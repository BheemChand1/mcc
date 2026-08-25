<?php
require_once 'auth.php';

// Target month & year selection
$selectedMonth = $_GET['month'] ?? date('m');
$selectedYear = $_GET['year'] ?? date('Y');

// Standardize
$selectedMonth = str_pad($selectedMonth, 2, '0', STR_PAD_LEFT);
$selectedYear = intval($selectedYear);

$startDate = "$selectedYear-$selectedMonth-01";
$endDate = date('Y-m-t', strtotime($startDate));

// Fetch active parameters of category 'pit_office' to get total max marks
$paramsStmt = $pdo->prepare("
    SELECT SUM(max_marks) as max_marks_total 
    FROM mcc_surprise_parameters 
    WHERE category = 'pit_office' AND station_id = :station_id AND status = 'Active'
");
$paramsStmt->execute(['station_id' => $stationId]);
$maxMarksRow = $paramsStmt->fetch();
$maxMarksTotal = intval($maxMarksRow['max_marks_total'] ?? 30);
if ($maxMarksTotal <= 0) {
    $maxMarksTotal = 30; // Fallback
}

// Fetch all report entries in this month
$reportsStmt = $pdo->prepare("
    SELECT r.token_id, r.report_date, u.full_name AS supervisor_name, r.parameter_id, r.value
    FROM mcc_surprise_reports r
    LEFT JOIN mcc_users u ON r.submitted_by = u.user_id
    WHERE r.station_id = :station_id AND r.category = 'pit_office' AND r.report_date BETWEEN :start_date AND :end_date
    ORDER BY r.report_date ASC, r.token_id ASC, r.id ASC
");
$reportsStmt->execute([
    'station_id' => $stationId,
    'start_date' => $startDate,
    'end_date' => $endDate
]);
$reportRows = $reportsStmt->fetchAll();

// Group rows by token_id and report_date to calculate total score for each sheet
$sheets = [];
foreach ($reportRows as $row) {
    $key = $row['token_id'] . '_' . $row['report_date'];
    if (!isset($sheets[$key])) {
        $sheets[$key] = [
            'token_id' => $row['token_id'],
            'report_date' => $row['report_date'],
            'supervisor_name' => $row['supervisor_name'] ?? 'CDO',
            'total_score' => 0
        ];
    }
    $sheets[$key]['total_score'] += intval($row['value']);
}

// Compute percentage for each sheet
foreach ($sheets as $k => $sheet) {
    $sheets[$k]['percentage'] = round(($sheet['total_score'] / $maxMarksTotal) * 100, 1);
}

// Compute Monthly Average Score across all sheets
$averageMonthlyScore = 0.0;
if (count($sheets) > 0) {
    $totalPercent = 0.0;
    foreach ($sheets as $sheet) {
        $totalPercent += $sheet['percentage'];
    }
    $averageMonthlyScore = round($totalPercent / count($sheets), 2);
}

$daysInMonth = cal_days_in_month(CAL_GREGORIAN, intval($selectedMonth), $selectedYear);

// Group sheets by day
$sheetsByDay = [];
foreach ($sheets as $sheet) {
    $day = intval(date('d', strtotime($sheet['report_date'])));
    $sheetsByDay[$day][] = $sheet;
}

$pageTitle = 'MCC | Pit & Office Surprise Visit Monthly Summary';

$extraStyles = "
.table-warning-subtle {
    background-color: #fffbeb !important;
}
";

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
  <!-- Content Body -->
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
          <form method="GET" action="surprise-pit-office-summary.php" class="row g-3 align-items-center justify-content-center">
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

      <!-- Scorecard Entry Sheet -->
      <div class="card border-0 bg-white shadow-sm" style="border-radius: 12px; overflow: hidden; border: 1px solid #e2e8f0;">
        <div class="card-header bg-white py-3 border-bottom d-flex align-items-center justify-content-between flex-wrap gap-2">
          <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
            <i class="bi bi-calendar-range text-primary me-2"></i>
            Pit & Office Surprise Visit Summary: <?= date('F Y', strtotime($startDate)); ?>
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
                  <th style="width: 35%;">Date</th>
                  <th style="width: 35%;">Score Percentage</th>
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
                            <span class="badge bg-light text-dark border me-2">Token: <?= htmlspecialchars($ds['token_id']); ?></span>
                            <span class="badge bg-indigo-subtle text-indigo font-weight-bold"><?= number_format($ds['percentage'], 1); ?>%</span>
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
                            <a href="surprise-pit-office.php?from_date=<?= $ds['report_date']; ?>&to_date=<?= $ds['report_date']; ?>" class="btn btn-xs btn-outline-primary py-0 px-2 fw-bold" style="font-size: 0.78rem;">
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
