USE `audit`;

ALTER TABLE `audit_logon_errors` CHANGE `user_id` `user_id` VARCHAR( 16 ) NULL;
ALTER TABLE `audit_logon_errors` ADD `email_addr` VARCHAR( 50 ) NULL ;
