<?php
require_once 'auth.php';

$fromDate = $_GET['from_date'] ?? date('Y-m-d', strtotime('-6 days'));
$toDate = $_GET['to_date'] ?? date('Y-m-d');

// Generate list of dates between fromDate and toDate (latest date first)
$datesList = [];
$currentDate = $toDate;
while (strtotime($currentDate) >= strtotime($fromDate)) {
    $datesList[] = $currentDate;
    $currentDate = date('Y-m-d', strtotime($currentDate . ' -1 day'));
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
$coachWiseMap = [];
$targetsStmt = $pdo->prepare("
    SELECT target_date, category_id, manpower_type_id, target_qty, is_coach_wise 
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
    $coachWiseMap[$row['target_date']][$catId][$tId] = intval($row['is_coach_wise'] ?? 0);
    if ($catId === 0) {
        $targetsMap[$row['target_date']][0][$tId] = $row['target_qty'];
        $coachWiseMap[$row['target_date']][0][$tId] = intval($row['is_coach_wise'] ?? 0);
    }
}

// Fetch submitted daily logs in date range
$logsMap = [];
$dateApprovedMap = [];
$dateAuditorsMap = [];
$dateAuditByIdMap = [];
$hasLogs = false; // globally whether there are ANY logs in the range
$logStmt = $pdo->prepare("
    SELECT *
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
    $dateApprovedMap[$date] = intval($row['isApproved'] ?? 0);
    if (!empty($row['audit_by'])) {
        $dateAuditByIdMap[$date] = $row['audit_by'];
    }
    if (!empty($row['auditor_name'])) {
        $dateAuditorsMap[$date][] = $row['auditor_name'];
    }
    $logsMap[$date][$row['shift_id']][$row['manpower_type_id']] = [
        'provided' => $row['provided_qty'],
        'absent' => $row['absent_qty'],
        'no_dress' => $row['no_dress_qty'],
        'no_ppe' => $row['no_ppe_qty'],
        'auditor' => $row['auditor_name']
    ];
}

// Fetch penalty rate configurations
$penStmt = $pdo->prepare("
    SELECT effective_month, manpower_type_id, absent_penalty, dress_penalty, gears_penalty 
    FROM mcc_manpower_penalties 
    WHERE station_id = :station_id
    ORDER BY effective_month ASC
");
$penStmt->execute(['station_id' => $stationId]);
$allPenalties = $penStmt->fetchAll();

if (!function_exists('getEffectivePenaltiesForMonth')) {
    function getEffectivePenaltiesForMonth($allPenalties, $monthDate) {
        $rates = [];
        foreach ($allPenalties as $p) {
            if ($p['effective_month'] <= $monthDate) {
                $rates[$p['manpower_type_id']] = [
                    'absent' => floatval($p['absent_penalty']),
                    'dress'  => floatval($p['dress_penalty']),
                    'gears'  => floatval($p['gears_penalty'])
                ];
            }
        }
        return $rates;
    }
}



if (!function_exists('getScorecardTableForCategory')) {
    function getScorecardTableForCategory($categoryName) {
        $c = strtoupper(trim($categoryName));
        if ($c === 'NORMAL CLEANING' || $c === 'EXTERNAL COACH CLEANING') {
            return 'mcc_normal_scorecard_report';
        } elseif ($c === 'INTENSIVE COACH CLEANING') {
            return 'mcc_intensive_scorecard_report';
        } elseif ($c === 'WATERING AND INTERNAL DRY CLEANING OF COACHES FOR PLATFORM RETURN TRAINS' || strpos($c, 'PLATFORM RETURN') !== false) {
            return 'mcc_prt_scorecard_report';
        }
        return null;
    }
}

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
                      OR report_date = :rep_date
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
.report-meta-section {
    width: 100%;
    margin: 10px 0 15px 0 !important;
}
.meta-row {
    display: flex !important;
    justify-content: center !important;
    align-items: center !important;
    gap: 12px 24px !important;
    margin-bottom: 8px !important;
    flex-wrap: wrap !important;
    line-height: 1.5 !important;
}
.meta-item {
    font-size: 13px !important;
    font-weight: 600 !important;
    white-space: nowrap !important;
    line-height: 1.5 !important;
    display: inline-flex !important;
    align-items: center !important;
    gap: 6px !important;
}
.meta-item span {
    font-weight: 700 !important;
}
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
                    
                    // Pre-calculate data, totals and score for this sheet
                    $grandShiftTotals = [];
                    $grandTotalProvided = 0;
                    $grandTotalTarget = 0;
                    $grandTotalNoDress = 0;
                    $grandTotalNoPpe = 0;
                    $totalAvailable = 0;
                    $dayPenalty = 0.0;
                    $effectivePenalties = getEffectivePenaltiesForMonth($allPenalties, $targetMonthDate);
                    
                    $categoryData = [];
                    foreach ($categories as $cat) {
                        $cId = $cat['id'];
                        $scorecardTable = getScorecardTableForCategory($cat['category_name']);
                        $coachCount = ($scorecardTable !== null) ? getRailwayDateCoachCount($pdo, $scorecardTable, $stationId, $date) : null;

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
                        $rolesData = [];

                        foreach ($cat['roles'] as $role) {
                            $tId = $role['manpower_type_id'];
                            $rawNorm = floatval($targetsMap[$targetMonthDate][$cId][$tId] ?? $targetsMap[$targetMonthDate][0][$tId] ?? 0);
                            $isCoachWise = intval($coachWiseMap[$targetMonthDate][$cId][$tId] ?? $coachWiseMap[$targetMonthDate][0][$tId] ?? 0);

                            // Multiply target with coach count if target is coach wise and category has coach count, then round UP (ceil)
                            if ($isCoachWise === 1 && $coachCount !== null) {
                                $effectiveNorm = ceil($rawNorm * $coachCount);
                            } else {
                                $effectiveNorm = $rawNorm;
                            }
                            $normVal = (floatval($effectiveNorm) == intval($effectiveNorm)) ? intval($effectiveNorm) : round($effectiveNorm, 2);

                            $catTotalTarget += $effectiveNorm;
                            $grandTotalTarget += $effectiveNorm;

                            $roleTotalProvided = 0;
                            $roleTotalAbsent = 0;
                            $roleNoDress = 0;
                            $roleNoPpe = 0;
                            $shiftQtys = [];

                            foreach ($cat['shifts'] as $sh) {
                                $sId = $sh['id'];
                                $prov = isset($dateLogs[$sId][$tId]) ? intval($dateLogs[$sId][$tId]['provided']) : 0;
                                $abs = isset($dateLogs[$sId][$tId]) ? intval($dateLogs[$sId][$tId]['absent']) : 0;
                                $shiftQtys[$sId] = $prov;
                                $roleTotalProvided += $prov;
                                $roleTotalAbsent += $abs;
                                $catShiftTotals[$sId] += $prov;
                                $grandShiftTotals[$sId] += $prov;

                                if (isset($dateLogs[$sId][$tId])) {
                                    $roleNoDress += intval($dateLogs[$sId][$tId]['no_dress']);
                                    $roleNoPpe += intval($dateLogs[$sId][$tId]['no_ppe']);
                                }
                            }

                            $avail = max(0, $roleTotalProvided - $roleTotalAbsent);
                            $totalAvailable += min($avail, $effectiveNorm);

                            $catTotalProvided += $roleTotalProvided;
                            $grandTotalProvided += $roleTotalProvided;
                            $catTotalNoDress += $roleNoDress;
                            $grandTotalNoDress += $roleNoDress;
                            $catTotalNoPpe += $roleNoPpe;
                            $grandTotalNoPpe += $roleNoPpe;

                            // Calculate penalty for this role on this date
                            if ($hasLogsForDate) {
                                $absentCount = max($roleTotalAbsent, max(0, $effectiveNorm - $roleTotalProvided));
                                $rates = $effectivePenalties[$tId] ?? ['absent' => 0.0, 'dress' => 0.0, 'gears' => 0.0];
                                $rolePenalty = ($absentCount * floatval($rates['absent'])) 
                                             + ($roleNoDress * floatval($rates['dress'])) 
                                             + ($roleNoPpe * floatval($rates['gears']));
                                $dayPenalty += $rolePenalty;
                            }

                            $rolesData[] = [
                                'role_name' => $role['role_name'],
                                'shift_qtys' => $shiftQtys,
                                'total_provided' => $roleTotalProvided,
                                'norm_val' => $normVal,
                                'no_dress' => $roleNoDress,
                                'no_ppe' => $roleNoPpe
                            ];
                        }

                        $categoryData[] = [
                            'id' => $cat['id'],
                            'category_name' => $cat['category_name'],
                            'coach_count' => $coachCount,
                            'shifts' => $cat['shifts'],
                            'roles_data' => $rolesData,
                            'cat_shift_totals' => $catShiftTotals,
                            'cat_total_provided' => $catTotalProvided,
                            'cat_total_target' => $catTotalTarget,
                            'cat_total_no_dress' => $catTotalNoDress,
                            'cat_total_no_ppe' => $catTotalNoPpe
                        ];
                    }

                    if (!$hasLogsForDate) {
                        $scorePercent = "0%";
                    } else {
                        $scorePercent = $grandTotalTarget > 0 ? round(($totalAvailable / $grandTotalTarget) * 100, 1) . "%" : "100%";
                    }

                    $formattedGrandTotalTarget = (floatval($grandTotalTarget) == intval($grandTotalTarget)) ? intval($grandTotalTarget) : round($grandTotalTarget, 2);
                ?>
                    <div class="report-frame datewise-sheet">
                        <?php if (!$hasLogsForDate): ?>
                            <div class="alert alert-warning no-print" style="margin: 0 0 20px 0; border-radius: 8px; border: 1px solid #ffeeba; background-color: #fff3cd; color: #856404; padding: 12px 20px;">
                                <i class="bi bi-exclamation-triangle-fill me-2"></i> No manpower logs submitted for <?= htmlspecialchars(date('d-m-Y', strtotime($date))) ?>. Displaying configuration and norms.
                            </div>
                        <?php endif; ?>

                        <div class="report-header" style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #999; padding-bottom: 10px; margin-bottom: 15px;">
                            <h2 style="margin: 0;">Manpower Log</h2>
                            <div class="d-flex align-items-center gap-2">
                                <?php if (!empty($dateApprovedMap[$date])): ?>
                                    <span class="badge bg-success px-3 py-2 text-white" style="font-size: 0.85rem; font-weight: 600; border-radius: 6px; box-shadow: 0 2px 5px rgba(21,128,61,0.2);"><i class="bi bi-patch-check-fill me-1"></i> Approved</span>
                                <?php elseif (!empty($isCDO) && $hasLogsForDate): ?>
                                    <button type="button" class="btn btn-sm btn-success no-print" onclick="approveReport(this, 'mcc_manpower_log', '', {report_date: '<?= htmlspecialchars($date) ?>'})" style="font-weight: 600; padding: 5px 14px; border-radius: 6px; display: inline-flex; align-items: center; gap: 5px; box-shadow: 0 2px 6px rgba(16,185,129,0.25);">
                                        <i class="bi bi-check2-circle"></i> <span>Approve</span>
                                    </button>
                                <?php endif; ?>
                            </div>
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
                                <div class="meta-item"><span>Total Target:</span> <?= $formattedGrandTotalTarget ?></div>
                                <div class="meta-item"><span>Total Attended:</span> <?= $grandTotalProvided ?></div>
                                <div class="meta-item"><span>Total Score:</span> <?= htmlspecialchars($scorePercent) ?></div>
                                <div class="meta-item"><span>Penalty of the Day:</span> <strong style="color: #dc2626;">Rs. <?= (floatval($dayPenalty) == intval($dayPenalty)) ? number_format($dayPenalty, 0) : number_format($dayPenalty, 2) ?></strong></div>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="report-table">
                                <thead>
                                    <tr>
                                        <th rowspan="2" style="text-align: left; padding-left: 15px; width: 220px; vertical-align: middle;">Description</th>
                                        <th rowspan="2" style="text-align: center; width: 130px; vertical-align: middle;">Total Target of the day</th>
                                        <?php 
                                            $shiftColSpan = !empty($categories) ? count($categories[0]['shifts']) : 3;
                                        ?>
                                        <th colspan="<?= $shiftColSpan ?>" style="text-align: center;">Found Present</th>
                                        <th rowspan="2" style="text-align: center; width: 160px; vertical-align: middle;">Found without dress code & ID cards</th>
                                        <th rowspan="2" style="text-align: center; width: 160px; vertical-align: middle;">Found without protective gears</th>
                                        <th rowspan="2" style="text-align: center; width: 110px; vertical-align: middle;">Total Present</th>
                                    </tr>
                                    <tr>
                                        <?php if (!empty($categories)): ?>
                                            <?php foreach ($categories[0]['shifts'] as $sh): ?>
                                                <th style="text-align: center; width: 100px;"><?= htmlspecialchars($sh['shift_name']) ?></th>
                                            <?php endforeach; ?>
                                        <?php else: ?>
                                            <th style="text-align: center; width: 100px;">Shift 1</th>
                                            <th style="text-align: center; width: 100px;">Shift 2</th>
                                            <th style="text-align: center; width: 100px;">Shift 3</th>
                                        <?php endif; ?>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if (empty($categories)): ?>
                                        <tr>
                                            <td colspan="8" style="text-align:center;">No manpower categories or shifts configured. Go to <a href="manpower-config.php">Man Power Config</a> to add.</td>
                                        </tr>
                                    <?php else: ?>
                                        <?php foreach ($categoryData as $cat): 
                                            $colCount = count($cat['shifts']) + 5;
                                        ?>
                                            <!-- Category Subheader -->
                                            <tr class="sub-category">
                                                <td colspan="<?= $colCount ?>" style="text-align:center !important; padding-left:0 !important; text-transform: uppercase;">
                                                    <?= htmlspecialchars($cat['category_name']) ?><?php if ($cat['coach_count'] !== null): ?> (<?= $cat['coach_count'] ?> Coaches)<?php endif; ?>
                                                </td>
                                            </tr>

                                            <?php foreach ($cat['roles_data'] as $role): ?>
                                                <tr>
                                                    <td style="text-align: left; padding-left: 15px; font-weight: 500;"><?= htmlspecialchars($role['role_name']) ?></td>
                                                    <td style="text-align: center; font-weight: 600;"><?= $role['norm_val'] ?></td>
                                                    <?php foreach ($cat['shifts'] as $sh): ?>
                                                        <td style="text-align: center;"><?= $role['shift_qtys'][$sh['id']] ?></td>
                                                    <?php endforeach; ?>
                                                    <td style="text-align: center;"><?= $role['no_dress'] ?></td>
                                                    <td style="text-align: center;"><?= $role['no_ppe'] ?></td>
                                                    <td style="text-align: center; font-weight: 600;"><?= $role['total_provided'] ?></td>
                                                </tr>
                                            <?php endforeach; ?>

                                            <!-- Category Total Row -->
                                            <tr style="font-weight:700; background:#f9f9f9;">
                                                <td style="text-align: left !important; padding-left: 15px !important;">Total</td>
                                                <td style="text-align: center;"><?= (floatval($cat['cat_total_target']) == intval($cat['cat_total_target'])) ? intval($cat['cat_total_target']) : round($cat['cat_total_target'], 2) ?></td>
                                                <?php foreach ($cat['shifts'] as $sh): ?>
                                                    <td style="text-align: center;"><?= $cat['cat_shift_totals'][$sh['id']] ?></td>
                                                <?php endforeach; ?>
                                                <td style="text-align: center;"><?= $cat['cat_total_no_dress'] ?></td>
                                                <td style="text-align: center;"><?= $cat['cat_total_no_ppe'] ?></td>
                                                <td style="text-align: center;"><?= $cat['cat_total_provided'] ?></td>
                                            </tr>
                                        <?php endforeach; ?>

                                        <?php if (count($categoryData) > 1): ?>
                                            <!-- Grand Total Row -->
                                            <tr style="font-weight:700; background:#f2f2f2; border-top: 2px solid #cbd5e1;">
                                                <td style="text-align: left !important; padding-left: 15px !important;">Grand Total</td>
                                                <td style="text-align: center;"><?= $formattedGrandTotalTarget ?></td>
                                                <?php foreach ($categories[0]['shifts'] as $sh): ?>
                                                    <td style="text-align: center;"><?= $grandShiftTotals[$sh['id']] ?? 0 ?></td>
                                                <?php endforeach; ?>
                                                <td style="text-align: center;"><?= $grandTotalNoDress ?></td>
                                                <td style="text-align: center;"><?= $grandTotalNoPpe ?></td>
                                                <td style="text-align: center;"><?= $grandTotalProvided ?></td>
                                            </tr>
                                        <?php endif; ?>
                                    <?php endif; ?>
                                </tbody>
                            </table>
                        </div>

                        <?php 
                        $audName = isset($dateAuditorsMap[$date]) ? implode(', ', array_unique($dateAuditorsMap[$date])) : null;
                        $audId = $dateAuditByIdMap[$date] ?? null;
                        $dayAuditorSig = resolveAuditorSignature($pdo, $audId);
                        $isDayApproved = !empty($dateApprovedMap[$date]);
                        ?>
                        <div class="signature-row">
                            <div class="signature-box">
                                <div class="signature-img-wrap">
                                    <?php if ($isDayApproved && !empty($cdoSignature) && file_exists(__DIR__ . '/uploads/signatures/' . $cdoSignature)): ?>
                                        <img src="uploads/signatures/<?= htmlspecialchars($cdoSignature) ?>" alt="Contractor Sign">
                                    <?php endif; ?>
                                </div>
                                <div class="signature-line">Contractor's Representative</div>
                            </div>
                            <div class="signature-box">
                                <div class="signature-img-wrap">
                                    <?php if (!empty($dayAuditorSig) && file_exists(__DIR__ . '/uploads/signatures/' . $dayAuditorSig)): ?>
                                        <img src="uploads/signatures/<?= htmlspecialchars($dayAuditorSig) ?>" alt="Authorized Sign">
                                    <?php endif; ?>
                                </div>
                                <div class="signature-line">Authorized Railway personnel</div>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    </div>
</main>

<?php include 'footer.php'; ?>