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
    // 1. Fetch shifts
    $stmt = $pdo->prepare("
        SELECT id AS shift_id, shift AS shift_name 
        FROM mcc_normal_machine_shifts 
        WHERE station_id = :station_id
        ORDER BY id ASC
    ");
    $stmt->execute(['station_id' => $stationId]);
    $shifts = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // 2. Fetch active nominations for this station on this report date (SCD Type 2 with HY093 safety)
    $targetStmt = $pdo->prepare("
        SELECT machine_id, shift_id 
        FROM mcc_normal_machine_target 
        WHERE station_id = :station_id 
          AND nominated_area = 'Y'
          AND :date_ref_1 >= effective_from
          AND (effective_to IS NULL OR :date_ref_2 <= effective_to)
    ");
    $targetStmt->execute([
        'station_id' => $stationId,
        'date_ref_1' => $reportDate,
        'date_ref_2' => $reportDate
    ]);
    $targetsRaw = $targetStmt->fetchAll(PDO::FETCH_ASSOC);
    
    $nominationsByShift = [];
    foreach ($targetsRaw as $t) {
        $nominationsByShift[$t['shift_id']][] = intval($t['machine_id']);
    }

    // 3. Fetch existing reports for this station on this date
    $reportStmt = $pdo->prepare("
        SELECT parameter_id AS machine_id, shift_id, used_status 
        FROM mcc_normal_machine_report 
        WHERE station_id = :station_id AND report_date = :report_date
    ");
    $reportStmt->execute([
        'station_id' => $stationId,
        'report_date' => $reportDate
    ]);
    $reportRows = $reportStmt->fetchAll(PDO::FETCH_ASSOC);

    $filledByShift = [];
    $reportsByShift = [];
    foreach ($reportRows as $r) {
        $reportsByShift[$r['shift_id']][] = $r;
        if ($r['used_status'] !== null && $r['used_status'] !== '' && $r['used_status'] !== '-') {
            $filledByShift[$r['shift_id']][] = intval($r['machine_id']);
        }
    }

    // 4. Calculate status for each shift
    $updatedShifts = [];
    foreach ($shifts as $s) {
        $sId = $s['shift_id'];
        $noms = $nominationsByShift[$sId] ?? [];
        $filled = $filledByShift[$sId] ?? [];
        $reports = $reportsByShift[$sId] ?? [];

        $status = 0;
        if (!empty($noms)) {
            $matchedCount = 0;
            foreach ($noms as $nomId) {
                if (in_array($nomId, $filled)) {
                    $matchedCount++;
                }
            }
            $status = ($matchedCount === count($noms)) ? 1 : 0;
        } else {
            // If no nominated machines are configured for this shift, base status on whether any report rows exist
            $status = !empty($reports) ? 1 : 0;
        }

        $s['status'] = $status;
        $updatedShifts[] = $s;
    }

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "station_id" => $stationId,
        "date" => $reportDate,
        "shifts" => $updatedShifts
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
