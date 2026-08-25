<?php
require_once 'auth.php';

// Target month & year selection
$selectedMonth = $_GET['month'] ?? date('m');
$selectedYear = $_GET['year'] ?? date('Y');

$selectedMonth = str_pad($selectedMonth, 2, '0', STR_PAD_LEFT);
$selectedYear = intval($selectedYear);

$targetMonthDate = $selectedYear . "-" . $selectedMonth . "-01";
$daysInMonth = cal_days_in_month(CAL_GREGORIAN, intval($selectedMonth), $selectedYear);

$successMsg = '';
$errorMsg = '';

// Handle save post request
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['save_cleanliness'])) {
    $selectedMonth = $_POST['month'] ?? '';
    $selectedYear = $_POST['year'] ?? '';
    if (!empty($selectedMonth) && !empty($selectedYear)) {
        $selectedMonth = str_pad($selectedMonth, 2, '0', STR_PAD_LEFT);
        $selectedYear = intval($selectedYear);
        $daysInMonth = cal_days_in_month(CAL_GREGORIAN, intval($selectedMonth), $selectedYear);
        
        $scores = $_POST['score'] ?? [];
        
        $pdo->beginTransaction();
        try {
            $saveStmt = $pdo->prepare("
                INSERT INTO mcc_cleanliness_report (station_id, report_date, score)
                VALUES (:station_id, :report_date, :score)
                ON DUPLICATE KEY UPDATE score = VALUES(score)
            ");
            
            for ($day = 1; $day <= $daysInMonth; $day++) {
                $dateIso = sprintf('%04d-%02d-%02d', $selectedYear, $selectedMonth, $day);
                $score = isset($scores[$day]) && $scores[$day] !== '' ? floatval($scores[$day]) : 0.00;
                
                $saveStmt->execute([
                    'station_id' => $stationId,
                    'report_date' => $dateIso,
                    'score' => $score
                ]);
            }
            $pdo->commit();
            $successMsg = "Daily cleanliness scores for " . date('F, Y', strtotime($selectedYear . '-' . $selectedMonth . '-01')) . " saved successfully!";
        } catch (Exception $e) {
            $pdo->rollBack();
            $errorMsg = "Error saving cleanliness scores: " . $e->getMessage();
        }
    }
}

// Fetch existing cleanliness reports for that month and station
$reportsStmt = $pdo->prepare("
    SELECT report_date, score
    FROM mcc_cleanliness_report
    WHERE station_id = :station_id AND report_date BETWEEN :start_date AND :end_date
");
$reportsStmt->execute([
    'station_id' => $stationId,
    'start_date' => $selectedYear . '-' . $selectedMonth . '-01',
    'end_date' => $selectedYear . '-' . $selectedMonth . '-' . $daysInMonth
]);
$existingReports = $reportsStmt->fetchAll();

$reportsByDay = [];
$totalMonthlyScore = 0.00;
$submittedDaysCount = 0;

foreach ($existingReports as $rep) {
    $day = intval(date('d', strtotime($rep['report_date'])));
    $reportsByDay[$day] = [
        'score' => $rep['score']
    ];
    if (isset($rep['score']) && $rep['score'] !== null) {
        $totalMonthlyScore += floatval($rep['score']);
        $submittedDaysCount++;
    }
}
$averageMonthlyScore = $submittedDaysCount > 0 ? ($totalMonthlyScore / $submittedDaysCount) : 0.00;

$pageTitle = 'MCC | Daily Cleanliness Scorecard';

$extraStyles = "
.cleanliness-sheet {
    background: #ffffff !important;
    border: 1px solid #cbd5e1 !important;
    padding: 20px !important;
    width: 100% !important;
    margin: 10px auto 30px auto !important;
    border-radius: 12px !important;
    box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05), 0 2px 4px -1px rgba(0,0,0,0.03) !important;
}
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

      <!-- Messages -->
      <?php if (!empty($successMsg)): ?>
        <div class="alert alert-success alert-dismissible fade show rounded-3 shadow-sm mb-4" role="alert">
          <i class="bi bi-check-circle-fill me-2"></i>
          <?= htmlspecialchars($successMsg); ?>
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      <?php endif; ?>

      <?php if (!empty($errorMsg)): ?>
        <div class="alert alert-danger alert-dismissible fade show rounded-3 shadow-sm mb-4" role="alert">
          <i class="bi bi-exclamation-triangle-fill me-2"></i>
          <?= htmlspecialchars($errorMsg); ?>
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      <?php endif; ?>

      <!-- Month Filter -->
      <div class="card shadow-sm border-0 mb-4 bg-white no-print">
        <div class="card-body p-3 col-md-8 mx-auto">
          <form method="GET" action="cleanliness.php" class="row g-3 align-items-center justify-content-center">
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
              <button type="submit" class="btn btn-primary btn-sm px-3 fw-bold">Open Sheet</button>
            </div>
          </form>
        </div>
      </div>

      <!-- Scorecard Entry Sheet -->
      <div class="card cleanliness-sheet border-0 bg-white">
        <div class="card-header bg-white py-3 border-bottom d-flex align-items-center justify-content-between flex-wrap gap-2">
          <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
            <i class="bi bi-calendar-range text-primary me-2"></i>
            Daily Cleanliness Scorecard: <?= date('F Y', strtotime($targetMonthDate)); ?>
          </h5>
          <div class="d-flex align-items-center gap-3">
            <span class="badge bg-indigo-subtle text-indigo p-2 px-3 border border-indigo-subtle rounded-pill font-weight-bold" style="font-size: 0.9rem;">
              Monthly Average Score: <?= number_format($averageMonthlyScore, 2); ?>%
            </span>
            <button class="btn btn-outline-primary btn-sm fw-bold no-print px-3" onclick="window.print()"><i class="bi bi-printer me-1"></i> Print Sheet</button>
          </div>
        </div>
        <div class="card-body p-0 mt-3">
          <form method="POST" action="cleanliness.php?month=<?= $selectedMonth; ?>&year=<?= $selectedYear; ?>">
            <input type="hidden" name="month" value="<?= $selectedMonth; ?>">
            <input type="hidden" name="year" value="<?= $selectedYear; ?>">
            
            <div class="table-responsive">
              <table class="table table-hover table-bordered table-sm align-middle mb-0">
                <thead class="table-light">
                  <tr class="text-center">
                    <th style="width: 10%;">S.No</th>
                    <th style="width: 45%;">Date</th>
                    <th style="width: 45%;">Daily Score (0.00 - 100.00)</th>
                  </tr>
                </thead>
                <tbody>
                  <?php for ($day = 1; $day <= $daysInMonth; $day++): ?>
                    <?php 
                    $dateObj = new DateTime(sprintf('%04d-%02d-%02d', $selectedYear, $selectedMonth, $day));
                    $formattedDate = $dateObj->format('d-m-Y (D)');
                    $existingScore = isset($reportsByDay[$day]['score']) ? floatval($reportsByDay[$day]['score']) : '';
                    
                    // highlight weekend
                    $isWeekend = ($dateObj->format('N') >= 6);
                    $bgClass = $isWeekend ? 'table-warning-subtle' : '';
                    ?>
                    <tr class="<?= $bgClass; ?>">
                      <td class="text-center fw-bold"><?= $day; ?></td>
                      <td class="text-center"><?= $formattedDate; ?></td>
                      <td>
                        <div class="input-group input-group-sm mx-auto" style="max-width: 130px;">
                          <input type="number" name="score[<?= $day; ?>]" step="0.01" min="0" max="100" class="form-control text-center fw-bold text-primary" value="<?= ($existingScore !== '') ? number_format($existingScore, 2) : '90.00'; ?>" required>
                          <span class="input-group-text">%</span>
                        </div>
                      </td>
                    </tr>
                  <?php endfor; ?>
                </tbody>
              </table>
            </div>

            <div class="text-end mt-4 p-3 border-top no-print">
              <button type="submit" name="save_cleanliness" class="btn btn-success px-4 py-2.5 fw-bold rounded-pill shadow-sm">
                Save Cleanliness Sheet &nbsp;<i class="bi bi-save"></i>
              </button>
            </div>
          </form>
        </div>
      </div>

    </div>
  </div>
</main>

<?php
include 'footer.php';
?>
