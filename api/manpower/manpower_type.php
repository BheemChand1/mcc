<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

if (($_SERVER['REQUEST_METHOD'] ?? 'GET') === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once __DIR__ . '/../../connection.php';
global $pdo;

// Support both POST (JSON or urlencoded) and GET
$data = json_decode(file_get_contents("php://input"), true);
if (empty($data)) {
    $data = array_merge($_POST, $_GET);
}

$stationId  = isset($data['station_id']) ? intval($data['station_id']) : null;
$shiftId    = isset($data['shift_id']) ? intval($data['shift_id']) : null;
$categoryId = isset($data['category_id']) ? intval($data['category_id']) : null;
$reportDate = isset($data['date']) && !empty($data['date']) ? trim($data['date']) : date('Y-m-d');

if ($stationId === null || $stationId <= 0) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "station_id parameter is required and must be a valid positive integer."
    ]);
    exit();
}

if ($shiftId === null && $categoryId === null) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "Either shift_id or category_id parameter is required."
    ]);
    exit();
}

/**
 * Helper function to identify unskilled manpower roles
 */
function isUnskilledRole($roleName) {
    $r = strtolower(trim($roleName));
    if (strpos($r, 'supervisor') !== false || strpos($r, 'chi') !== false || strpos($r, 'officer') !== false) {
        return false;
    }
    if (strpos($r, 'unskilled') !== false || strpos($r, 'staff') !== false || strpos($r, 'safaiwala') !== false || strpos($r, 'safai') !== false || strpos($r, 'cleaner') !== false || strpos($r, 'labour') !== false || strpos($r, 'helper') !== false) {
        return true;
    }
    if (strpos($r, 'semi') !== false || (strpos($r, 'skilled') !== false && strpos($r, 'unskilled') === false)) {
        return false;
    }
    return true;
}

/**
 * Helper function to map category to scorecard table
 */
function getScorecardTableForCategory($categoryName) {
    $c = strtolower(trim($categoryName));
    if (strpos($c, 'normal') !== false) {
        return 'mcc_normal_scorecard_report';
    } elseif (strpos($c, 'intensive') !== false) {
        return 'mcc_intensive_scorecard_2_report';
    } elseif (strpos($c, 'prt') !== false || strpos($c, 'platform') !== false) {
        return 'mcc_prt_scorecard_report';
    } elseif (strpos($c, 'vande') !== false || strpos($c, 'vb') !== false) {
        return 'mcc_vb_scorecard_report';
    }
    return null;
}

/**
 * Helper function to get distinct coach count for a railway date (06:00 AM of $date to 07:00 AM of next day)
 */
