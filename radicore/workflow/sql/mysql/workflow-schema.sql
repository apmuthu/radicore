-- phpMyAdmin SQL Dump
-- version 2.11.0
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 17, 2007 at 11:01 AM
-- Server version: 4.1.22
-- PHP Version: 4.4.7

--
-- Database: `workflow`
--

-- --------------------------------------------------------

--
-- Table structure for table `wf_arc`
--

CREATE TABLE IF NOT EXISTS `wf_arc` (
  `workflow_id` smallint(5) unsigned NOT NULL default '0',
  `transition_id` smallint(5) unsigned NOT NULL default '0',
  `place_id` smallint(5) unsigned NOT NULL default '0',
  `direction` varchar(3) NOT NULL default 'IN',
  `arc_type` varchar(10) NOT NULL default 'SEQ',
  `pre_condition` text,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`workflow_id`,`transition_id`,`place_id`,`direction`),
  KEY `place_id` (`workflow_id`,`place_id`,`direction`),
  KEY `transition_id` (`workflow_id`,`transition_id`,`direction`)
) TYPE=MyISAM;

-- --------------------------------------------------------

--
-- Table structure for table `wf_case`
--

CREATE TABLE IF NOT EXISTS `wf_case` (
  `rdcaccount_id` int(11) unsigned NOT NULL default '1',
  `case_id` int(10) unsigned NOT NULL default '0',
  `workflow_id` smallint(5) unsigned NOT NULL default '0',
  `context` varchar(255) NOT NULL default '',
  `case_status` varchar(2) NOT NULL default 'OP',
  `start_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `end_date` datetime default NULL,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`case_id`),
  KEY `workflow_id` (`workflow_id`),
  KEY `rdcaccount_id` (`rdcaccount_id`)
) TYPE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `wf_place`
--

CREATE TABLE IF NOT EXISTS `wf_place` (
  `workflow_id` smallint(5) unsigned NOT NULL default '0',
  `place_id` smallint(5) unsigned NOT NULL default '0',
  `place_type` char(1) NOT NULL default '5',
  `place_name` varchar(80) NOT NULL default '',
  `place_desc` text,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`workflow_id`,`place_id`)
) TYPE=MyISAM;

-- --------------------------------------------------------

--
-- Table structure for table `wf_token`
--

CREATE TABLE IF NOT EXISTS `wf_token` (
  `rdcaccount_id` int(11) unsigned NOT NULL default '1',
  `case_id` int(10) unsigned NOT NULL default '0',
  `token_id` smallint(5) unsigned NOT NULL default '0',
  `workflow_id` smallint(6) unsigned NOT NULL default '0',
  `place_id` smallint(5) unsigned NOT NULL default '0',
  `context` varchar(255) NOT NULL default '',
  `token_status` varchar(4) NOT NULL default 'FREE',
  `enabled_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `cancelled_date` datetime default NULL,
  `consumed_date` datetime default NULL,
  PRIMARY KEY  (`case_id`,`token_id`),
  KEY `place_id` (`workflow_id`,`place_id`),
  KEY `rdcaccount_id` (`rdcaccount_id`)
) TYPE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `wf_transition`
--

CREATE TABLE IF NOT EXISTS `wf_transition` (
  `workflow_id` smallint(5) unsigned NOT NULL default '0',
  `transition_id` smallint(5) unsigned NOT NULL default '0',
  `transition_name` varchar(80) NOT NULL default '',
  `transition_desc` text,
  `transition_trigger` varchar(4) NOT NULL default 'USER',
  `time_limit` smallint(5) unsigned default NULL,
  `task_id` varchar(80) NOT NULL default '',
  `role_id` varchar(16) default NULL,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`workflow_id`,`transition_id`)
) TYPE=MyISAM;

-- --------------------------------------------------------

--
-- Table structure for table `wf_workflow`
--

CREATE TABLE IF NOT EXISTS `wf_workflow` (
  `workflow_id` smallint(5) unsigned NOT NULL default '0',
  `workflow_name` varchar(80) NOT NULL default '',
  `workflow_desc` text,
  `start_task_id` varchar(80) NOT NULL default '',
  `is_valid` char(1) NOT NULL default 'N',
  `workflow_errors` text,
  `start_date` date default NULL,
  `end_date` date default NULL,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`workflow_id`)
) TYPE=MyISAM;

-- --------------------------------------------------------

--
-- Table structure for table `wf_workitem`
--

CREATE TABLE IF NOT EXISTS `wf_workitem` (
  `rdcaccount_id` int(11) unsigned NOT NULL default '1',
  `case_id` int(10) unsigned NOT NULL default '0',
  `workitem_id` smallint(5) unsigned NOT NULL default '0',
  `workflow_id` smallint(6) unsigned NOT NULL default '0',
  `transition_id` smallint(5) unsigned NOT NULL default '0',
  `transition_trigger` varchar(4) NOT NULL default 'USER',
  `task_id` varchar(80) NOT NULL default '',
  `context` varchar(255) NOT NULL default '',
  `workitem_status` varchar(2) NOT NULL default 'EN',
  `enabled_date` datetime default NULL,
  `cancelled_date` datetime default NULL,
  `finished_date` datetime default NULL,
  `deadline` datetime default NULL,
  `role_id` varchar(16) default NULL,
  `user_id` varchar(16) default NULL,
  PRIMARY KEY  (`case_id`,`workitem_id`),
  KEY `transition_id` (`workflow_id`,`transition_id`),
  KEY `rdcaccount_id` (`rdcaccount_id`)
) TYPE=InnoDB;
