<?php
require_once 'auth.php';

$fromDate = $_GET['from_date'] ?? date('Y-m-d', strtotime('-6 days'));
$toDate = $_GET['to_date'] ?? date('Y-m-d');

// Fetch active shifts for this station - DC
$shiftsStmt = $pdo->prepare("
    SELECT id AS shift_id, shift AS shift_name 
    FROM dc_mcc_machine_shifts 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$shiftsStmt->execute(['station_id' => $stationId]);
$shiftsList = $shiftsStmt->fetchAll();

// Fetch active machines for this station - DC
$machinesStmt = $pdo->prepare("
    SELECT id AS machine_id, machine_no, machine_name 
    FROM dc_mcc_machine_param 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$machinesStmt->execute(['station_id' => $stationId]);
$machinesList = $machinesStmt->fetchAll();

// Fetch targets active on selected date (using SCD range logic) - DC
$targetsStmt = $pdo->prepare("
    SELECT machine_id, shift_id, nominated_area 
    FROM dc_mcc_machine_target 
    WHERE station_id = :station_id 
      AND :date_ref_1 >= effective_from
      AND (effective_to IS NULL OR :date_ref_2 <= effective_to)
");
$targetsStmt->execute([
    'station_id' => $stationId,
    'date_ref_1' => $fromDate,
    'date_ref_2' => $fromDate
]);
$targetsRows = $targetsStmt->fetchAll();

$targetsMap = [];
foreach ($targetsRows as $row) {
    $targetsMap[$row['machine_id']][$row['shift_id']] = $row['nominated_area'];
}

// Fetch report data for selected date - DC
$reportStmt = $pdo->prepare("
    SELECT parameter_id AS machine_id, shift_id, used_status, auditor_name 
    FROM dc_mcc_machine_report 
    WHERE station_id = :station_id AND report_date = :report_date
");
$reportStmt->execute([
    'station_id' => $stationId,
    'report_date' => $fromDate
]);
$reportRows = $reportStmt->fetchAll();

$reportsMap = [];
$auditorName = '';
foreach ($reportRows as $row) {
    $reportsMap[$row['machine_id']][$row['shift_id']] = $row['used_status'];
    if (empty($auditorName) && !empty($row['auditor_name'])) {
        $auditorName = $row['auditor_name'];
    }
}

$isFallback = empty($reportRows);

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

$totalScore = $isFallback ? "0%" : ($totalNominated > 0 ? round(($totalOperated / $totalNominated) * 100, 1) . "%" : "100%");

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
                <a href="dc-machine-target.php?month=<?= date('m', strtotime($fromDate)) ?>&year=<?= date('Y', strtotime($fromDate)) ?>" class="btn-summary" target="_blank">Machine Target</a>
                <a href="dc-machine-summary.php?month=<?= date('m', strtotime($fromDate)) ?>&year=<?= date('Y', strtotime($fromDate)) ?>" class="btn-summary">Summary</a>
                <button type="button" class="btn-print" onclick="window.print()">Print</button>
            </form>

            <div class="report-wrap">
                <?php if ($isFallback): ?>
                    <div class="alert alert-warning no-print" style="margin: 0 0 20px 0; border-radius: 8px; border: 1px solid #ffeeba; background-color: #fff3cd; color: #856404; padding: 12px 20px;">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> No daily machine reports found for the selected date. Displaying fallback/template values.
                    </div>
                <?php endif; ?>

                <div class="report-frame">
                    <div class="report-header">
                        <h2>DC Machine Deployment Report</h2>
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
                            <div class="meta-item"><span>Auditor Name:</span> <?= htmlspecialchars($auditorName ?: '-') ?></div>
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
                            <div class="signature-line">Contractor's Representative</div>
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
