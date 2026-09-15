<?php
/**
 * MCC - Admin Panel: View & Manage Trains and Coaches
 * Lists all registered trains, their coach composition, and provides full management features.
 */
$pageTitle = 'MCC Admin | View Trains & Coaches';
require_once '../connection.php';

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
            $message = 'Train and its associated coaches successfully deleted.';
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
        $station_id = intval($_POST['station_id'] ?? 0);
        $status = in_array($_POST['status'] ?? '', ['Active', 'Inactive']) ? $_POST['status'] : 'Active';

        $coach_nos = $_POST['coach_no'] ?? [];
        $coach_statuses = $_POST['coach_status'] ?? [];

        if (empty($train_no) || $station_id <= 0 || $train_id <= 0) {
            $message = 'Train number and station are required.';
            $messageType = 'danger';
        } else {
            try {
                $chk = $pdo->prepare("SELECT COUNT(*) FROM mcc_trains WHERE train_no = :train_no AND station_id = :station_id AND train_id != :id");
                $chk->execute(['train_no' => $train_no, 'station_id' => $station_id, 'id' => $train_id]);
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
                        'station_id' => $station_id,
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

// Filters & Search
$filterZone = intval($_GET['zone_id'] ?? 0);
$filterDivision = intval($_GET['division_id'] ?? 0);
$filterStation = intval($_GET['station_id'] ?? 0);
$filterStatus = trim($_GET['status'] ?? '');
$searchQuery = trim($_GET['q'] ?? '');

$zones = [];
$divisions = [];
$stations = [];
try {
    $zones = $pdo->query("SELECT zone_id, zone_name FROM mcc_zones WHERE status = 'Active' ORDER BY zone_name ASC")->fetchAll();
    $divisions = $pdo->query("SELECT division_id, division_name, zone_id FROM mcc_divisions WHERE status = 'Active' ORDER BY division_name ASC")->fetchAll();
    $stations = $pdo->query("SELECT station_id, station_name, division_id FROM mcc_stations WHERE status = 'Active' ORDER BY station_name ASC")->fetchAll();
} catch (PDOException $e) {}

$sql = "
    SELECT t.*, s.station_name, d.division_name, z.zone_name,
           COUNT(c.coach_id) as total_coaches,
           GROUP_CONCAT(c.coach_no ORDER BY c.display_order ASC SEPARATOR ', ') as coaches_list
    FROM mcc_trains t
    INNER JOIN mcc_stations s ON t.station_id = s.station_id
    INNER JOIN mcc_divisions d ON s.division_id = d.division_id
    INNER JOIN mcc_zones z ON d.zone_id = z.zone_id
    LEFT JOIN mcc_coaches c ON t.train_id = c.train_id
    WHERE 1=1
";
$params = [];

if ($filterZone > 0) {
    $sql .= " AND z.zone_id = :zone_id";
    $params['zone_id'] = $filterZone;
}
if ($filterDivision > 0) {
    $sql .= " AND d.division_id = :division_id";
    $params['division_id'] = $filterDivision;
}
if ($filterStation > 0) {
    $sql .= " AND s.station_id = :station_id";
    $params['station_id'] = $filterStation;
}
if ($filterStatus !== '') {
    $sql .= " AND t.status = :status";
    $params['status'] = $filterStatus;
}
if ($searchQuery !== '') {
    $sql .= " AND (t.train_no LIKE :q1 OR s.station_name LIKE :q2)";
    $params['q1'] = "%$searchQuery%";
    $params['q2'] = "%$searchQuery%";
}

$sql .= " GROUP BY t.train_id ORDER BY z.zone_name ASC, d.division_name ASC, s.station_name ASC, t.train_no ASC";

$trains = [];
try {
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    $trains = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    $dbError = $e->getMessage();
}

// KPI Statistics
$totalTrainsCount = count($trains);
$activeTrainsCount = 0;
$totalCoachesCount = 0;
$uniqueStations = [];
foreach ($trains as $tr) {
    if ($tr['status'] === 'Active') $activeTrainsCount++;
    $totalCoachesCount += intval($tr['total_coaches']);
    $uniqueStations[$tr['station_id']] = true;
}

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
  <!-- Content Header -->
  <div class="app-content-header py-3 mb-3 border-bottom bg-white shadow-sm">
    <div class="container-fluid">
      <div class="row align-items-center">
        <div class="col-md-6">
          <h3 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
            <i class="bi bi-list-columns-reverse text-indigo me-2" style="font-size: 1.6rem;"></i>
            Manage Trains & Coach Compositions
          </h3>
          <p class="text-muted small mb-0 mt-1">Directory of registered trains, rake compositions, and station associations.</p>
        </div>
        <div class="col-md-6 text-md-end mt-2 mt-md-0">
          <a href="create-trains.php" class="btn btn-indigo text-white px-4 rounded-pill shadow-sm">
            <i class="bi bi-plus-circle me-1"></i> Create New Train
          </a>
        </div>
      </div>
    </div>
  </div>

  <!-- Main Content -->
  <div class="app-content">
    <div class="container-fluid">

      <?php if (!empty($message)): ?>
        <div class="alert alert-<?= htmlspecialchars($messageType) ?> alert-dismissible fade show rounded-3 shadow-sm border-0 d-flex align-items-center" role="alert">
          <i class="bi <?= $messageType === 'success' ? 'bi-check-circle-fill text-success' : 'bi-exclamation-triangle-fill text-danger' ?> fs-4 me-3"></i>
          <div><?= htmlspecialchars($message) ?></div>
          <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      <?php endif; ?>

      <!-- KPI Summary Cards -->
      <div class="row g-3 mb-4">
        <div class="col-xl-3 col-sm-6">
          <div class="card border-0 shadow-sm rounded-4 p-3 bg-white h-100 border-start border-4 border-indigo">
            <div class="d-flex align-items-center">
              <div class="rounded-circle bg-indigo bg-opacity-10 p-3 text-indigo me-3">
                <i class="bi bi-train-front fs-3"></i>
              </div>
              <div>
                <span class="text-muted small text-uppercase font-weight-bold">Total Trains</span>
                <h3 class="mb-0 font-weight-bold text-dark"><?= number_format($totalTrainsCount) ?></h3>
              </div>
            </div>
          </div>
        </div>

        <div class="col-xl-3 col-sm-6">
          <div class="card border-0 shadow-sm rounded-4 p-3 bg-white h-100 border-start border-4 border-success">
            <div class="d-flex align-items-center">
              <div class="rounded-circle bg-success bg-opacity-10 p-3 text-success me-3">
                <i class="bi bi-check-circle fs-3"></i>
              </div>
              <div>
                <span class="text-muted small text-uppercase font-weight-bold">Active Trains</span>
                <h3 class="mb-0 font-weight-bold text-success"><?= number_format($activeTrainsCount) ?></h3>
              </div>
            </div>
          </div>
        </div>

        <div class="col-xl-3 col-sm-6">
          <div class="card border-0 shadow-sm rounded-4 p-3 bg-white h-100 border-start border-4 border-primary">
            <div class="d-flex align-items-center">
              <div class="rounded-circle bg-primary bg-opacity-10 p-3 text-primary me-3">
                <i class="bi bi-grid-3x3-gap fs-3"></i>
              </div>
              <div>
                <span class="text-muted small text-uppercase font-weight-bold">Total Coaches</span>
                <h3 class="mb-0 font-weight-bold text-primary"><?= number_format($totalCoachesCount) ?></h3>
              </div>
            </div>
          </div>
        </div>

        <div class="col-xl-3 col-sm-6">
          <div class="card border-0 shadow-sm rounded-4 p-3 bg-white h-100 border-start border-4 border-warning">
            <div class="d-flex align-items-center">
              <div class="rounded-circle bg-warning bg-opacity-10 p-3 text-warning me-3">
                <i class="bi bi-geo-alt fs-3"></i>
              </div>
              <div>
                <span class="text-muted small text-uppercase font-weight-bold">Covered Stations</span>
                <h3 class="mb-0 font-weight-bold text-dark"><?= count($uniqueStations) ?></h3>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Filter & Search Bar -->
      <div class="card border-0 shadow-sm rounded-4 mb-4">
        <div class="card-body p-3">
          <form method="GET" action="view-trains.php" class="row g-2 align-items-center">
            
            <div class="col-md-3">
              <div class="input-group">
                <span class="input-group-text bg-light text-muted border-end-0"><i class="bi bi-search"></i></span>
                <input type="text" name="q" value="<?= htmlspecialchars($searchQuery) ?>" class="form-control border-start-0 ps-0" placeholder="Search Train Number...">
              </div>
            </div>

            <div class="col-md-2">
              <select name="zone_id" class="form-select" onchange="this.form.submit()">
                <option value="0">All Zones</option>
                <?php foreach ($zones as $z): ?>
                  <option value="<?= $z['zone_id'] ?>" <?= ($filterZone == $z['zone_id']) ? 'selected' : '' ?>>
                    <?= htmlspecialchars($z['zone_name']) ?>
                  </option>
                <?php endforeach; ?>
              </select>
            </div>

            <div class="col-md-2">
              <select name="division_id" class="form-select" onchange="this.form.submit()">
                <option value="0">All Divisions</option>
                <?php foreach ($divisions as $d): ?>
                  <option value="<?= $d['division_id'] ?>" <?= ($filterDivision == $d['division_id']) ? 'selected' : '' ?>>
                    <?= htmlspecialchars($d['division_name']) ?>
                  </option>
                <?php endforeach; ?>
              </select>
            </div>

            <div class="col-md-2">
              <select name="station_id" class="form-select" onchange="this.form.submit()">
                <option value="0">All Stations</option>
                <?php foreach ($stations as $s): ?>
                  <option value="<?= $s['station_id'] ?>" <?= ($filterStation == $s['station_id']) ? 'selected' : '' ?>>
                    <?= htmlspecialchars($s['station_name']) ?>
                  </option>
                <?php endforeach; ?>
              </select>
            </div>

            <div class="col-md-2">
              <select name="status" class="form-select" onchange="this.form.submit()">
                <option value="">All Statuses</option>
                <option value="Active" <?= ($filterStatus === 'Active') ? 'selected' : '' ?>>Active Only</option>
                <option value="Inactive" <?= ($filterStatus === 'Inactive') ? 'selected' : '' ?>>Inactive Only</option>
              </select>
            </div>

            <div class="col-md-1 d-flex gap-1">
              <button type="submit" class="btn btn-indigo text-white w-100 rounded-3" title="Apply Filter">
                <i class="bi bi-funnel"></i>
              </button>
              <?php if ($filterZone || $filterDivision || $filterStation || $filterStatus || $searchQuery): ?>
                <a href="view-trains.php" class="btn btn-outline-secondary rounded-3" title="Reset Filters">
                  <i class="bi bi-arrow-counterclockwise"></i>
                </a>
              <?php endif; ?>
            </div>

          </form>
        </div>
      </div>

      <!-- Train List Table -->
      <div class="card border-0 shadow-sm rounded-4">
        <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
          <h5 class="card-title mb-0 font-weight-bold text-dark d-flex align-items-center">
            <i class="bi bi-train-lightrail-front text-indigo me-2"></i> Registered Trains List
          </h5>
          <span class="badge bg-light text-dark border px-3 py-2 rounded-pill">
            Showing <?= count($trains) ?> Train<?= count($trains) == 1 ? '' : 's' ?>
          </span>
        </div>

        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
              <thead class="table-light">
                <tr>
                  <th style="width: 60px;" class="text-center">#</th>
                  <th style="width: 150px;">Train Number</th>
                  <th>Station / Division</th>
                  <th style="width: 320px;">Rake Composition</th>
                  <th style="width: 120px;" class="text-center">Status</th>
                  <th style="width: 160px;" class="text-center">Actions</th>
                </tr>
              </thead>
              <tbody>
                <?php if (empty($trains)): ?>
                  <tr>
                    <td colspan="6" class="text-center py-5">
                      <i class="bi bi-train-front-fill text-muted" style="font-size: 3rem; opacity: 0.3;"></i>
                      <h6 class="text-muted mt-3 mb-1">No Trains Found</h6>
                      <p class="text-muted small mb-3">No railway trains match your current filter criteria.</p>
                      <a href="create-trains.php" class="btn btn-sm btn-indigo text-white rounded-pill px-4">
                        <i class="bi bi-plus-circle me-1"></i> Create First Train
                      </a>
                    </td>
                  </tr>
                <?php else: ?>
                  <?php 
                  $sl = 1;
                  foreach ($trains as $tr): 
                      $coachesArr = array_filter(array_map('trim', explode(',', $tr['coaches_list'] ?? '')));
                      $previewCount = 5;
                      $previewCoaches = array_slice($coachesArr, 0, $previewCount);
                      $remainingCoaches = count($coachesArr) - count($previewCoaches);
                  ?>
                    <tr>
                      <td class="text-center text-muted font-weight-bold"><?= $sl++ ?></td>
                      <td>
                        <span class="badge bg-dark rounded-3 font-monospace fs-6 px-3 py-2">
                          <?= htmlspecialchars($tr['train_no']) ?>
                        </span>
                      </td>
                      <td>
                        <div class="font-weight-bold text-indigo d-flex align-items-center">
                          <i class="bi bi-geo-alt me-1"></i> <?= htmlspecialchars($tr['station_name']) ?>
                        </div>
                        <div class="small text-muted">
                          <?= htmlspecialchars($tr['division_name']) ?> (<?= htmlspecialchars($tr['zone_name']) ?>)
                        </div>
                      </td>
                      <td>
                        <div class="d-flex align-items-center justify-content-between mb-1">
                          <span class="small font-weight-bold text-muted">
                            <?= intval($tr['total_coaches']) ?> Coaches
                          </span>
                          <button type="button" class="btn btn-link btn-sm p-0 text-decoration-none text-indigo font-weight-bold" onclick="viewTrainDetails(<?= $tr['train_id'] ?>)">
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
                              <span class="badge bg-indigo bg-opacity-10 text-indigo font-weight-bold" style="font-size: 0.75rem;">
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
                          <form method="POST" action="view-trains.php" class="d-inline" onsubmit="return confirm('Are you sure you want to permanently delete Train <?= htmlspecialchars($tr['train_no']) ?> and all its coaches?');">
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

    </div>
  </div>
</main>

<!-- Modal 1: View Coaches Modal -->
<div class="modal fade" id="viewCoachesModal" tabindex="-1" aria-labelledby="viewCoachesModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content rounded-4 border-0 shadow">
      <div class="modal-header bg-indigo text-white rounded-top-4">
        <h5 class="modal-title font-weight-bold d-flex align-items-center" id="viewCoachesModalLabel">
          <i class="bi bi-train-front me-2"></i> <span id="vModalTrainTitle">Train Composition</span>
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-4">
        <div class="p-3 bg-light rounded-3 border mb-3 d-flex flex-wrap justify-content-between align-items-center gap-2">
          <div>
            <span class="text-muted small text-uppercase">Station:</span>
            <strong class="text-indigo" id="vModalStation">-</strong>
          </div>
          <div>
            <span class="text-muted small text-uppercase">Total Coaches:</span>
            <span class="badge bg-indigo rounded-pill px-3" id="vModalCount">0</span>
          </div>
        </div>

        <h6 class="font-weight-bold text-dark small text-uppercase mb-2"><i class="bi bi-diagram-2 me-1"></i> Visual Rake Strip</h6>
        <div class="d-flex flex-wrap gap-1 p-2 bg-light rounded-3 border mb-4" id="vModalRakeStrip" style="min-height: 50px;">
        </div>

        <h6 class="font-weight-bold text-dark small text-uppercase mb-2"><i class="bi bi-table me-1"></i> Coach List</h6>
        <div class="table-responsive rounded-3 border" style="max-height: 320px; overflow-y: auto;">
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
        <button type="button" class="btn btn-indigo text-white rounded-pill px-4" id="vModalEditBtn">
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
          <h5 class="modal-title font-weight-bold d-flex align-items-center" id="editTrainModalLabel">
            <i class="bi bi-pencil-square me-2"></i> Edit Train & Coaches
          </h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>

        <div class="modal-body p-4">
          <div class="row g-3">
            <div class="col-md-6">
              <label class="form-label font-weight-bold small text-uppercase">Train Number <span class="text-danger">*</span></label>
              <input type="text" name="train_no" id="eModalTrainNo" class="form-control rounded-3 py-2 text-uppercase font-weight-bold" required>
            </div>

            <div class="col-md-6">
              <label class="form-label font-weight-bold small text-uppercase">Station <span class="text-danger">*</span></label>
              <select name="station_id" id="eModalStationId" class="form-select rounded-3 py-2" required>
                <?php foreach ($stations as $st): ?>
                  <option value="<?= $st['station_id'] ?>">
                    <?= htmlspecialchars($st['station_name']) ?>
                  </option>
                <?php endforeach; ?>
              </select>
            </div>
          </div>

          <hr class="my-4">

          <div class="d-flex justify-content-between align-items-center mb-2">
            <h6 class="font-weight-bold text-dark mb-0">Coach Composition</h6>
            <button type="button" class="btn btn-sm btn-indigo text-white rounded-pill px-3" id="eModalAddCoachBtn">
              <i class="bi bi-plus-lg me-1"></i> Add Coach
            </button>
          </div>

          <div class="table-responsive rounded-3 border" style="max-height: 380px; overflow-y: auto;">
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
          <button type="submit" class="btn btn-indigo text-white rounded-pill px-5 shadow-sm font-weight-bold">
            <i class="bi bi-check2-circle me-1"></i> Save Changes
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<style>
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
</style>

<?php
$extraScripts = <<<EOT
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
                                <td class="text-center text-muted font-weight-bold">${idx + 1}</td>
                                <td class="font-monospace font-weight-bold text-dark fs-6">${c.coach_no}</td>
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
        <td class="text-center text-muted font-weight-bold e-pos">${index + 1}</td>
        <td>
            <input type="text" name="coach_no[]" class="form-control form-control-sm rounded-2 text-uppercase font-weight-bold" value="${cNo}" required>
        </td>
        <td>
            <select name="coach_status[]" class="form-select form-select-sm rounded-2">
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
                document.getElementById('eModalStationId').value = tr.station_id;

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
EOT;
include 'footer.php';
?>
