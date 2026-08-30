<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require_once __DIR__ . '/../../../connection.php';
global $pdo;

// Support both POST (JSON or urlencoded) and GET
$data = json_decode(file_get_contents("php://input"), true);
if (empty($data)) {
    $data = array_merge($_POST, $_GET);
}

$stationId  = isset($data['station_id']) ? intval($data['station_id']) : null;
$trainNo    = isset($data['train_no']) ? trim($data['train_no']) : (isset($data['train_number']) ? trim($data['train_number']) : null);
$reportDate = isset($data['date']) ? trim($data['date']) : (isset($data['report_date']) ? trim($data['report_date']) : date('Y-m-d'));
$coachNo    = isset($data['coach_no']) ? trim($data['coach_no']) : null;

if ($stationId === null || $stationId <= 0) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "station_id parameter is required and must be a valid positive integer."
    ]);
    exit();
}

try {
    // 1. Fetch active parameters from mcc_intensive_pantry_param for the station
    $paramStmt = $pdo->prepare("
        SELECT id AS parameter_id, parameter_name 
        FROM mcc_intensive_pantry_param 
        WHERE station_id = :station_id AND status = 'Active'
        ORDER BY id ASC
    ");
    $paramStmt->execute(['station_id' => $stationId]);
    $paramRows = $paramStmt->fetchAll(PDO::FETCH_ASSOC);

    // 2. Fetch active sub-parameters from mcc_intensive_pantry_sub_param for the station
    $subParamStmt = $pdo->prepare("
        SELECT id AS sub_parameter_id, parameter_id, sub_parameter_name, input_type 
        FROM mcc_intensive_pantry_sub_param 
        WHERE station_id = :station_id AND status = 'Active'
        ORDER BY parameter_id ASC, id ASC
    ");
    $subParamStmt->execute(['station_id' => $stationId]);
    $subParamRows = $subParamStmt->fetchAll(PDO::FETCH_ASSOC);

    // 3. Fetch rating options from mcc_intensive_pantry_rating
    $ratingsStmt = $pdo->query("
        SELECT id, rating_name, rating_value, rating_group 
        FROM mcc_intensive_pantry_rating 
        ORDER BY id ASC
    ");
    $allRatings = $ratingsStmt ? $ratingsStmt->fetchAll(PDO::FETCH_ASSOC) : [];

    if (empty($allRatings)) {
        // Fallback to mcc_normal_rating if pantry rating table is empty
        $fallbackStmt = $pdo->query("
            SELECT id, rating_name, rating_value, rating_group 
            FROM mcc_normal_rating 
            ORDER BY id ASC
        ");
        $allRatings = $fallbackStmt ? $fallbackStmt->fetchAll(PDO::FETCH_ASSOC) : [];
    }

    // Group ratings by rating_group
    $ratingGroups = [];
    foreach ($allRatings as $r) {
        $group = !empty($r['rating_group']) ? $r['rating_group'] : 'cleaning';
        if (!isset($ratingGroups[$group])) {
            $ratingGroups[$group] = [];
        }
        $ratingGroups[$group][] = [
            'label' => $r['rating_name'],
            'value' => $r['rating_value']
        ];
    }

    // Default ratings if none found
    $defaultRatings = [
        ['label' => 'Very Good', 'value' => '3'],
        ['label' => 'Satisfactory', 'value' => '2'],
        ['label' => 'Poor', 'value' => '1'],
        ['label' => 'Not attended', 'value' => '0']
    ];

    // 4. Query mcc_intensive_pantry_report for existing parameters/scores if train_no is provided
    $existingReportsMap = [];
    if (!empty($trainNo)) {
        $reportQuery = "
            SELECT sub_parameter_id, score_value, coach_no, token_id
            FROM mcc_intensive_pantry_report
            WHERE station_id = :station_id 
              AND train_no = :train_no 
              AND report_date = :report_date
        ";
        $reportParams = [
            'station_id'  => $stationId,
            'train_no'    => $trainNo,
            'report_date' => $reportDate
        ];

        if (!empty($coachNo)) {
            $reportQuery .= " AND coach_no = :coach_no";
            $reportParams['coach_no'] = $coachNo;
        }

        $repStmt = $pdo->prepare($reportQuery);
        $repStmt->execute($reportParams);
        $repRows = $repStmt->fetchAll(PDO::FETCH_ASSOC);

        foreach ($repRows as $r) {
            $spId = intval($r['sub_parameter_id']);
            $val = $r['score_value'];
            $isFilled = ($val !== null && $val !== '' && $val !== 'X' && $val !== '-');

            if (!isset($existingReportsMap[$spId])) {
                $existingReportsMap[$spId] = [
                    'exists'      => true,
                    'filled'      => $isFilled,
                    'score_value' => $val,
                    'token_id'    => $r['token_id']
                ];
            } else {
                if ($isFilled) {
                    $existingReportsMap[$spId]['filled'] = true;
                    $existingReportsMap[$spId]['score_value'] = $val;
                }
            }
        }
    }

    // 5. Structure parameters and assign status (0 or 1)
    $parameters = [];
    foreach ($paramRows as $p) {
        $pId = intval($p['parameter_id']);
        $parameters[$pId] = [
            'parameter_id'   => $pId,
            'parameter_name' => $p['parameter_name'],
            'status'         => 0,
            'sub_parameters' => []
        ];
    }

    foreach ($subParamRows as $sp) {
        $pId = intval($sp['parameter_id']);
        $spId = intval($sp['sub_parameter_id']);

        if (isset($parameters[$pId])) {
            $inputType = !empty($sp['input_type']) ? $sp['input_type'] : 'cleaning';
            $spRatings = $ratingGroups[$inputType] ?? ($ratingGroups['cleaning'] ?? $defaultRatings);

            // Determine subparameter status: 1 if available in mcc_intensive_pantry_report for this train and date, else 0
            $isAvailable = isset($existingReportsMap[$spId]) ? 1 : 0;
            $savedScore = isset($existingReportsMap[$spId]) ? $existingReportsMap[$spId]['score_value'] : null;

            if ($isAvailable === 1) {
                $parameters[$pId]['status'] = 1;
            }

            $subObj = [
                'sub_parameter_id'   => $spId,
                'sub_parameter_name' => $sp['sub_parameter_name'],
                'input_type'         => $inputType,
                'status'             => $isAvailable,
                'ratings'            => $spRatings
            ];

            if ($savedScore !== null) {
                $subObj['score_value'] = $savedScore;
            }

            $parameters[$pId]['sub_parameters'][] = $subObj;
        }
    }

    http_response_code(200);
    $response = [
        "status"     => "success",
        "station_id" => $stationId,
        "date"       => $reportDate
    ];

    if (!empty($trainNo)) {
        $response["train_no"] = $trainNo;
    }
    if (!empty($coachNo)) {
        $response["coach_no"] = $coachNo;
    }

    $response["parameters"] = array_values($parameters);
    $response["ratings"]    = $allRatings;

    echo json_encode($response);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status"  => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
