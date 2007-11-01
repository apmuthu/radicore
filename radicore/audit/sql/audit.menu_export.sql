-- file created on July 12, 2007, 6:55 pm
    
REPLACE INTO `mnu_subsystem` (`subsys_id`, `subsys_desc`, `subsys_dir`, `task_prefix`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('AUDIT', 'Audit Trail', 'audit', 'audit_', '2003-01-01 12:00:00', 'AJM', '2006-04-22 09:38:17', 'AJM');

REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'Demonstration Class', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('DEV', 'Development', 'main_menu', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('GLOBAL', 'Global Access', 'main_menu', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('READONLY', 'Read Only', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'SURVEY (supervisor)', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER1', 'User Class 1', 'proto', 'N', '2003-01-01 12:00:00', 'AJM', '2005-07-31 14:59:56', 'AJM'),
('USER2', 'User Class 2', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER3', 'User Class 3', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('audit_dtl(del)', 'Delete Audit Detail', 'Delete', 'PROC', 'audit_dtl_del.php', 'N', 'DEL4', 'AUDIT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-03-20 15:29:33', 'AJM', '2006-03-20 16:50:22', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('audit_dtl(list)2', 'audit_dtl(del)', '002', 'Delete', 'N', '2006-03-20 15:39:54', 'AJM', '2007-06-23 13:41:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('audit_dtl(list)2', 'List Audit Details', 'List Audit', 'PROC', 'audit_dtl_list2.php', 'N', 'LIST2', 'AUDIT', 'audit_dtl(search)', NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2006-10-14 18:29:42', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('audit_dtl(list)2', 'audit_dtl(del)', '002', 'Delete', 'N', '2006-03-20 15:39:54', 'AJM', '2007-06-23 13:41:47', 'AJM'),
('audit_dtl(list)2', 'audit_dtl(search)', '003', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-06-23 13:41:47', 'AJM'),
('audit_dtl(list)2', 'audit_tbl(upd4)', '003', 'Generate SQL', 'N', '2007-06-23 13:41:06', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'audit_dtl(list)2', '2005-04-19 18:09:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('audit_dtl(list)3', 'List Audit Details for an Object', 'Audit Trail', 'PROC', 'audit_dtl_list3.php', 'N', 'LIST3', 'AUDIT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-04-08 16:25:44', 'AJM', '2006-01-18 18:04:09', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(list)2', 'audit_dtl(list)3', '001', 'Audit Trail', 'Y', '2004-04-09 11:59:34', 'AJM', NULL, NULL),
('pro_prod_cat_rollup(list)', 'audit_dtl(list)3', '003', 'Audit Trail', 'Y', '2004-04-09 12:00:58', 'AJM', NULL, NULL),
('mnu_task_field(list)', 'audit_dtl(list)3', '003', 'Audit Trail', 'Y', '2004-04-09 11:59:27', 'AJM', NULL, NULL),
('mnu_task(list)3', 'audit_dtl(list)3', '004', 'Audit Trail', 'Y', '2004-04-09 11:59:19', 'AJM', '2006-07-21 11:36:46', 'AJM'),
('mnu_task(list)2', 'audit_dtl(list)3', '004', 'Audit Trail', 'Y', '2004-04-09 11:59:11', 'AJM', '2006-07-21 11:35:33', 'AJM'),
('dict_table_key(list)', 'audit_dtl(list)3', '004', 'Audit Trail', 'Y', '2005-06-10 09:45:43', 'AJM', NULL, NULL),
('ord_requirement_request(list2)a', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2007-01-26 15:51:26', 'AJM', '2007-01-26 16:13:44', 'AJM'),
('dict_relationship(list)3', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2005-06-11 18:41:56', 'AJM', '2005-06-26 12:37:31', 'AJM'),
('pro_uom_conv(list)2', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2004-04-09 11:56:03', 'AJM', '2006-06-28 19:38:01', 'AJM'),
('ord_requirement_request(list2)b', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2007-01-26 16:29:48', 'AJM', NULL, NULL),
('mnu_menu(list)', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2004-04-09 11:58:45', 'AJM', NULL, NULL),
('mnu_nav_button(list)', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2004-04-09 11:58:57', 'AJM', NULL, NULL),
('pro_good_id(list)', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2004-04-09 12:00:28', 'AJM', NULL, NULL),
('dict_relationship(list)', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2005-06-11 18:38:45', 'AJM', '2005-06-26 12:38:42', 'AJM'),
('ord_responding_party(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-01-21 20:33:59', 'AJM', NULL, NULL),
('ord_term_type(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-31 16:10:50', 'AJM', NULL, NULL),
('py_contact_mech_purpose_type(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-02-20 17:50:03', 'AJM', NULL, NULL),
('py_org_subtype(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-02-04 11:26:40', 'AJM', NULL, NULL),
('ord_requirement_type(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-01-17 17:10:27', 'AJM', NULL, NULL),
('py_relationship_priority(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-02-09 17:15:21', 'AJM', NULL, NULL),
('py_relationship_status(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-02-09 17:23:35', 'AJM', NULL, NULL),
('py_relationship_type(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-02-09 17:07:20', 'AJM', NULL, NULL),
('py_role_subtype(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-02-04 15:50:58', 'AJM', NULL, NULL),
('pro_good_id_type(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-09 11:40:37', 'AJM', NULL, NULL),
('pro_price_component_a(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-09 12:00:35', 'AJM', '2007-03-25 18:25:01', 'AJM'),
('py_party_communication(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-02-17 16:11:57', 'AJM', NULL, NULL),
('ord_order_item_terms(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-31 17:34:21', 'AJM', NULL, NULL),
('ord_request_type(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-01-17 16:09:20', 'AJM', NULL, NULL),
('shp_preference_type(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-02-26 17:37:36', 'AJM', '2007-03-04 20:35:17', 'AJM'),
('shp_receipt_role_type(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-05 20:02:22', 'AJM', NULL, NULL),
('ord_order_item_adjustment(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-19 17:31:26', 'AJM', NULL, NULL),
('ord_order_item_p(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-06-25 14:14:13', 'AJM', NULL, NULL),
('ord_order_item_role(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-08 15:46:42', 'AJM', NULL, NULL),
('ord_order_item_status_hist(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-31 11:42:43', 'AJM', NULL, NULL),
('ord_order_item_status_type(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-05-22 15:04:35', 'AJM', NULL, NULL),
('ord_order_item_t(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-06-24 21:36:16', 'AJM', NULL, NULL),
('ord_invoice_status_hist(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-28 16:31:25', 'AJM', NULL, NULL),
('ord_order_role_type(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-05 16:49:47', 'AJM', NULL, NULL),
('ord_order_role(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-06 13:52:43', 'AJM', NULL, NULL),
('ord_order_status_hist(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-30 16:02:05', 'AJM', NULL, NULL),
('ord_order_status_rules(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-05-23 10:43:58', 'AJM', NULL, NULL),
('ord_order_status_type(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-30 15:19:58', 'AJM', NULL, NULL),
('ord_order_terms(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-31 16:51:32', 'AJM', NULL, NULL),
('ord_request_role_type(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-01-17 16:44:37', 'AJM', NULL, NULL),
('shp_rating_type(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-02-26 17:38:02', 'AJM', '2007-03-04 20:39:13', 'AJM'),
('pro_price_component_b(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-09 12:00:44', 'AJM', '2007-03-25 18:25:15', 'AJM'),
('pro_price_component_c(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-09 11:53:57', 'AJM', '2007-03-25 18:25:28', 'AJM'),
('shp_facility_contact_mechanism(list2)b', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-02-25 18:17:43', 'AJM', '2007-03-04 19:07:57', 'AJM'),
('shp_facility_role_type(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-02-25 14:15:34', 'AJM', '2007-03-04 19:10:23', 'AJM'),
('shp_facility_role(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-02-25 14:58:57', 'AJM', '2007-03-04 19:11:56', 'AJM'),
('ord_invoice_status(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-28 16:31:25', 'AJM', NULL, NULL),
('shp_shipment_status(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-02 18:38:03', 'AJM', NULL, NULL),
('ord_invoice_role_type(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-26 18:11:49', 'AJM', NULL, NULL),
('ord_invoice_role(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-28 11:45:46', 'AJM', NULL, NULL),
('ord_invoice_adjustment(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-29 17:32:56', 'AJM', '2007-05-02 21:41:44', 'AJM'),
('ord_invoice_item_adjustment(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-29 18:20:04', 'AJM', NULL, NULL),
('ord_invoice_item_terms(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-05-01 11:51:03', 'AJM', NULL, NULL),
('pro_price_component_k(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-25 17:56:14', 'AJM', NULL, NULL),
('pro_price_component_l(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-26 19:41:51', 'AJM', NULL, NULL),
('pro_price_component(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-03 14:50:04', 'AJM', NULL, NULL),
('pro_prod_cat_class(list2)b', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-20 18:32:41', 'AJM', NULL, NULL),
('pro_prod_feat_interact(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-09 12:01:14', 'AJM', NULL, NULL),
('shp_facility_contact_mechanism(list2)a', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-02-25 16:12:04', 'AJM', '2007-03-04 19:07:42', 'AJM'),
('shp_drop_shipment_item(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-23 13:48:09', 'AJM', NULL, NULL),
('pro_price_component_d(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-02-28 14:26:31', 'AJM', '2007-03-25 18:25:38', 'AJM'),
('pro_price_component_e(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-01 10:53:52', 'AJM', '2007-03-25 18:25:48', 'AJM'),
('pro_price_component_f(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-02 10:04:56', 'AJM', '2007-03-25 18:26:07', 'AJM'),
('pro_price_component_g(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-02 15:28:31', 'AJM', '2007-03-25 18:26:17', 'AJM'),
('pro_price_component_h(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-03 16:17:41', 'AJM', NULL, NULL),
('pro_price_component_i(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-21 10:26:44', 'AJM', '2007-03-21 10:27:48', 'AJM'),
('shp_carrier_shipment_method(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-12 18:01:55', 'AJM', NULL, NULL),
('shp_container_type(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2006-06-30 17:43:12', 'AJM', '2007-03-04 20:44:22', 'AJM'),
('shp_container(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2006-06-30 18:20:22', 'AJM', '2007-03-04 20:46:18', 'AJM'),
('shp_container(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-18 11:50:10', 'AJM', NULL, NULL),
('shp_dispatch_event(list2)b', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-13 17:44:24', 'AJM', NULL, NULL),
('shp_dispatch_event(list2)c', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-13 17:58:28', 'AJM', NULL, NULL),
('shp_dispatch_event(list2)d', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-13 18:10:16', 'AJM', NULL, NULL),
('shp_dispatch_event(list2)e', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-13 19:49:40', 'AJM', NULL, NULL),
('shp_dispatch_event(list2)f', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-14 18:25:29', 'AJM', NULL, NULL),
('pro_price_component_j(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-25 17:44:42', 'AJM', NULL, NULL),
('shp_facility_type(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2006-06-30 16:10:56', 'AJM', '2007-03-04 20:49:20', 'AJM'),
('wf_place(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-12 19:01:02', 'AJM', NULL, NULL),
('shp_lot(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2006-07-02 15:39:22', 'AJM', '2007-03-04 21:11:31', 'AJM'),
('wf_transition(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-12 19:01:54', 'AJM', NULL, NULL),
('shp_item_receipt_role(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-08 17:14:26', 'AJM', NULL, NULL),
('shp_issuance_role_type(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-10 15:07:23', 'AJM', NULL, NULL),
('shp_inventory_variance_reason(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2006-07-02 13:43:27', 'AJM', '2007-03-04 21:02:16', 'AJM'),
('dict_column(list)2', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2005-03-12 23:43:28', 'AJM', '2005-03-12 23:43:43', 'AJM'),
('dict_table_key(list)2', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2005-03-19 18:22:42', 'AJM', NULL, NULL),
('dict_relationship(list)2', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2005-06-11 18:39:37', 'AJM', '2005-06-26 12:36:53', 'AJM'),
('mnu_todo(list)2', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2005-07-30 19:32:02', 'AJM', NULL, NULL),
('shp_shipment_status_hist(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-02 18:38:03', 'AJM', NULL, NULL),
('mnu_todo(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2005-07-30 19:32:15', 'AJM', NULL, NULL),
('shp_inventory_item_variance(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2006-07-06 17:55:29', 'AJM', '2007-03-04 21:08:03', 'AJM'),
('shp_inventory_item_status(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2006-07-02 14:50:06', 'AJM', '2007-03-04 21:04:37', 'AJM'),
('pro_price_component_discount(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-07-07 17:00:34', 'AJM', NULL, NULL),
('shp_rejection_reason(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-05 20:17:11', 'AJM', NULL, NULL),
('wf_arc(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-12 19:26:31', 'AJM', NULL, NULL),
('ord_order_adjustment(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-14 11:51:45', 'AJM', '2007-03-19 17:39:07', 'AJM'),
('ord_order_notes(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-06-22 10:31:24', 'AJM', NULL, NULL),
('ord_item_role_type(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-03-05 17:14:49', 'AJM', NULL, NULL),
('shp_item_receipt(list2)a', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-06 18:15:52', 'AJM', '2007-05-19 15:46:03', 'AJM'),
('ord_invoice_terms(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-05-01 11:48:06', 'AJM', NULL, NULL),
('ord_invoice_status_type(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-04-28 16:18:24', 'AJM', NULL, NULL),
('ord_order_contact_mechanism(list2)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-03-08 14:26:59', 'AJM', '2007-03-10 14:04:06', 'AJM'),
('py_role_type(list1)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-02-04 15:29:58', 'AJM', '2007-02-04 15:52:28', 'AJM'),
('shp_vehicle_type(list1)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-04-12 20:41:33', 'AJM', '2007-04-13 11:31:15', 'AJM'),
('pro_quantity_break(list1)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-02-28 18:20:02', 'AJM', '2007-03-25 17:46:24', 'AJM'),
('shp_vehicle(list1)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-04-12 20:50:50', 'AJM', '2007-04-13 18:00:48', 'AJM'),
('shp_vehicle(list2)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-04-13 11:29:49', 'AJM', '2007-04-13 18:01:07', 'AJM'),
('pro_uom_category(list)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2004-04-09 11:55:55', 'AJM', '2006-06-27 17:01:05', 'AJM'),
('py_geographic_area_type(list1)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-02-11 22:35:28', 'AJM', '2007-02-15 11:26:17', 'AJM'),
('py_postal_address(list1)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-02-14 14:07:32', 'AJM', '2007-02-16 23:30:44', 'AJM'),
('py_party_subclass(list2)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-02-01 16:01:15', 'AJM', '2007-03-02 10:30:38', 'AJM'),
('shp_item_receipt(list2)b', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-04-07 14:48:51', 'AJM', '2007-04-08 17:17:05', 'AJM'),
('py_party_class(list1)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-02-01 15:51:59', 'AJM', '2007-02-01 16:02:05', 'AJM'),
('pro_prod_feature(list2)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2006-06-27 17:16:57', 'AJM', '2007-03-03 10:51:01', 'AJM'),
('pro_prod_feature(list)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2004-04-09 11:55:08', 'AJM', NULL, NULL),
('ord_order_adjustment_type(list1)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-03-14 11:25:02', 'AJM', '2007-03-21 10:30:26', 'AJM'),
('shp_package(list2)out', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-06-29 15:50:16', 'AJM', NULL, NULL),
('shp_item_issuance(list2)c', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-04-10 17:28:25', 'AJM', '2007-04-16 15:17:38', 'AJM'),
('ord_item_contact_mechanism(list2)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-03-08 16:23:23', 'AJM', '2007-03-10 14:37:58', 'AJM'),
('ord_item_adjustment_type(list1)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-03-26 17:44:27', 'AJM', '2007-03-26 19:42:43', 'AJM'),
('pro_value_break(list1)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-02-28 20:09:50', 'AJM', '2007-03-25 18:00:25', 'AJM'),
('pro_uom(list)2', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2006-06-27 17:15:50', 'AJM', '2006-06-28 19:34:29', 'AJM'),
('pro_uom(list)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2004-04-09 11:55:47', 'AJM', NULL, NULL),
('dict_database(list)2', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2005-03-12 19:08:37', 'AJM', '2005-06-10 17:20:20', 'AJM'),
('dict_column(list)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2005-06-10 12:47:40', 'AJM', '2006-10-01 11:33:40', 'AJM'),
('pro_prod_feat_cat(list)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2004-04-09 11:55:15', 'AJM', '2006-06-27 16:32:41', 'AJM'),
('mnu_pattern(list)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2004-04-09 11:37:12', 'AJM', '2006-03-27 23:37:24', 'AJM'),
('py_org_type(list1)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-01-30 17:08:53', 'AJM', '2007-02-04 11:29:33', 'AJM'),
('shp_stockcheck_dtl(list2)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-07-01 16:30:07', 'AJM', '2007-07-01 17:46:57', 'AJM'),
('ord_sale_type(list1)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-03-02 14:23:05', 'AJM', '2007-03-05 16:21:36', 'AJM'),
('wf_case(list)2', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2006-02-18 18:37:27', 'AJM', NULL, NULL),
('wf_case(list)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2006-02-18 18:37:09', 'AJM', NULL, NULL),
('py_contact_mechanism_type(list1)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-02-20 11:27:56', 'AJM', '2007-02-20 14:00:22', 'AJM'),
('shp_package_out_content(list2)out2', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-06-29 18:35:23', 'AJM', '2007-06-29 18:38:25', 'AJM'),
('shp_package_out_content(list2)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-04-06 15:01:04', 'AJM', '2007-06-29 18:37:40', 'AJM'),
('shp_item_receipt(list2)d', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-04-07 16:47:58', 'AJM', '2007-04-08 17:17:49', 'AJM'),
('shp_item_receipt(list2)c', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-04-07 15:05:23', 'AJM', '2007-04-08 17:17:26', 'AJM'),
('shp_picklist_dtl(list2)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-05-23 15:24:35', 'AJM', '2007-05-23 17:49:01', 'AJM'),
('shp_picklist_dtl(list2)a', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-06-21 18:37:38', 'AJM', NULL, NULL),
('shp_package(list2)out2', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-06-29 15:49:08', 'AJM', '2007-06-29 15:51:51', 'AJM'),
('py_contact_mechanism(list2)a', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-02-20 13:59:21', 'AJM', '2007-03-24 17:27:19', 'AJM'),
('shp_shipment(list2)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-05-24 12:06:16', 'AJM', '2007-06-28 18:56:20', 'AJM'),
('ord_request_item(list2)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2007-01-25 11:49:03', 'AJM', '2007-01-26 15:09:41', 'AJM'),
('shp_dispatch_event(list1)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2007-04-19 18:12:05', 'AJM', '2007-06-21 11:37:15', 'AJM'),
('shp_package_in_content(list2)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2007-04-22 16:55:07', 'AJM', '2007-04-22 19:27:20', 'AJM'),
('shp_shipment_dispatch_event(list2)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2007-04-19 19:40:32', 'AJM', '2007-06-21 14:20:31', 'AJM'),
('shp_shipment(list1)in3', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2007-05-03 13:55:24', 'AJM', '2007-05-03 14:18:32', 'AJM'),
('shp_shipment(list1)in2', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2007-05-03 13:55:34', 'AJM', '2007-05-03 14:18:14', 'AJM'),
('shp_shipment(list1)in1', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2007-05-03 13:55:48', 'AJM', '2007-05-03 14:17:16', 'AJM'),
('shp_shipment(list1)drop', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2007-05-03 13:57:21', 'AJM', '2007-05-03 14:04:05', 'AJM'),
('shp_shipment_method_type(list1)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2007-04-12 15:51:14', 'AJM', '2007-04-13 17:47:22', 'AJM'),
('shp_product_supplier(list2)a', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2007-02-26 18:21:27', 'AJM', '2007-03-04 20:36:49', 'AJM'),
('ord_requirement(list1)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2007-01-17 18:37:52', 'AJM', '2007-01-26 16:20:42', 'AJM'),
('shp_product_supplier(list2)b', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2007-02-26 22:46:30', 'AJM', '2007-03-04 20:37:04', 'AJM'),
('shp_reorder_guideline(list2)a', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2007-02-27 14:58:11', 'AJM', '2007-03-04 20:40:38', 'AJM'),
('shp_package(list2)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2007-04-16 20:46:50', 'AJM', '2007-04-22 17:01:32', 'AJM'),
('ord_request(list1)', 'audit_dtl(list)3', '009', 'Audit Trail', 'Y', '2007-01-19 16:53:51', 'AJM', '2007-01-25 11:50:47', 'AJM'),
('py_party_contact_mechanism_c(list2)', 'audit_dtl(list)3', '009', 'Audit Trail', 'Y', '2007-03-15 22:37:06', 'AJM', '2007-03-16 10:18:37', 'AJM'),
('py_party_relationship(list1)', 'audit_dtl(list)3', '009', 'Audit Trail', 'Y', '2007-02-09 18:34:45', 'AJM', '2007-02-17 16:14:29', 'AJM'),
('pro_prod_cat(list)', 'audit_dtl(list)3', '009', 'Audit Trail', 'Y', '2004-04-09 11:54:53', 'AJM', '2007-03-20 18:38:36', 'AJM'),
('shp_stockcheck_hdr(list1)', 'audit_dtl(list)3', '009', 'Audit Trail', 'Y', '2007-07-01 15:03:08', 'AJM', '2007-07-05 17:46:40', 'AJM'),
('pro_prod_feature_applicability(list)', 'audit_dtl(list)3', '009', 'Audit Trail', 'Y', '2004-04-09 12:01:07', 'AJM', '2007-03-11 14:00:12', 'AJM'),
('pro_prod_cat_class(list2)a', 'audit_dtl(list)3', '009', 'Audit Trail', 'Y', '2004-04-09 12:00:51', 'AJM', '2007-03-21 09:11:33', 'AJM'),
('dict_table(list)', 'audit_dtl(list)3', '009', 'Audit Trail', 'Y', '2005-06-10 12:43:33', 'AJM', '2006-10-01 11:27:01', 'AJM'),
('mnu_role(list)', 'audit_dtl(list)3', '010', 'Audit Trail', 'Y', '2004-04-09 11:37:40', 'AJM', '2007-05-05 22:43:07', 'AJM'),
('shp_shipment(list1)out2', 'audit_dtl(list)3', '010', 'Audit Trail', 'Y', '2007-05-03 13:55:01', 'AJM', '2007-07-03 11:21:21', 'AJM'),
('ord_order_role_s(list2)', 'audit_dtl(list)3', '010', 'Audit Trail', 'Y', '2007-03-09 16:38:26', 'AJM', '2007-06-26 11:42:05', 'AJM'),
('py_party_relationship(list2)', 'audit_dtl(list)3', '010', 'Audit Trail', 'Y', '2007-02-06 17:45:00', 'AJM', '2007-02-17 16:15:04', 'AJM'),
('shp_shipment(list1)out3', 'audit_dtl(list)3', '010', 'Audit Trail', 'Y', '2007-05-03 13:54:48', 'AJM', '2007-07-03 11:22:13', 'AJM'),
('dict_database(list)', 'audit_dtl(list)3', '010', 'Audit Trail', 'Y', '2005-03-12 19:07:33', 'AJM', '2005-12-10 12:33:03', 'AJM'),
('py_geographic_area(list1)', 'audit_dtl(list)3', '010', 'Audit Trail', 'Y', '2007-02-13 16:21:02', 'AJM', '2007-03-01 11:01:02', 'AJM'),
('py_geographic_area(list2)', 'audit_dtl(list)3', '010', 'Audit Trail', 'Y', '2007-02-11 22:46:37', 'AJM', '2007-03-01 11:01:24', 'AJM'),
('ord_order_role_p(list2)', 'audit_dtl(list)3', '010', 'Audit Trail', 'Y', '2007-03-09 18:13:24', 'AJM', '2007-06-26 11:40:57', 'AJM'),
('py_contact_mechanism(list1)', 'audit_dtl(list)3', '010', 'Audit Trail', 'Y', '2007-02-20 17:26:08', 'AJM', '2007-03-23 20:13:30', 'AJM'),
('shp_shipment(list1)out1', 'audit_dtl(list)3', '011', 'Audit Trail', 'Y', '2007-05-03 13:55:12', 'AJM', '2007-07-03 11:19:55', 'AJM'),
('dict_table(list)2', 'audit_dtl(list)3', '011', 'Audit Trail', 'Y', '2005-03-12 23:12:27', 'AJM', '2006-10-01 11:27:45', 'AJM'),
('mnu_user(list)', 'audit_dtl(list)3', '011', 'Audit Trail', 'Y', '2004-04-09 11:39:20', 'AJM', '2007-05-27 10:45:00', 'AJM'),
('shp_item_issuance(list2)a', 'audit_dtl(list)3', '011', 'Audit Trail', 'Y', '2007-04-10 17:19:56', 'AJM', '2007-04-18 11:44:34', 'AJM'),
('py_party_contact_mechanism(list2)a', 'audit_dtl(list)3', '011', 'Audit Trail', 'Y', '2007-02-21 11:20:19', 'AJM', '2007-03-24 13:41:57', 'AJM'),
('shp_inventory_item(list2)a', 'audit_dtl(list)3', '011', 'Audit Trail', 'Y', '2006-07-03 17:08:50', 'AJM', '2007-04-23 11:53:37', 'AJM'),
('ord_invoice_header(list1)', 'audit_dtl(list)3', '011', 'Audit Trail', 'Y', '2007-04-26 19:40:57', 'AJM', '2007-05-01 11:50:13', 'AJM'),
('shp_inventory_item(list2)b', 'audit_dtl(list)3', '011', 'Audit Trail', 'Y', '2006-07-04 16:47:28', 'AJM', '2007-04-23 11:53:59', 'AJM'),
('ord_invoice_item(list2)', 'audit_dtl(list)3', '011', 'Audit Trail', 'Y', '2007-04-27 16:55:29', 'AJM', '2007-05-01 11:54:02', 'AJM'),
('ord_order_header_p(list1)inactive', 'audit_dtl(list)3', '012', 'Audit Trail', 'Y', '2007-06-26 13:48:27', 'AJM', '2007-06-26 13:52:12', 'AJM'),
('mnu_subsystem(list)', 'audit_dtl(list)3', '012', 'Audit Trail', 'Y', '2004-04-09 11:37:58', 'AJM', '2006-09-28 11:11:15', 'AJM'),
('py_person(list1)', 'audit_dtl(list)3', '012', 'Audit Trail', 'Y', '2007-02-01 16:49:36', 'AJM', '2007-02-21 11:26:58', 'AJM'),
('py_party(list1)', 'audit_dtl(list)3', '012', 'Audit Trail', 'Y', '2007-01-31 10:55:00', 'AJM', '2007-04-13 18:25:19', 'AJM'),
('shp_picklist_hdr(list1)', 'audit_dtl(list)3', '012', 'Audit Trail', 'Y', '2007-05-23 14:03:50', 'AJM', '2007-05-24 13:20:47', 'AJM'),
('mnu_task(list)b', 'audit_dtl(list)3', '012', 'Audit Trail', 'Y', '2004-04-08 16:27:07', 'AJM', NULL, NULL),
('ord_order_header_p(list1)tba', 'audit_dtl(list)3', '012', 'Audit Trail', 'Y', '2007-06-26 13:48:27', 'AJM', '2007-06-26 18:12:55', 'AJM'),
('ord_order_header_t(list1)tba', 'audit_dtl(list)3', '012', 'Audit Trail', 'Y', '2007-06-26 13:48:27', 'AJM', '2007-06-28 17:19:02', 'AJM'),
('ord_order_header_t(list1)inactive', 'audit_dtl(list)3', '012', 'Audit Trail', 'Y', '2007-06-26 13:48:27', 'AJM', '2007-06-26 14:13:40', 'AJM'),
('ord_order_header_p(list1)', 'audit_dtl(list)3', '013', 'Audit Trail', 'Y', '2007-03-05 18:07:52', 'AJM', '2007-06-25 16:59:45', 'AJM'),
('ord_order_header_t(list1)', 'audit_dtl(list)3', '013', 'Audit Trail', 'Y', '2007-06-24 18:46:54', 'AJM', '2007-06-25 17:00:26', 'AJM'),
('wf_workflow(list)', 'audit_dtl(list)3', '013', 'Audit Trail', 'Y', '2004-04-09 11:57:37', 'AJM', '2004-04-26 14:14:18', 'AJM'),
('ord_order_item_s(list2)', 'audit_dtl(list)3', '014', 'Audit Trail', 'Y', '2007-03-05 18:05:38', 'AJM', '2007-06-25 14:10:56', 'AJM'),
('shp_inventory_item(list1)', 'audit_dtl(list)3', '014', 'Audit Trail', 'Y', '2006-07-03 10:25:29', 'AJM', '2007-05-21 16:30:22', 'AJM'),
('shp_facility(list1)', 'audit_dtl(list)3', '014', 'Audit Trail', 'Y', '2006-06-30 17:43:33', 'AJM', '2007-06-21 17:36:41', 'AJM'),
('pro_product(list)', 'audit_dtl(list)3', '015', 'Audit Trail', 'Y', '2004-04-09 11:54:41', 'AJM', '2007-05-15 10:06:27', 'AJM'),
('ord_order_header_s(list1)inactive', 'audit_dtl(list)3', '015', 'Audit Trail', 'Y', '2007-03-05 17:30:14', 'AJM', '2007-06-22 11:24:52', 'AJM'),
('ord_order_header_s(list1)tba', 'audit_dtl(list)3', '015', 'Audit Trail', 'Y', '2007-03-05 17:30:14', 'AJM', '2007-06-22 11:24:52', 'AJM'),
('ord_order_header_s(list1)', 'audit_dtl(list)3', '017', 'Audit Trail', 'Y', '2007-03-05 17:30:14', 'AJM', '2007-06-22 10:34:43', 'AJM'),
('py_organisation(list1)', 'audit_dtl(list)3', '018', 'Audit Trail', 'Y', '2007-02-01 16:49:11', 'AJM', '2007-06-26 11:15:42', 'AJM'),
('mnu_task(list)a', 'audit_dtl(list)3', '019', 'Audit Trail', 'Y', '2004-04-09 11:38:58', 'AJM', '2007-05-27 10:55:07', 'AJM'),
('mnu_task(list)', 'audit_dtl(list)3', '022', 'Audit Trail', 'Y', '2004-04-09 11:38:19', 'AJM', '2007-05-27 10:52:49', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'audit_dtl(list)3', '2005-04-19 18:09:05', 'AJM', NULL, NULL),
('DEV', 'audit_dtl(list)3', '2005-05-02 10:16:34', 'AJM', NULL, NULL),
('GLOBAL', 'audit_dtl(list)3', '2005-05-02 10:16:34', 'AJM', NULL, NULL),
('READONLY', 'audit_dtl(list)3', '2005-05-02 10:16:34', 'AJM', NULL, NULL),
('SURVEY', 'audit_dtl(list)3', '2005-05-02 10:16:34', 'AJM', NULL, NULL),
('USER1', 'audit_dtl(list)3', '2005-05-02 10:16:34', 'AJM', NULL, NULL),
('USER2', 'audit_dtl(list)3', '2005-05-02 10:16:34', 'AJM', NULL, NULL),
('USER3', 'audit_dtl(list)3', '2005-05-02 10:16:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('audit_dtl(list)3exact', 'List Audit Details for an Object (exact match)', 'Audit Trail', 'PROC', 'audit_dtl_list3.php', 'N', 'LIST3', 'AUDIT', NULL, NULL, NULL, 'pattern=exact', NULL, 'N', 'N', NULL, 'N', '2004-07-21 16:54:14', 'AJM', '2006-06-20 14:53:08', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('dict_database(list)2', 'audit_dtl(list)3exact', '007', 'Audit Trail (exact)', 'Y', '2005-03-12 19:08:37', 'AJM', '2005-03-12 22:54:26', 'AJM'),
('dict_database(list)', 'audit_dtl(list)3exact', '011', 'Audit Trail (exact)', 'Y', '2005-03-12 19:07:33', 'AJM', '2005-12-10 12:33:03', 'AJM'),
('dict_table(list)2', 'audit_dtl(list)3exact', '012', 'Audit Trail (exact)', 'Y', '2005-03-12 23:45:26', 'AJM', '2006-10-01 11:27:45', 'AJM'),
('wf_workflow(list)', 'audit_dtl(list)3exact', '014', 'Audit Trail (2)', 'Y', '2004-07-21 16:56:01', 'AJM', '2004-07-21 16:56:42', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'audit_dtl(list)3exact', '2005-04-19 18:09:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('audit_dtl(search)', 'Search Audit Detail', 'Search', 'PROC', 'audit_dtl_search.php', 'N', 'SRCH', 'AUDIT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2006-01-17 20:28:38', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('audit_dtl(list)2', 'audit_dtl(search)', '003', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-06-23 13:41:47', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'audit_dtl(search)', '2005-04-19 18:09:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('audit_logon_errors(list)', 'List Logon Errors', 'Logon Errors', 'PROC', 'audit_logon_errors_list.php', 'N', 'LIST1', 'AUDIT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-03-08 14:52:07', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('audit_logon_errors(list)', 'audit_logon_errors(search)', '001', 'Search', 'N', '2006-03-08 15:27:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('menu', 'audit_logon_errors(list)', '003', 'Logon Errors', 'N', '2006-03-08 14:52:45', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'audit_logon_errors(list)', '2006-04-07 14:24:33', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('audit_logon_errors(search)', 'Search Logon Errors', 'Search', 'PROC', 'audit_logon_errors_search.php', 'N', 'SRCH', 'AUDIT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-03-08 15:27:14', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('audit_logon_errors(list)', 'audit_logon_errors(search)', '001', 'Search', 'N', '2006-03-08 15:27:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'audit_logon_errors(search)', '2006-04-07 14:24:33', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('audit_tbl(upd4)', 'Generate SQL', 'Generate SQL', 'PROC', 'audit_tbl(upd4).php', 'N', 'UPD4', 'AUDIT', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2007-06-23 13:39:36', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('audit_dtl(list)2', 'audit_tbl(upd4)', '003', 'Generate SQL', 'N', '2007-06-23 13:41:06', 'AJM', NULL, NULL);

REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('main_menu', 'audit_dtl(list)2', '004', 'Audit', '2003-01-01 12:00:00', 'AJM', '2005-06-12 12:17:52', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('audit_dtl(list)2', 'This will list entries from the Audit Log.

Refer to <a href=\"%root%/audit_dtl(list)2.html\">List Audit Details</a> for full details.', '2005-06-29 12:41:45', 'AJM', '2005-07-02 15:33:45', 'AJM'),
('audit_dtl(list)3', 'This will allow the contents of the Audit Log to be viewed for selected objects.

This version will select those Audit Log entries where the the primary key of the selected object is contained with the PKEY value of the audited occurrence. This will include entries from subordinate (child) tables which contain the same field names within their primary keys.

Refer to <a href=\"%root%/audit_dtl(list)3.html\">List Audit Details for a selected Object</a> for full details.', '2005-06-29 13:03:54', 'AJM', '2005-07-02 15:33:52', 'AJM'),
('audit_dtl(list)3exact', 'This will allow the contents of the Audit Log to be viewed for selected objects.

This version will select only those Audit Log entries where the the primary key of the selected object is as exact match with the PKEY value of the audited occurrence. 

Refer to <a href=\"%root%/audit_dtl(list)3.html\">List Audit Details for a selected Object</a> for full details.', '2005-06-29 16:17:59', 'AJM', '2005-07-02 15:34:01', 'AJM'),
('audit_dtl(search)', 'This will allow selection criteria to be entered before passing control back to the List Audit Detail screen.

Refer to <a href=\"%root%/audit_dtl(search).html\">Search Audit Details</a> for full details.', '2005-06-29 12:37:59', 'AJM', '2005-07-02 15:34:07', 'AJM'),
('audit_logon_errors(list)', 'This will show the details of any logon attemps which failed.

Refer to <a href=\"%root%/audit_logon_errors(list).html\">List Logon Errors</a> for full details.', '2006-04-07 11:26:07', 'AJM', NULL, NULL);

-- finished
