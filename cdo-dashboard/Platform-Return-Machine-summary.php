<?php
require_once 'auth.php';

// Month & Year selection
$selectedMonth = $_GET['month'] ?? date('m');
$selectedYear = $_GET['year'] ?? date('Y');

// Standardize parameters
$selectedMonth = str_pad($selectedMonth, 2, '0', STR_PAD_LEFT);
$selectedYear = intval($selectedYear);

// Get number of days in selected month
$daysInMonth = cal_days_in_month(CAL_GREGORIAN, intval($selectedMonth), $selectedYear);

// Fetch active shifts for this station - PRT
$shiftsStmt = $pdo->prepare("
    SELECT id AS shift_id, shift AS shift_name 
    FROM mcc_prt_machine_shifts 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$shiftsStmt->execute(['station_id' => $stationId]);
$shiftsList = $shiftsStmt->fetchAll();

// Fetch active machine parameters for this station - PRT
$machinesStmt = $pdo->prepare("
    SELECT id AS machine_id, machine_no, machine_name 
    FROM mcc_prt_machine_param 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$machinesStmt->execute(['station_id' => $stationId]);
$machinesList = $machinesStmt->fetchAll();

// Fetch targets active in selected month (using SCD range logic) - PRT
$firstDay = "$selectedYear-$selectedMonth-01";
$lastDay = date('Y-m-d', strtotime("$firstDay +1 month -1 day"));

$targetsStmt = $pdo->prepare("
    SELECT machine_id, shift_id, nominated_area, penalty_amount, effective_from, effective_to 
    FROM mcc_prt_machine_target 
    WHERE station_id = :station_id
      AND effective_from <= :last_day
      AND (effective_to IS NULL OR effective_to >= :first_day)
");
$targetsStmt->execute([
    'station_id' => $stationId,
    'first_day' => $firstDay,
    'last_day' => $lastDay
]);
$monthlyTargets = $targetsStmt->fetchAll();

// Fetch all report data for the selected month - PRT
$reportsStmt = $pdo->prepare("
    SELECT report_date, parameter_id AS machine_id, shift_id, used_status 
    FROM mcc_prt_machine_report 
    WHERE station_id = :station_id AND YEAR(report_date) = :year AND MONTH(report_date) = :month
");
$reportsStmt->execute([
    'station_id' => $stationId,
    'year' => $selectedYear,
    'month' => intval($selectedMonth)
]);
$reportsRows = $reportsStmt->fetchAll();

$reportsMap = [];
$daysWithReports = [];
foreach ($reportsRows as $row) {
    $date = $row['report_date'];
    $reportsMap[$date][$row['machine_id']][$row['shift_id']] = $row['used_status'];
    $daysWithReports[$date] = true;
}

// Calculate daily scores and penalties
$dailySummary = [];
$totalMonthlyPenalty = 0.0;
$sumDailyScores = 0.0;

for ($d = 1; $d <= $daysInMonth; $d++) {
    $dayStr = str_pad($d, 2, '0', STR_PAD_LEFT);
    $dateStr = "$selectedYear-$selectedMonth-$dayStr";
    $formattedDate = date('j-M-Y', strtotime($dateStr));
    
    $dayScore = 0.0;
    $dayPenalty = 0.0;
    
    // Only calculate if reports exist for this day
    if (isset($daysWithReports[$dateStr])) {
        $dayNominated = 0;
        $dayOperated = 0;
        
        // Resolve active target for this specific day
        $dayTargetsMap = [];
        foreach ($monthlyTargets as $t) {
            $fromTs = strtotime($t['effective_from']);
            $toTs = empty($t['effective_to']) ? null : strtotime($t['effective_to']);
            $currTs = strtotime($dateStr);

            if ($currTs >= $fromTs && ($toTs === null || $currTs <= $toTs)) {
                $dayTargetsMap[$t['machine_id']][$t['shift_id']] = [
                    'nominated_area' => $t['nominated_area'],
                    'penalty_amount' => $t['penalty_amount']
                ];
            }
        }
        
        // Map of machine => is_any_nominated_shift_failed (boolean) to deduct penalty only once per machine per day
        $machinePenalized = [];

        foreach ($machinesList as $mach) {
            $mId = $mach['machine_id'];
            $machinePenalized[$mId] = false;
            
            foreach ($shiftsList as $shift) {
                $sId = $shift['shift_id'];
                $nom = $dayTargetsMap[$mId][$sId]['nominated_area'] ?? 'N';
                $penaltyRate = isset($dayTargetsMap[$mId][$sId]['penalty_amount']) ? floatval($dayTargetsMap[$mId][$sId]['penalty_amount']) : 0.00;
                
                if ($nom === 'Y') {
                    $dayNominated++;
                    $status = $reportsMap[$dateStr][$mId][$sId] ?? '-';
                    if ($status === 'Y') {
                        $dayOperated++;
                    } else {
                        // Deduct penalty once per day for that machine if it failed in any nominated shift
                        if (!$machinePenalized[$mId]) {
                            $dayPenalty += $penaltyRate;
                            $machinePenalized[$mId] = true;
                        }
                    }
                }
            }
        }
        
        $dayScore = $dayNominated > 0 ? ($dayOperated / $dayNominated) * 100 : 100.0;
        $sumDailyScores += $dayScore;
        $totalMonthlyPenalty += $dayPenalty;
        
        $dailySummary[] = [
            'date' => $dateStr,
            'formatted_date' => $formattedDate,
            'status' => 'Conducted',
            'score' => round($dayScore, 1) . "%",
            'penalty' => "₹" . number_format($dayPenalty, 2)
        ];
    } else {
        $dailySummary[] = [
            'date' => $dateStr,
            'formatted_date' => $formattedDate,
            'status' => 'Not Conducted',
            'score' => '-',
            'penalty' => '-'
        ];
    }
}

// Compute averages
$conductedDaysCount = count(array_filter($dailySummary, function($day) { return $day['status'] === 'Conducted'; }));
$averageMonthlyScore = $conductedDaysCount > 0 ? round($sumDailyScores / $conductedDaysCount, 2) : 0.00;

$pageTitle = 'Monthly PRT Machine Summary | MCC';

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
.report-table thead th {
    background: linear-gradient(180deg, #07203a 0%, #07182c 100%) !important;
    color: white !important;
    border: 1px solid #0b476a !important;
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

            <!-- Month Selection Filter Form -->
            <div class="card shadow-sm border-0 mb-4 bg-white no-print">
                <div class="card-body p-3 col-md-10 mx-auto">
                    <form method="GET" action="Platform-Return-Machine-summary.php" class="row g-3 align-items-center justify-content-center m-0">
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
                        <i class="bi bi-file-earmark-bar-graph text-primary me-2"></i> PRT Machine Monthly Summary: <?= date('F Y', strtotime($firstDay)) ?>
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

                <!-- Metrics Grid -->
                <div class="row g-3 mb-4">
                    <div class="col-md-3 col-sm-6">
                        <div class="stat-box">
                            <h3><?= $conductedDaysCount ?></h3>
                            <p>Days Conducted</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="stat-box">
                            <h3 class="text-primary"><?= number_format($averageMonthlyScore, 2) ?>%</h3>
                            <p>Average Score</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="stat-box">
                            <h3 class="text-danger">₹<?= number_format($totalMonthlyPenalty, 2) ?></h3>
                            <p>Total Penalty Deductions</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="stat-box">
                            <h3 class="text-success"><?= count($machinesList) ?></h3>
                            <p>Active Machines</p>
                        </div>
                    </div>
                </div>

                <!-- Main Daily Summary Table -->
                <div class="table-responsive">
                    <table class="report-table">
                        <thead>
                            <tr>
                                <th style="width: 70px;">Day</th>
                                <th style="width: 150px;">Date</th>
                                <th style="width: 180px;">Status</th>
                                <th>Operational Score (%)</th>
                                <th>Penalty Deduction</th>
                                <th class="no-print" style="width: 130px;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($dailySummary as $idx => $day): 
                                $isConducted = $day['status'] === 'Conducted';
                                $scoreVal = floatval(rtrim($day['score'], '%'));
                                $scoreClass = !$isConducted ? 'text-muted' : ($scoreVal >= 90 ? 'text-success font-weight-bold' : ($scoreVal >= 75 ? 'text-primary font-weight-bold' : 'text-danger font-weight-bold'));
                            ?>
                                <tr>
                                    <td><strong><?= ($idx + 1) ?></strong></td>
                                    <td><strong><?= htmlspecialchars($day['formatted_date']) ?></strong></td>
                                    <td>
                                        <span class="badge <?= $isConducted ? 'bg-success' : 'bg-secondary' ?> px-2 py-1">
                                            <?= htmlspecialchars($day['status']) ?>
                                        </span>
                                    </td>
                                    <td class="<?= $scoreClass ?>"><?= htmlspecialchars($day['score']) ?></td>
                                    <td class="<?= $isConducted && floatval(substr($day['penalty'], 1)) > 0 ? 'text-danger font-weight-bold' : '' ?>">
                                        <?= htmlspecialchars($day['penalty']) ?>
                                    </td>
                                    <td class="no-print">
                                        <?php if ($isConducted): ?>
                                            <a href="Platform-Return-Machine.php?from_date=<?= $day['date'] ?>&to_date=<?= $day['date'] ?>" class="btn btn-xs btn-outline-primary py-1 px-2 fw-bold" style="font-size: 11px;">
                                                <i class="bi bi-eye"></i> View Detail
                                            </a>
                                        <?php else: ?>
                                            -
                                        <?php endif; ?>
                                    </td>
                                </tr>
                            <?php endforeach; ?>
                        </tbody>
                        <tfoot class="table-light font-weight-bold">
                            <tr>
                                <td colspan="3" class="text-end">Monthly Summary Totals:</td>
                                <td class="text-primary fs-6"><?= number_format($averageMonthlyScore, 2) ?>%</td>
                                <td class="text-danger fs-6">₹<?= number_format($totalMonthlyPenalty, 2) ?></td>
                                <td class="no-print"></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

        </div>
    </div>
</main>

<?php include 'footer.php'; ?>
