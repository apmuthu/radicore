-- file created on October 31, 2006, 10:02 am
    
REPLACE INTO `mnu_subsystem` (`subsys_id`, `subsys_desc`, `subsys_dir`, `task_prefix`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('MISC', 'Miscellaneous Tasks', 'menu', NULL, '2004-04-17 17:12:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'Demonstration Class', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('date(current)', 'Select Records with Current Dates', 'Current', 'PROC', 'date_current.php', 'N', 'SRCH', 'MISC', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-04-17 17:14:09', 'AJM', '2004-04-17 18:28:39', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'date(current)', '2005-04-19 18:13:04', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('date(future)', 'Select Records with Future Dates', 'Future', 'PROC', 'date_future.php', 'N', 'SRCH', 'MISC', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-04-17 17:15:38', 'AJM', '2004-04-17 18:28:45', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'date(future)', '2005-04-19 18:13:04', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('date(historic)', 'Select Records with Historic Dates', 'Historic', 'PROC', 'date_historic.php', 'N', 'SRCH', 'MISC', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-04-17 17:15:01', 'AJM', '2004-04-17 18:28:48', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'date(historic)', '2005-04-19 18:13:05', 'AJM', NULL, NULL);

-- finished
