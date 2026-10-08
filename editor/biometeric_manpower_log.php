<?php
/**
 * Editor Dashboard - Biometric Attendance Logs & Manpower Editor
 * Allows the Editor to view, filter, add, edit, and delete raw punch logs from `attendance_logs`.
 */
require_once 'auth.php';
global $pdo;

$pageTitle = 'Biometric Attendance Logs & Manpower Editor | MCC Editor';
$flashSuccess = '';
$flashError = '';

// Handle POST actions: Add, Edit, Delete attendance logs
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    if ($action === 'edit_log') {
        $logId = intval($_POST['log_id'] ?? 0);
        $empCode = trim($_POST['employee_code'] ?? '');
        $empName = trim($_POST['employee_name'] ?? '');
        $punchTime = trim($_POST['punch_time'] ?? '');
        $direction = trim($_POST['direction'] ?? '0');
        $deviceName = trim($_POST['device_name'] ?? 'coaching');
        $verMode = trim($_POST['verification_mode'] ?? 'Fingerprint');

        if ($logId > 0 && !empty($empCode) && !empty($punchTime)) {
            try {
                // Format punch_time properly (supports Y-m-d\TH:i and Y-m-d H:i:s)
                $formattedPunchTime = date('Y-m-d H:i:s', strtotime($punchTime));

                $updStmt = $pdo->prepare("
                    UPDATE attendance_logs 
                    SET employee_code = :emp_code,
                        employee_name = :emp_name,
                        punch_time = :punch_time,
                        direction = :direction,
                        device_name = :device_name,
                        verification_mode = :ver_mode
                    WHERE id = :id
                ");
                $updStmt->execute([
                    'emp_code' => $empCode,
                    'emp_name' => $empName,
                    'punch_time' => $formattedPunchTime,
                    'direction' => $direction,
                    'device_name' => $deviceName,
                    'ver_mode' => $verMode,
                    'id' => $logId
                ]);

                $flashSuccess = "Attendance log entry #{$logId} for Employee [{$empCode} - {$empName}] updated successfully!";
            } catch (Exception $e) {
                $flashError = "Failed to update attendance log: " . $e->getMessage();
            }
        } else {
            $flashError = "Please fill in all required fields (Employee ID, Punch Date & Time).";
        }
    } elseif ($action === 'add_log') {
        $empCode = trim($_POST['employee_code'] ?? '');
        $empName = trim($_POST['employee_name'] ?? '');
        $punchTime = trim($_POST['punch_time'] ?? '');
        $direction = trim($_POST['direction'] ?? '0');
        $deviceName = trim($_POST['device_name'] ?? 'coaching');
        $verMode = trim($_POST['verification_mode'] ?? 'Manual');

        if (!empty($empCode) && !empty($punchTime)) {
            try {
                $formattedPunchTime = date('Y-m-d H:i:s', strtotime($punchTime));

                $insStmt = $pdo->prepare("
                    INSERT INTO attendance_logs (employee_code, employee_name, punch_time, direction, device_name, verification_mode, device_id)
                    VALUES (:emp_code, :emp_name, :punch_time, :direction, :device_name, :ver_mode, :device_id)
                ");
                $insStmt->execute([
                    'emp_code' => $empCode,
                    'emp_name' => $empName,
                    'punch_time' => $formattedPunchTime,
                    'direction' => $direction,
                    'device_name' => $deviceName,
                    'ver_mode' => $verMode,
                    'device_id' => 'DEV_' . strtoupper(substr(preg_replace('/[^a-zA-Z0-9]/', '', $deviceName), 0, 8))
                ]);

                $newId = $pdo->lastInsertId();
                $flashSuccess = "New attendance log entry #{$newId} for [{$empCode} - {$empName}] created successfully!";
            } catch (Exception $e) {
                $flashError = "Failed to add attendance log: " . $e->getMessage();
            }
        } else {
            $flashError = "Please provide Employee ID and Punch Date/Time.";
        }
    } elseif ($action === 'delete_log') {
        $logId = intval($_POST['log_id'] ?? 0);
        if ($logId > 0) {
            try {
                $delStmt = $pdo->prepare("DELETE FROM attendance_logs WHERE id = :id");
                $delStmt->execute(['id' => $logId]);
                $flashSuccess = "Attendance log entry #{$logId} was deleted successfully.";
            } catch (Exception $e) {
                $flashError = "Failed to delete log entry: " . $e->getMessage();
            }
        }
    }
}

// Date & Filter Handling
$fromDate = isset($_GET['from_date']) && !empty($_GET['from_date']) ? $_GET['from_date'] : date('Y-m-d', strtotime('-6 days'));
$toDate = isset($_GET['to_date']) && !empty($_GET['to_date']) ? $_GET['to_date'] : date('Y-m-d');
$filterDevice = trim($_GET['device_name'] ?? '');
$filterSearch = trim($_GET['search'] ?? '');
$filterDirection = isset($_GET['direction']) && $_GET['direction'] !== '' ? trim($_GET['direction']) : '';

// Validation
if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $fromDate)) {
    $fromDate = date('Y-m-d', strtotime('-6 days'));
}
if (!preg_match('/^\d{4}-\d{2}-\d{2}$/', $toDate)) {
    $toDate = date('Y-m-d');
}
if ($fromDate > $toDate) {
    $temp = $fromDate;
    $fromDate = $toDate;
    $toDate = $temp;
}

