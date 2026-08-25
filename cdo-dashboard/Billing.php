<?php
require_once 'auth.php';
require_once 'scores.php';

// Parse query month
$selectedMonthYear = $_GET['month'] ?? date('Y-m'); // e.g. "2026-07"
$parts = explode('-', $selectedMonthYear);
$selectedYear = intval($parts[0] ?? date('Y'));
$selectedMonth = intval($parts[1] ?? date('m'));
$monthText = date('F Y', strtotime("$selectedYear-$selectedMonth-01"));
$daysInMonth = cal_days_in_month(CAL_GREGORIAN, $selectedMonth, $selectedYear);

// Fetch Billing Parameters Configured by Admin for this Station
$setupStmt = $pdo->prepare("SELECT * FROM mcc_billing_setup WHERE station_id = :station_id");
$setupStmt->execute(['station_id' => $stationId]);
$setupData = $setupStmt->fetch();

$earningsStmt = $pdo->prepare("SELECT * FROM mcc_billing_earnings WHERE station_id = :station_id ORDER BY id ASC");
$earningsStmt->execute(['station_id' => $stationId]);
$earningsList = $earningsStmt->fetchAll();

// Fetch active conditions configured by Admin for this Station
$conditionsStmt = $pdo->prepare("SELECT * FROM mcc_billing_conditions WHERE station_id = :station_id AND is_active = 1 ORDER BY min_score DESC");
$conditionsStmt->execute(['station_id' => $stationId]);
$customConditions = $conditionsStmt->fetchAll();

$isBillingConfigured = true;
if (!$setupData || empty($earningsList)) {
    $isBillingConfigured = false;
}

