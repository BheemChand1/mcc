<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require_once __DIR__ . '/../../../connection.php';
global $pdo;

// Get posted data (JSON or standard POST)
$data = json_decode(file_get_contents("php://input"), true);
if (empty($data)) {
    $data = $_POST;
}

$trainNo     = isset($data['train_no']) ? trim($data['train_no']) : (isset($data['train_number']) ? trim($data['train_number']) : null);
$stationId   = isset($data['station_id']) && intval($data['station_id']) > 0 ? intval($data['station_id']) : 1;
$reportDate  = isset($data['date']) ? trim($data['date']) : (isset($data['report_date']) ? trim($data['report_date']) : date('Y-m-d'));
$auditorName = isset($data['auditor_name']) ? trim($data['auditor_name']) : (isset($data['submitted_by']) ? trim($data['submitted_by']) : 'prabhunath');
$shiftId     = 0; // Default placeholder for DB schema

// Support coach_no (single, array, or comma-separated) or coach_nos
$coachInput = $data['coach_no'] ?? ($data['coach_nos'] ?? null);

if (empty($trainNo) || empty($coachInput)) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "train_no and coach_no are required parameters."
    ]);
    exit();
}

// Normalize coach numbers to array
$coachNos = [];
if (is_array($coachInput)) {
    $coachNos = array_values(array_filter(array_map('trim', $coachInput)));
} else {
    $coachNos = array_values(array_filter(array_map('trim', explode(',', (string)$coachInput))));
}

if (empty($coachNos)) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "At least one valid coach_no must be provided."
    ]);
    exit();
}

try {
    // 1. Fetch active sub-parameters from mcc_intensive_pantry_param & mcc_intensive_pantry_sub_param
    $subParamsStmt = $pdo->prepare("
        SELECT sp.id AS sub_parameter_id
        FROM mcc_intensive_pantry_param p
        JOIN mcc_intensive_pantry_sub_param sp ON p.id = sp.parameter_id
        WHERE p.station_id = :p_station_id AND sp.station_id = :sp_station_id
          AND p.status = 'Active' AND sp.status = 'Active'
        ORDER BY p.id ASC, sp.id ASC
    ");
    $subParamsStmt->execute([
        'p_station_id'  => $stationId,
        'sp_station_id' => $stationId
    ]);
    $subParams = $subParamsStmt->fetchAll(PDO::FETCH_COLUMN);

    if (empty($subParams)) {
        http_response_code(400);
        echo json_encode([
            "status" => "error",
            "message" => "No active pantry car scorecard parameters found for station_id: $stationId"
        ]);
        exit();
    }

    // 2. Fetch chemical parameters from mcc_intensive_pantry_chemical_param
    $chemParamsStmt = $pdo->prepare("
        SELECT id FROM mcc_intensive_pantry_chemical_param 
        WHERE station_id = :station_id
        ORDER BY id ASC
    ");
    $chemParamsStmt->execute(['station_id' => $stationId]);
    $chemParams = $chemParamsStmt->fetchAll(PDO::FETCH_COLUMN);

    // 3. Generate a unique token_id
    $datePart = date('Ymd', strtotime($reportDate));
    $randPart = sprintf("%03d", rand(1, 999));
    $tokenId = "TKN-PTRY-" . $datePart . "-" . $randPart;

    // Ensure token uniqueness
    $checkStmt = $pdo->prepare("SELECT COUNT(*) FROM mcc_intensive_pantry_report WHERE token_id = ?");
    $checkStmt->execute([$tokenId]);
    while ($checkStmt->fetchColumn() > 0) {
        $randPart = sprintf("%03d", rand(1, 999));
        $tokenId = "TKN-PTRY-" . $datePart . "-" . $randPart;
        $checkStmt->execute([$tokenId]);
    }

    $pdo->beginTransaction();

    // 4. Insert into mcc_intensive_pantry_report
    $insertScoreStmt = $pdo->prepare("
        INSERT INTO mcc_intensive_pantry_report 
        (sub_parameter_id, station_id, token_id, train_no, coach_no, score_value, submitted_by, report_date)
        VALUES (:sub_parameter_id, :station_id, :token_id, :train_no, :coach_no, '', :submitted_by, :report_date)
    ");

    foreach ($coachNos as $coachNo) {
        foreach ($subParams as $subParamId) {
            $insertScoreStmt->execute([
                'sub_parameter_id' => $subParamId,
                'station_id'       => $stationId,
                'token_id'         => $tokenId,
                'train_no'         => $trainNo,
                'coach_no'         => $coachNo,
                'submitted_by'     => $auditorName,
                'report_date'      => $reportDate
            ]);
        }
    }

    // 5. Insert into mcc_intensive_pantry_chemical_report
    if (!empty($chemParams)) {
        $insertChemStmt = $pdo->prepare("
            INSERT INTO mcc_intensive_pantry_chemical_report 
            (parameter_id, shift_id, qty_used, token_id, auditor_name, station_id, train_no, coach_no, report_date)
            VALUES (:parameter_id, :shift_id, NULL, :token_id, :auditor_name, :station_id, :train_no, :coach_no, :report_date)
        ");

        foreach ($coachNos as $coachNo) {
            foreach ($chemParams as $paramId) {
                $insertChemStmt->execute([
                    'parameter_id' => $paramId,
                    'shift_id'     => $shiftId,
                    'token_id'     => $tokenId,
                    'auditor_name' => $auditorName,
                    'station_id'   => $stationId,
                    'train_no'     => $trainNo,
                    'coach_no'     => $coachNo,
                    'report_date'  => $reportDate
                ]);
            }
        }
    }

    $pdo->commit();

    http_response_code(201);
    echo json_encode([
        "status"        => "success",
        "message"       => "Pantry car scorecard and chemical sheet initialized successfully.",
        "token_id"      => $tokenId,
        "train_no"      => $trainNo,
        "report_date"   => $reportDate,
        "coaches"       => $coachNos,
        "coaches_count" => count($coachNos)
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
