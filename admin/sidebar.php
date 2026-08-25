<?php
/**
 * MCC - Admin Panel Sidebar Template
 * Navigation sidebar for System Administrators.
 */
$currentPage = basename($_SERVER['PHP_SELF']);
?>
<aside class="app-sidebar shadow-lg" data-bs-theme="dark" style="background: #0f172a !important;">
  <!-- Sidebar Brand Logo -->
  <div class="sidebar-brand text-center d-flex align-items-center justify-content-center" style="height: 180px; border-bottom: 1px solid rgba(255,255,255,0.05); background: rgba(0,0,0,0.2);">
    <a href="index.php" class="brand-link d-flex flex-column align-items-center justify-content-center text-decoration-none">
      <img src="../cdo-dashboard/Indian_Railways.svg" alt="Indian Railways Logo" class="brand-image mb-2" style="max-height: 90px; width: auto;" />
      <span class="brand-text text-white font-weight-bold" style="font-size: 1rem; letter-spacing: 1.5px; text-transform: uppercase;">MCC Admin</span>
    </a>
  </div>

  <!-- Sidebar Wrapper -->
  <div class="sidebar-wrapper" style="padding: 20px 12px;">
    <nav class="mt-2">
      <ul class="nav sidebar-menu flex-column" data-lte-toggle="treeview" role="navigation">
        
        <!-- Dashboard Link -->
        <li class="nav-item mb-2">
          <a href="index.php" class="nav-link p-2 d-flex align-items-center rounded-3 <?= ($currentPage == 'index.php') ? 'active bg-indigo text-white' : 'text-secondary-emphasis' ?>" style="transition: all 0.3s ease; font-weight: 500;">
            <i class="bi bi-speedometer2 me-3" style="font-size: 1.15rem;"></i>
            <p class="m-0">Admin Dashboard</p>
          </a>
        </li>

        <li class="nav-header mt-3 small text-uppercase text-muted opacity-50 font-weight-bold">Configuration Panel</li>

        <!-- Zones Link -->
        <li class="nav-item mb-1">
          <a href="zones.php" class="nav-link p-2 d-flex align-items-center rounded-3 <?= ($currentPage == 'zones.php') ? 'active bg-indigo text-white' : 'text-secondary-emphasis' ?>" style="transition: all 0.3s ease;">
            <i class="bi bi-globe2 me-3" style="font-size: 1.15rem;"></i>
            <p class="m-0">Manage Zones</p>
          </a>
        </li>

        <!-- Divisions Link -->
        <li class="nav-item mb-1">
          <a href="divisions.php" class="nav-link p-2 d-flex align-items-center rounded-3 <?= ($currentPage == 'divisions.php') ? 'active bg-indigo text-white' : 'text-secondary-emphasis' ?>" style="transition: all 0.3s ease;">
            <i class="bi bi-diagram-3 me-3" style="font-size: 1.15rem;"></i>
            <p class="m-0">Manage Divisions</p>
          </a>
        </li>

        <!-- Stations Link -->
        <li class="nav-item mb-1">
          <a href="stations.php" class="nav-link p-2 d-flex align-items-center rounded-3 <?= ($currentPage == 'stations.php') ? 'active bg-indigo text-white' : 'text-secondary-emphasis' ?>" style="transition: all 0.3s ease;">
            <i class="bi bi-geo-alt me-3" style="font-size: 1.15rem;"></i>
            <p class="m-0">Manage Stations</p>
          </a>
        </li>

        <!-- Users Link -->
        <li class="nav-item mb-1">
          <a href="users.php" class="nav-link p-2 d-flex align-items-center rounded-3 <?= ($currentPage == 'users.php') ? 'active bg-indigo text-white' : 'text-secondary-emphasis' ?>" style="transition: all 0.3s ease;">
            <i class="bi bi-person-fill-gear me-3" style="font-size: 1.15rem;"></i>
            <p class="m-0">Manage Users</p>
          </a>
        </li>

        <!-- Assign Reports Link -->
        <li class="nav-item mb-1">
          <a href="assign-reports.php" class="nav-link p-2 d-flex align-items-center rounded-3 <?= ($currentPage == 'assign-reports.php') ? 'active bg-indigo text-white' : 'text-secondary-emphasis' ?>" style="transition: all 0.3s ease;">
            <i class="bi bi-file-earmark-check-fill me-3" style="font-size: 1.15rem;"></i>
            <p class="m-0">Assign Reports</p>
          </a>
        </li>

        <!-- Manage Parameters Link -->
        <li class="nav-item mb-1">
          <a href="report-parameters.php" class="nav-link p-2 d-flex align-items-center rounded-3 <?= ($currentPage == 'report-parameters.php') ? 'active bg-indigo text-white' : 'text-secondary-emphasis' ?>" style="transition: all 0.3s ease;">
            <i class="bi bi-sliders me-3" style="font-size: 1.15rem;"></i>
            <p class="m-0">Manage Parameters</p>
          </a>
        </li>

        <!-- Setup Billing Link -->
        <li class="nav-item mb-1">
          <a href="setup-billing.php" class="nav-link p-2 d-flex align-items-center rounded-3 <?= ($currentPage == 'setup-billing.php') ? 'active bg-indigo text-white' : 'text-secondary-emphasis' ?>" style="transition: all 0.3s ease;">
            <i class="bi bi-wallet2 me-3" style="font-size: 1.15rem;"></i>
            <p class="m-0">Setup Billing</p>
          </a>
        </li>

      </ul>
    </nav>
  </div>

  <!-- Sidebar Footer -->
  <div class="sidebar-footer" style="padding: 15px; border-top: 1px solid rgba(255,255,255,0.05); background: rgba(0,0,0,0.15); margin-top: auto;">
    <a href="logout.php" class="btn btn-danger w-100 p-2 rounded-3 d-flex align-items-center justify-content-center font-weight-bold" style="font-size: 0.9rem; gap: 8px;">
      <i class="bi bi-box-arrow-left"></i> Logout Admin
    </a>
  </div>
</aside>

<style>
  /* Sidebar Layout fixes to prevent breaking on scroll */
  .app-sidebar {
    position: fixed !important;
    top: 0;
    bottom: 0;
    left: 0;
    height: 100vh !important;
    z-index: 1030;
    display: flex !important;
    flex-direction: column !important;
  }

  .sidebar-wrapper {
    flex: 1 1 auto !important;
    overflow-y: auto !important;
    max-height: calc(100vh - 180px - 70px) !important;
  }

  /* Layout shifts to accommodate the fixed sidebar on desktop */
  @media (min-width: 992px) {
    .app-main, .app-header {
      margin-left: 250px !important;
      width: calc(100% - 250px) !important;
    }
  }

  /* Navigation sidebar styling overrides */
  .nav-sidebar .nav-link {
    color: #94a3b8 !important;
  }
  
  .nav-sidebar .nav-link:hover {
    background: rgba(255, 255, 255, 0.04) !important;
    color: #ffffff !important;
  }

  .nav-sidebar .nav-link.active {
    background-color: var(--admin-primary) !important;
    color: #ffffff !important;
    box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3) !important;
  }
</style>
