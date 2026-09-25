-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 22, 2026 at 04:02 PM
-- Server version: 10.11.19-MariaDB
-- PHP Version: 8.4.25

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
(1, '6.0.0', '2026-09-04 15:27:57', '2026-09-04 15:27:57');

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
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dc_mcc_chemical_report`
--

INSERT INTO `dc_mcc_chemical_report` (`id`, `parameter_id`, `shift_id`, `qty_used`, `auditor_name`, `station_id`, `token_id`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(1, 1, 1, 50.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:01', '2026-09-07 14:40:01', 0, NULL),
(2, 2, 1, 40.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:01', '2026-09-07 14:40:01', 0, NULL),
(3, 3, 1, 30.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:01', '2026-09-07 14:40:01', 0, NULL),
(4, 4, 1, 40.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:01', '2026-09-07 14:40:01', 0, NULL),
(5, 5, 1, 40.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:01', '2026-09-07 14:40:01', 0, NULL),
(6, 6, 1, 50.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:01', '2026-09-07 14:40:01', 0, NULL),
(7, 1, 2, 50.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:17', '2026-09-07 14:40:17', 0, NULL),
(8, 2, 2, 30.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:17', '2026-09-07 14:40:17', 0, NULL),
(9, 3, 2, 30.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:17', '2026-09-07 14:40:17', 0, NULL),
(10, 4, 2, 40.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:17', '2026-09-07 14:40:17', 0, NULL),
(11, 5, 2, 40.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:17', '2026-09-07 14:40:17', 0, NULL),
(12, 6, 2, 50.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:17', '2026-09-07 14:40:17', 0, NULL),
(13, 1, 3, 10.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:53', '2026-09-07 14:40:53', 0, NULL),
(14, 2, 3, 10.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:53', '2026-09-07 14:40:53', 0, NULL),
(15, 3, 3, 30.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:53', '2026-09-07 14:40:53', 0, NULL),
(16, 4, 3, 40.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:53', '2026-09-07 14:40:53', 0, NULL),
(17, 5, 3, 40.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:53', '2026-09-07 14:40:53', 0, NULL),
(18, 6, 3, 50.00, 'Bheem Chand', 1, 'TKN-DC-CHEM-20260907-027', '2026-09-07', '2026-09-07 14:40:53', '2026-09-07 14:40:53', 0, NULL),
(25, 21, 7, 50.00, 'SCL AUDITOR', 4, 'TKN-DC-CHEM-20260912-889', '2026-09-12', '2026-09-12 08:18:44', '2026-09-12 08:18:44', 0, NULL),
(26, 22, 7, 40.00, 'SCL AUDITOR', 4, 'TKN-DC-CHEM-20260912-889', '2026-09-12', '2026-09-12 08:18:44', '2026-09-12 08:18:44', 0, NULL),
(27, 23, 7, 30.00, 'SCL AUDITOR', 4, 'TKN-DC-CHEM-20260912-889', '2026-09-12', '2026-09-12 08:18:44', '2026-09-12 08:18:44', 0, NULL),
(28, 24, 7, 40.00, 'SCL AUDITOR', 4, 'TKN-DC-CHEM-20260912-889', '2026-09-12', '2026-09-12 08:18:44', '2026-09-12 08:18:44', 0, NULL),
(29, 25, 7, 40.00, 'SCL AUDITOR', 4, 'TKN-DC-CHEM-20260912-889', '2026-09-12', '2026-09-12 08:18:44', '2026-09-12 08:18:44', 0, NULL),
(30, 26, 7, 50.00, 'SCL AUDITOR', 4, 'TKN-DC-CHEM-20260912-889', '2026-09-12', '2026-09-12 08:18:44', '2026-09-12 08:18:44', 0, NULL);

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
  `updated_at` timestamp NULL DEFAULT current_timestamp(),
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dc_mcc_machine_report`
--

INSERT INTO `dc_mcc_machine_report` (`id`, `parameter_id`, `shift_id`, `used_status`, `token_id`, `auditor_name`, `station_id`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(1, 1, 1, 'Y', 'TKN-DC-MCH-20260907-1-6003', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:41:16', '2026-09-07 14:41:16', 0, NULL),
(2, 2, 1, 'N', 'TKN-DC-MCH-20260907-1-6003', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:41:16', '2026-09-07 14:41:16', 0, NULL),
(3, 1, 2, 'Y', 'TKN-DC-MCH-20260907-2-2816', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:41:49', '2026-09-07 14:41:49', 0, NULL),
(4, 2, 2, 'Y', 'TKN-DC-MCH-20260907-2-2816', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:41:49', '2026-09-07 14:41:49', 0, NULL),
(5, 1, 3, 'Y', 'TKN-DC-MCH-20260907-3-7067', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:41:53', '2026-09-07 14:41:53', 0, NULL),
(6, 2, 3, 'Y', 'TKN-DC-MCH-20260907-3-7067', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:41:53', '2026-09-07 14:41:53', 0, NULL),
(7, 4, 4, 'Y', 'TKN-DC-MCH-20260912-4-8618', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:19:03', '2026-09-12 08:19:03', 0, NULL),
(8, 5, 4, 'Y', 'TKN-DC-MCH-20260912-4-8618', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:19:03', '2026-09-12 08:19:03', 0, NULL),
(9, 1, 2, 'Y', 'TKN-DC-MCH-20260915-2-8585', 'bheem123', 1, '2026-09-15', '2026-09-15 16:58:43', '2026-09-15 16:58:43', 0, NULL),
(10, 2, 2, 'Y', 'TKN-DC-MCH-20260915-2-8585', 'bheem123', 1, '2026-09-15', '2026-09-15 16:58:43', '2026-09-15 16:58:43', 0, NULL);

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
  `auditor_name` varchar(255) DEFAULT NULL,
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dc_mcc_report`
--

INSERT INTO `dc_mcc_report` (`id`, `parameter_id`, `shift_id`, `rating`, `token_id`, `station_id`, `report_date`, `created_at`, `updated_at`, `auditor_name`, `isApproved`, `audit_by`) VALUES
(1, 11, 1, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:27', '2026-09-07 14:39:27', 'Bheem Chand', 0, NULL),
(2, 12, 1, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:27', '2026-09-07 14:39:27', 'Bheem Chand', 0, NULL),
(3, 13, 1, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:27', '2026-09-07 14:39:27', 'Bheem Chand', 0, NULL),
(4, 14, 1, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:27', '2026-09-07 14:39:27', 'Bheem Chand', 0, NULL),
(5, 15, 1, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:27', '2026-09-07 14:39:27', 'Bheem Chand', 0, NULL),
(6, 16, 1, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:27', '2026-09-07 14:39:27', 'Bheem Chand', 0, NULL),
(7, 17, 1, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:27', '2026-09-07 14:39:27', 'Bheem Chand', 0, NULL),
(8, 18, 1, 1, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:27', '2026-09-07 14:39:27', 'Bheem Chand', 0, NULL),
(9, 19, 1, 2, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:27', '2026-09-07 14:39:27', 'Bheem Chand', 0, NULL),
(10, 11, 2, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:39', '2026-09-07 14:39:39', 'Bheem Chand', 0, NULL),
(11, 12, 2, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:39', '2026-09-07 14:39:39', 'Bheem Chand', 0, NULL),
(12, 13, 2, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:39', '2026-09-07 14:39:39', 'Bheem Chand', 0, NULL),
(13, 14, 2, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:39', '2026-09-07 14:39:39', 'Bheem Chand', 0, NULL),
(14, 15, 2, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:39', '2026-09-07 14:39:39', 'Bheem Chand', 0, NULL),
(15, 16, 2, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:39', '2026-09-07 14:39:39', 'Bheem Chand', 0, NULL),
(16, 17, 2, 2, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:39', '2026-09-07 14:39:39', 'Bheem Chand', 0, NULL),
(17, 18, 2, 3, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:39', '2026-09-07 14:39:39', 'Bheem Chand', 0, NULL),
(18, 19, 2, 1, 'TKN-DC-20260907-969', 1, '2026-09-07', '2026-09-07 14:39:39', '2026-09-07 14:39:39', 'Bheem Chand', 0, NULL),
(19, 11, 1, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:45', '2026-09-08 13:16:45', 'Bheem Chand', 0, NULL),
(20, 12, 1, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:45', '2026-09-08 13:16:45', 'Bheem Chand', 0, NULL),
(21, 13, 1, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:45', '2026-09-08 13:16:45', 'Bheem Chand', 0, NULL),
(22, 14, 1, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:45', '2026-09-08 13:16:45', 'Bheem Chand', 0, NULL),
(23, 15, 1, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:45', '2026-09-08 13:16:45', 'Bheem Chand', 0, NULL),
(24, 16, 1, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:45', '2026-09-08 13:16:45', 'Bheem Chand', 0, NULL),
(25, 17, 1, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:45', '2026-09-08 13:16:45', 'Bheem Chand', 0, NULL),
(26, 18, 1, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:45', '2026-09-08 13:16:45', 'Bheem Chand', 0, NULL),
(27, 19, 1, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:45', '2026-09-08 13:16:45', 'Bheem Chand', 0, NULL),
(28, 11, 2, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:51', '2026-09-08 13:16:51', 'Bheem Chand', 0, NULL),
(29, 12, 2, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:51', '2026-09-08 13:16:51', 'Bheem Chand', 0, NULL),
(30, 13, 2, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:51', '2026-09-08 13:16:51', 'Bheem Chand', 0, NULL),
(31, 14, 2, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:51', '2026-09-08 13:16:51', 'Bheem Chand', 0, NULL),
(32, 15, 2, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:51', '2026-09-08 13:16:51', 'Bheem Chand', 0, NULL),
(33, 16, 2, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:51', '2026-09-08 13:16:51', 'Bheem Chand', 0, NULL),
(34, 17, 2, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:51', '2026-09-08 13:16:51', 'Bheem Chand', 0, NULL),
(35, 18, 2, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:51', '2026-09-08 13:16:51', 'Bheem Chand', 0, NULL),
(36, 19, 2, 3, 'TKN-DC-20260908-884', 1, '2026-09-08', '2026-09-08 13:16:51', '2026-09-08 13:16:51', 'Bheem Chand', 0, NULL),
(37, 11, 1, 2, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:10', '2026-09-09 07:36:10', 'Shivkumar', 0, NULL),
(38, 12, 1, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:10', '2026-09-09 07:36:10', 'Shivkumar', 0, NULL),
(39, 13, 1, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:10', '2026-09-09 07:36:10', 'Shivkumar', 0, NULL),
(40, 14, 1, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:10', '2026-09-09 07:36:10', 'Shivkumar', 0, NULL),
(41, 15, 1, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:10', '2026-09-09 07:36:10', 'Shivkumar', 0, NULL),
(42, 16, 1, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:10', '2026-09-09 07:36:10', 'Shivkumar', 0, NULL),
(43, 17, 1, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:10', '2026-09-09 07:36:10', 'Shivkumar', 0, NULL),
(44, 18, 1, 2, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:10', '2026-09-09 07:36:10', 'Shivkumar', 0, NULL),
(45, 19, 1, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:10', '2026-09-09 07:36:10', 'Shivkumar', 0, NULL),
(46, 11, 2, 2, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:26', '2026-09-09 07:36:26', 'Shivkumar', 0, NULL),
(47, 12, 2, 2, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:26', '2026-09-09 07:36:26', 'Shivkumar', 0, NULL),
(48, 13, 2, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:26', '2026-09-09 07:36:26', 'Shivkumar', 0, NULL),
(49, 14, 2, 2, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:26', '2026-09-09 07:36:26', 'Shivkumar', 0, NULL),
(50, 15, 2, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:26', '2026-09-09 07:36:26', 'Shivkumar', 0, NULL),
(51, 16, 2, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:26', '2026-09-09 07:36:26', 'Shivkumar', 0, NULL),
(52, 17, 2, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:26', '2026-09-09 07:36:26', 'Shivkumar', 0, NULL),
(53, 18, 2, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:26', '2026-09-09 07:36:26', 'Shivkumar', 0, NULL),
(54, 19, 2, 3, 'TKN-DC-20260909-241', 1, '2026-09-09', '2026-09-09 07:36:26', '2026-09-09 07:36:26', 'Shivkumar', 0, NULL),
(73, 20, 4, 3, 'TKN-DC-20260912-548', 4, '2026-09-12', '2026-09-12 08:18:12', '2026-09-12 08:18:12', 'SCL AUDITOR', 0, NULL),
(74, 21, 4, 3, 'TKN-DC-20260912-548', 4, '2026-09-12', '2026-09-12 08:18:12', '2026-09-12 08:18:12', 'SCL AUDITOR', 0, NULL),
(75, 22, 4, 3, 'TKN-DC-20260912-548', 4, '2026-09-12', '2026-09-12 08:18:12', '2026-09-12 08:18:12', 'SCL AUDITOR', 0, NULL),
(76, 23, 4, 3, 'TKN-DC-20260912-548', 4, '2026-09-12', '2026-09-12 08:18:12', '2026-09-12 08:18:12', 'SCL AUDITOR', 0, NULL),
(77, 24, 4, 3, 'TKN-DC-20260912-548', 4, '2026-09-12', '2026-09-12 08:18:12', '2026-09-12 08:18:12', 'SCL AUDITOR', 0, NULL),
(78, 25, 4, 3, 'TKN-DC-20260912-548', 4, '2026-09-12', '2026-09-12 08:18:12', '2026-09-12 08:18:12', 'SCL AUDITOR', 0, NULL),
(79, 26, 4, 3, 'TKN-DC-20260912-548', 4, '2026-09-12', '2026-09-12 08:18:12', '2026-09-12 08:18:12', 'SCL AUDITOR', 0, NULL),
(80, 27, 4, 3, 'TKN-DC-20260912-548', 4, '2026-09-12', '2026-09-12 08:18:12', '2026-09-12 08:18:12', 'SCL AUDITOR', 0, NULL),
(81, 28, 4, 3, 'TKN-DC-20260912-548', 4, '2026-09-12', '2026-09-12 08:18:12', '2026-09-12 08:18:12', 'SCL AUDITOR', 0, NULL),
(82, 11, 1, 3, 'TKN-DC-20260912-830', 1, '2026-09-12', '2026-09-12 11:44:48', '2026-09-12 11:44:48', 'bheem123', 0, NULL),
(83, 12, 1, 3, 'TKN-DC-20260912-830', 1, '2026-09-12', '2026-09-12 11:44:48', '2026-09-12 11:44:48', 'bheem123', 0, NULL),
(84, 13, 1, 3, 'TKN-DC-20260912-830', 1, '2026-09-12', '2026-09-12 11:44:48', '2026-09-12 11:44:48', 'bheem123', 0, NULL),
(85, 14, 1, 3, 'TKN-DC-20260912-830', 1, '2026-09-12', '2026-09-12 11:44:48', '2026-09-12 11:44:48', 'bheem123', 0, NULL),
(86, 15, 1, 3, 'TKN-DC-20260912-830', 1, '2026-09-12', '2026-09-12 11:44:48', '2026-09-12 11:44:48', 'bheem123', 0, NULL),
(87, 16, 1, 3, 'TKN-DC-20260912-830', 1, '2026-09-12', '2026-09-12 11:44:48', '2026-09-12 11:44:48', 'bheem123', 0, NULL),
(88, 17, 1, 3, 'TKN-DC-20260912-830', 1, '2026-09-12', '2026-09-12 11:44:48', '2026-09-12 11:44:48', 'bheem123', 0, NULL),
(89, 18, 1, 3, 'TKN-DC-20260912-830', 1, '2026-09-12', '2026-09-12 11:44:48', '2026-09-12 11:44:48', 'bheem123', 0, NULL),
(90, 19, 1, 3, 'TKN-DC-20260912-830', 1, '2026-09-12', '2026-09-12 11:44:48', '2026-09-12 11:44:48', 'bheem123', 0, NULL),
(91, 11, 1, 2, 'TKN-DC-20260921-387', 1, '2026-09-21', '2026-09-21 13:54:32', '2026-09-21 13:54:32', 'Ajit Kumar', 0, NULL),
(92, 12, 1, 3, 'TKN-DC-20260921-387', 1, '2026-09-21', '2026-09-21 13:54:32', '2026-09-21 13:54:32', 'Ajit Kumar', 0, NULL),
(93, 13, 1, 3, 'TKN-DC-20260921-387', 1, '2026-09-21', '2026-09-21 13:54:32', '2026-09-21 13:54:32', 'Ajit Kumar', 0, NULL),
(94, 14, 1, 2, 'TKN-DC-20260921-387', 1, '2026-09-21', '2026-09-21 13:54:32', '2026-09-21 13:54:32', 'Ajit Kumar', 0, NULL),
(95, 15, 1, 3, 'TKN-DC-20260921-387', 1, '2026-09-21', '2026-09-21 13:54:32', '2026-09-21 13:54:32', 'Ajit Kumar', 0, NULL),
(96, 16, 1, 3, 'TKN-DC-20260921-387', 1, '2026-09-21', '2026-09-21 13:54:32', '2026-09-21 13:54:32', 'Ajit Kumar', 0, NULL),
(97, 17, 1, 3, 'TKN-DC-20260921-387', 1, '2026-09-21', '2026-09-21 13:54:32', '2026-09-21 13:54:32', 'Ajit Kumar', 0, NULL),
(98, 18, 1, 3, 'TKN-DC-20260921-387', 1, '2026-09-21', '2026-09-21 13:54:32', '2026-09-21 13:54:32', 'Ajit Kumar', 0, NULL),
(99, 19, 1, 3, 'TKN-DC-20260921-387', 1, '2026-09-21', '2026-09-21 13:54:32', '2026-09-21 13:54:32', 'Ajit Kumar', 0, NULL),
(100, 11, 2, 1, 'TKN-DC-20260921-387', 1, '2026-09-21', '2026-09-21 13:54:51', '2026-09-21 13:54:51', 'Amit Kumar', 0, NULL),
(101, 12, 2, 3, 'TKN-DC-20260921-387', 1, '2026-09-21', '2026-09-21 13:54:51', '2026-09-21 13:54:51', 'Amit Kumar', 0, NULL),
(102, 13, 2, 3, 'TKN-DC-20260921-387', 1, '2026-09-21', '2026-09-21 13:54:51', '2026-09-21 13:54:51', 'Amit Kumar', 0, NULL),
(103, 14, 2, 3, 'TKN-DC-20260921-387', 1, '2026-09-21', '2026-09-21 13:54:51', '2026-09-21 13:54:51', 'Amit Kumar', 0, NULL),
(104, 15, 2, 3, 'TKN-DC-20260921-387', 1, '2026-09-21', '2026-09-21 13:54:51', '2026-09-21 13:54:51', 'Amit Kumar', 0, NULL),
(105, 16, 2, 3, 'TKN-DC-20260921-387', 1, '2026-09-21', '2026-09-21 13:54:51', '2026-09-21 13:54:51', 'Amit Kumar', 0, NULL),
(106, 17, 2, 2, 'TKN-DC-20260921-387', 1, '2026-09-21', '2026-09-21 13:54:51', '2026-09-21 13:54:51', 'Amit Kumar', 0, NULL),
(107, 18, 2, 3, 'TKN-DC-20260921-387', 1, '2026-09-21', '2026-09-21 13:54:51', '2026-09-21 13:54:51', 'Amit Kumar', 0, NULL),
(108, 19, 2, 3, 'TKN-DC-20260921-387', 1, '2026-09-21', '2026-09-21 13:54:51', '2026-09-21 13:54:51', 'Amit Kumar', 0, NULL);

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
(2, 1, 1, 'entry.created', 'kings (#2)', '2026-09-07', 40000, 0, 200000, 160000, 'akkkkk', '', '', 'entry.created', '2026-09-09 18:24:24'),
(4, 1, 72, 'material.created', 'kings (#2)', NULL, 0, 0, 100000, 0, '', '', '', 'HAND WASH', '2026-09-17 13:30:46'),
(5, 1, 6, 'material.updated', 'kings (#2)', NULL, 0, 0, 500000, 350000, '', '', '', 'Liquid Hand Soap (Hand Wash)', '2026-09-17 13:31:41'),
(6, 1, 1, 'entry.created', 'kings (#2)', '2026-09-17', 0, 100000, 160000, 260000, 'Test', 'Beatle', 'Testing', 'entry.created', '2026-09-17 13:46:31'),
(7, 1, 1, 'entry.updated', 'kings (#2)', '2026-09-17', 0, 0, 160000, 160000, 'Test', 'Beatle', 'Testing', 'entry.updated', '2026-09-17 13:47:07'),
(8, 1, 3, 'entry.created', 'kings (#2)', '2026-09-17', 0, 100000, 0, 100000, 'ajit', 'xyz', 'received', 'entry.created', '2026-09-17 13:52:22'),
(9, 1, 4, 'entry.created', 'kings (#2)', '2026-09-17', 0, 100000, 0, 100000, 'abc', 'xyz', 'received', 'entry.created', '2026-09-17 16:06:49'),
(10, 1, 5, 'entry.created', 'kings (#2)', '2026-09-17', 0, 50000, 0, 50000, 'XYZ', 'ABC', 'CHEMICAL RECEIVED', 'entry.created', '2026-09-17 17:55:40'),
(11, 1, 5, 'entry.created', 'kings (#2)', '2026-09-21', 0, 200000, 50000, 250000, 'ajit', '123456', 'Receiced', 'entry.created', '2026-09-21 19:54:20'),
(12, 1, 1, 'material.updated', 'kings (#2)', NULL, 0, 0, 200000, 150000, '', '', '', 'Heavy Duty Exterior Washing Liquid (Spiral)', '2026-09-21 19:58:03'),
(13, 1, 73, 'material.created', 'kings (#2)', NULL, 0, 0, 0, 0, '', '', '', 'Bottle picker', '2026-09-21 19:59:01');

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
(3, 1, '2026-09-07', 40000, 0, 'akkkkk', '', '', 'kings (#2)', 'kings (#2)', '2026-09-09T12:54:23+00:00', '2026-09-09T12:54:23+00:00'),
(5, 3, '2026-09-17', 0, 100000, 'ajit', 'xyz', 'received', 'kings (#2)', 'kings (#2)', '2026-09-17T08:22:22+00:00', '2026-09-17T08:22:22+00:00'),
(6, 4, '2026-09-17', 0, 100000, 'abc', 'xyz', 'received', 'kings (#2)', 'kings (#2)', '2026-09-17T10:36:49+00:00', '2026-09-17T10:36:49+00:00'),
(7, 5, '2026-09-17', 0, 50000, 'XYZ', 'ABC', 'CHEMICAL RECEIVED', 'kings (#2)', 'kings (#2)', '2026-09-17T12:25:40+00:00', '2026-09-17T12:25:40+00:00'),
(8, 5, '2026-09-21', 0, 200000, 'ajit', '123456', 'Receiced', 'kings (#2)', 'kings (#2)', '2026-09-21T14:24:20+00:00', '2026-09-21T14:24:20+00:00');

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
(1, 1, 1, 'Heavy Duty Exterior Washing Liquid (Spiral)', 'Chemical', 'L', 200000, '2026-09-01', 150000, 7, '2026-09-09 17:49:57', '2026-09-21T14:28:03+00:00'),
(2, 1, 2, 'Ceramic & Stainless Steel Toilet Fittings Cleaning Agent', 'Chemical', 'L', 0, '2026-09-01', 0, 2, '2026-09-09 17:49:57', '2026-09-09T12:47:20+00:00'),
(3, 1, 3, 'Glass Cleaning Agent', 'Chemical', 'L', 0, '2026-09-17', 0, 2, '2026-09-09 17:49:57', '2026-09-17T08:22:22+00:00'),
(4, 1, 4, 'PVC Floor Cleaning Agent', 'Chemical', 'L', 0, '2026-09-17', 0, 2, '2026-09-09 17:49:57', '2026-09-17T10:36:49+00:00'),
(5, 1, 5, 'Air Freshener', 'Chemical', 'L', 0, '2026-09-17', 0, 3, '2026-09-09 17:49:57', '2026-09-21T14:24:20+00:00'),
(6, 1, 6, 'Liquid Hand Soap (Hand Wash)', 'Chemical', 'L', 500000, '2026-09-17', 350000, 3, '2026-09-09 17:49:57', '2026-09-17T08:01:41+00:00'),
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
(35, 1, 35, 'Window Glass Squeezer', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-09 17:49:57', '2026-09-09 17:49:57'),
(37, 4, 1, 'Heavy Duty Exterior Washing Liquid', 'Chemical', 'L', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(38, 4, 2, 'Ceramic & Stainless Steel Toilet Fittings Cleaning Agent', 'Chemical', 'L', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(39, 4, 3, 'Glass Cleaning Agent', 'Chemical', 'L', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(40, 4, 4, 'PVC Floor Cleaning Agent', 'Chemical', 'L', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(41, 4, 5, 'Air Freshener', 'Chemical', 'L', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(42, 4, 6, 'Liquid Hand Soap (Hand Wash)', 'Chemical', 'L', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(43, 4, 7, 'Cleaning Agent for Removing Old Sticker, Glue Marks etc.', 'Chemical', 'L', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(44, 4, 8, 'Stainless Steel Polish', 'Chemical', 'L', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(45, 4, 9, 'Banister Brush', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(46, 4, 10, 'Bucket (15 L + 5 L)', 'Equipment', 'sets', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(47, 4, 11, 'Foot Broom Head with Bristles', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(48, 4, 12, 'Polypropylene Bristle Brush', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(49, 4, 13, 'Suitable Broom', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(50, 4, 14, 'Disposable Bag (29 × 39)', 'Consumable', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(51, 4, 15, 'Floor Mopper', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(52, 4, 16, 'Mopper Cloth', 'Consumable', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(53, 4, 17, 'Microfiber Cloth', 'Consumable', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(54, 4, 18, 'Fiber Hand Held Brush (Round Type)', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(55, 4, 19, 'Floor Squeezer', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(56, 4, 20, 'Window Squeezer', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(57, 4, 21, 'Bottle with Spray Gun', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(58, 4, 22, 'Super Absorbent Floor Mopper', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(59, 4, 23, 'Squeeze Brush', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(60, 4, 24, 'Toilet Commode Brush', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(61, 4, 25, 'Carpet Brush', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(62, 4, 26, 'Upholstery Cleaning Brush', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(63, 4, 27, 'Sponge Duster (Yellow)', 'Consumable', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(64, 4, 28, 'Disposable Bag for Dustbin (19 × 21)', 'Consumable', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(65, 4, 29, 'Disinfectants', 'Chemical', 'L', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(66, 4, 30, 'Mosquito Repellent Spray', 'Chemical', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(67, 4, 31, 'Tissue Paper for Western AC Coach Toilet', 'Consumable', 'rolls', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(68, 4, 32, 'Deodorant Stick/Cake for Each Toilet in AC Coaches', 'Consumable', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(69, 4, 33, 'Painted Surface Cleaning Agent', 'Chemical', 'L', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(70, 4, 34, 'Laminated Plastic Sheet & Berth Rexine Cleaner', 'Chemical', 'L', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(71, 4, 35, 'Window Glass Squeezer', 'Equipment', 'pcs', 0, NULL, 0, 1, '2026-09-14 16:53:18', '2026-09-14 16:53:18'),
(72, 1, NULL, 'HAND WASH', 'Chemical', 'L', 100000, '2026-09-17', 0, 1, '2026-09-17T08:00:46+00:00', '2026-09-17T08:00:46+00:00'),
(73, 1, NULL, 'Bottle picker', 'Consumable', 'pcs', 0, '2026-09-21', 0, 1, '2026-09-21T14:29:01+00:00', '2026-09-21T14:29:01+00:00');

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
(1, '2026-09-09 17:49:57'),
(4, '2026-09-14 16:53:18');

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
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_cleanliness_report`
--

INSERT INTO `mcc_cleanliness_report` (`id`, `station_id`, `report_date`, `score`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(1, 1, '2026-07-01', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(2, 1, '2026-07-02', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(3, 1, '2026-07-03', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(4, 1, '2026-07-04', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(5, 1, '2026-07-05', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(6, 1, '2026-07-06', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(7, 1, '2026-07-07', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(8, 1, '2026-07-08', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(9, 1, '2026-07-09', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(10, 1, '2026-07-10', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(11, 1, '2026-07-11', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(12, 1, '2026-07-12', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(13, 1, '2026-07-13', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(14, 1, '2026-07-14', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(15, 1, '2026-07-15', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(16, 1, '2026-07-16', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(17, 1, '2026-07-17', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(18, 1, '2026-07-18', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(19, 1, '2026-07-19', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(20, 1, '2026-07-20', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(21, 1, '2026-07-21', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(22, 1, '2026-07-22', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(23, 1, '2026-07-23', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(24, 1, '2026-07-24', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(25, 1, '2026-07-25', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(26, 1, '2026-07-26', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(27, 1, '2026-07-27', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(28, 1, '2026-07-28', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(29, 1, '2026-07-29', 70.00, '2026-07-10 04:22:45', '2026-07-10 04:25:38', 0, NULL),
(30, 1, '2026-07-30', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL),
(31, 1, '2026-07-31', 90.00, '2026-07-10 04:22:45', '2026-07-10 04:22:45', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mcc_coaches`
--

CREATE TABLE `mcc_coaches` (
  `coach_id` int(11) NOT NULL,
  `train_id` int(11) NOT NULL,
  `coach_no` varchar(50) NOT NULL,
  `display_order` int(11) DEFAULT 1,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_coaches`
--

INSERT INTO `mcc_coaches` (`coach_id`, `train_id`, `coach_no`, `display_order`, `status`, `created_at`, `updated_at`) VALUES
(16, 3, 'S1', 1, 'Active', '2026-09-15 07:44:39', '2026-09-15 07:44:39'),
(17, 3, 'S2', 2, 'Active', '2026-09-15 07:44:40', '2026-09-15 07:44:40'),
(18, 3, 'S3', 3, 'Active', '2026-09-15 07:44:40', '2026-09-15 07:44:40'),
(50, 7, '227126', 1, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(51, 7, '182209', 2, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(52, 7, '226871', 3, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(53, 7, '225859', 4, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(54, 7, '225283', 5, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(55, 7, '226472', 6, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(56, 7, '191730', 7, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(57, 7, '193659', 8, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(58, 7, '197712', 9, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(59, 7, '197855', 10, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(60, 7, '212183', 11, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(61, 7, '243440', 12, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(62, 7, '182083', 13, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(63, 7, '182078', 14, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(64, 7, '223450', 15, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(65, 7, '201593', 16, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(66, 7, '191483', 17, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(67, 7, '195176', 18, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(68, 7, '191599', 19, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(69, 7, '263996', 20, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(70, 7, '191077', 21, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(71, 8, '143707', 1, 'Active', '2026-09-22 07:59:48', '2026-09-22 07:59:48'),
(72, 8, '084665', 2, 'Active', '2026-09-22 07:59:48', '2026-09-22 07:59:48'),
(73, 8, '144211', 3, 'Active', '2026-09-22 07:59:48', '2026-09-22 07:59:48'),
(74, 8, '074971', 4, 'Active', '2026-09-22 07:59:48', '2026-09-22 07:59:48'),
(75, 8, '084214', 5, 'Active', '2026-09-22 07:59:48', '2026-09-22 07:59:48'),
(76, 8, '124921', 6, 'Active', '2026-09-22 07:59:48', '2026-09-22 07:59:48'),
(77, 8, '124401', 7, 'Active', '2026-09-22 07:59:48', '2026-09-22 07:59:48'),
(78, 8, '125039', 8, 'Active', '2026-09-22 07:59:48', '2026-09-22 07:59:48'),
(79, 8, '124202', 9, 'Active', '2026-09-22 07:59:48', '2026-09-22 07:59:48'),
(80, 8, '164189', 10, 'Active', '2026-09-22 07:59:48', '2026-09-22 07:59:48'),
(81, 8, '171244', 11, 'Active', '2026-09-22 07:59:48', '2026-09-22 07:59:48'),
(82, 8, '074873', 12, 'Active', '2026-09-22 07:59:48', '2026-09-22 07:59:48'),
(83, 8, '124147', 13, 'Active', '2026-09-22 07:59:48', '2026-09-22 07:59:48'),
(84, 8, '094280', 14, 'Active', '2026-09-22 07:59:48', '2026-09-22 07:59:48'),
(85, 8, '084511', 15, 'Active', '2026-09-22 07:59:48', '2026-09-22 07:59:48'),
(86, 8, '134530', 16, 'Active', '2026-09-22 07:59:48', '2026-09-22 07:59:48'),
(87, 8, '084593', 17, 'Active', '2026-09-22 07:59:48', '2026-09-22 07:59:48'),
(88, 8, '144481', 18, 'Active', '2026-09-22 07:59:48', '2026-09-22 07:59:48'),
(89, 9, '164328', 1, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(90, 9, '104139', 2, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(91, 9, '134938', 3, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(92, 9, '111414', 4, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(93, 9, '111564', 5, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(94, 9, '131360', 6, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(95, 9, '071395', 7, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(96, 9, '154627', 8, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(97, 9, '084402', 9, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(98, 9, '134864', 10, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(99, 9, '154684', 11, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(100, 9, '164437', 12, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(101, 9, '084351', 13, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(102, 9, '074876', 14, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(103, 9, '154171', 15, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(104, 9, '151471', 16, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(105, 9, '154088', 17, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(106, 9, '074255', 18, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(107, 9, '074740', 19, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(108, 9, '144639', 20, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(109, 9, '124361', 21, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(110, 10, '263724', 1, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(111, 10, '264514', 2, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(112, 10, '264511', 3, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(113, 10, '263653', 4, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(114, 10, '263656', 5, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(115, 10, '259759', 6, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(116, 10, '264960', 7, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(117, 10, '264948', 8, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(118, 10, '263703', 9, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(119, 10, '263695', 10, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(120, 10, '263693', 11, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(121, 10, '263704', 12, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(122, 10, '263700', 13, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(123, 10, '261136', 14, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(124, 10, '264520', 15, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(125, 10, '264512', 16, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(126, 10, '264517', 17, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(127, 10, '264518', 18, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(128, 10, '261303', 19, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(129, 11, '243970', 1, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(130, 11, '248931', 2, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(131, 11, '257196', 3, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(132, 11, '221809', 4, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(133, 11, '224767', 5, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(134, 11, '224142', 6, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(135, 11, '194976', 7, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(136, 11, '224131', 8, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(137, 11, '205516', 9, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(138, 11, '205244', 10, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(139, 11, '174467', 11, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(140, 11, '225301', 12, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(141, 11, '216533', 13, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(142, 11, '184199', 14, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(143, 11, '235944', 15, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(144, 11, '174173', 16, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(145, 11, '135404', 17, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(146, 11, '216713', 18, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(147, 11, '256446', 19, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(148, 11, '256447', 20, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(149, 11, '225585', 21, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(150, 12, '074536', 1, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(151, 12, '114561', 2, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(152, 12, '084268', 3, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(153, 12, '091299', 4, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(154, 12, '131550', 5, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(155, 12, '081312', 6, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(156, 12, '131524', 7, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(157, 12, '146253', 8, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(158, 12, '074879', 9, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(159, 12, '104563', 10, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(160, 12, '144178', 11, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(161, 12, '154556', 12, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(162, 12, '141054', 13, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(163, 12, '134696', 14, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(164, 12, '074578', 15, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(165, 12, '134907', 16, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(166, 12, '074074', 17, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(167, 12, '134729', 18, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(168, 12, '174132', 19, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(169, 12, '114361', 20, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(170, 12, '154104', 21, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(171, 13, '226281', 1, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(172, 13, '264697', 2, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(173, 13, '264700', 3, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(174, 13, '264701', 4, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(175, 13, '264693', 5, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(176, 13, '264696', 6, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(177, 13, '26495', 7, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(178, 13, '264097', 8, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(179, 13, '154859', 9, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(180, 13, '264533', 10, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(181, 13, '263800', 11, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(182, 13, '263799', 12, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(183, 13, '251097', 13, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(184, 13, '264753', 14, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(185, 13, '264754', 15, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(186, 13, '264758', 16, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(187, 13, '264750', 17, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(188, 13, '261177', 18, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(189, 13, '265498', 19, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(190, 13, '264188', 20, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(191, 14, '243971', 1, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(192, 14, '191601', 2, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(193, 14, '197862', 3, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(194, 14, '182069', 4, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(195, 14, '231540', 5, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(196, 14, '202913', 6, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(197, 14, '221173', 7, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(198, 14, '251600', 8, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(199, 14, '212182', 9, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(200, 14, '205231', 10, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(201, 14, '256290', 11, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(202, 14, '182106', 12, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(203, 14, '174329', 13, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(204, 14, '225300', 14, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(205, 14, '256956', 15, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(206, 14, '217052', 16, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(207, 14, '201002', 17, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(208, 14, '245086', 18, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(209, 14, '260284', 19, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(210, 14, '201636', 20, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(211, 14, '236377', 21, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(212, 15, '156754', 1, 'Active', '2026-09-22 09:40:39', '2026-09-22 09:40:39'),
(213, 15, '084727', 2, 'Active', '2026-09-22 09:40:39', '2026-09-22 09:40:39'),
(214, 15, '075008', 3, 'Active', '2026-09-22 09:40:39', '2026-09-22 09:40:39'),
(215, 15, '144807', 4, 'Active', '2026-09-22 09:40:39', '2026-09-22 09:40:39'),
(216, 15, '104583', 5, 'Active', '2026-09-22 09:40:39', '2026-09-22 09:40:39'),
(217, 15, '084696', 6, 'Active', '2026-09-22 09:40:39', '2026-09-22 09:40:39'),
(218, 15, '074674', 7, 'Active', '2026-09-22 09:40:39', '2026-09-22 09:40:39'),
(219, 15, '174412', 8, 'Active', '2026-09-22 09:40:39', '2026-09-22 09:40:39'),
(220, 15, '164407', 9, 'Active', '2026-09-22 09:40:39', '2026-09-22 09:40:39'),
(221, 15, '134473', 10, 'Active', '2026-09-22 09:40:39', '2026-09-22 09:40:39'),
(222, 15, '114059', 11, 'Active', '2026-09-22 09:40:39', '2026-09-22 09:40:39'),
(223, 15, '124060', 12, 'Active', '2026-09-22 09:40:39', '2026-09-22 09:40:39'),
(224, 15, '114631', 13, 'Active', '2026-09-22 09:40:39', '2026-09-22 09:40:39'),
(225, 15, '114479', 14, 'Active', '2026-09-22 09:40:39', '2026-09-22 09:40:39'),
(226, 16, '246057', 1, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(227, 16, '260248', 2, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(228, 16, '247561', 3, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(229, 16, '245896', 4, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(230, 16, '245751', 5, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(231, 16, '256607', 6, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(232, 16, '246163', 7, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(233, 16, '246075', 8, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(234, 16, '257597', 9, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(235, 16, '245762', 10, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(236, 16, '251436', 11, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(237, 16, '167123', 12, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(238, 16, '222262', 13, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(239, 16, '203893', 14, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(240, 16, '167139', 15, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(241, 16, '242802', 16, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(242, 16, '233872', 17, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(243, 16, '227822', 18, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(244, 16, '241995', 19, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(245, 16, '215965', 20, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(246, 16, '247325', 21, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(247, 16, '252628', 22, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(248, 17, '261051', 1, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(249, 17, '182835', 2, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(250, 17, '193605', 3, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(251, 17, '182186', 4, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(252, 17, '195185', 5, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(253, 17, '191750', 6, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(254, 17, '225311', 7, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(255, 17, '191715', 8, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(256, 17, '191720', 9, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(257, 17, '191740', 10, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(258, 17, '193050', 11, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(259, 17, '202965', 12, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(260, 17, '191709', 13, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(261, 17, '221468', 14, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(262, 17, '205521', 15, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(263, 17, '202924', 16, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(264, 17, '221454', 17, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(265, 17, '211882', 18, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(266, 17, '195862', 19, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(267, 17, '184430', 20, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(268, 17, '225852', 21, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(269, 18, '205205', 1, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(270, 18, '235843', 2, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(271, 18, '186429', 3, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(272, 18, '242311', 4, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(273, 18, '242101', 5, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(274, 18, '181398', 6, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(275, 18, '193961', 7, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(276, 18, '224278', 8, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(277, 18, '212756', 9, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(278, 18, '241828', 10, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(279, 18, '195462', 11, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(280, 18, '245392', 12, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(281, 18, '186202', 13, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(282, 18, '182399', 14, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(283, 18, '246175', 15, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(284, 18, '246178', 16, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(285, 18, '192081', 17, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(286, 18, '245371', 18, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(287, 18, '174112', 19, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(288, 18, '187421', 20, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(289, 18, '245722', 21, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(290, 18, '261171', 22, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(291, 19, '265538', 1, 'Active', '2026-09-22 10:03:52', '2026-09-22 10:03:52'),
(292, 19, '265493', 2, 'Active', '2026-09-22 10:03:52', '2026-09-22 10:03:52'),
(293, 19, '264299', 3, 'Active', '2026-09-22 10:03:52', '2026-09-22 10:03:52'),
(294, 19, '265470', 4, 'Active', '2026-09-22 10:03:52', '2026-09-22 10:03:52'),
(295, 19, '265473', 5, 'Active', '2026-09-22 10:03:52', '2026-09-22 10:03:52'),
(296, 19, '265467', 6, 'Active', '2026-09-22 10:03:52', '2026-09-22 10:03:52'),
(297, 19, '265469', 7, 'Active', '2026-09-22 10:03:52', '2026-09-22 10:03:52'),
(298, 19, '265465', 8, 'Active', '2026-09-22 10:03:52', '2026-09-22 10:03:52'),
(299, 19, '265482', 9, 'Active', '2026-09-22 10:03:52', '2026-09-22 10:03:52'),
(300, 19, '265478', 10, 'Active', '2026-09-22 10:03:52', '2026-09-22 10:03:52'),
(301, 19, '265475', 11, 'Active', '2026-09-22 10:03:52', '2026-09-22 10:03:52'),
(302, 19, '265474', 12, 'Active', '2026-09-22 10:03:52', '2026-09-22 10:03:52'),
(303, 19, '264685', 13, 'Active', '2026-09-22 10:03:52', '2026-09-22 10:03:52'),
(304, 19, '252204', 14, 'Active', '2026-09-22 10:03:52', '2026-09-22 10:03:52'),
(305, 19, '264717', 15, 'Active', '2026-09-22 10:03:52', '2026-09-22 10:03:52'),
(306, 19, '265500', 16, 'Active', '2026-09-22 10:03:52', '2026-09-22 10:03:52'),
(307, 19, '261621', 17, 'Active', '2026-09-22 10:03:52', '2026-09-22 10:03:52'),
(308, 4, '225388', 1, 'Active', '2026-09-22 10:29:41', '2026-09-22 10:29:41'),
(309, 4, '225861', 2, 'Active', '2026-09-22 10:29:41', '2026-09-22 10:29:41'),
(310, 4, '245887', 3, 'Active', '2026-09-22 10:29:41', '2026-09-22 10:29:41'),
(311, 4, '251521', 4, 'Active', '2026-09-22 10:29:41', '2026-09-22 10:29:41'),
(312, 4, '201671', 5, 'Active', '2026-09-22 10:29:41', '2026-09-22 10:29:41'),
(313, 4, '212954', 6, 'Active', '2026-09-22 10:29:41', '2026-09-22 10:29:41'),
(314, 4, '182601', 7, 'Active', '2026-09-22 10:29:41', '2026-09-22 10:29:41'),
(315, 4, '251574', 8, 'Active', '2026-09-22 10:29:41', '2026-09-22 10:29:41'),
(316, 4, '216697', 9, 'Active', '2026-09-22 10:29:41', '2026-09-22 10:29:41'),
(317, 4, '191746', 10, 'Active', '2026-09-22 10:29:41', '2026-09-22 10:29:41'),
(318, 4, '255982', 11, 'Active', '2026-09-22 10:29:41', '2026-09-22 10:29:41'),
(319, 4, '195191', 12, 'Active', '2026-09-22 10:29:41', '2026-09-22 10:29:41'),
(320, 4, '191757', 13, 'Active', '2026-09-22 10:29:41', '2026-09-22 10:29:41'),
(321, 4, '201587', 14, 'Active', '2026-09-22 10:29:41', '2026-09-22 10:29:41'),
(322, 4, '197705', 15, 'Active', '2026-09-22 10:29:41', '2026-09-22 10:29:41'),
(323, 4, '193028', 16, 'Active', '2026-09-22 10:29:41', '2026-09-22 10:29:41'),
(324, 4, '193241', 17, 'Active', '2026-09-22 10:29:41', '2026-09-22 10:29:41'),
(325, 4, '191216', 18, 'Active', '2026-09-22 10:29:41', '2026-09-22 10:29:41');

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
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_chemical_report`
--

INSERT INTO `mcc_intensive_chemical_report` (`id`, `parameter_id`, `coach_no`, `qty_used`, `auditor_name`, `station_id`, `token_id`, `train_no`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(1, 1, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:07', 0, NULL),
(2, 2, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:07', 0, NULL),
(3, 3, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:07', 0, NULL),
(4, 4, 'C1', 5.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:07', 0, NULL),
(5, 5, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:07', 0, NULL),
(6, 6, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:07', 0, NULL),
(7, 7, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:07', 0, NULL),
(8, 8, 'C1', 100.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:07', 0, NULL),
(9, 1, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:09', 0, NULL),
(10, 2, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:09', 0, NULL),
(11, 3, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:09', 0, NULL),
(12, 4, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:09', 0, NULL),
(13, 5, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:09', 0, NULL),
(14, 6, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:09', 0, NULL),
(15, 7, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:09', 0, NULL),
(16, 8, 'C2', 100.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:09', 0, NULL),
(17, 1, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:17', 0, NULL),
(18, 2, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:17', 0, NULL),
(19, 3, 'C3', 8.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:17', 0, NULL),
(20, 4, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:17', 0, NULL),
(21, 5, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:17', 0, NULL),
(22, 6, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:17', 0, NULL),
(23, 7, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:17', 0, NULL),
(24, 8, 'C3', 100.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:17', 0, NULL),
(25, 1, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:19', 0, NULL),
(26, 2, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:19', 0, NULL),
(27, 3, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:19', 0, NULL),
(28, 4, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:19', 0, NULL),
(29, 5, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:19', 0, NULL),
(30, 6, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:19', 0, NULL),
(31, 7, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:19', 0, NULL),
(32, 8, 'C4', 100.00, 'Bheem Chand', 1, 'TKN-20260907-989', '12345', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:13:19', 0, NULL),
(33, 1, '1', NULL, 'Ajit', 1, 'TKN-20260908-027', '12345', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(34, 2, '1', NULL, 'Ajit', 1, 'TKN-20260908-027', '12345', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(35, 3, '1', NULL, 'Ajit', 1, 'TKN-20260908-027', '12345', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(36, 4, '1', NULL, 'Ajit', 1, 'TKN-20260908-027', '12345', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(37, 5, '1', NULL, 'Ajit', 1, 'TKN-20260908-027', '12345', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(38, 6, '1', NULL, 'Ajit', 1, 'TKN-20260908-027', '12345', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(39, 7, '1', NULL, 'Ajit', 1, 'TKN-20260908-027', '12345', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(40, 8, '1', NULL, 'Ajit', 1, 'TKN-20260908-027', '12345', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(41, 1, '1', NULL, 'Ajit', 1, 'TKN-20260908-341', '12315', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 07:34:44', 0, NULL),
(42, 2, '1', NULL, 'Ajit', 1, 'TKN-20260908-341', '12315', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 07:34:44', 0, NULL),
(43, 3, '1', NULL, 'Ajit', 1, 'TKN-20260908-341', '12315', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 07:34:44', 0, NULL),
(44, 4, '1', NULL, 'Ajit', 1, 'TKN-20260908-341', '12315', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 07:34:44', 0, NULL),
(45, 5, '1', NULL, 'Ajit', 1, 'TKN-20260908-341', '12315', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 07:34:44', 0, NULL),
(46, 6, '1', NULL, 'Ajit', 1, 'TKN-20260908-341', '12315', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 07:34:44', 0, NULL),
(47, 7, '1', NULL, 'Ajit', 1, 'TKN-20260908-341', '12315', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 07:34:44', 0, NULL),
(48, 8, '1', NULL, 'Ajit', 1, 'TKN-20260908-341', '12315', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 07:34:44', 0, NULL),
(49, 1, '1', NULL, 'Smc', 1, 'TKN-20260908-286', '16236', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:04', 0, NULL),
(50, 2, '1', NULL, 'Smc', 1, 'TKN-20260908-286', '16236', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:04', 0, NULL),
(51, 3, '1', NULL, 'Smc', 1, 'TKN-20260908-286', '16236', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:04', 0, NULL),
(52, 4, '1', NULL, 'Smc', 1, 'TKN-20260908-286', '16236', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:04', 0, NULL),
(53, 5, '1', NULL, 'Smc', 1, 'TKN-20260908-286', '16236', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:04', 0, NULL),
(54, 6, '1', NULL, 'Smc', 1, 'TKN-20260908-286', '16236', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:04', 0, NULL),
(55, 7, '1', NULL, 'Smc', 1, 'TKN-20260908-286', '16236', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:04', 0, NULL),
(56, 8, '1', NULL, 'Smc', 1, 'TKN-20260908-286', '16236', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:04', 0, NULL),
(57, 1, '01', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:35', 0, NULL),
(58, 2, '01', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:35', 0, NULL),
(59, 3, '01', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:35', 0, NULL),
(60, 4, '01', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:35', 0, NULL),
(61, 5, '01', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:35', 0, NULL),
(62, 6, '01', 25.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:35', 0, NULL),
(63, 7, '01', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:35', 0, NULL),
(64, 8, '01', 100.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:35', 0, NULL),
(65, 1, '02', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:41', 0, NULL),
(66, 2, '02', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:41', 0, NULL),
(67, 3, '02', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:41', 0, NULL),
(68, 4, '02', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:41', 0, NULL),
(69, 5, '02', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:41', 0, NULL),
(70, 6, '02', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:41', 0, NULL),
(71, 7, '02', 10.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:41', 0, NULL),
(72, 8, '02', 100.00, 'Darshan', 1, 'TKN-20260909-536', '16236', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:34:41', 0, NULL),
(73, 1, '01', 28.00, 'Sandesh', 1, 'TKN-20260909-635', '22687', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:34:20', 0, NULL),
(74, 2, '01', 10.00, 'Sandesh', 1, 'TKN-20260909-635', '22687', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:34:20', 0, NULL),
(75, 3, '01', 10.00, 'Sandesh', 1, 'TKN-20260909-635', '22687', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:34:20', 0, NULL),
(76, 4, '01', 10.00, 'Sandesh', 1, 'TKN-20260909-635', '22687', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:34:20', 0, NULL),
(77, 5, '01', 10.00, 'Sandesh', 1, 'TKN-20260909-635', '22687', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:34:20', 0, NULL),
(78, 6, '01', 10.00, 'Sandesh', 1, 'TKN-20260909-635', '22687', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:34:20', 0, NULL),
(79, 7, '01', 10.00, 'Sandesh', 1, 'TKN-20260909-635', '22687', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:34:20', 0, NULL),
(80, 8, '01', 100.00, 'Sandesh', 1, 'TKN-20260909-635', '22687', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:34:20', 0, NULL),
(81, 1, '01', 10.00, 'Rafik', 1, 'TKN-20260909-989', '16227', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:34:03', 0, NULL),
(82, 2, '01', 10.00, 'Rafik', 1, 'TKN-20260909-989', '16227', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:34:03', 0, NULL),
(83, 3, '01', 10.00, 'Rafik', 1, 'TKN-20260909-989', '16227', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:34:03', 0, NULL),
(84, 4, '01', 10.00, 'Rafik', 1, 'TKN-20260909-989', '16227', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:34:03', 0, NULL),
(85, 5, '01', 10.00, 'Rafik', 1, 'TKN-20260909-989', '16227', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:34:03', 0, NULL),
(86, 6, '01', 10.00, 'Rafik', 1, 'TKN-20260909-989', '16227', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:34:03', 0, NULL),
(87, 7, '01', 10.00, 'Rafik', 1, 'TKN-20260909-989', '16227', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:34:03', 0, NULL),
(88, 8, '01', 100.00, 'Rafik', 1, 'TKN-20260909-989', '16227', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:34:03', 0, NULL),
(89, 1, '01', 10.00, 'Shivkumar', 1, 'TKN-20260909-880', '22781', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:34:09', 0, NULL),
(90, 2, '01', 10.00, 'Shivkumar', 1, 'TKN-20260909-880', '22781', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:34:09', 0, NULL),
(91, 3, '01', 10.00, 'Shivkumar', 1, 'TKN-20260909-880', '22781', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:34:09', 0, NULL),
(92, 4, '01', 10.00, 'Shivkumar', 1, 'TKN-20260909-880', '22781', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:34:09', 0, NULL),
(93, 5, '01', 10.00, 'Shivkumar', 1, 'TKN-20260909-880', '22781', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:34:09', 0, NULL),
(94, 6, '01', 10.00, 'Shivkumar', 1, 'TKN-20260909-880', '22781', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:34:09', 0, NULL),
(95, 7, '01', 10.00, 'Shivkumar', 1, 'TKN-20260909-880', '22781', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:34:09', 0, NULL),
(96, 8, '01', 100.00, 'Shivkumar', 1, 'TKN-20260909-880', '22781', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:34:09', 0, NULL),
(105, 9, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-20260912-424', '123456', '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:03:37', 0, NULL),
(106, 10, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-20260912-424', '123456', '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:03:37', 0, NULL),
(107, 11, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-20260912-424', '123456', '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:03:37', 0, NULL),
(108, 12, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-20260912-424', '123456', '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:03:37', 0, NULL),
(109, 13, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-20260912-424', '123456', '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:03:37', 0, NULL),
(110, 14, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-20260912-424', '123456', '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:03:37', 0, NULL),
(111, 15, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-20260912-424', '123456', '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:03:37', 0, NULL),
(112, 16, 'C1', 100.00, 'SCL AUDITOR', 4, 'TKN-20260912-424', '123456', '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:03:37', 0, NULL),
(113, 9, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(114, 10, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(115, 11, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(116, 12, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(117, 13, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(118, 14, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(119, 15, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(120, 16, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(121, 9, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(122, 10, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(123, 11, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(124, 12, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(125, 13, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(126, 14, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(127, 15, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(128, 16, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(129, 9, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(130, 10, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(131, 11, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(132, 12, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(133, 13, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(134, 14, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(135, 15, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(136, 16, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-476', '812601', '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL);

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
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_machine_report`
--

INSERT INTO `mcc_intensive_machine_report` (`id`, `parameter_id`, `shift_id`, `used_status`, `token_id`, `auditor_name`, `station_id`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(1, 16, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41', 0, NULL),
(2, 17, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41', 0, NULL),
(3, 18, 4, 'N', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41', 0, NULL),
(4, 19, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41', 0, NULL),
(5, 20, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41', 0, NULL),
(6, 21, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41', 0, NULL),
(7, 22, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41', 0, NULL),
(8, 23, 4, 'N', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41', 0, NULL),
(9, 24, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41', 0, NULL),
(10, 25, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41', 0, NULL),
(11, 26, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41', 0, NULL),
(12, 27, 4, 'N', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41', 0, NULL),
(13, 28, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41', 0, NULL),
(14, 29, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41', 0, NULL),
(15, 30, 4, 'Y', 'TKN-MCH-20260907-4-6976', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:41', '2026-09-07 14:12:41', 0, NULL),
(16, 16, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50', 0, NULL),
(17, 17, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50', 0, NULL),
(18, 18, 5, 'N', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50', 0, NULL),
(19, 19, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50', 0, NULL),
(20, 20, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50', 0, NULL),
(21, 21, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50', 0, NULL),
(22, 22, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50', 0, NULL),
(23, 23, 5, 'N', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50', 0, NULL),
(24, 24, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50', 0, NULL),
(25, 25, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50', 0, NULL),
(26, 26, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50', 0, NULL),
(27, 27, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50', 0, NULL),
(28, 28, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50', 0, NULL),
(29, 29, 5, 'N', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50', 0, NULL),
(30, 30, 5, 'Y', 'TKN-MCH-20260907-5-8780', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:50', '2026-09-07 14:12:50', 0, NULL),
(31, 16, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54', 0, NULL),
(32, 17, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54', 0, NULL),
(33, 18, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54', 0, NULL),
(34, 19, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54', 0, NULL),
(35, 20, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54', 0, NULL),
(36, 21, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54', 0, NULL),
(37, 22, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54', 0, NULL),
(38, 23, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54', 0, NULL),
(39, 24, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54', 0, NULL),
(40, 25, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54', 0, NULL),
(41, 26, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54', 0, NULL),
(42, 27, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54', 0, NULL),
(43, 28, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54', 0, NULL),
(44, 29, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54', 0, NULL),
(45, 30, 6, 'Y', 'TKN-MCH-20260907-6-7332', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:12:54', '2026-09-07 14:12:54', 0, NULL),
(46, 16, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01', 0, NULL),
(47, 17, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01', 0, NULL),
(48, 18, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01', 0, NULL),
(49, 19, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01', 0, NULL),
(50, 20, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01', 0, NULL),
(51, 21, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01', 0, NULL),
(52, 22, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01', 0, NULL),
(53, 23, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01', 0, NULL),
(54, 24, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01', 0, NULL),
(55, 25, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01', 0, NULL),
(56, 26, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01', 0, NULL),
(57, 27, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01', 0, NULL),
(58, 28, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01', 0, NULL),
(59, 29, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01', 0, NULL),
(60, 30, 4, 'Y', 'TKN-MCH-20260908-4-8695', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:01', '2026-09-08 07:39:01', 0, NULL),
(61, 16, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01', 0, NULL),
(62, 17, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01', 0, NULL),
(63, 18, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01', 0, NULL),
(64, 19, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01', 0, NULL),
(65, 20, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01', 0, NULL),
(66, 21, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01', 0, NULL),
(67, 22, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01', 0, NULL),
(68, 23, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01', 0, NULL),
(69, 24, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01', 0, NULL),
(70, 25, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01', 0, NULL),
(71, 26, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01', 0, NULL),
(72, 27, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01', 0, NULL),
(73, 28, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01', 0, NULL),
(74, 29, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01', 0, NULL),
(75, 30, 4, 'Y', 'TKN-MCH-20260909-4-3865', 'Darshan', 1, '2026-09-09', '2026-09-09 07:22:01', '2026-09-09 07:22:01', 0, NULL),
(76, 16, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10', 0, NULL),
(77, 17, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10', 0, NULL),
(78, 18, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10', 0, NULL),
(79, 19, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10', 0, NULL),
(80, 20, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10', 0, NULL),
(81, 21, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10', 0, NULL),
(82, 22, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10', 0, NULL),
(83, 23, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10', 0, NULL),
(84, 24, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10', 0, NULL),
(85, 25, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10', 0, NULL),
(86, 26, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10', 0, NULL),
(87, 27, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10', 0, NULL),
(88, 28, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10', 0, NULL),
(89, 29, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10', 0, NULL),
(90, 30, 5, 'Y', 'TKN-MCH-20260909-5-9789', 'Rafik', 1, '2026-09-09', '2026-09-09 07:22:10', '2026-09-09 07:22:10', 0, NULL),
(91, 16, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19', 0, NULL),
(92, 17, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19', 0, NULL),
(93, 18, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19', 0, NULL),
(94, 19, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19', 0, NULL),
(95, 20, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19', 0, NULL),
(96, 21, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19', 0, NULL),
(97, 22, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19', 0, NULL),
(98, 23, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19', 0, NULL),
(99, 24, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19', 0, NULL),
(100, 25, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19', 0, NULL),
(101, 26, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19', 0, NULL),
(102, 27, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19', 0, NULL),
(103, 28, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19', 0, NULL),
(104, 29, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19', 0, NULL),
(105, 30, 6, 'Y', 'TKN-MCH-20260909-6-9148', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:22:19', '2026-09-09 07:22:19', 0, NULL),
(106, 16, 6, 'Y', 'TKN-MCH-20260912-6-2779', 'bheem123', 1, '2026-09-12', '2026-09-12 11:46:56', '2026-09-12 11:46:56', 0, NULL),
(107, 17, 6, 'Y', 'TKN-MCH-20260912-6-2779', 'bheem123', 1, '2026-09-12', '2026-09-12 11:46:56', '2026-09-12 11:46:56', 0, NULL),
(108, 18, 6, 'Y', 'TKN-MCH-20260912-6-2779', 'bheem123', 1, '2026-09-12', '2026-09-12 11:46:56', '2026-09-12 11:46:56', 0, NULL),
(109, 19, 6, 'Y', 'TKN-MCH-20260912-6-2779', 'bheem123', 1, '2026-09-12', '2026-09-12 11:46:56', '2026-09-12 11:46:56', 0, NULL),
(110, 20, 6, 'Y', 'TKN-MCH-20260912-6-2779', 'bheem123', 1, '2026-09-12', '2026-09-12 11:46:56', '2026-09-12 11:46:56', 0, NULL),
(111, 21, 6, 'Y', 'TKN-MCH-20260912-6-2779', 'bheem123', 1, '2026-09-12', '2026-09-12 11:46:56', '2026-09-12 11:46:56', 0, NULL),
(112, 22, 6, 'Y', 'TKN-MCH-20260912-6-2779', 'bheem123', 1, '2026-09-12', '2026-09-12 11:46:56', '2026-09-12 11:46:56', 0, NULL),
(113, 23, 6, 'Y', 'TKN-MCH-20260912-6-2779', 'bheem123', 1, '2026-09-12', '2026-09-12 11:46:56', '2026-09-12 11:46:56', 0, NULL),
(114, 24, 6, 'Y', 'TKN-MCH-20260912-6-2779', 'bheem123', 1, '2026-09-12', '2026-09-12 11:46:56', '2026-09-12 11:46:56', 0, NULL),
(115, 25, 6, 'Y', 'TKN-MCH-20260912-6-2779', 'bheem123', 1, '2026-09-12', '2026-09-12 11:46:56', '2026-09-12 11:46:56', 0, NULL),
(116, 26, 6, 'Y', 'TKN-MCH-20260912-6-2779', 'bheem123', 1, '2026-09-12', '2026-09-12 11:46:56', '2026-09-12 11:46:56', 0, NULL),
(117, 27, 6, 'Y', 'TKN-MCH-20260912-6-2779', 'bheem123', 1, '2026-09-12', '2026-09-12 11:46:56', '2026-09-12 11:46:56', 0, NULL),
(118, 28, 6, 'Y', 'TKN-MCH-20260912-6-2779', 'bheem123', 1, '2026-09-12', '2026-09-12 11:46:56', '2026-09-12 11:46:56', 0, NULL),
(119, 29, 6, 'Y', 'TKN-MCH-20260912-6-2779', 'bheem123', 1, '2026-09-12', '2026-09-12 11:46:56', '2026-09-12 11:46:56', 0, NULL),
(120, 30, 6, 'Y', 'TKN-MCH-20260912-6-2779', 'bheem123', 1, '2026-09-12', '2026-09-12 11:46:56', '2026-09-12 11:46:56', 0, NULL);

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
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_pantry_chemical_report`
--

INSERT INTO `mcc_intensive_pantry_chemical_report` (`id`, `parameter_id`, `qty_used`, `token_id`, `auditor_name`, `station_id`, `train_no`, `coach_no`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(1, 1, 10.00, 'TKN-PTRY-20260907-280', 'Bheem Chand', 1, '12345', 'C1', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:15:42', 0, NULL),
(2, 2, 10.00, 'TKN-PTRY-20260907-280', 'Bheem Chand', 1, '12345', 'C1', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:15:42', 0, NULL),
(3, 3, 8.00, 'TKN-PTRY-20260907-280', 'Bheem Chand', 1, '12345', 'C1', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:15:42', 0, NULL),
(4, 4, 10.00, 'TKN-PTRY-20260907-280', 'Bheem Chand', 1, '12345', 'C1', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:15:42', 0, NULL),
(5, 5, 10.00, 'TKN-PTRY-20260907-280', 'Bheem Chand', 1, '12345', 'C1', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:15:42', 0, NULL),
(6, 6, 10.00, 'TKN-PTRY-20260907-280', 'Bheem Chand', 1, '12345', 'C1', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:15:42', 0, NULL),
(7, 7, 5.00, 'TKN-PTRY-20260907-280', 'Bheem Chand', 1, '12345', 'C1', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:15:42', 0, NULL),
(8, 8, 10.00, 'TKN-PTRY-20260907-280', 'Bheem Chand', 1, '12345', 'C1', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:15:42', 0, NULL),
(9, 1, NULL, 'TKN-PTRY-20260908-633', 'Bheem Chand', 1, '12315', '01', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:28', 0, NULL),
(10, 2, NULL, 'TKN-PTRY-20260908-633', 'Bheem Chand', 1, '12315', '01', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:28', 0, NULL),
(11, 3, NULL, 'TKN-PTRY-20260908-633', 'Bheem Chand', 1, '12315', '01', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:28', 0, NULL),
(12, 4, NULL, 'TKN-PTRY-20260908-633', 'Bheem Chand', 1, '12315', '01', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:28', 0, NULL),
(13, 5, NULL, 'TKN-PTRY-20260908-633', 'Bheem Chand', 1, '12315', '01', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:28', 0, NULL),
(14, 6, NULL, 'TKN-PTRY-20260908-633', 'Bheem Chand', 1, '12315', '01', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:28', 0, NULL),
(15, 7, NULL, 'TKN-PTRY-20260908-633', 'Bheem Chand', 1, '12315', '01', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:28', 0, NULL),
(16, 8, NULL, 'TKN-PTRY-20260908-633', 'Bheem Chand', 1, '12315', '01', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:28', 0, NULL),
(17, 1, NULL, 'TKN-PTRY-20260909-440', 'Bheem Chand', 1, '22781', '02', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:11', 0, NULL),
(18, 2, NULL, 'TKN-PTRY-20260909-440', 'Bheem Chand', 1, '22781', '02', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:11', 0, NULL),
(19, 3, NULL, 'TKN-PTRY-20260909-440', 'Bheem Chand', 1, '22781', '02', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:11', 0, NULL),
(20, 4, NULL, 'TKN-PTRY-20260909-440', 'Bheem Chand', 1, '22781', '02', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:11', 0, NULL),
(21, 5, NULL, 'TKN-PTRY-20260909-440', 'Bheem Chand', 1, '22781', '02', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:11', 0, NULL),
(22, 6, NULL, 'TKN-PTRY-20260909-440', 'Bheem Chand', 1, '22781', '02', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:11', 0, NULL),
(23, 7, NULL, 'TKN-PTRY-20260909-440', 'Bheem Chand', 1, '22781', '02', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:11', 0, NULL),
(24, 8, NULL, 'TKN-PTRY-20260909-440', 'Bheem Chand', 1, '22781', '02', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:11', 0, NULL);

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
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_pantry_machine_report`
--

INSERT INTO `mcc_intensive_pantry_machine_report` (`id`, `parameter_id`, `shift_id`, `used_status`, `token_id`, `auditor_name`, `station_id`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(1, 16, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31', 0, NULL),
(2, 17, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31', 0, NULL),
(3, 18, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31', 0, NULL),
(4, 19, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31', 0, NULL),
(5, 20, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31', 0, NULL),
(6, 21, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31', 0, NULL),
(7, 22, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31', 0, NULL),
(8, 23, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31', 0, NULL),
(9, 24, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31', 0, NULL),
(10, 25, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31', 0, NULL),
(11, 26, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31', 0, NULL),
(12, 27, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31', 0, NULL),
(13, 28, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31', 0, NULL),
(14, 29, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31', 0, NULL),
(15, 30, 4, 'Y', 'TKN-PC-MCH-20260907-4-1489', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:31', '2026-09-07 14:31:31', 0, NULL),
(16, 16, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43', 0, NULL),
(17, 17, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43', 0, NULL),
(18, 18, 5, 'N', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43', 0, NULL),
(19, 19, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43', 0, NULL),
(20, 20, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43', 0, NULL),
(21, 21, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43', 0, NULL),
(22, 22, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43', 0, NULL),
(23, 23, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43', 0, NULL),
(24, 24, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43', 0, NULL),
(25, 25, 5, 'N', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43', 0, NULL),
(26, 26, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43', 0, NULL),
(27, 27, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43', 0, NULL),
(28, 28, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43', 0, NULL),
(29, 29, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43', 0, NULL),
(30, 30, 5, 'Y', 'TKN-PC-MCH-20260907-5-2809', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:43', '2026-09-07 14:31:43', 0, NULL),
(31, 16, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49', 0, NULL),
(32, 17, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49', 0, NULL),
(33, 18, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49', 0, NULL),
(34, 19, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49', 0, NULL),
(35, 20, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49', 0, NULL),
(36, 21, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49', 0, NULL),
(37, 22, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49', 0, NULL),
(38, 23, 6, 'N', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49', 0, NULL),
(39, 24, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49', 0, NULL),
(40, 25, 6, 'N', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49', 0, NULL),
(41, 26, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49', 0, NULL),
(42, 27, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49', 0, NULL),
(43, 28, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49', 0, NULL),
(44, 29, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49', 0, NULL),
(45, 30, 6, 'Y', 'TKN-PC-MCH-20260907-6-4896', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:31:49', '2026-09-07 14:31:49', 0, NULL);

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
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_pantry_report`
--

INSERT INTO `mcc_intensive_pantry_report` (`id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `auditor_name`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(1, 1, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(2, 2, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(3, 3, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(4, 4, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(5, 5, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(6, 6, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(7, 7, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(8, 8, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(9, 9, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(10, 10, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(11, 11, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(12, 12, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(13, 13, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(14, 14, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(15, 15, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(16, 16, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(17, 17, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(18, 18, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(19, 19, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(20, 20, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(21, 21, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(22, 22, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(23, 23, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(24, 24, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(25, 25, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(26, 26, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(27, 27, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(28, 28, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(29, 29, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(30, 30, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(31, 31, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(32, 32, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(33, 33, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(34, 34, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(35, 35, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(36, 36, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(37, 37, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(38, 38, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(39, 39, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(40, 40, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(41, 41, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(42, 42, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(43, 43, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(44, 44, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(45, 45, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(46, 46, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(47, 47, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(48, 48, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(49, 49, 1, 'TKN-PTRY-20260907-280', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:15:18', '2026-09-07 14:20:09', 0, NULL),
(50, 1, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:30', 0, NULL),
(51, 2, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:34', 0, NULL),
(52, 3, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:34', 0, NULL),
(53, 4, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:34', 0, NULL),
(54, 5, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:34', 0, NULL),
(55, 6, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:34', 0, NULL),
(56, 7, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:34', 0, NULL),
(57, 8, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:38', 0, NULL),
(58, 9, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:38', 0, NULL),
(59, 10, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:38', 0, NULL),
(60, 11, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:38', 0, NULL),
(61, 12, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:41', 0, NULL),
(62, 13, 1, 'TKN-PTRY-20260908-633', '12315', '01', '2', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:46', 0, NULL),
(63, 14, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:46', 0, NULL),
(64, 15, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:53', 0, NULL),
(65, 16, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:53', 0, NULL),
(66, 17, 1, 'TKN-PTRY-20260908-633', '12315', '01', '2', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:53', 0, NULL),
(67, 18, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:19:53', 0, NULL),
(68, 19, 1, 'TKN-PTRY-20260908-633', '12315', '01', '2', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:04', 0, NULL),
(69, 20, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:04', 0, NULL),
(70, 21, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:09', 0, NULL),
(71, 22, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:09', 0, NULL),
(72, 23, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:13', 0, NULL),
(73, 24, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:13', 0, NULL),
(74, 25, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:13', 0, NULL),
(75, 26, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:13', 0, NULL),
(76, 27, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:22', 0, NULL),
(77, 28, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:26', 0, NULL),
(78, 29, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:26', 0, NULL),
(79, 30, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:26', 0, NULL),
(80, 31, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:26', 0, NULL),
(81, 32, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:30', 0, NULL),
(82, 33, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:30', 0, NULL),
(83, 34, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:38', 0, NULL),
(84, 35, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:41', 0, NULL),
(85, 36, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:41', 0, NULL),
(86, 37, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:44', 0, NULL),
(87, 38, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:44', 0, NULL),
(88, 39, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:51', 0, NULL),
(89, 40, 1, 'TKN-PTRY-20260908-633', '12315', '01', '2', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:51', 0, NULL),
(90, 41, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:51', 0, NULL),
(91, 42, 1, 'TKN-PTRY-20260908-633', '12315', '01', '2', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:51', 0, NULL),
(92, 43, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:55', 0, NULL),
(93, 44, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:55', 0, NULL),
(94, 45, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:20:55', 0, NULL),
(95, 46, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:21:00', 0, NULL),
(96, 47, 1, 'TKN-PTRY-20260908-633', '12315', '01', '2', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:21:00', 0, NULL),
(97, 48, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:21:00', 0, NULL),
(98, 49, 1, 'TKN-PTRY-20260908-633', '12315', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:19:28', '2026-09-08 13:21:00', 0, NULL),
(99, 1, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:15', 0, NULL),
(100, 2, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:22', 0, NULL),
(101, 3, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:22', 0, NULL),
(102, 4, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:22', 0, NULL),
(103, 5, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:22', 0, NULL),
(104, 6, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:22', 0, NULL),
(105, 7, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:22', 0, NULL),
(106, 8, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:25', 0, NULL),
(107, 9, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:25', 0, NULL),
(108, 10, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:25', 0, NULL),
(109, 11, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:25', 0, NULL),
(110, 12, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:30', 0, NULL),
(111, 13, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:34', 0, NULL),
(112, 14, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:34', 0, NULL),
(113, 15, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:46', 0, NULL),
(114, 16, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:46', 0, NULL),
(115, 17, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:46', 0, NULL),
(116, 18, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:46', 0, NULL),
(117, 19, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:49', 0, NULL),
(118, 20, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:49', 0, NULL),
(119, 21, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:53', 0, NULL),
(120, 22, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:53', 0, NULL),
(121, 23, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:56', 0, NULL),
(122, 24, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:56', 0, NULL),
(123, 25, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:56', 0, NULL),
(124, 26, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:56', 0, NULL),
(125, 27, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:51:59', 0, NULL),
(126, 28, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:04', 0, NULL),
(127, 29, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:04', 0, NULL),
(128, 30, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:04', 0, NULL),
(129, 31, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:04', 0, NULL),
(130, 32, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:10', 0, NULL),
(131, 33, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:10', 0, NULL),
(132, 34, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:15', 0, NULL),
(133, 35, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:21', 0, NULL),
(134, 36, 1, 'TKN-PTRY-20260909-440', '22781', '02', '1', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:21', 0, NULL),
(135, 37, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:24', 0, NULL),
(136, 38, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:24', 0, NULL),
(137, 39, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:27', 0, NULL),
(138, 40, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:27', 0, NULL),
(139, 41, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:27', 0, NULL),
(140, 42, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:27', 0, NULL),
(141, 43, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:33', 0, NULL),
(142, 44, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:33', 0, NULL),
(143, 45, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:33', 0, NULL),
(144, 46, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:38', 0, NULL),
(145, 47, 1, 'TKN-PTRY-20260909-440', '22781', '02', '2', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:38', 0, NULL),
(146, 48, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:38', 0, NULL),
(147, 49, 1, 'TKN-PTRY-20260909-440', '22781', '02', '3', 'Bheem Chand', '2026-09-09', '2026-09-09 07:51:11', '2026-09-09 07:52:38', 0, NULL);

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
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_scorecard_2_report`
--

INSERT INTO `mcc_intensive_scorecard_2_report` (`id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `submitted_by`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(1, 1, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(2, 2, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(3, 3, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:10:34', 0, NULL),
(4, 4, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(5, 5, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(6, 6, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:10:34', 0, NULL),
(7, 7, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:10:34', 0, NULL),
(8, 8, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:10:43', 0, NULL),
(9, 9, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:10:43', 0, NULL),
(10, 10, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(11, 11, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(12, 12, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(13, 13, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(14, 14, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(15, 15, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:10:57', 0, NULL),
(16, 16, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(17, 17, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:10:57', 0, NULL),
(18, 18, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(19, 19, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(20, 20, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:10:57', 0, NULL),
(21, 21, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:10:57', 0, NULL),
(22, 22, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(23, 23, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(24, 24, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(25, 25, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(26, 26, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(27, 27, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(28, 28, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(29, 29, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(30, 30, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(31, 31, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(32, 32, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(33, 33, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(34, 34, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(35, 35, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(36, 36, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(37, 37, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(38, 38, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(39, 39, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:21', 0, NULL),
(40, 40, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:21', 0, NULL),
(41, 41, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(42, 42, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(43, 43, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(44, 44, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:21', 0, NULL),
(45, 45, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:26', 0, NULL),
(46, 46, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:32', 0, NULL),
(47, 47, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(48, 48, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(49, 49, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:32', 0, NULL),
(50, 50, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(51, 51, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(52, 52, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:44', 0, NULL),
(53, 53, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(54, 54, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(55, 55, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(56, 56, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:44', 0, NULL),
(57, 57, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:44', 0, NULL),
(58, 58, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:44', 0, NULL),
(59, 59, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(60, 60, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(61, 61, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:11:44', 0, NULL),
(62, 62, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(63, 63, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(64, 64, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(65, 65, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(66, 66, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(67, 67, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:12:00', 0, NULL),
(68, 68, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(69, 69, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:12:00', 0, NULL),
(70, 70, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(71, 71, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:12:00', 0, NULL),
(72, 72, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(73, 73, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(74, 74, 1, 'TKN-20260907-989', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(75, 75, 1, 'TKN-20260907-989', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:12:05', 0, NULL),
(76, 76, 1, 'TKN-20260907-989', '12345', 'C1', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(77, 1, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(78, 2, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(79, 3, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(80, 4, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(81, 5, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(82, 6, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(83, 7, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(84, 8, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(85, 9, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(86, 10, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(87, 11, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(88, 12, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(89, 13, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(90, 14, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(91, 15, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(92, 16, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(93, 17, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(94, 18, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(95, 19, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(96, 20, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(97, 21, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(98, 22, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(99, 23, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(100, 24, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(101, 25, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(102, 26, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(103, 27, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(104, 28, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(105, 29, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(106, 30, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(107, 31, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(108, 32, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(109, 33, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(110, 34, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(111, 35, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(112, 36, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(113, 37, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(114, 38, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(115, 39, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(116, 40, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(117, 41, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(118, 42, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(119, 43, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(120, 44, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(121, 45, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(122, 46, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(123, 47, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(124, 48, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(125, 49, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(126, 50, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(127, 51, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(128, 52, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(129, 53, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(130, 54, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(131, 55, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(132, 56, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(133, 57, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(134, 58, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(135, 59, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(136, 60, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(137, 61, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(138, 62, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(139, 63, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(140, 64, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(141, 65, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(142, 66, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(143, 67, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(144, 68, 1, 'TKN-20260907-989', '12345', 'C2', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(145, 69, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(146, 70, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(147, 71, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(148, 72, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(149, 73, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(150, 74, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(151, 75, 1, 'TKN-20260907-989', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(152, 76, 1, 'TKN-20260907-989', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(153, 1, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(154, 2, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(155, 3, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(156, 4, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(157, 5, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(158, 6, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(159, 7, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(160, 8, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(161, 9, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(162, 10, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(163, 11, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(164, 12, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(165, 13, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(166, 14, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(167, 15, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(168, 16, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(169, 17, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(170, 18, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(171, 19, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(172, 20, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(173, 21, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(174, 22, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(175, 23, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(176, 24, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(177, 25, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(178, 26, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(179, 27, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(180, 28, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(181, 29, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(182, 30, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(183, 31, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(184, 32, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(185, 33, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(186, 34, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(187, 35, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(188, 36, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(189, 37, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(190, 38, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(191, 39, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(192, 40, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(193, 41, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(194, 42, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(195, 43, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(196, 44, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(197, 45, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(198, 46, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(199, 47, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(200, 48, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(201, 49, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(202, 50, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(203, 51, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(204, 52, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(205, 53, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(206, 54, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(207, 55, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(208, 56, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(209, 57, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(210, 58, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(211, 59, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(212, 60, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(213, 61, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(214, 62, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(215, 63, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(216, 64, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(217, 65, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(218, 66, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(219, 67, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(220, 68, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(221, 69, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(222, 70, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(223, 71, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(224, 72, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(225, 73, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(226, 74, 1, 'TKN-20260907-989', '12345', 'C3', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(227, 75, 1, 'TKN-20260907-989', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(228, 76, 1, 'TKN-20260907-989', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(229, 1, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(230, 2, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(231, 3, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(232, 4, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(233, 5, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(234, 6, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(235, 7, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(236, 8, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(237, 9, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(238, 10, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(239, 11, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(240, 12, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(241, 13, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(242, 14, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(243, 15, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(244, 16, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(245, 17, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(246, 18, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(247, 19, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(248, 20, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(249, 21, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(250, 22, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(251, 23, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(252, 24, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(253, 25, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(254, 26, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(255, 27, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(256, 28, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(257, 29, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(258, 30, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(259, 31, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(260, 32, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(261, 33, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(262, 34, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(263, 35, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(264, 36, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(265, 37, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(266, 38, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(267, 39, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(268, 40, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(269, 41, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(270, 42, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(271, 43, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(272, 44, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(273, 45, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(274, 46, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(275, 47, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(276, 48, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(277, 49, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(278, 50, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(279, 51, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(280, 52, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(281, 53, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(282, 54, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(283, 55, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(284, 56, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(285, 57, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(286, 58, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(287, 59, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(288, 60, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(289, 61, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(290, 62, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(291, 63, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(292, 64, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(293, 65, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(294, 66, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(295, 67, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(296, 68, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(297, 69, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(298, 70, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(299, 71, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(300, 72, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(301, 73, 1, 'TKN-20260907-989', '12345', 'C4', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(302, 74, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(303, 75, 1, 'TKN-20260907-989', '12345', 'C4', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(304, 76, 1, 'TKN-20260907-989', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:10:23', '2026-09-07 14:14:40', 0, NULL),
(305, 1, 1, 'TKN-20260908-027', '12345', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:35:07', 0, NULL),
(306, 2, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(307, 3, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(308, 4, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(309, 5, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(310, 6, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(311, 7, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(312, 8, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(313, 9, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(314, 10, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(315, 11, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(316, 12, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(317, 13, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(318, 14, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(319, 15, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(320, 16, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(321, 17, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(322, 18, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(323, 19, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(324, 20, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(325, 21, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(326, 22, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(327, 23, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(328, 24, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(329, 25, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(330, 26, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(331, 27, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(332, 28, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(333, 29, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(334, 30, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(335, 31, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(336, 32, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(337, 33, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(338, 34, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(339, 35, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(340, 36, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(341, 37, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(342, 38, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(343, 39, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(344, 40, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(345, 41, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(346, 42, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(347, 43, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(348, 44, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(349, 45, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(350, 46, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(351, 47, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(352, 48, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(353, 49, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(354, 50, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(355, 51, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(356, 52, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(357, 53, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(358, 54, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(359, 55, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(360, 56, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(361, 57, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(362, 58, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(363, 59, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(364, 60, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(365, 61, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(366, 62, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(367, 63, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(368, 64, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(369, 65, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(370, 66, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(371, 67, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL);
INSERT INTO `mcc_intensive_scorecard_2_report` (`id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `submitted_by`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(372, 68, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(373, 69, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(374, 70, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(375, 71, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(376, 72, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(377, 73, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(378, 74, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(379, 75, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(380, 76, 1, 'TKN-20260908-027', '12345', '1', '', 'Ajit', '2026-09-08', '2026-09-08 07:28:54', '2026-09-08 07:28:54', 0, NULL),
(381, 1, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:17', 0, NULL),
(382, 2, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:21', 0, NULL),
(383, 3, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:21', 0, NULL),
(384, 4, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:21', 0, NULL),
(385, 5, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:21', 0, NULL),
(386, 6, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:21', 0, NULL),
(387, 7, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:21', 0, NULL),
(388, 8, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:25', 0, NULL),
(389, 9, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:25', 0, NULL),
(390, 10, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:25', 0, NULL),
(391, 11, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:25', 0, NULL),
(392, 12, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:32', 0, NULL),
(393, 13, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36', 0, NULL),
(394, 14, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36', 0, NULL),
(395, 15, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36', 0, NULL),
(396, 16, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36', 0, NULL),
(397, 17, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36', 0, NULL),
(398, 18, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36', 0, NULL),
(399, 19, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36', 0, NULL),
(400, 20, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36', 0, NULL),
(401, 21, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36', 0, NULL),
(402, 22, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:14:36', 0, NULL),
(403, 23, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42', 0, NULL),
(404, 24, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42', 0, NULL),
(405, 25, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42', 0, NULL),
(406, 26, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42', 0, NULL),
(407, 27, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42', 0, NULL),
(408, 28, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42', 0, NULL),
(409, 29, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42', 0, NULL),
(410, 30, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42', 0, NULL),
(411, 31, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42', 0, NULL),
(412, 32, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42', 0, NULL),
(413, 33, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42', 0, NULL),
(414, 34, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:42', 0, NULL),
(415, 35, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:45', 0, NULL),
(416, 36, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:45', 0, NULL),
(417, 37, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:48', 0, NULL),
(418, 38, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:48', 0, NULL),
(419, 39, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:55', 0, NULL),
(420, 40, 1, 'TKN-20260908-341', '12315', '1', '2', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:55', 0, NULL),
(421, 41, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:55', 0, NULL),
(422, 42, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:55', 0, NULL),
(423, 43, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:55', 0, NULL),
(424, 44, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:55', 0, NULL),
(425, 45, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:15:58', 0, NULL),
(426, 46, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:03', 0, NULL),
(427, 47, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:03', 0, NULL),
(428, 48, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:03', 0, NULL),
(429, 49, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:03', 0, NULL),
(430, 50, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:03', 0, NULL),
(431, 51, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:03', 0, NULL),
(432, 52, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07', 0, NULL),
(433, 53, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07', 0, NULL),
(434, 54, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07', 0, NULL),
(435, 55, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07', 0, NULL),
(436, 56, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07', 0, NULL),
(437, 57, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07', 0, NULL),
(438, 58, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07', 0, NULL),
(439, 59, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07', 0, NULL),
(440, 60, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07', 0, NULL),
(441, 61, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:07', 0, NULL),
(442, 62, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14', 0, NULL),
(443, 63, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14', 0, NULL),
(444, 64, 1, 'TKN-20260908-341', '12315', '1', '2', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14', 0, NULL),
(445, 65, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14', 0, NULL),
(446, 66, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14', 0, NULL),
(447, 67, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14', 0, NULL),
(448, 68, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14', 0, NULL),
(449, 69, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14', 0, NULL),
(450, 70, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14', 0, NULL),
(451, 71, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:14', 0, NULL),
(452, 72, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:18', 0, NULL),
(453, 73, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:21', 0, NULL),
(454, 74, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:21', 0, NULL),
(455, 75, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:24', 0, NULL),
(456, 76, 1, 'TKN-20260908-341', '12315', '1', '3', 'Ajit', '2026-09-08', '2026-09-08 07:34:44', '2026-09-08 13:16:24', 0, NULL),
(457, 1, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:37', 0, NULL),
(458, 2, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:40', 0, NULL),
(459, 3, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:40', 0, NULL),
(460, 4, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:40', 0, NULL),
(461, 5, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:40', 0, NULL),
(462, 6, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:40', 0, NULL),
(463, 7, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:40', 0, NULL),
(464, 8, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:46', 0, NULL),
(465, 9, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:46', 0, NULL),
(466, 10, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:46', 0, NULL),
(467, 11, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:46', 0, NULL),
(468, 12, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:50', 0, NULL),
(469, 13, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54', 0, NULL),
(470, 14, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54', 0, NULL),
(471, 15, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54', 0, NULL),
(472, 16, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54', 0, NULL),
(473, 17, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54', 0, NULL),
(474, 18, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54', 0, NULL),
(475, 19, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54', 0, NULL),
(476, 20, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54', 0, NULL),
(477, 21, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54', 0, NULL),
(478, 22, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:54', 0, NULL),
(479, 23, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59', 0, NULL),
(480, 24, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59', 0, NULL),
(481, 25, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59', 0, NULL),
(482, 26, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59', 0, NULL),
(483, 27, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59', 0, NULL),
(484, 28, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59', 0, NULL),
(485, 29, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59', 0, NULL),
(486, 30, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59', 0, NULL),
(487, 31, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59', 0, NULL),
(488, 32, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59', 0, NULL),
(489, 33, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59', 0, NULL),
(490, 34, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:46:59', 0, NULL),
(491, 35, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:02', 0, NULL),
(492, 36, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:02', 0, NULL),
(493, 37, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:05', 0, NULL),
(494, 38, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:05', 0, NULL),
(495, 39, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:09', 0, NULL),
(496, 40, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:09', 0, NULL),
(497, 41, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:09', 0, NULL),
(498, 42, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:09', 0, NULL),
(499, 43, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:09', 0, NULL),
(500, 44, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:09', 0, NULL),
(501, 45, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:13', 0, NULL),
(502, 46, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:18', 0, NULL),
(503, 47, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:18', 0, NULL),
(504, 48, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:18', 0, NULL),
(505, 49, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:18', 0, NULL),
(506, 50, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:18', 0, NULL),
(507, 51, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:18', 0, NULL),
(508, 52, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25', 0, NULL),
(509, 53, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25', 0, NULL),
(510, 54, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25', 0, NULL),
(511, 55, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25', 0, NULL),
(512, 56, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25', 0, NULL),
(513, 57, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25', 0, NULL),
(514, 58, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25', 0, NULL),
(515, 59, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25', 0, NULL),
(516, 60, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25', 0, NULL),
(517, 61, 1, 'TKN-20260908-286', '16236', '1', '2', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:25', 0, NULL),
(518, 62, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31', 0, NULL),
(519, 63, 1, 'TKN-20260908-286', '16236', '1', '2', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31', 0, NULL),
(520, 64, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31', 0, NULL),
(521, 65, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31', 0, NULL),
(522, 66, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31', 0, NULL),
(523, 67, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31', 0, NULL),
(524, 68, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31', 0, NULL),
(525, 69, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31', 0, NULL),
(526, 70, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31', 0, NULL),
(527, 71, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:31', 0, NULL),
(528, 72, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:34', 0, NULL),
(529, 73, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:38', 0, NULL),
(530, 74, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:38', 0, NULL),
(531, 75, 1, 'TKN-20260908-286', '16236', '1', '3', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:43', 0, NULL),
(532, 76, 1, 'TKN-20260908-286', '16236', '1', '2', 'Smc', '2026-09-08', '2026-09-08 07:46:04', '2026-09-08 07:47:43', 0, NULL),
(533, 1, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:05', 0, NULL),
(534, 2, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:08', 0, NULL),
(535, 3, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:08', 0, NULL),
(536, 4, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:08', 0, NULL),
(537, 5, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:08', 0, NULL),
(538, 6, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:08', 0, NULL),
(539, 7, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:08', 0, NULL),
(540, 8, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:12', 0, NULL),
(541, 9, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:12', 0, NULL),
(542, 10, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:12', 0, NULL),
(543, 11, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:12', 0, NULL),
(544, 12, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:15', 0, NULL),
(545, 13, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25', 0, NULL),
(546, 14, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25', 0, NULL),
(547, 15, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25', 0, NULL),
(548, 16, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25', 0, NULL),
(549, 17, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25', 0, NULL),
(550, 18, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25', 0, NULL),
(551, 19, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25', 0, NULL),
(552, 20, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25', 0, NULL),
(553, 21, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25', 0, NULL),
(554, 22, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:25', 0, NULL),
(555, 23, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33', 0, NULL),
(556, 24, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33', 0, NULL),
(557, 25, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33', 0, NULL),
(558, 26, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33', 0, NULL),
(559, 27, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33', 0, NULL),
(560, 28, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33', 0, NULL),
(561, 29, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33', 0, NULL),
(562, 30, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33', 0, NULL),
(563, 31, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33', 0, NULL),
(564, 32, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33', 0, NULL),
(565, 33, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33', 0, NULL),
(566, 34, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:33', 0, NULL),
(567, 35, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:44', 0, NULL),
(568, 36, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:44', 0, NULL),
(569, 37, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:38', 0, NULL),
(570, 38, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:38', 0, NULL),
(571, 39, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:53', 0, NULL),
(572, 40, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:53', 0, NULL),
(573, 41, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:53', 0, NULL),
(574, 42, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:53', 0, NULL),
(575, 43, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:53', 0, NULL),
(576, 44, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:53', 0, NULL),
(577, 45, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:23:58', 0, NULL),
(578, 46, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:01', 0, NULL),
(579, 47, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:01', 0, NULL),
(580, 48, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:01', 0, NULL),
(581, 49, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:01', 0, NULL),
(582, 50, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:01', 0, NULL),
(583, 51, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:01', 0, NULL),
(584, 52, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11', 0, NULL),
(585, 53, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11', 0, NULL),
(586, 54, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11', 0, NULL),
(587, 55, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11', 0, NULL),
(588, 56, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11', 0, NULL),
(589, 57, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11', 0, NULL),
(590, 58, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11', 0, NULL),
(591, 59, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11', 0, NULL),
(592, 60, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11', 0, NULL),
(593, 61, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:11', 0, NULL),
(594, 62, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18', 0, NULL),
(595, 63, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18', 0, NULL),
(596, 64, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18', 0, NULL),
(597, 65, 1, 'TKN-20260909-536', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18', 0, NULL),
(598, 66, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18', 0, NULL),
(599, 67, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18', 0, NULL),
(600, 68, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18', 0, NULL),
(601, 69, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18', 0, NULL),
(602, 70, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18', 0, NULL),
(603, 71, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:18', 0, NULL),
(604, 72, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:22', 0, NULL),
(605, 73, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:25', 0, NULL),
(606, 74, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:25', 0, NULL),
(607, 75, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:28', 0, NULL),
(608, 76, 1, 'TKN-20260909-536', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:28', 0, NULL),
(609, 1, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:36', 0, NULL),
(610, 2, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:41', 0, NULL),
(611, 3, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:41', 0, NULL),
(612, 4, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:41', 0, NULL),
(613, 5, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:41', 0, NULL),
(614, 6, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:41', 0, NULL),
(615, 7, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:41', 0, NULL),
(616, 8, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:51', 0, NULL),
(617, 9, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:51', 0, NULL),
(618, 10, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:51', 0, NULL),
(619, 11, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:51', 0, NULL),
(620, 12, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:24:55', 0, NULL),
(621, 13, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03', 0, NULL),
(622, 14, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03', 0, NULL),
(623, 15, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03', 0, NULL),
(624, 16, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03', 0, NULL),
(625, 17, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03', 0, NULL),
(626, 18, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03', 0, NULL),
(627, 19, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03', 0, NULL),
(628, 20, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03', 0, NULL),
(629, 21, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03', 0, NULL),
(630, 22, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:03', 0, NULL),
(631, 23, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08', 0, NULL),
(632, 24, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08', 0, NULL),
(633, 25, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08', 0, NULL),
(634, 26, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08', 0, NULL),
(635, 27, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08', 0, NULL),
(636, 28, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08', 0, NULL),
(637, 29, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08', 0, NULL),
(638, 30, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08', 0, NULL),
(639, 31, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08', 0, NULL),
(640, 32, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08', 0, NULL),
(641, 33, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08', 0, NULL),
(642, 34, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:08', 0, NULL),
(643, 35, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:14', 0, NULL),
(644, 36, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:14', 0, NULL),
(645, 37, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:19', 0, NULL),
(646, 38, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:19', 0, NULL),
(647, 39, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:29', 0, NULL),
(648, 40, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:29', 0, NULL),
(649, 41, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:29', 0, NULL),
(650, 42, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:29', 0, NULL),
(651, 43, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:29', 0, NULL),
(652, 44, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:29', 0, NULL),
(653, 45, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:35', 0, NULL),
(654, 46, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:44', 0, NULL),
(655, 47, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:44', 0, NULL),
(656, 48, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:44', 0, NULL),
(657, 49, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:44', 0, NULL),
(658, 50, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:44', 0, NULL),
(659, 51, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:44', 0, NULL),
(660, 52, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47', 0, NULL),
(661, 53, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47', 0, NULL),
(662, 54, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47', 0, NULL),
(663, 55, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47', 0, NULL),
(664, 56, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47', 0, NULL),
(665, 57, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47', 0, NULL),
(666, 58, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47', 0, NULL),
(667, 59, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47', 0, NULL),
(668, 60, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47', 0, NULL),
(669, 61, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:25:47', 0, NULL),
(670, 62, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01', 0, NULL),
(671, 63, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01', 0, NULL),
(672, 64, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01', 0, NULL),
(673, 65, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01', 0, NULL),
(674, 66, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01', 0, NULL),
(675, 67, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01', 0, NULL),
(676, 68, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01', 0, NULL),
(677, 69, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01', 0, NULL),
(678, 70, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01', 0, NULL),
(679, 71, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:01', 0, NULL),
(680, 72, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:11', 0, NULL),
(681, 73, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:14', 0, NULL),
(682, 74, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:14', 0, NULL),
(683, 75, 1, 'TKN-20260909-536', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:19', 0, NULL),
(684, 76, 1, 'TKN-20260909-536', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:22:52', '2026-09-09 07:26:19', 0, NULL),
(685, 1, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:27:59', 0, NULL),
(686, 2, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:13', 0, NULL),
(687, 3, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:13', 0, NULL),
(688, 4, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:13', 0, NULL),
(689, 5, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:13', 0, NULL),
(690, 6, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:13', 0, NULL),
(691, 7, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:13', 0, NULL),
(692, 8, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:18', 0, NULL),
(693, 9, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:18', 0, NULL),
(694, 10, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:18', 0, NULL),
(695, 11, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:18', 0, NULL),
(696, 12, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:21', 0, NULL),
(697, 13, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32', 0, NULL),
(698, 14, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32', 0, NULL),
(699, 15, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32', 0, NULL),
(700, 16, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32', 0, NULL),
(701, 17, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32', 0, NULL),
(702, 18, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32', 0, NULL),
(703, 19, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32', 0, NULL),
(704, 20, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32', 0, NULL),
(705, 21, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32', 0, NULL),
(706, 22, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:32', 0, NULL),
(707, 23, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39', 0, NULL),
(708, 24, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39', 0, NULL),
(709, 25, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39', 0, NULL),
(710, 26, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39', 0, NULL),
(711, 27, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39', 0, NULL),
(712, 28, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39', 0, NULL),
(713, 29, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39', 0, NULL),
(714, 30, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39', 0, NULL),
(715, 31, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39', 0, NULL),
(716, 32, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39', 0, NULL),
(717, 33, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39', 0, NULL),
(718, 34, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:39', 0, NULL),
(719, 35, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:45', 0, NULL),
(720, 36, 1, 'TKN-20260909-635', '22687', '01', '1', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:45', 0, NULL),
(721, 37, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:49', 0, NULL),
(722, 38, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:49', 0, NULL),
(723, 39, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:52', 0, NULL),
(724, 40, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:52', 0, NULL),
(725, 41, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:52', 0, NULL),
(726, 42, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:52', 0, NULL),
(727, 43, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:52', 0, NULL),
(728, 44, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:52', 0, NULL),
(729, 45, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:28:56', 0, NULL),
(730, 46, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:00', 0, NULL),
(731, 47, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:00', 0, NULL),
(732, 48, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:00', 0, NULL),
(733, 49, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:00', 0, NULL),
(734, 50, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:00', 0, NULL),
(735, 51, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:00', 0, NULL),
(736, 52, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08', 0, NULL),
(737, 53, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08', 0, NULL),
(738, 54, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08', 0, NULL),
(739, 55, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08', 0, NULL),
(740, 56, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08', 0, NULL),
(741, 57, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08', 0, NULL),
(742, 58, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08', 0, NULL),
(743, 59, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08', 0, NULL),
(744, 60, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08', 0, NULL),
(745, 61, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:08', 0, NULL),
(746, 62, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12', 0, NULL),
(747, 63, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12', 0, NULL),
(748, 64, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12', 0, NULL),
(749, 65, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12', 0, NULL),
(750, 66, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12', 0, NULL),
(751, 67, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12', 0, NULL),
(752, 68, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12', 0, NULL),
(753, 69, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12', 0, NULL);
INSERT INTO `mcc_intensive_scorecard_2_report` (`id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `submitted_by`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(754, 70, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12', 0, NULL),
(755, 71, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:12', 0, NULL),
(756, 72, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:16', 0, NULL),
(757, 73, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:21', 0, NULL),
(758, 74, 1, 'TKN-20260909-635', '22687', '01', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:21', 0, NULL),
(759, 75, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:25', 0, NULL),
(760, 76, 1, 'TKN-20260909-635', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:27:54', '2026-09-09 07:29:25', 0, NULL),
(761, 1, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:29:53', 0, NULL),
(762, 2, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:02', 0, NULL),
(763, 3, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:02', 0, NULL),
(764, 4, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:02', 0, NULL),
(765, 5, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:02', 0, NULL),
(766, 6, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:02', 0, NULL),
(767, 7, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:02', 0, NULL),
(768, 8, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:08', 0, NULL),
(769, 9, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:08', 0, NULL),
(770, 10, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:08', 0, NULL),
(771, 11, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:08', 0, NULL),
(772, 12, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:11', 0, NULL),
(773, 13, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20', 0, NULL),
(774, 14, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20', 0, NULL),
(775, 15, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20', 0, NULL),
(776, 16, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20', 0, NULL),
(777, 17, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20', 0, NULL),
(778, 18, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20', 0, NULL),
(779, 19, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20', 0, NULL),
(780, 20, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20', 0, NULL),
(781, 21, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20', 0, NULL),
(782, 22, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:20', 0, NULL),
(783, 23, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25', 0, NULL),
(784, 24, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25', 0, NULL),
(785, 25, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25', 0, NULL),
(786, 26, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25', 0, NULL),
(787, 27, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25', 0, NULL),
(788, 28, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25', 0, NULL),
(789, 29, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25', 0, NULL),
(790, 30, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25', 0, NULL),
(791, 31, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25', 0, NULL),
(792, 32, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25', 0, NULL),
(793, 33, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25', 0, NULL),
(794, 34, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:25', 0, NULL),
(795, 35, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:31', 0, NULL),
(796, 36, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:31', 0, NULL),
(797, 37, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:35', 0, NULL),
(798, 38, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:35', 0, NULL),
(799, 39, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:41', 0, NULL),
(800, 40, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:41', 0, NULL),
(801, 41, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:41', 0, NULL),
(802, 42, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:41', 0, NULL),
(803, 43, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:41', 0, NULL),
(804, 44, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:41', 0, NULL),
(805, 45, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:44', 0, NULL),
(806, 46, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:53', 0, NULL),
(807, 47, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:53', 0, NULL),
(808, 48, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:53', 0, NULL),
(809, 49, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:53', 0, NULL),
(810, 50, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:53', 0, NULL),
(811, 51, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:30:53', 0, NULL),
(812, 52, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06', 0, NULL),
(813, 53, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06', 0, NULL),
(814, 54, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06', 0, NULL),
(815, 55, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06', 0, NULL),
(816, 56, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06', 0, NULL),
(817, 57, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06', 0, NULL),
(818, 58, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06', 0, NULL),
(819, 59, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06', 0, NULL),
(820, 60, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06', 0, NULL),
(821, 61, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:06', 0, NULL),
(822, 62, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16', 0, NULL),
(823, 63, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16', 0, NULL),
(824, 64, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16', 0, NULL),
(825, 65, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16', 0, NULL),
(826, 66, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16', 0, NULL),
(827, 67, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16', 0, NULL),
(828, 68, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16', 0, NULL),
(829, 69, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16', 0, NULL),
(830, 70, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16', 0, NULL),
(831, 71, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:16', 0, NULL),
(832, 72, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:21', 0, NULL),
(833, 73, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:27', 0, NULL),
(834, 74, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:27', 0, NULL),
(835, 75, 1, 'TKN-20260909-989', '16227', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:32', 0, NULL),
(836, 76, 1, 'TKN-20260909-989', '16227', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:29:49', '2026-09-09 07:31:32', 0, NULL),
(837, 1, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:09', 0, NULL),
(838, 2, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:19', 0, NULL),
(839, 3, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:19', 0, NULL),
(840, 4, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:19', 0, NULL),
(841, 5, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:19', 0, NULL),
(842, 6, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:19', 0, NULL),
(843, 7, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:19', 0, NULL),
(844, 8, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:24', 0, NULL),
(845, 9, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:24', 0, NULL),
(846, 10, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:24', 0, NULL),
(847, 11, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:24', 0, NULL),
(848, 12, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:29', 0, NULL),
(849, 13, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34', 0, NULL),
(850, 14, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34', 0, NULL),
(851, 15, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34', 0, NULL),
(852, 16, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34', 0, NULL),
(853, 17, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34', 0, NULL),
(854, 18, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34', 0, NULL),
(855, 19, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34', 0, NULL),
(856, 20, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34', 0, NULL),
(857, 21, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34', 0, NULL),
(858, 22, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:34', 0, NULL),
(859, 23, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39', 0, NULL),
(860, 24, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39', 0, NULL),
(861, 25, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39', 0, NULL),
(862, 26, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39', 0, NULL),
(863, 27, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39', 0, NULL),
(864, 28, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39', 0, NULL),
(865, 29, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39', 0, NULL),
(866, 30, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39', 0, NULL),
(867, 31, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39', 0, NULL),
(868, 32, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39', 0, NULL),
(869, 33, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39', 0, NULL),
(870, 34, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:39', 0, NULL),
(871, 35, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:44', 0, NULL),
(872, 36, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:44', 0, NULL),
(873, 37, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:50', 0, NULL),
(874, 38, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:50', 0, NULL),
(875, 39, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:59', 0, NULL),
(876, 40, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:59', 0, NULL),
(877, 41, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:59', 0, NULL),
(878, 42, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:59', 0, NULL),
(879, 43, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:59', 0, NULL),
(880, 44, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:32:59', 0, NULL),
(881, 45, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:06', 0, NULL),
(882, 46, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:16', 0, NULL),
(883, 47, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:16', 0, NULL),
(884, 48, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:16', 0, NULL),
(885, 49, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:16', 0, NULL),
(886, 50, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:16', 0, NULL),
(887, 51, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:16', 0, NULL),
(888, 52, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19', 0, NULL),
(889, 53, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19', 0, NULL),
(890, 54, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19', 0, NULL),
(891, 55, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19', 0, NULL),
(892, 56, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19', 0, NULL),
(893, 57, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19', 0, NULL),
(894, 58, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19', 0, NULL),
(895, 59, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19', 0, NULL),
(896, 60, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19', 0, NULL),
(897, 61, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:19', 0, NULL),
(898, 62, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26', 0, NULL),
(899, 63, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26', 0, NULL),
(900, 64, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26', 0, NULL),
(901, 65, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26', 0, NULL),
(902, 66, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26', 0, NULL),
(903, 67, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26', 0, NULL),
(904, 68, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26', 0, NULL),
(905, 69, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26', 0, NULL),
(906, 70, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26', 0, NULL),
(907, 71, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:26', 0, NULL),
(908, 72, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:30', 0, NULL),
(909, 73, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:36', 0, NULL),
(910, 74, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:36', 0, NULL),
(911, 75, 1, 'TKN-20260909-880', '22781', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:45', 0, NULL),
(912, 76, 1, 'TKN-20260909-880', '22781', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:32:04', '2026-09-09 07:33:45', 0, NULL);

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
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_intensive_scorecard_report`
--

INSERT INTO `mcc_intensive_scorecard_report` (`id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `auditor_name`, `submitted_by`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(1, 13, 4, 'TKN-20260912-424', '123456', 'C1', '3', 'SCL AUDITOR', NULL, '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 07:55:24', 0, NULL),
(2, 14, 4, 'TKN-20260912-424', '123456', 'C1', '3', 'SCL AUDITOR', NULL, '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 07:55:24', 0, NULL),
(3, 15, 4, 'TKN-20260912-424', '123456', 'C1', '3', 'SCL AUDITOR', NULL, '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 07:55:24', 0, NULL),
(4, 16, 4, 'TKN-20260912-424', '123456', 'C1', '3', 'SCL AUDITOR', NULL, '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 07:55:24', 0, NULL),
(5, 17, 4, 'TKN-20260912-424', '123456', 'C1', '3', 'SCL AUDITOR', NULL, '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:00:14', 0, NULL),
(6, 18, 4, 'TKN-20260912-424', '123456', 'C1', 'Y', 'SCL AUDITOR', NULL, '2026-09-12', '2026-09-12 07:55:18', '2026-09-12 08:03:01', 0, NULL),
(7, 13, 4, 'TKN-20260915-476', '812601', 'S1', '', 'SCL AUDITOR', NULL, '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(8, 14, 4, 'TKN-20260915-476', '812601', 'S1', '', 'SCL AUDITOR', NULL, '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(9, 15, 4, 'TKN-20260915-476', '812601', 'S1', '', 'SCL AUDITOR', NULL, '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(10, 16, 4, 'TKN-20260915-476', '812601', 'S1', '', 'SCL AUDITOR', NULL, '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(11, 17, 4, 'TKN-20260915-476', '812601', 'S1', '', 'SCL AUDITOR', NULL, '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(12, 18, 4, 'TKN-20260915-476', '812601', 'S1', '', 'SCL AUDITOR', NULL, '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(13, 13, 4, 'TKN-20260915-476', '812601', 'S2', '', 'SCL AUDITOR', NULL, '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(14, 14, 4, 'TKN-20260915-476', '812601', 'S2', '', 'SCL AUDITOR', NULL, '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(15, 15, 4, 'TKN-20260915-476', '812601', 'S2', '', 'SCL AUDITOR', NULL, '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(16, 16, 4, 'TKN-20260915-476', '812601', 'S2', '', 'SCL AUDITOR', NULL, '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(17, 17, 4, 'TKN-20260915-476', '812601', 'S2', '', 'SCL AUDITOR', NULL, '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(18, 18, 4, 'TKN-20260915-476', '812601', 'S2', '', 'SCL AUDITOR', NULL, '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(19, 13, 4, 'TKN-20260915-476', '812601', 'S3', '', 'SCL AUDITOR', NULL, '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(20, 14, 4, 'TKN-20260915-476', '812601', 'S3', '', 'SCL AUDITOR', NULL, '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(21, 15, 4, 'TKN-20260915-476', '812601', 'S3', '', 'SCL AUDITOR', NULL, '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(22, 16, 4, 'TKN-20260915-476', '812601', 'S3', '', 'SCL AUDITOR', NULL, '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(23, 17, 4, 'TKN-20260915-476', '812601', 'S3', '', 'SCL AUDITOR', NULL, '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL),
(24, 18, 4, 'TKN-20260915-476', '812601', 'S3', '', 'SCL AUDITOR', NULL, '2026-09-15', '2026-09-15 10:07:08', '2026-09-15 10:07:08', 0, NULL);

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
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_manpower_log`
--

INSERT INTO `mcc_manpower_log` (`id`, `station_id`, `category_id`, `report_date`, `shift_id`, `manpower_type_id`, `provided_qty`, `absent_qty`, `no_dress_qty`, `no_ppe_qty`, `auditor_name`, `created_at`, `isApproved`, `audit_by`) VALUES
(3, 4, 22, '2026-09-12', 46, 17, 29, 0, 0, 0, 'SCL AUDITOR', '2026-09-12 10:57:22', 0, NULL);

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
(7, 1, '2026-06-01', 7, 100.00, 50.00, 50.00, '2026-06-23 12:41:26', '2026-06-23 12:41:26'),
(8, 4, '2026-09-01', 17, 1000.00, 500.00, 500.00, '2026-09-12 11:09:44', '2026-09-12 11:09:44'),
(9, 4, '2026-09-01', 19, 1000.00, 500.00, 500.00, '2026-09-12 11:09:44', '2026-09-12 11:09:44'),
(10, 4, '2026-09-01', 18, 1000.00, 500.00, 500.00, '2026-09-12 11:09:44', '2026-09-12 11:09:44');

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
(46, 22, 'Shift 1', 1, 'Active', '2026-09-12 10:38:57'),
(47, 22, 'Shift 2', 2, 'Active', '2026-09-12 10:38:57'),
(48, 22, 'Shift 3', 3, 'Active', '2026-09-12 10:38:59'),
(49, 23, 'Shift 1', 1, 'Active', '2026-09-12 10:39:00'),
(50, 23, 'Shift 2', 2, 'Active', '2026-09-12 10:39:01'),
(51, 23, 'Shift 3', 3, 'Active', '2026-09-12 10:39:03'),
(52, 24, 'Shift 1', 1, 'Active', '2026-09-12 10:39:04'),
(53, 24, 'Shift 2', 2, 'Active', '2026-09-12 10:39:05'),
(54, 24, 'Shift 3', 3, 'Active', '2026-09-12 10:39:06'),
(55, 25, 'Shift 1', 1, 'Active', '2026-09-12 10:39:09'),
(56, 25, 'Shift 2', 2, 'Active', '2026-09-12 10:39:12'),
(57, 25, 'Shift 3', 3, 'Active', '2026-09-12 10:39:12'),
(58, 26, 'Shift 1', 1, 'Active', '2026-09-12 10:39:14'),
(59, 26, 'Shift 2', 2, 'Active', '2026-09-12 10:39:16'),
(60, 26, 'Shift 3', 3, 'Active', '2026-09-12 10:39:18'),
(61, 27, 'Shift 1', 1, 'Active', '2026-09-12 10:39:20'),
(62, 27, 'Shift 2', 2, 'Active', '2026-09-12 10:39:23'),
(63, 27, 'Shift 3', 3, 'Active', '2026-09-12 10:39:24'),
(64, 28, 'Shift 1', 1, 'Active', '2026-09-12 10:39:25'),
(65, 28, 'Shift 2', 2, 'Active', '2026-09-12 10:39:26'),
(66, 28, 'Shift 3', 3, 'Active', '2026-09-12 10:39:29'),
(67, 29, 'Shift 1', 1, 'Active', '2026-09-12 10:39:33'),
(68, 29, 'Shift 2', 2, 'Active', '2026-09-12 10:39:38'),
(69, 29, 'Shift 3', 3, 'Active', '2026-09-12 10:39:39');

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
(72, 4, 46, 19, '2026-09-12 10:38:57', '2026-09-12 10:38:57'),
(74, 4, 46, 17, '2026-09-12 10:38:57', '2026-09-12 10:38:57'),
(75, 4, 47, 19, '2026-09-12 10:38:58', '2026-09-12 10:38:58'),
(77, 4, 47, 17, '2026-09-12 10:38:58', '2026-09-12 10:38:58'),
(78, 4, 48, 19, '2026-09-12 10:38:59', '2026-09-12 10:38:59'),
(80, 4, 48, 17, '2026-09-12 10:39:00', '2026-09-12 10:39:00'),
(81, 4, 49, 19, '2026-09-12 10:39:01', '2026-09-12 10:39:01'),
(83, 4, 49, 17, '2026-09-12 10:39:01', '2026-09-12 10:39:01'),
(84, 4, 50, 19, '2026-09-12 10:39:02', '2026-09-12 10:39:02'),
(86, 4, 50, 17, '2026-09-12 10:39:03', '2026-09-12 10:39:03'),
(87, 4, 51, 19, '2026-09-12 10:39:03', '2026-09-12 10:39:03'),
(89, 4, 51, 17, '2026-09-12 10:39:04', '2026-09-12 10:39:04'),
(90, 4, 52, 19, '2026-09-12 10:39:05', '2026-09-12 10:39:05'),
(92, 4, 52, 17, '2026-09-12 10:39:05', '2026-09-12 10:39:05'),
(93, 4, 53, 19, '2026-09-12 10:39:05', '2026-09-12 10:39:05'),
(95, 4, 53, 17, '2026-09-12 10:39:06', '2026-09-12 10:39:06'),
(96, 4, 54, 19, '2026-09-12 10:39:06', '2026-09-12 10:39:06'),
(98, 4, 54, 17, '2026-09-12 10:39:07', '2026-09-12 10:39:07'),
(99, 4, 55, 19, '2026-09-12 10:39:09', '2026-09-12 10:39:09'),
(101, 4, 55, 17, '2026-09-12 10:39:11', '2026-09-12 10:39:11'),
(102, 4, 56, 19, '2026-09-12 10:39:12', '2026-09-12 10:39:12'),
(104, 4, 56, 17, '2026-09-12 10:39:12', '2026-09-12 10:39:12'),
(105, 4, 57, 19, '2026-09-12 10:39:13', '2026-09-12 10:39:13'),
(107, 4, 57, 17, '2026-09-12 10:39:13', '2026-09-12 10:39:13'),
(108, 4, 58, 19, '2026-09-12 10:39:14', '2026-09-12 10:39:14'),
(110, 4, 58, 17, '2026-09-12 10:39:15', '2026-09-12 10:39:15'),
(111, 4, 59, 19, '2026-09-12 10:39:17', '2026-09-12 10:39:17'),
(113, 4, 59, 17, '2026-09-12 10:39:18', '2026-09-12 10:39:18'),
(114, 4, 60, 19, '2026-09-12 10:39:19', '2026-09-12 10:39:19'),
(116, 4, 60, 17, '2026-09-12 10:39:20', '2026-09-12 10:39:20'),
(117, 4, 61, 19, '2026-09-12 10:39:21', '2026-09-12 10:39:21'),
(119, 4, 61, 17, '2026-09-12 10:39:22', '2026-09-12 10:39:22'),
(120, 4, 62, 19, '2026-09-12 10:39:23', '2026-09-12 10:39:23'),
(122, 4, 62, 17, '2026-09-12 10:39:23', '2026-09-12 10:39:23'),
(123, 4, 63, 19, '2026-09-12 10:39:24', '2026-09-12 10:39:24'),
(125, 4, 63, 17, '2026-09-12 10:39:24', '2026-09-12 10:39:24'),
(126, 4, 64, 19, '2026-09-12 10:39:25', '2026-09-12 10:39:25'),
(128, 4, 64, 17, '2026-09-12 10:39:26', '2026-09-12 10:39:26'),
(129, 4, 65, 19, '2026-09-12 10:39:26', '2026-09-12 10:39:26'),
(131, 4, 65, 17, '2026-09-12 10:39:28', '2026-09-12 10:39:28'),
(132, 4, 66, 19, '2026-09-12 10:39:30', '2026-09-12 10:39:30'),
(134, 4, 66, 17, '2026-09-12 10:39:31', '2026-09-12 10:39:31'),
(135, 4, 67, 19, '2026-09-12 10:39:34', '2026-09-12 10:39:34'),
(137, 4, 67, 17, '2026-09-12 10:39:37', '2026-09-12 10:39:37'),
(138, 4, 68, 19, '2026-09-12 10:39:38', '2026-09-12 10:39:38'),
(140, 4, 68, 17, '2026-09-12 10:39:39', '2026-09-12 10:39:39'),
(141, 4, 69, 19, '2026-09-12 10:39:40', '2026-09-12 10:39:40'),
(143, 4, 69, 17, '2026-09-12 10:39:40', '2026-09-12 10:39:40'),
(144, 4, 46, 18, '2026-09-15 12:04:26', '2026-09-15 12:04:26'),
(145, 4, 47, 18, '2026-09-15 12:04:40', '2026-09-15 12:04:40'),
(146, 4, 48, 18, '2026-09-15 12:04:54', '2026-09-15 12:04:54');

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
  `is_coach_wise` tinyint(1) NOT NULL DEFAULT 0,
  `effective_from` date DEFAULT NULL,
  `effective_to` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_manpower_targets`
--

INSERT INTO `mcc_manpower_targets` (`id`, `station_id`, `category_id`, `target_date`, `manpower_type_id`, `manpower_type`, `target_qty`, `is_coach_wise`, `effective_from`, `effective_to`, `created_at`, `updated_at`) VALUES
(85, 4, 22, '2026-09-01', 17, 'Unskilled', 0.45, 1, '2026-09-01', '2026-09-30', '2026-09-15 12:50:56', '2026-09-15 12:50:56'),
(86, 4, 22, '2026-09-01', 19, 'SemiSkilled', 6.00, 0, '2026-09-01', '2026-09-30', '2026-09-15 12:50:56', '2026-09-15 12:50:56'),
(87, 4, 22, '2026-09-01', 18, 'Wartering', 3.00, 0, '2026-09-01', '2026-09-30', '2026-09-15 12:50:56', '2026-09-15 12:50:56'),
(88, 4, 23, '2026-09-01', 17, 'Unskilled', 0.20, 1, '2026-09-01', '2026-09-30', '2026-09-15 12:50:57', '2026-09-15 12:50:57'),
(89, 4, 23, '2026-09-01', 19, 'SemiSkilled', 0.00, 0, '2026-09-01', '2026-09-30', '2026-09-15 12:50:57', '2026-09-15 12:50:57'),
(90, 4, 24, '2026-09-01', 17, 'Unskilled', 2.25, 1, '2026-09-01', '2026-09-30', '2026-09-15 12:50:57', '2026-09-15 12:50:57'),
(91, 4, 24, '2026-09-01', 19, 'SemiSkilled', 0.00, 0, '2026-09-01', '2026-09-30', '2026-09-15 12:50:57', '2026-09-15 12:50:57'),
(92, 4, 25, '2026-09-01', 17, 'Unskilled', 3.00, 0, '2026-09-01', '2026-09-30', '2026-09-15 12:50:57', '2026-09-15 12:50:57'),
(93, 4, 25, '2026-09-01', 19, 'SemiSkilled', 0.00, 0, '2026-09-01', '2026-09-30', '2026-09-15 12:50:57', '2026-09-15 12:50:57'),
(94, 4, 26, '2026-09-01', 17, 'Unskilled', 11.00, 0, '2026-09-01', '2026-09-30', '2026-09-15 12:50:57', '2026-09-15 12:50:57'),
(95, 4, 26, '2026-09-01', 19, 'SemiSkilled', 0.00, 0, '2026-09-01', '2026-09-30', '2026-09-15 12:50:57', '2026-09-15 12:50:57'),
(96, 4, 27, '2026-09-01', 17, 'Unskilled', 0.45, 1, '2026-09-01', '2026-09-30', '2026-09-15 12:50:58', '2026-09-15 12:50:58'),
(97, 4, 27, '2026-09-01', 19, 'SemiSkilled', 1.00, 0, '2026-09-01', '2026-09-30', '2026-09-15 12:50:58', '2026-09-15 12:50:58'),
(98, 4, 28, '2026-09-01', 17, 'Unskilled', 6.00, 0, '2026-09-01', '2026-09-30', '2026-09-15 12:50:58', '2026-09-15 12:50:58'),
(99, 4, 28, '2026-09-01', 19, 'SemiSkilled', 0.00, 0, '2026-09-01', '2026-09-30', '2026-09-15 12:50:58', '2026-09-15 12:50:58'),
(100, 4, 29, '2026-09-01', 17, 'Unskilled', 6.00, 0, '2026-09-01', '2026-09-30', '2026-09-15 12:50:58', '2026-09-15 12:50:58'),
(101, 4, 29, '2026-09-01', 19, 'SemiSkilled', 0.00, 0, '2026-09-01', '2026-09-30', '2026-09-15 12:50:58', '2026-09-15 12:50:58');

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
(16, 1, 'Supervisor', 2, 'Active', '2026-09-01 06:09:49'),
(17, 4, 'Unskilled', 1, 'Active', '2026-09-01 06:09:05'),
(18, 4, 'Wartering', 3, 'Active', '2026-09-01 06:09:49'),
(19, 4, 'SemiSkilled', 2, 'Active', '2026-09-12 10:30:52');

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
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_normal_chemical_report`
--

INSERT INTO `mcc_normal_chemical_report` (`id`, `parameter_id`, `coach_no`, `qty_used`, `auditor_name`, `station_id`, `token_id`, `train_no`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(1, 1, 'C1', 30.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:54', 0, NULL),
(2, 2, 'C1', 40.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:54', 0, NULL),
(3, 3, 'C1', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:54', 0, NULL),
(4, 4, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:54', 0, NULL),
(5, 5, 'C1', 18.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:54', 0, NULL),
(6, 6, 'C1', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:54', 0, NULL),
(7, 7, 'C1', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:54', 0, NULL),
(8, 8, 'C1', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:54', 0, NULL),
(9, 1, 'C2', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:05', 0, NULL),
(10, 2, 'C2', 40.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:05', 0, NULL),
(11, 3, 'C2', 25.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:05', 0, NULL),
(12, 4, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:05', 0, NULL),
(13, 5, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:05', 0, NULL),
(14, 6, 'C2', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:05', 0, NULL),
(15, 7, 'C2', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:05', 0, NULL),
(16, 8, 'C2', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:05', 0, NULL),
(17, 1, 'C3', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:08', 0, NULL),
(18, 2, 'C3', 40.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:08', 0, NULL),
(19, 3, 'C3', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:08', 0, NULL),
(20, 4, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:08', 0, NULL),
(21, 5, 'C3', 18.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:08', 0, NULL),
(22, 6, 'C3', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:08', 0, NULL),
(23, 7, 'C3', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:08', 0, NULL),
(24, 8, 'C3', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:08', 0, NULL),
(25, 1, 'C4', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:11', 0, NULL),
(26, 2, 'C4', 40.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:11', 0, NULL),
(27, 3, 'C4', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:11', 0, NULL),
(28, 4, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:11', 0, NULL),
(29, 5, 'C4', 18.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:11', 0, NULL),
(30, 6, 'C4', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:11', 0, NULL),
(31, 7, 'C4', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:11', 0, NULL),
(32, 8, 'C4', 50.00, 'Bheem Chand', 1, 'TKN-20260907-999', '12345', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:09:11', 0, NULL),
(33, 1, '1', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:06', 0, NULL),
(34, 2, '1', 40.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:06', 0, NULL),
(35, 3, '1', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:06', 0, NULL),
(36, 4, '1', 10.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:06', 0, NULL),
(37, 5, '1', 18.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:06', 0, NULL),
(38, 6, '1', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:06', 0, NULL),
(39, 7, '1', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:06', 0, NULL),
(40, 8, '1', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:06', 0, NULL),
(41, 1, '2', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:10', 0, NULL),
(42, 2, '2', 40.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:10', 0, NULL),
(43, 3, '2', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:10', 0, NULL),
(44, 4, '2', 10.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:10', 0, NULL),
(45, 5, '2', 18.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:10', 0, NULL),
(46, 6, '2', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:10', 0, NULL),
(47, 7, '2', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:10', 0, NULL),
(48, 8, '2', 50.00, 'Sayan', 1, 'TKN-20260908-837', '16210', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 07:43:10', 0, NULL),
(49, 1, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:12:43', 0, NULL),
(50, 2, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:12:43', 0, NULL),
(51, 3, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:12:43', 0, NULL),
(52, 4, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:12:43', 0, NULL),
(53, 5, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(54, 6, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(55, 7, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(56, 8, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(57, 1, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(58, 2, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(59, 3, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(60, 4, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(61, 5, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(62, 6, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(63, 7, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(64, 8, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(65, 1, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(66, 2, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(67, 3, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(68, 4, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(69, 5, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(70, 6, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(71, 7, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(72, 8, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-707', '16215', '2026-09-08', '2026-09-08 13:12:44', '2026-09-08 13:12:44', 0, NULL),
(73, 1, '01', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(74, 2, '01', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(75, 3, '01', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(76, 4, '01', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(77, 5, '01', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(78, 6, '01', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(79, 7, '01', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(80, 8, '01', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(81, 1, '02', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(82, 2, '02', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(83, 3, '02', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(84, 4, '02', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(85, 5, '02', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(86, 6, '02', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(87, 7, '02', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(88, 8, '02', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(89, 1, '03', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(90, 2, '03', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(91, 3, '03', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(92, 4, '03', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(93, 5, '03', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(94, 6, '03', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(95, 7, '03', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(96, 8, '03', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(97, 1, '04', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(98, 2, '04', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(99, 3, '04', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(100, 4, '04', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(101, 5, '04', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(102, 6, '04', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(103, 7, '04', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(104, 8, '04', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(105, 1, '05', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(106, 2, '05', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(107, 3, '05', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(108, 4, '05', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(109, 5, '05', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(110, 6, '05', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(111, 7, '05', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(112, 8, '05', NULL, 'Subham Bansal', 1, 'TKN-20260908-892', '56202', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(113, 1, '01', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:48', 0, NULL),
(114, 2, '01', 40.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:48', 0, NULL),
(115, 3, '01', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:48', 0, NULL),
(116, 4, '01', 10.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:48', 0, NULL),
(117, 5, '01', 18.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:48', 0, NULL),
(118, 6, '01', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:48', 0, NULL),
(119, 7, '01', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:48', 0, NULL),
(120, 8, '01', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:48', 0, NULL),
(121, 1, '02', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:51', 0, NULL),
(122, 2, '02', 40.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:51', 0, NULL),
(123, 3, '02', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:51', 0, NULL),
(124, 4, '02', 10.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:51', 0, NULL),
(125, 5, '02', 18.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:51', 0, NULL),
(126, 6, '02', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:51', 0, NULL),
(127, 7, '02', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:51', 0, NULL),
(128, 8, '02', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:51', 0, NULL),
(129, 1, '03', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:55', 0, NULL),
(130, 2, '03', 40.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:55', 0, NULL),
(131, 3, '03', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:55', 0, NULL),
(132, 4, '03', 10.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:55', 0, NULL),
(133, 5, '03', 18.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:55', 0, NULL),
(134, 6, '03', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:55', 0, NULL),
(135, 7, '03', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:55', 0, NULL),
(136, 8, '03', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:55', 0, NULL),
(137, 1, '04', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:59', 0, NULL),
(138, 2, '04', 40.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:59', 0, NULL),
(139, 3, '04', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:59', 0, NULL),
(140, 4, '04', 10.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:59', 0, NULL),
(141, 5, '04', 18.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:59', 0, NULL),
(142, 6, '04', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:59', 0, NULL),
(143, 7, '04', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:59', 0, NULL),
(144, 8, '04', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:19:59', 0, NULL),
(145, 1, '05', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:20:03', 0, NULL),
(146, 2, '05', 40.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:20:03', 0, NULL),
(147, 3, '05', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:20:03', 0, NULL),
(148, 4, '05', 10.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:20:03', 0, NULL),
(149, 5, '05', 18.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:20:03', 0, NULL),
(150, 6, '05', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:20:03', 0, NULL),
(151, 7, '05', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:20:03', 0, NULL),
(152, 8, '05', 50.00, 'Darshan', 1, 'TKN-20260909-797', '16236', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:20:03', 0, NULL),
(153, 1, '01', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:11', 0, NULL),
(154, 2, '01', 40.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:11', 0, NULL),
(155, 3, '01', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:11', 0, NULL),
(156, 4, '01', 10.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:11', 0, NULL),
(157, 5, '01', 18.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:11', 0, NULL),
(158, 6, '01', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:11', 0, NULL),
(159, 7, '01', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:11', 0, NULL),
(160, 8, '01', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:11', 0, NULL),
(161, 1, '02', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:16', 0, NULL),
(162, 2, '02', 40.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:16', 0, NULL),
(163, 3, '02', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:16', 0, NULL),
(164, 4, '02', 10.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:16', 0, NULL),
(165, 5, '02', 18.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:16', 0, NULL),
(166, 6, '02', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:16', 0, NULL),
(167, 7, '02', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:16', 0, NULL),
(168, 8, '02', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:16', 0, NULL),
(169, 1, '03', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:20', 0, NULL),
(170, 2, '03', 40.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:20', 0, NULL),
(171, 3, '03', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:20', 0, NULL),
(172, 4, '03', 10.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:20', 0, NULL),
(173, 5, '03', 18.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:20', 0, NULL),
(174, 6, '03', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:20', 0, NULL),
(175, 7, '03', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:20', 0, NULL),
(176, 8, '03', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:20', 0, NULL),
(177, 1, '04', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:23', 0, NULL),
(178, 2, '04', 40.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:23', 0, NULL),
(179, 3, '04', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:23', 0, NULL),
(180, 4, '04', 10.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:23', 0, NULL),
(181, 5, '04', 18.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:23', 0, NULL),
(182, 6, '04', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:23', 0, NULL),
(183, 7, '04', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:23', 0, NULL),
(184, 8, '04', 50.00, 'Sandesh', 1, 'TKN-20260909-562', '22687', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:20:23', 0, NULL),
(185, 1, '01', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:30', 0, NULL),
(186, 2, '01', 40.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:30', 0, NULL),
(187, 3, '01', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:30', 0, NULL),
(188, 4, '01', 10.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:30', 0, NULL),
(189, 5, '01', 18.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:30', 0, NULL),
(190, 6, '01', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:30', 0, NULL),
(191, 7, '01', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:30', 0, NULL),
(192, 8, '01', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:30', 0, NULL),
(193, 1, '02', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:33', 0, NULL),
(194, 2, '02', 40.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:33', 0, NULL),
(195, 3, '02', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:33', 0, NULL),
(196, 4, '02', 10.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:33', 0, NULL),
(197, 5, '02', 18.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:33', 0, NULL),
(198, 6, '02', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:33', 0, NULL),
(199, 7, '02', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:33', 0, NULL),
(200, 8, '02', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:33', 0, NULL),
(201, 1, '03', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:36', 0, NULL),
(202, 2, '03', 40.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:36', 0, NULL),
(203, 3, '03', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:36', 0, NULL),
(204, 4, '03', 10.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:36', 0, NULL),
(205, 5, '03', 18.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:36', 0, NULL),
(206, 6, '03', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:36', 0, NULL),
(207, 7, '03', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:36', 0, NULL),
(208, 8, '03', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:36', 0, NULL),
(209, 1, '04', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:40', 0, NULL),
(210, 2, '04', 40.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:40', 0, NULL),
(211, 3, '04', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:40', 0, NULL),
(212, 4, '04', 10.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:40', 0, NULL),
(213, 5, '04', 18.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:40', 0, NULL),
(214, 6, '04', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:40', 0, NULL),
(215, 7, '04', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:40', 0, NULL),
(216, 8, '04', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:40', 0, NULL),
(217, 1, '05', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:44', 0, NULL),
(218, 2, '05', 40.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:44', 0, NULL),
(219, 3, '05', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:44', 0, NULL),
(220, 4, '05', 10.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:44', 0, NULL),
(221, 5, '05', 18.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:44', 0, NULL),
(222, 6, '05', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:44', 0, NULL),
(223, 7, '05', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:44', 0, NULL),
(224, 8, '05', 50.00, 'Rafik', 1, 'TKN-20260909-404', '22681', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:20:44', 0, NULL),
(225, 1, '01', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:50', 0, NULL),
(226, 2, '01', 40.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:50', 0, NULL),
(227, 3, '01', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:50', 0, NULL),
(228, 4, '01', 10.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:50', 0, NULL),
(229, 5, '01', 18.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:50', 0, NULL),
(230, 6, '01', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:50', 0, NULL),
(231, 7, '01', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:50', 0, NULL),
(232, 8, '01', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:50', 0, NULL),
(233, 1, '02', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:53', 0, NULL),
(234, 2, '02', 40.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:53', 0, NULL),
(235, 3, '02', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:53', 0, NULL),
(236, 4, '02', 10.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:53', 0, NULL),
(237, 5, '02', 18.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:53', 0, NULL),
(238, 6, '02', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:53', 0, NULL),
(239, 7, '02', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:53', 0, NULL),
(240, 8, '02', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:53', 0, NULL),
(241, 1, '03', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:57', 0, NULL),
(242, 2, '03', 40.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:57', 0, NULL),
(243, 3, '03', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:57', 0, NULL),
(244, 4, '03', 10.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:57', 0, NULL),
(245, 5, '03', 18.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:57', 0, NULL),
(246, 6, '03', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:57', 0, NULL),
(247, 7, '03', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:57', 0, NULL),
(248, 8, '03', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:20:57', 0, NULL),
(249, 1, '04', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:21:00', 0, NULL),
(250, 2, '04', 40.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:21:00', 0, NULL),
(251, 3, '04', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:21:00', 0, NULL),
(252, 4, '04', 10.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:21:00', 0, NULL),
(253, 5, '04', 18.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:21:00', 0, NULL),
(254, 6, '04', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:21:00', 0, NULL),
(255, 7, '04', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:21:00', 0, NULL),
(256, 8, '04', 50.00, 'Shivkumar', 1, 'TKN-20260909-287', '16227', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:21:00', 0, NULL),
(257, 10, 'C1', 50.00, 'SCL AUDITOR', 4, 'TKN-20260912-852', '12345', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:41', 0, NULL),
(258, 11, 'C1', 40.00, 'SCL AUDITOR', 4, 'TKN-20260912-852', '12345', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:41', 0, NULL),
(259, 12, 'C1', 50.00, 'SCL AUDITOR', 4, 'TKN-20260912-852', '12345', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:41', 0, NULL),
(260, 13, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-20260912-852', '12345', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:41', 0, NULL),
(261, 14, 'C1', 18.00, 'SCL AUDITOR', 4, 'TKN-20260912-852', '12345', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:41', 0, NULL),
(262, 15, 'C1', 50.00, 'SCL AUDITOR', 4, 'TKN-20260912-852', '12345', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:41', 0, NULL),
(263, 16, 'C1', 50.00, 'SCL AUDITOR', 4, 'TKN-20260912-852', '12345', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:41', 0, NULL),
(264, 17, 'C1', 50.00, 'SCL AUDITOR', 4, 'TKN-20260912-852', '12345', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:41', 0, NULL),
(265, 1, 'C1', NULL, 'Bheem Chand', 1, 'TKN-20260912-033', '12345', '2026-09-12', '2026-09-12 11:23:57', '2026-09-12 11:23:57', 0, NULL),
(266, 2, 'C1', NULL, 'Bheem Chand', 1, 'TKN-20260912-033', '12345', '2026-09-12', '2026-09-12 11:23:57', '2026-09-12 11:23:57', 0, NULL),
(267, 3, 'C1', NULL, 'Bheem Chand', 1, 'TKN-20260912-033', '12345', '2026-09-12', '2026-09-12 11:23:57', '2026-09-12 11:23:57', 0, NULL),
(268, 4, 'C1', NULL, 'Bheem Chand', 1, 'TKN-20260912-033', '12345', '2026-09-12', '2026-09-12 11:23:57', '2026-09-12 11:23:57', 0, NULL),
(269, 5, 'C1', NULL, 'Bheem Chand', 1, 'TKN-20260912-033', '12345', '2026-09-12', '2026-09-12 11:23:57', '2026-09-12 11:23:57', 0, NULL),
(270, 6, 'C1', NULL, 'Bheem Chand', 1, 'TKN-20260912-033', '12345', '2026-09-12', '2026-09-12 11:23:57', '2026-09-12 11:23:57', 0, NULL),
(271, 7, 'C1', NULL, 'Bheem Chand', 1, 'TKN-20260912-033', '12345', '2026-09-12', '2026-09-12 11:23:57', '2026-09-12 11:23:57', 0, NULL),
(272, 8, 'C1', NULL, 'Bheem Chand', 1, 'TKN-20260912-033', '12345', '2026-09-12', '2026-09-12 11:23:57', '2026-09-12 11:23:57', 0, NULL),
(273, 1, 'C2', NULL, 'Bheem Chand', 1, 'TKN-20260912-033', '12345', '2026-09-12', '2026-09-12 11:23:57', '2026-09-12 11:23:57', 0, NULL),
(274, 2, 'C2', NULL, 'Bheem Chand', 1, 'TKN-20260912-033', '12345', '2026-09-12', '2026-09-12 11:23:57', '2026-09-12 11:23:57', 0, NULL),
(275, 3, 'C2', NULL, 'Bheem Chand', 1, 'TKN-20260912-033', '12345', '2026-09-12', '2026-09-12 11:23:57', '2026-09-12 11:23:57', 0, NULL),
(276, 4, 'C2', NULL, 'Bheem Chand', 1, 'TKN-20260912-033', '12345', '2026-09-12', '2026-09-12 11:23:57', '2026-09-12 11:23:57', 0, NULL),
(277, 5, 'C2', NULL, 'Bheem Chand', 1, 'TKN-20260912-033', '12345', '2026-09-12', '2026-09-12 11:23:57', '2026-09-12 11:23:57', 0, NULL),
(278, 6, 'C2', NULL, 'Bheem Chand', 1, 'TKN-20260912-033', '12345', '2026-09-12', '2026-09-12 11:23:57', '2026-09-12 11:23:57', 0, NULL),
(279, 7, 'C2', NULL, 'Bheem Chand', 1, 'TKN-20260912-033', '12345', '2026-09-12', '2026-09-12 11:23:57', '2026-09-12 11:23:57', 0, NULL),
(280, 8, 'C2', NULL, 'Bheem Chand', 1, 'TKN-20260912-033', '12345', '2026-09-12', '2026-09-12 11:23:57', '2026-09-12 11:23:57', 0, NULL),
(281, 10, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(282, 11, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(283, 12, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(284, 13, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(285, 14, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(286, 15, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(287, 16, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(288, 17, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(289, 10, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(290, 11, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(291, 12, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(292, 13, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(293, 14, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(294, 15, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(295, 16, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(296, 17, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(297, 10, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(298, 11, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(299, 12, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(300, 13, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(301, 14, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(302, 15, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(303, 16, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(304, 17, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260915-026', '812601', '2026-09-15', '2026-09-15 10:01:18', '2026-09-15 10:01:18', 0, NULL),
(305, 1, '12', NULL, 'Ajit Kumar', 1, 'TKN-20260917-899', '123', '2026-09-17', '2026-09-17 08:27:42', '2026-09-17 08:27:42', 0, NULL),
(306, 2, '12', NULL, 'Ajit Kumar', 1, 'TKN-20260917-899', '123', '2026-09-17', '2026-09-17 08:27:42', '2026-09-17 08:27:42', 0, NULL),
(307, 3, '12', NULL, 'Ajit Kumar', 1, 'TKN-20260917-899', '123', '2026-09-17', '2026-09-17 08:27:42', '2026-09-17 08:27:42', 0, NULL),
(308, 4, '12', NULL, 'Ajit Kumar', 1, 'TKN-20260917-899', '123', '2026-09-17', '2026-09-17 08:27:42', '2026-09-17 08:27:42', 0, NULL),
(309, 5, '12', NULL, 'Ajit Kumar', 1, 'TKN-20260917-899', '123', '2026-09-17', '2026-09-17 08:27:42', '2026-09-17 08:27:42', 0, NULL),
(310, 6, '12', NULL, 'Ajit Kumar', 1, 'TKN-20260917-899', '123', '2026-09-17', '2026-09-17 08:27:42', '2026-09-17 08:27:42', 0, NULL),
(311, 7, '12', NULL, 'Ajit Kumar', 1, 'TKN-20260917-899', '123', '2026-09-17', '2026-09-17 08:27:42', '2026-09-17 08:27:42', 0, NULL),
(312, 8, '12', NULL, 'Ajit Kumar', 1, 'TKN-20260917-899', '123', '2026-09-17', '2026-09-17 08:27:42', '2026-09-17 08:27:42', 0, NULL),
(313, 1, '123', NULL, 'Ajit Kumar', 1, 'TKN-20260917-027', '16236', '2026-09-17', '2026-09-17 10:06:01', '2026-09-17 10:06:01', 0, NULL),
(314, 2, '123', NULL, 'Ajit Kumar', 1, 'TKN-20260917-027', '16236', '2026-09-17', '2026-09-17 10:06:01', '2026-09-17 10:06:01', 0, NULL),
(315, 3, '123', NULL, 'Ajit Kumar', 1, 'TKN-20260917-027', '16236', '2026-09-17', '2026-09-17 10:06:01', '2026-09-17 10:06:01', 0, NULL),
(316, 4, '123', NULL, 'Ajit Kumar', 1, 'TKN-20260917-027', '16236', '2026-09-17', '2026-09-17 10:06:01', '2026-09-17 10:06:01', 0, NULL),
(317, 5, '123', NULL, 'Ajit Kumar', 1, 'TKN-20260917-027', '16236', '2026-09-17', '2026-09-17 10:06:01', '2026-09-17 10:06:01', 0, NULL),
(318, 6, '123', NULL, 'Ajit Kumar', 1, 'TKN-20260917-027', '16236', '2026-09-17', '2026-09-17 10:06:01', '2026-09-17 10:06:01', 0, NULL),
(319, 7, '123', NULL, 'Ajit Kumar', 1, 'TKN-20260917-027', '16236', '2026-09-17', '2026-09-17 10:06:01', '2026-09-17 10:06:01', 0, NULL),
(320, 8, '123', NULL, 'Ajit Kumar', 1, 'TKN-20260917-027', '16236', '2026-09-17', '2026-09-17 10:06:01', '2026-09-17 10:06:01', 0, NULL),
(321, 10, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(322, 11, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(323, 12, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(324, 13, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(325, 14, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(326, 15, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(327, 16, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(328, 17, 'S1', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(329, 10, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(330, 11, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(331, 12, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(332, 13, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(333, 14, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(334, 15, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(335, 16, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(336, 17, 'S2', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(337, 10, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(338, 11, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(339, 12, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(340, 13, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(341, 14, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(342, 15, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(343, 16, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(344, 17, 'S3', NULL, 'SCL AUDITOR', 4, 'TKN-20260918-199', '812601', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 08:53:48', 0, 14),
(345, 1, 'S1', NULL, 'Ajit Kumar', 1, 'TKN-20260921-484', '16236', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 13:23:58', 0, 16),
(346, 2, 'S1', NULL, 'Ajit Kumar', 1, 'TKN-20260921-484', '16236', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 13:23:58', 0, 16),
(347, 3, 'S1', NULL, 'Ajit Kumar', 1, 'TKN-20260921-484', '16236', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 13:23:58', 0, 16),
(348, 4, 'S1', NULL, 'Ajit Kumar', 1, 'TKN-20260921-484', '16236', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 13:23:58', 0, 16),
(349, 5, 'S1', NULL, 'Ajit Kumar', 1, 'TKN-20260921-484', '16236', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 13:23:58', 0, 16),
(350, 6, 'S1', NULL, 'Ajit Kumar', 1, 'TKN-20260921-484', '16236', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 13:23:58', 0, 16),
(351, 7, 'S1', NULL, 'Ajit Kumar', 1, 'TKN-20260921-484', '16236', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 13:23:58', 0, 16),
(352, 8, 'S1', NULL, 'Ajit Kumar', 1, 'TKN-20260921-484', '16236', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 13:23:58', 0, 16),
(353, 1, 'S2', NULL, 'Ajit Kumar', 1, 'TKN-20260921-484', '16236', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 13:23:58', 0, 16),
(354, 2, 'S2', NULL, 'Ajit Kumar', 1, 'TKN-20260921-484', '16236', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 13:23:58', 0, 16),
(355, 3, 'S2', NULL, 'Ajit Kumar', 1, 'TKN-20260921-484', '16236', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 13:23:58', 0, 16),
(356, 4, 'S2', NULL, 'Ajit Kumar', 1, 'TKN-20260921-484', '16236', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 13:23:58', 0, 16),
(357, 5, 'S2', NULL, 'Ajit Kumar', 1, 'TKN-20260921-484', '16236', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 13:23:58', 0, 16),
(358, 6, 'S2', NULL, 'Ajit Kumar', 1, 'TKN-20260921-484', '16236', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 13:23:58', 0, 16),
(359, 7, 'S2', NULL, 'Ajit Kumar', 1, 'TKN-20260921-484', '16236', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 13:23:58', 0, 16),
(360, 8, 'S2', NULL, 'Ajit Kumar', 1, 'TKN-20260921-484', '16236', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 13:23:58', 0, 16),
(361, 1, 'A1', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:20', 0, 16),
(362, 2, 'A1', 40.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:20', 0, 16),
(363, 3, 'A1', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:20', 0, 16),
(364, 4, 'A1', 10.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:20', 0, 16),
(365, 5, 'A1', 18.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:20', 0, 16),
(366, 6, 'A1', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:20', 0, 16),
(367, 7, 'A1', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:20', 0, 16),
(368, 8, 'A1', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:20', 0, 16),
(369, 1, 'A2', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:24', 0, 16),
(370, 2, 'A2', 40.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:24', 0, 16);
INSERT INTO `mcc_normal_chemical_report` (`id`, `parameter_id`, `coach_no`, `qty_used`, `auditor_name`, `station_id`, `token_id`, `train_no`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(371, 3, 'A2', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:24', 0, 16),
(372, 4, 'A2', 10.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:24', 0, 16),
(373, 5, 'A2', 18.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:24', 0, 16),
(374, 6, 'A2', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:24', 0, 16),
(375, 7, 'A2', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:24', 0, 16),
(376, 8, 'A2', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:24', 0, 16),
(377, 1, 'B1', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:28', 0, 16),
(378, 2, 'B1', 40.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:28', 0, 16),
(379, 3, 'B1', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:28', 0, 16),
(380, 4, 'B1', 10.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:28', 0, 16),
(381, 5, 'B1', 18.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:28', 0, 16),
(382, 6, 'B1', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:28', 0, 16),
(383, 7, 'B1', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:28', 0, 16),
(384, 8, 'B1', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:28', 0, 16),
(385, 1, '123456', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:17', 0, 16),
(386, 2, '123456', 40.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:17', 0, 16),
(387, 3, '123456', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:17', 0, 16),
(388, 4, '123456', 10.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:17', 0, 16),
(389, 5, '123456', 18.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:17', 0, 16),
(390, 6, '123456', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:17', 0, 16),
(391, 7, '123456', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:17', 0, 16),
(392, 8, '123456', 50.00, 'Ajit Kumar', 1, 'TKN-20260921-841', '16210', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:51:17', 0, 16),
(393, 1, 'A1', 50.00, 'RAJ BIRUA', 1, 'TKN-20260921-728', '22687', '2026-09-21', '2026-09-21 14:05:32', '2026-09-21 14:06:00', 0, 21),
(394, 2, 'A1', 40.00, 'RAJ BIRUA', 1, 'TKN-20260921-728', '22687', '2026-09-21', '2026-09-21 14:05:32', '2026-09-21 14:06:00', 0, 21),
(395, 3, 'A1', 50.00, 'RAJ BIRUA', 1, 'TKN-20260921-728', '22687', '2026-09-21', '2026-09-21 14:05:32', '2026-09-21 14:06:00', 0, 21),
(396, 4, 'A1', 10.00, 'RAJ BIRUA', 1, 'TKN-20260921-728', '22687', '2026-09-21', '2026-09-21 14:05:32', '2026-09-21 14:06:00', 0, 21),
(397, 5, 'A1', 18.00, 'RAJ BIRUA', 1, 'TKN-20260921-728', '22687', '2026-09-21', '2026-09-21 14:05:32', '2026-09-21 14:06:00', 0, 21),
(398, 6, 'A1', 50.00, 'RAJ BIRUA', 1, 'TKN-20260921-728', '22687', '2026-09-21', '2026-09-21 14:05:32', '2026-09-21 14:06:00', 0, 21),
(399, 7, 'A1', 50.00, 'RAJ BIRUA', 1, 'TKN-20260921-728', '22687', '2026-09-21', '2026-09-21 14:05:32', '2026-09-21 14:06:00', 0, 21),
(400, 8, 'A1', 50.00, 'RAJ BIRUA', 1, 'TKN-20260921-728', '22687', '2026-09-21', '2026-09-21 14:05:32', '2026-09-21 14:06:00', 0, 21),
(401, 1, '227126', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(402, 2, '227126', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(403, 3, '227126', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(404, 4, '227126', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(405, 5, '227126', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(406, 6, '227126', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(407, 7, '227126', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(408, 8, '227126', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(409, 1, '182209', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(410, 2, '182209', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(411, 3, '182209', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(412, 4, '182209', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(413, 5, '182209', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(414, 6, '182209', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(415, 7, '182209', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(416, 8, '182209', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(417, 1, '226871', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(418, 2, '226871', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(419, 3, '226871', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(420, 4, '226871', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(421, 5, '226871', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(422, 6, '226871', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(423, 7, '226871', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(424, 8, '226871', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(425, 1, '225859', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(426, 2, '225859', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(427, 3, '225859', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(428, 4, '225859', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(429, 5, '225859', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(430, 6, '225859', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(431, 7, '225859', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(432, 8, '225859', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(433, 1, '225283', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(434, 2, '225283', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(435, 3, '225283', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(436, 4, '225283', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(437, 5, '225283', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(438, 6, '225283', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(439, 7, '225283', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(440, 8, '225283', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(441, 1, '226472', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(442, 2, '226472', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(443, 3, '226472', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(444, 4, '226472', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(445, 5, '226472', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(446, 6, '226472', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(447, 7, '226472', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(448, 8, '226472', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(449, 1, '191730', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(450, 2, '191730', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(451, 3, '191730', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(452, 4, '191730', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(453, 5, '191730', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(454, 6, '191730', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(455, 7, '191730', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(456, 8, '191730', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(457, 1, '193659', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(458, 2, '193659', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(459, 3, '193659', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(460, 4, '193659', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(461, 5, '193659', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(462, 6, '193659', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(463, 7, '193659', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(464, 8, '193659', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(465, 1, '197712', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(466, 2, '197712', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(467, 3, '197712', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(468, 4, '197712', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(469, 5, '197712', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(470, 6, '197712', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(471, 7, '197712', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(472, 8, '197712', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(473, 1, '197855', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(474, 2, '197855', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(475, 3, '197855', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(476, 4, '197855', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(477, 5, '197855', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(478, 6, '197855', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(479, 7, '197855', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(480, 8, '197855', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(481, 1, '212183', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(482, 2, '212183', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(483, 3, '212183', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(484, 4, '212183', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(485, 5, '212183', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(486, 6, '212183', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(487, 7, '212183', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(488, 8, '212183', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(489, 1, '243440', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(490, 2, '243440', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(491, 3, '243440', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(492, 4, '243440', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(493, 5, '243440', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(494, 6, '243440', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(495, 7, '243440', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(496, 8, '243440', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(497, 1, '182083', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(498, 2, '182083', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(499, 3, '182083', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(500, 4, '182083', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(501, 5, '182083', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(502, 6, '182083', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(503, 7, '182083', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(504, 8, '182083', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(505, 1, '182078', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(506, 2, '182078', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(507, 3, '182078', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(508, 4, '182078', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(509, 5, '182078', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(510, 6, '182078', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(511, 7, '182078', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(512, 8, '182078', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(513, 1, '223450', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(514, 2, '223450', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(515, 3, '223450', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(516, 4, '223450', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(517, 5, '223450', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(518, 6, '223450', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(519, 7, '223450', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(520, 8, '223450', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(521, 1, '201593', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(522, 2, '201593', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(523, 3, '201593', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(524, 4, '201593', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(525, 5, '201593', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(526, 6, '201593', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(527, 7, '201593', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(528, 8, '201593', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(529, 1, '191483', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(530, 2, '191483', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(531, 3, '191483', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(532, 4, '191483', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(533, 5, '191483', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(534, 6, '191483', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(535, 7, '191483', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(536, 8, '191483', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(537, 1, '195176', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(538, 2, '195176', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(539, 3, '195176', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(540, 4, '195176', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(541, 5, '195176', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(542, 6, '195176', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(543, 7, '195176', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(544, 8, '195176', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(545, 1, '191599', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(546, 2, '191599', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(547, 3, '191599', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(548, 4, '191599', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(549, 5, '191599', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(550, 6, '191599', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(551, 7, '191599', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(552, 8, '191599', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(553, 1, '263996', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(554, 2, '263996', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(555, 3, '263996', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(556, 4, '263996', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(557, 5, '263996', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(558, 6, '263996', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(559, 7, '263996', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(560, 8, '263996', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(561, 1, '191077', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(562, 2, '191077', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(563, 3, '191077', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(564, 4, '191077', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(565, 5, '191077', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(566, 6, '191077', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(567, 7, '191077', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(568, 8, '191077', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-621', '16210', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(569, 1, '225388', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(570, 2, '225388', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(571, 3, '225388', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(572, 4, '225388', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(573, 5, '225388', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(574, 6, '225388', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(575, 7, '225388', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(576, 8, '225388', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(577, 1, '225861', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(578, 2, '225861', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(579, 3, '225861', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(580, 4, '225861', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(581, 5, '225861', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(582, 6, '225861', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(583, 7, '225861', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(584, 8, '225861', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(585, 1, '245887', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(586, 2, '245887', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(587, 3, '245887', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(588, 4, '245887', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(589, 5, '245887', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(590, 6, '245887', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(591, 7, '245887', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(592, 8, '245887', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(593, 1, '251521', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(594, 2, '251521', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(595, 3, '251521', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(596, 4, '251521', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(597, 5, '251521', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(598, 6, '251521', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(599, 7, '251521', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(600, 8, '251521', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(601, 1, '201671', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(602, 2, '201671', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(603, 3, '201671', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(604, 4, '201671', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(605, 5, '201671', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(606, 6, '201671', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(607, 7, '201671', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(608, 8, '201671', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(609, 1, '212954', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(610, 2, '212954', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(611, 3, '212954', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(612, 4, '212954', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(613, 5, '212954', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(614, 6, '212954', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(615, 7, '212954', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(616, 8, '212954', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(617, 1, '182601', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(618, 2, '182601', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(619, 3, '182601', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(620, 4, '182601', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(621, 5, '182601', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(622, 6, '182601', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(623, 7, '182601', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(624, 8, '182601', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(625, 1, '251574', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(626, 2, '251574', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(627, 3, '251574', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(628, 4, '251574', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(629, 5, '251574', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(630, 6, '251574', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(631, 7, '251574', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(632, 8, '251574', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(633, 1, '216697', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(634, 2, '216697', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(635, 3, '216697', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(636, 4, '216697', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(637, 5, '216697', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(638, 6, '216697', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(639, 7, '216697', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(640, 8, '216697', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(641, 1, '191746', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(642, 2, '191746', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(643, 3, '191746', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(644, 4, '191746', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(645, 5, '191746', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(646, 6, '191746', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(647, 7, '191746', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(648, 8, '191746', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(649, 1, '255982', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(650, 2, '255982', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(651, 3, '255982', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(652, 4, '255982', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(653, 5, '255982', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(654, 6, '255982', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(655, 7, '255982', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(656, 8, '255982', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(657, 1, '195191', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(658, 2, '195191', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(659, 3, '195191', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(660, 4, '195191', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(661, 5, '195191', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(662, 6, '195191', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(663, 7, '195191', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(664, 8, '195191', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(665, 1, '191757', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(666, 2, '191757', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(667, 3, '191757', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(668, 4, '191757', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(669, 5, '191757', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(670, 6, '191757', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(671, 7, '191757', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(672, 8, '191757', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(673, 1, '201587', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(674, 2, '201587', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(675, 3, '201587', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(676, 4, '201587', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(677, 5, '201587', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(678, 6, '201587', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(679, 7, '201587', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(680, 8, '201587', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(681, 1, '197705', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(682, 2, '197705', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(683, 3, '197705', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(684, 4, '197705', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(685, 5, '197705', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(686, 6, '197705', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(687, 7, '197705', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(688, 8, '197705', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(689, 1, '193028', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(690, 2, '193028', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(691, 3, '193028', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(692, 4, '193028', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(693, 5, '193028', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(694, 6, '193028', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(695, 7, '193028', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(696, 8, '193028', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(697, 1, '193241', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(698, 2, '193241', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(699, 3, '193241', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(700, 4, '193241', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(701, 5, '193241', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(702, 6, '193241', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(703, 7, '193241', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(704, 8, '193241', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(705, 1, '191216', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(706, 2, '191216', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(707, 3, '191216', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(708, 4, '191216', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(709, 5, '191216', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(710, 6, '191216', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(711, 7, '191216', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(712, 8, '191216', NULL, 'RAJ BIRUA', 1, 'TKN-20260922-876', '16236', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21);

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
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_normal_machine_report`
--

INSERT INTO `mcc_normal_machine_report` (`id`, `parameter_id`, `shift_id`, `used_status`, `token_id`, `auditor_name`, `station_id`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(1, 16, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23', 0, NULL),
(2, 17, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23', 0, NULL),
(3, 18, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23', 0, NULL),
(4, 19, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23', 0, NULL),
(5, 20, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23', 0, NULL),
(6, 21, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23', 0, NULL),
(7, 22, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23', 0, NULL),
(8, 23, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23', 0, NULL),
(9, 24, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23', 0, NULL),
(10, 25, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23', 0, NULL),
(11, 26, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23', 0, NULL),
(12, 27, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23', 0, NULL),
(13, 28, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23', 0, NULL),
(14, 29, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23', 0, NULL),
(15, 30, 4, 'Y', 'TKN-MCH-20260907-4-1162', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:23', '2026-09-07 14:09:23', 0, NULL),
(16, 16, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36', 0, NULL),
(17, 17, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36', 0, NULL),
(18, 18, 5, 'N', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36', 0, NULL),
(19, 19, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36', 0, NULL),
(20, 20, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36', 0, NULL),
(21, 21, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36', 0, NULL),
(22, 22, 5, 'N', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36', 0, NULL),
(23, 23, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36', 0, NULL),
(24, 24, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36', 0, NULL),
(25, 25, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36', 0, NULL),
(26, 26, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36', 0, NULL),
(27, 27, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36', 0, NULL),
(28, 28, 5, 'N', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36', 0, NULL),
(29, 29, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36', 0, NULL),
(30, 30, 5, 'Y', 'TKN-MCH-20260907-5-3619', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:36', '2026-09-07 14:09:36', 0, NULL),
(31, 16, 6, 'N', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45', 0, NULL),
(32, 17, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45', 0, NULL),
(33, 18, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45', 0, NULL),
(34, 19, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45', 0, NULL),
(35, 20, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45', 0, NULL),
(36, 21, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45', 0, NULL),
(37, 22, 6, 'N', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45', 0, NULL),
(38, 23, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45', 0, NULL),
(39, 24, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45', 0, NULL),
(40, 25, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45', 0, NULL),
(41, 26, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45', 0, NULL),
(42, 27, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45', 0, NULL),
(43, 28, 6, 'N', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45', 0, NULL),
(44, 29, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45', 0, NULL),
(45, 30, 6, 'Y', 'TKN-MCH-20260907-6-1638', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:09:45', '2026-09-07 14:09:45', 0, NULL),
(46, 16, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38', 0, NULL),
(47, 17, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38', 0, NULL),
(48, 18, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38', 0, NULL),
(49, 19, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38', 0, NULL),
(50, 20, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38', 0, NULL),
(51, 21, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38', 0, NULL),
(52, 22, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38', 0, NULL),
(53, 23, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38', 0, NULL),
(54, 24, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38', 0, NULL),
(55, 25, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38', 0, NULL),
(56, 26, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38', 0, NULL),
(57, 27, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38', 0, NULL),
(58, 28, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38', 0, NULL),
(59, 29, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38', 0, NULL),
(60, 30, 4, 'Y', 'TKN-MCH-20260908-4-2773', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:39:38', '2026-09-08 07:39:38', 0, NULL),
(61, 16, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25', 0, NULL),
(62, 17, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25', 0, NULL),
(63, 18, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25', 0, NULL),
(64, 19, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25', 0, NULL),
(65, 20, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25', 0, NULL),
(66, 21, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25', 0, NULL),
(67, 22, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25', 0, NULL),
(68, 23, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25', 0, NULL),
(69, 24, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25', 0, NULL),
(70, 25, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25', 0, NULL),
(71, 26, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25', 0, NULL),
(72, 27, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25', 0, NULL),
(73, 28, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25', 0, NULL),
(74, 29, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25', 0, NULL),
(75, 30, 5, 'Y', 'TKN-MCH-20260908-5-9618', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:25', '2026-09-08 07:42:25', 0, NULL),
(76, 16, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31', 0, NULL),
(77, 17, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31', 0, NULL),
(78, 18, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31', 0, NULL),
(79, 19, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31', 0, NULL),
(80, 20, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31', 0, NULL),
(81, 21, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31', 0, NULL),
(82, 22, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31', 0, NULL),
(83, 23, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31', 0, NULL),
(84, 24, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31', 0, NULL),
(85, 25, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31', 0, NULL),
(86, 26, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31', 0, NULL),
(87, 27, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31', 0, NULL),
(88, 28, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31', 0, NULL),
(89, 29, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31', 0, NULL),
(90, 30, 6, 'Y', 'TKN-MCH-20260908-6-3550', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 07:42:31', '2026-09-08 07:42:31', 0, NULL),
(91, 16, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19', 0, NULL),
(92, 17, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19', 0, NULL),
(93, 18, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19', 0, NULL),
(94, 19, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19', 0, NULL),
(95, 20, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19', 0, NULL),
(96, 21, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19', 0, NULL),
(97, 22, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19', 0, NULL),
(98, 23, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19', 0, NULL),
(99, 24, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19', 0, NULL),
(100, 25, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19', 0, NULL),
(101, 26, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19', 0, NULL),
(102, 27, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19', 0, NULL),
(103, 28, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19', 0, NULL),
(104, 29, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19', 0, NULL),
(105, 30, 4, 'Y', 'TKN-MCH-20260909-4-4745', 'Darshan', 1, '2026-09-09', '2026-09-09 07:21:19', '2026-09-09 07:21:19', 0, NULL),
(106, 16, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28', 0, NULL),
(107, 17, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28', 0, NULL),
(108, 18, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28', 0, NULL),
(109, 19, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28', 0, NULL),
(110, 20, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28', 0, NULL),
(111, 21, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28', 0, NULL),
(112, 22, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28', 0, NULL),
(113, 23, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28', 0, NULL),
(114, 24, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28', 0, NULL),
(115, 25, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28', 0, NULL),
(116, 26, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28', 0, NULL),
(117, 27, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28', 0, NULL),
(118, 28, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28', 0, NULL),
(119, 29, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28', 0, NULL),
(120, 30, 5, 'Y', 'TKN-MCH-20260909-5-8687', 'Rafik', 1, '2026-09-09', '2026-09-09 07:21:28', '2026-09-09 07:21:28', 0, NULL),
(121, 16, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37', 0, NULL),
(122, 17, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37', 0, NULL),
(123, 18, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37', 0, NULL),
(124, 19, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37', 0, NULL),
(125, 20, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37', 0, NULL),
(126, 21, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37', 0, NULL),
(127, 22, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37', 0, NULL),
(128, 23, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37', 0, NULL),
(129, 24, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37', 0, NULL),
(130, 25, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37', 0, NULL),
(131, 26, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37', 0, NULL),
(132, 27, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37', 0, NULL),
(133, 28, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37', 0, NULL),
(134, 29, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37', 0, NULL),
(135, 30, 6, 'Y', 'TKN-MCH-20260909-6-9875', 'Shivkumar', 1, '2026-09-09', '2026-09-09 07:21:37', '2026-09-09 07:21:37', 0, NULL),
(136, 31, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22', 0, NULL),
(137, 32, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22', 0, NULL),
(138, 33, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22', 0, NULL),
(139, 34, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22', 0, NULL),
(140, 35, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22', 0, NULL),
(141, 36, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22', 0, NULL),
(142, 37, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22', 0, NULL),
(143, 38, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22', 0, NULL),
(144, 39, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22', 0, NULL),
(145, 40, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22', 0, NULL),
(146, 41, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22', 0, NULL),
(147, 42, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22', 0, NULL),
(148, 43, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22', 0, NULL),
(149, 44, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22', 0, NULL),
(150, 45, 7, 'Y', 'TKN-MCH-20260912-7-5903', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:22', '2026-09-12 08:01:22', 0, NULL),
(151, 31, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27', 0, NULL),
(152, 32, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27', 0, NULL),
(153, 33, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27', 0, NULL),
(154, 34, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27', 0, NULL),
(155, 35, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27', 0, NULL),
(156, 36, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27', 0, NULL),
(157, 37, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27', 0, NULL),
(158, 38, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27', 0, NULL),
(159, 39, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27', 0, NULL),
(160, 40, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27', 0, NULL),
(161, 41, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27', 0, NULL),
(162, 42, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27', 0, NULL),
(163, 43, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27', 0, NULL),
(164, 44, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27', 0, NULL),
(165, 45, 8, 'Y', 'TKN-MCH-20260912-8-3954', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:27', '2026-09-12 08:01:27', 0, NULL),
(166, 31, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33', 0, NULL),
(167, 32, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33', 0, NULL),
(168, 33, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33', 0, NULL),
(169, 34, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33', 0, NULL),
(170, 35, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33', 0, NULL),
(171, 36, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33', 0, NULL),
(172, 37, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33', 0, NULL),
(173, 38, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33', 0, NULL),
(174, 39, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33', 0, NULL),
(175, 40, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33', 0, NULL),
(176, 41, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33', 0, NULL),
(177, 42, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33', 0, NULL),
(178, 43, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33', 0, NULL),
(179, 44, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33', 0, NULL),
(180, 45, 9, 'Y', 'TKN-MCH-20260912-9-9004', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:01:33', '2026-09-12 08:01:33', 0, NULL),
(181, 16, 4, 'Y', 'TKN-MCH-20260915-4-7634', 'bheem123', 1, '2026-09-15', '2026-09-15 17:02:39', '2026-09-15 17:02:39', 0, NULL),
(182, 17, 4, 'Y', 'TKN-MCH-20260915-4-7634', 'bheem123', 1, '2026-09-15', '2026-09-15 17:02:39', '2026-09-15 17:02:39', 0, NULL),
(183, 18, 4, 'Y', 'TKN-MCH-20260915-4-7634', 'bheem123', 1, '2026-09-15', '2026-09-15 17:02:39', '2026-09-15 17:02:39', 0, NULL),
(184, 19, 4, 'Y', 'TKN-MCH-20260915-4-7634', 'bheem123', 1, '2026-09-15', '2026-09-15 17:02:39', '2026-09-15 17:02:39', 0, NULL),
(185, 20, 4, 'Y', 'TKN-MCH-20260915-4-7634', 'bheem123', 1, '2026-09-15', '2026-09-15 17:02:39', '2026-09-15 17:02:39', 0, NULL),
(186, 21, 4, 'Y', 'TKN-MCH-20260915-4-7634', 'bheem123', 1, '2026-09-15', '2026-09-15 17:02:39', '2026-09-15 17:02:39', 0, NULL),
(187, 22, 4, 'Y', 'TKN-MCH-20260915-4-7634', 'bheem123', 1, '2026-09-15', '2026-09-15 17:02:39', '2026-09-15 17:02:39', 0, NULL),
(188, 23, 4, 'Y', 'TKN-MCH-20260915-4-7634', 'bheem123', 1, '2026-09-15', '2026-09-15 17:02:39', '2026-09-15 17:02:39', 0, NULL),
(189, 24, 4, 'Y', 'TKN-MCH-20260915-4-7634', 'bheem123', 1, '2026-09-15', '2026-09-15 17:02:39', '2026-09-15 17:02:39', 0, NULL),
(190, 25, 4, 'Y', 'TKN-MCH-20260915-4-7634', 'bheem123', 1, '2026-09-15', '2026-09-15 17:02:39', '2026-09-15 17:02:39', 0, NULL),
(191, 26, 4, 'Y', 'TKN-MCH-20260915-4-7634', 'bheem123', 1, '2026-09-15', '2026-09-15 17:02:39', '2026-09-15 17:02:39', 0, NULL),
(192, 27, 4, 'Y', 'TKN-MCH-20260915-4-7634', 'bheem123', 1, '2026-09-15', '2026-09-15 17:02:39', '2026-09-15 17:02:39', 0, NULL),
(193, 28, 4, 'Y', 'TKN-MCH-20260915-4-7634', 'bheem123', 1, '2026-09-15', '2026-09-15 17:02:39', '2026-09-15 17:02:39', 0, NULL),
(194, 29, 4, 'Y', 'TKN-MCH-20260915-4-7634', 'bheem123', 1, '2026-09-15', '2026-09-15 17:02:39', '2026-09-15 17:02:39', 0, NULL),
(195, 30, 4, 'Y', 'TKN-MCH-20260915-4-7634', 'bheem123', 1, '2026-09-15', '2026-09-15 17:02:39', '2026-09-15 17:02:39', 0, NULL),
(196, 16, 5, 'Y', 'TKN-MCH-20260915-5-2841', 'bheem123', 1, '2026-09-15', '2026-09-15 17:04:03', '2026-09-15 17:04:03', 0, NULL),
(197, 17, 5, 'Y', 'TKN-MCH-20260915-5-2841', 'bheem123', 1, '2026-09-15', '2026-09-15 17:04:03', '2026-09-15 17:04:03', 0, NULL),
(198, 18, 5, 'Y', 'TKN-MCH-20260915-5-2841', 'bheem123', 1, '2026-09-15', '2026-09-15 17:04:03', '2026-09-15 17:04:03', 0, NULL),
(199, 19, 5, 'Y', 'TKN-MCH-20260915-5-2841', 'bheem123', 1, '2026-09-15', '2026-09-15 17:04:03', '2026-09-15 17:04:03', 0, NULL),
(200, 20, 5, 'Y', 'TKN-MCH-20260915-5-2841', 'bheem123', 1, '2026-09-15', '2026-09-15 17:04:03', '2026-09-15 17:04:03', 0, NULL),
(201, 21, 5, 'Y', 'TKN-MCH-20260915-5-2841', 'bheem123', 1, '2026-09-15', '2026-09-15 17:04:03', '2026-09-15 17:04:03', 0, NULL),
(202, 22, 5, 'Y', 'TKN-MCH-20260915-5-2841', 'bheem123', 1, '2026-09-15', '2026-09-15 17:04:03', '2026-09-15 17:04:03', 0, NULL),
(203, 23, 5, 'Y', 'TKN-MCH-20260915-5-2841', 'bheem123', 1, '2026-09-15', '2026-09-15 17:04:03', '2026-09-15 17:04:03', 0, NULL),
(204, 24, 5, 'Y', 'TKN-MCH-20260915-5-2841', 'bheem123', 1, '2026-09-15', '2026-09-15 17:04:03', '2026-09-15 17:04:03', 0, NULL),
(205, 25, 5, 'Y', 'TKN-MCH-20260915-5-2841', 'bheem123', 1, '2026-09-15', '2026-09-15 17:04:03', '2026-09-15 17:04:03', 0, NULL),
(206, 26, 5, 'Y', 'TKN-MCH-20260915-5-2841', 'bheem123', 1, '2026-09-15', '2026-09-15 17:04:03', '2026-09-15 17:04:03', 0, NULL),
(207, 27, 5, 'Y', 'TKN-MCH-20260915-5-2841', 'bheem123', 1, '2026-09-15', '2026-09-15 17:04:03', '2026-09-15 17:04:03', 0, NULL),
(208, 28, 5, 'Y', 'TKN-MCH-20260915-5-2841', 'bheem123', 1, '2026-09-15', '2026-09-15 17:04:03', '2026-09-15 17:04:03', 0, NULL),
(209, 29, 5, 'Y', 'TKN-MCH-20260915-5-2841', 'bheem123', 1, '2026-09-15', '2026-09-15 17:04:03', '2026-09-15 17:04:03', 0, NULL),
(210, 30, 5, 'Y', 'TKN-MCH-20260915-5-2841', 'bheem123', 1, '2026-09-15', '2026-09-15 17:04:03', '2026-09-15 17:04:03', 0, NULL),
(211, 16, 4, 'Y', 'TKN-MCH-20260921-4-1731', 'RAJ BIRUA', 1, '2026-09-21', '2026-09-21 14:06:16', '2026-09-21 14:06:16', 0, NULL),
(212, 17, 4, 'Y', 'TKN-MCH-20260921-4-1731', 'RAJ BIRUA', 1, '2026-09-21', '2026-09-21 14:06:16', '2026-09-21 14:06:16', 0, NULL),
(213, 18, 4, 'Y', 'TKN-MCH-20260921-4-1731', 'RAJ BIRUA', 1, '2026-09-21', '2026-09-21 14:06:16', '2026-09-21 14:06:16', 0, NULL),
(214, 19, 4, 'Y', 'TKN-MCH-20260921-4-1731', 'RAJ BIRUA', 1, '2026-09-21', '2026-09-21 14:06:16', '2026-09-21 14:06:16', 0, NULL),
(215, 20, 4, 'Y', 'TKN-MCH-20260921-4-1731', 'RAJ BIRUA', 1, '2026-09-21', '2026-09-21 14:06:16', '2026-09-21 14:06:16', 0, NULL),
(216, 21, 4, 'Y', 'TKN-MCH-20260921-4-1731', 'RAJ BIRUA', 1, '2026-09-21', '2026-09-21 14:06:16', '2026-09-21 14:06:16', 0, NULL),
(217, 22, 4, 'Y', 'TKN-MCH-20260921-4-1731', 'RAJ BIRUA', 1, '2026-09-21', '2026-09-21 14:06:16', '2026-09-21 14:06:16', 0, NULL),
(218, 23, 4, 'Y', 'TKN-MCH-20260921-4-1731', 'RAJ BIRUA', 1, '2026-09-21', '2026-09-21 14:06:16', '2026-09-21 14:06:16', 0, NULL),
(219, 24, 4, 'Y', 'TKN-MCH-20260921-4-1731', 'RAJ BIRUA', 1, '2026-09-21', '2026-09-21 14:06:16', '2026-09-21 14:06:16', 0, NULL),
(220, 25, 4, 'Y', 'TKN-MCH-20260921-4-1731', 'RAJ BIRUA', 1, '2026-09-21', '2026-09-21 14:06:16', '2026-09-21 14:06:16', 0, NULL),
(221, 26, 4, 'Y', 'TKN-MCH-20260921-4-1731', 'RAJ BIRUA', 1, '2026-09-21', '2026-09-21 14:06:16', '2026-09-21 14:06:16', 0, NULL),
(222, 27, 4, 'Y', 'TKN-MCH-20260921-4-1731', 'RAJ BIRUA', 1, '2026-09-21', '2026-09-21 14:06:16', '2026-09-21 14:06:16', 0, NULL),
(223, 28, 4, 'Y', 'TKN-MCH-20260921-4-1731', 'RAJ BIRUA', 1, '2026-09-21', '2026-09-21 14:06:16', '2026-09-21 14:06:16', 0, NULL),
(224, 29, 4, 'Y', 'TKN-MCH-20260921-4-1731', 'RAJ BIRUA', 1, '2026-09-21', '2026-09-21 14:06:16', '2026-09-21 14:06:16', 0, NULL),
(225, 30, 4, 'Y', 'TKN-MCH-20260921-4-1731', 'RAJ BIRUA', 1, '2026-09-21', '2026-09-21 14:06:16', '2026-09-21 14:06:16', 0, NULL);

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
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_normal_scorecard_report`
--

INSERT INTO `mcc_normal_scorecard_report` (`id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `auditor_name`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(1, 7, 1, 'TKN-20260907-999', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:07:53', 0, NULL),
(2, 8, 1, 'TKN-20260907-999', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:07:53', 0, NULL),
(3, 9, 1, 'TKN-20260907-999', '12345', 'C1', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:07:53', 0, NULL),
(4, 10, 1, 'TKN-20260907-999', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:07:53', 0, NULL),
(5, 11, 1, 'TKN-20260907-999', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:07:55', 0, NULL),
(6, 12, 1, 'TKN-20260907-999', '12345', 'C1', 'Y', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:07:57', 0, NULL),
(7, 7, 1, 'TKN-20260907-999', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:06', 0, NULL),
(8, 8, 1, 'TKN-20260907-999', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:06', 0, NULL),
(9, 9, 1, 'TKN-20260907-999', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:06', 0, NULL),
(10, 10, 1, 'TKN-20260907-999', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:06', 0, NULL),
(11, 11, 1, 'TKN-20260907-999', '12345', 'C2', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:10', 0, NULL),
(12, 12, 1, 'TKN-20260907-999', '12345', 'C2', 'Y', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:13', 0, NULL),
(13, 7, 1, 'TKN-20260907-999', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:19', 0, NULL),
(14, 8, 1, 'TKN-20260907-999', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:19', 0, NULL),
(15, 9, 1, 'TKN-20260907-999', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:19', 0, NULL),
(16, 10, 1, 'TKN-20260907-999', '12345', 'C3', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:19', 0, NULL),
(17, 11, 1, 'TKN-20260907-999', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:22', 0, NULL),
(18, 12, 1, 'TKN-20260907-999', '12345', 'C3', 'Y', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:24', 0, NULL),
(19, 7, 1, 'TKN-20260907-999', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:27', 0, NULL),
(20, 8, 1, 'TKN-20260907-999', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:27', 0, NULL),
(21, 9, 1, 'TKN-20260907-999', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:27', 0, NULL),
(22, 10, 1, 'TKN-20260907-999', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:27', 0, NULL),
(23, 11, 1, 'TKN-20260907-999', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:30', 0, NULL),
(24, 12, 1, 'TKN-20260907-999', '12345', 'C4', 'Y', 'Bheem Chand', '2026-09-07', '2026-09-07 14:07:41', '2026-09-07 14:08:32', 0, NULL),
(25, 7, 1, 'TKN-20260908-837', '16210', '1', '3', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:15', 0, NULL),
(26, 8, 1, 'TKN-20260908-837', '16210', '1', '3', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:15', 0, NULL),
(27, 9, 1, 'TKN-20260908-837', '16210', '1', '3', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:15', 0, NULL),
(28, 10, 1, 'TKN-20260908-837', '16210', '1', '3', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:15', 0, NULL),
(29, 11, 1, 'TKN-20260908-837', '16210', '1', '3', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:18', 0, NULL),
(30, 12, 1, 'TKN-20260908-837', '16210', '1', 'Y', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:20', 0, NULL),
(31, 7, 1, 'TKN-20260908-837', '16210', '2', '3', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:29', 0, NULL),
(32, 8, 1, 'TKN-20260908-837', '16210', '2', '3', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:29', 0, NULL),
(33, 9, 1, 'TKN-20260908-837', '16210', '2', '2', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:29', 0, NULL),
(34, 10, 1, 'TKN-20260908-837', '16210', '2', '3', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:29', 0, NULL),
(35, 11, 1, 'TKN-20260908-837', '16210', '2', '2', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:33', 0, NULL),
(36, 12, 1, 'TKN-20260908-837', '16210', '2', 'Y', 'Sayan', '2026-09-08', '2026-09-08 07:40:31', '2026-09-08 13:36:37', 0, NULL),
(37, 7, 1, 'TKN-20260908-707', '16215', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:05', 0, NULL),
(38, 8, 1, 'TKN-20260908-707', '16215', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:05', 0, NULL),
(39, 9, 1, 'TKN-20260908-707', '16215', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:05', 0, NULL),
(40, 10, 1, 'TKN-20260908-707', '16215', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:05', 0, NULL),
(41, 11, 1, 'TKN-20260908-707', '16215', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:09', 0, NULL),
(42, 12, 1, 'TKN-20260908-707', '16215', '01', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:12', 0, NULL),
(43, 7, 1, 'TKN-20260908-707', '16215', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:19', 0, NULL),
(44, 8, 1, 'TKN-20260908-707', '16215', '02', '2', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:19', 0, NULL),
(45, 9, 1, 'TKN-20260908-707', '16215', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:19', 0, NULL),
(46, 10, 1, 'TKN-20260908-707', '16215', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:19', 0, NULL),
(47, 11, 1, 'TKN-20260908-707', '16215', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:28', 0, NULL),
(48, 12, 1, 'TKN-20260908-707', '16215', '02', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:31', 0, NULL),
(49, 7, 1, 'TKN-20260908-707', '16215', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:44', 0, NULL),
(50, 8, 1, 'TKN-20260908-707', '16215', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:44', 0, NULL),
(51, 9, 1, 'TKN-20260908-707', '16215', '03', '2', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:44', 0, NULL),
(52, 10, 1, 'TKN-20260908-707', '16215', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:44', 0, NULL),
(53, 11, 1, 'TKN-20260908-707', '16215', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:47', 0, NULL),
(54, 12, 1, 'TKN-20260908-707', '16215', '03', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:12:43', '2026-09-08 13:13:50', 0, NULL),
(55, 7, 1, 'TKN-20260908-892', '56202', '01', '3', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:28', 0, NULL),
(56, 8, 1, 'TKN-20260908-892', '56202', '01', '2', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:28', 0, NULL),
(57, 9, 1, 'TKN-20260908-892', '56202', '01', '3', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:28', 0, NULL),
(58, 10, 1, 'TKN-20260908-892', '56202', '01', '3', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:28', 0, NULL),
(59, 11, 1, 'TKN-20260908-892', '56202', '01', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(60, 12, 1, 'TKN-20260908-892', '56202', '01', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(61, 7, 1, 'TKN-20260908-892', '56202', '02', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(62, 8, 1, 'TKN-20260908-892', '56202', '02', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(63, 9, 1, 'TKN-20260908-892', '56202', '02', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(64, 10, 1, 'TKN-20260908-892', '56202', '02', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(65, 11, 1, 'TKN-20260908-892', '56202', '02', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(66, 12, 1, 'TKN-20260908-892', '56202', '02', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(67, 7, 1, 'TKN-20260908-892', '56202', '03', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(68, 8, 1, 'TKN-20260908-892', '56202', '03', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(69, 9, 1, 'TKN-20260908-892', '56202', '03', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(70, 10, 1, 'TKN-20260908-892', '56202', '03', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(71, 11, 1, 'TKN-20260908-892', '56202', '03', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(72, 12, 1, 'TKN-20260908-892', '56202', '03', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(73, 7, 1, 'TKN-20260908-892', '56202', '04', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(74, 8, 1, 'TKN-20260908-892', '56202', '04', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(75, 9, 1, 'TKN-20260908-892', '56202', '04', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(76, 10, 1, 'TKN-20260908-892', '56202', '04', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(77, 11, 1, 'TKN-20260908-892', '56202', '04', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(78, 12, 1, 'TKN-20260908-892', '56202', '04', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(79, 7, 1, 'TKN-20260908-892', '56202', '05', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(80, 8, 1, 'TKN-20260908-892', '56202', '05', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(81, 9, 1, 'TKN-20260908-892', '56202', '05', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(82, 10, 1, 'TKN-20260908-892', '56202', '05', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(83, 11, 1, 'TKN-20260908-892', '56202', '05', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(84, 12, 1, 'TKN-20260908-892', '56202', '05', '', 'Subham Bansal', '2026-09-08', '2026-09-08 13:37:19', '2026-09-08 13:37:19', 0, NULL),
(85, 7, 1, 'TKN-20260909-797', '16236', '01', '2', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:12:50', 0, NULL),
(86, 8, 1, 'TKN-20260909-797', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:12:50', 0, NULL),
(87, 9, 1, 'TKN-20260909-797', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:12:50', 0, NULL),
(88, 10, 1, 'TKN-20260909-797', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:12:50', 0, NULL),
(89, 11, 1, 'TKN-20260909-797', '16236', '01', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:12:53', 0, NULL),
(90, 12, 1, 'TKN-20260909-797', '16236', '01', 'Y', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:12:56', 0, NULL),
(91, 7, 1, 'TKN-20260909-797', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:03', 0, NULL),
(92, 8, 1, 'TKN-20260909-797', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:03', 0, NULL),
(93, 9, 1, 'TKN-20260909-797', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:03', 0, NULL),
(94, 10, 1, 'TKN-20260909-797', '16236', '02', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:03', 0, NULL),
(95, 11, 1, 'TKN-20260909-797', '16236', '02', '2', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:07', 0, NULL),
(96, 12, 1, 'TKN-20260909-797', '16236', '02', 'Y', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:10', 0, NULL),
(97, 7, 1, 'TKN-20260909-797', '16236', '03', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:15', 0, NULL),
(98, 8, 1, 'TKN-20260909-797', '16236', '03', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:15', 0, NULL),
(99, 9, 1, 'TKN-20260909-797', '16236', '03', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:15', 0, NULL),
(100, 10, 1, 'TKN-20260909-797', '16236', '03', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:15', 0, NULL),
(101, 11, 1, 'TKN-20260909-797', '16236', '03', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:17', 0, NULL),
(102, 12, 1, 'TKN-20260909-797', '16236', '03', 'Y', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:20', 0, NULL),
(103, 7, 1, 'TKN-20260909-797', '16236', '04', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:26', 0, NULL),
(104, 8, 1, 'TKN-20260909-797', '16236', '04', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:26', 0, NULL),
(105, 9, 1, 'TKN-20260909-797', '16236', '04', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:26', 0, NULL),
(106, 10, 1, 'TKN-20260909-797', '16236', '04', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:26', 0, NULL),
(107, 11, 1, 'TKN-20260909-797', '16236', '04', '2', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:30', 0, NULL),
(108, 12, 1, 'TKN-20260909-797', '16236', '04', 'Y', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:33', 0, NULL),
(109, 7, 1, 'TKN-20260909-797', '16236', '05', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:41', 0, NULL),
(110, 8, 1, 'TKN-20260909-797', '16236', '05', '2', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:41', 0, NULL),
(111, 9, 1, 'TKN-20260909-797', '16236', '05', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:41', 0, NULL),
(112, 10, 1, 'TKN-20260909-797', '16236', '05', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:41', 0, NULL),
(113, 11, 1, 'TKN-20260909-797', '16236', '05', '3', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:46', 0, NULL),
(114, 12, 1, 'TKN-20260909-797', '16236', '05', 'Y', 'Darshan', '2026-09-09', '2026-09-09 07:12:42', '2026-09-09 07:13:49', 0, NULL),
(115, 7, 1, 'TKN-20260909-562', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:41', 0, NULL),
(116, 8, 1, 'TKN-20260909-562', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:41', 0, NULL),
(117, 9, 1, 'TKN-20260909-562', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:41', 0, NULL),
(118, 10, 1, 'TKN-20260909-562', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:41', 0, NULL),
(119, 11, 1, 'TKN-20260909-562', '22687', '01', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:44', 0, NULL),
(120, 12, 1, 'TKN-20260909-562', '22687', '01', 'Y', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:47', 0, NULL),
(121, 7, 1, 'TKN-20260909-562', '22687', '02', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:56', 0, NULL),
(122, 8, 1, 'TKN-20260909-562', '22687', '02', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:56', 0, NULL),
(123, 9, 1, 'TKN-20260909-562', '22687', '02', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:56', 0, NULL),
(124, 10, 1, 'TKN-20260909-562', '22687', '02', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:14:56', 0, NULL),
(125, 11, 1, 'TKN-20260909-562', '22687', '02', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:01', 0, NULL),
(126, 12, 1, 'TKN-20260909-562', '22687', '02', 'Y', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:03', 0, NULL),
(127, 7, 1, 'TKN-20260909-562', '22687', '03', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:10', 0, NULL),
(128, 8, 1, 'TKN-20260909-562', '22687', '03', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:10', 0, NULL),
(129, 9, 1, 'TKN-20260909-562', '22687', '03', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:10', 0, NULL),
(130, 10, 1, 'TKN-20260909-562', '22687', '03', '2', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:10', 0, NULL),
(131, 11, 1, 'TKN-20260909-562', '22687', '03', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:13', 0, NULL),
(132, 12, 1, 'TKN-20260909-562', '22687', '03', 'Y', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:15', 0, NULL),
(133, 7, 1, 'TKN-20260909-562', '22687', '04', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:32', 0, NULL),
(134, 8, 1, 'TKN-20260909-562', '22687', '04', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:32', 0, NULL),
(135, 9, 1, 'TKN-20260909-562', '22687', '04', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:32', 0, NULL),
(136, 10, 1, 'TKN-20260909-562', '22687', '04', '3', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:32', 0, NULL),
(137, 11, 1, 'TKN-20260909-562', '22687', '04', '1', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:24', 0, NULL),
(138, 12, 1, 'TKN-20260909-562', '22687', '04', 'Y', 'Sandesh', '2026-09-09', '2026-09-09 07:14:36', '2026-09-09 07:15:35', 0, NULL),
(139, 7, 1, 'TKN-20260909-404', '22681', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:31', 0, NULL),
(140, 8, 1, 'TKN-20260909-404', '22681', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:31', 0, NULL),
(141, 9, 1, 'TKN-20260909-404', '22681', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:31', 0, NULL),
(142, 10, 1, 'TKN-20260909-404', '22681', '01', '2', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:31', 0, NULL),
(143, 11, 1, 'TKN-20260909-404', '22681', '01', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:33', 0, NULL),
(144, 12, 1, 'TKN-20260909-404', '22681', '01', 'Y', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:36', 0, NULL),
(145, 7, 1, 'TKN-20260909-404', '22681', '02', '2', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:43', 0, NULL),
(146, 8, 1, 'TKN-20260909-404', '22681', '02', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:43', 0, NULL),
(147, 9, 1, 'TKN-20260909-404', '22681', '02', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:43', 0, NULL),
(148, 10, 1, 'TKN-20260909-404', '22681', '02', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:43', 0, NULL),
(149, 11, 1, 'TKN-20260909-404', '22681', '02', '2', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:48', 0, NULL),
(150, 12, 1, 'TKN-20260909-404', '22681', '02', 'Y', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:50', 0, NULL),
(151, 7, 1, 'TKN-20260909-404', '22681', '03', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:55', 0, NULL),
(152, 8, 1, 'TKN-20260909-404', '22681', '03', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:55', 0, NULL),
(153, 9, 1, 'TKN-20260909-404', '22681', '03', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:55', 0, NULL),
(154, 10, 1, 'TKN-20260909-404', '22681', '03', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:55', 0, NULL),
(155, 11, 1, 'TKN-20260909-404', '22681', '03', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:16:58', 0, NULL),
(156, 12, 1, 'TKN-20260909-404', '22681', '03', 'Y', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:01', 0, NULL),
(157, 7, 1, 'TKN-20260909-404', '22681', '04', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:05', 0, NULL),
(158, 8, 1, 'TKN-20260909-404', '22681', '04', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:05', 0, NULL),
(159, 9, 1, 'TKN-20260909-404', '22681', '04', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:05', 0, NULL),
(160, 10, 1, 'TKN-20260909-404', '22681', '04', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:05', 0, NULL),
(161, 11, 1, 'TKN-20260909-404', '22681', '04', '2', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:09', 0, NULL),
(162, 12, 1, 'TKN-20260909-404', '22681', '04', 'Y', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:12', 0, NULL),
(163, 7, 1, 'TKN-20260909-404', '22681', '05', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:19', 0, NULL),
(164, 8, 1, 'TKN-20260909-404', '22681', '05', '2', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:19', 0, NULL),
(165, 9, 1, 'TKN-20260909-404', '22681', '05', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:19', 0, NULL),
(166, 10, 1, 'TKN-20260909-404', '22681', '05', '3', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:19', 0, NULL),
(167, 11, 1, 'TKN-20260909-404', '22681', '05', '2', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:24', 0, NULL),
(168, 12, 1, 'TKN-20260909-404', '22681', '05', 'Y', 'Rafik', '2026-09-09', '2026-09-09 07:16:21', '2026-09-09 07:17:26', 0, NULL),
(169, 7, 1, 'TKN-20260909-287', '16227', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:45', 0, NULL),
(170, 8, 1, 'TKN-20260909-287', '16227', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:45', 0, NULL),
(171, 9, 1, 'TKN-20260909-287', '16227', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:45', 0, NULL),
(172, 10, 1, 'TKN-20260909-287', '16227', '01', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:45', 0, NULL),
(173, 11, 1, 'TKN-20260909-287', '16227', '01', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:49', 0, NULL),
(174, 12, 1, 'TKN-20260909-287', '16227', '01', 'Y', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:52', 0, NULL),
(175, 7, 1, 'TKN-20260909-287', '16227', '02', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:58', 0, NULL),
(176, 8, 1, 'TKN-20260909-287', '16227', '02', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:58', 0, NULL),
(177, 9, 1, 'TKN-20260909-287', '16227', '02', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:58', 0, NULL),
(178, 10, 1, 'TKN-20260909-287', '16227', '02', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:18:58', 0, NULL),
(179, 11, 1, 'TKN-20260909-287', '16227', '02', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:01', 0, NULL),
(180, 12, 1, 'TKN-20260909-287', '16227', '02', 'Y', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:04', 0, NULL),
(181, 7, 1, 'TKN-20260909-287', '16227', '03', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:09', 0, NULL),
(182, 8, 1, 'TKN-20260909-287', '16227', '03', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:09', 0, NULL),
(183, 9, 1, 'TKN-20260909-287', '16227', '03', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:09', 0, NULL),
(184, 10, 1, 'TKN-20260909-287', '16227', '03', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:09', 0, NULL),
(185, 11, 1, 'TKN-20260909-287', '16227', '03', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:13', 0, NULL),
(186, 12, 1, 'TKN-20260909-287', '16227', '03', 'Y', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:16', 0, NULL),
(187, 7, 1, 'TKN-20260909-287', '16227', '04', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:21', 0, NULL),
(188, 8, 1, 'TKN-20260909-287', '16227', '04', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:21', 0, NULL),
(189, 9, 1, 'TKN-20260909-287', '16227', '04', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:21', 0, NULL),
(190, 10, 1, 'TKN-20260909-287', '16227', '04', '3', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:21', 0, NULL),
(191, 11, 1, 'TKN-20260909-287', '16227', '04', '2', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:26', 0, NULL),
(192, 12, 1, 'TKN-20260909-287', '16227', '04', 'Y', 'Shivkumar', '2026-09-09', '2026-09-09 07:18:35', '2026-09-09 07:19:29', 0, NULL),
(193, 14, 4, 'TKN-20260912-852', '12345', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:05', 0, NULL),
(194, 15, 4, 'TKN-20260912-852', '12345', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:05', 0, NULL),
(195, 16, 4, 'TKN-20260912-852', '12345', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:05', 0, NULL),
(196, 17, 4, 'TKN-20260912-852', '12345', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:05', 0, NULL),
(197, 18, 4, 'TKN-20260912-852', '12345', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:08', 0, NULL),
(198, 19, 4, 'TKN-20260912-852', '12345', 'C1', 'Y', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:00:59', '2026-09-12 08:01:12', 0, NULL),
(199, 7, 1, 'TKN-20260912-033', '12345', 'C1', '3', 'Bheem Chand', '2026-09-12', '2026-09-12 11:23:57', '2026-09-17 13:17:09', 0, 2),
(200, 8, 1, 'TKN-20260912-033', '12345', 'C1', '3', 'Bheem Chand', '2026-09-12', '2026-09-12 11:23:57', '2026-09-17 13:17:09', 0, 2),
(201, 9, 1, 'TKN-20260912-033', '12345', 'C1', '3', 'Bheem Chand', '2026-09-12', '2026-09-12 11:23:57', '2026-09-17 13:17:09', 0, 2),
(202, 10, 1, 'TKN-20260912-033', '12345', 'C1', '3', 'Bheem Chand', '2026-09-12', '2026-09-12 11:23:57', '2026-09-17 13:17:09', 0, 2),
(203, 11, 1, 'TKN-20260912-033', '12345', 'C1', '', 'Bheem Chand', '2026-09-12', '2026-09-12 11:23:57', '2026-09-17 13:17:09', 0, 2),
(204, 12, 1, 'TKN-20260912-033', '12345', 'C1', '', 'Bheem Chand', '2026-09-12', '2026-09-12 11:23:57', '2026-09-17 13:17:09', 0, 2),
(205, 7, 1, 'TKN-20260912-033', '12345', 'C2', '', 'Bheem Chand', '2026-09-12', '2026-09-12 11:23:57', '2026-09-17 13:17:09', 0, 2),
(206, 8, 1, 'TKN-20260912-033', '12345', 'C2', '', 'Bheem Chand', '2026-09-12', '2026-09-12 11:23:57', '2026-09-17 13:17:09', 0, 2),
(207, 9, 1, 'TKN-20260912-033', '12345', 'C2', '', 'Bheem Chand', '2026-09-12', '2026-09-12 11:23:57', '2026-09-17 13:17:09', 0, 2),
(208, 10, 1, 'TKN-20260912-033', '12345', 'C2', '', 'Bheem Chand', '2026-09-12', '2026-09-12 11:23:57', '2026-09-17 13:17:09', 0, 2),
(209, 11, 1, 'TKN-20260912-033', '12345', 'C2', '', 'Bheem Chand', '2026-09-12', '2026-09-12 11:23:57', '2026-09-17 13:17:09', 0, 2),
(210, 12, 1, 'TKN-20260912-033', '12345', 'C2', '', 'Bheem Chand', '2026-09-12', '2026-09-12 11:23:57', '2026-09-17 13:17:09', 0, 2),
(211, 14, 4, 'TKN-20260915-026', '812601', 'S1', '', 'SCL AUDITOR', '2026-09-15', '2026-09-15 10:01:18', '2026-09-18 12:48:54', 1, NULL),
(212, 15, 4, 'TKN-20260915-026', '812601', 'S1', '', 'SCL AUDITOR', '2026-09-15', '2026-09-15 10:01:18', '2026-09-18 12:48:54', 1, NULL),
(213, 16, 4, 'TKN-20260915-026', '812601', 'S1', '', 'SCL AUDITOR', '2026-09-15', '2026-09-15 10:01:18', '2026-09-18 12:48:54', 1, NULL),
(214, 17, 4, 'TKN-20260915-026', '812601', 'S1', '', 'SCL AUDITOR', '2026-09-15', '2026-09-15 10:01:18', '2026-09-18 12:48:54', 1, NULL),
(215, 18, 4, 'TKN-20260915-026', '812601', 'S1', '', 'SCL AUDITOR', '2026-09-15', '2026-09-15 10:01:18', '2026-09-18 12:48:54', 1, NULL),
(216, 19, 4, 'TKN-20260915-026', '812601', 'S1', '', 'SCL AUDITOR', '2026-09-15', '2026-09-15 10:01:18', '2026-09-18 12:48:54', 1, NULL),
(217, 14, 4, 'TKN-20260915-026', '812601', 'S2', '', 'SCL AUDITOR', '2026-09-15', '2026-09-15 10:01:18', '2026-09-18 12:48:54', 1, NULL),
(218, 15, 4, 'TKN-20260915-026', '812601', 'S2', '', 'SCL AUDITOR', '2026-09-15', '2026-09-15 10:01:18', '2026-09-18 12:48:54', 1, NULL),
(219, 16, 4, 'TKN-20260915-026', '812601', 'S2', '', 'SCL AUDITOR', '2026-09-15', '2026-09-15 10:01:18', '2026-09-18 12:48:54', 1, NULL),
(220, 17, 4, 'TKN-20260915-026', '812601', 'S2', '', 'SCL AUDITOR', '2026-09-15', '2026-09-15 10:01:18', '2026-09-18 12:48:54', 1, NULL),
(221, 18, 4, 'TKN-20260915-026', '812601', 'S2', '', 'SCL AUDITOR', '2026-09-15', '2026-09-15 10:01:18', '2026-09-18 12:48:54', 1, NULL),
(222, 19, 4, 'TKN-20260915-026', '812601', 'S2', '', 'SCL AUDITOR', '2026-09-15', '2026-09-15 10:01:18', '2026-09-18 12:48:54', 1, NULL),
(223, 14, 4, 'TKN-20260915-026', '812601', 'S3', '', 'SCL AUDITOR', '2026-09-15', '2026-09-15 10:01:18', '2026-09-18 12:48:54', 1, NULL),
(224, 15, 4, 'TKN-20260915-026', '812601', 'S3', '', 'SCL AUDITOR', '2026-09-15', '2026-09-15 10:01:18', '2026-09-18 12:48:54', 1, NULL),
(225, 16, 4, 'TKN-20260915-026', '812601', 'S3', '', 'SCL AUDITOR', '2026-09-15', '2026-09-15 10:01:18', '2026-09-18 12:48:54', 1, NULL),
(226, 17, 4, 'TKN-20260915-026', '812601', 'S3', '', 'SCL AUDITOR', '2026-09-15', '2026-09-15 10:01:18', '2026-09-18 12:48:54', 1, NULL),
(227, 18, 4, 'TKN-20260915-026', '812601', 'S3', '', 'SCL AUDITOR', '2026-09-15', '2026-09-15 10:01:18', '2026-09-18 12:48:54', 1, NULL),
(228, 19, 4, 'TKN-20260915-026', '812601', 'S3', '', 'SCL AUDITOR', '2026-09-15', '2026-09-15 10:01:18', '2026-09-18 12:48:54', 1, NULL),
(229, 7, 1, 'TKN-20260917-899', '123', '12', '3', 'Ajit Kumar', '2026-09-17', '2026-09-17 08:27:42', '2026-09-17 13:17:22', 1, 2),
(230, 8, 1, 'TKN-20260917-899', '123', '12', '3', 'Ajit Kumar', '2026-09-17', '2026-09-17 08:27:42', '2026-09-17 13:17:22', 1, 2),
(231, 9, 1, 'TKN-20260917-899', '123', '12', '3', 'Ajit Kumar', '2026-09-17', '2026-09-17 08:27:42', '2026-09-17 13:17:22', 1, 2),
(232, 10, 1, 'TKN-20260917-899', '123', '12', '3', 'Ajit Kumar', '2026-09-17', '2026-09-17 08:27:42', '2026-09-17 13:17:22', 1, 2),
(233, 11, 1, 'TKN-20260917-899', '123', '12', '3', 'Ajit Kumar', '2026-09-17', '2026-09-17 08:27:42', '2026-09-17 13:17:22', 1, 2),
(234, 12, 1, 'TKN-20260917-899', '123', '12', 'Y', 'Ajit Kumar', '2026-09-17', '2026-09-17 08:27:42', '2026-09-17 13:17:22', 1, 2),
(235, 7, 1, 'TKN-20260917-027', '16236', '123', '3', 'Ajit Kumar', '2026-09-17', '2026-09-17 10:06:01', '2026-09-17 13:17:09', 0, 1),
(236, 8, 1, 'TKN-20260917-027', '16236', '123', '2', 'Ajit Kumar', '2026-09-17', '2026-09-17 10:06:01', '2026-09-17 13:17:09', 0, 1),
(237, 9, 1, 'TKN-20260917-027', '16236', '123', '1', 'Ajit Kumar', '2026-09-17', '2026-09-17 10:06:01', '2026-09-17 13:17:09', 0, 1),
(238, 10, 1, 'TKN-20260917-027', '16236', '123', '3', 'Ajit Kumar', '2026-09-17', '2026-09-17 10:06:01', '2026-09-17 13:17:09', 0, 1),
(239, 11, 1, 'TKN-20260917-027', '16236', '123', '3', 'Ajit Kumar', '2026-09-17', '2026-09-17 10:06:01', '2026-09-17 13:17:09', 0, 1),
(240, 12, 1, 'TKN-20260917-027', '16236', '123', 'Y', 'Ajit Kumar', '2026-09-17', '2026-09-17 10:06:01', '2026-09-17 13:17:09', 0, 1),
(241, 14, 4, 'TKN-20260918-199', '812601', 'S1', '3', 'SCL AUDITOR', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 12:37:09', 1, 14),
(242, 15, 4, 'TKN-20260918-199', '812601', 'S1', '3', 'SCL AUDITOR', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 12:37:13', 1, 14),
(243, 16, 4, 'TKN-20260918-199', '812601', 'S1', '3', 'SCL AUDITOR', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 12:37:17', 1, 14),
(244, 17, 4, 'TKN-20260918-199', '812601', 'S1', '3', 'SCL AUDITOR', '2026-09-18', '2026-09-18 08:53:48', '2026-09-18 12:37:22', 1, 14),
(245, 18, 4, 'TKN-20260918-199', '812601', 'S1', '3', 'SCL AUDITOR', '2026-09-18', '2026-09-18 08:53:48', '2026-09-19 12:37:34', 1, 14),
(246, 19, 4, 'TKN-20260918-199', '812601', 'S1', 'Y', 'SCL AUDITOR', '2026-09-18', '2026-09-18 08:53:48', '2026-09-19 12:37:37', 1, 14),
(247, 14, 4, 'TKN-20260918-199', '812601', 'S2', '2', 'SCL AUDITOR', '2026-09-18', '2026-09-18 08:53:48', '2026-09-19 12:37:23', 1, 14),
(248, 15, 4, 'TKN-20260918-199', '812601', 'S2', '2', 'SCL AUDITOR', '2026-09-18', '2026-09-18 08:53:48', '2026-09-19 12:37:26', 1, 14),
(249, 16, 4, 'TKN-20260918-199', '812601', 'S2', '3', 'SCL AUDITOR', '2026-09-18', '2026-09-18 08:53:48', '2026-09-19 12:37:28', 1, 14),
(250, 17, 4, 'TKN-20260918-199', '812601', 'S2', '3', 'SCL AUDITOR', '2026-09-18', '2026-09-18 08:53:48', '2026-09-19 12:37:31', 1, 14),
(251, 18, 4, 'TKN-20260918-199', '812601', 'S2', '2', 'SCL AUDITOR', '2026-09-18', '2026-09-18 08:53:48', '2026-09-19 12:37:34', 1, 14),
(252, 19, 4, 'TKN-20260918-199', '812601', 'S2', 'Y', 'SCL AUDITOR', '2026-09-18', '2026-09-18 08:53:48', '2026-09-19 12:37:37', 1, 14),
(253, 14, 4, 'TKN-20260918-199', '812601', 'S3', '3', 'SCL AUDITOR', '2026-09-18', '2026-09-18 08:53:48', '2026-09-19 12:37:23', 1, 14),
(254, 15, 4, 'TKN-20260918-199', '812601', 'S3', '2', 'SCL AUDITOR', '2026-09-18', '2026-09-18 08:53:48', '2026-09-19 12:37:26', 1, 14),
(255, 16, 4, 'TKN-20260918-199', '812601', 'S3', '3', 'SCL AUDITOR', '2026-09-18', '2026-09-18 08:53:48', '2026-09-19 12:37:29', 1, 14),
(256, 17, 4, 'TKN-20260918-199', '812601', 'S3', '3', 'SCL AUDITOR', '2026-09-18', '2026-09-18 08:53:48', '2026-09-19 12:37:32', 1, 14),
(257, 18, 4, 'TKN-20260918-199', '812601', 'S3', '2', 'SCL AUDITOR', '2026-09-18', '2026-09-18 08:53:48', '2026-09-19 12:37:34', 1, 14),
(258, 19, 4, 'TKN-20260918-199', '812601', 'S3', 'Y', 'SCL AUDITOR', '2026-09-18', '2026-09-18 08:53:48', '2026-09-19 12:38:17', 1, 14),
(259, 7, 1, 'TKN-20260921-484', '16236', 'S1', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 14:01:52', 0, 16),
(260, 8, 1, 'TKN-20260921-484', '16236', 'S1', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 14:01:52', 0, 16),
(261, 9, 1, 'TKN-20260921-484', '16236', 'S1', '2', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 14:01:52', 0, 16),
(262, 10, 1, 'TKN-20260921-484', '16236', 'S1', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 14:01:52', 0, 16),
(263, 11, 1, 'TKN-20260921-484', '16236', 'S1', '2', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 14:01:57', 0, 16),
(264, 12, 1, 'TKN-20260921-484', '16236', 'S1', 'Y', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 14:02:00', 0, 16),
(265, 7, 1, 'TKN-20260921-484', '16236', 'S2', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 14:02:07', 0, 16),
(266, 8, 1, 'TKN-20260921-484', '16236', 'S2', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 14:02:07', 0, 16),
(267, 9, 1, 'TKN-20260921-484', '16236', 'S2', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 14:02:07', 0, 16),
(268, 10, 1, 'TKN-20260921-484', '16236', 'S2', '2', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 14:02:07', 0, 16),
(269, 11, 1, 'TKN-20260921-484', '16236', 'S2', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 14:02:12', 0, 16),
(270, 12, 1, 'TKN-20260921-484', '16236', 'S2', 'Y', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:23:58', '2026-09-21 14:02:15', 0, 16),
(271, 7, 1, 'TKN-20260921-841', '16210', 'A1', '2', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:31:09', 0, 16),
(272, 8, 1, 'TKN-20260921-841', '16210', 'A1', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:31:09', 0, 16),
(273, 9, 1, 'TKN-20260921-841', '16210', 'A1', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:31:09', 0, 16),
(274, 10, 1, 'TKN-20260921-841', '16210', 'A1', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:31:09', 0, 16),
(275, 11, 1, 'TKN-20260921-841', '16210', 'A1', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:31:13', 0, 16),
(276, 12, 1, 'TKN-20260921-841', '16210', 'A1', 'Y', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:31:15', 0, 16),
(277, 7, 1, 'TKN-20260921-841', '16210', 'A2', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:31:30', 0, 16),
(278, 8, 1, 'TKN-20260921-841', '16210', 'A2', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:31:30', 0, 16),
(279, 9, 1, 'TKN-20260921-841', '16210', 'A2', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:31:30', 0, 16),
(280, 10, 1, 'TKN-20260921-841', '16210', 'A2', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:31:30', 0, 16),
(281, 11, 1, 'TKN-20260921-841', '16210', 'A2', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:31:33', 0, 16),
(282, 12, 1, 'TKN-20260921-841', '16210', 'A2', 'Y', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:31:37', 0, 16),
(283, 7, 1, 'TKN-20260921-841', '16210', 'B1', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:31:43', 0, 16),
(284, 8, 1, 'TKN-20260921-841', '16210', 'B1', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:31:43', 0, 16),
(285, 9, 1, 'TKN-20260921-841', '16210', 'B1', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:31:43', 0, 16),
(286, 10, 1, 'TKN-20260921-841', '16210', 'B1', '2', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:31:43', 0, 16),
(287, 11, 1, 'TKN-20260921-841', '16210', 'B1', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:31:46', 0, 16),
(288, 12, 1, 'TKN-20260921-841', '16210', 'B1', 'Y', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:31:49', 0, 16),
(289, 7, 1, 'TKN-20260921-841', '16210', '123456', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:30:52', 0, 16),
(290, 8, 1, 'TKN-20260921-841', '16210', '123456', '1', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:30:52', 0, 16),
(291, 9, 1, 'TKN-20260921-841', '16210', '123456', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:30:52', 0, 16),
(292, 10, 1, 'TKN-20260921-841', '16210', '123456', '3', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:30:52', 0, 16),
(293, 11, 1, 'TKN-20260921-841', '16210', '123456', '2', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:30:57', 0, 16),
(294, 12, 1, 'TKN-20260921-841', '16210', '123456', 'Y', 'Ajit Kumar', '2026-09-21', '2026-09-21 13:29:32', '2026-09-21 13:31:01', 0, 16),
(295, 7, 1, 'TKN-20260921-728', '22687', 'A1', '3', 'RAJ BIRUA', '2026-09-21', '2026-09-21 14:05:32', '2026-09-21 14:05:40', 0, 21),
(296, 8, 1, 'TKN-20260921-728', '22687', 'A1', '3', 'RAJ BIRUA', '2026-09-21', '2026-09-21 14:05:32', '2026-09-21 14:05:40', 0, 21),
(297, 9, 1, 'TKN-20260921-728', '22687', 'A1', '2', 'RAJ BIRUA', '2026-09-21', '2026-09-21 14:05:32', '2026-09-21 14:05:40', 0, 21),
(298, 10, 1, 'TKN-20260921-728', '22687', 'A1', '3', 'RAJ BIRUA', '2026-09-21', '2026-09-21 14:05:32', '2026-09-21 14:05:40', 0, 21),
(299, 11, 1, 'TKN-20260921-728', '22687', 'A1', '3', 'RAJ BIRUA', '2026-09-21', '2026-09-21 14:05:32', '2026-09-21 14:05:43', 0, 21),
(300, 12, 1, 'TKN-20260921-728', '22687', 'A1', 'Y', 'RAJ BIRUA', '2026-09-21', '2026-09-21 14:05:32', '2026-09-21 14:05:46', 0, 21),
(301, 7, 1, 'TKN-20260922-621', '16210', '227126', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(302, 8, 1, 'TKN-20260922-621', '16210', '227126', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(303, 9, 1, 'TKN-20260922-621', '16210', '227126', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(304, 10, 1, 'TKN-20260922-621', '16210', '227126', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(305, 11, 1, 'TKN-20260922-621', '16210', '227126', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(306, 12, 1, 'TKN-20260922-621', '16210', '227126', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(307, 7, 1, 'TKN-20260922-621', '16210', '182209', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(308, 8, 1, 'TKN-20260922-621', '16210', '182209', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(309, 9, 1, 'TKN-20260922-621', '16210', '182209', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(310, 10, 1, 'TKN-20260922-621', '16210', '182209', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(311, 11, 1, 'TKN-20260922-621', '16210', '182209', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(312, 12, 1, 'TKN-20260922-621', '16210', '182209', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(313, 7, 1, 'TKN-20260922-621', '16210', '226871', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(314, 8, 1, 'TKN-20260922-621', '16210', '226871', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(315, 9, 1, 'TKN-20260922-621', '16210', '226871', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(316, 10, 1, 'TKN-20260922-621', '16210', '226871', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(317, 11, 1, 'TKN-20260922-621', '16210', '226871', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(318, 12, 1, 'TKN-20260922-621', '16210', '226871', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(319, 7, 1, 'TKN-20260922-621', '16210', '225859', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(320, 8, 1, 'TKN-20260922-621', '16210', '225859', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(321, 9, 1, 'TKN-20260922-621', '16210', '225859', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(322, 10, 1, 'TKN-20260922-621', '16210', '225859', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(323, 11, 1, 'TKN-20260922-621', '16210', '225859', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(324, 12, 1, 'TKN-20260922-621', '16210', '225859', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(325, 7, 1, 'TKN-20260922-621', '16210', '225283', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(326, 8, 1, 'TKN-20260922-621', '16210', '225283', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(327, 9, 1, 'TKN-20260922-621', '16210', '225283', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(328, 10, 1, 'TKN-20260922-621', '16210', '225283', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(329, 11, 1, 'TKN-20260922-621', '16210', '225283', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(330, 12, 1, 'TKN-20260922-621', '16210', '225283', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(331, 7, 1, 'TKN-20260922-621', '16210', '226472', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(332, 8, 1, 'TKN-20260922-621', '16210', '226472', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(333, 9, 1, 'TKN-20260922-621', '16210', '226472', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(334, 10, 1, 'TKN-20260922-621', '16210', '226472', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(335, 11, 1, 'TKN-20260922-621', '16210', '226472', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(336, 12, 1, 'TKN-20260922-621', '16210', '226472', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(337, 7, 1, 'TKN-20260922-621', '16210', '191730', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(338, 8, 1, 'TKN-20260922-621', '16210', '191730', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(339, 9, 1, 'TKN-20260922-621', '16210', '191730', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(340, 10, 1, 'TKN-20260922-621', '16210', '191730', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(341, 11, 1, 'TKN-20260922-621', '16210', '191730', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(342, 12, 1, 'TKN-20260922-621', '16210', '191730', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(343, 7, 1, 'TKN-20260922-621', '16210', '193659', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(344, 8, 1, 'TKN-20260922-621', '16210', '193659', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(345, 9, 1, 'TKN-20260922-621', '16210', '193659', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(346, 10, 1, 'TKN-20260922-621', '16210', '193659', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(347, 11, 1, 'TKN-20260922-621', '16210', '193659', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(348, 12, 1, 'TKN-20260922-621', '16210', '193659', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(349, 7, 1, 'TKN-20260922-621', '16210', '197712', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(350, 8, 1, 'TKN-20260922-621', '16210', '197712', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(351, 9, 1, 'TKN-20260922-621', '16210', '197712', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(352, 10, 1, 'TKN-20260922-621', '16210', '197712', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(353, 11, 1, 'TKN-20260922-621', '16210', '197712', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(354, 12, 1, 'TKN-20260922-621', '16210', '197712', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(355, 7, 1, 'TKN-20260922-621', '16210', '197855', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(356, 8, 1, 'TKN-20260922-621', '16210', '197855', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(357, 9, 1, 'TKN-20260922-621', '16210', '197855', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(358, 10, 1, 'TKN-20260922-621', '16210', '197855', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(359, 11, 1, 'TKN-20260922-621', '16210', '197855', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(360, 12, 1, 'TKN-20260922-621', '16210', '197855', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(361, 7, 1, 'TKN-20260922-621', '16210', '212183', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(362, 8, 1, 'TKN-20260922-621', '16210', '212183', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(363, 9, 1, 'TKN-20260922-621', '16210', '212183', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(364, 10, 1, 'TKN-20260922-621', '16210', '212183', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(365, 11, 1, 'TKN-20260922-621', '16210', '212183', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(366, 12, 1, 'TKN-20260922-621', '16210', '212183', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(367, 7, 1, 'TKN-20260922-621', '16210', '243440', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(368, 8, 1, 'TKN-20260922-621', '16210', '243440', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(369, 9, 1, 'TKN-20260922-621', '16210', '243440', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(370, 10, 1, 'TKN-20260922-621', '16210', '243440', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(371, 11, 1, 'TKN-20260922-621', '16210', '243440', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(372, 12, 1, 'TKN-20260922-621', '16210', '243440', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(373, 7, 1, 'TKN-20260922-621', '16210', '182083', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21);
INSERT INTO `mcc_normal_scorecard_report` (`id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `auditor_name`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(374, 8, 1, 'TKN-20260922-621', '16210', '182083', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(375, 9, 1, 'TKN-20260922-621', '16210', '182083', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(376, 10, 1, 'TKN-20260922-621', '16210', '182083', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(377, 11, 1, 'TKN-20260922-621', '16210', '182083', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(378, 12, 1, 'TKN-20260922-621', '16210', '182083', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(379, 7, 1, 'TKN-20260922-621', '16210', '182078', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(380, 8, 1, 'TKN-20260922-621', '16210', '182078', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(381, 9, 1, 'TKN-20260922-621', '16210', '182078', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(382, 10, 1, 'TKN-20260922-621', '16210', '182078', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(383, 11, 1, 'TKN-20260922-621', '16210', '182078', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(384, 12, 1, 'TKN-20260922-621', '16210', '182078', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(385, 7, 1, 'TKN-20260922-621', '16210', '223450', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(386, 8, 1, 'TKN-20260922-621', '16210', '223450', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(387, 9, 1, 'TKN-20260922-621', '16210', '223450', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(388, 10, 1, 'TKN-20260922-621', '16210', '223450', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(389, 11, 1, 'TKN-20260922-621', '16210', '223450', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(390, 12, 1, 'TKN-20260922-621', '16210', '223450', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(391, 7, 1, 'TKN-20260922-621', '16210', '201593', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(392, 8, 1, 'TKN-20260922-621', '16210', '201593', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(393, 9, 1, 'TKN-20260922-621', '16210', '201593', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(394, 10, 1, 'TKN-20260922-621', '16210', '201593', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(395, 11, 1, 'TKN-20260922-621', '16210', '201593', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(396, 12, 1, 'TKN-20260922-621', '16210', '201593', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(397, 7, 1, 'TKN-20260922-621', '16210', '191483', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(398, 8, 1, 'TKN-20260922-621', '16210', '191483', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(399, 9, 1, 'TKN-20260922-621', '16210', '191483', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(400, 10, 1, 'TKN-20260922-621', '16210', '191483', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(401, 11, 1, 'TKN-20260922-621', '16210', '191483', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(402, 12, 1, 'TKN-20260922-621', '16210', '191483', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(403, 7, 1, 'TKN-20260922-621', '16210', '195176', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(404, 8, 1, 'TKN-20260922-621', '16210', '195176', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(405, 9, 1, 'TKN-20260922-621', '16210', '195176', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(406, 10, 1, 'TKN-20260922-621', '16210', '195176', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(407, 11, 1, 'TKN-20260922-621', '16210', '195176', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(408, 12, 1, 'TKN-20260922-621', '16210', '195176', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(409, 7, 1, 'TKN-20260922-621', '16210', '191599', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(410, 8, 1, 'TKN-20260922-621', '16210', '191599', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(411, 9, 1, 'TKN-20260922-621', '16210', '191599', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(412, 10, 1, 'TKN-20260922-621', '16210', '191599', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(413, 11, 1, 'TKN-20260922-621', '16210', '191599', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(414, 12, 1, 'TKN-20260922-621', '16210', '191599', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(415, 7, 1, 'TKN-20260922-621', '16210', '263996', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(416, 8, 1, 'TKN-20260922-621', '16210', '263996', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(417, 9, 1, 'TKN-20260922-621', '16210', '263996', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(418, 10, 1, 'TKN-20260922-621', '16210', '263996', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(419, 11, 1, 'TKN-20260922-621', '16210', '263996', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(420, 12, 1, 'TKN-20260922-621', '16210', '263996', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(421, 7, 1, 'TKN-20260922-621', '16210', '191077', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(422, 8, 1, 'TKN-20260922-621', '16210', '191077', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(423, 9, 1, 'TKN-20260922-621', '16210', '191077', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(424, 10, 1, 'TKN-20260922-621', '16210', '191077', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(425, 11, 1, 'TKN-20260922-621', '16210', '191077', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(426, 12, 1, 'TKN-20260922-621', '16210', '191077', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:15:08', '2026-09-22 08:15:08', 0, 21),
(427, 7, 1, 'TKN-20260922-876', '16236', '225388', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(428, 8, 1, 'TKN-20260922-876', '16236', '225388', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(429, 9, 1, 'TKN-20260922-876', '16236', '225388', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(430, 10, 1, 'TKN-20260922-876', '16236', '225388', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(431, 11, 1, 'TKN-20260922-876', '16236', '225388', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(432, 12, 1, 'TKN-20260922-876', '16236', '225388', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(433, 7, 1, 'TKN-20260922-876', '16236', '225861', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(434, 8, 1, 'TKN-20260922-876', '16236', '225861', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(435, 9, 1, 'TKN-20260922-876', '16236', '225861', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(436, 10, 1, 'TKN-20260922-876', '16236', '225861', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(437, 11, 1, 'TKN-20260922-876', '16236', '225861', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(438, 12, 1, 'TKN-20260922-876', '16236', '225861', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(439, 7, 1, 'TKN-20260922-876', '16236', '245887', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(440, 8, 1, 'TKN-20260922-876', '16236', '245887', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(441, 9, 1, 'TKN-20260922-876', '16236', '245887', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(442, 10, 1, 'TKN-20260922-876', '16236', '245887', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(443, 11, 1, 'TKN-20260922-876', '16236', '245887', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(444, 12, 1, 'TKN-20260922-876', '16236', '245887', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(445, 7, 1, 'TKN-20260922-876', '16236', '251521', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(446, 8, 1, 'TKN-20260922-876', '16236', '251521', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(447, 9, 1, 'TKN-20260922-876', '16236', '251521', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(448, 10, 1, 'TKN-20260922-876', '16236', '251521', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(449, 11, 1, 'TKN-20260922-876', '16236', '251521', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(450, 12, 1, 'TKN-20260922-876', '16236', '251521', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(451, 7, 1, 'TKN-20260922-876', '16236', '201671', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(452, 8, 1, 'TKN-20260922-876', '16236', '201671', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(453, 9, 1, 'TKN-20260922-876', '16236', '201671', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(454, 10, 1, 'TKN-20260922-876', '16236', '201671', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(455, 11, 1, 'TKN-20260922-876', '16236', '201671', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(456, 12, 1, 'TKN-20260922-876', '16236', '201671', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(457, 7, 1, 'TKN-20260922-876', '16236', '212954', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(458, 8, 1, 'TKN-20260922-876', '16236', '212954', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(459, 9, 1, 'TKN-20260922-876', '16236', '212954', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(460, 10, 1, 'TKN-20260922-876', '16236', '212954', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(461, 11, 1, 'TKN-20260922-876', '16236', '212954', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(462, 12, 1, 'TKN-20260922-876', '16236', '212954', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(463, 7, 1, 'TKN-20260922-876', '16236', '182601', '3', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:23', 0, 21),
(464, 8, 1, 'TKN-20260922-876', '16236', '182601', '3', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:23', 0, 21),
(465, 9, 1, 'TKN-20260922-876', '16236', '182601', '3', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:23', 0, 21),
(466, 10, 1, 'TKN-20260922-876', '16236', '182601', '3', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:23', 0, 21),
(467, 11, 1, 'TKN-20260922-876', '16236', '182601', '2', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:31:01', 0, 21),
(468, 12, 1, 'TKN-20260922-876', '16236', '182601', 'Y', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:31:04', 0, 21),
(469, 7, 1, 'TKN-20260922-876', '16236', '251574', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(470, 8, 1, 'TKN-20260922-876', '16236', '251574', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(471, 9, 1, 'TKN-20260922-876', '16236', '251574', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(472, 10, 1, 'TKN-20260922-876', '16236', '251574', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(473, 11, 1, 'TKN-20260922-876', '16236', '251574', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(474, 12, 1, 'TKN-20260922-876', '16236', '251574', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(475, 7, 1, 'TKN-20260922-876', '16236', '216697', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(476, 8, 1, 'TKN-20260922-876', '16236', '216697', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(477, 9, 1, 'TKN-20260922-876', '16236', '216697', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(478, 10, 1, 'TKN-20260922-876', '16236', '216697', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(479, 11, 1, 'TKN-20260922-876', '16236', '216697', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(480, 12, 1, 'TKN-20260922-876', '16236', '216697', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(481, 7, 1, 'TKN-20260922-876', '16236', '191746', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(482, 8, 1, 'TKN-20260922-876', '16236', '191746', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(483, 9, 1, 'TKN-20260922-876', '16236', '191746', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(484, 10, 1, 'TKN-20260922-876', '16236', '191746', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(485, 11, 1, 'TKN-20260922-876', '16236', '191746', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(486, 12, 1, 'TKN-20260922-876', '16236', '191746', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(487, 7, 1, 'TKN-20260922-876', '16236', '255982', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(488, 8, 1, 'TKN-20260922-876', '16236', '255982', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(489, 9, 1, 'TKN-20260922-876', '16236', '255982', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(490, 10, 1, 'TKN-20260922-876', '16236', '255982', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(491, 11, 1, 'TKN-20260922-876', '16236', '255982', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(492, 12, 1, 'TKN-20260922-876', '16236', '255982', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(493, 7, 1, 'TKN-20260922-876', '16236', '195191', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(494, 8, 1, 'TKN-20260922-876', '16236', '195191', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(495, 9, 1, 'TKN-20260922-876', '16236', '195191', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(496, 10, 1, 'TKN-20260922-876', '16236', '195191', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(497, 11, 1, 'TKN-20260922-876', '16236', '195191', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(498, 12, 1, 'TKN-20260922-876', '16236', '195191', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(499, 7, 1, 'TKN-20260922-876', '16236', '191757', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(500, 8, 1, 'TKN-20260922-876', '16236', '191757', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(501, 9, 1, 'TKN-20260922-876', '16236', '191757', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(502, 10, 1, 'TKN-20260922-876', '16236', '191757', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(503, 11, 1, 'TKN-20260922-876', '16236', '191757', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(504, 12, 1, 'TKN-20260922-876', '16236', '191757', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(505, 7, 1, 'TKN-20260922-876', '16236', '201587', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(506, 8, 1, 'TKN-20260922-876', '16236', '201587', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(507, 9, 1, 'TKN-20260922-876', '16236', '201587', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(508, 10, 1, 'TKN-20260922-876', '16236', '201587', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(509, 11, 1, 'TKN-20260922-876', '16236', '201587', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(510, 12, 1, 'TKN-20260922-876', '16236', '201587', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(511, 7, 1, 'TKN-20260922-876', '16236', '197705', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(512, 8, 1, 'TKN-20260922-876', '16236', '197705', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(513, 9, 1, 'TKN-20260922-876', '16236', '197705', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(514, 10, 1, 'TKN-20260922-876', '16236', '197705', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(515, 11, 1, 'TKN-20260922-876', '16236', '197705', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(516, 12, 1, 'TKN-20260922-876', '16236', '197705', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(517, 7, 1, 'TKN-20260922-876', '16236', '193028', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(518, 8, 1, 'TKN-20260922-876', '16236', '193028', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(519, 9, 1, 'TKN-20260922-876', '16236', '193028', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(520, 10, 1, 'TKN-20260922-876', '16236', '193028', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(521, 11, 1, 'TKN-20260922-876', '16236', '193028', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(522, 12, 1, 'TKN-20260922-876', '16236', '193028', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(523, 7, 1, 'TKN-20260922-876', '16236', '193241', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(524, 8, 1, 'TKN-20260922-876', '16236', '193241', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(525, 9, 1, 'TKN-20260922-876', '16236', '193241', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(526, 10, 1, 'TKN-20260922-876', '16236', '193241', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(527, 11, 1, 'TKN-20260922-876', '16236', '193241', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(528, 12, 1, 'TKN-20260922-876', '16236', '193241', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(529, 7, 1, 'TKN-20260922-876', '16236', '191216', '3', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:32:04', 0, 21),
(530, 8, 1, 'TKN-20260922-876', '16236', '191216', '2', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:32:04', 0, 21),
(531, 9, 1, 'TKN-20260922-876', '16236', '191216', '3', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:32:04', 0, 21),
(532, 10, 1, 'TKN-20260922-876', '16236', '191216', '2', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:32:04', 0, 21),
(533, 11, 1, 'TKN-20260922-876', '16236', '191216', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21),
(534, 12, 1, 'TKN-20260922-876', '16236', '191216', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 10:30:11', '2026-09-22 10:30:11', 0, 21);

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
  `after_remark` text DEFAULT NULL,
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_photo_report`
--

INSERT INTO `mcc_photo_report` (`id`, `station_id`, `report_date`, `before_photo`, `after_photo`, `created_at`, `updated_at`, `area`, `before_remark`, `after_remark`, `isApproved`, `audit_by`) VALUES
(1, 1, '2026-07-09', 'before_sample.png', 'after_sample.png', '2026-07-10 11:24:52', '2026-07-10 11:24:52', 'Platform 1 (AC Section)', 'Accumulated dust and dry garbage on the floor.', 'Thoroughly scrubbed with power disc Mopper. Clean and shiny.', 0, NULL),
(2, 1, '2026-07-10', 'before_sample.png', 'after_sample.png', '2026-07-10 11:24:52', '2026-07-10 11:24:52', 'Concourse Area', 'Stains and litter near seating space.', 'High-pressure washing and disinfection done. Spotless.', 0, NULL);

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
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_prt_chemical_report`
--

INSERT INTO `mcc_prt_chemical_report` (`id`, `parameter_id`, `coach_no`, `qty_used`, `auditor_name`, `station_id`, `token_id`, `train_no`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(1, 1, 'C1', 5.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:21', 0, NULL),
(2, 2, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:21', 0, NULL),
(3, 3, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:21', 0, NULL),
(4, 4, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:21', 0, NULL),
(5, 5, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:21', 0, NULL),
(6, 6, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:21', 0, NULL),
(7, 7, 'C1', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:21', 0, NULL),
(8, 1, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:24', 0, NULL),
(9, 2, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:24', 0, NULL),
(10, 3, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:24', 0, NULL),
(11, 4, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:24', 0, NULL),
(12, 5, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:24', 0, NULL),
(13, 6, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:24', 0, NULL),
(14, 7, 'C2', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:24', 0, NULL),
(15, 1, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:30', 0, NULL),
(16, 2, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:30', 0, NULL),
(17, 3, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:30', 0, NULL),
(18, 4, 'C3', 7.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:30', 0, NULL),
(19, 5, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:30', 0, NULL),
(20, 6, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:30', 0, NULL),
(21, 7, 'C3', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:30', 0, NULL),
(22, 1, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:36', 0, NULL),
(23, 2, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:36', 0, NULL),
(24, 3, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:36', 0, NULL),
(25, 4, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:36', 0, NULL),
(26, 5, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:36', 0, NULL),
(27, 6, 'C4', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:36', 0, NULL),
(28, 7, 'C4', 4.00, 'Bheem Chand', 1, 'TKN-PRT-20260907-037', '12345', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:36', 0, NULL),
(29, 1, '01', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:27', 0, NULL),
(30, 2, '01', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:27', 0, NULL),
(31, 3, '01', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:27', 0, NULL),
(32, 4, '01', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:27', 0, NULL),
(33, 5, '01', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:27', 0, NULL),
(34, 6, '01', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:27', 0, NULL),
(35, 7, '01', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:27', 0, NULL),
(36, 1, '02', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:31', 0, NULL),
(37, 2, '02', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:31', 0, NULL),
(38, 3, '02', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:31', 0, NULL),
(39, 4, '02', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:31', 0, NULL),
(40, 5, '02', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:31', 0, NULL),
(41, 6, '02', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:31', 0, NULL),
(42, 7, '02', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:31', 0, NULL),
(43, 1, '03', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:34', 0, NULL),
(44, 2, '03', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:34', 0, NULL),
(45, 3, '03', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:34', 0, NULL),
(46, 4, '03', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:34', 0, NULL),
(47, 5, '03', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:34', 0, NULL),
(48, 6, '03', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:34', 0, NULL),
(49, 7, '03', 10.00, 'Bheem Chand', 1, 'TKN-PRT-20260908-861', '16232', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:29:34', 0, NULL),
(50, 1, '01', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:40', 0, NULL),
(51, 2, '01', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:41', 0, NULL),
(52, 3, '01', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:41', 0, NULL),
(53, 4, '01', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:41', 0, NULL),
(54, 5, '01', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:41', 0, NULL),
(55, 6, '01', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:41', 0, NULL),
(56, 7, '01', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:41', 0, NULL),
(57, 1, '02', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:43', 0, NULL),
(58, 2, '02', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:43', 0, NULL),
(59, 3, '02', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:43', 0, NULL),
(60, 4, '02', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:43', 0, NULL),
(61, 5, '02', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:43', 0, NULL),
(62, 6, '02', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:43', 0, NULL),
(63, 7, '02', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:43', 0, NULL),
(64, 1, '03', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:47', 0, NULL),
(65, 2, '03', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:47', 0, NULL),
(66, 3, '03', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:47', 0, NULL),
(67, 4, '03', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:47', 0, NULL),
(68, 5, '03', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:47', 0, NULL),
(69, 6, '03', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:47', 0, NULL),
(70, 7, '03', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:47', 0, NULL),
(71, 1, '04', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:58', 0, NULL),
(72, 2, '04', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:58', 0, NULL),
(73, 3, '04', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:58', 0, NULL),
(74, 4, '04', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:58', 0, NULL),
(75, 5, '04', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:58', 0, NULL),
(76, 6, '04', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:58', 0, NULL),
(77, 7, '04', 10.00, 'Amit kumar', 1, 'TKN-PRT-20260908-808', '12008', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:29:58', 0, NULL),
(78, 1, '01', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:11', 0, NULL),
(79, 2, '01', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:11', 0, NULL),
(80, 3, '01', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:11', 0, NULL),
(81, 4, '01', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:11', 0, NULL),
(82, 5, '01', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:11', 0, NULL),
(83, 6, '01', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:11', 0, NULL),
(84, 7, '01', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:11', 0, NULL),
(85, 1, '02', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:14', 0, NULL),
(86, 2, '02', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:14', 0, NULL),
(87, 3, '02', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:14', 0, NULL),
(88, 4, '02', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:14', 0, NULL),
(89, 5, '02', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:14', 0, NULL),
(90, 6, '02', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:14', 0, NULL),
(91, 7, '02', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:14', 0, NULL),
(92, 1, '03', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:18', 0, NULL),
(93, 2, '03', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:18', 0, NULL),
(94, 3, '03', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:18', 0, NULL),
(95, 4, '03', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:18', 0, NULL),
(96, 5, '03', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:18', 0, NULL),
(97, 6, '03', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:18', 0, NULL),
(98, 7, '03', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:18', 0, NULL),
(99, 1, '04', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:22', 0, NULL),
(100, 2, '04', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:22', 0, NULL),
(101, 3, '04', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:22', 0, NULL),
(102, 4, '04', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:22', 0, NULL),
(103, 5, '04', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:22', 0, NULL),
(104, 6, '04', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:22', 0, NULL),
(105, 7, '04', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:22', 0, NULL),
(106, 1, '05', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:26', 0, NULL),
(107, 2, '05', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:26', 0, NULL),
(108, 3, '05', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:26', 0, NULL),
(109, 4, '05', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:26', 0, NULL),
(110, 5, '05', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:26', 0, NULL),
(111, 6, '05', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:26', 0, NULL),
(112, 7, '05', 10.00, 'Siddik', 1, 'TKN-PRT-20260908-132', '17301', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:30:26', 0, NULL),
(113, 1, '01', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:06', 0, NULL),
(114, 2, '01', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:06', 0, NULL),
(115, 3, '01', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:06', 0, NULL),
(116, 4, '01', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:06', 0, NULL),
(117, 5, '01', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:06', 0, NULL),
(118, 6, '01', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:06', 0, NULL),
(119, 7, '01', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:06', 0, NULL),
(120, 1, '02', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:09', 0, NULL),
(121, 2, '02', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:09', 0, NULL),
(122, 3, '02', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:09', 0, NULL),
(123, 4, '02', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:09', 0, NULL),
(124, 5, '02', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:09', 0, NULL),
(125, 6, '02', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:09', 0, NULL),
(126, 7, '02', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:09', 0, NULL),
(127, 1, '03', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:12', 0, NULL),
(128, 2, '03', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:12', 0, NULL),
(129, 3, '03', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:12', 0, NULL),
(130, 4, '03', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:12', 0, NULL),
(131, 5, '03', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:12', 0, NULL),
(132, 6, '03', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:12', 0, NULL),
(133, 7, '03', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:12', 0, NULL),
(134, 1, '04', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:15', 0, NULL),
(135, 2, '04', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:15', 0, NULL),
(136, 3, '04', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:15', 0, NULL),
(137, 4, '04', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:15', 0, NULL),
(138, 5, '04', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:15', 0, NULL),
(139, 6, '04', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:15', 0, NULL),
(140, 7, '04', 10.00, 'Abbuzada', 1, 'TKN-PRT-20260908-873', '16315', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:33:15', 0, NULL),
(141, 1, '01', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:33', 0, NULL),
(142, 2, '01', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:33', 0, NULL),
(143, 3, '01', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:33', 0, NULL),
(144, 4, '01', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:33', 0, NULL),
(145, 5, '01', 25.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:33', 0, NULL),
(146, 6, '01', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:33', 0, NULL),
(147, 7, '01', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:33', 0, NULL),
(148, 1, '02', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:40', 0, NULL),
(149, 2, '02', 15.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:40', 0, NULL),
(150, 3, '02', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:40', 0, NULL),
(151, 4, '02', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:40', 0, NULL),
(152, 5, '02', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:40', 0, NULL),
(153, 6, '02', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:40', 0, NULL),
(154, 7, '02', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:40', 0, NULL),
(155, 1, '03', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:43', 0, NULL),
(156, 2, '03', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:43', 0, NULL),
(157, 3, '03', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:43', 0, NULL),
(158, 4, '03', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:43', 0, NULL),
(159, 5, '03', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:43', 0, NULL),
(160, 6, '03', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:43', 0, NULL),
(161, 7, '03', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:43', 0, NULL),
(162, 1, '04', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:47', 0, NULL),
(163, 2, '04', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:47', 0, NULL),
(164, 3, '04', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:47', 0, NULL),
(165, 4, '04', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:47', 0, NULL),
(166, 5, '04', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:47', 0, NULL),
(167, 6, '04', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:47', 0, NULL),
(168, 7, '04', 10.00, 'S kumar', 1, 'TKN-PRT-20260908-698', '16022', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:47', 0, NULL),
(169, 1, '01', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:34', 0, NULL),
(170, 2, '01', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:34', 0, NULL),
(171, 3, '01', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:34', 0, NULL),
(172, 4, '01', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:34', 0, NULL),
(173, 5, '01', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:34', 0, NULL),
(174, 6, '01', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:34', 0, NULL),
(175, 7, '01', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:34', 0, NULL),
(176, 1, '02', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:37', 0, NULL),
(177, 2, '02', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:37', 0, NULL),
(178, 3, '02', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:37', 0, NULL),
(179, 4, '02', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:37', 0, NULL),
(180, 5, '02', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:37', 0, NULL),
(181, 6, '02', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:37', 0, NULL),
(182, 7, '02', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:37', 0, NULL),
(183, 1, '03', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:41', 0, NULL),
(184, 2, '03', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:41', 0, NULL),
(185, 3, '03', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:41', 0, NULL),
(186, 4, '03', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:41', 0, NULL),
(187, 5, '03', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:41', 0, NULL),
(188, 6, '03', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:41', 0, NULL),
(189, 7, '03', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:41', 0, NULL),
(190, 1, '04', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:50', 0, NULL),
(191, 2, '04', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:50', 0, NULL),
(192, 3, '04', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:50', 0, NULL),
(193, 4, '04', 35.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:50', 0, NULL),
(194, 5, '04', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:50', 0, NULL),
(195, 6, '04', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:50', 0, NULL),
(196, 7, '04', 10.00, 'Mahesh', 1, 'TKN-PRT-20260909-298', '16232', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:48:50', 0, NULL),
(197, 1, '01', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:00', 0, NULL),
(198, 2, '01', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:00', 0, NULL),
(199, 3, '01', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:00', 0, NULL),
(200, 4, '01', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:00', 0, NULL),
(201, 5, '01', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:00', 0, NULL),
(202, 6, '01', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:00', 0, NULL),
(203, 7, '01', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:00', 0, NULL),
(204, 1, '02', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:03', 0, NULL),
(205, 2, '02', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:03', 0, NULL),
(206, 3, '02', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:03', 0, NULL),
(207, 4, '02', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:03', 0, NULL),
(208, 5, '02', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:03', 0, NULL),
(209, 6, '02', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:03', 0, NULL),
(210, 7, '02', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:03', 0, NULL),
(211, 1, '03', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:06', 0, NULL),
(212, 2, '03', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:06', 0, NULL),
(213, 3, '03', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:06', 0, NULL),
(214, 4, '03', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:06', 0, NULL),
(215, 5, '03', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:06', 0, NULL),
(216, 6, '03', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:06', 0, NULL),
(217, 7, '03', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:06', 0, NULL),
(218, 1, '04', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:10', 0, NULL),
(219, 2, '04', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:10', 0, NULL),
(220, 3, '04', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:10', 0, NULL),
(221, 4, '04', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:10', 0, NULL),
(222, 5, '04', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:10', 0, NULL),
(223, 6, '04', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:10', 0, NULL),
(224, 7, '04', 10.00, 'Umesh', 1, 'TKN-PRT-20260909-755', '16595', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:48:10', 0, NULL),
(225, 1, '01', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:01', 0, NULL),
(226, 2, '01', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:01', 0, NULL),
(227, 3, '01', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:01', 0, NULL),
(228, 4, '01', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:01', 0, NULL),
(229, 5, '01', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:01', 0, NULL),
(230, 6, '01', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:01', 0, NULL),
(231, 7, '01', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:01', 0, NULL),
(232, 1, '02', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:16', 0, NULL),
(233, 2, '02', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:16', 0, NULL),
(234, 3, '02', 20.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:16', 0, NULL),
(235, 4, '02', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:16', 0, NULL),
(236, 5, '02', 35.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:16', 0, NULL),
(237, 6, '02', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:16', 0, NULL),
(238, 7, '02', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:16', 0, NULL),
(239, 1, '03', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:24', 0, NULL),
(240, 2, '03', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:24', 0, NULL),
(241, 3, '03', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:24', 0, NULL),
(242, 4, '03', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:24', 0, NULL),
(243, 5, '03', 15.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:24', 0, NULL),
(244, 6, '03', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:24', 0, NULL),
(245, 7, '03', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:24', 0, NULL),
(246, 1, '04', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:27', 0, NULL),
(247, 2, '04', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:27', 0, NULL),
(248, 3, '04', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:27', 0, NULL),
(249, 4, '04', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:27', 0, NULL),
(250, 5, '04', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:27', 0, NULL),
(251, 6, '04', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:27', 0, NULL),
(252, 7, '04', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:27', 0, NULL),
(253, 1, '05', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:31', 0, NULL),
(254, 2, '05', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:31', 0, NULL),
(255, 3, '05', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:31', 0, NULL),
(256, 4, '05', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:31', 0, NULL),
(257, 5, '05', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:31', 0, NULL),
(258, 6, '05', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:31', 0, NULL),
(259, 7, '05', 10.00, 'Kalyan', 1, 'TKN-PRT-20260909-754', '16592', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:49:31', 0, NULL),
(260, 1, '01', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:16', 0, NULL),
(261, 2, '01', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:16', 0, NULL),
(262, 3, '01', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:16', 0, NULL),
(263, 4, '01', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:16', 0, NULL),
(264, 5, '01', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:16', 0, NULL),
(265, 6, '01', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:16', 0, NULL),
(266, 7, '01', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:16', 0, NULL),
(267, 1, '02', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:20', 0, NULL),
(268, 2, '02', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:20', 0, NULL),
(269, 3, '02', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:20', 0, NULL),
(270, 4, '02', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:20', 0, NULL),
(271, 5, '02', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:20', 0, NULL),
(272, 6, '02', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:20', 0, NULL),
(273, 7, '02', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:20', 0, NULL),
(274, 1, '03', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:23', 0, NULL),
(275, 2, '03', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:23', 0, NULL),
(276, 3, '03', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:23', 0, NULL),
(277, 4, '03', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:23', 0, NULL),
(278, 5, '03', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:23', 0, NULL),
(279, 6, '03', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:23', 0, NULL),
(280, 7, '03', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:23', 0, NULL),
(281, 1, '04', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:27', 0, NULL),
(282, 2, '04', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:27', 0, NULL),
(283, 3, '04', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:27', 0, NULL),
(284, 4, '04', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:27', 0, NULL),
(285, 5, '04', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:27', 0, NULL),
(286, 6, '04', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:27', 0, NULL),
(287, 7, '04', 10.00, 'Somaselharn', 1, 'TKN-PRT-20260909-309', '12007', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:48:27', 0, NULL),
(288, 1, 'C1', NULL, 'Bheem Chand', 1, 'TKN-PRT-20260912-131', '12345', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:21', 0, NULL),
(289, 2, 'C1', NULL, 'Bheem Chand', 1, 'TKN-PRT-20260912-131', '12345', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:21', 0, NULL),
(290, 3, 'C1', NULL, 'Bheem Chand', 1, 'TKN-PRT-20260912-131', '12345', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:21', 0, NULL),
(291, 4, 'C1', NULL, 'Bheem Chand', 1, 'TKN-PRT-20260912-131', '12345', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:21', 0, NULL),
(292, 5, 'C1', NULL, 'Bheem Chand', 1, 'TKN-PRT-20260912-131', '12345', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:21', 0, NULL),
(293, 6, 'C1', NULL, 'Bheem Chand', 1, 'TKN-PRT-20260912-131', '12345', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:21', 0, NULL),
(294, 7, 'C1', NULL, 'Bheem Chand', 1, 'TKN-PRT-20260912-131', '12345', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:21', 0, NULL),
(295, 15, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-PRT-20260912-918', '123456', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:04:04', 0, NULL),
(296, 16, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-PRT-20260912-918', '123456', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:04:04', 0, NULL),
(297, 17, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-PRT-20260912-918', '123456', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:04:04', 0, NULL),
(298, 18, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-PRT-20260912-918', '123456', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:04:04', 0, NULL),
(299, 19, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-PRT-20260912-918', '123456', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:04:04', 0, NULL),
(300, 20, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-PRT-20260912-918', '123456', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:04:04', 0, NULL),
(301, 21, 'C1', 10.00, 'SCL AUDITOR', 4, 'TKN-PRT-20260912-918', '123456', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:04:04', 0, NULL),
(302, 1, '227126', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(303, 2, '227126', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(304, 3, '227126', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(305, 4, '227126', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(306, 5, '227126', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(307, 6, '227126', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(308, 7, '227126', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(309, 1, '182209', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(310, 2, '182209', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(311, 3, '182209', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(312, 4, '182209', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(313, 5, '182209', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(314, 6, '182209', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(315, 7, '182209', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(316, 1, '226871', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(317, 2, '226871', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(318, 3, '226871', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(319, 4, '226871', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(320, 5, '226871', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(321, 6, '226871', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(322, 7, '226871', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(323, 1, '225859', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(324, 2, '225859', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(325, 3, '225859', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(326, 4, '225859', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(327, 5, '225859', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(328, 6, '225859', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(329, 7, '225859', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(330, 1, '225283', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(331, 2, '225283', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(332, 3, '225283', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(333, 4, '225283', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(334, 5, '225283', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(335, 6, '225283', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(336, 7, '225283', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(337, 1, '226472', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(338, 2, '226472', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(339, 3, '226472', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(340, 4, '226472', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(341, 5, '226472', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(342, 6, '226472', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(343, 7, '226472', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(344, 1, '191730', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(345, 2, '191730', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(346, 3, '191730', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(347, 4, '191730', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(348, 5, '191730', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(349, 6, '191730', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(350, 7, '191730', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(351, 1, '193659', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(352, 2, '193659', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(353, 3, '193659', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(354, 4, '193659', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(355, 5, '193659', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(356, 6, '193659', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(357, 7, '193659', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(358, 1, '197712', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(359, 2, '197712', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(360, 3, '197712', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21);
INSERT INTO `mcc_prt_chemical_report` (`id`, `parameter_id`, `coach_no`, `qty_used`, `auditor_name`, `station_id`, `token_id`, `train_no`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(361, 4, '197712', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(362, 5, '197712', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(363, 6, '197712', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(364, 7, '197712', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(365, 1, '197855', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(366, 2, '197855', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(367, 3, '197855', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(368, 4, '197855', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(369, 5, '197855', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(370, 6, '197855', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(371, 7, '197855', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(372, 1, '212183', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(373, 2, '212183', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(374, 3, '212183', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(375, 4, '212183', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(376, 5, '212183', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(377, 6, '212183', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(378, 7, '212183', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(379, 1, '243440', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(380, 2, '243440', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(381, 3, '243440', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(382, 4, '243440', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(383, 5, '243440', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(384, 6, '243440', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(385, 7, '243440', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(386, 1, '182083', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(387, 2, '182083', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(388, 3, '182083', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(389, 4, '182083', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(390, 5, '182083', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(391, 6, '182083', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(392, 7, '182083', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(393, 1, '182078', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(394, 2, '182078', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(395, 3, '182078', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(396, 4, '182078', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(397, 5, '182078', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(398, 6, '182078', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(399, 7, '182078', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(400, 1, '223450', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(401, 2, '223450', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(402, 3, '223450', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(403, 4, '223450', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(404, 5, '223450', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(405, 6, '223450', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(406, 7, '223450', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(407, 1, '201593', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(408, 2, '201593', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(409, 3, '201593', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(410, 4, '201593', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(411, 5, '201593', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(412, 6, '201593', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(413, 7, '201593', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(414, 1, '191483', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(415, 2, '191483', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(416, 3, '191483', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(417, 4, '191483', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(418, 5, '191483', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(419, 6, '191483', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(420, 7, '191483', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(421, 1, '195176', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(422, 2, '195176', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(423, 3, '195176', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(424, 4, '195176', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(425, 5, '195176', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(426, 6, '195176', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(427, 7, '195176', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(428, 1, '191599', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(429, 2, '191599', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(430, 3, '191599', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(431, 4, '191599', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(432, 5, '191599', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(433, 6, '191599', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(434, 7, '191599', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(435, 1, '263996', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(436, 2, '263996', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(437, 3, '263996', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(438, 4, '263996', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(439, 5, '263996', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(440, 6, '263996', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(441, 7, '263996', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(442, 1, '191077', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(443, 2, '191077', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(444, 3, '191077', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(445, 4, '191077', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(446, 5, '191077', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(447, 6, '191077', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(448, 7, '191077', NULL, 'RAJ BIRUA', 1, 'TKN-PRT-20260922-263', '16210', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21);

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
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_prt_machine_report`
--

INSERT INTO `mcc_prt_machine_report` (`id`, `parameter_id`, `shift_id`, `used_status`, `token_id`, `auditor_name`, `station_id`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(1, 16, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44', 0, NULL),
(2, 17, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44', 0, NULL),
(3, 18, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44', 0, NULL),
(4, 19, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44', 0, NULL),
(5, 20, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44', 0, NULL),
(6, 21, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44', 0, NULL),
(7, 22, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44', 0, NULL),
(8, 23, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44', 0, NULL),
(9, 24, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44', 0, NULL),
(10, 25, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44', 0, NULL),
(11, 26, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44', 0, NULL),
(12, 27, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44', 0, NULL),
(13, 28, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44', 0, NULL),
(14, 29, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44', 0, NULL),
(15, 30, 4, 'Y', 'TKN-PRT-MCH-20260907-4-2124', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:44', '2026-09-07 14:19:44', 0, NULL),
(16, 16, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51', 0, NULL),
(17, 17, 5, 'N', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51', 0, NULL),
(18, 18, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51', 0, NULL),
(19, 19, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51', 0, NULL),
(20, 20, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51', 0, NULL),
(21, 21, 5, 'N', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51', 0, NULL),
(22, 22, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51', 0, NULL),
(23, 23, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51', 0, NULL),
(24, 24, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51', 0, NULL),
(25, 25, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51', 0, NULL),
(26, 26, 5, 'N', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51', 0, NULL),
(27, 27, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51', 0, NULL),
(28, 28, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51', 0, NULL),
(29, 29, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51', 0, NULL),
(30, 30, 5, 'Y', 'TKN-PRT-MCH-20260907-5-5633', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:19:51', '2026-09-07 14:19:51', 0, NULL),
(31, 16, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01', 0, NULL),
(32, 17, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01', 0, NULL),
(33, 18, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01', 0, NULL),
(34, 19, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01', 0, NULL),
(35, 20, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01', 0, NULL),
(36, 21, 6, 'N', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01', 0, NULL),
(37, 22, 6, 'N', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01', 0, NULL),
(38, 23, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01', 0, NULL),
(39, 24, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01', 0, NULL),
(40, 25, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01', 0, NULL),
(41, 26, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01', 0, NULL),
(42, 27, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01', 0, NULL),
(43, 28, 6, 'N', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01', 0, NULL),
(44, 29, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01', 0, NULL),
(45, 30, 6, 'Y', 'TKN-PRT-MCH-20260907-6-8153', 'Bheem Chand', 1, '2026-09-07', '2026-09-07 14:20:01', '2026-09-07 14:20:01', 0, NULL),
(46, 16, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57', 0, NULL),
(47, 17, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57', 0, NULL),
(48, 18, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57', 0, NULL),
(49, 19, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57', 0, NULL),
(50, 20, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57', 0, NULL),
(51, 21, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57', 0, NULL),
(52, 22, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57', 0, NULL),
(53, 23, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57', 0, NULL),
(54, 24, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57', 0, NULL),
(55, 25, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57', 0, NULL),
(56, 26, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57', 0, NULL),
(57, 27, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57', 0, NULL),
(58, 28, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57', 0, NULL),
(59, 29, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57', 0, NULL),
(60, 30, 4, 'Y', 'TKN-PRT-MCH-20260908-4-6868', 'Bheem Chand', 1, '2026-09-08', '2026-09-08 13:30:57', '2026-09-08 13:30:57', 0, NULL),
(61, 16, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09', 0, NULL),
(62, 17, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09', 0, NULL),
(63, 18, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09', 0, NULL),
(64, 19, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09', 0, NULL),
(65, 20, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09', 0, NULL),
(66, 21, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09', 0, NULL),
(67, 22, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09', 0, NULL),
(68, 23, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09', 0, NULL),
(69, 24, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09', 0, NULL),
(70, 25, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09', 0, NULL),
(71, 26, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09', 0, NULL),
(72, 27, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09', 0, NULL),
(73, 28, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09', 0, NULL),
(74, 29, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09', 0, NULL),
(75, 30, 5, 'Y', 'TKN-PRT-MCH-20260908-5-5319', 'Amit Kumar', 1, '2026-09-08', '2026-09-08 13:31:09', '2026-09-08 13:31:09', 0, NULL),
(76, 16, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22', 0, NULL),
(77, 17, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22', 0, NULL),
(78, 18, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22', 0, NULL),
(79, 19, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22', 0, NULL),
(80, 20, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22', 0, NULL),
(81, 21, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22', 0, NULL),
(82, 22, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22', 0, NULL),
(83, 23, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22', 0, NULL),
(84, 24, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22', 0, NULL),
(85, 25, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22', 0, NULL),
(86, 26, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22', 0, NULL),
(87, 27, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22', 0, NULL),
(88, 28, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22', 0, NULL),
(89, 29, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22', 0, NULL),
(90, 30, 6, 'Y', 'TKN-PRT-MCH-20260908-6-8951', 'Mf Sarif', 1, '2026-09-08', '2026-09-08 13:31:22', '2026-09-08 13:31:22', 0, NULL),
(91, 16, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51', 0, NULL),
(92, 17, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51', 0, NULL),
(93, 18, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51', 0, NULL),
(94, 19, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51', 0, NULL),
(95, 20, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51', 0, NULL),
(96, 21, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51', 0, NULL),
(97, 22, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51', 0, NULL),
(98, 23, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51', 0, NULL),
(99, 24, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51', 0, NULL),
(100, 25, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51', 0, NULL),
(101, 26, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51', 0, NULL),
(102, 27, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51', 0, NULL),
(103, 28, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51', 0, NULL),
(104, 29, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51', 0, NULL),
(105, 30, 4, 'Y', 'TKN-PRT-MCH-20260909-4-6964', 'Umesh', 1, '2026-09-09', '2026-09-09 07:49:51', '2026-09-09 07:49:51', 0, NULL),
(106, 16, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03', 0, NULL),
(107, 17, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03', 0, NULL),
(108, 18, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03', 0, NULL),
(109, 19, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03', 0, NULL),
(110, 20, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03', 0, NULL),
(111, 21, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03', 0, NULL),
(112, 22, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03', 0, NULL),
(113, 23, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03', 0, NULL),
(114, 24, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03', 0, NULL),
(115, 25, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03', 0, NULL),
(116, 26, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03', 0, NULL),
(117, 27, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03', 0, NULL),
(118, 28, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03', 0, NULL),
(119, 29, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03', 0, NULL),
(120, 30, 5, 'Y', 'TKN-PRT-MCH-20260909-5-5128', 'Kalyan', 1, '2026-09-09', '2026-09-09 07:50:03', '2026-09-09 07:50:03', 0, NULL),
(121, 16, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15', 0, NULL),
(122, 17, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15', 0, NULL),
(123, 18, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15', 0, NULL),
(124, 19, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15', 0, NULL),
(125, 20, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15', 0, NULL),
(126, 21, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15', 0, NULL),
(127, 22, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15', 0, NULL),
(128, 23, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15', 0, NULL),
(129, 24, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15', 0, NULL),
(130, 25, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15', 0, NULL),
(131, 26, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15', 0, NULL),
(132, 27, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15', 0, NULL),
(133, 28, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15', 0, NULL),
(134, 29, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15', 0, NULL),
(135, 30, 6, 'Y', 'TKN-PRT-MCH-20260909-6-5700', 'Mahesh', 1, '2026-09-09', '2026-09-09 07:50:15', '2026-09-09 07:50:15', 0, NULL),
(136, 16, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52', 0, NULL),
(137, 17, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52', 0, NULL),
(138, 18, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52', 0, NULL),
(139, 19, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52', 0, NULL),
(140, 20, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52', 0, NULL),
(141, 21, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52', 0, NULL),
(142, 22, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52', 0, NULL),
(143, 23, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52', 0, NULL),
(144, 24, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52', 0, NULL),
(145, 25, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52', 0, NULL),
(146, 26, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52', 0, NULL),
(147, 27, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52', 0, NULL),
(148, 28, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52', 0, NULL),
(149, 29, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52', 0, NULL),
(150, 30, 4, 'Y', 'TKN-PRT-MCH-20260912-4-2276', 'Bheem Chand', 1, '2026-09-12', '2026-09-12 07:24:52', '2026-09-12 07:24:52', 0, NULL),
(151, 31, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14', 0, NULL),
(152, 32, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14', 0, NULL),
(153, 33, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14', 0, NULL),
(154, 34, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14', 0, NULL),
(155, 35, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14', 0, NULL),
(156, 36, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14', 0, NULL),
(157, 37, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14', 0, NULL),
(158, 38, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14', 0, NULL),
(159, 39, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14', 0, NULL),
(160, 40, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14', 0, NULL),
(161, 41, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14', 0, NULL),
(162, 42, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14', 0, NULL),
(163, 43, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14', 0, NULL),
(164, 44, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14', 0, NULL),
(165, 45, 7, 'Y', 'TKN-PRT-MCH-20260912-7-1428', 'SCL AUDITOR', 4, '2026-09-12', '2026-09-12 08:04:14', '2026-09-12 08:04:14', 0, NULL);

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
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_prt_scorecard_report`
--

INSERT INTO `mcc_prt_scorecard_report` (`id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `auditor_name`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(1, 1, 1, 'TKN-PRT-20260907-037', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:38', 0, NULL),
(2, 2, 1, 'TKN-PRT-20260907-037', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:38', 0, NULL),
(3, 3, 1, 'TKN-PRT-20260907-037', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:38', 0, NULL),
(4, 4, 1, 'TKN-PRT-20260907-037', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:38', 0, NULL),
(5, 5, 1, 'TKN-PRT-20260907-037', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:38', 0, NULL),
(6, 7, 1, 'TKN-PRT-20260907-037', '12345', 'C1', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:40', 0, NULL),
(7, 1, 1, 'TKN-PRT-20260907-037', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:44', 0, NULL),
(8, 2, 1, 'TKN-PRT-20260907-037', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:44', 0, NULL),
(9, 3, 1, 'TKN-PRT-20260907-037', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:44', 0, NULL),
(10, 4, 1, 'TKN-PRT-20260907-037', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:44', 0, NULL),
(11, 5, 1, 'TKN-PRT-20260907-037', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:44', 0, NULL),
(12, 7, 1, 'TKN-PRT-20260907-037', '12345', 'C2', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:46', 0, NULL),
(13, 1, 1, 'TKN-PRT-20260907-037', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:55', 0, NULL),
(14, 2, 1, 'TKN-PRT-20260907-037', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:55', 0, NULL),
(15, 3, 1, 'TKN-PRT-20260907-037', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:55', 0, NULL),
(16, 4, 1, 'TKN-PRT-20260907-037', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:55', 0, NULL),
(17, 5, 1, 'TKN-PRT-20260907-037', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:55', 0, NULL),
(18, 7, 1, 'TKN-PRT-20260907-037', '12345', 'C3', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:18:56', 0, NULL),
(19, 1, 1, 'TKN-PRT-20260907-037', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:07', 0, NULL),
(20, 2, 1, 'TKN-PRT-20260907-037', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:07', 0, NULL),
(21, 3, 1, 'TKN-PRT-20260907-037', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:07', 0, NULL),
(22, 4, 1, 'TKN-PRT-20260907-037', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:07', 0, NULL),
(23, 5, 1, 'TKN-PRT-20260907-037', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:07', 0, NULL),
(24, 7, 1, 'TKN-PRT-20260907-037', '12345', 'C4', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:18:30', '2026-09-07 14:19:10', 0, NULL),
(25, 1, 1, 'TKN-PRT-20260908-861', '16232', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:26', 0, NULL),
(26, 2, 1, 'TKN-PRT-20260908-861', '16232', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:26', 0, NULL),
(27, 3, 1, 'TKN-PRT-20260908-861', '16232', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:26', 0, NULL),
(28, 4, 1, 'TKN-PRT-20260908-861', '16232', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:26', 0, NULL),
(29, 5, 1, 'TKN-PRT-20260908-861', '16232', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:26', 0, NULL),
(30, 7, 1, 'TKN-PRT-20260908-861', '16232', '01', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:29', 0, NULL),
(31, 1, 1, 'TKN-PRT-20260908-861', '16232', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:34', 0, NULL),
(32, 2, 1, 'TKN-PRT-20260908-861', '16232', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:34', 0, NULL),
(33, 3, 1, 'TKN-PRT-20260908-861', '16232', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:34', 0, NULL),
(34, 4, 1, 'TKN-PRT-20260908-861', '16232', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:34', 0, NULL),
(35, 5, 1, 'TKN-PRT-20260908-861', '16232', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:34', 0, NULL),
(36, 7, 1, 'TKN-PRT-20260908-861', '16232', '02', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:37', 0, NULL),
(37, 1, 1, 'TKN-PRT-20260908-861', '16232', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:43', 0, NULL),
(38, 2, 1, 'TKN-PRT-20260908-861', '16232', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:43', 0, NULL),
(39, 3, 1, 'TKN-PRT-20260908-861', '16232', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:43', 0, NULL),
(40, 4, 1, 'TKN-PRT-20260908-861', '16232', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:43', 0, NULL),
(41, 5, 1, 'TKN-PRT-20260908-861', '16232', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:43', 0, NULL),
(42, 7, 1, 'TKN-PRT-20260908-861', '16232', '03', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:18:22', '2026-09-08 13:18:46', 0, NULL),
(43, 1, 1, 'TKN-PRT-20260908-808', '12008', '01', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:26:59', 0, NULL),
(44, 2, 1, 'TKN-PRT-20260908-808', '12008', '01', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:26:59', 0, NULL),
(45, 3, 1, 'TKN-PRT-20260908-808', '12008', '01', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:26:59', 0, NULL),
(46, 4, 1, 'TKN-PRT-20260908-808', '12008', '01', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:26:59', 0, NULL),
(47, 5, 1, 'TKN-PRT-20260908-808', '12008', '01', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:26:59', 0, NULL),
(48, 7, 1, 'TKN-PRT-20260908-808', '12008', '01', 'Y', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:03', 0, NULL),
(49, 1, 1, 'TKN-PRT-20260908-808', '12008', '02', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:10', 0, NULL),
(50, 2, 1, 'TKN-PRT-20260908-808', '12008', '02', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:10', 0, NULL),
(51, 3, 1, 'TKN-PRT-20260908-808', '12008', '02', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:10', 0, NULL),
(52, 4, 1, 'TKN-PRT-20260908-808', '12008', '02', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:10', 0, NULL),
(53, 5, 1, 'TKN-PRT-20260908-808', '12008', '02', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:10', 0, NULL),
(54, 7, 1, 'TKN-PRT-20260908-808', '12008', '02', 'Y', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:13', 0, NULL),
(55, 1, 1, 'TKN-PRT-20260908-808', '12008', '03', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:18', 0, NULL),
(56, 2, 1, 'TKN-PRT-20260908-808', '12008', '03', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:18', 0, NULL),
(57, 3, 1, 'TKN-PRT-20260908-808', '12008', '03', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:18', 0, NULL),
(58, 4, 1, 'TKN-PRT-20260908-808', '12008', '03', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:18', 0, NULL),
(59, 5, 1, 'TKN-PRT-20260908-808', '12008', '03', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:18', 0, NULL),
(60, 7, 1, 'TKN-PRT-20260908-808', '12008', '03', 'Y', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:21', 0, NULL),
(61, 1, 1, 'TKN-PRT-20260908-808', '12008', '04', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:31', 0, NULL),
(62, 2, 1, 'TKN-PRT-20260908-808', '12008', '04', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:31', 0, NULL),
(63, 3, 1, 'TKN-PRT-20260908-808', '12008', '04', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:31', 0, NULL),
(64, 4, 1, 'TKN-PRT-20260908-808', '12008', '04', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:31', 0, NULL),
(65, 5, 1, 'TKN-PRT-20260908-808', '12008', '04', '3', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:31', 0, NULL),
(66, 7, 1, 'TKN-PRT-20260908-808', '12008', '04', 'Y', 'Amit kumar', '2026-09-08', '2026-09-08 13:26:45', '2026-09-08 13:27:34', 0, NULL),
(67, 1, 1, 'TKN-PRT-20260908-132', '17301', '01', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:22', 0, NULL),
(68, 2, 1, 'TKN-PRT-20260908-132', '17301', '01', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:22', 0, NULL),
(69, 3, 1, 'TKN-PRT-20260908-132', '17301', '01', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:22', 0, NULL),
(70, 4, 1, 'TKN-PRT-20260908-132', '17301', '01', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:22', 0, NULL),
(71, 5, 1, 'TKN-PRT-20260908-132', '17301', '01', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:22', 0, NULL),
(72, 7, 1, 'TKN-PRT-20260908-132', '17301', '01', 'Y', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:25', 0, NULL),
(73, 1, 1, 'TKN-PRT-20260908-132', '17301', '02', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:31', 0, NULL),
(74, 2, 1, 'TKN-PRT-20260908-132', '17301', '02', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:31', 0, NULL),
(75, 3, 1, 'TKN-PRT-20260908-132', '17301', '02', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:31', 0, NULL),
(76, 4, 1, 'TKN-PRT-20260908-132', '17301', '02', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:31', 0, NULL),
(77, 5, 1, 'TKN-PRT-20260908-132', '17301', '02', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:31', 0, NULL),
(78, 7, 1, 'TKN-PRT-20260908-132', '17301', '02', 'Y', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:36', 0, NULL),
(79, 1, 1, 'TKN-PRT-20260908-132', '17301', '03', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:46', 0, NULL),
(80, 2, 1, 'TKN-PRT-20260908-132', '17301', '03', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:46', 0, NULL),
(81, 3, 1, 'TKN-PRT-20260908-132', '17301', '03', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:46', 0, NULL),
(82, 4, 1, 'TKN-PRT-20260908-132', '17301', '03', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:46', 0, NULL),
(83, 5, 1, 'TKN-PRT-20260908-132', '17301', '03', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:46', 0, NULL),
(84, 7, 1, 'TKN-PRT-20260908-132', '17301', '03', 'Y', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:49', 0, NULL),
(85, 1, 1, 'TKN-PRT-20260908-132', '17301', '04', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:57', 0, NULL),
(86, 2, 1, 'TKN-PRT-20260908-132', '17301', '04', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:57', 0, NULL),
(87, 3, 1, 'TKN-PRT-20260908-132', '17301', '04', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:57', 0, NULL),
(88, 4, 1, 'TKN-PRT-20260908-132', '17301', '04', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:57', 0, NULL),
(89, 5, 1, 'TKN-PRT-20260908-132', '17301', '04', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:57', 0, NULL),
(90, 7, 1, 'TKN-PRT-20260908-132', '17301', '04', 'Y', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:28:59', 0, NULL),
(91, 1, 1, 'TKN-PRT-20260908-132', '17301', '05', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:29:04', 0, NULL),
(92, 2, 1, 'TKN-PRT-20260908-132', '17301', '05', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:29:04', 0, NULL),
(93, 3, 1, 'TKN-PRT-20260908-132', '17301', '05', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:29:04', 0, NULL),
(94, 4, 1, 'TKN-PRT-20260908-132', '17301', '05', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:29:04', 0, NULL),
(95, 5, 1, 'TKN-PRT-20260908-132', '17301', '05', '3', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:29:04', 0, NULL),
(96, 7, 1, 'TKN-PRT-20260908-132', '17301', '05', 'Y', 'Siddik', '2026-09-08', '2026-09-08 13:28:13', '2026-09-08 13:29:08', 0, NULL),
(97, 1, 1, 'TKN-PRT-20260908-873', '16315', '01', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:19', 0, NULL),
(98, 2, 1, 'TKN-PRT-20260908-873', '16315', '01', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:19', 0, NULL),
(99, 3, 1, 'TKN-PRT-20260908-873', '16315', '01', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:19', 0, NULL),
(100, 4, 1, 'TKN-PRT-20260908-873', '16315', '01', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:19', 0, NULL),
(101, 5, 1, 'TKN-PRT-20260908-873', '16315', '01', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:19', 0, NULL),
(102, 7, 1, 'TKN-PRT-20260908-873', '16315', '01', 'Y', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:21', 0, NULL),
(103, 1, 1, 'TKN-PRT-20260908-873', '16315', '02', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:27', 0, NULL),
(104, 2, 1, 'TKN-PRT-20260908-873', '16315', '02', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:27', 0, NULL),
(105, 3, 1, 'TKN-PRT-20260908-873', '16315', '02', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:27', 0, NULL),
(106, 4, 1, 'TKN-PRT-20260908-873', '16315', '02', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:27', 0, NULL),
(107, 5, 1, 'TKN-PRT-20260908-873', '16315', '02', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:27', 0, NULL),
(108, 7, 1, 'TKN-PRT-20260908-873', '16315', '02', 'Y', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:30', 0, NULL),
(109, 1, 1, 'TKN-PRT-20260908-873', '16315', '03', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:39', 0, NULL),
(110, 2, 1, 'TKN-PRT-20260908-873', '16315', '03', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:39', 0, NULL),
(111, 3, 1, 'TKN-PRT-20260908-873', '16315', '03', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:39', 0, NULL),
(112, 4, 1, 'TKN-PRT-20260908-873', '16315', '03', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:39', 0, NULL),
(113, 5, 1, 'TKN-PRT-20260908-873', '16315', '03', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:39', 0, NULL),
(114, 7, 1, 'TKN-PRT-20260908-873', '16315', '03', 'Y', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:42', 0, NULL),
(115, 1, 1, 'TKN-PRT-20260908-873', '16315', '04', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:50', 0, NULL),
(116, 2, 1, 'TKN-PRT-20260908-873', '16315', '04', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:50', 0, NULL),
(117, 3, 1, 'TKN-PRT-20260908-873', '16315', '04', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:50', 0, NULL),
(118, 4, 1, 'TKN-PRT-20260908-873', '16315', '04', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:50', 0, NULL),
(119, 5, 1, 'TKN-PRT-20260908-873', '16315', '04', '3', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:50', 0, NULL),
(120, 7, 1, 'TKN-PRT-20260908-873', '16315', '04', 'Y', 'Abbuzada', '2026-09-08', '2026-09-08 13:32:11', '2026-09-08 13:32:53', 0, NULL),
(121, 1, 1, 'TKN-PRT-20260908-698', '16022', '01', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:44', 0, NULL),
(122, 2, 1, 'TKN-PRT-20260908-698', '16022', '01', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:44', 0, NULL),
(123, 3, 1, 'TKN-PRT-20260908-698', '16022', '01', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:44', 0, NULL),
(124, 4, 1, 'TKN-PRT-20260908-698', '16022', '01', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:44', 0, NULL),
(125, 5, 1, 'TKN-PRT-20260908-698', '16022', '01', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:44', 0, NULL),
(126, 7, 1, 'TKN-PRT-20260908-698', '16022', '01', 'Y', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:47', 0, NULL),
(127, 1, 1, 'TKN-PRT-20260908-698', '16022', '02', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:52', 0, NULL),
(128, 2, 1, 'TKN-PRT-20260908-698', '16022', '02', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:52', 0, NULL),
(129, 3, 1, 'TKN-PRT-20260908-698', '16022', '02', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:52', 0, NULL),
(130, 4, 1, 'TKN-PRT-20260908-698', '16022', '02', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:52', 0, NULL),
(131, 5, 1, 'TKN-PRT-20260908-698', '16022', '02', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:52', 0, NULL),
(132, 7, 1, 'TKN-PRT-20260908-698', '16022', '02', 'Y', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:34:57', 0, NULL),
(133, 1, 1, 'TKN-PRT-20260908-698', '16022', '03', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:02', 0, NULL),
(134, 2, 1, 'TKN-PRT-20260908-698', '16022', '03', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:02', 0, NULL),
(135, 3, 1, 'TKN-PRT-20260908-698', '16022', '03', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:02', 0, NULL),
(136, 4, 1, 'TKN-PRT-20260908-698', '16022', '03', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:02', 0, NULL),
(137, 5, 1, 'TKN-PRT-20260908-698', '16022', '03', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:02', 0, NULL),
(138, 7, 1, 'TKN-PRT-20260908-698', '16022', '03', 'Y', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:06', 0, NULL),
(139, 1, 1, 'TKN-PRT-20260908-698', '16022', '04', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:15', 0, NULL),
(140, 2, 1, 'TKN-PRT-20260908-698', '16022', '04', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:15', 0, NULL),
(141, 3, 1, 'TKN-PRT-20260908-698', '16022', '04', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:15', 0, NULL),
(142, 4, 1, 'TKN-PRT-20260908-698', '16022', '04', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:15', 0, NULL),
(143, 5, 1, 'TKN-PRT-20260908-698', '16022', '04', '3', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:15', 0, NULL),
(144, 7, 1, 'TKN-PRT-20260908-698', '16022', '04', 'Y', 'S kumar', '2026-09-08', '2026-09-08 13:34:34', '2026-09-08 13:35:17', 0, NULL),
(145, 1, 1, 'TKN-PRT-20260909-298', '16232', '01', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:13', 0, NULL),
(146, 2, 1, 'TKN-PRT-20260909-298', '16232', '01', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:13', 0, NULL),
(147, 3, 1, 'TKN-PRT-20260909-298', '16232', '01', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:13', 0, NULL),
(148, 4, 1, 'TKN-PRT-20260909-298', '16232', '01', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:13', 0, NULL),
(149, 5, 1, 'TKN-PRT-20260909-298', '16232', '01', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:13', 0, NULL),
(150, 7, 1, 'TKN-PRT-20260909-298', '16232', '01', 'Y', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:16', 0, NULL),
(151, 1, 1, 'TKN-PRT-20260909-298', '16232', '02', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:21', 0, NULL),
(152, 2, 1, 'TKN-PRT-20260909-298', '16232', '02', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:21', 0, NULL),
(153, 3, 1, 'TKN-PRT-20260909-298', '16232', '02', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:21', 0, NULL),
(154, 4, 1, 'TKN-PRT-20260909-298', '16232', '02', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:21', 0, NULL),
(155, 5, 1, 'TKN-PRT-20260909-298', '16232', '02', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:21', 0, NULL),
(156, 7, 1, 'TKN-PRT-20260909-298', '16232', '02', 'Y', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:24', 0, NULL),
(157, 1, 1, 'TKN-PRT-20260909-298', '16232', '03', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:35', 0, NULL),
(158, 2, 1, 'TKN-PRT-20260909-298', '16232', '03', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:35', 0, NULL),
(159, 3, 1, 'TKN-PRT-20260909-298', '16232', '03', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:35', 0, NULL),
(160, 4, 1, 'TKN-PRT-20260909-298', '16232', '03', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:35', 0, NULL),
(161, 5, 1, 'TKN-PRT-20260909-298', '16232', '03', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:35', 0, NULL),
(162, 7, 1, 'TKN-PRT-20260909-298', '16232', '03', 'Y', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:38', 0, NULL),
(163, 1, 1, 'TKN-PRT-20260909-298', '16232', '04', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:45', 0, NULL),
(164, 2, 1, 'TKN-PRT-20260909-298', '16232', '04', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:45', 0, NULL),
(165, 3, 1, 'TKN-PRT-20260909-298', '16232', '04', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:45', 0, NULL),
(166, 4, 1, 'TKN-PRT-20260909-298', '16232', '04', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:45', 0, NULL),
(167, 5, 1, 'TKN-PRT-20260909-298', '16232', '04', '3', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:45', 0, NULL),
(168, 7, 1, 'TKN-PRT-20260909-298', '16232', '04', 'Y', 'Mahesh', '2026-09-09', '2026-09-09 07:39:56', '2026-09-09 07:47:48', 0, NULL),
(169, 1, 1, 'TKN-PRT-20260909-755', '16595', '01', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:41:59', 0, NULL),
(170, 2, 1, 'TKN-PRT-20260909-755', '16595', '01', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:41:59', 0, NULL),
(171, 3, 1, 'TKN-PRT-20260909-755', '16595', '01', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:41:59', 0, NULL),
(172, 4, 1, 'TKN-PRT-20260909-755', '16595', '01', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:41:59', 0, NULL),
(173, 5, 1, 'TKN-PRT-20260909-755', '16595', '01', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:41:59', 0, NULL),
(174, 7, 1, 'TKN-PRT-20260909-755', '16595', '01', 'Y', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:11', 0, NULL),
(175, 1, 1, 'TKN-PRT-20260909-755', '16595', '02', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:21', 0, NULL),
(176, 2, 1, 'TKN-PRT-20260909-755', '16595', '02', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:21', 0, NULL),
(177, 3, 1, 'TKN-PRT-20260909-755', '16595', '02', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:21', 0, NULL),
(178, 4, 1, 'TKN-PRT-20260909-755', '16595', '02', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:21', 0, NULL),
(179, 5, 1, 'TKN-PRT-20260909-755', '16595', '02', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:21', 0, NULL),
(180, 7, 1, 'TKN-PRT-20260909-755', '16595', '02', 'Y', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:23', 0, NULL),
(181, 1, 1, 'TKN-PRT-20260909-755', '16595', '03', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:28', 0, NULL),
(182, 2, 1, 'TKN-PRT-20260909-755', '16595', '03', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:28', 0, NULL),
(183, 3, 1, 'TKN-PRT-20260909-755', '16595', '03', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:28', 0, NULL),
(184, 4, 1, 'TKN-PRT-20260909-755', '16595', '03', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:28', 0, NULL),
(185, 5, 1, 'TKN-PRT-20260909-755', '16595', '03', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:28', 0, NULL),
(186, 7, 1, 'TKN-PRT-20260909-755', '16595', '03', 'Y', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:31', 0, NULL),
(187, 1, 1, 'TKN-PRT-20260909-755', '16595', '04', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:40', 0, NULL),
(188, 2, 1, 'TKN-PRT-20260909-755', '16595', '04', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:40', 0, NULL),
(189, 3, 1, 'TKN-PRT-20260909-755', '16595', '04', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:40', 0, NULL),
(190, 4, 1, 'TKN-PRT-20260909-755', '16595', '04', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:40', 0, NULL),
(191, 5, 1, 'TKN-PRT-20260909-755', '16595', '04', '3', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:40', 0, NULL),
(192, 7, 1, 'TKN-PRT-20260909-755', '16595', '04', 'Y', 'Umesh', '2026-09-09', '2026-09-09 07:40:20', '2026-09-09 07:42:43', 0, NULL),
(193, 1, 1, 'TKN-PRT-20260909-754', '16592', '01', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:42:56', 0, NULL),
(194, 2, 1, 'TKN-PRT-20260909-754', '16592', '01', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:42:56', 0, NULL),
(195, 3, 1, 'TKN-PRT-20260909-754', '16592', '01', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:42:56', 0, NULL),
(196, 4, 1, 'TKN-PRT-20260909-754', '16592', '01', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:42:56', 0, NULL),
(197, 5, 1, 'TKN-PRT-20260909-754', '16592', '01', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:42:56', 0, NULL),
(198, 7, 1, 'TKN-PRT-20260909-754', '16592', '01', 'Y', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:42:59', 0, NULL),
(199, 1, 1, 'TKN-PRT-20260909-754', '16592', '02', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:38', 0, NULL),
(200, 2, 1, 'TKN-PRT-20260909-754', '16592', '02', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:38', 0, NULL),
(201, 3, 1, 'TKN-PRT-20260909-754', '16592', '02', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:38', 0, NULL),
(202, 4, 1, 'TKN-PRT-20260909-754', '16592', '02', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:38', 0, NULL),
(203, 5, 1, 'TKN-PRT-20260909-754', '16592', '02', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:38', 0, NULL),
(204, 7, 1, 'TKN-PRT-20260909-754', '16592', '02', 'Y', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:41', 0, NULL),
(205, 1, 1, 'TKN-PRT-20260909-754', '16592', '03', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:48', 0, NULL),
(206, 2, 1, 'TKN-PRT-20260909-754', '16592', '03', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:48', 0, NULL),
(207, 3, 1, 'TKN-PRT-20260909-754', '16592', '03', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:48', 0, NULL),
(208, 4, 1, 'TKN-PRT-20260909-754', '16592', '03', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:48', 0, NULL),
(209, 5, 1, 'TKN-PRT-20260909-754', '16592', '03', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:48', 0, NULL),
(210, 7, 1, 'TKN-PRT-20260909-754', '16592', '03', 'Y', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:50', 0, NULL),
(211, 1, 1, 'TKN-PRT-20260909-754', '16592', '04', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:56', 0, NULL),
(212, 2, 1, 'TKN-PRT-20260909-754', '16592', '04', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:56', 0, NULL),
(213, 3, 1, 'TKN-PRT-20260909-754', '16592', '04', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:56', 0, NULL),
(214, 4, 1, 'TKN-PRT-20260909-754', '16592', '04', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:56', 0, NULL),
(215, 5, 1, 'TKN-PRT-20260909-754', '16592', '04', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:56', 0, NULL),
(216, 7, 1, 'TKN-PRT-20260909-754', '16592', '04', 'Y', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:45:58', 0, NULL),
(217, 1, 1, 'TKN-PRT-20260909-754', '16592', '05', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:46:07', 0, NULL),
(218, 2, 1, 'TKN-PRT-20260909-754', '16592', '05', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:46:07', 0, NULL),
(219, 3, 1, 'TKN-PRT-20260909-754', '16592', '05', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:46:07', 0, NULL),
(220, 4, 1, 'TKN-PRT-20260909-754', '16592', '05', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:46:07', 0, NULL),
(221, 5, 1, 'TKN-PRT-20260909-754', '16592', '05', '3', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:46:07', 0, NULL),
(222, 7, 1, 'TKN-PRT-20260909-754', '16592', '05', 'Y', 'Kalyan', '2026-09-09', '2026-09-09 07:40:57', '2026-09-09 07:46:10', 0, NULL),
(223, 1, 1, 'TKN-PRT-20260909-309', '12007', '01', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:24', 0, NULL),
(224, 2, 1, 'TKN-PRT-20260909-309', '12007', '01', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:24', 0, NULL),
(225, 3, 1, 'TKN-PRT-20260909-309', '12007', '01', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:24', 0, NULL),
(226, 4, 1, 'TKN-PRT-20260909-309', '12007', '01', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:24', 0, NULL),
(227, 5, 1, 'TKN-PRT-20260909-309', '12007', '01', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:24', 0, NULL),
(228, 7, 1, 'TKN-PRT-20260909-309', '12007', '01', 'Y', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:26', 0, NULL),
(229, 1, 1, 'TKN-PRT-20260909-309', '12007', '02', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:36', 0, NULL),
(230, 2, 1, 'TKN-PRT-20260909-309', '12007', '02', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:36', 0, NULL),
(231, 3, 1, 'TKN-PRT-20260909-309', '12007', '02', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:36', 0, NULL),
(232, 4, 1, 'TKN-PRT-20260909-309', '12007', '02', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:36', 0, NULL),
(233, 5, 1, 'TKN-PRT-20260909-309', '12007', '02', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:36', 0, NULL),
(234, 7, 1, 'TKN-PRT-20260909-309', '12007', '02', 'Y', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:39', 0, NULL),
(235, 1, 1, 'TKN-PRT-20260909-309', '12007', '03', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:46', 0, NULL),
(236, 2, 1, 'TKN-PRT-20260909-309', '12007', '03', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:46', 0, NULL),
(237, 3, 1, 'TKN-PRT-20260909-309', '12007', '03', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:46', 0, NULL),
(238, 4, 1, 'TKN-PRT-20260909-309', '12007', '03', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:46', 0, NULL),
(239, 5, 1, 'TKN-PRT-20260909-309', '12007', '03', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:46', 0, NULL),
(240, 7, 1, 'TKN-PRT-20260909-309', '12007', '03', 'Y', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:49', 0, NULL),
(241, 1, 1, 'TKN-PRT-20260909-309', '12007', '04', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:57', 0, NULL),
(242, 2, 1, 'TKN-PRT-20260909-309', '12007', '04', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:57', 0, NULL),
(243, 3, 1, 'TKN-PRT-20260909-309', '12007', '04', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:57', 0, NULL),
(244, 4, 1, 'TKN-PRT-20260909-309', '12007', '04', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:57', 0, NULL),
(245, 5, 1, 'TKN-PRT-20260909-309', '12007', '04', '3', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:46:57', 0, NULL),
(246, 7, 1, 'TKN-PRT-20260909-309', '12007', '04', 'Y', 'Somaselharn', '2026-09-09', '2026-09-09 07:41:34', '2026-09-09 07:47:00', 0, NULL),
(247, 1, 1, 'TKN-PRT-20260912-131', '12345', 'C1', '3', 'Bheem Chand', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:26', 0, NULL),
(248, 2, 1, 'TKN-PRT-20260912-131', '12345', 'C1', '3', 'Bheem Chand', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:26', 0, NULL),
(249, 3, 1, 'TKN-PRT-20260912-131', '12345', 'C1', '3', 'Bheem Chand', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:26', 0, NULL),
(250, 4, 1, 'TKN-PRT-20260912-131', '12345', 'C1', '3', 'Bheem Chand', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:26', 0, NULL),
(251, 5, 1, 'TKN-PRT-20260912-131', '12345', 'C1', '3', 'Bheem Chand', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:26', 0, NULL),
(252, 7, 1, 'TKN-PRT-20260912-131', '12345', 'C1', '', 'Bheem Chand', '2026-09-12', '2026-09-12 07:25:21', '2026-09-12 07:25:21', 0, NULL),
(253, 15, 4, 'TKN-PRT-20260912-918', '123456', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:03:48', 0, NULL),
(254, 16, 4, 'TKN-PRT-20260912-918', '123456', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:03:48', 0, NULL),
(255, 17, 4, 'TKN-PRT-20260912-918', '123456', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:03:48', 0, NULL),
(256, 18, 4, 'TKN-PRT-20260912-918', '123456', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:03:48', 0, NULL),
(257, 19, 4, 'TKN-PRT-20260912-918', '123456', 'C1', '3', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:03:48', 0, NULL),
(258, 20, 4, 'TKN-PRT-20260912-918', '123456', 'C1', 'Y', 'SCL AUDITOR', '2026-09-12', '2026-09-12 08:03:27', '2026-09-12 08:03:51', 0, NULL),
(259, 1, 1, 'TKN-PRT-20260922-263', '16210', '227126', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(260, 2, 1, 'TKN-PRT-20260922-263', '16210', '227126', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(261, 3, 1, 'TKN-PRT-20260922-263', '16210', '227126', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(262, 4, 1, 'TKN-PRT-20260922-263', '16210', '227126', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(263, 5, 1, 'TKN-PRT-20260922-263', '16210', '227126', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(264, 7, 1, 'TKN-PRT-20260922-263', '16210', '227126', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(265, 1, 1, 'TKN-PRT-20260922-263', '16210', '182209', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(266, 2, 1, 'TKN-PRT-20260922-263', '16210', '182209', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(267, 3, 1, 'TKN-PRT-20260922-263', '16210', '182209', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(268, 4, 1, 'TKN-PRT-20260922-263', '16210', '182209', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(269, 5, 1, 'TKN-PRT-20260922-263', '16210', '182209', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(270, 7, 1, 'TKN-PRT-20260922-263', '16210', '182209', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(271, 1, 1, 'TKN-PRT-20260922-263', '16210', '226871', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(272, 2, 1, 'TKN-PRT-20260922-263', '16210', '226871', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(273, 3, 1, 'TKN-PRT-20260922-263', '16210', '226871', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(274, 4, 1, 'TKN-PRT-20260922-263', '16210', '226871', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(275, 5, 1, 'TKN-PRT-20260922-263', '16210', '226871', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(276, 7, 1, 'TKN-PRT-20260922-263', '16210', '226871', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(277, 1, 1, 'TKN-PRT-20260922-263', '16210', '225859', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(278, 2, 1, 'TKN-PRT-20260922-263', '16210', '225859', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(279, 3, 1, 'TKN-PRT-20260922-263', '16210', '225859', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(280, 4, 1, 'TKN-PRT-20260922-263', '16210', '225859', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(281, 5, 1, 'TKN-PRT-20260922-263', '16210', '225859', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(282, 7, 1, 'TKN-PRT-20260922-263', '16210', '225859', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(283, 1, 1, 'TKN-PRT-20260922-263', '16210', '225283', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(284, 2, 1, 'TKN-PRT-20260922-263', '16210', '225283', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(285, 3, 1, 'TKN-PRT-20260922-263', '16210', '225283', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(286, 4, 1, 'TKN-PRT-20260922-263', '16210', '225283', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(287, 5, 1, 'TKN-PRT-20260922-263', '16210', '225283', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(288, 7, 1, 'TKN-PRT-20260922-263', '16210', '225283', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(289, 1, 1, 'TKN-PRT-20260922-263', '16210', '226472', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(290, 2, 1, 'TKN-PRT-20260922-263', '16210', '226472', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(291, 3, 1, 'TKN-PRT-20260922-263', '16210', '226472', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(292, 4, 1, 'TKN-PRT-20260922-263', '16210', '226472', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(293, 5, 1, 'TKN-PRT-20260922-263', '16210', '226472', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(294, 7, 1, 'TKN-PRT-20260922-263', '16210', '226472', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(295, 1, 1, 'TKN-PRT-20260922-263', '16210', '191730', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(296, 2, 1, 'TKN-PRT-20260922-263', '16210', '191730', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(297, 3, 1, 'TKN-PRT-20260922-263', '16210', '191730', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(298, 4, 1, 'TKN-PRT-20260922-263', '16210', '191730', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(299, 5, 1, 'TKN-PRT-20260922-263', '16210', '191730', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(300, 7, 1, 'TKN-PRT-20260922-263', '16210', '191730', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(301, 1, 1, 'TKN-PRT-20260922-263', '16210', '193659', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(302, 2, 1, 'TKN-PRT-20260922-263', '16210', '193659', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(303, 3, 1, 'TKN-PRT-20260922-263', '16210', '193659', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(304, 4, 1, 'TKN-PRT-20260922-263', '16210', '193659', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(305, 5, 1, 'TKN-PRT-20260922-263', '16210', '193659', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(306, 7, 1, 'TKN-PRT-20260922-263', '16210', '193659', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(307, 1, 1, 'TKN-PRT-20260922-263', '16210', '197712', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(308, 2, 1, 'TKN-PRT-20260922-263', '16210', '197712', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(309, 3, 1, 'TKN-PRT-20260922-263', '16210', '197712', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(310, 4, 1, 'TKN-PRT-20260922-263', '16210', '197712', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(311, 5, 1, 'TKN-PRT-20260922-263', '16210', '197712', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(312, 7, 1, 'TKN-PRT-20260922-263', '16210', '197712', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(313, 1, 1, 'TKN-PRT-20260922-263', '16210', '197855', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(314, 2, 1, 'TKN-PRT-20260922-263', '16210', '197855', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(315, 3, 1, 'TKN-PRT-20260922-263', '16210', '197855', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(316, 4, 1, 'TKN-PRT-20260922-263', '16210', '197855', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(317, 5, 1, 'TKN-PRT-20260922-263', '16210', '197855', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(318, 7, 1, 'TKN-PRT-20260922-263', '16210', '197855', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(319, 1, 1, 'TKN-PRT-20260922-263', '16210', '212183', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(320, 2, 1, 'TKN-PRT-20260922-263', '16210', '212183', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(321, 3, 1, 'TKN-PRT-20260922-263', '16210', '212183', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(322, 4, 1, 'TKN-PRT-20260922-263', '16210', '212183', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(323, 5, 1, 'TKN-PRT-20260922-263', '16210', '212183', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(324, 7, 1, 'TKN-PRT-20260922-263', '16210', '212183', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(325, 1, 1, 'TKN-PRT-20260922-263', '16210', '243440', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(326, 2, 1, 'TKN-PRT-20260922-263', '16210', '243440', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(327, 3, 1, 'TKN-PRT-20260922-263', '16210', '243440', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(328, 4, 1, 'TKN-PRT-20260922-263', '16210', '243440', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(329, 5, 1, 'TKN-PRT-20260922-263', '16210', '243440', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(330, 7, 1, 'TKN-PRT-20260922-263', '16210', '243440', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(331, 1, 1, 'TKN-PRT-20260922-263', '16210', '182083', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(332, 2, 1, 'TKN-PRT-20260922-263', '16210', '182083', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(333, 3, 1, 'TKN-PRT-20260922-263', '16210', '182083', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(334, 4, 1, 'TKN-PRT-20260922-263', '16210', '182083', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(335, 5, 1, 'TKN-PRT-20260922-263', '16210', '182083', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(336, 7, 1, 'TKN-PRT-20260922-263', '16210', '182083', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(337, 1, 1, 'TKN-PRT-20260922-263', '16210', '182078', '3', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:36', 0, 21),
(338, 2, 1, 'TKN-PRT-20260922-263', '16210', '182078', '3', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:36', 0, 21),
(339, 3, 1, 'TKN-PRT-20260922-263', '16210', '182078', '3', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:36', 0, 21),
(340, 4, 1, 'TKN-PRT-20260922-263', '16210', '182078', '3', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:36', 0, 21),
(341, 5, 1, 'TKN-PRT-20260922-263', '16210', '182078', '3', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:36', 0, 21),
(342, 7, 1, 'TKN-PRT-20260922-263', '16210', '182078', 'Y', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:47', 0, 21),
(343, 1, 1, 'TKN-PRT-20260922-263', '16210', '223450', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(344, 2, 1, 'TKN-PRT-20260922-263', '16210', '223450', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(345, 3, 1, 'TKN-PRT-20260922-263', '16210', '223450', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(346, 4, 1, 'TKN-PRT-20260922-263', '16210', '223450', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(347, 5, 1, 'TKN-PRT-20260922-263', '16210', '223450', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(348, 7, 1, 'TKN-PRT-20260922-263', '16210', '223450', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(349, 1, 1, 'TKN-PRT-20260922-263', '16210', '201593', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(350, 2, 1, 'TKN-PRT-20260922-263', '16210', '201593', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(351, 3, 1, 'TKN-PRT-20260922-263', '16210', '201593', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(352, 4, 1, 'TKN-PRT-20260922-263', '16210', '201593', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(353, 5, 1, 'TKN-PRT-20260922-263', '16210', '201593', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(354, 7, 1, 'TKN-PRT-20260922-263', '16210', '201593', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(355, 1, 1, 'TKN-PRT-20260922-263', '16210', '191483', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(356, 2, 1, 'TKN-PRT-20260922-263', '16210', '191483', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(357, 3, 1, 'TKN-PRT-20260922-263', '16210', '191483', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(358, 4, 1, 'TKN-PRT-20260922-263', '16210', '191483', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(359, 5, 1, 'TKN-PRT-20260922-263', '16210', '191483', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(360, 7, 1, 'TKN-PRT-20260922-263', '16210', '191483', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(361, 1, 1, 'TKN-PRT-20260922-263', '16210', '195176', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(362, 2, 1, 'TKN-PRT-20260922-263', '16210', '195176', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(363, 3, 1, 'TKN-PRT-20260922-263', '16210', '195176', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(364, 4, 1, 'TKN-PRT-20260922-263', '16210', '195176', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21);
INSERT INTO `mcc_prt_scorecard_report` (`id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `auditor_name`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(365, 5, 1, 'TKN-PRT-20260922-263', '16210', '195176', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(366, 7, 1, 'TKN-PRT-20260922-263', '16210', '195176', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(367, 1, 1, 'TKN-PRT-20260922-263', '16210', '191599', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(368, 2, 1, 'TKN-PRT-20260922-263', '16210', '191599', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(369, 3, 1, 'TKN-PRT-20260922-263', '16210', '191599', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(370, 4, 1, 'TKN-PRT-20260922-263', '16210', '191599', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(371, 5, 1, 'TKN-PRT-20260922-263', '16210', '191599', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(372, 7, 1, 'TKN-PRT-20260922-263', '16210', '191599', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(373, 1, 1, 'TKN-PRT-20260922-263', '16210', '263996', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(374, 2, 1, 'TKN-PRT-20260922-263', '16210', '263996', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(375, 3, 1, 'TKN-PRT-20260922-263', '16210', '263996', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(376, 4, 1, 'TKN-PRT-20260922-263', '16210', '263996', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(377, 5, 1, 'TKN-PRT-20260922-263', '16210', '263996', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(378, 7, 1, 'TKN-PRT-20260922-263', '16210', '263996', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(379, 1, 1, 'TKN-PRT-20260922-263', '16210', '191077', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(380, 2, 1, 'TKN-PRT-20260922-263', '16210', '191077', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(381, 3, 1, 'TKN-PRT-20260922-263', '16210', '191077', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(382, 4, 1, 'TKN-PRT-20260922-263', '16210', '191077', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(383, 5, 1, 'TKN-PRT-20260922-263', '16210', '191077', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21),
(384, 7, 1, 'TKN-PRT-20260922-263', '16210', '191077', '', 'RAJ BIRUA', '2026-09-22', '2026-09-22 08:31:02', '2026-09-22 08:31:02', 0, 21);

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
(1, 'Normal Cleaning', 'normal_cleaning', 1, 'Active', '2026-05-22 10:09:17', '2026-09-21 10:25:39'),
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
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_surprise_reports`
--

INSERT INTO `mcc_surprise_reports` (`id`, `category`, `station_id`, `token_id`, `report_date`, `auditor_name`, `parameter_id`, `value`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(1, 'pit_office', 4, 'SV-PIT-CDO-001', '2026-09-10', 'CDO', 1, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(2, 'pit_office', 4, 'SV-PIT-CDO-001', '2026-09-10', 'CDO', 2, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(3, 'pit_office', 4, 'SV-PIT-CDO-001', '2026-09-10', 'CDO', 3, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(4, 'pit_office', 4, 'SV-PIT-CDO-001', '2026-09-10', 'CDO', 4, 3, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(5, 'pit_office', 4, 'SV-PIT-CDO-001', '2026-09-10', 'CDO', 5, 4, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(6, 'pit_office', 4, 'SV-PIT-CDO-001', '2026-09-10', 'CDO', 6, 4, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(7, 'pit_office', 4, 'SV-PIT-CDO-002', '2026-09-10', 'CDO', 1, 4, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(8, 'pit_office', 4, 'SV-PIT-CDO-002', '2026-09-10', 'CDO', 2, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(9, 'pit_office', 4, 'SV-PIT-CDO-002', '2026-09-10', 'CDO', 3, 3, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(10, 'pit_office', 4, 'SV-PIT-CDO-002', '2026-09-10', 'CDO', 4, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(11, 'pit_office', 4, 'SV-PIT-CDO-002', '2026-09-10', 'CDO', 5, 3, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(12, 'pit_office', 4, 'SV-PIT-CDO-002', '2026-09-10', 'CDO', 6, 3, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(13, 'pf_trains', 4, 'SV-PRT-12018-01', '2026-09-10', 'CDO', 7, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(14, 'pf_trains', 4, 'SV-PRT-12018-01', '2026-09-10', 'CDO', 8, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(15, 'pf_trains', 4, 'SV-PRT-12018-01', '2026-09-10', 'CDO', 9, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(16, 'pf_trains', 4, 'SV-PRT-12018-01', '2026-09-10', 'CDO', 10, 4, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(17, 'pf_trains', 4, 'SV-PRT-12018-01', '2026-09-10', 'CDO', 11, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(18, 'pf_trains', 4, 'SV-PRT-12056-01', '2026-09-10', 'CDO', 7, 4, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(19, 'pf_trains', 4, 'SV-PRT-12056-01', '2026-09-10', 'CDO', 8, 3, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(20, 'pf_trains', 4, 'SV-PRT-12056-01', '2026-09-10', 'CDO', 9, 5, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(21, 'pf_trains', 4, 'SV-PRT-12056-01', '2026-09-10', 'CDO', 10, 3, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(22, 'pf_trains', 4, 'SV-PRT-12056-01', '2026-09-10', 'CDO', 11, 3, '2026-06-17 13:08:07', '2026-09-11 10:51:03', 0, NULL),
(23, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 1, 5, '2026-09-12 07:14:37', '2026-09-12 07:14:37', 0, NULL),
(24, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 2, 5, '2026-09-12 07:14:37', '2026-09-12 07:14:37', 0, NULL),
(25, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 3, 5, '2026-09-12 07:14:37', '2026-09-12 07:14:37', 0, NULL),
(26, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 4, 5, '2026-09-12 07:14:37', '2026-09-12 07:14:37', 0, NULL),
(27, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 5, 5, '2026-09-12 07:14:37', '2026-09-12 07:14:37', 0, NULL),
(28, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 6, 5, '2026-09-12 07:14:37', '2026-09-12 07:14:37', 0, NULL),
(29, 'pf_trains', 4, 'SV-PF-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 7, 5, '2026-09-12 07:15:06', '2026-09-12 07:15:06', 0, NULL),
(30, 'pf_trains', 4, 'SV-PF-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 8, 5, '2026-09-12 07:15:06', '2026-09-12 07:15:06', 0, NULL),
(31, 'pf_trains', 4, 'SV-PF-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 9, 5, '2026-09-12 07:15:06', '2026-09-12 07:15:06', 0, NULL),
(32, 'pf_trains', 4, 'SV-PF-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 10, 5, '2026-09-12 07:15:06', '2026-09-12 07:15:06', 0, NULL),
(33, 'pf_trains', 4, 'SV-PF-SCLAUDITOR-001', '2026-09-12', 'SCL AUDITOR', 11, 5, '2026-09-12 07:15:06', '2026-09-12 07:15:06', 0, NULL),
(34, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-002', '2026-09-12', 'SCL AUDITOR', 1, 5, '2026-09-12 07:16:26', '2026-09-12 07:16:26', 0, NULL),
(35, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-002', '2026-09-12', 'SCL AUDITOR', 2, 5, '2026-09-12 07:16:26', '2026-09-12 07:16:26', 0, NULL),
(36, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-002', '2026-09-12', 'SCL AUDITOR', 3, 5, '2026-09-12 07:16:26', '2026-09-12 07:16:26', 0, NULL),
(37, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-002', '2026-09-12', 'SCL AUDITOR', 4, 5, '2026-09-12 07:16:26', '2026-09-12 07:16:26', 0, NULL),
(38, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-002', '2026-09-12', 'SCL AUDITOR', 5, 5, '2026-09-12 07:16:26', '2026-09-12 07:16:26', 0, NULL),
(39, 'pit_office', 4, 'SV-PIT-SCLAUDITOR-002', '2026-09-12', 'SCL AUDITOR', 6, 5, '2026-09-12 07:16:26', '2026-09-12 07:16:26', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mcc_trains`
--

CREATE TABLE `mcc_trains` (
  `train_id` int(11) NOT NULL,
  `train_no` varchar(50) NOT NULL,
  `station_id` int(11) NOT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_trains`
--

INSERT INTO `mcc_trains` (`train_id`, `train_no`, `station_id`, `status`, `created_at`, `updated_at`) VALUES
(3, '812601', 4, 'Active', '2026-09-15 07:44:39', '2026-09-15 07:44:39'),
(4, '16236', 1, 'Active', '2026-09-21 13:23:46', '2026-09-21 13:23:46'),
(7, '16210', 1, 'Active', '2026-09-22 07:52:17', '2026-09-22 07:52:17'),
(8, '56202', 1, 'Active', '2026-09-22 07:59:48', '2026-09-22 07:59:48'),
(9, '16227', 1, 'Active', '2026-09-22 08:11:52', '2026-09-22 08:11:52'),
(10, '16215', 1, 'Active', '2026-09-22 08:25:24', '2026-09-22 08:25:24'),
(11, '56210', 1, 'Active', '2026-09-22 09:25:09', '2026-09-22 09:25:09'),
(12, '56206', 1, 'Active', '2026-09-22 09:30:57', '2026-09-22 09:30:57'),
(13, '20676', 1, 'Active', '2026-09-22 09:31:04', '2026-09-22 09:31:04'),
(14, '16535', 1, 'Active', '2026-09-22 09:37:13', '2026-09-22 09:37:13'),
(15, '16225', 1, 'Active', '2026-09-22 09:40:39', '2026-09-22 09:40:39'),
(16, '12786', 1, 'Active', '2026-09-22 09:47:59', '2026-09-22 09:47:59'),
(17, '16232', 1, 'Active', '2026-09-22 09:54:50', '2026-09-22 09:54:50'),
(18, '16315', 1, 'Active', '2026-09-22 09:59:40', '2026-09-22 09:59:40'),
(19, '20624', 1, 'Active', '2026-09-22 10:03:52', '2026-09-22 10:03:52');

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
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `digital_signature` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_users`
--

INSERT INTO `mcc_users` (`user_id`, `user_name`, `user_code`, `username`, `email`, `password_hash`, `full_name`, `phone`, `designation`, `address`, `role`, `station_id`, `start_date`, `end_date`, `status`, `created_by_user_id`, `created_at`, `updated_at`, `digital_signature`) VALUES
(2, 'kings', NULL, 'CDO', 'kings@gmail.com', '$2y$10$3RDR/QZdf0b2bWDgSixl.uw8YPluriaVM2waD0w2unBxnXF51Awy2', NULL, NULL, NULL, NULL, 'CDO', 1, '2026-04-10', '2026-08-12', 'Active', NULL, '2026-04-10 14:15:10', '2026-07-17 04:49:15', NULL),
(4, 'admin', NULL, 'admin', 're@gmail.com', '$2y$10$3RDR/QZdf0b2bWDgSixl.uw8YPluriaVM2waD0w2unBxnXF51Awy2', NULL, NULL, NULL, NULL, 'ADMIN', 1, '2026-04-06', '2026-07-30', 'Active', NULL, '2026-04-06 14:02:59', '2026-08-12 04:22:45', NULL),
(9, 'Bheem Chand', NULL, 'bheem123', 'chandkapil24@gmail.com', '$2y$10$zpTRPGdYKI/0a.vFtgaGCO7rcbiwmZjDm72ZgcGy/3hLfvmE3LzLq', 'Bheem Chand', NULL, NULL, NULL, 'AUDITOR', 1, NULL, NULL, 'Active', NULL, '2026-08-30 17:33:03', '2026-08-30 17:33:03', NULL),
(11, 'viewer', NULL, 'bheem8126', 'BHEEMCHAND8126@GMAIL.COM', '$2y$10$kxX8Qi1mfQiloQuKPW6W0.3QRpa/rJqHQkNkvSjxEiRBlz1Y02OHe', 'viewer', NULL, NULL, NULL, 'VIEWER', 1, NULL, NULL, 'Active', NULL, '2026-09-01 11:10:24', '2026-09-01 11:10:24', NULL),
(12, 'SSE MYS', NULL, 'SSEMYS', 'AB@GMAIL.COM', '$2y$10$S7wsNB24l9VhmqV.WTXjfeFDm5n/Xw7rXDwpz7DK4zB1.bl.FCfge', 'SSE MYS', NULL, NULL, NULL, 'VIEWER', 1, NULL, NULL, 'Inactive', NULL, '2026-09-03 12:01:52', '2026-09-21 14:10:56', NULL),
(13, 'SCL', NULL, 'SCL', 'scl@gmail.com', '$2y$10$W2z.zaLR6QrvG.3hXUgyDOMehPNSFHy2P0IiOiGLgtWKmqfGVfr02', 'SCL', NULL, NULL, NULL, 'CDO', 4, NULL, NULL, 'Active', NULL, '2026-09-11 06:39:50', '2026-09-20 11:25:33', NULL),
(14, 'SCL AUDITOR', NULL, 'auditor', 'auditor@gmail.com', '$2y$10$jA2NMuvPbl74T/uJ0pH1S.3NpC9t6BV7bHJOCYxqC.XKovl/ClpeC', 'SCL AUDITOR', NULL, NULL, NULL, 'AUDITOR', 4, NULL, NULL, 'Active', NULL, '2026-09-11 10:50:32', '2026-09-18 12:05:27', 'sig_1789733127_16324c14.png'),
(15, 'Ajit Kumar Singh', NULL, 'SMC123', 'AJIT@1234GMAIL.COM', '$2y$10$0jsboXPMnfeae.MUGiT1VecjHwdZR.YAPqVrCNTdOHEV/tRTrIkSq', 'Ajit Kumar Singh', NULL, NULL, NULL, 'AUDITOR', 1, NULL, NULL, 'Inactive', NULL, '2026-09-16 10:46:38', '2026-09-17 08:24:08', NULL),
(16, 'Ajit Kumar', NULL, 'SMC1234', 'AJIT@GMAIL.COM', '$2y$10$/JYF8GUc2TVub5B5fJ8qVuhyYI7PxWYB3lr/rGkAYJzUpKE.rCiIS', 'Ajit Kumar', NULL, NULL, NULL, 'AUDITOR', 1, NULL, NULL, 'Active', NULL, '2026-09-17 08:15:47', '2026-09-17 08:19:51', NULL),
(18, 'Bhargab Sinha', NULL, 'Bhargab_SSE', 'bhargav.mi5@gmail.com', '$2y$10$T5NZtIK1euYWIz/mt3E7Ju2VA7.FlS7NhNgdmWm.02VnmZCRJADya', 'Bhargab Sinha', NULL, NULL, NULL, 'AUDITOR', 4, NULL, NULL, 'Active', NULL, '2026-09-20 11:47:12', '2026-09-20 11:47:12', NULL),
(19, 'Chayad Barbhuiya', NULL, 'Chayad_SSE', 'chayadb@gmail.com', '$2y$10$LWG3rDEH6WO.65FfOwoRQ.OCrN9jyLQpyKnF8jL9FeIYt1moqGoYO', 'Chayad Barbhuiya', NULL, NULL, NULL, 'AUDITOR', 4, NULL, NULL, 'Active', NULL, '2026-09-20 12:14:49', '2026-09-20 12:14:49', NULL),
(20, 'Angom Joshi Meetei', NULL, 'Angom_JE', 'angom.joshi@gmail.com', '$2y$10$EU2JgHmiDp9RXz4dzjv5YONFky4qw3ZWrjxO2kxHVaxxMMq/D0mXG', 'Angom Joshi Meetei', NULL, NULL, NULL, 'AUDITOR', 4, NULL, NULL, 'Active', NULL, '2026-09-20 12:15:43', '2026-09-20 12:16:24', NULL),
(21, 'RAJ BIRUA', NULL, 'Raj1234', 'raj123@gmail.com', '$2y$10$OcKdmwAKOEihXBsD98J0vuf2XlfsC3tgml.VQMQaMhy163WXE6uYm', 'RAJ BIRUA', NULL, NULL, NULL, 'AUDITOR', 1, NULL, NULL, 'Active', NULL, '2026-09-21 13:59:29', '2026-09-21 13:59:29', 'sig_1789999169_f0580d0a.jpeg');

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
  `train_no` varchar(50) DEFAULT NULL,
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_vb_chemical_report`
--

INSERT INTO `mcc_vb_chemical_report` (`id`, `parameter_id`, `coach_no`, `qty_used`, `auditor_name`, `station_id`, `token_id`, `report_date`, `created_at`, `updated_at`, `train_no`, `isApproved`, `audit_by`) VALUES
(1, 9, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-545', '2026-09-07', '2026-09-07 14:43:31', '2026-09-07 14:52:54', '12345', 0, NULL),
(2, 10, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-545', '2026-09-07', '2026-09-07 14:43:31', '2026-09-07 14:52:54', '12345', 0, NULL),
(3, 11, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-545', '2026-09-07', '2026-09-07 14:43:31', '2026-09-07 14:52:54', '12345', 0, NULL),
(4, 12, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-545', '2026-09-07', '2026-09-07 14:43:31', '2026-09-07 14:52:54', '12345', 0, NULL),
(5, 13, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-545', '2026-09-07', '2026-09-07 14:43:31', '2026-09-07 14:52:54', '12345', 0, NULL),
(6, 14, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-545', '2026-09-07', '2026-09-07 14:43:31', '2026-09-07 14:52:54', '12345', 0, NULL),
(7, 15, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-545', '2026-09-07', '2026-09-07 14:43:31', '2026-09-07 14:52:54', '12345', 0, NULL),
(8, 16, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-545', '2026-09-07', '2026-09-07 14:43:31', '2026-09-07 14:52:54', '12345', 0, NULL),
(9, 9, '1111', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:50:42', '12345', 0, NULL),
(10, 10, '1111', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:50:42', '12345', 0, NULL),
(11, 11, '1111', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:50:42', '12345', 0, NULL),
(12, 12, '1111', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:50:42', '12345', 0, NULL),
(13, 13, '1111', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:50:42', '12345', 0, NULL),
(14, 14, '1111', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:50:42', '12345', 0, NULL),
(15, 15, '1111', 5.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:50:42', '12345', 0, NULL),
(16, 16, '1111', 2.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:50:42', '12345', 0, NULL),
(17, 9, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:08', '12345', 0, NULL),
(18, 10, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:08', '12345', 0, NULL),
(19, 11, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:08', '12345', 0, NULL),
(20, 12, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:08', '12345', 0, NULL),
(21, 13, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:08', '12345', 0, NULL),
(22, 14, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:08', '12345', 0, NULL),
(23, 15, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:08', '12345', 0, NULL),
(24, 16, '2222', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:08', '12345', 0, NULL),
(25, 9, '3322', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:14', '12345', 0, NULL),
(26, 10, '3322', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:14', '12345', 0, NULL),
(27, 11, '3322', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:14', '12345', 0, NULL),
(28, 12, '3322', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:14', '12345', 0, NULL),
(29, 13, '3322', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:14', '12345', 0, NULL),
(30, 14, '3322', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:14', '12345', 0, NULL),
(31, 15, '3322', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:14', '12345', 0, NULL),
(32, 16, '3322', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:14', '12345', 0, NULL),
(33, 9, '4324', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:19', '12345', 0, NULL),
(34, 10, '4324', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:19', '12345', 0, NULL),
(35, 11, '4324', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:19', '12345', 0, NULL),
(36, 12, '4324', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:19', '12345', 0, NULL),
(37, 13, '4324', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:19', '12345', 0, NULL),
(38, 14, '4324', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:19', '12345', 0, NULL),
(39, 15, '4324', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:19', '12345', 0, NULL),
(40, 16, '4324', 10.00, 'Bheem Chand', 1, 'TKN-20260907-339', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:52:19', '12345', 0, NULL),
(41, 9, '1', NULL, 'Bheem Chand', 1, 'TKN-20260907-817', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', '12345', 0, NULL),
(42, 10, '1', NULL, 'Bheem Chand', 1, 'TKN-20260907-817', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', '12345', 0, NULL),
(43, 11, '1', NULL, 'Bheem Chand', 1, 'TKN-20260907-817', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', '12345', 0, NULL),
(44, 12, '1', NULL, 'Bheem Chand', 1, 'TKN-20260907-817', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', '12345', 0, NULL),
(45, 13, '1', NULL, 'Bheem Chand', 1, 'TKN-20260907-817', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', '12345', 0, NULL),
(46, 14, '1', NULL, 'Bheem Chand', 1, 'TKN-20260907-817', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', '12345', 0, NULL),
(47, 15, '1', NULL, 'Bheem Chand', 1, 'TKN-20260907-817', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', '12345', 0, NULL),
(48, 16, '1', NULL, 'Bheem Chand', 1, 'TKN-20260907-817', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', '12345', 0, NULL),
(49, 9, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(50, 10, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(51, 11, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(52, 12, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(53, 13, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(54, 14, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(55, 15, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(56, 16, '01', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(57, 9, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(58, 10, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(59, 11, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(60, 12, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(61, 13, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(62, 14, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(63, 15, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(64, 16, '02', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(65, 9, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(66, 10, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(67, 11, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(68, 12, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(69, 13, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(70, 14, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(71, 15, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(72, 16, '03', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(73, 9, '04', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(74, 10, '04', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(75, 11, '04', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(76, 12, '04', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(77, 13, '04', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(78, 14, '04', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(79, 15, '04', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(80, 16, '04', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(81, 9, '05', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(82, 10, '05', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(83, 11, '05', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(84, 12, '05', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(85, 13, '05', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(86, 14, '05', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(87, 15, '05', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(88, 16, '05', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(89, 9, '06', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(90, 10, '06', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(91, 11, '06', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(92, 12, '06', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(93, 13, '06', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(94, 14, '06', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(95, 15, '06', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(96, 16, '06', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(97, 9, '07', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(98, 10, '07', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(99, 11, '07', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(100, 12, '07', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(101, 13, '07', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(102, 14, '07', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(103, 15, '07', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(104, 16, '07', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(105, 9, '08', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(106, 10, '08', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(107, 11, '08', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(108, 12, '08', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(109, 13, '08', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(110, 14, '08', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(111, 15, '08', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(112, 16, '08', NULL, 'Bheem Chand', 1, 'TKN-20260908-956', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:11', '22063', 0, NULL),
(113, 9, '01', 20.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:30', '20608', 0, NULL),
(114, 10, '01', 25.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:30', '20608', 0, NULL),
(115, 11, '01', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:30', '20608', 0, NULL),
(116, 12, '01', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:30', '20608', 0, NULL),
(117, 13, '01', 30.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:30', '20608', 0, NULL),
(118, 14, '01', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:30', '20608', 0, NULL),
(119, 15, '01', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:30', '20608', 0, NULL),
(120, 16, '01', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:30', '20608', 0, NULL),
(121, 9, '02', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:33', '20608', 0, NULL),
(122, 10, '02', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:33', '20608', 0, NULL),
(123, 11, '02', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:33', '20608', 0, NULL),
(124, 12, '02', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:33', '20608', 0, NULL),
(125, 13, '02', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:33', '20608', 0, NULL),
(126, 14, '02', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:33', '20608', 0, NULL),
(127, 15, '02', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:33', '20608', 0, NULL),
(128, 16, '02', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:33', '20608', 0, NULL),
(129, 9, '03', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:42', '20608', 0, NULL),
(130, 10, '03', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:42', '20608', 0, NULL),
(131, 11, '03', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:42', '20608', 0, NULL),
(132, 12, '03', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:42', '20608', 0, NULL),
(133, 13, '03', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:42', '20608', 0, NULL),
(134, 14, '03', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:42', '20608', 0, NULL),
(135, 15, '03', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:42', '20608', 0, NULL),
(136, 16, '03', 30.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:42', '20608', 0, NULL),
(137, 9, '04', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:45', '20608', 0, NULL),
(138, 10, '04', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:45', '20608', 0, NULL),
(139, 11, '04', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:45', '20608', 0, NULL),
(140, 12, '04', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:45', '20608', 0, NULL),
(141, 13, '04', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:45', '20608', 0, NULL),
(142, 14, '04', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:45', '20608', 0, NULL),
(143, 15, '04', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:45', '20608', 0, NULL),
(144, 16, '04', 10.00, 'Hema', 1, 'TKN-20260909-814', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:54:45', '20608', 0, NULL);

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
  `auditor_name` varchar(150) DEFAULT NULL,
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_vb_machine_report`
--

INSERT INTO `mcc_vb_machine_report` (`id`, `parameter_id`, `shift_id`, `used_status`, `token_id`, `station_id`, `report_date`, `created_at`, `updated_at`, `auditor_name`, `isApproved`, `audit_by`) VALUES
(1, 16, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand', 0, NULL),
(2, 17, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand', 0, NULL),
(3, 18, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand', 0, NULL),
(4, 19, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand', 0, NULL),
(5, 20, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand', 0, NULL),
(6, 21, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand', 0, NULL),
(7, 22, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand', 0, NULL),
(8, 23, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand', 0, NULL),
(9, 24, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand', 0, NULL),
(10, 25, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand', 0, NULL),
(11, 26, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand', 0, NULL),
(12, 27, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand', 0, NULL),
(13, 28, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand', 0, NULL),
(14, 29, 4, 'N', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand', 0, NULL),
(15, 30, 4, 'Y', 'TKN-MCH-20260907-4-7883', 1, '2026-09-07', '2026-09-07 14:53:19', '2026-09-07 14:53:19', 'Bheem Chand', 0, NULL),
(16, 16, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand', 0, NULL),
(17, 17, 5, 'N', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand', 0, NULL),
(18, 18, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand', 0, NULL),
(19, 19, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand', 0, NULL),
(20, 20, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand', 0, NULL),
(21, 21, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand', 0, NULL),
(22, 22, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand', 0, NULL),
(23, 23, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand', 0, NULL),
(24, 24, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand', 0, NULL),
(25, 25, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand', 0, NULL),
(26, 26, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand', 0, NULL),
(27, 27, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand', 0, NULL),
(28, 28, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand', 0, NULL),
(29, 29, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand', 0, NULL),
(30, 30, 5, 'Y', 'TKN-MCH-20260907-5-9917', 1, '2026-09-07', '2026-09-07 14:53:26', '2026-09-07 14:53:26', 'Bheem Chand', 0, NULL),
(31, 16, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand', 0, NULL),
(32, 17, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand', 0, NULL),
(33, 18, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand', 0, NULL),
(34, 19, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand', 0, NULL),
(35, 20, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand', 0, NULL),
(36, 21, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand', 0, NULL),
(37, 22, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand', 0, NULL),
(38, 23, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand', 0, NULL),
(39, 24, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand', 0, NULL),
(40, 25, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand', 0, NULL),
(41, 26, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand', 0, NULL),
(42, 27, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand', 0, NULL),
(43, 28, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand', 0, NULL),
(44, 29, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand', 0, NULL),
(45, 30, 6, 'Y', 'TKN-MCH-20260907-6-3698', 1, '2026-09-07', '2026-09-07 14:53:38', '2026-09-07 14:53:38', 'Bheem Chand', 0, NULL);

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
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `isApproved` tinyint(1) NOT NULL DEFAULT 0,
  `audit_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mcc_vb_scorecard_report`
--

INSERT INTO `mcc_vb_scorecard_report` (`id`, `sub_parameter_id`, `station_id`, `token_id`, `train_no`, `coach_no`, `score_value`, `auditor_name`, `report_date`, `created_at`, `updated_at`, `isApproved`, `audit_by`) VALUES
(6, 7, 1, 'TKN-20260907-339', '12345', '1111', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:44:48', 0, NULL),
(7, 8, 1, 'TKN-20260907-339', '12345', '1111', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:44:48', 0, NULL),
(8, 9, 1, 'TKN-20260907-339', '12345', '1111', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:44:48', 0, NULL),
(9, 10, 1, 'TKN-20260907-339', '12345', '1111', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:44:48', 0, NULL),
(10, 12, 1, 'TKN-20260907-339', '12345', '1111', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:44:51', 0, NULL),
(11, 7, 1, 'TKN-20260907-339', '12345', '2222', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:44:58', 0, NULL),
(12, 8, 1, 'TKN-20260907-339', '12345', '2222', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:44:58', 0, NULL),
(13, 9, 1, 'TKN-20260907-339', '12345', '2222', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:44:58', 0, NULL),
(14, 10, 1, 'TKN-20260907-339', '12345', '2222', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:44:58', 0, NULL),
(15, 12, 1, 'TKN-20260907-339', '12345', '2222', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:03', 0, NULL),
(16, 7, 1, 'TKN-20260907-339', '12345', '3322', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:17', 0, NULL),
(17, 8, 1, 'TKN-20260907-339', '12345', '3322', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:17', 0, NULL),
(18, 9, 1, 'TKN-20260907-339', '12345', '3322', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:17', 0, NULL),
(19, 10, 1, 'TKN-20260907-339', '12345', '3322', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:17', 0, NULL),
(20, 12, 1, 'TKN-20260907-339', '12345', '3322', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:21', 0, NULL),
(21, 7, 1, 'TKN-20260907-339', '12345', '4324', '1', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:38', 0, NULL),
(22, 8, 1, 'TKN-20260907-339', '12345', '4324', '2', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:38', 0, NULL),
(23, 9, 1, 'TKN-20260907-339', '12345', '4324', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:38', 0, NULL),
(24, 10, 1, 'TKN-20260907-339', '12345', '4324', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:38', 0, NULL),
(25, 12, 1, 'TKN-20260907-339', '12345', '4324', '3', 'Bheem Chand', '2026-09-07', '2026-09-07 14:44:42', '2026-09-07 14:45:45', 0, NULL),
(26, 7, 1, 'TKN-20260907-817', '12345', '1', '', 'Bheem Chand', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', 0, NULL),
(27, 8, 1, 'TKN-20260907-817', '12345', '1', '', 'Bheem Chand', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', 0, NULL),
(28, 9, 1, 'TKN-20260907-817', '12345', '1', '', 'Bheem Chand', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', 0, NULL),
(29, 10, 1, 'TKN-20260907-817', '12345', '1', '', 'Bheem Chand', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', 0, NULL),
(30, 12, 1, 'TKN-20260907-817', '12345', '1', '', 'Bheem Chand', '2026-09-07', '2026-09-07 15:07:03', '2026-09-07 15:07:03', 0, NULL),
(31, 7, 1, 'TKN-20260908-956', '22063', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:16', 0, NULL),
(32, 8, 1, 'TKN-20260908-956', '22063', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:16', 0, NULL),
(33, 9, 1, 'TKN-20260908-956', '22063', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:16', 0, NULL),
(34, 10, 1, 'TKN-20260908-956', '22063', '01', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:16', 0, NULL),
(35, 12, 1, 'TKN-20260908-956', '22063', '01', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:19', 0, NULL),
(36, 7, 1, 'TKN-20260908-956', '22063', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:41', 0, NULL),
(37, 8, 1, 'TKN-20260908-956', '22063', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:41', 0, NULL),
(38, 9, 1, 'TKN-20260908-956', '22063', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:41', 0, NULL),
(39, 10, 1, 'TKN-20260908-956', '22063', '02', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:41', 0, NULL),
(40, 12, 1, 'TKN-20260908-956', '22063', '02', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:45', 0, NULL),
(41, 7, 1, 'TKN-20260908-956', '22063', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:52', 0, NULL),
(42, 8, 1, 'TKN-20260908-956', '22063', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:52', 0, NULL),
(43, 9, 1, 'TKN-20260908-956', '22063', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:52', 0, NULL),
(44, 10, 1, 'TKN-20260908-956', '22063', '03', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:52', 0, NULL),
(45, 12, 1, 'TKN-20260908-956', '22063', '03', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:24:55', 0, NULL),
(46, 7, 1, 'TKN-20260908-956', '22063', '04', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:04', 0, NULL),
(47, 8, 1, 'TKN-20260908-956', '22063', '04', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:04', 0, NULL),
(48, 9, 1, 'TKN-20260908-956', '22063', '04', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:04', 0, NULL),
(49, 10, 1, 'TKN-20260908-956', '22063', '04', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:04', 0, NULL),
(50, 12, 1, 'TKN-20260908-956', '22063', '04', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:09', 0, NULL),
(51, 7, 1, 'TKN-20260908-956', '22063', '05', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:22', 0, NULL),
(52, 8, 1, 'TKN-20260908-956', '22063', '05', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:22', 0, NULL),
(53, 9, 1, 'TKN-20260908-956', '22063', '05', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:22', 0, NULL),
(54, 10, 1, 'TKN-20260908-956', '22063', '05', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:22', 0, NULL),
(55, 12, 1, 'TKN-20260908-956', '22063', '05', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:28', 0, NULL),
(56, 7, 1, 'TKN-20260908-956', '22063', '06', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:35', 0, NULL),
(57, 8, 1, 'TKN-20260908-956', '22063', '06', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:35', 0, NULL),
(58, 9, 1, 'TKN-20260908-956', '22063', '06', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:35', 0, NULL),
(59, 10, 1, 'TKN-20260908-956', '22063', '06', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:35', 0, NULL),
(60, 12, 1, 'TKN-20260908-956', '22063', '06', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:39', 0, NULL),
(61, 7, 1, 'TKN-20260908-956', '22063', '07', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:48', 0, NULL),
(62, 8, 1, 'TKN-20260908-956', '22063', '07', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:48', 0, NULL),
(63, 9, 1, 'TKN-20260908-956', '22063', '07', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:48', 0, NULL),
(64, 10, 1, 'TKN-20260908-956', '22063', '07', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:48', 0, NULL),
(65, 12, 1, 'TKN-20260908-956', '22063', '07', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:51', 0, NULL),
(66, 7, 1, 'TKN-20260908-956', '22063', '08', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:59', 0, NULL),
(67, 8, 1, 'TKN-20260908-956', '22063', '08', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:59', 0, NULL),
(68, 9, 1, 'TKN-20260908-956', '22063', '08', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:59', 0, NULL),
(69, 10, 1, 'TKN-20260908-956', '22063', '08', '3', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:25:59', 0, NULL),
(70, 12, 1, 'TKN-20260908-956', '22063', '08', 'Y', 'Bheem Chand', '2026-09-08', '2026-09-08 13:24:11', '2026-09-08 13:26:04', 0, NULL),
(71, 7, 1, 'TKN-20260909-814', '20608', '01', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:30', 0, NULL),
(72, 8, 1, 'TKN-20260909-814', '20608', '01', '2', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:30', 0, NULL),
(73, 9, 1, 'TKN-20260909-814', '20608', '01', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:30', 0, NULL),
(74, 10, 1, 'TKN-20260909-814', '20608', '01', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:30', 0, NULL),
(75, 12, 1, 'TKN-20260909-814', '20608', '01', 'Y', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:33', 0, NULL),
(76, 7, 1, 'TKN-20260909-814', '20608', '02', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:39', 0, NULL),
(77, 8, 1, 'TKN-20260909-814', '20608', '02', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:39', 0, NULL),
(78, 9, 1, 'TKN-20260909-814', '20608', '02', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:39', 0, NULL),
(79, 10, 1, 'TKN-20260909-814', '20608', '02', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:39', 0, NULL),
(80, 12, 1, 'TKN-20260909-814', '20608', '02', 'Y', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:42', 0, NULL),
(81, 7, 1, 'TKN-20260909-814', '20608', '03', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:47', 0, NULL),
(82, 8, 1, 'TKN-20260909-814', '20608', '03', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:47', 0, NULL),
(83, 9, 1, 'TKN-20260909-814', '20608', '03', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:47', 0, NULL),
(84, 10, 1, 'TKN-20260909-814', '20608', '03', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:47', 0, NULL),
(85, 12, 1, 'TKN-20260909-814', '20608', '03', 'Y', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:50', 0, NULL),
(86, 7, 1, 'TKN-20260909-814', '20608', '04', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:56', 0, NULL),
(87, 8, 1, 'TKN-20260909-814', '20608', '04', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:56', 0, NULL),
(88, 9, 1, 'TKN-20260909-814', '20608', '04', '3', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:56', 0, NULL),
(89, 10, 1, 'TKN-20260909-814', '20608', '04', '2', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:56', 0, NULL),
(90, 12, 1, 'TKN-20260909-814', '20608', '04', 'Y', 'Hema', '2026-09-09', '2026-09-09 07:53:23', '2026-09-09 07:53:59', 0, NULL);

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
-- Indexes for table `mcc_coaches`
--
ALTER TABLE `mcc_coaches`
  ADD PRIMARY KEY (`coach_id`),
  ADD UNIQUE KEY `uk_train_coach` (`train_id`,`coach_no`),
  ADD KEY `idx_coach_train` (`train_id`),
  ADD KEY `idx_coach_no` (`coach_no`);

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
-- Indexes for table `mcc_trains`
--
ALTER TABLE `mcc_trains`
  ADD PRIMARY KEY (`train_id`),
  ADD UNIQUE KEY `uk_train_station` (`train_no`,`station_id`),
  ADD KEY `idx_train_no` (`train_no`),
  ADD KEY `idx_train_station` (`station_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT for table `dc_mcc_shifts`
--
ALTER TABLE `dc_mcc_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `inventory_audit`
--
ALTER TABLE `inventory_audit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `inventory_entries`
--
ALTER TABLE `inventory_entries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `inventory_materials`
--
ALTER TABLE `inventory_materials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

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
-- AUTO_INCREMENT for table `mcc_coaches`
--
ALTER TABLE `mcc_coaches`
  MODIFY `coach_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=326;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `mcc_intensive_scorecard_sub_param`
--
ALTER TABLE `mcc_intensive_scorecard_sub_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `mcc_manpower_categories`
--
ALTER TABLE `mcc_manpower_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `mcc_manpower_log`
--
ALTER TABLE `mcc_manpower_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `mcc_manpower_penalties`
--
ALTER TABLE `mcc_manpower_penalties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `mcc_manpower_shifts`
--
ALTER TABLE `mcc_manpower_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `mcc_manpower_shift_type_map`
--
ALTER TABLE `mcc_manpower_shift_type_map`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=147;

--
-- AUTO_INCREMENT for table `mcc_manpower_targets`
--
ALTER TABLE `mcc_manpower_targets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `mcc_manpower_types`
--
ALTER TABLE `mcc_manpower_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `mcc_normal_chemical_param`
--
ALTER TABLE `mcc_normal_chemical_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `mcc_normal_chemical_report`
--
ALTER TABLE `mcc_normal_chemical_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=713;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=226;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=535;

--
-- AUTO_INCREMENT for table `mcc_normal_scorecard_sub_param`
--
ALTER TABLE `mcc_normal_scorecard_sub_param`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=449;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=385;

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
-- AUTO_INCREMENT for table `mcc_trains`
--
ALTER TABLE `mcc_trains`
  MODIFY `train_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `mcc_users`
--
ALTER TABLE `mcc_users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

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
-- Constraints for table `mcc_coaches`
--
ALTER TABLE `mcc_coaches`
  ADD CONSTRAINT `mcc_coaches_fk_train` FOREIGN KEY (`train_id`) REFERENCES `mcc_trains` (`train_id`) ON DELETE CASCADE;

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
-- Constraints for table `mcc_trains`
--
ALTER TABLE `mcc_trains`
  ADD CONSTRAINT `mcc_trains_fk_station` FOREIGN KEY (`station_id`) REFERENCES `mcc_stations` (`station_id`) ON DELETE CASCADE;

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
