<?php
require_once 'auth.php';

$selectedDate = $_GET['report_date'] ?? date('Y-m-d');
$successMsg = '';
$errorMsg = '';

// Handle Add / Update Single Equipment Provided Entry
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'save_provided') {
    $postDate = $_POST['log_date'] ?? $selectedDate;
    $equipmentId = intval($_POST['equipment_id'] ?? 0);
    $providedQty = max(1, intval($_POST['provided_qty'] ?? 1));
    $workingQty = isset($_POST['working_qty']) && $_POST['working_qty'] !== '' ? max(0, intval($_POST['working_qty'])) : $providedQty;
    $breakdownQty = max(0, intval($_POST['breakdown_qty'] ?? 0));
    $remarks = trim($_POST['remarks'] ?? '');
    $userName = $_SESSION['username'] ?? ($_SESSION['user_name'] ?? 'CDO');

    if ($equipmentId > 0 && !empty($postDate)) {
        try {
            // Get master equipment details
            $mStmt = $pdo->prepare("SELECT required_qty, equipment_name FROM mcc_equipment_master WHERE id = ? AND station_id = ?");
            $mStmt->execute([$equipmentId, $stationId]);
            $masterItem = $mStmt->fetch(PDO::FETCH_ASSOC);
            $reqQty = $masterItem ? intval($masterItem['required_qty']) : 1;
            $eqName = $masterItem ? $masterItem['equipment_name'] : 'Equipment';

            $upsertStmt = $pdo->prepare("
                INSERT INTO mcc_equipment_daily_log 
                (station_id, equipment_id, log_date, required_qty, given_qty, working_qty, breakdown_qty, remarks, submitted_by)
                VALUES (:station_id, :equipment_id, :log_date, :required_qty, :given_qty, :working_qty, :breakdown_qty, :remarks, :submitted_by)
                ON DUPLICATE KEY UPDATE 
                    required_qty = VALUES(required_qty),
                    given_qty = VALUES(given_qty),
                    working_qty = VALUES(working_qty),
                    breakdown_qty = VALUES(breakdown_qty),
                    remarks = VALUES(remarks),
                    submitted_by = VALUES(submitted_by),
                    updated_at = CURRENT_TIMESTAMP
            ");

            $upsertStmt->execute([
                'station_id' => $stationId,
                'equipment_id' => $equipmentId,
                'log_date' => $postDate,
                'required_qty' => $reqQty,
                'given_qty' => $providedQty,
                'working_qty' => $workingQty,
                'breakdown_qty' => $breakdownQty,
                'remarks' => $remarks,
                'submitted_by' => $userName
            ]);

            header("Location: equipment-daily-report.php?report_date=" . urlencode($postDate) . "&success=saved&item=" . urlencode($eqName));
            exit();

        } catch (Exception $e) {
            $errorMsg = "Error saving provided equipment: " . $e->getMessage();
        }
    } else {
        $errorMsg = "Please select an equipment and a valid date.";
    }
}

// Handle Delete Log Entry for a date
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'delete_log_entry') {
    $postDate = $_POST['log_date'] ?? $selectedDate;
    $equipmentId = intval($_POST['equipment_id'] ?? 0);

    if ($equipmentId > 0 && !empty($postDate)) {
        try {
            $delStmt = $pdo->prepare("DELETE FROM mcc_equipment_daily_log WHERE station_id = ? AND equipment_id = ? AND log_date = ?");
            $delStmt->execute([$stationId, $equipmentId, $postDate]);
            header("Location: equipment-daily-report.php?report_date=" . urlencode($postDate) . "&success=deleted");
            exit();
        } catch (Exception $e) {
            $errorMsg = "Error removing provided equipment: " . $e->getMessage();
        }
    }
}

// Notification messages
if (isset($_GET['success'])) {
    if ($_GET['success'] === 'saved') {
        $itemName = isset($_GET['item']) ? htmlspecialchars($_GET['item']) : 'Equipment';
        $successMsg = "Daily provided record for <strong>{$itemName}</strong> on " . date('d-m-Y', strtotime($selectedDate)) . " saved successfully!";
    } elseif ($_GET['success'] === 'deleted') {
        $successMsg = "Equipment removed from daily provided sheet.";
    }
}

