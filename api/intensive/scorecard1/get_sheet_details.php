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
    // 1. Fetch token details - Intensive Scorecard 1
    $metaStmt = $pdo->prepare("
        SELECT DISTINCT token_id, train_no, report_date, auditor_name, station_id
        FROM mcc_intensive_scorecard_report
        WHERE token_id = :token_id
    ");
    $metaStmt->execute(['token_id' => $tokenId]);
    $meta = $metaStmt->fetch(PDO::FETCH_ASSOC);

    if ($meta && (empty($meta['auditor_name']) || !isset($meta['auditor_name']))) {
        // Fallback to chemical report auditor_name if empty
        try {
            $auditorStmt = $pdo->prepare("SELECT auditor_name FROM mcc_intensive_chemical_report WHERE token_id = ? LIMIT 1");
            $auditorStmt->execute([$tokenId]);
            $meta['auditor_name'] = $auditorStmt->fetchColumn() ?: '';
        } catch (Exception $e) {
            $meta['auditor_name'] = '';
        }
    }

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
        FROM mcc_intensive_scorecard_report 
        WHERE token_id = :token_id
        ORDER BY coach_no ASC
    ");
    $coachesStmt->execute(['token_id' => $tokenId]);
    $coaches = $coachesStmt->fetchAll(PDO::FETCH_COLUMN);

    // 3. Fetch active parameters and subparameters - Intensive Scorecard 1
    $paramsStmt = $pdo->prepare("
        SELECT p.id AS parameter_id, p.parameter_name, sp.id AS sub_parameter_id, sp.sub_parameter_name
        FROM mcc_intensive_scorecard_param p
        JOIN mcc_intensive_scorecard_sub_param sp ON p.id = sp.parameter_id
        WHERE p.station_id = ? AND sp.station_id = ? AND p.status = 'Active' AND sp.status = 'Active'
        ORDER BY p.id ASC, sp.id ASC
    ");
    $paramsStmt->execute([$meta['station_id'], $meta['station_id']]);
    $paramsRows = $paramsStmt->fetchAll(PDO::FETCH_ASSOC);

    // Fetch all rating options grouped by rating_group
    $ratingsRows = [];
    try {
        $ratingsStmt = $pdo->query("SELECT rating_group, rating_name, rating_value FROM mcc_intensive_scorecard_2_rating ORDER BY id ASC");
        if ($ratingsStmt) {
            $ratingsRows = $ratingsStmt->fetchAll(PDO::FETCH_ASSOC);
        }
    } catch (Exception $e) {}

    if (empty($ratingsRows)) {
        try {
            $ratingsStmt = $pdo->query("SELECT rating_group, rating_name, rating_value FROM mcc_normal_rating ORDER BY id ASC");
            if ($ratingsStmt) {
                $ratingsRows = $ratingsStmt->fetchAll(PDO::FETCH_ASSOC);
            }
        } catch (Exception $e) {}
    }

    if (empty($ratingsRows)) {
        $ratingsRows = [
            ['rating_group' => 'cleaning', 'rating_name' => 'Excellent', 'rating_value' => '3'],
            ['rating_group' => 'cleaning', 'rating_name' => 'Good', 'rating_value' => '2'],
            ['rating_group' => 'cleaning', 'rating_name' => 'Average', 'rating_value' => '1'],
            ['rating_group' => 'cleaning', 'rating_name' => 'Poor', 'rating_value' => '0'],
            ['rating_group' => 'yes_no', 'rating_name' => 'Yes', 'rating_value' => 'Y'],
            ['rating_group' => 'yes_no', 'rating_name' => 'No', 'rating_value' => 'N'],
        ];
    }

    $ratingGroups = [];
    foreach ($ratingsRows as $r) {
        $group = $r['rating_group'] ?: 'cleaning';
        if (!isset($ratingGroups[$group])) {
            $ratingGroups[$group] = [];
        }
        $ratingGroups[$group][] = [
            'label' => $r['rating_name'],
            'value' => $r['rating_value']
        ];
    }

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

        $inputType = (stripos($row['sub_parameter_name'], 'Yes') !== false || stripos($row['parameter_name'], 'Watering') !== false) 
            ? 'yes_no' 
            : 'cleaning';
        $options = $ratingGroups[$inputType] ?? ($ratingGroups['cleaning'] ?? []);

        $parameters[$pId]['sub_parameters'][] = [
            'sub_parameter_id' => $row['sub_parameter_id'],
            'sub_parameter_name' => $row['sub_parameter_name'],
            'input_type' => $inputType,
            'options' => $options
        ];
    }
    $parameters = array_values($parameters);

    // 4. Fetch current scorecard scores - Intensive Scorecard 1
    $scoresStmt = $pdo->prepare("
        SELECT sub_parameter_id, coach_no, score_value 
        FROM mcc_intensive_scorecard_report
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
?>
