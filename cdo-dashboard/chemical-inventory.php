<?php
require_once 'auth.php';

$successMsg = '';
$errorMsg = '';

// Fetch all units from mcc_chemical_units
$unitsListStmt = $pdo->query("SELECT * FROM mcc_chemical_units ORDER BY unit_type, conversion_to_base ASC");
$allUnits = $unitsListStmt->fetchAll(PDO::FETCH_ASSOC);

// Helper function to format stock for display
function formatStockDisplay($qtyInBase, $unitType) {
    $qty = floatval($qtyInBase);
    if ($unitType === 'volume') {
        if ($qty >= 1000) {
            $litres = $qty / 1000;
            return '<span class="fw-bold">' . number_format($litres, 2) . ' L</span> <small class="text-muted d-block">(' . number_format($qty, 0) . ' ml)</small>';
        }
        return '<span class="fw-bold">' . number_format($qty, 2) . ' ml</span>';
    } elseif ($unitType === 'weight') {
        if ($qty >= 1000) {
            $kg = $qty / 1000;
            return '<span class="fw-bold">' . number_format($kg, 2) . ' kg</span> <small class="text-muted d-block">(' . number_format($qty, 0) . ' g)</small>';
        }
        return '<span class="fw-bold">' . number_format($qty, 2) . ' g</span>';
    }
    return '<span class="fw-bold">' . number_format($qty, 0) . ' pcs</span>';
}

