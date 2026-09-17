<?php
require_once __DIR__ . '/auth.php';

header('Content-Type: application/json');

if (!$isCDO) {
    echo json_encode([
        'success' => false,
        'message' => 'Unauthorized. Only CDO users can approve reports.'
    ]);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    echo json_encode([
        'success' => false,
        'message' => 'Invalid request method.'
    ]);
    exit;
}

$table = trim($_POST['table'] ?? '');
$tokenId = trim($_POST['token_id'] ?? '');
$reportDate = trim($_POST['report_date'] ?? '');
$shiftId = intval($_POST['shift_id'] ?? 0);
$categoryId = intval($_POST['category_id'] ?? 0);
$reportId = intval($_POST['report_id'] ?? 0);

$allowedTables = [
    'dc_mcc_chemical_report',
    'dc_mcc_machine_report',
    'dc_mcc_report',
    'mcc_cleanliness_report',
    'mcc_intensive_chemical_report',
    'mcc_intensive_machine_report',
    'mcc_intensive_pantry_chemical_report',
    'mcc_intensive_pantry_machine_report',
    'mcc_intensive_pantry_report',
    'mcc_intensive_scorecard_2_report',
    'mcc_intensive_scorecard_report',
    'mcc_manpower_log',
    'mcc_normal_chemical_report',
    'mcc_normal_machine_report',
    'mcc_normal_scorecard_report',
    'mcc_photo_report',
    'mcc_prt_chemical_report',
    'mcc_prt_machine_report',
    'mcc_prt_scorecard_report',
    'mcc_surprise_reports',
    'mcc_vb_chemical_report',
    'mcc_vb_machine_report',
    'mcc_vb_scorecard_report'
];

if (!in_array($table, $allowedTables)) {
    echo json_encode([
        'success' => false,
        'message' => 'Invalid report table.'
    ]);
    exit;
}

try {
    if (!empty($tokenId)) {
        $stmt = $pdo->prepare("UPDATE `$table` SET isApproved = 1, audit_by = :audit_by WHERE token_id = :token_id AND station_id = :station_id");
        $stmt->execute([
            'audit_by'   => $currentUserId,
            'token_id'   => $tokenId,
            'station_id' => $stationId
        ]);
    } elseif ($table === 'mcc_manpower_log' && !empty($reportDate)) {
        $where = "report_date = :report_date AND station_id = :station_id";
        $params = [
            'audit_by'    => $currentUserId,
            'report_date' => $reportDate,
            'station_id'  => $stationId
        ];
        if ($categoryId > 0) {
            $where .= " AND category_id = :category_id";
            $params['category_id'] = $categoryId;
        }
        if ($shiftId > 0) {
            $where .= " AND shift_id = :shift_id";
            $params['shift_id'] = $shiftId;
        }
        $stmt = $pdo->prepare("UPDATE `$table` SET isApproved = 1, audit_by = :audit_by WHERE $where");
        $stmt->execute($params);
    } elseif ($reportId > 0) {
        $stmt = $pdo->prepare("UPDATE `$table` SET isApproved = 1, audit_by = :audit_by WHERE id = :id AND station_id = :station_id");
        $stmt->execute([
            'audit_by'   => $currentUserId,
            'id'         => $reportId,
            'station_id' => $stationId
        ]);
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'Missing report identifier.'
        ]);
        exit;
    }

    echo json_encode([
        'success' => true,
        'isApproved' => 1,
        'message' => 'Report approved successfully!'
    ]);
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Database error: ' . $e->getMessage()
    ]);
}
