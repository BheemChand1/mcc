<?php
/**
 * MCC - Admin Panel Header Template
 * Establishes authentication restrictions and sets up resources.
 */
if (session_status() === PHP_SESSION_NONE) {
    session_name('MCC_ADMIN_SESS');
    session_start();
}

// RESTRICT ACCESS to ADMIN only
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'ADMIN') {
    header("Location: login.php");
    exit();
}

$pageTitle = isset($pageTitle) ? $pageTitle : 'MCC Admin Dashboard';
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title><?php echo htmlspecialchars($pageTitle); ?></title>
  
  <!-- CSS Fonts & Framework Libraries -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fontsource/source-sans-3@5.0.12/index.css" />
  <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.10.1/styles/overlayscrollbars.min.css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@4.0.0-beta3/dist/css/adminlte.css" />
  
  <!-- ChartJS CDN for interactive charts -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

  <!-- Theme overrides for a premium, custom Admin Panel feel -->
  <style>
    :root {
      --admin-primary: #6366f1; /* Modern Indigo */
      --admin-primary-dark: #4f46e5;
      --admin-bg: #f8fafc;
      --admin-panel-bg: #ffffff;
      --admin-text-dark: #0f172a;
      --admin-text-muted: #64748b;
      --admin-border: #e2e8f0;
      
      /* AdminLTE overrides */
      --lte-brand-bg: #1e1b4b !important;
      --lte-brand-color: #ffffff !important;
    }

    body {
      font-family: 'Outfit', 'Source Sans 3', sans-serif;
      background-color: var(--admin-bg);
      color: var(--admin-text-dark);
      -webkit-font-smoothing: antialiased;
    }

    /* Top navbar styled beautifully with modern purple-indigo theme */
    .app-header.navbar {
      background: linear-gradient(135deg, var(--admin-primary) 0%, var(--admin-primary-dark) 100%) !important;
      border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      box-shadow: 0 4px 12px rgba(99, 102, 241, 0.15);
    }

    .app-header .nav-link {
      color: rgba(255, 255, 255, 0.9) !important;
      font-weight: 500;
      transition: color 0.2s ease;
    }

    .app-header .nav-link:hover {
      color: #ffffff !important;
    }

    /* Smooth page scroll override */
    html, body {
      height: auto !important;
      overflow-x: hidden;
    }

    .app-wrapper, .app-main, .app-content {
      height: auto !important;
      min-height: 100vh !important;
    }

    .app-main {
      padding-top: 15px;
      background: #f1f5f9;
    }

    /* Premium styled tables */
    .table thead th {
      background: linear-gradient(180deg, var(--admin-primary) 0%, var(--admin-primary-dark) 100%) !important;
      color: white !important;
      font-weight: 600 !important;
      font-size: 0.9rem;
      border: none;
      letter-spacing: 0.5px;
    }

    .table tbody td {
      vertical-align: middle;
      font-size: 0.92rem;
      color: #334155;
    }

    .card {
      border: 1px solid var(--admin-border);
      border-radius: 16px;
      box-shadow: 0 4px 20px rgba(15, 23, 42, 0.03);
      overflow: hidden;
      margin-bottom: 25px;
    }

    .card-header {
      background-color: #ffffff;
      border-bottom: 1px solid var(--admin-border);
      padding: 18px 24px;
      font-weight: 700;
    }

    /* Micro animations for interactive components */
    .kpi-card-custom {
      background: #ffffff;
      border: 1px solid var(--admin-border);
      border-radius: 16px;
      padding: 22px;
      transition: all 0.3s cubic-bezier(0.165, 0.84, 0.44, 1);
      box-shadow: 0 4px 15px rgba(0,0,0,0.02);
      height: 100%;
      position: relative;
      overflow: hidden;
    }

    .kpi-card-custom::before {
      content: '';
      position: absolute;
      left: 0;
      top: 0;
      height: 100%;
      width: 4px;
      background: var(--admin-primary);
      opacity: 0;
      transition: opacity 0.3s ease;
    }

    .kpi-card-custom:hover {
      transform: translateY(-4px);
      box-shadow: 0 12px 25px rgba(15, 23, 42, 0.06);
      border-color: rgba(99, 102, 241, 0.2);
    }

    .kpi-card-custom:hover::before {
      opacity: 1;
    }

    .kpi-card-custom .icon-box {
      width: 48px;
      height: 48px;
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-size: 1.35rem;
    }

    /* Custom style classes */
    .badge-admin {
      background-color: rgba(99, 102, 241, 0.12) !important;
      color: var(--admin-primary) !important;
      border: 1px solid rgba(99, 102, 241, 0.2);
      font-weight: 600;
    }

    .badge-active {
      background-color: rgba(34, 197, 94, 0.12) !important;
      color: #16a34a !important;
      border: 1px solid rgba(34, 197, 94, 0.2);
      font-weight: 600;
    }

    /* Indigo Utility overrides to fix hidden text on standard bootstrap setups */
    .text-indigo {
      color: var(--admin-primary) !important;
    }
    .bg-indigo-subtle {
      background-color: rgba(99, 102, 241, 0.12) !important;
    }
    .border-indigo-subtle {
      border-color: rgba(99, 102, 241, 0.2) !important;
    }
  </style>
  
  <?php if (isset($extraStyles)) echo "<style>$extraStyles</style>"; ?>
