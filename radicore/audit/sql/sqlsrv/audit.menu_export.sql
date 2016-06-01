-- file created on May 20, 2016, 9:32 am

-- use [menu];
    
INSERT INTO mnu_subsystem (subsys_id, subsys_desc, subsys_dir, task_prefix, created_date, created_user, revised_date, revised_user) VALUES ('AUDIT', 'Audit Trail', 'audit', 'audit_', '2003-01-01 12:00:00', 'AJM', '2006-04-22 09:38:17', 'AJM');

INSERT INTO mnu_role (role_id, role_desc, start_task_id, global_access, is_external_auth_off, created_date, created_user, revised_date, revised_user) VALUES ('AUDIT', 'AUDIT', 'main_menu', 'N', 'N', '2014-04-19 12:21:39', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('audit_dtl(del)', 'Delete Audit Detail', 'Delete', 'PROC', 'audit_dtl_del.php', 'N', 'DEL4', 'AUDIT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-03-20 15:29:33', 'AJM', '2006-03-20 16:50:22', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('audit_dtl(list)2', 'List Audit Details', 'List Audit', 'PROC', 'audit_dtl_list2.php', 'N', 'LIST2', 'AUDIT', 'audit_dtl(search)', NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2006-10-14 18:29:42', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('audit_dtl(list)2', 'audit_dtl(del)', '002', 'Delete', 'N', '2006-03-20 15:39:54', 'AJM', '2007-06-23 13:41:47', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('audit_dtl(list)2', 'audit_dtl(search)', '003', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-06-23 13:41:47', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('audit_dtl(list)2', 'audit_tbl(upd4)', '003', 'Generate SQL', 'N', '2007-06-23 13:41:06', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('AUDIT', 'audit_dtl(list)2', '2014-04-19 12:23:19', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('audit_dtl(list)2', 'This will list entries from the Audit Log.

Refer to <a href="%root%/audit_dtl(list)2.html">List Audit Details</a> for full details.', '2005-06-29 12:41:45', 'AJM', '2005-07-02 15:33:45', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('audit_dtl(list)3', 'List Audit Details for an Object', 'Audit Trail', 'PROC', 'audit_dtl_list3.php', 'N', 'LIST3', 'AUDIT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-08 16:25:44', 'AJM', '2006-01-18 18:04:09', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('AUDIT', 'audit_dtl(list)3', '2014-04-19 12:23:20', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('audit_dtl(list)3', 'This will allow the contents of the Audit Log to be viewed for selected objects.

This version will select those Audit Log entries where the the primary key of the selected object is contained with the PKEY value of the audited occurrence. This will include entries from subordinate (child) tables which contain the same field names within their primary keys.

Refer to <a href="%root%/audit_dtl(list)3.html">List Audit Details for a selected Object</a> for full details.', '2005-06-29 13:03:54', 'AJM', '2005-07-02 15:33:52', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('audit_dtl(list)3exact', 'List Audit Details for an Object (exact match)', 'Audit Trail', 'PROC', 'audit_dtl_list3.php', 'N', 'LIST3', 'AUDIT', NULL, NULL, NULL, 'pattern=exact', NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-07-21 16:54:14', 'AJM', '2006-06-20 14:53:08', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('AUDIT', 'audit_dtl(list)3exact', '2014-04-19 12:23:20', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('audit_dtl(list)3exact', 'This will allow the contents of the Audit Log to be viewed for selected objects.

This version will select only those Audit Log entries where the the primary key of the selected object is as exact match with the PKEY value of the audited occurrence. 

Refer to <a href="%root%/audit_dtl(list)3.html">List Audit Details for a selected Object</a> for full details.', '2005-06-29 16:17:59', 'AJM', '2005-07-02 15:34:01', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('audit_dtl(search)', 'Search Audit Detail', 'Search', 'PROC', 'audit_dtl_search.php', 'N', 'SRCH', 'AUDIT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2006-01-17 20:28:38', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('AUDIT', 'audit_dtl(search)', '2014-04-19 12:23:20', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('audit_dtl(search)', 'This will allow selection criteria to be entered before passing control back to the List Audit Detail screen.

Refer to <a href="%root%/audit_dtl(search).html">Search Audit Details</a> for full details.', '2005-06-29 12:37:59', 'AJM', '2005-07-02 15:34:07', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('audit_logon_errors(del)', 'Delete Audit Logon Errors', 'Delete', 'PROC', 'audit_logon_errors_del.php', 'N', 'DEL1', 'AUDIT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2010-07-31 20:11:14', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('audit_logon_errors(list)', 'List Logon Errors', 'Logon Errors', 'PROC', 'audit_logon_errors_list.php', 'N', 'LIST1', 'AUDIT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-03-08 14:52:07', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('audit_logon_errors(list)', 'audit_logon_errors(del)', '002', 'Delete', 'Y', '2010-07-31 20:11:39', 'AJM', '2010-07-31 20:19:05', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('audit_logon_errors(list)', 'audit_logon_errors(search)', '001', 'Search', 'N', '2006-03-08 15:27:28', 'AJM', '2010-07-31 20:19:05', 'AJM');

INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('audit_logon_errors(list)', 'user_id', '1', 'User Id', '2016-05-19 18:44:26', 'AJM', NULL, NULL);
INSERT INTO mnu_task_quicksearch (task_id, field_id, sort_seq, field_name, created_date, created_user, revised_date, revised_user) VALUES ('audit_logon_errors(list)', 'email_addr', '2', 'Email Address', '2016-05-19 18:44:49', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('audit_logon_errors(list)', 'This will show the details of any logon attemps which failed.

Refer to <a href="%root%/audit_logon_errors(list).html">List Logon Errors</a> for full details.', '2006-04-07 11:26:07', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('audit_logon_errors(search)', 'Search Logon Errors', 'Search', 'PROC', 'audit_logon_errors_search.php', 'N', 'SRCH', 'AUDIT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-03-08 15:27:14', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('AUDIT', 'audit_logon_errors(search)', '2014-04-19 12:23:21', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('audit_ssn(batch)delete', 'Delete Audit data', 'Delete', 'PROC', 'audit_ssn(batch)delete.php', 'N', 'BATCH', 'AUDIT', NULL, NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, NULL, NULL, NULL, '2012-01-24 16:12:38', 'AJM', '2012-01-24 16:27:06', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('audit_tbl(upd4)', 'Generate SQL', 'Generate SQL', 'PROC', 'audit_tbl(upd4).php', 'N', 'UPD4', 'AUDIT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2007-06-23 13:39:36', 'AJM', NULL, NULL);

INSERT INTO mnu_menu (menu_id, task_id_jnr, sort_seq, button_text, created_date, created_user, revised_date, revised_user) VALUES ('main_menu', 'audit_dtl(list)2', '004', 'Audit', '2003-01-01 12:00:00', 'AJM', '2005-06-12 12:17:52', 'AJM');

-- finished
