USE `menu`;

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Favourites' ,'2010-07-20 10:30:47' ,'AJM' ,'N' ,'N' ,'N' ,'LIST2' ,'mnu_favourite(list2).php' ,'MENU' ,'List mnu_favourite by mnu_user' ,'mnu_favourite(list2)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('New' ,'2010-07-20 10:30:48' ,'AJM' ,'N' ,'N' ,'N' ,'ADD2' ,'mnu_favourite(add2).php' ,'MENU' ,'Add Favourites' ,'mnu_favourite(add2)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Read' ,'2010-07-20 10:30:51' ,'AJM' ,'N' ,'N' ,'N' ,'ENQ1' ,'mnu_favourite(enq1).php' ,'MENU' ,'Enquire Favourites' ,'mnu_favourite(enq1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Update' ,'2010-07-20 10:30:53' ,'AJM' ,'N' ,'N' ,'N' ,'UPD1' ,'mnu_favourite(upd1).php' ,'MENU' ,'Update Favourites' ,'mnu_favourite(upd1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Delete' ,'2010-07-20 10:30:55' ,'AJM' ,'N' ,'N' ,'N' ,'DEL1' ,'mnu_favourite(del1).php' ,'MENU' ,'Delete Favourites' ,'mnu_favourite(del1)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Search' ,'2010-07-20 10:30:56' ,'AJM' ,'N' ,'N' ,'N' ,'SRCH' ,'mnu_favourite(search).php' ,'MENU' ,'Search Favourites' ,'mnu_favourite(search)' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('New' ,'N' ,'2010-07-20 10:30:56' ,'AJM' ,'001' ,'mnu_favourite(add2)' ,'mnu_favourite(list2)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Read' ,'Y' ,'2010-07-20 10:30:58' ,'AJM' ,'002' ,'mnu_favourite(enq1)' ,'mnu_favourite(list2)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Update' ,'Y' ,'2010-07-20 10:30:58' ,'AJM' ,'003' ,'mnu_favourite(upd1)' ,'mnu_favourite(list2)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Delete' ,'Y' ,'2010-07-20 10:30:59' ,'AJM' ,'004' ,'mnu_favourite(del1)' ,'mnu_favourite(list2)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Search' ,'N' ,'2010-07-20 10:31:00' ,'AJM' ,'005' ,'mnu_favourite(search)' ,'mnu_favourite(list2)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Audit Trail' ,'Y' ,'2010-07-20 10:31:00' ,'AJM' ,'006' ,'audit_dtl(list)3' ,'mnu_favourite(list2)');

UPDATE `mnu_task` SET `revised_date`='2010-07-20 10:33:25' ,`revised_user`='AJM' ,`task_desc`='List Favourites by User' WHERE task_id='mnu_favourite(list2)';

UPDATE `mnu_task` SET `button_text`='List Favourites' ,`revised_date`='2010-07-20 10:35:05' ,`revised_user`='AJM' WHERE task_id='mnu_favourite(list2)';

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('List Favourites' ,'Y' ,'2010-07-20 10:35:15' ,'AJM' ,'010' ,'mnu_favourite(list2)' ,'menu');

UPDATE `mnu_nav_button` SET `button_text`='IP Address' ,`revised_date`='2010-07-20 10:55:48' ,`revised_user`='AJM' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='mnu_user_ip_address(list2)';

UPDATE `mnu_nav_button` SET `button_text`='Email Signature' ,`revised_date`='2010-07-20 10:55:48' ,`revised_user`='AJM' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='py_email_signature(multi1)';

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('List Favourites' ,'Y' ,'2010-07-20 10:56:02' ,'AJM' ,'014' ,'mnu_favourite(list2)' ,'mnu_user(list1)');

UPDATE `mnu_nav_button` SET `revised_date`='2010-07-20 10:56:18' ,`revised_user`='AJM' ,`sort_seq`='014' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `button_text`='Favourites' ,`revised_date`='2010-07-20 10:56:19' ,`revised_user`='AJM' ,`sort_seq`='013' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='mnu_favourite(list2)';

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Update' ,'2010-07-20 14:20:30' ,'AJM' ,'N' ,'N' ,'N' ,'UPD4' ,'mnu_favourite(upd4)moveup.php' ,'MENU' ,'Update Favourites' ,'mnu_favourite(upd4)moveup' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Update' ,'2010-07-20 14:31:43' ,'AJM' ,'N' ,'N' ,'N' ,'UPD4' ,'mnu_favourite(upd4)movedown.php' ,'MENU' ,'Update Favourites' ,'mnu_favourite(upd4)movedown' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Update' ,'Y' ,'2010-07-20 14:32:55' ,'AJM' ,'007' ,'mnu_favourite(upd4)movedown' ,'mnu_favourite(list2)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Update' ,'Y' ,'2010-07-20 14:32:56' ,'AJM' ,'008' ,'mnu_favourite(upd4)moveup' ,'mnu_favourite(list2)');

UPDATE `mnu_nav_button` SET `revised_date`='2010-07-20 14:33:26' ,`revised_user`='AJM' ,`sort_seq`='008' WHERE task_id_snr='mnu_favourite(list2)' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `button_text`='Move Down' ,`revised_date`='2010-07-20 14:33:26' ,`revised_user`='AJM' WHERE task_id_snr='mnu_favourite(list2)' AND task_id_jnr='mnu_favourite(upd4)movedown';

UPDATE `mnu_nav_button` SET `button_text`='Move Up' ,`revised_date`='2010-07-20 14:33:26' ,`revised_user`='AJM' ,`sort_seq`='006' WHERE task_id_snr='mnu_favourite(list2)' AND task_id_jnr='mnu_favourite(upd4)moveup';

UPDATE `mnu_task` SET `button_text`='Move Down' ,`revised_date`='2010-07-20 14:34:14' ,`revised_user`='AJM' ,`task_desc`='Move Favourite Down' WHERE task_id='mnu_favourite(upd4)movedown';

UPDATE `mnu_task` SET `button_text`='Move Up' ,`revised_date`='2010-07-20 14:34:34' ,`revised_user`='AJM' ,`task_desc`='Move Favourite Up' WHERE task_id='mnu_favourite(upd4)moveup';

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Resequence' ,'2010-07-20 15:54:42' ,'AJM' ,'N' ,'N' ,'N' ,'UPD4' ,'mnu_favourite(upd4)reseq.php' ,'MENU' ,'Resequence Favourites' ,'mnu_favourite(upd4)reseq' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Resequence' ,'Y' ,'2010-07-20 15:55:09' ,'AJM' ,'009' ,'mnu_favourite(upd4)reseq' ,'mnu_favourite(list2)');

