<?php
require_once 'auth.php';

// Month & Year selection
$selectedMonth = $_GET['month'] ?? date('m');
$selectedYear = $_GET['year'] ?? date('Y');

// Standardize parameters
$selectedMonth = str_pad($selectedMonth, 2, '0', STR_PAD_LEFT);
$selectedYear = intval($selectedYear);

// Fetch chemical parameters for this station dynamically - PRT
$paramsStmt = $pdo->prepare("
    SELECT id AS parameter_id, name AS parameter_name, units 
    FROM mcc_prt_chemical_param
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$paramsStmt->execute(['station_id' => $stationId]);
$parametersList = $paramsStmt->fetchAll();

// Fetch active target values for display/initialization (as of end of month or today) - PRT
$displayTargetsStmt = $pdo->prepare("
    SELECT t.parameter_id, t.`qty(ml)` AS qty_ml, t.penalty, t.`penalty_qty(ml)` AS penalty_qty_ml
    FROM mcc_prt_chemical_target t
    WHERE t.station_id = :station_id 
      AND :date_ref_1 >= t.effective_from
      AND (t.effective_to IS NULL OR :date_ref_2 <= t.effective_to)
");
// Use last day of selected month or today as date reference
$dateRef = date('Y-m-d', strtotime("$selectedYear-$selectedMonth-01 +1 month -1 day"));
if (strtotime($dateRef) > time()) {
    $dateRef = date('Y-m-d');
}
$displayTargetsStmt->execute(['station_id' => $stationId, 'date_ref_1' => $dateRef, 'date_ref_2' => $dateRef]);
$displayTargetsRaw = $displayTargetsStmt->fetchAll(PDO::FETCH_ASSOC);
$displayTargets = [];
foreach ($displayTargetsRaw as $dt) {
    $displayTargets[$dt['parameter_id']] = $dt;
}

// Fetch all reports (distinct tokens) in the selected month - PRT
$tokensStmt = $pdo->prepare("
    SELECT DISTINCT token_id, report_date 
    FROM mcc_prt_chemical_report 
    WHERE YEAR(report_date) = :year AND MONTH(report_date) = :month AND station_id = :station_id
    ORDER BY report_date ASC, token_id ASC
");
$tokensStmt->execute([
    'year' => $selectedYear,
    'month' => $selectedMonth,
    'station_id' => $stationId
]);
$tokensList = $tokensStmt->fetchAll();

// Get count of distinct coaches for each token in the selected month - PRT
$coachesStmt = $pdo->prepare("
    SELECT token_id, COUNT(DISTINCT coach_no) AS coaches_count
    FROM mcc_prt_chemical_report
    WHERE YEAR(report_date) = :year AND MONTH(report_date) = :month AND station_id = :station_id
    GROUP BY token_id
");
$coachesStmt->execute([
    'year' => $selectedYear,
    'month' => $selectedMonth,
    'station_id' => $stationId
]);
$tokenCoaches = [];
while ($row = $coachesStmt->fetch()) {
    $cCount = intval($row['coaches_count']);
    if ($cCount === 0) {
        $cCount = 24; // fallback
    }
    $tokenCoaches[$row['token_id']] = $cCount;
}

// Initialize parameters list for aggregation
$monthlyParamData = [];
foreach ($parametersList as $p) {
    $pId = $p['parameter_id'];
    $monthlyParamData[$pId] = [
        'name' => $p['parameter_name'],
        'units' => $p['units'] ?? 'Nos',
        'qty_ml' => isset($displayTargets[$pId]['qty_ml']) ? floatval($displayTargets[$pId]['qty_ml']) : 0,
        'penalty_rate' => isset($displayTargets[$pId]['penalty']) ? floatval($displayTargets[$pId]['penalty']) : 0,
        'penalty_qty_ml' => isset($displayTargets[$pId]['penalty_qty_ml']) ? floatval($displayTargets[$pId]['penalty_qty_ml']) : 0,
        'monthly_target' => 0.0,
        'total_consumed' => 0.0,
        'total_penalty' => 0.0
    ];
}

// Fetch daily reports details to compute daily scores & penalties - PRT
$dailyReportStmt = $pdo->prepare("
    SELECT parameter_id, qty_used 
    FROM mcc_prt_chemical_report 
    WHERE token_id = :token_id AND station_id = :station_id
");

// Target resolving statement - PRT
$targetStmt = $pdo->prepare("
    SELECT t.parameter_id, t.`qty(ml)` AS qty_ml, t.penalty, t.`penalty_qty(ml)` AS penalty_qty_ml
    FROM mcc_prt_chemical_target t
    WHERE t.station_id = :station_id
      AND :report_date_1 >= t.effective_from 
      AND (t.effective_to IS NULL OR :report_date_2 <= t.effective_to)
");

$dailyScores = [];
$totalMonthlyPenalty = 0.0;
$totalConductedInspections = count($tokensList);

foreach ($tokensList as $t) {
    $tokenId = $t['token_id'];
    $reportDate = $t['report_date'];
    
    $coachesCount = $tokenCoaches[$tokenId] ?? 24;
    
    $dailyReportStmt->execute(['token_id' => $tokenId, 'station_id' => $stationId]);
    $reportRows = $dailyReportStmt->fetchAll();
    
    $dailyUsed = [];
    foreach ($reportRows as $row) {
        $pId = $row['parameter_id'];
        if (!isset($dailyUsed[$pId])) {
            $dailyUsed[$pId] = 0.0;
        }
        $dailyUsed[$pId] += floatval($row['qty_used']);
    }
    
    // Resolve targets active on this specific day
    $targetStmt->execute([
        'station_id' => $stationId,
        'report_date_1' => $reportDate,
        'report_date_2' => $reportDate
    ]);
    $dailyTargetsRaw = $targetStmt->fetchAll(PDO::FETCH_ASSOC);
    $dailyTargets = [];
    foreach ($dailyTargetsRaw as $dt) {
        $dailyTargets[$dt['parameter_id']] = $dt;
    }
    
    $compliances = [];
    $tokenPenalty = 0.0;
    
    foreach ($parametersList as $p) {
        $pId = $p['parameter_id'];
        
        $stdQty = isset($dailyTargets[$pId]['qty_ml']) ? floatval($dailyTargets[$pId]['qty_ml']) : 0.0;
        $totalTarget = $stdQty * $coachesCount;
        $actualUsed = $dailyUsed[$pId] ?? 0.0;
        
        // Aggregate monthly totals
        $monthlyParamData[$pId]['monthly_target'] += $totalTarget;
        $monthlyParamData[$pId]['total_consumed'] += $actualUsed;
        
        if ($totalTarget > 0) {
            $compliance = min(100.0, ($actualUsed / $totalTarget) * 100.0);
            $compliances[] = $compliance;
        } else {
            $compliances[] = 100.0;
        }
        
        // Deficit penalty calculation
        if ($actualUsed < $totalTarget) {
            $deficit = $totalTarget - $actualUsed;
            $penaltyQty = isset($dailyTargets[$pId]['penalty_qty_ml']) ? floatval($dailyTargets[$pId]['penalty_qty_ml']) : 0.0;
            if ($penaltyQty <= 0) {
                $penaltyQty = 1.0;
            }
            $basePenalty = isset($dailyTargets[$pId]['penalty']) ? floatval($dailyTargets[$pId]['penalty']) : 0.0;
            if ($basePenalty > 0) {
                $penaltyForThis = ceil($deficit / $penaltyQty) * $basePenalty;
                $tokenPenalty += $penaltyForThis;
                $monthlyParamData[$pId]['total_penalty'] += $penaltyForThis;
            }
        }
    }
    
    $score = count($compliances) > 0 ? (array_sum($compliances) / count($compliances)) : 100.0;
    $totalMonthlyPenalty += $tokenPenalty;
    
    $dailyScores[] = [
        'date' => $reportDate,
        'token_id' => $tokenId,
        'coaches' => $coachesCount,
        'score' => round($score, 1),
        'penalty' => $tokenPenalty
    ];
}

// Monthly Average Compliance
$monthlyAvgScore = 0.0;
if (count($dailyScores) > 0) {
    $monthlyAvgScore = round(array_sum(array_column($dailyScores, 'score')) / count($dailyScores), 2);
}

$pageTitle = 'Monthly PRT Chemical Summary | MCC';

$extraStyles = "
.summary-container {
    background: #ffffff !important;
    border: 1px solid #cbd5e1 !important;
    padding: 25px !important;
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
    text-align: center !important;
}
.report-table td.text-left {
    text-align: left !important;
    padding-left: 15px !important;
}
.stat-box {
    background: #f8fafc;
    border: 1px solid #cbd5e1;
    padding: 12px 20px;
    border-radius: 6px;
    text-align: center;
}
.stat-box h3 {
    margin: 0;
    font-size: 20px;
    font-weight: 800;
    color: #0f172a;
}
.stat-box p {
    margin: 5px 0 0 0;
    font-size: 11px;
    font-weight: 700;
    color: #64748b;
    text-transform: uppercase;
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
    .summary-container {
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

            <!-- Month Filter -->
            <div class="card shadow-sm border-0 mb-4 bg-white no-print">
                <div class="card-body p-3 col-md-10 mx-auto">
                    <form method="GET" action="Platform-Return-Chemical-summary.php" class="row g-3 align-items-center justify-content-center m-0">
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
                                <i class="bi bi-funnel-fill me-1"></i> Open Summary
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="summary-container">
                <div class="d-flex align-items-center justify-content-between border-bottom pb-3 mb-4">
                    <h4 class="mb-0 fw-bold text-dark text-uppercase">
                        <i class="bi bi-file-earmark-bar-graph text-primary me-2"></i> PRT Chemical Monthly Summary: <?= date('F Y', strtotime($dateRef)) ?>
                    </h4>
                    <div class="no-print">
                        <a href="Platform-Return-Chemical.php" class="btn btn-sm btn-outline-secondary fw-bold px-3 me-2">
                            <i class="bi bi-arrow-left"></i> Daily Chemical Report
                        </a>
                        <button type="button" class="btn btn-sm btn-dark fw-bold px-3" onclick="window.print()">
                            <i class="bi bi-printer me-1"></i> Print Summary
                        </button>
                    </div>
                </div>

                <!-- Stats Grid -->
                <div class="row g-3 mb-4">
                    <div class="col-md-4">
                        <div class="stat-box">
                            <h3><?= $totalConductedInspections ?></h3>
                            <p>Total Trains Inspected</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-box">
                            <h3 class="text-success"><?= number_format($monthlyAvgScore, 2) ?>%</h3>
                            <p>Average Compliance Score</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stat-box">
                            <h3 class="text-danger">₹<?= number_format($totalMonthlyPenalty, 2) ?></h3>
                            <p>Total Penalty Deductions</p>
                        </div>
                    </div>
                </div>

                <!-- Tabulated Aggregated Consumables Usage -->
                <h5 class="fw-bold mb-2 text-dark"><i class="bi bi-pie-chart me-1 text-primary"></i> Aggregated Consumables Usage</h5>
                <div class="table-responsive mb-5">
                    <table class="report-table">
                        <thead>
                            <tr>
                                <th style="width: 50px;">S.No</th>
                                <th style="text-align: left; padding-left: 15px;">Consumable Items</th>
                                <th style="width: 110px;">Units</th>
                                <th>Target Qty (per coach)</th>
                                <th>Aggregated Target Month Qty</th>
                                <th>Aggregated Actual Quantity Consumed</th>
                                <th>Total Penalty (₹)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php 
                            $serial = 1;
                            foreach ($monthlyParamData as $pId => $data): 
                            ?>
                                <tr>
                                    <td><?= $serial++ ?></td>
                                    <td class="text-left"><strong><?= htmlspecialchars($data['name']) ?></strong></td>
                                    <td><?= htmlspecialchars($data['units']) ?></td>
                                    <td><?= number_format($data['qty_ml'], 2) ?></td>
                                    <td><?= number_format($data['nominated_target'] ?? $data['monthly_target'], 2) ?></td>
                                    <td><strong><?= number_format($data['total_consumed'], 2) ?></strong></td>
                                    <td class="<?= $data['total_penalty'] > 0 ? 'text-danger font-weight-bold' : '' ?>">
                                        ₹<?= number_format($data['total_penalty'], 2) ?>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>

                <!-- Daily Breakdown Table -->
                <h5 class="fw-bold mb-2 text-dark"><i class="bi bi-clock-history me-1 text-primary"></i> Daily Inspections Breakdown</h5>
                <div class="table-responsive">
                    <table class="report-table">
                        <thead>
                            <tr>
                                <th style="width: 70px;">S.No</th>
                                <th style="width: 150px;">Date</th>
                                <th style="width: 160px;">Token ID</th>
                                <th style="width: 140px;">Coaches Count</th>
                                <th>Day Compliance Score</th>
                                <th>Day Penalty Deduction</th>
                                <th class="no-print" style="width: 130px;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if (empty($dailyScores)): ?>
                                <tr>
                                    <td colspan="7" class="text-muted text-center py-3">No inspections conducted in this month.</td>
                                </tr>
                            <?php else: ?>
                                <?php 
                                $serial = 1;
                                foreach ($dailyScores as $ds): 
                                    $scoreColor = $ds['score'] >= 90 ? 'text-success font-weight-bold' : ($ds['score'] >= 75 ? 'text-primary font-weight-bold' : 'text-danger font-weight-bold');
                                ?>
                                    <tr>
                                        <td><?= $serial++ ?></td>
                                        <td><strong><?= htmlspecialchars(date('d-m-Y', strtotime($ds['date']))) ?></strong></td>
                                        <td><span class="badge bg-light text-dark border"><?= htmlspecialchars($ds['token_id']) ?></span></td>
                                        <td><?= $ds['coaches'] ?></td>
                                        <td class="<?= $scoreColor ?>"><?= number_format($ds['score'], 1) ?>%</td>
                                        <td class="<?= $ds['penalty'] > 0 ? 'text-danger font-weight-bold' : '' ?>">
                                            ₹<?= number_format($ds['penalty'], 2) ?>
                                        </td>
                                        <td class="no-print">
                                            <a href="Platform-Return-Chemical.php?from_date=<?= $ds['date'] ?>&to_date=<?= $ds['date'] ?>" class="btn btn-xs btn-outline-primary py-1 px-2 fw-bold" style="font-size: 11px;">
                                                <i class="bi bi-eye"></i> View Detail
                                            </a>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            <?php endif; ?>
                        </tbody>
                    </table>
                </div>

            </div>

        </div>
    </div>
</main>

<?php include 'footer.php'; ?>
