<?php
/**
 * MCC - Admin Panel Division Management
 * Lists divisions and processes creation and status toggle requests.
 */
$pageTitle = 'MCC Admin | Manage Divisions';
require_once '../connection.php';

$message = '';
$messageType = '';

// Handle POST actions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // 1. Add Division Action
    if (isset($_POST['action']) && $_POST['action'] === 'add_division') {
        $division_name = trim($_POST['division_name'] ?? '');
        $zone_id = intval($_POST['zone_id'] ?? 0);
        
        if (empty($division_name) || $zone_id <= 0) {
            $message = 'Division name and zone are required.';
            $messageType = 'danger';
        } else {
            try {
                // Check duplicate (name + zone)
                $chk = $pdo->prepare("SELECT COUNT(*) FROM mcc_divisions WHERE division_name = :name AND zone_id = :zone");
                $chk->execute(['name' => $division_name, 'zone' => $zone_id]);
                if ($chk->fetchColumn() > 0) {
                    $message = "Division '$division_name' already exists in this Zone.";
                    $messageType = 'warning';
                } else {
                    $ins = $pdo->prepare("INSERT INTO mcc_divisions (division_name, zone_id, status) VALUES (:name, :zone, 'Active')");
                    $ins->execute(['name' => $division_name, 'zone' => $zone_id]);
                    $message = "Division '$division_name' successfully created.";
                    $messageType = 'success';
                }
            } catch (PDOException $e) {
                $message = 'Error creating division: ' . $e->getMessage();
                $messageType = 'danger';
            }
        }
    }
    
    // 2. Toggle Status Action
    if (isset($_POST['action']) && $_POST['action'] === 'toggle_status') {
        $division_id = intval($_POST['division_id'] ?? 0);
        $current_status = $_POST['current_status'] ?? 'Active';
        $new_status = ($current_status === 'Active') ? 'Inactive' : 'Active';
        
        try {
            $upd = $pdo->prepare("UPDATE mcc_divisions SET status = :status WHERE division_id = :id");
            $upd->execute(['status' => $new_status, 'id' => $division_id]);
            $message = "Division status updated to $new_status.";
            $messageType = 'success';
        } catch (PDOException $e) {
            $message = 'Error updating status: ' . $e->getMessage();
            $messageType = 'danger';
        }
    }
}

// Fetch active zones for dropdown
$activeZones = [];
try {
    $activeZones = $pdo->query("SELECT zone_id, zone_name FROM mcc_zones WHERE status = 'Active' ORDER BY zone_name ASC")->fetchAll();
} catch (PDOException $e) {
    // Graceful error capture
}

