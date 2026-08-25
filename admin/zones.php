<?php
/**
 * MCC - Admin Panel Zone Management
 * Lists zones and processes creation and status toggle requests.
 */
$pageTitle = 'MCC Admin | Manage Zones';
require_once '../connection.php';

$message = '';
$messageType = '';

// Handle POST actions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // 1. Add Zone Action
    if (isset($_POST['action']) && $_POST['action'] === 'add_zone') {
        $zone_name = trim($_POST['zone_name'] ?? '');
        
        if (empty($zone_name)) {
            $message = 'Zone name is required.';
            $messageType = 'danger';
        } else {
            try {
                // Check duplicate
                $chk = $pdo->prepare("SELECT COUNT(*) FROM mcc_zones WHERE zone_name = :name");
                $chk->execute(['name' => $zone_name]);
                if ($chk->fetchColumn() > 0) {
                    $message = "Zone '$zone_name' already exists.";
                    $messageType = 'warning';
                } else {
                    $ins = $pdo->prepare("INSERT INTO mcc_zones (zone_name, status) VALUES (:name, 'Active')");
                    $ins->execute(['name' => $zone_name]);
                    $message = "Zone '$zone_name' successfully created.";
                    $messageType = 'success';
                }
            } catch (PDOException $e) {
                $message = 'Error creating zone: ' . $e->getMessage();
                $messageType = 'danger';
            }
        }
    }
    
    // 2. Toggle Status Action
    if (isset($_POST['action']) && $_POST['action'] === 'toggle_status') {
        $zone_id = intval($_POST['zone_id'] ?? 0);
        $current_status = $_POST['current_status'] ?? 'Active';
        $new_status = ($current_status === 'Active') ? 'Inactive' : 'Active';
        
        try {
            $upd = $pdo->prepare("UPDATE mcc_zones SET status = :status WHERE zone_id = :id");
            $upd->execute(['status' => $new_status, 'id' => $zone_id]);
            $message = "Zone status updated to $new_status.";
            $messageType = 'success';
        } catch (PDOException $e) {
            $message = 'Error updating status: ' . $e->getMessage();
            $messageType = 'danger';
        }
    }
}

// Fetch all zones with division counts
$zones = [];
try {
    $stmt = $pdo->query("
        SELECT z.*, COUNT(d.division_id) as division_count 
        FROM mcc_zones z 
        LEFT JOIN mcc_divisions d ON z.zone_id = d.zone_id 
        GROUP BY z.zone_id 
        ORDER BY z.zone_name ASC
    ");
    $zones = $stmt->fetchAll();
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
            <i class="bi bi-globe2 text-indigo me-2" style="font-size: 1.6rem;"></i>
            Manage Zonal Railways
          </h3>
        </div>
        <div class="col-md-6 text-md-end mt-2 mt-md-0">
          <span class="badge bg-indigo-subtle text-indigo p-2 px-3 border border-indigo-subtle rounded-pill">
            System Zones: <?php echo count($zones); ?>
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
        
        <!-- Left Side: Zones List Table -->
        <div class="col-lg-8">
          <div class="card shadow-sm border-0 h-100">
            <div class="card-header bg-white py-3">
              <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                <i class="bi bi-list-stars text-indigo me-2"></i> Zone Directory
              </h5>
            </div>
            <div class="card-body p-0">
              <div class="table-responsive">
                <table class="table table-hover table-striped mb-0">
                  <thead>
                    <tr>
                      <th class="ps-3" style="width: 100px;">Zone ID</th>
                      <th>Zone Name</th>
                      <th>Divisions Count</th>
                      <th>Status</th>
                      <th class="text-center" style="width: 150px;">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php if (empty($zones)): ?>
                      <tr>
                        <td colspan="5" class="text-center py-5 text-muted small">No railway zones found in the database.</td>
                      </tr>
                    <?php else: ?>
                      <?php foreach ($zones as $zone): ?>
                        <tr>
                          <td class="ps-3"><strong>ZN-<?php echo $zone['zone_id']; ?></strong></td>
                          <td><strong><?php echo htmlspecialchars($zone['zone_name']); ?></strong></td>
                          <td>
                            <span class="badge bg-secondary-subtle text-secondary border px-2 py-1">
                              <?php echo $zone['division_count']; ?> divisions
                            </span>
                          </td>
                          <td>
                            <span class="badge rounded-pill <?php echo $zone['status'] === 'Active' ? 'bg-success-subtle text-success border border-success-subtle' : 'bg-danger-subtle text-danger border border-danger-subtle'; ?>" style="font-size: 0.78rem;">
                              <?php echo htmlspecialchars($zone['status']); ?>
                            </span>
                          </td>
                          <td class="text-center">
                            <form action="zones.php" method="POST" class="d-inline">
                              <input type="hidden" name="action" value="toggle_status">
                              <input type="hidden" name="zone_id" value="<?php echo $zone['zone_id']; ?>">
                              <input type="hidden" name="current_status" value="<?php echo $zone['status']; ?>">
                              <button type="submit" class="btn btn-sm <?php echo $zone['status'] === 'Active' ? 'btn-outline-danger' : 'btn-outline-success'; ?> rounded-pill px-3 font-weight-bold">
                                <?php echo $zone['status'] === 'Active' ? 'Deactivate' : 'Activate'; ?>
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

        <!-- Right Side: Create Zone Form -->
        <div class="col-lg-4">
          <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3">
              <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                <i class="bi bi-plus-circle-fill text-indigo me-2"></i> Create Zone
              </h5>
            </div>
            <div class="card-body">
              <form action="zones.php" method="POST" autocomplete="off">
                <input type="hidden" name="action" value="add_zone">
                
                <div class="mb-3">
                  <label for="zone_name" class="form-label font-weight-bold text-secondary" style="font-size: 0.85rem; text-transform: uppercase;">Zone Name</label>
                  <input type="text" class="form-control rounded-3" id="zone_name" name="zone_name" placeholder="e.g. Eastern Railway" required>
                  <small class="text-muted mt-1 d-block">Please enter the official zonal designation.</small>
                </div>

                <button type="submit" class="btn btn-indigo w-100 p-2.5 rounded-3 font-weight-bold shadow-sm mt-2">
                  Add Zone &nbsp;<i class="bi bi-plus-lg"></i>
                </button>
              </form>
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
