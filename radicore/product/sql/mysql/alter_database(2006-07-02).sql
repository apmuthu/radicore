-- phpMyAdmin SQL Dump
-- version 2.7.0
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Jun 30, 2006 at 09:58 PM
-- Server version: 4.0.25
-- PHP Version: 4.4.2
-- 
-- Database: `product`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `container`
-- 

CREATE TABLE IF NOT EXISTS `container` (
  `facility_id` smallint(5) unsigned NOT NULL default '0',
  `container_id` smallint(5) unsigned NOT NULL default '0',
  `container_desc` varchar(40) NOT NULL default '',
  `container_type_id` smallint(5) unsigned NOT NULL default '0',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`facility_id`,`container_id`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `container_type`
-- 

CREATE TABLE IF NOT EXISTS `container_type` (
  `container_type_id` smallint(5) unsigned NOT NULL auto_increment,
  `container_type_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`container_type_id`)
) TYPE=MyISAM AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `facility`
-- 

CREATE TABLE IF NOT EXISTS `facility` (
  `facility_id` smallint(6) unsigned NOT NULL auto_increment,
  `facility_desc` varchar(255) NOT NULL default '',
  `facility_type_id` smallint(6) unsigned NOT NULL default '0',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`facility_id`)
) TYPE=MyISAM AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `facility_type`
-- 

CREATE TABLE IF NOT EXISTS `facility_type` (
  `facility_type_id` smallint(6) unsigned NOT NULL auto_increment,
  `facility_type_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`facility_type_id`)
) TYPE=MyISAM PACK_KEYS=0 AUTO_INCREMENT=3 ;

-- 
-- Table structure for table `inventory_item`
-- 

CREATE TABLE IF NOT EXISTS `inventory_item` (
  `product_id` varchar(16) NOT NULL default '',
  `inventory_item_id` smallint(6) unsigned NOT NULL default '0',
  `inv_type` char(1) NOT NULL default '',
  `serial_no` varchar(40) default NULL,
  `qty_on_hand` int(11) default NULL,
  `total_qty` int(11) default NULL,
  `facility_id` smallint(5) unsigned NOT NULL default '0',
  `container_id` smallint(5) unsigned NOT NULL default '0',
  `lot_id` int(10) unsigned default NULL,
  `inv_item_status_id` smallint(5) unsigned NOT NULL default '1',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`product_id`,`inventory_item_id`),
  UNIQUE KEY `serial_no` (`product_id`,`serial_no`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `inventory_item_status`
-- 

CREATE TABLE IF NOT EXISTS `inventory_item_status` (
  `inv_item_status_id` smallint(5) unsigned NOT NULL auto_increment,
  `inv_item_status_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`inv_item_status_id`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `inventory_item_status_hist`
-- 

CREATE TABLE IF NOT EXISTS `inventory_item_status_hist` (
  `product_id` varchar(16) NOT NULL default '',
  `inventory_item_id` smallint(5) unsigned NOT NULL default '0',
  `seq_no` smallint(6) unsigned NOT NULL default '0',
  `inv_item_status_id` smallint(5) unsigned NOT NULL default '0',
  `status_date` date NOT NULL default '2001-01-01',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`product_id`,`inventory_item_id`,`seq_no`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `inventory_item_variance`
-- 

CREATE TABLE IF NOT EXISTS `inventory_item_variance` (
  `product_id` varchar(16) NOT NULL default '',
  `inventory_item_id` smallint(5) unsigned NOT NULL default '0',
  `seq_no` smallint(5) unsigned NOT NULL default '0',
  `inv_var_reason_id` smallint(5) unsigned NOT NULL default '0',
  `inventory_date` date NOT NULL default '2001-01-01',
  `variance_qty` int(11) default NULL,
  `comment` text default NULL,
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`product_id`,`inventory_item_id`,`seq_no`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `inventory_variance_reason`
-- 

CREATE TABLE IF NOT EXISTS `inventory_variance_reason` (
  `inv_var_reason_id` smallint(5) unsigned NOT NULL auto_increment,
  `inv_var_reason_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`inv_var_reason_id`)
) TYPE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `lot`
-- 

CREATE TABLE IF NOT EXISTS `lot` (
  `lot_id` int(10) unsigned NOT NULL default '0',
  `quantity` int(10) unsigned NOT NULL default '0',
  `manuf_date` date NOT NULL default '2001-01-01',
  `expiry_date` date default NULL,
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`lot_id`)
) TYPE=MyISAM;

