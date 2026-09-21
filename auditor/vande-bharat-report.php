<?php
require_once 'auth.php';
global $pdo;

$fromDate = $_GET['from_date'] ?? date('Y-m-d', strtotime('-6 days'));
$toDate = $_GET['to_date'] ?? date('Y-m-d');
$editToken = $_GET['edit'] ?? '';
$flashSuccess = '';
$flashError = '';

// Handle Direct PHP POST Save (No AJAX)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['save_sheet_changes'])) {
    $targetToken = trim($_POST['token_id'] ?? '');
    $postedScores = $_POST['scores'] ?? [];

    if (!empty($targetToken) && !empty($postedScores)) {
        try {
            $pdo->beginTransaction();

            $chk = $pdo->prepare("SELECT COUNT(*) FROM mcc_vb_scorecard_report WHERE token_id = :tok AND station_id = :sid AND audit_by = :aud");
            $chk->execute(['tok' => $targetToken, 'sid' => $stationId, 'aud' => $auditorId]);

            if ($chk->fetchColumn() > 0) {
                $updStmt = $pdo->prepare("
                    UPDATE mcc_vb_scorecard_report 
                    SET score_value = :val 
                    WHERE token_id = :tok 
                      AND station_id = :sid 
                      AND audit_by = :aud 
                      AND sub_parameter_id = :sp_id 
                      AND coach_no = :c_no
                ");

                foreach ($postedScores as $spId => $coachVals) {
                    foreach ($coachVals as $cNo => $val) {
                        $updStmt->execute([
                            'val' => trim($val),
                            'tok' => $targetToken,
                            'sid' => $stationId,
                            'aud' => $auditorId,
                            'sp_id' => $spId,
                            'c_no' => $cNo
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

// Fetch rating values from database
$ratingStmt = $pdo->query("SELECT rating_name, rating_value, rating_group FROM mcc_vb_rating ORDER BY rating_value DESC");
$ratings = $ratingStmt->fetchAll(PDO::FETCH_ASSOC);
$ratingStrings = [];
foreach ($ratings as $r) {
    $ratingStrings[] = htmlspecialchars($r['rating_name']) . "-" . htmlspecialchars($r['rating_value']);
}
$ratingText = implode(', ', $ratingStrings);

// Fetch the current station's name & contractor for meta info
$stationQuery = $pdo->prepare("SELECT station_name, contractor_name FROM mcc_stations WHERE station_id = :station_id");
$stationQuery->execute(['station_id' => $stationId]);
$stnData = $stationQuery->fetch();
$stationName = $stnData['station_name'] ?? 'Lumdhing';
$contractorName = !empty($stnData['contractor_name']) ? $stnData['contractor_name'] : 'Kingson';

// Fetch distinct tokens/trains in this date range for Vande Bharat report
$stmt = $pdo->prepare("
    SELECT DISTINCT token_id, train_no, report_date 
    FROM mcc_vb_scorecard_report 
    WHERE station_id = :station_id AND report_date BETWEEN :from_date AND :to_date AND audit_by = :auditor_id 
    ORDER BY report_date DESC, token_id DESC
");
$stmt->execute(['station_id' => $stationId, 'from_date' => $fromDate, 'to_date' => $toDate, 'auditor_id' => $auditorId]);
$tokens = $stmt->fetchAll();

// Fetch active parameters and subparameters from the database for Vande Bharat report
$paramsStmt = $pdo->prepare("
    SELECT p.id AS parameter_id, p.parameter_name, sp.id AS sub_parameter_id, sp.sub_parameter_name
    FROM mcc_vb_scorecard_param p
    JOIN mcc_vb_scorecard_sub_param sp ON p.id = sp.parameter_id
    WHERE p.station_id = :param_station_id AND sp.station_id = :sub_station_id AND p.status = 'Active' AND sp.status = 'Active'
    ORDER BY p.id ASC, sp.id ASC
");
$paramsStmt->execute([
    'param_station_id' => $stationId,
    'sub_station_id' => $stationId
]);
$paramsRows = $paramsStmt->fetchAll();

// Group subparameters by parameter
$dynamicParameters = [];
foreach ($paramsRows as $row) {
    $pId = $row['parameter_id'];
    if (!isset($dynamicParameters[$pId])) {
        $dynamicParameters[$pId] = [
            'name' => $row['parameter_name'],
            'sub_parameters' => []
        ];
    }
    $dynamicParameters[$pId]['sub_parameters'][] = [
        'id' => $row['sub_parameter_id'],
        'name' => $row['sub_parameter_name']
    ];
}

$sheets = [];
$isFallback = empty($tokens);

if ($isFallback) {
    // No fallback sheet populated
} else {
    // Fetch reports for each token
    $scoresStmt = $pdo->prepare("
        SELECT s.* 
        FROM mcc_vb_scorecard_report s
        WHERE s.station_id = :station_id AND s.token_id = :token_id
    ");

    foreach ($tokens as $t) {
        $tokenId = $t['token_id'];
        $trainNo = $t['train_no'];
        $reportDate = $t['report_date'];

        $scoresStmt->execute(['station_id' => $stationId, 'token_id' => $tokenId]);
        $rows = $scoresStmt->fetchAll();

        $scoresData = [];
        $supervisorName = 'Shubham';
        $dbCoaches = [];

        if (!empty($rows)) {
            $supervisorName = $rows[0]['auditor_name'] ?? 'Shubham';
            foreach ($rows as $row) {
                $scoresData[$row['sub_parameter_id']][$row['coach_no']] = $row['score_value'];
                $dbCoaches[$row['coach_no']] = true;
            }
            $dbCoaches = array_keys($dbCoaches);
            natsort($dbCoaches);
            $dbCoaches = array_values($dbCoaches);
        }

        $attendedCount = count($dbCoaches);

        // Always show 24 columns, pad with empty string if fewer than 24 coaches in database
        $coaches = $dbCoaches;
        while (count($coaches) < 24) {
            $coaches[] = '';
        }

        // Dynamically map parameter IDs
        $parameterIds = array_keys($dynamicParameters);
        $internalParamId = $parameterIds[0] ?? 0;
        $externalParamId = $parameterIds[1] ?? 0;
        $wateringParamId = $parameterIds[2] ?? 0;

        // Calculations using dynamically loaded parameters
        $internalSum = 0;
        $internalSubParamCount = 0;
        if ($internalParamId && isset($dynamicParameters[$internalParamId])) {
            $internalSubParamCount = count($dynamicParameters[$internalParamId]['sub_parameters']);
            foreach ($coaches as $coach) {
                if ($coach === '') continue;
                foreach ($dynamicParameters[$internalParamId]['sub_parameters'] as $sp) {
                    $val = $scoresData[$sp['id']][$coach] ?? null;
                    if ($val !== null && is_numeric($val)) {
                        $internalSum += intval($val);
                    }
                }
            }
        }
        $internalMax = $attendedCount * $internalSubParamCount * 3;
        $internalPercentage = $internalMax > 0 ? round(($internalSum / $internalMax) * 100, 1) : 0;

        $externalSum = 0;
        $externalSubParamCount = 0;
        if ($externalParamId && isset($dynamicParameters[$externalParamId])) {
            $externalSubParamCount = count($dynamicParameters[$externalParamId]['sub_parameters']);
            foreach ($coaches as $coach) {
                if ($coach === '') continue;
                foreach ($dynamicParameters[$externalParamId]['sub_parameters'] as $sp) {
                    $val = $scoresData[$sp['id']][$coach] ?? null;
                    if ($val !== null && is_numeric($val)) {
                        $externalSum += intval($val);
                    }
                }
            }
        }
        $externalMax = $attendedCount * $externalSubParamCount * 3;
        $externalPercentage = $externalMax > 0 ? round(($externalSum / $externalMax) * 100, 1) : 0;

        $wateringYes = 0;
        $wateringSubParamCount = 0;
        if ($wateringParamId && isset($dynamicParameters[$wateringParamId])) {
            $wateringSubParamCount = count($dynamicParameters[$wateringParamId]['sub_parameters']);
            foreach ($coaches as $coach) {
                if ($coach === '') continue;
                foreach ($dynamicParameters[$wateringParamId]['sub_parameters'] as $sp) {
                    $val = $scoresData[$sp['id']][$coach] ?? null;
                    if ($val === 'Y') {
                        $wateringYes++;
                    }
                }
            }
        }
        $wateringMaxCount = $attendedCount * $wateringSubParamCount;
        $wateringPercentage = $wateringMaxCount > 0 ? round(($wateringYes / $wateringMaxCount) * 100, 1) : 0;

        $auditById = !empty($rows) ? ($rows[0]['audit_by'] ?? null) : null;
        $auditorSig = resolveAuditorSignature($pdo, $auditById, $supervisorName);

        $sheets[] = [
            'token_id' => $tokenId,
            'train_no' => $trainNo,
            'report_date' => $reportDate,
            'supervisor_name' => $supervisorName,
            'auditor_signature' => $auditorSig,
            'coaches' => $coaches,
            'scores_data' => $scoresData,
            'internal_percentage' => $internalPercentage,
            'external_percentage' => $externalPercentage,
            'watering_percentage' => $wateringPercentage,
            'is_fallback' => false,
            'attended_count' => $attendedCount,
            'isApproved' => !empty($rows) ? (int)($rows[0]['isApproved'] ?? 0) : 0
        ];
    }
}

$pageTitle = 'Vande Bharat Score Card | MCC';

$extraStyles = "
.report-wrap{
    padding:10px;
    background:#f5f5f5;
    min-height:100vh;
    font-family: 'Roboto' ! IMPORTANT;
}

.report-frame{
    background:#efefef;
    border:1px solid #999;
    padding:15px 20px !important;
    width:100%;
    overflow-x:auto;
    margin-bottom: 40px !important;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1) !important;
    border-radius: 8px !important;
}

.report-frame:last-child {
    margin-bottom: 0 !important;
}

.report-header h2{
    text-align:center;
    font-size:20px;
    font-weight:700;
    color:#000;
    margin-bottom:0;
}

.report-meta-section{
    width:100%;
    margin-top:5px;
    margin-bottom:10px;
    color:#000;
}

.meta-row{
    display:flex;
    justify-content:center;
    align-items:center;
    gap:25px;
    margin-bottom:2px;
    flex-wrap:wrap;
}

.meta-item{
    font-size:12px;
    font-weight:600;
    white-space:nowrap;
    line-height:.5;
}

.meta-item span{
    font-weight:700;
}

.report-table{
    width:100%;
    border-collapse:collapse;
    font-size:13px;
    background:#fff;
}

.report-table th,
.report-table td{
    border:1px solid #000;
    padding:6px;
    text-align:center;
    vertical-align:middle;
    font-weight:500;
}

.report-table th{
    background: linear-gradient(180deg, #07203a 0%, #07182c 100%) !important;
    color: #fff !important;
    font-weight: 700;
    border-color: #0b476a !important;
}

.sub-category{
    background:#f2f2f2 !important;
    font-weight:600;
    text-align:left !important;
}

.sub-category td{
    padding-left:18px !important;
    text-align:left !important;
    font-weight:700;
}

.report-info{
    margin-top:20px;
    padding:15px;
    background:#fff;
    border:1px solid #ccc;
    font-size:12px;
}

.report-info ul{
    margin-bottom:0;
}

.signature-row{
    display:flex;
    justify-content:space-between;
    margin-top:60px;
    padding:0 30px;
}

.signature-box{
    text-align:center;
    font-size:13px;
    font-weight:700;
}

.signature-line{
    border-top:1px solid #000;
    width:220px;
    padding-top:5px;
}

.report-filter{
    margin-bottom:15px;
    display:flex;
    gap:10px;
    align-items:center;
    flex-wrap:wrap;
}

.btn-go,
.btn-print{
    padding:6px 14px;
    border:none;
    background:#1987C6;
    color:#fff;
    cursor:pointer;
    border-radius:4px;
}

.btn-print{
    background:#111;
}

.table-responsive{
    overflow-x:auto;
}

@media print{
    .app-header,
    .app-sidebar,
    .app-footer,
    .report-filter,
    .no-print{
        display:none !important;
        visibility:hidden !important;
        height:0 !important;
        width:0 !important;
        margin:0 !important;
        padding:0 !important;
    }

    html, body, .app-wrapper, .app-main, .app-content, .container-fluid, .report-wrap{
        padding:0 !important;
        margin:0 !important;
        background:#fff !important;
        width:100% !important;
        max-width:100% !important;
    }

    .app-main {
        margin-left: 0 !important;
        padding-top: 0 !important;
    }

    .report-frame{
        border:none !important;
        background:#fff !important;
        padding:0 !important;
        margin-bottom: 0 !important;
        page-break-after: always !important;
        break-after: page !important;
        page-break-inside: avoid !important;
        break-inside: avoid !important;
        box-shadow: none !important;
        border-radius: 0 !important;
    }

    .report-frame:last-child {
        page-break-after: avoid !important;
        break-after: avoid !important;
    }

    .report-table th{
        background:#07203a !important;
        color:#fff !important;
        -webkit-print-color-adjust:exact !important;
        print-color-adjust:exact !important;
    }
}
";

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
    <div class="app-content">
        <div class="container-fluid">
            <form class="report-filter no-print" method="GET" action="vande-bharat-report.php">
                <label>From:</label>
                <input type="date" name="from_date" value="<?= htmlspecialchars($fromDate); ?>">

                <label>To:</label>
                <input type="date" name="to_date" value="<?= htmlspecialchars($toDate); ?>">

                <button type="submit" class="btn-go">Go</button>

                

                <button type="button" class="btn-print" onclick="window.print()">
                    Print
                </button>
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
                    <div class="alert alert-warning" style="margin: 0 0 15px 0; border-radius: 8px; border: 1px solid #ffeeba; background-color: #fff3cd; color: #856404; padding: 12px 20px;">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> No inspection reports found for the selected date range. 
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
                        <div class="report-header" style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #999; padding-bottom: 10px; margin-bottom: 15px;">
                            <h2 style="margin: 0;">Score Card For Vande Bharat Cleaning</h2>
                            <div class="d-flex align-items-center gap-2">
                                <?php if (!$sheet['is_fallback'] && !empty($sheet['token_id'])): ?>
                                    <span style="font-family: monospace; font-weight: 700; font-size: 13px; background: #e2e8f0; color: #475569; padding: 4px 10px; border-radius: 6px; border: 1px solid #cbd5e1;">Token: <?= htmlspecialchars($sheet['token_id']) ?></span>
                                <?php endif; ?>
                                <?php if (!empty($sheet['isApproved'])): ?>
                                    <span class="badge bg-success px-3 py-2 text-white" style="font-size: 0.85rem; font-weight: 600; border-radius: 6px; box-shadow: 0 2px 5px rgba(21,128,61,0.2);"><i class="bi bi-patch-check-fill me-1"></i> Approved</span>
                                <?php else: ?>
                                    <span class="badge bg-warning text-dark px-3 py-2" style="font-size: 0.85rem; font-weight: 600; border-radius: 6px;"><i class="bi bi-clock-history me-1"></i> Pending Approval</span>
                                <?php endif; ?>

                                <?php if (!$sheet['is_fallback'] && !empty($sheet['token_id'])): ?>
                                    <?php if ($isEditingThisSheet): ?>
                                        <button type="submit" name="save_sheet_changes" class="btn btn-sm btn-success fw-bold text-white no-print shadow-sm px-3" style="font-weight: 700;">
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
                                <span class="small fw-semibold"><i class="bi bi-info-circle-fill me-1"></i> <strong>Edit Mode Active:</strong> You can edit the coach scores in the table cells below. Click <strong>Save Changes</strong> above to update the database.</span>
                            </div>
                        <?php endif; ?>

                        <div class="report-meta-section">
                            <div class="meta-row">
                                <div class="meta-item">
                                    <span>Agreement No & date:</span>
                                    AGR_2026-99-02 & 01-04-2026
                                </div>
                                <div class="meta-item">
                                    <span>Date of Inspection:</span>
                                    <?= htmlspecialchars(date('d-m-Y', strtotime($sheet['report_date']))) ?>
                                </div>
                                <div class="meta-item">
                                    <span>Name of Supervisor:</span>
                                    <?= htmlspecialchars($sheet['supervisor_name']) ?>
                                </div>
                                <div class="meta-item">
                                    <span>Name of Contractor:</span>
                                    <?= htmlspecialchars($contractorName) ?>
                                </div>
                                <div class="meta-item">
                                    <span>Time Work Started:</span>
                                    <?= !$sheet['is_fallback'] ? '08:00' : '....................' ?>
                                </div>
                                <div class="meta-item">
                                    <span>Time Work Completed:</span>
                                    <?= !$sheet['is_fallback'] ? '12:00' : '....................' ?>
                                </div>
                            </div>

                            <div class="meta-row">
                                <div class="meta-item">
                                    <span>Name of Depot:</span>
                                    <?= htmlspecialchars($stationName) ?> Coaching Depot
                                </div>
                                <div class="meta-item">
                                    <span>Train No:</span>
                                    <?= htmlspecialchars($sheet['train_no']) ?>
                                </div>
                                 <div class="meta-item">
                                     <span>Number of Coaches Attended :</span>
                                     <?= $sheet['attended_count'] ?>
                                 </div>
                                <div class="meta-item">
                                    <span>Internal Cleaning Score :</span>
                                    <?= $sheet['internal_percentage'] ?> %
                                </div>
                                <div class="meta-item">
                                    <span>External Cleaning Score :</span>
                                    <?= $sheet['external_percentage'] ?> %
                                </div>
                                <div class="meta-item">
                                    <span>Watering Score :</span>
                                    <?= $sheet['watering_percentage'] ?> %
                                </div>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="report-table">
                                <thead>
                                    <tr>
                                        <th style="width:40px;">S.No</th>
                                        <th style="width:auto;">Coach Position</th>
                                        <?php for ($i = 1; $i <= count($sheet['coaches']); $i++): ?>
                                            <th><?= $i ?></th>
                                        <?php endfor; ?>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>Coach No</td>
                                        <?php foreach ($sheet['coaches'] as $coach): ?>
                                            <td><?= htmlspecialchars($coach) ?></td>
                                        <?php endforeach; ?>
                                    </tr>

                                    <?php 
                                    $paramIndex = 0;
                                    foreach ($dynamicParameters as $pId => $pData): 
                                        $paramLetter = chr(65 + $paramIndex);
                                        $paramIndex++;
                                    ?>
                                        <tr class="sub-category">
                                            <td><?= $paramLetter ?></td>
                                            <td colspan="<?= count($sheet['coaches']) + 1 ?>">
                                                <?= htmlspecialchars($pData['name']) ?>
                                            </td>
                                        </tr>

                                        <?php 
                                        $spIndex = 1;
                                        foreach ($pData['sub_parameters'] as $sp): 
                                        ?>
                                            <tr>
                                                <td><?= $spIndex++ ?></td>
                                                <td style="text-align: left !important; padding-left: 15px !important;">
                                                    <?= htmlspecialchars($sp['name']) ?>
                                                </td>

                                                <?php
                                                $isWatering = (stripos($pData['name'] ?? '', 'water') !== false || stripos($sp['name'] ?? '', 'water') !== false);
                                                $optRatings = array_filter($ratings, function($r) use ($isWatering) {
                                                    $grp = $r['rating_group'] ?? '';
                                                    $val = strtoupper(trim((string)$r['rating_value']));
                                                    if ($isWatering) {
                                                        return ($grp === 'watering' || in_array($val, ['Y', 'N']));
                                                    } else {
                                                        return ($grp !== 'watering' && !in_array($val, ['Y', 'N']));
                                                    }
                                                });
                                                if (empty($optRatings)) {
                                                    $optRatings = $isWatering 
                                                        ? [['rating_value' => 'Y'], ['rating_value' => 'N']]
                                                        : [['rating_value' => '3'], ['rating_value' => '2'], ['rating_value' => '1'], ['rating_value' => '0']];
                                                }

                                                foreach ($sheet['coaches'] as $coach) {
                                                    $hasCoach = (trim((string)$coach) !== '');
                                                    $s = $hasCoach ? ($sheet['scores_data'][$sp['id']][$coach] ?? '-') : '';
                                                    if ($isEditingThisSheet) {
                                                        if ($hasCoach) {
                                                            $val = ($s === '-' ? '' : (string)$s);
                                                            echo "<td style='padding: 2px !important;'>";
                                                            echo "<select name='scores[" . $sp['id'] . "][" . htmlspecialchars($coach) . "]' class='form-select form-select-sm text-center fw-bold' style='width: 52px; margin: 0 auto; background: #ffffff !important; color: #000000 !important; border: 1.5px solid #0284c7; padding: 2px 2px; font-size: 12px; font-weight: 700; height: 28px;'>";
                                                            echo "<option value=''>-</option>";
                                                            $matched = false;
                                                            foreach ($optRatings as $r) {
                                                                $rv = (string)$r['rating_value'];
                                                                $isSelected = ($val !== '' && $val === $rv);
                                                                if ($isSelected) $matched = true;
                                                                echo "<option value='" . htmlspecialchars($rv) . "'" . ($isSelected ? " selected" : "") . ">" . htmlspecialchars($rv) . "</option>";
                                                            }
                                                            if ($val !== '' && !$matched) {
                                                                echo "<option value='" . htmlspecialchars($val) . "' selected>" . htmlspecialchars($val) . "</option>";
                                                            }
                                                            echo "</select>";
                                                            echo "</td>";
                                                        } else {
                                                            echo "<td style='background: #f8fafc;'></td>";
                                                        }
                                                    } else {
                                                        echo "<td>" . ($hasCoach ? htmlspecialchars($s) : "") . "</td>";
                                                    }
                                                }
                                                ?>
                                            </tr>
                                        <?php endforeach; ?>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>

                        <div class="report-info">
                            <strong>Scoring Guidelines:</strong>
                            <ul>
                                <li>
                                    Maximum Marks will be 12 for internal cleaning. This will be counted as under: <?= $ratingText ?>
                                </li>
                                <li>
                                    Maximum Marks will be 3 for exterior cleaning & washing. This will be counted as under:
                                    <?= $ratingText ?>. % can be derived as per the marks
                                    separately.
                                </li>
                            </ul>
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
