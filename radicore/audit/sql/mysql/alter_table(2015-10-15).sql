-- USE `audit`;

ALTER TABLE `audit_ssn` ADD COLUMN `ssn_datetime` DATETIME NULL AFTER `ssn_time`;

UPDATE `audit_ssn` SET `ssn_datetime`=TIMESTAMP(ssn_date, ssn_time) WHERE ssn_datetime IS NULL;

ALTER TABLE `audit_ssn` ALTER `ssn_datetime` DROP DEFAULT;
ALTER TABLE `audit_ssn` CHANGE COLUMN `ssn_datetime` `ssn_datetime` DATETIME NOT NULL AFTER `user_id`;

ALTER TABLE `audit_ssn` ADD INDEX `ssn_datetime` (`ssn_datetime`);

ALTER TABLE `audit_ssn` DROP COLUMN `ssn_date`;
ALTER TABLE `audit_ssn`	DROP COLUMN `ssn_time`;

ALTER TABLE `audit_trn` ADD COLUMN `trn_datetime` DATETIME NULL AFTER `trn_time`;

UPDATE `audit_trn` SET `trn_datetime`=TIMESTAMP(trn_date, trn_time) WHERE trn_datetime IS NULL;

ALTER TABLE `audit_trn` ALTER `trn_datetime` DROP DEFAULT;
ALTER TABLE `audit_trn` CHANGE COLUMN `trn_datetime` `trn_datetime` DATETIME NOT NULL AFTER `tran_seq_no`;

ALTER TABLE `audit_trn` ADD INDEX `trn_datetime` (`trn_datetime`);

ALTER TABLE `audit_trn` DROP COLUMN `trn_date`;
ALTER TABLE `audit_trn`	DROP COLUMN `trn_time`;
