USE `menu`;

CREATE TABLE IF NOT EXISTS `mnu_favourite` (
  `user_id` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `seq_no` smallint(10) unsigned NOT NULL DEFAULT '0',
  `task_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `task_desc` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sort_seq` smallint(10) unsigned NOT NULL DEFAULT '0',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`,`seq_no`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
