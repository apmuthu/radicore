-- USE `dict`;

ALTER TABLE `dict_column` ALTER `column_desc` DROP DEFAULT;
ALTER TABLE `dict_column` CHANGE COLUMN `column_desc` `column_name` VARCHAR(80) NOT NULL AFTER `column_seq`;
ALTER TABLE `dict_column` CHANGE COLUMN `col_comment` `column_desc` TEXT NULL AFTER `column_name`;

ALTER TABLE `dict_database` ALTER `database_desc` DROP DEFAULT;
ALTER TABLE `dict_database` CHANGE COLUMN `database_desc` `database_name` VARCHAR(80) NOT NULL AFTER `database_id`;
ALTER TABLE `dict_database` CHANGE COLUMN `db_comment` `database_desc` TEXT NULL AFTER `database_name`;

ALTER TABLE `dict_relationship` CHANGE COLUMN `relation_desc` `relation_name` VARCHAR(80) NOT NULL AFTER `table_alias_jnr`;
ALTER TABLE `dict_relationship` CHANGE COLUMN `rel_comment` `relation_desc` TEXT NULL AFTER `relation_name`;
ALTER TABLE `dict_relationship` CHANGE COLUMN `rel_type` `relation_type` CHAR(3) NOT NULL DEFAULT 'RES' AFTER `relation_desc`;

ALTER TABLE `dict_table` CHANGE COLUMN `table_desc` `table_name` VARCHAR(80) NOT NULL AFTER `table_id`;
ALTER TABLE `dict_table` CHANGE COLUMN `tbl_comment` `table_desc` TEXT NULL AFTER `table_name`;

-- finish