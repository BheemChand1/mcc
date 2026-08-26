<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require_once '../../connection.php';
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
        "message" => "station_id is required and must be a valid positive integer."
    ]);
    exit();
}

try {
    // 1. Fetch active reports for the station
    $reportsStmt = $pdo->prepare("
        SELECT report_id, report_name 
        FROM mcc_reports 
        WHERE station_id = :station_id AND status = 'Active'
        ORDER BY report_id ASC
    ");
    $reportsStmt->execute(['station_id' => $stationId]);
    $reportsList = $reportsStmt->fetchAll(PDO::FETCH_ASSOC);

    // 2. Fetch active subreports for each report
    $subreportsStmt = $pdo->prepare("
        SELECT subreport_id, report_name AS subreport_name, report_url 
        FROM mcc_subreports 
        WHERE report_id = :report_id AND status = 'Active'
        ORDER BY subreport_id ASC
    ");

    $reports = [];
    foreach ($reportsList as $rep) {
        $subreportsStmt->execute(['report_id' => $rep['report_id']]);
        $subreports = $subreportsStmt->fetchAll(PDO::FETCH_ASSOC);

        // Convert IDs to integer
        $rep['report_id'] = intval($rep['report_id']);
        foreach ($subreports as &$sub) {
            $sub['subreport_id'] = intval($sub['subreport_id']);
        }

        $rep['subreports'] = $subreports;
        $reports[] = $rep;
    }

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "station_id" => $stationId,
        "reports" => $reports
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
