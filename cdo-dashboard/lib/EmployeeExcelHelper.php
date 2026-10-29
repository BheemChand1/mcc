<?php
require_once __DIR__ . '/SimpleXLSX.php';

class EmployeeExcelHelper {

    /**
     * Get all active fields for a given station (Default + Custom)
     */
    public static function getStationFields($pdo, $stationId) {
        $fields = [
            [
                'key' => 'employee_id',
                'label' => 'Employee ID',
                'required' => true,
                'is_default' => true,
                'sample' => 'EMP1001'
            ],
            [
                'key' => 'full_name',
                'label' => 'Full Name',
                'required' => true,
                'is_default' => true,
                'sample' => 'Ramesh Kumar'
            ],
            [
                'key' => 'designation',
                'label' => 'Designation',
                'required' => true,
                'is_default' => true,
                'sample' => 'Supervisor'
            ]
        ];

        try {
            $stmt = $pdo->prepare("
                SELECT field_label, field_key, field_type, field_options, placeholder, is_required 
                FROM mcc_employee_custom_fields 
                WHERE station_id = :station_id AND status = 'Active' 
                ORDER BY sort_order ASC, id ASC
            ");
            $stmt->execute(['station_id' => $stationId]);
            $customs = $stmt->fetchAll(PDO::FETCH_ASSOC);

            foreach ($customs as $c) {
                // Determine sensible sample data based on field_type / field_key
                $sample = 'Sample ' . $c['field_label'];
                if ($c['field_type'] === 'number') $sample = '12345';
                elseif ($c['field_type'] === 'date') $sample = date('Y-m-d');
                elseif (stripos($c['field_key'], 'mobile') !== false) $sample = '9876543210';
                elseif (stripos($c['field_key'], 'aadhar') !== false) $sample = '1234-5678-9012';
                elseif (stripos($c['field_key'], 'age') !== false) $sample = '28';
                elseif (!empty($c['field_options'])) {
                    $opts = array_map('trim', explode(',', $c['field_options']));
                    $sample = $opts[0] ?? '';
                }

                $fields[] = [
                    'key' => $c['field_key'],
                    'label' => $c['field_label'],
                    'required' => (bool)$c['is_required'],
                    'is_default' => false,
                    'sample' => $sample
                ];
            }
        } catch (Exception $e) {
            // Log or ignore
        }

        return $fields;
    }

    /**
     * Parse an uploaded file (XLSX or CSV) into rows
     */
    public static function parseUploadedFile($filePath, $fileName) {
        $ext = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));

