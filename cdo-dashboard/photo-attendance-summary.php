<?php
require_once 'auth.php';

$pageTitle = 'Photo Attendance Monthly Summary | CDO';
$extraStyles = "";

// Month & Year selection (Default to current month and year)
$selectedMonth = isset($_GET['month']) ? str_pad($_GET['month'], 2, '0', STR_PAD_LEFT) : date('m');
$selectedYear = isset($_GET['year']) ? intval($_GET['year']) : intval(date('Y'));

// Days in month
$firstDayOfMonth = "$selectedYear-$selectedMonth-01";
$lastDayOfMonth = date('Y-m-t', strtotime($firstDayOfMonth));
$daysInMonth = cal_days_in_month(CAL_GREGORIAN, intval($selectedMonth), $selectedYear);
$summaryMonthDisplay = date('F Y', strtotime($firstDayOfMonth));

// ----------------------------------------------------
// Query All Monthly Records
// ----------------------------------------------------
$sql = "
    SELECT 
        p.*,
        COALESCE(e.full_name, p.employee_id) AS employee_name,
        COALESCE(e.designation, 'Staff') AS designation,
        e.employee_photo AS master_photo,
        DAY(p.attendance_date) AS day_num,
        CASE 
            WHEN p.in_time IS NULL THEN 'Shift 1'
            WHEN TIME(p.in_time) >= '06:00:00' AND TIME(p.in_time) < '14:00:00' THEN 'Shift 1'
            WHEN TIME(p.in_time) >= '14:00:00' AND TIME(p.in_time) < '22:00:00' THEN 'Shift 2'
            ELSE 'Shift 3'
        END AS dynamic_shift
    FROM mcc_photo_attendance p
    LEFT JOIN mcc_employee e ON p.employee_id = e.employee_id
    WHERE p.attendance_date BETWEEN :start_date AND :end_date
    ORDER BY p.attendance_date ASC, p.in_time ASC
";
$params = [
    'start_date' => $firstDayOfMonth,
    'end_date' => $lastDayOfMonth
];

$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$monthlyLogs = $stmt->fetchAll(PDO::FETCH_ASSOC);

// ----------------------------------------------------
// Process Data & Calculate Monthly Metrics
// ----------------------------------------------------
$daySummary = [];
for ($d = 1; $d <= $daysInMonth; $d++) {
    $daySummary[$d] = [
        'day' => $d,
        'date' => sprintf('%04d-%02d-%02d', $selectedYear, $selectedMonth, $d),
        'shift1' => 0,
        'shift2' => 0,
        'shift3' => 0,
        'total_present' => 0,
        'normal_clean' => 0,
        'pit_clean' => 0,
        'intensive_clean' => 0,
        'prt_clean' => 0,
        'in_photos' => 0,
        'out_photos' => 0,
        'total_seconds' => 0,
        'distinct_emps' => []
    ];
}

$empSummary = [];
$totalMonthlyPunches = count($monthlyLogs);
$totalSecondsWorked = 0;
$totalInPhotos = 0;
$totalOutPhotos = 0;
$distinctStaffMap = [];
$processBreakdown = [
    'Normal Cleaning' => 0,
    'Pit Cleaning' => 0,
    'Intensive Cleaning' => 0,
    'Platform Return Cleaning' => 0
];

