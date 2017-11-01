-- USE `menu`;

UPDATE mnu_language SET language_id=LOWER(language_id) WHERE language_id IS NOT NULL;

ALTER TABLE `mnu_user` CHANGE COLUMN `language_code` `language_id` VARCHAR(6) NULL DEFAULT NULL AFTER `logon_time`;
