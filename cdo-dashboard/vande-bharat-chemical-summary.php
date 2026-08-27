<?php
require_once 'auth.php';

// Month & Year selection
$selectedMonth = $_GET['month'] ?? date('m');
$selectedYear = $_GET['year'] ?? date('Y');

// Standardize parameters
$selectedMonth = str_pad($selectedMonth, 2, '0', STR_PAD_LEFT);
$selectedYear = intval($selectedYear);

// Fetch chemical parameters for this station dynamically - Vande Bharat
$paramsStmt = $pdo->prepare("
    SELECT id AS parameter_id, name AS parameter_name, units 
    FROM mcc_vb_chemical_param
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$paramsStmt->execute(['station_id' => $stationId]);
$parametersList = $paramsStmt->fetchAll();

// Fetch active target values for display/initialization (as of end of month or today) - Vande Bharat
$displayTargetsStmt = $pdo->prepare("
    SELECT t.parameter_id, t.`qty(ml)` AS qty_ml, t.penalty, t.`penalty_qty(ml)` AS penalty_qty_ml
    FROM mcc_vb_chemical_target t
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

// Fetch all reports (distinct tokens) in the selected month - Vande Bharat
$tokensStmt = $pdo->prepare("
    SELECT DISTINCT token_id, report_date 
    FROM mcc_vb_chemical_report 
    WHERE YEAR(report_date) = :year AND MONTH(report_date) = :month AND station_id = :station_id
    ORDER BY report_date ASC, token_id ASC
");
$tokensStmt->execute([
    'year' => $selectedYear,
    'month' => $selectedMonth,
    'station_id' => $stationId
]);
$tokensList = $tokensStmt->fetchAll();

// Get count of distinct coaches for each token in the selected month - Vande Bharat
$coachesStmt = $pdo->prepare("
    SELECT token_id, COUNT(DISTINCT coach_no) AS coaches_count
    FROM mcc_vb_chemical_report
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
        $cCount = 16; // fallback
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

// Fetch daily reports details to compute daily scores & penalties - Vande Bharat
$dailyReportStmt = $pdo->prepare("
    SELECT parameter_id, qty_used 
    FROM mcc_vb_chemical_report 
    WHERE token_id = :token_id AND station_id = :station_id
");

// Target resolving statement - Vande Bharat
$targetStmt = $pdo->prepare("
    SELECT t.parameter_id, t.`qty(ml)` AS qty_ml, t.penalty, t.`penalty_qty(ml)` AS penalty_qty_ml
    FROM mcc_vb_chemical_target t
    WHERE t.station_id = :station_id
      AND :report_date_1 >= t.effective_from 
      AND (t.effective_to IS NULL OR :report_date_2 <= t.effective_to)
");

$dailyScores = [];
$totalMonthlyPenalty = 0.0;

foreach ($tokensList as $t) {
    $tokenId = $t['token_id'];
    $coachesCount = $tokenCoaches[$tokenId] ?? 16;
    $reportDate = $t['report_date'];

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

    $dailyReportStmt->execute(['token_id' => $tokenId, 'station_id' => $stationId]);
    $rows = $dailyReportStmt->fetchAll();

    $tokenParamQty = [];
    foreach ($rows as $row) {
        $pId = $row['parameter_id'];
        $qty = floatval($row['qty_used']);

        if (!isset($tokenParamQty[$pId])) {
            $tokenParamQty[$pId] = 0.0;
        }
        $tokenParamQty[$pId] += $qty;

        if (isset($monthlyParamData[$pId])) {
            $monthlyParamData[$pId]['total_consumed'] += $qty;
        }
    }

    $paramCompliances = [];
    $tokenPenalty = 0.0;

    foreach ($parametersList as $p) {
        $pId = $p['parameter_id'];
        $targetPerCoach = isset($targets[$pId]['qty_ml']) ? floatval($targets[$pId]['qty_ml']) : 0;
        $targetTotal = $targetPerCoach * $coachesCount;
        $consumedTotal = $tokenParamQty[$pId] ?? 0.0;

        if (isset($monthlyParamData[$pId])) {
            $monthlyParamData[$pId]['monthly_target'] += $targetTotal;
        }

        if ($targetTotal > 0) {
            $compliance = min(100.0, ($consumedTotal / $targetTotal) * 100.0);
            $paramCompliances[] = $compliance;
        } else {
            $paramCompliances[] = 100.0;
        }

        if ($consumedTotal < $targetTotal) {
            $deficit = $targetTotal - $consumedTotal;
            $penaltyQty = isset($targets[$pId]['penalty_qty_ml']) ? floatval($targets[$pId]['penalty_qty_ml']) : 0;
            if ($penaltyQty <= 0) {
                $penaltyQty = $targetPerCoach;
            }
            $basePenalty = isset($targets[$pId]['penalty']) ? floatval($targets[$pId]['penalty']) : 0;
            if ($penaltyQty > 0 && $basePenalty > 0) {
                $penaltyVal = ceil($deficit / $penaltyQty) * $basePenalty;
                $tokenPenalty += $penaltyVal;
            }
        }
    }

    $dailyScore = (count($paramCompliances) > 0) ? (array_sum($paramCompliances) / count($paramCompliances)) : 100.0;
    $totalMonthlyPenalty += $tokenPenalty;
    $dailyScores[] = $dailyScore;
}

// Compute aggregate monthly score: average of the achievements of parameters that have monthly_target > 0
$totalAchieved = 0.0;
$paramWithTargetCount = 0;
foreach ($monthlyParamData as $pId => $data) {
    if ($data['monthly_target'] > 0) {
        $target = $data['monthly_target'];
        $consumed = $data['total_consumed'];
        $pct = min(100.0, ($consumed / $target) * 100.0);
        $totalAchieved += $pct;
        $paramWithTargetCount++;
    }
}
$avgMonthlyScore = ($paramWithTargetCount > 0) ? ($totalAchieved / $paramWithTargetCount) : 0.0;

// Fetch station details
$stationQuery = $pdo->prepare("
    SELECT s.station_name, s.contractor_name, d.division_name, z.zone_name 
    FROM mcc_stations s
    LEFT JOIN mcc_divisions d ON s.division_id = d.division_id
    LEFT JOIN mcc_zones z ON d.zone_id = z.zone_id
    WHERE s.station_id = :station_id
");
$stationQuery->execute(['station_id' => $stationId]);
$stnData = $stationQuery->fetch();

$railwayName    = strtoupper($stnData['zone_name'] ?? 'NORTH EASTERN RAILWAY');
$divisionName   = strtoupper($stnData['division_name'] ?? 'LUCKNOW - NER');
$stationName    = ucfirst($stnData['station_name'] ?? 'Gorakhpur');
$contractorName = $stnData['contractor_name'] ?? 'Prime Cleaning Services';

$pageTitle = 'Monthly Vande Bharat Chemical Summary Report | MCC';

$extraStyles = "
.report-sheet-frame {
    background: #ffffff !important;
    border: 1.5px solid #000000 !important;
    padding: 25px !important;
    width: 100% !important;
    max-width: 1300px !important;
    margin: 10px auto 30px auto !important;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05) !important;
}
.report-table {
    width: 100% !important;
    border-collapse: collapse !important;
    border: 1px solid #000000 !important;
    margin-top: 15px !important;
}
.report-table thead th {
    background: #f8fafc !important;
    color: #000000 !important;
    border: 1.5px solid #000000 !important;
    font-weight: bold !important;
    text-align: center !important;
    font-size: 13px !important;
    padding: 8px 4px !important;
}
.report-table tbody td {
    border: 1px solid #000000 !important;
    color: #000000 !important;
    font-size: 12px !important;
    text-align: center !important;
    padding: 6px 4px !important;
}
.report-table td.text-left {
    text-align: left !important;
    padding-left: 8px !important;
    font-weight: 500;
}
.underlined-value {
    text-decoration: underline !important;
    font-weight: bold !important;
}
";

include 'header.php';
include 'sidebar.php';
?>

<style>
@media print {
    @page {
        size: A4 portrait;
        margin: 5mm 8mm 5mm 8mm !important;
    }
    
    .app-header, 
    .app-sidebar, 
    .app-footer, 
    .no-print, 
    .report-filter,
    form.report-filter {
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
    .report-sheet-frame {
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
    
    body * {
        background-color: transparent !important;
        background: transparent !important;
    }
    
    .report-table thead th {
        background-color: #f1f5f9 !important;
        background: #f1f5f9 !important;
        -webkit-print-color-adjust: exact !important;
        print-color-adjust: exact !important;
    }
    
    .app-main {
        padding-top: 0 !important;
        margin-left: 0 !important;
    }
    
    .report-sheet-frame {
        border: none !important;
    }
    
    .table-responsive {
        overflow: visible !important;
        display: block !important;
    }

    /* Print scaling compact styles */
    .report-sheet-frame div[style*="text-align: center"] {
        margin-bottom: 8px !important;
    }
    
    h1 {
        font-size: 13px !important;
        margin-top: 0 !important;
        margin-bottom: 2px !important;
    }
    
    .report-sheet-frame div[style*="border: 1px solid #000"] {
        margin-top: 4px !important;
        margin-bottom: 4px !important;
        padding: 2px 10px !important;
        font-size: 11px !important;
    }
    
    .report-sheet-frame div[style*="border-top: 1.5px solid #000"] {
        margin-bottom: 8px !important;
        padding: 3px 0 !important;
        font-size: 10px !important;
        gap: 4px 10px !important;
    }
    
    .report-table {
        margin-top: 5px !important;
    }
    
    .report-table thead th {
        font-size: 10px !important;
        padding: 3px 2px !important;
        border: 1px solid #000000 !important;
    }
    
    .report-table tbody td {
        font-size: 9.5px !important;
        padding: 2.5px 2px !important;
        border: 1px solid #000000 !important;
    }
    
    .report-sheet-frame div[style*="margin-top: 50px"] {
        margin-top: 15px !important;
    }
    
    div[style*="margin-top: 60px"] {
        margin-top: 25px !important;
    }
}
</style>

<main class="app-main">
    <div class="app-content">
        <div class="container-fluid" style="padding-top: 15px;">
            
            <!-- Filter Form Bar -->
            <form class="report-filter no-print" method="GET" action="vande-bharat-chemical-summary.php" style="display: flex; justify-content: space-between; align-items: center; background: #fff; border: 1px solid #e2e8f0; padding: 12px 20px; border-radius: 8px; margin-bottom: 15px; box-shadow: 0 2px 4px rgba(0,0,0,0.04);">
                <div style="display: flex; gap: 10px;">
                    <a href="vande-bharat-chemical.php" class="btn-print" style="background: #1987C6 !important; color: white !important; text-decoration: none; padding: 8px 16px; border-radius: 6px; font-weight: 700; font-size: 14px; display: inline-flex; align-items: center; border: none; height: 38px;">
                        <i class="bi bi-arrow-left me-1"></i> Back
                    </a>
                    <button type="button" class="btn-print" onclick="window.print()" style="background: #1987C6 !important; color: white !important; padding: 8px 16px; border-radius: 6px; font-weight: 700; font-size: 14px; display: inline-flex; align-items: center; border: none; height: 38px;">
                        Print All
                    </button>
                </div>
                
                <div style="display: flex; align-items: center; gap: 12px;">
                    <select id="month" name="month" style="border: 1px solid #cbd5e1; border-radius: 6px; padding: 6px 12px; font-size: 14px; background-color: #f8fafc; color: #334155; width: 140px; cursor: pointer; height: 38px;">
                        <?php
                        for ($m = 1; $m <= 12; $m++) {
                            $mVal = str_pad($m, 2, '0', STR_PAD_LEFT);
                            $mName = date('F', mktime(0, 0, 0, $m, 1));
                            $selected = ($mVal == $selectedMonth) ? 'selected' : '';
                            echo "<option value=\"$mVal\" $selected>$mName</option>";
                        }
                        ?>
                    </select>
                    
                    <select id="year" name="year" style="border: 1px solid #cbd5e1; border-radius: 6px; padding: 6px 12px; font-size: 14px; background-color: #f8fafc; color: #334155; width: 100px; cursor: pointer; height: 38px;">
                        <?php
                        $currentYear = intval(date('Y'));
                        for ($y = $currentYear - 3; $y <= $currentYear + 2; $y++) {
                            $selected = ($y == $selectedYear) ? 'selected' : '';
                            echo "<option value=\"$y\" $selected>$y</option>";
                        }
                        ?>
                    </select>
                    
                    <button type="submit" class="btn-go" style="background: #16a34a !important; color: white !important; font-weight: 700; font-size: 14px; padding: 8px 24px; border-radius: 6px; border: none; cursor: pointer; height: 38px; display: inline-flex; align-items: center;">
                        GO
                    </button>
                </div>
            </form>

            <!-- Printable Main Sheet Panel -->
            <div class="report-sheet-frame">
                
                <!-- Center Headers Layout -->
                <div style="text-align: center; margin-bottom: 20px;">
                    <h1 style="font-size: 16px; font-weight: bold; color: #000; margin: 0; text-transform: uppercase; letter-spacing: 0.5px;">
                        <?= htmlspecialchars($railwayName) ?>
                    </h1>
                    
                    <div style="border: 1px solid #000; padding: 6px 20px; display: inline-block; font-weight: bold; font-size: 14px; margin-top: 10px; margin-bottom: 10px;">
                        MCC - Vande Bharat Chemical Report
                    </div>
                </div>

                <!-- Underlined Meta Info Row -->
                <div style="display: flex; flex-wrap: wrap; justify-content: center; gap: 8px 18px; font-size: 13px; font-weight: bold; border-top: 1.5px solid #000; border-bottom: 1.5px solid #000; padding: 8px 0; margin-bottom: 20px;">
                    <div>
                        Month : <span class="underlined-value"><?= date('F - Y', mktime(0, 0, 0, intval($selectedMonth), 1, $selectedYear)) ?></span>
                    </div>
                    <div>
                        Division : <span class="underlined-value"><?= htmlspecialchars($divisionName) ?></span>
                    </div>
                    <div>
                        Station : <span class="underlined-value"><?= htmlspecialchars($stationName) ?></span>
                    </div>
                    <div>
                        Name Of Contractor : <span class="underlined-value"><?= htmlspecialchars($contractorName) ?></span>
                    </div>
                    <div>
                        Monthly Score : <span class="underlined-value"><?= number_format($avgMonthlyScore, 2) ?>%</span>
                    </div>
                    <div>
                        Total Penalty : <span class="underlined-value"><?= number_format($totalMonthlyPenalty, 0) ?></span>
                    </div>
                </div>

                <!-- Table -->
                <div class="table-responsive" style="overflow-x: auto;">
                    <table class="report-table">
                        <thead>
                            <tr>
                                <th style="width: 50px;">S.No</th>
                                <th style="text-align: left; padding-left: 10px;">Description Of Material</th>
                                <th style="width: 100px;">Target</th>
                                <th style="width: 80px;">Units</th>
                                <th style="width: 120px; white-space: nowrap;">Penalty</th>
                                <th style="width: 120px;">Quantity Used (ml)</th>
                                <th style="width: 100px;">Difference</th>
                                <th style="width: 100px;">Achieved</th>
                                <th style="width: 100px;">Deficit</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php 
                            $serial = 1;
                            foreach ($monthlyParamData as $pId => $data): 
                                $target = $data['monthly_target'];
                                $totalQty = $data['total_consumed'];
                                $difference = $totalQty - $target;

                                // Achieved and Deficit calculations to match target=0 displays as 0.00%
                                if ($target > 0) {
                                    $achievedPct = ($totalQty / $target) * 100.0;
                                    $achievedPct = min(100.0, $achievedPct);
                                    $deficitPct = 100.0 - $achievedPct;
                                } else {
                                    $achievedPct = 0.0;
                                    $deficitPct = 0.0;
                                }
                            ?>
                                <tr>
                                    <td><?= $serial++ ?></td>
                                    <td class="text-left"><?= htmlspecialchars($data['name']) ?></td>
                                    <td><?= number_format($target, 0) ?></td>
                                    <td><?= htmlspecialchars($data['units']) ?></td>
                                    <td style="white-space: nowrap; font-size: 11.5px;"><?= $data['penalty_rate'] > 0 ? 'Rs.' . number_format($data['penalty_rate'], 0) . '/' . number_format(($data['penalty_qty_ml'] > 0 ? $data['penalty_qty_ml'] : $data['qty_ml']), 0) . 'ml' : '0' ?></td>
                                    <td><strong><?= number_format($totalQty, 0) ?></strong></td>
                                    <td><?= ($difference > 0 ? '+' : '') . number_format($difference, 0) ?></td>
                                    <td><?= number_format($achievedPct, 2) ?>%</td>
                                    <td><?= number_format($deficitPct, 2) ?>%</td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                    </table>
                </div>

                <!-- Footer Signature Block -->
                <div style="display: flex; justify-content: space-between; margin-top: 50px; padding: 0 40px; font-weight: bold; font-size: 14px;">
                    <div style="text-align: center; width: 250px;">
                        <div>Signature of Contractor Representative</div>
                        <div style="border-bottom: 1.5px solid #000000; margin-top: 60px; width: 100%;"></div>
                    </div>
                    <div style="text-align: center; width: 250px;">
                        <div>CHI IN Charge</div>
                        <div style="border-bottom: 1.5px solid #000000; margin-top: 60px; width: 100%;"></div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</main>

<?php 
include 'footer.php'; 
?>
