<?php
/**
 * CDO Dashboard - View & Manage Trains and Coaches
 * Lists registered trains for the station, their coach compositions, and provides management actions.
 */
require_once 'auth.php';

$message = '';
$messageType = '';

// Handle AJAX Request: Get Coach Details for a Train
if (isset($_GET['ajax']) && $_GET['ajax'] === 'get_train_coaches') {
    header('Content-Type: application/json');
    $tId = intval($_GET['train_id'] ?? 0);
    try {
        $tStmt = $pdo->prepare("
            SELECT t.*, s.station_name, d.division_name, z.zone_name 
            FROM mcc_trains t
            INNER JOIN mcc_stations s ON t.station_id = s.station_id
            INNER JOIN mcc_divisions d ON s.division_id = d.division_id
            INNER JOIN mcc_zones z ON d.zone_id = z.zone_id
            WHERE t.train_id = :id
        ");
        $tStmt->execute(['id' => $tId]);
        $trainData = $tStmt->fetch(PDO::FETCH_ASSOC);

        if (!$trainData) {
            echo json_encode(['status' => 'error', 'message' => 'Train not found.']);
            exit();
        }

        $cStmt = $pdo->prepare("SELECT * FROM mcc_coaches WHERE train_id = :id ORDER BY display_order ASC, coach_id ASC");
        $cStmt->execute(['id' => $tId]);
        $coaches = $cStmt->fetchAll(PDO::FETCH_ASSOC);

        echo json_encode([
            'status' => 'success',
            'train' => $trainData,
            'coaches' => $coaches
        ]);
        exit();
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
        exit();
    }
}

// Handle POST actions
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action'])) {
    // 1. Toggle Train Status
    if ($_POST['action'] === 'toggle_status') {
        $train_id = intval($_POST['train_id'] ?? 0);
        $current_status = $_POST['current_status'] ?? 'Active';
        $new_status = ($current_status === 'Active') ? 'Inactive' : 'Active';

        try {
            $stmt = $pdo->prepare("UPDATE mcc_trains SET status = :status WHERE train_id = :id");
            $stmt->execute(['status' => $new_status, 'id' => $train_id]);
            $message = "Train status updated to '$new_status'.";
            $messageType = 'success';
        } catch (PDOException $e) {
            $message = 'Error updating status: ' . $e->getMessage();
            $messageType = 'danger';
        }
    }

    // 2. Delete Train
    if ($_POST['action'] === 'delete_train') {
        $train_id = intval($_POST['train_id'] ?? 0);
        try {
            $stmt = $pdo->prepare("DELETE FROM mcc_trains WHERE train_id = :id");
            $stmt->execute(['id' => $train_id]);
            $message = 'Train and all associated coaches successfully deleted.';
            $messageType = 'success';
        } catch (PDOException $e) {
            $message = 'Error deleting train: ' . $e->getMessage();
            $messageType = 'danger';
        }
    }

    // 3. Update Train & Coaches
    if ($_POST['action'] === 'update_train') {
        $train_id = intval($_POST['train_id'] ?? 0);
        $train_no = strtoupper(trim($_POST['train_no'] ?? ''));
        $selected_station_id = intval($_POST['station_id'] ?? $stationId);
        $status = in_array($_POST['status'] ?? '', ['Active', 'Inactive']) ? $_POST['status'] : 'Active';

        $coach_nos = $_POST['coach_no'] ?? [];
        $coach_statuses = $_POST['coach_status'] ?? [];

        if (empty($train_no) || $selected_station_id <= 0 || $train_id <= 0) {
            $message = 'Train number and station are required.';
            $messageType = 'danger';
        } else {
            try {
                $chk = $pdo->prepare("SELECT COUNT(*) FROM mcc_trains WHERE train_no = :train_no AND station_id = :station_id AND train_id != :id");
                $chk->execute(['train_no' => $train_no, 'station_id' => $selected_station_id, 'id' => $train_id]);
                if ($chk->fetchColumn() > 0) {
                    $message = "Train number '$train_no' is already registered for this station.";
                    $messageType = 'warning';
                } else {
                    $pdo->beginTransaction();

                    $uStmt = $pdo->prepare("
                        UPDATE mcc_trains 
                        SET train_no = :train_no, station_id = :station_id, status = :status 
                        WHERE train_id = :id
                    ");
                    $uStmt->execute([
                        'train_no'   => $train_no,
                        'station_id' => $selected_station_id,
                        'status'     => $status,
                        'id'         => $train_id
                    ]);

                    $pdo->prepare("DELETE FROM mcc_coaches WHERE train_id = :id")->execute(['id' => $train_id]);

                    if (!empty($coach_nos) && is_array($coach_nos)) {
                        $cStmt = $pdo->prepare("
                            INSERT INTO mcc_coaches (train_id, coach_no, display_order, status) 
                            VALUES (:train_id, :coach_no, :display_order, :status)
                        ");

                        $seenCoaches = [];
                        $order = 1;
                        foreach ($coach_nos as $idx => $cNo) {
                            $cNoClean = strtoupper(trim($cNo));
                            if ($cNoClean === '') continue;

                            if (isset($seenCoaches[$cNoClean])) {
                                $cNoClean .= " (" . ($seenCoaches[$cNoClean] + 1) . ")";
                            }
                            $seenCoaches[$cNoClean] = ($seenCoaches[$cNoClean] ?? 0) + 1;

                            $cStat = (isset($coach_statuses[$idx]) && $coach_statuses[$idx] === 'Inactive') ? 'Inactive' : 'Active';

                            $cStmt->execute([
                                'train_id'      => $train_id,
                                'coach_no'      => $cNoClean,
                                'display_order' => $order++,
                                'status'        => $cStat
                            ]);
                        }
                    }

                    $pdo->commit();
                    $message = "Train '$train_no' and coaches updated successfully!";
                    $messageType = 'success';
                }
            } catch (Exception $e) {
                if ($pdo->inTransaction()) {
                    $pdo->rollBack();
                }
                $message = 'Error updating train & coaches: ' . $e->getMessage();
                $messageType = 'danger';
            }
        }
    }
}

// Search Filter Logic
$search = trim($_GET['search'] ?? '');
$statusFilter = trim($_GET['status'] ?? '');

$sql = "
    SELECT t.*, s.station_name, d.division_name, z.zone_name,
           COUNT(c.coach_id) as total_coaches,
           GROUP_CONCAT(c.coach_no ORDER BY c.display_order ASC SEPARATOR ', ') as coaches_list
    FROM mcc_trains t
    INNER JOIN mcc_stations s ON t.station_id = s.station_id
    INNER JOIN mcc_divisions d ON s.division_id = d.division_id
    INNER JOIN mcc_zones z ON d.zone_id = z.zone_id
    LEFT JOIN mcc_coaches c ON t.train_id = c.train_id
    WHERE t.station_id = :station_id
";
$params = ['station_id' => $stationId];

if (!empty($search)) {
    $sql .= " AND t.train_no LIKE :search";
    $params['search'] = "%$search%";
}

if (!empty($statusFilter)) {
    $sql .= " AND t.status = :status";
    $params['status'] = $statusFilter;
}

$sql .= " GROUP BY t.train_id ORDER BY t.train_no ASC";

$trains = [];
try {
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    $trains = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    // Fail silently
}

// Active stations for edit modal
$allStations = [];
try {
    $allStations = $pdo->query("SELECT station_id, station_name FROM mcc_stations WHERE status = 'Active' ORDER BY station_name ASC")->fetchAll();
} catch (Exception $e) {}

// KPI metrics
$totalTrains = count($trains);
$activeTrains = 0;
$totalCoaches = 0;
foreach ($trains as $tr) {
    if ($tr['status'] === 'Active') $activeTrains++;
    $totalCoaches += intval($tr['total_coaches']);
}

$pageTitle = 'View Trains & Coaches | MCC Dashboard';
$extraStyles = "
    .content-wrapper { padding: 15px; background: #f0f2f5; min-height: 100vh; }
    .kpi-card {
        background: #fff;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        padding: 16px;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
    }
    .search-card {
        background: #fff;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        padding: 12px;
        margin-bottom: 15px;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
    }
    .data-card {
        background: #fff;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05);
    }
    .table-header {
        background: linear-gradient(180deg, #07203a 0%, #07182c 100%);
        color: #fff;
        padding: 14px 18px;
        border-radius: 12px 12px 0 0;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .table-header h4 { margin: 0; font-weight: 700; font-size: 1.05rem; }
    .trains-table th {
        background: #f8fafc;
        color: #475569;
        font-size: 0.78rem;
        font-weight: 700;
        text-transform: uppercase;
        border-bottom: 1px solid #e2e8f0;
        padding: 12px 14px;
    }
    .trains-table td {
        padding: 12px 14px;
        font-size: 0.88rem;
        color: #334155;
    }
    .rake-tag {
        font-size: 0.8rem;
        font-weight: 700;
        padding: 6px 10px;
        border-radius: 6px;
        border: 1px solid #cbd5e1;
        background: #ffffff;
        color: #0f172a;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        box-shadow: 0 1px 2px rgba(0,0,0,0.05);
    }
";

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
  <div class="content-wrapper">

    <!-- Header Title -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-3">
      <div>
        <h4 class="mb-0 fw-bold text-dark d-flex align-items-center">
          <i class="bi bi-list-columns-reverse text-primary me-2"></i> Trains & Coach Composition
        </h4>
        <p class="text-muted small mb-0">Station: <strong><?= htmlspecialchars($stationName) ?></strong> (<?= htmlspecialchars($divisionName) ?> - <?= htmlspecialchars($railwayName) ?>)</p>
      </div>
      <div>
        <a href="create-trains.php" class="btn btn-sm btn-primary px-3 rounded-pill fw-bold" style="background: #1987C6; border-color: #1987C6;">
          <i class="bi bi-plus-lg me-1"></i> Create Train
        </a>
      </div>
    </div>

    <?php if (!empty($message)): ?>
      <div class="alert alert-<?= htmlspecialchars($messageType) ?> alert-dismissible fade show rounded-3 shadow-sm border-0 d-flex align-items-center mb-3" role="alert">
        <i class="bi <?= $messageType === 'success' ? 'bi-check-circle-fill text-success' : 'bi-exclamation-triangle-fill text-danger' ?> fs-4 me-3"></i>
        <div><?= htmlspecialchars($message) ?></div>
        <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>
    <?php endif; ?>

    <!-- KPI Cards -->
    <div class="row g-3 mb-3">
      <div class="col-md-4">
        <div class="kpi-card border-start border-4 border-primary">
          <div class="d-flex align-items-center">
            <div class="rounded-circle bg-primary bg-opacity-10 p-3 text-primary me-3">
              <i class="bi bi-train-front fs-3"></i>
            </div>
            <div>
              <span class="text-muted small text-uppercase fw-bold">Total Trains</span>
              <h3 class="mb-0 fw-bold text-dark"><?= number_format($totalTrains) ?></h3>
            </div>
          </div>
        </div>
      </div>

      <div class="col-md-4">
        <div class="kpi-card border-start border-4 border-success">
          <div class="d-flex align-items-center">
            <div class="rounded-circle bg-success bg-opacity-10 p-3 text-success me-3">
              <i class="bi bi-check-circle fs-3"></i>
            </div>
            <div>
              <span class="text-muted small text-uppercase fw-bold">Active Trains</span>
              <h3 class="mb-0 fw-bold text-success"><?= number_format($activeTrains) ?></h3>
            </div>
          </div>
        </div>
      </div>

      <div class="col-md-4">
        <div class="kpi-card border-start border-4 border-info">
          <div class="d-flex align-items-center">
            <div class="rounded-circle bg-info bg-opacity-10 p-3 text-info me-3">
              <i class="bi bi-grid-3x3-gap fs-3"></i>
            </div>
            <div>
              <span class="text-muted small text-uppercase fw-bold">Total Coaches</span>
              <h3 class="mb-0 fw-bold text-primary"><?= number_format($totalCoaches) ?></h3>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Search / Filter Box -->
    <div class="search-card">
      <form method="GET" action="view-trains.php" class="row g-2 align-items-center">
        <div class="col-md-6">
          <div class="input-group">
            <span class="input-group-text bg-light text-muted border-end-0"><i class="bi bi-search"></i></span>
            <input type="text" name="search" value="<?= htmlspecialchars($search) ?>" class="form-control border-start-0 ps-0" placeholder="Search by Train Number...">
          </div>
        </div>
        <div class="col-md-4">
          <select name="status" class="form-select" onchange="this.form.submit()">
            <option value="">All Statuses</option>
            <option value="Active" <?= ($statusFilter === 'Active') ? 'selected' : '' ?>>Active Only</option>
            <option value="Inactive" <?= ($statusFilter === 'Inactive') ? 'selected' : '' ?>>Inactive Only</option>
          </select>
        </div>
        <div class="col-md-2 d-flex gap-1">
          <button type="submit" class="btn btn-primary w-100 rounded-3" style="background: #1987C6; border-color: #1987C6;">
            <i class="bi bi-funnel me-1"></i> Filter
          </button>
          <?php if (!empty($search) || !empty($statusFilter)): ?>
            <a href="view-trains.php" class="btn btn-outline-secondary rounded-3" title="Reset Filters">
              <i class="bi bi-arrow-counterclockwise"></i>
            </a>
          <?php endif; ?>
        </div>
      </form>
    </div>

    <!-- Data Table Card -->
    <div class="data-card">
      <div class="table-header">
        <h4><i class="bi bi-train-lightrail-front me-2"></i> Registered Trains List</h4>
        <span class="badge bg-light text-dark fw-bold px-3 py-2 rounded-pill">
          <?= count($trains) ?> Train<?= count($trains) == 1 ? '' : 's' ?>
        </span>
      </div>

      <div class="table-responsive">
        <table class="table table-hover align-middle mb-0 trains-table">
          <thead>
            <tr>
              <th style="width: 70px;" class="text-center">#</th>
              <th style="width: 180px;">Train Number</th>
              <th>Rake Composition</th>
              <th style="width: 120px;" class="text-center">Status</th>
              <th style="width: 160px;" class="text-center">Actions</th>
            </tr>
          </thead>
          <tbody>
            <?php if (empty($trains)): ?>
              <tr>
                <td colspan="5" class="text-center py-5">
                  <i class="bi bi-train-front-fill text-muted" style="font-size: 2.5rem; opacity: 0.3;"></i>
                  <h6 class="text-muted mt-2 mb-1">No Trains Found</h6>
                  <p class="text-muted small mb-3">No railway trains found for the selected filter or station.</p>
                  <a href="create-trains.php" class="btn btn-sm btn-primary rounded-pill px-4" style="background: #1987C6; border-color: #1987C6;">
                    <i class="bi bi-plus-circle me-1"></i> Create First Train
                  </a>
                </td>
              </tr>
            <?php else: ?>
              <?php 
              $sl = 1;
              foreach ($trains as $tr): 
                  $coachesArr = array_filter(array_map('trim', explode(',', $tr['coaches_list'] ?? '')));
                  $previewCount = 6;
                  $previewCoaches = array_slice($coachesArr, 0, $previewCount);
                  $remainingCoaches = count($coachesArr) - count($previewCoaches);
              ?>
                <tr>
                  <td class="text-center text-muted fw-bold"><?= $sl++ ?></td>
                  <td>
                    <span class="badge bg-dark rounded-2 font-monospace fs-6 px-3 py-2">
                      <?= htmlspecialchars($tr['train_no']) ?>
                    </span>
                  </td>
                  <td>
                    <div class="d-flex align-items-center justify-content-between mb-1">
                      <span class="small fw-bold text-muted"><?= intval($tr['total_coaches']) ?> Coaches</span>
                      <button type="button" class="btn btn-link btn-sm p-0 text-decoration-none text-primary fw-bold" onclick="viewTrainDetails(<?= $tr['train_id'] ?>)">
                        View All <i class="bi bi-chevron-right small"></i>
                      </button>
                    </div>
                    <div class="d-flex flex-wrap gap-1">
                      <?php if (empty($coachesArr)): ?>
                        <span class="badge bg-light text-muted border">No coaches added</span>
                      <?php else: ?>
                        <?php foreach ($previewCoaches as $cNo): ?>
                          <span class="badge bg-light text-dark border font-monospace" style="font-size: 0.75rem;">
                            <?= htmlspecialchars($cNo) ?>
                          </span>
                        <?php endforeach; ?>
                        <?php if ($remainingCoaches > 0): ?>
                          <span class="badge bg-primary bg-opacity-10 text-primary fw-bold" style="font-size: 0.75rem;">
                            +<?= $remainingCoaches ?> more
                          </span>
                        <?php endif; ?>
                      <?php endif; ?>
                    </div>
                  </td>
                  <td class="text-center">
                    <form method="POST" action="view-trains.php" class="d-inline">
                      <input type="hidden" name="action" value="toggle_status">
                      <input type="hidden" name="train_id" value="<?= $tr['train_id'] ?>">
                      <input type="hidden" name="current_status" value="<?= $tr['status'] ?>">
                      <button type="submit" class="badge border-0 cursor-pointer <?= ($tr['status'] === 'Active') ? 'bg-success' : 'bg-secondary opacity-75' ?> rounded-pill px-3 py-2" title="Click to toggle status">
                        <i class="bi <?= ($tr['status'] === 'Active') ? 'bi-check-circle-fill' : 'bi-x-circle-fill' ?> me-1"></i>
                        <?= $tr['status'] ?>
                      </button>
                    </form>
                  </td>
                  <td class="text-center">
                    <div class="btn-group">
                      <button type="button" class="btn btn-sm btn-outline-primary rounded-start-pill px-2" title="View Coach Composition" onclick="viewTrainDetails(<?= $tr['train_id'] ?>)">
                        <i class="bi bi-eye"></i>
                      </button>
                      <button type="button" class="btn btn-sm btn-outline-secondary px-2" title="Edit Train & Coaches" onclick="openEditTrainModal(<?= $tr['train_id'] ?>)">
                        <i class="bi bi-pencil-square"></i>
                      </button>
                      <form method="POST" action="view-trains.php" class="d-inline" onsubmit="return confirm('Are you sure you want to delete Train <?= htmlspecialchars($tr['train_no']) ?> and all its coaches?');">
                        <input type="hidden" name="action" value="delete_train">
                        <input type="hidden" name="train_id" value="<?= $tr['train_id'] ?>">
                        <button type="submit" class="btn btn-sm btn-outline-danger rounded-end-pill px-2" title="Delete Train">
                          <i class="bi bi-trash"></i>
                        </button>
                      </form>
                    </div>
                  </td>
                </tr>
              <?php endforeach; ?>
            <?php endif; ?>
          </tbody>
        </table>
      </div>
    </div>

  </div>
</main>

<!-- Modal 1: View Coaches Modal -->
<div class="modal fade" id="viewCoachesModal" tabindex="-1" aria-labelledby="viewCoachesModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content rounded-4 border-0 shadow">
      <div class="modal-header bg-dark text-white rounded-top-4">
        <h5 class="modal-title fw-bold d-flex align-items-center" id="viewCoachesModalLabel">
          <i class="bi bi-train-front me-2 text-primary"></i> <span id="vModalTrainTitle">Train Composition</span>
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-4">
        <!-- Train Info Bar -->
        <div class="p-3 bg-light rounded-3 border mb-3 d-flex flex-wrap justify-content-between align-items-center gap-2">
          <div>
            <span class="text-muted small text-uppercase">Station:</span>
            <strong class="text-primary" id="vModalStation">-</strong>
          </div>
          <div>
            <span class="text-muted small text-uppercase">Total Coaches:</span>
            <span class="badge bg-primary rounded-pill px-3" id="vModalCount">0</span>
          </div>
        </div>

        <!-- Visual Strip -->
        <h6 class="fw-bold text-dark small text-uppercase mb-2"><i class="bi bi-diagram-2 me-1"></i> Visual Rake Strip</h6>
        <div class="d-flex flex-wrap gap-1 p-2 bg-light rounded-3 border mb-4" id="vModalRakeStrip" style="min-height: 48px;">
        </div>

        <!-- Coach List Table -->
        <h6 class="fw-bold text-dark small text-uppercase mb-2"><i class="bi bi-table me-1"></i> Coach List</h6>
        <div class="table-responsive rounded-3 border" style="max-height: 300px; overflow-y: auto;">
          <table class="table table-hover align-middle mb-0">
            <thead class="table-light sticky-top">
              <tr>
                <th style="width: 70px;" class="text-center">#</th>
                <th>Coach Number / Identifier</th>
                <th style="width: 120px;" class="text-center">Status</th>
              </tr>
            </thead>
            <tbody id="vModalCoachesTbody">
            </tbody>
          </table>
        </div>
      </div>
      <div class="modal-footer bg-light rounded-bottom-4 d-flex justify-content-between">
        <button type="button" class="btn btn-outline-secondary rounded-pill px-4" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary rounded-pill px-4 fw-bold" id="vModalEditBtn" style="background: #1987C6; border-color: #1987C6;">
          <i class="bi bi-pencil-square me-1"></i> Edit Train & Coaches
        </button>
      </div>
    </div>
  </div>
</div>

<!-- Modal 2: Edit Train & Coaches Modal -->
<div class="modal fade" id="editTrainModal" tabindex="-1" aria-labelledby="editTrainModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content rounded-4 border-0 shadow">
      <form method="POST" action="view-trains.php" id="editTrainForm">
        <input type="hidden" name="action" value="update_train">
        <input type="hidden" name="train_id" id="eModalTrainId" value="">

        <div class="modal-header bg-dark text-white rounded-top-4">
          <h5 class="modal-title fw-bold d-flex align-items-center" id="editTrainModalLabel">
            <i class="bi bi-pencil-square me-2 text-info"></i> Edit Train & Coaches
          </h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body p-4">
          <div class="row g-3">
            <div class="col-md-6">
              <label class="form-label fw-bold small text-uppercase">Train Number <span class="text-danger">*</span></label>
              <input type="text" name="train_no" id="eModalTrainNo" class="form-control py-2 text-uppercase fw-bold" required>
            </div>

            <div class="col-md-6">
              <label class="form-label fw-bold small text-uppercase text-secondary">Station</label>
              <div class="p-2 px-3 bg-light rounded-3 border d-flex align-items-center">
                <i class="bi bi-geo-alt-fill text-primary me-2 fs-5"></i>
                <div>
                  <div class="fw-bold text-dark"><?= htmlspecialchars($stationName) ?></div>
                  <div class="text-muted" style="font-size: 0.75rem;"><?= htmlspecialchars($divisionName) ?> &bull; <?= htmlspecialchars($railwayName) ?></div>
                </div>
              </div>
            </div>
          </div>

          <hr class="my-4">

          <div class="d-flex justify-content-between align-items-center mb-2">
            <h6 class="fw-bold text-dark mb-0">Coach Composition</h6>
            <button type="button" class="btn btn-sm btn-primary rounded-pill px-3 fw-bold" id="eModalAddCoachBtn" style="background: #1987C6; border-color: #1987C6;">
              <i class="bi bi-plus-lg me-1"></i> Add Coach
            </button>
          </div>

          <div class="table-responsive rounded-3 border" style="max-height: 350px; overflow-y: auto;">
            <table class="table table-hover align-middle mb-0" id="eModalCoachesTable">
              <thead class="table-light sticky-top">
                <tr>
                  <th style="width: 70px;" class="text-center">#</th>
                  <th>Coach Number / Identifier <span class="text-danger">*</span></th>
                  <th style="width: 140px;">Status</th>
                  <th style="width: 90px;" class="text-center">Action</th>
                </tr>
              </thead>
              <tbody id="eModalCoachesTbody">
              </tbody>
            </table>
          </div>
        </div>

        <div class="modal-footer bg-light rounded-bottom-4">
          <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-primary rounded-pill px-5 shadow-sm fw-bold" style="background: #1987C6; border-color: #1987C6;">
            <i class="bi bi-check2-circle me-1"></i> Save Changes
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
function viewTrainDetails(trainId) {
    fetch('view-trains.php?ajax=get_train_coaches&train_id=' + trainId)
        .then(res => res.json())
        .then(data => {
            if (data.status === 'success') {
                const tr = data.train;
                const coaches = data.coaches;

                document.getElementById('vModalTrainTitle').innerText = 'Train ' + tr.train_no;
                document.getElementById('vModalStation').innerText = tr.station_name + ' (' + tr.division_name + ' - ' + tr.zone_name + ')';
                document.getElementById('vModalCount').innerText = coaches.length + ' Coaches';

                let stripHtml = '';
                if (coaches.length === 0) {
                    stripHtml = '<span class="text-muted small my-auto">No coaches configured for this train.</span>';
                } else {
                    coaches.forEach((c, idx) => {
                        stripHtml += '<div class="rake-tag">' +
                                     '<span style="opacity: 0.5; font-size: 0.7rem;">' + (idx + 1) + '.</span> ' + 
                                     c.coach_no + '</div>';
                    });
                }
                document.getElementById('vModalRakeStrip').innerHTML = stripHtml;

                let tbodyHtml = '';
                if (coaches.length === 0) {
                    tbodyHtml = '<tr><td colspan="3" class="text-center text-muted py-3">No coaches assigned.</td></tr>';
                } else {
                    coaches.forEach((c, idx) => {
                        const statusBadge = (c.status === 'Active') ? 'bg-success' : 'bg-secondary';
                        tbodyHtml += `
                            <tr>
                                <td class="text-center text-muted fw-bold">${idx + 1}</td>
                                <td class="font-monospace fw-bold text-dark fs-6">${c.coach_no}</td>
                                <td class="text-center">
                                    <span class="badge ${statusBadge} rounded-pill">
                                        ${c.status}
                                    </span>
                                </td>
                            </tr>
                        `;
                    });
                }
                document.getElementById('vModalCoachesTbody').innerHTML = tbodyHtml;

                document.getElementById('vModalEditBtn').onclick = function() {
                    const vModal = bootstrap.Modal.getInstance(document.getElementById('viewCoachesModal'));
                    if (vModal) vModal.hide();
                    openEditTrainModal(trainId);
                };

                const modal = new bootstrap.Modal(document.getElementById('viewCoachesModal'));
                modal.show();
            } else {
                alert(data.message || 'Error loading train details');
            }
        })
        .catch(err => alert('Network error: ' + err));
}

function addEditModalCoachRow(cNo = '', cStatus = 'Active') {
    const tbody = document.getElementById('eModalCoachesTbody');
    const index = tbody.children.length;

    const tr = document.createElement('tr');
    tr.innerHTML = `
        <td class="text-center text-muted fw-bold e-pos">${index + 1}</td>
        <td>
            <input type="text" name="coach_no[]" class="form-control form-control-sm text-uppercase fw-bold" value="${cNo}" required>
        </td>
        <td>
            <select name="coach_status[]" class="form-select form-select-sm">
                <option value="Active" ${cStatus === 'Active' ? 'selected' : ''}>Active</option>
                <option value="Inactive" ${cStatus === 'Inactive' ? 'selected' : ''}>Inactive</option>
            </select>
        </td>
        <td class="text-center">
            <button type="button" class="btn btn-sm btn-outline-danger" onclick="this.closest('tr').remove(); reIndexEditRows();">
                <i class="bi bi-trash"></i>
            </button>
        </td>
    `;
    tbody.appendChild(tr);
}

function reIndexEditRows() {
    const tbody = document.getElementById('eModalCoachesTbody');
    tbody.querySelectorAll('tr').forEach((row, i) => {
        const p = row.querySelector('.e-pos');
        if (p) p.innerText = (i + 1);
    });
}

function openEditTrainModal(trainId) {
    fetch('view-trains.php?ajax=get_train_coaches&train_id=' + trainId)
        .then(res => res.json())
        .then(data => {
            if (data.status === 'success') {
                const tr = data.train;
                const coaches = data.coaches;

                document.getElementById('eModalTrainId').value = tr.train_id;
                document.getElementById('eModalTrainNo').value = tr.train_no;

                const tbody = document.getElementById('eModalCoachesTbody');
                tbody.innerHTML = '';

                coaches.forEach(c => {
                    addEditModalCoachRow(c.coach_no, c.status);
                });

                const modal = new bootstrap.Modal(document.getElementById('editTrainModal'));
                modal.show();
            } else {
                alert(data.message || 'Error loading train for edit');
            }
        })
        .catch(err => alert('Network error: ' + err));
}

document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('eModalAddCoachBtn').addEventListener('click', function() {
        addEditModalCoachRow();
    });
});
</script>

<?php include 'footer.php'; ?>
