-- file created on May 20, 2016, 9:31 am

-- SET search_path = menu;
    
INSERT INTO mnu_subsystem (subsys_id, subsys_desc, subsys_dir, task_prefix, created_date, created_user, revised_date, revised_user) VALUES ('DICT', 'Data Dictionary', 'dict', 'dict_', '2005-03-12 18:06:10', 'AJM', '2006-04-22 09:38:05', 'AJM');

INSERT INTO mnu_role (role_id, role_desc, start_task_id, global_access, is_external_auth_off, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'DICT read_only', 'main_menu', 'N', 'N', '2014-04-19 12:21:11', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(add4)import', 'Import Column Names', 'Import', 'PROC', 'column(add4)import.php', 'N', 'ADD4', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-13 15:53:17', 'AJM', '2009-06-26 11:29:40', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(del1)', 'Delete Column', 'Delete', 'PROC', 'column(del1).php', 'N', 'DEL1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-12 23:29:31', 'AJM', '2009-06-26 11:28:13', 'AJM');

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(del1)', 'This will display a record from the DICT_COLUMN table and allow it to be deleted. 

Refer to <a href="%root%/dict_column(del1).html">Delete Column</a> for full details.', '2005-06-29 19:11:50', 'AJM', '2009-08-14 14:43:02', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(enq1)', 'Enquire Column', 'Read', 'PROC', 'column(enq1).php', 'N', 'ENQ1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-12 23:29:51', 'AJM', '2009-06-26 11:28:45', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_column(enq1)', '2014-04-19 12:25:29', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(enq1)', 'This will display the contents of a record from the DICT_COLUMN table.

Refer to <a href="%root%/dict_column(enq1).html">Enquire Columns</a> for full details.', '2005-06-29 19:05:34', 'AJM', '2009-08-14 14:43:09', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list1)', 'List Columns', 'Columns', 'PROC', 'column(list1).php', 'N', 'LIST1', 'DICT', NULL, NULL, NULL, NULL, 'database_id,table_id,column_seq', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2005-04-24 12:20:09', 'AJM', '2009-06-26 11:30:46', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list1)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2005-06-10 12:47:40', 'AJM', '2009-06-26 11:30:46', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list1)', 'dict_column(del1)', '004', 'Delete', 'Y', '2005-06-10 12:47:53', 'AJM', '2009-06-26 11:30:45', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list1)', 'dict_column(enq1)', '001', 'Read', 'Y', '2005-04-24 12:24:52', 'AJM', '2009-06-26 11:30:45', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list1)', 'dict_column(output2)', '005', 'Output to PDF(L)', 'N', '2006-08-18 10:55:04', 'AJM', '2009-06-26 11:33:51', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list1)', 'dict_column(output3)', '006', 'Output to PDF(D)', 'N', '2006-08-18 11:32:26', 'AJM', '2009-06-26 11:34:39', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list1)', 'dict_column(search)', '002', 'Search', 'N', '2005-04-24 12:24:53', 'AJM', '2009-06-26 11:30:45', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list1)', 'dict_column(upd1)', '003', 'Update', 'Y', '2005-06-10 12:47:53', 'AJM', '2009-06-26 11:32:47', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_column(list1)', '2014-04-19 12:25:30', 'AJM', NULL, NULL);

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list1)', 'table_id', '2', 'Table Id', '2016-05-19 18:52:02', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list1)', 'column_id', '3', 'Column Id', '2016-05-19 18:52:28', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list1)', 'database_id', '1', 'Database Id', '2016-05-19 18:50:00', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list1)', 'This will list records on the DICT_COLUMN table.

Refer to <a href="%root%/dict_column(list1).html">List Columns</a> for full details.', '2005-06-29 18:56:16', 'AJM', '2009-08-14 14:43:16', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list2)', 'List Column by Database Table', 'Columns', 'PROC', 'column(list2).php', 'N', 'LIST2', 'DICT', NULL, NULL, NULL, NULL, 'column_seq', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-12 23:28:37', 'AJM', '2009-06-26 11:31:34', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2005-03-12 23:43:28', 'AJM', '2009-06-26 11:31:32', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list2)', 'dict_column(add4)import', '007', 'Import Columns', 'N', '2005-03-13 15:53:33', 'AJM', '2009-06-26 11:31:32', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list2)', 'dict_column(del1)', '004', 'Delete', 'Y', '2005-03-12 23:30:56', 'AJM', '2009-06-26 11:31:31', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list2)', 'dict_column(enq1)', '002', 'Read', 'Y', '2005-03-12 23:30:56', 'AJM', '2009-06-26 11:31:31', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list2)', 'dict_column(output2)', '012', 'Output to PDF(L)', 'N', '2006-08-18 10:55:22', 'AJM', '2012-07-14 18:09:21', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list2)', 'dict_column(output3)', '013', 'Output to PDF(D)', 'N', '2006-08-18 11:32:39', 'AJM', '2012-07-14 18:09:21', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list2)', 'dict_column(search)', '005', 'Search', 'N', '2005-03-12 23:30:56', 'AJM', '2009-06-26 11:31:32', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list2)', 'dict_column(upd1)', '003', 'Update', 'Y', '2005-03-12 23:30:56', 'AJM', '2009-06-26 11:32:47', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list2)', 'dict_relationship(list2)a', '009', 'Child Relationships', 'N', '2005-04-09 17:06:49', 'AJM', '2012-07-14 18:08:24', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list2)', 'dict_relationship(list2)b', '010', 'Parent Relationships', 'N', '2012-07-14 18:08:45', 'AJM', '2012-07-14 18:09:22', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list2)', 'dict_table_key(list2)', '008', 'Keys', 'N', '2005-03-20 10:42:57', 'AJM', '2009-06-26 19:05:23', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list2)', 'dict_table(upd4)export', '011', 'Export to PHP', 'N', '2005-04-05 17:27:54', 'AJM', '2012-07-14 18:09:21', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_column(list2)', '2014-04-19 12:25:30', 'AJM', NULL, NULL);

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list2)', 'column_id', '1', 'Column Id', '2016-05-19 18:53:39', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(list2)', 'This will list records on the DICT_COLUMN table for a selected TABLE.

