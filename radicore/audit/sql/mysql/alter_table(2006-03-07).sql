
CREATE TABLE IF NOT EXISTS `audit_logon_errors` (
  `id` int(11) NOT NULL auto_increment,
  `timestamp` datetime NOT NULL default '0000-00-00 00:00:00',
  `ip_address` varchar(16) NOT NULL default '0.0.0.0',
  `user_id` varchar(16) NOT NULL default '',
  `user_password` varchar(16) NOT NULL default '',
  PRIMARY KEY  (`id`)
) TYPE=MyISAM AUTO_INCREMENT=1 ;