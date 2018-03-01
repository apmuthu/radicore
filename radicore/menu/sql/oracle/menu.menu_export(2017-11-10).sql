ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
SET SCAN OFF;

-- ALTER SESSION SET CURRENT_SCHEMA = "MENU";

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_id, task_name, task_type, use_https) VALUES
('All Dates' ,'2017-11-10 10:11:40' ,'AJM' ,'N' ,'N' ,'N' ,'OTHER' ,'date_all.php' ,'MISC' ,'date(all)' ,'Select Records with All Dates' ,'PROC' ,'N');

INSERT INTO mnu_role_task (created_date, created_user, role_id, task_id) VALUES
('2017-11-10 10:16:23' ,'AJM' ,'MENU-RO' ,'date(all)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('All Dates' ,'N' ,'2017-11-10 11:42:56' ,'AJM' ,'009' ,'date(all)' ,'mnu_motd(list1)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('All Dates' ,'N' ,'2017-11-10 14:06:18' ,'AJM' ,'013' ,'date(all)' ,'mnu_user_role(list2)');

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:06:49', revised_user='AJM', sort_seq='010' WHERE task_id_snr='mnu_user_role(list2)' AND task_id_jnr='mnu_user_role(upd4)moveup';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:06:49', revised_user='AJM', sort_seq='011' WHERE task_id_snr='mnu_user_role(list2)' AND task_id_jnr='mnu_user_role(upd4)movedown';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:06:49', revised_user='AJM', sort_seq='012' WHERE task_id_snr='mnu_user_role(list2)' AND task_id_jnr='mnu_user_role(upd4)reseq';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:06:49', revised_user='AJM', sort_seq='013' WHERE task_id_snr='mnu_user_role(list2)' AND task_id_jnr='audit_dtl(list)3';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:06:49', revised_user='AJM', sort_seq='009' WHERE task_id_snr='mnu_user_role(list2)' AND task_id_jnr='date(all)';

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('All Dates' ,'N' ,'2017-11-10 14:09:48' ,'AJM' ,'011' ,'date(all)' ,'wf_case(list)');

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:10:24', revised_user='AJM', sort_seq='005' WHERE task_id_snr='wf_case(list)' AND task_id_jnr='wf_case(enq)';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:10:24', revised_user='AJM', sort_seq='006' WHERE task_id_snr='wf_case(list)' AND task_id_jnr='wf_token(list)2';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:10:24', revised_user='AJM', sort_seq='007' WHERE task_id_snr='wf_case(list)' AND task_id_jnr='wf_workitem(list)2';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:10:25', revised_user='AJM', sort_seq='008' WHERE task_id_snr='wf_case(list)' AND task_id_jnr='wf_case(upd1)a';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:10:25', revised_user='AJM', sort_seq='009' WHERE task_id_snr='wf_case(list)' AND task_id_jnr='wf_case(upd1)b';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:10:25', revised_user='AJM', sort_seq='010' WHERE task_id_snr='wf_case(list)' AND task_id_jnr='wf_case(upd1)c';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:10:25', revised_user='AJM', sort_seq='011' WHERE task_id_snr='wf_case(list)' AND task_id_jnr='audit_dtl(list)3';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:10:25', revised_user='AJM', sort_seq='004' WHERE task_id_snr='wf_case(list)' AND task_id_jnr='date(all)';

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('All Dates' ,'N' ,'2017-11-10 14:11:15' ,'AJM' ,'011' ,'date(all)' ,'wf_case(list)2');

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:11:59', revised_user='AJM', sort_seq='006' WHERE task_id_snr='wf_case(list)2' AND task_id_jnr='wf_token(list)2';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:12:00', revised_user='AJM', sort_seq='007' WHERE task_id_snr='wf_case(list)2' AND task_id_jnr='wf_workitem(list)2';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:12:00', revised_user='AJM', sort_seq='008' WHERE task_id_snr='wf_case(list)2' AND task_id_jnr='wf_case(upd1)a';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:12:00', revised_user='AJM', sort_seq='009' WHERE task_id_snr='wf_case(list)2' AND task_id_jnr='wf_case(upd1)b';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:12:00', revised_user='AJM', sort_seq='010' WHERE task_id_snr='wf_case(list)2' AND task_id_jnr='wf_case(upd1)c';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:12:00', revised_user='AJM', sort_seq='011' WHERE task_id_snr='wf_case(list)2' AND task_id_jnr='audit_dtl(list)3';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:12:00', revised_user='AJM', sort_seq='005' WHERE task_id_snr='wf_case(list)2' AND task_id_jnr='date(all)';

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('All Dates' ,'N' ,'2017-11-10 14:13:34' ,'AJM' ,'015' ,'date(all)' ,'wf_workflow(list)');

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:14:06', revised_user='AJM', sort_seq='013' WHERE task_id_snr='wf_workflow(list)' AND task_id_jnr='wf_case(list)2';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:14:06', revised_user='AJM', sort_seq='014' WHERE task_id_snr='wf_workflow(list)' AND task_id_jnr='audit_dtl(list)3';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:14:06', revised_user='AJM', sort_seq='015' WHERE task_id_snr='wf_workflow(list)' AND task_id_jnr='audit_dtl(list)3exact';

UPDATE mnu_nav_button SET revised_date='2017-11-10 14:14:06', revised_user='AJM', sort_seq='012' WHERE task_id_snr='wf_workflow(list)' AND task_id_jnr='date(all)';
