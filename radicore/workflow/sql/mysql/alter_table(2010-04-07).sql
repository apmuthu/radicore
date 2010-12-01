USE `workflow`;

ALTER TABLE `wf_transition` CHANGE `time_limit` `time_limit` INT(11) UNSIGNED NULL DEFAULT NULL;
