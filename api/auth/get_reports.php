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
    // 1. Fetch assigned report keys for this station
    $stmt = $pdo->prepare("
        SELECT report_key 
        FROM mcc_station_reports 
        WHERE station_id = :station_id
    ");
    $stmt->execute(['station_id' => $stationId]);
    $assignedKeys = $stmt->fetchAll(PDO::FETCH_COLUMN);

    // 2. Map keys to human-readable names
    $reportNamesMap = [
        'normal_audit' => 'Normal Audit Scorecard',
        'normal_chem' => 'Normal Chemical Consumption',
        'normal_mach' => 'Normal Machine Log',
        'int_audit' => 'Intensive Audit Scorecard',
        'int_chem' => 'Intensive Chemical Report',
        'int_mach' => 'Intensive Machine Log',
        'int_scorecard_2' => 'Intensive Scorecard 2',
        'int_pantry' => 'Pantry Car Score Card',
        'pldc_audit' => 'PLDC Audit Scorecard',
        'pldc_chem' => 'PLDC Chemical Report',
        'pldc_mach' => 'PLDC Machine Log',
        'sur_pit' => 'Pit & Office Inspection',
        'sur_pf' => 'PF Return Trains Audit',
        'prt_audit' => 'PRT ScoreCard',
        'prt_chem' => 'PRT Chemical Report',
        'vb_audit' => 'Vande Bharat Score Card',
        'vb_chem' => 'Vande Bharat Chemical Report',
        'vb_mach' => 'Vande Bharat Machine Report',
        'manpower' => 'Man Power Log',
        'cleanliness' => 'Cleanliness Scorecard',
        'photo_report' => 'Photo Report (Before/After)'
    ];

    $reports = [];
    foreach ($assignedKeys as $key) {
        $reports[] = [
            "report_key" => $key,
            "report_name" => $reportNamesMap[$key] ?? ucfirst(str_replace('_', ' ', $key))
        ];
    }

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "station_id" => $stationId,
        "assigned_reports_count" => count($reports),
        "assigned_reports" => $reports
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}

