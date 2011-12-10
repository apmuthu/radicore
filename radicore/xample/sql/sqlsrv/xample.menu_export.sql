USE menu;

INSERT INTO mnu_subsystem (subsys_id, subsys_desc, subsys_dir, task_prefix, created_date, created_user, revised_date, revised_user) VALUES ('XAMPLE', 'Example application', 'xample', 'x_', '2003-01-01 12:00:00', 'AJM', '2006-04-22 09:40:39', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('test_autoinsert(add)', 'Test Auto Insert', 'Insert', 'PROC', 'test_autoincrement_add.php', 'Y', 'ADD1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2005-05-25 21:06:56', 'AJM', '2007-11-11 21:10:40', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_fix-last-addr-no(batch)', 'Fix Last Address No (batch)', 'Fix Addr No (batch)', 'PROC', 'fix-last-addr-no(batch).php', 'N', 'BATCH', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, NULL, '2008-11-27 15:07:25', 'AJM', '2008-11-27 15:09:06', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)', 'x_fix-last-addr-no(batch)', '016', 'Fix Addr No (batch)', 'N', '2008-11-27 15:08:08', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_option_alt(add2)', 'Add Option (Alternative Languages)', 'New', 'PROC', 'option_alt(add2).php', 'N', 'ADD2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-09 19:58:35', 'AJM', '2008-01-09 21:03:43', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option_alt(list2)', 'x_option_alt(add2)', '001', 'New', 'N', '2008-01-09 19:58:38', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_option_alt(del1)', 'Delete Option (Alternative Languages)', 'Delete', 'PROC', 'option_alt(del1).php', 'N', 'DEL1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-09 19:58:37', 'AJM', '2008-01-09 21:04:35', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option_alt(list2)', 'x_option_alt(del1)', '004', 'Delete', 'Y', '2008-01-09 19:58:39', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_option_alt(enq1)', 'Enquire Option (Alternative Languages)', 'Read', 'PROC', 'option_alt(enq1).php', 'N', 'ENQ1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-09 19:58:35', 'AJM', '2008-01-09 21:04:19', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option_alt(list2)', 'x_option_alt(enq1)', '002', 'Read', 'Y', '2008-01-09 19:58:38', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_option_alt(list2)', 'Maintain Alternative Languages for OPTION', 'Alternative Languages', 'PROC', 'option_alt(list2).php', 'N', 'LIST2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-09 19:58:34', 'AJM', '2008-01-09 21:02:50', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option_alt(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2008-01-09 19:58:40', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option_alt(list2)', 'x_option_alt(search)', '005', 'Search', 'N', '2008-01-09 19:58:39', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option_alt(list2)', 'x_option_alt(upd1)', '003', 'Update', 'Y', '2008-01-09 19:58:39', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option(list)', 'x_option_alt(list2)', '008', 'Alternative Languages', 'Y', '2008-01-09 21:05:44', 'AJM', '2008-01-09 21:05:55', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_option_alt(search)', 'Search Option (Alternative Languages)', 'Search', 'PROC', 'option_alt(search).php', 'N', 'SRCH', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-09 19:58:37', 'AJM', '2008-01-09 21:04:57', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_option_alt(upd1)', 'Update Option (Alternative Languages)', 'Update', 'PROC', 'option_alt(upd1).php', 'N', 'UPD1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-09 19:58:36', 'AJM', '2008-01-09 21:05:12', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_option(add)', 'Add Option', 'Insert', 'PROC', 'option_add.php', 'N', 'ADD1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option(list)', 'x_option(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_option(add)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_option(del)', 'Delete Option', 'Delete', 'PROC', 'option_del.php', 'N', 'DEL1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2008-01-30 14:11:20', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option(list)', 'x_option(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_option(del)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_option(enq)', 'Enquire Option', 'Enquire', 'PROC', 'option_enq.php', 'N', 'ENQ1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option(list)', 'x_option(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_option(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_option(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_option(list)', 'List Option', 'List Option', 'PROC', 'option_list.php', 'N', 'LIST1', 'XAMPLE', NULL, NULL, NULL, NULL, 'option_id', 'Y', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2005-01-31 18:14:44', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option(list)', 'audit_dtl(list)3', '009', 'Audit Trail', 'Y', '2004-04-09 11:39:32', 'AJM', '2008-01-09 21:05:55', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option(list)', 'x_option(search)', '007', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option(list)', 'x_option(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option(list)', 'x_pers_opt_xref(link)b', '006', 'Maintain Person', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option(list)', 'x_person(list)b', '005', 'List Person', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_option(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_option(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('USER1', 'x_option(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('USER2', 'x_option(list)', '2005-07-31 15:12:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('USER3', 'x_option(list)', '2005-07-31 15:15:55', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_option(list)a', 'List Option for a selected Person', 'List Option', 'PROC', 'option_list(a).php', 'N', 'LIST2', 'XAMPLE', NULL, NULL, NULL, NULL, 'option_id', 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2005-01-31 18:15:36', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option(list)a', 'audit_dtl(list)3', '004', 'Audit Trail', 'Y', '2004-04-09 11:59:47', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option(list)a', 'x_option(search)', '003', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option(list)a', 'x_pers_opt_xref(add)a', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option(list)a', 'x_pers_opt_xref(del)', '002', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)', 'x_option(list)a', '007', 'List Options', 'Y', '2003-01-01 12:00:00', 'AJM', '2006-07-30 10:13:44', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_option(list)a', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_option(list)a', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_option(popup)', 'Choose Options', 'Choose', 'PROC', 'option_popup.php', 'N', 'POPUP1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2006-10-06 13:51:30', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_option(popup)', 'x_option(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_option(popup)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_option(popup)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_option(search)', 'Search Option', 'Search', 'PROC', 'option_search.php', 'N', 'SRCH', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_opt_xref(link)a', 'x_option(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_option(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_option(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_option(upd)', 'Update Option', 'Update', 'PROC', 'option_upd.php', 'N', 'UPD1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2008-01-30 18:27:26', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_option(upd)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_opt_xref(add)', 'Add Person(s) to selected Option', 'Insert', 'PROC', 'pers_opt_xref_add.php', 'N', 'ADD3', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)b', 'x_pers_opt_xref(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_pers_opt_xref(add)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_opt_xref(add)a', 'Add Option(s) to selected Person', 'Insert', 'PROC', 'pers_opt_xref_add(a).php', 'N', 'ADD3', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_pers_opt_xref(add)a', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_opt_xref(del)', 'Delete from Person/Option cross-reference', 'Delete', 'PROC', 'pers_opt_xref_del.php', 'N', 'DEL2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)b', 'x_pers_opt_xref(del)', '003', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_pers_opt_xref(del)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_opt_xref(link)a', 'Link Option(s) to selected Person', 'Maintain Option', 'PROC', 'pers_opt_xref_link(a).php', 'N', 'LINK1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2006-03-19 18:06:42', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)', 'x_pers_opt_xref(link)a', '008', 'Maintain Options', 'Y', '2003-01-01 12:00:00', 'AJM', '2006-07-30 10:13:44', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_pers_opt_xref(link)a', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_opt_xref(link)b', 'Link Person(s) to selected Option', 'Maintain Person', 'PROC', 'pers_opt_xref_link(b).php', 'N', 'LINK1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2006-01-20 23:19:01', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_opt_xref(link)b', 'x_person(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_pers_opt_xref(link)b', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type_alt(add2)', 'Add Person Type (Alternative Languages)', 'New', 'PROC', 'pers_type_alt(add2).php', 'N', 'ADD2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-07 11:48:31', 'AJM', '2008-01-07 12:00:34', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type_alt(list2)', 'x_pers_type_alt(add2)', '001', 'New', 'N', '2008-01-07 11:48:34', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type_alt(del1)', 'Delete Person Type (Alternative Languages)', 'Delete', 'PROC', 'pers_type_alt(del1).php', 'N', 'DEL1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-07 11:48:33', 'AJM', '2008-01-07 12:00:42', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type_alt(list2)', 'x_pers_type_alt(del1)', '004', 'Delete', 'Y', '2008-01-07 11:48:35', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type_alt(enq1)', 'Enquire Person Type (Alternative Languages)', 'Read', 'PROC', 'pers_type_alt(enq1).php', 'N', 'ENQ1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-07 11:48:32', 'AJM', '2008-01-07 12:00:50', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type_alt(list2)', 'x_pers_type_alt(enq1)', '002', 'Read', 'Y', '2008-01-07 11:48:34', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type_alt(list2)', 'Maintain Alternative Languages for PERSON TYPE', 'Alternative Languages', 'PROC', 'pers_type_alt(list2).php', 'N', 'LIST2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-07 11:48:30', 'AJM', '2008-01-09 21:03:13', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type_alt(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2008-01-07 11:48:36', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type_alt(list2)', 'x_pers_type_alt(search)', '005', 'Search', 'N', '2008-01-07 11:48:35', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type_alt(list2)', 'x_pers_type_alt(upd1)', '003', 'Update', 'Y', '2008-01-07 11:48:35', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(list)', 'x_pers_type_alt(list2)', '007', 'Alternative Languages', 'Y', '2008-01-07 11:50:47', 'AJM', '2008-01-07 11:51:16', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type_alt(search)', 'Search Person Type (Alternative Languages)', 'Search', 'PROC', 'pers_type_alt(search).php', 'N', 'SRCH', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-07 11:48:33', 'AJM', '2008-01-07 12:01:05', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type_alt(upd1)', 'Update Person Type (Alternative Languages)', 'Update', 'PROC', 'pers_type_alt(upd1).php', 'N', 'UPD1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-07 11:48:32', 'AJM', '2008-01-07 12:01:12', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(add)', 'Add Person Type', 'Insert', 'PROC', 'pers_type_add.php', 'N', 'ADD1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(list)', 'x_pers_type(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_pers_type(add)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(del)', 'Delete Person Type', 'Delete', 'PROC', 'pers_type_del.php', 'N', 'DEL1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(list)', 'x_pers_type(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_pers_type(del)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(enq)', 'Enquire Person Type', 'Enquire', 'PROC', 'pers_type_enq.php', 'N', 'ENQ1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(list)', 'x_pers_type(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_pers_type(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_pers_type(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(list)', 'List Person Type', 'List Person Type', 'PROC', 'pers_type_list.php', 'N', 'LIST1', 'XAMPLE', NULL, NULL, NULL, NULL, 'pers_type_id', 'Y', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2005-01-31 18:17:34', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(list)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2004-04-09 11:40:25', 'AJM', '2008-01-07 11:51:16', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(list)', 'x_pers_type(search)', '006', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(list)', 'x_pers_type(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(list)', 'x_person(list)a', '005', 'List Person', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_pers_type(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_pers_type(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(search)', 'Search Person Type', 'Search', 'PROC', 'pers_type_search.php', 'N', 'SRCH', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_pers_type(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_pers_type(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(upd)', 'Update Person Type', 'Update', 'PROC', 'pers_type_upd.php', 'N', 'UPD1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_pers_type(upd)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(add)', 'Add Person Address', 'Insert', 'PROC', 'person_addr_add.php', 'N', 'ADD2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2004-09-02 18:50:16', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(list)', 'x_person_addr(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-03 12:35:23', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_person_addr(add)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(add2)', 'Add Person Address', 'New', 'PROC', 'x_person_addr(add2).php', 'N', 'ADD2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2009-08-18 11:00:25', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(multi2)', 'x_person_addr(add2)', '001', 'New', 'N', '2009-08-18 11:00:26', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(del)', 'Delete Person Address', 'Delete', 'PROC', 'person_addr_del.php', 'N', 'DEL1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(list)', 'x_person_addr(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_person_addr(del)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(del1)', 'Delete Person Address', 'Delete', 'PROC', 'x_person_addr(del1).php', 'N', 'DEL1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2009-08-18 11:00:25', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(multi2)', 'x_person_addr(del1)', '002', 'Delete', 'Y', '2009-08-18 11:00:26', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(enq)', 'Enquire Person Address', 'Enquire', 'PROC', 'person_addr_enq.php', 'N', 'ENQ1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(list)', 'x_person_addr(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_person_addr(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(list)', 'List Person Address', 'List Addresses', 'PROC', 'person_addr_list.php', 'N', 'LIST2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(list)', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2004-04-09 12:00:16', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(list)', 'x_person_addr(multi2)', '007', 'Maintain Person Address', 'Y', '2009-08-18 11:10:51', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(list)', 'x_person_addr(search)', '006', 'Search', 'N', '2009-07-17 17:56:31', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(list)', 'x_person_addr(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(enq)', 'x_person_addr(list)', '001', 'List Addresses', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)', 'x_person_addr(list)', '006', 'List Addresses', 'Y', '2003-01-01 12:00:00', 'AJM', '2006-07-30 10:13:44', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_person_addr(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_person_addr(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(multi2)', 'Maintain Person Address', 'Maintain Person Address', 'PROC', 'x_person_addr(multi2).php', 'Y', 'MULTI2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2009-08-18 11:00:24', 'AJM', '2009-08-19 23:24:32', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(search)', 'Search Person Address', 'Search', 'PROC', 'person_addr_search.php', 'N', 'SRCH', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2009-07-17 17:55:52', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(upd)', 'Update Person Address', 'Update', 'PROC', 'person_addr_upd.php', 'N', 'UPD1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_person_addr(upd)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(add)', 'Add Person', 'Insert', 'PROC', 'person_add.php', 'N', 'ADD1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)a', 'x_person(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)', 'x_person(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_person(add)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(csv)', 'Output Person data to CSV file', 'Output to CSV', 'PROC', 'person_output(csv).php', 'N', 'OUTPUT1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2006-08-11 16:53:17', 'AJM', '2008-06-16 11:52:26', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)', 'x_person(csv)', '010', 'Output to CSV (1)', 'N', '2006-08-11 16:58:31', 'AJM', '2008-06-16 11:48:52', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(del)', 'Delete Person', 'Delete', 'PROC', 'person_del.php', 'N', 'DEL1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)', 'x_person(del)', '005', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2006-07-30 10:13:44', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_person(del)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(del)2', 'Delete Person (without user dialog)', 'Delete', 'PROC', 'person_del(2).php', 'N', 'DEL2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2006-02-16 21:35:41', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(enq)', 'Enquire Person', 'Enquire', 'PROC', 'person_enq.php', 'N', 'ENQ1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(enq)', 'x_person(filedownload)', '002', 'Download Picture', 'N', '2006-07-26 11:20:30', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)a', 'x_person(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)', 'x_person(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)b', 'x_person(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_person(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_person(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(filedownload)', 'Download Person Picture', 'Download Picture', 'PROC', 'person_filedownload.php', 'N', 'FILEDOWNLOAD', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2006-07-26 10:53:55', 'AJM', '2006-07-26 17:02:18', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(filepicker)', 'Choose Person Picture', 'Choose Picture', 'PROC', 'person_filepicker.php', 'N', 'FILEPICKER', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2005-03-10 21:48:44', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(filepicker)', 'file(search)', '002', 'Search', 'N', '2008-11-22 18:21:30', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(filepicker)', 'x_person(fileupload)', '001', 'Upload Picture', 'N', '2005-12-15 20:53:05', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(fileupload)', 'Upload Person Picture', 'Upload Picture', 'PROC', 'person_fileupload.php', 'N', 'FILEUPLOAD', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2005-12-15 17:48:42', 'AJM', '2005-12-18 14:51:08', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)', 'List Person', 'List Person', 'PROC', 'person_list.php', 'N', 'LIST1', 'XAMPLE', NULL, NULL, NULL, NULL, 'last_name', 'Y', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2005-01-31 18:19:16', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)', 'audit_dtl(list)3', '011', 'Audit Trail', 'Y', '2004-04-09 11:39:55', 'AJM', '2006-08-11 16:58:55', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)', 'x_person(output4)', '015', 'Output to CSV (2)', 'N', '2008-06-16 11:47:56', 'AJM', '2008-06-16 11:48:38', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)', 'x_person(pdf)', '012', 'Output to PDF(L)', 'N', '2006-08-13 16:17:40', 'AJM', '2006-08-14 16:12:06', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)', 'x_person(pdf)2', '013', 'Output to PDF(D)', 'N', '2006-08-14 16:12:22', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)', 'x_person(pdf)3', '014', 'Invoice (PDF)', 'Y', '2006-08-28 10:30:19', 'AJM', '2006-08-28 10:30:34', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)', 'x_person(search)', '009', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2006-08-11 17:01:19', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)', 'x_person(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)', 'x_person(upd)js', '004', 'Update (js)', 'Y', '2006-07-30 10:13:08', 'AJM', '2006-07-30 10:13:44', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_person(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_person(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)a', 'List Person for a selected Person Type', 'List Person', 'PROC', 'person_list(a).php', 'N', 'LIST2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)a', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2004-04-09 11:59:55', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)a', 'x_person(search)', '004', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)a', 'x_person(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_person(list)a', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_person(list)a', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)b', 'List Person for a selected Option', 'List Person', 'PROC', 'person_list(b).php', 'N', 'LIST2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)b', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2004-04-09 12:00:04', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)b', 'x_person(search)', '004', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_person(list)b', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_person(list)b', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(output4)', 'Output Person data to CSV file', 'Output to CSV', 'PROC', 'x_person(output4).php', 'N', 'OUTPUT4', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-06-16 11:46:58', 'AJM', '2008-06-16 11:52:48', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(pdf)', 'Output person records to PDF file (List view)', 'Output to PDF(L)', 'PROC', 'person_output(pdf).php', 'N', 'OUTPUT2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2006-08-13 16:16:55', 'AJM', '2006-08-14 16:11:34', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(pdf)2', 'Output person records to PDF file (Detail view)', 'Output to PDF(D)', 'PROC', 'person_output(pdf)2.php', 'N', 'OUTPUT3', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2006-08-14 16:10:50', 'AJM', '2006-08-14 16:11:41', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(pdf)3', 'Sample Invoice print', 'Invoice (PDF)', 'PROC', 'person_output(pdf)3.php', 'N', 'OUTPUT3', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2006-08-28 10:29:44', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(popup)', 'Choose Person', 'Choose', 'PROC', 'person_popup.php', 'N', 'POPUP1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2006-10-06 13:51:57', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(popup)', 'x_person(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_person(popup)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_person(popup)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(search)', 'Search Person', 'Search', 'PROC', 'person_search.php', 'N', 'SRCH', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_person(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_person(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(upd)', 'Update Person', 'Update', 'PROC', 'person_upd.php', 'N', 'UPD1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_person(upd)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(upd)js', 'Update Person (with javascript)', 'Update (js)', 'PROC', 'person_upd(js).php', 'N', 'UPD1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2006-07-30 10:12:35', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_person(upd)js', 'x_person(upd)js2', '001', 'Update (js2)', 'Y', '2006-08-04 18:40:17', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_person(upd)js2', 'Update Person (with javascript)', 'Update (js2)', 'PROC', 'person_upd(fckeditor).php', 'N', 'UPD1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2006-08-04 18:39:51', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level_alt(add2)', 'Add Tree Level (Alternative Languages)', 'New', 'PROC', 'tree_level_alt(add2).php', 'N', 'ADD2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-10 17:05:38', 'AJM', '2008-01-10 17:11:45', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level_alt(list2)', 'x_tree_level_alt(add2)', '001', 'New', 'N', '2008-01-10 17:05:41', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level_alt(del1)', 'Delete Tree Level (Alternative Languages)', 'Delete', 'PROC', 'tree_level_alt(del1).php', 'N', 'DEL1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-10 17:05:40', 'AJM', '2008-01-10 17:12:01', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level_alt(list2)', 'x_tree_level_alt(del1)', '004', 'Delete', 'Y', '2008-01-10 17:05:42', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level_alt(enq1)', 'Enquire Tree Level (Alternative Languages)', 'Read', 'PROC', 'tree_level_alt(enq1).php', 'N', 'ENQ1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-10 17:05:39', 'AJM', '2008-01-10 17:12:08', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level_alt(list2)', 'x_tree_level_alt(enq1)', '002', 'Read', 'Y', '2008-01-10 17:05:41', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level_alt(list2)', 'Maintain Alternative Languages for TREE_LEVEL', 'Alternative Languages', 'PROC', 'tree_level_alt(list2).php', 'N', 'LIST2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-10 17:05:38', 'AJM', '2008-01-10 17:11:26', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level_alt(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2008-01-10 17:05:42', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level_alt(list2)', 'x_tree_level_alt(search)', '005', 'Search', 'N', '2008-01-10 17:05:42', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level_alt(list2)', 'x_tree_level_alt(upd1)', '003', 'Update', 'Y', '2008-01-10 17:05:41', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(list)', 'x_tree_level_alt(list2)', '008', 'Alternative Languages', 'Y', '2008-01-10 17:13:39', 'AJM', '2008-01-10 17:13:54', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level_alt(search)', 'Search Tree Level (Alternative Languages)', 'Search', 'PROC', 'tree_level_alt(search).php', 'N', 'SRCH', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-10 17:05:40', 'AJM', '2008-01-10 17:12:33', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level_alt(upd1)', 'Update Tree Level (Alternative Languages)', 'Update', 'PROC', 'tree_level_alt(upd1).php', 'N', 'UPD1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-10 17:05:39', 'AJM', '2008-01-10 17:12:42', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(add)', 'Add Tree Level', 'Insert', 'PROC', 'tree_level_add.php', 'N', 'ADD2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(list)', 'x_tree_level(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_level(add)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(del)', 'Delete Tree Level', 'Delete', 'PROC', 'tree_level_del.php', 'N', 'DEL1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(list)', 'x_tree_level(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_level(del)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(enq)', 'Enquire Tree Level', 'Enquire', 'PROC', 'tree_level_enq.php', 'N', 'ENQ1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2006-01-17 18:49:13', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(list)', 'x_tree_level(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_tree_level(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_level(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(list)', 'List Tree Level', 'Tree Level', 'PROC', 'tree_level_list.php', 'N', 'LIST2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2004-08-24 17:37:26', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(list)', 'audit_dtl(list)3', '009', 'Audit Trail', 'Y', '2004-04-09 12:02:07', 'AJM', '2008-01-10 17:13:54', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(list)', 'x_tree_level(multi)', '005', 'Update Seq Number', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-05 16:11:56', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(list)', 'x_tree_level(search)', '007', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(list)', 'x_tree_level(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(list)', 'x_tree_node(list)', '006', 'Nodes', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(list)', 'x_tree_level(list)', '005', 'Tree Level', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_tree_level(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_level(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(multi)', 'Update Level Sequence Number', 'Update Seq Number', 'PROC', 'tree_level_multi.php', 'N', 'MULTI2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2005-06-24 17:30:43', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_level(multi)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(search)', 'Search Tree Level', 'Search', 'PROC', 'tree_level_search.php', 'N', 'SRCH', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_tree_level(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_level(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(upd)', 'Update Tree Level', 'Update', 'PROC', 'tree_level_upd.php', 'N', 'UPD1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_level(upd)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_alt(add2)', 'Add Tree Node (Alternative Languages)', 'New', 'PROC', 'tree_node_alt(add2).php', 'N', 'ADD2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-10 17:35:55', 'AJM', '2008-01-10 17:39:20', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_alt(list2)', 'x_tree_node_alt(add2)', '001', 'New', 'N', '2008-01-10 17:35:58', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_alt(del1)', 'Delete Tree Node (Alternative Languages)', 'Delete', 'PROC', 'tree_node_alt(del1).php', 'N', 'DEL1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-10 17:35:57', 'AJM', '2008-01-10 17:38:56', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_alt(list2)', 'x_tree_node_alt(del1)', '004', 'Delete', 'Y', '2008-01-10 17:35:59', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_alt(enq1)', 'Enquire Tree Node (Alternative Languages)', 'Read', 'PROC', 'tree_node_alt(enq1).php', 'N', 'ENQ1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-10 17:35:56', 'AJM', '2008-01-10 17:39:04', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_alt(list2)', 'x_tree_node_alt(enq1)', '002', 'Read', 'Y', '2008-01-10 17:35:58', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_alt(list2)', 'Maintain Alternative Languages for TREE_NODE', 'Alternative Languages', 'PROC', 'tree_node_alt(list2).php', 'N', 'LIST2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-10 17:35:55', 'AJM', '2008-01-10 17:41:02', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_alt(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2008-01-10 17:35:59', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_alt(list2)', 'x_tree_node_alt(search)', '005', 'Search', 'N', '2008-01-10 17:35:59', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_alt(list2)', 'x_tree_node_alt(upd1)', '003', 'Update', 'Y', '2008-01-10 17:35:58', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(list)', 'x_tree_node_alt(list2)', '008', 'Alternative Languages', 'Y', '2008-01-10 17:40:28', 'AJM', '2008-01-10 17:40:40', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_alt(search)', 'Search Tree Node (Alternative Languages)', 'Search', 'PROC', 'tree_node_alt(search).php', 'N', 'SRCH', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-10 17:35:57', 'AJM', '2008-01-10 17:38:33', 'AJM');
INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_alt(upd1)', 'Update Tree Node (Alternative Languages)', 'Update', 'PROC', 'tree_node_alt(upd1).php', 'N', 'UPD1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-10 17:35:56', 'AJM', '2008-01-10 17:38:40', 'AJM');
INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_jnr(add)', 'Link Child Nodes to a Parent Node', 'Link Children', 'PROC', 'tree_node_jnr_add.php', 'N', 'UPD2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_jnr(list)', 'x_tree_node_jnr(add)', '001', 'Link Children', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-04 18:04:15', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_node_jnr(add)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_jnr(del)', 'Unlink Child Nodes from Parent Node', 'Unlink Children', 'PROC', 'tree_node_jnr_del.php', 'N', 'DEL3', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_jnr(list)', 'x_tree_node_jnr(del)', '002', 'Unlink Child', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-05-04 18:04:15', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_node_jnr(del)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_jnr(list)', 'List Child Nodes for a selected Parent', 'Child Nodes', 'PROC', 'tree_node_jnr_list.php', 'N', 'LIST2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2004-08-24 17:39:11', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_jnr(list)', 'audit_dtl(list)3', '003', 'Audit Trail', 'Y', '2004-04-09 12:02:28', 'AJM', '2004-05-04 18:04:15', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_jnr(list)', 'x_tree_node(search)', '004', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-04 18:04:15', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(list)', 'x_tree_node_jnr(list)', '006', 'Child Nodes', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_tree_node_jnr(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_node_jnr(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_jnr(popup)', 'Choose Orphan Nodes', 'Choose', 'PROC', 'tree_node_jnr_popup.php', 'N', 'POPUP2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2006-10-06 13:52:25', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_jnr(popup)', 'x_tree_node(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-06 12:30:17', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_jnr(popup)', 'x_tree_node(search)', '002', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_tree_node_jnr(popup)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_node_jnr(popup)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_snr(list)', 'List Parentage for a selected Node', 'Parent Nodes', 'PROC', 'tree_node_snr_list.php', 'N', 'LIST2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2004-08-24 17:39:02', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_snr(list)', 'audit_dtl(list)3', '001', 'Audit Trail', 'Y', '2004-04-09 12:02:39', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(list)', 'x_tree_node_snr(list)', '005', 'Parent Nodes', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_tree_node_snr(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_node_snr(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(add)', 'Add Tree Node', 'New', 'PROC', 'tree_node_add.php', 'N', 'ADD2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2004-08-24 17:40:42', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(list)', 'x_tree_node(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_node(add)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(del)', 'Delete Tree Node', 'Delete', 'PROC', 'tree_node_del.php', 'N', 'DEL1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(list)', 'x_tree_node(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_node(del)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(enq)', 'Enquire Tree Node', 'Enquire', 'PROC', 'tree_node_enq.php', 'N', 'ENQ1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2006-01-17 18:49:19', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_structure(list)', 'x_tree_node(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(list)', 'x_tree_node(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_tree_node(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_node(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(list)', 'List Tree Node', 'Tree Node', 'PROC', 'tree_node_list.php', 'N', 'LIST2', 'XAMPLE', NULL, NULL, NULL, NULL, 'node_desc', 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2005-01-31 18:22:18', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(list)', 'audit_dtl(list)3', '009', 'Audit Trail', 'Y', '2004-04-09 12:02:14', 'AJM', '2008-01-10 17:40:40', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(list)', 'x_tree_node(search)', '007', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(list)', 'x_tree_node(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_tree_node(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_node(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(search)', 'Search Tree Node', 'Search', 'PROC', 'tree_node_search.php', 'N', 'SRCH', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_tree_node(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_node(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(upd)', 'Update Tree Node', 'Update', 'PROC', 'tree_node_upd.php', 'N', 'UPD1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_node(upd)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_structure(list)', 'List Structure for a selected Tree Type', 'Structure', 'PROC', 'tree_structure_list.php', 'N', 'TREE2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2004-08-27 15:37:19', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(list)', 'x_tree_structure(list)', '006', 'Tree Structure', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_tree_structure(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_structure(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_structure(popup)', 'Choose Node from a Tree Structure', 'Choose', 'PROC', 'tree_structure_popup.php', 'N', 'POPUP4', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2006-10-06 13:18:27', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_tree_structure(popup)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_structure(popup)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type_alt(add2)', 'Add Tree Type (Alternative Languages)', 'New', 'PROC', 'tree_type_alt(add2).php', 'N', 'ADD2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-10 16:30:02', 'AJM', '2008-01-10 16:35:55', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type_alt(list2)', 'x_tree_type_alt(add2)', '001', 'New', 'N', '2008-01-10 16:30:05', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type_alt(del1)', 'Delete Tree Type (Alternative Languages)', 'Delete', 'PROC', 'tree_type_alt(del1).php', 'N', 'DEL1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-10 16:30:04', 'AJM', '2008-01-10 16:36:02', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type_alt(list2)', 'x_tree_type_alt(del1)', '004', 'Delete', 'Y', '2008-01-10 16:30:06', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type_alt(enq1)', 'Enquire Tree Type (Alternative Languages)', 'Read', 'PROC', 'tree_type_alt(enq1).php', 'N', 'ENQ1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-10 16:30:03', 'AJM', '2008-01-10 16:36:11', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type_alt(list2)', 'x_tree_type_alt(enq1)', '002', 'Read', 'Y', '2008-01-10 16:30:05', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type_alt(list2)', 'Maintain Alternative Languages for TREE_TYPE', 'Alternative Languages', 'PROC', 'tree_type_alt(list2).php', 'N', 'LIST2', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-10 16:30:02', 'AJM', '2008-01-10 16:35:28', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type_alt(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2008-01-10 16:30:06', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type_alt(list2)', 'x_tree_type_alt(search)', '005', 'Search', 'N', '2008-01-10 16:30:06', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type_alt(list2)', 'x_tree_type_alt(upd1)', '003', 'Update', 'Y', '2008-01-10 16:30:06', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(list)', 'x_tree_type_alt(list2)', '008', 'Alternative Languages', 'Y', '2008-01-10 16:37:01', 'AJM', '2008-01-10 16:37:12', 'AJM');

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type_alt(search)', 'Search Tree Type (Alternative Languages)', 'Search', 'PROC', 'tree_type_alt(search).php', 'N', 'SRCH', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-10 16:30:05', 'AJM', '2008-01-10 16:36:24', 'AJM');
INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type_alt(upd1)', 'Update Tree Type (Alternative Languages)', 'Update', 'PROC', 'tree_type_alt(upd1).php', 'N', 'UPD1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, '2008-01-10 16:30:04', 'AJM', '2008-01-10 16:36:31', 'AJM');
INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(add)', 'Add Tree Type', 'Insert', 'PROC', 'tree_type_add.php', 'N', 'ADD1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(list)', 'x_tree_type(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_type(add)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(del)', 'Delete Tree Type', 'Delete', 'PROC', 'tree_type_del.php', 'N', 'DEL1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(list)', 'x_tree_type(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_type(del)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(enq)', 'Enquire Tree Type', 'Enquire', 'PROC', 'tree_type_enq.php', 'N', 'ENQ1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(list)', 'x_tree_type(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_tree_type(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_type(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(list)', 'List Tree Type', 'Tree Type', 'PROC', 'tree_type_list.php', 'N', 'LIST1', 'XAMPLE', NULL, NULL, NULL, NULL, 'tree_type_id', 'Y', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2005-01-31 18:18:21', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(list)', 'audit_dtl(list)3', '009', 'Audit Trail', 'Y', '2004-04-09 11:57:30', 'AJM', '2008-01-10 16:37:12', 'AJM');
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(list)', 'x_tree_type(search)', '007', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(list)', 'x_tree_type(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_tree_type(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_type(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(search)', 'Search Tree Type', 'Search', 'PROC', 'tree_type_search.php', 'N', 'SRCH', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('READONLY', 'x_tree_type(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_type(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(upd)', 'Update Tree Type', 'Update', 'PROC', 'tree_type_upd.php', 'N', 'UPD1', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('SURVEY', 'x_tree_type(upd)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, created_date, created_user, revised_date, revised_user) VALUES ('xample', 'Example System', 'Example System', 'MENU', 'menu.php', 'N', 'MENU', 'XAMPLE', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_menu (menu_id, task_id_jnr, sort_seq, button_text, created_date, created_user, revised_date, revised_user) VALUES ('xample', 'test_autoinsert(add)', '005', 'Auto-Increment', '2005-05-25 21:07:55', 'AJM', '2005-05-25 21:32:27', 'AJM');
INSERT INTO mnu_menu (menu_id, task_id_jnr, sort_seq, button_text, created_date, created_user, revised_date, revised_user) VALUES ('xample', 'x_option(list)', '002', 'Option', '2003-01-01 12:00:00', 'AJM', '2005-04-24 10:21:31', 'AJM');
INSERT INTO mnu_menu (menu_id, task_id_jnr, sort_seq, button_text, created_date, created_user, revised_date, revised_user) VALUES ('xample', 'x_pers_type(list)', '003', 'Person Type', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO mnu_menu (menu_id, task_id_jnr, sort_seq, button_text, created_date, created_user, revised_date, revised_user) VALUES ('xample', 'x_person(list)', '001', 'Person', '2003-01-01 12:00:00', 'AJM', '2005-04-24 10:21:31', 'AJM');
INSERT INTO mnu_menu (menu_id, task_id_jnr, sort_seq, button_text, created_date, created_user, revised_date, revised_user) VALUES ('xample', 'x_tree_type(list)', '004', 'Tree Type', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

INSERT INTO mnu_menu (menu_id, task_id_jnr, sort_seq, button_text, created_date, created_user, revised_date, revised_user) VALUES ('proto', 'xample', '001', 'Example', '2005-05-05 17:46:15', 'AJM', '2007-01-22 10:58:39', 'AJM');

INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_option(add)', 'This will allow a new record to be added to the OPTION table.
Enter your data then press the SUBMIT button to add it to the database.
For a description of screens of type ADD 1 <a href=\"%root%/php-mysql/dialog-types.html#add1\">click here</a>.', '2004-08-26 11:50:11', 'AJM', '2004-08-26 11:53:03', 'AJM');
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_option(del)', 'This will display a record from the OPTION table and allow it to be deleted.
For a description of screens of type DELETE 1 <a href=\"%root%/php-mysql/dialog-types.html#delete1\">click here</a>.', '2004-08-26 12:32:08', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_option(enq)', 'This will display the contents of a record from the OPTION table.
For a description of screens of type ENQUIRE 1 <a href=\"%root%/php-mysql/dialog-types.html#enquire1\">click here</a>.', '2004-08-26 12:22:22', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_option(list)', 'This will list records on the OPTION table.
For a description of screens of type LIST 1 <a href=\"%root%/php-mysql/dialog-types.html#list1\">click here</a>.', '2004-08-26 14:02:57', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_option(list)a', 'This will list records on the OPTION table for a selected PERSON.
For a description of screens of type LIST 2 <a href=\"%root%/php-mysql/dialog-types.html#list2\">click here</a>.', '2004-08-26 12:13:36', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_option(popup)', 'This will list records on the OPTION table and allow one or more to be selected.
After selecting records please press the CHOOSE button.
For a description of screens of type POPUP <a href=\"%root%/php-mysql/dialog-types.html#popup\">click here</a>.', '2004-08-26 14:06:50', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_option(search)', 'This will define search criteria for the OPTION table.
Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.
For a description of screens of type SEARCH 1 <a href=\"%root%/php-mysql/dialog-types.html#search1\">click here</a>.', '2004-08-26 11:43:18', 'AJM', '2004-08-26 11:46:08', 'AJM');
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_option(upd)', 'This will display the contents of a record from the OPTION table and allow it to be updated. 
For a description of screens of type UPDATE 1 <a href=\"%root%/php-mysql/dialog-types.html#update1\">click here</a>.', '2004-08-26 12:26:29', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_opt_xref(link)a', 'This will allow the contents of PERS_OPT_XREF to be maintained. This table links PERSON to OPTION in a many-to-many relationship.
This will show the selected PERSON at the top of the screen. Below it will show all available entries for OPTION, and the SELECT box will be checked if an entry currently exists on PERS_OPT_XREF for this combination of PERSON and OPTION.
To alter the contents of the database simply change the relevant SELECT box to ON or OFF, then press the SUBMIT button.
For a description of screens of type LINK 1 <a href=\"%root%/php-mysql/dialog-types.html#link1\">click here</a>.', '2004-05-08 15:25:36', 'AJM', '2004-05-08 15:27:53', 'AJM');
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_opt_xref(link)b', 'This will allow the contents of PERS_OPT_XREF to be maintained. This table links PERSON to OPTION in a many-to-many relationship.
This will show the selected OPTION at the top of the screen. Below it will show all available entries for PERSON, and the SELECT box will be checked if an entry currently exists on PERS_OPT_XREF for this combination of PERSON and OPTION.
To alter the contents of the database simply change the relevant SELECT box to ON or OFF, then press the SUBMIT button.
For a description of screens of type LINK 1 <a href=\"%root%/php-mysql/dialog-types.html#link1\">click here</a>.', '2004-05-08 15:26:06', 'AJM', '2004-05-08 15:28:01', 'AJM');
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(add)', 'This will allow a new record to be added to the PERS_TYPE table.
Enter your data then press the SUBMIT button to add it to the database.
For a description of screens of type ADD 1 <a href=\"%root%/php-mysql/dialog-types.html#add1\">click here</a>.', '2004-08-26 11:50:39', 'AJM', '2004-08-26 11:53:17', 'AJM');
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(del)', 'This will display a record from the PERSON TYPE table and allow it to be deleted.
For a description of screens of type DELETE 1 <a href=\"%root%/php-mysql/dialog-types.html#delete1\">click here</a>.', '2004-08-26 12:32:47', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(enq)', 'This will display the contents of a record from the PERSON TYPE table.
For a description of screens of type ENQUIRE 1 <a href=\"%root%/php-mysql/dialog-types.html#enquire1\">click here</a>.', '2004-08-26 12:23:02', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(list)', 'This will list records on the PERSON TYPE table.
For a description of screens of type LIST 1 <a href=\"%root%/php-mysql/dialog-types.html#list1\">click here</a>.', '2004-08-26 14:03:39', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(search)', 'This will define search criteria for the PERS_TYPE table.
Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.
For a description of screens of type SEARCH 1 <a href=\"%root%/php-mysql/dialog-types.html#search1\">click here</a>.', '2004-08-26 11:43:49', 'AJM', '2004-08-26 11:46:25', 'AJM');
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_pers_type(upd)', 'This will display the contents of a record from the PERSON TYPE table and allow it to be updated. 
For a description of screens of type UPDATE 1 <a href=\"%root%/php-mysql/dialog-types.html#update1\">click here</a>.', '2004-08-26 12:27:11', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(add)', 'This will allow a record to be added to the PERSON ADDRESS table for a selected PERSON.
For a description of screens of type ADD 2 <a href=\"%root%/php-mysql/dialog-types.html#add2\">click here</a>.', '2004-08-26 12:49:16', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(del)', 'This will display a record from the PERSON ADDRESS table and allow it to be deleted.
For a description of screens of type DELETE 1 <a href=\"%root%/php-mysql/dialog-types.html#delete1\">click here</a>.', '2004-08-26 12:32:35', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(enq)', 'This will display the contents of a record from the PERSON ADDRESS table.
For a description of screens of type ENQUIRE 1 <a href=\"%root%/php-mysql/dialog-types.html#enquire1\">click here</a>.', '2004-08-26 12:22:49', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(list)', 'This will list records on the PERSON ADDRESS table for a selected PERSON.
For a description of screens of type LIST 2 <a href=\"%root%/php-mysql/dialog-types.html#list2\">click here</a>.', '2004-08-26 12:15:02', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_person_addr(upd)', 'This will display the contents of a record from the PERSON ADDRESS table and allow it to be updated. 
For a description of screens of type UPDATE 1 <a href=\"%root%/php-mysql/dialog-types.html#update1\">click here</a>.', '2004-08-26 12:26:59', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_person(add)', 'This will allow a new record to be added to the PERSON table.
Enter your data then press the SUBMIT button to add it to the database.
For a description of screens of type ADD 1 <a href=\"%root%/php-mysql/dialog-types.html#add1\">click here</a>.', '2004-08-26 11:50:24', 'AJM', '2004-08-26 11:53:10', 'AJM');
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_person(del)', 'This will display a record from the PERSON table and allow it to be deleted.
For a description of screens of type DELETE 1 <a href=\"%root%/php-mysql/dialog-types.html#delete1\">click here</a>.', '2004-08-26 12:32:22', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_person(enq)', 'This will display the contents of a record from the PERSON table.
For a description of screens of type ENQUIRE 1 <a href=\"%root%/php-mysql/dialog-types.html#enquire1\">click here</a>.', '2004-08-26 12:22:35', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)', 'This will list records on the PERSON table.
For a description of screens of type LIST 1 <a href=\"%root%/php-mysql/dialog-types.html#list1\">click here</a>.', '2004-08-26 14:03:24', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)a', 'This will list records on the PERSON table for a selected PERSON TYPE.
For a description of screens of type LIST 2 <a href=\"%root%/php-mysql/dialog-types.html#list2\">click here</a>.', '2004-08-26 12:14:02', 'AJM', '2004-08-26 12:14:32', 'AJM');
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_person(list)b', 'This will list records on the PERSON table for a selected OPTION.
For a description of screens of type LIST 2 <a href=\"%root%/php-mysql/dialog-types.html#list2\">click here</a>.', '2004-08-26 12:14:20', 'AJM', '2004-08-26 12:14:41', 'AJM');
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_person(popup)', 'This will list records on the PERSON table and allow one or more to be selected.
After selecting records please press the CHOOSE button.
For a description of screens of type POPUP <a href=\"%root%/php-mysql/dialog-types.html#popup\">click here</a>.', '2004-08-26 14:07:03', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_person(search)', 'This will define search criteria for the PERSON table.
Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.
For a description of screens of type SEARCH 1 <a href=\"%root%/php-mysql/dialog-types.html#search1\">click here</a>.', '2004-08-26 11:43:34', 'AJM', '2004-08-26 11:46:16', 'AJM');
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_person(upd)', 'This will display the contents of a record from the PERSON table and allow it to be updated. 
For a description of screens of type UPDATE 1 <a href=\"%root%/php-mysql/dialog-types.html#update1\">click here</a>.', '2004-08-26 12:26:40', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(add)', 'This will allow a record to be added to the TREE LEVEL table for a selected TREE TYPE.
For a description of screens of type ADD 2 <a href=\"%root%/php-mysql/dialog-types.html#add2\">click here</a>.', '2004-08-26 12:49:37', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(del)', 'This will display a record from the TREE LEVEL table and allow it to be deleted.
For a description of screens of type DELETE 1 <a href=\"%root%/php-mysql/dialog-types.html#delete1\">click here</a>.', '2004-08-26 12:33:00', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(enq)', 'This will display the contents of a record from the TREE LEVEL table.
For a description of screens of type ENQUIRE 1 <a href=\"%root%/php-mysql/dialog-types.html#enquire1\">click here</a>.', '2004-08-26 12:23:15', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(list)', 'This will list records on the TREE LEVEL table for a selected TREE TYPE.
For a description of screens of type LIST 2 <a href=\"%root%/php-mysql/dialog-types.html#list2\">click here</a>.', '2004-08-26 12:15:40', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(multi)', 'This will show the existing records on the TREE LEVEL table and allow them to be resequenced.
Note that the sequence numbers must start from 1, with no duplicates and no gaps.
For a description of screens of type MULTI 1 <a href=\"%root%/php-mysql/dialog-types.html#multi1\">click here</a>.', '2004-08-26 12:54:45', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(search)', 'This will define search criteria for the TREE_LEVEL table.
Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.
For a description of screens of type SEARCH 1 <a href=\"%root%/php-mysql/dialog-types.html#search1\">click here</a>.', '2004-08-26 11:44:03', 'AJM', '2004-08-26 11:46:31', 'AJM');
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_level(upd)', 'This will display the contents of a record from the TREE LEVEL table and allow it to be updated. 
For a description of screens of type UPDATE 1 <a href=\"%root%/php-mysql/dialog-types.html#update1\">click here</a>.', '2004-08-26 12:27:24', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_jnr(list)', 'This will list ''child'' nodes for a selected ''parent'' NODE.
For a description of screens of type LIST 2 <a href=\"%root%/php-mysql/dialog-types.html#list2\">click here</a>.
Press the LINK CHILDREN button to add new nodes as children.
Press the UNLINK CHILDREN button to remove selected nodes as children.', '2004-08-26 12:17:01', 'AJM', '2004-08-26 14:16:51', 'AJM');
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_jnr(popup)', 'This will list available records on the TREE NODE table and allow one or more to be selected.
After selecting records please press the CHOOSE button.
For a description of screens of type POPUP <a href=\"%root%/php-mysql/dialog-types.html#popup\">click here</a>.', '2004-08-26 14:07:43', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node_snr(list)', 'This will list ''parent'' NODES for a selected ''child'' NODE.
For a description of screens of type LIST 2 <a href=\"%root%/php-mysql/dialog-types.html#list2\">click here</a>.', '2004-08-26 12:17:56', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(add)', 'This will allow a record to be added to the TREE NODE table for a selected TREE LEVEL.
For a description of screens of type ADD 2 <a href=\"%root%/php-mysql/dialog-types.html#add2\">click here</a>.', '2004-08-26 12:49:58', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(del)', 'This will display a record from the TREE NODE table and allow it to be deleted.
For a description of screens of type DELETE 1 <a href=\"%root%/php-mysql/dialog-types.html#delete1\">click here</a>.', '2004-08-26 12:33:12', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(enq)', 'This will display the contents of a record from the TREE NODE table.
For a description of screens of type ENQUIRE 1 <a href=\"%root%/php-mysql/dialog-types.html#enquire1\">click here</a>.', '2004-08-26 12:23:28', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(list)', 'This will list records on the TREE NODE table for a selected TREE LEVEL.
For a description of screens of type LIST 2 <a href=\"%root%/php-mysql/dialog-types.html#list2\">click here</a>.', '2004-08-26 12:15:55', 'AJM', '2004-08-26 12:16:21', 'AJM');
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(search)', 'This will define search criteria for the TREE_NODE table.
Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.
For a description of screens of type SEARCH 1 <a href=\"%root%/php-mysql/dialog-types.html#search1\">click here</a>.', '2004-08-26 11:44:15', 'AJM', '2004-08-26 11:46:38', 'AJM');
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_node(upd)', 'This will display the contents of a record from the TREE NODE table and allow it to be updated. 
For a description of screens of type UPDATE 1 <a href=\"%root%/php-mysql/dialog-types.html#update1\">click here</a>.', '2004-08-26 12:27:37', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_structure(list)', 'This will display the structure of a selected TREE TYPE, starting with the root nodes.
The plus symbol (+) against a node can be used to expand the display to include the children of that node.
The minus symbol (-) against a node can be used to collapse the display the exclude the cgildren of that node.
The EXPAND and COLLAPSE buttons at the bottom of the screen will operate on all nodes within the tree structure.
For a description of screens of type TREE VIEW 2 <a href=\"%root%/php-mysql/dialog-types.html#tree2\">click here</a>.', '2004-08-26 12:40:51', 'AJM', '2004-08-27 15:37:33', 'AJM');
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_structure(popup)', 'This will display the structure of a selected TREE TYPE, starting with the root nodes.
When you have selected a node press the CHOOSE button to pass that election back to the previous task.
The plus symbol (+) against a node can be used to expand the display to include the children of that node.
The minus symbol (-) against a node can be used to collapse the display the exclude the cgildren of that node.
The EXPAND and COLLAPSE buttons at the bottom of the screen will operate on all nodes within the tree structure.
For a description of screens of type TREE VIEW 2 1 <a href=\"%root%/php-mysql/dialog-types.html#tree2\">click here</a>.', '2004-08-26 12:41:43', 'AJM', '2004-08-26 12:42:34', 'AJM');
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(add)', 'This will allow a new record to be added to the TREE_TYPE table.
Enter your data then press the SUBMIT button to add it to the database.
For a description of screens of type ADD 1 <a href=\"%root%/php-mysql/dialog-types.html#add1\">click here</a>.', '2004-08-26 11:50:55', 'AJM', '2004-08-26 11:53:24', 'AJM');
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(del)', 'This will display a record from the TREE TYPE table and allow it to be deleted.
For a description of screens of type DELETE 1 <a href=\"%root%/php-mysql/dialog-types.html#delete1\">click here</a>.', '2004-08-26 12:33:23', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(enq)', 'This will display the contents of a record from the TREE TYPE table.
For a description of screens of type ENQUIRE 1 <a href=\"%root%/php-mysql/dialog-types.html#enquire1\">click here</a>.', '2004-08-26 12:23:41', 'AJM', NULL, NULL);
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(list)', 'This will list records on the TREE_TYPE table.
For a description of screens of type LIST 1 <a href=\"%root%/php-mysql/dialog-types.html#list1\">click here</a>.
You can view and maintain the Levels and Nodes within a Tree Type by pressing the ''Tree Level'' button.
You can view the entire structure by pressing the ''Tree Structure'' button.
For an overview on tree structures please read <a href=\"%root%/php-mysql/tree-structure.html\">A Flexible Tree Structure</a>.', '2004-08-26 11:36:17', 'AJM', '2004-08-26 11:39:18', 'AJM');
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(search)', 'This will define search criteria for the TREE_TYPE table.
Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.
For a description of screens of type SEARCH 1 <a href=\"%root%/php-mysql/dialog-types.html#search1\">click here</a>.', '2004-08-26 11:42:44', 'AJM', '2004-08-26 11:46:45', 'AJM');
INSERT INTO help_text (task_id, help_text, created_date, created_user, revised_date, revised_user) VALUES ('x_tree_type(upd)', 'This will display the contents of a record from the TREE TYPE table and allow it to be updated. 
For a description of screens of type UPDATE 1 <a href=\"%root%/php-mysql/dialog-types.html#update1\">click here</a>.', '2004-08-26 12:27:49', 'AJM', NULL, NULL);

-- finished
