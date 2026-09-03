<?php
require_once 'auth.php';

$fromDate = $_GET['from_date'] ?? date('Y-m-d', strtotime('-6 days'));
$toDate = $_GET['to_date'] ?? date('Y-m-d');

// Generate list of dates between fromDate and toDate
$datesList = [];
$currentDate = $fromDate;
while (strtotime($currentDate) <= strtotime($toDate)) {
    $datesList[] = $currentDate;
    $currentDate = date('Y-m-d', strtotime($currentDate . ' +1 day'));
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
    
    // Fetch shifts for this category
    $shiftStmt = $pdo->prepare("
        SELECT id, shift_name 
        FROM mcc_manpower_shifts 
        WHERE category_id = :category_id AND status = 'Active' 
        ORDER BY order_no ASC, id ASC
    ");
    $shiftStmt->execute(['category_id' => $categoryId]);
    $shifts = $shiftStmt->fetchAll();

    // Fetch mapped distinct roles for this category (sorted by role's order_no)
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

// Fetch target norms for the selected months in range
$startMonth = date('Y-m-01', strtotime($fromDate));
$endMonth = date('Y-m-01', strtotime($toDate));

$targetsMap = [];
$targetsStmt = $pdo->prepare("
    SELECT target_date, category_id, manpower_type_id, target_qty 
    FROM mcc_manpower_targets 
    WHERE station_id = :station_id AND target_date BETWEEN :start_month AND :end_month
");
$targetsStmt->execute([
    'station_id' => $stationId,
    'start_month' => $startMonth,
    'end_month' => $endMonth
]);
$targetsRows = $targetsStmt->fetchAll();
foreach ($targetsRows as $row) {
    $catId = intval($row['category_id']);
    $tId = intval($row['manpower_type_id']);
    $targetsMap[$row['target_date']][$catId][$tId] = $row['target_qty'];
    if ($catId === 0) {
        $targetsMap[$row['target_date']][0][$tId] = $row['target_qty'];
    }
}

// Fetch submitted daily logs in date range
$logsMap = [];
$hasLogs = false; // globally whether there are ANY logs in the range
$logStmt = $pdo->prepare("
    SELECT 
        report_date,
        shift_id,
        manpower_type_id,
        provided_qty,
        absent_qty,
        no_dress_qty,
        no_ppe_qty,
        chi_signature
    FROM mcc_manpower_log
    WHERE station_id = :station_id AND report_date BETWEEN :from_date AND :to_date
");
$logStmt->execute([
    'station_id' => $stationId,
    'from_date' => $fromDate,
    'to_date' => $toDate
]);
$logRows = $logStmt->fetchAll();

foreach ($logRows as $row) {
    $hasLogs = true;
    $date = $row['report_date'];
    $logsMap[$date][$row['shift_id']][$row['manpower_type_id']] = [
        'provided' => $row['provided_qty'],
        'absent' => $row['absent_qty'],
        'no_dress' => $row['no_dress_qty'],
        'no_ppe' => $row['no_ppe_qty'],
        'chi' => $row['chi_signature']
    ];
}

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

$extraStyles = "
.sub-category {
    background:#f2f2f2 !important;
    font-weight:600;
    text-align:left !important;
}
.sub-category td {
    padding-left:18px !important;
    text-align:left !important;
    font-weight:700;
}
.shift-cell {
    white-space: nowrap !important;
}
.datewise-sheet {
    margin-bottom: 40px !important;
}
@media print {
    .datewise-sheet {
        page-break-after: always !important;
        break-after: page !important;
    }
    .datewise-sheet:last-child {
        page-break-after: avoid !important;
        break-after: avoid !important;
    }
}
";

include 'header.php';
include 'sidebar.php';
?>

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
                <a href="manpower-target.php?month=<?= date('m', strtotime($fromDate)) ?>&year=<?= date('Y', strtotime($fromDate)) ?>" class="btn-print" style="background: #1987C6 !important; text-decoration: none;">Manpower Target</a>
                <a href="manpower-penalty.php?month=<?= date('m', strtotime($fromDate)) ?>&year=<?= date('Y', strtotime($fromDate)) ?>" class="btn-print" style="background: #1987C6 !important; text-decoration: none;">Manpower Penalty</a>
                <a href="manpower-summary.php?month=<?= date('m', strtotime($fromDate)) ?>&year=<?= date('Y', strtotime($fromDate)) ?>" class="btn-print" style="background: #1987C6 !important; text-decoration: none;">Summary</a>
            </form>

            <div class="report-wrap">
                <?php foreach ($datesList as $date): 
                    $targetMonthDate = date('Y-m-01', strtotime($date));
                    $dateLogs = $logsMap[$date] ?? [];
                    $hasLogsForDate = !empty($dateLogs);
                    
                    // Calculate total score percentage based on staff availability against norms for this date
                    $totalNorms = 0;
                    $totalAvailable = 0;
                    
                    foreach ($categories as $cat) {
                        $cId = $cat['id'];
                        $scorecardTable = getScorecardTableForCategory($cat['category_name']);
                        $coachCount = ($scorecardTable !== null) ? getRailwayDateCoachCount($pdo, $scorecardTable, $stationId, $date) : 0;

                        foreach ($cat['roles'] as $role) {
                            $tId = $role['manpower_type_id'];
                            $rawNorm = floatval($targetsMap[$targetMonthDate][$cId][$tId] ?? $targetsMap[$targetMonthDate][0][$tId] ?? 0);
                            $isUnskilled = isUnskilledRole($role['role_name']);
                            
                            // Unskilled manpower target is multiplied by coach count for dynamic scorecard categories
                            if ($scorecardTable !== null && $isUnskilled) {
                                $effectiveNorm = $rawNorm * $coachCount;
                            } else {
                                $effectiveNorm = $rawNorm;
                            }
                            $totalNorms += $effectiveNorm;
                            
                            $roleTotalProvided = 0;
                            $roleTotalAbsent = 0;
                            foreach ($cat['shifts'] as $sh) {
                                $sId = $sh['id'];
                                if (isset($dateLogs[$sId][$tId])) {
                                    $roleTotalProvided += intval($dateLogs[$sId][$tId]['provided']);
                                    $roleTotalAbsent += intval($dateLogs[$sId][$tId]['absent']);
                                }
                            }
                            $avail = max(0, $roleTotalProvided - $roleTotalAbsent);
                            $totalAvailable += min($avail, $effectiveNorm);
                        }
                    }
                    
                    $scorePercent = $totalNorms > 0 ? round(($totalAvailable / $totalNorms) * 100, 1) . "%" : "100%";
                    if (!$hasLogsForDate) {
                        $scorePercent = "100%";
                    }
                ?>
                    <div class="report-frame datewise-sheet">
                        <?php if (!$hasLogsForDate): ?>
                            <div class="alert alert-warning no-print" style="margin: 0 0 20px 0; border-radius: 8px; border: 1px solid #ffeeba; background-color: #fff3cd; color: #856404; padding: 12px 20px;">
                                <i class="bi bi-exclamation-triangle-fill me-2"></i> No manpower logs submitted for <?= htmlspecialchars(date('d-m-Y', strtotime($date))) ?>. Displaying configuration and norms.
                            </div>
                        <?php endif; ?>

                        <div class="report-header">
                            <h2>Manpower Log</h2>
                        </div>

                        <div class="report-meta-section">
                            <div class="meta-row">
                                <div class="meta-item"><span>Railway:</span> <?= htmlspecialchars($railwayName) ?></div>
                                <div class="meta-item"><span>Date:</span> <?= htmlspecialchars(date('d-m-Y', strtotime($date))) ?></div>
                                <div class="meta-item"><span>Division:</span> <?= htmlspecialchars($divisionName) ?></div>
                                <div class="meta-item"><span>Station:</span> <?= htmlspecialchars($stationName) ?></div>
                            </div>
                            <div class="meta-row">
                                <div class="meta-item"><span>Contractor:</span> <?= htmlspecialchars($contractorName) ?></div>
                                <div class="meta-item"><span>Total Score:</span> <?= htmlspecialchars($scorePercent) ?></div>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="report-table">
                                <thead>
                                    <tr>
                                        <th style="text-align: left; padding-left: 15px; width: 220px;">Description</th>
                                        <?php if (!empty($categories)): ?>
                                            <?php foreach ($categories[0]['shifts'] as $sh): ?>
                                                <th style="text-align: center; width: 100px;"><?= htmlspecialchars($sh['shift_name']) ?></th>
                                            <?php endforeach; ?>
                                        <?php else: ?>
                                            <th style="text-align: center; width: 100px;">Shift 1</th>
                                            <th style="text-align: center; width: 100px;">Shift 2</th>
                                            <th style="text-align: center; width: 100px;">Shift 3</th>
                                        <?php endif; ?>
                                        <th style="text-align: center; width: 100px;">Total</th>
                                        <th style="text-align: center; width: 120px;">Target</th>
                                        <th style="text-align: center; width: 160px;">Found without dress code & ID cards</th>
                                        <th style="text-align: center; width: 160px;">Found without protective gears</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if (empty($categories)): ?>
                                        <tr>
                                            <td colspan="8" style="text-align:center;">No manpower categories or shifts configured. Go to <a href="manpower-config.php">Man Power Config</a> to add.</td>
                                        </tr>
                                    <?php else: ?>
                                        <?php 
                                        $grandShiftTotals = [];
                                        $grandTotalProvided = 0;
                                        $grandTotalTarget = 0;
                                        $grandTotalNoDress = 0;
                                        $grandTotalNoPpe = 0;

                                        foreach ($categories as $cat): 
                                            $cId = $cat['id'];
                                            $scorecardTable = getScorecardTableForCategory($cat['category_name']);
                                            $coachCount = ($scorecardTable !== null) ? getRailwayDateCoachCount($pdo, $scorecardTable, $stationId, $date) : 0;

                                            $catShiftTotals = [];
                                            foreach ($cat['shifts'] as $sh) {
                                                $catShiftTotals[$sh['id']] = 0;
                                                if (!isset($grandShiftTotals[$sh['id']])) {
                                                    $grandShiftTotals[$sh['id']] = 0;
                                                }
                                            }
                                            $catTotalProvided = 0;
                                            $catTotalTarget = 0;
                                            $catTotalNoDress = 0;
                                            $catTotalNoPpe = 0;
                                            $colCount = count($cat['shifts']) + 5;
                                        ?>
                                            <!-- Category Subheader -->
                                            <tr class="sub-category">
                                                <td colspan="<?= $colCount ?>" style="text-align:center !important; padding-left:0 !important; text-transform: uppercase;">
                                                    <?= htmlspecialchars($cat['category_name']) ?>
                                                    <?php if ($scorecardTable !== null): ?>
                                                        <span style="font-weight: 600; font-size: 13px; text-transform: none; margin-left: 10px; color: #1e3a8a; background: #dbeafe; padding: 2px 10px; border-radius: 12px;">
                                                            <?= $coachCount ?> Coaches Cleaned
                                                        </span>
                                                    <?php endif; ?>
                                                </td>
                                            </tr>

                                            <?php foreach ($cat['roles'] as $role): 
                                                $tId = $role['manpower_type_id'];
                                                $rawNorm = floatval($targetsMap[$targetMonthDate][$cId][$tId] ?? $targetsMap[$targetMonthDate][0][$tId] ?? 0);
                                                $isUnskilled = isUnskilledRole($role['role_name']);

                                                // Dynamic target for unskilled roles based on coaches cleaned
                                                if ($scorecardTable !== null && $isUnskilled) {
                                                    $effectiveNorm = $rawNorm * $coachCount;
                                                } else {
                                                    $effectiveNorm = $rawNorm;
                                                }
                                                $normVal = (floatval($effectiveNorm) == intval($effectiveNorm)) ? intval($effectiveNorm) : round($effectiveNorm, 2);

                                                $catTotalTarget += $effectiveNorm;
                                                $grandTotalTarget += $effectiveNorm;

                                                $roleTotalProvided = 0;
                                                $roleNoDress = 0;
                                                $roleNoPpe = 0;
                                                $shiftQtys = [];

                                                foreach ($cat['shifts'] as $sh) {
                                                    $sId = $sh['id'];
                                                    $prov = isset($dateLogs[$sId][$tId]) ? intval($dateLogs[$sId][$tId]['provided']) : 0;
                                                    $shiftQtys[$sId] = $prov;
                                                    $roleTotalProvided += $prov;
                                                    $catShiftTotals[$sId] += $prov;
                                                    $grandShiftTotals[$sId] += $prov;

                                                    if (isset($dateLogs[$sId][$tId])) {
                                                        $roleNoDress += intval($dateLogs[$sId][$tId]['no_dress']);
                                                        $roleNoPpe += intval($dateLogs[$sId][$tId]['no_ppe']);
                                                    }
                                                }

                                                $catTotalProvided += $roleTotalProvided;
                                                $grandTotalProvided += $roleTotalProvided;
                                                $catTotalNoDress += $roleNoDress;
                                                $grandTotalNoDress += $roleNoDress;
                                                $catTotalNoPpe += $roleNoPpe;
                                                $grandTotalNoPpe += $roleNoPpe;
                                            ?>
                                                <tr>
                                                    <td style="text-align: left; padding-left: 15px; font-weight: 500;"><?= htmlspecialchars($role['role_name']) ?></td>
                                                    <?php foreach ($cat['shifts'] as $sh): ?>
                                                        <td style="text-align: center;"><?= $shiftQtys[$sh['id']] ?></td>
                                                    <?php endforeach; ?>
                                                    <td style="text-align: center; font-weight: 600;"><?= $roleTotalProvided ?></td>
                                                    <td style="text-align: center; font-weight: 600;"><?= $normVal ?></td>
                                                    <td style="text-align: center;"><?= $roleNoDress ?></td>
                                                    <td style="text-align: center;"><?= $roleNoPpe ?></td>
                                                </tr>
                                            <?php endforeach; ?>

                                            <!-- Category Total Row -->
                                            <tr style="font-weight:700; background:#f9f9f9;">
                                                <td style="text-align: left !important; padding-left: 15px !important;">Total</td>
                                                <?php foreach ($cat['shifts'] as $sh): ?>
                                                    <td style="text-align: center;"><?= $catShiftTotals[$sh['id']] ?></td>
                                                <?php endforeach; ?>
                                                <td style="text-align: center;"><?= $catTotalProvided ?></td>
                                                <td style="text-align: center;"><?= (floatval($catTotalTarget) == intval($catTotalTarget)) ? intval($catTotalTarget) : round($catTotalTarget, 2) ?></td>
                                                <td style="text-align: center;"><?= $catTotalNoDress ?></td>
                                                <td style="text-align: center;"><?= $catTotalNoPpe ?></td>
                                            </tr>
                                        <?php endforeach; ?>

                                        <?php if (count($categories) > 1): ?>
                                            <!-- Grand Total Row -->
                                            <tr style="font-weight:700; background:#f2f2f2; border-top: 2px solid #cbd5e1;">
                                                <td style="text-align: left !important; padding-left: 15px !important;">Grand Total</td>
                                                <?php foreach ($categories[0]['shifts'] as $sh): ?>
                                                    <td style="text-align: center;"><?= $grandShiftTotals[$sh['id']] ?? 0 ?></td>
                                                <?php endforeach; ?>
                                                <td style="text-align: center;"><?= $grandTotalProvided ?></td>
                                                <td style="text-align: center;"><?= (floatval($grandTotalTarget) == intval($grandTotalTarget)) ? intval($grandTotalTarget) : round($grandTotalTarget, 2) ?></td>
                                                <td style="text-align: center;"><?= $grandTotalNoDress ?></td>
                                                <td style="text-align: center;"><?= $grandTotalNoPpe ?></td>
                                            </tr>
                                        <?php endif; ?>
                                    <?php endif; ?>
                                </tbody>
                            </table>
                        </div>

                        <div class="signature-row">
                            <div class="signature-box">
                                <div class="signature-line">Contractor's Supervisor</div>
                            </div>
                            <div class="signature-box">
                                <div class="signature-line">On-Duty CHI/Railway Auth.</div>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    </div>
</main>

<?php include 'footer.php'; ?>