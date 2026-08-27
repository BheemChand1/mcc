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
$shiftId = isset($data['shift_id']) ? intval($data['shift_id']) : null;
$reportDate = isset($data['date']) ? trim($data['date']) : date('Y-m-d');

if ($stationId === null || $stationId <= 0 || $shiftId === null || $shiftId <= 0) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "station_id and shift_id are required parameters and must be positive integers."
    ]);
    exit();
}

try {
    // 1. Fetch active targets/nominations for this station, shift and date (SCD Type 2 range query with HY093 safety)
    $targetStmt = $pdo->prepare("
        SELECT machine_id 
        FROM mcc_normal_machine_target 
        WHERE station_id = :station_id 
          AND shift_id = :shift_id
          AND nominated_area = 'Y'
          AND :date_ref_1 >= effective_from
          AND (effective_to IS NULL OR :date_ref_2 <= effective_to)
    ");
    $targetStmt->execute([
        'station_id' => $stationId,
        'shift_id' => $shiftId,
        'date_ref_1' => $reportDate,
        'date_ref_2' => $reportDate
    ]);
    $nominatedMachineIds = $targetStmt->fetchAll(PDO::FETCH_COLUMN);
    $totalNominated = count($nominatedMachineIds);

    // 2. Fetch existing report records for this date and shift
    $reportStmt = $pdo->prepare("
        SELECT parameter_id AS machine_id, used_status, token_id 
        FROM mcc_normal_machine_report 
        WHERE station_id = :station_id 
          AND shift_id = :shift_id 
          AND report_date = :report_date
    ");
    $reportStmt->execute([
        'station_id' => $stationId,
        'shift_id' => $shiftId,
        'report_date' => $reportDate
    ]);
    $reportRows = $reportStmt->fetchAll(PDO::FETCH_ASSOC);

    $filledMachineIds = [];
    $tokenId = null;
    foreach ($reportRows as $r) {
        // A machine is considered filled if used_status is recorded (Y, N, etc. and not empty/null)
        if ($r['used_status'] !== null && $r['used_status'] !== '' && $r['used_status'] !== '-') {
            $filledMachineIds[] = intval($r['machine_id']);
        }
        if (empty($tokenId)) {
            $tokenId = $r['token_id'];
        }
    }

    $totalFilled = 0;
    if ($totalNominated > 0) {
        foreach ($nominatedMachineIds as $nomId) {
            if (in_array(intval($nomId), $filledMachineIds)) {
                $totalFilled++;
            }
        }
        // Status = 1 (completed) if all nominated machines are filled
        $status = ($totalFilled === $totalNominated) ? 1 : 0;
    } else {
        // If there are no nominated machines, check if at least some entries exist
        $status = !empty($reportRows) ? 1 : 0;
        $totalFilled = count($reportRows);
    }

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "meta" => [
            "station_id" => $stationId,
            "shift_id" => $shiftId,
            "date" => $reportDate,
            "token_id" => $tokenId
        ],
        "shift_status" => $status, // 1 = Complete, 0 = Incomplete
        "total_nominated" => $totalNominated,
        "total_filled" => $totalFilled
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
