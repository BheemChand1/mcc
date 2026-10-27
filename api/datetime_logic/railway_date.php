<?php
/**
 * Railway Operating Day Date Helper
 *
 * In Indian Railways, a single working/operational day runs from 06:00:00 AM on Day D to 05:59:59 AM on Day D+1.
 * - 06:00:00 AM to 11:59:59 PM: Saved under current date (Day D).
 * - 12:00:00 AM to 05:59:59 AM: Saved under previous date (Day D - 1).
 */

if (!function_exists('normalizeDateToYmd')) {
    /**
     * Parses and normalizes various date string formats to Y-m-d (MySQL DATE).
     * Supports d-m-Y, d/m/Y, Y-m-d, Y/m/d, and standard date strings.
     */
    function normalizeDateToYmd(?string $dateStr): ?string {
        if (empty($dateStr)) {
            return null;
        }
        $trimmed = trim($dateStr);

        // Check YYYY-MM-DD or YYYY/MM/DD
        if (preg_match('/^(\d{4})[-\/](\d{1,2})[-\/](\d{1,2})$/', $trimmed, $m)) {
            if (checkdate((int)$m[2], (int)$m[3], (int)$m[1])) {
                return sprintf('%04d-%02d-%02d', $m[1], $m[2], $m[3]);
            }
        }

        // Check DD-MM-YYYY or DD/MM/YYYY
        if (preg_match('/^(\d{1,2})[-\/](\d{1,2})[-\/](\d{4})$/', $trimmed, $m)) {
            if (checkdate((int)$m[2], (int)$m[1], (int)$m[3])) {
                return sprintf('%04d-%02d-%02d', $m[3], $m[2], $m[1]);
            }
        }

        // General fallback with strtotime
        $ts = strtotime($trimmed);
        if ($ts !== false && $ts > 0) {
            return date('Y-m-d', $ts);
        }

        return null;
    }
}

if (!function_exists('getRailwayOperatingDate')) {
    /**
     * Calculates the railway operating date based on the 6:00 AM boundary.
     * If an explicit date is provided (e.g. '28-10-2026' or '2026-10-28'), it is parsed and normalized to Y-m-d.
     *
     * @param string|null $explicitDate Optional override date from client payload.
     * @param string $timezone Timezone string (default: 'Asia/Kolkata').
     * @return string Formatted date string (Y-m-d).
     */
    function getRailwayOperatingDate(?string $explicitDate = null, string $timezone = 'Asia/Kolkata'): string {
        // If explicit date is passed and not empty, prioritize it if valid
        if (!empty($explicitDate)) {
            $normalized = normalizeDateToYmd($explicitDate);
            if ($normalized !== null) {
                return $normalized;
            }
        }

        try {
            $tz = new DateTimeZone($timezone);
            $now = new DateTime('now', $tz);
        } catch (Exception $e) {
            $now = new DateTime('now', new DateTimeZone('Asia/Kolkata'));
        }

        $hour = (int)$now->format('G'); // 0 to 23

        // If time is between 12:00:00 AM (00:00) and 05:59:59 AM, attribute to previous day
        if ($hour < 6) {
            return $now->modify('-1 day')->format('Y-m-d');
        }

        return $now->format('Y-m-d');
    }
}

if (!function_exists('getReportCreatedAt')) {
    /**
     * Returns the created_at timestamp string (Y-m-d H:i:s).
     * Combines the report date (explicit date or current railway operating date)
     * with the current time (H:i:s) in Asia/Kolkata.
     *
     * @param string|null $explicitDate Optional override date from client payload.
     * @param string $timezone Timezone string (default: 'Asia/Kolkata').
     * @return string Formatted datetime string (Y-m-d H:i:s).
     */
    function getReportCreatedAt(?string $explicitDate = null, string $timezone = 'Asia/Kolkata'): string {
        try {
            $tz = new DateTimeZone($timezone);
            $now = new DateTime('now', $tz);
        } catch (Exception $e) {
            $tz = new DateTimeZone('Asia/Kolkata');
            $now = new DateTime('now', $tz);
        }

        $currentTime = $now->format('H:i:s');
        $datePart = getRailwayOperatingDate($explicitDate, $timezone);

        return $datePart . ' ' . $currentTime;
    }
}
