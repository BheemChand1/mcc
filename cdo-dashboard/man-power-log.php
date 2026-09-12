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
        auditor_name
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
        'auditor' => $row['auditor_name']
    ];
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
                    
                    // Pre-calculate data, totals and score for this sheet
                    $grandShiftTotals = [];
                    $grandTotalProvided = 0;
                    $grandTotalTarget = 0;
                    $grandTotalNoDress = 0;
                    $grandTotalNoPpe = 0;
                    $totalAvailable = 0;
                    
                    $categoryData = [];
                    foreach ($categories as $cat) {
                        $cId = $cat['id'];
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
                            $effectiveNorm = floatval($targetsMap[$targetMonthDate][$cId][$tId] ?? $targetsMap[$targetMonthDate][0][$tId] ?? 0);
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
                                <div class="meta-item"><span>Total Target:</span> <?= $formattedGrandTotalTarget ?></div>
                                <div class="meta-item"><span>Total Attended:</span> <?= $grandTotalProvided ?></div>
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
                                        <?php foreach ($categoryData as $cat): 
                                            $colCount = count($cat['shifts']) + 5;
                                        ?>
                                            <!-- Category Subheader -->
                                            <tr class="sub-category">
                                                <td colspan="<?= $colCount ?>" style="text-align:center !important; padding-left:0 !important; text-transform: uppercase;">
                                                    <?= htmlspecialchars($cat['category_name']) ?>
                                                </td>
                                            </tr>

                                            <?php foreach ($cat['roles_data'] as $role): ?>
                                                <tr>
                                                    <td style="text-align: left; padding-left: 15px; font-weight: 500;"><?= htmlspecialchars($role['role_name']) ?></td>
                                                    <?php foreach ($cat['shifts'] as $sh): ?>
                                                        <td style="text-align: center;"><?= $role['shift_qtys'][$sh['id']] ?></td>
                                                    <?php endforeach; ?>
                                                    <td style="text-align: center; font-weight: 600;"><?= $role['total_provided'] ?></td>
                                                    <td style="text-align: center; font-weight: 600;"><?= $role['norm_val'] ?></td>
                                                    <td style="text-align: center;"><?= $role['no_dress'] ?></td>
                                                    <td style="text-align: center;"><?= $role['no_ppe'] ?></td>
                                                </tr>
                                            <?php endforeach; ?>

                                            <!-- Category Total Row -->
                                            <tr style="font-weight:700; background:#f9f9f9;">
                                                <td style="text-align: left !important; padding-left: 15px !important;">Total</td>
                                                <?php foreach ($cat['shifts'] as $sh): ?>
                                                    <td style="text-align: center;"><?= $cat['cat_shift_totals'][$sh['id']] ?></td>
                                                <?php endforeach; ?>
                                                <td style="text-align: center;"><?= $cat['cat_total_provided'] ?></td>
                                                <td style="text-align: center;"><?= (floatval($cat['cat_total_target']) == intval($cat['cat_total_target'])) ? intval($cat['cat_total_target']) : round($cat['cat_total_target'], 2) ?></td>
                                                <td style="text-align: center;"><?= $cat['cat_total_no_dress'] ?></td>
                                                <td style="text-align: center;"><?= $cat['cat_total_no_ppe'] ?></td>
                                            </tr>
                                        <?php endforeach; ?>

                                        <?php if (count($categoryData) > 1): ?>
                                            <!-- Grand Total Row -->
                                            <tr style="font-weight:700; background:#f2f2f2; border-top: 2px solid #cbd5e1;">
                                                <td style="text-align: left !important; padding-left: 15px !important;">Grand Total</td>
                                                <?php foreach ($categories[0]['shifts'] as $sh): ?>
                                                    <td style="text-align: center;"><?= $grandShiftTotals[$sh['id']] ?? 0 ?></td>
                                                <?php endforeach; ?>
                                                <td style="text-align: center;"><?= $grandTotalProvided ?></td>
                                                <td style="text-align: center;"><?= $formattedGrandTotalTarget ?></td>
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