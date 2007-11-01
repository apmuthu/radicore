-- file created on July 12, 2007, 6:55 pm
    
REPLACE INTO `mnu_subsystem` (`subsys_id`, `subsys_desc`, `subsys_dir`, `task_prefix`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('MISC', 'Miscellaneous Tasks', 'menu', NULL, '2004-04-17 17:12:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('date(current)', 'Select Records with Current Dates', 'Current', 'PROC', 'date_current.php', 'N', 'OTHER', 'MISC', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-04-17 17:14:09', 'AJM', '2007-01-10 18:22:11', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('py_contact_mechanism(list2)b', 'date(current)', '001', 'Current', 'N', '2007-03-16 14:24:53', 'AJM', NULL, NULL),
('wf_case(list)', 'date(current)', '002', 'Current', 'N', '2004-04-25 11:44:54', 'AJM', '2004-04-25 11:45:10', 'AJM'),
('pro_prod_feature(popup)jnr', 'date(current)', '002', 'Current', 'N', '2007-03-29 17:52:05', 'AJM', NULL, NULL),
('pro_prod_feature_applicability(popup2)', 'date(current)', '002', 'Current', 'N', '2007-03-07 18:35:06', 'AJM', NULL, NULL),
('pro_prod_feature(popup)snr', 'date(current)', '002', 'Current', 'N', '2007-03-29 17:52:36', 'AJM', NULL, NULL),
('py_party_contact_mech_purpose(multi2)', 'date(current)', '003', 'Current', 'N', '2007-02-22 17:07:31', 'AJM', NULL, NULL),
('py_party_subclass_link(multi2)a', 'date(current)', '003', 'Current', 'N', '2007-02-05 13:53:43', 'AJM', NULL, NULL),
('py_party_role_link(multi2)a', 'date(current)', '003', 'Current', 'N', '2007-02-05 17:22:17', 'AJM', NULL, NULL),
('wf_case(list)2', 'date(current)', '003', 'Current', 'N', '2004-04-26 14:50:45', 'AJM', NULL, NULL),
('pro_product(popup)', 'date(current)', '003', 'Current', 'N', '2007-03-11 15:12:50', 'AJM', NULL, NULL),
('py_party_contact_mechanism(list2)b', 'date(current)', '004', 'Current', 'N', '2007-02-25 18:11:02', 'AJM', NULL, NULL),
('pro_product(list2)', 'date(current)', '005', 'Current', 'N', '2007-03-11 14:53:42', 'AJM', NULL, NULL),
('shp_reorder_guideline(list2)a', 'date(current)', '006', 'Current', 'N', '2007-02-27 15:13:12', 'AJM', '2007-03-04 20:40:38', 'AJM'),
('pro_prod_feature_applicability(list)', 'date(current)', '006', 'Current', 'N', '2004-05-18 16:38:21', 'AJM', '2007-03-05 18:54:42', 'AJM'),
('shp_product_supplier(list2)a', 'date(current)', '006', 'Current', 'N', '2007-02-28 11:36:30', 'AJM', '2007-03-04 20:36:49', 'AJM'),
('shp_product_supplier(list2)b', 'date(current)', '006', 'Current', 'N', '2007-02-28 11:36:54', 'AJM', '2007-03-04 20:37:04', 'AJM'),
('pro_price_component_k(list2)', 'date(current)', '007', 'Current', 'N', '2007-03-25 18:24:07', 'AJM', NULL, NULL),
('shp_facility_contact_mechanism(list2)b', 'date(current)', '007', 'Current', 'N', '2007-02-25 18:33:41', 'AJM', '2007-03-04 19:07:57', 'AJM'),
('pro_price_component_h(list2)', 'date(current)', '007', 'Current', 'N', '2007-03-25 18:26:28', 'AJM', NULL, NULL),
('shp_facility_contact_mechanism(list2)a', 'date(current)', '007', 'Current', 'N', '2007-02-25 16:36:13', 'AJM', '2007-03-04 19:07:42', 'AJM'),
('pro_price_component(list1)', 'date(current)', '007', 'Current', 'N', '2007-03-03 15:20:32', 'AJM', NULL, NULL),
('pro_prod_cat_class(list2)a', 'date(current)', '007', 'Current', 'N', '2007-02-27 15:43:12', 'AJM', '2007-03-21 09:11:33', 'AJM'),
('pro_price_component_j(list2)', 'date(current)', '007', 'Current', 'N', '2007-03-25 18:23:51', 'AJM', NULL, NULL),
('pro_price_component_l(list2)', 'date(current)', '007', 'Current', 'N', '2007-03-26 19:44:01', 'AJM', NULL, NULL),
('pro_price_component_g(list2)', 'date(current)', '007', 'Current', 'N', '2007-03-02 16:17:04', 'AJM', '2007-03-25 18:26:17', 'AJM'),
('pro_price_component_f(list2)', 'date(current)', '007', 'Current', 'N', '2007-03-02 11:15:27', 'AJM', '2007-03-25 18:26:07', 'AJM'),
('pro_price_component_e(list2)', 'date(current)', '007', 'Current', 'N', '2007-03-02 19:19:16', 'AJM', '2007-03-25 18:25:48', 'AJM'),
('pro_price_component_discount(list1)', 'date(current)', '007', 'Current', 'N', '2007-07-07 18:39:44', 'AJM', NULL, NULL),
('pro_price_component_i(list2)', 'date(current)', '007', 'Current', 'N', '2007-07-07 18:37:17', 'AJM', NULL, NULL),
('py_organisation(list1)', 'date(current)', '007', 'Current', 'N', '2007-02-02 19:07:08', 'AJM', NULL, NULL),
('py_party_contact_mechanism_c(list2)', 'date(current)', '007', 'Current', 'N', '2007-03-15 23:35:14', 'AJM', '2007-03-16 10:18:37', 'AJM'),
('py_party_relationship(list1)', 'date(current)', '007', 'Current', 'N', '2007-02-09 18:45:35', 'AJM', NULL, NULL),
('py_party_relationship(list2)', 'date(current)', '007', 'Current', 'N', '2007-02-07 19:45:51', 'AJM', NULL, NULL),
('py_party(list1)', 'date(current)', '007', 'Current', 'N', '2007-02-03 11:33:07', 'AJM', NULL, NULL),
('py_person(list1)', 'date(current)', '007', 'Current', 'N', '2007-02-02 19:11:32', 'AJM', NULL, NULL),
('pro_price_component_a(list2)', 'date(current)', '007', 'Current', 'N', '2004-04-17 17:20:19', 'AJM', '2007-03-25 18:25:01', 'AJM'),
('pro_price_component_b(list2)', 'date(current)', '007', 'Current', 'N', '2004-04-17 17:20:58', 'AJM', '2007-03-25 18:25:15', 'AJM'),
('pro_price_component_c(list2)', 'date(current)', '007', 'Current', 'N', '2004-04-17 17:21:26', 'AJM', '2007-03-25 18:25:27', 'AJM'),
('pro_price_component_d(list2)', 'date(current)', '007', 'Current', 'N', '2007-02-28 14:35:40', 'AJM', '2007-03-25 18:25:38', 'AJM'),
('py_party_contact_mechanism(list2)a', 'date(current)', '009', 'Current', 'N', '2007-02-21 11:22:57', 'AJM', '2007-03-24 13:41:57', 'AJM'),
('wf_workflow(list)', 'date(current)', '010', 'Current', 'N', '2004-04-17 18:27:51', 'AJM', '2004-04-17 18:28:13', 'AJM'),
('pro_product(list)', 'date(current)', '012', 'Current', 'N', '2007-03-11 14:53:11', 'AJM', '2007-05-15 10:06:27', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('date(future)', 'Select Records with Future Dates', 'Future', 'PROC', 'date_future.php', 'N', 'OTHER', 'MISC', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-04-17 17:15:38', 'AJM', '2007-01-10 18:22:22', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('date(historic)', 'Select Records with Historic Dates', 'Historic', 'PROC', 'date_historic.php', 'N', 'OTHER', 'MISC', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-04-17 17:15:01', 'AJM', '2007-01-10 18:22:33', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('py_contact_mechanism(list2)b', 'date(historic)', '002', 'Historic', 'N', '2007-03-16 14:24:53', 'AJM', NULL, NULL),
('wf_case(list)', 'date(historic)', '003', 'Historic', 'N', '2004-04-25 11:44:54', 'AJM', '2004-04-25 11:45:10', 'AJM'),
('pro_prod_feature(popup)jnr', 'date(historic)', '003', 'Historic', 'N', '2007-03-29 17:52:05', 'AJM', NULL, NULL),
('pro_prod_feature_applicability(popup2)', 'date(historic)', '003', 'Historic', 'N', '2007-03-07 18:35:06', 'AJM', NULL, NULL),
('pro_prod_feature(popup)snr', 'date(historic)', '003', 'Historic', 'N', '2007-03-29 17:52:36', 'AJM', NULL, NULL),
('py_party_contact_mech_purpose(multi2)', 'date(historic)', '004', 'Historic', 'N', '2007-02-22 17:07:31', 'AJM', NULL, NULL),
('py_party_subclass_link(multi2)a', 'date(historic)', '004', 'Historic', 'N', '2007-02-05 13:53:43', 'AJM', NULL, NULL),
('py_party_role_link(multi2)a', 'date(historic)', '004', 'Historic', 'N', '2007-02-05 17:22:17', 'AJM', NULL, NULL),
('wf_case(list)2', 'date(historic)', '004', 'Historic', 'N', '2004-04-26 14:50:45', 'AJM', NULL, NULL),
('pro_product(popup)', 'date(historic)', '004', 'Historic', 'N', '2007-03-11 15:12:50', 'AJM', NULL, NULL),
('py_party_contact_mechanism(list2)b', 'date(historic)', '005', 'Historic', 'N', '2007-02-25 18:11:02', 'AJM', NULL, NULL),
('pro_product(list2)', 'date(historic)', '006', 'Historic', 'N', '2007-03-11 14:53:43', 'AJM', NULL, NULL),
('shp_reorder_guideline(list2)a', 'date(historic)', '007', 'Historic', 'N', '2007-02-27 15:13:12', 'AJM', '2007-03-04 20:40:38', 'AJM'),
('pro_prod_feature_applicability(list)', 'date(historic)', '007', 'Historic', 'N', '2004-05-18 16:38:21', 'AJM', '2007-03-05 18:54:42', 'AJM'),
('shp_product_supplier(list2)a', 'date(historic)', '007', 'Historic', 'N', '2007-02-28 11:36:31', 'AJM', '2007-03-04 20:36:49', 'AJM'),
('shp_product_supplier(list2)b', 'date(historic)', '007', 'Historic', 'N', '2007-02-28 11:36:55', 'AJM', '2007-03-04 20:37:04', 'AJM'),
('pro_price_component_k(list2)', 'date(historic)', '008', 'Historic', 'N', '2007-03-25 18:24:07', 'AJM', NULL, NULL),
('shp_facility_contact_mechanism(list2)b', 'date(historic)', '008', 'Historic', 'N', '2007-02-25 18:33:41', 'AJM', '2007-03-04 19:07:57', 'AJM'),
('pro_price_component_h(list2)', 'date(historic)', '008', 'Historic', 'N', '2007-03-25 18:26:28', 'AJM', NULL, NULL),
('shp_facility_contact_mechanism(list2)a', 'date(historic)', '008', 'Historic', 'N', '2007-02-25 16:36:13', 'AJM', '2007-03-04 19:07:43', 'AJM'),
('pro_price_component(list1)', 'date(historic)', '008', 'Historic', 'N', '2007-03-03 15:20:32', 'AJM', NULL, NULL),
('pro_prod_cat_class(list2)a', 'date(historic)', '008', 'Historic', 'N', '2007-02-27 15:43:12', 'AJM', '2007-03-21 09:11:33', 'AJM'),
('pro_price_component_j(list2)', 'date(historic)', '008', 'Historic', 'N', '2007-03-25 18:23:51', 'AJM', NULL, NULL),
('pro_price_component_l(list2)', 'date(historic)', '008', 'Historic', 'N', '2007-03-26 19:44:01', 'AJM', NULL, NULL),
('pro_price_component_g(list2)', 'date(historic)', '008', 'Historic', 'N', '2007-03-02 16:17:04', 'AJM', '2007-03-25 18:26:17', 'AJM'),
('pro_price_component_f(list2)', 'date(historic)', '008', 'Historic', 'N', '2007-03-02 11:15:27', 'AJM', '2007-03-25 18:26:07', 'AJM'),
('pro_price_component_e(list2)', 'date(historic)', '008', 'Historic', 'N', '2007-03-02 19:19:16', 'AJM', '2007-03-25 18:25:48', 'AJM'),
('pro_price_component_discount(list1)', 'date(historic)', '008', 'Historic', 'N', '2007-07-07 18:39:55', 'AJM', NULL, NULL),
('pro_price_component_i(list2)', 'date(historic)', '008', 'Historic', 'N', '2007-07-07 18:37:17', 'AJM', NULL, NULL),
('py_organisation(list1)', 'date(historic)', '008', 'Historic', 'N', '2007-02-02 19:07:08', 'AJM', NULL, NULL),
('py_party_contact_mechanism_c(list2)', 'date(historic)', '008', 'Historic', 'N', '2007-03-15 23:35:14', 'AJM', '2007-03-16 10:18:37', 'AJM'),
('py_party_relationship(list1)', 'date(historic)', '008', 'Historic', 'N', '2007-02-09 18:45:35', 'AJM', NULL, NULL),
('py_party_relationship(list2)', 'date(historic)', '008', 'Historic', 'N', '2007-02-07 19:45:51', 'AJM', NULL, NULL),
('py_party(list1)', 'date(historic)', '008', 'Historic', 'N', '2007-02-03 11:33:07', 'AJM', NULL, NULL),
('py_person(list1)', 'date(historic)', '008', 'Historic', 'N', '2007-02-02 19:11:32', 'AJM', NULL, NULL),
('pro_price_component_a(list2)', 'date(historic)', '008', 'Historic', 'N', '2004-04-17 17:20:19', 'AJM', '2007-03-25 18:25:01', 'AJM'),
('pro_price_component_b(list2)', 'date(historic)', '008', 'Historic', 'N', '2004-04-17 17:20:58', 'AJM', '2007-03-25 18:25:15', 'AJM'),
('pro_price_component_c(list2)', 'date(historic)', '008', 'Historic', 'N', '2004-04-17 17:21:26', 'AJM', '2007-03-25 18:25:28', 'AJM'),
('pro_price_component_d(list2)', 'date(historic)', '008', 'Historic', 'N', '2007-02-28 14:35:41', 'AJM', '2007-03-25 18:25:38', 'AJM'),
('py_party_contact_mechanism(list2)a', 'date(historic)', '010', 'Historic', 'N', '2007-02-21 11:22:57', 'AJM', '2007-03-24 13:41:57', 'AJM'),
('wf_workflow(list)', 'date(historic)', '011', 'Historic', 'N', '2004-04-17 18:27:51', 'AJM', '2004-04-17 18:28:14', 'AJM'),
('pro_product(list)', 'date(historic)', '013', 'Historic', 'N', '2007-03-11 14:53:11', 'AJM', '2007-05-15 10:06:27', 'AJM');

-- finished
