<?php
require_once 'auth.php';

$fromDate = $_GET['from_date'] ?? date('Y-m-d', strtotime('-6 days'));
$toDate = $_GET['to_date'] ?? date('Y-m-d');

// Fetch active shifts for this station - PLDC
$shiftsStmt = $pdo->prepare("
    SELECT id AS shift_id, shift AS shift_name 
    FROM mcc_pldc_machine_shifts 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$shiftsStmt->execute(['station_id' => $stationId]);
$shiftsList = $shiftsStmt->fetchAll();

// Fetch active machines for this station - PLDC
$machinesStmt = $pdo->prepare("
    SELECT id AS machine_id, machine_no, machine_name 
    FROM mcc_pldc_machine_param 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$machinesStmt->execute(['station_id' => $stationId]);
$machinesList = $machinesStmt->fetchAll();

// Fetch targets for selected month - PLDC
$targetMonthDate = date('Y-m-01', strtotime($fromDate));
$targetsStmt = $pdo->prepare("
    SELECT machine_id, shift_id, nominated_area 
    FROM mcc_pldc_machine_target 
    WHERE station_id = :station_id AND target_month = :target_month
");
$targetsStmt->execute([
    'station_id' => $stationId,
    'target_month' => $targetMonthDate
]);
$targetsRows = $targetsStmt->fetchAll();

$targetsMap = [];
foreach ($targetsRows as $row) {
    $targetsMap[$row['machine_id']][$row['shift_id']] = $row['nominated_area'];
}

// Fetch report data for selected date - PLDC
$reportStmt = $pdo->prepare("
    SELECT parameter_id AS machine_id, shift_id, used_status 
    FROM mcc_pldc_machine_report 
    WHERE station_id = :station_id AND report_date = :report_date
");
$reportStmt->execute([
    'station_id' => $stationId,
    'report_date' => $fromDate
]);
$reportRows = $reportStmt->fetchAll();

$reportsMap = [];
foreach ($reportRows as $row) {
    $reportsMap[$row['machine_id']][$row['shift_id']] = $row['used_status'];
}

// Calculate score
$totalNominated = 0;
$totalOperated = 0;

foreach ($machinesList as $mach) {
    $mId = $mach['machine_id'];
    foreach ($shiftsList as $shift) {
        $sId = $shift['shift_id'];
        $nomArea = $targetsMap[$mId][$sId] ?? '';
        $isNominated = !empty($nomArea) && strtoupper($nomArea) !== 'N' && $nomArea !== '-';
        if ($isNominated) {
            $totalNominated++;
            $status = $reportsMap[$mId][$sId] ?? '-';
            if ($status === 'Y') {
                $totalOperated++;
            }
        }
    }
}

$totalScore = $totalNominated > 0 ? round(($totalOperated / $totalNominated) * 100, 1) . "%" : "100%";

$extraStyles = "";

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
                <a href="pldc-machine-target.php?month=<?= date('m', strtotime($fromDate)) ?>&year=<?= date('Y', strtotime($fromDate)) ?>" class="btn-summary" target="_blank">Machine Target</a>
                <a href="pldc-machine-summary.php?month=<?= date('m', strtotime($fromDate)) ?>&year=<?= date('Y', strtotime($fromDate)) ?>" class="btn-summary">Summary</a>
                <button type="button" class="btn-print" onclick="window.print()">Print</button>
            </form>

            <div class="report-wrap">

                <div class="report-frame">
                    <div class="report-header">
                        <h2>PLDC Machine Deployment Report</h2>
                    </div>

                    <div class="report-meta-section">
                        <div class="meta-row">
                            <div class="meta-item"><span>Railway:</span> <?= htmlspecialchars($railwayName) ?></div>
                            <div class="meta-item"><span>Date:</span> <?= htmlspecialchars(date('d-m-Y', strtotime($fromDate))) ?></div>
                            <div class="meta-item"><span>Division:</span> <?= htmlspecialchars($divisionName) ?></div>
                            <div class="meta-item"><span>Station/Depot:</span> <?= htmlspecialchars($stationName) ?></div>
                        </div>
                        <div class="meta-row">
                            <div class="meta-item"><span>Contractor:</span> <?= htmlspecialchars($contractorName) ?></div>
                            <div class="meta-item"><span>Total Score:</span> <?= htmlspecialchars($totalScore) ?></div>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="report-table">
                            <thead>
                                <tr>
                                    <th rowspan="3" style="width: 50px;">S.No</th>
                                    <th rowspan="3" style="width: 130px;">Machine ID</th>
                                    <th rowspan="3" style="width: 300px; text-align: left; padding-left: 15px;">Name of Machines</th>
                                    <th colspan="<?= max(1, count($shiftsList)) ?>">Nominated Work Area</th>
                                    <th colspan="<?= max(1, count($shiftsList)) ?>">Shift Status (Work Done Y/N)</th>
                                </tr>
                                <tr>
                                    <?php if (empty($shiftsList)): ?>
                                        <th>Shifts</th>
                                        <th>Shifts</th>
                                    <?php else: ?>
                                        <?php foreach ($shiftsList as $shift): ?>
                                            <th><?= htmlspecialchars($shift['shift_name']) ?></th>
                                        <?php endforeach; ?>
                                        <?php foreach ($shiftsList as $shift): ?>
                                            <th><?= htmlspecialchars($shift['shift_name']) ?></th>
                                        <?php endforeach; ?>
                                    <?php endif; ?>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if (empty($machinesList)): ?>
                                    <tr>
                                        <td colspan="<?= 3 + 2 * max(1, count($shiftsList)) ?>" style="text-align: center;">No machines found.</td>
                                    </tr>
                                <?php else: ?>
                                    <?php 
                                    $serial = 1;
                                    foreach ($machinesList as $mach): 
                                        $mId = $mach['machine_id'];
                                    ?>
                                        <tr>
                                            <td><?= $serial++ ?></td>
                                            <td><strong><?= htmlspecialchars($mach['machine_no']) ?></strong></td>
                                            <td class="text-left"><?= htmlspecialchars($mach['machine_name']) ?></td>
                                            
                                            <!-- Nominated Work Area -->
                                            <?php if (empty($shiftsList)): ?>
                                                <td>-</td>
                                            <?php else: ?>
                                                <?php foreach ($shiftsList as $shift): 
                                                    $sId = $shift['shift_id'];
                                                    $nom = $targetsMap[$mId][$sId] ?? '-';
                                                ?>
                                                    <td><?= htmlspecialchars($nom) ?></td>
                                                <?php endforeach; ?>
                                            <?php endif; ?>
                                            
                                            <!-- Shift Status (Work Done Y/N) -->
                                            <?php if (empty($shiftsList)): ?>
                                                <td>-</td>
                                            <?php else: ?>
                                                <?php foreach ($shiftsList as $shift): 
                                                    $sId = $shift['shift_id'];
                                                    $status = $reportsMap[$mId][$sId] ?? '-';
                                                ?>
                                                    <td><strong><?= htmlspecialchars($status) ?></strong></td>
                                                <?php endforeach; ?>
                                            <?php endif; ?>
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
                            <div class="signature-line">Authorized Railway Officer</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<?php include 'footer.php'; ?>
