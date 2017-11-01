-- USE `menu`;

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(complete)', 'Set selection criteria to COMPLETE', 'COMPLETE', 'PROC', 'mnu_todo(complete).php', 'N', 'OTHER', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2010-07-24 11:07:35', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(incomplete)', 'Set selection criteria to INCOMPLETE', 'INCOMPLETE', 'PROC', 'mnu_todo(incomplete).php', 'N', 'OTHER', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2010-07-24 11:07:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(list1)', 'mnu_todo(complete)', '006', 'COMPLETE', 'N', '2010-07-24 11:08:59', 'AJM', '2010-07-24 11:09:39', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(list1)', 'mnu_todo(incomplete)', '007', 'INCOMPLETE', 'N', '2010-07-24 11:09:20', 'AJM', '2010-07-24 11:09:39', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('MENU-RO', 'mnu_todo(complete)', '2014-04-19 06:21:58', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('MENU-RO', 'mnu_todo(incomplete)', '2014-04-19 06:21:58', 'AJM', NULL, NULL);

UPDATE `mnu_task` SET `order_by`='date desc' ,`revised_date`='2015-04-14 14:51:03' ,`revised_user`='AJM' WHERE task_id='batch_log(filepicker)';
