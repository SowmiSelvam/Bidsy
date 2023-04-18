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
  PRIMARY KEY (`bid_id`),
  KEY `user_id` (`user_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `bids_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `bidsy_user` (`user_id`),
  CONSTRAINT `bids_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `itemClassifies` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bids`
--

LOCK TABLES `bids` WRITE;
/*!40000 ALTER TABLE `bids` DISABLE KEYS */;
INSERT INTO `bids` VALUES (6,1200,800,'2023-04-15 14:20:00',10,'vj@bidsy.com',1),(7,1000,850,'2023-04-16 10:45:00',5,'ag@bidsy.com',1),(8,1100,900,'2023-04-17 13:30:00',10,'hk@bidsy.com',1),(9,1500,1000,'2023-04-18 16:15:00',20,'selvam@bidsy.com',1),(10,1800,1300,'2023-04-16 16:45:00',20,'vj@bidsy.com',2),(11,2000,1400,'2023-04-18 10:30:00',25,'ag@bidsy.com',2),(12,1700,1500,'2023-04-19 12:15:00',30,'hk@bidsy.com',2);
/*!40000 ALTER TABLE `bids` ENABLE KEYS */;
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
  CONSTRAINT `bidsy_employee_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `bidsy_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bidsy_employee`
--

LOCK TABLES `bidsy_employee` WRITE;
/*!40000 ALTER TABLE `bidsy_employee` DISABLE KEYS */;
INSERT INTO `bidsy_employee` VALUES ('1',1,'admin'),('2',0,'emp1@bidsy.com');
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
  `telephone_no` int DEFAULT NULL,
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
INSERT INTO `bidsy_user` VALUES ('admin','','','admin','',0,'admin',0,0,0),('Anubhav','G','285  George St','ag@bidsy.com','ag@bidsy.com',73232,'asdf',1234567890,12345678,1),('First','Employee','New Brunswick','emp1@bidsy.com','emp1@bidsy.com',1234,'sdfg',1234567894,12345678,0),('Hittishi','K','230','hk@bidsy.com','hk@bidsy.com',732322592,'asdf',1234567890,12345678,1),('Sowmiyanarayan','Selvam','285  George St','selvam@bidsy.com','selvam@bidsy.com',732322592,'12345',1234567,12345678,1),('Vijay','S','Vj NB','vj@bidsy.com','vj@bidsy.com',0,'gilma',1234567892,12345678,1);
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
  CONSTRAINT `buyer_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `bidsy_user` (`user_id`)
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
INSERT INTO `category` VALUES (1,'Gaming Laptops'),(2,'Business Laptops'),(3,'Ultrabooks'),(4,'2-in-1 Laptops'),(5,'Budget Laptops'),(6,'High-End Laptops'),(7,'Student Laptops'),(8,'Workstation Laptops'),(9,'Chromebooks');
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
  CONSTRAINT `comments_ineditscontainsqna_ibfk_1` FOREIGN KEY (`q_user_id`) REFERENCES `bidsy_user` (`user_id`),
  CONSTRAINT `comments_ineditscontainsqna_ibfk_2` FOREIGN KEY (`a_user_id`) REFERENCES `bidsy_employee` (`user_id`),
  CONSTRAINT `comments_ineditscontainsqna_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `ItemClassifies` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments_inEditsContainsQnA`
--

LOCK TABLES `comments_inEditsContainsQnA` WRITE;
/*!40000 ALTER TABLE `comments_inEditsContainsQnA` DISABLE KEYS */;
INSERT INTO `comments_inEditsContainsQnA` VALUES ('vj@bidsy.com',NULL,'2023-04-14 11:22:16',1,'Acer is good',''),('vj@bidsy.com',NULL,'2023-04-14 11:24:29',1,'Acer is good',''),('vj@bidsy.com',NULL,'2023-04-14 11:25:23',1,'Acer is good',''),('vj@bidsy.com',NULL,'2023-04-14 11:29:18',1,'Acer is good',''),('vj@bidsy.com',NULL,'2023-04-14 11:47:45',1,'Acer is good 3',''),('vj@bidsy.com',NULL,'2023-04-14 11:50:08',1,'Acer is good 3',''),('vj@bidsy.com',NULL,'2023-04-14 11:51:06',1,'Acer is good 3',''),('vj@bidsy.com',NULL,'2023-04-14 11:52:54',1,'Acer is good 3',''),('vj@bidsy.com',NULL,'2023-04-14 11:54:58',1,'Acer is good 3',''),('vj@bidsy.com',NULL,'2023-04-14 11:56:21',1,'Acer is good',''),('vj@bidsy.com',NULL,'2023-04-14 11:56:39',1,'Acer is good',''),('vj@bidsy.com',NULL,'2023-04-14 11:57:32',1,'Acer is good','');
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
  PRIMARY KEY (`item_id`),
  KEY `sub_category_index` (`sub_category_index`),
  CONSTRAINT `itemclassifies_ibfk_1` FOREIGN KEY (`sub_category_index`) REFERENCES `subcategoryBelongs` (`sub_category_index`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itemClassifies`
--

LOCK TABLES `itemClassifies` WRITE;
/*!40000 ALTER TABLE `itemClassifies` DISABLE KEYS */;
INSERT INTO `itemClassifies` VALUES (1,1,'Acer Predator Helios 300',800,'Gaming Laptop','seller@example.com','2023-04-13 12:00:00','2023-04-20 12:00:00',9,1),(1,2,'Dell XPS 13',1000,'Lightweight Ultrabook','seller@example.com','2023-04-13 12:00:00','2023-04-20 12:00:00',12,3),(1,3,'HP EliteBook 840 G6',900,'Business Laptop','seller@example.com','2023-04-13 12:00:00','2023-04-20 12:00:00',0,6),(1,4,'Lenovo Flex 5',600,'2-in-1 Laptop','seller@example.com','2023-04-13 12:00:00','2023-04-20 12:00:00',0,4),(1,5,'Acer Aspire 5',400,'Budget Laptop','seller@example.com','2023-04-13 12:00:00','2023-04-20 12:00:00',0,5),(1,6,'Dell XPS 17',2000,'High-End Laptop','seller@example.com','2023-04-13 12:00:00','2023-04-20 12:00:00',0,6),(0,7,'Gaming Lap 2000',1200,'Good Condition','','2023-04-12 11:22:00','2023-04-15 11:22:00',0,4),(0,8,'Computer Good ',1200,'Good condition','','2023-04-05 11:24:00','2023-04-24 11:24:00',0,1),(0,9,'Computer Gamin 2000',1000,'Good condition. ','','2023-03-29 11:29:00','2023-04-24 11:29:00',0,1),(0,10,'Gaming Laptop 2000',1000,'Good Condition','','2023-04-06 11:51:00','2023-04-28 11:51:00',0,3),(0,11,'Gaming Laptop 2000',1000,'Good Condition','','2023-04-06 11:51:00','2023-04-28 11:51:00',0,3),(0,12,'Gamin lap 2000',1000,'Good ','','2023-04-12 11:54:00','2023-04-26 11:54:00',0,9),(0,13,'Gaming Laptop 2000',1200,'Good ','','2023-04-10 12:03:00','2023-04-14 12:03:00',0,7),(0,14,'Gamin Lap 2000',1200,'Good','','2023-04-12 12:04:00','2023-04-19 12:04:00',0,5),(50,15,'dfabdfb',1200,'asfvsfg nghnfb','vj@bidsy.com','2023-04-13 12:14:00','2023-04-27 12:14:00',0,5);
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
  CONSTRAINT `seller_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `bidsy_user` (`user_id`)
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
  CONSTRAINT `sells_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `bidsy_user` (`user_id`),
  CONSTRAINT `sells_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `itemClassifies` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sells`
--

LOCK TABLES `sells` WRITE;
/*!40000 ALTER TABLE `sells` DISABLE KEYS */;
INSERT INTO `sells` VALUES (1300,'vj@bidsy.com',14,NULL),(1500,'vj@bidsy.com',15,NULL);
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
INSERT INTO `subcategoryBelongs` VALUES (1,'Acer Predator Helios 300',1),(2,'Dell G5 15',1),(3,'Dell XPS 13',3),(4,'Lenovo Flex 5',4),(5,'Acer Aspire 5',5),(6,'HP EliteBook 840 G6',2),(7,'Apple MacBook Air',7),(8,'Lenovo ThinkPad P17',8),(9,'Google Pixelbook Go',9),(10,'Dell XPS 17',6);
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

-- Dump completed on 2023-04-18  0:00:18
