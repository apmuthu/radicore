-- USE `menu`;

ALTER TABLE `mnu_language`
	CHANGE COLUMN `input_date_format` `input_date_format` VARCHAR(20) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `language_name`,
	CHANGE COLUMN `output_date_format` `output_date_format` VARCHAR(20) NULL DEFAULT NULL COLLATE 'utf8_unicode_ci' AFTER `input_date_format`;
