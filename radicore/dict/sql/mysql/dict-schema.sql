-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.19-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             8.3.0.4792
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table dict.dict_column
CREATE TABLE IF NOT EXISTS `dict_column` (
  `database_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `table_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `column_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `column_seq` smallint(6) unsigned NOT NULL,
  `column_desc` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `col_comment` text COLLATE utf8_unicode_ci,
  `col_type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `col_type_native` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `col_array_type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `col_values` text COLLATE utf8_unicode_ci,
  `user_size` bigint(20) unsigned DEFAULT NULL,
  `col_maxsize` bigint(20) unsigned DEFAULT NULL,
  `col_null` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_required` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `col_key` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `col_default` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `col_auto_increment` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `col_unsigned` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `col_zerofill_bwz` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `col_precision` tinyint(3) unsigned DEFAULT NULL,
  `col_scale` tinyint(3) unsigned DEFAULT NULL,
  `col_minvalue` double DEFAULT NULL,
  `col_maxvalue` double DEFAULT NULL,
  `user_minvalue` double DEFAULT NULL,
  `user_maxvalue` double DEFAULT NULL,
  `noedit_nodisplay` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `no_search` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `no_audit` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `upper_lowercase` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_password` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `auto_insert` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `auto_update` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `infinityisnull` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `col_subtype` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_width` smallint(6) unsigned DEFAULT NULL,
  `image_height` smallint(5) unsigned DEFAULT NULL,
  `is_boolean` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `boolean_true` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `boolean_false` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `control` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `optionlist` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `checkbox_label` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `task_id` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `foreign_field` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `align_hv` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `align_lr` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `multi_cols` tinyint(3) unsigned DEFAULT NULL,
  `multi_rows` tinyint(3) unsigned DEFAULT NULL,
  `custom_validation` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`database_id`,`table_id`,`column_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Database Column Names';

-- Data exporting was unselected.


-- Dumping structure for table dict.dict_database
CREATE TABLE IF NOT EXISTS `dict_database` (
  `database_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `database_desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `db_comment` text COLLATE utf8_unicode_ci,
  `subsys_id` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`database_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Database Names';

-- Data exporting was unselected.


-- Dumping structure for table dict.dict_related_column
CREATE TABLE IF NOT EXISTS `dict_related_column` (
  `database_id_snr` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `table_id_snr` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `column_id_snr` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `database_id_jnr` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `table_id_jnr` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `seq_no` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `column_id_jnr` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `seq_in_index` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`database_id_snr`,`table_id_snr`,`column_id_snr`,`database_id_jnr`,`table_id_jnr`,`seq_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Columns used in relationship';

-- Data exporting was unselected.


-- Dumping structure for table dict.dict_relationship
CREATE TABLE IF NOT EXISTS `dict_relationship` (
  `database_id_snr` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `table_id_snr` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `database_id_jnr` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `table_id_jnr` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `seq_no` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `table_alias_snr` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `table_alias_jnr` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `relation_desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rel_comment` text COLLATE utf8_unicode_ci,
  `rel_type` char(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'RES',
  `orderby` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_field` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `calc_field` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `key_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'PRIMARY',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`database_id_snr`,`table_id_snr`,`database_id_jnr`,`table_id_jnr`,`seq_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Database Table Relationships';

-- Data exporting was unselected.


-- Dumping structure for table dict.dict_table
CREATE TABLE IF NOT EXISTS `dict_table` (
  `database_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `table_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `table_desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tbl_comment` text COLLATE utf8_unicode_ci,
  `audit_logging` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `default_orderby` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `alt_language_table` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `alt_language_cols` text COLLATE utf8_unicode_ci,
  `nameof_start_date` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nameof_end_date` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`database_id`,`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Database Table Names';

-- Data exporting was unselected.


-- Dumping structure for table dict.dict_table_key
CREATE TABLE IF NOT EXISTS `dict_table_key` (
  `database_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `table_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `key_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `column_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `seq_in_index` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `is_unique` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `column_seq` tinyint(3) unsigned DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`database_id`,`table_id`,`key_name`,`column_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Database Table Keys';

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
