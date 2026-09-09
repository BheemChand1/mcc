<?php
require_once 'auth.php';

$pageTitle = 'Biometric Manpower Summary | CDO';
$extraStyles = "";

$selectedMonth = $_GET['month'] ?? date('m');
$selectedYear = $_GET['year'] ?? date('Y');
$selectedMonth = str_pad($selectedMonth, 2, '0', STR_PAD_LEFT);
$selectedYear = intval($selectedYear);

$summaryMonthDisplay = date('F Y', strtotime("$selectedYear-$selectedMonth-01"));
$daysInMonth = cal_days_in_month(CAL_GREGORIAN, intval($selectedMonth), $selectedYear);
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
.table-wrap{overflow:auto;border:1px solid #111;margin-bottom:15px}table{width:100%;border-collapse:collapse;min-width:1020px;background:#fff}thead th{background:#062e4e;color:#fff;font-size:13px;padding:12px 10px;border:1px solid #245474;text-align:center}tbody td{font-size:13px;padding:9px 10px;border:1px solid #c8c8c8;text-align:center}tfoot td{background:#eaf2f8;font-weight:800;font-size:13px;padding:10px;border:1px solid #abc6d9;text-align:center}.report-panel{display:none}.report-panel.active{display:block}
.tag-green{color:#0e7b3e;font-weight:700}.tag-red{color:#c81e1e;font-weight:700}
@media(max-width:1100px){.meta-grid{grid-template-columns:repeat(2,minmax(180px,1fr))}.datebox{width:150px}}
@media(max-width:800px){.toolbar{padding:10px;gap:8px}.meta-grid{grid-template-columns:1fr}}
@media print{.app-header,.app-sidebar,.app-footer,.toolbar,.tabs,.no-print{display:none!important}.app-main{margin:0!important;padding:0!important}.report-shell{border:none;padding:0;background:#fff}.report-panel{display:none!important}.report-panel.active{display:block!important}.report-card{border:none}.table-wrap{border:1px solid #000}}
</style>

<main class="app-main">
  <div class="app-content">
    <div class="container-fluid">
      <section class="page">
        <!-- Filter Toolbar -->
        <form method="GET" action="biometric-summary.php" class="toolbar no-print">
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
          <a class="btn blue" href="biometric-penalty.php">Manpower Penalty</a>
          <a class="btn blue active-nav" href="biometric-summary.php">Summary</a>
        </form>

        <div class="report-shell">
          <!-- Navigation Tabs -->
          <div class="tabs no-print">
            <button class="tab-btn active" data-tab="depot">Manpower Summary for Coaching Depot</button>
            <button class="tab-btn" data-tab="prt">Manpower Summary for Platform Return Trains</button>
            <button class="tab-btn" data-tab="vb">Manpower Summary for Vande Bharat</button>
          </div>

          <!-- Depot Panel -->
          <section id="depot" class="report-panel active">
            <div class="report-card">
              <div class="report-title">Monthly Manpower Performance Summary &mdash; Coaching Depot</div>
              <div class="meta-grid">
                <div class="meta"><strong>Railway:</strong> <?= htmlspecialchars($railwayName) ?></div>
                <div class="meta"><strong>Month:</strong> <?= $summaryMonthDisplay ?></div>
                <div class="meta"><strong>Division:</strong> <?= htmlspecialchars($divisionName) ?></div>
                <div class="meta"><strong>Coaching Depot:</strong> <?= htmlspecialchars($stationName) ?></div>
                <div class="meta" style="grid-column:span 2"><strong>Contractor Name:</strong> <?= htmlspecialchars($contractorName) ?></div>
                <div class="meta"><strong>Target Monthly Manpower:</strong> <?= 25 * $daysInMonth ?></div>
                <div class="meta"><strong>Compliance Rate:</strong> <span class="tag-green">98.4%</span></div>
              </div>
              <div class="table-wrap">
                <table>
                  <thead>
                    <tr>
                      <th rowspan="2">S.No</th>
                      <th rowspan="2">Date</th>
                      <th colspan="3">Target Manpower</th>
                      <th colspan="3">Biometric Present</th>
                      <th rowspan="2">Total Shortage</th>
                      <th rowspan="2">Penalty Amount (₹)</th>
                      <th rowspan="2">Compliance</th>
                    </tr>
                    <tr>
                      <th>Shift 1</th>
                      <th>Shift 2</th>
                      <th>Shift 3</th>
                      <th>Shift 1</th>
                      <th>Shift 2</th>
                      <th>Shift 3</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php for ($d = 1; $d <= min(7, $daysInMonth); $d++): 
                      $dateStr = sprintf('%02d-%s-%d', $d, $selectedMonth, $selectedYear);
                    ?>
                    <tr>
                      <td><?= $d ?></td>
                      <td><?= $dateStr ?></td>
                      <td>8</td>
                      <td>9</td>
                      <td>8</td>
                      <td>8</td>
                      <td><?= $d === 3 ? '8' : '9' ?></td>
                      <td>8</td>
                      <td><span class="<?= $d === 3 ? 'tag-red' : 'tag-green' ?>"><?= $d === 3 ? '1' : '0' ?></span></td>
                      <td><?= $d === 3 ? '₹ 500.00' : '₹ 0.00' ?></td>
                      <td><span class="<?= $d === 3 ? 'tag-red' : 'tag-green' ?>"><?= $d === 3 ? '96.0%' : '100%' ?></span></td>
                    </tr>
                    <?php endfor; ?>
                  </tbody>
                  <tfoot>
                    <tr>
                      <td colspan="2">Period Total (Sample)</td>
                      <td>56</td>
                      <td>63</td>
                      <td>56</td>
                      <td>56</td>
                      <td>62</td>
                      <td>56</td>
                      <td class="tag-red">1</td>
                      <td class="tag-red">₹ 500.00</td>
                      <td class="tag-green">99.4%</td>
                    </tr>
                  </tfoot>
                </table>
              </div>
            </div>
          </section>

          <!-- PRT Panel -->
          <section id="prt" class="report-panel">
            <div class="report-card">
              <div class="report-title">Monthly Manpower Performance Summary &mdash; Platform Return Trains</div>
              <div class="meta-grid">
                <div class="meta"><strong>Railway:</strong> <?= htmlspecialchars($railwayName) ?></div>
                <div class="meta"><strong>Month:</strong> <?= $summaryMonthDisplay ?></div>
                <div class="meta"><strong>Division:</strong> <?= htmlspecialchars($divisionName) ?></div>
                <div class="meta"><strong>Coaching Depot:</strong> <?= htmlspecialchars($stationName) ?></div>
                <div class="meta" style="grid-column:span 2"><strong>Contractor Name:</strong> <?= htmlspecialchars($contractorName) ?></div>
                <div class="meta"><strong>Target Monthly Manpower:</strong> <?= 25 * $daysInMonth ?></div>
                <div class="meta"><strong>Compliance Rate:</strong> <span class="tag-green">100%</span></div>
              </div>
              <div class="table-wrap">
                <table>
                  <thead>
                    <tr>
                      <th rowspan="2">S.No</th>
                      <th rowspan="2">Date</th>
                      <th colspan="3">Target Manpower</th>
                      <th colspan="3">Biometric Present</th>
                      <th rowspan="2">Total Shortage</th>
                      <th rowspan="2">Penalty Amount (₹)</th>
                      <th rowspan="2">Compliance</th>
                    </tr>
                    <tr>
                      <th>Shift 1</th>
                      <th>Shift 2</th>
                      <th>Shift 3</th>
                      <th>Shift 1</th>
                      <th>Shift 2</th>
                      <th>Shift 3</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php for ($d = 1; $d <= min(7, $daysInMonth); $d++): 
                      $dateStr = sprintf('%02d-%s-%d', $d, $selectedMonth, $selectedYear);
                    ?>
                    <tr>
                      <td><?= $d ?></td>
                      <td><?= $dateStr ?></td>
                      <td>8</td>
                      <td>9</td>
                      <td>8</td>
                      <td>8</td>
                      <td>9</td>
                      <td>8</td>
                      <td><span class="tag-green">0</span></td>
                      <td>₹ 0.00</td>
                      <td><span class="tag-green">100%</span></td>
                    </tr>
                    <?php endfor; ?>
                  </tbody>
                  <tfoot>
                    <tr>
                      <td colspan="2">Period Total (Sample)</td>
                      <td>56</td>
                      <td>63</td>
                      <td>56</td>
                      <td>56</td>
                      <td>63</td>
                      <td>56</td>
                      <td class="tag-green">0</td>
                      <td>₹ 0.00</td>
                      <td class="tag-green">100%</td>
                    </tr>
                  </tfoot>
                </table>
              </div>
            </div>
          </section>

          <!-- Vande Bharat Panel -->
          <section id="vb" class="report-panel">
            <div class="report-card">
              <div class="report-title">Monthly Manpower Performance Summary &mdash; Vande Bharat</div>
              <div class="meta-grid">
                <div class="meta"><strong>Railway:</strong> <?= htmlspecialchars($railwayName) ?></div>
                <div class="meta"><strong>Month:</strong> <?= $summaryMonthDisplay ?></div>
                <div class="meta"><strong>Division:</strong> <?= htmlspecialchars($divisionName) ?></div>
                <div class="meta"><strong>Coaching Depot:</strong> <?= htmlspecialchars($stationName) ?></div>
                <div class="meta" style="grid-column:span 2"><strong>Contractor Name:</strong> <?= htmlspecialchars($contractorName) ?></div>
                <div class="meta"><strong>Target Monthly Manpower:</strong> <?= 20 * $daysInMonth ?></div>
                <div class="meta"><strong>Compliance Rate:</strong> <span class="tag-green">100%</span></div>
              </div>
              <div class="table-wrap">
                <table>
                  <thead>
                    <tr>
                      <th rowspan="2">S.No</th>
                      <th rowspan="2">Date</th>
                      <th colspan="3">Target Manpower</th>
                      <th colspan="3">Biometric Present</th>
                      <th rowspan="2">Total Shortage</th>
                      <th rowspan="2">Penalty Amount (₹)</th>
                      <th rowspan="2">Compliance</th>
                    </tr>
                    <tr>
                      <th>Shift 1</th>
                      <th>Shift 2</th>
                      <th>Shift 3</th>
                      <th>Shift 1</th>
                      <th>Shift 2</th>
                      <th>Shift 3</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php for ($d = 1; $d <= min(7, $daysInMonth); $d++): 
                      $dateStr = sprintf('%02d-%s-%d', $d, $selectedMonth, $selectedYear);
                    ?>
                    <tr>
                      <td><?= $d ?></td>
                      <td><?= $dateStr ?></td>
                      <td>7</td>
                      <td>7</td>
                      <td>6</td>
                      <td>7</td>
                      <td>7</td>
                      <td>6</td>
                      <td><span class="tag-green">0</span></td>
                      <td>₹ 0.00</td>
                      <td><span class="tag-green">100%</span></td>
                    </tr>
                    <?php endfor; ?>
                  </tbody>
                  <tfoot>
                    <tr>
                      <td colspan="2">Period Total (Sample)</td>
                      <td>49</td>
                      <td>49</td>
                      <td>42</td>
                      <td>49</td>
                      <td>49</td>
                      <td>42</td>
                      <td class="tag-green">0</td>
                      <td>₹ 0.00</td>
                      <td class="tag-green">100%</td>
                    </tr>
                  </tfoot>
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