$startQuery = $fromDate . ' 00:00:00';
$endQuery = $toDate . ' 23:59:59';

// Build Query for attendance_logs
$sql = "
    SELECT 
        a.id,
        a.employee_code,
        a.employee_name,
        COALESCE(e.full_name, a.employee_name) AS full_name_resolved,
        e.designation,
        a.punch_time,
        a.direction,
        a.device_id,
        a.device_name,
        a.verification_mode,
        a.created_at
    FROM attendance_logs a
    LEFT JOIN mcc_employee e ON a.employee_code = e.employee_id
    WHERE a.punch_time BETWEEN :start_time AND :end_time
";
$params = [
    'start_time' => $startQuery,
    'end_time' => $endQuery
];

if ($filterDevice !== '') {
    $sql .= " AND a.device_name LIKE :device_name";
    $params['device_name'] = '%' . $filterDevice . '%';
}

if ($filterDirection !== '') {
    $sql .= " AND a.direction = :direction";
    $params['direction'] = $filterDirection;
}

if ($filterSearch !== '') {
    $sql .= " AND (a.employee_code LIKE :q OR a.employee_name LIKE :q OR e.full_name LIKE :q OR a.device_name LIKE :q)";
    $params['q'] = '%' . $filterSearch . '%';
}

$sql .= " ORDER BY a.punch_time DESC, a.id DESC";

$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$logs = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Metrics calculation
$totalLogs = count($logs);
$uniqueEmployees = [];
$inCount = 0;
$outCount = 0;

foreach ($logs as $l) {
    $uniqueEmployees[$l['employee_code']] = true;
    $dirStr = strtolower(trim((string)$l['direction']));
    if ($dirStr === '0' || $dirStr === 'in' || $dirStr === 'checkin') {
        $inCount++;
    } else {
        $outCount++;
    }
}
$distinctEmpCount = count($uniqueEmployees);

