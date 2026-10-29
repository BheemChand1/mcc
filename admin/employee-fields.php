<?php
/**
 * MCC - Admin Panel Location-Wise Employee Field Management
 * Manage dynamic employee inputs per location/station.
 */
if (session_status() === PHP_SESSION_NONE) {
    session_name('MCC_ADMIN_SESS');
    session_start();
}
$pageTitle = 'MCC Admin | Manage Employee Fields';
require_once '../connection.php';

$message = '';
$messageType = '';

// Standard Predefined Field Presets for quick adding
$standardPresets = [
    'mobile_number' => ['label' => 'Mobile Number', 'type' => 'text', 'placeholder' => '10-digit mobile number'],
    'dob' => ['label' => 'Date of Birth', 'type' => 'date', 'placeholder' => 'YYYY-MM-DD'],
    'age' => ['label' => 'Age', 'type' => 'number', 'placeholder' => 'Years'],
    'blood_group' => ['label' => 'Blood Group', 'type' => 'text', 'placeholder' => 'e.g. B+, O+'],
    'father_name' => ['label' => "Father's Name", 'type' => 'text', 'placeholder' => "Father's full name"],
    'mother_name' => ['label' => "Mother's Name", 'type' => 'text', 'placeholder' => "Mother's full name"],
    'aadhar_number' => ['label' => 'Aadhar Number', 'type' => 'text', 'placeholder' => '12-digit Aadhar number'],
    'address' => ['label' => 'Address', 'type' => 'textarea', 'placeholder' => 'Complete residential address'],
    'department' => ['label' => 'Department', 'type' => 'text', 'placeholder' => 'e.g. MECHANICAL (C&W)'],
    'ren_id' => ['label' => 'REN ID', 'type' => 'text', 'placeholder' => 'REN Identification'],
    'rakshak_id' => ['label' => 'Rakshak ID', 'type' => 'text', 'placeholder' => 'Rakshak ID'],
    'pan_card' => ['label' => 'PAN Card', 'type' => 'text', 'placeholder' => '10-character PAN'],
    'police_ver' => ['label' => 'Police Verification', 'type' => 'select', 'options' => 'Done, Pending, Applied, Not Required', 'placeholder' => 'Verification status'],
    'police_ver_dt' => ['label' => 'Police Verification Date', 'type' => 'date', 'placeholder' => 'Verification date'],
    'pvc' => ['label' => 'PVC Status', 'type' => 'text', 'placeholder' => 'PVC details'],
    'medical' => ['label' => 'Medical Status', 'type' => 'text', 'placeholder' => 'Medical fitness status'],
    'education' => ['label' => 'Education', 'type' => 'text', 'placeholder' => 'e.g. 10th, 12th, ITI, Graduate'],
    'account_name' => ['label' => 'Bank Account Name', 'type' => 'text', 'placeholder' => 'Account holder name'],
    'account_number' => ['label' => 'Bank Account Number', 'type' => 'text', 'placeholder' => 'Bank account number'],
    'ifsc_code' => ['label' => 'IFSC Code', 'type' => 'text', 'placeholder' => 'Bank IFSC code'],
    'status' => ['label' => 'Employment Status', 'type' => 'select', 'options' => 'Active, Inactive', 'placeholder' => 'Current status'],
    'issue_date' => ['label' => 'Issue Date', 'type' => 'date', 'placeholder' => 'ID card issue date'],
    'valid_upto_date' => ['label' => 'Valid Upto Date', 'type' => 'date', 'placeholder' => 'ID card validity date'],
    'remarks' => ['label' => 'Remarks', 'type' => 'textarea', 'placeholder' => 'Additional observations']
];

