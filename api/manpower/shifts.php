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

try {
    // 1. Fetch active shifts
    if ($categoryId !== null && $categoryId > 0) {
        $stmt = $pdo->prepare("
            SELECT s.id AS shift_id, s.shift_name, s.order_no, s.category_id, c.category_name
            FROM mcc_manpower_shifts s
            JOIN mcc_manpower_categories c ON s.category_id = c.id
            WHERE c.station_id = :station_id AND s.category_id = :category_id AND s.status = 'Active' AND c.status = 'Active'
            ORDER BY s.order_no ASC, s.id ASC
        ");
        $stmt->execute([
            'station_id' => $stationId,
            'category_id' => $categoryId
        ]);
    } else {
        $stmt = $pdo->prepare("
            SELECT s.id AS shift_id, s.shift_name, s.order_no, s.category_id, c.category_name
            FROM mcc_manpower_shifts s
            JOIN mcc_manpower_categories c ON s.category_id = c.id
            WHERE c.station_id = :station_id AND s.status = 'Active' AND c.status = 'Active'
            ORDER BY c.order_no ASC, s.order_no ASC, s.id ASC
        ");
        $stmt->execute(['station_id' => $stationId]);
    }

    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // 2. Fetch total active mapped manpower types for each shift
    $totalTypesStmt = $pdo->prepare("
        SELECT map.shift_id, COUNT(DISTINCT t.id) AS total_types
        FROM mcc_manpower_shift_type_map map
        JOIN mcc_manpower_types t ON map.manpower_type_id = t.id
        WHERE t.status = 'Active' AND map.station_id = :station_id
        GROUP BY map.shift_id
    ");
    $totalTypesStmt->execute(['station_id' => $stationId]);
    $totalTypesMap = $totalTypesStmt->fetchAll(PDO::FETCH_KEY_PAIR);

    // Fallback: total active manpower types for the station
    $fallbackTypesStmt = $pdo->prepare("
        SELECT COUNT(DISTINCT id) FROM mcc_manpower_types WHERE station_id = :station_id AND status = 'Active'
    ");
    $fallbackTypesStmt->execute(['station_id' => $stationId]);
    $defaultStationTypesCount = intval($fallbackTypesStmt->fetchColumn() ?: 0);

    // 3. Fetch count of submitted distinct manpower types per shift for the given date
    $filledStmt = $pdo->prepare("
        SELECT shift_id, COUNT(DISTINCT manpower_type_id) AS filled_types
        FROM mcc_manpower_log 
        WHERE station_id = :station_id AND report_date = :report_date
        GROUP BY shift_id
    ");
    $filledStmt->execute([
        'station_id' => $stationId,
        'report_date' => $reportDate
    ]);
    $filledCountsMap = $filledStmt->fetchAll(PDO::FETCH_KEY_PAIR);

    $shifts = [];
    foreach ($rows as $row) {
        $sId = intval($row['shift_id']);
        $requiredCount = isset($totalTypesMap[$sId]) ? intval($totalTypesMap[$sId]) : $defaultStationTypesCount;
        $filledCount   = isset($filledCountsMap[$sId]) ? intval($filledCountsMap[$sId]) : 0;
        $isFilled      = ($requiredCount > 0 && $filledCount >= $requiredCount) ? 1 : 0;

        $shifts[] = [
            "id"            => $sId,
            "shift_id"      => $sId,
            "shift_name"    => $row['shift_name'],
            "category_id"   => intval($row['category_id']),
            "category_name" => $row['category_name'],
            "order_no"      => intval($row['order_no']),
            "status"        => $isFilled,
            "filled_count"  => $filledCount,
            "total_count"   => $requiredCount
        ];
    }

    http_response_code(200);
    echo json_encode([
        "status"      => "success",
        "station_id"  => $stationId,
        "date"        => $reportDate,
        "category_id" => $categoryId,
        "count"       => count($shifts),
        "shifts"      => $shifts
    ], JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status"  => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
