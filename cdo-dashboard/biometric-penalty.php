<?php
require_once 'auth.php';

$pageTitle = 'Biometric Manpower Penalty | CDO';
$extraStyles = "";

$selectedMonth = $_GET['month'] ?? date('m');
$selectedYear = $_GET['year'] ?? date('Y');
$selectedMonth = str_pad($selectedMonth, 2, '0', STR_PAD_LEFT);
$selectedYear = intval($selectedYear);

$penaltyMonthDisplay = date('F Y', strtotime("$selectedYear-$selectedMonth-01"));
?>

<?php include 'header.php'; ?>
<?php include 'sidebar.php'; ?>

<style>
.page{padding:20px 20px 14px}
.toolbar{display:flex;align-items:center;gap:10px;flex-wrap:nowrap;overflow-x:auto;background:#fff;border:1px solid #dce2e7;border-radius:11px;padding:12px 16px;box-shadow:0 3px 12px rgba(0,0,0,.15);margin-bottom:28px}
.toolbar label{font-weight:700;font-size:14px}
.datebox, .selectbox{height:38px;width:140px;border:1.5px solid #0d5584;border-radius:3px;padding:0 12px;font-weight:700;background:#fff}
.btn{height:38px;border:none;border-radius:7px;padding:0 16px;color:#fff;font-weight:700;cursor:pointer;box-shadow:0 2px 5px rgba(0,0,0,.12);display:inline-flex;align-items:center;justify-content:center;text-decoration:none;white-space:nowrap;flex-shrink:0}
.btn.cyan{background:#14aee8}.btn.dark{background:#053151}.btn.blue{background:#188fc4;border:1px solid #0c638f}.btn.active-nav{background:#053151;border:1px solid #053151}
.report-shell{background:#eee;border:1px solid #b9b9b9;padding:12px 10px 14px;min-height:680px}
.tabs{display:flex;gap:2px;margin:0 0 16px;padding:0 2px}
.tab-btn{border:1px solid #0c527d;background:#eaf2f8;color:#0b3551;padding:12px 18px;font-weight:800;cursor:pointer;border-radius:8px 8px 0 0;font-size:14px;white-space:nowrap}
.tab-btn.active{background:#062f50;color:#fff;border-color:#062f50}
.report-card{background:#fff;border:1px solid #c7c7c7;padding:14px 10px 0}
.report-title{text-align:center;font-size:23px;font-weight:800;margin:4px 0 22px}
.meta-grid{display:grid;grid-template-columns:repeat(4,minmax(180px,1fr));gap:13px 28px;max-width:1080px;margin:0 auto 18px;font-size:13px}
.meta{display:flex;justify-content:center;gap:5px;white-space:nowrap}.meta strong{font-weight:800}
.table-wrap{overflow:auto;border:1px solid #111;margin-bottom:15px}table{width:100%;border-collapse:collapse;min-width:960px;background:#fff}thead th{background:#062e4e;color:#fff;font-size:13px;padding:12px 10px;border:1px solid #245474;text-align:center}tbody td{font-size:13px;padding:9px 10px;border:1px solid #c8c8c8;text-align:center}tbody td.name{text-align:left;font-weight:700}.report-panel{display:none}.report-panel.active{display:block}
.penalty-input{width:110px;height:32px;text-align:right;font-weight:700;border:1px solid #c83232;border-radius:4px;padding:0 8px;color:#a81c1c}
@media(max-width:1100px){.meta-grid{grid-template-columns:repeat(2,minmax(180px,1fr))}.datebox{width:150px}}
@media(max-width:800px){.toolbar{padding:10px;gap:8px}.meta-grid{grid-template-columns:1fr}}
@media print{.app-header,.app-sidebar,.app-footer,.toolbar,.tabs,.no-print{display:none!important}.app-main{margin:0!important;padding:0!important}.report-shell{border:none;padding:0;background:#fff}.report-panel{display:none!important}.report-panel.active{display:block!important}.report-card{border:none}.table-wrap{border:1px solid #000}}
</style>

<main class="app-main">
  <div class="app-content">
    <div class="container-fluid">
      <section class="page">
        <!-- Filter Toolbar -->
        <form method="GET" action="biometric-penalty.php" class="toolbar no-print">
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
          <a class="btn blue" href="biometric-target.php">Manpower Target</a>
          <a class="btn blue active-nav" href="biometric-penalty.php">Manpower Penalty</a>
          <a class="btn blue" href="biometric-summary.php">Summary</a>
        </form>

        <div class="report-shell">
          <!-- Navigation Tabs -->
          <div class="tabs no-print">
            <button class="tab-btn active" data-tab="depot">Manpower Penalty for Coaching Depot</button>
            <button class="tab-btn" data-tab="prt">Manpower Penalty for Platform Return Trains</button>
            <button class="tab-btn" data-tab="vb">Manpower Penalty for Vande Bharat</button>
          </div>

          <!-- Depot Panel -->
          <section id="depot" class="report-panel active">
            <div class="report-card">
              <div class="report-title">Manpower Penalty Schedule &mdash; Coaching Depot</div>
              <div class="meta-grid">
                <div class="meta"><strong>Railway:</strong> <?= htmlspecialchars($railwayName) ?></div>
                <div class="meta"><strong>Effective Month:</strong> <?= $penaltyMonthDisplay ?></div>
                <div class="meta"><strong>Division:</strong> <?= htmlspecialchars($divisionName) ?></div>
                <div class="meta"><strong>Coaching Depot:</strong> <?= htmlspecialchars($stationName) ?></div>
                <div class="meta" style="grid-column:span 2"><strong>Contractor Name:</strong> <?= htmlspecialchars($contractorName) ?></div>
                <div class="meta"><strong>Rule Reference:</strong> Clause 12.3</div>
                <div class="meta"><strong>Status:</strong> Active</div>
              </div>
              <div class="table-wrap">
                <table>
                  <thead>
                    <tr>
                      <th>S.No</th>
                      <th>Category / Role</th>
                      <th>Absenteeism Penalty (₹ / Person / Shift)</th>
                      <th>Improper Uniform / Missing PPE (₹ / Incident)</th>
                      <th>Late Entry / Early Exit > 30 Mins (₹ / Incident)</th>
                      <th>Remarks</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>1</td>
                      <td class="name">Supervisor / Incharge</td>
                      <td><input type="text" class="penalty-input" value="₹ 1,000.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 300.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 200.00" readonly></td>
                      <td>Mandatory in all shifts</td>
                    </tr>
                    <tr>
                      <td>2</td>
                      <td class="name">Internal Cleaning Staff</td>
                      <td><input type="text" class="penalty-input" value="₹ 500.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 200.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 100.00" readonly></td>
                      <td>Full shift duty logs required</td>
                    </tr>
                    <tr>
                      <td>3</td>
                      <td class="name">External Coach Washing Staff</td>
                      <td><input type="text" class="penalty-input" value="₹ 500.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 200.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 100.00" readonly></td>
                      <td>High-pressure safety gear check</td>
                    </tr>
                    <tr>
                      <td>4</td>
                      <td class="name">Pitline / Premises Cleaner</td>
                      <td><input type="text" class="penalty-input" value="₹ 400.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 150.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 100.00" readonly></td>
                      <td>General duty compliance</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </section>

          <!-- PRT Panel -->
          <section id="prt" class="report-panel">
            <div class="report-card">
              <div class="report-title">Manpower Penalty Schedule &mdash; Platform Return Trains</div>
              <div class="meta-grid">
                <div class="meta"><strong>Railway:</strong> <?= htmlspecialchars($railwayName) ?></div>
                <div class="meta"><strong>Effective Month:</strong> <?= $penaltyMonthDisplay ?></div>
                <div class="meta"><strong>Division:</strong> <?= htmlspecialchars($divisionName) ?></div>
                <div class="meta"><strong>Coaching Depot:</strong> <?= htmlspecialchars($stationName) ?></div>
                <div class="meta" style="grid-column:span 2"><strong>Contractor Name:</strong> <?= htmlspecialchars($contractorName) ?></div>
                <div class="meta"><strong>Rule Reference:</strong> Clause 12.3</div>
                <div class="meta"><strong>Status:</strong> Active</div>
              </div>
              <div class="table-wrap">
                <table>
                  <thead>
                    <tr>
                      <th>S.No</th>
                      <th>Category / Role</th>
                      <th>Absenteeism Penalty (₹ / Person / Shift)</th>
                      <th>Improper Uniform / Missing PPE (₹ / Incident)</th>
                      <th>Late Entry / Early Exit > 30 Mins (₹ / Incident)</th>
                      <th>Remarks</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>1</td>
                      <td class="name">PRT Platform Supervisor</td>
                      <td><input type="text" class="penalty-input" value="₹ 1,000.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 300.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 200.00" readonly></td>
                      <td>Platform turnaround presence</td>
                    </tr>
                    <tr>
                      <td>2</td>
                      <td class="name">Watering & Quick Dry Cleaner</td>
                      <td><input type="text" class="penalty-input" value="₹ 500.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 200.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 100.00" readonly></td>
                      <td>Critical train stoppage time</td>
                    </tr>
                    <tr>
                      <td>3</td>
                      <td class="name">Garbage & Bio-Toilet Clearance</td>
                      <td><input type="text" class="penalty-input" value="₹ 500.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 200.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 100.00" readonly></td>
                      <td>Immediate waste disposal protocol</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </section>

          <!-- Vande Bharat Panel -->
          <section id="vb" class="report-panel">
            <div class="report-card">
              <div class="report-title">Manpower Penalty Schedule &mdash; Vande Bharat</div>
              <div class="meta-grid">
                <div class="meta"><strong>Railway:</strong> <?= htmlspecialchars($railwayName) ?></div>
                <div class="meta"><strong>Effective Month:</strong> <?= $penaltyMonthDisplay ?></div>
                <div class="meta"><strong>Division:</strong> <?= htmlspecialchars($divisionName) ?></div>
                <div class="meta"><strong>Coaching Depot:</strong> <?= htmlspecialchars($stationName) ?></div>
                <div class="meta" style="grid-column:span 2"><strong>Contractor Name:</strong> <?= htmlspecialchars($contractorName) ?></div>
                <div class="meta"><strong>Rule Reference:</strong> Clause 12.3 (Premium)</div>
                <div class="meta"><strong>Status:</strong> Active</div>
              </div>
              <div class="table-wrap">
                <table>
                  <thead>
                    <tr>
                      <th>S.No</th>
                      <th>Category / Role</th>
                      <th>Absenteeism Penalty (₹ / Person / Shift)</th>
                      <th>Improper Uniform / Missing PPE (₹ / Incident)</th>
                      <th>Late Entry / Early Exit > 30 Mins (₹ / Incident)</th>
                      <th>Remarks</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td>1</td>
                      <td class="name">VB Premium Cleaning Incharge</td>
                      <td><input type="text" class="penalty-input" value="₹ 1,500.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 500.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 300.00" readonly></td>
                      <td>Specialized service inspection</td>
                    </tr>
                    <tr>
                      <td>2</td>
                      <td class="name">Interior & Aerodynamic Exterior Cleaner</td>
                      <td><input type="text" class="penalty-input" value="₹ 750.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 300.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 200.00" readonly></td>
                      <td>Trained automated equipment staff</td>
                    </tr>
                    <tr>
                      <td>3</td>
                      <td class="name">Executive Lounge & Washroom Attendant</td>
                      <td><input type="text" class="penalty-input" value="₹ 750.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 300.00" readonly></td>
                      <td><input type="text" class="penalty-input" value="₹ 200.00" readonly></td>
                      <td>Executive hospitality standard</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </section>
        </div>
      </section>
    </div>
  </div>
</main>

<script>
// Tab Switching
document.querySelectorAll(".tab-btn").forEach(btn => {
  btn.addEventListener("click", () => {
    document.querySelectorAll(".tab-btn").forEach(b => b.classList.remove("active"));
    document.querySelectorAll(".report-panel").forEach(p => p.classList.remove("active"));
    btn.classList.add("active");
    const targetPanel = document.getElementById(btn.dataset.tab);
    if (targetPanel) {
      targetPanel.classList.add("active");
    }
  });
});
</script>

<?php include 'footer.php'; ?>
