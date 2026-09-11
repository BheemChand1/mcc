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
    $report_names = $_POST['report_names'] ?? [];
    $report_active = $_POST['report_active'] ?? [];
    $subreport_names = $_POST['subreport_names'] ?? [];
    $subreport_active = $_POST['subreport_active'] ?? [];
    
    if ($station_id <= 0) {
        $_SESSION['flash_message'] = 'Please select a station to map report profiles.';
        $_SESSION['flash_message_type'] = 'danger';
    } else {
        try {
            $pdo->beginTransaction();
            
            // 1. Update main reports status and names
            $repsStmt = $pdo->prepare("SELECT report_id FROM mcc_reports WHERE station_id = :station_id");
            $repsStmt->execute(['station_id' => $station_id]);
            $stationReportIds = $repsStmt->fetchAll(PDO::FETCH_COLUMN);

            $updateRepStmt = $pdo->prepare("UPDATE mcc_reports SET report_name = :report_name, status = :status WHERE report_id = :report_id");
            
            foreach ($stationReportIds as $rid) {
                $name = trim($report_names[$rid] ?? '');
                if (empty($name)) continue;
                $status = in_array($rid, $report_active) ? 'Active' : 'Inactive';
                $updateRepStmt->execute([
                    'report_name' => $name,
                    'status' => $status,
                    'report_id' => $rid
                ]);
            }

            // 2. Update subreports status and names
            if (!empty($stationReportIds)) {
                $inClause = implode(',', array_map('intval', $stationReportIds));
                $subsStmt = $pdo->query("SELECT subreport_id FROM mcc_subreports WHERE report_id IN ($inClause)");
                $stationSubreportIds = $subsStmt->fetchAll(PDO::FETCH_COLUMN);

                $updateSubStmt = $pdo->prepare("UPDATE mcc_subreports SET report_name = :report_name, status = :status WHERE subreport_id = :subreport_id");

                foreach ($stationSubreportIds as $sid) {
                    $name = trim($subreport_names[$sid] ?? '');
                    if (empty($name)) continue;
                    $status = in_array($sid, $subreport_active) ? 'Active' : 'Inactive';
                    $updateSubStmt->execute([
                        'report_name' => $name,
                        'status' => $status,
                        'subreport_id' => $sid
                    ]);
                }
            }

            // 3. Sync mcc_station_reports access control entries for this station
            $urlToReportKeys = [
                'normal-report.php' => 'normal_audit',
                'chemical-report.php' => 'normal_chem',
                'machine-report.php' => 'normal_mach',
                'intensive-report.php' => 'int_audit',
                'intensive-chemical-report.php' => 'int_chem',
                'machine-report-intensive.php' => 'int_mach',
                'intensive_scorecard_2.php' => 'int_scorecard_2',
                'DC-Scorecard.php' => 'dc_audit',
                'dc-chemical.php' => 'dc_chem',
                'dc-machine.php' => 'dc_mach',
                'Platform-Return-TrainsScorecard.php' => 'prt_audit',
                'Platform-Return-Chemical.php' => 'prt_chem',
                'Platform-Return-Machine.php' => 'prt_mach',
                'intensive_pantry_scorecard.php' => 'int_pantry',
                'pantry-chemical.php' => 'int_pantry',
                'pantry-machine.php' => 'int_pantry',
                'surprise-pit-office.php' => 'sur_pit',
                'surprise-pf-trains.php' => 'sur_pf',
                'vande-bharat-report.php' => 'vb_audit',
                'vande-bharat-chemical.php' => 'vb_chem',
                'vande-bharat-machine.php' => 'vb_mach',
                'man-power-log.php' => 'manpower',
                'biometeric_manpower_log.php' => 'manpower',
                'cleanliness.php' => 'cleanliness',
                'photo-report.php' => 'photo_report',
                'Billing.php' => 'billing'
            ];

            $delStnRep = $pdo->prepare("DELETE FROM mcc_station_reports WHERE station_id = :station_id");
            $delStnRep->execute(['station_id' => $station_id]);

            if (!empty($stationReportIds)) {
                $inClause = implode(',', array_map('intval', $stationReportIds));
                $activeSubsStmt = $pdo->query("SELECT report_url FROM mcc_subreports WHERE report_id IN ($inClause) AND status = 'Active'");
                $activeUrls = $activeSubsStmt->fetchAll(PDO::FETCH_COLUMN);

                $keysToInsert = [];
                foreach ($activeUrls as $u) {
                    if (isset($urlToReportKeys[$u])) {
                        $keysToInsert[] = $urlToReportKeys[$u];
                    }
                }
                $keysToInsert = array_unique($keysToInsert);

                if (!empty($keysToInsert)) {
                    $insStnRep = $pdo->prepare("INSERT INTO mcc_station_reports (station_id, report_key) VALUES (:station_id, :report_key)");
                    foreach ($keysToInsert as $rk) {
                        $insStnRep->execute([
                            'station_id' => $station_id,
                            'report_key' => $rk
                        ]);
                    }
                }
            }

            // 4. Seeder for manpower default categories if manpower subreports are active
            $chkManpowerActive = false;
            if (!empty($stationReportIds)) {
                $inClause = implode(',', array_map('intval', $stationReportIds));
                $mpStmt = $pdo->query("SELECT COUNT(*) FROM mcc_subreports WHERE report_id IN ($inClause) AND report_url IN ('man-power-log.php', 'biometeric_manpower_log.php') AND status = 'Active'");
                if ($mpStmt && $mpStmt->fetchColumn() > 0) {
                    $chkManpowerActive = true;
                }
            }

            if ($chkManpowerActive) {
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
            
            $_SESSION['flash_message'] = "Success! Mapping configurations and report names saved successfully for Station '$stn_name'.";
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

$selected_reports = [];
$selected_subreports = [];
$stationReports = [];

// Handle GET request to load mappings for editing/pre-filling
if (isset($_GET['edit_station'])) {
    $selected_station_id = intval($_GET['edit_station']);
    try {
        $defaultTemplate = [
            'normal_cleaning' => [
                'name' => 'Normal Cleaning',
                'subreports' => [
                    ['name' => 'Scorecard', 'url' => 'normal-report.php', 'aap_key' => 'normal_scorecard'],
                    ['name' => 'Chemical Report', 'url' => 'chemical-report.php', 'aap_key' => 'normal_chemical'],
                    ['name' => 'Machine Report', 'url' => 'machine-report.php', 'aap_key' => 'normal_machine']
                ]
            ],
            'intensive_cleaning' => [
                'name' => 'Intensive Cleaning',
                'subreports' => [
                    ['name' => 'Intensive Report', 'url' => 'intensive-report.php', 'aap_key' => 'intensive_scorecard'],
                    ['name' => 'Scorecard', 'url' => 'intensive_scorecard_2.php', 'aap_key' => 'intensive_scorecard_2'],
                    ['name' => 'Chemical Report', 'url' => 'intensive-chemical-report.php', 'aap_key' => 'intensive_chemical'],
                    ['name' => 'Machine Report', 'url' => 'machine-report-intensive.php', 'aap_key' => 'intensive_machine']
                ]
            ],
            'dc_cleaning' => [
                'name' => 'DC Cleaning',
                'subreports' => [
                    ['name' => 'Scorecard', 'url' => 'DC-Scorecard.php', 'aap_key' => 'dc_scorecard'],
                    ['name' => 'Chemical Report', 'url' => 'dc-chemical.php', 'aap_key' => 'dc_chemical'],
                    ['name' => 'Machine Report', 'url' => 'dc-machine.php', 'aap_key' => 'dc_machine']
                ]
            ],
            'prt_cleaning' => [
                'name' => 'PRT Cleaning',
                'subreports' => [
                    ['name' => 'Scorecard', 'url' => 'Platform-Return-TrainsScorecard.php', 'aap_key' => 'prt_scorecard'],
                    ['name' => 'Chemical Report', 'url' => 'Platform-Return-Chemical.php', 'aap_key' => 'prt_chemical'],
                    ['name' => 'Machine Report', 'url' => 'Platform-Return-Machine.php', 'aap_key' => 'prt_machine']
                ]
            ],
            'pantry_car' => [
                'name' => 'Pantry Car',
                'subreports' => [
                    ['name' => 'Scorecard', 'url' => 'intensive_pantry_scorecard.php', 'aap_key' => 'intensive_pantry_scorecard'],
                    ['name' => 'Pantry Car Chemical', 'url' => 'pantry-chemical.php', 'aap_key' => 'pantry_chemical'],
                    ['name' => 'Pantry Car Machine', 'url' => 'pantry-machine.php', 'aap_key' => 'pantry_machine']
                ]
            ],
            'surprise_visit_audits' => [
                'name' => 'Surprise Visit Audits',
                'subreports' => [
                    ['name' => 'Pit & Office Inspection', 'url' => 'surprise-pit-office.php', 'aap_key' => 'surprise_pit_office'],
                    ['name' => 'PF Return Trains Audit', 'url' => 'surprise-pf-trains.php', 'aap_key' => 'surprise_pf_trains']
                ]
            ],
            'vande_bharat_modules' => [
                'name' => 'Vande Bharat Modules',
                'subreports' => [
                    ['name' => 'Scorecard', 'url' => 'vande-bharat-report.php', 'aap_key' => 'vande_bharat_scorecard'],
                    ['name' => 'Chemical Report', 'url' => 'vande-bharat-chemical.php', 'aap_key' => 'vande_bharat_chemical'],
                    ['name' => 'Machine Report', 'url' => 'vande-bharat-machine.php', 'aap_key' => 'vande_bharat_machine']
                ]
            ],
            'attendance_manpower' => [
                'name' => 'Attendance & Manpower',
                'subreports' => [
                    ['name' => 'Man Power Log', 'url' => 'man-power-log.php', 'aap_key' => 'man_power_log'],
                    ['name' => 'Bio Metric', 'url' => 'biometeric_manpower_log.php', 'aap_key' => 'biometric_manpower_log']
                ]
            ],
            'cleanliness_modules' => [
                'name' => 'Cleanliness Modules',
                'subreports' => [
                    ['name' => 'Cleanliness Scorecard', 'url' => 'cleanliness.php', 'aap_key' => 'cleanliness_scorecard']
                ]
            ],
            'photo_reports' => [
                'name' => 'Photo Reports',
                'subreports' => [
                    ['name' => 'Photo Report (Before/After)', 'url' => 'photo-report.php', 'aap_key' => 'photo_report']
                ]
            ],
            'billing_management' => [
                'name' => 'Billing Management',
                'subreports' => [
                    ['name' => 'Billing Invoice', 'url' => 'Billing.php', 'aap_key' => 'billing_invoice']
                ]
            ]
        ];

        $pdo->beginTransaction();
        
        $chkRepStmt = $pdo->prepare("SELECT report_id, app_key FROM mcc_reports WHERE station_id = :station_id");
        $chkRepStmt->execute(['station_id' => $selected_station_id]);
        $existingReports = $chkRepStmt->fetchAll(PDO::FETCH_ASSOC);
        $existingKeyMap = [];
        foreach ($existingReports as $er) {
            $existingKeyMap[$er['app_key']] = $er['report_id'];
        }

        $insRepStmt = $pdo->prepare("INSERT INTO mcc_reports (report_name, app_key, station_id, status) VALUES (?, ?, ?, 'Inactive')");
        $insSubStmt = $pdo->prepare("INSERT INTO mcc_subreports (report_url, report_name, report_id, status, aap_key) VALUES (?, ?, ?, 'Inactive', ?)");
        $chkSubStmt = $pdo->prepare("SELECT COUNT(*) FROM mcc_subreports WHERE report_id = :report_id");

        foreach ($defaultTemplate as $appKey => $template) {
            if (!isset($existingKeyMap[$appKey])) {
                // Insert new report
                $insRepStmt->execute([$template['name'], $appKey, $selected_station_id]);
                $repId = $pdo->lastInsertId();
                // Insert subreports
                foreach ($template['subreports'] as $sub) {
                    $insSubStmt->execute([$sub['url'], $sub['name'], $repId, $sub['aap_key']]);
                }
            } else {
                $repId = $existingKeyMap[$appKey];
                // Check if subreports exist for this report
                $chkSubStmt->execute(['report_id' => $repId]);
                if ($chkSubStmt->fetchColumn() == 0) {
                    foreach ($template['subreports'] as $sub) {
                        $insSubStmt->execute([$sub['url'], $sub['name'], $repId, $sub['aap_key']]);
                    }
                }
            }
        }
        
        $pdo->commit();

        // Fetch reports list
        $stmt = $pdo->prepare("SELECT * FROM mcc_reports WHERE station_id = :station_id ORDER BY report_id ASC");
        $stmt->execute(['station_id' => $selected_station_id]);
        $stationReports = $stmt->fetchAll(PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
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
                    <label for="station_id_select" class="form-label font-weight-bold text-secondary mb-1" style="font-size: 0.82rem; text-transform: uppercase; letter-spacing: 0.5px;">Select Target Depot Station</label>
                    <select class="form-select rounded-3 p-2.5 font-weight-bold border-indigo-subtle" id="station_id_select" name="station_id" onchange="window.location.href='assign-reports.php?edit_station=' + this.value" required>
                      <option value="">-- Choose Active Station --</option>
                      <?php foreach ($activeStations as $stn): ?>
                        <option value="<?php echo $stn['station_id']; ?>" <?php echo ($selected_station_id == $stn['station_id']) ? 'selected' : ''; ?>><?php echo htmlspecialchars($stn['station_name']); ?></option>
                      <?php endforeach; ?>
                    </select>
                  </div>

                  <?php if ($selected_station_id > 0): ?>
                    <!-- Reports Checklist -->
                    <div class="mb-4">
                      <label class="form-label font-weight-bold text-secondary mb-3" style="font-size: 0.82rem; text-transform: uppercase; letter-spacing: 0.5px;">Edit & Allocate Reports Profile</label>
                      
                      <?php foreach ($stationReports as $rep): 
                          // Fetch subreports for this report
                          $subStmt = $pdo->prepare("SELECT * FROM mcc_subreports WHERE report_id = :report_id ORDER BY subreport_id ASC");
                          $subStmt->execute(['report_id' => $rep['report_id']]);
                          $subreports = $subStmt->fetchAll(PDO::FETCH_ASSOC);
                      ?>
                      <div class="report-group-container border rounded-3 p-3 mb-3 bg-light-subtle shadow-sm">
                        <div class="d-flex align-items-center justify-content-between mb-2 pb-2 border-bottom">
                          <div class="d-flex align-items-center gap-2 flex-grow-1">
                            <input class="form-check-input check-indigo" type="checkbox" name="report_active[]" value="<?= $rep['report_id'] ?>" id="rep_<?= $rep['report_id'] ?>" <?= $rep['status'] == 'Active' ? 'checked' : '' ?>>
                            <input type="text" class="form-control form-control-sm font-weight-bold text-indigo border-0 bg-transparent p-0" name="report_names[<?= $rep['report_id'] ?>]" value="<?= htmlspecialchars($rep['report_name']) ?>" style="font-size: 0.9rem; max-width: 250px;" required>
                          </div>
                          <span class="badge <?= $rep['status'] == 'Active' ? 'bg-success' : 'bg-secondary' ?> small" style="font-size: 11px;"><?= $rep['status'] ?></span>
                        </div>
                        
                        <div class="subreports-list ms-4 mt-2">
                          <?php foreach ($subreports as $sub): ?>
                          <div class="d-flex align-items-center justify-content-between mb-1 pb-1">
                            <div class="d-flex align-items-center gap-2">
                              <input class="form-check-input check-indigo" type="checkbox" name="subreport_active[]" value="<?= $sub['subreport_id'] ?>" id="sub_<?= $sub['subreport_id'] ?>" <?= $sub['status'] == 'Active' ? 'checked' : '' ?>>
                              <input type="text" class="form-control form-control-sm text-dark border-0 bg-transparent p-0" name="subreport_names[<?= $sub['subreport_id'] ?>]" value="<?= htmlspecialchars($sub['report_name']) ?>" style="max-width: 200px;" required>
                            </div>
                            <span class="text-muted font-monospace" style="font-size: 10px;"><?= htmlspecialchars($sub['report_url']) ?></span>
                          </div>
                          <?php endforeach; ?>
                        </div>
                      </div>
                      <?php endforeach; ?>
                    </div>

                    <button type="submit" class="btn btn-indigo w-100 p-2.5 rounded-3 font-weight-bold shadow-sm mt-3">
                      Save Dynamic Allocation & Names &nbsp;<i class="bi bi-shield-check"></i>
                    </button>
                  <?php else: ?>
                    <div class="alert alert-info text-center small rounded-3 p-3 mb-0" role="alert">
                      <i class="bi bi-info-circle-fill fs-5 d-block mb-2"></i>
                      Please select a depot station to load and manage report profiles.
                    </div>
                  <?php endif; ?>
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
                    // Fetch and group station mapping configurations from mcc_reports and mcc_subreports
                    $mappings = [];
                    try {
                        $stationsStmt = $pdo->query("SELECT station_id, station_name FROM mcc_stations WHERE status = 'Active' ORDER BY station_name ASC");
                        $stationsList = $stationsStmt->fetchAll(PDO::FETCH_ASSOC);

                        $repStmt = $pdo->prepare("
                            SELECT r.report_name, s.report_name AS subreport_name
                            FROM mcc_reports r
                            LEFT JOIN mcc_subreports s ON r.report_id = s.report_id AND s.status = 'Active'
                            WHERE r.station_id = :station_id AND r.status = 'Active'
                            ORDER BY r.report_id ASC, s.subreport_id ASC
                        ");

                        foreach ($stationsList as $stn) {
                            $sid = $stn['station_id'];
                            $repStmt->execute(['station_id' => $sid]);
                            $rows = $repStmt->fetchAll(PDO::FETCH_ASSOC);

                            $reports = [];
                            foreach ($rows as $row) {
                                if ($row['subreport_name']) {
                                    $reports[] = $row['report_name'] . " (" . $row['subreport_name'] . ")";
                                } else {
                                    $reports[] = $row['report_name'];
                                }
                            }

                            $mappings[$sid] = [
                                'name' => $stn['station_name'],
                                'reports' => $reports
                            ];
                        }
                    } catch (PDOException $e) {
                        // Fail silently
                    }
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
                              <span class="text-muted small italic"><i class="bi bi-info-circle"></i> No report profiles active/assigned yet.</span>
                            <?php else: ?>
                              <?php foreach ($data['reports'] as $report_label): ?>
                                <span class="badge bg-indigo-subtle text-indigo p-1.5 me-1 mb-1" style="font-size: 11px;"><?php echo htmlspecialchars($report_label); ?></span>
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