Refer to <a href="%root%/dict_column(list2).html">List Column by Database Table</a> for full details.', '2005-06-29 19:25:11', 'AJM', '2009-08-14 14:43:32', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(output2)', 'Output to PDF - List view', 'Output to PDF(L)', 'PROC', 'column(output2).php', 'N', 'OUTPUT2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-08-18 10:54:48', 'AJM', '2009-06-26 11:33:53', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_column(output2)', '2014-04-19 12:25:31', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(output3)', 'Output to PDF - Detail view', 'Output to PDF(D)', 'PROC', 'column(output3).php', 'N', 'OUTPUT3', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-08-18 11:32:06', 'AJM', '2009-06-26 11:34:40', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_column(output3)', '2014-04-19 12:25:31', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(search)', 'Search Column', 'Search', 'PROC', 'column(search).php', 'N', 'SRCH', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-12 23:30:13', 'AJM', '2009-06-26 11:31:58', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_column(search)', '2014-04-19 12:25:31', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(search)', 'This will allow search criteria to be entered for the DICT_COLUMN table. 

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/dict_column(search).html">Search Column</a> for full details.', '2005-06-29 19:16:09', 'AJM', '2005-07-02 15:39:13', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(upd1)', 'Update Column', 'Update', 'PROC', 'column(upd1).php', 'N', 'UPD1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-12 23:30:34', 'AJM', '2009-06-26 11:32:47', 'AJM');

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_column(upd1)', 'This will display the contents of a record from the DICT_COLUMN table and allow it to be updated.

Refer to <a href="%root%/dict_column(upd1).html">Update Column</a> for full details.', '2005-06-29 19:18:43', 'AJM', '2009-08-14 14:43:51', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(add1)import', 'Import Database Details', 'Import', 'PROC', 'database(add1)import.php', 'N', 'ADD1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-13 11:33:39', 'AJM', '2009-06-26 16:17:57', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(del1)', 'Delete Database', 'Delete', 'PROC', 'database(del1).php', 'N', 'DEL1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-12 18:34:27', 'AJM', '2009-06-26 16:11:33', 'AJM');

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(del1)', 'This will enable a record on the DICT_DATABASE table to be deleted.

Refer to <a href="%root%/dict_database(del1).html">Delete Database</a> for full details.', '2005-06-29 19:02:41', 'AJM', '2009-08-14 14:44:33', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(enq1)', 'Enquire Database', 'Read', 'PROC', 'database(enq1).php', 'N', 'ENQ1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-12 18:34:56', 'AJM', '2009-06-26 16:12:13', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_database(enq1)', '2014-04-19 12:27:17', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(enq1)', 'This will display the contents of a record from the DICT_DATABASE table.

Refer to <a href="%root%/dict_database(enq1).html">Enquire Databases</a> for full details.', '2005-06-29 19:04:27', 'AJM', '2009-08-14 14:44:39', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(erase1)', 'Erase Database details', 'Erase', 'PROC', 'database(erase1).php', 'N', 'ERASE1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '240', NULL, NULL, '2005-12-10 11:51:10', 'AJM', '2013-12-02 04:09:13', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list1)', 'List Database', 'Databases', 'PROC', 'database(list1).php', 'N', 'LIST1', 'DICT', NULL, NULL, NULL, NULL, 'database_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-12 18:33:01', 'AJM', '2009-06-26 16:12:50', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list1)', 'audit_dtl(list)3', '012', 'Audit Trail', 'Y', '2005-03-12 19:07:33', 'AJM', '2012-07-14 12:56:42', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list1)', 'audit_dtl(list)3exact', '013', 'Audit Trail (exact)', 'Y', '2005-03-12 19:07:33', 'AJM', '2012-07-14 12:56:42', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list1)', 'dict_database(add1)import', '005', 'Import Database', 'N', '2005-03-13 11:34:09', 'AJM', '2009-06-26 16:17:57', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list1)', 'dict_database(del1)', '004', 'Delete', 'Y', '2005-03-12 18:36:18', 'AJM', '2009-06-26 16:12:48', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list1)', 'dict_database(enq1)', '002', 'Read', 'Y', '2005-03-12 18:36:18', 'AJM', '2009-06-26 16:12:48', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list1)', 'dict_database(erase1)', '011', 'Erase', 'Y', '2005-12-10 12:32:37', 'AJM', '2012-07-14 12:56:42', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list1)', 'dict_database(output2)', '006', 'Output to PDF(L)', 'N', '2006-08-17 20:19:31', 'AJM', '2012-07-14 12:56:43', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list1)', 'dict_database(search)', '001', 'Search', 'N', '2005-03-12 18:36:18', 'AJM', '2009-06-26 16:12:48', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list1)', 'dict_database(upd1)', '003', 'Update', 'Y', '2005-03-12 18:36:18', 'AJM', '2009-06-26 16:14:25', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list1)', 'dict_database(upd4)export', '008', 'Export', 'Y', '2005-12-07 22:58:33', 'AJM', '2013-11-27 15:31:43', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list1)', 'dict_relationship(list2)c', '009', 'Child Relationships', 'Y', '2005-06-11 20:03:15', 'AJM', '2013-11-27 15:31:43', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list1)', 'dict_relationship(list2)d', '010', 'Parent Relationships', 'Y', '2012-07-14 12:54:59', 'AJM', '2013-11-27 15:31:43', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list1)', 'dict_table(list2)', '007', 'Tables', 'Y', '2005-03-12 22:53:50', 'AJM', '2012-07-14 12:56:42', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_database(list1)', '2014-04-19 12:27:17', 'AJM', NULL, NULL);

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list1)', 'subsys_id', '3', 'Subsys Id', '2016-05-19 18:56:25', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list1)', 'database_id', '1', 'Database Id', '2016-05-19 18:55:22', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list1)', 'database_desc', '2', 'Database Desc', '2016-05-19 18:55:54', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list1)', 'This will list records on the DICT_DATABASE table.

