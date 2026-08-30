<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
if (!isset($_SESSION['user_id'])) {
    header("Location: ../index.php");
    exit();
}

// Check report access permissions based on user's station assignment
$page_report_mapping = [
    'normal-report.php' => 'normal_audit',
    'normal-summary.php' => 'normal_audit',
    'chemical-report.php' => 'normal_chem',
    'machine-report.php' => 'normal_mach',
    'machine-target.php' => 'normal_mach',
    'machine-summary.php' => 'normal_mach',
    
    'intensive-report.php' => 'int_audit',
    'intensive-summary.php' => 'int_audit',
    'intensive_scorecard_2.php' => 'int_scorecard_2',
    'instensive_scorecard_2.php' => 'int_scorecard_2',
    'intensive_pantry_scorecard.php' => 'int_pantry',
    'pantry_scorecard.php' => 'int_pantry',
    'intensive-chemical-report.php' => 'int_chem',
    'intensive-chemical-summary.php' => 'int_chem',
    'machine-report-intensive.php' => 'int_mach',
    'machine-target-intensive.php' => 'int_mach',
    'machine-summary-intensive.php' => 'int_mach',
    
    'DC-Scorecard.php' => 'dc_audit',
    'DC-Summary.php' => 'dc_audit',
    'dc-chemical.php' => 'dc_chem',
    'dc-chemical-target.php' => 'dc_chem',
    'dc-chemical-summary.php' => 'dc_chem',
    'dc-machine.php' => 'dc_mach',
    'dc-machine-target.php' => 'dc_mach',
    'dc-machine-summary.php' => 'dc_mach',
    
    'Platform-Return-TrainsScorecard.php' => 'prt_audit',
    'Platform-Return-TrainsSummary.php' => 'prt_audit',
    'Platform-Return-Chemical.php' => 'prt_chem',
    'Platform-Return-Chemical-target.php' => 'prt_chem',
    'Platform-Return-Chemical-summary.php' => 'prt_chem',
    
    'surprise-pit-office.php' => 'sur_pit',
    'surprise-pit-office-summary.php' => 'sur_pit',
    'surprise-pf-trains.php' => 'sur_pf',
    'surprise-pf-trains-summary.php' => 'sur_pf',
    
    'vande-bharat-report.php' => 'vb_audit',
    'vande-bharat-summary.php' => 'vb_audit',
    'vande-bharat-chemical.php' => 'vb_chem',
    'vande-bharat-chemical-target.php' => 'vb_chem',
    'vande-bharat-chemical-summary.php' => 'vb_chem',
    'vande-bharat-machine.php' => 'vb_mach',
    'vande-bharat-machine-target.php' => 'vb_mach',
    'vande-bharat-machine-summary.php' => 'vb_mach',
    
    'cleanliness.php' => 'cleanliness',
    'photo-report.php' => 'photo_report'
];

$currentPage = basename($_SERVER['PHP_SELF']);

