<?php
require_once 'auth.php';

$pageTitle = 'Biometric Manpower Target | CDO';
$extraStyles = "";

$selectedMonth = $_GET['month'] ?? date('m');
$selectedYear = $_GET['year'] ?? date('Y');
$selectedMonth = str_pad($selectedMonth, 2, '0', STR_PAD_LEFT);
$selectedYear = intval($selectedYear);

$targetMonthDisplay = date('F Y', strtotime("$selectedYear-$selectedMonth-01"));
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
table{width:100%;border-collapse:collapse;min-width:1010px;background:#fff}
thead th{background:#062e4e;color:#fff;font-size:13px;padding:12px 10px;border:1px solid #245474;text-align:center}
tbody td{font-size:13px;padding:9px 10px;border:1px solid #c8c8c8;text-align:center}
tbody td.name{text-align:left;font-weight:700}
.shift-row td{background:#e8f2fb;color:#073957;font-weight:800;text-align:left;padding:8px 11px;border-color:#abc6d9}
.target-input{height:34px;width:100%;max-width:320px;border:1.5px solid #0d5584;border-radius:3px;padding:0 12px;font-weight:600;font-size:13px;background:#fff;outline:none}
.target-input:focus{border-color:#14aee8;box-shadow:0 0 0 2px rgba(20,174,232,0.2)}
.action-row{margin:20px 0 10px;text-align:center}
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
            
            <div class="meta-grid">
              <div class="meta"><strong>Railway:</strong> <?= htmlspecialchars($railwayName) ?></div>
              <div class="meta"><strong>Effective Month:</strong> <?= $targetMonthDisplay ?></div>
              <div class="meta"><strong>Division:</strong> <?= htmlspecialchars($divisionName) ?></div>
              <div class="meta"><strong>Coaching Depot:</strong> <?= htmlspecialchars($stationName) ?></div>
              <div class="meta" style="grid-column:span 2"><strong>Contractor Name:</strong> <?= htmlspecialchars($contractorName) ?></div>
              <div class="meta"><strong>Status:</strong> Active</div>
              <div class="meta"><strong>Effective Date:</strong> 01-<?= $selectedMonth ?>-<?= $selectedYear ?></div>
            </div>

            <!-- Target Rate Table matching Full-Width CDO Theme -->
            <form method="POST" action="">
              <div class="table-wrap">
                <table>
                  <thead>
                    <tr>
                      <th style="width: 50%; text-align: left; padding-left: 20px;">Categories</th>
                      <th style="width: 50%; text-align: center;">Target Rate</th>
                    </tr>
                  </thead>
                  <tbody>
                    <!-- Normal cleaning -->
                    <tr class="shift-row">
                      <td colspan="2">Normal cleaning</td>
                    </tr>
                    <tr>
                      <td class="name" style="padding-left: 30px;">unskilled</td>
                      <td>
                        <input type="text" name="target[normal][unskilled]" class="target-input">
                      </td>
                    </tr>
                    <tr>
                      <td class="name" style="padding-left: 30px;">sup.</td>
                      <td>
                        <input type="text" name="target[normal][sup]" class="target-input">
                      </td>
                    </tr>

                    <!-- Intensive cleaning -->
                    <tr class="shift-row">
                      <td colspan="2">Intensive cleaning</td>
                    </tr>
                    <tr>
                      <td class="name" style="padding-left: 30px;">unskilled</td>
                      <td>
                        <input type="text" name="target[intensive][unskilled]" class="target-input">
                      </td>
                    </tr>

                    <!-- Depot cleaning -->
                    <tr class="shift-row">
                      <td colspan="2">Depot cleaning</td>
                    </tr>
                    <tr>
                      <td class="name" style="padding-left: 30px;">unskilled</td>
                      <td>
                        <input type="text" name="target[depot][unskilled]" class="target-input">
                      </td>
                    </tr>
                    <tr>
                      <td class="name" style="padding-left: 30px;">sup.</td>
                      <td>
                        <input type="text" name="target[depot][sup]" class="target-input">
                      </td>
                    </tr>

                    <!-- PFTA cleaning -->
                    <tr class="shift-row">
                      <td colspan="2">PFTA cleaning</td>
                    </tr>
                    <tr>
                      <td class="name" style="padding-left: 30px;">unskilled</td>
                      <td>
                        <input type="text" name="target[pfta][unskilled]" class="target-input">
                      </td>
                    </tr>
                    <tr>
                      <td class="name" style="padding-left: 30px;">sup.</td>
                      <td>
                        <input type="text" name="target[pfta][sup]" class="target-input">
                      </td>
                    </tr>

                    <!-- vb -->
                    <tr class="shift-row">
                      <td colspan="2">vb</td>
                    </tr>
                    <tr>
                      <td class="name" style="padding-left: 30px;">unskilled</td>
                      <td>
                        <input type="text" name="target[vb][unskilled]" class="target-input">
                      </td>
                    </tr>
                    <tr>
                      <td class="name" style="padding-left: 30px;">sup.</td>
                      <td>
                        <input type="text" name="target[vb][sup]" class="target-input">
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

              <div class="action-row no-print">
                <button type="submit" class="btn green" style="padding: 0 32px; font-size: 14px;">
                  Save Targets
                </button>
              </div>
            </form>

          </div>
        </div>
      </section>
    </div>
  </div>
</main>

<?php include 'footer.php'; ?>
