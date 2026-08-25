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

    $pdo->beginTransaction();
    try {
        // Query active parameters to check update list
        $pStmt = $pdo->prepare("SELECT id FROM mcc_vb_chemical_param WHERE station_id = :station_id");
        $pStmt->execute(['station_id' => $stationId]);
        $paramIds = $pStmt->fetchAll(PDO::FETCH_COLUMN);

        foreach ($paramIds as $pId) {
            $qty = isset($qtys[$pId]) ? floatval($qtys[$pId]) : 0.00;
            $penalty = isset($penalties[$pId]) ? floatval($penalties[$pId]) : 0.00;
            $penalty_qty = isset($penalty_qtys[$pId]) ? floatval($penalty_qtys[$pId]) : 1.00;

            // Check if target row already exists
            $checkStmt = $pdo->prepare("
                SELECT id FROM mcc_vb_chemical_target 
                WHERE parameter_id = :param_id AND station_id = :station_id
            ");
            $checkStmt->execute([
                'param_id' => $pId,
                'station_id' => $stationId
            ]);
            $existingId = $checkStmt->fetchColumn();

            if ($existingId) {
                $updStmt = $pdo->prepare("
                    UPDATE mcc_vb_chemical_target 
                    SET `qty(ml)` = :qty, penalty = :penalty, `penalty_qty(ml)` = :penalty_qty 
                    WHERE id = :id
                ");
                $updStmt->execute([
                    'qty' => $qty,
                    'penalty' => $penalty,
                    'penalty_qty' => $penalty_qty,
                    'id' => $existingId
                ]);
            } else {
                $insStmt = $pdo->prepare("
                    INSERT INTO mcc_vb_chemical_target (parameter_id, `qty(ml)`, penalty, `penalty_qty(ml)`, station_id) 
                    VALUES (:param_id, :qty, :penalty, :penalty_qty, :station_id)
                ");
                $insStmt->execute([
                    'param_id' => $pId,
                    'qty' => $qty,
                    'penalty' => $penalty,
                    'penalty_qty' => $penalty_qty,
                    'station_id' => $stationId
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

// Fetch active parameters and their targets
$pStmt = $pdo->prepare("
    SELECT p.id AS parameter_id, p.name AS parameter_name, p.units, t.`qty(ml)` AS qty_ml, t.penalty, t.`penalty_qty(ml)` AS penalty_qty_ml 
    FROM mcc_vb_chemical_param p
    LEFT JOIN mcc_vb_chemical_target t ON p.id = t.parameter_id AND t.station_id = :stn_id_target
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
