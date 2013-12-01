ALTER TABLE `survey_hdr` CHANGE `survey_desc` `survey_long_name` VARCHAR( 255 ) NOT NULL;

ALTER TABLE `number_option` CHANGE `min_value` `min_value` INT( 10 ) UNSIGNED NOT NULL DEFAULT '';
