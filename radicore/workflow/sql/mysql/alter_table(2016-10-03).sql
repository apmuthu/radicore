-- USE `workflow`;

ALTER TABLE `wf_workitem`
	ALTER `case_id` DROP DEFAULT,
	ALTER `workitem_id` DROP DEFAULT,
	ALTER `workflow_id` DROP DEFAULT,
	ALTER `transition_id` DROP DEFAULT,
	ALTER `task_id` DROP DEFAULT,
	ALTER `context` DROP DEFAULT;
ALTER TABLE `wf_workitem`
	CHANGE COLUMN `case_id` `case_id` INT(10) UNSIGNED NOT NULL AFTER `rdcaccount_id`,
	CHANGE COLUMN `workitem_id` `workitem_id` SMALLINT(5) UNSIGNED NOT NULL AFTER `case_id`,
	CHANGE COLUMN `workflow_id` `workflow_id` SMALLINT(6) UNSIGNED NOT NULL AFTER `workitem_id`,
	CHANGE COLUMN `transition_id` `transition_id` SMALLINT(5) UNSIGNED NOT NULL AFTER `workflow_id`,
	CHANGE COLUMN `transition_trigger` `transition_trigger` VARCHAR(4) NOT NULL DEFAULT 'USER' COLLATE 'utf8_unicode_ci' AFTER `transition_id`,
	CHANGE COLUMN `task_id` `task_id` VARCHAR(80) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `transition_trigger`,
	CHANGE COLUMN `context` `context` VARCHAR(255) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `task_id`,
	CHANGE COLUMN `workitem_status` `workitem_status` CHAR(2) NOT NULL DEFAULT 'EN' COLLATE 'utf8_unicode_ci' AFTER `context`,
	CHANGE COLUMN `role_id` `role_id` VARCHAR(16) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `deadline`,
	CHANGE COLUMN `user_id` `user_id` VARCHAR(16) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `role_id`;
