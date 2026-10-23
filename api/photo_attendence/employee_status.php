<?php
/**
 * Fast & Lightweight API to check employee punch status (IN or OUT)
 * Endpoint: /api/photo_attendence/employee_status.php
 * Method: GET, POST
 * 
 * Parameters:
 *   - employee_id (required): String
 * 
 * Response:
 *   - IN (if latest record has no out_time)
 *   - OUT (if latest record has out_time or no attendance found)
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

$employeeId = isset($data['employee_id']) ? trim($data['employee_id']) : '';

if (empty($employeeId)) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "employee_id is required."
    ]);
    exit();
}

try {
    // Fetch latest attendance record for this employee
    $stmt = $pdo->prepare("
        SELECT id, station_id, employee_id, attendance_date, process, in_time, out_time 
        FROM mcc_photo_attendance 
        WHERE employee_id = :employee_id 
        ORDER BY id DESC 
        LIMIT 1
    ");
    $stmt->execute([':employee_id' => $employeeId]);
    $latest = $stmt->fetch(PDO::FETCH_ASSOC);

    // Determine in or out
    $empStatus = ($latest && !empty($latest['in_time']) && empty($latest['out_time'])) ? 'in' : 'out';

    echo json_encode([
        "status" => $empStatus
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
