<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require_once __DIR__ . '/../../../connection.php';
global $pdo;

// Get posted data
$data = json_decode(file_get_contents("php://input"), true);
if (empty($data)) {
    $data = $_POST;
}

$tokenId        = $data['token_id'] ?? null;
$subParameterId = $data['sub_parameter_id'] ?? ($data['parameter_id'] ?? null);
$coachNo        = $data['coach_no'] ?? null;
$scoreValue     = $data['score_value'] ?? ($data['value'] ?? null);
$trainNo        = $data['train_no'] ?? null;

if (empty($subParameterId) || empty($coachNo) || $scoreValue === null) {
    http_response_code(400);
    echo json_encode([
        "status"  => "error",
        "message" => "Incomplete data. sub_parameter_id, coach_no, and score_value are required."
    ]);
    exit();
}

try {
    $whereClauses = ["sub_parameter_id = :sub_parameter_id", "coach_no = :coach_no"];
    $params = [
        'score_value'      => (string)$scoreValue,
        'sub_parameter_id' => $subParameterId,
        'coach_no'         => $coachNo
    ];

    if (!empty($tokenId)) {
        $whereClauses[] = "token_id = :token_id";
        $params['token_id'] = $tokenId;
    }
    if (!empty($trainNo)) {
        $whereClauses[] = "train_no = :train_no";
        $params['train_no'] = $trainNo;
    }

    $whereSql = implode(" AND ", $whereClauses);

    // Update the score value
    $updateStmt = $pdo->prepare("
        UPDATE mcc_intensive_pantry_report 
        SET score_value = :score_value
        WHERE $whereSql
    ");
    $updateStmt->execute($params);

    http_response_code(200);
    echo json_encode([
        "status"  => "success",
        "message" => "Pantry car score value updated successfully."
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status"  => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