// Fetch all active equipments for the selection dropdown
$equipMasterStmt = $pdo->prepare("
    SELECT id, equipment_name, required_qty, unit 
    FROM mcc_equipment_master 
    WHERE station_id = :station_id AND status = 'Active' 
    ORDER BY equipment_name ASC
");
$equipMasterStmt->execute(['station_id' => $stationId]);
$allMasterEquipments = $equipMasterStmt->fetchAll(PDO::FETCH_ASSOC);

// Fetch ONLY the equipments provided for the $selectedDate
$query = "
    SELECT 
        l.id AS log_id,
        l.equipment_id,
        m.equipment_name,
        m.unit,
        m.required_qty AS master_stock_qty,
        l.given_qty,
        l.working_qty,
        l.breakdown_qty,
        l.remarks,
        l.submitted_by,
        l.updated_at AS log_updated_at
    FROM mcc_equipment_daily_log l
    INNER JOIN mcc_equipment_master m ON l.equipment_id = m.id
    WHERE l.station_id = :station_id AND l.log_date = :selected_date
    ORDER BY l.id ASC
";

$stmt = $pdo->prepare($query);
$stmt->execute([
    'station_id' => $stationId,
    'selected_date' => $selectedDate
]);
$providedEquipments = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Calculate Totals for KPI Summary
$totalProvidedCount = count($providedEquipments);
$totalGivenQty = 0;
$totalWorkingQty = 0;
$totalBreakdownQty = 0;

foreach ($providedEquipments as $row) {
    $totalGivenQty += intval($row['given_qty']);
    $totalWorkingQty += intval($row['working_qty']);
    $totalBreakdownQty += intval($row['breakdown_qty']);
}

$pageTitle = "Daily Equipment Provided Report | MCC";

include 'header.php';
include 'sidebar.php';
?>

<style>
.daily-report-sheet {
    background: #ffffff !important;
    border: 1px solid #cbd5e1 !important;
    padding: 24px !important;
    width: 100% !important;
    margin-bottom: 30px !important;
    box-shadow: 0 4px 14px rgba(0, 0, 0, 0.05) !important;
    border-radius: 10px !important;
}
.report-custom-table th {
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
.report-custom-table td {
    font-size: 13.5px !important;
    vertical-align: middle !important;
    padding: 11px 14px !important;
    color: #334155 !important;
    border: 1px solid #e2e8f0 !important;
}
.report-custom-table tbody tr:hover {
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
.quick-entry-card {
    background: #ffffff;
    border: 1.5px solid #07385f;
    border-radius: 12px;
    padding: 20px 24px;
    margin-bottom: 24px;
    box-shadow: 0 4px 14px rgba(7, 56, 95, 0.07);
}

@media print {
    .app-header, 
    .app-sidebar, 
    .app-footer, 
    .no-print, 
    .report-filter,
    form.report-filter,
    div.no-print,
    .quick-entry-card,
    .sidebar-overlay,
    .sidebar-backdrop,
    #sidebar-overlay {
        display: none !important;
        opacity: 0 !important;
        visibility: hidden !important;
        height: 0 !important;
        padding: 0 !important;
        margin: 0 !important;
    }
    .daily-report-sheet {
        box-shadow: none !important;
        border: 1px solid #000 !important;
        padding: 10px !important;
    }
    .report-custom-table th {
        background: #f1f5f9 !important;
        color: #000000 !important;
        border: 1px solid #000 !important;
    }
    .report-custom-table td {
        border: 1px solid #000 !important;
    }
}
</style>

<main class="app-main">
    <div class="app-content">
        <div class="container-fluid">
            
            <!-- Top Filter Bar -->
            <form class="report-filter no-print" method="GET" action="equipment-daily-report.php">
                <label for="report_date" class="fw-bold"><i class="bi bi-calendar-event me-1"></i> Select Date:</label>
                <input type="date" id="report_date" name="report_date" value="<?= htmlspecialchars($selectedDate); ?>" class="form-control d-inline-block" style="width: auto;">
                
                <button type="submit" class="btn btn-primary" style="background: #07385f; border-color: #07385f;">
                    <i class="bi bi-search me-1"></i> View Date
                </button>
                <a href="equipment-inventory.php" class="btn btn-secondary" style="background: #10b981; border-color: #10b981;">
                    <i class="bi bi-tools me-1"></i> Equipment Inventory
                </a>
                <button type="button" class="btn btn-outline-dark ms-auto" onclick="window.print()">
                    <i class="bi bi-printer me-1"></i> Print
                </button>
            </form>

            <?php if (!empty($successMsg)): ?>
                <div class="alert alert-success alert-dismissible fade show mt-3 no-print" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i> <?= $successMsg; ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <?php endif; ?>

            <?php if (!empty($errorMsg)): ?>
                <div class="alert alert-danger alert-dismissible fade show mt-3 no-print" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> <?= htmlspecialchars($errorMsg); ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <?php endif; ?>

            <div class="report-wrap mt-3">
                
                <!-- Entry Form: Select Date, Select Equipment, Enter Provided Quantity -->
                <div class="quick-entry-card no-print">
                    <div class="d-flex align-items-center justify-content-between mb-3 border-bottom pb-2">
                        <h5 class="fw-bold text-dark m-0" style="color: #07385f !important;">
                            <i class="bi bi-plus-circle-fill me-2 text-primary"></i> Provide Equipment for Date
                        </h5>
                        <span class="badge bg-primary px-3 py-1 fw-bold" style="background: #07385f !important;">
                            Selected Date: <?= date('d-M-Y', strtotime($selectedDate)) ?>
                        </span>
                    </div>

                    <form method="POST" action="equipment-daily-report.php" id="provideEquipmentForm">
                        <input type="hidden" name="action" value="save_provided">
                        
                        <div class="row g-3 align-items-end">
                            <!-- Date Selector -->
                            <div class="col-md-3">
                                <label for="form_log_date" class="form-label fw-bold text-dark small mb-1">
                                    <i class="bi bi-calendar3 me-1 text-primary"></i> Date <span class="text-danger">*</span>
                                </label>
                                <input type="date" class="form-control fw-semibold" id="form_log_date" name="log_date" value="<?= htmlspecialchars($selectedDate) ?>" required>
                            </div>

                            <!-- Equipment Selector -->
                            <div class="col-md-4">
                                <label for="form_equipment_id" class="form-label fw-bold text-dark small mb-1">
                                    <i class="bi bi-tools me-1 text-primary"></i> Select Equipment <span class="text-danger">*</span>
                                </label>
                                <select class="form-select fw-semibold" id="form_equipment_id" name="equipment_id" required onchange="onEquipmentChange(this)">
                                    <option value="">-- Select Equipment --</option>
                                    <?php foreach ($allMasterEquipments as $meq): ?>
                                        <option value="<?= $meq['id'] ?>" 
                                                data-unit="<?= htmlspecialchars($meq['unit']) ?>"
                                                data-qty="<?= $meq['required_qty'] ?>">
                                            <?= htmlspecialchars($meq['equipment_name']) ?> (Stock: <?= intval($meq['required_qty']) ?> <?= htmlspecialchars($meq['unit']) ?>)
                                        </option>
                                    <?php endforeach; ?>
                                </select>
                            </div>

                            <!-- Provided Quantity -->
                            <div class="col-md-3">
                                <label for="form_provided_qty" class="form-label fw-bold text-dark small mb-1">
                                    <i class="bi bi-box-arrow-in-right me-1 text-success"></i> Provided Quantity <span class="text-danger">*</span>
                                </label>
                                <div class="input-group">
                                    <input type="number" class="form-control text-center fw-bold text-success" 
                                           id="form_provided_qty" name="provided_qty" min="1" value="1" required 
                                           style="border: 1.5px solid #10b981; font-size: 16px;"
                                           oninput="syncWorkingQuantity(this.value)">
                                    <span class="input-group-text bg-light text-muted fw-bold" id="form_unit_badge">Nos</span>
                                </div>
                            </div>

                            <!-- Submit Button -->
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-success w-100 py-2 fw-bold" style="background: #10b981; border-color: #10b981;">
                                    <i class="bi bi-check-circle me-1"></i> Save Provided
                                </button>
                            </div>

                            <!-- Working Qty, Breakdown Qty & Remarks (Row 2) -->
                            <div class="col-md-3">
                                <label for="form_working_qty" class="form-label text-muted small mb-1">
                                    <i class="bi bi-check2-circle text-info me-1"></i> Working Qty
                                </label>
                                <input type="number" class="form-control form-control-sm text-center" 
                                       id="form_working_qty" name="working_qty" min="0" value="1">
                            </div>

                            <div class="col-md-3">
                                <label for="form_breakdown_qty" class="form-label text-muted small mb-1">
                                    <i class="bi bi-exclamation-triangle text-danger me-1"></i> Breakdown / Defective Qty
                                </label>
                                <input type="number" class="form-control form-control-sm text-center text-danger" 
                                       id="form_breakdown_qty" name="breakdown_qty" min="0" value="0">
                            </div>

                            <div class="col-md-6">
                                <label for="form_remarks" class="form-label text-muted small mb-1">
                                    <i class="bi bi-card-text me-1"></i> Remarks / Deployed Location
                                </label>
                                <input type="text" class="form-control form-control-sm" 
                                       id="form_remarks" name="remarks" placeholder="e.g. Deployed at Platform 1 / Coach S1-S6 (Optional)">
                            </div>
                        </div>
                    </form>
                </div>

                <!-- KPI Stat Cards for Selected Date -->
                <div class="row g-3 mb-4 no-print">
                    <div class="col-md-4">
                        <div class="summary-kpi-box">
                            <div>
                                <div class="text-muted small fw-bold text-uppercase">Equipments Provided on Date</div>
                                <div class="fs-4 fw-bold text-dark"><?= $totalProvidedCount ?> <small class="fs-6 text-muted">Items</small></div>
                            </div>
                            <div class="bg-light text-primary p-3 rounded-circle fs-4">
                                <i class="bi bi-list-check"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="summary-kpi-box">
                            <div>
                                <div class="text-muted small fw-bold text-uppercase">Total Provided Quantity</div>
                                <div class="fs-4 fw-bold text-success">
                                    <?= $totalGivenQty ?> <small class="fs-6 text-muted">Units</small>
                                </div>
                            </div>
                            <div class="bg-light text-success p-3 rounded-circle fs-4">
                                <i class="bi bi-truck"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="summary-kpi-box">
                            <div>
                                <div class="text-muted small fw-bold text-uppercase">Working / Breakdown</div>
                                <div class="fs-4 fw-bold text-info">
                                    <?= $totalWorkingQty ?> <small class="fs-6 text-success">Working</small> 
                                    <?php if ($totalBreakdownQty > 0): ?>
                                        / <span class="text-danger"><?= $totalBreakdownQty ?> <small class="fs-6 text-danger">Defective</small></span>
                                    <?php endif; ?>
                                </div>
                            </div>
                            <div class="bg-light text-info p-3 rounded-circle fs-4">
                                <i class="bi bi-gear-wide-connected"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main Daily Provided Equipment Sheet for Selected Date -->
                <div class="daily-report-sheet">
                    
                    <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #e2e8f0; padding-bottom: 12px; margin-bottom: 16px;">
                        <div>
                            <h2 style="font-size: 18px; font-weight: 700; color: #1e293b; margin: 0;">
                                <i class="bi bi-clipboard2-check me-2 text-primary"></i> Daily Equipment Provided Sheet
                            </h2>
                            <p class="text-muted small mb-0">List of equipments provided for operations on selected date</p>
                        </div>
                        <span class="badge bg-primary px-3 py-2 text-white" style="font-size: 0.9rem; font-weight: 600; border-radius: 6px;">
                            <i class="bi bi-calendar3 me-1"></i> Date: <?= date('d-m-Y', strtotime($selectedDate)) ?>
                        </span>
                    </div>

                    <div style="font-size: 13px; color: #334155; margin-bottom: 16px; border-bottom: 1px solid #e2e8f0; padding-bottom: 10px; line-height: 1.6;">
                        <div style="display: flex; flex-wrap: wrap; justify-content: space-between; gap: 8px 16px;">
                            <div>
                                <strong>Railway:</strong> <?= htmlspecialchars($railwayName) ?> &nbsp;|&nbsp;
                                <strong>Division:</strong> <?= htmlspecialchars($divisionName) ?> &nbsp;|&nbsp;
                                <strong>Station:</strong> <?= htmlspecialchars($stationName) ?>
                            </div>
                            <div>
                                <strong>Contractor:</strong> <?= htmlspecialchars($contractorName) ?>
                            </div>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="table table-bordered report-custom-table mb-0 align-middle">
                            <thead>
                                <tr>
                                    <th style="width: 50px;" class="text-center">#</th>
                                    <th>Equipment / Machinery Name</th>
                                    <th class="text-center" style="width: 170px; background: #064e3b !important; border-color: #065f46 !important;">
                                        Provided Quantity
                                    </th>
                                    <th class="text-center" style="width: 130px;">Working Qty</th>
                                    <th class="text-center" style="width: 130px;">Breakdown Qty</th>
                                    <th>Remarks / Deployed Location</th>
                                    <th class="text-center" style="width: 130px;">Recorded By</th>
                                    <th class="text-center no-print" style="width: 110px;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if (empty($providedEquipments)): ?>
                                    <tr>
                                        <td colspan="8" class="text-center py-5 text-muted">
                                            <i class="bi bi-inbox fs-2 d-block mb-2 text-secondary"></i>
                                            <h6 class="fw-bold text-dark mb-1">No equipment provided for this date yet.</h6>
                                            <p class="small text-muted mb-0">Use the <strong>"Provide Equipment for Date"</strong> form above to add provided equipments for <?= date('d-m-Y', strtotime($selectedDate)) ?>.</p>
                                        </td>
                                    </tr>
                                <?php else: ?>
                                    <?php $i = 1; foreach ($providedEquipments as $row): ?>
                                        <tr>
                                            <td class="text-center fw-bold text-muted"><?= $i++ ?></td>
                                            <td class="fw-bold text-dark fs-6">
                                                <?= htmlspecialchars($row['equipment_name']) ?>
                                            </td>
                                            <td class="text-center fw-bold text-success fs-5" style="background-color: #f0fdf4;">
                                                <?= intval($row['given_qty']) ?> 
                                                <small class="fs-6 text-muted fw-normal"><?= htmlspecialchars($row['unit']) ?></small>
                                            </td>
                                            <td class="text-center fw-semibold text-info">
                                                <?= intval($row['working_qty']) ?>
                                            </td>
                                            <td class="text-center fw-semibold <?= intval($row['breakdown_qty']) > 0 ? 'text-danger' : 'text-muted' ?>">
                                                <?= intval($row['breakdown_qty']) ?>
                                            </td>
                                            <td>
                                                <?= !empty($row['remarks']) ? htmlspecialchars($row['remarks']) : '<span class="text-muted fst-italic">None</span>' ?>
                                            </td>
                                            <td class="text-center small text-muted">
                                                <?= htmlspecialchars($row['submitted_by'] ?: 'CDO') ?>
                                            </td>
                                            <td class="text-center no-print" style="white-space: nowrap;">
                                                <div class="d-inline-flex justify-content-center align-items-center gap-1 flex-nowrap">
                                                    <button type="button" 
                                                            class="btn btn-sm btn-outline-primary" 
                                                            title="Edit this entry"
                                                            onclick="openEditLogModal(<?= htmlspecialchars(json_encode($row)) ?>)">
                                                        <i class="bi bi-pencil"></i>
                                                    </button>
                                                    <button type="button" 
                                                            class="btn btn-sm btn-outline-danger" 
                                                            title="Remove from date"
                                                            onclick="deleteEquipmentLog(<?= $row['equipment_id'] ?>, '<?= htmlspecialchars(addslashes($row['equipment_name'])) ?>')">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
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
    </div>
</main>

<!-- Edit Log Modal -->
<div class="modal fade" id="editLogModal" tabindex="-1" aria-labelledby="editLogModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form method="POST" action="equipment-daily-report.php">
                <input type="hidden" name="action" value="save_provided">
                <input type="hidden" name="log_date" value="<?= htmlspecialchars($selectedDate) ?>">
                <input type="hidden" name="equipment_id" id="edit_equipment_id">
                
                <div class="modal-header" style="background: #07385f; color: #fff;">
                    <h5 class="modal-title" id="editLogModalLabel"><i class="bi bi-pencil-square me-2"></i> Edit Provided Equipment</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label fw-bold">Equipment Name</label>
                        <input type="text" class="form-control bg-light" id="edit_equipment_name" readonly>
                    </div>
                    <div class="row g-2 mb-3">
                        <div class="col-md-6">
                            <label for="edit_provided_qty" class="form-label fw-bold text-success">Provided Quantity <span class="text-danger">*</span></label>
                            <input type="number" class="form-control fw-bold text-success text-center" id="edit_provided_qty" name="provided_qty" min="1" required>
                        </div>
                        <div class="col-md-6">
                            <label for="edit_working_qty" class="form-label fw-bold text-info">Working Quantity</label>
                            <input type="number" class="form-control text-center" id="edit_working_qty" name="working_qty" min="0">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="edit_breakdown_qty" class="form-label fw-bold text-danger">Breakdown / Defective Quantity</label>
                        <input type="number" class="form-control text-center text-danger" id="edit_breakdown_qty" name="breakdown_qty" min="0">
                    </div>
                    <div class="mb-3">
                        <label for="edit_remarks" class="form-label fw-bold">Remarks / Deployed Location</label>
                        <input type="text" class="form-control" id="edit_remarks" name="remarks" placeholder="Optional notes">
                    </div>
                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary" style="background: #07385f; border-color: #07385f;"><i class="bi bi-save me-1"></i> Update Entry</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Hidden form for deleting single log entry -->
<form id="deleteLogForm" method="POST" action="equipment-daily-report.php" style="display:none;">
    <input type="hidden" name="action" value="delete_log_entry">
    <input type="hidden" name="log_date" value="<?= htmlspecialchars($selectedDate) ?>">
    <input type="hidden" name="equipment_id" id="delete_equipment_id" value="">
</form>

<script>
function onEquipmentChange(selectElement) {
    var selectedOption = selectElement.options[selectElement.selectedIndex];
    var unit = selectedOption.getAttribute('data-unit') || 'Nos';
    var qty = selectedOption.getAttribute('data-qty') || 1;
    
    document.getElementById('form_unit_badge').textContent = unit;
    document.getElementById('form_provided_qty').value = qty;
    document.getElementById('form_working_qty').value = qty;
}

function syncWorkingQuantity(val) {
    document.getElementById('form_working_qty').value = val;
}

function openEditLogModal(data) {
    document.getElementById('edit_equipment_id').value = data.equipment_id;
    document.getElementById('edit_equipment_name').value = data.equipment_name;
    document.getElementById('edit_provided_qty').value = data.given_qty;
    document.getElementById('edit_working_qty').value = data.working_qty;
    document.getElementById('edit_breakdown_qty').value = data.breakdown_qty;
    document.getElementById('edit_remarks').value = data.remarks || '';
    
    var modal = new bootstrap.Modal(document.getElementById('editLogModal'));
    modal.show();
}

function deleteEquipmentLog(eqId, eqName) {
    if (confirm('Are you sure you want to remove "' + eqName + '" from the provided sheet for date <?= date("d-m-Y", strtotime($selectedDate)) ?>?')) {
        document.getElementById('delete_equipment_id').value = eqId;
        document.getElementById('deleteLogForm').submit();
    }
}
</script>

<?php include 'footer.php'; ?>
