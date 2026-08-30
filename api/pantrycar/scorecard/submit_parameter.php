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

$auditorName   = isset($data['auditor_name']) ? trim($data['auditor_name']) : (isset($data['submitted_by']) ? trim($data['submitted_by']) : null);
$trainNo       = isset($data['train_no']) ? trim($data['train_no']) : (isset($data['train_number']) ? trim($data['train_number']) : null);
$coachNo       = isset($data['coach_no']) ? trim($data['coach_no']) : null;
$tokenId       = isset($data['token_id']) ? trim($data['token_id']) : null;
$subParameters = $data['sub_parameters'] ?? ($data['parameters'] ?? null); // Expect array of {"sub_parameter_id": X, "value": Y}

if (empty($trainNo) || empty($coachNo) || empty($subParameters) || !is_array($subParameters)) {
    http_response_code(400);
    echo json_encode([
        "status"  => "error",
        "message" => "Incomplete data. train_no, coach_no, and sub_parameters (array) are required."
    ]);
    exit();
}

try {
    $pdo->beginTransaction();

    // Prepare update query in Pantry Car Scorecard
    $updateQuery = "
        UPDATE mcc_intensive_pantry_report 
        SET score_value = :score_value
    ";
    if (!empty($auditorName)) {
        $updateQuery .= ", auditor_name = :auditor_name";
    }
    $updateQuery .= " WHERE train_no = :train_no AND coach_no = :coach_no AND sub_parameter_id = :sub_parameter_id";
    if (!empty($tokenId)) {
        $updateQuery .= " AND token_id = :token_id";
    }

    $stmt = $pdo->prepare($updateQuery);
    $updatedCount = 0;

    foreach ($subParameters as $sub) {
        $subParamId = $sub['sub_parameter_id'] ?? ($sub['parameter_id'] ?? null);
        $val        = $sub['value'] ?? ($sub['score_value'] ?? null);

        if ($subParamId !== null) {
            $params = [
                'score_value'      => ($val !== null) ? (string)$val : '',
                'train_no'          => $trainNo,
                'coach_no'          => $coachNo,
                'sub_parameter_id' => $subParamId
            ];
            if (!empty($auditorName)) {
                $params['auditor_name'] = $auditorName;
            }
            if (!empty($tokenId)) {
                $params['token_id'] = $tokenId;
            }

            $stmt->execute($params);
            $updatedCount += $stmt->rowCount();
        }
    }

    $pdo->commit();

    http_response_code(200);
    echo json_encode([
        "status"       => "success",
        "message"      => "Pantry car scorecard values updated successfully.",
        "updated_rows" => $updatedCount
    ]);

} catch (Exception $e) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    http_response_code(500);
    echo json_encode([
        "status"  => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
