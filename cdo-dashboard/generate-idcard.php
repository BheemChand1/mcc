<?php
require_once 'auth.php';

// Fetch Employee Record
$empIdParam = $_GET['id'] ?? ($_GET['employee_id'] ?? null);
$employee = null;

if ($empIdParam) {
    if (is_numeric($empIdParam)) {
        $stmt = $pdo->prepare("SELECT * FROM mcc_employee WHERE id = ?");
        $stmt->execute([$empIdParam]);
    } else {
        $stmt = $pdo->prepare("SELECT * FROM mcc_employee WHERE employee_id = ?");
        $stmt->execute([$empIdParam]);
    }
    $employee = $stmt->fetch(PDO::FETCH_ASSOC);
}

if (!$employee) {
    // Fallback to first employee for current station if available
    $stmt = $pdo->prepare("SELECT * FROM mcc_employee WHERE station_id = ? ORDER BY id ASC LIMIT 1");
    $stmt->execute([$stationId]);
    $employee = $stmt->fetch(PDO::FETCH_ASSOC);
    if (!$employee) {
        $stmt = $pdo->query("SELECT * FROM mcc_employee ORDER BY id ASC LIMIT 1");
        $employee = $stmt->fetch(PDO::FETCH_ASSOC) ?: [
            'full_name' => '',
            'employee_id' => '',
            'designation' => '',
            'employee_photo' => '',
            'issue_date' => '',
            'valid_upto_date' => '',
            'ren_id' => '',
            'rakshak_id' => '',
            'aadhar_number' => '',
            'blood_group' => 'B+',
            'department' => 'MECHANICAL',
            'mobile_number' => '',
            'address' => ''
        ];
    }
}

