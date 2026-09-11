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
            'mobile_number' => ''
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

// Station 4 uses the older ID card layout
$isOldCard = ($currentStationId === 4);

// Resolve photo path
$photoSrc = 'assets/img/avatar.png';
if (!empty($employee['employee_photo'])) {
    $customPhoto = 'uploads/' . $employee['employee_photo'];
    if (file_exists(__DIR__ . '/' . $customPhoto)) {
        $photoSrc = $customPhoto;
    }
}

// Prepare field values
$fullName     = !empty($employee['full_name']) ? htmlspecialchars(strtoupper(trim($employee['full_name']))) : '';
$regNo        = !empty($employee['employee_id']) ? htmlspecialchars(strtoupper(trim($employee['employee_id']))) : '';
$designation  = !empty($employee['designation']) ? htmlspecialchars(strtoupper(trim($employee['designation']))) : '';
$empTempId    = !empty($employee['ren_id']) ? htmlspecialchars(strtoupper(trim($employee['ren_id']))) : (!empty($employee['rakshak_id']) ? htmlspecialchars(strtoupper(trim($employee['rakshak_id']))) : '');
$unitName     = 'SMC';
$siteLocation = !empty($stationName) ? htmlspecialchars(strtoupper(trim($stationName))) : 'MYSORE';

// Validity format for SMC Card
$validityStr = '';
$issueDateValid = !empty($employee['issue_date']) && $employee['issue_date'] !== '0000-00-00';
$validUptoValid = !empty($employee['valid_upto_date']) && $employee['valid_upto_date'] !== '0000-00-00';

if ($issueDateValid && $validUptoValid) {
    $validityStr = date('d/m/y', strtotime($employee['issue_date'])) . ' to ' . date('d/m/y', strtotime($employee['valid_upto_date']));
} elseif ($validUptoValid) {
    $validityStr = 'to ' . date('d/m/y', strtotime($employee['valid_upto_date']));
} elseif ($issueDateValid) {
    $validityStr = date('d/m/y', strtotime($employee['issue_date']));
}

