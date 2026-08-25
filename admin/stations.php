<?php
/**
 * MCC - Admin Panel Station Management
 * Lists stations and processes creation and status toggle requests.
 */
$pageTitle = 'MCC Admin | Manage Stations';
require_once '../connection.php';

$message = '';
$messageType = '';

// Handle POST actions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // 1. Add Station Action
    if (isset($_POST['action']) && $_POST['action'] === 'add_station') {
        $station_name = trim($_POST['station_name'] ?? '');
        $division_id = intval($_POST['division_id'] ?? 0);
        
        if (empty($station_name) || $division_id <= 0) {
            $message = 'Station name and division are required.';
            $messageType = 'danger';
        } else {
            try {
                // Check duplicate (name + division)
                $chk = $pdo->prepare("SELECT COUNT(*) FROM mcc_stations WHERE station_name = :name AND division_id = :division");
                $chk->execute(['name' => $station_name, 'division' => $division_id]);
                if ($chk->fetchColumn() > 0) {
                    $message = "Station '$station_name' already exists in this Division.";
                    $messageType = 'warning';
                } else {
                    $ins = $pdo->prepare("INSERT INTO mcc_stations (station_name, division_id, status) VALUES (:name, :division, 'Active')");
                    $ins->execute(['name' => $station_name, 'division' => $division_id]);
                    $message = "Station '$station_name' successfully created.";
                    $messageType = 'success';
                }
            } catch (PDOException $e) {
                $message = 'Error creating station: ' . $e->getMessage();
                $messageType = 'danger';
            }
        }
    }
    
    // 2. Toggle Status Action
    if (isset($_POST['action']) && $_POST['action'] === 'toggle_status') {
        $station_id = intval($_POST['station_id'] ?? 0);
        $current_status = $_POST['current_status'] ?? 'Active';
        $new_status = ($current_status === 'Active') ? 'Inactive' : 'Active';
        
        try {
            $upd = $pdo->prepare("UPDATE mcc_stations SET status = :status WHERE station_id = :id");
            $upd->execute(['status' => $new_status, 'id' => $station_id]);
            $message = "Station status updated to $new_status.";
            $messageType = 'success';
        } catch (PDOException $e) {
            $message = 'Error updating status: ' . $e->getMessage();
            $messageType = 'danger';
        }
    }
}

