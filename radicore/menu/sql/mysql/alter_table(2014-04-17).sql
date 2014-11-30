-- USE `menu`;

ALTER TABLE `mnu_language`
	ADD COLUMN `input_date_format` VARCHAR(12) NULL DEFAULT NULL AFTER `language_name`,
	ADD COLUMN `output_date_format` VARCHAR(12) NULL DEFAULT NULL AFTER `input_date_format`;

ALTER TABLE `mnu_favourite` ADD UNIQUE INDEX `user_id_task_id` (`user_id`, `task_id`);

ALTER TABLE `mnu_favourite`
	CHANGE COLUMN `breadcrumbs` `breadcrumbs` VARCHAR(4000) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `sort_seq`;

CREATE TABLE IF NOT EXISTS `mnu_user_alt` (
  `user_id` varchar(16) NOT NULL DEFAULT '',
  `language_id` varchar(5) NOT NULL DEFAULT '',
  `user_name` varchar(30) NOT NULL DEFAULT '',
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `mnu_user_role` (
  `user_id` varchar(16) NOT NULL DEFAULT '',
  `role_id` varchar(16) NOT NULL DEFAULT '',
  `is_primary` char(1) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `created_user` varchar(16) NOT NULL DEFAULT 'UNKNOWN',
  `revised_date` datetime DEFAULT NULL,
  `revised_user` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO mnu_user_role (user_id, role_id, is_primary, created_date, created_user)
                    SELECT user_id, role_id, 'Y', '2014-04-17', created_user FROM mnu_user;

ALTER TABLE `mnu_user` DROP COLUMN `role_id`;