Refer to <a href="%root%/dict_database(list1).html">List Databases</a> for full details.', '2005-06-29 18:57:00', 'AJM', '2009-08-14 14:44:50', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list2)', 'List Database by Subsystem', 'Databases', 'PROC', 'database(list2).php', 'N', 'LIST2', 'DICT', NULL, NULL, NULL, NULL, 'database_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-12 18:55:37', 'AJM', '2009-06-26 16:13:26', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list2)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2005-03-12 19:08:37', 'AJM', '2009-06-26 16:13:25', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list2)', 'audit_dtl(list)3exact', '007', 'Audit Trail (exact)', 'Y', '2005-03-12 19:08:37', 'AJM', '2009-06-26 16:13:25', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list2)', 'dict_database(del1)', '004', 'Delete', 'Y', '2005-03-12 19:08:14', 'AJM', '2009-06-26 16:13:25', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list2)', 'dict_database(enq1)', '002', 'Read', 'Y', '2005-03-12 19:08:14', 'AJM', '2009-06-26 16:13:25', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list2)', 'dict_database(search)', '001', 'Search', 'N', '2005-03-12 19:08:14', 'AJM', '2009-06-26 16:13:25', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list2)', 'dict_database(upd1)', '003', 'Update', 'Y', '2005-03-12 19:08:14', 'AJM', '2009-06-26 16:14:25', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list2)', 'dict_table(list2)', '005', 'Tables', 'Y', '2005-03-12 22:54:17', 'AJM', '2009-06-26 18:24:00', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_database(list2)', '2014-04-19 12:27:18', 'AJM', NULL, NULL);

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list2)', 'database_id', '1', 'Database Id', '2016-05-19 18:57:06', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list2)', 'database_desc', '2', 'Database Desc', '2016-05-19 18:57:27', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(list2)', 'This will list records on the DICT_DATABASE table for a selected SUBSYSTEM.

Refer to <a href="%root%/dict_database(list2).html">List Databases by Subsystem</a> for full details.', '2005-06-29 19:00:40', 'AJM', '2009-08-14 14:44:58', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(output2)', 'Output to PDF - List view', 'Output to PDF(L)', 'PROC', 'database(output2).php', 'N', 'OUTPUT2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-08-17 20:19:09', 'AJM', '2009-06-26 16:15:10', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(popup1)', 'Choose Dictionary Database', 'Choose', 'PROC', 'database(popup1).php', 'N', 'POPUP1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2007-02-26 20:57:55', 'AJM', '2013-10-26 17:35:37', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_database(popup1)', '2014-04-19 12:26:54', 'AJM', NULL, NULL);

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(popup1)', 'subsys_id', '3', 'Subsys Id', '2016-05-19 18:56:25', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(popup1)', 'database_id', '1', 'Database Id', '2016-05-19 18:55:22', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(popup1)', 'database_desc', '2', 'Database Desc', '2016-05-19 18:55:54', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(popup1)inner', 'Choose Dictionary Database (Inner)', 'Choose', 'PROC', 'database(popup1).php', 'N', 'POPUP1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2013-10-26 16:53:10', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_database(popup1)inner', '2014-04-19 12:26:55', 'AJM', NULL, NULL);

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(popup1)inner', 'subsys_id', '3', 'Subsys Id', '2016-05-19 18:56:25', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(popup1)inner', 'database_id', '1', 'Database Id', '2016-05-19 18:55:22', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(popup1)inner', 'database_desc', '2', 'Database Desc', '2016-05-19 18:55:54', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(popup1)middle', 'Choose Dictionary Database (Middle)', 'Choose', 'PROC', 'database(popup1).php', 'N', 'POPUP1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2013-10-26 16:52:49', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_database(popup1)middle', '2014-04-19 12:26:55', 'AJM', NULL, NULL);

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(popup1)middle', 'subsys_id', '3', 'Subsys Id', '2016-05-19 18:56:25', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(popup1)middle', 'database_id', '1', 'Database Id', '2016-05-19 18:55:22', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(popup1)middle', 'database_desc', '2', 'Database Desc', '2016-05-19 18:55:54', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(popup1)outer', 'Choose Dictionary Database (Outer)', 'Choose', 'PROC', 'database(popup1).php', 'N', 'POPUP1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2013-10-26 16:52:32', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_database(popup1)outer', '2014-04-19 12:26:55', 'AJM', NULL, NULL);

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(popup1)outer', 'subsys_id', '3', 'Subsys Id', '2016-05-19 18:56:25', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(popup1)outer', 'database_id', '1', 'Database Id', '2016-05-19 18:55:22', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(popup1)outer', 'database_desc', '2', 'Database Desc', '2016-05-19 18:55:54', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(search)', 'Search Database', 'Search', 'PROC', 'database(search).php', 'N', 'SRCH', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-12 18:35:58', 'AJM', '2009-06-26 16:13:49', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_database(search)', '2014-04-19 12:26:56', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(search)', 'This will allow search criteria to be entered for the DICT_DATABASE table. 

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/dict_database(search).html">Search Database</a> for full details.', '2005-06-29 19:16:39', 'AJM', '2005-07-02 15:39:39', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(upd1)', 'Update Database', 'Update', 'PROC', 'database(upd1).php', 'N', 'UPD1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-12 18:35:19', 'AJM', '2009-06-26 16:14:26', 'AJM');

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(upd1)', 'This will display the contents of a record from the DICT_DATABASE table and allow it to be updated.

Refer to <a href="%root%/dict_database(upd1).html">Update Database</a> for full details.', '2005-06-29 19:19:11', 'AJM', '2009-08-14 14:45:16', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_database(upd4)export', 'Export Database details', 'Export', 'PROC', 'database(upd4)export.php', 'N', 'UPD4', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '120', NULL, NULL, '2005-12-07 22:58:10', 'AJM', '2012-08-17 10:20:02', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_related_column(list2)a', 'Enquire Child Relationship', 'Related Columns', 'PROC', 'related_column(list2)a.php', 'N', 'LIST2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-06-23 19:11:04', 'AJM', '2012-06-23 20:02:01', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_related_column(list2)a', 'dict_related_column(multi4)a', '001', 'Update', 'N', '2005-06-25 18:14:46', 'AJM', '2012-06-23 20:04:48', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_related_column(list2)a', '2014-04-19 12:26:56', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_related_column(list2)a', 'This will list records on the DICT_RELATIONSHIP table for a selected DATABASE.

