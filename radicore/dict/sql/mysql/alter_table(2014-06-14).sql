-- USE `dict`;

ALTER TABLE `dict_column` CHANGE COLUMN `col_default` `col_default` VARCHAR(255) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `col_key`;
