<?php
/**
 * CDO Dashboard - Monthly Summary for Intensive Cleaning of Pantry Car
 */
require_once 'auth.php';

// Target month & year selection
$selectedMonth = $_GET['month'] ?? date('m');
$selectedYear  = $_GET['year']  ?? date('Y');

// Standardize
$selectedMonth = str_pad($selectedMonth, 2, '0', STR_PAD_LEFT);
$selectedYear  = intval($selectedYear);

$startDate   = "$selectedYear-$selectedMonth-01";
$endDate     = date('Y-m-t', strtotime($startDate));
$daysInMonth = cal_days_in_month(CAL_GREGORIAN, intval($selectedMonth), $selectedYear);

// Station information
$stationQuery = $pdo->prepare("
    SELECT s.station_name, s.contractor_name, d.division_name, z.zone_name 
    FROM mcc_stations s
    LEFT JOIN mcc_divisions d ON s.division_id = d.division_id
    LEFT JOIN mcc_zones z ON d.zone_id = z.zone_id
    WHERE s.station_id = :station_id
");
$stationQuery->execute(['station_id' => $stationId]);
$stnData = $stationQuery->fetch();

$railwayName    = strtoupper($stnData['zone_name'] ?? 'NORTH EASTERN RAILWAY');
$divisionName   = strtoupper($stnData['division_name'] ?? 'LUCKNOW - NER');
$stationName    = ucfirst($stnData['station_name'] ?? 'Gorakhpur');
$contractorName = $stnData['contractor_name'] ?? 'Prime Cleaning Services';

// Fetch active parameters and sub-parameters for intensive pantry scorecard
$paramStmt = $pdo->prepare("
    SELECT p.id AS param_id, p.parameter_name, sp.id AS sub_param_id, sp.sub_parameter_name 
    FROM mcc_intensive_pantry_param p
    JOIN mcc_intensive_pantry_sub_param sp ON p.id = sp.parameter_id
    WHERE p.station_id = :p_station_id AND sp.station_id = :sp_station_id AND p.status = 'Active' AND sp.status = 'Active'
    ORDER BY p.id ASC, sp.id ASC
");
$paramStmt->execute(['p_station_id' => $stationId, 'sp_station_id' => $stationId]);
$paramRows = $paramStmt->fetchAll();

$totalSubParamsCount = count($paramRows);
$maxScorePerCoach = $totalSubParamsCount > 0 ? ($totalSubParamsCount * 3) : 54;

// Fetch distinct inspection tokens in selected month
$tokensStmt = $pdo->prepare("
    SELECT DISTINCT token_id, train_no, report_date 
    FROM mcc_intensive_pantry_report 
    WHERE station_id = :station_id AND report_date BETWEEN :start_date AND :end_date 
    ORDER BY report_date ASC, id ASC
");
$tokensStmt->execute([
    'station_id' => $stationId,
    'start_date' => $startDate,
    'end_date'   => $endDate
]);
$tokens = $tokensStmt->fetchAll();

$sheets = [];
$reportStmt = $pdo->prepare("
    SELECT r.sub_parameter_id, r.coach_no, r.score_value, r.submitted_by, u.full_name AS auditor_name
    FROM mcc_intensive_pantry_report r
    LEFT JOIN mcc_users u ON r.submitted_by = u.user_id
    WHERE r.station_id = :station_id AND r.token_id = :token_id
    ORDER BY r.id ASC
");

foreach ($tokens as $t) {
    $tokenId    = $t['token_id'];
    $trainNo    = $t['train_no'];
    $reportDate = $t['report_date'];

    $reportStmt->execute(['station_id' => $stationId, 'token_id' => $tokenId]);
    $entries = $reportStmt->fetchAll();

    $uniqueCoaches = [];
    $supervisorName = 'prabhunath';
    $totalObtained = 0.0;
    $totalPossible = 0;

    foreach ($entries as $sc) {
        if (!empty($sc['coach_no']) && !in_array($sc['coach_no'], $uniqueCoaches)) {
            $uniqueCoaches[] = $sc['coach_no'];
        }
        if (!empty($sc['auditor_name'])) {
            $supervisorName = $sc['auditor_name'];
        } elseif (!empty($sc['submitted_by'])) {
            $supervisorName = $sc['submitted_by'];
        }

        $val = $sc['score_value'];
        if (is_numeric($val)) {
            $totalObtained += floatval($val);
            $totalPossible += 3;
        } else {
            $v = strtolower(trim((string)$val));
            if ($v === '3' || $v === 'vg' || $v === 'very good') { $totalObtained += 3; $totalPossible += 3; }
            elseif ($v === '2' || $v === 'sat' || $v === 'satisfactory' || $v === 'good') { $totalObtained += 2; $totalPossible += 3; }
            elseif ($v === '1' || $v === 'poor') { $totalObtained += 1; $totalPossible += 3; }
            elseif ($v === '0' || $v === 'not attended') { $totalObtained += 0; $totalPossible += 3; }
        }
    }

    if (empty($uniqueCoaches)) {
        $uniqueCoaches = ['WGACCW 19208'];
    }

    if ($totalPossible === 0) {
        $totalPossible = count($uniqueCoaches) * $maxScorePerCoach;
        $totalObtained = $totalPossible;
    }

    $pct = $totalPossible > 0 ? round(($totalObtained / $totalPossible) * 100, 2) : 0;

    $sheets[] = [
        'token_id'        => $tokenId,
        'train_no'        => $trainNo,
        'report_date'     => $reportDate,
        'coaches'         => implode(', ', $uniqueCoaches),
        'coach_count'     => count($uniqueCoaches),
        'supervisor_name' => $supervisorName,
        'obtained'        => round($totalObtained, 1),
        'possible'        => $totalPossible,
        'percentage'      => $pct
    ];
}

// Compute Monthly Average Score across all sheets
$averageMonthlyScore = 0.0;
$totalCoachesCleaned = 0;
if (count($sheets) > 0) {
    $totalPercent = 0.0;
    foreach ($sheets as $sheet) {
        $totalPercent += $sheet['percentage'];
        $totalCoachesCleaned += $sheet['coach_count'];
    }
    $averageMonthlyScore = round($totalPercent / count($sheets), 2);
}

// Group sheets by day
$sheetsByDay = [];
foreach ($sheets as $sheet) {
    $day = intval(date('d', strtotime($sheet['report_date'])));
    $sheetsByDay[$day][] = $sheet;
}

$pageTitle = 'Monthly Intensive Pantry Car Scorecard Summary | MCC';

$extraStyles = "
.pantry-summary-wrap {
    padding: 15px;
    background: #f1f5f9;
    min-height: 100vh;
    font-family: 'Roboto', 'Segoe UI', Tahoma, sans-serif !important;
}

.summary-meta-banner {
    font-size: 0.85rem;
    color: #475569;
    background: #ffffff;
    border: 1px solid #cbd5e1;
    border-radius: 8px;
    padding: 10px 18px;
    margin-bottom: 20px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}

.stat-card-box {
    background: #ffffff;
    border: 1px solid #cbd5e1;
    border-radius: 8px;
    padding: 14px 18px;
    text-align: center;
    box-shadow: 0 2px 5px rgba(0,0,0,0.04);
}

.stat-val {
    font-size: 1.5rem;
    font-weight: 800;
    color: #0f172a;
}

.stat-label {
    font-size: 0.78rem;
    font-weight: 700;
    color: #64748b;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

@media print {
    .no-print, .main-header, .app-sidebar, .app-footer, .filter-bar {
        display: none !important;
    }
    body, .app-main, .app-content, .pantry-summary-wrap {
        background: #ffffff !important;
        padding: 0 !important;
        margin: 0 !important;
    }
    @page {
        size: A4 portrait;
        margin: 8mm;
    }
}
";

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
    <div class="app-content py-3">
        <div class="container-fluid">

            <!-- Meta Information Banner -->
            <div class="summary-meta-banner no-print d-flex align-items-center justify-content-between flex-wrap gap-2">
                <div>
                    <span class="me-4"><strong>Depot Station:</strong> <span class="text-primary fw-bold"><?= htmlspecialchars($stationName); ?></span></span>
                    <span class="me-4"><strong>Division:</strong> <span class="text-dark fw-bold"><?= htmlspecialchars($divisionName); ?></span></span>
                    <span class="me-4"><strong>Railway Zone:</strong> <span class="text-dark fw-bold"><?= htmlspecialchars($railwayName); ?></span></span>
                    <span><strong>Contractor:</strong> <span class="text-success fw-bold"><?= htmlspecialchars($contractorName); ?></span></span>
                </div>
                <div class="d-flex align-items-center gap-2">
                    <a href="intensive_pantry_scorecard.php" class="btn btn-sm btn-outline-secondary fw-bold">
                        <i class="bi bi-card-checklist me-1"></i> Detailed Scorecard
                    </a>
                </div>
            </div>

            <!-- Month & Year Filter Form -->
            <div class="card shadow-sm border-0 mb-4 bg-white no-print">
                <div class="card-body p-3 col-md-8 mx-auto">
                    <form method="GET" action="intensive_pantry_summary.php" class="row g-3 align-items-center justify-content-center">
                        <div class="col-auto">
                            <label for="month" class="form-label mb-0 fw-bold"><i class="bi bi-calendar3 text-primary me-1"></i> Month:</label>
                        </div>
                        <div class="col-auto">
                            <select name="month" id="month" class="form-select form-select-sm" style="min-width: 130px;">
                                <?php
                                for ($m = 1; $m <= 12; $m++) {
                                    $mStr = str_pad($m, 2, '0', STR_PAD_LEFT);
                                    $selected = ($mStr === $selectedMonth) ? 'selected' : '';
                                    echo "<option value='$mStr' $selected>" . date('F', mktime(0, 0, 0, $m, 1)) . "</option>";
                                }
                                ?>
                            </select>
                        </div>
                        <div class="col-auto">
                            <label for="year" class="form-label mb-0 fw-bold">Year:</label>
                        </div>
                        <div class="col-auto">
                            <select name="year" id="year" class="form-select form-select-sm" style="min-width: 95px;">
                                <?php
                                $currYear = intval(date('Y'));
                                for ($y = $currYear - 5; $y <= $currYear + 5; $y++) {
                                    $selected = ($y === $selectedYear) ? 'selected' : '';
                                    echo "<option value='$y' $selected>$y</option>";
                                }
                                ?>
                            </select>
                        </div>
                        <div class="col-auto">
                            <button type="submit" class="btn btn-primary btn-sm px-3 fw-bold">
                                <i class="bi bi-funnel-fill me-1"></i> Open Summary
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Summary Overview Statistics -->
            <div class="row g-3 mb-4 no-print">
                <div class="col-md-4">
                    <div class="stat-card-box">
                        <div class="stat-val text-primary"><?= count($sheets); ?></div>
                        <div class="stat-label">Pantry Inspections Done</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card-box">
                        <div class="stat-val text-success"><?= number_format($averageMonthlyScore, 2); ?>%</div>
                        <div class="stat-label">Monthly Average Score</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card-box">
                        <div class="stat-val text-info"><?= $totalCoachesCleaned; ?></div>
                        <div class="stat-label">Pantry Coaches Inspected</div>
                    </div>
                </div>
            </div>

            <!-- Main Monthly Summary Table Card -->
            <div class="card border-0 bg-white shadow-sm" style="border-radius: 10px; overflow: hidden; border: 1.5px solid #000000;">
                <div class="card-header bg-white py-3 border-bottom d-flex align-items-center justify-content-between flex-wrap gap-2">
                    <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center" style="font-size: 1.1rem;">
                        <i class="bi bi-cup-hot-fill text-primary me-2"></i>
                        Pantry Car Intensive Cleaning Monthly Summary: <?= date('F Y', strtotime($startDate)); ?>
                    </h5>
                    <div class="d-flex align-items-center gap-3">
                        <span class="badge bg-success-subtle text-success p-2 px-3 border border-success-subtle rounded-pill font-weight-bold" style="font-size: 0.95rem;">
                            Monthly Average: <?= number_format($averageMonthlyScore, 2); ?>%
                        </span>
                        <button class="btn btn-dark btn-sm fw-bold no-print px-3" onclick="window.print()">
                            <i class="bi bi-printer me-1"></i> Print Summary
                        </button>
                    </div>
                </div>

                <div class="card-body p-0 table-responsive">
                    <table class="table table-bordered table-hover align-middle mb-0" style="font-size: 0.88rem;">
                        <thead style="background: #1987C6; color: #ffffff;" class="text-center align-middle">
                            <tr>
                                <th style="width: 50px;">#</th>
                                <th style="width: 110px;">Date</th>
                                <th style="width: 100px;">Train No.</th>
                                <th style="width: 160px;">Token ID</th>
                                <th>Pantry Coach No.(s)</th>
                                <th>Supervisor</th>
                                <th style="width: 140px;">Marks Obtained</th>
                                <th style="width: 100px;">Score (%)</th>
                                <th style="width: 130px;" class="no-print">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if (empty($sheets)): ?>
                                <tr>
                                    <td colspan="9" class="text-center py-4 text-muted">
                                        <i class="bi bi-info-circle me-1"></i> No pantry car intensive scorecard inspections found for <?= date('F Y', strtotime($startDate)); ?>.
                                    </td>
                                </tr>
                            <?php else: ?>
                                <?php 
                                $sn = 1;
                                foreach ($sheets as $s):
                                    $scoreColor = $s['percentage'] >= 90 ? 'text-success' : ($s['percentage'] >= 75 ? 'text-primary' : 'text-danger');
                                ?>
                                    <tr>
                                        <td class="text-center font-weight-bold"><?= $sn++; ?></td>
                                        <td class="text-center font-weight-bold"><?= date('d-m-Y', strtotime($s['report_date'])); ?></td>
                                        <td class="text-center font-weight-bold text-primary"><?= htmlspecialchars($s['train_no']); ?></td>
                                        <td class="text-center"><span class="badge bg-light text-dark border"><?= htmlspecialchars($s['token_id']); ?></span></td>
                                        <td class="font-weight-bold"><?= htmlspecialchars($s['coaches']); ?></td>
                                        <td><?= htmlspecialchars($s['supervisor_name']); ?></td>
                                        <td class="text-center font-weight-bold"><?= number_format($s['obtained'], 1) ?> / <?= $s['possible'] ?></td>
                                        <td class="text-center font-weight-bold <?= $scoreColor ?>" style="font-size: 0.95rem;"><?= number_format($s['percentage'], 2) ?>%</td>
                                        <td class="text-center no-print">
                                            <a href="intensive_pantry_scorecard.php?from_date=<?= $s['report_date'] ?>&to_date=<?= $s['report_date'] ?>&train_no=<?= urlencode($s['train_no']) ?>" class="btn btn-xs btn-outline-primary fw-bold py-1 px-2" style="font-size: 0.78rem;">
                                                <i class="bi bi-eye-fill me-1"></i> View Sheet
                                            </a>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            <?php endif; ?>
                        </tbody>
                        <tfoot class="table-light">
                            <tr class="font-weight-bold">
                                <td colspan="6" class="text-end">Overall Monthly Average Score:</td>
                                <td colspan="3" class="text-success font-weight-bold fs-6">
                                    <?= number_format($averageMonthlyScore, 2); ?>%
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

        </div>
    </div>
</main>

<?php include 'footer.php'; ?>