Refer to <a href="%root%/dict_related_column(list2).html">Enquire Relationship</a> for full details.', '2005-06-29 19:26:15', 'AJM', '2012-06-23 20:02:00', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_related_column(list2)b', 'Enquire Parent Relationship', 'Related Columns', 'PROC', 'related_column(list2)b.php', 'N', 'LIST2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2012-06-24 19:46:48', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_related_column(list2)b', 'dict_related_column(multi4)b', '001', 'Update', 'N', '2012-06-24 19:49:46', 'AJM', '2012-06-24 19:50:02', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_related_column(list2)b', '2014-04-19 12:26:57', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_related_column(multi4)a', 'Update Child Relationship', 'Update', 'PROC', 'related_column(multi4)a.php', 'N', 'MULTI4', 'DICT', NULL, NULL, NULL, NULL, 'seq_in_index', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-06-25 16:49:54', 'AJM', '2012-06-23 20:04:49', 'AJM');

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_related_column(multi4)a', 'This will list a record from the DICT_RELATIONSHIP table and allow it to be updated.

Refer to <a href="%root%/dict_related_column(multi4).html">Update Relationship</a> for full details.', '2005-06-29 19:35:11', 'AJM', '2012-06-23 20:04:48', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_related_column(multi4)b', 'Update Parent Relationship', 'Update', 'PROC', 'related_column(multi4)b.php', 'N', 'MULTI4', 'DICT', NULL, NULL, NULL, NULL, 'seq_in_index', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2012-06-24 19:11:12', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(add2)a', 'Add Child Relationship', 'New', 'PROC', 'relationship(add2)a.php', 'N', 'ADD2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-20 12:05:46', 'AJM', '2012-06-23 19:57:50', 'AJM');

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(add2)a', 'This will allow a new record to be added to the DICT_RELATIONSHIP table. 

Enter your data then press the SUBMIT button to add it to the database. 

Refer to <a href="%root%/dict_relationship(add2).html">Add Relationship</a> for full details.', '2005-06-29 19:09:53', 'AJM', '2012-06-23 19:57:49', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(add2)b', 'Add Parent Relationship', 'New', 'PROC', 'relationship(add2)b.php', 'N', 'ADD2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2012-06-24 19:51:46', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(del4)', 'Delete Relationship', 'Delete', 'PROC', 'relationship(del4).php', 'N', 'DEL4', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-20 12:06:16', 'AJM', '2009-06-26 17:43:49', 'AJM');

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(del4)', 'This will display a record from the DICT_RELATIONSHIP table and allow it to be deleted. 

Refer to <a href="%root%/dict_relationship(del4).html">Delete Relationship</a> for full details.', '2005-06-29 19:13:21', 'AJM', '2009-08-14 14:46:21', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list1)', 'List Relationships', 'Relationships', 'PROC', 'relationship(list1).php', 'N', 'LIST1', 'DICT', NULL, NULL, NULL, NULL, 'database_id_snr,table_id_snr', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2005-04-24 11:51:49', 'AJM', '2009-06-26 17:44:54', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list1)', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2005-06-11 18:38:45', 'AJM', '2009-06-26 17:44:53', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list1)', 'dict_related_column(list2)a', '002', 'Read', 'Y', '2005-06-23 19:18:20', 'AJM', '2012-06-23 20:02:00', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list1)', 'dict_related_column(multi4)a', '003', 'Update', 'Y', '2005-06-25 18:08:41', 'AJM', '2012-06-23 20:04:48', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list1)', 'dict_relationship(del4)', '004', 'Delete', 'Y', '2005-06-10 12:46:19', 'AJM', '2009-06-26 17:44:53', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list1)', 'dict_relationship(output2)a', '006', 'Output to PDF(L)', 'N', '2006-08-17 20:50:49', 'AJM', '2012-06-23 20:11:15', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list1)', 'dict_relationship(output3)a', '007', 'Output to PDF(D)', 'N', '2006-08-21 19:31:14', 'AJM', '2012-06-23 20:13:07', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list1)', 'dict_relationship(search)', '001', 'Search', 'N', '2005-04-24 11:57:55', 'AJM', '2009-06-26 17:44:53', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_relationship(list1)', '2014-04-19 12:26:37', 'AJM', NULL, NULL);

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list1)', 'table_id_jnr', '4', 'Table Id Jnr', '2016-05-20 08:34:27', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list1)', 'table_id_snr', '2', 'Table Id Snr', '2016-05-20 08:33:40', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list1)', 'database_id_jnr', '3', 'Database Id Jnr', '2016-05-20 08:34:03', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list1)', 'database_id_snr', '1', 'Database Id Snr', '2016-05-20 08:33:18', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list1)', 'This will list records on the DICT_RELATIONSHIP table.

Refer to <a href="%root%/dict_relationship(list1).html">List Relationships</a> for full details.', '2005-06-29 19:39:16', 'AJM', '2009-08-14 14:46:29', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)a', 'List Child Relationship by Table', 'Relationships (Child)', 'PROC', 'relationship(list2)a.php', 'N', 'LIST2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-20 12:05:16', 'AJM', '2012-06-23 19:00:05', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)a', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2005-06-11 18:39:37', 'AJM', '2009-06-26 17:47:05', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)a', 'dict_related_column(list2)a', '003', 'Read', 'Y', '2005-06-23 19:24:50', 'AJM', '2012-06-23 20:02:00', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)a', 'dict_related_column(multi4)a', '004', 'Update', 'Y', '2005-06-25 17:15:56', 'AJM', '2012-06-23 20:04:48', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)a', 'dict_relationship(add2)a', '001', 'New', 'N', '2005-03-20 12:07:53', 'AJM', '2012-06-23 19:57:50', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)a', 'dict_relationship(del4)', '005', 'Delete', 'Y', '2005-03-20 12:07:53', 'AJM', '2009-06-26 17:47:05', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)a', 'dict_relationship(output2)a', '007', 'Output to PDF(L)', 'N', '2006-08-17 20:51:00', 'AJM', '2012-06-23 20:11:16', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)a', 'dict_relationship(output3)a', '008', 'Output to PDF(D)', 'N', '2006-08-21 19:31:29', 'AJM', '2012-06-23 20:13:07', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)a', 'dict_relationship(search)', '002', 'Search', 'N', '2005-03-20 12:07:53', 'AJM', '2009-06-26 17:47:04', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_relationship(list2)a', '2014-04-19 12:26:37', 'AJM', NULL, NULL);

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)a', 'table_id_jnr', '2', 'Table Id Jnr', '2016-05-20 09:00:26', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)a', 'database_id_jnr', '1', 'Database Id Jnr', '2016-05-20 08:59:58', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)a', 'This will list records on the DICT_RELATIONSHIP table for a selected TABLE.

