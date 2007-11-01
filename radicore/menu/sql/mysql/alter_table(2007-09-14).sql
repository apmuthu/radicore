CREATE TABLE IF NOT EXISTS `mnu_account` (
  `rdcaccount_id` int(10) unsigned NOT NULL auto_increment,
  `account_name` varchar(255) NOT NULL default '',
  `rdcversion` int(10) unsigned NOT NULL default '1',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`rdcaccount_id`)
) TYPE=MyISAM;

ALTER TABLE `mnu_user` ADD `rdcaccount_id` INT UNSIGNED NULL AFTER `role_id` ;
ALTER TABLE `mnu_user` ADD INDEX ( `rdcaccount_id` );

REPLACE INTO `mnu_account` (`rdcaccount_id`, `account_name`, `rdcversion`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES
(1, 'Shared Account', 1, '2007-09-13 11:41:52', 'AJM', NULL, NULL);