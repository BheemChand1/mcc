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
    $auditBy = $currentUserId ?: ($_SESSION['user_id'] ?? null);

    if (!empty($tokenId)) {
        // Simple and robust: update all rows matching this token_id
        $stmt = $pdo->prepare("UPDATE `$table` SET isApproved = 1, audit_by = :audit_by WHERE token_id = :token_id");
        $stmt->execute([
            'audit_by' => $auditBy,
            'token_id' => $tokenId
        ]);
    } elseif (!empty($reportDate)) {
        $where = "report_date = :report_date";
        $params = [
            'audit_by'    => $auditBy,
            'report_date' => $reportDate
        ];
        if ($stationId) {
            $where .= " AND station_id = :station_id";
            $params['station_id'] = $stationId;
        }
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
        $stmt = $pdo->prepare("UPDATE `$table` SET isApproved = 1, audit_by = :audit_by WHERE id = :id");
        $stmt->execute([
            'audit_by' => $auditBy,
            'id'       => $reportId
        ]);
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'Missing report token_id or identifier.'
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
