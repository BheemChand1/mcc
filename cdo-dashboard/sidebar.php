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

$assigned_reports = [];
if (isset($_SESSION['station_id'])) {
    try {
        $stmt = $pdo->prepare("SELECT report_key FROM mcc_station_reports WHERE station_id = :station_id");
        $stmt->execute(['station_id' => $_SESSION['station_id']]);
        $assigned_reports = $stmt->fetchAll(PDO::FETCH_COLUMN);
    } catch (PDOException $e) {
        // Fail silently
    }
}

// Access mapping helper variables
$has_normal_audit = in_array('normal_audit', $assigned_reports);
$has_normal_chem  = in_array('normal_chem', $assigned_reports);
$has_normal_mach  = in_array('normal_mach', $assigned_reports);
$has_normal_any   = $has_normal_audit || $has_normal_chem || $has_normal_mach;

$has_int_audit        = in_array('int_audit', $assigned_reports);
$has_int_chem         = in_array('int_chem', $assigned_reports);
$has_int_mach         = in_array('int_mach', $assigned_reports);
$has_int_scorecard_2  = in_array('int_scorecard_2', $assigned_reports);
$has_int_pantry       = in_array('int_pantry', $assigned_reports);
$has_int_any          = $has_int_audit || $has_int_chem || $has_int_mach || $has_int_scorecard_2;

$has_pldc_audit   = in_array('pldc_audit', $assigned_reports);
$has_pldc_chem    = in_array('pldc_chem', $assigned_reports);
$has_pldc_mach    = in_array('pldc_mach', $assigned_reports);
$has_pldc_any     = $has_pldc_audit || $has_pldc_chem || $has_pldc_mach;

$has_prt_audit    = in_array('prt_audit', $assigned_reports);
$has_prt_chem     = in_array('prt_chem', $assigned_reports);
$has_prt_any      = $has_prt_audit || $has_prt_chem;

$has_sur_pit      = in_array('sur_pit', $assigned_reports);
$has_sur_pf       = in_array('sur_pf', $assigned_reports);
$has_sur_any      = $has_sur_pit || $has_sur_pf;

$has_vb_audit     = in_array('vb_audit', $assigned_reports);
$has_vb_chem      = in_array('vb_chem', $assigned_reports);
$has_vb_mach      = in_array('vb_mach', $assigned_reports);
$has_vb_any       = $has_vb_audit || $has_vb_chem || $has_vb_mach;

