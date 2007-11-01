ALTER TABLE `mnu_role_taskfield` ADD INDEX ( `task_id` );

CREATE TABLE IF NOT EXISTS `mnu_initial_value_role` (
  `role_id` varchar(16) NOT NULL default '',
  `task_id` varchar(80) NOT NULL default '',
  `field_id` varchar(40) NOT NULL default '',
  `initial_value` varchar(40) default NULL,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`role_id`,`task_id`,`field_id`),
  KEY `task_id` (`task_id`)
) TYPE=MyISAM;

CREATE TABLE IF NOT EXISTS `mnu_initial_value_user` (
  `user_id` varchar(16) NOT NULL default '',
  `task_id` varchar(80) NOT NULL default '',
  `field_id` varchar(40) NOT NULL default '',
  `initial_value` varchar(40) default NULL,
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`user_id`,`task_id`,`field_id`),
  KEY `task_id` (`task_id`)
) TYPE=MyISAM;

ALTER TABLE `mnu_todo` ADD `visibility` DECIMAL(2,0) UNSIGNED NULL AFTER `due_date`;
UPDATE `mnu_todo` SET `visibility`=7;
ALTER TABLE `mnu_todo` CHANGE `visibility` `visibility` TINYINT(3) UNSIGNED NOT NULL;

ALTER TABLE `mnu_todo` ADD `repeat_interval` DECIMAL(3,0) UNSIGNED NULL AFTER `is_complete`;
ALTER TABLE `mnu_todo` ADD `repeat_unit` CHAR(1) NULL AFTER `repeat_interval`;
ALTER TABLE `mnu_todo` ADD `task_id` VARCHAR(80) NULL AFTER `repeat_unit`;
ALTER TABLE `mnu_todo` ADD `task_context` VARCHAR(255) NULL AFTER `task_id`;


