<?php
/**
 * CDO Dashboard - Score & Penalty Utility Functions
 * Computes monthly average scores and penalty deductions for the Billing Invoice.
 */

if (!isset($pdo)) {
    require_once __DIR__ . '/../connection.php';
}

/**
 * Calculates Monthly Cleanliness Score
 */
function getCleanlinessScore($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);
    $daysInMonth = cal_days_in_month(CAL_GREGORIAN, intval($month), intval($year));
    $startDate = "$year-$month-01";
    $endDate = "$year-$month-$daysInMonth";

    try {
        $stmt = $pdo->prepare("
            SELECT score FROM mcc_cleanliness_report 
            WHERE station_id = :station_id AND report_date BETWEEN :start_date AND :end_date
        ");
        $stmt->execute([
            'station_id' => $stationId,
            'start_date' => $startDate,
            'end_date' => $endDate
        ]);
        $rows = $stmt->fetchAll(PDO::FETCH_COLUMN);

        if (empty($rows)) {
            return 0.0;
        }

        $total = 0.0;
        $count = 0;
        foreach ($rows as $score) {
            if ($score !== null) {
                $total += floatval($score);
                $count++;
            }
        }
        return $count > 0 ? round($total / $count, 2) : 0.0;
    } catch (Exception $e) {
        return 0.0;
    }
}

/**
 * Calculates Monthly Manpower (Attendance) Score and Penalties
 */
