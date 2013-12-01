-- phpMyAdmin SQL Dump
-- version 2.7.0
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Feb 23, 2006 at 11:09 AM
-- Server version: 4.0.25
-- PHP Version: 4.4.2
-- 
-- Database: `classroom`
-- 

-- CREATE DATABASE classroom ;
-- USE classroom ;

-- --------------------------------------------------------

-- 
-- Table structure for table `crs_class`
-- 

CREATE TABLE IF NOT EXISTS `crs_class` (
  `class_id` varchar(8) NOT NULL default '',
  `class_name` varchar(40) NOT NULL default '',
  `year` decimal(1,0) unsigned default NULL,
  `class_notes` text,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`class_id`)
) ENGINE=MyISAM COMMENT='Idenfifies groups of students who attend the same lessons';

-- --------------------------------------------------------

-- 
-- Table structure for table `crs_class_lesson`
-- 

CREATE TABLE IF NOT EXISTS `crs_class_lesson` (
  `class_id` varchar(8) NOT NULL default '',
  `lesson_id` smallint(5) unsigned NOT NULL default '0',
  PRIMARY KEY  (`class_id`,`lesson_id`)
) ENGINE=MyISAM COMMENT='Cross-reference between Classes and Lessons';

-- --------------------------------------------------------

-- 
-- Table structure for table `crs_conflict`
-- 

CREATE TABLE IF NOT EXISTS `crs_conflict` (
  `conflict_id` int(10) unsigned NOT NULL default '0',
  `conflict_type` char(1) NOT NULL default '',
  `teacher_id` smallint(5) unsigned default NULL,
  `student_id` smallint(5) unsigned default NULL,
  `class_id` varchar(8) default NULL,
  `lesson_id1` smallint(5) unsigned NOT NULL default '0',
  `lesson_id2` smallint(5) unsigned NOT NULL default '0',
  PRIMARY KEY  (`conflict_id`),
  KEY `lesson_id` (`lesson_id1`)
) ENGINE=MyISAM COMMENT='Identifies the lessons which conflict with one another';

-- --------------------------------------------------------

-- 
-- Table structure for table `crs_lesson`
-- 

CREATE TABLE IF NOT EXISTS `crs_lesson` (
  `lesson_id` smallint(5) unsigned NOT NULL default '0',
  `lesson_name` varchar(40) default NULL,
  `lesson_short_name` varchar(30) default NULL,
  `year` decimal(1,0) unsigned default NULL,
  `teacher_id` smallint(5) unsigned default NULL,
  `lesson_notes` text,
  `subject_id` varchar(8) NOT NULL default '',
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`lesson_id`)
) ENGINE=MyISAM COMMENT='Identifies the grade or level of subject being taught';

-- --------------------------------------------------------

-- 
-- Table structure for table `crs_room`
-- 

CREATE TABLE IF NOT EXISTS `crs_room` (
  `room_id` varchar(8) NOT NULL default '',
  `room_desc` varchar(40) NOT NULL default '',
  `room_capacity` decimal(2,0) unsigned NOT NULL default '0',
  `room_notes` text,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`room_id`)
) ENGINE=MyISAM COMMENT='Identifies the rooms where lessons are given';

-- --------------------------------------------------------

-- 
-- Table structure for table `crs_schedule`
-- 

CREATE TABLE IF NOT EXISTS `crs_schedule` (
  `schedule_id` smallint(5) unsigned NOT NULL default '0',
  `seq_no` smallint(5) unsigned NOT NULL default '0',
  `room_id` varchar(8) NOT NULL default '',
  `day_no` decimal(1,0) unsigned NOT NULL default '0',
  `start_time` time NOT NULL default '00:00:00',
  `end_time` time NOT NULL default '00:00:00',
  `lesson_id` smallint(5) unsigned NOT NULL default '0',
  `is_valid` char(1) NOT NULL default 'N',
  `schedule_errors` text,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`schedule_id`,`seq_no`)
) ENGINE=MyISAM COMMENT='Schedule Events';

-- --------------------------------------------------------

-- 
-- Table structure for table `crs_schedule_hdr`
-- 

CREATE TABLE IF NOT EXISTS `crs_schedule_hdr` (
  `schedule_id` smallint(5) unsigned NOT NULL default '0',
  `schedule_desc` varchar(40) NOT NULL default '',
  `schedule_notes` text,
  `is_active` char(1) default NULL,
  `start_time` time NOT NULL default '00:00:00',
  `end_time` time NOT NULL default '00:00:00',
  `last_day_no` decimal(1,0) unsigned NOT NULL default '0',
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`schedule_id`)
) ENGINE=MyISAM COMMENT='Schedule Header';

-- --------------------------------------------------------

-- 
-- Table structure for table `crs_student`
-- 

CREATE TABLE IF NOT EXISTS `crs_student` (
  `student_id` smallint(5) unsigned NOT NULL default '0',
  `first_name` varchar(40) NOT NULL default '',
  `last_name` varchar(40) NOT NULL default '',
  `initials` varchar(4) default NULL,
  `year` decimal(1,0) unsigned default NULL,
  `class_id` varchar(8) default NULL,
  `student_notes` text,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`student_id`)
) ENGINE=MyISAM COMMENT='Identifies the people who will take lessons';

-- --------------------------------------------------------

-- 
-- Table structure for table `crs_student_lesson`
-- 

CREATE TABLE IF NOT EXISTS `crs_student_lesson` (
  `student_id` smallint(5) unsigned NOT NULL default '0',
  `lesson_id` smallint(5) unsigned NOT NULL default '0',
  PRIMARY KEY  (`student_id`,`lesson_id`)
) ENGINE=MyISAM COMMENT='Cross-reference between Students and Lessons';

-- --------------------------------------------------------

-- 
-- Table structure for table `crs_subject`
-- 

CREATE TABLE IF NOT EXISTS `crs_subject` (
  `subject_id` varchar(8) NOT NULL default '',
  `subject_name` varchar(80) NOT NULL default '',
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`subject_id`)
) ENGINE=MyISAM;

-- --------------------------------------------------------

-- 
-- Table structure for table `crs_teacher`
-- 

CREATE TABLE IF NOT EXISTS `crs_teacher` (
  `teacher_id` smallint(5) unsigned NOT NULL default '0',
  `first_name` varchar(40) NOT NULL default '',
  `last_name` varchar(40) NOT NULL default '',
  `initials` varchar(4) default NULL,
  `title` varchar(4) default NULL,
  `teacher_notes` text,
  `created_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`teacher_id`)
) ENGINE=MyISAM COMMENT='Identifies the people who will give lessons';
