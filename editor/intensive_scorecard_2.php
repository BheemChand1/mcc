<?php
/**
 * CDO Dashboard - Intensive Scorecard 2 (Annexure A-2)
 * Scorecard For Intensive Cleaning - 3-Table Dynamic Architecture & 24-Coach Matrix
 */
require_once 'auth.php';

$fromDate = $_GET['from_date'] ?? date('Y-m-d', strtotime('-6 days'));
$toDate = $_GET['to_date'] ?? date('Y-m-d');
$selectedTrain = $_GET['train_no'] ?? '';
$editToken = $_GET['edit'] ?? '';
$flashSuccess = '';
$flashError = '';

// Handle Direct PHP POST Save (Date, Scores)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['save_scorecard_changes'])) {
    $targetToken = trim($_POST['token_id'] ?? '');
    $newReportDate = trim($_POST['sheet_report_date'] ?? '');
    $postedScores = $_POST['scores'] ?? [];

    if (!empty($targetToken)) {
        try {
            $pdo->beginTransaction();

            $chk = $pdo->prepare("SELECT COUNT(*) FROM mcc_intensive_scorecard_2_report WHERE token_id = :tok AND station_id = :sid");
            $chk->execute(['tok' => $targetToken, 'sid' => $stationId]);

            if ($chk->fetchColumn() > 0) {
                // Update Date if provided
                if (!empty($newReportDate) && preg_match('/^\d{4}-\d{2}-\d{2}$/', $newReportDate)) {
                    $dateUpd = $pdo->prepare("UPDATE mcc_intensive_scorecard_2_report SET report_date = :dt WHERE token_id = :tok AND station_id = :sid");
                    $dateUpd->execute(['dt' => $newReportDate, 'tok' => $targetToken, 'sid' => $stationId]);

                    if ($newReportDate < $fromDate) $fromDate = $newReportDate;
                    if ($newReportDate > $toDate) $toDate = $newReportDate;
                }

                // Update Scores
                if (!empty($postedScores)) {
                    $updScoreStmt = $pdo->prepare("
                        UPDATE mcc_intensive_scorecard_2_report 
                        SET score_value = :val 
                        WHERE token_id = :tok 
                          AND station_id = :sid 
                          AND sub_parameter_id = :sp_id 
                          AND coach_no = :c_no
                    ");

                    foreach ($postedScores as $spId => $coachVals) {
                        foreach ($coachVals as $cNo => $val) {
                            $updScoreStmt->execute([
                                'val' => trim($val),
                                'tok' => $targetToken,
                                'sid' => $stationId,
                                'sp_id' => $spId,
                                'c_no' => $cNo
                            ]);
                        }
                    }
                }

                $pdo->commit();
                $dateNote = (!empty($newReportDate)) ? " (Date: " . date('d-m-Y', strtotime($newReportDate)) . ")" : "";
                $flashSuccess = "Intensive Scorecard (Annexure A-2, Token: " . htmlspecialchars($targetToken) . ") updated successfully{$dateNote}!";
                $editToken = ''; // Exit edit mode after saving
            } else {
                $pdo->rollBack();
                $flashError = "Record not found for this station.";
            }
        } catch (Exception $e) {
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            $flashError = "Failed to update sheet: " . $e->getMessage();
        }
    }
}

