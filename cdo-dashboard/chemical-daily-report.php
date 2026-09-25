<?php
require_once 'auth.php';

$selectedDate = $_GET['report_date'] ?? date('Y-m-d');

// Helper function to format quantities for display
function formatChemicalQty($qtyInBase, $unitType) {
    $qty = floatval($qtyInBase);
    if ($qty <= 0) {
        return '<span class="text-muted">0.00</span>';
    }
    if ($unitType === 'volume') {
        if ($qty >= 1000) {
            $litres = $qty / 1000;
            return '<span class="fw-bold">' . number_format($litres, 2) . ' L</span> <small class="text-muted">(' . number_format($qty, 0) . ' ml)</small>';
        }
        return '<span class="fw-bold">' . number_format($qty, 2) . ' ml</span>';
    } elseif ($unitType === 'weight') {
        if ($qty >= 1000) {
            $kg = $qty / 1000;
            return '<span class="fw-bold">' . number_format($kg, 2) . ' kg</span> <small class="text-muted">(' . number_format($qty, 0) . ' g)</small>';
        }
        return '<span class="fw-bold">' . number_format($qty, 2) . ' g</span>';
    }
    return '<span class="fw-bold">' . number_format($qty, 0) . ' pcs</span>';
}

// Fetch all active chemical parameters for this station
// 1. Total Added Inward Stock (from mcc_chemical_stock)
// 2. Prior Used before $selectedDate (from mcc_chemical_report where report_date < $selectedDate)
// 3. Used Today on $selectedDate (from mcc_chemical_report where report_date = $selectedDate)
$query = "
    SELECT 
        p.id AS parameter_id,
        p.name AS chemical_name,
        COALESCE(p.unit_type, 'volume') AS unit_type,
        COALESCE(u.unit_symbol, 'ml') AS base_unit_symbol,
        COALESCE(s.stock_quantity, 0) AS total_added_stock,
        COALESCE(prior.total_prior_used, 0) AS total_prior_used,
        COALESCE(day_rep.qty_used_day, 0) AS qty_used_today
    FROM mcc_chemical_param p
    LEFT JOIN mcc_chemical_units u ON p.base_unit_id = u.id
    LEFT JOIN mcc_chemical_stock s ON p.id = s.parameter_id AND s.station_id = :stn1
    LEFT JOIN (
        SELECT parameter_id, SUM(qty_used) AS total_prior_used
        FROM mcc_chemical_report
        WHERE station_id = :stn2 AND report_date < :rep_date_prior
        GROUP BY parameter_id
    ) prior ON p.id = prior.parameter_id
    LEFT JOIN (
        SELECT 
            parameter_id, 
            SUM(qty_used) AS qty_used_day
        FROM mcc_chemical_report
        WHERE station_id = :stn3 AND report_date = :rep_date_day
        GROUP BY parameter_id
    ) day_rep ON p.id = day_rep.parameter_id
    WHERE p.station_id = :stn4 AND p.status = 'Active'
    ORDER BY p.name ASC
";

$stmt = $pdo->prepare($query);
$stmt->execute([
    'stn1' => $stationId,
    'stn2' => $stationId,
    'rep_date_prior' => $selectedDate,
    'stn3' => $stationId,
    'rep_date_day' => $selectedDate,
    'stn4' => $stationId
]);
$dailyReport = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Totals for top stat summary
$totalChemicals = count($dailyReport);
$activeUsedCount = 0;

foreach ($dailyReport as $row) {
    if (floatval($row['qty_used_today']) > 0) {
        $activeUsedCount++;
    }
}