// Fetch active divisions with parent zones for dropdown
$activeDivisions = [];
try {
    $activeDivisions = $pdo->query("
        SELECT d.division_id, d.division_name, z.zone_name 
        FROM mcc_divisions d 
        INNER JOIN mcc_zones z ON d.zone_id = z.zone_id 
        WHERE d.status = 'Active' 
        ORDER BY z.zone_name ASC, d.division_name ASC
    ")->fetchAll();
} catch (PDOException $e) {
    // Graceful error capture
}

// Fetch all stations with division and zone info
$stations = [];
try {
    $stmt = $pdo->query("
        SELECT s.*, d.division_name, z.zone_name 
        FROM mcc_stations s 
        INNER JOIN mcc_divisions d ON s.division_id = d.division_id 
        INNER JOIN mcc_zones z ON d.zone_id = z.zone_id 
        ORDER BY z.zone_name ASC, d.division_name ASC, s.station_name ASC
    ");
    $stations = $stmt->fetchAll();
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
        <div class="col-md-6">
          <h3 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
            <i class="bi bi-geo-alt text-indigo me-2" style="font-size: 1.6rem;"></i>
            Manage Coaching Stations
          </h3>
        </div>
        <div class="col-md-6 text-md-end mt-2 mt-md-0">
          <span class="badge bg-indigo-subtle text-indigo p-2 px-3 border border-indigo-subtle rounded-pill">
            System Stations: <?php echo count($stations); ?>
          </span>
        </div>
      </div>
    </div>
  </div>

  <!-- Content Body -->
  <div class="app-content">
    <div class="container-fluid">
      
      <?php if (!empty($message)): ?>
        <div class="alert alert-<?php echo $messageType; ?> alert-dismissible fade show rounded-3 shadow-sm mb-4" role="alert">
          <i class="bi <?php echo ($messageType === 'success') ? 'bi-check-circle-fill' : 'bi-exclamation-triangle-fill'; ?> me-2"></i>
          <?php echo htmlspecialchars($message); ?>
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      <?php endif; ?>

      <div class="row g-4">
        
        <!-- Left Side: Stations List Table -->
        <div class="col-lg-8">
          <div class="card shadow-sm border-0 h-100">
            <div class="card-header bg-white py-3">
              <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                <i class="bi bi-list-stars text-indigo me-2"></i> Station Directory
              </h5>
            </div>
            <div class="card-body p-0">
              <div class="table-responsive">
                <table class="table table-hover table-striped mb-0">
                  <thead>
                    <tr>
                      <th class="ps-3" style="width: 100px;">Station ID</th>
                      <th>Station Name</th>
                      <th>Division</th>
                      <th>Zone</th>
                      <th>Status</th>
                      <th class="text-center" style="width: 150px;">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php if (empty($stations)): ?>
                      <tr>
                        <td colspan="6" class="text-center py-5 text-muted small">No stations found in the database.</td>
                      </tr>
                    <?php else: ?>
                      <?php foreach ($stations as $stn): ?>
                        <tr>
                          <td class="ps-3"><strong>STN-<?php echo $stn['station_id']; ?></strong></td>
                          <td><strong><?php echo htmlspecialchars($stn['station_name']); ?></strong></td>
                          <td><?php echo htmlspecialchars($stn['division_name']); ?></td>
                          <td>
                            <span class="badge bg-indigo-subtle text-indigo px-2 py-1 border border-indigo-subtle">
                              <?php echo htmlspecialchars($stn['zone_name']); ?>
                            </span>
                          </td>
                          <td>
                            <span class="badge rounded-pill <?php echo $stn['status'] === 'Active' ? 'bg-success-subtle text-success border border-success-subtle' : 'bg-danger-subtle text-danger border border-danger-subtle'; ?>" style="font-size: 0.78rem;">
                              <?php echo htmlspecialchars($stn['status']); ?>
                            </span>
                          </td>
                          <td class="text-center">
                            <form action="stations.php" method="POST" class="d-inline">
                              <input type="hidden" name="action" value="toggle_status">
                              <input type="hidden" name="station_id" value="<?php echo $stn['station_id']; ?>">
                              <input type="hidden" name="current_status" value="<?php echo $stn['status']; ?>">
                              <button type="submit" class="btn btn-sm <?php echo $stn['status'] === 'Active' ? 'btn-outline-danger' : 'btn-outline-success'; ?> rounded-pill px-3 font-weight-bold">
                                <?php echo $stn['status'] === 'Active' ? 'Deactivate' : 'Activate'; ?>
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

        <!-- Right Side: Create Station Form -->
        <div class="col-lg-4">
          <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3">
              <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                <i class="bi bi-plus-circle-fill text-indigo me-2"></i> Create Station
              </h5>
            </div>
            <div class="card-body">
              <?php if (empty($activeDivisions)): ?>
                <div class="alert alert-warning text-center small rounded-3 p-3 mb-0" role="alert">
                  <i class="bi bi-exclamation-triangle-fill fs-5 d-block mb-2"></i>
                  No active Divisions found! You must create an <strong>Active Division</strong> first before adding a Station.
                  <a href="divisions.php" class="btn btn-sm btn-warning w-100 mt-3 font-weight-bold rounded-pill">Create Division</a>
                </div>
              <?php else: ?>
                <form action="stations.php" method="POST" autocomplete="off">
                  <input type="hidden" name="action" value="add_station">
                  
                  <div class="mb-3">
                    <label for="division_id" class="form-label font-weight-bold text-secondary" style="font-size: 0.85rem; text-transform: uppercase;">Division / Zone</label>
                    <select class="form-select rounded-3" id="division_id" name="division_id" required>
                      <option value="">-- Select Active Division --</option>
                      <?php foreach ($activeDivisions as $div): ?>
                        <option value="<?php echo $div['division_id']; ?>"><?php echo htmlspecialchars($div['division_name'] . ' (' . $div['zone_name'] . ')'); ?></option>
                      <?php endforeach; ?>
                    </select>
                  </div>

                  <div class="mb-3">
                    <label for="station_name" class="form-label font-weight-bold text-secondary" style="font-size: 0.85rem; text-transform: uppercase;">Station / Depot Name</label>
                    <input type="text" class="form-control rounded-3" id="station_name" name="station_name" placeholder="e.g. Lumding" required>
                    <small class="text-muted mt-1 d-block">Please enter the specific coaching depot station name.</small>
                  </div>

                  <button type="submit" class="btn btn-indigo w-100 p-2.5 rounded-3 font-weight-bold shadow-sm mt-2">
                    Add Station &nbsp;<i class="bi bi-plus-lg"></i>
                  </button>
                </form>
              <?php endif; ?>
            </div>
          </div>
        </div>

      </div>
    </div>
  </div>
</main>

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
</style>

<?php include 'footer.php'; ?>
