-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 15, 2020 at 08:29 PM
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

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `fn_GetStock`$$
CREATE `fn_GetStock` (IN `KodeItem` VARCHAR(15))  BEGIN
  SELECT 
    a.KodeItem,a.NamaItem,
    SUM(a.QtyBeli) - SUM(a.QtyJual) + SUM(a.QtyHasil) - SUM(a.QtyPemakaian) AS Stock
  FROM (

    SELECT a.KodeItem,a.NamaItem,a.QtyBeli, 0 QtyJual,0 QtyHasil,0 QtyPemakaian FROM pembeliandetail a

    UNION ALL

    SELECT b.KodeItem,b.NamaItem,0 , b.QtyJual ,0 , 0 FROM penjualandetail b

    UNION ALL

    SELECT c.KodeItemFG,c.NamaItemFG,0,0,c.QtyFG,0 FROM hasilproduksi c

    UNION ALL

    SELECT d.KodeItemRM,d.NamaItemRM,0,0,0,d.QtyIssue FROM pemakaianbahan d

  ) a
    WHERE (a.KodeItem = KodeItem OR KodeItem = '')
  GROUP BY a.KodeItem;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `hasilproduksi`
--

DROP TABLE IF EXISTS `hasilproduksi`;
CREATE TABLE `hasilproduksi` (
  `RowID` varchar(255) NOT NULL,
  `NoTransaksi` varchar(50) NOT NULL,
  `TglTransaksi` date NOT NULL,
  `KodeItemFG` varchar(15) NOT NULL,
  `NamaItemFG` varchar(255) NOT NULL,
  `QtyFG` double(16,2) NOT NULL,
  `Createdon` datetime(6) NOT NULL,
  `Createdby` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `hasilproduksi`
--

INSERT INTO `hasilproduksi` (`RowID`, `NoTransaksi`, `TglTransaksi`, `KodeItemFG`, `NamaItemFG`, `QtyFG`, `Createdon`, `Createdby`) VALUES
('a16c9935-f539-4baa-8e0c-f0dcd5b559f8', '3202060001', '2020-07-13', '100.0001 ', ' Beras C4 5KG', 50.00, '2020-07-13 09:44:27.000000', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `pemakaianbahan`
--

DROP TABLE IF EXISTS `pemakaianbahan`;
CREATE TABLE `pemakaianbahan` (
  `RowID` varchar(255) NOT NULL,
  `NoTransaksi` varchar(50) NOT NULL,
  `TglTransaksi` date NOT NULL,
  `KodeItemRM` varchar(25) NOT NULL,
  `NamaItemRM` varchar(255) NOT NULL,
  `QtyIssue` double(16,2) NOT NULL,
  `Createdon` datetime(6) NOT NULL,
  `Createdby` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `pemakaianbahan`
--

INSERT INTO `pemakaianbahan` (`RowID`, `NoTransaksi`, `TglTransaksi`, `KodeItemRM`, `NamaItemRM`, `QtyIssue`, `Createdon`, `Createdby`) VALUES
('36c5610f-7bf7-4943-828f-47fa6816dd40', '3202060001', '2020-07-13', '200.0001', 'Karung ukuran 5kg', 50.00, '2020-07-13 09:44:27.000000', 'admin'),
('7ef5b153-aea0-4363-98b1-ad89b112902b', '3202060001', '2020-07-13', '200.0004', 'Gabah Super', 250.00, '2020-07-13 09:44:27.000000', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `pembeliandetail`
--

DROP TABLE IF EXISTS `pembeliandetail`;
CREATE TABLE `pembeliandetail` (
  `RowID` varchar(255) NOT NULL,
  `HeaderID` varchar(255) NOT NULL,
  `KodeItem` varchar(15) NOT NULL,
  `NamaItem` varchar(255) NOT NULL,
  `QtyBeli` decimal(16,2) NOT NULL,
  `HargaBeli` double(16,2) NOT NULL,
  `Createdby` varchar(255) NOT NULL,
  `Createdon` datetime(6) NOT NULL ON UPDATE current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `pembeliandetail`
--

INSERT INTO `pembeliandetail` (`RowID`, `HeaderID`, `KodeItem`, `NamaItem`, `QtyBeli`, `HargaBeli`, `Createdby`, `Createdon`) VALUES
('2ddad022-94ba-4f07-aba3-3db84aabf23c', 'feebcdbe-d10a-4490-9397-ade021eb0416', '100.0002', 'Beras C4 10KG', '35.00', 3000.00, 'admin', '2020-07-12 10:39:53.000000'),
('5470af5b-af83-415a-99e0-168c98a27f3a', 'feebcdbe-d10a-4490-9397-ade021eb0416', '100.0001', 'Beras C4 5KG', '25.00', 3500.00, 'admin', '2020-07-12 10:39:53.000000'),
('644c9f74-b296-4bdc-8a9b-27ffa61e9058', '53c7fbba-debf-434c-8470-9dca0630d971', '100.0001', 'Beras C4 5KG', '2.00', 4.00, 'admin', '2020-07-13 01:57:54.000000'),
('7b0855ae-8f28-4fe7-8e6c-7349dba2ce8d', 'cdf6200c-10c6-477a-8746-1b123e234e5b', '200.0001', 'Karung ukuran 5kg', '5000.00', 1400.00, 'admin', '2020-07-13 09:05:24.000000'),
('b3d37ec6-69b1-439c-b185-cec52b28b0c9', 'b7631a89-e143-46c0-a94c-7b297e8dd67b', '100.0001', 'Beras C4 5KG', '1.00', 3500.00, 'admin', '2020-07-12 10:39:13.000000'),
('c096633c-9be8-4f83-90fe-f16b1cb6dc6f', 'cdf6200c-10c6-477a-8746-1b123e234e5b', '200.0004', 'Gabah Super', '5000.00', 2500.00, 'admin', '2020-07-13 09:05:24.000000');

-- --------------------------------------------------------

--
-- Table structure for table `pembelianheader`
--

DROP TABLE IF EXISTS `pembelianheader`;
CREATE TABLE `pembelianheader` (
  `RowID` varchar(255) NOT NULL,
  `NoTransaksi` varchar(50) NOT NULL,
  `TglTransaksi` datetime(6) NOT NULL,
  `KodeVendor` varchar(15) NOT NULL,
  `printed` bit(1) NOT NULL DEFAULT b'0',
  `Createdby` varchar(255) NOT NULL,
  `Createdon` datetime(6) NOT NULL ON UPDATE current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `pembelianheader`
--

INSERT INTO `pembelianheader` (`RowID`, `NoTransaksi`, `TglTransaksi`, `KodeVendor`, `printed`, `Createdby`, `Createdon`) VALUES
('53c7fbba-debf-434c-8470-9dca0630d971', '2202060003', '2020-07-13 00:00:00.000000', 'VC001 ', b'0', 'admin', '2020-07-13 01:57:54.000000'),
('b7631a89-e143-46c0-a94c-7b297e8dd67b', '2202060001', '2020-07-12 00:00:00.000000', 'VC001 ', b'0', 'admin', '2020-07-12 10:39:13.000000'),
('cdf6200c-10c6-477a-8746-1b123e234e5b', '2202060004', '2020-07-13 00:00:00.000000', 'VC001 ', b'0', 'admin', '2020-07-13 09:05:24.000000'),
('feebcdbe-d10a-4490-9397-ade021eb0416', '2202060002', '2020-07-12 00:00:00.000000', 'VC001 ', b'0', 'admin', '2020-07-12 10:39:52.000000');

-- --------------------------------------------------------

--
-- Table structure for table `penjualandetail`
--

DROP TABLE IF EXISTS `penjualandetail`;
CREATE TABLE `penjualandetail` (
  `RowID` varchar(255) NOT NULL,
  `HeaderID` varchar(255) NOT NULL,
  `KodeItem` varchar(15) NOT NULL,
  `NamaItem` varchar(255) NOT NULL,
  `QtyJual` decimal(16,2) NOT NULL,
  `HargaJual` double(16,2) NOT NULL,
  `Createdby` varchar(255) NOT NULL,
  `Createdon` datetime(6) NOT NULL ON UPDATE current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `penjualandetail`
--

INSERT INTO `penjualandetail` (`RowID`, `HeaderID`, `KodeItem`, `NamaItem`, `QtyJual`, `HargaJual`, `Createdby`, `Createdon`) VALUES
('18531b50-b05c-439b-8a8f-26d950e516bf', '569cdd1d-24c4-43cd-80fa-85e5c8498420', '100.0002', 'Beras C4 10KG', '1.00', 4500.00, 'Beras Merbabu', '2020-07-15 03:18:13.000000'),
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

DROP TABLE IF EXISTS `penjualanheader`;
CREATE TABLE `penjualanheader` (
  `RowID` varchar(255) NOT NULL,
  `NoTransaksi` varchar(50) NOT NULL,
  `TglTransaksi` datetime(6) NOT NULL,
  `KodeCustomer` varchar(15) NOT NULL,
  `CustomerSource` int(11) NOT NULL,
  `printed` bit(1) NOT NULL DEFAULT b'0',
  `Status` int(11) NOT NULL COMMENT '1: Ordered, 2: DiProses, 3: Dikirim, 4: Selesai, 5: Cancel',
  `Createdby` varchar(255) NOT NULL,
  `Createdon` datetime(6) NOT NULL ON UPDATE current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `penjualanheader`
--

INSERT INTO `penjualanheader` (`RowID`, `NoTransaksi`, `TglTransaksi`, `KodeCustomer`, `CustomerSource`, `printed`, `Status`, `Createdby`, `Createdon`) VALUES
('136012bf-e3ef-437a-8a32-770d89e3a93e', '1202060006', '2020-07-11 00:00:00.000000', 'CL0001 ', 1, b'0', 3, 'admin', '2020-07-12 21:36:37.515762'),
('420934da-bae8-4064-836e-87b9b9768b3a', '1202060008', '2020-07-11 00:00:00.000000', 'CL0001 ', 1, b'0', 1, 'admin', '2020-07-11 06:58:18.000000'),
('569cdd1d-24c4-43cd-80fa-85e5c8498420', '1202060009', '2020-07-15 00:00:00.000000', 'CL0002 ', 1, b'0', 1, 'Beras Merbabu', '2020-07-15 03:18:13.000000'),
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

DROP TABLE IF EXISTS `permission`;
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
(4, 'User', 'user', NULL, '1', b'1', b'0', 4, b'1', NULL, NULL, NULL),
(5, 'Transaksi', NULL, 'icon-pencil', '0', b'1', b'0', 10, b'1', NULL, NULL, NULL),
(6, 'Penjualan', 'penjualan', NULL, '5', b'1', b'0', 11, b'1', NULL, NULL, NULL),
(7, 'Pembelian', 'pembelian', NULL, '5', b'1', b'0', 12, b'1', NULL, NULL, NULL),
(8, 'Produksi', 'produksi', NULL, '5', b'1', b'0', 13, b'1', NULL, NULL, NULL),
(9, 'Informasi', NULL, 'icon-info-sign', '0', b'1', b'1', 20, b'1', NULL, NULL, NULL),
(10, 'Stock Beras', 'persediaan', NULL, '9', b'1', b'0', 21, b'1', NULL, NULL, NULL),
(11, 'Laporan', NULL, 'icon-paper-clip', '0', b'1', b'1', 25, b'1', NULL, NULL, NULL),
(12, 'Persediaan Beras', NULL, NULL, '11', b'1', b'1', 26, b'1', NULL, NULL, NULL),
(13, 'Penjualan', NULL, NULL, '11', b'1', b'1', 27, b'1', NULL, NULL, NULL),
(14, 'Pembelian', 'pembelian', NULL, '11', b'1', b'1', 28, b'1', NULL, NULL, NULL),
(15, 'Master Vendor', 'vendor', NULL, '1', b'1', b'0', 3, b'1', NULL, NULL, NULL),
(16, 'Order', 'penjualan', 'icon-pencil', '0', b'0', b'0', 14, b'1', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `permissionrole`
--

DROP TABLE IF EXISTS `permissionrole`;
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
(1, 14),
(1, 15),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(2, 11),
(2, 12),
(2, 13),
(2, 14),
(2, 15),
(3, 5),
(3, 6),
(3, 9),
(3, 10),
(4, 16),
(5, 9),
(5, 10),
(6, 5),
(6, 8),
(6, 9),
(6, 10);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
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

DROP TABLE IF EXISTS `tcustomer`;
CREATE TABLE `tcustomer` (
  `id` int(11) NOT NULL,
  `KodeCustomer` varchar(15) NOT NULL,
  `NamaCustomer` varchar(50) NOT NULL,
  `AlamatCustomer` varchar(255) NOT NULL,
  `NoTlp` varchar(15) NOT NULL,
  `Source` int(11) NOT NULL COMMENT '1: append, 2 : ecomers',
  `Createdby` varchar(255) NOT NULL,
  `Createdon` datetime(6) NOT NULL ON UPDATE current_timestamp(6),
  `isActive` bit(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `tcustomer`
--

INSERT INTO `tcustomer` (`id`, `KodeCustomer`, `NamaCustomer`, `AlamatCustomer`, `NoTlp`, `Source`, `Createdby`, `Createdon`, `isActive`) VALUES
(1, 'CL0001', 'Solo Beras', 'Solo Surakarta 2', '081325058258', 1, 'admin', '2020-07-09 15:16:17.789027', b'1'),
(2, 'CL0002', 'Beras Merbabu', 'Solo', '081325058258', 1, 'admin', '2020-07-15 02:57:12.000000', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `titem`
--

DROP TABLE IF EXISTS `titem`;
CREATE TABLE `titem` (
  `ItemCode` varchar(15) NOT NULL,
  `ItemName` varchar(255) NOT NULL,
  `ItemGroup` int(11) NOT NULL DEFAULT 1,
  `Createdby` varchar(255) NOT NULL,
  `Createdon` datetime(6) NOT NULL ON UPDATE current_timestamp(6),
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  `Satuan` varchar(25) NOT NULL,
  `Image` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `titem`
--

INSERT INTO `titem` (`ItemCode`, `ItemName`, `ItemGroup`, `Createdby`, `Createdon`, `isActive`, `Satuan`, `Image`) VALUES
('100.0001', 'Beras C4 5KG', 1, 'admin', '2020-07-14 10:43:07.000000', b'1', 'pcs', 'data:image/png;base64,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'),
('100.0002', 'Beras C4 10KG', 1, 'admin', '2020-07-09 15:16:22.663676', b'1', '', ''),
('200.0001', 'Karung ukuran 5kg', 1, 'admin', '2020-07-13 01:58:58.000000', b'1', '', ''),
('200.0002', 'Karung ukuran 3kg', 1, 'admin', '2020-07-13 01:59:07.000000', b'1', '', ''),
('200.0003', 'Selepan', 1, 'admin', '2020-07-13 01:59:17.000000', b'1', '', ''),
('200.0004', 'Gabah Super', 1, 'admin', '2020-07-13 01:59:29.000000', b'1', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `transactionstatus`
--

DROP TABLE IF EXISTS `transactionstatus`;
CREATE TABLE `transactionstatus` (
  `id` int(11) NOT NULL,
  `NoTransaksi` varchar(50) NOT NULL,
  `TanggalPencatatan` datetime NOT NULL,
  `Status` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `transactionstatus`
--

INSERT INTO `transactionstatus` (`id`, `NoTransaksi`, `TanggalPencatatan`, `Status`) VALUES
(1, '1202060006', '2020-07-12 09:36:28', 'Di Proses'),
(2, '1202060006', '2020-07-12 09:36:37', 'Di Kirim');

-- --------------------------------------------------------

--
-- Table structure for table `transactionStatus`
--

DROP TABLE IF EXISTS `transactionStatus`;
CREATE TABLE `transactionStatus` (
  `id` int(11) NOT NULL,
  `NoTransaksi` varchar(50) NOT NULL,
  `TanggalPencatatan` datetime NOT NULL,
  `Status` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transactionStatus`
--

INSERT INTO `transactionStatus` (`id`, `NoTransaksi`, `TanggalPencatatan`, `Status`) VALUES
(1, '1202060006', '2020-07-12 09:36:28', 'Di Proses'),
(2, '1202060006', '2020-07-12 09:36:37', 'Di Kirim');

-- --------------------------------------------------------

--
-- Table structure for table `tvendor`
--

DROP TABLE IF EXISTS `tvendor`;
CREATE TABLE `tvendor` (
  `id` int(11) NOT NULL,
  `KodeVendor` varchar(25) NOT NULL,
  `NamaVendor` varchar(100) NOT NULL,
  `AlamatVendor` varchar(255) NOT NULL,
  `TlpVendor` varchar(15) NOT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `tvendor`
--

INSERT INTO `tvendor` (`id`, `KodeVendor`, `NamaVendor`, `AlamatVendor`, `TlpVendor`, `isActive`) VALUES
(1, 'VC001', 'Petani X', 'Solo 2', '081325958258', b'1'),
(2, 'VC002', 'Test tambah', 'xx', 'xxxx', b'0');

-- --------------------------------------------------------

--
-- Table structure for table `userrole`
--

DROP TABLE IF EXISTS `userrole`;
CREATE TABLE `userrole` (
  `userid` int(11) NOT NULL,
  `roleid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `userrole`
--

INSERT INTO `userrole` (`userid`, `roleid`) VALUES
(14, 1),
(74, 4),
(78, 2),
(79, 3),
(80, 5),
(81, 6);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
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
(73, '200001', 'Ridho', '427713375014f3d4686a334f911c8506642bf46124642043eefbd969653e316f9cf05c28fa41663a3aa5981ff00ba80df9665b8d0358e5e2877f7c42470591feQDe7uWIfqSvmee0oAtRUwMHbPxpFETOXeMNK2ww1v0o=', 'admin', '2020-07-03 03:12:46', 3, NULL, NULL, NULL, NULL, NULL, NULL),
(74, 'CL0002', 'Beras Merbabu', '737a35c9b148f22801975b67a7fef6e6bc1a02575492d357715b0d7659a3d86e3d7f4770984649ca6bf07c1e5b52de383fc4cdae9374843d1e8b5bb9c9def443yXi5OOJBDEpVZdcWF0530YM+YZ0AX8Tz0yWRDWEXOLo=', 'admin', '2020-07-15 02:57:12', 4, NULL, NULL, NULL, NULL, NULL, NULL),
(75, 'admin', 'admin', '85a7bfcf545c803c70cfbe541d5dfc37cb139cdf5c1a90571897c4f3a07b72d2ba94950c77c0b12896036738f63c772941fa1bc69c65d28c991fabeab82bdd7a9ZuK4mx7yFULiCLq4YTwOIAak8A7i2M3TpXf3CQtySA=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(76, 'admin', 'admin', 'a112f0c2f68c48cb10d269f262cba8b88757017553e37d72897e4d9880a94ae6682008b3d86276340f5f73fa7fd516276cdf3353b3b7888114d08202c221dcb4rfbkQnHNMEjpQH3qo6s7XWkBjnhvk5jleIUxr4z9yGI=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(77, 'admin', 'admin', '18e4b8691f26e4f2b26be18cad4cc6ee08d97dabe3bf81c8e858d0ba2e499e2541e16e7cddffae414898130e9c0c365bbfcd48d8feea72edcef3740f01e0f960oo6rUU7xXivn4aHF/RwgtiOczUwYZVD7n/9BnF97jIs=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(78, 'administrator', 'administrator', '688ce20feb3b2c921a6d8b65eb5beec9c371b5470081a0140dc0b20d6e90550d966a6f2bcc6bd26ea595f39b1e733e0db0a22b385a3ffc6711389363efb7794bpoj17DNFr56SgAFl88xAhHuFANH/ejLGP7YHDZNd8lE=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(79, 'owner', 'owner', 'e6f54be826b1cf846534493834a32b018a3ba0c28178302adaaa06cd39b2c0db4f0103f9a4deb924523a34c4808bd4a1297be26bb15860a6fedf965c8327b6530KCMwPsWdV81xvgP+LcJcRbFu2YBGtCiOvXoHLm7noA=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(80, 'whs', 'warehouse', 'cce00c546b08115d9477e687c5702c5d277ae623aee1d6db9c7f06f42ef840e1cd35eed4147edafbdc51fa77e32a0ba4e9c40ef113534eb9c1159155a1d8a1168SzxHZPkgyHRQAV+Ur3hSgMitzfrSqc0fs5SJPEbplc=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(81, 'prd', 'produksi', '9025c92b47273d1a03acb487eef671d394d536703d0e7652add1792a22c25339847dae2c3a9a80543c7165f647a45842807d3c1df8ba0c8b43d7e6bfcad74aa1AKgvb1lNnpMJHoHJPVVV4AgOIsIwv2djgp66Xrps2KU=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hasilproduksi`
--
ALTER TABLE `hasilproduksi`
  ADD PRIMARY KEY (`RowID`) USING BTREE;

--
-- Indexes for table `pembeliandetail`
--
ALTER TABLE `pembeliandetail`
  ADD PRIMARY KEY (`RowID`) USING BTREE;

--
-- Indexes for table `pembelianheader`
--
ALTER TABLE `pembelianheader`
  ADD PRIMARY KEY (`RowID`) USING BTREE;

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
-- Indexes for table `transactionstatus`
--
ALTER TABLE `transactionstatus`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `transactionStatus`
--
ALTER TABLE `transactionStatus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tvendor`
--
ALTER TABLE `tvendor`
  ADD PRIMARY KEY (`id`) USING BTREE;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tcustomer`
--
ALTER TABLE `tcustomer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transactionstatus`
--
ALTER TABLE `transactionstatus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transactionStatus`
--
ALTER TABLE `transactionStatus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tvendor`
--
ALTER TABLE `tvendor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
