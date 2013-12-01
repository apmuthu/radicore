-- USE `menu`;

CREATE TABLE IF NOT EXISTS `help_text_alt` (
  `task_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `language_id` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `help_text` text COLLATE utf8_unicode_ci,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`task_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `mnu_task_alt` (
  `task_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `language_id` varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `task_desc` varchar(80) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `button_text` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`task_id`,`language_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
