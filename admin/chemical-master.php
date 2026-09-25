<?php
/**
 * MCC - Admin Panel Master Chemical & Type Mapping Management
 * Allows Administrators to define master chemicals per station and map them to cleaning types.
 */
$pageTitle = 'MCC Admin | Chemical Master & Type Mapping';
require_once '../connection.php';
require_once 'header.php';

$message = '';
$messageType = '';

// Fetch all active stations
$stationsStmt = $pdo->query("SELECT station_id, station_name FROM mcc_stations WHERE status = 'Active' ORDER BY station_name ASC");
$stations = $stationsStmt->fetchAll(PDO::FETCH_ASSOC);

// Determine selected station
$selectedStationId = intval($_GET['station_id'] ?? ($stations[0]['station_id'] ?? 0));
if ($selectedStationId <= 0 && !empty($stations)) {
    $selectedStationId = $stations[0]['station_id'];
}

// Fetch all cleaning types
$typesStmt = $pdo->query("SELECT * FROM mcc_chemical_types ORDER BY id ASC");
$chemicalTypes = $typesStmt->fetchAll(PDO::FETCH_ASSOC);
$selectedTypeId = intval($_GET['type_id'] ?? ($chemicalTypes[0]['id'] ?? 1));

// Handle POST actions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    // 1. Add Master Chemical
    if ($action === 'add_chemical') {
        $name = trim($_POST['name'] ?? '');
        $units = trim($_POST['units'] ?? 'ml');
        $stationId = intval($_POST['station_id'] ?? $selectedStationId);
        $mappedTypes = $_POST['mapped_types'] ?? [];

        if (empty($name) || $stationId <= 0) {
            $message = 'Chemical name and station are required.';
            $messageType = 'danger';
        } else {
            try {
                $chk = $pdo->prepare("SELECT id FROM mcc_chemical_param WHERE station_id = :sid AND LOWER(TRIM(name)) = LOWER(:name)");
                $chk->execute(['sid' => $stationId, 'name' => $name]);
                if ($chk->fetch()) {
                    $message = "Chemical '$name' already exists for this station.";
                    $messageType = 'warning';
                } else {
                    $pdo->beginTransaction();
                    $ins = $pdo->prepare("INSERT INTO mcc_chemical_param (station_id, name, units, status) VALUES (:sid, :name, :units, 'Active')");
                    $ins->execute(['sid' => $stationId, 'name' => $name, 'units' => $units]);
                    $newParamId = (int)$pdo->lastInsertId();

                    // Map to selected types immediately if any
                    if (!empty($mappedTypes) && is_array($mappedTypes)) {
                        $insMap = $pdo->prepare("INSERT INTO mcc_chemical_param_type_map (station_id, parameter_id, chemical_type_id, status) VALUES (:sid, :pid, :tid, 'Active')");
                        foreach ($mappedTypes as $tId) {
                            $insMap->execute(['sid' => $stationId, 'pid' => $newParamId, 'tid' => intval($tId)]);
                        }
                    }

                    $pdo->commit();
                    $message = "Chemical '$name' created and mapped successfully!";
                    $messageType = 'success';
                }
            } catch (Exception $e) {
                if ($pdo->inTransaction()) $pdo->rollBack();
                $message = 'Error creating chemical: ' . $e->getMessage();
                $messageType = 'danger';
            }
        }
    }

    // 2. Edit Master Chemical
    if ($action === 'edit_chemical') {
        $paramId = intval($_POST['param_id'] ?? 0);
        $name = trim($_POST['name'] ?? '');
        $units = trim($_POST['units'] ?? 'ml');
        $status = $_POST['status'] ?? 'Active';

        if ($paramId > 0 && !empty($name)) {
            try {
                $upd = $pdo->prepare("UPDATE mcc_chemical_param SET name = :name, units = :units, status = :status WHERE id = :id");
                $upd->execute(['name' => $name, 'units' => $units, 'status' => $status, 'id' => $paramId]);
                $message = "Chemical updated successfully.";
                $messageType = 'success';
            } catch (Exception $e) {
                $message = 'Error updating chemical: ' . $e->getMessage();
                $messageType = 'danger';
            }
        }
    }

    // 3. Save Chemical to Type Mapping Batch
    if ($action === 'save_type_mapping') {
        $stationId = intval($_POST['station_id'] ?? $selectedStationId);
        $typeId = intval($_POST['chemical_type_id'] ?? $selectedTypeId);
        $selectedParams = $_POST['selected_params'] ?? []; // Array of parameter_ids

        if ($stationId > 0 && $typeId > 0) {
            try {
                $pdo->beginTransaction();

                // Get all chemical params for this station
                $allParamsStmt = $pdo->prepare("SELECT id FROM mcc_chemical_param WHERE station_id = :sid");
                $allParamsStmt->execute(['sid' => $stationId]);
                $allStationParams = $allParamsStmt->fetchAll(PDO::FETCH_COLUMN);

                $upsertStmt = $pdo->prepare("
                    INSERT INTO mcc_chemical_param_type_map (station_id, parameter_id, chemical_type_id, status)
                    VALUES (:sid, :pid, :tid, :status)
                    ON DUPLICATE KEY UPDATE status = :status_upd
                ");

                foreach ($allStationParams as $pId) {
                    $isActive = in_array((string)$pId, $selectedParams) || in_array((int)$pId, $selectedParams);
                    $newStatus = $isActive ? 'Active' : 'Inactive';
                    $upsertStmt->execute([
                        'sid' => $stationId,
                        'pid' => $pId,
                        'tid' => $typeId,
                        'status' => $newStatus,
                        'status_upd' => $newStatus
                    ]);
                }

                $pdo->commit();
                $message = "Chemical type mappings updated successfully!";
                $messageType = 'success';
            } catch (Exception $e) {
                if ($pdo->inTransaction()) $pdo->rollBack();
                $message = 'Error updating mappings: ' . $e->getMessage();
                $messageType = 'danger';
            }
        }
    }

    // 4. Delete Chemical
    if ($action === 'delete_chemical') {
        $paramId = intval($_POST['param_id'] ?? 0);
        if ($paramId > 0) {
            try {
                $del = $pdo->prepare("DELETE FROM mcc_chemical_param WHERE id = :id");
                $del->execute(['id' => $paramId]);
                $message = "Chemical removed successfully.";
                $messageType = 'success';
            } catch (Exception $e) {
                $message = 'Error deleting chemical: ' . $e->getMessage();
                $messageType = 'danger';
            }
        }
    }
}

