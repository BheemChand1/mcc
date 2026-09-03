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

$targetMonthDate = "$selectedYear-$selectedMonth-01";
$firstDayOfMonth = "$selectedYear-$selectedMonth-01";
$lastDayOfMonth = date('Y-m-t', strtotime($firstDayOfMonth));

// Fetch active categories, shifts, and mapped roles (sorted by order_no)
// Helper function to identify unskilled manpower roles
if (!function_exists('isUnskilledRole')) {
    function isUnskilledRole($roleName) {
        $r = strtolower(trim($roleName));
        if (strpos($r, 'supervisor') !== false || strpos($r, 'chi') !== false || strpos($r, 'officer') !== false) {
            return false;
        }
        if (strpos($r, 'unskilled') !== false || strpos($r, 'staff') !== false || strpos($r, 'safaiwala') !== false || strpos($r, 'safai') !== false || strpos($r, 'cleaner') !== false || strpos($r, 'labour') !== false || strpos($r, 'helper') !== false) {
            return true;
        }
        if (strpos($r, 'semi') !== false || (strpos($r, 'skilled') !== false && strpos($r, 'unskilled') === false)) {
            return false;
        }
        return true;
    }
}

// Helper function to map category to scorecard table
if (!function_exists('getScorecardTableForCategory')) {
    function getScorecardTableForCategory($categoryName) {
        $c = strtolower(trim($categoryName));
        if (strpos($c, 'normal') !== false) {
            return 'mcc_normal_scorecard_report';
        } elseif (strpos($c, 'intensive') !== false) {
            return 'mcc_intensive_scorecard_2_report';
        } elseif (strpos($c, 'prt') !== false || strpos($c, 'platform') !== false) {
            return 'mcc_prt_scorecard_report';
        } elseif (strpos($c, 'vande') !== false || strpos($c, 'vb') !== false) {
            return 'mcc_vb_scorecard_report';
        }
        return null;
    }
}

