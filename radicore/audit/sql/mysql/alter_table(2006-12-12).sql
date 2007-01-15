ALTER TABLE `audit_ssn` CHANGE `date` `ssn_date` DATE NOT NULL DEFAULT '2000-01-01';
ALTER TABLE `audit_ssn` CHANGE `time` `ssn_time` TIME NOT NULL DEFAULT '00:00:00';
ALTER TABLE `audit_trn` CHANGE `date` `trn_date` DATE NOT NULL DEFAULT '2000-01-01';
ALTER TABLE `audit_trn` CHANGE `time` `trn_time` TIME NOT NULL DEFAULT '00:00:00';
ALTER TABLE `audit_logon_errors` CHANGE `timestamp` `err_timestamp` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00';

