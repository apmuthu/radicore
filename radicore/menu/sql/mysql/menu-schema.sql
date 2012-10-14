-- phpMyAdmin SQL Dump
-- version 3.3.8
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 6, 2012 at 16:31 AM
-- Server version: 5.1.54
-- PHP Version: 5.2.16

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `menu`
--

-- --------------------------------------------------------

--
-- Table structure for table `help_text`
--

CREATE TABLE IF NOT EXISTS `help_text` (
  `task_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `help_text` text COLLATE utf8_unicode_ci,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`task_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mnu_account`
--

CREATE TABLE IF NOT EXISTS `mnu_account` (
  `rdcaccount_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `rdcversion` int(10) unsigned NOT NULL DEFAULT '1',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`rdcaccount_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mnu_control`
--

CREATE TABLE IF NOT EXISTS `mnu_control` (
  `record_id` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `field_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `field_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`record_id`,`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mnu_favourite`
--

CREATE TABLE IF NOT EXISTS `mnu_favourite` (
  `user_id` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `seq_no` smallint(5) unsigned NOT NULL DEFAULT '0',
  `task_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `task_desc` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sort_seq` smallint(5) unsigned NOT NULL DEFAULT '0',
  `breadcrumbs` varchar(4000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`,`seq_no`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mnu_initial_value_role`
--

CREATE TABLE IF NOT EXISTS `mnu_initial_value_role` (
  `role_id` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `task_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `field_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `initial_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_noedit` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`role_id`,`task_id`,`field_id`),
  KEY `task_id` (`task_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mnu_initial_value_user`
--

CREATE TABLE IF NOT EXISTS `mnu_initial_value_user` (
  `user_id` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `task_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `field_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `initial_value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_noedit` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`,`task_id`,`field_id`),
  KEY `task_id` (`task_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mnu_language`
--

CREATE TABLE IF NOT EXISTS `mnu_language` (
  `language_id` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'EN',
  `language_name` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'English',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mnu_menu`
--

CREATE TABLE IF NOT EXISTS `mnu_menu` (
  `menu_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `task_id_jnr` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sort_seq` tinyint(3) unsigned zerofill NOT NULL DEFAULT '000',
  `button_text` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`menu_id`,`task_id_jnr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mnu_motd`
--

CREATE TABLE IF NOT EXISTS `mnu_motd` (
  `motd_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `motd_subject` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `motd_message` text COLLATE utf8_unicode_ci NOT NULL,
  `start_date` date NOT NULL DEFAULT '2000-01-01',
  `end_date` date DEFAULT '9999-12-31',
  `role_id` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`motd_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mnu_nav_button`
--

CREATE TABLE IF NOT EXISTS `mnu_nav_button` (
  `task_id_snr` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `task_id_jnr` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sort_seq` tinyint(3) unsigned zerofill NOT NULL DEFAULT '000',
  `button_text` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `context_preselect` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`task_id_snr`,`task_id_jnr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mnu_pattern`
--

CREATE TABLE IF NOT EXISTS `mnu_pattern` (
  `pattern_id` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `pattern_desc` varchar(60) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `pattern_long_desc` text COLLATE utf8_unicode_ci,
  `visible_screen` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `context_preselect` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `keep_data` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`pattern_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mnu_role`
--

CREATE TABLE IF NOT EXISTS `mnu_role` (
  `role_id` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `role_desc` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `start_task_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `global_access` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `is_external_auth_off` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mnu_role_task`
--

CREATE TABLE IF NOT EXISTS `mnu_role_task` (
  `role_id` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `task_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`role_id`,`task_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mnu_role_taskfield`
--

CREATE TABLE IF NOT EXISTS `mnu_role_taskfield` (
  `role_id` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `task_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `field_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `access_type` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`role_id`,`task_id`,`field_id`),
  KEY `task_id` (`task_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mnu_subsystem`
--

CREATE TABLE IF NOT EXISTS `mnu_subsystem` (
  `subsys_id` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `subsys_desc` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `subsys_dir` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `task_prefix` varchar(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`subsys_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mnu_task`
--

CREATE TABLE IF NOT EXISTS `mnu_task` (
  `task_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `task_desc` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `button_text` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `task_type` varchar(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `script_id` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_disabled` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `pattern_id` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subsys_id` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `initial_passthru` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `selection_fixed` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `selection_temp` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `settings` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `order_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `keep_data` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `log_sql_query` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `screen_refresh` smallint(5) unsigned DEFAULT NULL,
  `use_https` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `max_execution_time` smallint(5) unsigned DEFAULT NULL,
  `task_id_run_at_end` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `task_id_run_at_cancel` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`task_id`),
  KEY `subsys_id` (`subsys_id`),
  KEY `pattern_id` (`pattern_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mnu_task_field`
--

CREATE TABLE IF NOT EXISTS `mnu_task_field` (
  `task_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `field_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `field_desc` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`task_id`,`field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mnu_task_ip_address`
--

CREATE TABLE IF NOT EXISTS `mnu_task_ip_address` (
  `task_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `ip_address` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`task_id`,`ip_address`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='List of valid IP addresses';

-- --------------------------------------------------------

--
-- Table structure for table `mnu_todo`
--

CREATE TABLE IF NOT EXISTS `mnu_todo` (
  `user_id` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `seq_no` smallint(5) unsigned NOT NULL DEFAULT '0',
  `item_desc` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `item_notes` text COLLATE utf8_unicode_ci,
  `due_date` date NOT NULL DEFAULT '0000-00-00',
  `visibility` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `is_complete` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `repeat_interval` decimal(3,0) unsigned DEFAULT NULL,
  `repeat_unit` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `task_id` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `task_context` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`,`seq_no`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='List of "To Do" items';

-- --------------------------------------------------------

--
-- Table structure for table `mnu_user`
--

CREATE TABLE IF NOT EXISTS `mnu_user` (
  `user_id` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `user_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `user_password` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `role_id` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `rdcaccount_id` int(10) unsigned DEFAULT NULL,
  `pswd_chg_date` date DEFAULT NULL,
  `pswd_chg_time` time DEFAULT NULL,
  `pswd_count` smallint(5) unsigned DEFAULT NULL,
  `in_use` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `is_disabled` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `logon_date` date DEFAULT NULL,
  `logon_time` time DEFAULT NULL,
  `language_code` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_date` date NOT NULL DEFAULT '2000-01-01',
  `end_date` date DEFAULT '9999-12-31',
  `ip_address` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_addr` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `external_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_external_auth_off` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `party_id` int(11) unsigned DEFAULT NULL,
  `user_timezone` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_addr` (`email_addr`),
  KEY `role_id` (`role_id`),
  KEY `rdcaccount_id` (`rdcaccount_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mnu_user_ip_address`
--

CREATE TABLE IF NOT EXISTS `mnu_user_ip_address` (
  `user_id` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `ip_address` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`,`ip_address`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='List of valid IP addresses';
