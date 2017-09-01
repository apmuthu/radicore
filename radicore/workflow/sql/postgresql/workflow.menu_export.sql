-- file created on May 5, 2017, 9:34 am

-- SET search_path TO "menu";
    
INSERT INTO mnu_subsystem (subsys_id, subsys_name, subsys_desc, subsys_dir, task_prefix, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'Workflow', NULL, 'workflow', 'wf_', '2004-04-03 23:42:43', 'AJM', '2006-04-22 09:39:56', 'AJM');

INSERT INTO mnu_role (role_id, role_name, role_desc, start_task_id, global_access, is_external_auth_off, created_date, created_user, revised_date, revised_user) VALUES ('DEMO', 'Demonstration Class', NULL, 'main_menu', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2009-07-22 00:55:33', 'AJM');
INSERT INTO mnu_role (role_id, role_name, role_desc, start_task_id, global_access, is_external_auth_off, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'WORKFLOW', NULL, 'workflow', 'N', 'N', '2014-04-19 12:22:14', 'AJM', '2014-04-20 12:54:42', 'AJM');
INSERT INTO mnu_role (role_id, role_name, role_desc, start_task_id, global_access, is_external_auth_off, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'WORKFLOW read-only', NULL, 'workflow', 'N', 'N', '2014-04-20 12:47:57', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_arc(add)', 'Insert Workflow Arc', NULL, 'New', 'PROC', 'arc.add.php', 'N', 'ADD2', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-12 19:22:22', 'AJM', '2004-04-17 18:37:17', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_arc(add)', '2014-04-20 12:06:46', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_arc(add)', 'This will allow a record to be added to the WF_ARC table for a selected WORKFLOW.

Refer to <a href="%root%/wf_arc(add).html">Add Workflow Arc</a> for full details.', '2005-07-02 16:19:06', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_arc(del)', 'Delete Workflow Arc', NULL, 'Delete', 'PROC', 'arc.del.php', 'N', 'DEL1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-12 19:24:59', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_arc(del)', '2014-04-20 12:06:46', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_arc(del)', 'This will display a record from the WF_ARC table and allow it to be deleted.

Refer to <a href="%root%/wf_arc(del).html">Delete Workflow Arc</a> for full details.', '2005-07-02 16:27:14', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_arc(enq)', 'Enquire Workflow Arc', NULL, 'Read', 'PROC', 'arc.enq.php', 'N', 'ENQ1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-12 19:24:21', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_arc(enq)', '2014-04-19 12:31:09', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_arc(enq)', '2014-04-20 12:48:43', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_arc(enq)', 'This will display the contents of a record from the WF_ARC table.

Refer to <a href="%root%/wf_arc(enq).html">Enquire Workflow Arc</a> for full details.', '2005-07-02 16:55:28', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_arc(list)', 'List Workflow Arc', NULL, 'Arc', 'PROC', 'arc.list.php', 'N', 'LIST2', 'WORKFLOW', NULL, NULL, NULL, NULL, 'place_type,place_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-12 19:21:28', 'AJM', '2007-03-20 18:07:46', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_arc(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-12 19:26:31', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_arc(list)', 'wf_arc(add)', '001', 'New', 'N', '2004-04-12 19:25:58', 'AJM', '2004-04-12 19:26:19', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_arc(list)', 'wf_arc(del)', '004', 'Delete', 'Y', '2004-04-12 19:25:58', 'AJM', '2004-04-12 19:26:19', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_arc(list)', 'wf_arc(enq)', '002', 'Read', 'Y', '2004-04-12 19:25:58', 'AJM', '2004-04-12 19:26:19', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_arc(list)', 'wf_arc(search)', '005', 'Search', 'N', '2004-04-12 19:25:58', 'AJM', '2004-04-12 19:26:19', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_arc(list)', 'wf_arc(upd)', '003', 'Update', 'Y', '2004-04-12 19:25:58', 'AJM', '2004-04-12 19:26:19', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_arc(list)', '2014-04-19 12:31:10', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_arc(list)', '2014-04-20 12:48:43', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_arc(list)', 'This will list records on the WF_ARC table for a selected WORKFLOW.

Refer to <a href="%root%/wf_arc(list).html">List Workflow Arc</a> for full details.', '2005-07-02 16:04:44', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_arc(search)', 'Search Workflow Arc', NULL, 'Search', 'PROC', 'arc.search.php', 'N', 'SRCH', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-12 19:25:33', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_arc(search)', '2014-04-19 12:31:10', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_arc(search)', '2014-04-20 12:48:43', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_arc(search)', 'This will allow search criteria to be entered for the WF_ARC table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/wf_arc(search).html">Search Workflow Arc</a> for full details.', '2005-07-02 17:01:25', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_arc(upd)', 'Update Workflow Arc', NULL, 'Update', 'PROC', 'arc.upd.php', 'N', 'UPD1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-12 19:22:55', 'AJM', '2004-04-16 17:33:59', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_arc(upd)', '2014-04-20 12:06:47', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_arc(upd)', 'This will display the contents of a record from the WF_ARC table and allow it to be updated. 

Refer to <a href="%root%/wf_arc(upd).html">Update Workflow Arc</a> for full details.', '2005-07-02 17:04:47', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(enq)', 'Enquire Workflow Case', NULL, 'Read', 'PROC', 'case.enq.php', 'N', 'ENQ1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-25 11:00:14', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_case(enq)', '2014-04-19 12:31:10', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_case(enq)', '2014-04-20 12:48:44', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(enq)', 'This will display the contents of a record from the WF_CASE table.

Refer to <a href="%root%/wf_case(enq).html">Enquire Workflow Case</a> for full details.', '2005-07-02 16:55:47', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)', 'List Workflow Case', NULL, 'Case', 'PROC', 'case.list.php', 'N', 'LIST1', 'WORKFLOW', NULL, NULL, NULL, NULL, 'case_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-25 10:48:24', 'AJM', '2004-05-18 15:03:20', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)', 'audit_dtl(list)3', '010', 'Audit Trail', 'Y', '2006-02-18 18:37:09', 'AJM', '2016-12-02 15:50:38', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)', 'date(current)', '002', 'Current', 'N', '2004-04-25 11:44:54', 'AJM', '2004-04-25 11:45:10', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)', 'date(historic)', '003', 'Historic', 'N', '2004-04-25 11:44:54', 'AJM', '2004-04-25 11:45:10', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)', 'wf_case(enq)', '004', 'Read', 'Y', '2004-04-25 11:00:38', 'AJM', '2004-04-25 11:45:10', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)', 'wf_case(search)', '001', 'Search', 'N', '2004-04-25 11:10:50', 'AJM', '2004-04-25 11:10:57', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)', 'wf_case(upd1)a', '007', 'CANCEL', 'Y', '2016-12-02 15:50:13', 'AJM', '2016-12-02 15:50:39', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)', 'wf_case(upd1)b', '008', 'SUSPEND', 'Y', '2016-12-02 15:50:14', 'AJM', '2016-12-02 15:50:39', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)', 'wf_case(upd1)c', '009', 'REOPEN', 'Y', '2016-12-02 15:50:15', 'AJM', '2016-12-02 15:50:39', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)', 'wf_token(list)2', '005', 'Tokens', 'Y', '2004-04-26 15:03:43', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)', 'wf_workitem(list)2', '006', 'WorkItems', 'Y', '2004-04-26 15:04:01', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_case(list)', '2014-04-19 12:31:11', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_case(list)', '2014-04-20 12:48:44', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)', 'This will list records on the WF_CASE table.

