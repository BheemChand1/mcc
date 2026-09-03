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

    // 2. Fetch filled shift IDs for the given date from mcc_manpower_log
    $filledStmt = $pdo->prepare("
        SELECT DISTINCT shift_id 
        FROM mcc_manpower_log 
        WHERE station_id = :station_id AND report_date = :report_date
    ");
    $filledStmt->execute([
        'station_id' => $stationId,
        'report_date' => $reportDate
    ]);
    $filledShiftIds = $filledStmt->fetchAll(PDO::FETCH_COLUMN, 0);
    $filledMap = array_flip($filledShiftIds);

    $shifts = [];
    foreach ($rows as $row) {
        $sId = intval($row['shift_id']);
        $isFilled = isset($filledMap[$sId]) ? 1 : 0;

        $shifts[] = [
            "id"            => $sId,
            "shift_id"      => $sId,
            "shift_name"    => $row['shift_name'],
            "category_id"   => intval($row['category_id']),
            "category_name" => $row['category_name'],
            "order_no"      => intval($row['order_no']),
            "status"        => $isFilled
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
