-- use `survey`;

ALTER TABLE `answer_option`
	ALTER `survey_id` DROP DEFAULT,
	ALTER `section_id` DROP DEFAULT,
	ALTER `question_id` DROP DEFAULT,
	ALTER `answer_id` DROP DEFAULT,
	ALTER `answer_seq` DROP DEFAULT;
ALTER TABLE `answer_option`
	CHANGE COLUMN `survey_id` `survey_id` SMALLINT(5) UNSIGNED NOT NULL FIRST,
	CHANGE COLUMN `section_id` `section_id` SMALLINT(5) UNSIGNED NOT NULL AFTER `survey_id`,
	CHANGE COLUMN `question_id` `question_id` SMALLINT(5) UNSIGNED NOT NULL AFTER `section_id`,
	CHANGE COLUMN `answer_id` `answer_id` TINYINT(3) UNSIGNED NOT NULL AFTER `question_id`,
	CHANGE COLUMN `answer_seq` `answer_seq` SMALLINT(5) UNSIGNED NOT NULL AFTER `answer_id`;

ALTER TABLE `asset_type`
	ALTER `asset_type_id` DROP DEFAULT;
ALTER TABLE `asset_type`
	CHANGE COLUMN `asset_type_id` `asset_type_id` TINYINT(3) UNSIGNED NOT NULL FIRST;

ALTER TABLE `default_prompt`
	ALTER `survey_id` DROP DEFAULT,
	ALTER `prompt_id` DROP DEFAULT;
ALTER TABLE `default_prompt`
	CHANGE COLUMN `survey_id` `survey_id` SMALLINT(5) UNSIGNED NOT NULL FIRST,
	CHANGE COLUMN `prompt_id` `prompt_id` TINYINT(3) UNSIGNED NOT NULL AFTER `survey_id`;

ALTER TABLE `location_address`
	ALTER `node_id` DROP DEFAULT;
ALTER TABLE `location_address`
	CHANGE COLUMN `node_id` `node_id` SMALLINT(5) UNSIGNED NOT NULL FIRST;

ALTER TABLE `location_type`
	ALTER `location_type_id` DROP DEFAULT;
ALTER TABLE `location_type`
	CHANGE COLUMN `location_type_id` `location_type_id` TINYINT(3) UNSIGNED NOT NULL FIRST;

ALTER TABLE `number_option`
	ALTER `survey_id` DROP DEFAULT,
	ALTER `section_id` DROP DEFAULT,
	ALTER `question_id` DROP DEFAULT;
ALTER TABLE `number_option`
	CHANGE COLUMN `survey_id` `survey_id` SMALLINT(5) UNSIGNED NOT NULL FIRST,
	CHANGE COLUMN `section_id` `section_id` SMALLINT(5) UNSIGNED NOT NULL AFTER `survey_id`,
	CHANGE COLUMN `question_id` `question_id` SMALLINT(5) UNSIGNED NOT NULL AFTER `section_id`;

ALTER TABLE `org_type`
	ALTER `org_type_id` DROP DEFAULT;
ALTER TABLE `org_type`
	CHANGE COLUMN `org_type_id` `org_type_id` TINYINT(3) UNSIGNED NOT NULL FIRST;

ALTER TABLE `question_prompt`
	ALTER `survey_id` DROP DEFAULT,
	ALTER `section_id` DROP DEFAULT,
	ALTER `question_id` DROP DEFAULT,
	ALTER `prompt_id` DROP DEFAULT;
ALTER TABLE `question_prompt`
	CHANGE COLUMN `survey_id` `survey_id` SMALLINT(5) UNSIGNED NOT NULL FIRST,
	CHANGE COLUMN `section_id` `section_id` SMALLINT(5) UNSIGNED NOT NULL AFTER `survey_id`,
	CHANGE COLUMN `question_id` `question_id` SMALLINT(5) UNSIGNED NOT NULL AFTER `section_id`,
	CHANGE COLUMN `prompt_id` `prompt_id` TINYINT(3) UNSIGNED NOT NULL AFTER `question_id`;

ALTER TABLE `risk_status`
	ALTER `risk_status_id` DROP DEFAULT;
