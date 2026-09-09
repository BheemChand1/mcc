<?php
/**
 * CDO Dashboard — Live Command Center (Neon Dark Theme)
 * Data: live MCC report tables with a From/To date-range filter.
 */
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
require_once 'auth.php';
global $pdo;

$stationId = $_SESSION['station_id'] ?? 1;
$tz        = new DateTimeZone('Asia/Kolkata');
$today     = new DateTimeImmutable('now', $tz);

/* ------------------------------------------------------------------ */
/* 0. DATE RANGE FILTER (From / To) + previous period for deltas      */
/* ------------------------------------------------------------------ */
$rangeEnd   = (isset($_GET['to'])   && preg_match('/^\d{4}-\d{2}-\d{2}$/', $_GET['to']))   ? $_GET['to']   : $today->format('Y-m-d');
$rangeStart = (isset($_GET['from']) && preg_match('/^\d{4}-\d{2}-\d{2}$/', $_GET['from'])) ? $_GET['from'] : $today->modify('-6 days')->format('Y-m-d');
if ($rangeStart > $rangeEnd) {
    [$rangeStart, $rangeEnd] = [$rangeEnd, $rangeStart];
}
$startDt   = new DateTimeImmutable($rangeStart);
$endDt     = new DateTimeImmutable($rangeEnd);
$rangeDays = (int) $startDt->diff($endDt)->format('%a') + 1;

$prevEndDt  = $startDt->modify('-1 day');
$prevStartF = $prevEndDt->modify('-' . ($rangeDays - 1) . ' days')->format('Y-m-d');
$prevEndF   = $prevEndDt->format('Y-m-d');

$qsToday = '?from=' . $today->format('Y-m-d') . '&to=' . $today->format('Y-m-d');
$qs7     = '?from=' . $today->modify('-6 days')->format('Y-m-d') . '&to=' . $today->format('Y-m-d');
$qs30    = '?from=' . $today->modify('-29 days')->format('Y-m-d') . '&to=' . $today->format('Y-m-d');

$scoreRe = '^[0-9]+(\\.[0-9]+)?$';

$mccPctDelta = function ($cur, $prev): float {
    $cur = floatval($cur);
    $prev = floatval($prev);
    if ($prev <= 0) {
        return $cur > 0 ? 100.0 : 0.0;
    }
    return round((($cur - $prev) / $prev) * 100, 1);
};

/* ------------------------------------------------------------------ */
/* 1. OPERATION CATEGORIES + PERIOD AGGREGATES                        */
/* ------------------------------------------------------------------ */
$categories = [
    'normal'    => ['label' => 'Normal Cleaning',    'short' => 'Normal',       'table' => 'mcc_normal_scorecard_report',      'color' => '#2f8bff', 'icon' => 'bi-bus-front-fill'],
    'intensive' => ['label' => 'Intensive Cleaning', 'short' => 'Intensive',    'table' => 'mcc_intensive_scorecard_2_report', 'color' => '#a55eea', 'icon' => 'bi-droplet-fill'],
    'pantry'    => ['label' => 'Pantry Car',         'short' => 'Pantry Car',   'table' => 'mcc_intensive_pantry_report',      'color' => '#22e07c', 'icon' => 'bi-egg-fried'],
    'prt'       => ['label' => 'PFTA Trains',        'short' => 'PFTA',         'table' => 'mcc_prt_scorecard_report',         'color' => '#ffaa2b', 'icon' => 'bi-person-workspace'],
    'vande'     => ['label' => 'Vande Bharat',       'short' => 'Vande Bharat', 'table' => 'mcc_vb_scorecard_report',          'color' => '#22d3ee', 'icon' => 'bi-train-front-fill'],
];

