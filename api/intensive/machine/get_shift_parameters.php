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
$shiftId = isset($data['shift_id']) ? intval($data['shift_id']) : null;
$reportDate = isset($data['date']) ? trim($data['date']) : date('Y-m-d');

if ($stationId === null || $stationId <= 0 || $shiftId === null || $shiftId <= 0) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "station_id and shift_id are required parameters and must be positive integers."
    ]);
    exit();
}

try {
    // 1. Get shift name - Intensive
    $shiftStmt = $pdo->prepare("SELECT shift AS shift_name FROM mcc_intensive_machine_shifts WHERE id = :shift_id LIMIT 1");
    $shiftStmt->execute(['shift_id' => $shiftId]);
    $shiftRow = $shiftStmt->fetch(PDO::FETCH_ASSOC);
    $shiftName = $shiftRow ? $shiftRow['shift_name'] : 'Unknown Shift';

    // 2. Fetch active machines for this station - Intensive
    $machinesStmt = $pdo->prepare("
        SELECT id AS machine_id, machine_no, machine_name 
        FROM mcc_intensive_machine_param 
        WHERE station_id = :station_id
        ORDER BY id ASC
    ");
    $machinesStmt->execute(['station_id' => $stationId]);
    $machinesList = $machinesStmt->fetchAll(PDO::FETCH_ASSOC);

    // 3. Fetch targets/nominations active on this report date (SCD Type 2 range query with HY093 safety) - Intensive
    $targetStmt = $pdo->prepare("
        SELECT machine_id, nominated_area 
        FROM mcc_intensive_machine_target 
        WHERE station_id = :station_id 
          AND shift_id = :shift_id
          AND :date_ref_1 >= effective_from
          AND (effective_to IS NULL OR :date_ref_2 <= effective_to)
    ");
    $targetStmt->execute([
        'station_id' => $stationId,
        'shift_id' => $shiftId,
        'date_ref_1' => $reportDate,
        'date_ref_2' => $reportDate
    ]);
    $targetsRaw = $targetStmt->fetchAll(PDO::FETCH_ASSOC);
    $targetsMap = [];
    foreach ($targetsRaw as $t) {
        $targetsMap[$t['machine_id']] = $t['nominated_area'];
    }

    // 4. Fetch existing report records and token - Intensive
    $reportStmt = $pdo->prepare("
        SELECT parameter_id AS machine_id, used_status, token_id, auditor_name 
        FROM mcc_intensive_machine_report 
        WHERE station_id = :station_id AND shift_id = :shift_id AND report_date = :report_date
    ");
    $reportStmt->execute([
        'station_id' => $stationId,
        'shift_id' => $shiftId,
        'report_date' => $reportDate
    ]);
    $reportRows = $reportStmt->fetchAll(PDO::FETCH_ASSOC);
    
    $reportsMap = [];
    $tokenId = null;
    $auditorName = null;
    foreach ($reportRows as $r) {
        $reportsMap[$r['machine_id']] = $r['used_status'];
        if (empty($tokenId)) {
            $tokenId = $r['token_id'];
        }
        if (empty($auditorName) && !empty($r['auditor_name'])) {
            $auditorName = $r['auditor_name'];
        }
    }

    // Generate a default token if no records exist yet
    if (empty($tokenId)) {
        $tokenId = 'TKN-MCH-' . date('Ymd', strtotime($reportDate)) . '-' . $shiftId . '-' . rand(1000, 9999);
    }

    // 5. Assemble parameters output
    $machines = [];
    foreach ($machinesList as $mach) {
        $mId = $mach['machine_id'];
        $machines[] = [
            "machine_id" => $mId,
            "machine_no" => $mach['machine_no'],
            "machine_name" => $mach['machine_name'],
            "nominated" => $targetsMap[$mId] ?? 'N', // Y/N target value
            "operated" => $reportsMap[$mId] ?? null   // Y/N or null if not filled yet
        ];
    }

    // Calculate shift completion status
    $totalNominated = 0;
    $totalFilled = 0;
    foreach ($machines as $m) {
        if ($m['nominated'] === 'Y') {
            $totalNominated++;
            if ($m['operated'] !== null && $m['operated'] !== '' && $m['operated'] !== '-') {
                $totalFilled++;
            }
        }
    }
    
    $shiftStatus = 0;
    if ($totalNominated > 0) {
        $shiftStatus = ($totalFilled === $totalNominated) ? 1 : 0;
    } else {
        // If there are no nominated machines configured, check if at least some entries exist
        $shiftStatus = !empty($reportRows) ? 1 : 0;
    }

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "meta" => [
            "station_id" => $stationId,
            "shift_id" => $shiftId,
            "shift_name" => $shiftName,
            "date" => $reportDate,
            "token_id" => $tokenId,
            "auditor_name" => $auditorName,
            "shift_status" => $shiftStatus
        ],
        "machines" => $machines
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