// Helper function to get distinct coach count for a railway date (06:00 AM of $date to 07:00 AM of next day)
if (!function_exists('getRailwayDateCoachCount')) {
    function getRailwayDateCoachCount($pdo, $tableName, $stationId, $date) {
        static $coachCache = [];
        $cacheKey = "{$tableName}_{$stationId}_{$date}";
        if (isset($coachCache[$cacheKey])) {
            return $coachCache[$cacheKey];
        }
        
        $startDateTime = $date . ' 06:00:00';
        $nextDate = date('Y-m-d', strtotime($date . ' +1 day'));
        $endDateTime = $nextDate . ' 07:00:00';
        
        try {
            $stmt = $pdo->prepare("
                SELECT COUNT(DISTINCT token_id, coach_no) AS total_coaches
                FROM {$tableName}
                WHERE station_id = :station_id
                  AND (
                      (created_at IS NOT NULL AND created_at >= :start_dt AND created_at <= :end_dt)
                      OR (created_at IS NULL AND report_date = :rep_date)
                  )
            ");
            $stmt->execute([
                'station_id' => $stationId,
                'start_dt' => $startDateTime,
                'end_dt' => $endDateTime,
                'rep_date' => $date
            ]);
            $count = intval($stmt->fetchColumn() ?: 0);
        } catch (Exception $e) {
            $count = 0;
        }
        
        $coachCache[$cacheKey] = $count;
        return $count;
    }
}

// Fetch active categories, shifts, and mapped roles (sorted by order_no)
$categories = [];
$catStmt = $pdo->prepare("
    SELECT id, category_name 
    FROM mcc_manpower_categories 
    WHERE station_id = :station_id AND status = 'Active' 
    ORDER BY order_no ASC, id ASC
");
$catStmt->execute(['station_id' => $stationId]);
$catList = $catStmt->fetchAll();

foreach ($catList as $cat) {
    $categoryId = $cat['id'];
    
    // Shifts for this category
    $shiftStmt = $pdo->prepare("
        SELECT id, shift_name 
        FROM mcc_manpower_shifts 
        WHERE category_id = :category_id AND status = 'Active' 
        ORDER BY order_no ASC, id ASC
    ");
    $shiftStmt->execute(['category_id' => $categoryId]);
    $shifts = $shiftStmt->fetchAll();

    // Distinct mapped roles for this category (sorted by role's order_no)
    $rolesStmt = $pdo->prepare("
        SELECT DISTINCT t.id AS manpower_type_id, t.role_name, t.order_no
        FROM mcc_manpower_shift_type_map map
        JOIN mcc_manpower_shifts sh ON map.shift_id = sh.id
        JOIN mcc_manpower_types t ON map.manpower_type_id = t.id
        WHERE sh.category_id = :category_id AND sh.status = 'Active' AND t.status = 'Active'
        ORDER BY t.order_no ASC, t.id ASC
    ");
    $rolesStmt->execute(['category_id' => $categoryId]);
    $roles = $rolesStmt->fetchAll();

    if (!empty($roles) && !empty($shifts)) {
        $categories[] = [
            'id' => $cat['id'],
            'category_name' => $cat['category_name'],
            'shifts' => $shifts,
            'roles' => $roles
        ];
    }
}

// Fetch target norms for the selected month
$targetsMap = [];
$targetsStmt = $pdo->prepare("
    SELECT category_id, manpower_type_id, target_qty 
    FROM mcc_manpower_targets 
    WHERE station_id = :station_id AND target_date = :target_date
");
$targetsStmt->execute([
    'station_id' => $stationId,
    'target_date' => $targetMonthDate
]);
$targetsRows = $targetsStmt->fetchAll();
foreach ($targetsRows as $row) {
    $catId = intval($row['category_id']);
    $tId = intval($row['manpower_type_id']);
    $targetsMap[$catId][$tId] = $row['target_qty'];
    if ($catId === 0) {
        $targetsMap[0][$tId] = $row['target_qty'];
    }
}

// Fetch all active manpower types (roles) for this station to format the header and lookup penalty rates
$rolesStmt = $pdo->prepare("
    SELECT id, role_name 
    FROM mcc_manpower_types 
    WHERE station_id = :station_id AND status = 'Active' 
    ORDER BY order_no ASC, id ASC
");
$rolesStmt->execute(['station_id' => $stationId]);
$rolesList = $rolesStmt->fetchAll();

// Fetch effective penalties configurations (most recent month <= selected month)
$existingPenalties = [];
$penStmt = $pdo->prepare("
    SELECT p1.manpower_type_id, p1.absent_penalty, p1.dress_penalty, p1.gears_penalty 
    FROM mcc_manpower_penalties p1
    INNER JOIN (
        SELECT manpower_type_id, MAX(effective_month) AS max_month
        FROM mcc_manpower_penalties
        WHERE station_id = :station_id1 AND effective_month <= :selected_month
        GROUP BY manpower_type_id
    ) p2 ON p1.manpower_type_id = p2.manpower_type_id AND p1.effective_month = p2.max_month
    WHERE p1.station_id = :station_id2
");
$penStmt->execute([
    'station_id1' => $stationId,
    'station_id2' => $stationId,
    'selected_month' => $targetMonthDate
]);
$penRows = $penStmt->fetchAll();
foreach ($penRows as $row) {
    $existingPenalties[$row['manpower_type_id']] = [
        'absent' => $row['absent_penalty'],
        'dress' => $row['dress_penalty'],
        'gears' => $row['gears_penalty']
    ];
}

// Fetch all log data for the selected month
$logsMap = [];
$logsStmt = $pdo->prepare("
    SELECT 
        report_date,
        shift_id,
        manpower_type_id,
        provided_qty,
        absent_qty,
        no_dress_qty,
        no_ppe_qty
    FROM mcc_manpower_log
    WHERE station_id = :station_id AND YEAR(report_date) = :year AND MONTH(report_date) = :month
");
$logsStmt->execute([
    'station_id' => $stationId,
    'year' => $selectedYear,
    'month' => intval($selectedMonth)
]);
$logsRows = $logsStmt->fetchAll();

foreach ($logsRows as $row) {
    $date = $row['report_date'];
    $logsMap[$date][$row['shift_id']][$row['manpower_type_id']] = [
        'provided' => $row['provided_qty'],
        'absent' => $row['absent_qty'],
        'no_dress' => $row['no_dress_qty'],
        'no_ppe' => $row['no_ppe_qty']
    ];
}

// Dynamically construct the penalty rate list for the column header
$headerPenalties = [];
foreach ($rolesList as $role) {
    $roleId = $role['id'];
    $roleName = $role['role_name'];
    $rate = isset($existingPenalties[$roleId]['absent']) ? floatval($existingPenalties[$roleId]['absent']) : 0.0;
    $formattedRate = ($rate == intval($rate)) ? intval($rate) : $rate;
    $headerPenalties[] = "$roleName @ Rs $formattedRate/ Person";
}
$penaltyHeaderSuffix = implode(', ', $headerPenalties);
$penaltyHeaderTitle = "Penalty for the Day";
if (!empty($penaltyHeaderSuffix)) {
    $penaltyHeaderTitle .= " : " . $penaltyHeaderSuffix;
}

// Calculate daily scores and penalties
$dailySummary = [];
$totalMonthlyPenalty = 0.0;
$sumDailyScores = 0.0;

for ($d = 1; $d <= $daysInMonth; $d++) {
    $dayStr = str_pad($d, 2, '0', STR_PAD_LEFT);
    $dateStr = "$selectedYear-$selectedMonth-$dayStr";
    $formattedDate = date('j-M-Y', strtotime($dateStr));
    
    $dayToProvide = 0;
    $dayAvailable = 0;
    $dayAbsent = 0;
    $dayNoDress = 0;
    $dayNoPpe = 0;
    $dayPenalty = 0.0;
    $dayScore = 0.0;
    
    // Sum target norms for the day (unskilled targets multiplied dynamically by coach counts for scorecard categories)
    $effectiveTargets = [];
    foreach ($categories as $cat) {
        $cId = $cat['id'];
        $scorecardTable = getScorecardTableForCategory($cat['category_name']);
        $coachCount = ($scorecardTable !== null) ? getRailwayDateCoachCount($pdo, $scorecardTable, $stationId, $dateStr) : 0;

        foreach ($cat['roles'] as $role) {
            $tId = $role['manpower_type_id'];
            $rawNorm = floatval($targetsMap[$cId][$tId] ?? $targetsMap[0][$tId] ?? 0);
            $isUnskilled = isUnskilledRole($role['role_name']);

            if ($scorecardTable !== null && $isUnskilled) {
                $effectiveNorm = $rawNorm * $coachCount;
            } else {
                $effectiveNorm = $rawNorm;
            }
            $effectiveTargets[$cId][$tId] = $effectiveNorm;
            $dayToProvide += $effectiveNorm;
        }
    }
    
    $hasLogsForDay = isset($logsMap[$dateStr]);
    if ($hasLogsForDay) {
        $cappedAvailable = 0;
        foreach ($categories as $cat) {
            $cId = $cat['id'];
            foreach ($cat['roles'] as $role) {
                $tId = $role['manpower_type_id'];
                $effectiveNorm = $effectiveTargets[$cId][$tId] ?? 0;
                
                $roleProvided = 0;
                $roleAbsent = 0;
                $roleNoDress = 0;
                $roleNoPpe = 0;
                
                foreach ($cat['shifts'] as $sh) {
                    $shId = $sh['id'];
                    if (isset($logsMap[$dateStr][$shId][$tId])) {
                        $prov = intval($logsMap[$dateStr][$shId][$tId]['provided'] ?? 0);
                        $abs = intval($logsMap[$dateStr][$shId][$tId]['absent'] ?? 0);
                        $noDress = intval($logsMap[$dateStr][$shId][$tId]['no_dress'] ?? 0);
                        $noPpe = intval($logsMap[$dateStr][$shId][$tId]['no_ppe'] ?? 0);

                        $roleProvided += $prov;
                        $roleAbsent += $abs;
                        $roleNoDress += $noDress;
                        $roleNoPpe += $noPpe;
                    }
                }
                
                $avail = max(0, $roleProvided - $roleAbsent);
                $dayAvailable += $avail;
                $dayAbsent += $roleAbsent;
                $dayNoDress += $roleNoDress;
                $dayNoPpe += $roleNoPpe;

                // Calculate penalty for this role on this day
                $rates = $existingPenalties[$tId] ?? ['absent' => 0.0, 'dress' => 0.0, 'gears' => 0.0];
                $rolePenalty = ($roleAbsent * floatval($rates['absent'])) 
                             + ($roleNoDress * floatval($rates['dress'])) 
                             + ($roleNoPpe * floatval($rates['gears']));
                $dayPenalty += $rolePenalty;

                // Capped availability for daily score
                $cappedAvailable += min($avail, $effectiveNorm);
            }
        }
        $dayScore = $dayToProvide > 0 ? ($cappedAvailable / $dayToProvide) * 100.0 : 100.0;
    } else {
        $dayScore = 0.0;
    }
    
    $totalMonthlyPenalty += $dayPenalty;
    $sumDailyScores += $dayScore;
    
    $dailySummary[] = [
        's_no' => $d,
        'date' => $formattedDate,
        'to_provide' => $dayToProvide,
        'available' => $dayAvailable,
        'absent' => $dayAbsent,
        'no_dress' => $dayNoDress,
        'no_ppe' => $dayNoPpe,
        'penalty' => $dayPenalty
    ];
}

$avgMonthlyScore = $daysInMonth > 0 ? ($sumDailyScores / $daysInMonth) : 0.0;

$pageTitle = 'Monthly Manpower Summary Report | CDO Dashboard';

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
            <form class="report-filter no-print" method="GET" style="display: flex; justify-content: space-between; align-items: center; background: #fff; border: 1px solid #e2e8f0; padding: 12px 20px; border-radius: 8px; margin-bottom: 15px; box-shadow: 0 2px 4px rgba(0,0,0,0.04); flex-wrap: wrap; gap: 15px;">
                <div style="display: flex; gap: 10px;">
                    <a href="man-power-log.php?from_date=<?= urlencode($firstDayOfMonth) ?>&to_date=<?= urlencode($lastDayOfMonth) ?>" class="btn-print" style="background: #1987C6 !important; color: white !important; text-decoration: none; padding: 8px 16px; border-radius: 6px; font-weight: 700; font-size: 14px; display: inline-flex; align-items: center; border: none; height: 38px;">
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
            <div class="summary-sheet-frame" style="text-align: center;">
                
                <!-- Main Header Title Blocks -->
                <h1 style="font-size: 1.3rem; font-weight: bold; margin: 0; text-transform: uppercase;"><?= htmlspecialchars($railwayName) ?></h1>
                <div style="margin: 10px 0;">
                    <span style="font-size: 1.2rem; font-weight: bold; border: 1.5px solid #000; padding: 4px 15px; text-transform: uppercase; display: inline-block;">MCC - Manpower Summary</span>
                </div>

                <!-- Underlined Meta Info Row (exactly styled as requested in image) -->
                <div style="display: flex; flex-wrap: wrap; justify-content: center; gap: 8px 24px; font-size: 13px; font-weight: bold; border-top: 1.5px solid #000; border-bottom: 1.5px solid #000; padding: 8px 0; margin-bottom: 20px; text-transform: uppercase; text-align: center;">
                    <div>
                        Month <?= $selectedMonth ?> : <span class="underlined-value"><?= date('F', mktime(0, 0, 0, intval($selectedMonth), 1)) ?></span>
                    </div>
                    <div>
                        Year : <span class="underlined-value"><?= $selectedYear ?></span>
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
                        Total Month Penalty : <span class="underlined-value"><?= number_format($totalMonthlyPenalty, 0) ?></span>
                    </div>
                </div>

                <!-- Table -->
                <div class="table-responsive">
                    <table class="report-table">
                        <thead>
                            <tr>
                                <th style="width: 150px;">Date</th>
                                <th style="width: 180px;">To Be Provided as per Norms</th>
                                <th style="width: 140px;">Actual Available</th>
                                <th style="width: 120px;">Absent (A)</th>
                                <th style="width: 180px;">Found Without Dress Code/ ID Cards/ Batches (D)</th>
                                <th style="width: 180px;">Found Without Protective Gears (G)</th>
                                <th><?= htmlspecialchars($penaltyHeaderTitle) ?></th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($dailySummary as $day): ?>
                                <tr>
                                    <td style="font-weight: 600;"><?= htmlspecialchars($day['date']) ?></td>
                                    <td><?= number_format($day['to_provide'], 0) ?></td>
                                    <td><?= number_format($day['available'], 0) ?></td>
                                    <td><?= number_format($day['absent'], 0) ?></td>
                                    <td><?= number_format($day['no_dress'], 0) ?></td>
                                    <td><?= number_format($day['no_ppe'], 0) ?></td>
                                    <td><?= number_format($day['penalty'], 0) ?></td>
                                </tr>
                            <?php endforeach; ?>
                            
                            <!-- Bottom Summary Row -->
                            <tr style="font-weight: bold; background-color: #f8fafc;">
                                <td colspan="6" style="text-align: right; padding-right: 15px;">Total Month Penalty</td>
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
