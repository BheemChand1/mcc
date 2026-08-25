<?php
/**
 * MCC - Admin Panel Logout
 * Clears session variables and redirects to the login screen.
 */
session_name('MCC_ADMIN_SESS');
session_start();
$_SESSION = array();

// If session cookie is set, invalidate it
if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000,
        $params["path"], $params["domain"],
        $params["secure"], $params["httponly"]
    );
}

// Destroy session
session_destroy();

// Redirect back to Admin Login
header("Location: login.php");
exit();
?>
