<?php
/**
 * MCC - Admin Panel Dashboard Landing Page
 * Displays overall statistics, analytics charts, and user/station logs.
 */
$pageTitle = 'MCC Admin Panel | Dashboard';

require_once '../connection.php';

// Initialize count values
$totalUsers = 0;
$activeStations = 0;
$activeEmployees = 0;
$totalDivisions = 0;

$recentUsers = [];
$stationsList = [];
$roleData = [];
$designationData = [];

try {
    // 1. KPI Counts
    $totalUsers = $pdo->query("SELECT COUNT(*) FROM mcc_users")->fetchColumn();
    $activeStations = $pdo->query("SELECT COUNT(*) FROM mcc_stations WHERE status = 'Active'")->fetchColumn();
    $activeEmployees = $pdo->query("SELECT COUNT(*) FROM mcc_employee WHERE status = 'Active'")->fetchColumn();
    $totalDivisions = $pdo->query("SELECT COUNT(*) FROM mcc_divisions")->fetchColumn();

    // 2. Fetch 5 Recent Registered Users
    $stmt = $pdo->query("
        SELECT u.*, s.station_name 
        FROM mcc_users u 
        LEFT JOIN mcc_stations s ON u.station_id = s.station_id 
        ORDER BY u.created_at DESC 
        LIMIT 5
    ");
    $recentUsers = $stmt->fetchAll();

    // 3. Fetch 5 Active Stations with Division info
    $stmt = $pdo->query("
        SELECT s.*, d.division_name 
        FROM mcc_stations s 
        LEFT JOIN mcc_divisions d ON s.division_id = d.division_id 
        ORDER BY s.station_name ASC 
        LIMIT 5
    ");
    $stationsList = $stmt->fetchAll();

    // 4. Role distribution for Chart.js
    $stmt = $pdo->query("SELECT role, COUNT(*) as count FROM mcc_users GROUP BY role");
    $roleRows = $stmt->fetchAll();
    foreach ($roleRows as $row) {
        $roleData[$row['role'] ? $row['role'] : 'UNASSIGNED'] = (int)$row['count'];
    }

    // 5. Employee designation breakdown for Chart.js
    $stmt = $pdo->query("
        SELECT designation, COUNT(*) as count 
        FROM mcc_employee 
        WHERE designation IS NOT NULL AND designation != '' 
        GROUP BY designation 
        ORDER BY count DESC 
        LIMIT 5
    ");
    $designationRows = $stmt->fetchAll();
    foreach ($designationRows as $row) {
        $designationData[$row['designation']] = (int)$row['count'];
    }
} catch (PDOException $e) {
    // Fail silently or capture warning (handled gracefully in UI)
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
            <i class="bi bi-speedometer2 text-indigo me-2" style="font-size: 1.6rem;"></i>
            Admin Control Center
          </h3>
        </div>
        <div class="col-md-6 text-md-end mt-2 mt-md-0">
          <span class="badge bg-indigo-subtle text-indigo p-2 px-3 border border-indigo-subtle rounded-pill" style="font-size: 0.88rem;">
            <i class="bi bi-calendar-event-fill me-1"></i> Date: <?php echo date('d M Y'); ?>
          </span>
          <span class="badge bg-success-subtle text-success p-2 px-3 border border-success-subtle rounded-pill ms-2" style="font-size: 0.88rem;">
            <i class="bi bi-cpu-fill me-1"></i> System OK
          </span>
        </div>
      </div>
    </div>
  </div>

  <!-- Main Content Body -->
  <div class="app-content">
    <div class="container-fluid">
      
      <?php if (isset($dbError)): ?>
        <div class="alert alert-danger d-flex align-items-center rounded-3 shadow-sm mb-4" role="alert">
          <i class="bi bi-exclamation-octagon-fill me-2 fs-5"></i>
          <div>
            <strong>Database Query Notice:</strong> <?php echo htmlspecialchars($dbError); ?>
          </div>
        </div>
      <?php endif; ?>

      <!-- 1. KPI Cards Row -->
      <div class="row g-4 mb-4">
        <!-- KPI card: Users -->
        <div class="col-xl-3 col-sm-6">
          <div class="kpi-card-custom d-flex justify-content-between align-items-center">
            <div>
              <div class="text-uppercase small text-muted font-weight-bold mb-1" style="font-size: 0.75rem; letter-spacing: 0.8px;">Total System Users</div>
              <h2 class="mb-0 font-weight-bold text-dark" style="font-size: 2.2rem;"><?php echo $totalUsers; ?></h2>
              <span class="text-success small mt-1 d-block"><i class="bi bi-person-check-fill"></i> CDO & DM Portals</span>
            </div>
            <div class="icon-box shadow" style="background: linear-gradient(135deg, #6366f1 0%, #4f46e5 100%);">
              <i class="bi bi-people-fill"></i>
            </div>
          </div>
        </div>

        <!-- KPI card: Active Stations -->
        <div class="col-xl-3 col-sm-6">
          <div class="kpi-card-custom d-flex justify-content-between align-items-center" style="--admin-primary: #10b981;">
            <div>
              <div class="text-uppercase small text-muted font-weight-bold mb-1" style="font-size: 0.75rem; letter-spacing: 0.8px;">Active Stations</div>
              <h2 class="mb-0 font-weight-bold text-dark" style="font-size: 2.2rem;"><?php echo $activeStations; ?></h2>
              <span class="text-success small mt-1 d-block"><i class="bi bi-shield-check"></i> Connected & Online</span>
            </div>
            <div class="icon-box shadow" style="background: linear-gradient(135deg, #10b981 0%, #059669 100%);">
              <i class="bi bi-geo-alt-fill"></i>
            </div>
          </div>
        </div>

        <!-- KPI card: Active Employees -->
        <div class="col-xl-3 col-sm-6">
          <div class="kpi-card-custom d-flex justify-content-between align-items-center" style="--admin-primary: #06b6d4;">
            <div>
              <div class="text-uppercase small text-muted font-weight-bold mb-1" style="font-size: 0.75rem; letter-spacing: 0.8px;">Active Employees</div>
              <h2 class="mb-0 font-weight-bold text-dark" style="font-size: 2.2rem;"><?php echo $activeEmployees; ?></h2>
              <span class="text-info small mt-1 d-block"><i class="bi bi-file-earmark-person"></i> Verified Database</span>
            </div>
            <div class="icon-box shadow" style="background: linear-gradient(135deg, #06b6d4 0%, #0891b2 100%);">
              <i class="bi bi-person-badge-fill"></i>
            </div>
          </div>
        </div>

        <!-- KPI card: Total Divisions -->
        <div class="col-xl-3 col-sm-6">
          <div class="kpi-card-custom d-flex justify-content-between align-items-center" style="--admin-primary: #f59e0b;">
            <div>
              <div class="text-uppercase small text-muted font-weight-bold mb-1" style="font-size: 0.75rem; letter-spacing: 0.8px;">Total Divisions</div>
              <h2 class="mb-0 font-weight-bold text-dark" style="font-size: 2.2rem;"><?php echo $totalDivisions; ?></h2>
              <span class="text-warning small mt-1 d-block"><i class="bi bi-diagram-3-fill"></i> Zonal Network mapping</span>
            </div>
            <div class="icon-box shadow" style="background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);">
              <i class="bi bi-building"></i>
            </div>
          </div>
        </div>
      </div>

      <!-- 2. Charts Visualisations Section -->
      <div class="row g-4 mb-4">
        <!-- User Role Distribution Chart -->
        <div class="col-lg-5">
          <div class="card h-100 shadow-sm border-0">
            <div class="card-header d-flex justify-content-between align-items-center bg-white py-3">
              <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center" style="font-size: 1.05rem;">
                <i class="bi bi-pie-chart text-indigo me-2"></i> User Roles Distribution
              </h5>
              <span class="badge bg-indigo-subtle text-indigo rounded-pill px-2">Live</span>
            </div>
            <div class="card-body d-flex align-items-center justify-content-center" style="min-height: 280px; position: relative;">
              <?php if(empty($roleData)): ?>
                <span class="text-muted small">No role data available</span>
              <?php else: ?>
                <canvas id="roleChart" style="max-height: 250px; max-width: 250px;"></canvas>
              <?php endif; ?>
            </div>
          </div>
        </div>

        <!-- Employee Designation Distribution Chart -->
        <div class="col-lg-7">
          <div class="card h-100 shadow-sm border-0">
            <div class="card-header d-flex justify-content-between align-items-center bg-white py-3">
              <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center" style="font-size: 1.05rem;">
                <i class="bi bi-bar-chart-steps text-success me-2"></i> Employee Designations Distribution
              </h5>
              <span class="badge bg-success-subtle text-success rounded-pill px-2">Top 5</span>
            </div>
            <div class="card-body d-flex align-items-center justify-content-center" style="min-height: 280px;">
              <?php if(empty($designationData)): ?>
                <span class="text-muted small">No employee records in database</span>
              <?php else: ?>
                <canvas id="designationChart" style="max-height: 250px;"></canvas>
              <?php endif; ?>
            </div>
          </div>
        </div>
      </div>

      <!-- 3. Tables Logs Section -->
      <div class="row g-4">
        <!-- Recent Logins / User Management Overview -->
        <div class="col-lg-6">
          <div class="card shadow-sm border-0 h-100">
            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
              <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center" style="font-size: 1.05rem;">
                <i class="bi bi-people text-indigo me-2"></i> Recent Registered Users
              </h5>
              <a href="#" class="btn btn-sm btn-outline-indigo rounded-pill px-3 font-weight-bold">View All</a>
            </div>
            <div class="card-body p-0">
              <div class="table-responsive">
                <table class="table table-hover table-striped mb-0">
                  <thead>
                    <tr>
                      <th>User Code</th>
                      <th>Name</th>
                      <th>Role</th>
                      <th>Station</th>
                      <th>Status</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php if (empty($recentUsers)): ?>
                      <tr>
                        <td colspan="5" class="text-center py-4 text-muted small">No users found.</td>
                      </tr>
                    <?php else: ?>
                      <?php foreach ($recentUsers as $user): ?>
                        <tr>
                          <td><strong><?php echo htmlspecialchars($user['user_code'] ? $user['user_code'] : 'USR-'.$user['user_id']); ?></strong></td>
                          <td><?php echo htmlspecialchars($user['user_name']); ?></td>
                          <td>
                            <span class="badge rounded-pill <?php echo $user['role'] === 'ADMIN' ? 'bg-danger-subtle text-danger border border-danger-subtle' : 'bg-primary-subtle text-primary border border-primary-subtle'; ?>" style="font-size: 0.78rem;">
                              <?php echo htmlspecialchars($user['role']); ?>
                            </span>
                          </td>
                          <td><?php echo htmlspecialchars($user['station_name'] ? $user['station_name'] : 'System Base'); ?></td>
                          <td>
                            <span class="badge rounded-pill <?php echo $user['status'] === 'Active' ? 'bg-success-subtle text-success border border-success-subtle' : 'bg-secondary-subtle text-secondary'; ?>" style="font-size: 0.78rem;">
                              <?php echo htmlspecialchars($user['status']); ?>
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

        <!-- Station Management Overview -->
        <div class="col-lg-6">
          <div class="card shadow-sm border-0 h-100">
            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
              <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center" style="font-size: 1.05rem;">
                <i class="bi bi-geo-alt text-success me-2"></i> Registered Depot Stations
              </h5>
              <a href="#" class="btn btn-sm btn-outline-success rounded-pill px-3 font-weight-bold">View All</a>
            </div>
            <div class="card-body p-0">
              <div class="table-responsive">
                <table class="table table-hover table-striped mb-0">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Station Name</th>
                      <th>Division</th>
                      <th>Status</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php if (empty($stationsList)): ?>
                      <tr>
                        <td colspan="4" class="text-center py-4 text-muted small">No stations found.</td>
                      </tr>
                    <?php else: ?>
                      <?php foreach ($stationsList as $station): ?>
                        <tr>
                          <td><strong>STN-<?php echo $station['station_id']; ?></strong></td>
                          <td><?php echo htmlspecialchars($station['station_name']); ?></td>
                          <td><?php echo htmlspecialchars($station['division_name'] ? $station['division_name'] : 'N/A'); ?></td>
                          <td>
                            <span class="badge rounded-pill <?php echo $station['status'] === 'Active' ? 'bg-success-subtle text-success border border-success-subtle' : 'bg-secondary-subtle text-secondary'; ?>" style="font-size: 0.78rem;">
                              <?php echo htmlspecialchars($station['status']); ?>
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

    </div>
  </div>
</main>

<?php
// Prepare charts configuration variables
$roleLabelsJson = json_encode(array_keys($roleData));
$roleCountsJson = json_encode(array_values($roleData));

$designationLabelsJson = json_encode(array_keys($designationData));
$designationCountsJson = json_encode(array_values($designationData));

$extraScripts = "
// Role Distribution Pie Chart
const roleCtx = document.getElementById('roleChart');
if(roleCtx) {
    new Chart(roleCtx, {
        type: 'doughnut',
        data: {
            labels: $roleLabelsJson,
            datasets: [{
                data: $roleCountsJson,
                backgroundColor: [
                    '#6366f1', // Indigo
                    '#10b981', // Emerald
                    '#06b6d4', // Cyan
                    '#f59e0b', // Amber
                    '#ec4899'  // Pink
                ],
                borderWidth: 2,
                borderColor: '#ffffff'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        boxWidth: 12,
                        padding: 15,
                        font: {
                            family: 'Outfit',
                            size: 11
                        }
                    }
                }
            },
            cutout: '65%'
        }
    });
}

// Designation Distribution Horizontal Bar Chart
const desgCtx = document.getElementById('designationChart');
if(desgCtx) {
    new Chart(desgCtx, {
        type: 'bar',
        data: {
            labels: $designationLabelsJson,
            datasets: [{
                label: 'Employees count',
                data: $designationCountsJson,
                backgroundColor: 'rgba(16, 185, 129, 0.85)',
                hoverBackgroundColor: '#10b981',
                borderRadius: 8,
                borderWidth: 0
            }]
        },
        options: {
            indexAxis: 'y',
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                x: {
                    grid: {
                        display: false
                    },
                    ticks: {
                        precision: 0
                    }
                },
                y: {
                    grid: {
                        display: false
                    }
                }
            }
        }
    });
}
";

include 'footer.php';
?>
