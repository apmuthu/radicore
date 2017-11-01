USE `audit`;

ALTER TABLE `audit_logon_errors` CHANGE `ip_address` `ip_address` VARCHAR( 40) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '0.0.0.0';
