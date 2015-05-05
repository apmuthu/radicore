-- USE `workflow`;

ALTER TABLE `wf_arc`
	ADD COLUMN `condition_field` VARCHAR(40) NULL AFTER `pre_condition`,
	ADD COLUMN `condition_operator` VARCHAR(4) NULL AFTER `condition_field`,
	ADD COLUMN `condition_value` VARCHAR(40) NULL AFTER `condition_operator`;