// Station information
$stationQuery = $pdo->prepare("
    SELECT s.station_name, s.contractor_name, d.division_name, z.zone_name 
    FROM mcc_stations s
    LEFT JOIN mcc_divisions d ON s.division_id = d.division_id
    LEFT JOIN mcc_zones z ON d.zone_id = z.zone_id
    WHERE s.station_id = :station_id
");
$stationQuery->execute(['station_id' => $stationId]);
$stnData = $stationQuery->fetch();

$railwayName    = strtoupper($stnData['zone_name'] ?? 'NORTH EASTERN RAILWAY');
$divisionName   = strtoupper($stnData['division_name'] ?? 'LUCKNOW - NER');
$stationName    = ucfirst($stnData['station_name'] ?? 'Gorakhpur');
$contractorName = $stnData['contractor_name'] ?? 'Prime Cleaning Services';

// Fetch distinct available trains for dropdown filter
$trainsStmt = $pdo->prepare("SELECT DISTINCT train_no FROM mcc_intensive_scorecard_2_report WHERE station_id = :station_id ORDER BY train_no ASC");
$trainsStmt->execute(['station_id' => $stationId]);
$availableTrains = $trainsStmt->fetchAll(PDO::FETCH_COLUMN);

// 1. Fetch active parameters and sub-parameters from database (mcc_intensive_scorecard_2_param & sub_param)
$paramStmt = $pdo->prepare("
    SELECT p.id AS param_id, p.parameter_name, sp.id AS sub_param_id, sp.sub_parameter_name 
    FROM mcc_intensive_scorecard_2_param p
    JOIN mcc_intensive_scorecard_2_sub_param sp ON p.id = sp.parameter_id
    WHERE p.station_id = :p_station_id AND sp.station_id = :sp_station_id AND p.status = 'Active' AND sp.status = 'Active'
    ORDER BY p.id ASC, sp.id ASC
");
$paramStmt->execute(['p_station_id' => $stationId, 'sp_station_id' => $stationId]);
$paramRows = $paramStmt->fetchAll();

$dbParameters = [];
$snCounter = 1;
foreach ($paramRows as $row) {
    $pId = $row['param_id'];
    if (!isset($dbParameters[$pId])) {
        $dbParameters[$pId] = [
            'sn' => $snCounter++,
            'id' => $pId,
            'desc' => $row['parameter_name'],
            'subparts' => []
        ];
    }
    $dbParameters[$pId]['subparts'][] = [
        'id' => $row['sub_param_id'],
        'slot' => $row['sub_parameter_name']
    ];
}

// 2. Fetch distinct inspection tokens from mcc_intensive_scorecard_2_report
$tokensSql = "
    SELECT DISTINCT token_id, train_no, report_date 
    FROM mcc_intensive_scorecard_2_report 
    WHERE station_id = :station_id AND report_date BETWEEN :from_date AND :to_date
";
$tokensParams = [
    'station_id' => $stationId,
    'from_date' => $fromDate,
    'to_date' => $toDate,
    ];

if (!empty($selectedTrain)) {
    $tokensSql .= " AND train_no = :train_no";
    $tokensParams['train_no'] = $selectedTrain;
}

$tokensSql .= " ORDER BY report_date DESC, id DESC";
$tokensStmt = $pdo->prepare($tokensSql);
$tokensStmt->execute($tokensParams);
$inspectionTokens = $tokensStmt->fetchAll();

$sheetsData = [];

if (!empty($inspectionTokens)) {
    // Populate sheets from mcc_intensive_scorecard_2_report
    $reportStmt = $pdo->prepare("
        SELECT r.sub_parameter_id, r.coach_no, r.score_value, r.submitted_by, r.audit_by, r.isApproved 
        FROM mcc_intensive_scorecard_2_report r
        WHERE r.station_id = :station_id AND r.token_id = :token_id
        ORDER BY r.id ASC
    ");

    foreach ($inspectionTokens as $tokenRow) {
        $tokenId = $tokenRow['token_id'];
        $reportStmt->execute(['station_id' => $stationId, 'token_id' => $tokenId]);
        $scoreEntries = $reportStmt->fetchAll();

        // Determine unique coaches in order of appearance and auditor name
        $uniqueCoaches = [];
        $auditorName = 'prabhunath';
        $auditById = null;
        foreach ($scoreEntries as $sc) {
            if (!in_array($sc['coach_no'], $uniqueCoaches) && !empty($sc['coach_no'])) {
                $uniqueCoaches[] = $sc['coach_no'];
            }
            if (!empty($sc['submitted_by'])) {
                $auditorName = $sc['submitted_by'];
            }
            if (!empty($sc['audit_by'])) {
                $auditById = $sc['audit_by'];
            }
        }
        $auditorSig = resolveAuditorSignature($pdo, $auditById, $auditorName);

        // Build 24-slot coach array
        $coachNos = array_fill(0, 24, '');
        for ($i = 0; $i < min(24, count($uniqueCoaches)); $i++) {
            $coachNos[$i] = $uniqueCoaches[$i];
        }

        // Map scores into [sub_param_id][coach_index]
        $scoreMatrix = [];
        foreach ($scoreEntries as $sc) {
            $cIdx = array_search($sc['coach_no'], $uniqueCoaches);
            if ($cIdx !== false && $cIdx < 24) {
                $scoreMatrix[$sc['sub_parameter_id']][$cIdx] = $sc['score_value'];
            }
        }

        // Build row data and calculate totals
        $sheetRows = [];
        $totalPossible = 0;
        $totalObtained = 0;

        foreach ($dbParameters as $p) {
            $subData = [];
            foreach ($p['subparts'] as $sp) {
                $vals = [];
                $ts = 0;
                for ($c = 0; $c < 24; $c++) {
                    $val = $scoreMatrix[$sp['id']][$c] ?? '';
                    $vals[] = $val;
                    if ($val !== '' && $val !== 'X' && $val !== '-') {
                        if (is_numeric($val)) {
                            $ts += intval($val);
                            $totalObtained += intval($val);
                            $totalPossible += 3;
                        } elseif (strtoupper($val) === 'Y') {
                            $ts += 3;
                            $totalObtained += 3;
                            $totalPossible += 3;
                        } elseif (strtoupper($val) === 'N') {
                            $totalPossible += 3;
                        }
                    }
                }
                $subData[] = [
                    'id' => $sp['id'],
                    'slot' => $sp['slot'],
                    'values' => $vals,
                    'ts' => $ts
                ];
            }
            $sheetRows[] = [
                'sn' => $p['sn'],
                'desc' => $p['desc'],
                'subparts' => $subData
            ];
        }

        $calculatedScore = $totalPossible > 0 ? round(($totalObtained / $totalPossible) * 100, 2) . '%' : '0%';
        $attendedCount = count($uniqueCoaches);

        $sheetsData[] = [
            'page_no' => '54',
            'annexure' => 'ANNEXURE A-2',
            'title' => 'SCORECARD FOR INTENSIVE CLEANING',
            'subtitle' => '(To be filled by the supervisor/Nominated representative of CDO/ADME)',
            'token_id' => $tokenRow['token_id'],
            'train_no' => $tokenRow['train_no'],
            'date' => date('d-m-Y', strtotime($tokenRow['report_date'])),
            'report_date_raw' => $tokenRow['report_date'],
            'is_fallback' => false,
            'total_coaches' => $attendedCount ?: 19,
            'attended_coaches' => $attendedCount ?: 19,
            'total_score_percent' => $calculatedScore,
            'supervisor_name' => $auditorName,
            'auditor_signature' => $auditorSig,
            'division' => $divisionName,
            'station' => $stationName,
            'contractor' => $contractorName,
            'coach_numbers' => $coachNos,
            'rows' => $sheetRows,
            'isApproved' => !empty($scoreEntries) ? (int)($scoreEntries[0]['isApproved'] ?? 0) : 0
        ];
    }
} else {
    // Fallback sample sheet matching seeded database parameters
    $coachNumbers = [
        '19208', '192725', '193920', '122204', '163292', '201226', '201457', '153922',
        '192725', '172076', '172425', '201251', '172435', '155191', '196109', '131450',
        '191475', '154051', '195127', '', '', '', '', ''
    ];

    $fallbackRows = [];
    $totalPossible = 0;
    $totalObtained = 0;

    foreach ($dbParameters as $p) {
        $subData = [];
        foreach ($p['subparts'] as $sp) {
            $vals = [];
            $ts = 0;
            for ($c = 0; $c < 24; $c++) {
                if ($c < 19) {
                    $val = '3';
                    $vals[] = $val;
                    $ts += 3;
                    $totalObtained += 3;
                    $totalPossible += 3;
                } else {
                    $vals[] = '';
                }
            }
            $subData[] = [
                'slot' => $sp['slot'],
                'values' => $vals,
                'ts' => $ts
            ];
        }
        $fallbackRows[] = [
            'sn' => $p['sn'],
            'desc' => $p['desc'],
            'subparts' => $subData
        ];
    }

    $fallbackScore = $totalPossible > 0 ? round(($totalObtained / $totalPossible) * 100, 2) . '%' : '98.50%';

    $sheetsData[] = [
        'page_no' => '54',
        'annexure' => 'ANNEXURE A-2',
        'title' => 'SCORECARD FOR INTENSIVE CLEANING',
        'subtitle' => '(To be filled by the supervisor/Nominated representative of CDO/ADME)',
        'token_id' => 'TOK-INT2-0941',
        'train_no' => '12504',
        'date' => date('d-m-Y', strtotime($toDate)),
        'report_date_raw' => $toDate,
        'is_fallback' => true,
        'total_coaches' => '19',
        'attended_coaches' => '19',
        'total_score_percent' => $fallbackScore,
        'supervisor_name' => 'prabhunath',
        'division' => $divisionName,
        'station' => $stationName,
        'contractor' => $contractorName,
        'coach_numbers' => $coachNumbers,
        'rows' => $fallbackRows
    ];
}

$pageTitle = 'Intensive Scorecard 2 (Annexure A-2) | MCC';

$extraStyles = "
.cts-wrap {
    padding: 15px;
    background: #f1f5f9;
    min-height: 100vh;
    font-family: 'Roboto', 'Segoe UI', Tahoma, sans-serif !important;
}

.cts-frame {
    background: #ffffff;
    border: 1.5px solid #000000;
    padding: 25px 25px !important;
    width: 100%;
    margin: 0 auto 35px auto !important;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08) !important;
    position: relative;
}

/* Header Elements */
.cts-token-side {
    position: absolute;
    top: 22px;
    right: 25px;
    font-size: 12.5px;
    font-weight: 700;
    color: #0f172a;
    background: #f8fafc;
    border: 1px solid #94a3b8;
    padding: 4px 12px;
    border-radius: 4px;
    letter-spacing: 0.3px;
}

.scorecard-main-title {
    text-align: center;
    font-size: 19px;
    font-weight: 800;
    color: #000000;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    margin: 4px 0 2px 0;
}

.scorecard-subtitle {
    text-align: center;
    font-size: 12.5px;
    font-weight: 600;
    color: #1e293b;
    margin-bottom: 16px;
}

/* Meta Data Box */
.meta-card {
    background: #f8fafc;
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    padding: 12px 18px;
    margin-bottom: 16px;
}

.meta-grid {
    display: grid;
    grid-template-columns: 1.1fr 1fr 1.1fr 1.3fr;
    row-gap: 10px;
    column-gap: 22px;
    align-items: center;
}

.meta-item {
    display: flex;
    align-items: baseline;
    gap: 8px;
}

.meta-label {
    font-size: 11.5px;
    font-weight: 700;
    color: #475569;
    letter-spacing: 0.2px;
    white-space: nowrap;
}

.meta-val {
    font-size: 12.5px;
    font-weight: 800;
    color: #0f172a;
    border-bottom: 1.5px solid #cbd5e1;
    padding-bottom: 1px;
    white-space: nowrap;
}

.meta-val.meta-score {
    color: #0284c7;
    font-size: 13px;
    border-bottom-color: #0284c7;
}

/* Scorecard 24-Coach Table */
.cts-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 11px;
    color: #000000;
    background: #ffffff;
    border: 1.5px solid #000000;
}

.cts-table th,
.cts-table td {
    border: 1px solid #000000;
    padding: 3px 4px;
    text-align: center;
    vertical-align: middle;
}

.cts-table thead th {
    background: linear-gradient(180deg, #07203a 0%, #07182c 100%) !important;
    color: #ffffff !important;
    font-weight: 700;
    font-size: 11px;
    border-color: #0b476a !important;
}

.th-c-head {
    background: linear-gradient(180deg, #0b3457 0%, #07203a 100%) !important;
    color: #ffffff !important;
    font-size: 10px;
    font-weight: 800;
    border-color: #0b476a !important;
}

.th-c-label {
    background: #eef2ff !important;
    color: #3730a3 !important;
    font-size: 8.5px;
    font-weight: 700;
    line-height: 1.1;
}

.th-c-num {
    background: #ffffff !important;
    color: #000000 !important;
    font-size: 9px;
    font-weight: 700;
    letter-spacing: -0.3px;
    max-width: 28px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.col-sn {
    width: 32px;
    font-weight: 800;
    background: #ffffff;
}

.col-desc {
    width: 270px;
    text-align: left !important;
    padding-left: 8px !important;
    padding-right: 8px !important;
    font-size: 11px;
    line-height: 1.3;
    font-weight: 700;
}

.col-slot {
    width: 80px;
    font-weight: 700;
    background: #f8fafc;
    font-size: 10.5px;
}

.col-c {
    width: 28px;
    padding: 2px 1px !important;
    font-size: 10.5px;
    font-weight: 700;
}

.col-ts {
    width: 38px;
    font-weight: 800;
    background: #f8fafc;
}

/* Signatures */
.cts-sig-row {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    margin-top: 30px;
    padding: 0 40px;
}

.cts-sig-box {
    text-align: center;
    width: 200px;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.cts-sig-box .signature-img-wrap {
    height: 24px;
    display: flex;
    align-items: flex-end;
    justify-content: center;
    margin-bottom: 2px;
}

.cts-sig-box .signature-img-wrap img {
    max-height: 24px;
    max-width: 95px;
    object-fit: contain;
    display: block;
}

.cts-sig-title {
    font-size: 12.5px;
    font-weight: 700;
    color: #000000;
    text-decoration: underline;
    text-underline-offset: 4px;
    white-space: nowrap;
}

/* Filter controls */
.filter-bar {
    background: #ffffff;
    border-radius: 8px;
    padding: 12px 18px;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 12px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.08);
    flex-wrap: wrap;
}

.filter-group {
    display: flex;
    align-items: center;
    gap: 8px;
}

.filter-label {
    font-size: 13px;
    font-weight: 700;
    color: #334155;
    margin-bottom: 0;
}

.filter-input {
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    padding: 6px 12px;
    font-size: 13px;
    color: #0f172a;
}

.btn-filter-go {
    background: linear-gradient(135deg, #13c9ff 0%, #0284c7 100%) !important;
    color: #ffffff !important;
    border: none;
    padding: 7px 18px;
    border-radius: 6px;
    font-weight: 700;
    font-size: 13px;
    cursor: pointer;
    box-shadow: 0 2px 8px rgba(19, 201, 255, 0.3) !important;
    transition: all 0.2s;
    display: inline-flex;
    align-items: center;
}

.btn-filter-go:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 12px rgba(19, 201, 255, 0.4) !important;
}

.btn-filter-summary {
    background: linear-gradient(135deg, #0d5f99 0%, #072e4a 100%) !important;
    color: #ffffff !important;
    border: 1px solid #167db3 !important;
    padding: 7px 18px;
    border-radius: 6px;
    font-weight: 700;
    font-size: 13px;
    cursor: pointer;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 6px;
    transition: all 0.2s;
}

.btn-filter-summary:hover {
    color: #ffffff !important;
    transform: translateY(-2px);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3) !important;
}

.btn-filter-print {
    background: linear-gradient(135deg, #07385f 0%, #042540 100%) !important;
    color: #ffffff !important;
    border: 1px solid #0b476a !important;
    padding: 7px 18px;
    border-radius: 6px;
    font-weight: 700;
    font-size: 13px;
    cursor: pointer;
    margin-left: auto;
    display: inline-flex;
    align-items: center;
    gap: 6px;
    transition: all 0.2s;
}

.btn-filter-print:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3) !important;
}

/* Print Optimization */
@media print {
    .no-print, .main-header, .app-header, .app-sidebar, .app-footer, .filter-bar, .report-filter {
        display: none !important;
        visibility: hidden !important;
        height: 0 !important;
        width: 0 !important;
        margin: 0 !important;
        padding: 0 !important;
    }
    
    html, body, .app-wrapper, .app-main, .app-content, .container-fluid, .cts-wrap {
        background: #ffffff !important;
        padding: 0 !important;
        margin: 0 !important;
        width: 100% !important;
        max-width: 100% !important;
    }

    .app-main {
        margin-left: 0 !important;
        padding-top: 0 !important;
    }
    
    .cts-frame {
        border: none !important;
        box-shadow: none !important;
        margin: 0 !important;
        padding: 0 !important;
        page-break-after: always !important;
        break-after: page !important;
        page-break-inside: avoid !important;
        break-inside: avoid !important;
        width: 100% !important;
        max-width: 100% !important;
    }

    .cts-frame:last-child {
        page-break-after: avoid !important;
        break-after: avoid !important;
    }
    
    .cts-table thead th {
        background: #07203a !important;
        color: #ffffff !important;
        -webkit-print-color-adjust: exact !important;
        print-color-adjust: exact !important;
    }

    .meta-card {
        background: #ffffff !important;
        border: 1px solid #000000 !important;
        border-radius: 0 !important;
        padding: 6px 12px !important;
        margin-bottom: 8px !important;
    }

    .meta-label {
        color: #000000 !important;
    }

    .meta-val {
        color: #000000 !important;
        border-bottom: 1px solid #000000 !important;
    }

    .meta-val.meta-score {
        color: #000000 !important;
        border-bottom-color: #000000 !important;
    }
    
    @page {
        size: A4 landscape;
        margin: 5mm;
    }
}
";

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
    <div class="app-content pt-3">
        <div class="container-fluid">

            <!-- Filter and Actions Toolbar -->
            <div class="filter-bar no-print">
                <form method="GET" action="intensive_scorecard_2.php" class="d-flex align-items-center gap-3 flex-wrap m-0">
                    <div class="filter-group">
                        <label class="filter-label"><i class="bi bi-calendar3 me-1 text-primary"></i> From:</label>
                        <input type="date" name="from_date" class="filter-input" value="<?= htmlspecialchars($fromDate) ?>">
                    </div>

                    <div class="filter-group">
                        <label class="filter-label">To:</label>
                        <input type="date" name="to_date" class="filter-input" value="<?= htmlspecialchars($toDate) ?>">
                    </div>

                    <button type="submit" class="btn-filter-go">
                        <i class="bi bi-funnel-fill me-1"></i> Apply Filter
                    </button>
                </form>

                <div class="d-flex align-items-center gap-2 ms-auto">
                    
                    <button type="button" class="btn-filter-print" onclick="window.print()">
                        <i class="bi bi-printer-fill"></i> Print Scorecard
                    </button>
                </div>
            </div>

            <?php if (!empty($flashSuccess)): ?>
                <div class="alert alert-success alert-dismissible fade show mb-3 no-print" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i><strong>Success!</strong> <?= $flashSuccess ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <?php endif; ?>
            <?php if (!empty($flashError)): ?>
                <div class="alert alert-danger alert-dismissible fade show mb-3 no-print" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i><strong>Error!</strong> <?= $flashError ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <?php endif; ?>

            <!-- Scorecard Document Wrapper -->
            <div class="cts-wrap">
                <?php foreach ($sheetsData as $sheet): 
                    $isEditingThisSheet = (!$sheet['is_fallback'] && !empty($sheet['token_id']) && (string)$editToken === (string)$sheet['token_id']);
                ?>
                    <?php if ($isEditingThisSheet): ?>
                    <form method="POST" action="">
                        <input type="hidden" name="token_id" value="<?= htmlspecialchars($sheet['token_id']) ?>">
                        <input type="hidden" name="from_date" value="<?= htmlspecialchars($fromDate) ?>">
                        <input type="hidden" name="to_date" value="<?= htmlspecialchars($toDate) ?>">
                        <input type="hidden" name="train_no" value="<?= htmlspecialchars($selectedTrain) ?>">
                    <?php endif; ?>

                    <div class="cts-frame" style="<?= $isEditingThisSheet ? 'border: 2px solid #0284c7; box-shadow: 0 0 22px rgba(2, 132, 199, 0.35);' : '' ?>">

                        <!-- Token & Approval on the Side -->
                        <div class="cts-token-side d-flex align-items-center gap-2">
                            <?php if (!empty($sheet['token_id'])): ?>
                                <span><strong>Token:</strong> <?= htmlspecialchars($sheet['token_id']) ?></span>
                            <?php endif; ?>
                            <?php if (!empty($sheet['isApproved'])): ?>
                                <span class="badge bg-success px-3 py-1 text-white" style="font-size: 0.85rem; font-weight: 600; border-radius: 6px;"><i class="bi bi-patch-check-fill me-1"></i> Approved</span>
                            <?php else: ?>
                                <span class="badge bg-warning text-dark px-3 py-1" style="font-size: 0.85rem; font-weight: 600; border-radius: 6px;"><i class="bi bi-clock-history me-1"></i> Pending Approval</span>
                            <?php endif; ?>

                            <?php if (!$sheet['is_fallback'] && !empty($sheet['token_id'])): ?>
                                <?php if ($isEditingThisSheet): ?>
                                    <button type="submit" name="save_scorecard_changes" class="btn btn-sm btn-success fw-bold text-white no-print shadow-sm px-3" style="font-weight: 700;">
                                        <i class="bi bi-check2-circle me-1"></i> Save Changes
                                    </button>
                                    <a href="?from_date=<?= urlencode($fromDate) ?>&to_date=<?= urlencode($toDate) ?>&train_no=<?= urlencode($selectedTrain) ?>" class="btn btn-sm btn-secondary fw-bold text-white no-print shadow-sm px-3">
                                        <i class="bi bi-x-circle me-1"></i> Cancel
                                    </a>
                                <?php else: ?>
                                    <a href="?from_date=<?= urlencode($fromDate) ?>&to_date=<?= urlencode($toDate) ?>&train_no=<?= urlencode($selectedTrain) ?>&edit=<?= urlencode($sheet['token_id']) ?>" class="btn btn-sm fw-bold text-dark no-print shadow-sm px-3" style="background-color: #fbbf24 !important; color: #000000 !important; font-weight: 700 !important; border: 1px solid #f59e0b;" title="Edit Sheet">
                                        <i class="bi bi-pencil-square me-1"></i> Edit Sheet
                                    </a>
                                <?php endif; ?>
                            <?php endif; ?>
                        </div>

                        <!-- Main Titles -->
                        <h2 class="scorecard-main-title"><?= htmlspecialchars($sheet['title']) ?></h2>
                        <div class="scorecard-subtitle"><?= htmlspecialchars($sheet['subtitle']) ?></div>

                        <?php if ($isEditingThisSheet): ?>
                            <div class="alert alert-info py-2 px-3 mb-3 d-flex align-items-center justify-content-between no-print" style="border: 1px solid #b9e6fe; background-color: #f0f9ff; color: #0369a1; border-radius: 6px;">
                                <span class="small fw-semibold"><i class="bi bi-info-circle-fill me-1"></i> <strong>Edit Mode Active:</strong> You can edit the Date and coach scores (0-3 or Y/N) directly in the table below. Click <strong>Save Changes</strong> above to update the database.</span>
                            </div>
                        <?php endif; ?>

                        <!-- Professional Metadata Card -->
                        <div class="meta-card">
                            <div class="meta-grid">
                                <div class="meta-item">
                                    <span class="meta-label">Train No.:</span>
                                    <span class="meta-val"><?= htmlspecialchars($sheet['train_no']) ?></span>
                                </div>
                                <div class="meta-item">
                                    <span class="meta-label">Date:</span>
                                    <span class="meta-val">
                                        <?php if ($isEditingThisSheet): ?>
                                            <input type="date" name="sheet_report_date" value="<?= htmlspecialchars($sheet['report_date_raw']) ?>" class="form-control form-control-sm text-center fw-bold d-inline-block" style="width: 140px; height: 28px; font-size: 12px; padding: 1px 4px; border: 1.5px solid #0284c7; background: #fff !important; color: #000 !important;" required>
                                        <?php else: ?>
                                            <?= htmlspecialchars($sheet['date']) ?>
                                        <?php endif; ?>
                                    </span>
                                </div>
                                <div class="meta-item">
                                    <span class="meta-label">Total No of coaches in rake:</span>
                                    <span class="meta-val"><?= htmlspecialchars($sheet['total_coaches']) ?></span>
                                </div>
                                <div class="meta-item">
                                    <span class="meta-label">Total Scores obtained:</span>
                                    <span class="meta-val meta-score"><?= htmlspecialchars($sheet['total_score_percent']) ?></span>
                                </div>
                                <div class="meta-item">
                                    <span class="meta-label">Name of the supervisor:</span>
                                    <span class="meta-val"><?= htmlspecialchars($sheet['supervisor_name']) ?></span>
                                </div>
                                <div class="meta-item">
                                    <span class="meta-label">Division:</span>
                                    <span class="meta-val"><?= htmlspecialchars($sheet['division']) ?></span>
                                </div>
                                <div class="meta-item">
                                    <span class="meta-label">Station / Depot:</span>
                                    <span class="meta-val"><?= htmlspecialchars($sheet['station']) ?></span>
                                </div>
                                <div class="meta-item">
                                    <span class="meta-label">Name of Contractor:</span>
                                    <span class="meta-val"><?= htmlspecialchars($sheet['contractor']) ?></span>
                                </div>
                            </div>
                        </div>

                        <!-- 24-Coach Score Card Table for all 16 Parameters -->
                        <div class="table-responsive">
                            <table class="cts-table">
                                <thead>
                                    <tr>
                                        <th rowspan="2" class="col-sn">SL<br>No.</th>
                                        <th rowspan="2" class="col-desc">Description</th>
                                        <th rowspan="2" class="col-slot">Area / Part</th>
                                        <?php for ($c = 1; $c <= 24; $c++): ?>
                                            <th class="col-c th-c-head">C<?= $c ?></th>
                                        <?php endfor; ?>
                                        <th rowspan="2" class="col-ts">T.S.</th>
                                    </tr>
                                    <tr>
                                        <?php for ($c = 0; $c < 24; $c++): ?>
                                            <th class="col-c th-c-num"><?= htmlspecialchars($sheet['coach_numbers'][$c] ?? '') ?></th>
                                        <?php endfor; ?>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($sheet['rows'] as $row): 
                                        $subCount = count($row['subparts']);
                                    ?>
                                        <?php foreach ($row['subparts'] as $sIndex => $sub): ?>
                                            <tr>
                                                <?php if ($sIndex === 0): ?>
                                                    <td rowspan="<?= $subCount ?>" class="col-sn"><?= $row['sn'] ?></td>
                                                    <td rowspan="<?= $subCount ?>" class="col-desc"><?= htmlspecialchars($row['desc']) ?></td>
                                                <?php endif; ?>
                                                
                                                <td class="col-slot"><?= htmlspecialchars($sub['slot']) ?></td>

                                                <?php for ($c = 0; $c < 24; $c++): 
                                                    $val = $sub['values'][$c] ?? '';
                                                    $coachNo = $sheet['coach_numbers'][$c] ?? '';
                                                ?>
                                                    <td class="col-c font-weight-bold">
                                                        <?php if ($isEditingThisSheet && !empty($coachNo)): ?>
                                                            <input type="text" name="scores[<?= $sub['id'] ?>][<?= htmlspecialchars($coachNo) ?>]" value="<?= htmlspecialchars($val) ?>" class="form-control form-control-sm text-center fw-bold" style="width: 38px; height: 26px; padding: 1px; margin: 0 auto; border: 1.5px solid #0284c7; background: #fff !important; color: #000 !important; font-size: 11px;">
                                                        <?php else: ?>
                                                            <?= htmlspecialchars($val) ?>
                                                        <?php endif; ?>
                                                    </td>
                                                <?php endfor; ?>

                                                <td class="col-ts"><?= htmlspecialchars($sub['ts']) ?></td>
                                            </tr>
                                        <?php endforeach; ?>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>

                        <!-- Signatures Section -->
                        <div class="cts-sig-row">
                            <div class="cts-sig-box">
                                <div class="signature-img-wrap">
                                    <?php if (!empty($sheet['isApproved']) && !empty($cdoSignature) && file_exists(__DIR__ . '/uploads/signatures/' . $cdoSignature)): ?>
                                        <img src="uploads/signatures/<?= htmlspecialchars($cdoSignature) ?>" alt="Contractor Sign">
                                    <?php endif; ?>
                                </div>
                                <div class="cts-sig-title">Contractor's Representative</div>
                            </div>
                            <div class="cts-sig-box">
                                <div class="signature-img-wrap">
                                    <?php if (!empty($sheet['auditor_signature']) && file_exists(__DIR__ . '/uploads/signatures/' . $sheet['auditor_signature'])): ?>
                                        <img src="uploads/signatures/<?= htmlspecialchars($sheet['auditor_signature']) ?>" alt="Authorized Sign">
                                    <?php endif; ?>
                                </div>
                                <div class="cts-sig-title">Authorized Railway personnel</div>
                            </div>
                        </div>

                    </div>
                    <?php if ($isEditingThisSheet): ?>
                    </form>
                    <?php endif; ?>
                <?php endforeach; ?>
            </div>

        </div>
    </div>
</main>

<?php include 'footer.php'; ?>
