-- file created on May 5, 2017, 9:26 am
    
INSERT INTO mnu_subsystem (subsys_id, subsys_name, subsys_desc, subsys_dir, task_prefix, created_date, created_user, revised_date, revised_user) VALUES ('MISC', 'Miscellaneous Tasks', NULL, 'menu', NULL, '2004-04-17 17:12:15', 'AJM', NULL, NULL);

INSERT INTO mnu_role (role_id, role_name, role_desc, start_task_id, global_access, is_external_auth_off, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'MENU read-only', NULL, 'main_menu', 'N', 'Y', '2014-04-19 06:21:53', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('batch_log(filedownload)', 'Download Batch Log File', NULL, 'Batch Log Files', 'PROC', 'batch_log_filedownload.php', 'N', 'FILEDOWNLOAD', 'MISC', NULL, NULL, NULL, 'hyperlink_direct=Y', NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2008-11-21 11:42:41', 'AJM', '2009-08-25 16:36:16', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'batch_log(filedownload)', '2014-04-19 13:06:08', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('batch_log(filepicker)', 'Show Batch Log File', NULL, 'Batch Log Files', 'PROC', 'batch_log_filepicker.php', 'N', 'FILEPICKER', 'MISC', NULL, NULL, NULL, 'download=FALSE', NULL, 'N', 'N', '10', 'N', NULL, NULL, NULL, '2008-11-21 12:09:14', 'AJM', '2009-08-25 16:36:30', 'AJM');

INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('batch_log(filepicker)', 'file(delete)', '002', 'Delete', 'Y', '2008-11-24 16:34:42', 'AJM', NULL, NULL);
INSERT INTO mnu_nav_button (task_id_snr, task_id_jnr, sort_seq, button_text, context_preselect, created_date, created_user, revised_date, revised_user) VALUES ('batch_log(filepicker)', 'file(search)', '001', 'Search', 'N', '2008-11-22 16:20:27', 'AJM', NULL, NULL);

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'batch_log(filepicker)', '2014-04-19 13:06:09', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('date(current)', 'Select Records with Current Dates', NULL, 'Current', 'PROC', 'date_current.php', 'N', 'OTHER', 'MISC', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-17 17:14:09', 'AJM', '2008-02-01 14:30:06', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'date(current)', '2014-04-19 13:06:09', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('date(future)', 'Select Records with Future Dates', NULL, 'Future', 'PROC', 'date_future.php', 'N', 'OTHER', 'MISC', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-17 17:15:38', 'AJM', '2008-02-01 14:30:15', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'date(future)', '2014-04-19 13:06:09', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('date(historic)', 'Select Records with Historic Dates', NULL, 'Historic', 'PROC', 'date_historic.php', 'N', 'OTHER', 'MISC', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-17 17:15:01', 'AJM', '2008-02-01 14:30:25', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'date(historic)', '2014-04-19 13:06:10', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('file(delete)', 'Delete File Name', NULL, 'Delete', 'PROC', 'file(delete).php', 'N', 'DEL2', 'MISC', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2008-11-24 16:33:57', 'AJM', NULL, NULL);

INSERT INTO mnu_task (task_id, task_name, task_desc, button_text, task_type, script_id, is_disabled, pattern_id, subsys_id, initial_passthru, selection_fixed, selection_temp, settings, order_by, keep_data, log_sql_query, screen_refresh, use_https, max_execution_time, task_id_run_at_end, task_id_run_at_cancel, created_date, created_user, revised_date, revised_user) VALUES ('file(search)', 'Search File Name', NULL, 'Search', 'PROC', 'file(search).php', 'N', 'SRCH', 'MISC', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2008-11-22 16:19:22', 'AJM', '2008-11-22 23:06:30', 'AJM');

INSERT INTO mnu_role_task (role_id, task_id, created_date, created_user, revised_date, revised_user) VALUES ('MENU-RO', 'file(search)', '2014-04-19 13:06:10', 'AJM', NULL, NULL);

-- finished
