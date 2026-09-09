-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 09, 2026 at 01:10 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mcc`
--

-- --------------------------------------------------------

--
-- Table structure for table `app_version`
--

CREATE TABLE `app_version` (
  `id` int(11) NOT NULL,
  `version` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `app_version`
--

INSERT INTO `app_version` (`id`, `version`, `created_at`, `updated_at`) VALUES
(1, '1.0.0', '2026-09-04 15:27:57', '2026-09-04 15:27:57');

-- --------------------------------------------------------

--
-- Table structure for table `attendance_logs`
--

CREATE TABLE `attendance_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_code` varchar(50) NOT NULL,
  `employee_name` varchar(100) DEFAULT NULL,
  `punch_time` datetime NOT NULL,
  `direction` varchar(10) DEFAULT NULL,
  `device_id` varchar(100) DEFAULT NULL,
  `serial_number` varchar(100) DEFAULT NULL,
  `verification_mode` varchar(50) DEFAULT NULL,
  `device_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance_logs`
--

INSERT INTO `attendance_logs` (`id`, `employee_code`, `employee_name`, `punch_time`, `direction`, `device_id`, `serial_number`, `verification_mode`, `device_name`, `created_at`) VALUES
(20, 'smc-123', 'Bheem Chand', '2026-09-09 16:25:34', '0', NULL, NULL, '1', 'cleanliness', '2026-09-09 10:57:43'),
(21, 'smc-123', 'Bheem Chand', '2026-09-09 22:25:34', '1', NULL, NULL, '1', 'cleanliness', '2026-09-09 10:57:43'),
(22, 'smc-132', 'Akhil', '2026-09-09 16:25:34', '0', NULL, NULL, '1', 'depot', '2026-09-09 10:57:43'),
(23, 'smc-132', 'Akhil', '2026-09-09 22:25:34', '1', NULL, NULL, '1', 'depot', '2026-09-09 10:57:43');

-- --------------------------------------------------------

--
-- Table structure for table `dc_mcc_chemical_param`
--

CREATE TABLE `dc_mcc_chemical_param` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `units` varchar(100) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dc_mcc_chemical_param`
--

INSERT INTO `dc_mcc_chemical_param` (`id`, `name`, `units`, `station_id`, `created_at`, `updated_at`) VALUES
(1, 'Spiral R7 floor cleaner', 'ml', 1, '2026-06-06 11:13:48', '2026-08-31 12:03:03'),
(2, 'Taski R6 ceramic toilet cleaner', 'ml', 1, '2026-06-06 11:13:48', '2026-08-31 12:03:11'),
(3, 'Disinfectant', 'ml', 1, '2026-06-06 11:13:48', '2026-08-31 12:03:18'),
(4, 'Bleaching powder', 'kg', 1, '2026-06-06 11:13:48', '2026-08-31 12:03:26'),
(5, 'Naphthalene balls', 'kg', 1, '2026-06-06 11:13:48', '2026-08-31 12:03:33'),
(6, 'Odonil', 'units', 1, '2026-06-06 11:13:48', '2026-08-31 12:03:41');

-- --------------------------------------------------------

--
-- Table structure for table `dc_mcc_chemical_report`
--

CREATE TABLE `dc_mcc_chemical_report` (
  `id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `qty_used` decimal(10,2) DEFAULT NULL,
  `auditor_name` varchar(255) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `token_id` varchar(100) NOT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dc_mcc_chemical_report`
--

INSERT INTO `dc_mcc_chemical_report` (`id`, `parameter_id`, `shift_id`, `qty_used`, `auditor_name`, `station_id`, `token_id`, `report_date`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 50.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:01', '2026-09-07 14:40:01'),
(2, 2, 1, 40.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:01', '2026-09-07 14:40:01'),
(3, 3, 1, 30.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:01', '2026-09-07 14:40:01'),
(4, 4, 1, 40.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:01', '2026-09-07 14:40:01'),
(5, 5, 1, 40.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:01', '2026-09-07 14:40:01'),
(6, 6, 1, 50.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:01', '2026-09-07 14:40:01'),
(7, 1, 2, 50.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:17', '2026-09-07 14:40:17'),
(8, 2, 2, 30.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:17', '2026-09-07 14:40:17'),
(9, 3, 2, 30.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:17', '2026-09-07 14:40:17'),
(10, 4, 2, 40.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:17', '2026-09-07 14:40:17'),
(11, 5, 2, 40.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:17', '2026-09-07 14:40:17'),
(12, 6, 2, 50.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:17', '2026-09-07 14:40:17'),
(13, 1, 3, 10.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:53', '2026-09-07 14:40:53'),
(14, 2, 3, 10.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:53', '2026-09-07 14:40:53'),
(15, 3, 3, 30.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:53', '2026-09-07 14:40:53'),
(16, 4, 3, 40.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:53', '2026-09-07 14:40:53'),
(17, 5, 3, 40.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:53', '2026-09-07 14:40:53'),
(18, 6, 3, 50.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:53', '2026-09-07 14:40:53');

-- --------------------------------------------------------

--
-- Table structure for table `dc_mcc_chemical_shifts`
--

CREATE TABLE `dc_mcc_chemical_shifts` (
  `id` int(11) NOT NULL,
  `shift` varchar(100) NOT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dc_mcc_chemical_shifts`
--

INSERT INTO `dc_mcc_chemical_shifts` (`id`, `shift`, `station_id`, `created_at`, `updated_at`) VALUES
(1, 'Shift 1', 1, '2026-06-06 11:13:48', '2026-06-06 11:13:48'),
(2, 'Shift 2', 1, '2026-06-06 11:13:48', '2026-06-06 11:13:48'),
(3, 'Shift 3', 1, '2026-06-06 11:13:48', '2026-06-06 11:13:48');

-- --------------------------------------------------------

--
-- Table structure for table `dc_mcc_chemical_target`
--

CREATE TABLE `dc_mcc_chemical_target` (
  `id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `target_month` date NOT NULL,
  `qty(ml)` decimal(10,2) DEFAULT NULL,
  `penalty` decimal(10,2) DEFAULT NULL,
  `penalty_qty(ml)` decimal(10,2) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dc_mcc_chemical_target`
--

INSERT INTO `dc_mcc_chemical_target` (`id`, `parameter_id`, `target_month`, `qty(ml)`, `penalty`, `penalty_qty(ml)`, `station_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2026-09-01', 50.00, 500.00, 10.00, 1, '2026-09-07 14:35:18', '2026-09-07 14:35:18'),
(2, 2, '2026-09-01', 40.00, 500.00, 10.00, 1, '2026-09-07 14:35:18', '2026-09-07 14:35:18'),
(3, 3, '2026-09-01', 30.00, 500.00, 10.00, 1, '2026-09-07 14:35:18', '2026-09-07 14:35:18'),
(4, 4, '2026-09-01', 40.00, 500.00, 10.00, 1, '2026-09-07 14:35:18', '2026-09-07 14:35:18'),
(5, 5, '2026-09-01', 40.00, 500.00, 10.00, 1, '2026-09-07 14:35:18', '2026-09-07 14:35:18'),
(6, 6, '2026-09-01', 50.00, 500.00, 10.00, 1, '2026-09-07 14:35:18', '2026-09-07 14:35:18');

-- --------------------------------------------------------

--
-- Table structure for table `dc_mcc_machine_param`
--

CREATE TABLE `dc_mcc_machine_param` (
  `id` int(11) NOT NULL,
  `machine_no` varchar(100) NOT NULL,
  `machine_name` varchar(255) NOT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dc_mcc_machine_param`
--

INSERT INTO `dc_mcc_machine_param` (`id`, `machine_no`, `machine_name`, `station_id`, `created_at`, `updated_at`) VALUES
(1, 'NBMD', 'Nylon brush multi disc heavy duty floor scrubber (Karcher BD 50/50 C Bp Classic)', 1, '2026-06-08 12:11:51', '2026-06-08 12:11:51'),
(2, 'GCM', 'Grass cutting machine (Honda Brush Cutter and Accessories (UMK435T U2NT 11900 W))', 1, '2026-06-08 12:11:51', '2026-06-08 12:11:51');

-- --------------------------------------------------------

--
-- Table structure for table `dc_mcc_machine_report`
--

CREATE TABLE `dc_mcc_machine_report` (
  `id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `used_status` varchar(50) DEFAULT NULL,
  `token_id` varchar(100) NOT NULL,
  `auditor_name` varchar(150) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dc_mcc_machine_report`
--

INSERT INTO `dc_mcc_machine_report` (`id`, `parameter_id`, `shift_id`, `used_status`, `token_id`, `auditor_name`, `station_id`, `report_date`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Y', 'TKN-DC-MCH-20260907-1-6003', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:41:16', '2026-09-07 14:41:16'),
(2, 2, 1, 'N', 'TKN-DC-MCH-20260907-1-6003', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:41:16', '2026-09-07 14:41:16'),
(3, 1, 2, 'Y', 'TKN-DC-MCH-20260907-2-2816', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:41:49', '2026-09-07 14:41:49'),
(4, 2, 2, 'Y', 'TKN-DC-MCH-20260907-2-2816', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:41:49', '2026-09-07 14:41:49'),
(5, 1, 3, 'Y', 'TKN-DC-MCH-20260907-3-7067', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:41:53', '2026-09-07 14:41:53'),
(6, 2, 3, 'Y', 'TKN-DC-MCH-20260907-3-7067', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:41:53', '2026-09-07 14:41:53');

-- --------------------------------------------------------

--
-- Table structure for table `dc_mcc_machine_shifts`
--

CREATE TABLE `dc_mcc_machine_shifts` (
  `id` int(11) NOT NULL,
  `shift` varchar(100) NOT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dc_mcc_machine_shifts`
--

INSERT INTO `dc_mcc_machine_shifts` (`id`, `shift`, `station_id`, `created_at`, `updated_at`) VALUES
(1, 'Shift 1', 1, '2026-06-08 12:11:51', '2026-06-08 12:11:51'),
(2, 'Shift 2', 1, '2026-06-08 12:11:51', '2026-06-08 12:11:51'),
(3, 'Shift 3', 1, '2026-06-08 12:11:51', '2026-06-08 12:11:51');

-- --------------------------------------------------------

--
-- Table structure for table `dc_mcc_machine_target`
--

CREATE TABLE `dc_mcc_machine_target` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `machine_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `nominated_area` varchar(50) DEFAULT NULL,
  `penalty_amount` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `effective_from` date NOT NULL DEFAULT curdate(),
  `effective_to` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dc_mcc_machine_target`
--

INSERT INTO `dc_mcc_machine_target` (`id`, `station_id`, `machine_id`, `shift_id`, `nominated_area`, `penalty_amount`, `created_at`, `updated_at`, `effective_from`, `effective_to`) VALUES
(1, 1, 1, 1, 'Y', 500.00, '2026-09-07 14:38:50', '2026-09-07 14:38:50', '2026-09-01', NULL),
(2, 1, 1, 2, 'Y', 500.00, '2026-09-07 14:38:50', '2026-09-07 14:38:50', '2026-09-01', NULL),
(3, 1, 1, 3, 'Y', 500.00, '2026-09-07 14:38:50', '2026-09-07 14:38:50', '2026-09-01', NULL),
(4, 1, 2, 1, 'Y', 500.00, '2026-09-07 14:38:50', '2026-09-07 14:38:50', '2026-09-01', NULL),
(5, 1, 2, 2, 'Y', 500.00, '2026-09-07 14:38:50', '2026-09-07 14:38:50', '2026-09-01', NULL),
(6, 1, 2, 3, 'Y', 500.00, '2026-09-07 14:38:50', '2026-09-07 14:38:50', '2026-09-01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `dc_mcc_param`
--

CREATE TABLE `dc_mcc_param` (
  `id` int(11) NOT NULL,
  `parameter_name` varchar(255) NOT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dc_mcc_param`
--

INSERT INTO `dc_mcc_param` (`id`, `parameter_name`, `station_id`, `created_at`, `updated_at`) VALUES
(11, 'Cleaning of office premises', 1, '2026-08-29 06:32:14', '2026-08-29 06:32:14'),
(12, 'Cleaning of IOH Sheds/Sick lines', 1, '2026-08-29 06:32:14', '2026-08-29 06:32:14'),
(13, 'Cleaning of Catwalks and Aprons', 1, '2026-08-29 06:32:14', '2026-08-29 06:32:14'),
(14, 'Cleaning & De-silting of Pits', 1, '2026-08-29 06:32:14', '2026-08-29 06:32:14'),
(15, 'Cleaning of Toilets, Bathrooms.', 1, '2026-08-29 06:32:15', '2026-08-29 06:32:15'),
(16, 'Cleaning of Drains inside the depots', 1, '2026-08-29 06:32:15', '2026-08-29 06:32:15'),
(17, 'Cleaning of Pathways', 1, '2026-08-29 06:32:15', '2026-08-29 06:32:15'),
(18, 'Disposal of Scraps to nominated Places', 1, '2026-08-29 06:32:15', '2026-08-29 06:32:15'),
(19, 'Disposal of garbage at nominated Places', 1, '2026-08-29 06:32:16', '2026-08-29 06:32:16');

-- --------------------------------------------------------

--
-- Table structure for table `dc_mcc_rating`
--

CREATE TABLE `dc_mcc_rating` (
  `id` int(11) NOT NULL,
  `rating_name` varchar(50) NOT NULL,
  `rating_value` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dc_mcc_rating`
--

INSERT INTO `dc_mcc_rating` (`id`, `rating_name`, `rating_value`, `created_at`) VALUES
(1, 'Very Good', '3', '2026-08-29 06:58:55'),
(2, 'Satisfactory', '2', '2026-08-29 06:58:55'),
(3, 'Poor', '1', '2026-08-29 06:58:55'),
(4, 'Not attended', '0', '2026-08-29 06:58:55');

-- --------------------------------------------------------

--
-- Table structure for table `dc_mcc_report`
--

CREATE TABLE `dc_mcc_report` (
  `id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `rating` int(11) DEFAULT NULL,
  `token_id` varchar(100) NOT NULL,
  `station_id` int(11) NOT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `auditor_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dc_mcc_report`
--

INSERT INTO `dc_mcc_report` (`id`, `parameter_id`, `shift_id`, `rating`, `token_id`, `station_id`, `report_date`, `created_at`, `updated_at`, `auditor_name`) VALUES
(1, 11, 1, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:27', '2026-09-07 14:39:27', 'Bheem Chand'),
(2, 12, 1, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:27', '2026-09-07 14:39:27', 'Bheem Chand'),
(3, 13, 1, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:27', '2026-09-07 14:39:27', 'Bheem Chand'),
(4, 14, 1, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:27', '2026-09-07 14:39:27', 'Bheem Chand'),
(5, 15, 1, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:27', '2026-09-07 14:39:27', 'Bheem Chand'),
(6, 16, 1, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:27', '2026-09-07 14:39:27', 'Bheem Chand'),
(7, 17, 1, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:27', '2026-09-07 14:39:27', 'Bheem Chand'),
(8, 18, 1, 1, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:27', '2026-09-07 14:39:27', 'Bheem Chand'),
(9, 19, 1, 2, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:27', '2026-09-07 14:39:27', 'Bheem Chand'),
(10, 11, 2, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:39', '2026-09-07 14:39:39', 'Bheem Chand'),
(11, 12, 2, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:39', '2026-09-07 14:39:39', 'Bheem Chand'),
(12, 13, 2, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:39', '2026-09-07 14:39:39', 'Bheem Chand'),
(13, 14, 2, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:39', '2026-09-07 14:39:39', 'Bheem Chand'),
(14, 15, 2, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:39', '2026-09-07 14:39:39', 'Bheem Chand'),
(15, 16, 2, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:39', '2026-09-07 14:39:39', 'Bheem Chand'),
(16, 17, 2, 2, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:39', '2026-09-07 14:39:39', 'Bheem Chand'),
(17, 18, 2, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:39', '2026-09-07 14:39:39', 'Bheem Chand'),
(18, 19, 2, 1, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:39', '2026-09-07 14:39:39', 'Bheem Chand'),
(19, 11, 1, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:45', '2026-09-08 13:16:45', 'Bheem Chand'),
(20, 12, 1, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:45', '2026-09-08 13:16:45', 'Bheem Chand'),
(21, 13, 1, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:45', '2026-09-08 13:16:45', 'Bheem Chand'),
(22, 14, 1, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:45', '2026-09-08 13:16:45', 'Bheem Chand'),
(23, 15, 1, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:45', '2026-09-08 13:16:45', 'Bheem Chand'),
(24, 16, 1, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:45', '2026-09-08 13:16:45', 'Bheem Chand'),
(25, 17, 1, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:45', '2026-09-08 13:16:45', 'Bheem Chand'),
(26, 18, 1, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:45', '2026-09-08 13:16:45', 'Bheem Chand'),
(27, 19, 1, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:45', '2026-09-08 13:16:45', 'Bheem Chand'),
(28, 11, 2, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:51', '2026-09-08 13:16:51', 'Bheem Chand'),
(29, 12, 2, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:51', '2026-09-08 13:16:51', 'Bheem Chand'),
(30, 13, 2, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:51', '2026-09-08 13:16:51', 'Bheem Chand'),
(31, 14, 2, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:51', '2026-09-08 13:16:51', 'Bheem Chand'),
(32, 15, 2, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:51', '2026-09-08 13:16:51', 'Bheem Chand'),
(33, 16, 2, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:51', '2026-09-08 13:16:51', 'Bheem Chand'),
(34, 17, 2, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:51', '2026-09-08 13:16:51', 'Bheem Chand'),
(35, 18, 2, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:51', '2026-09-08 13:16:51', 'Bheem Chand'),
(36, 19, 2, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:51', '2026-09-08 13:16:51', 'Bheem Chand');

-- --------------------------------------------------------

--
-- Table structure for table `dc_mcc_shifts`
--

CREATE TABLE `dc_mcc_shifts` (
  `id` int(11) NOT NULL,
  `shift` varchar(100) NOT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dc_mcc_shifts`
--

INSERT INTO `dc_mcc_shifts` (`id`, `shift`, `station_id`, `created_at`, `updated_at`) VALUES
(1, 'Score on First Check (11:00 hrs)', 1, '2026-05-30 08:53:53', '2026-08-29 06:27:49'),
(2, 'Score on 2nd\nCheck (16:00 hrs)', 1, '2026-05-30 08:53:53', '2026-08-29 06:29:01');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_billing_conditions`
--

CREATE TABLE `mcc_billing_conditions` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `min_score` decimal(5,2) NOT NULL,
  `max_score` decimal(5,2) NOT NULL,
  `deduction_percentage` decimal(5,2) NOT NULL,
  `description` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_billing_conditions`
--

INSERT INTO `mcc_billing_conditions` (`id`, `station_id`, `min_score`, `max_score`, `deduction_percentage`, `description`, `is_active`, `created_at`) VALUES
(2, 1, 0.00, 50.00, 100.00, 'poor', 1, '2026-07-14 11:20:40');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_billing_earnings`
--

CREATE TABLE `mcc_billing_earnings` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `earning_name` varchar(255) NOT NULL,
  `score_type` varchar(255) NOT NULL,
  `weightage` decimal(5,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_billing_earnings`
--

INSERT INTO `mcc_billing_earnings` (`id`, `station_id`, `earning_name`, `score_type`, `weightage`, `created_at`) VALUES
(6, 2, 'Attendance records of the staff (staff and supervisor)', 'attendance', 25.00, '2026-07-11 08:26:54'),
(7, 2, 'Cleanliness record', 'cleanliness', 20.00, '2026-07-11 08:26:54'),
(8, 2, 'Use of type and quantity of consumables and machinery', 'consumables_machinery', 15.00, '2026-07-11 08:26:54'),
(9, 2, 'Surprise visits conducted by officials of Indian Railways', 'surprise_visits', 10.00, '2026-07-11 08:26:54'),
(10, 2, 'Score card from cleaning (PF Return Trains)', 'prt_scorecard', 30.00, '2026-07-11 08:26:54'),
(11, 3, 'Attendance records of the staff (staff and supervisor)', 'attendance', 25.00, '2026-07-11 08:26:54'),
(12, 3, 'Cleanliness record', 'cleanliness', 20.00, '2026-07-11 08:26:54'),
(13, 3, 'Use of type and quantity of consumables and machinery', 'consumables_machinery', 15.00, '2026-07-11 08:26:54'),
(14, 3, 'Surprise visits conducted by officials of Indian Railways', 'surprise_visits', 10.00, '2026-07-11 08:26:54'),
(15, 3, 'Score card from cleaning (PF Return Trains)', 'prt_scorecard', 30.00, '2026-07-11 08:26:54'),
(17, 1, 'Attendance records of the staff (staff and supervisor)', 'attendance', 25.00, '2026-07-13 10:36:06'),
(18, 1, 'Cleanliness record', 'cleanliness', 20.00, '2026-07-13 11:02:29'),
(19, 1, 'Use of type and quantity of consumables and machinery', 'normal_chemical,intensive_chemical,dc_chemical,prt_chemical,normal_machine,intensive_machine,dc_machine', 15.00, '2026-07-13 11:03:32'),
(20, 1, 'Surprise visits conducted by officials of Indian Railways', 'surprise_pit_office,surprise_pf_trains', 10.00, '2026-07-13 11:04:20'),
(21, 1, 'Score card from cleaning (PF Return Trains)', 'normal_scorecard,intensive_scorecard,dc_scorecard,prt_scorecard', 30.00, '2026-07-13 11:04:58');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_billing_setup`
--

CREATE TABLE `mcc_billing_setup` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `sanctioned_amount` decimal(15,2) NOT NULL DEFAULT 1000000.00,
  `gst_percentage` decimal(5,2) NOT NULL DEFAULT 18.00,
  `contract_start_date` date NOT NULL,
  `contract_end_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `agreement_no` varchar(255) DEFAULT 'AGR-2026-99-01'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_billing_setup`
--

INSERT INTO `mcc_billing_setup` (`id`, `station_id`, `sanctioned_amount`, `gst_percentage`, `contract_start_date`, `contract_end_date`, `created_at`, `agreement_no`) VALUES
(1, 1, 1000000.00, 18.00, '2026-04-01', '2027-03-31', '2026-07-11 08:26:54', 'AGR-2026-99-01'),
(2, 2, 1000000.00, 18.00, '2026-04-01', '2027-03-31', '2026-07-11 08:26:54', 'AGR-2026-99-01'),
(3, 3, 1000000.00, 18.00, '2026-04-01', '2027-03-31', '2026-07-11 08:26:54', 'AGR-2026-99-01');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_cleanliness_report`
--

CREATE TABLE `mcc_cleanliness_report` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `report_date` date NOT NULL,
  `score` decimal(10,2) DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_cleanliness_report`
--

INSERT INTO `mcc_cleanliness_report` (`id`, `station_id`, `report_date`, `score`, `created_at`, `updated_at`) VALUES
(1, 1, '2026-07-01', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(2, 1, '2026-07-02', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(3, 1, '2026-07-03', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(4, 1, '2026-07-04', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(5, 1, '2026-07-05', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(6, 1, '2026-07-06', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(7, 1, '2026-07-07', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(8, 1, '2026-07-08', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(9, 1, '2026-07-09', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(10, 1, '2026-07-10', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(11, 1, '2026-07-11', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(12, 1, '2026-07-12', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(13, 1, '2026-07-13', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(14, 1, '2026-07-14', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(15, 1, '2026-07-15', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(16, 1, '2026-07-16', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(17, 1, '2026-07-17', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(18, 1, '2026-07-18', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(19, 1, '2026-07-19', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(20, 1, '2026-07-20', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(21, 1, '2026-07-21', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(22, 1, '2026-07-22', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(23, 1, '2026-07-23', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(24, 1, '2026-07-24', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(25, 1, '2026-07-25', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(26, 1, '2026-07-26', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(27, 1, '2026-07-27', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(28, 1, '2026-07-28', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(29, 1, '2026-07-29', 70.00, '2026-07-10 04:22:45', '2026-07-10 04:25:38'),
(30, 1, '2026-07-30', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45'),
(31, 1, '2026-07-31', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_divisions`
--

CREATE TABLE `mcc_divisions` (
  `division_id` int(11) NOT NULL,
  `division_name` varchar(120) NOT NULL,
  `zone_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_divisions`
--

INSERT INTO `mcc_divisions` (`division_id`, `division_name`, `zone_id`, `status`, `created_at`, `updated_at`) VALUES
(10, 'Mumbai', 1, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(11, 'Bhusawal', 1, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(12, 'Pune', 1, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(13, 'Nagpur', 1, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(14, 'Solapur', 1, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(17, 'Howrah', 2, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(18, 'Sealdah', 2, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(19, 'Asansol', 2, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(20, 'Malda', 2, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(24, 'Danapur', 3, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(25, 'Dhanbad', 3, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(26, 'Pandit Deen Dayal Upadhyaya', 3, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(27, 'Samastipur', 3, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(28, 'Sonpur', 3, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(31, 'Khurda Road', 4, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(32, 'Sambalpur', 4, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(33, 'Waltair', 4, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(34, 'Delhi', 5, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(35, 'Ambala', 5, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(36, 'Firozpur', 5, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(37, 'Lucknow NR', 5, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(38, 'Moradabad', 5, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(41, 'Prayagraj', 6, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(42, 'Agra', 6, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(43, 'Jhansi', 6, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(44, 'Izzatnagar', 7, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(45, 'Lucknow NER', 7, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(46, 'Varanasi', 7, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(47, 'Alipurduar', 8, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(48, 'Katihar', 8, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(49, 'LMG', 10, '', '2025-07-25 18:39:47', '2026-05-26 04:41:46'),
(50, 'Rangiya', 8, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(51, 'Tinsukia', 8, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(54, 'Jaipur', 9, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(55, 'Ajmer', 9, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(56, 'Bikaner', 9, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(57, 'Jodhpur', 9, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(61, 'Secunderabad', 10, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(62, 'Hyderabad', 10, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(63, 'Vijayawada', 10, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(64, 'Guntur', 10, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(65, 'Guntakal', 10, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(66, 'Nanded', 10, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(68, 'Visakhapatnam', 11, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(69, 'Bilaspur', 12, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(70, 'Raipur', 12, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(71, 'Nagpur SECR', 12, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(72, 'Adra', 13, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(73, 'Chakradharpur', 13, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(74, 'Kharagpur', 13, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(75, 'Ranchi', 13, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(79, 'Bengaluru', 14, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(80, 'Hubballi', 14, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(81, 'Mysuru', 14, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(82, 'Chennai', 15, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(83, 'Salem', 15, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(84, 'Tiruchirappalli', 15, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(85, 'Madurai', 15, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(86, 'Palakkad', 15, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(87, 'Thiruvananthapuram', 15, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(89, 'Bhopal', 16, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(90, 'Jabalpur', 16, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(91, 'Kota', 16, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(92, 'Mumbai WR', 17, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(93, 'Ahmedabad', 17, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(94, 'Vadodara', 17, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(95, 'Ratlam', 17, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(96, 'Rajkot', 17, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(97, 'Bhavnagar', 17, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(99, 'Kolkata Metro', 18, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(100, 'Jammu Railway', 5, '', '2025-07-25 18:39:47', '2025-07-25 18:39:47'),
(101, 'Test Division', 20, 'Active', '2026-06-27 12:25:30', '2026-06-27 12:25:30'),
(102, 'Mysore', 14, 'Active', '2026-08-31 05:58:44', '2026-08-31 05:58:44');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_employee`
--

CREATE TABLE `mcc_employee` (
  `id` int(11) NOT NULL,
  `employee_id` varchar(50) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `designation` varchar(255) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `employee_photo` varchar(255) DEFAULT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `mother_name` varchar(255) DEFAULT NULL,
  `mobile_number` varchar(20) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `aadhar_number` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `ren_id` varchar(50) DEFAULT NULL,
  `rakshak_id` varchar(50) DEFAULT NULL,
  `pan_card` varchar(50) DEFAULT NULL,
  `police_ver` varchar(100) DEFAULT NULL,
  `police_ver_dt` date DEFAULT NULL,
  `pvc` varchar(100) DEFAULT NULL,
  `pvc_ok_applied` varchar(100) DEFAULT NULL,
  `pvc_issue_month` varchar(50) DEFAULT NULL,
  `medical` varchar(100) DEFAULT NULL,
  `medical_issue_month` varchar(50) DEFAULT NULL,
  `education` varchar(100) DEFAULT NULL,
  `document_status` varchar(100) DEFAULT NULL,
  `account_name` varchar(255) DEFAULT NULL,
  `account_number` varchar(50) DEFAULT NULL,
  `ifsc_code` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `valid_upto_date` date DEFAULT NULL,
  `valid_upto_month` varchar(50) DEFAULT NULL,
  `formula_valid_upto` varchar(255) DEFAULT NULL,
  `notification` varchar(255) DEFAULT NULL,
  `document_link` varchar(255) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `blood_group` varchar(10) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mcc_imposed_penalties`
--

CREATE TABLE `mcc_imposed_penalties` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `penalty_date` date NOT NULL,
  `penalty_reason` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `penalty_amount` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_imposed_penalties`
--

INSERT INTO `mcc_imposed_penalties` (`id`, `station_id`, `penalty_date`, `penalty_reason`, `description`, `penalty_amount`, `created_at`) VALUES
(2, 1, '2026-07-14', 'garbage', 'lot of garbage', 1000.00, '2026-07-14 12:06:38');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_chemical_param`
--

CREATE TABLE `mcc_intensive_chemical_param` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `units` varchar(100) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_chemical_param`
--

INSERT INTO `mcc_intensive_chemical_param` (`id`, `name`, `units`, `station_id`, `created_at`, `updated_at`) VALUES
(1, 'PVC Floor Cleaning Agent', 'ml/coach', 1, '2026-05-25 12:18:12', '2026-05-25 12:18:12'),
(2, 'Ceramic and stainless-steel toilet fittings cleaner', 'ml/coach', 1, '2026-05-25 12:18:12', '2026-08-31 11:54:46'),
(3, 'Glass cleaner', 'ml/coach', 1, '2026-05-25 12:18:12', '2026-08-31 11:55:09'),
(4, 'Laminated plastic sheet and berth rexine cleaner', 'ml/coach', 1, '2026-05-25 12:18:12', '2026-08-31 11:55:26'),
(5, 'Painted-surface cleaner', 'ml/coach', 1, '2026-05-25 12:18:12', '2026-08-31 11:55:48'),
(6, 'Stainless-steel polisher', 'ml/coach', 1, '2026-05-25 12:18:12', '2026-08-31 11:56:06'),
(7, 'Disinfectant', 'ml/coach', 1, '2026-05-25 12:18:12', '2026-08-31 11:56:22'),
(8, 'Water-based air freshener', 'ml/coach', 1, '2026-05-25 12:18:12', '2026-08-31 11:57:13');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_chemical_report`
--

CREATE TABLE `mcc_intensive_chemical_report` (
  `id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `coach_no` varchar(20) DEFAULT NULL,
  `qty_used` decimal(10,2) DEFAULT NULL,
  `auditor_name` varchar(255) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `token_id` varchar(100) NOT NULL,
  `train_no` varchar(50) DEFAULT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_chemical_report`
--

INSERT INTO `mcc_intensive_chemical_report` (`id`, `parameter_id`, `coach_no`, `qty_used`, `auditor_name`, `station_id`, `token_id`, `train_no`, `report_date`, `created_at`, `updated_at`) VALUES
(1, 1, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:07'),
(2, 2, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:07'),
(3, 3, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:07'),
(4, 4, 'C1', 5.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:07'),
(5, 5, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:07'),
(6, 6, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:07'),
(7, 7, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:07'),
(8, 8, 'C1', 100.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:07'),
(9, 1, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:09'),
(10, 2, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:09'),
(11, 3, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:09'),
(12, 4, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:09'),
(13, 5, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:09'),
(14, 6, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:09'),
(15, 7, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:09'),
(16, 8, 'C2', 100.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:09'),
(17, 1, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:17'),
(18, 2, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:17'),
(19, 3, 'C3', 8.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:17'),
(20, 4, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:17'),
(21, 5, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:17'),
(22, 6, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:17'),
(23, 7, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:17'),
(24, 8, 'C3', 100.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:17'),
(25, 1, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:19'),
(26, 2, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:19'),
(27, 3, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:19'),
(28, 4, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:19'),
(29, 5, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:19'),
(30, 6, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:19'),
(31, 7, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:19'),
(32, 8, 'C4', 100.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:19'),
(33, 1, '1', NULL, 'Ajit', 1, 'TKN-20260908-027', '12345', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(34, 2, '1', NULL, 'Ajit', 1, 'TKN-20260908-027', '12345', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(35, 3, '1', NULL, 'Ajit', 1, 'TKN-20260908-027', '12345', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(36, 4, '1', NULL, 'Ajit', 1, 'TKN-20260908-027', '12345', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(37, 5, '1', NULL, 'Ajit', 1, 'TKN-20260908-027', '12345', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(38, 6, '1', NULL, 'Ajit', 1, 'TKN-20260908-027', '12345', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(39, 7, '1', NULL, 'Ajit', 1, 'TKN-20260908-027', '12345', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(40, 8, '1', NULL, 'Ajit', 1, 'TKN-20260908-027', '12345', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(41, 1, '1', NULL, 'Ajit', 1, 'TKN-20260908-341', '12315', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 07:34:44'),
(42, 2, '1', NULL, 'Ajit', 1, 'TKN-20260908-341', '12315', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 07:34:44'),
(43, 3, '1', NULL, 'Ajit', 1, 'TKN-20260908-341', '12315', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 07:34:44'),
(44, 4, '1', NULL, 'Ajit', 1, 'TKN-20260908-341', '12315', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 07:34:44'),
(45, 5, '1', NULL, 'Ajit', 1, 'TKN-20260908-341', '12315', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 07:34:44'),
(46, 6, '1', NULL, 'Ajit', 1, 'TKN-20260908-341', '12315', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 07:34:44'),
(47, 7, '1', NULL, 'Ajit', 1, 'TKN-20260908-341', '12315', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 07:34:44'),
(48, 8, '1', NULL, 'Ajit', 1, 'TKN-20260908-341', '12315', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 07:34:44'),
(49, 1, '1', NULL, 'Smc', 1, 'TKN-20260908-286', '16236', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:04'),
(50, 2, '1', NULL, 'Smc', 1, 'TKN-20260908-286', '16236', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:04'),
(51, 3, '1', NULL, 'Smc', 1, 'TKN-20260908-286', '16236', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:04'),
(52, 4, '1', NULL, 'Smc', 1, 'TKN-20260908-286', '16236', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:04'),
(53, 5, '1', NULL, 'Smc', 1, 'TKN-20260908-286', '16236', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:04'),
(54, 6, '1', NULL, 'Smc', 1, 'TKN-20260908-286', '16236', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:04'),
(55, 7, '1', NULL, 'Smc', 1, 'TKN-20260908-286', '16236', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:04'),
(56, 8, '1', NULL, 'Smc', 1, 'TKN-20260908-286', '16236', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:04');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_chemical_target`
--

CREATE TABLE `mcc_intensive_chemical_target` (
  `id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `qty(ml)` decimal(10,2) DEFAULT NULL,
  `penalty` decimal(10,2) DEFAULT NULL,
  `penalty_qty(ml)` decimal(10,2) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `effective_from` date NOT NULL DEFAULT curdate(),
  `effective_to` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_chemical_target`
--

INSERT INTO `mcc_intensive_chemical_target` (`id`, `parameter_id`, `qty(ml)`, `penalty`, `penalty_qty(ml)`, `station_id`, `created_at`, `updated_at`, `effective_from`, `effective_to`) VALUES
(1, 1, 10.00, 500.00, 10.00, 1, '2026-09-07 14:08:23', '2026-09-07 14:08:23', '2026-09-07', NULL),
(2, 2, 10.00, 500.00, 10.00, 1, '2026-09-07 14:08:23', '2026-09-07 14:08:23', '2026-09-07', NULL),
(3, 3, 10.00, 500.00, 10.00, 1, '2026-09-07 14:08:23', '2026-09-07 14:08:23', '2026-09-07', NULL),
(4, 4, 10.00, 500.00, 10.00, 1, '2026-09-07 14:08:23', '2026-09-07 14:08:23', '2026-09-07', NULL),
(5, 5, 10.00, 500.00, 10.00, 1, '2026-09-07 14:08:23', '2026-09-07 14:08:23', '2026-09-07', NULL),
(6, 6, 10.00, 500.00, 10.00, 1, '2026-09-07 14:08:23', '2026-09-07 14:08:23', '2026-09-07', NULL),
(7, 7, 10.00, 50.00, 10.00, 1, '2026-09-07 14:08:23', '2026-09-07 14:08:23', '2026-09-07', NULL),
(8, 8, 100.00, 50.00, 10.00, 1, '2026-09-07 14:08:23', '2026-09-07 14:08:23', '2026-09-07', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_machine_param`
--

CREATE TABLE `mcc_intensive_machine_param` (
  `id` int(11) NOT NULL,
  `machine_no` varchar(100) NOT NULL,
  `machine_name` varchar(255) NOT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_machine_param`
--

INSERT INTO `mcc_intensive_machine_param` (`id`, `machine_no`, `machine_name`, `station_id`, `created_at`, `updated_at`) VALUES
(16, 'PPSD 1', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(17, 'PPSD 2', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(18, 'PPSD 3', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(19, 'PPSD 4', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(20, 'PPSD 5', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(21, 'PPSD 6', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(22, 'PPSD 7', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(23, 'PPSD 8', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(24, 'PPSD 9', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(25, 'HHSD 1', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(26, 'HHSD 2', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(27, 'HHSD 3', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(28, 'HHSD 4', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(29, 'HHSD 5', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(30, 'HHSD 6', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_machine_report`
--

CREATE TABLE `mcc_intensive_machine_report` (
  `id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `used_status` varchar(50) DEFAULT NULL,
  `token_id` varchar(100) NOT NULL,
  `auditor_name` varchar(150) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_machine_report`
--

INSERT INTO `mcc_intensive_machine_report` (`id`, `parameter_id`, `shift_id`, `used_status`, `token_id`, `auditor_name`, `station_id`, `report_date`, `created_at`, `updated_at`) VALUES
(1, 16, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41'),
(2, 17, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41'),
(3, 18, 4, 'N', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41'),
(4, 19, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41'),
(5, 20, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41'),
(6, 21, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41'),
(7, 22, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41'),
(8, 23, 4, 'N', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41'),
(9, 24, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41'),
(10, 25, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41'),
(11, 26, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41'),
(12, 27, 4, 'N', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41'),
(13, 28, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41'),
(14, 29, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41'),
(15, 30, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41'),
(16, 16, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50'),
(17, 17, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50'),
(18, 18, 5, 'N', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50'),
(19, 19, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50'),
(20, 20, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50'),
(21, 21, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50'),
(22, 22, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50'),
(23, 23, 5, 'N', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50'),
(24, 24, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50'),
(25, 25, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50'),
(26, 26, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50'),
(27, 27, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50'),
(28, 28, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50'),
(29, 29, 5, 'N', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50'),
(30, 30, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50'),
(31, 16, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54'),
(32, 17, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54'),
(33, 18, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54'),
(34, 19, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54'),
(35, 20, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54'),
(36, 21, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54'),
(37, 22, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54'),
(38, 23, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54'),
(39, 24, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54'),
(40, 25, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54'),
(41, 26, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54'),
(42, 27, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54'),
(43, 28, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54'),
(44, 29, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54'),
(45, 30, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54'),
(46, 16, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01'),
(47, 17, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01'),
(48, 18, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01'),
(49, 19, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01'),
(50, 20, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01'),
(51, 21, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01'),
(52, 22, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01'),
(53, 23, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01'),
(54, 24, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01'),
(55, 25, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01'),
(56, 26, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01'),
(57, 27, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01'),
(58, 28, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01'),
(59, 29, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01'),
(60, 30, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_machine_shifts`
--

CREATE TABLE `mcc_intensive_machine_shifts` (
  `id` int(11) NOT NULL,
  `shift` varchar(100) NOT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_machine_shifts`
--

INSERT INTO `mcc_intensive_machine_shifts` (`id`, `shift`, `station_id`, `created_at`, `updated_at`) VALUES
(4, 'Shift 1', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(5, 'Shift 2', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(6, 'Shift 3', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_machine_target`
--

CREATE TABLE `mcc_intensive_machine_target` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `machine_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `nominated_area` varchar(50) DEFAULT NULL,
  `penalty_amount` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `effective_from` date NOT NULL DEFAULT curdate(),
  `effective_to` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_machine_target`
--

INSERT INTO `mcc_intensive_machine_target` (`id`, `station_id`, `machine_id`, `shift_id`, `nominated_area`, `penalty_amount`, `created_at`, `updated_at`, `effective_from`, `effective_to`) VALUES
(1, 1, 16, 4, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(2, 1, 16, 5, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(3, 1, 16, 6, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(4, 1, 17, 4, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(5, 1, 17, 5, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(6, 1, 17, 6, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(7, 1, 18, 4, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(8, 1, 18, 5, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(9, 1, 18, 6, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(10, 1, 19, 4, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(11, 1, 19, 5, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(12, 1, 19, 6, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(13, 1, 20, 4, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(14, 1, 20, 5, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(15, 1, 20, 6, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(16, 1, 21, 4, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(17, 1, 21, 5, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(18, 1, 21, 6, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(19, 1, 22, 4, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(20, 1, 22, 5, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(21, 1, 22, 6, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(22, 1, 23, 4, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(23, 1, 23, 5, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(24, 1, 23, 6, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(25, 1, 24, 4, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(26, 1, 24, 5, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(27, 1, 24, 6, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(28, 1, 25, 4, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(29, 1, 25, 5, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(30, 1, 25, 6, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(31, 1, 26, 4, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(32, 1, 26, 5, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(33, 1, 26, 6, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(34, 1, 27, 4, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(35, 1, 27, 5, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(36, 1, 27, 6, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(37, 1, 28, 4, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(38, 1, 28, 5, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(39, 1, 28, 6, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(40, 1, 29, 4, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(41, 1, 29, 5, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(42, 1, 29, 6, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(43, 1, 30, 4, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(44, 1, 30, 5, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(45, 1, 30, 6, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_pantry_chemical_param`
--

CREATE TABLE `mcc_intensive_pantry_chemical_param` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `units` varchar(100) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_pantry_chemical_param`
--

INSERT INTO `mcc_intensive_pantry_chemical_param` (`id`, `name`, `units`, `station_id`, `created_at`, `updated_at`) VALUES
(1, 'PVC floor-cleaning agent', 'ml/coach', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(2, 'Ceramic and stainless-steel toilet fittings cleaner', 'ml/coach', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(3, 'Glass-cleaning agent', 'ml/coach', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(4, 'Laminated plastic sheet and berth rexine cleaner', 'ml/coach', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(5, 'Painted-surface cleaner', 'ml/coach', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(6, 'Disinfectant', 'ml/coach', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(7, 'Air Freshener', 'ml/coach', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(8, 'Old-label, sticker and glue-mark remover', 'ml/coach', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_pantry_chemical_report`
--

CREATE TABLE `mcc_intensive_pantry_chemical_report` (
  `id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `qty_used` decimal(10,2) DEFAULT NULL,
  `token_id` varchar(100) NOT NULL,
  `auditor_name` varchar(150) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `train_no` varchar(50) DEFAULT NULL,
  `coach_no` varchar(20) DEFAULT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_pantry_chemical_report`
--

INSERT INTO `mcc_intensive_pantry_chemical_report` (`id`, `parameter_id`, `qty_used`, `token_id`, `auditor_name`, `station_id`, `train_no`, `coach_no`, `report_date`, `created_at`, `updated_at`) VALUES
(1, 1, 10.00, 'TKN-PTRY-20260907-280', 'Bheem Chand', 1, '12345', 'C1', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:15:42'),
(2, 2, 10.00, 'TKN-PTRY-20260907-280', 'Bheem Chand', 1, '12345', 'C1', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:15:42'),
(3, 3, 8.00, 'TKN-PTRY-20260907-280', 'Bheem Chand', 1, '12345', 'C1', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:15:42'),
(4, 4, 10.00, 'TKN-PTRY-20260907-280', 'Bheem Chand', 1, '12345', 'C1', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:15:42'),
(5, 5, 10.00, 'TKN-PTRY-20260907-280', 'Bheem Chand', 1, '12345', 'C1', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:15:42'),
(6, 6, 10.00, 'TKN-PTRY-20260907-280', 'Bheem Chand', 1, '12345', 'C1', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:15:42'),
(7, 7, 5.00, 'TKN-PTRY-20260907-280', 'Bheem Chand', 1, '12345', 'C1', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:15:42'),
(8, 8, 10.00, 'TKN-PTRY-20260907-280', 'Bheem Chand', 1, '12345', 'C1', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:15:42'),
(9, 1, NULL, 'TKN-PTRY-20260908-633', 'Bheem Chand', 1, '12315', '01', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:28'),
(10, 2, NULL, 'TKN-PTRY-20260908-633', 'Bheem Chand', 1, '12315', '01', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:28'),
(11, 3, NULL, 'TKN-PTRY-20260908-633', 'Bheem Chand', 1, '12315', '01', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:28'),
(12, 4, NULL, 'TKN-PTRY-20260908-633', 'Bheem Chand', 1, '12315', '01', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:28'),
(13, 5, NULL, 'TKN-PTRY-20260908-633', 'Bheem Chand', 1, '12315', '01', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:28'),
(14, 6, NULL, 'TKN-PTRY-20260908-633', 'Bheem Chand', 1, '12315', '01', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:28'),
(15, 7, NULL, 'TKN-PTRY-20260908-633', 'Bheem Chand', 1, '12315', '01', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:28'),
(16, 8, NULL, 'TKN-PTRY-20260908-633', 'Bheem Chand', 1, '12315', '01', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:28');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_pantry_chemical_target`
--

CREATE TABLE `mcc_intensive_pantry_chemical_target` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `qty(ml)` decimal(10,2) NOT NULL,
  `penalty` decimal(10,2) NOT NULL,
  `penalty_qty(ml)` decimal(10,2) DEFAULT NULL,
  `effective_from` date NOT NULL,
  `effective_to` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_pantry_chemical_target`
--

INSERT INTO `mcc_intensive_pantry_chemical_target` (`id`, `station_id`, `parameter_id`, `qty(ml)`, `penalty`, `penalty_qty(ml)`, `effective_from`, `effective_to`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 10.00, 200.00, 5.00, '2026-09-07', NULL, '2026-09-07 14:11:06', '2026-09-07 14:11:06'),
(2, 1, 2, 10.00, 200.00, 5.00, '2026-09-07', NULL, '2026-09-07 14:11:06', '2026-09-07 14:11:06'),
(3, 1, 3, 10.00, 200.00, 5.00, '2026-09-07', NULL, '2026-09-07 14:11:06', '2026-09-07 14:11:06'),
(4, 1, 4, 10.00, 200.00, 5.00, '2026-09-07', NULL, '2026-09-07 14:11:06', '2026-09-07 14:11:06'),
(5, 1, 5, 10.00, 200.00, 5.00, '2026-09-07', NULL, '2026-09-07 14:11:06', '2026-09-07 14:11:06'),
(6, 1, 6, 10.00, 200.00, 5.00, '2026-09-07', NULL, '2026-09-07 14:11:06', '2026-09-07 14:11:06'),
(7, 1, 7, 10.00, 200.00, 5.00, '2026-09-07', NULL, '2026-09-07 14:11:06', '2026-09-07 14:11:06'),
(8, 1, 8, 10.00, 200.00, 5.00, '2026-09-07', NULL, '2026-09-07 14:11:06', '2026-09-07 14:11:06');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_pantry_machine_param`
--

CREATE TABLE `mcc_intensive_pantry_machine_param` (
  `id` int(11) NOT NULL,
  `machine_no` varchar(100) NOT NULL,
  `machine_name` varchar(255) NOT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_pantry_machine_param`
--

INSERT INTO `mcc_intensive_pantry_machine_param` (`id`, `machine_no`, `machine_name`, `station_id`, `created_at`, `updated_at`) VALUES
(16, 'PPSD 1', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(17, 'PPSD 2', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(18, 'PPSD 3', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(19, 'PPSD 4', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(20, 'PPSD 5', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(21, 'PPSD 6', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(22, 'PPSD 7', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(23, 'PPSD 8', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(24, 'PPSD 9', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(25, 'HHSD 1', 'Hand held single disc electrically operated mini scrubber', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(26, 'HHSD 2', 'Hand held single disc electrically operated mini scrubber', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(27, 'HHSD 3', 'Hand held single disc electrically operated mini scrubber', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(28, 'HHSD 4', 'Hand held single disc electrically operated mini scrubber', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(29, 'HHSD 5', 'Hand held single disc electrically operated mini scrubber', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(30, 'HHSD 6', 'Hand held single disc electrically operated mini scrubber', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_pantry_machine_report`
--

CREATE TABLE `mcc_intensive_pantry_machine_report` (
  `id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `used_status` varchar(10) NOT NULL,
  `token_id` varchar(100) NOT NULL,
  `auditor_name` varchar(150) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_pantry_machine_report`
--

INSERT INTO `mcc_intensive_pantry_machine_report` (`id`, `parameter_id`, `shift_id`, `used_status`, `token_id`, `auditor_name`, `station_id`, `report_date`, `created_at`, `updated_at`) VALUES
(1, 16, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31'),
(2, 17, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31'),
(3, 18, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31'),
(4, 19, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31'),
(5, 20, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31'),
(6, 21, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31'),
(7, 22, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31'),
(8, 23, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31'),
(9, 24, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31'),
(10, 25, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31'),
(11, 26, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31'),
(12, 27, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31'),
(13, 28, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31'),
(14, 29, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31'),
(15, 30, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31'),
(16, 16, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43'),
(17, 17, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43'),
(18, 18, 5, 'N', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43'),
(19, 19, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43'),
(20, 20, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43'),
(21, 21, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43'),
(22, 22, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43'),
(23, 23, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43'),
(24, 24, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43'),
(25, 25, 5, 'N', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43'),
(26, 26, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43'),
(27, 27, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43'),
(28, 28, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43'),
(29, 29, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43'),
(30, 30, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43'),
(31, 16, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49'),
(32, 17, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49'),
(33, 18, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49'),
(34, 19, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49'),
(35, 20, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49'),
(36, 21, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49'),
(37, 22, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49'),
(38, 23, 6, 'N', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49'),
(39, 24, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49'),
(40, 25, 6, 'N', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49'),
(41, 26, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49'),
(42, 27, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49'),
(43, 28, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49'),
(44, 29, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49'),
(45, 30, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_pantry_machine_shifts`
--

CREATE TABLE `mcc_intensive_pantry_machine_shifts` (
  `id` int(11) NOT NULL,
  `shift` varchar(100) NOT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_pantry_machine_shifts`
--

INSERT INTO `mcc_intensive_pantry_machine_shifts` (`id`, `shift`, `station_id`, `created_at`, `updated_at`) VALUES
(4, 'Shift 1', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(5, 'Shift 2', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(6, 'Shift 3', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_pantry_machine_target`
--

CREATE TABLE `mcc_intensive_pantry_machine_target` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `machine_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `nominated_area` varchar(255) NOT NULL,
  `penalty_amount` decimal(10,2) NOT NULL,
  `effective_from` date NOT NULL,
  `effective_to` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_pantry_machine_target`
--

INSERT INTO `mcc_intensive_pantry_machine_target` (`id`, `station_id`, `machine_id`, `shift_id`, `nominated_area`, `penalty_amount`, `effective_from`, `effective_to`, `created_at`, `updated_at`) VALUES
(1, 1, 16, 4, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(2, 1, 16, 5, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(3, 1, 16, 6, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(4, 1, 17, 4, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(5, 1, 17, 5, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(6, 1, 17, 6, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(7, 1, 18, 4, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(8, 1, 18, 5, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(9, 1, 18, 6, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(10, 1, 19, 4, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(11, 1, 19, 5, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(12, 1, 19, 6, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(13, 1, 20, 4, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(14, 1, 20, 5, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(15, 1, 20, 6, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(16, 1, 21, 4, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(17, 1, 21, 5, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(18, 1, 21, 6, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(19, 1, 22, 4, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(20, 1, 22, 5, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(21, 1, 22, 6, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(22, 1, 23, 4, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(23, 1, 23, 5, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(24, 1, 23, 6, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(25, 1, 24, 4, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(26, 1, 24, 5, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(27, 1, 24, 6, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(28, 1, 25, 4, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(29, 1, 25, 5, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(30, 1, 25, 6, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(31, 1, 26, 4, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(32, 1, 26, 5, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(33, 1, 26, 6, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(34, 1, 27, 4, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(35, 1, 27, 5, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(36, 1, 27, 6, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(37, 1, 28, 4, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(38, 1, 28, 5, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(39, 1, 28, 6, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(40, 1, 29, 4, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(41, 1, 29, 5, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(42, 1, 29, 6, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(43, 1, 30, 4, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(44, 1, 30, 5, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(45, 1, 30, 6, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_pantry_param`
--

CREATE TABLE `mcc_intensive_pantry_param` (
  `id` int(11) NOT NULL,
  `parameter_name` varchar(255) NOT NULL,
  `station_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_pantry_param`
--

INSERT INTO `mcc_intensive_pantry_param` (`id`, `parameter_name`, `station_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'All items of daily cleaning attention (Total marks: 3)', 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18'),
(2, 'Apply polish to the stainless steel wash basins and other items as required. (Total marks: 3)', 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18'),
(3, 'Buffing of stainless steel items such as wash basins, wall protector and lavatory pans etc. (Total marks: 3)', 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18'),
(4, 'PVC floor cleaning using electric floor scrubber and vacuum cleaner (Total marks: 3)', 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18'),
(5, 'Cleaning of Seat/Berths using portable electric disc scrubber (Cleaning of Seat/Berths using portable wet & dry vacuum cleaner - Only For vande bharat coach seats) Berth flap should be cleaned with wet cloth (Total marks: 3)', 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18'),
(6, 'Cleaning of LP Sheet and Roof. No graffiti/sticker/cobweb/spot should be visible after cleaning attention. (Total marks: 3)', 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18'),
(7, 'Cleaning of Doorway & vestibule area with scrubber and Vacuum machines (Total marks: 3)', 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18'),
(8, 'Corners and dustbins to be cleaned with nylon brush. Cleaning of dustbins & dismantling/assembling if required (Total marks: 3)', 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18'),
(9, 'Footsteps to be cleaned thoroughly (Total marks: 3)', 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18'),
(10, 'Cleaning/polishing of amenity fittings (Total marks: 3)', 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18'),
(11, 'Cleaning/polishing of door handles etc (Total marks: 3)', 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18'),
(12, 'All glass windows should be cleaned so that no spot is visible. Window sill area needs special cleaning to remove pan stains/spit stains using portable electric scrubber (Total marks: 3)', 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18'),
(13, 'Dry & wet vacuum cleaning in inaccessible areas like behind panels (Total marks: 3)', 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18'),
(14, 'Visible portion of the exterior Roof should be cleaned using a long brush (Total marks: 3)', 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(15, 'Complete exterior cleaning (Total marks: 3)', 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(16, 'All stoves (Total marks: 3 marks for each stove)', 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(17, 'Hot cases (Total marks: 3 marks for each hot Hot Case ) & All refrigerators (Total marks: 3)', 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(18, 'All storage spaces, racks, tables and counter to be scrubbed properly (Total marks: 3)', 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(19, 'All items of daily cleaning attention (Total marks: 3)', 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(20, 'Apply polish to the stainless steel wash basins and other items as required. (Total marks: 3)', 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(21, 'Buffing of stainless steel items such as wash basins, wall protector and lavatory pans etc. (Total marks: 3)', 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(22, 'PVC floor cleaning using electric floor scrubber and vacuum cleaner (Total marks: 3)', 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(23, 'Cleaning of Seat/Berths using portable electric disc scrubber (Cleaning of Seat/Berths using portable wet & dry vacuum cleaner - Only For vande bharat coach seats) Berth flap should be cleaned with wet cloth (Total marks: 3)', 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(24, 'Cleaning of LP Sheet and Roof. No graffiti/sticker/cobweb/spot should be visible after cleaning attention. (Total marks: 3)', 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(25, 'Cleaning of Doorway & vestibule area with scrubber and Vacuum machines (Total marks: 3)', 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(26, 'Corners and dustbins to be cleaned with nylon brush. Cleaning of dustbins & dismantling/assembling if required (Total marks: 3)', 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(27, 'Footsteps to be cleaned thoroughly (Total marks: 3)', 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(28, 'Cleaning/polishing of amenity fittings (Total marks: 3)', 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(29, 'Cleaning/polishing of door handles etc (Total marks: 3)', 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(30, 'All glass windows should be cleaned so that no spot is visible. Window sill area needs special cleaning to remove pan stains/spit stains using portable electric scrubber (Total marks: 3)', 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(31, 'Dry & wet vacuum cleaning in inaccessible areas like behind panels (Total marks: 3)', 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(32, 'Visible portion of the exterior Roof should be cleaned using a long brush (Total marks: 3)', 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(33, 'Complete exterior cleaning (Total marks: 3)', 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(34, 'All stoves (Total marks: 3 marks for each stove)', 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(35, 'Hot cases (Total marks: 3 marks for each hot Hot Case ) & All refrigerators (Total marks: 3)', 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(36, 'All storage spaces, racks, tables and counter to be scrubbed properly (Total marks: 3)', 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(37, 'All items of daily cleaning attention (Total marks: 3)', 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(38, 'Apply polish to the stainless steel wash basins and other items as required. (Total marks: 3)', 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(39, 'Buffing of stainless steel items such as wash basins, wall protector and lavatory pans etc. (Total marks: 3)', 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(40, 'PVC floor cleaning using electric floor scrubber and vacuum cleaner (Total marks: 3)', 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(41, 'Cleaning of Seat/Berths using portable electric disc scrubber (Cleaning of Seat/Berths using portable wet & dry vacuum cleaner - Only For vande bharat coach seats) Berth flap should be cleaned with wet cloth (Total marks: 3)', 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(42, 'Cleaning of LP Sheet and Roof. No graffiti/sticker/cobweb/spot should be visible after cleaning attention. (Total marks: 3)', 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(43, 'Cleaning of Doorway & vestibule area with scrubber and Vacuum machines (Total marks: 3)', 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(44, 'Corners and dustbins to be cleaned with nylon brush. Cleaning of dustbins & dismantling/assembling if required (Total marks: 3)', 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(45, 'Footsteps to be cleaned thoroughly (Total marks: 3)', 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(46, 'Cleaning/polishing of amenity fittings (Total marks: 3)', 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(47, 'Cleaning/polishing of door handles etc (Total marks: 3)', 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(48, 'All glass windows should be cleaned so that no spot is visible. Window sill area needs special cleaning to remove pan stains/spit stains using portable electric scrubber (Total marks: 3)', 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(49, 'Dry & wet vacuum cleaning in inaccessible areas like behind panels (Total marks: 3)', 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(50, 'Visible portion of the exterior Roof should be cleaned using a long brush (Total marks: 3)', 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(51, 'Complete exterior cleaning (Total marks: 3)', 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(52, 'All stoves (Total marks: 3 marks for each stove)', 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(53, 'Hot cases (Total marks: 3 marks for each hot Hot Case ) & All refrigerators (Total marks: 3)', 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(54, 'All storage spaces, racks, tables and counter to be scrubbed properly (Total marks: 3)', 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_pantry_rating`
--

CREATE TABLE `mcc_intensive_pantry_rating` (
  `id` int(11) NOT NULL,
  `rating_name` varchar(50) NOT NULL,
  `rating_value` varchar(50) NOT NULL,
  `rating_group` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_pantry_rating`
--

INSERT INTO `mcc_intensive_pantry_rating` (`id`, `rating_name`, `rating_value`, `rating_group`, `created_at`) VALUES
(1, 'Very Good', '3', 'cleaning', '2026-08-26 06:52:18'),
(2, 'Satisfactory', '2', 'cleaning', '2026-08-26 06:52:18'),
(3, 'Poor', '1', 'cleaning', '2026-08-26 06:52:18'),
(4, 'Not attended', '0', 'cleaning', '2026-08-26 06:52:18'),
(5, 'Yes', 'Y', 'watering', '2026-08-26 11:03:28'),
(6, 'No', 'N', 'watering', '2026-08-26 11:03:28');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_pantry_report`
--

CREATE TABLE `mcc_intensive_pantry_report` (
  `id` int(11) NOT NULL,
  `sub_parameter_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `token_id` varchar(100) NOT NULL,
  `train_no` varchar(50) NOT NULL,
  `coach_no` varchar(20) NOT NULL,
  `score_value` varchar(10) NOT NULL,
  `auditor_name` varchar(150) NOT NULL DEFAULT 'prabhunath',
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_pantry_report`
--

INSERT INTO `mcc_intensive_pantry_report` (`id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `auditor_name`, `report_date`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(2, 2, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(3, 3, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(4, 4, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(5, 5, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(6, 6, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(7, 7, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(8, 8, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(9, 9, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(10, 10, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(11, 11, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(12, 12, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(13, 13, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(14, 14, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(15, 15, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(16, 16, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(17, 17, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(18, 18, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(19, 19, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(20, 20, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(21, 21, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(22, 22, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(23, 23, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(24, 24, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(25, 25, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(26, 26, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(27, 27, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(28, 28, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(29, 29, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(30, 30, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(31, 31, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(32, 32, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(33, 33, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(34, 34, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(35, 35, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(36, 36, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(37, 37, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(38, 38, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(39, 39, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(40, 40, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(41, 41, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(42, 42, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(43, 43, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(44, 44, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(45, 45, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(46, 46, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(47, 47, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(48, 48, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(49, 49, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09'),
(50, 1, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:30'),
(51, 2, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:34'),
(52, 3, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:34'),
(53, 4, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:34'),
(54, 5, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:34'),
(55, 6, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:34'),
(56, 7, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:34'),
(57, 8, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:38'),
(58, 9, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:38'),
(59, 10, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:38'),
(60, 11, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:38'),
(61, 12, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:41'),
(62, 13, 1, 'TKN-PTRY-20260908-633', '12315', '01', '2', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:46'),
(63, 14, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:46'),
(64, 15, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:53'),
(65, 16, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:53'),
(66, 17, 1, 'TKN-PTRY-20260908-633', '12315', '01', '2', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:53'),
(67, 18, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:53'),
(68, 19, 1, 'TKN-PTRY-20260908-633', '12315', '01', '2', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:04'),
(69, 20, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:04'),
(70, 21, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:09'),
(71, 22, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:09'),
(72, 23, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:13'),
(73, 24, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:13'),
(74, 25, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:13'),
(75, 26, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:13'),
(76, 27, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:22'),
(77, 28, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:26'),
(78, 29, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:26'),
(79, 30, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:26'),
(80, 31, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:26'),
(81, 32, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:30'),
(82, 33, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:30'),
(83, 34, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:38'),
(84, 35, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:41'),
(85, 36, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:41'),
(86, 37, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:44'),
(87, 38, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:44'),
(88, 39, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:51'),
(89, 40, 1, 'TKN-PTRY-20260908-633', '12315', '01', '2', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:51'),
(90, 41, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:51'),
(91, 42, 1, 'TKN-PTRY-20260908-633', '12315', '01', '2', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:51'),
(92, 43, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:55'),
(93, 44, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:55'),
(94, 45, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:55'),
(95, 46, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:21:00'),
(96, 47, 1, 'TKN-PTRY-20260908-633', '12315', '01', '2', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:21:00'),
(97, 48, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:21:00'),
(98, 49, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:21:00');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_pantry_sub_param`
--

CREATE TABLE `mcc_intensive_pantry_sub_param` (
  `id` int(11) NOT NULL,
  `sub_parameter_name` varchar(255) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `input_type` varchar(50) DEFAULT 'cleaning'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_pantry_sub_param`
--

INSERT INTO `mcc_intensive_pantry_sub_param` (`id`, `sub_parameter_name`, `parameter_id`, `station_id`, `status`, `created_at`, `updated_at`, `input_type`) VALUES
(1, 'Daily', 1, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(2, 'Basin 1', 2, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(3, 'Basin 2', 2, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(4, 'Basin 3', 2, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(5, 'Basin 4', 2, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(6, 'Basin 5', 2, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(7, 'Basin 6', 2, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(8, 'Toilet 1', 3, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(9, 'Toilet 2', 3, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(10, 'Toilet 3', 3, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(11, 'Toilet 4', 3, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(12, 'Floor', 4, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(13, 'Bay 1', 5, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(14, 'Bay 2', 5, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(15, 'Bay 1', 6, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(16, 'Bay 2', 6, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(17, 'AP End', 6, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(18, 'SBC End', 6, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(19, 'AP End', 7, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(20, 'SBC End', 7, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(21, 'Ap End', 8, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(22, 'SBC End', 8, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(23, 'Foot Step 1', 9, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(24, 'Foot Step 2', 9, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(25, 'Foot Step 3', 9, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(26, 'Foot Step 4', 9, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(27, 'Amenity', 10, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(28, 'Door 1', 11, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(29, 'door 2', 11, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(30, 'Door 3', 11, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(31, 'Door 4', 11, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(32, 'East Side', 12, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(33, 'West Side', 12, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(34, 'Vacuum', 13, 1, 'Active', '2026-08-17 06:54:18', '2026-08-17 06:54:18', 'cleaning'),
(35, 'East Side', 14, 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(36, 'West Side', 14, 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(37, 'East Side', 15, 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(38, 'West Side', 15, 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(39, 'Stove 1', 16, 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(40, 'Stove 2', 16, 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(41, 'Stove 3', 16, 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(42, 'Stove 4', 16, 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(43, 'Hot case 1', 17, 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(44, 'Hot case 2', 17, 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(45, 'Refrigerators', 17, 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(46, 'Storage area', 18, 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(47, 'All tables', 18, 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(48, 'Counter', 18, 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(49, 'Food racks', 18, 1, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(50, 'Daily', 19, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(51, 'Basin 1', 20, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(52, 'Basin 2', 20, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(53, 'Basin 3', 20, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(54, 'Basin 4', 20, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(55, 'Basin 5', 20, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(56, 'Basin 6', 20, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(57, 'Toilet 1', 21, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(58, 'Toilet 2', 21, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(59, 'Toilet 3', 21, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(60, 'Toilet 4', 21, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(61, 'Floor', 22, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(62, 'Bay 1', 23, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(63, 'Bay 2', 23, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(64, 'Bay 1', 24, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(65, 'Bay 2', 24, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(66, 'AP End', 24, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(67, 'SBC End', 24, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(68, 'AP End', 25, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(69, 'SBC End', 25, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(70, 'Ap End', 26, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(71, 'SBC End', 26, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(72, 'Foot Step 1', 27, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(73, 'Foot Step 2', 27, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(74, 'Foot Step 3', 27, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(75, 'Foot Step 4', 27, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(76, 'Amenity', 28, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(77, 'Door 1', 29, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(78, 'door 2', 29, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(79, 'Door 3', 29, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(80, 'Door 4', 29, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(81, 'East Side', 30, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(82, 'West Side', 30, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(83, 'Vacuum', 31, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(84, 'East Side', 32, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(85, 'West Side', 32, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(86, 'East Side', 33, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(87, 'West Side', 33, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(88, 'Stove 1', 34, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(89, 'Stove 2', 34, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(90, 'Stove 3', 34, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(91, 'Stove 4', 34, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(92, 'Hot case 1', 35, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(93, 'Hot case 2', 35, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(94, 'Refrigerators', 35, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(95, 'Storage area', 36, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(96, 'All tables', 36, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(97, 'Counter', 36, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(98, 'Food racks', 36, 2, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(99, 'Daily', 37, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(100, 'Basin 1', 38, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(101, 'Basin 2', 38, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(102, 'Basin 3', 38, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(103, 'Basin 4', 38, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(104, 'Basin 5', 38, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(105, 'Basin 6', 38, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(106, 'Toilet 1', 39, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(107, 'Toilet 2', 39, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(108, 'Toilet 3', 39, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(109, 'Toilet 4', 39, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(110, 'Floor', 40, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(111, 'Bay 1', 41, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(112, 'Bay 2', 41, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(113, 'Bay 1', 42, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(114, 'Bay 2', 42, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(115, 'AP End', 42, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(116, 'SBC End', 42, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(117, 'AP End', 43, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(118, 'SBC End', 43, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(119, 'Ap End', 44, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(120, 'SBC End', 44, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(121, 'Foot Step 1', 45, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(122, 'Foot Step 2', 45, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(123, 'Foot Step 3', 45, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(124, 'Foot Step 4', 45, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(125, 'Amenity', 46, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(126, 'Door 1', 47, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(127, 'door 2', 47, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(128, 'Door 3', 47, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(129, 'Door 4', 47, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(130, 'East Side', 48, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(131, 'West Side', 48, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(132, 'Vacuum', 49, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(133, 'East Side', 50, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(134, 'West Side', 50, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(135, 'East Side', 51, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(136, 'West Side', 51, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(137, 'Stove 1', 52, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(138, 'Stove 2', 52, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(139, 'Stove 3', 52, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(140, 'Stove 4', 52, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(141, 'Hot case 1', 53, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(142, 'Hot case 2', 53, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(143, 'Refrigerators', 53, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(144, 'Storage area', 54, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(145, 'All tables', 54, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(146, 'Counter', 54, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(147, 'Food racks', 54, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_scorecard_2_param`
--

CREATE TABLE `mcc_intensive_scorecard_2_param` (
  `id` int(11) NOT NULL,
  `parameter_name` varchar(255) NOT NULL,
  `station_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_scorecard_2_param`
--

INSERT INTO `mcc_intensive_scorecard_2_param` (`id`, `parameter_name`, `station_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'All items of daily cleaning attention (Total marks: 3)', 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(2, 'Apply polish to the stainless steel wash basins and other items as required. (Total marks: 3)', 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(3, 'Buffing of stainless steel items such as wash basins, wall protector and lavatory pans etc. (Total marks: 3)', 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(4, 'PVC floor cleaning using electric floor scrubber and vacuum cleaner (Total marks: 3)', 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(5, 'Cleaning of Seat/Berths using portable electric disc scrubber (Cleaning of Seat/Berths using portable wet & dry vacuum cleaner - Only For vande bharat coach seats) Berth flap should be cleaned with wet cloth (Total marks: 3)', 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(6, 'Cleaning of LP Sheet and Roof. No graffiti/sticker/cobweb/spot should be visible after cleaning attention. (Total marks: 3)', 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(7, 'Cleaning of Doorway & vestibule area with scrubber and Vacuum machines (Total marks: 3)', 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(8, 'Corners and dustbins to be cleaned with nylon brush. Cleaning of dustbins & dismantling/assembling if required (Total marks: 3)', 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(9, 'Footsteps to be cleaned thoroughly (Total marks: 3)', 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(10, 'Cleaning/polishing of amenity fittings (Total marks: 3)', 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(11, 'Cleaning/polishing of door handles etc (Total marks: 3)', 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(12, 'All glass windows should be cleaned so that no spot is visible. Window sill area needs special cleaning to remove pan stains/spit stains using portable electric scrubber (Total marks: 3)', 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(13, 'Panes of Louver shutter should also be cleaned with wet cloth. In the case of Vande bharat, All luggage racks should be cleaned. (Total marks: 3)', 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(14, 'Dry & wet vacuum cleaning in inaccessible areas like behind panels (Total marks: 3)', 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(15, 'Visible portion of the exterior Roof should be cleaned using a long brush. (Total marks: 3)', 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(16, 'Complete exterior cleaning (Total marks: 3)', 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(17, 'All items of daily cleaning attention (Total marks: 3)', 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(18, 'Apply polish to the stainless steel wash basins and other items as required. (Total marks: 3)', 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(19, 'Buffing of stainless steel items such as wash basins, wall protector and lavatory pans etc. (Total marks: 3)', 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(20, 'PVC floor cleaning using electric floor scrubber and vacuum cleaner (Total marks: 3)', 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(21, 'Cleaning of Seat/Berths using portable electric disc scrubber (Cleaning of Seat/Berths using portable wet & dry vacuum cleaner - Only For vande bharat coach seats) Berth flap should be cleaned with wet cloth (Total marks: 3)', 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(22, 'Cleaning of LP Sheet and Roof. No graffiti/sticker/cobweb/spot should be visible after cleaning attention. (Total marks: 3)', 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(23, 'Cleaning of Doorway & vestibule area with scrubber and Vacuum machines (Total marks: 3)', 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(24, 'Corners and dustbins to be cleaned with nylon brush. Cleaning of dustbins & dismantling/assembling if required (Total marks: 3)', 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(25, 'Footsteps to be cleaned thoroughly (Total marks: 3)', 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(26, 'Cleaning/polishing of amenity fittings (Total marks: 3)', 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(27, 'Cleaning/polishing of door handles etc (Total marks: 3)', 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(28, 'All glass windows should be cleaned so that no spot is visible. Window sill area needs special cleaning to remove pan stains/spit stains using portable electric scrubber (Total marks: 3)', 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07'),
(29, 'Panes of Louver shutter should also be cleaned with wet cloth. In the case of Vande bharat, All luggage racks should be cleaned. (Total marks: 3)', 2, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(30, 'Dry & wet vacuum cleaning in inaccessible areas like behind panels (Total marks: 3)', 2, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(31, 'Visible portion of the exterior Roof should be cleaned using a long brush. (Total marks: 3)', 2, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(32, 'Complete exterior cleaning (Total marks: 3)', 2, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(33, 'All items of daily cleaning attention (Total marks: 3)', 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(34, 'Apply polish to the stainless steel wash basins and other items as required. (Total marks: 3)', 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(35, 'Buffing of stainless steel items such as wash basins, wall protector and lavatory pans etc. (Total marks: 3)', 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(36, 'PVC floor cleaning using electric floor scrubber and vacuum cleaner (Total marks: 3)', 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(37, 'Cleaning of Seat/Berths using portable electric disc scrubber (Cleaning of Seat/Berths using portable wet & dry vacuum cleaner - Only For vande bharat coach seats) Berth flap should be cleaned with wet cloth (Total marks: 3)', 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(38, 'Cleaning of LP Sheet and Roof. No graffiti/sticker/cobweb/spot should be visible after cleaning attention. (Total marks: 3)', 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(39, 'Cleaning of Doorway & vestibule area with scrubber and Vacuum machines (Total marks: 3)', 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(40, 'Corners and dustbins to be cleaned with nylon brush. Cleaning of dustbins & dismantling/assembling if required (Total marks: 3)', 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(41, 'Footsteps to be cleaned thoroughly (Total marks: 3)', 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(42, 'Cleaning/polishing of amenity fittings (Total marks: 3)', 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(43, 'Cleaning/polishing of door handles etc (Total marks: 3)', 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(44, 'All glass windows should be cleaned so that no spot is visible. Window sill area needs special cleaning to remove pan stains/spit stains using portable electric scrubber (Total marks: 3)', 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(45, 'Panes of Louver shutter should also be cleaned with wet cloth. In the case of Vande bharat, All luggage racks should be cleaned. (Total marks: 3)', 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(46, 'Dry & wet vacuum cleaning in inaccessible areas like behind panels (Total marks: 3)', 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(47, 'Visible portion of the exterior Roof should be cleaned using a long brush. (Total marks: 3)', 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(48, 'Complete exterior cleaning (Total marks: 3)', 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_scorecard_2_rating`
--

CREATE TABLE `mcc_intensive_scorecard_2_rating` (
  `id` int(11) NOT NULL,
  `rating_name` varchar(50) NOT NULL,
  `rating_value` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `rating_group` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_scorecard_2_rating`
--

INSERT INTO `mcc_intensive_scorecard_2_rating` (`id`, `rating_name`, `rating_value`, `created_at`, `rating_group`) VALUES
(1, 'Very Good', '3', '2026-08-27 09:07:46', 'cleaning'),
(2, 'Satisfactory', '2', '2026-08-27 09:07:46', 'cleaning'),
(3, 'Poor', '1', '2026-08-27 09:07:46', 'cleaning'),
(4, 'Not attended', '0', '2026-08-27 09:07:46', 'cleaning'),
(5, 'Yes', 'Y', '2026-08-27 09:07:46', 'watering'),
(6, 'No', 'N', '2026-08-27 09:07:46', 'watering');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_scorecard_2_report`
--

CREATE TABLE `mcc_intensive_scorecard_2_report` (
  `id` int(11) NOT NULL,
  `sub_parameter_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `token_id` varchar(100) NOT NULL,
  `train_no` varchar(50) NOT NULL,
  `coach_no` varchar(20) NOT NULL,
  `score_value` varchar(10) NOT NULL,
  `submitted_by` varchar(150) NOT NULL DEFAULT 'prabhunath',
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_scorecard_2_report`
--

INSERT INTO `mcc_intensive_scorecard_2_report` (`id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `submitted_by`, `report_date`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(2, 2, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(3, 3, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:10:34'),
(4, 4, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(5, 5, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(6, 6, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:10:34'),
(7, 7, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:10:34'),
(8, 8, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:10:43'),
(9, 9, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:10:43'),
(10, 10, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(11, 11, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(12, 12, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(13, 13, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(14, 14, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(15, 15, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:10:57'),
(16, 16, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(17, 17, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:10:57'),
(18, 18, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(19, 19, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(20, 20, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:10:57'),
(21, 21, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:10:57'),
(22, 22, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(23, 23, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(24, 24, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(25, 25, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(26, 26, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(27, 27, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(28, 28, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(29, 29, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(30, 30, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(31, 31, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(32, 32, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(33, 33, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(34, 34, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(35, 35, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(36, 36, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(37, 37, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(38, 38, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(39, 39, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:21'),
(40, 40, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:21'),
(41, 41, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(42, 42, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(43, 43, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(44, 44, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:21'),
(45, 45, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:26'),
(46, 46, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:32'),
(47, 47, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(48, 48, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(49, 49, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:32'),
(50, 50, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(51, 51, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(52, 52, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:44'),
(53, 53, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(54, 54, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(55, 55, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(56, 56, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:44'),
(57, 57, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:44'),
(58, 58, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:44'),
(59, 59, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(60, 60, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(61, 61, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:44'),
(62, 62, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(63, 63, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(64, 64, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(65, 65, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(66, 66, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(67, 67, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:12:00'),
(68, 68, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(69, 69, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:12:00'),
(70, 70, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(71, 71, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:12:00'),
(72, 72, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(73, 73, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(74, 74, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(75, 75, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:12:05'),
(76, 76, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(77, 1, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(78, 2, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(79, 3, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(80, 4, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(81, 5, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(82, 6, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(83, 7, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(84, 8, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(85, 9, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(86, 10, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(87, 11, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(88, 12, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(89, 13, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(90, 14, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(91, 15, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(92, 16, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(93, 17, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(94, 18, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(95, 19, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(96, 20, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(97, 21, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(98, 22, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(99, 23, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(100, 24, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(101, 25, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(102, 26, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(103, 27, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(104, 28, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(105, 29, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(106, 30, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(107, 31, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(108, 32, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(109, 33, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(110, 34, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(111, 35, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(112, 36, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(113, 37, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(114, 38, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(115, 39, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(116, 40, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(117, 41, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(118, 42, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(119, 43, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(120, 44, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(121, 45, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(122, 46, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(123, 47, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(124, 48, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(125, 49, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(126, 50, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(127, 51, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(128, 52, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(129, 53, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(130, 54, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(131, 55, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(132, 56, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(133, 57, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(134, 58, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(135, 59, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(136, 60, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(137, 61, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(138, 62, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(139, 63, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(140, 64, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(141, 65, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(142, 66, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(143, 67, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(144, 68, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(145, 69, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(146, 70, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(147, 71, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(148, 72, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(149, 73, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(150, 74, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(151, 75, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(152, 76, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(153, 1, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(154, 2, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(155, 3, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(156, 4, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(157, 5, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(158, 6, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(159, 7, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(160, 8, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(161, 9, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(162, 10, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(163, 11, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(164, 12, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(165, 13, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(166, 14, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(167, 15, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(168, 16, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(169, 17, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(170, 18, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(171, 19, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(172, 20, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(173, 21, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(174, 22, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(175, 23, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(176, 24, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(177, 25, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(178, 26, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(179, 27, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(180, 28, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(181, 29, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(182, 30, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(183, 31, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(184, 32, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(185, 33, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(186, 34, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(187, 35, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(188, 36, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(189, 37, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(190, 38, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(191, 39, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(192, 40, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(193, 41, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(194, 42, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(195, 43, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(196, 44, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(197, 45, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(198, 46, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(199, 47, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(200, 48, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(201, 49, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(202, 50, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(203, 51, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(204, 52, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(205, 53, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(206, 54, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(207, 55, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(208, 56, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(209, 57, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(210, 58, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(211, 59, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(212, 60, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(213, 61, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(214, 62, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(215, 63, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(216, 64, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(217, 65, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(218, 66, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(219, 67, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(220, 68, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(221, 69, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(222, 70, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(223, 71, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(224, 72, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(225, 73, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(226, 74, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(227, 75, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(228, 76, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(229, 1, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(230, 2, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(231, 3, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(232, 4, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(233, 5, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(234, 6, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(235, 7, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(236, 8, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(237, 9, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(238, 10, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(239, 11, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(240, 12, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(241, 13, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(242, 14, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(243, 15, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(244, 16, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(245, 17, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(246, 18, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(247, 19, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(248, 20, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(249, 21, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(250, 22, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(251, 23, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(252, 24, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(253, 25, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(254, 26, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(255, 27, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(256, 28, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(257, 29, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(258, 30, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(259, 31, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(260, 32, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(261, 33, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(262, 34, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(263, 35, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(264, 36, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(265, 37, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(266, 38, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(267, 39, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(268, 40, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(269, 41, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(270, 42, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(271, 43, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(272, 44, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(273, 45, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(274, 46, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(275, 47, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(276, 48, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(277, 49, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(278, 50, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(279, 51, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(280, 52, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(281, 53, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(282, 54, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(283, 55, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(284, 56, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(285, 57, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(286, 58, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(287, 59, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(288, 60, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(289, 61, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(290, 62, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(291, 63, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(292, 64, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(293, 65, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(294, 66, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(295, 67, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(296, 68, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(297, 69, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(298, 70, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(299, 71, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(300, 72, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(301, 73, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(302, 74, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(303, 75, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(304, 76, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40'),
(305, 1, 1, 'TKN-20260908-027', '12345', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:35:07'),
(306, 2, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(307, 3, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(308, 4, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(309, 5, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(310, 6, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(311, 7, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(312, 8, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(313, 9, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(314, 10, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(315, 11, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(316, 12, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(317, 13, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(318, 14, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(319, 15, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(320, 16, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(321, 17, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(322, 18, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(323, 19, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(324, 20, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(325, 21, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(326, 22, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(327, 23, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(328, 24, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(329, 25, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(330, 26, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(331, 27, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(332, 28, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(333, 29, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(334, 30, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(335, 31, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(336, 32, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(337, 33, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(338, 34, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(339, 35, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(340, 36, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(341, 37, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(342, 38, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(343, 39, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(344, 40, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(345, 41, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(346, 42, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(347, 43, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(348, 44, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(349, 45, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(350, 46, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(351, 47, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(352, 48, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(353, 49, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(354, 50, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(355, 51, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(356, 52, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(357, 53, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(358, 54, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(359, 55, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(360, 56, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(361, 57, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(362, 58, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(363, 59, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(364, 60, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(365, 61, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(366, 62, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(367, 63, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(368, 64, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(369, 65, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(370, 66, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(371, 67, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(372, 68, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(373, 69, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(374, 70, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(375, 71, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(376, 72, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(377, 73, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(378, 74, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(379, 75, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(380, 76, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54'),
(381, 1, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:17'),
(382, 2, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:21'),
(383, 3, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:21'),
(384, 4, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:21'),
(385, 5, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:21'),
(386, 6, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:21'),
(387, 7, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:21'),
(388, 8, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:25'),
(389, 9, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:25'),
(390, 10, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:25'),
(391, 11, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:25'),
(392, 12, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:32'),
(393, 13, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36'),
(394, 14, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36'),
(395, 15, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36'),
(396, 16, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36'),
(397, 17, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36'),
(398, 18, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36'),
(399, 19, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36'),
(400, 20, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36');
INSERT INTO `mcc_intensive_scorecard_2_report` (`id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `submitted_by`, `report_date`, `created_at`, `updated_at`) VALUES
(401, 21, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36'),
(402, 22, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36'),
(403, 23, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42'),
(404, 24, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42'),
(405, 25, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42'),
(406, 26, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42'),
(407, 27, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42'),
(408, 28, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42'),
(409, 29, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42'),
(410, 30, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42'),
(411, 31, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42'),
(412, 32, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42'),
(413, 33, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42'),
(414, 34, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42'),
(415, 35, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:45'),
(416, 36, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:45'),
(417, 37, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:48'),
(418, 38, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:48'),
(419, 39, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:55'),
(420, 40, 1, 'TKN-20260908-341', '12315', '1', '2', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:55'),
(421, 41, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:55'),
(422, 42, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:55'),
(423, 43, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:55'),
(424, 44, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:55'),
(425, 45, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:58'),
(426, 46, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:03'),
(427, 47, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:03'),
(428, 48, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:03'),
(429, 49, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:03'),
(430, 50, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:03'),
(431, 51, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:03'),
(432, 52, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07'),
(433, 53, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07'),
(434, 54, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07'),
(435, 55, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07'),
(436, 56, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07'),
(437, 57, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07'),
(438, 58, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07'),
(439, 59, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07'),
(440, 60, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07'),
(441, 61, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07'),
(442, 62, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14'),
(443, 63, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14'),
(444, 64, 1, 'TKN-20260908-341', '12315', '1', '2', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14'),
(445, 65, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14'),
(446, 66, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14'),
(447, 67, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14'),
(448, 68, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14'),
(449, 69, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14'),
(450, 70, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14'),
(451, 71, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14'),
(452, 72, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:18'),
(453, 73, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:21'),
(454, 74, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:21'),
(455, 75, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:24'),
(456, 76, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:24'),
(457, 1, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:37'),
(458, 2, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:40'),
(459, 3, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:40'),
(460, 4, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:40'),
(461, 5, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:40'),
(462, 6, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:40'),
(463, 7, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:40'),
(464, 8, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:46'),
(465, 9, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:46'),
(466, 10, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:46'),
(467, 11, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:46'),
(468, 12, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:50'),
(469, 13, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54'),
(470, 14, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54'),
(471, 15, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54'),
(472, 16, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54'),
(473, 17, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54'),
(474, 18, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54'),
(475, 19, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54'),
(476, 20, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54'),
(477, 21, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54'),
(478, 22, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54'),
(479, 23, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59'),
(480, 24, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59'),
(481, 25, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59'),
(482, 26, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59'),
(483, 27, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59'),
(484, 28, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59'),
(485, 29, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59'),
(486, 30, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59'),
(487, 31, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59'),
(488, 32, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59'),
(489, 33, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59'),
(490, 34, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59'),
(491, 35, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:02'),
(492, 36, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:02'),
(493, 37, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:05'),
(494, 38, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:05'),
(495, 39, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:09'),
(496, 40, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:09'),
(497, 41, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:09'),
(498, 42, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:09'),
(499, 43, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:09'),
(500, 44, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:09'),
(501, 45, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:13'),
(502, 46, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:18'),
(503, 47, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:18'),
(504, 48, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:18'),
(505, 49, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:18'),
(506, 50, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:18'),
(507, 51, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:18'),
(508, 52, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25'),
(509, 53, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25'),
(510, 54, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25'),
(511, 55, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25'),
(512, 56, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25'),
(513, 57, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25'),
(514, 58, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25'),
(515, 59, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25'),
(516, 60, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25'),
(517, 61, 1, 'TKN-20260908-286', '16236', '1', '2', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25'),
(518, 62, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31'),
(519, 63, 1, 'TKN-20260908-286', '16236', '1', '2', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31'),
(520, 64, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31'),
(521, 65, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31'),
(522, 66, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31'),
(523, 67, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31'),
(524, 68, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31'),
(525, 69, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31'),
(526, 70, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31'),
(527, 71, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31'),
(528, 72, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:34'),
(529, 73, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:38'),
(530, 74, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:38'),
(531, 75, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:43'),
(532, 76, 1, 'TKN-20260908-286', '16236', '1', '2', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:43');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_scorecard_2_sub_param`
--

CREATE TABLE `mcc_intensive_scorecard_2_sub_param` (
  `id` int(11) NOT NULL,
  `sub_parameter_name` varchar(255) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `input_type` varchar(50) DEFAULT 'cleaning'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_scorecard_2_sub_param`
--

INSERT INTO `mcc_intensive_scorecard_2_sub_param` (`id`, `sub_parameter_name`, `parameter_id`, `station_id`, `status`, `created_at`, `updated_at`, `input_type`) VALUES
(1, 'Daily', 1, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(2, 'Basin 1', 2, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(3, 'Basin 2', 2, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(4, 'Basin 3', 2, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(5, 'Basin 4', 2, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(6, 'Basin 5', 2, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(7, 'Basin 6', 2, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(8, 'Toilet 1', 3, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(9, 'Toilet 2', 3, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(10, 'Toilet 3', 3, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(11, 'Toilet 4', 3, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(12, 'Floor', 4, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(13, 'Bay 1', 5, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(14, 'Bay 2', 5, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(15, 'Bay 3', 5, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(16, 'Bay 4', 5, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(17, 'Bay 5', 5, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(18, 'Bay 6', 5, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(19, 'Bay 7', 5, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(20, 'Bay 8', 5, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(21, 'Bay 9', 5, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(22, 'Bay 10', 5, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(23, 'Bay 1', 6, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(24, 'Bay 2', 6, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(25, 'Bay 3', 6, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(26, 'Bay 4', 6, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(27, 'Bay 5', 6, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(28, 'Bay 6', 6, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(29, 'Bay 7', 6, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(30, 'Bay 8', 6, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(31, 'Bay 9', 6, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(32, 'Bay 10', 6, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(33, 'AP End', 6, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(34, 'SBC End', 6, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(35, 'AP End', 7, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(36, 'SBC End', 7, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(37, 'AP End', 8, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(38, 'SBC End', 8, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(39, 'Foot Step 1', 9, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(40, 'Foot Step 2', 9, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(41, 'Foot Step 3', 9, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(42, 'Foot Step 4', 9, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(43, 'Foot Step 5', 9, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(44, 'Foot Step 6', 9, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(45, 'Amenity', 10, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(46, 'Door 1', 11, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(47, 'door 2', 11, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(48, 'Door 3', 11, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(49, 'Door 4', 11, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(50, 'Door 5', 11, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(51, 'Door 6', 11, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(52, 'Bay 1', 12, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(53, 'Bay 2', 12, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(54, 'Bay 3', 12, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(55, 'Bay 4', 12, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(56, 'Bay 5', 12, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(57, 'Bay 6', 12, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(58, 'Bay 7', 12, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(59, 'Bay 8', 12, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(60, 'bay 9', 12, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(61, 'Bay 10', 12, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(62, 'Bay 1', 13, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(63, 'Bay 2', 13, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(64, 'Bay 3', 13, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(65, 'Bay 4', 13, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(66, 'Bay 5', 13, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(67, 'Bay 6', 13, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(68, 'Bay 7', 13, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(69, 'Bay 8', 13, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(70, 'bay 9', 13, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(71, 'Bay 10', 13, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(72, 'Vacuum', 14, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(73, 'East Side', 15, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(74, 'West Side', 15, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(75, 'East Side', 16, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(76, 'West Side', 16, 1, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(77, 'Daily', 17, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(78, 'Basin 1', 18, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(79, 'Basin 2', 18, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(80, 'Basin 3', 18, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(81, 'Basin 4', 18, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(82, 'Basin 5', 18, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(83, 'Basin 6', 18, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(84, 'Toilet 1', 19, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(85, 'Toilet 2', 19, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(86, 'Toilet 3', 19, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(87, 'Toilet 4', 19, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(88, 'Floor', 20, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(89, 'Bay 1', 21, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(90, 'Bay 2', 21, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(91, 'Bay 3', 21, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(92, 'Bay 4', 21, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(93, 'Bay 5', 21, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(94, 'Bay 6', 21, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(95, 'Bay 7', 21, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(96, 'Bay 8', 21, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(97, 'Bay 9', 21, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(98, 'Bay 10', 21, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(99, 'Bay 1', 22, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(100, 'Bay 2', 22, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(101, 'Bay 3', 22, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(102, 'Bay 4', 22, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(103, 'Bay 5', 22, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(104, 'Bay 6', 22, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(105, 'Bay 7', 22, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(106, 'Bay 8', 22, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(107, 'Bay 9', 22, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(108, 'Bay 10', 22, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(109, 'AP End', 22, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(110, 'SBC End', 22, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(111, 'AP End', 23, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(112, 'SBC End', 23, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(113, 'AP End', 24, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(114, 'SBC End', 24, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(115, 'Foot Step 1', 25, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(116, 'Foot Step 2', 25, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(117, 'Foot Step 3', 25, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(118, 'Foot Step 4', 25, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(119, 'Foot Step 5', 25, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(120, 'Foot Step 6', 25, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(121, 'Amenity', 26, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(122, 'Door 1', 27, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(123, 'door 2', 27, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(124, 'Door 3', 27, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(125, 'Door 4', 27, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(126, 'Door 5', 27, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(127, 'Door 6', 27, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(128, 'Bay 1', 28, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(129, 'Bay 2', 28, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(130, 'Bay 3', 28, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(131, 'Bay 4', 28, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(132, 'Bay 5', 28, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(133, 'Bay 6', 28, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(134, 'Bay 7', 28, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(135, 'Bay 8', 28, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(136, 'bay 9', 28, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(137, 'Bay 10', 28, 2, 'Active', '2026-08-14 10:08:07', '2026-08-14 10:08:07', 'cleaning'),
(138, 'Bay 1', 29, 2, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(139, 'Bay 2', 29, 2, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(140, 'Bay 3', 29, 2, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(141, 'Bay 4', 29, 2, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(142, 'Bay 5', 29, 2, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(143, 'Bay 6', 29, 2, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(144, 'Bay 7', 29, 2, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(145, 'Bay 8', 29, 2, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(146, 'bay 9', 29, 2, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(147, 'Bay 10', 29, 2, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(148, 'Vacuum', 30, 2, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(149, 'East Side', 31, 2, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(150, 'West Side', 31, 2, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(151, 'East Side', 32, 2, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(152, 'West Side', 32, 2, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(153, 'Daily', 33, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(154, 'Basin 1', 34, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(155, 'Basin 2', 34, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(156, 'Basin 3', 34, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(157, 'Basin 4', 34, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(158, 'Basin 5', 34, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(159, 'Basin 6', 34, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(160, 'Toilet 1', 35, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(161, 'Toilet 2', 35, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(162, 'Toilet 3', 35, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(163, 'Toilet 4', 35, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(164, 'Floor', 36, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(165, 'Bay 1', 37, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(166, 'Bay 2', 37, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(167, 'Bay 3', 37, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(168, 'Bay 4', 37, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(169, 'Bay 5', 37, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(170, 'Bay 6', 37, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(171, 'Bay 7', 37, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(172, 'Bay 8', 37, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(173, 'Bay 9', 37, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(174, 'Bay 10', 37, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(175, 'Bay 1', 38, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(176, 'Bay 2', 38, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(177, 'Bay 3', 38, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(178, 'Bay 4', 38, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(179, 'Bay 5', 38, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(180, 'Bay 6', 38, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(181, 'Bay 7', 38, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(182, 'Bay 8', 38, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(183, 'Bay 9', 38, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(184, 'Bay 10', 38, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(185, 'AP End', 38, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(186, 'SBC End', 38, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(187, 'AP End', 39, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(188, 'SBC End', 39, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(189, 'AP End', 40, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(190, 'SBC End', 40, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(191, 'Foot Step 1', 41, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(192, 'Foot Step 2', 41, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(193, 'Foot Step 3', 41, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(194, 'Foot Step 4', 41, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(195, 'Foot Step 5', 41, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(196, 'Foot Step 6', 41, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(197, 'Amenity', 42, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(198, 'Door 1', 43, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(199, 'door 2', 43, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(200, 'Door 3', 43, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(201, 'Door 4', 43, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(202, 'Door 5', 43, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(203, 'Door 6', 43, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(204, 'Bay 1', 44, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(205, 'Bay 2', 44, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(206, 'Bay 3', 44, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(207, 'Bay 4', 44, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(208, 'Bay 5', 44, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(209, 'Bay 6', 44, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(210, 'Bay 7', 44, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(211, 'Bay 8', 44, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(212, 'bay 9', 44, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(213, 'Bay 10', 44, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(214, 'Bay 1', 45, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(215, 'Bay 2', 45, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(216, 'Bay 3', 45, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(217, 'Bay 4', 45, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(218, 'Bay 5', 45, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(219, 'Bay 6', 45, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(220, 'Bay 7', 45, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(221, 'Bay 8', 45, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(222, 'bay 9', 45, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(223, 'Bay 10', 45, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(224, 'Vacuum', 46, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(225, 'East Side', 47, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(226, 'West Side', 47, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(227, 'East Side', 48, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(228, 'West Side', 48, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_scorecard_param`
--

CREATE TABLE `mcc_intensive_scorecard_param` (
  `id` int(11) NOT NULL,
  `parameter_name` varchar(255) NOT NULL,
  `station_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_scorecard_param`
--

INSERT INTO `mcc_intensive_scorecard_param` (`id`, `parameter_name`, `station_id`, `status`, `created_at`, `updated_at`) VALUES
(4, 'Coach Interior Cleaning', 1, 'Active', '2026-06-12 06:40:03', '2026-06-12 06:40:03'),
(5, 'Coach Exterior Cleaning', 1, 'Active', '2026-06-12 06:40:03', '2026-06-12 06:40:03'),
(6, 'Watering Status', 1, 'Active', '2026-06-12 06:40:03', '2026-06-12 06:40:03');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_scorecard_report`
--

CREATE TABLE `mcc_intensive_scorecard_report` (
  `id` int(11) NOT NULL,
  `sub_parameter_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `token_id` varchar(100) NOT NULL,
  `train_no` varchar(50) NOT NULL,
  `coach_no` varchar(20) NOT NULL,
  `score_value` varchar(10) NOT NULL,
  `submitted_by` int(11) NOT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_scorecard_report`
--

INSERT INTO `mcc_intensive_scorecard_report` (`id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `submitted_by`, `report_date`, `created_at`, `updated_at`) VALUES
(1, 7, 1, 'TKN-INT-20260612-001', '12501', 'C1', '3', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(2, 8, 1, 'TKN-INT-20260612-001', '12501', 'C1', '3', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(3, 9, 1, 'TKN-INT-20260612-001', '12501', 'C1', '2', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(4, 10, 1, 'TKN-INT-20260612-001', '12501', 'C1', '3', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(5, 11, 1, 'TKN-INT-20260612-001', '12501', 'C1', '3', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(6, 12, 1, 'TKN-INT-20260612-001', '12501', 'C1', 'Y', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(7, 7, 1, 'TKN-INT-20260612-001', '12501', 'C2', '3', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(8, 8, 1, 'TKN-INT-20260612-001', '12501', 'C2', '2', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(9, 9, 1, 'TKN-INT-20260612-001', '12501', 'C2', '3', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(10, 10, 1, 'TKN-INT-20260612-001', '12501', 'C2', '2', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(11, 11, 1, 'TKN-INT-20260612-001', '12501', 'C2', '3', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(12, 12, 1, 'TKN-INT-20260612-001', '12501', 'C2', 'Y', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(13, 7, 1, 'TKN-INT-20260612-001', '12501', 'C3', '2', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(14, 8, 1, 'TKN-INT-20260612-001', '12501', 'C3', '3', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(15, 9, 1, 'TKN-INT-20260612-001', '12501', 'C3', '3', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(16, 10, 1, 'TKN-INT-20260612-001', '12501', 'C3', '3', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(17, 11, 1, 'TKN-INT-20260612-001', '12501', 'C3', '2', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(18, 12, 1, 'TKN-INT-20260612-001', '12501', 'C3', 'N', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(19, 7, 1, 'TKN-INT-20260612-001', '12501', 'C4', '3', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(20, 8, 1, 'TKN-INT-20260612-001', '12501', 'C4', '3', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(21, 9, 1, 'TKN-INT-20260612-001', '12501', 'C4', '3', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(22, 10, 1, 'TKN-INT-20260612-001', '12501', 'C4', '3', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(23, 11, 1, 'TKN-INT-20260612-001', '12501', 'C4', '3', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22'),
(24, 12, 1, 'TKN-INT-20260612-001', '12501', 'C4', 'Y', 2, '2026-06-12', '2026-06-12 06:47:22', '2026-06-12 06:47:22');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_scorecard_sub_param`
--

CREATE TABLE `mcc_intensive_scorecard_sub_param` (
  `id` int(11) NOT NULL,
  `sub_parameter_name` varchar(255) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_scorecard_sub_param`
--

INSERT INTO `mcc_intensive_scorecard_sub_param` (`id`, `sub_parameter_name`, `parameter_id`, `station_id`, `status`, `created_at`, `updated_at`) VALUES
(7, 'Cleaning and wiping of toilet area and fittings including wash basins, mirrors. Cleaning of mugs in AC coaches', 4, 1, 'Active', '2026-06-12 06:40:03', '2026-06-12 06:40:03'),
(8, 'Interior Cleaning of compartments, doorways, gang ways, vestibules, Window glass, window shutter etc.', 4, 1, 'Active', '2026-06-12 06:40:03', '2026-06-12 06:40:03'),
(9, 'Cleaning & wiping of all berths, Panels, Rexene & amenity fittings.', 4, 1, 'Active', '2026-06-12 06:40:03', '2026-06-12 06:40:03'),
(10, 'Floor including area under seats/berths etc.', 4, 1, 'Active', '2026-06-12 06:40:03', '2026-06-12 06:40:03'),
(11, 'Exterior Cleaning / washing including end panel', 5, 1, 'Active', '2026-06-12 06:40:03', '2026-06-12 06:40:03'),
(12, 'Please mention Yes/ No', 6, 1, 'Active', '2026-06-12 06:40:03', '2026-06-12 06:40:03');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_score_card`
--

CREATE TABLE `mcc_intensive_score_card` (
  `id` int(11) NOT NULL,
  `sub_report_id` int(11) NOT NULL,
  `sub_parameter_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `token_id` varchar(100) NOT NULL,
  `train_no` varchar(50) NOT NULL,
  `coach_no` varchar(20) NOT NULL,
  `score_value` varchar(10) NOT NULL,
  `submitted_by` int(11) NOT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_score_card`
--

INSERT INTO `mcc_intensive_score_card` (`id`, `sub_report_id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `submitted_by`, `report_date`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 'TKN-20260522-001', '12301', 'C1', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(2, 1, 1, 1, 'TKN-20260522-001', '12301', 'C2', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(3, 1, 1, 1, 'TKN-20260522-001', '12301', 'C3', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(4, 1, 1, 1, 'TKN-20260522-001', '12301', 'C4', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(5, 1, 1, 1, 'TKN-20260522-001', '12301', 'C5', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(6, 1, 1, 1, 'TKN-20260522-001', '12301', 'C6', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(7, 1, 1, 1, 'TKN-20260522-001', '12301', 'C7', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(8, 1, 1, 1, 'TKN-20260522-001', '12301', 'C8', '1', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(9, 1, 1, 1, 'TKN-20260522-001', '12301', 'C9', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(10, 1, 1, 1, 'TKN-20260522-001', '12301', 'C10', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(11, 1, 1, 1, 'TKN-20260522-001', '12301', 'C11', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(12, 1, 1, 1, 'TKN-20260522-001', '12301', 'C12', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(13, 1, 1, 1, 'TKN-20260522-001', '12301', 'C13', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(14, 1, 1, 1, 'TKN-20260522-001', '12301', 'C14', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(15, 1, 1, 1, 'TKN-20260522-001', '12301', 'C15', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(16, 1, 1, 1, 'TKN-20260522-001', '12301', 'C16', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(17, 1, 1, 1, 'TKN-20260522-001', '12301', 'C17', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(18, 1, 1, 1, 'TKN-20260522-001', '12301', 'C18', '1', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(19, 1, 1, 1, 'TKN-20260522-001', '12301', 'C19', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(20, 1, 1, 1, 'TKN-20260522-001', '12301', 'C20', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(21, 1, 1, 1, 'TKN-20260522-001', '12301', 'C21', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(22, 1, 1, 1, 'TKN-20260522-001', '12301', 'C22', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(23, 1, 1, 1, 'TKN-20260522-001', '12301', 'C23', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(24, 1, 1, 1, 'TKN-20260522-001', '12301', 'C24', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(25, 1, 2, 1, 'TKN-20260522-001', '12301', 'C1', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(26, 1, 2, 1, 'TKN-20260522-001', '12301', 'C2', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(27, 1, 2, 1, 'TKN-20260522-001', '12301', 'C3', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(28, 1, 2, 1, 'TKN-20260522-001', '12301', 'C4', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(29, 1, 2, 1, 'TKN-20260522-001', '12301', 'C5', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(30, 1, 2, 1, 'TKN-20260522-001', '12301', 'C6', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(31, 1, 2, 1, 'TKN-20260522-001', '12301', 'C7', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(32, 1, 2, 1, 'TKN-20260522-001', '12301', 'C8', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(33, 1, 2, 1, 'TKN-20260522-001', '12301', 'C9', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(34, 1, 2, 1, 'TKN-20260522-001', '12301', 'C10', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(35, 1, 2, 1, 'TKN-20260522-001', '12301', 'C11', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(36, 1, 2, 1, 'TKN-20260522-001', '12301', 'C12', '1', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(37, 1, 2, 1, 'TKN-20260522-001', '12301', 'C13', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(38, 1, 2, 1, 'TKN-20260522-001', '12301', 'C14', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(39, 1, 2, 1, 'TKN-20260522-001', '12301', 'C15', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(40, 1, 2, 1, 'TKN-20260522-001', '12301', 'C16', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(41, 1, 2, 1, 'TKN-20260522-001', '12301', 'C17', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(42, 1, 2, 1, 'TKN-20260522-001', '12301', 'C18', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(43, 1, 2, 1, 'TKN-20260522-001', '12301', 'C19', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(44, 1, 2, 1, 'TKN-20260522-001', '12301', 'C20', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(45, 1, 2, 1, 'TKN-20260522-001', '12301', 'C21', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(46, 1, 2, 1, 'TKN-20260522-001', '12301', 'C22', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(47, 1, 2, 1, 'TKN-20260522-001', '12301', 'C23', '1', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(48, 1, 2, 1, 'TKN-20260522-001', '12301', 'C24', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(49, 1, 3, 1, 'TKN-20260522-001', '12301', 'C1', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(50, 1, 3, 1, 'TKN-20260522-001', '12301', 'C2', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(51, 1, 3, 1, 'TKN-20260522-001', '12301', 'C3', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(52, 1, 3, 1, 'TKN-20260522-001', '12301', 'C4', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(53, 1, 3, 1, 'TKN-20260522-001', '12301', 'C5', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(54, 1, 3, 1, 'TKN-20260522-001', '12301', 'C6', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(55, 1, 3, 1, 'TKN-20260522-001', '12301', 'C7', '1', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(56, 1, 3, 1, 'TKN-20260522-001', '12301', 'C8', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(57, 1, 3, 1, 'TKN-20260522-001', '12301', 'C9', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(58, 1, 3, 1, 'TKN-20260522-001', '12301', 'C10', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(59, 1, 3, 1, 'TKN-20260522-001', '12301', 'C11', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(60, 1, 3, 1, 'TKN-20260522-001', '12301', 'C12', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(61, 1, 3, 1, 'TKN-20260522-001', '12301', 'C13', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(62, 1, 3, 1, 'TKN-20260522-001', '12301', 'C14', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(63, 1, 3, 1, 'TKN-20260522-001', '12301', 'C15', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(64, 1, 3, 1, 'TKN-20260522-001', '12301', 'C16', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(65, 1, 3, 1, 'TKN-20260522-001', '12301', 'C17', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(66, 1, 3, 1, 'TKN-20260522-001', '12301', 'C18', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(67, 1, 3, 1, 'TKN-20260522-001', '12301', 'C19', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(68, 1, 3, 1, 'TKN-20260522-001', '12301', 'C20', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(69, 1, 3, 1, 'TKN-20260522-001', '12301', 'C21', '1', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(70, 1, 3, 1, 'TKN-20260522-001', '12301', 'C22', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(71, 1, 3, 1, 'TKN-20260522-001', '12301', 'C23', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(72, 1, 3, 1, 'TKN-20260522-001', '12301', 'C24', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(73, 1, 4, 1, 'TKN-20260522-001', '12301', 'C1', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(74, 1, 4, 1, 'TKN-20260522-001', '12301', 'C2', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(75, 1, 4, 1, 'TKN-20260522-001', '12301', 'C3', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(76, 1, 4, 1, 'TKN-20260522-001', '12301', 'C4', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(77, 1, 4, 1, 'TKN-20260522-001', '12301', 'C5', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(78, 1, 4, 1, 'TKN-20260522-001', '12301', 'C6', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(79, 1, 4, 1, 'TKN-20260522-001', '12301', 'C7', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(80, 1, 4, 1, 'TKN-20260522-001', '12301', 'C8', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(81, 1, 4, 1, 'TKN-20260522-001', '12301', 'C9', '1', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(82, 1, 4, 1, 'TKN-20260522-001', '12301', 'C10', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(83, 1, 4, 1, 'TKN-20260522-001', '12301', 'C11', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(84, 1, 4, 1, 'TKN-20260522-001', '12301', 'C12', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(85, 1, 4, 1, 'TKN-20260522-001', '12301', 'C13', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(86, 1, 4, 1, 'TKN-20260522-001', '12301', 'C14', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(87, 1, 4, 1, 'TKN-20260522-001', '12301', 'C15', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(88, 1, 4, 1, 'TKN-20260522-001', '12301', 'C16', '1', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(89, 1, 4, 1, 'TKN-20260522-001', '12301', 'C17', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(90, 1, 4, 1, 'TKN-20260522-001', '12301', 'C18', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(91, 1, 4, 1, 'TKN-20260522-001', '12301', 'C19', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(92, 1, 4, 1, 'TKN-20260522-001', '12301', 'C20', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(93, 1, 4, 1, 'TKN-20260522-001', '12301', 'C21', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(94, 1, 4, 1, 'TKN-20260522-001', '12301', 'C22', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(95, 1, 4, 1, 'TKN-20260522-001', '12301', 'C23', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(96, 1, 4, 1, 'TKN-20260522-001', '12301', 'C24', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(97, 1, 5, 1, 'TKN-20260522-001', '12301', 'C1', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(98, 1, 5, 1, 'TKN-20260522-001', '12301', 'C2', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(99, 1, 5, 1, 'TKN-20260522-001', '12301', 'C3', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(100, 1, 5, 1, 'TKN-20260522-001', '12301', 'C4', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(101, 1, 5, 1, 'TKN-20260522-001', '12301', 'C5', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(102, 1, 5, 1, 'TKN-20260522-001', '12301', 'C6', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(103, 1, 5, 1, 'TKN-20260522-001', '12301', 'C7', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(104, 1, 5, 1, 'TKN-20260522-001', '12301', 'C8', '1', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(105, 1, 5, 1, 'TKN-20260522-001', '12301', 'C9', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(106, 1, 5, 1, 'TKN-20260522-001', '12301', 'C10', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(107, 1, 5, 1, 'TKN-20260522-001', '12301', 'C11', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(108, 1, 5, 1, 'TKN-20260522-001', '12301', 'C12', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(109, 1, 5, 1, 'TKN-20260522-001', '12301', 'C13', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(110, 1, 5, 1, 'TKN-20260522-001', '12301', 'C14', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(111, 1, 5, 1, 'TKN-20260522-001', '12301', 'C15', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(112, 1, 5, 1, 'TKN-20260522-001', '12301', 'C16', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(113, 1, 5, 1, 'TKN-20260522-001', '12301', 'C17', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(114, 1, 5, 1, 'TKN-20260522-001', '12301', 'C18', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(115, 1, 5, 1, 'TKN-20260522-001', '12301', 'C19', '2', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(116, 1, 5, 1, 'TKN-20260522-001', '12301', 'C20', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(117, 1, 5, 1, 'TKN-20260522-001', '12301', 'C21', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(118, 1, 5, 1, 'TKN-20260522-001', '12301', 'C22', '1', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(119, 1, 5, 1, 'TKN-20260522-001', '12301', 'C23', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(120, 1, 5, 1, 'TKN-20260522-001', '12301', 'C24', '3', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(121, 1, 6, 1, 'TKN-20260522-001', '12301', 'C1', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(122, 1, 6, 1, 'TKN-20260522-001', '12301', 'C2', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(123, 1, 6, 1, 'TKN-20260522-001', '12301', 'C3', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(124, 1, 6, 1, 'TKN-20260522-001', '12301', 'C4', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(125, 1, 6, 1, 'TKN-20260522-001', '12301', 'C5', 'N', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(126, 1, 6, 1, 'TKN-20260522-001', '12301', 'C6', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(127, 1, 6, 1, 'TKN-20260522-001', '12301', 'C7', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(128, 1, 6, 1, 'TKN-20260522-001', '12301', 'C8', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(129, 1, 6, 1, 'TKN-20260522-001', '12301', 'C9', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(130, 1, 6, 1, 'TKN-20260522-001', '12301', 'C10', 'N', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(131, 1, 6, 1, 'TKN-20260522-001', '12301', 'C11', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(132, 1, 6, 1, 'TKN-20260522-001', '12301', 'C12', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(133, 1, 6, 1, 'TKN-20260522-001', '12301', 'C13', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(134, 1, 6, 1, 'TKN-20260522-001', '12301', 'C14', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(135, 1, 6, 1, 'TKN-20260522-001', '12301', 'C15', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(136, 1, 6, 1, 'TKN-20260522-001', '12301', 'C16', 'N', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(137, 1, 6, 1, 'TKN-20260522-001', '12301', 'C17', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(138, 1, 6, 1, 'TKN-20260522-001', '12301', 'C18', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(139, 1, 6, 1, 'TKN-20260522-001', '12301', 'C19', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(140, 1, 6, 1, 'TKN-20260522-001', '12301', 'C20', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(141, 1, 6, 1, 'TKN-20260522-001', '12301', 'C21', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(142, 1, 6, 1, 'TKN-20260522-001', '12301', 'C22', 'N', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(143, 1, 6, 1, 'TKN-20260522-001', '12301', 'C23', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(144, 1, 6, 1, 'TKN-20260522-001', '12301', 'C24', 'Y', 2, '2026-05-22', '2026-05-22 11:36:28', '2026-05-22 11:36:28'),
(145, 10, 37, 1, 'TKN-20260609-010', '12018', 'C1', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(146, 10, 38, 1, 'TKN-20260609-010', '12018', 'C1', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(147, 10, 39, 1, 'TKN-20260609-010', '12018', 'C1', '2', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(148, 10, 40, 1, 'TKN-20260609-010', '12018', 'C1', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(149, 10, 41, 1, 'TKN-20260609-010', '12018', 'C1', 'Y', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(150, 10, 42, 1, 'TKN-20260609-010', '12018', 'C1', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(151, 10, 43, 1, 'TKN-20260609-010', '12018', 'C1', 'Y', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(152, 10, 37, 1, 'TKN-20260609-010', '12018', 'C2', '2', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(153, 10, 38, 1, 'TKN-20260609-010', '12018', 'C2', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(154, 10, 39, 1, 'TKN-20260609-010', '12018', 'C2', '2', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(155, 10, 40, 1, 'TKN-20260609-010', '12018', 'C2', '2', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(156, 10, 41, 1, 'TKN-20260609-010', '12018', 'C2', 'Y', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(157, 10, 42, 1, 'TKN-20260609-010', '12018', 'C2', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(158, 10, 43, 1, 'TKN-20260609-010', '12018', 'C2', 'Y', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(159, 10, 37, 1, 'TKN-20260609-010', '12018', 'C3', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(160, 10, 38, 1, 'TKN-20260609-010', '12018', 'C3', '2', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(161, 10, 39, 1, 'TKN-20260609-010', '12018', 'C3', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(162, 10, 40, 1, 'TKN-20260609-010', '12018', 'C3', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(163, 10, 41, 1, 'TKN-20260609-010', '12018', 'C3', 'Y', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(164, 10, 42, 1, 'TKN-20260609-010', '12018', 'C3', '2', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(165, 10, 43, 1, 'TKN-20260609-010', '12018', 'C3', 'Y', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(166, 10, 37, 1, 'TKN-20260609-010', '12018', 'C4', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(167, 10, 38, 1, 'TKN-20260609-010', '12018', 'C4', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(168, 10, 39, 1, 'TKN-20260609-010', '12018', 'C4', '2', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(169, 10, 40, 1, 'TKN-20260609-010', '12018', 'C4', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(170, 10, 41, 1, 'TKN-20260609-010', '12018', 'C4', 'Y', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(171, 10, 42, 1, 'TKN-20260609-010', '12018', 'C4', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(172, 10, 43, 1, 'TKN-20260609-010', '12018', 'C4', 'Y', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(173, 10, 37, 1, 'TKN-20260609-010', '12018', 'C5', '2', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(174, 10, 38, 1, 'TKN-20260609-010', '12018', 'C5', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(175, 10, 39, 1, 'TKN-20260609-010', '12018', 'C5', '2', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(176, 10, 40, 1, 'TKN-20260609-010', '12018', 'C5', '2', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(177, 10, 41, 1, 'TKN-20260609-010', '12018', 'C5', 'N', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(178, 10, 42, 1, 'TKN-20260609-010', '12018', 'C5', '1', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(179, 10, 43, 1, 'TKN-20260609-010', '12018', 'C5', 'Y', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(180, 10, 37, 1, 'TKN-20260609-010', '12018', 'C6', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(181, 10, 38, 1, 'TKN-20260609-010', '12018', 'C6', '2', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(182, 10, 39, 1, 'TKN-20260609-010', '12018', 'C6', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(183, 10, 40, 1, 'TKN-20260609-010', '12018', 'C6', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(184, 10, 41, 1, 'TKN-20260609-010', '12018', 'C6', 'Y', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(185, 10, 42, 1, 'TKN-20260609-010', '12018', 'C6', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(186, 10, 43, 1, 'TKN-20260609-010', '12018', 'C6', 'Y', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(187, 10, 37, 1, 'TKN-20260609-010', '12018', 'C7', '1', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(188, 10, 38, 1, 'TKN-20260609-010', '12018', 'C7', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(189, 10, 39, 1, 'TKN-20260609-010', '12018', 'C7', '2', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(190, 10, 40, 1, 'TKN-20260609-010', '12018', 'C7', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(191, 10, 41, 1, 'TKN-20260609-010', '12018', 'C7', 'Y', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(192, 10, 42, 1, 'TKN-20260609-010', '12018', 'C7', '2', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(193, 10, 43, 1, 'TKN-20260609-010', '12018', 'C7', 'N', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(194, 10, 37, 1, 'TKN-20260609-010', '12018', 'C8', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(195, 10, 38, 1, 'TKN-20260609-010', '12018', 'C8', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(196, 10, 39, 1, 'TKN-20260609-010', '12018', 'C8', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(197, 10, 40, 1, 'TKN-20260609-010', '12018', 'C8', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(198, 10, 41, 1, 'TKN-20260609-010', '12018', 'C8', 'Y', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(199, 10, 42, 1, 'TKN-20260609-010', '12018', 'C8', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(200, 10, 43, 1, 'TKN-20260609-010', '12018', 'C8', 'Y', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(201, 10, 37, 1, 'TKN-20260609-010', '12018', 'C9', '2', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(202, 10, 38, 1, 'TKN-20260609-010', '12018', 'C9', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(203, 10, 39, 1, 'TKN-20260609-010', '12018', 'C9', '2', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(204, 10, 40, 1, 'TKN-20260609-010', '12018', 'C9', '2', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(205, 10, 41, 1, 'TKN-20260609-010', '12018', 'C9', 'Y', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(206, 10, 42, 1, 'TKN-20260609-010', '12018', 'C9', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(207, 10, 43, 1, 'TKN-20260609-010', '12018', 'C9', 'Y', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(208, 10, 37, 1, 'TKN-20260609-010', '12018', 'C10', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(209, 10, 38, 1, 'TKN-20260609-010', '12018', 'C10', '2', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(210, 10, 39, 1, 'TKN-20260609-010', '12018', 'C10', '2', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(211, 10, 40, 1, 'TKN-20260609-010', '12018', 'C10', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(212, 10, 41, 1, 'TKN-20260609-010', '12018', 'C10', 'Y', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(213, 10, 42, 1, 'TKN-20260609-010', '12018', 'C10', '3', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32'),
(214, 10, 43, 1, 'TKN-20260609-010', '12018', 'C10', 'Y', 2, '2026-06-09', '2026-06-09 12:16:32', '2026-06-09 12:16:32');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_manpower_categories`
--

CREATE TABLE `mcc_manpower_categories` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `order_no` int(11) NOT NULL DEFAULT 0,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_manpower_categories`
--

INSERT INTO `mcc_manpower_categories` (`id`, `station_id`, `category_name`, `order_no`, `status`, `created_at`) VALUES
(17, 1, 'Normal cleaning', 1, 'Active', '2026-08-31 17:40:01'),
(18, 1, 'Intensive Cleaning', 2, 'Active', '2026-08-31 17:40:20'),
(19, 1, 'Depot Cleaning', 3, 'Active', '2026-09-01 05:27:28'),
(20, 1, 'Prt cleaning', 4, 'Active', '2026-09-01 05:28:01'),
(21, 1, 'Vande Bharat', 5, 'Active', '2026-09-01 05:28:46');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_manpower_log`
--

CREATE TABLE `mcc_manpower_log` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `report_date` date NOT NULL,
  `shift_id` int(11) NOT NULL,
  `manpower_type_id` int(11) NOT NULL,
  `provided_qty` int(11) DEFAULT NULL,
  `absent_qty` int(11) DEFAULT NULL,
  `no_dress_qty` int(11) DEFAULT NULL,
  `no_ppe_qty` int(11) DEFAULT NULL,
  `auditor_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_manpower_log`
--

INSERT INTO `mcc_manpower_log` (`id`, `station_id`, `category_id`, `report_date`, `shift_id`, `manpower_type_id`, `provided_qty`, `absent_qty`, `no_dress_qty`, `no_ppe_qty`, `auditor_name`, `created_at`) VALUES
(38, 1, 17, '2026-09-03', 31, 15, 0, 0, 0, 0, 'Bheem Chand', '2026-09-03 12:19:44'),
(39, 1, 17, '2026-09-03', 31, 16, 10, 0, 15, 20, 'Bheem Chand', '2026-09-03 12:21:05'),
(40, 1, 17, '2026-09-03', 32, 15, 0, 0, 0, 0, 'Bheem Chand', '2026-09-03 16:49:36'),
(41, 1, 17, '2026-09-04', 31, 15, 0, 0, 0, 0, 'Bheem Chand', '2026-09-04 10:24:19'),
(42, 1, 17, '2026-09-04', 31, 16, 1, 0, 0, 0, 'Bheem Chand', '2026-09-04 10:24:28'),
(43, 1, 17, '2026-09-07', 31, 15, 0, 0, 0, 0, 'Bheem Chand', '2026-09-07 11:05:08'),
(44, 1, 18, '2026-09-07', 34, 15, 0, 0, 0, 0, 'Bheem Chand', '2026-09-07 11:05:20');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_manpower_penalties`
--

CREATE TABLE `mcc_manpower_penalties` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `effective_month` date NOT NULL,
  `manpower_type_id` int(11) NOT NULL,
  `absent_penalty` decimal(10,2) NOT NULL DEFAULT 0.00,
  `dress_penalty` decimal(10,2) NOT NULL DEFAULT 0.00,
  `gears_penalty` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_manpower_penalties`
--

INSERT INTO `mcc_manpower_penalties` (`id`, `station_id`, `effective_month`, `manpower_type_id`, `absent_penalty`, `dress_penalty`, `gears_penalty`, `created_at`, `updated_at`) VALUES
(1, 1, '2026-06-01', 1, 100.00, 50.00, 50.00, '2026-06-23 12:41:26', '2026-06-23 12:41:26'),
(2, 1, '2026-06-01', 2, 100.00, 50.00, 50.00, '2026-06-23 12:41:26', '2026-06-23 12:41:26'),
(3, 1, '2026-06-01', 3, 100.00, 50.00, 50.00, '2026-06-23 12:41:26', '2026-06-23 12:41:26'),
(4, 1, '2026-06-01', 4, 100.00, 50.00, 50.00, '2026-06-23 12:41:26', '2026-06-23 12:41:26'),
(5, 1, '2026-06-01', 5, 100.00, 50.00, 50.00, '2026-06-23 12:41:26', '2026-06-23 12:41:26'),
(6, 1, '2026-06-01', 6, 100.00, 50.00, 50.00, '2026-06-23 12:41:26', '2026-06-23 12:41:26'),
(7, 1, '2026-06-01', 7, 100.00, 50.00, 50.00, '2026-06-23 12:41:26', '2026-06-23 12:41:26');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_manpower_shifts`
--

CREATE TABLE `mcc_manpower_shifts` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `shift_name` varchar(100) NOT NULL,
  `order_no` int(11) NOT NULL DEFAULT 0,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_manpower_shifts`
--

INSERT INTO `mcc_manpower_shifts` (`id`, `category_id`, `shift_name`, `order_no`, `status`, `created_at`) VALUES
(31, 17, 'Shift 1', 1, 'Active', '2026-09-01 05:29:23'),
(32, 17, 'Shift 2', 2, 'Active', '2026-09-01 05:29:35'),
(33, 17, 'Shift 3', 3, 'Active', '2026-09-01 05:29:48'),
(34, 18, 'Shift 1', 1, 'Active', '2026-09-01 05:30:01'),
(35, 18, 'Shift 2', 2, 'Active', '2026-09-01 05:30:19'),
(36, 18, 'Shift 3', 3, 'Active', '2026-09-01 05:30:37'),
(37, 19, 'Shift 1', 1, 'Active', '2026-09-01 05:31:02'),
(38, 19, 'Shift 2', 2, 'Active', '2026-09-01 05:31:15'),
(39, 19, 'Shift 3', 3, 'Active', '2026-09-01 05:31:34'),
(40, 20, 'Shift 1', 1, 'Active', '2026-09-01 05:31:50'),
(41, 20, 'Shift 2', 2, 'Active', '2026-09-01 05:32:17'),
(42, 20, 'Shift 3', 3, 'Active', '2026-09-01 05:32:37'),
(43, 21, 'Shift 1', 1, 'Active', '2026-09-01 05:32:54'),
(44, 21, 'Shift 2', 2, 'Active', '2026-09-01 05:33:11'),
(45, 21, 'Shift 3', 3, 'Active', '2026-09-01 05:33:26');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_manpower_shift_type_map`
--

CREATE TABLE `mcc_manpower_shift_type_map` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `manpower_type_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_manpower_shift_type_map`
--

INSERT INTO `mcc_manpower_shift_type_map` (`id`, `station_id`, `shift_id`, `manpower_type_id`, `created_at`, `updated_at`) VALUES
(45, 1, 31, 15, '2026-09-01 06:10:22', '2026-09-01 06:10:22'),
(46, 1, 31, 16, '2026-09-01 06:10:33', '2026-09-01 06:10:33'),
(47, 1, 32, 15, '2026-09-01 06:12:06', '2026-09-01 06:12:06'),
(48, 1, 32, 16, '2026-09-01 06:12:15', '2026-09-01 06:12:15'),
(49, 1, 33, 15, '2026-09-01 06:12:29', '2026-09-01 06:12:29'),
(50, 1, 33, 16, '2026-09-01 06:12:40', '2026-09-01 06:12:40'),
(51, 1, 34, 15, '2026-09-01 06:13:07', '2026-09-01 06:13:07'),
(52, 1, 35, 15, '2026-09-01 06:13:22', '2026-09-01 06:13:22'),
(53, 1, 36, 15, '2026-09-01 06:13:30', '2026-09-01 06:13:30'),
(54, 1, 37, 15, '2026-09-01 06:14:25', '2026-09-01 06:14:25'),
(55, 1, 37, 16, '2026-09-01 06:14:35', '2026-09-01 06:14:35'),
(56, 1, 38, 15, '2026-09-01 06:14:55', '2026-09-01 06:14:55'),
(57, 1, 38, 16, '2026-09-01 06:15:11', '2026-09-01 06:15:11'),
(58, 1, 39, 15, '2026-09-01 06:16:42', '2026-09-01 06:16:42'),
(59, 1, 39, 16, '2026-09-01 06:16:49', '2026-09-01 06:16:49'),
(60, 1, 40, 15, '2026-09-01 06:18:58', '2026-09-01 06:18:58'),
(61, 1, 40, 16, '2026-09-01 06:19:06', '2026-09-01 06:19:06'),
(62, 1, 41, 15, '2026-09-01 06:19:17', '2026-09-01 06:19:17'),
(63, 1, 41, 16, '2026-09-01 06:19:25', '2026-09-01 06:19:25'),
(64, 1, 42, 15, '2026-09-01 06:19:36', '2026-09-01 06:19:36'),
(65, 1, 42, 16, '2026-09-01 06:20:13', '2026-09-01 06:20:13'),
(66, 1, 43, 15, '2026-09-01 06:21:04', '2026-09-01 06:21:04'),
(67, 1, 43, 16, '2026-09-01 06:21:12', '2026-09-01 06:21:12'),
(68, 1, 44, 15, '2026-09-01 06:21:25', '2026-09-01 06:21:25'),
(69, 1, 44, 16, '2026-09-01 06:21:51', '2026-09-01 06:21:51'),
(70, 1, 45, 15, '2026-09-01 06:22:01', '2026-09-01 06:22:01'),
(71, 1, 45, 16, '2026-09-01 06:22:10', '2026-09-01 06:22:10');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_manpower_targets`
--

CREATE TABLE `mcc_manpower_targets` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL DEFAULT 0,
  `target_date` date NOT NULL,
  `manpower_type_id` int(11) NOT NULL,
  `manpower_type` varchar(255) NOT NULL,
  `target_qty` decimal(10,2) NOT NULL DEFAULT 0.00,
  `effective_from` date DEFAULT NULL,
  `effective_to` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_manpower_targets`
--

INSERT INTO `mcc_manpower_targets` (`id`, `station_id`, `category_id`, `target_date`, `manpower_type_id`, `manpower_type`, `target_qty`, `effective_from`, `effective_to`, `created_at`, `updated_at`) VALUES
(1, 1, 17, '2026-08-01', 15, 'Unskilled', 0.58, '2026-08-01', '2026-08-31', '2026-09-01 12:13:08', '2026-09-01 12:13:08'),
(2, 1, 17, '2026-08-01', 16, 'Supervisor', 9.00, '2026-08-01', '2026-08-31', '2026-09-01 12:13:08', '2026-09-01 12:13:08'),
(3, 1, 18, '2026-08-01', 15, 'Unskilled', 0.58, '2026-08-01', '2026-08-31', '2026-09-01 12:13:08', '2026-09-01 12:13:08'),
(4, 1, 19, '2026-08-01', 15, 'Unskilled', 21.00, '2026-08-01', '2026-08-31', '2026-09-01 12:13:08', '2026-09-01 12:13:08'),
(5, 1, 19, '2026-08-01', 16, 'Supervisor', 1.00, '2026-08-01', '2026-08-31', '2026-09-01 12:13:08', '2026-09-01 12:13:08'),
(6, 1, 20, '2026-08-01', 15, 'Unskilled', 0.20, '2026-08-01', '2026-08-31', '2026-09-01 12:13:08', '2026-09-01 12:13:08'),
(7, 1, 20, '2026-08-01', 16, 'Supervisor', 3.00, '2026-08-01', '2026-08-31', '2026-09-01 12:13:08', '2026-09-01 12:13:08'),
(8, 1, 21, '2026-08-01', 15, 'Unskilled', 3.00, '2026-08-01', '2026-08-31', '2026-09-01 12:13:08', '2026-09-01 12:13:08'),
(9, 1, 21, '2026-08-01', 16, 'Supervisor', 1.00, '2026-08-01', '2026-08-31', '2026-09-01 12:13:08', '2026-09-01 12:13:08');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_manpower_types`
--

CREATE TABLE `mcc_manpower_types` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `role_name` varchar(255) NOT NULL,
  `order_no` int(11) NOT NULL DEFAULT 0,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_manpower_types`
--

INSERT INTO `mcc_manpower_types` (`id`, `station_id`, `role_name`, `order_no`, `status`, `created_at`) VALUES
(15, 1, 'Unskilled', 1, 'Active', '2026-09-01 06:09:05'),
(16, 1, 'Supervisor', 2, 'Active', '2026-09-01 06:09:49');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_normal_chemical_param`
--

CREATE TABLE `mcc_normal_chemical_param` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `units` varchar(100) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_normal_chemical_param`
--

INSERT INTO `mcc_normal_chemical_param` (`id`, `name`, `units`, `station_id`, `created_at`, `updated_at`) VALUES
(1, 'PVC floor-cleaning agent', 'ml/coach', 1, '2026-05-25 12:18:12', '2026-08-26 07:50:07'),
(2, 'Ceramic and stainless-steel toilet fittings cleaner', 'ml/coach', 1, '2026-05-25 12:18:12', '2026-08-26 07:50:15'),
(3, 'Glass-cleaning agent', 'ml/coach', 1, '2026-05-25 12:18:12', '2026-08-26 07:50:21'),
(4, 'Laminated plastic sheet and berth rexine cleaner', 'ml/coach', 1, '2026-05-25 12:18:12', '2026-08-26 07:50:38'),
(5, 'Painted-surface cleaner', 'ml/coach', 1, '2026-05-25 12:18:12', '2026-08-26 07:50:45'),
(6, 'Disinfectant', 'ml/coach', 1, '2026-05-25 12:18:12', '2026-08-26 07:51:01'),
(7, 'Air Freshener', 'ml/coach', 1, '2026-05-25 12:18:12', '2026-05-25 12:18:12'),
(8, 'Old-label, sticker and glue-mark remover', 'ml/coach', 1, '2026-05-25 12:18:12', '2026-08-26 07:51:10');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_normal_chemical_report`
--

CREATE TABLE `mcc_normal_chemical_report` (
  `id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `coach_no` varchar(20) DEFAULT NULL,
  `qty_used` decimal(10,2) DEFAULT NULL,
  `auditor_name` varchar(255) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `token_id` varchar(100) NOT NULL,
  `train_no` varchar(50) NOT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_normal_chemical_report`
--

INSERT INTO `mcc_normal_chemical_report` (`id`, `parameter_id`, `coach_no`, `qty_used`, `auditor_name`, `station_id`, `token_id`, `train_no`, `report_date`, `created_at`, `updated_at`) VALUES
(1, 1, 'C1', 30.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:54'),
(2, 2, 'C1', 40.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:54'),
(3, 3, 'C1', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:54'),
(4, 4, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:54'),
(5, 5, 'C1', 18.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:54'),
(6, 6, 'C1', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:54'),
(7, 7, 'C1', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:54'),
(8, 8, 'C1', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:54'),
(9, 1, 'C2', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:05'),
(10, 2, 'C2', 40.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:05'),
(11, 3, 'C2', 25.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:05'),
(12, 4, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:05'),
(13, 5, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:05'),
(14, 6, 'C2', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:05'),
(15, 7, 'C2', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:05'),
(16, 8, 'C2', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:05'),
(17, 1, 'C3', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:08'),
(18, 2, 'C3', 40.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:08'),
(19, 3, 'C3', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:08'),
(20, 4, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:08'),
(21, 5, 'C3', 18.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:08'),
(22, 6, 'C3', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:08'),
(23, 7, 'C3', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:08'),
(24, 8, 'C3', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:08'),
(25, 1, 'C4', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:11'),
(26, 2, 'C4', 40.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:11'),
(27, 3, 'C4', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:11'),
(28, 4, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:11'),
(29, 5, 'C4', 18.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:11'),
(30, 6, 'C4', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:11'),
(31, 7, 'C4', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:11'),
(32, 8, 'C4', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:11'),
(33, 1, '1', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:06'),
(34, 2, '1', 40.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:06'),
(35, 3, '1', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:06'),
(36, 4, '1', 10.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:06'),
(37, 5, '1', 18.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:06'),
(38, 6, '1', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:06'),
(39, 7, '1', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:06'),
(40, 8, '1', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:06'),
(41, 1, '2', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:10'),
(42, 2, '2', 40.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:10'),
(43, 3, '2', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:10'),
(44, 4, '2', 10.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:10'),
(45, 5, '2', 18.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:10'),
(46, 6, '2', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:10'),
(47, 7, '2', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:10'),
(48, 8, '2', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:10'),
(49, 1, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:12:43'),
(50, 2, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:12:43'),
(51, 3, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:12:43'),
(52, 4, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:12:43'),
(53, 5, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(54, 6, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(55, 7, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(56, 8, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(57, 1, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(58, 2, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(59, 3, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(60, 4, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(61, 5, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(62, 6, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(63, 7, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(64, 8, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(65, 1, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(66, 2, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(67, 3, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(68, 4, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(69, 5, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(70, 6, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(71, 7, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(72, 8, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44'),
(73, 1, '01', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(74, 2, '01', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(75, 3, '01', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(76, 4, '01', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(77, 5, '01', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(78, 6, '01', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(79, 7, '01', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(80, 8, '01', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(81, 1, '02', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(82, 2, '02', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(83, 3, '02', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(84, 4, '02', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(85, 5, '02', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(86, 6, '02', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(87, 7, '02', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(88, 8, '02', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(89, 1, '03', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(90, 2, '03', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(91, 3, '03', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(92, 4, '03', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(93, 5, '03', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(94, 6, '03', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(95, 7, '03', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(96, 8, '03', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(97, 1, '04', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(98, 2, '04', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(99, 3, '04', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(100, 4, '04', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(101, 5, '04', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(102, 6, '04', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(103, 7, '04', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(104, 8, '04', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(105, 1, '05', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(106, 2, '05', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(107, 3, '05', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(108, 4, '05', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(109, 5, '05', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(110, 6, '05', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(111, 7, '05', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(112, 8, '05', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_normal_chemical_target`
--

CREATE TABLE `mcc_normal_chemical_target` (
  `id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `qty(ml)` decimal(10,2) DEFAULT NULL,
  `penalty` decimal(10,2) DEFAULT NULL,
  `penalty_qty(ml)` decimal(10,2) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `effective_from` date NOT NULL DEFAULT curdate(),
  `effective_to` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_normal_chemical_target`
--

INSERT INTO `mcc_normal_chemical_target` (`id`, `parameter_id`, `qty(ml)`, `penalty`, `penalty_qty(ml)`, `station_id`, `created_at`, `updated_at`, `effective_from`, `effective_to`) VALUES
(1, 1, 50.00, 500.00, 1.00, 1, '2026-09-07 14:07:13', '2026-09-07 14:07:13', '2026-09-07', NULL),
(2, 2, 40.00, 500.00, 1.00, 1, '2026-09-07 14:07:13', '2026-09-07 14:07:13', '2026-09-07', NULL),
(3, 3, 50.00, 500.00, 1.00, 1, '2026-09-07 14:07:13', '2026-09-07 14:07:13', '2026-09-07', NULL),
(4, 4, 10.00, 500.00, 1.00, 1, '2026-09-07 14:07:13', '2026-09-07 14:07:13', '2026-09-07', NULL),
(5, 5, 18.00, 500.00, 1.00, 1, '2026-09-07 14:07:13', '2026-09-07 14:07:13', '2026-09-07', NULL),
(6, 6, 50.00, 500.00, 1.00, 1, '2026-09-07 14:07:13', '2026-09-07 14:07:13', '2026-09-07', NULL),
(7, 7, 50.00, 500.00, 1.00, 1, '2026-09-07 14:07:13', '2026-09-07 14:07:13', '2026-09-07', NULL),
(8, 8, 50.00, 500.00, 1.00, 1, '2026-09-07 14:07:13', '2026-09-07 14:07:13', '2026-09-07', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mcc_normal_machine_param`
--

CREATE TABLE `mcc_normal_machine_param` (
  `id` int(11) NOT NULL,
  `machine_no` varchar(100) NOT NULL,
  `machine_name` varchar(255) NOT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_normal_machine_param`
--

INSERT INTO `mcc_normal_machine_param` (`id`, `machine_no`, `machine_name`, `station_id`, `created_at`, `updated_at`) VALUES
(16, 'PPSD 1', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(17, 'PPSD 2', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(18, 'PPSD 3', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(19, 'PPSD 4', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(20, 'PPSD 5', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(21, 'PPSD 6', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(22, 'PPSD 7', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(23, 'PPSD 8', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(24, 'PPSD 9', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(25, 'HHSD 1', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(26, 'HHSD 2', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(27, 'HHSD 3', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(28, 'HHSD 4', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(29, 'HHSD 5', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(30, 'HHSD 6', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_normal_machine_report`
--

CREATE TABLE `mcc_normal_machine_report` (
  `id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `used_status` varchar(50) DEFAULT NULL,
  `token_id` varchar(100) NOT NULL,
  `auditor_name` varchar(150) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_normal_machine_report`
--

INSERT INTO `mcc_normal_machine_report` (`id`, `parameter_id`, `shift_id`, `used_status`, `token_id`, `auditor_name`, `station_id`, `report_date`, `created_at`, `updated_at`) VALUES
(1, 16, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23'),
(2, 17, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23'),
(3, 18, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23'),
(4, 19, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23'),
(5, 20, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23'),
(6, 21, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23'),
(7, 22, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23'),
(8, 23, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23'),
(9, 24, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23'),
(10, 25, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23'),
(11, 26, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23'),
(12, 27, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23'),
(13, 28, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23'),
(14, 29, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23'),
(15, 30, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23'),
(16, 16, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36'),
(17, 17, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36'),
(18, 18, 5, 'N', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36'),
(19, 19, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36'),
(20, 20, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36'),
(21, 21, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36'),
(22, 22, 5, 'N', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36'),
(23, 23, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36'),
(24, 24, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36'),
(25, 25, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36'),
(26, 26, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36'),
(27, 27, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36'),
(28, 28, 5, 'N', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36'),
(29, 29, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36'),
(30, 30, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36'),
(31, 16, 6, 'N', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45'),
(32, 17, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45'),
(33, 18, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45'),
(34, 19, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45'),
(35, 20, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45'),
(36, 21, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45'),
(37, 22, 6, 'N', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45'),
(38, 23, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45'),
(39, 24, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45'),
(40, 25, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45'),
(41, 26, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45'),
(42, 27, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45'),
(43, 28, 6, 'N', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45'),
(44, 29, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45'),
(45, 30, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45'),
(46, 16, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38'),
(47, 17, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38'),
(48, 18, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38'),
(49, 19, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38'),
(50, 20, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38'),
(51, 21, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38'),
(52, 22, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38'),
(53, 23, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38'),
(54, 24, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38'),
(55, 25, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38'),
(56, 26, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38'),
(57, 27, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38'),
(58, 28, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38'),
(59, 29, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38'),
(60, 30, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38'),
(61, 16, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25'),
(62, 17, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25'),
(63, 18, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25'),
(64, 19, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25'),
(65, 20, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25'),
(66, 21, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25'),
(67, 22, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25'),
(68, 23, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25'),
(69, 24, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25'),
(70, 25, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25'),
(71, 26, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25'),
(72, 27, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25'),
(73, 28, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25'),
(74, 29, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25'),
(75, 30, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25'),
(76, 16, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31'),
(77, 17, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31'),
(78, 18, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31'),
(79, 19, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31'),
(80, 20, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31'),
(81, 21, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31'),
(82, 22, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31'),
(83, 23, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31'),
(84, 24, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31'),
(85, 25, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31'),
(86, 26, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31'),
(87, 27, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31'),
(88, 28, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31'),
(89, 29, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31'),
(90, 30, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_normal_machine_shifts`
--

CREATE TABLE `mcc_normal_machine_shifts` (
  `id` int(11) NOT NULL,
  `shift` varchar(100) NOT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_normal_machine_shifts`
--

INSERT INTO `mcc_normal_machine_shifts` (`id`, `shift`, `station_id`, `created_at`, `updated_at`) VALUES
(4, 'Shift 1', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(5, 'Shift 2', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(6, 'Shift 3', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_normal_machine_target`
--

CREATE TABLE `mcc_normal_machine_target` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `machine_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `nominated_area` varchar(50) DEFAULT NULL,
  `penalty_amount` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `effective_from` date NOT NULL DEFAULT curdate(),
  `effective_to` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_normal_machine_target`
--

INSERT INTO `mcc_normal_machine_target` (`id`, `station_id`, `machine_id`, `shift_id`, `nominated_area`, `penalty_amount`, `created_at`, `updated_at`, `effective_from`, `effective_to`) VALUES
(1, 1, 16, 4, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(2, 1, 16, 5, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(3, 1, 16, 6, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(4, 1, 17, 4, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(5, 1, 17, 5, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(6, 1, 17, 6, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(7, 1, 18, 4, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(8, 1, 18, 5, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(9, 1, 18, 6, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(10, 1, 19, 4, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(11, 1, 19, 5, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(12, 1, 19, 6, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(13, 1, 20, 4, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(14, 1, 20, 5, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(15, 1, 20, 6, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(16, 1, 21, 4, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(17, 1, 21, 5, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(18, 1, 21, 6, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(19, 1, 22, 4, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(20, 1, 22, 5, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(21, 1, 22, 6, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(22, 1, 23, 4, 'Y', 50.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(23, 1, 23, 5, 'Y', 50.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(24, 1, 23, 6, 'Y', 50.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(25, 1, 24, 4, 'Y', 50.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(26, 1, 24, 5, 'Y', 50.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(27, 1, 24, 6, 'Y', 50.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(28, 1, 25, 4, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(29, 1, 25, 5, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(30, 1, 25, 6, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(31, 1, 26, 4, 'Y', 50.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(32, 1, 26, 5, 'Y', 50.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(33, 1, 26, 6, 'Y', 50.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(34, 1, 27, 4, 'Y', 50.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(35, 1, 27, 5, 'Y', 50.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(36, 1, 27, 6, 'Y', 50.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(37, 1, 28, 4, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(38, 1, 28, 5, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(39, 1, 28, 6, 'Y', 500.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(40, 1, 29, 4, 'Y', 50.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(41, 1, 29, 5, 'Y', 50.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(42, 1, 29, 6, 'Y', 50.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(43, 1, 30, 4, 'Y', 40.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(44, 1, 30, 5, 'Y', 40.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(45, 1, 30, 6, 'Y', 40.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mcc_normal_rating`
--

CREATE TABLE `mcc_normal_rating` (
  `id` int(11) NOT NULL,
  `rating_name` varchar(50) NOT NULL,
  `rating_value` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `rating_group` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_normal_rating`
--

INSERT INTO `mcc_normal_rating` (`id`, `rating_name`, `rating_value`, `created_at`, `rating_group`) VALUES
(1, 'Very Good', '3', '2026-08-26 06:52:18', 'cleaning'),
(2, 'Satisfactory', '2', '2026-08-26 06:52:18', 'cleaning'),
(3, 'Poor', '1', '2026-08-26 06:52:18', 'cleaning'),
(4, 'Not attended', '0', '2026-08-26 06:52:18', 'cleaning'),
(5, 'Yes', 'Y', '2026-08-26 11:03:28', 'watering'),
(6, 'No', 'N', '2026-08-26 11:03:28', 'watering');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_normal_scorecard_param`
--

CREATE TABLE `mcc_normal_scorecard_param` (
  `id` int(11) NOT NULL,
  `parameter_name` varchar(255) NOT NULL,
  `station_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_normal_scorecard_param`
--

INSERT INTO `mcc_normal_scorecard_param` (`id`, `parameter_name`, `station_id`, `status`, `created_at`, `updated_at`) VALUES
(4, 'Coach Interior Cleaning', 1, 'Active', '2026-06-12 06:32:00', '2026-06-12 06:32:00'),
(5, 'Coach Exterior Cleaning', 1, 'Active', '2026-06-12 06:32:00', '2026-06-12 06:32:00'),
(6, 'Watering Status', 1, 'Active', '2026-06-12 06:32:00', '2026-06-12 06:32:00');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_normal_scorecard_report`
--

CREATE TABLE `mcc_normal_scorecard_report` (
  `id` int(11) NOT NULL,
  `sub_parameter_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `token_id` varchar(100) NOT NULL,
  `train_no` varchar(50) NOT NULL,
  `coach_no` varchar(20) NOT NULL,
  `score_value` varchar(10) DEFAULT NULL,
  `auditor_name` varchar(255) DEFAULT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_normal_scorecard_report`
--

INSERT INTO `mcc_normal_scorecard_report` (`id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `auditor_name`, `report_date`, `created_at`, `updated_at`) VALUES
(1, 7, 1, 'TKN-20260907-999', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:07:53'),
(2, 8, 1, 'TKN-20260907-999', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:07:53'),
(3, 9, 1, 'TKN-20260907-999', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:07:53'),
(4, 10, 1, 'TKN-20260907-999', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:07:53'),
(5, 11, 1, 'TKN-20260907-999', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:07:55'),
(6, 12, 1, 'TKN-20260907-999', '12345', 'C1', 'Y', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:07:57'),
(7, 7, 1, 'TKN-20260907-999', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:06'),
(8, 8, 1, 'TKN-20260907-999', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:06'),
(9, 9, 1, 'TKN-20260907-999', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:06'),
(10, 10, 1, 'TKN-20260907-999', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:06'),
(11, 11, 1, 'TKN-20260907-999', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:10'),
(12, 12, 1, 'TKN-20260907-999', '12345', 'C2', 'Y', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:13'),
(13, 7, 1, 'TKN-20260907-999', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:19'),
(14, 8, 1, 'TKN-20260907-999', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:19'),
(15, 9, 1, 'TKN-20260907-999', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:19'),
(16, 10, 1, 'TKN-20260907-999', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:19'),
(17, 11, 1, 'TKN-20260907-999', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:22'),
(18, 12, 1, 'TKN-20260907-999', '12345', 'C3', 'Y', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:24'),
(19, 7, 1, 'TKN-20260907-999', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:27'),
(20, 8, 1, 'TKN-20260907-999', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:27'),
(21, 9, 1, 'TKN-20260907-999', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:27'),
(22, 10, 1, 'TKN-20260907-999', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:27'),
(23, 11, 1, 'TKN-20260907-999', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:30'),
(24, 12, 1, 'TKN-20260907-999', '12345', 'C4', 'Y', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:32'),
(25, 7, 1, 'TKN-20260908-837', '16210', '1', '3', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:15'),
(26, 8, 1, 'TKN-20260908-837', '16210', '1', '3', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:15'),
(27, 9, 1, 'TKN-20260908-837', '16210', '1', '3', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:15'),
(28, 10, 1, 'TKN-20260908-837', '16210', '1', '3', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:15'),
(29, 11, 1, 'TKN-20260908-837', '16210', '1', '3', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:18'),
(30, 12, 1, 'TKN-20260908-837', '16210', '1', 'Y', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:20'),
(31, 7, 1, 'TKN-20260908-837', '16210', '2', '3', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:29'),
(32, 8, 1, 'TKN-20260908-837', '16210', '2', '3', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:29'),
(33, 9, 1, 'TKN-20260908-837', '16210', '2', '2', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:29'),
(34, 10, 1, 'TKN-20260908-837', '16210', '2', '3', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:29'),
(35, 11, 1, 'TKN-20260908-837', '16210', '2', '2', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:33'),
(36, 12, 1, 'TKN-20260908-837', '16210', '2', 'Y', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:37'),
(37, 7, 1, 'TKN-20260908-707', '16215', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:05'),
(38, 8, 1, 'TKN-20260908-707', '16215', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:05'),
(39, 9, 1, 'TKN-20260908-707', '16215', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:05'),
(40, 10, 1, 'TKN-20260908-707', '16215', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:05'),
(41, 11, 1, 'TKN-20260908-707', '16215', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:09'),
(42, 12, 1, 'TKN-20260908-707', '16215', '01', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:12'),
(43, 7, 1, 'TKN-20260908-707', '16215', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:19'),
(44, 8, 1, 'TKN-20260908-707', '16215', '02', '2', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:19'),
(45, 9, 1, 'TKN-20260908-707', '16215', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:19'),
(46, 10, 1, 'TKN-20260908-707', '16215', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:19'),
(47, 11, 1, 'TKN-20260908-707', '16215', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:28'),
(48, 12, 1, 'TKN-20260908-707', '16215', '02', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:31'),
(49, 7, 1, 'TKN-20260908-707', '16215', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:44'),
(50, 8, 1, 'TKN-20260908-707', '16215', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:44'),
(51, 9, 1, 'TKN-20260908-707', '16215', '03', '2', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:44'),
(52, 10, 1, 'TKN-20260908-707', '16215', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:44'),
(53, 11, 1, 'TKN-20260908-707', '16215', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:47'),
(54, 12, 1, 'TKN-20260908-707', '16215', '03', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:50'),
(55, 7, 1, 'TKN-20260908-892', '56202', '01', '3', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:28'),
(56, 8, 1, 'TKN-20260908-892', '56202', '01', '2', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:28'),
(57, 9, 1, 'TKN-20260908-892', '56202', '01', '3', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:28'),
(58, 10, 1, 'TKN-20260908-892', '56202', '01', '3', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:28'),
(59, 11, 1, 'TKN-20260908-892', '56202', '01', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(60, 12, 1, 'TKN-20260908-892', '56202', '01', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(61, 7, 1, 'TKN-20260908-892', '56202', '02', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(62, 8, 1, 'TKN-20260908-892', '56202', '02', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(63, 9, 1, 'TKN-20260908-892', '56202', '02', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(64, 10, 1, 'TKN-20260908-892', '56202', '02', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(65, 11, 1, 'TKN-20260908-892', '56202', '02', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(66, 12, 1, 'TKN-20260908-892', '56202', '02', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(67, 7, 1, 'TKN-20260908-892', '56202', '03', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(68, 8, 1, 'TKN-20260908-892', '56202', '03', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(69, 9, 1, 'TKN-20260908-892', '56202', '03', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(70, 10, 1, 'TKN-20260908-892', '56202', '03', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(71, 11, 1, 'TKN-20260908-892', '56202', '03', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(72, 12, 1, 'TKN-20260908-892', '56202', '03', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(73, 7, 1, 'TKN-20260908-892', '56202', '04', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(74, 8, 1, 'TKN-20260908-892', '56202', '04', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(75, 9, 1, 'TKN-20260908-892', '56202', '04', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(76, 10, 1, 'TKN-20260908-892', '56202', '04', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(77, 11, 1, 'TKN-20260908-892', '56202', '04', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(78, 12, 1, 'TKN-20260908-892', '56202', '04', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(79, 7, 1, 'TKN-20260908-892', '56202', '05', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(80, 8, 1, 'TKN-20260908-892', '56202', '05', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(81, 9, 1, 'TKN-20260908-892', '56202', '05', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(82, 10, 1, 'TKN-20260908-892', '56202', '05', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(83, 11, 1, 'TKN-20260908-892', '56202', '05', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(84, 12, 1, 'TKN-20260908-892', '56202', '05', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_normal_scorecard_sub_param`
--

CREATE TABLE `mcc_normal_scorecard_sub_param` (
  `id` int(11) NOT NULL,
  `sub_parameter_name` varchar(255) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `input_type` varchar(50) DEFAULT 'cleaning'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_normal_scorecard_sub_param`
--

INSERT INTO `mcc_normal_scorecard_sub_param` (`id`, `sub_parameter_name`, `parameter_id`, `station_id`, `status`, `created_at`, `updated_at`, `input_type`) VALUES
(7, 'Cleaning and wiping of toilet area and fittings including wash basins, mirrors. Cleaning of mugs in AC coaches', 4, 1, 'Active', '2026-06-12 06:32:00', '2026-06-12 06:32:00', 'cleaning'),
(8, 'Interior Cleaning of compartments, doorways, gang ways, vestibules, Window glass, window shutter etc.', 4, 1, 'Active', '2026-06-12 06:32:00', '2026-07-07 10:59:56', 'cleaning'),
(9, 'Cleaning & wiping of all berths, Panels, Rexene & amenity fittings.', 4, 1, 'Active', '2026-06-12 06:32:00', '2026-06-12 06:32:00', 'cleaning'),
(10, 'Floor including area under seats/berths etc.', 4, 1, 'Active', '2026-06-12 06:32:00', '2026-06-12 06:32:00', 'cleaning'),
(11, 'Exterior Cleaning / washing including end panel', 5, 1, 'Active', '2026-06-12 06:32:00', '2026-06-12 06:32:00', 'cleaning'),
(12, 'Please mention Yes/ No', 6, 1, 'Active', '2026-06-12 06:32:00', '2026-08-26 11:04:16', 'watering');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_normal_score_card`
--

CREATE TABLE `mcc_normal_score_card` (
  `id` int(11) NOT NULL,
  `sub_report_id` int(11) NOT NULL,
  `sub_parameter_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `token_id` varchar(100) NOT NULL,
  `train_no` varchar(50) NOT NULL,
  `coach_no` varchar(20) NOT NULL,
  `score_value` varchar(10) NOT NULL,
  `submitted_by` int(11) NOT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mcc_parameters`
--

CREATE TABLE `mcc_parameters` (
  `parameter_id` int(11) NOT NULL,
  `parameter_name` varchar(255) NOT NULL,
  `subreport_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_parameters`
--

INSERT INTO `mcc_parameters` (`parameter_id`, `parameter_name`, `subreport_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Coach Interior Cleaning', 1, 'Active', '2026-05-22 10:43:16', '2026-05-22 10:43:16'),
(2, 'Coach Exterior Cleaning', 1, 'Active', '2026-05-22 10:43:16', '2026-05-22 10:43:16'),
(3, 'Watering Status', 1, 'Active', '2026-05-22 10:43:16', '2026-05-22 10:43:16'),
(4, 'Shift 1', 2, 'Active', '2026-05-22 10:43:16', '2026-05-22 10:43:16'),
(5, 'Shift 2', 2, 'Active', '2026-05-22 10:43:16', '2026-05-22 10:43:16'),
(6, 'Shift 3', 2, 'Active', '2026-05-22 10:43:16', '2026-05-22 10:43:16'),
(7, 'Coach Interior Cleaning', 4, 'Active', '2026-05-30 06:29:09', '2026-05-30 06:29:09'),
(8, 'Coach Exterior Cleaning', 4, 'Active', '2026-05-30 06:29:09', '2026-05-30 06:29:09'),
(9, 'Watering Status', 4, 'Active', '2026-05-30 06:29:09', '2026-05-30 06:29:09'),
(10, 'Coach Interior Cleaning', 10, 'Active', '2026-06-09 11:33:45', '2026-06-09 11:33:45'),
(11, 'Coach Exterior Cleaning', 10, 'Active', '2026-06-09 11:33:45', '2026-06-09 11:33:45'),
(12, 'Watering Status', 10, 'Active', '2026-06-09 11:33:45', '2026-06-09 11:33:45');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_photo_report`
--

CREATE TABLE `mcc_photo_report` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `report_date` date NOT NULL,
  `before_photo` varchar(255) DEFAULT NULL,
  `after_photo` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `area` varchar(255) DEFAULT NULL,
  `before_remark` text DEFAULT NULL,
  `after_remark` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_photo_report`
--

INSERT INTO `mcc_photo_report` (`id`, `station_id`, `report_date`, `before_photo`, `after_photo`, `created_at`, `updated_at`, `area`, `before_remark`, `after_remark`) VALUES
(1, 1, '2026-07-09', 'before_sample.png', 'after_sample.png', '2026-07-10 11:24:52', '2026-07-10 11:24:52', 'Platform 1 (AC Section)', 'Accumulated dust and dry garbage on the floor.', 'Thoroughly scrubbed with power disc Mopper. Clean and shiny.'),
(2, 1, '2026-07-10', 'before_sample.png', 'after_sample.png', '2026-07-10 11:24:52', '2026-07-10 11:24:52', 'Concourse Area', 'Stains and litter near seating space.', 'High-pressure washing and disinfection done. Spotless.');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_prt_chemical_param`
--

CREATE TABLE `mcc_prt_chemical_param` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `units` varchar(100) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_prt_chemical_param`
--

INSERT INTO `mcc_prt_chemical_param` (`id`, `name`, `units`, `station_id`, `created_at`, `updated_at`) VALUES
(1, 'PVC floor-cleaning agent', 'ml', 1, '2026-06-09 12:56:20', '2026-08-31 11:59:20'),
(2, 'Ceramic and stainless-steel toilet fittings cleaner', 'ml', 1, '2026-06-09 12:56:20', '2026-08-31 11:59:28'),
(3, 'Glass cleaner', 'ml', 1, '2026-06-09 12:56:20', '2026-08-31 11:59:37'),
(4, 'Laminated plastic sheet and berth rexine cleaner', 'ml', 1, '2026-06-09 12:56:20', '2026-08-31 11:59:55'),
(5, 'Disinfectant', 'ml', 1, '2026-06-09 12:56:20', '2026-08-31 12:00:04'),
(6, 'Air Freshener', 'ml', 1, '2026-06-09 12:56:20', '2026-06-09 12:56:20'),
(7, 'Old label, sticker and glue remover', 'ml', 1, '2026-06-09 12:56:20', '2026-08-31 12:00:17');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_prt_chemical_report`
--

CREATE TABLE `mcc_prt_chemical_report` (
  `id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `coach_no` varchar(20) DEFAULT NULL,
  `qty_used` decimal(10,2) DEFAULT NULL,
  `auditor_name` varchar(255) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `token_id` varchar(100) NOT NULL,
  `train_no` varchar(50) NOT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_prt_chemical_report`
--

INSERT INTO `mcc_prt_chemical_report` (`id`, `parameter_id`, `coach_no`, `qty_used`, `auditor_name`, `station_id`, `token_id`, `train_no`, `report_date`, `created_at`, `updated_at`) VALUES
(1, 1, 'C1', 5.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:21'),
(2, 2, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:21'),
(3, 3, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:21'),
(4, 4, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:21'),
(5, 5, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:21'),
(6, 6, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:21'),
(7, 7, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:21'),
(8, 1, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:24'),
(9, 2, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:24'),
(10, 3, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:24'),
(11, 4, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:24'),
(12, 5, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:24'),
(13, 6, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:24'),
(14, 7, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:24'),
(15, 1, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:30'),
(16, 2, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:30'),
(17, 3, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:30'),
(18, 4, 'C3', 7.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:30'),
(19, 5, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:30'),
(20, 6, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:30'),
(21, 7, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:30'),
(22, 1, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:36'),
(23, 2, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:36'),
(24, 3, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:36'),
(25, 4, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:36'),
(26, 5, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:36'),
(27, 6, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:36'),
(28, 7, 'C4', 4.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:36'),
(29, 1, '01', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:27'),
(30, 2, '01', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:27'),
(31, 3, '01', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:27'),
(32, 4, '01', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:27'),
(33, 5, '01', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:27'),
(34, 6, '01', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:27'),
(35, 7, '01', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:27'),
(36, 1, '02', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:31'),
(37, 2, '02', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:31'),
(38, 3, '02', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:31'),
(39, 4, '02', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:31'),
(40, 5, '02', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:31'),
(41, 6, '02', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:31'),
(42, 7, '02', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:31'),
(43, 1, '03', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:34'),
(44, 2, '03', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:34'),
(45, 3, '03', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:34'),
(46, 4, '03', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:34'),
(47, 5, '03', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:34'),
(48, 6, '03', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:34'),
(49, 7, '03', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:34'),
(50, 1, '01', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:40'),
(51, 2, '01', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:41'),
(52, 3, '01', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:41'),
(53, 4, '01', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:41'),
(54, 5, '01', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:41'),
(55, 6, '01', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:41'),
(56, 7, '01', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:41'),
(57, 1, '02', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:43'),
(58, 2, '02', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:43'),
(59, 3, '02', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:43'),
(60, 4, '02', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:43'),
(61, 5, '02', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:43'),
(62, 6, '02', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:43'),
(63, 7, '02', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:43'),
(64, 1, '03', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:47'),
(65, 2, '03', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:47'),
(66, 3, '03', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:47'),
(67, 4, '03', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:47'),
(68, 5, '03', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:47'),
(69, 6, '03', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:47'),
(70, 7, '03', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:47'),
(71, 1, '04', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:58'),
(72, 2, '04', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:58'),
(73, 3, '04', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:58'),
(74, 4, '04', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:58'),
(75, 5, '04', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:58'),
(76, 6, '04', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:58'),
(77, 7, '04', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:58'),
(78, 1, '01', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:11'),
(79, 2, '01', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:11'),
(80, 3, '01', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:11'),
(81, 4, '01', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:11'),
(82, 5, '01', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:11'),
(83, 6, '01', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:11'),
(84, 7, '01', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:11'),
(85, 1, '02', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:14'),
(86, 2, '02', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:14'),
(87, 3, '02', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:14'),
(88, 4, '02', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:14'),
(89, 5, '02', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:14'),
(90, 6, '02', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:14'),
(91, 7, '02', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:14'),
(92, 1, '03', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:18'),
(93, 2, '03', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:18'),
(94, 3, '03', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:18'),
(95, 4, '03', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:18'),
(96, 5, '03', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:18'),
(97, 6, '03', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:18'),
(98, 7, '03', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:18'),
(99, 1, '04', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:22'),
(100, 2, '04', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:22'),
(101, 3, '04', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:22'),
(102, 4, '04', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:22'),
(103, 5, '04', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:22'),
(104, 6, '04', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:22'),
(105, 7, '04', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:22'),
(106, 1, '05', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:26'),
(107, 2, '05', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:26'),
(108, 3, '05', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:26'),
(109, 4, '05', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:26'),
(110, 5, '05', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:26'),
(111, 6, '05', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:26'),
(112, 7, '05', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:26'),
(113, 1, '01', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:06'),
(114, 2, '01', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:06'),
(115, 3, '01', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:06'),
(116, 4, '01', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:06'),
(117, 5, '01', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:06'),
(118, 6, '01', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:06'),
(119, 7, '01', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:06'),
(120, 1, '02', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:09'),
(121, 2, '02', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:09'),
(122, 3, '02', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:09'),
(123, 4, '02', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:09'),
(124, 5, '02', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:09'),
(125, 6, '02', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:09'),
(126, 7, '02', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:09'),
(127, 1, '03', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:12'),
(128, 2, '03', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:12'),
(129, 3, '03', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:12'),
(130, 4, '03', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:12'),
(131, 5, '03', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:12'),
(132, 6, '03', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:12'),
(133, 7, '03', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:12'),
(134, 1, '04', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:15'),
(135, 2, '04', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:15'),
(136, 3, '04', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:15'),
(137, 4, '04', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:15'),
(138, 5, '04', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:15'),
(139, 6, '04', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:15'),
(140, 7, '04', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:15'),
(141, 1, '01', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:33'),
(142, 2, '01', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:33'),
(143, 3, '01', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:33'),
(144, 4, '01', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:33'),
(145, 5, '01', 25.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:33'),
(146, 6, '01', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:33'),
(147, 7, '01', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:33'),
(148, 1, '02', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:40'),
(149, 2, '02', 15.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:40'),
(150, 3, '02', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:40'),
(151, 4, '02', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:40'),
(152, 5, '02', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:40'),
(153, 6, '02', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:40'),
(154, 7, '02', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:40'),
(155, 1, '03', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:43'),
(156, 2, '03', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:43'),
(157, 3, '03', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:43'),
(158, 4, '03', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:43'),
(159, 5, '03', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:43'),
(160, 6, '03', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:43'),
(161, 7, '03', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:43'),
(162, 1, '04', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:47'),
(163, 2, '04', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:47'),
(164, 3, '04', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:47'),
(165, 4, '04', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:47'),
(166, 5, '04', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:47'),
(167, 6, '04', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:47'),
(168, 7, '04', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:47');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_prt_chemical_target`
--

CREATE TABLE `mcc_prt_chemical_target` (
  `id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `qty(ml)` decimal(10,2) DEFAULT NULL,
  `penalty` decimal(10,2) DEFAULT NULL,
  `penalty_qty(ml)` decimal(10,2) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `effective_from` date NOT NULL DEFAULT curdate(),
  `effective_to` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_prt_chemical_target`
--

INSERT INTO `mcc_prt_chemical_target` (`id`, `parameter_id`, `qty(ml)`, `penalty`, `penalty_qty(ml)`, `station_id`, `created_at`, `updated_at`, `effective_from`, `effective_to`) VALUES
(1, 1, 10.00, 200.00, 5.00, 1, '2026-09-07 14:15:33', '2026-09-07 14:15:33', '2026-09-07', NULL),
(2, 2, 10.00, 400.00, 5.00, 1, '2026-09-07 14:15:33', '2026-09-07 14:15:33', '2026-09-07', NULL),
(3, 3, 10.00, 500.00, 5.00, 1, '2026-09-07 14:15:33', '2026-09-07 14:15:33', '2026-09-07', NULL),
(4, 4, 10.00, 200.00, 5.00, 1, '2026-09-07 14:15:33', '2026-09-07 14:15:33', '2026-09-07', NULL),
(5, 5, 10.00, 600.00, 5.00, 1, '2026-09-07 14:15:33', '2026-09-07 14:15:33', '2026-09-07', NULL),
(6, 6, 10.00, 300.00, 5.00, 1, '2026-09-07 14:15:33', '2026-09-07 14:15:33', '2026-09-07', NULL),
(7, 7, 10.00, 400.00, 5.00, 1, '2026-09-07 14:15:33', '2026-09-07 14:15:33', '2026-09-07', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mcc_prt_machine_param`
--

CREATE TABLE `mcc_prt_machine_param` (
  `id` int(11) NOT NULL,
  `machine_no` varchar(100) NOT NULL,
  `machine_name` varchar(255) NOT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_prt_machine_param`
--

INSERT INTO `mcc_prt_machine_param` (`id`, `machine_no`, `machine_name`, `station_id`, `created_at`, `updated_at`) VALUES
(16, 'PPSD 1', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(17, 'PPSD 2', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(18, 'PPSD 3', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(19, 'PPSD 4', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(20, 'PPSD 5', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(21, 'PPSD 6', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(22, 'PPSD 7', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(23, 'PPSD 8', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(24, 'PPSD 9', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(25, 'HHSD 1', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(26, 'HHSD 2', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(27, 'HHSD 3', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(28, 'HHSD 4', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(29, 'HHSD 5', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(30, 'HHSD 6', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_prt_machine_report`
--

CREATE TABLE `mcc_prt_machine_report` (
  `id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `used_status` varchar(50) DEFAULT NULL,
  `token_id` varchar(100) NOT NULL,
  `auditor_name` varchar(150) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_prt_machine_report`
--

INSERT INTO `mcc_prt_machine_report` (`id`, `parameter_id`, `shift_id`, `used_status`, `token_id`, `auditor_name`, `station_id`, `report_date`, `created_at`, `updated_at`) VALUES
(1, 16, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44'),
(2, 17, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44'),
(3, 18, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44'),
(4, 19, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44'),
(5, 20, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44'),
(6, 21, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44'),
(7, 22, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44'),
(8, 23, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44'),
(9, 24, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44'),
(10, 25, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44'),
(11, 26, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44'),
(12, 27, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44'),
(13, 28, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44'),
(14, 29, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44'),
(15, 30, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44'),
(16, 16, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51'),
(17, 17, 5, 'N', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51'),
(18, 18, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51'),
(19, 19, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51'),
(20, 20, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51'),
(21, 21, 5, 'N', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51'),
(22, 22, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51'),
(23, 23, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51'),
(24, 24, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51'),
(25, 25, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51'),
(26, 26, 5, 'N', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51'),
(27, 27, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51'),
(28, 28, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51'),
(29, 29, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51'),
(30, 30, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51'),
(31, 16, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01'),
(32, 17, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01'),
(33, 18, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01'),
(34, 19, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01'),
(35, 20, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01'),
(36, 21, 6, 'N', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01'),
(37, 22, 6, 'N', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01'),
(38, 23, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01'),
(39, 24, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01'),
(40, 25, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01'),
(41, 26, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01'),
(42, 27, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01'),
(43, 28, 6, 'N', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01'),
(44, 29, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01'),
(45, 30, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01'),
(46, 16, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57'),
(47, 17, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57'),
(48, 18, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57'),
(49, 19, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57'),
(50, 20, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57'),
(51, 21, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57'),
(52, 22, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57'),
(53, 23, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57'),
(54, 24, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57'),
(55, 25, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57'),
(56, 26, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57'),
(57, 27, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57'),
(58, 28, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57'),
(59, 29, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57'),
(60, 30, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57'),
(61, 16, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09'),
(62, 17, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09'),
(63, 18, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09'),
(64, 19, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09'),
(65, 20, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09'),
(66, 21, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09'),
(67, 22, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09'),
(68, 23, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09'),
(69, 24, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09'),
(70, 25, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09'),
(71, 26, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09'),
(72, 27, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09'),
(73, 28, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09'),
(74, 29, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09'),
(75, 30, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09'),
(76, 16, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22'),
(77, 17, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22'),
(78, 18, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22'),
(79, 19, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22'),
(80, 20, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22'),
(81, 21, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22'),
(82, 22, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22'),
(83, 23, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22'),
(84, 24, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22'),
(85, 25, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22'),
(86, 26, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22'),
(87, 27, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22'),
(88, 28, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22'),
(89, 29, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22'),
(90, 30, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_prt_machine_shifts`
--

CREATE TABLE `mcc_prt_machine_shifts` (
  `id` int(11) NOT NULL,
  `shift` varchar(100) NOT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_prt_machine_shifts`
--

INSERT INTO `mcc_prt_machine_shifts` (`id`, `shift`, `station_id`, `created_at`, `updated_at`) VALUES
(4, 'Shift 1', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(5, 'Shift 2', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(6, 'Shift 3', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_prt_machine_target`
--

CREATE TABLE `mcc_prt_machine_target` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `machine_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `nominated_area` varchar(50) DEFAULT NULL,
  `penalty_amount` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `effective_from` date NOT NULL DEFAULT curdate(),
  `effective_to` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_prt_machine_target`
--

INSERT INTO `mcc_prt_machine_target` (`id`, `station_id`, `machine_id`, `shift_id`, `nominated_area`, `penalty_amount`, `created_at`, `updated_at`, `effective_from`, `effective_to`) VALUES
(1, 1, 16, 4, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(2, 1, 16, 5, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(3, 1, 16, 6, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(4, 1, 17, 4, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(5, 1, 17, 5, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(6, 1, 17, 6, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(7, 1, 18, 4, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(8, 1, 18, 5, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(9, 1, 18, 6, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(10, 1, 19, 4, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(11, 1, 19, 5, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(12, 1, 19, 6, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(13, 1, 20, 4, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(14, 1, 20, 5, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(15, 1, 20, 6, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(16, 1, 21, 4, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(17, 1, 21, 5, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(18, 1, 21, 6, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(19, 1, 22, 4, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(20, 1, 22, 5, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(21, 1, 22, 6, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(22, 1, 23, 4, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(23, 1, 23, 5, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(24, 1, 23, 6, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(25, 1, 24, 4, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(26, 1, 24, 5, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(27, 1, 24, 6, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(28, 1, 25, 4, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(29, 1, 25, 5, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(30, 1, 25, 6, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(31, 1, 26, 4, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(32, 1, 26, 5, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(33, 1, 26, 6, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(34, 1, 27, 4, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(35, 1, 27, 5, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(36, 1, 27, 6, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(37, 1, 28, 4, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(38, 1, 28, 5, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(39, 1, 28, 6, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(40, 1, 29, 4, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(41, 1, 29, 5, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(42, 1, 29, 6, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(43, 1, 30, 4, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(44, 1, 30, 5, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(45, 1, 30, 6, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mcc_prt_rating`
--

CREATE TABLE `mcc_prt_rating` (
  `id` int(11) NOT NULL,
  `rating_name` varchar(50) NOT NULL,
  `rating_value` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `rating_group` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_prt_rating`
--

INSERT INTO `mcc_prt_rating` (`id`, `rating_name`, `rating_value`, `created_at`, `rating_group`) VALUES
(1, 'Very Good', '3', '2026-08-26 06:52:18', 'cleaning'),
(2, 'Satisfactory', '2', '2026-08-26 06:52:18', 'cleaning'),
(3, 'Poor', '1', '2026-08-26 06:52:18', 'cleaning'),
(4, 'Not attended', '0', '2026-08-26 06:52:18', 'cleaning'),
(5, 'Yes', 'Y', '2026-08-26 11:03:28', 'watering'),
(6, 'No', 'N', '2026-08-26 11:03:28', 'watering');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_prt_scorecard_param`
--

CREATE TABLE `mcc_prt_scorecard_param` (
  `id` int(11) NOT NULL,
  `parameter_name` varchar(255) NOT NULL,
  `station_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_prt_scorecard_param`
--

INSERT INTO `mcc_prt_scorecard_param` (`id`, `parameter_name`, `station_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Coach Interior Cleaning', 1, 'Active', '2026-06-09 12:36:06', '2026-06-09 12:36:06'),
(3, 'Watering of PFTR coaches', 1, 'Active', '2026-06-09 12:36:06', '2026-08-30 10:52:58');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_prt_scorecard_report`
--

CREATE TABLE `mcc_prt_scorecard_report` (
  `id` int(11) NOT NULL,
  `sub_parameter_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `token_id` varchar(100) NOT NULL,
  `train_no` varchar(50) NOT NULL,
  `coach_no` varchar(20) NOT NULL,
  `score_value` varchar(10) NOT NULL,
  `auditor_name` varchar(255) DEFAULT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_prt_scorecard_report`
--

INSERT INTO `mcc_prt_scorecard_report` (`id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `auditor_name`, `report_date`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'TKN-PRT-20260907-037', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:38'),
(2, 2, 1, 'TKN-PRT-20260907-037', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:38'),
(3, 3, 1, 'TKN-PRT-20260907-037', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:38'),
(4, 4, 1, 'TKN-PRT-20260907-037', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:38'),
(5, 5, 1, 'TKN-PRT-20260907-037', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:38'),
(6, 7, 1, 'TKN-PRT-20260907-037', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:40'),
(7, 1, 1, 'TKN-PRT-20260907-037', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:44'),
(8, 2, 1, 'TKN-PRT-20260907-037', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:44'),
(9, 3, 1, 'TKN-PRT-20260907-037', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:44'),
(10, 4, 1, 'TKN-PRT-20260907-037', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:44'),
(11, 5, 1, 'TKN-PRT-20260907-037', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:44'),
(12, 7, 1, 'TKN-PRT-20260907-037', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:46'),
(13, 1, 1, 'TKN-PRT-20260907-037', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:55'),
(14, 2, 1, 'TKN-PRT-20260907-037', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:55'),
(15, 3, 1, 'TKN-PRT-20260907-037', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:55'),
(16, 4, 1, 'TKN-PRT-20260907-037', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:55'),
(17, 5, 1, 'TKN-PRT-20260907-037', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:55'),
(18, 7, 1, 'TKN-PRT-20260907-037', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:56'),
(19, 1, 1, 'TKN-PRT-20260907-037', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:07'),
(20, 2, 1, 'TKN-PRT-20260907-037', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:07'),
(21, 3, 1, 'TKN-PRT-20260907-037', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:07'),
(22, 4, 1, 'TKN-PRT-20260907-037', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:07'),
(23, 5, 1, 'TKN-PRT-20260907-037', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:07'),
(24, 7, 1, 'TKN-PRT-20260907-037', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:10'),
(25, 1, 1, 'TKN-PRT-20260908-861', '16232', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:26'),
(26, 2, 1, 'TKN-PRT-20260908-861', '16232', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:26'),
(27, 3, 1, 'TKN-PRT-20260908-861', '16232', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:26'),
(28, 4, 1, 'TKN-PRT-20260908-861', '16232', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:26'),
(29, 5, 1, 'TKN-PRT-20260908-861', '16232', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:26'),
(30, 7, 1, 'TKN-PRT-20260908-861', '16232', '01', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:29'),
(31, 1, 1, 'TKN-PRT-20260908-861', '16232', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:34'),
(32, 2, 1, 'TKN-PRT-20260908-861', '16232', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:34'),
(33, 3, 1, 'TKN-PRT-20260908-861', '16232', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:34'),
(34, 4, 1, 'TKN-PRT-20260908-861', '16232', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:34'),
(35, 5, 1, 'TKN-PRT-20260908-861', '16232', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:34'),
(36, 7, 1, 'TKN-PRT-20260908-861', '16232', '02', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:37'),
(37, 1, 1, 'TKN-PRT-20260908-861', '16232', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:43'),
(38, 2, 1, 'TKN-PRT-20260908-861', '16232', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:43'),
(39, 3, 1, 'TKN-PRT-20260908-861', '16232', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:43'),
(40, 4, 1, 'TKN-PRT-20260908-861', '16232', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:43'),
(41, 5, 1, 'TKN-PRT-20260908-861', '16232', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:43'),
(42, 7, 1, 'TKN-PRT-20260908-861', '16232', '03', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:46'),
(43, 1, 1, 'TKN-PRT-20260908-808', '12008', '01', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:26:59'),
(44, 2, 1, 'TKN-PRT-20260908-808', '12008', '01', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:26:59'),
(45, 3, 1, 'TKN-PRT-20260908-808', '12008', '01', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:26:59'),
(46, 4, 1, 'TKN-PRT-20260908-808', '12008', '01', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:26:59'),
(47, 5, 1, 'TKN-PRT-20260908-808', '12008', '01', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:26:59'),
(48, 7, 1, 'TKN-PRT-20260908-808', '12008', '01', 'Y', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:03'),
(49, 1, 1, 'TKN-PRT-20260908-808', '12008', '02', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:10'),
(50, 2, 1, 'TKN-PRT-20260908-808', '12008', '02', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:10'),
(51, 3, 1, 'TKN-PRT-20260908-808', '12008', '02', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:10'),
(52, 4, 1, 'TKN-PRT-20260908-808', '12008', '02', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:10'),
(53, 5, 1, 'TKN-PRT-20260908-808', '12008', '02', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:10'),
(54, 7, 1, 'TKN-PRT-20260908-808', '12008', '02', 'Y', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:13'),
(55, 1, 1, 'TKN-PRT-20260908-808', '12008', '03', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:18'),
(56, 2, 1, 'TKN-PRT-20260908-808', '12008', '03', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:18'),
(57, 3, 1, 'TKN-PRT-20260908-808', '12008', '03', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:18'),
(58, 4, 1, 'TKN-PRT-20260908-808', '12008', '03', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:18'),
(59, 5, 1, 'TKN-PRT-20260908-808', '12008', '03', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:18'),
(60, 7, 1, 'TKN-PRT-20260908-808', '12008', '03', 'Y', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:21'),
(61, 1, 1, 'TKN-PRT-20260908-808', '12008', '04', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:31'),
(62, 2, 1, 'TKN-PRT-20260908-808', '12008', '04', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:31'),
(63, 3, 1, 'TKN-PRT-20260908-808', '12008', '04', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:31'),
(64, 4, 1, 'TKN-PRT-20260908-808', '12008', '04', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:31'),
(65, 5, 1, 'TKN-PRT-20260908-808', '12008', '04', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:31'),
(66, 7, 1, 'TKN-PRT-20260908-808', '12008', '04', 'Y', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:34'),
(67, 1, 1, 'TKN-PRT-20260908-132', '17301', '01', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:22'),
(68, 2, 1, 'TKN-PRT-20260908-132', '17301', '01', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:22'),
(69, 3, 1, 'TKN-PRT-20260908-132', '17301', '01', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:22'),
(70, 4, 1, 'TKN-PRT-20260908-132', '17301', '01', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:22'),
(71, 5, 1, 'TKN-PRT-20260908-132', '17301', '01', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:22'),
(72, 7, 1, 'TKN-PRT-20260908-132', '17301', '01', 'Y', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:25'),
(73, 1, 1, 'TKN-PRT-20260908-132', '17301', '02', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:31'),
(74, 2, 1, 'TKN-PRT-20260908-132', '17301', '02', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:31'),
(75, 3, 1, 'TKN-PRT-20260908-132', '17301', '02', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:31'),
(76, 4, 1, 'TKN-PRT-20260908-132', '17301', '02', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:31'),
(77, 5, 1, 'TKN-PRT-20260908-132', '17301', '02', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:31'),
(78, 7, 1, 'TKN-PRT-20260908-132', '17301', '02', 'Y', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:36'),
(79, 1, 1, 'TKN-PRT-20260908-132', '17301', '03', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:46'),
(80, 2, 1, 'TKN-PRT-20260908-132', '17301', '03', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:46'),
(81, 3, 1, 'TKN-PRT-20260908-132', '17301', '03', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:46'),
(82, 4, 1, 'TKN-PRT-20260908-132', '17301', '03', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:46'),
(83, 5, 1, 'TKN-PRT-20260908-132', '17301', '03', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:46'),
(84, 7, 1, 'TKN-PRT-20260908-132', '17301', '03', 'Y', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:49'),
(85, 1, 1, 'TKN-PRT-20260908-132', '17301', '04', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:57'),
(86, 2, 1, 'TKN-PRT-20260908-132', '17301', '04', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:57'),
(87, 3, 1, 'TKN-PRT-20260908-132', '17301', '04', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:57'),
(88, 4, 1, 'TKN-PRT-20260908-132', '17301', '04', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:57'),
(89, 5, 1, 'TKN-PRT-20260908-132', '17301', '04', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:57'),
(90, 7, 1, 'TKN-PRT-20260908-132', '17301', '04', 'Y', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:59'),
(91, 1, 1, 'TKN-PRT-20260908-132', '17301', '05', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:29:04'),
(92, 2, 1, 'TKN-PRT-20260908-132', '17301', '05', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:29:04'),
(93, 3, 1, 'TKN-PRT-20260908-132', '17301', '05', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:29:04'),
(94, 4, 1, 'TKN-PRT-20260908-132', '17301', '05', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:29:04'),
(95, 5, 1, 'TKN-PRT-20260908-132', '17301', '05', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:29:04'),
(96, 7, 1, 'TKN-PRT-20260908-132', '17301', '05', 'Y', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:29:08'),
(97, 1, 1, 'TKN-PRT-20260908-873', '16315', '01', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:19'),
(98, 2, 1, 'TKN-PRT-20260908-873', '16315', '01', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:19'),
(99, 3, 1, 'TKN-PRT-20260908-873', '16315', '01', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:19'),
(100, 4, 1, 'TKN-PRT-20260908-873', '16315', '01', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:19'),
(101, 5, 1, 'TKN-PRT-20260908-873', '16315', '01', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:19'),
(102, 7, 1, 'TKN-PRT-20260908-873', '16315', '01', 'Y', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:21'),
(103, 1, 1, 'TKN-PRT-20260908-873', '16315', '02', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:27'),
(104, 2, 1, 'TKN-PRT-20260908-873', '16315', '02', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:27'),
(105, 3, 1, 'TKN-PRT-20260908-873', '16315', '02', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:27'),
(106, 4, 1, 'TKN-PRT-20260908-873', '16315', '02', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:27'),
(107, 5, 1, 'TKN-PRT-20260908-873', '16315', '02', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:27'),
(108, 7, 1, 'TKN-PRT-20260908-873', '16315', '02', 'Y', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:30'),
(109, 1, 1, 'TKN-PRT-20260908-873', '16315', '03', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:39'),
(110, 2, 1, 'TKN-PRT-20260908-873', '16315', '03', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:39'),
(111, 3, 1, 'TKN-PRT-20260908-873', '16315', '03', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:39'),
(112, 4, 1, 'TKN-PRT-20260908-873', '16315', '03', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:39'),
(113, 5, 1, 'TKN-PRT-20260908-873', '16315', '03', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:39'),
(114, 7, 1, 'TKN-PRT-20260908-873', '16315', '03', 'Y', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:42'),
(115, 1, 1, 'TKN-PRT-20260908-873', '16315', '04', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:50'),
(116, 2, 1, 'TKN-PRT-20260908-873', '16315', '04', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:50'),
(117, 3, 1, 'TKN-PRT-20260908-873', '16315', '04', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:50'),
(118, 4, 1, 'TKN-PRT-20260908-873', '16315', '04', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:50'),
(119, 5, 1, 'TKN-PRT-20260908-873', '16315', '04', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:50'),
(120, 7, 1, 'TKN-PRT-20260908-873', '16315', '04', 'Y', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:53'),
(121, 1, 1, 'TKN-PRT-20260908-698', '16022', '01', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:44'),
(122, 2, 1, 'TKN-PRT-20260908-698', '16022', '01', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:44'),
(123, 3, 1, 'TKN-PRT-20260908-698', '16022', '01', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:44'),
(124, 4, 1, 'TKN-PRT-20260908-698', '16022', '01', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:44'),
(125, 5, 1, 'TKN-PRT-20260908-698', '16022', '01', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:44'),
(126, 7, 1, 'TKN-PRT-20260908-698', '16022', '01', 'Y', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:47'),
(127, 1, 1, 'TKN-PRT-20260908-698', '16022', '02', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:52'),
(128, 2, 1, 'TKN-PRT-20260908-698', '16022', '02', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:52'),
(129, 3, 1, 'TKN-PRT-20260908-698', '16022', '02', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:52'),
(130, 4, 1, 'TKN-PRT-20260908-698', '16022', '02', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:52'),
(131, 5, 1, 'TKN-PRT-20260908-698', '16022', '02', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:52'),
(132, 7, 1, 'TKN-PRT-20260908-698', '16022', '02', 'Y', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:57'),
(133, 1, 1, 'TKN-PRT-20260908-698', '16022', '03', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:02'),
(134, 2, 1, 'TKN-PRT-20260908-698', '16022', '03', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:02'),
(135, 3, 1, 'TKN-PRT-20260908-698', '16022', '03', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:02'),
(136, 4, 1, 'TKN-PRT-20260908-698', '16022', '03', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:02'),
(137, 5, 1, 'TKN-PRT-20260908-698', '16022', '03', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:02'),
(138, 7, 1, 'TKN-PRT-20260908-698', '16022', '03', 'Y', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:06'),
(139, 1, 1, 'TKN-PRT-20260908-698', '16022', '04', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:15'),
(140, 2, 1, 'TKN-PRT-20260908-698', '16022', '04', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:15'),
(141, 3, 1, 'TKN-PRT-20260908-698', '16022', '04', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:15'),
(142, 4, 1, 'TKN-PRT-20260908-698', '16022', '04', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:15'),
(143, 5, 1, 'TKN-PRT-20260908-698', '16022', '04', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:15'),
(144, 7, 1, 'TKN-PRT-20260908-698', '16022', '04', 'Y', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:17');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_prt_scorecard_sub_param`
--

CREATE TABLE `mcc_prt_scorecard_sub_param` (
  `id` int(11) NOT NULL,
  `sub_parameter_name` varchar(255) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `input_type` varchar(50) DEFAULT 'cleaning'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_prt_scorecard_sub_param`
--

INSERT INTO `mcc_prt_scorecard_sub_param` (`id`, `sub_parameter_name`, `parameter_id`, `station_id`, `status`, `created_at`, `updated_at`, `input_type`) VALUES
(1, 'Cleaning and wiping of toilet area and fittings including wash basins, Mirrors. Cleaning of mugs in AC coaches etc.', 1, 1, 'Active', '2026-06-09 12:36:06', '2026-06-09 12:36:06', 'cleaning'),
(2, 'Interior Cleaning of compartments, doorways, gangways, vestibules etc.', 1, 1, 'Active', '2026-06-09 12:36:06', '2026-06-09 12:36:06', 'cleaning'),
(3, 'Cleaning & wiping if required of all berths, panels, Rexene & Amenity fittings.', 1, 1, 'Active', '2026-06-09 12:36:06', '2026-06-09 12:36:06', 'cleaning'),
(4, 'Floor including area under the seats/berths etc. & wiping if required', 1, 1, 'Active', '2026-06-09 12:36:06', '2026-06-09 12:36:06', 'cleaning'),
(5, 'Disposal of garbage', 1, 1, 'Active', '2026-06-09 12:36:06', '2026-06-09 12:36:06', 'cleaning'),
(7, 'Watering', 3, 1, 'Active', '2026-06-09 12:36:06', '2026-09-08 06:43:10', 'watering');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_reports`
--

CREATE TABLE `mcc_reports` (
  `report_id` int(11) NOT NULL,
  `report_name` varchar(255) NOT NULL,
  `app_key` varchar(255) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_reports`
--

INSERT INTO `mcc_reports` (`report_id`, `report_name`, `app_key`, `station_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Normal Cleaning', 'normal_cleaning', 1, 'Active', '2026-05-22 10:09:17', '2026-08-29 09:13:27'),
(2, 'Intensive Cleaning', 'intensive_cleaning', 1, 'Active', '2026-05-22 10:09:17', '2026-08-29 09:13:27'),
(3, 'Depot Cleaning', 'dc_cleaning', 1, 'Active', '2026-05-22 10:09:17', '2026-08-31 06:22:20'),
(4, 'PRT Cleaning', 'prt_cleaning', 1, 'Active', '2026-05-22 10:09:17', '2026-08-29 09:13:27'),
(5, 'Pantry Car', 'pantry_car', 1, 'Active', '2026-08-26 09:51:39', '2026-08-29 09:13:27'),
(6, 'Surprise Visit Audits', 'surprise_visit_audits', 1, 'Inactive', '2026-08-26 09:51:39', '2026-08-29 09:13:28'),
(7, 'Vande Bharat', 'vande_bharat_modules', 1, 'Active', '2026-08-26 09:51:40', '2026-08-29 12:23:20'),
(8, 'Attendance & Manpower', 'attendance_manpower', 1, 'Active', '2026-08-26 09:51:40', '2026-08-31 17:33:28'),
(9, 'Cleanliness Modules', 'cleanliness_modules', 1, 'Inactive', '2026-08-26 09:51:41', '2026-08-29 09:13:28'),
(10, 'Photo Reports', 'photo_reports', 1, 'Inactive', '2026-08-26 09:51:41', '2026-08-29 09:13:28'),
(11, 'Billing Management', 'billing_management', 1, 'Inactive', '2026-08-30 11:51:28', '2026-08-30 11:52:57');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_stations`
--

CREATE TABLE `mcc_stations` (
  `station_id` int(11) NOT NULL,
  `station_name` varchar(120) NOT NULL,
  `division_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `contractor_name` varchar(255) DEFAULT 'Kingson Services'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_stations`
--

INSERT INTO `mcc_stations` (`station_id`, `station_name`, `division_id`, `status`, `created_at`, `updated_at`, `contractor_name`) VALUES
(1, 'Mysore', 102, 'Active', '2026-04-06 13:50:26', '2026-08-31 05:59:55', 'Kingson Services');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_station_reports`
--

CREATE TABLE `mcc_station_reports` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `report_key` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_station_reports`
--

INSERT INTO `mcc_station_reports` (`id`, `station_id`, `report_key`, `created_at`) VALUES
(94, 1, 'normal_audit', '2026-08-13 08:26:44'),
(95, 1, 'normal_chem', '2026-08-13 08:26:44'),
(96, 1, 'normal_mach', '2026-08-13 08:26:44'),
(97, 1, 'int_audit', '2026-08-13 08:26:44'),
(98, 1, 'int_chem', '2026-08-13 08:26:44'),
(99, 1, 'int_mach', '2026-08-13 08:26:44'),
(100, 1, 'int_scorecard_2', '2026-08-13 08:26:44'),
(101, 1, 'dc_audit', '2026-08-13 08:26:44'),
(102, 1, 'dc_chem', '2026-08-13 08:26:44'),
(103, 1, 'dc_mach', '2026-08-13 08:26:44'),
(104, 1, 'sur_pit', '2026-08-13 08:26:44'),
(105, 1, 'sur_pf', '2026-08-13 08:26:44'),
(106, 1, 'prt_audit', '2026-08-13 08:26:44'),
(107, 1, 'prt_chem', '2026-08-13 08:26:44'),
(108, 1, 'manpower', '2026-08-13 08:26:44'),
(109, 1, 'cleanliness', '2026-08-13 08:26:44'),
(110, 1, 'photo_report', '2026-08-13 08:26:44'),
(111, 1, 'int_pantry', '2026-08-17 06:54:18'),
(114, 1, 'vb_audit', '2026-08-18 11:11:38'),
(115, 1, 'vb_chem', '2026-08-18 11:11:38'),
(116, 1, 'vb_mach', '2026-08-18 11:11:38'),
(117, 1, 'prt_mach', '2026-08-28 10:49:50');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_subreports`
--

CREATE TABLE `mcc_subreports` (
  `subreport_id` int(11) NOT NULL,
  `report_url` varchar(500) NOT NULL,
  `report_name` varchar(255) NOT NULL,
  `report_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `aap_key` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_subreports`
--

INSERT INTO `mcc_subreports` (`subreport_id`, `report_url`, `report_name`, `report_id`, `status`, `created_at`, `updated_at`, `aap_key`) VALUES
(1, 'normal-report.php', 'Scorecard', 1, 'Active', '2026-05-22 10:10:06', '2026-08-31 06:24:11', 'normal_scorecard'),
(2, 'chemical-report.php', 'Chemical Report', 1, 'Active', '2026-05-22 10:10:06', '2026-08-26 11:23:55', 'normal_chemical'),
(3, 'machine-report.php', 'Machine Report', 1, 'Active', '2026-05-22 10:10:06', '2026-08-26 11:23:55', 'normal_machine'),
(4, 'intensive-report.php', 'Intensive Report', 2, 'Inactive', '2026-05-22 10:10:06', '2026-08-26 11:23:55', 'intensive_scorecard'),
(5, 'intensive-chemical-report.php', 'Chemical Report', 2, 'Active', '2026-05-22 10:10:06', '2026-08-26 11:23:55', 'intensive_chemical'),
(6, 'machine-report-intensive.php', 'Machine Report', 2, 'Active', '2026-05-22 10:10:06', '2026-08-26 11:23:55', 'intensive_machine'),
(7, 'DC-Scorecard.php', 'Scorecard', 3, 'Active', '2026-05-22 10:10:06', '2026-08-31 06:22:20', 'dc_scorecard'),
(8, 'dc-chemical.php', 'Chemical Report', 3, 'Active', '2026-05-22 10:10:06', '2026-08-29 06:48:23', 'dc_chemical'),
(9, 'dc-machine.php', 'Machine Report', 3, 'Active', '2026-05-22 10:10:06', '2026-08-29 06:48:23', 'dc_machine'),
(10, 'Platform-Return-TrainsScorecard.php', 'Scorecard', 4, 'Active', '2026-05-22 10:10:06', '2026-08-31 06:24:11', 'prt_scorecard'),
(11, 'Platform-Return-Chemical.php', 'Chemical Report', 4, 'Active', '2026-05-22 10:10:06', '2026-08-26 11:23:56', 'prt_chemical'),
(12, 'intensive_scorecard_2.php', 'Scorecard', 2, 'Active', '2026-08-26 09:51:41', '2026-08-31 06:24:11', 'intensive_scorecard_2'),
(13, 'intensive_pantry_scorecard.php', 'Scorecard', 5, 'Active', '2026-08-26 09:51:42', '2026-08-31 06:24:11', 'intensive_pantry_scorecard'),
(14, 'surprise-pit-office.php', 'Pit & Office Inspection', 6, 'Active', '2026-08-26 09:51:42', '2026-08-26 11:23:56', 'surprise_pit_office'),
(15, 'surprise-pf-trains.php', 'PF Return Trains Audit', 6, 'Active', '2026-08-26 09:51:42', '2026-08-26 11:23:56', 'surprise_pf_trains'),
(16, 'vande-bharat-report.php', 'Scorecard', 7, 'Active', '2026-08-26 09:51:43', '2026-08-31 06:24:11', 'vande_bharat_scorecard'),
(17, 'vande-bharat-chemical.php', 'Chemical Report', 7, 'Active', '2026-08-26 09:51:43', '2026-08-29 09:56:55', 'vande_bharat_chemical'),
(18, 'vande-bharat-machine.php', 'Machine Report', 7, 'Active', '2026-08-26 09:51:44', '2026-08-29 09:56:55', 'vande_bharat_machine'),
(19, 'man-power-log.php', 'Man Power Log', 8, 'Active', '2026-08-26 09:51:44', '2026-08-26 11:23:56', 'man_power_log'),
(20, 'cleanliness.php', 'Cleanliness Scorecard', 9, 'Inactive', '2026-08-26 09:51:44', '2026-08-29 12:19:28', 'cleanliness_scorecard'),
(21, 'photo-report.php', 'Photo Report (Before/After)', 10, 'Inactive', '2026-08-26 09:51:45', '2026-08-29 12:19:28', 'photo_report'),
(22, 'Platform-Return-Machine.php', 'Machine Report', 4, 'Active', '2026-08-28 10:48:56', '2026-08-28 10:48:56', 'prt_machine'),
(23, 'pantry-chemical.php', 'Pantry Car Chemical', 5, 'Active', '2026-08-29 15:58:24', '2026-08-29 15:58:24', 'pantry_chemical'),
(24, 'pantry-machine.php', 'Pantry Car Machine', 5, 'Active', '2026-08-29 15:58:24', '2026-08-29 15:58:24', 'pantry_machine'),
(25, 'Billing.php', 'Billing Invoice', 11, 'Active', '2026-08-30 11:51:27', '2026-08-30 11:51:27', 'billing_invoice'),
(26, 'biometeric_manpower_log.php', 'Bio Metric', 8, 'Active', '2026-09-09 16:30:00', '2026-09-09 16:30:00', 'biometric_manpower_log');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_sub_parameters`
--

CREATE TABLE `mcc_sub_parameters` (
  `sub_parameter_id` int(11) NOT NULL,
  `sub_parameter_name` varchar(255) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_sub_parameters`
--

INSERT INTO `mcc_sub_parameters` (`sub_parameter_id`, `sub_parameter_name`, `parameter_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Cleaning and wiping of toilet area and fittings including wash basins, mirrors. Cleaning of mugs in AC coaches', 1, 'Active', '2026-05-22 10:43:30', '2026-05-22 10:43:30'),
(2, 'Interior Cleaning of compartments, doorways, gang ways, vestibules, Window glass, window shutter etc.', 1, 'Active', '2026-05-22 10:43:30', '2026-05-22 10:43:30'),
(3, 'Cleaning & wiping of all berths, Panels, Rexene & amenity fittings.', 1, 'Active', '2026-05-22 10:43:30', '2026-05-22 10:43:30'),
(4, 'Floor including area under seats/berths etc.', 1, 'Active', '2026-05-22 10:43:30', '2026-05-22 10:43:30'),
(5, 'Exterior Cleaning / washing including end panel', 2, 'Active', '2026-05-22 10:43:30', '2026-05-22 10:43:30'),
(6, 'Please mention Yes/ No', 3, 'Active', '2026-05-22 10:43:30', '2026-05-22 10:43:30'),
(7, 'PVC Floor Cleaning Agent', 4, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(8, 'Ceramic & Stainless Steel Cleaner', 4, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(9, 'Glass Cleaning Agent', 4, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(10, 'Laminated Sheet & Berth Cleaner', 4, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(11, 'Stainless Steel Polisher', 4, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(12, 'Disinfectants', 4, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(13, 'Air Freshener', 4, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(14, 'Label & Sticker Remover', 4, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(15, 'PVC Floor Cleaning Agent', 5, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(16, 'Ceramic & Stainless Steel Cleaner', 5, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(17, 'Glass Cleaning Agent', 5, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(18, 'Laminated Sheet & Berth Cleaner', 5, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(19, 'Stainless Steel Polisher', 5, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(20, 'Disinfectants', 5, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(21, 'Air Freshener', 5, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(22, 'Label & Sticker Remover', 5, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(23, 'PVC Floor Cleaning Agent', 6, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(24, 'Ceramic & Stainless Steel Cleaner', 6, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(25, 'Glass Cleaning Agent', 6, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(26, 'Laminated Sheet & Berth Cleaner', 6, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(27, 'Stainless Steel Polisher', 6, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(28, 'Disinfectants', 6, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(29, 'Air Freshener', 6, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(30, 'Label & Sticker Remover', 6, 'Active', '2026-05-25 10:08:20', '2026-05-25 10:08:20'),
(31, 'Cleaning and wiping of toilet area and fittings including wash basins, mirrors. Cleaning of mugs in AC coaches', 7, 'Active', '2026-05-30 06:29:09', '2026-05-30 06:29:09'),
(32, 'Interior Cleaning of compartments, doorways, gang ways, vestibules, Window glass, window shutter etc.', 7, 'Active', '2026-05-30 06:29:09', '2026-05-30 06:29:09'),
(33, 'Cleaning & wiping of all berths, Panels, Rexene & amenity fittings.', 7, 'Active', '2026-05-30 06:29:09', '2026-05-30 06:29:09'),
(34, 'Floor including area under seats/berths etc.', 7, 'Active', '2026-05-30 06:29:09', '2026-05-30 06:29:09'),
(35, 'Exterior Cleaning / washing including end panel', 8, 'Active', '2026-05-30 06:29:09', '2026-05-30 06:29:09'),
(36, 'Please mention Yes/ No', 9, 'Active', '2026-05-30 06:29:09', '2026-05-30 06:29:09'),
(37, 'Cleaning and wiping of toilet area and fittings including wash basins, Mirrors. Cleaning of mugs in AC coaches etc.', 10, 'Active', '2026-06-09 11:33:45', '2026-06-09 11:33:45'),
(38, 'Interior Cleaning of compartments, doorways, gangways, vestibules etc.', 10, 'Active', '2026-06-09 11:33:45', '2026-06-09 11:33:45'),
(39, 'Cleaning & wiping if required of all berths, panels, Rexene & Amenity fittings.', 10, 'Active', '2026-06-09 11:33:45', '2026-06-09 11:33:45'),
(40, 'Floor including area under the seats/berths etc. & wiping if required', 10, 'Active', '2026-06-09 11:33:45', '2026-06-09 11:33:45'),
(41, 'Disposal of garbage', 10, 'Active', '2026-06-09 11:33:45', '2026-06-09 11:33:45'),
(42, 'Exterior Cleaning / washing including end panel', 11, 'Active', '2026-06-09 11:33:45', '2026-06-09 11:33:45'),
(43, 'Watering', 12, 'Active', '2026-06-09 11:33:45', '2026-06-09 11:33:45');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_surprise_parameters`
--

CREATE TABLE `mcc_surprise_parameters` (
  `id` int(11) NOT NULL,
  `category` enum('pit_office','pf_trains') NOT NULL,
  `station_id` int(11) NOT NULL,
  `item_name` varchar(255) NOT NULL,
  `max_marks` int(11) NOT NULL DEFAULT 5,
  `parameter_desc` varchar(255) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_surprise_parameters`
--

INSERT INTO `mcc_surprise_parameters` (`id`, `category`, `station_id`, `item_name`, `max_marks`, `parameter_desc`, `status`, `created_at`) VALUES
(1, 'pit_office', 1, 'Staff as per contract Yardstick', 5, 'No. of staffs as per Contract vs staff available', 'Active', '2026-06-17 13:08:07'),
(2, 'pit_office', 1, 'Chemicals as per contract', 5, 'Availability as per contract', 'Active', '2026-06-17 13:08:07'),
(3, 'pit_office', 1, 'Staff in uniform', 5, 'Availability', 'Active', '2026-06-17 13:08:07'),
(4, 'pit_office', 1, 'Availability of tools as per contract', 5, 'Full / Partial / None', 'Active', '2026-06-17 13:08:07'),
(5, 'pit_office', 1, 'Quality of exterior cleaning', 5, 'Cleaning results', 'Active', '2026-06-17 13:08:07'),
(6, 'pit_office', 1, 'Quality of interior cleaning', 5, 'Cleaning results', 'Active', '2026-06-17 13:08:07'),
(7, 'pf_trains', 1, 'Availability of manpower as per contract', 5, 'No. of staffs as per Contract vs staff available', 'Active', '2026-06-17 13:08:07'),
(8, 'pf_trains', 1, 'Availability of tools & machinery as per contract', 5, 'Full / Partial / None', 'Active', '2026-06-17 13:08:07'),
(9, 'pf_trains', 1, 'Availability of chemicals', 5, 'Availability as per contract', 'Active', '2026-06-17 13:08:07'),
(10, 'pf_trains', 1, 'Quality of cleaning', 5, 'Cleaning results', 'Active', '2026-06-17 13:08:07'),
(11, 'pf_trains', 1, 'Full watering & padlocking done', 5, 'All coaches watered and padlocked from inside or by using a lock', 'Active', '2026-06-17 13:08:07');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_surprise_reports`
--

CREATE TABLE `mcc_surprise_reports` (
  `id` int(11) NOT NULL,
  `category` enum('pit_office','pf_trains') NOT NULL,
  `station_id` int(11) NOT NULL,
  `token_id` varchar(100) NOT NULL,
  `report_date` date NOT NULL,
  `submitted_by` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `value` tinyint(4) NOT NULL,
  `score_label` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_surprise_reports`
--

INSERT INTO `mcc_surprise_reports` (`id`, `category`, `station_id`, `token_id`, `report_date`, `submitted_by`, `parameter_id`, `value`, `score_label`, `created_at`, `updated_at`) VALUES
(1, 'pit_office', 1, 'SV-PIT-CDO-001', '2026-06-17', 2, 1, 5, '0% shortage – 5 marks', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(2, 'pit_office', 1, 'SV-PIT-CDO-001', '2026-06-17', 2, 2, 5, 'No shortage 5 marks', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(3, 'pit_office', 1, 'SV-PIT-CDO-001', '2026-06-17', 2, 3, 5, 'No shortage 5 marks', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(4, 'pit_office', 1, 'SV-PIT-CDO-001', '2026-06-17', 2, 4, 3, 'Partially available 3 marks', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(5, 'pit_office', 1, 'SV-PIT-CDO-001', '2026-06-17', 2, 5, 4, 'Very good -4', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(6, 'pit_office', 1, 'SV-PIT-CDO-001', '2026-06-17', 2, 6, 4, 'Very good -4', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(7, 'pit_office', 1, 'SV-PIT-CDO-002', '2026-06-14', 2, 1, 4, '1-10 % shortage – 4 marks', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(8, 'pit_office', 1, 'SV-PIT-CDO-002', '2026-06-14', 2, 2, 5, 'No shortage 5 marks', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(9, 'pit_office', 1, 'SV-PIT-CDO-002', '2026-06-14', 2, 3, 3, 'Partially available 3 marks', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(10, 'pit_office', 1, 'SV-PIT-CDO-002', '2026-06-14', 2, 4, 5, 'No shortage 5 marks', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(11, 'pit_office', 1, 'SV-PIT-CDO-002', '2026-06-14', 2, 5, 3, 'Good-3', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(12, 'pit_office', 1, 'SV-PIT-CDO-002', '2026-06-14', 2, 6, 3, 'Good-3', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(13, 'pf_trains', 1, 'SV-PRT-12018-01', '2026-06-17', 2, 7, 5, '0% shortage – 5 marks', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(14, 'pf_trains', 1, 'SV-PRT-12018-01', '2026-06-17', 2, 8, 5, 'No shortage 5 marks', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(15, 'pf_trains', 1, 'SV-PRT-12018-01', '2026-06-17', 2, 9, 5, 'No shortage 5 marks', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(16, 'pf_trains', 1, 'SV-PRT-12018-01', '2026-06-17', 2, 10, 4, 'Very good -4', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(17, 'pf_trains', 1, 'SV-PRT-12018-01', '2026-06-17', 2, 11, 5, 'Excellent -5', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(18, 'pf_trains', 1, 'SV-PRT-12056-01', '2026-06-14', 2, 7, 4, '1-10 % shortage – 4 marks', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(19, 'pf_trains', 1, 'SV-PRT-12056-01', '2026-06-14', 2, 8, 3, 'Partially available 3 marks', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(20, 'pf_trains', 1, 'SV-PRT-12056-01', '2026-06-14', 2, 9, 5, 'No shortage 5 marks', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(21, 'pf_trains', 1, 'SV-PRT-12056-01', '2026-06-14', 2, 10, 3, 'Good-3', '2026-06-17 13:08:07', '2026-06-17 13:08:07'),
(22, 'pf_trains', 1, 'SV-PRT-12056-01', '2026-06-14', 2, 11, 3, 'Good-3', '2026-06-17 13:08:07', '2026-06-17 13:08:07');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_users`
--

CREATE TABLE `mcc_users` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(150) NOT NULL,
  `user_code` varchar(50) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(150) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `role` varchar(50) NOT NULL DEFAULT 'AUDITOR',
  `station_id` int(11) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_by_user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_users`
--

INSERT INTO `mcc_users` (`user_id`, `user_name`, `user_code`, `username`, `email`, `password_hash`, `full_name`, `phone`, `designation`, `address`, `role`, `station_id`, `start_date`, `end_date`, `status`, `created_by_user_id`, `created_at`, `updated_at`) VALUES
(2, 'kings', NULL, 'CDO', 'kings@gmail.com', '$2y$10$3RDR/QZdf0b2bWDgSixl.uw8YPluriaVM2waD0w2unBxnXF51Awy2', NULL, NULL, NULL, NULL, 'CDO', 1, '2026-04-10', '2026-08-12', 'Active', NULL, '2026-04-10 14:15:10', '2026-07-17 04:49:15'),
(4, 'admin', NULL, 'admin', 're@gmail.com', '$2y$10$3RDR/QZdf0b2bWDgSixl.uw8YPluriaVM2waD0w2unBxnXF51Awy2', NULL, NULL, NULL, NULL, 'ADMIN', 1, '2026-04-06', '2026-07-30', 'Active', NULL, '2026-04-06 14:02:59', '2026-08-12 04:22:45'),
(9, 'Bheem Chand', NULL, 'bheem123', 'chandkapil24@gmail.com', '$2y$10$zpTRPGdYKI/0a.vFtgaGCO7rcbiwmZjDm72ZgcGy/3hLfvmE3LzLq', 'Bheem Chand', NULL, NULL, NULL, 'AUDITOR', 1, NULL, NULL, 'Active', NULL, '2026-08-30 17:33:03', '2026-08-30 17:33:03'),
(11, 'viewer', NULL, 'bheem8126', 'BHEEMCHAND8126@GMAIL.COM', '$2y$10$kxX8Qi1mfQiloQuKPW6W0.3QRpa/rJqHQkNkvSjxEiRBlz1Y02OHe', 'viewer', NULL, NULL, NULL, 'VIEWER', 1, NULL, NULL, 'Active', NULL, '2026-09-01 11:10:24', '2026-09-01 11:10:24'),
(12, 'SSE MYS', NULL, 'SSEMYS', 'AB@GMAIL.COM', '$2y$10$S7wsNB24l9VhmqV.WTXjfeFDm5n/Xw7rXDwpz7DK4zB1.bl.FCfge', 'SSE MYS', NULL, NULL, NULL, 'VIEWER', 1, NULL, NULL, 'Active', NULL, '2026-09-03 12:01:52', '2026-09-03 12:01:52');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_vb_chemical_param`
--

CREATE TABLE `mcc_vb_chemical_param` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `units` varchar(100) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_vb_chemical_param`
--

INSERT INTO `mcc_vb_chemical_param` (`id`, `name`, `units`, `station_id`, `created_at`, `updated_at`) VALUES
(1, 'PVC Floor Cleaning Agent', 'ml/coach', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(2, 'Ceramic & Stainless Steel Cleaner', 'ml/coach', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(3, 'Glass Cleaning Agent', 'ml/coach', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(4, 'Laminated Sheet & Berth Cleaner', 'ml/coach', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(5, 'Stainless Steel Polisher', 'ml/coach', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(6, 'Disinfectants', 'ml/coach', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(7, 'Air Freshener', 'ml/coach', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(8, 'Label & Sticker Remover', 'ml/coach', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(9, 'PVC Floor Cleaning Agent', 'ml/coach', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(10, 'Ceramic & Stainless Steel Cleaner', 'ml/coach', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(11, 'Glass Cleaning Agent', 'ml/coach', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(12, 'Laminated Sheet & Berth Cleaner', 'ml/coach', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(13, 'Stainless Steel Polisher', 'ml/coach', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(14, 'Disinfectants', 'ml/coach', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(15, 'Air Freshener', 'ml/coach', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(16, 'Label & Sticker Remover', 'ml/coach', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(17, 'PVC Floor Cleaning Agent', 'ml/coach', 3, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(18, 'Ceramic & Stainless Steel Cleaner', 'ml/coach', 3, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(19, 'Glass Cleaning Agent', 'ml/coach', 3, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(20, 'Laminated Sheet & Berth Cleaner', 'ml/coach', 3, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(21, 'Stainless Steel Polisher', 'ml/coach', 3, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(22, 'Disinfectants', 'ml/coach', 3, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(23, 'Air Freshener', 'ml/coach', 3, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(24, 'Label & Sticker Remover', 'ml/coach', 3, '2026-08-18 11:06:18', '2026-08-18 11:06:18');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_vb_chemical_report`
--

CREATE TABLE `mcc_vb_chemical_report` (
  `id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `coach_no` varchar(20) DEFAULT NULL,
  `qty_used` decimal(10,2) DEFAULT NULL,
  `auditor_name` varchar(255) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `token_id` varchar(100) NOT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `train_no` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_vb_chemical_report`
--

INSERT INTO `mcc_vb_chemical_report` (`id`, `parameter_id`, `coach_no`, `qty_used`, `auditor_name`, `station_id`, `token_id`, `report_date`, `created_at`, `updated_at`, `train_no`) VALUES
(1, 9, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-545', '2026-09-07', '2026-09-07 14:43:31', '2026-09-07 14:52:54', '12345'),
(2, 10, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-545', '2026-09-07', '2026-09-07 14:43:31', '2026-09-07 14:52:54', '12345'),
(3, 11, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-545', '2026-09-07', '2026-09-07 14:43:31', '2026-09-07 14:52:54', '12345'),
(4, 12, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-545', '2026-09-07', '2026-09-07 14:43:31', '2026-09-07 14:52:54', '12345'),
(5, 13, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-545', '2026-09-07', '2026-09-07 14:43:31', '2026-09-07 14:52:54', '12345'),
(6, 14, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-545', '2026-09-07', '2026-09-07 14:43:31', '2026-09-07 14:52:54', '12345'),
(7, 15, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-545', '2026-09-07', '2026-09-07 14:43:31', '2026-09-07 14:52:54', '12345'),
(8, 16, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-545', '2026-09-07', '2026-09-07 14:43:31', '2026-09-07 14:52:54', '12345'),
(9, 9, '1111', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:50:42', '12345'),
(10, 10, '1111', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:50:42', '12345'),
(11, 11, '1111', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:50:42', '12345'),
(12, 12, '1111', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:50:42', '12345'),
(13, 13, '1111', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:50:42', '12345'),
(14, 14, '1111', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:50:42', '12345'),
(15, 15, '1111', 5.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:50:42', '12345'),
(16, 16, '1111', 2.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:50:42', '12345'),
(17, 9, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:08', '12345'),
(18, 10, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:08', '12345'),
(19, 11, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:08', '12345'),
(20, 12, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:08', '12345'),
(21, 13, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:08', '12345'),
(22, 14, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:08', '12345'),
(23, 15, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:08', '12345'),
(24, 16, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:08', '12345'),
(25, 9, '3322', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:14', '12345'),
(26, 10, '3322', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:14', '12345'),
(27, 11, '3322', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:14', '12345'),
(28, 12, '3322', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:14', '12345'),
(29, 13, '3322', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:14', '12345'),
(30, 14, '3322', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:14', '12345'),
(31, 15, '3322', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:14', '12345'),
(32, 16, '3322', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:14', '12345'),
(33, 9, '4324', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:19', '12345'),
(34, 10, '4324', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:19', '12345'),
(35, 11, '4324', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:19', '12345'),
(36, 12, '4324', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:19', '12345'),
(37, 13, '4324', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:19', '12345'),
(38, 14, '4324', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:19', '12345'),
(39, 15, '4324', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:19', '12345'),
(40, 16, '4324', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:19', '12345'),
(41, 9, '1', NULL, 'Bheem Chand', 1, 'TKN-20260907-817', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', '12345'),
(42, 10, '1', NULL, 'Bheem Chand', 1, 'TKN-20260907-817', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', '12345'),
(43, 11, '1', NULL, 'Bheem Chand', 1, 'TKN-20260907-817', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', '12345'),
(44, 12, '1', NULL, 'Bheem Chand', 1, 'TKN-20260907-817', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', '12345'),
(45, 13, '1', NULL, 'Bheem Chand', 1, 'TKN-20260907-817', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', '12345'),
(46, 14, '1', NULL, 'Bheem Chand', 1, 'TKN-20260907-817', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', '12345'),
(47, 15, '1', NULL, 'Bheem Chand', 1, 'TKN-20260907-817', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', '12345'),
(48, 16, '1', NULL, 'Bheem Chand', 1, 'TKN-20260907-817', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', '12345'),
(49, 9, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(50, 10, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(51, 11, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(52, 12, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(53, 13, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(54, 14, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(55, 15, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(56, 16, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(57, 9, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(58, 10, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(59, 11, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(60, 12, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(61, 13, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(62, 14, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(63, 15, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(64, 16, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(65, 9, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(66, 10, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(67, 11, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(68, 12, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(69, 13, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(70, 14, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(71, 15, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(72, 16, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(73, 9, '04', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(74, 10, '04', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(75, 11, '04', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(76, 12, '04', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(77, 13, '04', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(78, 14, '04', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(79, 15, '04', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(80, 16, '04', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(81, 9, '05', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(82, 10, '05', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(83, 11, '05', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(84, 12, '05', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(85, 13, '05', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(86, 14, '05', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(87, 15, '05', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(88, 16, '05', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(89, 9, '06', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(90, 10, '06', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(91, 11, '06', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(92, 12, '06', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(93, 13, '06', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(94, 14, '06', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(95, 15, '06', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(96, 16, '06', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(97, 9, '07', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(98, 10, '07', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(99, 11, '07', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(100, 12, '07', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(101, 13, '07', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(102, 14, '07', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(103, 15, '07', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(104, 16, '07', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(105, 9, '08', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(106, 10, '08', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(107, 11, '08', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(108, 12, '08', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(109, 13, '08', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(110, 14, '08', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(111, 15, '08', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(112, 16, '08', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_vb_chemical_target`
--

CREATE TABLE `mcc_vb_chemical_target` (
  `id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `qty(ml)` decimal(10,2) DEFAULT NULL,
  `penalty` decimal(10,2) DEFAULT NULL,
  `penalty_qty(ml)` decimal(10,2) DEFAULT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `effective_from` date DEFAULT NULL,
  `effective_to` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_vb_chemical_target`
--

INSERT INTO `mcc_vb_chemical_target` (`id`, `parameter_id`, `qty(ml)`, `penalty`, `penalty_qty(ml)`, `station_id`, `created_at`, `updated_at`, `effective_from`, `effective_to`) VALUES
(1, 9, 10.00, 100.00, 5.00, 1, '2026-09-07 14:51:33', '2026-09-07 14:51:33', '2026-09-07', NULL),
(2, 10, 10.00, 100.00, 1.00, 1, '2026-09-07 14:51:33', '2026-09-07 14:51:33', '2026-09-07', NULL),
(3, 11, 10.00, 100.00, 1.00, 1, '2026-09-07 14:51:33', '2026-09-07 14:51:33', '2026-09-07', NULL),
(4, 12, 10.00, 100.00, 1.00, 1, '2026-09-07 14:51:33', '2026-09-07 14:51:33', '2026-09-07', NULL),
(5, 13, 10.00, 100.00, 1.00, 1, '2026-09-07 14:51:33', '2026-09-07 14:51:33', '2026-09-07', NULL),
(6, 14, 10.00, 100.00, 1.00, 1, '2026-09-07 14:51:33', '2026-09-07 14:51:33', '2026-09-07', NULL),
(7, 15, 10.00, 100.00, 1.00, 1, '2026-09-07 14:51:33', '2026-09-07 14:51:33', '2026-09-07', NULL),
(8, 16, 10.00, 100.00, 1.00, 1, '2026-09-07 14:51:33', '2026-09-07 14:51:33', '2026-09-07', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mcc_vb_machine_param`
--

CREATE TABLE `mcc_vb_machine_param` (
  `id` int(11) NOT NULL,
  `machine_no` varchar(100) NOT NULL,
  `machine_name` varchar(255) NOT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_vb_machine_param`
--

INSERT INTO `mcc_vb_machine_param` (`id`, `machine_no`, `machine_name`, `station_id`, `created_at`, `updated_at`) VALUES
(1, 'PPSD 1', 'Portable powerd single disc floor scrubber/ mopper', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(2, 'PPSD 2', 'Portable powerd single disc floor scrubber/ mopper', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(3, 'PPSD 3', 'Portable powerd single disc floor scrubber/ mopper', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(4, 'PPSD 4', 'Portable powerd single disc floor scrubber/ mopper', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(5, 'PPSD 5', 'Portable powerd single disc floor scrubber/ mopper', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(6, 'PPSD 6', 'Portable powerd single disc floor scrubber/ mopper', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(7, 'PPSD 7', 'Portable powerd single disc floor scrubber/ mopper', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(8, 'PPSD 8', 'Portable powerd single disc floor scrubber/ mopper', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(9, 'PPSD 9', 'Portable powerd single disc floor scrubber/ mopper', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(10, 'HHSD 1', 'Hand held single disc electrically operated mini scrubber', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(11, 'HHSD 2', 'Hand held single disc electrically operated mini scrubber', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(12, 'HHSD 3', 'Hand held single disc electrically operated mini scrubber', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(13, 'HHSD 4', 'Hand held single disc electrically operated mini scrubber', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(14, 'HHSD 5', 'Hand held single disc electrically operated mini scrubber', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(15, 'HHSD 6', 'Hand held single disc electrically operated mini scrubber', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(16, 'PPSD 1', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(17, 'PPSD 2', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(18, 'PPSD 3', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(19, 'PPSD 4', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(20, 'PPSD 5', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(21, 'PPSD 6', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(22, 'PPSD 7', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(23, 'PPSD 8', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(24, 'PPSD 9', 'Portable powerd single disc floor scrubber/ mopper', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(25, 'HHSD 1', 'Hand held single disc electrically operated mini scrubber', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(26, 'HHSD 2', 'Hand held single disc electrically operated mini scrubber', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(27, 'HHSD 3', 'Hand held single disc electrically operated mini scrubber', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(28, 'HHSD 4', 'Hand held single disc electrically operated mini scrubber', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(29, 'HHSD 5', 'Hand held single disc electrically operated mini scrubber', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(30, 'HHSD 6', 'Hand held single disc electrically operated mini scrubber', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(31, 'PPSD 1', 'Portable powerd single disc floor scrubber/ mopper', 3, '2026-08-18 11:06:19', '2026-08-18 11:06:19'),
(32, 'PPSD 2', 'Portable powerd single disc floor scrubber/ mopper', 3, '2026-08-18 11:06:19', '2026-08-18 11:06:19'),
(33, 'PPSD 3', 'Portable powerd single disc floor scrubber/ mopper', 3, '2026-08-18 11:06:19', '2026-08-18 11:06:19'),
(34, 'PPSD 4', 'Portable powerd single disc floor scrubber/ mopper', 3, '2026-08-18 11:06:19', '2026-08-18 11:06:19'),
(35, 'PPSD 5', 'Portable powerd single disc floor scrubber/ mopper', 3, '2026-08-18 11:06:19', '2026-08-18 11:06:19'),
(36, 'PPSD 6', 'Portable powerd single disc floor scrubber/ mopper', 3, '2026-08-18 11:06:19', '2026-08-18 11:06:19'),
(37, 'PPSD 7', 'Portable powerd single disc floor scrubber/ mopper', 3, '2026-08-18 11:06:19', '2026-08-18 11:06:19'),
(38, 'PPSD 8', 'Portable powerd single disc floor scrubber/ mopper', 3, '2026-08-18 11:06:19', '2026-08-18 11:06:19'),
(39, 'PPSD 9', 'Portable powerd single disc floor scrubber/ mopper', 3, '2026-08-18 11:06:19', '2026-08-18 11:06:19'),
(40, 'HHSD 1', 'Hand held single disc electrically operated mini scrubber', 3, '2026-08-18 11:06:19', '2026-08-18 11:06:19'),
(41, 'HHSD 2', 'Hand held single disc electrically operated mini scrubber', 3, '2026-08-18 11:06:19', '2026-08-18 11:06:19'),
(42, 'HHSD 3', 'Hand held single disc electrically operated mini scrubber', 3, '2026-08-18 11:06:19', '2026-08-18 11:06:19'),
(43, 'HHSD 4', 'Hand held single disc electrically operated mini scrubber', 3, '2026-08-18 11:06:19', '2026-08-18 11:06:19'),
(44, 'HHSD 5', 'Hand held single disc electrically operated mini scrubber', 3, '2026-08-18 11:06:19', '2026-08-18 11:06:19'),
(45, 'HHSD 6', 'Hand held single disc electrically operated mini scrubber', 3, '2026-08-18 11:06:19', '2026-08-18 11:06:19');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_vb_machine_report`
--

CREATE TABLE `mcc_vb_machine_report` (
  `id` int(11) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `used_status` varchar(50) DEFAULT NULL,
  `token_id` varchar(100) NOT NULL,
  `station_id` int(11) NOT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `auditor_name` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_vb_machine_report`
--

INSERT INTO `mcc_vb_machine_report` (`id`, `parameter_id`, `shift_id`, `used_status`, `token_id`, `station_id`, `report_date`, `created_at`, `updated_at`, `auditor_name`) VALUES
(1, 16, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand'),
(2, 17, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand'),
(3, 18, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand'),
(4, 19, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand'),
(5, 20, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand'),
(6, 21, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand'),
(7, 22, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand'),
(8, 23, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand'),
(9, 24, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand'),
(10, 25, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand'),
(11, 26, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand'),
(12, 27, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand'),
(13, 28, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand'),
(14, 29, 4, 'N', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand'),
(15, 30, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand'),
(16, 16, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand'),
(17, 17, 5, 'N', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand'),
(18, 18, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand'),
(19, 19, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand'),
(20, 20, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand'),
(21, 21, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand'),
(22, 22, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand'),
(23, 23, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand'),
(24, 24, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand'),
(25, 25, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand'),
(26, 26, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand'),
(27, 27, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand'),
(28, 28, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand'),
(29, 29, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand'),
(30, 30, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand'),
(31, 16, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand'),
(32, 17, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand'),
(33, 18, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand'),
(34, 19, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand'),
(35, 20, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand'),
(36, 21, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand'),
(37, 22, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand'),
(38, 23, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand'),
(39, 24, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand'),
(40, 25, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand'),
(41, 26, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand'),
(42, 27, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand'),
(43, 28, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand'),
(44, 29, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand'),
(45, 30, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_vb_machine_shifts`
--

CREATE TABLE `mcc_vb_machine_shifts` (
  `id` int(11) NOT NULL,
  `shift` varchar(100) NOT NULL,
  `station_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_vb_machine_shifts`
--

INSERT INTO `mcc_vb_machine_shifts` (`id`, `shift`, `station_id`, `created_at`, `updated_at`) VALUES
(1, 'Shift 1', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(2, 'Shift 2', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(3, 'Shift 3', 2, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(4, 'Shift 1', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(5, 'Shift 2', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(6, 'Shift 3', 1, '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(7, 'Shift 1', 3, '2026-08-18 11:06:19', '2026-08-18 11:06:19'),
(8, 'Shift 2', 3, '2026-08-18 11:06:19', '2026-08-18 11:06:19'),
(9, 'Shift 3', 3, '2026-08-18 11:06:19', '2026-08-18 11:06:19');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_vb_machine_target`
--

CREATE TABLE `mcc_vb_machine_target` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `machine_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `nominated_area` varchar(50) DEFAULT NULL,
  `penalty_amount` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `effective_from` date DEFAULT NULL,
  `effective_to` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_vb_machine_target`
--

INSERT INTO `mcc_vb_machine_target` (`id`, `station_id`, `machine_id`, `shift_id`, `nominated_area`, `penalty_amount`, `created_at`, `updated_at`, `effective_from`, `effective_to`) VALUES
(1, 1, 16, 4, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(2, 1, 16, 5, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(3, 1, 16, 6, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(4, 1, 17, 4, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(5, 1, 17, 5, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(6, 1, 17, 6, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(7, 1, 18, 4, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(8, 1, 18, 5, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(9, 1, 18, 6, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(10, 1, 19, 4, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(11, 1, 19, 5, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(12, 1, 19, 6, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(13, 1, 20, 4, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(14, 1, 20, 5, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(15, 1, 20, 6, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(16, 1, 21, 4, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(17, 1, 21, 5, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(18, 1, 21, 6, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(19, 1, 22, 4, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(20, 1, 22, 5, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(21, 1, 22, 6, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(22, 1, 23, 4, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(23, 1, 23, 5, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(24, 1, 23, 6, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(25, 1, 24, 4, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(26, 1, 24, 5, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(27, 1, 24, 6, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(28, 1, 25, 4, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(29, 1, 25, 5, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(30, 1, 25, 6, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(31, 1, 26, 4, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(32, 1, 26, 5, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(33, 1, 26, 6, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(34, 1, 27, 4, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(35, 1, 27, 5, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(36, 1, 27, 6, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(37, 1, 28, 4, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(38, 1, 28, 5, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(39, 1, 28, 6, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(40, 1, 29, 4, 'Y', 80.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(41, 1, 29, 5, 'Y', 80.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(42, 1, 29, 6, 'Y', 80.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(43, 1, 30, 4, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(44, 1, 30, 5, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL),
(45, 1, 30, 6, 'Y', 100.00, '2026-09-07 15:06:08', '2026-09-07 15:06:08', '2026-09-07', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mcc_vb_rating`
--

CREATE TABLE `mcc_vb_rating` (
  `id` int(11) NOT NULL,
  `rating_name` varchar(50) NOT NULL,
  `rating_value` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `rating_group` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_vb_rating`
--

INSERT INTO `mcc_vb_rating` (`id`, `rating_name`, `rating_value`, `created_at`, `rating_group`) VALUES
(1, 'Very Good', '3', '2026-08-26 06:52:18', 'cleaning'),
(2, 'Satisfactory', '2', '2026-08-26 06:52:18', 'cleaning'),
(3, 'Poor', '1', '2026-08-26 06:52:18', 'cleaning'),
(4, 'Not attended', '0', '2026-08-26 06:52:18', 'cleaning'),
(5, 'Yes', 'Y', '2026-08-26 11:03:28', 'watering'),
(6, 'No', 'N', '2026-08-26 11:03:28', 'watering');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_vb_scorecard_param`
--

CREATE TABLE `mcc_vb_scorecard_param` (
  `id` int(11) NOT NULL,
  `parameter_name` varchar(255) NOT NULL,
  `station_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_vb_scorecard_param`
--

INSERT INTO `mcc_vb_scorecard_param` (`id`, `parameter_name`, `station_id`, `status`, `created_at`, `updated_at`) VALUES
(4, 'Coach Interior Cleaning', 1, 'Active', '2026-08-18 11:06:18', '2026-08-18 11:06:18'),
(6, 'Watering of PFTR coaches', 1, 'Active', '2026-08-18 11:06:18', '2026-08-30 10:55:05');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_vb_scorecard_report`
--

CREATE TABLE `mcc_vb_scorecard_report` (
  `id` int(11) NOT NULL,
  `sub_parameter_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `token_id` varchar(100) NOT NULL,
  `train_no` varchar(50) NOT NULL,
  `coach_no` varchar(20) NOT NULL,
  `score_value` varchar(10) NOT NULL,
  `auditor_name` varchar(255) DEFAULT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_vb_scorecard_report`
--

INSERT INTO `mcc_vb_scorecard_report` (`id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `auditor_name`, `report_date`, `created_at`, `updated_at`) VALUES
(6, 7, 1, 'TKN-20260907-339', '12345', '1111', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:44:48'),
(7, 8, 1, 'TKN-20260907-339', '12345', '1111', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:44:48'),
(8, 9, 1, 'TKN-20260907-339', '12345', '1111', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:44:48'),
(9, 10, 1, 'TKN-20260907-339', '12345', '1111', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:44:48'),
(10, 12, 1, 'TKN-20260907-339', '12345', '1111', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:44:51'),
(11, 7, 1, 'TKN-20260907-339', '12345', '2222', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:44:58'),
(12, 8, 1, 'TKN-20260907-339', '12345', '2222', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:44:58'),
(13, 9, 1, 'TKN-20260907-339', '12345', '2222', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:44:58'),
(14, 10, 1, 'TKN-20260907-339', '12345', '2222', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:44:58'),
(15, 12, 1, 'TKN-20260907-339', '12345', '2222', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:03'),
(16, 7, 1, 'TKN-20260907-339', '12345', '3322', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:17'),
(17, 8, 1, 'TKN-20260907-339', '12345', '3322', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:17'),
(18, 9, 1, 'TKN-20260907-339', '12345', '3322', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:17'),
(19, 10, 1, 'TKN-20260907-339', '12345', '3322', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:17'),
(20, 12, 1, 'TKN-20260907-339', '12345', '3322', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:21'),
(21, 7, 1, 'TKN-20260907-339', '12345', '4324', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:38'),
(22, 8, 1, 'TKN-20260907-339', '12345', '4324', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:38'),
(23, 9, 1, 'TKN-20260907-339', '12345', '4324', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:38'),
(24, 10, 1, 'TKN-20260907-339', '12345', '4324', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:38'),
(25, 12, 1, 'TKN-20260907-339', '12345', '4324', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:45'),
(26, 7, 1, 'TKN-20260907-817', '12345', '1', '', 'Bheem Chand', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03'),
(27, 8, 1, 'TKN-20260907-817', '12345', '1', '', 'Bheem Chand', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03'),
(28, 9, 1, 'TKN-20260907-817', '12345', '1', '', 'Bheem Chand', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03'),
(29, 10, 1, 'TKN-20260907-817', '12345', '1', '', 'Bheem Chand', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03'),
(30, 12, 1, 'TKN-20260907-817', '12345', '1', '', 'Bheem Chand', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03'),
(31, 7, 1, 'TKN-20260908-956', '22063', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:16'),
(32, 8, 1, 'TKN-20260908-956', '22063', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:16'),
(33, 9, 1, 'TKN-20260908-956', '22063', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:16'),
(34, 10, 1, 'TKN-20260908-956', '22063', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:16'),
(35, 12, 1, 'TKN-20260908-956', '22063', '01', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:19'),
(36, 7, 1, 'TKN-20260908-956', '22063', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:41'),
(37, 8, 1, 'TKN-20260908-956', '22063', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:41'),
(38, 9, 1, 'TKN-20260908-956', '22063', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:41'),
(39, 10, 1, 'TKN-20260908-956', '22063', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:41'),
(40, 12, 1, 'TKN-20260908-956', '22063', '02', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:45'),
(41, 7, 1, 'TKN-20260908-956', '22063', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:52'),
(42, 8, 1, 'TKN-20260908-956', '22063', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:52'),
(43, 9, 1, 'TKN-20260908-956', '22063', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:52'),
(44, 10, 1, 'TKN-20260908-956', '22063', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:52'),
(45, 12, 1, 'TKN-20260908-956', '22063', '03', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:55'),
(46, 7, 1, 'TKN-20260908-956', '22063', '04', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:04'),
(47, 8, 1, 'TKN-20260908-956', '22063', '04', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:04'),
(48, 9, 1, 'TKN-20260908-956', '22063', '04', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:04'),
(49, 10, 1, 'TKN-20260908-956', '22063', '04', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:04'),
(50, 12, 1, 'TKN-20260908-956', '22063', '04', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:09'),
(51, 7, 1, 'TKN-20260908-956', '22063', '05', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:22'),
(52, 8, 1, 'TKN-20260908-956', '22063', '05', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:22'),
(53, 9, 1, 'TKN-20260908-956', '22063', '05', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:22'),
(54, 10, 1, 'TKN-20260908-956', '22063', '05', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:22'),
(55, 12, 1, 'TKN-20260908-956', '22063', '05', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:28'),
(56, 7, 1, 'TKN-20260908-956', '22063', '06', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:35'),
(57, 8, 1, 'TKN-20260908-956', '22063', '06', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:35'),
(58, 9, 1, 'TKN-20260908-956', '22063', '06', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:35'),
(59, 10, 1, 'TKN-20260908-956', '22063', '06', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:35'),
(60, 12, 1, 'TKN-20260908-956', '22063', '06', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:39'),
(61, 7, 1, 'TKN-20260908-956', '22063', '07', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:48'),
(62, 8, 1, 'TKN-20260908-956', '22063', '07', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:48'),
(63, 9, 1, 'TKN-20260908-956', '22063', '07', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:48'),
(64, 10, 1, 'TKN-20260908-956', '22063', '07', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:48'),
(65, 12, 1, 'TKN-20260908-956', '22063', '07', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:51'),
(66, 7, 1, 'TKN-20260908-956', '22063', '08', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:59'),
(67, 8, 1, 'TKN-20260908-956', '22063', '08', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:59'),
(68, 9, 1, 'TKN-20260908-956', '22063', '08', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:59'),
(69, 10, 1, 'TKN-20260908-956', '22063', '08', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:59'),
(70, 12, 1, 'TKN-20260908-956', '22063', '08', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:26:04');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_vb_scorecard_sub_param`
--

CREATE TABLE `mcc_vb_scorecard_sub_param` (
  `id` int(11) NOT NULL,
  `sub_parameter_name` varchar(255) NOT NULL,
  `parameter_id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `input_type` varchar(50) DEFAULT 'cleaning'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_vb_scorecard_sub_param`
--

INSERT INTO `mcc_vb_scorecard_sub_param` (`id`, `sub_parameter_name`, `parameter_id`, `station_id`, `status`, `created_at`, `updated_at`, `input_type`) VALUES
(1, 'Cleaning and wiping of toilet area and fittings including wash basins, mirrors. Cleaning of mugs in AC coaches', 1, 2, 'Active', '2026-08-18 11:06:18', '2026-08-18 11:06:18', 'cleaning'),
(2, 'Interior Cleaning of compartments, doorways, gang ways, vestibules, Window glass, window shutter etc.', 1, 2, 'Active', '2026-08-18 11:06:18', '2026-08-18 11:06:18', 'cleaning'),
(3, 'Cleaning & wiping of all berths, Panels, Rexene & amenity fittings.', 1, 2, 'Active', '2026-08-18 11:06:18', '2026-08-18 11:06:18', 'cleaning'),
(4, 'Floor including area under seats/berths etc.', 1, 2, 'Active', '2026-08-18 11:06:18', '2026-08-18 11:06:18', 'cleaning'),
(5, 'Exterior Cleaning / washing including end panel', 2, 2, 'Active', '2026-08-18 11:06:18', '2026-08-18 11:06:18', 'cleaning'),
(6, 'Please mention Yes/ No', 3, 2, 'Active', '2026-08-18 11:06:18', '2026-08-18 11:06:18', 'cleaning'),
(7, 'Cleaning and wiping of toilet area and fittings including wash basins, mirrors. Cleaning of mugs in AC coaches', 4, 1, 'Active', '2026-08-18 11:06:18', '2026-08-18 11:06:18', 'cleaning'),
(8, 'Interior Cleaning of compartments, doorways, gang ways, vestibules, Window glass, window shutter etc.', 4, 1, 'Active', '2026-08-18 11:06:18', '2026-08-18 11:06:18', 'cleaning'),
(9, 'Cleaning & wiping of all berths, Panels, Rexene & amenity fittings.', 4, 1, 'Active', '2026-08-18 11:06:18', '2026-08-18 11:06:18', 'cleaning'),
(10, 'Floor including area under seats/berths etc.', 4, 1, 'Active', '2026-08-18 11:06:18', '2026-08-18 11:06:18', 'cleaning'),
(11, 'Exterior Cleaning / washing including end panel', 5, 1, 'Active', '2026-08-18 11:06:18', '2026-08-18 11:06:18', 'cleaning'),
(12, 'Please mention Yes/ No', 6, 1, 'Active', '2026-08-18 11:06:18', '2026-09-08 06:43:52', 'watering');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_zones`
--

CREATE TABLE `mcc_zones` (
  `zone_id` int(11) NOT NULL,
  `zone_name` varchar(100) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_zones`
--

INSERT INTO `mcc_zones` (`zone_id`, `zone_name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Central Railway', 'Active', '2025-07-25 18:36:03', '2026-05-26 04:45:13'),
(2, 'Eastern Railway', 'Active', '2025-07-25 18:36:03', '2026-05-26 04:45:13'),
(3, 'East Central Railway', 'Active', '2025-07-25 18:36:03', '2026-05-26 04:45:13'),
(4, 'East Coast Railway', 'Active', '2025-07-25 18:36:03', '2026-05-26 04:45:13'),
(5, 'Northern Railway', 'Active', '2025-07-25 18:36:03', '2026-05-26 04:45:13'),
(6, 'North Central Railway', 'Active', '2025-07-25 18:36:03', '2026-05-26 04:45:13'),
(7, 'North Eastern Railway', 'Active', '2025-07-25 18:36:03', '2026-05-26 04:45:13'),
(8, 'Northeast Frontier Railway', 'Active', '2025-07-25 18:36:03', '2026-05-26 04:45:13'),
(9, 'North Western Railway', 'Active', '2025-07-25 18:36:03', '2026-05-26 04:45:13'),
(10, 'South Central Railway', 'Active', '2025-07-25 18:36:03', '2026-05-26 04:45:13'),
(11, 'South Coast Railway', 'Active', '2025-07-25 18:36:03', '2026-05-26 04:45:13'),
(12, 'South East Central Railway', 'Active', '2025-07-25 18:36:03', '2026-05-26 04:45:13'),
(13, 'South Eastern Railway', 'Active', '2025-07-25 18:36:03', '2026-05-26 04:45:13'),
(14, 'South Western Railway', 'Active', '2025-07-25 18:36:03', '2026-05-26 04:45:13'),
(15, 'Southern Railway', 'Active', '2025-07-25 18:36:03', '2026-05-26 04:45:13'),
(16, 'West Central Railway', 'Active', '2025-07-25 18:36:03', '2026-05-26 04:45:13'),
(17, 'Western Railway', 'Active', '2025-07-25 18:36:03', '2026-05-26 04:45:13'),
(18, 'Metro Railway, Kolkata', 'Active', '2025-07-25 18:36:03', '2026-05-26 04:45:13'),
(19, 'Konkan Railway', 'Active', '2025-07-25 18:36:03', '2026-05-26 04:45:13'),
(20, 'Test Zone', 'Active', '2026-06-27 12:23:48', '2026-06-27 12:23:48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `app_version`
--
ALTER TABLE `app_version`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attendance_logs`
--
ALTER TABLE `attendance_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_attendance` (`employee_code`,`punch_time`,`device_id`);

--
-- Indexes for table `dc_mcc_chemical_param`
--
ALTER TABLE `dc_mcc_chemical_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pldc_chem_param_station` (`station_id`);

--
-- Indexes for table `dc_mcc_chemical_report`
--
ALTER TABLE `dc_mcc_chemical_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pldc_chem_rep_param` (`parameter_id`),
  ADD KEY `idx_pldc_chem_rep_shift` (`shift_id`),
  ADD KEY `idx_pldc_chem_rep_station` (`station_id`),
  ADD KEY `idx_pldc_chem_rep_token` (`token_id`),
  ADD KEY `idx_pldc_chem_rep_date` (`report_date`);

--
-- Indexes for table `dc_mcc_chemical_shifts`
--
ALTER TABLE `dc_mcc_chemical_shifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pldc_chem_shift_station` (`station_id`);

--
-- Indexes for table `dc_mcc_chemical_target`
--
ALTER TABLE `dc_mcc_chemical_target`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_pldc_chem_target` (`parameter_id`,`target_month`,`station_id`),
  ADD KEY `idx_pldc_chem_target_station` (`station_id`);

--
-- Indexes for table `dc_mcc_machine_param`
--
ALTER TABLE `dc_mcc_machine_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pldc_mach_param_station` (`station_id`);

--
-- Indexes for table `dc_mcc_machine_report`
--
ALTER TABLE `dc_mcc_machine_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pldc_mach_rep_param` (`parameter_id`),
  ADD KEY `idx_pldc_mach_rep_shift` (`shift_id`),
  ADD KEY `idx_pldc_mach_rep_station` (`station_id`);

--
-- Indexes for table `dc_mcc_machine_shifts`
--
ALTER TABLE `dc_mcc_machine_shifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pldc_mach_shift_station` (`station_id`);

--
-- Indexes for table `dc_mcc_machine_target`
--
ALTER TABLE `dc_mcc_machine_target`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pldc_mach_target_station` (`station_id`),
  ADD KEY `idx_pldc_mach_target_machine` (`machine_id`),
  ADD KEY `idx_pldc_mach_target_shift` (`shift_id`);

--
-- Indexes for table `dc_mcc_param`
--
ALTER TABLE `dc_mcc_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pldc_param_station` (`station_id`);

--
-- Indexes for table `dc_mcc_rating`
--
ALTER TABLE `dc_mcc_rating`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dc_mcc_report`
--
ALTER TABLE `dc_mcc_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pldc_rep_param` (`parameter_id`),
  ADD KEY `idx_pldc_rep_shift` (`shift_id`),
  ADD KEY `idx_pldc_rep_station` (`station_id`),
  ADD KEY `idx_pldc_rep_token` (`token_id`),
  ADD KEY `idx_pldc_rep_date` (`report_date`);

--
-- Indexes for table `dc_mcc_shifts`
--
ALTER TABLE `dc_mcc_shifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pldc_shift_station` (`station_id`);

--
-- Indexes for table `mcc_billing_conditions`
--
ALTER TABLE `mcc_billing_conditions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_billing_earnings`
--
ALTER TABLE `mcc_billing_earnings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mcc_billing_setup`
--
ALTER TABLE `mcc_billing_setup`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_cleanliness_report`
--
ALTER TABLE `mcc_cleanliness_report`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_cleanliness_date_station` (`report_date`,`station_id`),
  ADD KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_divisions`
--
ALTER TABLE `mcc_divisions`
  ADD PRIMARY KEY (`division_id`),
  ADD UNIQUE KEY `uk_division_zone` (`division_name`,`zone_id`),
  ADD KEY `idx_division_name` (`division_name`),
  ADD KEY `idx_division_zone` (`zone_id`);

--
-- Indexes for table `mcc_employee`
--
ALTER TABLE `mcc_employee`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `employee_id` (`employee_id`);

--
-- Indexes for table `mcc_imposed_penalties`
--
ALTER TABLE `mcc_imposed_penalties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_intensive_chemical_param`
--
ALTER TABLE `mcc_intensive_chemical_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_intensive_chem_param_station` (`station_id`);

--
-- Indexes for table `mcc_intensive_chemical_report`
--
ALTER TABLE `mcc_intensive_chemical_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_intensive_chem_rep_param` (`parameter_id`),
  ADD KEY `idx_intensive_chem_rep_station` (`station_id`),
  ADD KEY `idx_intensive_chem_rep_token` (`token_id`),
  ADD KEY `idx_intensive_chem_rep_date` (`report_date`);

--
-- Indexes for table `mcc_intensive_chemical_target`
--
ALTER TABLE `mcc_intensive_chemical_target`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_intensive_chem_target_param` (`parameter_id`),
  ADD KEY `idx_intensive_chem_target_station` (`station_id`);

--
-- Indexes for table `mcc_intensive_machine_param`
--
ALTER TABLE `mcc_intensive_machine_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_intensive_mach_param_station` (`station_id`);

--
-- Indexes for table `mcc_intensive_machine_report`
--
ALTER TABLE `mcc_intensive_machine_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_intensive_mach_rep_param` (`parameter_id`),
  ADD KEY `idx_intensive_mach_rep_shift` (`shift_id`),
  ADD KEY `idx_intensive_mach_rep_station` (`station_id`),
  ADD KEY `idx_intensive_mach_rep_token` (`token_id`);

--
-- Indexes for table `mcc_intensive_machine_shifts`
--
ALTER TABLE `mcc_intensive_machine_shifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_intensive_mach_shift_station` (`station_id`);

--
-- Indexes for table `mcc_intensive_machine_target`
--
ALTER TABLE `mcc_intensive_machine_target`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_intensive_mach_target_station` (`station_id`),
  ADD KEY `idx_intensive_mach_target_machine` (`machine_id`),
  ADD KEY `idx_intensive_mach_target_shift` (`shift_id`);

--
-- Indexes for table `mcc_intensive_pantry_chemical_param`
--
ALTER TABLE `mcc_intensive_pantry_chemical_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_intensive_pantry_chemical_report`
--
ALTER TABLE `mcc_intensive_pantry_chemical_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parameter_id` (`parameter_id`),
  ADD KEY `station_id` (`station_id`),
  ADD KEY `report_date` (`report_date`),
  ADD KEY `token_id` (`token_id`);

--
-- Indexes for table `mcc_intensive_pantry_chemical_target`
--
ALTER TABLE `mcc_intensive_pantry_chemical_target`
  ADD PRIMARY KEY (`id`),
  ADD KEY `station_id` (`station_id`),
  ADD KEY `chemical_id` (`parameter_id`);

--
-- Indexes for table `mcc_intensive_pantry_machine_param`
--
ALTER TABLE `mcc_intensive_pantry_machine_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_intensive_pantry_machine_report`
--
ALTER TABLE `mcc_intensive_pantry_machine_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parameter_id` (`parameter_id`),
  ADD KEY `station_id` (`station_id`),
  ADD KEY `report_date` (`report_date`),
  ADD KEY `token_id` (`token_id`);

--
-- Indexes for table `mcc_intensive_pantry_machine_shifts`
--
ALTER TABLE `mcc_intensive_pantry_machine_shifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_intensive_pantry_machine_target`
--
ALTER TABLE `mcc_intensive_pantry_machine_target`
  ADD PRIMARY KEY (`id`),
  ADD KEY `station_id` (`station_id`),
  ADD KEY `machine_id` (`machine_id`),
  ADD KEY `shift_id` (`shift_id`);

--
-- Indexes for table `mcc_intensive_pantry_param`
--
ALTER TABLE `mcc_intensive_pantry_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_intensive_pantry_rating`
--
ALTER TABLE `mcc_intensive_pantry_rating`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mcc_intensive_pantry_report`
--
ALTER TABLE `mcc_intensive_pantry_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_parameter_id` (`sub_parameter_id`),
  ADD KEY `station_id` (`station_id`),
  ADD KEY `token_id` (`token_id`),
  ADD KEY `report_date` (`report_date`);

--
-- Indexes for table `mcc_intensive_pantry_sub_param`
--
ALTER TABLE `mcc_intensive_pantry_sub_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parameter_id` (`parameter_id`),
  ADD KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_intensive_scorecard_2_param`
--
ALTER TABLE `mcc_intensive_scorecard_2_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_intensive_scorecard_2_rating`
--
ALTER TABLE `mcc_intensive_scorecard_2_rating`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mcc_intensive_scorecard_2_report`
--
ALTER TABLE `mcc_intensive_scorecard_2_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_parameter_id` (`sub_parameter_id`),
  ADD KEY `station_id` (`station_id`),
  ADD KEY `token_id` (`token_id`),
  ADD KEY `report_date` (`report_date`);

--
-- Indexes for table `mcc_intensive_scorecard_2_sub_param`
--
ALTER TABLE `mcc_intensive_scorecard_2_sub_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parameter_id` (`parameter_id`),
  ADD KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_intensive_scorecard_param`
--
ALTER TABLE `mcc_intensive_scorecard_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_intensive_sc_param_station` (`station_id`);

--
-- Indexes for table `mcc_intensive_scorecard_report`
--
ALTER TABLE `mcc_intensive_scorecard_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_intensive_sc_rep_sub_param` (`sub_parameter_id`),
  ADD KEY `idx_intensive_sc_rep_station` (`station_id`),
  ADD KEY `idx_intensive_sc_rep_token` (`token_id`),
  ADD KEY `idx_intensive_sc_rep_date` (`report_date`),
  ADD KEY `fk_intensive_sc_rep_user` (`submitted_by`);

--
-- Indexes for table `mcc_intensive_scorecard_sub_param`
--
ALTER TABLE `mcc_intensive_scorecard_sub_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_intensive_sc_sub_param_station` (`station_id`),
  ADD KEY `idx_intensive_sc_sub_param_parent` (`parameter_id`);

--
-- Indexes for table `mcc_intensive_score_card`
--
ALTER TABLE `mcc_intensive_score_card`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_intensive_score_card_station` (`station_id`);

--
-- Indexes for table `mcc_manpower_categories`
--
ALTER TABLE `mcc_manpower_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_manpower_category_station` (`station_id`);

--
-- Indexes for table `mcc_manpower_log`
--
ALTER TABLE `mcc_manpower_log`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_log_station_date_shift_type` (`station_id`,`report_date`,`shift_id`,`manpower_type_id`),
  ADD KEY `fk_log_shift` (`shift_id`),
  ADD KEY `fk_log_type` (`manpower_type_id`),
  ADD KEY `fk_log_category` (`category_id`);

--
-- Indexes for table `mcc_manpower_penalties`
--
ALTER TABLE `mcc_manpower_penalties`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `station_month_type` (`station_id`,`effective_month`,`manpower_type_id`);

--
-- Indexes for table `mcc_manpower_shifts`
--
ALTER TABLE `mcc_manpower_shifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_manpower_shift_category` (`category_id`);

--
-- Indexes for table `mcc_manpower_shift_type_map`
--
ALTER TABLE `mcc_manpower_shift_type_map`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_shift_type` (`shift_id`,`manpower_type_id`),
  ADD KEY `fk_map_station` (`station_id`),
  ADD KEY `fk_map_type` (`manpower_type_id`);

--
-- Indexes for table `mcc_manpower_targets`
--
ALTER TABLE `mcc_manpower_targets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_station_date_cat_type` (`station_id`,`target_date`,`category_id`,`manpower_type_id`),
  ADD KEY `fk_target_type` (`manpower_type_id`);

--
-- Indexes for table `mcc_manpower_types`
--
ALTER TABLE `mcc_manpower_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_station_role` (`station_id`,`role_name`);

--
-- Indexes for table `mcc_normal_chemical_param`
--
ALTER TABLE `mcc_normal_chemical_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_normal_chem_param_station` (`station_id`);

--
-- Indexes for table `mcc_normal_chemical_report`
--
ALTER TABLE `mcc_normal_chemical_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_normal_chem_rep_param` (`parameter_id`),
  ADD KEY `idx_normal_chem_rep_station` (`station_id`),
  ADD KEY `idx_normal_chem_rep_token` (`token_id`),
  ADD KEY `idx_normal_chem_rep_date` (`report_date`);

--
-- Indexes for table `mcc_normal_chemical_target`
--
ALTER TABLE `mcc_normal_chemical_target`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_normal_chem_target_param` (`parameter_id`),
  ADD KEY `idx_normal_chem_target_station` (`station_id`);

--
-- Indexes for table `mcc_normal_machine_param`
--
ALTER TABLE `mcc_normal_machine_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_normal_mach_param_station` (`station_id`);

--
-- Indexes for table `mcc_normal_machine_report`
--
ALTER TABLE `mcc_normal_machine_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_normal_mach_rep_param` (`parameter_id`),
  ADD KEY `idx_normal_mach_rep_shift` (`shift_id`),
  ADD KEY `idx_normal_mach_rep_station` (`station_id`),
  ADD KEY `idx_normal_mach_rep_token` (`token_id`);

--
-- Indexes for table `mcc_normal_machine_shifts`
--
ALTER TABLE `mcc_normal_machine_shifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_normal_mach_shift_station` (`station_id`);

--
-- Indexes for table `mcc_normal_machine_target`
--
ALTER TABLE `mcc_normal_machine_target`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_normal_mach_target_station` (`station_id`),
  ADD KEY `idx_normal_mach_target_machine` (`machine_id`),
  ADD KEY `idx_normal_mach_target_shift` (`shift_id`);

--
-- Indexes for table `mcc_normal_rating`
--
ALTER TABLE `mcc_normal_rating`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mcc_normal_scorecard_param`
--
ALTER TABLE `mcc_normal_scorecard_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_normal_sc_param_station` (`station_id`);

--
-- Indexes for table `mcc_normal_scorecard_report`
--
ALTER TABLE `mcc_normal_scorecard_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_normal_sc_rep_sub_param` (`sub_parameter_id`),
  ADD KEY `idx_normal_sc_rep_station` (`station_id`),
  ADD KEY `idx_normal_sc_rep_token` (`token_id`),
  ADD KEY `idx_normal_sc_rep_date` (`report_date`);

--
-- Indexes for table `mcc_normal_scorecard_sub_param`
--
ALTER TABLE `mcc_normal_scorecard_sub_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_normal_sc_sub_param_station` (`station_id`),
  ADD KEY `idx_normal_sc_sub_param_parent` (`parameter_id`);

--
-- Indexes for table `mcc_normal_score_card`
--
ALTER TABLE `mcc_normal_score_card`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mcc_parameters`
--
ALTER TABLE `mcc_parameters`
  ADD PRIMARY KEY (`parameter_id`);

--
-- Indexes for table `mcc_photo_report`
--
ALTER TABLE `mcc_photo_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_prt_chemical_param`
--
ALTER TABLE `mcc_prt_chemical_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_prt_chem_param_station` (`station_id`);

--
-- Indexes for table `mcc_prt_chemical_report`
--
ALTER TABLE `mcc_prt_chemical_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_prt_chem_rep_param` (`parameter_id`),
  ADD KEY `idx_prt_chem_rep_station` (`station_id`),
  ADD KEY `idx_prt_chem_rep_token` (`token_id`),
  ADD KEY `idx_prt_chem_rep_date` (`report_date`);

--
-- Indexes for table `mcc_prt_chemical_target`
--
ALTER TABLE `mcc_prt_chemical_target`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_prt_chem_target_param` (`parameter_id`),
  ADD KEY `idx_prt_chem_target_station` (`station_id`);

--
-- Indexes for table `mcc_prt_machine_param`
--
ALTER TABLE `mcc_prt_machine_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_prt_mach_param_station` (`station_id`);

--
-- Indexes for table `mcc_prt_machine_report`
--
ALTER TABLE `mcc_prt_machine_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_prt_mach_rep_param` (`parameter_id`),
  ADD KEY `idx_prt_mach_rep_shift` (`shift_id`),
  ADD KEY `idx_prt_mach_rep_station` (`station_id`),
  ADD KEY `idx_prt_mach_rep_token` (`token_id`);

--
-- Indexes for table `mcc_prt_machine_shifts`
--
ALTER TABLE `mcc_prt_machine_shifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_prt_mach_shift_station` (`station_id`);

--
-- Indexes for table `mcc_prt_machine_target`
--
ALTER TABLE `mcc_prt_machine_target`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_prt_mach_target_station` (`station_id`),
  ADD KEY `idx_prt_mach_target_machine` (`machine_id`),
  ADD KEY `idx_prt_mach_target_shift` (`shift_id`);

--
-- Indexes for table `mcc_prt_rating`
--
ALTER TABLE `mcc_prt_rating`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mcc_prt_scorecard_param`
--
ALTER TABLE `mcc_prt_scorecard_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_prt_param_station` (`station_id`);

--
-- Indexes for table `mcc_prt_scorecard_report`
--
ALTER TABLE `mcc_prt_scorecard_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_prt_rep_sub_param` (`sub_parameter_id`),
  ADD KEY `idx_prt_rep_station` (`station_id`),
  ADD KEY `idx_prt_rep_token` (`token_id`),
  ADD KEY `idx_prt_rep_user` (`auditor_name`);

--
-- Indexes for table `mcc_prt_scorecard_sub_param`
--
ALTER TABLE `mcc_prt_scorecard_sub_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_prt_sub_param_parent` (`parameter_id`),
  ADD KEY `idx_prt_sub_param_station` (`station_id`);

--
-- Indexes for table `mcc_reports`
--
ALTER TABLE `mcc_reports`
  ADD PRIMARY KEY (`report_id`);

--
-- Indexes for table `mcc_stations`
--
ALTER TABLE `mcc_stations`
  ADD PRIMARY KEY (`station_id`),
  ADD UNIQUE KEY `uk_station_division` (`station_name`,`division_id`),
  ADD KEY `idx_station_name` (`station_name`),
  ADD KEY `idx_station_division` (`division_id`);

--
-- Indexes for table `mcc_station_reports`
--
ALTER TABLE `mcc_station_reports`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_station_report` (`station_id`,`report_key`);

--
-- Indexes for table `mcc_subreports`
--
ALTER TABLE `mcc_subreports`
  ADD PRIMARY KEY (`subreport_id`);

--
-- Indexes for table `mcc_sub_parameters`
--
ALTER TABLE `mcc_sub_parameters`
  ADD PRIMARY KEY (`sub_parameter_id`);

--
-- Indexes for table `mcc_surprise_parameters`
--
ALTER TABLE `mcc_surprise_parameters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_surprise_reports`
--
ALTER TABLE `mcc_surprise_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `station_id` (`station_id`),
  ADD KEY `submitted_by` (`submitted_by`),
  ADD KEY `parameter_id` (`parameter_id`);

--
-- Indexes for table `mcc_users`
--
ALTER TABLE `mcc_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_name` (`user_name`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `user_code` (`user_code`),
  ADD KEY `created_by_user_id` (`created_by_user_id`),
  ADD KEY `idx_user_name` (`user_name`),
  ADD KEY `idx_user_station` (`station_id`),
  ADD KEY `idx_user_role` (`role`),
  ADD KEY `idx_user_email` (`email`);

--
-- Indexes for table `mcc_vb_chemical_param`
--
ALTER TABLE `mcc_vb_chemical_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_vb_chemical_report`
--
ALTER TABLE `mcc_vb_chemical_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parameter_id` (`parameter_id`),
  ADD KEY `station_id` (`station_id`),
  ADD KEY `token_id` (`token_id`),
  ADD KEY `report_date` (`report_date`);

--
-- Indexes for table `mcc_vb_chemical_target`
--
ALTER TABLE `mcc_vb_chemical_target`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parameter_id` (`parameter_id`),
  ADD KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_vb_machine_param`
--
ALTER TABLE `mcc_vb_machine_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_vb_machine_report`
--
ALTER TABLE `mcc_vb_machine_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parameter_id` (`parameter_id`),
  ADD KEY `shift_id` (`shift_id`),
  ADD KEY `station_id` (`station_id`),
  ADD KEY `token_id` (`token_id`),
  ADD KEY `report_date` (`report_date`);

--
-- Indexes for table `mcc_vb_machine_shifts`
--
ALTER TABLE `mcc_vb_machine_shifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_vb_machine_target`
--
ALTER TABLE `mcc_vb_machine_target`
  ADD PRIMARY KEY (`id`),
  ADD KEY `station_id` (`station_id`),
  ADD KEY `machine_id` (`machine_id`);

--
-- Indexes for table `mcc_vb_rating`
--
ALTER TABLE `mcc_vb_rating`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mcc_vb_scorecard_param`
--
ALTER TABLE `mcc_vb_scorecard_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_vb_scorecard_report`
--
ALTER TABLE `mcc_vb_scorecard_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_parameter_id` (`sub_parameter_id`),
  ADD KEY `station_id` (`station_id`),
  ADD KEY `token_id` (`token_id`),
  ADD KEY `report_date` (`report_date`);

--
-- Indexes for table `mcc_vb_scorecard_sub_param`
--
ALTER TABLE `mcc_vb_scorecard_sub_param`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parameter_id` (`parameter_id`),
  ADD KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_zones`
--
ALTER TABLE `mcc_zones`
  ADD PRIMARY KEY (`zone_id`),
  ADD UNIQUE KEY `zone_name` (`zone_name`),
  ADD KEY `idx_zone_name` (`zone_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `app_version`
--
ALTER TABLE `app_version`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `attendance_logs`
--
ALTER TABLE `attendance_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `dc_mcc_chemical_param`
--
ALTER TABLE `dc_mcc_chemical_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `dc_mcc_chemical_report`
--
ALTER TABLE `dc_mcc_chemical_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `dc_mcc_chemical_shifts`
--
ALTER TABLE `dc_mcc_chemical_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `dc_mcc_chemical_target`
--
ALTER TABLE `dc_mcc_chemical_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `dc_mcc_machine_param`
--
ALTER TABLE `dc_mcc_machine_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dc_mcc_machine_report`
--
ALTER TABLE `dc_mcc_machine_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `dc_mcc_machine_shifts`
--
ALTER TABLE `dc_mcc_machine_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dc_mcc_machine_target`
--
ALTER TABLE `dc_mcc_machine_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `dc_mcc_param`
--
ALTER TABLE `dc_mcc_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `dc_mcc_rating`
--
ALTER TABLE `dc_mcc_rating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `dc_mcc_report`
--
ALTER TABLE `dc_mcc_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `dc_mcc_shifts`
--
ALTER TABLE `dc_mcc_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `mcc_billing_conditions`
--
ALTER TABLE `mcc_billing_conditions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `mcc_billing_earnings`
--
ALTER TABLE `mcc_billing_earnings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `mcc_billing_setup`
--
ALTER TABLE `mcc_billing_setup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `mcc_cleanliness_report`
--
ALTER TABLE `mcc_cleanliness_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `mcc_divisions`
--
ALTER TABLE `mcc_divisions`
  MODIFY `division_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;

--
-- AUTO_INCREMENT for table `mcc_employee`
--
ALTER TABLE `mcc_employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `mcc_imposed_penalties`
--
ALTER TABLE `mcc_imposed_penalties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `mcc_intensive_chemical_param`
--
ALTER TABLE `mcc_intensive_chemical_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `mcc_intensive_chemical_report`
--
ALTER TABLE `mcc_intensive_chemical_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `mcc_intensive_chemical_target`
--
ALTER TABLE `mcc_intensive_chemical_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `mcc_intensive_machine_param`
--
ALTER TABLE `mcc_intensive_machine_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `mcc_intensive_machine_report`
--
ALTER TABLE `mcc_intensive_machine_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `mcc_intensive_machine_shifts`
--
ALTER TABLE `mcc_intensive_machine_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mcc_intensive_machine_target`
--
ALTER TABLE `mcc_intensive_machine_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_chemical_param`
--
ALTER TABLE `mcc_intensive_pantry_chemical_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_chemical_report`
--
ALTER TABLE `mcc_intensive_pantry_chemical_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_chemical_target`
--
ALTER TABLE `mcc_intensive_pantry_chemical_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_machine_param`
--
ALTER TABLE `mcc_intensive_pantry_machine_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_machine_report`
--
ALTER TABLE `mcc_intensive_pantry_machine_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_machine_shifts`
--
ALTER TABLE `mcc_intensive_pantry_machine_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_machine_target`
--
ALTER TABLE `mcc_intensive_pantry_machine_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_param`
--
ALTER TABLE `mcc_intensive_pantry_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_rating`
--
ALTER TABLE `mcc_intensive_pantry_rating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_report`
--
ALTER TABLE `mcc_intensive_pantry_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_sub_param`
--
ALTER TABLE `mcc_intensive_pantry_sub_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=148;

--
-- AUTO_INCREMENT for table `mcc_intensive_scorecard_2_param`
--
ALTER TABLE `mcc_intensive_scorecard_2_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `mcc_intensive_scorecard_2_rating`
--
ALTER TABLE `mcc_intensive_scorecard_2_rating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mcc_intensive_scorecard_2_report`
--
ALTER TABLE `mcc_intensive_scorecard_2_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=533;

--
-- AUTO_INCREMENT for table `mcc_intensive_scorecard_2_sub_param`
--
ALTER TABLE `mcc_intensive_scorecard_2_sub_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=229;

--
-- AUTO_INCREMENT for table `mcc_intensive_scorecard_param`
--
ALTER TABLE `mcc_intensive_scorecard_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mcc_intensive_scorecard_report`
--
ALTER TABLE `mcc_intensive_scorecard_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `mcc_intensive_scorecard_sub_param`
--
ALTER TABLE `mcc_intensive_scorecard_sub_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `mcc_intensive_score_card`
--
ALTER TABLE `mcc_intensive_score_card`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=215;

--
-- AUTO_INCREMENT for table `mcc_manpower_categories`
--
ALTER TABLE `mcc_manpower_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `mcc_manpower_log`
--
ALTER TABLE `mcc_manpower_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `mcc_manpower_penalties`
--
ALTER TABLE `mcc_manpower_penalties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `mcc_manpower_shifts`
--
ALTER TABLE `mcc_manpower_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `mcc_manpower_shift_type_map`
--
ALTER TABLE `mcc_manpower_shift_type_map`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `mcc_manpower_targets`
--
ALTER TABLE `mcc_manpower_targets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `mcc_manpower_types`
--
ALTER TABLE `mcc_manpower_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `mcc_normal_chemical_param`
--
ALTER TABLE `mcc_normal_chemical_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `mcc_normal_chemical_report`
--
ALTER TABLE `mcc_normal_chemical_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- AUTO_INCREMENT for table `mcc_normal_chemical_target`
--
ALTER TABLE `mcc_normal_chemical_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `mcc_normal_machine_param`
--
ALTER TABLE `mcc_normal_machine_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `mcc_normal_machine_report`
--
ALTER TABLE `mcc_normal_machine_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `mcc_normal_machine_shifts`
--
ALTER TABLE `mcc_normal_machine_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mcc_normal_machine_target`
--
ALTER TABLE `mcc_normal_machine_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `mcc_normal_rating`
--
ALTER TABLE `mcc_normal_rating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mcc_normal_scorecard_param`
--
ALTER TABLE `mcc_normal_scorecard_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `mcc_normal_scorecard_report`
--
ALTER TABLE `mcc_normal_scorecard_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `mcc_normal_scorecard_sub_param`
--
ALTER TABLE `mcc_normal_scorecard_sub_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `mcc_normal_score_card`
--
ALTER TABLE `mcc_normal_score_card`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mcc_parameters`
--
ALTER TABLE `mcc_parameters`
  MODIFY `parameter_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `mcc_photo_report`
--
ALTER TABLE `mcc_photo_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `mcc_prt_chemical_param`
--
ALTER TABLE `mcc_prt_chemical_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `mcc_prt_chemical_report`
--
ALTER TABLE `mcc_prt_chemical_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=169;

--
-- AUTO_INCREMENT for table `mcc_prt_chemical_target`
--
ALTER TABLE `mcc_prt_chemical_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `mcc_prt_machine_param`
--
ALTER TABLE `mcc_prt_machine_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `mcc_prt_machine_report`
--
ALTER TABLE `mcc_prt_machine_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `mcc_prt_machine_shifts`
--
ALTER TABLE `mcc_prt_machine_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mcc_prt_machine_target`
--
ALTER TABLE `mcc_prt_machine_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `mcc_prt_rating`
--
ALTER TABLE `mcc_prt_rating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mcc_prt_scorecard_param`
--
ALTER TABLE `mcc_prt_scorecard_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mcc_prt_scorecard_report`
--
ALTER TABLE `mcc_prt_scorecard_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=145;

--
-- AUTO_INCREMENT for table `mcc_prt_scorecard_sub_param`
--
ALTER TABLE `mcc_prt_scorecard_sub_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `mcc_reports`
--
ALTER TABLE `mcc_reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `mcc_stations`
--
ALTER TABLE `mcc_stations`
  MODIFY `station_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `mcc_station_reports`
--
ALTER TABLE `mcc_station_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT for table `mcc_subreports`
--
ALTER TABLE `mcc_subreports`
  MODIFY `subreport_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `mcc_sub_parameters`
--
ALTER TABLE `mcc_sub_parameters`
  MODIFY `sub_parameter_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `mcc_surprise_parameters`
--
ALTER TABLE `mcc_surprise_parameters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `mcc_surprise_reports`
--
ALTER TABLE `mcc_surprise_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `mcc_users`
--
ALTER TABLE `mcc_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `mcc_vb_chemical_param`
--
ALTER TABLE `mcc_vb_chemical_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `mcc_vb_chemical_report`
--
ALTER TABLE `mcc_vb_chemical_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- AUTO_INCREMENT for table `mcc_vb_chemical_target`
--
ALTER TABLE `mcc_vb_chemical_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `mcc_vb_machine_param`
--
ALTER TABLE `mcc_vb_machine_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `mcc_vb_machine_report`
--
ALTER TABLE `mcc_vb_machine_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `mcc_vb_machine_shifts`
--
ALTER TABLE `mcc_vb_machine_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `mcc_vb_machine_target`
--
ALTER TABLE `mcc_vb_machine_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `mcc_vb_rating`
--
ALTER TABLE `mcc_vb_rating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mcc_vb_scorecard_param`
--
ALTER TABLE `mcc_vb_scorecard_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `mcc_vb_scorecard_report`
--
ALTER TABLE `mcc_vb_scorecard_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `mcc_vb_scorecard_sub_param`
--
ALTER TABLE `mcc_vb_scorecard_sub_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `mcc_zones`
--
ALTER TABLE `mcc_zones`
  MODIFY `zone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dc_mcc_chemical_param`
--
ALTER TABLE `dc_mcc_chemical_param`
  ADD CONSTRAINT `fk_pldc_chem_param_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `dc_mcc_chemical_report`
--
ALTER TABLE `dc_mcc_chemical_report`
  ADD CONSTRAINT `fk_pldc_chem_rep_param` FOREIGN KEY (`parameter_id`) REFERENCES `dc_mcc_chemical_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pldc_chem_rep_shift` FOREIGN KEY (`shift_id`) REFERENCES `dc_mcc_chemical_shifts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pldc_chem_rep_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `dc_mcc_chemical_shifts`
--
ALTER TABLE `dc_mcc_chemical_shifts`
  ADD CONSTRAINT `fk_pldc_chem_shift_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `dc_mcc_chemical_target`
--
ALTER TABLE `dc_mcc_chemical_target`
  ADD CONSTRAINT `fk_pldc_chem_target_param` FOREIGN KEY (`parameter_id`) REFERENCES `dc_mcc_chemical_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pldc_chem_target_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `dc_mcc_machine_param`
--
ALTER TABLE `dc_mcc_machine_param`
  ADD CONSTRAINT `fk_pldc_mach_param_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `dc_mcc_machine_report`
--
ALTER TABLE `dc_mcc_machine_report`
  ADD CONSTRAINT `fk_pldc_mach_rep_param` FOREIGN KEY (`parameter_id`) REFERENCES `dc_mcc_machine_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pldc_mach_rep_shift` FOREIGN KEY (`shift_id`) REFERENCES `dc_mcc_machine_shifts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pldc_mach_rep_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `dc_mcc_machine_shifts`
--
ALTER TABLE `dc_mcc_machine_shifts`
  ADD CONSTRAINT `fk_pldc_mach_shift_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `dc_mcc_machine_target`
--
ALTER TABLE `dc_mcc_machine_target`
  ADD CONSTRAINT `fk_pldc_mach_target_machine` FOREIGN KEY (`machine_id`) REFERENCES `dc_mcc_machine_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pldc_mach_target_shift` FOREIGN KEY (`shift_id`) REFERENCES `dc_mcc_machine_shifts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pldc_mach_target_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `dc_mcc_param`
--
ALTER TABLE `dc_mcc_param`
  ADD CONSTRAINT `fk_pldc_param_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `dc_mcc_report`
--
ALTER TABLE `dc_mcc_report`
  ADD CONSTRAINT `fk_pldc_rep_param` FOREIGN KEY (`parameter_id`) REFERENCES `dc_mcc_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pldc_rep_shift` FOREIGN KEY (`shift_id`) REFERENCES `dc_mcc_shifts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_pldc_rep_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `dc_mcc_shifts`
--
ALTER TABLE `dc_mcc_shifts`
  ADD CONSTRAINT `fk_pldc_shift_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_billing_conditions`
--
ALTER TABLE `mcc_billing_conditions`
  ADD CONSTRAINT `mcc_billing_conditions_ibfk_1` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_cleanliness_report`
--
ALTER TABLE `mcc_cleanliness_report`
  ADD CONSTRAINT `mcc_cleanliness_report_ibfk_1` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_divisions`
--
ALTER TABLE `mcc_divisions`
  ADD CONSTRAINT `Mcc_divisions_ibfk_1` FOREIGN KEY (`zone_id`) REFERENCES `mcc_zones` (`zone_id`);

--
-- Constraints for table `mcc_imposed_penalties`
--
ALTER TABLE `mcc_imposed_penalties`
  ADD CONSTRAINT `mcc_imposed_penalties_ibfk_1` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_intensive_chemical_param`
--
ALTER TABLE `mcc_intensive_chemical_param`
  ADD CONSTRAINT `fk_intensive_chem_param_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_intensive_chemical_report`
--
ALTER TABLE `mcc_intensive_chemical_report`
  ADD CONSTRAINT `fk_intensive_chem_rep_param` FOREIGN KEY (`parameter_id`) REFERENCES `mcc_intensive_chemical_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_intensive_chem_rep_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_intensive_chemical_target`
--
ALTER TABLE `mcc_intensive_chemical_target`
  ADD CONSTRAINT `fk_intensive_chem_target_param` FOREIGN KEY (`parameter_id`) REFERENCES `mcc_intensive_chemical_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_intensive_chem_target_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_intensive_machine_param`
--
ALTER TABLE `mcc_intensive_machine_param`
  ADD CONSTRAINT `fk_intensive_mach_param_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_intensive_machine_report`
--
ALTER TABLE `mcc_intensive_machine_report`
  ADD CONSTRAINT `fk_intensive_mach_rep_param` FOREIGN KEY (`parameter_id`) REFERENCES `mcc_intensive_machine_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_intensive_mach_rep_shift` FOREIGN KEY (`shift_id`) REFERENCES `mcc_intensive_machine_shifts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_intensive_mach_rep_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_intensive_machine_shifts`
--
ALTER TABLE `mcc_intensive_machine_shifts`
  ADD CONSTRAINT `fk_intensive_mach_shift_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_intensive_machine_target`
--
ALTER TABLE `mcc_intensive_machine_target`
  ADD CONSTRAINT `fk_intensive_mach_target_machine` FOREIGN KEY (`machine_id`) REFERENCES `mcc_intensive_machine_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_intensive_mach_target_shift` FOREIGN KEY (`shift_id`) REFERENCES `mcc_intensive_machine_shifts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_intensive_mach_target_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_intensive_scorecard_param`
--
ALTER TABLE `mcc_intensive_scorecard_param`
  ADD CONSTRAINT `fk_intensive_sc_param_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_intensive_scorecard_report`
--
ALTER TABLE `mcc_intensive_scorecard_report`
  ADD CONSTRAINT `fk_intensive_sc_rep_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_intensive_sc_rep_sub_param` FOREIGN KEY (`sub_parameter_id`) REFERENCES `mcc_intensive_scorecard_sub_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_intensive_sc_rep_user` FOREIGN KEY (`submitted_by`) REFERENCES `mcc_users` (`user_id`);

--
-- Constraints for table `mcc_intensive_scorecard_sub_param`
--
ALTER TABLE `mcc_intensive_scorecard_sub_param`
  ADD CONSTRAINT `fk_intensive_sc_sub_param_parent` FOREIGN KEY (`parameter_id`) REFERENCES `mcc_intensive_scorecard_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_intensive_sc_sub_param_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_intensive_score_card`
--
ALTER TABLE `mcc_intensive_score_card`
  ADD CONSTRAINT `fk_intensive_score_card_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_manpower_categories`
--
ALTER TABLE `mcc_manpower_categories`
  ADD CONSTRAINT `fk_manpower_category_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_manpower_log`
--
ALTER TABLE `mcc_manpower_log`
  ADD CONSTRAINT `fk_log_category` FOREIGN KEY (`category_id`) REFERENCES `mcc_manpower_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_log_shift` FOREIGN KEY (`shift_id`) REFERENCES `mcc_manpower_shifts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_log_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_log_type` FOREIGN KEY (`manpower_type_id`) REFERENCES `mcc_manpower_types` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_manpower_shifts`
--
ALTER TABLE `mcc_manpower_shifts`
  ADD CONSTRAINT `fk_manpower_shift_category` FOREIGN KEY (`category_id`) REFERENCES `mcc_manpower_categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_manpower_shift_type_map`
--
ALTER TABLE `mcc_manpower_shift_type_map`
  ADD CONSTRAINT `fk_map_shift` FOREIGN KEY (`shift_id`) REFERENCES `mcc_manpower_shifts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_map_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_map_type` FOREIGN KEY (`manpower_type_id`) REFERENCES `mcc_manpower_types` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_manpower_targets`
--
ALTER TABLE `mcc_manpower_targets`
  ADD CONSTRAINT `fk_target_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_target_type` FOREIGN KEY (`manpower_type_id`) REFERENCES `mcc_manpower_types` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_manpower_types`
--
ALTER TABLE `mcc_manpower_types`
  ADD CONSTRAINT `fk_manpower_type_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_normal_chemical_param`
--
ALTER TABLE `mcc_normal_chemical_param`
  ADD CONSTRAINT `fk_normal_chem_param_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_normal_chemical_report`
--
ALTER TABLE `mcc_normal_chemical_report`
  ADD CONSTRAINT `fk_normal_chem_rep_param` FOREIGN KEY (`parameter_id`) REFERENCES `mcc_normal_chemical_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_normal_chem_rep_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_normal_chemical_target`
--
ALTER TABLE `mcc_normal_chemical_target`
  ADD CONSTRAINT `fk_normal_chem_target_param` FOREIGN KEY (`parameter_id`) REFERENCES `mcc_normal_chemical_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_normal_chem_target_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_normal_machine_param`
--
ALTER TABLE `mcc_normal_machine_param`
  ADD CONSTRAINT `fk_normal_mach_param_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_normal_machine_report`
--
ALTER TABLE `mcc_normal_machine_report`
  ADD CONSTRAINT `fk_normal_mach_rep_param` FOREIGN KEY (`parameter_id`) REFERENCES `mcc_normal_machine_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_normal_mach_rep_shift` FOREIGN KEY (`shift_id`) REFERENCES `mcc_normal_machine_shifts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_normal_mach_rep_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_normal_machine_shifts`
--
ALTER TABLE `mcc_normal_machine_shifts`
  ADD CONSTRAINT `fk_normal_mach_shift_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_normal_machine_target`
--
ALTER TABLE `mcc_normal_machine_target`
  ADD CONSTRAINT `fk_normal_mach_target_machine` FOREIGN KEY (`machine_id`) REFERENCES `mcc_normal_machine_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_normal_mach_target_shift` FOREIGN KEY (`shift_id`) REFERENCES `mcc_normal_machine_shifts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_normal_mach_target_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_normal_scorecard_param`
--
ALTER TABLE `mcc_normal_scorecard_param`
  ADD CONSTRAINT `fk_normal_sc_param_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_normal_scorecard_report`
--
ALTER TABLE `mcc_normal_scorecard_report`
  ADD CONSTRAINT `fk_normal_sc_rep_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_normal_sc_rep_sub_param` FOREIGN KEY (`sub_parameter_id`) REFERENCES `mcc_normal_scorecard_sub_param` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_normal_scorecard_sub_param`
--
ALTER TABLE `mcc_normal_scorecard_sub_param`
  ADD CONSTRAINT `fk_normal_sc_sub_param_parent` FOREIGN KEY (`parameter_id`) REFERENCES `mcc_normal_scorecard_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_normal_sc_sub_param_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_photo_report`
--
ALTER TABLE `mcc_photo_report`
  ADD CONSTRAINT `mcc_photo_report_ibfk_1` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_prt_chemical_param`
--
ALTER TABLE `mcc_prt_chemical_param`
  ADD CONSTRAINT `fk_prt_chem_param_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_prt_chemical_report`
--
ALTER TABLE `mcc_prt_chemical_report`
  ADD CONSTRAINT `fk_prt_chem_rep_param` FOREIGN KEY (`parameter_id`) REFERENCES `mcc_prt_chemical_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_prt_chem_rep_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_prt_chemical_target`
--
ALTER TABLE `mcc_prt_chemical_target`
  ADD CONSTRAINT `fk_prt_chem_target_param` FOREIGN KEY (`parameter_id`) REFERENCES `mcc_prt_chemical_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_prt_chem_target_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_prt_machine_param`
--
ALTER TABLE `mcc_prt_machine_param`
  ADD CONSTRAINT `fk_prt_mach_param_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_prt_machine_report`
--
ALTER TABLE `mcc_prt_machine_report`
  ADD CONSTRAINT `fk_prt_mach_rep_param` FOREIGN KEY (`parameter_id`) REFERENCES `mcc_prt_machine_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_prt_mach_rep_shift` FOREIGN KEY (`shift_id`) REFERENCES `mcc_prt_machine_shifts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_prt_mach_rep_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_prt_machine_shifts`
--
ALTER TABLE `mcc_prt_machine_shifts`
  ADD CONSTRAINT `fk_prt_mach_shift_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_prt_machine_target`
--
ALTER TABLE `mcc_prt_machine_target`
  ADD CONSTRAINT `fk_prt_mach_target_machine` FOREIGN KEY (`machine_id`) REFERENCES `mcc_prt_machine_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_prt_mach_target_shift` FOREIGN KEY (`shift_id`) REFERENCES `mcc_prt_machine_shifts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_prt_mach_target_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_prt_scorecard_param`
--
ALTER TABLE `mcc_prt_scorecard_param`
  ADD CONSTRAINT `fk_prt_param_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_prt_scorecard_report`
--
ALTER TABLE `mcc_prt_scorecard_report`
  ADD CONSTRAINT `fk_prt_rep_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_prt_rep_sub_param` FOREIGN KEY (`sub_parameter_id`) REFERENCES `mcc_prt_scorecard_sub_param` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_prt_scorecard_sub_param`
--
ALTER TABLE `mcc_prt_scorecard_sub_param`
  ADD CONSTRAINT `fk_prt_sub_param_parent` FOREIGN KEY (`parameter_id`) REFERENCES `mcc_prt_scorecard_param` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_prt_sub_param_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_stations`
--
ALTER TABLE `mcc_stations`
  ADD CONSTRAINT `Mcc_stations_ibfk_1` FOREIGN KEY (`division_id`) REFERENCES `mcc_divisions` (`division_id`);

--
-- Constraints for table `mcc_station_reports`
--
ALTER TABLE `mcc_station_reports`
  ADD CONSTRAINT `fk_station_reports_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_surprise_parameters`
--
ALTER TABLE `mcc_surprise_parameters`
  ADD CONSTRAINT `mcc_surprise_parameters_ibfk_1` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_surprise_reports`
--
ALTER TABLE `mcc_surprise_reports`
  ADD CONSTRAINT `mcc_surprise_reports_ibfk_1` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mcc_surprise_reports_ibfk_2` FOREIGN KEY (`submitted_by`) REFERENCES `mcc_users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `mcc_surprise_reports_ibfk_3` FOREIGN KEY (`parameter_id`) REFERENCES `mcc_surprise_parameters` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_users`
--
ALTER TABLE `mcc_users`
  ADD CONSTRAINT `Mcc_users_ibfk_1` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`),
  ADD CONSTRAINT `Mcc_users_ibfk_2` FOREIGN KEY (`created_by_user_id`) REFERENCES `mcc_users` (`user_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
