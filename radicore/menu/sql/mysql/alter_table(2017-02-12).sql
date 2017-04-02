-- USE `menu`;

ALTER TABLE `mnu_user`
	ADD COLUMN `force_pswd_chg` CHAR(1) NOT NULL DEFAULT 'N' COLLATE 'utf8_unicode_ci' AFTER `pswd_count`,
	CHANGE COLUMN `in_use` `in_use` CHAR(1) NOT NULL DEFAULT 'N' COLLATE 'utf8_unicode_ci' AFTER `force_pswd_chg`,
	CHANGE COLUMN `is_disabled` `is_disabled` CHAR(1) NOT NULL DEFAULT 'N' COLLATE 'utf8_unicode_ci' AFTER `in_use`,
	CHANGE COLUMN `is_external_auth_off` `is_external_auth_off` CHAR(1) NOT NULL DEFAULT 'N' COLLATE 'utf8_unicode_ci' AFTER `external_id`;
