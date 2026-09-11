<?php
require_once 'auth.php';

$pageTitle = 'Biometric Manpower Target | CDO';
$extraStyles = "";

$selectedMonth = $_GET['month'] ?? date('m');
$selectedYear = $_GET['year'] ?? date('Y');
$selectedMonth = str_pad($selectedMonth, 2, '0', STR_PAD_LEFT);
$selectedYear = intval($selectedYear);

$targetMonthDate = "$selectedYear-$selectedMonth-01";
$targetMonthDisplay = date('F Y', strtotime($targetMonthDate));
$effectiveFromDate = "$selectedYear-$selectedMonth-01";
$effectiveToDate = date('Y-m-t', strtotime($targetMonthDate));

// 1. Fetch active designations from mcc_designation table
$desStmt = $pdo->prepare("
    SELECT id, designation_name 
    FROM mcc_designation 
    WHERE (station_id = :station_id OR station_id = 0) AND status = 'Active' 
    ORDER BY id ASC
");
$desStmt->execute(['station_id' => $stationId]);
$designations = $desStmt->fetchAll(PDO::FETCH_ASSOC);

if (empty($designations)) {
    $designations = [
        ['id' => 1, 'designation_name' => 'Unskilled'],
        ['id' => 2, 'designation_name' => 'Supervisor']
    ];
}

// 2. Fetch categories from mcc_manpower_categories
$catStmt = $pdo->prepare("
    SELECT id, category_name 
    FROM mcc_manpower_categories 
    WHERE station_id = :station_id AND status = 'Active' 
    ORDER BY order_no ASC, id ASC
");
$catStmt->execute(['station_id' => $stationId]);
$categories = $catStmt->fetchAll(PDO::FETCH_ASSOC);

if (empty($categories)) {
    $categories = [
        ['id' => 17, 'category_name' => 'Normal cleaning'],
        ['id' => 18, 'category_name' => 'Intensive Cleaning'],
        ['id' => 19, 'category_name' => 'Depot Cleaning'],
        ['id' => 20, 'category_name' => 'PRT cleaning'],
        ['id' => 21, 'category_name' => 'Vande Bharat']
    ];
}

// Check/Create biometric_manpower_target table if not exists
$tableCheck = $pdo->query("SHOW TABLES LIKE 'biometric_manpower_target'");
if ($tableCheck->rowCount() == 0) {
    $sqlBioTarget = "CREATE TABLE `biometric_manpower_target` (
        `id` INT AUTO_INCREMENT PRIMARY KEY,
        `station_id` INT NOT NULL DEFAULT 1,
        `category_id` INT NOT NULL DEFAULT 0,
        `category_name` VARCHAR(100) DEFAULT NULL,
        `designation_id` INT NOT NULL DEFAULT 0,
        `designation_name` VARCHAR(100) NOT NULL,
        `target_date` DATE NOT NULL,
        `target_qty` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
        `effective_from` DATE NULL,
        `effective_to` DATE NULL,
        `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        INDEX (`station_id`),
        INDEX (`target_date`),
        UNIQUE KEY `uq_station_cat_des_date` (`station_id`, `category_id`, `designation_name`, `target_date`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;";
    $pdo->exec($sqlBioTarget);
}

$successMsg = '';
$errorMsg = '';

// 3. Handle Save Targets POST Action
if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST' && isset($_POST['save_target'])) {
    if (!empty($isViewer)) {
        $errorMsg = "Viewers are in read-only mode and cannot modify targets.";
    } else {
        $submittedTargets = $_POST['target_qty'] ?? []; // [category_id][designation_name] => qty
        
        try {
            $pdo->beginTransaction();

            $saveStmt = $pdo->prepare("
                INSERT INTO biometric_manpower_target 
                (station_id, category_id, category_name, designation_id, designation_name, target_date, target_qty, effective_from, effective_to)
                VALUES 
                (:station_id, :category_id, :category_name, :designation_id, :designation_name, :target_date, :target_qty, :effective_from, :effective_to)
                ON DUPLICATE KEY UPDATE 
                    category_name = VALUES(category_name),
                    designation_id = VALUES(designation_id),
                    target_qty = VALUES(target_qty),
                    effective_from = VALUES(effective_from),
                    effective_to = VALUES(effective_to)
            ");

            foreach ($categories as $cat) {
                $catId = $cat['id'];
                $catName = $cat['category_name'];
                foreach ($designations as $des) {
                    $desName = $des['designation_name'];
                    $desId = $des['id'];
                    $qty = isset($submittedTargets[$catId][$desName]) ? trim($submittedTargets[$catId][$desName]) : '';
                    
                    if ($qty !== '') {
                        $targetQty = floatval($qty);
                        $saveStmt->execute([
                            'station_id'        => $stationId,
                            'category_id'       => $catId,
                            'category_name'     => $catName,
                            'designation_id'    => $desId,
                            'designation_name'  => $desName,
                            'target_date'       => $targetMonthDate,
                            'target_qty'        => $targetQty,
                            'effective_from'    => $effectiveFromDate,
                            'effective_to'      => $effectiveToDate
                        ]);
                    }
                }
            }

            $pdo->commit();
            $successMsg = "Biometric manpower targets for $targetMonthDisplay saved successfully!";
        } catch (Exception $e) {
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            $errorMsg = "Failed to save targets: " . $e->getMessage();
        }
    }
}

// 4. Fetch existing targets for the selected month/year from biometric_manpower_target
$existingTargets = [];
$targetsStmt = $pdo->prepare("
    SELECT category_id, designation_name, target_qty 
    FROM biometric_manpower_target 
    WHERE station_id = :station_id AND target_date = :target_date
");
$targetsStmt->execute([
    'station_id'  => $stationId,
    'target_date' => $targetMonthDate
]);
$targetRows = $targetsStmt->fetchAll(PDO::FETCH_ASSOC);

foreach ($targetRows as $tr) {
    $existingTargets[$tr['category_id']][strtolower(trim($tr['designation_name']))] = $tr['target_qty'];
}
?>

<?php include 'header.php'; ?>
<?php include 'sidebar.php'; ?>

<style>
.page{padding:20px 20px 14px}
.toolbar{display:flex;align-items:center;gap:10px;flex-wrap:nowrap;overflow-x:auto;background:#fff;border:1px solid #dce2e7;border-radius:11px;padding:12px 16px;box-shadow:0 3px 12px rgba(0,0,0,.15);margin-bottom:28px}
.toolbar label{font-weight:700;font-size:14px}
.selectbox{height:38px;width:175px;border:1.5px solid #0d5584;border-radius:3px;padding:0 12px;font-weight:700;background:#fff}
.btn{height:38px;border:none;border-radius:7px;padding:0 16px;color:#fff;font-weight:700;cursor:pointer;box-shadow:0 2px 5px rgba(0,0,0,.12);display:inline-flex;align-items:center;justify-content:center;text-decoration:none;white-space:nowrap;flex-shrink:0}
.btn.cyan{background:#14aee8}.btn.dark{background:#053151}.btn.blue{background:#188fc4;border:1px solid #0c638f}.btn.green{background:#15803d;border:1px solid #166534}
.report-shell{background:#eee;border:1px solid #b9b9b9;padding:12px 10px 14px;min-height:680px}
.report-card{background:#fff;border:1px solid #c7c7c7;padding:14px 10px 20px}
.report-title{text-align:center;font-size:23px;font-weight:800;margin:4px 0 22px}
.meta-grid{display:grid;grid-template-columns:repeat(4,minmax(180px,1fr));gap:13px 28px;max-width:1080px;margin:0 auto 18px;font-size:13px}
.meta{display:flex;justify-content:center;gap:5px;white-space:nowrap}.meta strong{font-weight:800}
.table-wrap{overflow:auto;border:1px solid #111;margin-bottom:15px}
table{width:100%;border-collapse:collapse;min-width:960px;background:#fff}
thead th{background:#062e4e;color:#fff;font-size:13px;padding:12px 10px;border:1px solid #245474;text-align:center}
tbody td{font-size:13px;padding:9px 10px;border:1px solid #c8c8c8;text-align:center}
tbody td.name{text-align:left;font-weight:700}
.shift-row td{background:#e8f2fb;color:#073957;font-weight:800;text-align:left;padding:8px 11px;border-color:#abc6d9}
.target-input{height:34px;width:100%;max-width:320px;border:1.5px solid #0d5584;border-radius:3px;padding:0 12px;font-weight:600;font-size:13px;background:#fff;outline:none}
.target-input:focus{border-color:#14aee8;box-shadow:0 0 0 2px rgba(20,174,232,0.2)}
.action-row{margin:20px 0 10px;text-align:center}
.alert-box{padding:12px 16px;border-radius:6px;margin-bottom:18px;font-weight:600;font-size:14px}
.alert-success{background-color:#d1fae5;color:#065f46;border:1px solid #a7f3d0}
.alert-danger{background-color:#fee2e2;color:#991b1b;border:1px solid #fecaca}
@media(max-width:1100px){.meta-grid{grid-template-columns:repeat(2,minmax(180px,1fr))}.selectbox{width:210px}}
@media(max-width:800px){.toolbar{padding:10px;gap:8px}.selectbox{width:150px}.meta-grid{grid-template-columns:1fr}}
@media print{.app-header,.app-sidebar,.app-footer,.toolbar,.no-print{display:none!important}.app-main{margin:0!important;padding:0!important}.report-shell{border:none;padding:0;background:#fff}.report-card{border:none}.table-wrap{border:1px solid #000}.target-input{border:none;background:transparent}}
</style>

<main class="app-main">
  <div class="app-content">
    <div class="container-fluid">
      <section class="page">
        <!-- Filter Toolbar -->
        <form method="GET" action="biometric-target.php" class="toolbar no-print">
          <label for="month">Month:</label>
          <select id="month" name="month" class="selectbox">
            <?php for ($m = 1; $m <= 12; $m++): ?>
              <option value="<?= str_pad($m, 2, '0', STR_PAD_LEFT) ?>" <?= $selectedMonth == str_pad($m, 2, '0', STR_PAD_LEFT) ? 'selected' : '' ?>>
                <?= date('F', mktime(0, 0, 0, $m, 1)) ?>
              </option>
            <?php endfor; ?>
          </select>

          <label for="year">Year:</label>
          <select id="year" name="year" class="selectbox">
            <?php for ($y = date('Y') - 2; $y <= date('Y') + 2; $y++): ?>
              <option value="<?= $y ?>" <?= $selectedYear == $y ? 'selected' : '' ?>><?= $y ?></option>
            <?php endfor; ?>
          </select>
          
          <button type="submit" class="btn cyan">Go</button>
          <button type="button" class="btn dark" onclick="window.print()">Print</button>
          <a class="btn blue" href="biometeric_manpower_log.php">Manpower Log</a>
          <a class="btn blue" href="biometric-target.php" style="background:#053151;">Manpower Target</a>
          <!-- <a class="btn blue" href="biometric-penalty.php">Manpower Penalty</a>
          <a class="btn blue" href="biometric-summary.php">Summary</a> -->
        </form>

        <div class="report-shell">
          <div class="report-card">
            <div class="report-title">Biometric Manpower Target</div>
            
            <?php if (!empty($successMsg)): ?>
              <div class="alert-box alert-success no-print"><?= htmlspecialchars($successMsg) ?></div>
            <?php endif; ?>
            <?php if (!empty($errorMsg)): ?>
              <div class="alert-box alert-danger no-print"><?= htmlspecialchars($errorMsg) ?></div>
            <?php endif; ?>

            <div class="meta-grid">
              <div class="meta"><strong>Railway:</strong> <?= htmlspecialchars($railwayName) ?></div>
              <div class="meta"><strong>Effective Month:</strong> <?= $targetMonthDisplay ?></div>
              <div class="meta"><strong>Division:</strong> <?= htmlspecialchars($divisionName) ?></div>
              <div class="meta"><strong>Coaching Depot:</strong> <?= htmlspecialchars($stationName) ?></div>
              <div class="meta" style="grid-column:span 2"><strong>Contractor Name:</strong> <?= htmlspecialchars($contractorName) ?></div>
              <div class="meta"><strong>Status:</strong> Active</div>
              <div class="meta"><strong>Effective Date:</strong> 01-<?= $selectedMonth ?>-<?= $selectedYear ?></div>
            </div>

            <!-- Dynamic Target Rate Table Loaded from mcc_designation -->
            <form method="POST" action="">
              <input type="hidden" name="save_target" value="1">
              <div class="table-wrap">
                <table>
                  <thead>
                    <tr>
                      <th style="width: 50%; text-align: left; padding-left: 20px;">Categories</th>
                      <th style="width: 50%; text-align: center;">Target Rate</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php foreach ($categories as $cat): 
                        $catId = $cat['id'];
                    ?>
                      <!-- Category Header -->
                      <tr class="shift-row">
                        <td colspan="2"><?= htmlspecialchars($cat['category_name']) ?></td>
                      </tr>

                      <!-- Dynamic Designations from mcc_designation -->
                      <?php foreach ($designations as $des): 
                          $desName = $des['designation_name'];
                          $lookupKey = strtolower(trim($desName));
                          $val = isset($existingTargets[$catId][$lookupKey]) ? $existingTargets[$catId][$lookupKey] : '';
                      ?>
                        <tr>
                          <td class="name" style="padding-left: 30px;"><?= htmlspecialchars($desName) ?></td>
                          <td>
                            <input 
                              type="number" 
                              step="0.01" 
                              min="0"
                              name="target_qty[<?= $catId ?>][<?= htmlspecialchars($desName) ?>]" 
                              value="<?= $val !== '' ? htmlspecialchars($val) : '' ?>" 
                              placeholder="Enter target rate"
                              class="target-input"
                              <?= !empty($isViewer) ? 'readonly' : '' ?>
                            >
                          </td>
                        </tr>
                      <?php endforeach; ?>
                    <?php endforeach; ?>
                  </tbody>
                </table>
              </div>

              <?php if (empty($isViewer)): ?>
                <div class="action-row no-print">
                  <button type="submit" class="btn green" style="padding: 0 32px; font-size: 14px;">
                    Save Targets
                  </button>
                </div>
              <?php endif; ?>
            </form>

          </div>
        </div>
      </section>
    </div>
  </div>
</main>

<?php include 'footer.php'; ?>
