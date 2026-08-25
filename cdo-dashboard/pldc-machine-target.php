<?php
require_once 'auth.php';

// Target month & year selection
$selectedMonth = $_GET['month'] ?? date('m');
$selectedYear = $_GET['year'] ?? date('Y');

// Standardize
$selectedMonth = str_pad($selectedMonth, 2, '0', STR_PAD_LEFT);
$selectedYear = intval($selectedYear);

$targetMonthDate = $selectedYear . "-" . $selectedMonth . "-01";

// Fetch active shifts for this station - PLDC
$shiftsStmt = $pdo->prepare("
    SELECT id AS shift_id, shift AS shift_name 
    FROM mcc_pldc_machine_shifts 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$shiftsStmt->execute(['station_id' => $stationId]);
$shiftsList = $shiftsStmt->fetchAll();

// Fetch active machines for this station - PLDC
$machinesStmt = $pdo->prepare("
    SELECT id AS machine_id, machine_no, machine_name 
    FROM mcc_pldc_machine_param 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$machinesStmt->execute(['station_id' => $stationId]);
$machinesList = $machinesStmt->fetchAll();

$successMsg = '';
$errorMsg = '';

// Handle save post request
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['save_target'])) {
    $selectedMonth = $_POST['month'] ?? '';
    $selectedYear = $_POST['year'] ?? '';
    if (!empty($selectedMonth) && !empty($selectedYear)) {
        $targetMonthDate = $selectedYear . "-" . str_pad($selectedMonth, 2, '0', STR_PAD_LEFT) . "-01";
        $penalties = $_POST['penalty'] ?? []; // machine_id => penalty_amount
        $nominations = $_POST['nomination'] ?? []; // machine_id => [shift_id => text]
        
        $pdo->beginTransaction();
        try {
            // Delete existing machine targets for this station and month - PLDC
            $deleteStmt = $pdo->prepare("
                DELETE FROM mcc_pldc_machine_target 
                WHERE station_id = :station_id AND target_month = :target_month
            ");
            $deleteStmt->execute([
                'station_id' => $stationId,
                'target_month' => $targetMonthDate
            ]);
            
            // Insert updated machine targets - PLDC
            $insertStmt = $pdo->prepare("
                INSERT INTO mcc_pldc_machine_target 
                (station_id, machine_id, target_month, shift_id, nominated_area, penalty_amount) 
                VALUES (:station_id, :machine_id, :target_month, :shift_id, :nominated_area, :penalty_amount)
            ");
            
            foreach ($machinesList as $mach) {
                $mId = $mach['machine_id'];
                $penalty = isset($penalties[$mId]) ? floatval($penalties[$mId]) : 0.00;
                
                foreach ($shiftsList as $shift) {
                    $sId = $shift['shift_id'];
                    $nom = isset($nominations[$mId][$sId]) ? trim($nominations[$mId][$sId]) : '';
                    if ($nom === '') {
                        $nom = 'N'; // default to 'N' if empty
                    }
                    
                    $insertStmt->execute([
                        'station_id' => $stationId,
                        'machine_id' => $mId,
                        'target_month' => $targetMonthDate,
                        'shift_id' => $sId,
                        'nominated_area' => $nom,
                        'penalty_amount' => $penalty
                    ]);
                }
            }
            
            $pdo->commit();
            $successMsg = "Machine targets for " . date('F, Y', strtotime($targetMonthDate)) . " saved successfully!";
        } catch (Exception $e) {
            $pdo->rollBack();
            $errorMsg = "Error saving machine targets: " . $e->getMessage();
        }
    }
}

// Fetch existing targets for the selected month to populate inputs - PLDC
$existingTargetsStmt = $pdo->prepare("
    SELECT machine_id, shift_id, nominated_area, penalty_amount 
    FROM mcc_pldc_machine_target 
    WHERE station_id = :station_id AND target_month = :target_month
");
$existingTargetsStmt->execute([
    'station_id' => $stationId,
    'target_month' => $targetMonthDate
]);
$existingTargetsRows = $existingTargetsStmt->fetchAll();

$existingTargets = [];
foreach ($existingTargetsRows as $row) {
    $existingTargets[$row['machine_id']][$row['shift_id']] = [
        'nominated_area' => $row['nominated_area'],
        'penalty_amount' => $row['penalty_amount']
    ];
}

$pageTitle = 'Set Monthly Machine Target (PLDC) | MCC';

$extraStyles = "
.machine-sheet {
    background: #ffffff !important;
    border: 1px solid #cbd5e1 !important;
    padding: 20px !important;
    width: 100% !important;
    max-width: 1300px !important;
    margin: 10px auto 30px auto !important;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05) !important;
    border-radius: 8px !important;
}
.report-table {
    width: 100% !important;
    border-collapse: collapse !important;
    margin-top: 15px !important;
}
.report-table th {
    background: linear-gradient(180deg, #1987C6 0%, #146ea3 100%) !important;
    color: white !important;
    font-weight: 700 !important;
    text-align: center !important;
    padding: 6px 8px !important;
    font-size: 13px !important;
    border: 1px solid #cbd5e1 !important;
}
.report-table td {
    padding: 6px 8px !important;
    font-size: 13px !important;
    border: 1px solid #cbd5e1 !important;
}
.report-table td.text-left {
    text-align: left !important;
    padding-left: 12px !important;
}
.penalty-input {
    width: 80px;
    padding: 3px 6px;
    border: 1px solid #cbd5e1;
    border-radius: 4px;
    text-align: center;
    font-weight: 600;
    outline: none;
    font-size: 13px;
    transition: all 0.2s ease;
    height: 30px;
}
.penalty-input:focus {
    border-color: #3b82f6;
    box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2);
}
.nomination-text-input {
    width: 120px;
    padding: 3px 6px;
    border: 1px solid #cbd5e1;
    border-radius: 4px;
    text-align: center;
    font-weight: 600;
    outline: none;
    font-size: 13px;
    height: 30px;
}
.nomination-text-input:focus {
    border-color: #3b82f6;
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
    .machine-sheet {
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
    
    .machine-sheet {
        border: none !important;
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
            
            <form class="report-filter no-print" method="GET" style="display: flex; justify-content: space-between; align-items: center; background: #fff; border: 1px solid #e2e8f0; padding: 12px 20px; border-radius: 8px; margin-bottom: 15px; box-shadow: 0 2px 4px rgba(0,0,0,0.04); flex-wrap: wrap; gap: 15px;">
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
                    <a href="pldc-machine.php" class="btn-print" style="background: #4b5563 !important; color: white !important; text-decoration: none; padding: 8px 16px; border-radius: 6px; font-weight: 700; font-size: 14px; display: inline-flex; align-items: center; border: none; height: 38px;">
                        Machine Report (PLDC)
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

            <div class="machine-sheet">
                
                <?php if (empty($machinesList)): ?>
                    <div class="alert alert-info" style="margin: 20px 0; border-radius: 8px; padding: 12px 20px; border: 1px solid #bee5eb; background-color: #d1ecf1; color: #0c5460; text-align: center;">
                        <i class="bi bi-info-circle-fill me-2"></i> No machines registered for this station.
                    </div>
                <?php else: ?>
                    <form method="POST" action="">
                        <input type="hidden" name="month" value="<?= htmlspecialchars($selectedMonth); ?>">
                        <input type="hidden" name="year" value="<?= htmlspecialchars($selectedYear); ?>">
                        
                        <div class="table-responsive">
                            <table class="report-table">
                                <thead>
                                    <tr>
                                        <th rowspan="2" style="width: 50px;">S.No</th>
                                        <th rowspan="2" style="width: 130px;">Machine No</th>
                                        <th rowspan="2" style="text-align: left; padding-left: 15px;">Name of Machines</th>
                                        <th rowspan="2" style="width: 130px;">Penalty</th>
                                        <th colspan="<?= max(1, count($shiftsList)) ?>">Nominated Work Area for Each Machine</th>
                                    </tr>
                                    <tr>
                                        <?php if (empty($shiftsList)): ?>
                                            <th style="width: 150px;">Shifts</th>
                                        <?php else: ?>
                                            <?php foreach ($shiftsList as $shift): ?>
                                                <th style="width: 150px;"><?= htmlspecialchars($shift['shift_name']) ?></th>
                                            <?php endforeach; ?>
                                        <?php endif; ?>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php 
                                    $serial = 1;
                                    foreach ($machinesList as $mach): 
                                        $mId = $mach['machine_id'];
                                        $firstShiftId = !empty($shiftsList) ? $shiftsList[0]['shift_id'] : 0;
                                        $penaltyVal = isset($existingTargets[$mId][$firstShiftId]['penalty_amount']) 
                                            ? floatval($existingTargets[$mId][$firstShiftId]['penalty_amount']) 
                                            : '';
                                        
                                        if ($penaltyVal !== '' && $penaltyVal == intval($penaltyVal)) {
                                            $penaltyVal = intval($penaltyVal);
                                        }
                                    ?>
                                        <tr>
                                            <td><?= $serial++ ?></td>
                                            <td><strong><?= htmlspecialchars($mach['machine_no']) ?></strong></td>
                                            <td class="text-left"><?= htmlspecialchars($mach['machine_name']) ?></td>
                                            <td>
                                                <input type="number" step="1" min="0" name="penalty[<?= $mId ?>]" 
                                                    value="<?= htmlspecialchars($penaltyVal) ?>" 
                                                    class="penalty-input" required placeholder="0">
                                            </td>
                                            
                                            <?php if (empty($shiftsList)): ?>
                                                <td>-</td>
                                            <?php else: ?>
                                                <?php foreach ($shiftsList as $shift): 
                                                    $sId = $shift['shift_id'];
                                                    $nomVal = $existingTargets[$mId][$sId]['nominated_area'] ?? '';
                                                    if ($nomVal === 'N') {
                                                        $nomVal = '';
                                                    }
                                                ?>
                                                    <td>
                                                        <input type="text" name="nomination[<?= $mId ?>][<?= $sId ?>]" 
                                                            value="<?= htmlspecialchars($nomVal) ?>" 
                                                            class="nomination-text-input" placeholder="e.g. Pit Line 1">
                                                    </td>
                                                <?php endforeach; ?>
                                            <?php endif; ?>
                                        </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>

                        <div style="text-align: center; margin-top: 25px;" class="no-print">
                            <button type="submit" name="save_target" class="btn btn-primary" style="background-color: #007bff; border: none; font-weight: 700; font-size: 15px; padding: 10px 30px; border-radius: 6px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); cursor: pointer; transition: all 0.2s ease;">
                                Save Target
                            </button>
                        </div>
                    </form>
                <?php endif; ?>

            </div>
        </div>
    </div>
</main>

<?php include 'footer.php'; ?>
