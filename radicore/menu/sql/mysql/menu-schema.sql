-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.19-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.4.0.5174
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table demo_menu.help_text
CREATE TABLE IF NOT EXISTS `help_text` (
  `task_id` varchar(80) NOT NULL,
  `help_text` text NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`task_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.help_text_alt
CREATE TABLE IF NOT EXISTS `help_text_alt` (
  `task_id` varchar(80) NOT NULL,
  `language_id` varchar(5) NOT NULL,
  `help_text` text NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`task_id`,`language_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_account
CREATE TABLE IF NOT EXISTS `mnu_account` (
  `rdcaccount_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `account_name` varchar(80) NOT NULL,
  `account_desc` text,
  `rdcversion` int(10) unsigned NOT NULL DEFAULT '1',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`rdcaccount_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_control
CREATE TABLE IF NOT EXISTS `mnu_control` (
  `record_id` varchar(16) NOT NULL,
  `field_id` varchar(32) NOT NULL,
  `field_value` varchar(255) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`record_id`,`field_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_favourite
CREATE TABLE IF NOT EXISTS `mnu_favourite` (
  `user_id` varchar(16) NOT NULL,
  `seq_no` smallint(10) unsigned NOT NULL,
  `task_id` varchar(80) NOT NULL,
  `task_name` varchar(80) NOT NULL,
  `sort_seq` smallint(10) unsigned NOT NULL,
  `breadcrumbs` varchar(4000) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`seq_no`),
  UNIQUE KEY `user_id_task_id` (`user_id`,`task_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_initial_value_role
CREATE TABLE IF NOT EXISTS `mnu_initial_value_role` (
  `role_id` varchar(16) NOT NULL,
  `task_id` varchar(80) NOT NULL,
  `field_id` varchar(40) NOT NULL,
  `initial_value` varchar(255) DEFAULT NULL,
  `is_noedit` char(1) NOT NULL DEFAULT 'N',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`role_id`,`task_id`,`field_id`),
  KEY `task_id` (`task_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_initial_value_user
CREATE TABLE IF NOT EXISTS `mnu_initial_value_user` (
  `user_id` varchar(16) NOT NULL,
  `task_id` varchar(80) NOT NULL,
  `field_id` varchar(40) NOT NULL,
  `initial_value` varchar(255) DEFAULT NULL,
  `is_noedit` char(1) NOT NULL DEFAULT 'N',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`task_id`,`field_id`),
  KEY `task_id` (`task_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_language
CREATE TABLE IF NOT EXISTS `mnu_language` (
  `language_id` varchar(5) NOT NULL,
  `language_name` varchar(40) NOT NULL,
  `input_date_format` varchar(20) DEFAULT NULL,
  `output_date_format` varchar(20) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`language_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_menu
CREATE TABLE IF NOT EXISTS `mnu_menu` (
  `menu_id` varchar(80) NOT NULL,
  `task_id_jnr` varchar(80) NOT NULL,
  `sort_seq` tinyint(3) unsigned zerofill NOT NULL DEFAULT '000',
  `button_text` varchar(40) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`menu_id`,`task_id_jnr`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_motd
CREATE TABLE IF NOT EXISTS `mnu_motd` (
  `motd_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `motd_subject` varchar(80) NOT NULL,
  `motd_message` text,
  `start_date` date NOT NULL DEFAULT '2000-01-01',
  `end_date` date DEFAULT '9999-12-31',
  `role_id` varchar(16) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`motd_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_nav_button
CREATE TABLE IF NOT EXISTS `mnu_nav_button` (
  `task_id_snr` varchar(80) NOT NULL,
  `task_id_jnr` varchar(80) NOT NULL,
  `sort_seq` tinyint(3) unsigned zerofill NOT NULL DEFAULT '000',
  `button_text` varchar(40) NOT NULL,
  `context_preselect` char(1) NOT NULL DEFAULT 'N',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`task_id_snr`,`task_id_jnr`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_pattern
CREATE TABLE IF NOT EXISTS `mnu_pattern` (
  `pattern_id` varchar(16) NOT NULL,
  `pattern_name` varchar(80) NOT NULL,
  `pattern_desc` text,
  `visible_screen` char(1) NOT NULL DEFAULT 'N',
  `context_preselect` char(1) NOT NULL DEFAULT 'N',
  `keep_data` char(1) NOT NULL DEFAULT 'N',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`pattern_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_role
CREATE TABLE IF NOT EXISTS `mnu_role` (
  `role_id` varchar(16) NOT NULL,
  `role_name` varchar(80) NOT NULL,
  `role_desc` text,
  `start_task_id` varchar(80) NOT NULL,
  `global_access` char(1) NOT NULL DEFAULT 'N',
  `is_external_auth_off` char(1) NOT NULL DEFAULT 'N',
  `allow_responsive_gui` char(1) NOT NULL DEFAULT 'N',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_role_task
CREATE TABLE IF NOT EXISTS `mnu_role_task` (
  `role_id` varchar(16) NOT NULL,
  `task_id` varchar(80) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`role_id`,`task_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_role_taskfield
CREATE TABLE IF NOT EXISTS `mnu_role_taskfield` (
  `role_id` varchar(16) NOT NULL,
  `task_id` varchar(80) NOT NULL,
  `field_id` varchar(40) NOT NULL,
  `access_type` varchar(4) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`role_id`,`task_id`,`field_id`),
  KEY `task_id` (`task_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_saved_selection
CREATE TABLE IF NOT EXISTS `mnu_saved_selection` (
  `selection_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `selection_name` varchar(80) NOT NULL,
  `user_id` varchar(16) NOT NULL,
  `task_id` varchar(80) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`selection_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_saved_selection_data
CREATE TABLE IF NOT EXISTS `mnu_saved_selection_data` (
  `selection_id` int(10) unsigned NOT NULL,
  `fieldname` varchar(80) NOT NULL,
  `fieldvalue` varchar(80) DEFAULT NULL,
  `sort_seq` smallint(5) unsigned DEFAULT NULL,
  `output_name` varchar(80) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`selection_id`,`fieldname`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_subsystem
CREATE TABLE IF NOT EXISTS `mnu_subsystem` (
  `subsys_id` varchar(16) NOT NULL,
  `subsys_name` varchar(80) NOT NULL,
  `subsys_desc` text,
  `subsys_dir` varchar(255) NOT NULL,
  `task_prefix` varchar(8) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`subsys_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_task
CREATE TABLE IF NOT EXISTS `mnu_task` (
  `task_id` varchar(80) NOT NULL,
  `task_name` varchar(80) NOT NULL,
  `task_desc` text,
  `button_text` varchar(40) NOT NULL,
  `task_type` varchar(4) NOT NULL,
  `script_id` varchar(80) NOT NULL,
  `is_disabled` char(1) NOT NULL DEFAULT 'N',
  `pattern_id` varchar(16) NOT NULL,
  `subsys_id` varchar(16) NOT NULL,
  `initial_passthru` varchar(80) DEFAULT NULL,
  `selection_fixed` varchar(255) DEFAULT NULL,
  `selection_temp` varchar(255) DEFAULT NULL,
  `settings` varchar(255) DEFAULT NULL,
  `order_by` varchar(255) DEFAULT NULL,
  `keep_data` char(1) NOT NULL DEFAULT 'N',
  `log_sql_query` char(1) NOT NULL DEFAULT 'N',
  `screen_refresh` smallint(5) unsigned DEFAULT NULL,
  `use_https` char(1) NOT NULL DEFAULT 'N',
  `max_execution_time` smallint(5) unsigned DEFAULT NULL,
  `task_id_run_at_end` varchar(80) DEFAULT NULL,
  `task_id_run_at_cancel` varchar(80) DEFAULT NULL,
  `allow_responsive_gui` char(1) NOT NULL DEFAULT 'N',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`task_id`),
  KEY `subsys_id` (`subsys_id`),
  KEY `pattern_id` (`pattern_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_task_alt
CREATE TABLE IF NOT EXISTS `mnu_task_alt` (
  `task_id` varchar(80) NOT NULL,
  `language_id` varchar(5) NOT NULL,
  `task_name` varchar(80) NOT NULL,
  `task_desc` text,
  `button_text` varchar(40) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`task_id`,`language_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_task_field
CREATE TABLE IF NOT EXISTS `mnu_task_field` (
  `task_id` varchar(80) NOT NULL,
  `field_id` varchar(40) NOT NULL,
  `field_desc` varchar(255) DEFAULT NULL,
  `is_documentation_only` char(1) NOT NULL DEFAULT 'N',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`task_id`,`field_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_task_ip_address
CREATE TABLE IF NOT EXISTS `mnu_task_ip_address` (
  `task_id` varchar(80) NOT NULL,
  `ip_address` varchar(40) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`task_id`,`ip_address`)
) COMMENT='List of valid IP addresses';

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_task_quicksearch
CREATE TABLE IF NOT EXISTS `mnu_task_quicksearch` (
  `task_id` varchar(80) NOT NULL,
  `field_id` varchar(40) NOT NULL,
  `sort_seq` smallint(5) unsigned NOT NULL,
  `field_name` varchar(80) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`task_id`,`field_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_task_quicksearch_alt
CREATE TABLE IF NOT EXISTS `mnu_task_quicksearch_alt` (
  `task_id` varchar(80) NOT NULL,
  `field_id` varchar(40) NOT NULL,
  `language_id` varchar(5) NOT NULL,
  `field_name` varchar(80) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`task_id`,`field_id`,`language_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_time_limit_role
CREATE TABLE IF NOT EXISTS `mnu_time_limit_role` (
  `role_id` varchar(16) NOT NULL,
  `seq_no` smallint(5) unsigned NOT NULL,
  `scheduled_start_time` time NOT NULL DEFAULT '09:00:00' COMMENT 'Scheduled start time',
  `scheduled_end_time` time NOT NULL DEFAULT '17:00:00' COMMENT 'Scheduled start time',
  `scheduled_monday` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Scheduled on Monday?',
  `scheduled_tuesday` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Scheduled on Tuesday?',
  `scheduled_wednesday` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Scheduled on Wednesday?',
  `scheduled_thursday` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Scheduled on Thursday?',
  `scheduled_friday` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Scheduled on Friday?',
  `scheduled_saturday` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Scheduled on Saturday?',
  `scheduled_sunday` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Scheduled on Sunday?',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`role_id`,`seq_no`)
) COMMENT='Shows the allowed time period for logons';

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_time_limit_user
CREATE TABLE IF NOT EXISTS `mnu_time_limit_user` (
  `user_id` varchar(16) NOT NULL,
  `seq_no` smallint(5) unsigned NOT NULL,
  `scheduled_start_time` time NOT NULL DEFAULT '09:00:00' COMMENT 'Scheduled start time',
  `scheduled_end_time` time NOT NULL DEFAULT '17:00:00' COMMENT 'Scheduled start time',
  `scheduled_monday` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Scheduled on Monday?',
  `scheduled_tuesday` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Scheduled on Tuesday?',
  `scheduled_wednesday` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Scheduled on Wednesday?',
  `scheduled_thursday` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Scheduled on Thursday?',
  `scheduled_friday` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT 'Scheduled on Friday?',
  `scheduled_saturday` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Scheduled on Saturday?',
  `scheduled_sunday` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Scheduled on Sunday?',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`seq_no`)
) COMMENT='Shows the allowed time period for logons';

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_todo
CREATE TABLE IF NOT EXISTS `mnu_todo` (
  `user_id` varchar(16) NOT NULL,
  `seq_no` smallint(5) unsigned NOT NULL,
  `item_name` varchar(80) NOT NULL,
  `item_desc` text,
  `due_date` date NOT NULL DEFAULT '0000-00-00',
  `visibility` tinyint(3) unsigned NOT NULL,
  `is_complete` char(1) NOT NULL DEFAULT 'N',
  `repeat_interval` decimal(3,0) unsigned DEFAULT NULL,
  `repeat_unit` char(1) DEFAULT NULL,
  `task_id` varchar(80) DEFAULT NULL,
  `task_context` varchar(255) DEFAULT NULL,
  `object_id` varchar(255) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`seq_no`)
) COMMENT='List of "To Do" items';

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_user
CREATE TABLE IF NOT EXISTS `mnu_user` (
  `user_id` varchar(16) NOT NULL,
  `user_name` varchar(40) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `rdcaccount_id` int(10) unsigned DEFAULT NULL,
  `pswd_change_datetime` datetime DEFAULT NULL,
  `pswd_count` smallint(6) unsigned DEFAULT NULL,
  `force_pswd_chg` char(1) NOT NULL DEFAULT 'N',
  `in_use` char(1) NOT NULL DEFAULT 'N',
  `is_disabled` char(1) NOT NULL DEFAULT 'N',
  `logon_datetime` datetime DEFAULT NULL,
  `language_id` varchar(6) DEFAULT NULL,
  `start_date` date NOT NULL DEFAULT '2000-01-01',
  `end_date` date DEFAULT '9999-12-31',
  `ip_address` varchar(40) DEFAULT NULL,
  `email_addr` varchar(50) NOT NULL,
  `external_id` varchar(255) DEFAULT NULL,
  `is_external_auth_off` char(1) NOT NULL DEFAULT 'N',
  `party_id` int(11) unsigned DEFAULT NULL,
  `user_timezone` varchar(40) DEFAULT NULL,
  `allow_responsive_gui` char(1) NOT NULL DEFAULT 'N',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_addr` (`email_addr`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_user_alt
CREATE TABLE IF NOT EXISTS `mnu_user_alt` (
  `user_id` varchar(16) NOT NULL,
  `language_id` varchar(5) NOT NULL,
  `user_name` varchar(40) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`language_id`)
);

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_user_ip_address
CREATE TABLE IF NOT EXISTS `mnu_user_ip_address` (
  `user_id` varchar(16) NOT NULL,
  `ip_address` varchar(40) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`ip_address`)
) COMMENT='List of valid IP addresses';

-- Data exporting was unselected.
-- Dumping structure for table demo_menu.mnu_user_role
CREATE TABLE IF NOT EXISTS `mnu_user_role` (
  `user_id` varchar(16) NOT NULL,
  `role_id` varchar(16) NOT NULL,
  `sort_seq` int(10) unsigned NOT NULL,
  `start_date` date NOT NULL DEFAULT '2000-01-01',
  `end_date` date DEFAULT '9999-12-31',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