function getRailwayDateCoachCount($pdo, $tableName, $stationId, $date) {
    static $coachCache = [];
    $cacheKey = "{$tableName}_{$stationId}_{$date}";
    if (isset($coachCache[$cacheKey])) {
        return $coachCache[$cacheKey];
    }

    $startDateTime = $date . ' 06:00:00';
    $nextDate = date('Y-m-d', strtotime($date . ' +1 day'));
    $endDateTime = $nextDate . ' 07:00:00';

    try {
        $stmt = $pdo->prepare("
            SELECT COUNT(DISTINCT token_id, coach_no) AS total_coaches
            FROM {$tableName}
            WHERE station_id = :station_id
              AND (
                  (created_at IS NOT NULL AND created_at >= :start_dt AND created_at <= :end_dt)
                  OR (created_at IS NULL AND report_date = :rep_date)
              )
        ");
        $stmt->execute([
            'station_id' => $stationId,
            'start_dt' => $startDateTime,
            'end_dt' => $endDateTime,
            'rep_date' => $date
        ]);
        $count = intval($stmt->fetchColumn() ?: 0);
    } catch (Exception $e) {
        $count = 0;
    }

    $coachCache[$cacheKey] = $count;
    return $count;
}

try {
    $targetMonthDate = date('Y-m-01', strtotime($reportDate));
    $nextDate = date('Y-m-d', strtotime($reportDate . ' +1 day'));

    // 1. Resolve Shift and Category details
    $shiftDetails = null;
    if ($shiftId !== null && $shiftId > 0) {
        $sStmt = $pdo->prepare("
            SELECT s.id AS shift_id, s.shift_name, s.category_id, c.category_name
            FROM mcc_manpower_shifts s
            JOIN mcc_manpower_categories c ON s.category_id = c.id
            WHERE s.id = :shift_id AND c.station_id = :station_id
        ");
        $sStmt->execute(['shift_id' => $shiftId, 'station_id' => $stationId]);
        $shiftDetails = $sStmt->fetch(PDO::FETCH_ASSOC);
        if ($shiftDetails) {
            $categoryId = intval($shiftDetails['category_id']);
        }
    }

    $categoryName = '';
    if ($categoryId !== null && $categoryId > 0) {
        $cStmt = $pdo->prepare("SELECT id, category_name FROM mcc_manpower_categories WHERE id = :cid AND station_id = :station_id");
        $cStmt->execute(['cid' => $categoryId, 'station_id' => $stationId]);
        $catRow = $cStmt->fetch(PDO::FETCH_ASSOC);
        if ($catRow) {
            $categoryName = $catRow['category_name'];
        }
    }

    // 2. Fetch coach count for this category on railway date
    $scorecardTable = getScorecardTableForCategory($categoryName);
    $isDynamicCategory = ($scorecardTable !== null);
    $coachesCleaned = $isDynamicCategory ? getRailwayDateCoachCount($pdo, $scorecardTable, $stationId, $reportDate) : 0;

    // 3. Fetch monthly target norms for this station & category
    $targetsMap = [];
    $targetsStmt = $pdo->prepare("
        SELECT category_id, manpower_type_id, target_qty 
        FROM mcc_manpower_targets 
        WHERE station_id = :station_id AND target_date = :target_date
    ");
    $targetsStmt->execute([
        'station_id' => $stationId,
        'target_date' => $targetMonthDate
    ]);
    foreach ($targetsStmt->fetchAll(PDO::FETCH_ASSOC) as $row) {
        $cId = intval($row['category_id']);
        $tId = intval($row['manpower_type_id']);
        $targetsMap[$cId][$tId] = floatval($row['target_qty']);
        if ($cId === 0) {
            $targetsMap[0][$tId] = floatval($row['target_qty']);
        }
    }

    // 4. Fetch existing daily log for this station, shift & date
    $existingLogs = [];
    if ($shiftId !== null) {
        $logStmt = $pdo->prepare("
            SELECT manpower_type_id, provided_qty, absent_qty, no_dress_qty, no_ppe_qty, auditor_name
            FROM mcc_manpower_log
            WHERE station_id = :station_id AND shift_id = :shift_id AND report_date = :report_date
        ");
        $logStmt->execute([
            'station_id' => $stationId,
            'shift_id' => $shiftId,
            'report_date' => $reportDate
        ]);
        foreach ($logStmt->fetchAll(PDO::FETCH_ASSOC) as $row) {
            $existingLogs[intval($row['manpower_type_id'])] = $row;
        }
    }

    // 5. Fetch mapped active manpower types
    if ($shiftId !== null) {
        $typesStmt = $pdo->prepare("
            SELECT t.id AS manpower_type_id, t.role_name, t.order_no
            FROM mcc_manpower_shift_type_map map
            JOIN mcc_manpower_types t ON map.manpower_type_id = t.id
            WHERE map.shift_id = :shift_id AND t.status = 'Active'
            ORDER BY t.order_no ASC, t.id ASC
        ");
        $typesStmt->execute(['shift_id' => $shiftId]);
    } else {
        $typesStmt = $pdo->prepare("
            SELECT DISTINCT t.id AS manpower_type_id, t.role_name, t.order_no
            FROM mcc_manpower_shift_type_map map
            JOIN mcc_manpower_shifts sh ON map.shift_id = sh.id
            JOIN mcc_manpower_types t ON map.manpower_type_id = t.id
            WHERE sh.category_id = :category_id AND sh.status = 'Active' AND t.status = 'Active'
            ORDER BY t.order_no ASC, t.id ASC
        ");
        $typesStmt->execute(['category_id' => $categoryId]);
    }

    $typesList = $typesStmt->fetchAll(PDO::FETCH_ASSOC);

    $manpowerTypes = [];
    foreach ($typesList as $type) {
        $typeId = intval($type['manpower_type_id']);
        $roleName = $type['role_name'];
        $isUnskilled = isUnskilledRole($roleName);

        $baseNorm = floatval($targetsMap[$categoryId][$typeId] ?? $targetsMap[0][$typeId] ?? 0.0);

        // Calculate dynamic target for unskilled, fixed for supervisor
        if ($isDynamicCategory && $isUnskilled) {
            $calculatedTarget = round($baseNorm * $coachesCleaned, 2);
        } else {
            $calculatedTarget = round($baseNorm, 2);
        }

        $logData = $existingLogs[$typeId] ?? null;
        $isLogged = ($logData !== null);

        $manpowerTypes[] = [
            "manpower_type_id"                 => $typeId,
            "role_name"                        => $roleName,
            "is_unskilled"                     => $isUnskilled,
            "base_norm"                        => $baseNorm,
            "target"                           => (floatval($calculatedTarget) == intval($calculatedTarget)) ? intval($calculatedTarget) : $calculatedTarget,
            "provided_qty"                     => isset($logData['provided_qty']) ? intval($logData['provided_qty']) : 0,
            "absent_qty"                       => isset($logData['absent_qty']) ? intval($logData['absent_qty']) : 0,
            "found_without_dress_and_id_cards" => isset($logData['no_dress_qty']) ? intval($logData['no_dress_qty']) : 0,
            "found_without_protective_gears"   => isset($logData['no_ppe_qty']) ? intval($logData['no_ppe_qty']) : 0,
            "no_dress_qty"                     => isset($logData['no_dress_qty']) ? intval($logData['no_dress_qty']) : 0,
            "no_ppe_qty"                       => isset($logData['no_ppe_qty']) ? intval($logData['no_ppe_qty']) : 0,
            "auditor_name"                     => $logData['auditor_name'] ?? null,
            "status"                           => $isLogged ? 1 : 0,
            "is_logged"                        => $isLogged
        ];
    }

    $isShiftFilled = !empty($existingLogs) ? 1 : 0;

    http_response_code(200);
    echo json_encode([
        "status"           => "success",
        "station_id"       => $stationId,
        "date"             => $reportDate,
        "railway_window"   => [
            "start" => $reportDate . " 06:00:00",
            "end"   => $nextDate . " 07:00:00"
        ],
        "category_id"      => $categoryId,
        "category_name"    => $categoryName,
        "shift_id"         => $shiftId,
        "shift_name"       => $shiftDetails['shift_name'] ?? null,
        "is_dynamic"       => $isDynamicCategory,
        "scorecard_table"  => $scorecardTable,
        "coaches_cleaned"  => $coachesCleaned,
        "shift_status"     => $isShiftFilled,
        "count"            => count($manpowerTypes),
        "manpower_types"   => $manpowerTypes
    ], JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status"  => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
