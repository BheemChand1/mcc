<style>
  .app-sidebar {
    background: #1e293b !important;
    border-right: none !important;
  }

  .sidebar-brand {
    height: 180px;
    background: rgba(255, 255, 255, 0.03);
    border-bottom: 1px solid rgba(255, 255, 255, 0.05);
    display: flex;
    align-items: center;
    padding: 0 20px;
  }

  .brand-link {
    text-decoration: none !important;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 8px;
    width: 100%;
  }

  .brand-text {
    color: white !important;
    font-weight: 700 !important;
    letter-spacing: 1px;
    font-size: 0.9rem;
  }

  .sidebar-wrapper {
    padding: 15px 12px;
  }

  .nav-sidebar .nav-item {
    margin-bottom: 5px;
  }

  .nav-sidebar .nav-link {
    border-radius: 10px;
    padding: 10px 15px;
    color: #94a3b8 !important;
    transition: all 0.3s ease;
    font-weight: 500;
  }

  .nav-sidebar .nav-link:hover {
    background: rgba(255, 255, 255, 0.05) !important;
    color: white !important;
  }

  .nav-sidebar .nav-link.active {
    background: #3b82f6 !important;
    color: white !important;
    box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
  }

  .nav-icon {
    font-size: 1.1rem;
    margin-right: 10px;
  }

  .nav-arrow {
    font-size: 0.8rem;
    opacity: 0.6;
  }

  .sidebar-footer {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    padding: 10px;
    background: rgba(255, 255, 255, 0.03);
    border-top: 1px solid rgba(255, 255, 255, 0.05);
  }

  .logout-btn {
    width: 100%;
    padding: 10px;
    border-radius: 8px;
    background: rgba(239, 68, 68, 0.1);
    color: #ef4444 !important;
    text-align: center;
    font-weight: 600;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    transition: all 0.2s ease;
  }

  .logout-btn:hover {
    background: #ef4444;
    color: white !important;
  }

  /* Custom Scrollbar for Sidebar */
  .sidebar-wrapper::-webkit-scrollbar {
    width: 4px;
  }

  .sidebar-wrapper::-webkit-scrollbar-track {
    background: transparent;
  }

  .sidebar-wrapper::-webkit-scrollbar-thumb {
    background: rgba(255, 255, 255, 0.1);
    border-radius: 10px;
  }
</style>

<?php
$currentPage = basename($_SERVER['PHP_SELF']);

if (!isset($pdo)) {
    require_once '../connection.php';
}

$active_report_ids = [];
$active_subreport_urls = [];
$report_names = [];
$subreport_names = [];

if (isset($_SESSION['station_id'])) {
    try {
        // Fetch active report ids for this station
        $stmt = $pdo->prepare("SELECT report_id, report_name FROM mcc_reports WHERE station_id = :station_id AND status = 'Active'");
        $stmt->execute(['station_id' => $_SESSION['station_id']]);
        $active_reports_rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        $active_report_ids = array_column($active_reports_rows, 'report_id');

        if (!empty($active_report_ids)) {
            $inClause = implode(',', array_map('intval', $active_report_ids));
            $subStmt = $pdo->query("SELECT report_url FROM mcc_subreports WHERE report_id IN ($inClause) AND status = 'Active'");
            $active_subreport_urls = $subStmt->fetchAll(PDO::FETCH_COLUMN);
        }

        // Fetch report names dynamically for the current station
        $stmtNames = $pdo->prepare("SELECT report_id, report_name FROM mcc_reports WHERE station_id = :station_id");
        $stmtNames->execute(['station_id' => $_SESSION['station_id']]);
        $report_names = $stmtNames->fetchAll(PDO::FETCH_KEY_PAIR);

        // Fetch subreport names dynamically
        $subreport_names = $pdo->query("SELECT subreport_id, report_name FROM mcc_subreports")->fetchAll(PDO::FETCH_KEY_PAIR);
    } catch (PDOException $e) {
        // Fail silently
    }
}

