-- file created on June 22, 2006, 3:28 pm
    
REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(import)', 'Import Database Details', 'Import', 'PROC', 'database_import.php', 'N', 'ADD1', 'DICT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2005-03-13 11:33:39', 'AJM', '2006-06-22 10:55:02', 'AJM');

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
('dict_database(list)', 'audit_dtl(list)3exact', '011', 'Audit Trail (exact)', 'Y', '2005-03-12 19:07:33', 'AJM', '2005-12-10 12:33:03', 'AJM');

-- finished
