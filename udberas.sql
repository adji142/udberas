/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 100406
 Source Host           : localhost:3306
 Source Schema         : udberas

 Target Server Type    : MySQL
 Target Server Version : 100406
 File Encoding         : 65001

 Date: 13/07/2020 16:10:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hasilproduksi
-- ----------------------------
DROP TABLE IF EXISTS `hasilproduksi`;
CREATE TABLE `hasilproduksi`  (
  `RowID` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NoTransaksi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `TglTransaksi` date NOT NULL,
  `KodeItemFG` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaItemFG` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `QtyFG` double(16, 2) NOT NULL,
  `Createdon` datetime(6) NOT NULL,
  `Createdby` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`RowID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hasilproduksi
-- ----------------------------

-- ----------------------------
-- Table structure for pemakaianbahan
-- ----------------------------
DROP TABLE IF EXISTS `pemakaianbahan`;
CREATE TABLE `pemakaianbahan`  (
  `RowID` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NoTransaksi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `TglTransaksi` date NOT NULL,
  `KodeItemRM` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaItemRM` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `QtyIssue` double(16, 2) NOT NULL,
  `Createdon` datetime(6) NOT NULL,
  `Createdby` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`RowID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pemakaianbahan
-- ----------------------------

-- ----------------------------
-- Table structure for pembeliandetail
-- ----------------------------
DROP TABLE IF EXISTS `pembeliandetail`;
CREATE TABLE `pembeliandetail`  (
  `RowID` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `HeaderID` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `KodeItem` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaItem` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `QtyBeli` decimal(16, 2) NOT NULL,
  `HargaBeli` double(16, 2) NOT NULL,
  `Createdby` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Createdon` datetime(6) NOT NULL DEFAULT '0000-00-00 00:00:00.000000' ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`RowID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pembeliandetail
-- ----------------------------
INSERT INTO `pembeliandetail` VALUES ('2ddad022-94ba-4f07-aba3-3db84aabf23c', 'feebcdbe-d10a-4490-9397-ade021eb0416', '100.0002', 'Beras C4 10KG', 35.00, 3000.00, 'admin', '2020-07-12 10:39:53.000000');
INSERT INTO `pembeliandetail` VALUES ('5470af5b-af83-415a-99e0-168c98a27f3a', 'feebcdbe-d10a-4490-9397-ade021eb0416', '100.0001', 'Beras C4 5KG', 25.00, 3500.00, 'admin', '2020-07-12 10:39:53.000000');
INSERT INTO `pembeliandetail` VALUES ('644c9f74-b296-4bdc-8a9b-27ffa61e9058', '53c7fbba-debf-434c-8470-9dca0630d971', '100.0001', 'Beras C4 5KG', 2.00, 4.00, 'admin', '2020-07-13 01:57:54.000000');
INSERT INTO `pembeliandetail` VALUES ('b3d37ec6-69b1-439c-b185-cec52b28b0c9', 'b7631a89-e143-46c0-a94c-7b297e8dd67b', '100.0001', 'Beras C4 5KG', 1.00, 3500.00, 'admin', '2020-07-12 10:39:13.000000');

-- ----------------------------
-- Table structure for pembelianheader
-- ----------------------------
DROP TABLE IF EXISTS `pembelianheader`;
CREATE TABLE `pembelianheader`  (
  `RowID` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NoTransaksi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `TglTransaksi` datetime(6) NOT NULL,
  `KodeVendor` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `printed` bit(1) NOT NULL DEFAULT b'0',
  `Createdby` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Createdon` datetime(6) NOT NULL DEFAULT '0000-00-00 00:00:00.000000' ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`RowID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pembelianheader
-- ----------------------------
INSERT INTO `pembelianheader` VALUES ('53c7fbba-debf-434c-8470-9dca0630d971', '2202060003', '2020-07-13 00:00:00.000000', 'VC001 ', b'0', 'admin', '2020-07-13 01:57:54.000000');
INSERT INTO `pembelianheader` VALUES ('b7631a89-e143-46c0-a94c-7b297e8dd67b', '2202060001', '2020-07-12 00:00:00.000000', 'VC001 ', b'0', 'admin', '2020-07-12 10:39:13.000000');
INSERT INTO `pembelianheader` VALUES ('feebcdbe-d10a-4490-9397-ade021eb0416', '2202060002', '2020-07-12 00:00:00.000000', 'VC001 ', b'0', 'admin', '2020-07-12 10:39:52.000000');

-- ----------------------------
-- Table structure for penjualandetail
-- ----------------------------
DROP TABLE IF EXISTS `penjualandetail`;
CREATE TABLE `penjualandetail`  (
  `RowID` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `HeaderID` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `KodeItem` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaItem` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `QtyJual` decimal(16, 2) NOT NULL,
  `HargaJual` double(16, 2) NOT NULL,
  `Createdby` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Createdon` datetime(6) NOT NULL DEFAULT '0000-00-00 00:00:00.000000' ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`RowID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of penjualandetail
-- ----------------------------
INSERT INTO `penjualandetail` VALUES ('3041ead2-d9e6-4fe3-b159-3ca177c745a7', '420934da-bae8-4064-836e-87b9b9768b3a', '100.0002', 'Beras C4 10KG', 2.00, 4000.00, 'admin', '2020-07-11 06:58:18.000000');
INSERT INTO `penjualandetail` VALUES ('4138907f-db62-410c-99a8-e6f4c8b61b9d', '136012bf-e3ef-437a-8a32-770d89e3a93e', '100.0002', 'Beras C4 10KG', 1.00, 4000.00, 'admin', '2020-07-11 06:55:34.000000');
INSERT INTO `penjualandetail` VALUES ('4fcaf114-ad3e-4f4e-ac36-c6c0db89c80c', '87e5947f-095d-4fa7-94cb-178a6f116f7a', '100.0001', 'Beras C4 5KG', 2.00, 4000.00, 'admin', '2020-07-11 06:46:38.000000');
INSERT INTO `penjualandetail` VALUES ('67f2d652-b01b-48bb-9618-863d9228748b', '92852aec-a7bc-44ab-8a87-50c3215c6109', '100.0001', 'Beras C4 5KG', 1.00, 4000.00, 'admin', '2020-07-11 06:56:52.000000');
INSERT INTO `penjualandetail` VALUES ('874f3297-ee2a-404d-92de-2d20d59a704e', '136012bf-e3ef-437a-8a32-770d89e3a93e', '100.0001', 'Beras C4 5KG', 2.00, 4500.00, 'admin', '2020-07-11 06:55:34.000000');
INSERT INTO `penjualandetail` VALUES ('978101b9-8177-4e0d-892e-3cd33ccf06a3', 'd07d769f-0a2a-4452-aaf4-3b1614ea231f', '100.0002', 'Beras C4 10KG', 2.00, 3000.00, 'admin', '2020-07-11 06:49:47.000000');
INSERT INTO `penjualandetail` VALUES ('97adf0f4-6a3e-4b08-a233-b51ebedf0979', 'dfd4bcd0-c8f6-482d-9e40-930d088a78b1', '100.0001', 'Beras C4 5KG', 2.00, 4000.00, 'admin', '2020-07-11 06:53:44.000000');
INSERT INTO `penjualandetail` VALUES ('a59f5626-eb3f-4e8f-baa0-a8a9ab7b36f6', 'd07d769f-0a2a-4452-aaf4-3b1614ea231f', '100.0001', 'Beras C4 5KG', 2.00, 4000.00, 'admin', '2020-07-11 06:49:47.000000');
INSERT INTO `penjualandetail` VALUES ('aa05440f-9e60-4118-80fa-94e5619383f6', '71e38865-e83f-44b2-b130-258f139946e3', '100.0002', 'Beras C4 10KG', 1.00, 4000.00, 'admin', '2020-07-11 06:48:23.000000');
INSERT INTO `penjualandetail` VALUES ('b8a51941-22a6-4367-bc74-917cd68679d9', '92852aec-a7bc-44ab-8a87-50c3215c6109', '100.0002', 'Beras C4 10KG', 2.00, 4500.00, 'admin', '2020-07-11 06:56:52.000000');
INSERT INTO `penjualandetail` VALUES ('d82efe57-d46e-4f87-8d4e-37637f61c953', 'dfd4bcd0-c8f6-482d-9e40-930d088a78b1', '100.0002', 'Beras C4 10KG', 1.00, 4500.00, 'admin', '2020-07-11 06:53:44.000000');
INSERT INTO `penjualandetail` VALUES ('df947814-7c0d-4fee-bcd2-587e3d344caa', '71e38865-e83f-44b2-b130-258f139946e3', '100.0001', 'Beras C4 5KG', 2.00, 4500.00, 'admin', '2020-07-11 06:48:23.000000');
INSERT INTO `penjualandetail` VALUES ('f4423457-954b-4883-bb4f-41b5160bdf4d', '87e5947f-095d-4fa7-94cb-178a6f116f7a', '100.0002', 'Beras C4 10KG', 1.00, 4500.00, 'admin', '2020-07-11 06:46:38.000000');
INSERT INTO `penjualandetail` VALUES ('fafe08bd-8aca-4733-ba8d-96d729993adb', '420934da-bae8-4064-836e-87b9b9768b3a', '100.0001', 'Beras C4 5KG', 1.00, 4500.00, 'admin', '2020-07-11 06:58:18.000000');
INSERT INTO `penjualandetail` VALUES ('ffe8621d-6e15-4a34-a263-769500a353bf', '7d28b9eb-d868-4468-ad40-8b80f93d64eb', '100.0001', 'Beras C4 5KG', 1.00, 4500.00, 'admin', '2020-07-11 06:45:37.000000');

-- ----------------------------
-- Table structure for penjualanheader
-- ----------------------------
DROP TABLE IF EXISTS `penjualanheader`;
CREATE TABLE `penjualanheader`  (
  `RowID` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NoTransaksi` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `TglTransaksi` datetime(6) NOT NULL,
  `KodeCustomer` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `CustomerSource` int(11) NOT NULL,
  `printed` bit(1) NOT NULL DEFAULT b'0',
  `Status` int(11) NOT NULL COMMENT '1: Ordered, 2: DiProses, 3: Dikirim, 4: Selesai, 5: Cancel',
  `Createdby` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Createdon` datetime(6) NOT NULL DEFAULT '0000-00-00 00:00:00.000000' ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`RowID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of penjualanheader
-- ----------------------------
INSERT INTO `penjualanheader` VALUES ('136012bf-e3ef-437a-8a32-770d89e3a93e', '1202060006', '2020-07-11 00:00:00.000000', 'CL0001 ', 1, b'0', 3, 'admin', '2020-07-12 21:36:37.515762');
INSERT INTO `penjualanheader` VALUES ('420934da-bae8-4064-836e-87b9b9768b3a', '1202060008', '2020-07-11 00:00:00.000000', 'CL0001 ', 1, b'0', 1, 'admin', '2020-07-11 06:58:18.000000');
INSERT INTO `penjualanheader` VALUES ('71e38865-e83f-44b2-b130-258f139946e3', '1202060003', '2020-07-11 00:00:00.000000', 'CL0001 ', 1, b'0', 1, 'admin', '2020-07-11 06:48:23.000000');
INSERT INTO `penjualanheader` VALUES ('7d28b9eb-d868-4468-ad40-8b80f93d64eb', '1202060001', '2020-07-11 00:00:00.000000', '', 1, b'0', 1, 'admin', '2020-07-11 06:45:37.000000');
INSERT INTO `penjualanheader` VALUES ('87e5947f-095d-4fa7-94cb-178a6f116f7a', '1202060002', '2020-07-11 00:00:00.000000', 'CL0001 ', 1, b'0', 1, 'admin', '2020-07-11 06:46:38.000000');
INSERT INTO `penjualanheader` VALUES ('92852aec-a7bc-44ab-8a87-50c3215c6109', '1202060007', '2020-07-11 00:00:00.000000', 'CL0001 ', 1, b'0', 1, 'admin', '2020-07-11 06:56:52.000000');
INSERT INTO `penjualanheader` VALUES ('d07d769f-0a2a-4452-aaf4-3b1614ea231f', '1202060004', '2020-07-11 00:00:00.000000', 'CL0001 ', 1, b'0', 1, 'admin', '2020-07-11 06:49:47.000000');
INSERT INTO `penjualanheader` VALUES ('dfd4bcd0-c8f6-482d-9e40-930d088a78b1', '1202060005', '2020-07-11 00:00:00.000000', 'CL0001 ', 1, b'0', 1, 'admin', '2020-07-11 06:53:44.000000');

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionname` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `link` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `ico` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `menusubmenu` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `multilevel` bit(1) NULL DEFAULT NULL,
  `separator` bit(1) NULL DEFAULT NULL,
  `order` int(255) NULL DEFAULT NULL,
  `status` bit(1) NULL DEFAULT NULL,
  `AllowMobile` bit(1) NULL DEFAULT NULL,
  `MobileRoute` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `MobileLogo` int(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, 'Master', NULL, 'icon-briefcase\n', '0', b'1', b'0', 0, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (2, 'Master Item', 'item', NULL, '1', b'1', b'0', 1, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (3, 'Master Pelanggan', 'customer', NULL, '1', b'1', b'0', 2, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (4, 'User', NULL, NULL, '1', b'1', b'0', 4, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (5, 'Transaksi', NULL, 'icon-pencil', '0', b'1', b'0', 10, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (6, 'Penjualan', 'penjualan', NULL, '5', b'1', b'0', 11, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (7, 'Pembelian', 'pembelian', NULL, '5', b'1', b'0', 12, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (8, 'Produksi', 'produksi', NULL, '5', b'1', b'0', 13, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (9, 'Informasi', NULL, 'icon-info-sign', '0', b'1', b'1', 20, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (10, 'Stock Beras', NULL, NULL, '9', b'1', b'1', 21, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (11, 'Laporan', NULL, 'icon-paper-clip', '0', b'1', b'1', 25, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (12, 'Persediaan Beras', NULL, NULL, '11', b'1', b'1', 26, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (13, 'Penjualan', NULL, NULL, '11', b'1', b'1', 27, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (14, 'Pembelian', 'pembelian', NULL, '11', b'1', b'1', 28, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (15, 'Master Vendor', 'vendor', NULL, '1', b'1', b'0', 3, b'1', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for permissionrole
-- ----------------------------
DROP TABLE IF EXISTS `permissionrole`;
CREATE TABLE `permissionrole`  (
  `roleid` int(11) NOT NULL,
  `permissionid` int(11) NOT NULL
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permissionrole
-- ----------------------------
INSERT INTO `permissionrole` VALUES (1, 1);
INSERT INTO `permissionrole` VALUES (1, 2);
INSERT INTO `permissionrole` VALUES (1, 3);
INSERT INTO `permissionrole` VALUES (1, 4);
INSERT INTO `permissionrole` VALUES (1, 5);
INSERT INTO `permissionrole` VALUES (1, 6);
INSERT INTO `permissionrole` VALUES (1, 7);
INSERT INTO `permissionrole` VALUES (1, 8);
INSERT INTO `permissionrole` VALUES (1, 9);
INSERT INTO `permissionrole` VALUES (1, 10);
INSERT INTO `permissionrole` VALUES (1, 11);
INSERT INTO `permissionrole` VALUES (1, 12);
INSERT INTO `permissionrole` VALUES (1, 13);
INSERT INTO `permissionrole` VALUES (1, 14);
INSERT INTO `permissionrole` VALUES (1, 15);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'SU');
INSERT INTO `roles` VALUES (2, 'Admin');
INSERT INTO `roles` VALUES (3, 'Pemilik');
INSERT INTO `roles` VALUES (4, 'Pembeli');
INSERT INTO `roles` VALUES (5, 'Gudang');
INSERT INTO `roles` VALUES (6, 'Produksi');

-- ----------------------------
-- Table structure for tcustomer
-- ----------------------------
DROP TABLE IF EXISTS `tcustomer`;
CREATE TABLE `tcustomer`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `KodeCustomer` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NamaCustomer` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `AlamatCustomer` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NoTlp` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Source` int(11) NOT NULL COMMENT '1: append, 2 : ecomers',
  `Createdby` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Createdon` datetime(6) NOT NULL DEFAULT '0000-00-00 00:00:00.000000' ON UPDATE CURRENT_TIMESTAMP(6),
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`, `KodeCustomer`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tcustomer
-- ----------------------------
INSERT INTO `tcustomer` VALUES (1, 'CL0001', 'Solo Beras', 'Solo Surakarta 2', '081325058258', 1, 'admin', '2020-07-09 15:16:17.789027', b'1');

-- ----------------------------
-- Table structure for titem
-- ----------------------------
DROP TABLE IF EXISTS `titem`;
CREATE TABLE `titem`  (
  `ItemCode` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ItemName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ItemGroup` int(11) NOT NULL DEFAULT 1,
  `Createdby` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Createdon` datetime(6) NOT NULL DEFAULT '0000-00-00 00:00:00.000000' ON UPDATE CURRENT_TIMESTAMP(6),
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ItemCode`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of titem
-- ----------------------------
INSERT INTO `titem` VALUES ('100.0001', 'Beras C4 5KG', 1, 'admin', '2020-07-09 11:25:25.000000', b'1');
INSERT INTO `titem` VALUES ('100.0002', 'Beras C4 10KG', 1, 'admin', '2020-07-09 15:16:22.663676', b'1');
INSERT INTO `titem` VALUES ('200.0001', 'Karung ukuran 5kg', 1, 'admin', '2020-07-13 01:58:58.000000', b'1');
INSERT INTO `titem` VALUES ('200.0002', 'Karung ukuran 3kg', 1, 'admin', '2020-07-13 01:59:07.000000', b'1');
INSERT INTO `titem` VALUES ('200.0003', 'Selepan', 1, 'admin', '2020-07-13 01:59:17.000000', b'1');
INSERT INTO `titem` VALUES ('200.0004', 'Gabah Super', 1, 'admin', '2020-07-13 01:59:29.000000', b'1');

-- ----------------------------
-- Table structure for transactionstatus
-- ----------------------------
DROP TABLE IF EXISTS `transactionstatus`;
CREATE TABLE `transactionstatus`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `NoTransaksi` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TanggalPencatatan` datetime(0) NOT NULL,
  `Status` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transactionstatus
-- ----------------------------
INSERT INTO `transactionstatus` VALUES (1, '1202060006', '2020-07-12 09:36:28', 'Di Proses');
INSERT INTO `transactionstatus` VALUES (2, '1202060006', '2020-07-12 09:36:37', 'Di Kirim');

-- ----------------------------
-- Table structure for tvendor
-- ----------------------------
DROP TABLE IF EXISTS `tvendor`;
CREATE TABLE `tvendor`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `KodeVendor` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NamaVendor` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `AlamatVendor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TlpVendor` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tvendor
-- ----------------------------
INSERT INTO `tvendor` VALUES (1, 'VC001', 'Petani X', 'Solo 2', '081325958258', b'1');
INSERT INTO `tvendor` VALUES (2, 'VC002', 'Test tambah', 'xx', 'xxxx', b'0');

-- ----------------------------
-- Table structure for userrole
-- ----------------------------
DROP TABLE IF EXISTS `userrole`;
CREATE TABLE `userrole`  (
  `userid` int(11) NOT NULL,
  `roleid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`userid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of userrole
-- ----------------------------
INSERT INTO `userrole` VALUES (14, 1);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(75) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nama` varchar(75) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `createdby` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `createdon` datetime(0) NULL DEFAULT NULL,
  `HakAkses` int(255) NULL DEFAULT NULL COMMENT '1: admin,2: guru, 3 : murid',
  `token` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `verified` bit(1) NULL DEFAULT NULL,
  `ip` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `browser` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 74 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (14, 'admin', 'admin', '440308e0a299d722ebc5a9459a56d27adffc7ad28688d4471fdc1c7a8324f9a5cabdcd25bae8fe71b65837f6dd33fd1a9187ff4e2b2fea10e88289b70fdb79a221Nz7VN+sVNcNv1J/4lhqE9nfn5cpZTw8zhp2ge4pY0=', 'mnl', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (43, 'operator', 'Operator', 'a9bdd47d7321d4089b3b00561c9c621848bd6f6e2f745a53d54913d613789c23945b66de6ded1eb336a7d526f9349a9d964d6f6c3a40e2ac90b4b16c0121f7895Xg53McbkyQ/NmW60Sf4cu3wJsi/8cyZXxeXV7g6b04=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (71, '1001', 'Prasetyo Aji Wibowo', 'c637abd9352a25c922463f7acc7b3a5f9328eba06ed17e6572a23b8cbdabb0a3c131c304d92c3b144077d08b83bea24e8523995d9e0a8d3c059c89d3526ea8f8HAx07QI6q7vgVWvh8bgR0FD4/Nox8aBN/4DFMRh9I9E=', 'admin', '2020-07-03 02:53:26', 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (72, '1002', 'Bambang sukiryo', '2fab8327944504c22d9b8c85bc1d2be04ef81e4cb5eaea3ab1cbac561c05442e242fd7df31b5fcf49813aeb94f99a36302de884140b3b15415864a89e0f72a260D9/S7S/r5aU0t6xDZREZyZoTGQwVUccfVKmWIDL6tU=', 'admin', '2020-07-03 02:54:47', 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (73, '200001', 'Ridho', '427713375014f3d4686a334f911c8506642bf46124642043eefbd969653e316f9cf05c28fa41663a3aa5981ff00ba80df9665b8d0358e5e2877f7c42470591feQDe7uWIfqSvmee0oAtRUwMHbPxpFETOXeMNK2ww1v0o=', 'admin', '2020-07-03 03:12:46', 3, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Procedure structure for fn_GetStock
-- ----------------------------
DROP PROCEDURE IF EXISTS `fn_GetStock`;
delimiter ;;
CREATE PROCEDURE `fn_GetStock`(IN `KodeItem` varchar(15))
BEGIN
	SELECT 
		a.KodeItem,a.KodeItem,
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
	GROUP BY a.KodeItem;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
