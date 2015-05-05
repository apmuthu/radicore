-- phpMyAdmin SQL Dump
-- version 3.3.3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 16, 2010 at 05:32 PM
-- Server version: 5.1.46
-- PHP Version: 5.2.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `workflow`
--

-- --------------------------------------------------------

--
-- Table structure for table `wf_arc`
--

CREATE TABLE IF NOT EXISTS `wf_arc` (
  `workflow_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `transition_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `place_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `direction` varchar(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'IN',
  `arc_type` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'SEQ',
  `pre_condition` text COLLATE utf8_unicode_ci,
  `condition_field` varchar(40) COLLATE utf8_unicode_ci NULL,      
  `condition_operator` varchar(4) COLLATE utf8_unicode_ci NULL,
  `condition_value` varchar(40) COLLATE utf8_unicode_ci NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',   
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',  
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`workflow_id`,`transition_id`,`place_id`,`direction`),
  KEY `place_id` (`workflow_id`,`place_id`,`direction`),
  KEY `transition_id` (`workflow_id`,`transition_id`,`direction`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wf_case`
--

CREATE TABLE IF NOT EXISTS `wf_case` (
  `rdcaccount_id` int(11) unsigned NOT NULL DEFAULT '1',
  `case_id` int(10) unsigned NOT NULL DEFAULT '0',
  `workflow_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `context` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `case_status` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'OP',
  `start_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `end_date` datetime DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`case_id`),
  KEY `workflow_id` (`workflow_id`),
  KEY `rdcaccount_id` (`rdcaccount_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wf_place`
--

CREATE TABLE IF NOT EXISTS `wf_place` (
  `workflow_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `place_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `place_type` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '5',
  `place_name` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `place_desc` text COLLATE utf8_unicode_ci,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`workflow_id`,`place_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wf_token`
--

CREATE TABLE IF NOT EXISTS `wf_token` (
  `rdcaccount_id` int(11) unsigned NOT NULL DEFAULT '1',
  `case_id` int(10) unsigned NOT NULL DEFAULT '0',
  `token_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `workflow_id` smallint(6) unsigned NOT NULL DEFAULT '0',
  `place_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `context` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `token_status` varchar(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'FREE',
  `enabled_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `cancelled_date` datetime DEFAULT NULL,
  `consumed_date` datetime DEFAULT NULL,
  PRIMARY KEY (`case_id`,`token_id`),
  KEY `place_id` (`workflow_id`,`place_id`),
  KEY `rdcaccount_id` (`rdcaccount_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wf_transition`
--

CREATE TABLE IF NOT EXISTS `wf_transition` (
  `workflow_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `transition_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `transition_name` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `transition_desc` text COLLATE utf8_unicode_ci,
  `transition_trigger` varchar(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'USER',
  `time_limit` int(11) unsigned DEFAULT NULL,
  `task_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `role_id` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`workflow_id`,`transition_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wf_workflow`
--

CREATE TABLE IF NOT EXISTS `wf_workflow` (
  `workflow_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `workflow_name` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `workflow_desc` text COLLATE utf8_unicode_ci,
  `start_task_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `is_valid` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `workflow_errors` text COLLATE utf8_unicode_ci,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`workflow_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wf_workitem`
--

CREATE TABLE IF NOT EXISTS `wf_workitem` (
  `rdcaccount_id` int(11) unsigned NOT NULL DEFAULT '1',
  `case_id` int(10) unsigned NOT NULL DEFAULT '0',
  `workitem_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `workflow_id` smallint(6) unsigned NOT NULL DEFAULT '0',
  `transition_id` smallint(5) unsigned NOT NULL DEFAULT '0',
  `transition_trigger` varchar(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'USER',
  `task_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `context` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `workitem_status` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'EN',
  `enabled_date` datetime DEFAULT NULL,
  `cancelled_date` datetime DEFAULT NULL,
  `finished_date` datetime DEFAULT NULL,
  `deadline` datetime DEFAULT NULL,
  `role_id` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`case_id`,`workitem_id`),
  KEY `transition_id` (`workflow_id`,`transition_id`),
  KEY `rdcaccount_id` (`rdcaccount_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
