-- USE `menu`;

ALTER TABLE `mnu_user`
	ALTER `user_password` DROP DEFAULT;
ALTER TABLE `mnu_user`
	CHANGE COLUMN `user_password` `user_password` VARCHAR(255) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `user_name`;

ALTER TABLE `mnu_task`
	ALTER `task_desc` DROP DEFAULT,
	ALTER `task_type` DROP DEFAULT,
	ALTER `script_id` DROP DEFAULT,
	ALTER `pattern_id` DROP DEFAULT,
	ALTER `subsys_id` DROP DEFAULT;
ALTER TABLE `mnu_task`
	CHANGE COLUMN `task_desc` `task_desc` VARCHAR(80) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `task_id`,
	CHANGE COLUMN `task_type` `task_type` VARCHAR(4) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `button_text`,
	CHANGE COLUMN `script_id` `script_id` VARCHAR(80) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `task_type`,
	CHANGE COLUMN `pattern_id` `pattern_id` VARCHAR(16) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `is_disabled`,
	CHANGE COLUMN `subsys_id` `subsys_id` VARCHAR(16) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `pattern_id`;
