-- file created on June 20, 2006, 2:55 pm
    
REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('audit_dtl(list)3exact', 'List Audit Details for an Object (exact match)', 'Audit Trail', 'PROC', 'audit_dtl_list3.php', 'N', 'LIST3', 'AUDIT', NULL, NULL, NULL, 'pattern=exact', NULL, 'N', 'N', NULL, 'N', '2004-07-21 16:54:14', 'AJM', '2006-06-20 14:53:08', 'AJM');

-- finished
