-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.15-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.3.0.5119
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table demo_workflow.wf_arc
CREATE TABLE IF NOT EXISTS `wf_arc` (
  `workflow_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `transition_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `place_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `direction` char(3) NOT NULL,
  `arc_type` varchar(10) DEFAULT NULL,
  `pre_condition` text,
  `condition_field` varchar(40) DEFAULT NULL,
  `condition_operator` varchar(4) DEFAULT NULL,
  `condition_value` varchar(40) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`workflow_id`,`transition_id`,`place_id`,`direction`),
  KEY `place_id` (`workflow_id`,`place_id`,`direction`),
  KEY `transition_id` (`workflow_id`,`transition_id`,`direction`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_workflow.wf_case
CREATE TABLE IF NOT EXISTS `wf_case` (
  `rdcaccount_id` int(11) unsigned NOT NULL DEFAULT '1',
  `case_id` int(10) unsigned NOT NULL DEFAULT '0',
  `workflow_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `context` varchar(255) DEFAULT NULL,
  `case_status` char(2) DEFAULT NULL,
  `start_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `end_date` datetime DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`case_id`),
  KEY `workflow_id` (`workflow_id`),
  KEY `rdcaccount_id` (`rdcaccount_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_workflow.wf_place
CREATE TABLE IF NOT EXISTS `wf_place` (
  `workflow_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `place_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `place_type` char(1) DEFAULT NULL,
  `place_name` varchar(80) DEFAULT NULL,
  `place_desc` text,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`workflow_id`,`place_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_workflow.wf_token
CREATE TABLE IF NOT EXISTS `wf_token` (
  `rdcaccount_id` int(11) unsigned NOT NULL DEFAULT '1',
  `case_id` int(10) unsigned NOT NULL DEFAULT '0',
  `token_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `workflow_id` smallint(6) unsigned NOT NULL DEFAULT '0',
  `place_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `context` varchar(255) DEFAULT NULL,
  `token_status` varchar(4) DEFAULT NULL,
  `enabled_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `cancelled_date` datetime DEFAULT NULL,
  `consumed_date` datetime DEFAULT NULL,
  PRIMARY KEY (`case_id`,`token_id`),
  KEY `place_id` (`workflow_id`,`place_id`),
  KEY `rdcaccount_id` (`rdcaccount_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_workflow.wf_transition
CREATE TABLE IF NOT EXISTS `wf_transition` (
  `workflow_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `transition_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `transition_name` varchar(80) DEFAULT NULL,
  `transition_desc` text,
  `transition_trigger` varchar(4) DEFAULT NULL,
  `time_limit` int(11) unsigned DEFAULT NULL,
  `task_id` varchar(80) DEFAULT NULL,
  `role_id` varchar(16) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`workflow_id`,`transition_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_workflow.wf_workflow
CREATE TABLE IF NOT EXISTS `wf_workflow` (
  `workflow_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `workflow_name` varchar(80) DEFAULT NULL,
  `workflow_desc` text,
  `start_task_id` varchar(80) DEFAULT NULL,
  `is_valid` char(1) DEFAULT NULL,
  `workflow_errors` text,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`workflow_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_workflow.wf_workitem
CREATE TABLE IF NOT EXISTS `wf_workitem` (
  `rdcaccount_id` int(11) unsigned NOT NULL DEFAULT '1',
  `case_id` int(10) unsigned NOT NULL,
  `workitem_id` smallint(5) unsigned NOT NULL,
  `workflow_id` smallint(6) unsigned NOT NULL,
  `transition_id` smallint(5) unsigned NOT NULL,
  `transition_trigger` varchar(4) NOT NULL DEFAULT 'USER',
  `task_id` varchar(80) NOT NULL,
  `context` varchar(255) NOT NULL,
  `workitem_status` char(2) NOT NULL DEFAULT 'EN',
  `enabled_date` datetime DEFAULT NULL,
  `cancelled_date` datetime DEFAULT NULL,
  `finished_date` datetime DEFAULT NULL,
  `deadline` datetime DEFAULT NULL,
  `role_id` varchar(16) DEFAULT NULL,
  `user_id` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`case_id`,`workitem_id`),
  KEY `transition_id` (`workflow_id`,`transition_id`),
  KEY `rdcaccount_id` (`rdcaccount_id`)
);

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
