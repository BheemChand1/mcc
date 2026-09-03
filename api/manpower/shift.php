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

$stationId = isset($data['station_id']) ? intval($data['station_id']) : null;
$reportDate = isset($data['date']) && !empty($data['date']) ? trim($data['date']) : date('Y-m-d');

if ($stationId === null || $stationId <= 0) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "station_id parameter is required and must be a valid positive integer."
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

    // 1. Fetch monthly target norms for this station
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
    $targetsRows = $targetsStmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($targetsRows as $row) {
        $cId = intval($row['category_id']);
        $tId = intval($row['manpower_type_id']);
        $targetsMap[$cId][$tId] = floatval($row['target_qty']);
        if ($cId === 0) {
            $targetsMap[0][$tId] = floatval($row['target_qty']);
        }
    }

    // 2. Fetch existing daily logs for this station and date
    $logsMap = [];
    $logStmt = $pdo->prepare("
        SELECT shift_id, manpower_type_id, provided_qty, absent_qty, no_dress_qty, no_ppe_qty, chi_signature
        FROM mcc_manpower_log
        WHERE station_id = :station_id AND report_date = :report_date
    ");
    $logStmt->execute([
        'station_id' => $stationId,
        'report_date' => $reportDate
    ]);
    $logRows = $logStmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($logRows as $row) {
        $sId = intval($row['shift_id']);
        $tId = intval($row['manpower_type_id']);
        $logsMap[$sId][$tId] = [
            'provided_qty' => intval($row['provided_qty']),
            'absent_qty' => intval($row['absent_qty']),
            'no_dress_qty' => intval($row['no_dress_qty']),
            'no_ppe_qty' => intval($row['no_ppe_qty']),
            'chi_signature' => $row['chi_signature']
        ];
    }

    // 3. Fetch active categories for the station
    $catStmt = $pdo->prepare("
        SELECT id, category_name, order_no 
        FROM mcc_manpower_categories 
        WHERE station_id = :station_id AND status = 'Active' 
        ORDER BY order_no ASC, id ASC
    ");
    $catStmt->execute(['station_id' => $stationId]);
    $catList = $catStmt->fetchAll(PDO::FETCH_ASSOC);

    $categoriesResponse = [];
    $flatShiftsResponse = [];

    foreach ($catList as $cat) {
        $categoryId = intval($cat['id']);
        $categoryName = $cat['category_name'];

        // Determine scorecard table & count coaches on this railway date
        $scorecardTable = getScorecardTableForCategory($categoryName);
        $isDynamicCategory = ($scorecardTable !== null);
        $coachesCleaned = $isDynamicCategory ? getRailwayDateCoachCount($pdo, $scorecardTable, $stationId, $reportDate) : 0;

        // Fetch shifts for this category
        $shiftStmt = $pdo->prepare("
            SELECT id, shift_name, order_no 
            FROM mcc_manpower_shifts 
            WHERE category_id = :category_id AND status = 'Active' 
            ORDER BY order_no ASC, id ASC
        ");
        $shiftStmt->execute(['category_id' => $categoryId]);
        $shiftsList = $shiftStmt->fetchAll(PDO::FETCH_ASSOC);

        $categoryShifts = [];

        foreach ($shiftsList as $sh) {
            $shiftId = intval($sh['id']);
            $shiftName = $sh['shift_name'];

            // Fetch mapped manpower types for this shift
            $typesStmt = $pdo->prepare("
                SELECT t.id AS manpower_type_id, t.role_name, t.order_no
                FROM mcc_manpower_shift_type_map map
                JOIN mcc_manpower_types t ON map.manpower_type_id = t.id
                WHERE map.shift_id = :shift_id AND t.status = 'Active'
                ORDER BY t.order_no ASC, t.id ASC
            ");
            $typesStmt->execute(['shift_id' => $shiftId]);
            $typesList = $typesStmt->fetchAll(PDO::FETCH_ASSOC);

            $manpowerTypes = [];
            $shiftIsSubmitted = false;

            foreach ($typesList as $type) {
                $typeId = intval($type['manpower_type_id']);
                $roleName = $type['role_name'];
                $isUnskilled = isUnskilledRole($roleName);

                $baseTarget = floatval($targetsMap[$categoryId][$typeId] ?? $targetsMap[0][$typeId] ?? 0.0);

                // Multiply by coach count for unskilled roles in dynamic categories
                if ($isDynamicCategory && $isUnskilled) {
                    $dynamicTarget = round($baseTarget * $coachesCleaned, 2);
                } else {
                    $dynamicTarget = round($baseTarget, 2);
                }

                // Existing log values if already logged
                $logData = $logsMap[$shiftId][$typeId] ?? null;
                if ($logData !== null) {
                    $shiftIsSubmitted = true;
                }

                $manpowerTypes[] = [
                    "manpower_type_id" => $typeId,
                    "role_name"        => $roleName,
                    "is_unskilled"     => $isUnskilled,
                    "base_norm"        => $baseTarget,
                    "dynamic_target"   => (floatval($dynamicTarget) == intval($dynamicTarget)) ? intval($dynamicTarget) : $dynamicTarget,
                    "provided_qty"     => $logData['provided_qty'] ?? 0,
                    "absent_qty"       => $logData['absent_qty'] ?? 0,
                    "no_dress_qty"     => $logData['no_dress_qty'] ?? 0,
                    "no_ppe_qty"       => $logData['no_ppe_qty'] ?? 0,
                    "chi_signature"    => $logData['chi_signature'] ?? null,
                    "is_logged"        => ($logData !== null)
                ];
            }

            $shiftItem = [
                "shift_id"          => $shiftId,
                "shift_name"        => $shiftName,
                "category_id"       => $categoryId,
                "category_name"     => $categoryName,
                "is_dynamic"        => $isDynamicCategory,
                "scorecard_table"   => $scorecardTable,
                "coaches_cleaned"   => $coachesCleaned,
                "is_submitted"      => $shiftIsSubmitted,
                "manpower_types"    => $manpowerTypes
            ];

            $categoryShifts[] = $shiftItem;
            $flatShiftsResponse[] = $shiftItem;
        }

        $categoriesResponse[] = [
            "category_id"       => $categoryId,
            "category_name"     => $categoryName,
            "order_no"          => intval($cat['order_no']),
            "is_dynamic"        => $isDynamicCategory,
            "scorecard_table"   => $scorecardTable,
            "coaches_cleaned"   => $coachesCleaned,
            "shifts"            => $categoryShifts
        ];
    }

    http_response_code(200);
    echo json_encode([
        "status"            => "success",
        "station_id"        => $stationId,
        "date"              => $reportDate,
        "railway_window"    => [
            "start" => $reportDate . " 06:00:00",
            "end"   => $nextDate . " 07:00:00"
        ],
        "categories"        => $categoriesResponse,
        "shifts"            => $flatShiftsResponse
    ], JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status"  => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
