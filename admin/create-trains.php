<?php
/**
 * MCC - Admin Panel: Create Trains and Coaches
 * Allows system administrators to register a train and build its coach composition.
 */
$pageTitle = 'MCC Admin | Create Trains & Coaches';
require_once '../connection.php';

$message = '';
$messageType = '';
$createdTrainId = null;

// Handle Form Submission
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'create_train') {
    $train_no = strtoupper(trim($_POST['train_no'] ?? ''));
    $station_id = intval($_POST['station_id'] ?? 0);
    $status = in_array($_POST['status'] ?? '', ['Active', 'Inactive']) ? $_POST['status'] : 'Active';

    // Coaches payload
    $coach_nos = $_POST['coach_no'] ?? [];
    $coach_statuses = $_POST['coach_status'] ?? [];

    if (empty($train_no) || $station_id <= 0) {
        $message = 'Please provide a valid Train Number and select a Station.';
        $messageType = 'danger';
    } else {
        try {
            $chk = $pdo->prepare("SELECT COUNT(*) FROM mcc_trains WHERE train_no = :train_no AND station_id = :station_id");
            $chk->execute(['train_no' => $train_no, 'station_id' => $station_id]);
            if ($chk->fetchColumn() > 0) {
                $message = "Train number '$train_no' is already registered for the selected station.";
                $messageType = 'warning';
            } else {
                $pdo->beginTransaction();

                // 1. Insert Train
                $stmt = $pdo->prepare("
                    INSERT INTO mcc_trains (train_no, station_id, status) 
                    VALUES (:train_no, :station_id, :status)
                ");
                $stmt->execute([
                    'train_no'   => $train_no,
                    'station_id' => $station_id,
                    'status'     => $status
                ]);
                $train_id = $pdo->lastInsertId();
                $createdTrainId = $train_id;

                // 2. Insert Coaches if provided
                $coachCount = 0;
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
                        $coachCount++;
                    }
                }

                $pdo->commit();
                $message = "Train '$train_no' and $coachCount coach(es) created successfully!";
                $messageType = 'success';
            }
        } catch (Exception $e) {
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            $message = 'Error creating train & coaches: ' . $e->getMessage();
            $messageType = 'danger';
        }
    }
}