Refer to <a href="%root%/wf_case(list).html">List Workflow Case</a> for full details.', '2005-07-02 15:48:56', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)2', 'List Case within Workflow', NULL, 'Cases', 'PROC', 'case.list2.php', 'N', 'LIST2', 'WORKFLOW', NULL, NULL, NULL, NULL, 'case_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-26 14:03:18', 'AJM', '2007-03-20 18:08:02', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)2', 'audit_dtl(list)3', '010', 'Audit Trail', 'Y', '2006-02-18 18:37:27', 'AJM', '2016-12-02 15:52:03', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)2', 'date(current)', '003', 'Current', 'N', '2004-04-26 14:50:45', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)2', 'date(historic)', '004', 'Historic', 'N', '2004-04-26 14:50:45', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)2', 'wf_case(enq)', '001', 'Read', 'Y', '2004-04-26 14:47:11', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)2', 'wf_case(search)', '002', 'Search', 'N', '2004-04-26 14:47:11', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)2', 'wf_case(upd1)a', '007', 'CANCEL', 'Y', '2016-12-02 15:51:42', 'AJM', '2016-12-02 15:52:04', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)2', 'wf_case(upd1)b', '008', 'SUSPEND', 'Y', '2016-12-02 15:51:42', 'AJM', '2016-12-02 15:52:04', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)2', 'wf_case(upd1)c', '009', 'REOPEN', 'Y', '2016-12-02 15:51:43', 'AJM', '2016-12-02 15:52:04', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)2', 'wf_token(list)2', '005', 'Tokens', 'Y', '2004-04-26 15:02:36', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)2', 'wf_workitem(list)2', '006', 'WorkItems', 'Y', '2004-04-26 15:03:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_case(list)2', '2014-04-19 12:31:11', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_case(list)2', '2014-04-20 12:48:44', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(list)2', 'This will list records on the WF_CASE table for a selected WORKFLOW.

