CREATE TABLE IF NOT EXISTS `mnu_language` (
  `language_id` varchar(5) NOT NULL default 'EN',
  `language_name` varchar(40) NOT NULL default 'English',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`language_id`)
) TYPE=MyISAM;

ALTER TABLE `mnu_user` ADD `radius_id` VARCHAR( 40 ) NULL AFTER `email_addr`;
ALTER TABLE `mnu_user` ADD `is_radius_auth_off` CHAR( 1 ) NULL DEFAULT 'N' AFTER `radius_id`;

ALTER TABLE `mnu_role` ADD `is_radius_auth_off` CHAR( 1 ) NULL DEFAULT 'N' AFTER `global_access`;
ALTER TABLE `mnu_role` CHANGE `global_access` `global_access` CHAR( 1 ) NULL DEFAULT 'N';

ALTER TABLE `mnu_initial_value_role` ADD `is_noedit` CHAR( 1 ) NULL DEFAULT 'N' AFTER `initial_value`;
ALTER TABLE `mnu_initial_value_user` ADD `is_noedit` CHAR( 1 ) NULL DEFAULT 'N' AFTER `initial_value`;

ALTER TABLE `mnu_task` CHANGE `settings` `settings` VARCHAR( 255 ) NULL DEFAULT NULL;
ALTER TABLE `mnu_task` CHANGE `use_https` `use_https` CHAR( 1 ) NULL DEFAULT 'N';
ALTER TABLE `mnu_task` CHANGE `log_sql_query` `log_sql_query` CHAR( 1 ) NULL DEFAULT 'N';
ALTER TABLE `mnu_task` CHANGE `keep_data` `keep_data` CHAR( 1 ) NULL DEFAULT 'N';
ALTER TABLE `mnu_task` CHANGE `is_disabled` `is_disabled` CHAR( 1 ) NULL DEFAULT 'N';
ALTER TABLE `mnu_task` CHANGE `created_user` `created_user` VARCHAR( 16 ) NOT NULL DEFAULT 'UNKNOWN';
ALTER TABLE `mnu_task` CHANGE `revised_user` `revised_user` VARCHAR( 16 ) NULL DEFAULT NULL;

ALTER TABLE `help_text` CHANGE `created_user` `created_user` VARCHAR( 16 ) NOT NULL DEFAULT 'UNKNOWN';
ALTER TABLE `help_text` CHANGE `revised_user` `revised_user` VARCHAR( 16 ) NULL DEFAULT NULL;

ALTER TABLE `mnu_control` CHANGE `created_user` `created_user` VARCHAR( 16 ) NOT NULL DEFAULT 'UNKNOWN';
ALTER TABLE `mnu_control` CHANGE `revised_user` `revised_user` VARCHAR( 16 ) NULL DEFAULT NULL;

ALTER TABLE `mnu_menu` CHANGE `created_user` `created_user` VARCHAR( 16 ) NOT NULL DEFAULT 'UNKNOWN';
ALTER TABLE `mnu_menu` CHANGE `revised_user` `revised_user` VARCHAR( 16 ) NULL DEFAULT NULL;

ALTER TABLE `mnu_nav_button` CHANGE `created_user` `created_user` VARCHAR( 16 ) NOT NULL DEFAULT 'UNKNOWN';
ALTER TABLE `mnu_nav_button` CHANGE `revised_user` `revised_user` VARCHAR( 16 ) NULL DEFAULT NULL;
ALTER TABLE `mnu_nav_button` CHANGE `context_preselect` `context_preselect` CHAR( 1 ) NULL DEFAULT 'N';

ALTER TABLE `mnu_pattern` CHANGE `created_user` `created_user` VARCHAR( 16 ) NOT NULL DEFAULT 'UNKNOWN';
ALTER TABLE `mnu_pattern` CHANGE `revised_user` `revised_user` VARCHAR( 16 ) NULL DEFAULT NULL;
ALTER TABLE `mnu_pattern` CHANGE `visible_screen` `visible_screen` CHAR( 1 ) NULL DEFAULT 'N';
ALTER TABLE `mnu_pattern` CHANGE `context_preselect` `context_preselect` CHAR( 1 ) NULL DEFAULT 'N';
ALTER TABLE `mnu_pattern` CHANGE `keep_data` `keep_data` CHAR( 1 ) NULL DEFAULT 'N';

ALTER TABLE `mnu_role` CHANGE `created_user` `created_user` VARCHAR( 16 ) NOT NULL DEFAULT 'UNKNOWN';
ALTER TABLE `mnu_role` CHANGE `revised_user` `revised_user` VARCHAR( 16 ) NULL DEFAULT NULL;

ALTER TABLE `mnu_role_task` CHANGE `created_user` `created_user` VARCHAR( 16 ) NOT NULL DEFAULT 'UNKNOWN';
ALTER TABLE `mnu_role_task` CHANGE `revised_user` `revised_user` VARCHAR( 16 ) NULL DEFAULT NULL;

ALTER TABLE `mnu_role_taskfield` CHANGE `created_user` `created_user` VARCHAR( 16 ) NOT NULL DEFAULT 'UNKNOWN';
ALTER TABLE `mnu_role_taskfield` CHANGE `revised_user` `revised_user` VARCHAR( 16 ) NULL DEFAULT NULL;

ALTER TABLE `mnu_subsystem` CHANGE `created_user` `created_user` VARCHAR( 16 ) NOT NULL DEFAULT 'UNKNOWN';
ALTER TABLE `mnu_subsystem` CHANGE `revised_user` `revised_user` VARCHAR( 16 ) NULL DEFAULT NULL;

ALTER TABLE `mnu_task_field` CHANGE `created_user` `created_user` VARCHAR( 16 ) NOT NULL DEFAULT 'UNKNOWN';
ALTER TABLE `mnu_task_field` CHANGE `revised_user` `revised_user` VARCHAR( 16 ) NULL DEFAULT NULL;

ALTER TABLE `mnu_todo` CHANGE `created_user` `created_user` VARCHAR( 16 ) NOT NULL DEFAULT 'UNKNOWN';
ALTER TABLE `mnu_todo` CHANGE `revised_user` `revised_user` VARCHAR( 16 ) NULL DEFAULT NULL;

ALTER TABLE `mnu_role_taskfield` DROP INDEX `task_id_2`;