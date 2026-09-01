<?php
require_once 'auth.php';

$successMessage = '';
$errorMessage = '';

// Handle POST request to update targets - PRT
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!empty($isViewer)) {
        $errorMessage = "Viewers are in read-only mode and cannot save targets.";
    } else {
        $effectiveFrom = $_POST['effective_from'] ?? date('Y-m-d');
        if (empty($effectiveFrom) || !strtotime($effectiveFrom)) {
            $effectiveFrom = date('Y-m-d');
        }

        $targetsInput = $_POST['targets'] ?? []; // Array of parameter_id => [qty, penalty, penalty_qty]
        
        try {
            $pdo->beginTransaction();

            $findActiveStmt = $pdo->prepare("
                SELECT * FROM mcc_prt_chemical_target 
                WHERE station_id = :station_id AND parameter_id = :parameter_id AND effective_to IS NULL
                LIMIT 1
            ");

            $closeActiveStmt = $pdo->prepare("
                UPDATE mcc_prt_chemical_target 
                SET effective_to = :effective_to 
                WHERE id = :id
            ");

            $insertNewStmt = $pdo->prepare("
                INSERT INTO mcc_prt_chemical_target 
                (parameter_id, station_id, `qty(ml)`, penalty, `penalty_qty(ml)`, effective_from, effective_to) 
                VALUES (:parameter_id, :station_id, :qty, :penalty, :penalty_qty, :effective_from, NULL)
            ");

            foreach ($targetsInput as $paramId => $values) {
                $paramId = intval($paramId);
                $newQty = isset($values['qty']) ? floatval($values['qty']) : 0.0;
                $newPenalty = isset($values['penalty']) ? floatval($values['penalty']) : 0.0;
                $newPenaltyQty = isset($values['penalty_qty']) ? floatval($values['penalty_qty']) : 0.0;

                $findActiveStmt->execute([
                    'station_id' => $stationId,
                    'parameter_id' => $paramId
                ]);
                $currentActive = $findActiveStmt->fetch(PDO::FETCH_ASSOC);

                $needsUpdate = false;
                if ($currentActive) {
                    $currQty = floatval($currentActive['qty(ml)']);
                    $currPenalty = floatval($currentActive['penalty']);
                    $currPenaltyQty = floatval($currentActive['penalty_qty(ml)']);

                    if ($currQty !== $newQty || $currPenalty !== $newPenalty || $currPenaltyQty !== $newPenaltyQty) {
                        $needsUpdate = true;
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
                    $needsUpdate = true;
                }

                if ($needsUpdate) {
                    $insertNewStmt->execute([
                        'parameter_id' => $paramId,
                        'station_id' => $stationId,
                        'qty' => $newQty,
                        'penalty' => $newPenalty,
                        'penalty_qty' => $newPenaltyQty,
                        'effective_from' => $effectiveFrom
                    ]);
                }
            }

            $pdo->commit();
            $successMessage = 'PRT Chemical targets updated successfully.';

        } catch (Exception $e) {
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            $errorMessage = 'Error updating PRT chemical targets: ' . $e->getMessage();
        }
    }
}

// Fetch all active chemical parameters - PRT
$paramsStmt = $pdo->prepare("
    SELECT id AS parameter_id, name AS parameter_name, units 
    FROM mcc_prt_chemical_param
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$paramsStmt->execute(['station_id' => $stationId]);
$parametersList = $paramsStmt->fetchAll();

// Resolve active target values (effective_to IS NULL) - PRT
$activeTargetsStmt = $pdo->prepare("
    SELECT * FROM mcc_prt_chemical_target 
    WHERE station_id = :station_id AND effective_to IS NULL
");
$activeTargetsStmt->execute(['station_id' => $stationId]);
$activeTargetsRaw = $activeTargetsStmt->fetchAll();

$activeTargets = [];
foreach ($activeTargetsRaw as $at) {
    $activeTargets[$at['parameter_id']] = [
        'qty' => floatval($at['qty(ml)']),
        'penalty' => floatval($at['penalty']),
        'penalty_qty' => floatval($at['penalty_qty(ml)'])
    ];
}

$pageTitle = 'Set Monthly PRT Chemical Target | MCC';

$extraStyles = "
.target-card {
    background: #ffffff !important;
    border: 1px solid #cbd5e1 !important;
    padding: 25px !important;
    max-width: 1200px !important;
    margin: 10px auto 30px auto !important;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05) !important;
    border-radius: 8px !important;
}

.report-table {
    width: 100% !important;
    border-collapse: collapse !important;
    margin-top: 15px !important;
}

.report-table thead th {
    background: linear-gradient(180deg, #07203a 0%, #07182c 100%) !important;
    color: white !important;
    border: 1px solid #0b476a !important;
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
    text-align: center !important;
}

.report-table td.text-left {
    text-align: left !important;
    padding-left: 15px !important;
}

.qty-input, .penalty-input {
    width: 100px;
    padding: 4px 8px;
    border: 1px solid #cbd5e1;
    border-radius: 4px;
    font-weight: 600;
    text-align: center;
    outline: none;
    font-size: 13px;
    transition: all 0.2s ease;
}

.qty-input:focus, .penalty-input:focus {
    border-color: #3b82f6;
    box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2);
}
";

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
    <div class="app-content py-4">
        <div class="container-fluid">
            
            <?php if (!empty($successMessage)): ?>
                <div class="alert alert-success alert-dismissible fade show no-print mx-auto col-md-10" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i> <?= htmlspecialchars($successMessage) ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <?php endif; ?>

            <?php if (!empty($errorMessage)): ?>
                <div class="alert alert-danger alert-dismissible fade show no-print mx-auto col-md-10" role="alert">
                    <i class="bi bi-exclamation-octagon-fill me-2"></i> <?= htmlspecialchars($errorMessage) ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <?php endif; ?>

            <div class="target-card">
                <div class="d-flex align-items-center justify-content-between mb-4 border-bottom pb-3">
                    <h4 class="mb-0 fw-bold text-dark text-uppercase">
                        <i class="bi bi-sliders text-primary me-2"></i> PRT Chemical Nominated Targets
                    </h4>
                    <div class="no-print">
                        <a href="Platform-Return-Chemical.php" class="btn btn-sm btn-outline-secondary fw-bold px-3 me-2">
                            <i class="bi bi-arrow-left"></i> Daily Chemical Report
                        </a>
                        <button type="button" class="btn btn-sm btn-dark fw-bold px-3" onclick="window.print()">
                            <i class="bi bi-printer me-1"></i> Print
                        </button>
                    </div>
                </div>

                <form method="POST" action="Platform-Return-Chemical-target.php">
                    
                    <div class="row g-3 mb-4 align-items-center no-print bg-light p-3 rounded border">
                        <div class="col-md-4">
                            <label class="form-label fw-bold mb-1"><i class="bi bi-calendar-check me-1 text-primary"></i> Target Change Effective Date:</label>
                            <input type="date" name="effective_from" class="form-control form-control-sm" required value="<?= date('Y-m-d') ?>">
                            <small class="text-muted">Set when these targets become active (defaults to today).</small>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="report-table">
                            <thead>
                                <tr>
                                    <th style="width: 50px;">S.No</th>
                                    <th style="text-align: left; padding-left: 15px;">Consumable Items</th>
                                    <th style="width: 140px;">Units</th>
                                    <th>Standard Target Qty (per coach)</th>
                                    <th>Penalty Rate (₹)</th>
                                    <th>Penalty Deficit Qty Step</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if (empty($parametersList)): ?>
                                    <tr>
                                        <td colspan="6" class="text-center py-4 text-muted">
                                            No chemical parameters configured.
                                        </td>
                                    </tr>
                                <?php else: ?>
                                    <?php 
                                    $serial = 1;
                                    foreach ($parametersList as $p): 
                                        $pId = $p['parameter_id'];
                                        $targetQty = $activeTargets[$pId]['qty'] ?? 0.0;
                                        $penaltyVal = $activeTargets[$pId]['penalty'] ?? 0.0;
                                        $penaltyQty = $activeTargets[$pId]['penalty_qty'] ?? 0.0;
                                    ?>
                                        <tr>
                                            <td class="text-center font-weight-bold"><?= $serial++ ?></td>
                                            <td class="text-left"><strong><?= htmlspecialchars($p['parameter_name']) ?></strong></td>
                                            <td><?= htmlspecialchars($p['units']) ?></td>
                                            <td>
                                                <input type="number" step="0.001" min="0" name="targets[<?= $pId ?>][qty]" 
                                                       value="<?= number_format($targetQty, 3, '.', '') ?>" class="qty-input form-control form-control-sm">
                                            </td>
                                            <td>
                                                <input type="number" step="0.01" min="0" name="targets[<?= $pId ?>][penalty]" 
                                                       value="<?= number_format($penaltyVal, 2, '.', '') ?>" class="penalty-input form-control form-control-sm">
                                            </td>
                                            <td>
                                                <input type="number" step="0.001" min="0" name="targets[<?= $pId ?>][penalty_qty]" 
                                                       value="<?= number_format($penaltyQty, 3, '.', '') ?>" class="qty-input form-control form-control-sm">
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>
                                <?php endif; ?>
                            </tbody>
                        </table>
                    </div>

                    <div class="mt-4 text-center no-print">
                        <button type="submit" class="btn btn-success fw-bold px-4 py-2" <?= !empty($isViewer) ? 'disabled title="Read-only mode: Viewers cannot save targets"' : '' ?> style="<?= !empty($isViewer) ? 'cursor: not-allowed; opacity: 0.65;' : '' ?>">
                            <i class="bi <?= !empty($isViewer) ? 'bi-lock-fill' : 'bi-save' ?> me-1"></i> <?= !empty($isViewer) ? 'Targets Locked (Read-Only)' : 'Save Chemical Targets' ?>
                        </button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</main>

<?php include 'footer.php'; ?>