Refer to <a href="%root%/dict_relationship(list2)a.html">List Relationship by Table</a> for full details.', '2005-06-29 19:30:50', 'AJM', '2009-08-14 14:46:40', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)b', 'List Parent Relationship by Table', 'Relationships (Parent)', 'PROC', 'relationship(list2)b.php', 'N', 'LIST2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2012-06-23 18:59:45', 'AJM', '2012-07-14 12:12:17', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)b', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2012-06-23 20:20:52', 'AJM', '2012-06-24 19:52:56', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)b', 'dict_related_column(list2)b', '002', 'Read', 'Y', '2012-06-24 19:47:25', 'AJM', '2012-06-24 19:52:55', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)b', 'dict_related_column(multi4)b', '003', 'Update', 'Y', '2012-06-24 19:13:15', 'AJM', '2012-06-24 19:52:56', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)b', 'dict_relationship(add2)b', '001', 'New', 'N', '2012-06-24 19:52:22', 'AJM', '2012-06-24 19:52:56', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)b', 'dict_relationship(del4)', '004', 'Delete', 'Y', '2012-06-23 20:19:52', 'AJM', '2012-06-24 19:52:56', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)b', 'dict_relationship(search)', '005', 'Search', 'N', '2012-06-23 20:19:02', 'AJM', '2012-06-24 19:52:56', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_relationship(list2)b', '2014-04-19 12:26:38', 'AJM', NULL, NULL);

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)b', 'table_id_snr', '2', 'Table Id Snr', '2016-05-20 09:02:21', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)b', 'database_id_snr', '1', 'Database Id Snr', '2016-05-20 09:02:01', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)c', 'List Child Relationships by Database', 'Child Relationships', 'PROC', 'relationship(list2)c.php', 'N', 'LIST2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-21 20:19:24', 'AJM', '2012-07-14 11:59:53', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)c', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2005-06-11 18:41:56', 'AJM', '2012-06-23 18:58:25', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)c', 'dict_related_column(list2)a', '002', 'Read', 'Y', '2005-06-23 19:22:18', 'AJM', '2012-06-23 20:02:00', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)c', 'dict_related_column(multi4)a', '003', 'Update', 'Y', '2005-06-25 18:03:51', 'AJM', '2012-06-23 20:04:48', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)c', 'dict_relationship(del4)', '004', 'Delete', 'Y', '2005-06-10 15:43:00', 'AJM', '2012-06-23 18:58:25', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)c', 'dict_relationship(output2)a', '006', 'Output to PDF(L)', 'N', '2006-08-17 20:51:11', 'AJM', '2012-06-23 20:11:16', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)c', 'dict_relationship(output3)a', '007', 'Output to PDF(D)', 'N', '2006-08-21 19:31:41', 'AJM', '2012-06-23 20:13:07', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)c', 'dict_relationship(search)', '001', 'Search', 'N', '2005-03-21 20:26:06', 'AJM', '2012-06-23 18:58:25', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_relationship(list2)c', '2014-04-19 12:26:38', 'AJM', NULL, NULL);

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)c', 'table_id_jnr', '3', 'Table Id Jnr', '2016-05-20 09:05:17', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)c', 'table_id_snr', '1', 'Table Id Snr', '2016-05-20 09:04:33', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)c', 'database_id_jnr', '2', 'Database Id Jnr', '2016-05-20 09:04:54', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)c', 'This will list records on the DICT_RELATIONSHIP table for a selected DATABASE.

Refer to <a href="%root%/dict_relationship(list2)b.html">List Relationship by Database</a> for full details.', '2005-06-29 19:31:17', 'AJM', '2012-06-23 18:58:24', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)d', 'List Parent Relationships by Database', 'Parent Relationships', 'PROC', 'relationship(list2)d.php', 'N', 'LIST2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2012-07-14 11:59:29', 'AJM', '2012-07-14 12:00:00', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_relationship(list2)d', '2014-04-19 12:26:38', 'AJM', NULL, NULL);

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)d', 'table_id_jnr', '3', 'Table Id Jnr', '2016-05-20 09:07:29', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)d', 'table_id_snr', '2', 'Table Id Snr', '2016-05-20 09:07:02', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(list2)d', 'database_id_snr', '1', 'Database Id Snr', '2016-05-20 09:06:36', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(output2)a', 'Output to PDF - List view', 'Output to PDF(L)', 'PROC', 'relationship(output2)a.php', 'N', 'OUTPUT2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-08-17 20:50:28', 'AJM', '2012-06-23 20:11:16', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(output3)a', 'Output to PDF - Detail view', 'Output to PDF(D)', 'PROC', 'relationship(output3)a.php', 'N', 'OUTPUT3', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-08-21 19:30:32', 'AJM', '2012-06-23 20:13:08', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_relationship(output3)a', '2014-04-19 12:26:16', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(search)', 'Search Relationship', 'Search', 'PROC', 'relationship(search).php', 'N', 'SRCH', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-20 12:07:06', 'AJM', '2009-06-26 17:45:24', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_relationship(search)', '2014-04-19 12:26:16', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_relationship(search)', 'This will allow search criteria to be entered for the DICT_RELATIONSHIP table. 

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/dict_relationship(search).html">Search Relationship</a> for full details.', '2005-06-29 19:48:22', 'AJM', '2005-07-02 15:40:17', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(del1)', 'Delete Key', 'Delete', 'PROC', 'table_key(del1).php', 'N', 'DEL1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-19 18:19:46', 'AJM', '2009-06-26 19:02:23', 'AJM');

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(del1)', 'This will display a record from the DICT_TABLE_KEY table and allow it to be deleted. 

