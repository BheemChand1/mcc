<?php
/**
 * Database Connection Configuration
 * Handles both MySQLi and PDO database connections for the MCC application.
 */

// Database credentials
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'mcc');

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
?>
