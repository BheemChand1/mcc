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
    // 1. Fetch distinct tokens and trains for the station and date in chemical reports - PRT
    $stmt = $pdo->prepare("
        SELECT DISTINCT token_id, train_no, report_date 
        FROM mcc_prt_chemical_report 
        WHERE station_id = :station_id AND report_date = :report_date
        ORDER BY token_id DESC
    ");
    $stmt->execute([
        'station_id' => $stationId,
        'report_date' => $reportDate
    ]);
    $tokensList = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $sheets = [];

    if (!empty($tokensList)) {
        // Prepare statement to fetch distinct coaches for a token - PRT
        $coachesStmt = $pdo->prepare("
            SELECT DISTINCT coach_no 
            FROM mcc_prt_chemical_report 
            WHERE token_id = :token_id
            ORDER BY coach_no ASC
        ");

        $statusStmt = $pdo->prepare("
            SELECT 
                COUNT(*) AS total_rows,
                SUM(CASE WHEN qty_used IS NULL OR qty_used = '' THEN 1 ELSE 0 END) AS empty_rows
            FROM mcc_prt_chemical_report
            WHERE token_id = :token_id
        ");

        foreach ($tokensList as $tokenItem) {
            $coachesStmt->execute(['token_id' => $tokenItem['token_id']]);
            $coaches = $coachesStmt->fetchAll(PDO::FETCH_COLUMN);

            $statusStmt->execute(['token_id' => $tokenItem['token_id']]);
            $statusRow = $statusStmt->fetch(PDO::FETCH_ASSOC);
            $totalRows = intval($statusRow['total_rows'] ?? 0);
            $emptyRows = intval($statusRow['empty_rows'] ?? 0);
            $trainStatus = ($totalRows > 0 && $emptyRows === 0) ? 1 : 0;

            $sheets[] = [
                "token_id" => $tokenItem['token_id'],
                "train_no" => $tokenItem['train_no'],
                "report_date" => $tokenItem['report_date'],
                "train_status" => $trainStatus,
                "coaches" => $coaches
            ];
        }
    }

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "date" => $reportDate,
        "station_id" => $stationId,
        "sheets" => $sheets
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
?>