// Fetch all master chemicals for the selected station
$chemicalsStmt = $pdo->prepare("
    SELECT p.*,
           GROUP_CONCAT(CONCAT(t.type_name, '::', m.status) SEPARATOR '||') AS mappings_info,
           COUNT(CASE WHEN m.status = 'Active' THEN 1 END) AS active_maps_count
    FROM mcc_chemical_param p
    LEFT JOIN mcc_chemical_param_type_map m ON p.id = m.parameter_id AND m.station_id = p.station_id
    LEFT JOIN mcc_chemical_types t ON m.chemical_type_id = t.id
    WHERE p.station_id = :sid
    GROUP BY p.id
    ORDER BY p.name ASC
");
$chemicalsStmt->execute(['sid' => $selectedStationId]);
$chemicals = $chemicalsStmt->fetchAll(PDO::FETCH_ASSOC);

// Fetch mapping matrix for the selected type
$typeMapStmt = $pdo->prepare("
    SELECT parameter_id, status 
    FROM mcc_chemical_param_type_map 
    WHERE station_id = :sid AND chemical_type_id = :tid
");
$typeMapStmt->execute(['sid' => $selectedStationId, 'tid' => $selectedTypeId]);
$typeMappings = $typeMapStmt->fetchAll(PDO::FETCH_KEY_PAIR); // param_id => status

include 'sidebar.php';
?>

<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
  <div class="d-flex flex-column flex-column-fluid">
    <div class="app-content flex-column-fluid py-4 px-3 px-md-4">
      <div class="container-fluid max-w-7xl">

        <!-- Page Header -->
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
          <div>
            <h3 class="fw-bold text-dark mb-1">
              <i class="bi bi-droplet-half text-indigo me-2"></i>Chemical Master & Type Mapping
            </h3>
            <p class="text-muted small mb-0">Create chemicals once per station and map them to Intensive, Normal, PRT, Vande Bharat, etc.</p>
          </div>
          
          <!-- Station Selector -->
          <form method="GET" class="d-flex align-items-center gap-2">
            <label class="fw-semibold small text-muted text-nowrap">Station:</label>
            <select name="station_id" class="form-select form-select-sm fw-bold border-indigo shadow-sm" onchange="this.form.submit()" style="min-width: 200px;">
              <?php foreach ($stations as $stn): ?>
                <option value="<?= $stn['station_id'] ?>" <?= ($stn['station_id'] == $selectedStationId) ? 'selected' : '' ?>>
                  <?= htmlspecialchars($stn['station_name']) ?>
                </option>
              <?php endforeach; ?>
            </select>
          </form>
        </div>

        <?php if (!empty($message)): ?>
          <div class="alert alert-<?= $messageType ?> alert-dismissible fade show shadow-sm mb-4" role="alert">
            <?= htmlspecialchars($message) ?>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
          </div>
        <?php endif; ?>

        <!-- Quick Summary Stats -->
        <div class="row g-3 mb-4">
          <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm rounded-4 p-3 bg-white h-100">
              <span class="text-muted small fw-semibold">Total Master Chemicals</span>
              <h3 class="fw-bold text-dark mt-2 mb-0"><?= count($chemicals) ?></h3>
            </div>
          </div>
          <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm rounded-4 p-3 bg-white h-100">
              <span class="text-muted small fw-semibold">Cleaning Categories</span>
              <h3 class="fw-bold text-indigo mt-2 mb-0"><?= count($chemicalTypes) ?></h3>
            </div>
          </div>
          <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm rounded-4 p-3 bg-white h-100">
              <span class="text-muted small fw-semibold">Active in <?= htmlspecialchars($chemicalTypes[array_search($selectedTypeId, array_column($chemicalTypes, 'id'))]['type_name'] ?? 'Selected') ?></span>
              <h3 class="fw-bold text-success mt-2 mb-0">
                <?= count(array_filter($typeMappings, fn($s) => $s === 'Active')) ?>
              </h3>
            </div>
          </div>
          <div class="col-6 col-md-3">
            <div class="card border-0 shadow-sm rounded-4 p-3 bg-indigo text-white h-100 d-flex justify-content-center">
              <button class="btn btn-light btn-sm fw-bold rounded-pill text-indigo" data-bs-toggle="modal" data-bs-target="#addChemicalModal">
                <i class="bi bi-plus-lg me-1"></i> Add New Chemical
              </button>
            </div>
          </div>
        </div>

        <!-- Navigation Tabs -->
        <ul class="nav nav-pills mb-4 bg-white p-2 rounded-4 shadow-sm" id="pills-tab" role="tablist">
          <li class="nav-item" role="presentation">
            <button class="nav-link active rounded-pill fw-semibold px-4" id="tab-master-btn" data-bs-toggle="pill" data-bs-target="#tab-master" type="button" role="tab">
              <i class="bi bi-list-check me-2"></i>Master Chemicals (Station Catalog)
            </button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link rounded-pill fw-semibold px-4" id="tab-mapping-btn" data-bs-toggle="pill" data-bs-target="#tab-mapping" type="button" role="tab">
              <i class="bi bi-diagram-3-fill me-2"></i>Module Mapping Matrix
            </button>
          </li>
        </ul>

        <div class="tab-content" id="pills-tabContent">

          <!-- TAB 1: MASTER CHEMICAL LIST -->
          <div class="tab-pane fade show active" id="tab-master" role="tabpanel">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white">
              <div class="card-header bg-white py-3 px-4 d-flex justify-content-between align-items-center">
                <h5 class="fw-bold m-0 text-dark">Chemicals List</h5>
                <button class="btn btn-indigo btn-sm rounded-pill" data-bs-toggle="modal" data-bs-target="#addChemicalModal">
                  <i class="bi bi-plus-circle me-1"></i> Add Chemical
                </button>
              </div>
              <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                  <thead class="bg-light">
                    <tr>
                      <th class="ps-4" style="width: 60px;">#</th>
                      <th>Chemical Name</th>
                      <th>Unit of Measure</th>
                      <th>Mapped Cleaning Modules</th>
                      <th>Status</th>
                      <th class="text-end pe-4">Actions</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php if (empty($chemicals)): ?>
                      <tr>
                        <td colspan="6" class="text-center py-5 text-muted">
                          <i class="bi bi-droplet text-secondary display-6 d-block mb-2"></i>
                          No chemicals created for this station yet. Click "Add New Chemical" to start.
                        </td>
                      </tr>
                    <?php else: ?>
                      <?php foreach ($chemicals as $idx => $chem): ?>
                        <tr>
                          <td class="ps-4 fw-bold text-muted"><?= $idx + 1 ?></td>
                          <td>
                            <span class="fw-bold text-dark"><?= htmlspecialchars($chem['name']) ?></span>
                          </td>
                          <td>
                            <span class="badge bg-light text-dark border px-2 py-1"><?= htmlspecialchars($chem['units'] ?: 'ml') ?></span>
                          </td>
                          <td>
                            <?php 
                            if (!empty($chem['mappings_info'])) {
                                $maps = explode('||', $chem['mappings_info']);
                                foreach ($maps as $mInfo) {
                                    $parts = explode('::', $mInfo);
                                    $tName = $parts[0] ?? '';
                                    $mStatus = $parts[1] ?? 'Active';
                                    if ($mStatus === 'Active') {
                                        echo '<span class="badge bg-indigo-subtle text-indigo me-1 mb-1">' . htmlspecialchars($tName) . '</span>';
                                    }
                                }
                            } else {
                                echo '<span class="text-muted small italic">Not mapped to any type</span>';
                            }
                            ?>
                          </td>
                          <td>
                            <?php if ($chem['status'] === 'Active'): ?>
                              <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1">Active</span>
                            <?php else: ?>
                              <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-2 py-1">Inactive</span>
                            <?php endif; ?>
                          </td>
                          <td class="text-end pe-4">
                            <button class="btn btn-light btn-sm text-primary rounded-circle me-1" 
                                    data-bs-toggle="modal" 
                                    data-bs-target="#editChemicalModal<?= $chem['id'] ?>" title="Edit">
                              <i class="bi bi-pencil-fill"></i>
                            </button>
                            <button class="btn btn-light btn-sm text-danger rounded-circle" 
                                    data-bs-toggle="modal" 
                                    data-bs-target="#deleteChemicalModal<?= $chem['id'] ?>" title="Delete">
                              <i class="bi bi-trash-fill"></i>
                            </button>
                          </td>
                        </tr>

                        <!-- Edit Modal -->
                        <div class="modal fade" id="editChemicalModal<?= $chem['id'] ?>" tabindex="-1" aria-hidden="true">
                          <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content rounded-4 border-0 shadow">
                              <form method="POST">
                                <input type="hidden" name="action" value="edit_chemical">
                                <input type="hidden" name="param_id" value="<?= $chem['id'] ?>">
                                <input type="hidden" name="station_id" value="<?= $selectedStationId ?>">
                                <div class="modal-header border-0 pb-0">
                                  <h5 class="modal-title fw-bold">Edit Chemical</h5>
                                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                  <div class="mb-3">
                                    <label class="form-label fw-semibold small">Chemical Name</label>
                                    <input type="text" name="name" class="form-control" value="<?= htmlspecialchars($chem['name']) ?>" required>
                                  </div>
                                  <div class="mb-3">
                                    <label class="form-label fw-semibold small">Unit (ml / Ltr / Kg / Nos)</label>
                                    <input type="text" name="units" class="form-control" value="<?= htmlspecialchars($chem['units']) ?>" required>
                                  </div>
                                  <div class="mb-3">
                                    <label class="form-label fw-semibold small">Status</label>
                                    <select name="status" class="form-select">
                                      <option value="Active" <?= ($chem['status'] === 'Active') ? 'selected' : '' ?>>Active</option>
                                      <option value="Inactive" <?= ($chem['status'] === 'Inactive') ? 'selected' : '' ?>>Inactive</option>
                                    </select>
                                  </div>
                                </div>
                                <div class="modal-footer border-0 pt-0">
                                  <button type="button" class="btn btn-light rounded-pill" data-bs-dismiss="modal">Cancel</button>
                                  <button type="submit" class="btn btn-indigo rounded-pill px-4">Save Changes</button>
                                </div>
                              </form>
                            </div>
                          </div>
                        </div>

                        <!-- Delete Modal -->
                        <div class="modal fade" id="deleteChemicalModal<?= $chem['id'] ?>" tabindex="-1" aria-hidden="true">
                          <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content rounded-4 border-0 shadow">
                              <form method="POST">
                                <input type="hidden" name="action" value="delete_chemical">
                                <input type="hidden" name="param_id" value="<?= $chem['id'] ?>">
                                <div class="modal-header border-0 pb-0">
                                  <h5 class="modal-title fw-bold text-danger">Delete Chemical</h5>
                                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                  <p class="mb-0">Are you sure you want to delete <strong><?= htmlspecialchars($chem['name']) ?></strong>? All associated mappings and targets for this chemical will also be removed.</p>
                                </div>
                                <div class="modal-footer border-0 pt-0">
                                  <button type="button" class="btn btn-light rounded-pill" data-bs-dismiss="modal">Cancel</button>
                                  <button type="submit" class="btn btn-danger rounded-pill px-4">Delete</button>
                                </div>
                              </form>
                            </div>
                          </div>
                        </div>

                      <?php endforeach; ?>
                    <?php endif; ?>
                  </tbody>
                </table>
              </div>
            </div>
          </div>

          <!-- TAB 2: TYPE MAPPING MATRIX -->
          <div class="tab-pane fade" id="tab-mapping" role="tabpanel">
            <div class="card border-0 shadow-sm rounded-4 bg-white p-4">
              
              <!-- Sub-header for Module selection -->
              <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3 pb-3 border-bottom">
                <div>
                  <h5 class="fw-bold mb-1">Select Cleaning Type to Configure Mappings</h5>
                  <p class="text-muted small mb-0">Check the chemicals that should be available and active for this specific module in Mobile App & Reports.</p>
                </div>
                
                <div class="d-flex gap-2">
                  <?php foreach ($chemicalTypes as $ct): ?>
                    <a href="?station_id=<?= $selectedStationId ?>&type_id=<?= $ct['id'] ?>" 
                       class="btn btn-sm rounded-pill fw-semibold <?= ($ct['id'] == $selectedTypeId) ? 'btn-indigo' : 'btn-light' ?>">
                      <?= htmlspecialchars($ct['type_name']) ?>
                    </a>
                  <?php endforeach; ?>
                </div>
              </div>

              <!-- Mapping Form -->
              <form method="POST">
                <input type="hidden" name="action" value="save_type_mapping">
                <input type="hidden" name="station_id" value="<?= $selectedStationId ?>">
                <input type="hidden" name="chemical_type_id" value="<?= $selectedTypeId ?>">

                <div class="d-flex justify-content-between align-items-center mb-3">
                  <span class="fw-bold text-dark">
                    Configuring: <span class="text-indigo"><?= htmlspecialchars($chemicalTypes[array_search($selectedTypeId, array_column($chemicalTypes, 'id'))]['type_name'] ?? '') ?></span>
                  </span>
                  <div>
                    <button type="button" class="btn btn-sm btn-link text-decoration-none" onclick="toggleSelectAll(true)">Select All</button>
                    <button type="button" class="btn btn-sm btn-link text-decoration-none text-danger" onclick="toggleSelectAll(false)">Deselect All</button>
                  </div>
                </div>

                <div class="row g-3 mb-4">
                  <?php if (empty($chemicals)): ?>
                    <div class="col-12 text-center py-4 text-muted">
                      No chemicals available for this station. Add chemicals in Tab 1 first.
                    </div>
                  <?php else: ?>
                    <?php foreach ($chemicals as $chem): ?>
                      <?php $isMapped = isset($typeMappings[$chem['id']]) && $typeMappings[$chem['id']] === 'Active'; ?>
                      <div class="col-md-4 col-sm-6">
                        <label class="card h-100 border p-3 rounded-3 cursor-pointer user-select-none chemical-card-select <?= $isMapped ? 'border-indigo bg-indigo-subtle' : 'bg-light' ?>" style="cursor: pointer;">
                          <div class="form-check d-flex align-items-center gap-2 m-0">
                            <input class="form-check-input chem-checkbox" 
                                   type="checkbox" 
                                   name="selected_params[]" 
                                   value="<?= $chem['id'] ?>" 
                                   <?= $isMapped ? 'checked' : '' ?>
                                   onchange="this.closest('.chemical-card-select').classList.toggle('border-indigo', this.checked); this.closest('.chemical-card-select').classList.toggle('bg-indigo-subtle', this.checked);">
                            <div class="ms-2">
                              <div class="fw-bold text-dark"><?= htmlspecialchars($chem['name']) ?></div>
                              <span class="text-muted small">Unit: <?= htmlspecialchars($chem['units'] ?: 'ml') ?></span>
                            </div>
                          </div>
                        </label>
                      </div>
                    <?php endforeach; ?>
                  <?php endif; ?>
                </div>

                <div class="d-flex justify-content-end gap-2">
                  <button type="submit" class="btn btn-indigo rounded-pill px-4 fw-bold">
                    <i class="bi bi-check2-circle me-1"></i> Save Mapping Configuration
                  </button>
                </div>
              </form>

            </div>
          </div>

        </div>

      </div>
    </div>
  </div>
</div>

<!-- Add Chemical Modal -->
<div class="modal fade" id="addChemicalModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content rounded-4 border-0 shadow">
      <form method="POST">
        <input type="hidden" name="action" value="add_chemical">
        <input type="hidden" name="station_id" value="<?= $selectedStationId ?>">
        <div class="modal-header border-0 pb-0">
          <h5 class="modal-title fw-bold">Add Master Chemical</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="mb-3">
            <label class="form-label fw-semibold small">Chemical / Item Name</label>
            <input type="text" name="name" class="form-control" placeholder="e.g. TASKI R1 Super" required>
          </div>
          <div class="mb-3">
            <label class="form-label fw-semibold small">Unit of Measurement</label>
            <input type="text" name="units" class="form-control" value="ml" placeholder="ml, Ltr, Kg, Nos" required>
          </div>
          <div class="mb-3">
            <label class="form-label fw-semibold small">Auto-Map to Cleaning Types</label>
            <div class="row g-2 mt-1">
              <?php foreach ($chemicalTypes as $ct): ?>
                <div class="col-6">
                  <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="mapped_types[]" value="<?= $ct['id'] ?>" id="map_type_<?= $ct['id'] ?>" checked>
                    <label class="form-check-label small" for="map_type_<?= $ct['id'] ?>">
                      <?= htmlspecialchars($ct['type_name']) ?>
                    </label>
                  </div>
                </div>
              <?php endforeach; ?>
            </div>
          </div>
        </div>
        <div class="modal-footer border-0 pt-0">
          <button type="button" class="btn btn-light rounded-pill" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-indigo rounded-pill px-4">Create Chemical</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
function toggleSelectAll(select) {
  document.querySelectorAll('.chem-checkbox').forEach(cb => {
    cb.checked = select;
    const card = cb.closest('.chemical-card-select');
    if (select) {
      card.classList.add('border-indigo', 'bg-indigo-subtle');
    } else {
      card.classList.remove('border-indigo', 'bg-indigo-subtle');
    }
  });
}
</script>

<style>
.btn-indigo {
  background-color: var(--admin-primary) !important;
  color: #fff !important;
  border: none;
}
.btn-indigo:hover {
  background-color: var(--admin-primary-dark) !important;
  color: #fff !important;
}
.text-indigo {
  color: var(--admin-primary) !important;
}
.border-indigo {
  border-color: var(--admin-primary) !important;
}
.bg-indigo-subtle {
  background-color: #e0e7ff !important;
}
</style>

<?php require_once 'footer.php'; ?>
