<?php
require_once 'auth.php';
global $pdo;

$fromDate = $_GET['from_date'] ?? date('Y-m-d', strtotime('-6 days'));
$toDate = $_GET['to_date'] ?? date('Y-m-d');
$editDate = $_GET['edit_date'] ?? ($_GET['edit'] ?? '');
$flashSuccess = '';
$flashError = '';

// Handle Direct PHP POST Save (No AJAX)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['save_machine_changes'])) {
    $targetDate = trim($_POST['report_date'] ?? '');
    $postedStatus = $_POST['used_status'] ?? [];

    if (!empty($targetDate) && !empty($postedStatus)) {
        try {
            $pdo->beginTransaction();

            $chk = $pdo->prepare("SELECT COUNT(*) FROM mcc_normal_machine_report WHERE report_date = :rd AND station_id = :sid AND audit_by = :aud");
            $chk->execute(['rd' => $targetDate, 'sid' => $stationId, 'aud' => $auditorId]);

            if ($chk->fetchColumn() > 0) {
                $updStmt = $pdo->prepare("
                    UPDATE mcc_normal_machine_report 
                    SET used_status = :status 
                    WHERE report_date = :rd 
                      AND station_id = :sid 
                      AND audit_by = :aud 
                      AND parameter_id = :m_id 
                      AND shift_id = :s_id
                ");

                foreach ($postedStatus as $mId => $shiftVals) {
                    foreach ($shiftVals as $sId => $val) {
                        $updStmt->execute([
                            'status' => trim($val),
                            'rd' => $targetDate,
                            'sid' => $stationId,
                            'aud' => $auditorId,
                            'm_id' => $mId,
                            's_id' => $sId
                        ]);
                    }
                }

                $pdo->commit();
                $flashSuccess = "Machine report for " . htmlspecialchars(date('d-m-Y', strtotime($targetDate))) . " updated successfully!";
                $editDate = ''; // Exit edit mode
            } else {
                $pdo->rollBack();
                $flashError = "Unauthorized: You can only edit sheets submitted by your auditor account.";
            }
        } catch (Exception $e) {
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            $flashError = "Failed to update sheet: " . $e->getMessage();
        }
    }
}

