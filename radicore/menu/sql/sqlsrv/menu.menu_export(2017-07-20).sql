-- USE [menu];

UPDATE mnu_task SET revised_date='2017-07-20 14:38:09', revised_user='AJM', selection_temp='curr_or_hist=''C''' WHERE task_id='mnu_user_role(list2)';

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Current' ,'N' ,'2017-07-20 14:39:04' ,'AJM' ,'007' ,'date(current)' ,'mnu_user_role(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Future' ,'N' ,'2017-07-20 14:39:04' ,'AJM' ,'008' ,'date(future)' ,'mnu_user_role(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Historic' ,'N' ,'2017-07-20 14:39:04' ,'AJM' ,'009' ,'date(historic)' ,'mnu_user_role(list2)');

UPDATE mnu_nav_button SET revised_date='2017-07-20 14:39:42', revised_user='AJM', sort_seq='009' WHERE task_id_snr='mnu_user_role(list2)' AND task_id_jnr='audit_dtl(list)3';

UPDATE mnu_nav_button SET revised_date='2017-07-20 14:39:42', revised_user='AJM', sort_seq='006' WHERE task_id_snr='mnu_user_role(list2)' AND task_id_jnr='date(current)';

UPDATE mnu_nav_button SET revised_date='2017-07-20 14:39:42', revised_user='AJM', sort_seq='007' WHERE task_id_snr='mnu_user_role(list2)' AND task_id_jnr='date(future)';

UPDATE mnu_nav_button SET revised_date='2017-07-20 14:39:43', revised_user='AJM', sort_seq='008' WHERE task_id_snr='mnu_user_role(list2)' AND task_id_jnr='date(historic)';

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_id, task_name, task_type, use_https) VALUES
('Move Down' ,'2017-07-20 15:01:44' ,'AJM' ,'N' ,'N' ,'N' ,'UPD4' ,'mnu_user_role(upd4)movedown.php' ,'MENU' ,'mnu_user_role(upd4)movedown' ,'Move Role Down' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_id, task_name, task_type, use_https) VALUES
('Move Up' ,'2017-07-20 15:02:40' ,'AJM' ,'N' ,'N' ,'N' ,'UPD4' ,'mnu_user_role(upd4)moveup.php' ,'MENU' ,'mnu_user_role(upd4)moveup' ,'Move Role Up' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_id, task_name, task_type, use_https) VALUES
('Resequence' ,'2017-07-20 15:03:37' ,'AJM' ,'N' ,'N' ,'N' ,'UPD4' ,'mnu_user_role(upd4)reseq.php' ,'MENU' ,'mnu_user_role(upd4)reseq' ,'Resequence User Roles' ,'PROC' ,'N');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Move Up' ,'Y' ,'2017-07-20 15:04:54' ,'AJM' ,'010' ,'mnu_user_role(upd4)moveup' ,'mnu_user_role(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Move Down' ,'Y' ,'2017-07-20 15:05:08' ,'AJM' ,'011' ,'mnu_user_role(upd4)movedown' ,'mnu_user_role(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Resequence' ,'N' ,'2017-07-20 15:05:08' ,'AJM' ,'012' ,'mnu_user_role(upd4)reseq' ,'mnu_user_role(list2)');

UPDATE mnu_nav_button SET revised_date='2017-07-20 15:05:33', revised_user='AJM', sort_seq='012' WHERE task_id_snr='mnu_user_role(list2)' AND task_id_jnr='audit_dtl(list)3';

UPDATE mnu_nav_button SET revised_date='2017-07-20 15:05:33', revised_user='AJM', sort_seq='009' WHERE task_id_snr='mnu_user_role(list2)' AND task_id_jnr='mnu_user_role(upd4)moveup';

UPDATE mnu_nav_button SET revised_date='2017-07-20 15:05:33', revised_user='AJM', sort_seq='010' WHERE task_id_snr='mnu_user_role(list2)' AND task_id_jnr='mnu_user_role(upd4)movedown';

UPDATE mnu_nav_button SET revised_date='2017-07-20 15:05:33', revised_user='AJM', sort_seq='011' WHERE task_id_snr='mnu_user_role(list2)' AND task_id_jnr='mnu_user_role(upd4)reseq';


-- 2017-07-24


UPDATE mnu_nav_button SET context_preselect='N', revised_date='2017-07-20 15:45:31', revised_user='AJM' WHERE task_id_snr='mnu_user_role(list2)' AND task_id_jnr='mnu_user_role(upd4)reseq';

UPDATE mnu_nav_button SET context_preselect='N', revised_date='2017-07-20 15:46:11', revised_user='AJM' WHERE task_id_snr='mnu_favourite(list2)' AND task_id_jnr='mnu_favourite(upd4)reseq';

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_id, task_name, task_type, use_https) VALUES
('Mnu Saved Selection' ,'2017-07-24 18:04:26' ,'AJM' ,'N' ,'N' ,'N' ,'LIST2' ,'mnu_saved_selection(list2).php' ,'MENU' ,'mnu_saved_selection(list2)' ,'List Mnu Saved Selection by Mnu User' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_id, task_name, task_type, use_https) VALUES
('New' ,'2017-07-24 18:04:28' ,'AJM' ,'N' ,'N' ,'N' ,'ADD2' ,'mnu_saved_selection(add2).php' ,'MENU' ,'mnu_saved_selection(add2)' ,'Add Mnu Saved Selection' ,'PROC' ,'N');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('New' ,'N' ,'2017-07-24 18:04:29' ,'AJM' ,'001' ,'mnu_saved_selection(add2)' ,'mnu_saved_selection(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Read' ,'Y' ,'2017-07-24 18:04:30' ,'AJM' ,'002' ,'mnu_saved_selection(enq1)' ,'mnu_saved_selection(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Update' ,'Y' ,'2017-07-24 18:04:31' ,'AJM' ,'003' ,'mnu_saved_selection(upd1)' ,'mnu_saved_selection(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Delete' ,'Y' ,'2017-07-24 18:04:31' ,'AJM' ,'004' ,'mnu_saved_selection(del1)' ,'mnu_saved_selection(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Search' ,'N' ,'2017-07-24 18:04:32' ,'AJM' ,'005' ,'mnu_saved_selection(search)' ,'mnu_saved_selection(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Audit Trail' ,'Y' ,'2017-07-24 18:04:33' ,'AJM' ,'006' ,'audit_dtl(list)3' ,'mnu_saved_selection(list2)');

UPDATE mnu_task SET button_text='Saved Selections', order_by='selection_id desc', revised_date='2017-07-24 18:07:20', revised_user='AJM', task_name='List Saved Selection by User' WHERE task_id='mnu_saved_selection(list2)';

DELETE FROM mnu_nav_button WHERE task_id_snr='mnu_saved_selection(list2)' AND task_id_jnr='mnu_saved_selection(add2)';

DELETE FROM mnu_task WHERE task_id='mnu_saved_selection(add2)';

DELETE FROM mnu_nav_button WHERE task_id_snr='mnu_saved_selection(list1)' AND task_id_jnr='mnu_saved_selection(add1)';

DELETE FROM mnu_task WHERE task_id='mnu_saved_selection(add1)';
