USE `menu`;

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`order_by` ,`pattern_id` ,`script_id` ,`selection_fixed` ,`settings` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Choose' ,'2010-07-18 13:24:51' ,'AJM' ,'N' ,'Y' ,'N' ,'task_id' ,'POPUP1' ,'mnu_task(popup1).php' ,'task_type=\'PROC\'' ,'select_one=FALSE' ,'MENU' ,'Choose Task (proc)' ,'mnu_task(popup1)a1' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`order_by` ,`pattern_id` ,`script_id` ,`selection_fixed` ,`settings` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Choose' ,'2010-07-18 13:25:05' ,'AJM' ,'N' ,'Y' ,'N' ,'task_id' ,'POPUP1' ,'mnu_task(popup1).php' ,'task_type=\'PROC\'' ,'select_one=FALSE' ,'MENU' ,'Choose Task (proc)' ,'mnu_task(popup1)a2' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Search' ,'N' ,'2010-07-18 15:47:21' ,'AJM' ,'001' ,'mnu_task(search)' ,'mnu_task(popup1)a1');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Search' ,'N' ,'2010-07-18 15:47:34' ,'AJM' ,'001' ,'mnu_task(search)' ,'mnu_task(popup1)a2');
