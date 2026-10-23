<?php
/**
 * Fast & Lightweight API to fetch employees for Photo Attendance
 * Endpoint: /api/photo_attendence/get_employees.php
 * Method: GET, POST
 * 
 * Parameters:
 *   - station_id (required): Integer
 * 
 * Response:
 *   - employee_id, full_name, designation
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
    // Fast direct query for only required columns
    $stmt = $pdo->prepare("
        SELECT employee_id, full_name, designation 
        FROM mcc_employee 
        WHERE station_id = :station_id
        ORDER BY full_name ASC
    ");
    $stmt->execute([':station_id' => $stationId]);
    $employees = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
        "status" => "success",
        "count" => count($employees),
        "data" => $employees,
        "employees" => $employees
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
