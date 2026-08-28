<?php
/**
 * CDO Dashboard - Monthly Summary for Intensive Cleaning of Pantry Car
 * Aggregated by Date (Overall Daily Score Percentage)
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

// Fetch distinct report dates in selected month from mcc_intensive_pantry_report
$datesStmt = $pdo->prepare("
    SELECT DISTINCT report_date 
    FROM mcc_intensive_pantry_report 
    WHERE station_id = :station_id AND report_date BETWEEN :start_date AND :end_date 
    ORDER BY report_date ASC
");
$datesStmt->execute([
    'station_id' => $stationId,
    'start_date' => $startDate,
    'end_date'   => $endDate
]);
$activeDates = $datesStmt->fetchAll(PDO::FETCH_COLUMN);

$scoresStmt = $pdo->prepare("
    SELECT sub_parameter_id, coach_no, score_value, token_id
    FROM mcc_intensive_pantry_report
    WHERE station_id = :station_id AND report_date = :report_date
");

$dailyRows = [];
$totalMonthlyObtained = 0.0;
$totalMonthlyPossible = 0;
$totalMonthlyInspections = 0;

foreach ($activeDates as $rDate) {
    $scoresStmt->execute([
        'station_id'  => $stationId,
        'report_date' => $rDate
    ]);
    $entries = $scoresStmt->fetchAll();

    $tokensOnDate = [];
    $dateObtained = 0.0;
    $datePossible = 0;

    foreach ($entries as $sc) {
        if (!empty($sc['token_id']) && !in_array($sc['token_id'], $tokensOnDate)) {
            $tokensOnDate[] = $sc['token_id'];
        }

        $val = $sc['score_value'];
        if (is_numeric($val)) {
            $dateObtained += floatval($val);
            $datePossible += 3;
        } else {
            $v = strtolower(trim((string)$val));
            if ($v === '3' || $v === 'vg' || $v === 'very good') { $dateObtained += 3; $datePossible += 3; }
            elseif ($v === '2' || $v === 'sat' || $v === 'satisfactory' || $v === 'good') { $dateObtained += 2; $datePossible += 3; }
            elseif ($v === '1' || $v === 'poor') { $dateObtained += 1; $datePossible += 3; }
            elseif ($v === '0' || $v === 'not attended') { $dateObtained += 0; $datePossible += 3; }
        }
    }

    $inspectionCount = count($tokensOnDate);
    if ($inspectionCount === 0) {
        $inspectionCount = 1;
    }

    $datePct = $datePossible > 0 ? round(($dateObtained / $datePossible) * 100, 2) : 0;

    $dailyRows[] = [
        'date'             => $rDate,
        'inspection_count' => $inspectionCount,
        'obtained'         => round($dateObtained, 1),
        'possible'         => $datePossible,
        'percentage'       => $datePct
    ];

    $totalMonthlyObtained += $dateObtained;
    $totalMonthlyPossible += $datePossible;
    $totalMonthlyInspections += $inspectionCount;
}

$averageMonthlyScore = $totalMonthlyPossible > 0 ? round(($totalMonthlyObtained / $totalMonthlyPossible) * 100, 2) : 0.0;

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
                        <div class="stat-val text-primary"><?= count($dailyRows); ?></div>
                        <div class="stat-label">Inspected Days</div>
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
                        <div class="stat-val text-info"><?= $totalMonthlyInspections; ?></div>
                        <div class="stat-label">Total Pantry Inspections</div>
                    </div>
                </div>
            </div>

            <!-- Main Monthly Summary Table Card -->
            <div class="card border-0 bg-white shadow-sm" style="border-radius: 10px; overflow: hidden; border: 1.5px solid #000000;">
                <div class="card-header bg-white py-3 border-bottom d-flex align-items-center justify-content-between flex-wrap gap-2">
                    <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center" style="font-size: 1.1rem;">
                        <i class="bi bi-cup-hot-fill text-primary me-2"></i>
                        Pantry Car Intensive Cleaning Daily Summary: <?= date('F Y', strtotime($startDate)); ?>
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
                    <table class="table table-bordered table-hover align-middle mb-0" style="font-size: 0.92rem;">
                        <thead style="background: #1987C6; color: #ffffff;" class="text-center align-middle">
                            <tr>
                                <th style="width: 60px;">#</th>
                                <th style="width: 140px;">Date</th>
                                <th style="width: 180px;">Total Inspections</th>
                                <th>Marks Obtained / Eligible</th>
                                <th style="width: 180px;">Overall Day Score (%)</th>
                                <th style="width: 160px;" class="no-print">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if (empty($dailyRows)): ?>
                                <tr>
                                    <td colspan="6" class="text-center py-4 text-muted">
                                        <i class="bi bi-info-circle me-1"></i> No pantry car intensive scorecard inspections found for <?= date('F Y', strtotime($startDate)); ?>.
                                    </td>
                                </tr>
                            <?php else: ?>
                                <?php 
                                $sn = 1;
                                foreach ($dailyRows as $r):
                                    $scoreColor = $r['percentage'] >= 90 ? 'text-success' : ($r['percentage'] >= 75 ? 'text-primary' : 'text-danger');
                                ?>
                                    <tr>
                                        <td class="text-center font-weight-bold"><?= $sn++; ?></td>
                                        <td class="text-center font-weight-bold"><?= date('d-m-Y', strtotime($r['date'])); ?></td>
                                        <td class="text-center font-weight-bold text-primary"><?= $r['inspection_count']; ?> Inspection<?= $r['inspection_count'] > 1 ? 's' : '' ?></td>
                                        <td class="text-center font-weight-bold"><?= number_format($r['obtained'], 1) ?> / <?= $r['possible'] ?></td>
                                        <td class="text-center font-weight-bold <?= $scoreColor ?>" style="font-size: 1rem;"><?= number_format($r['percentage'], 2) ?>%</td>
                                        <td class="text-center no-print">
                                            <a href="intensive_pantry_scorecard.php?from_date=<?= $r['date'] ?>&to_date=<?= $r['date'] ?>" class="btn btn-sm btn-outline-primary fw-bold py-1 px-3" style="font-size: 0.8rem;">
                                                <i class="bi bi-eye-fill me-1"></i> View Scorecards
                                            </a>
                                        </td>
                                    </tr>
                                <?php endforeach; ?>
                            <?php endif; ?>
                        </tbody>
                        <tfoot class="table-light">
                            <tr class="font-weight-bold fs-6">
                                <td colspan="4" class="text-end">Overall Monthly Average Score:</td>
                                <td colspan="2" class="text-success font-weight-bold">
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
