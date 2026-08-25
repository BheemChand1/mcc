<?php
/**
 * MCC - Admin Panel User Impersonation Utility
 * Logs the administrator directly into the selected user's profile in a new session tab.
 */
if (session_status() === PHP_SESSION_NONE) {
    session_name('MCC_ADMIN_SESS');
    session_start();
}
require_once '../connection.php';

// Validate that the request originates from an active administrator session
if (!isset($_SESSION['user_id']) || $_SESSION['role'] !== 'ADMIN') {
    header("Location: login.php");
    exit();
}

$target_user_id = intval($_GET['user_id'] ?? 0);
if ($target_user_id <= 0) {
    die("Error: Invalid target user reference.");
}

try {
    // Fetch active target user profile
    $stmt = $pdo->prepare("SELECT * FROM mcc_users WHERE user_id = :id AND status = 'Active'");
    $stmt->execute(['id' => $target_user_id]);
    $user = $stmt->fetch();
    
    if (!$user) {
        die("Error: Target user account not found or is currently suspended.");
    }
    
    // Close the admin session without destroying it (preserving the admin's tab session)
    session_write_close();
    
    // Switch session namespace to the default dashboard session cookie
    session_name('PHPSESSID');
    
    // Explicitly isolate the session ID to prevent PHP from reusing the admin session ID file!
    if (isset($_COOKIE['PHPSESSID']) && preg_match('/^[a-zA-Z0-9,-]{22,40}$/', $_COOKIE['PHPSESSID'])) {
        session_id($_COOKIE['PHPSESSID']);
    } else {
        session_id(bin2hex(random_bytes(16))); // Generate a new valid secure alphanumeric ID
    }
    
    session_start();
    
    // Set target user profile context in the default session
    $_SESSION['user_id'] = $user['user_id'];
    $_SESSION['username'] = $user['username'];
    $_SESSION['user_name'] = $user['user_name'];
    $_SESSION['role'] = $user['role'];
    $_SESSION['station_id'] = $user['station_id'];
    
    // Redirect target to appropriate dashboard
    if ($user['role'] === 'ADMIN') {
        header("Location: index.php");
    } else {
        header("Location: ../cdo-dashboard/index.php");
    }
    exit();
} catch (PDOException $e) {
    die("Database transaction failure: " . $e->getMessage());
}
?>
