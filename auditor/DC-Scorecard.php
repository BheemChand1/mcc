<?php
require_once 'auth.php';
global $pdo;

$fromDate = $_GET['from_date'] ?? date('Y-m-d', strtotime('-6 days'));
$toDate = $_GET['to_date'] ?? date('Y-m-d');
$editToken = $_GET['edit'] ?? '';
$flashSuccess = '';
$flashError = '';

// Handle Direct PHP POST Save (No AJAX)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['save_dc_changes'])) {
    $targetToken = trim($_POST['token_id'] ?? '');
    $postedRatings = $_POST['ratings'] ?? [];

    if (!empty($targetToken) && !empty($postedRatings)) {
        try {
            $pdo->beginTransaction();

            $chk = $pdo->prepare("SELECT COUNT(*) FROM dc_mcc_report WHERE token_id = :tok AND station_id = :sid AND audit_by = :aud");
            $chk->execute(['tok' => $targetToken, 'sid' => $stationId, 'aud' => $auditorId]);

            if ($chk->fetchColumn() > 0) {
                $updStmt = $pdo->prepare("
                    UPDATE dc_mcc_report 
                    SET rating = :val 
                    WHERE token_id = :tok 
                      AND station_id = :sid 
                      AND audit_by = :aud 
                      AND parameter_id = :p_id 
                      AND shift_id = :s_id
                ");

                foreach ($postedRatings as $pId => $shiftVals) {
                    foreach ($shiftVals as $sId => $val) {
                        $updStmt->execute([
                            'val' => trim($val),
                            'tok' => $targetToken,
                            'sid' => $stationId,
                            'aud' => $auditorId,
                            'p_id' => $pId,
                            's_id' => $sId
                        ]);
                    }
                }

                $pdo->commit();
                $flashSuccess = "Scorecard (Token: " . htmlspecialchars($targetToken) . ") updated successfully!";
                $editToken = ''; // Exit edit mode after saving
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

// Fetch distinct tokens in date range
$tokensStmt = $pdo->prepare("
    SELECT DISTINCT token_id, report_date 
    FROM dc_mcc_report 
    WHERE station_id = :station_id AND report_date BETWEEN :from_date AND :to_date AND audit_by = :auditor_id
    ORDER BY report_date DESC, token_id DESC
");
$tokensStmt->execute([
    'station_id' => $stationId,
    'from_date' => $fromDate,
    'to_date' => $toDate,
    'auditor_id' => $auditorId
]);
$tokens = $tokensStmt->fetchAll();

// Fetch active parameters and shifts
$paramsStmt = $pdo->prepare("
    SELECT id, parameter_name 
    FROM dc_mcc_param 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$paramsStmt->execute(['station_id' => $stationId]);
$paramsList = $paramsStmt->fetchAll();
$shiftsStmt = $pdo->prepare("
    SELECT id, shift 
    FROM dc_mcc_shifts 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$shiftsStmt->execute(['station_id' => $stationId]);
$shiftsList = $shiftsStmt->fetchAll();

$isFallback = empty($tokens) || empty($paramsList) || empty($shiftsList);

$sheets = [];

if ($isFallback) {
    // If no parameters or shifts in DB, populate mock ones for headers
    if (empty($paramsList) || empty($shiftsList)) {
        $paramsList = [
            ["id" => 1, "parameter_name" => "Cleaning of drains"],
            ["id" => 2, "parameter_name" => "Cleaning of catwalk and pathways"],
            ["id" => 3, "parameter_name" => "Cleaning of pits"],
            ["id" => 4, "parameter_name" => "Cleaning of Yards (Stabling lines at SCL)"],
            ["id" => 5, "parameter_name" => "Cleaning of roads leading to pit line"],
            ["id" => 6, "parameter_name" => "Disposal of scraps at nominated space"],
            ["id" => 7, "parameter_name" => "Disposal of garbage from Depot premises by truck"],
            ["id" => 8, "parameter_name" => "Cleaning of Depot premises (Sick line, Store, Bedroll, Scrap yard, etc.)"],
            ["id" => 9, "parameter_name" => "Coach cleaning for direct fit coaches from sickline"],
            ["id" => 10, "parameter_name" => "Cleaning of office building at SCL pitline"]
        ];
        $shiftsList = [
            ["id" => 1, "shift" => "Check 1"],
            ["id" => 2, "shift" => "Check 2"],
            ["id" => 3, "shift" => "Check 3"]
        ];
    }
} else {
    // Fetch reports for each token
    $reportStmt = $pdo->prepare("
        SELECT * 
        FROM dc_mcc_report 
        WHERE station_id = :station_id AND token_id = :token_id
    ");

    foreach ($tokens as $t) {
        $tokenId = $t['token_id'];
        $reportDate = $t['report_date'];

        $reportStmt->execute([
            'station_id' => $stationId,
            'token_id' => $tokenId
        ]);
        $reportRows = $reportStmt->fetchAll();

        $reportsMap = [];
        $auditById = null;
        $auditorName = null;
        foreach ($reportRows as $row) {
            $reportsMap[$row['parameter_id']][$row['shift_id']] = $row['rating'];
            if (!empty($row['audit_by'])) {
                $auditById = $row['audit_by'];
            }
            if (!empty($row['auditor_name'])) {
                $auditorName = $row['auditor_name'];
            }
        }
        $auditorSig = resolveAuditorSignature($pdo, $auditById, $auditorName);

        // Calculate average score
        $totalScoreSum = 0;
        $totalRatingCount = 0;
        foreach ($paramsList as $param) {
            $pId = $param['id'];
            foreach ($shiftsList as $shift) {
                $sId = $shift['id'];
                if (isset($reportsMap[$pId][$sId]) && $reportsMap[$pId][$sId] !== null) {
                    $totalScoreSum += intval($reportsMap[$pId][$sId]);
                    $totalRatingCount++;
                }
            }
        }
        $averageScore = $totalRatingCount > 0 ? round(($totalScoreSum / ($totalRatingCount * 3)) * 100, 1) : 0;

        $sheets[] = [
            'token_id' => $tokenId,
            'report_date' => $reportDate,
            'reports_map' => $reportsMap,
            'average_score' => $averageScore,
            'auditor_signature' => $auditorSig,
            'is_fallback' => false,
            'isApproved' => !empty($reportRows) ? (int)($reportRows[0]['isApproved'] ?? 0) : 0
        ];
    }
}

$extraStyles = "
.report-frame {
    background: #fff !important;
    border: 1px solid #000000 !important;
    padding: 20px !important;
    width: 100% !important;
    overflow-x: auto !important;
    margin-bottom: 50px !important;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1) !important;
    border-radius: 8px !important;
}
.report-frame:last-child {
    margin-bottom: 0 !important;
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
    .modal-backdrop,
    .offcanvas-backdrop,
    #sidebar-overlay {
        display: none !important;
        opacity: 0 !important;
        visibility: hidden !important;
        width: 0 !important;
        height: 0 !important;
    }
    
    html,
    body, 
    .bg-body-tertiary,
    .app-wrapper, 
    .app-main, 
    .app-content, 
    .container-fluid, 
    .report-wrap,
    .report-frame {
        margin: 0 !important;
        padding: 0 !important;
        width: 100% !important;
        max-width: 100% !important;
        min-width: 100% !important;
        background: #fff !important;
        background-color: #fff !important;
        box-shadow: none !important;
        position: static !important;
        overflow: visible !important;
        opacity: 1 !important;
        filter: none !important;
        transition: none !important;
        animation: none !important;
    }
    
    .app-main {
        padding-top: 0 !important;
        margin-left: 0 !important;
    }
    
    .report-frame {
        margin: 0 0 20px 0 !important;
        padding: 0 !important;
        border: none !important;
        box-shadow: none !important;
        page-break-inside: avoid !important;
        page-break-after: always !important;
        break-after: page !important;
        width: 100% !important;
        background: #fff !important;
        overflow: visible !important;
    }
    
    .report-frame:last-child {
        page-break-after: avoid !important;
        break-after: avoid !important;
        margin-bottom: 0 !important;
    }
}
</style>

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

                <?php if ($isFallback): ?>
                    <div class="alert alert-warning no-print" style="margin: 0 0 20px 0; border-radius: 8px; border: 1px solid #ffeeba; background-color: #fff3cd; color: #856404; padding: 12px 20px;">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> No DC scorecard reports found for the selected date range. 
                    </div>
                <?php endif; ?>

                <?php foreach ($sheets as $sheet): 
                    $isEditingThisSheet = (!$sheet['is_fallback'] && !empty($sheet['token_id']) && (string)$editToken === (string)$sheet['token_id']);
                ?>
                    <?php if ($isEditingThisSheet): ?>
                    <form method="POST" action="">
                        <input type="hidden" name="token_id" value="<?= htmlspecialchars($sheet['token_id']) ?>">
                        <input type="hidden" name="from_date" value="<?= htmlspecialchars($fromDate) ?>">
                        <input type="hidden" name="to_date" value="<?= htmlspecialchars($toDate) ?>">
                    <?php endif; ?>

                    <div class="report-frame" style="<?= $isEditingThisSheet ? 'border: 2px solid #0284c7; box-shadow: 0 0 22px rgba(2, 132, 199, 0.35);' : '' ?>">
                        <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #e2e8f0; padding-bottom: 10px; margin-bottom: 15px;">
                            <h2 style="font-size: 18px; font-weight: 700; color: #1e293b; margin: 0;">Score Card for Pit Line & Depot Cleaning</h2>
                            <div class="d-flex align-items-center gap-2">
                                <?php if (!$sheet['is_fallback'] && !empty($sheet['token_id'])): ?>
                                    <span style="font-family: monospace; font-weight: 700; font-size: 12px; background: #e2e8f0; color: #475569; padding: 3px 8px; border-radius: 4px; border: 1px solid #cbd5e1;">Token: <?= htmlspecialchars($sheet['token_id']) ?></span>
                                <?php endif; ?>
                                <?php if (!empty($sheet['isApproved'])): ?>
                                    <span class="badge bg-success px-3 py-2 text-white" style="font-size: 0.85rem; font-weight: 600; border-radius: 6px; box-shadow: 0 2px 5px rgba(21,128,61,0.2);"><i class="bi bi-patch-check-fill me-1"></i> Approved</span>
                                <?php else: ?>
                                    <span class="badge bg-warning text-dark px-3 py-2" style="font-size: 0.85rem; font-weight: 600; border-radius: 6px;"><i class="bi bi-clock-history me-1"></i> Pending Approval</span>
                                <?php endif; ?>

                                <?php if (!$sheet['is_fallback'] && !empty($sheet['token_id'])): ?>
                                    <?php if ($isEditingThisSheet): ?>
                                        <button type="submit" name="save_dc_changes" class="btn btn-sm btn-success fw-bold text-white no-print shadow-sm px-3" style="font-weight: 700;">
                                            <i class="bi bi-check2-circle me-1"></i> Save Changes
                                        </button>
                                        <a href="?from_date=<?= urlencode($fromDate) ?>&to_date=<?= urlencode($toDate) ?>" class="btn btn-sm btn-secondary fw-bold text-white no-print shadow-sm px-3">
                                            <i class="bi bi-x-circle me-1"></i> Cancel
                                        </a>
                                    <?php else: ?>
                                        <a href="?from_date=<?= urlencode($fromDate) ?>&to_date=<?= urlencode($toDate) ?>&edit=<?= urlencode($sheet['token_id']) ?>" class="btn btn-sm fw-bold text-dark no-print shadow-sm px-3" style="background-color: #fbbf24 !important; color: #000000 !important; font-weight: 700 !important; border: 1px solid #f59e0b;" title="Edit Sheet">
                                            <i class="bi bi-pencil-square me-1"></i> Edit Sheet
                                        </a>
                                    <?php endif; ?>
                                <?php endif; ?>
                            </div>
                        </div>

                        <?php if ($isEditingThisSheet): ?>
                            <div class="alert alert-info py-2 px-3 mb-3 d-flex align-items-center justify-content-between no-print" style="border: 1px solid #b9e6fe; background-color: #f0f9ff; color: #0369a1; border-radius: 6px;">
                                <span class="small fw-semibold"><i class="bi bi-info-circle-fill me-1"></i> <strong>Edit Mode Active:</strong> You can edit the shift ratings (0, 1, 2, 3) below. Click <strong>Save Changes</strong> above to update the database.</span>
                            </div>
                        <?php endif; ?>

                        <div style="font-size: 13px; color: #334155; margin-bottom: 15px; border-bottom: 1px solid #e2e8f0; padding-bottom: 10px; line-height: 1.6;">
                            <div style="display: flex; flex-wrap: wrap; justify-content: space-between; gap: 8px 16px;">
                                <div>
                                    <strong>Depot:</strong> <?= htmlspecialchars($stationName) ?> &nbsp;|&nbsp;
                                    <strong>Inspection Date:</strong> <?= htmlspecialchars(date('d-m-Y', strtotime($sheet['report_date']))) ?>
                                    <?php if (!$sheet['is_fallback']): ?>
                                        &nbsp;|&nbsp; <strong>Token:</strong> <?= htmlspecialchars($sheet['token_id']) ?>
                                    <?php endif; ?>
                                </div>
                                <div>
                                    <strong>Contractor:</strong> <?= htmlspecialchars($contractorName) ?> &nbsp;|&nbsp;
                                    <strong>Avg. Score:</strong> <span style="color: #15803d; font-weight: 700;"><?= htmlspecialchars($sheet['average_score']) ?>%</span>
                                </div>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="report-table">
                                <thead>
                                    <tr>
                                        <th style="width:50px">S.No</th>
                                        <th class="text-left">Items For Cleaning</th>
                                        <?php foreach ($shiftsList as $shift): ?>
                                            <th style="width:150px"><?= htmlspecialchars($shift['shift']) ?></th>
                                        <?php endforeach; ?>
                                        <th style="width:120px">Average Score</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if (empty($paramsList)): ?>
                                        <tr>
                                            <td colspan="<?= 3 + count($shiftsList) ?>" class="text-center">No parameters found.</td>
                                        </tr>
                                    <?php else: ?>
                                        <?php foreach ($paramsList as $index => $param): 
                                            $pId = $param['id'];
                                            
                                            // Compute row average score
                                            $rowScoreSum = 0;
                                            $rowRatingCount = 0;
                                            foreach ($shiftsList as $shift) {
                                                $sId = $shift['id'];
                                                $ratingVal = $sheet['reports_map'][$pId][$sId] ?? null;
                                                if ($ratingVal !== null && $ratingVal !== '' && $ratingVal !== '-') {
                                                    $rowScoreSum += intval($ratingVal);
                                                    $rowRatingCount++;
                                                }
                                            }
                                            $rowAvg = $rowRatingCount > 0 ? round(($rowScoreSum / ($rowRatingCount * 3)) * 100, 1) . '%' : '-';
                                        ?>
                                        <tr>
                                            <td><?= $index + 1 ?></td>
                                            <td class="text-left"><?= htmlspecialchars($param['parameter_name']) ?></td>
                                            <?php foreach ($shiftsList as $shift): 
                                                $sId = $shift['id'];
                                                $rating = $sheet['reports_map'][$pId][$sId] ?? '-';
                                            ?>
                                                <td>
                                                    <?php if ($isEditingThisSheet): ?>
                                                        <input type="text" name="ratings[<?= $pId ?>][<?= $sId ?>]" value="<?= htmlspecialchars($rating === '-' ? '' : $rating) ?>" class="form-control form-control-sm text-center fw-bold" style="width: 60px; margin: 0 auto; background: #fff !important; color: #000 !important; border: 1.5px solid #0284c7; padding: 2px 4px; font-size: 13px;">
                                                    <?php else: ?>
                                                        <?= htmlspecialchars($rating) ?>
                                                    <?php endif; ?>
                                                </td>
                                            <?php endforeach; ?>
                                            <td><strong><?= $rowAvg ?></strong></td>
                                        </tr>
                                        <?php endforeach; ?>
                                    <?php endif; ?>
                                </tbody>
                            </table>
                        </div>

                        <div class="report-info">
                            <strong>Scoring Guidelines:</strong> Very Good (3), Satisfactory (2), Poor (1), Not attended (0). 
                            Aim for 90-100%. Scores below 70% are not acceptable for payment.
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
