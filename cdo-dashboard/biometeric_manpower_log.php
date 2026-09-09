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

    // Determine Category: 'vb', 'prt', or 'depot'
    if (strpos($devName, 'vande') !== false || strpos($devName, 'vb') !== false) {
        $category = 'vb';
    } elseif (strpos($devName, 'prt') !== false || strpos($devName, 'platform') !== false) {
        $category = 'prt';
    } else {
        $category = 'depot';
    }

    $groupKey = $cycleDate . '_' . $shift . '_' . $empCode;

    if ($category === 'vb') {
        if (!isset($vbRecords[$groupKey])) {
            $vbRecords[$groupKey] = [
                'cycle_date' => $cycleDate,
                'shift' => $shift,
                'employee_code' => $empCode,
                'employee_name' => $empName,
                'punches' => []
            ];
        }
        $vbRecords[$groupKey]['punches'][] = [
            'time' => $log['punch_time'],
            'direction' => $log['direction']
        ];
    } elseif ($category === 'prt') {
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
    } else {
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
            'date_display' => date('d-m-Y', strtotime($item['cycle_date'])),
            'shift' => $item['shift'],
            'employee_code' => $item['employee_code'],
            'employee_name' => $item['employee_name'],
            'login' => $loginDisplay,
            'logout' => $logoutDisplay,
            'hours' => $durationStr,
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
$prtData = processShiftRecords($prtRecords);
$vbData = processShiftRecords($vbRecords);

$targetManpower = 25; // Target per category
$shiftLabels = [
    1 => 'Shift 1 (06:00 - 14:00)',
    2 => 'Shift 2 (14:00 - 22:00)',
    3 => 'Shift 3 (22:00 - 06:00 Day 2)'
];
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
.report-card{background:#fff;border:1px solid #c7c7c7;padding:14px 10px 0}
.report-title{text-align:center;font-size:23px;font-weight:800;margin:4px 0 22px}
.meta-grid{display:grid;grid-template-columns:repeat(4,minmax(180px,1fr));gap:13px 28px;max-width:1080px;margin:0 auto 18px;font-size:13px}
.meta{display:flex;justify-content:center;gap:5px;white-space:nowrap}.meta strong{font-weight:800}
.table-wrap{overflow:auto;border:1px solid #111;margin-bottom:15px}table{width:100%;border-collapse:collapse;min-width:960px;background:#fff}thead th{background:#062e4e;color:#fff;font-size:13px;padding:12px 10px;border:1px solid #245474;text-align:center}tbody td{font-size:13px;padding:9px 10px;border:1px solid #c8c8c8;text-align:center}tbody td.name{text-align:left;font-weight:700}.shift-row td{background:#e8f2fb;color:#073957;font-weight:800;text-align:left;padding:8px 11px;border-color:#abc6d9}.report-panel{display:none}.report-panel.active{display:block}
.empty-data-row{padding:25px;font-weight:600;color:#666;font-style:italic}
@media(max-width:1100px){.meta-grid{grid-template-columns:repeat(2,minmax(180px,1fr))}.datebox{width:210px}}
@media(max-width:800px){.toolbar{padding:10px;gap:8px}.datebox{width:150px}.meta-grid{grid-template-columns:1fr}}
@media print{.app-header,.app-sidebar,.app-footer,.toolbar,.tabs,.no-print{display:none!important}.app-main{margin:0!important;padding:0!important}.report-shell{border:none;padding:0;background:#fff}.report-panel{display:none!important}.report-panel.active{display:block!important}.report-card{border:none}.table-wrap{border:1px solid #000}}
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
            <div class="report-card">
              <div class="report-title">Manpower Report for Coaching Depot</div>
              <div class="meta-grid">
                <div class="meta"><strong>Railway:</strong> <?= htmlspecialchars($railwayName) ?></div>
                <div class="meta"><strong>Date:</strong> <?= date('d-m-Y', strtotime($selectedFromDate)) . ($selectedFromDate !== $selectedToDate ? ' to ' . date('d-m-Y', strtotime($selectedToDate)) : '') ?></div>
                <div class="meta"><strong>Division:</strong> <?= htmlspecialchars($divisionName) ?></div>
                <div class="meta"><strong>Coaching Depot:</strong> <?= htmlspecialchars($stationName) ?></div>
                <div class="meta" style="grid-column:span 2"><strong>Contractor Name:</strong> <?= htmlspecialchars($contractorName) ?></div>
                <div class="meta"><strong>Target Manpower:</strong> <?= $targetManpower ?></div>
                <div class="meta"><strong>Total Present:</strong> <?= $depotData['total_present'] ?></div>
              </div>
              <div class="table-wrap">
                <table id="depotTable">
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
                    <?php if (empty($depotData['rows'])): ?>
                      <tr><td colspan="7" class="empty-data-row">No attendance records found for Coaching Depot in selected date range.</td></tr>
                    <?php else: ?>
                      <?php 
                      $depotSerial = 1;
                      for ($s = 1; $s <= 3; $s++): 
                          $shiftRows = array_filter($depotData['rows'], function($r) use ($s) { return $r['shift'] === $s; });
                      ?>
                        <tr class="shift-row">
                          <td colspan="7"><?= $shiftLabels[$s] ?> &mdash; (<?= count($shiftRows) ?> Present)</td>
                        </tr>
                        <?php if (empty($shiftRows)): ?>
                          <tr><td colspan="7" style="color:#888; font-style:italic;">No records for Shift <?= $s ?></td></tr>
                        <?php else: ?>
                          <?php foreach ($shiftRows as $row): ?>
                            <tr>
                              <td><?= $depotSerial++ ?></td>
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
          </section>

          <!-- PRT Panel -->
          <section id="prt" class="report-panel">
            <div class="report-card">
              <div class="report-title">Manpower Report for Platform Return Trains</div>
              <div class="meta-grid">
                <div class="meta"><strong>Railway:</strong> <?= htmlspecialchars($railwayName) ?></div>
                <div class="meta"><strong>Date:</strong> <?= date('d-m-Y', strtotime($selectedFromDate)) . ($selectedFromDate !== $selectedToDate ? ' to ' . date('d-m-Y', strtotime($selectedToDate)) : '') ?></div>
                <div class="meta"><strong>Division:</strong> <?= htmlspecialchars($divisionName) ?></div>
                <div class="meta"><strong>Coaching Depot:</strong> <?= htmlspecialchars($stationName) ?></div>
                <div class="meta" style="grid-column:span 2"><strong>Contractor Name:</strong> <?= htmlspecialchars($contractorName) ?></div>
                <div class="meta"><strong>Target Manpower:</strong> <?= $targetManpower ?></div>
                <div class="meta"><strong>Total Present:</strong> <?= $prtData['total_present'] ?></div>
              </div>
              <div class="table-wrap">
                <table id="prtTable">
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
                    <?php if (empty($prtData['rows'])): ?>
                      <tr><td colspan="7" class="empty-data-row">No attendance records found for Platform Return Trains in selected date range.</td></tr>
                    <?php else: ?>
                      <?php 
                      $prtSerial = 1;
                      for ($s = 1; $s <= 3; $s++): 
                          $shiftRows = array_filter($prtData['rows'], function($r) use ($s) { return $r['shift'] === $s; });
                      ?>
                        <tr class="shift-row">
                          <td colspan="7"><?= $shiftLabels[$s] ?> &mdash; (<?= count($shiftRows) ?> Present)</td>
                        </tr>
                        <?php if (empty($shiftRows)): ?>
                          <tr><td colspan="7" style="color:#888; font-style:italic;">No records for Shift <?= $s ?></td></tr>
                        <?php else: ?>
                          <?php foreach ($shiftRows as $row): ?>
                            <tr>
                              <td><?= $prtSerial++ ?></td>
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
          </section>

          <!-- Vande Bharat Panel -->
          <section id="vb" class="report-panel">
            <div class="report-card">
              <div class="report-title">Manpower Report for Vande Bharat</div>
              <div class="meta-grid">
                <div class="meta"><strong>Railway:</strong> <?= htmlspecialchars($railwayName) ?></div>
                <div class="meta"><strong>Date:</strong> <?= date('d-m-Y', strtotime($selectedFromDate)) . ($selectedFromDate !== $selectedToDate ? ' to ' . date('d-m-Y', strtotime($selectedToDate)) : '') ?></div>
                <div class="meta"><strong>Division:</strong> <?= htmlspecialchars($divisionName) ?></div>
                <div class="meta"><strong>Coaching Depot:</strong> <?= htmlspecialchars($stationName) ?></div>
                <div class="meta" style="grid-column:span 2"><strong>Contractor Name:</strong> <?= htmlspecialchars($contractorName) ?></div>
                <div class="meta"><strong>Target Manpower:</strong> <?= $targetManpower ?></div>
                <div class="meta"><strong>Total Present:</strong> <?= $vbData['total_present'] ?></div>
              </div>
              <div class="table-wrap">
                <table id="vbTable">
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
                    <?php if (empty($vbData['rows'])): ?>
                      <tr><td colspan="7" class="empty-data-row">No attendance records found for Vande Bharat in selected date range.</td></tr>
                    <?php else: ?>
                      <?php 
                      $vbSerial = 1;
                      for ($s = 1; $s <= 3; $s++): 
                          $shiftRows = array_filter($vbData['rows'], function($r) use ($s) { return $r['shift'] === $s; });
                      ?>
                        <tr class="shift-row">
                          <td colspan="7"><?= $shiftLabels[$s] ?> &mdash; (<?= count($shiftRows) ?> Present)</td>
                        </tr>
                        <?php if (empty($shiftRows)): ?>
                          <tr><td colspan="7" style="color:#888; font-style:italic;">No records for Shift <?= $s ?></td></tr>
                        <?php else: ?>
                          <?php foreach ($shiftRows as $row): ?>
                            <tr>
                              <td><?= $vbSerial++ ?></td>
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