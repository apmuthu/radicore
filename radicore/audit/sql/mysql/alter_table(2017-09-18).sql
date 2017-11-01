-- USE `audit`;

ALTER TABLE `php_session` ALTER `session_id` DROP DEFAULT;
ALTER TABLE `php_session` CHANGE COLUMN `session_id` `session_id` VARCHAR(256) NOT NULL FIRST;