foreach ($monthlyLogs as $log) {
    $day = intval($log['day_num']);
    $shift = $log['dynamic_shift'];
    $empId = $log['employee_id'];
    $proc = $log['process'] ?? 'Normal Cleaning';

    $distinctStaffMap[$empId] = true;
    if (isset($processBreakdown[$proc])) {
        $processBreakdown[$proc]++;
    } else {
        $processBreakdown[$proc] = 1;
    }

    // Work duration calculation
    $durationSec = 0;
    if (!empty($log['in_time']) && !empty($log['out_time'])) {
        $inTs = strtotime($log['in_time']);
        $outTs = strtotime($log['out_time']);
        if ($outTs > $inTs) {
            $durationSec = $outTs - $inTs;
        }
    }
    $totalSecondsWorked += $durationSec;

    // Photo check
    $hasInPhoto = !empty($log['in_photo']);
    $hasOutPhoto = !empty($log['out_photo']);
    if ($hasInPhoto) $totalInPhotos++;
    if ($hasOutPhoto) $totalOutPhotos++;

    // Daily Accumulation
    if (isset($daySummary[$day])) {
        $daySummary[$day]['distinct_emps'][$empId] = true;
        if ($shift === 'Shift 1') $daySummary[$day]['shift1']++;
        elseif ($shift === 'Shift 2') $daySummary[$day]['shift2']++;
        elseif ($shift === 'Shift 3') $daySummary[$day]['shift3']++;

        if (stripos($proc, 'pit') !== false) $daySummary[$day]['pit_clean']++;
        elseif (stripos($proc, 'intensive') !== false) $daySummary[$day]['intensive_clean']++;
        elseif (stripos($proc, 'platform') !== false || stripos($proc, 'prt') !== false) $daySummary[$day]['prt_clean']++;
        else $daySummary[$day]['normal_clean']++;

        if ($hasInPhoto) $daySummary[$day]['in_photos']++;
        if ($hasOutPhoto) $daySummary[$day]['out_photos']++;
        $daySummary[$day]['total_seconds'] += $durationSec;
    }

    // Employee-wise Accumulation
    if (!isset($empSummary[$empId])) {
        $empSummary[$empId] = [
            'emp_id' => $empId,
            'name' => $log['employee_name'],
            'designation' => $log['designation'],
            'master_photo' => $log['master_photo'],
            'days_present' => 0,
            'shift1_count' => 0,
            'shift2_count' => 0,
            'shift3_count' => 0,
            'total_seconds' => 0,
            'in_photos_count' => 0,
            'out_photos_count' => 0,
            'processes' => []
        ];
    }
    $empSummary[$empId]['days_present']++;
    if ($shift === 'Shift 1') $empSummary[$empId]['shift1_count']++;
    elseif ($shift === 'Shift 2') $empSummary[$empId]['shift2_count']++;
    elseif ($shift === 'Shift 3') $empSummary[$empId]['shift3_count']++;
    $empSummary[$empId]['total_seconds'] += $durationSec;
    if ($hasInPhoto) $empSummary[$empId]['in_photos_count']++;
    if ($hasOutPhoto) $empSummary[$empId]['out_photos_count']++;
    $empSummary[$empId]['processes'][$proc] = ($empSummary[$empId]['processes'][$proc] ?? 0) + 1;
}

// Compute total present per day
foreach ($daySummary as $d => $data) {
    $daySummary[$d]['total_present'] = count($data['distinct_emps']);
}

// Global Metrics
$uniqueStaffCount = count($distinctStaffMap);
$totalHoursLogged = round($totalSecondsWorked / 3600, 1);
$activeDaysCount = count(array_filter($daySummary, function($d) { return $d['total_present'] > 0; }));
$avgDailyStaff = $activeDaysCount > 0 ? round($totalMonthlyPunches / $activeDaysCount, 1) : 0;
$compliancePercent = $totalMonthlyPunches > 0 ? round((($totalInPhotos + $totalOutPhotos) / ($totalMonthlyPunches * 2)) * 100, 1) : 100;

include 'header.php';
include 'sidebar.php';
?>

<style>
/* Page Styling */
.summary-page {
  padding: 22px 24px;
  background: #f4f7fa;
  min-height: calc(100vh - 65px);
  font-family: 'Inter', system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
}

/* Toolbar Card */
.filter-card {
  background: #ffffff;
  border: 1px solid #dce4ec;
  border-radius: 12px;
  padding: 18px 20px;
  box-shadow: 0 4px 14px rgba(7, 32, 58, 0.06);
  margin-bottom: 22px;
}

.filter-title {
  font-size: 14px;
  font-weight: 700;
  color: #072e50;
  margin-bottom: 14px;
  display: flex;
  align-items: center;
  gap: 8px;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.filter-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  align-items: flex-end;
}

