ALTER TABLE `mnu_dialog_type` RENAME `mnu_pattern` ;

ALTER TABLE `mnu_pattern` CHANGE `dialog_type_id` `pattern_id` VARCHAR( 16 ) NOT NULL ;
ALTER TABLE `mnu_pattern` CHANGE `dialog_type_desc` `pattern_desc` VARCHAR( 60 ) NOT NULL ;
ALTER TABLE `mnu_pattern` CHANGE `dialog_type_long_desc` `pattern_long_desc` TEXT NULL DEFAULT NULL ;

ALTER TABLE `mnu_task` CHANGE `dialog_type_id` `pattern_id` VARCHAR( 16 ) NULL DEFAULT NULL ;
ALTER TABLE `mnu_task` DROP INDEX `dialog_type_id` ,
ADD INDEX `pattern_id` ( `pattern_id` ) ;