if ($isBillingConfigured) {
    $sanctionedAmount = floatval($setupData['sanctioned_amount']);
    $gstPercentage = floatval($setupData['gst_percentage']);
    $contractStart = date('d.m.Y', strtotime($setupData['contract_start_date']));
    $contractEnd = date('d.m.Y', strtotime($setupData['contract_end_date']));
    $agreementNo = $setupData['agreement_no'] ?? '';

    // Calculate contract days dynamically
    $d1 = new DateTime($setupData['contract_start_date']);
    $d2 = new DateTime($setupData['contract_end_date']);
    $contractDays = $d1->diff($d2)->days + 1;

    $baseAmount = $sanctionedAmount / (1 + ($gstPercentage / 100));
    $gstAmount = $sanctionedAmount - $baseAmount;
    $perDayBudget = $baseAmount / $contractDays;
    $monthlyBudget = $perDayBudget * $daysInMonth;

    // Identify all configured score types for this station's bill setup
    $activeScoreTypes = [];
    foreach ($earningsList as $item) {
        $types = explode(',', $item['score_type'] ?? '');
        foreach ($types as $t) {
            $t = trim($t);
            if ($t !== '') {
                $activeScoreTypes[$t] = true;
            }
        }
    }

    // Retrieve Dynamic Scores & Penalties
    $manpowerSum = getManpowerSummary($stationId, $selectedYear, $selectedMonth);
    $attendanceScore = $manpowerSum['score'];
    $manpowerPenalty = $manpowerSum['penalty'];

    $cleanlinessScore = getCleanlinessScore($stationId, $selectedYear, $selectedMonth);

    $chemSum = getChemicalSummary($stationId, $selectedYear, $selectedMonth);
    $machSum = getMachineSummary($stationId, $selectedYear, $selectedMonth);
    $consumablesScore = round(($chemSum['score'] + $machSum['score']) / 2.0, 2);

    // Sum up chemical penalties from all chemical summary reports
    $chemIntensiveSum = getIntensiveChemicalSummary($stationId, $selectedYear, $selectedMonth);
    $chemPldcSum = getPLDCChemicalSummary($stationId, $selectedYear, $selectedMonth);
    $chemPrtSum = getPRTChemicalSummary($stationId, $selectedYear, $selectedMonth);

    $chemicalPenalty = $chemSum['penalty'] + $chemIntensiveSum['penalty'] + $chemPldcSum['penalty'] + $chemPrtSum['penalty'];

    // Sum up machine penalties from all machinery summary reports
    $machIntensiveSum = getIntensiveMachineSummary($stationId, $selectedYear, $selectedMonth);
    $machPldcSum = getPLDCMachineSummary($stationId, $selectedYear, $selectedMonth);

    $machinePenalty = $machSum['penalty'] + $machIntensiveSum['penalty'] + $machPldcSum['penalty'];

    // Fetch General Imposed Penalties for this station and month
    $generalPenaltyStmt = $pdo->prepare("
        SELECT SUM(penalty_amount) 
        FROM mcc_imposed_penalties 
        WHERE station_id = :station_id 
          AND YEAR(penalty_date) = :year 
          AND MONTH(penalty_date) = :month
    ");
    $generalPenaltyStmt->execute([
        'station_id' => $stationId,
        'year' => $selectedYear,
        'month' => $selectedMonth
    ]);
    $generalImposedPenalty = floatval($generalPenaltyStmt->fetchColumn() ?: 0.00);

    $surpriseScore = getSurpriseVisitsScore($stationId, $selectedYear, $selectedMonth);
    $prtScore = getPRTScore($stationId, $selectedYear, $selectedMonth);

    $totalWeightageSum = 0.0;
    $totalEarnedAmount = 0.0;
    $overallScore = 0.0;
    $processedEarnings = [];

    foreach ($earningsList as $idx => $item) {
        $name = $item['earning_name'];
        $type = $item['score_type'];
        $weightage = floatval($item['weightage']);

        $scoreTypes = explode(',', $type ?? '');
        $scoresSum = 0.0;
        $validScoresCount = 0;
        foreach ($scoreTypes as $st) {
            $st = trim($st);
            if ($st === '') continue;

            $tempScore = 100.00;
            if ($st === 'attendance') {
                $tempScore = $attendanceScore;
            } elseif ($st === 'cleanliness') {
                $tempScore = $cleanlinessScore;
            } elseif ($st === 'normal_scorecard') {
                $tempScore = getNormalCleaningScore($stationId, $selectedYear, $selectedMonth);
            } elseif ($st === 'intensive_scorecard') {
                $tempScore = getIntensiveCleaningScore($stationId, $selectedYear, $selectedMonth);
            } elseif ($st === 'pldc_scorecard') {
                $tempScore = getPLDCCleaningScore($stationId, $selectedYear, $selectedMonth);
            } elseif ($st === 'prt_scorecard') {
                $tempScore = $prtScore;
            } elseif ($st === 'normal_chemical') {
                $tempScore = $chemSum['score'];
            } elseif ($st === 'intensive_chemical') {
                $tempScore = getIntensiveChemicalScore($stationId, $selectedYear, $selectedMonth);
            } elseif ($st === 'pldc_chemical') {
                $tempScore = getPLDCChemicalScore($stationId, $selectedYear, $selectedMonth);
            } elseif ($st === 'prt_chemical') {
                $tempScore = getPRTChemicalScore($stationId, $selectedYear, $selectedMonth);
            } elseif ($st === 'normal_machine') {
                $tempScore = $machSum['score'];
            } elseif ($st === 'intensive_machine') {
                $tempScore = getIntensiveMachineScore($stationId, $selectedYear, $selectedMonth);
            } elseif ($st === 'pldc_machine') {
                $tempScore = getPLDCMachineScore($stationId, $selectedYear, $selectedMonth);
            } elseif ($st === 'surprise_pit_office') {
                $tempScore = getSurprisePitOfficeScore($stationId, $selectedYear, $selectedMonth);
            } elseif ($st === 'surprise_pf_trains') {
                $tempScore = getSurprisePFTrainsScore($stationId, $selectedYear, $selectedMonth);
            } elseif ($st === 'consumables_machinery') {
                $tempScore = $consumablesScore;
            } elseif ($st === 'surprise_visits') {
                $tempScore = $surpriseScore;
            } elseif ($st === 'static') {
                $tempScore = 100.00;
            }
            $scoresSum += $tempScore;
            $validScoresCount++;
        }
        $score = $validScoresCount > 0 ? round($scoresSum / $validScoresCount, 2) : 100.00;

        // Show amount according to weightage of selected month budget, don't cut here
        $amount = $monthlyBudget * ($weightage / 100);

        $totalWeightageSum += $weightage;
        $totalEarnedAmount += $amount;
        $overallScore += $score * ($weightage / 100);

        $processedEarnings[] = [
            's_no' => $idx + 1,
            'name' => $name,
            'weightage' => $weightage,
            'score' => $score,
            'amount' => $amount
        ];
    }

    // Deductions (including general penalties)
    $totalDeductions = $manpowerPenalty + $machinePenalty + $chemicalPenalty + $generalImposedPenalty;

    // Penalty ranges & descriptions based on overall score (dynamically configured station-wise)
    $performanceDesc = "Good performance";
    $scoreBasedDeductionRate = 0.00;
    $matchedRangeText = "";

    $matched = false;
    if (!empty($customConditions)) {
        foreach ($customConditions as $cond) {
            $min = floatval($cond['min_score']);
            $max = floatval($cond['max_score']);
            if ($overallScore >= $min && $overallScore <= $max) {
                $performanceDesc = $cond['description'];
                $scoreBasedDeductionRate = floatval($cond['deduction_percentage']);
                $matchedRangeText = number_format($min, 2) . "% - " . number_format($max, 2) . "%";
                $matched = true;
                break;
            }
        }
    }

    if (!$matched) {
        // Fallback to default hardcoded logic
        if ($overallScore >= 95.0) {
            $performanceDesc = "Excellent performance";
            $matchedRangeText = "95.00% - 100.00%";
        } elseif ($overallScore >= 90.0) {
            $performanceDesc = "Good performance";
            $matchedRangeText = "90.00% - 95.00%";
        } elseif ($overallScore >= 80.0) {
            $performanceDesc = "Satisfactory performance";
            $matchedRangeText = "80.00% - 90.00%";
        } else {
            $performanceDesc = "Unsatisfactory performance (5% Deduction applicable)";
            $scoreBasedDeductionRate = 5.00;
            $matchedRangeText = "Below 80.00%";
        }
    }

    $scoreBasedDeduction = $totalEarnedAmount * ($scoreBasedDeductionRate / 100);

    // Apply cuts: Total Budget minus log penalties minus 5% score-based deduction if score < 80%
    $taxableAmount = $totalEarnedAmount - $totalDeductions - $scoreBasedDeduction;
    $billingGstAmount = $taxableAmount * ($gstPercentage / 100);
    $totalPayableAmount = $taxableAmount + $billingGstAmount;
    $totalPayableRound = round($totalPayableAmount);

    $inWordsText = numberToWords($totalPayableRound);
} else {
    $sanctionedAmount = 0;
    $baseAmount = 0;
    $gstPercentage = 0;
    $gstAmount = 0;
    $contractStart = '';
    $contractEnd = '';
    $contractDays = 0;
    $perDayBudget = 0;
    $monthlyBudget = 0;
    $processedEarnings = [];
    $totalWeightageSum = 0;
    $overallScore = 0;
    $totalEarnedAmount = 0;
    $manpowerPenalty = 0;
    $machinePenalty = 0;
    $chemicalPenalty = 0;
    $generalImposedPenalty = 0;
    $totalDeductions = 0;
    $performanceDesc = '';
    $scoreBasedDeductionRate = 0;
    $scoreBasedDeduction = 0;
    $scoreBonusRate = 0;
    $scoreBonus = 0;
    $taxableAmount = 0;
    $billingGstAmount = 0;
    $totalPayableAmount = 0;
    $totalPayableRound = 0;
    $inWordsText = '';
    $agreementNo = '';
    $matchedRangeText = '';
    $performanceScoreDeduction = 0;
}

$pageTitle = 'MCC | Billing Invoice';

$extraStyles = "
    .billing-page,
    .billing-page table,
    .billing-page button {
        font-family: Arial, Helvetica, sans-serif;
    }

    .billing-page {
        padding: 12px;
        background: #f4f6f8;
    }

    .billing-toolbar {
        display: flex;
        justify-content: center;
        margin-bottom: 8px;
    }

    .billing-toolbar .toolbar-form {
        display: inline-flex;
        align-items: center;
        gap: 10px;
        flex-wrap: wrap;
        background: #edf1f5;
        border-radius: 10px;
        padding: 10px 14px;
        border: 1px solid #d2d8df;
    }

    .billing-toolbar label {
        font-size: 12px;
        font-weight: 700;
        margin-bottom: 0;
    }

    .billing-toolbar input {
        height: 30px;
        border: 1px solid #bbc5d0;
        border-radius: 6px;
        padding: 3px 8px;
        font-size: 12px;
    }

    .billing-btn {
        height: 30px;
        border: 0;
        border-radius: 6px;
        background: #3c8dbc;
        color: #fff;
        font-size: 12px;
        font-weight: 700;
        padding: 0 12px;
        cursor: pointer;
        transition: background 0.2s;
    }

    .billing-btn:hover {
        background: #2d6a8f;
    }

    .billing-sheet {
        background: #fff;
        border: 1px solid #222;
        padding: 8px 10px;
        max-width: 230mm;
        margin: 0 auto;
        overflow: hidden;
        box-sizing: border-box;
        box-shadow: 0 4px 18 rgba(0, 0, 0, 0.08);
    }

    .sheet-heading {
        text-align: center;
        font-weight: 700;
        font-size: 15px;
        margin-bottom: 2px;
        color: #000;
    }

    .sheet-subtitle {
        text-align: center;
        font-size: 11px;
        font-weight: 700;
        margin-bottom: 4px;
        border-bottom: 1px solid #222;
        padding-bottom: 2px;
        color: #000;
    }

    .sheet-meta {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 6px;
        margin: 4px 0 6px;
        font-size: 10px;
    }

    .meta-block {
        border: 1px solid #222;
        padding: 5px 6px;
    }

    .meta-block-title {
        font-size: 9px;
        font-weight: 700;
        letter-spacing: 0.2px;
        margin-bottom: 3px;
        padding-bottom: 2px;
        border-bottom: 1px solid #999;
        text-transform: uppercase;
        color: #000;
    }

    .meta-list {
        display: flex;
        flex-direction: column;
        gap: 2px;
    }

    .meta-row {
        display: flex;
        justify-content: flex-start;
        align-items: center;
        gap: 6px;
        flex-wrap: nowrap;
        line-height: 1.1;
        border-bottom: 1px dotted #bbb;
        padding-bottom: 1px;
    }

    .meta-label {
        min-width: 0;
        flex: 0 0 45%;
        color: #000;
        font-weight: 700;
    }

    .meta-value {
        flex: 1;
        min-width: 0;
        text-align: right;
        font-weight: 700;
        color: #000;
    }

    .billing-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 6px;
        font-size: 11px;
    }

    .billing-table th,
    .billing-table td {
        border: 1px solid #111;
        padding: 3px 4px;
        text-align: center;
    }

    .billing-table th {
        background: #f2f2f2 !important;
        font-weight: 700;
        color: #000 !important;
    }

    .billing-table td {
        height: 18px;
    }

    .col-item {
        text-align: left;
        padding-left: 4px;
    }

    .col-amount {
        text-align: right;
        padding-right: 4px;
    }

    .section-title {
        font-weight: 700;
        font-size: 11px;
        margin: 4px 0 3px 0;
        background: #f2f2f2;
        padding: 3px 4px;
        border: 1px solid #222;
        color: #000;
    }

    .total-row {
        font-weight: 700;
        background: #f7f7f7;
    }

    .summary-box {
        margin-top: 6px;
        font-size: 11px;
        font-weight: 700;
        color: #000;
    }

    .summary-row {
        display: flex;
        justify-content: space-between;
        border-bottom: 1px solid #111;
        padding: 2px 0;
        align-items: center;
    }

    .summary-total {
        font-size: 12px;
        margin-top: 3px;
        padding: 4px;
        border: 1px solid #222;
        background: #f7f7f7;
    }

    .in-words {
        margin-top: 3px;
        font-size: 10px;
        text-align: center;
        font-weight: 700;
        color: #000;
    }

    .footer-note {
        margin-top: 3px;
        text-align: center;
        font-size: 10px;
        color: #555;
    }

    .text-end {
        text-align: right;
    }
    .text-center {
        text-align: center;
    }

    @media (max-width: 991px) {
        .billing-page {
            padding: 8px;
        }

        .sheet-meta {
            grid-template-columns: 1fr;
        }

        .meta-label {
            flex-basis: 48%;
        }

        .billing-table th,
        .billing-table td,
        .section-title {
            font-size: 10px;
        }
    }

    @media print {
        @page {
            size: A4 portrait;
            margin: 8mm;
        }

        html,
        body {
            background: #fff !important;
            color: #000 !important;
            margin: 0 !important;
            padding: 0 !important;
            -webkit-print-color-adjust: exact;
            print-color-adjust: exact;
        }

        body * {
            visibility: hidden !important;
        }

        .billing-sheet,
        .billing-sheet * {
            visibility: visible !important;
        }

        .app-header,
        .app-sidebar,
        .app-footer,
        .billing-toolbar,
        .no-print,
        .sidebar-wrapper,
        .main-sidebar,
        .main-header {
            display: none !important;
        }

        .app-wrapper,
        .app-main,
        .app-content,
        .container-fluid,
        .billing-page {
            margin: 0 !important;
            padding: 0 !important;
            background: #fff !important;
            color: #000 !important;
            box-shadow: none !important;
            min-height: 0 !important;
            height: auto !important;
        }

        .billing-sheet {
            position: absolute !important;
            left: 0 !important;
            top: 0 !important;
            width: 100% !important;
            max-width: 100% !important;
            padding: 4mm !important;
            margin: 0 !important;
            border: 1px solid #000 !important;
            overflow: visible !important;
            background: #fff !important;
            color: #000 !important;
            box-shadow: none !important;
            background-image: none !important;
            -webkit-print-color-adjust: exact;
            print-color-adjust: exact;
        }

        .billing-sheet *,
        .billing-table *,
        .section-title,
        .summary-total,
        .total-row {
            background: #fff !important;
            background-image: none !important;
            color: #000 !important;
            box-shadow: none !important;
            text-shadow: none !important;
        }

        .billing-table,
        .billing-table th,
        .billing-table td,
        .section-title,
        .summary-total,
        .summary-row,
        .total-row {
            border-color: #000 !important;
        }

        .sheet-heading,
        .sheet-subtitle {
            color: #000 !important;
            border-color: #000 !important;
        }

        .sheet-meta {
            grid-template-columns: 1fr 1fr !important;
            gap: 6px !important;
            margin: 5mm 0 6mm !important;
        }

        .meta-block {
            border-color: #000 !important;
            padding: 5px 6px !important;
        }

        .meta-block-title {
            border-color: #000 !important;
            margin-bottom: 4px !important;
            padding-bottom: 3px !important;
        }

        .meta-row {
            border-bottom: 1px dotted #777 !important;
        }

        .billing-table {
            border-collapse: collapse !important;
            margin-bottom: 8px !important;
        }

        .section-title {
            padding: 3px 5px !important;
        }

        .summary-box {
            margin-top: 8px !important;
        }

        .footer-note {
            color: #000 !important;
        }
    }
