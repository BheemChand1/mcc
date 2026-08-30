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

// Fetch active shifts for this station
$shiftsStmt = $pdo->prepare("
    SELECT id AS shift_id, shift AS shift_name 
    FROM mcc_vb_machine_shifts 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$shiftsStmt->execute(['station_id' => $stationId]);
$shiftsList = $shiftsStmt->fetchAll();

// Fetch active machine parameters for this station
$machinesStmt = $pdo->prepare("
    SELECT id AS machine_id, machine_no, machine_name 
    FROM mcc_vb_machine_param 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$machinesStmt->execute(['station_id' => $stationId]);
$machinesList = $machinesStmt->fetchAll();

// Fetch targets active in selected month (using SCD range logic) - Vande Bharat
$firstDay = "$selectedYear-$selectedMonth-01";
$lastDay = date('Y-m-d', strtotime("$firstDay +1 month -1 day"));

$targetsStmt = $pdo->prepare("
    SELECT machine_id, shift_id, nominated_area, penalty_amount, effective_from, effective_to
    FROM mcc_vb_machine_target
    WHERE station_id = :station_id
      AND effective_from <= :last_day
      AND (effective_to IS NULL OR effective_to >= :first_day)
");
$targetsStmt->execute([
    'station_id' => $stationId,
    'first_day' => $firstDay,
    'last_day' => $lastDay
]);
$targetsRows = $targetsStmt->fetchAll();

// Fetch all report data for the selected month
$reportsStmt = $pdo->prepare("
    SELECT report_date, parameter_id AS machine_id, shift_id, used_status 
    FROM mcc_vb_machine_report 
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
    
    if (isset($daysWithReports[$dateStr])) {
        $dayNominated = 0;
        $dayOperated = 0;
        
        // Resolve active targets for this specific day
        $dayTargetsMap = [];
        foreach ($targetsRows as $tm) {
            $fromTs = strtotime($tm['effective_from']);
            $toTs = empty($tm['effective_to']) ? null : strtotime($tm['effective_to']);
            $currTs = strtotime($dateStr);

            if ($currTs >= $fromTs && ($toTs === null || $currTs <= $toTs)) {
                $dayTargetsMap[$tm['machine_id']][$tm['shift_id']] = [
                    'nominated_area' => $tm['nominated_area'],
                    'penalty_amount' => $tm['penalty_amount']
                ];
            }
        }
        
        foreach ($machinesList as $mach) {
            $mId = $mach['machine_id'];
            foreach ($shiftsList as $shift) {
                $sId = $shift['shift_id'];
                $isNominated = ($dayTargetsMap[$mId][$sId]['nominated_area'] ?? 'N') === 'Y';
                if ($isNominated) {
                    $dayNominated++;
                    $status = $reportsMap[$dateStr][$mId][$sId] ?? '-';
                    if ($status === 'Y') {
                        $dayOperated++;
                    } else {
                        // Charged penalty for nominated but not operated
                        $penaltyRate = floatval($dayTargetsMap[$mId][$sId]['penalty_amount'] ?? 0.0);
                        $dayPenalty += $penaltyRate;
                    }
                }
            }
        }
        $dayScore = $dayNominated > 0 ? ($dayOperated / $dayNominated) * 100.0 : 100.0;
    }
    
    $totalMonthlyPenalty += $dayPenalty;
    $sumDailyScores += $dayScore;
    
    $dailySummary[] = [
        's_no' => $d,
        'date' => $formattedDate,
        'score' => $dayScore,
        'penalty' => $dayPenalty
    ];
}

$avgMonthlyScore = $daysInMonth > 0 ? ($sumDailyScores / $daysInMonth) : 0.0;

$pageTitle = 'Monthly Vande Bharat Machine Summary Report | MCC';

$extraStyles = "
.summary-sheet-frame {
    background: #ffffff !important;
    border: 1.5px solid #000000 !important;
    padding: 25px !important;
    width: 100% !important;
    max-width: 1300px !important;
    margin: 10px auto 30px auto !important;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05) !important;
    border-radius: 8px !important;
}
.report-table {
    width: 100% !important;
    border-collapse: collapse !important;
    border: 1px solid #cbd5e1 !important;
    margin-top: 15px !important;
}
.report-table thead th {
    background: linear-gradient(180deg, #07203a 0%, #07182c 100%) !important;
    color: white !important;
    border: 1px solid #0b476a !important;
    font-weight: bold !important;
    text-align: center !important;
    font-size: 13px !important;
    padding: 8px 6px !important;
}
.report-table tbody td {
    border: 1px solid #cbd5e1 !important;
    color: #000000 !important;
    font-size: 13px !important;
    text-align: center !important;
    padding: 6px 6px !important;
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
    .summary-sheet-frame {
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
    
    .summary-sheet-frame {
        border: none !important;
    }
    
    .table-responsive {
        overflow: visible !important;
        display: block !important;
    }
}
</style>

<main class="app-main">
    <div class="app-content">
        <div class="container-fluid" style="padding-top: 15px;">
            
            <!-- Filter & Navigation Bar -->
            <form class="report-filter no-print" method="GET" action="vande-bharat-machine-summary.php" style="display: flex; justify-content: space-between; align-items: center; background: #fff; border: 1px solid #e2e8f0; padding: 12px 20px; border-radius: 8px; margin-bottom: 15px; box-shadow: 0 2px 4px rgba(0,0,0,0.04); flex-wrap: wrap; gap: 15px;">
                <div style="display: flex; gap: 10px;">
                    <a href="vande-bharat-machine.php" class="btn-print" style="background: #1987C6 !important; color: white !important; text-decoration: none; padding: 8px 16px; border-radius: 6px; font-weight: 700; font-size: 14px; display: inline-flex; align-items: center; border: none; height: 38px;">
                        <i class="bi bi-arrow-left me-1"></i> Back
                    </a>
                    <button type="button" class="btn-print" onclick="window.print()" style="background: #1987C6 !important; color: white !important; padding: 8px 16px; border-radius: 6px; font-weight: 700; font-size: 14px; display: inline-flex; align-items: center; border: none; height: 38px;">
                        Print All
                    </button>
                </div>
                
                <div style="display: flex; align-items: center; gap: 12px;">
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
                    
                    <button type="submit" class="btn-go" style="background: #16a34a !important; color: white !important; font-weight: 700; font-size: 14px; padding: 8px 24px; border-radius: 6px; border: none; cursor: pointer; height: 38px; display: inline-flex; align-items: center;">
                        GO
                    </button>
                </div>
            </form>

            <!-- Printable Main Summary Panel -->
            <div class="summary-sheet-frame">
                
                <!-- Center Header -->
                <div style="text-align: center; margin-bottom: 20px;">
                    <h1 style="font-size: 16px; font-weight: bold; color: #000; margin: 0; text-transform: uppercase; letter-spacing: 0.5px;">
                        <?= htmlspecialchars($railwayName) ?>
                    </h1>
                    
                    <div style="border: 1px solid #000; padding: 6px 20px; display: inline-block; font-weight: bold; font-size: 14px; margin-top: 10px; margin-bottom: 10px;">
                        MCC - Vande Bharat Machine Report
                    </div>
                </div>

                <!-- Underlined Meta Info Row -->
                <div style="display: flex; flex-wrap: wrap; justify-content: center; gap: 8px 24px; font-size: 13px; font-weight: bold; border-top: 1.5px solid #000; border-bottom: 1.5px solid #000; padding: 8px 0; margin-bottom: 20px; text-transform: uppercase; text-align: center;">
                    <div>
                        Month : <span class="underlined-value"><?= date('F', mktime(0, 0, 0, intval($selectedMonth), 1)) ?></span>
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
                        Total Score : <span class="underlined-value"><?= number_format($avgMonthlyScore, 2) ?>%</span>
                    </div>
                    <div>
                        Total Month Penalty : <span class="underlined-value"><?= number_format($totalMonthlyPenalty, 0) ?></span>
                    </div>
                </div>

                <!-- Table -->
                <div class="table-responsive">
                    <table class="report-table">
                        <thead>
                            <tr>
                                <th style="width: 80px;">S.No</th>
                                <th style="width: 250px;">Date</th>
                                <th style="width: 200px;">Score(%)</th>
                                <th>Penalty for the Day</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($dailySummary as $day): ?>
                                <tr>
                                    <td><?= $day['s_no'] ?></td>
                                    <td><?= htmlspecialchars($day['date']) ?></td>
                                    <td><?= number_format($day['score'], 0) ?></td>
                                    <td><?= number_format($day['penalty'], 0) ?></td>
                                </tr>
                            <?php endforeach; ?>
                            
                            <!-- Bottom Summary Row -->
                            <tr style="font-weight: bold; background-color: #f8fafc;">
                                <td colspan="3" style="text-align: right; padding-right: 15px;">Total Month Penalty</td>
                                <td><?= number_format($totalMonthlyPenalty, 0) ?></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- Footer Signature Block -->
                <div style="display: flex; justify-content: space-between; margin-top: 60px; padding: 0 40px; font-weight: bold; font-size: 14px;">
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

<?php include 'footer.php'; ?>
