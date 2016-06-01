-- SET search_path TO "menu";

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_desc, task_id, task_type, use_https) VALUES
('Mnu Task Quicksearch' ,'2016-05-18 15:24:39' ,'AJM' ,'N' ,'N' ,'N' ,'LIST2' ,'mnu_task_quicksearch(list2).php' ,'MENU' ,'List Mnu Task Quicksearch by Mnu Task' ,'mnu_task_quicksearch(list2)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_desc, task_id, task_type, use_https) VALUES
('New' ,'2016-05-18 15:24:40' ,'AJM' ,'N' ,'N' ,'N' ,'ADD2' ,'mnu_task_quicksearch(add2).php' ,'MENU' ,'Add Identifies the QuickSearch options for a task' ,'mnu_task_quicksearch(add2)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_desc, task_id, task_type, use_https) VALUES
('Read' ,'2016-05-18 15:24:41' ,'AJM' ,'N' ,'N' ,'N' ,'ENQ1' ,'mnu_task_quicksearch(enq1).php' ,'MENU' ,'Enquire Identifies the QuickSearch options for a task' ,'mnu_task_quicksearch(enq1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_desc, task_id, task_type, use_https) VALUES
('Update' ,'2016-05-18 15:24:42' ,'AJM' ,'N' ,'N' ,'N' ,'UPD1' ,'mnu_task_quicksearch(upd1).php' ,'MENU' ,'Update Mnu Task Quicksearch' ,'mnu_task_quicksearch(upd1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_desc, task_id, task_type, use_https) VALUES
('Delete' ,'2016-05-18 15:24:43' ,'AJM' ,'N' ,'N' ,'N' ,'DEL1' ,'mnu_task_quicksearch(del1).php' ,'MENU' ,'Delete Identifies the QuickSearch options for a task' ,'mnu_task_quicksearch(del1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_desc, task_id, task_type, use_https) VALUES
('Search' ,'2016-05-18 15:24:43' ,'AJM' ,'N' ,'N' ,'N' ,'SRCH' ,'mnu_task_quicksearch(search).php' ,'MENU' ,'Search Mnu Task Quicksearch' ,'mnu_task_quicksearch(search)' ,'PROC' ,'N');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('New' ,'N' ,'2016-05-18 15:24:44' ,'AJM' ,'001' ,'mnu_task_quicksearch(add2)' ,'mnu_task_quicksearch(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Read' ,'Y' ,'2016-05-18 15:24:45' ,'AJM' ,'002' ,'mnu_task_quicksearch(enq1)' ,'mnu_task_quicksearch(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Update' ,'Y' ,'2016-05-18 15:24:45' ,'AJM' ,'003' ,'mnu_task_quicksearch(upd1)' ,'mnu_task_quicksearch(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Delete' ,'Y' ,'2016-05-18 15:24:46' ,'AJM' ,'004' ,'mnu_task_quicksearch(del1)' ,'mnu_task_quicksearch(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Search' ,'N' ,'2016-05-18 15:24:46' ,'AJM' ,'005' ,'mnu_task_quicksearch(search)' ,'mnu_task_quicksearch(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Audit Trail' ,'Y' ,'2016-05-18 15:24:47' ,'AJM' ,'006' ,'audit_dtl(list)3' ,'mnu_task_quicksearch(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Mnu Task Quicksearch' ,'Y' ,'2016-05-18 15:27:55' ,'AJM' ,'024' ,'mnu_task_quicksearch(list2)' ,'mnu_task(list1)a');

UPDATE mnu_nav_button SET revised_date='2016-05-18 15:28:24', revised_user='AJM', sort_seq='024' WHERE task_id_snr='mnu_task(list1)a' AND task_id_jnr='audit_dtl(list)3';

UPDATE mnu_nav_button SET button_text='Quicksearch', revised_date='2016-05-18 15:28:24', revised_user='AJM', sort_seq='023' WHERE task_id_snr='mnu_task(list1)a' AND task_id_jnr='mnu_task_quicksearch(list2)';

UPDATE mnu_task SET button_text='Quicksearch', revised_date='2016-05-18 15:28:59', revised_user='AJM', task_desc='List Quicksearch options for a Task' WHERE task_id='mnu_task_quicksearch(list2)';

UPDATE mnu_task SET revised_date='2016-05-18 15:29:35', revised_user='AJM', task_desc='Search Quicksearch options' WHERE task_id='mnu_task_quicksearch(search)';

UPDATE mnu_task SET revised_date='2016-05-18 15:29:50', revised_user='AJM', task_desc='Update Quicksearch option' WHERE task_id='mnu_task_quicksearch(upd1)';

UPDATE mnu_task SET revised_date='2016-05-18 15:30:39', revised_user='AJM', task_desc='Add QuickSearch option' WHERE task_id='mnu_task_quicksearch(add2)';

UPDATE mnu_task SET revised_date='2016-05-18 15:30:54', revised_user='AJM', task_desc='Delete QuickSearch option' WHERE task_id='mnu_task_quicksearch(del1)';

UPDATE mnu_task SET revised_date='2016-05-18 15:31:08', revised_user='AJM', task_desc='Enquire QuickSearch option' WHERE task_id='mnu_task_quicksearch(enq1)';

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Quicksearch' ,'Y' ,'2016-05-18 15:31:41' ,'AJM' ,'006' ,'mnu_task_quicksearch(list2)' ,'mnu_task(list2)a');

UPDATE mnu_nav_button SET revised_date='2016-05-18 15:32:24', revised_user='AJM', sort_seq='006' WHERE task_id_snr='mnu_task(list2)a' AND task_id_jnr='audit_dtl(list)3';

UPDATE mnu_nav_button SET revised_date='2016-05-18 15:32:24', revised_user='AJM', sort_seq='004' WHERE task_id_snr='mnu_task(list2)a' AND task_id_jnr='mnu_task(pdf)';

UPDATE mnu_nav_button SET revised_date='2016-05-18 15:32:24', revised_user='AJM', sort_seq='005' WHERE task_id_snr='mnu_task(list2)a' AND task_id_jnr='mnu_task_quicksearch(list2)';


INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_desc, task_id, task_type, use_https) VALUES
('Mnu Task Quicksearch Alt' ,'2016-05-19 09:11:56' ,'AJM' ,'N' ,'N' ,'N' ,'LIST2' ,'mnu_task_quicksearch_alt(list2).php' ,'MENU' ,'List Mnu Task Quicksearch Alt by Mnu Task Quicksearch' ,'mnu_task_quicksearch_alt(list2)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_desc, task_id, task_type, use_https) VALUES
('New' ,'2016-05-19 09:11:57' ,'AJM' ,'N' ,'N' ,'N' ,'ADD2' ,'mnu_task_quicksearch_alt(add2).php' ,'MENU' ,'Add Identifies the QuickSearch options for a task in alternative languages' ,'mnu_task_quicksearch_alt(add2)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_desc, task_id, task_type, use_https) VALUES
('Read' ,'2016-05-19 09:11:58' ,'AJM' ,'N' ,'N' ,'N' ,'ENQ1' ,'mnu_task_quicksearch_alt(enq1).php' ,'MENU' ,'Enquire Identifies the QuickSearch options for a task in alternative languages' ,'mnu_task_quicksearch_alt(enq1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_desc, task_id, task_type, use_https) VALUES
('Update' ,'2016-05-19 09:11:59' ,'AJM' ,'N' ,'N' ,'N' ,'UPD1' ,'mnu_task_quicksearch_alt(upd1).php' ,'MENU' ,'Update Mnu Task Quicksearch Alt' ,'mnu_task_quicksearch_alt(upd1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_desc, task_id, task_type, use_https) VALUES
('Delete' ,'2016-05-19 09:12:01' ,'AJM' ,'N' ,'N' ,'N' ,'DEL1' ,'mnu_task_quicksearch_alt(del1).php' ,'MENU' ,'Delete Identifies the QuickSearch options for a task in alternative languages' ,'mnu_task_quicksearch_alt(del1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text, created_date, created_user, is_disabled, keep_data, log_sql_query, pattern_id, script_id, subsys_id, task_desc, task_id, task_type, use_https) VALUES
('Search' ,'2016-05-19 09:12:02' ,'AJM' ,'N' ,'N' ,'N' ,'SRCH' ,'mnu_task_quicksearch_alt(search).php' ,'MENU' ,'Search Mnu Task Quicksearch Alt' ,'mnu_task_quicksearch_alt(search)' ,'PROC' ,'N');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('New' ,'N' ,'2016-05-19 09:12:03' ,'AJM' ,'001' ,'mnu_task_quicksearch_alt(add2)' ,'mnu_task_quicksearch_alt(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Read' ,'Y' ,'2016-05-19 09:12:04' ,'AJM' ,'002' ,'mnu_task_quicksearch_alt(enq1)' ,'mnu_task_quicksearch_alt(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Update' ,'Y' ,'2016-05-19 09:12:04' ,'AJM' ,'003' ,'mnu_task_quicksearch_alt(upd1)' ,'mnu_task_quicksearch_alt(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Delete' ,'Y' ,'2016-05-19 09:12:05' ,'AJM' ,'004' ,'mnu_task_quicksearch_alt(del1)' ,'mnu_task_quicksearch_alt(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Search' ,'N' ,'2016-05-19 09:12:05' ,'AJM' ,'005' ,'mnu_task_quicksearch_alt(search)' ,'mnu_task_quicksearch_alt(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Audit Trail' ,'Y' ,'2016-05-19 09:12:06' ,'AJM' ,'006' ,'audit_dtl(list)3' ,'mnu_task_quicksearch_alt(list2)');

INSERT INTO mnu_nav_button (button_text, context_preselect, created_date, created_user, sort_seq, task_id_jnr, task_id_snr) VALUES
('Mnu Task Quicksearch Alt' ,'Y' ,'2016-05-19 09:13:42' ,'AJM' ,'007' ,'mnu_task_quicksearch_alt(list2)' ,'mnu_task_quicksearch(list2)');

UPDATE mnu_nav_button SET revised_date='2016-05-19 09:13:54', revised_user='AJM', sort_seq='007' WHERE task_id_snr='mnu_task_quicksearch(list2)' AND task_id_jnr='audit_dtl(list)3';

UPDATE mnu_nav_button SET revised_date='2016-05-19 09:13:54', revised_user='AJM', sort_seq='006' WHERE task_id_snr='mnu_task_quicksearch(list2)' AND task_id_jnr='mnu_task_quicksearch_alt(list2)';

UPDATE mnu_nav_button SET button_text='Alternative Languages', revised_date='2016-05-19 09:16:03', revised_user='AJM' WHERE task_id_snr='mnu_task_quicksearch(list2)' AND task_id_jnr='mnu_task_quicksearch_alt(list2)';

UPDATE mnu_task SET revised_date='2016-05-19 09:17:02', revised_user='AJM', task_desc='List QuickSearch options for a Task' WHERE task_id='mnu_task_quicksearch(list2)';

UPDATE mnu_task SET revised_date='2016-05-19 09:17:10', revised_user='AJM', task_desc='Search QuickSearch options' WHERE task_id='mnu_task_quicksearch(search)';

UPDATE mnu_task SET revised_date='2016-05-19 09:17:18', revised_user='AJM', task_desc='Update QuickSearch option' WHERE task_id='mnu_task_quicksearch(upd1)';

UPDATE mnu_task SET button_text='Alternative Languages', revised_date='2016-05-19 09:20:09', revised_user='AJM', task_desc='Maintain Alternative Languages for TASK_QUICKSEARCH' WHERE task_id='mnu_task_quicksearch_alt(list2)';

UPDATE mnu_task SET revised_date='2016-05-19 09:21:06', revised_user='AJM', task_desc='Add Task QuickSearch (Alternative Language)' WHERE task_id='mnu_task_quicksearch_alt(add2)';

UPDATE mnu_task SET revised_date='2016-05-19 09:21:17', revised_user='AJM', task_desc='Delete Task QuickSearch (Alternative Language)' WHERE task_id='mnu_task_quicksearch_alt(del1)';

UPDATE mnu_task SET revised_date='2016-05-19 09:21:29', revised_user='AJM', task_desc='Enquire Task QuickSearch (Alternative Language)' WHERE task_id='mnu_task_quicksearch_alt(enq1)';

UPDATE mnu_task SET revised_date='2016-05-19 09:21:38', revised_user='AJM', task_desc='Search Task QuickSearch (Alternative Language)' WHERE task_id='mnu_task_quicksearch_alt(search)';

UPDATE mnu_task SET revised_date='2016-05-19 09:21:47', revised_user='AJM', task_desc='Update Task QuickSearch (Alternative Language)' WHERE task_id='mnu_task_quicksearch_alt(upd1)';

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_pattern(list1)', 'pattern_desc', 2, 'Pattern Desc', '2016-05-18 16:50:33', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_pattern(list1)', 'pattern_id', 1, 'Pattern Id', '2016-05-18 16:50:22', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_role(list1)', 'role_desc', 2, 'Role Desc', '2016-05-18 16:51:17', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_role(list1)', 'role_id', 1, 'Role Id', '2016-05-18 16:51:06', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_subsystem(list1)', 'subsys_desc', 2, 'Subsys Desc', '2016-05-18 16:40:20', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_subsystem(list1)', 'subsys_dir', 3, 'Subsys Dir', '2016-05-18 16:40:31', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_subsystem(list1)', 'subsys_id', 1, 'Subsys Id', '2016-05-18 16:40:07', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_subsystem(list1)', 'task_prefix', 4, 'Task Prefix', '2016-05-18 16:40:43', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(list1)', 'pattern_id', 3, 'Pattern Id', '2016-05-18 16:52:38', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(list1)', 'task_desc', 2, 'Task Desc', '2016-05-18 16:52:28', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(list1)', 'task_id', 1, 'Task Id', '2016-05-18 16:52:16', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(list1)a', 'pattern_id', 3, 'Pattern Id', '2016-05-18 16:58:09', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(list1)a', 'task_desc', 2, 'Task Desc', '2016-05-18 16:57:57', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(list1)a', 'task_id', 1, 'Task Id', '2016-05-18 16:57:47', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_todo(list1)', 'item_desc', 2, 'Item Desc', '2016-05-18 16:58:58', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_todo(list1)', 'user_id', 1, 'User Id', '2016-05-18 16:58:47', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_user(list1)', 'user_id', 1, 'User Id', '2016-05-18 16:59:27', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_user(list1)', 'user_name', 2, 'User Name', '2016-05-18 16:59:38', 'AJM', NULL, NULL);

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(list1)b', 'task_desc', 2, 'Task Desc', '2016-05-18 16:57:57', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(list1)b', 'task_id', 1, 'Task Id', '2016-05-18 16:57:47', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(list2)a', 'task_desc', 2, 'Task Desc', '2016-05-18 16:57:57', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(list2)a', 'task_id', 1, 'Task Id', '2016-05-18 16:57:47', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(list2)b', 'task_desc', 2, 'Task Desc', '2016-05-18 16:57:57', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(list2)b', 'task_id', 1, 'Task Id', '2016-05-18 16:57:47', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(popup1)', 'pattern_id', 3, 'Pattern Id', '2016-05-18 16:58:09', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(popup1)', 'task_desc', 2, 'Task Desc', '2016-05-18 16:57:57', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(popup1)', 'task_id', 1, 'Task Id', '2016-05-18 16:57:47', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(popup1)a', 'pattern_id', 3, 'Pattern Id', '2016-05-18 16:58:09', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(popup1)a', 'task_desc', 2, 'Task Desc', '2016-05-18 16:57:57', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(popup1)a', 'task_id', 1, 'Task Id', '2016-05-18 16:57:47', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(popup1)a1', 'pattern_id', 3, 'Pattern Id', '2016-05-18 16:58:09', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(popup1)a1', 'task_desc', 2, 'Task Desc', '2016-05-18 16:57:57', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(popup1)a1', 'task_id', 1, 'Task Id', '2016-05-18 16:57:47', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(popup1)a2', 'pattern_id', 3, 'Pattern Id', '2016-05-18 16:58:09', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(popup1)a2', 'task_desc', 2, 'Task Desc', '2016-05-18 16:57:57', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(popup1)a2', 'task_id', 1, 'Task Id', '2016-05-18 16:57:47', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(popup1)b', 'pattern_id', 3, 'Pattern Id', '2016-05-18 16:58:09', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(popup1)b', 'task_desc', 2, 'Task Desc', '2016-05-18 16:57:57', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('mnu_task(popup1)b', 'task_id', 1, 'Task Id', '2016-05-18 16:57:47', 'AJM', NULL, NULL);
