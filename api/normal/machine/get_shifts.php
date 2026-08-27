<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require_once '../../../connection.php';
global $pdo;

// Support both POST (JSON or urlencoded) and GET
$data = json_decode(file_get_contents("php://input"), true);
if (empty($data)) {
    $data = array_merge($_POST, $_GET);
}

$stationId = isset($data['station_id']) ? intval($data['station_id']) : null;

if ($stationId === null || $stationId <= 0) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "station_id parameter is required and must be a valid positive integer."
    ]);
    exit();
}

try {
    $stmt = $pdo->prepare("
        SELECT id AS shift_id, shift AS shift_name 
        FROM mcc_normal_machine_shifts 
        WHERE station_id = :station_id
        ORDER BY id ASC
    ");
    $stmt->execute(['station_id' => $stationId]);
    $shifts = $stmt->fetchAll(PDO::FETCH_ASSOC);

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "station_id" => $stationId,
        "shifts" => $shifts
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
