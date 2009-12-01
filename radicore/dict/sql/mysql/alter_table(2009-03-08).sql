USE `dict`;

ALTER TABLE `dict_table` ADD `nameof_start_date` VARCHAR( 40 ) NULL AFTER `alt_language_cols`;
ALTER TABLE `dict_table` ADD `nameof_end_date` VARCHAR( 40 ) NULL AFTER `nameof_start_date` ;
