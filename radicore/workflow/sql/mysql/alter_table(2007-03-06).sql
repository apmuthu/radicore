ALTER TABLE `wf_transition` CHANGE `task_id` `task_id` VARCHAR( 80 ) NOT NULL;
ALTER TABLE `wf_workflow` CHANGE `start_task_id` `start_task_id` VARCHAR( 80 ) NOT NULL;
ALTER TABLE `wf_workitem` CHANGE `task_id` `task_id` VARCHAR( 80 ) NOT NULL;
