-- USE `menu`;

ALTER TABLE `mnu_user_role` ADD COLUMN `sort_seq` INT UNSIGNED NULL AFTER `is_primary`;
ALTER TABLE `mnu_user_role` ADD COLUMN `start_date` DATE NOT NULL DEFAULT '2000-01-01' AFTER `sort_seq`;
ALTER TABLE `mnu_user_role` ADD COLUMN `end_date` DATE NULL DEFAULT '9999-12-31' AFTER `start_date`;

UPDATE `mnu_user_role` SET `sort_seq`=1 WHERE `is_primary`='Y';
UPDATE `mnu_user_role` SET `sort_seq`=9 WHERE `is_primary`='N';
UPDATE `mnu_user_role` SET `start_date`=DATE(`created_date`);

ALTER TABLE `mnu_user_role` DROP COLUMN `is_primary`;
ALTER TABLE `mnu_user_role` CHANGE COLUMN `sort_seq` `sort_seq` INT(10) UNSIGNED NOT NULL;

-- 2017-07-21
ALTER TABLE `mnu_saved_selection_data` ADD COLUMN `sort_seq` SMALLINT UNSIGNED NULL AFTER `fieldvalue`;
ALTER TABLE `mnu_saved_selection_data` ADD COLUMN `output_name` VARCHAR(80) NULL AFTER `sort_seq`;

-- finish