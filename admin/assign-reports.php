<?php
/**
 * MCC - Admin Panel Assign Reports
 * UI view for mapping specific report access forms to station profiles.
 * Note: Currently UI-only prototype processing mock state alerts on submit.
 */
if (session_status() === PHP_SESSION_NONE) {
    session_name('MCC_ADMIN_SESS');
    session_start();
}
$pageTitle = 'MCC Admin | Assign Reports to Station';
require_once '../connection.php';

$message = $_SESSION['flash_message'] ?? '';
$messageType = $_SESSION['flash_message_type'] ?? '';
unset($_SESSION['flash_message'], $_SESSION['flash_message_type']);

$selected_station_id = 0;
$selected_reports = [];

// Handle POST submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $station_id = intval($_POST['station_id'] ?? 0);
    $reports = $_POST['reports'] ?? [];
    
    if ($station_id <= 0) {
        $_SESSION['flash_message'] = 'Please select a station to map report profiles.';
        $_SESSION['flash_message_type'] = 'danger';
    } else {
        try {
            $pdo->beginTransaction();
            
            // Delete existing mappings for this station
            $delStmt = $pdo->prepare("DELETE FROM mcc_station_reports WHERE station_id = :station_id");
            $delStmt->execute(['station_id' => $station_id]);
            
              // Insert new mappings
              if (!empty($reports)) {
                  $insStmt = $pdo->prepare("INSERT INTO mcc_station_reports (station_id, report_key) VALUES (:station_id, :report_key)");
                  foreach ($reports as $rep_key) {
                      $insStmt->execute([
                          'station_id' => $station_id,
                          'report_key' => $rep_key
                      ]);
                  }
              }
              
              // Seed default manpower categories if manpower is assigned and no categories exist
              if (in_array('manpower', $reports)) {
                  $chkCat = $pdo->prepare("SELECT COUNT(*) FROM mcc_manpower_categories WHERE station_id = :station_id");
                  $chkCat->execute(['station_id' => $station_id]);
                  if ($chkCat->fetchColumn() == 0) {
                      $defaultCats = [
                          ['NORMAL CLEANING', 1],
                          ['EXTERNAL COACH CLEANING', 2],
                          ['INTENSIVE COACH CLEANING', 3],
                          ['PADLOCKING', 4],
                          ['CLEANING OF PITLINES AND DEPOT PREMISES', 5],
                          ['Watering and Internal dry cleaning of coaches for Platform Return Trains', 6],
                          ['Manpower Required for Undergear Cleaning', 7],
                          ['Changing & Cleaning of DB/IB at SCL Pit', 8]
                      ];
                      $insCat = $pdo->prepare("INSERT INTO mcc_manpower_categories (station_id, category_name, order_no, status) VALUES (:station_id, :category_name, :order_no, 'Active')");
                      foreach ($defaultCats as $cat) {
                          $insCat->execute([
                              'station_id' => $station_id,
                              'category_name' => $cat[0],
                              'order_no' => $cat[1]
                          ]);
                      }
                  }
              }
            
            $pdo->commit();
            
            // Fetch station name for message
            $st = $pdo->prepare("SELECT station_name FROM mcc_stations WHERE station_id = :id");
            $st->execute(['id' => $station_id]);
            $stn_name = $st->fetchColumn();
            
            $count = count($reports);
            if ($count > 0) {
                $_SESSION['flash_message'] = "Success! Mapping configurations saved: $count report profiles successfully mapped to Station '$stn_name'.";
            } else {
                $_SESSION['flash_message'] = "Success! All report mappings removed for Station '$stn_name'.";
            }
            $_SESSION['flash_message_type'] = 'success';
        } catch (PDOException $e) {
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            $_SESSION['flash_message'] = 'Action failed with database error: ' . $e->getMessage();
            $_SESSION['flash_message_type'] = 'danger';
        }
    }
    
    header("Location: assign-reports.php?edit_station=" . $station_id);
    exit();
}

