<?php
require_once 'auth.php';

// Target month & year selection
$selectedMonth = $_GET['month'] ?? date('m');
$selectedYear = $_GET['year'] ?? date('Y');

// Standardize
$selectedMonth = str_pad($selectedMonth, 2, '0', STR_PAD_LEFT);
$selectedYear = intval($selectedYear);

$targetMonthDate = $selectedYear . "-" . $selectedMonth . "-01";

// Fetch active shifts for this station (ordered by ID) - PRT
$shiftsStmt = $pdo->prepare("
    SELECT id AS shift_id, shift AS shift_name 
    FROM mcc_prt_machine_shifts 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$shiftsStmt->execute(['station_id' => $stationId]);
$shiftsList = $shiftsStmt->fetchAll();

// Fetch active machines for this station - PRT
$machinesStmt = $pdo->prepare("
    SELECT id AS machine_id, machine_no, machine_name 
    FROM mcc_prt_machine_param 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$machinesStmt->execute(['station_id' => $stationId]);
$machinesList = $machinesStmt->fetchAll();

$successMsg = '';
$errorMsg = '';

// Handle save post request - PRT
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['save_target'])) {
    $selectedMonth = $_POST['month'] ?? '';
    $selectedYear = $_POST['year'] ?? '';
    $effectiveFrom = $_POST['effective_from'] ?? '';
    
    if (empty($effectiveFrom) || !strtotime($effectiveFrom)) {
        $effectiveFrom = $selectedYear . "-" . str_pad($selectedMonth, 2, '0', STR_PAD_LEFT) . "-01";
    }

    if (!empty($selectedMonth) && !empty($selectedYear)) {
        $targetMonthDate = $selectedYear . "-" . str_pad($selectedMonth, 2, '0', STR_PAD_LEFT) . "-01";
        $penalties = $_POST['penalty'] ?? []; // machine_id => penalty_amount
        $nominations = $_POST['nomination'] ?? []; // machine_id => [shift_id => Y/N]
        
        $pdo->beginTransaction();
        try {
            // Prepare statements
            $findActiveStmt = $pdo->prepare("
                SELECT * FROM mcc_prt_machine_target 
                WHERE station_id = :station_id 
                  AND machine_id = :machine_id 
                  AND shift_id = :shift_id 
                  AND effective_to IS NULL
                LIMIT 1
            ");

            $closeActiveStmt = $pdo->prepare("
                UPDATE mcc_prt_machine_target 
                SET effective_to = :effective_to 
                WHERE id = :id
            ");

            $insertNewStmt = $pdo->prepare("
                INSERT INTO mcc_prt_machine_target 
                (station_id, machine_id, shift_id, nominated_area, penalty_amount, effective_from, effective_to) 
                VALUES (:station_id, :machine_id, :shift_id, :nominated_area, :penalty_amount, :effective_from, NULL)
            ");
            
            foreach ($machinesList as $mach) {
                $mId = $mach['machine_id'];
                $penalty = isset($penalties[$mId]) ? floatval($penalties[$mId]) : 0.00;
                
                foreach ($shiftsList as $shift) {
                    $sId = $shift['shift_id'];
                    $nom = $nominations[$mId][$sId] ?? 'N';
                    
                    // Find currently active target row for this machine and shift
                    $findActiveStmt->execute([
                        'station_id' => $stationId,
                        'machine_id' => $mId,
                        'shift_id' => $sId
                    ]);
                    $currentActive = $findActiveStmt->fetch(PDO::FETCH_ASSOC);
                    
                    $needsUpdate = false;
                    
                    if ($currentActive) {
                        $currNom = $currentActive['nominated_area'];
                        $currPenalty = floatval($currentActive['penalty_amount']);
                        
                        if ($currNom !== $nom || $currPenalty !== $penalty) {
                            $needsUpdate = true;
                            
                            // Close active row. Set effective_to to the day before effective_from
                            $effectiveToDate = date('Y-m-d', strtotime($effectiveFrom . ' - 1 day'));
                            if (strtotime($effectiveToDate) < strtotime($currentActive['effective_from'])) {
                                $effectiveToDate = $currentActive['effective_from'];
                            }
                            
                            $closeActiveStmt->execute([
                                'effective_to' => $effectiveToDate,
                                'id' => $currentActive['id']
                            ]);
                        }
                    } else {
                        // No active target row exists, insert one
                        $needsUpdate = true;
                    }
                    
                    if ($needsUpdate) {
                        $insertNewStmt->execute([
                            'station_id' => $stationId,
                            'machine_id' => $mId,
                            'shift_id' => $sId,
                            'nominated_area' => $nom,
                            'penalty_amount' => $penalty,
                            'effective_from' => $effectiveFrom
                        ]);
                    }
                }
            }
            
            $pdo->commit();
            $successMsg = "PRT Machine targets updated successfully starting from " . date('d-m-Y', strtotime($effectiveFrom)) . "!";
        } catch (Exception $e) {
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            $errorMsg = "Error saving PRT machine targets: " . $e->getMessage();
        }
    }
}

// Fetch existing targets active on the target date to populate inputs
$existingTargetsStmt = $pdo->prepare("
    SELECT machine_id, shift_id, nominated_area, penalty_amount 
    FROM mcc_prt_machine_target 
    WHERE station_id = :station_id
      AND :date_ref_1 >= effective_from
      AND (effective_to IS NULL OR :date_ref_2 <= effective_to)
");
$existingTargetsStmt->execute([
    'station_id' => $stationId,
    'date_ref_1' => $targetMonthDate,
    'date_ref_2' => $targetMonthDate
]);
$existingTargetsRows = $existingTargetsStmt->fetchAll();

$existingTargets = [];
foreach ($existingTargetsRows as $row) {
    $existingTargets[$row['machine_id']][$row['shift_id']] = [
        'nominated_area' => $row['nominated_area'],
        'penalty_amount' => $row['penalty_amount']
    ];
}

$pageTitle = 'Set Monthly PRT Machine Target | MCC';

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
.nomination-select {
    width: 65px;
    padding: 3px 6px;
    border: 1px solid #cbd5e1;
    border-radius: 4px;
    text-align: center;
    background-color: #fff;
    cursor: pointer;
    font-weight: 600;
    outline: none;
    font-size: 13px;
    height: 30px;
}
.nomination-select:focus {
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
    }
    body, .app-main, .app-content {
        margin: 0 !important;
        padding: 0 !important;
        background: #ffffff !important;
    }
    .machine-sheet {
        border: none !important;
        box-shadow: none !important;
        padding: 0 !important;
        margin: 0 !important;
    }
}
</style>

<main class="app-main">
    <div class="app-content py-4">
        <div class="container-fluid">
            
            <!-- Filter & Month Selector Form -->
            <div class="card shadow-sm border-0 mb-4 bg-white no-print">
                <div class="card-body p-3 col-md-10 mx-auto">
                    <form method="GET" action="Platform-Return-Machine-target.php" class="row g-3 align-items-center justify-content-center m-0">
                        <div class="col-auto">
                            <label class="form-label mb-0 fw-bold"><i class="bi bi-calendar3 me-1 text-primary"></i> Target Month:</label>
                        </div>
                        <div class="col-auto">
                            <select name="month" class="form-select form-select-sm" style="min-width: 120px;">
                                <?php
                                for ($m = 1; $m <= 12; $m++) {
                                    $mStr = str_pad($m, 2, '0', STR_PAD_LEFT);
                                    $selected = ($mStr === $selectedMonth) ? 'selected' : '';
                                    echo "<option value='$mStr' $selected>" . date('F', mktime(0, 0, 0, $m, 1)) . "</option>";
                                }
                                ?>
                            </select>
                        </div>
                        <div class="col-auto">
                            <label class="form-label mb-0 fw-bold">Year:</label>
                        </div>
                        <div class="col-auto">
                            <select name="year" class="form-select form-select-sm" style="min-width: 90px;">
                                <?php
                                $currYear = intval(date('Y'));
                                for ($y = $currYear - 5; $y <= $currYear + 5; $y++) {
                                    $selected = ($y === $selectedYear) ? 'selected' : '';
                                    echo "<option value='$y' $selected>$y</option>";
                                }
                                ?>
                            </select>
                        </div>
                        <div class="col-auto">
                            <button type="submit" class="btn btn-primary btn-sm px-3 fw-bold">
                                <i class="bi bi-arrow-right-circle me-1"></i> Load Target
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Messages -->
            <?php if (!empty($successMsg)): ?>
                <div class="alert alert-success alert-dismissible fade show no-print mx-auto col-md-10" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i> <?= htmlspecialchars($successMsg) ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <?php endif; ?>
            <?php if (!empty($errorMsg)): ?>
                <div class="alert alert-danger alert-dismissible fade show no-print mx-auto col-md-10" role="alert">
                    <i class="bi bi-exclamation-octagon-fill me-2"></i> <?= htmlspecialchars($errorMsg) ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <?php endif; ?>

            <div class="machine-sheet">
                <div class="d-flex align-items-center justify-content-between mb-3 border-bottom pb-3">
                    <h4 class="mb-0 fw-bold text-dark text-uppercase">
                        <i class="bi bi-gear-fill text-primary me-2"></i> PRT Machine Targets: <?= date('F Y', strtotime($targetMonthDate)) ?>
                    </h4>
                    <div class="no-print">
                        <a href="Platform-Return-Machine.php" class="btn btn-sm btn-outline-secondary fw-bold px-3 me-2">
                            <i class="bi bi-arrow-left"></i> Daily Machine Report
                        </a>
                        <button type="button" class="btn btn-sm btn-dark fw-bold px-3" onclick="window.print()">
                            <i class="bi bi-printer me-1"></i> Print
                        </button>
                    </div>
                </div>

                <form method="POST" action="Platform-Return-Machine-target.php?month=<?= $selectedMonth ?>&year=<?= $selectedYear ?>">
                    <input type="hidden" name="month" value="<?= htmlspecialchars($selectedMonth) ?>">
                    <input type="hidden" name="year" value="<?= htmlspecialchars($selectedYear) ?>">
                    
                    <div class="row g-3 mb-4 align-items-center no-print bg-light p-3 rounded border">
                        <div class="col-md-4">
                            <label class="form-label fw-bold mb-1"><i class="bi bi-calendar-check me-1 text-primary"></i> Target Change Effective Date:</label>
                            <input type="date" name="effective_from" class="form-control form-control-sm" required value="<?= htmlspecialchars($targetMonthDate) ?>">
                            <small class="text-muted">Set when these targets become active (defaults to start of month).</small>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="report-table">
                            <thead>
                                <tr>
                                    <th style="width: 50px;">S.No</th>
                                    <th style="width: 150px;">Machine ID</th>
                                    <th style="text-align: left; padding-left: 15px;">Machine Name</th>
                                    <th style="width: 140px;">Penalty Amount (₹)</th>
                                    <?php foreach ($shiftsList as $shift): ?>
                                        <th style="width: 120px;"><?= htmlspecialchars($shift['shift_name']) ?> Area</th>
                                    <?php endforeach; ?>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if (empty($machinesList)): ?>
                                    <tr>
                                        <td colspan="<?= 4 + count($shiftsList) ?>" class="text-center py-4 text-muted">
                                            No machines parameter configuration registered.
                                        </td>
                                    </tr>
                                <?php else: ?>
                                    <?php 
                                    $serial = 1;
                                    foreach ($machinesList as $mach): 
                                        $mId = $mach['machine_id'];
                                        // Pick the penalty amount from any of the shifts for this machine (assumed uniform)
                                        $penaltyVal = 0.00;
                                        foreach ($shiftsList as $shift) {
                                            $sId = $shift['shift_id'];
                                            if (isset($existingTargets[$mId][$sId]['penalty_amount'])) {
                                                $penaltyVal = floatval($existingTargets[$mId][$sId]['penalty_amount']);
                                                break;
                                            }
                                        }
                                    ?>
                                        <tr>
                                            <td class="text-center font-weight-bold"><?= $serial++ ?></td>
                                            <td class="text-center font-weight-bold"><?= htmlspecialchars($mach['machine_no']) ?></td>
                                            <td class="text-left"><?= htmlspecialchars($mach['machine_name']) ?></td>
                                            <td class="text-center">
                                                <input type="number" step="0.01" min="0" name="penalty[<?= $mId ?>]" 
                                                       value="<?= number_format($penaltyVal, 2, '.', '') ?>" class="penalty-input form-control form-control-sm">
                                            </td>
                                            <?php foreach ($shiftsList as $shift): 
                                                $sId = $shift['shift_id'];
                                                $nom = $existingTargets[$mId][$sId]['nominated_area'] ?? 'N';
                                            ?>
                                                <td class="text-center">
                                                    <select name="nomination[<?= $mId ?>][<?= $sId ?>]" class="nomination-select form-select form-select-sm">
                                                        <option value="Y" <?= $nom === 'Y' ? 'selected' : '' ?>>Y</option>
                                                        <option value="N" <?= $nom === 'N' ? 'selected' : '' ?>>N</option>
                                                    </select>
                                                </td>
                                            <?php endforeach; ?>
                                        </tr>
                                    <?php endforeach; ?>
                                <?php endif; ?>
                            </tbody>
                        </table>
                    </div>

                    <div class="mt-4 text-center no-print">
                        <button type="submit" name="save_target" class="btn btn-success fw-bold px-4 py-2">
                            <i class="bi bi-save me-1"></i> Save Machine Targets
                        </button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</main>

<?php include 'footer.php'; ?>
