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
    // Fallback to first employee
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
        'aadhar_number' => ''
    ];
}

// Resolve photo path
$photoSrc = 'assets/img/avatar.png';
if (!empty($employee['employee_photo'])) {
    $customPhoto = 'uploads/' . $employee['employee_photo'];
    if (file_exists(__DIR__ . '/' . $customPhoto)) {
        $photoSrc = $customPhoto;
    }
}

// Prepare field values (Leave completely blank if missing)
$fullName     = !empty($employee['full_name']) ? htmlspecialchars(strtoupper(trim($employee['full_name']))) : '';
$regNo        = !empty($employee['employee_id']) ? htmlspecialchars(strtoupper(trim($employee['employee_id']))) : '';
$designation  = !empty($employee['designation']) ? htmlspecialchars(strtoupper(trim($employee['designation']))) : '';
$empTempId    = !empty($employee['ren_id']) ? htmlspecialchars(strtoupper(trim($employee['ren_id']))) : (!empty($employee['rakshak_id']) ? htmlspecialchars(strtoupper(trim($employee['rakshak_id']))) : '');
$unitName     = 'SMC';
$siteLocation = !empty($stationName) ? htmlspecialchars(strtoupper(trim($stationName))) : 'MYSORE';

// Validity format
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

</body>
</html>
