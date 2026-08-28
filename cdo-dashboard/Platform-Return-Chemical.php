<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once 'auth.php';

$fromDate = $_GET['from_date'] ?? date('Y-m-d', strtotime('-6 days'));
$toDate = $_GET['to_date'] ?? date('Y-m-d');

// Fetch all active parameters dynamically - PRT
$paramsStmt = $pdo->prepare("
    SELECT id AS parameter_id, name AS parameter_name, units 
    FROM mcc_prt_chemical_param
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$paramsStmt->execute(['station_id' => $stationId]);
$parametersList = $paramsStmt->fetchAll();

// Fetch distinct tokens in this date range and station for PRT chemical report
$stmt = $pdo->prepare("
    SELECT DISTINCT token_id, train_no, report_date 
    FROM mcc_prt_chemical_report 
    WHERE report_date BETWEEN :from_date AND :to_date AND station_id = :station_id
    ORDER BY report_date DESC, token_id DESC
");
$stmt->execute(['from_date' => $fromDate, 'to_date' => $toDate, 'station_id' => $stationId]);
$tokensList = $stmt->fetchAll();

$sheetsData = [];

// Target resolving statement - PRT
$targetStmt = $pdo->prepare("
    SELECT t.parameter_id, t.`qty(ml)` AS qty_ml, t.penalty, t.`penalty_qty(ml)` AS penalty_qty_ml
    FROM mcc_prt_chemical_target t
    WHERE t.station_id = :station_id
      AND :report_date_1 >= t.effective_from 
      AND (t.effective_to IS NULL OR :report_date_2 <= t.effective_to)
");

if (!empty($tokensList)) {
    // Prepare queries to run inside the loop
    $coachesStmt = $pdo->prepare("
        SELECT DISTINCT coach_no 
        FROM mcc_prt_chemical_report 
        WHERE token_id = :token_id AND station_id = :station_id
    ");

    $reportStmt = $pdo->prepare("
        SELECT * 
        FROM mcc_prt_chemical_report 
        WHERE token_id = :token_id AND station_id = :station_id
    ");

    foreach ($tokensList as $t) {
        $tokenId = $t['token_id'];
        $reportDate = $t['report_date'];
        $trainNo = $t['train_no'];

        // Get targets active on this report date
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
        
        // Get distinct coaches count
        $coachesStmt->execute(['token_id' => $tokenId, 'station_id' => $stationId]);
        $distinctCoaches = $coachesStmt->fetchAll(PDO::FETCH_COLUMN);
        $totalCoaches = count($distinctCoaches);
        if ($totalCoaches === 0) {
            $totalCoaches = 24;
        }
        
        // Fetch report data
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
        
        $sheetParameters = [];
        $paramCompliances = [];
        $totalPenalty = 0;
        
        foreach ($parametersList as $p) {
            $pId = $p['parameter_id'];
            $target = $targets[$pId] ?? null;
            
            $targetQty = isset($target['qty_ml']) ? floatval($target['qty_ml']) : 0.0;
            $dailyTarget = $targetQty * $totalCoaches;
            
            $actualUsed = $reportData[$pId] ?? 0.0;
            
            if ($dailyTarget > 0) {
                $compliance = min(100.0, ($actualUsed / $dailyTarget) * 100.0);
                $paramCompliances[] = $compliance;
            } else {
                $compliance = 100.0;
                $paramCompliances[] = 100.0;
            }
            
            $sheetParameters[] = [
                'parameter_id' => $pId,
                'parameter_name' => $p['parameter_name'],
                'units' => $p['units'] ?? 'Nos',
                'target_qty' => $targetQty,
                'total_target' => $dailyTarget,
                'actual_used' => $actualUsed,
                'compliance' => $compliance,
                'penalty_qty_ml' => $target['penalty_qty_ml'] ?? 0.0,
                'penalty' => $target['penalty'] ?? 0.0
            ];
            
            // Penalty calculation
            if ($actualUsed < $dailyTarget) {
                $deficit = $dailyTarget - $actualUsed;
                $penaltyQty = floatval($target['penalty_qty_ml'] ?? 0);
                if ($penaltyQty <= 0) {
                    $penaltyQty = 1.0;
                }
                $basePenalty = floatval($target['penalty'] ?? 0);
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
            'train_no' => $trainNo,
            'report_date' => $reportDate,
            'report_data' => $reportData,
            'auditor_name' => implode(', ', $auditors),
            'chemical_score' => $chemicalScore,
            'total_penalty' => $totalPenalty,
            'parameters_list' => $sheetParameters,
            'is_fallback' => false
        ];
    }
} else {
    // Return empty template row
    $sheetParameters = [];
    foreach ($parametersList as $p) {
        $sheetParameters[] = [
            'parameter_id' => $p['parameter_id'],
            'parameter_name' => $p['parameter_name'],
            'units' => $p['units'] ?? 'Nos',
            'target_qty' => 0.0,
            'total_target' => 0.0,
            'actual_used' => 0.0,
            'compliance' => 100.0,
            'penalty_qty_ml' => 0.0,
            'penalty' => 0.0
        ];
    }
    $sheetsData[] = [
        'token_id' => 'TKN-' . date('Ymd') . '-001',
        'train_no' => '12555',
        'report_date' => $fromDate,
        'report_data' => [],
        'auditor_name' => 'Supervisor',
        'chemical_score' => 100,
        'total_penalty' => 0,
        'parameters_list' => $sheetParameters,
        'is_fallback' => true
    ];
}

$pageTitle = 'Consumables Usage Report (PRT) | MCC';

$extraStyles = "
.chemical-sheet {
    background: #ffffff !important;
    border: 1px solid #cbd5e1 !important;
    padding: 20px !important;
    width: 100% !important;
    max-width: 1300px !important;
    margin: 10px auto 30px auto !important;
    box-shadow: 0 4px 6px rgba(0,0,0,0.05) !important;
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
    text-align: center !important;
}

.report-table td.text-left {
    text-align: left !important;
    padding-left: 15px !important;
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
        <div class="container-fluid" style="padding-top: 15px;">
            <form class="report-filter no-print" method="GET" style="display: flex; justify-content: space-between; align-items: center; background: #fff; border: 1px solid #e2e8f0; padding: 12px 20px; border-radius: 8px; margin-bottom: 15px; box-shadow: 0 2px 4px rgba(0,0,0,0.04); flex-wrap: wrap; gap: 15px;">
                <div style="display: flex; align-items: center; gap: 12px;">
                    <label for="from_date" style="font-weight: 600; margin: 0; color: #334155;">From:</label>
                    <input type="date" id="from_date" name="from_date" value="<?= htmlspecialchars($fromDate); ?>" style="border: 1px solid #cbd5e1; border-radius: 6px; padding: 6px 12px; font-size: 14px; background-color: #f8fafc; color: #334155; height: 38px; outline: none;">
                    
                    <label for="to_date" style="font-weight: 600; margin: 0; color: #334155;">To:</label>
                    <input type="date" id="to_date" name="to_date" value="<?= htmlspecialchars($toDate); ?>" style="border: 1px solid #cbd5e1; border-radius: 6px; padding: 6px 12px; font-size: 14px; background-color: #f8fafc; color: #334155; height: 38px; outline: none;">
                    
                    <button type="submit" class="btn-go" style="background: #1987C6 !important; color: white !important; font-weight: 700; font-size: 14px; padding: 8px 24px; border-radius: 6px; border: none; cursor: pointer; height: 38px; display: inline-flex; align-items: center;">Go</button>
                </div>
                
                <div style="display: flex; gap: 10px; flex-wrap: wrap;">
                    <a href="Platform-Return-Chemical-summary.php?month=<?= date('m', strtotime($fromDate)) ?>&year=<?= date('Y', strtotime($fromDate)) ?>" class="btn-summary" style="background: #16a34a !important; color: white !important; text-decoration: none; padding: 8px 16px; border-radius: 6px; font-weight: 700; font-size: 14px; display: inline-flex; align-items: center; border: none; height: 38px;">Summary</a>
                    <a href="Platform-Return-Chemical-target.php" class="btn-summary" style="background: #6c757d !important; color: white !important; text-decoration: none; padding: 8px 16px; border-radius: 6px; font-weight: 700; font-size: 14px; display: inline-flex; align-items: center; border: none; height: 38px;">Targets</a>
                    <button type="button" class="btn-print" onclick="window.print()" style="background: #1987C6 !important; color: white !important; padding: 8px 16px; border-radius: 6px; font-weight: 700; font-size: 14px; display: inline-flex; align-items: center; border: none; height: 38px;">Print</button>
                </div>
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
                            <h2 style="font-size: 18px; font-weight: 700; color: #1e293b; margin: 0;">Daily Consumables Usage Report (Platform Return Trains)</h2>
                            <?php if (!$sheet['is_fallback']): ?>
                                <span style="font-family: monospace; font-weight: 700; font-size: 12px; background: #e2e8f0; color: #475569; padding: 3px 8px; border-radius: 4px; border: 1px solid #cbd5e1;">Token: <?= htmlspecialchars($sheet['token_id']) ?></span>
                            <?php endif; ?>
                        </div>

                        <div style="font-size: 13px; color: #334155; margin-bottom: 15px; border-bottom: 1px solid #e2e8f0; padding-bottom: 10px; line-height: 1.6;">
                            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 8px 25px;">
                                <div><strong style="color: #475569;">Railway:</strong> <?= htmlspecialchars($railwayName) ?></div>
                                <div><strong style="color: #475569;">Date:</strong> <?= htmlspecialchars(date('d-m-Y', strtotime($sheet['report_date']))) ?></div>
                                <div><strong style="color: #475569;">Division:</strong> <?= htmlspecialchars($divisionName) ?></div>
                                <div><strong style="color: #475569;">Station:</strong> <?= htmlspecialchars($stationName) ?></div>
                                <div><strong style="color: #475569;">Contractor:</strong> <?= htmlspecialchars($contractorName) ?></div>
                                <div><strong style="color: #475569;">Auditor Name:</strong> <?= htmlspecialchars($sheet['auditor_name'] ?: '-') ?></div>
                                <div><strong style="color: #475569;">Overall Compliance:</strong> <span style="font-weight: 800; color: #16a34a;"><?= htmlspecialchars($sheet['chemical_score']) ?>%</span></div>
                                <div><strong style="color: #475569;">Penalty Deduction:</strong> <span style="font-weight: 800; color: #dc2626;">₹<?= number_format($sheet['total_penalty'], 2) ?></span></div>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="report-table">
                                <thead>
                                    <tr>
                                        <th style="width: 50px;">S.No</th>
                                        <th style="text-align: left; padding-left: 15px;">Consumable Items</th>
                                        <th style="width: 110px;">Units</th>
                                        <th style="width: 140px;">Standard Qty (per coach)</th>
                                        <th style="width: 140px;">Nominated Qty (total train)</th>
                                        <th style="width: 140px;">Actual Quantity Consumed</th>
                                        <th style="width: 140px;">Compliance (%)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php 
                                    $serial = 1;
                                    foreach ($sheet['parameters_list'] as $param): 
                                        $scoreVal = floatval($param['compliance']);
                                        $scoreClass = $scoreVal >= 90 ? 'text-success font-weight-bold' : ($scoreVal >= 75 ? 'text-primary font-weight-bold' : 'text-danger font-weight-bold');
                                    ?>
                                        <tr>
                                            <td><?= $serial++ ?></td>
                                            <td class="text-left"><strong><?= htmlspecialchars($param['parameter_name']) ?></strong></td>
                                            <td><?= htmlspecialchars($param['units']) ?></td>
                                            <td><?= number_format($param['target_qty'], 2) ?></td>
                                            <td><?= number_format($param['total_target'], 2) ?></td>
                                            <td><strong><?= number_format($param['actual_used'], 2) ?></strong></td>
                                            <td class="<?= $scoreClass ?>"><?= number_format($param['compliance'], 1) ?>%</td>
                                        </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>

                        <!-- Footer and Signatures -->
                        <div style="margin-top: 40px; display: flex; justify-content: space-between; align-items: flex-end; padding: 0 20px;">
                            <div style="text-align: center;">
                                <div style="border-top: 1px solid #475569; width: 200px; padding-top: 6px; font-size: 13px; font-weight: 700; color: #475569;">Contractor Representative</div>
                            </div>
                            <div style="text-align: center;">
                                <div style="border-top: 1px solid #475569; width: 200px; padding-top: 6px; font-size: 13px; font-weight: 700; color: #475569;">Authorized Railway Officer</div>
                            </div>
                        </div>

                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    </div>
</main>

<?php include 'footer.php'; ?>