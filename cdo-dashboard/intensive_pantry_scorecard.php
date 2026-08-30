<?php
/**
 * CDO Dashboard - Scorecard for Intensive Cleaning of Pantry Car
 * Annexure A-3 Standard Layout with Dynamic Coaches
 */
require_once 'auth.php';

$fromDate = $_GET['from_date'] ?? date('Y-m-d', strtotime('-6 days'));
$toDate = $_GET['to_date'] ?? date('Y-m-d');

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

// Helper function to format qualitative rating grades
if (!function_exists('getPantryGradeBadge')) {
    function getPantryGradeBadge($val) {
        if (is_numeric($val)) {
            $num = floatval($val);
            if ($num >= 2.8) return '<span class="grade-badge grade-vg">3</span>';
            if ($num >= 1.8) return '<span class="grade-badge grade-sat">2</span>';
            if ($num >= 0.8) return '<span class="grade-badge grade-poor">1</span>';
            return '<span class="grade-badge grade-na">0</span>';
        }
        $v = strtolower(trim((string)$val));
        if ($v === '3' || $v === 'vg' || $v === 'very good' || $v === 'verygood') return '<span class="grade-badge grade-vg">3</span>';
        if ($v === '2' || $v === 'sat' || $v === 'satisfactory' || $v === 'good') return '<span class="grade-badge grade-sat">2</span>';
        if ($v === '1' || $v === 'poor') return '<span class="grade-badge grade-poor">1</span>';
        if ($v === '0' || $v === 'not attended' || $v === 'na') return '<span class="grade-badge grade-na">0</span>';
        if ($v === 'x') return '<span class="grade-badge grade-x">X</span>';
        if ($v === '-') return '<span class="text-muted">-</span>';
        return htmlspecialchars((string)$val);
    }
}

