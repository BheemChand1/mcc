<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
$stationId = $_SESSION['station_id'] ?? 1;

require_once 'auth.php';

$fromDate = $_GET['from_date'] ?? date('Y-m-d', strtotime('-6 days'));
$toDate = $_GET['to_date'] ?? date('Y-m-d');

// 2. Fetch active parameters for Pit & Office Cleaning for this station
$paramsStmt = $pdo->prepare("
    SELECT id, item_name, max_marks, parameter_desc 
    FROM mcc_surprise_parameters 
    WHERE category = 'pit_office' AND station_id = :station_id AND status = 'Active' 
    ORDER BY id ASC
");
$paramsStmt->execute(['station_id' => $stationId]);
$parameters = $paramsStmt->fetchAll();

// 3. Fetch reports in date range
$reportsStmt = $pdo->prepare("
    SELECT r.token_id, r.report_date, u.full_name AS supervisor_name, r.parameter_id, r.value, r.score_label
    FROM mcc_surprise_reports r
    LEFT JOIN mcc_users u ON r.submitted_by = u.user_id
    WHERE r.station_id = :station_id AND r.category = 'pit_office' AND r.report_date BETWEEN :from_date AND :to_date
    ORDER BY r.report_date DESC, r.token_id DESC, r.id ASC
");
$reportsStmt->execute([
    'station_id' => $stationId,
    'from_date' => $fromDate,
    'to_date' => $toDate
]);
$reportRows = $reportsStmt->fetchAll();

// Group rows by token_id and report_date
$groupedSheets = [];
foreach ($reportRows as $row) {
    $key = $row['token_id'] . '_' . $row['report_date'];
    if (!isset($groupedSheets[$key])) {
        $groupedSheets[$key] = [
            'token_id' => $row['token_id'],
            'report_date' => $row['report_date'],
            'supervisor_name' => $row['supervisor_name'] ?? 'CDO',
            'scores' => [],
            'total_score' => 0
        ];
    }
    $groupedSheets[$key]['scores'][$row['parameter_id']] = [
        'score' => $row['value'],
        'label' => $row['score_label']
    ];
    $groupedSheets[$key]['total_score'] += intval($row['value']);
}

$sheets = [];
foreach ($groupedSheets as $sheet) {
    $sheet['percentage'] = round(($sheet['total_score'] / 30) * 100, 1);
    $sheets[] = $sheet;
}

$isFallback = empty($sheets);

if ($isFallback) { }

$pageTitle = 'Pit & Office Cleaning Surprise Visit | CDO';

$extraStyles = "
.report-frame {
    background: #fff !important;
    border: 1px solid #e2e8f0 !important;
    padding: 25px !important;
    width: 100% !important;
    overflow-x: auto !important;
    margin-bottom: 30px !important;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06) !important;
    border-radius: 12px !important;
}
.report-frame:last-child {
    margin-bottom: 0 !important;
}
.report-table th {
    background: linear-gradient(180deg, #1987C6 0%, #146ea3 100%) !important;
    color: white !important;
    font-weight: 600 !important;
    text-align: center;
    vertical-align: middle;
}
.report-table td {
    text-align: center;
    vertical-align: middle;
}
.report-table td.text-left {
    text-align: left !important;
}
.score-badge {
    display: inline-block;
    padding: 4px 10px;
    border-radius: 6px;
    font-weight: 700;
    font-size: 13px;
}
.score-badge-good { background-color: #dcfce7; color: #166534; }
.score-badge-warn { background-color: #fef9c3; color: #854d0e; }
.score-badge-danger { background-color: #fee2e2; color: #991b1b; }
";

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
    <div class="app-content">
        <div class="container-fluid">
            <!-- Filter Bar -->
            <form class="report-filter no-print" method="GET">
                <label for="from_date">From:</label>
                <input type="date" id="from_date" name="from_date" value="<?= htmlspecialchars($fromDate); ?>">
                <label for="to_date">To:</label>
                <input type="date" id="to_date" name="to_date" value="<?= htmlspecialchars($toDate); ?>">
                
                <button type="submit" class="btn-go">Go</button>
                <a href="surprise-pit-office-summary.php?month=<?= date('m', strtotime($fromDate)) ?>&year=<?= date('Y', strtotime($fromDate)) ?>" class="btn-summary">Summary</a>
                <button type="button" class="btn-print" onclick="window.print()">Print</button>
            </form>

            <!-- Reports Wrapper -->
            <div id="reports-wrap" class="report-wrap">
                <?php if ($isFallback): ?>
                    <div class="alert alert-warning no-print" style="margin: 0 0 20px 0; border-radius: 8px; border: 1px solid #ffeeba; background-color: #fff3cd; color: #856404; padding: 12px 20px;">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> No surprise visit reports found for the selected date range. 
                    </div>
                <?php endif; ?>

                <?php foreach ($sheets as $sheet): ?>
                    <?php 
                    $sumScore = $sheet['total_score'];
                    $percentage = $sheet['percentage'];

                    $scoreBadgeClass = "score-badge-good";
                    if ($percentage < 70) {
                        $scoreBadgeClass = "score-badge-danger";
                    } else if ($percentage < 85) {
                        $scoreBadgeClass = "score-badge-warn";
                    }
                    ?>
                    <div class="report-frame">
                        <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #e2e8f0; padding-bottom: 10px; margin-bottom: 15px;">
                            <h2 style="font-size: 18px; font-weight: 700; color: #1e293b; margin: 0;">Surprise Visit Score Card - Pit & Office Cleaning</h2>
                            <span style="font-family: monospace; font-weight: 700; font-size: 12px; background: #e2e8f0; color: #475569; padding: 3px 8px; border-radius: 4px; border: 1px solid #cbd5e1;">Token: <?= htmlspecialchars($sheet['token_id']); ?></span>
                        </div>

                        <div style="font-size: 13px; color: #334155; margin-bottom: 15px; border-bottom: 1px solid #e2e8f0; padding-bottom: 10px; line-height: 1.6;">
                            <div style="display: flex; flex-wrap: wrap; justify-content: space-between; gap: 8px 16px;">
                                <div>
                                    <strong>Depot:</strong> <?= htmlspecialchars($stationName) ?> Coaching Depot &nbsp;|&nbsp;
                                    <strong>Inspection Date:</strong> <?= htmlspecialchars(date('d-m-Y', strtotime($sheet['report_date']))); ?> &nbsp;|&nbsp;
                                    <strong>Supervisor:</strong> <?= htmlspecialchars($sheet['supervisor_name']); ?>
                                </div>
                                <div>
                                    <strong>Contractor:</strong> <?= htmlspecialchars($contractorName) ?> &nbsp;|&nbsp;
                                    <strong>Avg. Score:</strong> <span class="score-badge <?= $scoreBadgeClass; ?>"><?= $percentage; ?>%</span>
                                </div>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="report-table table table-bordered">
                                <thead>
                                    <tr>
                                        <th style="width:50px">SN</th>
                                        <th>Items</th>
                                        <th style="width:130px">Maximum Marks</th>
                                        <th>Parameters</th>
                                        <th style="width:280px">Score (0-5)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($parameters as $index => $param): 
                                        $paramId = $param['id'];
                                        $scoreVal = $sheet['scores'][$paramId]['score'] ?? '-';
                                        $scoreLabel = $sheet['scores'][$paramId]['label'] ?? '-';
                                    ?>
                                    <tr>
                                        <td><?= $index + 1; ?></td>
                                        <td class="text-left font-weight-bold"><?= htmlspecialchars($param['item_name']); ?></td>
                                        <td><?= htmlspecialchars($param['max_marks']); ?></td>
                                        <td class="text-left"><?= htmlspecialchars($param['parameter_desc']); ?></td>
                                        <td class="font-weight-bold"><?= htmlspecialchars($scoreLabel); ?> (Score: <?= $scoreVal; ?>)</td>
                                    </tr>
                                    <?php endforeach; ?>
                                    <tr class="bg-light font-weight-bold">
                                        <td colspan="2" class="text-left">Total Quality Score</td>
                                        <td>30</td>
                                        <td class="text-left">Sum of individual scores</td>
                                        <td class="font-weight-bold text-primary"><?= $sumScore; ?> / 30 (<?= $percentage; ?>%)</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <div class="report-info no-print" style="margin-top: 15px; border-radius: 8px; border: 1px solid #cbd5e1; background-color: #f8fafc; padding: 12px 18px; font-size: 13px; color: #475569;">
                            <strong>Scoring Guidelines:</strong> 5 (Excellent/No shortage), 4 (Very Good / 1-10% shortage), 3 (Good / Partially available), 2 (11-20% shortage), 1 (Average), 0 (Poor / Not available / Shortage > 20%).
                        </div>

                        <div class="signature-row" style="display: flex; justify-content: space-between; margin-top: 40px; padding: 0 15px;">
                            <div class="signature-box" style="text-align: center;">
                                <div class="signature-line" style="border-top: 1px solid #94a3b8; width: 200px; padding-top: 5px; color: #475569; font-weight: 600; font-size: 13px;">Contractor's Supervisor</div>
                            </div>
                            <div class="signature-box" style="text-align: center;">
                                <div class="signature-line" style="border-top: 1px solid #94a3b8; width: 200px; padding-top: 5px; color: #475569; font-weight: 600; font-size: 13px;">Authorized Railway Officer</div>
                            </div>
                        </div>
                    </div>
                <?php endforeach; ?>
            </div>
        </div>
    </div>
</main>

<?php include 'footer.php'; ?>
