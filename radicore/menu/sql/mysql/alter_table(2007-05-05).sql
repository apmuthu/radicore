ALTER TABLE `mnu_role_taskfield` ADD INDEX ( `task_id` );

CREATE TABLE IF NOT EXISTS `mnu_initial_value` (
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