// Fallback arrays for safety
$report_names[1] = $report_names[1] ?? 'Normal Cleaning';
$report_names[2] = $report_names[2] ?? 'Intensive Cleaning';
$report_names[3] = $report_names[3] ?? 'DC Cleaning';
$report_names[4] = $report_names[4] ?? 'PRT Cleaning';
$report_names[5] = $report_names[5] ?? 'Pantry Car';
$report_names[6] = $report_names[6] ?? 'Surprise Visit Audits';
$report_names[7] = $report_names[7] ?? 'Vande Bharat Modules';
$report_names[8] = $report_names[8] ?? 'Attendance & Manpower';
$report_names[9] = $report_names[9] ?? 'Cleanliness Modules';
$report_names[10] = $report_names[10] ?? 'Photo Reports';

$subreport_names[1] = $subreport_names[1] ?? 'Normal Report';
$subreport_names[2] = $subreport_names[2] ?? 'Chemical Report';
$subreport_names[3] = $subreport_names[3] ?? 'Machine Report';
$subreport_names[4] = $subreport_names[4] ?? 'Intensive Report';
$subreport_names[5] = $subreport_names[5] ?? 'Chemical Report';
$subreport_names[6] = $subreport_names[6] ?? 'Machine Report';
$subreport_names[7] = $subreport_names[7] ?? 'DC Scorecard';
$subreport_names[8] = $subreport_names[8] ?? 'Chemical Report';
$subreport_names[9] = $subreport_names[9] ?? 'Machine Report';
$subreport_names[10] = $subreport_names[10] ?? 'PRT ScoreCard';
$subreport_names[11] = $subreport_names[11] ?? 'Chemical Report';
$subreport_names[12] = $subreport_names[12] ?? 'Intensive Scorecard 2';
$subreport_names[13] = $subreport_names[13] ?? 'Pantry Car Score Card';
$subreport_names[14] = $subreport_names[14] ?? 'Pit & Office Inspection';
$subreport_names[15] = $subreport_names[15] ?? 'PF Return Trains Audit';
$subreport_names[16] = $subreport_names[16] ?? 'Vande Bharat Score Card';
$subreport_names[17] = $subreport_names[17] ?? 'Vande Bharat Chemical Report';
$subreport_names[18] = $subreport_names[18] ?? 'Vande Bharat Machine Report';
$subreport_names[19] = $subreport_names[19] ?? 'Man Power Log';
$subreport_names[20] = $subreport_names[20] ?? 'Cleanliness Scorecard';
$subreport_names[21] = $subreport_names[21] ?? 'Photo Report (Before/After)';

// Access mapping helper variables
$has_normal_audit = in_array('normal-report.php', $active_subreport_urls);
$has_normal_chem  = in_array('chemical-report.php', $active_subreport_urls);
$has_normal_mach  = in_array('machine-report.php', $active_subreport_urls);
$has_normal_any   = in_array(1, $active_report_ids) && ($has_normal_audit || $has_normal_chem || $has_normal_mach);

$has_int_audit        = in_array('intensive-report.php', $active_subreport_urls);
$has_int_chem         = in_array('intensive-chemical-report.php', $active_subreport_urls);
$has_int_mach         = in_array('machine-report-intensive.php', $active_subreport_urls);
$has_int_scorecard_2  = in_array('intensive_scorecard_2.php', $active_subreport_urls);
$has_int_pantry       = in_array('intensive_pantry_scorecard.php', $active_subreport_urls);
$has_pantry_chem      = in_array('pantry-chemical.php', $active_subreport_urls);
$has_pantry_mach      = in_array('pantry-machine.php', $active_subreport_urls);
$has_pantry_any       = in_array(5, $active_report_ids) && ($has_int_pantry || $has_pantry_chem || $has_pantry_mach);
$has_int_any          = in_array(2, $active_report_ids) && ($has_int_audit || $has_int_chem || $has_int_mach || $has_int_scorecard_2);

$has_dc_audit   = in_array('DC-Scorecard.php', $active_subreport_urls);
$has_dc_chem    = in_array('dc-chemical.php', $active_subreport_urls);
$has_dc_mach    = in_array('dc-machine.php', $active_subreport_urls);
$has_dc_any     = in_array(3, $active_report_ids) && ($has_dc_audit || $has_dc_chem || $has_dc_mach);

$has_prt_audit    = in_array('Platform-Return-TrainsScorecard.php', $active_subreport_urls);
$has_prt_chem     = in_array('Platform-Return-Chemical.php', $active_subreport_urls);
$has_prt_mach     = in_array('Platform-Return-Machine.php', $active_subreport_urls);
$has_prt_any      = in_array(4, $active_report_ids) && ($has_prt_audit || $has_prt_chem || $has_prt_mach);

