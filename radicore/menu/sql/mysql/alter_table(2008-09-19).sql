USE `menu`;

UPDATE mnu_control SET field_id='AUTHENTICATION' WHERE record_id='SYSTEM' AND field_id='RADIUS_AUTHENTICATION';
UPDATE mnu_control SET field_value='RADIUS' WHERE record_id='SYSTEM' AND field_id='AUTHENTICATION' AND field_value='Y';
UPDATE mnu_control SET field_value='INTERNAL' WHERE record_id='SYSTEM' AND field_id='AUTHENTICATION' AND field_value='N';

ALTER TABLE `mnu_role` CHANGE `is_radius_auth_off` `is_external_auth_off` CHAR( 1 ) NULL DEFAULT 'N';
ALTER TABLE `mnu_user` CHANGE `is_radius_auth_off` `is_external_auth_off` CHAR( 1 ) NULL DEFAULT 'N';
ALTER TABLE `mnu_user` CHANGE `radius_id` `external_id` VARCHAR( 255 ) NULL DEFAULT NULL;

ALTER TABLE `mnu_task` ADD `max_execution_time` SMALLINT UNSIGNED NULL AFTER `use_https`;