$pageTitle = "Daily Chemical Report | MCC";

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
            <form class="report-filter no-print" method="GET" action="chemical-daily-report.php">
                <label for="report_date">Date:</label>
                <input type="date" id="report_date" name="report_date" value="<?= htmlspecialchars($selectedDate); ?>">
                
                <button type="submit" class="btn-go">Filter</button>
                <a href="chemical-inventory.php" class="btn-summary" style="background: #10b981 !important; margin-left: 8px;">
                    <i class="bi bi-box-seam me-1"></i> Manage Stock
                </a>
                <button type="button" class="btn-print" onclick="window.print()">Print</button>
            </form>

            <div class="report-wrap">
                
                <!-- KPI Stat Cards -->
                <div class="row g-3 mb-4 no-print">
                    <div class="col-md-4">
                        <div class="summary-kpi-box">
                            <div>
                                <div class="text-muted small fw-bold text-uppercase">Total Chemicals</div>
                                <div class="fs-4 fw-bold text-dark"><?= $totalChemicals ?></div>
                            </div>
                            <div class="bg-light text-primary p-3 rounded-circle fs-4">
                                <i class="bi bi-droplet-half"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="summary-kpi-box">
                            <div>
                                <div class="text-muted small fw-bold text-uppercase">Chemicals Used on <?= date('d M', strtotime($selectedDate)) ?></div>
                                <div class="fs-4 fw-bold text-info"><?= $activeUsedCount ?></div>
                            </div>
                            <div class="bg-light text-info p-3 rounded-circle fs-4">
                                <i class="bi bi-activity"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="summary-kpi-box">
                            <div>
                                <div class="text-muted small fw-bold text-uppercase">Report Date</div>
                                <div class="fs-5 fw-bold text-dark"><?= date('d-m-Y', strtotime($selectedDate)) ?></div>
                            </div>
                            <div class="bg-light text-success p-3 rounded-circle fs-4">
                                <i class="bi bi-calendar-check"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main Report Sheet -->
                <div class="daily-report-sheet">
                    
                    <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #e2e8f0; padding-bottom: 12px; margin-bottom: 16px;">
                        <h2 style="font-size: 18px; font-weight: 700; color: #1e293b; margin: 0;">
                            <i class="bi bi-journal-text me-2 text-primary"></i> Daily Chemical Balance Sheet (Opening vs Used vs Remaining)
                        </h2>
                        <span class="badge bg-primary px-3 py-2 text-white" style="font-size: 0.85rem; font-weight: 600; border-radius: 6px;">
                            Date: <?= date('d-m-Y', strtotime($selectedDate)) ?>
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
                                    <th>Chemical Name</th>
                                    <th class="text-center" style="width: 100px;">Type</th>
                                    <th class="text-end" style="width: 200px;">Opening Stock (Start of Day)</th>
                                    <th class="text-end" style="width: 180px;">Used Today (<?= date('d-m-Y', strtotime($selectedDate)) ?>)</th>
                                    <th class="text-end" style="width: 200px;">Remaining Stock (End of Day)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if (empty($dailyReport)): ?>
                                    <tr>
                                        <td colspan="6" class="text-center py-4 text-muted">
                                            <i class="bi bi-inbox fs-3 d-block mb-2"></i> No chemical parameters found for this station.
                                        </td>
                                    </tr>
                                <?php else: ?>
                                    <?php $i = 1; foreach ($dailyReport as $row): 
                                        $addedStock = floatval($row['total_added_stock']);
                                        $priorUsed = floatval($row['total_prior_used']);
                                        $usedToday = floatval($row['qty_used_today']);

                                        // Opening Stock = Total Inward Stock - Usage before this date
                                        $openingStock = max(0, $addedStock - $priorUsed);

                                        // Remaining Stock = Opening Stock - Usage on this date
                                        $remainingStock = max(0, $openingStock - $usedToday);

                                        $unitType = $row['unit_type'];
                                    ?>
                                        <tr>
                                            <td class="text-center fw-bold text-muted"><?= $i++ ?></td>
                                            <td class="fw-semibold text-dark">
                                                <?= htmlspecialchars($row['chemical_name']) ?>
                                            </td>
                                            <td class="text-center">
                                                <span class="badge bg-light text-dark border text-capitalize"><?= htmlspecialchars($unitType) ?></span>
                                            </td>
                                            <td class="text-end text-secondary" style="font-size: 14.5px;">
                                                <?= formatChemicalQty($openingStock, $unitType) ?>
                                            </td>
                                            <td class="text-end <?= $usedToday > 0 ? 'text-primary' : 'text-muted' ?>" style="font-size: 14.5px;">
                                                <?= formatChemicalQty($usedToday, $unitType) ?>
                                            </td>
                                            <td class="text-end text-success" style="font-size: 15px;">
                                                <?= formatChemicalQty($remainingStock, $unitType) ?>
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

<?php include 'footer.php'; ?>
