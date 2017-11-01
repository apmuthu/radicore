USE [menu];

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('User Role' ,'2014-04-19 09:28:26' ,'AJM' ,'N' ,'N' ,'N' ,'LIST2' ,'mnu_user_role(list2).php' ,'MENU' ,'List User Role by Mnu User' ,'mnu_user_role(list2)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('New' ,'2014-04-19 09:28:26' ,'AJM' ,'N' ,'N' ,'N' ,'ADD2' ,'mnu_user_role(add2).php' ,'MENU' ,'Add User Role' ,'mnu_user_role(add2)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('Read' ,'2014-04-19 09:28:26' ,'AJM' ,'N' ,'N' ,'N' ,'ENQ1' ,'mnu_user_role(enq1).php' ,'MENU' ,'Enquire User Role' ,'mnu_user_role(enq1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('Update' ,'2014-04-19 09:28:26' ,'AJM' ,'N' ,'N' ,'N' ,'UPD1' ,'mnu_user_role(upd1).php' ,'MENU' ,'Update User Role' ,'mnu_user_role(upd1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('Delete' ,'2014-04-19 09:28:27' ,'AJM' ,'N' ,'N' ,'N' ,'DEL1' ,'mnu_user_role(del1).php' ,'MENU' ,'Delete User Role' ,'mnu_user_role(del1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('Search' ,'2014-04-19 09:28:28' ,'AJM' ,'N' ,'N' ,'N' ,'SRCH' ,'mnu_user_role(search).php' ,'MENU' ,'Search User Role' ,'mnu_user_role(search)' ,'PROC' ,'N');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('New' ,'N' ,'2014-04-19 09:28:28' ,'AJM' ,'001' ,'mnu_user_role(add2)' ,'mnu_user_role(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Read' ,'Y' ,'2014-04-19 09:28:28' ,'AJM' ,'002' ,'mnu_user_role(enq1)' ,'mnu_user_role(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Update' ,'Y' ,'2014-04-19 09:28:28' ,'AJM' ,'003' ,'mnu_user_role(upd1)' ,'mnu_user_role(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Delete' ,'Y' ,'2014-04-19 09:28:28' ,'AJM' ,'004' ,'mnu_user_role(del1)' ,'mnu_user_role(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Search' ,'N' ,'2014-04-19 09:28:28' ,'AJM' ,'005' ,'mnu_user_role(search)' ,'mnu_user_role(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Audit Trail' ,'Y' ,'2014-04-19 09:28:29' ,'AJM' ,'006' ,'audit_dtl(list)3' ,'mnu_user_role(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('User Role' ,'Y' ,'2014-04-19 09:43:52' ,'AJM' ,'001' ,'mnu_user_role(list2)' ,'mnu_user(upd1)');

UPDATE mnu_nav_button SET button_text='User Roles' ,revised_date='2014-04-19 09:44:16' ,revised_user='AJM' WHERE task_id_snr='mnu_user(upd1)' AND task_id_jnr='mnu_user_role(list2)';

UPDATE mnu_task SET button_text='User Roles' ,revised_date='2014-04-19 09:44:41' ,revised_user='AJM' WHERE task_id='mnu_user_role(list2)';

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('User Roles' ,'Y' ,'2014-04-19 10:46:48' ,'AJM' ,'016' ,'mnu_user_role(list2)' ,'mnu_user(list1)');

UPDATE mnu_nav_button SET revised_date='2014-04-19 10:47:31' ,revised_user='AJM' ,sort_seq='006' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='mnu_user(upd1)a';

UPDATE mnu_nav_button SET revised_date='2014-04-19 10:47:31' ,revised_user='AJM' ,sort_seq='007' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='mnu_user(upd1)b';

UPDATE mnu_nav_button SET revised_date='2014-04-19 10:47:32' ,revised_user='AJM' ,sort_seq='008' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='mnu_todo(list2)';

UPDATE mnu_nav_button SET revised_date='2014-04-19 10:47:32' ,revised_user='AJM' ,sort_seq='009' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='mnu_initial_value_user(multi3)b';

UPDATE mnu_nav_button SET revised_date='2014-04-19 10:47:32' ,revised_user='AJM' ,sort_seq='010' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='mnu_user(search)';

UPDATE mnu_nav_button SET revised_date='2014-04-19 10:47:33' ,revised_user='AJM' ,sort_seq='011' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='mnu_user(pdf)';

UPDATE mnu_nav_button SET revised_date='2014-04-19 10:47:33' ,revised_user='AJM' ,sort_seq='012' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='mnu_user_ip_address(list2)';

UPDATE mnu_nav_button SET revised_date='2014-04-19 10:47:33' ,revised_user='AJM' ,sort_seq='013' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='py_email_signature(multi1)';

UPDATE mnu_nav_button SET revised_date='2014-04-19 10:47:33' ,revised_user='AJM' ,sort_seq='014' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='mnu_favourite(list2)';

UPDATE mnu_nav_button SET revised_date='2014-04-19 10:47:34' ,revised_user='AJM' ,sort_seq='015' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='mnu_time_limit_user(list2)';

UPDATE mnu_nav_button SET revised_date='2014-04-19 10:47:34' ,revised_user='AJM' ,sort_seq='016' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='audit_dtl(list)3';

UPDATE mnu_nav_button SET revised_date='2014-04-19 10:47:35' ,revised_user='AJM' ,sort_seq='005' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='mnu_user_role(list2)';

UPDATE mnu_task SET revised_date='2014-04-19 10:59:35' ,revised_user='AJM' ,task_desc='List User Role by User' WHERE task_id='mnu_user_role(list2)';

DELETE FROM mnu_nav_button WHERE task_id_snr='mnu_user(upd1)' AND task_id_jnr='mnu_user_role(list2)';


INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('User (Alternative Language)' ,'2014-04-23 18:14:31' ,'AJM' ,'N' ,'N' ,'N' ,'LIST2' ,'mnu_user_alt(list2).php' ,'MENU' ,'List Mnu User Alt by Mnu User' ,'mnu_user_alt(list2)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('New' ,'2014-04-23 18:14:31' ,'AJM' ,'N' ,'N' ,'N' ,'ADD2' ,'mnu_user_alt(add2).php' ,'MENU' ,'Add User (Alternative Language)' ,'mnu_user_alt(add2)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('Read' ,'2014-04-23 18:14:31' ,'AJM' ,'N' ,'N' ,'N' ,'ENQ1' ,'mnu_user_alt(enq1).php' ,'MENU' ,'Enquire User (Alternative Language)' ,'mnu_user_alt(enq1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('Update' ,'2014-04-23 18:14:31' ,'AJM' ,'N' ,'N' ,'N' ,'UPD1' ,'mnu_user_alt(upd1).php' ,'MENU' ,'Update User (Alternative Language)' ,'mnu_user_alt(upd1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('Delete' ,'2014-04-23 18:14:31' ,'AJM' ,'N' ,'N' ,'N' ,'DEL1' ,'mnu_user_alt(del1).php' ,'MENU' ,'Delete User (Alternative Language)' ,'mnu_user_alt(del1)' ,'PROC' ,'N');

INSERT INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('Search' ,'2014-04-23 18:14:32' ,'AJM' ,'N' ,'N' ,'N' ,'SRCH' ,'mnu_user_alt(search).php' ,'MENU' ,'Search User (Alternative Language)' ,'mnu_user_alt(search)' ,'PROC' ,'N');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('New' ,'N' ,'2014-04-23 18:14:32' ,'AJM' ,'001' ,'mnu_user_alt(add2)' ,'mnu_user_alt(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Read' ,'Y' ,'2014-04-23 18:14:32' ,'AJM' ,'002' ,'mnu_user_alt(enq1)' ,'mnu_user_alt(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Update' ,'Y' ,'2014-04-23 18:14:32' ,'AJM' ,'003' ,'mnu_user_alt(upd1)' ,'mnu_user_alt(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Delete' ,'Y' ,'2014-04-23 18:14:32' ,'AJM' ,'004' ,'mnu_user_alt(del1)' ,'mnu_user_alt(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Search' ,'N' ,'2014-04-23 18:14:32' ,'AJM' ,'005' ,'mnu_user_alt(search)' ,'mnu_user_alt(list2)');

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Audit Trail' ,'Y' ,'2014-04-23 18:14:33' ,'AJM' ,'006' ,'audit_dtl(list)3' ,'mnu_user_alt(list2)');

UPDATE mnu_task SET button_text='Alternative Languages' ,revised_date='2014-04-23 18:16:42' ,revised_user='AJM' ,task_desc='Maintain Alternative Languages for USER' WHERE task_id='mnu_user_alt(list2)';

INSERT INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Alternative Languages' ,'Y' ,'2014-04-23 18:18:02' ,'AJM' ,'017' ,'mnu_user_alt(list2)' ,'mnu_user(list1)');

UPDATE mnu_nav_button SET revised_date='2014-04-23 18:18:47' ,revised_user='AJM' ,sort_seq='017' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='audit_dtl(list)3';

UPDATE mnu_nav_button SET revised_date='2014-04-23 18:18:47' ,revised_user='AJM' ,sort_seq='016' WHERE task_id_snr='mnu_user(list1)' AND task_id_jnr='mnu_user_alt(list2)';

-- roles

INSERT INTO mnu_role (role_id, role_desc, start_task_id, global_access, is_external_auth_off, created_date, created_user, revised_date, revised_user) VALUES ('AUDIT', 'AUDIT', 'main_menu', 'N', 'N', '2014-04-19 12:21:39', 'AJM', NULL, NULL);
INSERT INTO mnu_role (role_id, role_desc, start_task_id, global_access, is_external_auth_off, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'DICT read_only', 'main_menu', 'N', 'N', '2014-04-19 12:21:11', 'AJM', NULL, NULL);
INSERT INTO mnu_role (role_id, role_desc, start_task_id, global_access, is_external_auth_off, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'MENU read-only', 'main_menu', 'N', 'Y', '2014-04-19 06:21:53', 'AJM', NULL, NULL);
INSERT INTO mnu_role (role_id, role_desc, start_task_id, global_access, is_external_auth_off, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'WORKFLOW', 'workflow', 'N', 'N', '2014-04-19 12:22:14', 'AJM', '2014-04-20 12:54:42', 'AJM');
INSERT INTO mnu_role (role_id, role_desc, start_task_id, global_access, is_external_auth_off, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'WORKFLOW read-only', 'workflow', 'N', 'N', '2014-04-20 12:47:57', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('AUDIT', 'audit_dtl(list)2', '2014-04-19 12:23:19', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('AUDIT', 'audit_dtl(list)3', '2014-04-19 12:23:20', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('AUDIT', 'audit_dtl(list)3exact', '2014-04-19 12:23:20', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('AUDIT', 'audit_dtl(search)', '2014-04-19 12:23:20', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('AUDIT', 'audit_logon_errors(search)', '2014-04-19 12:23:21', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('AUDIT', 'menu', '2014-04-19 12:21:40', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_column(enq1)', '2014-04-19 12:25:29', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_column(list1)', '2014-04-19 12:25:30', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_column(list2)', '2014-04-19 12:25:30', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_column(output2)', '2014-04-19 12:25:31', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_column(output3)', '2014-04-19 12:25:31', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_column(search)', '2014-04-19 12:25:31', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_database(enq1)', '2014-04-19 12:27:17', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_database(list1)', '2014-04-19 12:27:17', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_database(list2)', '2014-04-19 12:27:18', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_database(popup1)', '2014-04-19 12:26:54', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_database(popup1)inner', '2014-04-19 12:26:55', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_database(popup1)middle', '2014-04-19 12:26:55', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_database(popup1)outer', '2014-04-19 12:26:55', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_database(search)', '2014-04-19 12:26:56', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_related_column(list2)a', '2014-04-19 12:26:56', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_related_column(list2)b', '2014-04-19 12:26:57', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_relationship(list1)', '2014-04-19 12:26:37', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_relationship(list2)a', '2014-04-19 12:26:37', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_relationship(list2)b', '2014-04-19 12:26:38', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_relationship(list2)c', '2014-04-19 12:26:38', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_relationship(list2)d', '2014-04-19 12:26:38', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_relationship(output3)a', '2014-04-19 12:26:16', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_relationship(search)', '2014-04-19 12:26:16', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table_key(enq1)', '2014-04-19 12:26:17', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table_key(list1)', '2014-04-19 12:26:17', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table_key(list2)', '2014-04-19 12:26:17', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table_key(search)', '2014-04-19 12:26:18', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table(enq1)', '2014-04-19 12:26:18', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table(list1)', '2014-04-19 12:25:55', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table(list2)', '2014-04-19 12:25:56', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table(output2)', '2014-04-19 12:25:56', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table(popup2)', '2014-04-19 12:25:56', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table(popup2)jnr', '2014-04-19 12:25:57', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table(popup2)snr', '2014-04-19 12:25:57', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table(search)', '2014-04-19 12:25:57', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dictionary', '2014-04-19 12:25:40', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'menu', '2014-04-19 12:21:12', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'applications', '2014-04-19 08:55:54', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'batch_log(filedownload)', '2014-04-19 13:06:08', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'batch_log(filepicker)', '2014-04-19 13:06:09', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'date(current)', '2014-04-19 13:06:09', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'date(future)', '2014-04-19 13:06:09', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'date(historic)', '2014-04-19 13:06:10', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'file(search)', '2014-04-19 13:06:10', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'logon', '2014-04-19 08:55:55', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'main_menu', '2014-04-19 09:02:03', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'menu', '2014-04-19 06:21:54', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'menu01', '2014-04-19 09:02:03', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_account(enq1)', '2014-04-19 08:55:55', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_account(list1)', '2014-04-19 08:55:56', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_account(search)', '2014-04-19 08:55:56', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_control(upd3)', '2014-04-20 12:57:53', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_control(upd3)noedit', '2014-04-19 08:56:19', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_favourite(add2)', '2014-04-19 06:21:59', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_favourite(add4)', '2014-04-19 06:21:59', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_favourite(del1)', '2014-04-19 06:21:59', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_favourite(enq1)', '2014-04-19 06:22:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_favourite(list2)', '2014-04-19 06:22:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_favourite(search)', '2014-04-19 06:22:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_favourite(upd1)', '2014-04-19 06:22:01', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_favourite(upd4)movedown', '2014-04-19 06:22:01', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_favourite(upd4)moveup', '2014-04-19 06:22:02', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_favourite(upd4)reseq', '2014-04-19 06:22:02', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_help_text_alt(enq1)', '2014-04-19 08:56:20', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_help_text_alt(list2)', '2014-04-19 09:02:04', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_help_text_alt(search)', '2014-04-19 09:02:04', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_language(enq1)', '2014-04-19 09:01:30', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_language(list1)', '2014-04-19 09:01:31', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_language(search)', '2014-04-19 09:01:17', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_menu(list2)', '2014-04-19 09:01:08', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_menu(list2)a', '2014-04-19 09:01:08', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_menu(search)', '2014-04-19 09:01:08', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_motd(enq1)', '2014-04-19 09:00:54', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_motd(list1)', '2014-04-19 09:00:54', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_motd(search)', '2014-04-19 09:00:55', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_motd(show)', '2014-04-19 06:21:55', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_nav_button(list2)', '2014-04-19 09:00:38', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_nav_button(list2)a', '2014-04-19 09:00:39', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_nav_button(search)', '2014-04-19 09:00:39', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_pattern(enq1)', '2014-04-19 09:00:39', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_pattern(list1)', '2014-04-19 09:00:40', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_pattern(pdf)', '2014-04-19 08:59:58', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_pattern(pdf)2', '2014-04-19 08:59:59', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_pattern(search)', '2014-04-19 08:59:59', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_role(enq1)', '2014-04-19 08:59:19', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_role(list1)', '2014-04-19 08:59:19', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_role(pdf)', '2014-04-19 08:59:20', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_role(popup1)', '2014-04-19 08:59:20', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_role(search)', '2014-04-19 08:59:20', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_session(upd3)', '2014-04-19 13:07:20', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_subsystem(enq1)', '2014-04-19 08:59:21', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_subsystem(list1)', '2014-04-19 08:59:03', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_subsystem(pdf)', '2014-04-19 08:59:03', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_subsystem(search)', '2014-04-19 08:59:04', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task_alt(enq1)', '2014-04-19 08:59:04', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task_alt(list2)', '2014-04-19 08:58:43', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task_alt(search)', '2014-04-19 08:58:43', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task_field(enq1)', '2014-04-19 08:58:44', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task_field(list2)', '2014-04-19 08:58:44', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task_field(search)', '2014-04-19 08:58:45', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task_ip_address(enq1)', '2014-04-19 08:58:20', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task_ip_address(list2)', '2014-04-19 08:58:20', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task_ip_address(search)', '2014-04-19 08:58:21', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task(enq1)', '2014-04-19 08:58:21', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task(list1)', '2014-04-19 08:58:22', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task(list1)a', '2014-04-19 08:58:22', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task(list1)b', '2014-04-19 08:57:58', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task(list2)a', '2014-04-19 08:57:58', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task(list2)b', '2014-04-19 08:57:58', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task(pdf)', '2014-04-19 08:57:59', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task(pdf)2', '2014-04-19 08:57:59', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task(pdf)3', '2014-04-19 08:57:59', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task(popup1)', '2014-04-19 08:58:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task(popup1)a', '2014-04-19 06:22:02', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task(popup1)a1', '2014-04-19 08:58:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task(popup1)a2', '2014-04-19 08:58:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task(popup1)b', '2014-04-19 08:58:01', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_task(search)', '2014-04-19 06:22:03', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_time_limit_role(enq1)', '2014-04-19 08:57:38', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_time_limit_role(list2)', '2014-04-19 08:57:38', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_time_limit_role(search)', '2014-04-19 08:57:38', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_time_limit_user(enq1)', '2014-04-19 08:57:18', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_time_limit_user(list2)', '2014-04-19 08:57:18', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_time_limit_user(search)', '2014-04-19 08:57:19', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_todo(add1)', '2014-04-19 06:21:56', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_todo(complete)', '2014-04-19 06:21:58', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_todo(del1)', '2014-04-19 06:21:56', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_todo(enq1)', '2014-04-19 06:21:57', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_todo(incomplete)', '2014-04-19 06:21:58', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_todo(list1)', '2014-04-19 08:57:19', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_todo(list2)', '2014-04-19 06:21:56', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_todo(search)', '2014-04-19 06:21:57', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_todo(upd1)', '2014-04-19 06:21:57', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_user_alt(enq1)', '2014-04-23 14:03:45', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_user_alt(list2)', '2014-04-23 14:03:46', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_user_alt(search)', '2014-04-23 14:03:46', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_user_ip_address(enq1)', '2014-04-19 08:57:20', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_user_ip_address(list2)', '2014-04-19 08:57:20', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_user_ip_address(search)', '2014-04-19 08:57:20', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_user_role(enq1)', '2014-04-19 08:56:57', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_user_role(list2)', '2014-04-19 08:56:58', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_user_role(search)', '2014-04-19 08:56:58', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_user(enq1)', '2014-04-19 08:56:59', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_user(list1)', '2014-04-19 08:56:37', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_user(list2)', '2014-04-19 08:56:37', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_user(pdf)', '2014-04-19 08:56:38', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_user(popup1)', '2014-04-19 08:56:38', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_user(search)', '2014-04-19 08:56:38', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'mnu_user(upd1)c', '2014-04-19 06:21:55', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_arc(add)', '2014-04-20 12:06:46', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_arc(del)', '2014-04-20 12:06:46', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_arc(enq)', '2014-04-19 12:31:09', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_arc(list)', '2014-04-19 12:31:10', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_arc(search)', '2014-04-19 12:31:10', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_arc(upd)', '2014-04-20 12:06:47', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_case(enq)', '2014-04-19 12:31:10', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_case(list)', '2014-04-19 12:31:11', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_case(list)2', '2014-04-19 12:31:11', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_case(search)', '2014-04-19 12:31:11', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_place(add)', '2014-04-20 12:06:47', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_place(del)', '2014-04-20 12:06:47', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_place(enq)', '2014-04-19 12:30:49', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_place(list)', '2014-04-19 12:30:50', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_place(popup)', '2014-04-19 12:30:50', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_place(search)', '2014-04-19 12:30:50', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_place(upd)', '2014-04-20 12:06:48', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_token(enq)', '2014-04-19 12:30:51', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_token(list)', '2014-04-19 12:30:51', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_token(list)2', '2014-04-19 12:30:51', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_token(search)', '2014-04-19 12:30:31', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_transition(add)', '2014-04-20 12:06:48', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_transition(del)', '2014-04-20 12:06:48', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_transition(enq)', '2014-04-19 12:30:31', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_transition(list)', '2014-04-19 12:30:32', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_transition(popup)', '2014-04-19 12:30:32', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_transition(search)', '2014-04-19 12:30:33', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_transition(upd)', '2014-04-20 12:06:49', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workflow(add)', '2014-04-20 12:06:49', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workflow(del)', '2014-04-20 12:06:55', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workflow(enq)', '2014-04-19 12:29:53', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workflow(list)', '2014-04-19 12:29:53', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workflow(popup)', '2014-04-19 12:29:54', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workflow(search)', '2014-04-19 12:29:54', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workflow(upd)', '2014-04-20 12:06:56', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workflow(validate)', '2014-04-20 12:06:56', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workitem(enq)', '2014-04-19 12:29:54', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workitem(list)', '2014-04-19 12:29:55', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workitem(list)2', '2014-04-19 12:29:55', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workitem(list)expired', '2014-04-19 12:30:03', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workitem(search)', '2014-04-19 12:29:35', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workitem(upd)', '2014-04-20 12:06:56', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workitem(upd)expired', '2014-04-20 12:06:57', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'workflow', '2014-04-19 12:29:36', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'menu', '2014-04-20 12:47:58', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_favourite(add2)', '2014-04-20 12:48:02', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_favourite(add4)', '2014-04-20 12:48:02', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_favourite(del1)', '2014-04-20 12:48:02', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_favourite(enq1)', '2014-04-20 12:48:03', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_favourite(list2)', '2014-04-20 12:48:03', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_favourite(search)', '2014-04-20 12:48:03', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_favourite(upd1)', '2014-04-20 12:48:04', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_favourite(upd4)movedown', '2014-04-20 12:48:04', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_favourite(upd4)moveup', '2014-04-20 12:48:04', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_favourite(upd4)reseq', '2014-04-20 12:48:05', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_motd(show)', '2014-04-20 12:47:59', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_task(popup1)a', '2014-04-20 12:48:05', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_task(search)', '2014-04-20 12:48:05', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_todo(add1)', '2014-04-20 12:48:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_todo(complete)', '2014-04-20 12:48:01', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_todo(del1)', '2014-04-20 12:48:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_todo(enq1)', '2014-04-20 12:48:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_todo(incomplete)', '2014-04-20 12:48:01', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_todo(list2)', '2014-04-20 12:47:59', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_todo(search)', '2014-04-20 12:48:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_todo(upd1)', '2014-04-20 12:48:01', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'mnu_user(upd1)c', '2014-04-20 12:47:59', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_arc(enq)', '2014-04-20 12:48:43', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_arc(list)', '2014-04-20 12:48:43', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_arc(search)', '2014-04-20 12:48:43', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_case(enq)', '2014-04-20 12:48:44', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_case(list)', '2014-04-20 12:48:44', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_case(list)2', '2014-04-20 12:48:44', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_case(search)', '2014-04-20 12:48:45', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_place(enq)', '2014-04-20 12:49:01', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_place(list)', '2014-04-20 12:49:01', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_place(popup)', '2014-04-20 12:49:01', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_place(search)', '2014-04-20 12:49:02', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_token(enq)', '2014-04-20 12:49:02', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_token(list)', '2014-04-20 12:49:02', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_token(list)2', '2014-04-20 12:49:03', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_token(search)', '2014-04-20 12:49:16', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_transition(enq)', '2014-04-20 12:49:16', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_transition(list)', '2014-04-20 12:49:16', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_transition(popup)', '2014-04-20 12:49:17', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_transition(search)', '2014-04-20 12:49:17', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_workflow(enq)', '2014-04-20 12:49:35', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_workflow(list)', '2014-04-20 12:49:35', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_workflow(popup)', '2014-04-20 12:49:36', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_workflow(search)', '2014-04-20 12:49:36', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_workitem(enq)', '2014-04-20 12:49:37', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_workitem(list)', '2014-04-20 12:49:37', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_workitem(list)2', '2014-04-20 12:49:38', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_workitem(list)expired', '2014-04-20 12:49:38', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_workitem(search)', '2014-04-20 12:49:50', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'workflow', '2014-04-20 12:49:50', 'AJM', NULL, NULL);
