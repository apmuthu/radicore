USE `menu`;

ALTER TABLE `mnu_user` CHANGE COLUMN `user_password` `user_password` VARCHAR(40) NOT NULL COLLATE 'utf8_bin' AFTER `user_name`;