Refer to <a href="%root%/wf_case(list)2.html">List Case within Wrkflow</a> for full details.', '2005-07-02 16:05:30', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(search)', 'Search Workflow Case', NULL, 'Search', 'PROC', 'case.search.php', 'N', 'SRCH', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-25 11:10:30', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_case(search)', '2014-04-19 12:31:11', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_case(search)', '2014-04-20 12:48:45', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(search)', 'This will allow search criteria to be entered for the WF_CASE table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/wf_case(search).html">Search Workflow Case</a> for full details.', '2005-07-02 17:01:53', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(upd1)a', 'Cancel Workflow Case', NULL, 'CANCEL', 'PROC', 'case(upd1)status.php', 'N', 'UPD1', 'WORKFLOW', NULL, NULL, NULL, 'case_status=CA', NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2016-12-02 15:47:07', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(upd1)b', 'Suspend Workflow Case', NULL, 'SUSPEND', 'PROC', 'case(upd1)status.php', 'N', 'UPD1', 'WORKFLOW', NULL, NULL, NULL, 'case_status=SU', NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2016-12-02 15:48:03', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_case(upd1)c', 'Reopen Workflow Case', NULL, 'REOPEN', 'PROC', 'case(upd1)status.php', 'N', 'UPD1', 'WORKFLOW', NULL, NULL, NULL, 'case_status=OP', NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2016-12-02 15:48:46', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(add)', 'Insert Workflow Place', NULL, 'Insert', 'PROC', 'place.add.php', 'N', 'ADD2', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-12 18:53:01', 'AJM', '2004-04-17 18:37:23', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_place(add)', '2014-04-20 12:06:47', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(add)', 'This will allow a record to be added to the WF_PLACE table for a selected WORKFLOW.

Refer to <a href="%root%/wf_place(add).html">Add Workflow Place</a> for full details.', '2005-07-02 16:19:30', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(del)', 'Delete Workflow Place', NULL, 'Delete', 'PROC', 'place.del.php', 'N', 'DEL1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-12 18:56:06', 'AJM', '2004-04-12 18:57:24', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_place(del)', '2014-04-20 12:06:47', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(del)', 'This will display a record from the WF_PLACE table and allow it to be deleted.

Refer to <a href="%root%/wf_place(del).html">Delete Workflow Place</a> for full details.', '2005-07-02 16:28:04', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(enq)', 'Enquire Workflow Place', NULL, 'Read', 'PROC', 'place.enq.php', 'N', 'ENQ1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-12 18:55:34', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_place(enq)', '2014-04-19 12:30:49', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_place(enq)', '2014-04-20 12:49:01', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(enq)', 'This will display the contents of a record from the WF_PLACE table.

Refer to <a href="%root%/wf_place(enq).html">Enquire Workflow Place</a> for full details.', '2005-07-02 16:56:06', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(list)', 'List Workflow Place', NULL, 'Place', 'PROC', 'place.list.php', 'N', 'LIST2', 'WORKFLOW', NULL, NULL, NULL, NULL, 'place_type,place_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-12 18:51:05', 'AJM', '2007-03-20 18:08:08', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-12 19:01:02', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(list)', 'wf_place(add)', '001', 'New', 'N', '2004-04-12 18:57:46', 'AJM', '2004-04-12 19:06:49', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(list)', 'wf_place(del)', '004', 'Delete', 'Y', '2004-04-12 18:57:46', 'AJM', '2004-04-12 18:58:12', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(list)', 'wf_place(enq)', '002', 'Read', 'Y', '2004-04-12 18:57:46', 'AJM', '2004-04-12 18:58:12', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(list)', 'wf_place(search)', '005', 'Search', 'N', '2004-04-12 18:57:46', 'AJM', '2004-04-12 18:58:12', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(list)', 'wf_place(upd)', '003', 'Update', 'Y', '2004-04-12 18:57:46', 'AJM', '2004-04-12 18:58:12', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_place(list)', '2014-04-19 12:30:50', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_place(list)', '2014-04-20 12:49:01', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(list)', 'This will list records on the WF_PLACE table for a selected WORKFLOW.