// Fetch active employees for autocomplete dropdown
$empListStmt = $pdo->query("SELECT employee_id, full_name, designation FROM mcc_employee ORDER BY full_name ASC");
$allEmployees = $empListStmt ? $empListStmt->fetchAll(PDO::FETCH_ASSOC) : [];

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
  <!-- Content Header -->
  <div class="app-content-header py-3 mb-3 border-bottom bg-white shadow-sm">
    <div class="container-fluid">
      <div class="row align-items-center">
        <div class="col-md-7">
          <h3 class="mb-0 fw-bold text-dark d-flex align-items-center">
            <i class="bi bi-fingerprint text-primary me-2 fs-3"></i>
            Biometric Attendance Logs &amp; Manpower Entry
          </h3>
          <span class="text-muted small">
            Location: <strong><?= htmlspecialchars($stationName) ?></strong> &bull; Edit, modify timestamps, and manage punch records
          </span>
        </div>
        <div class="col-md-5 text-md-end mt-2 mt-md-0">
          <button type="button" class="btn btn-primary px-3 fw-bold shadow-sm" data-bs-toggle="modal" data-bs-target="#addLogModal">
            <i class="bi bi-plus-circle me-1"></i> Add Punch Entry
          </button>
          <button type="button" class="btn btn-outline-dark px-3 fw-bold ms-1" onclick="window.print()">
            <i class="bi bi-printer-fill me-1"></i> Print
          </button>
        </div>
      </div>
    </div>
  </div>

  <!-- Content Body -->
  <div class="app-content">
    <div class="container-fluid">

      <!-- Alert Messages -->
      <?php if (!empty($flashSuccess)): ?>
        <div class="alert alert-success alert-dismissible fade show rounded-3 shadow-sm mb-3 no-print" role="alert">
          <i class="bi bi-check-circle-fill me-2 fs-5"></i>
          <strong>Success:</strong> <?= htmlspecialchars($flashSuccess) ?>
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      <?php endif; ?>

      <?php if (!empty($flashError)): ?>
        <div class="alert alert-danger alert-dismissible fade show rounded-3 shadow-sm mb-3 no-print" role="alert">
          <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
          <strong>Error:</strong> <?= htmlspecialchars($flashError) ?>
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      <?php endif; ?>



      <!-- Filter Card Toolbar -->
      <div class="card border-0 shadow-sm rounded-3 bg-white mb-4 no-print">
        <div class="card-body p-3">
          <form method="GET" action="biometeric_manpower_log.php" class="row g-2 align-items-end">
            <div class="col-md-2 col-sm-6">
              <label class="form-label small fw-bold text-secondary mb-1">From Date:</label>
              <input type="date" name="from_date" class="form-control form-control-sm" value="<?= htmlspecialchars($fromDate) ?>" required>
            </div>

            <div class="col-md-2 col-sm-6">
              <label class="form-label small fw-bold text-secondary mb-1">To Date:</label>
              <input type="date" name="to_date" class="form-control form-control-sm" value="<?= htmlspecialchars($toDate) ?>" required>
            </div>

            <div class="col-md-2 col-sm-6">
              <label class="form-label small fw-bold text-secondary mb-1">Area / Device:</label>
              <select name="device_name" class="form-select form-select-sm">
                <option value="">-- All Areas --</option>
                <option value="coaching" <?= $filterDevice === 'coaching' ? 'selected' : '' ?>>Coaching Depot</option>
                <option value="prt" <?= $filterDevice === 'prt' ? 'selected' : '' ?>>Platform Return (PRT)</option>
                <option value="vb" <?= $filterDevice === 'vb' ? 'selected' : '' ?>>Vande Bharat</option>
              </select>
            </div>

            <div class="col-md-2 col-sm-6">
              <label class="form-label small fw-bold text-secondary mb-1">Punch Direction:</label>
              <select name="direction" class="form-select form-select-sm">
                <option value="">-- All (IN &amp; OUT) --</option>
                <option value="0" <?= $filterDirection === '0' ? 'selected' : '' ?>>IN (Login)</option>
                <option value="1" <?= $filterDirection === '1' ? 'selected' : '' ?>>OUT (Logout)</option>
              </select>
            </div>

            <div class="col-md-2 col-sm-8">
              <label class="form-label small fw-bold text-secondary mb-1">Search Staff / ID:</label>
              <input type="text" name="search" class="form-control form-control-sm" placeholder="Search by name, ID..." value="<?= htmlspecialchars($filterSearch) ?>">
            </div>

            <div class="col-md-2 col-sm-4 d-flex gap-2">
              <button type="submit" class="btn btn-primary btn-sm w-100 fw-bold">
                <i class="bi bi-funnel-fill me-1"></i> Filter
              </button>
              <a href="biometeric_manpower_log.php" class="btn btn-outline-secondary btn-sm" title="Reset Filters">
                <i class="bi bi-arrow-counterclockwise"></i>
              </a>
            </div>
          </form>
        </div>
      </div>

      <!-- Main Logs Table -->
      <div class="card border-0 shadow-sm rounded-3 bg-white mb-4">
        <div class="card-header bg-white py-3 border-bottom d-flex align-items-center justify-content-between flex-wrap gap-2">
          <div class="d-flex align-items-center gap-2">
            <h5 class="mb-0 fw-bold text-dark">
              <i class="bi bi-table text-primary me-1"></i> Attendance Logs Records
            </h5>
            <span class="badge bg-primary-subtle text-primary rounded-pill px-3">
              Showing <?= count($logs) ?> Entries
            </span>
          </div>
          <div class="small text-muted">
            Date Window: <strong><?= date('d-M-Y', strtotime($fromDate)) ?></strong> to <strong><?= date('d-M-Y', strtotime($toDate)) ?></strong>
          </div>
        </div>

        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-hover align-middle mb-0 text-nowrap" style="font-size: 13.5px;">
              <thead class="table-dark" style="background: #07203a; border-color: #0b476a;">
                <tr>
                  <th class="ps-3 py-3" style="width: 70px;">Log ID</th>
                  <th class="py-3">Date &amp; Punch Time</th>
                  <th class="py-3">Employee ID</th>
                  <th class="py-3">Employee Name</th>
                  <th class="py-3 text-center" style="width: 110px;">Direction</th>
                  <th class="py-3">Location / Device</th>
                  <th class="py-3">Verification</th>
                  <th class="py-3 text-end pe-3 no-print" style="width: 140px;">Action</th>
                </tr>
              </thead>
              <tbody>
                <?php if (empty($logs)): ?>
                  <tr>
                    <td colspan="8" class="text-center py-5 text-muted">
                      <div class="py-4">
                        <i class="bi bi-inbox fs-1 text-secondary opacity-50 d-block mb-2"></i>
                        <h6 class="fw-bold text-secondary">No attendance logs found</h6>
                        <p class="small text-muted mb-0">Try changing the date filter range or search keywords.</p>
                      </div>
                    </td>
                  </tr>
                <?php else: ?>
                  <?php foreach ($logs as $row): 
                    $dir = strtolower(trim((string)$row['direction']));
                    $isIN = ($dir === '0' || $dir === 'in' || $dir === 'checkin');
                    $displayName = !empty($row['full_name_resolved']) ? $row['full_name_resolved'] : (!empty($row['employee_name']) ? $row['employee_name'] : $row['employee_code']);
                    $punchFormatted = date('d-M-Y H:i:s', strtotime($row['punch_time']));
                    $punchTimeOnly = date('h:i:s A', strtotime($row['punch_time']));
                    $punchDateOnly = date('d-M-Y', strtotime($row['punch_time']));
                  ?>
                    <tr>
                      <td class="ps-3 fw-bold text-muted">#<?= $row['id'] ?></td>
                      <td>
                        <div class="d-flex align-items-center gap-2">
                          <span class="badge bg-light text-dark border px-2 py-1">
                            <i class="bi bi-calendar3 me-1 text-primary"></i> <?= $punchDateOnly ?>
                          </span>
                          <span class="fw-bold text-dark">
                            <i class="bi bi-clock-fill text-info me-1"></i> <?= $punchTimeOnly ?>
                          </span>
                        </div>
                      </td>
                      <td>
                        <span class="badge bg-dark-subtle text-dark px-2 py-1 font-monospace fw-bold">
                          <?= htmlspecialchars($row['employee_code']) ?>
                        </span>
                      </td>
                      <td>
                        <div class="fw-bold text-dark"><?= htmlspecialchars($displayName) ?></div>
                        <?php if (!empty($row['designation'])): ?>
                          <div class="small text-muted" style="font-size: 11.5px;"><?= htmlspecialchars($row['designation']) ?></div>
                        <?php endif; ?>
                      </td>
                      <td class="text-center">
                        <?php if ($isIN): ?>
                          <span class="badge bg-success text-white px-3 py-1 rounded-pill" style="font-size: 11.5px; font-weight: 700;">
                            <i class="bi bi-box-arrow-in-right me-1"></i> IN
                          </span>
                        <?php else: ?>
                          <span class="badge bg-warning text-dark px-3 py-1 rounded-pill" style="font-size: 11.5px; font-weight: 700;">
                            <i class="bi bi-box-arrow-right me-1"></i> OUT
                          </span>
                        <?php endif; ?>
                      </td>
                      <td>
                        <span class="badge bg-secondary-subtle text-secondary px-2 py-1 text-uppercase" style="font-size: 11.5px; font-weight: 600;">
                          <i class="bi bi-hdd-network me-1"></i> <?= htmlspecialchars($row['device_name'] ?: 'coaching') ?>
                        </span>
                      </td>
                      <td>
                        <span class="small text-muted">
                          <?= htmlspecialchars($row['verification_mode'] ?: 'Fingerprint') ?>
                        </span>
                      </td>
                      <td class="text-end pe-3 no-print">
                        <button type="button" 
                                class="btn btn-sm edit-log-btn shadow-sm"
                                style="background-color: #f59e0b !important; color: #000000 !important; font-weight: 700 !important; border: 1px solid #d97706 !important; padding: 4px 12px; font-size: 12px; border-radius: 6px; display: inline-flex; align-items: center; gap: 4px;"
                                data-id="<?= $row['id'] ?>"
                                data-code="<?= htmlspecialchars($row['employee_code']) ?>"
                                data-name="<?= htmlspecialchars($row['employee_name'] ?: $displayName) ?>"
                                data-time="<?= date('Y-m-d\TH:i:s', strtotime($row['punch_time'])) ?>"
                                data-direction="<?= htmlspecialchars($row['direction']) ?>"
                                data-device="<?= htmlspecialchars($row['device_name'] ?: 'coaching') ?>"
                                data-vermode="<?= htmlspecialchars($row['verification_mode'] ?: 'Fingerprint') ?>"
                                title="Edit this punch log">
                          <i class="bi bi-pencil-square" style="color: #000000 !important; font-size: 13px;"></i> 
                          <span style="color: #000000 !important; font-weight: 700 !important;">Edit</span>
                        </button>
                        <form method="POST" action="" class="d-inline" onsubmit="return confirm('Are you sure you want to delete Attendance Log #<?= $row['id'] ?> for Employee <?= htmlspecialchars($row['employee_code']) ?>?');">
                          <input type="hidden" name="action" value="delete_log">
                          <input type="hidden" name="log_id" value="<?= $row['id'] ?>">
                          <button type="submit" 
                                  class="btn btn-sm shadow-sm" 
                                  style="background-color: #ef4444 !important; color: #ffffff !important; font-weight: 700 !important; border: 1px solid #dc2626 !important; padding: 4px 10px; font-size: 12px; border-radius: 6px; display: inline-flex; align-items: center; gap: 4px;"
                                  title="Delete log">
                            <i class="bi bi-trash-fill" style="color: #ffffff !important; font-size: 13px;"></i>
                            <span style="color: #ffffff !important; font-weight: 700 !important;">Delete</span>
                          </button>
                        </form>
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

