ALTER TABLE `mnu_user` ADD `party_id` INT( 11 ) UNSIGNED NULL AFTER `is_radius_auth_off`;

ALTER TABLE `mnu_task_field` ADD `field_desc` VARCHAR( 255 ) NULL AFTER `field_id`;