Refer to <a href="%root%/dict_table_key(del1).html">Delete Key</a> for full details.', '2005-06-29 19:14:15', 'AJM', '2009-08-14 14:47:22', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(enq1)', 'Enquire Key', 'Read', 'PROC', 'table_key(enq1).php', 'N', 'ENQ1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-19 18:20:15', 'AJM', '2009-06-26 19:03:39', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table_key(enq1)', '2014-04-19 12:26:17', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(enq1)', 'This will display the contents of a record from the DICT_TABLE_KEY table.

Refer to <a href="%root%/dict_table_key(enq1).html">Enquire Key</a> for full details.', '2005-06-29 19:07:15', 'AJM', '2009-08-14 14:47:30', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(list1)', 'List Table Keys', 'Keys', 'PROC', 'table_key(list1).php', 'N', 'LIST1', 'DICT', NULL, NULL, NULL, NULL, 'database_id,table_id,column_seq', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2005-06-10 09:20:55', 'AJM', '2009-06-26 19:04:29', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(list1)', 'audit_dtl(list)3', '004', 'Audit Trail', 'Y', '2005-06-10 09:45:43', 'AJM', '2009-06-26 19:04:29', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(list1)', 'dict_table_key(del1)', '003', 'Delete', 'Y', '2005-06-10 09:45:08', 'AJM', '2009-06-26 19:04:29', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(list1)', 'dict_table_key(enq1)', '002', 'Read', 'Y', '2005-06-10 09:45:08', 'AJM', '2009-06-26 19:04:29', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(list1)', 'dict_table_key(search)', '001', 'Search', 'N', '2005-06-10 09:45:08', 'AJM', '2009-06-26 19:04:28', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table_key(list1)', '2014-04-19 12:26:17', 'AJM', NULL, NULL);

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(list1)', 'key_name', '3', 'Key Name', '2016-05-20 08:41:08', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(list1)', 'table_id', '2', 'Table Id', '2016-05-20 08:40:53', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(list1)', 'column_id', '4', 'Column Id', '2016-05-20 08:41:23', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(list1)', 'database_id', '1', 'Database Id', '2016-05-20 08:40:34', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(list1)', 'This will list records on the DICT_TABLE_KEY table.

Refer to <a href="%root%/dict_table_key(list1).html">List Table Keys</a> for full details.', '2005-06-29 19:40:30', 'AJM', '2009-08-14 14:47:37', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(list2)', 'List Keys by Database Table', 'Keys', 'PROC', 'table_key(list2).php', 'N', 'LIST2', 'DICT', NULL, NULL, NULL, NULL, 'column_seq', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-19 18:18:41', 'AJM', '2009-06-26 19:05:24', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2005-03-19 18:22:42', 'AJM', '2009-06-26 19:05:23', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(list2)', 'dict_table_key(del1)', '004', 'Delete', 'Y', '2005-03-19 18:22:14', 'AJM', '2009-06-26 19:05:23', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(list2)', 'dict_table_key(enq1)', '002', 'Read', 'Y', '2005-03-19 18:22:14', 'AJM', '2009-06-26 19:05:23', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(list2)', 'dict_table_key(search)', '005', 'Search', 'N', '2005-03-19 18:22:14', 'AJM', '2009-06-26 19:05:23', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table_key(list2)', '2014-04-19 12:26:17', 'AJM', NULL, NULL);

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(list2)', 'key_name', '2', 'Key Name', '2016-05-20 08:42:24', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(list2)', 'table_id', '1', 'Table Id', '2016-05-20 08:42:08', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(list2)', 'column_id', '3', 'Column Id', '2016-05-20 08:42:44', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(list2)', 'This will list records on the DICT_TABLE_KEY table for a selected TABLE.

Refer to <a href="%root%/dict_table_key(list2).html">List Keys by Database Table</a> for full details.', '2005-06-29 19:32:44', 'AJM', '2009-08-14 14:47:48', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(search)', 'Search Key', 'Search', 'PROC', 'table_key(search).php', 'N', 'SRCH', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-19 18:20:39', 'AJM', '2009-06-26 19:06:59', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table_key(search)', '2014-04-19 12:26:18', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_table_key(search)', 'This will allow search criteria to be entered for the DICT_TABLE_KEY table. 

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/dict_table_key(search).html">Search Key</a> for full details.', '2005-06-29 19:17:30', 'AJM', '2005-07-02 15:41:15', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(add4)import', 'Import Table Names', 'Import', 'PROC', 'table(add4)import.php', 'N', 'ADD4', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-13 14:54:15', 'AJM', '2009-06-26 18:37:37', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(del1)', 'Delete Table', 'Delete', 'PROC', 'table(del1).php', 'N', 'DEL1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-12 23:07:36', 'AJM', '2009-06-26 18:18:24', 'AJM');

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(del1)', 'This will display a record from the DICT_TABLE table and allow it to be deleted. 

Refer to <a href="%root%/dict_table(del1).html">Delete Table</a> for full details.', '2005-06-29 19:13:48', 'AJM', '2009-08-14 14:48:04', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(enq1)', 'Enquire Table', 'Read', 'PROC', 'table(enq1).php', 'N', 'ENQ1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-12 23:08:36', 'AJM', '2009-06-26 18:20:27', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(enq1)', 'dict_table(generate)a', '002', 'Generate PHP', 'Y', '2006-10-01 11:28:19', 'AJM', '2009-06-26 18:20:26', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(enq1)', 'dict_table(upd4)export', '001', 'Export to PHP', 'Y', '2006-10-01 11:28:19', 'AJM', '2009-06-26 18:31:03', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table(enq1)', '2014-04-19 12:26:18', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(enq1)', 'This will display the contents of a record from the DICT_TABLE table.

Refer to <a href="%root%/dict_table(enq1).html">Enquire Table</a> for full details.', '2005-06-29 19:06:48', 'AJM', '2009-08-14 14:48:15', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(generate)a', 'Generate PHP scripts (a) - Select Pattern', 'Generate PHP', 'PROC', 'table(generate)a.php', 'N', 'UPD1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-09-30 16:56:15', 'AJM', '2009-06-26 18:33:43', 'AJM');

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(generate)a', 'This is the first screen in a two-screen process that will generate the scripts necessary to access the selected database table using a particular transaction pattern.

