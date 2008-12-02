-- phpMyAdmin SQL Dump
-- version 2.10.0.2
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Mar 06, 2007 at 11:41 AM
-- Server version: 4.1.22
-- PHP Version: 4.4.6

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
) TYPE=InnoDB COMMENT='Audit Trail Field data';

-- --------------------------------------------------------

-- 
-- Table structure for table `audit_logon_errors`
-- 

CREATE TABLE IF NOT EXISTS `audit_logon_errors` (
  `id` int(11) NOT NULL auto_increment,
  `err_timestamp` datetime NOT NULL default '0000-00-00 00:00:00',
  `ip_address` varchar(16) NOT NULL default '0.0.0.0',
  `user_id` varchar(16) NOT NULL default '',
  `user_password` varchar(16) NOT NULL default '',
  PRIMARY KEY  (`id`)
) TYPE=MyISAM  AUTO_INCREMENT=22 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `audit_ssn`
-- 

CREATE TABLE IF NOT EXISTS `audit_ssn` (
  `session_id` bigint(20) unsigned NOT NULL auto_increment,
  `user_id` varchar(16) NOT NULL default 'UNKNOWN',
  `ssn_date` date NOT NULL default '2000-01-01',
  `ssn_time` time NOT NULL default '00:00:00',
  PRIMARY KEY  (`session_id`)
) TYPE=InnoDB COMMENT='Audit Trail Session data' AUTO_INCREMENT=1873 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `audit_tbl`
-- 

CREATE TABLE IF NOT EXISTS `audit_tbl` (
  `session_id` bigint(20) unsigned NOT NULL default '0',
  `tran_seq_no` smallint(6) unsigned NOT NULL default '0',
  `table_seq_no` smallint(6) unsigned NOT NULL default '0',
  `base_name` varchar(64) NOT NULL default '',
  `table_name` varchar(64) NOT NULL default '',
  `pkey` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`session_id`,`tran_seq_no`,`table_seq_no`),
  KEY `pkey` (`pkey`)
) TYPE=InnoDB COMMENT='Audit Trail Table data';

-- --------------------------------------------------------

-- 
-- Table structure for table `audit_trn`
-- 

CREATE TABLE IF NOT EXISTS `audit_trn` (
  `session_id` bigint(20) unsigned NOT NULL default '0',
  `tran_seq_no` smallint(6) unsigned NOT NULL default '0',
  `trn_date` date NOT NULL default '2000-01-01',
  `trn_time` time NOT NULL default '00:00:00',
  `task_id` varchar(80) NOT NULL default '',
  PRIMARY KEY  (`session_id`,`tran_seq_no`)
) TYPE=InnoDB COMMENT='Audit Trail Transaction data';

-- --------------------------------------------------------

-- 
-- Table structure for table `php_session`
-- 

CREATE TABLE IF NOT EXISTS `php_session` (
  `session_id` varchar(32) NOT NULL default '',
  `user_id` varchar(16) NOT NULL default 'UNKNOWN',
  `date_created` datetime NOT NULL default '2000-01-01 00:00:00',
  `last_updated` datetime NOT NULL default '2000-01-01 00:00:00',
  `session_data` longtext,
  PRIMARY KEY  (`session_id`),
  KEY `last_updated` (`last_updated`)
) TYPE=MyISAM;
