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
    // 1. Fetch parameters from dc_mcc_param for the station
    $paramStmt = $pdo->prepare("
        SELECT id AS parameter_id, parameter_name 
        FROM dc_mcc_param 
        WHERE station_id = :station_id
        ORDER BY id ASC
    ");
    $paramStmt->execute(['station_id' => $stationId]);
    $parameters = $paramStmt->fetchAll(PDO::FETCH_ASSOC);

    // 2. Fetch rating options from dc_mcc_rating
    $ratingsStmt = $pdo->query("
        SELECT rating_name AS label, rating_value AS value 
        FROM dc_mcc_rating 
        ORDER BY id ASC
    ");
    $ratings = $ratingsStmt->fetchAll(PDO::FETCH_ASSOC);

    // 3. Attach ratings to every parameter
    foreach ($parameters as &$param) {
        $param['parameter_id'] = intval($param['parameter_id']);
        $param['ratings'] = $ratings;
    }

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "station_id" => $stationId,
        "parameters" => $parameters
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
?>
