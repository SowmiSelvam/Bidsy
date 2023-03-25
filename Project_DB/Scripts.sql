CREATE DATABASE  IF NOT EXISTS `bidsydb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bidsydb`;
-- MySQL dump 10.13  Distrib 8.0.29, for macos12 (x86_64)
--
-- Host: localhost    Database: bidsydb
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bidsy_employee`
--

DROP TABLE IF EXISTS bidsy_employee;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE bidsy_employee (
  emp_id varchar(30) DEFAULT NULL,
  is_admin tinyint(1) DEFAULT NULL,
  user_id varchar(30) NOT NULL,
  PRIMARY KEY (user_id),
  CONSTRAINT bidsy_employee_ibfk_1 FOREIGN KEY (user_id) REFERENCES bidsy_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bidsy_employee`
--

LOCK TABLES bidsy_employee WRITE;
/*!40000 ALTER TABLE bidsy_employee DISABLE KEYS */;
INSERT INTO bidsy_employee (emp_id, is_admin, user_id) VALUES ('1',1,'admin');
/*!40000 ALTER TABLE bidsy_employee ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bidsy_user`
--

DROP TABLE IF EXISTS bidsy_user;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE bidsy_user (
  first_name varchar(30) DEFAULT NULL,
  last_name varchar(20) DEFAULT NULL,
  address varchar(100) DEFAULT NULL,
  user_id varchar(30) NOT NULL,
  email varchar(30) DEFAULT NULL,
  telephone_no int DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  bank_acc_no bigint DEFAULT NULL,
  routing_no int DEFAULT NULL,
  is_user tinyint(1) DEFAULT NULL,
  PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bidsy_user`
--

LOCK TABLES bidsy_user WRITE;
/*!40000 ALTER TABLE bidsy_user DISABLE KEYS */;
INSERT INTO bidsy_user (first_name, last_name, address, user_id, email, telephone_no, password, bank_acc_no, routing_no, is_user) VALUES ('admin','','','admin','admin@bidsy.com',0,'system123#',11111111,222222222,0);
/*!40000 ALTER TABLE bidsy_user ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed
