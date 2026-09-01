<?php
require_once 'auth.php';

$successMessage = '';
$errorMessage = '';

// Handle POST request to update targets
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!empty($isViewer)) {
        $errorMessage = "Viewers are in read-only mode and cannot save targets.";
    } else {
        $effectiveFrom = $_POST['effective_from'] ?? date('Y-m-d');
        
        // Ensure effective date is valid
        if (empty($effectiveFrom) || !strtotime($effectiveFrom)) {
            $effectiveFrom = date('Y-m-d');
        }

        $targetsInput = $_POST['targets'] ?? []; // Array of parameter_id => [qty, penalty, penalty_qty]
        
        try {
            $pdo->beginTransaction();

            // Prepare statements
            $findActiveStmt = $pdo->prepare("
                SELECT * FROM mcc_normal_chemical_target 
                WHERE station_id = :station_id AND parameter_id = :parameter_id AND effective_to IS NULL
                LIMIT 1
            ");

            $closeActiveStmt = $pdo->prepare("
                UPDATE mcc_normal_chemical_target 
                SET effective_to = :effective_to 
                WHERE id = :id
            ");

            $insertNewStmt = $pdo->prepare("
                INSERT INTO mcc_normal_chemical_target 
                (parameter_id, station_id, `qty(ml)`, penalty, `penalty_qty(ml)`, effective_from, effective_to) 
                VALUES (:parameter_id, :station_id, :qty, :penalty, :penalty_qty, :effective_from, NULL)
            ");

            foreach ($targetsInput as $paramId => $values) {
                $newQty = isset($values['qty']) ? floatval($values['qty']) : 0.0;
                $newPenalty = isset($values['penalty']) ? floatval($values['penalty']) : 0.0;
                $newPenaltyQty = isset($values['penalty_qty']) ? floatval($values['penalty_qty']) : 0.0;

                // Find current active target
                $findActiveStmt->execute([
                    'station_id' => $stationId,
                    'parameter_id' => $paramId
                ]);
                $currentActive = $findActiveStmt->fetch(PDO::FETCH_ASSOC);

                $needsUpdate = false;

                if ($currentActive) {
                    // Compare values
                    $currQty = floatval($currentActive['qty(ml)']);
                    $currPenalty = floatval($currentActive['penalty']);
                    $currPenaltyQty = floatval($currentActive['penalty_qty(ml)']);

                    if ($currQty !== $newQty || $currPenalty !== $newPenalty || $currPenaltyQty !== $newPenaltyQty) {
                        $needsUpdate = true;
                        
                        // Close the active target. Set its effective_to to the day before the new effective date
                        $effectiveToDate = date('Y-m-d', strtotime($effectiveFrom . ' - 1 day'));
                        
                        // If the new effective date is today or in the past, ensure we don't end up with invalid ranges
                        if (strtotime($effectiveToDate) < strtotime($currentActive['effective_from'])) {
                            $effectiveToDate = $currentActive['effective_from'];
                        }

                        $closeActiveStmt->execute([
                            'effective_to' => $effectiveToDate,
                            'id' => $currentActive['id']
                        ]);
                    }
                } else {
                    // No active target exists yet, we definitely need to insert
                    $needsUpdate = true;
                }

                if ($needsUpdate) {
                    // Insert the new target record
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
            $successMessage = 'Chemical targets updated successfully.';

        } catch (Exception $e) {
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            $errorMessage = 'Error updating chemical targets: ' . $e->getMessage();
        }
    }
}

// Fetch active chemical parameters for the station
$paramsStmt = $pdo->prepare("
    SELECT p.id AS parameter_id, p.name AS parameter_name, p.units 
    FROM mcc_normal_chemical_param p
    WHERE p.station_id = :station_id
    ORDER BY p.id ASC
");
$paramsStmt->execute(['station_id' => $stationId]);
$parametersList = $paramsStmt->fetchAll(PDO::FETCH_ASSOC);

// Fetch current active targets
$targetsStmt = $pdo->prepare("
    SELECT t.* 
    FROM mcc_normal_chemical_target t
    WHERE t.station_id = :station_id AND t.effective_to IS NULL
");
$targetsStmt->execute(['station_id' => $stationId]);
$activeTargetsRaw = $targetsStmt->fetchAll(PDO::FETCH_ASSOC);

$activeTargets = [];
foreach ($activeTargetsRaw as $t) {
    $activeTargets[$t['parameter_id']] = $t;
}

$pageTitle = 'Manage Chemical Targets | CDO';

$extraStyles = "
.card-header {
    background: #1987C6 !important;
    color: #fff !important;
    font-weight: 700;
}
.btn-save {
    background: #16a34a !important;
    color: white !important;
    font-weight: 700;
    padding: 8px 24px;
    border-radius: 6px;
    border: none;
    cursor: pointer;
}
.btn-save:hover {
    background: #15803d !important;
}
.form-control-target {
    width: 100%;
    padding: 6px 12px;
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    background-color: #f8fafc;
    color: #334155;
}
.form-control-target:focus {
    border-color: #1987C6;
    outline: none;
}
";

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
    <div class="app-content">
        <div class="container-fluid" style="padding-top: 20px;">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h1 style="font-size: 20px; font-weight: 700; margin: 0; color: #1e293b;">Manage Chemical Targets & Penalties</h1>
                <a href="chemical-report.php" class="btn btn-secondary" style="background: #64748b; border: none; font-weight: 600;">
                    <i class="bi bi-arrow-left me-1"></i> Back to Report
                </a>
            </div>

            <?php if (!empty($successMessage)): ?>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i> <?= htmlspecialchars($successMessage) ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <?php endif; ?>

            <?php if (!empty($errorMessage)): ?>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> <?= htmlspecialchars($errorMessage) ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <?php endif; ?>

            <div class="card shadow-sm border-0 mb-4" style="border-radius: 12px; overflow: hidden;">
                <div class="card-header border-0 py-3">
                    <h5 class="card-title mb-0" style="font-size: 16px;"><i class="bi bi-gear-fill me-2"></i>Set Target Rates & Deficit Penalties</h5>
                </div>
                <div class="card-body p-4 bg-white">
                    <form method="POST" action="">
                        <!-- Effective Date Input -->
                        <div class="row mb-4">
                            <div class="col-md-4">
                                <label for="effective_from" class="form-label" style="font-weight: 600; color: #475569;">Targets Effective From Date</label>
                                <input type="date" id="effective_from" name="effective_from" class="form-control" value="<?= date('Y-m-d') ?>" required style="border-radius: 6px; border: 1px solid #cbd5e1; height: 38px;">
                                <div class="form-text text-muted" style="font-size: 11.5px; margin-top: 4px;">
                                    Any target changes will start applying starting on this date.
                                </div>
                            </div>
                        </div>

                        <!-- Targets Table -->
                        <div class="table-responsive">
                            <table class="table align-middle" style="border: 1px solid #e2e8f0; border-radius: 8px;">
                                <thead class="table-light">
                                    <tr>
                                        <th style="width: 50px;">S.No</th>
                                        <th>Material Description</th>
                                        <th style="width: 150px;">Units</th>
                                        <th style="width: 200px;">Target per Coach (ml)</th>
                                        <th style="width: 200px;">Penalty Rate (Rs.)</th>
                                        <th style="width: 200px;">Penalty Qty (ml)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php 
                                    $serial = 1;
                                    foreach ($parametersList as $param): 
                                        $pId = $param['parameter_id'];
                                        $targetVal = $activeTargets[$pId]['qty(ml)'] ?? 0.00;
                                        $penaltyVal = $activeTargets[$pId]['penalty'] ?? 0.00;
                                        $penaltyQtyVal = $activeTargets[$pId]['penalty_qty(ml)'] ?? 0.00;
                                    ?>
                                        <tr>
                                            <td><?= $serial++ ?></td>
                                            <td><strong><?= htmlspecialchars($param['parameter_name']) ?></strong></td>
                                            <td><span class="badge bg-light text-dark border px-2 py-1"><?= htmlspecialchars($param['units'] ?: 'ml') ?></span></td>
                                            <td>
                                                <input type="number" step="0.01" min="0" name="targets[<?= $pId ?>][qty]" class="form-control-target" value="<?= htmlspecialchars($targetVal) ?>" required>
                                            </td>
                                            <td>
                                                <input type="number" step="0.01" min="0" name="targets[<?= $pId ?>][penalty]" class="form-control-target" value="<?= htmlspecialchars($penaltyVal) ?>" required>
                                            </td>
                                            <td>
                                                <input type="number" step="0.01" min="0" name="targets[<?= $pId ?>][penalty_qty]" class="form-control-target" value="<?= htmlspecialchars($penaltyQtyVal) ?>" required>
                                            </td>
                                        </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>

                        <div class="d-flex justify-content-end mt-4">
                            <button type="submit" class="btn-save" <?= !empty($isViewer) ? 'disabled title="Read-only mode: Viewers cannot save targets"' : '' ?> style="<?= !empty($isViewer) ? 'cursor: not-allowed; opacity: 0.65;' : '' ?>">
                                <i class="bi <?= !empty($isViewer) ? 'bi-lock-fill' : 'bi-save' ?> me-1"></i> <?= !empty($isViewer) ? 'Targets Locked (Read-Only)' : 'Save Target Values' ?>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>

<?php include 'footer.php'; ?>
