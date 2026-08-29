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
if (empty($data)) {
    $data = $_POST;
}

$auditorName = $data['auditor_name'] ?? null;
$shiftId = isset($data['shift_id']) ? intval($data['shift_id']) : null;
$stationId = isset($data['station_id']) ? intval($data['station_id']) : 1;
$reportDate = $data['date'] ?? date('Y-m-d');
$values = $data['values'] ?? null;

if (empty($auditorName) || $shiftId === null || empty($values) || !is_array($values)) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "Incomplete data. auditor_name, shift_id, and values (array) are required."
    ]);
    exit();
}

try {
    // 1. Check if token already exists for this station and date
    $tokenStmt = $pdo->prepare("
        SELECT DISTINCT token_id 
        FROM dc_mcc_report 
        WHERE station_id = :station_id AND report_date = :report_date
        LIMIT 1
    ");
    $tokenStmt->execute([
        'station_id' => $stationId,
        'report_date' => $reportDate
    ]);
    $existingToken = $tokenStmt->fetchColumn();

    if ($existingToken) {
        $tokenId = $existingToken;
    } else {
        // Generate a new unique token
        $datePart = date('Ymd', strtotime($reportDate));
        $randPart = sprintf("%03d", rand(1, 999));
        $tokenId = "TKN-DC-" . $datePart . "-" . $randPart;

        $checkStmt = $pdo->prepare("SELECT COUNT(*) FROM dc_mcc_report WHERE token_id = ?");
        $checkStmt->execute([$tokenId]);
        while ($checkStmt->fetchColumn() > 0) {
            $randPart = sprintf("%03d", rand(1, 999));
            $tokenId = "TKN-DC-" . $datePart . "-" . $randPart;
            $checkStmt->execute([$tokenId]);
        }
    }

    $pdo->beginTransaction();

    $checkRowStmt = $pdo->prepare("
        SELECT id FROM dc_mcc_report 
        WHERE token_id = :token_id 
          AND parameter_id = :parameter_id 
          AND shift_id = :shift_id 
          AND station_id = :station_id
    ");

    $updateRowStmt = $pdo->prepare("
        UPDATE dc_mcc_report 
        SET rating = :rating, auditor_name = :auditor_name 
        WHERE id = :id
    ");

    $insertRowStmt = $pdo->prepare("
        INSERT INTO dc_mcc_report 
        (parameter_id, shift_id, rating, token_id, station_id, report_date, auditor_name) 
        VALUES (:parameter_id, :shift_id, :rating, :token_id, :station_id, :report_date, :auditor_name)
    ");

    foreach ($values as $val) {
        $parameterId = intval($val['parameter_id']);
        $rating = $val['value']; // could be numeric rating, e.g. "3"

        // Check if row already exists
        $checkRowStmt->execute([
            'token_id' => $tokenId,
            'parameter_id' => $parameterId,
            'shift_id' => $shiftId,
            'station_id' => $stationId
        ]);
        $rowId = $checkRowStmt->fetchColumn();

        if ($rowId) {
            // Update
            $updateRowStmt->execute([
                'rating' => $rating,
                'auditor_name' => $auditorName,
                'id' => $rowId
            ]);
        } else {
            // Insert
            $insertRowStmt->execute([
                'parameter_id' => $parameterId,
                'shift_id' => $shiftId,
                'rating' => $rating,
                'token_id' => $tokenId,
                'station_id' => $stationId,
                'report_date' => $reportDate,
                'auditor_name' => $auditorName
            ]);
        }
    }

    $pdo->commit();

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "message" => "Parameters submitted successfully.",
        "token_id" => $tokenId
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
