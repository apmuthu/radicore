-- phpMyAdmin SQL Dump
-- version 3.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 03, 2012 at 04:48 PM
-- Server version: 5.5.28
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `audit`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_fld`
--

CREATE TABLE IF NOT EXISTS `audit_fld` (
  `session_id` bigint(20) unsigned NOT NULL,
  `tran_seq_no` smallint(6) unsigned NOT NULL,
  `table_seq_no` smallint(6) unsigned NOT NULL,
  `field_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `old_value` text COLLATE utf8_unicode_ci,
  `new_value` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`session_id`,`tran_seq_no`,`table_seq_no`,`field_id`),
  KEY `field_id` (`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Audit Trail Field data';

-- --------------------------------------------------------

--
-- Table structure for table `audit_logon_errors`
--

CREATE TABLE IF NOT EXISTS `audit_logon_errors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `err_timestamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ip_address` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.0.0.0',
  `user_id` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_password` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `email_addr` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audit_ssn`
--

CREATE TABLE IF NOT EXISTS `audit_ssn` (
  `session_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `ssn_date` date NOT NULL DEFAULT '2000-01-01',
  `ssn_time` time NOT NULL DEFAULT '00:00:00',
  PRIMARY KEY (`session_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Audit Trail Session data';

-- --------------------------------------------------------

--
-- Table structure for table `audit_tbl`
--

CREATE TABLE IF NOT EXISTS `audit_tbl` (
  `session_id` bigint(20) unsigned NOT NULL,
  `tran_seq_no` smallint(6) unsigned NOT NULL,
  `table_seq_no` smallint(6) unsigned NOT NULL,
  `base_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `pkey` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`session_id`,`tran_seq_no`,`table_seq_no`),
  KEY `pkey` (`pkey`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Audit Trail Table data';

-- --------------------------------------------------------

--
-- Table structure for table `audit_trn`
--

CREATE TABLE IF NOT EXISTS `audit_trn` (
  `session_id` bigint(20) unsigned NOT NULL,
  `tran_seq_no` smallint(6) unsigned NOT NULL,
  `trn_date` date NOT NULL DEFAULT '2000-01-01',
  `trn_time` time NOT NULL DEFAULT '00:00:00',
  `task_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`session_id`,`tran_seq_no`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Audit Trail Transaction data';

-- --------------------------------------------------------

--
-- Table structure for table `php_session`
--

CREATE TABLE IF NOT EXISTS `php_session` (
  `session_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `user_id` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `date_created` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `last_updated` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `session_data` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`session_id`),
  KEY `last_updated` (`last_updated`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