// Fetch active shifts for this station (ordered by ID)
$shiftsStmt = $pdo->prepare("
    SELECT id AS shift_id, shift AS shift_name 
    FROM mcc_normal_machine_shifts 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$shiftsStmt->execute(['station_id' => $stationId]);
$shiftsList = $shiftsStmt->fetchAll();

// Fetch active machines for this station
$machinesStmt = $pdo->prepare("
    SELECT id AS machine_id, machine_no, machine_name 
    FROM mcc_normal_machine_param 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$machinesStmt->execute(['station_id' => $stationId]);
$machinesList = $machinesStmt->fetchAll();

// Fetch targets that overlap the selected date range.
$targetsStmt = $pdo->prepare("
    SELECT machine_id, shift_id, nominated_area, effective_from, effective_to
    FROM mcc_normal_machine_target 
    WHERE station_id = :station_id 
      AND effective_from <= :to_date
      AND (effective_to IS NULL OR effective_to >= :from_date)
    ORDER BY effective_from ASC, id ASC
");
$targetsStmt->execute([
    'station_id' => $stationId,
    'from_date' => $fromDate,
    'to_date' => $toDate]);
$targetsRows = $targetsStmt->fetchAll();

// Fetch all daily reports in the range, keeping each day's shift values separate.
$reportStmt = $pdo->prepare("
    SELECT report_date, parameter_id AS machine_id, shift_id, used_status, auditor_name, isApproved
    FROM mcc_normal_machine_report 
    WHERE station_id = :station_id AND report_date BETWEEN :from_date AND :to_date AND audit_by = :auditor_id
    ORDER BY report_date DESC, id ASC
");
$reportStmt->execute([
    'station_id' => $stationId,
    'from_date' => $fromDate,
    'to_date' => $toDate,
    'auditor_id' => $auditorId
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
            if (($targetsMap[$mId][$sId] ?? 'N') === 'Y') {
                $totalNominated++;
                if (($reportsMap[$mId][$sId] ?? '-') === 'Y') {
                    $totalOperated++;
                }
            }
        }
    }

    $auditById = null;
    foreach ($dailyRows as $row) {
        if (!empty($row['audit_by'])) {
            $auditById = $row['audit_by'];
            break;
        }
    }
    $auditorNameStr = implode(', ', $auditors);
    $auditorSig = resolveAuditorSignature($pdo, $auditById);

    $sheets[] = [
        'report_date' => $reportDate,
        'targets' => $targetsMap,
        'reports' => $reportsMap,
        'auditor_name' => $auditorNameStr,
        'auditor_signature' => $auditorSig,
        'total_score' => $totalNominated > 0 ? round(($totalOperated / $totalNominated) * 100, 1) . '%' : '100%',
        'isApproved' => !empty($dailyRows) ? (int)($dailyRows[0]['isApproved'] ?? 0) : 0
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
                
                
                <button type="button" class="btn-print" onclick="window.print()">Print</button>
            </form>

            <div class="report-wrap">
                <?php if (!empty($flashSuccess)): ?>
                    <div class="alert alert-success alert-dismissible fade show mb-3" role="alert">
                        <i class="bi bi-check-circle-fill me-2"></i><strong>Success!</strong> <?= $flashSuccess ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <?php endif; ?>
                <?php if (!empty($flashError)): ?>
                    <div class="alert alert-danger alert-dismissible fade show mb-3" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i><strong>Error!</strong> <?= $flashError ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <?php endif; ?>

                <?php if (empty($sheets)): ?>
                    <div class="alert alert-warning no-print" style="margin: 0 0 20px 0; border-radius: 8px; border: 1px solid #ffeeba; background-color: #fff3cd; color: #856404; padding: 12px 20px;">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> No daily machine reports found for the selected date range.
                    </div>
                <?php endif; ?>

                <?php foreach ($sheets as $sheet):
                    $targetsMap = $sheet['targets'];
                    $reportsMap = $sheet['reports'];
                    $isEditingThisSheet = ($editDate !== '' && $editDate === (string)$sheet['report_date']);
                ?>
                <?php if ($isEditingThisSheet): ?>
                <form method="POST" action="">
                    <input type="hidden" name="report_date" value="<?= htmlspecialchars($sheet['report_date']) ?>">
                    <input type="hidden" name="from_date" value="<?= htmlspecialchars($fromDate) ?>">
                    <input type="hidden" name="to_date" value="<?= htmlspecialchars($toDate) ?>">
                <?php endif; ?>

                <div class="report-frame" style="<?= $isEditingThisSheet ? 'border: 2px solid #0284c7; box-shadow: 0 0 22px rgba(2, 132, 199, 0.35);' : '' ?>">
                    <div class="report-header" style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #999; padding-bottom: 10px; margin-bottom: 15px;">
                        <h2 style="margin: 0;">Daily Machine Report</h2>
                        <div class="d-flex align-items-center gap-2">
                            <?php if (!empty($sheet['isApproved'])): ?>
                                <span class="badge bg-success px-3 py-2 text-white" style="font-size: 0.85rem; font-weight: 600; border-radius: 6px; box-shadow: 0 2px 5px rgba(21,128,61,0.2);"><i class="bi bi-patch-check-fill me-1"></i> Approved</span>
                            <?php else: ?>
                                <span class="badge bg-warning text-dark px-3 py-2" style="font-size: 0.85rem; font-weight: 600; border-radius: 6px;"><i class="bi bi-clock-history me-1"></i> Pending Approval</span>
                            <?php endif; ?>

                            <?php if ($isEditingThisSheet): ?>
                                <button type="submit" name="save_machine_changes" class="btn btn-sm btn-success fw-bold text-white no-print shadow-sm px-3" style="font-weight: 700;">
                                    <i class="bi bi-check2-circle me-1"></i> Save Changes
                                </button>
                                <a href="?from_date=<?= urlencode($fromDate) ?>&to_date=<?= urlencode($toDate) ?>" class="btn btn-sm btn-secondary fw-bold text-white no-print shadow-sm px-3">
                                    <i class="bi bi-x-circle me-1"></i> Cancel
                                </a>
                            <?php else: ?>
                                <a href="?from_date=<?= urlencode($fromDate) ?>&to_date=<?= urlencode($toDate) ?>&edit_date=<?= urlencode($sheet['report_date']) ?>" class="btn btn-sm fw-bold text-dark no-print shadow-sm px-3" style="background-color: #fbbf24 !important; color: #000000 !important; font-weight: 700 !important; border: 1px solid #f59e0b;" title="Edit Sheet">
                                    <i class="bi bi-pencil-square me-1"></i> Edit Sheet
                                </a>
                            <?php endif; ?>
                        </div>
                    </div>

                    <?php if ($isEditingThisSheet): ?>
                        <div class="alert alert-info py-2 px-3 mb-3 d-flex align-items-center justify-content-between no-print" style="border: 1px solid #b9e6fe; background-color: #f0f9ff; color: #0369a1; border-radius: 6px;">
                            <span class="small fw-semibold"><i class="bi bi-info-circle-fill me-1"></i> <strong>Edit Mode Active:</strong> You can edit the shift status (Y/N) in the table below. Click <strong>Save Changes</strong> above to update the database.</span>
                        </div>
                    <?php endif; ?>

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
                                                    <td>
                                                        <?php if ($isEditingThisSheet): ?>
                                                            <select name="used_status[<?= $mId ?>][<?= $sId ?>]" class="form-select form-select-sm text-center fw-bold" style="width: 70px; margin: 0 auto; background: #fff !important; color: #000 !important; border: 1.5px solid #0284c7; padding: 2px 4px; font-size: 13px;">
                                                                <option value="Y" <?= $status === 'Y' ? 'selected' : '' ?>>Y</option>
                                                                <option value="N" <?= $status === 'N' ? 'selected' : '' ?>>N</option>
                                                                <option value="-" <?= ($status === '-' || empty($status)) ? 'selected' : '' ?>>-</option>
                                                            </select>
                                                        <?php else: ?>
                                                            <strong><?= htmlspecialchars($status) ?></strong>
                                                        <?php endif; ?>
                                                    </td>
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
                            <div class="signature-img-wrap">
                                <?php if (!empty($sheet['isApproved']) && !empty($cdoSignature) && file_exists(__DIR__ . '/uploads/signatures/' . $cdoSignature)): ?>
                                    <img src="uploads/signatures/<?= htmlspecialchars($cdoSignature) ?>" alt="Contractor Sign">
                                <?php endif; ?>
                            </div>
                            <div class="signature-line">Contractor's Representative</div>
                        </div>
                        <div class="signature-box">
                            <div class="signature-img-wrap">
                                <?php if (!empty($sheet['auditor_signature']) && file_exists(__DIR__ . '/uploads/signatures/' . $sheet['auditor_signature'])): ?>
                                    <img src="uploads/signatures/<?= htmlspecialchars($sheet['auditor_signature']) ?>" alt="Authorized Sign">
                                <?php endif; ?>
                            </div>
                            <div class="signature-line">Authorized Railway personnel</div>
                        </div>
                    </div>
                </div>
                <?php if ($isEditingThisSheet): ?>
                </form>
                <?php endif; ?>
                <?php endforeach; ?>
            </div>
        </div>
    </div>
</main>

<?php include 'footer.php'; ?>