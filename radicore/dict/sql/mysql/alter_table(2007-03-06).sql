ALTER TABLE `dict_database` CHANGE `subsys_id` `subsys_id` VARCHAR( 16 ) NOT NULL;
ALTER TABLE `dict_column` CHANGE `task_id` `task_id` VARCHAR( 80 ) NULL DEFAULT NULL;