function getManpowerSummary($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);
    $daysInMonth = cal_days_in_month(CAL_GREGORIAN, intval($month), intval($year));
    $targetMonthDate = "$year-$month-01";

    try {
        // Fetch active categories
        $catStmt = $pdo->prepare("SELECT id FROM mcc_manpower_categories WHERE station_id = :station_id AND status = 'Active'");
        $catStmt->execute(['station_id' => $stationId]);
        $catList = $catStmt->fetchAll(PDO::FETCH_COLUMN);
        if (empty($catList)) return ['score' => 0.0, 'penalty' => 0.0];

        // Fetch active shifts & types mapped
        $shiftStmt = $pdo->prepare("SELECT id FROM mcc_manpower_shifts WHERE category_id = :category_id AND status = 'Active'");
        $typesStmt = $pdo->prepare("
            SELECT map.manpower_type_id
            FROM mcc_manpower_shift_type_map map
            JOIN mcc_manpower_types t ON map.manpower_type_id = t.id
            WHERE map.shift_id = :shift_id AND t.status = 'Active'
        ");

        $activeShiftTypes = [];
        foreach ($catList as $catId) {
            $shiftStmt->execute(['category_id' => $catId]);
            $sList = $shiftStmt->fetchAll(PDO::FETCH_COLUMN);
            foreach ($sList as $shId) {
                $typesStmt->execute(['shift_id' => $shId]);
                $tList = $typesStmt->fetchAll(PDO::FETCH_COLUMN);
                foreach ($tList as $tId) {
                    $activeShiftTypes[] = ['shift_id' => $shId, 'type_id' => $tId];
                }
            }
        }

        // Fetch target norms
        $targetsMap = [];
        $targetsStmt = $pdo->prepare("
            SELECT shift_id, manpower_type_id, target_qty FROM mcc_manpower_targets 
            WHERE station_id = :station_id AND target_date = :target_date
        ");
        $targetsStmt->execute(['station_id' => $stationId, 'target_date' => $targetMonthDate]);
        foreach ($targetsStmt->fetchAll() as $row) {
            $targetsMap[$row['shift_id']][$row['manpower_type_id']] = intval($row['target_qty']);
        }

        // Fetch effective penalties configs
        $existingPenalties = [];
        $penStmt = $pdo->prepare("
            SELECT p1.manpower_type_id, p1.absent_penalty, p1.dress_penalty, p1.gears_penalty 
            FROM mcc_manpower_penalties p1
            INNER JOIN (
                SELECT manpower_type_id, MAX(effective_month) AS max_month
                FROM mcc_manpower_penalties
                WHERE station_id = :station_id1 AND effective_month <= :selected_month
                GROUP BY manpower_type_id
            ) p2 ON p1.manpower_type_id = p2.manpower_type_id AND p1.effective_month = p2.max_month
            WHERE p1.station_id = :station_id2
        ");
        $penStmt->execute([
            'station_id1' => $stationId,
            'station_id2' => $stationId,
            'selected_month' => $targetMonthDate
        ]);
        foreach ($penStmt->fetchAll() as $row) {
            $existingPenalties[$row['manpower_type_id']] = [
                'absent' => $row['absent_penalty'],
                'dress' => $row['dress_penalty'],
                'gears' => $row['gears_penalty']
            ];
        }

        // Fetch all logs
        $logsMap = [];
        $logsStmt = $pdo->prepare("
            SELECT report_date, shift_id, manpower_type_id, provided_qty, absent_qty, no_dress_qty, no_ppe_qty
            FROM mcc_manpower_log
            WHERE station_id = :station_id AND YEAR(report_date) = :year AND MONTH(report_date) = :month
        ");
        $logsStmt->execute(['station_id' => $stationId, 'year' => $year, 'month' => intval($month)]);
        foreach ($logsStmt->fetchAll() as $row) {
            $logsMap[$row['report_date']][$row['shift_id']][$row['manpower_type_id']] = [
                'provided' => intval($row['provided_qty']),
                'absent' => intval($row['absent_qty']),
                'no_dress' => intval($row['no_dress_qty']),
                'no_ppe' => intval($row['no_ppe_qty'])
            ];
        }

        $sumDailyScores = 0.0;
        $totalMonthlyPenalty = 0.0;
        $daysWithLogs = 0;

        for ($d = 1; $d <= $daysInMonth; $d++) {
            $dayStr = str_pad($d, 2, '0', STR_PAD_LEFT);
            $dateStr = "$year-$month-$dayStr";

            if (!isset($logsMap[$dateStr])) continue;

            $daysWithLogs++;
            $dayToProvide = 0;
            $cappedAvailable = 0;
            $dayPenalty = 0.0;

            foreach ($activeShiftTypes as $ast) {
                $shId = $ast['shift_id'];
                $tId = $ast['type_id'];
                $norm = $targetsMap[$shId][$tId] ?? 0;
                $dayToProvide += $norm;

                if (isset($logsMap[$dateStr][$shId][$tId])) {
                    $prov = $logsMap[$dateStr][$shId][$tId]['provided'];
                    $abs = $logsMap[$dateStr][$shId][$tId]['absent'];
                    $noDress = $logsMap[$dateStr][$shId][$tId]['no_dress'];
                    $noPpe = $logsMap[$dateStr][$shId][$tId]['no_ppe'];

                    $avail = max(0, $prov - $abs);
                    $cappedAvailable += min($avail, $norm);

                    $rates = $existingPenalties[$tId] ?? ['absent' => 0.0, 'dress' => 0.0, 'gears' => 0.0];
                    $dayPenalty += ($abs * floatval($rates['absent'])) 
                                 + ($noDress * floatval($rates['dress'])) 
                                 + ($noPpe * floatval($rates['gears']));
                }
            }
            $dayScore = $dayToProvide > 0 ? ($cappedAvailable / $dayToProvide) * 100.0 : 100.0;
            $sumDailyScores += $dayScore;
            $totalMonthlyPenalty += $dayPenalty;
        }

        return [
            'score' => $daysWithLogs > 0 ? round($sumDailyScores / $daysWithLogs, 2) : 0.0,
            'penalty' => $totalMonthlyPenalty > 0 ? $totalMonthlyPenalty : 0.0
        ];
    } catch (Exception $e) {
        return ['score' => 0.0, 'penalty' => 0.0];
    }
}

/**
 * Calculates Monthly Chemical Score and Penalties
 */
function getChemicalSummary($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);

    try {
        $paramsStmt = $pdo->prepare("
            SELECT p.id AS parameter_id, t.`qty(ml)` AS qty_ml, t.penalty, t.`penalty_qty(ml)` AS penalty_qty_ml
            FROM mcc_normal_chemical_param p
            LEFT JOIN mcc_normal_chemical_target t ON p.id = t.parameter_id AND t.station_id = :station_id_target
            WHERE p.station_id = :station_id_param
        ");
        $paramsStmt->execute(['station_id_target' => $stationId, 'station_id_param' => $stationId]);
        $parameters = $paramsStmt->fetchAll();
        if (empty($parameters)) return ['score' => 0.0, 'penalty' => 0.0];
        $tokensStmt = $pdo->prepare("
            SELECT DISTINCT token_id, report_date 
            FROM mcc_normal_chemical_report 
            WHERE station_id = :station_id AND MONTH(report_date) = :month AND YEAR(report_date) = :year
        ");
        $tokensStmt->execute(['station_id' => $stationId, 'month' => intval($month), 'year' => $year]);
        $tokens = $tokensStmt->fetchAll();
        if (empty($tokens)) return ['score' => 0.0, 'penalty' => 0.0];

        $coachesStmt = $pdo->prepare("
            SELECT token_id, COUNT(DISTINCT coach_no) AS coaches_count
            FROM mcc_normal_chemical_report
            WHERE station_id = :station_id AND MONTH(report_date) = :month AND YEAR(report_date) = :year
            GROUP BY token_id
        ");
        $coachesStmt->execute(['station_id' => $stationId, 'month' => intval($month), 'year' => $year]);
        $tokenCoaches = [];
        while ($row = $coachesStmt->fetch()) {
            $cCount = intval($row['coaches_count']);
            if ($cCount === 0) {
                $cCount = 24;
            }
            $tokenCoaches[$row['token_id']] = $cCount;
        }

        // Fetch daily logs
        $logsStmt = $pdo->prepare("
            SELECT token_id, parameter_id, SUM(qty_used) as total_qty
            FROM mcc_normal_chemical_report
            WHERE station_id = :station_id AND MONTH(report_date) = :month AND YEAR(report_date) = :year
            GROUP BY token_id, parameter_id
        ");
        $logsStmt->execute(['station_id' => $stationId, 'month' => intval($month), 'year' => $year]);
        $logsRows = $logsStmt->fetchAll();

        $tokenParamQty = [];
        $monthlyParamConsumed = [];
        foreach ($logsRows as $row) {
            $tokenParamQty[$row['token_id']][$row['parameter_id']] = floatval($row['total_qty']);
            if (!isset($monthlyParamConsumed[$row['parameter_id']])) {
                $monthlyParamConsumed[$row['parameter_id']] = 0.0;
            }
            $monthlyParamConsumed[$row['parameter_id']] += floatval($row['total_qty']);
        }

        // Calculate Monthly Penalties
        $totalMonthlyPenalty = 0.0;
        foreach ($tokens as $t) {
            $tokenId = $t['token_id'];
            $coachesCount = $tokenCoaches[$tokenId] ?? 24;

            foreach ($parameters as $p) {
                $pId = $p['parameter_id'];
                $targetPerCoach = floatval($p['qty_ml'] ?? 0);
                $targetTotal = $targetPerCoach * $coachesCount;
                $consumedTotal = $tokenParamQty[$tokenId][$pId] ?? 0.0;

                if ($consumedTotal < $targetTotal) {
                    $deficit = $targetTotal - $consumedTotal;
                    $penaltyQty = floatval($p['penalty_qty_ml'] ?? 0);
                    if ($penaltyQty <= 0) {
                        $penaltyQty = $targetPerCoach;
                    }
                    $basePenalty = floatval($p['penalty'] ?? 0);
                    if ($penaltyQty > 0 && $basePenalty > 0) {
                        $totalMonthlyPenalty += ceil($deficit / $penaltyQty) * $basePenalty;
                    }
                }
            }
        }

        // Calculate Overall Monthly Score
        $totalMonthlyTarget = [];
        foreach ($parameters as $p) {
            $pId = $p['parameter_id'];
            $qtyMl = floatval($p['qty_ml'] ?? 0);
            $totalMonthlyTarget[$pId] = 0.0;
            foreach ($tokens as $t) {
                $coachesCount = $tokenCoaches[$t['token_id']] ?? 24;
                $totalMonthlyTarget[$pId] += $qtyMl * $coachesCount;
            }
        }
        $totalAchieved = 0.0;
        $paramWithTargetCount = 0;
        foreach ($parameters as $p) {
            $pId = $p['parameter_id'];
            $target = $totalMonthlyTarget[$pId] ?? 0.0;
            if ($target > 0) {
                $consumed = $monthlyParamConsumed[$pId] ?? 0.0;
                $pct = min(100.0, ($consumed / $target) * 100.0);
                $totalAchieved += $pct;
                $paramWithTargetCount++;
            }
        }

        return [
            'score' => $paramWithTargetCount > 0 ? round($totalAchieved / $paramWithTargetCount, 2) : 0.0,
            'penalty' => $totalMonthlyPenalty > 0 ? $totalMonthlyPenalty : 0.0
        ];
    } catch (Exception $e) {
        return ['score' => 0.0, 'penalty' => 0.0];
    }
}

/**
 * Calculates Monthly Machine Score and Penalties
 */
function getMachineSummary($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);
    $daysInMonth = cal_days_in_month(CAL_GREGORIAN, intval($month), intval($year));

    try {
        $machStmt = $pdo->prepare("SELECT id FROM mcc_normal_machine_param WHERE station_id = :station_id");
        $machStmt->execute(['station_id' => $stationId]);
        $machinesList = $machStmt->fetchAll(PDO::FETCH_COLUMN);

        $shiftStmt = $pdo->prepare("SELECT id FROM mcc_normal_machine_shifts WHERE station_id = :station_id");
        $shiftStmt->execute(['station_id' => $stationId]);
        $shiftsList = $shiftStmt->fetchAll(PDO::FETCH_COLUMN);

        if (empty($machinesList) || empty($shiftsList)) return ['score' => 0.0, 'penalty' => 0.0];

        // Fetch targets
        $targetsMap = [];
        $targetsStmt = $pdo->prepare("
            SELECT machine_id, shift_id, nominated_area, penalty_amount FROM mcc_normal_machine_target 
            WHERE station_id = :station_id AND target_month = :target_month
        ");
        $targetsStmt->execute(['station_id' => $stationId, 'target_month' => "$year-$month-01"]);
        foreach ($targetsStmt->fetchAll() as $row) {
            $targetsMap[$row['machine_id']][$row['shift_id']] = [
                'nominated_area' => $row['nominated_area'],
                'penalty_amount' => floatval($row['penalty_amount'] ?? 0.0)
            ];
        }

        // Fetch reports
        $reportsStmt = $pdo->prepare("
            SELECT report_date, parameter_id AS machine_id, shift_id, used_status FROM mcc_normal_machine_report 
            WHERE station_id = :station_id AND YEAR(report_date) = :year AND MONTH(report_date) = :month
        ");
        $reportsStmt->execute(['station_id' => $stationId, 'year' => $year, 'month' => intval($month)]);
        $reportsRows = $reportsStmt->fetchAll();

        $reportsMap = [];
        $daysWithReports = [];
        foreach ($reportsRows as $row) {
            $date = $row['report_date'];
            $reportsMap[$date][$row['machine_id']][$row['shift_id']] = $row['used_status'];
            $daysWithReports[$date] = true;
        }

        $sumDailyScores = 0.0;
        $totalMonthlyPenalty = 0.0;
        $daysLogged = 0;

        for ($d = 1; $d <= $daysInMonth; $d++) {
            $dayStr = str_pad($d, 2, '0', STR_PAD_LEFT);
            $dateStr = "$year-$month-$dayStr";

            if (!isset($daysWithReports[$dateStr])) continue;

            $daysLogged++;
            $dayNominated = 0;
            $dayOperated = 0;
            $dayPenalty = 0.0;

            foreach ($machinesList as $mId) {
                foreach ($shiftsList as $sId) {
                    $isNominated = ($targetsMap[$mId][$sId]['nominated_area'] ?? 'N') === 'Y';
                    if ($isNominated) {
                        $dayNominated++;
                        if (($reportsMap[$dateStr][$mId][$sId] ?? '-') === 'Y') {
                            $dayOperated++;
                        } else {
                            $dayPenalty += $targetsMap[$mId][$sId]['penalty_amount'] ?? 0.0;
                        }
                    }
                }
            }
            $dayScore = $dayNominated > 0 ? ($dayOperated / $dayNominated) * 100.0 : 100.0;
            $sumDailyScores += $dayScore;
            $totalMonthlyPenalty += $dayPenalty;
        }
        return [
            'score' => $daysLogged > 0 ? round($sumDailyScores / $daysLogged, 2) : 0.0,
            'penalty' => $totalMonthlyPenalty > 0 ? $totalMonthlyPenalty : 0.0
        ];
    } catch (Exception $e) {
        return ['score' => 0.0, 'penalty' => 0.0];
    }
}

/**
 * Calculates Monthly Consumables and Machinery combined Score
 */
function getConsumablesAndMachineryScore($stationId, $year, $month) {
    $chemSum = getChemicalSummary($stationId, $year, $month);
    $machSum = getMachineSummary($stationId, $year, $month);
    return round(($chemSum['score'] + $machSum['score']) / 2.0, 2);
}

/**
 * Calculates Monthly Surprise Visits average score
 */
function getSurpriseVisitsScore($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);
    $startDate = "$year-$month-01";
    $endDate = date('Y-m-t', strtotime($startDate));

    try {
        $pitMax = 30;
        $pfMax = 25;

        $stmt = $pdo->prepare("SELECT category, SUM(max_marks) as total FROM mcc_surprise_parameters WHERE station_id = :station_id AND status = 'Active' GROUP BY category");
        $stmt->execute(['station_id' => $stationId]);
        while ($row = $stmt->fetch()) {
            if ($row['category'] === 'pit_office') $pitMax = intval($row['total']);
            if ($row['category'] === 'pf_trains') $pfMax = intval($row['total']);
        }

        $reportsStmt = $pdo->prepare("
            SELECT token_id, category, SUM(value) as sheet_total, report_date
            FROM mcc_surprise_reports
            WHERE station_id = :station_id AND report_date BETWEEN :start_date AND :end_date
            GROUP BY token_id, category, report_date
        ");
        $reportsStmt->execute([
            'station_id' => $stationId,
            'start_date' => $startDate,
            'end_date' => $endDate
        ]);
        $sheets = $reportsStmt->fetchAll();

        if (empty($sheets)) {
            return 0.0;
        }

        $totalPct = 0.0;
        foreach ($sheets as $s) {
            $max = ($s['category'] === 'pf_trains') ? $pfMax : $pitMax;
            $pct = ($s['sheet_total'] / $max) * 100.0;
            $totalPct += min(100.0, max(0.0, $pct));
        }
        return round($totalPct / count($sheets), 2);
    } catch (Exception $e) {
        return 0.0;
    }
}

/**
 * Calculates Platform Return Trains Scorecard average score
 */
function getPRTScore($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);
    $startDate = "$year-$month-01";
    $endDate = date('Y-m-t', strtotime($startDate));

    try {
        $tokensStmt = $pdo->prepare("
            SELECT DISTINCT token_id, train_no, report_date 
            FROM mcc_prt_scorecard_report
            WHERE station_id = :station_id AND report_date BETWEEN :start_date AND :end_date
        ");
        $tokensStmt->execute([
            'station_id' => $stationId,
            'start_date' => $startDate,
            'end_date' => $endDate
        ]);
        $tokens = $tokensStmt->fetchAll();
        if (empty($tokens)) return 0.0;

        $paramsStmt = $pdo->prepare("
            SELECT sp.id, sp.parameter_id, p.name AS param_name
            FROM mcc_prt_scorecard_sub_param sp
            JOIN mcc_prt_scorecard_param p ON sp.parameter_id = p.id
            WHERE p.station_id = :station_id AND sp.status = 'Active'
        ");
        $paramsStmt->execute(['station_id' => $stationId]);
        $subParamsList = $paramsStmt->fetchAll();

        $dynamicParameters = [];
        foreach ($subParamsList as $sp) {
            $pId = $sp['parameter_id'];
            if (!isset($dynamicParameters[$pId])) {
                $dynamicParameters[$pId] = [
                    'name' => $sp['param_name'],
                    'sub_parameters' => []
                ];
            }
            $dynamicParameters[$pId]['sub_parameters'][] = [
                'id' => $sp['id']
            ];
        }

        $scoresStmt = $pdo->prepare("
            SELECT coach_no, sub_parameter_id, score_value 
            FROM mcc_prt_scorecard_report 
            WHERE station_id = :station_id AND token_id = :token_id
        ");

        $totalSheetsScore = 0.0;
        $sheetsCount = 0;

        foreach ($tokens as $t) {
            $tokenId = $t['token_id'];
            $scoresStmt->execute(['station_id' => $stationId, 'token_id' => $tokenId]);
            $rows = $scoresStmt->fetchAll();

            $scoresData = [];
            $coaches = [];
            foreach ($rows as $row) {
                $scoresData[$row['sub_parameter_id']][$row['coach_no']] = $row['score_value'];
                $coaches[$row['coach_no']] = true;
            }
            $coaches = array_keys($coaches);

            $parameterIds = array_keys($dynamicParameters);
            $internalParamId = $parameterIds[0] ?? 0;
            $externalParamId = $parameterIds[1] ?? 0;
            $wateringParamId = $parameterIds[2] ?? 0;

            // Internal Score
            $internalSum = 0; $internalCount = 0;
            if ($internalParamId && isset($dynamicParameters[$internalParamId])) {
                foreach ($coaches as $coach) {
                    foreach ($dynamicParameters[$internalParamId]['sub_parameters'] as $sp) {
                        $val = $scoresData[$sp['id']][$coach] ?? null;
                        if ($val !== null && is_numeric($val)) {
                            $internalSum += intval($val);
                            $internalCount++;
                        }
                    }
                }
            }
            $internalMax = $internalCount * 3;
            $internalPercentage = $internalMax > 0 ? ($internalSum / $internalMax) * 100.0 : 0.0;

            // External Score
            $externalSum = 0; $externalCount = 0;
            if ($externalParamId && isset($dynamicParameters[$externalParamId])) {
                foreach ($coaches as $coach) {
                    foreach ($dynamicParameters[$externalParamId]['sub_parameters'] as $sp) {
                        $val = $scoresData[$sp['id']][$coach] ?? null;
                        if ($val !== null && is_numeric($val)) {
                            $externalSum += intval($val);
                            $externalCount++;
                        }
                    }
                }
            }
            $externalMax = $externalCount * 3;
            $externalPercentage = $externalMax > 0 ? ($externalSum / $externalMax) * 100.0 : 0.0;

            // Watering Score
            $wateringYes = 0; $wateringCount = 0;
            if ($wateringParamId && isset($dynamicParameters[$wateringParamId])) {
                foreach ($coaches as $coach) {
                    foreach ($dynamicParameters[$wateringParamId]['sub_parameters'] as $sp) {
                        $val = $scoresData[$sp['id']][$coach] ?? null;
                        if ($val === 'Y') {
                            $wateringYes++; $wateringCount++;
                        } elseif ($val === 'N') {
                            $wateringCount++;
                        }
                    }
                }
            }
            $wateringPercentage = $wateringCount > 0 ? ($wateringYes / $wateringCount) * 100.0 : 0.0;

            $sheetAvg = ($internalPercentage + $externalPercentage + $wateringPercentage) / 3.0;
            $totalSheetsScore += $sheetAvg;
            $sheetsCount++;
        }
        return $sheetsCount > 0 ? round($totalSheetsScore / $sheetsCount, 2) : 0.0;
    } catch (Exception $e) {
        return 0.0;
    }
}

/**
 * Converts a decimal number to Indian Currency Words Format
 */
function numberToWords($number) {
    if ($number < 0) {
        return 'MINUS ' . numberToWords(abs($number));
    }
    $no = round($number);
    $decimal = round(($number - $no) * 100);
    $digits_length = strlen($no);
    $i = 0;
    $str = array();
    $words = array(
        0 => '', 1 => 'one', 2 => 'two',
        3 => 'three', 4 => 'four', 5 => 'five',
        6 => 'six', 7 => 'seven', 8 => 'eight',
        9 => 'nine', 10 => 'ten', 11 => 'eleven',
        12 => 'twelve', 13 => 'thirteen', 14 => 'fourteen',
        15 => 'fifteen', 16 => 'sixteen', 17 => 'seventeen',
        18 => 'eighteen', 19 => 'nineteen', 20 => 'twenty',
        30 => 'thirty', 40 => 'forty', 50 => 'fifty',
        60 => 'sixty', 70 => 'seventy', 80 => 'eighty',
        90 => 'ninety'
    );
    $digits = array('', 'hundred','thousand','lakh', 'crore');
    while ($i < $digits_length) {
        $divider = ($i == 2) ? 10 : 100;
        $number = floor($no % $divider);
        $no = floor($no / $divider);
        $i += $divider == 10 ? 1 : 2;
        if ($number) {
            $plural = (($counter = count($str)) && $number > 9) ? 's' : null;
            $hundred = ($counter == 1 && $str[0]) ? ' and ' : null;
            $str [] = ($number < 21) ? $words[$number] . ' ' . $digits[$counter] . $plural . $hundred : $words[floor($number / 10) * 10] . ' ' . $words[$number % 10] . ' ' . $digits[$counter] . $plural . $hundred;
        } else $str[] = null;
    }
    $Rupees = implode('', array_reverse($str));
    $paise = ($decimal > 0) ? " and " . ($words[floor($decimal / 10) * 10] . " " . $words[$decimal % 10]) . ' Paise' : '';
    return strtoupper(($Rupees ? $Rupees . 'Rupees ' : '') . $paise . ' Only');
}

/**
 * Calculates Monthly Normal Cleaning Scorecard Score
 */
function getNormalCleaningScore($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);
    $startDate = "$year-$month-01";
    $endDate = date('Y-m-t', strtotime($startDate));

    try {
        $paramsStmt = $pdo->prepare("
            SELECT p.id AS parameter_id, sp.id AS sub_parameter_id
            FROM mcc_normal_scorecard_param p
            JOIN mcc_normal_scorecard_sub_param sp ON p.id = sp.parameter_id
            WHERE p.station_id = :param_station_id AND sp.station_id = :sub_station_id AND p.status = 'Active' AND sp.status = 'Active'
        ");
        $paramsStmt->execute(['param_station_id' => $stationId, 'sub_station_id' => $stationId]);
        $paramsRows = $paramsStmt->fetchAll();

        $dynamicParameters = [];
        foreach ($paramsRows as $row) {
            $pId = $row['parameter_id'];
            if (!isset($dynamicParameters[$pId])) {
                $dynamicParameters[$pId] = [];
            }
            $dynamicParameters[$pId][] = $row['sub_parameter_id'];
        }

        $stmt = $pdo->prepare("
            SELECT DISTINCT token_id, report_date 
            FROM mcc_normal_scorecard_report 
            WHERE station_id = :station_id AND report_date BETWEEN :start_date AND :end_date
        ");
        $stmt->execute(['station_id' => $stationId, 'start_date' => $startDate, 'end_date' => $endDate]);
        $tokens = $stmt->fetchAll();

        if (empty($tokens)) {
            return 0.0;
        }

        $scoresStmt = $pdo->prepare("
            SELECT coach_no, sub_parameter_id, score_value 
            FROM mcc_normal_scorecard_report 
            WHERE station_id = :station_id AND token_id = :token_id
        ");

        $totalSheetsScore = 0.0;
        $sheetsCount = 0;

        foreach ($tokens as $t) {
            $tokenId = $t['token_id'];
            $scoresStmt->execute(['station_id' => $stationId, 'token_id' => $tokenId]);
            $rows = $scoresStmt->fetchAll();

            $scoresData = [];
            $coaches = [];
            foreach ($rows as $row) {
                $scoresData[$row['sub_parameter_id']][$row['coach_no']] = $row['score_value'];
                $coaches[$row['coach_no']] = true;
            }
            $coaches = array_keys($coaches);

            $parameterIds = array_keys($dynamicParameters);
            $internalParamId = $parameterIds[0] ?? 0;
            $externalParamId = $parameterIds[1] ?? 0;
            $wateringParamId = $parameterIds[2] ?? 0;

            // Internal Score
            $internalSum = 0; $internalCount = 0;
            if ($internalParamId && isset($dynamicParameters[$internalParamId])) {
                foreach ($coaches as $coach) {
                    if ($coach === '') continue;
                    foreach ($dynamicParameters[$internalParamId] as $spId) {
                        $val = $scoresData[$spId][$coach] ?? null;
                        if ($val !== null && is_numeric($val)) {
                            $internalSum += intval($val);
                            $internalCount++;
                        }
                    }
                }
            }
            $internalMax = $internalCount * 3;
            $internalPercentage = $internalMax > 0 ? ($internalSum / $internalMax) * 100.0 : 0.0;

            // External Score
            $externalSum = 0; $externalCount = 0;
            if ($externalParamId && isset($dynamicParameters[$externalParamId])) {
                foreach ($coaches as $coach) {
                    if ($coach === '') continue;
                    foreach ($dynamicParameters[$externalParamId] as $spId) {
                        $val = $scoresData[$spId][$coach] ?? null;
                        if ($val !== null && is_numeric($val)) {
                            $externalSum += intval($val);
                            $externalCount++;
                        }
                    }
                }
            }
            $externalMax = $externalCount * 3;
            $externalPercentage = $externalMax > 0 ? ($externalSum / $externalMax) * 100.0 : 0.0;

            // Watering Score
            $wateringYes = 0; $wateringCount = 0;
            if ($wateringParamId && isset($dynamicParameters[$wateringParamId])) {
                foreach ($coaches as $coach) {
                    if ($coach === '') continue;
                    foreach ($dynamicParameters[$wateringParamId] as $spId) {
                        $val = $scoresData[$spId][$coach] ?? null;
                        if ($val === 'Y') {
                            $wateringYes++; $wateringCount++;
                        } elseif ($val === 'N') {
                            $wateringCount++;
                        }
                    }
                }
            }
            $wateringPercentage = $wateringCount > 0 ? ($wateringYes / $wateringCount) * 100.0 : 0.0;

            $sheetAvg = ($internalPercentage + $externalPercentage + $wateringPercentage) / 3.0;
            $totalSheetsScore += $sheetAvg;
            $sheetsCount++;
        }

        return $sheetsCount > 0 ? round($totalSheetsScore / $sheetsCount, 2) : 0.0;
    } catch (Exception $e) {
        return 0.0;
    }
}

/**
 * Calculates Monthly Intensive Cleaning Scorecard Score
 */
function getIntensiveCleaningScore($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);
    $startDate = "$year-$month-01";
    $endDate = date('Y-m-t', strtotime($startDate));

    try {
        $paramsStmt = $pdo->prepare("
            SELECT p.id AS parameter_id, sp.id AS sub_parameter_id
            FROM mcc_intensive_scorecard_param p
            JOIN mcc_intensive_scorecard_sub_param sp ON p.id = sp.parameter_id
            WHERE p.station_id = :station_id AND sp.station_id = :station_id AND p.status = 'Active' AND sp.status = 'Active'
        ");
        $paramsStmt->execute(['station_id' => $stationId]);
        $paramsRows = $paramsStmt->fetchAll();

        $dynamicParameters = [];
        foreach ($paramsRows as $row) {
            $pId = $row['parameter_id'];
            if (!isset($dynamicParameters[$pId])) {
                $dynamicParameters[$pId] = [];
            }
            $dynamicParameters[$pId][] = $row['sub_parameter_id'];
        }

        $stmt = $pdo->prepare("
            SELECT DISTINCT token_id, report_date 
            FROM mcc_intensive_scorecard_report 
            WHERE station_id = :station_id AND report_date BETWEEN :start_date AND :end_date
        ");
        $stmt->execute(['station_id' => $stationId, 'start_date' => $startDate, 'end_date' => $endDate]);
        $tokens = $stmt->fetchAll();

        if (empty($tokens)) {
            return 0.0;
        }

        $scoresStmt = $pdo->prepare("
            SELECT coach_no, sub_parameter_id, score_value 
            FROM mcc_intensive_scorecard_report 
            WHERE station_id = :station_id AND token_id = :token_id
        ");

        $totalSheetsScore = 0.0;
        $sheetsCount = 0;

        foreach ($tokens as $t) {
            $tokenId = $t['token_id'];
            $scoresStmt->execute(['station_id' => $stationId, 'token_id' => $tokenId]);
            $rows = $scoresStmt->fetchAll();

            $scoresData = [];
            $coaches = [];
            foreach ($rows as $row) {
                $scoresData[$row['sub_parameter_id']][$row['coach_no']] = $row['score_value'];
                $coaches[$row['coach_no']] = true;
            }
            $coaches = array_keys($coaches);

            $parameterIds = array_keys($dynamicParameters);
            $internalParamId = $parameterIds[0] ?? 0;
            $externalParamId = $parameterIds[1] ?? 0;
            $wateringParamId = $parameterIds[2] ?? 0;

            // Internal Score
            $internalSum = 0; $internalCount = 0;
            if ($internalParamId && isset($dynamicParameters[$internalParamId])) {
                foreach ($coaches as $coach) {
                    if ($coach === '') continue;
                    foreach ($dynamicParameters[$internalParamId] as $spId) {
                        $val = $scoresData[$spId][$coach] ?? null;
                        if ($val !== null && is_numeric($val)) {
                            $internalSum += intval($val);
                            $internalCount++;
                        }
                    }
                }
            }
            $internalMax = $internalCount * 3;
            $internalPercentage = $internalMax > 0 ? ($internalSum / $internalMax) * 100.0 : 0.0;

            // External Score
            $externalSum = 0; $externalCount = 0;
            if ($externalParamId && isset($dynamicParameters[$externalParamId])) {
                foreach ($coaches as $coach) {
                    if ($coach === '') continue;
                    foreach ($dynamicParameters[$externalParamId] as $spId) {
                        $val = $scoresData[$spId][$coach] ?? null;
                        if ($val !== null && is_numeric($val)) {
                            $externalSum += intval($val);
                            $externalCount++;
                        }
                    }
                }
            }
            $externalMax = $externalCount * 3;
            $externalPercentage = $externalMax > 0 ? ($externalSum / $externalMax) * 100.0 : 0.0;

            // Watering Score
            $wateringYes = 0; $wateringCount = 0;
            if ($wateringParamId && isset($dynamicParameters[$wateringParamId])) {
                foreach ($coaches as $coach) {
                    if ($coach === '') continue;
                    foreach ($dynamicParameters[$wateringParamId] as $spId) {
                        $val = $scoresData[$spId][$coach] ?? null;
                        if ($val === 'Y') {
                            $wateringYes++; $wateringCount++;
                        } elseif ($val === 'N') {
                            $wateringCount++;
                        }
                    }
                }
            }
            $wateringPercentage = $wateringCount > 0 ? ($wateringYes / $wateringCount) * 100.0 : 0.0;

            $sheetAvg = ($internalPercentage + $externalPercentage + $wateringPercentage) / 3.0;
            $totalSheetsScore += $sheetAvg;
            $sheetsCount++;
        }

        return $sheetsCount > 0 ? round($totalSheetsScore / $sheetsCount, 2) : 0.0;
    } catch (Exception $e) {
        return 0.0;
    }
}

/**
 * Calculates Monthly Intensive Scorecard 2 Score (Annexure A-2)
 */
function getIntensiveCleaning2Score($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);
    $startDate = "$year-$month-01";
    $endDate = date('Y-m-t', strtotime($startDate));

    try {
        $stmt = $pdo->prepare("
            SELECT DISTINCT token_id 
            FROM mcc_intensive_scorecard_2_report 
            WHERE station_id = :station_id AND report_date BETWEEN :start_date AND :end_date
        ");
        $stmt->execute(['station_id' => $stationId, 'start_date' => $startDate, 'end_date' => $endDate]);
        $tokens = $stmt->fetchAll(PDO::FETCH_COLUMN);

        if (empty($tokens)) {
            return 0.0;
        }

        $scoresStmt = $pdo->prepare("
            SELECT score_value 
            FROM mcc_intensive_scorecard_2_report 
            WHERE station_id = :station_id AND token_id = :token_id
        ");

        $totalSheetsScore = 0.0;
        $sheetsCount = 0;

        foreach ($tokens as $tokenId) {
            $scoresStmt->execute(['station_id' => $stationId, 'token_id' => $tokenId]);
            $entries = $scoresStmt->fetchAll(PDO::FETCH_COLUMN);

            $obtained = 0;
            $possible = 0;
            foreach ($entries as $val) {
                if ($val !== '' && $val !== 'X' && $val !== '-') {
                    if (is_numeric($val)) {
                        $obtained += intval($val);
                    }
                    $possible++;
                }
            }

            if ($possible > 0) {
                $totalSheetsScore += ($obtained / $possible) * 100.0;
                $sheetsCount++;
            }
        }

        return $sheetsCount > 0 ? round($totalSheetsScore / $sheetsCount, 2) : 0.0;
    } catch (Exception $e) {
        return 0.0;
    }
}

/**
 * Calculates Monthly Intensive Pantry Scorecard Score
 */
function getIntensivePantryScore($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);
    $startDate = "$year-$month-01";
    $endDate = date('Y-m-t', strtotime($startDate));

    try {
        $stmt = $pdo->prepare("
            SELECT DISTINCT token_id 
            FROM mcc_intensive_pantry_report 
            WHERE station_id = :station_id AND report_date BETWEEN :start_date AND :end_date
        ");
        $stmt->execute(['station_id' => $stationId, 'start_date' => $startDate, 'end_date' => $endDate]);
        $tokens = $stmt->fetchAll(PDO::FETCH_COLUMN);

        if (empty($tokens)) {
            return 0.0;
        }

        $scoresStmt = $pdo->prepare("
            SELECT score_value 
            FROM mcc_intensive_pantry_report 
            WHERE station_id = :station_id AND token_id = :token_id
        ");

        $totalSheetsScore = 0.0;
        $sheetsCount = 0;

        foreach ($tokens as $tokenId) {
            $scoresStmt->execute(['station_id' => $stationId, 'token_id' => $tokenId]);
            $entries = $scoresStmt->fetchAll(PDO::FETCH_COLUMN);

            $obtained = 0;
            $possible = 0;
            foreach ($entries as $val) {
                if ($val !== '' && $val !== 'X' && $val !== '-') {
                    if (is_numeric($val)) {
                        $obtained += intval($val);
                    }
                    $possible++;
                }
            }

            if ($possible > 0) {
                $totalSheetsScore += ($obtained / $possible) * 100.0;
                $sheetsCount++;
            }
        }

        return $sheetsCount > 0 ? round($totalSheetsScore / $sheetsCount, 2) : 0.0;
    } catch (Exception $e) {
        return 0.0;
    }
}

/**
 * Calculates Monthly PLDC Cleaning Scorecard Score
 */
function getPLDCCleaningScore($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);
    $startDate = "$year-$month-01";
    $endDate = date('Y-m-t', strtotime($startDate));

    try {
        $paramsStmt = $pdo->prepare("SELECT id FROM dc_mcc_param WHERE station_id = :station_id");
        $paramsStmt->execute(['station_id' => $stationId]);
        $paramsList = $paramsStmt->fetchAll(PDO::FETCH_COLUMN);

        $shiftsStmt = $pdo->prepare("SELECT id FROM dc_mcc_shifts WHERE station_id = :station_id");
        $shiftsStmt->execute(['station_id' => $stationId]);
        $shiftsList = $shiftsStmt->fetchAll(PDO::FETCH_COLUMN);

        if (empty($paramsList) || empty($shiftsList)) {
            return 0.0;
        }

        $stmt = $pdo->prepare("
            SELECT DISTINCT token_id, report_date 
            FROM dc_mcc_report 
            WHERE station_id = :station_id AND report_date BETWEEN :start_date AND :end_date
        ");
        $stmt->execute(['station_id' => $stationId, 'start_date' => $startDate, 'end_date' => $endDate]);
        $tokens = $stmt->fetchAll();

        if (empty($tokens)) {
            return 0.0;
        }

        $reportStmt = $pdo->prepare("
            SELECT parameter_id, shift_id, rating 
            FROM dc_mcc_report 
            WHERE station_id = :station_id AND token_id = :token_id
        ");

        $totalSheetsScore = 0.0;
        $sheetsCount = 0;

        foreach ($tokens as $t) {
            $tokenId = $t['token_id'];
            $reportStmt->execute(['station_id' => $stationId, 'token_id' => $tokenId]);
            $reportRows = $reportStmt->fetchAll();

            $reportsMap = [];
            foreach ($reportRows as $row) {
                $reportsMap[$row['parameter_id']][$row['shift_id']] = $row['rating'];
            }

            $totalScoreSum = 0;
            $totalRatingCount = 0;
            foreach ($paramsList as $pId) {
                foreach ($shiftsList as $sId) {
                    if (isset($reportsMap[$pId][$sId]) && $reportsMap[$pId][$sId] !== null) {
                        $totalScoreSum += intval($reportsMap[$pId][$sId]);
                        $totalRatingCount++;
                    }
                }
            }
            $averageScore = $totalRatingCount > 0 ? ($totalScoreSum / ($totalRatingCount * 3)) * 100.0 : 0.0;
            $totalSheetsScore += $averageScore;
            $sheetsCount++;
        }

        return $sheetsCount > 0 ? round($totalSheetsScore / $sheetsCount, 2) : 0.0;
    } catch (Exception $e) {
        return 0.0;
    }
}

/**
 * Calculates Monthly Intensive Chemical Score & Penalties
 */
function getIntensiveChemicalSummary($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);

    try {
        $paramsStmt = $pdo->prepare("
            SELECT p.id AS parameter_id, t.`qty(ml)` AS qty_ml, t.penalty, t.`penalty_qty(ml)` AS penalty_qty_ml
            FROM mcc_intensive_chemical_param p
            LEFT JOIN mcc_intensive_chemical_target t ON p.id = t.parameter_id AND t.station_id = :station_id_target
            WHERE p.station_id = :station_id_param
        ");
        $paramsStmt->execute(['station_id_target' => $stationId, 'station_id_param' => $stationId]);
        $parameters = $paramsStmt->fetchAll();
        if (empty($parameters)) return ['score' => 0.0, 'penalty' => 0.0];

        $tokensStmt = $pdo->prepare("
            SELECT DISTINCT token_id, report_date 
            FROM mcc_intensive_chemical_report 
            WHERE YEAR(report_date) = :year AND MONTH(report_date) = :month AND station_id = :station_id
        ");
        $tokensStmt->execute(['year' => $year, 'month' => $month, 'station_id' => $stationId]);
        $tokens = $tokensStmt->fetchAll();
        if (empty($tokens)) return ['score' => 0.0, 'penalty' => 0.0];

        $coachesStmt = $pdo->prepare("
            SELECT token_id, COUNT(DISTINCT coach_no) AS coaches_count
            FROM mcc_intensive_chemical_report
            WHERE YEAR(report_date) = :year AND MONTH(report_date) = :month AND station_id = :station_id
            GROUP BY token_id
        ");
        $coachesStmt->execute(['year' => $year, 'month' => $month, 'station_id' => $stationId]);
        $tokenCoaches = $coachesStmt->fetchAll(PDO::FETCH_KEY_PAIR);

        $logsStmt = $pdo->prepare("
            SELECT token_id, parameter_id, SUM(qty_used) as total_qty
            FROM mcc_intensive_chemical_report
            WHERE station_id = :station_id AND MONTH(report_date) = :month AND YEAR(report_date) = :year
            GROUP BY token_id, parameter_id
        ");
        $logsStmt->execute(['station_id' => $stationId, 'month' => intval($month), 'year' => $year]);
        $logsRows = $logsStmt->fetchAll();

        $tokenParamQty = [];
        $monthlyParamConsumed = [];
        foreach ($logsRows as $row) {
            $tokenParamQty[$row['token_id']][$row['parameter_id']] = floatval($row['total_qty']);
            if (!isset($monthlyParamConsumed[$row['parameter_id']])) {
                $monthlyParamConsumed[$row['parameter_id']] = 0.0;
            }
            $monthlyParamConsumed[$row['parameter_id']] += floatval($row['total_qty']);
        }

        $totalMonthlyPenalty = 0.0;
        foreach ($tokens as $t) {
            $tokenId = $t['token_id'];
            $coachesCount = $tokenCoaches[$tokenId] ?? 24;
            if ($coachesCount <= 0) $coachesCount = 24;

            foreach ($parameters as $p) {
                $pId = $p['parameter_id'];
                $targetPerCoach = floatval($p['qty_ml'] ?? 0);
                $targetTotal = $targetPerCoach * $coachesCount;
                $consumedTotal = $tokenParamQty[$tokenId][$pId] ?? 0.0;

                if ($consumedTotal < $targetTotal) {
                    $deficit = $targetTotal - $consumedTotal;
                    $penaltyQty = floatval($p['penalty_qty_ml'] ?? 0);
                    if ($penaltyQty <= 0) {
                        $penaltyQty = $targetPerCoach;
                    }
                    $basePenalty = floatval($p['penalty'] ?? 0);
                    if ($penaltyQty > 0 && $basePenalty > 0) {
                        $totalMonthlyPenalty += ceil($deficit / $penaltyQty) * $basePenalty;
                    }
                }
            }
        }

        $totalMonthlyTarget = [];
        foreach ($parameters as $p) {
            $pId = $p['parameter_id'];
            $qtyMl = floatval($p['qty_ml'] ?? 0);
            $totalMonthlyTarget[$pId] = 0.0;
            foreach ($tokens as $t) {
                $coachesCount = $tokenCoaches[$t['token_id']] ?? 24;
                if ($coachesCount <= 0) $coachesCount = 24;
                $totalMonthlyTarget[$pId] += $qtyMl * $coachesCount;
            }
        }

        $totalAchieved = 0.0;
        $paramWithTargetCount = 0;
        foreach ($parameters as $p) {
            $pId = $p['parameter_id'];
            $target = $totalMonthlyTarget[$pId] ?? 0.0;
            if ($target > 0) {
                $consumed = floatval($monthlyParamConsumed[$pId] ?? 0.0);
                $pct = min(100.0, ($consumed / $target) * 100.0);
                $totalAchieved += $pct;
                $paramWithTargetCount++;
            }
        }

        return [
            'score' => $paramWithTargetCount > 0 ? round($totalAchieved / $paramWithTargetCount, 2) : 0.0,
            'penalty' => $totalMonthlyPenalty
        ];
    } catch (Exception $e) {
        return ['score' => 0.0, 'penalty' => 0.0];
    }
}

function getIntensiveChemicalScore($stationId, $year, $month) {
    $sum = getIntensiveChemicalSummary($stationId, $year, $month);
    return $sum['score'];
}

/**
 * Calculates Monthly PLDC Chemical Score & Penalties
 */
function getPLDCChemicalSummary($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);
    $targetMonthDate = "$year-$month-01";

    try {
        $paramsStmt = $pdo->prepare("
            SELECT p.id AS parameter_id, t.`qty(ml)` AS qty_ml, t.penalty, t.`penalty_qty(ml)` AS penalty_qty_ml
            FROM dc_mcc_chemical_param p
            LEFT JOIN dc_mcc_chemical_target t ON p.id = t.parameter_id AND t.station_id = :station_id_target AND t.target_month = :target_month
            WHERE p.station_id = :station_id_param
        ");
        $paramsStmt->execute([
            'station_id_target' => $stationId,
            'station_id_param' => $stationId,
            'target_month' => $targetMonthDate
        ]);
        $parameters = $paramsStmt->fetchAll();
        if (empty($parameters)) return ['score' => 0.0, 'penalty' => 0.0];

        $tokensStmt = $pdo->prepare("
            SELECT DISTINCT token_id, report_date 
            FROM dc_mcc_chemical_report 
            WHERE YEAR(report_date) = :year AND MONTH(report_date) = :month AND station_id = :station_id
        ");
        $tokensStmt->execute(['year' => $year, 'month' => $month, 'station_id' => $stationId]);
        $tokens = $tokensStmt->fetchAll();
        if (empty($tokens)) return ['score' => 0.0, 'penalty' => 0.0];

        $logsStmt = $pdo->prepare("
            SELECT token_id, parameter_id, SUM(qty_used) as total_qty
            FROM dc_mcc_chemical_report
            WHERE station_id = :station_id AND MONTH(report_date) = :month AND YEAR(report_date) = :year
            GROUP BY token_id, parameter_id
        ");
        $logsStmt->execute(['station_id' => $stationId, 'month' => intval($month), 'year' => $year]);
        $logsRows = $logsStmt->fetchAll();

        $tokenParamQty = [];
        $monthlyParamConsumed = [];
        foreach ($logsRows as $row) {
            $tokenParamQty[$row['token_id']][$row['parameter_id']] = floatval($row['total_qty']);
            if (!isset($monthlyParamConsumed[$row['parameter_id']])) {
                $monthlyParamConsumed[$row['parameter_id']] = 0.0;
            }
            $monthlyParamConsumed[$row['parameter_id']] += floatval($row['total_qty']);
        }

        $totalMonthlyTarget = [];
        foreach ($parameters as $p) {
            $pId = $p['parameter_id'];
            $qtyMl = floatval($p['qty_ml'] ?? 0);
            $dailyTarget = $qtyMl / 30.0;
            $totalMonthlyTarget[$pId] = $dailyTarget * count($tokens);
        }

        $totalMonthlyPenalty = 0.0;
        foreach ($tokens as $t) {
            $tokenId = $t['token_id'];
            foreach ($parameters as $p) {
                $pId = $p['parameter_id'];
                $target = $totalMonthlyTarget[$pId] / count($tokens); // daily target
                $consumedTotal = $tokenParamQty[$tokenId][$pId] ?? 0.0;

                if ($consumedTotal < $target) {
                    $deficit = $target - $consumedTotal;
                    $penaltyQty = floatval($p['penalty_qty_ml'] ?? 0);
                    if ($penaltyQty <= 0) {
                        $penaltyQty = $target;
                    }
                    $basePenalty = floatval($p['penalty'] ?? 0);
                    if ($penaltyQty > 0 && $basePenalty > 0) {
                        $totalMonthlyPenalty += ceil($deficit / $penaltyQty) * $basePenalty;
                    }
                }
            }
        }

        $totalAchieved = 0.0;
        $paramWithTargetCount = 0;
        foreach ($parameters as $p) {
            $pId = $p['parameter_id'];
            $target = $totalMonthlyTarget[$pId] ?? 0.0;
            if ($target > 0) {
                $consumed = floatval($monthlyParamConsumed[$pId] ?? 0.0);
                $pct = min(100.0, ($consumed / $target) * 100.0);
                $totalAchieved += $pct;
                $paramWithTargetCount++;
            }
        }

        return [
            'score' => $paramWithTargetCount > 0 ? round($totalAchieved / $paramWithTargetCount, 2) : 0.0,
            'penalty' => $totalMonthlyPenalty
        ];
    } catch (Exception $e) {
        return ['score' => 0.0, 'penalty' => 0.0];
    }
}

function getPLDCChemicalScore($stationId, $year, $month) {
    $sum = getPLDCChemicalSummary($stationId, $year, $month);
    return $sum['score'];
}

/**
 * Calculates Monthly Platform Return Trains Chemical Score & Penalties
 */
function getPRTChemicalSummary($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);
    $targetMonthDate = "$year-$month-01";

    try {
        $paramsStmt = $pdo->prepare("
            SELECT p.id AS parameter_id, t.`qty(ml)` AS qty_ml, t.penalty, t.`penalty_qty(ml)` AS penalty_qty_ml
            FROM mcc_prt_chemical_param p
            LEFT JOIN mcc_prt_chemical_target t ON p.id = t.parameter_id AND t.station_id = :station_id_target AND t.target_month = :target_month
            WHERE p.station_id = :station_id_param
        ");
        $paramsStmt->execute([
            'station_id_target' => $stationId,
            'station_id_param' => $stationId,
            'target_month' => $targetMonthDate
        ]);
        $parameters = $paramsStmt->fetchAll();
        if (empty($parameters)) return ['score' => 0.0, 'penalty' => 0.0];

        $tokensStmt = $pdo->prepare("
            SELECT DISTINCT token_id, report_date 
            FROM mcc_prt_chemical_report 
            WHERE YEAR(report_date) = :year AND MONTH(report_date) = :month AND station_id = :station_id
        ");
        $tokensStmt->execute(['year' => $year, 'month' => $month, 'station_id' => $stationId]);
        $tokens = $tokensStmt->fetchAll();
        if (empty($tokens)) return ['score' => 0.0, 'penalty' => 0.0];

        $logsStmt = $pdo->prepare("
            SELECT token_id, parameter_id, SUM(qty_used) as total_qty
            FROM mcc_prt_chemical_report
            WHERE station_id = :station_id AND MONTH(report_date) = :month AND YEAR(report_date) = :year
            GROUP BY token_id, parameter_id
        ");
        $logsStmt->execute(['station_id' => $stationId, 'month' => intval($month), 'year' => $year]);
        $logsRows = $logsStmt->fetchAll();

        $tokenParamQty = [];
        $monthlyParamConsumed = [];
        foreach ($logsRows as $row) {
            $tokenParamQty[$row['token_id']][$row['parameter_id']] = floatval($row['total_qty']);
            if (!isset($monthlyParamConsumed[$row['parameter_id']])) {
                $monthlyParamConsumed[$row['parameter_id']] = 0.0;
            }
            $monthlyParamConsumed[$row['parameter_id']] += floatval($row['total_qty']);
        }

        $totalMonthlyTarget = [];
        foreach ($parameters as $p) {
            $pId = $p['parameter_id'];
            $qtyMl = floatval($p['qty_ml'] ?? 0);
            $dailyTarget = $qtyMl / 30.0;
            $totalMonthlyTarget[$pId] = $dailyTarget * count($tokens);
        }

        $totalMonthlyPenalty = 0.0;
        foreach ($tokens as $t) {
            $tokenId = $t['token_id'];
            foreach ($parameters as $p) {
                $pId = $p['parameter_id'];
                $target = $totalMonthlyTarget[$pId] / count($tokens); // daily target
                $consumedTotal = $tokenParamQty[$tokenId][$pId] ?? 0.0;

                if ($consumedTotal < $target) {
                    $deficit = $target - $consumedTotal;
                    $penaltyQty = floatval($p['penalty_qty_ml'] ?? 0);
                    if ($penaltyQty <= 0) {
                        $penaltyQty = $target;
                    }
                    $basePenalty = floatval($p['penalty'] ?? 0);
                    if ($penaltyQty > 0 && $basePenalty > 0) {
                        $totalMonthlyPenalty += ceil($deficit / $penaltyQty) * $basePenalty;
                    }
                }
            }
        }

        $totalAchieved = 0.0;
        $paramWithTargetCount = 0;
        foreach ($parameters as $p) {
            $pId = $p['parameter_id'];
            $target = $totalMonthlyTarget[$pId] ?? 0.0;
            if ($target > 0) {
                $consumed = floatval($monthlyParamConsumed[$pId] ?? 0.0);
                $pct = min(100.0, ($consumed / $target) * 100.0);
                $totalAchieved += $pct;
                $paramWithTargetCount++;
            }
        }

        return [
            'score' => $paramWithTargetCount > 0 ? round($totalAchieved / $paramWithTargetCount, 2) : 0.0,
            'penalty' => $totalMonthlyPenalty
        ];
    } catch (Exception $e) {
        return ['score' => 0.0, 'penalty' => 0.0];
    }
}

function getPRTChemicalScore($stationId, $year, $month) {
    $sum = getPRTChemicalSummary($stationId, $year, $month);
    return $sum['score'];
}

/**
 * Calculates Monthly Intensive Machine Score & Penalties
 */
function getIntensiveMachineSummary($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);
    $daysInMonth = cal_days_in_month(CAL_GREGORIAN, intval($month), intval($year));

    try {
        $machStmt = $pdo->prepare("SELECT id FROM mcc_intensive_machine_param WHERE station_id = :station_id");
        $machStmt->execute(['station_id' => $stationId]);
        $machinesList = $machStmt->fetchAll(PDO::FETCH_COLUMN);

        $shiftStmt = $pdo->prepare("SELECT id FROM mcc_intensive_machine_shifts WHERE station_id = :station_id");
        $shiftStmt->execute(['station_id' => $stationId]);
        $shiftsList = $shiftStmt->fetchAll(PDO::FETCH_COLUMN);

        if (empty($machinesList) || empty($shiftsList)) return ['score' => 0.0, 'penalty' => 0.0];

        // Fetch targets
        $targetsMap = [];
        $targetsStmt = $pdo->prepare("
            SELECT machine_id, shift_id, nominated_area, penalty_amount FROM mcc_intensive_machine_target 
            WHERE station_id = :station_id AND target_month = :target_month
        ");
        $targetsStmt->execute(['station_id' => $stationId, 'target_month' => "$year-$month-01"]);
        foreach ($targetsStmt->fetchAll() as $row) {
            $targetsMap[$row['machine_id']][$row['shift_id']] = [
                'nominated_area' => $row['nominated_area'],
                'penalty_amount' => floatval($row['penalty_amount'] ?? 0.0)
            ];
        }

        // Fetch reports
        $reportsStmt = $pdo->prepare("
            SELECT report_date, parameter_id AS machine_id, shift_id, used_status FROM mcc_intensive_machine_report 
            WHERE station_id = :station_id AND YEAR(report_date) = :year AND MONTH(report_date) = :month
        ");
        $reportsStmt->execute(['station_id' => $stationId, 'year' => $year, 'month' => intval($month)]);
        $reportsRows = $reportsStmt->fetchAll();

        $reportsMap = [];
        $daysWithReports = [];
        foreach ($reportsRows as $row) {
            $date = $row['report_date'];
            $reportsMap[$date][$row['machine_id']][$row['shift_id']] = $row['used_status'];
            $daysWithReports[$date] = true;
        }

        $sumDailyScores = 0.0;
        $totalMonthlyPenalty = 0.0;
        $daysLogged = 0;

        for ($d = 1; $d <= $daysInMonth; $d++) {
            $dayStr = str_pad($d, 2, '0', STR_PAD_LEFT);
            $dateStr = "$year-$month-$dayStr";

            if (!isset($daysWithReports[$dateStr])) continue;

            $daysLogged++;
            $dayNominated = 0;
            $dayOperated = 0;
            $dayPenalty = 0.0;

            foreach ($machinesList as $mId) {
                foreach ($shiftsList as $sId) {
                    $isNominated = ($targetsMap[$mId][$sId]['nominated_area'] ?? 'N') === 'Y';
                    if ($isNominated) {
                        $dayNominated++;
                        if (($reportsMap[$dateStr][$mId][$sId] ?? '-') === 'Y') {
                            $dayOperated++;
                        } else {
                            $dayPenalty += floatval($targetsMap[$mId][$sId]['penalty_amount'] ?? 0.0);
                        }
                    }
                }
            }
            $dayScore = $dayNominated > 0 ? ($dayOperated / $dayNominated) * 100.0 : 100.0;
            $sumDailyScores += $dayScore;
            $totalMonthlyPenalty += $dayPenalty;
        }
        return [
            'score' => $daysLogged > 0 ? round($sumDailyScores / $daysLogged, 2) : 0.0,
            'penalty' => $totalMonthlyPenalty
        ];
    } catch (Exception $e) {
        return ['score' => 0.0, 'penalty' => 0.0];
    }
}

function getIntensiveMachineScore($stationId, $year, $month) {
    $sum = getIntensiveMachineSummary($stationId, $year, $month);
    return $sum['score'];
}

/**
 * Calculates Monthly PLDC Machine Score & Penalties
 */
function getPLDCMachineSummary($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);
    $daysInMonth = cal_days_in_month(CAL_GREGORIAN, intval($month), intval($year));

    try {
        $machStmt = $pdo->prepare("SELECT id FROM dc_mcc_machine_param WHERE station_id = :station_id");
        $machStmt->execute(['station_id' => $stationId]);
        $machinesList = $machStmt->fetchAll(PDO::FETCH_COLUMN);

        $shiftStmt = $pdo->prepare("SELECT id FROM dc_mcc_machine_shifts WHERE station_id = :station_id");
        $shiftStmt->execute(['station_id' => $stationId]);
        $shiftsList = $shiftStmt->fetchAll(PDO::FETCH_COLUMN);

        if (empty($machinesList) || empty($shiftsList)) return ['score' => 0.0, 'penalty' => 0.0];

        // Fetch targets
        $targetsMap = [];
        $targetsStmt = $pdo->prepare("
            SELECT machine_id, shift_id, nominated_area, penalty_amount FROM dc_mcc_machine_target 
            WHERE station_id = :station_id AND target_month = :target_month
        ");
        $targetsStmt->execute(['station_id' => $stationId, 'target_month' => "$year-$month-01"]);
        foreach ($targetsStmt->fetchAll() as $row) {
            $targetsMap[$row['machine_id']][$row['shift_id']] = [
                'nominated_area' => $row['nominated_area'],
                'penalty_amount' => floatval($row['penalty_amount'] ?? 0.0)
            ];
        }

        // Fetch reports
        $reportsStmt = $pdo->prepare("
            SELECT report_date, parameter_id AS machine_id, shift_id, used_status FROM dc_mcc_machine_report 
            WHERE station_id = :station_id AND YEAR(report_date) = :year AND MONTH(report_date) = :month
        ");
        $reportsStmt->execute(['station_id' => $stationId, 'year' => $year, 'month' => intval($month)]);
        $reportsRows = $reportsStmt->fetchAll();

        $reportsMap = [];
        $daysWithReports = [];
        foreach ($reportsRows as $row) {
            $date = $row['report_date'];
            $reportsMap[$date][$row['machine_id']][$row['shift_id']] = $row['used_status'];
            $daysWithReports[$date] = true;
        }

        $sumDailyScores = 0.0;
        $totalMonthlyPenalty = 0.0;
        $daysLogged = 0;

        for ($d = 1; $d <= $daysInMonth; $d++) {
            $dayStr = str_pad($d, 2, '0', STR_PAD_LEFT);
            $dateStr = "$year-$month-$dayStr";

            $hasReport = isset($daysWithReports[$dateStr]);
            if ($hasReport) {
                $daysLogged++;
            } else {
                continue;
            }

            $dayNominated = 0;
            $dayOperated = 0;
            $dayPenalty = 0.0;

            foreach ($machinesList as $mId) {
                foreach ($shiftsList as $sId) {
                    $nomArea = $targetsMap[$mId][$sId]['nominated_area'] ?? '';
                    $isNominated = !empty($nomArea) && strtoupper($nomArea) !== 'N' && $nomArea !== '-';
                    if ($isNominated) {
                        $dayNominated++;
                        $status = $reportsMap[$dateStr][$mId][$sId] ?? '-';
                        if ($status === 'Y') {
                            $dayOperated++;
                        } else {
                            $dayPenalty += floatval($targetsMap[$mId][$sId]['penalty_amount'] ?? 0.0);
                        }
                    }
                }
            }
            $dayScore = $dayNominated > 0 ? ($dayOperated / $dayNominated) * 100.0 : 100.0;
            $sumDailyScores += $dayScore;
            $totalMonthlyPenalty += $dayPenalty;
        }
        return [
            'score' => $daysLogged > 0 ? round($sumDailyScores / $daysLogged, 2) : 0.0,
            'penalty' => $totalMonthlyPenalty
        ];
    } catch (Exception $e) {
        return ['score' => 0.0, 'penalty' => 0.0];
    }
}

function getPLDCMachineScore($stationId, $year, $month) {
    $sum = getPLDCMachineSummary($stationId, $year, $month);
    return $sum['score'];
}

/**
 * Calculates Monthly Surprise Pit/Office Score
 */
function getSurprisePitOfficeScore($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);
    $startDate = "$year-$month-01";
    $endDate = date('Y-m-t', strtotime($startDate));

    try {
        $paramsStmt = $pdo->prepare("
            SELECT SUM(max_marks) as max_marks_total 
            FROM mcc_surprise_parameters 
            WHERE category = 'pit_office' AND station_id = :station_id AND status = 'Active'
        ");
        $paramsStmt->execute(['station_id' => $stationId]);
        $maxMarksRow = $paramsStmt->fetch();
        $maxMarksTotal = intval($maxMarksRow['max_marks_total'] ?? 30);
        if ($maxMarksTotal <= 0) $maxMarksTotal = 30;

        $reportsStmt = $pdo->prepare("
            SELECT token_id, report_date, SUM(value) as sheet_total
            FROM mcc_surprise_reports
            WHERE station_id = :station_id AND category = 'pit_office' AND report_date BETWEEN :start_date AND :end_date
            GROUP BY token_id, report_date
        ");
        $reportsStmt->execute([
            'station_id' => $stationId,
            'start_date' => $startDate,
            'end_date' => $endDate
        ]);
        $sheets = $reportsStmt->fetchAll();

        if (empty($sheets)) {
            return 0.0;
        }

        $totalPct = 0.0;
        foreach ($sheets as $s) {
            $pct = ($s['sheet_total'] / $maxMarksTotal) * 100.0;
            $totalPct += min(100.0, max(0.0, $pct));
        }
        return round($totalPct / count($sheets), 2);
    } catch (Exception $e) {
        return 0.0;
    }
}

/**
 * Calculates Monthly Surprise PF/Trains Score
 */
function getSurprisePFTrainsScore($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);
    $startDate = "$year-$month-01";
    $endDate = date('Y-m-t', strtotime($startDate));

    try {
        $paramsStmt = $pdo->prepare("
            SELECT SUM(max_marks) as max_marks_total 
            FROM mcc_surprise_parameters 
            WHERE category = 'pf_trains' AND station_id = :station_id AND status = 'Active'
        ");
        $paramsStmt->execute(['station_id' => $stationId]);
        $maxMarksRow = $paramsStmt->fetch();
        $maxMarksTotal = intval($maxMarksRow['max_marks_total'] ?? 25);
        if ($maxMarksTotal <= 0) $maxMarksTotal = 25;

        $reportsStmt = $pdo->prepare("
            SELECT token_id, report_date, SUM(value) as sheet_total
            FROM mcc_surprise_reports
            WHERE station_id = :station_id AND category = 'pf_trains' AND report_date BETWEEN :start_date AND :end_date
            GROUP BY token_id, report_date
        ");
        $reportsStmt->execute([
            'station_id' => $stationId,
            'start_date' => $startDate,
            'end_date' => $endDate
        ]);
        $sheets = $reportsStmt->fetchAll();

        if (empty($sheets)) {
            return 0.0;
        }

        $totalPct = 0.0;
        foreach ($sheets as $s) {
            $pct = ($s['sheet_total'] / $maxMarksTotal) * 100.0;
            $totalPct += min(100.0, max(0.0, $pct));
        }
        return round($totalPct / count($sheets), 2);
    } catch (Exception $e) {
        return 0.0;
    }
}

/**
 * Calculates Monthly Vande Bharat Audit Score
 */
function getVandeBharatAuditScore($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);
    $startDate = "$year-$month-01";
    $endDate = date('Y-m-t', strtotime($startDate));

    try {
        $paramsStmt = $pdo->prepare("
            SELECT p.id AS parameter_id, sp.id AS sub_parameter_id
            FROM mcc_vb_scorecard_param p
            JOIN mcc_vb_scorecard_sub_param sp ON p.id = sp.parameter_id
            WHERE p.station_id = :param_station_id AND sp.station_id = :sub_station_id AND p.status = 'Active' AND sp.status = 'Active'
            ORDER BY p.id ASC, sp.id ASC
        ");
        $paramsStmt->execute(['param_station_id' => $stationId, 'sub_station_id' => $stationId]);
        $paramsRows = $paramsStmt->fetchAll();

        $dynamicParameters = [];
        foreach ($paramsRows as $row) {
            $pId = $row['parameter_id'];
            if (!isset($dynamicParameters[$pId])) {
                $dynamicParameters[$pId] = [];
            }
            $dynamicParameters[$pId][] = $row['sub_parameter_id'];
        }

        $stmt = $pdo->prepare("
            SELECT DISTINCT token_id, report_date 
            FROM mcc_vb_scorecard_report 
            WHERE station_id = :station_id AND report_date BETWEEN :start_date AND :end_date
        ");
        $stmt->execute(['station_id' => $stationId, 'start_date' => $startDate, 'end_date' => $endDate]);
        $tokens = $stmt->fetchAll();

        if (empty($tokens)) {
            return 0.0;
        }

        $scoresStmt = $pdo->prepare("
            SELECT coach_no, sub_parameter_id, score_value 
            FROM mcc_vb_scorecard_report 
            WHERE station_id = :station_id AND token_id = :token_id
        ");

        $totalSheetsScore = 0.0;
        $sheetsCount = 0;

        foreach ($tokens as $t) {
            $tokenId = $t['token_id'];
            $scoresStmt->execute(['station_id' => $stationId, 'token_id' => $tokenId]);
            $rows = $scoresStmt->fetchAll();

            $scoresData = [];
            $coaches = [];
            foreach ($rows as $row) {
                $scoresData[$row['sub_parameter_id']][$row['coach_no']] = $row['score_value'];
                $coaches[$row['coach_no']] = true;
            }
            $coaches = array_keys($coaches);

            $parameterIds = array_keys($dynamicParameters);
            $internalParamId = $parameterIds[0] ?? 0;
            $externalParamId = $parameterIds[1] ?? 0;
            $wateringParamId = $parameterIds[2] ?? 0;

            // Internal Score
            $internalSum = 0; $internalCount = 0;
            if ($internalParamId && isset($dynamicParameters[$internalParamId])) {
                foreach ($coaches as $coach) {
                    if ($coach === '') continue;
                    foreach ($dynamicParameters[$internalParamId] as $spId) {
                        $val = $scoresData[$spId][$coach] ?? null;
                        if ($val !== null && is_numeric($val)) {
                            $internalSum += intval($val);
                            $internalCount++;
                        }
                    }
                }
            }
            $internalMax = $internalCount * 3;
            $internalPercentage = $internalMax > 0 ? ($internalSum / $internalMax) * 100.0 : 0.0;

            // External Score
            $externalSum = 0; $externalCount = 0;
            if ($externalParamId && isset($dynamicParameters[$externalParamId])) {
                foreach ($coaches as $coach) {
                    if ($coach === '') continue;
                    foreach ($dynamicParameters[$externalParamId] as $spId) {
                        $val = $scoresData[$spId][$coach] ?? null;
                        if ($val !== null && is_numeric($val)) {
                            $externalSum += intval($val);
                            $externalCount++;
                        }
                    }
                }
            }
            $externalMax = $externalCount * 3;
            $externalPercentage = $externalMax > 0 ? ($externalSum / $externalMax) * 100.0 : 0.0;

            // Watering Score
            $wateringYes = 0; $wateringCount = 0;
            if ($wateringParamId && isset($dynamicParameters[$wateringParamId])) {
                foreach ($coaches as $coach) {
                    if ($coach === '') continue;
                    foreach ($dynamicParameters[$wateringParamId] as $spId) {
                        $val = $scoresData[$spId][$coach] ?? null;
                        if ($val === 'Y') {
                            $wateringYes++; $wateringCount++;
                        } elseif ($val === 'N') {
                            $wateringCount++;
                        }
                    }
                }
            }
            $wateringPercentage = $wateringCount > 0 ? ($wateringYes / $wateringCount) * 100.0 : 0.0;

            $sheetAvg = ($internalPercentage + $externalPercentage + $wateringPercentage) / 3.0;
            $totalSheetsScore += $sheetAvg;
            $sheetsCount++;
        }

        return $sheetsCount > 0 ? round($totalSheetsScore / $sheetsCount, 2) : 0.0;
    } catch (Exception $e) {
        return 0.0;
    }
}

/**
 * Calculates Monthly Vande Bharat Chemical Score
 */
function getVandeBharatChemicalScore($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);

    try {
        // Fetch chemical parameters and target values
        $paramsStmt = $pdo->prepare("
            SELECT p.id AS parameter_id, t.`qty(ml)` AS qty_ml
            FROM mcc_vb_chemical_param p
            LEFT JOIN mcc_vb_chemical_target t ON p.id = t.parameter_id AND t.station_id = :stn_id_target
            WHERE p.station_id = :stn_id_param
            ORDER BY p.id ASC
        ");
        $paramsStmt->execute(['stn_id_target' => $stationId, 'stn_id_param' => $stationId]);
        $parametersList = $paramsStmt->fetchAll();

        // Fetch tokens in the selected month
        $tokensStmt = $pdo->prepare("
            SELECT DISTINCT token_id 
            FROM mcc_vb_chemical_report 
            WHERE YEAR(report_date) = :year AND MONTH(report_date) = :month AND station_id = :station_id
        ");
        $tokensStmt->execute(['year' => $year, 'month' => $month, 'station_id' => $stationId]);
        $tokensList = $tokensStmt->fetchAll(PDO::FETCH_COLUMN);

        if (empty($tokensList)) {
            return 0.0;
        }

        // Get count of distinct coaches per token
        $coachesStmt = $pdo->prepare("
            SELECT token_id, COUNT(DISTINCT coach_no) AS coaches_count
            FROM mcc_vb_chemical_report
            WHERE YEAR(report_date) = :year AND MONTH(report_date) = :month AND station_id = :station_id
            GROUP BY token_id
        ");
        $coachesStmt->execute(['year' => $year, 'month' => $month, 'station_id' => $stationId]);
        $tokenCoaches = [];
        while ($row = $coachesStmt->fetch()) {
            $cCount = intval($row['coaches_count']);
            $tokenCoaches[$row['token_id']] = ($cCount > 0) ? $cCount : 16;
        }

        $monthlyParamData = [];
        foreach ($parametersList as $p) {
            $monthlyParamData[$p['parameter_id']] = [
                'qty_ml' => floatval($p['qty_ml'] ?? 0),
                'monthly_target' => 0.0,
                'total_consumed' => 0.0
            ];
        }

        $dailyReportStmt = $pdo->prepare("
            SELECT parameter_id, qty_used 
            FROM mcc_vb_chemical_report 
            WHERE token_id = :token_id AND station_id = :station_id
        ");

        foreach ($tokensList as $tok) {
            $cCount = $tokenCoaches[$tok] ?? 16;
            $dailyReportStmt->execute(['token_id' => $tok, 'station_id' => $stationId]);
            $items = $dailyReportStmt->fetchAll();

            foreach ($items as $item) {
                $pId = $item['parameter_id'];
                $qty = floatval($item['qty_used']);
                if (isset($monthlyParamData[$pId])) {
                    $monthlyParamData[$pId]['total_consumed'] += $qty;
                }
            }

            foreach ($parametersList as $p) {
                $pId = $p['parameter_id'];
                $targetPerCoach = floatval($p['qty_ml'] ?? 0);
                $targetTotal = $targetPerCoach * $cCount;
                if (isset($monthlyParamData[$pId])) {
                    $monthlyParamData[$pId]['monthly_target'] += $targetTotal;
                }
            }
        }

        $totalAchieved = 0.0;
        $paramWithTargetCount = 0;
        foreach ($monthlyParamData as $pId => $data) {
            if ($data['monthly_target'] > 0) {
                $target = $data['monthly_target'];
                $consumed = $data['total_consumed'];
                $pct = min(100.0, ($consumed / $target) * 100.0);
                $totalAchieved += $pct;
                $paramWithTargetCount++;
            }
        }
        return ($paramWithTargetCount > 0) ? round($totalAchieved / $paramWithTargetCount, 2) : 0.0;
    } catch (Exception $e) {
        return 0.0;
    }
}

/**
 * Calculates Monthly Vande Bharat Machine Score
 */
function getVandeBharatMachineScore($stationId, $year, $month) {
    global $pdo;
    $month = str_pad($month, 2, '0', STR_PAD_LEFT);
    $daysInMonth = cal_days_in_month(CAL_GREGORIAN, intval($month), intval($year));
    $targetMonthDate = "$year-$month-01";

    try {
        $shiftsStmt = $pdo->prepare("SELECT id FROM mcc_vb_machine_shifts WHERE station_id = :station_id");
        $shiftsStmt->execute(['station_id' => $stationId]);
        $shifts = $shiftsStmt->fetchAll(PDO::FETCH_COLUMN);

        $machinesStmt = $pdo->prepare("SELECT id FROM mcc_vb_machine_param WHERE station_id = :station_id");
        $machinesStmt->execute(['station_id' => $stationId]);
        $machines = $machinesStmt->fetchAll(PDO::FETCH_COLUMN);

        $targetsStmt = $pdo->prepare("
            SELECT machine_id, shift_id, nominated_area, penalty_amount 
            FROM mcc_vb_machine_target 
            WHERE station_id = :station_id AND target_month = :target_month
        ");
        $targetsStmt->execute(['station_id' => $stationId, 'target_month' => $targetMonthDate]);
        $targetsMap = [];
        while ($row = $targetsStmt->fetch()) {
            $targetsMap[$row['machine_id']][$row['shift_id']] = $row['nominated_area'];
        }

        $reportsStmt = $pdo->prepare("
            SELECT report_date, parameter_id AS machine_id, shift_id, used_status 
            FROM mcc_vb_machine_report 
            WHERE station_id = :station_id AND YEAR(report_date) = :year AND MONTH(report_date) = :month
        ");
        $reportsStmt->execute(['station_id' => $stationId, 'year' => $year, 'month' => intval($month)]);
        $reportsRows = $reportsStmt->fetchAll();

        $reportsMap = [];
        $daysWithReports = [];
        foreach ($reportsRows as $row) {
            $date = $row['report_date'];
            $reportsMap[$date][$row['machine_id']][$row['shift_id']] = $row['used_status'];
            $daysWithReports[$date] = true;
        }

        if (empty($daysWithReports)) {
            return 0.0;
        }

        $sumDailyScores = 0.0;
        for ($d = 1; $d <= $daysInMonth; $d++) {
            $dayStr = str_pad($d, 2, '0', STR_PAD_LEFT);
            $dateStr = "$year-$month-$dayStr";
            $dayScore = 0.0;
            if (isset($daysWithReports[$dateStr])) {
                $dayNominated = 0;
                $dayOperated = 0;
                foreach ($machines as $mId) {
                    foreach ($shifts as $sId) {
                        $isNom = ($targetsMap[$mId][$sId] ?? 'N') === 'Y';
                        if ($isNom) {
                            $dayNominated++;
                            if (($reportsMap[$dateStr][$mId][$sId] ?? '-') === 'Y') {
                                $dayOperated++;
                            }
                        }
                    }
                }
                $dayScore = $dayNominated > 0 ? ($dayOperated / $dayNominated) * 100.0 : 100.0;
            }
            $sumDailyScores += $dayScore;
        }

        return $daysInMonth > 0 ? round($sumDailyScores / $daysInMonth, 2) : 0.0;
    } catch (Exception $e) {
        return 0.0;
    }
}
?>
