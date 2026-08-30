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

$tokenId = isset($data['token_id']) ? trim($data['token_id']) : null;
$trainNo = isset($data['train_no']) ? trim($data['train_no']) : null;
$coachNo = isset($data['coach_no']) ? trim($data['coach_no']) : null;

if (empty($tokenId) || empty($trainNo) || empty($coachNo)) {
    http_response_code(400);
    echo json_encode([
        "status"  => "error",
        "message" => "token_id, train_no, and coach_no are all required parameters."
    ]);
    exit();
}

try {
    // 1. Fetch scores joined with parameter details for the specific coach - Pantry Car
    $stmt = $pdo->prepare("
        SELECT 
            p.id AS parameter_id, 
            p.parameter_name, 
            sp.id AS sub_parameter_id, 
            sp.sub_parameter_name, 
            sp.input_type,
            r.score_value,
            r.auditor_name,
            r.report_date
        FROM mcc_intensive_pantry_report r
        JOIN mcc_intensive_pantry_sub_param sp ON r.sub_parameter_id = sp.id
        JOIN mcc_intensive_pantry_param p ON sp.parameter_id = p.id
        WHERE r.token_id = :token_id 
          AND r.train_no = :train_no 
          AND r.coach_no = :coach_no
        ORDER BY p.id ASC, sp.id ASC
    ");
    $stmt->execute([
        'token_id' => $tokenId,
        'train_no' => $trainNo,
        'coach_no' => $coachNo
    ]);
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

    if (empty($rows)) {
        http_response_code(404);
        echo json_encode([
            "status"  => "error",
            "message" => "No pantry car scorecard data found for the given combination of token_id, train_no, and coach_no."
        ]);
        exit();
    }

    // 2. Fetch rating groups and options dynamically - Pantry Car
    $ratingsStmt = $pdo->query("SELECT rating_group, rating_name, rating_value FROM mcc_intensive_pantry_rating ORDER BY id ASC");
    $ratingsRows = $ratingsStmt ? $ratingsStmt->fetchAll(PDO::FETCH_ASSOC) : [];

    if (empty($ratingsRows)) {
        $fallbackStmt = $pdo->query("SELECT rating_group, rating_name, rating_value FROM mcc_normal_rating ORDER BY id ASC");
        $ratingsRows = $fallbackStmt ? $fallbackStmt->fetchAll(PDO::FETCH_ASSOC) : [];
    }

    $ratingGroups = [];
    foreach ($ratingsRows as $r) {
        $group = !empty($r['rating_group']) ? $r['rating_group'] : 'cleaning';
        if (!isset($ratingGroups[$group])) {
            $ratingGroups[$group] = [];
        }
        $ratingGroups[$group][] = [
            'label' => $r['rating_name'],
            'value' => $r['rating_value']
        ];
    }

    // 3. Group subparameters by parameter
    $parameters  = [];
    $auditorName = '';
    $reportDate  = '';

    foreach ($rows as $row) {
        $pId = $row['parameter_id'];
        if (empty($auditorName)) {
            $auditorName = $row['auditor_name'];
        }
        if (empty($reportDate)) {
            $reportDate = $row['report_date'];
        }

        if (!isset($parameters[$pId])) {
            $parameters[$pId] = [
                'parameter_id'   => $pId,
                'parameter_name' => $row['parameter_name'],
                'status'         => 1,
                'sub_parameters' => []
            ];
        }

        $inputType = !empty($row['input_type']) ? $row['input_type'] : 'cleaning';
        $options   = $ratingGroups[$inputType] ?? ($ratingGroups['cleaning'] ?? []);

        $scoreValue = $row['score_value'];
        if ($scoreValue === null || $scoreValue === '') {
            $parameters[$pId]['status'] = 0;
        }

        $parameters[$pId]['sub_parameters'][] = [
            'sub_parameter_id'   => $row['sub_parameter_id'],
            'sub_parameter_name' => $row['sub_parameter_name'],
            'input_type'         => $inputType,
            'options'            => $options,
            'score_value'        => $scoreValue
        ];
    }

    // Final calculations: calculate percentage for the coach
    $totalCount  = 0;
    $obtainedSum = 0;
    foreach ($rows as $row) {
        $val = $row['score_value'];
        if ($val !== null && $val !== '' && is_numeric($val)) {
            $obtainedSum += floatval($val);
            $totalCount++;
        }
    }
    $maxPossible = $totalCount * 3;
    $overallCoachPercentage = $maxPossible > 0 ? round(($obtainedSum / $maxPossible) * 100, 2) : 0;

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "meta"   => [
            "token_id"               => $tokenId,
            "train_no"               => $trainNo,
            "coach_no"               => $coachNo,
            "auditor_name"           => $auditorName,
            "report_date"            => $reportDate,
            "coach_score_percentage" => $overallCoachPercentage
        ],
        "parameters" => array_values($parameters)
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status"  => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
