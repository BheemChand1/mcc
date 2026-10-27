<?php
/**
 * MCC - Admin Panel Station Mobile Backend Management
 * Allows administrators to Activate (1) and Deactivate (0) the active_backend_mobile flag for coaching stations.
 */
$pageTitle = 'MCC Admin | Mobile Backend Station Access';
require_once '../connection.php';

// Check if request is AJAX
$isAjax = (!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest') 
          || isset($_POST['is_ajax']);

// Handle POST actions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    // 1. Single Station Toggle Action
    if ($action === 'toggle_mobile_backend') {
        $station_id = intval($_POST['station_id'] ?? 0);
        $target_status = isset($_POST['target_status']) ? intval($_POST['target_status']) : null;

        if ($station_id <= 0) {
            $response = ['status' => 'error', 'message' => 'Invalid Station ID provided.'];
            if ($isAjax) {
                header('Content-Type: application/json');
                echo json_encode($response);
                exit();
            }
            $message = $response['message'];
            $messageType = 'danger';
        } else {
            try {
                // If target_status is not explicitly provided, invert current status
                if ($target_status === null) {
                    $chk = $pdo->prepare("SELECT active_backend_mobile FROM mcc_stations WHERE station_id = :id");
                    $chk->execute([':id' => $station_id]);
                    $current = $chk->fetchColumn();
                    $target_status = ($current == 1) ? 0 : 1;
                } else {
                    $target_status = ($target_status == 1) ? 1 : 0;
                }

                $stmt = $pdo->prepare("UPDATE mcc_stations SET active_backend_mobile = :status, updated_at = NOW() WHERE station_id = :id");
                $stmt->execute([':status' => $target_status, ':id' => $station_id]);

                $statusLabel = ($target_status === 1) ? 'Activated (1)' : 'Deactivated (0)';
                $response = [
                    'status' => 'success',
                    'station_id' => $station_id,
                    'active_backend_mobile' => $target_status,
                    'message' => "Station Mobile Backend successfully {$statusLabel}."
                ];

                if ($isAjax) {
                    header('Content-Type: application/json');
                    echo json_encode($response);
                    exit();
                }

                $message = $response['message'];
                $messageType = 'success';
            } catch (PDOException $e) {
                $response = ['status' => 'error', 'message' => 'Database error: ' . $e->getMessage()];
                if ($isAjax) {
                    header('Content-Type: application/json');
                    echo json_encode($response);
                    exit();
                }
                $message = $response['message'];
                $messageType = 'danger';
            }
        }
    }

    // 2. Bulk Action: Activate All or Deactivate All
    if ($action === 'bulk_mobile_backend') {
        $target_status = intval($_POST['bulk_status'] ?? 1);
        $target_status = ($target_status === 1) ? 1 : 0;

        try {
            $stmt = $pdo->prepare("UPDATE mcc_stations SET active_backend_mobile = :status, updated_at = NOW()");
            $stmt->execute([':status' => $target_status]);
            $count = $stmt->rowCount();

            $statusLabel = ($target_status === 1) ? 'Activated (1)' : 'Deactivated (0)';
            $message = "All stations ({$count} updated) have been {$statusLabel} for mobile backend access.";
            $messageType = 'success';
        } catch (PDOException $e) {
            $message = 'Error during bulk update: ' . $e->getMessage();
            $messageType = 'danger';
        }
    }
}

// Fetch all stations with division and zone info
$stations = [];
$totalStations = 0;
$activeMobileCount = 0;
$inactiveMobileCount = 0;