Refer to <a href="%root%/dict_table(generate)a.html">Generate PHP Scripts (a)</a> for full details.', '2006-10-15 16:00:32', 'AJM', '2006-10-15 16:06:54', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(generate)b', 'Generate PHP scripts (b) - Enter details', 'Generate PHP', 'PROC', 'table(generate)b.php', 'N', 'UPD1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-10-01 11:44:27', 'AJM', '2009-06-26 18:34:31', 'AJM');

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(generate)b', 'This is the second screen in a two-screen process that will generate the scripts necessary to access the selected database table using a particular transaction pattern.

Refer to <a href="%root%/dict_table(generate)a.html">Generate PHP Scripts (b)</a> for full details.', '2006-10-15 16:00:50', 'AJM', '2006-10-15 16:06:59', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list1)', 'List Database Tables', 'Tables', 'PROC', 'table(list1).php', 'N', 'LIST1', 'DICT', NULL, NULL, NULL, NULL, 'database_id,table_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2005-04-24 10:48:37', 'AJM', '2009-06-26 18:21:56', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list1)', 'audit_dtl(list)3', '010', 'Audit Trail', 'Y', '2005-06-10 12:43:33', 'AJM', '2012-07-14 11:48:39', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list1)', 'dict_column(list2)', '006', 'Columns', 'Y', '2005-04-24 11:41:23', 'AJM', '2009-06-26 18:21:55', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list1)', 'dict_relationship(list2)a', '008', 'Child Relationships', 'Y', '2005-04-24 11:41:23', 'AJM', '2012-07-14 11:47:26', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list1)', 'dict_relationship(list2)b', '009', 'Parent Relationships', 'Y', '2012-07-14 11:48:05', 'AJM', '2012-07-14 11:48:40', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list1)', 'dict_table_key(list2)', '007', 'Keys', 'Y', '2005-04-24 11:41:57', 'AJM', '2009-06-26 19:05:23', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list1)', 'dict_table(del1)', '004', 'Delete', 'Y', '2005-06-10 12:40:38', 'AJM', '2009-06-26 18:21:55', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list1)', 'dict_table(enq1)', '002', 'Read', 'Y', '2005-04-24 11:40:23', 'AJM', '2009-06-26 18:21:55', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list1)', 'dict_table(output2)', '011', 'Output to PDF(L)', 'N', '2006-08-17 20:33:12', 'AJM', '2012-07-14 11:48:39', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list1)', 'dict_table(search)', '001', 'Search', 'N', '2005-04-24 10:59:37', 'AJM', '2009-06-26 18:21:55', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list1)', 'dict_table(upd1)', '003', 'Update', 'Y', '2005-04-24 11:40:47', 'AJM', '2009-06-26 18:27:26', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list1)', 'dict_table(upd4)export', '005', 'Export to PHP', 'Y', '2005-06-10 12:41:58', 'AJM', '2009-06-26 18:31:03', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table(list1)', '2014-04-19 12:25:55', 'AJM', NULL, NULL);

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list1)', 'table_id', '2', 'Table Id', '2016-05-20 08:36:05', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list1)', 'table_desc', '3', 'Table Desc', '2016-05-20 08:36:29', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list1)', 'database_id', '1', 'Database Id', '2016-05-20 08:35:42', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list1)', 'This will list records on the DICT_TABLE table.

Refer to <a href="%root%/dict_table(list1).html">List Database Tables</a> for full details.', '2005-06-29 19:39:46', 'AJM', '2009-08-14 14:48:42', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list2)', 'List Table by Database', 'Tables', 'PROC', 'table(list2).php', 'N', 'LIST2', 'DICT', NULL, NULL, NULL, NULL, 'table_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-12 22:53:15', 'AJM', '2009-06-26 18:24:00', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list2)', 'audit_dtl(list)3', '015', 'Audit Trail', 'Y', '2005-03-12 23:12:27', 'AJM', '2012-07-14 13:11:55', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list2)', 'audit_dtl(list)3exact', '016', 'Audit Trail (exact)', 'Y', '2005-03-12 23:45:26', 'AJM', '2012-07-14 13:11:56', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list2)', 'dict_column(list2)', '011', 'Columns', 'Y', '2005-03-12 23:34:39', 'AJM', '2012-07-14 13:11:55', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list2)', 'dict_relationship(list2)a', '013', 'Child Relationships (Table)', 'Y', '2005-03-20 12:09:07', 'AJM', '2012-07-14 13:11:55', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list2)', 'dict_relationship(list2)b', '014', 'Parent Relationships (Table)', 'Y', '2012-06-23 19:06:13', 'AJM', '2012-07-14 13:11:55', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list2)', 'dict_relationship(list2)c', '007', 'Child Relationships (DB)', 'N', '2005-03-21 20:20:39', 'AJM', '2012-07-14 13:10:50', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list2)', 'dict_relationship(list2)d', '008', 'Parent Relationships(DB)', 'N', '2012-07-14 13:11:11', 'AJM', '2012-07-14 13:12:17', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list2)', 'dict_table_key(list2)', '012', 'Keys', 'Y', '2005-03-19 18:23:12', 'AJM', '2012-07-14 13:11:55', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list2)', 'dict_table(add4)import', '006', 'Import Tables', 'N', '2005-03-13 14:54:39', 'AJM', '2009-06-26 18:37:37', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list2)', 'dict_table(del1)', '004', 'Delete', 'Y', '2005-03-12 23:11:54', 'AJM', '2009-06-26 18:23:58', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list2)', 'dict_table(enq1)', '002', 'Read', 'Y', '2005-03-12 23:11:54', 'AJM', '2009-06-26 18:23:58', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list2)', 'dict_table(output2)', '009', 'Output to PDF(L)', 'N', '2006-08-17 20:33:39', 'AJM', '2012-07-14 13:11:55', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list2)', 'dict_table(search)', '005', 'Search', 'N', '2005-03-12 23:11:55', 'AJM', '2009-06-26 18:23:58', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list2)', 'dict_table(upd1)', '003', 'Update', 'Y', '2005-03-12 23:11:55', 'AJM', '2009-06-26 18:27:26', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list2)', 'dict_table(upd4)export', '010', 'Export to PHP', 'Y', '2005-03-27 20:38:27', 'AJM', '2012-07-14 13:11:55', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table(list2)', '2014-04-19 12:25:56', 'AJM', NULL, NULL);

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list2)', 'table_id', '1', 'Table Id', '2016-05-20 08:38:08', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list2)', 'table_desc', '2', 'Table Desc', '2016-05-20 08:38:25', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(list2)', 'This will list records on the DICT_TABLE table for a selected DATABASE.

