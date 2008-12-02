use `menu`;

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Search' ,'N' ,'2008-02-07 14:43:08' ,'AJM' ,'001' ,'mnu_task(search)' ,'mnu_initial_value_user(multi3)b');

UPDATE `mnu_nav_button` SET `button_text`='Search Task' ,`revised_date`='2008-02-07 14:43:17' ,`revised_user`='AJM' WHERE task_id_snr='mnu_initial_value_user(multi3)b' AND task_id_jnr='mnu_task(search)';

UPDATE `mnu_nav_button` SET `button_text`='Search Task' ,`revised_date`='2008-02-07 14:45:32' ,`revised_user`='AJM' WHERE task_id_snr='mnu_initial_value_role(multi3)b' AND task_id_jnr='mnu_task(search)';

UPDATE `mnu_nav_button` SET `button_text`='Search Role' ,`revised_date`='2008-02-07 14:46:56' ,`revised_user`='AJM' WHERE task_id_snr='mnu_initial_value_role(multi3)a' AND task_id_jnr='mnu_role(search)';

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Search' ,'N' ,'2008-02-07 14:47:21' ,'AJM' ,'001' ,'mnu_user(search)' ,'mnu_initial_value_user(multi3)a');

UPDATE `mnu_nav_button` SET `button_text`='Search User' ,`revised_date`='2008-02-07 14:47:30' ,`revised_user`='AJM' WHERE task_id_snr='mnu_initial_value_user(multi3)a' AND task_id_jnr='mnu_user(search)';


REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Update' ,'2008-02-27 16:15:00' ,'AJM' ,'N' ,'N' ,'N' ,'UPD1' ,'mnu_task_field(upd1).php' ,'MENU' ,'Update Task Field' ,'mnu_task_field(upd1)' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Update' ,'Y' ,'2008-02-27 16:15:46' ,'AJM' ,'004' ,'mnu_task_field(upd1)' ,'mnu_task_field(list2)');

UPDATE `mnu_nav_button` SET `revised_date`='2008-02-27 16:15:57' ,`revised_user`='AJM' ,`sort_seq`='004' WHERE task_id_snr='mnu_task_field(list2)' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `revised_date`='2008-02-27 16:15:57' ,`revised_user`='AJM' ,`sort_seq`='003' WHERE task_id_snr='mnu_task_field(list2)' AND task_id_jnr='mnu_task_field(upd1)';

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Read' ,'2008-02-27 16:28:01' ,'AJM' ,'N' ,'N' ,'N' ,'ENQ1' ,'mnu_task_field(enq1).php' ,'MENU' ,'Enquire Task Field' ,'mnu_task_field(enq1)' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Read' ,'Y' ,'2008-02-27 16:28:34' ,'AJM' ,'005' ,'mnu_task_field(enq1)' ,'mnu_task_field(list2)');

UPDATE `mnu_nav_button` SET `revised_date`='2008-02-27 16:28:57' ,`revised_user`='AJM' ,`sort_seq`='003' WHERE task_id_snr='mnu_task_field(list2)' AND task_id_jnr='mnu_task_field(del1)';

UPDATE `mnu_nav_button` SET `revised_date`='2008-02-27 16:28:57' ,`revised_user`='AJM' ,`sort_seq`='004' WHERE task_id_snr='mnu_task_field(list2)' AND task_id_jnr='mnu_task_field(upd1)';

UPDATE `mnu_nav_button` SET `revised_date`='2008-02-27 16:28:57' ,`revised_user`='AJM' ,`sort_seq`='005' WHERE task_id_snr='mnu_task_field(list2)' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `revised_date`='2008-02-27 16:28:57' ,`revised_user`='AJM' ,`sort_seq`='002' WHERE task_id_snr='mnu_task_field(list2)' AND task_id_jnr='mnu_task_field(enq1)';

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Search' ,'2008-02-27 16:31:56' ,'AJM' ,'N' ,'N' ,'N' ,'SRCH' ,'mnu_task_field(search).php' ,'MENU' ,'Search Task Field' ,'mnu_task_field(search)' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Search' ,'N' ,'2008-02-27 16:32:16' ,'AJM' ,'006' ,'mnu_task_field(search)' ,'mnu_task_field(list2)');

UPDATE `mnu_nav_button` SET `revised_date`='2008-02-27 16:32:26' ,`revised_user`='AJM' ,`sort_seq`='006' WHERE task_id_snr='mnu_task_field(list2)' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `revised_date`='2008-02-27 16:32:27' ,`revised_user`='AJM' ,`sort_seq`='005' WHERE task_id_snr='mnu_task_field(list2)' AND task_id_jnr='mnu_task_field(search)';

UPDATE `mnu_nav_button` SET `revised_date`='2008-02-27 16:37:08' ,`revised_user`='AJM' ,`sort_seq`='004' WHERE task_id_snr='mnu_task_field(list2)' AND task_id_jnr='mnu_task_field(del1)';

UPDATE `mnu_nav_button` SET `revised_date`='2008-02-27 16:37:08' ,`revised_user`='AJM' ,`sort_seq`='003' WHERE task_id_snr='mnu_task_field(list2)' AND task_id_jnr='mnu_task_field(upd1)';
