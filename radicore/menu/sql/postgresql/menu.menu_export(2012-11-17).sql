SET search_path = menu;

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('Help Text Alt' ,'2012-11-17 15:03:56' ,'AJM' ,'N' ,'N' ,'N' ,'LIST2' ,'help_text_alt(list2).php' ,'MENU' ,'List Help Text Alt by Mnu Task' ,'mnu_help_text_alt(list2)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('New' ,'2012-11-17 15:03:56' ,'AJM' ,'N' ,'N' ,'N' ,'ADD2' ,'help_text_alt(add2).php' ,'MENU' ,'Add Help Text Alt' ,'mnu_help_text_alt(add2)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('Read' ,'2012-11-17 15:03:56' ,'AJM' ,'N' ,'N' ,'N' ,'ENQ1' ,'help_text_alt(enq1).php' ,'MENU' ,'Enquire Help Text Alt' ,'mnu_help_text_alt(enq1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('Update' ,'2012-11-17 15:03:56' ,'AJM' ,'N' ,'N' ,'N' ,'UPD1' ,'help_text_alt(upd1).php' ,'MENU' ,'Update Help Text Alt' ,'mnu_help_text_alt(upd1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('Delete' ,'2012-11-17 15:03:57' ,'AJM' ,'N' ,'N' ,'N' ,'DEL1' ,'help_text_alt(del1).php' ,'MENU' ,'Delete Help Text Alt' ,'mnu_help_text_alt(del1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('Search' ,'2012-11-17 15:03:57' ,'AJM' ,'N' ,'N' ,'N' ,'SRCH' ,'help_text_alt(search).php' ,'MENU' ,'Search Help Text Alt' ,'mnu_help_text_alt(search)' ,'PROC' ,'N');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('New' ,'N' ,'2012-11-17 15:03:57' ,'AJM' ,'001' ,'mnu_help_text_alt(add2)' ,'mnu_help_text_alt(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Read' ,'Y' ,'2012-11-17 15:03:57' ,'AJM' ,'002' ,'mnu_help_text_alt(enq1)' ,'mnu_help_text_alt(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Update' ,'Y' ,'2012-11-17 15:03:57' ,'AJM' ,'003' ,'mnu_help_text_alt(upd1)' ,'mnu_help_text_alt(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Delete' ,'Y' ,'2012-11-17 15:03:58' ,'AJM' ,'004' ,'mnu_help_text_alt(del1)' ,'mnu_help_text_alt(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Search' ,'N' ,'2012-11-17 15:03:58' ,'AJM' ,'005' ,'mnu_help_text_alt(search)' ,'mnu_help_text_alt(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Audit Trail' ,'Y' ,'2012-11-17 15:03:58' ,'AJM' ,'006' ,'audit_dtl(list)3' ,'mnu_help_text_alt(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Help Text Alt' ,'Y' ,'2012-11-17 15:08:01' ,'AJM' ,'001' ,'mnu_help_text_alt(list2)' ,'mnu_help_text(multi1)');

UPDATE mnu_task SET button_text='Alternative Languages' ,revised_date='2012-11-17 15:10:44' ,revised_user='AJM' ,task_desc='Maintain Alternative Languages for HELP_TEXT' WHERE task_id='mnu_help_text_alt(list2)';

UPDATE mnu_nav_button SET button_text='Alternative Languages' ,revised_date='2012-11-17 15:11:08' ,revised_user='AJM' WHERE task_id_snr='mnu_help_text(multi1)' AND task_id_jnr='mnu_help_text_alt(list2)';

UPDATE mnu_task SET revised_date='2012-12-29 12:56:55' ,revised_user='AJM' ,task_desc='Add Help Text (Alternative Language)' WHERE task_id='mnu_help_text_alt(add2)';

UPDATE mnu_task SET revised_date='2012-12-29 12:57:04' ,revised_user='AJM' ,task_desc='Delete Help Text (Alternative Language)' WHERE task_id='mnu_help_text_alt(del1)';

UPDATE mnu_task SET revised_date='2012-12-29 12:57:14' ,revised_user='AJM' ,task_desc='Enquire Help Text (Alternative Language)' WHERE task_id='mnu_help_text_alt(enq1)';

UPDATE mnu_task SET revised_date='2012-12-29 12:57:26' ,revised_user='AJM' ,task_desc='Search Help Text (Alternative Language)' WHERE task_id='mnu_help_text_alt(search)';

UPDATE mnu_task SET revised_date='2012-12-29 12:57:36' ,revised_user='AJM' ,task_desc='Update Help Text (Alternative Language)' WHERE task_id='mnu_help_text_alt(upd1)';

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('Task (Alternative Language)' ,'2013-01-01 13:34:23' ,'AJM' ,'N' ,'N' ,'N' ,'LIST2' ,'mnu_task_alt(list2).php' ,'MENU' ,'List Mnu Task Alt by Mnu Task' ,'mnu_task_alt(list2)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('New' ,'2013-01-01 13:34:24' ,'AJM' ,'N' ,'N' ,'N' ,'ADD2' ,'mnu_task_alt(add2).php' ,'MENU' ,'Add Task (Alternative Language)' ,'mnu_task_alt(add2)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('Read' ,'2013-01-01 13:34:25' ,'AJM' ,'N' ,'N' ,'N' ,'ENQ1' ,'mnu_task_alt(enq1).php' ,'MENU' ,'Enquire Task (Alternative Language)' ,'mnu_task_alt(enq1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('Update' ,'2013-01-01 13:34:26' ,'AJM' ,'N' ,'N' ,'N' ,'UPD1' ,'mnu_task_alt(upd1).php' ,'MENU' ,'Update Task (Alternative Language)' ,'mnu_task_alt(upd1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('Delete' ,'2013-01-01 13:34:26' ,'AJM' ,'N' ,'N' ,'N' ,'DEL1' ,'mnu_task_alt(del1).php' ,'MENU' ,'Delete Task (Alternative Language)' ,'mnu_task_alt(del1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('Search' ,'2013-01-01 13:34:27' ,'AJM' ,'N' ,'N' ,'N' ,'SRCH' ,'mnu_task_alt(search).php' ,'MENU' ,'Search Task (Alternative Language)' ,'mnu_task_alt(search)' ,'PROC' ,'N');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('New' ,'N' ,'2013-01-01 13:34:28' ,'AJM' ,'001' ,'mnu_task_alt(add2)' ,'mnu_task_alt(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Read' ,'Y' ,'2013-01-01 13:34:28' ,'AJM' ,'002' ,'mnu_task_alt(enq1)' ,'mnu_task_alt(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Update' ,'Y' ,'2013-01-01 13:34:28' ,'AJM' ,'003' ,'mnu_task_alt(upd1)' ,'mnu_task_alt(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Delete' ,'Y' ,'2013-01-01 13:34:28' ,'AJM' ,'004' ,'mnu_task_alt(del1)' ,'mnu_task_alt(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Search' ,'N' ,'2013-01-01 13:34:28' ,'AJM' ,'005' ,'mnu_task_alt(search)' ,'mnu_task_alt(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Audit Trail' ,'Y' ,'2013-01-01 13:34:29' ,'AJM' ,'006' ,'audit_dtl(list)3' ,'mnu_task_alt(list2)');

UPDATE mnu_task SET revised_date='2013-01-01 13:37:28' ,revised_user='AJM' ,task_desc='Maintain Alternative Languages for TASK' WHERE task_id='mnu_task_alt(list2)';

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Task (Alternative Language)' ,'Y' ,'2013-01-01 13:39:52' ,'AJM' ,'025' ,'mnu_task_alt(list2)' ,'mnu_task(list1)');

UPDATE mnu_nav_button SET revised_date='2013-01-01 13:40:04' ,revised_user='AJM' ,sort_seq='025' WHERE task_id_snr='mnu_task(list1)' AND task_id_jnr='audit_dtl(list)3';

UPDATE mnu_nav_button SET revised_date='2013-01-01 13:40:04' ,revised_user='AJM' ,sort_seq='024' WHERE task_id_snr='mnu_task(list1)' AND task_id_jnr='mnu_task_alt(list2)';

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Task (Alternative Language)' ,'Y' ,'2013-01-01 13:40:26' ,'AJM' ,'023' ,'mnu_task_alt(list2)' ,'mnu_task(list1)a');

UPDATE mnu_nav_button SET revised_date='2013-01-01 13:40:38' ,revised_user='AJM' ,sort_seq='023' WHERE task_id_snr='mnu_task(list1)a' AND task_id_jnr='audit_dtl(list)3';

UPDATE mnu_nav_button SET revised_date='2013-01-01 13:40:38' ,revised_user='AJM' ,sort_seq='023' WHERE task_id_snr='mnu_task(list1)a' AND task_id_jnr='audit_dtl(list)3';

UPDATE mnu_nav_button SET revised_date='2013-01-01 13:40:38' ,revised_user='AJM' ,sort_seq='022' WHERE task_id_snr='mnu_task(list1)a' AND task_id_jnr='mnu_task_alt(list2)';

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Task (Alternative Language)' ,'Y' ,'2013-01-01 13:40:53' ,'AJM' ,'016' ,'mnu_task_alt(list2)' ,'mnu_task(list1)b');

UPDATE mnu_nav_button SET revised_date='2013-01-01 13:41:25' ,revised_user='AJM' ,sort_seq='016' WHERE task_id_snr='mnu_task(list1)b' AND task_id_jnr='audit_dtl(list)3';

UPDATE mnu_nav_button SET revised_date='2013-01-01 13:41:25' ,revised_user='AJM' ,sort_seq='013' WHERE task_id_snr='mnu_task(list1)b' AND task_id_jnr='mnu_task(pdf)';

UPDATE mnu_nav_button SET revised_date='2013-01-01 13:41:25' ,revised_user='AJM' ,sort_seq='014' WHERE task_id_snr='mnu_task(list1)b' AND task_id_jnr='mnu_task(pdf)2';

UPDATE mnu_nav_button SET revised_date='2013-01-01 13:41:25' ,revised_user='AJM' ,sort_seq='015' WHERE task_id_snr='mnu_task(list1)b' AND task_id_jnr='mnu_task_alt(list2)';

UPDATE mnu_nav_button SET button_text='Alternative Languages' ,revised_date='2013-01-01 13:42:16' ,revised_user='AJM' WHERE task_id_snr='mnu_task(list1)' AND task_id_jnr='mnu_task_alt(list2)';

UPDATE mnu_nav_button SET button_text='Alternative Languages' ,revised_date='2013-01-01 13:42:28' ,revised_user='AJM' WHERE task_id_snr='mnu_task(list1)a' AND task_id_jnr='mnu_task_alt(list2)';

UPDATE mnu_nav_button SET button_text='Alternative Languages' ,revised_date='2013-01-01 13:42:40' ,revised_user='AJM' WHERE task_id_snr='mnu_task(list1)b' AND task_id_jnr='mnu_task_alt(list2)';

UPDATE mnu_task SET button_text='Alternative Languages' ,revised_date='2013-01-01 13:43:09' ,revised_user='AJM' WHERE task_id='mnu_task_alt(list2)';
