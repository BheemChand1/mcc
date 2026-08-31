<?php
/**
 * CDO Dashboard - Live Command Center Aggregator
 */
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
require_once 'auth.php';
global $pdo;

$stationId = $_SESSION['station_id'] ?? 1;
$selectedDate = (new DateTimeImmutable('now', new DateTimeZone('Asia/Kolkata')))->format('Y-m-d');
$month = date('m', strtotime($selectedDate));
$year = date('Y', strtotime($selectedDate));

// ----------------------------------------------------
// 1. LIVE RECENT AUDITS / OPERATIONS BOARD
// ----------------------------------------------------
$liveOperations = [];

// Fetch active sub-parameter counts for each report type for this station
$normalMaxPerCoach = 0;
try {
    $subStmt = $pdo->prepare("
        SELECT sp.id, p.parameter_name 
        FROM mcc_normal_scorecard_sub_param sp
        JOIN mcc_normal_scorecard_param p ON p.id = sp.parameter_id
        WHERE p.station_id = :sid AND sp.station_id = :sid AND p.status = 'Active' AND sp.status = 'Active'
    ");
    $subStmt->execute(['sid' => $stationId]);
    $subRows = $subStmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($subRows as $sr) {
        if (stripos($sr['parameter_name'], 'watering') !== false) {
            $normalMaxPerCoach += 1;
        } else {
            $normalMaxPerCoach += 3;
        }
    }
    if ($normalMaxPerCoach <= 0) $normalMaxPerCoach = 16;
} catch (Exception $e) {
    $normalMaxPerCoach = 16;
}

$intensiveSubCount = 0;
try {
    $subStmt = $pdo->prepare("
        SELECT COUNT(*) 
        FROM mcc_intensive_scorecard_2_sub_param sp
        JOIN mcc_intensive_scorecard_2_param p ON p.id = sp.parameter_id
        WHERE p.station_id = :sid AND sp.station_id = :sid AND p.status = 'Active' AND sp.status = 'Active'
    ");
    $subStmt->execute(['sid' => $stationId]);
    $intensiveSubCount = intval($subStmt->fetchColumn()) ?: 20;
} catch (Exception $e) {
    $intensiveSubCount = 20;
}

$pantrySubCount = 0;
try {
    $subStmt = $pdo->prepare("
        SELECT COUNT(*) 
        FROM mcc_intensive_pantry_sub_param sp
        JOIN mcc_intensive_pantry_param p ON p.id = sp.parameter_id
        WHERE p.station_id = :sid AND sp.station_id = :sid AND p.status = 'Active' AND sp.status = 'Active'
    ");
    $subStmt->execute(['sid' => $stationId]);
    $pantrySubCount = intval($subStmt->fetchColumn()) ?: 10;
} catch (Exception $e) {
    $pantrySubCount = 10;
}

$prtMaxPerCoach = 0;
try {
    $subStmt = $pdo->prepare("
        SELECT sp.id, p.parameter_name 
        FROM mcc_prt_scorecard_sub_param sp
        JOIN mcc_prt_scorecard_param p ON p.id = sp.parameter_id
        WHERE p.station_id = :sid AND sp.station_id = :sid AND p.status = 'Active' AND sp.status = 'Active'
    ");
    $subStmt->execute(['sid' => $stationId]);
    $subRows = $subStmt->fetchAll(PDO::FETCH_ASSOC);
    foreach ($subRows as $sr) {
        if (stripos($sr['parameter_name'], 'watering') !== false) {
            $prtMaxPerCoach += 1;
        } else {
            $prtMaxPerCoach += 3;
        }
    }
    if ($prtMaxPerCoach <= 0) $prtMaxPerCoach = 16;
} catch (Exception $e) {
    $prtMaxPerCoach = 16;
}

// A. Normal Scorecard Reports
try {
    $stmt = $pdo->prepare("
        SELECT token_id, train_no, report_date, auditor_name,
               COUNT(DISTINCT coach_no) as coaches_count,
               SUM(CASE WHEN score_value REGEXP '^[0-9]+$' THEN CAST(score_value AS DECIMAL(5,2)) WHEN score_value = 'Y' THEN 1 ELSE 0 END) as sum_score,
               MAX(created_at) as last_updated
        FROM mcc_normal_scorecard_report
        WHERE station_id = :sid AND report_date = :rdate
        GROUP BY token_id, train_no, report_date, auditor_name
        ORDER BY report_date DESC, last_updated DESC
        LIMIT 10
    ");
    $stmt->execute(['sid' => $stationId, 'rdate' => $selectedDate]);
    while ($r = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $coachesCount = intval($r['coaches_count']) > 0 ? intval($r['coaches_count']) : 1;
        $maxPossible = $coachesCount * $normalMaxPerCoach;
        $scorePct = $maxPossible > 0 ? round((floatval($r['sum_score']) / $maxPossible) * 100, 1) : 0;
        $liveOperations[] = [
            'train_no'       => $r['train_no'] ?: 'Normal Train',
            'type'           => 'MCC Normal Cleaning',
            'type_badge_bg'  => '#02d66f',
            'type_badge_ico' => '▣',
            'location'       => 'Pit Line 1',
            'coaches'        => $r['coaches_count'] > 0 ? $r['coaches_count'] : 24,
            'auditor'        => $r['auditor_name'] ?: 'Auditor',
            'time'           => !empty($r['last_updated']) ? date('h:i A', strtotime($r['last_updated'])) : '–',
            'score'          => $scorePct > 0 ? $scorePct . '%' : '–',
            'progress'       => $scorePct > 0 ? min(100, max(40, round($scorePct))) : 75,
            'status'         => ($scorePct >= 85) ? 'Completed' : (($scorePct > 0) ? 'At Risk' : 'In Progress'),
            'status_class'   => ($scorePct >= 85) ? 'on' : (($scorePct > 0) ? 'risk' : 'inspect'),
            'report_date'    => $r['report_date']
        ];
    }
} catch (Exception $e) {}

// B. Intensive Scorecard 2 Reports
try {
    $stmt = $pdo->prepare("
        SELECT token_id, train_no, report_date, auditor_name,
               COUNT(DISTINCT coach_no) as coaches_count,
               SUM(CASE WHEN score_value REGEXP '^[0-9]+$' THEN CAST(score_value AS DECIMAL(5,2)) ELSE 0 END) as sum_score,
               MAX(created_at) as last_updated
        FROM mcc_intensive_scorecard_2_report
        WHERE station_id = :sid AND report_date = :rdate
        GROUP BY token_id, train_no, report_date, auditor_name
        ORDER BY report_date DESC, last_updated DESC
        LIMIT 10
    ");
    $stmt->execute(['sid' => $stationId, 'rdate' => $selectedDate]);
    while ($r = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $coachesCount = intval($r['coaches_count']) > 0 ? intval($r['coaches_count']) : 1;
        $maxPossible = $coachesCount * $intensiveSubCount * 1;
        $scorePct = $maxPossible > 0 ? round((floatval($r['sum_score']) / $maxPossible) * 100, 1) : 0;
        $liveOperations[] = [
            'train_no'       => $r['train_no'] ?: 'Intensive Rake',
            'type'           => 'MCC Intensive Cleaning',
            'type_badge_bg'  => '#f05400',
            'type_badge_ico' => '♟',
            'location'       => 'Pit Line 2',
            'coaches'        => $r['coaches_count'] > 0 ? $r['coaches_count'] : 22,
            'auditor'        => $r['auditor_name'] ?: 'Auditor',
            'time'           => !empty($r['last_updated']) ? date('h:i A', strtotime($r['last_updated'])) : '–',
            'score'          => $scorePct > 0 ? $scorePct . '%' : '–',
            'progress'       => $scorePct > 0 ? min(100, max(50, round($scorePct))) : 80,
            'status'         => ($scorePct >= 85) ? 'Completed' : (($scorePct > 0) ? 'At Risk' : 'In Progress'),
            'status_class'   => ($scorePct >= 85) ? 'on' : (($scorePct > 0) ? 'risk' : 'inspect'),
            'report_date'    => $r['report_date']
        ];
    }
} catch (Exception $e) {}

// C. Pantry Car Scorecard Reports
try {
    $stmt = $pdo->prepare("
        SELECT token_id, train_no, report_date, auditor_name,
               COUNT(DISTINCT coach_no) as coaches_count,
               SUM(CASE WHEN score_value REGEXP '^[0-9]+$' THEN CAST(score_value AS DECIMAL(5,2)) ELSE 0 END) as sum_score,
               MAX(created_at) as last_updated
        FROM mcc_intensive_pantry_report
        WHERE station_id = :sid AND report_date = :rdate
        GROUP BY token_id, train_no, report_date, auditor_name
        ORDER BY report_date DESC, last_updated DESC
        LIMIT 10
    ");
    $stmt->execute(['sid' => $stationId, 'rdate' => $selectedDate]);
    while ($r = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $coachesCount = intval($r['coaches_count']) > 0 ? intval($r['coaches_count']) : 1;
        $maxPossible = $coachesCount * $pantrySubCount * 1;
        $scorePct = $maxPossible > 0 ? round((floatval($r['sum_score']) / $maxPossible) * 100, 1) : 0;
        $liveOperations[] = [
            'train_no'       => $r['train_no'] ?: 'Pantry Car',
            'type'           => 'Pantry Car Audit',
            'type_badge_bg'  => '#933ce3',
            'type_badge_ico' => '♨',
            'location'       => 'Pantry Bay',
            'coaches'        => $r['coaches_count'] > 0 ? $r['coaches_count'] : 1,
            'auditor'        => $r['auditor_name'] ?: 'Auditor',
            'time'           => !empty($r['last_updated']) ? date('h:i A', strtotime($r['last_updated'])) : '–',
            'score'          => $scorePct > 0 ? $scorePct . '%' : '–',
            'progress'       => 100,
            'status'         => ($scorePct >= 85) ? 'Completed' : 'Inspection',
            'status_class'   => ($scorePct >= 85) ? 'on' : 'inspect',
            'report_date'    => $r['report_date']
        ];
    }
} catch (Exception $e) {}

// D. DC Scorecard Reports
try {
    $stmt = $pdo->prepare("
        SELECT token_id, train_no, report_date,
               AVG(CASE WHEN rating REGEXP '^[0-9]+$' THEN CAST(rating AS DECIMAL(5,2)) ELSE NULL END) as avg_rating,
               MAX(created_at) as last_updated
        FROM dc_mcc_report
        WHERE station_id = :sid AND report_date = :rdate
        GROUP BY token_id, train_no, report_date
        ORDER BY report_date DESC, last_updated DESC
        LIMIT 10
    ");
    $stmt->execute(['sid' => $stationId, 'rdate' => $selectedDate]);
    while ($r = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $scorePct = $r['avg_rating'] !== null ? round((floatval($r['avg_rating']) / 3.0) * 100, 1) : 0;
        $liveOperations[] = [
            'train_no'       => $r['train_no'] ?: 'DC Area',
            'type'           => 'Depot DC Cleaning',
            'type_badge_bg'  => '#00a4ff',
            'type_badge_ico' => '▣',
            'location'       => 'Yard / Track Area',
            'coaches'        => '–',
            'auditor'        => 'Staff',
            'time'           => !empty($r['last_updated']) ? date('h:i A', strtotime($r['last_updated'])) : '–',
            'score'          => $scorePct > 0 ? $scorePct . '%' : '–',
            'progress'       => 95,
            'status'         => 'Completed',
            'status_class'   => 'on',
            'report_date'    => $r['report_date']
        ];
    }
} catch (Exception $e) {}

// E. PRT Scorecard Reports
try {
    $stmt = $pdo->prepare("
        SELECT token_id, train_no, report_date, auditor_name,
               COUNT(DISTINCT coach_no) as coaches_count,
               SUM(CASE WHEN score_value REGEXP '^[0-9]+$' THEN CAST(score_value AS DECIMAL(5,2)) WHEN score_value = 'Y' THEN 1 ELSE 0 END) as sum_score,
               MAX(created_at) as last_updated
        FROM mcc_prt_scorecard_report
        WHERE station_id = :sid AND report_date = :rdate
        GROUP BY token_id, train_no, report_date, auditor_name
        ORDER BY report_date DESC, last_updated DESC
        LIMIT 10
    ");
    $stmt->execute(['sid' => $stationId, 'rdate' => $selectedDate]);
    while ($r = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $coachesCount = intval($r['coaches_count']) > 0 ? intval($r['coaches_count']) : 1;
        $maxPossible = $coachesCount * $prtMaxPerCoach;
        $scorePct = $maxPossible > 0 ? round((floatval($r['sum_score']) / $maxPossible) * 100, 1) : 0;
        $liveOperations[] = [
            'train_no'       => $r['train_no'] ?: 'PRT Train',
            'type'           => 'Platform Return Cleaning',
            'type_badge_bg'  => '#16dc66',
            'type_badge_ico' => '▣',
            'location'       => 'Platform Line',
            'coaches'        => $r['coaches_count'] > 0 ? $r['coaches_count'] : 18,
            'auditor'        => $r['auditor_name'] ?: 'Auditor',
            'time'           => !empty($r['last_updated']) ? date('h:i A', strtotime($r['last_updated'])) : '–',
            'score'          => $scorePct > 0 ? $scorePct . '%' : '–',
            'progress'       => 100,
            'status'         => 'Completed',
            'status_class'   => 'on',
            'report_date'    => $r['report_date']
        ];
    }
} catch (Exception $e) {}

// Sort all operations by report_date descending
usort($liveOperations, function($a, $b) {
    return strcmp($b['report_date'], $a['report_date']);
});
$liveOperations = array_slice($liveOperations, 0, 8);


// ----------------------------------------------------
// 2. DYNAMIC SUMMARY & KPIS
// ----------------------------------------------------
// Count total unique coaches inspected
$totalCoachesCleaned = 0;
$totalRakesProcessed = count($liveOperations);
$sumScores = 0;
$countScores = 0;

foreach ($liveOperations as $op) {
    if (is_numeric($op['coaches'])) {
        $totalCoachesCleaned += intval($op['coaches']);
    }
    if ($op['score'] !== '–') {
        $sumScores += floatval(rtrim($op['score'], '%'));
        $countScores++;
    }
}
$avgCleaningScore = $countScores > 0 ? round($sumScores / $countScores, 1) : 0;

// Manpower Stats
$manpowerPresent = 0;
$manpowerTarget = 0;
try {
    $mpStmt = $pdo->prepare("
        SELECT SUM(provided) as total_provided, SUM(absent) as total_absent
        FROM mcc_manpower_log
        WHERE station_id = :sid AND report_date = :rdate
    ");
    $mpStmt->execute(['sid' => $stationId, 'rdate' => $selectedDate]);
    $mpRow = $mpStmt->fetch(PDO::FETCH_ASSOC);
    if ($mpRow && $mpRow['total_provided'] > 0) {
        $manpowerPresent = max(0, intval($mpRow['total_provided']) - intval($mpRow['total_absent']));
        $manpowerTarget = intval($mpRow['total_provided']);
    }
} catch (Exception $e) {}

// Machine Stats
$machinesOperational = 0;
$machinesTotal = 0;
try {
    $machStmt = $pdo->prepare("
        SELECT COUNT(*) as total, SUM(CASE WHEN status = 'Operational' OR remarks = 'Working' THEN 1 ELSE 0 END) as op_cnt
        FROM mcc_normal_machine_report
        WHERE station_id = :sid AND report_date = :rdate
    ");
    $machStmt->execute(['sid' => $stationId, 'rdate' => $selectedDate]);
    $mRow = $machStmt->fetch(PDO::FETCH_ASSOC);
    if ($mRow && $mRow['total'] > 0) {
        $machinesTotal = intval($mRow['total']);
        $machinesOperational = intval($mRow['op_cnt']);
    }
} catch (Exception $e) {}

// Top Performing Trains
$topTrains = [];
foreach ($liveOperations as $op) {
    if ($op['score'] !== '–') {
        $topTrains[] = [
            'train_no' => $op['train_no'],
            'type'     => $op['type'],
            'score'    => $op['score'],
            'auditor'  => $op['auditor']
        ];
    }
}
usort($topTrains, function($a, $b) {
    return floatval(rtrim($b['score'], '%')) <=> floatval(rtrim($a['score'], '%'));
});
$topTrains = array_slice($topTrains, 0, 5);

// Complete work-summary totals and scores for today (not limited by the
// eight-row live operations board).
$summarySources = [
    'normal'    => ['table' => 'mcc_normal_scorecard_report',      'score' => 'score_value', 'maximum' => 3],
    'intensive' => ['table' => 'mcc_intensive_scorecard_2_report', 'score' => 'score_value', 'maximum' => 1],
    'pantry'    => ['table' => 'mcc_intensive_pantry_report',      'score' => 'score_value', 'maximum' => 1],
    'dc'        => ['table' => 'dc_mcc_report',                    'score' => 'rating',      'maximum' => 3],
    'vande'     => ['table' => 'mcc_vb_scorecard_report',          'score' => 'score_value', 'maximum' => 3],
    'prt'       => ['table' => 'mcc_prt_scorecard_report',         'score' => 'score_value', 'maximum' => 3],
];

$todayWorkSummary = [];
foreach ($summarySources as $key => $source) {
    $todayWorkSummary[$key] = ['rakes' => 0, 'score' => 0];
    try {
        $summaryStmt = $pdo->prepare("
            SELECT COUNT(DISTINCT token_id) AS rake_count,
                   AVG(CASE
                       WHEN {$source['score']} REGEXP '^[0-9]+(\\.[0-9]+)?$'
                       THEN CAST({$source['score']} AS DECIMAL(8,2))
                       ELSE NULL
                   END) AS average_score
            FROM {$source['table']}
            WHERE station_id = :sid AND report_date = :rdate
        ");
        $summaryStmt->execute(['sid' => $stationId, 'rdate' => $selectedDate]);
        $summaryRow = $summaryStmt->fetch(PDO::FETCH_ASSOC);
        if ($summaryRow) {
            $todayWorkSummary[$key]['rakes'] = intval($summaryRow['rake_count'] ?? 0);
            $todayWorkSummary[$key]['score'] = $summaryRow['average_score'] !== null
                ? round((floatval($summaryRow['average_score']) / $source['maximum']) * 100, 1)
                : 0;
        }
    } catch (Exception $e) {}
}

// Quality parameter distribution from today's submitted scorecards. Parent
// parameter names are configured per station in Report Parameters, while the
// scores are recorded against their child parameters in each report table.
$qualityParameterSources = [
    ['report' => 'mcc_normal_scorecard_report',      'sub' => 'mcc_normal_scorecard_sub_param',      'param' => 'mcc_normal_scorecard_param'],
    ['report' => 'mcc_intensive_scorecard_2_report', 'sub' => 'mcc_intensive_scorecard_2_sub_param', 'param' => 'mcc_intensive_scorecard_2_param'],
    ['report' => 'mcc_intensive_pantry_report',      'sub' => 'mcc_intensive_pantry_sub_param',      'param' => 'mcc_intensive_pantry_param'],
    ['report' => 'mcc_prt_scorecard_report',         'sub' => 'mcc_prt_scorecard_sub_param',         'param' => 'mcc_prt_scorecard_param'],
    ['report' => 'mcc_vb_scorecard_report',          'sub' => 'mcc_vb_scorecard_sub_param',          'param' => 'mcc_vb_scorecard_param'],
];

$qualityParameterTotals = [];
foreach ($qualityParameterSources as $source) {
    try {
        $qualityStmt = $pdo->prepare("
            SELECT p.parameter_name,
                   SUM(CAST(r.score_value AS DECIMAL(8,2))) AS score_sum,
                   COUNT(*) AS score_count
            FROM {$source['report']} r
            JOIN {$source['sub']} sp ON sp.id = r.sub_parameter_id
            JOIN {$source['param']} p ON p.id = sp.parameter_id
            WHERE r.station_id = :sid
              AND r.report_date = :rdate
              AND r.score_value REGEXP '^[0-3](\\.[0-9]+)?$'
            GROUP BY p.id, p.parameter_name
        ");
        $qualityStmt->execute(['sid' => $stationId, 'rdate' => $selectedDate]);
        foreach ($qualityStmt->fetchAll(PDO::FETCH_ASSOC) as $qualityRow) {
            $parameterName = trim($qualityRow['parameter_name']);
            if ($parameterName === '') continue;
            if (!isset($qualityParameterTotals[$parameterName])) {
                $qualityParameterTotals[$parameterName] = ['score_sum' => 0.0, 'score_count' => 0];
            }
            $qualityParameterTotals[$parameterName]['score_sum'] += floatval($qualityRow['score_sum']);
            $qualityParameterTotals[$parameterName]['score_count'] += intval($qualityRow['score_count']);
        }
    } catch (Exception $e) {}
}

$qualityParameters = [];
foreach ($qualityParameterTotals as $parameterName => $totals) {
    if ($totals['score_count'] <= 0) continue;
    $percentage = round(($totals['score_sum'] / ($totals['score_count'] * 3)) * 100, 1);
    $percentage = min(100, max(0, $percentage));
    $qualityParameters[] = [
        'name' => $parameterName,
        'percentage' => $percentage,
        'count' => $totals['score_count'],
        'color' => $percentage >= 90 ? '#02d66f' : ($percentage >= 75 ? '#00a4ff' : ($percentage >= 60 ? '#f1ae00' : '#f05400')),
    ];
}
usort($qualityParameters, function($a, $b) {
    return ($b['count'] <=> $a['count']) ?: ($b['percentage'] <=> $a['percentage']);
});
$qualityParameters = array_slice($qualityParameters, 0, 5);

// Seven-day cleaning score trend across every dashboard report type.
$trendEndDate = new DateTimeImmutable($selectedDate, new DateTimeZone('Asia/Kolkata'));
$trendStartDate = $trendEndDate->modify('-6 days');
$trendDailyTotals = [];
for ($dayOffset = 0; $dayOffset < 7; $dayOffset++) {
    $dateKey = $trendStartDate->modify("+{$dayOffset} days")->format('Y-m-d');
    $trendDailyTotals[$dateKey] = ['score_sum' => 0.0, 'score_count' => 0];
}

foreach ($summarySources as $source) {
    try {
        $trendStmt = $pdo->prepare("
            SELECT report_date,
                   SUM(CASE
                       WHEN {$source['score']} REGEXP '^[0-9]+(\\.[0-9]+)?$'
                       THEN CAST({$source['score']} AS DECIMAL(8,2))
                       ELSE 0
                   END) AS raw_score_sum,
                   COUNT(CASE
                       WHEN {$source['score']} REGEXP '^[0-9]+(\\.[0-9]+)?$' THEN 1
                       ELSE NULL
                   END) AS score_count
            FROM {$source['table']}
            WHERE station_id = :sid AND report_date BETWEEN :start_date AND :end_date
            GROUP BY report_date
        ");
        $trendStmt->execute([
            'sid' => $stationId,
            'start_date' => $trendStartDate->format('Y-m-d'),
            'end_date' => $trendEndDate->format('Y-m-d'),
        ]);
        foreach ($trendStmt->fetchAll(PDO::FETCH_ASSOC) as $trendRow) {
            $dateKey = $trendRow['report_date'];
            if (!isset($trendDailyTotals[$dateKey])) continue;
            $validScores = intval($trendRow['score_count']);
            $trendDailyTotals[$dateKey]['score_sum'] +=
                (floatval($trendRow['raw_score_sum']) / $source['maximum']) * 100;
            $trendDailyTotals[$dateKey]['score_count'] += $validScores;
        }
    } catch (Exception $e) {}
}

$trendLabels = [];
$trendScores = [];
$trendPoints = [];
$trendPointCount = count($trendDailyTotals);
$trendIndex = 0;
foreach ($trendDailyTotals as $dateKey => $totals) {
    $score = $totals['score_count'] > 0
        ? round($totals['score_sum'] / $totals['score_count'], 1)
        : 0;
    $score = min(100, max(0, $score));
    $x = 10 + ($trendIndex * (500 / max(1, $trendPointCount - 1)));
    $y = 145 - ($score * 1.2);
    $trendLabels[] = (new DateTimeImmutable($dateKey))->format('d M');
    $trendScores[] = $score;
    $trendPoints[] = round($x, 1) . ',' . round($y, 1);
    $trendIndex++;
}
$trendPolyline = implode(' ', $trendPoints);
$trendAreaPath = $trendPoints
    ? 'M' . implode(' L', $trendPoints) . ' L510,150 L10,150 Z'
    : '';

$pageTitle = 'MCC Command Center';
include 'header.php';
include 'sidebar.php';
?>

<link rel="stylesheet" href="css/dashboard.css">

<main class="app-main">
  <div class="mcc-dashboard-shell">
    <section class="mcc-dashboard-grid">
      
      <!-- 1. KPI Row (6 Cards) -->
      <section class="mcc-kpi-row">
        <article class="mcc-kpi mcc-card mcc-cyan">
          <div class="mcc-kpi-icon">▣</div>
          <div>
            <small>COACHES AUDITED</small>
            <div class="mcc-kpi-value"><?= $totalCoachesCleaned ?> <span>Coaches</span></div>
            <div class="mcc-kpi-sub positive">▲ Live Inspected Data</div>
          </div>
        </article>

        <article class="mcc-kpi mcc-card mcc-purple">
          <div class="mcc-kpi-icon">▣</div>
          <div>
            <small>RAKES / TRAINS PROCESSED</small>
            <div class="mcc-kpi-value"><?= str_pad($totalRakesProcessed, 2, '0', STR_PAD_LEFT) ?> <span>Rakes</span></div>
            <div class="mcc-kpi-sub">Active Inspection Records</div>
          </div>
        </article>

        <article class="mcc-kpi mcc-card mcc-green">
          <div class="mcc-kpi-icon">★</div>
          <div>
            <small>AVERAGE CLEANING SCORE</small>
            <div class="mcc-kpi-value"><?= $avgCleaningScore ?>%</div>
            <div class="mcc-kpi-sub positive">▲ Compliance Rating</div>
          </div>
        </article>

        <article class="mcc-kpi mcc-card mcc-cyan">
          <div class="mcc-kpi-icon">♟</div>
          <div>
            <small>MANPOWER DEPLOYED</small>
            <div class="mcc-kpi-value"><?= $manpowerPresent ?> <span>/ <?= $manpowerTarget ?></span></div>
            <div class="mcc-kpi-sub positive">▲ <?= round(($manpowerPresent / max(1, $manpowerTarget)) * 100, 1) ?>% Staff Attendance</div>
          </div>
        </article>

        <article class="mcc-kpi mcc-card mcc-amber">
          <div class="mcc-kpi-icon">♨</div>
          <div>
            <small>MACHINERY AVAILABLE</small>
            <div class="mcc-kpi-value"><?= $machinesOperational ?> <span>/ <?= $machinesTotal ?></span></div>
            <div class="mcc-kpi-sub positive">▲ <?= round(($machinesOperational / max(1, $machinesTotal)) * 100, 1) ?>% Operational</div>
          </div>
        </article>

        <article class="mcc-kpi mcc-card mcc-red">
          <div class="mcc-kpi-icon">!</div>
          <div>
            <small>ACTIVE DEPOT STATION</small>
            <div class="mcc-kpi-value" style="font-size: 1.15rem; font-weight: 700;"><?= htmlspecialchars($stationName) ?></div>
            <div class="mcc-kpi-sub">Zone / Division Active</div>
          </div>
        </article>
      </section>

      <!-- 2. Command Board (Live Operations) -->
      <section class="mcc-command mcc-card">
        <div class="mcc-panel-head">
          <h2>LIVE CLEANING OPERATIONS COMMAND BOARD</h2>
          <div class="mcc-legend">
            <span><i class="mcc-dot mcc-green-dot"></i>Completed</span>
            <span><i class="mcc-dot mcc-amber-dot"></i>At Risk</span>
            <span><i class="mcc-dot mcc-red-dot"></i>Inspection</span>
          </div>
        </div>
        <div class="mcc-ops-table-wrap">
          <table class="mcc-ops-table">
            <thead>
              <tr>
                <th>TRAIN / RAKE</th>
                <th>OPERATION TYPE</th>
                <th>COACHES</th>
                <th>AUDITOR / TIME</th>
                <th>PROGRESS</th>
                <th>INSPECTION SCORE</th>
                <th>STATUS</th>
              </tr>
            </thead>
            <tbody id="operationsBody">
              <?php if (empty($liveOperations)): ?>
                <tr>
                  <td colspan="8" class="text-center py-4 text-muted">
                    No cleaning audits logged yet. Use the mobile app or audit forms to record train sheets.
                  </td>
                </tr>
              <?php else: ?>
                <?php foreach ($liveOperations as $op): ?>
                  <tr>
                    <td>
                      <div class="mcc-train-cell">
                        <span class="mcc-train-badge" style="background:<?= $op['type_badge_bg'] ?>"><?= $op['type_badge_ico'] ?></span>
                        <strong><?= htmlspecialchars($op['train_no']) ?></strong>
                      </div>
                    </td>
                    <td><?= htmlspecialchars($op['type']) ?></td>
                    <td><?= htmlspecialchars($op['coaches']) ?></td>
                    <td><?= htmlspecialchars($op['auditor']) ?> <small style="color:var(--mcc-muted)">(<?= $op['time'] ?>)</small></td>
                    <td class="mcc-progress-cell">
                      <?= $op['progress'] ?>%
                      <div class="mcc-progress-track"><i style="width:<?= $op['progress'] ?>%"></i></div>
                    </td>
                    <td><strong style="color:var(--mcc-cyan)"><?= $op['score'] ?></strong></td>
                    <td><span class="mcc-status <?= $op['status_class'] ?>"><?= $op['status'] ?> ›</span></td>
                  </tr>
                <?php endforeach; ?>
              <?php endif; ?>
            </tbody>
          </table>
        </div>
      </section>

      <!-- 3. AI Insights -->
      <aside class="mcc-ai mcc-card">
        <div class="mcc-panel-head">
          <h2>OPERATIONAL AUDIT INSIGHTS</h2>
          <span class="mcc-ai-pill">AI</span>
        </div>
        <div class="mcc-ai-content">
          <div class="mcc-ai-brain" aria-hidden="true">
            <div class="mcc-brain-core"></div>
          </div>
          <div class="mcc-insight-list" id="insightList">
            <div class="mcc-insight">
              <span class="mcc-insight-icon mcc-tone-green">✓</span>
              <div>
                <strong class="mcc-tone-green">Cleaning Quality Rating</strong>
                <p>Overall compliance score is at <?= $avgCleaningScore ?>% today</p>
              </div>
              <a href="normal-report.php">View Sheets</a>
            </div>
            <div class="mcc-insight">
              <span class="mcc-insight-icon mcc-tone-amber">♟</span>
              <div>
                <strong class="mcc-tone-amber">Manpower Deployment</strong>
                <p><?= $manpowerPresent ?> of <?= $manpowerTarget ?> active personnel logged</p>
              </div>
              <a href="man-power-log.php">View Log</a>
            </div>
            <div class="mcc-insight">
              <span class="mcc-insight-icon mcc-tone-purple">⚗</span>
              <div>
                <strong class="mcc-tone-purple">Chemical Tracking</strong>
                <p>Recorded consumption verified with station targets</p>
              </div>
              <a href="chemical-report.php">View Details</a>
            </div>
            <div class="mcc-insight">
              <span class="mcc-insight-icon mcc-tone-cyan">♨</span>
              <div>
                <strong class="mcc-tone-cyan">Machinery Readiness</strong>
                <p><?= $machinesOperational ?> machines operational on duty</p>
              </div>
              <a href="machine-report.php">View Status</a>
            </div>
          </div>
        </div>
      </aside>

      <!-- 4. Work Summary -->
      <section class="mcc-summary mcc-card">
        <div class="mcc-panel-head">
          <h2>DEPOT WORK SUMMARY</h2>
        </div>
        <div class="mcc-summary-list" id="summaryList">
          <div class="mcc-summary-line">
            <span class="mcc-summary-name"><i class="mcc-summary-icon" style="background:#02d66f;color:#06202a">▣</i>MCC Normal Cleaning</span>
            <span class="mcc-summary-val"><?= $todayWorkSummary['normal']['rakes'] ?> Rakes</span>
            <span class="mcc-summary-score"><?= $todayWorkSummary['normal']['score'] ?>%</span>
          </div>
          <div class="mcc-summary-line">
            <span class="mcc-summary-name"><i class="mcc-summary-icon" style="background:#f05400;color:#06202a">♟</i>MCC Intensive Cleaning</span>
            <span class="mcc-summary-val"><?= $todayWorkSummary['intensive']['rakes'] ?> Rakes</span>
            <span class="mcc-summary-score"><?= $todayWorkSummary['intensive']['score'] ?>%</span>
          </div>
          <div class="mcc-summary-line">
            <span class="mcc-summary-name"><i class="mcc-summary-icon" style="background:#933ce3;color:#06202a">♨</i>Pantry Car Scorecards</span>
            <span class="mcc-summary-val"><?= $todayWorkSummary['pantry']['rakes'] ?> Rakes</span>
            <span class="mcc-summary-score"><?= $todayWorkSummary['pantry']['score'] ?>%</span>
          </div>
          <div class="mcc-summary-line">
            <span class="mcc-summary-name"><i class="mcc-summary-icon" style="background:#00a4ff;color:#06202a">▣</i>Depot Yard & DC</span>
            <span class="mcc-summary-val"><?= $todayWorkSummary['dc']['rakes'] ?> Rakes</span>
            <span class="mcc-summary-score"><?= $todayWorkSummary['dc']['score'] ?>%</span>
          </div>
          <div class="mcc-summary-line">
            <span class="mcc-summary-name"><i class="mcc-summary-icon" style="background:#13c9ff;color:#06202a">VB</i>Vande Bharat Cleaning</span>
            <span class="mcc-summary-val"><?= $todayWorkSummary['vande']['rakes'] ?> Rakes</span>
            <span class="mcc-summary-score"><?= $todayWorkSummary['vande']['score'] ?>%</span>
          </div>
          <div class="mcc-summary-line">
            <span class="mcc-summary-name"><i class="mcc-summary-icon" style="background:#ffb000;color:#06202a">P</i>PRT Cleaning</span>
            <span class="mcc-summary-val"><?= $todayWorkSummary['prt']['rakes'] ?> Rakes</span>
            <span class="mcc-summary-score"><?= $todayWorkSummary['prt']['score'] ?>%</span>
          </div>
        </div>
      </section>

      <!-- 5. Cleaning Score Trend -->
      <section class="mcc-trend mcc-card">
        <div class="mcc-panel-head">
          <h2>CLEANING SCORE TREND</h2>
          <span class="mcc-trend-range">Last 7 Days</span>
        </div>
        <div class="mcc-line-chart">
          <div class="mcc-ylabels">
            <span>100%</span><span>67%</span><span>33%</span><span>0%</span>
          </div>
          <svg viewBox="0 0 520 160" preserveAspectRatio="none" aria-label="Cleaning score trend">
            <defs>
              <linearGradient id="mccAreaG" x1="0" y1="0" x2="0" y2="1">
                <stop offset="0" stop-color="#10caff" stop-opacity=".28"/>
                <stop offset="1" stop-color="#10caff" stop-opacity="0"/>
              </linearGradient>
            </defs>
            <g class="mcc-gridlines">
              <path d="M0 25 H520 M0 65 H520 M0 105 H520 M0 145 H520"/>
            </g>
            <path class="mcc-chart-area" d="<?= htmlspecialchars($trendAreaPath) ?>"/>
            <polyline class="mcc-chart-line" points="<?= htmlspecialchars($trendPolyline) ?>"/>
            <g class="mcc-chart-points">
              <?php foreach ($trendPoints as $pointIndex => $point): ?>
                <?php [$pointX, $pointY] = explode(',', $point); ?>
                <circle cx="<?= $pointX ?>" cy="<?= $pointY ?>" r="4">
                  <title><?= htmlspecialchars($trendLabels[$pointIndex]) ?>: <?= $trendScores[$pointIndex] ?>%</title>
                </circle>
              <?php endforeach; ?>
            </g>
          </svg>
          <div class="mcc-xlabels">
            <?php foreach ($trendLabels as $label): ?>
              <span><?= htmlspecialchars($label) ?></span>
            <?php endforeach; ?>
          </div>
          <div class="mcc-chart-legend">◆ Live Quality Compliance Curve (%)</div>
        </div>
      </section>

      <!-- 6. Manpower Deployment -->
      <section class="mcc-manpower mcc-card">
        <div class="mcc-panel-head">
          <h2>MANPOWER DEPLOYMENT</h2>
        </div>
        <div class="mcc-donut-wrap">
          <div class="mcc-donut mcc-manpower-donut">
            <div class="mcc-donut-center">
              <span>Total</span>
              <strong><?= $manpowerTarget ?></strong>
            </div>
          </div>
          <div class="mcc-donut-legend" id="manpowerLegend">
            <div class="mcc-legend-row"><i style="background:#0ba95c"></i><span>Present Staff</span><em><?= $manpowerPresent ?> (<?= round(($manpowerPresent / max(1, $manpowerTarget)) * 100) ?>%)</em></div>
            <div class="mcc-legend-row"><i style="background:#e13c32"></i><span>Absent / Leave</span><em><?= max(0, $manpowerTarget - $manpowerPresent) ?></em></div>
          </div>
        </div>
      </section>

      <!-- 7. Machinery Status -->
      <section class="mcc-machinery mcc-card">
        <div class="mcc-panel-head">
          <h2>MACHINERY STATUS</h2>
        </div>
        <div class="mcc-donut-wrap">
          <div class="mcc-donut mcc-machine-donut">
            <div class="mcc-donut-center">
              <span>Total</span>
              <strong><?= $machinesTotal ?></strong>
            </div>
          </div>
          <div class="mcc-donut-legend" id="machineLegend">
            <div class="mcc-legend-row"><i style="background:#10a95d"></i><span>Operational</span><em><?= $machinesOperational ?> (<?= round(($machinesOperational / max(1, $machinesTotal)) * 100) ?>%)</em></div>
            <div class="mcc-legend-row"><i style="background:#e13c32"></i><span>Maintenance / Idle</span><em><?= max(0, $machinesTotal - $machinesOperational) ?></em></div>
          </div>
        </div>
      </section>

      <!-- 8. Top Performing Trains -->
      <section class="mcc-trains mcc-card">
        <div class="mcc-panel-head">
          <h2>TOP PERFORMING TRAINS <small>(By Score)</small></h2>
        </div>
        <table class="mcc-mini-table">
          <thead>
            <tr><th>Train No.</th><th>Operation Type</th><th>Auditor</th><th>Avg Score</th></tr>
          </thead>
          <tbody>
            <?php if (empty($topTrains)): ?>
              <tr><td colspan="4" class="text-center py-3 text-muted">No train scores recorded yet.</td></tr>
            <?php else: ?>
              <?php foreach ($topTrains as $tt): ?>
                <tr>
                  <td><strong><?= htmlspecialchars($tt['train_no']) ?></strong></td>
                  <td><?= htmlspecialchars($tt['type']) ?></td>
                  <td><?= htmlspecialchars($tt['auditor']) ?></td>
                  <td class="score"><?= htmlspecialchars($tt['score']) ?></td>
                </tr>
              <?php endforeach; ?>
            <?php endif; ?>
          </tbody>
        </table>
      </section>

      <!-- 9. Deficiency Overview -->
      <section class="mcc-deficiency mcc-card">
        <div class="mcc-panel-head">
          <h2>QUALITY PARAMETER DISTRIBUTION</h2>
        </div>
        <div class="mcc-bar-list">
          <?php if (!empty($qualityParameters)): ?>
            <?php foreach ($qualityParameters as $parameter): ?>
              <div>
                <span><?= htmlspecialchars($parameter['name']) ?></span>
                <b><i style="width:<?= $parameter['percentage'] ?>%;background:<?= $parameter['color'] ?>"></i></b>
                <em><?= number_format($parameter['percentage'], 1) ?>%</em>
              </div>
            <?php endforeach; ?>
          <?php else: ?>
            <p class="mcc-empty">No quality parameter scores recorded today.</p>
          <?php endif; ?>
        </div>
      </section>

      <!-- 10. Alerts & Notifications -->
      <section class="mcc-alerts mcc-card">
        <div class="mcc-panel-head">
          <h2>LIVE AUDIT ALERTS &amp; LOGS</h2>
        </div>
        <div class="mcc-alert-list">
          <?php if (!empty($liveOperations)): ?>
            <?php foreach (array_slice($liveOperations, 0, 4) as $lop): ?>
              <div>
                <span class="mcc-alert-dot mcc-green-bg">✓</span>
                <p>Train <?= htmlspecialchars($lop['train_no']) ?> – <?= htmlspecialchars($lop['type']) ?> (<?= $lop['score'] ?>)</p>
                <time><?= $lop['time'] ?></time>
              </div>
            <?php endforeach; ?>
          <?php else: ?>
            <div><span class="mcc-alert-dot mcc-blue-bg">i</span><p>System listening for new audit submissions</p><time>Just now</time></div>
          <?php endif; ?>
        </div>
      </section>

      <!-- 11. Status Bar -->
      <footer class="mcc-statusbar">
        <span>Depot: <strong class="mcc-cyan">● <?= htmlspecialchars($stationName) ?> Station</strong></span>
        <span>Inspection Modules: <strong class="mcc-green">Online &amp; Active</strong></span>
        <span>Average Score: <strong class="mcc-cyan"><?= $avgCleaningScore ?>%</strong></span>
        <span>◔ Last Data Sync: <b id="syncTime" style="color:var(--mcc-cyan)"><?= date('h:i:s A') ?></b></span>
      </footer>

    </section>
  </div>
</main>

<script>
document.addEventListener('DOMContentLoaded', function () {
    // Live Sync Clock
    setInterval(() => {
        const syncEl = document.getElementById('syncTime');
        if (syncEl) {
            syncEl.textContent = new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', second: '2-digit' });
        }
    }, 1000);
});
</script>

<?php include 'footer.php'; ?>
