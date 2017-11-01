-- USE `menu`;

ALTER TABLE `mnu_task_field` ADD COLUMN `is_documentation_only` CHAR(1) NOT NULL DEFAULT 'N' AFTER `field_desc`;

CREATE TABLE IF NOT EXISTS `mnu_task_quicksearch` (
  `task_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `field_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `sort_seq` smallint(5) unsigned NOT NULL DEFAULT '0',
  `field_name` VARCHAR(40) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`task_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `mnu_task_quicksearch_alt` (
  `task_id` varchar(80) COLLATE utf8_unicode_ci NOT NULL,
  `field_id` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `language_id` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `field_name` VARCHAR(40) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`task_id`,`field_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
