<?php
require_once 'auth.php';

$pageTitle = 'Photo Attendance Report | Editor';
$extraStyles = "";

// ----------------------------------------------------
// Filters (Date, Shift, Search)
// ----------------------------------------------------
$selectedFromDate = isset($_GET['from_date']) && !empty($_GET['from_date']) ? $_GET['from_date'] : date('Y-m-d');
$selectedToDate = isset($_GET['to_date']) && !empty($_GET['to_date']) ? $_GET['to_date'] : $selectedFromDate;
$selectedShift = isset($_GET['shift']) ? trim($_GET['shift']) : '';
$selectedProcess = isset($_GET['process']) ? trim($_GET['process']) : '';
$searchQuery = isset($_GET['search']) ? trim($_GET['search']) : '';

// Validation
if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $selectedFromDate)) {
    $selectedFromDate = date('Y-m-d');
}
if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $selectedToDate)) {
    $selectedToDate = $selectedFromDate;
}
if ($selectedToDate < $selectedFromDate) {
    $selectedToDate = $selectedFromDate;
}

// ----------------------------------------------------
// Database Query
// Shift is calculated dynamically based on IN time:
// Shift 1: 06:00 - 14:00
// Shift 2: 14:00 - 22:00
// Shift 3: 22:00 - 06:00
// ----------------------------------------------------
$sql = "
    SELECT 
        p.*,
        COALESCE(e.full_name, p.employee_name, p.employee_id) AS employee_name,
        COALESCE(e.designation, 'Staff') AS designation,
        e.employee_photo AS master_photo,
        s.station_name,
        CASE 
            WHEN p.in_time IS NULL THEN 'Shift 1'
            WHEN TIME(p.in_time) >= '06:00:00' AND TIME(p.in_time) < '14:00:00' THEN 'Shift 1'
            WHEN TIME(p.in_time) >= '14:00:00' AND TIME(p.in_time) < '22:00:00' THEN 'Shift 2'
            ELSE 'Shift 3'
        END AS shift
    FROM mcc_photo_attendance p
    LEFT JOIN mcc_employee e ON p.employee_id = e.employee_id
    LEFT JOIN mcc_stations s ON p.station_id = s.station_id
    WHERE p.attendance_date BETWEEN :from_date AND :to_date
";
$params = [
    'from_date' => $selectedFromDate,
    'to_date' => $selectedToDate
];

if (!empty($selectedShift)) {
    if ($selectedShift === 'Shift 1') {
        $sql .= " AND (TIME(p.in_time) >= '06:00:00' AND TIME(p.in_time) < '14:00:00')";
    } elseif ($selectedShift === 'Shift 2') {
        $sql .= " AND (TIME(p.in_time) >= '14:00:00' AND TIME(p.in_time) < '22:00:00')";
    } elseif ($selectedShift === 'Shift 3') {
        $sql .= " AND (TIME(p.in_time) >= '22:00:00' OR TIME(p.in_time) < '06:00:00')";
    }
}

if (!empty($selectedProcess)) {
    $sql .= " AND p.process = :process";
    $params['process'] = $selectedProcess;
}

if (!empty($searchQuery)) {
    $sql .= " AND (p.employee_id LIKE :q1 OR e.full_name LIKE :q2 OR e.designation LIKE :q3 OR p.in_location LIKE :q4 OR p.out_location LIKE :q5 OR p.process LIKE :q6)";
    $params['q1'] = "%$searchQuery%";
    $params['q2'] = "%$searchQuery%";
    $params['q3'] = "%$searchQuery%";
    $params['q4'] = "%$searchQuery%";
    $params['q5'] = "%$searchQuery%";
    $params['q6'] = "%$searchQuery%";
}

$sql .= " ORDER BY p.attendance_date DESC, p.in_time ASC";

$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$attendanceLogs = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Summary Metrics
$totalRecords = count($attendanceLogs);
$totalIn = 0;
$totalOut = 0;
$pendingOut = 0;

foreach ($attendanceLogs as $row) {
    if (!empty($row['in_time'])) $totalIn++;
    if (!empty($row['out_time'])) {
        $totalOut++;
    } else {
        $pendingOut++;
    }
}

// Fixed Shifts list
$allShifts = ['Shift 1', 'Shift 2', 'Shift 3'];

// Get Distinct Processes for filter dropdown
$procStmt = $pdo->query("SELECT DISTINCT process FROM mcc_photo_attendance WHERE process IS NOT NULL AND process != '' ORDER BY process ASC");
$allProcesses = $procStmt->fetchAll(PDO::FETCH_COLUMN);
if (empty($allProcesses)) {
    $allProcesses = ['Normal Cleaning', 'Pit Cleaning', 'Intensive Cleaning', 'Platform Return Cleaning'];
}

