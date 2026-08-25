<?php
require_once 'auth.php';

$photoSrc = !empty($employee['employee_photo']) ? 'uploads/' . $employee['employee_photo'] : 'assets/img/avatar.png';
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ID Card - <?= htmlspecialchars($employee['full_name']) ?></title>
    <!-- Include Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
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
</head>
<body>

    <div class="no-print-area">
        <a href="view-employee.php" class="btn-back">
            <i class="bi bi-arrow-left"></i> Back to Directory
        </a>
        <button class="btn-print" onclick="window.print()">
            <i class="bi bi-printer"></i> Print ID Card
        </button>
    </div>

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
                            <div class="blood-value"><?= htmlspecialchars($employee['blood_group'] ?: 'B+') ?></div>
                        </div>
                    </div>
                    
                    <div class="dept-box">
                        <?= htmlspecialchars($employee['department'] ?: 'MECHANICAL') ?>
                    </div>
                    
                    <div class="phone-box">
                        <?= htmlspecialchars($employee['mobile_number'] ?: '9989999999') ?>
                    </div>
                    
                    <div class="details-box">
                        <div class="detail-item"><span>Name of Contractor:</span> <?= htmlspecialchars($contractorName) ?></div>
                        <div class="detail-item"><span>Validity of Contract:</span></div>
                        <div class="detail-item">&nbsp;&nbsp;From: <?= htmlspecialchars($employee['issue_date'] ? date('d.m.Y', strtotime($employee['issue_date'])) : '15.01.2026') ?> To: <?= htmlspecialchars($employee['valid_upto_date'] ? date('d.m.Y', strtotime($employee['valid_upto_date'])) : '14.01.2027') ?></div>
                        <div class="detail-item"><span>Date of Issue:</span> <?= htmlspecialchars($employee['issue_date'] ? date('d.m.Y', strtotime($employee['issue_date'])) : date('d.m.Y')) ?></div>
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
            const qrText = "Emp ID: <?= htmlspecialchars($employee['employee_id']) ?>\n" +
                           "Name: <?= htmlspecialchars($employee['full_name']) ?>\n" +
                           "Designation: <?= htmlspecialchars($employee['designation']) ?>\n" +
                           "Validity: <?= htmlspecialchars($employee['valid_upto_date']) ?>";

            new QRious({
                element: document.getElementById('qrCanvas'),
                value: qrText,
                size: 70,
                level: 'M'
            });
        });
    </script>
</body>
</html>
