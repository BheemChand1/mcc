<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
require_once '../connection.php';

$stationId = $_SESSION['station_id'] ?? 1;

// Fetch assigned report keys for this station
$assigned_reports = [];
try {
    $stmt = $pdo->prepare("SELECT report_key FROM mcc_station_reports WHERE station_id = :station_id");
    $stmt->execute(['station_id' => $stationId]);
    $assigned_reports = $stmt->fetchAll(PDO::FETCH_COLUMN);
} catch (PDOException $e) {
    // Fallback to empty array
}

// Metadata for report keys
$reportMetadata = [
    'normal_audit' => [
        'label' => 'Normal Audit Score',
        'score' => '86.4%',
        'icon' => 'bi bi-droplet-half',
        'color' => '#3c8dbc',
        'foot' => 'Target: 85.0%'
    ],
    'normal_chem' => [
        'label' => 'Normal Chemical Usage',
        'score' => '94.2%',
        'icon' => 'bi bi-droplet',
        'color' => '#2f78a5',
        'foot' => 'Optimal Consumption'
    ],
    'normal_mach' => [
        'label' => 'Normal Machine Log',
        'score' => '89.0%',
        'icon' => 'bi bi-gear',
        'color' => '#4fa3d1',
        'foot' => 'Availability Rate'
    ],
    'int_audit' => [
        'label' => 'Intensive Audit Score',
        'score' => '88.5%',
        'icon' => 'bi bi-stars',
        'color' => '#6366f1',
        'foot' => 'Target: 90.0%'
    ],
    'int_chem' => [
        'label' => 'Intensive Chem Usage',
        'score' => '91.8%',
        'icon' => 'bi bi-clipboard-data',
        'color' => '#4f46e5',
        'foot' => 'Compliance Level'
    ],
    'int_scorecard_2' => [
        'label' => 'Intensive Scorecard 2',
        'score' => '91.0%',
        'icon' => 'bi bi-card-checklist',
        'color' => '#6366f1',
        'foot' => 'Annexure A-2 Audit'
    ],
    'int_pantry' => [
        'label' => 'Pantry Car Scorecard',
        'score' => '94.5%',
        'icon' => 'bi bi-cup-hot',
        'color' => '#0891b2',
        'foot' => 'Pantry Audit'
    ],
    'int_mach' => [
        'label' => 'Intensive Machine Log',
        'score' => '95.0%',
        'icon' => 'bi bi-cpu',
        'color' => '#4338ca',
        'foot' => 'Availability Rate'
    ],
    'pldc_audit' => [
        'label' => 'PLDC Audit Score',
        'score' => '92.5%',
        'icon' => 'bi bi-shield-check',
        'color' => '#10b981',
        'foot' => 'Target: 90.0%'
    ],
    'pldc_chem' => [
        'label' => 'PLDC Chem Usage',
        'score' => '87.3%',
        'icon' => 'bi bi-flask',
        'color' => '#059669',
        'foot' => 'Standard compliance'
    ],
    'pldc_mach' => [
        'label' => 'PLDC Machine Log',
        'score' => '93.0%',
        'icon' => 'bi bi-wrench',
        'color' => '#047857',
        'foot' => 'Availability Rate'
    ],
    'prt_audit' => [
        'label' => 'PRT Audit Score',
        'score' => '85.7%',
        'icon' => 'bi bi-arrow-repeat',
        'color' => '#f59e0b',
        'foot' => 'Target: 80.0%'
    ],
    'prt_chem' => [
        'label' => 'PRT Chem Usage',
        'score' => '90.2%',
        'icon' => 'bi bi-funnel',
        'color' => '#d97706',
        'foot' => 'Optimal consumption'
    ],
    'sur_pit' => [
        'label' => 'Surprise Pit & Office',
        'score' => '82.0%',
        'icon' => 'bi bi-patch-check-fill',
        'color' => '#ef4444',
        'foot' => 'Target: 80.0%'
    ],
    'sur_pf' => [
        'label' => 'Surprise PF Trains',
        'score' => '84.3%',
        'icon' => 'bi bi-train-front',
        'color' => '#dc2626',
        'foot' => 'Target: 80.0%'
    ],
    'manpower' => [
        'label' => 'Manpower Attendance',
        'score' => '96.5%',
        'icon' => 'bi bi-people',
        'color' => '#8b5cf6',
        'foot' => 'Target: 95.0%'
    ],
    'cleanliness' => [
        'label' => 'Cleanliness Scorecard',
        'score' => '92.4%',
        'icon' => 'bi bi-stars',
        'color' => '#10b981',
        'foot' => 'Target: 90.0%'
    ],
    'photo_report' => [
        'label' => 'Photo Reports',
        'score' => '100%',
        'icon' => 'bi bi-camera',
        'color' => '#f59e0b',
        'foot' => 'Target: Before/After'
    ],
    'vb_audit' => [
        'label' => 'Vande Bharat Score Card',
        'score' => '95.2%',
        'icon' => 'bi bi-lightning-charge',
        'color' => '#0284c7',
        'foot' => 'Target: 95.0%'
    ],
    'vb_chem' => [
        'label' => 'Vande Bharat Chemical',
        'score' => '93.8%',
        'icon' => 'bi bi-flask',
        'color' => '#0ea5e9',
        'foot' => 'Optimal consumption'
    ],
    'vb_mach' => [
        'label' => 'Vande Bharat Machine Log',
        'score' => '96.0%',
        'icon' => 'bi bi-cpu',
        'color' => '#38bdf8',
        'foot' => 'Availability Rate'
    ]
];