$has_manpower     = in_array('manpower', $assigned_reports);
$has_cleanliness  = in_array('cleanliness', $assigned_reports);
$has_photo_report = in_array('photo_report', $assigned_reports);
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
              Normal Cleaning
              <i class="nav-arrow bi bi-chevron-right"></i>
            </p>
          </a>
          <ul class="nav nav-treeview ms-3">
            <?php if ($has_normal_audit): ?>
            <li class="nav-item">
              <a href="normal-report.php" class="nav-link <?= ($currentPage == 'normal-report.php') ? 'active' : '' ?>">
                <p>Normal Report</p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_normal_chem): ?>
            <li class="nav-item">
              <a href="chemical-report.php" class="nav-link <?= ($currentPage == 'chemical-report.php' && !isset($_GET['intensive'])) ? 'active' : '' ?>">
                <p>Chemical Report</p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_normal_mach): ?>
            <li class="nav-item">
              <a href="machine-report.php" class="nav-link <?= in_array($currentPage, ['machine-report.php', 'machine-target.php', 'machine-summary.php']) ? 'active' : '' ?>">
                <p>Machine Report</p>
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
              Intensive Cleaning
              <i class="nav-arrow bi bi-chevron-right"></i>
            </p>
          </a>
          <ul class="nav nav-treeview ms-3">
            <?php if ($has_int_audit): ?>
            <li class="nav-item">
              <a href="intensive-report.php" class="nav-link <?= ($currentPage == 'intensive-report.php') ? 'active' : '' ?>">
                <p>Intensive Report</p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_int_scorecard_2): ?>
            <li class="nav-item">
              <a href="intensive_scorecard_2.php" class="nav-link <?= in_array($currentPage, ['intensive_scorecard_2.php', 'instensive_scorecard_2.php']) ? 'active' : '' ?>">
                <p>Intensive Scorecard 2</p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_int_chem): ?>
            <li class="nav-item">
              <a href="intensive-chemical-report.php" class="nav-link <?= in_array($currentPage, ['intensive-chemical-report.php', 'intensive-chemical-summary.php']) ? 'active' : '' ?>">
                <p>Chemical Report</p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_int_mach): ?>
            <li class="nav-item">
              <a href="machine-report-intensive.php" class="nav-link <?= in_array($currentPage, ['machine-report-intensive.php', 'machine-target-intensive.php', 'machine-summary-intensive.php']) ? 'active' : '' ?>">
                <p>Machine Report</p>
              </a>
            </li>
            <?php endif; ?>
          </ul>
        </li>
        <?php endif; ?>

        <!-- Pantry Car Dropdown -->
        <?php if ($has_int_pantry): ?>
        <?php 
        $pantryPages = ['intensive_pantry_scorecard.php', 'pantry_scorecard.php'];
        $isPantryActive = in_array($currentPage, $pantryPages);
        ?>
        <li class="nav-item <?= $isPantryActive ? 'menu-open' : '' ?>">
          <a href="#" class="nav-link <?= $isPantryActive ? 'active' : '' ?>">
            <i class="nav-icon bi bi-cup-hot"></i>
            <p>
              Pantry Car
              <i class="nav-arrow bi bi-chevron-right"></i>
            </p>
          </a>
          <ul class="nav nav-treeview ms-3">
            <li class="nav-item">
              <a href="intensive_pantry_scorecard.php" class="nav-link <?= in_array($currentPage, ['intensive_pantry_scorecard.php', 'pantry_scorecard.php']) ? 'active' : '' ?>">
                <p>Score Card</p>
              </a>
            </li>
          </ul>
        </li>
        <?php endif; ?>

        <!-- PLDC Cleaning Dropdown -->
        <?php if ($has_pldc_any): ?>
        <?php 
        $pldcPages = ['PLDC-Scorecard.php', 'pldc-chemical.php', 'pldc-machine.php'];
        $isPldcActive = in_array($currentPage, $pldcPages);
        ?>
        <li class="nav-item <?= $isPldcActive ? 'menu-open' : '' ?>">
          <a href="#" class="nav-link <?= $isPldcActive ? 'active' : '' ?>">
            <i class="nav-icon bi bi-shield-check"></i>
            <p>
              PLDC Cleaning
              <i class="nav-arrow bi bi-chevron-right"></i>
            </p>
          </a>
          <ul class="nav nav-treeview ms-3">
            <?php if ($has_pldc_audit): ?>
            <li class="nav-item">
              <a href="PLDC-Scorecard.php" class="nav-link <?= ($currentPage == 'PLDC-Scorecard.php') ? 'active' : '' ?>">
                <p>PLDC Scorecard</p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_pldc_chem): ?>
            <li class="nav-item">
              <a href="pldc-chemical.php" class="nav-link <?= ($currentPage == 'pldc-chemical.php') ? 'active' : '' ?>">
                <p>Chemical Report</p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_pldc_mach): ?>
            <li class="nav-item">
              <a href="pldc-machine.php" class="nav-link <?= ($currentPage == 'pldc-machine.php') ? 'active' : '' ?>">
                <p>Machine Report</p>
              </a>
            </li>
            <?php endif; ?>
          </ul>
        </li>
        <?php endif; ?>

        <!-- PRT Cleaning Dropdown -->
        <?php if ($has_prt_any): ?>
        <?php 
        $prtPages = ['Platform-Return-TrainsScorecard.php', 'Platform-Return-Chemical.php'];
        $isPrtActive = in_array($currentPage, $prtPages);
        ?>
        <li class="nav-item <?= $isPrtActive ? 'menu-open' : '' ?>">
          <a href="#" class="nav-link <?= $isPrtActive ? 'active' : '' ?>">
            <i class="nav-icon bi bi-arrow-repeat"></i>
            <p>
              PRT Cleaning
              <i class="nav-arrow bi bi-chevron-right"></i>
            </p>
          </a>
          <ul class="nav nav-treeview ms-3">
            <?php if ($has_prt_audit): ?>
            <li class="nav-item">
              <a href="Platform-Return-TrainsScorecard.php" class="nav-link <?= ($currentPage == 'Platform-Return-TrainsScorecard.php') ? 'active' : '' ?>">
                <p>PRT ScoreCard</p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_prt_chem): ?>
            <li class="nav-item">
              <a href="Platform-Return-Chemical.php" class="nav-link <?= ($currentPage == 'Platform-Return-Chemical.php') ? 'active' : '' ?>">
                <p>Chemical Report</p>
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
              Surprise Visit
              <i class="nav-arrow bi bi-chevron-right"></i>
            </p>
          </a>
          <ul class="nav nav-treeview ms-3">
            <?php if ($has_sur_pit): ?>
            <li class="nav-item">
              <a href="surprise-pit-office.php" class="nav-link <?= ($currentPage == 'surprise-pit-office.php') ? 'active' : '' ?>">
                <p>Pit & Office Cleaning</p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_sur_pf): ?>
            <li class="nav-item">
              <a href="surprise-pf-trains.php" class="nav-link <?= ($currentPage == 'surprise-pf-trains.php') ? 'active' : '' ?>">
                <p>PF Return Trains</p>
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
              Vande Bharat
              <i class="nav-arrow bi bi-chevron-right"></i>
            </p>
          </a>
          <ul class="nav nav-treeview ms-3">
            <?php if ($has_vb_audit): ?>
            <li class="nav-item">
              <a href="vande-bharat-report.php" class="nav-link <?= in_array($currentPage, ['vande-bharat-report.php', 'vande-bharat-summary.php']) ? 'active' : '' ?>">
                <p>Score Card</p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_vb_chem): ?>
            <li class="nav-item">
              <a href="vande-bharat-chemical.php" class="nav-link <?= in_array($currentPage, ['vande-bharat-chemical.php', 'vande-bharat-chemical-target.php', 'vande-bharat-chemical-summary.php']) ? 'active' : '' ?>">
                <p>Chemical Report</p>
              </a>
            </li>
            <?php endif; ?>
            <?php if ($has_vb_mach): ?>
            <li class="nav-item">
              <a href="vande-bharat-machine.php" class="nav-link <?= in_array($currentPage, ['vande-bharat-machine.php', 'vande-bharat-machine-target.php', 'vande-bharat-machine-summary.php']) ? 'active' : '' ?>">
                <p>Machine Report</p>
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
            <p>Cleanliness</p>
          </a>
        </li>
        <?php endif; ?>

        <!-- Photo Report -->
        <?php if ($has_photo_report): ?>
        <li class="nav-item">
          <a href="photo-report.php" class="nav-link <?= ($currentPage == 'photo-report.php') ? 'active' : '' ?>">
            <i class="nav-icon bi bi-camera"></i>
            <p>Photo Report</p>
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
              Attendance
              <i class="nav-arrow bi bi-chevron-right"></i>
            </p>
          </a>
          <ul class="nav nav-treeview ms-3">
            <li class="nav-item">
              <a href="man-power-log.php" class="nav-link <?= ($currentPage == 'man-power-log.php') ? 'active' : '' ?>">
                <p>Man Power Log</p>
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