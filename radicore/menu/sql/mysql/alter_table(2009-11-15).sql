USE `menu`;

CREATE TABLE IF NOT EXISTS `mnu_user_ip_address` (
  `user_id` varchar(16) NOT NULL default '',
  `ip_address` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`user_id`,`ip_address`)
) TYPE=MyISAM COMMENT='List of valid IP addresses';

CREATE TABLE IF NOT EXISTS `mnu_task_ip_address` (
  `task_id` varchar(80) NOT NULL default '',
  `ip_address` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`task_id`,`ip_address`)
) TYPE=MyISAM COMMENT='List of valid IP addresses';
