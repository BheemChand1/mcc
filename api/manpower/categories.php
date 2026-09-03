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
    // 1. Fetch active categories for the station
    $stmt = $pdo->prepare("
        SELECT id, category_name, order_no 
        FROM mcc_manpower_categories 
        WHERE station_id = :station_id AND status = 'Active' 
        ORDER BY order_no ASC, id ASC
    ");
    $stmt->execute(['station_id' => $stationId]);
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // 2. Fetch filled category IDs for the given date from mcc_manpower_log
    $filledStmt = $pdo->prepare("
        SELECT DISTINCT s.category_id 
        FROM mcc_manpower_log l
        JOIN mcc_manpower_shifts s ON l.shift_id = s.id
        WHERE l.station_id = :station_id AND l.report_date = :report_date
    ");
    $filledStmt->execute([
        'station_id' => $stationId,
        'report_date' => $reportDate
    ]);
    $filledCategoryIds = $filledStmt->fetchAll(PDO::FETCH_COLUMN, 0);
    $filledMap = array_flip($filledCategoryIds);

    $categories = [];
    foreach ($rows as $row) {
        $cId = intval($row['id']);
        $isFilled = isset($filledMap[$cId]) ? 1 : 0;

        $categories[] = [
            "id"            => $cId,
            "category_id"   => $cId,
            "category_name" => $row['category_name'],
            "order_no"      => intval($row['order_no']),
            "status"        => $isFilled
        ];
    }

    http_response_code(200);
    echo json_encode([
        "status"     => "success",
        "station_id" => $stationId,
        "date"       => $reportDate,
        "count"      => count($categories),
        "categories" => $categories
    ], JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status"  => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
