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

$auditorName = $data['auditor_name'] ?? ($data['submitted_by'] ?? null);
$trainNo = $data['train_no'] ?? null;
$coachNo = $data['coach_no'] ?? null;
$tokenId = $data['token_id'] ?? null;
$subParameters = $data['sub_parameters'] ?? null; // Expect array of {"sub_parameter_id": X, "value": Y}

if (empty($auditorName) || empty($trainNo) || empty($coachNo) || empty($tokenId) || empty($subParameters) || !is_array($subParameters)) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "Incomplete data. auditor_name, train_no, coach_no, token_id, and sub_parameters (array) are required."
    ]);
    exit();
}

try {
    $pdo->beginTransaction();

    // Prepare update query in Pantry Car Scorecard
    $stmt = $pdo->prepare("
        UPDATE mcc_intensive_pantry_report 
        SET score_value = :score_value, submitted_by = :submitted_by
        WHERE token_id = :token_id 
          AND train_no = :train_no 
          AND coach_no = :coach_no 
          AND sub_parameter_id = :sub_parameter_id
    ");

    $updatedCount = 0;

    foreach ($subParameters as $sub) {
        $subParamId = $sub['sub_parameter_id'] ?? null;
        $val = $sub['value'] ?? null;

        if ($subParamId !== null) {
            $stmt->execute([
                'score_value' => $val,
                'submitted_by' => $auditorName,
                'token_id' => $tokenId,
                'train_no' => $trainNo,
                'coach_no' => $coachNo,
                'sub_parameter_id' => $subParamId
            ]);
            $updatedCount += $stmt->rowCount();
        }
    }

    $pdo->commit();

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "message" => "Pantry car scorecard values updated successfully.",
        "updated_rows" => $updatedCount
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
