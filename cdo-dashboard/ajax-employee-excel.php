<?php
/**
 * CDO Dashboard - Employee Excel/CSV Import and Template Download Handler
 */
require_once 'auth.php';
require_once __DIR__ . '/lib/EmployeeExcelHelper.php';

$action = $_REQUEST['action'] ?? '';

// 1. Download Sample CSV Template
if ($action === 'download_template') {
    EmployeeExcelHelper::downloadTemplateCsv($pdo, $stationId, $stationName);
    exit;
}

// 2. Import Excel or CSV
if ($action === 'import_excel' && $_SERVER['REQUEST_METHOD'] === 'POST') {
    header('Content-Type: application/json');

    if (!isset($_FILES['excel_file']) || $_FILES['excel_file']['error'] !== UPLOAD_ERR_OK) {
        $errorCode = $_FILES['excel_file']['error'] ?? 'No file';
        echo json_encode(['success' => false, 'message' => 'Please select a valid Excel (.xlsx) or CSV file. (Error: ' . $errorCode . ')']);
        exit;
    }

    $tmpPath = $_FILES['excel_file']['tmp_name'];
    $origName = $_FILES['excel_file']['name'];
    $updateExisting = !empty($_POST['update_existing']);

    try {
        $rows = EmployeeExcelHelper::parseUploadedFile($tmpPath, $origName);
        $result = EmployeeExcelHelper::importRows($pdo, $stationId, $rows, $updateExisting);

        $msg = "Import completed successfully! ";
        $msg .= "Added: {$result['imported']}, Updated: {$result['updated']}, Skipped: {$result['skipped']}.";

        if (!empty($result['errors'])) {
            $msg .= " (Note: " . count($result['errors']) . " rows had warnings/errors).";
        }

        echo json_encode([
            'success' => true,
            'message' => $msg,
            'stats' => $result
        ]);
        exit;
    } catch (Exception $e) {
        echo json_encode([
            'success' => false,
            'message' => $e->getMessage()
        ]);
        exit;
    }
}

echo json_encode(['success' => false, 'message' => 'Invalid action.']);
exit;
