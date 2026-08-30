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

$tokenId = $data['token_id'] ?? null;
$subParameterId = $data['sub_parameter_id'] ?? null;
$coachNo = $data['coach_no'] ?? null;
$scoreValue = $data['score_value'] ?? null;

if (empty($tokenId) || empty($subParameterId) || empty($coachNo) || $scoreValue === null) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "Incomplete data. token_id, sub_parameter_id, coach_no, and score_value are required."
    ]);
    exit();
}

try {
    // Verify if the scorecard record exists in pantry report
    $checkStmt = $pdo->prepare("
        SELECT COUNT(*) FROM mcc_intensive_pantry_report 
        WHERE token_id = :token_id AND sub_parameter_id = :sub_parameter_id AND coach_no = :coach_no
    ");
    $checkStmt->execute([
        'token_id' => $tokenId,
        'sub_parameter_id' => $subParameterId,
        'coach_no' => $coachNo
    ]);

    if ($checkStmt->fetchColumn() == 0) {
        http_response_code(404);
        echo json_encode([
            "status" => "error",
            "message" => "Pantry car scorecard record not found for token_id: $tokenId, sub_parameter_id: $subParameterId, coach_no: $coachNo"
        ]);
        exit();
    }

    // Update the score value
    $updateStmt = $pdo->prepare("
        UPDATE mcc_intensive_pantry_report 
        SET score_value = :score_value
        WHERE token_id = :token_id AND sub_parameter_id = :sub_parameter_id AND coach_no = :coach_no
    ");
    $updateStmt->execute([
        'score_value' => $scoreValue,
        'token_id' => $tokenId,
        'sub_parameter_id' => $subParameterId,
        'coach_no' => $coachNo
    ]);

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "message" => "Pantry car score value updated successfully."
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