Refer to <a href="%root%/wf_place(list).html">List Workflow Place</a> for full details.', '2005-07-02 16:05:53', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(popup)', 'Choose Workflow Place', NULL, 'Choose', 'PROC', 'place.popup.php', 'N', 'POPUP1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-12 18:57:08', 'AJM', '2006-10-06 13:50:20', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_place(popup)', '2014-04-19 12:30:50', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_place(popup)', '2014-04-20 12:49:01', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(popup)', 'This will list records on the WF_PLACE table and allow one or more to be selected.

After selecting records please press the CHOOSE button.

Refer to <a href="%root%/wf_place(popup).html">Choose Workflow Place</a> for full details.', '2005-07-02 16:59:25', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(search)', 'Search Workflow Place', NULL, 'Search', 'PROC', 'place.search.php', 'N', 'SRCH', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-12 18:56:35', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_place(search)', '2014-04-19 12:30:50', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_place(search)', '2014-04-20 12:49:02', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(search)', 'This will allow search criteria to be entered for the WF_PLACE table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/wf_place(search).html">Search Workflow Place</a> for full details.', '2005-07-02 17:02:13', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(upd)', 'Update Workflow Place', NULL, 'Update', 'PROC', 'place.upd.php', 'N', 'UPD1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-12 18:54:45', 'AJM', '2004-04-16 17:34:03', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_place(upd)', '2014-04-20 12:06:48', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_place(upd)', 'This will display the contents of a record from the WF_PLACE table and allow it to be updated. 

Refer to <a href="%root%/wf_place(upd).html">Update Workflow Place</a> for full details.', '2005-07-02 17:05:13', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_token(enq)', 'Enquire Workflow Token', NULL, 'Read', 'PROC', 'token.enq.php', 'N', 'ENQ1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-25 12:44:38', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_token(enq)', '2014-04-19 12:30:51', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_token(enq)', '2014-04-20 12:49:02', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_token(enq)', 'This will display the contents of a record from the WF_TOKEN table.

Refer to <a href="%root%/wf_token(enq).html">Enquire Workflow Token</a> for full details.', '2005-07-02 16:56:27', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_token(list)', 'List Workflow Token', NULL, 'Token', 'PROC', 'token.list.php', 'N', 'LIST1', 'WORKFLOW', NULL, NULL, NULL, NULL, 'token_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-25 12:11:01', 'AJM', '2004-05-18 15:04:07', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_token(list)', 'wf_token(enq)', '002', 'Read', 'Y', '2004-04-25 12:45:41', 'AJM', '2004-04-25 12:45:47', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_token(list)', 'wf_token(search)', '001', 'Search', 'N', '2004-04-25 12:45:41', 'AJM', '2004-04-25 12:45:48', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_token(list)', '2014-04-19 12:30:51', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_token(list)', '2014-04-20 12:49:02', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_token(list)', 'This will list records on the WF_TOKEN table.

Refer to <a href="%root%/wf_token(list).html">List Workflow Token</a> for full details.', '2005-07-02 15:49:41', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_token(list)2', 'List Token within Case', NULL, 'Tokens', 'PROC', 'token.list2.php', 'N', 'LIST2', 'WORKFLOW', NULL, NULL, NULL, NULL, 'case_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-26 15:01:10', 'AJM', '2007-03-20 18:08:13', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_token(list)2', 'wf_token(enq)', '001', 'Read', 'Y', '2004-04-26 15:11:37', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_token(list)2', 'wf_token(search)', '002', 'Search', 'N', '2004-04-26 15:11:37', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_token(list)2', '2014-04-19 12:30:51', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_token(list)2', '2014-04-20 12:49:03', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_token(list)2', 'This will list records on the WF_TOKEN table for a selected WORKFLOW CASE.

