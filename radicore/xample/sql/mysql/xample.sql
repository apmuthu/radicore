-- phpMyAdmin SQL Dump
-- version 2.7.0
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Feb 05, 2006 at 03:44 PM
-- Server version: 4.0.25
-- PHP Version: 4.4.2
-- 
-- Database: `xample`
-- 

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

-- 
-- Dumping data for table `x_option`
-- 

REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ALBATROS', 'Albatross', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ANACONDA', 'Anaconda', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BARACUDA', 'Baracuda', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BUMBLE', 'Bumble Bee', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('CHINCHIL', 'Chinchilla', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('CROCODIL', 'Crocodile', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DINOSAUR', 'Dinosaur', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DUCKBILL', 'Duck-Billed Platypus', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ELEPHANT', 'Eléphânt', '2000-01-01 00:00:00', 'AJM', '2006-01-09 18:17:11', 'AJM');
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('EMU', 'Emu', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FERRET', 'Ferret', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FOX', 'Fox', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('GERBIL', 'Gerbil', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('GORILLA', 'Gorilla', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('HADDOCK', 'Haddock', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('HAMSTER', 'Hamster', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('IBEX', 'Ibex', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('IBIS', 'Ibis', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('JABBER', 'Jabberwocky', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('JACKAL', 'Jackal', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KANGEROO', 'Kangeroo', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KESTREL', 'Kestrel', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('LEMMING', 'Lemming', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('LION', 'Lion', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MACAW', 'Macaw', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MOUSE', 'Mouse', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('NASTURTI', 'Nasturtium', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('NATTERJA', 'Natterjack', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('OAK', 'Oak', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('OCELOT', 'Ocelot', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PARROT', 'Parrot', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PARSLEY', 'Parsley', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('QUAIL', 'Quail', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('QUINCE', 'Quince', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('RABBIT', 'Rabbit', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('RACOON', 'Racoon', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALAMAND', 'Salamander', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SHEEP', 'Sheep', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('TARANTUL', 'Tarantula', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('TURKEY', 'Turkey', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('UKELELE', 'Ukelele', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('URCHIN', 'Urchin', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('VIXEN', 'Vixen', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('VOLE', 'Vole', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WATERBUF', 'Waterbuffalo', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WILDEBEE', 'Wildebeest', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('XENOPHIL', 'Xenophile', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('XENOPHOB', 'Xenophobe', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('YAK', 'Yak', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('YETI', 'Yeti', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ZEBRA', 'Zebra', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ZOMBIE', 'Zombie', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_option` (`option_id`, `option_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('CôTE', 'Côte d''Ivoire', '2005-02-03 18:40:45', 'AJM', NULL, NULL);

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

-- 
-- Dumping data for table `x_pers_opt_xref`
-- 

REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'BARACUDA', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'CHINCHIL', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'DINOSAUR', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ELEPHANT', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'FERRET', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'GERBIL', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'HADDOCK', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'IBEX', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'JABBER', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'KANGEROO', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'LEMMING', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'MACAW', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'NASTURTI', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'OAK', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'PARROT', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'QUAIL', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'RABBIT', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'SALAMAND', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'TARANTUL', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'UKELELE', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'VIXEN', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'WATERBUF', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'XENOPHIL', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'YAK', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ZEBRA', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BB', 'ANACONDA', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BB', 'BUMBLE', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BB', 'DINOSAUR', '2006-01-09 18:19:53', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BB', 'ELEPHANT', '2006-01-09 18:19:53', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BB', 'EMU', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BG', 'BUMBLE', '2006-01-09 18:22:01', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BG', 'CHINCHIL', '2006-01-09 18:22:01', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BG', 'DINOSAUR', '2006-01-09 18:22:01', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BG', 'ELEPHANT', '2006-01-09 18:22:01', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BG', 'EMU', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('CC', 'ALBATROS', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('CC', 'BARACUDA', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('CC', 'CROCODIL', '2006-01-09 18:20:58', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('CC', 'DUCKBILL', '2006-01-09 18:20:58', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WC', 'CHINCHIL', '2006-01-09 18:21:08', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('CJ', 'ALBATROS', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DD', 'ALBATROS', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DD', 'BARACUDA', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DD', 'CROCODIL', '2006-01-09 18:21:21', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DD', 'DUCKBILL', '2006-01-09 18:21:21', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('EE', 'CHINCHIL', '2006-01-09 18:21:29', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('EE', 'ANACONDA', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('EE', 'BUMBLE', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('EE', 'DINOSAUR', '2006-01-09 18:21:29', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('EE', 'ELEPHANT', '2006-01-09 18:21:29', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('EE', 'EMU', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', 'ALBATROS', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', 'BARACUDA', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', 'CROCODIL', '2006-01-09 18:19:43', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', 'DUCKBILL', '2006-01-09 18:19:43', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BB', 'CHINCHIL', '2006-01-09 18:19:53', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', 'ZOMBIE', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'BUMBLE', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'CHINCHIL', '2006-01-01 23:43:14', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'ELEPHANT', '2006-01-02 00:13:06', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'EMU', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'FOX', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'GORILLA', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'HAMSTER', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'IBIS', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'JACKAL', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'KESTREL', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'LION', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'MOUSE', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'NATTERJA', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'OCELOT', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'PARSLEY', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'RACOON', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'TURKEY', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'URCHIN', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'VOLE', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'WILDEBEE', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'XENOPHOB', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'YETI', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'ZOMBIE', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('LH', 'ALBATROS', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('LH', 'ZOMBIE', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('LL', 'ALBATROS', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PV', 'ALBATROS', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MM', 'ALBATROS', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'BARACUDA', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'CROCODIL', '2006-01-01 23:31:34', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'DUCKBILL', '2006-01-01 23:31:34', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'DINOSAUR', '2006-01-01 23:43:17', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'FERRET', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'GERBIL', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'HADDOCK', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'IBEX', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'JABBER', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'KANGEROO', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'LEMMING', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'MACAW', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'NASTURTI', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'OAK', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'PARROT', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'QUAIL', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'RABBIT', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'SALAMAND', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'TARANTUL', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'UKELELE', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'VIXEN', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'WATERBUF', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'XENOPHIL', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'YAK', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('Z', 'ALBATROS', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PQ', 'ALBATROS', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('RO', 'ALBATROS', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('RR', 'ALBATROS', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('RR', 'ZOMBIE', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WW', 'ALBATROS', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SF', 'ALBATROS', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SF', 'BARACUDA', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SF', 'CROCODIL', '2006-01-09 18:21:39', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SF', 'DUCKBILL', '2006-01-09 18:21:39', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SF', 'ZOMBIE', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SS', 'ZOMBIE', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WC', 'ANACONDA', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WC', 'BUMBLE', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WC', 'DINOSAUR', '2006-01-09 18:21:08', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WC', 'ELEPHANT', '2006-01-09 18:21:08', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WC', 'EMU', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('TT', 'ALBATROS', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'ZEBRA', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('YY', 'ALBATROS', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'ALBATROS', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('CJ', 'ANACONDA', '2004-08-16 14:56:55', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ALBATROS', '2004-08-16 14:59:47', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ANACONDA', '2004-08-16 14:59:47', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BG', 'ANACONDA', '2006-01-09 18:22:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DD', 'CôTE', '2006-01-09 18:21:20', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SF', 'CôTE', '2006-01-09 18:21:39', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', 'CôTE', '2006-01-09 18:19:42', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('CC', 'CôTE', '2006-01-09 18:20:58', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'CôTE', '2006-01-01 23:31:33', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_opt_xref` (`person_id`, `option_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'ANACONDA', '2000-01-01 00:00:00', 'AJM', NULL, NULL);

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

-- 
-- Dumping data for table `x_pers_type`
-- 

REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ACTOR', 'Actor/Artiste', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BORING', 'Boring Person', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('CARTOO', 'Cartoon Character', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DOLLY', 'Dolly Bird', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('EXEC', 'Executive', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FUNNY', 'Funny Person/Comedian', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('GENFAC', 'General Factotum', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('IGTWIT', 'Ignorant Twit', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('JAMMY', 'Jammy Beggar', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KLEPTO', 'Kleptomaniac', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('LAZY', 'Lazy Bones', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MAD', 'Mad as a Hatter', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('NINNY', 'Nincompoop', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ONE', 'One Sandwich Short of a Picnic', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('LAME', 'Lame Brain', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('HISTOR', 'Historical Figure', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('QP', 'Of Questionable Parentage', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ANON', 'Anne Oni Mouse', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FILM', 'Film Star', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('LAYABO', 'Layabout', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MOANER', 'Moaning Minnie', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PP', 'Party Pooper', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FAMOUS', 'Famous Person', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('OBNOXI', 'Obnoxious Oik', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_pers_type` (`pers_type_id`, `pers_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BRICK', 'One brick short of a full load', '2005-10-29 15:59:05', 'AJM', NULL, NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `x_person`
-- 

CREATE TABLE IF NOT EXISTS `x_person` (
  `person_id` varchar(8) NOT NULL default '',
  `pers_type_id` varchar(6) default NULL,
  `node_id` smallint(4) unsigned default '0',
  `nat_ins_no` varchar(10) NOT NULL default '',
  `first_name` varchar(20) NOT NULL default '',
  `last_name` varchar(30) NOT NULL default '',
  `initials` varchar(6) default NULL,
  `star_sign` char(3) NOT NULL default '',
  `email_addr` varchar(50) default NULL,
  `value1` smallint(6) unsigned default NULL,
  `value2` decimal(10,2) unsigned default NULL,
  `last_addr_no` smallint(4) unsigned default '0',
  `start_date` date NOT NULL default '2000-01-01',
  `end_date` date default '9999-12-31',
  `picture` varchar(40) default NULL,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`person_id`),
  UNIQUE KEY `nat_ins_no` (`nat_ins_no`),
  KEY `pers_type_id` (`pers_type_id`)
) TYPE=InnoDB;

-- 
-- Dumping data for table `x_person`
-- 

REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'GENFAC', 10, 'XX123456Y', 'Tony', 'Marston', '', 'CAP', 'tony@marston-home.demon.co.uk', 34, 12.34, 3, '1951-01-02', '2005-01-02', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BB', 'CARTOO', 8, 'BB', 'Billy', 'Bunter', NULL, 'CAN', 'bb@fatman.com', NULL, NULL, 2, '2002-12-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BG', 'EXEC', 21, 'BG', 'Bill', 'Gates', 'wg', 'CAN', NULL, NULL, NULL, 1, '1990-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('CC', 'CARTOO', 9, 'CC', 'Charlie', 'Chan', NULL, 'CAN', NULL, NULL, NULL, 1, '1953-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('CJ', 'FUNNY', 7, 'CJ', 'Casper', 'Jarret', 'cj', 'GEM', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DD', 'CARTOO', 16, 'DD', 'Donald', 'Duck', NULL, 'SAG', NULL, NULL, NULL, 1, '1998-02-02', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('EE', 'FUNNY', 17, 'EE', 'Edna', 'Everage', 'ee', 'ARI', NULL, NULL, NULL, 1, '1990-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', 'ANON', 7, 'FB', 'Fred', 'Bloggs', NULL, 'VIR', 'fred.bloggs@nowhere.com', NULL, NULL, 3, '2002-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('JI', 'FILM', 6, 'JI', 'Jeremy', 'Irons', 'ji', 'SAG', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 'DOLLY', 6, 'KB', 'Kim', 'Basinger', 'KB', 'SAG', 'kim.bassinger@hollywood.net', NULL, NULL, 1, '1990-01-01', '9999-12-31', 'pictures/female2.jpg', '2000-01-01 00:00:00', 'AJM', '2005-10-29 23:12:47', 'AJM');
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KK', 'FILM', 8, 'KK', 'Kevin', 'Kline', 'kk', 'LEO', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('LH', 'DOLLY', 5, 'LH', 'Liz', 'Hurley', 'lh', 'VIR', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', 'pictures/female2.jpg', '2000-01-01 00:00:00', 'AJM', '2005-03-10 21:56:30', 'AJM');
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('LL', 'FAMOUS', 9, 'LL', 'Lord', 'Lucan', 'll', 'GEM', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('LU', 'ACTOR', 10, 'LU', 'Liv', 'Ullman', 'lu', 'ARI', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MM', 'CARTOO', 16, 'MM', 'Mickey', 'Mouse', NULL, 'LEO', NULL, NULL, NULL, 0, '2001-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MP', 'DOLLY', 21, 'MP', 'Michelle', 'Pfeiffer', 'mp', 'CAP', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', 'pictures/female2.jpg', '2000-01-01 00:00:00', 'AJM', '2005-03-10 21:56:37', 'AJM');
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MR', 'FILM', 6, 'MR', 'Mickey', 'Rooney', NULL, 'SCO', NULL, NULL, NULL, 1, '1940-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('NN', 'FILM', 17, 'NN', 'Nick', 'Nolte', 'nn', 'TAU', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 'DOLLY', 5, 'PA', 'Pamela', 'Anderson', 'PA', 'VIR', 'pam@hollywood.com', NULL, NULL, 2, '1980-07-01', '9999-12-31', 'pictures/female2.jpg', '2000-01-01 00:00:00', 'AJM', '2005-10-29 23:12:36', 'AJM');
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PQ', 'ACTOR', 5, 'PQ', 'Pauline', 'Quirke', 'pq', 'ARI', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PV', 'HISTOR', 16, 'PV', 'Pancho', 'Villa', 'pv', 'LIB', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('RO', 'FAMOUS', 18, 'RO', 'Roy', 'Orbison', 'ro', 'SAG', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('RR', 'CARTOO', 7, 'RR', 'Road', 'Runner', NULL, 'VIR', 'roadrunner@cartoonland.com', NULL, NULL, 0, '1950-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('RW', 'DOLLY', 17, 'RW', 'Raquel', 'Welch', 'rw', 'VIR', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', 'pictures/female2.jpg', '2000-01-01 00:00:00', 'AJM', '2005-03-10 21:56:50', 'AJM');
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SF', 'DOLLY', 18, 'SF', 'Sam', 'Fox', 'sf', 'VIR', NULL, NULL, NULL, 1, '1990-01-01', '9999-12-31', 'pictures/female2.jpg', '2000-01-01 00:00:00', 'AJM', '2005-03-10 21:56:23', 'AJM');
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SS', 'DOLLY', 8, 'SS', 'Sharon', 'Stone', 'ss', 'VIR', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', 'pictures/female2.jpg', '2000-01-01 00:00:00', 'AJM', '2005-03-10 21:56:44', 'AJM');
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('TT', 'FUNNY', 9, 'TT', 'Terry', 'Thomas', 'tt', 'AQU', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WC', 'CARTOO', 10, 'WC', 'Wiley', 'Coyote', NULL, 'SAG', 'wileycoyote@cartoonland.com', NULL, NULL, 1, '1950-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WW', 'BORING', 18, 'WW', 'Willy', 'Wonka', '', 'GEM', 'willy@chocolatefactory.com', NULL, NULL, 1, '1999-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('XX', 'ANON', 21, 'XX', 'Xavier', 'Xtra', 'xx', 'LIB', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('YY', 'HISTOR', 5, 'YY', 'Yin', 'Yang', 'yy', 'SCO', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person` (`person_id`, `pers_type_id`, `node_id`, `nat_ins_no`, `first_name`, `last_name`, `initials`, `star_sign`, `email_addr`, `value1`, `value2`, `last_addr_no`, `start_date`, `end_date`, `picture`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('Z', 'CARTOO', 6, 'Z', 'Mr', 'Zebedee', 'z', 'CAN', NULL, NULL, NULL, 1, '1990-01-01', '9999-12-31', NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);

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

-- 
-- Dumping data for table `x_person_addr`
-- 

REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 1, '020 8642 3524', NULL, '32 Strathearn Road', NULL, NULL, 'SUTTON', 'Surrey', 'SM1 2RS', '1951-01-02', '1978-06-30', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 2, NULL, NULL, 'new 1', 'new 2', NULL, 'NEWTOWN', 'newshire', 'NN1 1NN', '1978-07-01', '2003-12-31', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 3, NULL, NULL, 'new3', NULL, NULL, 'NEW3', NULL, 'NN3 3NN', '2004-01-01', '2005-01-02', '2004-08-29 20:16:39', 'AJM', NULL, NULL);
REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BB', 1, NULL, NULL, 'bb1', NULL, NULL, 'BB1', NULL, 'BB1 2BB', '2002-12-01', '2003-12-31', '2004-04-16 16:06:20', 'AJM', '2004-05-27 15:11:58', 'AJM');
REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BB', 2, NULL, NULL, 'bb2', NULL, NULL, 'BB2', NULL, 'BB2 2BB', '2004-01-01', '9999-12-31', '2004-05-27 15:11:58', 'AJM', NULL, NULL);
REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BG', 1, NULL, NULL, 'bg1', NULL, NULL, 'BG1', NULL, 'BG1 1BG', '1990-01-01', '9999-12-31', '2004-05-31 19:34:40', 'AJM', NULL, NULL);
REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('CC', 1, NULL, NULL, 'cc1', NULL, NULL, 'CC1', NULL, 'CC1 1CC', '1953-01-01', '9999-12-31', '2004-05-31 15:48:12', 'AJM', NULL, NULL);
REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DD', 1, NULL, NULL, 'dd1', NULL, NULL, 'DD1', NULL, 'DD1 1DD', '1998-02-02', '9999-12-31', '2004-05-31 16:11:06', 'AJM', NULL, NULL);
REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('EE', 1, NULL, NULL, 'ee1', NULL, NULL, 'EE1', NULL, 'EE1 1EE', '1990-01-01', '9999-12-31', '2004-05-31 16:19:02', 'AJM', NULL, NULL);
REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', 1, NULL, NULL, 'Battersea Dogs Home', NULL, NULL, 'BATTERSEA', 'London', 'SW9 9AZ', '2002-01-01', '2003-05-31', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', 2, NULL, NULL, 'Chelsea Pensioners', NULL, NULL, 'CHELSEA', 'London', 'SW5 5AZ', '2003-06-01', '2003-08-31', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', 3, NULL, NULL, 'Cell 27', 'Wormwood Scrubs', NULL, 'WANDSWORTH', 'London', 'NE1 1NE', '2003-09-01', '9999-12-31', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('KB', 1, NULL, NULL, 'kb1', NULL, NULL, 'KB1', NULL, 'KB1 1KB', '1990-01-01', '9999-12-31', '2004-04-16 15:59:54', 'AJM', NULL, NULL);
REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MR', 1, NULL, NULL, 'mr1', NULL, NULL, 'MR1', 'mr1', 'MR1 1MR', '1940-01-01', '9999-12-31', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 1, NULL, NULL, '2 Titty Terrace', NULL, NULL, 'JUGSVILLE', NULL, 'TT1 1TT', '1980-07-01', '1989-12-31', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PA', 2, NULL, NULL, 'pa2', 'pa2', 'pa2', 'PA2', 'pa2 again', 'PA2 2PA', '1990-01-01', '9999-12-31', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SF', 1, NULL, NULL, 'sf1', NULL, NULL, 'SF1', NULL, 'SF1 1SF', '1990-01-01', '9999-12-31', '2004-05-31 16:34:37', 'AJM', NULL, NULL);
REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WC', 1, NULL, NULL, 'test', 'test', NULL, 'TEST', NULL, 'SM1 2RS', '1999-09-09', '9999-12-31', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WW', 1, NULL, NULL, 'line 1', 'line 2', 'line 3', 'TOWN', 'county', 'WW1 1WW', '1999-01-01', '9999-12-31', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_person_addr` (`person_id`, `address_no`, `telephone_no`, `fax_no`, `addr_line_1`, `addr_line_2`, `addr_line_3`, `town`, `county`, `postcode`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('Z', 1, NULL, NULL, '26 Alphabet Street', NULL, NULL, 'ALPHABETVILLE', 'Dictionaryshire', 'AB1 1XY', '1990-01-01', '9999-12-31', '2000-01-01 00:00:00', 'AJM', NULL, NULL);

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

-- 
-- Dumping data for table `x_tree_level`
-- 

REPLACE INTO `x_tree_level` (`tree_type_id`, `tree_level_id`, `tree_level_seq`, `tree_level_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('TEST', 1, 1, 'Test level 1', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_level` (`tree_type_id`, `tree_level_id`, `tree_level_seq`, `tree_level_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('TEST', 2, 2, 'Test level 2', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_level` (`tree_type_id`, `tree_level_id`, `tree_level_seq`, `tree_level_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ORG', 1, 2, 'Company', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_level` (`tree_type_id`, `tree_level_id`, `tree_level_seq`, `tree_level_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ORG', 2, 3, 'Department', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_level` (`tree_type_id`, `tree_level_id`, `tree_level_seq`, `tree_level_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ORG', 3, 4, 'Section', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_level` (`tree_type_id`, `tree_level_id`, `tree_level_seq`, `tree_level_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROJ', 1, 1, 'Project ID', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_level` (`tree_type_id`, `tree_level_id`, `tree_level_seq`, `tree_level_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROJ', 2, 2, 'Project Phase', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_level` (`tree_type_id`, `tree_level_id`, `tree_level_seq`, `tree_level_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROJ', 3, 3, 'Project Component', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_level` (`tree_type_id`, `tree_level_id`, `tree_level_seq`, `tree_level_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ORG', 4, 1, 'Group', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_level` (`tree_type_id`, `tree_level_id`, `tree_level_seq`, `tree_level_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('TEST', 3, 3, 'Test level 3', '2000-01-01 00:00:00', 'AJM', NULL, NULL);

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

-- 
-- Dumping data for table `x_tree_node`
-- 

REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (1, 'ORG', 1, 'AJM Systems Limited', 25, '-01', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (2, 'ORG', 2, 'Department of Problems', 1, '-001', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (3, 'ORG', 2, 'Department of Solutions', 1, '-002', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (4, 'ORG', 2, 'Department of Excuses', 1, '-003', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (6, 'ORG', 3, 'Section 2 (node 6)', 4, '-0002', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (5, 'ORG', 3, 'Section 1 (node 5)', 4, '-0001', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (7, 'ORG', 3, 'Section 3 (node 7)', 4, '-0003', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (8, 'ORG', 3, 'Section 4 (node 8)', 2, '-0004', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (9, 'ORG', 3, 'Section 5 (node 9)', 2, '-0005', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (10, 'ORG', 3, 'Section 6 (node 10)', 2, '-0006', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (11, 'TEST', 2, 'Node 11, test level 2', 12, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (12, 'TEST', 1, 'Node 12, test level 1', NULL, '12-1', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (13, 'TEST', 2, 'Node 13, test level 2', 12, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (14, 'TEST', 2, 'Node 14, test level 2', 12, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (15, 'ORG', 2, 'Department of Silly Noises', 26, '-004', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (16, 'ORG', 3, 'Section 7 (node 16)', 3, '-0007', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (17, 'ORG', 3, 'Section 8 (node 17)', 3, '-0008', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (18, 'ORG', 3, 'Section 9 (node 18)', 3, '-0009', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (19, 'ORG', 2, 'Department of Silly Walks', 26, '-005', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (20, 'ORG', 2, 'Department of Failures', 26, '-006', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (21, 'ORG', 3, 'Section 10 (node 21)', 3, '-0010', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (22, 'ORG', 3, 'Section 11 (node 22)', 15, '-0011', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (23, 'ORG', 3, 'Section 12 (node 23)', 44, '-0012', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (24, 'ORG', 3, 'Section 13 (node 24)', 20, '-0013', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (25, 'ORG', 4, 'The AJM Group', NULL, 'A', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (26, 'ORG', 1, 'AJM Products Limited', 25, '-02', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (27, 'ORG', 3, 'Section 14 (node 27)', 19, '-0014', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (28, 'ORG', 3, 'Section 15 (node 28)', NULL, '-0015', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (29, 'PROJ', 1, 'Project A', NULL, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (30, 'PROJ', 1, 'Project B', NULL, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (31, 'PROJ', 1, 'Project C', NULL, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (32, 'PROJ', 2, 'Phase 1', 29, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (33, 'PROJ', 2, 'Phase 2', 29, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (34, 'PROJ', 2, 'Phase 3', 29, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (35, 'PROJ', 2, 'Phase 1', 30, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (36, 'PROJ', 2, 'Phase 2', 30, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (37, 'PROJ', 2, 'Phase 3', 30, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (38, 'PROJ', 2, 'Phase 1', 31, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (39, 'PROJ', 2, 'Phase 2', 31, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (40, 'PROJ', 2, 'Phase 3', 31, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (41, 'PROJ', 3, 'Component 41', 32, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (42, 'PROJ', 3, 'Component 42', 32, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (43, 'PROJ', 3, 'Component 43', 32, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (44, 'ORG', 2, 'Department 44', 1, '-044', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (45, 'ORG', 3, 'Section 16 (node 45)', NULL, '-0016', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (46, 'TEST', 2, 'Node 46 level 2', NULL, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (47, 'ORG', 1, 'AJM Enterprises Ltd', 25, '47', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (48, 'ORG', 3, 'node 48', NULL, '-0048', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (49, 'ORG', 3, 'node 49', NULL, '-0049', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (50, 'TEST', 3, 'node 50', 11, '', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (51, 'TEST', 3, 'node 51', 11, '-51', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (52, 'ORG', 2, 'yet another node', 47, 'N/A', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (53, 'ORG', 1, 'AJM Business Solutions (BS) Ltd', 25, 'BS', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (54, 'ORG', 2, 'node 54', 53, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (55, 'TEST', 2, 'node 55', NULL, NULL, '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (56, 'ORG', 3, 'node 56', 20, '-0056', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (57, 'TEST', 3, 'Node 57', 11, '57', '2004-07-23 17:54:20', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (58, 'ORG', 3, 'Node 58', NULL, NULL, '2004-08-16 15:41:34', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (60, 'TEST', 2, 'Node 60', NULL, '-60', '2005-01-16 18:51:32', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (59, 'ORG', 2, 'Node 59', NULL, '-59', '2004-08-26 14:06:02', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (61, 'TEST', 3, 'Node 61', NULL, '-61', '2005-01-16 18:52:15', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (62, 'TEST', 3, 'Node 62', NULL, '-62', '2005-01-16 20:34:59', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (63, 'TEST', 3, 'Node 63', NULL, '-63', '2005-01-20 21:50:02', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (64, 'TEST', 3, 'Node 64', NULL, '-64', '2005-01-20 21:55:30', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (65, 'TEST', 3, 'Node 65', NULL, '-65', '2005-01-21 06:26:12', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (66, 'TEST', 3, 'Node 66', NULL, '-66', '2005-01-21 06:27:51', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (69, 'TEST', 3, 'Node 69', NULL, NULL, '2005-11-09 18:35:57', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (68, 'TEST', 3, 'Node 68', NULL, 'External Code', '2005-11-09 18:26:09', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_node` (`node_id`, `tree_type_id`, `tree_level_id`, `node_desc`, `node_id_snr`, `external_code`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES (67, 'TEST', 3, 'Node 67', NULL, NULL, '2005-11-07 22:21:31', 'AJM', NULL, NULL);

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

-- 
-- Dumping data for table `x_tree_type`
-- 

REPLACE INTO `x_tree_type` (`tree_type_id`, `tree_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ORG', 'Organisation', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_type` (`tree_type_id`, `tree_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROJ', 'Project', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `x_tree_type` (`tree_type_id`, `tree_type_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('TEST', 'Test', '2000-01-01 00:00:00', 'AJM', NULL, NULL);