// Fetch all active stations
$stations = [];
try {
    $stmt = $pdo->query("
        SELECT s.station_id, s.station_name, d.division_name, z.zone_name 
        FROM mcc_stations s 
        LEFT JOIN mcc_divisions d ON s.division_id = d.division_id 
        LEFT JOIN mcc_zones z ON d.zone_id = z.zone_id 
        ORDER BY s.station_name ASC
    ");
    $stations = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (Exception $e) {
    $message = "Error loading stations: " . $e->getMessage();
    $messageType = 'danger';
}

$selected_station_id = isset($_REQUEST['station_id']) ? intval($_REQUEST['station_id']) : ($stations[0]['station_id'] ?? 1);

// Helper to sanitize field key
function sanitizeFieldKey($rawKey, $label) {
    $key = trim($rawKey);
    if (empty($key)) {
        $key = strtolower(trim($label));
    }
    $key = preg_replace('/[^a-z0-9_]/', '_', strtolower($key));
    $key = preg_replace('/_+/', '_', $key);
    return trim($key, '_');
}

// POST Actions Handler
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    // 1. Add Single Custom Field
    if ($action === 'add_field') {
        $station_id = intval($_POST['station_id'] ?? 0);
        $label = trim($_POST['field_label'] ?? '');
        $key = sanitizeFieldKey($_POST['field_key'] ?? '', $label);
        $type = $_POST['field_type'] ?? 'text';
        $options = trim($_POST['field_options'] ?? '');
        $placeholder = trim($_POST['placeholder'] ?? '');
        $isRequired = isset($_POST['is_required']) ? 1 : 0;
        $sortOrder = intval($_POST['sort_order'] ?? 0);

        $defaultCoreKeys = ['station_id', 'employee_id', 'full_name', 'designation', 'employee_photo'];

        if ($station_id <= 0 || empty($label) || empty($key)) {
            $message = 'Field Label is required.';
            $messageType = 'danger';
        } elseif (in_array($key, $defaultCoreKeys)) {
            $message = "Field key '$key' is a permanent core input and cannot be duplicated as a custom field.";
            $messageType = 'warning';
        } else {
            try {
                // Check if key already exists for this station
                $chk = $pdo->prepare("SELECT COUNT(*) FROM mcc_employee_custom_fields WHERE station_id = ? AND field_key = ?");
                $chk->execute([$station_id, $key]);
                if ($chk->fetchColumn() > 0) {
                    $message = "A field with key '$key' already exists for this location.";
                    $messageType = 'warning';
                } else {
                    $ins = $pdo->prepare("
                        INSERT INTO mcc_employee_custom_fields 
                        (station_id, field_label, field_key, field_type, field_options, placeholder, is_required, sort_order, status)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'Active')
                    ");
                    $ins->execute([$station_id, $label, $key, $type, $options, $placeholder, $isRequired, $sortOrder]);
                    $message = "Field '{$label}' successfully added for this location!";
                    $messageType = 'success';
                }
            } catch (Exception $e) {
                $message = "Database error: " . $e->getMessage();
                $messageType = 'danger';
            }
        }
    }

    // 2. Edit Custom Field
    if ($action === 'edit_field') {
        $id = intval($_POST['field_id'] ?? 0);
        $label = trim($_POST['field_label'] ?? '');
        $type = $_POST['field_type'] ?? 'text';
        $options = trim($_POST['field_options'] ?? '');
        $placeholder = trim($_POST['placeholder'] ?? '');
        $isRequired = isset($_POST['is_required']) ? 1 : 0;
        $sortOrder = intval($_POST['sort_order'] ?? 0);

        if ($id <= 0 || empty($label)) {
            $message = 'Field Label is required.';
            $messageType = 'danger';
        } else {
            try {
                $upd = $pdo->prepare("
                    UPDATE mcc_employee_custom_fields 
                    SET field_label = ?, field_type = ?, field_options = ?, placeholder = ?, is_required = ?, sort_order = ?
                    WHERE id = ? AND station_id = ?
                ");
                $upd->execute([$label, $type, $options, $placeholder, $isRequired, $sortOrder, $id, $selected_station_id]);
                $message = "Field '{$label}' updated successfully!";
                $messageType = 'success';
            } catch (Exception $e) {
                $message = "Database error: " . $e->getMessage();
                $messageType = 'danger';
            }
        }
    }

    // 3. Delete Custom Field
    if ($action === 'delete_field') {
        $id = intval($_POST['field_id'] ?? 0);
        try {
            $del = $pdo->prepare("DELETE FROM mcc_employee_custom_fields WHERE id = ? AND station_id = ?");
            $del->execute([$id, $selected_station_id]);
            $message = "Custom input field deleted successfully.";
            $messageType = 'success';
        } catch (Exception $e) {
            $message = "Error deleting field: " . $e->getMessage();
            $messageType = 'danger';
        }
    }

    // 4. Toggle Status (Active / Inactive)
    if ($action === 'toggle_status') {
        $id = intval($_POST['field_id'] ?? 0);
        $currStatus = $_POST['current_status'] ?? 'Active';
        $newStatus = ($currStatus === 'Active') ? 'Inactive' : 'Active';
        try {
            $upd = $pdo->prepare("UPDATE mcc_employee_custom_fields SET status = ? WHERE id = ? AND station_id = ?");
            $upd->execute([$newStatus, $id, $selected_station_id]);
            $message = "Field status updated to {$newStatus}.";
            $messageType = 'success';
        } catch (Exception $e) {
            $message = "Error: " . $e->getMessage();
            $messageType = 'danger';
        }
    }

    // 5. Bulk Add Standard Presets
    if ($action === 'import_presets') {
        $presetKeys = $_POST['preset_keys'] ?? [];
        if (empty($presetKeys)) {
            $message = "Please select at least one preset to import.";
            $messageType = 'warning';
        } else {
            $addedCount = 0;
            $existingCount = 0;

            // Fetch existing keys for station
            $existingKeysStmt = $pdo->prepare("SELECT field_key FROM mcc_employee_custom_fields WHERE station_id = ?");
            $existingKeysStmt->execute([$selected_station_id]);
            $currStationKeys = $existingKeysStmt->fetchAll(PDO::FETCH_COLUMN);

            $insStmt = $pdo->prepare("
                INSERT INTO mcc_employee_custom_fields 
                (station_id, field_label, field_key, field_type, field_options, placeholder, is_required, sort_order, status)
                VALUES (?, ?, ?, ?, ?, ?, 0, ?, 'Active')
            ");

            $currOrder = count($currStationKeys) * 10;
            foreach ($presetKeys as $pkey) {
                if (isset($standardPresets[$pkey])) {
                    if (in_array($pkey, $currStationKeys)) {
                        $existingCount++;
                        continue;
                    }
                    $p = $standardPresets[$pkey];
                    $opts = $p['options'] ?? null;
                    $currOrder += 10;
                    $insStmt->execute([
                        $selected_station_id,
                        $p['label'],
                        $pkey,
                        $p['type'],
                        $opts,
                        $p['placeholder'] ?? '',
                        $currOrder
                    ]);
                    $addedCount++;
                }
            }
            $message = "Imported {$addedCount} standard fields into this location. ({$existingCount} were already present).";
            $messageType = 'success';
        }
    }

    // 6. Copy Fields From Another Station
    if ($action === 'copy_from_station') {
        $sourceStationId = intval($_POST['source_station_id'] ?? 0);
        if ($sourceStationId <= 0 || $sourceStationId === $selected_station_id) {
            $message = "Please select a different valid source location.";
            $messageType = 'warning';
        } else {
            try {
                // Fetch source fields
                $srcStmt = $pdo->prepare("SELECT * FROM mcc_employee_custom_fields WHERE station_id = ? AND status = 'Active'");
                $srcStmt->execute([$sourceStationId]);
                $srcFields = $srcStmt->fetchAll(PDO::FETCH_ASSOC);

                // Fetch existing keys in target station
                $tarStmt = $pdo->prepare("SELECT field_key FROM mcc_employee_custom_fields WHERE station_id = ?");
                $tarStmt->execute([$selected_station_id]);
                $tarKeys = $tarStmt->fetchAll(PDO::FETCH_COLUMN);

                $insStmt = $pdo->prepare("
                    INSERT INTO mcc_employee_custom_fields 
                    (station_id, field_label, field_key, field_type, field_options, placeholder, is_required, sort_order, status)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'Active')
                ");

                $copied = 0;
                foreach ($srcFields as $sf) {
                    if (!in_array($sf['field_key'], $tarKeys)) {
                        $insStmt->execute([
                            $selected_station_id,
                            $sf['field_label'],
                            $sf['field_key'],
                            $sf['field_type'],
                            $sf['field_options'],
                            $sf['placeholder'],
                            $sf['is_required'],
                            $sf['sort_order']
                        ]);
                        $copied++;
                    }
                }
                $message = "Successfully copied {$copied} fields to this location.";
                $messageType = 'success';
            } catch (Exception $e) {
                $message = "Error copying fields: " . $e->getMessage();
                $messageType = 'danger';
            }
        }
    }
}

// Fetch configured fields for the currently selected station
$configuredFields = [];
$selectedStationDetails = null;

foreach ($stations as $s) {
    if (intval($s['station_id']) === $selected_station_id) {
        $selectedStationDetails = $s;
        break;
    }
}
if (!$selectedStationDetails && !empty($stations)) {
    $selected_station_id = $stations[0]['station_id'];
    $selectedStationDetails = $stations[0];
}

try {
    $fStmt = $pdo->prepare("
        SELECT * FROM mcc_employee_custom_fields 
        WHERE station_id = ? 
        ORDER BY sort_order ASC, id ASC
    ");
    $fStmt->execute([$selected_station_id]);
    $configuredFields = $fStmt->fetchAll(PDO::FETCH_ASSOC);
} catch (Exception $e) {
    $message = "Error fetching fields: " . $e->getMessage();
    $messageType = 'danger';
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
            <i class="bi bi-person-lines-fill text-indigo me-2" style="font-size: 1.6rem;"></i>
            Location-Wise Employee Fields
          </h3>
          <p class="text-muted small mb-0 mt-1">Configure and customize employee registration input fields for each location</p>
        </div>
        <div class="col-md-6 text-md-end mt-2 mt-md-0 d-flex gap-2 justify-content-md-end align-items-center flex-wrap">
          <form method="GET" class="d-flex align-items-center gap-2">
            <label class="small fw-bold text-secondary text-nowrap m-0">Select Location:</label>
            <select name="station_id" class="form-select form-select-sm border-indigo shadow-sm" onchange="this.form.submit()" style="min-width: 200px;">
              <?php foreach ($stations as $stn): ?>
                <option value="<?= $stn['station_id'] ?>" <?= ($stn['station_id'] == $selected_station_id) ? 'selected' : '' ?>>
                  <?= htmlspecialchars($stn['station_name']) ?> (<?= htmlspecialchars($stn['division_name'] ?? 'Division') ?>)
                </option>
              <?php endforeach; ?>
            </select>
          </form>
        </div>
      </div>
    </div>
  </div>

  <!-- Content Body -->
  <div class="app-content">
    <div class="container-fluid">

      <?php if (!empty($message)): ?>
        <div class="alert alert-<?= $messageType; ?> alert-dismissible fade show rounded-3 shadow-sm mb-4" role="alert">
          <div class="d-flex align-items-center">
            <i class="bi bi-info-circle-fill fs-5 me-2"></i>
            <div><?= htmlspecialchars($message); ?></div>
          </div>
          <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
      <?php endif; ?>

      <!-- Station Active Banner -->
      <div class="card mb-4 border-0 shadow-sm" style="background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%); color: white; border-radius: 12px;">
        <div class="card-body p-3 d-flex flex-wrap justify-content-between align-items-center gap-3">
          <div class="d-flex align-items-center gap-3">
            <div class="rounded-circle bg-indigo p-3 d-flex align-items-center justify-content-center text-white" style="width: 50px; height: 50px;">
              <i class="bi bi-geo-alt-fill fs-4"></i>
            </div>
            <div>
              <div class="small text-indigo-subtle text-uppercase fw-bold" style="letter-spacing: 1px;">Selected Location</div>
              <h4 class="m-0 fw-bold"><?= htmlspecialchars($selectedStationDetails['station_name'] ?? 'Station') ?></h4>
              <div class="small opacity-75"><?= htmlspecialchars(($selectedStationDetails['division_name'] ?? '') . ' Division | ' . ($selectedStationDetails['zone_name'] ?? 'Railway')) ?></div>
            </div>
          </div>
          <div class="d-flex gap-2 flex-wrap">
            <button type="button" class="btn btn-primary btn-sm rounded-pill px-3 shadow-sm" data-bs-toggle="modal" data-bs-target="#addFieldModal">
              <i class="bi bi-plus-circle me-1"></i> Add Custom Input
            </button>
            <button type="button" class="btn btn-outline-light btn-sm rounded-pill px-3 shadow-sm" data-bs-toggle="modal" data-bs-target="#presetsModal">
              <i class="bi bi-lightning-charge me-1"></i> Quick Add Standard Presets
            </button>
            <button type="button" class="btn btn-outline-light btn-sm rounded-pill px-3 shadow-sm" data-bs-toggle="modal" data-bs-target="#copyModal">
              <i class="bi bi-copy me-1"></i> Copy From Another Location
            </button>
          </div>
        </div>
      </div>

      <!-- 1. Mandatory Default Inputs Card -->
      <div class="card border-0 shadow-sm rounded-3 mb-4">
        <div class="card-header bg-light py-3 border-bottom d-flex align-items-center justify-content-between">
          <div class="d-flex align-items-center gap-2">
            <i class="bi bi-shield-lock-fill text-success fs-5"></i>
            <div>
              <h6 class="m-0 fw-bold text-dark">Default Core Inputs (Fixed across all locations)</h6>
              <span class="text-muted small">These 4 core fields are permanently active for all employees and cannot be removed</span>
            </div>
          </div>
          <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-2 rounded-pill">
            <i class="bi bi-check2-all me-1"></i> 4 Core Inputs Active
          </span>
        </div>
        <div class="card-body p-3">
          <div class="row g-3">
            <div class="col-md-3">
              <div class="p-3 border rounded-3 bg-white h-100 shadow-sm d-flex flex-column justify-content-between">
                <div>
                  <div class="d-flex align-items-center justify-content-between mb-2">
                    <span class="badge bg-secondary-subtle text-secondary border">Core Text</span>
                    <span class="badge bg-danger-subtle text-danger border">Mandatory</span>
                  </div>
                  <h6 class="fw-bold mb-1 text-primary">Employee ID</h6>
                  <p class="text-muted small mb-0">Database column: <code>employee_id</code></p>
                </div>
                <div class="mt-2 text-end text-muted small"><i class="bi bi-lock-fill"></i> System Locked</div>
              </div>
            </div>

            <div class="col-md-3">
              <div class="p-3 border rounded-3 bg-white h-100 shadow-sm d-flex flex-column justify-content-between">
                <div>
                  <div class="d-flex align-items-center justify-content-between mb-2">
                    <span class="badge bg-secondary-subtle text-secondary border">Core Text</span>
                    <span class="badge bg-danger-subtle text-danger border">Mandatory</span>
                  </div>
                  <h6 class="fw-bold mb-1 text-primary">Full Name</h6>
                  <p class="text-muted small mb-0">Database column: <code>full_name</code></p>
                </div>
                <div class="mt-2 text-end text-muted small"><i class="bi bi-lock-fill"></i> System Locked</div>
              </div>
            </div>

            <div class="col-md-3">
              <div class="p-3 border rounded-3 bg-white h-100 shadow-sm d-flex flex-column justify-content-between">
                <div>
                  <div class="d-flex align-items-center justify-content-between mb-2">
                    <span class="badge bg-secondary-subtle text-secondary border">Core Dropdown</span>
                    <span class="badge bg-danger-subtle text-danger border">Mandatory</span>
                  </div>
                  <h6 class="fw-bold mb-1 text-primary">Designation</h6>
                  <p class="text-muted small mb-0">Database column: <code>designation</code></p>
                </div>
                <div class="mt-2 text-end text-muted small"><i class="bi bi-lock-fill"></i> System Locked</div>
              </div>
            </div>

            <div class="col-md-3">
              <div class="p-3 border rounded-3 bg-white h-100 shadow-sm d-flex flex-column justify-content-between">
                <div>
                  <div class="d-flex align-items-center justify-content-between mb-2">
                    <span class="badge bg-secondary-subtle text-secondary border">Core File Upload</span>
                    <span class="badge bg-secondary-subtle text-secondary border">Optional</span>
                  </div>
                  <h6 class="fw-bold mb-1 text-primary">Photo</h6>
                  <p class="text-muted small mb-0">Database column: <code>employee_photo</code></p>
                </div>
                <div class="mt-2 text-end text-muted small"><i class="bi bi-lock-fill"></i> System Locked</div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 2. Location-Wise Custom Inputs Table -->
      <div class="card border-0 shadow-sm rounded-3">
        <div class="card-header bg-white py-3 border-bottom d-flex align-items-center justify-content-between flex-wrap gap-2">
          <div>
            <h5 class="m-0 fw-bold text-dark d-flex align-items-center gap-2">
              <i class="bi bi-ui-checks-grid text-indigo"></i>
              Custom Inputs for <?= htmlspecialchars($selectedStationDetails['station_name'] ?? 'Station') ?>
            </h5>
            <span class="text-muted small">These additional inputs will appear when adding/editing employees for this location</span>
          </div>
          <div>
            <span class="badge bg-indigo-subtle text-indigo border border-indigo-subtle px-3 py-2 rounded-pill">
              Configured Custom Inputs: <?= count($configuredFields) ?>
            </span>
          </div>
        </div>

        <div class="card-body p-0">
          <?php if (empty($configuredFields)): ?>
            <div class="text-center py-5">
              <div class="mb-3">
                <i class="bi bi-input-cursor-text text-muted" style="font-size: 3.5rem;"></i>
              </div>
              <h5 class="fw-bold text-secondary">No Custom Inputs Configured For This Location</h5>
              <p class="text-muted small max-w-500 mx-auto" style="max-width: 480px;">
                Currently, employees added at <strong><?= htmlspecialchars($selectedStationDetails['station_name']) ?></strong> will only ask for the 4 default inputs (Employee ID, Name, Designation, Photo). Click below to add extra fields.
              </p>
              <div class="d-flex justify-content-center gap-2 mt-3">
                <button type="button" class="btn btn-primary rounded-pill px-4 shadow-sm" data-bs-toggle="modal" data-bs-target="#addFieldModal">
                  <i class="bi bi-plus-circle me-1"></i> Add Custom Input
                </button>
                <button type="button" class="btn btn-outline-secondary rounded-pill px-4 shadow-sm" data-bs-toggle="modal" data-bs-target="#presetsModal">
                  <i class="bi bi-lightning-charge me-1"></i> Quick Add Standard Presets
                </button>
              </div>
            </div>
          <?php else: ?>
            <div class="table-responsive">
              <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                  <tr>
                    <th style="width: 60px;" class="text-center">Order</th>
                    <th>Field Label</th>
                    <th>Field Key</th>
                    <th>Input Type</th>
                    <th>Required?</th>
                    <th>Placeholder / Options</th>
                    <th class="text-center">Status</th>
                    <th class="text-end" style="width: 140px;">Actions</th>
                  </tr>
                </thead>
                <tbody>
                  <?php foreach ($configuredFields as $idx => $f): ?>
                    <tr>
                      <td class="text-center fw-bold text-muted"><?= $f['sort_order'] ?: ($idx + 1) ?></td>
                      <td>
                        <strong class="text-dark"><?= htmlspecialchars($f['field_label']) ?></strong>
                      </td>
                      <td>
                        <code class="text-indigo bg-indigo-subtle px-2 py-1 rounded"><?= htmlspecialchars($f['field_key']) ?></code>
                      </td>
                      <td>
                        <?php
                          $typeIcons = [
                            'text' => 'bi-fonts text-primary',
                            'number' => 'bi-123 text-info',
                            'date' => 'bi-calendar-date text-warning',
                            'select' => 'bi-menu-button-wide text-success',
                            'textarea' => 'bi-textarea-resize text-secondary',
                            'file' => 'bi-paperclip text-danger'
                          ];
                          $icon = $typeIcons[$f['field_type']] ?? 'bi-fonts';
                        ?>
                        <span class="d-inline-flex align-items-center gap-1">
                          <i class="bi <?= $icon ?>"></i>
                          <span class="text-capitalize"><?= htmlspecialchars($f['field_type']) ?></span>
                        </span>
                      </td>
                      <td>
                        <?php if ($f['is_required']): ?>
                          <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill">Yes (Required)</span>
                        <?php else: ?>
                          <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle rounded-pill">Optional</span>
                        <?php endif; ?>
                      </td>
                      <td class="small text-muted">
                        <?php if ($f['field_type'] === 'select' && !empty($f['field_options'])): ?>
                          <span class="badge bg-light text-dark border text-truncate d-inline-block" style="max-width: 200px;" title="<?= htmlspecialchars($f['field_options']) ?>">
                            Options: <?= htmlspecialchars($f['field_options']) ?>
                          </span>
                        <?php elseif (!empty($f['placeholder'])): ?>
                          <em><?= htmlspecialchars($f['placeholder']) ?></em>
                        <?php else: ?>
                          <span class="text-muted opacity-50">-</span>
                        <?php endif; ?>
                      </td>
                      <td class="text-center">
                        <form method="POST" class="d-inline">
                          <input type="hidden" name="action" value="toggle_status">
                          <input type="hidden" name="station_id" value="<?= $selected_station_id ?>">
                          <input type="hidden" name="field_id" value="<?= $f['id'] ?>">
                          <input type="hidden" name="current_status" value="<?= $f['status'] ?>">
                          <button type="submit" class="btn btn-sm border-0 bg-transparent p-0" title="Click to toggle status">
                            <?php if ($f['status'] === 'Active'): ?>
                              <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill px-2 py-1">Active</span>
                            <?php else: ?>
                              <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle rounded-pill px-2 py-1">Inactive</span>
                            <?php endif; ?>
                          </button>
                        </form>
                      </td>
                      <td class="text-end">
                        <div class="btn-group btn-group-sm">
                          <button type="button" class="btn btn-outline-secondary edit-field-btn" 
                            data-field='<?= json_encode($f, JSON_HEX_APOS | JSON_HEX_QUOT) ?>'
                            title="Edit Input">
                            <i class="bi bi-pencil"></i>
                          </button>
                          <form method="POST" class="d-inline" onsubmit="return confirm('Are you sure you want to remove this input from this location?');">
                            <input type="hidden" name="action" value="delete_field">
                            <input type="hidden" name="station_id" value="<?= $selected_station_id ?>">
                            <input type="hidden" name="field_id" value="<?= $f['id'] ?>">
                            <button type="submit" class="btn btn-outline-danger" title="Remove Input">
                              <i class="bi bi-trash"></i>
                            </button>
                          </form>
                        </div>
                      </td>
                    </tr>
                  <?php endforeach; ?>
                </tbody>
              </table>
            </div>
          <?php endif; ?>
        </div>
      </div>

    </div>
  </div>
</main>

<!-- Modal: Add Custom Field -->
<div class="modal fade" id="addFieldModal" tabindex="-1" aria-labelledby="addFieldModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow">
      <form method="POST">
        <input type="hidden" name="action" value="add_field">
        <input type="hidden" name="station_id" value="<?= $selected_station_id ?>">
        <div class="modal-header bg-dark text-white">
          <h5 class="modal-title fw-bold" id="addFieldModalLabel">
            <i class="bi bi-plus-circle me-1 text-primary"></i> Add Custom Input for <?= htmlspecialchars($selectedStationDetails['station_name']) ?>
          </h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body p-4">
          <div class="mb-3">
            <label class="form-label fw-bold small text-secondary">Field Label <span class="text-danger">*</span></label>
            <input type="text" name="field_label" class="form-control" placeholder="e.g. Aadhar Number, Blood Group, PVC Status" required>
            <div class="form-text">Visible title shown next to the input in CDO employee form.</div>
          </div>

          <div class="row g-3 mb-3">
            <div class="col-md-6">
              <label class="form-label fw-bold small text-secondary">Field Key (Optional Identifier)</label>
              <input type="text" name="field_key" class="form-control" placeholder="e.g. aadhar_number">
              <div class="form-text">Leave blank to auto-generate from label.</div>
            </div>
            <div class="col-md-6">
              <label class="form-label fw-bold small text-secondary">Input Type <span class="text-danger">*</span></label>
              <select name="field_type" class="form-select" id="fieldTypeSelect" onchange="toggleOptionsInput(this.value, 'optionsGroupAdd')">
                <option value="text">Text (Single line)</option>
                <option value="number">Number</option>
                <option value="date">Date</option>
                <option value="select">Dropdown (Select list)</option>
                <option value="textarea">Textarea (Multi-line)</option>
                <option value="file">File Upload (Document/Image)</option>
              </select>
            </div>
          </div>

          <div class="mb-3 d-none" id="optionsGroupAdd">
            <label class="form-label fw-bold small text-secondary">Dropdown Options (Comma-separated)</label>
            <input type="text" name="field_options" class="form-control" placeholder="Option 1, Option 2, Option 3">
            <div class="form-text">Enter choices separated by commas (e.g. Yes, No, Pending).</div>
          </div>

          <div class="row g-3 mb-3">
            <div class="col-md-8">
              <label class="form-label fw-bold small text-secondary">Placeholder / Hint Text</label>
              <input type="text" name="placeholder" class="form-control" placeholder="e.g. Enter 12-digit number">
            </div>
            <div class="col-md-4">
              <label class="form-label fw-bold small text-secondary">Sort Order</label>
              <input type="number" name="sort_order" class="form-control" value="0">
            </div>
          </div>

          <div class="form-check form-switch mt-2">
            <input class="form-check-input" type="checkbox" name="is_required" value="1" id="isRequiredCheck">
            <label class="form-check-label fw-bold text-dark small" for="isRequiredCheck">
              Mark as Required Input (Mandatory)
            </label>
          </div>
        </div>
        <div class="modal-footer bg-light">
          <button type="button" class="btn btn-secondary rounded-pill px-3" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-primary rounded-pill px-4">
            <i class="bi bi-save me-1"></i> Save Input Field
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Modal: Edit Custom Field -->
<div class="modal fade" id="editFieldModal" tabindex="-1" aria-labelledby="editFieldModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow">
      <form method="POST">
        <input type="hidden" name="action" value="edit_field">
        <input type="hidden" name="station_id" value="<?= $selected_station_id ?>">
        <input type="hidden" name="field_id" id="edit_field_id">
        <div class="modal-header bg-dark text-white">
          <h5 class="modal-title fw-bold" id="editFieldModalLabel">
            <i class="bi bi-pencil me-1 text-primary"></i> Edit Input Field
          </h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body p-4">
          <div class="mb-3">
            <label class="form-label fw-bold small text-secondary">Field Label <span class="text-danger">*</span></label>
            <input type="text" name="field_label" id="edit_field_label" class="form-control" required>
          </div>

          <div class="row g-3 mb-3">
            <div class="col-md-6">
              <label class="form-label fw-bold small text-secondary">Field Key</label>
              <input type="text" id="edit_field_key" class="form-control bg-light" readonly>
            </div>
            <div class="col-md-6">
              <label class="form-label fw-bold small text-secondary">Input Type <span class="text-danger">*</span></label>
              <select name="field_type" id="edit_field_type" class="form-select" onchange="toggleOptionsInput(this.value, 'optionsGroupEdit')">
                <option value="text">Text (Single line)</option>
                <option value="number">Number</option>
                <option value="date">Date</option>
                <option value="select">Dropdown (Select list)</option>
                <option value="textarea">Textarea (Multi-line)</option>
                <option value="file">File Upload (Document/Image)</option>
              </select>
            </div>
          </div>

          <div class="mb-3 d-none" id="optionsGroupEdit">
            <label class="form-label fw-bold small text-secondary">Dropdown Options (Comma-separated)</label>
            <input type="text" name="field_options" id="edit_field_options" class="form-control">
          </div>

          <div class="row g-3 mb-3">
            <div class="col-md-8">
              <label class="form-label fw-bold small text-secondary">Placeholder / Hint Text</label>
              <input type="text" name="placeholder" id="edit_placeholder" class="form-control">
            </div>
            <div class="col-md-4">
              <label class="form-label fw-bold small text-secondary">Sort Order</label>
              <input type="number" name="sort_order" id="edit_sort_order" class="form-control">
            </div>
          </div>

          <div class="form-check form-switch mt-2">
            <input class="form-check-input" type="checkbox" name="is_required" value="1" id="edit_is_required">
            <label class="form-check-label fw-bold text-dark small" for="edit_is_required">
              Mark as Required Input (Mandatory)
            </label>
          </div>
        </div>
        <div class="modal-footer bg-light">
          <button type="button" class="btn btn-secondary rounded-pill px-3" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-primary rounded-pill px-4">
            <i class="bi bi-check-lg me-1"></i> Update Input Field
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Modal: Quick Add Standard Presets -->
<div class="modal fade" id="presetsModal" tabindex="-1" aria-labelledby="presetsModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content border-0 shadow">
      <form method="POST">
        <input type="hidden" name="action" value="import_presets">
        <input type="hidden" name="station_id" value="<?= $selected_station_id ?>">
        <div class="modal-header bg-dark text-white">
          <h5 class="modal-title fw-bold" id="presetsModalLabel">
            <i class="bi bi-lightning-charge me-1 text-warning"></i> Quick Add Standard Field Presets
          </h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body p-4">
          <p class="text-muted small mb-3">
            Check the standard fields below that you wish to activate for <strong><?= htmlspecialchars($selectedStationDetails['station_name']) ?></strong>:
          </p>
          <div class="row g-2">
            <?php 
            $currConfiguredKeys = array_column($configuredFields, 'field_key');
            foreach ($standardPresets as $k => $preset): 
              $isAlreadyAdded = in_array($k, $currConfiguredKeys);
            ?>
              <div class="col-md-4 col-sm-6">
                <div class="p-2 border rounded-3 bg-white h-100 <?= $isAlreadyAdded ? 'opacity-50 bg-light' : '' ?>">
                  <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="preset_keys[]" value="<?= $k ?>" id="preset_<?= $k ?>" <?= $isAlreadyAdded ? 'disabled' : '' ?>>
                    <label class="form-check-label small fw-bold text-dark d-block" for="preset_<?= $k ?>">
                      <?= htmlspecialchars($preset['label']) ?>
                      <?php if ($isAlreadyAdded): ?>
                        <span class="badge bg-secondary-subtle text-secondary small py-0 ms-1">Added</span>
                      <?php endif; ?>
                    </label>
                    <span class="text-muted" style="font-size: 0.75rem;">Type: <?= htmlspecialchars($preset['type']) ?></span>
                  </div>
                </div>
              </div>
            <?php endforeach; ?>
          </div>
        </div>
        <div class="modal-footer bg-light d-flex justify-content-between">
          <button type="button" class="btn btn-sm btn-outline-secondary" onclick="toggleAllPresets(true)">Select All Available</button>
          <div>
            <button type="button" class="btn btn-secondary rounded-pill px-3" data-bs-dismiss="modal">Cancel</button>
            <button type="submit" class="btn btn-warning rounded-pill px-4 fw-bold">
              <i class="bi bi-plus-lg me-1"></i> Add Selected Presets
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Modal: Copy Fields From Another Location -->
<div class="modal fade" id="copyModal" tabindex="-1" aria-labelledby="copyModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content border-0 shadow">
      <form method="POST">
        <input type="hidden" name="action" value="copy_from_station">
        <input type="hidden" name="station_id" value="<?= $selected_station_id ?>">
        <div class="modal-header bg-dark text-white">
          <h5 class="modal-title fw-bold" id="copyModalLabel">
            <i class="bi bi-copy me-1 text-primary"></i> Copy Inputs From Another Location
          </h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body p-4">
          <p class="text-muted small mb-3">
            Clone all custom fields configured at another station into <strong><?= htmlspecialchars($selectedStationDetails['station_name']) ?></strong>.
          </p>
          <div class="mb-3">
            <label class="form-label fw-bold small text-secondary">Source Location <span class="text-danger">*</span></label>
            <select name="source_station_id" class="form-select" required>
              <option value="">-- Choose Source Location --</option>
              <?php foreach ($stations as $stn): ?>
                <?php if ($stn['station_id'] != $selected_station_id): ?>
                  <option value="<?= $stn['station_id'] ?>">
                    <?= htmlspecialchars($stn['station_name']) ?> (<?= htmlspecialchars($stn['division_name'] ?? 'Division') ?>)
                  </option>
                <?php endif; ?>
              <?php endforeach; ?>
            </select>
          </div>
        </div>
        <div class="modal-footer bg-light">
          <button type="button" class="btn btn-secondary rounded-pill px-3" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-primary rounded-pill px-4">
            <i class="bi bi-copy me-1"></i> Copy Fields
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
function toggleOptionsInput(type, elementId) {
  const el = document.getElementById(elementId);
  if (type === 'select') {
    el.classList.remove('d-none');
  } else {
    el.classList.add('d-none');
  }
}

function toggleAllPresets(select) {
  document.querySelectorAll('#presetsModal input[name="preset_keys[]"]:not(:disabled)').forEach(cb => {
    cb.checked = select;
  });
}

document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.edit-field-btn').forEach(btn => {
    btn.addEventListener('click', function() {
      const data = JSON.parse(this.getAttribute('data-field'));
      document.getElementById('edit_field_id').value = data.id;
      document.getElementById('edit_field_label').value = data.field_label;
      document.getElementById('edit_field_key').value = data.field_key;
      document.getElementById('edit_field_type').value = data.field_type;
      document.getElementById('edit_field_options').value = data.field_options || '';
      document.getElementById('edit_placeholder').value = data.placeholder || '';
      document.getElementById('edit_sort_order').value = data.sort_order || 0;
      document.getElementById('edit_is_required').checked = (parseInt(data.is_required) === 1);

      toggleOptionsInput(data.field_type, 'optionsGroupEdit');
      new bootstrap.Modal(document.getElementById('editFieldModal')).show();
    });
  });
});
</script>

<?php include 'footer.php'; ?>
