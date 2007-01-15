-- phpMyAdmin SQL Dump
-- version 2.7.0
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Apr 24, 2006 at 11:35 AM
-- Server version: 4.0.25
-- PHP Version: 4.4.2
-- 
-- Database: `menu`
-- 

CREATE DATABASE menu ;
USE menu ;

-- --------------------------------------------------------

-- 
-- Table structure for table `help_text`
-- 

CREATE TABLE IF NOT EXISTS `help_text` (
  `task_id` varchar(40) NOT NULL default '',
  `help_text` text,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`task_id`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `mnu_control`
-- 

CREATE TABLE IF NOT EXISTS `mnu_control` (
  `record_id` varchar(16) NOT NULL default '',
  `field_id` varchar(32) NOT NULL default '',
  `field_value` varchar(255) default NULL,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`record_id`,`field_id`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `mnu_menu`
-- 

CREATE TABLE IF NOT EXISTS `mnu_menu` (
  `menu_id` varchar(40) NOT NULL default '',
  `task_id_jnr` varchar(40) NOT NULL default '',
  `sort_seq` tinyint(3) unsigned zerofill NOT NULL default '000',
  `button_text` varchar(40) default NULL,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`menu_id`,`task_id_jnr`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `mnu_nav_button`
-- 

CREATE TABLE IF NOT EXISTS `mnu_nav_button` (
  `task_id_snr` varchar(40) NOT NULL default '',
  `task_id_jnr` varchar(40) NOT NULL default '',
  `sort_seq` tinyint(3) unsigned zerofill NOT NULL default '000',
  `button_text` varchar(40) default NULL,
  `context_preselect` char(1) default NULL,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`task_id_snr`,`task_id_jnr`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `mnu_pattern`
-- 

CREATE TABLE IF NOT EXISTS `mnu_pattern` (
  `pattern_id` varchar(16) NOT NULL default '',
  `pattern_desc` varchar(60) NOT NULL default '',
  `pattern_long_desc` text,
  `visible_screen` char(1) default NULL,
  `context_preselect` char(1) default NULL,
  `keep_data` char(1) default NULL,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`pattern_id`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `mnu_role`
-- 

CREATE TABLE IF NOT EXISTS `mnu_role` (
  `role_id` varchar(16) NOT NULL default '',
  `role_desc` varchar(30) NOT NULL default '',
  `start_task_id` varchar(40) NOT NULL default '',
  `global_access` char(1) NOT NULL default 'N',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`role_id`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `mnu_role_task`
-- 

CREATE TABLE IF NOT EXISTS `mnu_role_task` (
  `role_id` varchar(16) NOT NULL default '',
  `task_id` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`role_id`,`task_id`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `mnu_role_taskfield`
-- 

CREATE TABLE IF NOT EXISTS `mnu_role_taskfield` (
  `role_id` varchar(16) NOT NULL default '',
  `task_id` varchar(40) NOT NULL default '',
  `field_id` varchar(40) NOT NULL default '',
  `access_type` varchar(4) default NULL,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`role_id`,`task_id`,`field_id`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `mnu_subsystem`
-- 

CREATE TABLE IF NOT EXISTS `mnu_subsystem` (
  `subsys_id` varchar(8) NOT NULL default '',
  `subsys_desc` varchar(255) NOT NULL default '',
  `subsys_dir` varchar(255) default NULL,
  `task_prefix` varchar(8) default NULL,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`subsys_id`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `mnu_task`
-- 

CREATE TABLE IF NOT EXISTS `mnu_task` (
  `task_id` varchar(40) NOT NULL default '',
  `task_desc` varchar(50) NOT NULL default '',
  `button_text` varchar(40) default NULL,
  `task_type` varchar(4) default NULL,
  `script_id` varchar(40) default NULL,
  `is_disabled` char(1) default NULL,
  `pattern_id` varchar(16) default NULL,
  `subsys_id` varchar(8) default NULL,
  `initial_passthru` varchar(40) default NULL,
  `selection_fixed` varchar(255) default NULL,
  `selection_temp` varchar(255) default NULL,
  `settings` varchar(40) default NULL,
  `order_by` varchar(255) default NULL,
  `keep_data` char(1) default NULL,
  `log_sql_query` char(1) default NULL,
  `screen_refresh` smallint(5) unsigned default NULL,
  `use_https` char(1) default NULL,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`task_id`),
  KEY `subsys_id` (`subsys_id`),
  KEY `pattern_id` (`pattern_id`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `mnu_task_field`
-- 

CREATE TABLE IF NOT EXISTS `mnu_task_field` (
  `task_id` varchar(40) NOT NULL default '',
  `field_id` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`task_id`,`field_id`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `mnu_todo`
-- 

CREATE TABLE IF NOT EXISTS `mnu_todo` (
  `user_id` varchar(16) NOT NULL default '',
  `seq_no` smallint(10) unsigned NOT NULL default '0',
  `item_desc` varchar(80) NOT NULL default '',
  `item_notes` text,
  `due_date` date NOT NULL default '0000-00-00',
  `is_complete` char(1) NOT NULL default 'N',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`user_id`,`seq_no`)
) TYPE=MyISAM COMMENT='List of "To Do" items';

-- --------------------------------------------------------

-- 
-- Table structure for table `mnu_user`
-- 

CREATE TABLE IF NOT EXISTS `mnu_user` (
  `user_id` varchar(16) NOT NULL default '',
  `user_name` varchar(30) NOT NULL default '',
  `user_password` varchar(40) NOT NULL default '',
  `role_id` varchar(16) NOT NULL default '',
  `pswd_chg_date` date default NULL,
  `pswd_chg_time` time default NULL,
  `pswd_count` smallint(6) unsigned default NULL,
  `in_use` char(1) NOT NULL default 'N',
  `is_disabled` char(1) NOT NULL default 'N',
  `logon_date` date default NULL,
  `logon_time` time default NULL,
  `language_code` varchar(6) default NULL,
  `start_date` date NOT NULL default '2000-01-01',
  `end_date` date default '9999-12-31',
  `ip_address` varchar(16) default NULL,
  `email_addr` varchar(50) default NULL,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`user_id`),
  UNIQUE KEY `email_addr` (`email_addr`),
  KEY `role_id` (`role_id`)
) TYPE=MyISAM;
