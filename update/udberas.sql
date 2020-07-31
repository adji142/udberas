/*
 Navicat Premium Data Transfer

 Source Server         : dev_aistrick
 Source Server Type    : MySQL
 Source Server Version : 100210
 Source Host           : localhost:3306
 Source Schema         : udberas

 Target Server Type    : MySQL
 Target Server Version : 100210
 File Encoding         : 65001

 Date: 01/08/2020 00:12:34
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
  `Createdby` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL
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
  `Createdon` datetime(6) NOT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`RowID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pembeliandetail
-- ----------------------------

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
  `Createdon` datetime(6) NOT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`RowID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pembelianheader
-- ----------------------------

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
  `Createdon` datetime(6) NOT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`RowID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of penjualandetail
-- ----------------------------

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
  `Createdon` datetime(6) NOT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  `BuktiBayar` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`RowID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of penjualanheader
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, 'Master', NULL, 'icon-briefcase\n', '0', b'1', b'0', 0, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (2, 'Master Item', 'item', NULL, '1', b'1', b'0', 1, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (3, 'Master Pelanggan', 'customer', NULL, '1', b'1', b'0', 2, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (4, 'User', 'user', NULL, '1', b'1', b'0', 4, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (5, 'Transaksi', NULL, 'icon-pencil', '0', b'1', b'0', 10, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (6, 'Penjualan', 'penjualan', NULL, '5', b'1', b'0', 11, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (7, 'Pembelian', 'pembelian', NULL, '5', b'1', b'0', 12, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (8, 'Produksi', 'produksi', NULL, '5', b'1', b'0', 13, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (9, 'Informasi', NULL, 'icon-info-sign', '0', b'1', b'1', 20, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (10, 'Stock Beras', 'persediaan', NULL, '9', b'1', b'0', 21, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (11, 'Laporan', NULL, 'icon-paper-clip', '0', b'1', b'1', 25, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (12, 'Persediaan Beras', 'persediaan', NULL, '11', b'1', b'1', 26, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (13, 'Penjualan', 'lapPenjualan', NULL, '11', b'1', b'1', 30, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (15, 'Master Vendor', 'vendor', NULL, '1', b'1', b'0', 3, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (16, 'Pembelian', 'penjualan', 'icon-pencil', '0', b'0', b'0', 14, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (17, 'Laporan Persediaan Beras', 'persediaan', NULL, '11', b'0', b'0', 27, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (18, 'Laporan Penjualan', 'lapPenjualan', NULL, '11', b'0', b'0', 31, b'1', NULL, NULL, NULL);

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
INSERT INTO `permissionrole` VALUES (2, 1);
INSERT INTO `permissionrole` VALUES (2, 2);
INSERT INTO `permissionrole` VALUES (2, 3);
INSERT INTO `permissionrole` VALUES (2, 4);
INSERT INTO `permissionrole` VALUES (2, 5);
INSERT INTO `permissionrole` VALUES (2, 6);
INSERT INTO `permissionrole` VALUES (2, 7);
INSERT INTO `permissionrole` VALUES (2, 8);
INSERT INTO `permissionrole` VALUES (2, 9);
INSERT INTO `permissionrole` VALUES (2, 10);
INSERT INTO `permissionrole` VALUES (2, 11);
INSERT INTO `permissionrole` VALUES (2, 12);
INSERT INTO `permissionrole` VALUES (2, 13);
INSERT INTO `permissionrole` VALUES (2, 14);
INSERT INTO `permissionrole` VALUES (2, 15);
INSERT INTO `permissionrole` VALUES (3, 5);
INSERT INTO `permissionrole` VALUES (3, 6);
INSERT INTO `permissionrole` VALUES (3, 9);
INSERT INTO `permissionrole` VALUES (3, 10);
INSERT INTO `permissionrole` VALUES (4, 16);
INSERT INTO `permissionrole` VALUES (5, 9);
INSERT INTO `permissionrole` VALUES (5, 10);
INSERT INTO `permissionrole` VALUES (6, 5);
INSERT INTO `permissionrole` VALUES (6, 8);
INSERT INTO `permissionrole` VALUES (6, 9);
INSERT INTO `permissionrole` VALUES (6, 10);
INSERT INTO `permissionrole` VALUES (1, 17);
INSERT INTO `permissionrole` VALUES (1, 18);

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
  `Createdon` datetime(6) NOT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`, `KodeCustomer`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tcustomer
-- ----------------------------

-- ----------------------------
-- Table structure for titem
-- ----------------------------
DROP TABLE IF EXISTS `titem`;
CREATE TABLE `titem`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ItemCode` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ItemName` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `ItemGroup` int(11) NOT NULL DEFAULT 1,
  `Createdby` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Createdon` datetime(6) NOT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  `Satuan` varchar(25) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Image` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `Harga` double(255, 2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of titem
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transactionstatus
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tvendor
-- ----------------------------

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
INSERT INTO `userrole` VALUES (74, 4);
INSERT INTO `userrole` VALUES (78, 2);
INSERT INTO `userrole` VALUES (79, 3);
INSERT INTO `userrole` VALUES (80, 5);
INSERT INTO `userrole` VALUES (81, 6);
INSERT INTO `userrole` VALUES (82, 4);

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
) ENGINE = InnoDB AUTO_INCREMENT = 83 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (14, 'admin', 'admin', '440308e0a299d722ebc5a9459a56d27adffc7ad28688d4471fdc1c7a8324f9a5cabdcd25bae8fe71b65837f6dd33fd1a9187ff4e2b2fea10e88289b70fdb79a221Nz7VN+sVNcNv1J/4lhqE9nfn5cpZTw8zhp2ge4pY0=', 'mnl', NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (43, 'operator', 'Operator', 'a9bdd47d7321d4089b3b00561c9c621848bd6f6e2f745a53d54913d613789c23945b66de6ded1eb336a7d526f9349a9d964d6f6c3a40e2ac90b4b16c0121f7895Xg53McbkyQ/NmW60Sf4cu3wJsi/8cyZXxeXV7g6b04=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (71, '1001', 'Prasetyo Aji Wibowo', 'c637abd9352a25c922463f7acc7b3a5f9328eba06ed17e6572a23b8cbdabb0a3c131c304d92c3b144077d08b83bea24e8523995d9e0a8d3c059c89d3526ea8f8HAx07QI6q7vgVWvh8bgR0FD4/Nox8aBN/4DFMRh9I9E=', 'admin', '2020-07-03 02:53:26', 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (72, '1002', 'Bambang sukiryo', '2fab8327944504c22d9b8c85bc1d2be04ef81e4cb5eaea3ab1cbac561c05442e242fd7df31b5fcf49813aeb94f99a36302de884140b3b15415864a89e0f72a260D9/S7S/r5aU0t6xDZREZyZoTGQwVUccfVKmWIDL6tU=', 'admin', '2020-07-03 02:54:47', 2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (73, '200001', 'Ridho', '427713375014f3d4686a334f911c8506642bf46124642043eefbd969653e316f9cf05c28fa41663a3aa5981ff00ba80df9665b8d0358e5e2877f7c42470591feQDe7uWIfqSvmee0oAtRUwMHbPxpFETOXeMNK2ww1v0o=', 'admin', '2020-07-03 03:12:46', 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (75, 'admin', 'admin', '85a7bfcf545c803c70cfbe541d5dfc37cb139cdf5c1a90571897c4f3a07b72d2ba94950c77c0b12896036738f63c772941fa1bc69c65d28c991fabeab82bdd7a9ZuK4mx7yFULiCLq4YTwOIAak8A7i2M3TpXf3CQtySA=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (76, 'admin', 'admin', 'a112f0c2f68c48cb10d269f262cba8b88757017553e37d72897e4d9880a94ae6682008b3d86276340f5f73fa7fd516276cdf3353b3b7888114d08202c221dcb4rfbkQnHNMEjpQH3qo6s7XWkBjnhvk5jleIUxr4z9yGI=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (77, 'admin', 'admin', '18e4b8691f26e4f2b26be18cad4cc6ee08d97dabe3bf81c8e858d0ba2e499e2541e16e7cddffae414898130e9c0c365bbfcd48d8feea72edcef3740f01e0f960oo6rUU7xXivn4aHF/RwgtiOczUwYZVD7n/9BnF97jIs=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (78, 'administrator', 'administrator', '688ce20feb3b2c921a6d8b65eb5beec9c371b5470081a0140dc0b20d6e90550d966a6f2bcc6bd26ea595f39b1e733e0db0a22b385a3ffc6711389363efb7794bpoj17DNFr56SgAFl88xAhHuFANH/ejLGP7YHDZNd8lE=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (79, 'owner', 'owner', 'e6f54be826b1cf846534493834a32b018a3ba0c28178302adaaa06cd39b2c0db4f0103f9a4deb924523a34c4808bd4a1297be26bb15860a6fedf965c8327b6530KCMwPsWdV81xvgP+LcJcRbFu2YBGtCiOvXoHLm7noA=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (80, 'whs', 'warehouse', 'cce00c546b08115d9477e687c5702c5d277ae623aee1d6db9c7f06f42ef840e1cd35eed4147edafbdc51fa77e32a0ba4e9c40ef113534eb9c1159155a1d8a1168SzxHZPkgyHRQAV+Ur3hSgMitzfrSqc0fs5SJPEbplc=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `users` VALUES (81, 'prd', 'produksi', '9025c92b47273d1a03acb487eef671d394d536703d0e7652add1792a22c25339847dae2c3a9a80543c7165f647a45842807d3c1df8ba0c8b43d7e6bfcad74aa1AKgvb1lNnpMJHoHJPVVV4AgOIsIwv2djgp66Xrps2KU=', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Procedure structure for fn_GetStock
-- ----------------------------
DROP PROCEDURE IF EXISTS `fn_GetStock`;
delimiter ;;
CREATE PROCEDURE `fn_GetStock`(IN `KodeItem` VARCHAR(15))
BEGIN
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
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
