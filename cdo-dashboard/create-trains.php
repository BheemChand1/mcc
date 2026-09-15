<?php
/**
 * CDO Dashboard - Create Trains and Coaches
 * Allows CDO officers and supervisors to register trains and build their coach rake composition.
 * Uses station ID automatically from active session.
 */
require_once 'auth.php';

$message = '';
$messageType = '';
$createdTrainId = null;

// Handle Form Submission
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'create_train') {
    $train_no = strtoupper(trim($_POST['train_no'] ?? ''));
    $status = in_array($_POST['status'] ?? '', ['Active', 'Inactive']) ? $_POST['status'] : 'Active';

    // Coaches payload
    $coach_nos = $_POST['coach_no'] ?? [];
    $coach_statuses = $_POST['coach_status'] ?? [];

    if (empty($train_no)) {
        $message = 'Please provide a valid Train Number.';
        $messageType = 'danger';
    } else {
        try {
            // Check for duplicate train_no under the session station
            $chk = $pdo->prepare("SELECT COUNT(*) FROM mcc_trains WHERE train_no = :train_no AND station_id = :station_id");
            $chk->execute(['train_no' => $train_no, 'station_id' => $stationId]);
            if ($chk->fetchColumn() > 0) {
                $message = "Train number '$train_no' is already registered for this station.";
                $messageType = 'warning';
            } else {
                $pdo->beginTransaction();

                // 1. Insert Train using session stationId
                $stmt = $pdo->prepare("
                    INSERT INTO mcc_trains (train_no, station_id, status) 
                    VALUES (:train_no, :station_id, :status)
                ");
                $stmt->execute([
                    'train_no'   => $train_no,
                    'station_id' => $stationId,
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

$pageTitle = 'Create Train & Coaches | MCC Dashboard';
$extraStyles = "
    .content-wrapper { padding: 15px; background: #f0f2f5; min-height: 100vh; }
    .form-card {
        background: #fff;
        border: 1px solid #e2e8f0;
        border-radius: 12px;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
    }
    .form-header {
        background: linear-gradient(180deg, #07203a 0%, #07182c 100%);
        color: #fff;
        padding: 12px 18px;
        border-radius: 12px 12px 0 0;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .form-header h5 { margin: 0; font-weight: 700; font-size: 1rem; }
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

    <!-- Top Action Bar -->
    <div class="d-flex flex-wrap justify-content-between align-items-center mb-3">
      <div>
        <h4 class="mb-0 fw-bold text-dark d-flex align-items-center">
          <i class="bi bi-train-front text-primary me-2"></i> Create Train & Coach Composition
        </h4>
        <p class="text-muted small mb-0">Register a new train number for <strong><?= htmlspecialchars($stationName) ?></strong> and configure its alphanumeric coaches.</p>
      </div>
      <div>
        <a href="view-trains.php" class="btn btn-sm btn-outline-secondary px-3 rounded-pill">
          <i class="bi bi-list-columns-reverse me-1"></i> View Registered Trains
        </a>
      </div>
    </div>

    <?php if (!empty($message)): ?>
      <div class="alert alert-<?= htmlspecialchars($messageType) ?> alert-dismissible fade show rounded-3 shadow-sm border-0 d-flex align-items-center mb-3" role="alert">
        <i class="bi <?= $messageType === 'success' ? 'bi-check-circle-fill text-success' : 'bi-exclamation-triangle-fill text-danger' ?> fs-4 me-3"></i>
        <div>
          <div><?= htmlspecialchars($message) ?></div>
          <?php if ($messageType === 'success' && $createdTrainId): ?>
            <div class="mt-2">
              <a href="view-trains.php" class="btn btn-sm btn-success rounded-pill px-3 me-2">
                <i class="bi bi-eye me-1"></i> View in Train List
              </a>
              <a href="create-trains.php" class="btn btn-sm btn-outline-dark rounded-pill px-3">
                <i class="bi bi-plus-circle me-1"></i> Create Another Train
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
        <!-- Left Column: Train Profile -->
        <div class="col-lg-4 mb-3">
          <div class="form-card h-100">
            <div class="form-header">
              <h5><i class="bi bi-info-circle me-2"></i> 1. Train Profile</h5>
            </div>
            <div class="p-3">

              <!-- Station Display (Automatic from Session) -->
              <div class="mb-3">
                <label class="form-label fw-bold small text-uppercase text-secondary">Station</label>
                <div class="p-2 px-3 bg-light rounded-3 border d-flex align-items-center">
                  <i class="bi bi-geo-alt-fill text-primary me-2 fs-5"></i>
                  <div>
                    <div class="fw-bold text-dark"><?= htmlspecialchars($stationName) ?></div>
                    <div class="text-muted" style="font-size: 0.75rem;"><?= htmlspecialchars($divisionName) ?> &bull; <?= htmlspecialchars($railwayName) ?></div>
                  </div>
                </div>
              </div>

              <!-- Train Number -->
              <div class="mb-3">
                <label class="form-label fw-bold small text-uppercase text-secondary">Train Number <span class="text-danger">*</span></label>
                <div class="input-group">
                  <span class="input-group-text bg-light text-muted"><i class="bi bi-hash"></i></span>
                  <input type="text" name="train_no" id="train_no" class="form-control py-2 text-uppercase fw-bold" placeholder="e.g., 12429, 22436, S101" required maxlength="50" autocomplete="off">
                </div>
                <small class="text-muted">Unique alphanumeric train number or code.</small>
              </div>

              <!-- Initial Status -->
              <div class="mb-3">
                <label class="form-label fw-bold small text-uppercase text-secondary">Status</label>
                <select name="status" class="form-select py-2">
                  <option value="Active" selected>Active</option>
                  <option value="Inactive">Inactive</option>
                </select>
              </div>

              <!-- Summary Box -->
              <div class="p-3 bg-light rounded-3 border mt-4">
                <div class="d-flex justify-content-between align-items-center">
                  <span class="text-muted small fw-bold">Total Coaches:</span>
                  <span class="badge bg-primary rounded-pill fs-6 px-3 py-2" id="coachCountBadge">0 Coaches</span>
                </div>
              </div>

            </div>
          </div>
        </div>

        <!-- Right Column: Coach Builder -->
        <div class="col-lg-8 mb-3">
          <div class="form-card h-100">
            <div class="form-header flex-wrap gap-2">
              <h5><i class="bi bi-grid-3x3-gap-fill me-2"></i> 2. Coach Composition Builder</h5>
              <button type="button" class="btn btn-sm btn-primary text-white rounded-pill px-3 fw-bold" id="addSingleCoachBtn" style="background: #1987C6; border-color: #1987C6;">
                <i class="bi bi-plus-lg me-1"></i> Add More Coach
              </button>
            </div>

            <div class="p-3">
              <p class="text-muted small mb-2">
                Add alphanumeric coach numbers (e.g., <code>A1</code>, <code>B1</code>, <code>S1</code>, <code>GEN1</code>, <code>124021</code>, <code>PC</code>, <code>EOG</code>) in order from engine to rear.
              </p>

              <!-- Coach Table -->
              <div class="table-responsive rounded-3 border mb-3" style="max-height: 420px; overflow-y: auto;">
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
                    <!-- Dynamic rows -->
                  </tbody>
                </table>
              </div>

              <!-- Add More Coach Row Button -->
              <div class="mb-3">
                <button type="button" class="btn btn-outline-primary btn-sm rounded-pill px-4 fw-bold" id="addMoreCoachBottomBtn">
                  <i class="bi bi-plus-circle me-1"></i> Add More Coach
                </button>
              </div>

              <!-- Empty State -->
              <div id="emptyCoachesState" class="text-center py-4 bg-light rounded-3 border border-dashed mt-2">
                <i class="bi bi-train-front-fill text-muted" style="font-size: 2.5rem; opacity: 0.3;"></i>
                <h6 class="text-muted mt-2 mb-1">No Coaches Added Yet</h6>
                <p class="text-muted small mb-3">Click 'Add Coach' to start adding coaches to this train.</p>
                <button type="button" class="btn btn-sm btn-primary rounded-pill px-4 fw-bold" id="addFirstCoachBtn" style="background: #1987C6; border-color: #1987C6;">
                  <i class="bi bi-plus-circle me-1"></i> Add Coach
                </button>
              </div>

              <!-- Visual Rake Strip Preview -->
              <div class="mt-3 pt-3 border-top">
                <div class="d-flex justify-content-between align-items-center mb-1">
                  <label class="form-label fw-bold text-dark small text-uppercase mb-0">
                    <i class="bi bi-eye me-1"></i> Visual Rake Strip
                  </label>
                  <button type="button" class="btn btn-link btn-sm text-danger p-0 text-decoration-none" id="clearAllCoachesBtn">
                    <i class="bi bi-trash3 me-1"></i> Clear All
                  </button>
                </div>
                <div class="d-flex flex-wrap gap-1 p-2 bg-light rounded-3 border" id="visualRakeStrip" style="min-height: 46px;">
                  <span class="text-muted small my-auto">Coaches will visually appear here in order.</span>
                </div>
              </div>

            </div>

            <div class="p-3 bg-light border-top rounded-bottom-4 d-flex justify-content-between align-items-center">
              <a href="view-trains.php" class="btn btn-secondary px-4 rounded-pill">Cancel</a>
              <button type="submit" class="btn btn-primary px-5 py-2 rounded-pill shadow-sm fw-bold" style="background: #1987C6; border-color: #1987C6;">
                <i class="bi bi-check2-circle me-1 fs-6"></i> Save Train & Coaches
              </button>
            </div>
          </div>
        </div>
      </div>
    </form>

  </div>
</main>

<script>
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
        <td class="text-center fw-bold text-muted coach-pos">${index + 1}</td>
        <td>
            <input type="text" name="coach_no[]" class="form-control text-uppercase fw-bold coach-no-input" value="${cNo}" placeholder="e.g. A1, B1, S1, 124021, PC, EOG" required autocomplete="off">
        </td>
        <td>
            <select name="coach_status[]" class="form-select">
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

    // Focus on the newly added input
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
</script>

<?php include 'footer.php'; ?>