Refer to <a href="%root%/dict_table(list2).html">List Table by Database</a> for full details.', '2005-06-29 19:32:01', 'AJM', '2009-08-14 14:48:51', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(output2)', 'Output to PDF - List view', 'Output to PDF(L)', 'PROC', 'table(output2).php', 'N', 'OUTPUT2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-08-17 20:32:47', 'AJM', '2009-06-26 18:28:36', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table(output2)', '2014-04-19 12:25:56', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(popup2)', 'Choose Database Table', 'Choose', 'PROC', 'table(popup2).php', 'N', 'POPUP2', 'DICT', NULL, NULL, NULL, NULL, 'table_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-20 12:44:13', 'AJM', '2013-10-26 17:39:18', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table(popup2)', '2014-04-19 12:25:56', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(popup2)', 'This will list records on the DICT_TABLE table and allow one or more to be selected. 

After selecting records please press the CHOOSE button. 

Refer to <a href="%root%/dict_table(popup1).html">Choose Database Table</a> for full details.', '2005-06-29 19:21:33', 'AJM', '2013-10-26 17:39:17', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(popup2)jnr', 'Choose Database Table', 'Choose', 'PROC', 'table(popup2).php', 'N', 'POPUP2', 'DICT', NULL, NULL, NULL, NULL, 'table_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-02-27 18:47:56', 'AJM', '2013-10-26 17:39:44', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table(popup2)jnr', '2014-04-19 12:25:57', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(popup2)snr', 'Choose Database Table', 'Choose', 'PROC', 'table(popup2).php', 'N', 'POPUP2', 'DICT', NULL, NULL, NULL, NULL, 'table_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-21 20:40:10', 'AJM', '2013-10-26 17:40:05', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table(popup2)snr', '2014-04-19 12:25:57', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(popup2)snr', 'This will list records on the DICT_TABLE table and allow one or more to be selected. 

After selecting records please press the CHOOSE button. 

Refer to <a href="%root%/dict_table(popup1).html">Choose Database Table</a> for full details.', '2005-06-29 19:21:54', 'AJM', '2013-10-26 17:40:03', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(search)', 'Search Table', 'Search', 'PROC', 'table(search).php', 'N', 'SRCH', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-12 23:09:02', 'AJM', '2009-06-26 18:25:22', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dict_table(search)', '2014-04-19 12:25:57', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(search)', 'This will allow search criteria to be entered for the DICT_TABLE table. 

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/dict_table(search).html">Search Table</a> for full details.', '2005-06-29 19:17:04', 'AJM', '2005-07-02 15:40:48', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(upd1)', 'Update Table', 'Update', 'PROC', 'table(upd1).php', 'N', 'UPD1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-12 23:09:25', 'AJM', '2009-06-26 18:27:26', 'AJM');

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(upd1)', 'This will display the contents of a record from the DICT_TABLE table and allow it to be updated.

Refer to <a href="%root%/dict_table(upd1).html">Update Table</a> for full details.', '2005-06-29 19:19:45', 'AJM', '2009-08-14 14:49:27', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dict_table(upd4)export', 'Export Table Script', 'Export', 'PROC', 'table(upd4)export.php', 'N', 'UPD4', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-03-27 20:37:04', 'AJM', '2009-06-26 18:31:04', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dictionary', 'Data Dictionary', 'Dict', 'MENU', 'menu.php', 'N', 'MENU', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, NULL, NULL, '2005-03-12 18:37:06', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DICT-RO', 'dictionary', '2014-04-19 12:25:40', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('dictionary', 'Data Dictionary', 'Dict', 'MENU', 'menu.php', 'N', 'MENU', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, NULL, NULL, '2005-03-12 18:37:06', 'AJM', NULL, NULL);

INSERT INTO mnu_menu (menu_id, task_id_jnr, sort_seq, button_text, created_date, created_user, revised_date, revised_user) VALUES ('dictionary', 'dict_column(list1)', '005', 'Columns', '2005-04-24 12:20:31', 'AJM', '2009-06-26 11:30:45', 'AJM');
INSERT INTO mnu_menu (menu_id, task_id_jnr, sort_seq, button_text, created_date, created_user, revised_date, revised_user) VALUES ('dictionary', 'dict_database(list1)', '001', 'Databases', '2005-03-12 18:38:21', 'AJM', '2009-06-26 16:12:48', 'AJM');
INSERT INTO mnu_menu (menu_id, task_id_jnr, sort_seq, button_text, created_date, created_user, revised_date, revised_user) VALUES ('dictionary', 'dict_relationship(list1)', '004', 'Relationships', '2005-04-24 11:52:31', 'AJM', '2009-06-26 17:44:53', 'AJM');
INSERT INTO mnu_menu (menu_id, task_id_jnr, sort_seq, button_text, created_date, created_user, revised_date, revised_user) VALUES ('dictionary', 'dict_table_key(list1)', '003', 'Keys', '2005-06-10 09:23:39', 'AJM', '2009-06-26 19:04:28', 'AJM');
INSERT INTO mnu_menu (menu_id, task_id_jnr, sort_seq, button_text, created_date, created_user, revised_date, revised_user) VALUES ('dictionary', 'dict_table(list1)', '002', 'Tables', '2005-04-24 10:49:34', 'AJM', '2009-06-26 18:21:54', 'AJM');

INSERT INTO mnu_menu (menu_id, task_id_jnr, sort_seq, button_text, created_date, created_user, revised_date, revised_user) VALUES ('main_menu', 'dictionary', '002', 'Dictionary', '2005-03-12 18:37:25', 'AJM', '2005-05-05 17:47:27', 'AJM');

-- finished