// Handle GET request to load mappings for editing/pre-filling
if (isset($_GET['edit_station'])) {
    $selected_station_id = intval($_GET['edit_station']);
    try {
        $stmt = $pdo->prepare("SELECT report_key FROM mcc_station_reports WHERE station_id = :station_id");
        $stmt->execute(['station_id' => $selected_station_id]);
        $selected_reports = $stmt->fetchAll(PDO::FETCH_COLUMN);
    } catch (PDOException $e) {
        // Fail silently
    }
}

// Fetch active stations from the database
$activeStations = [];
try {
    $activeStations = $pdo->query("SELECT station_id, station_name FROM mcc_stations WHERE status = 'Active' ORDER BY station_name ASC")->fetchAll();
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
            <i class="bi bi-file-earmark-check text-indigo me-2" style="font-size: 1.6rem;"></i>
            Assign Reports to Station
          </h3>
        </div>
        <div class="col-md-6 text-md-end mt-2 mt-md-0">
          <span class="badge bg-indigo-subtle text-indigo p-2 px-3 border border-indigo-subtle rounded-pill">
            Mock Mode UI
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
          <?php echo $message; ?>
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      <?php endif; ?>

      <div class="row g-4">
        
        <!-- Left Column: Mapping Form -->
        <div class="col-lg-5">
          <div class="card shadow-sm border-0">
            <div class="card-header bg-white py-3">
              <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                <i class="bi bi-sliders text-indigo me-2"></i> Report Allocation Form
              </h5>
            </div>
            <div class="card-body">
              <?php if (empty($activeStations)): ?>
                <div class="alert alert-warning text-center small rounded-3 p-3 mb-0" role="alert">
                  <i class="bi bi-exclamation-triangle-fill fs-5 d-block mb-2"></i>
                  No active Stations found! You must create a Station first.
                  <a href="stations.php" class="btn btn-sm btn-warning w-100 mt-3 font-weight-bold rounded-pill">Manage Stations</a>
                </div>
              <?php else: ?>
                <form action="assign-reports.php" method="POST">
                  
                  <!-- Station Selection -->
                  <div class="mb-4">
                    <label for="station_id" class="form-label font-weight-bold text-secondary mb-1" style="font-size: 0.82rem; text-transform: uppercase; letter-spacing: 0.5px;">Select Target Depot Station</label>
                    <select class="form-select rounded-3 p-2.5 font-weight-bold border-indigo-subtle" id="station_id" name="station_id" required>
                      <option value="">-- Choose Active Station --</option>
                      <?php foreach ($activeStations as $stn): ?>
                        <option value="<?php echo $stn['station_id']; ?>" <?php echo ($selected_station_id == $stn['station_id']) ? 'selected' : ''; ?>><?php echo htmlspecialchars($stn['station_name']); ?></option>
                      <?php endforeach; ?>
                    </select>
                  </div>

                  <!-- Reports Checklist -->
                  <div class="mb-4">
                    <label class="form-label font-weight-bold text-secondary mb-3" style="font-size: 0.82rem; text-transform: uppercase; letter-spacing: 0.5px;">Select Reports Profile to Assign</label>
                    
                    <!-- 1. Normal Cleaning Group -->
                    <div class="report-group-container border rounded-3 p-3 mb-3 bg-light-subtle">
                      <h6 class="font-weight-bold text-indigo mb-2" style="font-size: 0.9rem;"><i class="bi bi-droplet-half"></i> Normal Cleaning Modules</h6>
                      <div class="form-check mb-1">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="normal_audit" id="rep_normal_audit" <?php echo in_array('normal_audit', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_normal_audit">Normal Audit Scorecard</label>
                      </div>
                      <div class="form-check mb-1">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="normal_chem" id="rep_normal_chem" <?php echo in_array('normal_chem', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_normal_chem">Normal Chemical Consumption</label>
                      </div>
                      <div class="form-check">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="normal_mach" id="rep_normal_mach" <?php echo in_array('normal_mach', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_normal_mach">Normal Machine Log</label>
                      </div>
                    </div>

                    <!-- 2. Intensive Cleaning Group -->
                    <div class="report-group-container border rounded-3 p-3 mb-3 bg-light-subtle">
                      <h6 class="font-weight-bold text-indigo mb-2" style="font-size: 0.9rem;"><i class="bi bi-stars"></i> Intensive Cleaning Modules</h6>
                      <div class="form-check mb-1">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="int_audit" id="rep_int_audit" <?php echo in_array('int_audit', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_int_audit">Intensive Audit Scorecard</label>
                      </div>
                      <div class="form-check mb-1">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="int_chem" id="rep_int_chem" <?php echo in_array('int_chem', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_int_chem">Intensive Chemical Report</label>
                      </div>
                      <div class="form-check mb-1">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="int_mach" id="rep_int_mach" <?php echo in_array('int_mach', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_int_mach">Intensive Machine Log</label>
                      </div>
                      <div class="form-check">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="int_scorecard_2" id="rep_int_scorecard_2" <?php echo in_array('int_scorecard_2', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_int_scorecard_2">Intensive Scorecard 2</label>
                      </div>
                    </div>

                    <!-- 3. Pantry Car Group -->
                    <div class="report-group-container border rounded-3 p-3 mb-3 bg-light-subtle">
                      <h6 class="font-weight-bold text-indigo mb-2" style="font-size: 0.9rem;"><i class="bi bi-cup-hot"></i> Pantry Car Modules</h6>
                      <div class="form-check">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="int_pantry" id="rep_int_pantry" <?php echo in_array('int_pantry', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_int_pantry">Pantry Car Score Card</label>
                      </div>
                    </div>

                    <!-- 3. PLDC Group -->
                    <div class="report-group-container border rounded-3 p-3 mb-3 bg-light-subtle">
                      <h6 class="font-weight-bold text-indigo mb-2" style="font-size: 0.9rem;"><i class="bi bi-shield-check"></i> PLDC Audit Modules</h6>
                      <div class="form-check mb-1">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="pldc_audit" id="rep_pldc_audit" <?php echo in_array('pldc_audit', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_pldc_audit">PLDC Audit Scorecard</label>
                      </div>
                      <div class="form-check mb-1">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="pldc_chem" id="rep_pldc_chem" <?php echo in_array('pldc_chem', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_pldc_chem">PLDC Chemical Report</label>
                      </div>
                      <div class="form-check">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="pldc_mach" id="rep_pldc_mach" <?php echo in_array('pldc_mach', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_pldc_mach">PLDC Machine Log</label>
                      </div>
                    </div>

                    <!-- 4. Surprise Inspections Group -->
                    <div class="report-group-container border rounded-3 p-3 bg-light-subtle">
                      <h6 class="font-weight-bold text-indigo mb-2" style="font-size: 0.9rem;"><i class="bi bi-patch-check-fill"></i> Surprise Visit Audits</h6>
                      <div class="form-check mb-1">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="sur_pit" id="rep_sur_pit" <?php echo in_array('sur_pit', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_sur_pit">Pit & Office Inspection</label>
                      </div>
                      <div class="form-check">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="sur_pf" id="rep_sur_pf" <?php echo in_array('sur_pf', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_sur_pf">PF Return Trains Audit</label>
                      </div>
                    </div>

                    <!-- 5. PRT Cleaning Group -->
                    <div class="report-group-container border rounded-3 p-3 bg-light-subtle mt-3">
                      <h6 class="font-weight-bold text-indigo mb-2" style="font-size: 0.9rem;"><i class="bi bi-arrow-repeat"></i> PRT Cleaning Modules</h6>
                      <div class="form-check mb-1">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="prt_audit" id="rep_prt_audit" <?php echo in_array('prt_audit', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_prt_audit">PRT ScoreCard</label>
                      </div>
                      <div class="form-check">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="prt_chem" id="rep_prt_chem" <?php echo in_array('prt_chem', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_prt_chem">PRT Chemical Report</label>
                      </div>
                    </div>

                    <!-- 6. Vande Bharat Modules Group -->
                    <div class="report-group-container border rounded-3 p-3 bg-light-subtle mt-3">
                      <h6 class="font-weight-bold text-indigo mb-2" style="font-size: 0.9rem;"><i class="bi bi-lightning-charge-fill"></i> Vande Bharat Modules</h6>
                      <div class="form-check mb-1">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="vb_audit" id="rep_vb_audit" <?php echo in_array('vb_audit', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_vb_audit">Vande Bharat Score Card</label>
                      </div>
                      <div class="form-check mb-1">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="vb_chem" id="rep_vb_chem" <?php echo in_array('vb_chem', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_vb_chem">Vande Bharat Chemical Report</label>
                      </div>
                      <div class="form-check">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="vb_mach" id="rep_vb_mach" <?php echo in_array('vb_mach', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_vb_mach">Vande Bharat Machine Report</label>
                      </div>
                    </div>

                    <!-- 6. Attendance & Manpower Group -->
                    <div class="report-group-container border rounded-3 p-3 bg-light-subtle mt-3">
                      <h6 class="font-weight-bold text-indigo mb-2" style="font-size: 0.9rem;"><i class="bi bi-calendar-check"></i> Attendance & Manpower</h6>
                      <div class="form-check">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="manpower" id="rep_manpower" <?php echo in_array('manpower', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_manpower">Man Power Log</label>
                      </div>
                    </div>

                    <!-- 7. Cleanliness Group -->
                    <div class="report-group-container border rounded-3 p-3 bg-light-subtle mt-3">
                      <h6 class="font-weight-bold text-indigo mb-2" style="font-size: 0.9rem;"><i class="bi bi-stars"></i> Cleanliness Modules</h6>
                      <div class="form-check">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="cleanliness" id="rep_cleanliness" <?php echo in_array('cleanliness', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_cleanliness">Cleanliness Scorecard</label>
                      </div>
                    </div>

                    <!-- 8. Photo Report Group -->
                    <div class="report-group-container border rounded-3 p-3 bg-light-subtle mt-3">
                      <h6 class="font-weight-bold text-indigo mb-2" style="font-size: 0.9rem;"><i class="bi bi-camera"></i> Photo Reports</h6>
                      <div class="form-check">
                        <input class="form-check-input check-indigo" type="checkbox" name="reports[]" value="photo_report" id="rep_photo_report" <?php echo in_array('photo_report', $selected_reports) ? 'checked' : ''; ?>>
                        <label class="form-check-label text-dark small" for="rep_photo_report">Photo Report (Before/After)</label>
                      </div>
                    </div>

                  </div>

                  <button type="submit" class="btn btn-indigo w-100 p-2.5 rounded-3 font-weight-bold shadow-sm mt-3">
                    Assign Report Profiles &nbsp;<i class="bi bi-shield-check"></i>
                  </button>
                </form>
              <?php endif; ?>
            </div>
          </div>
        </div>

        <!-- Right Column: Active Mappings Matrix View -->
        <div class="col-lg-7">
          <div class="card shadow-sm border-0 h-100">
            <div class="card-header bg-white py-3">
              <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
                <i class="bi bi-table text-indigo me-2"></i> Report Mapping Matrix
              </h5>
            </div>
            <div class="card-body p-0">
              <div class="table-responsive">
                <table class="table table-hover table-striped align-middle mb-0">
                  <thead>
                    <tr>
                      <th class="ps-3">Depot Station</th>
                      <th>Assigned Audit Profiles</th>
                      <th class="text-center" style="width: 130px;">Action (UI)</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php
                    // Fetch and group station mapping configurations
                    $mappings = [];
                    try {
                        $stmt = $pdo->query("
                            SELECT s.station_id, s.station_name, r.report_key 
                            FROM mcc_stations s 
                            LEFT JOIN mcc_station_reports r ON s.station_id = r.station_id 
                            WHERE s.status = 'Active' 
                            ORDER BY s.station_name ASC, r.report_key ASC
                        ");
                        $rawMappings = $stmt->fetchAll();
                        
                        foreach ($rawMappings as $row) {
                            $sid = $row['station_id'];
                            if (!isset($mappings[$sid])) {
                                $mappings[$sid] = [
                                    'name' => $row['station_name'],
                                    'reports' => []
                                ];
                            }
                            if ($row['report_key'] !== null) {
                                $mappings[$sid]['reports'][] = $row['report_key'];
                            }
                        }
                    } catch (PDOException $e) {
                        // Fail silently
                    }
                    
                    $reportLabels = [
                        'normal_audit' => 'Normal Audit',
                        'normal_chem'  => 'Normal Chemical',
                        'normal_mach'  => 'Normal Machine',
                        'int_audit'       => 'Intensive Audit',
                        'int_chem'        => 'Intensive Chemical',
                        'int_mach'        => 'Intensive Machine',
                        'int_scorecard_2' => 'Intensive Scorecard 2',
                        'int_pantry'      => 'Pantry Car Score Card',
                        'pldc_audit'      => 'PLDC Scorecard',
                        'pldc_chem'    => 'PLDC Chemical',
                        'pldc_mach'    => 'PLDC Machine',
                        'prt_audit'    => 'PRT ScoreCard',
                        'prt_chem'     => 'PRT Chemical',
                        'sur_pit'      => 'Surprise Pit & Office',
                        'sur_pf'       => 'Surprise PF Trains',
                        'vb_audit'     => 'Vande Bharat Score Card',
                        'vb_chem'      => 'Vande Bharat Chemical Report',
                        'vb_mach'      => 'Vande Bharat Machine Report',
                        'manpower'     => 'Manpower Log',
                        'cleanliness'  => 'Cleanliness Scorecard',
                        'photo_report' => 'Photo Report'
                    ];
                    ?>
                    
                    <?php if (empty($mappings)): ?>
                      <tr>
                        <td colspan="3" class="text-center py-4 text-muted">
                          <i class="bi bi-info-circle fs-4 d-block mb-2"></i>
                          No active stations found.
                        </td>
                      </tr>
                    <?php else: ?>
                      <?php foreach ($mappings as $sid => $data): ?>
                        <tr>
                          <td class="ps-3"><strong><?php echo htmlspecialchars($data['name']); ?></strong></td>
                          <td>
                            <?php if (empty($data['reports'])): ?>
                              <span class="text-muted small italic"><i class="bi bi-info-circle"></i> No report profiles assigned yet.</span>
                            <?php else: ?>
                              <?php foreach ($data['reports'] as $rep_key): ?>
                                <?php if (isset($reportLabels[$rep_key])): ?>
                                  <span class="badge bg-indigo-subtle text-indigo p-1.5 me-1 mb-1"><?php echo htmlspecialchars($reportLabels[$rep_key]); ?></span>
                                <?php endif; ?>
                              <?php endforeach; ?>
                            <?php endif; ?>
                          </td>
                          <td class="text-center">
                            <a href="assign-reports.php?edit_station=<?php echo $sid; ?>" class="btn btn-xs btn-outline-indigo rounded-pill px-2.5 font-weight-bold text-uppercase" style="font-size: 0.72rem; text-decoration: none;">Edit / Map</a>
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
  
  /* Custom checkbox style */
  .check-indigo:checked {
    background-color: var(--admin-primary) !important;
    border-color: var(--admin-primary) !important;
  }
  
  .report-group-container {
    background: #f8fafc;
    border-color: #f1f5f9 !important;
    transition: border-color 0.2s ease;
  }
  
  .report-group-container:hover {
    border-color: var(--admin-border) !important;
  }
</style>

<?php include 'footer.php'; ?>
