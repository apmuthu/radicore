ALTER TABLE `mnu_user` ADD `start_date` DATE NOT NULL DEFAULT '2000-01-01' AFTER `language_code` ,
ADD `end_date` DATE NULL DEFAULT '9999-12-31' AFTER `start_date` ,
ADD `ip_address` VARCHAR( 16 ) NULL AFTER `end_date` ;

UPDATE `mnu_user` SET start_date=created_date;

ALTER TABLE `mnu_subsystem` ADD `task_prefix` VARCHAR( 8 ) NULL AFTER `subsys_dir` ;

ALTER TABLE `mnu_task` ADD `use_https` CHAR( 1 ) NULL AFTER `screen_refresh` ;
UPDATE `mnu_task` SET use_https = 'N' WHERE use_https IS NULL;




