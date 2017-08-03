-- phpMyAdmin SQL Dump
-- version 2.7.0
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Dec 16, 2006 at 07:47 PM
-- Server version: 4.0.26
-- PHP Version: 4.4.4
-- 
-- Database: `product`
-- 

-- REATE DATABASE product ;
-- USE product ;

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
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`facility_id`,`container_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `container_type`
-- 

CREATE TABLE IF NOT EXISTS `container_type` (
  `container_type_id` smallint(5) unsigned NOT NULL auto_increment,
  `container_type_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`container_type_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `facility`
-- 

CREATE TABLE IF NOT EXISTS `facility` (
  `facility_id` smallint(5) unsigned NOT NULL auto_increment,
  `facility_desc` varchar(255) NOT NULL default '',
  `facility_type_id` smallint(6) unsigned NOT NULL default '0',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`facility_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `facility_type`
-- 

CREATE TABLE IF NOT EXISTS `facility_type` (
  `facility_type_id` smallint(6) unsigned NOT NULL auto_increment,
  `facility_type_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`facility_type_id`)
) ENGINE=MyISAM PACK_KEYS=0;

-- --------------------------------------------------------

-- 
-- Table structure for table `good_identification`
-- 

CREATE TABLE IF NOT EXISTS `good_identification` (
  `product_id` varchar(16) NOT NULL default '',
  `identity_type_id` varchar(6) NOT NULL default '',
  `id_value` varchar(32) NOT NULL default '',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`product_id`,`identity_type_id`),
  UNIQUE KEY `identity_type_id` (`identity_type_id`,`id_value`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `good_identity_type`
-- 

CREATE TABLE IF NOT EXISTS `good_identity_type` (
  `identity_type_id` varchar(6) NOT NULL default '',
  `identity_type_desc` varchar(255) NOT NULL default '',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`identity_type_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

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
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`product_id`,`inventory_item_id`),
  UNIQUE KEY `serial_no` (`product_id`,`serial_no`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `inventory_item_status`
-- 

CREATE TABLE IF NOT EXISTS `inventory_item_status` (
  `inv_item_status_id` smallint(5) unsigned NOT NULL auto_increment,
  `inv_item_status_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`inv_item_status_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `inventory_item_status_hist`
-- 

CREATE TABLE IF NOT EXISTS `inventory_item_status_hist` (
  `product_id` varchar(16) NOT NULL default '',
  `inventory_item_id` smallint(5) unsigned NOT NULL default '0',
  `seq_no` smallint(5) unsigned NOT NULL default '0',
  `inv_item_status_id` smallint(5) unsigned NOT NULL default '0',
  `status_date` date NOT NULL default '2001-01-01',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`product_id`,`inventory_item_id`,`seq_no`)
) ENGINE=MyISAM;

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
  `var_comment` text,
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`product_id`,`inventory_item_id`,`seq_no`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `inventory_variance_reason`
-- 

CREATE TABLE IF NOT EXISTS `inventory_variance_reason` (
  `inv_var_reason_id` smallint(5) unsigned NOT NULL auto_increment,
  `inv_var_reason_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`inv_var_reason_id`)
) ENGINE=MyISAM PACK_KEYS=0;

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
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`lot_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `price_component`
-- 

CREATE TABLE IF NOT EXISTS `price_component` (
  `price_component_id` int(10) unsigned NOT NULL default '0',
  `start_date` date NOT NULL default '2001-01-01',
  `end_date` date default NULL,
  `price` decimal(11,2) unsigned default NULL,
  `percent` decimal(6,3) unsigned default NULL,
  `price_type` char(1) NOT NULL default '',
  `price_frequency` char(1) NOT NULL default '',
  `uom_id` varchar(16) default NULL,
  `quantity` smallint(6) unsigned default NULL,
  `product_id` varchar(16) default NULL,
  `prod_feature_id` mediumint(8) unsigned default NULL,
  `prod_cat_id` varchar(16) default NULL,
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`price_component_id`),
  KEY `product_id` (`product_id`),
  KEY `prod_feature_id` (`prod_feature_id`),
  KEY `prod_cat_id` (`prod_cat_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `prod_cat_class`
-- 

CREATE TABLE IF NOT EXISTS `prod_cat_class` (
  `product_id` varchar(16) NOT NULL default '',
  `prod_cat_id` varchar(16) NOT NULL default '',
  `seq_no` smallint(5) unsigned NOT NULL default '0',
  `primary_flag` char(1) NOT NULL default '',
  `pcc_comment` varchar(255) default NULL,
  `start_date` date NOT NULL default '2001-01-01',
  `end_date` date default NULL,
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`product_id`,`prod_cat_id`,`seq_no`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `prod_cat_rollup`
-- 

CREATE TABLE IF NOT EXISTS `prod_cat_rollup` (
  `prod_cat_id_snr` varchar(16) NOT NULL default '',
  `prod_cat_id_jnr` varchar(16) NOT NULL default '',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`prod_cat_id_snr`,`prod_cat_id_jnr`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `prod_feature_applicability`
-- 

CREATE TABLE IF NOT EXISTS `prod_feature_applicability` (
  `product_id` varchar(16) NOT NULL default '',
  `prod_feature_id` mediumint(9) unsigned NOT NULL default '0',
  `seq_no` smallint(6) unsigned NOT NULL default '1',
  `feature_type` char(1) NOT NULL default 'O',
  `start_date` date NOT NULL default '2001-01-01',
  `end_date` date default NULL,
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`product_id`,`prod_feature_id`,`seq_no`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `prod_feature_interaction`
-- 

CREATE TABLE IF NOT EXISTS `prod_feature_interaction` (
  `product_id` varchar(16) NOT NULL default '',
  `prod_feature_id_snr` mediumint(9) unsigned NOT NULL default '0',
  `prod_feature_id_jnr` mediumint(9) unsigned NOT NULL default '0',
  `feature_interaction` char(1) NOT NULL default '',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`product_id`,`prod_feature_id_snr`,`prod_feature_id_jnr`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `product`
-- 

CREATE TABLE IF NOT EXISTS `product` (
  `product_id` varchar(16) NOT NULL default '',
  `product_name` varchar(255) NOT NULL default '',
  `date_intro` date default NULL,
  `end_date_sales` date default NULL,
  `end_date_support` date default NULL,
  `prod_comment` varchar(255) default NULL,
  `product_subtype` char(1) NOT NULL default 'G',
  `uom_id` varchar(16) default NULL,
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`product_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `product_category`
-- 

CREATE TABLE IF NOT EXISTS `product_category` (
  `prod_cat_id` varchar(16) NOT NULL default '',
  `prod_cat_desc` varchar(255) NOT NULL default '',
  `product_usage` varchar(16) default NULL,
  `product_industry` varchar(16) default NULL,
  `product_materials` varchar(16) default NULL,
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`prod_cat_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `product_feature`
-- 

CREATE TABLE IF NOT EXISTS `product_feature` (
  `prod_feature_id` mediumint(9) unsigned NOT NULL default '0',
  `prod_feature_desc` varchar(255) NOT NULL default '',
  `prod_feature_cat_id` varchar(16) default NULL,
  `uom_id` varchar(16) default NULL,
  `measurement` float default NULL,
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`prod_feature_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `product_feature_category`
-- 

CREATE TABLE IF NOT EXISTS `product_feature_category` (
  `prod_feature_cat_id` varchar(16) NOT NULL default '',
  `prod_feature_cat_desc` varchar(255) NOT NULL default '',
  `measurement_reqd` char(1) NOT NULL default 'N',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`prod_feature_cat_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `unit_of_measure`
-- 

CREATE TABLE IF NOT EXISTS `unit_of_measure` (
  `uom_id` varchar(16) NOT NULL default '',
  `uom_cat_id` varchar(4) NOT NULL default '',
  `uom_abbrev` varchar(8) NOT NULL default '',
  `uom_desc` varchar(255) NOT NULL default '',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`uom_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `uom_category`
-- 

CREATE TABLE IF NOT EXISTS `uom_category` (
  `uom_cat_id` varchar(4) NOT NULL default '',
  `uom_cat_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`uom_cat_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `uom_conversion`
-- 

CREATE TABLE IF NOT EXISTS `uom_conversion` (
  `uom_id_from` varchar(16) NOT NULL default '',
  `uom_id_to` varchar(16) NOT NULL default '',
  `conversion_factor` double NOT NULL default '0',
  `created_date` datetime NOT NULL default '2001-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`uom_id_from`,`uom_id_to`)
) ENGINE=MyISAM;
