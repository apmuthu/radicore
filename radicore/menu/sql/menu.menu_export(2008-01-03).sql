use `menu`;

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Supported Languages' ,'2008-01-03 11:34:31' ,'AJM' ,'N' ,'N' ,'N' ,'LIST1' ,'mnu_language(list1).php' ,'MENU' ,'List Supported Languages' ,'mnu_language(list1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('New' ,'2008-01-03 11:34:32' ,'AJM' ,'N' ,'N' ,'N' ,'ADD1' ,'mnu_language(add1).php' ,'MENU' ,'Add Supported Languages' ,'mnu_language(add1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Read' ,'2008-01-03 11:34:33' ,'AJM' ,'N' ,'N' ,'N' ,'ENQ1' ,'mnu_language(enq1).php' ,'MENU' ,'Enquire Supported Languages' ,'mnu_language(enq1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Update' ,'2008-01-03 11:34:33' ,'AJM' ,'N' ,'N' ,'N' ,'UPD1' ,'mnu_language(upd1).php' ,'MENU' ,'Update Supported Languages' ,'mnu_language(upd1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Delete' ,'2008-01-03 11:34:34' ,'AJM' ,'N' ,'N' ,'N' ,'DEL1' ,'mnu_language(del1).php' ,'MENU' ,'Delete Supported Languages' ,'mnu_language(del1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Search' ,'2008-01-03 11:34:34' ,'AJM' ,'N' ,'N' ,'N' ,'SRCH' ,'mnu_language(search).php' ,'MENU' ,'Search Supported Languages' ,'mnu_language(search)' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('New' ,'N' ,'2008-01-03 11:34:35' ,'AJM' ,'001' ,'mnu_language(add1)' ,'mnu_language(list1)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Read' ,'Y' ,'2008-01-03 11:34:35' ,'AJM' ,'002' ,'mnu_language(enq1)' ,'mnu_language(list1)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Update' ,'Y' ,'2008-01-03 11:34:35' ,'AJM' ,'003' ,'mnu_language(upd1)' ,'mnu_language(list1)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Delete' ,'Y' ,'2008-01-03 11:34:36' ,'AJM' ,'004' ,'mnu_language(del1)' ,'mnu_language(list1)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Search' ,'N' ,'2008-01-03 11:34:36' ,'AJM' ,'005' ,'mnu_language(search)' ,'mnu_language(list1)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Audit Trail' ,'Y' ,'2008-01-03 11:34:36' ,'AJM' ,'006' ,'audit_dtl(list)3' ,'mnu_language(list1)');

REPLACE INTO `mnu_menu` (`button_text` ,`created_date` ,`created_user` ,`menu_id` ,`sort_seq` ,`task_id_jnr`) VALUES
('Languages' ,'2008-01-03 11:38:46' ,'AJM' ,'menu01' ,'011' ,'mnu_language(list1)');