// Determine Station ID
$currentStationId = !empty($employee['station_id']) ? intval($employee['station_id']) : intval($stationId);
if ($currentStationId !== intval($stationId)) {
    $stnStmt = $pdo->prepare("
        SELECT 
            s.station_name, 
            s.contractor_name,
            d.division_name, 
            z.zone_name 
        FROM mcc_stations s
        LEFT JOIN mcc_divisions d ON s.division_id = d.division_id
        LEFT JOIN mcc_zones z ON d.zone_id = z.zone_id
        WHERE s.station_id = :station_id
    ");
    $stnStmt->execute(['station_id' => $currentStationId]);
    $stData = $stnStmt->fetch(PDO::FETCH_ASSOC);
    if ($stData) {
        $railwayName = strtoupper($stData['zone_name'] ?? $railwayName);
        $divisionName = strtoupper($stData['division_name'] ?? $divisionName);
        $stationName = ucfirst($stData['station_name'] ?? $stationName);
        $contractorName = $stData['contractor_name'] ?? $contractorName;
    }
}

// Stations 4 (Silchar) and 5 (Agartala) use the Indian Railway Orange ID Card layout
$isRailwayCard = in_array($currentStationId, [4, 5]);

// Station code & depot metadata
if ($currentStationId === 5) {
    $stnCode = 'AGTL';
    $depotName = 'Coaching Depot Agartala';
} elseif ($currentStationId === 4) {
    $stnCode = 'SCL';
    $depotName = 'Coaching Depot Silchar';
} else {
    $stnCode = strtoupper(substr($stationName ?? 'STN', 0, 4));
    $depotName = 'Coaching Depot ' . ($stationName ?? '');
}

// Resolve photo path
$photoSrc = 'assets/img/avatar.png';
if (!empty($employee['employee_photo'])) {
    $customPhoto = 'uploads/' . $employee['employee_photo'];
    if (file_exists(__DIR__ . '/' . $customPhoto)) {
        $photoSrc = $customPhoto;
    } elseif (file_exists(__DIR__ . '/../editor/' . $customPhoto)) {
        $photoSrc = '../editor/' . $customPhoto;
    } elseif (file_exists(__DIR__ . '/../auditor/' . $customPhoto)) {
        $photoSrc = '../auditor/' . $customPhoto;
    }
}

// Fields for Railway ID Card (Station 4 and 5)
$rawName        = trim($employee['full_name'] ?? '');
$displayName    = !empty($rawName) ? ucwords(strtolower($rawName)) : 'Employee Name';
$bloodGroup     = !empty($employee['blood_group']) ? strtoupper(trim($employee['blood_group'])) : 'B+';
$department     = !empty($employee['department']) ? strtoupper(trim($employee['department'])) : 'MECHANICAL';
$mobileNumber   = !empty($employee['mobile_number']) ? trim($employee['mobile_number']) : '6009892475';
$contractNo     = !empty($employee['contract_no']) ? $employee['contract_no'] : 'GEMC-511687798115171';

// Format Aadhaar: XXXX-XXXX-XXXX
$rawAadhar = preg_replace('/\D/', '', $employee['aadhar_number'] ?? '');
if (strlen($rawAadhar) === 12) {
    $aadharFormatted = substr($rawAadhar, 0, 4) . '-' . substr($rawAadhar, 4, 4) . '-' . substr($rawAadhar, 8, 4);
} elseif (!empty($rawAadhar)) {
    $aadharFormatted = implode('-', str_split($rawAadhar, 4));
} else {
    $aadharFormatted = '3534-7401-1368';
}

// Format ID Card No: e.g. 2025-005 or 2026-001
$empIdStr = trim($employee['employee_id'] ?? '');
if (preg_match('/(\d{2})-(\d{2})\/(\d+)/', $empIdStr, $m)) {
    $cardNo = '20' . $m[1] . '-' . str_pad($m[3], 3, '0', STR_PAD_LEFT);
} elseif (preg_match('/(\d{4})[-_](\d+)/', $empIdStr, $m)) {
    $cardNo = $m[1] . '-' . str_pad($m[2], 3, '0', STR_PAD_LEFT);
} elseif (preg_match('/(\d+)/', $empIdStr, $m)) {
    $cardNo = date('Y') . '-' . str_pad($m[1], 3, '0', STR_PAD_LEFT);
} elseif (!empty($empIdStr)) {
    $cardNo = $empIdStr;
} else {
    $cardNo = '2025-005';
}

// Format dates
$issueDateValid = !empty($employee['issue_date']) && $employee['issue_date'] !== '0000-00-00';
$validUptoValid = !empty($employee['valid_upto_date']) && $employee['valid_upto_date'] !== '0000-00-00';

$issueDateFormatted = $issueDateValid ? date('d M Y', strtotime($employee['issue_date'])) : '22 Aug 2025';
$validUptoFormatted = $validUptoValid ? date('d M Y', strtotime($employee['valid_upto_date'])) : '22 Jan 2026';

// QR Code text data as specified in Railway Board Annexure-'B'
$policeVerStr = (!empty($employee['police_ver_dt']) && $employee['police_ver_dt'] !== '0000-00-00')
    ? date('d/m/Y', strtotime($employee['police_ver_dt']))
    : (!empty($employee['police_ver']) ? $employee['police_ver'] : 'Verified');

$qrLines = [
    "Name: " . ($employee['full_name'] ?? ''),
    "Address: " . (!empty($employee['address']) ? $employee['address'] : 'Badharghat, West Tripura - 799003'),
    "Aadhaar No: " . $aadharFormatted,
    "Date of Issue: " . $issueDateFormatted,
    "Validity Upto: " . $validUptoFormatted,
    "Police Verification: " . $policeVerStr,
    "Agency: " . ($contractorName ?? 'BIPS'),
    "Issuing Authority: SSE/IC/CHG/" . $stnCode
];
$qrDataText = implode("\n", $qrLines);

// Fields for SMC Card (Station 1 etc.)
$fullName     = !empty($employee['full_name']) ? htmlspecialchars(strtoupper(trim($employee['full_name']))) : '';
$regNo        = !empty($employee['employee_id']) ? htmlspecialchars(strtoupper(trim($employee['employee_id']))) : '';
$designation  = !empty($employee['designation']) ? htmlspecialchars(strtoupper(trim($employee['designation']))) : '';
$empTempId    = !empty($employee['ren_id']) ? htmlspecialchars(strtoupper(trim($employee['ren_id']))) : (!empty($employee['rakshak_id']) ? htmlspecialchars(strtoupper(trim($employee['rakshak_id']))) : '');
$unitName     = 'SMC';
$siteLocation = !empty($stationName) ? htmlspecialchars(strtoupper(trim($stationName))) : 'MYSORE';

$validityStr = '';
if ($issueDateValid && $validUptoValid) {
    $validityStr = date('d/m/y', strtotime($employee['issue_date'])) . ' to ' . date('d/m/y', strtotime($employee['valid_upto_date']));
} elseif ($validUptoValid) {
    $validityStr = 'to ' . date('d/m/y', strtotime($employee['valid_upto_date']));
} elseif ($issueDateValid) {
    $validityStr = date('d/m/y', strtotime($employee['issue_date']));
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ID Card - <?= !empty($employee['full_name']) ? htmlspecialchars($employee['full_name']) : 'Employee' ?></title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Caveat:wght@600;700&family=Roboto:wght@400;500;700;900&display=swap" rel="stylesheet">
    
    <style>
        * {
            box-sizing: border-box;
            -webkit-print-color-adjust: exact !important;
            print-color-adjust: exact !important;
        }
        body {
            background-color: #f1f5f9;
            margin: 0;
            padding: 25px;
            display: flex;
            flex-direction: column;
            align-items: center;
            color: #000;
        }
        .no-print-area {
            margin-bottom: 25px;
            background: #fff;
            padding: 12px 24px;
            border-radius: 8px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.08);
            display: flex;
            gap: 15px;
            align-items: center;
        }
        .btn-action {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 9px 18px;
            border-radius: 6px;
            font-weight: 700;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            border: none;
            transition: transform 0.1s, opacity 0.2s;
        }
        .btn-action:hover {
            opacity: 0.92;
            transform: translateY(-1px);
        }
        .btn-print {
            background-color: #1987C6;
            color: #fff;
        }
        .btn-back {
            background-color: #64748b;
            color: #fff;
        }
        .cards-container {
            display: flex;
            gap: 45px;
            justify-content: center;
            flex-wrap: wrap;
        }
        .card-wrapper {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .view-label {
            margin-top: 12px;
            font-size: 13px;
            font-weight: 700;
            color: #475569;
            background: #fff;
            padding: 4px 14px;
            border-radius: 20px;
            border: 1px solid #cbd5e1;
        }

        <?php if ($isRailwayCard): ?>
        /* ==========================================================================
           INDIAN RAILWAY ORANGE ID CARD STYLES (STATION 4 & 5)
           Specifications matching Railway Board Annexure-'B' & Coaching Depot AGTL
           ========================================================================== */
        .ir-card {
            width: 5.4cm;
            height: 8.75cm;
            background-color: #FFA500;
            border-radius: 12px;
            box-shadow: 0 8px 18px rgba(0, 0, 0, 0.15);
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            box-sizing: border-box;
            font-family: 'Times New Roman', Times, serif;
            color: #000;
        }

        /* Front Side */
        .ir-card.front-card {
            padding: 0.12cm 0.16cm 0.16cm 0.16cm;
            align-items: center;
        }
        .ir-header-top {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 0.02cm;
        }
        .ir-logo-left {
            width: 0.85cm;
            height: 0.85cm;
            object-fit: contain;
            flex-shrink: 0;
        }
        .ir-logo-right {
            width: 0.95cm;
            height: 0.95cm;
            object-fit: contain;
            flex-shrink: 0;
        }
        .ir-header-center {
            flex: 1;
            text-align: center;
            padding: 0 0.05cm;
        }
        .ir-title {
            font-size: 13pt;
            font-weight: bold;
            color: #000;
            line-height: 1.1;
            letter-spacing: -0.2px;
            white-space: nowrap;
        }
        .ir-meta {
            font-size: 7.2pt;
            color: #000;
            line-height: 1.15;
            margin-top: 1px;
            white-space: nowrap;
        }
        .ir-contract-row {
            width: 100%;
            text-align: center;
            font-size: 7pt;
            color: #000;
            line-height: 1.15;
            margin-top: 0.04cm;
            margin-bottom: 0.08cm;
            white-space: nowrap;
        }

        /* Photo and Signature Block */
        .photo-sig-block {
            width: 4.2cm;
            height: 5.0cm;
            border-radius: 14px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            background-color: #fff;
            margin-top: 0.04cm;
            flex-shrink: 0;
        }
        .photo-box {
            width: 100%;
            height: 4.3cm;
            overflow: hidden;
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .photo-box .photo-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: top center;
        }
        .holder-sig-box {
            width: 100%;
            height: 0.7cm;
            background-color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            border-top: 1px solid #f1f1f1;
        }
        .holder-signature {
            font-family: 'Caveat', cursive, serif;
            font-size: 15pt;
            color: #000;
            line-height: 1;
        }

        /* Name */
        .emp-name-row {
            font-size: 15.5pt;
            font-weight: bold;
            color: #000;
            text-align: center;
            margin-top: 0.12cm;
            line-height: 1.1;
            width: 100%;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        /* Issuing Authority */
        .issuing-authority-block {
            margin-top: auto;
            margin-left: auto;
            margin-right: 0.05cm;
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 2.75cm;
        }
        .issuing-pill {
            width: 100%;
            height: 0.45cm;
            background-color: #ffffff;
            border-radius: 8px;
        }
        .issuing-label {
            font-size: 7.5pt;
            color: #000;
            text-align: center;
            margin-top: 2px;
            line-height: 1;
        }

        /* Back Side */
        .ir-card.back-card {
            padding: 0.25cm 0.35cm 0.2cm 0.35cm;
            align-items: center;
        }
        .back-top-row {
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.2cm;
        }
        .qr-box {
            width: 2.15cm;
            height: 2.25cm;
            background-color: #fff;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            padding: 2px;
            box-sizing: border-box;
        }
        .qr-box canvas {
            width: 1.85cm !important;
            height: 1.85cm !important;
        }
        .qr-stn-code {
            position: absolute;
            bottom: 2px;
            right: 3px;
            font-family: 'Times New Roman', Times, serif;
            font-size: 5.5pt;
            font-weight: bold;
            color: #000;
            line-height: 1;
        }
        .blood-box {
            width: 2.15cm;
            height: 2.25cm;
            background-color: #fff;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-sizing: border-box;
        }
        .blood-group-text {
            font-size: 40pt;
            font-weight: normal;
            color: #000;
            line-height: 1;
        }

        .dept-box {
            width: 100%;
            height: 0.68cm;
            background-color: #fff;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 15.5pt;
            font-weight: bold;
            color: #000;
            letter-spacing: 0.5px;
            margin-bottom: 0.25cm;
        }

        .phone-box {
            font-size: 19pt;
            font-weight: bold;
            color: #000;
            text-align: center;
            line-height: 1.1;
            margin-bottom: 0.12cm;
            letter-spacing: 0.5px;
        }

        .aadhar-box {
            font-size: 13pt;
            font-weight: bold;
            color: #000;
            text-align: center;
            line-height: 1.1;
            margin-bottom: 0.18cm;
            letter-spacing: 0.5px;
        }

        .card-divider {
            width: 80%;
            height: 1.5px;
            background-color: #000;
            border: none;
            margin: 0 auto 0.18cm auto;
        }

        .dates-block {
            text-align: center;
            margin-bottom: 0.22cm;
        }
        .dates-block .date-row {
            font-size: 7.8pt;
            font-weight: bold;
            color: #000;
            line-height: 1.35;
        }

        .instruction-block {
            text-align: center;
            color: #000;
            margin-top: auto;
        }
        .instruction-block .inst-title {
            font-size: 6pt;
            line-height: 1.2;
        }
        .instruction-block .inst-line {
            font-size: 5.2pt;
            line-height: 1.25;
        }

        <?php else: ?>
        /* ==========================================================================
           SMC INTEGRATED ID CARD STYLES (STATION 1 ETC.)
           ========================================================================== */
        body {
            font-family: 'Roboto', Arial, sans-serif;
        }
        .id-card {
            width: 5.4cm;
            height: 8.75cm;
            background-color: #ffffff;
            border: 1px solid #94a3b8;
            border-radius: 4px;
            box-shadow: 0 8px 18px rgba(0, 0, 0, 0.12);
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            padding: 0.22cm 0.25cm 0.18cm 0.25cm;
            box-sizing: border-box;
        }
        .smc-header {
            text-align: center;
            margin-bottom: 0.12cm;
        }
        .smc-logo-svg {
            display: block;
            margin: 0 auto 1px;
        }
        .smc-tag-sub1 {
            font-size: 3.8pt;
            font-weight: 900;
            color: #1e293b;
            letter-spacing: 0.2px;
            line-height: 1.1;
        }
        .smc-tag-sub2 {
            font-size: 3.4pt;
            font-weight: 600;
            color: #334155;
            line-height: 1.1;
        }
        .smc-tag-sub3 {
            font-size: 3.4pt;
            font-weight: 500;
            color: #475569;
            line-height: 1.1;
        }
        .photo-container {
            display: flex;
            justify-content: center;
            margin-bottom: 0.18cm;
        }
        .photo-box-smc {
            width: 2.35cm;
            height: 2.85cm;
            border: 1px solid #000;
            background-color: #f8fafc;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .photo-box-smc .photo-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }
        .info-fields {
            display: flex;
            flex-direction: column;
            gap: 0.08cm;
            width: 100%;
        }
        .field-row {
            display: flex;
            align-items: flex-end;
            font-size: 6.2pt;
            line-height: 1.15;
            width: 100%;
        }
        .field-label {
            font-weight: 900;
            color: #000;
            white-space: nowrap;
            margin-right: 3px;
        }
        .field-value {
            flex: 1;
            border-bottom: 1px dotted #000;
            min-height: 8.5pt;
            font-weight: 900;
            color: #002b66;
            padding-left: 2px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            text-align: left;
            font-size: 6.2pt;
        }
        .auth-sign-container {
            margin-top: auto;
            display: flex;
            justify-content: flex-end;
            padding-right: 0.05cm;
        }
        .auth-sign-text {
            font-size: 6.2pt;
            font-weight: 900;
            color: #000;
            line-height: 1;
        }
        .id-card.back-card-smc {
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            padding: 0.7cm 0.35cm 0.35cm 0.35cm;
            text-align: center;
        }
        .back-company-title {
            font-size: 7.2pt;
            font-weight: 900;
            color: #000;
            line-height: 1.25;
            margin-bottom: 0.35cm;
            letter-spacing: -0.1px;
        }
        .back-address {
            font-size: 6.6pt;
            font-weight: 700;
            color: #111;
            line-height: 1.4;
            margin-bottom: 0.45cm;
        }
        .back-phone {
            font-size: 7.2pt;
            font-weight: 900;
            color: #000;
            line-height: 1.2;
        }
        <?php endif; ?>

        /* Print Settings */
        @media print {
            body {
                background: #fff;
                padding: 0;
                margin: 0;
            }
            .no-print-area, .view-label {
                display: none !important;
            }
            .cards-container {
                gap: 1.5cm;
                padding: 1cm;
            }
            .id-card {
                box-shadow: none !important;
                page-break-inside: avoid;
            }
        }
    </style>
</head>
<body>

    <div class="no-print-area">
        <a href="view-employee.php" class="btn-action btn-back">
            <i class="bi bi-arrow-left"></i> Back to Directory
        </a>
        <button class="btn-action btn-print" onclick="window.print()">
            <i class="bi bi-printer"></i> Print ID Card
        </button>
    </div>

    <?php if ($isRailwayCard): ?>
    <!-- =====================================================================
         INDIAN RAILWAY ORANGE ID CARD LAYOUT (FOR STATION ID 4 & 5)
         ===================================================================== -->
    <div class="cards-container">
        <!-- FRONT VIEW -->
        <div class="card-wrapper">
            <div class="id-card ir-card front-card">
                <!-- Header: Logos and Title on Top Row, Contract No Below -->
                <div class="ir-header-top">
                    <img src="assets/idcard/railway_logo_red.png" class="ir-logo-left" alt="Indian Railways">
                    <div class="ir-header-center">
                        <div class="ir-title">Indian Railway</div>
                        <div class="ir-meta">ID Card No. <?= htmlspecialchars($cardNo) ?></div>
                    </div>
                    <img src="assets/idcard/coaching_depot_agartala.png" class="ir-logo-right" alt="<?= htmlspecialchars($depotName) ?>">
                </div>
                <div class="ir-contract-row">
                    Contract No: <?= htmlspecialchars($contractNo) ?>
                </div>

                <!-- Centered Photo Box with Holder Signature Strip -->
                <div class="photo-sig-block">
                    <div class="photo-box">
                        <img src="<?= htmlspecialchars($photoSrc) ?>" class="photo-img" alt="Photo">
                    </div>
                    <div class="holder-sig-box">
                        <span class="holder-signature"><?= htmlspecialchars($displayName) ?></span>
                    </div>
                </div>

                <!-- Employee Name in Bold 16pt -->
                <div class="emp-name-row">
                    <?= htmlspecialchars($displayName) ?>
                </div>

                <!-- Issuing Authority Pill & Title -->
                <div class="issuing-authority-block">
                    <div class="issuing-pill"></div>
                    <div class="issuing-label">Issuing Authority</div>
                </div>
            </div>
            <div class="view-label">Front View</div>
        </div>

        <!-- BACK VIEW -->
        <div class="card-wrapper">
            <div class="id-card ir-card back-card">
                <!-- Top Row: Dynamic QR Canvas + Station Code, Blood Group Box -->
                <div class="back-top-row">
                    <div class="qr-box">
                        <canvas id="qrCanvas"></canvas>
                        <div class="qr-stn-code"><?= htmlspecialchars($stnCode) ?></div>
                    </div>
                    <div class="blood-box">
                        <span class="blood-group-text"><?= htmlspecialchars($bloodGroup) ?></span>
                    </div>
                </div>

                <!-- Department Banner Strip -->
                <div class="dept-box">
                    <?= htmlspecialchars($department) ?>
                </div>

                <!-- Mobile Number -->
                <div class="phone-box">
                    <?= htmlspecialchars($mobileNumber) ?>
                </div>

                <!-- Aadhaar Number -->
                <div class="aadhar-box">
                    <?= htmlspecialchars($aadharFormatted) ?>
                </div>

                <!-- Dividing Line -->
                <hr class="card-divider">

                <!-- Dates -->
                <div class="dates-block">
                    <div class="date-row">Date of Issue : <?= htmlspecialchars($issueDateFormatted) ?></div>
                    <div class="date-row">Validity Upto:  <?= htmlspecialchars($validUptoFormatted) ?></div>
                </div>

                <!-- Footer Instructions -->
                <div class="instruction-block">
                    <div class="inst-title">Instruction:</div>
                    <div class="inst-line">Please surrender to issuing authority on</div>
                    <div class="inst-line">Completion/Termination of contractual services</div>
                </div>
            </div>
            <div class="view-label">Back View</div>
        </div>
    </div>

    <!-- QR Code Generator Library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/qrious/4.0.2/qrious.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const qrText = <?= json_encode($qrDataText) ?>;
            new QRious({
                element: document.getElementById('qrCanvas'),
                value: qrText,
                size: 72,
                level: 'M'
            });
        });
    </script>

    <?php else: ?>
    <!-- =====================================================================
         SMC INTEGRATED ID CARD LAYOUT (FOR OTHER STATIONS LIKE STATION 1)
         ===================================================================== -->
    <div class="cards-container">
        <!-- FRONT SIDE -->
        <div class="card-wrapper">
            <div class="id-card">
                <div class="smc-header">
                    <svg class="smc-logo-svg" viewBox="0 0 140 38" width="105" height="28">
                        <text x="18" y="30" font-family="'Roboto', 'Arial Black', sans-serif" font-weight="900" font-size="34" fill="#2d882d" letter-spacing="-1">S</text>
                        <text x="47" y="30" font-family="'Roboto', 'Arial Black', sans-serif" font-weight="900" font-size="34" fill="#f59e0b" letter-spacing="-1">M</text>
                        <text x="89" y="30" font-family="'Roboto', 'Arial Black', sans-serif" font-weight="900" font-size="34" fill="#2d882d" letter-spacing="-1">C</text>
                    </svg>
                    <div class="smc-tag-sub1">DIGITISE | AUTOMATE | MECHANISE</div>
                    <div class="smc-tag-sub2">Integrated Facility Management Solutions</div>
                    <div class="smc-tag-sub3">An SIS Group Enterprise</div>
                </div>

                <div class="photo-container">
                    <div class="photo-box-smc">
                        <img src="<?= htmlspecialchars($photoSrc) ?>" class="photo-img" alt="Photo">
                    </div>
                </div>

                <div class="info-fields">
                    <div class="field-row">
                        <span class="field-label">Employee Name:</span>
                        <span class="field-value"><?= $fullName ?></span>
                    </div>
                    <div class="field-row">
                        <span class="field-label">Registration No:</span>
                        <span class="field-value"><?= $regNo ?></span>
                    </div>
                    <div class="field-row">
                        <span class="field-label">Designation:</span>
                        <span class="field-value"><?= $designation ?></span>
                    </div>
                    <div class="field-row">
                        <span class="field-label">Emp Temp ID :</span>
                        <span class="field-value"><?= $empTempId ?></span>
                    </div>
                    <div class="field-row">
                        <span class="field-label">Unit Name :</span>
                        <span class="field-value"><?= $unitName ?></span>
                    </div>
                    <div class="field-row">
                        <span class="field-label">Site/Location :</span>
                        <span class="field-value"><?= $siteLocation ?></span>
                    </div>
                    <div class="field-row">
                        <span class="field-label">Validity:</span>
                        <span class="field-value"><?= $validityStr ?></span>
                    </div>
                </div>

                <div class="auth-sign-container">
                    <div class="auth-sign-text">Auth Sign</div>
                </div>
            </div>
            <div class="view-label">Front View</div>
        </div>

        <!-- BACK SIDE -->
        <div class="card-wrapper">
            <div class="id-card back-card-smc">
                <div class="back-company-title">
                    Smc Integrated Facility Management Solutions Limited
                </div>
                <div class="back-address">
                    Plot No. 18, DDA Community Centre<br>
                    Okhla Industrial Area,, Phase-I<br>
                    New Delhi - 110020
                </div>
                <div class="back-phone">
                    Tel: + 91-11-61345555
                </div>
            </div>
            <div class="view-label">Back View</div>
        </div>
    </div>
    <?php endif; ?>

</body>
</html>
