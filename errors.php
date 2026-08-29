<?php
/**
 * Error Reporting Configuration
 * Set DEVELOPMENT_MODE to false in production to turn off all error reporting.
 */
define('DEVELOPMENT_MODE', true);

if (DEVELOPMENT_MODE) {
    ini_set('display_errors', '1');
    ini_set('display_startup_errors', '1');
    error_reporting(E_ALL);
} else {
    ini_set('display_errors', '0');
    ini_set('display_startup_errors', '0');
    error_reporting(0);
}
?>
