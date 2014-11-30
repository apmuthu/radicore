-- USE `dict`;

ALTER TABLE `dict_relationship` ADD COLUMN `key_name` VARCHAR(64) NOT NULL DEFAULT 'PRIMARY' AFTER `calc_field`;

ALTER TABLE `dict_relationship` CHANGE COLUMN `rel_type` `rel_type` CHAR(3) NOT NULL DEFAULT 'RES' COLLATE 'utf8_unicode_ci' AFTER `rel_comment`;
