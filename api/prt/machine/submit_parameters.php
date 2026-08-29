<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require_once '../../../connection.php';
global $pdo;

// Get posted data
$data = json_decode(file_get_contents("php://input"), true);

// If JSON decoding fails, try standard $_POST
if (empty($data)) {
    $data = $_POST;
}

$stationId = isset($data['station_id']) ? intval($data['station_id']) : null;
$shiftId = isset($data['shift_id']) ? intval($data['shift_id']) : null;
$reportDate = $data['date'] ?? null;
$tokenId = $data['token_id'] ?? null;

if (empty($reportDate)) {
    // Attempt to extract YYYYMMDD date from token_id
    if (!empty($tokenId) && preg_match('/(\d{4})(\d{2})(\d{2})/', $tokenId, $matches)) {
        $reportDate = $matches[1] . '-' . $matches[2] . '-' . $matches[3];
    } else {
        $reportDate = date('Y-m-d');
    }
}

$auditorName = $data['auditor_name'] ?? $data['submitted_by'] ?? null;
$valuesList = $data['values'] ?? $data['parameters'] ?? null; // Support both values and parameters

if (empty($stationId) || empty($shiftId) || empty($reportDate) || empty($valuesList) || !is_array($valuesList)) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "Incomplete data. station_id, shift_id, and values (array) are required."
    ]);
    exit();
}

// Generate token_id if not supplied
if (empty($tokenId)) {
    $tokenId = 'TKN-PRT-MCH-' . date('Ymd', strtotime($reportDate)) . '-' . $shiftId . '-' . rand(1000, 9999);
}

try {
    $pdo->beginTransaction();

    // Prepare statements - PRT
    $checkStmt = $pdo->prepare("
        SELECT id FROM mcc_prt_machine_report 
        WHERE station_id = :station_id 
          AND shift_id = :shift_id 
          AND report_date = :report_date 
          AND parameter_id = :parameter_id
        LIMIT 1
    ");

    $updateStmt = $pdo->prepare("
        UPDATE mcc_prt_machine_report 
        SET used_status = :used_status, token_id = :token_id, auditor_name = :auditor_name
        WHERE id = :id
    ");

    $insertStmt = $pdo->prepare("
        INSERT INTO mcc_prt_machine_report 
        (parameter_id, shift_id, used_status, token_id, auditor_name, station_id, report_date)
        VALUES (:parameter_id, :shift_id, :used_status, :token_id, :auditor_name, :station_id, :report_date)
    ");

    $upsertCount = 0;

    foreach ($valuesList as $item) {
        $machineId = $item['machine_id'] ?? $item['parameter_id'] ?? null;
        // Accept both "operated" key and "value" key
        $operated = isset($item['operated']) ? trim($item['operated']) : (isset($item['value']) ? trim($item['value']) : null);

        if ($machineId !== null && $operated !== null) {
            // Check if record already exists
            $checkStmt->execute([
                'station_id' => $stationId,
                'shift_id' => $shiftId,
                'report_date' => $reportDate,
                'parameter_id' => $machineId
            ]);
            $existing = $checkStmt->fetch(PDO::FETCH_ASSOC);

            if ($existing) {
                // Update
                $updateStmt->execute([
                    'used_status' => $operated,
                    'token_id' => $tokenId,
                    'auditor_name' => $auditorName,
                    'id' => $existing['id']
                ]);
            } else {
                // Insert
                $insertStmt->execute([
                    'parameter_id' => $machineId,
                    'shift_id' => $shiftId,
                    'used_status' => $operated,
                    'token_id' => $tokenId,
                    'auditor_name' => $auditorName,
                    'station_id' => $stationId,
                    'report_date' => $reportDate
                ]);
            }
            $upsertCount++;
        }
    }

    $pdo->commit();

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "message" => "Machine report parameters submitted successfully.",
        "token_id" => $tokenId,
        "records_processed" => $upsertCount
    ]);

} catch (Exception $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
?>
