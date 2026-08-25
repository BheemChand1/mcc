<?php
/**
 * MCC Admin Panel - Setup Billing Page
 * Manages dynamic station billing configurations, contracts, and weightages.
 */
$pageTitle = 'MCC Admin Panel | Setup Billing';
require_once '../connection.php';

// Fetch all active stations for the selector
$stationsStmt = $pdo->query("SELECT station_id, station_name FROM mcc_stations WHERE status = 'Active' ORDER BY station_name ASC");
$activeStations = $stationsStmt->fetchAll();

// Handle selected station (default to first active station if not set)
$selectedStationId = isset($_GET['station_id']) ? intval($_GET['station_id']) : 0;
if ($selectedStationId <= 0 && !empty($activeStations)) {
    $selectedStationId = intval($activeStations[0]['station_id']);
}

$successMsg = '';
$errorMsg = '';

// 1. Handle Update General Setup
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'update_general') {
    $sanctioned = floatval($_POST['sanctioned_amount']);
    $gst = floatval($_POST['gst_percentage']);
    $startDate = $_POST['contract_start_date'];
    $endDate = $_POST['contract_end_date'];
    $agreementNo = trim($_POST['agreement_no']);

    if ($sanctioned <= 0) {
        $errorMsg = "Sanctioned amount must be greater than zero.";
    } elseif ($gst < 0 || $gst > 100) {
        $errorMsg = "GST percentage must be between 0 and 100.";
    } elseif (empty($startDate) || empty($endDate)) {
        $errorMsg = "Please specify valid contract period dates.";
    } elseif ($startDate > $endDate) {
        $errorMsg = "Contract start date cannot be later than end date.";
    } else {
        try {
            $stmt = $pdo->prepare("
                INSERT INTO mcc_billing_setup (station_id, sanctioned_amount, gst_percentage, contract_start_date, contract_end_date, agreement_no)
                VALUES (:station_id, :sanctioned, :gst, :start_date, :end_date, :agreement_no)
                ON DUPLICATE KEY UPDATE 
                    sanctioned_amount = :sanctioned2,
                    gst_percentage = :gst2,
                    contract_start_date = :start_date2,
                    contract_end_date = :end_date2,
                    agreement_no = :agreement_no2
            ");
            $stmt->execute([
                'station_id' => $selectedStationId,
                'sanctioned' => $sanctioned,
                'gst' => $gst,
                'start_date' => $startDate,
                'end_date' => $endDate,
                'agreement_no' => $agreementNo,
                'sanctioned2' => $sanctioned,
                'gst2' => $gst,
                'start_date2' => $startDate,
                'end_date2' => $endDate,
                'agreement_no2' => $agreementNo
            ]);
            $successMsg = "General billing parameters updated successfully!";
        } catch (Exception $e) {
            $errorMsg = "Database error: " . $e->getMessage();
        }
    }
}

// 2. Handle Update/Save Earning Categories (Bulk Update)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'update_earnings') {
    $earningsData = $_POST['earnings'] ?? [];
    
    // Verify sum of weightage is 100%
    $totalWeight = 0.0;
    foreach ($earningsData as $id => $data) {
        $totalWeight += floatval($data['weightage']);
    }

    if (abs($totalWeight - 100.0) > 0.01) {
        $errorMsg = "Error: The sum of weightages of the earning types is currently " . number_format($totalWeight, 2) . "%. It must equal exactly 100.00% to save.";
    } else {
        try {
            $pdo->beginTransaction();
            $stmt = $pdo->prepare("
                UPDATE mcc_billing_earnings 
                SET earning_name = :name, score_type = :type, weightage = :weight 
                WHERE id = :id AND station_id = :station_id
            ");
            foreach ($earningsData as $id => $data) {
                $scoreTypes = isset($data['score_types']) ? $data['score_types'] : [];
                $typeVal = is_array($scoreTypes) ? implode(',', $scoreTypes) : trim($scoreTypes);
                $stmt->execute([
                    'name' => $data['name'],
                    'type' => $typeVal,
                    'weight' => floatval($data['weightage']),
                    'id' => intval($id),
                    'station_id' => $selectedStationId
                ]);
            }
            $pdo->commit();
            $successMsg = "Earning categories updated successfully!";
        } catch (Exception $e) {
            $pdo->rollBack();
            $errorMsg = "Database error: " . $e->getMessage();
        }
    }
}

// 3. Handle Add New Earning Category
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'add_earning') {
    $name = trim($_POST['earning_name']);
    $types = $_POST['score_types'] ?? [];
    $weight = floatval($_POST['weightage']);

    if (empty($name)) {
        $errorMsg = "Earning description/name cannot be empty.";
    } elseif ($weight < 0) {
        $errorMsg = "Weightage cannot be negative.";
    } else {
        try {
            // Check current sum
            $sumStmt = $pdo->prepare("SELECT SUM(weightage) FROM mcc_billing_earnings WHERE station_id = :station_id");
            $sumStmt->execute(['station_id' => $selectedStationId]);
            $currentSum = floatval($sumStmt->fetchColumn());

            if ($currentSum + $weight > 100.01) {
                $errorMsg = "Cannot add earning. Total weightage would exceed 100% (currently " . number_format($currentSum, 2) . "%). Please adjust existing ones first.";
            } else {
                $typeVal = is_array($types) ? implode(',', $types) : trim($types);
                $insStmt = $pdo->prepare("
                    INSERT INTO mcc_billing_earnings (station_id, earning_name, score_type, weightage)
                    VALUES (:station_id, :name, :type, :weight)
                ");
                $insStmt->execute([
                    'station_id' => $selectedStationId,
                    'name' => $name,
                    'type' => $typeVal,
                    'weight' => $weight
                ]);
                $successMsg = "New earning category added successfully! Remember to ensure total weightage adds up to 100.00%.";
            }
        } catch (Exception $e) {
            $errorMsg = "Database error: " . $e->getMessage();
        }
    }
}

// 5. Handle Update/Save Billing Conditions
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'update_conditions') {
    $conditionsData = $_POST['conditions'] ?? [];
    try {
        $pdo->beginTransaction();
        
        // 1. Delete all existing conditions for this station
        $delStmt = $pdo->prepare("DELETE FROM mcc_billing_conditions WHERE station_id = :station_id");
        $delStmt->execute(['station_id' => $selectedStationId]);
        
        // 2. Insert new conditions
        if (!empty($conditionsData)) {
            $insStmt = $pdo->prepare("
                INSERT INTO mcc_billing_conditions (station_id, min_score, max_score, deduction_percentage, description, is_active)
                VALUES (:station_id, :min_score, :max_score, :deduction_percentage, :description, :is_active)
            ");
            foreach ($conditionsData as $cond) {
                $minScore = floatval($cond['min_score'] ?? 0);
                $maxScore = floatval($cond['max_score'] ?? 0);
                $deduction = floatval($cond['deduction_percentage'] ?? 0);
                $description = trim($cond['description'] ?? '');
                $isActive = isset($cond['is_active']) ? 1 : 0;
                
                // Skip completely empty/invalid rows
                if ($description === '') {
                    continue;
                }
                
                $insStmt->execute([
                    'station_id' => $selectedStationId,
                    'min_score' => $minScore,
                    'max_score' => $maxScore,
                    'deduction_percentage' => $deduction,
                    'description' => $description,
                    'is_active' => $isActive
                ]);
            }
        }
        
        $pdo->commit();
        $successMsg = "Billing conditions updated successfully!";
        header("Location: setup-billing.php?station_id=$selectedStationId&success_msg=" . urlencode($successMsg));
        exit();
    } catch (Exception $e) {
        $pdo->rollBack();
        $errorMsg = "Database error: " . $e->getMessage();
    }
}

// 4. Handle Delete Earning Category
if (isset($_GET['delete_earning'])) {
    $delId = intval($_GET['delete_earning']);
    try {
        $delStmt = $pdo->prepare("DELETE FROM mcc_billing_earnings WHERE id = :id AND station_id = :station_id");
        $delStmt->execute(['id' => $delId, 'station_id' => $selectedStationId]);
        $successMsg = "Earning category deleted successfully.";
        // Redirect to clean URL parameter
        header("Location: setup-billing.php?station_id=$selectedStationId&success_msg=" . urlencode($successMsg));
        exit();
    } catch (Exception $e) {
        $errorMsg = "Database error: " . $e->getMessage();
    }
}

// Fetch success msg from redirect
if (isset($_GET['success_msg'])) {
    $successMsg = $_GET['success_msg'];
}

// Fetch existing setup data
$setupStmt = $pdo->prepare("SELECT * FROM mcc_billing_setup WHERE station_id = :station_id");
$setupStmt->execute(['station_id' => $selectedStationId]);
$setupData = $setupStmt->fetch();

// Defaults if no setup row exists
if (!$setupData) {
    $setupData = [
        'sanctioned_amount' => 0.00,
        'gst_percentage' => 18.00,
        'contract_start_date' => '',
        'contract_end_date' => '',
        'agreement_no' => ''
    ];
}

// Fetch existing earning types
$earningsStmt = $pdo->prepare("SELECT * FROM mcc_billing_earnings WHERE station_id = :station_id ORDER BY id ASC");
$earningsStmt->execute(['station_id' => $selectedStationId]);
$earningsList = $earningsStmt->fetchAll();

// Calculate total weightage sum
$currentWeightSum = 0.0;
foreach ($earningsList as $earning) {
    $currentWeightSum += floatval($earning['weightage']);
}

// Fetch existing billing conditions
$conditionsStmt = $pdo->prepare("SELECT * FROM mcc_billing_conditions WHERE station_id = :station_id ORDER BY min_score DESC");
$conditionsStmt->execute(['station_id' => $selectedStationId]);
$conditionsList = $conditionsStmt->fetchAll();

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
    <!-- Content Header -->
    <div class="app-content-header py-3">
        <div class="container-fluid">
            <div class="row align-items-center">
                <div class="col-sm-6">
                    <h3 class="mb-0 font-weight-bold text-dark"><i class="bi bi-wallet2 me-2 text-indigo"></i> Setup Billing</h3>
                </div>
                <div class="col-sm-6 text-sm-end">
                    <!-- Station Selector Form -->
                    <form method="GET" id="stationForm" class="d-inline-block">
                        <label for="station_select" class="me-2 fw-bold text-secondary">Active Depot Station:</label>
                        <select name="station_id" id="station_select" class="form-select d-inline-block w-auto" onchange="document.getElementById('stationForm').submit()">
                            <?php foreach ($activeStations as $st): ?>
                                <option value="<?= $st['station_id'] ?>" <?= ($st['station_id'] == $selectedStationId) ? 'selected' : '' ?>>
                                    <?= htmlspecialchars($st['brand_text'] ?? $st['station_name']) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content Body -->
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

            <!-- Total Weightage Alert Warnings -->
            <?php if (abs($currentWeightSum - 100.0) > 0.01): ?>
                <div class="alert alert-warning shadow-sm border-start border-warning border-4" role="alert">
                    <div class="d-flex">
                        <i class="bi bi-exclamation-triangle-fill fs-4 me-3 text-warning"></i>
                        <div>
                            <h5 class="alert-heading fw-bold">Weightage Imbalance Warning</h5>
                            <p class="mb-0">
                                The sum of weightages of the earning types is currently <strong><?= number_format($currentWeightSum, 2) ?>%</strong>. 
                                It must equal exactly <strong>100.00%</strong> to allow dynamic billing invoices to print. Please adjust category weights below.
                            </p>
                        </div>
                    </div>
                </div>
            <?php endif; ?>

            <div class="row">
                <!-- Column 1: General Setup -->
                <div class="col-lg-4 mb-4">
                    <div class="card shadow-sm border-0 h-100 rounded-3">
                        <div class="card-header bg-white border-bottom py-3">
                            <h5 class="card-title mb-0 fw-bold"><i class="bi bi-gear-fill me-2 text-indigo"></i> General Contract Config</h5>
                        </div>
                        <div class="card-body">
                            <form method="POST">
                                <input type="hidden" name="action" value="update_general">
                                
                                <div class="mb-3">
                                    <label class="form-label fw-bold text-secondary">Sanctioned Amount (Total)</label>
                                    <div class="input-group">
                                        <span class="input-group-text">₹</span>
                                        <input type="number" step="0.01" name="sanctioned_amount" class="form-control" value="<?= htmlspecialchars($setupData['sanctioned_amount']) ?>" required>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold text-secondary">GST Percentage (%)</label>
                                    <div class="input-group">
                                        <input type="number" step="0.01" min="0" max="100" name="gst_percentage" class="form-control" value="<?= htmlspecialchars($setupData['gst_percentage']) ?>" required>
                                        <span class="input-group-text">%</span>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold text-secondary">M.O. / Agreement No.</label>
                                    <input type="text" name="agreement_no" class="form-control" value="<?= htmlspecialchars($setupData['agreement_no'] ?? '') ?>" required placeholder="e.g. AGR-2026-99-01">
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold text-secondary">Contract Start Date</label>
                                    <input type="date" name="contract_start_date" class="form-control" value="<?= htmlspecialchars($setupData['contract_start_date'] ?? '') ?>" required>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold text-secondary">Contract End Date</label>
                                    <input type="date" name="contract_end_date" class="form-control" value="<?= htmlspecialchars($setupData['contract_end_date'] ?? '') ?>" required>
                                </div>

                                <button type="submit" class="btn btn-indigo text-white w-100 py-2 fw-bold shadow-sm">
                                    <i class="bi bi-save me-2"></i> Save Contract Settings
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Column 2: Manage Earning Weights -->
                <div class="col-lg-8 mb-4">
                    <div class="card shadow-sm border-0 rounded-3">
                        <div class="card-header bg-white border-bottom py-3 d-flex justify-content-between align-items-center">
                            <h5 class="card-title mb-0 fw-bold"><i class="bi bi-list-check me-2 text-indigo"></i> Earning Categories & Weightages</h5>
                            <span class="badge bg-<?= abs($currentWeightSum - 100.0) < 0.01 ? 'success' : 'danger' ?> fs-6 px-3 py-2">
                                Total: <?= number_format($currentWeightSum, 2) ?>% / 100%
                            </span>
                        </div>
                        <div class="card-body p-0">
                            <?php if (empty($earningsList)): ?>
                                <div class="p-4 text-center text-muted">
                                    <i class="bi bi-info-circle fs-2 mb-2 d-block"></i>
                                    No earning categories defined for this station. Add one below to begin.
                                </div>
                            <?php else: ?>
                                <form method="POST">
                                    <input type="hidden" name="action" value="update_earnings">
                                    <div class="table-responsive">
                                        <table class="table align-middle mb-0">
                                            <thead>
                                                <tr>
                                                    <th style="width: 45%;" class="ps-3">Earning Category Name</th>
                                                    <th style="width: 30%;">Score Type Calculation Method</th>
                                                    <th style="width: 15%; text-align: center;">Weightage (%)</th>
                                                    <th style="width: 10%; text-align: center;">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <?php foreach ($earningsList as $earning): ?>
                                                    <tr>
                                                        <td class="ps-3">
                                                            <input type="text" name="earnings[<?= $earning['id'] ?>][name]" class="form-control form-control-sm border-0 border-bottom bg-transparent" value="<?= htmlspecialchars($earning['earning_name']) ?>" required>
                                                        </td>
                                                        <td>
                                                            <?php 
                                                            $selectedTypes = explode(',', $earning['score_type'] ?? ''); 
                                                            ?>
                                                            <div class="score-types-checklist shadow-sm" style="max-height: 150px; overflow-y: auto; padding: 8px; border: 1px solid #ced4da; border-radius: 6px; background: #fff; text-align: left; min-width: 250px;">
                                                                <?php
                                                                $opts = [
                                                                    'attendance' => '1. Attendance records',
                                                                    'cleanliness' => '2. Cleanliness record',
                                                                    'normal_scorecard' => '3. Normal cleaning scorecard',
                                                                    'intensive_scorecard' => '3. Intensive cleaning scorecard',
                                                                    'pldc_scorecard' => '3. PLDC cleaning scorecard',
                                                                    'prt_scorecard' => '3. PRT cleaning scorecard',
                                                                    'normal_chemical' => '4. Normal chemical consumables',
                                                                    'intensive_chemical' => '4. Intensive chemical consumables',
                                                                    'pldc_chemical' => '4. PLDC chemical consumables',
                                                                    'prt_chemical' => '4. PRT chemical consumables',
                                                                    'normal_machine' => '5. Normal machinery',
                                                                    'intensive_machine' => '5. Intensive machinery',
                                                                    'pldc_machine' => '5. PLDC machinery',
                                                                    'surprise_pit_office' => '6. Surprise Pit/Office visits',
                                                                    'surprise_pf_trains' => '6. Surprise PF/Trains visits'
                                                                ];
                                                                foreach ($opts as $val => $lbl):
                                                                    $isChecked = in_array($val, $selectedTypes) ? 'checked' : '';
                                                                    $chkId = "chk_{$earning['id']}_{$val}";
                                                                ?>
                                                                    <div class="form-check mb-1">
                                                                        <input class="form-check-input" type="checkbox" name="earnings[<?= $earning['id'] ?>][score_types][]" value="<?= $val ?>" id="<?= $chkId ?>" <?= $isChecked ?>>
                                                                        <label class="form-check-label text-dark fw-normal" for="<?= $chkId ?>" style="font-size: 0.8rem; cursor: pointer;">
                                                                            <?= $lbl ?>
                                                                        </label>
                                                                    </div>
                                                                <?php endforeach; ?>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="input-group input-group-sm w-75 mx-auto">
                                                                <input type="number" step="0.01" name="earnings[<?= $earning['id'] ?>][weightage]" class="form-control text-center earning-weight-input" value="<?= htmlspecialchars($earning['weightage']) ?>" required>
                                                                <span class="input-group-text">%</span>
                                                            </div>
                                                        </td>
                                                        <td class="text-center">
                                                            <a href="setup-billing.php?station_id=<?= $selectedStationId ?>&delete_earning=<?= $earning['id'] ?>" class="btn btn-outline-danger btn-sm rounded-3 border-0" onclick="return confirm('Are you sure you want to delete this earning category?')">
                                                                <i class="bi bi-trash-fill"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                <?php endforeach; ?>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="card-footer bg-white border-top py-3 text-end">
                                        <button type="submit" class="btn btn-indigo text-white fw-bold shadow-sm">
                                            <i class="bi bi-save-fill me-2"></i> Update Earning Weightages
                                        </button>
                                    </div>
                                </form>
                            <?php endif; ?>
                        </div>
                    </div>

                    <!-- Add New Earning Category Section -->
                    <div class="card shadow-sm border-0 mt-4 rounded-3">
                        <div class="card-header bg-white border-bottom py-3">
                            <h5 class="card-title mb-0 fw-bold text-dark"><i class="bi bi-plus-circle-fill me-2 text-indigo"></i> Add Custom Earning Category</h5>
                        </div>
                        <div class="card-body">
                            <form method="POST">
                                <input type="hidden" name="action" value="add_earning">
                                <div class="row align-items-end g-3">
                                    <div class="col-md-5">
                                        <label class="form-label fw-bold text-secondary">Earning Category Description / Name</label>
                                        <input type="text" name="earning_name" class="form-control" placeholder="e.g. Toilet Cleaning Scorecard" required>
                                    </div>
                                    <div class="col-md-4 text-start">
                                        <label class="form-label fw-bold text-secondary">Calculation Method (Tick boxes)</label>
                                        <div class="score-types-checklist shadow-sm" style="max-height: 150px; overflow-y: auto; padding: 8px; border: 1px solid #ced4da; border-radius: 6px; background: #fff;">
                                            <?php
                                            $optsAdd = [
                                                'attendance' => '1. Attendance records of the staff (staff and supervisor)',
                                                'cleanliness' => '2. Cleanliness record',
                                                'normal_scorecard' => '3. Normal cleaning score card',
                                                'intensive_scorecard' => '3. Intensive cleaning score card',
                                                'pldc_scorecard' => '3. PLDC cleaning score card',
                                                'prt_scorecard' => '3. PRT cleaning score card',
                                                'normal_chemical' => '4. Normal chemical consumables',
                                                'intensive_chemical' => '4. Intensive chemical consumables',
                                                'pldc_chemical' => '4. PLDC chemical consumables',
                                                'prt_chemical' => '4. PRT chemical consumables',
                                                'normal_machine' => '5. Normal machinery',
                                                'intensive_machine' => '5. Intensive machinery',
                                                'pldc_machine' => '5. PLDC machinery',
                                                'surprise_pit_office' => '6. Surprise Pit/Office visits',
                                                'surprise_pf_trains' => '6. Surprise PF/Trains visits'
                                            ];
                                            foreach ($optsAdd as $val => $lbl):
                                                $chkId = "add_chk_{$val}";
                                            ?>
                                                <div class="form-check mb-1">
                                                    <input class="form-check-input" type="checkbox" name="score_types[]" value="<?= $val ?>" id="<?= $chkId ?>">
                                                    <label class="form-check-label text-dark fw-normal" for="<?= $chkId ?>" style="font-size: 0.8rem; cursor: pointer;">
                                                        <?= $lbl ?>
                                                    </label>
                                                </div>
                                            <?php endforeach; ?>
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <label class="form-label fw-bold text-secondary">Weight (%)</label>
                                        <div class="input-group">
                                            <input type="number" step="0.01" min="0" max="100" name="weightage" class="form-control" placeholder="0" required>
                                            <span class="input-group-text">%</span>
                                        </div>
                                    </div>
                                    <div class="col-md-1">
                                        <button type="submit" class="btn btn-success text-white w-100 py-2 shadow-sm rounded-3">
                                            <i class="bi bi-plus-lg"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>
            </div>

            <!-- Row 3: Billing Conditions Station-Wise -->
            <div class="row mt-4">
                <div class="col-12 mb-4">
                    <div class="card shadow-sm border-0 rounded-3">
                        <div class="card-header bg-white border-bottom py-3">
                            <h5 class="card-title mb-0 fw-bold text-dark"><i class="bi bi-percent me-2 text-indigo"></i> Performance Score-Based Billing Conditions</h5>
                        </div>
                        <div class="card-body">
                            <!-- Example block as shown in the screenshot -->
                            <div class="alert alert-info border-start border-info border-3 mb-4 rounded-3 text-start p-3" role="alert" style="background-color: #f0f4f9;">
                                <div class="fw-bold mb-2 text-primary" style="font-size: 0.95rem;">Example:</div>
                                <ul class="mb-0 ps-3 text-dark" style="font-size: 0.9rem; list-style-type: disc;">
                                    <li>Score 85-100: 0% deduction (Full payment)</li>
                                    <li>Score 70-85: 5% deduction</li>
                                    <li>Score below 70: 10% deduction</li>
                                </ul>
                            </div>

                            <form method="POST" id="billingConditionsForm">
                                <input type="hidden" name="action" value="update_conditions">
                                <div class="table-responsive">
                                    <table class="table table-bordered align-middle text-start mb-0" id="conditionsTable" style="border-color: #eee;">
                                        <thead>
                                            <tr style="background-color: #f8f9fa;">
                                                <th style="width: 20%;" class="fw-bold text-secondary ps-3">Min Score</th>
                                                <th style="width: 20%;" class="fw-bold text-secondary">Max Score</th>
                                                <th style="width: 20%;" class="fw-bold text-secondary">Deduction %</th>
                                                <th style="width: 30%;" class="fw-bold text-secondary">Description</th>
                                                <th style="width: 5%;" class="text-center fw-bold text-secondary">Active</th>
                                                <th style="width: 5%;" class="text-center fw-bold text-secondary">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody id="conditionsTableBody">
                                            <?php if (!empty($conditionsList)): ?>
                                                <?php foreach ($conditionsList as $index => $cond): ?>
                                                    <tr>
                                                        <td class="ps-3">
                                                            <input type="number" step="0.01" min="0" max="100" name="conditions[<?= $index ?>][min_score]" class="form-control" value="<?= htmlspecialchars($cond['min_score']) ?>" required>
                                                        </td>
                                                        <td>
                                                            <input type="number" step="0.01" min="0" max="100" name="conditions[<?= $index ?>][max_score]" class="form-control" value="<?= htmlspecialchars($cond['max_score']) ?>" required>
                                                        </td>
                                                        <td>
                                                            <div class="input-group">
                                                                <input type="number" step="0.01" min="0" max="100" name="conditions[<?= $index ?>][deduction_percentage]" class="form-control" value="<?= htmlspecialchars($cond['deduction_percentage']) ?>" required>
                                                                <span class="input-group-text">%</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <input type="text" name="conditions[<?= $index ?>][description]" class="form-control" value="<?= htmlspecialchars($cond['description']) ?>" placeholder="e.g. Excellent Performance" required>
                                                        </td>
                                                        <td class="text-center">
                                                            <input type="checkbox" name="conditions[<?= $index ?>][is_active]" value="1" class="form-check-input" <?= $cond['is_active'] ? 'checked' : '' ?>>
                                                        </td>
                                                        <td class="text-center">
                                                            <button type="button" class="btn btn-outline-danger btn-sm rounded-3 border-0" onclick="removeConditionRow(this)">
                                                                <i class="bi bi-trash-fill"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                <?php endforeach; ?>
                                            <?php endif; ?>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="mt-3 text-start">
                                    <button type="button" class="btn btn-primary text-white fw-bold px-3 py-2 rounded-3 me-2 shadow-sm" onclick="addNewConditionRow()">
                                        <i class="bi bi-plus-lg me-1"></i> Add New Condition
                                    </button>
                                    <button type="submit" class="btn btn-success text-white fw-bold px-3 py-2 rounded-3 me-2 shadow-sm">
                                        Save Conditions
                                    </button>
                                    <button type="button" class="btn btn-secondary text-white fw-bold px-3 py-2 rounded-3 shadow-sm" onclick="window.location.reload()">
                                        Cancel
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

<script>
let conditionRowIndex = <?= count($conditionsList) ?>;

function addNewConditionRow() {
    const tbody = document.getElementById('conditionsTableBody');
    const tr = document.createElement('tr');
    tr.innerHTML = `
        <td class="ps-3">
            <input type="number" step="0.01" min="0" max="100" name="conditions[\${conditionRowIndex}][min_score]" class="form-control" value="0.00" required>
        </td>
        <td>
            <input type="number" step="0.01" min="0" max="100" name="conditions[\${conditionRowIndex}][max_score]" class="form-control" value="100.00" required>
        </td>
        <td>
            <div class="input-group">
                <input type="number" step="0.01" min="0" max="100" name="conditions[\${conditionRowIndex}][deduction_percentage]" class="form-control" value="0.00" required>
                <span class="input-group-text">%</span>
            </div>
        </td>
        <td>
            <input type="text" name="conditions[\${conditionRowIndex}][description]" class="form-control" value="" placeholder="e.g. Excellent Performance" required>
        </td>
        <td class="text-center">
            <input type="checkbox" name="conditions[\${conditionRowIndex}][is_active]" value="1" class="form-check-input" checked>
        </td>
        <td class="text-center">
            <button type="button" class="btn btn-outline-danger btn-sm rounded-3 border-0" onclick="removeConditionRow(this)">
                <i class="bi bi-trash-fill"></i>
            </button>
        </td>
    `;
    tbody.appendChild(tr);
    conditionRowIndex++;
}

function removeConditionRow(btn) {
    if (confirm('Are you sure you want to remove this condition? Please note that this will be deleted from the database only when you click Save Conditions.')) {
        const tr = btn.closest('tr');
        tr.remove();
    }
}

// Add a default row if the table is completely empty
document.addEventListener('DOMContentLoaded', function() {
    const tbody = document.getElementById('conditionsTableBody');
    if (tbody.children.length === 0) {
        addNewConditionRow();
    }
});
</script>

<style>
.btn-indigo {
    background-color: var(--admin-primary) !important;
    border-color: var(--admin-primary) !important;
}
.btn-indigo:hover {
    background-color: var(--admin-primary-dark) !important;
    border-color: var(--admin-primary-dark) !important;
}
.text-indigo {
    color: var(--admin-primary) !important;
}
.form-select:focus, .form-control:focus {
    border-color: var(--admin-primary) !important;
    box-shadow: 0 0 0 0.25rem rgba(99, 102, 241, 0.25) !important;
}
</style>

<?php
include 'footer.php';
?>
