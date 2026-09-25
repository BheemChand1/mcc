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

// Fetch all active chemical parameters for this station based strictly on chronological ledger
// 1. Stock received prior to $selectedDate (from mcc_chemical_stock_log)
// 2. Stock received today on $selectedDate (from mcc_chemical_stock_log)
// 3. Prior Used before $selectedDate (from mcc_chemical_report where report_date < $selectedDate)
// 4. Used Today on $selectedDate (from mcc_chemical_report where report_date = $selectedDate)
$query = "
    SELECT 
        p.id AS parameter_id,
        p.name AS chemical_name,
        COALESCE(p.unit_type, 'volume') AS unit_type,
        COALESCE(u.unit_symbol, 'ml') AS base_unit_symbol,
        COALESCE(log_prior.stock_received_prior, 0) AS stock_received_prior,
        COALESCE(log_today.stock_received_today, 0) AS stock_received_today,
        COALESCE(prior.total_prior_used, 0) AS total_prior_used,
        COALESCE(day_rep.qty_used_day, 0) AS qty_used_today
    FROM mcc_chemical_param p
    LEFT JOIN mcc_chemical_units u ON p.base_unit_id = u.id
    LEFT JOIN (
        SELECT parameter_id, SUM(quantity) AS stock_received_prior
        FROM mcc_chemical_stock_log
        WHERE station_id = :stn_log_prior AND action_type = 'ADD' AND DATE(created_at) < :rep_date_prior1
        GROUP BY parameter_id
    ) log_prior ON p.id = log_prior.parameter_id
    LEFT JOIN (
        SELECT parameter_id, SUM(quantity) AS stock_received_today
        FROM mcc_chemical_stock_log
        WHERE station_id = :stn_log_today AND action_type = 'ADD' AND DATE(created_at) = :rep_date_today1
        GROUP BY parameter_id
    ) log_today ON p.id = log_today.parameter_id
    LEFT JOIN (
        SELECT parameter_id, SUM(qty_used) AS total_prior_used
        FROM mcc_chemical_report
        WHERE station_id = :stn2 AND report_date < :rep_date_prior2
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
    'stn_log_prior' => $stationId,
    'rep_date_prior1' => $selectedDate,
    'stn_log_today' => $stationId,
    'rep_date_today1' => $selectedDate,
    'stn2' => $stationId,
    'rep_date_prior2' => $selectedDate,
    'stn3' => $stationId,
    'rep_date_day' => $selectedDate,
    'stn4' => $stationId
]);
$dailyReport = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Totals for top stat summary
$totalChemicals = count($dailyReport);
$receivedTodayCount = 0;
$activeUsedCount = 0;

foreach ($dailyReport as $row) {
    if (floatval($row['stock_received_today']) > 0) {
        $receivedTodayCount++;
    }
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
                    <div class="col-md-3">
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
                    <div class="col-md-3">
                        <div class="summary-kpi-box">
                            <div>
                                <div class="text-muted small fw-bold text-uppercase">Stock Received Today</div>
                                <div class="fs-4 fw-bold text-success"><?= $receivedTodayCount ?></div>
                            </div>
                            <div class="bg-light text-success p-3 rounded-circle fs-4">
                                <i class="bi bi-box-arrow-in-down"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="summary-kpi-box">
                            <div>
                                <div class="text-muted small fw-bold text-uppercase">Chemicals Used Today</div>
                                <div class="fs-4 fw-bold text-info"><?= $activeUsedCount ?></div>
                            </div>
                            <div class="bg-light text-info p-3 rounded-circle fs-4">
                                <i class="bi bi-activity"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="summary-kpi-box">
                            <div>
                                <div class="text-muted small fw-bold text-uppercase">Report Date</div>
                                <div class="fs-5 fw-bold text-dark"><?= date('d-m-Y', strtotime($selectedDate)) ?></div>
                            </div>
                            <div class="bg-light text-secondary p-3 rounded-circle fs-4">
                                <i class="bi bi-calendar-check"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main Report Sheet -->
                <div class="daily-report-sheet">
                    
                    <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #e2e8f0; padding-bottom: 12px; margin-bottom: 16px;">
                        <h2 style="font-size: 18px; font-weight: 700; color: #1e293b; margin: 0;">
                            <i class="bi bi-journal-text me-2 text-primary"></i> Daily Chemical Balance Sheet (Opening + Received vs Used vs Remaining)
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
                                    <th style="width: 45px;" class="text-center">#</th>
                                    <th>Chemical Name</th>
                                    <th class="text-center" style="width: 85px;">Type</th>
                                    <th class="text-end" style="width: 170px;">Opening Stock<br><small style="font-size: 11px; font-weight: 400; opacity: 0.9;">(Start of Day)</small></th>
                                    <th class="text-end" style="width: 170px; background: #064e3b !important; border-color: #065f46 !important;">Today Received Stock<br><small style="font-size: 11px; font-weight: 400; opacity: 0.9;">(Added Today)</small></th>
                                    <th class="text-end" style="width: 170px;">Total Available<br><small style="font-size: 11px; font-weight: 400; opacity: 0.9;">(Opening + Received)</small></th>
                                    <th class="text-end" style="width: 170px;">Used Today<br><small style="font-size: 11px; font-weight: 400; opacity: 0.9;">(<?= date('d-m-Y', strtotime($selectedDate)) ?>)</small></th>
                                    <th class="text-end" style="width: 180px;">Remaining Stock<br><small style="font-size: 11px; font-weight: 400; opacity: 0.9;">(End of Day)</small></th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php if (empty($dailyReport)): ?>
                                    <tr>
                                        <td colspan="8" class="text-center py-4 text-muted">
                                            <i class="bi bi-inbox fs-3 d-block mb-2"></i> No chemical parameters found for this station.
                                        </td>
                                    </tr>
                                <?php else: ?>
                                    <?php $i = 1; foreach ($dailyReport as $row): 
                                        $priorReceived = floatval($row['stock_received_prior']);
                                        $todayReceived = floatval($row['stock_received_today']);
                                        $priorUsed = floatval($row['total_prior_used']);
                                        $usedToday = floatval($row['qty_used_today']);

                                        // Opening Stock = Stock received before this date - Usage before this date
                                        $openingStock = max(0, $priorReceived - $priorUsed);

                                        // Total Available = Opening Stock + Today's Inward Added Stock
                                        $totalAvailable = $openingStock + $todayReceived;

                                        // Remaining Stock = Total Available - Usage on this date
                                        $remainingStock = max(0, $totalAvailable - $usedToday);

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
                                            <td class="text-end text-secondary" style="font-size: 14px;">
                                                <?= formatChemicalQty($openingStock, $unitType) ?>
                                            </td>
                                            <td class="text-end" style="font-size: 14px; background-color: <?= $todayReceived > 0 ? '#f0fdf4' : 'transparent' ?>;">
                                                <?php if ($todayReceived > 0): ?>
                                                    <span class="text-success fw-bold">+ <?= formatChemicalQty($todayReceived, $unitType) ?></span>
                                                <?php else: ?>
                                                    <span class="text-muted">0.00</span>
                                                <?php endif; ?>
                                            </td>
                                            <td class="text-end text-dark fw-semibold" style="font-size: 14px;">
                                                <?= formatChemicalQty($totalAvailable, $unitType) ?>
                                            </td>
                                            <td class="text-end <?= $usedToday > 0 ? 'text-primary fw-bold' : 'text-muted' ?>" style="font-size: 14px;">
                                                <?= formatChemicalQty($usedToday, $unitType) ?>
                                            </td>
                                            <td class="text-end text-success fw-bold" style="font-size: 14.5px;">
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
