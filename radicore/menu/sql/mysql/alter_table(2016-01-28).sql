-- USE `menu`;

ALTER TABLE `mnu_menu`
	ALTER `button_text` DROP DEFAULT;
ALTER TABLE `mnu_menu`
	CHANGE COLUMN `button_text` `button_text` VARCHAR(40) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `sort_seq`;
