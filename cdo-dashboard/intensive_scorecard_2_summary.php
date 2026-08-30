<?php
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

// Fetch distinct tokens in selected month from mcc_intensive_scorecard_2_report
$stmt = $pdo->prepare("
    SELECT DISTINCT token_id, train_no, report_date 
    FROM mcc_intensive_scorecard_2_report 
    WHERE station_id = :station_id AND report_date BETWEEN :start_date AND :end_date 
    ORDER BY report_date ASC, token_id ASC
");
$stmt->execute(['station_id' => $stationId, 'start_date' => $startDate, 'end_date' => $endDate]);
$tokens = $stmt->fetchAll();

$sheets = [];
$scoresStmt = $pdo->prepare("
    SELECT r.sub_parameter_id, r.coach_no, r.score_value, r.submitted_by 
    FROM mcc_intensive_scorecard_2_report r
    WHERE r.station_id = :station_id AND r.token_id = :token_id
");

foreach ($tokens as $t) {
    $tokenId = $t['token_id'];
    $trainNo = $t['train_no'];
    $reportDate = $t['report_date'];

    $scoresStmt->execute(['station_id' => $stationId, 'token_id' => $tokenId]);
    $rows = $scoresStmt->fetchAll();

    $supervisorName = 'prabhunath';
    $totalObtained = 0;
    $totalPossible = 0;

    if (!empty($rows)) {
        if (!empty($rows[0]['submitted_by'])) {
            $supervisorName = $rows[0]['submitted_by'];
        }

        foreach ($rows as $row) {
            $val = $row['score_value'];
            if ($val !== '' && $val !== 'X' && $val !== '-') {
                if (is_numeric($val)) {
                    $totalObtained += intval($val);
                }
                $totalPossible++;
            }
        }
    }

    $avgScore = $totalPossible > 0 ? round(($totalObtained / $totalPossible) * 100, 2) : 0.0;

    $sheets[] = [
        'token_id'        => $tokenId,
        'train_no'        => $trainNo,
        'report_date'     => $reportDate,
        'supervisor_name' => $supervisorName,
        'average_score'   => $avgScore
    ];
}

// Compute Monthly Average Score across all sheets
$averageMonthlyScore = 0.0;
if (count($sheets) > 0) {
    $totalPercent = 0.0;
    foreach ($sheets as $sheet) {
        $totalPercent += $sheet['average_score'];
    }
    $averageMonthlyScore = round($totalPercent / count($sheets), 2);
}

// Group sheets by day
$sheetsByDay = [];
foreach ($sheets as $sheet) {
    $day = intval(date('d', strtotime($sheet['report_date'])));
    $sheetsByDay[$day][] = $sheet;
}

$pageTitle = 'MCC | Monthly Intensive Scorecard 2 Summary';

$extraStyles = "
.table-warning-subtle {
    background-color: #fffbeb !important;
}
";

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
  <div class="app-content py-4">
    <div class="container-fluid">
      
      <!-- Compact Meta Information Banner -->
      <div class="mb-4 text-center no-print" style="font-size: 0.85rem; color: #475569; background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 8px; padding: 8px 16px;">
        <span class="me-4"><strong>Depot Station:</strong> <span class="text-primary fw-bold"><?= htmlspecialchars($stationName); ?></span></span>
        <span class="me-4"><strong>Division Name:</strong> <span class="text-dark fw-bold"><?= htmlspecialchars($divisionName); ?></span></span>
        <span class="me-4"><strong>Railway Zone:</strong> <span class="text-dark fw-bold"><?= htmlspecialchars($railwayName); ?></span></span>
        <span><strong>Contractor Agency:</strong> <span class="text-success fw-bold"><?= htmlspecialchars($contractorName); ?></span></span>
      </div>

      <!-- Month Filter -->
      <div class="card shadow-sm border-0 mb-4 bg-white no-print">
        <div class="card-body p-3 col-md-8 mx-auto">
          <form method="GET" action="intensive_scorecard_2_summary.php" class="row g-3 align-items-center justify-content-center">
            <div class="col-auto">
              <label for="month" class="form-label mb-0 fw-bold">Month:</label>
            </div>
            <div class="col-auto">
              <select name="month" id="month" class="form-select form-select-sm">
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
              <select name="year" id="year" class="form-select form-select-sm" style="min-width: 90px;">
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
              <button type="submit" class="btn btn-primary btn-sm px-3 fw-bold">Open Summary</button>
            </div>
          </form>
        </div>
      </div>

      <!-- Summary Card -->
      <div class="card border-0 bg-white shadow-sm" style="border-radius: 12px; overflow: hidden; border: 1px solid #e2e8f0;">
        <div class="card-header bg-white py-3 border-bottom d-flex align-items-center justify-content-between flex-wrap gap-2">
          <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
            <i class="bi bi-calendar-range text-primary me-2"></i>
            Intensive Scorecard 2 Monthly Summary: <?= date('F Y', strtotime($startDate)); ?>
          </h5>
          <div class="d-flex align-items-center gap-3">
            <span class="badge bg-indigo-subtle text-indigo p-2 px-3 border border-indigo-subtle rounded-pill font-weight-bold" style="font-size: 0.9rem;">
              Monthly Average Score: <?= number_format($averageMonthlyScore, 2); ?>%
            </span>
            <button class="btn btn-outline-primary btn-sm fw-bold no-print px-3" onclick="window.print()"><i class="bi bi-printer me-1"></i> Print</button>
          </div>
        </div>
        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-hover table-bordered table-sm align-middle mb-0">
              <thead class="table-light">
                <tr class="text-center">
                  <th style="width: 10%;">S.No</th>
                  <th style="width: 25%;">Date</th>
                  <th style="width: 45%;">Score Percentage</th>
                  <th style="width: 20%;" class="no-print">Action</th>
                </tr>
              </thead>
              <tbody>
                <?php for ($day = 1; $day <= $daysInMonth; $day++): ?>
                  <?php 
                  $dateObj = new DateTime(sprintf('%04d-%02d-%02d', $selectedYear, $selectedMonth, $day));
                  $formattedDate = $dateObj->format('d-m-Y (D)');
                  $daySheets = $sheetsByDay[$day] ?? [];
                  
                  // highlight weekend
                  $isWeekend = ($dateObj->format('N') >= 6);
                  $bgClass = $isWeekend ? 'table-warning-subtle' : '';
                  ?>
                  <tr class="<?= $bgClass; ?>">
                    <td class="text-center fw-bold"><?= $day; ?></td>
                    <td class="text-center"><?= $formattedDate; ?></td>
                    <td class="text-center">
                      <?php if (empty($daySheets)): ?>
                        <span class="text-muted">-</span>
                      <?php else: ?>
                        <?php foreach ($daySheets as $ds): ?>
                          <div class="mb-1">
                            <span class="badge bg-indigo-subtle text-indigo font-weight-bold"><?= number_format($ds['average_score'], 1); ?>%</span>
                            <?php if (!empty($ds['train_no'])): ?>
                              <small class="text-muted ms-1">(Train: <?= htmlspecialchars($ds['train_no']) ?>)</small>
                            <?php endif; ?>
                          </div>
                        <?php endforeach; ?>
                      <?php endif; ?>
                    </td>
                    <td class="text-center no-print">
                      <?php if (empty($daySheets)): ?>
                        <span class="text-muted">-</span>
                      <?php else: ?>
                        <?php foreach ($daySheets as $ds): ?>
                          <div class="mb-1">
                            <a href="intensive_scorecard_2.php?from_date=<?= $ds['report_date']; ?>&to_date=<?= $ds['report_date']; ?>" class="btn btn-xs btn-outline-primary py-0 px-2 fw-bold" style="font-size: 0.78rem;">
                              <i class="bi bi-eye me-1"></i> View Sheet
                            </a>
                          </div>
                        <?php endforeach; ?>
                      <?php endif; ?>
                    </td>
                  </tr>
                <?php endfor; ?>
              </tbody>
            </table>
          </div>
        </div>
      </div>

    </div>
  </div>
</main>

<?php
include 'footer.php';
?>
