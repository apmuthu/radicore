-- file created on January 10, 2006, 6:37 pm
    
REPLACE INTO `mnu_subsystem` (`subsys_id`, `subsys_desc`, `subsys_dir`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('PRODUCT', 'Product data', 'product', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id(add)', 'Insert Good Identification', 'New', 'PROC', 'good_identification.add.php', 'N', 'ADD2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id(del)', 'Delete Good Identification', 'Delete', 'PROC', 'good_identification.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id(enq)', 'Enquire Good Identification', 'Read', 'PROC', 'good_identification.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_good_id(enq)', '2005-04-19 18:46:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id(list)', 'List Good Identification', 'Good Identification', 'PROC', 'good_identification.list.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, NULL, NULL, 'identity_type_id', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:26:10', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id(list)', 'pro_good_id(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_good_id(list)', 'pro_good_id(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_good_id(list)', 'pro_good_id(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_good_id(list)', 'pro_good_id(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_good_id(list)', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2004-04-09 12:00:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_good_id(list)', '2005-04-19 18:46:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id(upd)', 'Update Good Identification', 'Update', 'PROC', 'good_identification.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:17', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id_type(add)', 'Insert Good Identity Type', 'New', 'PROC', 'good_identity_type.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id_type(del)', 'Delete Good Identity Type', 'Delete', 'PROC', 'good_identity_type.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id_type(enq)', 'Enquire Good Identity Type', 'Read', 'PROC', 'good_identity_type.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_good_id_type(enq)', '2005-04-19 18:46:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id_type(list)', 'List Good Identity Type', 'Good ID Type', 'PROC', 'good_identity_type.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, 'identity_type_id', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-05-18 15:19:45', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id_type(list)', 'pro_good_id_type(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_good_id_type(list)', 'pro_good_id_type(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_good_id_type(list)', 'pro_good_id_type(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_good_id_type(list)', 'pro_good_id_type(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_good_id_type(list)', 'pro_good_id_type(search)', '005', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_good_id_type(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-09 11:40:37', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_good_id_type(list)', '2005-04-19 18:46:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id_type(popup)', 'Choose Good Identity Type', 'Choose', 'PROC', 'good_identity_type.popup.php', 'N', 'POPUP', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_good_id_type(popup)', '2005-04-19 18:46:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id_type(search)', 'Search Good Identity Type', 'Search', 'PROC', 'good_identity_type.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_good_id_type(search)', '2005-04-19 18:46:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_good_id_type(upd)', 'Update Good Identity Type', 'Update', 'PROC', 'good_identity_type.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:22', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_a(add)', 'Insert Price by Product', 'New', 'PROC', 'price_component.product.add.php', 'N', 'ADD2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_a(del)', 'Delete Price by Product', 'Delete', 'PROC', 'price_component.product.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_a(enq)', 'Enquire Price by Product', 'Read', 'PROC', 'price_component.product.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_a(enq)', '2005-04-19 18:46:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_a(list)', 'List Price by Product', 'Price Components', 'PROC', 'price_component.product.list.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, 'curr_or_hist=\'C\'', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:26:43', 'AJM');

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

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_a(search)', 'Search Price by Product', 'Search', 'PROC', 'price_component.product.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_a(search)', '2005-04-19 18:46:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_a(upd)', 'Update Price by Product', 'Update', 'PROC', 'price_component.product.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:26', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_b(add)', 'Insert Price by Product Feature', 'New', 'PROC', 'price_component.prod_feature.add.php', 'N', 'ADD2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_b(del)', 'Delete Price by Product Feature', 'Delete', 'PROC', 'price_component.prod_feature.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_b(enq)', 'Enquire Price by Product Feature', 'Read', 'PROC', 'price_component.prod_feature.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_b(enq)', '2005-04-19 18:46:33', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_b(list)', 'List Price by Product Feature', 'Price Component', 'PROC', 'price_component.prod_feature.list.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, 'curr_or_hist=\'C\'', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:27:00', 'AJM');

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

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_b(search)', 'Search Price by Product Feature', 'Search', 'PROC', 'price_component.prod_feature.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_b(search)', '2005-04-19 18:46:33', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_b(upd)', 'Update Price by Product Feature', 'Update', 'PROC', 'price_component.prod_feature.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:30', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_c(add)', 'Insert Price by Product Category', 'New', 'PROC', 'price_component.prod_cat.add.php', 'N', 'ADD2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_c(del)', 'Delete Price by Product Category', 'Delete', 'PROC', 'price_component.prod_cat.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_c(enq)', 'Enquire Price by Product Category', 'Read', 'PROC', 'price_component.prod_cat.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_c(enq)', '2005-04-19 18:46:33', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_c(list)', 'List Price by Product Category', 'Price Component', 'PROC', 'price_component.prod_cat.list.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, 'curr_or_hist=\'C\'', NULL, NULL, 'Y', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:21:17', 'AJM');

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

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_c(search)', 'Search Price by Product Category', 'Search', 'PROC', 'price_component.prod_cat.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_price_component_c(search)', '2005-04-19 18:46:33', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_price_component_c(upd)', 'Update Price by Product Category', 'Update', 'PROC', 'price_component.prod_cat.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:34', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_product(add)', 'Insert Product', 'New', 'PROC', 'product.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_product(del)', 'Delete Product', 'Delete', 'PROC', 'product.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_product(enq)', 'Enquire Product', 'Read', 'PROC', 'product.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_product(enq)', '2005-04-19 18:46:44', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_product(list)', 'List Product', 'List Product', 'PROC', 'product.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_product(list)', 'pro_product(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_product(list)', 'pro_product(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_product(list)', 'pro_product(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_product(list)', 'pro_product(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_product(list)', 'pro_prod_cat_class(list)', '005', 'Category Class', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_product(list)', 'pro_good_id(list)', '006', 'Good Identification', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_product(list)', 'pro_prod_feat_interact(list)', '007', 'Feature Interaction', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_product(list)', 'pro_prod_feat_applic(list)', '008', 'Feature Applicability', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_product(list)', 'pro_price_component_a(list)', '009', 'Price Components', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_product(list)', 'pro_product(search)', '010', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_product(list)', 'audit_dtl(list)3', '011', 'Audit Trail', 'Y', '2004-04-09 11:54:41', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_product(list)', '2005-04-19 18:46:44', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_product(popup)', 'Choose Product', 'Choose', 'PROC', 'product.popup.php', 'N', 'POPUP', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_product(popup)', '2005-04-19 18:46:44', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_product(search)', 'Search Product', 'Search', 'PROC', 'product.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_product(search)', '2005-04-19 18:46:44', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_product(upd)', 'Update Product', 'Update', 'PROC', 'product.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:38', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat(add)', 'Insert Product Category', 'New', 'PROC', 'product_category.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat(del)', 'Delete Product Category', 'Delete', 'PROC', 'product_category.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat(enq)', 'Enquire Product Category', 'Read', 'PROC', 'product_category.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat(enq)', '2005-04-19 18:46:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat(list)', 'List Product Category', 'Category', 'PROC', 'product_category.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, 'prod_cat_id', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:22:55', 'AJM');

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

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat(popup)', 'Choose Product Category', 'Choose', 'PROC', 'product_category.popup.php', 'N', 'POPUP', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat(popup)', 'pro_prod_cat(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat(popup)', '2005-04-19 18:46:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat(search)', 'Search Product Category', 'Search', 'PROC', 'product_category.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat(search)', '2005-04-19 18:46:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat(upd)', 'Update Product Category', 'Update', 'PROC', 'product_category.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:43', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_class(add)', 'Insert Product Category Class', 'New', 'PROC', 'prod_cat_class.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_class(del)', 'Delete Product Category Class', 'Delete', 'PROC', 'prod_cat_class.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_class(enq)', 'Enquire Product Category Class', 'Read', 'PROC', 'prod_cat_class.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat_class(enq)', '2005-04-19 18:46:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_class(list)', 'List Product Category Class', 'Category Class', 'PROC', 'prod_cat_class.list.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, 'curr_or_hist=\'C\'', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:27:12', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_class(list)', 'pro_prod_cat_class(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat_class(list)', 'pro_prod_cat_class(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat_class(list)', 'pro_prod_cat_class(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat_class(list)', 'pro_prod_cat_class(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat_class(list)', 'pro_prod_cat_class(search)', '006', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat_class(list)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2004-04-09 12:00:51', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat_class(list)', '2005-04-19 18:46:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_class(search)', 'Search Product Category Class', 'Search', 'PROC', 'prod_cat_class.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat_class(search)', '2005-04-19 18:46:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_class(upd)', 'Update Product Category Class', 'Update', 'PROC', 'prod_cat_class.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_rollup(add)', 'Insert Product Category Rollup', 'New', 'PROC', 'prod_cat_rollup.add.php', 'N', 'ADD3', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_rollup(del)', 'Delete Product Category Rollup', 'Delete', 'PROC', 'prod_cat_rollup.del.php', 'N', 'DEL2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_rollup(list)', 'Product Category Rollup List', 'Rollup', 'PROC', 'prod_cat_rollup.list.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, NULL, NULL, 'prod_cat_id_jnr', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:35:23', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_cat_rollup(list)', 'pro_prod_cat_rollup(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat_rollup(list)', 'pro_prod_cat_rollup(del)', '002', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_cat_rollup(list)', 'audit_dtl(list)3', '003', 'Audit Trail', 'Y', '2004-04-09 12:00:58', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_cat_rollup(list)', '2005-04-19 18:47:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(add)', 'Insert Product Feature', 'New', 'PROC', 'product_feature.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(del)', 'Delete Product Feature', 'Delete', 'PROC', 'product_feature.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(enq)', 'Enquire Product Feature', 'Read', 'PROC', 'product_feature.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feature(enq)', '2005-04-19 18:47:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(list)', 'List Product Feature', 'Feature', 'PROC', 'product_feature.list.php', 'N', 'LIST1', 'PRODUCT', 'pro_prod_feature(search)', NULL, NULL, NULL, 'prod_feature_cat_id,prod_feature_desc', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:02:05', 'AJM');

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

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(popup)', 'Choose Product Feature', 'Choose', 'PROC', 'product_feature.popup.php', 'N', 'POPUP', 'PRODUCT', 'pro_prod_feature(search)', NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feature(popup)', '2005-04-19 18:47:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(popup)jnr', 'Choose Product Feature', 'Choose', 'PROC', 'product_feature.popup.php', 'N', 'POPUP', 'PRODUCT', 'pro_prod_feature(search)', NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feature(popup)jnr', '2005-04-19 18:47:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(popup)snr', 'Choose Product Feature', 'Choose', 'PROC', 'product_feature.popup.php', 'N', 'POPUP', 'PRODUCT', 'pro_prod_feature(search)', NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feature(popup)snr', '2005-04-19 18:47:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(search)', 'Search Product Feature', 'Search', 'PROC', 'product_feature.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feature(search)', '2005-04-19 18:47:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feature(upd)', 'Update Product Feature', 'Update', 'PROC', 'product_feature.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:51', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_applic(add)', 'Insert Product Feature Applicability', 'New', 'PROC', 'prod_feature_applicability.add.php', 'N', 'ADD2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_applic(del)', 'Delete Product Feature Applicability', 'Delete', 'PROC', 'prod_feature_applicability.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_applic(enq)', 'Enquire Product Feature Applicability', 'Read', 'PROC', 'prod_feature_applicability.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_applic(enq)', '2005-04-19 18:47:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_applic(list)', 'List Product Feature Applicability', 'Feature Applicability', 'PROC', 'prod_feature_applicability.list.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, 'curr_or_hist=\'C\'', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:27:25', 'AJM');

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

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_applic(search)', 'Search Product Feature Applicability', 'Search', 'PROC', 'prod_feature_applicability.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_applic(search)', '2005-04-19 18:47:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_applic(upd)', 'Update Product Feature Applicability', 'Update', 'PROC', 'prod_feature_applicability.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:55', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_cat(add)', 'Insert Product Feature Category', 'New', 'PROC', 'product_feature_category.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_cat(del)', 'Delete Product Feature Category', 'Delete', 'PROC', 'product_feature_category.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_cat(enq)', 'Enquire Product Feature Category', 'Read', 'PROC', 'product_feature_category.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_cat(enq)', '2005-04-19 18:47:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_cat(list)', 'List Product Feature Category', 'Feature Category', 'PROC', 'product_feature_category.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, 'prod_feature_cat_id', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:10:11', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_cat(list)', 'pro_prod_feat_cat(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_cat(list)', 'pro_prod_feat_cat(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_cat(list)', 'pro_prod_feat_cat(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_cat(list)', 'pro_prod_feat_cat(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_cat(list)', 'pro_prod_feat_cat(search)', '005', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_cat(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-09 11:55:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_cat(list)', '2005-04-19 18:47:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_cat(popup)', 'Choose Product Feature Category', 'Choose', 'PROC', 'product_feature_category.popup.php', 'N', 'POPUP', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_cat(popup)', '2005-04-19 18:47:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_cat(search)', 'Search Product Feature Cateory', 'Search', 'PROC', 'product_feature_category.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_cat(search)', '2005-04-19 18:47:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_cat(upd)', 'Update Product Feature Category', 'Update', 'PROC', 'product_feature_category.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:31:59', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_interact(add)', 'Insert Product Feature Interaction', 'New', 'PROC', 'prod_feature_interaction.add.php', 'N', 'ADD2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_interact(del)', 'Delete Product Feature Interaction', 'Delete', 'PROC', 'prod_feature_interaction.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_interact(enq)', 'Enquire Product Feature Interaction', 'Read', 'PROC', 'prod_feature_interaction.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_interact(enq)', '2005-04-19 18:47:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_interact(list)', 'List Product Feature Interaction', 'Feature Interaction', 'PROC', 'prod_feature_interaction.list.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_interact(list)', 'pro_prod_feat_interact(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_interact(list)', 'pro_prod_feat_interact(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_interact(list)', 'pro_prod_feat_interact(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_interact(list)', 'pro_prod_feat_interact(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_interact(list)', 'pro_prod_feat_interact(search)', '005', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_prod_feat_interact(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-09 12:01:14', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_interact(list)', '2005-04-19 18:47:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_interact(search)', 'Search Product Feature Interaction', 'Search', 'PROC', 'prod_feature_interaction.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_prod_feat_interact(search)', '2005-04-19 18:47:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_prod_feat_interact(upd)', 'Update Product Feature Interaction', 'Update', 'PROC', 'prod_feature_interaction.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:32:03', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(add)', 'Insert Unit of Measure', 'New', 'PROC', 'unit_of_measure.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(del)', 'Delete Unit of Measre', 'Delete', 'PROC', 'unit_of_measure.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(enq)', 'Enquire Unit of Measure', 'Read', 'PROC', 'unit_of_measure.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom(enq)', '2005-04-19 18:47:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(list)', 'List Unit of Measure', 'UOM', 'PROC', 'unit_of_measure.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, 'uom_cat_id,uom_id', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:13:43', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(list)', 'pro_uom(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom(list)', 'pro_uom(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom(list)', 'pro_uom(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom(list)', 'pro_uom(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom(list)', 'pro_uom_conv(list)', '005', 'UOM Conversion', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-05-06 16:11:56', 'AJM'),
('pro_uom(list)', 'pro_uom(search)', '006', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom(list)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2004-04-09 11:55:47', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom(list)', '2005-04-19 18:47:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(popup)', 'Choose Unit of Measure', 'Choose', 'PROC', 'unit_of_measure.popup.php', 'N', 'POPUP', 'PRODUCT', 'pro_uom(search)', NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(popup)', 'pro_uom(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom(popup)', '2005-04-19 18:47:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(search)', 'Search Unit of Measure', 'Search', 'PROC', 'unit_of_measure.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom(search)', '2005-04-19 18:47:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom(upd)', 'Update Unit of Measure', 'Update', 'PROC', 'unit_of_measure.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:32:07', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_category(add)', 'Insert Unit of Measure Category', 'New', 'PROC', 'uom_category.add.php', 'N', 'ADD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_category(del)', 'Delete Unit of Measure Category', 'Delete', 'PROC', 'uom_category.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_category(enq)', 'Enquire Unit of Measure Category', 'Read', 'PROC', 'uom_category.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom_category(enq)', '2005-04-19 18:47:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_category(list)', 'List Unit of Measure Category', 'UOM Category', 'PROC', 'uom_category.list.php', 'N', 'LIST1', 'PRODUCT', NULL, NULL, NULL, NULL, 'uom_cat_id', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:16:26', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_category(list)', 'pro_uom_category(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom_category(list)', 'pro_uom_category(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom_category(list)', 'pro_uom_category(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom_category(list)', 'pro_uom_category(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom_category(list)', 'pro_uom_category(search)', '005', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom_category(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-09 11:55:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom_category(list)', '2005-04-19 18:47:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_category(search)', 'Search Unit of Measure Category', 'Search', 'PROC', 'uom_category.search.php', 'N', 'SRCH', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom_category(search)', '2005-04-19 18:47:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_category(upd)', 'Update Unit of Measure Category', 'Update', 'PROC', 'uom_category.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:32:10', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_conv(add)', 'Insert Unit of Measure Conversion', 'New', 'PROC', 'uom_conversion.add.php', 'N', 'ADD2', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_conv(del)', 'Delete Unit of Measure Conversion', 'Delete', 'PROC', 'uom_conversion.del.php', 'N', 'DEL1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_conv(enq)', 'Enquire Unit of Measure Conversion', 'Enquire', 'PROC', 'uom_conversion.enq.php', 'N', 'ENQ1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom_conv(enq)', '2005-04-19 18:47:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_conv(list)', 'List Unit of Measure Conversion', 'UOM Conversion', 'PROC', 'uom_conversion.list.php', 'N', 'LIST2', 'PRODUCT', NULL, NULL, NULL, NULL, 'conversion_factor', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-05-18 16:50:58', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_conv(list)', 'pro_uom_conv(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-06 16:10:39', 'AJM'),
('pro_uom_conv(list)', 'pro_uom_conv(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom_conv(list)', 'pro_uom_conv(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom_conv(list)', 'pro_uom_conv(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('pro_uom_conv(list)', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2004-04-09 11:56:03', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'pro_uom_conv(list)', '2005-04-19 18:47:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('pro_uom_conv(upd)', 'Update Unit of Measure Conversion', 'Update', 'PROC', 'uom_conversion.upd.php', 'N', 'UPD1', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-16 17:32:15', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('product', 'Product Menu', 'Product', 'MENU', 'menu.php', 'N', 'MENU', 'PRODUCT', NULL, NULL, NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('product', 'pro_prod_feat_cat(list)', '001', 'Feature Category', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('product', 'pro_prod_feature(list)', '002', 'Feature', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('product', 'pro_good_id_type(list)', '003', 'Good ID Type', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('product', 'pro_uom_category(list)', '004', 'UOM Category', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('product', 'pro_uom(list)', '005', 'UOM', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('product', 'pro_prod_cat(list)', '006', 'Category', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('product', 'pro_product(list)', '007', 'Product', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('proto', 'product', '002', 'Product', '2005-05-05 17:45:59', 'AJM', NULL, NULL);

-- finished
