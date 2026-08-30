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
$reportDate = isset($data['date']) ? trim($data['date']) : (isset($data['report_date']) ? trim($data['report_date']) : date('Y-m-d'));

if ($stationId === null || $stationId <= 0) {
    http_response_code(400);
    echo json_encode([
        "status"  => "error",
        "message" => "station_id parameter is required and must be a valid positive integer."
    ]);
    exit();
}

try {
    // 1. Fetch distinct train_no and report_date for the station and date from mcc_intensive_scorecard_2_report
    $stmt = $pdo->prepare("
        SELECT DISTINCT train_no, report_date 
        FROM mcc_intensive_scorecard_2_report 
        WHERE station_id = :station_id AND report_date = :report_date
        ORDER BY train_no ASC
    ");
    $stmt->execute([
        'station_id'  => $stationId,
        'report_date' => $reportDate
    ]);
    $trainsList = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // 2. Query to check existence, auditor_name, token_id, coaches, and filled score values in mcc_intensive_pantry_report
    $pantryStmt = $pdo->prepare("
        SELECT DISTINCT token_id, auditor_name, coach_no
        FROM mcc_intensive_pantry_report
        WHERE station_id = :station_id AND train_no = :train_no AND report_date = :report_date
        ORDER BY coach_no ASC
    ");

    $statusStmt = $pdo->prepare("
        SELECT 
            COUNT(*) AS total_rows,
            SUM(CASE WHEN score_value IS NOT NULL AND score_value != '' THEN 1 ELSE 0 END) AS filled_rows,
            SUM(CASE WHEN score_value IS NULL OR score_value = '' THEN 1 ELSE 0 END) AS empty_rows
        FROM mcc_intensive_pantry_report
        WHERE station_id = :station_id AND train_no = :train_no AND report_date = :report_date
    ");

    $sheets = [];

    foreach ($trainsList as $t) {
        $trainNo = $t['train_no'];
        $pDate   = $t['report_date'];

        $pantryStmt->execute([
            'station_id'  => $stationId,
            'train_no'    => $trainNo,
            'report_date' => $pDate
        ]);
        $pantryRows = $pantryStmt->fetchAll(PDO::FETCH_ASSOC);

        $statusStmt->execute([
            'station_id'  => $stationId,
            'train_no'    => $trainNo,
            'report_date' => $pDate
        ]);
        $statusRow = $statusStmt->fetch(PDO::FETCH_ASSOC);

        $totalRows  = intval($statusRow['total_rows'] ?? 0);
        $filledRows = intval($statusRow['filled_rows'] ?? 0);
        $emptyRows  = intval($statusRow['empty_rows'] ?? 0);

        // Train status is 1 ONLY when all parameters are completely filled (empty_rows === 0), otherwise 0
        $trainStatus = ($totalRows > 0 && $emptyRows === 0) ? 1 : 0;

        if (!empty($pantryRows)) {
            $auditorName = $pantryRows[0]['auditor_name'] ?? 'prabhunath';
            $tokenId     = $pantryRows[0]['token_id'] ?? null;

            $coaches = [];
            foreach ($pantryRows as $pr) {
                if (!empty($pr['coach_no']) && !in_array($pr['coach_no'], $coaches)) {
                    $coaches[] = $pr['coach_no'];
                }
            }
        } else {
            $auditorName = null;
            $tokenId     = null;
            $coaches     = [];
        }

        $sheets[] = [
            "token_id"     => $tokenId,
            "train_no"     => $trainNo,
            "report_date"  => $pDate,
            "train_status" => $trainStatus,
            "auditor_name" => $auditorName,
            "coaches"      => $coaches
        ];
    }

    http_response_code(200);
    echo json_encode([
        "status"     => "success",
        "date"       => $reportDate,
        "station_id" => $stationId,
        "sheets"     => $sheets
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status"  => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
