<?php
require_once 'auth.php';

$pageTitle = 'Biometric Manpower Log | CDO';
$extraStyles = "";

// Date Filtering (Default to today)
$selectedFromDate = isset($_GET['from_date']) && !empty($_GET['from_date']) ? $_GET['from_date'] : date('Y-m-d');
$selectedToDate = isset($_GET['to_date']) && !empty($_GET['to_date']) ? $_GET['to_date'] : $selectedFromDate;

// Validate date formats
if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $selectedFromDate)) {
    $selectedFromDate = date('Y-m-d');
}
if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $selectedToDate)) {
    $selectedToDate = $selectedFromDate;
}
if ($selectedToDate < $selectedFromDate) {
    $selectedToDate = $selectedFromDate;
}

// Window query range to include Shift 3 punches that spill into next day 6:00 AM
$startQueryTime = $selectedFromDate . ' 06:00:00';
$endQueryTime = date('Y-m-d 06:00:00', strtotime($selectedToDate . ' +1 day'));

// Fetch punches from attendance_logs
$logsStmt = $pdo->prepare("
    SELECT 
        id,
        employee_code,
        employee_name,
        punch_time,
        direction,
        device_id,
        device_name
    FROM attendance_logs
    WHERE punch_time >= :start_time AND punch_time <= :end_time
    ORDER BY punch_time ASC
");
$logsStmt->execute([
    'start_time' => $startQueryTime,
    'end_time' => $endQueryTime
]);
$rawLogs = $logsStmt->fetchAll(PDO::FETCH_ASSOC);

/**
 * Classify punches by:
 * - Category: 'depot', 'prt', or 'vb' (Vande Bharat)
 * - Cycle Date: The date the shift belongs to
 * - Shift: 1 (06:00-14:00), 2 (14:00-22:00), 3 (22:00-06:00+1)
 * - Employee Code
 */
$depotRecords = [];
$prtRecords = [];
$vbRecords = [];

foreach ($rawLogs as $log) {
    $punchTs = strtotime($log['punch_time']);
    $timeStr = date('H:i:s', $punchTs);
    $punchDate = date('Y-m-d', $punchTs);

    // Determine Shift & Cycle Date
    if ($timeStr >= '06:00:00' && $timeStr < '14:00:00') {
        $shift = 1;
        $cycleDate = $punchDate;
    } elseif ($timeStr >= '14:00:00' && $timeStr < '22:00:00') {
        $shift = 2;
        $cycleDate = $punchDate;
    } elseif ($timeStr >= '22:00:00') {
        $shift = 3;
        $cycleDate = $punchDate;
    } else {
        // Punches between 00:00:00 and 05:59:59 belong to previous day's Shift 3
        $shift = 3;
        $cycleDate = date('Y-m-d', strtotime($punchDate . ' -1 day'));
    }

    // Only include if cycle date is within selected from_date and to_date
    if ($cycleDate < $selectedFromDate || $cycleDate > $selectedToDate) {
        continue;
    }

    $empCode = trim($log['employee_code']);
    $empName = !empty($log['employee_name']) ? trim($log['employee_name']) : $empCode;
    $devName = strtolower(trim((string)$log['device_name']));

    // Determine Category: 'depot' or 'prt'
    if (strpos($devName, 'coaching') !== false || strpos($devName, 'depot') !== false) {
        $category = 'depot';
    } else {
        $category = 'prt';
    }

    $groupKey = $cycleDate . '_' . $shift . '_' . $empCode;

    if ($category === 'depot') {
        if (!isset($depotRecords[$groupKey])) {
            $depotRecords[$groupKey] = [
                'cycle_date' => $cycleDate,
                'shift' => $shift,
                'employee_code' => $empCode,
                'employee_name' => $empName,
                'punches' => []
            ];
        }
        $depotRecords[$groupKey]['punches'][] = [
            'time' => $log['punch_time'],
            'direction' => $log['direction']
        ];
    } else {
        if (!isset($prtRecords[$groupKey])) {
            $prtRecords[$groupKey] = [
                'cycle_date' => $cycleDate,
                'shift' => $shift,
                'employee_code' => $empCode,
                'employee_name' => $empName,
                'punches' => []
            ];
        }
        $prtRecords[$groupKey]['punches'][] = [
            'time' => $log['punch_time'],
            'direction' => $log['direction']
        ];
    }
}

/**
 * Helper to process punches into summary rows
 */
function processShiftRecords($records) {
    $rows = [];
    $distinctEmployees = [];

    foreach ($records as $item) {
        $punches = $item['punches'];
        usort($punches, function($a, $b) {
            return strtotime($a['time']) - strtotime($b['time']);
        });

        $firstPunch = $punches[0]['time'];
        $lastPunch = count($punches) > 1 ? $punches[count($punches) - 1]['time'] : null;

        // Check if explicit IN (0) / OUT (1) punches exist
        $inPunch = null;
        $outPunch = null;
        foreach ($punches as $p) {
            if ($p['direction'] === '0' && $inPunch === null) {
                $inPunch = $p['time'];
            }
            if ($p['direction'] === '1') {
                $outPunch = $p['time'];
            }
        }

        $loginTime = $inPunch ?: $firstPunch;
        $logoutTime = $outPunch ?: ($lastPunch !== $firstPunch ? $lastPunch : null);

        $loginDisplay = date('H:i:s', strtotime($loginTime));
        $logoutDisplay = $logoutTime ? date('H:i:s', strtotime($logoutTime)) : '-';
        $loginDateDisplay = date('d-m-Y', strtotime($loginTime));

        $diffSeconds = 0;
        // Calculate total shift hours
        if ($logoutTime && strtotime($logoutTime) > strtotime($loginTime)) {
            $diffSeconds = strtotime($logoutTime) - strtotime($loginTime);
            $hours = floor($diffSeconds / 3600);
            $mins = floor(($diffSeconds % 3600) / 60);
            $secs = $diffSeconds % 60;
            $durationStr = sprintf('%02d:%02d:%02d', $hours, $mins, $secs);
        } else {
            $durationStr = '-';
        }

        $distinctEmployees[$item['employee_code']] = true;

        $rows[] = [
            'cycle_date' => $item['cycle_date'],
            'date_display' => $loginDateDisplay,
            'shift' => $item['shift'],
            'employee_code' => $item['employee_code'],
            'employee_name' => $item['employee_name'],
            'login' => $loginDisplay,
            'logout' => $logoutDisplay,
            'hours' => $durationStr,
            'diff_seconds' => $diffSeconds,
            'login_ts' => strtotime($loginTime)
        ];
    }

    // Sort by shift ASC, then login time ASC
    usort($rows, function($a, $b) {
        if ($a['shift'] !== $b['shift']) {
            return $a['shift'] - $b['shift'];
        }
        return $a['login_ts'] - $b['login_ts'];
    });

    return [
        'rows' => $rows,
        'total_present' => count($distinctEmployees)
    ];
}

$depotData = processShiftRecords($depotRecords);
$allPrtProcessed = processShiftRecords($prtRecords);

// Vande Bharat: PRT attendance with total shift duration between 45 mins (2700s) and 1 hr 15 mins (4500s)
$vbRows = array_values(array_filter($allPrtProcessed['rows'], function($r) {
    return $r['diff_seconds'] >= 2700 && $r['diff_seconds'] <= 4500;
}));
$vbDistinct = [];
foreach ($vbRows as $r) {
    $vbDistinct[$r['employee_code']] = true;
}
$vbData = [
    'rows' => $vbRows,
    'total_present' => count($vbDistinct)
];

// Platform Return Trains: PRT attendance outside the 45m - 1h 15m window
$prtRows = array_values(array_filter($allPrtProcessed['rows'], function($r) {
    return !($r['diff_seconds'] >= 2700 && $r['diff_seconds'] <= 4500);
}));
$prtDistinct = [];
foreach ($prtRows as $r) {
    $prtDistinct[$r['employee_code']] = true;
}
$prtData = [
    'rows' => $prtRows,
    'total_present' => count($prtDistinct)
];

$targetManpower = 25; // Target per category
$shiftLabels = [
    1 => 'Shift 1 (06:00 - 14:00)',
    2 => 'Shift 2 (14:00 - 22:00)',
    3 => 'Shift 3 (22:00 - 06:00 Day 2)'
];

// Build list of dates in selected range
$datesInRange = [];
$curTs = strtotime($selectedFromDate);
$endTs = strtotime($selectedToDate);
while ($curTs <= $endTs) {
    $datesInRange[] = date('Y-m-d', $curTs);
    $curTs = strtotime('+1 day', $curTs);
}

/**
 * Render individual report cards (sheets) per date
 */
function renderReportSheets($datesInRange, $dataRows, $reportTitle, $railwayName, $divisionName, $stationName, $contractorName, $targetManpower, $shiftLabels, $emptyCategoryName) {
    foreach ($datesInRange as $sheetDate) {
        $sheetDateDisplay = date('d-m-Y', strtotime($sheetDate));
        $sheetRows = array_filter($dataRows, function($r) use ($sheetDate) {
            return $r['cycle_date'] === $sheetDate;
        });
        $sheetEmployees = [];
        foreach ($sheetRows as $sr) {
            $sheetEmployees[$sr['employee_code']] = true;
        }
        $sheetPresent = count($sheetEmployees);
        ?>
        <div class="report-card">
          <div class="report-title"><?= htmlspecialchars($reportTitle) ?></div>
          <div class="meta-grid">
            <div class="meta"><strong>Railway:</strong> <?= htmlspecialchars($railwayName) ?></div>
            <div class="meta"><strong>Date:</strong> <?= $sheetDateDisplay ?></div>
            <div class="meta"><strong>Division:</strong> <?= htmlspecialchars($divisionName) ?></div>
            <div class="meta"><strong>Coaching Depot:</strong> <?= htmlspecialchars($stationName) ?></div>
            <div class="meta" style="grid-column:span 2"><strong>Contractor Name:</strong> <?= htmlspecialchars($contractorName) ?></div>
            <div class="meta"><strong>Target Manpower:</strong> <?= $targetManpower ?></div>
            <div class="meta"><strong>Total Present:</strong> <?= $sheetPresent ?></div>
          </div>
          <div class="table-wrap">
            <table>
              <thead>
                <tr>
                  <th>S.No</th>
                  <th>Employee Name</th>
                  <th>Employee ID</th>
                  <th>Date</th>
                  <th>Login Time</th>
                  <th>Logout Time</th>
                  <th>Total Shift Hours</th>
                </tr>
              </thead>
              <tbody>
                <?php if (empty($sheetRows)): ?>
                  <tr><td colspan="7" class="empty-data-row">No attendance records found for <?= htmlspecialchars($emptyCategoryName) ?> on <?= $sheetDateDisplay ?>.</td></tr>
                <?php else: ?>
                  <?php 
                  $serial = 1;
                  for ($s = 1; $s <= 3; $s++): 
                      $shiftRows = array_filter($sheetRows, function($r) use ($s) { return $r['shift'] === $s; });
                  ?>
                    <tr class="shift-row">
                      <td colspan="7"><?= $shiftLabels[$s] ?> &mdash; (<?= count($shiftRows) ?> Present)</td>
                    </tr>
                    <?php if (empty($shiftRows)): ?>
                      <tr><td colspan="7" style="color:#888; font-style:italic;">No records for Shift <?= $s ?></td></tr>
                    <?php else: ?>
                      <?php foreach ($shiftRows as $row): ?>
                        <tr>
                          <td><?= $serial++ ?></td>
                          <td class="name"><?= htmlspecialchars($row['employee_name']) ?></td>
                          <td><?= htmlspecialchars($row['employee_code']) ?></td>
                          <td><?= htmlspecialchars($row['date_display']) ?></td>
                          <td><?= htmlspecialchars($row['login']) ?></td>
                          <td><?= htmlspecialchars($row['logout']) ?></td>
                          <td><?= htmlspecialchars($row['hours']) ?></td>
                        </tr>
                      <?php endforeach; ?>
                    <?php endif; ?>
                  <?php endfor; ?>
                <?php endif; ?>
              </tbody>
            </table>
          </div>
        </div>
        <?php
    }
}
?>

<?php include 'header.php'; ?>
<?php include 'sidebar.php'; ?>

<style>
.page{padding:20px 20px 14px}
.toolbar{display:flex;align-items:center;gap:10px;flex-wrap:nowrap;overflow-x:auto;background:#fff;border:1px solid #dce2e7;border-radius:11px;padding:12px 16px;box-shadow:0 3px 12px rgba(0,0,0,.15);margin-bottom:28px}
.toolbar label{font-weight:700;font-size:14px}
.datebox{height:38px;width:175px;border:1.5px solid #0d5584;border-radius:3px;padding:0 12px;font-weight:700;background:#fff}
.btn{height:38px;border:none;border-radius:7px;padding:0 16px;color:#fff;font-weight:700;cursor:pointer;box-shadow:0 2px 5px rgba(0,0,0,.12);display:inline-flex;align-items:center;justify-content:center;text-decoration:none;white-space:nowrap;flex-shrink:0}
.btn.cyan{background:#14aee8}.btn.dark{background:#053151}.btn.blue{background:#188fc4;border:1px solid #0c638f}
.report-shell{background:#eee;border:1px solid #b9b9b9;padding:12px 10px 14px;min-height:680px}
.tabs{display:flex;gap:2px;margin:0 0 16px;padding:0 2px}
.tab-btn{border:1px solid #0c527d;background:#eaf2f8;color:#0b3551;padding:12px 18px;font-weight:800;cursor:pointer;border-radius:8px 8px 0 0;font-size:14px;white-space:nowrap}
.tab-btn.active{background:#062f50;color:#fff;border-color:#062f50}
.report-card{background:#fff;border:1px solid #c7c7c7;padding:14px 10px 0;margin-bottom:25px;border-radius:6px}
.report-card:last-child{margin-bottom:0}
.report-title{text-align:center;font-size:23px;font-weight:800;margin:4px 0 22px}
.meta-grid{display:grid;grid-template-columns:repeat(4,minmax(180px,1fr));gap:13px 28px;max-width:1080px;margin:0 auto 18px;font-size:13px}
.meta{display:flex;justify-content:center;gap:5px;white-space:nowrap}.meta strong{font-weight:800}
.table-wrap{overflow:auto;border:1px solid #111;margin-bottom:15px}table{width:100%;border-collapse:collapse;min-width:960px;background:#fff}thead th{background:#062e4e;color:#fff;font-size:13px;padding:12px 10px;border:1px solid #245474;text-align:center}tbody td{font-size:13px;padding:9px 10px;border:1px solid #c8c8c8;text-align:center}tbody td.name{text-align:left;font-weight:700}.shift-row td{background:#e8f2fb;color:#073957;font-weight:800;text-align:left;padding:8px 11px;border-color:#abc6d9}.report-panel{display:none}.report-panel.active{display:block}
.empty-data-row{padding:25px;font-weight:600;color:#666;font-style:italic}
@media(max-width:1100px){.meta-grid{grid-template-columns:repeat(2,minmax(180px,1fr))}.datebox{width:210px}}
@media(max-width:800px){.toolbar{padding:10px;gap:8px}.datebox{width:150px}.meta-grid{grid-template-columns:1fr}}
@media print{
  .app-header,.app-sidebar,.app-footer,.toolbar,.tabs,.no-print{display:none!important}
  .app-main{margin:0!important;padding:0!important}
  .report-shell{border:none;padding:0;background:#fff}
  .report-panel{display:none!important}
  .report-panel.active{display:block!important}
  .report-card{border:none;margin-bottom:20px;page-break-inside:avoid;page-break-after:always;break-after:page}
  .report-card:last-child{page-break-after:avoid;break-after:avoid;margin-bottom:0}
  .table-wrap{border:1px solid #000}
}
</style>

<main class="app-main">
  <div class="app-content">
    <div class="container-fluid">
      <section class="page">
        <!-- Filter Toolbar -->
        <form method="GET" action="biometeric_manpower_log.php" class="toolbar no-print">
          <label for="fromDate">From:</label>
          <input id="fromDate" name="from_date" class="datebox" type="date" value="<?= htmlspecialchars($selectedFromDate) ?>" required>
          
          <label for="toDate">To:</label>
          <input id="toDate" name="to_date" class="datebox" type="date" value="<?= htmlspecialchars($selectedToDate) ?>" required>
          
          <button type="submit" class="btn cyan">Go</button>
          <button type="button" class="btn dark" onclick="window.print()">Print</button>
          <a class="btn blue" href="biometric-target.php">Manpower Target</a>
          <!-- <a class="btn blue" href="biometric-penalty.php">Manpower Penalty</a>
          <a class="btn blue" href="biometric-summary.php">Summary</a> -->
        </form>

        <div class="report-shell">
          <!-- Navigation Tabs -->
          <div class="tabs no-print">
            <button class="tab-btn active" data-tab="depot">Manpower Report for Coaching Depot</button>
            <button class="tab-btn" data-tab="prt">Manpower Report for Platform Return Trains</button>
            <button class="tab-btn" data-tab="vb">Manpower Report for Vande Bharat</button>
          </div>

          <!-- Depot Panel -->
          <section id="depot" class="report-panel active">
            <?php renderReportSheets($datesInRange, $depotData['rows'], 'Manpower Report for Coaching Depot', $railwayName, $divisionName, $stationName, $contractorName, $targetManpower, $shiftLabels, 'Coaching Depot'); ?>
          </section>

          <!-- PRT Panel -->
          <section id="prt" class="report-panel">
            <?php renderReportSheets($datesInRange, $prtData['rows'], 'Manpower Report for Platform Return Trains', $railwayName, $divisionName, $stationName, $contractorName, $targetManpower, $shiftLabels, 'Platform Return Trains'); ?>
          </section>

          <!-- Vande Bharat Panel -->
          <section id="vb" class="report-panel">
            <?php renderReportSheets($datesInRange, $vbData['rows'], 'Manpower Report for Vande Bharat', $railwayName, $divisionName, $stationName, $contractorName, $targetManpower, $shiftLabels, 'Vande Bharat'); ?>
          </section>
        </div>
      </section>
    </div>
  </div>
</main>

<script>
// Tab Switching
document.querySelectorAll(".tab-btn").forEach(btn => {
  btn.addEventListener("click", () => {
    document.querySelectorAll(".tab-btn").forEach(b => b.classList.remove("active"));
    document.querySelectorAll(".report-panel").forEach(p => p.classList.remove("active"));
    btn.classList.add("active");
    const targetPanel = document.getElementById(btn.dataset.tab);
    if (targetPanel) {
      targetPanel.classList.add("active");
    }
  });
});
</script>

<?php include 'footer.php'; ?>