Refer to <a href="%root%/wf_token(list)2.html">List Token within Case</a> for full details.', '2005-07-02 16:06:42', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_token(search)', 'Search Workflow Token', NULL, 'Search', 'PROC', 'token.search.php', 'N', 'SRCH', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-25 12:45:16', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_token(search)', '2014-04-19 12:30:31', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_token(search)', '2014-04-20 12:49:16', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_token(search)', 'This will allow search criteria to be entered for the WF_TOKEN table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/wf_token(search).html">Search Workflow Token</a> for full details.', '2005-07-02 17:02:38', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(add)', 'Insert Workflow Transition', NULL, 'New', 'PROC', 'transition.add.php', 'N', 'ADD2', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-11 19:50:38', 'AJM', '2004-04-17 18:37:27', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_transition(add)', '2014-04-20 12:06:48', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(add)', 'This will allow a record to be added to the WF_TRANSITION table for a selected WORKFLOW.

Refer to <a href="%root%/wf_transition(add).html">Add Workflow Transition</a> for full details.', '2005-07-02 16:19:56', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(del)', 'Delete Workflow Transition', NULL, 'Delete', 'PROC', 'transition.del.php', 'N', 'DEL1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-11 19:51:13', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_transition(del)', '2014-04-20 12:06:48', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(del)', 'This will display a record from the WF_TRANSITION table and allow it to be deleted.

Refer to <a href="%root%/wf_transition(del).html">Delete Workflow Transition</a> for full details.', '2005-07-02 16:53:44', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(enq)', 'Enquire Workflow Transition', NULL, 'Read', 'PROC', 'transition.enq.php', 'N', 'ENQ1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-11 19:51:55', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_transition(enq)', '2014-04-19 12:30:31', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_transition(enq)', '2014-04-20 12:49:16', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(enq)', 'This will display the contents of a record from the WF_TRANSITION table.

Refer to <a href="%root%/wf_transition(enq).html">Enquire Workflow Transition</a> for full details.', '2005-07-02 16:56:52', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(list)', 'List Workflow Transition', NULL, 'Transition', 'PROC', 'transition.list.php', 'N', 'LIST2', 'WORKFLOW', NULL, NULL, NULL, NULL, 'transition_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-11 19:15:08', 'AJM', '2007-03-20 18:08:18', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-12 19:01:54', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(list)', 'wf_transition(add)', '001', 'New', 'N', '2004-04-11 19:52:12', 'AJM', '2004-04-11 20:18:44', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(list)', 'wf_transition(del)', '004', 'Delete', 'Y', '2004-04-11 19:45:56', 'AJM', '2004-04-11 19:53:13', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(list)', 'wf_transition(enq)', '002', 'Read', 'Y', '2004-04-11 19:45:56', 'AJM', '2004-04-11 19:53:13', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(list)', 'wf_transition(search)', '005', 'Search', 'N', '2004-04-11 19:45:56', 'AJM', '2004-04-11 19:53:13', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(list)', 'wf_transition(upd)', '003', 'Update', 'Y', '2004-04-11 19:45:56', 'AJM', '2004-04-11 19:53:13', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_transition(list)', '2014-04-19 12:30:32', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_transition(list)', '2014-04-20 12:49:16', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(list)', 'This will list records on the WF_TRANSITION table for a selected WORKFLOW.

Refer to <a href="%root%/wf_transition(list).html">List Workflow Transition</a> for full details.', '2005-07-02 16:07:15', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(popup)', 'Choose Workflow Transition', NULL, 'Choose', 'PROC', 'transition.popup.php', 'N', 'POPUP1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-11 19:20:53', 'AJM', '2006-10-06 13:50:39', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_transition(popup)', '2014-04-19 12:30:32', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_transition(popup)', '2014-04-20 12:49:17', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(popup)', 'This will list records on the WF_TRANSITION table and allow one or more to be selected.

After selecting records please press the CHOOSE button.

Refer to <a href="%root%/wf_transition(popup).html">Choose Workflow Transition</a> for full details.', '2005-07-02 16:59:51', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(search)', 'Search Workflow Transition', NULL, 'Search', 'PROC', 'transition.search.php', 'N', 'SRCH', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-11 19:20:12', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_transition(search)', '2014-04-19 12:30:33', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_transition(search)', '2014-04-20 12:49:17', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(search)', 'This will allow search criteria to be entered for the WF_TRANSITION table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/wf_transition(search).html">Search Workflow Transition</a> for full details.', '2005-07-02 17:03:01', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(upd)', 'Update Workflow Transition', NULL, 'Update', 'PROC', 'transition.upd.php', 'N', 'UPD1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-11 19:19:31', 'AJM', '2004-04-16 17:34:08', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_transition(upd)', '2014-04-20 12:06:49', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_transition(upd)', 'This will display the contents of a record from the WF_TRANSITION table and allow it to be updated. 

