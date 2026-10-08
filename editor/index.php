<?php
/**
 * MCC - Auditor Dashboard Home
 * Displays assigned report profiles, auditor KPI statistics, and filled sheets scoped to the logged-in auditor (audit_by).
 */
require_once __DIR__ . '/auth.php';
global $pdo;

$tz    = new DateTimeZone('Asia/Kolkata');
$today = new DateTimeImmutable('now', $tz);

$rangeEnd   = (isset($_GET['to'])   && preg_match('/^\d{4}-\d{2}-\d{2}$/', $_GET['to']))   ? $_GET['to']   : $today->format('Y-m-d');
$rangeStart = (isset($_GET['from']) && preg_match('/^\d{4}-\d{2}-\d{2}$/', $_GET['from'])) ? $_GET['from'] : $today->modify('-6 days')->format('Y-m-d');
if ($rangeStart > $rangeEnd) {
    [$rangeStart, $rangeEnd] = [$rangeEnd, $rangeStart];
}

// 1. Fetch active reports for current station to show assigned modules
$activeReports = [];
try {
    $stmtRep = $pdo->prepare("
        SELECT r.report_id, r.report_name, r.app_key 
        FROM mcc_reports r 
        WHERE r.station_id = :sid AND r.status = 'Active'
        ORDER BY r.report_id ASC
    ");
    $stmtRep->execute(['sid' => $stationId]);
    $activeReports = $stmtRep->fetchAll(PDO::FETCH_ASSOC);
} catch (Exception $e) {}

// Module metadata configuration for Auditor Dashboard cards
$moduleConfig = [
    'normal_cleaning' => [
        'title' => 'Normal Cleaning',
        'icon' => 'bi-droplet-half',
        'color' => '#38bdf8',
        'bg' => 'rgba(56, 189, 248, 0.12)',
        'sheet_url' => 'normal-report.php',
        'sub_sheets' => [
            ['name' => 'Scorecard', 'url' => 'normal-report.php'],
            ['name' => 'Chemical Sheet', 'url' => 'chemical-report.php'],
            ['name' => 'Machine Log', 'url' => 'machine-report.php'],
        ]
    ],
    'intensive_cleaning' => [
        'title' => 'Intensive Cleaning',
        'icon' => 'bi-stars',
        'color' => '#c084fc',
        'bg' => 'rgba(192, 132, 252, 0.12)',
        'sheet_url' => 'intensive-report.php',
        'sub_sheets' => [
            ['name' => 'Intensive Scorecard', 'url' => 'intensive-report.php'],
            ['name' => 'Scorecard 2', 'url' => 'intensive_scorecard_2.php'],
            ['name' => 'Chemical Sheet', 'url' => 'intensive-chemical-report.php'],
            ['name' => 'Machine Log', 'url' => 'machine-report-intensive.php'],
        ]
    ],
    'pantry_car' => [
        'title' => 'Pantry Car',
        'icon' => 'bi-cup-hot',
        'color' => '#34d399',
        'bg' => 'rgba(52, 211, 153, 0.12)',
        'sheet_url' => 'intensive_pantry_scorecard.php',
        'sub_sheets' => [
            ['name' => 'Pantry Scorecard', 'url' => 'intensive_pantry_scorecard.php'],
            ['name' => 'Chemical Sheet', 'url' => 'pantry-chemical.php'],
            ['name' => 'Machine Log', 'url' => 'pantry-machine.php'],
        ]
    ],
    'dc_cleaning' => [
        'title' => 'DC Depot Cleaning',
        'icon' => 'bi-shield-check',
        'color' => '#fbbf24',
        'bg' => 'rgba(251, 191, 36, 0.12)',
        'sheet_url' => 'DC-Scorecard.php',
        'sub_sheets' => [
            ['name' => 'DC Scorecard', 'url' => 'DC-Scorecard.php'],
            ['name' => 'Chemical Sheet', 'url' => 'dc-chemical.php'],
            ['name' => 'Machine Log', 'url' => 'dc-machine.php'],
        ]
    ],
    'prt_cleaning' => [
        'title' => 'PRT Cleaning',
        'icon' => 'bi-arrow-repeat',
        'color' => '#f97316',
        'bg' => 'rgba(249, 115, 22, 0.12)',
        'sheet_url' => 'Platform-Return-TrainsScorecard.php',
        'sub_sheets' => [
            ['name' => 'PRT Scorecard', 'url' => 'Platform-Return-TrainsScorecard.php'],
            ['name' => 'Chemical Sheet', 'url' => 'Platform-Return-Chemical.php'],
            ['name' => 'Machine Log', 'url' => 'Platform-Return-Machine.php'],
        ]
    ],
    'surprise_visit_audits' => [
        'title' => 'Surprise Visits',
        'icon' => 'bi-patch-check-fill',
        'color' => '#ec4899',
        'bg' => 'rgba(236, 72, 153, 0.12)',
        'sheet_url' => 'surprise-pit-office.php',
        'sub_sheets' => [
            ['name' => 'Pit & Office Audit', 'url' => 'surprise-pit-office.php'],
            ['name' => 'PF Trains Audit', 'url' => 'surprise-pf-trains.php'],
        ]
    ],
    'vande_bharat_modules' => [
        'title' => 'Vande Bharat',
        'icon' => 'bi-lightning-charge-fill',
        'color' => '#22d3ee',
        'bg' => 'rgba(34, 211, 238, 0.12)',
        'sheet_url' => 'vande-bharat-report.php',
        'sub_sheets' => [
            ['name' => 'VB Scorecard', 'url' => 'vande-bharat-report.php'],
            ['name' => 'Chemical Sheet', 'url' => 'vande-bharat-chemical.php'],
            ['name' => 'Machine Log', 'url' => 'vande-bharat-machine.php'],
        ]
    ],
    'attendance_manpower' => [
        'title' => 'Attendance & Manpower',
        'icon' => 'bi-calendar-check',
        'color' => '#a78bfa',
        'bg' => 'rgba(167, 139, 250, 0.12)',
        'sheet_url' => 'man-power-log.php',
        'sub_sheets' => [
            ['name' => 'Man Power Log', 'url' => 'man-power-log.php'],
            ['name' => 'Biometric Log', 'url' => 'biometeric_manpower_log.php'],
        ]
    ],
    'cleanliness_modules' => [
        'title' => 'Cleanliness Modules',
        'icon' => 'bi-stars',
        'color' => '#4ade80',
        'bg' => 'rgba(74, 222, 128, 0.12)',
        'sheet_url' => 'cleanliness.php',
        'sub_sheets' => [
            ['name' => 'Cleanliness Scorecard', 'url' => 'cleanliness.php'],
        ]
    ],
    'photo_reports' => [
        'title' => 'Photo Reports',
        'icon' => 'bi-camera',
        'color' => '#f43f5e',
        'bg' => 'rgba(244, 63, 94, 0.12)',
        'sheet_url' => 'photo-report.php',
        'sub_sheets' => [
            ['name' => 'Before / After Photos', 'url' => 'photo-report.php'],
        ]
    ],
];

// 2. Fetch live sheets submitted by THIS auditor across all report tables
$mySheets = [];
$totalSubmitted = 0;
$totalApproved = 0;
$totalPending = 0;

$sheetTables = [
    ['table' => 'mcc_normal_scorecard_report', 'name' => 'Normal Scorecard', 'url' => 'normal-report.php'],
    ['table' => 'mcc_normal_chemical_report', 'name' => 'Normal Chemical', 'url' => 'chemical-report.php'],
    ['table' => 'mcc_normal_machine_report', 'name' => 'Normal Machine', 'url' => 'machine-report.php'],
    ['table' => 'mcc_intensive_scorecard_report', 'name' => 'Intensive Scorecard', 'url' => 'intensive-report.php'],
    ['table' => 'mcc_intensive_scorecard_2_report', 'name' => 'Intensive Scorecard 2', 'url' => 'intensive_scorecard_2.php'],
    ['table' => 'mcc_intensive_chemical_report', 'name' => 'Intensive Chemical', 'url' => 'intensive-chemical-report.php'],
    ['table' => 'mcc_intensive_machine_report', 'name' => 'Intensive Machine', 'url' => 'machine-report-intensive.php'],
    ['table' => 'dc_mcc_report', 'name' => 'DC Scorecard', 'url' => 'DC-Scorecard.php'],
    ['table' => 'dc_mcc_chemical_report', 'name' => 'DC Chemical', 'url' => 'dc-chemical.php'],
    ['table' => 'dc_mcc_machine_report', 'name' => 'DC Machine', 'url' => 'dc-machine.php'],
    ['table' => 'mcc_prt_scorecard_report', 'name' => 'PRT Scorecard', 'url' => 'Platform-Return-TrainsScorecard.php'],
    ['table' => 'mcc_prt_chemical_report', 'name' => 'PRT Chemical', 'url' => 'Platform-Return-Chemical.php'],
    ['table' => 'mcc_prt_machine_report', 'name' => 'PRT Machine', 'url' => 'Platform-Return-Machine.php'],
    ['table' => 'mcc_intensive_pantry_report', 'name' => 'Pantry Scorecard', 'url' => 'intensive_pantry_scorecard.php'],
    ['table' => 'mcc_intensive_pantry_chemical_report', 'name' => 'Pantry Chemical', 'url' => 'pantry-chemical.php'],
    ['table' => 'mcc_intensive_pantry_machine_report', 'name' => 'Pantry Machine', 'url' => 'pantry-machine.php'],
    ['table' => 'mcc_surprise_pit_office_report', 'name' => 'Surprise Pit & Office', 'url' => 'surprise-pit-office.php'],
    ['table' => 'mcc_surprise_pf_trains_report', 'name' => 'Surprise PF Trains', 'url' => 'surprise-pf-trains.php'],
    ['table' => 'mcc_vb_scorecard_report', 'name' => 'Vande Bharat Scorecard', 'url' => 'vande-bharat-report.php'],
    ['table' => 'mcc_vb_chemical_report', 'name' => 'Vande Bharat Chemical', 'url' => 'vande-bharat-chemical.php'],
    ['table' => 'mcc_vb_machine_report', 'name' => 'Vande Bharat Machine', 'url' => 'vande-bharat-machine.php'],
    ['table' => 'mcc_cleanliness_report', 'name' => 'Cleanliness Sheet', 'url' => 'cleanliness.php'],
];

foreach ($sheetTables as $st) {
    try {
        $q = $pdo->prepare("
            SELECT DISTINCT token_id, train_no, report_date, isApproved 
            FROM {$st['table']} 
            WHERE station_id = :sid 
              AND audit_by = :aud_id
              AND report_date BETWEEN :f AND :t
            ORDER BY report_date DESC, token_id DESC
        ");
        $q->execute([
            'sid' => $stationId,
            'aud_id' => $auditorId,
            'f' => $rangeStart,
            't' => $rangeEnd
        ]);
        $rows = $q->fetchAll(PDO::FETCH_ASSOC);

        foreach ($rows as $r) {
            $isApp = intval($r['isApproved'] ?? 0);
            $totalSubmitted++;
            if ($isApp === 1) {
                $totalApproved++;
            } else {
                $totalPending++;
            }

            $mySheets[] = [
                'token_id' => $r['token_id'],
                'train_no' => $r['train_no'] ?? 'N/A',
                'report_date' => $r['report_date'],
                'module_name' => $st['name'],
                'table' => $st['table'],
                'view_url' => $st['url'] . '?from_date=' . $r['report_date'] . '&to_date=' . $r['report_date'],
                'isApproved' => $isApp
            ];
        }
    } catch (Exception $e) {
        // Table may not exist or empty
    }
}

// Sort mySheets by report_date descending
usort($mySheets, function($a, $b) {
    return strcmp($b['report_date'] . '_' . $b['token_id'], $a['report_date'] . '_' . $a['token_id']);
});

$pageTitle = 'Auditor Dashboard | MCC Portal';
include 'header.php';
include 'sidebar.php';
?>

<link rel="stylesheet" href="css/dashboard.css">
<style>
  .auditor-card {
    background: linear-gradient(180deg, #0a2440 0%, #071c31 100%) !important;
    border: 1px solid #14416b !important;
    border-radius: 12px !important;
    box-shadow: 0 4px 18px rgba(0, 0, 0, 0.45) !important;
    transition: transform 0.2s ease, box-shadow 0.2s ease, border-color 0.2s ease;
  }

  .auditor-card:hover {
    border-color: #29b6f6 !important;
    box-shadow: 0 6px 22px rgba(41, 182, 246, 0.22) !important;
  }

  .kpi-title {
    color: #93c5fd !important;
    font-size: 11px !important;
    font-weight: 700 !important;
    letter-spacing: 0.6px !important;
    text-transform: uppercase !important;
  }

  .kpi-sub {
    font-size: 11px !important;
    font-weight: 500 !important;
  }

  .module-btn-sub {
    background: rgba(7, 26, 46, 0.95) !important;
    border: 1px solid #1b4d79 !important;
    color: #f1f5f9 !important;
    border-radius: 6px !important;
    font-weight: 500 !important;
    transition: all 0.2s ease !important;
  }

  .module-btn-sub span {
    color: #e2e8f0 !important;
    font-weight: 500 !important;
  }

  .module-btn-sub:hover {
    background: rgba(41, 182, 246, 0.25) !important;
    border-color: #38bdf8 !important;
    color: #38bdf8 !important;
  }

  .module-btn-sub:hover span {
    color: #38bdf8 !important;
  }

  .auditor-date-input {
    background: #061e36 !important;
    background-color: #061e36 !important;
    color: #ffffff !important;
    border: 1px solid #14416b !important;
    border-radius: 6px !important;
    padding: 4px 10px !important;
    font-size: 13px !important;
    font-weight: 500 !important;
    color-scheme: dark !important;
    width: 135px !important;
    outline: none !important;
    box-shadow: none !important;
  }

  .auditor-date-input:focus {
    border-color: #29b6f6 !important;
    background-color: #082847 !important;
    color: #ffffff !important;
    box-shadow: 0 0 0 2px rgba(41, 182, 246, 0.25) !important;
  }

  .auditor-table,
  .auditor-table > :not(caption) > * > *,
  .auditor-table tbody tr,
  .auditor-table tbody td {
    --bs-table-bg: transparent !important;
    --bs-table-accent-bg: transparent !important;
    --bs-table-striped-bg: transparent !important;
    --bs-table-hover-bg: #11426e !important;
    --bs-table-hover-color: #ffffff !important;
    border-color: #14416b !important;
  }

  .auditor-table thead th {
    background: #06192d !important;
    background-color: #06192d !important;
    color: #38bdf8 !important;
    border-bottom: 2px solid #14416b !important;
    font-weight: 700 !important;
    text-transform: uppercase !important;
    font-size: 11.5px !important;
    letter-spacing: 0.5px !important;
  }

  .auditor-table tbody tr {
    background: #081d33 !important;
    background-color: #081d33 !important;
    color: #ffffff !important;
    transition: background-color 0.15s ease !important;
  }

  .auditor-table tbody tr:nth-of-type(odd) {
    background: #06182c !important;
    background-color: #06182c !important;
  }

  .auditor-table tbody tr td {
    background-color: transparent !important;
    color: #f1f5f9 !important;
    border-bottom: 1px solid #0f395f !important;
    vertical-align: middle !important;
  }

  .auditor-table tbody tr:hover,
  .auditor-table tbody tr:hover > *,
  .auditor-table tbody tr:hover td {
    background: #11426e !important;
    background-color: #11426e !important;
    color: #ffffff !important;
  }

  .auditor-table tbody tr:hover td span.text-white {
    color: #ffffff !important;
  }

  .auditor-table tbody tr:hover td small {
    color: #e0f2fe !important;
  }
</style>

<main class="app-main">
  <div class="mccx-shell">

      <!-- Welcome & Filter Card -->
      <div class="card auditor-card border-0 mb-4 shadow-sm">
        <div class="card-body p-4">
          <div class="row align-items-center g-3">
            <div class="col-lg-6">
              <div class="d-flex align-items-center gap-3">
                <div style="width: 52px; height: 52px; border-radius: 12px; background: linear-gradient(135deg, #0ea5e9, #2563eb); display: flex; align-items: center; justify-content: center; box-shadow: 0 4px 14px rgba(14, 165, 233, 0.4);">
                  <i class="bi bi-person-badge-fill text-white fs-3"></i>
                </div>
                <div>
                  <h4 class="mb-1 fw-bold text-white">Welcome, <?= htmlspecialchars($auditorName) ?>!</h4>
                  <p class="mb-0 text-white-50 small" style="font-size: 13px;">
                    <span class="text-info fw-semibold"><i class="bi bi-geo-alt-fill me-1"></i><?= htmlspecialchars($stationName) ?> Depot</span> 
                    &bull; <span class="text-light"><?= htmlspecialchars($divisionName) ?> Division</span> &bull; <span class="text-light"><?= htmlspecialchars($railwayName) ?></span>
                  </p>
                </div>
              </div>
            </div>

            <div class="col-lg-6">
              <form method="GET" class="d-flex flex-wrap align-items-center justify-content-lg-end gap-2">
                <div class="d-flex align-items-center gap-1 p-1 px-2 rounded" style="background: rgba(6, 26, 44, 0.9); border: 1px solid #14416b;">
                  <span class="text-info small me-1 fw-semibold"><i class="bi bi-calendar3"></i> Range:</span>
                  <input type="date" name="from" value="<?= htmlspecialchars($rangeStart) ?>" class="auditor-date-input">
                  <span class="text-muted small px-1">to</span>
                  <input type="date" name="to" value="<?= htmlspecialchars($rangeEnd) ?>" class="auditor-date-input">
                </div>
                <button type="submit" class="btn btn-sm btn-primary px-3 fw-semibold shadow-sm" style="background: linear-gradient(135deg, #13c9ff 0%, #0284c7 100%); border: none;">
                  <i class="bi bi-filter me-1"></i>Apply
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>

      <!-- KPI Metric Cards (Auditor Scoped) -->
      <div class="row g-3 mb-4">
        <div class="col-sm-6 col-xl-3">
          <div class="card auditor-card h-100 border-0 shadow-sm">
            <div class="card-body p-3 d-flex align-items-center justify-content-between">
              <div>
                <div class="kpi-title">My Filled Sheets</div>
                <h2 class="mb-0 fw-bold text-white mt-1"><?= $totalSubmitted ?></h2>
                <small class="text-info kpi-sub"><i class="bi bi-clock-history me-1"></i>In selected date range</small>
              </div>
              <div style="width: 46px; height: 46px; border-radius: 10px; background: rgba(14, 165, 233, 0.15); display: flex; align-items: center; justify-content: center;">
                <i class="bi bi-file-earmark-spreadsheet-fill text-info fs-4"></i>
              </div>
            </div>
          </div>
        </div>

        <div class="col-sm-6 col-xl-3">
          <div class="card auditor-card h-100 border-0 shadow-sm">
            <div class="card-body p-3 d-flex align-items-center justify-content-between">
              <div>
                <div class="kpi-title">Approved By CDO</div>
                <h2 class="mb-0 fw-bold text-success mt-1"><?= $totalApproved ?></h2>
                <small class="text-success kpi-sub"><i class="bi bi-check2-circle me-1"></i>Verified audits</small>
              </div>
              <div style="width: 46px; height: 46px; border-radius: 10px; background: rgba(16, 185, 129, 0.15); display: flex; align-items: center; justify-content: center;">
                <i class="bi bi-shield-check text-success fs-4"></i>
              </div>
            </div>
          </div>
        </div>

        <div class="col-sm-6 col-xl-3">
          <div class="card auditor-card h-100 border-0 shadow-sm">
            <div class="card-body p-3 d-flex align-items-center justify-content-between">
              <div>
                <div class="kpi-title">Pending Approval</div>
                <h2 class="mb-0 fw-bold text-warning mt-1"><?= $totalPending ?></h2>
                <small class="text-warning kpi-sub"><i class="bi bi-hourglass-split me-1"></i>Awaiting review</small>
              </div>
              <div style="width: 46px; height: 46px; border-radius: 10px; background: rgba(245, 158, 11, 0.15); display: flex; align-items: center; justify-content: center;">
                <i class="bi bi-hourglass-top text-warning fs-4"></i>
              </div>
            </div>
          </div>
        </div>

        <div class="col-sm-6 col-xl-3">
          <div class="card auditor-card h-100 border-0 shadow-sm">
            <div class="card-body p-3 d-flex align-items-center justify-content-between">
              <div>
                <div class="kpi-title">Assigned Modules</div>
                <h2 class="mb-0 fw-bold text-white mt-1"><?= count($activeReports) ?></h2>
                <small class="text-info kpi-sub"><i class="bi bi-layers me-1"></i>Active for this station</small>
              </div>
              <div style="width: 46px; height: 46px; border-radius: 10px; background: rgba(168, 85, 247, 0.15); display: flex; align-items: center; justify-content: center;">
                <i class="bi bi-grid-fill text-purple fs-4" style="color: #c084fc;"></i>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Assigned Reports Grid -->
      <div class="d-flex align-items-center justify-content-between mb-3">
        <h5 class="fw-bold text-white mb-0">
          <i class="bi bi-folder-check text-info me-2"></i>My Assigned Report Modules
        </h5>
        <span class="text-info small" style="opacity: 0.85;">Click any module to open sheets</span>
      </div>

      <div class="row g-3 mb-4">
        <?php if (empty($activeReports)): ?>
          <div class="col-12">
            <div class="alert alert-info bg-dark border-secondary text-white py-3">
              <i class="bi bi-info-circle me-2"></i>No active reports are mapped to this station profile yet.
            </div>
          </div>
        <?php else: ?>
          <?php foreach ($activeReports as $r): 
            $key = $r['app_key'] ?? '';
            $cfg = $moduleConfig[$key] ?? [
                'title' => $r['report_name'],
                'icon' => 'bi-file-text-fill',
                'color' => '#38bdf8',
                'bg' => 'rgba(56, 189, 248, 0.12)',
                'sheet_url' => 'normal-report.php',
                'sub_sheets' => []
            ];
          ?>
          <div class="col-md-6 col-lg-4 col-xl-3">
            <div class="card auditor-card h-100 border-0 shadow-sm">
              <div class="card-body p-3 d-flex flex-column">
                <div class="d-flex align-items-center gap-3 mb-3">
                  <div style="width: 42px; height: 42px; border-radius: 8px; background: <?= $cfg['bg'] ?>; display: flex; align-items: center; justify-content: center; flex-shrink: 0;">
                    <i class="bi <?= $cfg['icon'] ?> fs-4" style="color: <?= $cfg['color'] ?>;"></i>
                  </div>
                  <div>
                    <h6 class="fw-bold text-white mb-0" style="font-size: 14px;"><?= htmlspecialchars($r['report_name']) ?></h6>
                    <span class="badge mt-1" style="background: rgba(56, 189, 248, 0.15); color: #38bdf8; border: 1px solid rgba(56, 189, 248, 0.3); font-size: 10px;">Active Profile</span>
                  </div>
                </div>

                <div class="mt-auto">
                  <div class="d-flex flex-column gap-1">
                    <?php if (!empty($cfg['sub_sheets'])): ?>
                      <?php foreach ($cfg['sub_sheets'] as $sub): ?>
                      <a href="<?= $sub['url'] ?>" class="btn btn-sm module-btn-sub text-start d-flex align-items-center justify-content-between py-1 px-2" style="font-size: 12px;">
                        <span><?= htmlspecialchars($sub['name']) ?></span>
                        <i class="bi bi-chevron-right small text-info"></i>
                      </a>
                      <?php endforeach; ?>
                    <?php else: ?>
                      <a href="<?= $cfg['sheet_url'] ?>" class="btn btn-sm btn-primary w-100 fw-semibold" style="background: linear-gradient(135deg, #13c9ff 0%, #0284c7 100%); border: none; font-size: 12px;">
                        <i class="bi bi-arrow-right-circle me-1"></i>Open Sheets
                      </a>
                    <?php endif; ?>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <?php endforeach; ?>
        <?php endif; ?>
      </div>

      <!-- My Recent Filled Sheets Table -->
      <div class="card auditor-card border-0 shadow-sm mb-4">
        <div class="card-header bg-transparent border-bottom border-secondary border-opacity-25 py-3 d-flex align-items-center justify-content-between">
          <h6 class="fw-bold text-white mb-0">
            <i class="bi bi-list-check text-info me-2"></i>My Filled Sheets (Filtered by You)
          </h6>
          <span class="badge bg-dark border border-secondary border-opacity-50 text-light px-2 py-1 small">
            Total: <?= count($mySheets) ?> Sheets
          </span>
        </div>

        <div class="card-body p-0">
          <div class="table-responsive">
            <table class="table auditor-table align-middle mb-0" style="font-size: 13px;">
              <thead>
                <tr>
                  <th class="ps-3 py-2" style="width: 60px;">#</th>
                  <th class="py-2">Report Date</th>
                  <th class="py-2">Module / Sheet Type</th>
                  <th class="py-2">Token / Train No</th>
                  <th class="py-2 text-center">CDO Status</th>
                  <th class="py-2 text-end pe-3" style="width: 180px;">Actions</th>
                </tr>
              </thead>
              <tbody>
                <?php if (empty($mySheets)): ?>
                <tr>
                  <td colspan="6" class="text-center py-4 text-white-50">
                    <i class="bi bi-journal-x fs-3 d-block mb-2 text-info"></i>
                    No filled sheets found for your account in this date range.
                  </td>
                </tr>
                <?php else: ?>
                  <?php foreach ($mySheets as $idx => $sheet): ?>
                  <tr>
                    <td class="ps-3 text-info fw-semibold"><?= $idx + 1 ?></td>
                    <td>
                      <span class="fw-semibold text-white"><?= htmlspecialchars(date('d-m-Y', strtotime($sheet['report_date']))) ?></span>
                    </td>
                    <td>
                      <span class="badge" style="background: rgba(56, 189, 248, 0.18); color: #38bdf8; border: 1px solid rgba(56, 189, 248, 0.35); font-size: 11px; font-weight: 500;">
                        <?= htmlspecialchars($sheet['module_name']) ?>
                      </span>
                    </td>
                    <td>
                      <span class="fw-bold text-white"><?= htmlspecialchars($sheet['train_no']) ?></span>
                      <small class="text-info d-block" style="font-size: 11px; opacity: 0.85;">Token: <?= htmlspecialchars($sheet['token_id']) ?></small>
                    </td>
                    <td class="text-center">
                      <?php if ($sheet['isApproved'] === 1): ?>
                        <span class="badge px-2 py-1" style="background: rgba(34, 197, 94, 0.2); color: #4ade80; border: 1px solid rgba(34, 197, 94, 0.4);">
                          <i class="bi bi-check-circle-fill me-1"></i>Approved
                        </span>
                      <?php else: ?>
                        <span class="badge px-2 py-1" style="background: rgba(245, 158, 11, 0.2); color: #fbbf24; border: 1px solid rgba(245, 158, 11, 0.4);">
                          <i class="bi bi-clock-history me-1"></i>Pending Review
                        </span>
                      <?php endif; ?>
                    </td>
                    <td class="text-end pe-3">
                      <div class="d-inline-flex gap-2">
                        <a href="<?= htmlspecialchars($sheet['view_url']) ?>" class="btn btn-xs btn-outline-info px-2 py-1 fw-semibold" style="font-size: 11px; border-color: #38bdf8; color: #38bdf8;" title="View Sheet">
                          <i class="bi bi-eye me-1"></i>View
                        </a>
                        <a href="<?= htmlspecialchars($sheet['view_url']) ?>&edit=<?= urlencode($sheet['token_id']) ?>" class="btn btn-xs px-2 py-1 fw-bold text-dark" style="font-size: 11px; background-color: #fbbf24; color: #000000 !important; border: 1px solid #f59e0b;" title="Edit Sheet">
                          <i class="bi bi-pencil-square me-1"></i>Edit
                        </a>
                      </div>
                    </td>
                  </tr>
                  <?php endforeach; ?>
                <?php endif; ?>
              </tbody>
            </table>
          </div>
        </div>
      </div>

    </div>
</main>

<?php include 'footer.php'; ?>
