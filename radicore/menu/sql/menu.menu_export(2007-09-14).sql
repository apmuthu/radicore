use `menu`;

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Hosting Account' ,'2007-09-13 11:30:42' ,'AJM' ,'N' ,'N' ,'N' ,'LIST1' ,'mnu_account(list1).php' ,'MENU' ,'List Hosting Account' ,'mnu_account(list1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('New' ,'2007-09-13 11:30:42' ,'AJM' ,'N' ,'N' ,'N' ,'ADD1' ,'mnu_account(add1).php' ,'MENU' ,'Add Hosting Account' ,'mnu_account(add1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Read' ,'2007-09-13 11:30:42' ,'AJM' ,'N' ,'N' ,'N' ,'ENQ1' ,'mnu_account(enq1).php' ,'MENU' ,'Enquire Hosting Account' ,'mnu_account(enq1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Update' ,'2007-09-13 11:30:42' ,'AJM' ,'N' ,'N' ,'N' ,'UPD1' ,'mnu_account(upd1).php' ,'MENU' ,'Update Hosting Account' ,'mnu_account(upd1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Delete' ,'2007-09-13 11:30:42' ,'AJM' ,'N' ,'N' ,'N' ,'DEL1' ,'mnu_account(del1).php' ,'MENU' ,'Delete Hosting Account' ,'mnu_account(del1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Search' ,'2007-09-13 11:30:43' ,'AJM' ,'N' ,'N' ,'N' ,'SRCH' ,'mnu_account(search).php' ,'MENU' ,'Search Hosting Account' ,'mnu_account(search)' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('New' ,'N' ,'2007-09-13 11:30:43' ,'AJM' ,'001' ,'mnu_account(add1)' ,'mnu_account(list1)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Read' ,'Y' ,'2007-09-13 11:30:43' ,'AJM' ,'002' ,'mnu_account(enq1)' ,'mnu_account(list1)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Update' ,'Y' ,'2007-09-13 11:30:43' ,'AJM' ,'003' ,'mnu_account(upd1)' ,'mnu_account(list1)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Delete' ,'Y' ,'2007-09-13 11:30:43' ,'AJM' ,'004' ,'mnu_account(del1)' ,'mnu_account(list1)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Search' ,'N' ,'2007-09-13 11:30:43' ,'AJM' ,'005' ,'mnu_account(search)' ,'mnu_account(list1)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Audit Trail' ,'Y' ,'2007-09-13 11:30:43' ,'AJM' ,'006' ,'audit_dtl(list)3' ,'mnu_account(list1)');

REPLACE INTO `mnu_menu` (`button_text` ,`created_date` ,`created_user` ,`menu_id` ,`sort_seq` ,`task_id_jnr`) VALUES
('Hosting Account' ,'2007-09-13 11:30:43' ,'AJM' ,'menu' ,'001' ,'mnu_account(list1)');

REPLACE INTO `mnu_menu` (`button_text` ,`created_date` ,`created_user` ,`menu_id` ,`sort_seq` ,`task_id_jnr`) VALUES
('Hosting Account' ,'2007-09-13 11:37:37' ,'AJM' ,'menu01' ,'010' ,'mnu_account(list1)');
