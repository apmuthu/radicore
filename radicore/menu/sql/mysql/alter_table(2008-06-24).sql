USE `menu`;

ALTER TABLE `mnu_initial_value_role` CHANGE `initial_value` `initial_value` VARCHAR( 255 ) NULL DEFAULT NULL;
ALTER TABLE `mnu_initial_value_user` CHANGE `initial_value` `initial_value` VARCHAR( 255 ) NULL DEFAULT NULL;
