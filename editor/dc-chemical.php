<?php
require_once 'auth.php';

$fromDate = $_GET['from_date'] ?? date('Y-m-d', strtotime('-6 days'));
$toDate = $_GET['to_date'] ?? date('Y-m-d');
$editToken = $_GET['edit'] ?? '';
$flashSuccess = '';
$flashError = '';

// Handle Direct PHP POST Save (No AJAX)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['save_chemical_changes'])) {
    $targetToken = trim($_POST['token_id'] ?? '');
    $postedQty = $_POST['qty_used'] ?? [];
    $newReportDate = trim($_POST['sheet_report_date'] ?? '');

    if (!empty($targetToken)) {
        try {
            $pdo->beginTransaction();

            $chk = $pdo->prepare("SELECT COUNT(*) FROM mcc_chemical_report WHERE token_id = :tok AND station_id = :sid AND chemical_type_id = 6");
            $chk->execute(['tok' => $targetToken, 'sid' => $stationId]);

            if ($chk->fetchColumn() > 0) {
                // Update Date if provided
                if (!empty($newReportDate) && preg_match('/^\d{4}-\d{2}-\d{2}$/', $newReportDate)) {
                    $dateUpd = $pdo->prepare("UPDATE mcc_chemical_report SET report_date = :dt WHERE token_id = :tok AND station_id = :sid AND chemical_type_id = 6");
                    $dateUpd->execute(['dt' => $newReportDate, 'tok' => $targetToken, 'sid' => $stationId]);

                    // Also keep DC scorecard report date in sync if it exists for this token
                    try {
                        $scDateUpd = $pdo->prepare("UPDATE dc_mcc_report SET report_date = :dt WHERE token_id = :tok AND station_id = :sid");
                        $scDateUpd->execute(['dt' => $newReportDate, 'tok' => $targetToken, 'sid' => $stationId]);
                    } catch (Exception $ex) {}

                    // Ensure updated date falls within current filter range so it remains visible
                    if ($newReportDate < $fromDate) $fromDate = $newReportDate;
                    if ($newReportDate > $toDate) $toDate = $newReportDate;
                }

                // Update Quantities (by param and shift)
                if (!empty($postedQty)) {
                    $updStmt = $pdo->prepare("
                        UPDATE mcc_chemical_report 
                        SET qty_used = :qty 
                        WHERE token_id = :tok 
                          AND station_id = :sid 
                          AND parameter_id = :p_id
                          AND shift_id = :s_id
                          AND chemical_type_id = 6
                    ");

                    foreach ($postedQty as $pId => $shiftData) {
                        if (is_array($shiftData)) {
                            foreach ($shiftData as $sId => $qtyVal) {
                                $updStmt->execute([
                                    'qty' => floatval($qtyVal),
                                    'tok' => $targetToken,
                                    'sid' => $stationId,
                                    'p_id' => $pId,
                                    's_id' => $sId
                                ]);
                            }
                        }
                    }
                }

                $pdo->commit();
                $dateNote = (!empty($newReportDate)) ? " (Date: " . date('d-m-Y', strtotime($newReportDate)) . ")" : "";
                $flashSuccess = "DC chemical report (Token: " . htmlspecialchars($targetToken) . ") updated successfully{$dateNote}!";
                $editToken = ''; // Exit edit mode after saving
            } else {
                $pdo->rollBack();
                $flashError = "DC chemical report sheet not found or station mismatch.";
            }
        } catch (Exception $e) {
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            $flashError = "Failed to update chemical report: " . $e->getMessage();
        }
    }
}

