<?php
require_once 'auth.php';

// Target month & year selection
$selectedMonth = $_GET['month'] ?? date('m');
$selectedYear = $_GET['year'] ?? date('Y');

// Standardize
$selectedMonth = str_pad($selectedMonth, 2, '0', STR_PAD_LEFT);
$selectedYear = intval($selectedYear);

$targetMonthDate = $selectedYear . "-" . $selectedMonth . "-01";

$successMsg = '';
$errorMsg = '';

// Handle save post request
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['save_targets'])) {
    $selectedMonth = $_POST['month'] ?? '';
    $selectedYear = $_POST['year'] ?? '';
    if (!empty($selectedMonth) && !empty($selectedYear)) {
        $targetMonthDate = $selectedYear . "-" . str_pad($selectedMonth, 2, '0', STR_PAD_LEFT) . "-01";
        $qtys = $_POST['qty'] ?? [];
        $penalties = $_POST['penalty'] ?? [];
        $penalty_qtys = $_POST['penalty_qty'] ?? [];

        $pdo->beginTransaction();
        try {
            // Query active parameters to check update list
            $pStmt = $pdo->prepare("SELECT id FROM dc_mcc_chemical_param WHERE station_id = :station_id");
            $pStmt->execute(['station_id' => $stationId]);
            $paramIds = $pStmt->fetchAll(PDO::FETCH_COLUMN);

            foreach ($paramIds as $pId) {
                $qty = isset($qtys[$pId]) ? floatval($qtys[$pId]) : 0.00;
                $penalty = isset($penalties[$pId]) ? floatval($penalties[$pId]) : 0.00;
                $penalty_qty = isset($penalty_qtys[$pId]) ? floatval($penalty_qtys[$pId]) : 1.00;

                // Check if target row already exists
                $checkStmt = $pdo->prepare("
                    SELECT id FROM dc_mcc_chemical_target 
                    WHERE parameter_id = :param_id AND target_month = :target_month AND station_id = :station_id
                ");
                $checkStmt->execute([
                    'param_id' => $pId,
                    'target_month' => $targetMonthDate,
                    'station_id' => $stationId
                ]);
                $existingId = $checkStmt->fetchColumn();

                if ($existingId) {
                    $updStmt = $pdo->prepare("
                        UPDATE dc_mcc_chemical_target 
                        SET `qty(ml)` = :qty, penalty = :penalty, `penalty_qty(ml)` = :penalty_qty 
                        WHERE id = :id
                    ");
                    $updStmt->execute([
                        'qty' => $qty,
                        'penalty' => $penalty,
                        'penalty_qty' => $penalty_qty,
                        'id' => $existingId
                    ]);
                } else {
                    $insStmt = $pdo->prepare("
                        INSERT INTO dc_mcc_chemical_target (parameter_id, target_month, `qty(ml)`, penalty, `penalty_qty(ml)`, station_id) 
                        VALUES (:param_id, :target_month, :qty, :penalty, :penalty_qty, :station_id)
                    ");
                    $insStmt->execute([
                        'param_id' => $pId,
                        'target_month' => $targetMonthDate,
                        'qty' => $qty,
                        'penalty' => $penalty,
                        'penalty_qty' => $penalty_qty,
                        'station_id' => $stationId
                    ]);
                }
            }

            $pdo->commit();
            $successMsg = "PLDC chemical targets for " . date('F, Y', strtotime($targetMonthDate)) . " saved successfully!";
        } catch (Exception $e) {
            $pdo->rollBack();
            $errorMsg = "Error saving targets: " . $e->getMessage();
        }
    }
}

// Fetch all active parameters and current targets for the selected month
$paramsStmt = $pdo->prepare("
    SELECT p.id AS parameter_id, p.name AS parameter_name, p.units, t.`qty(ml)` AS qty_ml, t.penalty, t.`penalty_qty(ml)` AS penalty_qty_ml 
    FROM dc_mcc_chemical_param p
    LEFT JOIN dc_mcc_chemical_target t ON p.id = t.parameter_id AND t.station_id = :station_id_target AND t.target_month = :target_month
    WHERE p.station_id = :station_id_param
    ORDER BY p.id ASC
");
$paramsStmt->execute([
    'station_id_target' => $stationId,
    'station_id_param' => $stationId,
    'target_month' => $targetMonthDate
]);
$parametersList = $paramsStmt->fetchAll();

$pageTitle = 'Set PLDC Chemical Targets | MCC';

$extraStyles = "
.target-sheet {
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
    padding: 8px 10px !important;
    font-size: 13px !important;
    border: 1px solid #cbd5e1 !important;
}
.report-table td {
    padding: 8px 10px !important;
    font-size: 13px !important;
    border: 1px solid #cbd5e1 !important;
}
.report-table td.text-left {
    text-align: left !important;
    padding-left: 12px !important;
}
.target-input {
    width: 100px;
    padding: 4px 8px;
    border: 1px solid #cbd5e1;
    border-radius: 4px;
    text-align: center;
    font-weight: 600;
    outline: none;
    font-size: 13px;
    transition: all 0.2s ease;
    height: 32px;
}
.target-input:focus {
    border-color: #3b82f6;
    box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2);
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
    .target-sheet {
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
    
    .target-sheet {
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
            
            <!-- Filters & Navigation Bar -->
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
                    <a href="pldc-chemical.php" class="btn-print" style="background: #1987C6 !important; color: white !important; text-decoration: none; padding: 8px 16px; border-radius: 6px; font-weight: 700; font-size: 14px; display: inline-flex; align-items: center; border: none; height: 38px;">
                        Daily Chemical Report
                    </a>
                    <a href="pldc-chemical-summary.php?month=<?= date('m', strtotime($targetMonthDate)) ?>&year=<?= date('Y', strtotime($targetMonthDate)) ?>" class="btn-print" style="background: #6b7280 !important; color: white !important; text-decoration: none; padding: 8px 16px; border-radius: 6px; font-weight: 700; font-size: 14px; display: inline-flex; align-items: center; border: none; height: 38px;">
                        Chemical Summary
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

            <!-- Target Sheet Panel -->
            <div class="target-sheet">
                <div style="text-align: center; margin-bottom: 20px;">
                    <h1 style="font-size: 18px; font-weight: bold; color: #1e293b; margin: 0; text-transform: uppercase;">
                        PLDC Chemical Target Configuration
                    </h1>
                    <div style="font-size: 14px; color: #64748b; margin-top: 5px;">
                        Month: <strong><?= date('F, Y', strtotime($targetMonthDate)) ?></strong> &nbsp;|&nbsp; Depot: <strong><?= htmlspecialchars($stationName) ?></strong> &nbsp;|&nbsp; Contractor: <strong><?= htmlspecialchars($contractorName) ?></strong>
                    </div>
                </div>

                <?php if (empty($parametersList)): ?>
                    <div class="alert alert-info" style="margin: 20px 0; border-radius: 8px; padding: 12px 20px; border: 1px solid #bee5eb; background-color: #d1ecf1; color: #0c5460; text-align: center;">
                        <i class="bi bi-info-circle-fill me-2"></i> No chemical parameters registered for this station.
                    </div>
                <?php else: ?>
                    <form method="POST" action="">
                        <input type="hidden" name="month" value="<?= htmlspecialchars($selectedMonth); ?>">
                        <input type="hidden" name="year" value="<?= htmlspecialchars($selectedYear); ?>">
                        <div class="table-responsive">
                            <table class="report-table">
                                <thead>
                                    <tr>
                                        <th style="width: 50px;">S.No</th>
                                        <th class="text-left">Consumable Material Name</th>
                                        <th style="width: 100px;">Units</th>
                                        <th style="width: 160px;">Target Quantity/Month</th>
                                        <th style="width: 160px;">Penalty Rate (Rs.)</th>
                                        <th style="width: 160px;">Penalty Quantity (Divisor)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php 
                                    $serial = 1;
                                    foreach ($parametersList as $param): 
                                        $pId = $param['parameter_id'];
                                        $qtyVal = $param['qty_ml'] !== null ? floatval($param['qty_ml']) : '';
                                        $penaltyVal = $param['penalty'] !== null ? floatval($param['penalty']) : '';
                                        $penaltyQtyVal = $param['penalty_qty_ml'] !== null ? floatval($param['penalty_qty_ml']) : '';

                                        // Clean values if they are integers
                                        if ($qtyVal !== '' && $qtyVal == intval($qtyVal)) $qtyVal = intval($qtyVal);
                                        if ($penaltyVal !== '' && $penaltyVal == intval($penaltyVal)) $penaltyVal = intval($penaltyVal);
                                        if ($penaltyQtyVal !== '' && $penaltyQtyVal == intval($penaltyQtyVal)) $penaltyQtyVal = intval($penaltyQtyVal);
                                    ?>
                                        <tr>
                                            <td><?= $serial++ ?></td>
                                            <td class="text-left"><strong><?= htmlspecialchars($param['parameter_name']) ?></strong></td>
                                            <td><?= htmlspecialchars($param['units'] ?? 'Nos.') ?></td>
                                            <td>
                                                <input type="number" step="0.01" min="0" name="qty[<?= $pId ?>]" 
                                                    value="<?= htmlspecialchars($qtyVal) ?>" 
                                                    class="target-input" required placeholder="0">
                                            </td>
                                            <td>
                                                <input type="number" step="0.01" min="0" name="penalty[<?= $pId ?>]" 
                                                    value="<?= htmlspecialchars($penaltyVal) ?>" 
                                                    class="target-input" required placeholder="0">
                                            </td>
                                            <td>
                                                <input type="number" step="0.01" min="0.01" name="penalty_qty[<?= $pId ?>]" 
                                                    value="<?= htmlspecialchars($penaltyQtyVal) ?>" 
                                                    class="target-input" required placeholder="1">
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>

                        <div style="text-align: center; margin-top: 25px;" class="no-print">
                            <button type="submit" name="save_targets" class="btn btn-primary" style="background-color: #1987C6; border: none; font-weight: 700; font-size: 15px; padding: 10px 40px; border-radius: 6px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); cursor: pointer; transition: all 0.2s ease;">
                                Save Targets
                            </button>
                        </div>
                    </form>
                <?php endif; ?>

            </div>
        </div>
    </div>
</main>

<?php include 'footer.php'; ?>
