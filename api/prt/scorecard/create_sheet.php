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

$auditorName = $data['auditor_name'] ?? null;
$trainNo = $data['train_no'] ?? null;
$stationId = isset($data['station_id']) ? intval($data['station_id']) : 1;
$reportDate = date('Y-m-d');
$coachNos = $data['coach_nos'] ?? null; // Expect array of coach numbers or comma-separated string

if (empty($auditorName) || empty($trainNo) || empty($coachNos)) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "Incomplete data. auditor_name, train_no, and coach_nos are required."
    ]);
    exit();
}

// Convert coachNos to array if sent as comma-separated string
if (!is_array($coachNos)) {
    $coachNos = array_filter(array_map('trim', explode(',', $coachNos)));
}

try {
    // 1. Fetch active parameters and subparameters - PRT
    $paramsStmt = $pdo->prepare("
        SELECT sp.id AS sub_parameter_id
        FROM mcc_prt_scorecard_param p
        JOIN mcc_prt_scorecard_sub_param sp ON p.id = sp.parameter_id
        WHERE p.station_id = ? AND sp.station_id = ? 
          AND p.status = 'Active' AND sp.status = 'Active'
        ORDER BY p.id ASC, sp.id ASC
    ");
    $paramsStmt->execute([$stationId, $stationId]);
    $subParams = $paramsStmt->fetchAll(PDO::FETCH_COLUMN);

    // Fetch chemical parameters for the station - PRT
    $chemParamsStmt = $pdo->prepare("SELECT id FROM mcc_prt_chemical_param WHERE station_id = :station_id");
    $chemParamsStmt->execute(['station_id' => $stationId]);
    $chemParams = $chemParamsStmt->fetchAll(PDO::FETCH_COLUMN);

    if (empty($subParams)) {
        http_response_code(400);
        echo json_encode([
            "status" => "error",
            "message" => "No active scorecard parameters found for station_id " . $stationId
        ]);
        exit();
    }

    // 2. Generate unique token_id
    $datePart = date('Ymd', strtotime($reportDate));
    $randPart = sprintf("%03d", rand(1, 999));
    $tokenId = "TKN-PRT-" . $datePart . "-" . $randPart;

    // Verify uniqueness of generated token
    $checkStmt = $pdo->prepare("SELECT COUNT(*) FROM mcc_prt_scorecard_report WHERE token_id = ?");
    $checkStmt->execute([$tokenId]);
    while ($checkStmt->fetchColumn() > 0) {
        $randPart = sprintf("%03d", rand(1, 999));
        $tokenId = "TKN-PRT-" . $datePart . "-" . $randPart;
        $checkStmt->execute([$tokenId]);
    }

    // 3. Insert initial scorecard records (PRT score_value is NOT NULL, so init with '')
    $pdo->beginTransaction();

    $insertStmt = $pdo->prepare("
        INSERT INTO mcc_prt_scorecard_report 
        (sub_parameter_id, station_id, token_id, train_no, coach_no, score_value, auditor_name, report_date)
        VALUES (:sub_parameter_id, :station_id, :token_id, :train_no, :coach_no, '', :auditor_name, :report_date)
    ");

    foreach ($coachNos as $coachNo) {
        foreach ($subParams as $subParamId) {
            $insertStmt->execute([
                'sub_parameter_id' => $subParamId,
                'station_id' => $stationId,
                'token_id' => $tokenId,
                'train_no' => $trainNo,
                'coach_no' => trim($coachNo),
                'auditor_name' => $auditorName,
                'report_date' => $reportDate
            ]);
        }
    }

    // 4. Insert initial chemical report records
    if (!empty($chemParams)) {
        $insertChemStmt = $pdo->prepare("
            INSERT INTO mcc_prt_chemical_report 
            (parameter_id, coach_no, qty_used, auditor_name, station_id, token_id, train_no, report_date)
            VALUES (:parameter_id, :coach_no, NULL, :auditor_name, :station_id, :token_id, :train_no, :report_date)
        ");

        foreach ($coachNos as $coachNo) {
            foreach ($chemParams as $paramId) {
                $insertChemStmt->execute([
                    'parameter_id' => $paramId,
                    'coach_no' => trim($coachNo),
                    'auditor_name' => $auditorName,
                    'station_id' => $stationId,
                    'token_id' => $tokenId,
                    'train_no' => $trainNo,
                    'report_date' => $reportDate
                ]);
            }
        }
    }

    $pdo->commit();

    http_response_code(201);
    echo json_encode([
        "status" => "success",
        "message" => "PRT cleaning scorecard sheet initialized successfully.",
        "token_id" => $tokenId,
        "train_no" => $trainNo,
        "coaches_count" => count($coachNos)
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
