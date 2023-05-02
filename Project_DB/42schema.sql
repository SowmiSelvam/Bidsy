CREATE DATABASE  IF NOT EXISTS `bidsydb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bidsydb`;
-- MySQL dump 10.13  Distrib 8.0.29, for macos12 (x86_64)
--
-- Host: 127.0.0.1    Database: bidsydb
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bids`
--

DROP TABLE IF EXISTS `bids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bids` (
  `bid_id` int NOT NULL AUTO_INCREMENT,
  `secret_upper_price` int DEFAULT NULL,
  `bidding_price` int DEFAULT NULL,
  `bid_time` datetime DEFAULT NULL,
  `increment_bid` int DEFAULT NULL,
  `user_id` varchar(30) DEFAULT NULL,
  `item_id` int DEFAULT NULL,
  `isAutoBid` tinyint(1) DEFAULT NULL,
  `isAnonymous` int DEFAULT NULL,
  PRIMARY KEY (`bid_id`),
  KEY `user_id` (`user_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `bids_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `bidsy_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bids_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `itemClassifies` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bids`
--

LOCK TABLES `bids` WRITE;
/*!40000 ALTER TABLE `bids` DISABLE KEYS */;
INSERT INTO `bids` VALUES (18,NULL,810,'2023-04-30 20:16:31',NULL,'vj@bidsy.com',21,0,NULL),(24,NULL,1220,'2023-04-30 20:44:21',NULL,'hk@bidsy.com',19,0,1),(25,NULL,1360,'2023-04-30 21:13:09',NULL,'hk@bidsy.com',25,0,0),(26,1000,820,'2023-04-30 21:13:54',20,'ag@bidsy.com',21,1,0),(27,1400,1400,'2023-05-01 13:31:25',20,'vj@bidsy.com',27,1,0),(28,NULL,1420,'2023-05-01 13:32:23',NULL,'ag@bidsy.com',27,0,0),(29,400,360,'2023-05-01 14:03:47',10,'hk@bidsy.com',29,1,0),(30,NULL,350,'2023-05-01 14:03:48',NULL,'vj@bidsy.com',29,0,0),(31,2300,2300,'2023-05-01 19:43:07',100,'ag@bidsy.com',30,1,0),(32,NULL,2200,'2023-05-01 19:43:08',NULL,'hk@bidsy.com',30,0,0),(33,1400,1300,'2023-05-01 21:27:09',100,'johndoe@bidsy.com',32,1,0),(34,NULL,1200,'2023-05-01 21:27:09',NULL,'ag@bidsy.com',32,0,1);
/*!40000 ALTER TABLE `bids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bids_alerts`
--

DROP TABLE IF EXISTS `bids_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bids_alerts` (
  `user_id` varchar(30) NOT NULL,
  `alerts` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `bids_alerts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `bidsy_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bids_alerts`
--