ALTER TABLE `risk_status`
	CHANGE COLUMN `risk_status_id` `risk_status_id` TINYINT(3) UNSIGNED NOT NULL FIRST;

ALTER TABLE `risk_weighting`
	ALTER `weighting_id` DROP DEFAULT;
ALTER TABLE `risk_weighting`
	CHANGE COLUMN `weighting_id` `weighting_id` TINYINT(3) UNSIGNED NOT NULL FIRST;

ALTER TABLE `survey_answer_dtl`
	ALTER `survey_answer_id` DROP DEFAULT,
	ALTER `survey_id` DROP DEFAULT,
	ALTER `section_id` DROP DEFAULT,
	ALTER `question_id` DROP DEFAULT;
ALTER TABLE `survey_answer_dtl`
	CHANGE COLUMN `survey_answer_id` `survey_answer_id` INT(10) UNSIGNED NOT NULL FIRST,
	CHANGE COLUMN `survey_id` `survey_id` SMALLINT(5) UNSIGNED NOT NULL AFTER `survey_answer_id`,
	CHANGE COLUMN `section_id` `section_id` SMALLINT(5) UNSIGNED NOT NULL AFTER `survey_id`,
	CHANGE COLUMN `question_id` `question_id` SMALLINT(5) UNSIGNED NOT NULL AFTER `section_id`;

ALTER TABLE `survey_answer_hdr`
	ALTER `survey_answer_id` DROP DEFAULT;
ALTER TABLE `survey_answer_hdr`
	CHANGE COLUMN `survey_answer_id` `survey_answer_id` INT(10) UNSIGNED NOT NULL FIRST;

ALTER TABLE `survey_hdr`
	ALTER `survey_id` DROP DEFAULT;
ALTER TABLE `survey_hdr`
	CHANGE COLUMN `survey_id` `survey_id` SMALLINT(5) UNSIGNED NOT NULL FIRST;

ALTER TABLE `survey_question`
	ALTER `survey_id` DROP DEFAULT,
	ALTER `section_id` DROP DEFAULT,
	ALTER `question_id` DROP DEFAULT,
	ALTER `question_seq` DROP DEFAULT;
ALTER TABLE `survey_question`
	CHANGE COLUMN `survey_id` `survey_id` SMALLINT(5) UNSIGNED NOT NULL FIRST,
	CHANGE COLUMN `section_id` `section_id` SMALLINT(5) UNSIGNED NOT NULL AFTER `survey_id`,
	CHANGE COLUMN `question_id` `question_id` SMALLINT(5) UNSIGNED NOT NULL AFTER `section_id`,
	CHANGE COLUMN `question_seq` `question_seq` SMALLINT(5) UNSIGNED NOT NULL AFTER `question_id`;

ALTER TABLE `survey_section`
	ALTER `survey_id` DROP DEFAULT,
	ALTER `section_id` DROP DEFAULT,
	ALTER `section_seq` DROP DEFAULT;
ALTER TABLE `survey_section`
	CHANGE COLUMN `survey_id` `survey_id` SMALLINT(5) UNSIGNED NOT NULL FIRST,
	CHANGE COLUMN `section_id` `section_id` SMALLINT(5) UNSIGNED NOT NULL AFTER `survey_id`,
	CHANGE COLUMN `section_seq` `section_seq` SMALLINT(5) UNSIGNED NOT NULL AFTER `section_id`;

ALTER TABLE `survey_type`
	ALTER `survey_type_desc` DROP DEFAULT;
ALTER TABLE `survey_type`
	CHANGE COLUMN `survey_type_desc` `survey_type_desc` VARCHAR(40) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `survey_type_id`;

ALTER TABLE `tree_node`
	ALTER `node_id` DROP DEFAULT,
	ALTER `node_desc` DROP DEFAULT,
	ALTER `node_type` DROP DEFAULT;
ALTER TABLE `tree_node`
	CHANGE COLUMN `node_id` `node_id` SMALLINT(5) UNSIGNED NOT NULL FIRST,
	CHANGE COLUMN `node_desc` `node_desc` VARCHAR(40) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `node_id`,
	CHANGE COLUMN `node_type` `node_type` CHAR(1) NOT NULL COLLATE 'utf8_unicode_ci' AFTER `node_desc`;