// Fetch all active shifts for station_id dynamically - DC
$shiftsStmt = $pdo->prepare("
    SELECT id AS shift_id, shift AS shift_name 
    FROM dc_mcc_chemical_shifts 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$shiftsStmt->execute(['station_id' => $stationId]);
$shiftsList = $shiftsStmt->fetchAll();

// Fetch all active parameters and their target values/penalties dynamically by month - DC
$paramsStmt = $pdo->prepare("
    SELECT p.id AS parameter_id, p.name AS parameter_name, COALESCE(u.unit_symbol, 'ml') AS units, t.`qty(ml)` AS qty_ml, t.penalty, t.`penalty_qty(ml)` AS penalty_qty_ml 
    FROM mcc_chemical_param p
    LEFT JOIN mcc_chemical_units u ON p.base_unit_id = u.id
    INNER JOIN mcc_chemical_param_type_map m ON p.id = m.parameter_id
    LEFT JOIN mcc_chemical_target t ON p.id = t.parameter_id AND t.station_id = :station_id_target AND t.chemical_type_id = 6 AND t.target_month = :target_month
    WHERE m.station_id = :station_id_param AND m.chemical_type_id = 6 AND m.status = 'Active'
    ORDER BY p.id ASC
");

// Fetch distinct tokens in this date range and station for DC chemical report
$stmt = $pdo->prepare("
    SELECT DISTINCT token_id, report_date 
    FROM mcc_chemical_report 
    WHERE report_date BETWEEN :from_date AND :to_date AND station_id = :station_id AND chemical_type_id = 6
    ORDER BY report_date DESC, token_id DESC
");
$stmt->execute(['from_date' => $fromDate, 'to_date' => $toDate, 'station_id' => $stationId]);
$tokensList = $stmt->fetchAll();

$sheetsData = [];

if (!empty($tokensList)) {
    $reportStmt = $pdo->prepare("
        SELECT r.*, s.shift 
        FROM mcc_chemical_report r
        JOIN dc_mcc_chemical_shifts s ON r.shift_id = s.id
        WHERE r.token_id = :token_id AND r.station_id = :station_id AND r.chemical_type_id = 6
    ");

    foreach ($tokensList as $t) {
        $tokenId = $t['token_id'];
        $reportDate = $t['report_date'];
        $targetMonth = date('Y-m-01', strtotime($reportDate));

        // Fetch targets for this month
        $paramsStmt->execute([
            'station_id_target' => $stationId,
            'station_id_param' => $stationId,
            'target_month' => $targetMonth
        ]);
        $sheetParameters = $paramsStmt->fetchAll();
        
        $reportStmt->execute(['token_id' => $tokenId, 'station_id' => $stationId]);
        $rows = $reportStmt->fetchAll();
        
        $reportData = [];
        $auditorsByShift = [];
        
        foreach ($rows as $row) {
            $pId = $row['parameter_id'];
            $sId = $row['shift_id'];
            $qty = floatval($row['qty_used']);
            
            if (!isset($reportData[$pId][$sId])) {
                $reportData[$pId][$sId] = 0;
            }
            $reportData[$pId][$sId] += $qty;
            
            if ($row['auditor_name']) {
                $auditorsByShift[$sId] = $row['auditor_name'];
            }
        }
        
        $paramCompliances = [];
        $totalPenalty = 0;
        
        foreach ($sheetParameters as $param) {
            $pId = $param['parameter_id'];
            $targetMonthQty = floatval($param['qty_ml'] ?? 0);
            $dailyTarget = $targetMonthQty / 30.0;
            
            $rowTotalUsed = 0;
            foreach ($shiftsList as $shift) {
                $sId = $shift['shift_id'];
                $rowTotalUsed += $reportData[$pId][$sId] ?? 0;
            }
            
            if ($dailyTarget > 0) {
                $compliance = min(100.0, ($rowTotalUsed / $dailyTarget) * 100.0);
                $paramCompliances[] = $compliance;
            } else {
                $paramCompliances[] = 100.0;
            }
            
            if ($rowTotalUsed < $dailyTarget) {
                $deficit = $dailyTarget - $rowTotalUsed;
                $penaltyQty = floatval($param['penalty_qty_ml'] ?? 0);
                if ($penaltyQty <= 0) {
                    $penaltyQty = 1.0;
                }
                $basePenalty = floatval($param['penalty'] ?? 0);
                if ($basePenalty > 0) {
                    $totalPenalty += ceil($deficit / $penaltyQty) * $basePenalty;
                }
            }
        }
        
        if (count($paramCompliances) > 0) {
            $chemicalScore = round(array_sum($paramCompliances) / count($paramCompliances), 1);
        } else {
            $chemicalScore = 100;
        }
        
        $auditById = null;
        foreach ($rows as $row) {
            if (!empty($row['audit_by'])) {
                $auditById = $row['audit_by'];
                break;
            }
        }
        $auditorNameStr = implode(', ', array_unique($auditorsByShift));
        $auditorSig = resolveAuditorSignature($pdo, $auditById);

        $sheetsData[] = [
            'token_id' => $tokenId,
            'report_date' => $t['report_date'],
            'report_data' => $reportData,
            'auditors_by_shift' => $auditorsByShift,
            'auditor_signature' => $auditorSig,
            'chemical_score' => $chemicalScore,
            'total_penalty' => $totalPenalty,
            'parameters_list' => $sheetParameters,
            'is_fallback' => false,
            'isApproved' => !empty($rows) ? (int)($rows[0]['isApproved'] ?? 0) : 0
        ];
    }
}

$pageTitle = 'Consumables Usage Report | MCC';

$extraStyles = "
.chemical-sheet {
    background: #fff !important;
    border: 1px solid #000000 !important;
    padding: 20px !important;
    width: 100% !important;
    overflow-x: auto !important;
    margin-bottom: 50px !important;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1) !important;
    border-radius: 8px !important;
}
.chemical-sheet:last-child {
    margin-bottom: 0 !important;
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
    .modal-backdrop,
    .offcanvas-backdrop,
    #sidebar-overlay {
        display: none !important;
        opacity: 0 !important;
        visibility: hidden !important;
        width: 0 !important;
        height: 0 !important;
    }
    
    html,
    body, 
    .bg-body-tertiary,
    .app-wrapper, 
    .app-main, 
    .app-content, 
    .container-fluid, 
    .report-wrap,
    .chemical-sheet {
        margin: 0 !important;
        padding: 0 !important;
        width: 100% !important;
        max-width: 100% !important;
        min-width: 100% !important;
        background: #fff !important;
        background-color: #fff !important;
        box-shadow: none !important;
        position: static !important;
        overflow: visible !important;
        opacity: 1 !important;
        filter: none !important;
        transition: none !important;
        animation: none !important;
    }
    
    .app-main {
        padding-top: 0 !important;
        margin-left: 0 !important;
    }
    
    .chemical-sheet {
        margin: 0 0 20px 0 !important;
        padding: 0 !important;
        border: none !important;
        box-shadow: none !important;
        page-break-inside: avoid !important;
        page-break-after: always !important;
        break-after: page !important;
        width: 100% !important;
        background: #fff !important;
        overflow: visible !important;
    }
    
    .chemical-sheet:last-child {
        page-break-after: avoid !important;
        break-after: avoid !important;
        margin-bottom: 0 !important;
    }
}
</style>

<main class="app-main">
    <div class="app-content">
        <div class="container-fluid">
            <form class="report-filter no-print" method="GET">
                <label for="from_date">From:</label>
                <input type="date" id="from_date" name="from_date" value="<?= htmlspecialchars($fromDate); ?>">
                
                <label for="to_date">To:</label>
                <input type="date" id="to_date" name="to_date" value="<?= htmlspecialchars($toDate); ?>">
                
                <button type="submit" class="btn-go">Go</button>
                
                
                <button type="button" class="btn-print" onclick="window.print()">Print</button>
            </form>

            <div class="report-wrap">
                <?php if (!empty($flashSuccess)): ?>
                    <div class="alert alert-success alert-dismissible fade show mb-3" role="alert">
                        <i class="bi bi-check-circle-fill me-2"></i><strong>Success!</strong> <?= $flashSuccess ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <?php endif; ?>
                <?php if (!empty($flashError)): ?>
                    <div class="alert alert-danger alert-dismissible fade show mb-3" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i><strong>Error!</strong> <?= $flashError ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <?php endif; ?>

                <?php if (empty($sheetsData)): ?>
                    <div class="alert alert-warning no-print" style="margin: 0 0 20px 0; border-radius: 8px; border: 1px solid #ffeeba; background-color: #fff3cd; color: #856404; padding: 12px 20px;">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> No chemical reports found for the selected date range.
                    </div>
                <?php endif; ?>

                <?php foreach ($sheetsData as $sheet): 
                    $isEditingThisSheet = ($editToken !== '' && (string)$editToken === (string)$sheet['token_id']);
                ?>
                    <?php if ($isEditingThisSheet): ?>
                    <form method="POST" action="">
                        <input type="hidden" name="token_id" value="<?= htmlspecialchars($sheet['token_id']) ?>">
                        <input type="hidden" name="report_date" value="<?= htmlspecialchars($sheet['report_date']) ?>">
                        <input type="hidden" name="from_date" value="<?= htmlspecialchars($fromDate) ?>">
                        <input type="hidden" name="to_date" value="<?= htmlspecialchars($toDate) ?>">
                    <?php endif; ?>

                    <div class="chemical-sheet" style="<?= $isEditingThisSheet ? 'border: 2px solid #0284c7; box-shadow: 0 0 22px rgba(2, 132, 199, 0.35);' : '' ?>">

                        <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #e2e8f0; padding-bottom: 10px; margin-bottom: 15px;">
                            <h2 style="font-size: 18px; font-weight: 700; color: #1e293b; margin: 0;">DC Chemical Consumption Report</h2>
                            <div class="d-flex align-items-center gap-2">
                                <?php if (!$sheet['is_fallback'] && !empty($sheet['token_id'])): ?>
                                    <span style="font-family: monospace; font-weight: 700; font-size: 12px; background: #e2e8f0; color: #475569; padding: 3px 8px; border-radius: 4px; border: 1px solid #cbd5e1;">Token: <?= htmlspecialchars($sheet['token_id']) ?></span>
                                <?php endif; ?>
                                <?php if (!empty($sheet['isApproved'])): ?>
                                    <span class="badge bg-success px-3 py-2 text-white" style="font-size: 0.85rem; font-weight: 600; border-radius: 6px; box-shadow: 0 2px 5px rgba(21,128,61,0.2);"><i class="bi bi-patch-check-fill me-1"></i> Approved</span>
                                <?php else: ?>
                                    <span class="badge bg-warning text-dark px-3 py-2" style="font-size: 0.85rem; font-weight: 600; border-radius: 6px;"><i class="bi bi-clock-history me-1"></i> Pending Approval</span>
                                <?php endif; ?>

                                <?php if ($isEditingThisSheet): ?>
                                    <button type="submit" name="save_chemical_changes" class="btn btn-sm btn-success fw-bold text-white no-print shadow-sm px-3" style="font-weight: 700;">
                                        <i class="bi bi-check2-circle me-1"></i> Save Changes
                                    </button>
                                    <a href="?from_date=<?= urlencode($fromDate) ?>&to_date=<?= urlencode($toDate) ?>" class="btn btn-sm btn-secondary fw-bold text-white no-print shadow-sm px-3">
                                        <i class="bi bi-x-circle me-1"></i> Cancel
                                    </a>
                                <?php else: ?>
                                    <a href="?from_date=<?= urlencode($fromDate) ?>&to_date=<?= urlencode($toDate) ?>&edit=<?= urlencode($sheet['token_id']) ?>" class="btn btn-sm fw-bold text-dark no-print shadow-sm px-3" style="background-color: #fbbf24 !important; color: #000000 !important; font-weight: 700 !important; border: 1px solid #f59e0b;" title="Edit Sheet">
                                        <i class="bi bi-pencil-square me-1"></i> Edit Sheet
                                    </a>
                                <?php endif; ?>
                            </div>
                        </div>

                        <?php if ($isEditingThisSheet): ?>
                            <div class="alert alert-info py-2 px-3 mb-3 d-flex align-items-center justify-content-between no-print" style="border: 1px solid #b9e6fe; background-color: #f0f9ff; color: #0369a1; border-radius: 6px;">
                                <span class="small fw-semibold"><i class="bi bi-info-circle-fill me-1"></i> <strong>Edit Mode Active:</strong> You can edit the sheet Date and chemical quantities per shift in the table below. Click <strong>Save Changes</strong> above to update the database.</span>
                            </div>
                        <?php endif; ?>

                        <div style="font-size: 13px; color: #334155; margin-bottom: 15px; border-bottom: 1px solid #e2e8f0; padding-bottom: 10px; line-height: 1.6;">
                            <div style="display: flex; flex-wrap: wrap; justify-content: space-between; gap: 8px 16px;">
                                <div>
                                    <strong>Railway:</strong> <?= htmlspecialchars($railwayName) ?> &nbsp;|&nbsp;
                                    <strong>Division:</strong> <?= htmlspecialchars($divisionName) ?> &nbsp;|&nbsp;
                                    <strong>Depot:</strong> <?= htmlspecialchars($stationName) ?> &nbsp;|&nbsp;
                                    <strong>Date:</strong> 
                                    <?php if ($isEditingThisSheet): ?>
                                        <input type="date" name="sheet_report_date" value="<?= htmlspecialchars($sheet['report_date'] ?? $fromDate) ?>" class="form-control form-control-sm text-center fw-bold d-inline-block" style="width: 145px; height: 30px; font-size: 0.9rem; padding: 2px 6px; border: 1.5px solid #0284c7; background-color: #fff;" required>
                                    <?php else: ?>
                                        <?= htmlspecialchars($sheet['report_date'] ? date('d-m-Y', strtotime($sheet['report_date'])) : date('d-m-Y', strtotime($fromDate))) ?>
                                    <?php endif; ?>
                                </div>
                                <div>
                                    <strong>Contractor:</strong> <?= htmlspecialchars($contractorName) ?> &nbsp;|&nbsp;
                                    <strong>Score:</strong> <span style="color: #15803d; font-weight: 700;"><?= $sheet['chemical_score'] ?>%</span> &nbsp;|&nbsp;
                                    <strong>Total Penalty:</strong> <span style="color: #b91c1c; font-weight: 700;">Rs. <?= number_format($sheet['total_penalty'], 0) ?></span>
                                </div>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="report-table">
                                <thead>
                                    <tr>
                                        <th rowspan="2" style="width: 50px;">S.No</th>
                                        <th rowspan="2" class="text-left">Description of Material</th>
                                        <th rowspan="2" style="width: 80px;">Units</th>
                                        <th rowspan="2" style="width: 100px;">Target/Month</th>
                                        <th rowspan="2" style="width: 100px;">Daily Target</th>
                                        <th colspan="<?= count($shiftsList) ?>">Quantity Used</th>
                                        <th rowspan="2" style="width: 100px;">Total Qty</th>
                                        <th rowspan="2" style="width: 100px;">Deficit</th>
                                        <th rowspan="2" style="width: 100px;">Penalty (Rs.)</th>
                                    </tr>
                                    <tr>
                                        <?php foreach ($shiftsList as $shift): ?>
                                            <th style="width: 80px;"><?= htmlspecialchars($shift['shift_name']) ?></th>
                                        <?php endforeach; ?>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php 
                                    $serial = 1;
                                    foreach ($sheet['parameters_list'] as $param): 
                                        $pId = $param['parameter_id'];
                                        $targetMonthQty = floatval($param['qty_ml'] ?? 0);
                                        $dailyTarget = $targetMonthQty / 30.0;
                                        
                                        $rowTotalUsed = 0;
                                        foreach ($shiftsList as $shift): 
                                            $sId = $shift['shift_id'];
                                            $qty = $sheet['report_data'][$pId][$sId] ?? 0;
                                            $rowTotalUsed += $qty;
                                        endforeach;

                                        $diff = $rowTotalUsed - $dailyTarget;
                                        $rowPenalty = 0;
                                        if ($diff < 0) {
                                            $deficitVal = abs($diff);
                                            $penaltyQty = floatval($param['penalty_qty_ml'] ?? 0);
                                            if ($penaltyQty <= 0) {
                                                $penaltyQty = 1.0;
                                            }
                                            $basePenalty = floatval($param['penalty'] ?? 0);
                                            if ($basePenalty > 0) {
                                                $rowPenalty = ceil($deficitVal / $penaltyQty) * $basePenalty;
                                            }
                                        }
                                    ?>
                                        <tr>
                                            <td><?= $serial++ ?></td>
                                            <td class="text-left"><strong><?= htmlspecialchars($param['parameter_name']) ?></strong></td>
                                            <td><?= htmlspecialchars($param['units'] ?? 'Nos.') ?></td>
                                            <td><?= number_format($targetMonthQty, 2) ?></td>
                                            <td><?= number_format($dailyTarget, 2) ?></td>
                                            
                                            <?php 
                                            foreach ($shiftsList as $shift): 
                                                $sId = $shift['shift_id'];
                                                $qty = $sheet['report_data'][$pId][$sId] ?? 0;
                                            ?>
                                                <td>
                                                    <?php if ($isEditingThisSheet): ?>
                                                        <input type="number" step="0.01" min="0" name="qty_used[<?= $pId ?>][<?= $sId ?>]" value="<?= floatval($qty) ?>" class="form-control form-control-sm text-center fw-bold" style="width: 80px; margin: 0 auto; background: #fff !important; color: #000 !important; border: 1.5px solid #0284c7; padding: 2px 4px; font-size: 13px;">
                                                    <?php else: ?>
                                                        <?= $qty > 0 ? number_format($qty, 2) : '-' ?>
                                                    <?php endif; ?>
                                                </td>
                                            <?php endforeach; ?>
                                            
                                            <td><strong><?= number_format($rowTotalUsed, 2) ?></strong></td>
                                            <td><?= $diff < 0 ? number_format($diff, 2) : ($diff > 0 ? '+' . number_format($diff, 2) : '0.00') ?></td>
                                            <td><?= $rowPenalty > 0 ? 'Rs. ' . number_format($rowPenalty, 0) : '0' ?></td>
                                        </tr>
                                    <?php endforeach; ?>
                                    
                                    <tr class="section-row">
                                        <td colspan="5">Name Of Auditor</td>
                                        <?php foreach ($shiftsList as $shift): ?>
                                            <td style="text-align:center">
                                                <?= htmlspecialchars($sheet['auditors_by_shift'][$shift['shift_id']] ?? '-') ?>
                                            </td>
                                        <?php endforeach; ?>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr class="section-row">
                                        <td colspan="5">Signature of Supervisor</td>
                                        <td colspan="<?= count($shiftsList) + 3 ?>" style="text-align:center">_________________</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="signature-row">
                            <div class="signature-box">
                                <div class="signature-img-wrap">
                                    <?php if (!empty($sheet['isApproved']) && !empty($cdoSignature) && file_exists(__DIR__ . '/uploads/signatures/' . $cdoSignature)): ?>
                                        <img src="uploads/signatures/<?= htmlspecialchars($cdoSignature) ?>" alt="Contractor Sign">
                                    <?php endif; ?>
                                </div>
                                <div class="signature-line">Contractor's Representative</div>
                            </div>
                            <div class="signature-box">
                                <div class="signature-img-wrap">
                                    <?php if (!empty($sheet['auditor_signature']) && file_exists(__DIR__ . '/uploads/signatures/' . $sheet['auditor_signature'])): ?>
                                        <img src="uploads/signatures/<?= htmlspecialchars($sheet['auditor_signature']) ?>" alt="Authorized Sign">
                                    <?php endif; ?>
                                </div>
                                <div class="signature-line">Authorized Railway personnel</div>
                            </div>
                        </div>
                    </div>
                    <?php if ($isEditingThisSheet): ?>
                    </form>
                    <?php endif; ?>
                <?php endforeach; ?>
            </div>
        </div>
    </div>
</main>

<?php include 'footer.php'; ?>
