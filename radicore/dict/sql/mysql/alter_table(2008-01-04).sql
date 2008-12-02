ALTER TABLE `dict_table` ADD `alt_language_table` VARCHAR( 64 ) NULL AFTER `default_orderby`;
ALTER TABLE `dict_table` ADD `alt_language_cols` TEXT NULL AFTER `alt_language_table` ;