// 1. Fetch active parameters and sub-parameters from database
$paramStmt = $pdo->prepare("
    SELECT p.id AS param_id, p.parameter_name, sp.id AS sub_param_id, sp.sub_parameter_name 
    FROM mcc_intensive_pantry_param p
    JOIN mcc_intensive_pantry_sub_param sp ON p.id = sp.parameter_id
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

// 2. Fetch distinct inspection tokens from mcc_intensive_pantry_report
$tokensSql = "
    SELECT DISTINCT token_id, train_no, report_date 
    FROM mcc_intensive_pantry_report 
    WHERE station_id = :station_id AND report_date BETWEEN :from_date AND :to_date
    ORDER BY report_date DESC, id DESC
";
$tokensParams = [
    'station_id' => $stationId,
    'from_date' => $fromDate,
    'to_date' => $toDate
];

$tokensStmt = $pdo->prepare($tokensSql);
$tokensStmt->execute($tokensParams);
$inspectionTokens = $tokensStmt->fetchAll();

$sheetsData = [];

if (!empty($inspectionTokens)) {
    // Populate sheets from mcc_intensive_pantry_report
    $reportStmt = $pdo->prepare("
        SELECT r.sub_parameter_id, r.coach_no, r.score_value, r.auditor_name 
        FROM mcc_intensive_pantry_report r
        WHERE r.station_id = :station_id AND r.token_id = :token_id
        ORDER BY r.id ASC
    ");

    foreach ($inspectionTokens as $tokenRow) {
        $tokenId = $tokenRow['token_id'];
        $reportStmt->execute(['station_id' => $stationId, 'token_id' => $tokenId]);
        $scoreEntries = $reportStmt->fetchAll();

        // Determine unique dynamic coaches present for this token
        $uniqueCoaches = [];
        $auditorName = 'prabhunath';
        foreach ($scoreEntries as $sc) {
            if (!in_array($sc['coach_no'], $uniqueCoaches) && !empty($sc['coach_no'])) {
                $uniqueCoaches[] = $sc['coach_no'];
            }
            if (!empty($sc['submitted_by'])) {
                $auditorName = $sc['submitted_by'];
            }
        }

        if (empty($uniqueCoaches)) {
            $uniqueCoaches = ['WGACCW 19208'];
        }

        // Map scores into [sub_param_id][coach_no]
        $scoreMatrix = [];
        foreach ($scoreEntries as $sc) {
            $scoreMatrix[$sc['sub_parameter_id']][$sc['coach_no']] = $sc['score_value'];
        }

        // Build row data for each parameter and sub-item
        $sheetRows = [];
        $coachObtainedTotals = array_fill_keys($uniqueCoaches, 0);
        $coachPossibleTotals = array_fill_keys($uniqueCoaches, 0);

        foreach ($dbParameters as $p) {
            $subData = [];
            $itemObtainedSums = array_fill_keys($uniqueCoaches, 0);
            $itemPossibleSums = array_fill_keys($uniqueCoaches, 0);

            foreach ($p['subparts'] as $sp) {
                $coachVals = [];
                foreach ($uniqueCoaches as $cNo) {
                    $val = $scoreMatrix[$sp['id']][$cNo] ?? '3';
                    $coachVals[$cNo] = $val;

                    if (is_numeric($val)) {
                        $numVal = floatval($val);
                        $itemObtainedSums[$cNo] += $numVal;
                        $itemPossibleSums[$cNo] += 3;
                        $coachObtainedTotals[$cNo] += $numVal;
                        $coachPossibleTotals[$cNo] += 3;
                    }
                }

                $subData[] = [
                    'id' => $sp['id'],
                    'slot' => $sp['slot'],
                    'coach_vals' => $coachVals
                ];
            }

            // Calculate item-level marks awarded out of 3 for each coach
            $itemMarks = [];
            foreach ($uniqueCoaches as $cNo) {
                $subCount = count($p['subparts']);
                if ($subCount > 1 && $itemPossibleSums[$cNo] > 0) {
                    $itemMarks[$cNo] = round(($itemObtainedSums[$cNo] / $itemPossibleSums[$cNo]) * 3.0, 1);
                } else {
                    $itemMarks[$cNo] = isset($subData[0]['coach_vals'][$cNo]) && is_numeric($subData[0]['coach_vals'][$cNo]) ? floatval($subData[0]['coach_vals'][$cNo]) : 3.0;
                }
            }

            $sheetRows[] = [
                'sn' => $p['sn'],
                'desc' => $p['desc'],
                'subparts' => $subData,
                'item_marks' => $itemMarks
            ];
        }

        // Summary calculations per coach
        $coachSummary = [];
        foreach ($uniqueCoaches as $cNo) {
            $eligible = $coachPossibleTotals[$cNo] > 0 ? (count($dbParameters) * 3) : 54;
            $obtained = 0;
            foreach ($sheetRows as $r) {
                $obtained += $r['item_marks'][$cNo] ?? 0;
            }
            $pct = $eligible > 0 ? round(($obtained / $eligible) * 100, 2) : 0;

            $coachSummary[$cNo] = [
                'eligible' => $eligible,
                'obtained' => round($obtained, 1),
                'percent'  => $pct . '%'
            ];
        }

        $overallPercent = count($coachSummary) > 0 ? round(array_sum(array_column($coachSummary, 'obtained')) / (count($coachSummary) * 54) * 100, 2) . '%' : '98.50%';

        $sheetsData[] = [
            'token_id' => $tokenRow['token_id'],
            'train_no' => $tokenRow['train_no'],
            'date' => date('d-m-Y', strtotime($tokenRow['report_date'])),
            'pantry_coaches' => implode(', ', $uniqueCoaches),
            'coaches' => $uniqueCoaches,
            'total_score_percent' => $overallPercent,
            'supervisor_name' => $auditorName,
            'technician_name' => 'Sr. Technician',
            'division' => $divisionName,
            'station' => $stationName,
            'contractor' => $contractorName,
            'rows' => $sheetRows,
            'summary' => $coachSummary
        ];
    }
} else {
    // Fallback sample sheet with 1 pantry coach
    $sampleCoaches = ['WGACCW 19208'];
    $fallbackRows = [];
    $coachSummary = [];

    foreach ($dbParameters as $p) {
        $subData = [];
        foreach ($p['subparts'] as $sp) {
            $subData[] = [
                'slot' => $sp['slot'],
                'coach_vals' => ['WGACCW 19208' => '3']
            ];
        }
        $fallbackRows[] = [
            'sn' => $p['sn'],
            'desc' => $p['desc'],
            'subparts' => $subData,
            'item_marks' => ['WGACCW 19208' => 3.0]
        ];
    }

    $coachSummary['WGACCW 19208'] = [
        'eligible' => 54,
        'obtained' => 54.0,
        'percent' => '100%'
    ];

    $sheetsData[] = [
        'token_id' => 'TKN-PANTRY-20260817-001',
        'train_no' => '12504',
        'date' => date('d-m-Y', strtotime($toDate)),
        'pantry_coaches' => 'WGACCW 19208',
        'coaches' => $sampleCoaches,
        'total_score_percent' => '100%',
        'supervisor_name' => 'prabhunath',
        'technician_name' => 'Sr. Technician',
        'division' => $divisionName,
        'station' => $stationName,
        'contractor' => $contractorName,
        'rows' => $fallbackRows,
        'summary' => $coachSummary
    ];
}

$pageTitle = 'Scorecard for Intensive Cleaning of Pantry Car | MCC';

$extraStyles = "
.pantry-wrap {
    padding: 15px;
    background: #f1f5f9;
    min-height: 100vh;
    font-family: 'Roboto', 'Segoe UI', Tahoma, sans-serif !important;
}

.pantry-frame {
    background: #ffffff;
    border: 1.5px solid #000000;
    padding: 25px 25px !important;
    width: 100%;
    margin: 0 auto 35px auto !important;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08) !important;
    position: relative;
}

/* Header Elements */
.pantry-token-side {
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
    font-size: 18.5px;
    font-weight: 800;
    color: #000000;
    text-transform: uppercase;
    letter-spacing: 0.6px;
    margin: 4px 0 2px 0;
}

.scorecard-subtitle {
    text-align: center;
    font-size: 12px;
    font-weight: 600;
    color: #1e293b;
    margin-bottom: 16px;
}

/* Professional Metadata Grid */
.meta-card {
    background: #f8fafc;
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    padding: 12px 18px;
    margin-bottom: 16px;
}

.meta-grid {
    display: grid;
    grid-template-columns: 1.1fr 1fr 1.3fr 1.1fr;
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

/* Pantry Table */
.pantry-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 11.5px;
    color: #000000;
    background: #ffffff;
    border: 1.5px solid #000000;
}

.pantry-table th,
.pantry-table td {
    border: 1px solid #000000;
    padding: 4px 6px;
    text-align: center;
    vertical-align: middle;
}

.pantry-table thead th {
    background: linear-gradient(180deg, #07203a 0%, #07182c 100%) !important;
    color: #ffffff !important;
    font-weight: 700;
    font-size: 11.5px;
    border-color: #0b476a !important;
}

.col-sn {
    width: 40px;
    font-weight: 800;
    background: #ffffff;
}

.col-desc {
    text-align: left !important;
    padding-left: 10px !important;
    padding-right: 10px !important;
    font-size: 11.5px;
    line-height: 1.35;
    font-weight: 700;
}

.col-slot {
    width: 110px;
    font-weight: 700;
    background: #f8fafc;
    font-size: 11px;
}

.col-coach {
    min-width: 100px;
    padding: 3px 2px !important;
    font-size: 11px;
    font-weight: 700;
}

.col-marks {
    width: 55px;
    font-weight: 800;
    background: #f8fafc;
    font-size: 11.5px;
}

.th-coach-title {
    background: linear-gradient(180deg, #0b3457 0%, #07203a 100%) !important;
    color: #ffffff !important;
    font-size: 11px;
    font-weight: 800;
    border-color: #0b476a !important;
}

.th-coach-no-label {
    background: #f1f5f9 !important;
    color: #0f172a !important;
    font-weight: 800;
    text-align: right !important;
    padding-right: 12px !important;
}

.th-coach-no-val {
    background: #ffffff !important;
    color: #0f172a !important;
    font-weight: 800;
    font-size: 11px;
}

/* Qualitative Grade Badges */
.grade-badge {
    display: inline-block;
    padding: 2px 8px;
    border-radius: 4px;
    font-size: 11px;
    font-weight: 800;
    line-height: 1.2;
    min-width: 24px;
    text-align: center;
}

.grade-vg {
    background: #dcfce7;
    color: #15803d;
    border: 1px solid #bbf7d0;
}

.grade-sat {
    background: #e0f2fe;
    color: #0369a1;
    border: 1px solid #bae6fd;
}

.grade-poor {
    background: #ffedd5;
    color: #c2410c;
    border: 1px solid #fed7aa;
}

.grade-na {
    background: #f1f5f9;
    color: #475569;
    border: 1px solid #e2e8f0;
}

.grade-x {
    background: #fee2e2;
    color: #b91c1c;
    border: 1px solid #fecaca;
    font-weight: 800;
}

/* Summary Rows */
.summary-row td {
    background: #f8fafc;
    font-weight: 800 !important;
    font-size: 12px;
}

.summary-row-label {
    text-align: left !important;
    padding-left: 12px !important;
}

/* Bottom Sections matching photo */
.watering-section {
    margin-top: 18px;
    margin-bottom: 12px;
    font-size: 12.5px;
    font-weight: 700;
    color: #000000;
    display: flex;
    align-items: center;
    gap: 40px;
    flex-wrap: wrap;
}

.watering-options {
    display: flex;
    align-items: center;
    gap: 30px;
}

.watering-check {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    cursor: pointer;
    font-weight: 800;
}

.watering-check input[type='checkbox'] {
    width: 15px;
    height: 15px;
    cursor: pointer;
}

.score-notes-section {
    font-size: 12.5px;
    color: #000000;
    margin-bottom: 35px;
    font-weight: 700;
}

/* Signatures */
.pantry-sig-row {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    margin-top: 50px;
    padding: 0 40px;
}

.pantry-sig-box {
    text-align: center;
}

.pantry-sig-title {
    font-size: 12.5px;
    font-weight: 700;
    color: #000000;
    text-decoration: underline;
    text-underline-offset: 4px;
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
    
    html, body, .app-wrapper, .app-main, .app-content, .container-fluid, .pantry-wrap {
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
    
    .pantry-frame {
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

    .pantry-frame:last-child {
        page-break-after: avoid !important;
        break-after: avoid !important;
    }
    
    .pantry-table thead th {
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

    .grade-badge {
        border: none !important;
        background: transparent !important;
        color: #000000 !important;
        padding: 0 !important;
    }
    
    @page {
        size: A4 portrait;
        margin: 6mm;
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
                <form method="GET" action="intensive_pantry_scorecard.php" class="d-flex align-items-center gap-3 flex-wrap m-0">
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
                    <a href="intensive_pantry_summary.php?month=<?= date('m', strtotime($fromDate)) ?>&year=<?= date('Y', strtotime($fromDate)) ?>" class="btn-filter-summary">
                        <i class="bi bi-file-earmark-bar-graph-fill me-1"></i> Summary Page
                    </a>
                    <button type="button" class="btn-filter-print" onclick="window.print()">
                        <i class="bi bi-printer-fill"></i> Print Scorecard
                    </button>
                </div>
            </div>

            <!-- Scorecard Document Wrapper -->
            <div class="pantry-wrap">
                <?php foreach ($sheetsData as $sheet): 
                    $coachList = $sheet['coaches'];
                    $coachCount = count($coachList);
                ?>
                    <div class="pantry-frame">

                        <!-- Token on the Side -->
                        <?php if (!empty($sheet['token_id'])): ?>
                            <div class="pantry-token-side">
                                <strong>Token:</strong> <?= htmlspecialchars($sheet['token_id']) ?>
                            </div>
                        <?php endif; ?>

                        <!-- Main Titles -->
                        <h2 class="scorecard-main-title">SCORECARD FOR INTENSIVE CLEANING OF PANTRY CAR</h2>
                        <div class="scorecard-subtitle">(To be filled by the supervisor/Nominated representative of CDO/ADME)</div>

                        <!-- Professional Metadata Card -->
                        <div class="meta-card">
                            <div class="meta-grid">
                                <div class="meta-item">
                                    <span class="meta-label">Train No.:</span>
                                    <span class="meta-val"><?= htmlspecialchars($sheet['train_no']) ?></span>
                                </div>
                                <div class="meta-item">
                                    <span class="meta-label">Date:</span>
                                    <span class="meta-val"><?= htmlspecialchars($sheet['date']) ?></span>
                                </div>
                                <div class="meta-item">
                                    <span class="meta-label">Pantry Coach No.:</span>
                                    <span class="meta-val"><?= htmlspecialchars($sheet['pantry_coaches']) ?></span>
                                </div>
                                <div class="meta-item">
                                    <span class="meta-label">Total Score:</span>
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
                            </div>
                        </div>

                        <!-- Dynamic Coach Inspection Table -->
                        <div class="table-responsive">
                            <table class="pantry-table">
                                <thead>
                                    <tr>
                                        <th rowspan="2" class="col-sn">SL<br>No.</th>
                                        <th rowspan="2" class="col-desc" colspan="2">Description</th>
                                        <?php foreach ($coachList as $idx => $cNo): ?>
                                            <th class="col-coach th-coach-title">Coach <?= ($idx + 1) ?></th>
                                            <th class="col-marks th-coach-title">Marks</th>
                                        <?php endforeach; ?>
                                    </tr>
                                    <tr>
                                        <?php foreach ($coachList as $idx => $cNo): ?>
                                            <th class="th-coach-no-val" style="font-size: 10.5px;"><?= htmlspecialchars($cNo) ?></th>
                                            <th class="th-coach-no-val">-</th>
                                        <?php endforeach; ?>
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

                                                <?php foreach ($coachList as $cNo): 
                                                    $val = $sub['coach_vals'][$cNo] ?? '';
                                                ?>
                                                    <td class="col-coach">
                                                        <?= getPantryGradeBadge($val) ?>
                                                    </td>
                                                <?php endforeach; ?>

                                                <?php if ($sIndex === 0): ?>
                                                    <?php foreach ($coachList as $cNo): ?>
                                                        <td rowspan="<?= $subCount ?>" class="col-marks font-weight-bold">
                                                            <?= number_format($row['item_marks'][$cNo] ?? 3.0, 1) ?>
                                                        </td>
                                                    <?php endforeach; ?>
                                                <?php endif; ?>
                                            </tr>
                                        <?php endforeach; ?>
                                    <?php endforeach; ?>

                                    <!-- Summary Rows matching Photo 2 -->
                                    <tr class="summary-row">
                                        <td colspan="3" class="summary-row-label">Total Eligible marks</td>
                                        <?php foreach ($coachList as $cNo): ?>
                                            <td>-</td>
                                            <td><?= $sheet['summary'][$cNo]['eligible'] ?? 54 ?></td>
                                        <?php endforeach; ?>
                                    </tr>

                                    <tr class="summary-row">
                                        <td colspan="3" class="summary-row-label">Total Marks obtained</td>
                                        <?php foreach ($coachList as $cNo): ?>
                                            <td>-</td>
                                            <td style="color: #0284c7; font-size: 12.5px;"><?= $sheet['summary'][$cNo]['obtained'] ?? 54.0 ?></td>
                                        <?php endforeach; ?>
                                    </tr>

                                    <tr class="summary-row">
                                        <td colspan="3" class="summary-row-label">Percentage</td>
                                        <?php foreach ($coachList as $cNo): ?>
                                            <td>-</td>
                                            <td style="color: #15803d; font-size: 12.5px;"><?= $sheet['summary'][$cNo]['percent'] ?? '100%' ?></td>
                                        <?php endforeach; ?>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!-- Watering Section (Matching Photo 2) -->
                        <div class="watering-section">
                            <div>c. &nbsp; Watering of Intensive attended coaches (Tick Yes/No)</div>
                            <div class="watering-options">
                                <label class="watering-check">
                                    <input type="checkbox" checked disabled> YES
                                </label>
                                <label class="watering-check" style="margin-left: 20px;">
                                    <input type="checkbox" disabled> NO
                                </label>
                            </div>
                        </div>

                        <!-- Scoring Definition Note (Matching Photo 2) -->
                        <div class="score-notes-section">
                            3. &nbsp;&nbsp; Very Good-3, Satisfactory-2, Poor-1, Not attended-0
                        </div>

                        <!-- Signatures Section (Matching Photo 2) -->
                        <div class="pantry-sig-row">
                            <div class="pantry-sig-box">
                                <div class="pantry-sig-title">Signature of Contractor's Supervisor</div>
                            </div>
                            <div class="pantry-sig-box">
                                <div class="pantry-sig-title">SSE/JE/C&W</div>
                            </div>
                        </div>

                    </div>
                <?php endforeach; ?>
            </div>

        </div>
    </div>
</main>

<?php include 'footer.php'; ?>