UPDATE `mnu_nav_button` SET `revised_date`='2010-07-20 15:55:21' ,`revised_user`='AJM' ,`sort_seq`='009' WHERE task_id_snr='mnu_favourite(list2)' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `revised_date`='2010-07-20 15:55:22' ,`revised_user`='AJM' ,`sort_seq`='008' WHERE task_id_snr='mnu_favourite(list2)' AND task_id_jnr='mnu_favourite(upd4)reseq';

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`settings` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Favourites' ,'2010-07-21 10:18:52' ,'AJM' ,'N' ,'N' ,'N' ,'LIST1' ,'mnu_favourite(list1)display.php' ,'columns=5' ,'MENU' ,'Display Favourites by User' ,'mnu_favourite(list1)display' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Favourites' ,'N' ,'2010-07-21 10:19:32' ,'AJM' ,'011' ,'mnu_favourite(list1)display' ,'menu');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('New' ,'2010-07-30 11:38:34' ,'AJM' ,'N' ,'N' ,'N' ,'ADD4' ,'mnu_favourite(add4).php' ,'MENU' ,'Add Favourites' ,'mnu_favourite(add4)' ,'PROC' ,'N');

UPDATE `mnu_task` SET `revised_date`='2010-07-30 11:39:45' ,`revised_user`='AJM' ,`task_desc`='Add Initial Favourites' WHERE task_id='mnu_favourite(add4)';

UPDATE `mnu_task` SET `revised_date`='2010-07-30 12:06:08' ,`revised_user`='AJM' ,`task_desc`='Add Default Favourites' WHERE task_id='mnu_favourite(add4)';

REPLACE INTO `mnu_favourite` (`created_date` ,`created_user` ,`seq_no` ,`sort_seq` ,`task_desc` ,`task_id` ,`user_id`) VALUES
('2010-07-30 14:02:50' ,'AJM' ,'1' ,'1' ,'List Favourites by User' ,'mnu_favourite(list2)' ,'AJM');

REPLACE INTO `mnu_favourite` (`created_date` ,`created_user` ,`seq_no` ,`sort_seq` ,`task_desc` ,`task_id` ,`user_id`) VALUES
('2010-07-30 14:03:39' ,'AJM' ,'2' ,'2' ,'Change User Password' ,'mnu_user(upd1)a' ,'AJM');

REPLACE INTO `mnu_favourite` (`created_date` ,`created_user` ,`seq_no` ,`sort_seq` ,`task_desc` ,`task_id` ,`user_id`) VALUES
('2010-07-30 14:03:54' ,'AJM' ,'3' ,'3' ,'List ToDo by User' ,'mnu_todo(list2)' ,'AJM');

REPLACE INTO `mnu_favourite` (`created_date` ,`created_user` ,`seq_no` ,`sort_seq` ,`task_desc` ,`task_id` ,`user_id`) VALUES
('2010-07-30 14:04:08' ,'AJM' ,'4' ,'4' ,'List Message of the Day' ,'mnu_motd(list1)' ,'AJM');

DELETE FROM `mnu_nav_button` WHERE task_id_snr='menu' AND task_id_jnr='mnu_todo(list2)';

DELETE FROM `mnu_nav_button` WHERE task_id_snr='menu' AND task_id_jnr='mnu_user(upd1)a';

DELETE FROM `mnu_nav_button` WHERE task_id_snr='menu' AND task_id_jnr='wrk_timesheet(list2)';

DELETE FROM `mnu_nav_button` WHERE task_id_snr='menu' AND task_id_jnr='mnu_motd(list1)';

DELETE FROM `mnu_nav_button` WHERE task_id_snr='menu' AND task_id_jnr='mnu_favourite(list1)display';

DELETE FROM `help_text` WHERE task_id='mnu_favourite(list1)display';

DELETE FROM `mnu_role_task` WHERE role_id='DEMO' AND task_id='mnu_favourite(list1)display';

DELETE FROM `mnu_task` WHERE task_id='mnu_favourite(list1)display';
