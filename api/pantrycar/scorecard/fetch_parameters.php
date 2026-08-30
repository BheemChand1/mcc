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

$stationId = isset($data['station_id']) ? intval($data['station_id']) : null;

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

    // Map subparameters under parameters
    $parameters = [];
    foreach ($paramRows as $p) {
        $pId = intval($p['parameter_id']);
        $parameters[$pId] = [
            'parameter_id'   => $pId,
            'parameter_name' => $p['parameter_name'],
            'sub_parameters' => []
        ];
    }

    foreach ($subParamRows as $sp) {
        $pId = intval($sp['parameter_id']);
        if (isset($parameters[$pId])) {
            $inputType = !empty($sp['input_type']) ? $sp['input_type'] : 'cleaning';
            $spRatings = $ratingGroups[$inputType] ?? ($ratingGroups['cleaning'] ?? $defaultRatings);

            $parameters[$pId]['sub_parameters'][] = [
                'sub_parameter_id'   => intval($sp['sub_parameter_id']),
                'sub_parameter_name' => $sp['sub_parameter_name'],
                'input_type'         => $inputType,
                'ratings'            => $spRatings
            ];
        }
    }

    http_response_code(200);
    echo json_encode([
        "status"     => "success",
        "station_id" => $stationId,
        "parameters" => array_values($parameters),
        "ratings"    => $allRatings
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status"  => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
