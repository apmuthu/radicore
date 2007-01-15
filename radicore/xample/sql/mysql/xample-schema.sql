-- phpMyAdmin SQL Dump
-- version 2.7.0
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Sep 21, 2006 at 10:12 AM
-- Server version: 4.0.25
-- PHP Version: 4.4.4
-- 
-- Database: `xample`
-- 

CREATE DATABASE `xample`;
USE `xample`;

-- --------------------------------------------------------

-- 
-- Table structure for table `x_option`
-- 

CREATE TABLE IF NOT EXISTS `x_option` (
  `option_id` varchar(8) NOT NULL default '',
  `option_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`option_id`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `x_pers_opt_xref`
-- 

CREATE TABLE IF NOT EXISTS `x_pers_opt_xref` (
  `person_id` varchar(8) NOT NULL default '',
  `option_id` varchar(8) NOT NULL default '',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`person_id`,`option_id`),
  KEY `option_id` (`option_id`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `x_pers_type`
-- 

CREATE TABLE IF NOT EXISTS `x_pers_type` (
  `pers_type_id` varchar(6) NOT NULL default '',
  `pers_type_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`pers_type_id`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `x_person`
-- 

CREATE TABLE IF NOT EXISTS `x_person` (
  `person_id` varchar(8) NOT NULL default '',
  `pers_type_id` varchar(6) NOT NULL default '',
  `node_id` smallint(4) unsigned NOT NULL default '0',
  `nat_ins_no` varchar(10) NOT NULL default '',
  `first_name` varchar(20) NOT NULL default '',
  `last_name` varchar(30) NOT NULL default '',
  `initials` varchar(6) default NULL,
  `star_sign` char(3) NOT NULL default '',
  `email_addr` varchar(50) default NULL,
  `value1` smallint(5) unsigned default NULL,
  `value2` decimal(10,2) unsigned default NULL,
  `last_addr_no` smallint(4) unsigned default '0',
  `start_date` date NOT NULL default '2000-01-01',
  `end_date` date default '9999-12-31',
  `picture` varchar(40) default NULL,
  `favourite_food` set('1','2','3','4','5','6','7','8','9','10') default NULL,
  `fckeditor_test` text,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`person_id`),
  UNIQUE KEY `nat_ins_no` (`nat_ins_no`),
  KEY `pers_type_id` (`pers_type_id`)
) TYPE=InnoDB;

-- --------------------------------------------------------

-- 
-- Table structure for table `x_person_addr`
-- 

CREATE TABLE IF NOT EXISTS `x_person_addr` (
  `person_id` varchar(8) NOT NULL default '',
  `address_no` smallint(4) unsigned NOT NULL default '0',
  `telephone_no` varchar(20) default NULL,
  `fax_no` varchar(20) default NULL,
  `addr_line_1` varchar(30) NOT NULL default '',
  `addr_line_2` varchar(30) default NULL,
  `addr_line_3` varchar(30) default NULL,
  `town` varchar(30) NOT NULL default '',
  `county` varchar(30) default NULL,
  `postcode` varchar(10) NOT NULL default '',
  `start_date` date NOT NULL default '2000-01-01',
  `end_date` date default '9999-12-31',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`person_id`,`address_no`)
) TYPE=InnoDB;

-- --------------------------------------------------------

-- 
-- Table structure for table `x_tree_level`
-- 

CREATE TABLE IF NOT EXISTS `x_tree_level` (
  `tree_type_id` varchar(8) NOT NULL default '',
  `tree_level_id` tinyint(3) unsigned NOT NULL default '0',
  `tree_level_seq` tinyint(3) unsigned NOT NULL default '0',
  `tree_level_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`tree_type_id`,`tree_level_id`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `x_tree_node`
-- 

CREATE TABLE IF NOT EXISTS `x_tree_node` (
  `node_id` smallint(5) unsigned NOT NULL default '0',
  `tree_type_id` varchar(8) NOT NULL default '',
  `tree_level_id` tinyint(3) unsigned NOT NULL default '0',
  `node_desc` varchar(40) NOT NULL default '',
  `node_id_snr` smallint(5) unsigned default NULL,
  `external_code` varchar(255) default NULL,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`node_id`),
  KEY `tree_type_id` (`tree_type_id`,`tree_level_id`),
  KEY `node_id_snr` (`node_id_snr`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `x_tree_type`
-- 

CREATE TABLE IF NOT EXISTS `x_tree_type` (
  `tree_type_id` varchar(8) NOT NULL default '',
  `tree_type_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`tree_type_id`)
) TYPE=MyISAM;