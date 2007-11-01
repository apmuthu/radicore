-- file created on January 22, 2007, 11:00 am
    
REPLACE INTO `mnu_subsystem` (`subsys_id`, `subsys_desc`, `subsys_dir`, `task_prefix`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('PRODUCT', 'Product Inventory', 'product', 'pro_', '2003-01-01 12:00:00', 'AJM', '2006-07-02 15:06:22', 'AJM');

REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'Demonstration Class', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_container(add)', 'Add Container', 'New', 'PROC', 'container.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 18:17:50', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_container(add)', '2006-07-09 19:34:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_container(del)', 'Delete Container', 'Delete', 'PROC', 'container.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 18:18:18', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_container(del)', '2006-07-09 19:34:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_container(enq)', 'Enquire Container', 'Read', 'PROC', 'container.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 18:18:43', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_container(enq)', '2006-07-09 19:34:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_container(list)', 'List Container', 'Container', 'PROC', 'container.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, 'container_desc', 'Y', 'N', NULL, 'N', '2006-06-30 18:17:15', 'AJM', '2006-07-03 09:53:42', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_container(list)', 'pro_container(add)', '001', 'New', 'N', '2006-06-30 18:19:59', 'AJM', NULL, NULL),
('pro_container(list)', 'pro_container(enq)', '002', 'Read', 'Y', '2006-06-30 18:20:00', 'AJM', '2006-06-30 18:20:14', 'AJM'),
('pro_container(list)', 'pro_container(upd)', '003', 'Update', 'Y', '2006-06-30 18:20:00', 'AJM', '2006-07-02 23:50:41', 'AJM'),
('pro_container(list)', 'pro_container(del)', '004', 'Delete', 'Y', '2006-06-30 18:20:00', 'AJM', '2006-07-02 23:50:41', 'AJM'),
('pro_container(list)', 'pro_container(search)', '005', 'Search', 'N', '2006-06-30 18:20:00', 'AJM', '2006-06-30 18:20:14', 'AJM'),
('pro_container(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2006-06-30 18:20:22', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_container(list)', '2006-07-09 19:34:49', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_container(popup)', 'Choose Container', 'Choose', 'PROC', 'container.popup.php', 'N', 'POPUP1', 'PRODUCT', NULL, NULL, NULL, NULL, 'facility_id, container_desc', 'N', 'N', NULL, 'N', '2006-07-03 12:16:07', 'AJM', '2006-10-06 13:34:54', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_container(popup)', '2006-07-09 19:34:49', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_container(search)', 'Search Container', 'Search', 'PROC', 'container.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 18:19:12', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_container(search)', '2006-07-09 19:34:49', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_container(upd)', 'Update Container', 'Update', 'PROC', 'container.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 18:19:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_container(upd)', '2006-07-09 19:34:49', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_container_type(add)', 'Add Container Type', 'New', 'PROC', 'container_type.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 17:39:51', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_container_type(add)', '2006-07-09 19:34:49', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_container_type(del)', 'Delete Container Type', 'Delete', 'PROC', 'container_type.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 17:40:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_container_type(del)', '2006-07-09 19:34:49', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_container_type(enq)', 'Enquire Container Type', 'Read', 'PROC', 'container_type.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 17:40:52', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_container_type(enq)', '2006-07-09 19:34:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_container_type(list)', 'List Container Type', 'Container Type', 'PROC', 'container_type.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, 'container_type_desc', 'N', 'N', NULL, 'N', '2006-06-30 17:39:08', 'AJM', '2006-06-30 17:42:23', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_container_type(list)', 'pro_container_type(add)', '001', 'New', 'N', '2006-06-30 17:42:43', 'AJM', NULL, NULL),
('pro_container_type(list)', 'pro_container_type(enq)', '002', 'Read', 'Y', '2006-06-30 17:42:43', 'AJM', '2006-06-30 17:43:04', 'AJM'),
('pro_container_type(list)', 'pro_container_type(upd)', '003', 'Update', 'Y', '2006-06-30 17:42:43', 'AJM', '2006-07-02 23:50:16', 'AJM'),
('pro_container_type(list)', 'pro_container_type(del)', '004', 'Delete', 'Y', '2006-06-30 17:42:43', 'AJM', '2006-07-02 23:50:16', 'AJM'),
('pro_container_type(list)', 'pro_container_type(search)', '005', 'Search', 'N', '2006-06-30 17:42:43', 'AJM', '2006-06-30 17:43:04', 'AJM'),
('pro_container_type(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2006-06-30 17:43:12', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_container_type(list)', '2006-07-09 19:34:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_container_type(search)', 'Search Container Type', 'Search', 'PROC', 'container_type.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 17:41:25', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_container_type(search)', '2006-07-09 19:34:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_container_type(upd)', 'Update Container Type', 'Update', 'PROC', 'container_type.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 17:41:53', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_container_type(upd)', '2006-07-09 19:34:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_facility(add)', 'Add Facility', 'New', 'PROC', 'facility.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 17:03:10', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_facility(add)', '2006-07-09 19:34:57', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_facility(del)', 'Delete Facility', 'Delete', 'PROC', 'facility.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 17:03:41', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_facility(del)', '2006-07-09 19:34:57', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_facility(enq)', 'Enquire Facility', 'Read', 'PROC', 'facility.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 17:04:16', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_facility(enq)', '2006-07-09 19:34:57', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_facility(list)', 'List Facility', 'Facility', 'PROC', 'facility.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, 'facility_desc', 'Y', 'N', NULL, 'N', '2006-06-30 17:02:35', 'AJM', '2006-07-03 09:53:58', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_facility(list)', 'pro_facility(add)', '001', 'New', 'N', '2006-06-30 17:05:41', 'AJM', NULL, NULL),
('pro_facility(list)', 'pro_facility(enq)', '002', 'Read', 'Y', '2006-06-30 17:05:41', 'AJM', '2006-06-30 17:06:04', 'AJM'),
('pro_facility(list)', 'pro_facility(upd)', '003', 'Update', 'Y', '2006-06-30 17:05:41', 'AJM', '2006-07-02 23:49:45', 'AJM'),
('pro_facility(list)', 'pro_facility(del)', '004', 'Delete', 'Y', '2006-06-30 17:05:41', 'AJM', '2006-07-02 23:49:45', 'AJM'),
('pro_facility(list)', 'pro_facility(search)', '005', 'Search', 'N', '2006-06-30 17:05:41', 'AJM', '2006-06-30 17:06:04', 'AJM'),
('pro_facility(list)', 'pro_inv_item(list)3', '006', 'Inventory', 'Y', '2006-07-04 16:31:39', 'AJM', '2006-07-04 16:31:48', 'AJM'),
('pro_facility(list)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2006-06-30 17:43:33', 'AJM', '2006-07-04 16:31:48', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_facility(list)', '2006-07-09 19:34:57', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_facility(popup)', 'Choose Facility', 'Choose', 'PROC', 'facility.popup.php', 'N', 'POPUP1', 'PRODUCT', NULL, NULL, NULL, NULL, 'facility_desc', 'N', 'N', NULL, 'N', '2006-07-03 13:34:31', 'AJM', '2006-10-06 13:35:15', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_facility(popup)', '2006-07-09 19:34:57', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_facility(search)', 'Search Facility', 'Search', 'PROC', 'facility.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 17:04:51', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_facility(search)', '2006-07-09 19:34:57', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_facility(upd)', 'Update Facility', 'Update', 'PROC', 'facility.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 17:05:19', 'AJM', '2006-06-30 17:06:25', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_facility(upd)', '2006-07-09 19:35:03', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_facility_type(add)', 'Add Facility Type', 'New', 'PROC', 'facility_type.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 16:08:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_facility_type(add)', '2006-07-09 19:35:03', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_facility_type(del)', 'Delete Facility Type', 'Delete', 'PROC', 'facility_type.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 16:08:35', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_facility_type(del)', '2006-07-09 19:35:03', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_facility_type(enq)', 'Enquire Facility Type', 'Read', 'PROC', 'facility_type.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 16:09:07', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_facility_type(enq)', '2006-07-09 19:35:03', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_facility_type(list)', 'List Facility Type', 'Facility Type', 'PROC', 'facility_type.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, 'facility_type_desc', 'N', 'N', NULL, 'N', '2006-06-30 16:07:18', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_facility_type(list)', 'pro_facility_type(add)', '001', 'New', 'N', '2006-06-30 16:10:29', 'AJM', NULL, NULL),
('pro_facility_type(list)', 'pro_facility_type(enq)', '002', 'Read', 'Y', '2006-06-30 16:10:30', 'AJM', '2006-06-30 16:10:47', 'AJM'),
('pro_facility_type(list)', 'pro_facility_type(upd)', '003', 'Update', 'Y', '2006-06-30 16:10:30', 'AJM', '2006-06-30 16:43:08', 'AJM'),
('pro_facility_type(list)', 'pro_facility_type(del)', '004', 'Delete', 'Y', '2006-06-30 16:10:29', 'AJM', '2006-06-30 16:43:08', 'AJM'),
('pro_facility_type(list)', 'pro_facility_type(search)', '005', 'Search', 'N', '2006-06-30 16:10:30', 'AJM', '2006-06-30 16:10:47', 'AJM'),
('pro_facility_type(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2006-06-30 16:10:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_facility_type(list)', '2006-07-09 19:35:03', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_facility_type(search)', 'Search Facility Type', 'Search', 'PROC', 'facility_type.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 16:09:40', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_facility_type(search)', '2006-07-09 19:35:03', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_facility_type(upd)', 'Update Facility Type', 'Update', 'PROC', 'facility_type.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-30 16:10:09', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_facility_type(upd)', '2006-07-09 19:35:03', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id(add)', 'Insert Good Identification', 'New', 'PROC', 'good_identification.add.php', 'N', 'ADD2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_good_id(add)', '2006-07-09 19:35:03', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id(del)', 'Delete Good Identification', 'Delete', 'PROC', 'good_identification.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_good_id(del)', '2006-07-09 19:35:03', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id(enq)', 'Enquire Good Identification', 'Read', 'PROC', 'good_identification.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_good_id(enq)', '2005-04-19 18:46:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id(list)', 'List Good Identification', 'Good Identification', 'PROC', 'good_identification.list.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, NULL, NULL, 'identity_type_id', 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:26:10', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id(list)', 'pro_good_id(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_good_id(list)', 'pro_good_id(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_good_id(list)', 'pro_good_id(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_good_id(list)', 'pro_good_id(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_good_id(list)', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2004-04-09 12:00:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_good_id(list)', '2005-04-19 18:46:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id(upd)', 'Update Good Identification', 'Update', 'PROC', 'good_identification.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:17', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_good_id(upd)', '2006-07-09 19:35:11', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id_type(add)', 'Insert Good Identity Type', 'New', 'PROC', 'good_identity_type.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_good_id_type(add)', '2006-07-09 19:35:11', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id_type(del)', 'Delete Good Identity Type', 'Delete', 'PROC', 'good_identity_type.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_good_id_type(del)', '2006-07-09 19:35:11', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id_type(enq)', 'Enquire Good Identity Type', 'Read', 'PROC', 'good_identity_type.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_good_id_type(enq)', '2005-04-19 18:46:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id_type(list)', 'List Good Identity Type', 'Good ID Type', 'PROC', 'good_identity_type.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, 'identity_type_id', 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2006-07-03 09:54:15', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id_type(list)', 'pro_good_id_type(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_good_id_type(list)', 'pro_good_id_type(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_good_id_type(list)', 'pro_good_id_type(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_good_id_type(list)', 'pro_good_id_type(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_good_id_type(list)', 'pro_good_id_type(search)', '005', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_good_id_type(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-09 11:40:37', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_good_id_type(list)', '2005-04-19 18:46:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id_type(popup)', 'Choose Good Identity Type', 'Choose', 'PROC', 'good_identity_type.popup.php', 'N', 'POPUP1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2006-10-06 13:35:38', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_good_id_type(popup)', '2005-04-19 18:46:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id_type(search)', 'Search Good Identity Type', 'Search', 'PROC', 'good_identity_type.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_good_id_type(search)', '2005-04-19 18:46:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id_type(upd)', 'Update Good Identity Type', 'Update', 'PROC', 'good_identity_type.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:22', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_good_id_type(upd)', '2006-07-09 19:35:11', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item(add)', 'Add Inventory Item', 'New', 'PROC', 'inventory_item.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-03 10:22:43', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item(add)', '2006-07-09 19:35:11', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item(del)', 'Delete Inventory Item', 'Delete', 'PROC', 'inventory_item.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-03 10:23:13', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item(del)', '2006-07-09 19:35:18', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item(enq)', 'Enquire Inventory Item', 'Read', 'PROC', 'inventory_item.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-03 10:23:43', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item(enq)', '2006-07-09 19:35:18', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item(list)', 'List Inventory Item', 'Inventory', 'PROC', 'inventory_item.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, 'product_id, inventory_item_id', 'Y', 'N', NULL, 'N', '2006-07-03 10:21:57', 'AJM', '2006-07-09 19:40:05', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item(list)', 'pro_inv_item(add)', '001', 'New', 'N', '2006-07-03 10:25:00', 'AJM', NULL, NULL),
('pro_inv_item(list)', 'pro_inv_item(enq)', '002', 'Read', 'Y', '2006-07-03 10:25:00', 'AJM', '2006-07-03 10:26:05', 'AJM'),
('pro_inv_item(list)', 'pro_inv_item(upd)', '003', 'Update', 'Y', '2006-07-03 10:25:22', 'AJM', '2006-07-04 18:00:32', 'AJM'),
('pro_inv_item(list)', 'pro_inv_item(del)', '004', 'Delete', 'Y', '2006-07-03 10:25:00', 'AJM', '2006-07-04 18:00:31', 'AJM'),
('pro_inv_item(list)', 'pro_inv_item(search)', '005', 'Search', 'N', '2006-07-03 10:25:21', 'AJM', '2006-07-03 10:26:05', 'AJM'),
('pro_inv_item(list)', 'pro_inv_item_status_hist(list)2', '006', 'Status History', 'Y', '2006-07-04 18:36:31', 'AJM', '2006-07-04 18:36:41', 'AJM'),
('pro_inv_item(list)', 'pro_inv_item_variance(list)2', '007', 'Variance', 'Y', '2006-07-06 17:56:46', 'AJM', '2006-07-06 17:56:57', 'AJM'),
('pro_inv_item(list)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2006-07-03 10:25:29', 'AJM', '2006-07-06 17:56:57', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item(list)', '2006-07-09 19:35:18', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item(list)2', 'List Inventory Item by Product', 'Inventory', 'PROC', 'inventory_item.list2.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, NULL, NULL, 'product_id, inventory_item_id', 'N', 'N', NULL, 'N', '2006-07-03 16:51:31', 'AJM', '2006-07-09 19:40:11', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item(list)2', 'pro_inv_item(add)', '001', 'New', 'N', '2006-07-03 17:07:56', 'AJM', NULL, NULL),
('pro_inv_item(list)2', 'pro_inv_item(enq)', '002', 'Read', 'Y', '2006-07-03 17:08:42', 'AJM', '2006-07-03 17:09:06', 'AJM'),
('pro_inv_item(list)2', 'pro_inv_item(upd)', '003', 'Update', 'Y', '2006-07-03 17:08:42', 'AJM', '2006-07-04 18:01:10', 'AJM'),
('pro_inv_item(list)2', 'pro_inv_item(del)', '004', 'Delete', 'Y', '2006-07-03 17:07:56', 'AJM', '2006-07-04 18:01:10', 'AJM'),
('pro_inv_item(list)2', 'pro_inv_item(search)', '005', 'Search', 'N', '2006-07-03 17:08:42', 'AJM', '2006-07-03 17:09:06', 'AJM'),
('pro_inv_item(list)2', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2006-07-03 17:08:50', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item(list)2', '2006-07-09 19:35:18', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item(list)3', 'List Inventory Item by Facility', 'Inventory', 'PROC', 'inventory_item.list3.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, NULL, NULL, 'product_id, inventory_item_id', 'N', 'N', NULL, 'N', '2006-07-04 16:31:02', 'AJM', '2006-07-09 19:40:17', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item(list)3', 'pro_inv_item(add)', '001', 'New', 'N', '2006-07-04 16:47:02', 'AJM', NULL, NULL),
('pro_inv_item(list)3', 'pro_inv_item(enq)', '002', 'Read', 'Y', '2006-07-04 16:47:17', 'AJM', '2006-07-04 16:47:44', 'AJM'),
('pro_inv_item(list)3', 'pro_inv_item(upd)', '003', 'Update', 'Y', '2006-07-04 16:47:17', 'AJM', '2006-07-04 18:00:05', 'AJM'),
('pro_inv_item(list)3', 'pro_inv_item(del)', '004', 'Delete', 'Y', '2006-07-04 16:47:02', 'AJM', '2006-07-04 18:00:05', 'AJM'),
('pro_inv_item(list)3', 'pro_inv_item(search)', '005', 'Search', 'N', '2006-07-04 16:47:17', 'AJM', '2006-07-04 16:47:44', 'AJM'),
('pro_inv_item(list)3', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2006-07-04 16:47:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item(list)3', '2006-07-09 19:35:18', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item(search)', 'Search Inventory Item', 'Search', 'PROC', 'inventory_item.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-03 10:24:10', 'AJM', '2006-07-03 10:27:15', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item(search)', '2006-07-09 19:35:18', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item(upd)', 'Update Inventory Item', 'Update', 'PROC', 'inventory_item.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-03 10:24:33', 'AJM', '2006-07-03 10:27:23', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item(upd)', '2006-07-09 19:35:18', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_status(add)', 'Add Inventory Item Status', 'New', 'PROC', 'inventory_item_status.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-02 14:47:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item_status(add)', '2006-07-09 19:35:18', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_status(del)', 'Delete Inventory Item Status', 'Delete', 'PROC', 'inventory_item_status.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-02 14:47:47', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item_status(del)', '2006-07-09 19:35:18', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_status(enq)', 'Enquire Inventory Item Status', 'Read', 'PROC', 'inventory_item_status.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-02 14:48:16', 'AJM', '2006-07-02 23:51:51', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item_status(enq)', '2006-07-09 19:35:18', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_status(list)', 'List Inventory Item Status', 'Item Status', 'PROC', 'inventory_item_status.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, 'inv_item_status_desc', 'N', 'N', NULL, 'N', '2006-07-02 14:46:41', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_status(list)', 'pro_inv_item_status(add)', '001', 'New', 'N', '2006-07-02 14:49:40', 'AJM', NULL, NULL),
('pro_inv_item_status(list)', 'pro_inv_item_status(enq)', '002', 'Read', 'Y', '2006-07-02 14:49:40', 'AJM', '2006-07-02 23:52:23', 'AJM'),
('pro_inv_item_status(list)', 'pro_inv_item_status(upd)', '003', 'Update', 'Y', '2006-07-02 14:49:59', 'AJM', '2006-07-02 23:52:06', 'AJM'),
('pro_inv_item_status(list)', 'pro_inv_item_status(del)', '004', 'Delete', 'Y', '2006-07-02 14:49:40', 'AJM', '2006-07-02 23:52:06', 'AJM'),
('pro_inv_item_status(list)', 'pro_inv_item_status(search)', '005', 'Search', 'N', '2006-07-02 14:49:59', 'AJM', '2006-07-02 14:50:21', 'AJM'),
('pro_inv_item_status(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2006-07-02 14:50:06', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item_status(list)', '2006-07-09 19:35:25', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_status(search)', 'Search Inventory Item Status', 'Search', 'PROC', 'inventory_item_status.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-02 14:48:44', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item_status(search)', '2006-07-09 19:35:25', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_status(upd)', 'Update Inventory Item Status', 'Update', 'PROC', 'inventory_item_status.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-02 14:49:11', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item_status(upd)', '2006-07-09 19:35:25', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_status_hist(add)', 'Add Inventory Item Status History', 'New', 'PROC', 'inventory_item_status_hist.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-04 18:32:22', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item_status_hist(add)', '2006-07-09 19:35:25', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_status_hist(del)', 'Delete Inventory Item Status History', 'Delete', 'PROC', 'inventory_item_status_hist.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-04 18:32:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item_status_hist(del)', '2006-07-09 19:35:25', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_status_hist(enq)', 'Enquire Inventory Item Status History', 'Read', 'PROC', 'inventory_item_status_hist.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-04 18:33:22', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item_status_hist(enq)', '2006-07-09 19:35:25', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_status_hist(list)2', 'List Inventory Item Status History', 'Status History', 'PROC', 'inventory_item_status_hist.list2.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, NULL, NULL, 'status_date desc', 'N', 'N', NULL, 'N', '2006-07-04 18:31:47', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_status_hist(list)2', 'pro_inv_item_status_hist(add)', '001', 'New', 'N', '2006-07-04 18:34:54', 'AJM', NULL, NULL),
('pro_inv_item_status_hist(list)2', 'pro_inv_item_status_hist(enq)', '002', 'Read', 'Y', '2006-07-04 18:34:54', 'AJM', '2006-07-04 18:35:33', 'AJM'),
('pro_inv_item_status_hist(list)2', 'pro_inv_item_status_hist(upd)', '003', 'Update', 'Y', '2006-07-04 18:34:54', 'AJM', '2006-07-04 18:35:33', 'AJM'),
('pro_inv_item_status_hist(list)2', 'pro_inv_item_status_hist(del)', '004', 'Delete', 'Y', '2006-07-04 18:34:54', 'AJM', '2006-07-04 18:35:33', 'AJM'),
('pro_inv_item_status_hist(list)2', 'pro_inv_item_status_hist(search)', '005', 'Search', 'N', '2006-07-04 18:34:54', 'AJM', '2006-07-04 18:35:33', 'AJM'),
('pro_inv_item_status_hist(list)2', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2006-07-04 18:35:06', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item_status_hist(list)2', '2006-07-09 19:35:25', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_status_hist(search)', 'Search Inventory Item Status History', 'Search', 'PROC', 'inventory_item_status_hist.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-04 18:33:49', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item_status_hist(search)', '2006-07-09 19:35:25', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_status_hist(upd)', 'Update Inventory Item Status History', 'Update', 'PROC', 'inventory_item_status_hist.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-04 18:34:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item_status_hist(upd)', '2006-07-09 19:35:25', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_variance(add)', 'Add Inventory Item Variance', 'New', 'PROC', 'inventory_item_variance.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-06 17:52:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item_variance(add)', '2006-07-09 19:35:25', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_variance(del)', 'Delete Inventory Item Variance', 'Delete', 'PROC', 'inventory_item_variance.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-06 17:53:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item_variance(del)', '2006-07-09 19:35:32', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_variance(enq)', 'Enquire Inventory Item Variance', 'Read', 'PROC', 'inventory_item_variance.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-06 17:53:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item_variance(enq)', '2006-07-09 19:35:32', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_variance(list)2', 'List Inventory Item Variance', 'Variance', 'PROC', 'inventory_item_variance.list2.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, NULL, NULL, 'inventory_date desc', 'N', 'N', NULL, 'N', '2006-07-06 17:51:39', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_variance(list)2', 'pro_inv_item_variance(add)', '001', 'New', 'N', '2006-07-06 17:55:05', 'AJM', NULL, NULL),
('pro_inv_item_variance(list)2', 'pro_inv_item_variance(enq)', '002', 'Read', 'Y', '2006-07-06 17:55:18', 'AJM', '2006-07-06 17:55:48', 'AJM'),
('pro_inv_item_variance(list)2', 'pro_inv_item_variance(upd)', '003', 'Update', 'Y', '2006-07-06 17:55:18', 'AJM', '2006-07-06 17:55:48', 'AJM'),
('pro_inv_item_variance(list)2', 'pro_inv_item_variance(del)', '004', 'Delete', 'Y', '2006-07-06 17:55:05', 'AJM', '2006-07-06 17:55:48', 'AJM'),
('pro_inv_item_variance(list)2', 'pro_inv_item_variance(search)', '005', 'Search', 'N', '2006-07-06 17:55:18', 'AJM', '2006-07-06 17:55:48', 'AJM'),
('pro_inv_item_variance(list)2', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2006-07-06 17:55:29', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item_variance(list)2', '2006-07-09 19:35:32', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_variance(search)', 'Search Inventory Item Variance', 'Search', 'PROC', 'inventory_item_variance.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-06 17:53:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item_variance(search)', '2006-07-09 19:35:32', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_item_variance(upd)', 'Update Inventory Item Variance', 'Update', 'PROC', 'inventory_item_variance.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-06 17:54:27', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_item_variance(upd)', '2006-07-09 19:35:32', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_var_reason(add)', 'Add Inventory Variance Reason', 'New', 'PROC', 'inventory_variance_reason.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-02 13:39:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_var_reason(add)', '2006-07-09 19:35:32', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_var_reason(del)', 'Delete Inventory Variance Reason', 'Delete', 'PROC', 'inventory_variance_reason.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-02 13:40:24', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_var_reason(del)', '2006-07-09 19:35:32', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_var_reason(enq)', 'Enquire Inventory Variance Reason', 'Read', 'PROC', 'inventory_variance_reason.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-02 13:40:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_var_reason(enq)', '2006-07-09 19:35:32', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_var_reason(list)', 'List Inventory Variance Reason', 'Reason', 'PROC', 'inventory_variance_reason.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, 'inv_var_reason_desc', 'N', 'N', NULL, 'N', '2006-07-02 13:38:37', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_var_reason(list)', 'pro_inv_var_reason(add)', '001', 'New', 'N', '2006-07-02 13:43:00', 'AJM', NULL, NULL),
('pro_inv_var_reason(list)', 'pro_inv_var_reason(enq)', '002', 'Read', 'Y', '2006-07-02 13:43:00', 'AJM', '2006-07-02 13:43:45', 'AJM'),
('pro_inv_var_reason(list)', 'pro_inv_var_reason(upd)', '003', 'Update', 'Y', '2006-07-02 13:43:20', 'AJM', '2006-07-02 23:51:20', 'AJM'),
('pro_inv_var_reason(list)', 'pro_inv_var_reason(del)', '004', 'Delete', 'Y', '2006-07-02 13:43:00', 'AJM', '2006-07-02 23:51:20', 'AJM'),
('pro_inv_var_reason(list)', 'pro_inv_var_reason(search)', '005', 'Search', 'N', '2006-07-02 13:43:20', 'AJM', '2006-07-02 13:43:45', 'AJM'),
('pro_inv_var_reason(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2006-07-02 13:43:27', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_var_reason(list)', '2006-07-09 19:35:32', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_var_reason(search)', 'Search Inventory Variance Reason', 'Search', 'PROC', 'inventory_variance_reason.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-02 13:41:31', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_var_reason(search)', '2006-07-09 19:35:32', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_inv_var_reason(upd)', 'Update Inventory Variance Reason', 'Update', 'PROC', 'inventory_variance_reason.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-02 13:42:04', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_inv_var_reason(upd)', '2006-07-09 19:35:41', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_lot(add)', 'Add Lot', 'New', 'PROC', 'lot.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-02 15:35:57', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_lot(add)', '2006-07-09 19:35:41', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_lot(del)', 'Delete Lot', 'Delete', 'PROC', 'lot.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-02 15:36:26', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_lot(del)', '2006-07-09 19:35:41', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_lot(enq)', 'Enquire Lot', 'Read', 'PROC', 'lot.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-02 15:36:52', 'AJM', '2006-07-02 23:47:36', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_lot(enq)', '2006-07-09 19:35:41', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_lot(list)', 'List Lot', 'Lot', 'PROC', 'lot.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, 'lot_id', 'Y', 'N', NULL, 'N', '2006-07-02 15:34:40', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_lot(list)', 'pro_lot(add)', '001', 'New', 'N', '2006-07-02 15:38:40', 'AJM', NULL, NULL),
('pro_lot(list)', 'pro_lot(enq)', '002', 'Read', 'Y', '2006-07-02 15:39:13', 'AJM', '2006-07-02 23:47:14', 'AJM'),
('pro_lot(list)', 'pro_lot(upd)', '003', 'Update', 'Y', '2006-07-02 15:39:13', 'AJM', '2006-07-02 23:47:14', 'AJM'),
('pro_lot(list)', 'pro_lot(del)', '004', 'Delete', 'Y', '2006-07-02 15:38:40', 'AJM', '2006-07-02 23:47:14', 'AJM'),
('pro_lot(list)', 'pro_lot(search)', '005', 'Search', 'N', '2006-07-02 15:39:13', 'AJM', '2006-07-02 15:39:37', 'AJM'),
('pro_lot(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2006-07-02 15:39:22', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_lot(list)', '2006-07-09 19:35:41', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_lot(popup)', 'Choose Lot', 'Choose', 'PROC', 'lot.popup.php', 'N', 'POPUP1', 'PRODUCT', NULL, NULL, NULL, NULL, 'lot_id', 'N', 'N', NULL, 'N', '2006-07-03 14:31:41', 'AJM', '2006-10-06 13:36:04', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_lot(popup)', '2006-07-09 19:35:41', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_lot(search)', 'Search Lot', 'Search', 'PROC', 'lot.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-02 15:37:23', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_lot(search)', '2006-07-09 19:35:41', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_lot(upd)', 'Update Lot', 'Update', 'PROC', 'lot.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-07-02 15:38:04', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_lot(upd)', '2006-07-09 19:35:41', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_a(add)', 'Insert Price by Product', 'New', 'PROC', 'price_component.product.add.php', 'N', 'ADD2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_a(add)', '2006-07-09 19:35:41', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_a(del)', 'Delete Price by Product', 'Delete', 'PROC', 'price_component.product.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_a(del)', '2006-07-09 19:35:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_a(enq)', 'Enquire Price by Product', 'Read', 'PROC', 'price_component.product.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_a(enq)', '2005-04-19 18:46:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_a(list)', 'List Price by Product', 'Price Components', 'PROC', 'price_component.product.list.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, 'curr_or_hist=\'C\'', NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:26:43', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_a(list)', 'pro_price_component_a(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_price_component_a(list)', 'pro_price_component_a(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_price_component_a(list)', 'pro_price_component_a(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_price_component_a(list)', 'pro_price_component_a(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_price_component_a(list)', 'pro_price_component_a(search)', '005', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_price_component_a(list)', 'date(current)', '006', 'Current', 'N', '2004-04-17 17:20:19', 'AJM', '2004-04-17 17:20:41', 'AJM'),
('pro_price_component_a(list)', 'date(historic)', '007', 'Historic', 'N', '2004-04-17 17:20:19', 'AJM', '2004-04-17 17:20:41', 'AJM'),
('pro_price_component_a(list)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2004-04-09 12:00:35', 'AJM', '2004-04-17 17:20:41', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_a(list)', '2005-04-19 18:46:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_a(search)', 'Search Price by Product', 'Search', 'PROC', 'price_component.product.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_a(search)', '2005-04-19 18:46:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_a(upd)', 'Update Price by Product', 'Update', 'PROC', 'price_component.product.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:26', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_a(upd)', '2006-07-09 19:35:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_b(add)', 'Insert Price by Product Feature', 'New', 'PROC', 'price_component.prod_feature.add.php', 'N', 'ADD2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_b(add)', '2006-07-09 19:35:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_b(del)', 'Delete Price by Product Feature', 'Delete', 'PROC', 'price_component.prod_feature.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_b(del)', '2006-07-09 19:35:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_b(enq)', 'Enquire Price by Product Feature', 'Read', 'PROC', 'price_component.prod_feature.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_b(enq)', '2005-04-19 18:46:33', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_b(list)', 'List Price by Product Feature', 'Price Component', 'PROC', 'price_component.prod_feature.list.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, 'curr_or_hist=\'C\'', NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:27:00', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_b(list)', 'pro_price_component_b(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_price_component_b(list)', 'pro_price_component_b(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_price_component_b(list)', 'pro_price_component_b(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_price_component_b(list)', 'pro_price_component_b(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_price_component_b(list)', 'pro_price_component_b(search)', '005', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_price_component_b(list)', 'date(current)', '006', 'Current', 'N', '2004-04-17 17:20:58', 'AJM', '2004-04-17 17:21:11', 'AJM'),
('pro_price_component_b(list)', 'date(historic)', '007', 'Historic', 'N', '2004-04-17 17:20:58', 'AJM', '2004-04-17 17:21:11', 'AJM'),
('pro_price_component_b(list)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2004-04-09 12:00:44', 'AJM', '2004-04-17 17:21:11', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_b(list)', '2005-04-19 18:46:33', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_b(search)', 'Search Price by Product Feature', 'Search', 'PROC', 'price_component.prod_feature.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_b(search)', '2005-04-19 18:46:33', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_b(upd)', 'Update Price by Product Feature', 'Update', 'PROC', 'price_component.prod_feature.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:30', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_b(upd)', '2006-07-09 19:35:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_c(add)', 'Insert Price by Product Category', 'New', 'PROC', 'price_component.prod_cat.add.php', 'N', 'ADD2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_c(add)', '2006-07-09 19:35:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_c(del)', 'Delete Price by Product Category', 'Delete', 'PROC', 'price_component.prod_cat.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_c(del)', '2006-07-09 19:35:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_c(enq)', 'Enquire Price by Product Category', 'Read', 'PROC', 'price_component.prod_cat.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_c(enq)', '2005-04-19 18:46:33', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_c(list)', 'List Price by Product Category', 'Price Component', 'PROC', 'price_component.prod_cat.list.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, 'curr_or_hist=\'C\'', NULL, NULL, 'Y', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:21:17', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_c(list)', 'pro_price_component_c(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2005-04-24 18:51:44', 'AJM'),
('pro_price_component_c(list)', 'pro_price_component_c(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_price_component_c(list)', 'pro_price_component_c(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_price_component_c(list)', 'pro_price_component_c(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_price_component_c(list)', 'pro_price_component_c(search)', '005', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_price_component_c(list)', 'date(current)', '006', 'Current', 'N', '2004-04-17 17:21:26', 'AJM', '2004-04-17 17:21:39', 'AJM'),
('pro_price_component_c(list)', 'date(historic)', '007', 'Historic', 'N', '2004-04-17 17:21:26', 'AJM', '2004-04-17 17:21:39', 'AJM'),
('pro_price_component_c(list)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2004-04-09 11:53:57', 'AJM', '2004-04-17 17:21:39', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_c(list)', '2005-04-19 18:46:33', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_c(search)', 'Search Price by Product Category', 'Search', 'PROC', 'price_component.prod_cat.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_c(search)', '2005-04-19 18:46:33', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_c(upd)', 'Update Price by Product Category', 'Update', 'PROC', 'price_component.prod_cat.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:34', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_c(upd)', '2006-07-09 19:35:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_product(add)', 'Insert Product', 'New', 'PROC', 'product.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_product(add)', '2006-07-09 19:35:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_product(del)', 'Delete Product', 'Delete', 'PROC', 'product.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_product(del)', '2006-07-09 19:35:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_product(enq)', 'Enquire Product', 'Read', 'PROC', 'product.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_product(enq)', '2005-04-19 18:46:44', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_product(list)', 'List Product', 'List Product', 'PROC', 'product.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'Y', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2006-07-03 09:55:13', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_product(list)', 'pro_product(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_product(list)', 'pro_product(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_product(list)', 'pro_product(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_product(list)', 'pro_product(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_product(list)', 'pro_prod_cat_class(list)', '005', 'Category Class', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_product(list)', 'pro_good_id(list)', '006', 'Good Identification', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_product(list)', 'pro_prod_feat_applic(list)', '007', 'Feature Applicability', 'Y', '2003-01-01 12:00:00', 'AJM', '2006-07-03 09:52:24', 'AJM'),
('pro_product(list)', 'pro_prod_feat_interact(list)', '008', 'Feature Interaction', 'Y', '2003-01-01 12:00:00', 'AJM', '2006-07-03 09:52:24', 'AJM'),
('pro_product(list)', 'pro_price_component_a(list)', '009', 'Price Components', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_product(list)', 'pro_product(search)', '010', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_product(list)', 'pro_inv_item(list)2', '011', 'Inventory', 'Y', '2006-07-03 16:52:34', 'AJM', '2006-07-03 16:52:43', 'AJM'),
('pro_product(list)', 'audit_dtl(list)3', '012', 'Audit Trail', 'Y', '2004-04-09 11:54:41', 'AJM', '2006-07-03 16:52:43', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_product(list)', '2005-04-19 18:46:44', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_product(popup)', 'Choose Product', 'Choose', 'PROC', 'product.popup.php', 'N', 'POPUP1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2006-10-06 13:36:38', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_product(popup)', '2005-04-19 18:46:44', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_product(search)', 'Search Product', 'Search', 'PROC', 'product.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_product(search)', '2005-04-19 18:46:44', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_product(upd)', 'Update Product', 'Update', 'PROC', 'product.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:38', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_product(upd)', '2006-07-09 19:36:01', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat(add)', 'Insert Product Category', 'New', 'PROC', 'product_category.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat(add)', '2006-07-09 19:36:02', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat(del)', 'Delete Product Category', 'Delete', 'PROC', 'product_category.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat(del)', '2006-07-09 19:36:02', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat(enq)', 'Enquire Product Category', 'Read', 'PROC', 'product_category.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat(enq)', '2005-04-19 18:46:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat(list)', 'List Product Category', 'Category', 'PROC', 'product_category.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, 'prod_cat_id', 'Y', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2006-07-03 09:55:03', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat(list)', 'pro_prod_cat(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat(list)', 'pro_prod_cat(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat(list)', 'pro_prod_cat(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat(list)', 'pro_prod_cat(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat(list)', 'pro_prod_cat_rollup(list)', '005', 'Category Rollup', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat(list)', 'pro_price_component_c(list)', '006', 'Price Component', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-05-18 15:22:35', 'AJM'),
('pro_prod_cat(list)', 'pro_prod_cat(search)', '007', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat(list)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2004-04-09 11:54:53', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat(list)', '2005-04-19 18:46:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat(popup)', 'Choose Product Category', 'Choose', 'PROC', 'product_category.popup.php', 'N', 'POPUP1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2006-10-06 13:37:46', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat(popup)', 'pro_prod_cat(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat(popup)', '2005-04-19 18:46:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat(search)', 'Search Product Category', 'Search', 'PROC', 'product_category.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat(search)', '2005-04-19 18:46:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat(upd)', 'Update Product Category', 'Update', 'PROC', 'product_category.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:43', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat(upd)', '2006-07-09 19:36:02', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_class(add)', 'Insert Product Category Class', 'New', 'PROC', 'prod_cat_class.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat_class(add)', '2006-07-09 19:36:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_class(del)', 'Delete Product Category Class', 'Delete', 'PROC', 'prod_cat_class.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat_class(del)', '2006-07-09 19:36:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_class(enq)', 'Enquire Product Category Class', 'Read', 'PROC', 'prod_cat_class.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat_class(enq)', '2005-04-19 18:46:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_class(list)', 'List Product Category Class', 'Category Class', 'PROC', 'prod_cat_class.list.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, 'curr_or_hist=\'C\'', NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:27:12', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_class(list)', 'pro_prod_cat_class(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat_class(list)', 'pro_prod_cat_class(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat_class(list)', 'pro_prod_cat_class(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat_class(list)', 'pro_prod_cat_class(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat_class(list)', 'pro_prod_cat_class(search)', '006', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat_class(list)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2004-04-09 12:00:51', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat_class(list)', '2005-04-19 18:46:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_class(search)', 'Search Product Category Class', 'Search', 'PROC', 'prod_cat_class.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat_class(search)', '2005-04-19 18:46:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_class(upd)', 'Update Product Category Class', 'Update', 'PROC', 'prod_cat_class.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:47', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat_class(upd)', '2006-07-09 19:36:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_rollup(add)', 'Insert Product Category Rollup', 'New', 'PROC', 'prod_cat_rollup.add.php', 'N', 'ADD3', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat_rollup(add)', '2006-07-09 19:36:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_rollup(del)', 'Delete Product Category Rollup', 'Delete', 'PROC', 'prod_cat_rollup.del.php', 'N', 'DEL2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat_rollup(del)', '2006-07-09 19:36:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_rollup(list)', 'Product Category Rollup List', 'Rollup', 'PROC', 'prod_cat_rollup.list.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, NULL, NULL, 'prod_cat_id_jnr', 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:35:23', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_rollup(list)', 'pro_prod_cat_rollup(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat_rollup(list)', 'pro_prod_cat_rollup(del)', '002', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat_rollup(list)', 'audit_dtl(list)3', '003', 'Audit Trail', 'Y', '2004-04-09 12:00:58', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat_rollup(list)', '2005-04-19 18:47:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(add)', 'Insert Product Feature', 'New', 'PROC', 'product_feature.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feature(add)', '2006-07-09 19:36:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(del)', 'Delete Product Feature', 'Delete', 'PROC', 'product_feature.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feature(del)', '2006-07-09 19:36:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(enq)', 'Enquire Product Feature', 'Read', 'PROC', 'product_feature.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feature(enq)', '2005-04-19 18:47:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(list)', 'List Product Feature', 'Feature', 'PROC', 'product_feature.list.php', 'N', 'LIST1', 'PRODUCT', 'pro_prod_feature(search)', NULL, NULL, NULL, 'prod_feature_cat_id,prod_feature_desc', 'Y', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2006-07-03 09:55:32', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(list)', 'pro_prod_feature(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feature(list)', 'pro_prod_feature(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feature(list)', 'pro_prod_feature(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feature(list)', 'pro_prod_feature(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feature(list)', 'pro_price_component_b(list)', '005', 'Price Component', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feature(list)', 'pro_prod_feature(search)', '006', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feature(list)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2004-04-09 11:55:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feature(list)', '2005-04-19 18:47:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(list2)', 'List Product Feature by Category', 'Feature', 'PROC', 'product_feature.list2.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-27 16:31:37', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(list2)', 'pro_prod_feature(add)', '001', 'New', 'N', '2006-06-27 16:35:16', 'AJM', NULL, NULL),
('pro_prod_feature(list2)', 'pro_prod_feature(enq)', '002', 'Read', 'Y', '2006-06-27 16:35:16', 'AJM', '2006-06-27 16:37:47', 'AJM'),
('pro_prod_feature(list2)', 'pro_prod_feature(del)', '003', 'Delete', 'Y', '2006-06-27 16:35:16', 'AJM', '2006-06-27 16:37:47', 'AJM'),
('pro_prod_feature(list2)', 'pro_prod_feature(upd)', '004', 'Update', 'Y', '2006-06-27 16:35:49', 'AJM', '2006-06-27 16:49:36', 'AJM'),
('pro_prod_feature(list2)', 'pro_prod_feature(search)', '005', 'Search', 'N', '2006-06-27 16:35:49', 'AJM', '2006-06-27 16:49:36', 'AJM'),
('pro_prod_feature(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2006-06-27 17:16:57', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feature(list2)', '2006-07-09 19:36:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(popup)', 'Choose Product Feature', 'Choose', 'PROC', 'product_feature.popup.php', 'N', 'POPUP1', 'PRODUCT', 'pro_prod_feature(search)', NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2006-10-06 13:37:12', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feature(popup)', '2005-04-19 18:47:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(popup)jnr', 'Choose Product Feature', 'Choose', 'PROC', 'product_feature.popup.php', 'N', 'POPUP1', 'PRODUCT', 'pro_prod_feature(search)', NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2006-10-06 13:38:42', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feature(popup)jnr', '2005-04-19 18:47:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(popup)snr', 'Choose Product Feature', 'Choose', 'PROC', 'product_feature.popup.php', 'N', 'POPUP1', 'PRODUCT', 'pro_prod_feature(search)', NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2006-10-06 13:39:03', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feature(popup)snr', '2005-04-19 18:47:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(search)', 'Search Product Feature', 'Search', 'PROC', 'product_feature.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feature(search)', '2005-04-19 18:47:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(upd)', 'Update Product Feature', 'Update', 'PROC', 'product_feature.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:51', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feature(upd)', '2006-07-09 19:36:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_applic(add)', 'Insert Product Feature Applicability', 'New', 'PROC', 'prod_feature_applicability.add.php', 'N', 'ADD2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_applic(add)', '2006-07-09 19:36:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_applic(del)', 'Delete Product Feature Applicability', 'Delete', 'PROC', 'prod_feature_applicability.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_applic(del)', '2006-07-09 19:36:22', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_applic(enq)', 'Enquire Product Feature Applicability', 'Read', 'PROC', 'prod_feature_applicability.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_applic(enq)', '2005-04-19 18:47:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_applic(list)', 'List Product Feature Applicability', 'Feature Applicability', 'PROC', 'prod_feature_applicability.list.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, 'curr_or_hist=\'C\'', NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:27:25', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_applic(list)', 'pro_prod_feat_applic(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_applic(list)', 'pro_prod_feat_applic(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_applic(list)', 'pro_prod_feat_applic(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_applic(list)', 'pro_prod_feat_applic(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_applic(list)', 'pro_prod_feat_applic(search)', '005', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_applic(list)', 'date(current)', '006', 'Current', 'N', '2004-05-18 16:38:21', 'AJM', '2004-05-18 16:38:34', 'AJM'),
('pro_prod_feat_applic(list)', 'date(historic)', '007', 'Historic', 'N', '2004-05-18 16:38:21', 'AJM', '2004-05-18 16:38:34', 'AJM'),
('pro_prod_feat_applic(list)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2004-04-09 12:01:07', 'AJM', '2004-05-18 16:38:34', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_applic(list)', '2005-04-19 18:47:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_applic(search)', 'Search Product Feature Applicability', 'Search', 'PROC', 'prod_feature_applicability.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_applic(search)', '2005-04-19 18:47:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_applic(upd)', 'Update Product Feature Applicability', 'Update', 'PROC', 'prod_feature_applicability.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:55', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_applic(upd)', '2006-07-09 19:36:22', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_cat(add)', 'Insert Product Feature Category', 'New', 'PROC', 'product_feature_category.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_cat(add)', '2006-07-09 19:36:22', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_cat(del)', 'Delete Product Feature Category', 'Delete', 'PROC', 'product_feature_category.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_cat(del)', '2006-07-09 19:36:22', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_cat(enq)', 'Enquire Product Feature Category', 'Read', 'PROC', 'product_feature_category.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_cat(enq)', '2005-04-19 18:47:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_cat(list)', 'List Product Feature Category', 'Feature Category', 'PROC', 'product_feature_category.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, 'prod_feature_cat_id', 'Y', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2006-07-03 09:55:38', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_cat(list)', 'pro_prod_feat_cat(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_cat(list)', 'pro_prod_feat_cat(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_cat(list)', 'pro_prod_feat_cat(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_cat(list)', 'pro_prod_feat_cat(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_cat(list)', 'pro_prod_feat_cat(search)', '005', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_cat(list)', 'pro_prod_feature(list2)', '006', 'Feature', 'Y', '2006-06-27 16:32:23', 'AJM', '2006-06-27 16:32:41', 'AJM'),
('pro_prod_feat_cat(list)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2004-04-09 11:55:15', 'AJM', '2006-06-27 16:32:41', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_cat(list)', '2005-04-19 18:47:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_cat(popup)', 'Choose Product Feature Category', 'Choose', 'PROC', 'product_feature_category.popup.php', 'N', 'POPUP1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2006-10-06 13:47:13', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_cat(popup)', '2005-04-19 18:47:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_cat(search)', 'Search Product Feature Cateory', 'Search', 'PROC', 'product_feature_category.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_cat(search)', '2005-04-19 18:47:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_cat(upd)', 'Update Product Feature Category', 'Update', 'PROC', 'product_feature_category.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:59', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_cat(upd)', '2006-07-09 19:36:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_interact(add)', 'Insert Product Feature Interaction', 'New', 'PROC', 'prod_feature_interaction.add.php', 'N', 'ADD2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_interact(add)', '2006-07-09 19:36:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_interact(del)', 'Delete Product Feature Interaction', 'Delete', 'PROC', 'prod_feature_interaction.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_interact(del)', '2006-07-09 19:36:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_interact(enq)', 'Enquire Product Feature Interaction', 'Read', 'PROC', 'prod_feature_interaction.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_interact(enq)', '2005-04-19 18:47:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_interact(list)', 'List Product Feature Interaction', 'Feature Interaction', 'PROC', 'prod_feature_interaction.list.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_interact(list)', 'pro_prod_feat_interact(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_interact(list)', 'pro_prod_feat_interact(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_interact(list)', 'pro_prod_feat_interact(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_interact(list)', 'pro_prod_feat_interact(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_interact(list)', 'pro_prod_feat_interact(search)', '005', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_interact(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-09 12:01:14', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_interact(list)', '2005-04-19 18:47:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_interact(search)', 'Search Product Feature Interaction', 'Search', 'PROC', 'prod_feature_interaction.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_interact(search)', '2005-04-19 18:47:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_interact(upd)', 'Update Product Feature Interaction', 'Update', 'PROC', 'prod_feature_interaction.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:32:03', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_interact(upd)', '2006-07-09 19:36:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(add)', 'Insert Unit of Measure', 'New', 'PROC', 'unit_of_measure.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom(add)', '2006-07-09 19:36:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(del)', 'Delete Unit of Measre', 'Delete', 'PROC', 'unit_of_measure.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom(del)', '2006-07-09 19:36:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(enq)', 'Enquire Unit of Measure', 'Read', 'PROC', 'unit_of_measure.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom(enq)', '2005-04-19 18:47:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(list)', 'List Unit of Measure', 'UOM', 'PROC', 'unit_of_measure.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, 'uom_cat_id,uom_id', 'Y', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2006-07-03 09:55:46', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(list)', 'pro_uom(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom(list)', 'pro_uom(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom(list)', 'pro_uom(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom(list)', 'pro_uom(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom(list)', 'pro_uom_conv(list)2', '005', 'UOM Conversion', 'Y', '2003-01-01 12:00:00', 'AJM', '2006-06-28 19:38:01', 'AJM'),
('pro_uom(list)', 'pro_uom(search)', '006', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom(list)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2004-04-09 11:55:47', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom(list)', '2005-04-19 18:47:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(list)2', 'List Unit of Measure by Category', 'UOM', 'PROC', 'unit_of_measure.list2.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-06-27 17:00:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(list)2', 'pro_uom(add)', '001', 'New', 'N', '2006-06-27 17:03:23', 'AJM', NULL, NULL),
('pro_uom(list)2', 'pro_uom(enq)', '002', 'Read', 'Y', '2006-06-27 17:03:24', 'AJM', '2006-06-27 17:03:46', 'AJM'),
('pro_uom(list)2', 'pro_uom(del)', '003', 'Delete', 'Y', '2006-06-27 17:03:24', 'AJM', '2006-06-27 17:03:46', 'AJM'),
('pro_uom(list)2', 'pro_uom(upd)', '004', 'Update', 'Y', '2006-06-27 17:03:24', 'AJM', '2006-06-27 17:03:46', 'AJM'),
('pro_uom(list)2', 'pro_uom(search)', '005', 'Search', 'N', '2006-06-27 17:03:24', 'AJM', '2006-06-27 17:03:46', 'AJM'),
('pro_uom(list)2', 'pro_uom_conv(list)2', '006', 'UOM Conversion', 'Y', '2006-06-28 19:34:16', 'AJM', '2006-06-28 19:38:01', 'AJM'),
('pro_uom(list)2', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2006-06-27 17:15:50', 'AJM', '2006-06-28 19:34:29', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom(list)2', '2006-07-09 19:36:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(popup)', 'Choose Unit of Measure', 'Choose', 'PROC', 'unit_of_measure.popup.php', 'N', 'POPUP1', 'PRODUCT', 'pro_uom(search)', NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2006-10-06 13:47:50', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(popup)', 'pro_uom(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom(popup)', '2005-04-19 18:47:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(search)', 'Search Unit of Measure', 'Search', 'PROC', 'unit_of_measure.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom(search)', '2005-04-19 18:47:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(upd)', 'Update Unit of Measure', 'Update', 'PROC', 'unit_of_measure.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:32:07', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom(upd)', '2006-07-09 19:36:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_category(add)', 'Insert Unit of Measure Category', 'New', 'PROC', 'uom_category.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom_category(add)', '2006-07-09 19:36:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_category(del)', 'Delete Unit of Measure Category', 'Delete', 'PROC', 'uom_category.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom_category(del)', '2006-07-09 19:36:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_category(enq)', 'Enquire Unit of Measure Category', 'Read', 'PROC', 'uom_category.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom_category(enq)', '2005-04-19 18:47:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_category(list)', 'List Unit of Measure Category', 'UOM Category', 'PROC', 'uom_category.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, 'uom_cat_id', 'Y', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2006-07-03 09:55:54', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_category(list)', 'pro_uom_category(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom_category(list)', 'pro_uom_category(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom_category(list)', 'pro_uom_category(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom_category(list)', 'pro_uom_category(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom_category(list)', 'pro_uom_category(search)', '005', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom_category(list)', 'pro_uom(list)2', '006', 'UOM', 'Y', '2006-06-27 17:00:50', 'AJM', '2006-06-27 17:01:05', 'AJM'),
('pro_uom_category(list)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2004-04-09 11:55:55', 'AJM', '2006-06-27 17:01:05', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom_category(list)', '2005-04-19 18:47:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_category(search)', 'Search Unit of Measure Category', 'Search', 'PROC', 'uom_category.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom_category(search)', '2005-04-19 18:47:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_category(upd)', 'Update Unit of Measure Category', 'Update', 'PROC', 'uom_category.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:32:10', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom_category(upd)', '2006-07-09 19:36:40', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_conv(add)', 'Insert Unit of Measure Conversion', 'New', 'PROC', 'uom_conversion.add.php', 'N', 'ADD2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom_conv(add)', '2006-07-09 19:36:40', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_conv(del)', 'Delete Unit of Measure Conversion', 'Delete', 'PROC', 'uom_conversion.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom_conv(del)', '2006-07-09 19:36:40', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_conv(enq)', 'Enquire Unit of Measure Conversion', 'Enquire', 'PROC', 'uom_conversion.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom_conv(enq)', '2005-04-19 18:47:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_conv(list)', 'List Unit of Measure Conversion', 'UOM Conversion', 'PROC', 'uom_conversion.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'Y', 'N', NULL, 'N', '2006-06-28 19:45:45', 'AJM', '2006-06-28 19:48:38', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_conv(list)', 'pro_uom_conv(add)', '001', 'New', 'N', '2006-06-28 19:47:31', 'AJM', '2006-06-28 19:51:15', 'AJM'),
('pro_uom_conv(list)', 'pro_uom_conv(enq)', '002', 'Enquire', 'Y', '2006-06-28 19:47:31', 'AJM', '2006-06-28 19:47:55', 'AJM'),
('pro_uom_conv(list)', 'pro_uom_conv(upd)', '003', 'Update', 'Y', '2006-06-28 19:47:03', 'AJM', '2006-06-28 19:47:55', 'AJM'),
('pro_uom_conv(list)', 'pro_uom_conv(del)', '004', 'Delete', 'Y', '2006-06-28 19:47:31', 'AJM', '2006-06-28 19:47:55', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom_conv(list)', '2006-07-09 19:36:40', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_conv(list)2', 'List Unit of Measure Conversion', 'UOM Conversion', 'PROC', 'uom_conversion.list2.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, NULL, NULL, 'conversion_factor', 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2006-06-28 19:45:21', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_conv(list)2', 'pro_uom_conv(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2006-06-28 19:38:01', 'AJM'),
('pro_uom_conv(list)2', 'pro_uom_conv(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2006-06-28 19:38:01', 'AJM'),
('pro_uom_conv(list)2', 'pro_uom_conv(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2006-06-28 19:38:01', 'AJM'),
('pro_uom_conv(list)2', 'pro_uom_conv(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2006-06-28 19:38:01', 'AJM'),
('pro_uom_conv(list)2', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2004-04-09 11:56:03', 'AJM', '2006-06-28 19:38:01', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom_conv(list)2', '2005-04-19 18:47:59', 'AJM', '2006-06-28 19:38:01', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_conv(upd)', 'Update Unit of Measure Conversion', 'Update', 'PROC', 'uom_conversion.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:32:15', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom_conv(upd)', '2006-07-09 19:36:40', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('product', 'Product Menu', 'Product', 'MENU', 'menu.php', 'N', 'MENU', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pr_feature', 'Features', 'Features', 'MENU', 'menu.php', 'N', 'MENU', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, NULL, '2006-06-28 19:53:51', 'AJM', NULL, NULL),
('pr_inventory', 'Product Inventory Menu', 'Inventory', 'MENU', 'menu.php', 'N', 'MENU', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, NULL, '2006-06-30 16:12:06', 'AJM', '2006-07-02 13:44:22', 'AJM'),
('pr_uom', 'Unit of Measure', 'UOM', 'MENU', 'menu.php', 'N', 'MENU', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, NULL, '2006-06-28 19:28:53', 'AJM', NULL, NULL);

REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('product', 'pro_product(list)', '001', 'Product', '2003-01-01 12:00:00', 'AJM', '2006-06-28 19:58:01', 'AJM'),
('product', 'pro_prod_cat(list)', '002', 'Category', '2003-01-01 12:00:00', 'AJM', '2006-06-28 19:58:01', 'AJM'),
('product', 'pro_good_id_type(list)', '003', 'ID Type', '2003-01-01 12:00:00', 'AJM', '2006-06-28 19:58:01', 'AJM'),
('product', 'pr_feature', '004', 'Features', '2006-06-28 19:55:52', 'AJM', '2006-06-28 19:58:00', 'AJM'),
('product', 'pr_uom', '005', 'UOM', '2006-06-28 19:30:50', 'AJM', '2006-06-28 19:58:01', 'AJM'),
('product', 'pr_inventory', '006', 'Inventory', '2006-06-30 16:13:02', 'AJM', '2006-07-02 13:44:22', 'AJM'),
('pr_feature', 'pro_prod_feat_cat(list)', '001', 'Feature Category', '2006-06-28 19:54:50', 'AJM', NULL, NULL),
('pr_feature', 'pro_prod_feature(list)', '002', 'Feature', '2006-06-28 19:55:12', 'AJM', NULL, NULL),
('pr_inventory', 'pro_facility_type(list)', '001', 'Facility Type', '2006-06-30 16:12:28', 'AJM', '2006-07-02 13:44:22', 'AJM'),
('pr_inventory', 'pro_facility(list)', '002', 'Facility', '2006-06-30 17:06:50', 'AJM', '2006-07-02 13:44:22', 'AJM'),
('pr_inventory', 'pro_container_type(list)', '003', 'Container Type', '2006-06-30 17:44:11', 'AJM', '2006-07-02 13:44:22', 'AJM'),
('pr_inventory', 'pro_container(list)', '004', 'Container', '2006-06-30 18:20:50', 'AJM', '2006-07-02 13:44:22', 'AJM'),
('pr_inventory', 'pro_inv_var_reason(list)', '005', 'Reason', '2006-07-02 13:44:54', 'AJM', NULL, NULL),
('pr_inventory', 'pro_inv_item_status(list)', '006', 'Item Status', '2006-07-02 14:50:52', 'AJM', NULL, NULL),
('pr_inventory', 'pro_lot(list)', '007', 'Lot', '2006-07-02 15:40:13', 'AJM', NULL, NULL),
('pr_inventory', 'pro_inv_item(list)', '008', 'Inventory', '2006-07-03 10:27:55', 'AJM', NULL, NULL),
('pr_uom', 'pro_uom_category(list)', '001', 'UOM Category', '2006-06-28 19:29:45', 'AJM', NULL, NULL),
('pr_uom', 'pro_uom(list)', '002', 'UOM', '2006-06-28 19:30:09', 'AJM', NULL, NULL),
('pr_uom', 'pro_uom_conv(list)', '003', 'UOM Conversion', '2006-06-28 19:46:15', 'AJM', '2006-06-28 19:46:30', 'AJM');

REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('proto', 'product', '002', 'Product', '2005-05-05 17:45:59', 'AJM', NULL, NULL);

-- finished
