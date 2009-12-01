-- phpMyAdmin SQL Dump
-- version 2.6.3-pl1
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Aug 31, 2005 at 08:39 PM
-- Server version: 4.0.25
-- PHP Version: 4.3.11
-- 
-- Database: `xample`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `test_autoincrement`
-- 

CREATE TABLE `test_autoincrement` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `field1` varchar(40) default NULL,
  `field2` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) TYPE=MyISAM;
