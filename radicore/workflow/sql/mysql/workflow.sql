-- phpMyAdmin SQL Dump
-- version 2.6.4
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Oct 30, 2005 at 12:23 PM
-- Server version: 4.0.25
-- PHP Version: 4.4.0
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
  `direction` char(3) NOT NULL default 'IN',
  `arc_type` varchar(10) NOT NULL default 'NORMAL',
  `pre_condition` text,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`workflow_id`,`transition_id`,`place_id`,`direction`),
  KEY `place_id` (`workflow_id`,`place_id`,`direction`),
  KEY `transition_id` (`workflow_id`,`transition_id`,`direction`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `wf_arc`
-- 

REPLACE INTO `wf_arc` (`workflow_id`, `transition_id`, `place_id`, `direction`, `arc_type`, `pre_condition`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (2, 1, 1, 'IN', 'AND-JOIN', NULL, '2004-04-25 20:56:17', 'AJM', NULL, NULL);
REPLACE INTO `wf_arc` (`workflow_id`, `transition_id`, `place_id`, `direction`, `arc_type`, `pre_condition`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (1, 2, 1, 'IN', 'SEQ', NULL, '2005-10-06 18:54:22', 'AJM', NULL, NULL);
REPLACE INTO `wf_arc` (`workflow_id`, `transition_id`, `place_id`, `direction`, `arc_type`, `pre_condition`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (1, 2, 3, 'OUT', 'SEQ', NULL, '2005-10-06 18:54:51', 'AJM', NULL, NULL);
REPLACE INTO `wf_arc` (`workflow_id`, `transition_id`, `place_id`, `direction`, `arc_type`, `pre_condition`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (2, 1, 3, 'IN', 'OR-SPLIT-I', NULL, '2004-04-25 21:00:26', 'AJM', NULL, NULL);
REPLACE INTO `wf_arc` (`workflow_id`, `transition_id`, `place_id`, `direction`, `arc_type`, `pre_condition`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (2, 2, 3, 'IN', 'OR-SPLIT-I', NULL, '2004-04-25 21:28:25', 'AJM', NULL, NULL);
REPLACE INTO `wf_arc` (`workflow_id`, `transition_id`, `place_id`, `direction`, `arc_type`, `pre_condition`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (1, 3, 3, 'IN', 'SEQ', NULL, '2004-12-11 18:47:17', 'AJM', NULL, NULL);
REPLACE INTO `wf_arc` (`workflow_id`, `transition_id`, `place_id`, `direction`, `arc_type`, `pre_condition`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (1, 3, 2, 'OUT', 'SEQ', NULL, '2004-12-11 18:47:37', 'AJM', NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `wf_case`
-- 

CREATE TABLE IF NOT EXISTS `wf_case` (
  `case_id` int(10) unsigned NOT NULL default '0',
  `workflow_id` smallint(5) unsigned NOT NULL default '0',
  `context` varchar(255) NOT NULL default '',
  `case_status` char(2) NOT NULL default 'OP',
  `start_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `end_date` datetime default NULL,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`case_id`),
  KEY `workflow_id` (`workflow_id`)
) TYPE=InnoDB;

-- 
-- Dumping data for table `wf_case`
-- 


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

-- 
-- Dumping data for table `wf_place`
-- 

REPLACE INTO `wf_place` (`workflow_id`, `place_id`, `place_type`, `place_name`, `place_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (1, 3, '5', 'p1', NULL, '2004-04-12 19:06:04', 'AJM', '2004-04-13 17:11:47', 'AJM');
REPLACE INTO `wf_place` (`workflow_id`, `place_id`, `place_type`, `place_name`, `place_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (1, 1, '1', 'START', NULL, '2004-04-13 16:47:25', 'AJM', '2004-04-14 12:22:23', 'AJM');
REPLACE INTO `wf_place` (`workflow_id`, `place_id`, `place_type`, `place_name`, `place_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (1, 2, '9', 'END', NULL, '2004-04-13 16:47:38', 'AJM', '2004-04-14 12:22:40', 'AJM');
REPLACE INTO `wf_place` (`workflow_id`, `place_id`, `place_type`, `place_name`, `place_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (2, 1, '1', 'START', NULL, '2004-04-20 16:23:28', 'AJM', NULL, NULL);
REPLACE INTO `wf_place` (`workflow_id`, `place_id`, `place_type`, `place_name`, `place_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (2, 2, '9', 'END', NULL, '2004-04-20 16:23:33', 'AJM', NULL, NULL);
REPLACE INTO `wf_place` (`workflow_id`, `place_id`, `place_type`, `place_name`, `place_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (3, 1, '1', 'START', NULL, '2004-04-23 16:28:42', 'AJM', NULL, NULL);
REPLACE INTO `wf_place` (`workflow_id`, `place_id`, `place_type`, `place_name`, `place_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (3, 2, '9', 'END', NULL, '2004-04-23 16:28:42', 'AJM', NULL, NULL);
REPLACE INTO `wf_place` (`workflow_id`, `place_id`, `place_type`, `place_name`, `place_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (2, 3, '5', 'p1', NULL, '2004-04-25 16:14:28', 'AJM', NULL, NULL);
REPLACE INTO `wf_place` (`workflow_id`, `place_id`, `place_type`, `place_name`, `place_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (2, 4, '5', 'p2', NULL, '2004-04-25 21:01:37', 'AJM', NULL, NULL);
REPLACE INTO `wf_place` (`workflow_id`, `place_id`, `place_type`, `place_name`, `place_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (2, 5, '5', 'p3', NULL, '2004-04-25 21:47:46', 'AJM', NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `wf_token`
-- 

CREATE TABLE IF NOT EXISTS `wf_token` (
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
  KEY `place_id` (`workflow_id`,`place_id`)
) TYPE=InnoDB;

-- 
-- Dumping data for table `wf_token`
-- 


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
  `time_limit` int(10) unsigned default NULL,
  `task_id` varchar(40) NOT NULL default '',
  `role_id` varchar(16) NOT NULL default '',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`workflow_id`,`transition_id`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `wf_transition`
-- 

REPLACE INTO `wf_transition` (`workflow_id`, `transition_id`, `transition_name`, `transition_desc`, `transition_trigger`, `time_limit`, `task_id`, `role_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (2, 1, 'Add Person Address', NULL, 'USER', NULL, 'x_person_addr(add)', 'USER1', '2004-04-20 16:25:12', 'AJM', NULL, NULL);
REPLACE INTO `wf_transition` (`workflow_id`, `transition_id`, `transition_name`, `transition_desc`, `transition_trigger`, `time_limit`, `task_id`, `role_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (1, 2, 'Add Person Address', NULL, 'USER', NULL, 'x_person_addr(add)', 'GLOBAL', '2004-04-13 17:51:02', 'AJM', '2005-10-06 18:53:16', 'AJM');
REPLACE INTO `wf_transition` (`workflow_id`, `transition_id`, `transition_name`, `transition_desc`, `transition_trigger`, `time_limit`, `task_id`, `role_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (2, 2, 'Add Option', NULL, 'USER', NULL, 'x_option(add)', 'USER1', '2004-04-25 21:02:58', 'AJM', '2005-07-21 14:13:31', 'AJM');
REPLACE INTO `wf_transition` (`workflow_id`, `transition_id`, `transition_name`, `transition_desc`, `transition_trigger`, `time_limit`, `task_id`, `role_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (1, 3, 'Update Person Address', NULL, 'USER', NULL, 'x_person_addr(upd)', 'GLOBAL', '2004-04-13 17:51:31', 'AJM', '2004-04-22 14:27:30', 'AJM');

-- --------------------------------------------------------

-- 
-- Table structure for table `wf_workflow`
-- 

CREATE TABLE IF NOT EXISTS `wf_workflow` (
  `workflow_id` smallint(5) unsigned NOT NULL default '0',
  `workflow_name` varchar(80) NOT NULL default '',
  `workflow_desc` text,
  `start_task_id` varchar(40) NOT NULL default '',
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

-- 
-- Dumping data for table `wf_workflow`
-- 

REPLACE INTO `wf_workflow` (`workflow_id`, `workflow_name`, `workflow_desc`, `start_task_id`, `is_valid`, `workflow_errors`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (1, 'This is just a test', 'This is a long description. There is currently the only workable workflow.', 'x_person(add)', 'Y', NULL, '2004-04-10', '9999-12-31', '2004-04-04 00:10:10', 'AJM', '2005-10-06 19:01:10', 'AJM');
REPLACE INTO `wf_workflow` (`workflow_id`, `workflow_name`, `workflow_desc`, `start_task_id`, `is_valid`, `workflow_errors`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (2, 'This is another test', 'Just a test. It has lots of errors.', 'x_person(add)', 'N', 'There are no ARCS going into the END place.\nThere are no OUTWARD ARCS for place ''p1''\nThere are no INWARD ARCS for place ''p2''\nThere are no OUTWARD ARCS for place ''p2''\nThere are no INWARD ARCS for place ''p3''\nThere are no OUTWARD ARCS for place ''p3''\nNot enough arcs of type ''AND-join'' at transition ''Add Person Address''\nThere is more than 1 type of INWARD ARC for transition ''Add Person Address''\nThere are no OUTWARD ARCS for transition ''Add Person Address''\nThere are no OUTWARD ARCS for transition ''Add Option''\n', '2004-01-01', '2004-01-31', '2004-04-20 16:23:27', 'AJM', '2005-07-21 14:14:08', 'AJM');
REPLACE INTO `wf_workflow` (`workflow_id`, `workflow_name`, `workflow_desc`, `start_task_id`, `is_valid`, `workflow_errors`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (3, 'Yet another test', 'This is another test with errors.', 'x_option(add)', 'N', 'There are no intermediate places.\nThere are no TRANSITIONS.\nThere are no ARCS.\nThere are no ARCS coming out of the START place.\nThere are no ARCS going into the END place.\n', '2004-04-01', '9999-12-31', '2004-04-23 16:28:42', 'AJM', '2005-07-21 12:51:44', 'AJM');

-- --------------------------------------------------------

-- 
-- Table structure for table `wf_workitem`
-- 

CREATE TABLE IF NOT EXISTS `wf_workitem` (
  `case_id` int(10) unsigned NOT NULL default '0',
  `workitem_id` smallint(5) unsigned NOT NULL default '0',
  `workflow_id` smallint(6) unsigned NOT NULL default '0',
  `transition_id` smallint(5) unsigned NOT NULL default '0',
  `transition_trigger` varchar(4) NOT NULL default 'USER',
  `task_id` varchar(40) NOT NULL default '',
  `context` varchar(255) NOT NULL default '',
  `workitem_status` char(2) NOT NULL default 'EN',
  `enabled_date` datetime default NULL,
  `cancelled_date` datetime default NULL,
  `finished_date` datetime default NULL,
  `deadline` datetime default NULL,
  `role_id` varchar(16) default NULL,
  `user_id` varchar(16) default NULL,
  PRIMARY KEY  (`case_id`,`workitem_id`),
  KEY `transition_id` (`workflow_id`,`transition_id`)
) TYPE=InnoDB;

-- 
-- Dumping data for table `wf_workitem`
-- 