        if ($ext === 'xlsx') {
            if ($xlsx = SimpleXLSX::parse($filePath)) {
                return $xlsx->rows();
            } else {
                throw new Exception('Failed to read Excel (.xlsx) file: ' . SimpleXLSX::parseError());
            }
        } elseif ($ext === 'csv' || $ext === 'txt') {
            $rows = [];
            if (($handle = fopen($filePath, 'r')) !== false) {
                // Handle potential UTF-8 BOM
                $bom = fread($handle, 3);
                if ($bom !== "\xEF\xBB\xBF") {
                    rewind($handle);
                }
                while (($data = fgetcsv($handle, 4096, ',')) !== false) {
                    $rows[] = $data;
                }
                fclose($handle);
            }
            return $rows;
        } else {
            throw new Exception('Unsupported file type. Please upload a .xlsx or .csv file.');
        }
    }

    /**
     * Import parsed rows into database
     */
    public static function importRows($pdo, $stationId, array $rows, $updateExisting = false) {
        if (empty($rows) || count($rows) < 2) {
            throw new Exception('The uploaded file is empty or missing data rows.');
        }

        $stationFields = self::getStationFields($pdo, $stationId);

        // Header mapping
        $headerRow = array_map(function($v) {
            return strtolower(trim(preg_replace('/[^a-zA-Z0-9_]/', '', (string)$v)));
        }, $rows[0]);

        $colMap = []; // index => field_key
        foreach ($stationFields as $field) {
            $normalizedKey = strtolower(trim(preg_replace('/[^a-zA-Z0-9_]/', '', $field['key'])));
            $normalizedLabel = strtolower(trim(preg_replace('/[^a-zA-Z0-9_]/', '', $field['label'])));

            foreach ($headerRow as $idx => $headerVal) {
                if ($headerVal === $normalizedKey || $headerVal === $normalizedLabel) {
                    $colMap[$idx] = $field['key'];
                    break;
                }
            }
        }

        // Check if mandatory default fields are present in headers
        $mappedKeys = array_values($colMap);
        if (!in_array('employee_id', $mappedKeys)) {
            throw new Exception("Column 'Employee ID' is missing from the file headers.");
        }
        if (!in_array('full_name', $mappedKeys)) {
            throw new Exception("Column 'Full Name' is missing from the file headers.");
        }

        // Get table columns in mcc_employee to know which columns exist directly
        $existingCols = [];
        try {
            $colStmt = $pdo->query("SHOW COLUMNS FROM mcc_employee");
            while ($c = $colStmt->fetch(PDO::FETCH_ASSOC)) {
                $existingCols[] = $c['Field'];
            }
        } catch (Exception $e) {}

        $totalRows = count($rows) - 1;
        $importedCount = 0;
        $updatedCount = 0;
        $skippedCount = 0;
        $errors = [];

        // Check station designations to match or fallback
        $desStmt = $pdo->prepare("SELECT designation_name FROM mcc_designation WHERE (station_id = ? OR station_id = 0) AND status = 'Active'");
        $desStmt->execute([$stationId]);
        $validDesignations = $desStmt->fetchAll(PDO::FETCH_COLUMN) ?: ['Supervisor', 'Unskilled'];

        // Begin Processing Rows
        for ($i = 1; $i < count($rows); $i++) {
            $rowNum = $i + 1;
            $row = $rows[$i];

            // If empty row, skip
            if (empty(array_filter($row, fn($val) => trim((string)$val) !== ''))) {
                continue;
            }

            $rowData = [];
            foreach ($colMap as $colIdx => $fieldKey) {
                $val = isset($row[$colIdx]) ? trim((string)$row[$colIdx]) : '';
                $rowData[$fieldKey] = $val;
            }

            $empId = trim($rowData['employee_id'] ?? '');
            $fullName = trim($rowData['full_name'] ?? '');
            $designation = trim($rowData['designation'] ?? '');

            if (empty($empId)) {
                $errors[] = "Row #{$rowNum}: Employee ID is blank. Skipped.";
                $skippedCount++;
                continue;
            }
            if (empty($fullName)) {
                $errors[] = "Row #{$rowNum} (ID: {$empId}): Full Name is blank. Skipped.";
                $skippedCount++;
                continue;
            }
            if (empty($designation)) {
                $designation = $validDesignations[0] ?? 'Unskilled';
            }

            // Check if employee exists
            $checkStmt = $pdo->prepare("SELECT id, custom_data FROM mcc_employee WHERE employee_id = ?");
            $checkStmt->execute([$empId]);
            $existingEmp = $checkStmt->fetch(PDO::FETCH_ASSOC);

            // Separate default fields from custom fields
            $customData = [];
            $columnUpdates = [];

            foreach ($rowData as $k => $v) {
                if (in_array($k, ['employee_id', 'full_name', 'designation'])) {
                    continue;
                }
                $customData[$k] = $v;
                if (in_array($k, $existingCols)) {
                    $columnUpdates[$k] = $v;
                }
            }

            try {
                if ($existingEmp) {
                    if (!$updateExisting) {
                        $skippedCount++;
                        continue;
                    }

                    // Merge existing custom_data if present
                    $prevCustom = !empty($existingEmp['custom_data']) ? json_decode($existingEmp['custom_data'], true) : [];
                    if (!is_array($prevCustom)) $prevCustom = [];
                    $mergedCustom = array_merge($prevCustom, $customData);

                    $setClauses = [
                        "`station_id` = :station_id",
                        "`full_name` = :full_name",
                        "`designation` = :designation",
                        "`custom_data` = :custom_data"
                    ];
                    $params = [
                        'station_id' => $stationId,
                        'full_name' => $fullName,
                        'designation' => $designation,
                        'custom_data' => json_encode($mergedCustom, JSON_UNESCAPED_UNICODE),
                        'id' => $existingEmp['id']
                    ];

                    foreach ($columnUpdates as $colName => $colVal) {
                        $setClauses[] = "`{$colName}` = :{$colName}";
                        $params[$colName] = $colVal;
                    }

                    $updateSql = "UPDATE mcc_employee SET " . implode(', ', $setClauses) . " WHERE id = :id";
                    $updStmt = $pdo->prepare($updateSql);
                    $updStmt->execute($params);
                    $updatedCount++;
                } else {
                    // Insert
                    $insertCols = ['station_id', 'employee_id', 'full_name', 'designation', 'custom_data'];
                    $insertPlaceholders = [':station_id', ':employee_id', ':full_name', ':designation', ':custom_data'];
                    $params = [
                        'station_id' => $stationId,
                        'employee_id' => $empId,
                        'full_name' => $fullName,
                        'designation' => $designation,
                        'custom_data' => json_encode($customData, JSON_UNESCAPED_UNICODE)
                    ];

                    foreach ($columnUpdates as $colName => $colVal) {
                        $insertCols[] = "`{$colName}`";
                        $insertPlaceholders[] = ":{$colName}";
                        $params[$colName] = $colVal;
                    }

                    $insertSql = "INSERT INTO mcc_employee (" . implode(', ', $insertCols) . ") VALUES (" . implode(', ', $insertPlaceholders) . ")";
                    $insStmt = $pdo->prepare($insertSql);
                    $insStmt->execute($params);
                    $importedCount++;
                }
            } catch (Exception $e) {
                $errors[] = "Row #{$rowNum} (ID: {$empId}): " . $e->getMessage();
                $skippedCount++;
            }
        }

        return [
            'total' => $totalRows,
            'imported' => $importedCount,
            'updated' => $updatedCount,
            'skipped' => $skippedCount,
            'errors' => $errors
        ];
    }

    /**
     * Output a download for CSV template
     */
    public static function downloadTemplateCsv($pdo, $stationId, $stationName = 'Station') {
        $fields = self::getStationFields($pdo, $stationId);

        $headers = [];
        $sampleRow = [];

        foreach ($fields as $f) {
            $req = $f['required'] ? '*' : '';
            $headers[] = $f['label'] . ($req ? " ({$req})" : "");
            $sampleRow[] = $f['sample'];
        }

        $filename = 'employee_import_template_' . preg_replace('/[^a-zA-Z0-9_-]/', '_', strtolower($stationName)) . '.csv';

        header('Content-Type: text/csv; charset=utf-8');
        header('Content-Disposition: attachment; filename="' . $filename . '"');
        header('Pragma: no-cache');
        header('Expires: 0');

        $output = fopen('php://output', 'w');
        // Add UTF-8 BOM for Excel compatibility
        fprintf($output, chr(0xEF).chr(0xBB).chr(0xBF));

        fputcsv($output, $headers);
        fputcsv($output, $sampleRow);
        fclose($output);
        exit;
    }
}