LOCK TABLES `bids_alerts` WRITE;
/*!40000 ALTER TABLE `bids_alerts` DISABLE KEYS */;
INSERT INTO `bids_alerts` VALUES ('ag@bidsy.com','select title, itemDescription, item_id, starting_price, start_auction_time,end_auction_time, bid_id  from itemClassifies where end_auction_time > current_timestamp() and start_auction_time < current_timestamp()  and email not like \'ag@bidsy.com\'  and ram in (\'16 GB\') ;'),('vj@bidsy.com','select title, itemDescription, item_id, starting_price, start_auction_time,end_auction_time, bid_id  from itemClassifies where end_auction_time > current_timestamp() and start_auction_time < current_timestamp()  and email not like \'vj@bidsy.com\'  and ram in (\'4 GB\') ;');
/*!40000 ALTER TABLE `bids_alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bidsy_employee`
--

DROP TABLE IF EXISTS `bidsy_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bidsy_employee` (
  `emp_id` varchar(30) DEFAULT NULL,
  `is_admin` tinyint(1) DEFAULT NULL,
  `user_id` varchar(30) NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `bidsy_employee_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `bidsy_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bidsy_employee`
--

LOCK TABLES `bidsy_employee` WRITE;
/*!40000 ALTER TABLE `bidsy_employee` DISABLE KEYS */;
INSERT INTO `bidsy_employee` VALUES ('1',1,'admin'),('2',0,'emp1@bidsy.com'),('3',0,'emp2@bidsy.com'),('3',0,'selvamsowmiyanarayan@gmail.com');
/*!40000 ALTER TABLE `bidsy_employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bidsy_user`
--

DROP TABLE IF EXISTS `bidsy_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bidsy_user` (
  `first_name` varchar(30) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `user_id` varchar(30) NOT NULL,
  `email` varchar(30) DEFAULT NULL,
  `telephone_no` bigint DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `bank_acc_no` bigint DEFAULT NULL,
  `routing_no` int DEFAULT NULL,
  `is_user` int DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bidsy_user`
--

LOCK TABLES `bidsy_user` WRITE;
/*!40000 ALTER TABLE `bidsy_user` DISABLE KEYS */;
INSERT INTO `bidsy_user` VALUES ('admin','','','admin','',0,'admin',0,0,0),('Anubhav','Garikapadu','285, George St','ag@bidsy.com','ag@bidsy.com',7323225911,'asdf',1234567890,12345678,1),('First','Employee','New Brunswick','emp1@bidsy.com','emp1@bidsy.com',1234,'sdfg',1234567894,12345678,0),('emp','two','112 Belwin St','emp2@bidsy.com','emp2@bidsy.com',1231234154,'emp2',1231456238,87645692,0),('Hittishi','Kurlagunda','230 Paul','hk@bidsy.com','hk@bidsy.com',7323227756,'asdf',5316673456,23424,1),('john','doe','1 A St','johndoe@bidsy.com','johndoe@bidsy.com',3213213211,'password1',1212121212,12121212,1),('emp2','Selvam','285, George St','selvamsowmiyanarayan@gmail.com','selvamsowmiyanarayan@gmail.com',7323225923,'emp2',1234567,23424,0),('Sowmiyanarayan ','Selvam','285, George St','ss@bidsy.com','ss@bidsy.com',7325226998,'gilfa',1234567845,12345678,1),('Vijay','Swaminathan','285, George St','vj@bidsy.com','vj@bidsy.com',8482345560,'gilma',654676775,123456,1);
/*!40000 ALTER TABLE `bidsy_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buyer`
--

DROP TABLE IF EXISTS `buyer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buyer` (
  `shipping_address` varchar(50) DEFAULT NULL,
  `user_id` varchar(30) NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `buyer_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `bidsy_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyer`
--

LOCK TABLES `buyer` WRITE;
/*!40000 ALTER TABLE `buyer` DISABLE KEYS */;
/*!40000 ALTER TABLE `buyer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_index` int NOT NULL,
  `category_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`category_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Laptops');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments_inEditsContainsQnA`
--

DROP TABLE IF EXISTS `comments_inEditsContainsQnA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments_inEditsContainsQnA` (
  `q_user_id` varchar(30) NOT NULL,
  `a_user_id` varchar(30) DEFAULT NULL,
  `date_time` datetime NOT NULL,
  `item_id` int NOT NULL,
  `question` varchar(256) DEFAULT NULL,
  `answer` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`q_user_id`,`date_time`,`item_id`),
  KEY `a_user_id` (`a_user_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `comments_ineditscontainsqna_ibfk_1` FOREIGN KEY (`q_user_id`) REFERENCES `bidsy_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comments_ineditscontainsqna_ibfk_2` FOREIGN KEY (`a_user_id`) REFERENCES `bidsy_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comments_ineditscontainsqna_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `itemClassifies` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments_inEditsContainsQnA`
--

LOCK TABLES `comments_inEditsContainsQnA` WRITE;
/*!40000 ALTER TABLE `comments_inEditsContainsQnA` DISABLE KEYS */;
INSERT INTO `comments_inEditsContainsQnA` VALUES ('ag@bidsy.com','emp1@bidsy.com','2023-04-30 19:35:08',19,'Is the keyboard working properly?','yes it is good'),('ag@bidsy.com',NULL,'2023-05-01 19:16:16',21,'how big is the screen',NULL),('ag@bidsy.com','emp1@bidsy.com','2023-05-01 19:41:01',30,'hdd or ssd','ssd'),('ag@bidsy.com','emp1@bidsy.com','2023-05-01 19:42:16',30,'hdd or ssd','ssd'),('ag@bidsy.com','emp1@bidsy.com','2023-05-01 21:27:43',32,'HDD or SSD drive?','SSD'),('vj@bidsy.com',NULL,'2023-04-30 19:44:24',19,'Does the laptop get hot while using?',NULL);
/*!40000 ALTER TABLE `comments_inEditsContainsQnA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itemClassifies`
--

DROP TABLE IF EXISTS `itemClassifies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itemClassifies` (
  `increment_bid` int DEFAULT NULL,
  `item_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL,
  `starting_price` int DEFAULT NULL,
  `itemDescription` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `start_auction_time` datetime DEFAULT NULL,
  `end_auction_time` datetime DEFAULT NULL,
  `bid_id` int DEFAULT NULL,
  `sub_category_index` int DEFAULT NULL,
  `ram` varchar(5) DEFAULT NULL,
  `display_size` double(10,1) DEFAULT NULL,
  `operating_system` varchar(20) DEFAULT NULL,
  `processor` varchar(200) DEFAULT NULL,
  `hdd` int DEFAULT NULL,
  `graphics` varchar(200) DEFAULT NULL,
  `is_auction_over` int DEFAULT NULL,
  `winning_bid_id` int DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `sub_category_index` (`sub_category_index`),
  CONSTRAINT `itemclassifies_ibfk_1` FOREIGN KEY (`sub_category_index`) REFERENCES `subcategoryBelongs` (`sub_category_index`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itemClassifies`
--

LOCK TABLES `itemClassifies` WRITE;
/*!40000 ALTER TABLE `itemClassifies` DISABLE KEYS */;
INSERT INTO `itemClassifies` VALUES (20,19,'Macbook Air M2',1200,'Macbook Air M2, 2022 Model. Good Condition.','ag@bidsy.com','2023-04-29 18:00:00','2023-04-30 22:00:00',24,5,'16 GB',14.0,'MacOS','M2',512,'AMD',1,NULL),(10,20,'HP Omen 15',1299,'HP Omen 15, 2020 Model. Decent Condition. ','ag@bidsy.com','2023-05-01 19:00:00','2023-05-05 19:00:00',NULL,2,'8 GB',15.0,'Windows 10','Intel Core',1024,'Nvidia',NULL,NULL),(15,21,'HP Spectre ',800,'HP Spectre. Thin laptop. Charger Included.','hk@bidsy.com','2023-04-30 19:00:00','2023-05-14 19:00:00',26,3,'8 GB',13.0,'Windows 10','AMD Ryzen',512,'Intel Graphics',NULL,NULL),(30,22,'Alienware ',1500,'durable heavy laptop. optical mouse included.','hk@bidsy.com','2023-04-09 19:30:00','2023-05-04 19:30:00',NULL,2,'16 GB',16.0,'Windows 11','Intel Core',512,'Nvidia',NULL,NULL),(20,24,'HP Pavillion 360',350,'360 foldable excellent','hk@bidsy.com','2023-03-29 19:30:00','2023-05-06 19:30:00',NULL,4,'4 GB',13.0,'Windows 10','Intel Core',256,'Intel Graphics',NULL,NULL),(20,25,'ROG Zephyrus',1300,'backlight working beautiful','ag@bidsy.com','2023-01-30 19:30:00','2023-10-25 19:30:00',25,2,'32 GB',17.0,'Windows 11','AMD Ryzen',2048,'AMD',NULL,NULL),(40,26,'MSI Predator',2000,'RTX 4070','ag@bidsy.com','2023-04-04 21:30:00','2023-05-25 21:30:00',NULL,2,'32 GB',16.0,'Windows 11','AMD Ryzen',2048,'AMD',NULL,NULL),(20,27,'Surface Pro 9',1279,'360 foldable. good condition.','hk@bidsy.com','2023-04-30 18:30:00','2023-05-01 13:35:00',28,4,'16 GB',14.0,'Windows 11','Intel Core',1024,'Intel Graphics',1,28),(10,29,'Acer Aspire',289,'good condition','ag@bidsy.com','2023-04-30 15:03:00','2023-05-01 14:05:00',29,3,'4 GB',15.0,'Windows 11','Intel Core',512,'Intel Graphics',1,29),(100,30,'macbook pro m2 pro',2000,'Macintosh laptop running on MacOS','johndoe@bidsy.com','2023-05-01 19:36:00','2023-05-01 19:48:00',31,5,'16 GB',15.0,'MacOS','M2',512,'Intel Graphics',1,31),(100,31,'LG Gram',1000,'Lightweight laptop','userone@bidsy.com','2023-05-01 21:05:00','2023-05-01 21:10:00',NULL,5,'8 GB',15.0,'Windows 11','Intel Core',512,'Intel Graphics',1,NULL),(100,32,'LG Gram',1000,'Light-weight laptop for business and casual','nu@bidsy.com','2023-05-01 21:25:00','2023-05-01 21:31:00',33,5,'8 GB',15.0,'Windows 11','Intel Core',512,'Intel Graphics',1,33);
/*!40000 ALTER TABLE `itemClassifies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller`
--

DROP TABLE IF EXISTS `seller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller` (
  `user_id` varchar(30) NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `seller_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `bidsy_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller`
--

LOCK TABLES `seller` WRITE;
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sells`
--

DROP TABLE IF EXISTS `sells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sells` (
  `secret_min_price` int DEFAULT NULL,
  `user_id` varchar(30) NOT NULL,
  `item_id` int NOT NULL AUTO_INCREMENT,
  `bid_increments` int DEFAULT NULL,
  PRIMARY KEY (`user_id`,`item_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `sells_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `bidsy_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sells_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `itemClassifies` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sells`
--

LOCK TABLES `sells` WRITE;
/*!40000 ALTER TABLE `sells` DISABLE KEYS */;
INSERT INTO `sells` VALUES (1500,'ag@bidsy.com',19,NULL),(1450,'ag@bidsy.com',20,NULL),(1600,'ag@bidsy.com',25,NULL),(2500,'ag@bidsy.com',26,NULL),(350,'ag@bidsy.com',29,NULL),(950,'hk@bidsy.com',21,NULL),(2000,'hk@bidsy.com',22,NULL),(500,'hk@bidsy.com',24,NULL),(1400,'hk@bidsy.com',27,NULL),(2000,'johndoe@bidsy.com',30,NULL);
/*!40000 ALTER TABLE `sells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subcategoryBelongs`
--

DROP TABLE IF EXISTS `subcategoryBelongs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subcategoryBelongs` (
  `sub_category_index` int NOT NULL,
  `sub_category_name` varchar(50) DEFAULT NULL,
  `category_index` int DEFAULT NULL,
  PRIMARY KEY (`sub_category_index`),
  KEY `category_index` (`category_index`),
  CONSTRAINT `subcategorybelongs_ibfk_1` FOREIGN KEY (`category_index`) REFERENCES `category` (`category_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subcategoryBelongs`
--

LOCK TABLES `subcategoryBelongs` WRITE;
/*!40000 ALTER TABLE `subcategoryBelongs` DISABLE KEYS */;
INSERT INTO `subcategoryBelongs` VALUES (1,'Ultrabook',1),(2,'Gaming Laptop',1),(3,'Browsing Laptop',1),(4,'Yogabook',1),(5,'Business',1);
/*!40000 ALTER TABLE `subcategoryBelongs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-01 21:51:45
