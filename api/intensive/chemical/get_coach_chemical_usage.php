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

$tokenId = isset($data['token_id']) ? trim($data['token_id']) : null;
$trainNo = isset($data['train_no']) ? trim($data['train_no']) : null;
$coachNo = isset($data['coach_no']) ? trim($data['coach_no']) : null;

if (empty($tokenId) || empty($trainNo) || empty($coachNo)) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "token_id, train_no, and coach_no are required parameters."
    ]);
    exit();
}

try {
    // 1. Get token metadata (station_id, report_date, auditor_name) - Intensive
    $metaStmt = $pdo->prepare("
        SELECT DISTINCT station_id, report_date, auditor_name 
        FROM mcc_intensive_chemical_report
        WHERE token_id = :token_id AND train_no = :train_no AND coach_no = :coach_no
        LIMIT 1
    ");
    $metaStmt->execute([
        'token_id' => $tokenId,
        'train_no' => $trainNo,
        'coach_no' => $coachNo
    ]);
    $meta = $metaStmt->fetch(PDO::FETCH_ASSOC);

    if (empty($meta)) {
        http_response_code(404);
        echo json_encode([
            "status" => "error",
            "message" => "No chemical report records found for the specified token, train, and coach."
        ]);
        exit();
    }

    $stationId = intval($meta['station_id']);
    $reportDate = $meta['report_date'];
    $auditorName = $meta['auditor_name'];

    // 2. Fetch active chemical parameters for the station - Intensive
    $paramsStmt = $pdo->prepare("
        SELECT id AS parameter_id, name AS parameter_name, units 
        FROM mcc_intensive_chemical_param
        WHERE station_id = :station_id
        ORDER BY id ASC
    ");
    $paramsStmt->execute(['station_id' => $stationId]);
    $parametersList = $paramsStmt->fetchAll(PDO::FETCH_ASSOC);

    // 3. Fetch targets active on this report date (SCD Type 2 unique bindings to prevent HY093) - Intensive
    $targetStmt = $pdo->prepare("
        SELECT t.parameter_id, t.`qty(ml)` AS qty_ml
        FROM mcc_intensive_chemical_target t
        WHERE t.station_id = :station_id
          AND :report_date_1 >= t.effective_from 
          AND (t.effective_to IS NULL OR :report_date_2 <= t.effective_to)
    ");
    $targetStmt->execute([
        'station_id' => $stationId,
        'report_date_1' => $reportDate,
        'report_date_2' => $reportDate
    ]);
    $targetsRaw = $targetStmt->fetchAll(PDO::FETCH_ASSOC);
    $targets = [];
    foreach ($targetsRaw as $tr) {
        $targets[$tr['parameter_id']] = $tr;
    }

    // 4. Fetch currently saved quantities - Intensive
    $savedStmt = $pdo->prepare("
        SELECT parameter_id, qty_used 
        FROM mcc_intensive_chemical_report
        WHERE token_id = :token_id AND train_no = :train_no AND coach_no = :coach_no
    ");
    $savedStmt->execute([
        'token_id' => $tokenId,
        'train_no' => $trainNo,
        'coach_no' => $coachNo
    ]);
    $savedRaw = $savedStmt->fetchAll(PDO::FETCH_ASSOC);
    $savedQty = [];
    foreach ($savedRaw as $sr) {
        $savedQty[$sr['parameter_id']] = floatval($sr['qty_used']);
    }

    // 5. Assemble parameters output
    $parameters = [];
    foreach ($parametersList as $p) {
        $pId = $p['parameter_id'];
        $parameters[] = [
            "parameter_id" => $pId,
            "parameter_name" => $p['parameter_name'],
            "units" => $p['units'] ?: 'ml',
            "target_qty" => isset($targets[$pId]['qty_ml']) ? floatval($targets[$pId]['qty_ml']) : 0.00,
            "qty_used" => $savedQty[$pId] ?? 0.00
        ];
    }

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "meta" => [
            "token_id" => $tokenId,
            "train_no" => $trainNo,
            "coach_no" => $coachNo,
            "report_date" => $reportDate,
            "auditor_name" => $auditorName
        ],
        "parameters" => $parameters
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
