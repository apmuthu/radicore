-- USE `menu`;

CREATE TABLE IF NOT EXISTS `mnu_saved_selection` (
  `selection_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `selection_desc` varchar(80) NOT NULL,
  `user_id` varchar(16) NOT NULL,
  `task_id` varchar(80) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`selection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `mnu_saved_selection_data` (
  `selection_id` int(10) unsigned NOT NULL,
  `fieldname` varchar(80) NOT NULL,
  `fieldvalue` varchar(80) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`selection_id`,`fieldname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
