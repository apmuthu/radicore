USE `menu`;

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('COMPLETE' ,'2010-07-24 11:07:35' ,'AJM' ,'N' ,'N' ,'N' ,'OTHER' ,'mnu_todo(complete).php' ,'MENU' ,'Set selection criteria to COMPLETE' ,'mnu_todo(complete)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('INCOMPLETE' ,'2010-07-24 11:07:59' ,'AJM' ,'N' ,'N' ,'N' ,'OTHER' ,'mnu_todo(incomplete).php' ,'MENU' ,'Set selection criteria to INCOMPLETE' ,'mnu_todo(incomplete)' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('COMPLETE' ,'N' ,'2010-07-24 11:08:59' ,'AJM' ,'007' ,'mnu_todo(complete)' ,'mnu_todo(list1)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('INCOMPLETE' ,'N' ,'2010-07-24 11:09:20' ,'AJM' ,'008' ,'mnu_todo(incomplete)' ,'mnu_todo(list1)');

UPDATE `mnu_nav_button` SET `revised_date`='2010-07-24 11:09:39' ,`revised_user`='AJM' ,`sort_seq`='008' WHERE task_id_snr='mnu_todo(list1)' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `revised_date`='2010-07-24 11:09:39' ,`revised_user`='AJM' ,`sort_seq`='006' WHERE task_id_snr='mnu_todo(list1)' AND task_id_jnr='mnu_todo(complete)';

UPDATE `mnu_nav_button` SET `revised_date`='2010-07-24 11:09:39' ,`revised_user`='AJM' ,`sort_seq`='007' WHERE task_id_snr='mnu_todo(list1)' AND task_id_jnr='mnu_todo(incomplete)';

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('COMPLETE' ,'N' ,'2010-07-24 11:10:09' ,'AJM' ,'007' ,'mnu_todo(complete)' ,'mnu_todo(list2)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('INCOMPLETE' ,'N' ,'2010-07-24 11:10:25' ,'AJM' ,'008' ,'mnu_todo(incomplete)' ,'mnu_todo(list2)');

UPDATE `mnu_nav_button` SET `revised_date`='2010-07-24 11:10:52' ,`revised_user`='AJM' ,`sort_seq`='008' WHERE task_id_snr='mnu_todo(list2)' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `revised_date`='2010-07-24 11:10:53' ,`revised_user`='AJM' ,`sort_seq`='006' WHERE task_id_snr='mnu_todo(list2)' AND task_id_jnr='mnu_todo(complete)';

UPDATE `mnu_nav_button` SET `revised_date`='2010-07-24 11:10:53' ,`revised_user`='AJM' ,`sort_seq`='007' WHERE task_id_snr='mnu_todo(list2)' AND task_id_jnr='mnu_todo(incomplete)';
