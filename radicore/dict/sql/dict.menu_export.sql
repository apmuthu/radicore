-- file created on July 17, 2007, 1:36 pm
    
REPLACE INTO `mnu_subsystem` (`subsys_id`, `subsys_desc`, `subsys_dir`, `task_prefix`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DICT', 'Data Dictionary', 'dict', 'dict_', '2005-03-12 18:06:10', 'AJM', '2006-04-22 09:38:05', 'AJM');

REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'Demonstration Class', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_column(del)', 'Delete Column', 'Delete', 'PROC', 'column_del.php', 'N', 'DEL1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-12 23:29:31', 'AJM', '2005-04-05 15:58:03', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_column(list)2', 'dict_column(del)', '004', 'Delete', 'Y', '2005-03-12 23:30:56', 'AJM', '2005-03-12 23:35:42', 'AJM'),
('dict_column(list)', 'dict_column(del)', '004', 'Delete', 'Y', '2005-06-10 12:47:53', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_column(enq)', 'Enquire Column', 'Read', 'PROC', 'column_enq.php', 'N', 'ENQ1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2005-03-12 23:29:51', 'AJM', '2006-01-17 18:49:06', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_column(list)', 'dict_column(enq)', '001', 'Read', 'Y', '2005-04-24 12:24:52', 'AJM', NULL, NULL),
('dict_column(list)2', 'dict_column(enq)', '002', 'Read', 'Y', '2005-03-12 23:30:56', 'AJM', '2005-03-12 23:31:35', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_column(enq)', '2005-04-20 21:29:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_column(import)', 'Import Column Names', 'Import', 'PROC', 'column_import.php', 'N', 'ADD4', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-13 15:53:17', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_column(list)2', 'dict_column(import)', '007', 'Import Columns', 'N', '2005-03-13 15:53:33', 'AJM', '2005-04-05 13:08:59', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_column(list)', 'List Columns', 'Columns', 'PROC', 'column_list.php', 'N', 'LIST1', 'DICT', NULL, NULL, NULL, NULL, 'database_id,table_id,column_seq', 'Y', 'N', NULL, 'N', '2005-04-24 12:20:09', 'AJM', '2006-10-15 11:32:39', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_column(list)', 'dict_column(enq)', '001', 'Read', 'Y', '2005-04-24 12:24:52', 'AJM', NULL, NULL),
('dict_column(list)', 'dict_column(search)', '002', 'Search', 'N', '2005-04-24 12:24:53', 'AJM', NULL, NULL),
('dict_column(list)', 'dict_column(upd)', '003', 'Update', 'Y', '2005-06-10 12:47:53', 'AJM', '2005-06-10 12:48:13', 'AJM'),
('dict_column(list)', 'dict_column(del)', '004', 'Delete', 'Y', '2005-06-10 12:47:53', 'AJM', NULL, NULL),
('dict_column(list)', 'dict_column(pdf)', '005', 'Output to PDF(L)', 'N', '2006-08-18 10:55:04', 'AJM', '2006-10-01 11:33:40', 'AJM'),
('dict_column(list)', 'dict_column(pdf)2', '006', 'Output to PDF(D)', 'N', '2006-08-18 11:32:26', 'AJM', '2006-10-01 11:33:40', 'AJM'),
('dict_column(list)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2005-06-10 12:47:40', 'AJM', '2006-10-01 11:33:40', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_column(list)', '2005-04-24 12:47:09', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_column(list)2', 'List Column by Database Table', 'Columns', 'PROC', 'column_list2.php', 'N', 'LIST2', 'DICT', NULL, NULL, NULL, NULL, 'column_seq', 'N', NULL, NULL, 'N', '2005-03-12 23:28:37', 'AJM', '2005-04-24 12:19:17', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_column(list)2', 'dict_column(enq)', '002', 'Read', 'Y', '2005-03-12 23:30:56', 'AJM', '2005-03-12 23:31:35', 'AJM'),
('dict_column(list)2', 'dict_column(upd)', '003', 'Update', 'Y', '2005-03-12 23:30:56', 'AJM', '2005-03-12 23:35:42', 'AJM'),
('dict_column(list)2', 'dict_column(del)', '004', 'Delete', 'Y', '2005-03-12 23:30:56', 'AJM', '2005-03-12 23:35:42', 'AJM'),
('dict_column(list)2', 'dict_column(search)', '005', 'Search', 'N', '2005-03-12 23:30:56', 'AJM', '2005-03-12 23:35:42', 'AJM'),
('dict_column(list)2', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2005-03-12 23:43:28', 'AJM', '2005-03-12 23:43:43', 'AJM'),
('dict_column(list)2', 'dict_column(import)', '007', 'Import Columns', 'N', '2005-03-13 15:53:33', 'AJM', '2005-04-05 13:08:59', 'AJM'),
('dict_column(list)2', 'dict_table_key(list)2', '008', 'Keys', 'N', '2005-03-20 10:42:57', 'AJM', '2005-03-20 10:43:05', 'AJM'),
('dict_column(list)2', 'dict_relationship(list)2', '009', 'Relationships', 'N', '2005-04-09 17:06:49', 'AJM', '2005-04-09 17:07:42', 'AJM'),
('dict_column(list)2', 'dict_table(export)', '010', 'Export to PHP', 'N', '2005-04-05 17:27:54', 'AJM', '2005-04-09 17:07:42', 'AJM'),
('dict_column(list)2', 'dict_column(pdf)', '011', 'Output to PDF(L)', 'N', '2006-08-18 10:55:22', 'AJM', '2006-10-05 11:14:43', 'AJM'),
('dict_column(list)2', 'dict_column(pdf)2', '012', 'Output to PDF(D)', 'N', '2006-08-18 11:32:39', 'AJM', '2006-10-05 11:14:43', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(list)', 'dict_column(list)2', '006', 'Columns', 'Y', '2005-04-24 11:41:23', 'AJM', '2005-06-10 12:42:29', 'AJM'),
('dict_table(list)2', 'dict_column(list)2', '008', 'Columns', 'Y', '2005-03-12 23:34:39', 'AJM', '2005-03-27 20:39:07', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_column(list)2', '2005-04-20 21:29:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_column(pdf)', 'Output to PDF - List view', 'Output to PDF(L)', 'PROC', 'column_pdf.php', 'N', 'OUTPUT2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-08-18 10:54:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_column(list)', 'dict_column(pdf)', '005', 'Output to PDF(L)', 'N', '2006-08-18 10:55:04', 'AJM', '2006-10-01 11:33:40', 'AJM'),
('dict_column(list)2', 'dict_column(pdf)', '011', 'Output to PDF(L)', 'N', '2006-08-18 10:55:22', 'AJM', '2006-10-05 11:14:43', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_column(pdf)', '2006-08-18 13:24:36', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_column(pdf)2', 'Output to PDF - Detail view', 'Output to PDF(D)', 'PROC', 'column_pdf2.php', 'N', 'OUTPUT3', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-08-18 11:32:06', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_column(list)', 'dict_column(pdf)2', '006', 'Output to PDF(D)', 'N', '2006-08-18 11:32:26', 'AJM', '2006-10-01 11:33:40', 'AJM'),
('dict_column(list)2', 'dict_column(pdf)2', '012', 'Output to PDF(D)', 'N', '2006-08-18 11:32:39', 'AJM', '2006-10-05 11:14:43', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_column(pdf)2', '2006-08-18 13:24:52', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_column(search)', 'Search Column', 'Search', 'PROC', 'column_search.php', 'N', 'SRCH', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-12 23:30:13', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_column(list)', 'dict_column(search)', '002', 'Search', 'N', '2005-04-24 12:24:53', 'AJM', NULL, NULL),
('dict_column(list)2', 'dict_column(search)', '005', 'Search', 'N', '2005-03-12 23:30:56', 'AJM', '2005-03-12 23:35:42', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_column(search)', '2005-04-20 21:29:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_column(upd)', 'Update Column', 'Update', 'PROC', 'column_upd.php', 'N', 'UPD1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-12 23:30:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_column(list)2', 'dict_column(upd)', '003', 'Update', 'Y', '2005-03-12 23:30:56', 'AJM', '2005-03-12 23:35:42', 'AJM'),
('dict_column(list)', 'dict_column(upd)', '003', 'Update', 'Y', '2005-06-10 12:47:53', 'AJM', '2005-06-10 12:48:13', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(del)', 'Delete Database', 'Delete', 'PROC', 'database_del.php', 'N', 'DEL1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-12 18:34:27', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(list)', 'dict_database(del)', '004', 'Delete', 'Y', '2005-03-12 18:36:18', 'AJM', '2005-06-11 14:09:08', 'AJM'),
('dict_database(list)2', 'dict_database(del)', '004', 'Delete', 'Y', '2005-03-12 19:08:14', 'AJM', '2005-06-10 17:20:20', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(enq)', 'Enquire Database', 'Read', 'PROC', 'database_enq.php', 'N', 'ENQ1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-12 18:34:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(list)', 'dict_database(enq)', '002', 'Read', 'Y', '2005-03-12 18:36:18', 'AJM', '2005-06-11 14:14:44', 'AJM'),
('dict_database(list)2', 'dict_database(enq)', '002', 'Read', 'Y', '2005-03-12 19:08:14', 'AJM', '2005-03-12 19:08:23', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_database(enq)', '2005-04-20 21:29:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(erase)', 'Erase Database details', 'Erase', 'PROC', 'database_erase.php', 'N', 'ERASE1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-12-10 11:51:10', 'AJM', '2005-12-18 16:03:58', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(list)', 'dict_database(erase)', '009', 'Erase', 'Y', '2005-12-10 12:32:37', 'AJM', '2005-12-10 12:33:03', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(export)', 'Export Database details', 'Export', 'PROC', 'database_export.php', 'N', 'UPD4', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-12-07 22:58:10', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(list)', 'dict_database(export)', '008', 'Export', 'Y', '2005-12-07 22:58:33', 'AJM', '2005-12-07 22:58:51', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(import)', 'Import Database Details', 'Import', 'PROC', 'database_import.php', 'N', 'ADD1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2005-03-13 11:33:39', 'AJM', '2006-06-22 10:55:02', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(list)', 'dict_database(import)', '005', 'Import Database', 'N', '2005-03-13 11:34:09', 'AJM', '2006-06-22 10:55:26', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(list)', 'List Database', 'Databases', 'PROC', 'database_list.php', 'N', 'LIST1', 'DICT', NULL, NULL, NULL, NULL, 'database_id', 'N', NULL, NULL, 'N', '2005-03-12 18:33:01', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(list)', 'dict_database(search)', '001', 'Search', 'N', '2005-03-12 18:36:18', 'AJM', '2005-06-11 14:14:44', 'AJM'),
('dict_database(list)', 'dict_database(enq)', '002', 'Read', 'Y', '2005-03-12 18:36:18', 'AJM', '2005-06-11 14:14:44', 'AJM'),
('dict_database(list)', 'dict_database(upd)', '003', 'Update', 'Y', '2005-03-12 18:36:18', 'AJM', '2005-06-11 14:09:08', 'AJM'),
('dict_database(list)', 'dict_database(del)', '004', 'Delete', 'Y', '2005-03-12 18:36:18', 'AJM', '2005-06-11 14:09:08', 'AJM'),
('dict_database(list)', 'dict_database(import)', '005', 'Import Database', 'N', '2005-03-13 11:34:09', 'AJM', '2006-06-22 10:55:26', 'AJM'),
('dict_database(list)', 'dict_table(list)2', '006', 'Tables', 'Y', '2005-03-12 22:53:50', 'AJM', '2005-06-10 17:18:33', 'AJM'),
('dict_database(list)', 'dict_relationship(list)3', '007', 'Relationships', 'Y', '2005-06-11 20:03:15', 'AJM', '2005-06-11 20:03:35', 'AJM'),
('dict_database(list)', 'dict_database(export)', '008', 'Export', 'Y', '2005-12-07 22:58:33', 'AJM', '2005-12-07 22:58:51', 'AJM'),
('dict_database(list)', 'dict_database(erase)', '009', 'Erase', 'Y', '2005-12-10 12:32:37', 'AJM', '2005-12-10 12:33:03', 'AJM'),
('dict_database(list)', 'audit_dtl(list)3', '010', 'Audit Trail', 'Y', '2005-03-12 19:07:33', 'AJM', '2005-12-10 12:33:03', 'AJM'),
('dict_database(list)', 'audit_dtl(list)3exact', '011', 'Audit Trail (exact)', 'Y', '2005-03-12 19:07:33', 'AJM', '2005-12-10 12:33:03', 'AJM'),
('dict_database(list)', 'dict_database(pdf)', '012', 'Output to PDF(L)', 'N', '2006-08-17 20:19:31', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_database(list)', '2005-04-20 21:29:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(list)2', 'List Database by Subsystem', 'Databases', 'PROC', 'database_list2.php', 'N', 'LIST2', 'DICT', NULL, NULL, NULL, NULL, 'database_id', 'N', NULL, NULL, 'N', '2005-03-12 18:55:37', 'AJM', '2005-03-12 23:10:50', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(list)2', 'dict_database(search)', '001', 'Search', 'N', '2005-03-12 19:08:14', 'AJM', '2005-06-10 17:20:20', 'AJM'),
('dict_database(list)2', 'dict_database(enq)', '002', 'Read', 'Y', '2005-03-12 19:08:14', 'AJM', '2005-03-12 19:08:23', 'AJM'),
('dict_database(list)2', 'dict_database(upd)', '003', 'Update', 'Y', '2005-03-12 19:08:14', 'AJM', '2005-06-10 17:20:20', 'AJM'),
('dict_database(list)2', 'dict_database(del)', '004', 'Delete', 'Y', '2005-03-12 19:08:14', 'AJM', '2005-06-10 17:20:20', 'AJM'),
('dict_database(list)2', 'dict_table(list)2', '005', 'Tables', 'Y', '2005-03-12 22:54:17', 'AJM', '2005-06-10 17:20:20', 'AJM'),
('dict_database(list)2', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2005-03-12 19:08:37', 'AJM', '2005-06-10 17:20:20', 'AJM'),
('dict_database(list)2', 'audit_dtl(list)3exact', '007', 'Audit Trail (exact)', 'Y', '2005-03-12 19:08:37', 'AJM', '2005-03-12 22:54:26', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(list)', 'dict_database(list)2', '008', 'Databases', 'Y', '2005-03-12 18:56:34', 'AJM', '2005-07-15 21:14:32', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_database(list)2', '2005-04-20 21:29:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(pdf)', 'Output to PDF - List view', 'Output to PDF(L)', 'PROC', 'database_pdf.php', 'N', 'OUTPUT2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-08-17 20:19:09', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(list)', 'dict_database(pdf)', '012', 'Output to PDF(L)', 'N', '2006-08-17 20:19:31', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_database(pdf)', '2006-08-18 13:24:37', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(popup1)', 'Choose Dict Database', 'Choose', 'PROC', 'dict_database(popup1).php', 'N', 'POPUP1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'Y', 'N', NULL, 'N', '2007-02-26 20:57:55', 'AJM', '2007-07-17 13:36:15', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(search)', 'Search Database', 'Search', 'PROC', 'database_search.php', 'N', 'SRCH', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-12 18:35:58', 'AJM', '2005-03-12 23:38:00', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(list)', 'dict_database(search)', '001', 'Search', 'N', '2005-03-12 18:36:18', 'AJM', '2005-06-11 14:14:44', 'AJM'),
('dict_database(list)2', 'dict_database(search)', '001', 'Search', 'N', '2005-03-12 19:08:14', 'AJM', '2005-06-10 17:20:20', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_database(search)', '2005-04-20 21:29:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(upd)', 'Update Database', 'Update', 'PROC', 'database_upd.php', 'N', 'UPD1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-12 18:35:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(list)', 'dict_database(upd)', '003', 'Update', 'Y', '2005-03-12 18:36:18', 'AJM', '2005-06-11 14:09:08', 'AJM'),
('dict_database(list)2', 'dict_database(upd)', '003', 'Update', 'Y', '2005-03-12 19:08:14', 'AJM', '2005-06-10 17:20:20', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_related_column(list)2', 'Enquire Relationship', 'Related Columns', 'PROC', 'related_column_list2.php', 'N', 'LIST2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-06-23 19:11:04', 'AJM', '2005-06-23 19:23:57', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_related_column(list)2', 'dict_related_column(multi)2', '001', 'Update', 'N', '2005-06-25 18:14:46', 'AJM', '2005-06-26 12:36:00', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_relationship(list)3', 'dict_related_column(list)2', '002', 'Read', 'Y', '2005-06-23 19:22:18', 'AJM', '2005-06-26 12:37:31', 'AJM'),
('dict_relationship(list)', 'dict_related_column(list)2', '002', 'Read', 'Y', '2005-06-23 19:18:20', 'AJM', '2005-06-26 12:38:42', 'AJM'),
('dict_relationship(list)2', 'dict_related_column(list)2', '003', 'Read', 'Y', '2005-06-23 19:24:50', 'AJM', '2005-06-26 12:36:53', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_related_column(list)2', '2006-04-07 17:28:12', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_related_column(multi)2', 'Update Relationship', 'Update', 'PROC', 'related_column_multi2.php', 'N', 'MULTI4', 'DICT', NULL, NULL, NULL, NULL, 'seq_in_index', 'N', NULL, NULL, 'N', '2005-06-25 16:49:54', 'AJM', '2005-06-25 17:31:05', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_related_column(list)2', 'dict_related_column(multi)2', '001', 'Update', 'N', '2005-06-25 18:14:46', 'AJM', '2005-06-26 12:36:00', 'AJM'),
('dict_relationship(list)3', 'dict_related_column(multi)2', '003', 'Update', 'Y', '2005-06-25 18:03:51', 'AJM', '2005-06-26 12:37:31', 'AJM'),
('dict_relationship(list)', 'dict_related_column(multi)2', '003', 'Update', 'Y', '2005-06-25 18:08:41', 'AJM', '2005-06-26 12:38:42', 'AJM'),
('dict_relationship(list)2', 'dict_related_column(multi)2', '004', 'Update', 'Y', '2005-06-25 17:15:56', 'AJM', '2005-06-26 12:36:53', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_relationship(add)', 'Add Relationship', 'New', 'PROC', 'relationship_add.php', 'N', 'ADD2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-20 12:05:46', 'AJM', '2005-04-22 19:41:27', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_relationship(list)2', 'dict_relationship(add)', '001', 'New', 'N', '2005-03-20 12:07:53', 'AJM', '2005-03-20 12:08:33', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_relationship(del)', 'Delete Relationship', 'Delete', 'PROC', 'relationship_del.php', 'N', 'DEL4', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2005-03-20 12:06:16', 'AJM', '2006-03-11 14:29:24', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_relationship(list)', 'dict_relationship(del)', '004', 'Delete', 'Y', '2005-06-10 12:46:19', 'AJM', '2005-06-26 12:38:42', 'AJM'),
('dict_relationship(list)3', 'dict_relationship(del)', '004', 'Delete', 'Y', '2005-06-10 15:43:00', 'AJM', '2005-06-26 12:37:31', 'AJM'),
('dict_relationship(list)2', 'dict_relationship(del)', '005', 'Delete', 'Y', '2005-03-20 12:07:53', 'AJM', '2005-06-26 12:36:53', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_relationship(list)', 'List Relationships', 'Relationships', 'PROC', 'relationship_list.php', 'N', 'LIST1', 'DICT', NULL, NULL, NULL, NULL, 'database_id_snr,table_id_snr', 'Y', 'N', NULL, 'N', '2005-04-24 11:51:49', 'AJM', '2006-10-15 11:32:20', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_relationship(list)', 'dict_relationship(search)', '001', 'Search', 'N', '2005-04-24 11:57:55', 'AJM', '2005-04-24 11:58:07', 'AJM'),
('dict_relationship(list)', 'dict_related_column(list)2', '002', 'Read', 'Y', '2005-06-23 19:18:20', 'AJM', '2005-06-26 12:38:42', 'AJM'),
('dict_relationship(list)', 'dict_related_column(multi)2', '003', 'Update', 'Y', '2005-06-25 18:08:41', 'AJM', '2005-06-26 12:38:42', 'AJM'),
('dict_relationship(list)', 'dict_relationship(del)', '004', 'Delete', 'Y', '2005-06-10 12:46:19', 'AJM', '2005-06-26 12:38:42', 'AJM'),
('dict_relationship(list)', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2005-06-11 18:38:45', 'AJM', '2005-06-26 12:38:42', 'AJM'),
('dict_relationship(list)', 'dict_relationship(pdf)', '006', 'Output to PDF(L)', 'N', '2006-08-17 20:50:49', 'AJM', NULL, NULL),
('dict_relationship(list)', 'dict_relationship(pdf)2', '007', 'Output to PDF(D)', 'N', '2006-08-21 19:31:14', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_relationship(list)', '2005-04-24 12:47:09', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_relationship(list)2', 'List Relationship by Table', 'Relationships', 'PROC', 'relationship_list2.php', 'N', 'LIST2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-20 12:05:16', 'AJM', '2005-04-24 11:50:04', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_relationship(list)2', 'dict_relationship(add)', '001', 'New', 'N', '2005-03-20 12:07:53', 'AJM', '2005-03-20 12:08:33', 'AJM'),
('dict_relationship(list)2', 'dict_relationship(search)', '002', 'Search', 'N', '2005-03-20 12:07:53', 'AJM', '2005-06-11 19:06:56', 'AJM'),
('dict_relationship(list)2', 'dict_related_column(list)2', '003', 'Read', 'Y', '2005-06-23 19:24:50', 'AJM', '2005-06-26 12:36:53', 'AJM'),
('dict_relationship(list)2', 'dict_related_column(multi)2', '004', 'Update', 'Y', '2005-06-25 17:15:56', 'AJM', '2005-06-26 12:36:53', 'AJM'),
('dict_relationship(list)2', 'dict_relationship(del)', '005', 'Delete', 'Y', '2005-03-20 12:07:53', 'AJM', '2005-06-26 12:36:53', 'AJM'),
('dict_relationship(list)2', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2005-06-11 18:39:37', 'AJM', '2005-06-26 12:36:53', 'AJM'),
('dict_relationship(list)2', 'dict_relationship(pdf)', '007', 'Output to PDF(L)', 'N', '2006-08-17 20:51:00', 'AJM', NULL, NULL),
('dict_relationship(list)2', 'dict_relationship(pdf)2', '008', 'Output to PDF(D)', 'N', '2006-08-21 19:31:29', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(list)', 'dict_relationship(list)2', '008', 'Relationships', 'Y', '2005-04-24 11:41:23', 'AJM', '2005-06-10 12:43:09', 'AJM'),
('dict_column(list)2', 'dict_relationship(list)2', '009', 'Relationships', 'N', '2005-04-09 17:06:49', 'AJM', '2005-04-09 17:07:42', 'AJM'),
('dict_table(list)2', 'dict_relationship(list)2', '010', 'Relationships (Table)', 'Y', '2005-03-20 12:09:07', 'AJM', '2005-04-05 14:12:09', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_relationship(list)2', '2005-04-20 21:30:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_relationship(list)3', 'List Relationship by Database', 'Relationships', 'PROC', 'relationship_list3.php', 'N', 'LIST2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-21 20:19:24', 'AJM', '2005-04-24 11:49:51', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_relationship(list)3', 'dict_relationship(search)', '001', 'Search', 'N', '2005-03-21 20:26:06', 'AJM', '2005-06-11 19:07:53', 'AJM'),
('dict_relationship(list)3', 'dict_related_column(list)2', '002', 'Read', 'Y', '2005-06-23 19:22:18', 'AJM', '2005-06-26 12:37:31', 'AJM'),
('dict_relationship(list)3', 'dict_related_column(multi)2', '003', 'Update', 'Y', '2005-06-25 18:03:51', 'AJM', '2005-06-26 12:37:31', 'AJM'),
('dict_relationship(list)3', 'dict_relationship(del)', '004', 'Delete', 'Y', '2005-06-10 15:43:00', 'AJM', '2005-06-26 12:37:31', 'AJM'),
('dict_relationship(list)3', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2005-06-11 18:41:56', 'AJM', '2005-06-26 12:37:31', 'AJM'),
('dict_relationship(list)3', 'dict_relationship(pdf)', '006', 'Output to PDF(L)', 'N', '2006-08-17 20:51:11', 'AJM', NULL, NULL),
('dict_relationship(list)3', 'dict_relationship(pdf)2', '007', 'Output to PDF(D)', 'N', '2006-08-21 19:31:41', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(list)', 'dict_relationship(list)3', '007', 'Relationships', 'Y', '2005-06-11 20:03:15', 'AJM', '2005-06-11 20:03:35', 'AJM'),
('dict_table(list)2', 'dict_relationship(list)3', '013', 'Relationships (DB)', 'N', '2005-03-21 20:20:39', 'AJM', '2006-10-01 11:27:45', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_relationship(list)3', '2005-04-20 21:30:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_relationship(pdf)', 'Output to PDF - List view', 'Output to PDF(L)', 'PROC', 'relationship_pdf.php', 'N', 'OUTPUT2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-08-17 20:50:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_relationship(list)3', 'dict_relationship(pdf)', '006', 'Output to PDF(L)', 'N', '2006-08-17 20:51:11', 'AJM', NULL, NULL),
('dict_relationship(list)', 'dict_relationship(pdf)', '006', 'Output to PDF(L)', 'N', '2006-08-17 20:50:49', 'AJM', NULL, NULL),
('dict_relationship(list)2', 'dict_relationship(pdf)', '007', 'Output to PDF(L)', 'N', '2006-08-17 20:51:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_relationship(pdf)', '2006-08-18 13:24:37', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_relationship(pdf)2', 'Output to PDF - Detail view', 'Output to PDF(D)', 'PROC', 'relationship_pdf2.php', 'N', 'OUTPUT3', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-08-21 19:30:32', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_relationship(list)', 'dict_relationship(pdf)2', '007', 'Output to PDF(D)', 'N', '2006-08-21 19:31:14', 'AJM', NULL, NULL),
('dict_relationship(list)3', 'dict_relationship(pdf)2', '007', 'Output to PDF(D)', 'N', '2006-08-21 19:31:41', 'AJM', NULL, NULL),
('dict_relationship(list)2', 'dict_relationship(pdf)2', '008', 'Output to PDF(D)', 'N', '2006-08-21 19:31:29', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_relationship(pdf)2', '2006-08-22 17:40:18', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_relationship(search)', 'Search Relationship', 'Search', 'PROC', 'relationship_search.php', 'N', 'SRCH', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-20 12:07:06', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_relationship(list)3', 'dict_relationship(search)', '001', 'Search', 'N', '2005-03-21 20:26:06', 'AJM', '2005-06-11 19:07:53', 'AJM'),
('dict_relationship(list)', 'dict_relationship(search)', '001', 'Search', 'N', '2005-04-24 11:57:55', 'AJM', '2005-04-24 11:58:07', 'AJM'),
('dict_relationship(list)2', 'dict_relationship(search)', '002', 'Search', 'N', '2005-03-20 12:07:53', 'AJM', '2005-06-11 19:06:56', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_relationship(search)', '2005-04-20 21:30:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table_key(del)', 'Delete Key', 'Delete', 'PROC', 'table_key_del.php', 'N', 'DEL1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-19 18:19:46', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table_key(list)', 'dict_table_key(del)', '003', 'Delete', 'Y', '2005-06-10 09:45:08', 'AJM', '2005-06-10 09:45:22', 'AJM'),
('dict_table_key(list)2', 'dict_table_key(del)', '004', 'Delete', 'Y', '2005-03-19 18:22:14', 'AJM', '2005-03-19 19:34:24', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table_key(enq)', 'Enquire Key', 'Read', 'PROC', 'table_key_enq.php', 'N', 'ENQ1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-19 18:20:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table_key(list)', 'dict_table_key(enq)', '002', 'Read', 'Y', '2005-06-10 09:45:08', 'AJM', NULL, NULL),
('dict_table_key(list)2', 'dict_table_key(enq)', '002', 'Read', 'Y', '2005-03-19 18:22:14', 'AJM', '2005-03-19 19:34:24', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_table_key(enq)', '2005-04-20 21:30:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table_key(list)', 'List Table Keys', 'Keys', 'PROC', 'table_key_list.php', 'N', 'LIST1', 'DICT', NULL, NULL, NULL, NULL, 'database_id,table_id,column_seq', 'Y', 'N', NULL, 'N', '2005-06-10 09:20:55', 'AJM', '2006-10-15 11:31:46', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table_key(list)', 'dict_table_key(search)', '001', 'Search', 'N', '2005-06-10 09:45:08', 'AJM', '2005-06-10 09:45:22', 'AJM'),
('dict_table_key(list)', 'dict_table_key(enq)', '002', 'Read', 'Y', '2005-06-10 09:45:08', 'AJM', NULL, NULL),
('dict_table_key(list)', 'dict_table_key(del)', '003', 'Delete', 'Y', '2005-06-10 09:45:08', 'AJM', '2005-06-10 09:45:22', 'AJM'),
('dict_table_key(list)', 'audit_dtl(list)3', '004', 'Audit Trail', 'Y', '2005-06-10 09:45:43', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_table_key(list)', '2006-04-07 17:28:12', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table_key(list)2', 'List Keys by Database Table', 'Keys', 'PROC', 'table_key_list2.php', 'N', 'LIST2', 'DICT', NULL, NULL, NULL, NULL, 'column_seq', 'N', NULL, NULL, 'N', '2005-03-19 18:18:41', 'AJM', '2005-06-10 09:19:38', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table_key(list)2', 'dict_table_key(enq)', '002', 'Read', 'Y', '2005-03-19 18:22:14', 'AJM', '2005-03-19 19:34:24', 'AJM'),
('dict_table_key(list)2', 'dict_table_key(del)', '004', 'Delete', 'Y', '2005-03-19 18:22:14', 'AJM', '2005-03-19 19:34:24', 'AJM'),
('dict_table_key(list)2', 'dict_table_key(search)', '005', 'Search', 'N', '2005-03-19 18:22:14', 'AJM', '2005-03-19 19:34:24', 'AJM'),
('dict_table_key(list)2', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2005-03-19 18:22:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(list)', 'dict_table_key(list)2', '007', 'Keys', 'Y', '2005-04-24 11:41:57', 'AJM', '2005-06-10 12:43:09', 'AJM'),
('dict_column(list)2', 'dict_table_key(list)2', '008', 'Keys', 'N', '2005-03-20 10:42:57', 'AJM', '2005-03-20 10:43:05', 'AJM'),
('dict_table(list)2', 'dict_table_key(list)2', '009', 'Keys', 'Y', '2005-03-19 18:23:12', 'AJM', '2005-04-05 14:12:09', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_table_key(list)2', '2005-04-20 21:30:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table_key(search)', 'Search Key', 'Search', 'PROC', 'table_key_search.php', 'N', 'SRCH', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-19 18:20:39', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table_key(list)', 'dict_table_key(search)', '001', 'Search', 'N', '2005-06-10 09:45:08', 'AJM', '2005-06-10 09:45:22', 'AJM'),
('dict_table_key(list)2', 'dict_table_key(search)', '005', 'Search', 'N', '2005-03-19 18:22:14', 'AJM', '2005-03-19 19:34:24', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_table_key(search)', '2005-04-20 21:30:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(del)', 'Delete Table', 'Delete', 'PROC', 'table_del.php', 'N', 'DEL1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-12 23:07:36', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(list)2', 'dict_table(del)', '004', 'Delete', 'Y', '2005-03-12 23:11:54', 'AJM', '2005-03-12 23:34:25', 'AJM'),
('dict_table(list)', 'dict_table(del)', '004', 'Delete', 'Y', '2005-06-10 12:40:38', 'AJM', '2005-06-10 12:41:08', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(enq)', 'Enquire Table', 'Read', 'PROC', 'table_enq.php', 'N', 'ENQ1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-12 23:08:36', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(enq)', 'dict_table(export)', '001', 'Export to PHP', 'Y', '2006-10-01 11:28:19', 'AJM', '2006-10-01 11:29:00', 'AJM'),
('dict_table(enq)', 'dict_table(generate)a', '002', 'Generate PHP', 'Y', '2006-10-01 11:28:19', 'AJM', '2006-10-01 11:35:39', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(list)2', 'dict_table(enq)', '002', 'Read', 'Y', '2005-03-12 23:11:54', 'AJM', '2005-03-12 23:34:25', 'AJM'),
('dict_table(list)', 'dict_table(enq)', '002', 'Read', 'Y', '2005-04-24 11:40:23', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_table(enq)', '2005-04-20 21:29:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(export)', 'Export Table Script', 'Export', 'PROC', 'table_export.php', 'N', 'UPD4', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-27 20:37:04', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(enq)', 'dict_table(export)', '001', 'Export to PHP', 'Y', '2006-10-01 11:28:19', 'AJM', '2006-10-01 11:29:00', 'AJM'),
('dict_table(list)', 'dict_table(export)', '005', 'Export to PHP', 'Y', '2005-06-10 12:41:58', 'AJM', '2005-06-10 12:42:29', 'AJM'),
('dict_table(list)2', 'dict_table(export)', '007', 'Export to PHP', 'Y', '2005-03-27 20:38:27', 'AJM', '2005-03-27 20:39:08', 'AJM'),
('dict_column(list)2', 'dict_table(export)', '010', 'Export to PHP', 'N', '2005-04-05 17:27:54', 'AJM', '2005-04-09 17:07:42', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(generate)a', 'Generate PHP scripts (a) - Select Pattern', 'Generate PHP', 'PROC', 'table_generate_a.php', 'N', 'UPD1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-09-30 16:56:15', 'AJM', '2006-10-15 11:26:58', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(enq)', 'dict_table(generate)a', '002', 'Generate PHP', 'Y', '2006-10-01 11:28:19', 'AJM', '2006-10-01 11:35:39', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(generate)b', 'Generate PHP scripts (b) - Enter details', 'Generate PHP', 'PROC', 'table_generate_b.php', 'N', 'UPD1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-10-01 11:44:27', 'AJM', '2006-10-15 11:27:13', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(import)', 'Import Table Names', 'Import', 'PROC', 'table_import.php', 'N', 'ADD4', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-13 14:54:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(list)2', 'dict_table(import)', '006', 'Import Tables', 'N', '2005-03-13 14:54:39', 'AJM', '2005-03-19 18:25:29', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(list)', 'List Database Tables', 'Tables', 'PROC', 'table_list.php', 'N', 'LIST1', 'DICT', NULL, NULL, NULL, NULL, 'database_id,table_id', 'Y', 'N', NULL, 'N', '2005-04-24 10:48:37', 'AJM', '2006-10-15 11:29:49', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(list)', 'dict_table(search)', '001', 'Search', 'N', '2005-04-24 10:59:37', 'AJM', NULL, NULL),
('dict_table(list)', 'dict_table(enq)', '002', 'Read', 'Y', '2005-04-24 11:40:23', 'AJM', NULL, NULL),
('dict_table(list)', 'dict_table(upd)', '003', 'Update', 'Y', '2005-04-24 11:40:47', 'AJM', NULL, NULL),
('dict_table(list)', 'dict_table(del)', '004', 'Delete', 'Y', '2005-06-10 12:40:38', 'AJM', '2005-06-10 12:41:08', 'AJM'),
('dict_table(list)', 'dict_table(export)', '005', 'Export to PHP', 'Y', '2005-06-10 12:41:58', 'AJM', '2005-06-10 12:42:29', 'AJM'),
('dict_table(list)', 'dict_column(list)2', '006', 'Columns', 'Y', '2005-04-24 11:41:23', 'AJM', '2005-06-10 12:42:29', 'AJM'),
('dict_table(list)', 'dict_table_key(list)2', '007', 'Keys', 'Y', '2005-04-24 11:41:57', 'AJM', '2005-06-10 12:43:09', 'AJM'),
('dict_table(list)', 'dict_relationship(list)2', '008', 'Relationships', 'Y', '2005-04-24 11:41:23', 'AJM', '2005-06-10 12:43:09', 'AJM'),
('dict_table(list)', 'audit_dtl(list)3', '009', 'Audit Trail', 'Y', '2005-06-10 12:43:33', 'AJM', '2006-10-01 11:27:01', 'AJM'),
('dict_table(list)', 'dict_table(pdf)', '010', 'Output to PDF(L)', 'N', '2006-08-17 20:33:12', 'AJM', '2006-10-01 11:27:02', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_table(list)', '2005-04-24 12:47:09', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(list)2', 'List Table by Database', 'Tables', 'PROC', 'table_list2.php', 'N', 'LIST2', 'DICT', NULL, NULL, NULL, NULL, 'table_id', 'N', NULL, NULL, 'N', '2005-03-12 22:53:15', 'AJM', '2005-04-24 10:46:56', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(list)2', 'dict_table(enq)', '002', 'Read', 'Y', '2005-03-12 23:11:54', 'AJM', '2005-03-12 23:34:25', 'AJM'),
('dict_table(list)2', 'dict_table(upd)', '003', 'Update', 'Y', '2005-03-12 23:11:55', 'AJM', '2005-03-12 23:34:26', 'AJM'),
('dict_table(list)2', 'dict_table(del)', '004', 'Delete', 'Y', '2005-03-12 23:11:54', 'AJM', '2005-03-12 23:34:25', 'AJM'),
('dict_table(list)2', 'dict_table(search)', '005', 'Search', 'N', '2005-03-12 23:11:55', 'AJM', '2005-03-12 23:34:25', 'AJM'),
('dict_table(list)2', 'dict_table(import)', '006', 'Import Tables', 'N', '2005-03-13 14:54:39', 'AJM', '2005-03-19 18:25:29', 'AJM'),
('dict_table(list)2', 'dict_table(export)', '007', 'Export to PHP', 'Y', '2005-03-27 20:38:27', 'AJM', '2005-03-27 20:39:08', 'AJM'),
('dict_table(list)2', 'dict_column(list)2', '008', 'Columns', 'Y', '2005-03-12 23:34:39', 'AJM', '2005-03-27 20:39:07', 'AJM'),
('dict_table(list)2', 'dict_table_key(list)2', '009', 'Keys', 'Y', '2005-03-19 18:23:12', 'AJM', '2005-04-05 14:12:09', 'AJM'),
('dict_table(list)2', 'dict_relationship(list)2', '010', 'Relationships (Table)', 'Y', '2005-03-20 12:09:07', 'AJM', '2005-04-05 14:12:09', 'AJM'),
('dict_table(list)2', 'audit_dtl(list)3', '011', 'Audit Trail', 'Y', '2005-03-12 23:12:27', 'AJM', '2006-10-01 11:27:45', 'AJM'),
('dict_table(list)2', 'audit_dtl(list)3exact', '012', 'Audit Trail (exact)', 'Y', '2005-03-12 23:45:26', 'AJM', '2006-10-01 11:27:45', 'AJM'),
('dict_table(list)2', 'dict_relationship(list)3', '013', 'Relationships (DB)', 'N', '2005-03-21 20:20:39', 'AJM', '2006-10-01 11:27:45', 'AJM'),
('dict_table(list)2', 'dict_table(pdf)', '014', 'Output to PDF(L)', 'N', '2006-08-17 20:33:39', 'AJM', '2006-10-01 11:27:45', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(list)2', 'dict_table(list)2', '005', 'Tables', 'Y', '2005-03-12 22:54:17', 'AJM', '2005-06-10 17:20:20', 'AJM'),
('dict_database(list)', 'dict_table(list)2', '006', 'Tables', 'Y', '2005-03-12 22:53:50', 'AJM', '2005-06-10 17:18:33', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_table(list)2', '2005-04-20 21:29:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(pdf)', 'Output to PDF - List view', 'Output to PDF(L)', 'PROC', 'table_pdf.php', 'N', 'OUTPUT2', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-08-17 20:32:47', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(list)', 'dict_table(pdf)', '010', 'Output to PDF(L)', 'N', '2006-08-17 20:33:12', 'AJM', '2006-10-01 11:27:02', 'AJM'),
('dict_table(list)2', 'dict_table(pdf)', '014', 'Output to PDF(L)', 'N', '2006-08-17 20:33:39', 'AJM', '2006-10-01 11:27:45', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_table(pdf)', '2006-08-18 13:24:37', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(popup)', 'Choose Database Table', 'Choose', 'PROC', 'table_popup.php', 'N', 'POPUP2', 'DICT', NULL, NULL, NULL, NULL, 'table_id', 'N', 'N', NULL, 'N', '2005-03-20 12:44:13', 'AJM', '2006-10-06 13:29:54', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_table(popup)', '2005-04-20 21:30:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(popup)jnr', 'Choose Database Table', 'Choose', 'PROC', 'table_popup.php', 'N', 'POPUP2', 'DICT', NULL, NULL, NULL, NULL, 'table_id', 'N', 'N', NULL, 'N', '2006-02-27 18:47:56', 'AJM', '2006-10-06 13:30:25', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_table(popup)jnr', '2006-04-07 17:28:54', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(popup)snr', 'Choose Database Table', 'Choose', 'PROC', 'table_popup.php', 'N', 'POPUP2', 'DICT', NULL, NULL, NULL, NULL, 'table_id', 'N', 'N', NULL, 'N', '2005-03-21 20:40:10', 'AJM', '2006-10-06 13:30:42', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_table(popup)snr', '2005-04-20 21:30:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(search)', 'Search Table', 'Search', 'PROC', 'table_search.php', 'N', 'SRCH', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-12 23:09:02', 'AJM', '2005-03-12 23:38:20', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(list)', 'dict_table(search)', '001', 'Search', 'N', '2005-04-24 10:59:37', 'AJM', NULL, NULL),
('dict_table(list)2', 'dict_table(search)', '005', 'Search', 'N', '2005-03-12 23:11:55', 'AJM', '2005-03-12 23:34:25', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'dict_table(search)', '2005-04-20 21:29:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(upd)', 'Update Table', 'Update', 'PROC', 'table_upd.php', 'N', 'UPD1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-12 23:09:25', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_table(list)2', 'dict_table(upd)', '003', 'Update', 'Y', '2005-03-12 23:11:55', 'AJM', '2005-03-12 23:34:26', 'AJM'),
('dict_table(list)', 'dict_table(upd)', '003', 'Update', 'Y', '2005-04-24 11:40:47', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dictionary', 'Data Dictionary', 'Dict', 'MENU', 'menu.php', 'N', 'MENU', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-03-12 18:37:06', 'AJM', NULL, NULL);

REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dictionary', 'dict_database(list)', '001', 'Databases', '2005-03-12 18:38:21', 'AJM', '2007-06-13 15:13:06', 'AJM'),
('dictionary', 'dict_table(list)', '002', 'Tables', '2005-04-24 10:49:34', 'AJM', NULL, NULL),
('dictionary', 'dict_table_key(list)', '003', 'Keys', '2005-06-10 09:23:39', 'AJM', '2005-06-10 09:23:54', 'AJM'),
('dictionary', 'dict_relationship(list)', '004', 'Relationships', '2005-04-24 11:52:31', 'AJM', '2005-06-10 09:23:54', 'AJM'),
('dictionary', 'dict_column(list)', '005', 'Columns', '2005-04-24 12:20:31', 'AJM', '2005-06-10 09:23:54', 'AJM');

REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('main_menu', 'dictionary', '002', 'Dictionary', '2005-03-12 18:37:25', 'AJM', '2005-05-05 17:47:27', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_column(del)', 'This will display a record from the DICT_COLUMN table and allow it to be deleted. 

Refer to <a href=\"%root%/dict_column(del).html\">Delete Column</a> for full details.', '2005-06-29 19:11:50', 'AJM', '2005-07-02 15:38:56', 'AJM'),
('dict_column(enq)', 'This will display the contents of a record from the DICT_COLUMN table.

Refer to <a href=\"%root%/dict_column(enq).html\">Enquire Columns</a> for full details.', '2005-06-29 19:05:34', 'AJM', '2005-07-02 15:39:01', 'AJM'),
('dict_column(list)', 'This will list records on the DICT_COLUMN table.

Refer to <a href=\"%root%/dict_column(list).html\">List Columns</a> for full details.', '2005-06-29 18:56:16', 'AJM', '2005-07-02 15:39:05', 'AJM'),
('dict_column(list)2', 'This will list records on the DICT_COLUMN table for a selected TABLE.

Refer to <a href=\"%root%/dict_column(list)2.html\">List Column by Database Table</a> for full details.', '2005-06-29 19:25:11', 'AJM', '2005-07-02 15:39:09', 'AJM'),
('dict_column(search)', 'This will allow search criteria to be entered for the DICT_COLUMN table. 

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/dict_column(search).html\">Search Column</a> for full details.', '2005-06-29 19:16:09', 'AJM', '2005-07-02 15:39:13', 'AJM'),
('dict_column(upd)', 'This will display the contents of a record from the DICT_COLUMN table and allow it to be updated.

Refer to <a href=\"%root%/dict_column(upd).html\">Update Column</a> for full details.', '2005-06-29 19:18:43', 'AJM', '2005-07-02 15:39:17', 'AJM'),
('dict_database(del)', 'This will enable a record on the DICT_DATABASE table to be deleted.

Refer to <a href=\"%root%/dict_database(del).html\">Delete Database</a> for full details.', '2005-06-29 19:02:41', 'AJM', '2005-07-02 15:39:22', 'AJM'),
('dict_database(enq)', 'This will display the contents of a record from the DICT_DATABASE table.

Refer to <a href=\"%root%/dict_database(enq).html\">Enquire Databases</a> for full details.', '2005-06-29 19:04:27', 'AJM', '2005-07-02 15:39:26', 'AJM'),
('dict_database(list)', 'This will list records on the DICT_DATABASE table.

Refer to <a href=\"%root%/dict_database(list).html\">List Databases</a> for full details.', '2005-06-29 18:57:00', 'AJM', '2005-07-02 15:39:30', 'AJM'),
('dict_database(list)2', 'This will list records on the DICT_DATABASE table for a selected SUBSYSTEM.

Refer to <a href=\"%root%/dict_database(list)2.html\">List Databases by Subsystem</a> for full details.', '2005-06-29 19:00:40', 'AJM', '2005-07-02 15:39:35', 'AJM'),
('dict_database(search)', 'This will allow search criteria to be entered for the DICT_DATABASE table. 

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/dict_database(search).html\">Search Database</a> for full details.', '2005-06-29 19:16:39', 'AJM', '2005-07-02 15:39:39', 'AJM'),
('dict_database(upd)', 'This will display the contents of a record from the DICT_DATABASE table and allow it to be updated.

Refer to <a href=\"%root%/dict_database(upd).html\">Update Database</a> for full details.', '2005-06-29 19:19:11', 'AJM', '2005-07-02 15:39:43', 'AJM'),
('dict_related_column(list)2', 'This will list records on the DICT_RELATIONSHIP table for a selected DATABASE.

Refer to <a href=\"%root%/dict_relationship(enq).html\">Enquire Relationship</a> for full details.', '2005-06-29 19:26:15', 'AJM', '2005-07-02 15:39:48', 'AJM'),
('dict_related_column(multi)2', 'This will list a record from the DICT_RELATIONSHIP table and allow it to be updated.

Refer to <a href=\"%root%/dict_related_column(multi)2.html\">Update Relationship</a> for full details.', '2005-06-29 19:35:11', 'AJM', '2005-07-02 15:39:52', 'AJM'),
('dict_relationship(add)', 'This will allow a new record to be added to the DICT_RELATIONSHIP table. 

Enter your data then press the SUBMIT button to add it to the database. 

Refer to <a href=\"%root%/dict_relationship(add).html\">Add Relationship</a> for full details.', '2005-06-29 19:09:53', 'AJM', '2005-07-02 15:39:56', 'AJM'),
('dict_relationship(del)', 'This will display a record from the DICT_RELATIONSHIP table and allow it to be deleted. 

Refer to <a href=\"%root%/dict_relationship(del).html\">Delete Relationship</a> for full details.', '2005-06-29 19:13:21', 'AJM', '2005-07-02 15:40:00', 'AJM'),
('dict_relationship(list)', 'This will list records on the DICT_RELATIONSHIP table.

Refer to <a href=\"%root%/dict_relationship(list).html\">List Relationships</a> for full details.', '2005-06-29 19:39:16', 'AJM', '2005-07-02 15:40:05', 'AJM'),
('dict_relationship(list)2', 'This will list records on the DICT_RELATIONSHIP table for a selected TABLE.

Refer to <a href=\"%root%/dict_relationship(list)2.html\">List Relationship by Table</a> for full details.', '2005-06-29 19:30:50', 'AJM', '2005-07-02 15:40:09', 'AJM'),
('dict_relationship(list)3', 'This will list records on the DICT_RELATIONSHIP table for a selected DATABASE.

Refer to <a href=\"%root%/dict_relationship(list)3.html\">List Relationship by Database</a> for full details.', '2005-06-29 19:31:17', 'AJM', '2005-07-02 15:40:13', 'AJM'),
('dict_relationship(search)', 'This will allow search criteria to be entered for the DICT_RELATIONSHIP table. 

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/dict_relationship(search).html\">Search Relationship</a> for full details.', '2005-06-29 19:48:22', 'AJM', '2005-07-02 15:40:17', 'AJM'),
('dict_table_key(del)', 'This will display a record from the DICT_TABLE_KEY table and allow it to be deleted. 

Refer to <a href=\"%root%/dict_table_key(del).html\">Delete Key</a> for full details.', '2005-06-29 19:14:15', 'AJM', '2005-07-02 15:40:57', 'AJM'),
('dict_table_key(enq)', 'This will display the contents of a record from the DICT_TABLE_KEY table.

Refer to <a href=\"%root%/dict_table_key(enq).html\">Enquire Key</a> for full details.', '2005-06-29 19:07:15', 'AJM', '2005-07-02 15:41:01', 'AJM'),
('dict_table_key(list)', 'This will list records on the DICT_TABLE_KEY table.

Refer to <a href=\"%root%/dict_table_key(list).html\">List Table Keys</a> for full details.', '2005-06-29 19:40:30', 'AJM', '2005-07-02 15:41:06', 'AJM'),
('dict_table_key(list)2', 'This will list records on the DICT_TABLE_KEY table for a selected TABLE.

Refer to <a href=\"%root%/dict_table_key(list)2.html\">List Keys by Database Table</a> for full details.', '2005-06-29 19:32:44', 'AJM', '2005-07-02 15:41:11', 'AJM'),
('dict_table_key(search)', 'This will allow search criteria to be entered for the DICT_TABLE_KEY table. 

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/dict_table_key(search).html\">Search Key</a> for full details.', '2005-06-29 19:17:30', 'AJM', '2005-07-02 15:41:15', 'AJM'),
('dict_table(del)', 'This will display a record from the DICT_TABLE table and allow it to be deleted. 

Refer to <a href=\"%root%/dict_table(del).html\">Delete Table</a> for full details.', '2005-06-29 19:13:48', 'AJM', '2005-07-02 15:40:21', 'AJM'),
('dict_table(enq)', 'This will display the contents of a record from the DICT_TABLE table.

Refer to <a href=\"%root%/dict_table(enq).html\">Enquire Table</a> for full details.', '2005-06-29 19:06:48', 'AJM', '2005-07-02 15:40:26', 'AJM'),
('dict_table(generate)a', 'This is the first screen in a two-screen process that will generate the scripts necessary to access the selected database table using a particular transaction pattern.

Refer to <a href=\"%root%/dict_table(generate)a.html\">Generate PHP Scripts (a)</a> for full details.', '2006-10-15 16:00:32', 'AJM', '2006-10-15 16:06:54', 'AJM'),
('dict_table(generate)b', 'This is the second screen in a two-screen process that will generate the scripts necessary to access the selected database table using a particular transaction pattern.

Refer to <a href=\"%root%/dict_table(generate)a.html\">Generate PHP Scripts (b)</a> for full details.', '2006-10-15 16:00:50', 'AJM', '2006-10-15 16:06:59', 'AJM'),
('dict_table(list)', 'This will list records on the DICT_TABLE table.

Refer to <a href=\"%root%/dict_table(list).html\">List Database Tables</a> for full details.', '2005-06-29 19:39:46', 'AJM', '2005-07-02 15:40:31', 'AJM'),
('dict_table(list)2', 'This will list records on the DICT_TABLE table for a selected DATABASE.

Refer to <a href=\"%root%/dict_table(list)2.html\">List Table by Database</a> for full details.', '2005-06-29 19:32:01', 'AJM', '2005-07-02 15:40:35', 'AJM'),
('dict_table(popup)', 'This will list records on the DICT_TABLE table and allow one or more to be selected. 

After selecting records please press the CHOOSE button. 

Refer to <a href=\"%root%/dict_table(popup).html\">Choose Database Table</a> for full details.', '2005-06-29 19:21:33', 'AJM', '2005-07-02 15:40:39', 'AJM'),
('dict_table(popup)snr', 'This will list records on the DICT_TABLE table and allow one or more to be selected. 

After selecting records please press the CHOOSE button. 

Refer to <a href=\"%root%/dict_table(popup).html\">Choose Database Table</a> for full details.', '2005-06-29 19:21:54', 'AJM', '2005-07-02 15:40:44', 'AJM'),
('dict_table(search)', 'This will allow search criteria to be entered for the DICT_TABLE table. 

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/dict_table(search).html\">Search Table</a> for full details.', '2005-06-29 19:17:04', 'AJM', '2005-07-02 15:40:48', 'AJM'),
('dict_table(upd)', 'This will display the contents of a record from the DICT_TABLE table and allow it to be updated.

Refer to <a href=\"%root%/dict_table(upd).html\">Update Table</a> for full details.', '2005-06-29 19:19:45', 'AJM', '2005-07-02 15:40:52', 'AJM');

-- finished
