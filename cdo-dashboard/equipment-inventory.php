<?php
require_once 'auth.php';

$successMsg = '';
$errorMsg = '';

// Handle Add / Edit / Delete Equipment
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';
    
    if ($action === 'add') {
        $equipmentName = trim($_POST['equipment_name'] ?? '');
        $requiredQty = max(1, intval($_POST['required_qty'] ?? 1));
        $unit = trim($_POST['unit'] ?? 'Nos');

        if (!empty($equipmentName)) {
            try {
                $stmt = $pdo->prepare("
                    INSERT INTO mcc_equipment_master (station_id, equipment_name, category, required_qty, unit, status)
                    VALUES (:station_id, :equipment_name, 'General', :required_qty, :unit, 'Active')
                ");
                $stmt->execute([
                    'station_id' => $stationId,
                    'equipment_name' => $equipmentName,
                    'required_qty' => $requiredQty,
                    'unit' => $unit
                ]);
                header("Location: equipment-inventory.php?success=added");
                exit();
            } catch (Exception $e) {
                $errorMsg = "Error adding equipment: " . $e->getMessage();
            }
        } else {
            $errorMsg = "Equipment name is required.";
        }
    } elseif ($action === 'edit') {
        $id = intval($_POST['equipment_id'] ?? 0);
        $equipmentName = trim($_POST['equipment_name'] ?? '');
        $requiredQty = max(1, intval($_POST['required_qty'] ?? 1));
        $unit = trim($_POST['unit'] ?? 'Nos');
        $status = in_array($_POST['status'] ?? '', ['Active', 'Inactive']) ? $_POST['status'] : 'Active';

        if ($id > 0 && !empty($equipmentName)) {
            try {
                $stmt = $pdo->prepare("
                    UPDATE mcc_equipment_master 
                    SET equipment_name = :equipment_name, required_qty = :required_qty, unit = :unit, status = :status
                    WHERE id = :id AND station_id = :station_id
                ");
                $stmt->execute([
                    'equipment_name' => $equipmentName,
                    'required_qty' => $requiredQty,
                    'unit' => $unit,
                    'status' => $status,
                    'id' => $id,
                    'station_id' => $stationId
                ]);
                header("Location: equipment-inventory.php?success=updated");
                exit();
            } catch (Exception $e) {
                $errorMsg = "Error updating equipment: " . $e->getMessage();
            }
        }
    } elseif ($action === 'delete') {
        $id = intval($_POST['equipment_id'] ?? 0);
        if ($id > 0) {
            try {
                $stmt = $pdo->prepare("DELETE FROM mcc_equipment_master WHERE id = :id AND station_id = :station_id");
                $stmt->execute(['id' => $id, 'station_id' => $stationId]);
                header("Location: equipment-inventory.php?success=deleted");
                exit();
            } catch (Exception $e) {
                $errorMsg = "Error deleting equipment: " . $e->getMessage();
            }
        }
    }
}

if (isset($_GET['success'])) {
    if ($_GET['success'] === 'added') $successMsg = "Equipment & stock quantity added successfully!";
    if ($_GET['success'] === 'updated') $successMsg = "Equipment details updated successfully!";
    if ($_GET['success'] === 'deleted') $successMsg = "Equipment removed from inventory successfully!";
}

// Fetch all equipments for this station
$stmt = $pdo->prepare("
    SELECT * FROM mcc_equipment_master 
    WHERE station_id = :station_id 
    ORDER BY equipment_name ASC
");
$stmt->execute(['station_id' => $stationId]);
$equipments = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Calculate KPI summary
$totalEquipments = count($equipments);
$activeEquipments = 0;
$totalInventoryUnits = 0;

foreach ($equipments as $eq) {
    if ($eq['status'] === 'Active') {
        $activeEquipments++;
        $totalInventoryUnits += intval($eq['required_qty']);
    }
}

$pageTitle = "Equipment Inventory & Master Setup | MCC";

include 'header.php';
include 'sidebar.php';
?>

<style>
.inventory-sheet {
    background: #ffffff !important;
    border: 1px solid #cbd5e1 !important;
    padding: 24px !important;
    width: 100% !important;
    margin-bottom: 30px !important;
    box-shadow: 0 4px 14px rgba(0, 0, 0, 0.05) !important;
    border-radius: 10px !important;
}
.inventory-custom-table th {
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
.inventory-custom-table td {
    font-size: 13.5px !important;
    vertical-align: middle !important;
    padding: 11px 14px !important;
    color: #334155 !important;
    border: 1px solid #e2e8f0 !important;
}
.inventory-custom-table tbody tr:hover {
    background-color: #f8fafc !important;
}
.summary-kpi-box {
    background: #ffffff;
    border: 1px solid #e2e8f0;
    border-radius: 10px;
    padding: 16px 20px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    box-shadow: 0 2px 6px rgba(0,0,0,0.03);
}
</style>

<main class="app-main">
    <div class="app-content">
        <div class="container-fluid">
            
            <!-- Alert Notifications -->
            <?php if (!empty($successMsg)): ?>
                <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i> <?= htmlspecialchars($successMsg); ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <?php endif; ?>

            <?php if (!empty($errorMsg)): ?>
                <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> <?= htmlspecialchars($errorMsg); ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <?php endif; ?>

            <!-- Top Action Header -->
            <div class="d-flex flex-wrap justify-content-between align-items-center mt-3 mb-4">
                <div>
                    <h3 class="fw-bold text-dark m-0">Equipment & Machinery Inventory</h3>
                    <p class="text-muted small mb-0">Master catalog of station equipments and available stock quantities</p>
                </div>
                <div class="d-flex gap-2">
                    <a href="equipment-daily-report.php" class="btn btn-primary" style="background: #07385f; border-color: #07385f;">
                        <i class="bi bi-calendar-check me-1"></i> Equipments Report
                    </a>
                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addEquipmentModal" style="background: #10b981; border-color: #10b981;">
                        <i class="bi bi-plus-circle me-1"></i> Add Equipment & Quantity
                    </button>
                </div>
            </div>

            <!-- KPI Summary Cards -->
            <div class="row g-3 mb-4">
                <div class="col-md-4">
                    <div class="summary-kpi-box">
                        <div>
                            <div class="text-muted small fw-bold text-uppercase">Total Equipment Items</div>
                            <div class="fs-4 fw-bold text-dark"><?= $totalEquipments ?></div>
                        </div>
                        <div class="bg-light text-primary p-3 rounded-circle fs-4">
                            <i class="bi bi-tools"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="summary-kpi-box">
                        <div>
                            <div class="text-muted small fw-bold text-uppercase">Active Equipments</div>
                            <div class="fs-4 fw-bold text-success"><?= $activeEquipments ?></div>
                        </div>
                        <div class="bg-light text-success p-3 rounded-circle fs-4">
                            <i class="bi bi-check-circle"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="summary-kpi-box">
                        <div>
                            <div class="text-muted small fw-bold text-uppercase">Total Stock / Available Quantity</div>
                            <div class="fs-4 fw-bold text-info"><?= $totalInventoryUnits ?> <small class="fs-6 text-muted">Units</small></div>
                        </div>
                        <div class="bg-light text-info p-3 rounded-circle fs-4">
                            <i class="bi bi-box-seam"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Equipments Table -->
            <div class="inventory-sheet">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold text-dark m-0">
                        <i class="bi bi-list-check me-2 text-primary"></i> Station Equipment Inventory Catalog
                    </h5>
                    <div class="d-flex align-items-center gap-2">
                        <input type="text" id="tableSearch" class="form-control form-control-sm" placeholder="Search equipment..." style="max-width: 220px;">
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-bordered inventory-custom-table align-middle mb-0" id="equipmentsTable">
                        <thead>
                            <tr>
                                <th style="width: 50px;" class="text-center">#</th>
                                <th>Equipment / Tool Name</th>
                                <th style="width: 180px;" class="text-end">Total Stock / Quantity</th>
                                <th style="width: 120px;" class="text-center">Unit</th>
                                <th style="width: 130px;" class="text-center">Status</th>
                                <th style="width: 130px;" class="text-center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php if (empty($equipments)): ?>
                                <tr>
                                    <td colspan="6" class="text-center py-4 text-muted">
                                        <i class="bi bi-inbox fs-3 d-block mb-2"></i> No equipments configured in inventory yet. Click "Add Equipment & Quantity" to start.
                                    </td>
                                </tr>
                            <?php else: ?>
                                <?php $i = 1; foreach ($equipments as $eq): ?>
                                    <tr>
                                        <td class="text-center fw-bold text-muted"><?= $i++ ?></td>
                                        <td class="fw-semibold text-dark">
                                            <?= htmlspecialchars($eq['equipment_name']) ?>
                                        </td>
                                        <td class="text-end fw-bold text-primary fs-6">
                                            <?= intval($eq['required_qty']) ?>
                                        </td>
                                        <td class="text-center text-muted">
                                            <?= htmlspecialchars($eq['unit']) ?>
                                        </td>
                                        <td class="text-center">
                                            <?php if ($eq['status'] === 'Active'): ?>
                                                <span class="badge bg-success">Active</span>
                                            <?php else: ?>
                                                <span class="badge bg-secondary">Inactive</span>
                                            <?php endif; ?>
                                        </td>
                                        <td class="text-center" style="white-space: nowrap;">
                                            <div class="d-inline-flex justify-content-center align-items-center gap-1 flex-nowrap">
                                                <button type="button" class="btn btn-sm btn-outline-primary" 
                                                        onclick="openEditModal(<?= htmlspecialchars(json_encode($eq)) ?>)" title="Edit">
                                                    <i class="bi bi-pencil"></i>
                                                </button>
                                                <form method="POST" action="equipment-inventory.php" class="d-inline m-0 p-0" onsubmit="return confirm('Are you sure you want to remove this equipment from inventory?');">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="equipment_id" value="<?= $eq['id'] ?>">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger" title="Delete">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </form>
                                            </div>
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
</main>

<!-- Add Equipment Modal -->
<div class="modal fade" id="addEquipmentModal" tabindex="-1" aria-labelledby="addEquipmentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="POST" action="equipment-inventory.php">
                <input type="hidden" name="action" value="add">
                <div class="modal-header" style="background: #07385f; color: #fff;">
                    <h5 class="modal-title" id="addEquipmentModalLabel"><i class="bi bi-plus-circle me-2"></i> Add Equipment & Stock Quantity</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="equipment_name" class="form-label fw-bold">Equipment Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="equipment_name" name="equipment_name" required placeholder="e.g., High Pressure Jet Cleaner">
                    </div>
                    <div class="row g-2 mb-3">
                        <div class="col-md-6">
                            <label for="required_qty" class="form-label fw-bold">Total / Stock Quantity <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="required_qty" name="required_qty" min="1" value="1" required placeholder="Available Quantity">
                        </div>
                        <div class="col-md-6">
                            <label for="unit" class="form-label fw-bold">Unit</label>
                            <select class="form-select" id="unit" name="unit">
                                <option value="Nos">Nos</option>
                                <option value="Sets">Sets</option>
                                <option value="Units">Units</option>
                                <option value="Pieces">Pieces</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success" style="background: #10b981; border-color: #10b981;"><i class="bi bi-check-lg me-1"></i> Save Equipment</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Equipment Modal -->
<div class="modal fade" id="editEquipmentModal" tabindex="-1" aria-labelledby="editEquipmentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="POST" action="equipment-inventory.php">
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="equipment_id" id="edit_equipment_id">
                <div class="modal-header" style="background: #07385f; color: #fff;">
                    <h5 class="modal-title" id="editEquipmentModalLabel"><i class="bi bi-pencil-square me-2"></i> Edit Equipment</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="edit_equipment_name" class="form-label fw-bold">Equipment Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="edit_equipment_name" name="equipment_name" required>
                    </div>
                    <div class="row g-2 mb-3">
                        <div class="col-md-6">
                            <label for="edit_required_qty" class="form-label fw-bold">Total / Stock Quantity <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="edit_required_qty" name="required_qty" min="1" required>
                        </div>
                        <div class="col-md-6">
                            <label for="edit_unit" class="form-label fw-bold">Unit</label>
                            <select class="form-select" id="edit_unit" name="unit">
                                <option value="Nos">Nos</option>
                                <option value="Sets">Sets</option>
                                <option value="Units">Units</option>
                                <option value="Pieces">Pieces</option>
                            </select>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="edit_status" class="form-label fw-bold">Status</label>
                        <select class="form-select" id="edit_status" name="status">
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary"><i class="bi bi-save me-1"></i> Update Equipment</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function openEditModal(data) {
    document.getElementById('edit_equipment_id').value = data.id;
    document.getElementById('edit_equipment_name').value = data.equipment_name;
    document.getElementById('edit_required_qty').value = data.required_qty;
    document.getElementById('edit_unit').value = data.unit || 'Nos';
    document.getElementById('edit_status').value = data.status || 'Active';
    
    var modal = new bootstrap.Modal(document.getElementById('editEquipmentModal'));
    modal.show();
}

// Live table search
document.getElementById('tableSearch').addEventListener('keyup', function() {
    var val = this.value.toLowerCase();
    var rows = document.querySelectorAll('#equipmentsTable tbody tr');
    rows.forEach(function(row) {
        var text = row.textContent.toLowerCase();
        row.style.display = text.indexOf(val) > -1 ? '' : 'none';
    });
});
</script>

<?php include 'footer.php'; ?>