Refer to <a href="%root%/wf_transition(upd).html">Update Workflow Transition</a> for full details.', '2005-07-02 17:05:35', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(add)', 'Insert Workflow Process', NULL, 'New', 'PROC', 'workflow.add.php', 'N', 'ADD1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-03 23:56:59', 'AJM', '2004-04-17 18:36:57', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workflow(add)', '2014-04-20 12:06:49', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(add)', 'This will allow a new record to be added to the WF_WORKFLOW table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href="%root%/wf_workflow(add).html">Add Workflow process</a> for full details.', '2005-07-02 16:17:58', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(del)', 'Delete Workflow Process', NULL, 'Delete', 'PROC', 'workflow.del.php', 'N', 'DEL1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-03 23:58:01', 'AJM', '2004-04-11 15:53:50', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workflow(del)', '2014-04-20 12:06:55', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(del)', 'This will display a record from the WF_WORKFLOW table and allow it to be deleted.

Refer to <a href="%root%/wf_workflow(del).html">Delete Workflow Process</a> for full details.', '2005-07-02 16:54:10', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(enq)', 'Enquire Workflow Process', NULL, 'Read', 'PROC', 'workflow.enq.php', 'N', 'ENQ1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-03 23:58:34', 'AJM', '2004-04-11 15:54:00', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workflow(enq)', '2014-04-19 12:29:53', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_workflow(enq)', '2014-04-20 12:49:35', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(enq)', 'This will display the contents of a record from the WF_WORKFLOW table.

Refer to <a href="%root%/wf_workflow(enq).html">Enquire Workflow Process</a> for full details.', '2005-07-02 16:57:15', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(list)', 'List Workflow Process', NULL, 'Workflow', 'PROC', 'workflow.list.php', 'N', 'LIST1', 'WORKFLOW', NULL, NULL, NULL, NULL, 'workflow_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-03 23:56:07', 'AJM', '2004-05-18 15:05:43', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(list)', 'audit_dtl(list)3', '013', 'Audit Trail', 'Y', '2004-04-09 11:57:37', 'AJM', '2004-04-26 14:14:18', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(list)', 'audit_dtl(list)3exact', '014', 'Audit Trail (2)', 'Y', '2004-07-21 16:56:01', 'AJM', '2004-07-21 16:56:42', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(list)', 'date(current)', '010', 'Current', 'N', '2004-04-17 18:27:51', 'AJM', '2004-04-17 18:28:13', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(list)', 'date(historic)', '011', 'Historic', 'N', '2004-04-17 18:27:51', 'AJM', '2004-04-17 18:28:14', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(list)', 'wf_arc(list)', '009', 'Arcs', 'Y', '2004-04-12 19:27:07', 'AJM', '2004-04-26 14:41:27', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(list)', 'wf_case(list)2', '012', 'Cases', 'Y', '2004-04-26 14:12:30', 'AJM', '2004-04-26 14:14:18', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(list)', 'wf_place(list)', '008', 'Places', 'Y', '2004-04-12 18:59:27', 'AJM', '2004-04-26 14:41:27', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(list)', 'wf_transition(list)', '007', 'Transitions', 'Y', '2004-04-11 19:15:43', 'AJM', '2004-04-26 14:41:27', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(list)', 'wf_workflow(add)', '001', 'New', 'N', '2004-04-04 00:00:30', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(list)', 'wf_workflow(del)', '004', 'Delete', 'Y', '2004-04-04 00:00:30', 'AJM', '2004-04-04 00:00:54', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(list)', 'wf_workflow(enq)', '002', 'Read', 'Y', '2004-04-04 00:00:30', 'AJM', '2004-04-04 00:00:54', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(list)', 'wf_workflow(search)', '005', 'Search', 'N', '2004-04-04 00:00:30', 'AJM', '2004-04-04 00:00:54', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(list)', 'wf_workflow(upd)', '003', 'Update', 'Y', '2004-04-04 00:00:30', 'AJM', '2004-04-04 00:00:55', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(list)', 'wf_workflow(validate)', '006', 'Validate', 'Y', '2004-04-16 20:18:58', 'AJM', '2004-04-26 14:41:27', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workflow(list)', '2014-04-19 12:29:53', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_workflow(list)', '2014-04-20 12:49:35', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(list)', 'This will list records on the WF_WORKFLOW table.