$recentChecks = [
  ['zone' => 'Platform 1', 'time' => '10:30 AM', 'status' => 'Completed', 'status_class' => 'status-good'],
  ['zone' => 'Waiting Hall', 'time' => '11:15 AM', 'status' => 'In Progress', 'status_class' => 'status-warn'],
  ['zone' => 'Toilet Block A', 'time' => '09:45 AM', 'status' => 'Action Required', 'status_class' => 'status-alert'],
  ['zone' => 'Concourse Area', 'time' => '12:00 PM', 'status' => 'Scheduled', 'status_class' => 'status-good'],
];

$pageTitle = 'Auditor Dashboard';
$extraStyles = '
        :root {
            --panel-bg: #ffffff;
            --panel-border: #e2e8f0;
            --muted: #64748b;
            --title: #0f172a;
            --soft-bg: #f8fafc;
            --accent: #3c8dbc;
            --accent2: #2f78a5;
        }


        body, html {
            height: auto !important;
            overflow: visible !important;
        }

        .app-main {
            height: auto !important;
            min-height: calc(100vh - 60px);
            overflow: visible !important;
        }

        .app-content {
            height: auto !important;
        }

        .dashboard-wrap {
            height: 100%;
            padding: 10px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .kpi-row {
            flex: 0 0 auto;
        }

        .content-row {
            flex: 1;
            min-height: 0;
            display: flex;
            gap: 10px;
        }

        .kpi-card {
            background: var(--panel-bg);
            border: 1px solid var(--panel-border);
            border-radius: 10px;
            padding: 10px;
            box-shadow: 0 2px 8px rgba(15, 23, 42, 0.05);
            height: 100%;
        }

        .kpi-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 5px;
        }

        .kpi-label {
            font-size: 11px;
            font-weight: 600;
            color: var(--muted);
            text-transform: uppercase;
        }

        .kpi-icon {
            width: 28px;
            height: 28px;
            border-radius: 7px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-size: 14px;
        }

        .kpi-value {
            font-size: 22px;
            font-weight: 700;
            color: var(--title);
            line-height: 1;
        }

        .kpi-foot {
            margin-top: 4px;
            font-size: 10px;
            color: var(--muted);
        }

        .panel-card {
            background: var(--panel-bg);
            border: 1px solid var(--panel-border);
            border-radius: 10px;
            padding: 12px;
            box-shadow: 0 2px 8px rgba(15, 23, 42, 0.04);
            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .panel-title {
            margin: 0 0 4px;
            font-size: 15px;
            font-weight: 700;
            color: var(--title);
        }

        .panel-subtitle {
            margin-bottom: 8px;
            font-size: 11px;
            color: var(--muted);
        }

        .chart-box {
            flex: 1;
            min-height: 0;
            position: relative;
        }

        .datetime-box {
            background: var(--soft-bg);
            border: 1px dashed #bfdbfe;
            border-radius: 8px;
            padding: 6px;
            margin-bottom: 8px;
            text-align: center;
        }

        #date {
            font-size: 14px;
            color: #1e293b;
            font-weight: 700;
        }

        #time {
            font-size: 13px;
            color: #3c8dbc;
            font-weight: 700;
        }

        .insight-item {
            padding: 8px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            margin-bottom: 6px;
            background: #f8fafc;
        }

        .insight-title {
            font-size: 13px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 2px;
        }

        .insight-value {
            font-size: 12px;
            color: var(--muted);
        }

        .check-list {
            list-style: none;
            margin: 0;
            padding: 0;
            overflow-y: visible !important;
            height: auto !important;
            flex: 1;
        }

        .check-list li {
            border-bottom: 1px solid #e2e8f0;
            padding: 6px 0;
            display: flex;
            justify-content: space-between;
            gap: 8px;
            align-items: center;
            font-size: 13px;
        }

        .status-pill {
            border-radius: 999px;
            padding: 2px 8px;
            font-size: 11px;
            font-weight: 700;
        }

        .status-good { background: #dcfce7; color: #166534; }
        .status-warn { background: #fef9c3; color: #854d0e; }
        .status-alert { background: #fee2e2; color: #991b1b; }

        .mt-row { margin-top: 0 !important; }
';
include 'header.php';
include 'sidebar.php';
?>
<main class="app-main">
  <div class="app-content">
    <div class="container-fluid dashboard-wrap">
      <div class="row g-3">
        <?php if (empty($assigned_reports)): ?>
          <div class="col-12">
            <div class="alert alert-warning text-center rounded-3 p-4 mb-0" role="alert">
              <i class="bi bi-exclamation-triangle-fill fs-3 d-block mb-2 text-warning"></i>
              No reports assigned to this station profile yet. Please allocate report profiles in the Admin Panel.
            </div>
          </div>
        <?php else: ?>
          <?php foreach ($assigned_reports as $rk): ?>
            <?php if (isset($reportMetadata[$rk])): ?>
              <?php $meta = $reportMetadata[$rk]; ?>
              <div class="col-lg-3 col-md-6">
                <div class="kpi-card">
                  <div class="kpi-top">
                    <div class="kpi-label"><?php echo htmlspecialchars($meta['label']); ?></div>
                    <span class="kpi-icon" style="background:<?php echo $meta['color']; ?>;"><i class="<?php echo $meta['icon']; ?>"></i></span>
                  </div>
                  <div class="kpi-value"><?php echo htmlspecialchars($meta['score']); ?></div>
                  <div class="kpi-foot"><?php echo htmlspecialchars($meta['foot']); ?></div>
                </div>
              </div>
            <?php endif; ?>
          <?php endforeach; ?>
        <?php endif; ?>
      </div>

      <div class="row g-3 mt-1">
        <div class="col-xl-8">
          <div class="panel-card">
            <h3 class="panel-title">Monthly Performance</h3>
            <p class="panel-subtitle">Rolling score trend over the last 12
              months</p>
            <div class="chart-box"><canvas id="monthlyPerformanceChart"></canvas></div>
          </div>
        </div>
        <div class="col-xl-4">
          <div class="panel-card">
            <div class="datetime-box">
              <div id="date"></div>
              <div id="time"></div>
            </div>
            <h3 class="panel-title">Today Highlights</h3>
            <div class="insight-item">
              <div class="insight-title">Best Performing Area</div>
              <div class="insight-value">Platform Surface Cleaning at
                92%</div>
            </div>
            <div class="insight-item">
              <div class="insight-title">Priority Attention</div>
              <div class="insight-value">Staircase handrail sanitation
                frequency dropped by 8%</div>
            </div>
            <div class="insight-item">
              <div class="insight-title">Audit Completion</div>
              <div class="insight-value">14 out of 17 checks completed for
                current shift</div>
            </div>
          </div>
        </div>
      </div>

      <div class="row g-3 mt-1">
        <div class="col-xl-6">
          <div class="panel-card">
            <h3 class="panel-title">Last 30 Days Trend</h3>
            <p class="panel-subtitle">Daily overall quality score
              movement</p>
            <div class="chart-box"><canvas id="dailyPerformanceChart"></canvas></div>
          </div>
        </div>
        <div class="col-xl-3">
          <div class="panel-card">
            <h3 class="panel-title">Score Distribution</h3>
            <p class="panel-subtitle">Quality category split</p>
            <div class="chart-box"><canvas id="categoriesChart"></canvas></div>
          </div>
        </div>
        <div class="col-xl-3">
          <div class="panel-card">
            <h3 class="panel-title">Recent Checks</h3>
            <p class="panel-subtitle">Latest area-wise audit statuses</p>
            <ul class="check-list">
              <?php foreach ($recentChecks as $check): ?>
                <li>
                  <div>
                    <strong><?= htmlspecialchars($check['zone']);
                    ?></strong><br>
                    <span style="color:#64748b;">
                      <?=
                        htmlspecialchars($check['time']); ?>
                    </span>
                  </div>
                  <span class="status-pill <?= htmlspecialchars($check['status_class']); ?>">
                    <?=
                      htmlspecialchars($check['status']); ?>
                  </span>
                </li>
              <?php endforeach; ?>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</main>

<?php
$extraScripts = '
    function updateDateTime() {
        const now = new Date();
        const dateOptions = {
            weekday: "long",
            year: "numeric",
            month: "long",
            day: "numeric"
        };
        document.getElementById("date").textContent = now.toLocaleDateString("en-US", dateOptions);
        document.getElementById("time").textContent = now.toLocaleTimeString("en-US");
    }

    updateDateTime();
    setInterval(updateDateTime, 1000);

    document.addEventListener("DOMContentLoaded", function () {
        const monthlyCtx = document.getElementById("monthlyPerformanceChart");
        const dailyCtx = document.getElementById("dailyPerformanceChart");
        const categoriesCtx = document.getElementById("categoriesChart");

        if (monthlyCtx) {
            new Chart(monthlyCtx.getContext("2d"), {
                type: "bar",
                data: {
                    labels: ["Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", "Jan", "Feb", "Mar"],
                    datasets: [{
                        label: "Performance (%)",
                        data: [74, 78, 81, 79, 83, 86, 84, 88, 87, 85, 89, 90],
                        backgroundColor: "#3c8dbc",
                        borderRadius: 6,
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            max: 100,
                            grid: { color: "rgba(148, 163, 184, 0.22)" }
                        },
                        x: {
                            grid: { display: false }
                        }
                    }
                }
            });
        }

        if (dailyCtx) {
            new Chart(dailyCtx.getContext("2d"), {
                type: "line",
                data: {
                    labels: ["1", "3", "5", "7", "9", "11", "13", "15", "17", "19", "21", "23", "25", "27", "29"],
                    datasets: [{
                        label: "Daily Score (%)",
                        data: [77, 80, 79, 83, 84, 82, 86, 88, 87, 89, 85, 86, 88, 90, 89],
                        borderColor: "#3c8dbc",
                        backgroundColor: "rgba(60, 141, 188, 0.15)",
                        fill: true,
                        tension: 0.35,
                        pointRadius: 3,
                        pointHoverRadius: 4,
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            max: 100,
                            grid: { color: "rgba(148, 163, 184, 0.22)" }
                        },
                        x: {
                            grid: { display: false }
                        }
                    }
                }
            });
        }

        if (categoriesCtx) {
            new Chart(categoriesCtx.getContext("2d"), {
                type: "doughnut",
                data: {
                    labels: ["Excellent", "Very Good", "Good", "Average"],
                    datasets: [{
                        data: [34, 29, 24, 13],
                        backgroundColor: ["#3c8dbc", "#5da9d6", "#86c5e4", "#b7dcf0"],
                        borderWidth: 0,
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: "bottom",
                            labels: {
                                boxWidth: 10,
                                usePointStyle: true,
                                pointStyle: "circle"
                            }
                        }
                    },
                    cutout: "62%"
                }
            });
        }
    });
';
include 'footer.php';
?>