.filter-group {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.filter-group label {
  font-size: 12px;
  font-weight: 600;
  color: #4b6479;
}

.filter-select {
  height: 38px;
  padding: 6px 12px;
  font-size: 13px;
  font-weight: 600;
  border: 1.5px solid #c9d8e5;
  border-radius: 8px;
  background: #fff;
  color: #07203a;
  min-width: 150px;
  transition: all 0.2s ease;
}

.filter-select:focus {
  border-color: #0284c7;
  outline: none;
  box-shadow: 0 0 0 3px rgba(2, 132, 199, 0.15);
}

.btn-filter-go {
  background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
  color: #fff;
  font-weight: 600;
  font-size: 13px;
  height: 38px;
  padding: 0 18px;
  border-radius: 8px;
  border: none;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  box-shadow: 0 2px 6px rgba(2, 132, 199, 0.3);
  transition: all 0.2s;
}

.btn-filter-go:hover {
  background: linear-gradient(135deg, #0369a1 0%, #075985 100%);
  color: #fff;
}

.btn-back-link {
  background: #f1f5f9;
  color: #0369a1;
  font-weight: 600;
  font-size: 13px;
  height: 38px;
  padding: 0 14px;
  border-radius: 8px;
  border: 1px solid #cbd5e1;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  text-decoration: none;
  transition: all 0.2s;
}

.btn-back-link:hover {
  background: #e2e8f0;
  color: #075985;
}

.btn-print-action {
  background: #0f172a;
  color: #fff;
  font-weight: 600;
  font-size: 13px;
  height: 38px;
  padding: 0 16px;
  border-radius: 8px;
  border: none;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  margin-left: auto;
  transition: all 0.2s;
}

.btn-print-action:hover {
  background: #1e293b;
  color: #fff;
}

/* KPI Deck */
.kpi-deck {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(210px, 1fr));
  gap: 16px;
  margin-bottom: 22px;
}

.kpi-card {
  background: #fff;
  border: 1px solid #e2e8f0;
  border-radius: 12px;
  padding: 16px 20px;
  display: flex;
  align-items: center;
  gap: 16px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

.kpi-icon-wrap {
  width: 48px;
  height: 48px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 22px;
  flex-shrink: 0;
}

.kpi-icon-blue { background: #e0f2fe; color: #0284c7; }
.kpi-icon-green { background: #dcfce7; color: #16a34a; }
.kpi-icon-purple { background: #ede9fe; color: #7c3aed; }
.kpi-icon-amber { background: #fef3c7; color: #d97706; }

.kpi-meta .kpi-label {
  font-size: 11.5px;
  font-weight: 600;
  color: #64748b;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin-bottom: 3px;
}

.kpi-meta .kpi-value {
  font-size: 22px;
  font-weight: 800;
  color: #0f172a;
  line-height: 1.1;
}

/* Tabs */
.summary-tabs {
  display: flex;
  gap: 4px;
  border-bottom: 2px solid #cbd5e1;
  margin-bottom: 18px;
}

.summary-tab-btn {
  background: #e2e8f0;
  color: #475569;
  font-weight: 700;
  font-size: 13px;
  padding: 10px 18px;
  border-radius: 8px 8px 0 0;
  border: none;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  transition: all 0.2s;
}

.summary-tab-btn.active {
  background: #0284c7;
  color: #fff;
}

/* Report Table Container */
.report-card-wrap {
  background: #fff;
  border: 1px solid #dce4ec;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 16px rgba(7, 32, 58, 0.06);
  margin-bottom: 25px;
}

.report-header-banner {
  background: linear-gradient(135deg, #072a4a 0%, #0a3a66 100%);
  color: #fff;
  padding: 18px 24px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 12px;
  border-bottom: 3px solid #0284c7;
}

.banner-title {
  font-size: 18px;
  font-weight: 800;
  margin: 0;
  display: flex;
  align-items: center;
  gap: 10px;
}

.banner-sub {
  font-size: 12px;
  color: #93c5fd;
  margin-top: 3px;
}

/* Table */
.table-responsive-custom {
  overflow-x: auto;
  width: 100%;
}

.table-summary {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
  min-width: 1050px;
  font-size: 12.5px;
}

.table-summary thead tr.main-th th {
  background: #092c4c;
  color: #ffffff;
  padding: 10px 12px;
  font-size: 12px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  text-align: center;
  border-bottom: 1px solid #164670;
}

.table-summary thead tr.sub-th th {
  background: #f1f5f9;
  color: #334155;
  font-weight: 700;
  font-size: 11.5px;
  padding: 8px 10px;
  border-bottom: 2px solid #cbd5e1;
  text-align: center;
  white-space: nowrap;
}

.table-summary tbody tr:nth-child(even) {
  background: #f8fafc;
}

.table-summary tbody tr:hover {
  background: #eef6ff !important;
}

.table-summary tbody td {
  padding: 10px 12px;
  border-bottom: 1px solid #e2e8f0;
  color: #1e293b;
  text-align: center;
  vertical-align: middle;
}

.table-summary tfoot td {
  background: #e0f2fe;
  color: #0369a1;
  font-weight: 800;
  font-size: 13px;
  padding: 12px;
  border-top: 2px solid #0284c7;
  text-align: center;
}

/* Badges */
.badge-shift {
  display: inline-block;
  padding: 2px 7px;
  border-radius: 4px;
  font-weight: 700;
  font-size: 11px;
}
.badge-shift.s1 { background: #e0f2fe; color: #0369a1; }
.badge-shift.s2 { background: #fef3c7; color: #b45309; }
.badge-shift.s3 { background: #ede9fe; color: #6d28d9; }

.emp-id-badge {
  background: #e0f2fe;
  color: #0369a1;
  font-weight: 700;
  font-family: monospace;
  font-size: 12px;
  padding: 2px 8px;
  border-radius: 6px;
  border: 1px solid #bae6fd;
}

.tab-pane-content {
  display: none;
}
.tab-pane-content.active {
  display: block;
}

@media print {
  .no-print, .app-sidebar, .app-header { display: none !important; }
  .summary-page { padding: 0 !important; background: #fff !important; }
  .tab-pane-content { display: block !important; page-break-after: always; }
  .table-summary { font-size: 10px !important; min-width: 100% !important; }
}
</style>

<main class="app-main">
  <div class="app-content">
    <div class="container-fluid">
      <div class="summary-page">

        <!-- Filter Card -->
        <div class="filter-card no-print">
          <div class="filter-title">
            <i class="bi bi-calendar-month text-primary"></i>
            Monthly Photo Attendance Control Panel
          </div>

          <form method="GET" action="photo-attendance-summary.php" class="filter-grid">
            <div class="filter-group">
              <label for="month"><i class="bi bi-calendar3 me-1"></i>Select Month</label>
              <select id="month" name="month" class="filter-select">
                <?php for ($m = 1; $m <= 12; $m++): 
                  $mStr = str_pad($m, 2, '0', STR_PAD_LEFT);
                ?>
                  <option value="<?= $mStr ?>" <?= ($selectedMonth === $mStr) ? 'selected' : '' ?>>
                    <?= date('F', mktime(0, 0, 0, $m, 1)) ?>
                  </option>
                <?php endfor; ?>
              </select>
            </div>

            <div class="filter-group">
              <label for="year"><i class="bi bi-calendar-event me-1"></i>Select Year</label>
              <select id="year" name="year" class="filter-select" style="min-width: 110px;">
                <?php for ($y = date('Y') - 2; $y <= date('Y') + 2; $y++): ?>
                  <option value="<?= $y ?>" <?= ($selectedYear == $y) ? 'selected' : '' ?>><?= $y ?></option>
                <?php endfor; ?>
              </select>
            </div>

            <div class="filter-group" style="flex-direction: row; gap: 8px;">
              <button type="submit" class="btn-filter-go">
                <i class="bi bi-funnel-fill"></i> Load Summary
              </button>
              <a href="photo_attendance.php" class="btn-back-link" title="Go to daily photo verification logs">
                <i class="bi bi-camera-fill"></i> View Daily Logs
              </a>
            </div>

            <button type="button" class="btn-print-action" onclick="window.print()">
              <i class="bi bi-printer-fill"></i> Print Summary
            </button>
          </form>
        </div>

        <!-- Navigation Tabs -->
        <div class="summary-tabs no-print">
          <button class="summary-tab-btn active" onclick="switchSummaryTab('dayTab', this)">
            <i class="bi bi-calendar3"></i> Day-by-Day Calendar Summary
          </button>
          <button class="summary-tab-btn" onclick="switchSummaryTab('empTab', this)">
            <i class="bi bi-person-lines-fill"></i> Staff-Wise Monthly Performance
          </button>
        </div>

        <!-- TAB 1: Day-by-Day Calendar Summary -->
        <div id="dayTab" class="tab-pane-content active">
          <div class="report-card-wrap">
            <div class="report-header-banner">
              <div>
                <h2 class="banner-title">
                  <i class="bi bi-calendar-range-fill text-info"></i>
                  Daily Photo Attendance Summary &mdash; <?= $summaryMonthDisplay ?>
                </h2>
                <div class="banner-sub">
                  Coaching Depot: <strong><?= htmlspecialchars($stationName ?? 'Lumding') ?></strong> &bull;
                  Total Days: <strong><?= $daysInMonth ?></strong> &bull;
                  Active Duty Days: <strong><?= $activeDaysCount ?></strong> &bull;
                  Avg Daily Staff: <strong><?= $avgDailyStaff ?></strong>
                </div>
              </div>
              <div>
                <span class="badge bg-light text-dark px-3 py-2 fw-bold" style="font-size: 13px; border-radius: 8px;">
                  <i class="bi bi-check2-circle text-success me-1"></i> Shift Wise Summary
                </span>
              </div>
            </div>

            <div class="table-responsive-custom">
              <table class="table-summary">
                <thead>
                  <tr class="main-th">
                    <th rowspan="2" style="width: 50px;">Day</th>
                    <th rowspan="2" style="width: 140px;">Date</th>
                    <th colspan="3" style="background:#0c4a6e;">Shift Breakdown (Dynamic by IN Time)</th>
                    <th rowspan="2" style="width: 120px; background:#075985;">Total Staff</th>
                    <th rowspan="2" style="width: 120px;">Total Hours</th>
                  </tr>
                  <tr class="sub-th">
                    <th style="color:#0369a1;">Shift 1 (06-14)</th>
                    <th style="color:#b45309;">Shift 2 (14-22)</th>
                    <th style="color:#6d28d9;">Shift 3 (22-06)</th>
                  </tr>
                </thead>
                <tbody>
                  <?php 
                  $sumS1 = 0; $sumS2 = 0; $sumS3 = 0; $sumTotal = 0;
                  $sumSeconds = 0;

                  for ($d = 1; $d <= $daysInMonth; $d++): 
                      $row = $daySummary[$d];
                      $dayDate = $row['date'];
                      $dayName = date('D', strtotime($dayDate));
                      $isSunday = ($dayName === 'Sun');

                      $sumS1 += $row['shift1'];
                      $sumS2 += $row['shift2'];
                      $sumS3 += $row['shift3'];
                      $sumTotal += $row['total_present'];
                      $sumSeconds += $row['total_seconds'];

                      $dayHours = round($row['total_seconds'] / 3600, 1);
                  ?>
                    <tr style="<?= $isSunday ? 'background: #fff8f8;' : '' ?>">
                      <td><strong><?= $d ?></strong></td>
                      <td>
                        <span class="fw-semibold <?= $isSunday ? 'text-danger' : 'text-dark' ?>">
                          <?= date('d-m-Y', strtotime($dayDate)) ?> (<?= $dayName ?>)
                        </span>
                      </td>
                      <td><span class="badge-shift s1"><?= $row['shift1'] ?></span></td>
                      <td><span class="badge-shift s2"><?= $row['shift2'] ?></span></td>
                      <td><span class="badge-shift s3"><?= $row['shift3'] ?></span></td>
                      <td>
                        <strong class="text-primary fs-6"><?= $row['total_present'] ?></strong>
                      </td>
                      <td><strong><?= $dayHours > 0 ? "{$dayHours}h" : '-' ?></strong></td>
                    </tr>
                  <?php endfor; ?>
                </tbody>
                <tfoot>
                  <tr>
                    <td colspan="2">MONTH TOTAL (<?= $summaryMonthDisplay ?>)</td>
                    <td><?= $sumS1 ?></td>
                    <td><?= $sumS2 ?></td>
                    <td><?= $sumS3 ?></td>
                    <td><?= $sumTotal ?></td>
                    <td><?= round($sumSeconds / 3600, 1) ?> hrs</td>
                  </tr>
                </tfoot>
              </table>
            </div>
          </div>
        </div>

        <!-- TAB 2: Staff-Wise Monthly Performance -->
        <div id="empTab" class="tab-pane-content">
          <div class="report-card-wrap">
            <div class="report-header-banner">
              <div>
                <h2 class="banner-title">
                  <i class="bi bi-person-badge-fill text-info"></i>
                  Staff-Wise Monthly Attendance &mdash; <?= $summaryMonthDisplay ?>
                </h2>
                <div class="banner-sub">
                  Total Staff Evaluated: <strong><?= count($empSummary) ?></strong> &bull;
                  Month: <strong><?= $summaryMonthDisplay ?></strong>
                </div>
              </div>
            </div>

            <div class="table-responsive-custom">
              <table class="table-summary">
                <thead>
                  <tr class="main-th">
                    <th style="width: 50px;">#</th>
                    <th style="width: 140px;">Emp ID</th>
                    <th style="width: 250px; text-align: left; padding-left: 16px;">Staff Name</th>
                    <th style="width: 160px;">Designation</th>
                    <th style="width: 130px;">Days Present</th>
                    <th style="width: 100px;">Shift 1</th>
                    <th style="width: 100px;">Shift 2</th>
                    <th style="width: 100px;">Shift 3</th>
                    <th style="width: 130px;">Total Hours</th>
                  </tr>
                </thead>
                <tbody>
                  <?php if (empty($empSummary)): ?>
                    <tr>
                      <td colspan="9" style="padding: 30px; text-align: center; color: #64748b;">
                        No staff attendance records logged for this month.
                      </td>
                    </tr>
                  <?php else: ?>
                    <?php 
                    $eSerial = 1;
                    foreach ($empSummary as $emp): 
                        $empHours = round($emp['total_seconds'] / 3600, 1);
                    ?>
                      <tr>
                        <td><?= $eSerial++ ?></td>
                        <td><span class="emp-id-badge"><?= htmlspecialchars($emp['emp_id']) ?></span></td>
                        <td style="text-align: left; font-weight: 700; color: #0f172a;">
                          <?= htmlspecialchars($emp['name']) ?>
                        </td>
                        <td><span class="text-secondary fw-semibold"><?= htmlspecialchars($emp['designation']) ?></span></td>
                        <td>
                          <span class="badge bg-primary text-white px-2 py-1 fs-6">
                            <?= $emp['days_present'] ?> / <?= $daysInMonth ?>
                          </span>
                        </td>
                        <td><span class="badge-shift s1"><?= $emp['shift1_count'] ?></span></td>
                        <td><span class="badge-shift s2"><?= $emp['shift2_count'] ?></span></td>
                        <td><span class="badge-shift s3"><?= $emp['shift3_count'] ?></span></td>
                        <td><strong><?= $empHours ?> hrs</strong></td>
                      </tr>
                    <?php endforeach; ?>
                  <?php endif; ?>
                </tbody>
              </table>
            </div>
          </div>
        </div>

      </div>
    </div>
  </div>
</main>

<script>
function switchSummaryTab(tabId, btn) {
  document.querySelectorAll('.tab-pane-content').forEach(function(pane) {
    pane.classList.remove('active');
  });
  document.querySelectorAll('.summary-tab-btn').forEach(function(b) {
    b.classList.remove('active');
  });
  document.getElementById(tabId).classList.add('active');
  btn.classList.add('active');
}
</script>

<?php include 'footer.php'; ?>
