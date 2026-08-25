<?php
require_once 'auth.php';

$fromDate = $_GET['from_date'] ?? date('Y-m-d', strtotime('-6 days'));
$toDate = $_GET['to_date'] ?? date('Y-m-d');

// Fetch distinct tokens in date range
$tokensStmt = $pdo->prepare("
    SELECT DISTINCT token_id, report_date 
    FROM mcc_pldc_report 
    WHERE station_id = :station_id AND report_date BETWEEN :from_date AND :to_date
    ORDER BY report_date DESC, token_id DESC
");
$tokensStmt->execute([
    'station_id' => $stationId,
    'from_date' => $fromDate,
    'to_date' => $toDate
]);
$tokens = $tokensStmt->fetchAll();

// Fetch active parameters and shifts
$paramsStmt = $pdo->prepare("
    SELECT id, parameter_name 
    FROM mcc_pldc_param 
    WHERE station_id = :station_id
    ORDER BY id ASC
");
$paramsStmt->execute(['station_id' => $stationId]);
$paramsList = $paramsStmt->fetchAll();
$shiftsStmt = $pdo->prepare("
    SELECT id, shift 
    FROM mcc_pldc_shifts 
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
        SELECT parameter_id, shift_id, rating 
        FROM mcc_pldc_report 
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
        foreach ($reportRows as $row) {
            $reportsMap[$row['parameter_id']][$row['shift_id']] = $row['rating'];
        }

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
        $averageScore = $totalRatingCount > 0 ? round(($totalScoreSum / ($totalRatingCount * 10)) * 100, 1) : 0;

        $sheets[] = [
            'token_id' => $tokenId,
            'report_date' => $reportDate,
            'reports_map' => $reportsMap,
            'average_score' => $averageScore,
            'is_fallback' => false
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
                <a href="PLDC-Summary.php?month=<?= date('m', strtotime($fromDate)) ?>&year=<?= date('Y', strtotime($fromDate)) ?>" class="btn-summary" target="_blank">Summary</a>
                <button type="button" class="btn-print" onclick="window.print()">Print</button>
            </form>

            <div class="report-wrap">
                <?php if ($isFallback): ?>
                    <div class="alert alert-warning no-print" style="margin: 0 0 20px 0; border-radius: 8px; border: 1px solid #ffeeba; background-color: #fff3cd; color: #856404; padding: 12px 20px;">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> No PLDC scorecard reports found for the selected date range. 
                    </div>
                <?php endif; ?>

                <?php foreach ($sheets as $sheet): ?>
                    <div class="report-frame">
                        <!-- Header matching intensive-chemical-report.php -->
                        <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #e2e8f0; padding-bottom: 10px; margin-bottom: 15px;">
                            <h2 style="font-size: 18px; font-weight: 700; color: #1e293b; margin: 0;">Score Card for Pit Line & Depot Cleaning</h2>
                            <?php if (!$sheet['is_fallback']): ?>
                                <span style="font-family: monospace; font-weight: 700; font-size: 12px; background: #e2e8f0; color: #475569; padding: 3px 8px; border-radius: 4px; border: 1px solid #cbd5e1;">Token: <?= htmlspecialchars($sheet['token_id']) ?></span>
                            <?php endif; ?>
                        </div>

                        <!-- Meta details matching intensive-chemical-report.php -->
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
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if (empty($paramsList)): ?>
                                        <tr>
                                            <td colspan="<?= 2 + count($shiftsList) ?>" class="text-center">No parameters found.</td>
                                        </tr>
                                    <?php else: ?>
                                        <?php foreach ($paramsList as $index => $param): 
                                            $pId = $param['id'];
                                        ?>
                                        <tr>
                                            <td><?= $index + 1 ?></td>
                                            <td class="text-left"><?= htmlspecialchars($param['parameter_name']) ?></td>
                                            <?php foreach ($shiftsList as $shift): 
                                                $sId = $shift['id'];
                                                $rating = $sheet['reports_map'][$pId][$sId] ?? '-';
                                            ?>
                                                <td><?= htmlspecialchars($rating) ?></td>
                                            <?php endforeach; ?>
                                        </tr>
                                        <?php endforeach; ?>
                                    <?php endif; ?>
                                </tbody>
                            </table>
                        </div>

                        <div class="report-info">
                            <strong>Scoring Guidelines:</strong> 10 (Excellent), 8 (Very Good), 6 (Good), 4 (Average), 0 (Bad). 
                            Aim for 90-100%. Scores below 70% are not acceptable for payment.
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
                <?php endforeach; ?>
            </div>
        </div>
    </div>
</main>

<?php include 'footer.php'; ?>
