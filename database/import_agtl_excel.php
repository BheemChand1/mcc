<?php
/**
 * Import Agartala (Station ID: 5) Employees from AGTL NEW MCC DOCUMENT 2026.xlsx
 */
require_once __DIR__ . '/../connection.php';
require_once __DIR__ . '/../cdo-dashboard/lib/SimpleXLSX.php';

$excelPath = __DIR__ . '/../AGTL NEW MCC DOCUMENT 2026.xlsx';
$stationId = 5;

if (!file_exists($excelPath)) {
    die("Error: File not found: {$excelPath}\n");
}

echo "=== IMPORTING AGARTALA EMPLOYEES (STATION ID: 5) ===\n\n";

// 1. Ensure designations exist for Station 5
echo "1. Ensuring designations (Supervisor, Janitor) exist for Station 5...\n";
$desStmt = $pdo->prepare("INSERT IGNORE INTO mcc_designation (station_id, designation_name, status) VALUES (?, ?, 'Active')");
$desStmt->execute([$stationId, 'Supervisor']);
$desStmt->execute([$stationId, 'Janitor']);
$desStmt->execute([$stationId, 'Unskilled']);
echo "   Done.\n\n";

// 2. Ensure custom fields exist for Station 5
echo "2. Ensuring custom fields exist in mcc_employee_custom_fields for Station 5...\n";
$customDefs = [
    ['label' => 'Category', 'key' => 'category', 'type' => 'select', 'options' => 'Skilled, Unskilled, Semi-Skilled', 'sort' => 10],
    ['label' => "Father's Name", 'key' => 'father_name', 'type' => 'text', 'options' => null, 'sort' => 20],
    ['label' => 'Date of Birth', 'key' => 'dob', 'type' => 'date', 'options' => null, 'sort' => 30],
    ['label' => 'Aadhar Number', 'key' => 'aadhar_number', 'type' => 'text', 'options' => null, 'sort' => 40],
    ['label' => 'Address', 'key' => 'address', 'type' => 'textarea', 'options' => null, 'sort' => 50],
    ['label' => 'PAN Card', 'key' => 'pan_card', 'type' => 'text', 'options' => null, 'sort' => 60]
];

