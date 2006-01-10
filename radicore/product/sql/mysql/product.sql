-- phpMyAdmin SQL Dump
-- version 2.6.2-dev
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Apr 11, 2005 at 05:50 PM
-- Server version: 4.1.11
-- PHP Version: 5.0.4
-- 
-- Database: `product`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `good_identification`
-- 

CREATE TABLE IF NOT EXISTS `good_identification` (
  `product_id` varchar(16) NOT NULL default '',
  `identity_type_id` varchar(6) NOT NULL default '',
  `id_value` varchar(32) default NULL,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`product_id`,`identity_type_id`),
  UNIQUE KEY `identity_type_id` (`identity_type_id`,`id_value`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `good_identification`
-- 

REPLACE INTO `good_identification` VALUES ('PAP192', 'MANUF', 'MAN001', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `good_identification` VALUES ('PAP192', 'SKU', 'SKU001', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `good_identification` VALUES ('PEN202', 'MANUF', 'MAN002', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `good_identification` VALUES ('PEN202', 'SKU', 'SKU002', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `good_identification` VALUES ('DSK401', 'MANUF', 'MAN003', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `good_identification` VALUES ('DSK401', 'SKU', 'SKU003', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `good_identification` VALUES ('FRMCHFA1500', 'MANUF', 'MAN004', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `good_identification` VALUES ('FRMCHFA1500', 'SKU', 'SKU004', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `good_identification` VALUES ('PC101', 'MANUF', 'MAN005', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `good_identification` VALUES ('PC101', 'SKU', 'SKU005', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `good_identification` VALUES ('PC100', 'MANUF', 'MAN006', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `good_identification` VALUES ('PC100', 'SKU', 'SKU006', '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `good_identity_type`
-- 

CREATE TABLE IF NOT EXISTS `good_identity_type` (
  `identity_type_id` varchar(6) NOT NULL default '',
  `identity_type_desc` varchar(255) default NULL,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`identity_type_id`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `good_identity_type`
-- 

REPLACE INTO `good_identity_type` VALUES ('MANUF', 'Manufacturer''s ID number', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `good_identity_type` VALUES ('UPCA', 'Universal Product Code - America', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `good_identity_type` VALUES ('UPCE', 'Universal Product Code - Europe', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `good_identity_type` VALUES ('SKU', 'Stock Keeping Unit', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `good_identity_type` VALUES ('ISBN', 'International Standard Book Number', '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `price_component`
-- 

CREATE TABLE IF NOT EXISTS `price_component` (
  `price_component_id` int(10) unsigned NOT NULL default '0',
  `start_date` date NOT NULL default '0000-00-00',
  `end_date` date default NULL,
  `price` decimal(11,2) unsigned default NULL,
  `percent` decimal(6,3) unsigned default NULL,
  `price_type` char(1) default NULL,
  `price_frequency` char(1) default NULL,
  `uom_id` varchar(16) default NULL,
  `quantity` smallint(6) unsigned default NULL,
  `product_id` varchar(16) default NULL,
  `prod_feature_id` mediumint(8) unsigned default NULL,
  `prod_cat_id` varchar(16) default NULL,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`price_component_id`),
  KEY `product_id` (`product_id`),
  KEY `prod_feature_id` (`prod_feature_id`),
  KEY `prod_cat_id` (`prod_cat_id`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `price_component`
-- 

REPLACE INTO `price_component` VALUES (1, '2000-01-01', '2000-12-31', 2.00, NULL, 'B', '1', NULL, NULL, 'PAP192', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (2, '2001-01-01', '2001-12-31', 2.50, NULL, 'B', '1', NULL, NULL, 'PAP192', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (3, '2002-01-01', '2002-12-31', 2.99, NULL, 'B', '1', NULL, NULL, 'PAP192', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (4, '2003-01-01', '2003-12-31', 3.50, NULL, 'B', '1', NULL, NULL, 'PAP192', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (5, '2004-01-01', '9999-12-31', 3.99, NULL, 'B', '1', NULL, NULL, 'PAP192', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (6, '2000-01-01', '2000-12-31', 50.00, NULL, 'S', '1', NULL, NULL, NULL, 20, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (7, '2001-01-01', '2001-12-31', 45.00, NULL, 'S', '1', NULL, NULL, NULL, 20, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (8, '2002-01-01', '9999-12-31', 40.00, NULL, 'S', '1', NULL, NULL, NULL, 20, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (9, '2000-01-01', '2000-12-31', 150.00, NULL, 'S', '1', NULL, NULL, NULL, 21, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (10, '2001-01-01', '2001-12-31', 140.00, NULL, 'S', '1', NULL, NULL, NULL, 21, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (11, '2002-01-01', '9999-12-31', 130.00, NULL, 'S', '1', NULL, NULL, NULL, 21, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (12, '2002-01-01', '2003-12-31', 5.99, NULL, 'B', '1', NULL, NULL, 'PEN202', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (13, '2004-01-01', '9999-12-31', 6.99, NULL, 'B', '1', NULL, NULL, 'PEN202', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (14, '2002-01-01', '9999-12-31', 0.50, NULL, 'S', '1', NULL, NULL, 'PAP192', 7, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (15, '2002-01-01', '2002-12-31', 1000.00, NULL, 'B', '1', NULL, NULL, 'PC101', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (16, '2003-01-01', '9999-12-31', 1100.00, NULL, 'B', '1', NULL, NULL, 'PC101', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (17, '2002-01-01', '9999-12-31', 500.00, NULL, 'B', 'R', 'DAY', NULL, NULL, NULL, 'CONSULT', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (18, '2004-01-01', '9999-12-31', 400.00, NULL, 'D', 'R', 'DAY', NULL, NULL, 19, 'CONSULT', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (19, '2000-01-01', '2000-12-31', 90.00, NULL, 'B', '1', NULL, NULL, NULL, NULL, 'PC1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (20, '2001-01-01', '2001-12-31', 91.00, NULL, 'B', '1', NULL, NULL, NULL, NULL, 'PC1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (21, '2002-01-01', '2002-12-31', 92.00, NULL, 'B', '1', NULL, NULL, NULL, NULL, 'PC1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (22, '2003-01-01', '2003-12-31', 94.00, NULL, 'B', '1', NULL, NULL, NULL, NULL, 'PC1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `price_component` VALUES (23, '2004-01-01', '9999-12-31', 95.00, NULL, 'B', '1', NULL, NULL, NULL, NULL, 'PC1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `prod_cat_class`
-- 

CREATE TABLE IF NOT EXISTS `prod_cat_class` (
  `product_id` varchar(16) NOT NULL default '',
  `prod_cat_id` varchar(16) NOT NULL default '',
  `seq_no` smallint(5) unsigned NOT NULL default '0',
  `primary_flag` char(1) default NULL,
  `comment` varchar(255) default NULL,
  `start_date` date NOT NULL default '0000-00-00',
  `end_date` date default NULL,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`product_id`,`prod_cat_id`,`seq_no`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `prod_cat_class`
-- 

REPLACE INTO `prod_cat_class` VALUES ('PAP192', 'PAPER', 1, 'N', NULL, '2004-02-21', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_class` VALUES ('PC100', 'PC1', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_class` VALUES ('PEN202', 'PEN', 1, 'N', NULL, '2004-02-21', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_class` VALUES ('STUFF', 'STUFF', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_class` VALUES ('DSK401', 'COMPUTER', 1, 'Y', NULL, '2004-02-21', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_class` VALUES ('CNS109', 'CONSULT', 1, 'Y', NULL, '2004-02-21', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_class` VALUES ('FRMCHFA1500', 'OFFICE', 1, 'Y', NULL, '2004-02-21', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_class` VALUES ('STUFF1', 'STUFF1', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_class` VALUES ('PC101', 'PC1', 1, 'Y', NULL, '2004-03-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_class` VALUES ('STUFF2', 'STUFF2', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_class` VALUES ('STUFF1A', 'STUFF1A', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_class` VALUES ('STUFF1B', 'STUFF1B', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_class` VALUES ('STUFF2A', 'STUFF2A', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_class` VALUES ('STUFF2B', 'STUFF2B', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `prod_cat_rollup`
-- 

CREATE TABLE IF NOT EXISTS `prod_cat_rollup` (
  `prod_cat_id_snr` varchar(16) NOT NULL default '',
  `prod_cat_id_jnr` varchar(16) NOT NULL default '',
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`prod_cat_id_snr`,`prod_cat_id_jnr`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `prod_cat_rollup`
-- 

REPLACE INTO `prod_cat_rollup` VALUES ('OFFICE', 'PEN', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_rollup` VALUES ('OFFICE', 'PAPER', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_rollup` VALUES ('COMPUTER', 'PC1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_rollup` VALUES ('COMPUTER', 'PC2', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_rollup` VALUES ('STUFF', 'STUFF1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_rollup` VALUES ('STUFF', 'STUFF2', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_rollup` VALUES ('STUFF1', 'STUFF1A', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_rollup` VALUES ('STUFF1', 'STUFF1B', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_rollup` VALUES ('STUFF2', 'STUFF2A', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_cat_rollup` VALUES ('STUFF2', 'STUFF2B', '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `prod_feature_applicability`
-- 

CREATE TABLE IF NOT EXISTS `prod_feature_applicability` (
  `product_id` varchar(16) NOT NULL default '',
  `prod_feature_id` mediumint(9) unsigned NOT NULL default '0',
  `seq_no` smallint(6) unsigned NOT NULL default '1',
  `feature_type` char(1) default NULL,
  `start_date` date NOT NULL default '0000-00-00',
  `end_date` date default NULL,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`product_id`,`prod_feature_id`,`seq_no`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `prod_feature_applicability`
-- 

REPLACE INTO `prod_feature_applicability` VALUES ('PC101', 20, 1, 'S', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('PC101', 21, 1, 'O', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('PC100', 20, 1, 'S', '2000-01-01', '2001-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('PC100', 21, 1, 'S', '2002-01-01', '2003-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('PC100', 22, 1, 'S', '2004-01-01', '2004-03-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('PC100', 22, 2, 'S', '2004-04-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('PAP192', 5, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('PAP192', 4, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('PAP192', 14, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('PAP192', 6, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('PAP192', 7, 1, 'O', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('PAP192', 2, 1, 'X', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('PAP192', 10, 1, 'X', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('PAP192', 11, 1, 'X', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('PAP192', 12, 1, 'X', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('PEN202', 8, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('PEN202', 13, 1, 'S', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('PEN202', 2, 1, 'O', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('PEN202', 15, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('DSK401', 1, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('DSK401', 18, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('DSK401', 16, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('CNS109', 9, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `prod_feature_applicability` VALUES ('CNS109', 17, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `prod_feature_interaction`
-- 

CREATE TABLE IF NOT EXISTS `prod_feature_interaction` (
  `product_id` varchar(16) NOT NULL default '',
  `prod_feature_id_snr` mediumint(9) unsigned NOT NULL default '0',
  `prod_feature_id_jnr` mediumint(9) unsigned NOT NULL default '0',
  `feature_interaction` char(1) default NULL,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`product_id`,`prod_feature_id_snr`,`prod_feature_id_jnr`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `prod_feature_interaction`
-- 

REPLACE INTO `prod_feature_interaction` VALUES ('PC101', 20, 21, 'I', '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `product`
-- 

CREATE TABLE IF NOT EXISTS `product` (
  `product_id` varchar(16) NOT NULL default '',
  `product_name` varchar(255) default NULL,
  `date_intro` date default NULL,
  `end_date_sales` date default NULL,
  `end_date_support` date default NULL,
  `comment` varchar(255) default NULL,
  `product_subtype` char(1) default NULL,
  `uom_id` varchar(16) default NULL,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`product_id`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `product`
-- 

REPLACE INTO `product` VALUES ('PAP192', 'Johnson fine grade 8.5 by 11 inch bond paper', NULL, NULL, NULL, NULL, 'G', 'REAM', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product` VALUES ('PEN202', 'Goldstein Elite pen', NULL, NULL, NULL, NULL, 'G', 'EACH', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product` VALUES ('DSK401', 'Jerry''s box of 3.5-inch diskettes', NULL, NULL, NULL, NULL, 'G', 'BOX', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product` VALUES ('FRMCHFA1500', 'Preprinted forms for insurance claims', NULL, NULL, NULL, NULL, 'G', 'EACH', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product` VALUES ('CNS109', 'Office supply inventory management consulting service', NULL, NULL, NULL, NULL, 'S', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product` VALUES ('PC101', 'Laptop Computer', NULL, NULL, NULL, NULL, 'G', 'EACH', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product` VALUES ('PC100', 'Desktop Computer', '2004-03-01', NULL, NULL, NULL, 'G', 'EACH', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product` VALUES ('STUFF', 'Stuff', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product` VALUES ('STUFF1', 'Stuff 1', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product` VALUES ('STUFF2', 'Stuff 2', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product` VALUES ('STUFF1A', 'Stuff 1a', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product` VALUES ('STUFF1B', 'Stuff 1b', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product` VALUES ('STUFF2A', 'Stuff 2a', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product` VALUES ('STUFF2B', 'Stuff 2b', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `product_category`
-- 

CREATE TABLE IF NOT EXISTS `product_category` (
  `prod_cat_id` varchar(16) NOT NULL default '',
  `prod_cat_desc` varchar(255) default NULL,
  `product_usage` varchar(16) default NULL,
  `product_industry` varchar(16) default NULL,
  `product_materials` varchar(16) default NULL,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`prod_cat_id`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `product_category`
-- 

REPLACE INTO `product_category` VALUES ('OFFICE', 'Office Supplies', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_category` VALUES ('PEN', 'Pens', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_category` VALUES ('PAPER', 'Paper', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_category` VALUES ('COMPUTER', 'Computer Supplies', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_category` VALUES ('CONSULT', 'Consultancy Services', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_category` VALUES ('FORMS', 'Forms', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_category` VALUES ('INS', 'Insurance', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_category` VALUES ('PC1', 'Computer Hardware', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_category` VALUES ('PC2', 'Computer Software', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_category` VALUES ('STUFF', 'Stuff', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_category` VALUES ('STUFF1', 'Stuff 1', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_category` VALUES ('STUFF2', 'Stuff 2', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_category` VALUES ('STUFF1A', 'Stuff 1a', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_category` VALUES ('STUFF1B', 'Stuff 1b', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_category` VALUES ('STUFF2A', 'Stuff 2a', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_category` VALUES ('STUFF2B', 'Stuff 2b', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `product_feature`
-- 

CREATE TABLE IF NOT EXISTS `product_feature` (
  `prod_feature_id` mediumint(9) unsigned NOT NULL default '0',
  `prod_feature_desc` varchar(255) default NULL,
  `prod_feature_cat_id` varchar(16) default NULL,
  `uom_id` varchar(16) default NULL,
  `measurement` float unsigned default NULL,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`prod_feature_id`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `product_feature`
-- 

REPLACE INTO `product_feature` VALUES (1, 'Red', 'COLOUR', NULL, 1.23458, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (2, 'Blue', 'COLOUR', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (3, 'Green', 'COLOUR', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (4, '8.5in Wide', 'DIM', 'INCH', 8.5, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (5, '11in Long', 'DIM', 'INCH', 11, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (6, 'Fine Grade', 'QUAL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (7, 'Extra Glossy Finish', 'QUAL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (8, 'Fine Point', 'QUAL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (9, 'Expert', 'QUAL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (10, 'Grey', 'COLOUR', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (11, 'Cream', 'COLOUR', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (12, 'White', 'COLOUR', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (13, 'Black', 'COLOUR', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (14, 'Johnson', 'BRAND', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (15, 'Goldstein', 'BRAND', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (16, 'Jerry''s', 'BRAND', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (17, 'ABC Corporation', 'BRAND', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (18, '3.5in Diameter', 'DIM', 'INCH', 3.5, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (19, 'Junior', 'QUAL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (20, 'CD-ROM drive', 'HARD', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (21, 'DVD-ROM drive', 'HARD', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (22, 'DVD-RW drive', 'HARD', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (23, 'Small', 'SIZE', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (24, 'Medium', 'SIZE', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (25, 'Large', 'SIZE', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (26, 'Extra Large', 'SIZE', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (27, 'Post & Package', 'BILL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (28, 'Delivery - Standard', 'BILL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature` VALUES (29, 'Delivery - Express', 'BILL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `product_feature_category`
-- 

CREATE TABLE IF NOT EXISTS `product_feature_category` (
  `prod_feature_cat_id` varchar(16) NOT NULL default '',
  `prod_feature_cat_desc` varchar(255) default NULL,
  `measurement_reqd` char(1) default NULL,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`prod_feature_cat_id`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `product_feature_category`
-- 

REPLACE INTO `product_feature_category` VALUES ('BILL', 'Billing Feature', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature_category` VALUES ('BRAND', 'Brand', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature_category` VALUES ('COLOUR', 'Colour', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature_category` VALUES ('DIM', 'Dimension', 'Y', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature_category` VALUES ('HARD', 'Hardware Feature', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature_category` VALUES ('QUAL', 'Quality', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature_category` VALUES ('SIZE', 'Size', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature_category` VALUES ('SOFT', 'Software Feature', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `product_feature_category` VALUES ('STYLE', 'Style', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `unit_of_measure`
-- 

CREATE TABLE IF NOT EXISTS `unit_of_measure` (
  `uom_id` varchar(16) NOT NULL default '',
  `uom_cat_id` varchar(4) default NULL,
  `uom_abbrev` varchar(8) default NULL,
  `uom_desc` varchar(255) default NULL,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`uom_id`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `unit_of_measure`
-- 

REPLACE INTO `unit_of_measure` VALUES ('AMP', 'ELEC', 'amp', 'Ampere', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('BOX', 'VOL', 'BOX', 'Box', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('CENTILITRE', 'VOL', 'cl', 'Centilitre', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('CENTIMETER', 'LEN', 'cm', 'Centimeter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('CU_CC', 'VOL', 'cc', 'Cubic Centimeter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('CU_FT', 'VOL', 'Cu. Ft.', 'Cubic Foot', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('CU_INCH', 'VOL', 'Cu. In.', 'Cubic Inch', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('CU_M', 'VOL', 'Cu. M', 'Cubic Meter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('CU_YD', 'VOL', 'Cu. Yd.', 'Cubic Yard', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('DAY', 'TIME', 'day', 'per Day', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('DECIMETER', 'LEN', 'dm', 'Decimeter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('EACH', 'MISC', 'EA', 'Each', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('FLUIDOUNCE', 'VOL', 'Floz', 'Fluid Ounce', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('FOOT', 'LEN', 'Ft', 'Foot', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('GALLON', 'VOL', 'Gal', 'Gallon (Imperial)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('GALLON(US)', 'VOL', 'Gal', 'Gallon (US)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('GRAM', 'WEIG', 'gm', 'Gram', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('HOUR', 'TIME', 'Hour', 'per Hour', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('HUNDREDWEIGHT', 'WEIG', 'cwt', 'Hundredweight', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('HUNDREDWT(US)', 'WEIG', 'cwt', 'Hundredweight (US)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('INCH', 'LEN', 'in', 'Inch', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('KILOGRAM', 'WEIG', 'kg', 'Kilogram', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('KILOWATT', 'ELEC', 'Kw', 'Kilowatt', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('LITRE', 'VOL', 'lt', 'Litre', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('METER', 'LEN', 'm', 'Meter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('MILLIGRAM', 'WEIG', 'mg', 'Milligram', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('MILLIMETER', 'LEN', 'mm', 'Millimeter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('MONTH', 'TIME', 'month', 'per Month', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('OHM', 'ELEC', 'ohm', 'Ohm', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('OUNCE', 'WEIG', 'oz', 'Ounce Avoirdupois', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('PINT', 'VOL', 'pt', 'Pint (Imperial)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('PINT(US)', 'VOL', 'pt', 'Pint (US)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('POUND', 'WEIG', 'lb', 'Pound Avoirdupois', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('QUART', 'VOL', 'Qt', 'Quart (Imperial)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('QUART(US)', 'VOL', 'Qt', 'Quart (US)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('REAM', 'VOL', 'Ream', 'Ream', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('SHEET', 'VOL', 'Sheet', 'Sheet', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('SQ_CM', 'AREA', 'Sq. Cm.', 'Square Centimeter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('SQ_FOOT', 'AREA', 'Sq. Ft.', 'Square Foot', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('SQ_INCH', 'AREA', 'Sq. In.', 'Square Inch', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('SQ_M', 'AREA', 'Sq. M.', 'Square Meter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('SQ_YARD', 'AREA', 'Sq. Yd.', 'Square Yard', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('STONE', 'WEIG', 'st', 'Stone', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('TON', 'WEIG', 'ton', 'Short Ton (UK)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('TON(L)', 'WEIG', 'ton', 'Long Ton (US)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('TONNE', 'WEIG', 'tonne', 'Metric Tonne', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('VOLT', 'ELEC', 'V', 'Volt', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('WATT', 'ELEC', 'watt', 'Watt', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `unit_of_measure` VALUES ('YARD', 'LEN', 'yd', 'Yard', '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `uom_category`
-- 

CREATE TABLE IF NOT EXISTS `uom_category` (
  `uom_cat_id` varchar(4) NOT NULL default '',
  `uom_cat_desc` varchar(40) default NULL,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`uom_cat_id`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `uom_category`
-- 

REPLACE INTO `uom_category` VALUES ('VOL', 'Volume/Capacity', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_category` VALUES ('WEIG', 'Weight', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_category` VALUES ('LEN', 'Length', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_category` VALUES ('AREA', 'Area', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_category` VALUES ('TIME', 'Time', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_category` VALUES ('ELEC', 'Electrical', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_category` VALUES ('MISC', 'Miscellaneous', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_category` VALUES ('SPEE', 'Speed', '2004-03-01 12:00:00', 'AJM', NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `uom_conversion`
-- 

CREATE TABLE IF NOT EXISTS `uom_conversion` (
  `uom_id_from` varchar(16) NOT NULL default '',
  `uom_id_to` varchar(16) NOT NULL default '',
  `conversion_factor` double unsigned NOT NULL default '0',
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) default NULL,
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`uom_id_from`,`uom_id_to`)
) TYPE=MyISAM;

-- 
-- Dumping data for table `uom_conversion`
-- 

REPLACE INTO `uom_conversion` VALUES ('CENTIMETER', 'METER', 100, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('MILLIMETER', 'CENTIMETER', 10, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('MILLIMETER', 'METER', 1000, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('MILLIMETER', 'DECIMETER', 100, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('CENTIMETER', 'DECIMETER', 10, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('DECIMETER', 'METER', 10, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('DECIMETER', 'CENTIMETER', 0.100000001490116, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('DECIMETER', 'MILLIMETER', 0.00999999977648258, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('METER', 'DECIMETER', 0.100000001490116, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('METER', 'CENTIMETER', 0.00999999977648258, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('METER', 'MILLIMETER', 0.00100000004749745, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('CENTIMETER', 'MILLIMETER', 0.100000001490116, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('FOOT', 'INCH', 12, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('YARD', 'FOOT', 3, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('YARD', 'INCH', 36, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('FOOT', 'YARD', 0.33333333333333, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('INCH', 'FOOT', 0.083333333333333, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('INCH', 'YARD', 0.027777777777777, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('PINT', 'FLUIDOUNCE', 20, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('PINT(US)', 'FLUIDOUNCE', 16, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('GALLON', 'QUART', 4, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('GALLON', 'PINT', 8, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('GALLON', 'FLUIDOUNCE', 160, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('GALLON(US)', 'QUART(US)', 4, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('GALLON(US)', 'PINT(US)', 8, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('GALLON(US)', 'FLUIDOUNCE', 128, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('KILOGRAM', 'GRAM', 1000, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('GRAM', 'MILLIGRAM', 1000, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('TONNE', 'KILOGRAM', 1000, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('TONNE', 'MILLIGRAM', 1000000, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('TON', 'HUNDREDWEIGHT', 20, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('TON', 'POUND', 2240, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('POUND', 'OUNCE', 16, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('STONE', 'POUND', 14, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('TON(L)', 'POUND', 2000, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('HUNDREDWEIGHT', 'STONE', 8, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('HUNDREDWEIGHT', 'POUND', 112, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('HUNDREDWT(US)', 'POUND', 100, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('HUNDREDWT(US)', 'STONE', 7.1428571428571, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `uom_conversion` VALUES ('REAM', 'SHEET', 500, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
