<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require_once '../../../connection.php';
global $pdo;

$tokenId = $_GET['token_id'] ?? null;

if (empty($tokenId)) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "token_id parameter is required."
    ]);
    exit();
}

try {
    // 1. Fetch token details
    $metaStmt = $pdo->prepare("
        SELECT DISTINCT token_id, train_no, report_date, auditor_name, station_id
        FROM mcc_normal_scorecard_report
        WHERE token_id = :token_id
    ");
    $metaStmt->execute(['token_id' => $tokenId]);
    $meta = $metaStmt->fetch(PDO::FETCH_ASSOC);

    if (!$meta) {
        http_response_code(404);
        echo json_encode([
            "status" => "error",
            "message" => "Scorecard sheet not found for token_id: $tokenId"
        ]);
        exit();
    }

    // 2. Fetch distinct coaches
    $coachesStmt = $pdo->prepare("
        SELECT DISTINCT coach_no 
        FROM mcc_normal_scorecard_report 
        WHERE token_id = :token_id
        ORDER BY coach_no ASC
    ");
    $coachesStmt->execute(['token_id' => $tokenId]);
    $coaches = $coachesStmt->fetchAll(PDO::FETCH_COLUMN);

    // 3. Fetch active parameters and subparameters
    $paramsStmt = $pdo->prepare("
        SELECT p.id AS parameter_id, p.parameter_name, sp.id AS sub_parameter_id, sp.sub_parameter_name
        FROM mcc_normal_scorecard_param p
        JOIN mcc_normal_scorecard_sub_param sp ON p.id = sp.parameter_id
        WHERE p.station_id = ? AND sp.station_id = ? AND p.status = 'Active' AND sp.status = 'Active'
        ORDER BY p.id ASC, sp.id ASC
    ");
    $paramsStmt->execute([$meta['station_id'], $meta['station_id']]);
    $paramsRows = $paramsStmt->fetchAll(PDO::FETCH_ASSOC);

    // Group subparameters by parameter
    $parameters = [];
    foreach ($paramsRows as $row) {
        $pId = $row['parameter_id'];
        if (!isset($parameters[$pId])) {
            $parameters[$pId] = [
                'parameter_id' => $pId,
                'parameter_name' => $row['parameter_name'],
                'sub_parameters' => []
            ];
        }
        $parameters[$pId]['sub_parameters'][] = [
            'sub_parameter_id' => $row['sub_parameter_id'],
            'sub_parameter_name' => $row['sub_parameter_name']
        ];
    }
    $parameters = array_values($parameters);

    // 4. Fetch current scorecard scores
    $scoresStmt = $pdo->prepare("
        SELECT sub_parameter_id, coach_no, score_value 
        FROM mcc_normal_scorecard_report
        WHERE token_id = :token_id
    ");
    $scoresStmt->execute(['token_id' => $tokenId]);
    $scores = $scoresStmt->fetchAll(PDO::FETCH_ASSOC);

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "meta" => $meta,
        "coaches" => $coaches,
        "parameters" => $parameters,
        "scores" => $scores
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
