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
$reportDate = isset($data['date']) ? trim($data['date']) : date('Y-m-d');

if ($stationId === null || $stationId <= 0) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "station_id parameter is required and must be a valid positive integer."
    ]);
    exit();
}

try {
    // 1. Fetch total parameters count for the station
    $paramStmt = $pdo->prepare("SELECT COUNT(*) FROM dc_mcc_param WHERE station_id = :station_id");
    $paramStmt->execute(['station_id' => $stationId]);
    $totalParams = intval($paramStmt->fetchColumn());

    // 2. Fetch shifts for the station
    $shiftsStmt = $pdo->prepare("
        SELECT id AS shift_id, shift AS shift_name 
        FROM dc_mcc_shifts 
        WHERE station_id = :station_id
        ORDER BY id ASC
    ");
    $shiftsStmt->execute(['station_id' => $stationId]);
    $shifts = $shiftsStmt->fetchAll(PDO::FETCH_ASSOC);

    // Calculate start time and end time for the shifts: 7 AM yesterday to 6 AM today
    $startTime = date('Y-m-d', strtotime($reportDate . ' -1 day')) . ' 07:00:00';
    $endTime = $reportDate . ' 06:00:00';

    // 3. Fetch filled count per shift for the given date range (yesterday 7 AM to today 6 AM)
    $filledStmt = $pdo->prepare("
        SELECT shift_id, COUNT(*) AS filled_count 
        FROM dc_mcc_report 
        WHERE station_id = :station_id 
          AND created_at >= :start_time 
          AND created_at <= :end_time 
          AND rating IS NOT NULL
        GROUP BY shift_id
    ");
    $filledStmt->execute([
        'station_id' => $stationId,
        'start_time' => $startTime,
        'end_time' => $endTime
    ]);
    $filledRows = $filledStmt->fetchAll(PDO::FETCH_ASSOC);

    $filledByShift = [];
    foreach ($filledRows as $row) {
        $filledByShift[intval($row['shift_id'])] = intval($row['filled_count']);
    }

    // 4. Determine status (1 if at least one parameter is filled, else 0)
    $updatedShifts = [];
    foreach ($shifts as $s) {
        $sId = intval($s['shift_id']);
        $filledCount = $filledByShift[$sId] ?? 0;
        
        // If one or more parameters are available, status is 1. Otherwise 0.
        $status = ($filledCount > 0) ? 1 : 0;
        
        $s['status'] = $status;
        $updatedShifts[] = $s;
    }

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "station_id" => $stationId,
        "date" => $reportDate,
        "shifts" => $updatedShifts
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
?>
