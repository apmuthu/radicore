USE `menu`;

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Message of the Day' ,'2009-05-05 11:36:55' ,'AJM' ,'N' ,'N' ,'N' ,'LIST1' ,'mnu_motd(list1).php' ,'MENU' ,'List Message of the Day' ,'mnu_motd(list1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('New' ,'2009-05-05 11:36:55' ,'AJM' ,'N' ,'N' ,'N' ,'ADD1' ,'mnu_motd(add1).php' ,'MENU' ,'Add Message of the Day' ,'mnu_motd(add1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Read' ,'2009-05-05 11:36:56' ,'AJM' ,'N' ,'N' ,'N' ,'ENQ1' ,'mnu_motd(enq1).php' ,'MENU' ,'Enquire Message of the Day' ,'mnu_motd(enq1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Update' ,'2009-05-05 11:36:56' ,'AJM' ,'N' ,'N' ,'N' ,'UPD1' ,'mnu_motd(upd1).php' ,'MENU' ,'Update Message of the Day' ,'mnu_motd(upd1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Delete' ,'2009-05-05 11:36:57' ,'AJM' ,'N' ,'N' ,'N' ,'DEL1' ,'mnu_motd(del1).php' ,'MENU' ,'Delete Message of the Day' ,'mnu_motd(del1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Search' ,'2009-05-05 11:36:57' ,'AJM' ,'N' ,'N' ,'N' ,'SRCH' ,'mnu_motd(search).php' ,'MENU' ,'Search Message of the Day' ,'mnu_motd(search)' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('New' ,'N' ,'2009-05-05 11:36:58' ,'AJM' ,'001' ,'mnu_motd(add1)' ,'mnu_motd(list1)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Read' ,'Y' ,'2009-05-05 11:36:58' ,'AJM' ,'002' ,'mnu_motd(enq1)' ,'mnu_motd(list1)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Update' ,'Y' ,'2009-05-05 11:36:58' ,'AJM' ,'003' ,'mnu_motd(upd1)' ,'mnu_motd(list1)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Delete' ,'Y' ,'2009-05-05 11:36:59' ,'AJM' ,'004' ,'mnu_motd(del1)' ,'mnu_motd(list1)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Search' ,'N' ,'2009-05-05 11:36:59' ,'AJM' ,'005' ,'mnu_motd(search)' ,'mnu_motd(list1)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Audit Trail' ,'Y' ,'2009-05-05 11:36:59' ,'AJM' ,'006' ,'audit_dtl(list)3' ,'mnu_motd(list1)');

UPDATE `mnu_task` SET `button_text`='MOTD' ,`revised_date`='2009-05-05 11:40:03' ,`revised_user`='AJM' WHERE task_id='mnu_motd(list1)';

REPLACE INTO `mnu_menu` (`button_text` ,`created_date` ,`created_user` ,`menu_id` ,`sort_seq` ,`task_id_jnr`) VALUES
('MOTD' ,'2009-05-05 11:40:28' ,'AJM' ,'menu01' ,'012' ,'mnu_motd(list1)');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('MOTD' ,'2009-05-05 17:32:47' ,'AJM' ,'N' ,'N' ,'N' ,'ENQ1' ,'mnu_motd(show).php' ,'MENU' ,'Show Message of the Day' ,'mnu_motd(show)' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('MOTD' ,'Y' ,'2009-05-05 17:34:29' ,'AJM' ,'008' ,'mnu_motd(show)' ,'menu');

UPDATE `mnu_nav_button` SET `context_preselect`='N' ,`revised_date`='2009-05-05 17:34:53' ,`revised_user`='AJM' WHERE task_id_snr='menu' AND task_id_jnr='mnu_motd(show)';

DELETE FROM `mnu_nav_button` WHERE task_id_snr='menu' AND task_id_jnr='mnu_motd(show)';

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('MOTD' ,'N' ,'2009-05-05 18:24:05' ,'AJM' ,'008' ,'mnu_motd(list1)' ,'menu');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Current' ,'N' ,'2009-05-06 10:30:33' ,'AJM' ,'007' ,'date(current)' ,'mnu_motd(list1)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Historic' ,'N' ,'2009-05-06 10:30:34' ,'AJM' ,'008' ,'date(historic)' ,'mnu_motd(list1)');

UPDATE `mnu_task` SET `revised_date`='2009-05-06 10:32:00' ,`revised_user`='AJM' ,`selection_temp`='curr_or_hist=\'C\'' WHERE task_id='mnu_motd(list1)';