// Fetch active stations grouped by Zone and Division
$stationsList = [];
try {
    $sQuery = $pdo->query("
        SELECT s.station_id, s.station_name, d.division_name, z.zone_name 
        FROM mcc_stations s
        INNER JOIN mcc_divisions d ON s.division_id = d.division_id
        INNER JOIN mcc_zones z ON d.zone_id = z.zone_id
        WHERE s.status = 'Active'
        ORDER BY z.zone_name ASC, d.division_name ASC, s.station_name ASC
    ");
    $stationsList = $sQuery->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    // Fail silently
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
            <i class="bi bi-train-front text-indigo me-2" style="font-size: 1.6rem;"></i>
            Create Train & Coach Composition
          </h3>
          <p class="text-muted small mb-0 mt-1">Configure railway train numbers and define their alphanumeric coaches.</p>
        </div>
        <div class="col-md-6 text-md-end mt-2 mt-md-0">
          <a href="view-trains.php" class="btn btn-outline-secondary px-3 rounded-pill shadow-sm me-2">
            <i class="bi bi-list-columns-reverse me-1"></i> View All Trains
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
          <div>
            <div><?= htmlspecialchars($message) ?></div>
            <?php if ($messageType === 'success' && $createdTrainId): ?>
              <div class="mt-2">
                <a href="view-trains.php" class="btn btn-sm btn-success rounded-pill px-3 me-2">
                  <i class="bi bi-eye me-1"></i> View in Train List
                </a>
                <a href="create-trains.php" class="btn btn-sm btn-outline-dark rounded-pill px-3">
                  <i class="bi bi-plus-circle me-1"></i> Add Another Train
                </a>
              </div>
            <?php endif; ?>
          </div>
          <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      <?php endif; ?>

      <form method="POST" action="create-trains.php" id="createTrainForm">
        <input type="hidden" name="action" value="create_train">

        <div class="row">
          <!-- Left Column: Train Primary Information -->
          <div class="col-lg-4 mb-4">
            <div class="card border-0 shadow-sm rounded-4 h-100">
              <div class="card-header bg-indigo text-white rounded-top-4 py-3">
                <h5 class="card-title mb-0 d-flex align-items-center font-weight-bold">
                  <i class="bi bi-info-circle me-2"></i> 1. Train Profile
                </h5>
              </div>
              <div class="card-body p-4">

                <!-- Station Dropdown -->
                <div class="mb-3">
                  <label class="form-label font-weight-bold text-dark small text-uppercase">Assigned Station <span class="text-danger">*</span></label>
                  <select name="station_id" id="station_id" class="form-select rounded-3 py-2" required>
                    <option value="" disabled selected>-- Select Station --</option>
                    <?php foreach ($stationsList as $st): ?>
                      <option value="<?= $st['station_id'] ?>">
                        <?= htmlspecialchars($st['station_name']) ?> (<?= htmlspecialchars($st['division_name']) ?> - <?= htmlspecialchars($st['zone_name']) ?>)
                      </option>
                    <?php endforeach; ?>
                  </select>
                </div>

                <!-- Train Number -->
                <div class="mb-3">
                  <label class="form-label font-weight-bold text-dark small text-uppercase">Train Number <span class="text-danger">*</span></label>
                  <div class="input-group">
                    <span class="input-group-text bg-light text-muted"><i class="bi bi-hash"></i></span>
                    <input type="text" name="train_no" id="train_no" class="form-control rounded-end-3 py-2 text-uppercase font-weight-bold" placeholder="e.g., 12429, 22436, S101" required maxlength="50" autocomplete="off">
                  </div>
                  <small class="text-muted">Unique alphanumeric train number.</small>
                </div>

                <!-- Status -->
                <div class="mb-3">
                  <label class="form-label font-weight-bold text-dark small text-uppercase">Initial Status</label>
                  <select name="status" class="form-select rounded-3 py-2">
                    <option value="Active" selected>Active</option>
                    <option value="Inactive">Inactive</option>
                  </select>
                </div>

                <!-- Train Summary Pill -->
                <div class="p-3 bg-light rounded-3 border mt-4">
                  <div class="d-flex justify-content-between align-items-center">
                    <span class="text-muted small font-weight-bold">Total Coaches Configured:</span>
                    <span class="badge bg-indigo rounded-pill fs-6 px-3 py-2" id="coachCountBadge">0 Coaches</span>
                  </div>
                </div>

              </div>
            </div>
          </div>

          <!-- Right Column: Coach Builder -->
          <div class="col-lg-8 mb-4">
            <div class="card border-0 shadow-sm rounded-4 h-100">
              <div class="card-header bg-white py-3 border-bottom d-flex flex-wrap justify-content-between align-items-center gap-2">
                <h5 class="card-title mb-0 font-weight-bold text-dark d-flex align-items-center">
                  <i class="bi bi-grid-3x3-gap-fill text-indigo me-2"></i> 2. Coach Composition Builder
                </h5>
                <button type="button" class="btn btn-sm btn-indigo text-white rounded-pill px-3 fw-bold" id="addSingleCoachBtn">
                  <i class="bi bi-plus-lg me-1"></i> Add More Coach
                </button>
              </div>

              <div class="card-body p-4">
                <p class="text-muted small mb-3">
                  Add alphanumeric coach numbers (e.g. <code>A1</code>, <code>B1</code>, <code>S1</code>, <code>124021</code>, <code>PC</code>, <code>EOG</code>) in order from engine to rear.
                </p>

                <!-- Coach List Table -->
                <div class="table-responsive rounded-3 border mb-3" style="max-height: 480px; overflow-y: auto;">
                  <table class="table table-hover align-middle mb-0" id="coachesTable">
                    <thead class="table-light sticky-top" style="z-index: 2;">
                      <tr>
                        <th style="width: 70px;" class="text-center">#</th>
                        <th>Coach Number / Identifier <span class="text-danger">*</span></th>
                        <th style="width: 140px;">Status</th>
                        <th style="width: 100px;" class="text-center">Actions</th>
                      </tr>
                    </thead>
                    <tbody id="coachesTableBody">
                      <!-- Dynamically injected rows -->
                    </tbody>
                  </table>
                </div>

                <!-- Add More Coach Button below table -->
                <div class="mb-3">
                  <button type="button" class="btn btn-outline-primary btn-sm rounded-pill px-4 fw-bold" id="addMoreCoachBottomBtn">
                    <i class="bi bi-plus-circle me-1"></i> Add More Coach
                  </button>
                </div>

                <!-- Empty State -->
                <div id="emptyCoachesState" class="text-center py-5 bg-light rounded-3 border border-dashed mt-3">
                  <i class="bi bi-train-front-fill text-muted" style="font-size: 3rem; opacity: 0.4;"></i>
                  <h6 class="text-muted mt-3 mb-1">No Coaches Added Yet</h6>
                  <p class="text-muted small mb-3">Click 'Add Coach' to start configuring coaches.</p>
                  <button type="button" class="btn btn-sm btn-indigo text-white rounded-pill px-4" id="addFirstCoachBtn">
                    <i class="bi bi-plus-circle me-1"></i> Add Coach
                  </button>
                </div>

                <!-- Visual Rake Strip Preview -->
                <div class="mt-4 pt-3 border-top">
                  <label class="form-label font-weight-bold text-dark small text-uppercase d-flex justify-content-between align-items-center">
                    <span><i class="bi bi-eye me-1"></i> Visual Rake Strip Composition</span>
                    <button type="button" class="btn btn-link btn-sm text-danger p-0 text-decoration-none" id="clearAllCoachesBtn">
                      <i class="bi bi-trash3 me-1"></i> Clear All
                    </button>
                  </label>
                  <div class="d-flex flex-wrap gap-1 p-2 bg-light rounded-3 border" id="visualRakeStrip" style="min-height: 48px;">
                    <span class="text-muted small my-auto">Coaches will visually appear here in order.</span>
                  </div>
                </div>

              </div>

              <div class="card-footer bg-white border-top p-4 d-flex justify-content-between align-items-center">
                <a href="view-trains.php" class="btn btn-light px-4 rounded-pill">Cancel</a>
                <button type="submit" class="btn btn-indigo text-white px-5 py-2 rounded-pill shadow-sm font-weight-bold">
                  <i class="bi bi-check2-circle me-2 fs-5"></i> Save Train & Coaches
                </button>
              </div>
            </div>
          </div>
        </div>
      </form>

    </div>
  </div>
</main>

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
function renderCoaches() {
    const tbody = document.getElementById('coachesTableBody');
    const emptyState = document.getElementById('emptyCoachesState');
    const badge = document.getElementById('coachCountBadge');
    const visualStrip = document.getElementById('visualRakeStrip');

    const rows = tbody.querySelectorAll('tr');
    const count = rows.length;

    badge.innerText = count + (count === 1 ? ' Coach' : ' Coaches');

    if (count === 0) {
        emptyState.style.display = 'block';
        visualStrip.innerHTML = '<span class="text-muted small my-auto">Coaches will visually appear here in order.</span>';
    } else {
        emptyState.style.display = 'none';
        
        let stripHtml = '';
        rows.forEach((row, index) => {
            const posBadge = row.querySelector('.coach-pos');
            if (posBadge) posBadge.innerText = (index + 1);

            const cNoInput = row.querySelector('input[name="coach_no[]"]');
            const cNo = cNoInput ? cNoInput.value.toUpperCase().trim() : ('C' + (index + 1));

            stripHtml += '<div class="rake-tag">' + 
                         '<span style="opacity: 0.5; font-size: 0.7rem;">' + (index + 1) + '.</span> ' + 
                         (cNo || '-') + '</div>';
        });

        visualStrip.innerHTML = stripHtml;
    }
}

function addCoachRow(cNo = '', cStatus = 'Active') {
    const tbody = document.getElementById('coachesTableBody');
    const index = tbody.children.length;

    const tr = document.createElement('tr');
    tr.innerHTML = `
        <td class="text-center font-weight-bold text-muted coach-pos">${index + 1}</td>
        <td>
            <input type="text" name="coach_no[]" class="form-control rounded-2 text-uppercase font-weight-bold coach-no-input" value="${cNo}" placeholder="e.g. A1, B1, S1, 124021, PC, EOG" required autocomplete="off">
        </td>
        <td>
            <select name="coach_status[]" class="form-select rounded-2">
                <option value="Active" ${cStatus === 'Active' ? 'selected' : ''}>Active</option>
                <option value="Inactive" ${cStatus === 'Inactive' ? 'selected' : ''}>Inactive</option>
            </select>
        </td>
        <td class="text-center">
            <div class="btn-group btn-group-sm">
                <button type="button" class="btn btn-outline-secondary move-up-btn" title="Move Up"><i class="bi bi-arrow-up"></i></button>
                <button type="button" class="btn btn-outline-secondary move-down-btn" title="Move Down"><i class="bi bi-arrow-down"></i></button>
                <button type="button" class="btn btn-outline-danger remove-coach-btn" title="Remove"><i class="bi bi-trash"></i></button>
            </div>
        </td>
    `;

    tr.querySelector('.coach-no-input').addEventListener('input', renderCoaches);
    tr.querySelector('.remove-coach-btn').addEventListener('click', function() {
        tr.remove();
        renderCoaches();
    });
    tr.querySelector('.move-up-btn').addEventListener('click', function() {
        if (tr.previousElementSibling) {
            tr.parentNode.insertBefore(tr, tr.previousElementSibling);
            renderCoaches();
        }
    });
    tr.querySelector('.move-down-btn').addEventListener('click', function() {
        if (tr.nextElementSibling) {
            tr.parentNode.insertBefore(tr, tr.nextElementSibling);
            renderCoaches();
        }
    });

    tbody.appendChild(tr);
    renderCoaches();

    const input = tr.querySelector('.coach-no-input');
    if (input) input.focus();
}

document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('addSingleCoachBtn').addEventListener('click', () => addCoachRow());
    document.getElementById('addMoreCoachBottomBtn').addEventListener('click', () => addCoachRow());
    document.getElementById('addFirstCoachBtn').addEventListener('click', () => addCoachRow());
    
    document.getElementById('clearAllCoachesBtn').addEventListener('click', function() {
        if (confirm('Are you sure you want to clear all configured coaches?')) {
            document.getElementById('coachesTableBody').innerHTML = '';
            renderCoaches();
        }
    });

    // Start with 1 initial empty coach row
    addCoachRow();
});
EOT;
include 'footer.php';
?>
