USE `menu`;

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Delete' ,'2010-07-31 20:11:14' ,'AJM' ,'N' ,'N' ,'N' ,'DEL1' ,'audit_logon_errors_del.php' ,'AUDIT' ,'Delete Audit Logon Errors' ,'audit_logon_errors(del)' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Delete' ,'Y' ,'2010-07-31 20:11:39' ,'AJM' ,'002' ,'audit_logon_errors(del)' ,'audit_logon_errors(list)');