if (isset($page_report_mapping[$currentPage])) {
    $required_key = $page_report_mapping[$currentPage];
    
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
            // Fail silently or fallback
        }
    }
    
    if (!in_array($required_key, $assigned_reports)) {
        // Access Denied page output
        echo "<!doctype html>
        <html lang='en'>
        <head>
          <meta charset='utf-8'>
          <title>Access Denied | MCC Portal</title>
          <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/admin-lte@4.0.0-beta3/dist/css/adminlte.css' />
          <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css' />
          <style>
            body { font-family: sans-serif; background-color: #f8fafc; height: 100vh; display: flex; align-items: center; justify-content: center; margin: 0; }
            .error-card { max-width: 500px; padding: 40px; background: white; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); text-align: center; border-top: 4px solid #ef4444; }
            .icon-wrapper { font-size: 4rem; color: #ef4444; margin-bottom: 20px; }
            h2 { margin: 0 0 10px; color: #1e293b; font-weight: 700; }
            p { color: #64748b; margin-bottom: 25px; font-size: 0.95rem; line-height: 1.5; }
            .btn-back { background: #1987C6; color: white !important; border: none; padding: 10px 24px; border-radius: 8px; text-decoration: none; font-weight: 600; display: inline-flex; align-items: center; gap: 8px; transition: opacity 0.2s; }
            .btn-back:hover { opacity: 0.9; }
          </style>
        </head>
        <body>
          <div class='error-card'>
            <div class='icon-wrapper'><i class='bi bi-shield-slash-fill'></i></div>
            <h2>Access Denied</h2>
            <p>Your station does not have permission to view this report profile. Please contact the system administrator to assign the necessary permissions.</p>
            <a href='index.php' class='btn-back'><i class='bi bi-arrow-left'></i> Back to Dashboard</a>
          </div>
        </body>
        </html>";
        exit();
    }
}
?>
<!doctype html>
<html lang="en">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title><?php echo isset($pageTitle) ? $pageTitle : 'MCC Dashboard'; ?></title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="color-scheme" content="light dark" />
  <meta name="theme-color" content="#007bff" media="(prefers-color-scheme: light)" />
  <meta name="theme-color" content="#1a1a1a" media="(prefers-color-scheme: dark)" />

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.10.1/styles/overlayscrollbars.min.css"
    integrity="sha256-tZHrRjVqNSRyWg2wbppGnT833E/Ys0DHWGwT04GiqQg=" crossorigin="anonymous" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
    integrity="sha256-9kPW/n5nn53j4WMRYAxe9c1rCY96Oogo/MKSVdKzPmI=" crossorigin="anonymous" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@4.0.0-beta3/dist/css/adminlte.css" />
  <!-- Flatpickr CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/material_blue.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

  <!--begin::Report Theme CSS-->
  <link rel="stylesheet" href="./assets/css/report-theme.css" />
  <!--end::Report Theme CSS-->

  <?php if (isset($extraStyles)): ?>
    <style>
      <?php echo $extraStyles; ?>
    </style>
  <?php endif; ?>
  <style>
    :root {
      --lte-sidebar-width: 235px !important;
    }

    html,
    body,
    .app-wrapper,
    .app-header,
    .app-header *,
    .app-sidebar,
    .app-sidebar *,
    .nav-sidebar,
    .nav-sidebar *,
    .sidebar-wrapper,
    .sidebar-wrapper * {
      font-family: 'Inter', system-ui, -apple-system, "Segoe UI", Roboto, Arial, sans-serif !important;
      -webkit-font-smoothing: antialiased !important;
      -moz-osx-font-smoothing: grayscale !important;
      text-rendering: optimizeLegibility !important;
    }

    body {
      font-size: 13px;
      font-weight: 400;
    }

    .app-header.navbar {
      background: linear-gradient(180deg, #061a2c 0%, #03101e 100%) !important;
      border-bottom: 1px solid #0b476a !important;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.4) !important;
      font-family: 'Inter', "Segoe UI", Arial, sans-serif !important;
      height: 48px;
    }

    .app-header .nav-link {
      color: #f4f8fc !important;
      font-weight: 500 !important;
      font-size: 12.5px !important;
      letter-spacing: 0.2px !important;
      font-family: 'Inter', "Segoe UI", Arial, sans-serif !important;
      transition: all 0.2s ease;
      display: inline-flex;
      align-items: center;
      gap: 6px;
    }

    .app-header .nav-link:hover {
      color: #13c9ff !important;
    }

    table thead th,
    .report-table thead th,
    .scorecard-table thead th,
    .table thead th {
      background: linear-gradient(180deg, #07203a 0%, #07182c 100%) !important;
      color: #ffffff !important;
      font-weight: 600 !important;
      border-color: #0b476a !important;
    }

    table input,
    table select,
    table textarea {
      font-size: 15px !important;
    }

    /* Global Report Overrides */
    .report-container,
    .report-frame,
    .report-filter {
      font-weight: 400 !important;
      font-size: 15px !important;
    }

    .report-container strong,
    .report-frame strong,
    .report-filter label,
    .report-filter button,
    .report-filter a,
    .report-title {
      font-weight: 600 !important;
    }

    /* Global Report Filter Standard */
    .report-filter {
      background: #fff !important;
      border: 1px solid #e2e8f0 !important;
      border-radius: 12px !important;
      padding: 15px 25px !important;
      margin: 20px auto !important;
      display: flex !important;
      flex-direction: row !important;
      align-items: center !important;
      justify-content: center !important;
      gap: 15px !important;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06) !important;
      width: 100% !important;
      max-width: 100% !important;
      box-sizing: border-box !important;
      flex-wrap: nowrap !important;
    }

    .report-filter label {
      font-size: 15px !important;
      font-weight: 700 !important;
      margin: 0 !important;
      color: #334155 !important;
      white-space: nowrap !important;
    }

    /* Flatpickr CSS */
    .flatpickr-input {
      background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%2364748b' class='bi bi-calendar3' viewBox='0 0 16 16'%3E%3Cpath d='M14 0H2a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zM1 3.857C1 3.384 1.448 3 2 3h12c.552 0 1 .384 1 .857v10.286c0 .473-.448.857-1 .857H2c-.552 0-1-.384-1-.857V3.857z'/%3E%3Cpath d='M6.5 7a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm-9 3a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm-9 3a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm3 0a1 1 0 1 0 0-2 1 1 0 0 0 0 2z'/%3E%3C/svg%3E") !important;
      background-repeat: no-repeat !important;
      background-position: right 12px center !important;
      background-size: 16px !important;
      padding-right: 36px !important;
      cursor: pointer !important;
    }

    .report-filter input[type="date"],
    .report-filter .flatpickr-input {
      border: 1px solid #cbd5e1 !important;
      border-radius: 8px !important;
      padding: 8px 12px !important;
      font-size: 15px !important;
      font-family: inherit !important;
      font-weight: 400 !important;
      width: 170px !important;
      flex: 0 0 auto !important;
      color: #334155 !important;
      background-color: #f8fafc !important;
    }

    .report-filter .btn-go,
    .report-filter .btn-summary,
    .report-filter .btn-print {
      padding: 8px 24px !important;
      border-radius: 8px !important;
      font-size: 15px !important;
      font-weight: 700 !important;
      cursor: pointer !important;
      white-space: nowrap !important;
      transition: all 0.3s ease !important;
      margin: 0 !important;
      text-decoration: none !important;
      display: inline-flex !important;
      align-items: center !important;
      justify-content: center !important;
      height: 42px !important;
      border: none !important;
    }

    .report-filter .btn-go,
    .btn-go {
      background: linear-gradient(135deg, #13c9ff 0%, #0284c7 100%) !important;
      color: #ffffff !important;
      box-shadow: 0 2px 8px rgba(19, 201, 255, 0.3) !important;
    }

    .report-filter .btn-summary,
    .btn-summary {
      background: linear-gradient(135deg, #0d5f99 0%, #072e4a 100%) !important;
      color: #ffffff !important;
      border: 1px solid #167db3 !important;
    }

    .report-filter .btn-print,
    .btn-print {
      background: linear-gradient(135deg, #07385f 0%, #042540 100%) !important;
      color: #ffffff !important;
      border: 1px solid #0b476a !important;
    }

    .report-filter .btn-go:hover,
    .report-filter .btn-summary:hover,
    .report-filter .btn-print:hover,
    .btn-go:hover,
    .btn-summary:hover,
    .btn-print:hover {
      transform: translateY(-2px) !important;
      box-shadow: 0 8px 16px -2px rgba(0, 0, 0, 0.3) !important;
      opacity: 0.95 !important;
    }

    /* Force remove inner vertical scrollbars globally */
    html,
    body {
      height: auto !important;
      overflow: visible !important;
      overflow-y: visible !important;
    }

    .app-wrapper,
    .app-main,
    .content-wrapper,
    .app-content {
      height: auto !important;
      min-height: 100vh !important;
      overflow: visible !important;
      overflow-y: visible !important;
    }

    /* Target specific components that often have inner scrollbars */
    /* Universal Print Stylesheet to guarantee only report sheets print */
    @media print {
      @page {
        size: auto;
        margin: 5mm 8mm 5mm 8mm !important;
      }

      .app-header,
      .app-sidebar,
      .app-footer,
      .sidebar,
      .sidebar-wrapper,
      .sidebar-brand,
      .sidebar-footer,
      .report-filter,
      form.report-filter,
      div.no-print,
      .no-print,
      .sidebar-overlay,
      .sidebar-backdrop,
      #sidebar-overlay {
        display: none !important;
        opacity: 0 !important;
        visibility: hidden !important;
        height: 0 !important;
        width: 0 !important;
        padding: 0 !important;
        margin: 0 !important;
      }

      html,
      body,
      .bg-body-tertiary,
      .app-wrapper,
      .app-main,
      .app-content,
      .container-fluid,
      .report-wrap,
      .report-shell {
        margin: 0 !important;
        padding: 0 !important;
        width: 100% !important;
        max-width: 100% !important;
        min-width: 100% !important;
        background: #fff !important;
        background-color: #fff !important;
        box-shadow: none !important;
        position: static !important;
        overflow: visible !important;
      }

      .app-main {
        padding-top: 0 !important;
        margin-left: 0 !important;
      }

      .report-frame,
      .scorecard-sheet,
      .chemical-sheet,
      .machine-sheet,
      .summary-sheet-frame {
        border: none !important;
        box-shadow: none !important;
        background: #fff !important;
        margin-bottom: 0 !important;
        page-break-after: always !important;
        break-after: page !important;
        page-break-inside: avoid !important;
        break-inside: avoid !important;
      }

      .report-frame:last-child,
      .scorecard-sheet:last-child,
      .chemical-sheet:last-child,
      .machine-sheet:last-child,
      .summary-sheet-frame:last-child {
        page-break-after: avoid !important;
        break-after: avoid !important;
      }

      .report-table thead th,
      .scorecard-table thead th,
      table thead th {
        background-color: #07203a !important;
        background: #07203a !important;
        color: #fff !important;
        -webkit-print-color-adjust: exact !important;
        print-color-adjust: exact !important;
      }
    }
  </style>
</head>

<body class="layout-fixed sidebar-expand-lg bg-body-tertiary">
  <div class="app-wrapper">

    <nav class="app-header navbar navbar-expand" data-bs-theme="dark">
      <!--begin::Container-->
      <div class="container-fluid">
        <!--begin::Start Navbar Links-->
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link" data-lte-toggle="sidebar" href="#" role="button">
              <i class="bi bi-list"></i>
            </a>
          </li>
          <li class="nav-item d-none d-md-block">
            <a href="./index.php" class="nav-link">Home</a>
          </li>
          <li class="nav-item d-none d-md-block">
            <a href="#" class="nav-link">Contact</a>
          </li>
          <!-- <li class="nav-item d-none d-md-block">
            <marquee> <a href="#" class="nav-link">Lumding Station</a></marquee>
          </li> -->
        </ul>
        <!--end::Start Navbar Links-->

        <!--begin::End Navbar Links-->
        <ul class="navbar-nav ms-auto">
          <!--begin::Navbar Search-->
          <li class="nav-item">
            <a class="nav-link" data-widget="navbar-search" href="#" role="button">
              <i class="bi bi-search"></i>
            </a>
          </li>
          <!--end::Navbar Search-->

          <!--begin::Fullscreen Toggle-->
          <li class="nav-item">
            <a class="nav-link" href="#" data-lte-toggle="fullscreen">
              <i data-lte-icon="maximize" class="bi bi-arrows-fullscreen"></i>
              <i data-lte-icon="minimize" class="bi bi-fullscreen-exit" style="display: none"></i>
            </a>
          </li>
          <!--end::Fullscreen Toggle-->

          <!--begin::User Menu Dropdown-->
          <li class="nav-item dropdown user-menu">
            <a href="../logout.php" class="nav-link dropdown-toggle">
              <span class="d-none d-md-inline"><i class="bi bi-box-arrow-right"></i> Logout</span>
            </a>
          </li>
          <!--end::User Menu Dropdown-->
        </ul>
        <!--end::End Navbar Links-->
      </div>
      <!--end::Container-->
    </nav>
    <!--end::Header-->