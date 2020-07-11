-- MySQL dump 10.17  Distrib 10.3.22-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: udberas
-- ------------------------------------------------------
-- Server version	10.3.22-MariaDB-1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `penjualandetail`
--

DROP TABLE IF EXISTS `penjualandetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `penjualandetail` (
  `RowID` varchar(255) NOT NULL,
  `HeaderID` varchar(255) NOT NULL,
  `KodeItem` varchar(15) NOT NULL,
  `NamaItem` varchar(255) NOT NULL,
  `QtyJual` decimal(16,2) NOT NULL,
  `HargaJual` double(16,2) NOT NULL,
  `Createdby` varchar(255) NOT NULL,
  `Createdon` datetime(6) NOT NULL DEFAULT '0000-00-00 00:00:00.000000' ON UPDATE current_timestamp(6),
  PRIMARY KEY (`RowID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `penjualandetail`
--

LOCK TABLES `penjualandetail` WRITE;
/*!40000 ALTER TABLE `penjualandetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `penjualandetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `penjualanheader`
--

DROP TABLE IF EXISTS `penjualanheader`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `penjualanheader` (
  `RowID` varchar(255) NOT NULL,
  `NoTransaksi` varchar(50) NOT NULL,
  `TglTransaksi` datetime(6) NOT NULL,
  `KodeCustomer` varchar(15) NOT NULL,
  `CustomerSource` int(11) NOT NULL,
  `printed` bit(1) NOT NULL DEFAULT b'0',
  `Status` int(11) NOT NULL COMMENT '1: Ordered, 2: DiProses, 3: Dikirim, 4: Selesai, 5: Cancel',
  `Createdby` varchar(255) NOT NULL,
  `Createdon` datetime(6) NOT NULL DEFAULT '0000-00-00 00:00:00.000000' ON UPDATE current_timestamp(6),
  PRIMARY KEY (`RowID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `penjualanheader`
--

LOCK TABLES `penjualanheader` WRITE;
/*!40000 ALTER TABLE `penjualanheader` DISABLE KEYS */;
/*!40000 ALTER TABLE `penjualanheader` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `MobileLogo` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES (1,'Master',NULL,'icon-briefcase\n','0','','\0',0,'',NULL,NULL,NULL),(2,'Master Item','item',NULL,'1','','\0',1,'',NULL,NULL,NULL),(3,'Master Pelanggan','customer',NULL,'1','','\0',2,'',NULL,NULL,NULL),(4,'User',NULL,NULL,'1','','\0',3,'',NULL,NULL,NULL),(5,'Transaksi',NULL,'icon-pencil','0','','\0',10,'',NULL,NULL,NULL),(6,'Penjualan','penjualan',NULL,'5','','\0',11,'',NULL,NULL,NULL),(7,'Pembelian',NULL,NULL,'5','','\0',12,'',NULL,NULL,NULL),(8,'Produksi',NULL,NULL,'5','','\0',13,'',NULL,NULL,NULL),(9,'Informasi',NULL,'icon-info-sign','0','','',20,'',NULL,NULL,NULL),(10,'Stock Beras',NULL,NULL,'9','','',21,'',NULL,NULL,NULL),(11,'Laporan',NULL,'icon-paper-clip','0','','',25,'',NULL,NULL,NULL),(12,'Persediaan Beras',NULL,NULL,'11','','',26,'',NULL,NULL,NULL),(13,'Penjualan',NULL,NULL,'11','','',27,'',NULL,NULL,NULL),(14,'Pembelian',NULL,NULL,'11','','',28,'',NULL,NULL,NULL);
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissionrole`
--

DROP TABLE IF EXISTS `permissionrole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissionrole` (
  `roleid` int(11) NOT NULL,
  `permissionid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissionrole`
--

LOCK TABLES `permissionrole` WRITE;
/*!40000 ALTER TABLE `permissionrole` DISABLE KEYS */;
INSERT INTO `permissionrole` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14);
/*!40000 ALTER TABLE `permissionrole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'SU'),(2,'Admin'),(3,'Pemilik'),(4,'Pembeli'),(5,'Gudang'),(6,'Produksi');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tcustomer`
--

DROP TABLE IF EXISTS `tcustomer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tcustomer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `KodeCustomer` varchar(15) NOT NULL,
  `NamaCustomer` varchar(50) NOT NULL,
  `AlamatCustomer` varchar(255) NOT NULL,
  `NoTlp` varchar(15) NOT NULL,
  `Source` int(11) NOT NULL COMMENT '1: append, 2 : ecomers',
  `Createdby` varchar(255) NOT NULL,
  `Createdon` datetime(6) NOT NULL DEFAULT '0000-00-00 00:00:00.000000' ON UPDATE current_timestamp(6),
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`,`KodeCustomer`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tcustomer`
--

LOCK TABLES `tcustomer` WRITE;
/*!40000 ALTER TABLE `tcustomer` DISABLE KEYS */;
INSERT INTO `tcustomer` VALUES (1,'CL0001','Solo Beras','Solo Surakarta 2','081325058258',1,'admin','2020-07-09 15:16:17.789027','');
/*!40000 ALTER TABLE `tcustomer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `titem`
--

DROP TABLE IF EXISTS `titem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `titem` (
  `ItemCode` varchar(15) NOT NULL,
  `ItemName` varchar(255) NOT NULL,
  `ItemGroup` int(11) NOT NULL DEFAULT 1,
  `Createdby` varchar(255) NOT NULL,
  `Createdon` datetime(6) NOT NULL DEFAULT '0000-00-00 00:00:00.000000' ON UPDATE current_timestamp(6),
  `isActive` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`ItemCode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `titem`
--

LOCK TABLES `titem` WRITE;
/*!40000 ALTER TABLE `titem` DISABLE KEYS */;
INSERT INTO `titem` VALUES ('100.0001','Beras C4 5KG',1,'admin','2020-07-09 11:25:25.000000',''),('100.0002','Beras C4 10KG',1,'admin','2020-07-09 15:16:22.663676','');
/*!40000 ALTER TABLE `titem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userrole`
--

DROP TABLE IF EXISTS `userrole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userrole` (
  `userid` int(11) NOT NULL,
  `roleid` int(11) DEFAULT NULL,
  PRIMARY KEY (`userid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userrole`
--

LOCK TABLES `userrole` WRITE;
/*!40000 ALTER TABLE `userrole` DISABLE KEYS */;
INSERT INTO `userrole` VALUES (14,1);
/*!40000 ALTER TABLE `userrole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `phone` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (14,'admin','admin','440308e0a299d722ebc5a9459a56d27adffc7ad28688d4471fdc1c7a8324f9a5cabdcd25bae8fe71b65837f6dd33fd1a9187ff4e2b2fea10e88289b70fdb79a221Nz7VN+sVNcNv1J/4lhqE9nfn5cpZTw8zhp2ge4pY0=','mnl',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL),(43,'operator','Operator','a9bdd47d7321d4089b3b00561c9c621848bd6f6e2f745a53d54913d613789c23945b66de6ded1eb336a7d526f9349a9d964d6f6c3a40e2ac90b4b16c0121f7895Xg53McbkyQ/NmW60Sf4cu3wJsi/8cyZXxeXV7g6b04=',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(71,'1001','Prasetyo Aji Wibowo','c637abd9352a25c922463f7acc7b3a5f9328eba06ed17e6572a23b8cbdabb0a3c131c304d92c3b144077d08b83bea24e8523995d9e0a8d3c059c89d3526ea8f8HAx07QI6q7vgVWvh8bgR0FD4/Nox8aBN/4DFMRh9I9E=','admin','2020-07-03 02:53:26',2,NULL,NULL,NULL,NULL,NULL,NULL),(72,'1002','Bambang sukiryo','2fab8327944504c22d9b8c85bc1d2be04ef81e4cb5eaea3ab1cbac561c05442e242fd7df31b5fcf49813aeb94f99a36302de884140b3b15415864a89e0f72a260D9/S7S/r5aU0t6xDZREZyZoTGQwVUccfVKmWIDL6tU=','admin','2020-07-03 02:54:47',2,NULL,NULL,NULL,NULL,NULL,NULL),(73,'200001','Ridho','427713375014f3d4686a334f911c8506642bf46124642043eefbd969653e316f9cf05c28fa41663a3aa5981ff00ba80df9665b8d0358e5e2877f7c42470591feQDe7uWIfqSvmee0oAtRUwMHbPxpFETOXeMNK2ww1v0o=','admin','2020-07-03 03:12:46',3,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'udberas'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-11 10:00:17
