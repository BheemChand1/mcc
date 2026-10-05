<?php
/**
 * CDO Dashboard - Chemical Master & Module Mapping
 * Allows CDO to add, edit, delete master chemicals and configure mappings to cleaning modules.
 */
require_once 'auth.php';

$successMsg = '';
$errorMsg = '';

// Fetch all base units
$unitsStmt = $pdo->query("SELECT * FROM mcc_chemical_units ORDER BY unit_type, conversion_to_base ASC");
$allUnits = $unitsStmt->fetchAll(PDO::FETCH_ASSOC);

// Fetch all chemical types (cleaning modules)
$typesStmt = $pdo->query("SELECT * FROM mcc_chemical_types ORDER BY id ASC");
$chemicalTypes = $typesStmt->fetchAll(PDO::FETCH_ASSOC);

$selectedTypeId = intval($_GET['type_id'] ?? ($chemicalTypes[0]['id'] ?? 1));

// Handle POST actions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (!empty($isViewer)) {
        $errorMsg = "Viewers are in read-only mode and cannot perform modifications.";
    } else {
        $action = $_POST['action'] ?? '';

        // 1. ADD MASTER CHEMICAL
        if ($action === 'add_chemical') {
            $name = trim($_POST['name'] ?? '');
            $unitType = trim($_POST['unit_type'] ?? 'volume');
            $baseUnitId = intval($_POST['base_unit_id'] ?? 1);
            $mappedTypes = $_POST['mapped_types'] ?? [];

            if (empty($name)) {
                $errorMsg = 'Please enter a valid chemical name.';
            } else {
                try {
                    // Check for duplicate name for this station
                    $chk = $pdo->prepare("SELECT id FROM mcc_chemical_param WHERE station_id = :sid AND LOWER(TRIM(name)) = LOWER(:name)");
                    $chk->execute(['sid' => $stationId, 'name' => $name]);
                    if ($chk->fetch()) {
                        $errorMsg = "A chemical with the name '" . htmlspecialchars($name) . "' already exists for this station.";
                    } else {
                        $pdo->beginTransaction();

                        // Check if units column exists in mcc_chemical_param
                        $hasUnitsCol = false;
                        try {
                            $colCheck = $pdo->query("SHOW COLUMNS FROM mcc_chemical_param LIKE 'units'");
                            $hasUnitsCol = ($colCheck && $colCheck->rowCount() > 0);
                        } catch (Exception $e) {}

                        // Get unit symbol
                        $unitSymStmt = $pdo->prepare("SELECT unit_symbol FROM mcc_chemical_units WHERE id = :uid");
                        $unitSymStmt->execute(['uid' => $baseUnitId]);
                        $unitSymbol = $unitSymStmt->fetchColumn() ?: ($unitType === 'volume' ? 'ml' : ($unitType === 'weight' ? 'g' : 'pcs'));

                        if ($hasUnitsCol) {
                            $ins = $pdo->prepare("
                                INSERT INTO mcc_chemical_param (station_id, name, base_unit_id, unit_type, units, status) 
                                VALUES (:sid, :name, :b_uid, :u_type, :units, 'Active')
                            ");
                            $ins->execute([
                                'sid' => $stationId,
                                'name' => $name,
                                'b_uid' => $baseUnitId,
                                'u_type' => $unitType,
                                'units' => $unitSymbol
                            ]);
                        } else {
                            $ins = $pdo->prepare("
                                INSERT INTO mcc_chemical_param (station_id, name, base_unit_id, unit_type, status) 
                                VALUES (:sid, :name, :b_uid, :u_type, 'Active')
                            ");
                            $ins->execute([
                                'sid' => $stationId,
                                'name' => $name,
                                'b_uid' => $baseUnitId,
                                'u_type' => $unitType
                            ]);
                        }

                        $newParamId = (int)$pdo->lastInsertId();

                        // Initialize stock entry
                        $initStock = $pdo->prepare("
                            INSERT INTO mcc_chemical_stock (station_id, parameter_id, stock_quantity)
                            VALUES (:sid, :pid, 0)
                            ON DUPLICATE KEY UPDATE stock_quantity = stock_quantity
                        ");
                        $initStock->execute(['sid' => $stationId, 'pid' => $newParamId]);

                        // Map to selected cleaning types
                        if (!empty($mappedTypes) && is_array($mappedTypes)) {
                            $insMap = $pdo->prepare("
                                INSERT INTO mcc_chemical_param_type_map (station_id, parameter_id, chemical_type_id, status) 
                                VALUES (:sid, :pid, :tid, 'Active')
                                ON DUPLICATE KEY UPDATE status = 'Active'
                            ");
                            foreach ($mappedTypes as $tId) {
                                $insMap->execute(['sid' => $stationId, 'pid' => $newParamId, 'tid' => intval($tId)]);
                            }
                        }

                        $pdo->commit();
                        $successMsg = "Chemical '" . htmlspecialchars($name) . "' created and mapped successfully!";
                    }
                } catch (Exception $e) {
                    if ($pdo->inTransaction()) $pdo->rollBack();
                    $errorMsg = 'Error creating chemical: ' . $e->getMessage();
                }
            }
        }

        // 2. EDIT MASTER CHEMICAL
        if ($action === 'edit_chemical') {
            $paramId = intval($_POST['param_id'] ?? 0);
            $name = trim($_POST['name'] ?? '');
            $unitType = trim($_POST['unit_type'] ?? 'volume');
            $baseUnitId = intval($_POST['base_unit_id'] ?? 1);
            $status = $_POST['status'] ?? 'Active';
            $mappedTypes = $_POST['mapped_types'] ?? [];

            if ($paramId > 0 && !empty($name)) {
                try {
                    $pdo->beginTransaction();

                    // Check if units column exists
                    $hasUnitsCol = false;
                    try {
                        $colCheck = $pdo->query("SHOW COLUMNS FROM mcc_chemical_param LIKE 'units'");
                        $hasUnitsCol = ($colCheck && $colCheck->rowCount() > 0);
                    } catch (Exception $e) {}

                    $unitSymStmt = $pdo->prepare("SELECT unit_symbol FROM mcc_chemical_units WHERE id = :uid");
                    $unitSymStmt->execute(['uid' => $baseUnitId]);
                    $unitSymbol = $unitSymStmt->fetchColumn() ?: 'ml';

                    if ($hasUnitsCol) {
                        $upd = $pdo->prepare("
                            UPDATE mcc_chemical_param 
                            SET name = :name, base_unit_id = :b_uid, unit_type = :u_type, units = :units, status = :status 
                            WHERE id = :id AND station_id = :sid
                        ");
                        $upd->execute([
                            'name' => $name,
                            'b_uid' => $baseUnitId,
                            'u_type' => $unitType,
                            'units' => $unitSymbol,
                            'status' => $status,
                            'id' => $paramId,
                            'sid' => $stationId
                        ]);
                    } else {
                        $upd = $pdo->prepare("
                            UPDATE mcc_chemical_param 
                            SET name = :name, base_unit_id = :b_uid, unit_type = :u_type, status = :status 
                            WHERE id = :id AND station_id = :sid
                        ");
                        $upd->execute([
                            'name' => $name,
                            'b_uid' => $baseUnitId,
                            'u_type' => $unitType,
                            'status' => $status,
                            'id' => $paramId,
                            'sid' => $stationId
                        ]);
                    }

                    // Update Mappings for this chemical
                    $allTypesStmt = $pdo->query("SELECT id FROM mcc_chemical_types");
                    $allTypeIds = $allTypesStmt->fetchAll(PDO::FETCH_COLUMN);

                    $upsertMap = $pdo->prepare("
                        INSERT INTO mcc_chemical_param_type_map (station_id, parameter_id, chemical_type_id, status)
                        VALUES (:sid, :pid, :tid, :status)
                        ON DUPLICATE KEY UPDATE status = :status_upd
                    ");

                    foreach ($allTypeIds as $tid) {
                        $isMapped = in_array((string)$tid, $mappedTypes) || in_array((int)$tid, $mappedTypes);
                        $mapStatus = $isMapped ? 'Active' : 'Inactive';
                        $upsertMap->execute([
                            'sid' => $stationId,
                            'pid' => $paramId,
                            'tid' => $tid,
                            'status' => $mapStatus,
                            'status_upd' => $mapStatus
                        ]);
                    }

                    $pdo->commit();
                    $successMsg = "Chemical '" . htmlspecialchars($name) . "' updated successfully!";
                } catch (Exception $e) {
                    if ($pdo->inTransaction()) $pdo->rollBack();
                    $errorMsg = 'Error updating chemical: ' . $e->getMessage();
                }
            }
        }

        // 3. DELETE MASTER CHEMICAL
        if ($action === 'delete_chemical') {
            $paramId = intval($_POST['param_id'] ?? 0);
            if ($paramId > 0) {
                try {
                    $pdo->beginTransaction();

                    // Delete mappings
                    $delMaps = $pdo->prepare("DELETE FROM mcc_chemical_param_type_map WHERE parameter_id = :pid AND station_id = :sid");
                    $delMaps->execute(['pid' => $paramId, 'sid' => $stationId]);

                    // Delete stock
                    $delStock = $pdo->prepare("DELETE FROM mcc_chemical_stock WHERE parameter_id = :pid AND station_id = :sid");
                    $delStock->execute(['pid' => $paramId, 'sid' => $stationId]);

                    // Delete param
                    $delParam = $pdo->prepare("DELETE FROM mcc_chemical_param WHERE id = :id AND station_id = :sid");
                    $delParam->execute(['id' => $paramId, 'sid' => $stationId]);

                    $pdo->commit();
                    $successMsg = "Chemical and its mappings deleted successfully.";
                } catch (Exception $e) {
                    if ($pdo->inTransaction()) $pdo->rollBack();
                    $errorMsg = 'Error deleting chemical: ' . $e->getMessage();
                }
            }
        }

        // 4. BATCH SAVE MODULE MAPPING MATRIX
        if ($action === 'save_type_mapping') {
            $typeId = intval($_POST['chemical_type_id'] ?? $selectedTypeId);
            $selectedParams = $_POST['selected_params'] ?? []; // Array of parameter_ids

            if ($typeId > 0) {
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
                    $successMsg = "Chemical mappings updated successfully for the selected cleaning module!";
                    $selectedTypeId = $typeId;
                } catch (Exception $e) {
                    if ($pdo->inTransaction()) $pdo->rollBack();
                    $errorMsg = 'Error updating mappings: ' . $e->getMessage();
                }
            }
        }
    }
}

// Fetch all master chemicals for this station with mapped types information
$chemicalsStmt = $pdo->prepare("
    SELECT p.*,
           u.unit_name,
           u.unit_symbol,
           GROUP_CONCAT(CONCAT(t.id, '::', t.type_name, '::', m.status) SEPARATOR '||') AS mappings_info,
           COUNT(CASE WHEN m.status = 'Active' THEN 1 END) AS active_maps_count
    FROM mcc_chemical_param p
    LEFT JOIN mcc_chemical_units u ON p.base_unit_id = u.id
    LEFT JOIN mcc_chemical_param_type_map m ON p.id = m.parameter_id AND m.station_id = p.station_id
    LEFT JOIN mcc_chemical_types t ON m.chemical_type_id = t.id
    WHERE p.station_id = :sid
    GROUP BY p.id
    ORDER BY p.name ASC
");
$chemicalsStmt->execute(['sid' => $stationId]);
$chemicals = $chemicalsStmt->fetchAll(PDO::FETCH_ASSOC);

// Fetch mapping matrix for the selected type
$typeMapStmt = $pdo->prepare("
    SELECT parameter_id, status 
    FROM mcc_chemical_param_type_map 
    WHERE station_id = :sid AND chemical_type_id = :tid
");
$typeMapStmt->execute(['sid' => $stationId, 'tid' => $selectedTypeId]);
$typeMappings = $typeMapStmt->fetchAll(PDO::FETCH_KEY_PAIR); // param_id => status

// Find currently selected type name
$currentTypeName = '';
foreach ($chemicalTypes as $ct) {
    if ($ct['id'] == $selectedTypeId) {
        $currentTypeName = $ct['type_name'];
        break;
    }
}

$pageTitle = "Add & Map Chemicals | MCC";

include 'header.php';
include 'sidebar.php';
?>

<style>
.chem-mgmt-card {
    background: #ffffff !important;
    border: 1px solid #cbd5e1 !important;
    padding: 24px !important;
    width: 100% !important;
    margin-bottom: 30px !important;
    box-shadow: 0 4px 14px rgba(0, 0, 0, 0.05) !important;
    border-radius: 10px !important;
}
.chem-custom-table th {
    background: #07385f !important;
    color: #ffffff !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    text-transform: uppercase !important;
    letter-spacing: 0.5px !important;
    vertical-align: middle !important;
    padding: 12px 14px !important;
    border: 1px solid #0b476a !important;
}
.chem-custom-table td {
    font-size: 13.5px !important;
    vertical-align: middle !important;
    padding: 12px 14px !important;
    color: #334155 !important;
    border: 1px solid #e2e8f0 !important;
}
.chem-custom-table tbody tr:hover {
    background-color: #f8fafc !important;
}
.stat-box {
    background: #ffffff;
    border: 1px solid #e2e8f0;
    border-radius: 10px;
    padding: 16px 20px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.03);
    transition: all 0.2s ease;
}
.stat-box:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(0,0,0,0.06);
}
.type-badge-pill {
    font-size: 11.5px;
    font-weight: 600;
    padding: 4px 10px;
    border-radius: 20px;
    display: inline-flex;
    align-items: center;
    gap: 4px;
    margin: 2px;
}
.btn-nav-tab {
    font-weight: 600;
    font-size: 13.5px;
    padding: 9px 20px;
    border-radius: 8px;
    transition: all 0.2s;
    border: 1px solid #cbd5e1;
    background: #f8fafc;
    color: #475569;
}
.btn-nav-tab.active {
    background: #07385f !important;
    color: #ffffff !important;
    border-color: #07385f !important;
    box-shadow: 0 2px 8px rgba(7, 56, 95, 0.25);
}
.btn-nav-tab:hover:not(.active) {
    background: #e2e8f0;
    color: #1e293b;
}
.module-item-checkbox {
    border: 1px solid #e2e8f0;
    border-radius: 8px;
    padding: 12px 16px;
    background: #ffffff;
    transition: all 0.15s ease;
}
.module-item-checkbox:hover {
    background: #f8fafc;
    border-color: #cbd5e1;
}
</style>

<main class="app-main">
    <div class="app-content">
        <div class="container-fluid">
            
            <!-- Top Filter & Action Bar -->
            <div class="report-filter no-print d-flex justify-content-between align-items-center mb-3">
                <div class="d-flex align-items-center gap-2">
                    <span class="fw-bold text-white"><i class="bi bi-droplet-half me-1"></i> Chemical Master & Type Mapping</span>
                </div>
                <div class="d-flex align-items-center gap-2">
                    <button type="button" class="btn btn-sm btn-success fw-bold px-3 shadow-sm" data-bs-toggle="modal" data-bs-target="#addChemicalModal">
                        <i class="bi bi-plus-circle-fill me-1"></i> Add New Chemical
                    </button>
                    <a href="chemical-inventory.php" class="btn-summary">
                        <i class="bi bi-boxes me-1"></i> Chemical Stock
                    </a>
                    <a href="chemical-daily-report.php" class="btn-summary">
                        <i class="bi bi-calendar2-day me-1"></i> Daily Usage Report
                    </a>
                </div>
            </div>

            <div class="report-wrap">

                <?php if (!empty($successMsg)): ?>
                    <div class="alert alert-success alert-dismissible fade show no-print shadow-sm" role="alert" style="border-radius: 8px;">
                        <i class="bi bi-check-circle-fill me-2 fs-5 align-middle"></i> <?= htmlspecialchars($successMsg) ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <?php endif; ?>

                <?php if (!empty($errorMsg)): ?>
                    <div class="alert alert-danger alert-dismissible fade show no-print shadow-sm" role="alert" style="border-radius: 8px;">
                        <i class="bi bi-exclamation-triangle-fill me-2 fs-5 align-middle"></i> <?= htmlspecialchars($errorMsg) ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <?php endif; ?>

                <!-- Summary Stat Cards -->
                <div class="row g-3 mb-4">
                    <div class="col-6 col-md-3">
                        <div class="stat-box">
                            <div class="d-flex align-items-center justify-content-between">
                                <span class="text-muted small fw-bold text-uppercase">Total Chemicals</span>
                                <i class="bi bi-box-seam text-primary fs-4"></i>
                            </div>
                            <h3 class="fw-bold text-dark mt-2 mb-0"><?= count($chemicals) ?></h3>
                            <small class="text-muted">Master items for <?= htmlspecialchars($stationName) ?></small>
                        </div>
                    </div>
                    <div class="col-6 col-md-3">
                        <div class="stat-box">
                            <div class="d-flex align-items-center justify-content-between">
                                <span class="text-muted small fw-bold text-uppercase">Active Chemicals</span>
                                <i class="bi bi-check-circle-fill text-success fs-4"></i>
                            </div>
                            <h3 class="fw-bold text-success mt-2 mb-0">
                                <?= count(array_filter($chemicals, fn($c) => ($c['status'] ?? 'Active') === 'Active')) ?>
                            </h3>
                            <small class="text-muted">Available for stock & audit</small>
                        </div>
                    </div>
                    <div class="col-6 col-md-3">
                        <div class="stat-box">
                            <div class="d-flex align-items-center justify-content-between">
                                <span class="text-muted small fw-bold text-uppercase">Cleaning Modules</span>
                                <i class="bi bi-diagram-3-fill text-info fs-4"></i>
                            </div>
                            <h3 class="fw-bold text-info mt-2 mb-0"><?= count($chemicalTypes) ?></h3>
                            <small class="text-muted">Intensive, Normal, PRT, etc.</small>
                        </div>
                    </div>
                    <div class="col-6 col-md-3">
                        <div class="stat-box bg-light border-primary" style="background: linear-gradient(135deg, #07385f 0%, #0d5c94 100%) !important; color: #ffffff;">
                            <div class="d-flex align-items-center justify-content-between">
                                <span class="text-white-50 small fw-bold text-uppercase">Quick Action</span>
                                <i class="bi bi-lightning-charge-fill text-warning fs-4"></i>
                            </div>
                            <button type="button" class="btn btn-warning btn-sm fw-bold w-100 mt-2 text-dark shadow-sm" data-bs-toggle="modal" data-bs-target="#addChemicalModal">
                                <i class="bi bi-plus-lg me-1"></i> Add Chemical
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Nav Tabs -->
                <ul class="nav nav-pills gap-2 mb-3" id="chemMgmtTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link btn-nav-tab active" id="tab-master-btn" data-bs-toggle="pill" data-bs-target="#tab-master" type="button" role="tab">
                            <i class="bi bi-list-stars me-1"></i> Master Chemicals List (<?= count($chemicals) ?>)
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link btn-nav-tab" id="tab-matrix-btn" data-bs-toggle="pill" data-bs-target="#tab-matrix" type="button" role="tab">
                            <i class="bi bi-diagram-3 me-1"></i> Module Mapping Matrix
                        </button>
                    </li>
                </ul>

                <div class="tab-content" id="chemMgmtTabContent">

                    <!-- TAB 1: MASTER CHEMICALS LIST -->
                    <div class="tab-pane fade show active" id="tab-master" role="tabpanel">
                        <div class="chem-mgmt-card">
                            <div class="d-flex flex-wrap justify-content-between align-items-center border-bottom pb-3 mb-3 gap-2">
                                <div>
                                    <h2 style="font-size: 17px; font-weight: 700; color: #1e293b; margin: 0;">
                                        <i class="bi bi-card-checklist me-2 text-primary"></i> Station Chemicals Catalog
                                    </h2>
                                    <span class="text-muted small">Manage master chemical definitions and their mapped cleaning modules for <strong><?= htmlspecialchars($stationName) ?></strong>.</span>
                                </div>
                                <div class="d-flex align-items-center gap-2">
                                    <input type="text" id="chemSearchInput" class="form-control form-control-sm" placeholder="Search chemical..." style="max-width: 220px;">
                                    <button type="button" class="btn btn-sm btn-primary fw-bold text-nowrap" data-bs-toggle="modal" data-bs-target="#addChemicalModal">
                                        <i class="bi bi-plus-lg me-1"></i> Add Chemical
                                    </button>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-bordered chem-custom-table mb-0 align-middle" id="chemTable">
                                    <thead>
                                        <tr>
                                            <th style="width: 50px;" class="text-center">#</th>
                                            <th>Chemical Name</th>
                                            <th class="text-center" style="width: 140px;">Type & Unit</th>
                                            <th>Mapped Cleaning Modules</th>
                                            <th class="text-center" style="width: 110px;">Status</th>
                                            <th class="text-center no-print" style="width: 160px;">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php if (empty($chemicals)): ?>
                                            <tr>
                                                <td colspan="6" class="text-center py-5 text-muted">
                                                    <i class="bi bi-inbox fs-2 d-block mb-2 text-secondary"></i>
                                                    No chemicals configured for this station yet.
                                                    <div class="mt-2">
                                                        <button type="button" class="btn btn-sm btn-primary fw-semibold" data-bs-toggle="modal" data-bs-target="#addChemicalModal">
                                                            <i class="bi bi-plus-circle me-1"></i> Add First Chemical
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        <?php else: ?>
                                            <?php $i = 1; foreach ($chemicals as $chem): 
                                                $cId = $chem['id'];
                                                $uType = $chem['unit_type'] ?? 'volume';
                                                $uSym = $chem['unit_symbol'] ?? ($chem['units'] ?? ($uType === 'volume' ? 'ml' : ($uType === 'weight' ? 'g' : 'pcs')));
                                                $status = $chem['status'] ?? 'Active';

                                                // Extract mapped types
                                                $activeTypeIds = [];
                                                if (!empty($chem['mappings_info'])) {
                                                    $mapEntries = explode('||', $chem['mappings_info']);
                                                    foreach ($mapEntries as $mEntry) {
                                                        $mParts = explode('::', $mEntry);
                                                        if (count($mParts) >= 3 && $mParts[2] === 'Active') {
                                                            $activeTypeIds[] = intval($mParts[0]);
                                                        }
                                                    }
                                                }
                                            ?>
                                                <tr class="chem-row">
                                                    <td class="text-center fw-bold text-muted"><?= $i++ ?></td>
                                                    <td>
                                                        <div class="fw-bold text-dark fs-6"><?= htmlspecialchars($chem['name']) ?></div>
                                                        <small class="text-muted">ID: #<?= $cId ?></small>
                                                    </td>
                                                    <td class="text-center">
                                                        <span class="badge bg-light text-dark border text-capitalize px-2 py-1 mb-1 d-inline-block"><?= htmlspecialchars($uType) ?></span>
                                                        <div class="small fw-semibold text-secondary">Base: <?= htmlspecialchars($uSym) ?></div>
                                                    </td>
                                                    <td>
                                                        <?php if (empty($activeTypeIds)): ?>
                                                            <span class="text-muted small fst-italic">
                                                                <i class="bi bi-exclamation-circle text-warning me-1"></i> No modules mapped
                                                            </span>
                                                        <?php else: ?>
                                                            <div class="d-flex flex-wrap gap-1">
                                                                <?php 
                                                                foreach ($chemicalTypes as $ct) {
                                                                    if (in_array($ct['id'], $activeTypeIds)) {
                                                                        $badgeClass = 'bg-primary-subtle text-primary border border-primary-subtle';
                                                                        if (stripos($ct['type_name'], 'intensive') !== false) $badgeClass = 'bg-success-subtle text-success border border-success-subtle';
                                                                        elseif (stripos($ct['type_name'], 'vande') !== false) $badgeClass = 'bg-danger-subtle text-danger border border-danger-subtle';
                                                                        elseif (stripos($ct['type_name'], 'pantry') !== false) $badgeClass = 'bg-warning-subtle text-warning-emphasis border border-warning-subtle';
                                                                        elseif (stripos($ct['type_name'], 'prt') !== false) $badgeClass = 'bg-info-subtle text-info-emphasis border border-info-subtle';
                                                                        elseif (stripos($ct['type_name'], 'dc') !== false) $badgeClass = 'bg-secondary-subtle text-secondary-emphasis border border-secondary-subtle';
                                                                        
                                                                        echo '<span class="type-badge-pill ' . $badgeClass . '"><i class="bi bi-check2"></i> ' . htmlspecialchars($ct['type_name']) . '</span>';
                                                                    }
                                                                }
                                                                ?>
                                                            </div>
                                                        <?php endif; ?>
                                                    </td>
                                                    <td class="text-center">
                                                        <?php if ($status === 'Active'): ?>
                                                            <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1">Active</span>
                                                        <?php else: ?>
                                                            <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-2 py-1">Inactive</span>
                                                        <?php endif; ?>
                                                    </td>
                                                    <td class="text-center no-print">
                                                        <div class="btn-group btn-group-sm">
                                                            <button type="button" class="btn btn-outline-primary" 
                                                                    data-bs-toggle="modal" 
                                                                    data-bs-target="#editChemModal<?= $cId ?>"
                                                                    title="Edit Chemical & Mappings">
                                                                <i class="bi bi-pencil-square"></i> Edit
                                                            </button>
                                                            <button type="button" class="btn btn-outline-danger" 
                                                                    data-bs-toggle="modal" 
                                                                    data-bs-target="#deleteChemModal<?= $cId ?>"
                                                                    title="Delete Chemical">
                                                                <i class="bi bi-trash"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>

                                                <!-- EDIT CHEMICAL MODAL -->
                                                <div class="modal fade" id="editChemModal<?= $cId ?>" tabindex="-1" aria-labelledby="editChemModalLabel<?= $cId ?>" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered modal-lg">
                                                        <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.15);">
                                                            <form method="POST" action="manage-chemicals.php">
                                                                <input type="hidden" name="action" value="edit_chemical">
                                                                <input type="hidden" name="param_id" value="<?= $cId ?>">

                                                                <div class="modal-header" style="background: #07385f; color: #fff; border-top-left-radius: 12px; border-top-right-radius: 12px;">
                                                                    <h5 class="modal-title fw-bold" id="editChemModalLabel<?= $cId ?>" style="font-size: 16px;">
                                                                        <i class="bi bi-pencil-square me-2"></i> Edit Chemical: <?= htmlspecialchars($chem['name']) ?>
                                                                    </h5>
                                                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                </div>

                                                                <div class="modal-body p-4">
                                                                    <div class="row g-3 mb-3">
                                                                        <div class="col-md-7">
                                                                            <label class="form-label text-dark fw-bold small">Chemical Name <span class="text-danger">*</span></label>
                                                                            <input type="text" class="form-control" name="name" value="<?= htmlspecialchars($chem['name']) ?>" required>
                                                                        </div>
                                                                        <div class="col-md-5">
                                                                            <label class="form-label text-dark fw-bold small">Status</label>
                                                                            <select class="form-select fw-semibold" name="status">
                                                                                <option value="Active" <?= ($status === 'Active') ? 'selected' : '' ?>>Active (Visible in Reports)</option>
                                                                                <option value="Inactive" <?= ($status === 'Inactive') ? 'selected' : '' ?>>Inactive (Hidden)</option>
                                                                            </select>
                                                                        </div>
                                                                    </div>

                                                                    <div class="row g-3 mb-4">
                                                                        <div class="col-md-6">
                                                                            <label class="form-label text-dark fw-bold small">Measurement Type</label>
                                                                            <select class="form-select fw-semibold edit-unit-type" name="unit_type" data-target="#editBaseUnit<?= $cId ?>">
                                                                                <option value="volume" <?= ($uType === 'volume') ? 'selected' : '' ?>>Liquid / Volume (ml, Litres)</option>
                                                                                <option value="weight" <?= ($uType === 'weight') ? 'selected' : '' ?>>Powder / Weight (g, kg)</option>
                                                                                <option value="count" <?= ($uType === 'count') ? 'selected' : '' ?>>Count / Bottles / Pieces (pcs)</option>
                                                                            </select>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <label class="form-label text-dark fw-bold small">Base Standard Unit</label>
                                                                            <select class="form-select fw-semibold" name="base_unit_id" id="editBaseUnit<?= $cId ?>">
                                                                                <?php foreach ($allUnits as $u): ?>
                                                                                    <option value="<?= $u['id'] ?>" 
                                                                                            data-type="<?= $u['unit_type'] ?>"
                                                                                            <?= ($chem['base_unit_id'] == $u['id']) ? 'selected' : '' ?>>
                                                                                        <?= htmlspecialchars($u['unit_name']) ?> (<?= htmlspecialchars($u['unit_symbol']) ?>)
                                                                                    </option>
                                                                                <?php endforeach; ?>
                                                                            </select>
                                                                        </div>
                                                                    </div>

                                                                    <div class="border-top pt-3">
                                                                        <label class="form-label text-dark fw-bold small d-block mb-2">
                                                                            <i class="bi bi-diagram-3-fill text-primary me-1"></i> Map to Cleaning Modules
                                                                        </label>
                                                                        <p class="text-muted small mb-3">Select the cleaning modules where this chemical should appear for usage reporting and target calculations:</p>
                                                                        
                                                                        <div class="row g-2">
                                                                            <?php foreach ($chemicalTypes as $ct): 
                                                                                $isMapped = in_array($ct['id'], $activeTypeIds);
                                                                            ?>
                                                                                <div class="col-md-6">
                                                                                    <div class="module-item-checkbox d-flex align-items-center gap-2">
                                                                                        <input class="form-check-input mt-0" type="checkbox" name="mapped_types[]" value="<?= $ct['id'] ?>" id="editMap_<?= $cId ?>_<?= $ct['id'] ?>" <?= $isMapped ? 'checked' : '' ?>>
                                                                                        <label class="form-check-label fw-semibold text-dark small flex-grow-1 cursor-pointer" for="editMap_<?= $cId ?>_<?= $ct['id'] ?>">
                                                                                            <?= htmlspecialchars($ct['type_name']) ?>
                                                                                        </label>
                                                                                    </div>
                                                                                </div>
                                                                            <?php endforeach; ?>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="modal-footer bg-light" style="border-bottom-left-radius: 12px; border-bottom-right-radius: 12px;">
                                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                    <button type="submit" class="btn btn-primary fw-semibold px-4">
                                                                        <i class="bi bi-check2-circle me-1"></i> Update Chemical
                                                                    </button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- DELETE CHEMICAL CONFIRMATION MODAL -->
                                                <div class="modal fade" id="deleteChemModal<?= $cId ?>" tabindex="-1" aria-labelledby="deleteChemModalLabel<?= $cId ?>" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered">
                                                        <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.15);">
                                                            <form method="POST" action="manage-chemicals.php">
                                                                <input type="hidden" name="action" value="delete_chemical">
                                                                <input type="hidden" name="param_id" value="<?= $cId ?>">

                                                                <div class="modal-header bg-danger text-white" style="border-top-left-radius: 12px; border-top-right-radius: 12px;">
                                                                    <h5 class="modal-title fw-bold" id="deleteChemModalLabel<?= $cId ?>" style="font-size: 16px;">
                                                                        <i class="bi bi-exclamation-octagon-fill me-2"></i> Confirm Delete Chemical
                                                                    </h5>
                                                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                </div>

                                                                <div class="modal-body p-4 text-center">
                                                                    <div class="text-danger mb-3">
                                                                        <i class="bi bi-trash-fill display-4"></i>
                                                                    </div>
                                                                    <h5 class="fw-bold text-dark mb-2"><?= htmlspecialchars($chem['name']) ?></h5>
                                                                    <p class="text-muted small mb-0">
                                                                        Are you sure you want to delete this chemical from station catalog?
                                                                        This will remove all associated cleaning module mappings and inventory stock records for this chemical.
                                                                    </p>
                                                                </div>

                                                                <div class="modal-footer bg-light justify-content-center" style="border-bottom-left-radius: 12px; border-bottom-right-radius: 12px;">
                                                                    <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">No, Cancel</button>
                                                                    <button type="submit" class="btn btn-danger fw-semibold px-4">
                                                                        <i class="bi bi-trash-fill me-1"></i> Yes, Delete Chemical
                                                                    </button>
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

                    <!-- TAB 2: MODULE MAPPING MATRIX (BATCH MAPPING) -->
                    <div class="tab-pane fade" id="tab-matrix" role="tabpanel">
                        <div class="chem-mgmt-card">
                            <div class="d-flex flex-wrap justify-content-between align-items-center border-bottom pb-3 mb-3 gap-2">
                                <div>
                                    <h2 style="font-size: 17px; font-weight: 700; color: #1e293b; margin: 0;">
                                        <i class="bi bi-diagram-3-fill me-2 text-primary"></i> Module Mapping Matrix
                                    </h2>
                                    <span class="text-muted small">Select a cleaning module and easily check/uncheck the chemicals that apply to it.</span>
                                </div>
                                <div>
                                    <form method="GET" action="manage-chemicals.php" class="d-flex align-items-center gap-2">
                                        <input type="hidden" name="tab" value="matrix">
                                        <label class="fw-bold text-dark small text-nowrap">Select Module:</label>
                                        <select name="type_id" class="form-select form-select-sm fw-bold border-primary shadow-sm" onchange="this.form.submit()" style="min-width: 220px;">
                                            <?php foreach ($chemicalTypes as $ct): ?>
                                                <option value="<?= $ct['id'] ?>" <?= ($ct['id'] == $selectedTypeId) ? 'selected' : '' ?>>
                                                    <?= htmlspecialchars($ct['type_name']) ?>
                                                </option>
                                            <?php endforeach; ?>
                                        </select>
                                    </form>
                                </div>
                            </div>

                            <form method="POST" action="manage-chemicals.php">
                                <input type="hidden" name="action" value="save_type_mapping">
                                <input type="hidden" name="chemical_type_id" value="<?= $selectedTypeId ?>">

                                <div class="alert alert-info d-flex align-items-center justify-content-between py-2 px-3 mb-3" style="border-radius: 8px;">
                                    <div class="small">
                                        <i class="bi bi-info-circle-fill me-1"></i> Configuring mapped chemicals for <strong><?= htmlspecialchars($currentTypeName) ?></strong>.
                                    </div>
                                    <div class="d-flex gap-2">
                                        <button type="button" class="btn btn-sm btn-outline-primary bg-white py-0 px-2 fw-semibold" id="selectAllMatrix">Select All</button>
                                        <button type="button" class="btn btn-sm btn-outline-secondary bg-white py-0 px-2 fw-semibold" id="deselectAllMatrix">Deselect All</button>
                                    </div>
                                </div>

                                <div class="table-responsive mb-4">
                                    <table class="table table-bordered chem-custom-table mb-0 align-middle">
                                        <thead>
                                            <tr>
                                                <th style="width: 60px;" class="text-center">Select</th>
                                                <th>Chemical Name</th>
                                                <th class="text-center" style="width: 140px;">Unit Type</th>
                                                <th class="text-center" style="width: 140px;">Current Status in <?= htmlspecialchars($currentTypeName) ?></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php if (empty($chemicals)): ?>
                                                <tr>
                                                    <td colspan="4" class="text-center py-4 text-muted">
                                                        No master chemicals available to map. Please add chemicals first.
                                                    </td>
                                                </tr>
                                            <?php else: ?>
                                                <?php foreach ($chemicals as $chem): 
                                                    $pId = $chem['id'];
                                                    $isCurrentlyActive = (isset($typeMappings[$pId]) && $typeMappings[$pId] === 'Active');
                                                ?>
                                                    <tr>
                                                        <td class="text-center">
                                                            <input class="form-check-input matrix-checkbox" type="checkbox" name="selected_params[]" value="<?= $pId ?>" id="matrix_p_<?= $pId ?>" <?= $isCurrentlyActive ? 'checked' : '' ?>>
                                                        </td>
                                                        <td>
                                                            <label class="form-check-label fw-bold text-dark cursor-pointer d-block" for="matrix_p_<?= $pId ?>">
                                                                <?= htmlspecialchars($chem['name']) ?>
                                                            </label>
                                                        </td>
                                                        <td class="text-center">
                                                            <span class="badge bg-light text-dark border text-capitalize"><?= htmlspecialchars($chem['unit_type'] ?? 'volume') ?></span>
                                                        </td>
                                                        <td class="text-center">
                                                            <?php if ($isCurrentlyActive): ?>
                                                                <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1">Mapped (Active)</span>
                                                            <?php else: ?>
                                                                <span class="badge bg-secondary-subtle text-muted border px-2 py-1">Not Mapped</span>
                                                            <?php endif; ?>
                                                        </td>
                                                    </tr>
                                                <?php endforeach; ?>
                                            <?php endif; ?>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="d-flex justify-content-end gap-2">
                                    <a href="manage-chemicals.php" class="btn btn-secondary">Cancel</a>
                                    <button type="submit" class="btn btn-success fw-bold px-4">
                                        <i class="bi bi-save2-fill me-1"></i> Save Mapping Changes
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>

            </div>

        </div>
    </div>
</main>

<!-- ADD NEW CHEMICAL MODAL -->
<div class="modal fade" id="addChemicalModal" tabindex="-1" aria-labelledby="addChemicalModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.15);">
            <form method="POST" action="manage-chemicals.php">
                <input type="hidden" name="action" value="add_chemical">

                <div class="modal-header" style="background: #07385f; color: #fff; border-top-left-radius: 12px; border-top-right-radius: 12px;">
                    <h5 class="modal-title fw-bold" id="addChemicalModalLabel" style="font-size: 16px;">
                        <i class="bi bi-plus-circle-fill me-2"></i> Add New Master Chemical
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label text-dark fw-bold small">Chemical Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="name" placeholder="e.g. Taski R1, Harpic, Floor Cleaner" required>
                    </div>

                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label class="form-label text-dark fw-bold small">Measurement Type <span class="text-danger">*</span></label>
                            <select class="form-select fw-semibold" name="unit_type" id="addUnitTypeSelect" required>
                                <option value="volume">Liquid / Volume (ml, Litres)</option>
                                <option value="weight">Powder / Weight (g, kg)</option>
                                <option value="count">Count / Bottles / Pieces (pcs)</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label text-dark fw-bold small">Base Standard Unit <span class="text-danger">*</span></label>
                            <select class="form-select fw-semibold" name="base_unit_id" id="addBaseUnitSelect" required>
                                <?php foreach ($allUnits as $u): ?>
                                    <option value="<?= $u['id'] ?>" 
                                            data-type="<?= $u['unit_type'] ?>"
                                            <?= ($u['is_base_unit'] && $u['unit_type'] === 'volume') ? 'selected' : '' ?>>
                                        <?= htmlspecialchars($u['unit_name']) ?> (<?= htmlspecialchars($u['unit_symbol']) ?>)
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                    </div>

                    <div class="border-top pt-3">
                        <label class="form-label text-dark fw-bold small d-block mb-2">
                            <i class="bi bi-diagram-3-fill text-primary me-1"></i> Map to Cleaning Modules Immediately
                        </label>
                        <p class="text-muted small mb-3">Select the modules this chemical should be used for right away (you can change this anytime):</p>
                        
                        <div class="row g-2">
                            <?php foreach ($chemicalTypes as $ct): ?>
                                <div class="col-md-6">
                                    <div class="module-item-checkbox d-flex align-items-center gap-2">
                                        <input class="form-check-input mt-0" type="checkbox" name="mapped_types[]" value="<?= $ct['id'] ?>" id="addMap_<?= $ct['id'] ?>" checked>
                                        <label class="form-check-label fw-semibold text-dark small flex-grow-1 cursor-pointer" for="addMap_<?= $ct['id'] ?>">
                                            <?= htmlspecialchars($ct['type_name']) ?>
                                        </label>
                                    </div>
                                </div>
                            <?php endforeach; ?>
                        </div>
                    </div>
                </div>

                <div class="modal-footer bg-light" style="border-bottom-left-radius: 12px; border-bottom-right-radius: 12px;">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success fw-semibold px-4">
                        <i class="bi bi-plus-circle me-1"></i> Save Master Chemical
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Dynamic base unit filtering based on unit_type selection
    function setupUnitTypeFilter(typeSelectId, baseUnitSelectId) {
        const typeSelect = document.getElementById(typeSelectId);
        const unitSelect = document.getElementById(baseUnitSelectId);
        if (!typeSelect || !unitSelect) return;

        function filterUnits() {
            const chosenType = typeSelect.value;
            let firstMatched = null;

            Array.from(unitSelect.options).forEach(opt => {
                const optType = opt.getAttribute('data-type');
                if (optType === chosenType) {
                    opt.style.display = '';
                    if (!firstMatched) firstMatched = opt;
                } else {
                    opt.style.display = 'none';
                }
            });

            if (unitSelect.selectedOptions.length === 0 || unitSelect.selectedOptions[0].style.display === 'none') {
                if (firstMatched) firstMatched.selected = true;
            }
        }

        typeSelect.addEventListener('change', filterUnits);
        filterUnits();
    }

    setupUnitTypeFilter('addUnitTypeSelect', 'addBaseUnitSelect');

    // Setup edit modal unit type changes
    document.querySelectorAll('.edit-unit-type').forEach(select => {
        const targetId = select.getAttribute('data-target').replace('#', '');
        setupUnitTypeFilter(select.id || select, targetId);
    });

    // Real-time table search
    const searchInput = document.getElementById('chemSearchInput');
    if (searchInput) {
        searchInput.addEventListener('input', function() {
            const val = this.value.toLowerCase().trim();
            const rows = document.querySelectorAll('#chemTable tbody tr.chem-row');
            rows.forEach(r => {
                const text = r.textContent.toLowerCase();
                r.style.display = text.includes(val) ? '' : 'none';
            });
        });
    }

    // Select/Deselect All Matrix Checkboxes
    const selectAllBtn = document.getElementById('selectAllMatrix');
    const deselectAllBtn = document.getElementById('deselectAllMatrix');
    if (selectAllBtn && deselectAllBtn) {
        selectAllBtn.addEventListener('click', function() {
            document.querySelectorAll('.matrix-checkbox').forEach(cb => cb.checked = true);
        });
        deselectAllBtn.addEventListener('click', function() {
            document.querySelectorAll('.matrix-checkbox').forEach(cb => cb.checked = false);
        });
    }

    // If URL contains tab=matrix, switch to matrix tab
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('tab') === 'matrix') {
        const matrixTabBtn = document.getElementById('tab-matrix-btn');
        if (matrixTabBtn) {
            bootstrap.Tab.getOrCreateInstance(matrixTabBtn).show();
        }
    }
});
</script>

<?php include 'footer.php'; ?>