</head>

<body class="layout-fixed sidebar-expand-lg bg-body-tertiary">
  <div class="app-wrapper">

    <!-- Navbar -->
    <nav class="app-header navbar navbar-expand navbar-dark bg-primary" data-bs-theme="dark">
      <div class="container-fluid">
        <!-- Sidebar Toggle -->
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link" data-lte-toggle="sidebar" href="#" role="button">
              <i class="bi bi-list"></i>
            </a>
          </li>
          <li class="nav-item d-none d-md-block">
            <a href="index.php" class="nav-link">Dashboard Home</a>
          </li>
          <li class="nav-item d-none d-md-block">
            <a href="../cdo-dashboard/index.php" class="nav-link" target="_blank">CDO Live Portal <i class="bi bi-box-arrow-up-right small"></i></a>
          </li>
        </ul>

        <!-- Right Side Nav -->
        <ul class="navbar-nav ms-auto">
          <!-- Fullscreen Toggle -->
          <li class="nav-item">
            <a class="nav-link" href="#" data-lte-toggle="fullscreen">
              <i data-lte-icon="maximize" class="bi bi-arrows-fullscreen"></i>
              <i data-lte-icon="minimize" class="bi bi-fullscreen-exit" style="display: none"></i>
            </a>
          </li>
          
          <!-- User Profile & Logout -->
          <li class="nav-item dropdown user-menu">
            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
              <span class="d-none d-md-inline me-1"><i class="bi bi-person-circle"></i> Admin Profile (<?php echo htmlspecialchars($_SESSION['username']); ?>)</span>
            </a>
            <ul class="dropdown-menu dropdown-menu-lg dropdown-menu-end shadow-lg" style="border-radius: 12px; border: 1px solid var(--admin-border);">
              <!-- User Header -->
              <li class="p-3 text-center bg-light" style="border-top-left-radius: 12px; border-top-right-radius: 12px;">
                <h6 class="mb-0 text-dark font-weight-bold"><?php echo htmlspecialchars($_SESSION['user_name']); ?></h6>
                <small class="text-muted">System Administrator</small>
              </li>
              <!-- Menu Footer-->
              <li class="p-2 d-flex justify-content-between align-items-center bg-white" style="border-bottom-left-radius: 12px; border-bottom-right-radius: 12px;">
                <a href="../cdo-dashboard/index.php" class="btn btn-outline-secondary btn-sm" target="_blank">CDO Portal</a>
                <a href="logout.php" class="btn btn-danger btn-sm"><i class="bi bi-box-arrow-right"></i> Sign Out</a>
              </li>
            </ul>
          </li>
        </ul>
      </div>
    </nav>
    <!-- End Navbar -->
