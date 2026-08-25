<?php
/**
 * CDO Dashboard - Impose Penalty
 * Manages general penalties that apply to station billing.
 */
require_once 'auth.php';

$successMsg = '';
$errorMsg = '';

// Handle Delete Request
if (isset($_GET['delete_id'])) {
    $delId = intval($_GET['delete_id']);
    try {
        $stmt = $pdo->prepare("DELETE FROM mcc_imposed_penalties WHERE id = :id AND station_id = :station_id");
        $stmt->execute(['id' => $delId, 'station_id' => $stationId]);
        $successMsg = "Imposed penalty deleted successfully.";
        $monthParam = isset($_GET['month']) ? '&month=' . urlencode($_GET['month']) : '';
        header("Location: impose-penalty.php?success_msg=" . urlencode($successMsg) . $monthParam);
        exit();
    } catch (Exception $e) {
        $errorMsg = "Database error: " . $e->getMessage();
    }
}

// Handle Add Penalty Form Submission
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'add_penalty') {
    $date = $_POST['penalty_date'] ?? '';
    $reason = trim($_POST['penalty_reason'] ?? '');
    $desc = trim($_POST['description'] ?? '');
    $amount = floatval($_POST['penalty_amount'] ?? 0);

    if (empty($date) || empty($reason) || $amount <= 0) {
        $errorMsg = "Please fill in all required fields and specify a valid positive penalty amount.";
    } else {
        try {
            $stmt = $pdo->prepare("
                INSERT INTO mcc_imposed_penalties (station_id, penalty_date, penalty_reason, description, penalty_amount)
                VALUES (:station_id, :penalty_date, :penalty_reason, :description, :penalty_amount)
            ");
            $stmt->execute([
                'station_id' => $stationId,
                'penalty_date' => $date,
                'penalty_reason' => $reason,
                'description' => $desc,
                'penalty_amount' => $amount
            ]);
            $successMsg = "Penalty of ₹" . number_format($amount, 2) . " imposed successfully!";
            $redirMonth = date('Y-m', strtotime($date));
            header("Location: impose-penalty.php?success_msg=" . urlencode($successMsg) . "&month=" . urlencode($redirMonth));
            exit();
        } catch (Exception $e) {
            $errorMsg = "Database error: " . $e->getMessage();
        }
    }
}

if (isset($_GET['success_msg'])) {
    $successMsg = $_GET['success_msg'];
}

// Selected filter month (defaults to current month)
$selectedMonthYear = $_GET['month'] ?? date('Y-m');

if ($selectedMonthYear === 'all') {
    // Fetch all penalties list for this station
    $penaltiesStmt = $pdo->prepare("
        SELECT * FROM mcc_imposed_penalties 
        WHERE station_id = :station_id 
        ORDER BY penalty_date DESC, id DESC
    ");
    $penaltiesStmt->execute([
        'station_id' => $stationId
    ]);
    $selectedMonthName = "All Months";
} else {
    $parts = explode('-', $selectedMonthYear);
    $selectedYear = intval($parts[0] ?? date('Y'));
    $selectedMonth = intval($parts[1] ?? date('m'));

    // Fetch penalties list for this station and month
    $penaltiesStmt = $pdo->prepare("
        SELECT * FROM mcc_imposed_penalties 
        WHERE station_id = :station_id 
          AND YEAR(penalty_date) = :year 
          AND MONTH(penalty_date) = :month 
        ORDER BY penalty_date DESC, id DESC
    ");
    $penaltiesStmt->execute([
        'station_id' => $stationId,
        'year' => $selectedYear,
        'month' => $selectedMonth
    ]);
    $selectedMonthName = date('F Y', strtotime("$selectedYear-$selectedMonth-01"));
}
$penaltiesList = $penaltiesStmt->fetchAll();

// Calculate total penalty sum for selected filter
$totalMonthPenalties = 0.00;
foreach ($penaltiesList as $p) {
    $totalMonthPenalties += floatval($p['penalty_amount']);
}

$pageTitle = 'MCC CDO Dashboard | Impose Penalty';

$extraStyles = "
.btn-primary-custom {
    background-color: #1987C6 !important;
    border-color: #1987C6 !important;
}
.btn-primary-custom:hover {
    background-color: #126392 !important;
    border-color: #126392 !important;
}
.dataTables_wrapper .dataTables_paginate .paginate_button {
    padding: 0px 4px !important;
    margin: 0px !important;
}
.dataTables_wrapper .dataTables_filter input,
.dataTables_wrapper .dataTables_length select {
    border: 1px solid #cbd5e1 !important;
    border-radius: 6px !important;
    padding: 4px 8px !important;
    outline: none !important;
    font-size: 14px !important;
}
.dataTables_wrapper .dataTables_info,
.dataTables_wrapper .dataTables_paginate {
    font-size: 13px !important;
    margin-top: 10px !important;
    margin-bottom: 10px !important;
}
";

include 'header.php';
include 'sidebar.php';
?>
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">

<main class="app-main">
    <div class="app-content-header py-3">
        <div class="container-fluid">
            <div class="row align-items-center">
                <div class="col-sm-6">
                    <h3 class="mb-0 font-weight-bold text-dark"><i class="bi bi-exclamation-octagon me-2 text-danger"></i> Impose Penalty</h3>
                    <p class="text-muted mb-0" style="font-size: 0.85rem;">Depot Station: <?= htmlspecialchars($stationName) ?> (<?= htmlspecialchars($divisionName) ?> / <?= htmlspecialchars($railwayName) ?>)</p>
                </div>
                <div class="col-sm-6 text-sm-end">
                    <form method="GET" class="d-inline-block bg-white p-2 border rounded shadow-sm">
                        <label for="filter_month" class="me-2 fw-bold text-secondary small">Filter Month:</label>
                        <select name="month" id="filter_month" class="form-select d-inline-block w-auto form-select-sm" onchange="this.form.submit()">
                            <option value="all" <?= ($selectedMonthYear === 'all') ? 'selected' : '' ?>>Select Month / Show All</option>
                            <?php
                            // Generate options for the last 24 months dynamically
                            for ($i = 0; $i < 24; $i++) {
                                $val = date('Y-m', strtotime("-$i months"));
                                $label = date('F Y', strtotime("-$i months"));
                                $selected = ($val === $selectedMonthYear) ? 'selected' : '';
                                echo "<option value=\"$val\" $selected>$label</option>";
                            }
                            ?>
                        </select>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="app-content py-3">
        <div class="container-fluid">
            <!-- Alerts -->
            <?php if (!empty($successMsg)): ?>
                <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i> <?= htmlspecialchars($successMsg) ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <?php endif; ?>

            <?php if (!empty($errorMsg)): ?>
                <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> <?= htmlspecialchars($errorMsg) ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <?php endif; ?>

            <div class="row">
                <!-- Column 1: Add Penalty Form -->
                <div class="col-lg-4 mb-4">
                    <div class="card shadow-sm border-0 rounded-3">
                        <div class="card-header bg-white border-bottom py-3">
                            <h5 class="card-title mb-0 fw-bold text-dark"><i class="bi bi-plus-circle me-1 text-danger"></i> Add Penalty Record</h5>
                        </div>
                        <div class="card-body">
                            <form method="POST">
                                <input type="hidden" name="action" value="add_penalty">
                                
                                <div class="mb-3 text-start">
                                    <label class="form-label fw-bold text-secondary">Penalty Date <span class="text-danger">*</span></label>
                                    <input type="date" name="penalty_date" class="form-control" value="<?= date('Y-m-d') ?>" required>
                                </div>

                                <div class="mb-3 text-start">
                                    <label class="form-label fw-bold text-secondary">Penalty Reason <span class="text-danger">*</span></label>
                                    <input type="text" name="penalty_reason" class="form-control" placeholder="e.g. Late attendance / Machine failure" required>
                                </div>

                                <div class="mb-3 text-start">
                                    <label class="form-label fw-bold text-secondary">Penalty Amount (₹) <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text">₹</span>
                                        <input type="number" step="0.01" min="0.01" name="penalty_amount" class="form-control" placeholder="0.00" required>
                                    </div>
                                </div>

                                <div class="mb-3 text-start">
                                    <label class="form-label fw-bold text-secondary">Detailed Description</label>
                                    <textarea name="description" class="form-control" rows="3" placeholder="Enter details about the penalty..."></textarea>
                                </div>

                                <button type="submit" class="btn btn-primary-custom text-white w-100 py-2 fw-bold shadow-sm">
                                    <i class="bi bi-save me-1"></i> Save Penalty
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Column 2: Penalties List -->
                <div class="col-lg-8 mb-4">
                    <div class="card shadow-sm border-0 rounded-3">
                        <div class="card-header bg-white border-bottom py-3 d-flex justify-content-between align-items-center">
                            <h5 class="card-title mb-0 fw-bold text-dark"><i class="bi bi-list-task me-1 text-danger"></i> Penalties List for <?= htmlspecialchars($selectedMonthName) ?></h5>
                            <span class="badge bg-danger fs-6 px-3 py-2">
                                Total: ₹<?= number_format($totalMonthPenalties, 2) ?>
                            </span>
                        </div>
                        <div class="card-body p-3">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered align-middle text-start mb-0" id="penaltiesTable" style="width:100%">
                                    <thead>
                                        <tr class="table-light">
                                            <th style="width: 15%;" class="ps-3">Date</th>
                                            <th style="width: 20%;">Reason</th>
                                            <th style="width: 35%;">Description</th>
                                            <th style="width: 15%; text-align: right;">Amount (₹)</th>
                                            <th style="width: 15%; text-align: center;">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php foreach ($penaltiesList as $p): ?>
                                            <tr>
                                                <td class="ps-3 fw-bold" data-order="<?= strtotime($p['penalty_date']) ?>">
                                                    <?= date('d.m.Y', strtotime($p['penalty_date'])) ?>
                                                </td>
                                                <td>
                                                    <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill">
                                                        <?= htmlspecialchars($p['penalty_reason']) ?>
                                                    </span>
                                                </td>
                                                <td class="small text-secondary">
                                                    <?= nl2br(htmlspecialchars($p['description'])) ?>
                                                </td>
                                                <td class="text-end fw-bold">
                                                    ₹<?= number_format($p['penalty_amount'], 2) ?>
                                                </td>
                                                <td class="text-center">
                                                    <a href="impose-penalty.php?delete_id=<?= $p['id'] ?>&month=<?= urlencode($selectedMonthYear) ?>" class="btn btn-outline-danger btn-sm border-0 rounded-3" onclick="return confirm('Are you sure you want to delete this penalty record?')">
                                                        <i class="bi bi-trash-fill"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        <?php endforeach; ?>
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

<!-- Load jQuery and DataTables JS -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
<script>
$(document).ready(function() {
    if ($.fn.DataTable) {
        $('#penaltiesTable').DataTable({
            "order": [[ 0, "desc" ]], // Sort by date descending initially
            "pageLength": 10,
            "lengthMenu": [5, 10, 25, 50, 100],
            "language": {
                "search": "Search Penalties:",
                "lengthMenu": "Show _MENU_ entries"
            }
        });
    }
});
</script>

<?php
include 'footer.php';
?>