$has_sur_pit      = in_array('surprise-pit-office.php', $active_subreport_urls);
$has_sur_pf       = in_array('surprise-pf-trains.php', $active_subreport_urls);
$has_sur_any      = in_array(6, $active_report_ids) && ($has_sur_pit || $has_sur_pf);

$has_vb_audit     = in_array('vande-bharat-report.php', $active_subreport_urls);
$has_vb_chem      = in_array('vande-bharat-chemical.php', $active_subreport_urls);
$has_vb_mach      = in_array('vande-bharat-machine.php', $active_subreport_urls);
$has_vb_any       = in_array(7, $active_report_ids) && ($has_vb_audit || $has_vb_chem || $has_vb_mach);

$has_manpower     = in_array(8, $active_report_ids) && in_array('man-power-log.php', $active_subreport_urls);
$has_cleanliness  = in_array(9, $active_report_ids) && in_array('cleanliness.php', $active_subreport_urls);
$has_photo_report = in_array(10, $active_report_ids) && in_array('photo-report.php', $active_subreport_urls);
?>
<aside class="app-sidebar shadow-lg" data-bs-theme="dark">
  <div class="sidebar-brand">
    <a href="./index.php" class="brand-link">
      <img src="./Indian_Railways.svg" alt="Indian Railways Logo" class="brand-image"
        style="max-height: 130px; width: auto;" />
      <span class="brand-text">MCC</span>
    </a>
  </div>

  <div class="sidebar-wrapper">
    <nav class="mt-2">
      <ul class="nav sidebar-menu flex-column" data-lte-toggle="treeview" role="navigation">

        <li class="nav-item">
          <a href="./index.php" class="nav-link <?= ($currentPage == 'index.php') ? 'active' : '' ?>">
            <i class="nav-icon bi bi-speedometer2"></i>
            <p>Dashboard</p>
          </a>
        </li>

        <li class="nav-header mt-3 small text-uppercase text-muted opacity-50">Operations</li>

        <!-- Normal Cleaning Dropdown -->
        <?php if ($has_normal_any): ?>
        <?php 
        $normalPages = ['normal-report.php', 'chemical-report.php', 'machine-report.php', 'machine-target.php', 'machine-summary.php'];
        $isNormalActive = in_array($currentPage, $normalPages);
        ?>
        <li class="nav-item <?= $isNormalActive ? 'menu-open' : '' ?>">
          <a href="#" class="nav-link <?= $isNormalActive ? 'active' : '' ?>">
            <i class="nav-icon bi bi-droplet-half"></i>
            <p>
              <?= htmlspecialchars($report_names[1]) ?>
              <i class="nav-arrow bi bi-chevron-right"></i>
            </p>
          </a>
          <ul class="nav nav-treeview ms-3">
            <?php if ($has_normal_audit): ?>
            <li class="nav-item">
              <a href="normal-report.php" class="nav-link <?= ($currentPage == 'normal-report.php') ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[1]) ?></p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_normal_chem): ?>
            <li class="nav-item">
              <a href="chemical-report.php" class="nav-link <?= ($currentPage == 'chemical-report.php' && !isset($_GET['intensive'])) ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[2]) ?></p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_normal_mach): ?>
            <li class="nav-item">
              <a href="machine-report.php" class="nav-link <?= in_array($currentPage, ['machine-report.php', 'machine-target.php', 'machine-summary.php']) ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[3]) ?></p>
              </a>
            </li>
            <?php endif; ?>
          </ul>
        </li>
        <?php endif; ?>

        <!-- Intensive Cleaning Dropdown -->
        <?php if ($has_int_any): ?>
        <?php 
        $intensivePages = ['intensive-report.php', 'intensive_scorecard_2.php', 'instensive_scorecard_2.php', 'machine-report-intensive.php', 'machine-target-intensive.php', 'machine-summary-intensive.php', 'intensive-chemical-report.php', 'intensive-chemical-summary.php'];
        $isIntensiveActive = in_array($currentPage, $intensivePages);
        ?>
        <li class="nav-item <?= $isIntensiveActive ? 'menu-open' : '' ?>">
          <a href="#" class="nav-link <?= $isIntensiveActive ? 'active' : '' ?>">
            <i class="nav-icon bi bi-stars"></i>
            <p>
              <?= htmlspecialchars($report_names[2]) ?>
              <i class="nav-arrow bi bi-chevron-right"></i>
            </p>
          </a>
          <ul class="nav nav-treeview ms-3">
            <?php if ($has_int_audit): ?>
            <li class="nav-item">
              <a href="intensive-report.php" class="nav-link <?= ($currentPage == 'intensive-report.php') ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[4]) ?></p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_int_scorecard_2): ?>
            <li class="nav-item">
              <a href="intensive_scorecard_2.php" class="nav-link <?= in_array($currentPage, ['intensive_scorecard_2.php', 'instensive_scorecard_2.php']) ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[12]) ?></p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_int_chem): ?>
            <li class="nav-item">
              <a href="intensive-chemical-report.php" class="nav-link <?= in_array($currentPage, ['intensive-chemical-report.php', 'intensive-chemical-summary.php']) ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[5]) ?></p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_int_mach): ?>
            <li class="nav-item">
              <a href="machine-report-intensive.php" class="nav-link <?= in_array($currentPage, ['machine-report-intensive.php', 'machine-target-intensive.php', 'machine-summary-intensive.php']) ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[6]) ?></p>
              </a>
            </li>
            <?php endif; ?>
          </ul>
        </li>
        <?php endif; ?>

        <!-- Pantry Car Dropdown -->
        <?php if ($has_pantry_any): ?>
        <?php 
        $pantryPages = ['intensive_pantry_scorecard.php', 'pantry_scorecard.php', 'intensive_pantry_summary.php', 'pantry-chemical.php', 'pantry-machine.php'];
        $isPantryActive = in_array($currentPage, $pantryPages);
        ?>
        <li class="nav-item <?= $isPantryActive ? 'menu-open' : '' ?>">
          <a href="#" class="nav-link <?= $isPantryActive ? 'active' : '' ?>">
            <i class="nav-icon bi bi-cup-hot"></i>
            <p>
              <?= htmlspecialchars($report_names[5]) ?>
              <i class="nav-arrow bi bi-chevron-right"></i>
            </p>
          </a>
          <ul class="nav nav-treeview ms-3">
            <?php if ($has_int_pantry): ?>
            <li class="nav-item">
              <a href="intensive_pantry_scorecard.php" class="nav-link <?= in_array($currentPage, ['intensive_pantry_scorecard.php', 'pantry_scorecard.php']) ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[13] ?? 'Pantry Car Score Card') ?></p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_pantry_chem): ?>
            <li class="nav-item">
              <a href="pantry-chemical.php" class="nav-link <?= ($currentPage == 'pantry-chemical.php') ? 'active' : '' ?>">
                <p>Chemical Report</p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_pantry_mach): ?>
            <li class="nav-item">
              <a href="pantry-machine.php" class="nav-link <?= ($currentPage == 'pantry-machine.php') ? 'active' : '' ?>">
                <p>Machine Report</p>
              </a>
            </li>
            <?php endif; ?>
          </ul>
        </li>
        <?php endif; ?>

        <!-- DC Cleaning Dropdown -->
        <?php if ($has_dc_any): ?>
        <?php 
        $dcPages = ['DC-Scorecard.php', 'dc-chemical.php', 'dc-machine.php'];
        $isPldcActive = in_array($currentPage, $dcPages);
        ?>
        <li class="nav-item <?= $isPldcActive ? 'menu-open' : '' ?>">
          <a href="#" class="nav-link <?= $isPldcActive ? 'active' : '' ?>">
            <i class="nav-icon bi bi-shield-check"></i>
            <p>
              <?= htmlspecialchars($report_names[3]) ?>
              <i class="nav-arrow bi bi-chevron-right"></i>
            </p>
          </a>
          <ul class="nav nav-treeview ms-3">
            <?php if ($has_dc_audit): ?>
            <li class="nav-item">
              <a href="DC-Scorecard.php" class="nav-link <?= ($currentPage == 'DC-Scorecard.php') ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[7]) ?></p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_dc_chem): ?>
            <li class="nav-item">
              <a href="dc-chemical.php" class="nav-link <?= ($currentPage == 'dc-chemical.php') ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[8]) ?></p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_dc_mach): ?>
            <li class="nav-item">
              <a href="dc-machine.php" class="nav-link <?= ($currentPage == 'dc-machine.php') ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[9]) ?></p>
              </a>
            </li>
            <?php endif; ?>
          </ul>
        </li>
        <?php endif; ?>

        <!-- PRT Cleaning Dropdown -->
        <?php if ($has_prt_any): ?>
        <?php 
        $prtPages = ['Platform-Return-TrainsScorecard.php', 'Platform-Return-Chemical.php', 'Platform-Return-Machine.php'];
        $isPrtActive = in_array($currentPage, $prtPages);
        ?>
        <li class="nav-item <?= $isPrtActive ? 'menu-open' : '' ?>">
          <a href="#" class="nav-link <?= $isPrtActive ? 'active' : '' ?>">
            <i class="nav-icon bi bi-arrow-repeat"></i>
            <p>
              <?= htmlspecialchars($report_names[4]) ?>
              <i class="nav-arrow bi bi-chevron-right"></i>
            </p>
          </a>
          <ul class="nav nav-treeview ms-3">
            <?php if ($has_prt_audit): ?>
            <li class="nav-item">
              <a href="Platform-Return-TrainsScorecard.php" class="nav-link <?= ($currentPage == 'Platform-Return-TrainsScorecard.php') ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[10]) ?></p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_prt_chem): ?>
            <li class="nav-item">
              <a href="Platform-Return-Chemical.php" class="nav-link <?= ($currentPage == 'Platform-Return-Chemical.php') ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[11]) ?></p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_prt_mach): ?>
            <li class="nav-item">
              <a href="Platform-Return-Machine.php" class="nav-link <?= ($currentPage == 'Platform-Return-Machine.php') ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[22]) ?></p>
              </a>
            </li>
            <?php endif; ?>
          </ul>
        </li>
        <?php endif; ?>

        <!-- Surprise Visit Dropdown -->
        <?php if ($has_sur_any): ?>
        <?php 
        $surprisePages = ['surprise-pit-office.php', 'surprise-pf-trains.php'];
        $isSurpriseActive = in_array($currentPage, $surprisePages);
        ?>
        <li class="nav-item <?= $isSurpriseActive ? 'menu-open' : '' ?>">
          <a href="#" class="nav-link <?= $isSurpriseActive ? 'active' : '' ?>">
            <i class="nav-icon bi bi-patch-check-fill"></i>
            <p>
              <?= htmlspecialchars($report_names[6]) ?>
              <i class="nav-arrow bi bi-chevron-right"></i>
            </p>
          </a>
          <ul class="nav nav-treeview ms-3">
            <?php if ($has_sur_pit): ?>
            <li class="nav-item">
              <a href="surprise-pit-office.php" class="nav-link <?= ($currentPage == 'surprise-pit-office.php') ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[14]) ?></p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_sur_pf): ?>
            <li class="nav-item">
              <a href="surprise-pf-trains.php" class="nav-link <?= ($currentPage == 'surprise-pf-trains.php') ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[15]) ?></p>
              </a>
            </li>
            <?php endif; ?>
          </ul>
        </li>
        <?php endif; ?>

        <!-- Vande Bharat Cleaning Dropdown -->
        <?php if ($has_vb_any): ?>
        <?php 
        $vbPages = ['vande-bharat-report.php', 'vande-bharat-summary.php', 'vande-bharat-chemical.php', 'vande-bharat-chemical-target.php', 'vande-bharat-chemical-summary.php', 'vande-bharat-machine.php', 'vande-bharat-machine-target.php', 'vande-bharat-machine-summary.php'];
        $isVbActive = in_array($currentPage, $vbPages);
        ?>
        <li class="nav-item <?= $isVbActive ? 'menu-open' : '' ?>">
          <a href="#" class="nav-link <?= $isVbActive ? 'active' : '' ?>">
            <i class="nav-icon bi bi-lightning-charge-fill"></i>
            <p>
              <?= htmlspecialchars($report_names[7]) ?>
              <i class="nav-arrow bi bi-chevron-right"></i>
            </p>
          </a>
          <ul class="nav nav-treeview ms-3">
            <?php if ($has_vb_audit): ?>
            <li class="nav-item">
              <a href="vande-bharat-report.php" class="nav-link <?= in_array($currentPage, ['vande-bharat-report.php', 'vande-bharat-summary.php']) ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[16]) ?></p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_vb_chem): ?>
            <li class="nav-item">
              <a href="vande-bharat-chemical.php" class="nav-link <?= in_array($currentPage, ['vande-bharat-chemical.php', 'vande-bharat-chemical-target.php', 'vande-bharat-chemical-summary.php']) ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[17]) ?></p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_vb_mach): ?>
            <li class="nav-item">
              <a href="vande-bharat-machine.php" class="nav-link <?= in_array($currentPage, ['vande-bharat-machine.php', 'vande-bharat-machine-target.php', 'vande-bharat-machine-summary.php']) ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[18]) ?></p>
              </a>
            </li>
            <?php endif; ?>
          </ul>
        </li>
        <?php endif; ?>

        <!-- Cleanliness Scorecard -->
        <?php if ($has_cleanliness): ?>
        <li class="nav-item">
          <a href="cleanliness.php" class="nav-link <?= ($currentPage == 'cleanliness.php') ? 'active' : '' ?>">
            <i class="nav-icon bi bi-stars"></i>
            <p><?= htmlspecialchars($report_names[9]) ?></p>
          </a>
        </li>
        <?php endif; ?>

        <!-- Photo Report -->
        <?php if ($has_photo_report): ?>
        <li class="nav-item">
          <a href="photo-report.php" class="nav-link <?= ($currentPage == 'photo-report.php') ? 'active' : '' ?>">
            <i class="nav-icon bi bi-camera"></i>
            <p><?= htmlspecialchars($report_names[10]) ?></p>
          </a>
        </li>
        <?php endif; ?>

        <li class="nav-header mt-3 small text-uppercase text-muted opacity-50">Reports & Staff</li>

        <!-- Attendance Dropdown -->
        <?php if ($has_manpower): ?>
        <?php 
        $attendancePages = ['man-power-log.php', 'attendance-report.php'];
        $isAttendanceActive = in_array($currentPage, $attendancePages);
        ?>
        <li class="nav-item <?= $isAttendanceActive ? 'menu-open' : '' ?>">
          <a href="#" class="nav-link <?= $isAttendanceActive ? 'active' : '' ?>">
            <i class="nav-icon bi bi-calendar-check"></i>
            <p>
              <?= htmlspecialchars($report_names[8]) ?>
              <i class="nav-arrow bi bi-chevron-right"></i>
            </p>
          </a>
          <ul class="nav nav-treeview ms-3">
            <li class="nav-item">
              <a href="man-power-log.php" class="nav-link <?= ($currentPage == 'man-power-log.php') ? 'active' : '' ?>">
                <p><?= htmlspecialchars($subreport_names[19]) ?></p>
              </a>
            </li>
          </ul>
        </li>
        <?php endif; ?>

    

        <!-- Employee Management Dropdown -->
        <?php 
        $empPages = ['add-employee.php', 'view-employee.php'];
        $isEmpActive = in_array($currentPage, $empPages);
        ?>
        <li class="nav-item <?= $isEmpActive ? 'menu-open' : '' ?>">
          <a href="#" class="nav-link <?= $isEmpActive ? 'active' : '' ?>">
            <i class="nav-icon bi bi-people"></i>
            <p>
              Emp. Management
              <i class="nav-arrow bi bi-chevron-right"></i>
            </p>
          </a>
          <ul class="nav nav-treeview ms-3">
            <li class="nav-item">
              <a href="add-employee.php" class="nav-link <?= ($currentPage == 'add-employee.php') ? 'active' : '' ?>">
                <p>Add Employee</p>
              </a>
            </li>
            <li class="nav-item">
              <a href="view-employee.php" class="nav-link <?= ($currentPage == 'view-employee.php') ? 'active' : '' ?>">
                <p>View Employees</p>
              </a>
            </li>
          </ul>
        </li>

        <li class="nav-item">
          <a href="Billing.php" class="nav-link <?= ($currentPage == 'Billing.php') ? 'active' : '' ?>">
            <i class="nav-icon bi bi-receipt-cutoff"></i>
            <p>Billing Invoice</p>
          </a>
        </li>

      </ul>
    </nav>
  </div>

</aside>