<!-- Edit Punch Log Modal -->
<div class="modal fade" id="editLogModal" tabindex="-1" aria-labelledby="editLogModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg rounded-3">
      <div class="modal-header bg-dark text-white py-3">
        <h5 class="modal-title fw-bold" id="editLogModalLabel">
          <i class="bi bi-pencil-square text-warning me-2"></i> Edit Attendance Punch Log
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form method="POST" action="">
        <input type="hidden" name="action" value="edit_log">
        <input type="hidden" name="log_id" id="modalEditLogId">
        
        <div class="modal-body p-4">
          <div class="alert alert-info py-2 px-3 small d-flex align-items-center gap-2 mb-3">
            <i class="bi bi-info-circle-fill fs-5"></i>
            <div>Editing Log ID: <strong id="modalEditLogIdDisplay">#0</strong>. Changes will be saved directly into <code>attendance_logs</code>.</div>
          </div>

          <div class="mb-3">
            <label for="modalEditPunchTime" class="form-label small fw-bold text-secondary mb-1">
              <i class="bi bi-calendar-event me-1"></i> Punch Date &amp; Time: <span class="text-danger">*</span>
            </label>
            <input type="datetime-local" step="1" class="form-control" id="modalEditPunchTime" name="punch_time" required>
            <div class="form-text small">Select exact timestamp for the attendance punch.</div>
          </div>

          <div class="row g-2 mb-3">
            <div class="col-sm-6">
              <label for="modalEditEmpCode" class="form-label small fw-bold text-secondary mb-1">
                <i class="bi bi-person-badge me-1"></i> Employee ID / Code: <span class="text-danger">*</span>
              </label>
              <input type="text" class="form-control font-monospace fw-bold" id="modalEditEmpCode" name="employee_code" required>
            </div>
            <div class="col-sm-6">
              <label for="modalEditDirection" class="form-label small fw-bold text-secondary mb-1">
                <i class="bi bi-arrow-left-right me-1"></i> Direction (IN / OUT): <span class="text-danger">*</span>
              </label>
              <select class="form-select fw-bold" id="modalEditDirection" name="direction" required>
                <option value="0">IN (Login / Shift Start)</option>
                <option value="1">OUT (Logout / Shift End)</option>
              </select>
            </div>
          </div>

          <div class="mb-3">
            <label for="modalEditEmpName" class="form-label small fw-bold text-secondary mb-1">
              <i class="bi bi-person me-1"></i> Employee Full Name:
            </label>
            <input type="text" class="form-control" id="modalEditEmpName" name="employee_name" placeholder="e.g. Ramesh Kumar">
          </div>

          <div class="row g-2 mb-2">
            <div class="col-sm-6">
              <label for="modalEditDevice" class="form-label small fw-bold text-secondary mb-1">
                <i class="bi bi-hdd-network me-1"></i> Area / Device Name:
              </label>
              <select class="form-select" id="modalEditDevice" name="device_name">
                <option value="coaching">Coaching Depot</option>
                <option value="prt">Platform Return (PRT)</option>
                <option value="vande_bharat">Vande Bharat</option>
                <option value="pit_office">Pit &amp; Office</option>
              </select>
            </div>
            <div class="col-sm-6">
              <label for="modalEditVerMode" class="form-label small fw-bold text-secondary mb-1">
                <i class="bi bi-shield-lock me-1"></i> Verification:
              </label>
              <select class="form-select" id="modalEditVerMode" name="verification_mode">
                <option value="Fingerprint">Fingerprint</option>
                <option value="Face">Face Recognition</option>
                <option value="Card">RFID Card</option>
                <option value="Manual">Manual Entry</option>
              </select>
            </div>
          </div>
        </div>

        <div class="modal-footer bg-light py-2 px-4">
          <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-warning text-dark fw-bold px-4">
            <i class="bi bi-check2-circle me-1"></i> Save Changes
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Add New Punch Log Modal -->
<div class="modal fade" id="addLogModal" tabindex="-1" aria-labelledby="addLogModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow-lg rounded-3">
      <div class="modal-header bg-primary text-white py-3">
        <h5 class="modal-title fw-bold" id="addLogModalLabel">
          <i class="bi bi-plus-circle me-2"></i> Add New Punch Entry
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form method="POST" action="">
        <input type="hidden" name="action" value="add_log">
        
        <div class="modal-body p-4">
          <div class="mb-3">
            <label for="addPunchTime" class="form-label small fw-bold text-secondary mb-1">
              <i class="bi bi-calendar-event me-1"></i> Punch Date &amp; Time: <span class="text-danger">*</span>
            </label>
            <input type="datetime-local" step="1" class="form-control" id="addPunchTime" name="punch_time" value="<?= date('Y-m-d\TH:i:s') ?>" required>
          </div>

          <div class="row g-2 mb-3">
            <div class="col-sm-6">
              <label for="addEmpCode" class="form-label small fw-bold text-secondary mb-1">
                <i class="bi bi-person-badge me-1"></i> Employee ID: <span class="text-danger">*</span>
              </label>
              <input type="text" class="form-control font-monospace fw-bold" id="addEmpCode" name="employee_code" placeholder="e.g. DEP101" required list="employeesDatalist">
              <datalist id="employeesDatalist">
                <?php foreach ($allEmployees as $emp): ?>
                  <option value="<?= htmlspecialchars($emp['employee_id']) ?>" data-name="<?= htmlspecialchars($emp['full_name']) ?>"><?= htmlspecialchars($emp['full_name']) ?> (<?= htmlspecialchars($emp['designation']) ?>)</option>
                <?php endforeach; ?>
              </datalist>
            </div>
            <div class="col-sm-6">
              <label for="addDirection" class="form-label small fw-bold text-secondary mb-1">
                <i class="bi bi-arrow-left-right me-1"></i> Direction: <span class="text-danger">*</span>
              </label>
              <select class="form-select fw-bold" id="addDirection" name="direction" required>
                <option value="0">IN (Login / Shift Start)</option>
                <option value="1">OUT (Logout / Shift End)</option>
              </select>
            </div>
          </div>

          <div class="mb-3">
            <label for="addEmpName" class="form-label small fw-bold text-secondary mb-1">
              <i class="bi bi-person me-1"></i> Employee Name:
            </label>
            <input type="text" class="form-control" id="addEmpName" name="employee_name" placeholder="e.g. Ramesh Kumar">
          </div>

          <div class="row g-2 mb-2">
            <div class="col-sm-6">
              <label for="addDevice" class="form-label small fw-bold text-secondary mb-1">
                <i class="bi bi-hdd-network me-1"></i> Area / Device:
              </label>
              <select class="form-select" id="addDevice" name="device_name">
                <option value="coaching">Coaching Depot</option>
                <option value="prt">Platform Return (PRT)</option>
                <option value="vande_bharat">Vande Bharat</option>
                <option value="pit_office">Pit &amp; Office</option>
              </select>
            </div>
            <div class="col-sm-6">
              <label for="addVerMode" class="form-label small fw-bold text-secondary mb-1">
                <i class="bi bi-shield-lock me-1"></i> Verification Mode:
              </label>
              <select class="form-select" id="addVerMode" name="verification_mode">
                <option value="Manual" selected>Manual Entry</option>
                <option value="Fingerprint">Fingerprint</option>
                <option value="Face">Face Recognition</option>
                <option value="Card">RFID Card</option>
              </select>
            </div>
          </div>
        </div>

        <div class="modal-footer bg-light py-2 px-4">
          <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-primary fw-bold px-4">
            <i class="bi bi-check-circle me-1"></i> Create Entry
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
  // Bind click handlers for editing log modal
  const editModalEl = document.getElementById("editLogModal");
  const editModal = new bootstrap.Modal(editModalEl);

  document.querySelectorAll(".edit-log-btn").forEach(btn => {
    btn.addEventListener("click", function () {
      const logId = this.dataset.id;
      const code = this.dataset.code;
      const name = this.dataset.name;
      const time = this.dataset.time;
      const dir = this.dataset.direction;
      const dev = this.dataset.device;
      const vermode = this.dataset.vermode;

      document.getElementById("modalEditLogId").value = logId;
      document.getElementById("modalEditLogIdDisplay").innerText = "#" + logId;
      document.getElementById("modalEditEmpCode").value = code;
      document.getElementById("modalEditEmpName").value = name;
      document.getElementById("modalEditPunchTime").value = time;
      
      const dirSelect = document.getElementById("modalEditDirection");
      dirSelect.value = (dir === "1" || dir.toLowerCase() === "out") ? "1" : "0";

      const devSelect = document.getElementById("modalEditDevice");
      let devMatched = false;
      for (let i = 0; i < devSelect.options.length; i++) {
        if (devSelect.options[i].value.toLowerCase() === dev.toLowerCase() || dev.toLowerCase().includes(devSelect.options[i].value.toLowerCase())) {
          devSelect.selectedIndex = i;
          devMatched = true;
          break;
        }
      }
      if (!devMatched) {
        devSelect.value = "coaching";
      }

      document.getElementById("modalEditVerMode").value = vermode || "Fingerprint";

      editModal.show();
    });
  });

  // Auto-fill employee name when selecting employee_code in add modal
  const addEmpCodeInput = document.getElementById("addEmpCode");
  const addEmpNameInput = document.getElementById("addEmpName");
  if (addEmpCodeInput && addEmpNameInput) {
    addEmpCodeInput.addEventListener("input", function() {
      const val = this.value.trim();
      const datalist = document.getElementById("employeesDatalist");
      if (datalist) {
        const option = Array.from(datalist.options).find(opt => opt.value === val);
        if (option && option.dataset.name) {
          addEmpNameInput.value = option.dataset.name;
        }
      }
    });
  }
});
</script>

<?php include 'footer.php'; ?>