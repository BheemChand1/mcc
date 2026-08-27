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

$tokenId = $data['token_id'] ?? null;
$trainNo = $data['train_no'] ?? null;
$coachNo = $data['coach_no'] ?? null;
$auditorName = $data['auditor_name'] ?? null;
$parameters = $data['parameters'] ?? null; // Expect array of {"parameter_id": X, "qty_used": Y}

if (empty($tokenId) || empty($trainNo) || empty($coachNo) || empty($auditorName) || empty($parameters) || !is_array($parameters)) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "Incomplete data. token_id, train_no, coach_no, auditor_name, and parameters (array) are required."
    ]);
    exit();
}

try {
    $pdo->beginTransaction();

    // Prepare update query
    $stmt = $pdo->prepare("
        UPDATE mcc_normal_chemical_report 
        SET qty_used = :qty_used, auditor_name = :auditor_name
        WHERE token_id = :token_id 
          AND train_no = :train_no 
          AND coach_no = :coach_no 
          AND parameter_id = :parameter_id
    ");

    $updatedCount = 0;

    foreach ($parameters as $paramItem) {
        $paramId = $paramItem['parameter_id'] ?? null;
        $qtyUsed = isset($paramItem['qty_used']) ? floatval($paramItem['qty_used']) : null;

        if ($paramId !== null && $qtyUsed !== null) {
            $stmt->execute([
                'qty_used' => $qtyUsed,
                'auditor_name' => $auditorName,
                'token_id' => $tokenId,
                'train_no' => $trainNo,
                'coach_no' => $coachNo,
                'parameter_id' => $paramId
            ]);
            $updatedCount += $stmt->rowCount();
        }
    }

    $pdo->commit();

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "message" => "Chemical usage values updated successfully.",
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
