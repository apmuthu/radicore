USE `menu`;

ALTER TABLE `mnu_task` ADD `task_id_run_at_end` VARCHAR( 80 ) NULL AFTER `max_execution_time`;
ALTER TABLE `mnu_task` ADD `task_id_run_at_cancel` VARCHAR( 80 ) NULL AFTER `task_id_run_at_end`;

ALTER TABLE `mnu_task` CHANGE `initial_passthru` `initial_passthru` VARCHAR( 80 ) NULL DEFAULT NULL;
