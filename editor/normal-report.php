<?php
require_once 'auth.php';
global $pdo;

$fromDate = $_GET['from_date'] ?? date('Y-m-d', strtotime('-6 days'));
$toDate = $_GET['to_date'] ?? date('Y-m-d');
$editToken = $_GET['edit'] ?? '';
$flashSuccess = '';
$flashError = '';

// Handle Direct PHP POST Save & Delete Coach
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // 1. Remove Coach Action
    if (isset($_POST['remove_coach_btn'])) {
        $targetToken = trim($_POST['token_id'] ?? '');
        $coachToRemove = trim($_POST['remove_coach_btn'] ?? '');

        if (!empty($targetToken) && !empty($coachToRemove)) {
            try {
                $pdo->beginTransaction();

                $delStmt = $pdo->prepare("DELETE FROM mcc_normal_scorecard_report WHERE token_id = :tok AND station_id = :sid AND coach_no = :c_no");
                $delStmt->execute(['tok' => $targetToken, 'sid' => $stationId, 'c_no' => $coachToRemove]);

                try {
                    $delChem = $pdo->prepare("DELETE FROM mcc_chemical_report WHERE token_id = :tok AND station_id = :sid AND coach_no = :c_no");
                    $delChem->execute(['tok' => $targetToken, 'sid' => $stationId, 'c_no' => $coachToRemove]);
                } catch (Exception $ex) {}

                $pdo->commit();
                $flashSuccess = "Coach " . htmlspecialchars($coachToRemove) . " removed successfully from Scorecard (Token: " . htmlspecialchars($targetToken) . ")!";
                $editToken = $targetToken; // Keep in edit mode so user sees the change
            } catch (Exception $e) {
                if ($pdo->inTransaction()) {
                    $pdo->rollBack();
                }
                $flashError = "Failed to remove coach: " . $e->getMessage();
            }
        }
    }

    // 2. Save Sheet Changes (Date, Coaches, Scores)
    if (isset($_POST['save_sheet_changes'])) {
        $targetToken = trim($_POST['token_id'] ?? '');
        $newReportDate = trim($_POST['sheet_report_date'] ?? '');
        $coachRenames = $_POST['coach_rename'] ?? [];
        $newCoaches = $_POST['new_coaches'] ?? [];
        $postedScores = $_POST['scores'] ?? [];

        if (!empty($targetToken)) {
            try {
                $pdo->beginTransaction();

                $chk = $pdo->prepare("SELECT COUNT(*) FROM mcc_normal_scorecard_report WHERE token_id = :tok AND station_id = :sid");
                $chk->execute(['tok' => $targetToken, 'sid' => $stationId]);

                if ($chk->fetchColumn() > 0) {
                    // A. Update Report Date if provided
                    if (!empty($newReportDate) && preg_match('/^\d{4}-\d{2}-\d{2}$/', $newReportDate)) {
                        $dateUpd = $pdo->prepare("UPDATE mcc_normal_scorecard_report SET report_date = :dt WHERE token_id = :tok AND station_id = :sid");
                        $dateUpd->execute(['dt' => $newReportDate, 'tok' => $targetToken, 'sid' => $stationId]);

                        try {
                            $chemDateUpd = $pdo->prepare("UPDATE mcc_chemical_report SET report_date = :dt WHERE token_id = :tok AND station_id = :sid");
                            $chemDateUpd->execute(['dt' => $newReportDate, 'tok' => $targetToken, 'sid' => $stationId]);
                        } catch (Exception $ex) {}

                        // Ensure updated date falls within current filter range so it remains visible
                        if ($newReportDate < $fromDate) $fromDate = $newReportDate;
                        if ($newReportDate > $toDate) $toDate = $newReportDate;
                    }

                    // B. Process Coach Renames / Deletions
                    $delCoachStmt = $pdo->prepare("DELETE FROM mcc_normal_scorecard_report WHERE token_id = :tok AND station_id = :sid AND coach_no = :c_no");
                    $renameCoachStmt = $pdo->prepare("UPDATE mcc_normal_scorecard_report SET coach_no = :new_c WHERE token_id = :tok AND station_id = :sid AND coach_no = :old_c");

                    foreach ($coachRenames as $oldCoach => $newCoach) {
                        $oldCoach = trim((string)$oldCoach);
                        $newCoach = trim((string)$newCoach);
                        if ($oldCoach === '') continue;

                        if ($newCoach === '') {
                            // Empty coach name means user wants to remove this coach
                            $delCoachStmt->execute(['tok' => $targetToken, 'sid' => $stationId, 'c_no' => $oldCoach]);
                            try {
                                $delChem = $pdo->prepare("DELETE FROM mcc_chemical_report WHERE token_id = :tok AND station_id = :sid AND coach_no = :c_no");
                                $delChem->execute(['tok' => $targetToken, 'sid' => $stationId, 'c_no' => $oldCoach]);
                            } catch (Exception $ex) {}
                        } elseif ($newCoach !== $oldCoach) {
                            // Rename coach
                            $renameCoachStmt->execute(['new_c' => $newCoach, 'tok' => $targetToken, 'sid' => $stationId, 'old_c' => $oldCoach]);
                            try {
                                $renameChem = $pdo->prepare("UPDATE mcc_chemical_report SET coach_no = :new_c WHERE token_id = :tok AND station_id = :sid AND coach_no = :old_c");
                                $renameChem->execute(['new_c' => $newCoach, 'tok' => $targetToken, 'sid' => $stationId, 'old_c' => $oldCoach]);
                            } catch (Exception $ex) {}
                        }
                    }

                    // C. Process Adding New Coaches
                    $actualNewCoaches = array_filter(array_map('trim', (array)$newCoaches), function($c) { return $c !== ''; });
                    if (!empty($actualNewCoaches)) {
                        $sampleStmt = $pdo->prepare("SELECT train_no, report_date, auditor_name, audit_by FROM mcc_normal_scorecard_report WHERE token_id = :tok AND station_id = :sid LIMIT 1");
                        $sampleStmt->execute(['tok' => $targetToken, 'sid' => $stationId]);
                        $sampleRow = $sampleStmt->fetch(PDO::FETCH_ASSOC);

                        if ($sampleRow) {
                            $insertCoachStmt = $pdo->prepare("
                                INSERT INTO mcc_normal_scorecard_report 
                                (station_id, token_id, train_no, coach_no, sub_parameter_id, score_value, auditor_name, audit_by, report_date) 
                                VALUES (:sid, :tok, :train_no, :coach_no, :sp_id, :score_val, :aud_name, :aud_by, :rep_date)
                            ");

                            $allSpStmt = $pdo->prepare("
                                SELECT sp.id 
                                FROM mcc_normal_scorecard_sub_param sp 
                                JOIN mcc_normal_scorecard_param p ON sp.parameter_id = p.id 
                                WHERE p.station_id = :param_station_id AND sp.station_id = :sub_station_id AND p.status = 'Active' AND sp.status = 'Active'
                            ");
                            $allSpStmt->execute(['param_station_id' => $stationId, 'sub_station_id' => $stationId]);
                            $activeSpIds = $allSpStmt->fetchAll(PDO::FETCH_COLUMN);

                            foreach ($actualNewCoaches as $nc) {
                                $cExists = $pdo->prepare("SELECT COUNT(*) FROM mcc_normal_scorecard_report WHERE token_id = :tok AND station_id = :sid AND coach_no = :c_no");
                                $cExists->execute(['tok' => $targetToken, 'sid' => $stationId, 'c_no' => $nc]);
                                if ($cExists->fetchColumn() == 0) {
                                    $repDateForNew = !empty($newReportDate) ? $newReportDate : $sampleRow['report_date'];
                                    foreach ($activeSpIds as $spId) {
                                        $insertCoachStmt->execute([
                                            'sid' => $stationId,
                                            'tok' => $targetToken,
                                            'train_no' => $sampleRow['train_no'],
                                            'coach_no' => $nc,
                                            'sp_id' => $spId,
                                            'score_val' => '0',
                                            'aud_name' => $sampleRow['auditor_name'],
                                            'aud_by' => $sampleRow['audit_by'],
                                            'rep_date' => $repDateForNew
                                        ]);
                                    }
                                }
                            }
                        }
                    }

                    // D. Update Scores
                    if (!empty($postedScores)) {
                        $updStmt = $pdo->prepare("
                            UPDATE mcc_normal_scorecard_report 
                            SET score_value = :val 
                            WHERE token_id = :tok 
                              AND station_id = :sid 
                              AND sub_parameter_id = :sp_id 
                              AND coach_no = :c_no
                        ");

                        foreach ($postedScores as $spId => $coachVals) {
                            foreach ($coachVals as $cNo => $val) {
                                $finalCoach = isset($coachRenames[$cNo]) ? trim((string)$coachRenames[$cNo]) : $cNo;
                                if ($finalCoach === '') continue; // Skip deleted coach

                                $updStmt->execute([
                                    'val' => trim($val),
                                    'tok' => $targetToken,
                                    'sid' => $stationId,
                                    'sp_id' => $spId,
                                    'c_no' => $finalCoach
                                ]);
                            }
                        }
                    }

                    $pdo->commit();
                    $dateNote = (!empty($newReportDate)) ? " (Date: " . date('d-m-Y', strtotime($newReportDate)) . ")" : "";
                    $flashSuccess = "Scorecard (Token: " . htmlspecialchars($targetToken) . ") updated successfully{$dateNote}!";
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
}

// Fetch normal rating values from database
$ratingStmt = $pdo->query("SELECT rating_name, rating_value, rating_group FROM mcc_normal_rating ORDER BY rating_value DESC");
$ratings = $ratingStmt->fetchAll(PDO::FETCH_ASSOC);
$ratingStrings = [];
foreach ($ratings as $r) {
    $ratingStrings[] = htmlspecialchars($r['rating_name']) . "-" . htmlspecialchars($r['rating_value']);
}
$ratingText = implode(', ', $ratingStrings);

// Fetch the current station's name & contractor for meta info
$stationQuery = $pdo->prepare("SELECT station_name, contractor_name FROM mcc_stations WHERE station_id = :station_id");
$stationQuery->execute(['station_id' => $stationId]);
$stnData = $stationQuery->fetch(PDO::FETCH_ASSOC);
$stationName = $stnData['station_name'] ?? 'Lumdhing';
$contractorName = !empty($stnData['contractor_name']) ? $stnData['contractor_name'] : 'Kingson Services';

// Fetch distinct tokens/trains for THIS AUDITOR ONLY
$stmt = $pdo->prepare("
    SELECT DISTINCT token_id, train_no, report_date 
    FROM mcc_normal_scorecard_report 
    WHERE station_id = :station_id
      AND report_date BETWEEN :from_date AND :to_date 
    ORDER BY report_date DESC, token_id DESC
");
$stmt->execute([
    'station_id' => $stationId, 
    'from_date' => $fromDate, 
    'to_date' => $toDate
]);
$tokens = $stmt->fetchAll();

// Fetch active parameters and subparameters from the database for normal report
$paramsStmt = $pdo->prepare("
    SELECT p.id AS parameter_id, p.parameter_name, sp.id AS sub_parameter_id, sp.sub_parameter_name
    FROM mcc_normal_scorecard_param p
    JOIN mcc_normal_scorecard_sub_param sp ON p.id = sp.parameter_id
    WHERE p.station_id = :param_station_id AND sp.station_id = :sub_station_id AND p.status = 'Active' AND sp.status = 'Active'
    ORDER BY p.id ASC, sp.id ASC
");
$paramsStmt->execute([
    'param_station_id' => $stationId,
    'sub_station_id' => $stationId
]);
$paramsRows = $paramsStmt->fetchAll();

// Group subparameters by parameter
$dynamicParameters = [];
foreach ($paramsRows as $row) {
    $pId = $row['parameter_id'];
    if (!isset($dynamicParameters[$pId])) {
        $dynamicParameters[$pId] = [
            'name' => $row['parameter_name'],
            'sub_parameters' => []
        ];
    }
    $dynamicParameters[$pId]['sub_parameters'][] = [
        'id' => $row['sub_parameter_id'],
        'name' => $row['sub_parameter_name']
    ];
}

$sheets = [];
$isFallback = empty($tokens);

if (!$isFallback) {
    $scoresStmt = $pdo->prepare("
        SELECT s.* 
        FROM mcc_normal_scorecard_report s
        WHERE s.station_id = :station_id AND s.token_id = :token_id
        ORDER BY s.id ASC
    ");

    foreach ($tokens as $t) {
        $tokenId = $t['token_id'];
        $trainNo = $t['train_no'];
        $reportDate = $t['report_date'];

        $scoresStmt->execute(['station_id' => $stationId, 'token_id' => $tokenId]);
        $rows = $scoresStmt->fetchAll();

        $scoresData = [];
        $supervisorName = $auditorName;
        $dbCoaches = [];

        if (!empty($rows)) {
            $firstRow = $rows[0];
            if (!empty($firstRow['auditor_name'])) {
                $supervisorName = $firstRow['auditor_name'];
            } elseif (!empty($firstRow['submitted_by'])) {
                if (is_numeric($firstRow['submitted_by'])) {
                    $uStmt = $pdo->prepare("SELECT user_name FROM mcc_users WHERE user_id = :uid");
                    $uStmt->execute(['uid' => $firstRow['submitted_by']]);
                    $supervisorName = $uStmt->fetchColumn() ?: $auditorName;
                } else {
                    $supervisorName = $firstRow['submitted_by'];
                }
            }

            foreach ($rows as $row) {
                $scoresData[$row['sub_parameter_id']][$row['coach_no']] = $row['score_value'];
                $dbCoaches[$row['coach_no']] = true;
            }
            $dbCoaches = array_keys($dbCoaches);
        }

        $attendedCount = count($dbCoaches);

        $coaches = $dbCoaches;
        while (count($coaches) < 24) {
            $coaches[] = '';
        }

        $parameterIds = array_keys($dynamicParameters);
        $internalParamId = $parameterIds[0] ?? 0;
        $externalParamId = $parameterIds[1] ?? 0;
        $wateringParamId = $parameterIds[2] ?? 0;

        $internalSum = 0;
        $internalSubParamCount = 0;
        if ($internalParamId && isset($dynamicParameters[$internalParamId])) {
            $internalSubParamCount = count($dynamicParameters[$internalParamId]['sub_parameters']);
            foreach ($coaches as $coach) {
                if ($coach === '') continue;
                foreach ($dynamicParameters[$internalParamId]['sub_parameters'] as $sp) {
                    $val = $scoresData[$sp['id']][$coach] ?? null;
                    if ($val !== null && is_numeric($val)) {
                        $internalSum += intval($val);
                    }
                }
            }
        }
        $internalMax = $attendedCount * $internalSubParamCount * 3;
        $internalPercentage = $internalMax > 0 ? round(($internalSum / $internalMax) * 100, 1) : 0;

        $externalSum = 0;
        $externalSubParamCount = 0;
        if ($externalParamId && isset($dynamicParameters[$externalParamId])) {
            $externalSubParamCount = count($dynamicParameters[$externalParamId]['sub_parameters']);
            foreach ($coaches as $coach) {
                if ($coach === '') continue;
                foreach ($dynamicParameters[$externalParamId]['sub_parameters'] as $sp) {
                    $val = $scoresData[$sp['id']][$coach] ?? null;
                    if ($val !== null && is_numeric($val)) {
                        $externalSum += intval($val);
                    }
                }
            }
        }
        $externalMax = $attendedCount * $externalSubParamCount * 3;
        $externalPercentage = $externalMax > 0 ? round(($externalSum / $externalMax) * 100, 1) : 0;

        $wateringYes = 0;
        $wateringSubParamCount = 0;
        if ($wateringParamId && isset($dynamicParameters[$wateringParamId])) {
            $wateringSubParamCount = count($dynamicParameters[$wateringParamId]['sub_parameters']);
            foreach ($coaches as $coach) {
                if ($coach === '') continue;
                foreach ($dynamicParameters[$wateringParamId]['sub_parameters'] as $sp) {
                    $val = $scoresData[$sp['id']][$coach] ?? null;
                    if ($val === 'Y') {
                        $wateringYes++;
                    }
                }
            }
        }
        $wateringMaxCount = $attendedCount * $wateringSubParamCount;
        $wateringPercentage = $wateringMaxCount > 0 ? round(($wateringYes / $wateringMaxCount) * 100, 1) : 0;

        $auditById = $firstRow['audit_by'] ?? $auditorId;
        $auditorSig = resolveAuditorSignature($pdo, $auditById, $supervisorName);

        $sheets[] = [
            'token_id' => $tokenId,
            'train_no' => $trainNo,
            'report_date' => $reportDate,
            'supervisor_name' => $supervisorName,
            'auditor_signature' => $auditorSig,
            'coaches' => $coaches,
            'scores_data' => $scoresData,
            'internal_percentage' => $internalPercentage,
            'external_percentage' => $externalPercentage,
            'watering_percentage' => $wateringPercentage,
            'is_fallback' => false,
            'watering_percentage' => $wateringPercentage,
            'is_fallback' => false,
            'attended_count' => $attendedCount,
            'isApproved' => (int)($firstRow['isApproved'] ?? 0)
        ];
    }
}

// Penalty parameters for Annexure A-1 (Back side)
$penaltyItems = [
    [
        'sr' => 1,
        'item' => 'If on any day cleaning activities are not carried out for reasons other than those attributed to force majeure, then penalty of Rs. 20000/- per day/rake shall be imposed. In such cases no separate penalty for shortage of manpower shall be imposed.',
        'rate' => 20000,
        'type' => 'rake'
    ],
    [
        'sr' => 2,
        'item' => 'Penalty to the tune of Rs. 500/- shall be imposed per rake per instance for not locking/unlocking of coaches as detailed under the \'Schedule of Work\'.',
        'rate' => 500,
        'type' => 'rake'
    ],
    [
        'sr' => 3,
        'item' => 'Penalty of Rs. 500/- per coach per occasion shall be imposed for not watering any coach.',
        'rate' => 500,
        'type' => 'coach'
    ],
    [
        'sr' => 4,
        'item' => 'Penalty of Rs. 500/- per machine/pit line shall be imposed for not deploying machines as per resource specification.',
        'rate' => 500,
        'type' => 'rake'
    ],
    [
        'sr' => 5,
        'item' => 'Penalty of Rs. 200/- per occasion if flooding of water inside coach (other than toilet floor) is reported during cleaning activity.',
        'rate' => 200,
        'type' => 'coach'
    ],
    [
        'sr' => 6,
        'item' => 'Penalty of Rs. 200/- per coach shall be imposed for not dry mopping of toilet floor/coach floor.',
        'rate' => 200,
        'type' => 'coach'
    ],
    [
        'sr' => 7,
        'item' => 'Penalty of Rs. 1000/- shall be imposed per occasion for dropping garbage, collected from the coaches during dry sweeping, on the railway track/ maintenance line.',
        'rate' => 1000,
        'type' => 'rake'
    ],
    [
        'sr' => 8,
        'item' => 'Penalty of Rs. 1000/- per coach per case shall be imposed if the toiletries is not supplied as per the prescribed quantity.(As applicable)',
        'rate' => 1000,
        'type' => 'coach'
    ],
    [
        'sr' => 9,
        'item' => 'Penalty of Rs. 2000/- per rake per case shall be imposed if chemicals used are of unapproved brand or less than the prescribed quantity.',
        'rate' => 2000,
        'type' => 'rake'
    ],
    [
        'sr' => 10,
        'item' => 'A penalty of Rs. 200/- per person will be levied for the staff having improper uniform.',
        'rate' => 200,
        'type' => 'rake'
    ],
    [
        'sr' => 11,
        'item' => 'Penalty of Rs. 1000/- plus minimum wages per shortage of manpower',
        'rate' => 1000,
        'type' => 'rake'
    ],
    [
        'sr' => 12,
        'item' => 'Penalty of Rs. 200/-per coach per case shall be imposed if the soap dispensers are not provided as per the prescribed quantity.',
        'rate' => 200,
        'type' => 'coach'
    ],
    [
        'sr' => 13,
        'item' => 'Any other penalty as specified',
        'rate' => 0,
        'type' => 'custom'
    ]
];

$pageTitle = 'Normal Score Card | MCC Auditor';

$extraStyles = "
.report-wrap{
    padding:10px;
    background:#f5f5f5;
    min-height:100vh;
    font-family: 'Roboto' ! IMPORTANT;
}

.report-frame{
    background:#efefef;
    border:1px solid #999;
    padding:15px 20px !important;
    width:100%;
    overflow-x:auto;
    margin-bottom: 40px !important;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1) !important;
    border-radius: 8px !important;
}

.report-frame:last-child {
    margin-bottom: 0 !important;
}

.penalty-frame {
    border: 1px solid #888 !important;
    background: #efefef !important;
}

.penalty-table th, .penalty-table td {
    padding: 5px 3px !important;
    font-size: 11.5px;
}

.penalty-pill {
    display: inline-block;
    padding: 2px 4px;
    font-size: 10px;
    font-weight: 700;
    border-radius: 3px;
    text-align: center;
    min-width: 25px;
    user-select: none;
    cursor: default;
}

.penalty-pill-no {
    background: #f8fafc;
    color: #475569;
    border: 1px solid #cbd5e1;
}

.view-toggle-wrap {
    display: inline-flex;
    gap: 6px;
    margin-left: auto;
}

.btn-view-toggle {
    padding: 6px 14px;
    font-size: 12px;
    font-weight: 600;
    border-radius: 4px;
    border: 1px solid #1987C6;
    background: #fff;
    color: #1987C6;
    cursor: pointer;
    transition: all 0.15s ease;
}

.btn-view-toggle:hover {
    background: #e0f2fe;
}

.btn-view-toggle.active {
    background: #1987C6;
    color: #fff;
    box-shadow: 0 2px 4px rgba(25, 135, 198, 0.25);
}

.report-header h2{
    text-align:center;
    font-size:20px;
    font-weight:700;
    color:#000;
    margin-bottom:0;
}

.report-meta-section{
    width:100%;
    margin-top:5px;
    margin-bottom:10px;
    color:#000;
}

.meta-row{
    display:flex;
    justify-content:center;
    align-items:center;
    gap:25px;
    margin-bottom:2px;
    flex-wrap:wrap;
}

.meta-item{
    font-size:12px;
    font-weight:600;
    white-space:nowrap;
    line-height:.5;
}

.meta-item span{
    font-weight:700;
}

.report-table{
    width:100%;
    border-collapse:collapse;
    font-size:13px;
    background:#fff;
}

.report-table th,
.report-table td{
    border:1px solid #000;
    padding:6px;
    text-align:center;
    vertical-align:middle;
    font-weight:500;
}

.report-table th{
    background: linear-gradient(180deg, #07203a 0%, #07182c 100%) !important;
    color: #fff !important;
    font-weight: 700;
    border-color: #0b476a !important;
}

.sub-category{
    background:#f2f2f2 !important;
    font-weight:600;
    text-align:left !important;
}

.sub-category td{
    padding-left:18px !important;
    text-align:left !important;
    font-weight:700;
}

.report-info{
    margin-top:20px;
    padding:15px;
    background:#fff;
    border:1px solid #ccc;
    font-size:12px;
}

.report-info ul{
    margin:5px 0 0 20px;
    padding:0;
}

.signature-row{
    display:flex;
    justify-content:space-between;
    margin-top:20px;
    padding:0 50px;
}

.signature-box{
    text-align:center;
    width:220px;
}

.signature-img-wrap{
    height:50px;
    display:flex;
    align-items:flex-end;
    justify-content:center;
    margin-bottom:5px;
}

.signature-img-wrap img{
    max-height:45px;
    max-width:180px;
    object-fit:contain;
}

.signature-line{
    border-top:1px solid #000;
    margin-top:5px;
    font-size:12px;
    font-weight:700;
    padding-top:2px;
}

.report-filter{
    background:#fff;
    padding:12px 15px;
    display:flex;
    align-items:center;
    gap:10px;
    margin-bottom:15px;
    border-radius:6px;
    border:1px solid #ccc;
    box-shadow:0 2px 4px rgba(0,0,0,0.05);
    flex-wrap:wrap;
}

.report-filter label{
    font-size:13px;
    font-weight:600;
    color:#333;
}

.report-filter input[type='date']{
    padding:4px 8px;
    border:1px solid #aaa;
    border-radius:4px;
    font-size:13px;
}

.btn-go{
    background:#17476f;
    color:#fff;
    border:none;
    padding:5px 15px;
    border-radius:4px;
    cursor:pointer;
    font-weight:600;
    font-size:13px;
}

.btn-go:hover{
    background:#07203a;
}

.btn-print{
    background:#198754;
    color:#fff;
    border:none;
    padding:5px 15px;
    border-radius:4px;
    cursor:pointer;
    font-weight:600;
    font-size:13px;
    margin-left:auto;
}

.btn-print:hover{
    background:#157347;
}

@media print{
    .app-header,
    .app-sidebar,
    .app-footer,
    .report-filter,
    .no-print{
        display:none !important;
        visibility:hidden !important;
        height:0 !important;
        width:0 !important;
        margin:0 !important;
        padding:0 !important;
    }

    html, body, .app-wrapper, .app-main, .app-content, .container-fluid, .report-wrap{
        padding:0 !important;
        margin:0 !important;
        background:#fff !important;
        width:100% !important;
        max-width:100% !important;
    }

    .report-frame{
        border:none !important;
        background:#fff !important;
        padding:0 !important;
        margin-bottom: 0 !important;
        page-break-after: always !important;
        break-after: page !important;
    .penalty-frame {
        page-break-before: always !important;
        break-before: page !important;
        page-break-after: always !important;
        break-after: page !important;
    }

    .report-table th{
        background:#07203a !important;
        color:#fff !important;
        -webkit-print-color-adjust:exact !important;
        print-color-adjust:exact !important;
    }
}
";

include 'header.php';
include 'sidebar.php';
?>

<main class="app-main">
    <div class="app-content">
        <div class="container-fluid">
            <form class="report-filter no-print" method="GET">
                <label>From:</label>
                <input type="date" name="from_date" value="<?= htmlspecialchars($fromDate); ?>">

                <label>To:</label>
                <input type="date" name="to_date" value="<?= htmlspecialchars($toDate); ?>">

                <button type="submit" class="btn-go"><i class="bi bi-filter me-1"></i>Filter</button>

                <button type="button" class="btn-print" onclick="window.print()">
                    <i class="bi bi-printer me-1"></i>Print
                </button>

                <!-- BACK SIDE VIEW TOGGLE (Temporarily disabled - uncomment to re-enable when Back Side is restored)
                <div class="view-toggle-wrap no-print">
                    <button type="button" class="btn-view-toggle active" id="btn-toggle-all" onclick="setScorecardView('all')">
                        <i class="bi bi-layout-split me-1"></i>Both Sides
                    </button>
                    <button type="button" class="btn-view-toggle" id="btn-toggle-front" onclick="setScorecardView('front')">
                        <i class="bi bi-file-earmark-text me-1"></i>Front Side
                    </button>
                    <button type="button" class="btn-view-toggle" id="btn-toggle-back" onclick="setScorecardView('back')">
                        <i class="bi bi-shield-exclamation me-1"></i>Back Side
                    </button>
                </div>
                -->
            </form>

<div class="report-wrap">
    <?php if (!empty($flashSuccess)): ?>
        <div class="alert alert-success alert-dismissible fade show mb-3" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i><strong>Success!</strong> <?= $flashSuccess ?>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <?php endif; ?>
    <?php if (!empty($flashError)): ?>
        <div class="alert alert-danger alert-dismissible fade show mb-3" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i><strong>Error!</strong> <?= $flashError ?>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <?php endif; ?>

    <?php if ($isFallback): ?>
        <div class="alert alert-warning" style="margin: 0 0 15px 0; border-radius: 8px; border: 1px solid #ffeeba; background-color: #fff3cd; color: #856404; padding: 12px 20px;">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> No normal cleaning scorecards found filled by you in the selected date range.
        </div>
    <?php endif; ?>

    <?php foreach ($sheets as $sheet): 
        $isEditingThisSheet = (!$sheet['is_fallback'] && !empty($sheet['token_id']) && (string)$editToken === (string)$sheet['token_id']);
    ?>
        <?php if ($isEditingThisSheet): ?>
        <form method="POST" action="">
            <input type="hidden" name="token_id" value="<?= htmlspecialchars($sheet['token_id']) ?>">
            <input type="hidden" name="from_date" value="<?= htmlspecialchars($fromDate) ?>">
            <input type="hidden" name="to_date" value="<?= htmlspecialchars($toDate) ?>">
        <?php endif; ?>

        <!-- FRONT SIDE -->
        <div class="report-frame front-frame" id="front-<?= htmlspecialchars($sheet['token_id'] ?? '') ?>" style="<?= $isEditingThisSheet ? 'border: 2px solid #0284c7; box-shadow: 0 0 22px rgba(2, 132, 199, 0.35);' : '' ?>">
            <div class="report-header" style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #999; padding-bottom: 10px; margin-bottom: 15px;">
                <h2 style="margin: 0;">Score Card For Normal Cleaning</h2>
                <div class="d-flex align-items-center gap-2">
                    <?php if (!$sheet['is_fallback'] && !empty($sheet['token_id'])): ?>
                        <span style="font-family: monospace; font-weight: 700; font-size: 13px; background: #e2e8f0; color: #475569; padding: 4px 10px; border-radius: 6px; border: 1px solid #cbd5e1;">Token: <?= htmlspecialchars($sheet['token_id']) ?></span>
                    <?php endif; ?>

                    <?php if (!empty($sheet['isApproved'])): ?>
                        <span class="badge bg-success px-3 py-2 text-white" style="font-size: 0.85rem; font-weight: 600; border-radius: 6px;"><i class="bi bi-patch-check-fill me-1"></i> Approved</span>
                    <?php else: ?>
                        <span class="badge bg-warning text-dark px-3 py-2" style="font-size: 0.85rem; font-weight: 600; border-radius: 6px;"><i class="bi bi-clock-history me-1"></i> Pending Approval</span>
                    <?php endif; ?>

                    <?php if (!$sheet['is_fallback'] && !empty($sheet['token_id'])): ?>
                        <?php if ($isEditingThisSheet): ?>
                            <button type="submit" name="save_sheet_changes" class="btn btn-sm btn-success fw-bold text-white no-print shadow-sm px-3" style="font-weight: 700;">
                                <i class="bi bi-check2-circle me-1"></i> Save Changes
                            </button>
                            <a href="?from_date=<?= urlencode($fromDate) ?>&to_date=<?= urlencode($toDate) ?>" class="btn btn-sm btn-secondary fw-bold text-white no-print shadow-sm px-3">
                                <i class="bi bi-x-circle me-1"></i> Cancel
                            </a>
                        <?php else: ?>
                            <a href="?from_date=<?= urlencode($fromDate) ?>&to_date=<?= urlencode($toDate) ?>&edit=<?= urlencode($sheet['token_id']) ?>" class="btn btn-sm fw-bold text-dark no-print shadow-sm px-3" style="background-color: #fbbf24 !important; color: #000000 !important; font-weight: 700 !important; border: 1px solid #f59e0b;" title="Edit Sheet">
                                <i class="bi bi-pencil-square me-1"></i> Edit Sheet
                            </a>
                        <?php endif; ?>
                    <?php endif; ?>
                </div>
            </div>

            <?php if ($isEditingThisSheet): ?>
                <div class="alert alert-info py-2 px-3 mb-3 d-flex align-items-center justify-content-between no-print" style="border: 1px solid #b9e6fe; background-color: #f0f9ff; color: #0369a1; border-radius: 6px;">
                    <span class="small fw-semibold"><i class="bi bi-info-circle-fill me-1"></i> <strong>Edit Mode Active:</strong> You can edit the Date of Inspection, edit/rename coach numbers, remove coaches, add new coaches (+ Coach), and update scores in the table cells below. Click <strong>Save Changes</strong> above to save directly to the database.</span>
                </div>
            <?php endif; ?>

            <div class="report-meta-section">
                <div class="meta-row">
                    <div class="meta-item">
                        <span>Date of Inspection:</span>
                        <?php if ($isEditingThisSheet): ?>
                            <input type="date" name="sheet_report_date" value="<?= htmlspecialchars($sheet['report_date']) ?>" class="form-control form-control-sm text-center fw-bold d-inline-block" style="width: 145px; padding: 2px 6px; font-size: 12px; border: 2px solid #0284c7; background: #fff !important; color: #000 !important; border-radius: 4px;" required>
                        <?php else: ?>
                            <?= htmlspecialchars(date('d-m-Y', strtotime($sheet['report_date']))) ?>
                        <?php endif; ?>
                    </div>
                    <div class="meta-item">
                        <span>Name of Supervisor:</span>
                        <?= htmlspecialchars($sheet['supervisor_name']) ?>
                    </div>
                    <div class="meta-item">
                        <span>Name of Contractor:</span>
                        <?= htmlspecialchars($contractorName) ?>
                    </div>
                    <div class="meta-item">
                        <span>Time Work Started:</span>
                        <?= !$sheet['is_fallback'] ? '08:00' : '....................' ?>
                    </div>
                    <div class="meta-item">
                        <span>Time Work Completed:</span>
                        <?= !$sheet['is_fallback'] ? '12:00' : '....................' ?>
                    </div>
                </div>

                <div class="meta-row">
                    <div class="meta-item">
                        <span>Name of Depot:</span>
                        <?= htmlspecialchars($stationName) ?> Coaching Depot
                    </div>
                    <div class="meta-item">
                        <span>Train No:</span>
                        <?= htmlspecialchars($sheet['train_no']) ?>
                    </div>
                    <div class="meta-item">
                        <span>Number of Coaches Attended :</span>
                        <?= $sheet['attended_count'] ?>
                    </div>
                    <div class="meta-item">
                        <span>Internal Cleaning Score :</span>
                        <?= $sheet['internal_percentage'] ?> %
                    </div>
                    <div class="meta-item">
                        <span>External Cleaning Score :</span>
                        <?= $sheet['external_percentage'] ?> %
                    </div>
                    <div class="meta-item">
                        <span>Watering Score :</span>
                        <?= $sheet['watering_percentage'] ?> %
                    </div>
                </div>
            </div>

            <div class="table-responsive">
                <table class="report-table">
                    <thead>
                        <tr>
                            <th style="width:40px;">S.No</th>
                            <th style="width:auto;">Coach Position</th>
                            <?php for ($i = 1; $i <= count($sheet['coaches']); $i++): ?>
                                <th><?= $i ?></th>
                            <?php endfor; ?>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td></td>
                            <td style="font-weight: 700;">Coach No</td>
                            <?php foreach ($sheet['coaches'] as $cIndex => $coach): 
                                $hasCoach = (trim((string)$coach) !== '');
                            ?>
                                <td style="padding: <?= $isEditingThisSheet ? '3px 2px' : '6px' ?> !important; vertical-align: top; text-align: center;">
                                    <?php if ($isEditingThisSheet): ?>
                                        <?php if ($hasCoach): ?>
                                            <input type="text" 
                                                   name="coach_rename[<?= htmlspecialchars($coach) ?>]" 
                                                   value="<?= htmlspecialchars($coach) ?>" 
                                                   class="form-control form-control-sm text-center fw-bold" 
                                                   style="width: 72px; margin: 0 auto; padding: 2px 3px; font-size: 11px; font-weight: 700; border: 1.5px solid #0284c7; background: #ffffff !important; color: #000000 !important;" 
                                                   title="Edit coach number">
                                            <button type="submit" 
                                                    name="remove_coach_btn" 
                                                    value="<?= htmlspecialchars($coach) ?>" 
                                                    class="btn btn-danger btn-sm py-0 px-1 mt-1 no-print shadow-xs" 
                                                    onclick="return confirm('Are you sure you want to permanently remove coach <?= htmlspecialchars($coach) ?> from this scorecard?')" 
                                                    title="Remove coach <?= htmlspecialchars($coach) ?>" 
                                                    style="font-size: 10px; line-height: 1.3; font-weight: 700; border-radius: 3px;">
                                                <i class="bi bi-x-circle"></i> Remove
                                            </button>
                                        <?php else: ?>
                                            <input type="text" 
                                                   name="new_coaches[<?= $cIndex ?>]" 
                                                   value="" 
                                                   class="form-control form-control-sm text-center" 
                                                   style="width: 72px; margin: 0 auto; padding: 2px 3px; font-size: 10px; border: 1px dashed #94a3b8; background: #f8fafc;" 
                                                   placeholder="+ Coach">
                                        <?php endif; ?>
                                    <?php else: ?>
                                        <?= htmlspecialchars($coach) ?>
                                    <?php endif; ?>
                                </td>
                            <?php endforeach; ?>
                        </tr>

                        <?php 
                        $paramIndex = 0;
                        foreach ($dynamicParameters as $pId => $pData): 
                            $paramLetter = chr(65 + $paramIndex);
                            $paramIndex++;
                        ?>
                            <tr class="sub-category">
                                <td><?= $paramLetter ?></td>
                                <td colspan="<?= count($sheet['coaches']) + 1 ?>">
                                    <?= htmlspecialchars($pData['name']) ?>
                                </td>
                            </tr>

                            <?php 
                            $spIndex = 1;
                            foreach ($pData['sub_parameters'] as $sp): 
                            ?>
                                <tr>
                                    <td><?= $spIndex++ ?></td>
                                    <td style="text-align: left !important; padding-left: 15px !important;">
                                        <?= htmlspecialchars($sp['name']) ?>
                                    </td>

                                    <?php
                                    $isWatering = (stripos($pData['name'] ?? '', 'water') !== false || stripos($sp['name'] ?? '', 'water') !== false);
                                    $optRatings = array_filter($ratings, function($r) use ($isWatering) {
                                        $grp = $r['rating_group'] ?? '';
                                        $val = strtoupper(trim((string)$r['rating_value']));
                                        if ($isWatering) {
                                            return ($grp === 'watering' || in_array($val, ['Y', 'N']));
                                        } else {
                                            return ($grp !== 'watering' && !in_array($val, ['Y', 'N']));
                                        }
                                    });
                                    if (empty($optRatings)) {
                                        $optRatings = $isWatering 
                                            ? [['rating_value' => 'Y'], ['rating_value' => 'N']]
                                            : [['rating_value' => '3'], ['rating_value' => '2'], ['rating_value' => '1'], ['rating_value' => '0']];
                                    }

                                    foreach ($sheet['coaches'] as $coach) {
                                        $hasCoach = (trim((string)$coach) !== '');
                                        $s = $hasCoach ? ($sheet['scores_data'][$sp['id']][$coach] ?? '-') : '';
                                        if ($isEditingThisSheet) {
                                            if ($hasCoach) {
                                                $val = ($s === '-' ? '' : (string)$s);
                                                echo "<td style='padding: 2px !important;'>";
                                                echo "<select name='scores[" . $sp['id'] . "][" . htmlspecialchars($coach) . "]' class='form-select form-select-sm text-center fw-bold' style='width: 52px; margin: 0 auto; background: #ffffff !important; color: #000000 !important; border: 1.5px solid #0284c7; padding: 2px 2px; font-size: 12px; font-weight: 700; height: 28px;'>";
                                                echo "<option value=''>-</option>";
                                                $matched = false;
                                                foreach ($optRatings as $r) {
                                                    $rv = (string)$r['rating_value'];
                                                    $isSelected = ($val !== '' && $val === $rv);
                                                    if ($isSelected) $matched = true;
                                                    echo "<option value='" . htmlspecialchars($rv) . "'" . ($isSelected ? " selected" : "") . ">" . htmlspecialchars($rv) . "</option>";
                                                }
                                                if ($val !== '' && !$matched) {
                                                    echo "<option value='" . htmlspecialchars($val) . "' selected>" . htmlspecialchars($val) . "</option>";
                                                }
                                                echo "</select>";
                                                echo "</td>";
                                            } else {
                                                echo "<td style='background: #f8fafc;'></td>";
                                            }
                                        } else {
                                            echo "<td>" . ($hasCoach ? htmlspecialchars($s) : "") . "</td>";
                                        }
                                    }
                                    ?>
                                </tr>
                            <?php endforeach; ?>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>

            <div class="report-info">
                <strong>Scoring Guidelines:</strong>
                <ul>
                    <li>
                        Maximum Marks will be 12 for internal cleaning. This will be counted as under: <?= $ratingText ?>
                    </li>
                    <li>
                        Maximum Marks will be 3 for exterior cleaning & washing. This will be counted as under:
                        <?= $ratingText ?>. % can be derived as per the marks
                        separately.
                    </li>
                </ul>
            </div>

            <div class="signature-row">
                <div class="signature-box">
                    <div class="signature-img-wrap">
                        <?php if (!empty($sheet['isApproved']) && !empty($cdoSignature) && file_exists(__DIR__ . '/uploads/signatures/' . $cdoSignature)): ?>
                            <img src="uploads/signatures/<?= htmlspecialchars($cdoSignature) ?>" alt="Contractor Sign">
                        <?php endif; ?>
                    </div>
                    <div class="signature-line">Contractor's Representative</div>
                </div>
                <div class="signature-box">
                    <div class="signature-img-wrap">
                        <?php if (!empty($sheet['auditor_signature']) && file_exists(__DIR__ . '/uploads/signatures/' . $sheet['auditor_signature'])): ?>
                            <img src="uploads/signatures/<?= htmlspecialchars($sheet['auditor_signature']) ?>" alt="Authorized Sign">
                        <?php endif; ?>
                    </div>
                    <div class="signature-line">Authorized Railway personnel</div>
                </div>
            </div>
        </div>

        <?php if ($isEditingThisSheet): ?>
        </form>
        <?php endif; ?>

        <?php /* =======================================================
        BACK SIDE: Penalty Matrix (Temporarily removed - kept for future restoration)
        =======================================================
        <div class="report-frame penalty-frame" id="back-<?= htmlspecialchars($sheet['token_id'] ?? '') ?>">
            <div class="report-header" style="display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #000; padding-bottom: 8px; margin-bottom: 12px;">
                <div style="font-size: 13px; font-weight: 700; color: #475569;">
                    <?php if (!$sheet['is_fallback'] && !empty($sheet['token_id'])): ?>
                        <span style="font-family: monospace; background: #e2e8f0; color: #334155; padding: 3px 8px; border-radius: 4px; border: 1px solid #cbd5e1;">Token: <?= htmlspecialchars($sheet['token_id']) ?></span>
                    <?php endif; ?>
                </div>
                <div class="no-print">
                    <span class="badge bg-secondary px-2 py-1" style="font-size: 11px;">Back Side</span>
                </div>
            </div>

            <div class="table-responsive">
                <table class="report-table penalty-table">
                    <thead>
                        <tr>
                            <th style="width: 38px;">Sr</th>
                            <th style="text-align: left !important; padding-left: 8px !important; min-width: 320px;">Item</th>
                            <?php for ($i = 1; $i <= count($sheet['coaches']); $i++): ?>
                                <th style="width: 32px; min-width: 30px;"><?= $i ?></th>
                            <?php endfor; ?>
                            <th style="width: 60px;">Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Coach No Row -->
                        <tr style="background: #fafafa; font-weight: 700;">
                            <td style="font-weight: 700;"></td>
                            <td style="text-align: left !important; padding-left: 8px !important; font-weight: 700;">Coach No</td>
                            <?php foreach ($sheet['coaches'] as $coach): ?>
                                <td style="font-weight: 700; font-size: 11px;"><?= htmlspecialchars($coach) ?></td>
                            <?php endforeach; ?>
                            <td></td>
                        </tr>

                        <!-- 13 Penalty Parameters Matching Image -->
                        <?php foreach ($penaltyItems as $pItem): ?>
                            <tr data-penalty-rate="<?= $pItem['rate'] ?>" data-penalty-type="<?= $pItem['type'] ?>">
                                <td style="font-weight: 700; vertical-align: top; padding-top: 6px;"><?= $pItem['sr'] ?></td>
                                <td style="text-align: left !important; padding: 5px 8px !important; font-size: 11.5px; line-height: 1.35; font-weight: 500;">
                                    <?= htmlspecialchars($pItem['item']) ?>
                                </td>

                                <?php 
                                foreach ($sheet['coaches'] as $cIdx => $coach): 
                                    $hasCoach = !empty($coach);
                                ?>
                                    <td style="padding: 2px !important;">
                                        <?php if ($hasCoach): ?>
                                            <span class="penalty-pill penalty-pill-no">No</span>
                                        <?php else: ?>
                                            <span style="color: #bbb;">-</span>
                                        <?php endif; ?>
                                    </td>
                                <?php endforeach; ?>

                                <td class="item-violation-count" style="font-weight: 700; font-size: 12px;">0</td>
                            </tr>
                        <?php endforeach; ?>

                        <!-- Total Penalty Summary Row -->
                        <tr style="background: #f8fafc; font-weight: 800; border-top: 2px solid #000;">
                            <td></td>
                            <td style="text-align: right !important; padding-right: 15px !important; font-size: 13px; font-weight: 800; text-transform: uppercase;">
                                Total Penalty
                            </td>
                            <?php for ($i = 1; $i <= count($sheet['coaches']); $i++): ?>
                                <td></td>
                            <?php endfor; ?>
                            <td class="sheet-total-penalty" style="font-size: 13px; color: #b91c1c; font-weight: 800; background: #fee2e2;">
                                Rs. 0
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Signatures & Notes exactly as shown in Image -->
            <div style="margin-top: 50px; padding: 0 20px;">
                <div style="margin-bottom: 35px; font-size: 13px; font-weight: 700; color: #000;">
                    SSE/C&W &nbsp;&nbsp;____________________________________ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ____________________________________
                </div>

                <div style="font-size: 12px; line-height: 1.6; color: #111; font-weight: 600;">
                    <div>Berth charges for OBHS staff</div>
                    <div>(As per the below table-1) Berth charges for OBHS staff</div>
                    <div>(As per the below table-1)</div>
                </div>
            </div>
        </div>
        ======================================================= */ ?>
    <?php endforeach; ?>
    </div>
  </div>
</div>
</main>

<script>
// Switch between Both Sides, Front Side Only, and Back Side Only
function setScorecardView(mode) {
    document.querySelectorAll('.btn-view-toggle').forEach(b => b.classList.remove('active'));
    if (mode === 'all') {
        document.querySelectorAll('.front-frame, .penalty-frame').forEach(f => f.style.display = '');
        document.getElementById('btn-toggle-all')?.classList.add('active');
    } else if (mode === 'front') {
        document.querySelectorAll('.front-frame').forEach(f => f.style.display = '');
        document.querySelectorAll('.penalty-frame').forEach(f => f.style.display = 'none');
        document.getElementById('btn-toggle-front')?.classList.add('active');
    } else if (mode === 'back') {
        document.querySelectorAll('.front-frame').forEach(f => f.style.display = 'none');
        document.querySelectorAll('.penalty-frame').forEach(f => f.style.display = '');
        document.getElementById('btn-toggle-back')?.classList.add('active');
    }
}
</script>

<?php include 'footer.php'; ?>
