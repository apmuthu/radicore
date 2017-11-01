-- USE `menu`;

CREATE TABLE IF NOT EXISTS `mnu_time_limit_role` (
	`role_id` VARCHAR(16) NOT NULL DEFAULT '' COLLATE 'utf8_unicode_ci',
	`seq_no` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
	`scheduled_start_time` TIME NOT NULL DEFAULT '09:00:00' COMMENT 'Scheduled start time',
	`scheduled_end_time` TIME NOT NULL DEFAULT '17:00:00' COMMENT 'Scheduled start time',
	`scheduled_monday` TINYINT(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'Scheduled on Monday?',
	`scheduled_tuesday` TINYINT(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'Scheduled on Tuesday?',
	`scheduled_wednesday` TINYINT(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'Scheduled on Wednesday?',
	`scheduled_thursday` TINYINT(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'Scheduled on Thursday?',
	`scheduled_friday` TINYINT(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'Scheduled on Friday?',
	`scheduled_saturday` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Scheduled on Saturday?',
	`scheduled_sunday` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Scheduled on Sunday?',
	`created_date` DATETIME NOT NULL DEFAULT '2000-01-01 00:00:00',
	`created_user` VARCHAR(16) NOT NULL DEFAULT 'UNKNOWN' COLLATE 'utf8_unicode_ci',
	`revised_date` DATETIME NULL DEFAULT NULL,
	`revised_user` VARCHAR(16) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`role_id`, `seq_no`)
)
COMMENT='Shows the allowed time period for logons'
COLLATE='utf8_unicode_ci'
ENGINE=MyISAM;

CREATE TABLE IF NOT EXISTS `mnu_time_limit_user` (
	`user_id` VARCHAR(16) NOT NULL DEFAULT '' COLLATE 'utf8_unicode_ci',
	`seq_no` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
	`scheduled_start_time` TIME NOT NULL DEFAULT '09:00:00' COMMENT 'Scheduled start time',
	`scheduled_end_time` TIME NOT NULL DEFAULT '17:00:00' COMMENT 'Scheduled start time',
	`scheduled_monday` TINYINT(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'Scheduled on Monday?',
	`scheduled_tuesday` TINYINT(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'Scheduled on Tuesday?',
	`scheduled_wednesday` TINYINT(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'Scheduled on Wednesday?',
	`scheduled_thursday` TINYINT(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'Scheduled on Thursday?',
	`scheduled_friday` TINYINT(1) UNSIGNED NOT NULL DEFAULT '1' COMMENT 'Scheduled on Friday?',
	`scheduled_saturday` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Scheduled on Saturday?',
	`scheduled_sunday` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Scheduled on Sunday?',
	`created_date` DATETIME NOT NULL DEFAULT '2000-01-01 00:00:00',
	`created_user` VARCHAR(16) NOT NULL DEFAULT 'UNKNOWN' COLLATE 'utf8_unicode_ci',
	`revised_date` DATETIME NULL DEFAULT NULL,
	`revised_user` VARCHAR(16) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci',
	PRIMARY KEY (`user_id`, `seq_no`)
)
COMMENT='Shows the allowed time period for logons'
COLLATE='utf8_unicode_ci'
ENGINE=MyISAM;
