-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 12, 2026 at 03:54 PM
-- Server version: 10.11.19-MariaDB
-- PHP Version: 8.4.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mccbeatleanalyti_db`
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
(1, 'DEP101', 'Ramesh Kumar', '2026-09-10 06:15:00', '0', 'DEV_DEP', 'SN_DEP', 'Fingerprint', 'coaching', '2026-09-10 09:36:01'),
(2, 'DEP101', 'Ramesh Kumar', '2026-09-10 13:45:00', '1', 'DEV_DEP', 'SN_DEP', 'Fingerprint', 'coaching', '2026-09-10 09:36:01'),
(3, 'DEP102', 'Vijay Singh', '2026-09-10 14:15:00', '0', 'DEV_DEP', 'SN_DEP', 'Fingerprint', 'coaching', '2026-09-10 09:36:01'),
(4, 'DEP102', 'Vijay Singh', '2026-09-10 21:45:00', '1', 'DEV_DEP', 'SN_DEP', 'Fingerprint', 'coaching', '2026-09-10 09:36:01'),
(5, 'DEP103', 'Rajesh Gupta', '2026-09-10 22:15:00', '0', 'DEV_DEP', 'SN_DEP', 'Fingerprint', 'coaching', '2026-09-10 09:36:02'),
(6, 'DEP103', 'Rajesh Gupta', '2026-09-11 05:30:00', '1', 'DEV_DEP', 'SN_DEP', 'Fingerprint', 'coaching', '2026-09-10 09:36:02'),
(7, 'PRT201', 'Suresh Patel', '2026-09-10 06:15:00', '0', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:02'),
(8, 'PRT201', 'Suresh Patel', '2026-09-10 13:45:00', '1', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:02'),
(9, 'PRT202', 'Manoj Yadav', '2026-09-10 14:15:00', '0', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:02'),
(10, 'PRT202', 'Manoj Yadav', '2026-09-10 21:45:00', '1', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:02'),
(11, 'PRT203', 'Anil Kumar', '2026-09-10 22:15:00', '0', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:02'),
(12, 'PRT203', 'Anil Kumar', '2026-09-11 05:30:00', '1', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:03'),
(13, 'VB301', 'Amit Sharma', '2026-09-10 06:30:00', '0', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:03'),
(14, 'VB301', 'Amit Sharma', '2026-09-10 07:30:00', '1', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:03'),
(15, 'VB302', 'Priya Verma', '2026-09-10 14:30:00', '0', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:03'),
(16, 'VB302', 'Priya Verma', '2026-09-10 15:25:00', '1', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:03'),
(17, 'VB303', 'Sunil Sharma', '2026-09-10 22:30:00', '0', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:03'),
(18, 'VB303', 'Sunil Sharma', '2026-09-10 23:40:00', '1', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:03'),
(19, 'DEP101', 'Ramesh Kumar', '2026-09-11 06:15:00', '0', 'DEV_DEP', 'SN_DEP', 'Fingerprint', 'coaching', '2026-09-10 09:36:03'),
(20, 'DEP101', 'Ramesh Kumar', '2026-09-11 13:45:00', '1', 'DEV_DEP', 'SN_DEP', 'Fingerprint', 'coaching', '2026-09-10 09:36:03'),
(21, 'DEP102', 'Vijay Singh', '2026-09-11 14:15:00', '0', 'DEV_DEP', 'SN_DEP', 'Fingerprint', 'coaching', '2026-09-10 09:36:04'),
(22, 'DEP102', 'Vijay Singh', '2026-09-11 21:45:00', '1', 'DEV_DEP', 'SN_DEP', 'Fingerprint', 'coaching', '2026-09-10 09:36:04'),
(23, 'DEP103', 'Rajesh Gupta', '2026-09-11 22:15:00', '0', 'DEV_DEP', 'SN_DEP', 'Fingerprint', 'coaching', '2026-09-10 09:36:04'),
(24, 'DEP103', 'Rajesh Gupta', '2026-09-12 05:30:00', '1', 'DEV_DEP', 'SN_DEP', 'Fingerprint', 'coaching', '2026-09-10 09:36:04'),
(25, 'PRT201', 'Suresh Patel', '2026-09-11 06:15:00', '0', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:04'),
(26, 'PRT201', 'Suresh Patel', '2026-09-11 13:45:00', '1', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:04'),
(27, 'PRT202', 'Manoj Yadav', '2026-09-11 14:15:00', '0', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:04'),
(28, 'PRT202', 'Manoj Yadav', '2026-09-11 21:45:00', '1', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:04'),
(29, 'PRT203', 'Anil Kumar', '2026-09-11 22:15:00', '0', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:05'),
(30, 'PRT203', 'Anil Kumar', '2026-09-12 05:30:00', '1', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:05'),
(31, 'VB301', 'Amit Sharma', '2026-09-11 06:30:00', '0', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:05'),
(32, 'VB301', 'Amit Sharma', '2026-09-11 07:30:00', '1', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:05'),
(33, 'VB302', 'Priya Verma', '2026-09-11 14:30:00', '0', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:05'),
(34, 'VB302', 'Priya Verma', '2026-09-11 15:25:00', '1', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:05'),
(35, 'VB303', 'Sunil Sharma', '2026-09-11 22:30:00', '0', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:05'),
(36, 'VB303', 'Sunil Sharma', '2026-09-11 23:40:00', '1', 'DEV_PRT', 'SN_PRT', 'Fingerprint', 'prt', '2026-09-10 09:36:05');

-- --------------------------------------------------------

--
-- Table structure for table `biometric_manpower_target`
--

CREATE TABLE `biometric_manpower_target` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL DEFAULT 1,
  `category_id` int(11) NOT NULL DEFAULT 0,
  `category_name` varchar(100) DEFAULT NULL,
  `designation_id` int(11) NOT NULL DEFAULT 0,
  `designation_name` varchar(100) NOT NULL,
  `target_date` date NOT NULL,
  `target_qty` decimal(10,2) NOT NULL DEFAULT 0.00,
  `effective_from` date DEFAULT NULL,
  `effective_to` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `biometric_manpower_target`
--

INSERT INTO `biometric_manpower_target` (`id`, `station_id`, `category_id`, `category_name`, `designation_id`, `designation_name`, `target_date`, `target_qty`, `effective_from`, `effective_to`, `created_at`, `updated_at`) VALUES
(1, 1, 17, 'Normal cleaning', 1, 'Unskilled', '2026-09-01', 0.58, '2026-09-01', '2026-09-30', '2026-09-10 10:10:53', '2026-09-10 10:15:32'),
(2, 1, 17, 'Normal cleaning', 2, 'Supervisor', '2026-09-01', 0.46, '2026-09-01', '2026-09-30', '2026-09-10 10:10:54', '2026-09-10 10:15:32'),
(3, 1, 19, 'Depot Cleaning', 1, 'Unskilled', '2026-09-01', 21.00, '2026-09-01', '2026-09-30', '2026-09-10 10:10:54', '2026-09-10 10:15:32'),
(4, 1, 19, 'Depot Cleaning', 2, 'Supervisor', '2026-09-01', 1.00, '2026-09-01', '2026-09-30', '2026-09-10 10:10:54', '2026-09-10 10:10:54'),
(5, 1, 20, 'Prt cleaning', 1, 'Unskilled', '2026-09-01', 0.20, '2026-09-01', '2026-09-30', '2026-09-10 10:10:54', '2026-09-10 10:15:32'),
(6, 1, 21, 'Vande Bharat', 1, 'Unskilled', '2026-09-01', 3.00, '2026-09-01', '2026-09-30', '2026-09-10 10:10:54', '2026-09-10 10:10:54'),
(9, 1, 18, 'Intensive Cleaning', 1, 'Unskilled', '2026-09-01', 0.58, '2026-09-01', '2026-09-30', '2026-09-10 10:15:32', '2026-09-10 10:15:32'),
(13, 1, 20, 'Prt cleaning', 2, 'Supervisor', '2026-09-01', 3.00, '2026-09-01', '2026-09-30', '2026-09-10 10:15:32', '2026-09-10 10:15:32'),
(15, 1, 21, 'Vande Bharat', 2, 'Supervisor', '2026-09-01', 1.00, '2026-09-01', '2026-09-30', '2026-09-10 10:15:33', '2026-09-10 10:15:33');

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
(6, 'Odonil', 'units', 1, '2026-06-06 11:13:48', '2026-08-31 12:03:41'),
(21, 'Spiral R7 floor cleaner', 'ml', 4, '2026-09-11 10:43:16', '2026-09-11 10:43:16'),
(22, 'Taski R6 ceramic toilet cleaner', 'ml', 4, '2026-09-11 10:43:17', '2026-09-11 10:43:17'),
(23, 'Disinfectant', 'ml', 4, '2026-09-11 10:43:17', '2026-09-11 10:43:17'),
(24, 'Bleaching powder', 'kg', 4, '2026-09-11 10:43:17', '2026-09-11 10:43:17'),
(25, 'Naphthalene balls', 'kg', 4, '2026-09-11 10:43:17', '2026-09-11 10:43:17'),
(26, 'Odonil', 'units', 4, '2026-09-11 10:43:17', '2026-09-11 10:43:17');

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
(18, 6, 3, 50.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:53', '2026-09-07 14:40:53'),
(25, 21, 7, 50.00, 'SCL AUDITOR', 4, 'TKN-DC-CHEM-20260912-889', '2026-09-12', '2026-09-12 08:18:44', '2026-09-12 08:18:44'),
(26, 22, 7, 40.00, 'SCL AUDITOR', 4, 'TKN-DC-CHEM-20260912-889', '2026-09-12', '2026-09-12 08:18:44', '2026-09-12 08:18:44'),
(27, 23, 7, 30.00, 'SCL AUDITOR', 4, 'TKN-DC-CHEM-20260912-889', '2026-09-12', '2026-09-12 08:18:44', '2026-09-12 08:18:44'),
(28, 24, 7, 40.00, 'SCL AUDITOR', 4, 'TKN-DC-CHEM-20260912-889', '2026-09-12', '2026-09-12 08:18:44', '2026-09-12 08:18:44'),
(29, 25, 7, 40.00, 'SCL AUDITOR', 4, 'TKN-DC-CHEM-20260912-889', '2026-09-12', '2026-09-12 08:18:44', '2026-09-12 08:18:44'),
(30, 26, 7, 50.00, 'SCL AUDITOR', 4, 'TKN-DC-CHEM-20260912-889', '2026-09-12', '2026-09-12 08:18:44', '2026-09-12 08:18:44');

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
(3, 'Shift 3', 1, '2026-06-06 11:13:48', '2026-06-06 11:13:48'),
(7, 'Shift 1', 4, '2026-09-11 10:43:18', '2026-09-11 10:43:18'),
(8, 'Shift 2', 4, '2026-09-11 10:43:18', '2026-09-11 10:43:18'),
(9, 'Shift 3', 4, '2026-09-11 10:43:18', '2026-09-11 10:43:18');

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
(6, 6, '2026-09-01', 50.00, 500.00, 10.00, 1, '2026-09-07 14:35:18', '2026-09-07 14:35:18'),
(7, 21, '2026-09-01', 50.00, 500.00, 10.00, 4, '2026-09-11 10:43:18', '2026-09-11 10:43:18'),
(8, 22, '2026-09-01', 40.00, 500.00, 10.00, 4, '2026-09-11 10:43:18', '2026-09-11 10:43:18'),
(9, 23, '2026-09-01', 30.00, 500.00, 10.00, 4, '2026-09-11 10:43:19', '2026-09-11 10:43:19'),
(10, 24, '2026-09-01', 40.00, 500.00, 10.00, 4, '2026-09-11 10:43:19', '2026-09-11 10:43:19'),
(11, 25, '2026-09-01', 40.00, 500.00, 10.00, 4, '2026-09-11 10:43:19', '2026-09-11 10:43:19'),
(12, 26, '2026-09-01', 50.00, 500.00, 10.00, 4, '2026-09-11 10:43:19', '2026-09-11 10:43:19');

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
(2, 'GCM', 'Grass cutting machine (Honda Brush Cutter and Accessories (UMK435T U2NT 11900 W))', 1, '2026-06-08 12:11:51', '2026-06-08 12:11:51'),
(4, 'NBMD', 'Nylon brush multi disc heavy duty floor scrubber (Karcher BD 50/50 C Bp Classic)', 4, '2026-09-11 10:43:20', '2026-09-11 10:43:20'),
(5, 'GCM', 'Grass cutting machine (Honda Brush Cutter and Accessories (UMK435T U2NT 11900 W))', 4, '2026-09-11 10:43:20', '2026-09-11 10:43:20');

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
(6, 2, 3, 'Y', 'TKN-DC-MCH-20260907-3-7067', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:41:53', '2026-09-07 14:41:53'),
(7, 4, 4, 'Y', 'TKN-DC-MCH-20260912-4-8618', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:19:03', '2026-09-12 08:19:03'),
(8, 5, 4, 'Y', 'TKN-DC-MCH-20260912-4-8618', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:19:03', '2026-09-12 08:19:03');

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
(3, 'Shift 3', 1, '2026-06-08 12:11:51', '2026-06-08 12:11:51'),
(4, 'Shift 1', 4, '2026-09-11 10:43:20', '2026-09-11 10:43:20'),
(5, 'Shift 2', 4, '2026-09-11 10:43:20', '2026-09-11 10:43:20'),
(6, 'Shift 3', 4, '2026-09-11 10:43:21', '2026-09-11 10:43:21');

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
(6, 1, 2, 3, 'Y', 500.00, '2026-09-07 14:38:50', '2026-09-07 14:38:50', '2026-09-01', NULL),
(7, 4, 4, 4, 'Y', 500.00, '2026-09-11 10:43:21', '2026-09-11 10:43:21', '2026-09-01', NULL),
(8, 4, 4, 5, 'Y', 500.00, '2026-09-11 10:43:21', '2026-09-11 10:43:21', '2026-09-01', NULL),
(9, 4, 4, 6, 'Y', 500.00, '2026-09-11 10:43:22', '2026-09-11 10:43:22', '2026-09-01', NULL),
(10, 4, 5, 4, 'Y', 500.00, '2026-09-11 10:43:22', '2026-09-11 10:43:22', '2026-09-01', NULL),
(11, 4, 5, 5, 'Y', 500.00, '2026-09-11 10:43:22', '2026-09-11 10:43:22', '2026-09-01', NULL),
(12, 4, 5, 6, 'Y', 500.00, '2026-09-11 10:43:22', '2026-09-11 10:43:22', '2026-09-01', NULL);

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
(19, 'Disposal of garbage at nominated Places', 1, '2026-08-29 06:32:16', '2026-08-29 06:32:16'),
(20, 'Cleaning of office premises', 4, '2026-09-11 10:43:14', '2026-09-11 10:43:14'),
(21, 'Cleaning of IOH Sheds/Sick lines', 4, '2026-09-11 10:43:14', '2026-09-11 10:43:14'),
(22, 'Cleaning of Catwalks and Aprons', 4, '2026-09-11 10:43:15', '2026-09-11 10:43:15'),
(23, 'Cleaning & De-silting of Pits', 4, '2026-09-11 10:43:15', '2026-09-11 10:43:15'),
(24, 'Cleaning of Toilets, Bathrooms.', 4, '2026-09-11 10:43:15', '2026-09-11 10:43:15'),
(25, 'Cleaning of Drains inside the depots', 4, '2026-09-11 10:43:15', '2026-09-11 10:43:15'),
(26, 'Cleaning of Pathways', 4, '2026-09-11 10:43:15', '2026-09-11 10:43:15'),
(27, 'Disposal of Scraps to nominated Places', 4, '2026-09-11 10:43:15', '2026-09-11 10:43:15'),
(28, 'Disposal of garbage at nominated Places', 4, '2026-09-11 10:43:15', '2026-09-11 10:43:15');

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
(36, 19, 2, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:51', '2026-09-08 13:16:51', 'Bheem Chand'),
(37, 11, 1, 2, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:10', '2026-09-09 07:36:10', 'Shivkumar'),
(38, 12, 1, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:10', '2026-09-09 07:36:10', 'Shivkumar'),
(39, 13, 1, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:10', '2026-09-09 07:36:10', 'Shivkumar'),
(40, 14, 1, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:10', '2026-09-09 07:36:10', 'Shivkumar'),
(41, 15, 1, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:10', '2026-09-09 07:36:10', 'Shivkumar'),
(42, 16, 1, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:10', '2026-09-09 07:36:10', 'Shivkumar'),
(43, 17, 1, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:10', '2026-09-09 07:36:10', 'Shivkumar'),
(44, 18, 1, 2, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:10', '2026-09-09 07:36:10', 'Shivkumar'),
(45, 19, 1, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:10', '2026-09-09 07:36:10', 'Shivkumar'),
(46, 11, 2, 2, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:26', '2026-09-09 07:36:26', 'Shivkumar'),
(47, 12, 2, 2, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:26', '2026-09-09 07:36:26', 'Shivkumar'),
(48, 13, 2, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:26', '2026-09-09 07:36:26', 'Shivkumar'),
(49, 14, 2, 2, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:26', '2026-09-09 07:36:26', 'Shivkumar'),
(50, 15, 2, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:26', '2026-09-09 07:36:26', 'Shivkumar'),
(51, 16, 2, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:26', '2026-09-09 07:36:26', 'Shivkumar'),
(52, 17, 2, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:26', '2026-09-09 07:36:26', 'Shivkumar'),
(53, 18, 2, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:26', '2026-09-09 07:36:26', 'Shivkumar'),
(54, 19, 2, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:26', '2026-09-09 07:36:26', 'Shivkumar'),
(73, 20, 4, 3, 'TKN-DC-20260912-548', 4, '2026-09-12', '2026-09-12 08:18:12', '2026-09-12 08:18:12', 'SCL AUDITOR'),
(74, 21, 4, 3, 'TKN-DC-20260912-548', 4, '2026-09-12', '2026-09-12 08:18:12', '2026-09-12 08:18:12', 'SCL AUDITOR'),
(75, 22, 4, 3, 'TKN-DC-20260912-548', 4, '2026-09-12', '2026-09-12 08:18:12', '2026-09-12 08:18:12', 'SCL AUDITOR'),
(76, 23, 4, 3, 'TKN-DC-20260912-548', 4, '2026-09-12', '2026-09-12 08:18:12', '2026-09-12 08:18:12', 'SCL AUDITOR'),
(77, 24, 4, 3, 'TKN-DC-20260912-548', 4, '2026-09-12', '2026-09-12 08:18:12', '2026-09-12 08:18:12', 'SCL AUDITOR'),
(78, 25, 4, 3, 'TKN-DC-20260912-548', 4, '2026-09-12', '2026-09-12 08:18:12', '2026-09-12 08:18:12', 'SCL AUDITOR'),
(79, 26, 4, 3, 'TKN-DC-20260912-548', 4, '2026-09-12', '2026-09-12 08:18:12', '2026-09-12 08:18:12', 'SCL AUDITOR'),
(80, 27, 4, 3, 'TKN-DC-20260912-548', 4, '2026-09-12', '2026-09-12 08:18:12', '2026-09-12 08:18:12', 'SCL AUDITOR'),
(81, 28, 4, 3, 'TKN-DC-20260912-548', 4, '2026-09-12', '2026-09-12 08:18:12', '2026-09-12 08:18:12', 'SCL AUDITOR');

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
(2, 'Score on 2nd\nCheck (16:00 hrs)', 1, '2026-05-30 08:53:53', '2026-08-29 06:29:01'),
(4, 'Score on First Check (11:00 hrs)', 4, '2026-09-11 10:43:16', '2026-09-11 10:43:16'),
(5, 'Score on 2nd\nCheck (16:00 hrs)', 4, '2026-09-11 10:43:16', '2026-09-11 10:43:16');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_audit`
--

CREATE TABLE `inventory_audit` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `material_id` int(11) NOT NULL,
  `action` varchar(50) NOT NULL,
  `actor` varchar(255) NOT NULL,
  `entry_date` date DEFAULT NULL,
  `used_qty` bigint(20) NOT NULL DEFAULT 0,
  `received_qty` bigint(20) NOT NULL DEFAULT 0,
  `opening_qty` bigint(20) NOT NULL DEFAULT 0,
  `closing_qty` bigint(20) NOT NULL DEFAULT 0,
  `supervisor` varchar(255) DEFAULT NULL,
  `je_sse` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `details` text DEFAULT NULL,
  `created_at` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventory_audit`
--

INSERT INTO `inventory_audit` (`id`, `station_id`, `material_id`, `action`, `actor`, `entry_date`, `used_qty`, `received_qty`, `opening_qty`, `closing_qty`, `supervisor`, `je_sse`, `notes`, `details`, `created_at`) VALUES
(1, 1, 2, 'entry.created', 'kings (#2)', '2026-09-01', 200000, 400000, 0, 200000, 'akhil', '', 'na', 'entry.created', '2026-09-09 18:17:21'),
(2, 1, 1, 'entry.created', 'kings (#2)', '2026-09-07', 40000, 0, 200000, 160000, 'akkkkk', '', '', 'entry.created', '2026-09-09 18:24:24');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_entries`
--

