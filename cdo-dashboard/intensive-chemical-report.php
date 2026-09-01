<?php
require_once 'auth.php';

$fromDate = $_GET['from_date'] ?? date('Y-m-d', strtotime('-6 days'));
$toDate = $_GET['to_date'] ?? date('Y-m-d');

// Fetch all active parameters - Intensive
$paramsStmt = $pdo->prepare("
    SELECT id AS parameter_id, name AS parameter_name, units 
    FROM mcc_intensive_chemical_param 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$paramsStmt->execute(['station_id' => $stationId]);
$parametersList = $paramsStmt->fetchAll();

// Fetch distinct tokens in this date range and station for intensive chemical report
$stmt = $pdo->prepare("
    SELECT DISTINCT token_id, train_no, report_date 
    FROM mcc_intensive_chemical_report 
    WHERE report_date BETWEEN :from_date AND :to_date AND station_id = :station_id
    ORDER BY report_date DESC, token_id DESC
");
$stmt->execute(['from_date' => $fromDate, 'to_date' => $toDate, 'station_id' => $stationId]);
$tokensList = $stmt->fetchAll();

// Target resolving statement - Intensive SCD Range
$targetStmt = $pdo->prepare("
    SELECT t.parameter_id, t.`qty(ml)` AS qty_ml, t.penalty, t.`penalty_qty(ml)` AS penalty_qty_ml
    FROM mcc_intensive_chemical_target t
    WHERE t.station_id = :station_id
      AND :report_date_1 >= t.effective_from 
      AND (t.effective_to IS NULL OR :report_date_2 <= t.effective_to)
");

$sheetsData = [];

if (!empty($tokensList)) {
    $coachesStmt = $pdo->prepare("
        SELECT DISTINCT coach_no 
        FROM mcc_intensive_chemical_report 
        WHERE token_id = :token_id AND station_id = :station_id
    ");

    $reportStmt = $pdo->prepare("
        SELECT * 
        FROM mcc_intensive_chemical_report 
        WHERE token_id = :token_id AND station_id = :station_id
    ");

    foreach ($tokensList as $t) {
        $tokenId = $t['token_id'];
        $reportDate = $t['report_date'];
        $trainNo = $t['train_no'];

        // Get targets active on this report date (SCD Type 2)
        $targetStmt->execute([
            'station_id' => $stationId,
            'report_date_1' => $reportDate,
            'report_date_2' => $reportDate
        ]);
        $targetsRaw = $targetStmt->fetchAll(PDO::FETCH_ASSOC);
        $targets = [];
        foreach ($targetsRaw as $tr) {
            $targets[$tr['parameter_id']] = $tr;
        }
        
        $coachesStmt->execute(['token_id' => $tokenId, 'station_id' => $stationId]);
        $distinctCoaches = $coachesStmt->fetchAll(PDO::FETCH_COLUMN);
        $totalCoaches = count($distinctCoaches);
        if ($totalCoaches === 0) {
            $totalCoaches = 24;
        }
        
        $reportStmt->execute(['token_id' => $tokenId, 'station_id' => $stationId]);
        $rows = $reportStmt->fetchAll();
        
        $reportData = [];
        $auditors = [];
        
        foreach ($rows as $row) {
            $pId = $row['parameter_id'];
            $qty = floatval($row['qty_used']);
            
            if (!isset($reportData[$pId])) {
                $reportData[$pId] = 0;
            }
            $reportData[$pId] += $qty;
            
            if ($row['auditor_name'] && !in_array($row['auditor_name'], $auditors)) {
                $auditors[] = $row['auditor_name'];
            }
        }
        
        $auditorNameStr = implode(', ', $auditors);
        
        $paramCompliances = [];
        $totalPenalty = 0;
        
        foreach ($parametersList as $param) {
            $pId = $param['parameter_id'];
            $targetPerCoach = isset($targets[$pId]['qty_ml']) ? floatval($targets[$pId]['qty_ml']) : 0;
            $targetTotal = $targetPerCoach * $totalCoaches;
            
            $rowTotalUsed = $reportData[$pId] ?? 0;
            
            if ($targetTotal > 0) {
                $compliance = min(100.0, ($rowTotalUsed / $targetTotal) * 100.0);
                $paramCompliances[] = $compliance;
            } else {
                $paramCompliances[] = 100.0;
            }
            
            if ($rowTotalUsed < $targetTotal) {
                $deficit = $targetTotal - $rowTotalUsed;
                $penaltyQty = isset($targets[$pId]['penalty_qty_ml']) ? floatval($targets[$pId]['penalty_qty_ml']) : 0;
                if ($penaltyQty <= 0) {
                    $penaltyQty = targetPerCoach; // fallback to target per coach
                }
                if ($penaltyQty <= 0) {
                    $penaltyQty = 1; // avoid divide by zero
                }
                $basePenalty = isset($targets[$pId]['penalty']) ? floatval($targets[$pId]['penalty']) : 0;
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
            'report_date' => $reportDate,
            'train_no' => $trainNo,
            'total_coaches' => $totalCoaches,
            'report_data' => $reportData,
            'auditor_name' => $auditorNameStr,
            'chemical_score' => $chemicalScore,
            'total_penalty' => $totalPenalty,
            'targets' => $targets, // save targets for this date to display in UI table!
            'is_fallback' => false
        ];
    }
} else {
    $sheetsData[] = [
        'token_id' => '',
        'report_date' => $fromDate,
        'total_coaches' => 24,
        'report_data' => [],
        'auditor_name' => '',
        'chemical_score' => 100,
        'total_penalty' => 0,
        'is_fallback' => true
    ];
}

$pageTitle = 'Intensive Chemical Report | MCC';

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
                <a href="intensive-chemical-summary.php?month=<?= date('m', strtotime($fromDate)) ?>&year=<?= date('Y', strtotime($fromDate)) ?>" class="btn-summary">Summary</a>
                <a href="intensive-chemical-target.php" class="btn-summary" style="background: #10b981 !important; margin-left: 8px;">Targets</a>
                <button type="button" class="btn-print" onclick="window.print()">Print</button>
            </form>

            <div class="report-wrap">
                <?php if ($sheetsData[0]['is_fallback']): ?>
                    <div class="alert alert-warning no-print" style="margin: 0 0 20px 0; border-radius: 8px; border: 1px solid #ffeeba; background-color: #fff3cd; color: #856404; padding: 12px 20px;">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> No chemical reports found for the selected date range.
                    </div>
                <?php endif; ?>

                <?php foreach ($sheetsData as $sheet): ?>
                    <?php if ($sheet['is_fallback']) continue; ?>
                    <div class="chemical-sheet">

                        <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #e2e8f0; padding-bottom: 10px; margin-bottom: 15px;">
                            <h2 style="font-size: 18px; font-weight: 700; color: #1e293b; margin: 0;">Daily Chemical Report (Intensive)</h2>
                            <?php if (!$sheet['is_fallback']): ?>
                                <span style="font-family: monospace; font-weight: 700; font-size: 12px; background: #e2e8f0; color: #475569; padding: 3px 8px; border-radius: 4px; border: 1px solid #cbd5e1;">Token: <?= htmlspecialchars($sheet['token_id']) ?></span>
                            <?php endif; ?>
                        </div>

                        <div style="font-size: 13px; color: #334155; margin-bottom: 15px; border-bottom: 1px solid #e2e8f0; padding-bottom: 10px; line-height: 1.6;">
                            <div style="display: flex; flex-wrap: wrap; justify-content: space-between; gap: 8px 16px;">
                                <div>
                                    <strong>Railway:</strong> <?= htmlspecialchars($railwayName) ?> &nbsp;|&nbsp;
                                    <strong>Division:</strong> <?= htmlspecialchars($divisionName) ?> &nbsp;|&nbsp;
                                    <strong>Station:</strong> <?= htmlspecialchars($stationName) ?> &nbsp;|&nbsp;
                                    <strong>Date:</strong> <?= htmlspecialchars($sheet['report_date'] ? date('d-m-Y', strtotime($sheet['report_date'])) : date('d-m-Y', strtotime($fromDate))) ?>
                                </div>
                                <div>
                                    <strong>Train No:</strong> <?= htmlspecialchars($sheet['train_no'] ?? '-') ?> &nbsp;|&nbsp;
                                    <strong>No. of Coaches:</strong> <?= htmlspecialchars($sheet['total_coaches']) ?> &nbsp;|&nbsp;
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
                                        <th>S.No</th>
                                        <th>Description Of Material</th>
                                        <th>Units</th>
                                        <th>Coaches</th>
                                        <th>Target (ml)</th>
                                        <th>Quantity Used (ml)</th>
                                        <th>Deficit (ml)</th>
                                        <th>Penalty (Rs.)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php 
                                    $serial = 1;
                                    foreach ($parametersList as $param): 
                                        $pId = $param['parameter_id'];
                                        $targetPerCoach = isset($sheet['targets'][$pId]['qty_ml']) ? floatval($sheet['targets'][$pId]['qty_ml']) : 0;
                                        $totalTargetQty = $targetPerCoach * $sheet['total_coaches'];
                                        
                                        $rowTotalUsed = $sheet['report_data'][$pId] ?? 0;

                                        $diff = $rowTotalUsed - $totalTargetQty;
                                        $rowPenalty = 0;
                                        if ($diff < 0) {
                                            $deficitVal = abs($diff);
                                            $penaltyQty = isset($sheet['targets'][$pId]['penalty_qty_ml']) ? floatval($sheet['targets'][$pId]['penalty_qty_ml']) : 0;
                                            if ($penaltyQty <= 0) {
                                                $penaltyQty = $targetPerCoach;
                                            }
                                            if ($penaltyQty <= 0) {
                                                $penaltyQty = 1;
                                            }
                                            $basePenalty = isset($sheet['targets'][$pId]['penalty']) ? floatval($sheet['targets'][$pId]['penalty']) : 0;
                                            if ($basePenalty > 0) {
                                                $rowPenalty = ceil($deficitVal / $penaltyQty) * $basePenalty;
                                            }
                                        }
                                    ?>
                                        <tr>
                                            <td><?= $serial++ ?></td>
                                            <td class="text-left"><?= htmlspecialchars($param['parameter_name']) ?></td>
                                            <td><?= htmlspecialchars($param['units'] ?? 'ml/coach') ?></td>
                                            <td><?= $sheet['total_coaches'] ?></td>
                                            <td><?= number_format($totalTargetQty, 2) ?></td>
                                            <td><strong><?= $rowTotalUsed > 0 ? number_format($rowTotalUsed, 2) : '-' ?></strong></td>
                                            <td><?= $diff < 0 ? number_format($diff, 2) : ($diff > 0 ? '+' . number_format($diff, 2) : '0.00') ?></td>
                                            <td><?= $rowPenalty > 0 ? 'Rs. ' . number_format($rowPenalty, 0) : '0' ?></td>
                                        </tr>
                                    <?php endforeach; ?>
                                    
                                    <tr class="section-row">
                                        <td colspan="5">Name Of Auditor</td>
                                        <td colspan="3" style="text-align:center">
                                            <?= htmlspecialchars($sheet['auditor_name'] ?: '-') ?>
                                        </td>
                                    </tr>
                                    <tr class="section-row">
                                        <td colspan="5">Signature of Supervisor</td>
                                        <td colspan="3" style="text-align:center">_________________</td>
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
