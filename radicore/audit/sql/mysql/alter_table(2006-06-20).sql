ALTER TABLE `audit_trn` CHANGE `task_id` `task_id` VARCHAR( 40 ) NOT NULL;
ALTER TABLE `audit_tbl` CHANGE `base_name` `base_name` VARCHAR( 64 ) NOT NULL;
ALTER TABLE `audit_tbl` CHANGE `table_name` `table_name` VARCHAR( 64 ) NOT NULL;