Refer to <a href="%root%/wf_workflow(list).html">List Workflow Process</a> for full details.', '2005-07-02 15:50:07', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(popup)', 'Choose Workflow Process', NULL, 'Choose', 'PROC', 'workflow.popup.php', 'N', 'POPUP1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-04 00:00:09', 'AJM', '2006-10-06 13:50:58', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workflow(popup)', '2014-04-19 12:29:54', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_workflow(popup)', '2014-04-20 12:49:36', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(popup)', 'This will list records on the WF_WORKFLOW table and allow one or more to be selected.

After selecting records please press the CHOOSE button.

Refer to <a href="%root%/wf_workflow(popup).html">Choose Workflow Process</a> for full details.', '2005-07-02 17:00:15', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(search)', 'Search Workflow Process', NULL, 'Search', 'PROC', 'workflow.search.php', 'N', 'SRCH', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-03 23:59:39', 'AJM', '2004-04-11 15:54:34', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workflow(search)', '2014-04-19 12:29:54', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_workflow(search)', '2014-04-20 12:49:36', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(search)', 'This will allow search criteria to be entered for the WF_WORKFLOW table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/wf_workflow(search).html">Search Workflow Process</a> for full details.', '2005-07-02 17:03:25', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(upd)', 'Update Workflow Process', NULL, 'Update', 'PROC', 'workflow.upd.php', 'N', 'UPD1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-03 23:59:07', 'AJM', '2004-04-16 17:34:12', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workflow(upd)', '2014-04-20 12:06:56', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(upd)', 'This will display the contents of a record from the WF_WORKFLOW table and allow it to be updated. 

Refer to <a href="%root%/wf_workflow(upd).html">Update Workflow Process</a> for full details.', '2005-07-02 17:05:57', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_workflow(validate)', 'Validate Workflow Process', NULL, 'Validate', 'PROC', 'workflow.upd(validate).php', 'N', 'UPD4', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-16 20:18:20', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workflow(validate)', '2014-04-20 12:06:56', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(enq)', 'Enquire Workflow Workitem', NULL, 'Read', 'PROC', 'workitem.enq.php', 'N', 'ENQ1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-25 13:01:11', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workitem(enq)', '2014-04-19 12:29:54', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_workitem(enq)', '2014-04-20 12:49:37', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(enq)', 'This will display the contents of a record from the WF_WORKITEM table.

Refer to <a href="%root%/wf_workitem(enq).html">Enquire Workflow Workitem</a> for full details.', '2005-07-02 16:57:44', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(list)', 'List Workflow Workitem', NULL, 'Workitem', 'PROC', 'workitem.list.php', 'N', 'LIST1', 'WORKFLOW', NULL, NULL, NULL, NULL, 'case_id,workitem_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-25 13:00:42', 'AJM', '2004-05-18 15:11:37', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(list)', 'wf_workitem(enq)', '002', 'Read', 'Y', '2004-04-25 13:02:13', 'AJM', '2004-04-25 13:02:21', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(list)', 'wf_workitem(search)', '001', 'Search', 'N', '2004-04-25 13:02:13', 'AJM', '2004-04-25 13:02:21', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(list)', 'wf_workitem(upd)', '003', 'Update', 'Y', '2006-04-06 18:22:48', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workitem(list)', '2014-04-19 12:29:55', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_workitem(list)', '2014-04-20 12:49:37', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(list)', 'This will list records on the WF_WORKITEM table.

Refer to <a href="%root%/wf_workitem(list).html">List Workflow Workitem</a> for full details.', '2005-07-02 15:50:35', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(list)2', 'List Workitem within Case', NULL, 'WorkItems', 'PROC', 'workitem.list2.php', 'N', 'LIST2', 'WORKFLOW', NULL, NULL, NULL, NULL, 'workitem_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-26 15:01:56', 'AJM', '2007-03-20 18:08:23', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(list)2', 'wf_workitem(enq)', '001', 'Read', 'Y', '2004-04-26 15:20:09', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(list)2', 'wf_workitem(search)', '002', 'Search', 'N', '2004-04-26 15:20:09', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(list)2', 'wf_workitem(upd)', '003', 'Update', 'Y', '2006-04-06 18:23:15', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workitem(list)2', '2014-04-19 12:29:55', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_workitem(list)2', '2014-04-20 12:49:38', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(list)2', 'This will list records on the WF_WORKITEM table for a selected WORKFLOW CASE.

