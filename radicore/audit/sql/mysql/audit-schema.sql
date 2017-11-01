-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.19-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.4.0.5174
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table demo_audit.audit_fld
CREATE TABLE IF NOT EXISTS `audit_fld` (
  `session_id` bigint(20) unsigned NOT NULL,
  `tran_seq_no` smallint(6) unsigned NOT NULL,
  `table_seq_no` smallint(6) unsigned NOT NULL,
  `field_id` varchar(255) NOT NULL,
  `old_value` text,
  `new_value` text,
  PRIMARY KEY (`session_id`,`tran_seq_no`,`table_seq_no`,`field_id`),
  KEY `field_id` (`field_id`)
) COMMENT='Audit Trail Field data';

-- Data exporting was unselected.
-- Dumping structure for table demo_audit.audit_logon_errors
CREATE TABLE IF NOT EXISTS `audit_logon_errors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `err_timestamp` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `ip_address` varchar(40) DEFAULT NULL,
  `user_id` varchar(16) DEFAULT NULL,
  `user_password` varchar(16) DEFAULT NULL,
  `email_addr` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_audit.audit_ssn
CREATE TABLE IF NOT EXISTS `audit_ssn` (
  `session_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `ssn_datetime` datetime NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `ssn_datetime` (`ssn_datetime`)
) COMMENT='Audit Trail Session data';

-- Data exporting was unselected.
-- Dumping structure for table demo_audit.audit_tbl
CREATE TABLE IF NOT EXISTS `audit_tbl` (
  `session_id` bigint(20) unsigned NOT NULL,
  `tran_seq_no` smallint(6) unsigned NOT NULL,
  `table_seq_no` smallint(6) unsigned NOT NULL,
  `base_name` varchar(64) DEFAULT NULL,
  `table_name` varchar(64) DEFAULT NULL,
  `pkey` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`session_id`,`tran_seq_no`,`table_seq_no`),
  KEY `pkey` (`pkey`)
) COMMENT='Audit Trail Table data';

-- Data exporting was unselected.
-- Dumping structure for table demo_audit.audit_trn
CREATE TABLE IF NOT EXISTS `audit_trn` (
  `session_id` bigint(20) unsigned NOT NULL,
  `tran_seq_no` smallint(6) unsigned NOT NULL,
  `trn_datetime` datetime NOT NULL,
  `task_id` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`session_id`,`tran_seq_no`),
  KEY `trn_datetime` (`trn_datetime`)
) COMMENT='Audit Trail Transaction data';

-- Data exporting was unselected.
-- Dumping structure for table demo_audit.php_session
CREATE TABLE IF NOT EXISTS `php_session` (
  `session_id` varchar(256) NOT NULL,
  `user_id` varchar(16) DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `last_updated` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `session_data` longblob,
  PRIMARY KEY (`session_id`),
  KEY `last_updated` (`last_updated`)
);

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
