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
$shiftId = isset($data['shift_id']) && intval($data['shift_id']) > 0 ? intval($data['shift_id']) : null;
$reportDate = isset($data['date']) ? trim($data['date']) : date('Y-m-d');

if ($stationId === null || $stationId <= 0) {
    http_response_code(400);
    echo json_encode([
        "status" => "error",
        "message" => "station_id is a required parameter and must be a valid positive integer."
    ]);
    exit();
}

try {
    // 1. Fetch active machines for this station - DC
    $machinesStmt = $pdo->prepare("
        SELECT id AS machine_id, machine_no, machine_name 
        FROM dc_mcc_machine_param 
        WHERE station_id = :station_id
        ORDER BY id ASC
    ");
    $machinesStmt->execute(['station_id' => $stationId]);
    $machinesList = $machinesStmt->fetchAll(PDO::FETCH_ASSOC);

    $meta = [
        "station_id" => $stationId,
        "date" => $reportDate
    ];

    if ($shiftId !== null) {
        // Get shift name
        $shiftStmt = $pdo->prepare("SELECT shift AS shift_name FROM dc_mcc_machine_shifts WHERE id = :shift_id LIMIT 1");
        $shiftStmt->execute(['shift_id' => $shiftId]);
        $shiftRow = $shiftStmt->fetch(PDO::FETCH_ASSOC);
        $shiftName = $shiftRow ? $shiftRow['shift_name'] : 'Unknown Shift';

        // Fetch targets/nominations active on this report date
        $targetStmt = $pdo->prepare("
            SELECT machine_id, nominated_area 
            FROM dc_mcc_machine_target 
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

        // Fetch existing report records and token
        $reportStmt = $pdo->prepare("
            SELECT parameter_id AS machine_id, used_status, token_id, auditor_name 
            FROM dc_mcc_machine_report 
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

        if (empty($tokenId)) {
            $tokenId = 'TKN-DC-MCH-' . date('Ymd', strtotime($reportDate)) . '-' . $shiftId . '-' . rand(1000, 9999);
        }

        $machines = [];
        foreach ($machinesList as $mach) {
            $mId = $mach['machine_id'];
            $nomVal = $targetsMap[$mId] ?? 'N';

            if ($nomVal === 'Y') {
                $machines[] = [
                    "machine_id" => intval($mId),
                    "machine_no" => $mach['machine_no'],
                    "machine_name" => $mach['machine_name'],
                    "nominated" => $nomVal,
                    "operated" => $reportsMap[$mId] ?? null
                ];
            }
        }

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
            $shiftStatus = !empty($reportRows) ? 1 : 0;
        }

        $meta['shift_id'] = $shiftId;
        $meta['shift_name'] = $shiftName;
        $meta['token_id'] = $tokenId;
        $meta['auditor_name'] = $auditorName;
        $meta['shift_status'] = $shiftStatus;
    } else {
        $machines = [];
        foreach ($machinesList as $mach) {
            $machines[] = [
                "machine_id" => intval($mach['machine_id']),
                "machine_no" => $mach['machine_no'],
                "machine_name" => $mach['machine_name'],
                "nominated" => "N",
                "operated" => null
            ];
        }
    }

    http_response_code(200);
    echo json_encode([
        "status" => "success",
        "meta" => $meta,
        "machines" => $machines
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        "status" => "error",
        "message" => "Database error: " . $e->getMessage()
    ]);
}
?>
