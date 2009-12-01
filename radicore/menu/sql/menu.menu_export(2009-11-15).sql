USE `menu`;

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Task IP Address' ,'2009-11-15 18:07:25' ,'AJM' ,'N' ,'N' ,'N' ,'LIST2' ,'mnu_task_ip_address(list2).php' ,'MENU' ,'List mnu_task_ip_address by mnu_task' ,'mnu_task_ip_address(list2)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('New' ,'2009-11-15 18:07:26' ,'AJM' ,'N' ,'N' ,'N' ,'ADD2' ,'mnu_task_ip_address(add2).php' ,'MENU' ,'Add Task IP Address' ,'mnu_task_ip_address(add2)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Read' ,'2009-11-15 18:07:26' ,'AJM' ,'N' ,'N' ,'N' ,'ENQ1' ,'mnu_task_ip_address(enq1).php' ,'MENU' ,'Enquire Task IP Address' ,'mnu_task_ip_address(enq1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Update' ,'2009-11-15 18:07:27' ,'AJM' ,'N' ,'N' ,'N' ,'UPD1' ,'mnu_task_ip_address(upd1).php' ,'MENU' ,'Update Task IP Address' ,'mnu_task_ip_address(upd1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Delete' ,'2009-11-15 18:07:28' ,'AJM' ,'N' ,'N' ,'N' ,'DEL1' ,'mnu_task_ip_address(del1).php' ,'MENU' ,'Delete Task IP Address' ,'mnu_task_ip_address(del1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Search' ,'2009-11-15 18:07:30' ,'AJM' ,'N' ,'N' ,'N' ,'SRCH' ,'mnu_task_ip_address(search).php' ,'MENU' ,'Search Task IP Address' ,'mnu_task_ip_address(search)' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('New' ,'N' ,'2009-11-15 18:07:30' ,'AJM' ,'001' ,'mnu_task_ip_address(add2)' ,'mnu_task_ip_address(list2)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Read' ,'Y' ,'2009-11-15 18:07:31' ,'AJM' ,'002' ,'mnu_task_ip_address(enq1)' ,'mnu_task_ip_address(list2)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Update' ,'Y' ,'2009-11-15 18:07:31' ,'AJM' ,'003' ,'mnu_task_ip_address(upd1)' ,'mnu_task_ip_address(list2)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Delete' ,'Y' ,'2009-11-15 18:07:31' ,'AJM' ,'004' ,'mnu_task_ip_address(del1)' ,'mnu_task_ip_address(list2)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Search' ,'N' ,'2009-11-15 18:07:32' ,'AJM' ,'005' ,'mnu_task_ip_address(search)' ,'mnu_task_ip_address(list2)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Audit Trail' ,'Y' ,'2009-11-15 18:07:32' ,'AJM' ,'006' ,'audit_dtl(list)3' ,'mnu_task_ip_address(list2)');

UPDATE `mnu_task` SET `revised_date`='2009-11-15 18:10:22' ,`revised_user`='AJM' ,`task_desc`='List IP Address by Task' WHERE task_id='mnu_task_ip_address(list2)';

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Task IP Address' ,'Y' ,'2009-11-15 18:12:45' ,'AJM' ,'022' ,'mnu_task_ip_address(list2)' ,'mnu_task(list1)a');

UPDATE `mnu_nav_button` SET `revised_date`='2009-11-15 18:12:56' ,`revised_user`='AJM' ,`sort_seq`='022' WHERE task_id_snr='mnu_task(list1)a' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `revised_date`='2009-11-15 18:12:56' ,`revised_user`='AJM' ,`sort_seq`='021' WHERE task_id_snr='mnu_task(list1)a' AND task_id_jnr='mnu_task_ip_address(list2)';

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('User IP Address' ,'2009-11-15 18:22:04' ,'AJM' ,'N' ,'N' ,'N' ,'LIST2' ,'mnu_user_ip_address(list2).php' ,'MENU' ,'List mnu_user_ip_address by mnu_user' ,'mnu_user_ip_address(list2)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('New' ,'2009-11-15 18:22:05' ,'AJM' ,'N' ,'N' ,'N' ,'ADD2' ,'mnu_user_ip_address(add2).php' ,'MENU' ,'Add User IP Address' ,'mnu_user_ip_address(add2)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Read' ,'2009-11-15 18:22:05' ,'AJM' ,'N' ,'N' ,'N' ,'ENQ1' ,'mnu_user_ip_address(enq1).php' ,'MENU' ,'Enquire User IP Address' ,'mnu_user_ip_address(enq1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Update' ,'2009-11-15 18:22:06' ,'AJM' ,'N' ,'N' ,'N' ,'UPD1' ,'mnu_user_ip_address(upd1).php' ,'MENU' ,'Update User IP Address' ,'mnu_user_ip_address(upd1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Delete' ,'2009-11-15 18:22:07' ,'AJM' ,'N' ,'N' ,'N' ,'DEL1' ,'mnu_user_ip_address(del1).php' ,'MENU' ,'Delete User IP Address' ,'mnu_user_ip_address(del1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Search' ,'2009-11-15 18:22:09' ,'AJM' ,'N' ,'N' ,'N' ,'SRCH' ,'mnu_user_ip_address(search).php' ,'MENU' ,'Search User IP Address' ,'mnu_user_ip_address(search)' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('New' ,'N' ,'2009-11-15 18:22:10' ,'AJM' ,'001' ,'mnu_user_ip_address(add2)' ,'mnu_user_ip_address(list2)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Read' ,'Y' ,'2009-11-15 18:22:10' ,'AJM' ,'002' ,'mnu_user_ip_address(enq1)' ,'mnu_user_ip_address(list2)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Update' ,'Y' ,'2009-11-15 18:22:11' ,'AJM' ,'003' ,'mnu_user_ip_address(upd1)' ,'mnu_user_ip_address(list2)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Delete' ,'Y' ,'2009-11-15 18:22:11' ,'AJM' ,'004' ,'mnu_user_ip_address(del1)' ,'mnu_user_ip_address(list2)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Search' ,'N' ,'2009-11-15 18:22:12' ,'AJM' ,'005' ,'mnu_user_ip_address(search)' ,'mnu_user_ip_address(list2)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Audit Trail' ,'Y' ,'2009-11-15 18:22:13' ,'AJM' ,'006' ,'audit_dtl(list)3' ,'mnu_user_ip_address(list2)');

UPDATE `mnu_task` SET `revised_date`='2009-11-15 18:23:33' ,`revised_user`='AJM' ,`task_desc`='List IP Address by User' WHERE task_id='mnu_user_ip_address(list2)';

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('User IP Address' ,'Y' ,'2009-11-15 18:24:21' ,'AJM' ,'012' ,'mnu_user_ip_address(list2)' ,'mnu_user(list1)');

UPDATE `mnu_nav_button` SET `revised_date`='2009-11-15 18:24:30' ,`revised_user`='AJM' ,`sort_seq`='012' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `revised_date`='2009-11-15 18:24:30' ,`revised_user`='AJM' ,`sort_seq`='011' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='mnu_user_ip_address(list2)';