// ----------------------------------------------------
// Handle Excel Export Request
// ----------------------------------------------------
if (isset($_GET['export']) && $_GET['export'] === 'excel') {
    $cleanDateFrom = date('d-m-Y', strtotime($selectedFromDate));
    $cleanDateTo = date('d-m-Y', strtotime($selectedToDate));
    $filename = "Photo_Attendance_Report_" . $selectedFromDate . ($selectedFromDate !== $selectedToDate ? "_to_" . $selectedToDate : "") . ".xls";

    // Clear any previous output buffers
    while (ob_get_level()) {
        ob_end_clean();
    }

    header("Content-Type: application/vnd.ms-excel; charset=utf-8");
    header("Content-Disposition: attachment; filename=\"$filename\"");
    header("Pragma: no-cache");
    header("Expires: 0");

    // Output UTF-8 Byte Order Mark
    echo "\xEF\xBB\xBF";

    $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? "https://" : "http://";
    $host = $_SERVER['HTTP_HOST'] ?? 'localhost';
    $baseUrl = $protocol . $host;
    ?>
    <html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <!--[if gte mso 9]>
    <xml>
      <x:ExcelWorkbook>
        <x:ExcelWorksheets>
          <x:ExcelWorksheet>
            <x:Name>Photo Attendance</x:Name>
            <x:WorksheetOptions>
              <x:DisplayGridlines/>
            </x:WorksheetOptions>
          </x:ExcelWorksheet>
        </x:ExcelWorksheets>
      </x:ExcelWorkbook>
    </xml>
    <![endif]-->
    <style>
      table { border-collapse: collapse; width: 100%; font-family: Calibri, Arial, sans-serif; font-size: 11pt; }
      th { background-color: #072a4a; color: #ffffff; border: 1px solid #94a3b8; font-weight: bold; text-align: center; vertical-align: middle; padding: 10px 8px; }
      td { border: 1px solid #cbd5e1; vertical-align: middle; padding: 7px 8px; text-align: left; }
      .text-center { text-align: center; }
      .text-num { mso-number-format:"\@"; text-align: center; }
      .header-title { font-size: 16pt; font-weight: bold; text-align: center; color: #072a4a; height: 35px; }
      .header-meta { font-size: 10pt; text-align: center; color: #475569; height: 25px; }
      .th-in { background-color: #0369a1; color: #ffffff; }
      .th-out { background-color: #b45309; color: #ffffff; }
      .bg-in { background-color: #f0fdf4; }
      .bg-out { background-color: #fef2f2; }
      .badge-in { color: #15803d; font-weight: bold; }
      .badge-out { color: #b91c1c; font-weight: bold; }
      .badge-pending { color: #b45309; font-weight: bold; }
      .photo-link { color: #0284c7; text-decoration: underline; font-weight: 600; }
    </style>
    </head>
    <body>
    <table>
      <tr>
        <td colspan="15" class="header-title">INDIAN RAILWAYS - PHOTO ATTENDANCE & GEO-LOCATION REPORT</td>
      </tr>
      <tr>
        <td colspan="15" class="header-meta">
          Station: <strong><?= htmlspecialchars($stationName ?? 'Coaching Depot') ?></strong> &nbsp;|&nbsp;
          Date Range: <strong><?= $cleanDateFrom ?></strong><?php if ($selectedFromDate !== $selectedToDate): ?> to <strong><?= $cleanDateTo ?></strong><?php endif; ?> &nbsp;|&nbsp;
          Shift: <strong><?= htmlspecialchars(!empty($selectedShift) ? $selectedShift : 'All Shifts') ?></strong> &nbsp;|&nbsp;
          Process: <strong><?= htmlspecialchars(!empty($selectedProcess) ? $selectedProcess : 'All Processes') ?></strong> &nbsp;|&nbsp;
          Total Staff Logged: <strong><?= count($attendanceLogs) ?></strong> &nbsp;|&nbsp;
          Exported On: <strong><?= date('d-m-Y H:i:s') ?></strong>
        </td>
      </tr>
      <tr>
        <td colspan="15" style="border: none; height: 10px;"></td>
      </tr>
      <thead>
        <tr>
          <th style="width: 50px;">S.No</th>
          <th style="width: 110px;">Date</th>
          <th style="width: 100px;">Emp ID</th>
          <th style="width: 200px;">Employee Name</th>
          <th style="width: 140px;">Designation</th>
          <th style="width: 90px;">Shift</th>
          <th style="width: 130px;" class="th-in">Punch IN Time</th>
          <th style="width: 260px;" class="th-in">Punch IN Location</th>
          <th style="width: 140px;" class="th-in">Punch IN Photo</th>
          <th style="width: 130px;" class="th-out">Punch OUT Time</th>
          <th style="width: 260px;" class="th-out">Punch OUT Location</th>
          <th style="width: 140px;" class="th-out">Punch OUT Photo</th>
          <th style="width: 110px;">Duration</th>
          <th style="width: 130px;">Status</th>
          <th style="width: 160px;">Process</th>
        </tr>
      </thead>
      <tbody>
        <?php if (empty($attendanceLogs)): ?>
          <tr>
            <td colspan="15" class="text-center" style="padding: 20px; color: #64748b;">No attendance records found for the selected filter criteria.</td>
          </tr>
        <?php else: ?>
          <?php 
          $sno = 1;
          foreach ($attendanceLogs as $log): 
              $duration = '-';
              $status = 'Punch-Out Pending';
              if (!empty($log['in_time']) && !empty($log['out_time'])) {
                  $inTs = strtotime($log['in_time']);
                  $outTs = strtotime($log['out_time']);
                  if ($outTs > $inTs) {
                      $diff = $outTs - $inTs;
                      $hrs = floor($diff / 3600);
                      $mins = floor(($diff % 3600) / 60);
                      $duration = "{$hrs}h {$mins}m";
                  }
                  $status = 'Completed';
              } elseif (!empty($log['in_time'])) {
                  $status = 'Active';
              }

              $inPhotoFull = '';
              if (!empty($log['in_photo'])) {
                  $p = trim($log['in_photo']);
                  if (preg_match('/^https?:\/\//i', $p)) {
                      $inPhotoFull = $p;
                  } else {
                      $inPhotoFull = $baseUrl . '/mcc/' . ltrim($p, '/');
                  }
              }

              $outPhotoFull = '';
              if (!empty($log['out_photo'])) {
                  $p = trim($log['out_photo']);
                  if (preg_match('/^https?:\/\//i', $p)) {
                      $outPhotoFull = $p;
                  } else {
                      $outPhotoFull = $baseUrl . '/mcc/' . ltrim($p, '/');
                  }
              }

              $inTimeFormatted = !empty($log['in_time']) ? date('H:i:s', strtotime($log['in_time'])) : '-';
              $outTimeFormatted = !empty($log['out_time']) ? date('H:i:s', strtotime($log['out_time'])) : '-';
              $attDateFormatted = !empty($log['attendance_date']) ? date('d-m-Y', strtotime($log['attendance_date'])) : '-';
          ?>
            <tr>
              <td class="text-center"><?= $sno++ ?></td>
              <td class="text-center"><?= $attDateFormatted ?></td>
              <td class="text-num"><?= htmlspecialchars($log['employee_id']) ?></td>
              <td><strong><?= htmlspecialchars($log['employee_name']) ?></strong></td>
              <td><?= htmlspecialchars($log['designation']) ?></td>
              <td class="text-center"><?= htmlspecialchars($log['shift']) ?></td>
              <td class="text-center bg-in badge-in"><?= $inTimeFormatted ?></td>
              <td class="bg-in"><?= htmlspecialchars($log['in_location'] ?: '-') ?></td>
              <td class="text-center bg-in">
                <?php if (!empty($inPhotoFull)): ?>
                  <a href="<?= htmlspecialchars($inPhotoFull) ?>" class="photo-link" target="_blank">View IN Photo</a>
                <?php else: ?>
                  -
                <?php endif; ?>
              </td>
              <td class="text-center bg-out badge-out"><?= $outTimeFormatted ?></td>
              <td class="bg-out"><?= htmlspecialchars($log['out_location'] ?: '-') ?></td>
              <td class="text-center bg-out">
                <?php if (!empty($outPhotoFull)): ?>
                  <a href="<?= htmlspecialchars($outPhotoFull) ?>" class="photo-link" target="_blank">View OUT Photo</a>
                <?php else: ?>
                  -
                <?php endif; ?>
              </td>
              <td class="text-center"><strong><?= $duration ?></strong></td>
              <td class="text-center <?= $status === 'Completed' ? 'badge-in' : 'badge-pending' ?>"><?= $status ?></td>
              <td><?= htmlspecialchars($log['process'] ?: '-') ?></td>
            </tr>
          <?php endforeach; ?>
        <?php endif; ?>
      </tbody>
    </table>
    </body>
    </html>
    <?php
    exit();
}

include 'header.php';
include 'sidebar.php';
?>

<style>
/* Base Page Styling */
.photo-att-page {
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

.filter-input, .filter-select {
  height: 38px;
  padding: 6px 12px;
  font-size: 13px;
  font-weight: 600;
  border: 1.5px solid #c9d8e5;
  border-radius: 8px;
  background: #fff;
  color: #07203a;
  transition: all 0.2s ease;
}

.filter-input:focus, .filter-select:focus {
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

.btn-filter-reset {
  background: #f1f5f9;
  color: #475569;
  font-weight: 600;
  font-size: 13px;
  height: 38px;
  padding: 0 14px;
  border-radius: 8px;
  border: 1px solid #cbd5e1;
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  text-decoration: none;
  transition: all 0.2s;
}

.btn-filter-reset:hover {
  background: #e2e8f0;
  color: #1e293b;
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

.btn-export-excel {
  background: linear-gradient(135deg, #10b981 0%, #059669 100%);
  color: #fff !important;
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
  text-decoration: none;
  box-shadow: 0 2px 6px rgba(16, 185, 129, 0.3);
  transition: all 0.2s ease;
}

.btn-export-excel:hover {
  background: linear-gradient(135deg, #059669 0%, #047857 100%);
  box-shadow: 0 4px 10px rgba(16, 185, 129, 0.4);
  transform: translateY(-1px);
  color: #fff !important;
}

/* KPI Cards */
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
.kpi-icon-amber { background: #fef3c7; color: #d97706; }
.kpi-icon-purple { background: #ede9fe; color: #7c3aed; }

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

/* Report Table Container */
.report-card-wrap {
  background: #fff;
  border: 1px solid #dce4ec;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 16px rgba(7, 32, 58, 0.06);
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
  letter-spacing: 0.4px;
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

/* Table Design */
.table-responsive-custom {
  overflow-x: auto;
  width: 100%;
}

.table-att {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
  min-width: 1280px;
  font-size: 12.5px;
}

/* Group Headers */
.table-att thead tr.group-head th {
  background: #092c4c;
  color: #ffffff;
  padding: 10px 14px;
  font-size: 12px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.6px;
  border-bottom: 1px solid #164670;
  text-align: center;
}

.table-att thead tr.group-head th.th-in-head {
  background: #0c4a6e;
  border-left: 2px solid #0284c7;
  border-right: 1px solid #164e75;
}

.table-att thead tr.group-head th.th-out-head {
  background: #1e3a5f;
  border-left: 2px solid #38bdf8;
  border-right: 1px solid #234b79;
}

/* Sub Columns */
.table-att thead tr.sub-head th {
  background: #f1f5f9;
  color: #334155;
  font-weight: 700;
  font-size: 11.5px;
  padding: 10px 12px;
  border-bottom: 2px solid #cbd5e1;
  text-align: center;
  white-space: nowrap;
}

.table-att thead tr.sub-head th.border-left-in {
  border-left: 2px solid #0284c7;
}

.table-att thead tr.sub-head th.border-left-out {
  border-left: 2px solid #38bdf8;
}

/* Table Body */
.table-att tbody tr {
  transition: background 0.15s ease;
}

.table-att tbody tr:nth-child(even) {
  background: #f8fafc;
}

.table-att tbody tr:hover {
  background: #eef6ff !important;
}

.table-att tbody td {
  padding: 12px 14px;
  border-bottom: 1px solid #e2e8f0;
  color: #1e293b;
  vertical-align: middle;
  text-align: center;
}

.table-att tbody td.border-left-in {
  border-left: 2px solid #bae6fd;
}

.table-att tbody td.border-left-out {
  border-left: 2px solid #cbd5e1;
}

/* Cell content formatters */
.emp-id-badge {
  display: inline-block;
  background: #e0f2fe;
  color: #0369a1;
  font-weight: 700;
  font-family: monospace;
  font-size: 12px;
  padding: 3px 8px;
  border-radius: 6px;
  border: 1px solid #bae6fd;
}

.emp-info-cell {
  text-align: left !important;
  display: flex;
  align-items: center;
  gap: 10px;
}

.emp-avatar {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  object-fit: cover;
  background: #cbd5e1;
  border: 2px solid #94a3b8;
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #475569;
  font-weight: 700;
  font-size: 16px;
  box-shadow: 0 2px 5px rgba(0,0,0,0.08);
}

.emp-name-text {
  font-weight: 700;
  color: #0f172a;
  line-height: 1.2;
}

.emp-desig-text {
  font-size: 11px;
  color: #64748b;
  font-weight: 500;
}

.shift-pill {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 3px 10px;
  border-radius: 12px;
  font-weight: 700;
  font-size: 11.5px;
  background: #f1f5f9;
  color: #334155;
  border: 1px solid #cbd5e1;
}

.shift-pill.s1 { background: #e0f2fe; color: #0369a1; border-color: #bae6fd; }
.shift-pill.s2 { background: #fef3c7; color: #b45309; border-color: #fde68a; }
.shift-pill.s3 { background: #ede9fe; color: #6d28d9; border-color: #ddd6fe; }

/* Group Block (Punch Card Inside Table Cell) */
.punch-block {
  text-align: left;
  display: flex;
  align-items: center;
  gap: 12px;
}

.punch-thumb-wrap {
  position: relative;
  width: 92px;
  height: 92px;
  border-radius: 10px;
  overflow: hidden;
  border: 2.5px solid #cbd5e1;
  flex-shrink: 0;
  cursor: pointer;
  background: #f1f5f9;
  box-shadow: 0 3px 8px rgba(0,0,0,0.1);
  transition: transform 0.2s cubic-bezier(0.34, 1.56, 0.64, 1), box-shadow 0.2s ease, border-color 0.2s ease;
}

.punch-thumb-wrap:hover {
  transform: scale(1.15);
  box-shadow: 0 10px 24px rgba(2, 132, 199, 0.35);
  border-color: #0284c7;
  z-index: 10;
}

.punch-thumb-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
  image-rendering: -webkit-optimize-contrast;
}

.punch-thumb-placeholder {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #94a3b8;
  font-size: 28px;
}

.punch-thumb-zoom-hint {
  position: absolute;
  right: 4px;
  bottom: 4px;
  background: rgba(15, 23, 42, 0.75);
  color: #ffffff;
  font-size: 11px;
  width: 22px;
  height: 22px;
  border-radius: 5px;
  display: flex;
  align-items: center;
  justify-content: center;
  pointer-events: none;
  opacity: 0.9;
  transition: opacity 0.2s, background 0.2s;
}

.punch-thumb-wrap:hover .punch-thumb-zoom-hint {
  background: #0284c7;
  opacity: 1;
}

.punch-details {
  display: flex;
  flex-direction: column;
  gap: 3px;
  font-size: 12px;
}

.punch-time-row {
  font-weight: 700;
  color: #0f172a;
  display: flex;
  align-items: center;
  gap: 6px;
}

.punch-time-badge {
  font-size: 11px;
  padding: 1px 6px;
  border-radius: 4px;
  font-weight: 700;
}
.punch-time-badge.in { background: #dcfce7; color: #15803d; }
.punch-time-badge.out { background: #fee2e2; color: #b91c1c; }

.punch-loc-row {
  font-size: 11px;
  color: #475569;
  display: flex;
  align-items: center;
  gap: 4px;
}

.punch-geo-link {
  font-size: 11px;
  font-weight: 600;
  color: #0284c7;
  text-decoration: none;
  display: inline-flex;
  align-items: center;
  gap: 3px;
}

.punch-geo-link:hover {
  text-decoration: underline;
  color: #0369a1;
}

.pending-badge {
  display: inline-flex;
  align-items: center;
  gap: 5px;
  padding: 6px 12px;
  border-radius: 8px;
  font-size: 11.5px;
  font-weight: 700;
  background: #fffbeb;
  color: #b45309;
  border: 1px dashed #f59e0b;
}

.duration-badge {
  font-weight: 700;
  font-size: 12px;
  color: #0f172a;
  background: #f1f5f9;
  padding: 4px 10px;
  border-radius: 6px;
  display: inline-block;
}

/* Lightbox Modal */
.modal-photo-dialog {
  max-width: 650px;
}

.modal-photo-content {
  border-radius: 14px;
  border: none;
  overflow: hidden;
  box-shadow: 0 10px 30px rgba(0,0,0,0.3);
}

.modal-photo-header {
  background: #072a4a;
  color: #fff;
  border: none;
  padding: 14px 20px;
}

.modal-photo-header .btn-close {
  filter: invert(1);
}

.modal-photo-body {
  padding: 0;
  background: #0b1320;
  text-align: center;
  position: relative;
}

.modal-photo-img {
  max-height: 480px;
  width: auto;
  max-width: 100%;
  object-fit: contain;
  display: block;
  margin: 0 auto;
}

.modal-photo-info {
  background: #ffffff;
  padding: 16px 20px;
  border-top: 1px solid #e2e8f0;
  text-align: left;
}

/* Print Styles */
@media print {
  .no-print, .app-sidebar, .app-header { display: none !important; }
  .photo-att-page { padding: 0 !important; background: #fff !important; }
  .report-card-wrap { border: 1px solid #000 !important; box-shadow: none !important; }
  .table-att { font-size: 10px !important; min-width: 100% !important; }
  .punch-thumb-wrap { width: 64px !important; height: 64px !important; }
  .emp-avatar { width: 36px !important; height: 36px !important; }
}
</style>

<main class="app-main">
  <div class="app-content">
    <div class="container-fluid">
      <div class="photo-att-page">

        <!-- Top Header & Filter Form -->
        <div class="filter-card no-print">
          <div class="filter-title">
            <i class="bi bi-camera-fill text-primary"></i>
            Photo Attendance Filters & Control Panel
          </div>

          <form method="GET" action="photo_attendance.php" class="filter-grid" id="photoAttFilterForm">
            <div class="filter-group">
              <label for="from_date"><i class="bi bi-calendar3 me-1"></i>From Date</label>
              <input type="date" id="from_date" name="from_date" class="filter-input" value="<?= htmlspecialchars($selectedFromDate) ?>" required>
            </div>

            <div class="filter-group">
              <label for="to_date"><i class="bi bi-calendar3 me-1"></i>To Date</label>
              <input type="date" id="to_date" name="to_date" class="filter-input" value="<?= htmlspecialchars($selectedToDate) ?>" required>
            </div>

            <div class="filter-group">
              <label for="shift"><i class="bi bi-clock-history me-1"></i>Shift</label>
              <select id="shift" name="shift" class="filter-select">
                <option value="">All Shifts</option>
                <?php foreach ($allShifts as $s): ?>
                  <option value="<?= htmlspecialchars($s) ?>" <?= ($selectedShift === $s) ? 'selected' : '' ?>>
                    <?= htmlspecialchars($s) ?>
                  </option>
                <?php endforeach; ?>
              </select>
            </div>

            <div class="filter-group">
              <label for="process"><i class="bi bi-gear-wide-connected me-1"></i>Process</label>
              <select id="process" name="process" class="filter-select">
                <option value="">All Processes</option>
                <?php foreach ($allProcesses as $pr): ?>
                  <option value="<?= htmlspecialchars($pr) ?>" <?= ($selectedProcess === $pr) ? 'selected' : '' ?>>
                    <?= htmlspecialchars($pr) ?>
                  </option>
                <?php endforeach; ?>
              </select>
            </div>

            <div class="filter-group" style="flex: 1; min-width: 220px;">
              <label for="search"><i class="bi bi-search me-1"></i>Search</label>
              <input type="text" id="search" name="search" class="filter-input" placeholder="Search Emp ID, Name, Location..." value="<?= htmlspecialchars($searchQuery) ?>">
            </div>

            <div class="filter-group" style="flex-direction: row; gap: 8px;">
              <button type="submit" class="btn-filter-go">
                <i class="bi bi-funnel-fill"></i> Apply Filter
              </button>
              <a href="photo_attendance.php" class="btn-filter-reset" title="Reset Filters">
                <i class="bi bi-arrow-counterclockwise"></i> Reset
              </a>
              <a href="?<?= http_build_query(array_merge($_GET, ['export' => 'excel'])) ?>" onclick="event.preventDefault(); exportCurrentFiltersToExcel();" class="btn-export-excel" title="Export Current Filtered Records to Excel">
                <i class="bi bi-file-earmark-excel-fill"></i> Export Excel
              </a>
              <a href="photo-attendance-summary.php?month=<?= date('m', strtotime($selectedFromDate)) ?>&year=<?= date('Y', strtotime($selectedFromDate)) ?>" class="btn-filter-reset" style="background:#0284c7; color:#fff; border-color:#0284c7;" title="View Monthly Summary">
                <i class="bi bi-calendar-month-fill"></i> Monthly Summary
              </a>
            </div>

            <button type="button" class="btn-print-action" onclick="window.print()">
              <i class="bi bi-printer-fill"></i> Print Report
            </button>
          </form>
        </div>

        <!-- KPI Metrics Deck -->
        <div class="kpi-deck no-print">
          <div class="kpi-card">
            <div class="kpi-icon-wrap kpi-icon-blue">
              <i class="bi bi-people-fill"></i>
            </div>
            <div class="kpi-meta">
              <div class="kpi-label">Total Logs</div>
              <div class="kpi-value"><?= number_format($totalRecords) ?></div>
            </div>
          </div>

          <div class="kpi-card">
            <div class="kpi-icon-wrap kpi-icon-green">
              <i class="bi bi-box-arrow-in-right"></i>
            </div>
            <div class="kpi-meta">
              <div class="kpi-label">Punched IN</div>
              <div class="kpi-value"><?= number_format($totalIn) ?></div>
            </div>
          </div>

          <div class="kpi-card">
            <div class="kpi-icon-wrap kpi-icon-purple">
              <i class="bi bi-box-arrow-right"></i>
            </div>
            <div class="kpi-meta">
              <div class="kpi-label">Punched OUT</div>
              <div class="kpi-value"><?= number_format($totalOut) ?></div>
            </div>
          </div>

          <div class="kpi-card">
            <div class="kpi-icon-wrap kpi-icon-amber">
              <i class="bi bi-hourglass-split"></i>
            </div>
            <div class="kpi-meta">
              <div class="kpi-label">Currently On Duty</div>
              <div class="kpi-value"><?= number_format($pendingOut) ?></div>
            </div>
          </div>
        </div>

        <!-- Main Report Table Card -->
        <div class="report-card-wrap">
          <div class="report-header-banner">
            <div>
              <h2 class="banner-title">
                <i class="bi bi-camera-reels-fill text-info"></i>
                Photo Attendance & Geo-Location Verification Report
              </h2>
              <div class="banner-sub">
                Station: <strong><?= htmlspecialchars($stationName ?? 'Coaching Depot') ?></strong> &bull;
                Date Range: <strong><?= date('d-m-Y', strtotime($selectedFromDate)) ?></strong>
                <?php if ($selectedFromDate !== $selectedToDate): ?>
                  to <strong><?= date('d-m-Y', strtotime($selectedToDate)) ?></strong>
                <?php endif; ?>
                &bull; Total Staff Logged: <strong><?= $totalRecords ?></strong>
              </div>
            </div>
            <div class="d-flex align-items-center gap-2 flex-wrap">
              <a href="?<?= http_build_query(array_merge($_GET, ['export' => 'excel'])) ?>" onclick="event.preventDefault(); exportCurrentFiltersToExcel();" class="btn-export-excel" style="height: 34px; padding: 0 14px; font-size: 12px;" title="Export Current Filtered Records to Excel">
                <i class="bi bi-file-earmark-excel-fill"></i> Export Excel
              </a>
              <span class="badge bg-light text-dark px-3 py-2 fw-bold" style="font-size: 13px; border-radius: 8px;">
                <i class="bi bi-clock me-1 text-primary"></i> Live Verified Logs
              </span>
            </div>
          </div>

          <div class="table-responsive-custom">
            <table class="table-att">
              <thead>
                <!-- Group Headers -->
                <tr class="group-head">
                  <th style="width: 45px;">#</th>
                  <th style="width: 110px;">Emp ID</th>
                  <th style="width: 190px; text-align: left; padding-left: 16px;">Employee Info</th>
                  <th style="width: 130px;">Designation</th>
                  <th style="width: 100px;">Shift</th>
                  <th class="th-in-head" colspan="1" style="min-width: 380px;">
                    <i class="bi bi-box-arrow-in-right me-1 text-info"></i> PUNCH IN (Photo & Location)
                  </th>
                  <th class="th-out-head" colspan="1" style="min-width: 380px;">
                    <i class="bi bi-box-arrow-right me-1 text-warning"></i> PUNCH OUT (Photo & Location)
                  </th>
                  <th style="width: 110px;">Work Duration</th>
                  <th style="width: 140px;">Process</th>
                </tr>
              </thead>
              <tbody>
                <?php if (empty($attendanceLogs)): ?>
                  <tr>
                    <td colspan="9" style="padding: 40px; text-align: center; color: #64748b; font-size: 14px;">
                      <i class="bi bi-info-circle fs-3 text-muted d-block mb-2"></i>
                      No photo attendance records found for the selected date range and filters.
                    </td>
                  </tr>
                <?php else: ?>
                  <?php 
                  $serial = 1;
                  foreach ($attendanceLogs as $row): 
                      // Calculate shift duration
                      $durationDisplay = '-';
                      if (!empty($row['in_time']) && !empty($row['out_time'])) {
                          $inTs = strtotime($row['in_time']);
                          $outTs = strtotime($row['out_time']);
                          if ($outTs > $inTs) {
                              $diff = $outTs - $inTs;
                              $hrs = floor($diff / 3600);
                              $mins = floor(($diff % 3600) / 60);
                              $durationDisplay = "{$hrs}h {$mins}m";
                          }
                      } elseif (!empty($row['in_time'])) {
                          $durationDisplay = '<span class="text-primary fw-semibold"><i class="bi bi-play-circle-fill me-1"></i>Active</span>';
                      }

                      // Shift class
                      $shiftClass = 's1';
                      if (stripos($row['shift'], '2') !== false) $shiftClass = 's2';
                      elseif (stripos($row['shift'], '3') !== false) $shiftClass = 's3';

                      // Helper to resolve root-relative paths for images
                      if (!function_exists('resolvePhotoAttendanceUrl')) {
                          function resolvePhotoAttendanceUrl($path) {
                              if (empty($path)) return '';
                              $path = trim($path);
                              if (preg_match('/^https?:\/\//i', $path) || strpos($path, '/') === 0 || strpos($path, '../') === 0) {
                                  return $path;
                              }
                              return '../' . ltrim($path, '/');
                          }
                      }

                      // Determine photo URLs or fallbacks
                      $inPhotoUrl = !empty($row['in_photo']) ? htmlspecialchars(resolvePhotoAttendanceUrl($row['in_photo'])) : '';
                      $outPhotoUrl = !empty($row['out_photo']) ? htmlspecialchars(resolvePhotoAttendanceUrl($row['out_photo'])) : '';
                      $empAvatarUrl = !empty($row['master_photo']) ? htmlspecialchars(resolvePhotoAttendanceUrl($row['master_photo'])) : '';
                  ?>
                    <tr>
                      <!-- S.No -->
                      <td><?= $serial++ ?></td>

                      <!-- Employee ID -->
                      <td>
                        <span class="emp-id-badge"><?= htmlspecialchars($row['employee_id']) ?></span>
                      </td>

                      <!-- Employee Info (Avatar + Name) -->
                      <td>
                        <div class="emp-info-cell">
                          <?php if (!empty($empAvatarUrl)): ?>
                            <img src="<?= $empAvatarUrl ?>" alt="Avatar" class="emp-avatar">
                          <?php else: ?>
                            <div class="emp-avatar">
                              <?= strtoupper(substr($row['employee_name'], 0, 1)) ?>
                            </div>
                          <?php endif; ?>
                          <div>
                            <div class="emp-name-text"><?= htmlspecialchars($row['employee_name']) ?></div>
                            <div class="emp-desig-text"><?= htmlspecialchars($row['attendance_date']) ?></div>
                          </div>
                        </div>
                      </td>

                      <!-- Designation -->
                      <td>
                        <span class="fw-semibold text-secondary"><?= htmlspecialchars($row['designation']) ?></span>
                      </td>

                      <!-- Shift -->
                      <td>
                        <span class="shift-pill <?= $shiftClass ?>">
                          <?= htmlspecialchars($row['shift']) ?>
                        </span>
                      </td>

                      <!-- PUNCH IN Details -->
                      <td class="border-left-in">
                        <?php if (!empty($row['in_time'])): ?>
                          <div class="punch-block">
                            <!-- In Photo Thumbnail -->
                            <div class="punch-thumb-wrap" 
                                 onclick="openPhotoModal('<?= !empty($inPhotoUrl) ? $inPhotoUrl : '' ?>', '<?= htmlspecialchars(addslashes($row['employee_name'])) ?>', 'PUNCH IN', '<?= date('d-M-Y H:i:s', strtotime($row['in_time'])) ?>', '<?= htmlspecialchars(addslashes($row['in_location'] ?? 'Coaching Depot Yard')) ?>', '<?= $row['in_lat'] ?>', '<?= $row['in_long'] ?>')"
                                 title="Click to zoom IN photo">
                              <?php if (!empty($inPhotoUrl)): ?>
                                <img src="<?= $inPhotoUrl ?>" class="punch-thumb-img" alt="IN Photo" onerror="this.onerror=null; this.src='data:image/svg+xml,<svg xmlns=\'http://www.w3.org/2000/svg\' width=\'90\' height=\'90\' fill=\'%230284c7\' viewBox=\'0 0 16 16\'><path d=\'M10.5 8.5a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z\'/><path d=\'M2 4a2 2 0 0 0-2 2v6a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2h-1.172a2 2 0 0 1-1.414-.586l-.828-.828A2 2 0 0 0 9.172 2H6.828a2 2 0 0 0-1.414.586l-.828.828A2 2 0 0 1 3.172 4H2zm.5 2a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1zm9 2.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0z\'/></svg>'">
                              <?php else: ?>
                                <div class="punch-thumb-placeholder">
                                  <i class="bi bi-camera"></i>
                                </div>
                              <?php endif; ?>
                              <span class="punch-thumb-zoom-hint"><i class="bi bi-zoom-in"></i></span>
                            </div>

                            <!-- In Info -->
                            <div class="punch-details">
                              <div class="punch-time-row">
                                <span class="punch-time-badge in">IN</span>
                                <span><?= date('d-M-Y H:i:s', strtotime($row['in_time'])) ?></span>
                              </div>
                              <div class="punch-loc-row">
                                <i class="bi bi-geo-alt-fill text-danger"></i>
                                <span><?= htmlspecialchars($row['in_location'] ?? 'Depot Area') ?></span>
                              </div>
                              <?php if (!empty($row['in_lat']) && !empty($row['in_long'])): ?>
                                <div>
                                  <a href="https://maps.google.com/?q=<?= $row['in_lat'] ?>,<?= $row['in_long'] ?>" target="_blank" class="punch-geo-link">
                                    <i class="bi bi-pin-map-fill"></i>
                                    <?= number_format($row['in_lat'], 4) ?>, <?= number_format($row['in_long'], 4) ?>
                                    <i class="bi bi-box-arrow-up-right" style="font-size: 10px;"></i>
                                  </a>
                                </div>
                              <?php endif; ?>
                            </div>
                          </div>
                        <?php else: ?>
                          <span class="text-muted fst-italic">No IN Record</span>
                        <?php endif; ?>
                      </td>

                      <!-- PUNCH OUT Details -->
                      <td class="border-left-out">
                        <?php if (!empty($row['out_time'])): ?>
                          <div class="punch-block">
                            <!-- Out Photo Thumbnail -->
                            <div class="punch-thumb-wrap" 
                                 onclick="openPhotoModal('<?= !empty($outPhotoUrl) ? $outPhotoUrl : '' ?>', '<?= htmlspecialchars(addslashes($row['employee_name'])) ?>', 'PUNCH OUT', '<?= date('d-M-Y H:i:s', strtotime($row['out_time'])) ?>', '<?= htmlspecialchars(addslashes($row['out_location'] ?? 'Coaching Depot Yard')) ?>', '<?= $row['out_lat'] ?>', '<?= $row['out_long'] ?>')"
                                 title="Click to zoom OUT photo">
                              <?php if (!empty($outPhotoUrl)): ?>
                                <img src="<?= $outPhotoUrl ?>" class="punch-thumb-img" alt="OUT Photo" onerror="this.onerror=null; this.src='data:image/svg+xml,<svg xmlns=\'http://www.w3.org/2000/svg\' width=\'90\' height=\'90\' fill=\'%23b45309\' viewBox=\'0 0 16 16\'><path d=\'M10.5 8.5a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z\'/><path d=\'M2 4a2 2 0 0 0-2 2v6a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2h-1.172a2 2 0 0 1-1.414-.586l-.828-.828A2 2 0 0 0 9.172 2H6.828a2 2 0 0 0-1.414.586l-.828.828A2 2 0 0 1 3.172 4H2zm.5 2a.5.5 0 1 1 0-1 .5.5 0 0 1 0 1zm9 2.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0z\'/></svg>'">
                              <?php else: ?>
                                <div class="punch-thumb-placeholder">
                                  <i class="bi bi-camera"></i>
                                </div>
                              <?php endif; ?>
                              <span class="punch-thumb-zoom-hint"><i class="bi bi-zoom-in"></i></span>
                            </div>

                            <!-- Out Info -->
                            <div class="punch-details">
                              <div class="punch-time-row">
                                <span class="punch-time-badge out">OUT</span>
                                <span><?= date('d-M-Y H:i:s', strtotime($row['out_time'])) ?></span>
                              </div>
                              <div class="punch-loc-row">
                                <i class="bi bi-geo-alt-fill text-danger"></i>
                                <span><?= htmlspecialchars($row['out_location'] ?? 'Depot Area') ?></span>
                              </div>
                              <?php if (!empty($row['out_lat']) && !empty($row['out_long'])): ?>
                                <div>
                                  <a href="https://maps.google.com/?q=<?= $row['out_lat'] ?>,<?= $row['out_long'] ?>" target="_blank" class="punch-geo-link">
                                    <i class="bi bi-pin-map-fill"></i>
                                    <?= number_format($row['out_lat'], 4) ?>, <?= number_format($row['out_long'], 4) ?>
                                    <i class="bi bi-box-arrow-up-right" style="font-size: 10px;"></i>
                                  </a>
                                </div>
                              <?php endif; ?>
                            </div>
                          </div>
                        <?php else: ?>
                          <span class="pending-badge">
                            <i class="bi bi-clock-history"></i> Pending Out
                          </span>
                        <?php endif; ?>
                      </td>

                      <!-- Total Work Duration -->
                      <td>
                        <span class="duration-badge"><?= $durationDisplay ?></span>
                      </td>

                      <!-- Process -->
                      <td>
                        <?php
                        $proc = $row['process'] ?? 'Normal Cleaning';
                        $procBadgeClass = 'bg-primary-subtle text-primary border-primary-subtle';
                        $procIcon = 'bi-check-circle-fill';
                        if (stripos($proc, 'normal') !== false) {
                            $procBadgeClass = 'bg-primary-subtle text-primary border-primary-subtle';
                            $procIcon = 'bi-brush-fill';
                        } elseif (stripos($proc, 'pit') !== false) {
                            $procBadgeClass = 'bg-info-subtle text-info-emphasis border-info-subtle';
                            $procIcon = 'bi-tools';
                        } elseif (stripos($proc, 'intensive') !== false) {
                            $procBadgeClass = 'bg-warning-subtle text-warning-emphasis border-warning-subtle';
                            $procIcon = 'bi-stars';
                        } elseif (stripos($proc, 'platform') !== false || stripos($proc, 'prt') !== false) {
                            $procBadgeClass = 'bg-success-subtle text-success border-success-subtle';
                            $procIcon = 'bi-train-front-fill';
                        }
                        ?>
                        <span class="badge <?= $procBadgeClass ?> border px-2 py-1 fw-bold" style="font-size: 11.5px; white-space: nowrap;">
                          <i class="bi <?= $procIcon ?> me-1"></i><?= htmlspecialchars($proc) ?>
                        </span>
                      </td>
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
</main>

<!-- Lightbox Modal for Photo & Geolocation View -->
<div class="modal fade" id="photoViewModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-photo-dialog">
    <div class="modal-content modal-photo-content">
      <div class="modal-photo-header d-flex justify-content-between align-items-center">
        <h5 class="modal-title fs-6 fw-bold mb-0 text-white" id="modalPunchTitle">
          <i class="bi bi-camera-fill me-2 text-info"></i>Attendance Verification Photo
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-photo-body">
        <img src="" id="modalImgTag" class="modal-photo-img" alt="Punch Photo">
      </div>

      <div class="modal-photo-info">
        <div class="row g-2 align-items-center">
          <div class="col-sm-7">
            <h6 class="fw-bold text-dark mb-1" id="modalEmpNameDisplay">-</h6>
            <div class="small text-muted mb-1" id="modalPunchTimeDisplay">
              <i class="bi bi-clock me-1 text-primary"></i> <span>-</span>
            </div>
            <div class="small text-muted" id="modalPunchLocDisplay">
              <i class="bi bi-geo-alt-fill me-1 text-danger"></i> <span>-</span>
            </div>
          </div>
          <div class="col-sm-5 text-sm-end mt-2 mt-sm-0">
            <a href="#" id="modalMapLinkBtn" target="_blank" class="btn btn-sm btn-outline-primary fw-semibold">
              <i class="bi bi-pin-map-fill me-1"></i> Open Google Map
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
function openPhotoModal(imgUrl, empName, punchType, timeStr, locationStr, lat, lng) {
  var modalEl = document.getElementById('photoViewModal');
  var imgTag = document.getElementById('modalImgTag');
  var titleEl = document.getElementById('modalPunchTitle');
  var empNameEl = document.getElementById('modalEmpNameDisplay');
  var timeEl = document.getElementById('modalPunchTimeDisplay');
  var locEl = document.getElementById('modalPunchLocDisplay');
  var mapBtn = document.getElementById('modalMapLinkBtn');

  // Fallback SVG if image not present
  if (!imgUrl) {
    imgTag.src = 'data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" width="400" height="300" viewBox="0 0 400 300"><rect width="100%" height="100%" fill="%230f172a"/><circle cx="200" cy="120" r="50" fill="%23334155"/><path d="M120 250 c0 -60 160 -60 160 0" fill="%23334155"/><text x="50%" y="280" font-family="Arial" font-size="16" fill="%2394a3b8" text-anchor="middle">Verification Snapshot Captured</text></svg>';
  } else {
    imgTag.src = imgUrl;
  }

  titleEl.innerHTML = '<i class="bi bi-camera-fill me-2 text-info"></i>' + punchType + ' Verification Snapshot';
  empNameEl.innerText = empName;
  timeEl.innerHTML = '<i class="bi bi-clock me-1 text-primary"></i> <strong>' + punchType + ' Time:</strong> ' + timeStr;
  locEl.innerHTML = '<i class="bi bi-geo-alt-fill me-1 text-danger"></i> <strong>Location:</strong> ' + locationStr;

  if (lat && lng && lat !== 'null' && lng !== 'null') {
    mapBtn.href = 'https://maps.google.com/?q=' + lat + ',' + lng;
    mapBtn.style.display = 'inline-flex';
  } else {
    mapBtn.style.display = 'none';
  }

  var myModal = new bootstrap.Modal(modalEl);
  myModal.show();
}

function exportCurrentFiltersToExcel() {
  var form = document.getElementById('photoAttFilterForm');
  var params;
  if (form) {
    params = new URLSearchParams(new FormData(form));
  } else {
    params = new URLSearchParams(window.location.search);
  }
  params.set('export', 'excel');
  window.location.href = 'photo_attendance.php?' + params.toString();
}
</script>

<?php include 'footer.php'; ?>