// Old card specific titles
$officeName = 'OFFICE OF THE CDO / ' . strtoupper($stationName);
$officeSub  = !empty($railwayName) ? $railwayName : 'SOUTH WESTERN RAILWAY';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ID Card - <?= !empty($employee['full_name']) ? htmlspecialchars($employee['full_name']) : 'Employee' ?></title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <?php if ($isOldCard): ?>
    <style>
        body {
            font-family: 'Times New Roman', Times, serif;
            background-color: #f3f4f6;
            margin: 0;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .no-print-area {
            margin-bottom: 30px;
            background: white;
            padding: 15px 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            display: flex;
            gap: 15px;
            align-items: center;
        }
        .btn-print {
            background-color: #1987C6;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            transition: background 0.2s;
        }
        .btn-print:hover {
            background-color: #146ea3;
        }
        .btn-back {
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: bold;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            transition: background 0.2s;
        }
        .btn-back:hover {
            background-color: #5a6268;
        }
        .cards-container {
            display: flex;
            gap: 40px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        /* Absolute dimensions in cm matching user blueprint */
        .id-card {
            width: 5.4cm;
            height: 8.75cm;
            border: 1.5px solid #000;
            border-radius: 0.25cm;
            background-color: #fff;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
            position: relative;
            overflow: hidden;
            display: flex;
            box-sizing: border-box;
        }
        .vertical-sidebar {
            width: 0.7cm;
            height: 100%;
            background-color: #e2e8f0;
            border-right: 1.5px solid #000;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
            font-weight: bold;
            font-size: 11pt;
            padding: 0.3cm 0;
            box-sizing: border-box;
            letter-spacing: 1px;
        }
        .vertical-sidebar span {
            display: block;
            line-height: 1.1;
            text-align: center;
        }
        .card-content {
            flex: 1;
            height: 100%;
            padding: 0.1cm;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        
        /* Front View Styles */
        .header-office {
            font-size: 13.5pt;
            font-weight: bold;
            text-align: center;
            margin-top: 0.05cm;
            line-height: 1;
        }
        .header-office-sub {
            font-size: 5pt;
            text-align: center;
            margin-bottom: 0.1cm;
            font-weight: bold;
            color: #333;
        }
        .photo-box {
            width: 4.2cm;
            height: 4.85cm;
            border: 1.2px solid #000;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #fafafa;
            box-sizing: border-box;
        }
        .photo-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .signature-holder-box {
            width: 4.2cm;
            height: 0.75cm;
            border: 1.2px solid #000;
            border-top: none;
            position: relative;
            display: flex;
            justify-content: center;
            align-items: flex-end;
            padding-bottom: 1px;
            box-sizing: border-box;
            background-color: #fff;
        }
        .signature-label {
            font-size: 4.5pt;
            color: #555;
            text-align: center;
            width: 100%;
            line-height: 1;
        }
        .emp-name-row {
            font-size: 11pt;
            font-weight: bold;
            margin-top: 0.15cm;
            width: 100%;
            text-align: left;
            padding-left: 0.15cm;
            box-sizing: border-box;
        }
        .authority-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            width: 100%;
            margin-top: auto;
            padding: 0 0.15cm 0.1cm 0.15cm;
            box-sizing: border-box;
        }
        .auth-sig-placeholder {
            font-size: 5.5pt;
            text-align: right;
            color: #555;
            line-height: 1.1;
        }
        .auth-title {
            font-size: 5.5pt;
            font-weight: bold;
            text-align: right;
            margin-top: 1px;
        }

        /* Back View Styles */
        .back-top-row {
            display: flex;
            justify-content: space-between;
            width: 100%;
            height: 2cm;
            margin-bottom: 0.15cm;
        }
        .qr-box {
            width: 2cm;
            height: 2cm;
            border: 1.2px solid #000;
            display: flex;
            justify-content: center;
            align-items: center;
            box-sizing: border-box;
            padding: 1px;
        }
        .blood-box {
            width: 2cm;
            height: 2cm;
            border: 1.2px solid #000;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            box-sizing: border-box;
        }
        .blood-label {
            font-size: 6.5pt;
            color: #333;
            font-weight: bold;
            margin-bottom: 2px;
        }
        .blood-value {
            font-size: 32pt;
            font-weight: bold;
            color: #dc3545;
            line-height: 0.9;
        }
        .dept-box {
            width: 100%;
            height: 1.2cm;
            border: 1.2px solid #000;
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: bold;
            font-size: 13.5pt;
            text-align: center;
            margin-bottom: 0.15cm;
            background-color: #f8fafc;
            box-sizing: border-box;
        }
        .phone-box {
            font-size: 14.5pt;
            font-weight: bold;
            text-align: center;
            width: 100%;
            margin-bottom: 0.15cm;
            letter-spacing: 0.5px;
        }
        .details-box {
            width: 100%;
            font-size: 6.5pt;
            line-height: 1.4;
            text-align: left;
            margin-bottom: auto;
            padding-left: 0.1cm;
            box-sizing: border-box;
        }
        .detail-item {
            margin-bottom: 1.5px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .detail-item span {
            font-weight: bold;
        }
        .instruction-box {
            width: 100%;
            border: 1.2px solid #000;
            background-color: #f1f5f9;
            padding: 3px 2px;
            box-sizing: border-box;
            text-align: center;
        }
        .instruction-title {
            font-size: 6.5pt;
            font-weight: bold;
            margin-bottom: 1px;
        }
        .instruction-text {
            font-size: 5pt;
            line-height: 1.2;
        }

        .view-label {
            text-align: center;
            margin-top: 10px;
            font-size: 14px;
            font-weight: bold;
            background: #fff;
            padding: 4px 12px;
            border-radius: 4px;
            border: 1px solid #ddd;
            width: fit-content;
            margin-left: auto;
            margin-right: auto;
        }

        @media print {
            body {
                background-color: #fff;
                padding: 0;
                margin: 0;
            }
            .no-print-area {
                display: none !important;
            }
            .cards-container {
                gap: 2cm;
                padding: 1cm;
            }
            .id-card {
                box-shadow: none !important;
                page-break-inside: avoid;
            }
            .view-label {
                display: none !important;
            }
        }
    </style>
    <?php else: ?>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700;900&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
            -webkit-print-color-adjust: exact !important;
            print-color-adjust: exact !important;
        }
        body {
            font-family: 'Roboto', Arial, sans-serif;
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

        /* Standard CR80 Size Card (5.4cm x 8.75cm) */
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

        /* ------------------ FRONT SIDE ------------------ */
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
        .photo-box {
            width: 2.35cm;
            height: 2.85cm;
            border: 1px solid #000;
            background-color: #f8fafc;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .photo-img {
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

        /* ------------------ BACK SIDE ------------------ */
        .id-card.back-card {
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

        /* ------------------ PRINT STYLES ------------------ */
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
                border: 1px solid #000 !important;
                page-break-inside: avoid;
            }
        }
    </style>
    <?php endif; ?>
</head>
<body>

    <div class="no-print-area">
        <a href="view-employee.php" class="<?= $isOldCard ? 'btn-back' : 'btn-action btn-back' ?>">
            <i class="bi bi-arrow-left"></i> Back to Directory
        </a>
        <button class="<?= $isOldCard ? 'btn-print' : 'btn-action btn-print' ?>" onclick="window.print()">
            <i class="bi bi-printer"></i> Print ID Card
        </button>
    </div>

    <?php if ($isOldCard): ?>
    <!-- OLD ID CARD LAYOUT FOR STATION ID 4 -->
    <div class="cards-container">
        <!-- Front View Card -->
        <div>
            <div class="id-card">
                <div class="vertical-sidebar">
                    <span>O</span>
                    <span>N</span>
                    <span>C</span>
                    <span>O</span>
                    <span>N</span>
                    <span>T</span>
                    <span>R</span>
                    <span>A</span>
                    <span>C</span>
                    <span>T</span>
                </div>
                <div class="card-content">
                    <div class="header-office"><?= htmlspecialchars($officeName) ?></div>
                    <div class="header-office-sub"><?= htmlspecialchars($officeSub) ?></div>
                    
                    <div class="photo-box">
                        <img src="<?= htmlspecialchars($photoSrc) ?>" class="photo-img" alt="Photo">
                    </div>
                    <div class="signature-holder-box">
                        <div class="signature-label">Signature of card Holder</div>
                    </div>
                    
                    <div class="emp-name-row">
                        Name : <?= htmlspecialchars($employee['full_name']) ?>
                    </div>
                    
                    <div class="authority-row">
                        <div></div>
                        <div class="auth-sig-placeholder">
                            (Signature)<br>
                            <div class="auth-title">Senior DME / CDO</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="view-label">Front View</div>
        </div>

        <!-- Back View Card -->
        <div>
            <div class="id-card">
                <div class="vertical-sidebar">
                    <span>O</span>
                    <span>N</span>
                    <span>C</span>
                    <span>O</span>
                    <span>N</span>
                    <span>T</span>
                    <span>R</span>
                    <span>A</span>
                    <span>C</span>
                    <span>T</span>
                </div>
                <div class="card-content">
                    <div class="back-top-row">
                        <div class="qr-box">
                            <canvas id="qrCanvas"></canvas>
                        </div>
                        <div class="blood-box">
                            <div class="blood-label">B.Group</div>
                            <div class="blood-value"><?= htmlspecialchars(!empty($employee['blood_group']) ? $employee['blood_group'] : 'B+') ?></div>
                        </div>
                    </div>
                    
                    <div class="dept-box">
                        <?= htmlspecialchars(!empty($employee['department']) ? $employee['department'] : 'MECHANICAL') ?>
                    </div>
                    
                    <div class="phone-box">
                        <?= htmlspecialchars(!empty($employee['mobile_number']) ? $employee['mobile_number'] : '9989999999') ?>
                    </div>
                    
                    <div class="details-box">
                        <div class="detail-item"><span>Name of Contractor:</span> <?= htmlspecialchars($contractorName) ?></div>
                        <div class="detail-item"><span>Validity of Contract:</span></div>
                        <div class="detail-item">&nbsp;&nbsp;From: <?= htmlspecialchars(!empty($employee['issue_date']) && $employee['issue_date'] !== '0000-00-00' ? date('d.m.Y', strtotime($employee['issue_date'])) : '15.01.2026') ?> To: <?= htmlspecialchars(!empty($employee['valid_upto_date']) && $employee['valid_upto_date'] !== '0000-00-00' ? date('d.m.Y', strtotime($employee['valid_upto_date'])) : '14.01.2027') ?></div>
                        <div class="detail-item"><span>Date of Issue:</span> <?= htmlspecialchars(!empty($employee['issue_date']) && $employee['issue_date'] !== '0000-00-00' ? date('d.m.Y', strtotime($employee['issue_date'])) : date('d.m.Y')) ?></div>
                        <div class="detail-item"><span>Validity:</span> 01 year from the date of issue</div>
                    </div>
                    
                    <div class="instruction-box">
                        <div class="instruction-title">Instruction</div>
                        <div class="instruction-text">Please surrender to issuing authority on completion/termination of contractual services</div>
                    </div>
                </div>
            </div>
            <div class="view-label">Back View</div>
        </div>
    </div>

    <!-- QR Code Generator Library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/qrious/4.0.2/qrious.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Generate dynamic text for QR Code
            const qrText = "Emp ID: <?= htmlspecialchars($employee['employee_id'] ?? '') ?>\n" +
                           "Name: <?= htmlspecialchars($employee['full_name'] ?? '') ?>\n" +
                           "Designation: <?= htmlspecialchars($employee['designation'] ?? '') ?>\n" +
                           "Validity: <?= htmlspecialchars($employee['valid_upto_date'] ?? '') ?>";

            new QRious({
                element: document.getElementById('qrCanvas'),
                value: qrText,
                size: 70,
                level: 'M'
            });
        });
    </script>

    <?php else: ?>
    <!-- NEW SMC ID CARD LAYOUT (OTHER STATIONS) -->
    <div class="cards-container">
        <!-- FRONT SIDE -->
        <div class="card-wrapper">
            <div class="id-card">
                <!-- Header Logo -->
                <div class="smc-header">
                    <svg class="smc-logo-svg" viewBox="0 0 140 38" width="105" height="28">
                        <!-- S in Green -->
                        <text x="18" y="30" font-family="'Roboto', 'Arial Black', sans-serif" font-weight="900" font-size="34" fill="#2d882d" letter-spacing="-1">S</text>
                        <!-- M in Gold/Amber -->
                        <text x="47" y="30" font-family="'Roboto', 'Arial Black', sans-serif" font-weight="900" font-size="34" fill="#f59e0b" letter-spacing="-1">M</text>
                        <!-- C in Green -->
                        <text x="89" y="30" font-family="'Roboto', 'Arial Black', sans-serif" font-weight="900" font-size="34" fill="#2d882d" letter-spacing="-1">C</text>
                    </svg>
                    <div class="smc-tag-sub1">DIGITISE | AUTOMATE | MECHANISE</div>
                    <div class="smc-tag-sub2">Integrated Facility Management Solutions</div>
                    <div class="smc-tag-sub3">An SIS Group Enterprise</div>
                </div>

                <!-- Photo Box (No Stamp, No Sign) -->
                <div class="photo-container">
                    <div class="photo-box">
                        <img src="<?= htmlspecialchars($photoSrc) ?>" class="photo-img" alt="Photo">
                    </div>
                </div>

                <!-- Info Fields with Dotted Underlines -->
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

                <!-- Auth Sign (Text Only, No Stamp) -->
                <div class="auth-sign-container">
                    <div class="auth-sign-text">Auth Sign</div>
                </div>
            </div>
            <div class="view-label">Front View</div>
        </div>

        <!-- BACK SIDE -->
        <div class="card-wrapper">
            <div class="id-card back-card">
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
