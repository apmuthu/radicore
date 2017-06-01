-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.18-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.4.0.5169
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table demo_dict.dict_column
CREATE TABLE IF NOT EXISTS `dict_column` (
  `database_id` varchar(64) NOT NULL,
  `table_id` varchar(64) NOT NULL,
  `column_id` varchar(64) NOT NULL,
  `column_seq` smallint(6) unsigned NOT NULL,
  `column_name` varchar(80) NOT NULL,
  `column_desc` text,
  `col_type` varchar(20) DEFAULT NULL,
  `col_type_native` varchar(32) DEFAULT NULL,
  `col_array_type` varchar(20) DEFAULT NULL,
  `col_values` text,
  `user_size` bigint(20) unsigned DEFAULT NULL,
  `col_maxsize` bigint(20) unsigned DEFAULT NULL,
  `col_null` char(1) DEFAULT NULL,
  `is_required` char(1) DEFAULT NULL,
  `col_key` char(3) DEFAULT NULL,
  `col_default` varchar(255) DEFAULT NULL,
  `col_auto_increment` char(1) DEFAULT NULL,
  `col_unsigned` char(1) DEFAULT NULL,
  `col_zerofill_bwz` char(3) DEFAULT NULL,
  `col_precision` tinyint(3) unsigned DEFAULT NULL,
  `col_scale` tinyint(3) unsigned DEFAULT NULL,
  `col_minvalue` double DEFAULT NULL,
  `col_maxvalue` double DEFAULT NULL,
  `user_minvalue` double DEFAULT NULL,
  `user_maxvalue` double DEFAULT NULL,
  `noedit_nodisplay` char(3) DEFAULT NULL,
  `no_search` char(3) DEFAULT NULL,
  `no_audit` char(3) DEFAULT NULL,
  `upper_lowercase` varchar(5) DEFAULT NULL,
  `is_password` char(1) DEFAULT NULL,
  `auto_insert` char(1) DEFAULT NULL,
  `auto_update` char(1) DEFAULT NULL,
  `infinityisnull` char(1) DEFAULT NULL,
  `col_subtype` varchar(10) DEFAULT NULL,
  `image_width` smallint(6) unsigned DEFAULT NULL,
  `image_height` smallint(5) unsigned DEFAULT NULL,
  `is_boolean` char(1) DEFAULT NULL,
  `boolean_true` varchar(4) DEFAULT NULL,
  `boolean_false` varchar(4) DEFAULT NULL,
  `control` varchar(10) DEFAULT NULL,
  `optionlist` varchar(64) DEFAULT NULL,
  `checkbox_label` varchar(64) DEFAULT NULL,
  `task_id` varchar(80) DEFAULT NULL,
  `foreign_field` varchar(64) DEFAULT NULL,
  `align_hv` char(1) DEFAULT NULL,
  `align_lr` char(1) DEFAULT NULL,
  `multi_cols` tinyint(3) unsigned DEFAULT NULL,
  `multi_rows` tinyint(3) unsigned DEFAULT NULL,
  `custom_validation` varchar(255) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`database_id`,`table_id`,`column_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Database Column Names';

-- Data exporting was unselected.
-- Dumping structure for table demo_dict.dict_database
CREATE TABLE IF NOT EXISTS `dict_database` (
  `database_id` varchar(64) NOT NULL,
  `database_name` varchar(80) NOT NULL,
  `database_desc` text,
  `subsys_id` varchar(16) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`database_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Database Names';

-- Data exporting was unselected.
-- Dumping structure for table demo_dict.dict_related_column
CREATE TABLE IF NOT EXISTS `dict_related_column` (
  `database_id_snr` varchar(64) NOT NULL,
  `table_id_snr` varchar(64) NOT NULL,
  `column_id_snr` varchar(64) NOT NULL,
  `database_id_jnr` varchar(64) NOT NULL,
  `table_id_jnr` varchar(64) NOT NULL,
  `seq_no` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `column_id_jnr` varchar(64) DEFAULT NULL,
  `seq_in_index` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`database_id_snr`,`table_id_snr`,`column_id_snr`,`database_id_jnr`,`table_id_jnr`,`seq_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Columns used in relationship';

-- Data exporting was unselected.
-- Dumping structure for table demo_dict.dict_relationship
CREATE TABLE IF NOT EXISTS `dict_relationship` (
  `database_id_snr` varchar(64) NOT NULL,
  `table_id_snr` varchar(64) NOT NULL,
  `database_id_jnr` varchar(64) NOT NULL,
  `table_id_jnr` varchar(64) NOT NULL,
  `seq_no` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `table_alias_snr` varchar(64) DEFAULT NULL,
  `table_alias_jnr` varchar(64) DEFAULT NULL,
  `relation_name` varchar(80) NOT NULL,
  `relation_desc` text,
  `relation_type` char(3) NOT NULL DEFAULT 'RES',
  `orderby` varchar(64) DEFAULT NULL,
  `parent_field` varchar(64) DEFAULT NULL,
  `calc_field` varchar(255) DEFAULT NULL,
  `key_name` varchar(64) NOT NULL DEFAULT 'PRIMARY',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`database_id_snr`,`table_id_snr`,`database_id_jnr`,`table_id_jnr`,`seq_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Database Table Relationships';

-- Data exporting was unselected.
-- Dumping structure for table demo_dict.dict_table
CREATE TABLE IF NOT EXISTS `dict_table` (
  `database_id` varchar(64) NOT NULL,
  `table_id` varchar(64) NOT NULL,
  `table_name` varchar(80) NOT NULL,
  `table_desc` text,
  `audit_logging` char(1) DEFAULT NULL,
  `default_orderby` varchar(64) DEFAULT NULL,
  `alt_language_table` varchar(64) DEFAULT NULL,
  `alt_language_cols` text,
  `nameof_start_date` varchar(40) DEFAULT NULL,
  `nameof_end_date` varchar(40) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`database_id`,`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Database Table Names';

-- Data exporting was unselected.
-- Dumping structure for table demo_dict.dict_table_key
CREATE TABLE IF NOT EXISTS `dict_table_key` (
  `database_id` varchar(64) NOT NULL,
  `table_id` varchar(64) NOT NULL,
  `key_name` varchar(64) NOT NULL,
  `column_id` varchar(64) NOT NULL,
  `seq_in_index` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `is_unique` char(1) DEFAULT NULL,
  `column_seq` tinyint(3) unsigned DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`database_id`,`table_id`,`key_name`,`column_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Database Table Keys';

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