$mccAggregate = function (string $table, string $from, string $to) use ($pdo, $stationId, $scoreRe): array {
    $out = ['trains' => 0, 'rakes' => 0, 'coaches' => 0, 'score' => 0.0];
    try {
        $st = $pdo->prepare("
            SELECT COUNT(DISTINCT train_no)  AS trains,
                   COUNT(DISTINCT token_id)  AS rakes,
                   COUNT(DISTINCT coach_no)  AS coaches,
                   AVG(CASE WHEN score_value REGEXP '{$scoreRe}'
                       THEN CAST(score_value AS DECIMAL(8,2)) ELSE NULL END) AS avg_score
            FROM {$table}
            WHERE station_id = :sid AND report_date BETWEEN :f AND :t
        ");
        $st->execute([':sid' => $stationId, ':f' => $from, ':t' => $to]);
        $r = $st->fetch(PDO::FETCH_ASSOC) ?: [];
        $out['trains']  = intval($r['trains']  ?? 0);
        $out['rakes']   = intval($r['rakes']   ?? 0);
        $out['coaches'] = intval($r['coaches'] ?? 0);
        $out['score']   = ($r['avg_score'] !== null)
            ? round(min(100, max(0, (floatval($r['avg_score']) / 3) * 100)), 1)
            : 0.0;
    } catch (Exception $e) {}
    return $out;
};

$catStats     = [];
$catStatsPrev = [];
foreach ($categories as $key => $cat) {
    $catStats[$key]     = $mccAggregate($cat['table'], $rangeStart, $rangeEnd);
    $catStatsPrev[$key] = $mccAggregate($cat['table'], $prevStartF, $prevEndF);
}

/* ------------------------------------------------------------------ */
/* 2. OVERALL CHEMICAL SCORE (qty_used vs target qty)                 */
/* ------------------------------------------------------------------ */
$chemicalPairs = [
    ['mcc_normal_chemical_report',    'mcc_normal_chemical_target'],
    ['mcc_intensive_chemical_report', 'mcc_intensive_chemical_target'],
    ['mcc_prt_chemical_report',       'mcc_prt_chemical_target'],
    ['mcc_vb_chemical_report',        'mcc_vb_chemical_target'],
    ['dc_mcc_chemical_report',        'dc_mcc_chemical_target'],
];

$mccChem = function (string $reportTable, string $targetTable, string $from, string $to) use ($pdo, $stationId): float {
    $sqls = [
        "SELECT COALESCE(SUM(r.qty_used), 0) AS used, COALESCE(SUM(t.`qty(ml)`), 0) AS tgt
           FROM {$reportTable} r
           JOIN {$targetTable} t ON t.parameter_id = r.parameter_id AND t.station_id = r.station_id
            AND t.effective_from <= r.report_date AND (t.effective_to IS NULL OR t.effective_to >= r.report_date)
          WHERE r.station_id = :sid AND r.report_date BETWEEN :f AND :t",
        "SELECT COALESCE(SUM(r.qty_used), 0) AS used, COALESCE(SUM(t.`qty(ml)`), 0) AS tgt
           FROM {$reportTable} r
           JOIN {$targetTable} t ON t.parameter_id = r.parameter_id AND t.station_id = r.station_id
            AND t.id IN (SELECT MAX(x.id) FROM {$targetTable} x WHERE x.station_id = r.station_id GROUP BY x.parameter_id)
          WHERE r.station_id = :sid AND r.report_date BETWEEN :f AND :t",
    ];
    foreach ($sqls as $sql) {
        try {
            $st = $pdo->prepare($sql);
            $st->execute([':sid' => $stationId, ':f' => $from, ':t' => $to]);
            $r   = $st->fetch(PDO::FETCH_ASSOC);
            $used = floatval($r['used'] ?? 0);
            $tgt  = floatval($r['tgt'] ?? 0);
            return ($tgt > 0) ? round(min(100.0, ($used / $tgt) * 100), 1) : 0.0;
        } catch (Exception $e) {
            continue;
        }
    }
    return 0.0;
};

$chemScores = []; $chemScoresPrev = [];
foreach ($chemicalPairs as $cp) {
    $chemScores[]     = $mccChem($cp[0], $cp[1], $rangeStart, $rangeEnd);
    $chemScoresPrev[] = $mccChem($cp[0], $cp[1], $prevStartF, $prevEndF);
}
$chemActive = array_filter($chemScores, fn($v) => $v > 0);
$chemicalScore = $chemActive ? round(array_sum($chemActive) / count($chemActive), 1) : 0.0;
$chemActivePrev = array_filter($chemScoresPrev, fn($v) => $v > 0);
$chemicalScorePrev = $chemActivePrev ? round(array_sum($chemActivePrev) / count($chemActivePrev), 1) : 0.0;

/* ------------------------------------------------------------------ */
/* 3. OVERALL MACHINE SCORE (used_status Y compliance)                */
/* ------------------------------------------------------------------ */
$machineTables = ['mcc_normal_machine_report', 'mcc_intensive_machine_report', 'mcc_vb_machine_report', 'dc_mcc_machine_report'];

$mccMachine = function (string $table, string $from, string $to) use ($pdo, $stationId): float {
    try {
        $st = $pdo->prepare("
            SELECT COUNT(*) AS total,
                   SUM(CASE WHEN UPPER(used_status) = 'Y' THEN 1 ELSE 0 END) AS ok
            FROM {$table}
            WHERE station_id = :sid AND report_date BETWEEN :f AND :t
        ");
        $st->execute([':sid' => $stationId, ':f' => $from, ':t' => $to]);
        $r = $st->fetch(PDO::FETCH_ASSOC);
        if ($r && intval($r['total']) > 0) {
            return round(min(100.0, (intval($r['ok']) / intval($r['total'])) * 100), 1);
        }
    } catch (Exception $e) {}
    return 0.0;
};

$machScores = []; $machScoresPrev = [];
foreach ($machineTables as $mt) {
    $machScores[]     = $mccMachine($mt, $rangeStart, $rangeEnd);
    $machScoresPrev[] = $mccMachine($mt, $prevStartF, $prevEndF);
}
$machActive = array_filter($machScores, fn($v) => $v > 0);
$machineScore = $machActive ? round(array_sum($machActive) / count($machActive), 1) : 0.0;
$machActivePrev = array_filter($machScoresPrev, fn($v) => $v > 0);
$machineScorePrev = $machActivePrev ? round(array_sum($machActivePrev) / count($machActivePrev), 1) : 0.0;

/* ------------------------------------------------------------------ */
/* 4. OVERALL MANPOWER SCORE (attendance)                             */
/* ------------------------------------------------------------------ */
$manpowerScore = 0.0; $manpowerScorePrev = 0.0;
$manpowerPresent = 0; $manpowerTarget = 0;
try {
    $mpStmt = $pdo->prepare("
        SELECT SUM(provided) AS total_provided, SUM(absent) AS total_absent
        FROM mcc_manpower_log
        WHERE station_id = :sid AND report_date BETWEEN :f AND :t
    ");
    $mpStmt->execute([':sid' => $stationId, ':f' => $rangeStart, ':t' => $rangeEnd]);
    $mpRow = $mpStmt->fetch(PDO::FETCH_ASSOC);
    if ($mpRow && intval($mpRow['total_provided']) > 0) {
        $manpowerTarget  = intval($mpRow['total_provided']);
        $manpowerPresent = max(0, $manpowerTarget - intval($mpRow['total_absent']));
        $manpowerScore   = round(min(100.0, ($manpowerPresent / $manpowerTarget) * 100), 1);
    }
    $mpStmt->execute([':sid' => $stationId, ':f' => $prevStartF, ':t' => $prevEndF]);
    $mpRow = $mpStmt->fetch(PDO::FETCH_ASSOC);
    if ($mpRow && intval($mpRow['total_provided']) > 0) {
        $manpowerScorePrev = round(min(100.0, (max(0, intval($mpRow['total_provided']) - intval($mpRow['total_absent'])) / intval($mpRow['total_provided'])) * 100), 1);
    }
} catch (Exception $e) {}

/* ------------------------------------------------------------------ */
/* 5. CLEANING SCORE TREND (per-category daily series)                */
/* ------------------------------------------------------------------ */
$trendDates = [];
for ($i = 0; $i < $rangeDays; $i++) {
    $trendDates[] = $startDt->modify("+{$i} days")->format('Y-m-d');
}
$trendSeries = [];
foreach ($categories as $key => $cat) {
    $daily = array_fill_keys($trendDates, null);
    try {
        $st = $pdo->prepare("
            SELECT report_date,
                   AVG(CASE WHEN score_value REGEXP '{$scoreRe}'
                       THEN CAST(score_value AS DECIMAL(8,2)) ELSE NULL END) AS avg_score
            FROM {$cat['table']}
            WHERE station_id = :sid AND report_date BETWEEN :f AND :t
            GROUP BY report_date
        ");
        $st->execute([':sid' => $stationId, ':f' => $rangeStart, ':t' => $rangeEnd]);
        foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $row) {
            if (array_key_exists($row['report_date'], $daily) && $row['avg_score'] !== null) {
                $daily[$row['report_date']] = round(min(100, max(0, (floatval($row['avg_score']) / 3) * 100)), 1);
            }
        }
    } catch (Exception $e) {}
    $trendSeries[$key] = $daily;
}

/* SVG geometry (viewBox 0 0 560 190, plot area x:36-548, y:14-152) */
$n = count($trendDates);
$stepX = $n > 1 ? 512 / ($n - 1) : 0;
$mccXY = function ($i, $v) use ($stepX) {
    $x = 36 + ($i * $stepX);
    $y = 152 - (floatval($v) * 1.38);
    return [round($x, 1), round($y, 1)];
};
$trendLines = []; $trendDots = [];
foreach ($trendSeries as $key => $daily) {
    $pts = []; $dots = [];
    $idx = 0;
    foreach ($daily as $v) {
        if ($v === null) { $idx++; continue; }
        [$x, $y] = $mccXY($idx, $v);
        $pts[]  = $x . ',' . $y;
        $dots[] = ['x' => $x, 'y' => $y, 'v' => $v];
        $idx++;
    }
    $trendLines[$key] = implode(' ', $pts);
    $trendDots[$key]  = $dots;
}
$labelEvery = max(1, (int) ceil($n / 8));
$trendLabels = [];
foreach ($trendDates as $i => $d) {
    if ($i % $labelEvery === 0 || $i === $n - 1) {
        $trendLabels[] = ['x' => 36 + ($i * $stepX), 'text' => (new DateTimeImmutable($d))->format('d M')];
    }
}

/* ------------------------------------------------------------------ */
/* 6. COACH TYPE DISTRIBUTION (donut)                                 */
/* ------------------------------------------------------------------ */
$totalCoaches = array_sum(array_column($catStats, 'coaches'));
$donutLegends = [];
$donutCum = 0;
foreach ($categories as $key => $cat) {
    $count = $catStats[$key]['coaches'];
    $pct = $totalCoaches > 0 ? round(($count / $totalCoaches) * 100, 1) : 0.0;
    $deg = $totalCoaches > 0 ? ($count / $totalCoaches) * 360 : 0;
    $from = $donutCum;
    $donutCum += $deg;
    $donutLegends[] = [
        'label'   => $cat['label'],
        'color'   => $cat['color'],
        'count'   => $count,
        'pct'     => $pct,
        'gradient'=> "{$from}deg {$donutCum}deg",
    ];
}
$donutGradient = 'conic-gradient(' . implode(', ', array_map(fn($l) => "{$l['color']} {$l['gradient']}", $donutLegends)) . ')';

/* ------------------------------------------------------------------ */
/* 7. TOP PERFORMING TRAINS                                           */
/* ------------------------------------------------------------------ */
$topTrains = [];
foreach ($categories as $key => $cat) {
    try {
        $st = $pdo->prepare("
            SELECT train_no,
                   COUNT(DISTINCT coach_no) AS coaches,
                   AVG(CASE WHEN score_value REGEXP '{$scoreRe}'
                       THEN CAST(score_value AS DECIMAL(8,2)) ELSE NULL END) AS avg_score
            FROM {$cat['table']}
            WHERE station_id = :sid AND report_date BETWEEN :f AND :t
            GROUP BY train_no
            HAVING avg_score IS NOT NULL
            ORDER BY avg_score DESC
            LIMIT 5
        ");
        $st->execute([':sid' => $stationId, ':f' => $rangeStart, ':t' => $rangeEnd]);
        foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $r) {
            $topTrains[] = [
                'train_no' => $r['train_no'],
                'type'     => $cat['label'],
                'color'    => $cat['color'],
                'coaches'  => intval($r['coaches']),
                'score'    => round(min(100, max(0, (floatval($r['avg_score']) / 3) * 100)), 1),
            ];
        }
    } catch (Exception $e) {}
}
usort($topTrains, fn($a, $b) => $b['score'] <=> $a['score']);
$topTrains = array_slice($topTrains, 0, 5);

/* ------------------------------------------------------------------ */
/* 8. QUALITY PARAMETER SCORES (parent parameters, 0-3 scale)         */
/* ------------------------------------------------------------------ */
$qualityParameterSources = [
    ['report' => 'mcc_normal_scorecard_report',      'sub' => 'mcc_normal_scorecard_sub_param',      'param' => 'mcc_normal_scorecard_param'],
    ['report' => 'mcc_intensive_scorecard_2_report', 'sub' => 'mcc_intensive_scorecard_2_sub_param', 'param' => 'mcc_intensive_scorecard_2_param'],
    ['report' => 'mcc_intensive_pantry_report',      'sub' => 'mcc_intensive_pantry_sub_param',      'param' => 'mcc_intensive_pantry_param'],
    ['report' => 'mcc_prt_scorecard_report',         'sub' => 'mcc_prt_scorecard_sub_param',         'param' => 'mcc_prt_scorecard_param'],
    ['report' => 'mcc_vb_scorecard_report',          'sub' => 'mcc_vb_scorecard_sub_param',          'param' => 'mcc_vb_scorecard_param'],
];
$qualityParameterTotals = [];
foreach ($qualityParameterSources as $src) {
    try {
        $st = $pdo->prepare("
            SELECT p.parameter_name,
                   SUM(CAST(r.score_value AS DECIMAL(8,2))) AS score_sum,
                   COUNT(*) AS score_count
            FROM {$src['report']} r
            JOIN {$src['sub']} sp ON sp.id = r.sub_parameter_id
            JOIN {$src['param']} p ON p.id = sp.parameter_id
            WHERE r.station_id = :sid AND r.report_date BETWEEN :f AND :t
              AND r.score_value REGEXP '^[0-3](\\.[0-9]+)?$'
            GROUP BY p.id, p.parameter_name
        ");
        $st->execute([':sid' => $stationId, ':f' => $rangeStart, ':t' => $rangeEnd]);
        foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $row) {
            $name = trim($row['parameter_name']);
            if ($name === '') continue;
            if (!isset($qualityParameterTotals[$name])) {
                $qualityParameterTotals[$name] = ['sum' => 0.0, 'count' => 0];
            }
            $qualityParameterTotals[$name]['sum']   += floatval($row['score_sum']);
            $qualityParameterTotals[$name]['count'] += intval($row['score_count']);
        }
    } catch (Exception $e) {}
}
$qualityParameters = [];
foreach ($qualityParameterTotals as $name => $t) {
    if ($t['count'] <= 0) continue;
    $pct = min(100, max(0, round(($t['sum'] / ($t['count'] * 3)) * 100, 1)));
    $qualityParameters[] = ['name' => $name, 'pct' => $pct, 'count' => $t['count']];
}
usort($qualityParameters, fn($a, $b) => $b['count'] <=> $a['count'] ?: $b['pct'] <=> $a['pct']);
$qualityParameters = array_slice($qualityParameters, 0, 6);

/* ------------------------------------------------------------------ */
/* 9. LIVE ALERTS & LOGS (latest audit activity in range)             */
/* ------------------------------------------------------------------ */
$liveAlerts = [];
foreach ($categories as $key => $cat) {
    try {
        $st = $pdo->prepare("
            SELECT train_no, MAX(created_at) AS last_ts,
                   COUNT(DISTINCT coach_no) AS coaches,
                   AVG(CASE WHEN score_value REGEXP '{$scoreRe}'
                       THEN CAST(score_value AS DECIMAL(8,2)) ELSE NULL END) AS avg_score
            FROM {$cat['table']}
            WHERE station_id = :sid AND report_date BETWEEN :f AND :t
            GROUP BY token_id, train_no
            ORDER BY last_ts DESC
            LIMIT 4
        ");
        $st->execute([':sid' => $stationId, ':f' => $rangeStart, ':t' => $rangeEnd]);
        foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $r) {
            $score = ($r['avg_score'] !== null) ? round(min(100, (floatval($r['avg_score']) / 3) * 100), 1) : 0;
            $liveAlerts[] = [
                'train_no' => $r['train_no'] ?: 'Train',
                'type'     => $cat['label'],
                'color'    => $cat['color'],
                'score'    => $score,
                'time'     => !empty($r['last_ts']) ? date('d M Y H:i', strtotime($r['last_ts'])) : date('d M Y H:i'),
            ];
        }
    } catch (Exception $e) {}
}
usort($liveAlerts, fn($a, $b) => strcmp($b['time'], $a['time']));
$liveAlerts = array_slice($liveAlerts, 0, 5);

/* Overall KPI helpers */
$avgCleaningScore = count(array_filter(array_column($catStats, 'score'))) > 0
    ? round(array_sum(array_column($catStats, 'score')) / count(array_filter(array_column($catStats, 'score'))), 1)
    : 0.0;

$pageTitle = 'MCC Command Center';
include 'header.php';
include 'sidebar.php';
?>

<link rel="stylesheet" href="css/dashboard.css">

<main class="app-main">
  <div class="mccx-shell">
    <section class="mccx-grid">

      <!-- 0. Date Range Filter -->
      <section class="mccx-filterbar mccx-card" style="grid-area:filter">
        <form method="get" class="mccx-filter-form">
          <span class="mccx-filter-title"><i class="bi bi-calendar-range"></i></span>
          <span class="mccx-filter-label">Date Range</span>
          <label class="mccx-filter-field"><span class="mccx-filter-label">From</span>
            <input type="date" name="from" value="<?= htmlspecialchars($rangeStart) ?>">
          </label>
          <label class="mccx-filter-field"><span class="mccx-filter-label">To</span>
            <input type="date" name="to" value="<?= htmlspecialchars($rangeEnd) ?>">
          </label>
          <button type="submit" class="mccx-btn-apply"><i class="bi bi-funnel-fill"></i> Apply</button>
          <span class="mccx-filter-chips">
            <a class="mccx-chip <?= ($rangeDays === 1) ? 'on' : '' ?>" href="<?= $qsToday ?>">Today</a>
            <a class="mccx-chip <?= ($rangeDays === 7 && $rangeEnd === $today->format('Y-m-d')) ? 'on' : '' ?>" href="<?= $qs7 ?>">Last 7 Days</a>
            <a class="mccx-chip <?= ($rangeDays === 30 && $rangeEnd === $today->format('Y-m-d')) ? 'on' : '' ?>" href="<?= $qs30 ?>">Last 30 Days</a>
          </span>
        </form>
      </section>

      <!-- 1. KPI Row : Normal / Intensive / Pantry / PRT / Vande Bharat -->
      <section class="mccx-kpi-row" style="grid-area:kpi">
        <?php foreach ($categories as $key => $cat):
            $stat = $catStats[$key];
            $coachDelta = $mccPctDelta($stat['coaches'], $catStatsPrev[$key]['coaches']);
            $deltaUp = $coachDelta >= 0;
        ?>
        <article class="mccx-kpi mccx-card" style="--ac:<?= $cat['color'] ?>">
          <div class="mccx-kpi-icon"><i class="bi <?= $cat['icon'] ?>"></i></div>
          <div class="mccx-kpi-body">
            <h3><?= strtoupper($cat['label']) ?></h3>
            <small>(Coaches)</small>
            <div class="mccx-kpi-value"><?= $stat['coaches'] ?></div>
          </div>
          <div class="mccx-kpi-delta">
            <span class="mccx-delta <?= $deltaUp ? 'up' : 'down' ?>"><i class="bi bi-caret-<?= $deltaUp ? 'up' : 'down' ?>-fill"></i> <?= abs($coachDelta) ?>%</span>
            <span class="mccx-vs">vs previous period</span>
          </div>
        </article>
        <?php endforeach; ?>
      </section>

      <!-- 2. Overall Score Row : Chemical / Machine / Manpower -->
      <section class="mccx-score-row" style="grid-area:score">
        <?php
        $scoreCards = [
            ['label' => 'OVERALL CHEMICAL SCORE',  'value' => $chemicalScore,  'prev' => $chemicalScorePrev,  'icon' => 'bi-eyedropper',           'cls' => 'chem',    'bar' => 'linear-gradient(90deg,#0fd68b,#22e07c)'],
            ['label' => 'OVERALL MACHINE SCORE',   'value' => $machineScore,   'prev' => $machineScorePrev,   'icon' => 'bi-gear-fill',            'cls' => 'machine', 'bar' => 'linear-gradient(90deg,#8e5cf6,#a55eea)'],
            ['label' => 'OVERALL MANPOWER SCORE',  'value' => $manpowerScore,  'prev' => $manpowerScorePrev,  'icon' => 'bi-people-fill',          'cls' => 'man',     'bar' => 'linear-gradient(90deg,#ff8a3d,#ffaa2b)'],
        ];
        foreach ($scoreCards as $sc):
            $d = $mccPctDelta($sc['value'], $sc['prev']);
            $up = $d >= 0;
        ?>
        <article class="mccx-scorecard mccx-card mccx-<?= $sc['cls'] ?>">
          <div class="mccx-score-icon"><i class="bi <?= $sc['icon'] ?>"></i></div>
          <div class="mccx-score-main">
            <h3><?= $sc['label'] ?></h3>
            <div class="mccx-score-value"><?= number_format($sc['value'], 1) ?>%</div>
            <div class="mccx-score-bar"><i style="width:<?= max(2, min(100, $sc['value'])) ?>%;background:<?= $sc['bar'] ?>"></i></div>
          </div>
          <div class="mccx-score-delta">
            <span class="mccx-delta <?= $up ? 'up' : 'down' ?>"><i class="bi bi-caret-<?= $up ? 'up' : 'down' ?>-fill"></i> <?= abs($d) ?>%</span>
            <span class="mccx-vs">vs previous period</span>
          </div>
        </article>
        <?php endforeach; ?>
      </section>

      <!-- 3. Depot Work Summary -->
      <section class="mccx-panel mccx-card" style="grid-area:depot">
        <div class="mccx-panel-head">
          <span class="mccx-panel-ico"><i class="bi bi-bar-chart-fill"></i></span>
          <h2>DEPOT WORK SUMMARY</h2>
        </div>
        <table class="mccx-depot-table">
          <thead>
            <tr><th>Operation Type</th><th>Trains</th><th>Rakes</th><th>Coaches</th><th>Performance</th></tr>
          </thead>
          <tbody>
            <?php foreach ($categories as $key => $cat):
                $s = $catStats[$key];
            ?>
            <tr>
              <td><span class="mccx-type-dot" style="background:<?= $cat['color'] ?>"></span><?= $cat['label'] ?></td>
              <td><?= $s['trains'] ?></td>
              <td><?= $s['rakes'] ?></td>
              <td><?= $s['coaches'] ?></td>
              <td class="mccx-perf">
                <span class="mccx-perf-bar"><i style="width:<?= max(2, $s['score']) ?>%;background:<?= $cat['color'] ?>"></i></span>
                <b><?= number_format($s['score'], 1) ?>%</b>
              </td>
            </tr>
            <?php endforeach; ?>
            <tr class="mccx-total-row">
              <?php $tt = array_sum(array_column($catStats, 'trains')); $tr = array_sum(array_column($catStats, 'rakes')); ?>
              <td><span class="mccx-type-dot" style="background:#2f8bff"></span>Total</td>
              <td><?= $tt ?></td>
              <td><?= $tr ?></td>
              <td><?= $totalCoaches ?></td>
              <td class="mccx-perf">
                <span class="mccx-perf-bar"><i style="width:<?= max(2, $avgCleaningScore) ?>%;background:linear-gradient(90deg,#0fd68b,#22e07c)"></i></span>
                <b><?= number_format($avgCleaningScore, 1) ?>%</b>
              </td>
            </tr>
          </tbody>
        </table>
      </section>

      <!-- 4. Cleaning Score Trend -->
      <section class="mccx-panel mccx-card" style="grid-area:trend">
        <div class="mccx-panel-head">
          <span class="mccx-panel-ico"><i class="bi bi-graph-up"></i></span>
          <h2>CLEANING SCORE TREND</h2>
          <span class="mccx-range-chip"><?= $rangeDays === 1 ? 'Today' : 'Last ' . $rangeDays . ' Days' ?> <i class="bi bi-chevron-down"></i></span>
        </div>
        <div class="mccx-trend-wrap">
          <svg viewBox="0 0 560 190" preserveAspectRatio="none" class="mccx-trend-svg">
            <defs>
              <linearGradient id="mccxArea" x1="0" y1="0" x2="0" y2="1">
                <stop offset="0" stop-color="#10caff" stop-opacity=".18"/>
                <stop offset="1" stop-color="#10caff" stop-opacity="0"/>
              </linearGradient>
            </defs>
            <g class="mccx-gridlines">
              <path d="M36 152 H548 M36 117.5 H548 M36 83 H548 M36 48.5 H548 M36 14 H548"/>
            </g>
            <g class="mccx-ylabels">
              <text x="30" y="155">0%</text><text x="30" y="120">25%</text><text x="30" y="86">50%</text><text x="30" y="51">75%</text><text x="27" y="17">100%</text>
            </g>
            <?php if ($trendLines['normal']): ?>
            <polygon fill="url(#mccxArea)" points="<?= htmlspecialchars($trendLines['normal']) ?> 548,152 36,152"/>
            <?php endif; ?>
            <?php foreach ($trendLines as $key => $pts): if ($pts === '') continue; ?>
            <polyline class="mccx-line" style="stroke:<?= $categories[$key]['color'] ?>" points="<?= htmlspecialchars($pts) ?>"/>
            <?php endforeach; ?>
            <?php foreach ($trendDots as $key => $dots): foreach ($dots as $dot): ?>
            <circle class="mccx-dotp" style="fill:<?= $categories[$key]['color'] ?>" cx="<?= $dot['x'] ?>" cy="<?= $dot['y'] ?>" r="3.2">
              <title><?= htmlspecialchars($categories[$key]['label']) ?>: <?= $dot['v'] ?>%</title>
            </circle>
            <?php endforeach; endforeach; ?>
            <?php foreach ($trendLabels as $lbl): ?>
            <text class="mccx-xlabel" x="<?= $lbl['x'] ?>" y="176" text-anchor="middle"><?= htmlspecialchars($lbl['text']) ?></text>
            <?php endforeach; ?>
          </svg>
          <div class="mccx-trend-legend">
            <?php foreach ($categories as $key => $cat): ?>
            <span><i style="background:<?= $cat['color'] ?>"></i><?= $cat['short'] ?></span>
            <?php endforeach; ?>
          </div>
        </div>
      </section>

      <!-- 5. Coach Type Distribution (Donut) -->
      <section class="mccx-panel mccx-card" style="grid-area:donut">
        <div class="mccx-panel-head">
          <span class="mccx-panel-ico"><i class="bi bi-pie-chart-fill"></i></span>
          <h2>COACH TYPE DISTRIBUTION</h2>
        </div>
        <div class="mccx-donut-wrap">
          <div class="mccx-donut" style="background:<?= htmlspecialchars($donutGradient) ?>">
            <div class="mccx-donut-center">
              <strong><?= $totalCoaches ?></strong>
              <span>Coaches</span>
            </div>
          </div>
          <div class="mccx-donut-legend">
            <?php foreach ($donutLegends as $lg): ?>
            <div class="mccx-legend-row">
              <i style="background:<?= $lg['color'] ?>"></i>
              <span><?= $lg['label'] ?></span>
              <em><?= $lg['count'] ?> (<?= $lg['pct'] ?>%)</em>
            </div>
            <?php endforeach; ?>
          </div>
        </div>
      </section>

      <!-- 6. Top Performing Trains -->
      <section class="mccx-panel mccx-card" style="grid-area:trains">
        <div class="mccx-panel-head">
          <span class="mccx-panel-ico"><i class="bi bi-trophy-fill"></i></span>
          <h2>TOP PERFORMING TRAINS <small>(By Cleaning Score)</small></h2>
        </div>
        <table class="mccx-mini-table">
          <thead>
            <tr><th>#</th><th>Train No.</th><th>Operation Type</th><th>Coaches</th><th>Score</th></tr>
          </thead>
          <tbody>
            <?php if (empty($topTrains)): ?>
            <tr><td colspan="5" class="mccx-empty-row">No train scores recorded for this period.</td></tr>
            <?php else: $rank = 0; foreach ($topTrains as $tr): $rank++; ?>
            <tr>
              <td><?= $rank ?></td>
              <td><strong><?= htmlspecialchars($tr['train_no']) ?></strong></td>
              <td><span class="mccx-type-dot" style="background:<?= $tr['color'] ?>"></span><?= htmlspecialchars($tr['type']) ?></td>
              <td><?= $tr['coaches'] ?></td>
              <td class="mccx-score-cell"><?= number_format($tr['score'], 1) ?>%</td>
            </tr>
            <?php endforeach; endif; ?>
          </tbody>
        </table>
      </section>

      <!-- 7. Quality Parameter Scores -->
      <section class="mccx-panel mccx-card" style="grid-area:quality">
        <div class="mccx-panel-head">
          <span class="mccx-panel-ico"><i class="bi bi-clipboard-check-fill"></i></span>
          <h2>QUALITY PARAMETER SCORES</h2>
        </div>
        <div class="mccx-quality-list">
          <?php if (empty($qualityParameters)): ?>
          <p class="mccx-empty-row">No quality parameter scores recorded for this period.</p>
          <?php else: foreach ($qualityParameters as $qp): ?>
          <div class="mccx-quality-row">
            <span class="mccx-quality-name"><?= htmlspecialchars($qp['name']) ?></span>
            <span class="mccx-quality-bar"><i style="width:<?= max(2, $qp['pct']) ?>%;background:linear-gradient(90deg,#0fd68b,#22e07c)"></i></span>
            <b class="mccx-score-cell"><?= number_format($qp['pct'], 1) ?>%</b>
          </div>
          <?php endforeach; endif; ?>
        </div>
      </section>

      <!-- 8. Live Alerts & Logs -->
      <section class="mccx-panel mccx-card" style="grid-area:alerts">
        <div class="mccx-panel-head">
          <span class="mccx-panel-ico"><i class="bi bi-bell-fill"></i></span>
          <h2>LIVE ALERTS &amp; LOGS</h2>
          <a class="mccx-viewall" href="normal-summary.php">View All</a>
        </div>
        <div class="mccx-alert-list">
          <?php if (empty($liveAlerts)): ?>
          <div class="mccx-alert-row">
            <span class="mccx-alert-dot" style="background:#2f8bff"></span>
            <p>System listening for new audit submissions</p>
            <time>Just now</time>
          </div>
          <?php else: foreach ($liveAlerts as $la): ?>
          <div class="mccx-alert-row">
            <span class="mccx-alert-dot" style="background:<?= $la['color'] ?>"></span>
            <p>Train <?= htmlspecialchars($la['train_no']) ?> – <?= htmlspecialchars($la['type']) ?><?= $la['score'] > 0 ? ' Completed (' . number_format($la['score'], 1) . '%)' : ' Logged' ?></p>
            <time><?= $la['time'] ?></time>
          </div>
          <?php endforeach; endif; ?>
        </div>
      </section>

      <!-- 9. Status Bar -->
      <footer class="mccx-statusbar" style="grid-area:status">
        <span class="mccx-status-left">Depot: <strong><?= htmlspecialchars($stationName) ?> Station</strong> <em>|</em> <?= htmlspecialchars($railwayName) ?></span>
        <span class="mccx-status-center">MCC – Mechanized Coach Cleaning | Clean Today, Better Tomorrow</span>
        <span class="mccx-status-right">
          <i class="bi bi-wifi"></i> Last Data Sync: <b id="mccxSyncTime"><?= date('d M Y h:i:s A') ?></b>
          <span class="mccx-online"><i></i> Online</span>
        </span>
      </footer>

    </section>
  </div>
</main>

<script>
document.addEventListener('DOMContentLoaded', function () {
    var syncEl = document.getElementById('mccxSyncTime');
    if (syncEl) {
        setInterval(function () {
            var now = new Date();
            var pad = function (v) { return String(v).padStart(2, '0'); };
            var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
            syncEl.textContent = pad(now.getDate()) + ' ' + months[now.getMonth()] + ' ' + now.getFullYear() + ' ' +
                pad(now.getHours() % 12 || 12) + ':' + pad(now.getMinutes()) + ':' + pad(now.getSeconds()) +
                ' ' + (now.getHours() >= 12 ? 'PM' : 'AM');
        }, 1000);
    }
});
</script>

<?php include 'footer.php'; ?>