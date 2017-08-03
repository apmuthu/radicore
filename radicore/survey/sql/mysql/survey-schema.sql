-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.27-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.3.0.5019
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table demo_survey.answer_option
CREATE TABLE IF NOT EXISTS `answer_option` (
  `survey_id` smallint(5) unsigned NOT NULL,
  `section_id` smallint(5) unsigned NOT NULL,
  `question_id` smallint(5) unsigned NOT NULL,
  `answer_id` tinyint(3) unsigned NOT NULL,
  `answer_seq` smallint(5) unsigned NOT NULL,
  `answer_text` varchar(255) DEFAULT NULL,
  `jumpto_section_seq` smallint(5) unsigned DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`survey_id`,`section_id`,`question_id`,`answer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table demo_survey.asset_type
CREATE TABLE IF NOT EXISTS `asset_type` (
  `asset_type_id` tinyint(3) unsigned NOT NULL,
  `asset_type_desc` varchar(40) DEFAULT NULL,
  `image_fname` varchar(255) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`asset_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table demo_survey.default_prompt
CREATE TABLE IF NOT EXISTS `default_prompt` (
  `survey_id` smallint(5) unsigned NOT NULL,
  `prompt_id` tinyint(3) unsigned NOT NULL,
  `prompt_desc` varchar(30) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`survey_id`,`prompt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table demo_survey.location_address
CREATE TABLE IF NOT EXISTS `location_address` (
  `node_id` smallint(5) unsigned NOT NULL,
  `address_line1` varchar(80) DEFAULT NULL,
  `address_line2` varchar(80) DEFAULT NULL,
  `town` varchar(80) DEFAULT NULL,
  `county` varchar(80) DEFAULT NULL,
  `postcode` varchar(10) DEFAULT NULL,
  `country` varchar(80) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table demo_survey.location_type
CREATE TABLE IF NOT EXISTS `location_type` (
  `location_type_id` tinyint(3) unsigned NOT NULL,
  `location_type_desc` varchar(40) DEFAULT NULL,
  `image_fname` varchar(255) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`location_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table demo_survey.number_option
CREATE TABLE IF NOT EXISTS `number_option` (
  `survey_id` smallint(5) unsigned NOT NULL,
  `section_id` smallint(5) unsigned NOT NULL,
  `question_id` smallint(5) unsigned NOT NULL,
  `min_value` int(10) unsigned DEFAULT '0',
  `max_value` int(10) unsigned DEFAULT '0',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`survey_id`,`section_id`,`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table demo_survey.org_type
CREATE TABLE IF NOT EXISTS `org_type` (
  `org_type_id` tinyint(3) unsigned NOT NULL,
  `org_type_desc` varchar(40) DEFAULT NULL,
  `image_fname` varchar(255) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`org_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table demo_survey.question_prompt
CREATE TABLE IF NOT EXISTS `question_prompt` (
  `survey_id` smallint(5) unsigned NOT NULL,
  `section_id` smallint(5) unsigned NOT NULL,
  `question_id` smallint(5) unsigned NOT NULL,
  `prompt_id` tinyint(3) unsigned NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`survey_id`,`section_id`,`question_id`,`prompt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table demo_survey.risk_status
CREATE TABLE IF NOT EXISTS `risk_status` (
  `risk_status_id` tinyint(3) unsigned NOT NULL,
  `risk_status_desc` varchar(40) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`risk_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table demo_survey.risk_weighting
CREATE TABLE IF NOT EXISTS `risk_weighting` (
  `weighting_id` tinyint(3) unsigned NOT NULL,
  `weighting_desc` varchar(40) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`weighting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table demo_survey.survey_answer_dtl
CREATE TABLE IF NOT EXISTS `survey_answer_dtl` (
  `survey_answer_id` int(10) unsigned NOT NULL,
  `survey_id` smallint(5) unsigned NOT NULL,
  `section_id` smallint(5) unsigned NOT NULL,
  `question_id` smallint(5) unsigned NOT NULL,
  `answer_text` varchar(255) DEFAULT NULL,
  `weighting_id` tinyint(3) unsigned DEFAULT NULL,
  `measure_adequate` char(1) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`survey_answer_id`,`survey_id`,`section_id`,`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table demo_survey.survey_answer_hdr
CREATE TABLE IF NOT EXISTS `survey_answer_hdr` (
  `survey_answer_id` int(10) unsigned NOT NULL,
  `user_id` varchar(16) DEFAULT NULL,
  `answer_date` date NOT NULL DEFAULT '0000-00-00',
  `survey_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `node_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `is_complete` char(1) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`survey_answer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table demo_survey.survey_hdr
CREATE TABLE IF NOT EXISTS `survey_hdr` (
  `survey_id` smallint(5) unsigned NOT NULL,
  `survey_name` varchar(80) DEFAULT NULL,
  `survey_long_name` varchar(255) DEFAULT NULL,
  `survey_type_id` varchar(4) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`survey_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table demo_survey.survey_question
CREATE TABLE IF NOT EXISTS `survey_question` (
  `survey_id` smallint(5) unsigned NOT NULL,
  `section_id` smallint(5) unsigned NOT NULL,
  `question_id` smallint(5) unsigned NOT NULL,
  `question_seq` smallint(5) unsigned NOT NULL,
  `question_text` varchar(255) DEFAULT NULL,
  `answer_type` char(1) DEFAULT NULL,
  `advice_text` text,
  `risk_status_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`survey_id`,`section_id`,`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table demo_survey.survey_section
CREATE TABLE IF NOT EXISTS `survey_section` (
  `survey_id` smallint(5) unsigned NOT NULL,
  `section_id` smallint(5) unsigned NOT NULL,
  `section_seq` smallint(5) unsigned NOT NULL,
  `section_name` varchar(80) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`survey_id`,`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table demo_survey.survey_type
CREATE TABLE IF NOT EXISTS `survey_type` (
  `survey_type_id` varchar(4) NOT NULL,
  `survey_type_desc` varchar(40) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`survey_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.


-- Dumping structure for table demo_survey.tree_node
CREATE TABLE IF NOT EXISTS `tree_node` (
  `node_id` smallint(5) unsigned NOT NULL,
  `node_desc` varchar(40) NOT NULL,
  `node_type` char(1) NOT NULL,
  `node_depth` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `node_id_snr` smallint(5) unsigned DEFAULT NULL,
  `org_type_id` tinyint(3) unsigned DEFAULT NULL,
  `location_type_id` tinyint(3) unsigned DEFAULT NULL,
  `asset_type_id` tinyint(3) unsigned DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