$chkCf = $pdo->prepare("SELECT COUNT(*) FROM mcc_employee_custom_fields WHERE station_id = ? AND field_key = ?");
$insCf = $pdo->prepare("
    INSERT INTO mcc_employee_custom_fields 
    (station_id, field_label, field_key, field_type, field_options, sort_order, status)
    VALUES (?, ?, ?, ?, ?, ?, 'Active')
");

foreach ($customDefs as $c) {
    $chkCf->execute([$stationId, $c['key']]);
    if ($chkCf->fetchColumn() == 0) {
        $insCf->execute([$stationId, $c['label'], $c['key'], $c['type'], $c['options'], $c['sort']]);
        echo "   Added custom field: {$c['label']} ({$c['key']})\n";
    }
}
echo "   Done.\n\n";

// 3. Parse Excel file
echo "3. Parsing Excel file: {$excelPath}...\n";
if (!$xlsx = SimpleXLSX::parse($excelPath)) {
    die("Failed to parse Excel: " . SimpleXLSX::parseError() . "\n");
}

$rows = $xlsx->rows(0);
echo "   Total rows in sheet: " . count($rows) . "\n\n";

// Helper to clean and format DOB
function parseDateOfBirth($rawDob) {
    $dob = trim((string)$rawDob);
    if (empty($dob)) {
        return null;
    }

    // Replace commas with dots
    $dob = str_replace(',', '.', $dob);

    // Fix known human typo '12.02.19981' -> '12.02.1998'
    if (preg_match('/^(\d{1,2})\.(\d{1,2})\.19981$/', $dob, $m)) {
        return sprintf('1998-%02d-%02d', $m[2], $m[1]);
    }
    // Fix known human typo '21.132.1999' -> '21.12.1999'
    if (preg_match('/^(\d{1,2})\.132\.(\d{4})$/', $dob, $m)) {
        return sprintf('%s-12-%02d', $m[2], $m[1]);
    }

    // Standard DD.MM.YYYY, DD/MM/YYYY, DD-MM-YYYY
    if (preg_match('/^(\d{1,2})[\.\/\-](\d{1,2})[\.\/\-](\d{4})$/', $dob, $m)) {
        $day = intval($m[1]);
        $month = intval($m[2]);
        $year = intval($m[3]);
        if (checkdate($month, $day, $year)) {
            return sprintf('%04d-%02d-%02d', $year, $month, $day);
        }
    }

    return null;
}

// Helper to calculate age from DOB
function calculateAge($dobSql) {
    if (empty($dobSql)) return null;
    try {
        $bday = new DateTime($dobSql);
        $today = new DateTime('today');
        return $bday->diff($today)->y;
    } catch (Exception $e) {
        return null;
    }
}

// 4. Import / Upsert Rows
echo "4. Processing employee records...\n";

$inserted = 0;
$updated = 0;
$skipped = 0;

$checkStmt = $pdo->prepare("SELECT id FROM mcc_employee WHERE employee_id = ?");
$updateStmt = $pdo->prepare("
    UPDATE mcc_employee SET
        station_id = :station_id,
        full_name = :full_name,
        designation = :designation,
        father_name = :father_name,
        dob = :dob,
        age = :age,
        aadhar_number = :aadhar_number,
        address = :address,
        pan_card = :pan_card,
        status = 'Active',
        custom_data = :custom_data
    WHERE id = :id
");

$insertStmt = $pdo->prepare("
    INSERT INTO mcc_employee (
        station_id, employee_id, full_name, designation, father_name, 
        dob, age, aadhar_number, address, pan_card, status, custom_data
    ) VALUES (
        :station_id, :employee_id, :full_name, :designation, :father_name, 
        :dob, :age, :aadhar_number, :address, :pan_card, 'Active', :custom_data
    )
");

for ($i = 1; $i < count($rows); $i++) {
    $row = $rows[$i];
    $sl = trim($row[0] ?? '');
    $empId = trim($row[1] ?? '');
    $fullName = trim($row[2] ?? '');
    $designation = trim($row[3] ?? '');
    $category = trim($row[4] ?? '');
    $fatherName = trim($row[5] ?? '');
    $rawDob = trim($row[6] ?? '');
    $aadhar = trim($row[7] ?? '');
    $address = trim($row[8] ?? '');
    $pan = trim($row[9] ?? '');

    // Skip empty lines
    if (empty($empId) && empty($fullName)) {
        continue;
    }

    if (empty($empId)) {
        echo "   Row #{$i}: Skipped (Missing Employee ID)\n";
        $skipped++;
        continue;
    }

    $sqlDob = parseDateOfBirth($rawDob);
    $age = calculateAge($sqlDob);

    $customData = [
        'category' => $category,
        'father_name' => $fatherName,
        'dob' => $sqlDob ?: $rawDob,
        'raw_dob' => $rawDob,
        'aadhar_number' => $aadhar,
        'address' => $address,
        'pan_card' => $pan
    ];
    $customJson = json_encode($customData, JSON_UNESCAPED_UNICODE);

    $checkStmt->execute([$empId]);
    $existing = $checkStmt->fetch(PDO::FETCH_ASSOC);

    if ($existing) {
        $updateStmt->execute([
            'station_id' => $stationId,
            'full_name' => $fullName,
            'designation' => $designation,
            'father_name' => $fatherName,
            'dob' => $sqlDob,
            'age' => $age,
            'aadhar_number' => $aadhar,
            'address' => $address,
            'pan_card' => $pan,
            'custom_data' => $customJson,
            'id' => $existing['id']
        ]);
        $updated++;
        echo "   Updated [SL {$sl}]: {$empId} - {$fullName} ({$designation})\n";
    } else {
        $insertStmt->execute([
            'station_id' => $stationId,
            'employee_id' => $empId,
            'full_name' => $fullName,
            'designation' => $designation,
            'father_name' => $fatherName,
            'dob' => $sqlDob,
            'age' => $age,
            'aadhar_number' => $aadhar,
            'address' => $address,
            'pan_card' => $pan,
            'custom_data' => $customJson
        ]);
        $inserted++;
        echo "   Inserted [SL {$sl}]: {$empId} - {$fullName} ({$designation})\n";
    }
}

echo "\n=== IMPORT COMPLETED ===\n";
echo "Total Inserted: {$inserted}\n";
echo "Total Updated:  {$updated}\n";
echo "Total Skipped:  {$skipped}\n";

$finalCount = $pdo->prepare("SELECT COUNT(*) FROM mcc_employee WHERE station_id = ?");
$finalCount->execute([$stationId]);
echo "Total Active Employees for Station 5 (Agartala): " . $finalCount->fetchColumn() . "\n";
