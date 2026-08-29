<?php
require_once 'auth.php';

$fromDate = $_GET['from_date'] ?? date('Y-m-d', strtotime('-6 days'));
$toDate = $_GET['to_date'] ?? date('Y-m-d');

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
    SELECT p.id AS parameter_id, p.name AS parameter_name, p.units, t.`qty(ml)` AS qty_ml, t.penalty, t.`penalty_qty(ml)` AS penalty_qty_ml 
    FROM dc_mcc_chemical_param p
    LEFT JOIN dc_mcc_chemical_target t ON p.id = t.parameter_id AND t.station_id = :station_id_target AND t.target_month = :target_month
    WHERE p.station_id = :station_id_param
    ORDER BY p.id ASC
");

// Fetch distinct tokens in this date range and station for DC chemical report
$stmt = $pdo->prepare("
    SELECT DISTINCT token_id, report_date 
    FROM dc_mcc_chemical_report 
    WHERE report_date BETWEEN :from_date AND :to_date AND station_id = :station_id
    ORDER BY report_date DESC, token_id DESC
");
$stmt->execute(['from_date' => $fromDate, 'to_date' => $toDate, 'station_id' => $stationId]);
$tokensList = $stmt->fetchAll();

$sheetsData = [];

if (!empty($tokensList)) {
    $reportStmt = $pdo->prepare("
        SELECT r.*, s.shift 
        FROM dc_mcc_chemical_report r
        JOIN dc_mcc_chemical_shifts s ON r.shift_id = s.id
        WHERE r.token_id = :token_id AND r.station_id = :station_id
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
        
        $sheetsData[] = [
            'token_id' => $tokenId,
            'report_date' => $t['report_date'],
            'report_data' => $reportData,
            'auditors_by_shift' => $auditorsByShift,
            'chemical_score' => $chemicalScore,
            'total_penalty' => $totalPenalty,
            'parameters_list' => $sheetParameters,
            'is_fallback' => false
        ];
    }
} else {
    $targetMonth = date('Y-m-01', strtotime($fromDate));
    $paramsStmt->execute([
        'station_id_target' => $stationId,
        'station_id_param' => $stationId,
        'target_month' => $targetMonth
    ]);
    $fallbackParams = $paramsStmt->fetchAll();

    $sheetsData[] = [
        'token_id' => '',
        'report_date' => $fromDate,
        'report_data' => [],
        'auditors_by_shift' => [],
        'chemical_score' => 100,
        'total_penalty' => 0,
        'parameters_list' => $fallbackParams,
        'is_fallback' => true
    ];
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
                <a href="dc-chemical-summary.php?month=<?= date('m', strtotime($fromDate)) ?>&year=<?= date('Y', strtotime($fromDate)) ?>" class="btn-summary">Summary</a>
                <a href="dc-chemical-target.php" class="btn-summary" style="background: #6c757d !important;">Targets</a>
                <button type="button" class="btn-print" onclick="window.print()">Print</button>
            </form>

            <div class="report-wrap">
                <?php if ($sheetsData[0]['is_fallback']): ?>
                    <div class="alert alert-warning no-print" style="margin: 0 0 20px 0; border-radius: 8px; border: 1px solid #ffeeba; background-color: #fff3cd; color: #856404; padding: 12px 20px;">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> No chemical reports found for the selected date range. Displaying empty template scorecard.
                    </div>
                <?php endif; ?>

                <?php foreach ($sheetsData as $sheet): ?>
                    <div class="chemical-sheet">

                        <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #e2e8f0; padding-bottom: 10px; margin-bottom: 15px;">
                            <h2 style="font-size: 18px; font-weight: 700; color: #1e293b; margin: 0;">DC Chemical Consumption Report</h2>
                            <?php if (!$sheet['is_fallback']): ?>
                                <span style="font-family: monospace; font-weight: 700; font-size: 12px; background: #e2e8f0; color: #475569; padding: 3px 8px; border-radius: 4px; border: 1px solid #cbd5e1;">Token: <?= htmlspecialchars($sheet['token_id']) ?></span>
                            <?php endif; ?>
                        </div>

                        <div style="font-size: 13px; color: #334155; margin-bottom: 15px; border-bottom: 1px solid #e2e8f0; padding-bottom: 10px; line-height: 1.6;">
                            <div style="display: flex; flex-wrap: wrap; justify-content: space-between; gap: 8px 16px;">
                                <div>
                                    <strong>Railway:</strong> <?= htmlspecialchars($railwayName) ?> &nbsp;|&nbsp;
                                    <strong>Division:</strong> <?= htmlspecialchars($divisionName) ?> &nbsp;|&nbsp;
                                    <strong>Depot:</strong> <?= htmlspecialchars($stationName) ?> &nbsp;|&nbsp;
                                    <strong>Date:</strong> <?= htmlspecialchars($sheet['report_date'] ? date('d-m-Y', strtotime($sheet['report_date'])) : date('d-m-Y', strtotime($fromDate))) ?>
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
                                                <td><?= $qty > 0 ? number_format($qty, 2) : '-' ?></td>
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
                                <div class="signature-line">Contractor's Supervisor</div>
                            </div>
                            <div class="signature-box">
                                <div class="signature-line">Authorized Railway Officer</div>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    </div>
</main>

<?php include 'footer.php'; ?>
