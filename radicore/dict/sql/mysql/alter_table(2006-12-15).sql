ALTER TABLE `dict_column` CHANGE `comment` `col_comment` TEXT NULL DEFAULT NULL;
ALTER TABLE `dict_column` CHANGE `nosearch` `no_search` CHAR( 3 ) NULL DEFAULT NULL;
ALTER TABLE `dict_column` CHANGE `noaudit` `no_audit` CHAR( 3 ) NULL DEFAULT NULL;
ALTER TABLE `dict_column` CHANGE `subtype` `col_subtype` VARCHAR( 10 ) NULL DEFAULT NULL;
ALTER TABLE `dict_database` CHANGE `comment` `db_comment` TEXT NULL DEFAULT NULL;
ALTER TABLE `dict_relationship` CHANGE `comment` `rel_comment` TEXT NULL DEFAULT NULL;
ALTER TABLE `dict_table` CHANGE `comment` `tbl_comment` TEXT NULL DEFAULT NULL;
ALTER TABLE `dict_column` CHANGE `user_size` `user_size` BIGINT( 20 ) UNSIGNED NULL;
ALTER TABLE `dict_column` CHANGE `col_maxsize` `col_maxsize` BIGINT( 20 ) UNSIGNED NULL;

ALTER TABLE `dict_column` CHANGE `col_type` `col_type` VARCHAR( 20 ) NOT NULL ;
ALTER TABLE `dict_column` CHANGE `col_array_type` `col_array_type` VARCHAR( 20 ) NULL DEFAULT NULL ;
ALTER TABLE `dict_column` ADD `col_type_native` VARCHAR( 32 ) NULL AFTER `col_type`;
UPDATE dict_column SET col_type_native = col_type;
ALTER TABLE `dict_column` CHANGE `col_type_native` `col_type_native` VARCHAR( 32 ) NOT NULL DEFAULT '';




