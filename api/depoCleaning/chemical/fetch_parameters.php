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
$reportDate = isset($data['date']) ? trim($data['date']) : date('Y-m-d');

if ($stationId === null || $stationId <= 0) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "station_id parameter is required and must be a valid positive integer."
    ]);
    exit();
}

try {
    $targetMonth = date('Y-m', strtotime($reportDate));

    // Fetch parameters joined with targets
    $stmt = $pdo->prepare("
        SELECT 
            p.id AS parameter_id, 
            p.name AS parameter_name, 
            p.units, 
            t.qty_target, 
            t.penalty, 
            t.penalty_qty
        FROM dc_mcc_chemical_param p
        LEFT JOIN (
            SELECT parameter_id, `qty(ml)` AS qty_target, penalty, `penalty_qty(ml)` AS penalty_qty
            FROM dc_mcc_chemical_target
            WHERE station_id = :station_id_join 
              AND DATE_FORMAT(target_month, '%Y-%m') = :target_month
        ) t ON p.id = t.parameter_id
        WHERE p.station_id = :station_id_main
        ORDER BY p.id ASC
    ");
    $stmt->execute([
        'station_id_join' => $stationId,
        'station_id_main' => $stationId,
        'target_month' => $targetMonth
    ]);
    $parameters = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Format output types
    foreach ($parameters as &$param) {
        $param['parameter_id'] = intval($param['parameter_id']);
        $param['qty_target'] = $param['qty_target'] !== null ? floatval($param['qty_target']) : null;
        $param['penalty'] = $param['penalty'] !== null ? floatval($param['penalty']) : null;
        $param['penalty_qty'] = $param['penalty_qty'] !== null ? floatval($param['penalty_qty']) : null;
    }

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "station_id" => $stationId,
        "date" => $reportDate,
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
