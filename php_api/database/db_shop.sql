-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 06, 2025 at 12:34 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

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
(27, 'มานะ', 'ใจดี', '03873690', 'admin', '$2y$10$d/4HczT/3Uy0980sXb0g5ecTbtcxDGcLQatTos6rMsSU3xmt2WoqC'),
(36, 'มานี', 'ดีใจ', '0817542100', 'manee', '$2y$10$uSY7ZBo02Bhc9KDG0CFdG.NXVcDv69ZIXXG3NSpojVmIPmBoelefK'),
(37, 'มะลิร้ตน์', 'เกิดดี', '038743910', 'mali', '$2y$10$/TqLTTA4/VeGRpoIaWk.M.cETWjs28lCZNupXLePPmwJUbjDBOiq.'),
(38, 'เมษา', 'เด็กดี', '0868597422', 'mesa', '$2y$10$niCoSwaPofJTVjmmHW5pKe8dQp6XuDQZNlpUQoqwkv0PYneNDcaPC'),
(40, 'มานะ ', 'คงดี', '038743690', 'mana', '$2y$10$hM/xfX5avlRmtARCmxh7bOtZ8/ivyR25isNq8A86dWf1AqgW2Kis2');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`employee_id`, `firstname`, `lastname`, `username`, `password`, `image`) VALUES
(1, 'Somchai', 'Prasert', 'admin', '1234', '1762428696_cat2.jfif'),
(2, 'Masa', 'Dekdee', 'mesa', '1234', '1762428686_cat1.jfif');

-- --------------------------------------------------------

--
-- Table structure for table `orderdetails`
--

CREATE TABLE `orderdetails` (
  `order_detail_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `payment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `amount` decimal(10,2) NOT NULL,
  `method` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(8, 'หนังสือ AutoCAD', 'หนังสือวาดแบบ AutoCAD', 280.00, '1762428629_m5.jfif', 20, '2025-09-11 03:36:39'),
(9, 'หมูเนื้อแดงรวมผัก', 'ชุด 1 หมูเนื้อแดงรวมผักสด', 250.00, '1762428619_m1.jfif', 50, '2025-09-17 02:57:35'),
(10, 'ชุด 2 ลูกชิ้น + หมูสามชั้น', 'ชุด 2 ลูกชิ้น + หมูสามชั้น', 199.00, '1762428609_m2.jpg', 20, '2025-09-17 02:58:35'),
(11, 'สันคอหมูรวมผัก', 'ชุด 3 สันคอหมูรวมผัก', 220.00, '1762428601_m3.jfif', 20, '2025-09-17 02:59:44'),
(12, 'การพัฒนาเว็บด้วย HTML', 'หนังสือสอนการพัฒนาเว็บไซต์ด้วย HTML', 299.00, '1762428592_1760502827_p7.jpg', 20, '2025-09-17 04:08:58'),
(13, 'ชาบูน้ำดำ หมู ผักสด', 'ชุด 5 ชาบูน้ำดำ หมู ผักสด', 250.00, '1762428581_1760498908_p6.jpg', 20, '2025-09-17 04:15:07'),
(14, 'ชุดรวมมิตรชาบู', 'รวมมิตร หมู ลูกชิ้น ผักสด', 299.00, '1762428574_m4.jfif', 20, '2025-09-18 07:33:32'),
(15, 'Galaxy Note', 'หนังสือสอนใช้งาน Galaxy Note', 250.00, '1762428566_m1.jfif', 20, '2025-09-18 07:42:25'),
(21, 'แมวน่ารัก1', 'แมวครอบครัวรักแมวมาก1', 5000.00, '1762428550_1760511151_p8.jpg', 5, '2025-10-02 14:44:38');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD PRIMARY KEY (`order_detail_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `orderdetails`
--
ALTER TABLE `orderdetails`
  MODIFY `order_detail_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
