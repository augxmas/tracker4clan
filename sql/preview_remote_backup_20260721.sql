/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.18-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 3.35.190.76    Database: stamptour
-- ------------------------------------------------------
-- Server version	8.0.46-0ubuntu0.24.04.3

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
-- Table structure for table `batch_logs`
--

DROP TABLE IF EXISTS `batch_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `batch_logs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `job_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `source` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unknown',
  `status` enum('ok','error') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ok',
  `result_summary` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `started_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `finished_at` datetime DEFAULT NULL,
  `error_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `idx_job_started` (`job_key`,`started_at`),
  KEY `idx_started` (`started_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1389 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_logs`
--

LOCK TABLES `batch_logs` WRITE;
/*!40000 ALTER TABLE `batch_logs` DISABLE KEYS */;
INSERT INTO `batch_logs` VALUES
(1010,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-01 10:16:56','2026-07-01 10:16:56',NULL,NULL),
(1011,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-01 19:17:54','2026-07-01 10:17:53',NULL,NULL),
(1012,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 00:05:00','2026-07-02 00:05:00',NULL,NULL),
(1013,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 03:54:29','2026-07-02 03:54:30',NULL,NULL),
(1014,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-02 12:55:30','2026-07-02 03:55:30',NULL,NULL),
(1015,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 04:00:08','2026-07-02 04:00:08',NULL,NULL),
(1016,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-02 13:01:08','2026-07-02 04:01:08',NULL,NULL),
(1017,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 04:01:16','2026-07-02 04:01:16',NULL,NULL),
(1018,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 04:01:47','2026-07-02 04:01:47',NULL,NULL),
(1019,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 04:02:51','2026-07-02 04:02:51',NULL,NULL),
(1020,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 04:03:20','2026-07-02 04:03:20',NULL,NULL),
(1021,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 04:03:57','2026-07-02 04:03:57',NULL,NULL),
(1022,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 04:04:06','2026-07-02 04:04:06',NULL,NULL),
(1023,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 04:05:08','2026-07-02 04:05:08',NULL,NULL),
(1024,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-02 13:06:09','2026-07-02 04:06:08',NULL,NULL),
(1025,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 05:05:08','2026-07-02 05:05:09',NULL,NULL),
(1026,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-02 14:05:09','2026-07-02 05:05:09',NULL,NULL),
(1027,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-02 15:05:09','2026-07-02 06:05:09',NULL,NULL),
(1028,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 06:05:09','2026-07-02 06:05:09',NULL,NULL),
(1029,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 07:05:09','2026-07-02 07:05:09',NULL,NULL),
(1030,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-02 16:05:09','2026-07-02 07:05:09',NULL,NULL),
(1031,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 08:05:09','2026-07-02 08:05:09',NULL,NULL),
(1032,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-02 17:05:09','2026-07-02 08:05:09',NULL,NULL),
(1033,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 09:05:09','2026-07-02 09:05:09',NULL,NULL),
(1034,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-02 18:05:09','2026-07-02 09:05:09',NULL,NULL),
(1035,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-02 19:05:09','2026-07-02 10:05:09',NULL,NULL),
(1036,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 10:05:09','2026-07-02 10:05:09',NULL,NULL),
(1037,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 11:37:57','2026-07-02 11:37:57',NULL,NULL),
(1038,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-02 20:38:57','2026-07-02 11:38:57',NULL,NULL),
(1039,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 13:45:08','2026-07-02 13:45:08',NULL,NULL),
(1040,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-02 22:46:09','2026-07-02 13:46:09',NULL,NULL),
(1041,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 14:25:30','2026-07-02 14:25:31',NULL,NULL),
(1042,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-02 23:26:30','2026-07-02 14:26:30',NULL,NULL),
(1043,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 23:45:03','2026-07-02 23:45:03',NULL,NULL),
(1044,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-03 08:46:04','2026-07-02 23:46:03',NULL,NULL),
(1045,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-02 23:49:14','2026-07-02 23:49:15',NULL,NULL),
(1046,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-03 08:50:15','2026-07-02 23:50:14',NULL,NULL),
(1047,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 00:05:00','2026-07-03 00:05:00',NULL,NULL),
(1048,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 00:49:14','2026-07-03 00:49:14',NULL,NULL),
(1049,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-03 09:49:15','2026-07-03 00:49:14',NULL,NULL),
(1050,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 01:06:07','2026-07-03 01:06:08',NULL,NULL),
(1051,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 01:06:37','2026-07-03 01:06:37',NULL,NULL),
(1052,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-03 10:07:37','2026-07-03 01:07:37',NULL,NULL),
(1053,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 01:15:27','2026-07-03 01:15:27',NULL,NULL),
(1054,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 01:15:48','2026-07-03 01:15:48',NULL,NULL),
(1055,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 01:16:13','2026-07-03 01:16:13',NULL,NULL),
(1056,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 01:16:22','2026-07-03 01:16:22',NULL,NULL),
(1057,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 01:16:38','2026-07-03 01:16:38',NULL,NULL),
(1058,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 01:16:55','2026-07-03 01:16:55',NULL,NULL),
(1059,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 01:17:23','2026-07-03 01:17:23',NULL,NULL),
(1060,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-03 10:18:23','2026-07-03 01:18:23',NULL,NULL),
(1061,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 01:46:14','2026-07-03 01:46:14',NULL,NULL),
(1062,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 01:46:45','2026-07-03 01:46:45',NULL,NULL),
(1063,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 01:46:58','2026-07-03 01:46:58',NULL,NULL),
(1064,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-03 10:47:58','2026-07-03 01:47:58',NULL,NULL),
(1065,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 01:57:43','2026-07-03 01:57:43',NULL,NULL),
(1066,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 01:58:08','2026-07-03 01:58:08',NULL,NULL),
(1067,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 01:58:13','2026-07-03 01:58:13',NULL,NULL),
(1068,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 01:58:53','2026-07-03 01:58:53',NULL,NULL),
(1069,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 01:59:01','2026-07-03 01:59:01',NULL,NULL),
(1070,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-03 11:00:01','2026-07-03 02:00:01',NULL,NULL),
(1071,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 02:59:01','2026-07-03 02:59:01',NULL,NULL),
(1072,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-03 11:59:01','2026-07-03 02:59:01',NULL,NULL),
(1073,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 03:59:01','2026-07-03 03:59:01',NULL,NULL),
(1074,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-03 12:59:01','2026-07-03 03:59:01',NULL,NULL),
(1075,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 04:59:01','2026-07-03 04:59:01',NULL,NULL),
(1076,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-03 13:59:01','2026-07-03 04:59:01',NULL,NULL),
(1077,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 11:57:19','2026-07-03 11:57:19',NULL,NULL),
(1078,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-03 14:58:58','2026-07-03 11:57:19',NULL,NULL),
(1079,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 12:57:19','2026-07-03 12:57:19',NULL,NULL),
(1080,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-03 21:57:19','2026-07-03 12:57:19',NULL,NULL),
(1081,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 13:57:19','2026-07-03 13:57:19',NULL,NULL),
(1082,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-03 22:57:19','2026-07-03 13:57:19',NULL,NULL),
(1083,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 14:57:19','2026-07-03 14:57:19',NULL,NULL),
(1084,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-03 23:57:19','2026-07-03 14:57:19',NULL,NULL),
(1085,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 15:57:19','2026-07-03 15:57:19',NULL,NULL),
(1086,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 00:57:19','2026-07-03 15:57:19',NULL,NULL),
(1087,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 16:57:19','2026-07-03 16:57:19',NULL,NULL),
(1088,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 01:57:19','2026-07-03 16:57:19',NULL,NULL),
(1089,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 17:57:19','2026-07-03 17:57:19',NULL,NULL),
(1090,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 02:57:19','2026-07-03 17:57:19',NULL,NULL),
(1091,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 03:57:19','2026-07-03 18:57:19',NULL,NULL),
(1092,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 18:57:19','2026-07-03 18:57:19',NULL,NULL),
(1093,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 19:57:19','2026-07-03 19:57:19',NULL,NULL),
(1094,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 04:57:19','2026-07-03 19:57:19',NULL,NULL),
(1095,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 20:57:19','2026-07-03 20:57:19',NULL,NULL),
(1096,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 05:57:19','2026-07-03 20:57:19',NULL,NULL),
(1097,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 21:57:19','2026-07-03 21:57:19',NULL,NULL),
(1098,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 06:57:20','2026-07-03 21:57:19',NULL,NULL),
(1099,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 22:42:44','2026-07-03 22:42:44',NULL,NULL),
(1100,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 07:43:44','2026-07-03 22:43:44',NULL,NULL),
(1101,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 23:28:13','2026-07-03 23:28:13',NULL,NULL),
(1102,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 08:29:14','2026-07-03 23:29:13',NULL,NULL),
(1103,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 23:36:29','2026-07-03 23:36:30',NULL,NULL),
(1104,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 08:37:30','2026-07-03 23:37:30',NULL,NULL),
(1105,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 23:49:16','2026-07-03 23:49:16',NULL,NULL),
(1106,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 23:49:59','2026-07-03 23:49:59',NULL,NULL),
(1107,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 08:50:59','2026-07-03 23:50:59',NULL,NULL),
(1108,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-03 23:58:12','2026-07-03 23:58:12',NULL,NULL),
(1109,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 08:59:12','2026-07-03 23:59:12',NULL,NULL),
(1110,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 00:05:00','2026-07-04 00:05:00',NULL,NULL),
(1111,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 00:58:12','2026-07-04 00:58:12',NULL,NULL),
(1112,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 09:58:12','2026-07-04 00:58:12',NULL,NULL),
(1113,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 01:58:12','2026-07-04 01:58:12',NULL,NULL),
(1114,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 10:58:12','2026-07-04 01:58:12',NULL,NULL),
(1115,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 02:36:39','2026-07-04 02:36:39',NULL,NULL),
(1116,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 11:37:39','2026-07-04 02:37:39',NULL,NULL),
(1117,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 12:36:39','2026-07-04 03:36:39',NULL,NULL),
(1118,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 03:36:39','2026-07-04 03:36:39',NULL,NULL),
(1119,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 04:20:19','2026-07-04 04:20:19',NULL,NULL),
(1120,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 13:21:20','2026-07-04 04:21:19',NULL,NULL),
(1121,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 04:28:18','2026-07-04 04:28:18',NULL,NULL),
(1122,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 13:29:19','2026-07-04 04:29:18',NULL,NULL),
(1123,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 04:36:59','2026-07-04 04:36:59',NULL,NULL),
(1124,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 04:37:13','2026-07-04 04:37:13',NULL,NULL),
(1125,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 13:38:13','2026-07-04 04:38:13',NULL,NULL),
(1126,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 04:50:43','2026-07-04 04:50:43',NULL,NULL),
(1127,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 04:51:21','2026-07-04 04:51:21',NULL,NULL),
(1128,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 13:52:21','2026-07-04 04:52:21',NULL,NULL),
(1129,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 04:59:51','2026-07-04 04:59:51',NULL,NULL),
(1130,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 14:00:52','2026-07-04 05:00:51',NULL,NULL),
(1131,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 05:04:43','2026-07-04 05:04:43',NULL,NULL),
(1132,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 05:05:01','2026-07-04 05:05:01',NULL,NULL),
(1133,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 14:06:02','2026-07-04 05:06:01',NULL,NULL),
(1134,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 05:13:29','2026-07-04 05:13:29',NULL,NULL),
(1135,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 05:13:39','2026-07-04 05:13:39',NULL,NULL),
(1136,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 05:13:49','2026-07-04 05:13:49',NULL,NULL),
(1137,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 05:13:58','2026-07-04 05:13:58',NULL,NULL),
(1138,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 05:14:18','2026-07-04 05:14:18',NULL,NULL),
(1139,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 05:14:29','2026-07-04 05:14:29',NULL,NULL),
(1140,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 14:15:29','2026-07-04 05:15:29',NULL,NULL),
(1141,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 05:16:06','2026-07-04 05:16:06',NULL,NULL),
(1142,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 14:17:07','2026-07-04 05:17:06',NULL,NULL),
(1143,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 05:22:22','2026-07-04 05:22:22',NULL,NULL),
(1144,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 05:23:06','2026-07-04 05:23:06',NULL,NULL),
(1145,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 14:24:06','2026-07-04 05:24:06',NULL,NULL),
(1146,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 05:53:35','2026-07-04 05:53:35',NULL,NULL),
(1147,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 14:54:35','2026-07-04 05:54:35',NULL,NULL),
(1148,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 06:17:48','2026-07-04 06:17:48',NULL,NULL),
(1149,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 15:18:48','2026-07-04 06:18:48',NULL,NULL),
(1150,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 06:26:46','2026-07-04 06:26:46',NULL,NULL),
(1151,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 15:27:47','2026-07-04 06:27:46',NULL,NULL),
(1152,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 06:30:49','2026-07-04 06:30:49',NULL,NULL),
(1153,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 06:31:07','2026-07-04 06:31:07',NULL,NULL),
(1154,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 15:32:07','2026-07-04 06:32:07',NULL,NULL),
(1155,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 06:34:38','2026-07-04 06:34:38',NULL,NULL),
(1156,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 15:35:39','2026-07-04 06:35:38',NULL,NULL),
(1157,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 06:57:44','2026-07-04 06:57:44',NULL,NULL),
(1158,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 06:57:49','2026-07-04 06:57:49',NULL,NULL),
(1159,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 06:58:07','2026-07-04 06:58:07',NULL,NULL),
(1160,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 15:59:08','2026-07-04 06:59:07',NULL,NULL),
(1161,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 07:12:50','2026-07-04 07:12:50',NULL,NULL),
(1162,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 07:12:56','2026-07-04 07:12:56',NULL,NULL),
(1163,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 07:13:00','2026-07-04 07:13:00',NULL,NULL),
(1164,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 07:13:05','2026-07-04 07:13:05',NULL,NULL),
(1165,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 07:13:35','2026-07-04 07:13:35',NULL,NULL),
(1166,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 07:13:54','2026-07-04 07:13:54',NULL,NULL),
(1167,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 16:14:54','2026-07-04 07:14:54',NULL,NULL),
(1168,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 07:21:14','2026-07-04 07:21:14',NULL,NULL),
(1169,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 07:21:33','2026-07-04 07:21:33',NULL,NULL),
(1170,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 07:21:49','2026-07-04 07:21:49',NULL,NULL),
(1171,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 07:21:54','2026-07-04 07:21:54',NULL,NULL),
(1172,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 07:22:01','2026-07-04 07:22:01',NULL,NULL),
(1173,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 07:22:14','2026-07-04 07:22:14',NULL,NULL),
(1174,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 16:23:15','2026-07-04 07:23:14',NULL,NULL),
(1175,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 17:22:15','2026-07-04 08:22:15',NULL,NULL),
(1176,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 08:22:14','2026-07-04 08:22:15',NULL,NULL),
(1177,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 08:47:38','2026-07-04 08:47:38',NULL,NULL),
(1178,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 17:48:38','2026-07-04 08:48:38',NULL,NULL),
(1179,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 10:42:59','2026-07-04 10:42:59',NULL,NULL),
(1180,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 19:43:59','2026-07-04 10:43:59',NULL,NULL),
(1181,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 10:49:00','2026-07-04 10:49:00',NULL,NULL),
(1182,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 10:49:14','2026-07-04 10:49:14',NULL,NULL),
(1183,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 10:49:26','2026-07-04 10:49:26',NULL,NULL),
(1184,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 10:49:50','2026-07-04 10:49:50',NULL,NULL),
(1185,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 10:50:05','2026-07-04 10:50:05',NULL,NULL),
(1186,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 19:51:06','2026-07-04 10:51:05',NULL,NULL),
(1187,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 11:23:28','2026-07-04 11:23:28',NULL,NULL),
(1188,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 11:23:39','2026-07-04 11:23:39',NULL,NULL),
(1189,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 11:23:53','2026-07-04 11:23:53',NULL,NULL),
(1190,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 11:23:58','2026-07-04 11:23:58',NULL,NULL),
(1191,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 20:24:59','2026-07-04 11:24:58',NULL,NULL),
(1192,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 11:31:14','2026-07-04 11:31:14',NULL,NULL),
(1193,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 20:32:14','2026-07-04 11:32:14',NULL,NULL),
(1194,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 11:37:31','2026-07-04 11:37:31',NULL,NULL),
(1195,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 11:37:38','2026-07-04 11:37:38',NULL,NULL),
(1196,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 20:38:38','2026-07-04 11:38:38',NULL,NULL),
(1197,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 11:50:56','2026-07-04 11:50:56',NULL,NULL),
(1198,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 11:51:16','2026-07-04 11:51:16',NULL,NULL),
(1199,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 11:51:39','2026-07-04 11:51:39',NULL,NULL),
(1200,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 20:52:39','2026-07-04 11:52:39',NULL,NULL),
(1201,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 12:09:33','2026-07-04 12:09:33',NULL,NULL),
(1202,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 12:09:55','2026-07-04 12:09:55',NULL,NULL),
(1203,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 21:10:56','2026-07-04 12:10:55',NULL,NULL),
(1204,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 12:12:22','2026-07-04 12:12:22',NULL,NULL),
(1205,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 21:13:22','2026-07-04 12:13:21',NULL,NULL),
(1206,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 12:28:56','2026-07-04 12:28:56',NULL,NULL),
(1207,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 21:29:56','2026-07-04 12:29:56',NULL,NULL),
(1208,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 12:34:45','2026-07-04 12:34:45',NULL,NULL),
(1209,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 21:35:46','2026-07-04 12:35:45',NULL,NULL),
(1210,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 12:46:57','2026-07-04 12:46:57',NULL,NULL),
(1211,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 21:47:58','2026-07-04 12:47:57',NULL,NULL),
(1212,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 12:48:01','2026-07-04 12:48:01',NULL,NULL),
(1213,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 12:48:25','2026-07-04 12:48:25',NULL,NULL),
(1214,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 21:49:25','2026-07-04 12:49:25',NULL,NULL),
(1215,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 12:51:27','2026-07-04 12:51:27',NULL,NULL),
(1216,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 21:52:27','2026-07-04 12:52:27',NULL,NULL),
(1217,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 12:54:36','2026-07-04 12:54:36',NULL,NULL),
(1218,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 21:55:37','2026-07-04 12:55:36',NULL,NULL),
(1219,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 13:07:02','2026-07-04 13:07:02',NULL,NULL),
(1220,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 13:07:22','2026-07-04 13:07:22',NULL,NULL),
(1221,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 22:08:22','2026-07-04 13:08:22',NULL,NULL),
(1222,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-04 13:22:13','2026-07-04 13:22:13',NULL,NULL),
(1223,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-04 22:23:14','2026-07-04 13:23:13',NULL,NULL),
(1224,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 00:05:00','2026-07-05 00:05:00',NULL,NULL),
(1225,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 00:55:15','2026-07-05 00:55:15',NULL,NULL),
(1226,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-05 09:56:16','2026-07-05 00:56:15',NULL,NULL),
(1227,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 01:01:17','2026-07-05 01:01:17',NULL,NULL),
(1228,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 01:01:42','2026-07-05 01:01:42',NULL,NULL),
(1229,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 01:02:18','2026-07-05 01:02:19',NULL,NULL),
(1230,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-05 10:03:19','2026-07-05 01:03:18',NULL,NULL),
(1231,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 01:10:35','2026-07-05 01:10:35',NULL,NULL),
(1232,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 01:10:49','2026-07-05 01:10:49',NULL,NULL),
(1233,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-05 10:11:49','2026-07-05 01:11:49',NULL,NULL),
(1234,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 01:17:05','2026-07-05 01:17:05',NULL,NULL),
(1235,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 01:17:26','2026-07-05 01:17:26',NULL,NULL),
(1236,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 01:18:16','2026-07-05 01:18:16',NULL,NULL),
(1237,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-05 10:19:16','2026-07-05 01:19:16',NULL,NULL),
(1238,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 01:28:43','2026-07-05 01:28:43',NULL,NULL),
(1239,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 01:29:13','2026-07-05 01:29:13',NULL,NULL),
(1240,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-05 10:30:13','2026-07-05 01:30:13',NULL,NULL),
(1241,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 02:29:13','2026-07-05 02:29:13',NULL,NULL),
(1242,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-05 11:29:13','2026-07-05 02:29:13',NULL,NULL),
(1243,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-05 12:29:14','2026-07-05 03:29:13',NULL,NULL),
(1244,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 03:29:13','2026-07-05 03:29:13',NULL,NULL),
(1245,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 04:07:47','2026-07-05 04:07:47',NULL,NULL),
(1246,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 04:07:56','2026-07-05 04:07:56',NULL,NULL),
(1247,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 04:08:18','2026-07-05 04:08:18',NULL,NULL),
(1248,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-05 13:09:18','2026-07-05 04:09:18',NULL,NULL),
(1249,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 04:10:14','2026-07-05 04:10:14',NULL,NULL),
(1250,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-05 13:11:14','2026-07-05 04:11:14',NULL,NULL),
(1251,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 04:31:04','2026-07-05 04:31:04',NULL,NULL),
(1252,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 04:31:25','2026-07-05 04:31:25',NULL,NULL),
(1253,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 04:32:00','2026-07-05 04:32:00',NULL,NULL),
(1254,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 04:32:15','2026-07-05 04:32:15',NULL,NULL),
(1255,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 04:32:49','2026-07-05 04:32:49',NULL,NULL),
(1256,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 04:33:04','2026-07-05 04:33:04',NULL,NULL),
(1257,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-05 13:34:05','2026-07-05 04:34:04',NULL,NULL),
(1258,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 04:34:25','2026-07-05 04:34:25',NULL,NULL),
(1259,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-05 13:35:25','2026-07-05 04:35:25',NULL,NULL),
(1260,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 04:40:38','2026-07-05 04:40:38',NULL,NULL),
(1261,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-05 13:41:39','2026-07-05 04:41:38',NULL,NULL),
(1262,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 04:53:16','2026-07-05 04:53:16',NULL,NULL),
(1263,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-05 13:54:17','2026-07-05 04:54:16',NULL,NULL),
(1264,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 05:01:10','2026-07-05 05:01:10',NULL,NULL),
(1265,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-05 14:02:10','2026-07-05 05:02:10',NULL,NULL),
(1266,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 05:14:20','2026-07-05 05:14:20',NULL,NULL),
(1267,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 05:14:51','2026-07-05 05:14:51',NULL,NULL),
(1268,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 05:15:25','2026-07-05 05:15:25',NULL,NULL),
(1269,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 05:15:33','2026-07-05 05:15:33',NULL,NULL),
(1270,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 05:15:41','2026-07-05 05:15:41',NULL,NULL),
(1271,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-05 14:16:42','2026-07-05 05:16:41',NULL,NULL),
(1272,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-05 05:17:07','2026-07-05 05:17:07',NULL,NULL),
(1273,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-05 14:18:07','2026-07-05 05:18:07',NULL,NULL),
(1274,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-06 00:05:00','2026-07-06 00:05:00',NULL,NULL),
(1275,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-06 06:46:22','2026-07-06 06:46:22',NULL,NULL),
(1276,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-06 15:47:22','2026-07-06 06:47:22',NULL,NULL),
(1277,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-06 08:56:41','2026-07-06 08:56:41',NULL,NULL),
(1278,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-06 17:57:41','2026-07-06 08:57:41',NULL,NULL),
(1279,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-07 00:05:00','2026-07-07 00:05:00',NULL,NULL),
(1280,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-07 00:33:18','2026-07-07 00:33:18',NULL,NULL),
(1281,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-07 09:34:19','2026-07-07 00:34:18',NULL,NULL),
(1282,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-07 02:39:27','2026-07-07 02:39:27',NULL,NULL),
(1283,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-07 11:40:28','2026-07-07 02:40:27',NULL,NULL),
(1284,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-07 03:39:27','2026-07-07 03:39:27',NULL,NULL),
(1285,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-07 12:39:28','2026-07-07 03:39:27',NULL,NULL),
(1286,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-07 04:39:27','2026-07-07 04:39:27',NULL,NULL),
(1287,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-07 13:39:28','2026-07-07 04:39:27',NULL,NULL),
(1288,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-07 05:16:54','2026-07-07 05:16:54',NULL,NULL),
(1289,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-07 14:17:54','2026-07-07 05:17:54',NULL,NULL),
(1290,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-07 06:16:54','2026-07-07 06:16:54',NULL,NULL),
(1291,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-07 15:16:54','2026-07-07 06:16:54',NULL,NULL),
(1292,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-07 07:16:54','2026-07-07 07:16:54',NULL,NULL),
(1293,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-07 16:16:54','2026-07-07 07:16:54',NULL,NULL),
(1294,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-07 08:16:54','2026-07-07 08:16:54',NULL,NULL),
(1295,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-07 17:16:54','2026-07-07 08:16:54',NULL,NULL),
(1296,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-07 09:16:54','2026-07-07 09:16:54',NULL,NULL),
(1297,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-07 18:16:54','2026-07-07 09:16:54',NULL,NULL),
(1298,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-08 00:05:00','2026-07-08 00:05:01',NULL,NULL),
(1299,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-08 12:00:04','2026-07-08 12:00:04',NULL,NULL),
(1300,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-08 21:01:04','2026-07-08 12:01:04',NULL,NULL),
(1301,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-08 13:00:04','2026-07-08 13:00:04',NULL,NULL),
(1302,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-08 22:00:04','2026-07-08 13:00:04',NULL,NULL),
(1303,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-08 14:00:04','2026-07-08 14:00:04',NULL,NULL),
(1304,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-08 23:00:04','2026-07-08 14:00:04',NULL,NULL),
(1305,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-08 15:00:04','2026-07-08 15:00:04',NULL,NULL),
(1306,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-09 00:00:04','2026-07-08 15:00:04',NULL,NULL),
(1307,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-09 01:00:04','2026-07-08 16:00:04',NULL,NULL),
(1308,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-08 16:00:04','2026-07-08 16:00:04',NULL,NULL),
(1309,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-09 00:05:01','2026-07-09 00:05:01',NULL,NULL),
(1310,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-10 00:05:00','2026-07-10 00:05:01',NULL,NULL),
(1311,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-11 00:05:00','2026-07-11 00:05:00',NULL,NULL),
(1312,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-11 07:35:44','2026-07-11 07:35:44',NULL,NULL),
(1313,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-11 16:36:45','2026-07-11 07:36:44',NULL,NULL),
(1314,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-11 08:35:44','2026-07-11 08:35:44',NULL,NULL),
(1315,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-11 17:35:45','2026-07-11 08:35:44',NULL,NULL),
(1316,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-11 09:35:44','2026-07-11 09:35:44',NULL,NULL),
(1317,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-11 18:35:45','2026-07-11 09:35:44',NULL,NULL),
(1318,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-11 10:35:44','2026-07-11 10:35:44',NULL,NULL),
(1319,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-11 19:35:45','2026-07-11 10:35:44',NULL,NULL),
(1320,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-11 11:35:44','2026-07-11 11:35:44',NULL,NULL),
(1321,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-11 20:35:45','2026-07-11 11:35:44',NULL,NULL),
(1322,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-11 12:35:44','2026-07-11 12:35:44',NULL,NULL),
(1323,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-11 21:35:45','2026-07-11 12:35:44',NULL,NULL),
(1324,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-11 13:35:44','2026-07-11 13:35:45',NULL,NULL),
(1325,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-11 22:35:45','2026-07-11 13:35:45',NULL,NULL),
(1326,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-11 23:35:45','2026-07-11 14:35:45',NULL,NULL),
(1327,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-11 14:35:45','2026-07-11 14:35:45',NULL,NULL),
(1328,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 00:05:00','2026-07-12 00:05:00',NULL,NULL),
(1329,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 00:57:06','2026-07-12 00:57:06',NULL,NULL),
(1330,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 00:57:11','2026-07-12 00:57:11',NULL,NULL),
(1331,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 00:57:21','2026-07-12 00:57:21',NULL,NULL),
(1332,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 00:57:30','2026-07-12 00:57:30',NULL,NULL),
(1333,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-12 09:58:31','2026-07-12 00:58:30',NULL,NULL),
(1334,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 00:58:59','2026-07-12 00:58:59',NULL,NULL),
(1335,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-12 09:59:59','2026-07-12 00:59:59',NULL,NULL),
(1336,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 01:09:09','2026-07-12 01:09:09',NULL,NULL),
(1337,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 01:09:30','2026-07-12 01:09:31',NULL,NULL),
(1338,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-12 10:10:31','2026-07-12 01:10:31',NULL,NULL),
(1339,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 01:11:33','2026-07-12 01:11:33',NULL,NULL),
(1340,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-12 10:12:33','2026-07-12 01:12:33',NULL,NULL),
(1341,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 01:14:53','2026-07-12 01:14:53',NULL,NULL),
(1342,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 01:15:00','2026-07-12 01:15:00',NULL,NULL),
(1343,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-12 10:16:00','2026-07-12 01:16:00',NULL,NULL),
(1344,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 01:18:55','2026-07-12 01:18:55',NULL,NULL),
(1345,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-12 10:19:55','2026-07-12 01:19:55',NULL,NULL),
(1346,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 01:25:44','2026-07-12 01:25:44',NULL,NULL),
(1347,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 01:25:56','2026-07-12 01:25:56',NULL,NULL),
(1348,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-12 10:26:56','2026-07-12 01:26:56',NULL,NULL),
(1349,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 01:31:22','2026-07-12 01:31:22',NULL,NULL),
(1350,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 01:32:03','2026-07-12 01:32:03',NULL,NULL),
(1351,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 01:32:25','2026-07-12 01:32:25',NULL,NULL),
(1352,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 01:32:31','2026-07-12 01:32:31',NULL,NULL),
(1353,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 01:32:42','2026-07-12 01:32:42',NULL,NULL),
(1354,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-12 10:33:42','2026-07-12 01:33:42',NULL,NULL),
(1355,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 01:35:34','2026-07-12 01:35:34',NULL,NULL),
(1356,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 01:35:48','2026-07-12 01:35:48',NULL,NULL),
(1357,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-12 10:36:48','2026-07-12 01:36:48',NULL,NULL),
(1358,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 02:05:41','2026-07-12 02:05:41',NULL,NULL),
(1359,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-12 11:06:42','2026-07-12 02:06:41',NULL,NULL),
(1360,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-12 12:05:42','2026-07-12 03:05:41',NULL,NULL),
(1361,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 03:05:41','2026-07-12 03:05:41',NULL,NULL),
(1362,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-12 13:05:42','2026-07-12 04:05:41',NULL,NULL),
(1363,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 04:05:41','2026-07-12 04:05:41',NULL,NULL),
(1364,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-12 05:05:41','2026-07-12 05:05:42',NULL,NULL),
(1365,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-12 14:05:42','2026-07-12 05:05:42',NULL,NULL),
(1366,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-13 00:05:01','2026-07-13 00:05:01',NULL,NULL),
(1367,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-14 00:05:01','2026-07-14 00:05:01',NULL,NULL),
(1368,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-15 00:05:00','2026-07-15 00:05:00',NULL,NULL),
(1369,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-15 06:09:24','2026-07-15 06:09:24',NULL,NULL),
(1370,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-15 15:10:24','2026-07-15 06:10:24',NULL,NULL),
(1371,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-15 07:09:24','2026-07-15 07:09:24',NULL,NULL),
(1372,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-15 16:09:24','2026-07-15 07:09:24',NULL,NULL),
(1373,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-15 17:09:24','2026-07-15 08:09:24',NULL,NULL),
(1374,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-15 08:09:24','2026-07-15 08:09:24',NULL,NULL),
(1375,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-15 09:18:34','2026-07-15 09:18:34',NULL,NULL),
(1376,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-15 18:19:34','2026-07-15 09:19:34',NULL,NULL),
(1377,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-15 10:18:34','2026-07-15 10:18:34',NULL,NULL),
(1378,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-15 19:18:34','2026-07-15 10:18:34',NULL,NULL),
(1379,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-15 11:55:05','2026-07-15 11:55:05',NULL,NULL),
(1380,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-15 20:55:05','2026-07-15 11:55:05',NULL,NULL),
(1381,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-16 00:05:01','2026-07-16 00:05:01',NULL,NULL),
(1382,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-17 00:05:00','2026-07-17 00:05:00',NULL,NULL),
(1383,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-18 00:05:01','2026-07-18 00:05:01',NULL,NULL),
(1384,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-19 00:05:01','2026-07-19 00:05:01',NULL,NULL),
(1385,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-20 00:05:01','2026-07-20 00:05:01',NULL,NULL),
(1386,'sp_update_project_statuses','event','ok','started:0 / ready_to_start:0 / completed:0','2026-07-21 00:05:01','2026-07-21 00:05:01',NULL,NULL),
(1387,'sp_update_project_statuses','node','ok','started:0 / ready_to_start:0 / completed:0','2026-07-21 14:48:10','2026-07-21 14:48:10',NULL,NULL),
(1388,'project_ending_notice','node','ok','projects:0 / sent:0 / skipped:0 / failed:0','2026-07-21 23:49:10','2026-07-21 14:49:09',NULL,NULL);
/*!40000 ALTER TABLE `batch_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_logs`
--

DROP TABLE IF EXISTS `email_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_logs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `template_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `to_email` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` bigint DEFAULT NULL,
  `host_id` bigint DEFAULT NULL,
  `status` enum('sent','failed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger_type` enum('auto','manual') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'auto',
  `error_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=163 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_logs`
--

LOCK TABLES `email_logs` WRITE;
/*!40000 ALTER TABLE `email_logs` DISABLE KEYS */;
INSERT INTO `email_logs` VALUES
(135,'email_verify','kimch@monorama.kr','[모노라마] 이메일 인증 코드',NULL,NULL,'sent','auto',NULL,'2026-07-02 04:50:23'),
(136,'host_registration_submitted','kimch@monorama.kr','[모노라마] 회원가입 신청이 완료되었습니다',NULL,4,'sent','auto',NULL,'2026-07-02 07:41:05'),
(137,'supervisor_new_host','kimch@mono-rama.com','[모노라마 트래커] 신규 Host 가입 신청 확인 요청',NULL,4,'sent','auto',NULL,'2026-07-02 07:41:06'),
(138,'host_status_approved','kimch@monorama.kr','[모노라마] 회원가입이 승인되었습니다',NULL,4,'sent','auto',NULL,'2026-07-02 07:41:50'),
(139,'email_verify','nitsuser@naver.com','[모노라마] 이메일 인증 코드',NULL,NULL,'sent','auto',NULL,'2026-07-02 23:56:11'),
(140,'merchant_registration_submitted','nitsuser@naver.com','[모노라마] 가맹점 가입 신청이 완료되었습니다',NULL,NULL,'sent','auto',NULL,'2026-07-02 23:59:12'),
(141,'supervisor_new_merchant','kimch@mono-rama.com','[Tour Tracker] 신규 가맹점 가입 신청 확인 요청',NULL,NULL,'sent','auto',NULL,'2026-07-02 23:59:13'),
(142,'merchant_status_approved','nitsuser@naver.com','[모노라마] 가맹점 가입이 승인되었습니다',NULL,NULL,'sent','auto',NULL,'2026-07-03 00:02:13'),
(143,'project_pin','kimch@monorama.kr','[모노라마] Gift 승인 비밀번호',NULL,4,'sent','auto',NULL,'2026-07-04 02:14:54'),
(144,'tour_merchant_commission_approval','kimch@mono-rama.com','[Tour Tracker] Bangkok Old City Heritage Walk 가맹점 승인 요청',8,4,'sent','auto',NULL,'2026-07-04 05:24:24'),
(145,'tour_merchant_commission_approval','wefuture@nate.com','[Tour Tracker] Bangkok Old City Heritage Walk 가맹점 승인 요청',8,4,'sent','auto',NULL,'2026-07-04 05:24:25'),
(146,'host_temp_password','kimch@monorama.kr','[모노라마] 임시 비밀번호 안내',NULL,4,'sent','auto',NULL,'2026-07-04 05:56:46'),
(147,'thai_merchant_password_reset_request','kimch@mono-rama.com','[Tour Tracker] 태국 가맹점 비밀번호 재설정 안내',NULL,NULL,'sent','auto',NULL,'2026-07-04 06:33:14'),
(148,'thai_merchant_temp_password','kimch@mono-rama.com','[Tour Tracker] 태국 가맹점 임시 비밀번호 안내',NULL,NULL,'sent','auto',NULL,'2026-07-04 06:53:25'),
(149,'thai_merchant_temp_password','kimch@mono-rama.com','[Tour Tracker] 태국 가맹점 임시 비밀번호 안내',NULL,NULL,'sent','auto',NULL,'2026-07-04 07:06:10'),
(150,'tour_merchant_commission_approval','kimch@mono-rama.com','[Tour Tracker] Bangkok Old City Heritage Walk 가맹점 승인 요청',8,4,'sent','auto',NULL,'2026-07-04 07:16:12'),
(151,'tour_merchant_commission_approval','wefuture@nate.com','[Tour Tracker] Bangkok Old City Heritage Walk 가맹점 승인 요청',8,4,'sent','auto',NULL,'2026-07-04 07:16:13'),
(152,'tour_merchant_commission_approval','kimch@mono-rama.com','[Tour Tracker] Bangkok Old City Heritage Walk 가맹점 승인 요청',8,4,'sent','auto',NULL,'2026-07-04 07:24:47'),
(153,'tour_merchant_commission_approval','wefuture@nate.com','[Tour Tracker] Bangkok Old City Heritage Walk 가맹점 승인 요청',8,4,'sent','auto',NULL,'2026-07-04 07:24:47'),
(154,'tour_merchant_commission_approval','wefuture@nate.com','[Tour Tracker] Bangkok Old City Heritage Walk 가맹점 승인 요청',8,4,'sent','auto',NULL,'2026-07-04 07:26:39'),
(155,'thai_merchant_temp_password','wefuture@nate.com','[Tour Tracker] 태국 가맹점 임시 비밀번호 안내',NULL,NULL,'sent','auto',NULL,'2026-07-04 07:34:10'),
(156,'tour_merchant_commission_approval','kimch@mono-rama.com','[Tour Tracker] Bangkok Food & Night Market Route 가맹점 승인 요청',9,4,'sent','auto',NULL,'2026-07-04 07:35:23'),
(157,'tour_merchant_commission_approval','wefuture@nate.com','[Tour Tracker] Bangkok Food & Night Market Route 가맹점 승인 요청',9,4,'sent','auto',NULL,'2026-07-04 07:35:24'),
(158,'tour_merchant_commission_approval','kimch@mono-rama.com','[Tour Tracker] Bangkok Old City Heritage Walk 가맹점 승인 요청',8,4,'sent','auto',NULL,'2026-07-04 10:56:00'),
(159,'tour_merchant_commission_approval','wefuture@nate.com','[Tour Tracker] Bangkok Old City Heritage Walk 가맹점 승인 요청',8,4,'sent','auto',NULL,'2026-07-04 10:56:01'),
(160,'thai_merchant_temp_password','wefuture@nate.com','[Tour Tracker] 태국 가맹점 임시 비밀번호 안내',NULL,NULL,'sent','auto',NULL,'2026-07-04 11:16:22'),
(161,'thai_merchant_temp_password','wefuture@nate.com','[Tour Tracker] 태국 가맹점 임시 비밀번호 안내',NULL,NULL,'sent','auto',NULL,'2026-07-04 12:02:15'),
(162,'thai_merchant_temp_password','kimch@mono-rama.com','[Tour Tracker] 태국 가맹점 임시 비밀번호 안내',NULL,NULL,'sent','auto',NULL,'2026-07-04 12:07:50');
/*!40000 ALTER TABLE `email_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_templates`
--

DROP TABLE IF EXISTS `email_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_templates` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `template_key` varchar(64) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `subject` varchar(255) NOT NULL,
  `body_html` mediumtext NOT NULL,
  `variables` json DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `template_key` (`template_key`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_templates`
--

LOCK TABLES `email_templates` WRITE;
/*!40000 ALTER TABLE `email_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_agent_attendance`
--

DROP TABLE IF EXISTS `field_agent_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `field_agent_attendance` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `agent_id` bigint NOT NULL,
  `project_id` bigint NOT NULL,
  `attended_date` date NOT NULL,
  `checked_in_at` datetime NOT NULL,
  `attendance_type` enum('on_time','late') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_attendance_day` (`agent_id`,`attended_date`),
  KEY `idx_attendance_proj_date` (`project_id`,`attended_date`),
  CONSTRAINT `field_agent_attendance_ibfk_1` FOREIGN KEY (`agent_id`) REFERENCES `field_agents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `field_agent_attendance_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_agent_attendance`
--

LOCK TABLES `field_agent_attendance` WRITE;
/*!40000 ALTER TABLE `field_agent_attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_agent_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_agents`
--

DROP TABLE IF EXISTS `field_agents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `field_agents` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_lower` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_card_image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bankbook_image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `terms_accepted` tinyint(1) NOT NULL DEFAULT '0',
  `privacy_accepted` tinyint(1) NOT NULL DEFAULT '0',
  `email_optin` tinyint(1) NOT NULL DEFAULT '0',
  `push_optin` tinyint(1) NOT NULL DEFAULT '0',
  `qr_token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `qr_image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `qr_token` (`qr_token`),
  UNIQUE KEY `uq_agent_project_email` (`project_id`,`email_lower`),
  KEY `idx_agent_project` (`project_id`),
  CONSTRAINT `field_agents_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_agents`
--

LOCK TABLES `field_agents` WRITE;
/*!40000 ALTER TABLE `field_agents` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_agents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_definitions`
--

DROP TABLE IF EXISTS `field_definitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `field_definitions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `field_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label_ko` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `input_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `choice_type` enum('single','multi') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `choice_type_locked` tinyint(1) NOT NULL DEFAULT '0',
  `options_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `validation_regex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `placeholder` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `is_system` tinyint(1) NOT NULL DEFAULT '0',
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `field_key` (`field_key`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_definitions`
--

LOCK TABLES `field_definitions` WRITE;
/*!40000 ALTER TABLE `field_definitions` DISABLE KEYS */;
/*!40000 ALTER TABLE `field_definitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gift_redemptions`
--

DROP TABLE IF EXISTS `gift_redemptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gift_redemptions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `visitor_id` bigint NOT NULL,
  `merchant_id` bigint DEFAULT NULL,
  `redemption_type` enum('normal','grant') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` bigint NOT NULL,
  `eligible` tinyint(1) NOT NULL DEFAULT '0',
  `redeemed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  KEY `visitor_id` (`visitor_id`),
  KEY `idx_gr_merchant` (`merchant_id`),
  CONSTRAINT `fk_gr_merchant` FOREIGN KEY (`merchant_id`) REFERENCES `merchants` (`id`),
  CONSTRAINT `gift_redemptions_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  CONSTRAINT `gift_redemptions_ibfk_2` FOREIGN KEY (`visitor_id`) REFERENCES `visitors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gift_redemptions`
--

LOCK TABLES `gift_redemptions` WRITE;
/*!40000 ALTER TABLE `gift_redemptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `gift_redemptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gifts`
--

DROP TABLE IF EXISTS `gifts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gifts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `visitor_id` bigint NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` bigint NOT NULL,
  `threshold_pct` int NOT NULL DEFAULT '100',
  `status` enum('issued','used') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'issued',
  `qr_image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qr_view_pin_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qr_view_pin_set_at` datetime DEFAULT NULL,
  `issued_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `used_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_gift_token` (`token`),
  UNIQUE KEY `uq_gift_visitor_tier` (`project_id`,`visitor_id`,`threshold_pct`),
  KEY `visitor_id` (`visitor_id`),
  CONSTRAINT `gifts_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  CONSTRAINT `gifts_ibfk_2` FOREIGN KEY (`visitor_id`) REFERENCES `visitors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gifts`
--

LOCK TABLES `gifts` WRITE;
/*!40000 ALTER TABLE `gifts` DISABLE KEYS */;
/*!40000 ALTER TABLE `gifts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_email_verify_codes`
--

DROP TABLE IF EXISTS `host_email_verify_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `host_email_verify_codes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '0',
  `expires_at` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_hvc_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_email_verify_codes`
--

LOCK TABLES `host_email_verify_codes` WRITE;
/*!40000 ALTER TABLE `host_email_verify_codes` DISABLE KEYS */;
INSERT INTO `host_email_verify_codes` VALUES
(40,'kimch@monorama.kr','508909',1,'2026-07-02 14:00:23','2026-07-02 04:50:22');
/*!40000 ALTER TABLE `host_email_verify_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_project_pin_codes`
--

DROP TABLE IF EXISTS `host_project_pin_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `host_project_pin_codes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `host_id` bigint NOT NULL,
  `pin_code` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` datetime NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `host_id` (`host_id`),
  CONSTRAINT `host_project_pin_codes_ibfk_1` FOREIGN KEY (`host_id`) REFERENCES `hosts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_project_pin_codes`
--

LOCK TABLES `host_project_pin_codes` WRITE;
/*!40000 ALTER TABLE `host_project_pin_codes` DISABLE KEYS */;
INSERT INTO `host_project_pin_codes` VALUES
(21,4,'715454','2026-07-04 11:24:54',0,'2026-07-04 02:14:53');
/*!40000 ALTER TABLE `host_project_pin_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts`
--

DROP TABLE IF EXISTS `hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `hosts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `host_serial` varchar(13) COLLATE utf8mb4_unicode_ci NOT NULL,
  `host_name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `host_email` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `organization_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `biz_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `biz_cert_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `biz_cert_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_zip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','approved','cancelled','terminated','locked') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `status_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `project_pin_fail_count` int NOT NULL DEFAULT '0',
  `project_locked` tinyint(1) NOT NULL DEFAULT '0',
  `last_login_ip` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `last_logout_at` datetime DEFAULT NULL,
  `password_reset_required` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `host_email` (`host_email`),
  UNIQUE KEY `uq_host_serial` (`host_serial`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts`
--

LOCK TABLES `hosts` WRITE;
/*!40000 ALTER TABLE `hosts` DISABLE KEYS */;
INSERT INTO `hosts` VALUES
(4,'20260702_H001','56317D6315F0024C9142EC35490CAF28','B1F34F788D7F853B5BC48B25637B9DB0836036BB3CC6D1DF534BFD1FDFCD1311','574A9B3489B1C0FAB682C4301822FAA1','88940FDC6524AA2B7934C0019A187F79','(주)모노라마','2778600185','C:\\proj\\stamptour\\uploads\\biz-certs\\1782978064384_ë¯ëë¸ëê³_ëëì.jpg','ë¯ëë¸ëê³ ëëì.jpg','07807','서울 강서구 마곡중앙1로 10','B동 303호','$2b$12$qQMEtnWw/g1EuYVD/KTk7.Q3oELmDRf9Af4hFPECGh.O5Gakaolci','approved',NULL,0,0,'112.172.235.81','2026-07-21 14:49:07','2026-07-07 00:43:21',0,'2026-07-02 07:41:04','2026-07-21 14:49:07');
/*!40000 ALTER TABLE `hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_histories`
--

DROP TABLE IF EXISTS `login_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `login_histories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_type` enum('host','supervisor','merchant') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `login_ip` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `login_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `logout_at` datetime DEFAULT NULL,
  `session_id` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=409 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_histories`
--

LOCK TABLES `login_histories` WRITE;
/*!40000 ALTER TABLE `login_histories` DISABLE KEYS */;
INSERT INTO `login_histories` VALUES
(329,'supervisor','supervisor','112.221.246.133','2026-07-02 04:05:54','2026-07-02 04:10:11','i4k2e32LOQ1FmHN-HoAY33zBXJAjwW_y'),
(330,'supervisor','supervisor','112.221.246.133','2026-07-02 04:46:19','2026-07-02 05:03:34','Nl278ldUd07-iuIIse9Ui2eeojnqDkr-'),
(331,'supervisor','supervisor','112.221.246.133','2026-07-02 07:41:14','2026-07-02 07:45:52','EHQuSmNUKubgZeeuvBEWbNbZ9-PwfWkG'),
(332,'host','4','112.221.246.133','2026-07-02 07:41:53','2026-07-02 08:24:46','cAsW4pl-FJXrqMncbkezA2YP-3Ji-kWy'),
(333,'host','4','112.221.246.133','2026-07-02 08:25:02','2026-07-02 09:00:34','KtCoTGujUSuiz5J73C5zkl5GeVNZuv2Y'),
(334,'host','4','112.221.246.133','2026-07-02 09:02:18','2026-07-02 09:09:29','ToifoIGwr9cFd_FqqzVbape_-cyMz42s'),
(335,'host','4','112.221.246.133','2026-07-02 09:15:45','2026-07-02 09:34:49','95JGajU8bRJzBFuGJepJNwy76GbwtZ8V'),
(336,'host','4','112.221.246.133','2026-07-02 09:25:02','2026-07-02 10:14:50','H2bF1ZZu1BU_xV2gA3KWDI8VV7yqTvA3'),
(337,'host','4','112.172.235.81','2026-07-02 11:40:01','2026-07-02 12:24:11','_wnr-G1fdAMdISUMM0w17PhDm47acxzq'),
(338,'host','4','112.172.235.81','2026-07-02 12:00:43','2026-07-02 12:24:11','_wnr-G1fdAMdISUMM0w17PhDm47acxzq'),
(339,'host','4','112.172.235.81','2026-07-02 12:28:07',NULL,'24HnetxKKKdbthEGYqFQKwExbV-4GHiM'),
(340,'host','4','112.221.246.133','2026-07-03 00:01:03','2026-07-03 00:27:29','O0DScqo-Z8izXA04FVIvYBWf3eJnujpP'),
(341,'supervisor','supervisor','112.221.246.133','2026-07-03 00:01:37','2026-07-03 00:27:29','O0DScqo-Z8izXA04FVIvYBWf3eJnujpP'),
(342,'merchant','3','112.221.246.133','2026-07-03 00:05:01','2026-07-03 00:32:32','W3iR10tx7T54MeuJG8z-NSATuUvwY_rN'),
(343,'host','4','112.221.246.133','2026-07-03 00:34:27','2026-07-03 01:16:53','v3Oq-wy4o9WFY1PWhCF746B-uTr2mDRl'),
(344,'supervisor','supervisor','112.221.246.133','2026-07-03 01:22:29','2026-07-03 01:39:14','mAaNB_2hlopWawoq1tNQDKnUxUgDfmTm'),
(345,'host','4','112.221.246.133','2026-07-03 01:30:57','2026-07-03 01:39:14','mAaNB_2hlopWawoq1tNQDKnUxUgDfmTm'),
(346,'supervisor','supervisor','112.221.246.133','2026-07-03 01:47:49','2026-07-03 02:25:04','eumTYEkQ2Vi2_FeDg-bUIg2R0W-fz756'),
(347,'host','4','112.221.246.133','2026-07-03 01:58:37','2026-07-03 02:25:04','eumTYEkQ2Vi2_FeDg-bUIg2R0W-fz756'),
(348,'supervisor','supervisor','112.172.235.81','2026-07-03 22:38:35','2026-07-03 22:51:23','_UVpskD4dMg5i8T83rO3GgBlnuH0580t'),
(349,'supervisor','supervisor','112.172.235.81','2026-07-03 22:51:42','2026-07-03 23:02:18','UVGBoznIZfbfKebkCQJoM6yvuxCHJhUJ'),
(350,'supervisor','supervisor','112.172.235.81','2026-07-03 23:24:33','2026-07-03 23:29:10','rzXEp3MsihZYV8KwKedBhKbSoK8j6T9B'),
(351,'supervisor','supervisor','112.172.235.81','2026-07-03 23:29:26','2026-07-04 00:36:29','InMfpJQjIXIr3Cu_mMrh_9lXpp8zgcho'),
(352,'host','4','112.172.235.81','2026-07-04 00:10:35','2026-07-04 00:37:23','R9ysuAVncKPwQNn83p8_Djjw5Z7RlKc4'),
(353,'supervisor','supervisor','112.172.235.81','2026-07-04 00:37:02','2026-07-04 00:51:35','P3XGmMSVG4wm2ehm3J8PiGHZdfGkkzyq'),
(354,'host','4','112.172.235.81','2026-07-04 00:42:44','2026-07-04 01:37:23','_cuhGpMCRcCPSjqD3YvNA6VZdcDyLwAb'),
(355,'host','4','112.172.235.81','2026-07-04 01:14:59','2026-07-04 01:40:43','rcDfCtaObX6rrnlIiAnU9mRkL2fp5M2_'),
(356,'host','4','112.172.235.81','2026-07-04 02:12:35','2026-07-04 03:22:23','sIBuR2Yw2-7O7sQl-AtYq37M3IFho75n'),
(357,'supervisor','supervisor','112.172.235.81','2026-07-04 02:35:38','2026-07-04 02:45:44','1eGY50DtAuRhbz4wk5M6AsdAjocbMxwF'),
(358,'host','4','112.172.235.81','2026-07-04 02:37:06','2026-07-04 03:17:23','N0YZsfIhO12Cq3vAwZBTCfGsZpeQnsoy'),
(359,'host','4','112.172.235.81','2026-07-04 03:34:14',NULL,'gTbuscc5tqGyOsC_GlcjvRt8NKl6T35w'),
(360,'host','4','112.172.235.81','2026-07-04 03:58:21','2026-07-04 04:24:15','4G-RiH8hGZK-cXjsgWWmOvZYQoMSesEP'),
(361,'host','4','112.172.235.81','2026-07-04 04:24:28','2026-07-04 05:47:18','FbuQbKuKks5rIKUkdW4jWcKWf2zzOd9G'),
(362,'supervisor','supervisor','112.172.235.81','2026-07-04 04:25:42','2026-07-04 04:35:48','Jp-wW0-5rfFLMIxwum6nzm5rkfIK6KfZ'),
(363,'host','4','112.172.235.81','2026-07-04 05:57:02','2026-07-04 05:57:23','R7Wcen03-35UPgcmC5Za4mrkqTX9aHQi'),
(364,'host','4','112.172.235.81','2026-07-04 05:57:34','2026-07-04 06:55:23','gQhwx1pmOEKb7Mq3XKdOGEqE6MqmAAEd'),
(365,'supervisor','supervisor','112.172.235.81','2026-07-04 06:20:47',NULL,'Bck7QBUdEXQ13ATmOQzdpG9jNhUaB1xK'),
(366,'supervisor','supervisor','112.172.235.81','2026-07-04 07:00:33','2026-07-04 07:10:38','4k47HTOvx7L8qC35jPZD0VPgJRa2NdAh'),
(367,'host','4','112.172.235.81','2026-07-04 07:15:28','2026-07-04 08:01:29','1LxSS9wqwOd-ZQyMU97ZSOQiMpWbrRAd'),
(368,'supervisor','supervisor','112.172.235.81','2026-07-04 07:33:19','2026-07-04 07:43:30','wiwqFjM_mOl_5T4kRPc8dBeOe7yFBN1g'),
(369,'supervisor','supervisor','112.172.235.81','2026-07-04 07:53:08','2026-07-04 08:20:50','Z9Fbo7VTiUFViaTAqHGelUhujO5xlq7W'),
(370,'host','4','112.172.235.81','2026-07-04 08:11:22','2026-07-04 08:29:43','TWWfwgMaf6oqIDsgauRmq-B32PmjK7S1'),
(371,'host','4','112.172.235.81','2026-07-04 08:29:50','2026-07-04 08:44:57','9Q77BLcWVG_MUwPhN3b2KPnKFEyLjaY1'),
(372,'host','4','112.172.235.81','2026-07-04 08:44:59','2026-07-04 09:10:19','HAVmyNuKRSyRXRxq093I3QTXjmDDl5s7'),
(373,'supervisor','supervisor','112.172.235.81','2026-07-04 08:50:17','2026-07-04 09:00:48','9tJIBeo3wi4FlosGO4Wt1_B8VtGdJoXu'),
(374,'host','4','112.172.235.81','2026-07-04 09:10:32',NULL,'aDmtvKg0EnahVbpn2fcD4RsDwCfP7TqV'),
(375,'host','4','112.172.235.81','2026-07-04 10:43:56','2026-07-04 11:53:22','Ung7Wqz2a1bvtPQ-Fa3c6NI9TBqlSw13'),
(376,'supervisor','supervisor','112.172.235.81','2026-07-04 11:20:52','2026-07-04 11:31:09','D5uBvopGoJjZP8GqRkPwA946FFUcO3V8'),
(377,'supervisor','supervisor','112.172.235.81','2026-07-04 11:43:07','2026-07-04 11:53:14','cFNYKqdicDtwVL-ScoexyzrvNdXiloTM'),
(378,'supervisor','supervisor','112.172.235.81','2026-07-04 12:00:33','2026-07-04 12:11:00','q-iLUr8aKm652Idv4sWM_fZR4GbuAExw'),
(379,'host','4','112.172.235.81','2026-07-04 12:03:34','2026-07-04 12:20:28','8ETM6RuQgWryez_bSeN5W55hBtQORil3'),
(380,'host','4','112.172.235.81','2026-07-04 12:20:30','2026-07-04 12:36:26','z8ClSqaFKS7wzasoF9vKD6lTBHTXMu_a'),
(381,'host','4','112.172.235.81','2026-07-04 12:41:29',NULL,'IZx2syxZ3pcG4ckf0L1TQ2ptPHeSX5iB'),
(382,'supervisor','supervisor','112.172.235.81','2026-07-04 13:09:22','2026-07-04 13:19:42','PvJ4Kalu1z40ts6aGz-wgSF_tGt-XDKC'),
(383,'supervisor','supervisor','112.172.235.81','2026-07-05 00:56:07','2026-07-05 01:22:54','Rb39yvCzvF8O69YorLXdCxvKRsO7wQY7'),
(384,'supervisor','supervisor','112.172.235.81','2026-07-05 01:23:48','2026-07-05 01:34:09','pQeI4LlepuadavasVzscRg8on_9q3hci'),
(385,'supervisor','supervisor','112.172.235.81','2026-07-05 01:41:04','2026-07-05 02:00:17','oqXo-Kn-xSq51_JE_DsHVP6uscRydc02'),
(386,'host','4','112.172.235.81','2026-07-05 03:37:37','2026-07-05 04:00:19','5LjW1DoYFU_skDFykCkAobHw13moHo2e'),
(387,'host','4','112.172.235.81','2026-07-05 04:15:54','2026-07-05 04:32:14','TU-IhlooXTl4ZTF79n3Ngz1b6QPTXlLg'),
(388,'supervisor','supervisor','112.172.235.81','2026-07-05 04:25:22','2026-07-05 04:55:07','Rq62bleei4hX2uL8gtXE9d1ZPjT84Fwq'),
(389,'host','4','112.172.235.81','2026-07-05 04:36:07','2026-07-05 05:19:17','hwS3BDNgJ-6rLkp-xEvcz4N9ke8Zp5ts'),
(390,'host','4','112.221.246.133','2026-07-06 06:51:53',NULL,'cVKoolzGswdRoIYrk9xH0fdAhwrPvJNs'),
(391,'host','4','112.221.246.133','2026-07-06 06:51:56',NULL,'cVKoolzGswdRoIYrk9xH0fdAhwrPvJNs'),
(392,'host','4','112.221.246.133','2026-07-07 00:39:58','2026-07-07 00:43:21','BfWaMp1VJF_g8xxgUvNVwi7KOzHAhNZn'),
(393,'host','4','112.221.246.133','2026-07-07 02:39:39','2026-07-07 02:57:09','stfF_5m-3tzeBcrjQ30NCwdxmuXdr3n1'),
(394,'host','4','112.221.246.133','2026-07-07 02:44:57',NULL,'8-vFSsaGkL83eY6_IaELSDhuUC65E-6d'),
(395,'host','4','112.221.246.133','2026-07-07 05:24:12',NULL,'D-0SYLKzw3zHqL4REPBEiKRHaFH3QWty'),
(396,'host','4','112.172.235.81','2026-07-08 12:30:58',NULL,'6wf5j6ksg-bGGbP06ZDoj-lksNcGStRm'),
(397,'host','4','112.172.235.81','2026-07-11 07:46:21','2026-07-11 08:14:58','Tg2uu5smjUpG-X78qu6Pm27-3qVE7Jcv'),
(398,'host','4','112.172.235.81','2026-07-11 07:50:49','2026-07-11 08:38:58','tsNUaLNp32-4mBvf6dwe_ra0ousjb9_R'),
(399,'host','4','112.172.235.81','2026-07-11 11:30:59','2026-07-11 13:25:58','4R2JFJ6qLay7b4mULQSjKzRupt4eOMx-'),
(400,'host','4','112.172.235.81','2026-07-12 01:00:08',NULL,'xL2QGUggFZRH7CQd0OOuFBnXwBU7_LRv'),
(401,'supervisor','supervisor','112.221.246.133','2026-07-15 06:21:29','2026-07-15 06:25:19','FtciqUj5ikBkOEeRqA646yFf0UbN-ucb'),
(402,'supervisor','supervisor','112.221.246.133','2026-07-15 06:27:21','2026-07-15 06:27:50','UPhLZkywED7IqNAP2gSFGamipeuD8Z9b'),
(403,'supervisor','supervisor','112.221.246.133','2026-07-15 06:38:10',NULL,'pnXwuWI0CUxg__jeGBl6ViiMLQDNFXpE'),
(404,'supervisor','supervisor','112.221.246.133','2026-07-15 07:16:25',NULL,'N2NU3euQRk4kBBKf6c_H1zalu1QfjZms'),
(405,'supervisor','supervisor','112.221.246.133','2026-07-15 07:16:38',NULL,'w20lUx-ijR572H0NIHipFmN9o-V7LS9b'),
(406,'supervisor','supervisor','112.172.235.81','2026-07-15 09:19:22',NULL,'XYX8imD0XuEh4Z6J8Yy-mgnGtMgTTiah'),
(407,'supervisor','supervisor','112.172.235.81','2026-07-15 09:23:07',NULL,'AOsmMOnTwiEIt6-5A-thzJnZbYImELi1'),
(408,'host','4','112.172.235.81','2026-07-21 14:49:07',NULL,'EEVTj4jgxVxvf5GXI8u4knsXgKEYLguw');
/*!40000 ALTER TABLE `login_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merchant_email_verify_codes`
--

DROP TABLE IF EXISTS `merchant_email_verify_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchant_email_verify_codes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '0',
  `expires_at` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_mvc_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchant_email_verify_codes`
--

LOCK TABLES `merchant_email_verify_codes` WRITE;
/*!40000 ALTER TABLE `merchant_email_verify_codes` DISABLE KEYS */;
INSERT INTO `merchant_email_verify_codes` VALUES
(3,'nitsuser@naver.com','316102',1,'2026-07-03 09:06:11','2026-07-02 23:56:11');
/*!40000 ALTER TABLE `merchant_email_verify_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merchants`
--

DROP TABLE IF EXISTS `merchants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `merchants` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_serial` varchar(13) COLLATE utf8mb4_unicode_ci NOT NULL,
  `merchant_name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_phone` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_mobile` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `biz_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `biz_cert_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `biz_cert_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_account` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_copy_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_copy_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profile_image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profile_image_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_zip` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_lat` decimal(12,8) DEFAULT NULL,
  `google_lng` decimal(12,8) DEFAULT NULL,
  `password_hash` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','approved','cancelled','terminated','locked') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `status_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `system_approved_at` datetime DEFAULT NULL,
  `roampay_status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `roampay_approved_at` datetime DEFAULT NULL,
  `roampay_status_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `roampay_request_status` enum('none','approval_requested','request_received','request_unavailable') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `roampay_requested_at` datetime DEFAULT NULL,
  `roampay_request_attempts` int NOT NULL DEFAULT '0',
  `roampay_response_status_code` int DEFAULT NULL,
  `roampay_response_body` longtext COLLATE utf8mb4_unicode_ci,
  `roampay_response_at` datetime DEFAULT NULL,
  `last_login_ip` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `last_logout_at` datetime DEFAULT NULL,
  `password_reset_required` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_merchant_email` (`email`),
  UNIQUE KEY `uq_merchant_serial` (`merchant_serial`),
  KEY `idx_merchants_roampay_status` (`roampay_status`),
  KEY `idx_merchants_roampay_request_status` (`roampay_request_status`)
) ENGINE=InnoDB AUTO_INCREMENT=1008 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchants`
--

LOCK TABLES `merchants` WRITE;
/*!40000 ALTER TABLE `merchants` DISABLE KEYS */;
INSERT INTO `merchants` VALUES
(3,'20260703_0001','0C835D0DC23677688B784F18031AF68A','B4D29A7B08103ACFB46CE570E592704F','66D5D1E19B85AFCF64302CFEF0F987EE','66DE38183F3C9D34672B17E229AC9DC2','1823112833','C:\\proj\\stamptour\\uploads\\merchant-docs\\1783036749801_20223594_ì_ë¬¸ì°êµ¬ì¬ìì_ì£¼ìíì¬_ëª¨ë¸ë¼ë§.pdf','20223594 ì ë¬¸ì°êµ¬ì¬ìì_ì£¼ìíì¬ ëª¨ë¸ë¼ë§.pdf','29158691F936BDB37B18B5D514EEBBF4A576C47512991C621FC8A36EE886FF6E','우리은행','020','6B28F65EF0016384330F382D42AC59E0','C:\\proj\\stamptour\\uploads\\merchant-docs\\1783036751420_ìì£¼ìì¥ë°°_ìë§ì¶ì´_e_ì¤í¬ì¸_ëí.jpg','ìì£¼ìì¥ë°°_ìë§ì¶ì´_e_ì¤í¬ì¸ ëí.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'$2b$12$Az.9Gj5QFguDpAZbWgJzieKRhUPLm2F.Yg0EP09cC1.p49G6SZ6aO','approved',NULL,'2026-07-03 01:51:50','pending',NULL,NULL,'none',NULL,0,NULL,NULL,NULL,'112.221.246.133','2026-07-03 00:05:01',NULL,0,'2026-07-02 23:59:11','2026-07-03 01:52:10'),
(1001,'20260704TH001','C3437DC161870E236F1E8DEE088043282118B9A4EBBD694971FD8C217F3BBA39','E264B229F337774BF86DEFFA315F79BE',NULL,'4645436891B315FE647C60F72DB293B8','1-2345-67890-12-3',NULL,NULL,'4D7CBF8C7F875B3BCF472A14BFDFB23B9FF3BFE0244B577412466DEA21B43EC0',NULL,NULL,NULL,NULL,NULL,'uploads\\merchant-profiles\\bangkok-sky-bistro-400.png','bangkok-sky-bistro-400.png',NULL,NULL,NULL,13.73671700,100.56105000,'$2b$12$zx1epXgV/rnw177C0fmW2udkxiJvR4HGIs5QYPFW9VlzUs04uUF9G','approved',NULL,'2026-07-04 10:55:17','approved','2026-07-04 10:55:17',NULL,'none',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,'2026-07-04 10:55:17','2026-07-05 05:18:14'),
(1002,'20260704TH002','C68438710545448CF32679BF17960300699BCE77D59EC48A2CD08E42101E2057','F4BF573FED99A649C37DB488A8BF25D5',NULL,'DA9BF6A4CF42724BE9438E4C353A17D2','1-2345-67890-12-4',NULL,NULL,'145C10D93E8C28883251B1CFEED605259FF3BFE0244B577412466DEA21B43EC0',NULL,NULL,NULL,NULL,NULL,'uploads\\merchant-profiles\\chao-phraya-cafe-400.png','chao-phraya-cafe-400.png',NULL,NULL,NULL,13.73057800,100.54176600,'$2b$12$KXKC/73aB/weSiYIqW1IKutd8mcrXXEUyjE4s0g0IZMKhZZwxZM4C','approved',NULL,'2026-07-04 10:55:17','approved','2026-07-04 10:55:17',NULL,'none',NULL,0,NULL,NULL,NULL,NULL,NULL,'2026-07-04 12:07:17',0,'2026-07-04 10:55:17','2026-07-05 05:18:14'),
(1003,'20260704TH003','E2A244D9791751D8E4C2786D750E8F8E634CBC817E5465CF7EBDD2CA2CBE0C73','90805385B1A125CD0ED03C71C49A9ECB',NULL,'D6295ED90D4514EF555C4C99A4B93A8F','1-2345-67890-12-5',NULL,NULL,'C9939A6E1A76E999950B6B0CC90B9F999FF3BFE0244B577412466DEA21B43EC0',NULL,NULL,NULL,NULL,NULL,'uploads\\merchant-profiles\\siam-artisan-market-400.png','siam-artisan-market-400.png',NULL,NULL,NULL,13.74611100,100.53472200,'$2b$12$SQmasZawUGwdq7iJUa7P7uNo0jLEX/oALUBVvE1zNIQATKITGtHHa','approved',NULL,'2026-07-04 11:55:43','approved','2026-07-04 11:55:43',NULL,'none',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,'2026-07-04 11:55:43','2026-07-05 05:18:14'),
(1004,'20260704TH004','46E6B7C3216F489C3997F6C9E892F2D9C4AFB1B83D613F92241A0489AC122037','A4A38ED2FF044CCF1EBB7FA4EC8C4B53',NULL,'5F44A093E1C51B62D2AE86378C8E1192','1-2345-67890-12-6',NULL,NULL,'202629C7D8900F27C9154525A86634CD9FF3BFE0244B577412466DEA21B43EC0',NULL,NULL,NULL,NULL,NULL,'uploads\\merchant-profiles\\pattaya-beach-grill-400.png','pattaya-beach-grill-400.png',NULL,NULL,NULL,12.92760800,100.87577800,'$2b$12$uQD7rpRnabYvjewWe13vqeJ0hfMEq4n.X4Ug6GkW4BPXvlDYI2C8u','approved',NULL,'2026-07-04 11:55:43','approved','2026-07-04 11:55:43',NULL,'none',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,'2026-07-04 11:55:43','2026-07-05 05:18:14'),
(1005,'20260704TH005','4BE20E9AD84CF34A5F0F3940F6456F76E991E622842EBADC12481676D7118180','F1405C5974FF7ECD3D48D68E9D9ABC7A',NULL,'28F22857F13764D1F49D18F36DB49553','1-2345-67890-12-7',NULL,NULL,'CC03ADC326A981FD49C4C257D3A894739FF3BFE0244B577412466DEA21B43EC0',NULL,NULL,NULL,NULL,NULL,'uploads\\merchant-profiles\\jomtien-tour-shop-400.png','jomtien-tour-shop-400.png',NULL,NULL,NULL,12.89184500,100.87516700,'$2b$12$dEjR1XDzGzoOjmbVhqOnHeb5W0sYpewLxNsVIS59mh/l1YHGuJjWS','approved',NULL,'2026-07-04 11:55:43','approved','2026-07-04 11:55:43',NULL,'none',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,'2026-07-04 11:55:43','2026-07-05 05:18:14'),
(1006,'20260704TH006','6790FD04575160F159D26DA2BE1B7531C916925C87B0596289462A816D3B2407','C40E3BA3D82B7C8F917DB3C725D7FA6A',NULL,'17388A4D19139771606D6C0B14D46334','1-2345-67890-12-8',NULL,NULL,'D5A48FDA7306B565F451CA044A5C37A39FF3BFE0244B577412466DEA21B43EC0',NULL,NULL,NULL,NULL,NULL,'uploads\\merchant-profiles\\pattaya-wellness-spa-400.png','pattaya-wellness-spa-400.png',NULL,NULL,NULL,12.93407100,100.88926700,'$2b$12$jqFU1baI7IXELuAD8nN1M.Sxz3TI2pTPgF578TIQfcHmDLompUo8S','approved',NULL,'2026-07-04 11:55:43','approved','2026-07-04 11:55:43',NULL,'none',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,'2026-07-04 11:55:43','2026-07-05 05:18:14'),
(1007,'20260705_0001','B9EBC6339BD5925C555049B934F5C0EE2CC68486332E5CA3A3FA2309ECC032A7','0B85FD2CA1552FD3D0CB3A4123ECD769','0C079BFDACC2F77721127F5C58C0566A','29C6B64B054E3D400726BFABB61DA536','8248607251','C:\\proj\\stamptour\\uploads\\merchant-docs\\1783036749801_20223594_ì_ë¬¸ì°êµ¬ì¬ìì_ì£¼ìíì¬_ëª¨ë¸ë¼ë§.pdf','dummy_biz_cert.pdf','12FC6992B4671E8D1F11AF6C2D30D85E4DD8DE4A040EC07DC05EEE9159E04CAB','신한은행','088','59EF3FADA65728FCBE8170205983154D','C:\\proj\\stamptour\\uploads\\merchant-docs\\1783036751420_ìì£¼ìì¥ë°°_ìë§ì¶ì´_e_ì¤í¬ì¸_ëí.jpg','dummy_bank_copy.jpg','C:\\proj\\stamptour\\uploads\\merchant-profiles\\boat-party-merchant-400.png','boat-party-merchant-400.png','07335','서울 영등포구 여의동로 330','선착장 2층',13.72049200,100.51370700,'$2b$12$SPmrejHmNNZRUPR8WPjoL.k5xnldnejvcu8pyL/5Trpret2Nvwfl6','pending',NULL,NULL,'pending',NULL,NULL,'none',NULL,0,NULL,NULL,NULL,NULL,NULL,'2026-07-07 00:43:50',0,'2026-07-05 00:50:58','2026-07-07 00:43:50');
/*!40000 ALTER TABLE `merchants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partner_accounts`
--

DROP TABLE IF EXISTS `partner_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `partner_accounts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partner_accounts`
--

LOCK TABLES `partner_accounts` WRITE;
/*!40000 ALTER TABLE `partner_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `partner_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_applications`
--

DROP TABLE IF EXISTS `project_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_applications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `status` enum('pending','approved','rejected') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `support_type` enum('reservation','entry','tour','quiz','survey_reward') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'tour',
  `support_types` json DEFAULT NULL COMMENT '吏?썝 ?좏삎 諛곗뿴: ["quest","reservation","entry"]',
  `decided_at` datetime DEFAULT NULL,
  `decided_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `applied_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_proj_merch_type` (`project_id`,`merchant_id`,`support_type`),
  KEY `idx_project` (`project_id`),
  KEY `idx_merchant` (`merchant_id`),
  CONSTRAINT `project_applications_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_applications_ibfk_2` FOREIGN KEY (`merchant_id`) REFERENCES `merchants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_applications`
--

LOCK TABLES `project_applications` WRITE;
/*!40000 ALTER TABLE `project_applications` DISABLE KEYS */;
INSERT INTO `project_applications` VALUES
(12,8,1001,'approved','tour',NULL,'2026-07-04 10:56:15',NULL,'2026-07-04 10:56:00','2026-07-04 10:55:17','2026-07-04 10:56:15'),
(13,8,1002,'approved','tour',NULL,'2026-07-04 10:56:56',NULL,'2026-07-04 10:56:01','2026-07-04 10:55:17','2026-07-04 10:56:56'),
(14,9,1001,'approved','tour',NULL,'2026-07-07 00:44:29','dummy merchant pre-approved','2026-07-07 00:44:29','2026-07-07 00:44:29','2026-07-07 00:44:29'),
(15,9,1002,'approved','tour',NULL,'2026-07-07 00:44:29','dummy merchant pre-approved','2026-07-07 00:44:29','2026-07-07 00:44:29','2026-07-07 00:44:29'),
(16,9,1003,'approved','tour',NULL,'2026-07-07 00:44:29','dummy merchant pre-approved','2026-07-07 00:44:29','2026-07-07 00:44:29','2026-07-07 00:44:29'),
(17,9,1004,'approved','tour',NULL,'2026-07-07 00:44:29','dummy merchant pre-approved','2026-07-07 00:44:29','2026-07-07 00:44:29','2026-07-07 00:44:29'),
(18,10,1002,'approved','tour',NULL,'2026-07-07 00:44:29','dummy merchant pre-approved','2026-07-07 00:44:29','2026-07-07 00:44:29','2026-07-07 00:44:29'),
(19,10,1003,'approved','tour',NULL,'2026-07-07 00:44:29','dummy merchant pre-approved','2026-07-07 00:44:29','2026-07-07 00:44:29','2026-07-07 00:44:29'),
(20,10,1004,'approved','tour',NULL,'2026-07-07 00:44:29','dummy merchant pre-approved','2026-07-07 00:44:29','2026-07-07 00:44:29','2026-07-07 00:44:29'),
(21,10,1005,'approved','tour',NULL,'2026-07-07 00:44:29','dummy merchant pre-approved','2026-07-07 00:44:29','2026-07-07 00:44:29','2026-07-07 00:44:29'),
(22,11,1001,'approved','tour',NULL,'2026-07-07 00:44:29','dummy merchant pre-approved','2026-07-07 00:44:29','2026-07-07 00:44:29','2026-07-07 00:44:29'),
(23,11,1003,'approved','tour',NULL,'2026-07-07 00:44:29','dummy merchant pre-approved','2026-07-07 00:44:29','2026-07-07 00:44:29','2026-07-07 00:44:29'),
(24,11,1004,'approved','tour',NULL,'2026-07-07 00:44:29','dummy merchant pre-approved','2026-07-07 00:44:29','2026-07-07 00:44:29','2026-07-07 00:44:29'),
(25,11,1005,'approved','tour',NULL,'2026-07-07 00:44:29','dummy merchant pre-approved','2026-07-07 00:44:29','2026-07-07 00:44:29','2026-07-07 00:44:29'),
(26,12,1001,'approved','tour',NULL,'2026-07-07 00:44:29','dummy merchant pre-approved','2026-07-07 00:44:29','2026-07-07 00:44:29','2026-07-07 00:44:29'),
(27,12,1002,'approved','tour',NULL,'2026-07-07 00:44:29','dummy merchant pre-approved','2026-07-07 00:44:29','2026-07-07 00:44:29','2026-07-07 00:44:29'),
(28,12,1004,'approved','tour',NULL,'2026-07-07 00:44:29','dummy merchant pre-approved','2026-07-07 00:44:29','2026-07-07 00:44:29','2026-07-07 00:44:29'),
(29,12,1005,'approved','tour',NULL,'2026-07-07 00:44:29','dummy merchant pre-approved','2026-07-07 00:44:29','2026-07-07 00:44:29','2026-07-07 00:44:29');
/*!40000 ALTER TABLE `project_applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_daily_sequences`
--

DROP TABLE IF EXISTS `project_daily_sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_daily_sequences` (
  `seq_date` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_no` int NOT NULL,
  PRIMARY KEY (`seq_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_daily_sequences`
--

LOCK TABLES `project_daily_sequences` WRITE;
/*!40000 ALTER TABLE `project_daily_sequences` DISABLE KEYS */;
INSERT INTO `project_daily_sequences` VALUES
('20260704',5);
/*!40000 ALTER TABLE `project_daily_sequences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_gift_tiers`
--

DROP TABLE IF EXISTS `project_gift_tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_gift_tiers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `threshold_pct` int NOT NULL,
  `amount` bigint NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_tier` (`project_id`,`threshold_pct`),
  KEY `idx_project` (`project_id`),
  CONSTRAINT `project_gift_tiers_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_gift_tiers`
--

LOCK TABLES `project_gift_tiers` WRITE;
/*!40000 ALTER TABLE `project_gift_tiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_gift_tiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_inquiries`
--

DROP TABLE IF EXISTS `project_inquiries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_inquiries` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `visitor_id` bigint DEFAULT NULL,
  `author_email` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `author_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_member` tinyint(1) NOT NULL DEFAULT '0',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  `edit_pin` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_reply` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `replied_at` datetime DEFAULT NULL,
  `status` enum('open','answered') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_inq_project` (`project_id`),
  KEY `idx_inq_email` (`author_email`),
  CONSTRAINT `fk_inq_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_inquiries`
--

LOCK TABLES `project_inquiries` WRITE;
/*!40000 ALTER TABLE `project_inquiries` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_inquiries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_location_qr`
--

DROP TABLE IF EXISTS `project_location_qr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_location_qr` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `location_id` bigint NOT NULL,
  `qr_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `qr_image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_location` (`location_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `project_location_qr_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  CONSTRAINT `project_location_qr_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `project_locations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_location_qr`
--

LOCK TABLES `project_location_qr` WRITE;
/*!40000 ALTER TABLE `project_location_qr` DISABLE KEYS */;
INSERT INTO `project_location_qr` VALUES
(34,8,16,'http://tour.roampay.kr/v/20260704_0001/01','C:\\proj\\stamptour\\uploads\\qr\\8\\qr_20260704_0001_01.png','2026-07-04 07:27:44'),
(35,8,17,'http://tour.roampay.kr/v/20260704_0001/02','C:\\proj\\stamptour\\uploads\\qr\\8\\qr_20260704_0001_02.png','2026-07-04 07:27:44'),
(36,8,18,'http://tour.roampay.kr/v/20260704_0001/03','C:\\proj\\stamptour\\uploads\\qr\\8\\qr_20260704_0001_03.png','2026-07-04 07:27:44'),
(37,8,19,'http://tour.roampay.kr/v/20260704_0001/04','C:\\proj\\stamptour\\uploads\\qr\\8\\qr_20260704_0001_04.png','2026-07-04 07:27:44'),
(38,8,35,'http://tour.roampay.kr/v/20260704_0001/05','C:\\proj\\stamptour\\uploads\\qr\\8\\qr_20260704_0001_05.png','2026-07-04 07:27:44'),
(44,8,36,'http://tour.roampay.kr/v/20260704_0001/06','C:\\proj\\stamptour\\uploads\\qr\\8\\qr_20260704_0001_06.png','2026-07-04 07:27:44'),
(45,9,20,'http://tour.roampay.kr/v/20260704_0002/01','C:\\proj\\stamptour\\uploads\\qr\\9\\qr_20260704_0002_01.png','2026-07-04 07:42:06'),
(46,9,21,'http://tour.roampay.kr/v/20260704_0002/02','C:\\proj\\stamptour\\uploads\\qr\\9\\qr_20260704_0002_02.png','2026-07-04 07:42:06'),
(47,9,22,'http://tour.roampay.kr/v/20260704_0002/03','C:\\proj\\stamptour\\uploads\\qr\\9\\qr_20260704_0002_03.png','2026-07-04 07:42:06'),
(48,9,37,'http://tour.roampay.kr/v/20260704_0002/04','C:\\proj\\stamptour\\uploads\\qr\\9\\qr_20260704_0002_04.png','2026-07-04 07:42:06'),
(53,9,38,'http://tour.roampay.kr/v/20260704_0002/05','C:\\proj\\stamptour\\uploads\\qr\\9\\qr_20260704_0002_05.png','2026-07-04 07:42:06'),
(58,8,39,'http://tour.roampay.kr/v/20260704_0001/07','C:\\proj\\stamptour\\uploads\\qr\\8\\qr_20260704_0001_07.png','2026-07-04 10:57:12'),
(64,8,40,'http://tour.roampay.kr/v/20260704_0001/08','C:\\proj\\stamptour\\uploads\\qr\\8\\qr_20260704_0001_08.png','2026-07-04 10:57:12');
/*!40000 ALTER TABLE `project_location_qr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_locations`
--

DROP TABLE IF EXISTS `project_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_locations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `location_seq` int NOT NULL,
  `display_seq` int NOT NULL,
  `dest_type` enum('location','exhibit','merchant') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'location',
  `location_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kakao_lat` decimal(12,8) DEFAULT NULL,
  `kakao_lng` decimal(12,8) DEFAULT NULL,
  `map_provider` enum('kakao','google') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location_desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quiz_required` tinyint(1) NOT NULL DEFAULT '0',
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_project_location_seq` (`project_id`,`location_seq`),
  UNIQUE KEY `uq_project_display_seq_active` (`project_id`,`display_seq`,`disabled`),
  CONSTRAINT `project_locations_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_locations`
--

LOCK TABLES `project_locations` WRITE;
/*!40000 ALTER TABLE `project_locations` DISABLE KEYS */;
INSERT INTO `project_locations` VALUES
(16,8,1,1,'location','Grand Palace',13.75000000,100.49130000,'google','방콕 왕실 문화의 중심지에서 여정을 시작합니다.',NULL,0,0,'2026-07-04 01:13:26','2026-07-04 01:13:26'),
(17,8,2,2,'location','Wat Pho',13.74650000,100.49300000,'google','와불상과 전통 마사지 문화로 유명한 사원입니다.',NULL,0,0,'2026-07-04 01:13:26','2026-07-04 01:13:26'),
(18,8,3,3,'location','Tha Tien Pier',13.74590000,100.48920000,'google','차오프라야 강을 건너는 올드타운의 주요 선착장입니다.',NULL,0,0,'2026-07-04 01:13:26','2026-07-04 01:13:26'),
(19,8,4,4,'location','Wat Arun',13.74370000,100.48890000,'google','새벽 사원 전망과 강변 사진 포인트를 확인합니다.',NULL,0,0,'2026-07-04 01:13:26','2026-07-04 01:13:26'),
(20,9,1,1,'location','Chatuchak Weekend Market',13.79990000,100.55050000,'google','로컬 쇼핑과 간식을 한 번에 즐기는 대형 시장입니다.',NULL,0,0,'2026-07-04 01:13:26','2026-07-04 01:13:26'),
(21,9,2,2,'location','Jodd Fairs Rama 9',13.75840000,100.56690000,'google','야시장 음식과 트렌디한 푸드 부스를 경험합니다.',NULL,0,0,'2026-07-04 01:13:26','2026-07-04 01:13:26'),
(22,9,3,3,'location','Yaowarat Road',13.74000000,100.50980000,'google','방콕 차이나타운의 대표 미식 거리입니다.',NULL,0,0,'2026-07-04 01:13:26','2026-07-04 01:13:26'),
(23,10,1,1,'location','Bangkok Art and Culture Centre',13.74670000,100.53000000,'google','전시와 디자인 숍을 둘러보는 도심 아트 스팟입니다.',NULL,0,0,'2026-07-04 01:13:26','2026-07-04 01:13:26'),
(24,10,2,2,'location','Siam Square',13.74470000,100.53310000,'google','카페, 패션, 스트리트 문화를 연결하는 중심지입니다.',NULL,0,0,'2026-07-04 01:13:26','2026-07-04 01:13:26'),
(25,10,3,3,'location','ICONSIAM',13.72660000,100.51000000,'google','리버사이드 쇼핑과 전망을 함께 즐깁니다.',NULL,0,0,'2026-07-04 01:13:26','2026-07-04 01:13:26'),
(26,10,4,4,'location','Warehouse 30',13.72990000,100.51440000,'google','갤러리와 카페가 모인 창의 공간입니다.',NULL,0,0,'2026-07-04 01:13:26','2026-07-04 01:13:26'),
(27,11,1,1,'location','Pattaya Beach',12.93570000,100.88590000,'google','파타야 대표 해변 산책로에서 시작합니다.',NULL,0,0,'2026-07-04 01:13:26','2026-07-04 01:13:26'),
(28,11,2,2,'location','Jomtien Beach',12.88410000,100.89060000,'google','조용한 해변 분위기와 카페를 즐깁니다.',NULL,0,0,'2026-07-04 01:13:26','2026-07-04 01:13:26'),
(29,11,3,3,'location','Khao Phra Tamnak Viewpoint',12.92000000,100.86550000,'google','파타야 해안선을 내려다보는 전망 포인트입니다.',NULL,0,0,'2026-07-04 01:13:26','2026-07-04 01:13:26'),
(30,11,4,4,'location','Bali Hai Pier',12.92660000,100.86700000,'google','선셋과 해양 투어 출발 분위기를 느낄 수 있습니다.',NULL,0,0,'2026-07-04 01:13:26','2026-07-04 01:13:26'),
(31,12,1,1,'location','Koh Larn Pier',12.92260000,100.78760000,'google','꼬란 섬으로 이동해 해양 액티비티를 시작합니다.',NULL,0,0,'2026-07-04 01:13:26','2026-07-04 01:13:26'),
(32,12,2,2,'location','Tien Beach',12.92310000,100.77610000,'google','가족 단위 방문객에게 적합한 맑은 해변입니다.',NULL,0,0,'2026-07-04 01:13:26','2026-07-04 01:13:26'),
(33,12,3,3,'location','Underwater World Pattaya',12.89990000,100.90220000,'google','실내 해양 생물 관람 포인트입니다.',NULL,0,0,'2026-07-04 01:13:26','2026-07-04 01:13:26'),
(34,12,4,4,'location','Pattaya Floating Market',12.86790000,100.90530000,'google','수상시장과 로컬 먹거리를 체험합니다.',NULL,0,0,'2026-07-04 01:13:26','2026-07-04 01:13:26'),
(35,8,5,5,'merchant','Bangkok Sky Bistro',NULL,NULL,NULL,NULL,NULL,0,1,'2026-07-04 07:27:44','2026-07-04 10:54:41'),
(36,8,6,6,'merchant','Chao Phraya Cafe',NULL,NULL,NULL,NULL,NULL,0,1,'2026-07-04 07:27:44','2026-07-04 10:54:41'),
(37,9,4,4,'merchant','Bangkok Sky Bistro',NULL,NULL,NULL,NULL,NULL,0,0,'2026-07-04 07:42:06','2026-07-04 07:42:06'),
(38,9,5,5,'merchant','Chao Phraya Cafe',NULL,NULL,NULL,NULL,NULL,0,0,'2026-07-04 07:42:06','2026-07-04 07:42:06'),
(39,8,7,5,'merchant','Chao Phraya Cafe',NULL,NULL,NULL,'coffee, tea','https://tour.roampay.kr/upload/resources/images/1783820779442_a496826728c92e79.png',0,0,'2026-07-04 10:57:12','2026-07-12 01:49:45'),
(40,8,8,6,'merchant','Bangkok Sky Bistro',NULL,NULL,NULL,NULL,NULL,0,0,'2026-07-04 10:57:12','2026-07-04 10:57:12');
/*!40000 ALTER TABLE `project_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_notices`
--

DROP TABLE IF EXISTS `project_notices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_notices` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `pinned` tinyint(1) NOT NULL DEFAULT '0',
  `show_as_popup` tinyint(1) NOT NULL DEFAULT '0',
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_notice_project` (`project_id`),
  CONSTRAINT `fk_notice_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_notices`
--

LOCK TABLES `project_notices` WRITE;
/*!40000 ALTER TABLE `project_notices` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_notices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_notifications`
--

DROP TABLE IF EXISTS `project_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_notifications` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `image_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_notif_project` (`project_id`),
  CONSTRAINT `fk_notif_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_notifications`
--

LOCK TABLES `project_notifications` WRITE;
/*!40000 ALTER TABLE `project_notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_partner_form_config`
--

DROP TABLE IF EXISTS `project_partner_form_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_partner_form_config` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `use_company_name_ko` tinyint(1) NOT NULL DEFAULT '1',
  `use_company_name_en` tinyint(1) NOT NULL DEFAULT '1',
  `use_ceo_name` tinyint(1) NOT NULL DEFAULT '1',
  `use_ceo_email` tinyint(1) NOT NULL DEFAULT '1',
  `use_ceo_mobile` tinyint(1) NOT NULL DEFAULT '1',
  `use_biz_cert_file` tinyint(1) NOT NULL DEFAULT '1',
  `use_company_phone` tinyint(1) NOT NULL DEFAULT '1',
  `use_company_fax` tinyint(1) NOT NULL DEFAULT '1',
  `use_company_address` tinyint(1) NOT NULL DEFAULT '1',
  `use_company_homepage` tinyint(1) NOT NULL DEFAULT '1',
  `use_company_logo` tinyint(1) NOT NULL DEFAULT '1',
  `use_company_fields` tinyint(1) NOT NULL DEFAULT '1',
  `use_contact_name` tinyint(1) NOT NULL DEFAULT '1',
  `use_contact_dept` tinyint(1) NOT NULL DEFAULT '1',
  `use_contact_position` tinyint(1) NOT NULL DEFAULT '1',
  `use_contact_phone` tinyint(1) NOT NULL DEFAULT '1',
  `use_contact_email` tinyint(1) NOT NULL DEFAULT '1',
  `use_booth_type` tinyint(1) NOT NULL DEFAULT '1',
  `use_booth_count` tinyint(1) NOT NULL DEFAULT '1',
  `use_facility` tinyint(1) NOT NULL DEFAULT '1',
  `use_extra_request` tinyint(1) NOT NULL DEFAULT '1',
  `field_options` text COMMENT 'JSON 배열: 참가분야 선택지',
  `booth_type_options` text COMMENT 'JSON 배열: 부스타입 선택지',
  `facility_options` text COMMENT 'JSON 배열: 부대시설 선택지',
  `work_hours_from` varchar(5) NOT NULL DEFAULT '10:00',
  `work_hours_to` varchar(5) NOT NULL DEFAULT '18:00',
  `show_work_hours` tinyint(1) NOT NULL DEFAULT '1',
  `terms_text` mediumtext COMMENT '약관 동의 본문',
  `privacy_text` mediumtext COMMENT '개인정보수집 동의 본문',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`),
  CONSTRAINT `fk_ppfc_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_partner_form_config`
--

LOCK TABLES `project_partner_form_config` WRITE;
/*!40000 ALTER TABLE `project_partner_form_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_partner_form_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_partners`
--

DROP TABLE IF EXISTS `project_partners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_partners` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `company_name_ko` varchar(255) DEFAULT NULL,
  `company_name_en` varchar(255) DEFAULT NULL,
  `ceo_name` varchar(100) DEFAULT NULL,
  `ceo_email` varchar(255) DEFAULT NULL,
  `ceo_mobile` varchar(30) DEFAULT NULL,
  `biz_cert_path` varchar(500) DEFAULT NULL,
  `company_phone` varchar(50) DEFAULT NULL,
  `company_fax` varchar(50) DEFAULT NULL,
  `company_address` varchar(500) DEFAULT NULL,
  `company_homepage` varchar(500) DEFAULT NULL,
  `company_logo_path` varchar(500) DEFAULT NULL,
  `company_fields` json DEFAULT NULL,
  `contact_name` varchar(100) DEFAULT NULL,
  `contact_dept` varchar(100) DEFAULT NULL,
  `contact_position` varchar(100) DEFAULT NULL,
  `contact_phone` varchar(50) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `booth_type` varchar(100) DEFAULT NULL,
  `booth_unit_cost` int DEFAULT NULL,
  `booth_count` int DEFAULT NULL,
  `facility_json` json DEFAULT NULL,
  `quote_total` int DEFAULT NULL,
  `quote_json` json DEFAULT NULL,
  `facility` text,
  `extra_request` text,
  `agreed_terms` tinyint(1) NOT NULL DEFAULT '0',
  `agreed_privacy` tinyint(1) NOT NULL DEFAULT '0',
  `rejected_reason` varchar(500) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `deposit_confirmed_at` datetime DEFAULT NULL,
  `rejected_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_partner_proj` (`project_id`,`status`),
  CONSTRAINT `fk_pp_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_partners`
--

LOCK TABLES `project_partners` WRITE;
/*!40000 ALTER TABLE `project_partners` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_partners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_quiz_choices`
--

DROP TABLE IF EXISTS `project_quiz_choices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_quiz_choices` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quiz_id` bigint NOT NULL,
  `choice_text` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `choice_image_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_correct` tinyint(1) NOT NULL DEFAULT '0',
  `display_seq` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_quiz` (`quiz_id`),
  CONSTRAINT `project_quiz_choices_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `project_quizzes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_quiz_choices`
--

LOCK TABLES `project_quiz_choices` WRITE;
/*!40000 ALTER TABLE `project_quiz_choices` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_quiz_choices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_quizzes`
--

DROP TABLE IF EXISTS `project_quizzes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_quizzes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `location_id` bigint DEFAULT NULL,
  `question` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `question_image_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `choice_type` enum('single','multi') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'single',
  `correct_image_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correct_sound_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wrong_image_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wrong_sound_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `display_seq` int NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_project` (`project_id`),
  KEY `idx_location` (`location_id`),
  CONSTRAINT `fk_quiz_location` FOREIGN KEY (`location_id`) REFERENCES `project_locations` (`id`),
  CONSTRAINT `project_quizzes_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_quizzes`
--

LOCK TABLES `project_quizzes` WRITE;
/*!40000 ALTER TABLE `project_quizzes` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_quizzes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_reservation_fields`
--

DROP TABLE IF EXISTS `project_reservation_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_reservation_fields` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `field_id` bigint NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT '0',
  `choice_type_override` enum('single','multi') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_proj_field` (`project_id`,`field_id`),
  KEY `field_id` (`field_id`),
  CONSTRAINT `project_reservation_fields_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_reservation_fields_ibfk_2` FOREIGN KEY (`field_id`) REFERENCES `field_definitions` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_reservation_fields`
--

LOCK TABLES `project_reservation_fields` WRITE;
/*!40000 ALTER TABLE `project_reservation_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_reservation_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_resources`
--

DROP TABLE IF EXISTS `project_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_resources` (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_id` int NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_size` int NOT NULL,
  `width` int DEFAULT NULL,
  `height` int DEFAULT NULL,
  `file_data` longblob,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_resources`
--

LOCK TABLES `project_resources` WRITE;
/*!40000 ALTER TABLE `project_resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_survey_questions`
--

DROP TABLE IF EXISTS `project_survey_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_survey_questions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `question_def_id` bigint DEFAULT NULL COMMENT '카탈로그 참조 시 사용, 커스텀이면 NULL',
  `custom_label` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_input_type` enum('text','textarea','choice','rating','yesno') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_choice_type` enum('single','multi') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_options_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_required` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_psq_project` (`project_id`),
  KEY `question_def_id` (`question_def_id`),
  CONSTRAINT `project_survey_questions_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_survey_questions_ibfk_2` FOREIGN KEY (`question_def_id`) REFERENCES `survey_question_definitions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_survey_questions`
--

LOCK TABLES `project_survey_questions` WRITE;
/*!40000 ALTER TABLE `project_survey_questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_survey_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_survey_respondent_fields`
--

DROP TABLE IF EXISTS `project_survey_respondent_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_survey_respondent_fields` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `field_id` bigint NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_psrf` (`project_id`,`field_id`),
  KEY `field_id` (`field_id`),
  CONSTRAINT `project_survey_respondent_fields_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `project_survey_respondent_fields_ibfk_2` FOREIGN KEY (`field_id`) REFERENCES `field_definitions` (`id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_survey_respondent_fields`
--

LOCK TABLES `project_survey_respondent_fields` WRITE;
/*!40000 ALTER TABLE `project_survey_respondent_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_survey_respondent_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_surveys`
--

DROP TABLE IF EXISTS `project_surveys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_surveys` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('draft','published','closed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `allow_anonymous` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1=등록자 외 직접 응답 허용',
  `require_pre_registration` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=사전·현장등록자만 응답 가능',
  `thank_you_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `reward_label` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '경품 설명',
  `reward_amount` bigint NOT NULL DEFAULT '0' COMMENT '경품 단가 금액',
  `reward_qty` int NOT NULL DEFAULT '0' COMMENT '경품 발급 수량 (0=무제한)',
  `reward_message` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '혜택 메시지 (QR 수령 안내)',
  `reward_image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '경품 이미지 경로',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`),
  CONSTRAINT `project_surveys_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_surveys`
--

LOCK TABLES `project_surveys` WRITE;
/*!40000 ALTER TABLE `project_surveys` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_surveys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_videos`
--

DROP TABLE IF EXISTS `project_videos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_videos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `video_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `youtube_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `author` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thumbnail_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `sort_order` int NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_video_project` (`project_id`),
  CONSTRAINT `fk_video_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_videos`
--

LOCK TABLES `project_videos` WRITE;
/*!40000 ALTER TABLE `project_videos` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_videos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_vote_ballots`
--

DROP TABLE IF EXISTS `project_vote_ballots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_vote_ballots` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `vote_id` bigint NOT NULL,
  `voter_email` varchar(255) NOT NULL,
  `partner_id` bigint NOT NULL,
  `voted_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_vote_voter_partner` (`vote_id`,`voter_email`,`partner_id`),
  KEY `idx_vote_partner` (`vote_id`,`partner_id`),
  KEY `fk_pvb_partner` (`partner_id`),
  CONSTRAINT `fk_pvb_partner` FOREIGN KEY (`partner_id`) REFERENCES `project_partners` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_pvb_vote` FOREIGN KEY (`vote_id`) REFERENCES `project_votes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_vote_ballots`
--

LOCK TABLES `project_vote_ballots` WRITE;
/*!40000 ALTER TABLE `project_vote_ballots` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_vote_ballots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_vote_tiers`
--

DROP TABLE IF EXISTS `project_vote_tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_vote_tiers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `vote_id` bigint NOT NULL,
  `tier_rank` int NOT NULL,
  `award_title` varchar(255) NOT NULL,
  `winner_count` int NOT NULL DEFAULT '1',
  `prize_title` varchar(255) DEFAULT NULL,
  `prize_desc` text,
  `prize_image_path` varchar(500) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_vote_rank` (`vote_id`,`tier_rank`),
  CONSTRAINT `fk_pvt_vote` FOREIGN KEY (`vote_id`) REFERENCES `project_votes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_vote_tiers`
--

LOCK TABLES `project_vote_tiers` WRITE;
/*!40000 ALTER TABLE `project_vote_tiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_vote_tiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_votes`
--

DROP TABLE IF EXISTS `project_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `project_votes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `target_type` varchar(20) NOT NULL DEFAULT 'partner',
  `votes_per_visitor` int NOT NULL DEFAULT '1',
  `tier_count` int NOT NULL DEFAULT '1',
  `vote_title` varchar(255) DEFAULT NULL,
  `description` text,
  `status` enum('draft','published','closed') NOT NULL DEFAULT 'draft',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`),
  CONSTRAINT `fk_pv_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_votes`
--

LOCK TABLES `project_votes` WRITE;
/*!40000 ALTER TABLE `project_votes` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_votes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `projects` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `host_id` bigint NOT NULL,
  `project_name` varchar(160) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_serial` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `gift_amount` bigint NOT NULL,
  `gift_qty` int NOT NULL DEFAULT '0',
  `prize_amount` bigint NOT NULL DEFAULT '0',
  `prize_qty` int NOT NULL DEFAULT '0',
  `quiz_bonus_per_correct` int NOT NULL DEFAULT '0',
  `stop_on_budget_exceed` tinyint(1) NOT NULL DEFAULT '0',
  `budget_amount` bigint NOT NULL,
  `pin_hash` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pin_enc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('draft','quoted','deposit_wait','deposit_confirmed','ready_to_start','started','completed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'quoted',
  `quote_days` int NOT NULL,
  `quote_amount` bigint NOT NULL,
  `quote_sent_at` datetime DEFAULT NULL,
  `quote_read_at` datetime DEFAULT NULL,
  `quote_read` tinyint(1) NOT NULL DEFAULT '0',
  `deposit_confirmed_at` datetime DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `started_at` datetime DEFAULT NULL,
  `supervisor_mobile_image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supervisor_favicon_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `locations_submitted` tinyint(1) NOT NULL DEFAULT '0',
  `locations_submitted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `reservation_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `reservation_use` tinyint(1) NOT NULL DEFAULT '0',
  `reservation_benefit_amount` bigint NOT NULL DEFAULT '0',
  `reservation_benefit_label` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reservation_benefit_message` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reservation_benefit_max_count` int NOT NULL DEFAULT '0',
  `reservation_stop_on_limit` tinyint(1) NOT NULL DEFAULT '0',
  `reservation_benefit_image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reservation_start_at` datetime DEFAULT NULL,
  `entry_benefit_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `entry_use` tinyint(1) NOT NULL DEFAULT '0',
  `entry_benefit_amount` bigint NOT NULL DEFAULT '0',
  `entry_benefit_label` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entry_benefit_message` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entry_benefit_max_count` int NOT NULL DEFAULT '0',
  `entry_stop_on_limit` tinyint(1) NOT NULL DEFAULT '0',
  `entry_benefit_image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_agent_use` tinyint(1) NOT NULL DEFAULT '0',
  `survey_use` tinyint(1) NOT NULL DEFAULT '0' COMMENT '?ㅻЦ議곗궗 湲곕뒫 ?ъ슜 (?꾨줈?앺듃???뺤븸)',
  `tour_use` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Tour(목적지/스탬프) 사용 여부',
  `quiz_use` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Quiz 사용 여부',
  `mobile_design_use` tinyint(1) NOT NULL DEFAULT '1' COMMENT '랜딩페이지 디자인 N안 사용 여부',
  `favicon_use` tinyint(1) NOT NULL DEFAULT '1' COMMENT '모바일앱 아이콘 사용 여부',
  `tour_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Tour 제목',
  `tour_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Tour 설명',
  `tour_image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Tour 대표 이미지',
  `survey_reward_use` tinyint(1) NOT NULL DEFAULT '0' COMMENT '설문 응답자 경품 지급 사용 (별도 비용 없음)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_serial` (`project_serial`),
  KEY `host_id` (`host_id`),
  CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`host_id`) REFERENCES `hosts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES
(8,4,'Bangkok Old City Heritage Walk','20260704_0001','왕궁, 왓 포, 왓 아룬, 차오프라야 강변을 따라 방콕의 역사와 사원 문화를 체험하는 도보 여행 경로입니다.','2026-07-10','2026-08-31',100,300,0,0,0,1,30000,'$2b$10$yFAJgljxDT50zcuBUauI1uEqRc6VkEtDsAFRc6L3b9tt6hSoRDItm',NULL,'started',53,0,'2026-07-04 10:11:07','2026-07-04 10:11:07',1,'2026-07-04 10:11:07','2026-07-04 10:11:07','2026-07-04 10:11:07',NULL,NULL,1,'2026-07-04 01:13:26','2026-07-04 10:11:07','2026-07-12 01:49:52',1,1,0,NULL,NULL,0,0,NULL,NULL,1,1,0,NULL,NULL,0,0,NULL,1,1,1,1,1,1,'왕궁과 사원으로 걷는 방콕 올드타운','왕궁, 왓 포, 왓 아룬, 차오프라야 강변을 따라 방콕의 역사와 사원 문화를 체험하는 도보 여행 경로입니다.','https://tour.roampay.kr/upload/resources/images/1783819483708_68325a546a19d330.png',1),
(9,4,'Bangkok Food & Night Market Route','20260704_0002','짜뚜짝, 조드페어, 차이나타운 야오와랏을 연결해 길거리 음식과 야간 시장을 즐기는 미식 중심 경로입니다.','2026-07-12','2026-09-15',80,400,0,0,0,1,32000,'$2b$10$yFAJgljxDT50zcuBUauI1uEqRc6VkEtDsAFRc6L3b9tt6hSoRDItm',NULL,'started',66,0,'2026-07-04 10:11:07','2026-07-04 10:11:07',1,'2026-07-04 10:11:07','2026-07-04 10:11:07','2026-07-04 10:11:07',NULL,NULL,1,'2026-07-04 01:13:26','2026-07-04 10:11:07','2026-07-04 06:14:37',1,1,0,NULL,NULL,0,0,NULL,NULL,1,1,0,NULL,NULL,0,0,NULL,1,1,1,1,1,1,'야시장과 로컬 푸드 방콕 미식 투어','짜뚜짝, 조드페어, 차이나타운 야오와랏을 연결해 길거리 음식과 야간 시장을 즐기는 미식 중심 경로입니다.','C:\\proj\\stamptour\\uploads\\tour-images\\1783145661878_ë°©ì½ììê³¼ì¼ìì¥.png',1),
(10,4,'Bangkok Art, Cafe & Riverside Tour','20260704_0003','방콕 예술문화센터, 시암, 아이콘시암, 강변 카페를 엮은 젊은 여행자 대상 감성 투어입니다.','2026-07-15','2026-09-30',120,250,0,0,0,1,30000,'$2b$10$yFAJgljxDT50zcuBUauI1uEqRc6VkEtDsAFRc6L3b9tt6hSoRDItm',NULL,'started',78,0,'2026-07-04 10:11:07','2026-07-04 10:11:07',1,'2026-07-04 10:11:07','2026-07-04 10:11:07','2026-07-04 10:11:07',NULL,NULL,1,'2026-07-04 01:13:26','2026-07-04 10:11:07','2026-07-04 06:15:00',1,1,0,NULL,NULL,0,0,NULL,NULL,1,1,0,NULL,NULL,0,0,NULL,1,1,1,1,1,1,'아트, 카페, 리버사이드 방콕 감성 루트','방콕 예술문화센터, 시암, 아이콘시암, 강변 카페를 엮은 젊은 여행자 대상 감성 투어입니다.','C:\\proj\\stamptour\\uploads\\tour-images\\1783145692641_ë°©ì½ìí¸ì¹´íê°ë³.png',1),
(11,4,'Pattaya Beach & Sunset Trail','20260704_0004','파타야 비치, 좀티엔, 프라탐낙 전망대, 선셋 포인트를 따라 바다와 노을을 즐기는 해변 경로입니다.','2026-07-18','2026-10-10',100,300,0,0,0,1,30000,'$2b$10$yFAJgljxDT50zcuBUauI1uEqRc6VkEtDsAFRc6L3b9tt6hSoRDItm',NULL,'started',85,0,'2026-07-04 10:11:07','2026-07-04 10:11:07',1,'2026-07-04 10:11:07','2026-07-04 10:11:07','2026-07-04 10:11:07',NULL,NULL,1,'2026-07-04 01:13:26','2026-07-04 10:11:07','2026-07-04 01:13:26',1,1,0,NULL,NULL,0,0,NULL,NULL,1,1,0,NULL,NULL,0,0,NULL,1,1,1,1,1,1,'파타야 해변과 선셋 포인트 투어','파타야 비치, 좀티엔, 프라탐낙 전망대, 선셋 포인트를 따라 바다와 노을을 즐기는 해변 경로입니다.',NULL,1),
(12,4,'Pattaya Family Marine Adventure','20260704_0005','꼬란, 언더워터월드, 워터파크, 해산물 식당을 연결한 가족형 해양 액티비티 여행 경로입니다.','2026-07-20','2026-10-31',150,200,0,0,0,1,30000,'$2b$10$yFAJgljxDT50zcuBUauI1uEqRc6VkEtDsAFRc6L3b9tt6hSoRDItm',NULL,'started',104,0,'2026-07-04 10:11:07','2026-07-04 10:11:07',1,'2026-07-04 10:11:07','2026-07-04 10:11:07','2026-07-04 10:11:07',NULL,NULL,1,'2026-07-04 01:13:26','2026-07-04 10:11:07','2026-07-04 01:13:26',1,1,0,NULL,NULL,0,0,NULL,NULL,1,1,0,NULL,NULL,0,0,NULL,1,1,1,1,1,1,'가족 여행자를 위한 파타야 해양 체험','꼬란, 언더워터월드, 워터파크, 해산물 식당을 연결한 가족형 해양 액티비티 여행 경로입니다.',NULL,1);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `mode` enum('reservation','entry') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'reservation',
  `email_lower` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pin_hash` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fields_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` bigint NOT NULL,
  `status` enum('pending','activated','used','cancelled','expired') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `qr_image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `activated_at` datetime DEFAULT NULL,
  `activated_by_host_id` bigint DEFAULT NULL,
  `used_at` datetime DEFAULT NULL,
  `used_by_merchant_id` bigint DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  UNIQUE KEY `uq_resv_project_email` (`project_id`,`email_lower`),
  KEY `idx_resv_project_status` (`project_id`,`status`),
  KEY `idx_resv_project_mode` (`project_id`,`mode`),
  CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resource_images`
--

DROP TABLE IF EXISTS `resource_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `resource_images` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `host_id` bigint NOT NULL,
  `original_name` varchar(255) NOT NULL,
  `stored_name` varchar(255) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `file_size` bigint NOT NULL,
  `width` int NOT NULL,
  `height` int NOT NULL,
  `description` text,
  `tags` varchar(1000) DEFAULT NULL,
  `file_path` varchar(500) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_resource_images_host_created` (`host_id`,`created_at`),
  KEY `idx_resource_images_host_name` (`host_id`,`original_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resource_images`
--

LOCK TABLES `resource_images` WRITE;
/*!40000 ALTER TABLE `resource_images` DISABLE KEYS */;
INSERT INTO `resource_images` VALUES
(1,4,'ìê¶ê³¼ì¬ìì¼ë¡ê±·ëë°©ì½ì¬ëíì´.png','1783819483708_68325a546a19d330.png','image/png',2596792,1681,936,'방콕 올드 시티 투어 대표 이미지','old,bangkok,temple','C:\\proj\\stamptour\\upload\\resources\\images\\1783819483708_68325a546a19d330.png','2026-07-12 01:24:43','2026-07-12 01:24:43'),
(2,4,'chao-phraya-cafe-400.png','1783820779442_a496826728c92e79.png','image/png',447053,400,400,'카오프라야 커피','coffee,ice,hot,fancy','C:\\proj\\stamptour\\upload\\resources\\images\\1783820779442_a496826728c92e79.png','2026-07-12 01:46:19','2026-07-12 01:46:19');
/*!40000 ALTER TABLE `resource_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int unsigned NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES
('EEVTj4jgxVxvf5GXI8u4knsXgKEYLguw',1784646498,'{\"cookie\":{\"originalMaxAge\":600000,\"expires\":\"2026-07-21T14:59:07.288Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"host\":{\"id\":4,\"host_serial\":\"20260702_H001\",\"name\":\"홍길동\",\"email\":\"kimch@monorama.kr\",\"organization_name\":\"(주)모노라마\"},\"lastActivity\":1784645347163}');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `survey_question_definitions`
--

DROP TABLE IF EXISTS `survey_question_definitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `survey_question_definitions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `question_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label_ko` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `input_type` enum('text','textarea','choice','rating','yesno') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `choice_type` enum('single','multi') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `options_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '["옵션1","옵션2",...]',
  `category` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '만족도/구성/홍보/재방문/개선',
  `sort_order` int NOT NULL DEFAULT '0',
  `is_system` tinyint(1) NOT NULL DEFAULT '1',
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `question_key` (`question_key`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `survey_question_definitions`
--

LOCK TABLES `survey_question_definitions` WRITE;
/*!40000 ALTER TABLE `survey_question_definitions` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey_question_definitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `survey_responses`
--

DROP TABLE IF EXISTS `survey_responses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `survey_responses` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `reservation_id` bigint DEFAULT NULL COMMENT 'visitor 사전·현장등록과 연결 (있을 때)',
  `respondent_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `respondent_fields_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '익명 응답 시 수집된 개인정보',
  `answers_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `submitted_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `qr_token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '응답 완료 후 발급되는 QR 토큰',
  `qr_image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '경품 수령 QR 이미지 파일 경로',
  `reward_used_at` datetime DEFAULT NULL COMMENT '경품 수령 완료 시각',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_sr_qr_token` (`qr_token`),
  KEY `idx_sr_project` (`project_id`,`submitted_at`),
  KEY `idx_sr_resv` (`reservation_id`),
  CONSTRAINT `survey_responses_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `survey_responses_ibfk_2` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `survey_responses`
--

LOCK TABLES `survey_responses` WRITE;
/*!40000 ALTER TABLE `survey_responses` DISABLE KEYS */;
/*!40000 ALTER TABLE `survey_responses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_grid_prefs`
--

DROP TABLE IF EXISTS `user_grid_prefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_grid_prefs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `grid_key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefs_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_user_grid` (`user_type`,`user_id`,`grid_key`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_grid_prefs`
--

LOCK TABLES `user_grid_prefs` WRITE;
/*!40000 ALTER TABLE `user_grid_prefs` DISABLE KEYS */;
INSERT INTO `user_grid_prefs` VALUES
(12,'host','4','proj-table_l4flah','{\"order\":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14],\"hidden\":[4,6,8],\"freeze\":null}','2026-07-04 01:17:30'),
(15,'host','4','tour-grid-wrap_12h43jq','{\"order\":[0,1,2,3,4,5],\"hidden\":[],\"freeze\":null,\"align\":{\"0\":\"left\",\"1\":\"center\"}}','2026-07-04 04:02:59'),
(21,'host','4','admin.apps.grid.v1','{\"order\":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],\"hidden\":[3,4,14],\"freeze\":1,\"align\":{\"0\":\"left\",\"1\":\"left\"}}','2026-07-04 11:12:57'),
(29,'host','4','tour-grid-wrap_1wmwhi6','{\"order\":[0,1,2,3,4,5,6],\"hidden\":[],\"freeze\":null,\"align\":{\"0\":\"center\",\"1\":\"left\"}}','2026-07-04 11:14:10');
/*!40000 ALTER TABLE `user_grid_prefs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitor_push_subscriptions`
--

DROP TABLE IF EXISTS `visitor_push_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `visitor_push_subscriptions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `visitor_id` bigint NOT NULL,
  `endpoint` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `endpoint_hash` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `p256dh` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `auth` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_endpoint_hash` (`endpoint_hash`),
  KEY `idx_visitor` (`visitor_id`),
  CONSTRAINT `visitor_push_subscriptions_ibfk_1` FOREIGN KEY (`visitor_id`) REFERENCES `visitors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitor_push_subscriptions`
--

LOCK TABLES `visitor_push_subscriptions` WRITE;
/*!40000 ALTER TABLE `visitor_push_subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `visitor_push_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitor_quiz_attempts`
--

DROP TABLE IF EXISTS `visitor_quiz_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `visitor_quiz_attempts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `visitor_id` bigint NOT NULL,
  `quiz_id` bigint NOT NULL,
  `is_correct` tinyint(1) NOT NULL DEFAULT '0',
  `selected_choice_ids` json DEFAULT NULL,
  `attempted_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_attempt` (`visitor_id`,`quiz_id`),
  KEY `idx_quiz` (`quiz_id`),
  CONSTRAINT `visitor_quiz_attempts_ibfk_1` FOREIGN KEY (`visitor_id`) REFERENCES `visitors` (`id`),
  CONSTRAINT `visitor_quiz_attempts_ibfk_2` FOREIGN KEY (`quiz_id`) REFERENCES `project_quizzes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitor_quiz_attempts`
--

LOCK TABLES `visitor_quiz_attempts` WRITE;
/*!40000 ALTER TABLE `visitor_quiz_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `visitor_quiz_attempts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitor_visits`
--

DROP TABLE IF EXISTS `visitor_visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `visitor_visits` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `visitor_id` bigint NOT NULL,
  `location_id` bigint NOT NULL,
  `visited_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_visit` (`visitor_id`,`location_id`),
  KEY `project_id` (`project_id`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `visitor_visits_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  CONSTRAINT `visitor_visits_ibfk_2` FOREIGN KEY (`visitor_id`) REFERENCES `visitors` (`id`),
  CONSTRAINT `visitor_visits_ibfk_3` FOREIGN KEY (`location_id`) REFERENCES `project_locations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitor_visits`
--

LOCK TABLES `visitor_visits` WRITE;
/*!40000 ALTER TABLE `visitor_visits` DISABLE KEYS */;
/*!40000 ALTER TABLE `visitor_visits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitors`
--

DROP TABLE IF EXISTS `visitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `visitors` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `project_id` bigint NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `consent_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_project_phone` (`project_id`,`phone`),
  CONSTRAINT `visitors_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitors`
--

LOCK TABLES `visitors` WRITE;
/*!40000 ALTER TABLE `visitors` DISABLE KEYS */;
/*!40000 ALTER TABLE `visitors` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-21 14:59:57