CREATE TABLE `inventory_entries` (
  `id` int(11) NOT NULL,
  `material_id` int(11) NOT NULL,
  `entry_date` date NOT NULL,
  `used_qty` bigint(20) NOT NULL DEFAULT 0,
  `received_qty` bigint(20) NOT NULL DEFAULT 0,
  `supervisor` varchar(255) NOT NULL,
  `je_sse` varchar(255) NOT NULL DEFAULT '',
  `notes` text DEFAULT NULL,
  `created_by` varchar(255) NOT NULL,
  `updated_by` varchar(255) NOT NULL,
  `created_at` varchar(50) NOT NULL,
  `updated_at` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventory_entries`
--

INSERT INTO `inventory_entries` (`id`, `material_id`, `entry_date`, `used_qty`, `received_qty`, `supervisor`, `je_sse`, `notes`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, '2026-09-08', 50000, 50000, 'akhil', '', '', 'kings (#2)', 'kings (#2)', '2026-09-09T12:37:19+00:00', '2026-09-09T12:37:19+00:00'),
(2, 2, '2026-09-01', 200000, 400000, 'akhil', '', 'na', 'kings (#2)', 'kings (#2)', '2026-09-09T12:47:20+00:00', '2026-09-09T12:47:20+00:00'),
(3, 1, '2026-09-07', 40000, 0, 'akkkkk', '', '', 'kings (#2)', 'kings (#2)', '2026-09-09T12:54:23+00:00', '2026-09-09T12:54:23+00:00');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_materials`
--

CREATE TABLE `inventory_materials` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL,
  `catalog_number` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `category` enum('Chemical','Equipment','Consumable') NOT NULL,
  `unit` enum('L','mL','kg','g','pcs','rolls','sets') NOT NULL,
  `opening_qty` bigint(20) NOT NULL DEFAULT 0,
  `opening_date` date DEFAULT NULL,
  `minimum_qty` bigint(20) NOT NULL DEFAULT 0,
  `version` int(11) NOT NULL DEFAULT 1,
  `created_at` varchar(50) NOT NULL,
  `updated_at` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventory_materials`
--

INSERT INTO `inventory_materials` (`id`, `station_id`, `catalog_number`, `name`, `category`, `unit`, `opening_qty`, `opening_date`, `minimum_qty`, `version`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Heavy Duty Exterior Washing Liquid', 'Chemical', 'L', 200000, '2026-09-01', 150000, 4, '2026-09-09 17:49:57', '2026-09-09T12:54:23+00:00'),
(2, 1, 2, 'Ceramic & Stainless Steel Toilet Fittings Cleaning Agent', 'Chemical', 'L', 0, '2026-09-01', 0, 2, '2026-09-09 17:49:57', '2026-09-09T12:47:20+00:00'),
(3, 1, 3, 'Glass Cleaning Agent', 'Chemical', 'L', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(4, 1, 4, 'PVC Floor Cleaning Agent', 'Chemical', 'L', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(5, 1, 5, 'Air Freshener', 'Chemical', 'L', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(6, 1, 6, 'Liquid Hand Soap (Hand Wash)', 'Chemical', 'L', 400000, '2026-09-09', 350000, 2, '2026-09-09 17:49:57', '2026-09-09T12:28:34+00:00'),
(7, 1, 7, 'Cleaning Agent for Removing Old Sticker, Glue Marks etc.', 'Chemical', 'L', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(8, 1, 8, 'Stainless Steel Polish', 'Chemical', 'L', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(9, 1, 9, 'Banister Brush', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(10, 1, 10, 'Bucket (15 L + 5 L)', 'Equipment', 'sets', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(11, 1, 11, 'Foot Broom Head with Bristles', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(12, 1, 12, 'Polypropylene Bristle Brush', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(13, 1, 13, 'Suitable Broom', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(14, 1, 14, 'Disposable Bag (29 × 39)', 'Consumable', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(15, 1, 15, 'Floor Mopper', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(16, 1, 16, 'Mopper Cloth', 'Consumable', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(17, 1, 17, 'Microfiber Cloth', 'Consumable', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(18, 1, 18, 'Fiber Hand Held Brush (Round Type)', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(19, 1, 19, 'Floor Squeezer', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(20, 1, 20, 'Window Squeezer', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(21, 1, 21, 'Bottle with Spray Gun', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(22, 1, 22, 'Super Absorbent Floor Mopper', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(23, 1, 23, 'Squeeze Brush', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(24, 1, 24, 'Toilet Commode Brush', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(25, 1, 25, 'Carpet Brush', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(26, 1, 26, 'Upholstery Cleaning Brush', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(27, 1, 27, 'Sponge Duster (Yellow)', 'Consumable', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(28, 1, 28, 'Disposable Bag for Dustbin (19 × 21)', 'Consumable', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(29, 1, 29, 'Disinfectants', 'Chemical', 'L', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(30, 1, 30, 'Mosquito Repellent Spray', 'Chemical', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(31, 1, 31, 'Tissue Paper for Western AC Coach Toilet', 'Consumable', 'rolls', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(32, 1, 32, 'Deodorant Stick/Cake for Each Toilet in AC Coaches', 'Consumable', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(33, 1, 33, 'Painted Surface Cleaning Agent', 'Chemical', 'L', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(34, 1, 34, 'Laminated Plastic Sheet & Berth Rexine Cleaner', 'Chemical', 'L', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(35, 1, 35, 'Window Glass Squeezer', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_seeded_stations`
--

CREATE TABLE `inventory_seeded_stations` (
  `station_id` int(11) NOT NULL,
  `seeded_at` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventory_seeded_stations`
--

INSERT INTO `inventory_seeded_stations` (`station_id`, `seeded_at`) VALUES
(1, '2026-09-09 17:49:57');

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
-- Table structure for table `mcc_designation`
--

CREATE TABLE `mcc_designation` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL DEFAULT 1,
  `designation_name` varchar(100) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_designation`
--

INSERT INTO `mcc_designation` (`id`, `station_id`, `designation_name`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Unskilled', 'Active', '2026-09-10 09:36:00', '2026-09-10 09:36:00'),
(2, 1, 'Supervisor', 'Active', '2026-09-10 09:36:00', '2026-09-10 09:36:00');

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
(102, 'Mysore', 14, 'Active', '2026-08-31 05:58:44', '2026-08-31 05:58:44'),
(103, 'Lumding', 8, 'Active', '2026-09-11 06:36:50', '2026-09-11 06:36:50');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_employee`
--

CREATE TABLE `mcc_employee` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL DEFAULT 1,
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

--
-- Dumping data for table `mcc_employee`
--

INSERT INTO `mcc_employee` (`id`, `station_id`, `employee_id`, `full_name`, `designation`, `age`, `employee_photo`, `father_name`, `mother_name`, `mobile_number`, `dob`, `aadhar_number`, `address`, `ren_id`, `rakshak_id`, `pan_card`, `police_ver`, `police_ver_dt`, `pvc`, `pvc_ok_applied`, `pvc_issue_month`, `medical`, `medical_issue_month`, `education`, `document_status`, `account_name`, `account_number`, `ifsc_code`, `status`, `issue_date`, `valid_upto_date`, `valid_upto_month`, `formula_valid_upto`, `notification`, `document_link`, `remarks`, `created_at`, `updated_at`, `blood_group`, `department`) VALUES
(1, 1, 'DEP101', 'Ramesh Kumar', 'Unskilled', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-10 09:36:06', '2026-09-10 09:36:06', NULL, NULL),
(2, 1, 'DEP102', 'Vijay Singh', 'Supervisor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-10 09:36:06', '2026-09-10 09:36:06', NULL, NULL),
(3, 1, 'DEP103', 'Rajesh Gupta', 'Unskilled', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-10 09:36:06', '2026-09-10 09:36:06', NULL, NULL),
(4, 1, 'PRT201', 'Suresh Patel', 'Unskilled', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-10 09:36:06', '2026-09-10 09:36:06', NULL, NULL),
(5, 1, 'PRT202', 'Manoj Yadav', 'Supervisor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-10 09:36:06', '2026-09-10 09:36:06', NULL, NULL),
(6, 1, 'PRT203', 'Anil Kumar', 'Unskilled', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-10 09:36:06', '2026-09-10 09:36:06', NULL, NULL),
(7, 4, 'VB301', 'Amit Sharma', 'Unskilled', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-10 09:36:06', '2026-09-11 13:12:36', NULL, NULL),
(8, 1, 'VB302', 'Priya Verma', 'Supervisor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-10 09:36:07', '2026-09-10 09:36:07', NULL, NULL),
(9, 1, 'VB303', 'Sunil Sharma', 'Unskilled', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-09-10 09:36:07', '2026-09-10 09:36:07', NULL, NULL);

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
(8, 'Water-based air freshener', 'ml/coach', 1, '2026-05-25 12:18:12', '2026-08-31 11:57:13'),
(9, 'PVC Floor Cleaning Agent', 'ml/coach', 4, '2026-09-11 10:37:58', '2026-09-11 10:37:58'),
(10, 'Ceramic and stainless-steel toilet fittings cleaner', 'ml/coach', 4, '2026-09-11 10:37:58', '2026-09-11 10:37:58'),
(11, 'Glass cleaner', 'ml/coach', 4, '2026-09-11 10:37:59', '2026-09-11 10:37:59'),
(12, 'Laminated plastic sheet and berth rexine cleaner', 'ml/coach', 4, '2026-09-11 10:37:59', '2026-09-11 10:37:59'),
(13, 'Painted-surface cleaner', 'ml/coach', 4, '2026-09-11 10:37:59', '2026-09-11 10:37:59'),
(14, 'Stainless-steel polisher', 'ml/coach', 4, '2026-09-11 10:37:59', '2026-09-11 10:37:59'),
(15, 'Disinfectant', 'ml/coach', 4, '2026-09-11 10:37:59', '2026-09-11 10:37:59'),
(16, 'Water-based air freshener', 'ml/coach', 4, '2026-09-11 10:37:59', '2026-09-11 10:37:59');

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
(56, 8, '1', NULL, 'Smc', 1, 'TKN-20260908-286', '16236', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:04'),
(57, 1, '01', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:35'),
(58, 2, '01', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:35'),
(59, 3, '01', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:35'),
(60, 4, '01', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:35'),
(61, 5, '01', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:35'),
(62, 6, '01', 25.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:35'),
(63, 7, '01', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:35'),
(64, 8, '01', 100.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:35'),
(65, 1, '02', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:41'),
(66, 2, '02', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:41'),
(67, 3, '02', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:41'),
(68, 4, '02', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:41'),
(69, 5, '02', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:41'),
(70, 6, '02', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:41'),
(71, 7, '02', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:41'),
(72, 8, '02', 100.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:41'),
(73, 1, '01', 28.00, 'Sandesh', 1, 'TKN-20260909-635', '22687', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:34:20'),
(74, 2, '01', 10.00, 'Sandesh', 1, 'TKN-20260909-635', '22687', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:34:20'),
(75, 3, '01', 10.00, 'Sandesh', 1, 'TKN-20260909-635', '22687', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:34:20'),
(76, 4, '01', 10.00, 'Sandesh', 1, 'TKN-20260909-635', '22687', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:34:20'),
(77, 5, '01', 10.00, 'Sandesh', 1, 'TKN-20260909-635', '22687', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:34:20'),
(78, 6, '01', 10.00, 'Sandesh', 1, 'TKN-20260909-635', '22687', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:34:20'),
(79, 7, '01', 10.00, 'Sandesh', 1, 'TKN-20260909-635', '22687', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:34:20'),
(80, 8, '01', 100.00, 'Sandesh', 1, 'TKN-20260909-635', '22687', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:34:20'),
(81, 1, '01', 10.00, 'Rafik', 1, 'TKN-20260909-989', '16227', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:34:03'),
(82, 2, '01', 10.00, 'Rafik', 1, 'TKN-20260909-989', '16227', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:34:03'),
(83, 3, '01', 10.00, 'Rafik', 1, 'TKN-20260909-989', '16227', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:34:03'),
(84, 4, '01', 10.00, 'Rafik', 1, 'TKN-20260909-989', '16227', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:34:03'),
(85, 5, '01', 10.00, 'Rafik', 1, 'TKN-20260909-989', '16227', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:34:03'),
(86, 6, '01', 10.00, 'Rafik', 1, 'TKN-20260909-989', '16227', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:34:03'),
(87, 7, '01', 10.00, 'Rafik', 1, 'TKN-20260909-989', '16227', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:34:03'),
(88, 8, '01', 100.00, 'Rafik', 1, 'TKN-20260909-989', '16227', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:34:03'),
(89, 1, '01', 10.00, 'Shivkumar', 1, 'TKN-20260909-880', '22781', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:34:09'),
(90, 2, '01', 10.00, 'Shivkumar', 1, 'TKN-20260909-880', '22781', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:34:09'),
(91, 3, '01', 10.00, 'Shivkumar', 1, 'TKN-20260909-880', '22781', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:34:09'),
(92, 4, '01', 10.00, 'Shivkumar', 1, 'TKN-20260909-880', '22781', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:34:09'),
(93, 5, '01', 10.00, 'Shivkumar', 1, 'TKN-20260909-880', '22781', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:34:09'),
(94, 6, '01', 10.00, 'Shivkumar', 1, 'TKN-20260909-880', '22781', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:34:09'),
(95, 7, '01', 10.00, 'Shivkumar', 1, 'TKN-20260909-880', '22781', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:34:09'),
(96, 8, '01', 100.00, 'Shivkumar', 1, 'TKN-20260909-880', '22781', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:34:09'),
(105, 9, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-20260912-424', '123456', '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:03:37'),
(106, 10, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-20260912-424', '123456', '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:03:37'),
(107, 11, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-20260912-424', '123456', '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:03:37'),
(108, 12, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-20260912-424', '123456', '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:03:37'),
(109, 13, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-20260912-424', '123456', '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:03:37'),
(110, 14, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-20260912-424', '123456', '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:03:37'),
(111, 15, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-20260912-424', '123456', '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:03:37'),
(112, 16, 'C1', 100.00, 'SCL AUDITOR', 4, 'TKN-20260912-424', '123456', '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:03:37');

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
(8, 8, 100.00, 50.00, 10.00, 1, '2026-09-07 14:08:23', '2026-09-07 14:08:23', '2026-09-07', NULL),
(9, 9, 10.00, 500.00, 10.00, 4, '2026-09-11 10:38:00', '2026-09-11 10:38:00', '2026-09-07', NULL),
(10, 10, 10.00, 500.00, 10.00, 4, '2026-09-11 10:38:00', '2026-09-11 10:38:00', '2026-09-07', NULL),
(11, 11, 10.00, 500.00, 10.00, 4, '2026-09-11 10:38:00', '2026-09-11 10:38:00', '2026-09-07', NULL),
(12, 12, 10.00, 500.00, 10.00, 4, '2026-09-11 10:38:01', '2026-09-11 10:38:01', '2026-09-07', NULL),
(13, 13, 10.00, 500.00, 10.00, 4, '2026-09-11 10:38:01', '2026-09-11 10:38:01', '2026-09-07', NULL),
(14, 14, 10.00, 500.00, 10.00, 4, '2026-09-11 10:38:01', '2026-09-11 10:38:01', '2026-09-07', NULL),
(15, 15, 10.00, 50.00, 10.00, 4, '2026-09-11 10:38:01', '2026-09-11 10:38:01', '2026-09-07', NULL),
(16, 16, 100.00, 50.00, 10.00, 4, '2026-09-11 10:38:01', '2026-09-11 10:38:01', '2026-09-07', NULL);

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
(30, 'HHSD 6', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(31, 'PPSD 1', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:38:04', '2026-09-11 10:38:04'),
(32, 'PPSD 2', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:38:04', '2026-09-11 10:38:04'),
(33, 'PPSD 3', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:38:04', '2026-09-11 10:38:04'),
(34, 'PPSD 4', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:38:04', '2026-09-11 10:38:04'),
(35, 'PPSD 5', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:38:05', '2026-09-11 10:38:05'),
(36, 'PPSD 6', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:38:05', '2026-09-11 10:38:05'),
(37, 'PPSD 7', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:38:05', '2026-09-11 10:38:05'),
(38, 'PPSD 8', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:38:05', '2026-09-11 10:38:05'),
(39, 'PPSD 9', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:38:05', '2026-09-11 10:38:05'),
(40, 'HHSD 1', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:38:05', '2026-09-11 10:38:05'),
(41, 'HHSD 2', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:38:05', '2026-09-11 10:38:05'),
(42, 'HHSD 3', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:38:06', '2026-09-11 10:38:06'),
(43, 'HHSD 4', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:38:06', '2026-09-11 10:38:06'),
(44, 'HHSD 5', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:38:06', '2026-09-11 10:38:06'),
(45, 'HHSD 6', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:38:06', '2026-09-11 10:38:06');

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
(60, 30, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01'),
(61, 16, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01'),
(62, 17, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01'),
(63, 18, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01'),
(64, 19, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01'),
(65, 20, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01'),
(66, 21, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01'),
(67, 22, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01'),
(68, 23, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01'),
(69, 24, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01'),
(70, 25, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01'),
(71, 26, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01'),
(72, 27, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01'),
(73, 28, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01'),
(74, 29, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01'),
(75, 30, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01'),
(76, 16, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10'),
(77, 17, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10'),
(78, 18, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10'),
(79, 19, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10'),
(80, 20, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10'),
(81, 21, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10'),
(82, 22, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10'),
(83, 23, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10'),
(84, 24, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10'),
(85, 25, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10'),
(86, 26, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10'),
(87, 27, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10'),
(88, 28, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10'),
(89, 29, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10'),
(90, 30, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10'),
(91, 16, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19'),
(92, 17, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19'),
(93, 18, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19'),
(94, 19, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19'),
(95, 20, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19'),
(96, 21, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19'),
(97, 22, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19'),
(98, 23, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19'),
(99, 24, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19'),
(100, 25, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19'),
(101, 26, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19'),
(102, 27, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19'),
(103, 28, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19'),
(104, 29, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19'),
(105, 30, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19');

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
(6, 'Shift 3', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(7, 'Shift 1', 4, '2026-09-11 10:38:07', '2026-09-11 10:38:07'),
(8, 'Shift 2', 4, '2026-09-11 10:38:07', '2026-09-11 10:38:07'),
(9, 'Shift 3', 4, '2026-09-11 10:38:07', '2026-09-11 10:38:07');

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
(45, 1, 30, 6, 'Y', 500.00, '2026-09-08 06:12:48', '2026-09-08 06:12:48', '2026-09-01', NULL),
(46, 4, 31, 7, 'Y', 500.00, '2026-09-11 10:38:08', '2026-09-11 10:38:08', '2026-09-01', NULL),
(47, 4, 31, 8, 'Y', 500.00, '2026-09-11 10:38:08', '2026-09-11 10:38:08', '2026-09-01', NULL),
(48, 4, 31, 9, 'Y', 500.00, '2026-09-11 10:38:08', '2026-09-11 10:38:08', '2026-09-01', NULL),
(49, 4, 32, 7, 'Y', 500.00, '2026-09-11 10:38:08', '2026-09-11 10:38:08', '2026-09-01', NULL),
(50, 4, 32, 8, 'Y', 500.00, '2026-09-11 10:38:08', '2026-09-11 10:38:08', '2026-09-01', NULL),
(51, 4, 32, 9, 'Y', 500.00, '2026-09-11 10:38:08', '2026-09-11 10:38:08', '2026-09-01', NULL),
(52, 4, 33, 7, 'Y', 500.00, '2026-09-11 10:38:08', '2026-09-11 10:38:08', '2026-09-01', NULL),
(53, 4, 33, 8, 'Y', 500.00, '2026-09-11 10:38:09', '2026-09-11 10:38:09', '2026-09-01', NULL),
(54, 4, 33, 9, 'Y', 500.00, '2026-09-11 10:38:09', '2026-09-11 10:38:09', '2026-09-01', NULL),
(55, 4, 34, 7, 'Y', 500.00, '2026-09-11 10:38:09', '2026-09-11 10:38:09', '2026-09-01', NULL),
(56, 4, 34, 8, 'Y', 500.00, '2026-09-11 10:38:09', '2026-09-11 10:38:09', '2026-09-01', NULL),
(57, 4, 34, 9, 'Y', 500.00, '2026-09-11 10:38:09', '2026-09-11 10:38:09', '2026-09-01', NULL),
(58, 4, 35, 7, 'Y', 500.00, '2026-09-11 10:38:09', '2026-09-11 10:38:09', '2026-09-01', NULL),
(59, 4, 35, 8, 'Y', 500.00, '2026-09-11 10:38:09', '2026-09-11 10:38:09', '2026-09-01', NULL),
(60, 4, 35, 9, 'Y', 500.00, '2026-09-11 10:38:09', '2026-09-11 10:38:09', '2026-09-01', NULL),
(61, 4, 36, 7, 'Y', 500.00, '2026-09-11 10:38:09', '2026-09-11 10:38:09', '2026-09-01', NULL),
(62, 4, 36, 8, 'Y', 500.00, '2026-09-11 10:38:10', '2026-09-11 10:38:10', '2026-09-01', NULL),
(63, 4, 36, 9, 'Y', 500.00, '2026-09-11 10:38:10', '2026-09-11 10:38:10', '2026-09-01', NULL),
(64, 4, 37, 7, 'Y', 500.00, '2026-09-11 10:38:10', '2026-09-11 10:38:10', '2026-09-01', NULL),
(65, 4, 37, 8, 'Y', 500.00, '2026-09-11 10:38:10', '2026-09-11 10:38:10', '2026-09-01', NULL),
(66, 4, 37, 9, 'Y', 500.00, '2026-09-11 10:38:10', '2026-09-11 10:38:10', '2026-09-01', NULL),
(67, 4, 38, 7, 'Y', 500.00, '2026-09-11 10:38:11', '2026-09-11 10:38:11', '2026-09-01', NULL),
(68, 4, 38, 8, 'Y', 500.00, '2026-09-11 10:38:11', '2026-09-11 10:38:11', '2026-09-01', NULL),
(69, 4, 38, 9, 'Y', 500.00, '2026-09-11 10:38:11', '2026-09-11 10:38:11', '2026-09-01', NULL),
(70, 4, 39, 7, 'Y', 500.00, '2026-09-11 10:38:11', '2026-09-11 10:38:11', '2026-09-01', NULL),
(71, 4, 39, 8, 'Y', 500.00, '2026-09-11 10:38:11', '2026-09-11 10:38:11', '2026-09-01', NULL),
(72, 4, 39, 9, 'Y', 500.00, '2026-09-11 10:38:11', '2026-09-11 10:38:11', '2026-09-01', NULL),
(73, 4, 40, 7, 'Y', 500.00, '2026-09-11 10:38:11', '2026-09-11 10:38:11', '2026-09-01', NULL),
(74, 4, 40, 8, 'Y', 500.00, '2026-09-11 10:38:12', '2026-09-11 10:38:12', '2026-09-01', NULL),
(75, 4, 40, 9, 'Y', 500.00, '2026-09-11 10:38:12', '2026-09-11 10:38:12', '2026-09-01', NULL),
(76, 4, 41, 7, 'Y', 500.00, '2026-09-11 10:38:12', '2026-09-11 10:38:12', '2026-09-01', NULL),
(77, 4, 41, 8, 'Y', 500.00, '2026-09-11 10:38:12', '2026-09-11 10:38:12', '2026-09-01', NULL),
(78, 4, 41, 9, 'Y', 500.00, '2026-09-11 10:38:12', '2026-09-11 10:38:12', '2026-09-01', NULL),
(79, 4, 42, 7, 'Y', 500.00, '2026-09-11 10:38:12', '2026-09-11 10:38:12', '2026-09-01', NULL),
(80, 4, 42, 8, 'Y', 500.00, '2026-09-11 10:38:12', '2026-09-11 10:38:12', '2026-09-01', NULL),
(81, 4, 42, 9, 'Y', 500.00, '2026-09-11 10:38:12', '2026-09-11 10:38:12', '2026-09-01', NULL),
(82, 4, 43, 7, 'Y', 500.00, '2026-09-11 10:38:12', '2026-09-11 10:38:12', '2026-09-01', NULL),
(83, 4, 43, 8, 'Y', 500.00, '2026-09-11 10:38:13', '2026-09-11 10:38:13', '2026-09-01', NULL),
(84, 4, 43, 9, 'Y', 500.00, '2026-09-11 10:38:13', '2026-09-11 10:38:13', '2026-09-01', NULL),
(85, 4, 44, 7, 'Y', 500.00, '2026-09-11 10:38:13', '2026-09-11 10:38:13', '2026-09-01', NULL),
(86, 4, 44, 8, 'Y', 500.00, '2026-09-11 10:38:13', '2026-09-11 10:38:13', '2026-09-01', NULL),
(87, 4, 44, 9, 'Y', 500.00, '2026-09-11 10:38:13', '2026-09-11 10:38:13', '2026-09-01', NULL),
(88, 4, 45, 7, 'Y', 500.00, '2026-09-11 10:38:13', '2026-09-11 10:38:13', '2026-09-01', NULL),
(89, 4, 45, 8, 'Y', 500.00, '2026-09-11 10:38:13', '2026-09-11 10:38:13', '2026-09-01', NULL),
(90, 4, 45, 9, 'Y', 500.00, '2026-09-11 10:38:13', '2026-09-11 10:38:13', '2026-09-01', NULL);

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
(8, 'Old-label, sticker and glue-mark remover', 'ml/coach', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(9, 'PVC floor-cleaning agent', 'ml/coach', 4, '2026-09-11 10:38:01', '2026-09-11 10:38:01'),
(10, 'Ceramic and stainless-steel toilet fittings cleaner', 'ml/coach', 4, '2026-09-11 10:38:02', '2026-09-11 10:38:02'),
(11, 'Glass-cleaning agent', 'ml/coach', 4, '2026-09-11 10:38:02', '2026-09-11 10:38:02'),
(12, 'Laminated plastic sheet and berth rexine cleaner', 'ml/coach', 4, '2026-09-11 10:38:02', '2026-09-11 10:38:02'),
(13, 'Painted-surface cleaner', 'ml/coach', 4, '2026-09-11 10:38:02', '2026-09-11 10:38:02'),
(14, 'Disinfectant', 'ml/coach', 4, '2026-09-11 10:38:02', '2026-09-11 10:38:02'),
(15, 'Air Freshener', 'ml/coach', 4, '2026-09-11 10:38:02', '2026-09-11 10:38:02'),
(16, 'Old-label, sticker and glue-mark remover', 'ml/coach', 4, '2026-09-11 10:38:02', '2026-09-11 10:38:02');

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
(16, 8, NULL, 'TKN-PTRY-20260908-633', 'Bheem Chand', 1, '12315', '01', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:28'),
(17, 1, NULL, 'TKN-PTRY-20260909-440', 'Bheem Chand', 1, '22781', '02', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:11'),
(18, 2, NULL, 'TKN-PTRY-20260909-440', 'Bheem Chand', 1, '22781', '02', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:11'),
(19, 3, NULL, 'TKN-PTRY-20260909-440', 'Bheem Chand', 1, '22781', '02', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:11'),
(20, 4, NULL, 'TKN-PTRY-20260909-440', 'Bheem Chand', 1, '22781', '02', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:11'),
(21, 5, NULL, 'TKN-PTRY-20260909-440', 'Bheem Chand', 1, '22781', '02', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:11'),
(22, 6, NULL, 'TKN-PTRY-20260909-440', 'Bheem Chand', 1, '22781', '02', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:11'),
(23, 7, NULL, 'TKN-PTRY-20260909-440', 'Bheem Chand', 1, '22781', '02', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:11'),
(24, 8, NULL, 'TKN-PTRY-20260909-440', 'Bheem Chand', 1, '22781', '02', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:11');

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
(8, 1, 8, 10.00, 200.00, 5.00, '2026-09-07', NULL, '2026-09-07 14:11:06', '2026-09-07 14:11:06'),
(9, 4, 9, 10.00, 200.00, 5.00, '2026-09-07', NULL, '2026-09-11 10:38:03', '2026-09-11 10:38:03'),
(10, 4, 10, 10.00, 200.00, 5.00, '2026-09-07', NULL, '2026-09-11 10:38:03', '2026-09-11 10:38:03'),
(11, 4, 11, 10.00, 200.00, 5.00, '2026-09-07', NULL, '2026-09-11 10:38:03', '2026-09-11 10:38:03'),
(12, 4, 12, 10.00, 200.00, 5.00, '2026-09-07', NULL, '2026-09-11 10:38:03', '2026-09-11 10:38:03'),
(13, 4, 13, 10.00, 200.00, 5.00, '2026-09-07', NULL, '2026-09-11 10:38:03', '2026-09-11 10:38:03'),
(14, 4, 14, 10.00, 200.00, 5.00, '2026-09-07', NULL, '2026-09-11 10:38:03', '2026-09-11 10:38:03'),
(15, 4, 15, 10.00, 200.00, 5.00, '2026-09-07', NULL, '2026-09-11 10:38:04', '2026-09-11 10:38:04'),
(16, 4, 16, 10.00, 200.00, 5.00, '2026-09-07', NULL, '2026-09-11 10:38:04', '2026-09-11 10:38:04');

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
(30, 'HHSD 6', 'Hand held single disc electrically operated mini scrubber', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(31, 'PPSD 1', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:38:14', '2026-09-11 10:38:14'),
(32, 'PPSD 2', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:38:14', '2026-09-11 10:38:14'),
(33, 'PPSD 3', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:38:14', '2026-09-11 10:38:14'),
(34, 'PPSD 4', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:38:14', '2026-09-11 10:38:14'),
(35, 'PPSD 5', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:38:15', '2026-09-11 10:38:15'),
(36, 'PPSD 6', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:38:15', '2026-09-11 10:38:15'),
(37, 'PPSD 7', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:38:16', '2026-09-11 10:38:16'),
(38, 'PPSD 8', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:38:16', '2026-09-11 10:38:16'),
(39, 'PPSD 9', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:38:16', '2026-09-11 10:38:16'),
(40, 'HHSD 1', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:38:16', '2026-09-11 10:38:16'),
(41, 'HHSD 2', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:38:17', '2026-09-11 10:38:17'),
(42, 'HHSD 3', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:38:17', '2026-09-11 10:38:17'),
(43, 'HHSD 4', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:38:17', '2026-09-11 10:38:17'),
(44, 'HHSD 5', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:38:17', '2026-09-11 10:38:17'),
(45, 'HHSD 6', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:38:17', '2026-09-11 10:38:17');

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
(6, 'Shift 3', 1, '2026-08-29 16:00:25', '2026-08-29 16:00:25'),
(7, 'Shift 1', 4, '2026-09-11 10:38:18', '2026-09-11 10:38:18'),
(8, 'Shift 2', 4, '2026-09-11 10:38:18', '2026-09-11 10:38:18'),
(9, 'Shift 3', 4, '2026-09-11 10:38:18', '2026-09-11 10:38:18');

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
(45, 1, 30, 6, 'Y', 500.00, '2026-09-01', NULL, '2026-09-08 06:13:52', '2026-09-08 06:13:52'),
(46, 4, 31, 7, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:19', '2026-09-11 10:38:19'),
(47, 4, 31, 8, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:19', '2026-09-11 10:38:19'),
(48, 4, 31, 9, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:19', '2026-09-11 10:38:19'),
(49, 4, 32, 7, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:19', '2026-09-11 10:38:19'),
(50, 4, 32, 8, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:19', '2026-09-11 10:38:19'),
(51, 4, 32, 9, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:19', '2026-09-11 10:38:19'),
(52, 4, 33, 7, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:20', '2026-09-11 10:38:20'),
(53, 4, 33, 8, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:20', '2026-09-11 10:38:20'),
(54, 4, 33, 9, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:20', '2026-09-11 10:38:20'),
(55, 4, 34, 7, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:20', '2026-09-11 10:38:20'),
(56, 4, 34, 8, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:20', '2026-09-11 10:38:20'),
(57, 4, 34, 9, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:20', '2026-09-11 10:38:20'),
(58, 4, 35, 7, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:20', '2026-09-11 10:38:20'),
(59, 4, 35, 8, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:20', '2026-09-11 10:38:20'),
(60, 4, 35, 9, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:20', '2026-09-11 10:38:20'),
(61, 4, 36, 7, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:21', '2026-09-11 10:38:21'),
(62, 4, 36, 8, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:21', '2026-09-11 10:38:21'),
(63, 4, 36, 9, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:21', '2026-09-11 10:38:21'),
(64, 4, 37, 7, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:21', '2026-09-11 10:38:21'),
(65, 4, 37, 8, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:21', '2026-09-11 10:38:21'),
(66, 4, 37, 9, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:21', '2026-09-11 10:38:21'),
(67, 4, 38, 7, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:22', '2026-09-11 10:38:22'),
(68, 4, 38, 8, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:22', '2026-09-11 10:38:22'),
(69, 4, 38, 9, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:22', '2026-09-11 10:38:22'),
(70, 4, 39, 7, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:22', '2026-09-11 10:38:22'),
(71, 4, 39, 8, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:22', '2026-09-11 10:38:22'),
(72, 4, 39, 9, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:22', '2026-09-11 10:38:22'),
(73, 4, 40, 7, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:22', '2026-09-11 10:38:22'),
(74, 4, 40, 8, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:22', '2026-09-11 10:38:22'),
(75, 4, 40, 9, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:22', '2026-09-11 10:38:22'),
(76, 4, 41, 7, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:23', '2026-09-11 10:38:23'),
(77, 4, 41, 8, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:23', '2026-09-11 10:38:23'),
(78, 4, 41, 9, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:23', '2026-09-11 10:38:23'),
(79, 4, 42, 7, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:23', '2026-09-11 10:38:23'),
(80, 4, 42, 8, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:23', '2026-09-11 10:38:23'),
(81, 4, 42, 9, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:23', '2026-09-11 10:38:23'),
(82, 4, 43, 7, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:23', '2026-09-11 10:38:23'),
(83, 4, 43, 8, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:23', '2026-09-11 10:38:23'),
(84, 4, 43, 9, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:23', '2026-09-11 10:38:23'),
(85, 4, 44, 7, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:24', '2026-09-11 10:38:24'),
(86, 4, 44, 8, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:24', '2026-09-11 10:38:24'),
(87, 4, 44, 9, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:25', '2026-09-11 10:38:25'),
(88, 4, 45, 7, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:25', '2026-09-11 10:38:25'),
(89, 4, 45, 8, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:26', '2026-09-11 10:38:26'),
(90, 4, 45, 9, 'Y', 500.00, '2026-09-01', NULL, '2026-09-11 10:38:26', '2026-09-11 10:38:26');

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
(54, 'All storage spaces, racks, tables and counter to be scrubbed properly (Total marks: 3)', 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19'),
(55, 'All items of daily cleaning attention (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:49', '2026-09-11 10:37:49'),
(56, 'Apply polish to the stainless steel wash basins and other items as required. (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:49', '2026-09-11 10:37:49'),
(57, 'Buffing of stainless steel items such as wash basins, wall protector and lavatory pans etc. (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:49', '2026-09-11 10:37:49'),
(58, 'PVC floor cleaning using electric floor scrubber and vacuum cleaner (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:49', '2026-09-11 10:37:49'),
(59, 'Cleaning of Seat/Berths using portable electric disc scrubber (Cleaning of Seat/Berths using portable wet & dry vacuum cleaner - Only For vande bharat coach seats) Berth flap should be cleaned with wet cloth (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:49', '2026-09-11 10:37:49'),
(60, 'Cleaning of LP Sheet and Roof. No graffiti/sticker/cobweb/spot should be visible after cleaning attention. (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:49', '2026-09-11 10:37:49'),
(61, 'Cleaning of Doorway & vestibule area with scrubber and Vacuum machines (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:50', '2026-09-11 10:37:50'),
(62, 'Corners and dustbins to be cleaned with nylon brush. Cleaning of dustbins & dismantling/assembling if required (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:50', '2026-09-11 10:37:50'),
(63, 'Footsteps to be cleaned thoroughly (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:50', '2026-09-11 10:37:50'),
(64, 'Cleaning/polishing of amenity fittings (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:50', '2026-09-11 10:37:50'),
(65, 'Cleaning/polishing of door handles etc (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:50', '2026-09-11 10:37:50'),
(66, 'All glass windows should be cleaned so that no spot is visible. Window sill area needs special cleaning to remove pan stains/spit stains using portable electric scrubber (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:51', '2026-09-11 10:37:51'),
(67, 'Dry & wet vacuum cleaning in inaccessible areas like behind panels (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:51', '2026-09-11 10:37:51'),
(68, 'Visible portion of the exterior Roof should be cleaned using a long brush (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:51', '2026-09-11 10:37:51'),
(69, 'Complete exterior cleaning (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:51', '2026-09-11 10:37:51'),
(70, 'All stoves (Total marks: 3 marks for each stove)', 4, 'Active', '2026-09-11 10:37:51', '2026-09-11 10:37:51'),
(71, 'Hot cases (Total marks: 3 marks for each hot Hot Case ) & All refrigerators (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:51', '2026-09-11 10:37:51'),
(72, 'All storage spaces, racks, tables and counter to be scrubbed properly (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:51', '2026-09-11 10:37:51');

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
(98, 49, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:21:00'),
(99, 1, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:15'),
(100, 2, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:22'),
(101, 3, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:22'),
(102, 4, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:22'),
(103, 5, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:22'),
(104, 6, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:22'),
(105, 7, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:22'),
(106, 8, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:25'),
(107, 9, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:25'),
(108, 10, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:25'),
(109, 11, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:25'),
(110, 12, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:30'),
(111, 13, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:34'),
(112, 14, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:34'),
(113, 15, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:46'),
(114, 16, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:46'),
(115, 17, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:46'),
(116, 18, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:46'),
(117, 19, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:49'),
(118, 20, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:49'),
(119, 21, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:53'),
(120, 22, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:53'),
(121, 23, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:56'),
(122, 24, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:56'),
(123, 25, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:56'),
(124, 26, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:56'),
(125, 27, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:59'),
(126, 28, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:04'),
(127, 29, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:04'),
(128, 30, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:04'),
(129, 31, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:04'),
(130, 32, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:10'),
(131, 33, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:10'),
(132, 34, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:15'),
(133, 35, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:21'),
(134, 36, 1, 'TKN-PTRY-20260909-440', '22781', '02', '1', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:21'),
(135, 37, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:24'),
(136, 38, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:24'),
(137, 39, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:27'),
(138, 40, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:27'),
(139, 41, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:27'),
(140, 42, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:27'),
(141, 43, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:33'),
(142, 44, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:33'),
(143, 45, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:33'),
(144, 46, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:38'),
(145, 47, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:38'),
(146, 48, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:38'),
(147, 49, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:38');

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
(147, 'Food racks', 54, 3, 'Active', '2026-08-17 06:54:19', '2026-08-17 06:54:19', 'cleaning'),
(148, 'Daily', 55, 4, 'Active', '2026-09-11 10:37:52', '2026-09-11 10:37:52', 'cleaning'),
(149, 'Basin 1', 56, 4, 'Active', '2026-09-11 10:37:52', '2026-09-11 10:37:52', 'cleaning'),
(150, 'Basin 2', 56, 4, 'Active', '2026-09-11 10:37:52', '2026-09-11 10:37:52', 'cleaning'),
(151, 'Basin 3', 56, 4, 'Active', '2026-09-11 10:37:52', '2026-09-11 10:37:52', 'cleaning'),
(152, 'Basin 4', 56, 4, 'Active', '2026-09-11 10:37:52', '2026-09-11 10:37:52', 'cleaning'),
(153, 'Basin 5', 56, 4, 'Active', '2026-09-11 10:37:53', '2026-09-11 10:37:53', 'cleaning'),
(154, 'Basin 6', 56, 4, 'Active', '2026-09-11 10:37:53', '2026-09-11 10:37:53', 'cleaning'),
(155, 'Toilet 1', 57, 4, 'Active', '2026-09-11 10:37:53', '2026-09-11 10:37:53', 'cleaning'),
(156, 'Toilet 2', 57, 4, 'Active', '2026-09-11 10:37:53', '2026-09-11 10:37:53', 'cleaning'),
(157, 'Toilet 3', 57, 4, 'Active', '2026-09-11 10:37:53', '2026-09-11 10:37:53', 'cleaning'),
(158, 'Toilet 4', 57, 4, 'Active', '2026-09-11 10:37:53', '2026-09-11 10:37:53', 'cleaning'),
(159, 'Floor', 58, 4, 'Active', '2026-09-11 10:37:53', '2026-09-11 10:37:53', 'cleaning'),
(160, 'Bay 1', 59, 4, 'Active', '2026-09-11 10:37:53', '2026-09-11 10:37:53', 'cleaning'),
(161, 'Bay 2', 59, 4, 'Active', '2026-09-11 10:37:53', '2026-09-11 10:37:53', 'cleaning'),
(162, 'Bay 1', 60, 4, 'Active', '2026-09-11 10:37:54', '2026-09-11 10:37:54', 'cleaning'),
(163, 'Bay 2', 60, 4, 'Active', '2026-09-11 10:37:54', '2026-09-11 10:37:54', 'cleaning'),
(164, 'AP End', 60, 4, 'Active', '2026-09-11 10:37:54', '2026-09-11 10:37:54', 'cleaning'),
(165, 'SBC End', 60, 4, 'Active', '2026-09-11 10:37:54', '2026-09-11 10:37:54', 'cleaning'),
(166, 'AP End', 61, 4, 'Active', '2026-09-11 10:37:54', '2026-09-11 10:37:54', 'cleaning'),
(167, 'SBC End', 61, 4, 'Active', '2026-09-11 10:37:54', '2026-09-11 10:37:54', 'cleaning'),
(168, 'Ap End', 62, 4, 'Active', '2026-09-11 10:37:54', '2026-09-11 10:37:54', 'cleaning'),
(169, 'SBC End', 62, 4, 'Active', '2026-09-11 10:37:54', '2026-09-11 10:37:54', 'cleaning'),
(170, 'Foot Step 1', 63, 4, 'Active', '2026-09-11 10:37:54', '2026-09-11 10:37:54', 'cleaning'),
(171, 'Foot Step 2', 63, 4, 'Active', '2026-09-11 10:37:55', '2026-09-11 10:37:55', 'cleaning'),
(172, 'Foot Step 3', 63, 4, 'Active', '2026-09-11 10:37:55', '2026-09-11 10:37:55', 'cleaning'),
(173, 'Foot Step 4', 63, 4, 'Active', '2026-09-11 10:37:55', '2026-09-11 10:37:55', 'cleaning'),
(174, 'Amenity', 64, 4, 'Active', '2026-09-11 10:37:55', '2026-09-11 10:37:55', 'cleaning'),
(175, 'Door 1', 65, 4, 'Active', '2026-09-11 10:37:55', '2026-09-11 10:37:55', 'cleaning'),
(176, 'door 2', 65, 4, 'Active', '2026-09-11 10:37:55', '2026-09-11 10:37:55', 'cleaning'),
(177, 'Door 3', 65, 4, 'Active', '2026-09-11 10:37:55', '2026-09-11 10:37:55', 'cleaning'),
(178, 'Door 4', 65, 4, 'Active', '2026-09-11 10:37:55', '2026-09-11 10:37:55', 'cleaning'),
(179, 'East Side', 66, 4, 'Active', '2026-09-11 10:37:56', '2026-09-11 10:37:56', 'cleaning'),
(180, 'West Side', 66, 4, 'Active', '2026-09-11 10:37:56', '2026-09-11 10:37:56', 'cleaning'),
(181, 'Vacuum', 67, 4, 'Active', '2026-09-11 10:37:56', '2026-09-11 10:37:56', 'cleaning'),
(182, 'East Side', 68, 4, 'Active', '2026-09-11 10:37:56', '2026-09-11 10:37:56', 'cleaning'),
(183, 'West Side', 68, 4, 'Active', '2026-09-11 10:37:56', '2026-09-11 10:37:56', 'cleaning'),
(184, 'East Side', 69, 4, 'Active', '2026-09-11 10:37:56', '2026-09-11 10:37:56', 'cleaning'),
(185, 'West Side', 69, 4, 'Active', '2026-09-11 10:37:56', '2026-09-11 10:37:56', 'cleaning'),
(186, 'Stove 1', 70, 4, 'Active', '2026-09-11 10:37:56', '2026-09-11 10:37:56', 'cleaning'),
(187, 'Stove 2', 70, 4, 'Active', '2026-09-11 10:37:56', '2026-09-11 10:37:56', 'cleaning'),
(188, 'Stove 3', 70, 4, 'Active', '2026-09-11 10:37:57', '2026-09-11 10:37:57', 'cleaning'),
(189, 'Stove 4', 70, 4, 'Active', '2026-09-11 10:37:57', '2026-09-11 10:37:57', 'cleaning'),
(190, 'Hot case 1', 71, 4, 'Active', '2026-09-11 10:37:57', '2026-09-11 10:37:57', 'cleaning'),
(191, 'Hot case 2', 71, 4, 'Active', '2026-09-11 10:37:57', '2026-09-11 10:37:57', 'cleaning'),
(192, 'Refrigerators', 71, 4, 'Active', '2026-09-11 10:37:57', '2026-09-11 10:37:57', 'cleaning'),
(193, 'Storage area', 72, 4, 'Active', '2026-09-11 10:37:57', '2026-09-11 10:37:57', 'cleaning'),
(194, 'All tables', 72, 4, 'Active', '2026-09-11 10:37:57', '2026-09-11 10:37:57', 'cleaning'),
(195, 'Counter', 72, 4, 'Active', '2026-09-11 10:37:57', '2026-09-11 10:37:57', 'cleaning'),
(196, 'Food racks', 72, 4, 'Active', '2026-09-11 10:37:57', '2026-09-11 10:37:57', 'cleaning');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_intensive_rating`
--

CREATE TABLE `mcc_intensive_rating` (
  `id` int(11) NOT NULL,
  `rating_name` varchar(50) NOT NULL,
  `rating_value` varchar(10) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `rating_group` varchar(50) DEFAULT 'standard'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_rating`
--

INSERT INTO `mcc_intensive_rating` (`id`, `rating_name`, `rating_value`, `created_at`, `rating_group`) VALUES
(1, 'Excellent', '3', '2026-09-11 10:18:43', 'cleaning'),
(2, 'Good', '2', '2026-09-11 10:18:43', 'cleaning'),
(3, 'Average', '1', '2026-09-11 10:18:43', 'cleaning'),
(4, 'Poor', '0', '2026-09-11 10:18:43', 'cleaning'),
(5, 'Yes', 'Y', '2026-09-12 07:59:31', 'watering'),
(6, 'No', 'N', '2026-09-12 07:59:31', 'watering');

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
(48, 'Complete exterior cleaning (Total marks: 3)', 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08'),
(49, 'All items of daily cleaning attention (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:37', '2026-09-11 10:37:37'),
(50, 'Apply polish to the stainless steel wash basins and other items as required. (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:37', '2026-09-11 10:37:37'),
(51, 'Buffing of stainless steel items such as wash basins, wall protector and lavatory pans etc. (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:37', '2026-09-11 10:37:37'),
(52, 'PVC floor cleaning using electric floor scrubber and vacuum cleaner (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:37', '2026-09-11 10:37:37'),
(53, 'Cleaning of Seat/Berths using portable electric disc scrubber (Cleaning of Seat/Berths using portable wet & dry vacuum cleaner - Only For vande bharat coach seats) Berth flap should be cleaned with wet cloth (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:37', '2026-09-11 10:37:37'),
(54, 'Cleaning of LP Sheet and Roof. No graffiti/sticker/cobweb/spot should be visible after cleaning attention. (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:38', '2026-09-11 10:37:38'),
(55, 'Cleaning of Doorway & vestibule area with scrubber and Vacuum machines (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:38', '2026-09-11 10:37:38'),
(56, 'Corners and dustbins to be cleaned with nylon brush. Cleaning of dustbins & dismantling/assembling if required (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:38', '2026-09-11 10:37:38'),
(57, 'Footsteps to be cleaned thoroughly (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:38', '2026-09-11 10:37:38'),
(58, 'Cleaning/polishing of amenity fittings (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:38', '2026-09-11 10:37:38'),
(59, 'Cleaning/polishing of door handles etc (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:38', '2026-09-11 10:37:38'),
(60, 'All glass windows should be cleaned so that no spot is visible. Window sill area needs special cleaning to remove pan stains/spit stains using portable electric scrubber (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:38', '2026-09-11 10:37:38'),
(61, 'Panes of Louver shutter should also be cleaned with wet cloth. In the case of Vande bharat, All luggage racks should be cleaned. (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:38', '2026-09-11 10:37:38'),
(62, 'Dry & wet vacuum cleaning in inaccessible areas like behind panels (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:38', '2026-09-11 10:37:38'),
(63, 'Visible portion of the exterior Roof should be cleaned using a long brush. (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:39', '2026-09-11 10:37:39'),
(64, 'Complete exterior cleaning (Total marks: 3)', 4, 'Active', '2026-09-11 10:37:39', '2026-09-11 10:37:39');

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
(532, 76, 1, 'TKN-20260908-286', '16236', '1', '2', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:43'),
(533, 1, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:05'),
(534, 2, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:08'),
(535, 3, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:08'),
(536, 4, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:08'),
(537, 5, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:08'),
(538, 6, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:08'),
(539, 7, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:08'),
(540, 8, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:12'),
(541, 9, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:12'),
(542, 10, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:12'),
(543, 11, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:12'),
(544, 12, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:15'),
(545, 13, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25'),
(546, 14, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25'),
(547, 15, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25'),
(548, 16, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25'),
(549, 17, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25'),
(550, 18, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25'),
(551, 19, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25'),
(552, 20, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25'),
(553, 21, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25'),
(554, 22, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25'),
(555, 23, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33'),
(556, 24, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33'),
(557, 25, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33'),
(558, 26, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33'),
(559, 27, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33'),
(560, 28, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33'),
(561, 29, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33'),
(562, 30, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33'),
(563, 31, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33'),
(564, 32, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33'),
(565, 33, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33'),
(566, 34, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33'),
(567, 35, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:44'),
(568, 36, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:44'),
(569, 37, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:38'),
(570, 38, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:38'),
(571, 39, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:53'),
(572, 40, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:53'),
(573, 41, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:53'),
(574, 42, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:53'),
(575, 43, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:53'),
(576, 44, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:53'),
(577, 45, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:58'),
(578, 46, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:01'),
(579, 47, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:01'),
(580, 48, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:01'),
(581, 49, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:01'),
(582, 50, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:01'),
(583, 51, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:01'),
(584, 52, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11'),
(585, 53, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11'),
(586, 54, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11'),
(587, 55, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11'),
(588, 56, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11'),
(589, 57, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11'),
(590, 58, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11'),
(591, 59, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11'),
(592, 60, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11'),
(593, 61, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11'),
(594, 62, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18'),
(595, 63, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18'),
(596, 64, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18'),
(597, 65, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18'),
(598, 66, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18'),
(599, 67, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18'),
(600, 68, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18'),
(601, 69, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18'),
(602, 70, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18'),
(603, 71, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18'),
(604, 72, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:22'),
(605, 73, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:25'),
(606, 74, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:25'),
(607, 75, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:28'),
(608, 76, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:28'),
(609, 1, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:36'),
(610, 2, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:41'),
(611, 3, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:41'),
(612, 4, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:41'),
(613, 5, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:41'),
(614, 6, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:41'),
(615, 7, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:41'),
(616, 8, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:51'),
(617, 9, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:51'),
(618, 10, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:51'),
(619, 11, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:51'),
(620, 12, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:55'),
(621, 13, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03'),
(622, 14, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03'),
(623, 15, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03'),
(624, 16, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03'),
(625, 17, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03'),
(626, 18, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03'),
(627, 19, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03'),
(628, 20, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03'),
(629, 21, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03'),
(630, 22, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03'),
(631, 23, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08'),
(632, 24, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08'),
(633, 25, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08'),
(634, 26, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08'),
(635, 27, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08'),
(636, 28, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08'),
(637, 29, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08'),
(638, 30, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08'),
(639, 31, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08'),
(640, 32, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08'),
(641, 33, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08'),
(642, 34, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08'),
(643, 35, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:14'),
(644, 36, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:14'),
(645, 37, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:19'),
(646, 38, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:19'),
(647, 39, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:29'),
(648, 40, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:29'),
(649, 41, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:29'),
(650, 42, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:29'),
(651, 43, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:29'),
(652, 44, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:29'),
(653, 45, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:35'),
(654, 46, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:44'),
(655, 47, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:44'),
(656, 48, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:44'),
(657, 49, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:44'),
(658, 50, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:44'),
(659, 51, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:44'),
(660, 52, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47'),
(661, 53, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47'),
(662, 54, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47'),
(663, 55, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47'),
(664, 56, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47'),
(665, 57, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47'),
(666, 58, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47'),
(667, 59, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47'),
(668, 60, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47'),
(669, 61, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47'),
(670, 62, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01'),
(671, 63, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01'),
(672, 64, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01'),
(673, 65, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01'),
(674, 66, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01'),
(675, 67, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01'),
(676, 68, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01'),
(677, 69, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01'),
(678, 70, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01'),
(679, 71, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01'),
(680, 72, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:11'),
(681, 73, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:14'),
(682, 74, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:14'),
(683, 75, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:19'),
(684, 76, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:19'),
(685, 1, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:27:59'),
(686, 2, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:13'),
(687, 3, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:13'),
(688, 4, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:13'),
(689, 5, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:13'),
(690, 6, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:13'),
(691, 7, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:13'),
(692, 8, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:18'),
(693, 9, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:18'),
(694, 10, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:18'),
(695, 11, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:18'),
(696, 12, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:21'),
(697, 13, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32'),
(698, 14, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32'),
(699, 15, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32'),
(700, 16, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32'),
(701, 17, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32'),
(702, 18, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32'),
(703, 19, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32'),
(704, 20, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32'),
(705, 21, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32'),
(706, 22, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32'),
(707, 23, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39'),
(708, 24, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39'),
(709, 25, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39'),
(710, 26, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39'),
(711, 27, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39'),
(712, 28, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39'),
(713, 29, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39'),
(714, 30, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39'),
(715, 31, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39'),
(716, 32, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39'),
(717, 33, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39'),
(718, 34, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39'),
(719, 35, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:45'),
(720, 36, 1, 'TKN-20260909-635', '22687', '01', '1', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:45'),
(721, 37, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:49'),
(722, 38, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:49'),
(723, 39, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:52'),
(724, 40, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:52'),
(725, 41, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:52'),
(726, 42, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:52'),
(727, 43, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:52'),
(728, 44, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:52'),
(729, 45, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:56'),
(730, 46, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:00'),
(731, 47, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:00'),
(732, 48, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:00'),
(733, 49, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:00'),
(734, 50, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:00'),
(735, 51, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:00'),
(736, 52, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08'),
(737, 53, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08'),
(738, 54, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08'),
(739, 55, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08'),
(740, 56, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08'),
(741, 57, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08'),
(742, 58, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08'),
(743, 59, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08'),
(744, 60, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08'),
(745, 61, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08'),
(746, 62, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12'),
(747, 63, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12'),
(748, 64, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12'),
(749, 65, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12'),
(750, 66, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12'),
(751, 67, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12'),
(752, 68, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12'),
(753, 69, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12'),
(754, 70, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12'),
(755, 71, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12'),
(756, 72, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:16'),
(757, 73, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:21'),
(758, 74, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:21'),
(759, 75, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:25'),
(760, 76, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:25'),
(761, 1, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:29:53'),
(762, 2, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:02'),
(763, 3, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:02'),
(764, 4, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:02'),
(765, 5, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:02'),
(766, 6, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:02'),
(767, 7, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:02'),
(768, 8, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:08'),
(769, 9, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:08'),
(770, 10, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:08'),
(771, 11, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:08'),
(772, 12, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:11'),
(773, 13, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20'),
(774, 14, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20'),
(775, 15, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20'),
(776, 16, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20'),
(777, 17, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20'),
(778, 18, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20'),
(779, 19, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20'),
(780, 20, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20'),
(781, 21, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20'),
(782, 22, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20'),
(783, 23, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25'),
(784, 24, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25'),
(785, 25, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25'),
(786, 26, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25'),
(787, 27, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25'),
(788, 28, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25'),
(789, 29, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25'),
(790, 30, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25'),
(791, 31, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25'),
(792, 32, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25'),
(793, 33, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25'),
(794, 34, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25'),
(795, 35, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:31'),
(796, 36, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:31'),
(797, 37, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:35'),
(798, 38, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:35'),
(799, 39, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:41'),
(800, 40, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:41'),
(801, 41, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:41'),
(802, 42, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:41'),
(803, 43, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:41'),
(804, 44, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:41'),
(805, 45, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:44'),
(806, 46, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:53'),
(807, 47, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:53'),
(808, 48, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:53'),
(809, 49, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:53'),
(810, 50, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:53');
INSERT INTO `mcc_intensive_scorecard_2_report` (`id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `submitted_by`, `report_date`, `created_at`, `updated_at`) VALUES
(811, 51, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:53'),
(812, 52, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06'),
(813, 53, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06'),
(814, 54, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06'),
(815, 55, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06'),
(816, 56, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06'),
(817, 57, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06'),
(818, 58, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06'),
(819, 59, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06'),
(820, 60, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06'),
(821, 61, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06'),
(822, 62, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16'),
(823, 63, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16'),
(824, 64, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16'),
(825, 65, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16'),
(826, 66, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16'),
(827, 67, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16'),
(828, 68, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16'),
(829, 69, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16'),
(830, 70, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16'),
(831, 71, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16'),
(832, 72, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:21'),
(833, 73, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:27'),
(834, 74, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:27'),
(835, 75, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:32'),
(836, 76, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:32'),
(837, 1, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:09'),
(838, 2, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:19'),
(839, 3, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:19'),
(840, 4, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:19'),
(841, 5, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:19'),
(842, 6, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:19'),
(843, 7, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:19'),
(844, 8, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:24'),
(845, 9, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:24'),
(846, 10, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:24'),
(847, 11, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:24'),
(848, 12, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:29'),
(849, 13, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34'),
(850, 14, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34'),
(851, 15, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34'),
(852, 16, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34'),
(853, 17, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34'),
(854, 18, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34'),
(855, 19, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34'),
(856, 20, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34'),
(857, 21, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34'),
(858, 22, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34'),
(859, 23, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39'),
(860, 24, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39'),
(861, 25, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39'),
(862, 26, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39'),
(863, 27, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39'),
(864, 28, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39'),
(865, 29, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39'),
(866, 30, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39'),
(867, 31, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39'),
(868, 32, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39'),
(869, 33, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39'),
(870, 34, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39'),
(871, 35, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:44'),
(872, 36, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:44'),
(873, 37, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:50'),
(874, 38, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:50'),
(875, 39, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:59'),
(876, 40, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:59'),
(877, 41, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:59'),
(878, 42, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:59'),
(879, 43, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:59'),
(880, 44, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:59'),
(881, 45, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:06'),
(882, 46, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:16'),
(883, 47, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:16'),
(884, 48, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:16'),
(885, 49, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:16'),
(886, 50, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:16'),
(887, 51, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:16'),
(888, 52, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19'),
(889, 53, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19'),
(890, 54, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19'),
(891, 55, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19'),
(892, 56, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19'),
(893, 57, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19'),
(894, 58, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19'),
(895, 59, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19'),
(896, 60, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19'),
(897, 61, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19'),
(898, 62, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26'),
(899, 63, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26'),
(900, 64, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26'),
(901, 65, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26'),
(902, 66, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26'),
(903, 67, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26'),
(904, 68, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26'),
(905, 69, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26'),
(906, 70, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26'),
(907, 71, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26'),
(908, 72, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:30'),
(909, 73, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:36'),
(910, 74, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:36'),
(911, 75, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:45'),
(912, 76, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:45');

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
(228, 'West Side', 48, 3, 'Active', '2026-08-14 10:08:08', '2026-08-14 10:08:08', 'cleaning'),
(229, 'Daily', 49, 4, 'Active', '2026-09-11 10:37:39', '2026-09-11 10:37:39', 'cleaning'),
(230, 'Basin 1', 50, 4, 'Active', '2026-09-11 10:37:39', '2026-09-11 10:37:39', 'cleaning'),
(231, 'Basin 2', 50, 4, 'Active', '2026-09-11 10:37:40', '2026-09-11 10:37:40', 'cleaning'),
(232, 'Basin 3', 50, 4, 'Active', '2026-09-11 10:37:40', '2026-09-11 10:37:40', 'cleaning'),
(233, 'Basin 4', 50, 4, 'Active', '2026-09-11 10:37:40', '2026-09-11 10:37:40', 'cleaning'),
(234, 'Basin 5', 50, 4, 'Active', '2026-09-11 10:37:40', '2026-09-11 10:37:40', 'cleaning'),
(235, 'Basin 6', 50, 4, 'Active', '2026-09-11 10:37:40', '2026-09-11 10:37:40', 'cleaning'),
(236, 'Toilet 1', 51, 4, 'Active', '2026-09-11 10:37:40', '2026-09-11 10:37:40', 'cleaning'),
(237, 'Toilet 2', 51, 4, 'Active', '2026-09-11 10:37:40', '2026-09-11 10:37:40', 'cleaning'),
(238, 'Toilet 3', 51, 4, 'Active', '2026-09-11 10:37:40', '2026-09-11 10:37:40', 'cleaning'),
(239, 'Toilet 4', 51, 4, 'Active', '2026-09-11 10:37:40', '2026-09-11 10:37:40', 'cleaning'),
(240, 'Floor', 52, 4, 'Active', '2026-09-11 10:37:41', '2026-09-11 10:37:41', 'cleaning'),
(241, 'Bay 1', 53, 4, 'Active', '2026-09-11 10:37:41', '2026-09-11 10:37:41', 'cleaning'),
(242, 'Bay 2', 53, 4, 'Active', '2026-09-11 10:37:41', '2026-09-11 10:37:41', 'cleaning'),
(243, 'Bay 3', 53, 4, 'Active', '2026-09-11 10:37:41', '2026-09-11 10:37:41', 'cleaning'),
(244, 'Bay 4', 53, 4, 'Active', '2026-09-11 10:37:41', '2026-09-11 10:37:41', 'cleaning'),
(245, 'Bay 5', 53, 4, 'Active', '2026-09-11 10:37:41', '2026-09-11 10:37:41', 'cleaning'),
(246, 'Bay 6', 53, 4, 'Active', '2026-09-11 10:37:41', '2026-09-11 10:37:41', 'cleaning'),
(247, 'Bay 7', 53, 4, 'Active', '2026-09-11 10:37:42', '2026-09-11 10:37:42', 'cleaning'),
(248, 'Bay 8', 53, 4, 'Active', '2026-09-11 10:37:42', '2026-09-11 10:37:42', 'cleaning'),
(249, 'Bay 9', 53, 4, 'Active', '2026-09-11 10:37:42', '2026-09-11 10:37:42', 'cleaning'),
(250, 'Bay 10', 53, 4, 'Active', '2026-09-11 10:37:42', '2026-09-11 10:37:42', 'cleaning'),
(251, 'Bay 1', 54, 4, 'Active', '2026-09-11 10:37:42', '2026-09-11 10:37:42', 'cleaning'),
(252, 'Bay 2', 54, 4, 'Active', '2026-09-11 10:37:42', '2026-09-11 10:37:42', 'cleaning'),
(253, 'Bay 3', 54, 4, 'Active', '2026-09-11 10:37:42', '2026-09-11 10:37:42', 'cleaning'),
(254, 'Bay 4', 54, 4, 'Active', '2026-09-11 10:37:42', '2026-09-11 10:37:42', 'cleaning'),
(255, 'Bay 5', 54, 4, 'Active', '2026-09-11 10:37:43', '2026-09-11 10:37:43', 'cleaning'),
(256, 'Bay 6', 54, 4, 'Active', '2026-09-11 10:37:43', '2026-09-11 10:37:43', 'cleaning'),
(257, 'Bay 7', 54, 4, 'Active', '2026-09-11 10:37:43', '2026-09-11 10:37:43', 'cleaning'),
(258, 'Bay 8', 54, 4, 'Active', '2026-09-11 10:37:43', '2026-09-11 10:37:43', 'cleaning'),
(259, 'Bay 9', 54, 4, 'Active', '2026-09-11 10:37:43', '2026-09-11 10:37:43', 'cleaning'),
(260, 'Bay 10', 54, 4, 'Active', '2026-09-11 10:37:43', '2026-09-11 10:37:43', 'cleaning'),
(261, 'AP End', 54, 4, 'Active', '2026-09-11 10:37:44', '2026-09-11 10:37:44', 'cleaning'),
(262, 'SBC End', 54, 4, 'Active', '2026-09-11 10:37:44', '2026-09-11 10:37:44', 'cleaning'),
(263, 'AP End', 55, 4, 'Active', '2026-09-11 10:37:44', '2026-09-11 10:37:44', 'cleaning'),
(264, 'SBC End', 55, 4, 'Active', '2026-09-11 10:37:44', '2026-09-11 10:37:44', 'cleaning'),
(265, 'AP End', 56, 4, 'Active', '2026-09-11 10:37:44', '2026-09-11 10:37:44', 'cleaning'),
(266, 'SBC End', 56, 4, 'Active', '2026-09-11 10:37:44', '2026-09-11 10:37:44', 'cleaning'),
(267, 'Foot Step 1', 57, 4, 'Active', '2026-09-11 10:37:44', '2026-09-11 10:37:44', 'cleaning'),
(268, 'Foot Step 2', 57, 4, 'Active', '2026-09-11 10:37:44', '2026-09-11 10:37:44', 'cleaning'),
(269, 'Foot Step 3', 57, 4, 'Active', '2026-09-11 10:37:45', '2026-09-11 10:37:45', 'cleaning'),
(270, 'Foot Step 4', 57, 4, 'Active', '2026-09-11 10:37:45', '2026-09-11 10:37:45', 'cleaning'),
(271, 'Foot Step 5', 57, 4, 'Active', '2026-09-11 10:37:45', '2026-09-11 10:37:45', 'cleaning'),
(272, 'Foot Step 6', 57, 4, 'Active', '2026-09-11 10:37:45', '2026-09-11 10:37:45', 'cleaning'),
(273, 'Amenity', 58, 4, 'Active', '2026-09-11 10:37:45', '2026-09-11 10:37:45', 'cleaning'),
(274, 'Door 1', 59, 4, 'Active', '2026-09-11 10:37:45', '2026-09-11 10:37:45', 'cleaning'),
(275, 'door 2', 59, 4, 'Active', '2026-09-11 10:37:45', '2026-09-11 10:37:45', 'cleaning'),
(276, 'Door 3', 59, 4, 'Active', '2026-09-11 10:37:45', '2026-09-11 10:37:45', 'cleaning'),
(277, 'Door 4', 59, 4, 'Active', '2026-09-11 10:37:45', '2026-09-11 10:37:45', 'cleaning'),
(278, 'Door 5', 59, 4, 'Active', '2026-09-11 10:37:46', '2026-09-11 10:37:46', 'cleaning'),
(279, 'Door 6', 59, 4, 'Active', '2026-09-11 10:37:46', '2026-09-11 10:37:46', 'cleaning'),
(280, 'Bay 1', 60, 4, 'Active', '2026-09-11 10:37:46', '2026-09-11 10:37:46', 'cleaning'),
(281, 'Bay 2', 60, 4, 'Active', '2026-09-11 10:37:46', '2026-09-11 10:37:46', 'cleaning'),
(282, 'Bay 3', 60, 4, 'Active', '2026-09-11 10:37:46', '2026-09-11 10:37:46', 'cleaning'),
(283, 'Bay 4', 60, 4, 'Active', '2026-09-11 10:37:46', '2026-09-11 10:37:46', 'cleaning'),
(284, 'Bay 5', 60, 4, 'Active', '2026-09-11 10:37:46', '2026-09-11 10:37:46', 'cleaning'),
(285, 'Bay 6', 60, 4, 'Active', '2026-09-11 10:37:46', '2026-09-11 10:37:46', 'cleaning'),
(286, 'Bay 7', 60, 4, 'Active', '2026-09-11 10:37:46', '2026-09-11 10:37:46', 'cleaning'),
(287, 'Bay 8', 60, 4, 'Active', '2026-09-11 10:37:47', '2026-09-11 10:37:47', 'cleaning'),
(288, 'bay 9', 60, 4, 'Active', '2026-09-11 10:37:47', '2026-09-11 10:37:47', 'cleaning'),
(289, 'Bay 10', 60, 4, 'Active', '2026-09-11 10:37:47', '2026-09-11 10:37:47', 'cleaning'),
(290, 'Bay 1', 61, 4, 'Active', '2026-09-11 10:37:47', '2026-09-11 10:37:47', 'cleaning'),
(291, 'Bay 2', 61, 4, 'Active', '2026-09-11 10:37:47', '2026-09-11 10:37:47', 'cleaning'),
(292, 'Bay 3', 61, 4, 'Active', '2026-09-11 10:37:47', '2026-09-11 10:37:47', 'cleaning'),
(293, 'Bay 4', 61, 4, 'Active', '2026-09-11 10:37:47', '2026-09-11 10:37:47', 'cleaning'),
(294, 'Bay 5', 61, 4, 'Active', '2026-09-11 10:37:47', '2026-09-11 10:37:47', 'cleaning'),
(295, 'Bay 6', 61, 4, 'Active', '2026-09-11 10:37:47', '2026-09-11 10:37:47', 'cleaning'),
(296, 'Bay 7', 61, 4, 'Active', '2026-09-11 10:37:48', '2026-09-11 10:37:48', 'cleaning'),
(297, 'Bay 8', 61, 4, 'Active', '2026-09-11 10:37:48', '2026-09-11 10:37:48', 'cleaning'),
(298, 'bay 9', 61, 4, 'Active', '2026-09-11 10:37:48', '2026-09-11 10:37:48', 'cleaning'),
(299, 'Bay 10', 61, 4, 'Active', '2026-09-11 10:37:48', '2026-09-11 10:37:48', 'cleaning'),
(300, 'Vacuum', 62, 4, 'Active', '2026-09-11 10:37:48', '2026-09-11 10:37:48', 'cleaning'),
(301, 'East Side', 63, 4, 'Active', '2026-09-11 10:37:48', '2026-09-11 10:37:48', 'cleaning'),
(302, 'West Side', 63, 4, 'Active', '2026-09-11 10:37:48', '2026-09-11 10:37:48', 'cleaning'),
(303, 'East Side', 64, 4, 'Active', '2026-09-11 10:37:48', '2026-09-11 10:37:48', 'cleaning'),
(304, 'West Side', 64, 4, 'Active', '2026-09-11 10:37:48', '2026-09-11 10:37:48', 'cleaning');

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
(6, 'Watering Status', 1, 'Active', '2026-06-12 06:40:03', '2026-06-12 06:40:03'),
(7, 'Coach Interior Cleaning', 4, 'Active', '2026-09-11 10:37:35', '2026-09-11 10:37:35'),
(8, 'Coach Exterior Cleaning', 4, 'Active', '2026-09-11 10:37:35', '2026-09-11 10:37:35'),
(9, 'Watering Status', 4, 'Active', '2026-09-11 10:37:35', '2026-09-11 10:37:35');

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
  `score_value` varchar(10) DEFAULT NULL,
  `auditor_name` varchar(255) DEFAULT NULL,
  `submitted_by` int(11) DEFAULT NULL,
  `report_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_scorecard_report`
--

INSERT INTO `mcc_intensive_scorecard_report` (`id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `auditor_name`, `submitted_by`, `report_date`, `created_at`, `updated_at`) VALUES
(1, 13, 4, 'TKN-20260912-424', '123456', 'C1', '3', 'SCL AUDITOR', NULL, '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 07:55:24'),
(2, 14, 4, 'TKN-20260912-424', '123456', 'C1', '3', 'SCL AUDITOR', NULL, '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 07:55:24'),
(3, 15, 4, 'TKN-20260912-424', '123456', 'C1', '3', 'SCL AUDITOR', NULL, '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 07:55:24'),
(4, 16, 4, 'TKN-20260912-424', '123456', 'C1', '3', 'SCL AUDITOR', NULL, '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 07:55:24'),
(5, 17, 4, 'TKN-20260912-424', '123456', 'C1', '3', 'SCL AUDITOR', NULL, '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:00:14'),
(6, 18, 4, 'TKN-20260912-424', '123456', 'C1', 'Y', 'SCL AUDITOR', NULL, '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:03:01');

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
  `input_type` varchar(50) DEFAULT 'cleaning',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_scorecard_sub_param`
--

INSERT INTO `mcc_intensive_scorecard_sub_param` (`id`, `sub_parameter_name`, `parameter_id`, `station_id`, `status`, `input_type`, `created_at`, `updated_at`) VALUES
(7, 'Cleaning and wiping of toilet area and fittings including wash basins, mirrors. Cleaning of mugs in AC coaches', 4, 1, 'Active', 'cleaning', '2026-06-12 06:40:03', '2026-06-12 06:40:03'),
(8, 'Interior Cleaning of compartments, doorways, gang ways, vestibules, Window glass, window shutter etc.', 4, 1, 'Active', 'cleaning', '2026-06-12 06:40:03', '2026-06-12 06:40:03'),
(9, 'Cleaning & wiping of all berths, Panels, Rexene & amenity fittings.', 4, 1, 'Active', 'cleaning', '2026-06-12 06:40:03', '2026-06-12 06:40:03'),
(10, 'Floor including area under seats/berths etc.', 4, 1, 'Active', 'cleaning', '2026-06-12 06:40:03', '2026-06-12 06:40:03'),
(11, 'Exterior Cleaning / washing including end panel', 5, 1, 'Active', 'cleaning', '2026-06-12 06:40:03', '2026-06-12 06:40:03'),
(12, 'Please mention Yes/ No', 6, 1, 'Active', 'watering', '2026-06-12 06:40:03', '2026-09-11 10:25:05'),
(13, 'Cleaning and wiping of toilet area and fittings including wash basins, mirrors. Cleaning of mugs in AC coaches', 7, 4, 'Active', 'cleaning', '2026-09-11 10:37:36', '2026-09-11 10:37:36'),
(14, 'Interior Cleaning of compartments, doorways, gang ways, vestibules, Window glass, window shutter etc.', 7, 4, 'Active', 'cleaning', '2026-09-11 10:37:36', '2026-09-11 10:37:36'),
(15, 'Cleaning & wiping of all berths, Panels, Rexene & amenity fittings.', 7, 4, 'Active', 'cleaning', '2026-09-11 10:37:36', '2026-09-11 10:37:36'),
(16, 'Floor including area under seats/berths etc.', 7, 4, 'Active', 'cleaning', '2026-09-11 10:37:36', '2026-09-11 10:37:36'),
(17, 'Exterior Cleaning / washing including end panel', 8, 4, 'Active', 'cleaning', '2026-09-11 10:37:36', '2026-09-11 10:37:36'),
(18, 'Please mention Yes/ No', 9, 4, 'Active', 'watering', '2026-09-11 10:37:36', '2026-09-11 10:37:36');

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
(21, 1, 'Vande Bharat', 5, 'Active', '2026-09-01 05:28:46'),
(22, 4, 'NORMAL CLEANING', 1, 'Active', '2026-09-12 08:21:28'),
(23, 4, 'EXTERNAL COACH CLEANING', 2, 'Active', '2026-09-12 08:21:28'),
(24, 4, 'INTENSIVE COACH CLEANING', 3, 'Active', '2026-09-12 08:21:28'),
(25, 4, 'PADLOCKING', 4, 'Active', '2026-09-12 08:21:28'),
(26, 4, 'CLEANING OF PITLINES AND DEPOT PREMISES', 5, 'Active', '2026-09-12 08:21:28'),
(27, 4, 'Watering and Internal dry cleaning of coaches for Platform Return Trains', 6, 'Active', '2026-09-12 08:21:28'),
(28, 4, 'Manpower Required for Undergear Cleaning', 7, 'Active', '2026-09-12 08:21:28'),
(29, 4, 'Changing & Cleaning of DB/IB at SCL Pit', 8, 'Active', '2026-09-12 08:21:28');

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
(8, 'Old-label, sticker and glue-mark remover', 'ml/coach', 1, '2026-05-25 12:18:12', '2026-08-26 07:51:10'),
(10, 'PVC floor-cleaning agent', 'ml/coach', 4, '2026-09-11 10:31:29', '2026-09-11 10:31:29'),
(11, 'Ceramic and stainless-steel toilet fittings cleaner', 'ml/coach', 4, '2026-09-11 10:31:29', '2026-09-11 10:31:29'),
(12, 'Glass-cleaning agent', 'ml/coach', 4, '2026-09-11 10:31:29', '2026-09-11 10:31:29'),
(13, 'Laminated plastic sheet and berth rexine cleaner', 'ml/coach', 4, '2026-09-11 10:31:29', '2026-09-11 10:31:29'),
(14, 'Painted-surface cleaner', 'ml/coach', 4, '2026-09-11 10:31:29', '2026-09-11 10:31:29'),
(15, 'Disinfectant', 'ml/coach', 4, '2026-09-11 10:31:29', '2026-09-11 10:31:29'),
(16, 'Air Freshener', 'ml/coach', 4, '2026-09-11 10:31:29', '2026-09-11 10:31:29'),
(17, 'Old-label, sticker and glue-mark remover', 'ml/coach', 4, '2026-09-11 10:31:30', '2026-09-11 10:31:30');

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
(112, 8, '05', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(113, 1, '01', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:48'),
(114, 2, '01', 40.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:48'),
(115, 3, '01', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:48'),
(116, 4, '01', 10.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:48'),
(117, 5, '01', 18.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:48'),
(118, 6, '01', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:48'),
(119, 7, '01', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:48'),
(120, 8, '01', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:48'),
(121, 1, '02', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:51'),
(122, 2, '02', 40.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:51'),
(123, 3, '02', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:51'),
(124, 4, '02', 10.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:51'),
(125, 5, '02', 18.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:51'),
(126, 6, '02', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:51'),
(127, 7, '02', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:51'),
(128, 8, '02', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:51'),
(129, 1, '03', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:55'),
(130, 2, '03', 40.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:55'),
(131, 3, '03', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:55'),
(132, 4, '03', 10.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:55'),
(133, 5, '03', 18.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:55'),
(134, 6, '03', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:55'),
(135, 7, '03', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:55'),
(136, 8, '03', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:55'),
(137, 1, '04', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:59'),
(138, 2, '04', 40.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:59'),
(139, 3, '04', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:59'),
(140, 4, '04', 10.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:59'),
(141, 5, '04', 18.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:59'),
(142, 6, '04', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:59'),
(143, 7, '04', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:59'),
(144, 8, '04', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:59'),
(145, 1, '05', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:20:03'),
(146, 2, '05', 40.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:20:03'),
(147, 3, '05', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:20:03'),
(148, 4, '05', 10.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:20:03'),
(149, 5, '05', 18.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:20:03'),
(150, 6, '05', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:20:03'),
(151, 7, '05', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:20:03'),
(152, 8, '05', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:20:03'),
(153, 1, '01', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:11'),
(154, 2, '01', 40.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:11'),
(155, 3, '01', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:11'),
(156, 4, '01', 10.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:11'),
(157, 5, '01', 18.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:11'),
(158, 6, '01', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:11'),
(159, 7, '01', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:11'),
(160, 8, '01', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:11'),
(161, 1, '02', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:16'),
(162, 2, '02', 40.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:16'),
(163, 3, '02', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:16'),
(164, 4, '02', 10.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:16'),
(165, 5, '02', 18.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:16'),
(166, 6, '02', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:16'),
(167, 7, '02', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:16'),
(168, 8, '02', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:16'),
(169, 1, '03', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:20'),
(170, 2, '03', 40.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:20'),
(171, 3, '03', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:20'),
(172, 4, '03', 10.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:20'),
(173, 5, '03', 18.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:20'),
(174, 6, '03', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:20'),
(175, 7, '03', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:20'),
(176, 8, '03', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:20'),
(177, 1, '04', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:23'),
(178, 2, '04', 40.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:23'),
(179, 3, '04', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:23'),
(180, 4, '04', 10.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:23'),
(181, 5, '04', 18.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:23'),
(182, 6, '04', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:23'),
(183, 7, '04', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:23'),
(184, 8, '04', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:23'),
(185, 1, '01', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:30'),
(186, 2, '01', 40.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:30'),
(187, 3, '01', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:30'),
(188, 4, '01', 10.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:30'),
(189, 5, '01', 18.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:30'),
(190, 6, '01', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:30'),
(191, 7, '01', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:30'),
(192, 8, '01', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:30'),
(193, 1, '02', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:33'),
(194, 2, '02', 40.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:33'),
(195, 3, '02', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:33'),
(196, 4, '02', 10.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:33'),
(197, 5, '02', 18.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:33'),
(198, 6, '02', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:33'),
(199, 7, '02', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:33'),
(200, 8, '02', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:33'),
(201, 1, '03', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:36'),
(202, 2, '03', 40.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:36'),
(203, 3, '03', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:36'),
(204, 4, '03', 10.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:36'),
(205, 5, '03', 18.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:36'),
(206, 6, '03', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:36'),
(207, 7, '03', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:36'),
(208, 8, '03', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:36'),
(209, 1, '04', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:40'),
(210, 2, '04', 40.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:40'),
(211, 3, '04', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:40'),
(212, 4, '04', 10.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:40'),
(213, 5, '04', 18.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:40'),
(214, 6, '04', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:40'),
(215, 7, '04', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:40'),
(216, 8, '04', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:40'),
(217, 1, '05', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:44'),
(218, 2, '05', 40.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:44'),
(219, 3, '05', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:44'),
(220, 4, '05', 10.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:44'),
(221, 5, '05', 18.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:44'),
(222, 6, '05', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:44'),
(223, 7, '05', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:44'),
(224, 8, '05', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:44'),
(225, 1, '01', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:50'),
(226, 2, '01', 40.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:50'),
(227, 3, '01', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:50'),
(228, 4, '01', 10.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:50'),
(229, 5, '01', 18.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:50'),
(230, 6, '01', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:50'),
(231, 7, '01', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:50'),
(232, 8, '01', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:50'),
(233, 1, '02', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:53'),
(234, 2, '02', 40.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:53'),
(235, 3, '02', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:53'),
(236, 4, '02', 10.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:53'),
(237, 5, '02', 18.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:53'),
(238, 6, '02', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:53'),
(239, 7, '02', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:53'),
(240, 8, '02', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:53'),
(241, 1, '03', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:57'),
(242, 2, '03', 40.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:57'),
(243, 3, '03', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:57'),
(244, 4, '03', 10.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:57'),
(245, 5, '03', 18.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:57'),
(246, 6, '03', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:57'),
(247, 7, '03', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:57'),
(248, 8, '03', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:57'),
(249, 1, '04', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:21:00'),
(250, 2, '04', 40.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:21:00'),
(251, 3, '04', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:21:00'),
(252, 4, '04', 10.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:21:00'),
(253, 5, '04', 18.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:21:00'),
(254, 6, '04', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:21:00'),
(255, 7, '04', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:21:00'),
(256, 8, '04', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:21:00'),
(257, 10, 'C1', 50.00, 'SCL AUDITOR', 4, 'TKN-20260912-852', '12345', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:41'),
(258, 11, 'C1', 40.00, 'SCL AUDITOR', 4, 'TKN-20260912-852', '12345', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:41'),
(259, 12, 'C1', 50.00, 'SCL AUDITOR', 4, 'TKN-20260912-852', '12345', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:41'),
(260, 13, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-20260912-852', '12345', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:41'),
(261, 14, 'C1', 18.00, 'SCL AUDITOR', 4, 'TKN-20260912-852', '12345', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:41'),
(262, 15, 'C1', 50.00, 'SCL AUDITOR', 4, 'TKN-20260912-852', '12345', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:41'),
(263, 16, 'C1', 50.00, 'SCL AUDITOR', 4, 'TKN-20260912-852', '12345', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:41'),
(264, 17, 'C1', 50.00, 'SCL AUDITOR', 4, 'TKN-20260912-852', '12345', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:41');

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
(8, 8, 50.00, 500.00, 1.00, 1, '2026-09-07 14:07:13', '2026-09-07 14:07:13', '2026-09-07', NULL),
(9, 10, 50.00, 500.00, 1.00, 4, '2026-09-11 10:31:30', '2026-09-11 10:31:30', '2026-09-07', NULL),
(10, 11, 40.00, 500.00, 1.00, 4, '2026-09-11 10:31:30', '2026-09-11 10:31:30', '2026-09-07', NULL),
(11, 12, 50.00, 500.00, 1.00, 4, '2026-09-11 10:31:30', '2026-09-11 10:31:30', '2026-09-07', NULL),
(12, 13, 10.00, 500.00, 1.00, 4, '2026-09-11 10:31:30', '2026-09-11 10:31:30', '2026-09-07', NULL),
(13, 14, 18.00, 500.00, 1.00, 4, '2026-09-11 10:31:31', '2026-09-11 10:31:31', '2026-09-07', NULL),
(14, 15, 50.00, 500.00, 1.00, 4, '2026-09-11 10:31:31', '2026-09-11 10:31:31', '2026-09-07', NULL),
(15, 16, 50.00, 500.00, 1.00, 4, '2026-09-11 10:31:31', '2026-09-11 10:31:31', '2026-09-07', NULL),
(16, 17, 50.00, 500.00, 1.00, 4, '2026-09-11 10:31:31', '2026-09-11 10:31:31', '2026-09-07', NULL);

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
(30, 'HHSD 6', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(31, 'PPSD 1', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:31:31', '2026-09-11 10:31:31'),
(32, 'PPSD 2', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:31:32', '2026-09-11 10:31:32'),
(33, 'PPSD 3', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:31:32', '2026-09-11 10:31:32'),
(34, 'PPSD 4', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:31:32', '2026-09-11 10:31:32'),
(35, 'PPSD 5', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:31:32', '2026-09-11 10:31:32'),
(36, 'PPSD 6', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:31:32', '2026-09-11 10:31:32'),
(37, 'PPSD 7', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:31:32', '2026-09-11 10:31:32'),
(38, 'PPSD 8', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:31:32', '2026-09-11 10:31:32'),
(39, 'PPSD 9', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:31:32', '2026-09-11 10:31:32'),
(40, 'HHSD 1', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:31:33', '2026-09-11 10:31:33'),
(41, 'HHSD 2', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:31:33', '2026-09-11 10:31:33'),
(42, 'HHSD 3', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:31:33', '2026-09-11 10:31:33'),
(43, 'HHSD 4', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:31:33', '2026-09-11 10:31:33'),
(44, 'HHSD 5', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:31:33', '2026-09-11 10:31:33'),
(45, 'HHSD 6', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:31:33', '2026-09-11 10:31:33');

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
(90, 30, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31'),
(91, 16, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19'),
(92, 17, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19'),
(93, 18, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19'),
(94, 19, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19'),
(95, 20, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19'),
(96, 21, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19'),
(97, 22, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19'),
(98, 23, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19'),
(99, 24, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19'),
(100, 25, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19'),
(101, 26, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19'),
(102, 27, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19'),
(103, 28, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19'),
(104, 29, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19'),
(105, 30, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19'),
(106, 16, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28'),
(107, 17, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28'),
(108, 18, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28'),
(109, 19, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28'),
(110, 20, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28'),
(111, 21, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28'),
(112, 22, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28'),
(113, 23, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28'),
(114, 24, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28'),
(115, 25, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28'),
(116, 26, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28'),
(117, 27, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28'),
(118, 28, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28'),
(119, 29, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28'),
(120, 30, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28'),
(121, 16, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37'),
(122, 17, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37'),
(123, 18, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37'),
(124, 19, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37'),
(125, 20, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37'),
(126, 21, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37'),
(127, 22, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37'),
(128, 23, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37'),
(129, 24, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37'),
(130, 25, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37'),
(131, 26, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37'),
(132, 27, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37'),
(133, 28, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37'),
(134, 29, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37'),
(135, 30, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37'),
(136, 31, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22'),
(137, 32, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22'),
(138, 33, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22'),
(139, 34, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22'),
(140, 35, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22'),
(141, 36, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22'),
(142, 37, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22'),
(143, 38, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22'),
(144, 39, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22'),
(145, 40, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22'),
(146, 41, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22'),
(147, 42, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22'),
(148, 43, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22'),
(149, 44, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22'),
(150, 45, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22'),
(151, 31, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27'),
(152, 32, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27'),
(153, 33, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27'),
(154, 34, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27'),
(155, 35, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27'),
(156, 36, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27'),
(157, 37, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27'),
(158, 38, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27'),
(159, 39, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27'),
(160, 40, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27'),
(161, 41, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27'),
(162, 42, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27'),
(163, 43, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27'),
(164, 44, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27'),
(165, 45, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27'),
(166, 31, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33'),
(167, 32, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33'),
(168, 33, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33'),
(169, 34, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33'),
(170, 35, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33'),
(171, 36, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33'),
(172, 37, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33'),
(173, 38, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33'),
(174, 39, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33'),
(175, 40, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33'),
(176, 41, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33'),
(177, 42, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33'),
(178, 43, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33'),
(179, 44, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33'),
(180, 45, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33');

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
(6, 'Shift 3', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(7, 'Shift 1', 4, '2026-09-11 10:31:34', '2026-09-11 10:31:34'),
(8, 'Shift 2', 4, '2026-09-11 10:31:34', '2026-09-11 10:31:34'),
(9, 'Shift 3', 4, '2026-09-11 10:31:34', '2026-09-11 10:31:34');

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
(45, 1, 30, 6, 'Y', 40.00, '2026-09-07 14:08:08', '2026-09-07 14:08:08', '2026-09-01', NULL),
(46, 4, 31, 7, 'Y', 500.00, '2026-09-11 10:31:34', '2026-09-11 10:31:34', '2026-09-01', NULL),
(47, 4, 31, 8, 'Y', 500.00, '2026-09-11 10:31:35', '2026-09-11 10:31:35', '2026-09-01', NULL),
(48, 4, 31, 9, 'Y', 500.00, '2026-09-11 10:31:35', '2026-09-11 10:31:35', '2026-09-01', NULL),
(49, 4, 32, 7, 'Y', 500.00, '2026-09-11 10:31:35', '2026-09-11 10:31:35', '2026-09-01', NULL),
(50, 4, 32, 8, 'Y', 500.00, '2026-09-11 10:31:35', '2026-09-11 10:31:35', '2026-09-01', NULL),
(51, 4, 32, 9, 'Y', 500.00, '2026-09-11 10:31:35', '2026-09-11 10:31:35', '2026-09-01', NULL),
(52, 4, 33, 7, 'Y', 500.00, '2026-09-11 10:31:35', '2026-09-11 10:31:35', '2026-09-01', NULL),
(53, 4, 33, 8, 'Y', 500.00, '2026-09-11 10:31:36', '2026-09-11 10:31:36', '2026-09-01', NULL),
(54, 4, 33, 9, 'Y', 500.00, '2026-09-11 10:31:36', '2026-09-11 10:31:36', '2026-09-01', NULL),
(55, 4, 34, 7, 'Y', 500.00, '2026-09-11 10:31:36', '2026-09-11 10:31:36', '2026-09-01', NULL),
(56, 4, 34, 8, 'Y', 500.00, '2026-09-11 10:31:36', '2026-09-11 10:31:36', '2026-09-01', NULL),
(57, 4, 34, 9, 'Y', 500.00, '2026-09-11 10:31:36', '2026-09-11 10:31:36', '2026-09-01', NULL),
(58, 4, 35, 7, 'Y', 500.00, '2026-09-11 10:31:36', '2026-09-11 10:31:36', '2026-09-01', NULL),
(59, 4, 35, 8, 'Y', 500.00, '2026-09-11 10:31:36', '2026-09-11 10:31:36', '2026-09-01', NULL),
(60, 4, 35, 9, 'Y', 500.00, '2026-09-11 10:31:36', '2026-09-11 10:31:36', '2026-09-01', NULL),
(61, 4, 36, 7, 'Y', 500.00, '2026-09-11 10:31:36', '2026-09-11 10:31:36', '2026-09-01', NULL),
(62, 4, 36, 8, 'Y', 500.00, '2026-09-11 10:31:37', '2026-09-11 10:31:37', '2026-09-01', NULL),
(63, 4, 36, 9, 'Y', 500.00, '2026-09-11 10:31:37', '2026-09-11 10:31:37', '2026-09-01', NULL),
(64, 4, 37, 7, 'Y', 500.00, '2026-09-11 10:31:37', '2026-09-11 10:31:37', '2026-09-01', NULL),
(65, 4, 37, 8, 'Y', 500.00, '2026-09-11 10:31:37', '2026-09-11 10:31:37', '2026-09-01', NULL),
(66, 4, 37, 9, 'Y', 500.00, '2026-09-11 10:31:37', '2026-09-11 10:31:37', '2026-09-01', NULL),
(67, 4, 38, 7, 'Y', 50.00, '2026-09-11 10:31:37', '2026-09-11 10:31:37', '2026-09-01', NULL),
(68, 4, 38, 8, 'Y', 50.00, '2026-09-11 10:31:37', '2026-09-11 10:31:37', '2026-09-01', NULL),
(69, 4, 38, 9, 'Y', 50.00, '2026-09-11 10:31:37', '2026-09-11 10:31:37', '2026-09-01', NULL),
(70, 4, 39, 7, 'Y', 50.00, '2026-09-11 10:31:38', '2026-09-11 10:31:38', '2026-09-01', NULL),
(71, 4, 39, 8, 'Y', 50.00, '2026-09-11 10:31:38', '2026-09-11 10:31:38', '2026-09-01', NULL),
(72, 4, 39, 9, 'Y', 50.00, '2026-09-11 10:31:38', '2026-09-11 10:31:38', '2026-09-01', NULL),
(73, 4, 40, 7, 'Y', 500.00, '2026-09-11 10:31:38', '2026-09-11 10:31:38', '2026-09-01', NULL),
(74, 4, 40, 8, 'Y', 500.00, '2026-09-11 10:31:38', '2026-09-11 10:31:38', '2026-09-01', NULL),
(75, 4, 40, 9, 'Y', 500.00, '2026-09-11 10:31:38', '2026-09-11 10:31:38', '2026-09-01', NULL),
(76, 4, 41, 7, 'Y', 50.00, '2026-09-11 10:31:38', '2026-09-11 10:31:38', '2026-09-01', NULL),
(77, 4, 41, 8, 'Y', 50.00, '2026-09-11 10:31:38', '2026-09-11 10:31:38', '2026-09-01', NULL),
(78, 4, 41, 9, 'Y', 50.00, '2026-09-11 10:31:38', '2026-09-11 10:31:38', '2026-09-01', NULL),
(79, 4, 42, 7, 'Y', 50.00, '2026-09-11 10:31:39', '2026-09-11 10:31:39', '2026-09-01', NULL),
(80, 4, 42, 8, 'Y', 50.00, '2026-09-11 10:31:39', '2026-09-11 10:31:39', '2026-09-01', NULL),
(81, 4, 42, 9, 'Y', 50.00, '2026-09-11 10:31:39', '2026-09-11 10:31:39', '2026-09-01', NULL),
(82, 4, 43, 7, 'Y', 500.00, '2026-09-11 10:31:39', '2026-09-11 10:31:39', '2026-09-01', NULL),
(83, 4, 43, 8, 'Y', 500.00, '2026-09-11 10:31:39', '2026-09-11 10:31:39', '2026-09-01', NULL),
(84, 4, 43, 9, 'Y', 500.00, '2026-09-11 10:31:39', '2026-09-11 10:31:39', '2026-09-01', NULL),
(85, 4, 44, 7, 'Y', 50.00, '2026-09-11 10:31:39', '2026-09-11 10:31:39', '2026-09-01', NULL),
(86, 4, 44, 8, 'Y', 50.00, '2026-09-11 10:31:39', '2026-09-11 10:31:39', '2026-09-01', NULL),
(87, 4, 44, 9, 'Y', 50.00, '2026-09-11 10:31:39', '2026-09-11 10:31:39', '2026-09-01', NULL),
(88, 4, 45, 7, 'Y', 40.00, '2026-09-11 10:31:40', '2026-09-11 10:31:40', '2026-09-01', NULL),
(89, 4, 45, 8, 'Y', 40.00, '2026-09-11 10:31:40', '2026-09-11 10:31:40', '2026-09-01', NULL),
(90, 4, 45, 9, 'Y', 40.00, '2026-09-11 10:31:40', '2026-09-11 10:31:40', '2026-09-01', NULL);

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
(6, 'Watering Status', 1, 'Active', '2026-06-12 06:32:00', '2026-06-12 06:32:00'),
(9, 'Coach Interior Cleaning', 4, 'Active', '2026-09-11 10:31:27', '2026-09-11 10:31:27'),
(10, 'Coach Exterior Cleaning', 4, 'Active', '2026-09-11 10:31:27', '2026-09-11 10:31:27'),
(11, 'Watering Status', 4, 'Active', '2026-09-11 10:31:27', '2026-09-11 10:31:27');

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
(84, 12, 1, 'TKN-20260908-892', '56202', '05', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19'),
(85, 7, 1, 'TKN-20260909-797', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:12:50'),
(86, 8, 1, 'TKN-20260909-797', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:12:50'),
(87, 9, 1, 'TKN-20260909-797', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:12:50'),
(88, 10, 1, 'TKN-20260909-797', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:12:50'),
(89, 11, 1, 'TKN-20260909-797', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:12:53'),
(90, 12, 1, 'TKN-20260909-797', '16236', '01', 'Y', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:12:56'),
(91, 7, 1, 'TKN-20260909-797', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:03'),
(92, 8, 1, 'TKN-20260909-797', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:03'),
(93, 9, 1, 'TKN-20260909-797', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:03'),
(94, 10, 1, 'TKN-20260909-797', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:03'),
(95, 11, 1, 'TKN-20260909-797', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:07'),
(96, 12, 1, 'TKN-20260909-797', '16236', '02', 'Y', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:10'),
(97, 7, 1, 'TKN-20260909-797', '16236', '03', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:15'),
(98, 8, 1, 'TKN-20260909-797', '16236', '03', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:15'),
(99, 9, 1, 'TKN-20260909-797', '16236', '03', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:15'),
(100, 10, 1, 'TKN-20260909-797', '16236', '03', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:15'),
(101, 11, 1, 'TKN-20260909-797', '16236', '03', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:17'),
(102, 12, 1, 'TKN-20260909-797', '16236', '03', 'Y', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:20'),
(103, 7, 1, 'TKN-20260909-797', '16236', '04', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:26'),
(104, 8, 1, 'TKN-20260909-797', '16236', '04', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:26'),
(105, 9, 1, 'TKN-20260909-797', '16236', '04', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:26'),
(106, 10, 1, 'TKN-20260909-797', '16236', '04', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:26'),
(107, 11, 1, 'TKN-20260909-797', '16236', '04', '2', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:30'),
(108, 12, 1, 'TKN-20260909-797', '16236', '04', 'Y', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:33'),
(109, 7, 1, 'TKN-20260909-797', '16236', '05', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:41'),
(110, 8, 1, 'TKN-20260909-797', '16236', '05', '2', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:41'),
(111, 9, 1, 'TKN-20260909-797', '16236', '05', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:41'),
(112, 10, 1, 'TKN-20260909-797', '16236', '05', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:41'),
(113, 11, 1, 'TKN-20260909-797', '16236', '05', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:46'),
(114, 12, 1, 'TKN-20260909-797', '16236', '05', 'Y', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:49'),
(115, 7, 1, 'TKN-20260909-562', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:41'),
(116, 8, 1, 'TKN-20260909-562', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:41'),
(117, 9, 1, 'TKN-20260909-562', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:41'),
(118, 10, 1, 'TKN-20260909-562', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:41'),
(119, 11, 1, 'TKN-20260909-562', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:44'),
(120, 12, 1, 'TKN-20260909-562', '22687', '01', 'Y', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:47'),
(121, 7, 1, 'TKN-20260909-562', '22687', '02', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:56'),
(122, 8, 1, 'TKN-20260909-562', '22687', '02', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:56'),
(123, 9, 1, 'TKN-20260909-562', '22687', '02', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:56'),
(124, 10, 1, 'TKN-20260909-562', '22687', '02', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:56'),
(125, 11, 1, 'TKN-20260909-562', '22687', '02', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:01'),
(126, 12, 1, 'TKN-20260909-562', '22687', '02', 'Y', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:03'),
(127, 7, 1, 'TKN-20260909-562', '22687', '03', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:10'),
(128, 8, 1, 'TKN-20260909-562', '22687', '03', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:10'),
(129, 9, 1, 'TKN-20260909-562', '22687', '03', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:10'),
(130, 10, 1, 'TKN-20260909-562', '22687', '03', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:10'),
(131, 11, 1, 'TKN-20260909-562', '22687', '03', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:13'),
(132, 12, 1, 'TKN-20260909-562', '22687', '03', 'Y', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:15'),
(133, 7, 1, 'TKN-20260909-562', '22687', '04', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:32'),
(134, 8, 1, 'TKN-20260909-562', '22687', '04', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:32'),
(135, 9, 1, 'TKN-20260909-562', '22687', '04', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:32'),
(136, 10, 1, 'TKN-20260909-562', '22687', '04', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:32'),
(137, 11, 1, 'TKN-20260909-562', '22687', '04', '1', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:24'),
(138, 12, 1, 'TKN-20260909-562', '22687', '04', 'Y', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:35'),
(139, 7, 1, 'TKN-20260909-404', '22681', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:31'),
(140, 8, 1, 'TKN-20260909-404', '22681', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:31'),
(141, 9, 1, 'TKN-20260909-404', '22681', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:31'),
(142, 10, 1, 'TKN-20260909-404', '22681', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:31'),
(143, 11, 1, 'TKN-20260909-404', '22681', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:33'),
(144, 12, 1, 'TKN-20260909-404', '22681', '01', 'Y', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:36'),
(145, 7, 1, 'TKN-20260909-404', '22681', '02', '2', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:43'),
(146, 8, 1, 'TKN-20260909-404', '22681', '02', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:43'),
(147, 9, 1, 'TKN-20260909-404', '22681', '02', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:43'),
(148, 10, 1, 'TKN-20260909-404', '22681', '02', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:43'),
(149, 11, 1, 'TKN-20260909-404', '22681', '02', '2', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:48'),
(150, 12, 1, 'TKN-20260909-404', '22681', '02', 'Y', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:50'),
(151, 7, 1, 'TKN-20260909-404', '22681', '03', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:55'),
(152, 8, 1, 'TKN-20260909-404', '22681', '03', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:55'),
(153, 9, 1, 'TKN-20260909-404', '22681', '03', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:55'),
(154, 10, 1, 'TKN-20260909-404', '22681', '03', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:55'),
(155, 11, 1, 'TKN-20260909-404', '22681', '03', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:58'),
(156, 12, 1, 'TKN-20260909-404', '22681', '03', 'Y', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:01'),
(157, 7, 1, 'TKN-20260909-404', '22681', '04', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:05'),
(158, 8, 1, 'TKN-20260909-404', '22681', '04', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:05'),
(159, 9, 1, 'TKN-20260909-404', '22681', '04', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:05'),
(160, 10, 1, 'TKN-20260909-404', '22681', '04', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:05'),
(161, 11, 1, 'TKN-20260909-404', '22681', '04', '2', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:09'),
(162, 12, 1, 'TKN-20260909-404', '22681', '04', 'Y', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:12'),
(163, 7, 1, 'TKN-20260909-404', '22681', '05', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:19'),
(164, 8, 1, 'TKN-20260909-404', '22681', '05', '2', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:19'),
(165, 9, 1, 'TKN-20260909-404', '22681', '05', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:19'),
(166, 10, 1, 'TKN-20260909-404', '22681', '05', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:19'),
(167, 11, 1, 'TKN-20260909-404', '22681', '05', '2', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:24'),
(168, 12, 1, 'TKN-20260909-404', '22681', '05', 'Y', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:26'),
(169, 7, 1, 'TKN-20260909-287', '16227', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:45'),
(170, 8, 1, 'TKN-20260909-287', '16227', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:45'),
(171, 9, 1, 'TKN-20260909-287', '16227', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:45'),
(172, 10, 1, 'TKN-20260909-287', '16227', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:45'),
(173, 11, 1, 'TKN-20260909-287', '16227', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:49'),
(174, 12, 1, 'TKN-20260909-287', '16227', '01', 'Y', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:52'),
(175, 7, 1, 'TKN-20260909-287', '16227', '02', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:58'),
(176, 8, 1, 'TKN-20260909-287', '16227', '02', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:58'),
(177, 9, 1, 'TKN-20260909-287', '16227', '02', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:58'),
(178, 10, 1, 'TKN-20260909-287', '16227', '02', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:58'),
(179, 11, 1, 'TKN-20260909-287', '16227', '02', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:01'),
(180, 12, 1, 'TKN-20260909-287', '16227', '02', 'Y', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:04'),
(181, 7, 1, 'TKN-20260909-287', '16227', '03', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:09'),
(182, 8, 1, 'TKN-20260909-287', '16227', '03', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:09'),
(183, 9, 1, 'TKN-20260909-287', '16227', '03', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:09'),
(184, 10, 1, 'TKN-20260909-287', '16227', '03', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:09'),
(185, 11, 1, 'TKN-20260909-287', '16227', '03', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:13'),
(186, 12, 1, 'TKN-20260909-287', '16227', '03', 'Y', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:16'),
(187, 7, 1, 'TKN-20260909-287', '16227', '04', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:21'),
(188, 8, 1, 'TKN-20260909-287', '16227', '04', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:21'),
(189, 9, 1, 'TKN-20260909-287', '16227', '04', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:21'),
(190, 10, 1, 'TKN-20260909-287', '16227', '04', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:21'),
(191, 11, 1, 'TKN-20260909-287', '16227', '04', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:26'),
(192, 12, 1, 'TKN-20260909-287', '16227', '04', 'Y', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:29'),
(193, 14, 4, 'TKN-20260912-852', '12345', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:05'),
(194, 15, 4, 'TKN-20260912-852', '12345', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:05'),
(195, 16, 4, 'TKN-20260912-852', '12345', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:05'),
(196, 17, 4, 'TKN-20260912-852', '12345', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:05'),
(197, 18, 4, 'TKN-20260912-852', '12345', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:08'),
(198, 19, 4, 'TKN-20260912-852', '12345', 'C1', 'Y', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:12');

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
(12, 'Please mention Yes/ No', 6, 1, 'Active', '2026-06-12 06:32:00', '2026-08-26 11:04:16', 'watering'),
(14, 'Cleaning and wiping of toilet area and fittings including wash basins, mirrors. Cleaning of mugs in AC coaches', 9, 4, 'Active', '2026-09-11 10:31:28', '2026-09-11 10:31:28', 'cleaning'),
(15, 'Interior Cleaning of compartments, doorways, gang ways, vestibules, Window glass, window shutter etc.', 9, 4, 'Active', '2026-09-11 10:31:28', '2026-09-11 10:31:28', 'cleaning'),
(16, 'Cleaning & wiping of all berths, Panels, Rexene & amenity fittings.', 9, 4, 'Active', '2026-09-11 10:31:28', '2026-09-11 10:31:28', 'cleaning'),
(17, 'Floor including area under seats/berths etc.', 9, 4, 'Active', '2026-09-11 10:31:28', '2026-09-11 10:31:28', 'cleaning'),
(18, 'Exterior Cleaning / washing including end panel', 10, 4, 'Active', '2026-09-11 10:31:28', '2026-09-11 10:31:28', 'cleaning'),
(19, 'Please mention Yes/ No', 11, 4, 'Active', '2026-09-11 10:31:28', '2026-09-11 10:31:28', 'watering');

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
(7, 'Old label, sticker and glue remover', 'ml', 1, '2026-06-09 12:56:20', '2026-08-31 12:00:17'),
(15, 'PVC floor-cleaning agent', 'ml', 4, '2026-09-11 10:43:24', '2026-09-11 10:43:24'),
(16, 'Ceramic and stainless-steel toilet fittings cleaner', 'ml', 4, '2026-09-11 10:43:24', '2026-09-11 10:43:24'),
(17, 'Glass cleaner', 'ml', 4, '2026-09-11 10:43:25', '2026-09-11 10:43:25'),
(18, 'Laminated plastic sheet and berth rexine cleaner', 'ml', 4, '2026-09-11 10:43:25', '2026-09-11 10:43:25'),
(19, 'Disinfectant', 'ml', 4, '2026-09-11 10:43:25', '2026-09-11 10:43:25'),
(20, 'Air Freshener', 'ml', 4, '2026-09-11 10:43:25', '2026-09-11 10:43:25'),
(21, 'Old label, sticker and glue remover', 'ml', 4, '2026-09-11 10:43:25', '2026-09-11 10:43:25');

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
(168, 7, '04', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:47'),
(169, 1, '01', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:34'),
(170, 2, '01', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:34'),
(171, 3, '01', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:34'),
(172, 4, '01', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:34'),
(173, 5, '01', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:34'),
(174, 6, '01', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:34'),
(175, 7, '01', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:34'),
(176, 1, '02', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:37'),
(177, 2, '02', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:37'),
(178, 3, '02', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:37'),
(179, 4, '02', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:37'),
(180, 5, '02', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:37'),
(181, 6, '02', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:37'),
(182, 7, '02', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:37'),
(183, 1, '03', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:41'),
(184, 2, '03', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:41'),
(185, 3, '03', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:41'),
(186, 4, '03', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:41'),
(187, 5, '03', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:41'),
(188, 6, '03', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:41'),
(189, 7, '03', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:41'),
(190, 1, '04', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:50'),
(191, 2, '04', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:50'),
(192, 3, '04', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:50'),
(193, 4, '04', 35.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:50'),
(194, 5, '04', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:50'),
(195, 6, '04', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:50'),
(196, 7, '04', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:50'),
(197, 1, '01', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:00'),
(198, 2, '01', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:00'),
(199, 3, '01', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:00'),
(200, 4, '01', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:00'),
(201, 5, '01', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:00'),
(202, 6, '01', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:00'),
(203, 7, '01', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:00'),
(204, 1, '02', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:03'),
(205, 2, '02', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:03'),
(206, 3, '02', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:03'),
(207, 4, '02', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:03'),
(208, 5, '02', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:03'),
(209, 6, '02', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:03'),
(210, 7, '02', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:03'),
(211, 1, '03', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:06'),
(212, 2, '03', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:06'),
(213, 3, '03', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:06'),
(214, 4, '03', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:06'),
(215, 5, '03', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:06'),
(216, 6, '03', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:06'),
(217, 7, '03', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:06'),
(218, 1, '04', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:10'),
(219, 2, '04', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:10'),
(220, 3, '04', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:10'),
(221, 4, '04', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:10'),
(222, 5, '04', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:10'),
(223, 6, '04', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:10'),
(224, 7, '04', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:10'),
(225, 1, '01', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:01'),
(226, 2, '01', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:01'),
(227, 3, '01', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:01'),
(228, 4, '01', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:01'),
(229, 5, '01', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:01'),
(230, 6, '01', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:01'),
(231, 7, '01', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:01'),
(232, 1, '02', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:16'),
(233, 2, '02', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:16'),
(234, 3, '02', 20.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:16'),
(235, 4, '02', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:16'),
(236, 5, '02', 35.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:16'),
(237, 6, '02', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:16'),
(238, 7, '02', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:16'),
(239, 1, '03', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:24'),
(240, 2, '03', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:24'),
(241, 3, '03', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:24'),
(242, 4, '03', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:24'),
(243, 5, '03', 15.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:24'),
(244, 6, '03', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:24'),
(245, 7, '03', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:24'),
(246, 1, '04', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:27'),
(247, 2, '04', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:27'),
(248, 3, '04', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:27'),
(249, 4, '04', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:27'),
(250, 5, '04', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:27'),
(251, 6, '04', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:27'),
(252, 7, '04', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:27'),
(253, 1, '05', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:31'),
(254, 2, '05', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:31'),
(255, 3, '05', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:31'),
(256, 4, '05', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:31'),
(257, 5, '05', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:31'),
(258, 6, '05', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:31'),
(259, 7, '05', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:31'),
(260, 1, '01', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:16'),
(261, 2, '01', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:16'),
(262, 3, '01', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:16'),
(263, 4, '01', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:16'),
(264, 5, '01', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:16'),
(265, 6, '01', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:16'),
(266, 7, '01', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:16'),
(267, 1, '02', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:20'),
(268, 2, '02', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:20'),
(269, 3, '02', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:20'),
(270, 4, '02', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:20'),
(271, 5, '02', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:20'),
(272, 6, '02', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:20'),
(273, 7, '02', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:20'),
(274, 1, '03', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:23'),
(275, 2, '03', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:23'),
(276, 3, '03', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:23'),
(277, 4, '03', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:23'),
(278, 5, '03', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:23'),
(279, 6, '03', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:23'),
(280, 7, '03', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:23'),
(281, 1, '04', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:27'),
(282, 2, '04', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:27'),
(283, 3, '04', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:27'),
(284, 4, '04', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:27'),
(285, 5, '04', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:27'),
(286, 6, '04', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:27'),
(287, 7, '04', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:27'),
(288, 1, 'C1', NULL, 'Bheem Chand', 1, 'TKN-PRT-20260912-131', '12345', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:21'),
(289, 2, 'C1', NULL, 'Bheem Chand', 1, 'TKN-PRT-20260912-131', '12345', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:21'),
(290, 3, 'C1', NULL, 'Bheem Chand', 1, 'TKN-PRT-20260912-131', '12345', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:21'),
(291, 4, 'C1', NULL, 'Bheem Chand', 1, 'TKN-PRT-20260912-131', '12345', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:21'),
(292, 5, 'C1', NULL, 'Bheem Chand', 1, 'TKN-PRT-20260912-131', '12345', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:21'),
(293, 6, 'C1', NULL, 'Bheem Chand', 1, 'TKN-PRT-20260912-131', '12345', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:21'),
(294, 7, 'C1', NULL, 'Bheem Chand', 1, 'TKN-PRT-20260912-131', '12345', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:21'),
(295, 15, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-PRT-20260912-918', '123456', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:04:04'),
(296, 16, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-PRT-20260912-918', '123456', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:04:04'),
(297, 17, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-PRT-20260912-918', '123456', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:04:04'),
(298, 18, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-PRT-20260912-918', '123456', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:04:04'),
(299, 19, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-PRT-20260912-918', '123456', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:04:04'),
(300, 20, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-PRT-20260912-918', '123456', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:04:04'),
(301, 21, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-PRT-20260912-918', '123456', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:04:04');

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
(7, 7, 10.00, 400.00, 5.00, 1, '2026-09-07 14:15:33', '2026-09-07 14:15:33', '2026-09-07', NULL),
(8, 15, 10.00, 200.00, 5.00, 4, '2026-09-11 10:43:26', '2026-09-11 10:43:26', '2026-09-07', NULL),
(9, 16, 10.00, 400.00, 5.00, 4, '2026-09-11 10:43:26', '2026-09-11 10:43:26', '2026-09-07', NULL),
(10, 17, 10.00, 500.00, 5.00, 4, '2026-09-11 10:43:26', '2026-09-11 10:43:26', '2026-09-07', NULL),
(11, 18, 10.00, 200.00, 5.00, 4, '2026-09-11 10:43:26', '2026-09-11 10:43:26', '2026-09-07', NULL),
(12, 19, 10.00, 600.00, 5.00, 4, '2026-09-11 10:43:26', '2026-09-11 10:43:26', '2026-09-07', NULL),
(13, 20, 10.00, 300.00, 5.00, 4, '2026-09-11 10:43:26', '2026-09-11 10:43:26', '2026-09-07', NULL),
(14, 21, 10.00, 400.00, 5.00, 4, '2026-09-11 10:43:26', '2026-09-11 10:43:26', '2026-09-07', NULL);

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
(30, 'HHSD 6', 'Hand held single disc electrically operated mini scrubber', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(31, 'PPSD 1', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:43:27', '2026-09-11 10:43:27'),
(32, 'PPSD 2', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:43:27', '2026-09-11 10:43:27'),
(33, 'PPSD 3', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:43:27', '2026-09-11 10:43:27'),
(34, 'PPSD 4', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:43:28', '2026-09-11 10:43:28'),
(35, 'PPSD 5', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:43:28', '2026-09-11 10:43:28'),
(36, 'PPSD 6', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:43:28', '2026-09-11 10:43:28'),
(37, 'PPSD 7', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:43:29', '2026-09-11 10:43:29'),
(38, 'PPSD 8', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:43:29', '2026-09-11 10:43:29'),
(39, 'PPSD 9', 'Portable powerd single disc floor scrubber/ mopper', 4, '2026-09-11 10:43:29', '2026-09-11 10:43:29'),
(40, 'HHSD 1', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:43:29', '2026-09-11 10:43:29'),
(41, 'HHSD 2', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:43:29', '2026-09-11 10:43:29'),
(42, 'HHSD 3', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:43:29', '2026-09-11 10:43:29'),
(43, 'HHSD 4', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:43:30', '2026-09-11 10:43:30'),
(44, 'HHSD 5', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:43:30', '2026-09-11 10:43:30'),
(45, 'HHSD 6', 'Hand held single disc electrically operated mini scrubber', 4, '2026-09-11 10:43:30', '2026-09-11 10:43:30');

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
(90, 30, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22'),
(91, 16, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51'),
(92, 17, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51'),
(93, 18, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51'),
(94, 19, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51'),
(95, 20, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51'),
(96, 21, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51'),
(97, 22, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51'),
(98, 23, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51'),
(99, 24, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51'),
(100, 25, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51'),
(101, 26, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51'),
(102, 27, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51'),
(103, 28, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51'),
(104, 29, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51'),
(105, 30, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51'),
(106, 16, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03'),
(107, 17, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03'),
(108, 18, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03'),
(109, 19, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03'),
(110, 20, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03'),
(111, 21, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03'),
(112, 22, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03'),
(113, 23, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03'),
(114, 24, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03'),
(115, 25, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03'),
(116, 26, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03'),
(117, 27, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03'),
(118, 28, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03'),
(119, 29, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03'),
(120, 30, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03'),
(121, 16, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15'),
(122, 17, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15'),
(123, 18, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15'),
(124, 19, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15'),
(125, 20, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15'),
(126, 21, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15'),
(127, 22, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15'),
(128, 23, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15'),
(129, 24, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15'),
(130, 25, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15'),
(131, 26, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15'),
(132, 27, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15'),
(133, 28, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15'),
(134, 29, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15'),
(135, 30, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15'),
(136, 16, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52'),
(137, 17, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52'),
(138, 18, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52'),
(139, 19, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52'),
(140, 20, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52'),
(141, 21, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52'),
(142, 22, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52'),
(143, 23, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52'),
(144, 24, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52'),
(145, 25, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52'),
(146, 26, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52'),
(147, 27, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52'),
(148, 28, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52'),
(149, 29, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52'),
(150, 30, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52'),
(151, 31, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14'),
(152, 32, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14'),
(153, 33, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14'),
(154, 34, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14'),
(155, 35, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14'),
(156, 36, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14'),
(157, 37, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14'),
(158, 38, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14'),
(159, 39, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14'),
(160, 40, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14'),
(161, 41, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14'),
(162, 42, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14'),
(163, 43, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14'),
(164, 44, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14'),
(165, 45, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14');

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
(6, 'Shift 3', 1, '2026-05-28 07:02:06', '2026-05-28 07:02:06'),
(7, 'Shift 1', 4, '2026-09-11 10:43:30', '2026-09-11 10:43:30'),
(8, 'Shift 2', 4, '2026-09-11 10:43:31', '2026-09-11 10:43:31'),
(9, 'Shift 3', 4, '2026-09-11 10:43:31', '2026-09-11 10:43:31');

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
(45, 1, 30, 6, 'Y', 500.00, '2026-09-08 06:40:21', '2026-09-08 06:40:21', '2026-09-01', NULL),
(46, 4, 31, 7, 'Y', 500.00, '2026-09-11 10:43:31', '2026-09-11 10:43:31', '2026-09-01', NULL),
(47, 4, 31, 8, 'Y', 500.00, '2026-09-11 10:43:31', '2026-09-11 10:43:31', '2026-09-01', NULL),
(48, 4, 31, 9, 'Y', 500.00, '2026-09-11 10:43:31', '2026-09-11 10:43:31', '2026-09-01', NULL),
(49, 4, 32, 7, 'Y', 500.00, '2026-09-11 10:43:31', '2026-09-11 10:43:31', '2026-09-01', NULL),
(50, 4, 32, 8, 'Y', 500.00, '2026-09-11 10:43:32', '2026-09-11 10:43:32', '2026-09-01', NULL),
(51, 4, 32, 9, 'Y', 500.00, '2026-09-11 10:43:32', '2026-09-11 10:43:32', '2026-09-01', NULL),
(52, 4, 33, 7, 'Y', 500.00, '2026-09-11 10:43:32', '2026-09-11 10:43:32', '2026-09-01', NULL),
(53, 4, 33, 8, 'Y', 500.00, '2026-09-11 10:43:32', '2026-09-11 10:43:32', '2026-09-01', NULL),
(54, 4, 33, 9, 'Y', 500.00, '2026-09-11 10:43:32', '2026-09-11 10:43:32', '2026-09-01', NULL),
(55, 4, 34, 7, 'Y', 500.00, '2026-09-11 10:43:32', '2026-09-11 10:43:32', '2026-09-01', NULL),
(56, 4, 34, 8, 'Y', 500.00, '2026-09-11 10:43:32', '2026-09-11 10:43:32', '2026-09-01', NULL),
(57, 4, 34, 9, 'Y', 500.00, '2026-09-11 10:43:32', '2026-09-11 10:43:32', '2026-09-01', NULL),
(58, 4, 35, 7, 'Y', 500.00, '2026-09-11 10:43:33', '2026-09-11 10:43:33', '2026-09-01', NULL),
(59, 4, 35, 8, 'Y', 500.00, '2026-09-11 10:43:33', '2026-09-11 10:43:33', '2026-09-01', NULL),
(60, 4, 35, 9, 'Y', 500.00, '2026-09-11 10:43:33', '2026-09-11 10:43:33', '2026-09-01', NULL),
(61, 4, 36, 7, 'Y', 500.00, '2026-09-11 10:43:33', '2026-09-11 10:43:33', '2026-09-01', NULL),
(62, 4, 36, 8, 'Y', 500.00, '2026-09-11 10:43:33', '2026-09-11 10:43:33', '2026-09-01', NULL),
(63, 4, 36, 9, 'Y', 500.00, '2026-09-11 10:43:33', '2026-09-11 10:43:33', '2026-09-01', NULL),
(64, 4, 37, 7, 'Y', 500.00, '2026-09-11 10:43:33', '2026-09-11 10:43:33', '2026-09-01', NULL),
(65, 4, 37, 8, 'Y', 500.00, '2026-09-11 10:43:33', '2026-09-11 10:43:33', '2026-09-01', NULL),
(66, 4, 37, 9, 'Y', 500.00, '2026-09-11 10:43:34', '2026-09-11 10:43:34', '2026-09-01', NULL),
(67, 4, 38, 7, 'Y', 500.00, '2026-09-11 10:43:34', '2026-09-11 10:43:34', '2026-09-01', NULL),
(68, 4, 38, 8, 'Y', 500.00, '2026-09-11 10:43:34', '2026-09-11 10:43:34', '2026-09-01', NULL),
(69, 4, 38, 9, 'Y', 500.00, '2026-09-11 10:43:34', '2026-09-11 10:43:34', '2026-09-01', NULL),
(70, 4, 39, 7, 'Y', 500.00, '2026-09-11 10:43:34', '2026-09-11 10:43:34', '2026-09-01', NULL),
(71, 4, 39, 8, 'Y', 500.00, '2026-09-11 10:43:34', '2026-09-11 10:43:34', '2026-09-01', NULL),
(72, 4, 39, 9, 'Y', 500.00, '2026-09-11 10:43:34', '2026-09-11 10:43:34', '2026-09-01', NULL),
(73, 4, 40, 7, 'Y', 500.00, '2026-09-11 10:43:35', '2026-09-11 10:43:35', '2026-09-01', NULL),
(74, 4, 40, 8, 'Y', 500.00, '2026-09-11 10:43:35', '2026-09-11 10:43:35', '2026-09-01', NULL),
(75, 4, 40, 9, 'Y', 500.00, '2026-09-11 10:43:35', '2026-09-11 10:43:35', '2026-09-01', NULL),
(76, 4, 41, 7, 'Y', 500.00, '2026-09-11 10:43:35', '2026-09-11 10:43:35', '2026-09-01', NULL),
(77, 4, 41, 8, 'Y', 500.00, '2026-09-11 10:43:35', '2026-09-11 10:43:35', '2026-09-01', NULL),
(78, 4, 41, 9, 'Y', 500.00, '2026-09-11 10:43:35', '2026-09-11 10:43:35', '2026-09-01', NULL),
(79, 4, 42, 7, 'Y', 500.00, '2026-09-11 10:43:35', '2026-09-11 10:43:35', '2026-09-01', NULL),
(80, 4, 42, 8, 'Y', 500.00, '2026-09-11 10:43:35', '2026-09-11 10:43:35', '2026-09-01', NULL),
(81, 4, 42, 9, 'Y', 500.00, '2026-09-11 10:43:36', '2026-09-11 10:43:36', '2026-09-01', NULL),
(82, 4, 43, 7, 'Y', 500.00, '2026-09-11 10:43:36', '2026-09-11 10:43:36', '2026-09-01', NULL),
(83, 4, 43, 8, 'Y', 500.00, '2026-09-11 10:43:36', '2026-09-11 10:43:36', '2026-09-01', NULL),
(84, 4, 43, 9, 'Y', 500.00, '2026-09-11 10:43:36', '2026-09-11 10:43:36', '2026-09-01', NULL),
(85, 4, 44, 7, 'Y', 500.00, '2026-09-11 10:43:36', '2026-09-11 10:43:36', '2026-09-01', NULL),
(86, 4, 44, 8, 'Y', 500.00, '2026-09-11 10:43:36', '2026-09-11 10:43:36', '2026-09-01', NULL),
(87, 4, 44, 9, 'Y', 500.00, '2026-09-11 10:43:36', '2026-09-11 10:43:36', '2026-09-01', NULL),
(88, 4, 45, 7, 'Y', 500.00, '2026-09-11 10:43:36', '2026-09-11 10:43:36', '2026-09-01', NULL),
(89, 4, 45, 8, 'Y', 500.00, '2026-09-11 10:43:36', '2026-09-11 10:43:36', '2026-09-01', NULL),
(90, 4, 45, 9, 'Y', 500.00, '2026-09-11 10:43:37', '2026-09-11 10:43:37', '2026-09-01', NULL);

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
(3, 'Watering of PFTR coaches', 1, 'Active', '2026-06-09 12:36:06', '2026-08-30 10:52:58'),
(7, 'Coach Interior Cleaning', 4, 'Active', '2026-09-11 10:43:22', '2026-09-11 10:43:22'),
(8, 'Watering of PFTR coaches', 4, 'Active', '2026-09-11 10:43:23', '2026-09-11 10:43:23');

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
(144, 7, 1, 'TKN-PRT-20260908-698', '16022', '04', 'Y', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:17'),
(145, 1, 1, 'TKN-PRT-20260909-298', '16232', '01', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:13'),
(146, 2, 1, 'TKN-PRT-20260909-298', '16232', '01', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:13'),
(147, 3, 1, 'TKN-PRT-20260909-298', '16232', '01', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:13'),
(148, 4, 1, 'TKN-PRT-20260909-298', '16232', '01', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:13'),
(149, 5, 1, 'TKN-PRT-20260909-298', '16232', '01', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:13'),
(150, 7, 1, 'TKN-PRT-20260909-298', '16232', '01', 'Y', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:16'),
(151, 1, 1, 'TKN-PRT-20260909-298', '16232', '02', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:21'),
(152, 2, 1, 'TKN-PRT-20260909-298', '16232', '02', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:21'),
(153, 3, 1, 'TKN-PRT-20260909-298', '16232', '02', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:21'),
(154, 4, 1, 'TKN-PRT-20260909-298', '16232', '02', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:21'),
(155, 5, 1, 'TKN-PRT-20260909-298', '16232', '02', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:21'),
(156, 7, 1, 'TKN-PRT-20260909-298', '16232', '02', 'Y', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:24'),
(157, 1, 1, 'TKN-PRT-20260909-298', '16232', '03', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:35'),
(158, 2, 1, 'TKN-PRT-20260909-298', '16232', '03', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:35'),
(159, 3, 1, 'TKN-PRT-20260909-298', '16232', '03', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:35'),
(160, 4, 1, 'TKN-PRT-20260909-298', '16232', '03', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:35'),
(161, 5, 1, 'TKN-PRT-20260909-298', '16232', '03', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:35'),
(162, 7, 1, 'TKN-PRT-20260909-298', '16232', '03', 'Y', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:38'),
(163, 1, 1, 'TKN-PRT-20260909-298', '16232', '04', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:45'),
(164, 2, 1, 'TKN-PRT-20260909-298', '16232', '04', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:45'),
(165, 3, 1, 'TKN-PRT-20260909-298', '16232', '04', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:45'),
(166, 4, 1, 'TKN-PRT-20260909-298', '16232', '04', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:45'),
(167, 5, 1, 'TKN-PRT-20260909-298', '16232', '04', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:45'),
(168, 7, 1, 'TKN-PRT-20260909-298', '16232', '04', 'Y', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:48'),
(169, 1, 1, 'TKN-PRT-20260909-755', '16595', '01', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:41:59'),
(170, 2, 1, 'TKN-PRT-20260909-755', '16595', '01', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:41:59'),
(171, 3, 1, 'TKN-PRT-20260909-755', '16595', '01', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:41:59'),
(172, 4, 1, 'TKN-PRT-20260909-755', '16595', '01', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:41:59'),
(173, 5, 1, 'TKN-PRT-20260909-755', '16595', '01', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:41:59'),
(174, 7, 1, 'TKN-PRT-20260909-755', '16595', '01', 'Y', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:11'),
(175, 1, 1, 'TKN-PRT-20260909-755', '16595', '02', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:21'),
(176, 2, 1, 'TKN-PRT-20260909-755', '16595', '02', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:21'),
(177, 3, 1, 'TKN-PRT-20260909-755', '16595', '02', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:21'),
(178, 4, 1, 'TKN-PRT-20260909-755', '16595', '02', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:21'),
(179, 5, 1, 'TKN-PRT-20260909-755', '16595', '02', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:21'),
(180, 7, 1, 'TKN-PRT-20260909-755', '16595', '02', 'Y', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:23'),
(181, 1, 1, 'TKN-PRT-20260909-755', '16595', '03', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:28'),
(182, 2, 1, 'TKN-PRT-20260909-755', '16595', '03', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:28'),
(183, 3, 1, 'TKN-PRT-20260909-755', '16595', '03', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:28'),
(184, 4, 1, 'TKN-PRT-20260909-755', '16595', '03', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:28'),
(185, 5, 1, 'TKN-PRT-20260909-755', '16595', '03', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:28'),
(186, 7, 1, 'TKN-PRT-20260909-755', '16595', '03', 'Y', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:31'),
(187, 1, 1, 'TKN-PRT-20260909-755', '16595', '04', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:40'),
(188, 2, 1, 'TKN-PRT-20260909-755', '16595', '04', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:40'),
(189, 3, 1, 'TKN-PRT-20260909-755', '16595', '04', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:40'),
(190, 4, 1, 'TKN-PRT-20260909-755', '16595', '04', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:40'),
(191, 5, 1, 'TKN-PRT-20260909-755', '16595', '04', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:40'),
(192, 7, 1, 'TKN-PRT-20260909-755', '16595', '04', 'Y', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:43'),
(193, 1, 1, 'TKN-PRT-20260909-754', '16592', '01', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:42:56'),
(194, 2, 1, 'TKN-PRT-20260909-754', '16592', '01', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:42:56'),
(195, 3, 1, 'TKN-PRT-20260909-754', '16592', '01', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:42:56'),
(196, 4, 1, 'TKN-PRT-20260909-754', '16592', '01', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:42:56'),
(197, 5, 1, 'TKN-PRT-20260909-754', '16592', '01', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:42:56'),
(198, 7, 1, 'TKN-PRT-20260909-754', '16592', '01', 'Y', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:42:59'),
(199, 1, 1, 'TKN-PRT-20260909-754', '16592', '02', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:38'),
(200, 2, 1, 'TKN-PRT-20260909-754', '16592', '02', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:38'),
(201, 3, 1, 'TKN-PRT-20260909-754', '16592', '02', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:38'),
(202, 4, 1, 'TKN-PRT-20260909-754', '16592', '02', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:38'),
(203, 5, 1, 'TKN-PRT-20260909-754', '16592', '02', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:38'),
(204, 7, 1, 'TKN-PRT-20260909-754', '16592', '02', 'Y', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:41'),
(205, 1, 1, 'TKN-PRT-20260909-754', '16592', '03', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:48'),
(206, 2, 1, 'TKN-PRT-20260909-754', '16592', '03', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:48'),
(207, 3, 1, 'TKN-PRT-20260909-754', '16592', '03', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:48'),
(208, 4, 1, 'TKN-PRT-20260909-754', '16592', '03', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:48'),
(209, 5, 1, 'TKN-PRT-20260909-754', '16592', '03', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:48'),
(210, 7, 1, 'TKN-PRT-20260909-754', '16592', '03', 'Y', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:50'),
(211, 1, 1, 'TKN-PRT-20260909-754', '16592', '04', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:56'),
(212, 2, 1, 'TKN-PRT-20260909-754', '16592', '04', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:56'),
(213, 3, 1, 'TKN-PRT-20260909-754', '16592', '04', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:56'),
(214, 4, 1, 'TKN-PRT-20260909-754', '16592', '04', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:56'),
(215, 5, 1, 'TKN-PRT-20260909-754', '16592', '04', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:56'),
(216, 7, 1, 'TKN-PRT-20260909-754', '16592', '04', 'Y', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:58'),
(217, 1, 1, 'TKN-PRT-20260909-754', '16592', '05', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:46:07'),
(218, 2, 1, 'TKN-PRT-20260909-754', '16592', '05', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:46:07'),
(219, 3, 1, 'TKN-PRT-20260909-754', '16592', '05', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:46:07'),
(220, 4, 1, 'TKN-PRT-20260909-754', '16592', '05', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:46:07'),
(221, 5, 1, 'TKN-PRT-20260909-754', '16592', '05', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:46:07'),
(222, 7, 1, 'TKN-PRT-20260909-754', '16592', '05', 'Y', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:46:10'),
(223, 1, 1, 'TKN-PRT-20260909-309', '12007', '01', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:24'),
(224, 2, 1, 'TKN-PRT-20260909-309', '12007', '01', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:24'),
(225, 3, 1, 'TKN-PRT-20260909-309', '12007', '01', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:24'),
(226, 4, 1, 'TKN-PRT-20260909-309', '12007', '01', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:24'),
(227, 5, 1, 'TKN-PRT-20260909-309', '12007', '01', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:24'),
(228, 7, 1, 'TKN-PRT-20260909-309', '12007', '01', 'Y', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:26'),
(229, 1, 1, 'TKN-PRT-20260909-309', '12007', '02', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:36'),
(230, 2, 1, 'TKN-PRT-20260909-309', '12007', '02', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:36'),
(231, 3, 1, 'TKN-PRT-20260909-309', '12007', '02', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:36'),
(232, 4, 1, 'TKN-PRT-20260909-309', '12007', '02', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:36'),
(233, 5, 1, 'TKN-PRT-20260909-309', '12007', '02', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:36'),
(234, 7, 1, 'TKN-PRT-20260909-309', '12007', '02', 'Y', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:39'),
(235, 1, 1, 'TKN-PRT-20260909-309', '12007', '03', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:46'),
(236, 2, 1, 'TKN-PRT-20260909-309', '12007', '03', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:46'),
(237, 3, 1, 'TKN-PRT-20260909-309', '12007', '03', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:46'),
(238, 4, 1, 'TKN-PRT-20260909-309', '12007', '03', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:46'),
(239, 5, 1, 'TKN-PRT-20260909-309', '12007', '03', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:46'),
(240, 7, 1, 'TKN-PRT-20260909-309', '12007', '03', 'Y', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:49'),
(241, 1, 1, 'TKN-PRT-20260909-309', '12007', '04', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:57'),
(242, 2, 1, 'TKN-PRT-20260909-309', '12007', '04', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:57'),
(243, 3, 1, 'TKN-PRT-20260909-309', '12007', '04', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:57'),
(244, 4, 1, 'TKN-PRT-20260909-309', '12007', '04', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:57'),
(245, 5, 1, 'TKN-PRT-20260909-309', '12007', '04', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:57'),
(246, 7, 1, 'TKN-PRT-20260909-309', '12007', '04', 'Y', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:47:00'),
(247, 1, 1, 'TKN-PRT-20260912-131', '12345', 'C1', '3', 'Bheem Chand', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:26'),
(248, 2, 1, 'TKN-PRT-20260912-131', '12345', 'C1', '3', 'Bheem Chand', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:26'),
(249, 3, 1, 'TKN-PRT-20260912-131', '12345', 'C1', '3', 'Bheem Chand', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:26'),
(250, 4, 1, 'TKN-PRT-20260912-131', '12345', 'C1', '3', 'Bheem Chand', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:26'),
(251, 5, 1, 'TKN-PRT-20260912-131', '12345', 'C1', '3', 'Bheem Chand', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:26'),
(252, 7, 1, 'TKN-PRT-20260912-131', '12345', 'C1', '', 'Bheem Chand', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:21'),
(253, 15, 4, 'TKN-PRT-20260912-918', '123456', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:03:48'),
(254, 16, 4, 'TKN-PRT-20260912-918', '123456', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:03:48'),
(255, 17, 4, 'TKN-PRT-20260912-918', '123456', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:03:48'),
(256, 18, 4, 'TKN-PRT-20260912-918', '123456', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:03:48'),
(257, 19, 4, 'TKN-PRT-20260912-918', '123456', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:03:48'),
(258, 20, 4, 'TKN-PRT-20260912-918', '123456', 'C1', 'Y', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:03:51');

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
(7, 'Watering', 3, 1, 'Active', '2026-06-09 12:36:06', '2026-09-08 06:43:10', 'watering'),
(15, 'Cleaning and wiping of toilet area and fittings including wash basins, Mirrors. Cleaning of mugs in AC coaches etc.', 7, 4, 'Active', '2026-09-11 10:43:23', '2026-09-11 10:43:23', 'cleaning'),
(16, 'Interior Cleaning of compartments, doorways, gangways, vestibules etc.', 7, 4, 'Active', '2026-09-11 10:43:23', '2026-09-11 10:43:23', 'cleaning'),
(17, 'Cleaning & wiping if required of all berths, panels, Rexene & Amenity fittings.', 7, 4, 'Active', '2026-09-11 10:43:23', '2026-09-11 10:43:23', 'cleaning'),
(18, 'Floor including area under the seats/berths etc. & wiping if required', 7, 4, 'Active', '2026-09-11 10:43:24', '2026-09-11 10:43:24', 'cleaning'),
(19, 'Disposal of garbage', 7, 4, 'Active', '2026-09-11 10:43:24', '2026-09-11 10:43:24', 'cleaning'),
(20, 'Watering', 8, 4, 'Active', '2026-09-11 10:43:24', '2026-09-11 10:43:24', 'watering');

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
(4, 'PFTA Cleaning', 'prt_cleaning', 1, 'Active', '2026-05-22 10:09:17', '2026-09-09 09:46:16'),
(5, 'Pantry Car', 'pantry_car', 1, 'Active', '2026-08-26 09:51:39', '2026-08-29 09:13:27'),
(6, 'Surprise Visit Audits', 'surprise_visit_audits', 1, 'Inactive', '2026-08-26 09:51:39', '2026-08-29 09:13:28'),
(7, 'Vande Bharat', 'vande_bharat_modules', 1, 'Active', '2026-08-26 09:51:40', '2026-08-29 12:23:20'),
(8, 'Attendance & Manpower', 'attendance_manpower', 1, 'Active', '2026-08-26 09:51:40', '2026-08-31 17:33:28'),
(9, 'Cleanliness Modules', 'cleanliness_modules', 1, 'Inactive', '2026-08-26 09:51:41', '2026-08-29 09:13:28'),
(10, 'Photo Reports', 'photo_reports', 1, 'Inactive', '2026-08-26 09:51:41', '2026-08-29 09:13:28'),
(11, 'Billing Management', 'billing_management', 1, 'Inactive', '2026-08-30 11:51:28', '2026-08-30 11:52:57'),
(12, 'Normal Cleaning', 'normal_cleaning', 4, 'Active', '2026-09-11 06:51:49', '2026-09-11 06:57:09'),
(13, 'Intensive Cleaning', 'intensive_cleaning', 4, 'Active', '2026-09-11 06:51:49', '2026-09-11 06:57:09'),
(14, 'PLDC Cleaning', 'dc_cleaning', 4, 'Active', '2026-09-11 06:51:50', '2026-09-12 08:49:37'),
(15, 'PFTA Cleaning', 'prt_cleaning', 4, 'Active', '2026-09-11 06:51:50', '2026-09-11 13:09:49'),
(16, 'Pantry Car', 'pantry_car', 4, 'Inactive', '2026-09-11 06:51:52', '2026-09-11 06:51:52'),
(17, 'Surprise Visit Audits', 'surprise_visit_audits', 4, 'Active', '2026-09-11 06:51:52', '2026-09-11 06:57:10'),
(18, 'Vande Bharat Modules', 'vande_bharat_modules', 4, 'Inactive', '2026-09-11 06:51:53', '2026-09-11 06:51:53'),
(19, 'Attendance & Manpower', 'attendance_manpower', 4, 'Active', '2026-09-11 06:51:53', '2026-09-12 08:22:18'),
(20, 'Cleanliness Modules', 'cleanliness_modules', 4, 'Inactive', '2026-09-11 06:51:54', '2026-09-11 06:51:54'),
(21, 'Photo Reports', 'photo_reports', 4, 'Inactive', '2026-09-11 06:51:54', '2026-09-11 06:51:54'),
(22, 'Billing Management', 'billing_management', 4, 'Inactive', '2026-09-11 06:51:54', '2026-09-11 06:51:54');

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
(1, 'Mysore', 102, 'Active', '2026-04-06 13:50:26', '2026-09-09 08:26:33', 'SMC Integrated Facility Management Solutions'),
(4, 'Silchar', 103, 'Active', '2026-09-11 06:37:23', '2026-09-11 06:37:23', 'Kingson Services');

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
(117, 1, 'prt_mach', '2026-08-28 10:49:50'),
(217, 4, 'normal_audit', '2026-09-12 08:49:37'),
(218, 4, 'normal_chem', '2026-09-12 08:49:37'),
(219, 4, 'normal_mach', '2026-09-12 08:49:37'),
(220, 4, 'int_audit', '2026-09-12 08:49:37'),
(221, 4, 'int_chem', '2026-09-12 08:49:37'),
(222, 4, 'int_mach', '2026-09-12 08:49:37'),
(223, 4, 'dc_audit', '2026-09-12 08:49:37'),
(224, 4, 'dc_chem', '2026-09-12 08:49:37'),
(225, 4, 'dc_mach', '2026-09-12 08:49:37'),
(226, 4, 'prt_audit', '2026-09-12 08:49:37'),
(227, 4, 'prt_chem', '2026-09-12 08:49:37'),
(228, 4, 'prt_mach', '2026-09-12 08:49:37'),
(229, 4, 'sur_pit', '2026-09-12 08:49:37'),
(230, 4, 'sur_pf', '2026-09-12 08:49:37'),
(231, 4, 'manpower', '2026-09-12 08:49:37');

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
(19, 'man-power-log.php', 'Man Power Log', 8, 'Inactive', '2026-08-26 09:51:44', '2026-09-09 13:16:15', 'man_power_log'),
(20, 'cleanliness.php', 'Cleanliness Scorecard', 9, 'Inactive', '2026-08-26 09:51:44', '2026-08-29 12:19:28', 'cleanliness_scorecard'),
(21, 'photo-report.php', 'Photo Report (Before/After)', 10, 'Inactive', '2026-08-26 09:51:45', '2026-08-29 12:19:28', 'photo_report'),
(22, 'Platform-Return-Machine.php', 'Machine Report', 4, 'Active', '2026-08-28 10:48:56', '2026-08-28 10:48:56', 'prt_machine'),
(23, 'pantry-chemical.php', 'Pantry Car Chemical', 5, 'Active', '2026-08-29 15:58:24', '2026-08-29 15:58:24', 'pantry_chemical'),
(24, 'pantry-machine.php', 'Pantry Car Machine', 5, 'Active', '2026-08-29 15:58:24', '2026-08-29 15:58:24', 'pantry_machine'),
(25, 'Billing.php', 'Billing Invoice', 11, 'Inactive', '2026-08-30 11:51:27', '2026-09-09 09:46:21', 'billing_invoice'),
(26, 'biometeric_manpower_log.php', 'Biometric', 8, 'Active', '2026-08-30 11:51:27', '2026-09-09 13:16:16', 'Biometric'),
(27, 'normal-report.php', 'Scorecard', 12, 'Active', '2026-09-11 06:51:49', '2026-09-11 06:58:15', 'normal_scorecard'),
(28, 'chemical-report.php', 'Chemical Report', 12, 'Active', '2026-09-11 06:51:49', '2026-09-11 06:58:15', 'normal_chemical'),
(29, 'machine-report.php', 'Machine Report', 12, 'Active', '2026-09-11 06:51:49', '2026-09-11 06:58:15', 'normal_machine'),
(30, 'intensive-report.php', 'Scorecard', 13, 'Active', '2026-09-11 06:51:49', '2026-09-11 13:06:27', 'intensive_scorecard'),
(31, 'intensive_scorecard_2.php', 'Scorecard', 13, 'Inactive', '2026-09-11 06:51:49', '2026-09-11 10:34:23', 'intensive_scorecard_2'),
(32, 'intensive-chemical-report.php', 'Chemical Report', 13, 'Active', '2026-09-11 06:51:49', '2026-09-11 06:58:16', 'intensive_chemical'),
(33, 'machine-report-intensive.php', 'Machine Report', 13, 'Active', '2026-09-11 06:51:50', '2026-09-11 06:58:16', 'intensive_machine'),
(34, 'DC-Scorecard.php', 'Scorecard', 14, 'Active', '2026-09-11 06:51:50', '2026-09-11 06:58:16', 'dc_scorecard'),
(35, 'dc-chemical.php', 'Chemical Report', 14, 'Active', '2026-09-11 06:51:50', '2026-09-11 06:58:16', 'dc_chemical'),
(36, 'dc-machine.php', 'Machine Report', 14, 'Active', '2026-09-11 06:51:50', '2026-09-11 06:58:16', 'dc_machine'),
(37, 'Platform-Return-TrainsScorecard.php', 'Scorecard', 15, 'Active', '2026-09-11 06:51:50', '2026-09-11 06:59:44', 'prt_scorecard'),
(38, 'Platform-Return-Chemical.php', 'Chemical Report', 15, 'Active', '2026-09-11 06:51:50', '2026-09-11 06:59:44', 'prt_chemical'),
(39, 'Platform-Return-Machine.php', 'Machine Report', 15, 'Active', '2026-09-11 06:51:51', '2026-09-11 06:59:44', 'prt_machine'),
(40, 'intensive_pantry_scorecard.php', 'Scorecard', 16, 'Inactive', '2026-09-11 06:51:52', '2026-09-11 06:51:52', 'intensive_pantry_scorecard'),
(41, 'pantry-chemical.php', 'Pantry Car Chemical', 16, 'Inactive', '2026-09-11 06:51:52', '2026-09-11 06:51:52', 'pantry_chemical'),
(42, 'pantry-machine.php', 'Pantry Car Machine', 16, 'Inactive', '2026-09-11 06:51:52', '2026-09-11 06:51:52', 'pantry_machine'),
(43, 'surprise-pit-office.php', 'Pit & Office Inspection', 17, 'Active', '2026-09-11 06:51:53', '2026-09-12 06:50:02', 'pit_office'),
(44, 'surprise-pf-trains.php', 'PF Return Trains Audit', 17, 'Active', '2026-09-11 06:51:53', '2026-09-12 06:49:56', 'pf_trains'),
(45, 'vande-bharat-report.php', 'Scorecard', 18, 'Inactive', '2026-09-11 06:51:53', '2026-09-11 06:51:53', 'vande_bharat_scorecard'),
(46, 'vande-bharat-chemical.php', 'Chemical Report', 18, 'Inactive', '2026-09-11 06:51:53', '2026-09-11 06:51:53', 'vande_bharat_chemical'),
(47, 'vande-bharat-machine.php', 'Machine Report', 18, 'Inactive', '2026-09-11 06:51:53', '2026-09-11 06:51:53', 'vande_bharat_machine'),
(48, 'man-power-log.php', 'Man Power Log', 19, 'Active', '2026-09-11 06:51:53', '2026-09-12 08:21:28', 'man_power_log'),
(49, 'biometeric_manpower_log.php', 'Bio Metric', 19, 'Inactive', '2026-09-11 06:51:54', '2026-09-11 06:51:54', 'biometric_manpower_log'),
(50, 'cleanliness.php', 'Cleanliness Scorecard', 20, 'Inactive', '2026-09-11 06:51:54', '2026-09-11 06:51:54', 'cleanliness_scorecard'),
(51, 'photo-report.php', 'Photo Report (Before/After)', 21, 'Inactive', '2026-09-11 06:51:54', '2026-09-11 06:51:54', 'photo_report'),
(52, 'Billing.php', 'Billing Invoice', 22, 'Inactive', '2026-09-11 06:51:54', '2026-09-11 06:51:54', 'billing_invoice');

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
(1, 'pit_office', 4, 'Staff as per contract Yardstick', 5, 'No. of staffs as per Contract vs staff available', 'Active', '2026-06-17 13:08:07'),
(2, 'pit_office', 4, 'Chemicals as per contract', 5, 'Availability as per contract', 'Active', '2026-06-17 13:08:07'),
(3, 'pit_office', 4, 'Staff in uniform', 5, 'Availability', 'Active', '2026-06-17 13:08:07'),
(4, 'pit_office', 4, 'Availability of tools as per contract', 5, 'Full / Partial / None', 'Active', '2026-06-17 13:08:07'),
(5, 'pit_office', 4, 'Quality of exterior cleaning', 5, 'Cleaning results', 'Active', '2026-06-17 13:08:07'),
(6, 'pit_office', 4, 'Quality of interior cleaning', 5, 'Cleaning results', 'Active', '2026-06-17 13:08:07'),
(7, 'pf_trains', 4, 'Availability of manpower as per contract', 5, 'No. of staffs as per Contract vs staff available', 'Active', '2026-06-17 13:08:07'),
(8, 'pf_trains', 4, 'Availability of tools & machinery as per contract', 5, 'Full / Partial / None', 'Active', '2026-06-17 13:08:07'),
(9, 'pf_trains', 4, 'Availability of chemicals', 5, 'Availability as per contract', 'Active', '2026-06-17 13:08:07'),
(10, 'pf_trains', 4, 'Quality of cleaning', 5, 'Cleaning results', 'Active', '2026-06-17 13:08:07'),
(11, 'pf_trains', 4, 'Full watering & padlocking done', 5, 'All coaches watered and padlocked from inside or by using a lock', 'Active', '2026-06-17 13:08:07');

-- --------------------------------------------------------

--
-- Table structure for table `mcc_surprise_ratings`
--

CREATE TABLE `mcc_surprise_ratings` (
  `id` int(11) NOT NULL,
  `station_id` int(11) NOT NULL DEFAULT 1,
  `rating_value` int(11) NOT NULL,
  `rating_name` varchar(150) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_surprise_ratings`
--

INSERT INTO `mcc_surprise_ratings` (`id`, `station_id`, `rating_value`, `rating_name`, `created_at`, `updated_at`) VALUES
(1, 1, 5, 'Excellent / No shortage', '2026-09-11 11:09:01', '2026-09-11 11:09:01'),
(2, 1, 4, 'Very Good / 1-10% shortage', '2026-09-11 11:09:02', '2026-09-11 11:09:02'),
(3, 1, 3, 'Good / Partially available', '2026-09-11 11:09:02', '2026-09-11 11:09:02'),
(4, 1, 2, '11-20% shortage', '2026-09-11 11:09:02', '2026-09-11 11:09:02'),
(5, 1, 1, 'Average', '2026-09-11 11:09:03', '2026-09-11 11:09:03'),
(6, 1, 0, 'Poor / Not available / Shortage > 20%', '2026-09-11 11:09:03', '2026-09-11 11:09:03'),
(7, 4, 5, 'Excellent / No shortage', '2026-09-11 11:09:03', '2026-09-11 11:09:03'),
(8, 4, 4, 'Very Good / 1-10% shortage', '2026-09-11 11:09:04', '2026-09-11 11:09:04'),
(9, 4, 3, 'Good / Partially available', '2026-09-11 11:09:04', '2026-09-11 11:09:04'),
(10, 4, 2, '11-20% shortage', '2026-09-11 11:09:04', '2026-09-11 11:09:04'),
(11, 4, 1, 'Average', '2026-09-11 11:09:04', '2026-09-11 11:09:04'),
(12, 4, 0, 'Poor / Not available / Shortage > 20%', '2026-09-11 11:09:05', '2026-09-11 11:09:05');

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
  `auditor_name` varchar(255) DEFAULT NULL,
  `parameter_id` int(11) NOT NULL,
  `value` tinyint(4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_surprise_reports`
--

INSERT INTO `mcc_surprise_reports` (`id`, `category`, `station_id`, `token_id`, `report_date`, `auditor_name`, `parameter_id`, `value`, `created_at`, `updated_at`) VALUES
(1, 'pit_office', 4, 'SV-PIT-CDO-001', '2026-09-10', 'CDO', 1, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(2, 'pit_office', 4, 'SV-PIT-CDO-001', '2026-09-10', 'CDO', 2, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(3, 'pit_office', 4, 'SV-PIT-CDO-001', '2026-09-10', 'CDO', 3, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(4, 'pit_office', 4, 'SV-PIT-CDO-001', '2026-09-10', 'CDO', 4, 3, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(5, 'pit_office', 4, 'SV-PIT-CDO-001', '2026-09-10', 'CDO', 5, 4, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(6, 'pit_office', 4, 'SV-PIT-CDO-001', '2026-09-10', 'CDO', 6, 4, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(7, 'pit_office', 4, 'SV-PIT-CDO-002', '2026-09-10', 'CDO', 1, 4, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(8, 'pit_office', 4, 'SV-PIT-CDO-002', '2026-09-10', 'CDO', 2, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(9, 'pit_office', 4, 'SV-PIT-CDO-002', '2026-09-10', 'CDO', 3, 3, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(10, 'pit_office', 4, 'SV-PIT-CDO-002', '2026-09-10', 'CDO', 4, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(11, 'pit_office', 4, 'SV-PIT-CDO-002', '2026-09-10', 'CDO', 5, 3, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(12, 'pit_office', 4, 'SV-PIT-CDO-002', '2026-09-10', 'CDO', 6, 3, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(13, 'pf_trains', 4, 'SV-PRT-12018-01', '2026-09-10', 'CDO', 7, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(14, 'pf_trains', 4, 'SV-PRT-12018-01', '2026-09-10', 'CDO', 8, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(15, 'pf_trains', 4, 'SV-PRT-12018-01', '2026-09-10', 'CDO', 9, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(16, 'pf_trains', 4, 'SV-PRT-12018-01', '2026-09-10', 'CDO', 10, 4, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(17, 'pf_trains', 4, 'SV-PRT-12018-01', '2026-09-10', 'CDO', 11, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(18, 'pf_trains', 4, 'SV-PRT-12056-01', '2026-09-10', 'CDO', 7, 4, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(19, 'pf_trains', 4, 'SV-PRT-12056-01', '2026-09-10', 'CDO', 8, 3, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(20, 'pf_trains', 4, 'SV-PRT-12056-01', '2026-09-10', 'CDO', 9, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(21, 'pf_trains', 4, 'SV-PRT-12056-01', '2026-09-10', 'CDO', 10, 3, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(22, 'pf_trains', 4, 'SV-PRT-12056-01', '2026-09-10', 'CDO', 11, 3, '2026-06-17 13:08:07', '2026-09-11 10:51:03'),
(23, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 1, 5, '2026-09-12 07:14:37', '2026-09-12 07:14:37'),
(24, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 2, 5, '2026-09-12 07:14:37', '2026-09-12 07:14:37'),
(25, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 3, 5, '2026-09-12 07:14:37', '2026-09-12 07:14:37'),
(26, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 4, 5, '2026-09-12 07:14:37', '2026-09-12 07:14:37'),
(27, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 5, 5, '2026-09-12 07:14:37', '2026-09-12 07:14:37'),
(28, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 6, 5, '2026-09-12 07:14:37', '2026-09-12 07:14:37'),
(29, 'pf_trains', 4, 'SV-PF-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 7, 5, '2026-09-12 07:15:06', '2026-09-12 07:15:06'),
(30, 'pf_trains', 4, 'SV-PF-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 8, 5, '2026-09-12 07:15:06', '2026-09-12 07:15:06'),
(31, 'pf_trains', 4, 'SV-PF-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 9, 5, '2026-09-12 07:15:06', '2026-09-12 07:15:06'),
(32, 'pf_trains', 4, 'SV-PF-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 10, 5, '2026-09-12 07:15:06', '2026-09-12 07:15:06'),
(33, 'pf_trains', 4, 'SV-PF-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 11, 5, '2026-09-12 07:15:06', '2026-09-12 07:15:06'),
(34, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-002', '2026-09-12', 'SCL AUDITOR', 1, 5, '2026-09-12 07:16:26', '2026-09-12 07:16:26'),
(35, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-002', '2026-09-12', 'SCL AUDITOR', 2, 5, '2026-09-12 07:16:26', '2026-09-12 07:16:26'),
(36, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-002', '2026-09-12', 'SCL AUDITOR', 3, 5, '2026-09-12 07:16:26', '2026-09-12 07:16:26'),
(37, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-002', '2026-09-12', 'SCL AUDITOR', 4, 5, '2026-09-12 07:16:26', '2026-09-12 07:16:26'),
(38, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-002', '2026-09-12', 'SCL AUDITOR', 5, 5, '2026-09-12 07:16:26', '2026-09-12 07:16:26'),
(39, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-002', '2026-09-12', 'SCL AUDITOR', 6, 5, '2026-09-12 07:16:26', '2026-09-12 07:16:26');

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
(12, 'SSE MYS', NULL, 'SSEMYS', 'AB@GMAIL.COM', '$2y$10$S7wsNB24l9VhmqV.WTXjfeFDm5n/Xw7rXDwpz7DK4zB1.bl.FCfge', 'SSE MYS', NULL, NULL, NULL, 'VIEWER', 1, NULL, NULL, 'Active', NULL, '2026-09-03 12:01:52', '2026-09-03 12:01:52'),
(13, 'SCL', NULL, 'SCL', 'scl@gmail.com', '$2y$10$F8pUlSeQetuhe5xbW2BU/.ZjIExVcXZRDyCaIqHeKjxouJVgQ1woe', NULL, NULL, NULL, NULL, 'CDO', 4, NULL, NULL, 'Active', NULL, '2026-09-11 06:39:50', '2026-09-11 06:39:50'),
(14, 'SCL AUDITOR', NULL, 'auditor', 'auditor@gmail.com', '$2y$10$jA2NMuvPbl74T/uJ0pH1S.3NpC9t6BV7bHJOCYxqC.XKovl/ClpeC', 'SCL AUDITOR', NULL, NULL, NULL, 'AUDITOR', 4, NULL, NULL, 'Active', NULL, '2026-09-11 10:50:32', '2026-09-11 10:50:32');

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
(112, 16, '08', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063'),
(113, 9, '01', 20.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:30', '20608'),
(114, 10, '01', 25.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:30', '20608'),
(115, 11, '01', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:30', '20608'),
(116, 12, '01', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:30', '20608'),
(117, 13, '01', 30.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:30', '20608'),
(118, 14, '01', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:30', '20608'),
(119, 15, '01', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:30', '20608'),
(120, 16, '01', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:30', '20608'),
(121, 9, '02', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:33', '20608'),
(122, 10, '02', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:33', '20608'),
(123, 11, '02', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:33', '20608'),
(124, 12, '02', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:33', '20608'),
(125, 13, '02', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:33', '20608'),
(126, 14, '02', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:33', '20608'),
(127, 15, '02', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:33', '20608'),
(128, 16, '02', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:33', '20608'),
(129, 9, '03', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:42', '20608'),
(130, 10, '03', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:42', '20608'),
(131, 11, '03', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:42', '20608'),
(132, 12, '03', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:42', '20608'),
(133, 13, '03', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:42', '20608'),
(134, 14, '03', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:42', '20608'),
(135, 15, '03', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:42', '20608'),
(136, 16, '03', 30.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:42', '20608'),
(137, 9, '04', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:45', '20608'),
(138, 10, '04', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:45', '20608'),
(139, 11, '04', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:45', '20608'),
(140, 12, '04', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:45', '20608'),
(141, 13, '04', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:45', '20608'),
(142, 14, '04', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:45', '20608'),
(143, 15, '04', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:45', '20608'),
(144, 16, '04', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:45', '20608');

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
(70, 12, 1, 'TKN-20260908-956', '22063', '08', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:26:04'),
(71, 7, 1, 'TKN-20260909-814', '20608', '01', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:30'),
(72, 8, 1, 'TKN-20260909-814', '20608', '01', '2', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:30'),
(73, 9, 1, 'TKN-20260909-814', '20608', '01', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:30'),
(74, 10, 1, 'TKN-20260909-814', '20608', '01', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:30'),
(75, 12, 1, 'TKN-20260909-814', '20608', '01', 'Y', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:33'),
(76, 7, 1, 'TKN-20260909-814', '20608', '02', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:39'),
(77, 8, 1, 'TKN-20260909-814', '20608', '02', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:39'),
(78, 9, 1, 'TKN-20260909-814', '20608', '02', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:39'),
(79, 10, 1, 'TKN-20260909-814', '20608', '02', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:39'),
(80, 12, 1, 'TKN-20260909-814', '20608', '02', 'Y', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:42'),
(81, 7, 1, 'TKN-20260909-814', '20608', '03', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:47'),
(82, 8, 1, 'TKN-20260909-814', '20608', '03', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:47'),
(83, 9, 1, 'TKN-20260909-814', '20608', '03', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:47'),
(84, 10, 1, 'TKN-20260909-814', '20608', '03', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:47'),
(85, 12, 1, 'TKN-20260909-814', '20608', '03', 'Y', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:50'),
(86, 7, 1, 'TKN-20260909-814', '20608', '04', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:56'),
(87, 8, 1, 'TKN-20260909-814', '20608', '04', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:56'),
(88, 9, 1, 'TKN-20260909-814', '20608', '04', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:56'),
(89, 10, 1, 'TKN-20260909-814', '20608', '04', '2', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:56'),
(90, 12, 1, 'TKN-20260909-814', '20608', '04', 'Y', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:59');

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
-- Indexes for table `biometric_manpower_target`
--
ALTER TABLE `biometric_manpower_target`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_station_cat_des_date` (`station_id`,`category_id`,`designation_name`,`target_date`),
  ADD KEY `station_id` (`station_id`),
  ADD KEY `target_date` (`target_date`);

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
-- Indexes for table `inventory_audit`
--
ALTER TABLE `inventory_audit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_audit_material` (`material_id`,`id`);

--
-- Indexes for table `inventory_entries`
--
ALTER TABLE `inventory_entries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_material_date` (`material_id`,`entry_date`),
  ADD KEY `idx_entries_date` (`entry_date`);

--
-- Indexes for table `inventory_materials`
--
ALTER TABLE `inventory_materials`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_station_name` (`station_id`,`name`),
  ADD KEY `idx_materials_station` (`station_id`);

--
-- Indexes for table `inventory_seeded_stations`
--
ALTER TABLE `inventory_seeded_stations`
  ADD PRIMARY KEY (`station_id`);

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
-- Indexes for table `mcc_designation`
--
ALTER TABLE `mcc_designation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_station_designation` (`station_id`,`designation_name`),
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
  ADD UNIQUE KEY `employee_id` (`employee_id`),
  ADD KEY `idx_station_id` (`station_id`);

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
-- Indexes for table `mcc_intensive_rating`
--
ALTER TABLE `mcc_intensive_rating`
  ADD PRIMARY KEY (`id`);

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
  ADD KEY `idx_intensive_sc_rep_date` (`report_date`);

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
-- Indexes for table `mcc_surprise_ratings`
--
ALTER TABLE `mcc_surprise_ratings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `station_id` (`station_id`);

--
-- Indexes for table `mcc_surprise_reports`
--
ALTER TABLE `mcc_surprise_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `station_id` (`station_id`),
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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `biometric_manpower_target`
--
ALTER TABLE `biometric_manpower_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `dc_mcc_chemical_param`
--
ALTER TABLE `dc_mcc_chemical_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `dc_mcc_chemical_report`
--
ALTER TABLE `dc_mcc_chemical_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `dc_mcc_chemical_shifts`
--
ALTER TABLE `dc_mcc_chemical_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `dc_mcc_chemical_target`
--
ALTER TABLE `dc_mcc_chemical_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `dc_mcc_machine_param`
--
ALTER TABLE `dc_mcc_machine_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `dc_mcc_machine_report`
--
ALTER TABLE `dc_mcc_machine_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `dc_mcc_machine_shifts`
--
ALTER TABLE `dc_mcc_machine_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `dc_mcc_machine_target`
--
ALTER TABLE `dc_mcc_machine_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `dc_mcc_param`
--
ALTER TABLE `dc_mcc_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `dc_mcc_rating`
--
ALTER TABLE `dc_mcc_rating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `dc_mcc_report`
--
ALTER TABLE `dc_mcc_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `dc_mcc_shifts`
--
ALTER TABLE `dc_mcc_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `inventory_audit`
--
ALTER TABLE `inventory_audit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `inventory_entries`
--
ALTER TABLE `inventory_entries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `inventory_materials`
--
ALTER TABLE `inventory_materials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

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
-- AUTO_INCREMENT for table `mcc_designation`
--
ALTER TABLE `mcc_designation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `mcc_divisions`
--
ALTER TABLE `mcc_divisions`
  MODIFY `division_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `mcc_employee`
--
ALTER TABLE `mcc_employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `mcc_imposed_penalties`
--
ALTER TABLE `mcc_imposed_penalties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `mcc_intensive_chemical_param`
--
ALTER TABLE `mcc_intensive_chemical_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `mcc_intensive_chemical_report`
--
ALTER TABLE `mcc_intensive_chemical_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- AUTO_INCREMENT for table `mcc_intensive_chemical_target`
--
ALTER TABLE `mcc_intensive_chemical_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `mcc_intensive_machine_param`
--
ALTER TABLE `mcc_intensive_machine_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `mcc_intensive_machine_report`
--
ALTER TABLE `mcc_intensive_machine_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `mcc_intensive_machine_shifts`
--
ALTER TABLE `mcc_intensive_machine_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `mcc_intensive_machine_target`
--
ALTER TABLE `mcc_intensive_machine_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_chemical_param`
--
ALTER TABLE `mcc_intensive_pantry_chemical_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_chemical_report`
--
ALTER TABLE `mcc_intensive_pantry_chemical_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_chemical_target`
--
ALTER TABLE `mcc_intensive_pantry_chemical_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_machine_param`
--
ALTER TABLE `mcc_intensive_pantry_machine_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_machine_report`
--
ALTER TABLE `mcc_intensive_pantry_machine_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_machine_shifts`
--
ALTER TABLE `mcc_intensive_pantry_machine_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_machine_target`
--
ALTER TABLE `mcc_intensive_pantry_machine_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_param`
--
ALTER TABLE `mcc_intensive_pantry_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_rating`
--
ALTER TABLE `mcc_intensive_pantry_rating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_report`
--
ALTER TABLE `mcc_intensive_pantry_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=148;

--
-- AUTO_INCREMENT for table `mcc_intensive_pantry_sub_param`
--
ALTER TABLE `mcc_intensive_pantry_sub_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=197;

--
-- AUTO_INCREMENT for table `mcc_intensive_rating`
--
ALTER TABLE `mcc_intensive_rating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mcc_intensive_scorecard_2_param`
--
ALTER TABLE `mcc_intensive_scorecard_2_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `mcc_intensive_scorecard_2_rating`
--
ALTER TABLE `mcc_intensive_scorecard_2_rating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mcc_intensive_scorecard_2_report`
--
ALTER TABLE `mcc_intensive_scorecard_2_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=989;

--
-- AUTO_INCREMENT for table `mcc_intensive_scorecard_2_sub_param`
--
ALTER TABLE `mcc_intensive_scorecard_2_sub_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=305;

--
-- AUTO_INCREMENT for table `mcc_intensive_scorecard_param`
--
ALTER TABLE `mcc_intensive_scorecard_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `mcc_intensive_scorecard_report`
--
ALTER TABLE `mcc_intensive_scorecard_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mcc_intensive_scorecard_sub_param`
--
ALTER TABLE `mcc_intensive_scorecard_sub_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `mcc_intensive_score_card`
--
ALTER TABLE `mcc_intensive_score_card`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=215;

--
-- AUTO_INCREMENT for table `mcc_manpower_categories`
--
ALTER TABLE `mcc_manpower_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `mcc_manpower_log`
--
ALTER TABLE `mcc_manpower_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `mcc_normal_chemical_report`
--
ALTER TABLE `mcc_normal_chemical_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=265;

--
-- AUTO_INCREMENT for table `mcc_normal_chemical_target`
--
ALTER TABLE `mcc_normal_chemical_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `mcc_normal_machine_param`
--
ALTER TABLE `mcc_normal_machine_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `mcc_normal_machine_report`
--
ALTER TABLE `mcc_normal_machine_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=181;

--
-- AUTO_INCREMENT for table `mcc_normal_machine_shifts`
--
ALTER TABLE `mcc_normal_machine_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `mcc_normal_machine_target`
--
ALTER TABLE `mcc_normal_machine_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `mcc_normal_rating`
--
ALTER TABLE `mcc_normal_rating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mcc_normal_scorecard_param`
--
ALTER TABLE `mcc_normal_scorecard_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `mcc_normal_scorecard_report`
--
ALTER TABLE `mcc_normal_scorecard_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=199;

--
-- AUTO_INCREMENT for table `mcc_normal_scorecard_sub_param`
--
ALTER TABLE `mcc_normal_scorecard_sub_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `mcc_prt_chemical_report`
--
ALTER TABLE `mcc_prt_chemical_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=302;

--
-- AUTO_INCREMENT for table `mcc_prt_chemical_target`
--
ALTER TABLE `mcc_prt_chemical_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `mcc_prt_machine_param`
--
ALTER TABLE `mcc_prt_machine_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `mcc_prt_machine_report`
--
ALTER TABLE `mcc_prt_machine_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=166;

--
-- AUTO_INCREMENT for table `mcc_prt_machine_shifts`
--
ALTER TABLE `mcc_prt_machine_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `mcc_prt_machine_target`
--
ALTER TABLE `mcc_prt_machine_target`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `mcc_prt_rating`
--
ALTER TABLE `mcc_prt_rating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mcc_prt_scorecard_param`
--
ALTER TABLE `mcc_prt_scorecard_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `mcc_prt_scorecard_report`
--
ALTER TABLE `mcc_prt_scorecard_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=259;

--
-- AUTO_INCREMENT for table `mcc_prt_scorecard_sub_param`
--
ALTER TABLE `mcc_prt_scorecard_sub_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `mcc_reports`
--
ALTER TABLE `mcc_reports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `mcc_stations`
--
ALTER TABLE `mcc_stations`
  MODIFY `station_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `mcc_station_reports`
--
ALTER TABLE `mcc_station_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=232;

--
-- AUTO_INCREMENT for table `mcc_subreports`
--
ALTER TABLE `mcc_subreports`
  MODIFY `subreport_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

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
-- AUTO_INCREMENT for table `mcc_surprise_ratings`
--
ALTER TABLE `mcc_surprise_ratings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `mcc_surprise_reports`
--
ALTER TABLE `mcc_surprise_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `mcc_users`
--
ALTER TABLE `mcc_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `mcc_vb_chemical_param`
--
ALTER TABLE `mcc_vb_chemical_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `mcc_vb_chemical_report`
--
ALTER TABLE `mcc_vb_chemical_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=145;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

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
-- Constraints for table `inventory_audit`
--
ALTER TABLE `inventory_audit`
  ADD CONSTRAINT `fk_inv_audit_material` FOREIGN KEY (`material_id`) REFERENCES `inventory_materials` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inventory_entries`
--
ALTER TABLE `inventory_entries`
  ADD CONSTRAINT `fk_inv_entries_material` FOREIGN KEY (`material_id`) REFERENCES `inventory_materials` (`id`);

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
-- Constraints for table `mcc_employee`
--
ALTER TABLE `mcc_employee`
  ADD CONSTRAINT `fk_mcc_employee_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

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
-- Constraints for table `mcc_surprise_ratings`
--
ALTER TABLE `mcc_surprise_ratings`
  ADD CONSTRAINT `fk_mcc_surprise_ratings_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

--
-- Constraints for table `mcc_surprise_reports`
--
ALTER TABLE `mcc_surprise_reports`
  ADD CONSTRAINT `mcc_surprise_reports_ibfk_1` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE,
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
