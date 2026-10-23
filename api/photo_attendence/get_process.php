<?php
/**
 * Fast & Lightweight API to fetch process names for Photo Attendance
 * Endpoint: /api/photo_attendence/get_process.php
 * Method: GET, POST
 * 
 * Parameters:
 *   - station_id (required): Integer
 * 
 * Response:
 *   - process_name list from photo_attendace_proccess
 */

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

// Handle preflight OPTIONS request
if (isset($_SERVER['REQUEST_METHOD']) && $_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

require_once __DIR__ . '/../../connection.php';
global $pdo;

// Support JSON body, POST and GET data
$data = json_decode(file_get_contents("php://input"), true);
if (empty($data)) {
    $data = array_merge($_POST, $_GET);
}

$stationId = isset($data['station_id']) ? intval($data['station_id']) : 0;

if ($stationId <= 0) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "station_id is required."
    ]);
    exit();
}

try {
    $stmt = $pdo->prepare("
        SELECT process_name 
        FROM photo_attendace_proccess 
        WHERE station_id = :station_id AND status = 'Active'
        ORDER BY id ASC
    ");
    $stmt->execute([':station_id' => $stationId]);
    $processes = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
        "status" => "success",
        "data" => $processes
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
