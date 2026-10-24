<?php
/**
 * Database Connection Configuration
 * Handles both MySQLi and PDO database connections for the MCC application.
 */
require_once __DIR__ . '/errors.php';

// Database credentials
define('DB_HOST', '184.168.122.185');
define('DB_USER', 'mccbeatleanalyti_user');
define('DB_PASS', 'Cee;[+&e$a+9rAXe');
define('DB_NAME', 'mccbeatleanalyti_db');


//Datebase credentials for local testing
// define('DB_HOST', 'localhost');
// define('DB_USER', 'root');
// define('DB_PASS', '');    
// define('DB_NAME', 'mcc');

// -----------------------------------------------------------------------------
// 1. MySQLi Connection (Standard/Procedural & Object-Oriented support)
// -----------------------------------------------------------------------------
$conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);

// Check MySQLi Connection
if ($conn->connect_error) {
    die("Connection failed (MySQLi): " . $conn->connect_error);
}

// Set charset to utf8mb4 for unicode compatibility
$conn->set_charset("utf8mb4");

// Alias variable commonly used in standard PHP codebases
$con = $conn;

// -----------------------------------------------------------------------------
// 2. PDO Connection (Recommended for modern PHP, secure queries)
// -----------------------------------------------------------------------------
try {
    $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4";
    $options = [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES   => false,
    ];
    $pdo = new PDO($dsn, DB_USER, DB_PASS, $options);
} catch (\PDOException $e) {
    // In production, log the error message and display a generic message
    die("Connection failed (PDO): " . $e->getMessage());
}

/**
 * -----------------------------------------------------------------------------
 * 3. Train Rake Coach Order Sorting Utilities (High-Performance In-Memory Cache)
 * -----------------------------------------------------------------------------
 */

/**
 * Fetches and caches the coach display_order mapping for a given train.
 * Query runs at most ONCE per train_no per request.
 *
 * @param string $trainNo Train Number
 * @param int|null $stationId Optional station ID
 * @param PDO|null $pdo Database connection
 * @return array Associative array of [clean_coach_no => display_order]
 */
function getTrainCoachOrderMap($trainNo, $stationId = null, $pdo = null) {
    static $trainCoachCache = [];

    if (empty($trainNo)) {
        return [];
    }

    $cleanTrainNo = strtoupper(trim((string)$trainNo));
    $cacheKey = $cleanTrainNo . '_' . ($stationId ? intval($stationId) : 'any');

    if (!isset($trainCoachCache[$cacheKey])) {
        if ($pdo === null) {
            global $pdo;
        }

        if (!$pdo) {
            return [];
        }

        try {
            $sql = "
                SELECT UPPER(TRIM(c.coach_no)) AS coach_no, c.display_order 
                FROM mcc_coaches c
                INNER JOIN mcc_trains t ON c.train_id = t.train_id
                WHERE UPPER(TRIM(t.train_no)) = :train_no
            ";
            $params = ['train_no' => $cleanTrainNo];
            if ($stationId) {
                $sql .= " AND t.station_id = :station_id";
                $params['station_id'] = intval($stationId);
            }
            $sql .= " ORDER BY c.display_order ASC, c.coach_id ASC";

            $stmt = $pdo->prepare($sql);
            $stmt->execute($params);
            $map = $stmt->fetchAll(PDO::FETCH_KEY_PAIR);

            // Fallback if not found under specific station: search globally across stations
            if (empty($map) && $stationId) {
                $stmtFallback = $pdo->prepare("
                    SELECT UPPER(TRIM(c.coach_no)) AS coach_no, c.display_order 
                    FROM mcc_coaches c
                    INNER JOIN mcc_trains t ON c.train_id = t.train_id
                    WHERE UPPER(TRIM(t.train_no)) = :train_no
                    ORDER BY c.display_order ASC, c.coach_id ASC
                ");
                $stmtFallback->execute(['train_no' => $cleanTrainNo]);
                $map = $stmtFallback->fetchAll(PDO::FETCH_KEY_PAIR);
            }

            $trainCoachCache[$cacheKey] = $map ?: [];
        } catch (Exception $e) {
            $trainCoachCache[$cacheKey] = [];
        }
    }

    return $trainCoachCache[$cacheKey];
}

/**
 * Sorts an array of coaches or scorecard rows according to the train's registered display_order.
 * Preserves unmapped coaches at the end in stable order.
 *
 * @param array $coaches List of coach numbers (strings) or associative arrays with 'coach_no'
 * @param string $trainNo Train Number
 * @param int|null $stationId Optional station ID
 * @param PDO|null $pdo Database connection
 * @return array Sorted array
 */
function sortCoachesByRakeOrder($coaches, $trainNo, $stationId = null, $pdo = null) {
    if (empty($coaches) || !is_array($coaches)) {
        return $coaches;
    }

    $orderMap = getTrainCoachOrderMap($trainNo, $stationId, $pdo);
    if (empty($orderMap)) {
        return array_values($coaches);
    }

    $sample = reset($coaches);
    $isAssociative = is_array($sample) && isset($sample['coach_no']);
    $isObject = is_object($sample) && isset($sample->coach_no);

    $items = [];
    $idx = 0;
    foreach ($coaches as $item) {
        if ($isAssociative) {
            $cNo = $item['coach_no'] ?? '';
        } elseif ($isObject) {
            $cNo = $item->coach_no ?? '';
        } else {
            $cNo = $item;
        }

        $cleanCNo = strtoupper(trim((string)$cNo));
        $ord = $orderMap[$cleanCNo] ?? null;

        // Strip any bracketed duplicate suffix like "B1 (2)" -> "B1" if exact match fails
        if ($ord === null && preg_match('/^([^\(]+)/', $cleanCNo, $m)) {
            $baseCNo = trim($m[1]);
            $ord = $orderMap[$baseCNo] ?? null;
        }

        $items[] = [
            'item' => $item,
            'orig_idx' => $idx++,
            'order' => ($ord !== null) ? intval($ord) : (100000 + $idx)
        ];
    }

    usort($items, function($a, $b) {
        if ($a['order'] === $b['order']) {
            return $a['orig_idx'] <=> $b['orig_idx'];
        }
        return $a['order'] <=> $b['order'];
    });

    return array_column($items, 'item');
}
?>
