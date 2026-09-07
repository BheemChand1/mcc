<?php
require_once 'auth.php';

$fromDate = $_GET['from_date'] ?? date('Y-m-d', strtotime('-6 days'));
$toDate = $_GET['to_date'] ?? date('Y-m-d');

// Fetch active shifts for this station (ordered by ID) - Pantry
$shiftsStmt = $pdo->prepare("
    SELECT id AS shift_id, shift AS shift_name 
    FROM mcc_intensive_pantry_machine_shifts 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$shiftsStmt->execute(['station_id' => $stationId]);
$shiftsList = $shiftsStmt->fetchAll();

// Fetch active machines for this station - Pantry
$machinesStmt = $pdo->prepare("
    SELECT id AS machine_id, machine_no, machine_name 
    FROM mcc_intensive_pantry_machine_param 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$machinesStmt->execute(['station_id' => $stationId]);
$machinesList = $machinesStmt->fetchAll();

// Fetch targets that overlap the selected date range - Pantry
$targetsStmt = $pdo->prepare("
    SELECT machine_id, shift_id, nominated_area, effective_from, effective_to
    FROM mcc_intensive_pantry_machine_target 
    WHERE station_id = :station_id 
      AND effective_from <= :to_date
      AND (effective_to IS NULL OR effective_to >= :from_date)
    ORDER BY effective_from ASC, id ASC
");
$targetsStmt->execute([
    'station_id' => $stationId,
    'from_date' => $fromDate,
    'to_date' => $toDate
]);
$targetsRows = $targetsStmt->fetchAll();

// Fetch all daily reports in the range, keeping each day's shift values separate - Pantry
$reportStmt = $pdo->prepare("
    SELECT report_date, parameter_id AS machine_id, shift_id, used_status, auditor_name
    FROM mcc_intensive_pantry_machine_report 
    WHERE station_id = :station_id AND report_date BETWEEN :from_date AND :to_date
    ORDER BY report_date DESC, id ASC
");
$reportStmt->execute([
    'station_id' => $stationId,
    'from_date' => $fromDate,
    'to_date' => $toDate
]);
$reportRows = $reportStmt->fetchAll();

$reportsByDate = [];
foreach ($reportRows as $row) {
    $reportsByDate[$row['report_date']][] = $row;
}

// Machine Area helper
function getMachineArea($machineNo, $machineName) {
    $no = strtoupper($machineNo);
    if (strpos($no, 'PPSD') !== false) {
        preg_match('/PPSD\s*(\d+)/i', $no, $matches);
        if (!empty($matches[1])) {
            $num = intval($matches[1]);
            if ($num <= 2) return "PL1";
            if ($num <= 4) return "PL2";
            if ($num <= 6) return "PL3";
            if ($num <= 8) return "PL4";
            return "PL5";
        }
        return "PL1";
    }
    if (strpos($no, 'HHSD') !== false) {
        return "Coach";
    }
    return "PL1"; 
}

// Resolve nominations and calculate a separate score for each report date.
$sheets = [];
foreach ($reportsByDate as $reportDate => $dailyRows) {
    $targetsMap = [];
    foreach ($targetsRows as $target) {
        if ($target['effective_from'] <= $reportDate
            && ($target['effective_to'] === null || $target['effective_to'] >= $reportDate)) {
            $targetsMap[$target['machine_id']][$target['shift_id']] = $target['nominated_area'];
        }
    }

    $reportsMap = [];
    $auditors = [];
    foreach ($dailyRows as $row) {
        $reportsMap[$row['machine_id']][$row['shift_id']] = $row['used_status'];
        if (!empty($row['auditor_name']) && !in_array($row['auditor_name'], $auditors, true)) {
            $auditors[] = $row['auditor_name'];
        }
    }

    $totalNominated = 0;
    $totalOperated = 0;
    foreach ($machinesList as $mach) {
        $mId = $mach['machine_id'];
        foreach ($shiftsList as $shift) {
            $sId = $shift['shift_id'];
            $nomArea = $targetsMap[$mId][$sId] ?? 'N';
            $isNominated = !empty($nomArea) && strtoupper($nomArea) !== 'N' && $nomArea !== '-';
            if ($isNominated) {
                $totalNominated++;
                if (($reportsMap[$mId][$sId] ?? '-') === 'Y') {
                    $totalOperated++;
                }
            }
        }
    }

    $sheets[] = [
        'report_date' => $reportDate,
        'targets' => $targetsMap,
        'reports' => $reportsMap,
        'auditor_name' => implode(', ', $auditors),
        'total_score' => $totalNominated > 0 ? round(($totalOperated / $totalNominated) * 100, 1) . '%' : '100%'
    ];
}

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
                <a href="pantry-machine-target.php?month=<?= date('m', strtotime($fromDate)) ?>&year=<?= date('Y', strtotime($fromDate)) ?>" class="btn-summary" target="_blank">Machine Target</a>
                <a href="pantry-machine-summary.php?month=<?= date('m', strtotime($fromDate)) ?>&year=<?= date('Y', strtotime($fromDate)) ?>" class="btn-summary">Summary</a>
                <button type="button" class="btn-print" onclick="window.print()">Print</button>
            </form>

            <div class="report-wrap">
                <?php if (empty($sheets)): ?>
                    <div class="alert alert-warning no-print" style="margin: 0 0 20px 0; border-radius: 8px; border: 1px solid #ffeeba; background-color: #fff3cd; color: #856404; padding: 12px 20px;">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> No daily machine reports found for the selected date range.
                    </div>
                <?php endif; ?>

                <?php foreach ($sheets as $sheet):
                    $targetsMap = $sheet['targets'];
                    $reportsMap = $sheet['reports'];
                ?>
                <div class="report-frame">
                    <div class="report-header">
                        <h2>Daily Machine Report (Pantry Car)</h2>
                    </div>

                    <div class="report-meta-section">
                        <div class="meta-row">
                            <div class="meta-item"><span>Railway:</span> <?= htmlspecialchars($railwayName) ?></div>
                            <div class="meta-item"><span>Date:</span> <?= htmlspecialchars(date('d-m-Y', strtotime($sheet['report_date']))) ?></div>
                            <div class="meta-item"><span>Division:</span> <?= htmlspecialchars($divisionName) ?></div>
                            <div class="meta-item"><span>Station:</span> <?= htmlspecialchars($stationName) ?></div>
                        </div>
                        <div class="meta-row">
                            <div class="meta-item"><span>Contractor:</span> <?= htmlspecialchars($contractorName) ?></div>
                            <div class="meta-item"><span>Auditor Name:</span> <?= htmlspecialchars($sheet['auditor_name'] ?: '-') ?></div>
                            <div class="meta-item"><span>Total Score:</span> <?= htmlspecialchars($sheet['total_score']) ?></div>
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
                                                    $nom = $targetsMap[$mId][$sId] ?? 'N';
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
                <?php endforeach; ?>
            </div>
        </div>
    </div>
</main>

<?php include 'footer.php'; ?>