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
    $shifts = [];
    $shiftStmt = $pdo->prepare("
        SELECT id, shift_name 
        FROM mcc_manpower_shifts 
        WHERE category_id = :category_id AND status = 'Active' 
        ORDER BY order_no ASC, id ASC
    ");
    $shiftStmt->execute(['category_id' => $categoryId]);
    $shiftList = $shiftStmt->fetchAll();

    foreach ($shiftList as $sh) {
        $shiftId = $sh['id'];
        
        // Fetch mapped roles from map table (sorted by role's order_no)
        $typesStmt = $pdo->prepare("
            SELECT map.manpower_type_id, t.role_name, t.order_no
            FROM mcc_manpower_shift_type_map map
            JOIN mcc_manpower_types t ON map.manpower_type_id = t.id
            WHERE map.shift_id = :shift_id AND t.status = 'Active'
            ORDER BY t.order_no ASC, t.id ASC
        ");
        $typesStmt->execute(['shift_id' => $shiftId]);
        $types = $typesStmt->fetchAll();

        if (!empty($types)) {
            $shifts[] = [
                'id' => $sh['id'],
                'shift_name' => $sh['shift_name'],
                'types' => $types
            ];
        }
    }

    if (!empty($shifts)) {
        $categories[] = [
            'id' => $cat['id'],
            'category_name' => $cat['category_name'],
            'shifts' => $shifts
        ];
    }
}

// Fetch target norms for the selected months in range
$startMonth = date('Y-m-01', strtotime($fromDate));
$endMonth = date('Y-m-01', strtotime($toDate));

$targetsMap = [];
$targetsStmt = $pdo->prepare("
    SELECT target_date, shift_id, manpower_type_id, target_qty 
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
    $targetsMap[$row['target_date']][$row['shift_id']][$row['manpower_type_id']] = $row['target_qty'];
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
                        foreach ($cat['shifts'] as $sh) {
                            foreach ($sh['types'] as $type) {
                                $shId = $sh['id'];
                                $tId = $type['manpower_type_id'];
                                $normVal = $targetsMap[$targetMonthDate][$shId][$tId] ?? 0;
                                $totalNorms += $normVal;
                                
                                if (isset($dateLogs[$shId][$tId])) {
                                    $prov = $dateLogs[$shId][$tId]['provided'] ?? 0;
                                    $abs = $dateLogs[$shId][$tId]['absent'] ?? 0;
                                    $avail = max(0, $prov - $abs);
                                    $totalAvailable += min($avail, $normVal);
                                }
                            }
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
                            <h2>Staff Availability Log (Shift-wise)</h2>
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
                                        <th>Shift</th>
                                        <th>Description</th>
                                        <th>To be provided as per norms</th>
                                        <th>Provided by contractor (as per bio-metric attendance sheet)</th>
                                        <th>Found absent during the shift check</th>
                                        <th>Actual available</th>
                                        <th>Found without dress code & ID cards</th>
                                        <th>Found without protective gears</th>
                                        <th>Signature of On duty CHI</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if (empty($categories)): ?>
                                        <tr>
                                            <td colspan="9" style="text-align:center;">No manpower categories or shifts configured. Go to <a href="manpower-config.php">Man Power Config</a> to add.</td>
                                        </tr>
                                    <?php else: ?>
                                        <?php foreach ($categories as $cat): 
                                            $catNormsTotal = 0;
                                            $catProvidedTotal = 0;
                                            $catAbsentTotal = 0;
                                            $catAvailableTotal = 0;
                                            $catNoDressTotal = 0;
                                            $catNoPpeTotal = 0;
                                        ?>
                                            <!-- Category Subheader -->
                                            <tr class="sub-category">
                                                <td colspan="9" style="text-align:center !important; padding-left:0 !important; text-transform: uppercase;">
                                                    <?= htmlspecialchars($cat['category_name']) ?>
                                                </td>
                                            </tr>

                                            <?php foreach ($cat['shifts'] as $shift): 
                                                $shiftNormsTotal = 0;
                                                $shiftProvidedTotal = 0;
                                                $shiftAbsentTotal = 0;
                                                $shiftAvailableTotal = 0;
                                                $shiftNoDressTotal = 0;
                                                $shiftNoPpeTotal = 0;
                                                $shiftSignatures = [];
                                            ?>
                                                <?php 
                                                $typeIndex = 0;
                                                $typesCount = count($shift['types']);
                                                foreach ($shift['types'] as $type): 
                                                    $shId = $shift['id'];
                                                    $tId = $type['manpower_type_id'];
                                                    $normVal = $targetsMap[$targetMonthDate][$shId][$tId] ?? 0;
                                                    $shiftNormsTotal += $normVal;
                                                    $catNormsTotal += $normVal;

                                                    $provided = '';
                                                    $absent = '';
                                                    $available = '';
                                                    $noDress = '';
                                                    $noPpe = '';
                                                    $chiSig = '';

                                                    if (isset($dateLogs[$shId][$tId])) {
                                                        $provided = $dateLogs[$shId][$tId]['provided'];
                                                        $absent = $dateLogs[$shId][$tId]['absent'];
                                                        $available = max(0, $provided - $absent);
                                                        $noDress = $dateLogs[$shId][$tId]['no_dress'];
                                                        $noPpe = $dateLogs[$shId][$tId]['no_ppe'];
                                                        $chiSig = $dateLogs[$shId][$tId]['chi'];

                                                        $shiftProvidedTotal += intval($provided);
                                                        $catProvidedTotal += intval($provided);
                                                        $shiftAbsentTotal += intval($absent);
                                                        $catAbsentTotal += intval($absent);
                                                        $shiftAvailableTotal += intval($available);
                                                        $catAvailableTotal += intval($available);
                                                        $shiftNoDressTotal += intval($noDress);
                                                        $catNoDressTotal += intval($noDress);
                                                        $shiftNoPpeTotal += intval($noPpe);
                                                        $catNoPpeTotal += intval($noPpe);

                                                        if (!empty($chiSig)) {
                                                            $shiftSignatures[] = $chiSig;
                                                        }
                                                    }
                                                ?>
                                                    <tr>
                                                        <?php if ($typeIndex === 0): ?>
                                                            <td rowspan="<?= $typesCount ?>" style="vertical-align: middle; text-align: center; font-weight: 500;"><?= htmlspecialchars($shift['shift_name']) ?></td>
                                                        <?php endif; ?>
                                                        <td><?= htmlspecialchars($type['role_name']) ?></td>
                                                        <td><?= $normVal ?></td>
                                                        <td><?= $provided !== '' ? $provided : '' ?></td>
                                                        <td><?= $absent !== '' ? $absent : '' ?></td>
                                                        <td><?= $available !== '' ? $available : '' ?></td>
                                                        <td><?= $noDress !== '' ? $noDress : '' ?></td>
                                                        <td><?= $noPpe !== '' ? $noPpe : '' ?></td>
                                                        <td><?= htmlspecialchars($chiSig) ?></td>
                                                    </tr>
                                                <?php 
                                                    $typeIndex++;
                                                endforeach; 
                                                ?>

                                                <!-- Shift Total Row -->
                                                <tr style="font-weight:700; background:#f9f9f9;">
                                                    <td colspan="2" style="text-align: left !important; padding-left: 15px !important;">Total</td>
                                                    <td><?= $shiftNormsTotal ?></td>
                                                    <td><?= $hasLogsForDate ? $shiftProvidedTotal : '' ?></td>
                                                    <td><?= $hasLogsForDate ? $shiftAbsentTotal : '' ?></td>
                                                    <td><?= $hasLogsForDate ? $shiftAvailableTotal : '' ?></td>
                                                    <td><?= $hasLogsForDate ? $shiftNoDressTotal : '' ?></td>
                                                    <td><?= $hasLogsForDate ? $shiftNoPpeTotal : '' ?></td>
                                                    <td>
                                                        <?php 
                                                            $uniqueSigs = array_unique(array_filter($shiftSignatures));
                                                            echo htmlspecialchars(implode(', ', $uniqueSigs));
                                                        ?>
                                                    </td>
                                                </tr>
                                            <?php endforeach; ?>

                                            <!-- Category Grand Total Row -->
                                            <tr style="font-weight:700; background:#f2f2f2;">
                                                <td colspan="2" style="text-align: left !important; padding-left: 15px !important;">Grand Total</td>
                                                <td><?= $catNormsTotal ?></td>
                                                <td><?= $hasLogsForDate ? $catProvidedTotal : '' ?></td>
                                                <td><?= $hasLogsForDate ? $catAbsentTotal : '' ?></td>
                                                <td><?= $hasLogsForDate ? $catAvailableTotal : '' ?></td>
                                                <td><?= $hasLogsForDate ? $catNoDressTotal : '' ?></td>
                                                <td><?= $hasLogsForDate ? $catNoPpeTotal : '' ?></td>
                                                <td></td>
                                            </tr>
                                        <?php endforeach; ?>
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