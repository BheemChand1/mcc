<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
require_once '../connection.php';
global $pdo;

$stationId = $_SESSION['station_id'] ?? 1;

$pageTitle = 'MCC Command Center';

include 'header.php';
include 'sidebar.php';
?>

<link rel="stylesheet" href="css/dashboard.css">

<main class="app-main">
  <div class="mcc-dashboard-shell">
    <section class="mcc-dashboard-grid">
      
      <!-- 1. KPI Row (6 Cards) -->
      <section class="mcc-kpi-row">
        <article class="mcc-kpi mcc-card mcc-cyan">
          <div class="mcc-kpi-icon">▣</div>
          <div>
            <small>COACHES CLEANED TODAY</small>
            <div class="mcc-kpi-value">647 <span>/ 699</span></div>
            <div class="mcc-kpi-sub positive">▲ 92.56% <em>vs yesterday</em></div>
          </div>
        </article>

        <article class="mcc-kpi mcc-card mcc-purple">
          <div class="mcc-kpi-icon">▣</div>
          <div>
            <small>RAKES PROCESSED</small>
            <div class="mcc-kpi-value">07 <span>/ 12</span></div>
            <div class="mcc-kpi-sub">Active Rakes</div>
          </div>
        </article>

        <article class="mcc-kpi mcc-card mcc-green">
          <div class="mcc-kpi-icon">★</div>
          <div>
            <small>AVERAGE CLEANING SCORE</small>
            <div class="mcc-kpi-value">94.2%</div>
            <div class="mcc-kpi-sub positive">▲ 3.6% <em>vs yesterday</em></div>
          </div>
        </article>

        <article class="mcc-kpi mcc-card mcc-cyan">
          <div class="mcc-kpi-icon">♟</div>
          <div>
            <small>MANPOWER PRESENT</small>
            <div class="mcc-kpi-value">309 <span>/ 326</span></div>
            <div class="mcc-kpi-sub positive">▲ 94.79%</div>
          </div>
        </article>

        <article class="mcc-kpi mcc-card mcc-amber">
          <div class="mcc-kpi-icon">♨</div>
          <div>
            <small>MACHINERY AVAILABLE</small>
            <div class="mcc-kpi-value">47 <span>/ 56</span></div>
            <div class="mcc-kpi-sub positive">▲ 83.93% <em>vs yesterday</em></div>
          </div>
        </article>

        <article class="mcc-kpi mcc-card mcc-red">
          <div class="mcc-kpi-icon">!</div>
          <div>
            <small>OPEN DEFICIENCIES</small>
            <div class="mcc-kpi-value">12</div>
            <div class="mcc-kpi-sub">High Priority</div>
          </div>
        </article>
      </section>

      <!-- 2. Command Board -->
      <section class="mcc-command mcc-card">
        <div class="mcc-panel-head">
          <h2>LIVE CLEANING OPERATIONS COMMAND BOARD</h2>
          <div class="mcc-legend">
            <span><i class="mcc-dot mcc-green-dot"></i>On Track</span>
            <span><i class="mcc-dot mcc-amber-dot"></i>At Risk</span>
            <span><i class="mcc-dot mcc-red-dot"></i>Delayed</span>
          </div>
        </div>
        <div class="mcc-ops-table-wrap">
          <table class="mcc-ops-table">
            <thead>
              <tr>
                <th>TRAIN / RAKE</th>
                <th>OPERATION TYPE</th>
                <th>LOCATION</th>
                <th>COACHES</th>
                <th>START TIME</th>
                <th>MANPOWER</th>
                <th>PROGRESS</th>
                <th>INSPECTION SCORE</th>
                <th>STATUS</th>
              </tr>
            </thead>
            <tbody id="operationsBody">
              <tr>
                <td><div class="mcc-train-cell"><span class="mcc-train-badge" style="background:#02d66f">▣</span>16231 – YPR DEMU</div></td>
                <td>MCC Normal Cleaning</td>
                <td>Pit Line 1</td>
                <td>22</td>
                <td>04:32 AM</td>
                <td>28 / 28</td>
                <td class="mcc-progress-cell">82%<div class="mcc-progress-track"><i style="width:82%"></i></div></td>
                <td>92.4%</td>
                <td><span class="mcc-status on">In Progress ›</span></td>
              </tr>
              <tr>
                <td><div class="mcc-train-cell"><span class="mcc-train-badge" style="background:#03c8ff">▣</span>16535 – KSR Bengaluru Exp</div></td>
                <td>Inspection</td>
                <td>Pit Line 2</td>
                <td>22</td>
                <td>05:10 AM</td>
                <td>30 / 30</td>
                <td class="mcc-progress-cell">100%<div class="mcc-progress-track"><i style="width:100%"></i></div></td>
                <td>94.0%</td>
                <td><span class="mcc-status inspect">Inspection ›</span></td>
              </tr>
              <tr>
                <td><div class="mcc-train-cell"><span class="mcc-train-badge" style="background:#9239e8">▣</span>PFTR OPERATIONS</div></td>
                <td>PFTR Cleaning</td>
                <td>PFTR Bay</td>
                <td>521 / 525</td>
                <td>–</td>
                <td>102 / 105</td>
                <td class="mcc-progress-cell">96%<div class="mcc-progress-track"><i style="width:96%"></i></div></td>
                <td>–</td>
                <td><span class="mcc-status on">In Progress ›</span></td>
              </tr>
              <tr>
                <td><div class="mcc-train-cell"><span class="mcc-train-badge" style="background:#f1ae00">♟</span>22833 – VANDE BHARAT</div></td>
                <td>14 Min Cleaning</td>
                <td>Platform 4</td>
                <td>16</td>
                <td>10:16 AM</td>
                <td>24 / 24</td>
                <td class="mcc-progress-cell"><div class="mcc-timer" id="vbTimer">08:32<small>Time Remaining</small></div></td>
                <td>–</td>
                <td><span class="mcc-status on">In Progress ›</span></td>
              </tr>
              <tr>
                <td><div class="mcc-train-cell"><span class="mcc-train-badge" style="background:#03aef0">▣</span>ACWP OPERATION</div></td>
                <td>ACWP Cleaning</td>
                <td>Pit Line 3</td>
                <td>Rake 01</td>
                <td>06:20 AM</td>
                <td>18 / 20</td>
                <td class="mcc-progress-cell">68%<div class="mcc-progress-track"><i style="width:68%"></i></div></td>
                <td>–</td>
                <td><span class="mcc-status risk">At Risk ›</span></td>
              </tr>
              <tr>
                <td><div class="mcc-train-cell"><span class="mcc-train-badge" style="background:#f05400">♟</span>INTENSIVE CLEANING</div></td>
                <td>MCC Intensive</td>
                <td>Pit Line 1</td>
                <td>Rake 03</td>
                <td>07:45 AM</td>
                <td>26 / 28</td>
                <td class="mcc-progress-cell">76%<div class="mcc-progress-track"><i style="width:76%"></i></div></td>
                <td>88.6%</td>
                <td><span class="mcc-status risk">At Risk ›</span></td>
              </tr>
              <tr>
                <td><div class="mcc-train-cell"><span class="mcc-train-badge" style="background:#00c56a">△</span>DEPOT CLEANING</div></td>
                <td>Depot / Yard Cleaning</td>
                <td>Yard Area</td>
                <td>–</td>
                <td>06:00 AM</td>
                <td>22 / 24</td>
                <td class="mcc-progress-cell">96%<div class="mcc-progress-track"><i style="width:96%"></i></div></td>
                <td>–</td>
                <td><span class="mcc-status on">In Progress ›</span></td>
              </tr>
            </tbody>
          </table>
        </div>
        <a href="normal-report.php" class="mcc-panel-link">VIEW ALL OPERATIONS <span>→</span></a>
      </section>

      <!-- 3. AI Insights -->
      <aside class="mcc-ai mcc-card">
        <div class="mcc-panel-head">
          <h2>AI OPERATIONS INSIGHTS</h2>
          <span class="mcc-ai-pill">AI</span>
        </div>
        <div class="mcc-ai-content">
          <div class="mcc-ai-brain" aria-hidden="true">
            <div class="mcc-brain-core"></div>
          </div>
          <div class="mcc-insight-list" id="insightList">
            <div class="mcc-insight">
              <span class="mcc-insight-icon mcc-tone-red">◴</span>
              <div>
                <strong class="mcc-tone-red">Delay Prediction</strong>
                <p>2 rakes likely to get delayed in next 2 hours</p>
              </div>
              <a href="normal-report.php">View Details</a>
            </div>
            <div class="mcc-insight">
              <span class="mcc-insight-icon mcc-tone-amber">♟</span>
              <div>
                <strong class="mcc-tone-amber">Manpower Shortage</strong>
                <p>17 staff shortage predicted for PFTR shift-2</p>
              </div>
              <a href="man-power-log.php">View Details</a>
            </div>
            <div class="mcc-insight">
              <span class="mcc-insight-icon mcc-tone-amber">▥</span>
              <div>
                <strong class="mcc-tone-amber">Low Score Risk</strong>
                <p>3 rakes predicted with score below 80%</p>
              </div>
              <a href="normal-summary.php">View Details</a>
            </div>
            <div class="mcc-insight">
              <span class="mcc-insight-icon mcc-tone-purple">⚗</span>
              <div>
                <strong class="mcc-tone-purple">Chemical Consumption</strong>
                <p>Floor cleaner consumption 23% above normal</p>
              </div>
              <a href="chemical-report.php">View Details</a>
            </div>
            <div class="mcc-insight">
              <span class="mcc-insight-icon mcc-tone-green">♧</span>
              <div>
                <strong class="mcc-tone-green">Performance Forecast</strong>
                <p>Today's Avg Cleaning Score predicted to be 94%</p>
              </div>
              <a href="scores.php">View Details</a>
            </div>
          </div>
        </div>
        <a href="scores.php" class="mcc-panel-link">VIEW ALL INSIGHTS <span>→</span></a>
      </aside>

      <!-- 4. Work Summary -->
      <section class="mcc-summary mcc-card">
        <div class="mcc-panel-head">
          <h2>TODAY'S WORK SUMMARY</h2>
        </div>
        <div class="mcc-summary-list" id="summaryList">
          <div class="mcc-summary-line">
            <span class="mcc-summary-name"><i class="mcc-summary-icon" style="background:#d0f100;color:#06202a">▣</i>MCC Normal Cleaning</span>
            <span class="mcc-summary-val">174 / 188 Coaches</span>
            <span class="mcc-summary-score">92%</span>
          </div>
          <div class="mcc-summary-line">
            <span class="mcc-summary-name"><i class="mcc-summary-icon" style="background:#16dc66;color:#06202a">▣</i>MCC Intensive Cleaning</span>
            <span class="mcc-summary-val">18 / 22 Coaches</span>
            <span class="mcc-summary-score">82%</span>
          </div>
          <div class="mcc-summary-line">
            <span class="mcc-summary-name"><i class="mcc-summary-icon" style="background:#00a4ff;color:#06202a">▣</i>PFTR Cleaning</span>
            <span class="mcc-summary-val">521 / 525 Coaches</span>
            <span class="mcc-summary-score">99%</span>
          </div>
          <div class="mcc-summary-line">
            <span class="mcc-summary-name"><i class="mcc-summary-icon" style="background:#933bff;color:#06202a">▣</i>14 Min Vande Bharat</span>
            <span class="mcc-summary-val">3 / 4 Rakes</span>
            <span class="mcc-summary-score">75%</span>
          </div>
          <div class="mcc-summary-line">
            <span class="mcc-summary-name"><i class="mcc-summary-icon" style="background:#ff4034;color:#06202a">♟</i>ACWP Operation</span>
            <span class="mcc-summary-val">5 / 6 Rakes</span>
            <span class="mcc-summary-score">83%</span>
          </div>
          <div class="mcc-summary-line">
            <span class="mcc-summary-name"><i class="mcc-summary-icon" style="background:#f0ad00;color:#06202a">△</i>Depot Cleaning</span>
            <span class="mcc-summary-val">96% Completed</span>
            <span class="mcc-summary-score"></span>
          </div>
        </div>
        <a href="normal-summary.php" class="mcc-panel-link">VIEW SUMMARY REPORT <span>→</span></a>
      </section>

      <!-- 5. Cleaning Score Trend -->
      <section class="mcc-trend mcc-card">
        <div class="mcc-panel-head">
          <h2>CLEANING SCORE TREND</h2>
          <select><option>7 Days</option><option>15 Days</option><option>30 Days</option></select>
        </div>
        <div class="mcc-line-chart">
          <div class="mcc-ylabels">
            <span>100%</span><span>90%</span><span>80%</span><span>70%</span>
          </div>
          <svg viewBox="0 0 520 160" preserveAspectRatio="none" aria-label="Cleaning score trend">
            <defs>
              <linearGradient id="mccAreaG" x1="0" y1="0" x2="0" y2="1">
                <stop offset="0" stop-color="#10caff" stop-opacity=".28"/>
                <stop offset="1" stop-color="#10caff" stop-opacity="0"/>
              </linearGradient>
            </defs>
            <g class="mcc-gridlines">
              <path d="M0 25 H520 M0 65 H520 M0 105 H520 M0 145 H520"/>
            </g>
            <path class="mcc-chart-area" d="M10,110 L75,88 L140,103 L205,72 L270,98 L335,80 L400,67 L465,86 L515,76 L515,150 L10,150 Z"/>
            <polyline class="mcc-chart-line" points="10,110 75,88 140,103 205,72 270,98 335,80 400,67 465,86 515,76"/>
            <g class="mcc-chart-points">
              <circle cx="10" cy="110" r="4"/>
              <circle cx="75" cy="88" r="4"/>
              <circle cx="140" cy="103" r="4"/>
              <circle cx="205" cy="72" r="4"/>
              <circle cx="270" cy="98" r="4"/>
              <circle cx="335" cy="80" r="4"/>
              <circle cx="400" cy="67" r="4"/>
              <circle cx="465" cy="86" r="4"/>
              <circle cx="515" cy="76" r="4"/>
            </g>
          </svg>
          <div class="mcc-xlabels">
            <span>04 Aug</span><span>05 Aug</span><span>06 Aug</span><span>07 Aug</span><span>08 Aug</span><span>09 Aug</span><span>10 Aug</span>
          </div>
          <div class="mcc-chart-legend">◆ Average Score (%)</div>
        </div>
      </section>

      <!-- 6. Manpower Deployment -->
      <section class="mcc-manpower mcc-card">
        <div class="mcc-panel-head">
          <h2>MANPOWER DEPLOYMENT</h2>
          <select><option>Today</option><option>Shift 1</option><option>Shift 2</option></select>
        </div>
        <div class="mcc-donut-wrap">
          <div class="mcc-donut mcc-manpower-donut">
            <div class="mcc-donut-center">
              <span>Total</span>
              <strong>326</strong>
            </div>
          </div>
          <div class="mcc-donut-legend" id="manpowerLegend">
            <div class="mcc-legend-row"><i style="background:#0ba95c"></i><span>MCC Normal</span><em>101 (30.9%)</em></div>
            <div class="mcc-legend-row"><i style="background:#149be0"></i><span>PFTR</span><em>105 (32.2%)</em></div>
            <div class="mcc-legend-row"><i style="background:#5a3de0"></i><span>ACWP</span><em>54 (16.6%)</em></div>
            <div class="mcc-legend-row"><i style="background:#e9a90b"></i><span>Intensive</span><em>28 (8.6%)</em></div>
            <div class="mcc-legend-row"><i style="background:#933ce3"></i><span>VB Cleaning</span><em>24 (7.4%)</em></div>
            <div class="mcc-legend-row"><i style="background:#6336a5"></i><span>Depot Cleaning</span><em>14 (4.3%)</em></div>
          </div>
        </div>
      </section>

      <!-- 7. Machinery Status -->
      <section class="mcc-machinery mcc-card">
        <div class="mcc-panel-head">
          <h2>MACHINERY STATUS</h2>
          <select><option>Today</option><option>This Week</option></select>
        </div>
        <div class="mcc-donut-wrap">
          <div class="mcc-donut mcc-machine-donut">
            <div class="mcc-donut-center">
              <span>Total</span>
              <strong>56</strong>
            </div>
          </div>
          <div class="mcc-donut-legend" id="machineLegend">
            <div class="mcc-legend-row"><i style="background:#10a95d"></i><span>Operational</span><em>47 (84%)</em></div>
            <div class="mcc-legend-row"><i style="background:#86a00d"></i><span>Under Repair</span><em>3 (5%)</em></div>
            <div class="mcc-legend-row"><i style="background:#e28b00"></i><span>Due Inspection</span><em>5 (9%)</em></div>
            <div class="mcc-legend-row"><i style="background:#e13c32"></i><span>Not Available</span><em>1 (2%)</em></div>
          </div>
        </div>
      </section>

      <!-- 8. Top Performing Trains -->
      <section class="mcc-trains mcc-card">
        <div class="mcc-panel-head">
          <h2>TOP PERFORMING TRAINS <small>(By Avg Score)</small></h2>
        </div>
        <table class="mcc-mini-table">
          <thead>
            <tr><th>Train No.</th><th>Train Name</th><th>Operation Type</th><th>Avg Score</th></tr>
          </thead>
          <tbody>
            <tr><td>16231</td><td>YPR DEMU</td><td>MCC Normal Cleaning</td><td class="score">96.4%</td></tr>
            <tr><td>16535</td><td>KSR Bengaluru Exp</td><td>MCC Normal Cleaning</td><td class="score">95.2%</td></tr>
            <tr><td>22833</td><td>Vande Bharat Exp</td><td>14 Min Cleaning</td><td class="score">94.8%</td></tr>
            <tr><td>16578</td><td>Mysuru Express</td><td>PFTR Cleaning</td><td class="score">93.6%</td></tr>
            <tr><td>16218</td><td>Mysuru - Chennai Exp</td><td>MCC Normal Cleaning</td><td class="score">92.1%</td></tr>
          </tbody>
        </table>
        <a href="scores.php" class="mcc-panel-link">VIEW ALL <span>→</span></a>
      </section>

      <!-- 9. Deficiency Overview -->
      <section class="mcc-deficiency mcc-card">
        <div class="mcc-panel-head">
          <h2>DEFICIENCY OVERVIEW</h2>
        </div>
        <div class="mcc-bar-list">
          <div><span>Toilet Area</span><b><i style="width:100%;background:#e33535"></i></b><em>4 (33%)</em></div>
          <div><span>Floor / PVC</span><b><i style="width:82%;background:#dc4f22"></i></b><em>3 (25%)</em></div>
          <div><span>Doors / Vestibule</span><b><i style="width:55%;background:#e08a00"></i></b><em>2 (17%)</em></div>
          <div><span>Berths / Seats</span><b><i style="width:55%;background:#8ea700"></i></b><em>2 (17%)</em></div>
          <div><span>Others</span><b><i style="width:30%;background:#2488e8"></i></b><em>1 (8%)</em></div>
        </div>
        <a href="cleanliness.php" class="mcc-panel-link">VIEW ALL DEFICIENCIES <span>→</span></a>
      </section>

      <!-- 10. Alerts & Notifications -->
      <section class="mcc-alerts mcc-card">
        <div class="mcc-panel-head">
          <h2>ALERTS &amp; NOTIFICATIONS</h2>
          <a href="#" style="color:var(--mcc-cyan);font-size:8px;font-weight:700;">View All</a>
        </div>
        <div class="mcc-alert-list">
          <div><span class="mcc-alert-dot mcc-red-bg">!</span><p>ACWP No. 02 – Hydraulic Issue</p><time>10:22 AM</time></div>
          <div><span class="mcc-alert-dot mcc-amber-bg">!</span><p>PFTR Bay 2 – High Water Usage</p><time>10:18 AM</time></div>
          <div><span class="mcc-alert-dot mcc-amber-bg">!</span><p>Chemical Stock – Floor Cleaner Low</p><time>10:15 AM</time></div>
          <div><span class="mcc-alert-dot mcc-green-bg">✓</span><p>Train 16231 rake cleaned with 96.4% score</p><time>10:10 AM</time></div>
          <div><span class="mcc-alert-dot mcc-blue-bg">i</span><p>Daily Work Diary Pending Approval</p><time>10:05 AM</time></div>
        </div>
      </section>

      <!-- 11. Status Bar -->
      <footer class="mcc-statusbar">
        <span>System Status: <strong class="mcc-green">● &nbsp;All Systems Operational</strong></span>
        <span>MCC performance improved by 4.6% compared to yesterday</span>
        <span>Vande Bharat 22833 completed 14 Min Cleaning with 100% compliance</span>
        <span>Safety First: Always wear PPE during cleaning operations</span>
        <span>◔ Last Data Sync: <b id="syncTime" style="color:var(--mcc-cyan)"><?= date('h:i:s A') ?></b></span>
      </footer>

    </section>
  </div>
</main>

<script>
document.addEventListener('DOMContentLoaded', function () {
    // Vande Bharat countdown timer
    let seconds = 8 * 60 + 32;
    setInterval(() => {
        seconds = Math.max(0, seconds - 1);
        const el = document.getElementById('vbTimer');
        if (el) {
            const m = String(Math.floor(seconds / 60)).padStart(2, '0');
            const s = String(seconds % 60).padStart(2, '0');
            el.innerHTML = `${m}:${s}<small>Time Remaining</small>`;
        }
    }, 1000);

    // Live Sync Clock
    setInterval(() => {
        const syncEl = document.getElementById('syncTime');
        if (syncEl) {
            syncEl.textContent = new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', second: '2-digit' });
        }
    }, 1000);
});
</script>

<?php include 'footer.php'; ?>