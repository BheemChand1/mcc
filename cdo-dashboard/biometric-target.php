<?php
require_once 'auth.php';

// Database Migration & Table Setup for mcc_biometric_manpower_types and biometric_manpower_target
try {
    // 1. Ensure mcc_biometric_manpower_types table exists
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS `mcc_biometric_manpower_types` (
            `id` INT(11) NOT NULL AUTO_INCREMENT,
            `station_id` INT(11) NOT NULL DEFAULT 1,
            `role_name` VARCHAR(255) NOT NULL,
            `order_no` INT(11) NOT NULL DEFAULT 0,
            `status` ENUM('Active','Inactive') DEFAULT 'Active',
            `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            PRIMARY KEY (`id`),
            UNIQUE KEY `uq_station_role` (`station_id`, `role_name`),
            KEY `fk_bio_type_station` (`station_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
    ");

    // 2. Ensure initial seed data exists in mcc_biometric_manpower_types
    $checkTypes = $pdo->prepare("SELECT COUNT(*) FROM mcc_biometric_manpower_types WHERE station_id = :station_id");
    $checkTypes->execute(['station_id' => $stationId]);
    if ($checkTypes->fetchColumn() == 0) {
        // Seed from mcc_manpower_types if available, else default roles
        $pdo->exec("
            INSERT IGNORE INTO `mcc_biometric_manpower_types` (`station_id`, `role_name`, `order_no`, `status`)
            SELECT `station_id`, `role_name`, `order_no`, `status` FROM `mcc_manpower_types` WHERE `station_id` = " . intval($stationId) . ";
        ");
        
        $checkAgain = $pdo->prepare("SELECT COUNT(*) FROM mcc_biometric_manpower_types WHERE station_id = :station_id");
        $checkAgain->execute(['station_id' => $stationId]);
        if ($checkAgain->fetchColumn() == 0) {
            $pdo->exec("
                INSERT INTO `mcc_biometric_manpower_types` (`station_id`, `role_name`, `order_no`, `status`) VALUES
                (" . intval($stationId) . ", 'Unskilled', 1, 'Active'),
                (" . intval($stationId) . ", 'Supervisor', 2, 'Active'),
                (" . intval($stationId) . ", 'SemiSkilled', 3, 'Active');
            ");
        }
    }

    // 3. Ensure biometric_manpower_target table exists like mcc_manpower_targets
    $pdo->exec("
        CREATE TABLE IF NOT EXISTS `biometric_manpower_target` (
            `id` INT(11) NOT NULL AUTO_INCREMENT,
            `station_id` INT(11) NOT NULL DEFAULT 1,
            `category_id` INT(11) NOT NULL DEFAULT 0,
            `target_date` DATE NOT NULL,
            `manpower_type_id` INT(11) NOT NULL DEFAULT 0,
            `manpower_type` VARCHAR(255) NOT NULL DEFAULT '',
            `target_qty` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
            `is_coach_wise` TINYINT(1) NOT NULL DEFAULT 0,
            `effective_from` DATE NULL,
            `effective_to` DATE NULL,
            `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
            `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            PRIMARY KEY (`id`),
            UNIQUE KEY `uq_station_date_cat_type` (`station_id`, `target_date`, `category_id`, `manpower_type_id`),
            KEY `idx_station` (`station_id`),
            KEY `idx_target_date` (`target_date`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
    ");

    // 4. Check and add any missing columns in biometric_manpower_target
    $colStmt = $pdo->query("
        SELECT COLUMN_NAME 
        FROM information_schema.COLUMNS 
        WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'biometric_manpower_target'
    ");
    $columns = $colStmt->fetchAll(PDO::FETCH_COLUMN);

    if (!in_array('manpower_type_id', $columns)) {
        $pdo->exec("ALTER TABLE biometric_manpower_target ADD COLUMN manpower_type_id INT(11) NOT NULL DEFAULT 0 AFTER target_date");
    }
    if (!in_array('manpower_type', $columns)) {
        $pdo->exec("ALTER TABLE biometric_manpower_target ADD COLUMN manpower_type VARCHAR(255) NOT NULL DEFAULT '' AFTER manpower_type_id");
    }
    if (!in_array('is_coach_wise', $columns)) {
        $pdo->exec("ALTER TABLE biometric_manpower_target ADD COLUMN is_coach_wise TINYINT(1) NOT NULL DEFAULT 0 AFTER target_qty");
    }
    if (!in_array('effective_from', $columns)) {
        $pdo->exec("ALTER TABLE biometric_manpower_target ADD COLUMN effective_from DATE NULL AFTER is_coach_wise");
    }
    if (!in_array('effective_to', $columns)) {
        $pdo->exec("ALTER TABLE biometric_manpower_target ADD COLUMN effective_to DATE NULL AFTER effective_from");
    }

    // 5. Ensure unique key uq_station_date_cat_type
    try {
        $pdo->exec("ALTER TABLE biometric_manpower_target DROP INDEX `uq_station_cat_des_date`");
    } catch (Exception $e) {}
    try {
        $pdo->exec("ALTER TABLE biometric_manpower_target ADD UNIQUE KEY `uq_station_date_cat_type` (`station_id`, `target_date`, `category_id`, `manpower_type_id`)");
    } catch (Exception $e) {}

} catch (Exception $e) {
    // Migration exception logged quietly
}

// Target month & year selection
$selectedMonth = $_GET['month'] ?? date('m');
$selectedYear = $_GET['year'] ?? date('Y');

// Standardize
$selectedMonth = str_pad($selectedMonth, 2, '0', STR_PAD_LEFT);
$selectedYear = intval($selectedYear);

$targetMonthDate = $selectedYear . "-" . $selectedMonth . "-01";
$effectiveFromDate = $targetMonthDate;
$effectiveToDate = date('Y-m-t', strtotime($targetMonthDate));

// 1. Fetch active categories for the station from mcc_manpower_categories
$catStmt = $pdo->prepare("
    SELECT id, category_name 
    FROM mcc_manpower_categories 
    WHERE station_id = :station_id AND status = 'Active' 
    ORDER BY order_no ASC, id ASC
");
$catStmt->execute(['station_id' => $stationId]);
$categoriesList = $catStmt->fetchAll(PDO::FETCH_ASSOC);

// If no station-specific categories configured, fallback to standard categories
if (empty($categoriesList)) {
    $categoriesList = [
        ['id' => 17, 'category_name' => 'Normal Cleaning'],
        ['id' => 18, 'category_name' => 'Intensive Cleaning'],
        ['id' => 19, 'category_name' => 'Depot Cleaning'],
        ['id' => 20, 'category_name' => 'PRT Cleaning'],
        ['id' => 21, 'category_name' => 'Vande Bharat']
    ];
}

// 2. Fetch active biometric manpower types from mcc_biometric_manpower_types
$typesStmt = $pdo->prepare("
    SELECT id, role_name, order_no 
    FROM mcc_biometric_manpower_types 
    WHERE station_id = :station_id AND status = 'Active' 
    ORDER BY order_no ASC, id ASC
");
$typesStmt->execute(['station_id' => $stationId]);
$biometricTypes = $typesStmt->fetchAll(PDO::FETCH_ASSOC);

// If none found, fallback
if (empty($biometricTypes)) {
    $fallbackStmt = $pdo->query("SELECT id, role_name, order_no FROM mcc_biometric_manpower_types WHERE status = 'Active' ORDER BY order_no ASC, id ASC");
    $biometricTypes = $fallbackStmt->fetchAll(PDO::FETCH_ASSOC);
    if (empty($biometricTypes)) {
        $biometricTypes = [
            ['id' => 1, 'role_name' => 'Unskilled', 'order_no' => 1],
            ['id' => 2, 'role_name' => 'Supervisor', 'order_no' => 2]
        ];
    }
}

// Build role map (id => role_name)
$roleNamesMap = [];
foreach ($biometricTypes as $bt) {
    $roleNamesMap[$bt['id']] = $bt['role_name'];
}

$successMsg = '';
$errorMsg = '';

// Handle save post request
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['save_target'])) {
    if (!empty($isViewer)) {
        $errorMsg = "Viewers are in read-only mode and cannot save targets.";
    } else {
        $selectedMonth = $_POST['month'] ?? $selectedMonth;
        $selectedYear = $_POST['year'] ?? $selectedYear;
        $effectiveFromInput = !empty($_POST['effective_from']) ? $_POST['effective_from'] : $targetMonthDate;
        $effectiveToInput = !empty($_POST['effective_to']) ? $_POST['effective_to'] : date('Y-m-t', strtotime($targetMonthDate));
        
        if (!empty($selectedMonth) && !empty($selectedYear)) {
            $targetMonthDate = $selectedYear . "-" . str_pad($selectedMonth, 2, '0', STR_PAD_LEFT) . "-01";
            $submittedTargets = $_POST['target_qty'] ?? []; // [category_id][manpower_type_id] => qty
            $submittedCoachWise = $_POST['is_coach_wise'] ?? []; // [category_id][manpower_type_id] => 1
            
            $pdo->beginTransaction();
            try {
                // Delete existing biometric targets for this station and month
                $deleteStmt = $pdo->prepare("
                    DELETE FROM biometric_manpower_target 
                    WHERE station_id = :station_id AND target_date = :target_date
                ");
                $deleteStmt->execute([
                    'station_id' => $stationId,
                    'target_date' => $targetMonthDate
                ]);
                
                // Insert updated biometric manpower targets
                $insertStmt = $pdo->prepare("
                    INSERT INTO biometric_manpower_target 
                    (station_id, category_id, target_date, manpower_type_id, manpower_type, target_qty, is_coach_wise, effective_from, effective_to) 
                    VALUES (:station_id, :category_id, :target_date, :manpower_type_id, :manpower_type, :target_qty, :is_coach_wise, :effective_from, :effective_to)
                ");
                
                foreach ($categoriesList as $cat) {
                    $catId = $cat['id'];
                    foreach ($biometricTypes as $role) {
                        $tId = $role['id'];
                        $qty = floatval($submittedTargets[$catId][$tId] ?? 0);
                        $isCoachWise = isset($submittedCoachWise[$catId][$tId]) ? 1 : 0;
                        $roleName = $roleNamesMap[$tId] ?? $role['role_name'] ?? 'Staff';
                        
                        $insertStmt->execute([
                            'station_id' => $stationId,
                            'category_id' => $catId,
                            'target_date' => $targetMonthDate,
                            'manpower_type_id' => $tId,
                            'manpower_type' => $roleName,
                            'target_qty' => $qty,
                            'is_coach_wise' => $isCoachWise,
                            'effective_from' => $effectiveFromInput,
                            'effective_to' => $effectiveToInput
                        ]);
                    }
                }
                
                $pdo->commit();
                $successMsg = "Biometric manpower targets for " . date('F, Y', strtotime($targetMonthDate)) . " saved successfully!";
            } catch (Exception $e) {
                if ($pdo->inTransaction()) {
                    $pdo->rollBack();
                }
                $errorMsg = "Error saving biometric manpower targets: " . $e->getMessage();
            }
        }
    }
}

// Fetch existing target norms for the selected month
$targetsMap = [];
$coachWiseMap = [];
$effectiveFrom = $targetMonthDate;
$effectiveTo = date('Y-m-t', strtotime($targetMonthDate));

$targetsStmt = $pdo->prepare("
    SELECT category_id, manpower_type_id, target_qty, is_coach_wise, effective_from, effective_to
    FROM biometric_manpower_target 
    WHERE station_id = :station_id AND target_date = :target_date
");
$targetsStmt->execute([
    'station_id' => $stationId,
    'target_date' => $targetMonthDate
]);
$targetsRows = $targetsStmt->fetchAll(PDO::FETCH_ASSOC);

foreach ($targetsRows as $row) {
    $catId = intval($row['category_id']);
    $tId = intval($row['manpower_type_id']);
    $targetsMap[$catId][$tId] = $row['target_qty'];
    $coachWiseMap[$catId][$tId] = intval($row['is_coach_wise'] ?? 0);
    if (!empty($row['effective_from'])) $effectiveFrom = $row['effective_from'];
    if (!empty($row['effective_to'])) $effectiveTo = $row['effective_to'];
}

$pageTitle = 'Set Monthly Biometric Manpower Target | MCC';

$extraStyles = "
.sub-category {
    background:#f2f2f2 !important;
    font-weight:600;
    text-align:left !important;
}
.sub-category td {
    padding-left:18px !important;
    text-align:left !important;
    font-weight:700;
}
.target-input {
    width: 120px;
    padding: 6px 12px;
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    text-align: center;
    font-weight: 600;
    outline: none;
    font-size: 14px;
    transition: all 0.2s ease;
    height: 38px;
    background-color: #f8fafc;
}
.target-input:focus {
    border-color: #1987C6;
    background-color: #fff;
    box-shadow: 0 0 0 3px rgba(25, 135, 198, 0.15);
}
";

include 'header.php';
include 'sidebar.php';
?>

<style>
@media print {
    .app-header, 
    .app-sidebar, 
    .app-footer, 
    .no-print, 
    .report-filter,
    form.report-filter,
    div.no-print,
    .sidebar-overlay,
    .sidebar-backdrop,
    #sidebar-overlay {
        display: none !important;
        opacity: 0 !important;
        visibility: hidden !important;
        height: 0 !important;
        padding: 0 !important;
        margin: 0 !important;
    }
    
    html,
    body, 
    .bg-body-tertiary,
    .app-wrapper, 
    .app-main, 
    .app-content, 
    .container-fluid, 
    .report-wrap {
        margin: 0 !important;
        padding: 0 !important;
        width: 100% !important;
        max-width: 100% !important;
        background: #ffffff !important;
        background-color: #ffffff !important;
        box-shadow: none !important;
        border: none !important;
        height: auto !important;
    }
    
    .app-main {
        padding-top: 0 !important;
        margin-left: 0 !important;
    }
    
    .report-frame {
        border: none !important;
        box-shadow: none !important;
    }
    
    .table-responsive {
        overflow: visible !important;
        display: block !important;
    }
    
    .report-table thead th {
        background-color: #f1f5f9 !important;
        background: #f1f5f9 !important;
        -webkit-print-color-adjust: exact !important;
        print-color-adjust: exact !important;
    }
}
</style>

<main class="app-main">
    <div class="app-content">
        <div class="container-fluid" style="padding-top: 15px;">
            
            <!-- Filters & Navigation Bar -->
            <form class="report-filter no-print" method="GET" action="biometric-target.php" style="display: flex; justify-content: space-between; align-items: center; background: #fff; border: 1px solid #e2e8f0; padding: 12px 20px; border-radius: 8px; margin-bottom: 15px; box-shadow: 0 2px 4px rgba(0,0,0,0.04); flex-wrap: wrap; gap: 15px;">
                <div style="display: flex; align-items: center; gap: 12px;">
                    <label for="month" style="font-weight: 700; margin: 0; font-size: 14px; color: #334155; white-space: nowrap;">Target Month</label>
                    <select id="month" name="month" style="border: 1px solid #cbd5e1; border-radius: 6px; padding: 6px 12px; font-size: 14px; background-color: #f8fafc; color: #334155; width: 140px; cursor: pointer; height: 38px; outline: none;">
                        <?php
                        for ($m = 1; $m <= 12; $m++) {
                            $mVal = str_pad($m, 2, '0', STR_PAD_LEFT);
                            $mName = date('F', mktime(0, 0, 0, $m, 1));
                            $selected = ($mVal == $selectedMonth) ? 'selected' : '';
                            echo "<option value=\"$mVal\" $selected>$mName</option>";
                        }
                        ?>
                    </select>
                    
                    <select id="year" name="year" style="border: 1px solid #cbd5e1; border-radius: 6px; padding: 6px 12px; font-size: 14px; background-color: #f8fafc; color: #334155; width: 100px; cursor: pointer; height: 38px; outline: none;">
                        <?php
                        $currentYear = intval(date('Y'));
                        for ($y = $currentYear - 3; $y <= $currentYear + 2; $y++) {
                            $selected = ($y == $selectedYear) ? 'selected' : '';
                            echo "<option value=\"$y\" $selected>$y</option>";
                        }
                        ?>
                    </select>
                    <button type="submit" class="btn-go" style="background: #1987C6 !important; color: white !important; font-weight: 700; font-size: 14px; padding: 8px 24px; border-radius: 6px; border: none; cursor: pointer; height: 38px; display: inline-flex; align-items: center;">
                        Show
                    </button>
                </div>
                
                <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                    <a href="biometeric_manpower_log.php?from_date=<?= urlencode(date('Y-m-d', strtotime($targetMonthDate))) ?>&to_date=<?= urlencode(date('Y-m-t', strtotime($targetMonthDate))) ?>" class="btn-print" style="background: #4b5563 !important; color: white !important; text-decoration: none; padding: 8px 16px; border-radius: 6px; font-weight: 700; font-size: 14px; display: inline-flex; align-items: center; border: none; height: 38px;">
                        Back to Log
                    </a>
                    <button type="button" class="btn-print" onclick="window.print()" style="background: #15803d !important; color: white !important; padding: 8px 16px; border-radius: 6px; font-weight: 700; font-size: 14px; display: inline-flex; align-items: center; border: none; height: 38px;">
                        Print
                    </button>
                </div>
            </form>

            <?php if (!empty($successMsg)): ?>
                <div class="alert alert-success no-print" style="margin-bottom: 20px; border-radius: 8px; padding: 12px 20px; border: 1px solid #c3e6cb; background-color: #d4edda; color: #155724;">
                    <i class="bi bi-check-circle-fill me-2"></i> <?= htmlspecialchars($successMsg) ?>
                </div>
            <?php endif; ?>
            <?php if (!empty($errorMsg)): ?>
                <div class="alert alert-danger no-print" style="margin-bottom: 20px; border-radius: 8px; padding: 12px 20px; border: 1px solid #f5c6cb; background-color: #f8d7da; color: #721c24;">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> <?= htmlspecialchars($errorMsg) ?>
                </div>
            <?php endif; ?>

            <!-- Main Biometric Target Configurations Sheet -->
            <div class="report-wrap">
                <div class="report-frame">
                    <div class="report-header" style="text-align: center; margin-bottom: 15px;">
                        <h2 style="font-weight: 700; margin-bottom: 5px;">Biometric Manpower Target</h2>
                        <h3 style="font-size: 1.15rem; font-weight: 600; color: #334155; margin-bottom: 5px;"><?= htmlspecialchars($railwayName) ?></h3>
                        <p style="font-size: 0.95rem; color: #475569; margin-bottom: 15px;">Set monthly biometric manpower norms for cleaning and housekeeping contract at <?= htmlspecialchars($stationName) ?> Railway Station</p>
                    </div>

                    <div class="report-meta-section" style="border-top: 1px solid #cbd5e1; border-bottom: 1px solid #cbd5e1; padding: 10px 0; margin-bottom: 20px; font-weight: 600; text-align: center; font-size: 0.95rem;">
                        <span>Division: <strong style="color: #0f172a;"><?= htmlspecialchars($divisionName) ?></strong></span> &nbsp;&nbsp;|&nbsp;&nbsp;
                        <span>Station: <strong style="color: #0f172a;"><?= htmlspecialchars($stationName) ?></strong></span> &nbsp;&nbsp;|&nbsp;&nbsp;
                        <span>Effective From: <strong style="color: #0f172a;"><?= date('d-m-Y', strtotime($effectiveFrom)) ?></strong></span> &nbsp;&nbsp;|&nbsp;&nbsp;
                        <span>Effective Till: <strong style="color: #0f172a;"><?= date('d-m-Y', strtotime($effectiveTo)) ?></strong></span>
                    </div>

                    <?php if (empty($categoriesList) || empty($biometricTypes)): ?>
                        <div class="alert alert-info" style="margin: 20px 0; border-radius: 8px; padding: 12px 20px; border: 1px solid #bee5eb; background-color: #d1ecf1; color: #0c5460; text-align: center;">
                            <i class="bi bi-info-circle-fill me-2"></i> No active biometric manpower categories or types configured.
                        </div>
                    <?php else: ?>
                        <form method="POST" action="">
                            <input type="hidden" name="month" value="<?= htmlspecialchars($selectedMonth); ?>">
                            <input type="hidden" name="year" value="<?= htmlspecialchars($selectedYear); ?>">
                            
                            <div style="margin-bottom: 20px; display: flex; align-items: center; justify-content: center; gap: 20px; flex-wrap: wrap;" class="no-print">
                                <div style="display: flex; align-items: center; gap: 8px;">
                                    <label style="font-weight: 700; font-size: 14px; color: #334155; margin: 0;">Effective From:</label>
                                    <input type="date" name="effective_from" style="border: 1px solid #cbd5e1; border-radius: 6px; padding: 6px 12px; font-size: 14px; background-color: #f8fafc; color: #334155; width: 170px; height: 38px; outline: none;" value="<?= htmlspecialchars($effectiveFrom) ?>" required>
                                </div>
                                <div style="display: flex; align-items: center; gap: 8px;">
                                    <label style="font-weight: 700; font-size: 14px; color: #334155; margin: 0;">Effective Till:</label>
                                    <input type="date" name="effective_to" style="border: 1px solid #cbd5e1; border-radius: 6px; padding: 6px 12px; font-size: 14px; background-color: #f8fafc; color: #334155; width: 170px; height: 38px; outline: none;" value="<?= htmlspecialchars($effectiveTo) ?>" required>
                                </div>
                            </div>
                            
                            <div class="table-responsive">
                                <table class="report-table">
                                    <thead>
                                        <tr>
                                            <th style="text-align: left !important; padding-left: 25px !important;">Description</th>
                                            <th style="width: 170px; text-align: center !important;">Coach Wise</th>
                                            <th style="width: 250px; text-align: center !important;">Target</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach ($categoriesList as $cat): 
                                            $catId = $cat['id'];
                                        ?>
                                            <!-- Category Subheader -->
                                            <tr class="sub-category">
                                                <td colspan="3" style="text-align:center !important; padding-left:0 !important; text-transform: uppercase;">
                                                    <?= htmlspecialchars($cat['category_name']) ?>
                                                </td>
                                            </tr>

                                            <?php foreach ($biometricTypes as $role): 
                                                $tId = $role['id'];
                                                $rawTarget = $targetsMap[$catId][$tId] ?? '';
                                                if ($rawTarget !== '' && is_numeric($rawTarget)) {
                                                    $targetVal = (floatval($rawTarget) == intval($rawTarget)) ? intval($rawTarget) : floatval($rawTarget);
                                                } else {
                                                    $targetVal = '';
                                                }
                                                $isCoachWise = ($coachWiseMap[$catId][$tId] ?? 0) == 1;
                                            ?>
                                                <tr>
                                                    <td style="text-align: left !important; padding-left: 25px !important; font-weight: 500; color: #334155; vertical-align: middle;">
                                                        <?= htmlspecialchars($role['role_name']) ?>
                                                    </td>
                                                    <td style="text-align: center; vertical-align: middle;">
                                                        <label style="cursor: pointer; display: inline-flex; align-items: center; gap: 7px; font-weight: 600; font-size: 13.5px; color: #334155; margin: 0; user-select: none;">
                                                            <input type="checkbox" 
                                                                name="is_coach_wise[<?= $catId ?>][<?= $tId ?>]" 
                                                                value="1" 
                                                                <?= $isCoachWise ? 'checked' : '' ?> 
                                                                <?= !empty($isViewer) ? 'disabled' : '' ?>
                                                                style="cursor: pointer; width: 18px; height: 18px; accent-color: #1987C6;">
                                                            <span>Coach Wise</span>
                                                        </label>
                                                    </td>
                                                    <td style="text-align: center; vertical-align: middle;">
                                                        <input type="number" min="0" step="0.01" 
                                                            name="target_qty[<?= $catId ?>][<?= $tId ?>]" 
                                                            value="<?= htmlspecialchars($targetVal) ?>" 
                                                            class="target-input" <?= !empty($isViewer) ? 'readonly' : 'required' ?> placeholder="0">
                                                    </td>
                                                </tr>
                                            <?php endforeach; ?>
                                        <?php endforeach; ?>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Save Biometric Manpower Target Button -->
                            <div style="text-align: center; margin-top: 25px;" class="no-print">
                                <button type="submit" name="save_target" class="btn btn-primary" <?= !empty($isViewer) ? 'disabled title="Read-only mode: Viewers cannot save targets"' : '' ?> style="background-color: #1987C6; border: none; font-weight: 700; font-size: 15px; padding: 10px 30px; border-radius: 6px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); cursor: <?= !empty($isViewer) ? 'not-allowed' : 'pointer' ?>; opacity: <?= !empty($isViewer) ? '0.65' : '1' ?>;">
                                    <?= !empty($isViewer) ? '<i class="bi bi-lock-fill me-1"></i> Targets Locked (Read-Only)' : 'Save Biometric Manpower Target' ?>
                                </button>
                            </div>
                        </form>
                    <?php endif; ?>

                </div>
            </div>
        </div>
    </div>
</main>

<?php include 'footer.php'; ?>
