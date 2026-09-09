<?php
/**
 * Railway Operating Day Date Helper
 *
 * In Indian Railways, a single working/operational day runs from 06:00:00 AM on Day D to 05:59:59 AM on Day D+1.
 * - 06:00:00 AM to 11:59:59 PM: Saved under current date (Day D).
 * - 12:00:00 AM to 05:59:59 AM: Saved under previous date (Day D - 1).
 */

if (!function_exists('getRailwayOperatingDate')) {
    /**
     * Calculates the railway operating date based on the 6:00 AM boundary.
     *
     * @param string|null $explicitDate Optional override date from client payload (Y-m-d).
     * @param string $timezone Timezone string (default: 'Asia/Kolkata').
     * @return string Formatted date string (Y-m-d).
     */
    function getRailwayOperatingDate(?string $explicitDate = null, string $timezone = 'Asia/Kolkata'): string {
        // If explicit date is passed and not empty, prioritize it if valid
        if (!empty($explicitDate)) {
            $trimmed = trim($explicitDate);
            if (preg_match('/^\d{4}-\d{2}-\d{2}$/', $trimmed)) {
                return $trimmed;
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
