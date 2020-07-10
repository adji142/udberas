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

 Date: 10/07/2020 16:11:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, 'Master', NULL, 'icon-briefcase\n', '0', b'1', b'0', 0, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (2, 'Master Item', 'item', NULL, '1', b'1', b'0', 1, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (3, 'Master Pelanggan', 'customer', NULL, '1', b'1', b'0', 2, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (4, 'User', NULL, NULL, '1', b'1', b'0', 3, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (5, 'Transaksi', NULL, 'icon-pencil', '0', b'1', b'0', 10, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (6, 'Penjualan', NULL, NULL, '5', b'1', b'0', 11, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (7, 'Pembelian', NULL, NULL, '5', b'1', b'0', 12, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (8, 'Produksi', NULL, NULL, '5', b'1', b'0', 13, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (9, 'Informasi', NULL, 'icon-info-sign', '0', b'1', b'1', 20, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (10, 'Stock Beras', NULL, NULL, '9', b'1', b'1', 21, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (11, 'Laporan', NULL, 'icon-paper-clip', '0', b'1', b'1', 25, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (12, 'Persediaan Beras', NULL, NULL, '11', b'1', b'1', 26, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (13, 'Penjualan', NULL, NULL, '11', b'1', b'1', 27, b'1', NULL, NULL, NULL);
INSERT INTO `permission` VALUES (14, 'Pembelian', NULL, NULL, '11', b'1', b'1', 28, b'1', NULL, NULL, NULL);

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

SET FOREIGN_KEY_CHECKS = 1;