";

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
    <div class="app-content py-4">
        <div class="container-fluid billing-page">
            <div class="billing-toolbar no-print">
                <form method="GET" class="toolbar-form">
                    <label for="month">Month:</label>
                    <input id="month" type="month" name="month" value="<?= htmlspecialchars($selectedMonthYear) ?>">
                    <button class="billing-btn" type="submit">Show Invoice</button>
                    <button class="billing-btn" type="button" onclick="window.location.href='impose-penalty.php?month=<?= urlencode($selectedMonthYear) ?>'">Impose Penalty</button>
                    <button class="billing-btn" type="button" onclick="window.print()">Print</button>
                </form>
            </div>

            <?php if (!$isBillingConfigured): ?>
                <div class="alert alert-danger shadow-sm border-start border-danger border-4 text-start p-4 rounded-3" role="alert">
                    <div class="d-flex align-items-center">
                        <i class="bi bi-exclamation-triangle-fill fs-2 me-3 text-danger"></i>
                        <div>
                            <h4 class="alert-heading fw-bold">Billing Parameters Not Setup</h4>
                            <p class="mb-0">
                                This Depot Station does not have general contract parameters or earning category weightages set up yet. 
                                Please configure them from the MCC Admin Panel -> <strong>Setup Billing</strong> first.
                            </p>
                        </div>
                    </div>
                </div>
            <?php else: ?>
                <div class="billing-sheet">
                    <div class="sheet-heading">MCC BILL INVOICE</div>
                    
                    <div class="sheet-subtitle">PAYABLE AMOUNT DESCRIPTION OF SANITATION WORK AT <?= strtoupper($stationName) ?></div>

                    <div class="sheet-meta">
                        <div class="meta-block">
                            <div class="meta-block-title">Billing Summary</div>
                            <div class="meta-list">
                                <div class="meta-row">
                                    <span class="meta-label">Sanctioned Amount (Total)</span>
                                    <span class="meta-value"><?= number_format($sanctionedAmount, 2) ?></span>
                                </div>
                                <div class="meta-row">
                                    <span class="meta-label">Base Amount</span>
                                    <span class="meta-value"><?= number_format($baseAmount, 2) ?></span>
                                </div>
                                <div class="meta-row">
                                    <span class="meta-label">GST (<?= number_format($gstPercentage, 2) ?>%)</span>
                                    <span class="meta-value"><?= number_format($gstAmount, 2) ?></span>
                                </div>
                                <div class="meta-row">
                                    <span class="meta-label">Contract Period</span>
                                    <span class="meta-value"><?= $contractStart ?> to <?= $contractEnd ?></span>
                                </div>
                                <div class="meta-row">
                                    <span class="meta-label">No. of Days</span>
                                    <span class="meta-value"><?= $contractDays ?></span>
                                </div>
                                <div class="meta-row">
                                    <span class="meta-label">Per Day Budget</span>
                                    <span class="meta-value"><?= number_format($perDayBudget, 2) ?></span>
                                </div>
                                <div class="meta-row">
                                    <span class="meta-label">Billing Month</span>
                                    <span class="meta-value"><?= $monthText ?></span>
                                </div>
                                <div class="meta-row">
                                    <span class="meta-label">Monthly Budget</span>
                                    <span class="meta-value"><?= number_format($monthlyBudget, 2) ?> (<?= $daysInMonth ?> days)</span>
                                </div>
                            </div>
                        </div>

                        <div class="meta-block">
                            <div class="meta-block-title">Contract Details</div>
                            <div class="meta-list">
                                <div class="meta-row">
                                    <span class="meta-label">Depot Station</span>
                                    <span class="meta-value"><?= htmlspecialchars($stationName) ?></span>
                                </div>
                                <div class="meta-row">
                                    <span class="meta-label">Division Name</span>
                                    <span class="meta-value"><?= htmlspecialchars($divisionName) ?></span>
                                </div>
                                <div class="meta-row">
                                    <span class="meta-label">Railway Zone</span>
                                    <span class="meta-value"><?= htmlspecialchars($railwayName) ?></span>
                                </div>
                                <div class="meta-row">
                                    <span class="meta-label">Contractor Agency</span>
                                    <span class="meta-value"><?= htmlspecialchars($contractorName) ?></span>
                                </div>
                                <div class="meta-row">
                                    <span class="meta-label">M.O. / Agreement No.</span>
                                    <span class="meta-value"><?= htmlspecialchars($agreementNo) ?></span>
                                </div>
                            </div>
                        </div>
                    </div>

                <!-- Payable Amount Section -->
                <div class="section-title">S.NO | EARNINGS | WEIGHTAGE | SCORED | AMOUNT</div>

                <table class="billing-table" aria-label="Payable amount details">
                    <thead>
                    <tr>
                        <th style="width: 5%;">S.NO</th>
                        <th style="width: 55%;">EARNINGS</th>
                        <th style="width: 10%;">WEIGHTAGE</th>
                        <th style="width: 10%;">SCORED</th>
                        <th style="width: 20%;">AMOUNT</th>
                    </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($processedEarnings as $pe): ?>
                            <tr>
                                <td><?= $pe['s_no'] ?></td>
                                <td class="col-item"><?= htmlspecialchars($pe['name']) ?></td>
                                <td><?= number_format($pe['weightage'], 2) ?>%</td>
                                <td><?= number_format($pe['score'], 2) ?>%</td>
                                <td class="col-amount"><?= number_format($pe['amount'], 2) ?></td>
                            </tr>
                        <?php endforeach; ?>
                        
                        <tr class="total-row">
                            <td colspan="2" class="col-item"><strong>TOTAL</strong></td>
                            <td><strong><?= number_format($totalWeightageSum, 2) ?>%</strong></td>
                            <td><strong><?= number_format($overallScore, 2) ?>%</strong></td>
                            <td class="col-amount"><strong><?= number_format($totalEarnedAmount, 2) ?></strong></td>
                        </tr>
                    </tbody>
                </table>

                <!-- Deductions Section -->
                <div class="section-title">S.NO | DEDUCTIONS | AMOUNT</div>

                <table class="billing-table" aria-label="Deductions details">
                    <thead>
                    <tr>
                        <th style="width: 5%;">S.NO</th>
                        <th style="width: 80%;">DEDUCTIONS</th>
                        <th style="width: 15%;">AMOUNT</th>
                    </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td class="col-item">Manpower Penalty</td>
                            <td class="col-amount"><?= number_format($manpowerPenalty, 2) ?></td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td class="col-item">Machine Penalty</td>
                            <td class="col-amount"><?= number_format($machinePenalty, 2) ?></td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td class="col-item">Chemical Penalty</td>
                            <td class="col-amount"><?= number_format($chemicalPenalty, 2) ?></td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td class="col-item">General Imposed Penalty</td>
                            <td class="col-amount"><?= number_format($generalImposedPenalty, 2) ?></td>
                        </tr>
                        <tr class="total-row">
                            <td colspan="2" class="col-item"><strong>TOTAL</strong></td>
                            <td class="col-amount"><strong><?= number_format($totalDeductions, 2) ?></strong></td>
                        </tr>
                    </tbody>
                </table>

                <!-- Summary Section -->
                <div class="summary-box">
                    <!-- Score Performance Section -->
                    <div style="background-color: #f9f9f9; padding: 6px; margin-bottom: 8px; border: 1px solid #ddd; border-radius: 4px;">
                        <div style="font-weight: bold; margin-bottom: 4px; color: #333; font-size: 10px;">PERFORMANCE SCORE ANALYSIS</div>
                        <div style="font-size: 10px; line-height: 1.4; color: #555;">
                            <div style="display: flex; justify-content: space-between; margin-bottom: 2px;">
                                <span>Total Calculated Score:</span>
                                <span style="font-weight: bold; color: #007bff;"><?= number_format($overallScore, 2) ?>%</span>
                            </div>
                            <div style="display: flex; justify-content: space-between; margin-bottom: 2px;">
                                <span>Applicable Range:</span>
                                <span><?= htmlspecialchars($matchedRangeText) ?></span>
                            </div>
                            <div style="display: flex; justify-content: space-between; margin-bottom: 2px;">
                                <span>Description:</span>
                                <span><?= htmlspecialchars($performanceDesc) ?></span>
                            </div>
                        </div>
                    </div>

                    <div class="summary-row">
                        <span>TOTAL VALUE OF WORK DONE (Monthly Budget):</span>
                        <span><?= number_format($totalEarnedAmount, 2) ?></span>
                    </div>
                    <div class="summary-row">
                        <span>Less: PENALTIES / DEDUCTIONS:</span>
                        <span><?= number_format($totalDeductions, 2) ?></span>
                    </div>
                    <?php if ($scoreBasedDeduction > 0): ?>
                        <div class="summary-row">
                            <span>Less: SCORE-BASED EXTRA PENALTY (<?= number_format($scoreBasedDeductionRate, 2) ?>%):</span>
                            <span style="color: #dc3545;"><?= number_format($scoreBasedDeduction, 2) ?></span>
                        </div>
                    <?php endif; ?>
                    <div class="summary-row">
                        <span>TAXABLE AMOUNT (After Deductions):</span>
                        <span><?= number_format($taxableAmount, 2) ?></span>
                    </div>
                    <div class="summary-row">
                        <span>GST (<?= number_format($gstPercentage, 2) ?>%) on Taxable Amount:</span>
                        <span><?= number_format($billingGstAmount, 2) ?></span>
                    </div>
                    <div class="summary-row" style="border-top: 2px solid #000; padding-top: 8px; font-weight: bold;">
                        <span>TOTAL PAYABLE AMOUNT:</span>
                        <span><?= number_format($totalPayableAmount, 2) ?></span>
                    </div>
                    <div class="summary-row">
                        <span>TOTAL ROUND OFF OF PAYABLE AMOUNT:</span>
                        <span><?= number_format($totalPayableRound) ?></span>
                    </div>
                </div>

                <div class="in-words">
                    IN WORDS: <?= htmlspecialchars($inWordsText) ?>
                </div>

                <div class="footer-note">
                    THIS IS A COMPUTER GENERATED INVOICE AND NO SIGNATURE IS REQUIRED.
                </div>
            </div>
            <?php endif; ?>
        </div>
    </div>
</main>

<?php
include 'footer.php';
?>
