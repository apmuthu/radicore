CREATE TABLE IF NOT EXISTS `x_pers_type_alt` (
  `pers_type_id` varchar(6) NOT NULL default '',
  `language_id` varchar(5) NOT NULL default '',
  `pers_type_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`pers_type_id`,`language_id`)
) TYPE=MyISAM;

CREATE TABLE IF NOT EXISTS `x_option_alt` (
  `option_id` varchar(8) NOT NULL default '',
  `language_id` varchar(5) NOT NULL default '',
  `option_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`option_id`,`language_id`)
) TYPE=MyISAM;

CREATE TABLE IF NOT EXISTS `x_tree_type_alt` (
  `tree_type_id` varchar(8) NOT NULL default '',
  `language_id` varchar(5) NOT NULL default '',
  `tree_type_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`tree_type_id`,`language_id`)
) TYPE=MyISAM;

CREATE TABLE IF NOT EXISTS `x_tree_level_alt` (
  `tree_type_id` varchar(8) NOT NULL default '',
  `tree_level_id` tinyint(3) unsigned NOT NULL default '0',
  `language_id` varchar(5) NOT NULL default '',
  `tree_level_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`tree_type_id`,`tree_level_id`,`language_id`)
) TYPE=MyISAM;

CREATE TABLE IF NOT EXISTS `x_tree_node_alt` (
  `node_id` smallint(5) unsigned NOT NULL default '0',
  `language_id` varchar(5) NOT NULL default '',
  `node_desc` varchar(40) NOT NULL default '',
  `created_date` datetime NOT NULL default '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL default 'UNKNOWN',
  `revised_date` datetime default NULL,
  `revised_user` varchar(16) default NULL,
  PRIMARY KEY  (`node_id`,`language_id`)
) TYPE=MyISAM;