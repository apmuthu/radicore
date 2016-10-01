-- USE `menu`;

ALTER TABLE `mnu_todo` ADD COLUMN `object_id` VARCHAR(255) NULL DEFAULT NULL AFTER `task_context`;
