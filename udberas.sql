-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 12, 2020 at 09:10 PM
-- Server version: 10.3.22-MariaDB-1
-- PHP Version: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `udberas`
--

-- --------------------------------------------------------

--
-- Table structure for table `penjualandetail`
--

CREATE TABLE `penjualandetail` (
  `RowID` varchar(255) NOT NULL,
  `HeaderID` varchar(255) NOT NULL,
  `KodeItem` varchar(15) NOT NULL,
  `NamaItem` varchar(255) NOT NULL,
  `QtyJual` decimal(16,2) NOT NULL,
  `HargaJual` double(16,2) NOT NULL,
  `Createdby` varchar(255) NOT NULL,
  `Createdon` datetime(6) NOT NULL  ON UPDATE current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `penjualandetail`
--

INSERT INTO `penjualandetail` (`RowID`, `HeaderID`, `KodeItem`, `NamaItem`, `QtyJual`, `HargaJual`, `Createdby`, `Createdon`) VALUES
('3041ead2-d9e6-4fe3-b159-3ca177c745a7', '420934da-bae8-4064-836e-87b9b9768b3a', '100.0002', 'Beras C4 10KG', '2.00', 4000.00, 'admin', '2020-07-11 06:58:18.000000'),
('4138907f-db62-410c-99a8-e6f4c8b61b9d', '136012bf-e3ef-437a-8a32-770d89e3a93e', '100.0002', 'Beras C4 10KG', '1.00', 4000.00, 'admin', '2020-07-11 06:55:34.000000'),
('4fcaf114-ad3e-4f4e-ac36-c6c0db89c80c', '87e5947f-095d-4fa7-94cb-178a6f116f7a', '100.0001', 'Beras C4 5KG', '2.00', 4000.00, 'admin', '2020-07-11 06:46:38.000000'),
('67f2d652-b01b-48bb-9618-863d9228748b', '92852aec-a7bc-44ab-8a87-50c3215c6109', '100.0001', 'Beras C4 5KG', '1.00', 4000.00, 'admin', '2020-07-11 06:56:52.000000'),
('874f3297-ee2a-404d-92de-2d20d59a704e', '136012bf-e3ef-437a-8a32-770d89e3a93e', '100.0001', 'Beras C4 5KG', '2.00', 4500.00, 'admin', '2020-07-11 06:55:34.000000'),
('978101b9-8177-4e0d-892e-3cd33ccf06a3', 'd07d769f-0a2a-4452-aaf4-3b1614ea231f', '100.0002', 'Beras C4 10KG', '2.00', 3000.00, 'admin', '2020-07-11 06:49:47.000000'),
('97adf0f4-6a3e-4b08-a233-b51ebedf0979', 'dfd4bcd0-c8f6-482d-9e40-930d088a78b1', '100.0001', 'Beras C4 5KG', '2.00', 4000.00, 'admin', '2020-07-11 06:53:44.000000'),
('a59f5626-eb3f-4e8f-baa0-a8a9ab7b36f6', 'd07d769f-0a2a-4452-aaf4-3b1614ea231f', '100.0001', 'Beras C4 5KG', '2.00', 4000.00, 'admin', '2020-07-11 06:49:47.000000'),
('aa05440f-9e60-4118-80fa-94e5619383f6', '71e38865-e83f-44b2-b130-258f139946e3', '100.0002', 'Beras C4 10KG', '1.00', 4000.00, 'admin', '2020-07-11 06:48:23.000000'),
('b8a51941-22a6-4367-bc74-917cd68679d9', '92852aec-a7bc-44ab-8a87-50c3215c6109', '100.0002', 'Beras C4 10KG', '2.00', 4500.00, 'admin', '2020-07-11 06:56:52.000000'),
('d82efe57-d46e-4f87-8d4e-37637f61c953', 'dfd4bcd0-c8f6-482d-9e40-930d088a78b1', '100.0002', 'Beras C4 10KG', '1.00', 4500.00, 'admin', '2020-07-11 06:53:44.000000'),
('df947814-7c0d-4fee-bcd2-587e3d344caa', '71e38865-e83f-44b2-b130-258f139946e3', '100.0001', 'Beras C4 5KG', '2.00', 4500.00, 'admin', '2020-07-11 06:48:23.000000'),
('f4423457-954b-4883-bb4f-41b5160bdf4d', '87e5947f-095d-4fa7-94cb-178a6f116f7a', '100.0002', 'Beras C4 10KG', '1.00', 4500.00, 'admin', '2020-07-11 06:46:38.000000'),
('fafe08bd-8aca-4733-ba8d-96d729993adb', '420934da-bae8-4064-836e-87b9b9768b3a', '100.0001', 'Beras C4 5KG', '1.00', 4500.00, 'admin', '2020-07-11 06:58:18.000000'),
('ffe8621d-6e15-4a34-a263-769500a353bf', '7d28b9eb-d868-4468-ad40-8b80f93d64eb', '100.0001', 'Beras C4 5KG', '1.00', 4500.00, 'admin', '2020-07-11 06:45:37.000000');

-- --------------------------------------------------------

--
-- Table structure for table `penjualanheader`
--

CREATE TABLE `penjualanheader` (
  `RowID` varchar(255) NOT NULL,
  `NoTransaksi` varchar(50) NOT NULL,
  `TglTransaksi` datetime(6) NOT NULL,
  `KodeCustomer` varchar(15) NOT NULL,
  `CustomerSource` int(11) NOT NULL,
  `printed` bit(1) NOT NULL DEFAULT b'0',
  `Status` int(11) NOT NULL COMMENT '1: Ordered, 2: DiProses, 3: Dikirim, 4: Selesai, 5: Cancel',
  `Createdby` varchar(255) NOT NULL,
  `Createdon` datetime(6) NOT NULL  ON UPDATE current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `penjualanheader`
--

INSERT INTO `penjualanheader` (`RowID`, `NoTransaksi`, `TglTransaksi`, `KodeCustomer`, `CustomerSource`, `printed`, `Status`, `Createdby`, `Createdon`) VALUES
('136012bf-e3ef-437a-8a32-770d89e3a93e', '1202060006', '2020-07-11 00:00:00.000000', 'CL0001 ', 1, b'0', 1, 'admin', '2020-07-11 06:55:34.000000'),
('420934da-bae8-4064-836e-87b9b9768b3a', '1202060008', '2020-07-11 00:00:00.000000', 'CL0001 ', 1, b'0', 1, 'admin', '2020-07-11 06:58:18.000000'),
('71e38865-e83f-44b2-b130-258f139946e3', '1202060003', '2020-07-11 00:00:00.000000', 'CL0001 ', 1, b'0', 1, 'admin', '2020-07-11 06:48:23.000000'),
('7d28b9eb-d868-4468-ad40-8b80f93d64eb', '1202060001', '2020-07-11 00:00:00.000000', '', 1, b'0', 1, 'admin', '2020-07-11 06:45:37.000000'),
('87e5947f-095d-4fa7-94cb-178a6f116f7a', '1202060002', '2020-07-11 00:00:00.000000', 'CL0001 ', 1, b'0', 1, 'admin', '2020-07-11 06:46:38.000000'),
('92852aec-a7bc-44ab-8a87-50c3215c6109', '1202060007', '2020-07-11 00:00:00.000000', 'CL0001 ', 1, b'0', 1, 'admin', '2020-07-11 06:56:52.000000'),
('d07d769f-0a2a-4452-aaf4-3b1614ea231f', '1202060004', '2020-07-11 00:00:00.000000', 'CL0001 ', 1, b'0', 1, 'admin', '2020-07-11 06:49:47.000000'),
('dfd4bcd0-c8f6-482d-9e40-930d088a78b1', '1202060005', '2020-07-11 00:00:00.000000', 'CL0001 ', 1, b'0', 1, 'admin', '2020-07-11 06:53:44.000000');

-- --------------------------------------------------------

--
-- Table structure for table `permission`
--

CREATE TABLE `permission` (
  `id` int(11) NOT NULL,
  `permissionname` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `ico` varchar(255) DEFAULT NULL,
  `menusubmenu` varchar(255) DEFAULT NULL,
  `multilevel` bit(1) DEFAULT NULL,
  `separator` bit(1) DEFAULT NULL,
  `order` int(255) DEFAULT NULL,
  `status` bit(1) DEFAULT NULL,
  `AllowMobile` bit(1) DEFAULT NULL,
  `MobileRoute` varchar(255) DEFAULT NULL,
  `MobileLogo` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `permission`
--

INSERT INTO `permission` (`id`, `permissionname`, `link`, `ico`, `menusubmenu`, `multilevel`, `separator`, `order`, `status`, `AllowMobile`, `MobileRoute`, `MobileLogo`) VALUES
(1, 'Master', NULL, 'icon-briefcase\n', '0', b'1', b'0', 0, b'1', NULL, NULL, NULL),
(2, 'Master Item', 'item', NULL, '1', b'1', b'0', 1, b'1', NULL, NULL, NULL),
(3, 'Master Pelanggan', 'customer', NULL, '1', b'1', b'0', 2, b'1', NULL, NULL, NULL),
(4, 'User', NULL, NULL, '1', b'1', b'0', 3, b'1', NULL, NULL, NULL),
(5, 'Transaksi', NULL, 'icon-pencil', '0', b'1', b'0', 10, b'1', NULL, NULL, NULL),
(6, 'Penjualan', 'penjualan', NULL, '5', b'1', b'0', 11, b'1', NULL, NULL, NULL),
(7, 'Pembelian', NULL, NULL, '5', b'1', b'0', 12, b'1', NULL, NULL, NULL),
(8, 'Produksi', NULL, NULL, '5', b'1', b'0', 13, b'1', NULL, NULL, NULL),
(9, 'Informasi', NULL, 'icon-info-sign', '0', b'1', b'1', 20, b'1', NULL, NULL, NULL),
(10, 'Stock Beras', NULL, NULL, '9', b'1', b'1', 21, b'1', NULL, NULL, NULL),
(11, 'Laporan', NULL, 'icon-paper-clip', '0', b'1', b'1', 25, b'1', NULL, NULL, NULL),
(12, 'Persediaan Beras', NULL, NULL, '11', b'1', b'1', 26, b'1', NULL, NULL, NULL),
(13, 'Penjualan', NULL, NULL, '11', b'1', b'1', 27, b'1', NULL, NULL, NULL),
(14, 'Pembelian', NULL, NULL, '11', b'1', b'1', 28, b'1', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `permissionrole`
--

CREATE TABLE `permissionrole` (
  `roleid` int(11) NOT NULL,
  `permissionid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `permissionrole`
--

INSERT INTO `permissionrole` (`roleid`, `permissionid`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `rolename` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `rolename`) VALUES
(1, 'SU'),
(2, 'Admin'),
(3, 'Pemilik'),
(4, 'Pembeli'),
(5, 'Gudang'),
(6, 'Produksi');

-- --------------------------------------------------------

--
-- Table structure for table `tcustomer`
--

CREATE TABLE `tcustomer` (
  `id` int(11) NOT NULL,
  `KodeCustomer` varchar(15) NOT NULL,
  `NamaCustomer` varchar(50) NOT NULL,
  `AlamatCustomer` varchar(255) NOT NULL,
  `NoTlp` varchar(15) NOT NULL,
  `Source` int(11) NOT NULL COMMENT '1: append, 2 : ecomers',
  `Createdby` varchar(255) NOT NULL,
  `Createdon` datetime(6) NOT NULL  ON UPDATE current_timestamp(6),
  `isActive` bit(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `tcustomer`
--

INSERT INTO `tcustomer` (`id`, `KodeCustomer`, `NamaCustomer`, `AlamatCustomer`, `NoTlp`, `Source`, `Createdby`, `Createdon`, `isActive`) VALUES
(1, 'CL0001', 'Solo Beras', 'Solo Surakarta 2', '081325058258', 1, 'admin', '2020-07-09 15:16:17.789027', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `titem`
--

CREATE TABLE `titem` (
  `ItemCode` varchar(15) NOT NULL,
  `ItemName` varchar(255) NOT NULL,
  `ItemGroup` int(11) NOT NULL DEFAULT 1,
  `Createdby` varchar(255) NOT NULL,
  `Createdon` datetime(6) NOT NULL  ON UPDATE current_timestamp(6),
  `isActive` bit(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `titem`
--

INSERT INTO `titem` (`ItemCode`, `ItemName`, `ItemGroup`, `Createdby`, `Createdon`, `isActive`) VALUES
('100.0001', 'Beras C4 5KG', 1, 'admin', '2020-07-09 11:25:25.000000', b'1'),
('100.0002', 'Beras C4 10KG', 1, 'admin', '2020-07-09 15:16:22.663676', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `transactionStatus`
--

CREATE TABLE `transactionStatus` (
  `id` int(11) NOT NULL,
  `NoTransaksi` varchar(50) NOT NULL,
  `TanggalPencatatan` datetime NOT NULL,
  `Status` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `userrole`
--

CREATE TABLE `userrole` (
  `userid` int(11) NOT NULL,
  `roleid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `userrole`
--

INSERT INTO `userrole` (`userid`, `roleid`) VALUES
(14, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(75) DEFAULT NULL,
  `nama` varchar(75) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `createdon` datetime DEFAULT NULL,
  `HakAkses` int(255) DEFAULT NULL COMMENT '1: admin,2: guru, 3 : murid',
  `token` varchar(255) DEFAULT NULL,
  `verified` bit(1) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `browser` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `nama`, `password`, `createdby`, `createdon`, `HakAkses`, `token`, `verified`, `ip`, `browser`, `email`, `phone`) VALUES
(14, 'admin', 'admin', '440308e0a299d722ebc5a9459a56d27adffc7ad28688d4471fdc1c7a8324f9a5cabdcd25bae8fe71b65837f6dd33fd1a9187ff4e2b2fea10e88289b70fdb79a221Nz7VN+sVNcNv1J/4lhqE9nfn5cpZTw8zhp2ge4pY0=', 'mnl', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL),
(43, 'operator', 'Operator', 'a9bdd47d7321d4089b3b00561c9c621848bd6f6e2f745a53d54913d613789c23945b66de6ded1eb336a7d526f9349a9d964d6f6c3a40e2ac90b4b16c0121f7895Xg53McbkyQ/NmW60Sf4cu3wJsi/8cyZXxeXV7g6b04=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(71, '1001', 'Prasetyo Aji Wibowo', 'c637abd9352a25c922463f7acc7b3a5f9328eba06ed17e6572a23b8cbdabb0a3c131c304d92c3b144077d08b83bea24e8523995d9e0a8d3c059c89d3526ea8f8HAx07QI6q7vgVWvh8bgR0FD4/Nox8aBN/4DFMRh9I9E=', 'admin', '2020-07-03 02:53:26', 2, NULL, NULL, NULL, NULL, NULL, NULL),
(72, '1002', 'Bambang sukiryo', '2fab8327944504c22d9b8c85bc1d2be04ef81e4cb5eaea3ab1cbac561c05442e242fd7df31b5fcf49813aeb94f99a36302de884140b3b15415864a89e0f72a260D9/S7S/r5aU0t6xDZREZyZoTGQwVUccfVKmWIDL6tU=', 'admin', '2020-07-03 02:54:47', 2, NULL, NULL, NULL, NULL, NULL, NULL),
(73, '200001', 'Ridho', '427713375014f3d4686a334f911c8506642bf46124642043eefbd969653e316f9cf05c28fa41663a3aa5981ff00ba80df9665b8d0358e5e2877f7c42470591feQDe7uWIfqSvmee0oAtRUwMHbPxpFETOXeMNK2ww1v0o=', 'admin', '2020-07-03 03:12:46', 3, NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `penjualandetail`
--
ALTER TABLE `penjualandetail`
  ADD PRIMARY KEY (`RowID`) USING BTREE;

--
-- Indexes for table `penjualanheader`
--
ALTER TABLE `penjualanheader`
  ADD PRIMARY KEY (`RowID`) USING BTREE;

--
-- Indexes for table `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `tcustomer`
--
ALTER TABLE `tcustomer`
  ADD PRIMARY KEY (`id`,`KodeCustomer`) USING BTREE;

--
-- Indexes for table `titem`
--
ALTER TABLE `titem`
  ADD PRIMARY KEY (`ItemCode`) USING BTREE;

--
-- Indexes for table `transactionStatus`
--
ALTER TABLE `transactionStatus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userrole`
--
ALTER TABLE `userrole`
  ADD PRIMARY KEY (`userid`) USING BTREE;

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `permission`
--
ALTER TABLE `permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tcustomer`
--
ALTER TABLE `tcustomer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transactionStatus`
--
ALTER TABLE `transactionStatus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
