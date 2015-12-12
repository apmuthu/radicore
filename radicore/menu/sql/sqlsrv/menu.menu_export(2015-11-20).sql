-- USE [menu];

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_desc, task_id, task_type, use_https) VALUES
('Saved Selection' ,'2015-11-20 09:23:26' ,'AJM' ,'N' ,'N' ,'N' ,'LIST1' ,'mnu_saved_selection(list1).php' ,'MENU' ,'List Saved Selection' ,'mnu_saved_selection(list1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_desc, task_id, task_type, use_https) VALUES
('New' ,'2015-11-20 09:23:26' ,'AJM' ,'N' ,'N' ,'N' ,'ADD1' ,'mnu_saved_selection(add1).php' ,'MENU' ,'Add Saved Selection' ,'mnu_saved_selection(add1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_desc, task_id, task_type, use_https) VALUES
('Read' ,'2015-11-20 09:23:27' ,'AJM' ,'N' ,'N' ,'N' ,'ENQ1' ,'mnu_saved_selection(enq1).php' ,'MENU' ,'Enquire Saved Selection' ,'mnu_saved_selection(enq1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_desc, task_id, task_type, use_https) VALUES
('Update' ,'2015-11-20 09:23:27' ,'AJM' ,'N' ,'N' ,'N' ,'UPD1' ,'mnu_saved_selection(upd1).php' ,'MENU' ,'Update Saved Selection' ,'mnu_saved_selection(upd1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_desc, task_id, task_type, use_https) VALUES
('Delete' ,'2015-11-20 09:23:28' ,'AJM' ,'N' ,'N' ,'N' ,'DEL1' ,'mnu_saved_selection(del1).php' ,'MENU' ,'Delete Saved Selection' ,'mnu_saved_selection(del1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_desc, task_id, task_type, use_https) VALUES
('Search' ,'2015-11-20 09:23:28' ,'AJM' ,'N' ,'N' ,'N' ,'SRCH' ,'mnu_saved_selection(search).php' ,'MENU' ,'Search Saved Selection' ,'mnu_saved_selection(search)' ,'PROC' ,'N');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('New' ,'N' ,'2015-11-20 09:23:28' ,'AJM' ,'001' ,'mnu_saved_selection(add1)' ,'mnu_saved_selection(list1)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Read' ,'Y' ,'2015-11-20 09:23:29' ,'AJM' ,'002' ,'mnu_saved_selection(enq1)' ,'mnu_saved_selection(list1)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Update' ,'Y' ,'2015-11-20 09:23:29' ,'AJM' ,'003' ,'mnu_saved_selection(upd1)' ,'mnu_saved_selection(list1)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Delete' ,'Y' ,'2015-11-20 09:23:29' ,'AJM' ,'004' ,'mnu_saved_selection(del1)' ,'mnu_saved_selection(list1)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Search' ,'N' ,'2015-11-20 09:23:29' ,'AJM' ,'005' ,'mnu_saved_selection(search)' ,'mnu_saved_selection(list1)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Audit Trail' ,'Y' ,'2015-11-20 09:23:30' ,'AJM' ,'006' ,'audit_dtl(list)3' ,'mnu_saved_selection(list1)');

INSERT INTO mnu_menu (button_text, created_date, created_user, menu_id, sort_seq, task_id_jnr) VALUES
('Saved Selection' ,'2015-11-20 09:23:30' ,'AJM' ,'menu' ,'001' ,'mnu_saved_selection(list1)');

DELETE FROM mnu_menu WHERE menu_id='menu' AND task_id_jnr='mnu_saved_selection(list1)';

INSERT INTO mnu_menu (button_text, created_date, created_user, menu_id, sort_seq, task_id_jnr) VALUES
('Saved Selection' ,'2015-11-20 09:25:59' ,'AJM' ,'menu01' ,'013' ,'mnu_saved_selection(list1)');

UPDATE mnu_task SET is_disabled='Y', revised_date='2015-11-20 10:26:24', revised_user='AJM' WHERE task_id='mnu_saved_selection(add1)';
