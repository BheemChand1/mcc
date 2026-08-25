<?php
require_once '../connection.php';
global $pdo;

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
$stationId = $_SESSION['station_id'] ?? 1;

$fromDate = $_GET['from_date'] ?? date('Y-m-d', strtotime('-6 days'));
$toDate = $_GET['to_date'] ?? date('Y-m-d');

// Fetch distinct tokens/trains in this date range for PRT report
$stmt = $pdo->prepare("
    SELECT DISTINCT token_id, train_no, report_date 
    FROM mcc_prt_scorecard_report 
    WHERE station_id = :station_id AND report_date BETWEEN :from_date AND :to_date 
    ORDER BY report_date DESC, token_id DESC
");
$stmt->execute(['station_id' => $stationId, 'from_date' => $fromDate, 'to_date' => $toDate]);
$tokens = $stmt->fetchAll();

// Fetch active parameters and subparameters from the database for PRT report
$paramsStmt = $pdo->prepare("
    SELECT p.id AS parameter_id, p.parameter_name, sp.id AS sub_parameter_id, sp.sub_parameter_name
    FROM mcc_prt_scorecard_param p
    JOIN mcc_prt_scorecard_sub_param sp ON p.id = sp.parameter_id
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
        SELECT s.*, u.full_name AS supervisor_name 
        FROM mcc_prt_scorecard_report s
        LEFT JOIN mcc_users u ON s.submitted_by = u.user_id
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
            $supervisorName = $rows[0]['supervisor_name'] ?? 'Shubham';
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
        $internalCount = 0;
        if ($internalParamId && isset($dynamicParameters[$internalParamId])) {
            foreach ($coaches as $coach) {
                if ($coach === '') continue;
                foreach ($dynamicParameters[$internalParamId]['sub_parameters'] as $sp) {
                    $val = $scoresData[$sp['id']][$coach] ?? null;
                    if ($val !== null && is_numeric($val)) {
                        $internalSum += intval($val);
                        $internalCount++;
                    }
                }
            }
        }
        $internalMax = $internalCount * 3;
        $internalPercentage = $internalMax > 0 ? round(($internalSum / $internalMax) * 100, 1) : 0;

        $externalSum = 0;
        $externalCount = 0;
        if ($externalParamId && isset($dynamicParameters[$externalParamId])) {
            foreach ($coaches as $coach) {
                if ($coach === '') continue;
                foreach ($dynamicParameters[$externalParamId]['sub_parameters'] as $sp) {
                    $val = $scoresData[$sp['id']][$coach] ?? null;
                    if ($val !== null && is_numeric($val)) {
                        $externalSum += intval($val);
                        $externalCount++;
                    }
                }
            }
        }
        $externalMax = $externalCount * 3;
        $externalPercentage = $externalMax > 0 ? round(($externalSum / $externalMax) * 100, 1) : 0;

        $wateringYes = 0;
        $wateringCount = 0;
        if ($wateringParamId && isset($dynamicParameters[$wateringParamId])) {
            foreach ($coaches as $coach) {
                if ($coach === '') continue;
                foreach ($dynamicParameters[$wateringParamId]['sub_parameters'] as $sp) {
                    $val = $scoresData[$sp['id']][$coach] ?? null;
                    if ($val === 'Y') {
                        $wateringYes++;
                        $wateringCount++;
                    } elseif ($val === 'N') {
                        $wateringCount++;
                    }
                }
            }
        }
        $wateringPercentage = $wateringCount > 0 ? round(($wateringYes / $wateringCount) * 100, 1) : 0;

        $sheets[] = [
            'token_id' => $tokenId,
            'train_no' => $trainNo,
            'report_date' => $reportDate,
            'supervisor_name' => $supervisorName,
            'coaches' => $coaches,
            'scores_data' => $scoresData,
            'internal_percentage' => $internalPercentage,
            'external_percentage' => $externalPercentage,
            'watering_percentage' => $wateringPercentage,
            'is_fallback' => false,
            'attended_count' => $attendedCount
        ];
    }
}

$pageTitle = 'PRT Scorecard | MCC';

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
    background:#1987C6;
    color:#fff;
    font-weight:700;
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
    .no-print{
        display:none !important;
    }

    .report-wrap{
        padding:0;
        background:#fff;
    }

    .report-frame{
        border:none;
        background:#fff;
        padding:0;
        margin-bottom: 0 !important;
        page-break-after: always !important;
        break-after: page !important;
        box-shadow: none !important;
        border-radius: 0 !important;
    }

    .report-frame:last-child {
        page-break-after: avoid !important;
        break-after: avoid !important;
    }

    .report-table th{
        background:#1987C6 !important;
        color:#fff !important;
        -webkit-print-color-adjust:exact;
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
                <label>From:</label>
                <input type="date" name="from_date" value="<?= htmlspecialchars($fromDate); ?>">

                <label>To:</label>
                <input type="date" name="to_date" value="<?= htmlspecialchars($toDate); ?>">

                <button type="submit" class="btn-go">Go</button>

                <a href="Platform-Return-TrainsSummary.php?month=<?= date('m', strtotime($fromDate)) ?>&year=<?= date('Y', strtotime($fromDate)) ?>" class="btn-summary" target="_blank">Summary</a>

                <button type="button" class="btn-print" onclick="window.print()">
                    Print
                </button>
            </form>

            <div class="report-wrap">
                <?php if ($isFallback): ?>
                    <div class="alert alert-warning" style="margin: 0 0 15px 0; border-radius: 8px; border: 1px solid #ffeeba; background-color: #fff3cd; color: #856404; padding: 12px 20px;">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> No inspection reports found for the selected date range. 
                    </div>
                <?php endif; ?>

                <?php foreach ($sheets as $sheet): ?>
                    <div class="report-frame">
                        <div class="report-header" style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #999; padding-bottom: 10px; margin-bottom: 15px;">
                            <h2 style="margin: 0;">Score Card For Platform Return Train Cleaning</h2>
                            <?php if (!$sheet['is_fallback']): ?>
                                <span style="font-family: monospace; font-weight: 700; font-size: 13px; background: #e2e8f0; color: #475569; padding: 4px 10px; border-radius: 6px; border: 1px solid #cbd5e1;">Token: <?= htmlspecialchars($sheet['token_id']) ?></span>
                            <?php endif; ?>
                        </div>

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
                                    Kingson
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
                                    Silchar Coaching Depot
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
                                                foreach ($sheet['coaches'] as $coach) {
                                                    $s = $sheet['scores_data'][$sp['id']][$coach] ?? '-';
                                                    echo "<td>" . htmlspecialchars($s) . "</td>";
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
                                    Maximum Marks will be 15 for internal cleaning. This will be counted as under: Very
                                    Good- 3, Satisfactory-2, Poor-1,Not attended-0
                                </li>
                                <li>
                                    Maximum Marks will be 3 for exterior cleaning & washing. This will be counted as under:
                                    Very Good-3, Satisfactory-2, Poor-1, Not attended-0. % can be derived as per the marks
                                    separately.
                                </li>
                            </ul>
                        </div>

                        <div class="signature-row">
                            <div class="signature-box">
                                <div class="signature-line">Auditor Signature</div>
                            </div>
                            <div class="signature-box">
                                <div class="signature-line">On Duty Supervisor Signature</div>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    </div>
</main>

<?php include 'footer.php'; ?>