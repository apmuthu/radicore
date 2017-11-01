-- USE `menu`;

ALTER TABLE `mnu_todo`
	ALTER `item_desc` DROP DEFAULT;
ALTER TABLE `mnu_todo`
	CHANGE COLUMN `item_desc` `item_desc` VARCHAR(80) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `seq_no`;