try {
    $stmt = $pdo->query("
        SELECT 
            s.station_id, 
            s.station_name, 
            s.division_id, 
            s.status, 
            COALESCE(s.active_backend_mobile, 1) AS active_backend_mobile, 
            s.contractor_name,
            s.updated_at,
            d.division_name, 
            z.zone_name 
        FROM mcc_stations s 
        LEFT JOIN mcc_divisions d ON s.division_id = d.division_id 
        LEFT JOIN mcc_zones z ON d.zone_id = z.zone_id 
        ORDER BY z.zone_name ASC, d.division_name ASC, s.station_name ASC
    ");
    $stations = $stmt->fetchAll(PDO::FETCH_ASSOC);

    $totalStations = count($stations);
    foreach ($stations as $stn) {
        if ($stn['active_backend_mobile'] == 1) {
            $activeMobileCount++;
        } else {
            $inactiveMobileCount++;
        }
    }
} catch (PDOException $e) {
    $dbError = $e->getMessage();
}

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
  <!-- Content Header -->
  <div class="app-content-header py-3 mb-3 border-bottom bg-white shadow-sm">
    <div class="container-fluid">
      <div class="row align-items-center">
        <div class="col-md-7">
          <h3 class="mb-1 font-weight-bold text-dark d-flex align-items-center">
            <i class="bi bi-phone-vibrate text-indigo me-2" style="font-size: 1.6rem;"></i>
            Mobile Backend Station Access
          </h3>
          <p class="text-muted small mb-0">Control the <code>active_backend_mobile</code> flag (1 = Active / Yes, 0 = Inactive / No) for mobile application synchronization.</p>
        </div>
        <div class="col-md-5 text-md-end mt-2 mt-md-0 d-flex gap-2 justify-content-md-end flex-wrap">
          <a href="#apiReferenceModal" data-bs-toggle="modal" class="btn btn-outline-indigo btn-sm rounded-pill px-3 shadow-sm">
            <i class="bi bi-code-slash me-1"></i> View API Details
          </a>
          <a href="stations.php" class="btn btn-light btn-sm rounded-pill px-3 border shadow-sm">
            <i class="bi bi-geo-alt me-1"></i> Manage Stations
          </a>
        </div>
      </div>
    </div>
  </div>

  <!-- Content Body -->
  <div class="app-content">
    <div class="container-fluid">
      
      <!-- Feedback Message -->
      <?php if (!empty($message)): ?>
        <div class="alert alert-<?= $messageType; ?> alert-dismissible fade show rounded-3 shadow-sm mb-4" role="alert">
          <i class="bi <?= ($messageType === 'success') ? 'bi-check-circle-fill' : 'bi-exclamation-triangle-fill'; ?> me-2"></i>
          <?= htmlspecialchars($message); ?>
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      <?php endif; ?>

      <!-- Stat Overview Cards -->
      <div class="row g-3 mb-4">
        <!-- Total Stations -->
        <div class="col-sm-6 col-lg-3">
          <div class="card border-0 shadow-sm rounded-3 p-3 h-100 bg-white">
            <div class="d-flex align-items-center justify-content-between">
              <div>
                <span class="text-muted small font-weight-bold text-uppercase">Total Stations</span>
                <h3 class="mb-0 mt-1 font-weight-bold text-dark"><?= $totalStations; ?></h3>
              </div>
              <div class="icon-circle bg-primary-subtle text-primary rounded-circle p-3 d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                <i class="bi bi-building fs-4"></i>
              </div>
            </div>
            <div class="mt-2 text-muted small">Registered in system</div>
          </div>
        </div>

        <!-- Mobile Active (1) -->
        <div class="col-sm-6 col-lg-3">
          <div class="card border-0 shadow-sm rounded-3 p-3 h-100 bg-white border-start border-4 border-success">
            <div class="d-flex align-items-center justify-content-between">
              <div>
                <span class="text-muted small font-weight-bold text-uppercase">Mobile Active (1)</span>
                <h3 class="mb-0 mt-1 font-weight-bold text-success" id="stat-active-count"><?= $activeMobileCount; ?></h3>
              </div>
              <div class="icon-circle bg-success-subtle text-success rounded-circle p-3 d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                <i class="bi bi-phone text-success fs-4"></i>
              </div>
            </div>
            <div class="mt-2 text-success small font-weight-bold"><i class="bi bi-check-circle me-1"></i> API Response: 1 (Yes)</div>
          </div>
        </div>

        <!-- Mobile Inactive (0) -->
        <div class="col-sm-6 col-lg-3">
          <div class="card border-0 shadow-sm rounded-3 p-3 h-100 bg-white border-start border-4 border-danger">
            <div class="d-flex align-items-center justify-content-between">
              <div>
                <span class="text-muted small font-weight-bold text-uppercase">Mobile Inactive (0)</span>
                <h3 class="mb-0 mt-1 font-weight-bold text-danger" id="stat-inactive-count"><?= $inactiveMobileCount; ?></h3>
              </div>
              <div class="icon-circle bg-danger-subtle text-danger rounded-circle p-3 d-flex align-items-center justify-content-center" style="width: 50px; height: 50px;">
                <i class="bi bi-phone-slash text-danger fs-4"></i>
              </div>
            </div>
            <div class="mt-2 text-danger small font-weight-bold"><i class="bi bi-slash-circle me-1"></i> API Response: 0 (No)</div>
          </div>
        </div>

        <!-- API Endpoint Card -->
        <div class="col-sm-6 col-lg-3">
          <div class="card border-0 shadow-sm rounded-3 p-3 h-100 bg-indigo-subtle border border-indigo-subtle">
            <div class="d-flex align-items-center justify-content-between">
              <div>
                <span class="text-indigo small font-weight-bold text-uppercase">Mobile API Endpoint</span>
                <div class="font-monospace text-indigo fw-bold mt-1" style="font-size: 0.85rem;">/api/stations/status.php</div>
              </div>
              <div class="icon-circle bg-white text-indigo rounded-circle p-3 d-flex align-items-center justify-content-center shadow-sm" style="width: 50px; height: 50px;">
                <i class="bi bi-broadcast-pin fs-4"></i>
              </div>
            </div>
            <div class="mt-2">
              <a href="../api/stations/status.php" target="_blank" class="btn btn-sm btn-indigo w-100 rounded-pill py-1" style="font-size: 0.78rem;">
                <i class="bi bi-box-arrow-up-right me-1"></i> Test Live JSON Feed
              </a>
            </div>
          </div>
        </div>
      </div>

      <!-- Main Directory Card -->
      <div class="card shadow-sm border-0 mb-4">
        <div class="card-header bg-white py-3 border-bottom d-flex align-items-center justify-content-between flex-wrap gap-2">
          <div class="d-flex align-items-center">
            <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
              <i class="bi bi-toggles text-indigo me-2"></i> Station Mobile Access Directory
            </h5>
            <span class="badge bg-secondary-subtle text-secondary ms-2 rounded-pill"><?= $totalStations; ?> Stations</span>
          </div>
          
          <!-- Bulk actions and Search -->
          <div class="d-flex align-items-center gap-2 flex-wrap">
            <div class="input-group input-group-sm" style="width: 240px;">
              <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
              <input type="text" id="stationSearchInput" class="form-control border-start-0 ps-0" placeholder="Search station, division...">
            </div>

            <div class="dropdown">
              <button class="btn btn-sm btn-outline-secondary dropdown-toggle rounded-pill px-3" type="button" data-bs-toggle="dropdown">
                <i class="bi bi-gear-fill me-1"></i> Bulk Actions
              </button>
              <ul class="dropdown-menu dropdown-menu-end shadow-sm">
                <li>
                  <form method="POST" action="station-mobile-status.php" onsubmit="return confirm('Activate Mobile Backend for ALL stations?');">
                    <input type="hidden" name="action" value="bulk_mobile_backend">
                    <input type="hidden" name="bulk_status" value="1">
                    <button type="submit" class="dropdown-item text-success">
                      <i class="bi bi-check2-all me-2"></i> Activate All (Set 1)
                    </button>
                  </form>
                </li>
                <li>
                  <form method="POST" action="station-mobile-status.php" onsubmit="return confirm('Deactivate Mobile Backend for ALL stations?');">
                    <input type="hidden" name="action" value="bulk_mobile_backend">
                    <input type="hidden" name="bulk_status" value="0">
                    <button type="submit" class="dropdown-item text-danger">
                      <i class="bi bi-x-circle me-2"></i> Deactivate All (Set 0)
                    </button>
                  </form>
                </li>
              </ul>
            </div>
          </div>
        </div>

        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table table-hover align-middle mb-0" id="stationsTable">
              <thead class="table-light">
                <tr>
                  <th class="ps-3" style="width: 90px;">ID</th>
                  <th>Station Name</th>
                  <th>Division & Zone</th>
                  <th>System Status</th>
                  <th class="text-center" style="width: 220px;">Mobile Backend (0 or 1)</th>
                  <th class="text-center" style="width: 140px;">Live API Test</th>
                </tr>
              </thead>
              <tbody>
                <?php if (empty($stations)): ?>
                  <tr>
                    <td colspan="6" class="text-center py-5 text-muted">No stations found in the database.</td>
                  </tr>
                <?php else: ?>
                  <?php foreach ($stations as $stn): 
                    $isActive = ($stn['active_backend_mobile'] == 1);
                  ?>
                    <tr id="row-station-<?= $stn['station_id']; ?>" class="station-row" data-search="<?= strtolower(htmlspecialchars($stn['station_name'] . ' ' . $stn['division_name'] . ' ' . $stn['zone_name'])); ?>">
                      <td class="ps-3">
                        <span class="badge bg-light text-dark border font-monospace">STN-<?= $stn['station_id']; ?></span>
                      </td>
                      <td>
                        <div class="fw-bold text-dark fs-6"><?= htmlspecialchars($stn['station_name']); ?></div>
                        <small class="text-muted"><i class="bi bi-briefcase me-1"></i><?= htmlspecialchars($stn['contractor_name'] ?: 'No contractor'); ?></small>
                      </td>
                      <td>
                        <div><strong class="text-dark"><?= htmlspecialchars($stn['division_name'] ?: 'N/A'); ?></strong></div>
                        <small class="text-muted"><?= htmlspecialchars($stn['zone_name'] ?: 'N/A'); ?></small>
                      </td>
                      <td>
                        <span class="badge rounded-pill <?= $stn['status'] === 'Active' ? 'bg-success-subtle text-success border border-success-subtle' : 'bg-secondary-subtle text-secondary border'; ?>">
                          <?= htmlspecialchars($stn['status']); ?>
                        </span>
                      </td>
                      <td class="text-center">
                        <div class="d-flex align-items-center justify-content-center gap-2">
                          <!-- Status badge indicator -->
                          <span id="badge-<?= $stn['station_id']; ?>" class="badge rounded-pill status-pill px-3 py-1.5 <?= $isActive ? 'bg-success text-white' : 'bg-danger text-white'; ?>" style="font-size: 0.82rem; min-width: 100px;">
                            <i class="bi <?= $isActive ? 'bi-check-circle-fill' : 'bi-x-circle-fill'; ?> me-1"></i>
                            <span class="status-text"><?= $isActive ? 'Active (1)' : 'Inactive (0)'; ?></span>
                          </span>

                          <!-- Interactive Toggle Switch -->
                          <div class="form-check form-switch m-0 ps-3">
                            <input class="form-check-input mobile-toggle-switch" 
                                   type="checkbox" 
                                   role="switch" 
                                   id="toggle-<?= $stn['station_id']; ?>" 
                                   data-station-id="<?= $stn['station_id']; ?>"
                                   <?= $isActive ? 'checked' : ''; ?>
                                   style="width: 2.5em; height: 1.3em; cursor: pointer;">
                          </div>

                          <!-- Fallback POST Form (hidden, triggered if JS is disabled) -->
                          <form method="POST" action="station-mobile-status.php" class="d-none" id="fallback-form-<?= $stn['station_id']; ?>">
                            <input type="hidden" name="action" value="toggle_mobile_backend">
                            <input type="hidden" name="station_id" value="<?= $stn['station_id']; ?>">
                            <input type="hidden" name="target_status" value="<?= $isActive ? '0' : '1'; ?>">
                            <button type="submit" class="btn btn-sm btn-outline-secondary">Toggle</button>
                          </form>
                        </div>
                      </td>
                      <td class="text-center">
                        <button type="button" 
                                class="btn btn-sm btn-outline-indigo rounded-pill px-3 btn-test-api" 
                                data-station-id="<?= $stn['station_id']; ?>" 
                                data-station-name="<?= htmlspecialchars($stn['station_name']); ?>">
                          <i class="bi bi-play-circle me-1"></i> Test JSON
                        </button>
                      </td>
                    </tr>
                  <?php endforeach; ?>
                <?php endif; ?>
              </tbody>
            </table>
          </div>
        </div>
      </div>

      <!-- Developer API Guide Card -->
      <div class="card shadow-sm border-0 mb-4 bg-white">
        <div class="card-header bg-white py-3 border-bottom d-flex align-items-center justify-content-between">
          <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
            <i class="bi bi-file-earmark-code text-indigo me-2"></i> Mobile App Integration & API Reference
          </h5>
          <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill">Status 0 or 1 Live API</span>
        </div>
        <div class="card-body">
          <div class="row g-4">
            <div class="col-lg-6">
              <h6 class="font-weight-bold text-dark mb-2">1. Check Specific Station Mobile Backend Status</h6>
              <p class="text-muted small">Pass the <code>station_id</code> via query parameter, POST body, or JSON payload to check if the station's mobile backend is enabled (1) or disabled (0).</p>
              
              <div class="bg-dark text-light p-3 rounded-3 font-monospace small position-relative mb-3">
                <span class="badge bg-primary position-absolute top-0 end-0 m-2">GET / POST</span>
                <div class="text-warning mb-1">// Request Endpoint:</div>
                <div>/api/stations/status.php?station_id=1</div>
              </div>

              <div class="bg-light p-3 rounded-3 font-monospace small border">
                <div class="text-success fw-bold mb-1">// Sample JSON Response (When Active = 1):</div>
                <pre class="mb-0" style="font-size: 0.8rem;">{
  "status": "success",
  "station_id": 1,
  "station_name": "Mysore",
  "division_name": "Mysore",
  "zone_name": "South Western Railway",
  "active_backend_mobile": 1,
  "is_active": true,
  "message": "Station backend mobile is active."
}</pre>
              </div>
            </div>

            <div class="col-lg-6">
              <h6 class="font-weight-bold text-dark mb-2">2. Fetch All Stations with Status (0 / 1)</h6>
              <p class="text-muted small">Calling the endpoint without parameters returns all registered stations with their respective <code>active_backend_mobile</code> flag.</p>

              <div class="bg-dark text-light p-3 rounded-3 font-monospace small position-relative mb-3">
                <span class="badge bg-primary position-absolute top-0 end-0 m-2">GET</span>
                <div class="text-warning mb-1">// Request Endpoint:</div>
                <div>/api/stations/status.php</div>
              </div>

              <div class="bg-light p-3 rounded-3 font-monospace small border">
                <div class="text-danger fw-bold mb-1">// Sample JSON Response (When Inactive = 0):</div>
                <pre class="mb-0" style="font-size: 0.8rem;">{
  "status": "success",
  "station_id": 4,
  "station_name": "Silchar",
  "division_name": "Lumding",
  "zone_name": "Northeast Frontier Railway",
  "active_backend_mobile": 0,
  "is_active": false,
  "message": "Station backend mobile is inactive."
}</pre>
              </div>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</main>

<!-- Live API Test Modal -->
<div class="modal fade" id="apiTestModal" tabindex="-1" aria-labelledby="apiTestModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content border-0 shadow">
      <div class="modal-header bg-dark text-white">
        <h5 class="modal-title font-monospace" id="apiTestModalLabel">
          <i class="bi bi-terminal me-2 text-warning"></i>Live API Inspector
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-4 bg-light">
        <div class="d-flex align-items-center justify-content-between mb-2">
          <span class="small font-weight-bold text-muted text-uppercase">Endpoint URL:</span>
          <span id="apiModalUrl" class="font-monospace small badge bg-indigo-subtle text-indigo p-2 border"></span>
        </div>
        <div class="bg-dark text-light p-3 rounded-3 position-relative" style="min-height: 180px;">
          <div id="apiModalLoader" class="text-center py-4 text-warning">
            <div class="spinner-border spinner-border-sm me-2" role="status"></div> Loading live API response...
          </div>
          <pre id="apiModalOutput" class="mb-0 font-monospace text-light" style="font-size: 0.85rem; max-height: 380px; overflow-y: auto; display: none;"></pre>
        </div>
      </div>
      <div class="modal-footer bg-white">
        <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Close</button>
        <a id="apiModalDirectLink" href="#" target="_blank" class="btn btn-indigo rounded-pill px-4">
          <i class="bi bi-box-arrow-up-right me-1"></i> Open in New Tab
        </a>
      </div>
    </div>
  </div>
</div>

<!-- API Reference Modal -->
<div class="modal fade" id="apiReferenceModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content border-0 shadow">
      <div class="modal-header bg-indigo text-white">
        <h5 class="modal-title"><i class="bi bi-code-slash me-2"></i>API Technical Specification</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-4">
        <div class="table-responsive">
          <table class="table table-bordered">
            <tbody>
              <tr>
                <th style="width: 180px;" class="bg-light">Endpoint</th>
                <td><code>/api/stations/status.php</code></td>
              </tr>
              <tr>
                <th class="bg-light">Supported Methods</th>
                <td><span class="badge bg-success">GET</span> <span class="badge bg-primary">POST</span></td>
              </tr>
              <tr>
                <th class="bg-light">Query Parameters</th>
                <td>
                  <div><code>station_id</code> (optional, integer): ID of station to check.</div>
                  <div><code>user_id</code> (optional, integer): ID of user to check their assigned station.</div>
                  <div class="text-muted small mt-1">If omitted, all stations with their status are returned in an array.</div>
                </td>
              </tr>
              <tr>
                <th class="bg-light">Key Output Field</th>
                <td>
                  <strong class="text-indigo"><code>active_backend_mobile</code></strong>
                  <div><code>1</code> = Yes / Active (Mobile app backend access granted)</div>
                  <div><code>0</code> = No / Inactive (Mobile app backend access restricted)</div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary rounded-pill px-4" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!-- Floating Toast Notification -->
<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 1090">
  <div id="liveToast" class="toast align-items-center text-white border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="d-flex">
      <div class="toast-body d-flex align-items-center" id="toastMessage">
        <i class="bi bi-info-circle-fill me-2 fs-5"></i> Action completed.
      </div>
      <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
  </div>
</div>

<style>
  .btn-indigo {
    background: linear-gradient(135deg, var(--admin-primary) 0%, var(--admin-primary-dark) 100%);
    color: white;
    border: none;
    transition: all 0.3s ease;
  }
  .btn-indigo:hover {
    box-shadow: 0 4px 15px rgba(99, 102, 241, 0.4);
    transform: translateY(-1px);
    color: white;
  }
  .btn-outline-indigo {
    border-color: var(--admin-primary);
    color: var(--admin-primary);
    transition: all 0.3s ease;
  }
  .btn-outline-indigo:hover {
    background-color: var(--admin-primary);
    color: white;
  }
  .form-check-input:checked {
    background-color: #10b981;
    border-color: #10b981;
  }
  .form-check-input:not(:checked) {
    background-color: #ef4444;
    border-color: #ef4444;
  }
  .status-pill {
    transition: all 0.3s ease;
  }
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
  const toastEl = document.getElementById('liveToast');
  const toast = new bootstrap.Toast(toastEl, { delay: 3500 });
  const toastMsg = document.getElementById('toastMessage');

  function showToast(message, isSuccess) {
    toastEl.className = 'toast align-items-center text-white border-0 shadow-lg ' + (isSuccess ? 'bg-success' : 'bg-danger');
    toastMsg.innerHTML = '<i class="bi ' + (isSuccess ? 'bi-check-circle-fill' : 'bi-exclamation-triangle-fill') + ' me-2 fs-5"></i> ' + message;
    toast.show();
  }

  // Live Toggle Switch Handler (AJAX)
  const switches = document.querySelectorAll('.mobile-toggle-switch');
  switches.forEach(function(sw) {
    sw.addEventListener('change', function() {
      const stationId = this.getAttribute('data-station-id');
      const isChecked = this.checked;
      const targetStatus = isChecked ? 1 : 0;
      const badge = document.getElementById('badge-' + stationId);
      const switchInput = this;

      // Optimistic UI updates
      switchInput.disabled = true;

      const formData = new FormData();
      formData.append('action', 'toggle_mobile_backend');
      formData.append('station_id', stationId);
      formData.append('target_status', targetStatus);
      formData.append('is_ajax', '1');

      fetch('station-mobile-status.php', {
        method: 'POST',
        headers: {
          'X-Requested-With': 'XMLHttpRequest'
        },
        body: formData
      })
      .then(response => response.json())
      .then(data => {
        switchInput.disabled = false;
        if (data.status === 'success') {
          // Update Badge UI
          if (data.active_backend_mobile === 1) {
            badge.className = 'badge rounded-pill status-pill px-3 py-1.5 bg-success text-white';
            badge.innerHTML = '<i class="bi bi-check-circle-fill me-1"></i> <span class="status-text">Active (1)</span>';
          } else {
            badge.className = 'badge rounded-pill status-pill px-3 py-1.5 bg-danger text-white';
            badge.innerHTML = '<i class="bi bi-x-circle-fill me-1"></i> <span class="status-text">Inactive (0)</span>';
          }

          // Recalculate stat counters
          updateCounterSummary();
          showToast(data.message, true);
        } else {
          // Revert checkbox
          switchInput.checked = !isChecked;
          showToast(data.message || 'Failed to update status', false);
        }
      })
      .catch(err => {
        switchInput.disabled = false;
        switchInput.checked = !isChecked;
        showToast('Network error: ' + err.message, false);
      });
    });
  });

  // Function to dynamically recalculate active & inactive counters
  function updateCounterSummary() {
    let active = 0;
    let inactive = 0;
    document.querySelectorAll('.mobile-toggle-switch').forEach(s => {
      if (s.checked) {
        active++;
      } else {
        inactive++;
      }
    });
    const activeEl = document.getElementById('stat-active-count');
    const inactiveEl = document.getElementById('stat-inactive-count');
    if (activeEl) activeEl.textContent = active;
    if (inactiveEl) inactiveEl.textContent = inactive;
  }

  // Search filter
  const searchInput = document.getElementById('stationSearchInput');
  if (searchInput) {
    searchInput.addEventListener('input', function() {
      const q = this.value.trim().toLowerCase();
      document.querySelectorAll('.station-row').forEach(row => {
        const text = row.getAttribute('data-search') || '';
        row.style.display = text.includes(q) ? '' : 'none';
      });
    });
  }

  // Live API Modal Inspector
  const apiModal = new bootstrap.Modal(document.getElementById('apiTestModal'));
  const apiModalUrl = document.getElementById('apiModalUrl');
  const apiModalLoader = document.getElementById('apiModalLoader');
  const apiModalOutput = document.getElementById('apiModalOutput');
  const apiModalDirectLink = document.getElementById('apiModalDirectLink');

  document.querySelectorAll('.btn-test-api').forEach(btn => {
    btn.addEventListener('click', function() {
      const stationId = this.getAttribute('data-station-id');
      const stationName = this.getAttribute('data-station-name');
      const url = '../api/stations/status.php?station_id=' + stationId;

      apiModalUrl.textContent = url;
      apiModalDirectLink.href = url;
      apiModalLoader.style.display = 'block';
      apiModalOutput.style.display = 'none';
      apiModalOutput.textContent = '';
      
      document.getElementById('apiTestModalLabel').innerHTML = '<i class="bi bi-terminal me-2 text-warning"></i>Testing: ' + stationName + ' (ID: ' + stationId + ')';
      apiModal.show();

      fetch(url)
      .then(res => res.json())
      .then(json => {
        apiModalLoader.style.display = 'none';
        apiModalOutput.style.display = 'block';
        apiModalOutput.textContent = JSON.stringify(json, null, 4);
      })
      .catch(err => {
        apiModalLoader.style.display = 'none';
        apiModalOutput.style.display = 'block';
        apiModalOutput.textContent = 'Error connecting to API: ' + err.message;
      });
    });
  });
});
</script>

<?php include 'footer.php'; ?>
