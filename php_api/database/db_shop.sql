-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 19, 2025 at 08:31 PM
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
(16, 'มานะ', 'ดีใจ', '038743690', 'mana', '$2y$10$a/QExybkIKpUhPKC31565.cGz4HNcneb.iuYfkR/OLHXraAvdK0cO'),
(17, 'มะลิรัตน์', 'คนดี', '038475820', 'mali', '$2y$10$LhcejD2YFJl8nvfsO/1rducc0L1a2gKxJVTPZzpUyzS3JDSKcnlje'),
(18, 'สมหญิง', 'มีใจ', '0817458211', 'som', '$2y$10$CzI.b9IwcXToX.PMCa1.u.bVz.cDO9eG8XigjsNOYHaz3eIeLwN3u'),
(21, 'มานะ', 'เด็กดี', '038756921', 'mana', '1234'),
(22, 'มานี', 'ใจดี', '038756901', 'manee', '1234'),
(23, 'df', 'dsf', 'dfs', 'dfs', '$2y$10$6pbA1vWnJVKM51h2IngWYeIQf3ph6u8xMkzEYfoB2BaPGLP/11eEC'),
(24, 'เมษา', 'เด็กดี', '038742690', 'mesa', '$2y$10$28g5fQI2.CTgVVtKQucPwOkyZy6HTzJNkFU4yJPS8RZVaHYfxpIw6'),
(25, 'sad', 'asd', '23432', 'dsfs', '$2y$10$n.ZXvSqVducEu6mqesHHOOHrcTMsVxdv2z6cNzwLJ6er9CKGYDufO');

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
(1, 'เสื้อยืดคอกลม', 'เสื้อยืดผ้าฝ้าย 100% สวมใส่สบาย', '199.00', 'tshirt.jpg', 50, '2025-09-12 18:09:34'),
(2, 'กางเกงยีนส์', 'กางเกงยีนส์ทรงกระบอก สีฟ้าอ่อน', '799.00', 'jeans.jpg', 30, '2025-09-12 18:09:34'),
(3, 'รองเท้าผ้าใบ', 'รองเท้าผ้าใบสีขาว ใส่ได้ทุกโอกาส', '1299.00', 'sneakers.jpg', 20, '2025-09-12 18:09:34'),
(10, 'สมุดวาดเขียน', 'สมุดใช้ประกอบการวาดรูป', '40.00', '1758305524_p1.jfif', 20, '2025-09-19 18:12:04'),
(11, 'ขายแมวน่ารัก', 'แมวน่ารัก เจ้าของหาย', '990.00', '1758305622_cat.jpg', 20, '2025-09-19 18:13:42'),
(12, 'ert', 'rete', '234.00', '1758305696_cat.jpg', 12, '2025-09-19 18:14:56'),
(13, 'ftgfd', 'fdgd', '435.00', '1758305825_cat.jpg', 3, '2025-09-19 18:17:05'),
(14, 'dsfds', 'dsfds', '234.00', '1758305896_p1.jfif', 12, '2025-09-19 18:18:16'),
(15, 'ขายแมว', 'แมวเจ้าของหาย', '990.00', '1758306111_cat.jpg', 20, '2025-09-19 18:21:51');

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
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

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
