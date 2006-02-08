-- phpMyAdmin SQL Dump
-- version 2.7.0
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Dec 31, 2005 at 04:46 PM
-- Server version: 4.0.25
-- PHP Version: 4.4.1
-- 
-- Database: `audit`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `audit_fld`
-- 

CREATE TABLE IF NOT EXISTS `audit_fld` (
  `session_id` bigint(20) unsigned NOT NULL default '0',
  `tran_seq_no` smallint(6) unsigned NOT NULL default '0',
  `table_seq_no` smallint(6) unsigned NOT NULL default '0',
  `field_id` varchar(255) NOT NULL default '',
  `old_value` text,
  `new_value` text,
  PRIMARY KEY  (`session_id`,`tran_seq_no`,`table_seq_no`,`field_id`),
  KEY `field_id` (`field_id`)
) TYPE=MyISAM COMMENT='Audit Trail Field data';

-- --------------------------------------------------------

-- 
-- Table structure for table `audit_ssn`
-- 

CREATE TABLE IF NOT EXISTS `audit_ssn` (
  `session_id` bigint(20) unsigned NOT NULL auto_increment,
  `user_id` varchar(16) NOT NULL default 'UNKNOWN',
  `date` date NOT NULL default '2000-01-01',
  `time` time NOT NULL default '00:00:00',
  PRIMARY KEY  (`session_id`)
) TYPE=MyISAM COMMENT='Audit Trail Session data' ;

-- --------------------------------------------------------

-- 
-- Table structure for table `audit_tbl`
-- 

CREATE TABLE IF NOT EXISTS `audit_tbl` (
  `session_id` bigint(20) unsigned NOT NULL default '0',
  `tran_seq_no` smallint(6) unsigned NOT NULL default '0',
  `table_seq_no` smallint(6) unsigned NOT NULL default '0',
  `base_name` varchar(32) NOT NULL default '',
  `table_name` varchar(32) NOT NULL default '',
  `pkey` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`session_id`,`tran_seq_no`,`table_seq_no`),
  KEY `pkey` (`pkey`)
) TYPE=MyISAM COMMENT='Audit Trail Table data';

-- --------------------------------------------------------

-- 
-- Table structure for table `audit_trn`
-- 

CREATE TABLE IF NOT EXISTS `audit_trn` (
  `session_id` bigint(20) unsigned NOT NULL default '0',
  `tran_seq_no` smallint(6) unsigned NOT NULL default '0',
  `date` date NOT NULL default '2000-01-01',
  `time` time NOT NULL default '00:00:00',
  `task_id` varchar(32) NOT NULL default '',
  PRIMARY KEY  (`session_id`,`tran_seq_no`)
) TYPE=MyISAM COMMENT='Audit Trail Transaction data';

-- --------------------------------------------------------

-- 
-- Table structure for table `php_session`
-- 

CREATE TABLE `php_session` (
  `session_id` varchar(32) NOT NULL default '',
  `user_id` varchar(16) NOT NULL default 'UNKNOWN',
  `date_created` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_updated` datetime NOT NULL default '0000-00-00 00:00:00',
  `session_data` longtext,
  PRIMARY KEY  (`session_id`),
  KEY `last_updated` (`last_updated`)
) ENGINE=MyISAM;
