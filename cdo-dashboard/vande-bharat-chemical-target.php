<?php
require_once 'auth.php';

// Target month & year selection
$selectedMonth = $_GET['month'] ?? date('m');
$selectedYear = $_GET['year'] ?? date('Y');

// Standardize
$selectedMonth = str_pad($selectedMonth, 2, '0', STR_PAD_LEFT);
$selectedYear = intval($selectedYear);

$targetMonthDate = $selectedYear . "-" . $selectedMonth . "-01";

$successMsg = '';
$errorMsg = '';

// Handle save post request
if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST' && isset($_POST['save_targets'])) {
    $qtys = $_POST['qty'] ?? [];
    $penalties = $_POST['penalty'] ?? [];
    $penalty_qtys = $_POST['penalty_qty'] ?? [];
    $effectiveFrom = isset($_POST['effective_from']) ? trim($_POST['effective_from']) : date('Y-m-d');

    $pdo->beginTransaction();
    try {
        // Query active parameters to check update list
        $pStmt = $pdo->prepare("SELECT id FROM mcc_vb_chemical_param WHERE station_id = :station_id");
        $pStmt->execute(['station_id' => $stationId]);
        $paramIds = $pStmt->fetchAll(PDO::FETCH_COLUMN);

        // Prepare statements
        $findActiveStmt = $pdo->prepare("
            SELECT * FROM mcc_vb_chemical_target 
            WHERE station_id = :station_id AND parameter_id = :parameter_id AND effective_to IS NULL
            LIMIT 1
        ");

        $closeActiveStmt = $pdo->prepare("
            UPDATE mcc_vb_chemical_target 
            SET effective_to = :effective_to 
            WHERE id = :id
        ");

        $insertNewStmt = $pdo->prepare("
            INSERT INTO mcc_vb_chemical_target 
            (parameter_id, station_id, `qty(ml)`, penalty, `penalty_qty(ml)`, effective_from, effective_to) 
            VALUES (:parameter_id, :station_id, :qty, :penalty, :penalty_qty, :effective_from, NULL)
        ");

        foreach ($paramIds as $pId) {
            $newQty = isset($qtys[$pId]) ? floatval($qtys[$pId]) : 0.00;
            $newPenalty = isset($penalties[$pId]) ? floatval($penalties[$pId]) : 0.00;
            $newPenaltyQty = isset($penalty_qtys[$pId]) ? floatval($penalty_qtys[$pId]) : 1.00;

            // Find current active target
            $findActiveStmt->execute([
                'station_id' => $stationId,
                'parameter_id' => $pId
            ]);
            $currentActive = $findActiveStmt->fetch(PDO::FETCH_ASSOC);

            $needsUpdate = false;

            if ($currentActive) {
                // Compare values
                $currQty = floatval($currentActive['qty(ml)']);
                $currPenalty = floatval($currentActive['penalty']);
                $currPenaltyQty = floatval($currentActive['penalty_qty(ml)']);

                if ($currQty !== $newQty || $currPenalty !== $newPenalty || $currPenaltyQty !== $newPenaltyQty) {
                    $needsUpdate = true;
                    
                    // Close the active target. Set its effective_to to the day before the new effective date
                    $effectiveToDate = date('Y-m-d', strtotime($effectiveFrom . ' - 1 day'));
                    
                    // If the new effective date is today or in the past, ensure we don't end up with invalid ranges
                    if (strtotime($effectiveToDate) < strtotime($currentActive['effective_from'])) {
                        $effectiveToDate = $currentActive['effective_from'];
                    }

                    $closeActiveStmt->execute([
                        'effective_to' => $effectiveToDate,
                        'id' => $currentActive['id']
                    ]);
                }
            } else {
                // No active target exists yet, we definitely need to insert
                $needsUpdate = true;
            }

            if ($needsUpdate) {
                // Insert the new target record
                $insertNewStmt->execute([
                    'parameter_id' => $pId,
                    'station_id' => $stationId,
                    'qty' => $newQty,
                    'penalty' => $newPenalty,
                    'penalty_qty' => $newPenaltyQty,
                    'effective_from' => $effectiveFrom
                ]);
            }
        }

        $pdo->commit();
        $successMsg = 'Vande Bharat chemical targets successfully updated!';
    } catch (PDOException $e) {
        $pdo->rollBack();
        $errorMsg = 'Error saving chemical targets: ' . $e->getMessage();
    }
}

// Fetch active parameters and their active targets (effective_to IS NULL)
$pStmt = $pdo->prepare("
    SELECT p.id AS parameter_id, p.name AS parameter_name, p.units, t.`qty(ml)` AS qty_ml, t.penalty, t.`penalty_qty(ml)` AS penalty_qty_ml 
    FROM mcc_vb_chemical_param p
    LEFT JOIN mcc_vb_chemical_target t ON p.id = t.parameter_id AND t.station_id = :stn_id_target AND t.effective_to IS NULL
    WHERE p.station_id = :stn_id_param
    ORDER BY p.id ASC
");
$pStmt->execute([
    'stn_id_target' => $stationId,
    'stn_id_param' => $stationId
]);
$parameters = $pStmt->fetchAll();

// Fetch station details
$stationQuery = $pdo->prepare("
    SELECT s.station_name, s.contractor_name, d.division_name, z.zone_name 
    FROM mcc_stations s
    LEFT JOIN mcc_divisions d ON s.division_id = d.division_id
    LEFT JOIN mcc_zones z ON d.zone_id = z.zone_id
    WHERE s.station_id = :station_id
");
$stationQuery->execute(['station_id' => $stationId]);
$stnData = $stationQuery->fetch();

$railwayName    = strtoupper($stnData['zone_name'] ?? 'NORTH EASTERN RAILWAY');
$divisionName   = strtoupper($stnData['division_name'] ?? 'LUCKNOW - NER');
$stationName    = ucfirst($stnData['station_name'] ?? 'Gorakhpur');
$contractorName = $stnData['contractor_name'] ?? 'Prime Cleaning Services';

$pageTitle = "Vande Bharat Chemical Target Setup | MCC";

include 'header.php';
include 'sidebar.php';
?>

<style>
.table-target {
    width: 100%;
    border-collapse: collapse;
    font-size: 13px;
    background: #fff;
}
.table-target th, .table-target td {
    border: 1px solid #cbd5e1;
    padding: 8px 12px;
    text-align: center;
    vertical-align: middle;
}
.table-target thead th {
    background: #1987C6 !important;
    color: #fff !important;
    font-weight: 600;
}
.target-input {
    width: 110px;
    padding: 4px 8px;
    border: 1px solid #cbd5e1;
    border-radius: 4px;
    text-align: center;
    font-weight: 600;
}
.target-input:focus {
    outline: none;
    border-color: #1987C6;
    box-shadow: 0 0 0 2px rgba(25, 135, 198, 0.2);
}
</style>

<main class="app-main">
  <div class="app-content py-4">
    <div class="container-fluid">
      
      <!-- Meta Information Banner -->
      <div class="mb-4 text-center no-print" style="font-size: 0.85rem; color: #475569; background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 8px; padding: 8px 16px;">
        <span class="me-4"><strong>Depot Station:</strong> <span class="text-primary fw-bold"><?= htmlspecialchars($stationName); ?></span></span>
        <span class="me-4"><strong>Division Name:</strong> <span class="text-dark fw-bold"><?= htmlspecialchars($divisionName); ?></span></span>
        <span class="me-4"><strong>Railway Zone:</strong> <span class="text-dark fw-bold"><?= htmlspecialchars($railwayName); ?></span></span>
        <span><strong>Contractor Agency:</strong> <span class="text-success fw-bold"><?= htmlspecialchars($contractorName); ?></span></span>
      </div>

      <?php if (!empty($successMsg)): ?>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
          <i class="bi bi-check-circle-fill me-2"></i> <?= htmlspecialchars($successMsg) ?>
          <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
      <?php endif; ?>

      <?php if (!empty($errorMsg)): ?>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
          <i class="bi bi-exclamation-triangle-fill me-2"></i> <?= htmlspecialchars($errorMsg) ?>
          <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
      <?php endif; ?>

      <div class="card border-0 bg-white shadow-sm" style="border-radius: 12px; overflow: hidden; border: 1px solid #e2e8f0;">
        <div class="card-header bg-white py-3 border-bottom d-flex align-items-center justify-content-between flex-wrap gap-2">
          <h5 class="mb-0 font-weight-bold text-dark d-flex align-items-center">
            <i class="bi bi-sliders text-primary me-2"></i>
            Vande Bharat Chemical Target & Penalty Configuration
          </h5>
          <div class="d-flex align-items-center gap-2">
            <a href="vande-bharat-chemical.php" class="btn btn-outline-secondary btn-sm fw-bold">
              <i class="bi bi-arrow-left me-1"></i> Back to Report
            </a>
          </div>
        </div>
        <div class="card-body p-4">
          <form method="POST" action="vande-bharat-chemical-target.php">
            <input type="hidden" name="save_targets" value="1">
            
            <div style="margin-bottom: 20px; display: flex; align-items: center; gap: 10px;" class="no-print">
                <label style="font-weight: 700; font-size: 14px; color: #334155; margin: 0;">Effective From:</label>
                <input type="date" name="effective_from" style="border: 1px solid #cbd5e1; border-radius: 6px; padding: 6px 12px; font-size: 14px; background-color: #f8fafc; color: #334155; width: 180px; height: 38px; outline: none;" value="<?= htmlspecialchars(date('Y-m-d')) ?>" required>
            </div>

            <div class="table-responsive">
              <table class="table-target">
                <thead>
                  <tr>
                    <th style="width: 50px;">S.No</th>
                    <th style="text-align: left;">Chemical Name</th>
                    <th style="width: 100px;">Units</th>
                    <th style="width: 150px;">Target Qty (Per Coach)</th>
                    <th style="width: 150px;">Penalty Rate (Rs.)</th>
                    <th style="width: 150px;">Penalty Qty Unit</th>
                  </tr>
                </thead>
                <tbody>
                  <?php $sNo = 1; foreach ($parameters as $p): $pId = $p['parameter_id']; ?>
                    <tr>
                      <td><?= $sNo++ ?></td>
                      <td style="text-align: left; font-weight: 500;"><?= htmlspecialchars($p['parameter_name']) ?></td>
                      <td><?= htmlspecialchars($p['units'] ?? 'ml') ?></td>
                      <td>
                        <input type="number" step="0.01" min="0" class="target-input" name="qty[<?= $pId ?>]" value="<?= htmlspecialchars($p['qty_ml'] ?? '0.00') ?>">
                      </td>
                      <td>
                        <input type="number" step="0.01" min="0" class="target-input" name="penalty[<?= $pId ?>]" value="<?= htmlspecialchars($p['penalty'] ?? '0.00') ?>">
                      </td>
                      <td>
                        <input type="number" step="0.01" min="0" class="target-input" name="penalty_qty[<?= $pId ?>]" value="<?= htmlspecialchars($p['penalty_qty_ml'] ?? '1.00') ?>">
                      </td>
                    </tr>
                  <?php endforeach; ?>
                </tbody>
              </table>
            </div>

            <div class="text-end mt-4">
              <button type="submit" class="btn btn-primary px-4 fw-bold shadow-sm">
                <i class="bi bi-save me-1"></i> Save Changes
              </button>
            </div>
          </form>
        </div>
      </div>

    </div>
  </div>
</main>

<?php include 'footer.php'; ?>
