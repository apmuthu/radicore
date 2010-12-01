-- phpMyAdmin SQL Dump
-- version 2.7.0
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Jul 16, 2006 at 05:00 PM
-- Server version: 4.0.25
-- PHP Version: 4.4.2
-- 
-- Database: `survey`
-- 

CREATE DATABASE survey ;
USE survey ;

-- --------------------------------------------------------

-- 
-- Table structure for table `answer_option`
-- 

CREATE TABLE IF NOT EXISTS `answer_option` (
  `survey_id` smallint(5) unsigned NOT NULL default '0',
  `section_id` smallint(5) unsigned NOT NULL default '0',
  `question_id` smallint(5) unsigned NOT NULL default '0',
  `answer_id` tinyint(2) unsigned NOT NULL default '0',
  `answer_seq` smallint(2) unsigned NOT NULL default '0',
  `answer_text` varchar(255) NOT NULL default '0',
  `jumpto_section_seq` smallint(5) unsigned default NULL,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`survey_id`,`section_id`,`question_id`,`answer_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `asset_type`
-- 

CREATE TABLE IF NOT EXISTS `asset_type` (
  `asset_type_id` tinyint(3) unsigned NOT NULL default '0',
  `asset_type_desc` varchar(40) NOT NULL default '',
  `image_fname` varchar(255) default NULL,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`asset_type_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `default_prompt`
-- 

CREATE TABLE IF NOT EXISTS `default_prompt` (
  `survey_id` smallint(5) unsigned NOT NULL default '0',
  `prompt_id` tinyint(2) unsigned NOT NULL default '0',
  `prompt_desc` varchar(30) NOT NULL default '',
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`survey_id`,`prompt_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `location_address`
-- 

CREATE TABLE IF NOT EXISTS `location_address` (
  `node_id` smallint(5) unsigned NOT NULL default '0',
  `address_line1` varchar(80) default NULL,
  `address_line2` varchar(80) default NULL,
  `town` varchar(80) default NULL,
  `county` varchar(80) default NULL,
  `postcode` varchar(10) default NULL,
  `country` varchar(80) default NULL,
  `telephone` varchar(20) default NULL,
  `fax` varchar(20) default NULL,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`node_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `location_type`
-- 

CREATE TABLE IF NOT EXISTS `location_type` (
  `location_type_id` tinyint(3) unsigned NOT NULL default '0',
  `location_type_desc` varchar(40) NOT NULL default '',
  `image_fname` varchar(255) default NULL,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`location_type_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `number_option`
-- 

CREATE TABLE IF NOT EXISTS `number_option` (
  `survey_id` smallint(5) unsigned NOT NULL default '0',
  `section_id` smallint(5) unsigned NOT NULL default '0',
  `question_id` smallint(5) unsigned NOT NULL default '0',
  `min_value` int(10) unsigned NOT NULL default '0',
  `max_value` int(10) unsigned default '0',
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`survey_id`,`section_id`,`question_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `org_type`
-- 

CREATE TABLE IF NOT EXISTS `org_type` (
  `org_type_id` tinyint(3) unsigned NOT NULL default '0',
  `org_type_desc` varchar(40) NOT NULL default '',
  `image_fname` varchar(255) default NULL,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`org_type_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `question_prompt`
-- 

CREATE TABLE IF NOT EXISTS `question_prompt` (
  `survey_id` smallint(5) unsigned NOT NULL default '0',
  `section_id` smallint(5) unsigned NOT NULL default '0',
  `question_id` smallint(5) unsigned NOT NULL default '0',
  `prompt_id` tinyint(2) unsigned NOT NULL default '0',
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`survey_id`,`section_id`,`question_id`,`prompt_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `risk_status`
-- 

CREATE TABLE IF NOT EXISTS `risk_status` (
  `risk_status_id` tinyint(3) unsigned NOT NULL default '0',
  `risk_status_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`risk_status_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `risk_weighting`
-- 

CREATE TABLE IF NOT EXISTS `risk_weighting` (
  `weighting_id` tinyint(3) unsigned NOT NULL default '0',
  `weighting_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`weighting_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `survey_answer_dtl`
-- 

CREATE TABLE IF NOT EXISTS `survey_answer_dtl` (
  `survey_answer_id` int(10) unsigned NOT NULL default '0',
  `survey_id` smallint(5) unsigned NOT NULL default '0',
  `section_id` smallint(5) unsigned NOT NULL default '0',
  `question_id` smallint(5) unsigned NOT NULL default '0',
  `answer_text` varchar(255) NOT NULL default '',
  `weighting_id` tinyint(3) unsigned default NULL,
  `measure_adequate` char(1) NOT NULL default '',
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`survey_answer_id`,`survey_id`,`section_id`,`question_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `survey_answer_hdr`
-- 

CREATE TABLE IF NOT EXISTS `survey_answer_hdr` (
  `survey_answer_id` int(10) unsigned NOT NULL default '0',
  `user_id` varchar(16) default NULL,
  `answer_date` date NOT NULL default '0000-00-00',
  `survey_id` smallint(5) unsigned NOT NULL default '0',
  `node_id` smallint(5) unsigned NOT NULL default '0',
  `is_complete` char(1) NOT NULL default 'N',
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`survey_answer_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `survey_hdr`
-- 

CREATE TABLE IF NOT EXISTS `survey_hdr` (
  `survey_id` smallint(5) unsigned NOT NULL default '0',
  `survey_name` varchar(80) NOT NULL default '',
  `survey_long_name` varchar(255) NOT NULL default '',
  `survey_type_id` varchar(4) NOT NULL default '',
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`survey_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `survey_question`
-- 

CREATE TABLE IF NOT EXISTS `survey_question` (
  `survey_id` smallint(5) unsigned NOT NULL default '0',
  `section_id` smallint(5) unsigned NOT NULL default '0',
  `question_id` smallint(5) unsigned NOT NULL default '0',
  `question_seq` smallint(5) unsigned NOT NULL default '0',
  `question_text` varchar(255) NOT NULL default '',
  `answer_type` char(1) NOT NULL default '',
  `advice_text` text,
  `risk_status_id` tinyint(2) NOT NULL default '0',
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`survey_id`,`section_id`,`question_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `survey_section`
-- 

CREATE TABLE IF NOT EXISTS `survey_section` (
  `survey_id` smallint(5) unsigned NOT NULL default '0',
  `section_id` smallint(5) unsigned NOT NULL default '0',
  `section_seq` smallint(5) unsigned NOT NULL default '0',
  `section_name` varchar(80) NOT NULL default '',
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`survey_id`,`section_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `survey_type`
-- 

CREATE TABLE IF NOT EXISTS `survey_type` (
  `survey_type_id` varchar(4) NOT NULL default '',
  `survey_type_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`survey_type_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `tree_node`
-- 

CREATE TABLE IF NOT EXISTS `tree_node` (
  `node_id` smallint(5) unsigned NOT NULL default '0',
  `node_desc` varchar(40) NOT NULL default '',
  `node_type` char(1) NOT NULL default '',
  `node_depth` tinyint(3) unsigned NOT NULL default '0',
  `node_id_snr` smallint(5) unsigned default NULL,
  `org_type_id` tinyint(3) unsigned default NULL,
  `location_type_id` tinyint(3) unsigned default NULL,
  `asset_type_id` tinyint(3) unsigned default NULL,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`node_id`)
) ENGINE=MyISAM;