Refer to <a href="%root%/wf_workitem(list)2.html">List Workitem within Case</a> for full details.', '2005-07-02 16:07:56', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(list)expired', 'List Expired Workitems', NULL, 'Expired Workitems', 'PROC', 'workitem.list(expired).php', 'N', 'LIST1', 'WORKFLOW', NULL, NULL, NULL, NULL, 'case_id,workitem_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2007-08-05 16:15:54', 'AJM', '2007-08-06 11:14:32', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(list)expired', 'wf_workitem(enq)', '001', 'Read', 'Y', '2007-08-05 16:17:49', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(list)expired', 'wf_workitem(search)', '002', 'Search', 'N', '2007-08-05 16:18:02', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(list)expired', 'wf_workitem(upd)expired', '003', 'Trigger', 'Y', '2007-08-05 16:57:18', 'AJM', '2007-08-06 10:57:28', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workitem(list)expired', '2014-04-19 12:30:03', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_workitem(list)expired', '2014-04-20 12:49:38', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(search)', 'Search Workflow Workitem', NULL, 'Search', 'PROC', 'workitem.search.php', 'N', 'SRCH', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-25 13:01:38', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workitem(search)', '2014-04-19 12:29:35', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'wf_workitem(search)', '2014-04-20 12:49:50', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(search)', 'This will allow search criteria to be entered for the WF_WORKITEM table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/wf_workitem(search).html">Search Workflow Workitem</a> for full details.', '2005-07-02 17:03:48', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(upd)', 'Update Workflow Workitem', NULL, 'Update', 'PROC', 'workitem.upd.php', 'N', 'UPD1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-04-06 18:22:06', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workitem(upd)', '2014-04-20 12:06:56', 'AJM', NULL, NULL);

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(upd)', 'This will display the contents of a record from the WF_WORKITEM table and allow certain values to be changed.

Refer to <a href="%root%/wf_workitem(upd).html">Update Workflow Workitem</a> for full details.', '2006-04-07 11:49:24', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('wf_workitem(upd)expired', 'Trigger Expired Workitem', NULL, 'Trigger', 'PROC', 'workitem.upd(expired).php', 'N', 'UPD1', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2007-08-05 16:56:56', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'wf_workitem(upd)expired', '2014-04-20 12:06:57', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('workflow', 'Workflow', NULL, 'Workflow', 'MENU', 'menu.php', 'N', 'MENU', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-03 23:43:28', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('DEMO', 'workflow', '2014-04-20 12:11:45', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW', 'workflow', '2014-04-19 12:29:36', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('WORKFLOW-RO', 'workflow', '2014-04-20 12:49:50', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('workflow', 'Workflow', NULL, 'Workflow', 'MENU', 'menu.php', 'N', 'MENU', 'WORKFLOW', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-03 23:43:28', 'AJM', NULL, NULL);

INSERT INTO mnu_menu (menu_id, task_id_jnr, sort_seq, button_text, created_date, created_user, revised_date, revised_user) VALUES ('workflow', 'wf_case(list)', '002', 'Case', '2004-04-25 10:48:48', 'AJM', NULL, NULL);
INSERT INTO mnu_menu (menu_id, task_id_jnr, sort_seq, button_text, created_date, created_user, revised_date, revised_user) VALUES ('workflow', 'wf_token(list)', '003', 'Token', '2004-04-25 12:11:33', 'AJM', NULL, NULL);
INSERT INTO mnu_menu (menu_id, task_id_jnr, sort_seq, button_text, created_date, created_user, revised_date, revised_user) VALUES ('workflow', 'wf_workflow(list)', '001', 'Workflow', '2004-04-04 00:01:23', 'AJM', '2004-04-25 10:40:41', 'AJM');
INSERT INTO mnu_menu (menu_id, task_id_jnr, sort_seq, button_text, created_date, created_user, revised_date, revised_user) VALUES ('workflow', 'wf_workitem(list)', '004', 'Workitem', '2004-04-25 13:02:43', 'AJM', NULL, NULL);
INSERT INTO mnu_menu (menu_id, task_id_jnr, sort_seq, button_text, created_date, created_user, revised_date, revised_user) VALUES ('workflow', 'wf_workitem(list)expired', '005', 'Expired Workitems', '2007-08-05 16:17:04', 'AJM', NULL, NULL);

INSERT INTO mnu_menu (menu_id, task_id_jnr, sort_seq, button_text, created_date, created_user, revised_date, revised_user) VALUES ('main_menu', 'workflow', '003', 'Workflow', '2004-04-25 10:39:55', 'AJM', '2005-06-12 12:17:52', 'AJM');

-- finished
