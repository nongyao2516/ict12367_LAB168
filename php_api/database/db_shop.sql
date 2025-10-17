-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 17, 2025 at 08:26 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `firstName`, `lastName`, `phone`, `username`, `password`) VALUES
(17, 'มะลิรัตน์', 'คนดี', '038475820', 'mali', '$2y$10$o/8FCDZ1CFwxno6lnpgdS.jwtTwLIF5Ryaj8ZVF13vqlWsr5iGFJa'),
(18, 'สมหญิง', 'มีใจ', '0817458211', 'som', '$2y$10$4pKBFer4Vdr3x1GISBHVFOnLV6MaJO7FWU4neXE30jLnAoDxWYAiO'),
(21, 'มานะ', 'เด็กดี', '038756921', 'mana', '1234'),
(29, 'วาริน', 'คนดี', '038743951', 'varin', '$2y$10$8jIhK8PVGqoLCRu9OTFx8etO6AOYLyO2/Kblp9ntXizwPvSmwVGKG'),
(30, 'นารารัตน์', 'มีบุญ', '038743690', 'nararat', '$2y$10$hambXhKPkJnnU2uUYsVzbOq6WyUdRZeix/Ag54pX68cbWME0LpNMO');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `employee_id` int(11) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`employee_id`, `firstname`, `lastname`, `username`, `password`, `image`) VALUES
(1, 'John', 'Doe', 'jdoe', 'password123', 'xxx'),
(2, 'Jane', 'Smith', 'jsmith', 'mysecurepassword', 'xxx'),
(3, 'Alice', 'Johnson', 'alicej', 'alicepass456', 'xxx'),
(4, 'Bob', 'Brown', 'bobb', 'bobsecure789', 'xxx');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `emp_id` int(8) UNSIGNED ZEROFILL NOT NULL COMMENT 'รหัสพนักงาน',
  `firstname` varchar(50) NOT NULL COMMENT 'ชื่อ',
  `lastname` varchar(50) NOT NULL COMMENT 'นามสกุล',
  `position` varchar(30) DEFAULT NULL COMMENT 'ตำแหน่ง',
  `salary` int(11) NOT NULL COMMENT 'เงินเดือน'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`emp_id`, `firstname`, `lastname`, `position`, `salary`) VALUES
(00000001, 'สมชาย', 'ใจดี', 'ผู้จัดการฝ่ายบุคคล', 35000),
(00000002, 'วิชัย', 'สุขสม', 'พนักงาน', 18000),
(00000004, 'อนันต์', 'เพชรแท้', 'หัวหน้าแผนกการตลาด', 25000),
(00000005, 'นภาพร', 'บัวงาม', 'พนักงาน', 17000),
(00000007, 'สุวิทย์', 'บุญมาก', 'พนักงาน', 18000);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` text DEFAULT NULL,
  `stock` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `description`, `price`, `image`, `stock`, `created_at`) VALUES
(1, 'เสื้อยืดคอกลม', 'เสื้อยืดผ้าฝ้าย 100% สวมใส่สบาย', '199.00', '1760720091_1758180812_p1.jpg', 50, '2025-09-12 18:09:34'),
(2, 'กางเกงยีนส์', 'กางเกงยีนส์ทรงกระบอก สีฟ้าอ่อน', '799.00', '1760720082_1758077984_p7.jpg', 30, '2025-09-12 18:09:34'),
(3, 'รองเท้าผ้าใบ', 'รองเท้าผ้าใบสีขาว ใส่ได้ทุกโอกาส', '1299.00', '1760720072_1760719501_1758180812_p1.jpg', 20, '2025-09-12 18:09:34'),
(10, 'สมุดวาดเขียน', 'สมุดใช้ประกอบการวาดรูป', '40.00', '1760720053_1758077984_p7.jpg', 20, '2025-09-19 18:12:04'),
(11, 'ขายแมวน่ารัก', 'แมวน่ารัก เจ้าของหาย', '990.00', '1760720043_1758180812_p1.jpg', 20, '2025-09-19 18:13:42'),
(12, 'ert', 'rete', '234.00', '1760720026_1758077915_p6.jpg', 12, '2025-09-19 18:14:56'),
(14, 'ชุดรวมมิตร หมู ผักสด', 'ชุดรวมมิตร หมู ผักสด', '234.00', '1760719501_1758180812_p1.jpg', 12, '2025-09-19 18:18:16');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `first_name`, `last_name`, `email`, `phone`, `created_at`) VALUES
(1, 'Somchai', 'Sukjai', 'somchai@example.com', '0811111111', '2025-09-16 22:56:22'),
(2, 'Suda', 'Jaidee', 'suda@example.com', '0822222222', '2025-09-16 22:56:22'),
(3, 'Anan', 'Thongdee', 'anan@example.com', '0833333333', '2025-09-16 22:56:22');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`emp_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `emp_id` int(8) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'รหัสพนักงาน', AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