// Handle Stock Addition / Update
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $paramId = intval($_POST['parameter_id'] ?? 0);
    $inputQty = floatval($_POST['quantity'] ?? 0);
    $unitId = intval($_POST['unit_id'] ?? 1);
    $actionType = $_POST['action_type'] ?? 'ADD';
    $userRemarks = trim($_POST['remarks'] ?? '');
    $userName = $_SESSION['username'] ?? ($_SESSION['user_name'] ?? 'CDO');

    if ($paramId > 0 && $inputQty > 0) {
        try {
            // Find conversion factor of chosen unit
            $unitStmt = $pdo->prepare("SELECT unit_name, unit_symbol, conversion_to_base FROM mcc_chemical_units WHERE id = :unit_id");
            $unitStmt->execute(['unit_id' => $unitId]);
            $unitInfo = $unitStmt->fetch(PDO::FETCH_ASSOC);

            $conversionFactor = $unitInfo ? floatval($unitInfo['conversion_to_base']) : 1.0;
            $unitSymbol = $unitInfo ? $unitInfo['unit_symbol'] : 'base';
            $qtyInBase = $inputQty * $conversionFactor;

            if ($actionType === 'ADD') {
                $stmt = $pdo->prepare("
                    INSERT INTO mcc_chemical_stock (station_id, parameter_id, stock_quantity)
                    VALUES (:station_id, :parameter_id, :qty)
                    ON DUPLICATE KEY UPDATE stock_quantity = stock_quantity + :qty_update
                ");
                $stmt->execute([
                    'station_id' => $stationId,
                    'parameter_id' => $paramId,
                    'qty' => $qtyInBase,
                    'qty_update' => $qtyInBase
                ]);

                $logRemarks = "Added {$inputQty} {$unitSymbol} (" . number_format($qtyInBase, 2) . " base)";
                if (!empty($userRemarks)) {
                    $logRemarks .= " - " . $userRemarks;
                }

                $logStmt = $pdo->prepare("
                    INSERT INTO mcc_chemical_stock_log (station_id, parameter_id, action_type, quantity, remarks, created_by)
                    VALUES (:station_id, :parameter_id, 'ADD', :qty, :remarks, :created_by)
                ");
                $logStmt->execute([
                    'station_id' => $stationId,
                    'parameter_id' => $paramId,
                    'qty' => $qtyInBase,
                    'remarks' => $logRemarks,
                    'created_by' => $userName
                ]);

                header("Location: chemical-inventory.php?success=added");
                exit();
            }
        } catch (Exception $e) {
            $errorMsg = "Error updating stock: " . $e->getMessage();
        }
    } else {
        $errorMsg = "Please enter a valid quantity greater than 0.";
    }
}

if (isset($_GET['success']) && $_GET['success'] === 'added') {
    $successMsg = "Stock quantity added successfully and converted to standard base units!";
}

// Fetch all active chemicals for this station with unit information
$query = "
    SELECT 
        p.id AS parameter_id,
        p.name AS chemical_name,
        COALESCE(p.unit_type, 'volume') AS unit_type,
        COALESCE(u.unit_symbol, 'ml') AS base_unit_symbol,
        COALESCE(s.stock_quantity, 0) AS total_added_base,
        COALESCE(used.total_used, 0) AS total_used_base,
        s.last_updated_at
    FROM mcc_chemical_param p
    LEFT JOIN mcc_chemical_units u ON p.base_unit_id = u.id
    LEFT JOIN mcc_chemical_stock s ON p.id = s.parameter_id AND s.station_id = :stn1
    LEFT JOIN (
        SELECT parameter_id, SUM(qty_used) AS total_used
        FROM mcc_chemical_report
        WHERE station_id = :stn2
        GROUP BY parameter_id
    ) used ON p.id = used.parameter_id
    WHERE p.station_id = :stn3 AND p.status = 'Active'
    ORDER BY p.name ASC
";
$stmt = $pdo->prepare($query);
$stmt->execute([
    'stn1' => $stationId,
    'stn2' => $stationId,
    'stn3' => $stationId
]);
$chemicals = $stmt->fetchAll(PDO::FETCH_ASSOC);

$pageTitle = "Chemical Inventory & Stock | MCC";

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
    padding: 12px 14px !important;
    color: #334155 !important;
    border: 1px solid #e2e8f0 !important;
}
.inventory-custom-table tbody tr:hover {
    background-color: #f8fafc !important;
}
.badge-stock {
    font-size: 12px;
    font-weight: 600;
    padding: 5px 10px;
    border-radius: 6px;
    display: inline-block;
}
.badge-in-stock {
    background: #dcfce7;
    color: #15803d;
    border: 1px solid #bbf7d0;
}
.badge-low-stock {
    background: #fef9c3;
    color: #a16207;
    border: 1px solid #fef08a;
}
.badge-out-stock {
    background: #fee2e2;
    color: #b91c1c;
    border: 1px solid #fecaca;
}
.btn-add-stock-action {
    background: linear-gradient(135deg, #10b981 0%, #059669 100%);
    color: #fff !important;
    border: none;
    font-size: 12.5px;
    font-weight: 600;
    padding: 7px 15px;
    border-radius: 6px;
    transition: all 0.2s;
    display: inline-flex;
    align-items: center;
    gap: 5px;
    box-shadow: 0 2px 5px rgba(16,185,129,0.25);
}
.btn-add-stock-action:hover {
    transform: translateY(-1px);
    box-shadow: 0 4px 10px rgba(16,185,129,0.35);
}

@media print {
    .app-header, 
    .app-sidebar, 
    .app-footer, 
    .no-print, 
    .report-filter,
    form.report-filter,
    div.no-print,
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
    .inventory-sheet {
        box-shadow: none !important;
        border: 1px solid #000 !important;
        padding: 10px !important;
    }
    .inventory-custom-table th {
        background: #f1f5f9 !important;
        color: #000000 !important;
        border: 1px solid #000 !important;
    }
    .inventory-custom-table td {
        border: 1px solid #000 !important;
    }
}
</style>

<main class="app-main">
    <div class="app-content">
        <div class="container-fluid">
            
            <!-- Top Filter & Action Bar -->
            <div class="report-filter no-print d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center gap-2">
                    <span class="fw-bold text-white"><i class="bi bi-box-seam me-1"></i> Chemical Stock Master</span>
                </div>
                <div class="d-flex align-items-center gap-2">
                    <a href="chemical-daily-report.php" class="btn-summary">
                        <i class="bi bi-calendar2-day me-1"></i> Daily Usage Report
                    </a>
                    <button type="button" class="btn-print" onclick="window.print()">Print</button>
                </div>
            </div>

            <div class="report-wrap">

                <?php if (!empty($successMsg)): ?>
                    <div class="alert alert-success alert-dismissible fade show no-print" role="alert" style="border-radius: 8px;">
                        <i class="bi bi-check-circle-fill me-2"></i> <?= htmlspecialchars($successMsg) ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <?php endif; ?>

                <?php if (!empty($errorMsg)): ?>
                    <div class="alert alert-danger alert-dismissible fade show no-print" role="alert" style="border-radius: 8px;">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> <?= htmlspecialchars($errorMsg) ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                <?php endif; ?>

                <!-- Inventory Sheet Card -->
                <div class="inventory-sheet">
                    <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #e2e8f0; padding-bottom: 12px; margin-bottom: 16px;">
                        <h2 style="font-size: 18px; font-weight: 700; color: #1e293b; margin: 0;">
                            <i class="bi bi-boxes me-2 text-primary"></i> Chemical Stock & Inward Management
                        </h2>
                        <span class="badge bg-secondary px-3 py-2 text-white" style="font-size: 0.85rem; font-weight: 600; border-radius: 6px;">
                            Station: <?= htmlspecialchars($stationName) ?>
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
                        <table class="table table-bordered inventory-custom-table mb-0 align-middle">
                            <thead>
                                <tr>
                                    <th style="width: 50px;" class="text-center">#</th>
                                    <th>Chemical Name</th>
                                    <th class="text-center" style="width: 100px;">Type</th>
                                    <th class="text-end" style="width: 160px;">Total Stock Added</th>
                                    <th class="text-end" style="width: 160px;">Total Consumed</th>
                                    <th class="text-end" style="width: 180px;">Available Stock</th>
                                    <th class="text-center" style="width: 120px;">Status</th>
                                    <th class="text-center no-print" style="width: 140px;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if (empty($chemicals)): ?>
                                    <tr>
                                        <td colspan="8" class="text-center py-4 text-muted">
                                            <i class="bi bi-inbox fs-3 d-block mb-2"></i> No active chemicals found for this station.
                                        </td>
                                    </tr>
                                <?php else: ?>
                                    <?php $i = 1; foreach ($chemicals as $chem): 
                                        $addedBase = floatval($chem['total_added_base']);
                                        $usedBase = floatval($chem['total_used_base']);
                                        $availBase = max(0, $addedBase - $usedBase);
                                        $unitType = $chem['unit_type'];

                                        $statusClass = 'badge-in-stock';
                                        $statusText = 'In Stock';
                                        if ($availBase <= 0) {
                                            $statusClass = 'badge-out-stock';
                                            $statusText = 'Out of Stock';
                                        } elseif ($unitType === 'volume' && $availBase < 5000) {
                                            $statusClass = 'badge-low-stock';
                                            $statusText = 'Low Stock';
                                        } elseif ($unitType === 'weight' && $availBase < 5000) {
                                            $statusClass = 'badge-low-stock';
                                            $statusText = 'Low Stock';
                                        }
                                    ?>
                                        <tr>
                                            <td class="text-center fw-bold text-muted"><?= $i++ ?></td>
                                            <td class="fw-semibold text-dark">
                                                <?= htmlspecialchars($chem['chemical_name']) ?>
                                            </td>
                                            <td class="text-center">
                                                <span class="badge bg-light text-dark border text-capitalize"><?= htmlspecialchars($unitType) ?></span>
                                            </td>
                                            <td class="text-end fw-semibold text-secondary">
                                                <?= formatStockDisplay($addedBase, $unitType) ?>
                                            </td>
                                            <td class="text-end fw-semibold text-danger">
                                                <?= formatStockDisplay($usedBase, $unitType) ?>
                                            </td>
                                            <td class="text-end text-success">
                                                <?= formatStockDisplay($availBase, $unitType) ?>
                                            </td>
                                            <td class="text-center">
                                                <span class="badge-stock <?= $statusClass ?>"><?= $statusText ?></span>
                                            </td>
                                            <td class="text-center no-print">
                                                <button type="button" class="btn-add-stock-action" 
                                                        data-bs-toggle="modal" 
                                                        data-bs-target="#stockModal"
                                                        data-id="<?= $chem['parameter_id'] ?>"
                                                        data-name="<?= htmlspecialchars($chem['chemical_name']) ?>"
                                                        data-type="<?= htmlspecialchars($unitType) ?>"
                                                        data-avail="<?= number_format($availBase, 2, '.', '') ?>">
                                                    <i class="bi bi-plus-lg"></i> Add Stock
                                                </button>
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

<!-- Add / Inward Stock Modal with Multi-Unit Support -->
<div class="modal fade" id="stockModal" tabindex="-1" aria-labelledby="stockModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content" style="border-radius: 12px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.15);">
            <form method="POST" action="chemical-inventory.php">
                <div class="modal-header" style="background: #07385f; color: #fff; border-top-left-radius: 12px; border-top-right-radius: 12px;">
                    <h5 class="modal-title fw-bold" id="stockModalLabel" style="font-size: 16px;">
                        <i class="bi bi-box-seam me-2"></i> Add / Inward Chemical Stock
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <input type="hidden" name="parameter_id" id="modalParamId">
                    <input type="hidden" name="action_type" value="ADD">

                    <div class="mb-3">
                        <label class="form-label text-muted small fw-bold">Chemical Name</label>
                        <div class="fw-bold text-dark fs-6 p-2 bg-light rounded border" id="modalChemName">-</div>
                    </div>

                    <div class="row g-2 mb-3">
                        <div class="col-7">
                            <label class="form-label text-dark fw-bold small">Quantity Received <span class="text-danger">*</span></label>
                            <input type="number" step="0.01" min="0.01" class="form-control" name="quantity" id="modalQuantity" placeholder="e.g. 10" required>
                        </div>
                        <div class="col-5">
                            <label class="form-label text-dark fw-bold small">Unit <span class="text-danger">*</span></label>
                            <select class="form-select fw-semibold" name="unit_id" id="modalUnitSelect" required>
                                <?php foreach ($allUnits as $u): ?>
                                    <option value="<?= $u['id'] ?>" 
                                            data-type="<?= $u['unit_type'] ?>" 
                                            data-multiplier="<?= $u['conversion_to_base'] ?>"
                                            data-symbol="<?= htmlspecialchars($u['unit_symbol']) ?>">
                                        <?= htmlspecialchars($u['unit_name']) ?> (<?= htmlspecialchars($u['unit_symbol']) ?>)
                                    </option>
                                <?php endforeach; ?>
                            </select>
                        </div>
                    </div>

                    <div class="p-2 mb-3 bg-light rounded border text-muted small" id="conversionHintBox">
                        <i class="bi bi-info-circle me-1 text-primary"></i> <span id="conversionHintText">Enter quantity and unit above.</span>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-dark fw-bold small">Remarks / Invoice Ref (Optional)</label>
                        <input type="text" class="form-control" name="remarks" placeholder="e.g. Invoice #2045, Batch 8A">
                    </div>
                </div>
                <div class="modal-footer bg-light" style="border-bottom-left-radius: 12px; border-bottom-right-radius: 12px;">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success fw-semibold px-4">
                        <i class="bi bi-check2-circle me-1"></i> Save Inward Stock
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const stockModal = document.getElementById('stockModal');
    const unitSelect = document.getElementById('modalUnitSelect');
    const quantityInput = document.getElementById('modalQuantity');
    const hintText = document.getElementById('conversionHintText');

    let currentChemType = 'volume';

    function updateConversionHint() {
        const qty = parseFloat(quantityInput.value) || 0;
        const selectedOpt = unitSelect.options[unitSelect.selectedIndex];
        if (!selectedOpt) return;

        const multiplier = parseFloat(selectedOpt.getAttribute('data-multiplier')) || 1;
        const symbol = selectedOpt.getAttribute('data-symbol');
        const baseQty = (qty * multiplier).toLocaleString(undefined, {minimumFractionDigits: 0, maximumFractionDigits: 2});

        if (qty > 0) {
            let baseName = 'ml';
            if (currentChemType === 'weight') baseName = 'g';
            else if (currentChemType === 'count') baseName = 'pcs';

            hintText.innerHTML = `<strong>${qty} ${symbol}</strong> will be stored as <strong>${baseQty} ${baseName}</strong> in stock.`;
        } else {
            hintText.textContent = `Selected unit: ${selectedOpt.text}`;
        }
    }

    if (stockModal) {
        stockModal.addEventListener('show.bs.modal', function(event) {
            const button = event.relatedTarget;
            const paramId = button.getAttribute('data-id');
            const chemName = button.getAttribute('data-name');
            const chemType = button.getAttribute('data-type') || 'volume';
            currentChemType = chemType;

            document.getElementById('modalParamId').value = paramId;
            document.getElementById('modalChemName').textContent = chemName;
            quantityInput.value = '';

            // Filter unit options matching this chemical type
            let firstMatched = false;
            for (let i = 0; i < unitSelect.options.length; i++) {
                const opt = unitSelect.options[i];
                const optType = opt.getAttribute('data-type');
                if (optType === chemType) {
                    opt.style.display = '';
                    opt.disabled = false;
                    if (!firstMatched) {
                        unitSelect.selectedIndex = i;
                        firstMatched = true;
                    }
                } else {
                    opt.style.display = 'none';
                    opt.disabled = true;
                }
            }

            updateConversionHint();
        });

        unitSelect.addEventListener('change', updateConversionHint);
        quantityInput.addEventListener('input', updateConversionHint);
    }
});
</script>

<?php include 'footer.php'; ?>
