-- phpMyAdmin SQL Dump
-- version 3.3.3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 16, 2010 at 05:34 PM
-- Server version: 5.1.46
-- PHP Version: 5.2.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `dict`
--

-- --------------------------------------------------------

--
-- Table structure for table `dict_column`
--

CREATE TABLE IF NOT EXISTS `dict_column` (
  `database_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `table_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `column_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `column_seq` smallint(6) unsigned NOT NULL DEFAULT '0',
  `column_desc` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `col_comment` text COLLATE utf8_unicode_ci,
  `col_type` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `col_type_native` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `col_array_type` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `col_values` text COLLATE utf8_unicode_ci,
  `user_size` bigint(20) unsigned DEFAULT NULL,
  `col_maxsize` bigint(20) unsigned DEFAULT NULL,
  `col_null` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
  `is_required` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `col_key` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `col_default` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `col_auto_increment` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `col_unsigned` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `col_zerofill_bwz` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `col_precision` tinyint(3) unsigned DEFAULT NULL,
  `col_scale` tinyint(3) unsigned DEFAULT NULL,
  `col_minvalue` double DEFAULT NULL,
  `col_maxvalue` double DEFAULT NULL,
  `user_minvalue` double DEFAULT NULL,
  `user_maxvalue` double DEFAULT NULL,
  `noedit_nodisplay` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `no_search` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `no_audit` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `upper_lowercase` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_password` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `auto_insert` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `auto_update` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `infinityisnull` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `col_subtype` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_width` smallint(6) unsigned DEFAULT NULL,
  `image_height` smallint(5) unsigned DEFAULT NULL,
  `is_boolean` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Database Column Names';

-- --------------------------------------------------------

--
-- Table structure for table `dict_database`
--

CREATE TABLE IF NOT EXISTS `dict_database` (
  `database_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `database_desc` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `db_comment` text COLLATE utf8_unicode_ci,
  `subsys_id` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`database_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Database Names';

-- --------------------------------------------------------

--
-- Table structure for table `dict_related_column`
--

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Columns used in relationship';

-- --------------------------------------------------------

--
-- Table structure for table `dict_relationship`
--

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
  `rel_type` varchar(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'IGN',
  `orderby` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_field` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `calc_field` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `key_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'PRIMARY',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`database_id_snr`,`table_id_snr`,`database_id_jnr`,`table_id_jnr`,`seq_no`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Database Table Relationships';

-- --------------------------------------------------------

--
-- Table structure for table `dict_table`
--

CREATE TABLE IF NOT EXISTS `dict_table` (
  `database_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `table_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `table_desc` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `tbl_comment` text COLLATE utf8_unicode_ci,
  `audit_logging` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Y',
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Database Table Names';

-- --------------------------------------------------------

--
-- Table structure for table `dict_table_key`
--

CREATE TABLE IF NOT EXISTS `dict_table_key` (
  `database_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `table_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `key_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `column_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `seq_in_index` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `is_unique` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `column_seq` tinyint(3) unsigned DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`database_id`,`table_id`,`key_name`,`column_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Database Table Keys';
