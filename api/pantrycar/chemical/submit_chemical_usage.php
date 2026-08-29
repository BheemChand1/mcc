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
$stationId = isset($data['station_id']) ? intval($data['station_id']) : null;

// Support both payload schemas: "values" array and legacy "parameters" array
$valuesList = $data['values'] ?? $data['parameters'] ?? null;

if (empty($tokenId) || empty($trainNo) || empty($coachNo) || empty($valuesList) || !is_array($valuesList)) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "Incomplete data. token_id, train_no, coach_no, and values (array) are required."
    ]);
    exit();
}

try {
    $pdo->beginTransaction();

    // Prepare update query
    if ($stationId !== null) {
        $stmt = $pdo->prepare("
            UPDATE mcc_intensive_pantry_chemical_report 
            SET qty_used = :qty_used
            WHERE token_id = :token_id 
              AND train_no = :train_no 
              AND coach_no = :coach_no 
              AND parameter_id = :parameter_id
              AND station_id = :station_id
        ");
    } else {
        $stmt = $pdo->prepare("
            UPDATE mcc_intensive_pantry_chemical_report 
            SET qty_used = :qty_used
            WHERE token_id = :token_id 
              AND train_no = :train_no 
              AND coach_no = :coach_no 
              AND parameter_id = :parameter_id
        ");
    }

    $updatedCount = 0;

    foreach ($valuesList as $item) {
        $paramId = $item['parameter_id'] ?? null;
        // Support both "value" key and legacy "qty_used" key
        $qtyUsed = isset($item['value']) ? floatval($item['value']) : (isset($item['qty_used']) ? floatval($item['qty_used']) : null);

        if ($paramId !== null && $qtyUsed !== null) {
            $binds = [
                'qty_used' => $qtyUsed,
                'token_id' => $tokenId,
                'train_no' => $trainNo,
                'coach_no' => $coachNo,
                'parameter_id' => $paramId
            ];
            if ($stationId !== null) {
                $binds['station_id'] = $stationId;
            }
            $stmt->execute($binds);
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
?>