// Fetch all divisions with zone details and station counts
$divisions = [];
try {
    $stmt = $pdo->query("
        SELECT d.*, z.zone_name, COUNT(s.station_id) as station_count 
        FROM mcc_divisions d 
        INNER JOIN mcc_zones z ON d.zone_id = z.zone_id 
        LEFT JOIN mcc_stations s ON d.division_id = s.division_id 
        GROUP BY d.division_id 
        ORDER BY z.zone_name ASC, d.division_name ASC
    ");
    $divisions = $stmt->fetchAll();
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
            <i class="bi bi-diagram-3 text-indigo me-2" style="font-size: 1.6rem;"></i>
            Manage Railway Divisions
          </h3>
        </div>
        <div class="col-md-6 text-md-end mt-2 mt-md-0">
          <span class="badge bg-indigo-subtle text-indigo p-2 px-3 border border-indigo-subtle rounded-pill">
            System Divisions: <?php echo count($divisions); ?>
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
        
        <!-- Left Side: Divisions List Table -->
        <div class="col-lg-8">
          <div class="card shadow-sm border-0 h-100">
            <div class="card-header bg-white py-3">
              <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                <i class="bi bi-list-stars text-indigo me-2"></i> Division Directory
              </h5>
            </div>
            <div class="card-body p-0">
              <div class="table-responsive">
                <table class="table table-hover table-striped mb-0">
                  <thead>
                    <tr>
                      <th class="ps-3" style="width: 100px;">Division ID</th>
                      <th>Division Name</th>
                      <th>Parent Zonal Railway</th>
                      <th>Stations</th>
                      <th>Status</th>
                      <th class="text-center" style="width: 150px;">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php if (empty($divisions)): ?>
                      <tr>
                        <td colspan="6" class="text-center py-5 text-muted small">No divisions found in the database.</td>
                      </tr>
                    <?php else: ?>
                      <?php foreach ($divisions as $div): ?>
                        <tr>
                          <td class="ps-3"><strong>DIV-<?php echo $div['division_id']; ?></strong></td>
                          <td><strong><?php echo htmlspecialchars($div['division_name']); ?></strong></td>
                          <td>
                            <span class="badge bg-indigo-subtle text-indigo px-2.5 py-1 border border-indigo-subtle">
                              <i class="bi bi-globe2 me-1"></i> <?php echo htmlspecialchars($div['zone_name']); ?>
                            </span>
                          </td>
                          <td>
                            <span class="badge bg-secondary-subtle text-secondary border px-2 py-1">
                              <?php echo $div['station_count']; ?> stations
                            </span>
                          </td>
                          <td>
                            <span class="badge rounded-pill <?php echo $div['status'] === 'Active' ? 'bg-success-subtle text-success border border-success-subtle' : 'bg-danger-subtle text-danger border border-danger-subtle'; ?>" style="font-size: 0.78rem;">
                              <?php echo htmlspecialchars($div['status']); ?>
                            </span>
                          </td>
                          <td class="text-center">
                            <form action="divisions.php" method="POST" class="d-inline">
                              <input type="hidden" name="action" value="toggle_status">
                              <input type="hidden" name="division_id" value="<?php echo $div['division_id']; ?>">
                              <input type="hidden" name="current_status" value="<?php echo $div['status']; ?>">
                              <button type="submit" class="btn btn-sm <?php echo $div['status'] === 'Active' ? 'btn-outline-danger' : 'btn-outline-success'; ?> rounded-pill px-3 font-weight-bold">
                                <?php echo $div['status'] === 'Active' ? 'Deactivate' : 'Activate'; ?>
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

        <!-- Right Side: Create Division Form -->
        <div class="col-lg-4">
          <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3">
              <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                <i class="bi bi-plus-circle-fill text-indigo me-2"></i> Create Division
              </h5>
            </div>
            <div class="card-body">
              <?php if (empty($activeZones)): ?>
                <div class="alert alert-warning text-center small rounded-3 p-3 mb-0" role="alert">
                  <i class="bi bi-exclamation-triangle-fill fs-5 d-block mb-2"></i>
                  No active Zones found! You must create an <strong>Active Zone</strong> first before adding a Division.
                  <a href="zones.php" class="btn btn-sm btn-warning w-100 mt-3 font-weight-bold rounded-pill">Create Zone</a>
                </div>
              <?php else: ?>
                <form action="divisions.php" method="POST" autocomplete="off">
                  <input type="hidden" name="action" value="add_division">
                  
                  <div class="mb-3">
                    <label for="zone_id" class="form-label font-weight-bold text-secondary" style="font-size: 0.85rem; text-transform: uppercase;">Zonal Railway</label>
                    <select class="form-select rounded-3" id="zone_id" name="zone_id" required>
                      <option value="">-- Select Active Zone --</option>
                      <?php foreach ($activeZones as $zone): ?>
                        <option value="<?php echo $zone['zone_id']; ?>"><?php echo htmlspecialchars($zone['zone_name']); ?></option>
                      <?php endforeach; ?>
                    </select>
                  </div>

                  <div class="mb-3">
                    <label for="division_name" class="form-label font-weight-bold text-secondary" style="font-size: 0.85rem; text-transform: uppercase;">Division Name</label>
                    <input type="text" class="form-control rounded-3" id="division_name" name="division_name" placeholder="e.g. Howrah" required>
                    <small class="text-muted mt-1 d-block">Please enter the division name under the selected zone.</small>
                  </div>

                  <button type="submit" class="btn btn-indigo w-100 p-2.5 rounded-3 font-weight-bold shadow-sm mt-2">
                    Add Division &nbsp;<i class="bi bi-plus-lg"></i>
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
