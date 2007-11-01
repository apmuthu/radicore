-- file created on March 26, 2007, 5:02 pm
    
REPLACE INTO `mnu_subsystem` (`subsys_id`, `subsys_desc`, `subsys_dir`, `task_prefix`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('CRSS', 'Classroom Scheduling System', 'classroom', 'crs_', '2004-12-19 15:51:55', 'AJM', '2006-04-22 09:38:27', 'AJM');

REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'Demonstration Class', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('READONLY', 'Read Only', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_class_lesson(add)a', 'Add Lesson(s) to selected Class', 'Insert', 'PROC', 'class_lesson_add(a).php', 'N', 'ADD3', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-26 11:00:29', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_class_lesson(add)b', 'Add Class(es) to selected Lesson', 'Insert', 'PROC', 'class_lesson_add(b).php', 'N', 'ADD3', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-26 11:01:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_class_lesson(del)', 'Delete from Class/Lesson cross-reference', 'Delete', 'PROC', 'class_lesson_del.php', 'N', 'DEL2', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-26 11:02:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_class(add)', 'Add Class', 'New', 'PROC', 'class_add.php', 'N', 'ADD1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-25 19:51:11', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_class(del)', 'Delete Class', 'Delete', 'PROC', 'class_del.php', 'N', 'DEL1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-25 19:51:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_class(enq)', 'Enquire Class', 'Read', 'PROC', 'class_enq.php', 'N', 'ENQ1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-25 19:51:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_class(enq)', '2005-04-19 18:44:36', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_class(list)', 'List Class', 'Classes', 'PROC', 'class_list.php', 'N', 'LIST1', 'CRSS', NULL, NULL, NULL, NULL, 'class_name', 'N', NULL, NULL, 'N', '2004-12-25 19:50:11', 'AJM', '2004-12-26 10:38:06', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_class(list)', 'crs_class(add)', '001', 'New', 'N', '2004-12-25 19:56:00', 'AJM', NULL, NULL),
('crs_class(list)', 'crs_class(enq)', '002', 'Read', 'Y', '2004-12-25 19:56:00', 'AJM', '2005-01-01 16:23:12', 'AJM'),
('crs_class(list)', 'crs_class(upd)', '003', 'Update', 'Y', '2004-12-25 19:56:00', 'AJM', '2005-01-01 16:23:12', 'AJM'),
('crs_class(list)', 'crs_class(del)', '004', 'Delete', 'Y', '2004-12-25 19:56:00', 'AJM', '2005-01-01 16:23:12', 'AJM'),
('crs_class(list)', 'crs_class(search)', '005', 'Search', 'N', '2004-12-25 19:56:00', 'AJM', '2005-01-01 16:23:12', 'AJM'),
('crs_class(list)', 'crs_lesson(list)b', '006', 'Lessons', 'Y', '2004-12-26 10:44:31', 'AJM', NULL, NULL),
('crs_class(list)', 'crs_student(list)b', '007', 'Students', 'Y', '2004-12-26 11:34:29', 'AJM', NULL, NULL),
('crs_class(list)', 'crs_schedule(list)class', '008', 'Show Schedule', 'Y', '2005-02-26 11:08:36', 'AJM', '2005-02-26 11:09:53', 'AJM'),
('crs_class(list)', 'audit_dtl(list)3', '009', 'Audit Trail', 'Y', '2004-12-26 11:34:51', 'AJM', '2005-02-26 11:09:53', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_class(list)', '2005-01-15 18:48:43', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_class(list)a', 'List Classes For a Lesson', 'Classes', 'PROC', 'class_list(a).php', 'N', 'LIST2', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-26 11:24:46', 'AJM', '2005-01-06 19:21:36', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_class(list)a', 'crs_student(list)b', '001', 'Students', 'Y', '2005-01-30 15:28:41', 'AJM', NULL, NULL),
('crs_class(list)a', 'crs_class_lesson(add)b', '002', 'New Class', 'N', '2005-01-30 17:02:10', 'AJM', '2005-01-30 17:02:53', 'AJM'),
('crs_class(list)a', 'crs_class_lesson(del)', '003', 'Delete Class', 'Y', '2005-01-30 17:02:10', 'AJM', '2005-01-30 17:02:53', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_class(list)a', '2005-01-15 18:48:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_class(popup)', 'Choose Class', 'Choose', 'PROC', 'class_popup.php', 'N', 'POPUP1', 'CRSS', NULL, NULL, NULL, NULL, 'class_name', 'N', 'N', NULL, 'N', '2005-01-30 17:07:19', 'AJM', '2007-03-05 17:34:28', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_class(popup)', '2005-04-19 18:44:07', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_class(search)', 'Search Class', 'Search', 'PROC', 'class_search.php', 'N', 'SRCH', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-25 19:52:43', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_class(search)', '2005-04-19 18:44:36', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_class(upd)', 'Update Class', 'Update', 'PROC', 'class_upd.php', 'N', 'UPD1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-25 19:52:20', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_confict(list)', 'List Lesson Conflicts', 'Conflicts', 'PROC', 'conflict_list.php', 'N', 'LIST1', 'CRSS', NULL, NULL, NULL, NULL, 'conflict_id', 'N', NULL, NULL, 'N', '2005-01-01 17:57:41', 'AJM', '2005-01-01 20:05:47', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_confict(list)', 'crs_confict(reset)', '001', 'Update', 'N', '2005-01-01 18:15:12', 'AJM', '2005-01-01 20:55:16', 'AJM'),
('crs_confict(list)', 'crs_conflict(search)', '002', 'Search', 'N', '2005-01-02 16:48:16', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_confict(list)', '2005-04-19 18:44:49', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_confict(reset)', 'Reset Lesson Conflicts', 'Reset', 'PROC', 'conflict_reset.php', 'N', 'ADD4', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-01-01 18:14:48', 'AJM', '2005-01-02 15:58:21', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_conflict(search)', 'Search Conflict', 'Search', 'PROC', 'conflict_search.php', 'N', 'SRCH', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-01-02 16:47:51', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_conflict(search)', '2005-04-19 18:44:49', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_lesson(add)', 'Add Lesson', 'New', 'PROC', 'lesson_add.php', 'N', 'ADD1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-21 18:29:29', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_lesson(del)', 'Delete Lesson', 'Delete', 'PROC', 'lesson_del.php', 'N', 'DEL1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-21 18:29:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_lesson(enq)', 'Enquire Lesson', 'Read', 'PROC', 'lesson_enq.php', 'N', 'ENQ1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-21 18:30:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_lesson(enq)', '2005-04-19 18:44:07', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_lesson(list)', 'List Lesson', 'Lessons', 'PROC', 'lesson_list.php', 'N', 'LIST1', 'CRSS', NULL, NULL, NULL, NULL, 'lesson_name', 'N', NULL, NULL, 'N', '2004-12-21 18:28:37', 'AJM', '2004-12-25 10:00:51', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_lesson(list)', 'crs_lesson(add)', '001', 'New', 'N', '2004-12-21 18:31:49', 'AJM', NULL, NULL),
('crs_lesson(list)', 'crs_lesson(enq)', '002', 'Read', 'Y', '2004-12-21 18:31:49', 'AJM', '2005-01-01 16:23:55', 'AJM'),
('crs_lesson(list)', 'crs_lesson(upd)', '003', 'Update', 'Y', '2004-12-21 18:31:49', 'AJM', '2005-01-01 16:23:55', 'AJM'),
('crs_lesson(list)', 'crs_lesson(del)', '004', 'Delete', 'Y', '2004-12-21 18:31:49', 'AJM', '2005-01-01 16:23:55', 'AJM'),
('crs_lesson(list)', 'crs_lesson(search)', '005', 'Search', 'N', '2004-12-21 18:31:49', 'AJM', NULL, NULL),
('crs_lesson(list)', 'crs_class(list)a', '006', 'Classes', 'Y', '2004-12-26 11:44:31', 'AJM', '2004-12-26 11:44:51', 'AJM'),
('crs_lesson(list)', 'crs_student(list)a', '007', 'Students', 'Y', '2004-12-25 11:33:07', 'AJM', '2004-12-26 11:44:51', 'AJM'),
('crs_lesson(list)', 'crs_schedule(list)lesson', '008', 'Show Schedule', 'Y', '2005-02-26 16:09:46', 'AJM', '2005-02-26 16:10:26', 'AJM'),
('crs_lesson(list)', 'audit_dtl(list)3', '009', 'Audit Trail', 'Y', '2004-12-25 11:09:37', 'AJM', '2005-02-26 16:10:00', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_lesson(list)', '2005-04-19 18:44:07', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_lesson(list)a', 'List Lessons For a Student', 'Lessons', 'PROC', 'lesson_list(a).php', 'N', 'LIST2', 'CRSS', NULL, NULL, NULL, NULL, 'lesson_name', 'N', NULL, NULL, 'N', '2004-12-24 17:05:25', 'AJM', '2004-12-25 11:57:18', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_lesson(list)a', 'crs_student_lesson(add)a', '001', 'New', 'N', '2004-12-24 17:28:05', 'AJM', '2006-07-13 18:36:09', 'AJM'),
('crs_lesson(list)a', 'crs_student_lesson(del)', '002', 'Delete', 'Y', '2004-12-24 17:28:05', 'AJM', NULL, NULL),
('crs_lesson(list)a', 'crs_lesson(search)', '003', 'Search', 'N', '2004-12-24 17:28:21', 'AJM', NULL, NULL),
('crs_lesson(list)a', 'crs_schedule(list)student', '004', 'Show Schedule', 'N', '2005-02-26 15:42:50', 'AJM', '2005-02-26 15:42:54', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_lesson(list)a', '2005-04-19 18:44:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_lesson(list)b', 'List Lessons For a Class', 'Lessons', 'PROC', 'lesson_list(b).php', 'N', 'LIST2', 'CRSS', NULL, NULL, NULL, NULL, 'lesson_name', 'N', NULL, NULL, 'N', '2004-12-26 10:43:36', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_lesson(list)b', 'crs_class_lesson(add)a', '001', 'New', 'N', '2004-12-26 11:03:18', 'AJM', '2006-07-13 18:36:16', 'AJM'),
('crs_lesson(list)b', 'crs_class_lesson(del)', '002', 'Delete', 'Y', '2004-12-26 11:03:18', 'AJM', NULL, NULL),
('crs_lesson(list)b', 'crs_lesson(search)', '003', 'Search', 'N', '2004-12-26 11:03:18', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_lesson(list)b', '2005-04-19 18:44:36', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_lesson(list)c', 'List Lessons For a Teacher', 'Lessons', 'PROC', 'lesson_list(c).php', 'N', 'LIST2', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-27 18:11:53', 'AJM', '2005-01-06 18:53:43', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_lesson(list)c', 'crs_class(list)a', '001', 'Classes', 'Y', '2005-01-30 16:46:40', 'AJM', NULL, NULL),
('crs_lesson(list)c', 'crs_student(list)a', '002', 'Students', 'Y', '2005-01-30 16:47:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_lesson(list)c', '2005-04-19 18:44:49', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_lesson(list)d', 'List Lessons For a Subject', 'Lessons', 'PROC', 'lesson_list(d).php', 'N', 'LIST2', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-07-28 14:33:17', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_lesson(list)d', '2006-04-07 17:24:51', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_lesson(popup)', 'Choose Lesson', 'Lessons', 'PROC', 'lesson_popup.php', 'N', 'POPUP1', 'CRSS', NULL, NULL, NULL, NULL, 'lesson_name', 'N', 'N', NULL, 'N', '2004-12-24 17:29:16', 'AJM', '2006-10-06 13:22:48', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_lesson(popup)', 'crs_lesson(search)', '001', 'Search', 'N', '2004-12-24 20:29:50', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_lesson(popup)', '2005-04-19 18:44:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_lesson(search)', 'Search Lesson', 'Search', 'PROC', 'lesson_search.php', 'N', 'SRCH', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-21 18:31:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_lesson(search)', '2005-04-19 18:44:07', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_lesson(upd)', 'Update Lesson', 'Update', 'PROC', 'lesson_upd.php', 'N', 'UPD1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-21 18:30:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_room(add)', 'Add Room', 'New', 'PROC', 'room_add.php', 'N', 'ADD1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-19 21:38:20', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_room(del)', 'Delete Room', 'Delete', 'PROC', 'room_del.php', 'N', 'DEL1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-19 21:38:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_room(enq)', 'Enquire Room', 'Read', 'PROC', 'room_enq.php', 'N', 'ENQ1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-19 21:39:18', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_room(enq)', '2005-04-19 18:43:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_room(list)', 'List Room', 'Rooms', 'PROC', 'room_list.php', 'N', 'LIST1', 'CRSS', NULL, NULL, NULL, NULL, 'room_desc', 'N', NULL, NULL, 'N', '2004-12-19 19:42:00', 'AJM', '2004-12-25 09:57:28', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_room(list)', 'crs_room(add)', '001', 'New', 'N', '2004-12-19 21:40:42', 'AJM', NULL, NULL),
('crs_room(list)', 'crs_room(enq)', '002', 'Read', 'Y', '2004-12-19 21:40:42', 'AJM', '2005-01-01 16:24:21', 'AJM'),
('crs_room(list)', 'crs_room(upd)', '003', 'Update', 'Y', '2004-12-19 21:40:42', 'AJM', '2005-01-01 16:24:21', 'AJM'),
('crs_room(list)', 'crs_room(del)', '004', 'Delete', 'Y', '2004-12-19 21:40:42', 'AJM', '2005-01-01 16:24:21', 'AJM'),
('crs_room(list)', 'crs_room(search)', '005', 'Search', 'N', '2004-12-19 21:40:42', 'AJM', '2005-02-20 17:36:16', 'AJM'),
('crs_room(list)', 'crs_schedule(multi)', '006', 'Maintain Schedule', 'Y', '2005-02-13 16:26:31', 'AJM', '2005-02-20 17:36:16', 'AJM'),
('crs_room(list)', 'crs_schedule(list)room', '007', 'Show Schedule', 'Y', '2005-02-20 17:35:46', 'AJM', '2005-02-26 11:00:52', 'AJM'),
('crs_room(list)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2004-12-25 11:09:54', 'AJM', '2005-02-20 17:36:16', 'AJM'),
('crs_room(list)', 'crs_schedule_hdr(choose)', '009', 'Choose Schedule', 'N', '2006-03-11 15:53:16', 'AJM', '2006-03-11 15:53:37', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_room(list)', '2005-04-19 18:43:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_room(search)', 'search Room', 'Search', 'PROC', 'room_search.php', 'N', 'SRCH', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-19 21:40:13', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_room(search)', '2005-04-19 18:43:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_room(upd)', 'Update Room', 'Update', 'PROC', 'room_upd.php', 'N', 'UPD1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-19 21:39:47', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule_hdr(add)', 'Add Schedule Header', 'New', 'PROC', 'schedule_hdr_add.php', 'N', 'ADD1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-01-03 16:25:06', 'AJM', '2005-01-03 16:27:19', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule_hdr(choose)', 'Choose Schedule Id', 'Choose Schedule', 'PROC', 'schedule_hdr_choose.php', 'N', 'UPD2', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-03-11 15:48:47', 'AJM', '2006-03-11 18:23:43', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_schedule_hdr(choose)', '2006-04-07 17:27:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule_hdr(del)', 'Delete Schedule Header', 'Delete', 'PROC', 'schedule_hdr_del.php', 'N', 'DEL1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-01-03 16:25:43', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule_hdr(enq)', 'Enquire Schedule Header', 'Read', 'PROC', 'schedule_hdr_enq.php', 'N', 'ENQ1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-01-03 16:26:06', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_schedule_hdr(enq)', '2005-04-19 18:45:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule_hdr(list)', 'List Schedule Header', 'Schedules', 'PROC', 'schedule_hdr_list.php', 'N', 'LIST1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-01-03 16:24:42', 'AJM', '2005-01-03 16:27:33', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule_hdr(list)', 'crs_schedule_hdr(add)', '001', 'New', 'N', '2005-01-03 16:28:31', 'AJM', '2005-01-03 16:29:01', 'AJM'),
('crs_schedule_hdr(list)', 'crs_schedule_hdr(search)', '002', 'Search', 'N', '2005-01-03 16:28:18', 'AJM', '2005-01-03 16:29:01', 'AJM'),
('crs_schedule_hdr(list)', 'crs_schedule_hdr(enq)', '003', 'Read', 'Y', '2005-01-03 16:28:18', 'AJM', '2005-01-03 16:29:01', 'AJM'),
('crs_schedule_hdr(list)', 'crs_schedule_hdr(upd)', '004', 'Update', 'Y', '2005-01-03 16:28:18', 'AJM', NULL, NULL),
('crs_schedule_hdr(list)', 'crs_schedule_hdr(del)', '005', 'Delete', 'Y', '2005-01-03 16:28:18', 'AJM', '2005-01-03 16:29:00', 'AJM'),
('crs_schedule_hdr(list)', 'crs_schedule(list)', '006', 'Events', 'Y', '2005-01-03 17:22:34', 'AJM', '2005-01-05 21:42:22', 'AJM'),
('crs_schedule_hdr(list)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2005-01-03 18:05:22', 'AJM', NULL, NULL),
('crs_schedule_hdr(list)', 'audit_dtl(list)3exact', '008', 'Audit Trail (exact)', 'Y', '2005-01-03 18:05:22', 'AJM', '2005-01-03 18:06:00', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_schedule_hdr(list)', '2005-04-19 18:45:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule_hdr(popup)', 'Choose Schedule Id', 'Choose', 'PROC', 'schedule_hdr_popup.php', 'N', 'POPUP1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-03-11 15:34:08', 'AJM', '2006-10-06 13:23:11', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_schedule_hdr(popup)', '2006-04-07 17:27:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule_hdr(search)', 'Search Schedule Header', 'Search', 'PROC', 'schedule_hdr_search.php', 'N', 'SRCH', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-01-03 16:26:33', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_schedule_hdr(search)', '2005-04-19 18:45:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule_hdr(upd)', 'Update Schedule Header', 'Update', 'PROC', 'schedule_hdr_upd.php', 'N', 'UPD1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-01-03 16:26:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule(add)', 'Add Schedule Event', 'New', 'PROC', 'schedule_add.php', 'N', 'ADD2', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-01-03 17:18:30', 'AJM', '2005-01-05 21:44:38', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule(del)', 'Delete Schedule Event', 'Delete', 'PROC', 'schedule_del.php', 'N', 'DEL1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-01-03 17:19:41', 'AJM', '2005-01-05 21:43:38', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule(enq)', 'Read Schedule Event', 'Read', 'PROC', 'schedule_enq.php', 'N', 'ENQ1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-01-03 17:20:00', 'AJM', '2005-01-05 21:43:45', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_schedule(enq)', '2005-04-19 18:45:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule(list)', 'List Schedule Events', 'Schedule', 'PROC', 'schedule_list.php', 'N', 'LIST2', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-01-03 17:17:50', 'AJM', '2005-01-05 21:42:45', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule(list)', 'crs_schedule(add)', '001', 'New', 'N', '2005-01-03 17:21:54', 'AJM', '2005-01-03 17:26:55', 'AJM'),
('crs_schedule(list)', 'crs_schedule(search)', '002', 'Search', 'N', '2005-01-03 17:21:54', 'AJM', '2005-01-03 17:22:08', 'AJM'),
('crs_schedule(list)', 'crs_schedule(enq)', '003', 'Read', 'Y', '2005-01-03 17:21:54', 'AJM', NULL, NULL),
('crs_schedule(list)', 'crs_schedule(upd)', '004', 'Update', 'Y', '2005-01-03 17:21:54', 'AJM', '2005-01-03 17:28:01', 'AJM'),
('crs_schedule(list)', 'crs_schedule(del)', '005', 'Delete', 'Y', '2005-01-03 17:21:54', 'AJM', '2005-01-03 17:28:01', 'AJM'),
('crs_schedule(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2005-01-03 18:03:54', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_schedule(list)', '2005-04-19 18:45:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule(list)class', 'Show Schedule for Class', 'Show Schedule', 'PROC', 'schedule_list(class).php', 'N', 'TIMETABLE1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2005-02-26 11:05:45', 'AJM', '2006-07-10 21:36:16', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_schedule(list)class', '2005-04-19 18:45:13', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule(list)lesson', 'Show Schedule for Lesson', 'Show Schedule', 'PROC', 'schedule_list(lesson).php', 'N', 'TIMETABLE1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2005-02-26 15:03:18', 'AJM', '2006-07-10 21:36:49', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_schedule(list)lesson', '2005-04-19 18:45:13', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule(list)room', 'Show Schedule for Room', 'Show Schedule', 'PROC', 'schedule_list(room).php', 'N', 'TIMETABLE1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2005-02-20 17:35:13', 'AJM', '2006-07-10 21:37:31', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_schedule(list)room', '2005-04-19 18:45:13', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule(list)student', 'Show Schedule for Student', 'Show Schedule', 'PROC', 'schedule_list(student).php', 'N', 'TIMETABLE1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2005-02-26 15:02:51', 'AJM', '2006-07-10 21:38:01', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_schedule(list)student', '2005-04-19 18:45:13', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule(list)teacher', 'Show Schedule for Teacher', 'Show Schedule', 'PROC', 'schedule_list(teacher).php', 'N', 'TIMETABLE1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2005-02-24 21:26:55', 'AJM', '2006-07-10 21:38:18', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_schedule(list)teacher', '2005-04-19 18:45:13', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule(multi)', 'Maintain Schedule Events', 'Schedule', 'PROC', 'schedule_multi.php', 'N', 'MULTI3', 'CRSS', NULL, NULL, NULL, NULL, 'start_time', 'N', NULL, NULL, 'N', '2005-02-13 16:25:34', 'AJM', '2005-06-24 17:34:11', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule(multi)', 'crs_schedule(add)', '001', 'New', 'N', '2005-02-14 20:13:45', 'AJM', '2005-02-14 20:16:35', 'AJM'),
('crs_schedule(multi)', 'crs_schedule(enq)', '002', 'Read', 'Y', '2005-02-14 22:12:53', 'AJM', '2006-07-12 21:32:22', 'AJM'),
('crs_schedule(multi)', 'crs_schedule(upd)', '003', 'Update', 'Y', '2006-07-13 11:08:10', 'AJM', '2006-07-13 11:08:28', 'AJM'),
('crs_schedule(multi)', 'crs_schedule(del)', '004', 'Delete', 'Y', '2005-02-14 20:13:45', 'AJM', '2006-07-13 11:08:28', 'AJM'),
('crs_schedule(multi)', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2006-07-13 11:03:28', 'AJM', NULL, NULL),
('crs_schedule(multi)', 'crs_schedule(list)room', '005', 'Show Schedule', 'N', '2005-02-26 15:32:48', 'AJM', '2006-07-13 11:08:28', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule(search)', 'Search Schedule Event', 'Search', 'PROC', 'schedule_search.php', 'N', 'SRCH', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-01-03 17:20:25', 'AJM', '2005-01-05 21:44:15', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_schedule(search)', '2005-04-19 18:45:13', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_schedule(upd)', 'Update Schedule Event', 'Update', 'PROC', 'schedule_upd.php', 'N', 'UPD1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2005-01-03 17:20:50', 'AJM', '2006-03-19 18:06:34', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_student_lesson(add)a', 'Add Lesson(s) to selected Student', 'Insert', 'PROC', 'student_lesson_add(a).php', 'N', 'ADD3', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-24 17:20:51', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_student_lesson(add)b', 'Add Students(s) to selected Lesson', 'Insert', 'PROC', 'student_lesson_add(b).php', 'N', 'ADD3', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-25 12:05:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_student_lesson(del)', 'Delete from Student/Lesson cross-reference', 'Delete', 'PROC', 'student_lesson_del.php', 'N', 'DEL2', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-24 17:25:02', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_student(add)', 'Add Student', 'New', 'PROC', 'student_add.php', 'N', 'ADD1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-24 12:53:41', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_student(del)', 'Delete Student', 'Delete', 'PROC', 'student_del.php', 'N', 'DEL1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-24 12:54:04', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_student(enq)', 'Enquire Student', 'Read', 'PROC', 'student_enq.php', 'N', 'ENQ1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-24 12:54:30', 'AJM', '2004-12-24 16:09:44', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_student(enq)', '2005-04-19 18:44:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_student(list)', 'List Student', 'Students', 'PROC', 'student_list.php', 'N', 'LIST1', 'CRSS', NULL, NULL, NULL, NULL, 'last_name, first_name', 'N', NULL, NULL, 'N', '2004-12-24 12:53:16', 'AJM', '2004-12-25 10:02:03', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_student(list)', 'crs_student(add)', '001', 'New', 'N', '2004-12-24 12:55:46', 'AJM', NULL, NULL),
('crs_student(list)', 'crs_student(enq)', '002', 'Read', 'Y', '2004-12-24 12:56:00', 'AJM', '2005-01-01 16:24:51', 'AJM'),
('crs_student(list)', 'crs_student(upd)', '003', 'Update', 'Y', '2004-12-24 12:56:00', 'AJM', '2005-01-01 16:24:51', 'AJM'),
('crs_student(list)', 'crs_student(del)', '004', 'Delete', 'Y', '2004-12-24 12:55:59', 'AJM', '2005-01-01 16:24:51', 'AJM'),
('crs_student(list)', 'crs_student(search)', '005', 'Search', 'N', '2004-12-24 12:56:00', 'AJM', '2005-01-01 16:24:51', 'AJM'),
('crs_student(list)', 'crs_lesson(list)a', '006', 'Lessons', 'Y', '2004-12-24 17:05:53', 'AJM', NULL, NULL),
('crs_student(list)', 'crs_schedule(list)student', '007', 'Show Schedule', 'Y', '2005-02-26 15:04:00', 'AJM', '2005-02-26 15:04:09', 'AJM'),
('crs_student(list)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2004-12-25 11:10:04', 'AJM', '2005-02-26 15:04:09', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_student(list)', '2005-04-19 18:44:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_student(list)a', 'List Students for a Lesson', 'Students', 'PROC', 'student_list(a).php', 'N', 'LIST2', 'CRSS', NULL, NULL, NULL, NULL, 'last_name', 'N', NULL, NULL, 'N', '2004-12-25 11:32:07', 'AJM', '2004-12-25 11:58:02', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_student(list)a', 'crs_student_lesson(add)b', '001', 'Insert', 'N', '2004-12-25 12:07:34', 'AJM', NULL, NULL),
('crs_student(list)a', 'crs_student_lesson(del)', '002', 'Delete', 'Y', '2004-12-25 12:07:34', 'AJM', NULL, NULL),
('crs_student(list)a', 'crs_student(search)', '003', 'Search', 'N', '2004-12-25 12:09:46', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_student(list)a', '2005-04-19 18:44:36', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_student(list)b', 'List Students for a Class', 'Students', 'PROC', 'student_list(b).php', 'N', 'LIST2', 'CRSS', NULL, NULL, NULL, NULL, 'last_name', 'N', NULL, NULL, 'N', '2004-12-26 11:32:16', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_student(list)b', '2005-04-19 18:44:49', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_student(popup)', 'Choose Student', 'Students', 'PROC', 'student_popup.php', 'N', 'POPUP1', 'CRSS', NULL, NULL, NULL, NULL, 'last_name, first_name', 'N', 'N', NULL, 'N', '2004-12-25 12:03:32', 'AJM', '2006-10-06 13:23:37', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_student(popup)', 'crs_student(search)', '001', 'Search', 'N', '2004-12-25 12:08:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_student(popup)', '2005-04-19 18:44:36', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_student(search)', 'Search Student', 'Search', 'PROC', 'student_search.php', 'N', 'SRCH', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-24 12:54:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_student(search)', '2005-04-19 18:44:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_student(upd)', 'Update Student', 'Update', 'PROC', 'student_upd.php', 'N', 'UPD1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-24 12:55:20', 'AJM', '2005-01-29 19:53:01', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_subject(add)', 'Add Subject', 'New', 'PROC', 'subject_add.php', 'N', 'ADD1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-07-28 12:33:40', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_subject(del)', 'Delete Subject', 'Delete', 'PROC', 'subject_del.php', 'N', 'DEL1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-07-28 12:34:06', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_subject(enq)', 'Enquire Subject', 'Enquire', 'PROC', 'subject_enq.php', 'N', 'ENQ1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-07-28 12:34:35', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_subject(enq)', '2006-04-07 17:27:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_subject(list)', 'List Subject', 'Subjects', 'PROC', 'subject_list.php', 'N', 'LIST1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'Y', NULL, NULL, 'N', '2005-07-28 12:33:11', 'AJM', '2005-07-28 12:41:46', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_subject(list)', 'crs_subject(add)', '001', 'New', 'N', '2005-07-28 12:46:28', 'AJM', NULL, NULL),
('crs_subject(list)', 'crs_subject(search)', '002', 'Search', 'N', '2005-07-28 12:46:28', 'AJM', '2005-07-28 12:50:47', 'AJM'),
('crs_subject(list)', 'crs_subject(enq)', '003', 'Enquire', 'Y', '2005-07-28 12:46:28', 'AJM', NULL, NULL),
('crs_subject(list)', 'crs_subject(upd)', '004', 'Update', 'Y', '2005-07-28 12:46:28', 'AJM', '2005-07-28 12:50:47', 'AJM'),
('crs_subject(list)', 'crs_subject(del)', '005', 'Delete', 'Y', '2005-07-28 12:46:28', 'AJM', '2005-07-28 12:50:47', 'AJM'),
('crs_subject(list)', 'crs_lesson(list)d', '006', 'Lessons', 'Y', '2005-07-28 14:38:28', 'AJM', '2005-07-28 14:38:41', 'AJM'),
('crs_subject(list)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2005-07-28 12:50:56', 'AJM', '2005-07-28 14:38:41', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_subject(list)', '2006-04-07 17:27:27', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_subject(search)', 'Search Subject', 'Search', 'PROC', 'subject_search.php', 'N', 'SRCH', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-07-28 12:35:07', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_subject(search)', '2006-04-07 17:27:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_subject(upd)', 'Update Subject', 'Update', 'PROC', 'subject_upd.php', 'N', 'UPD1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-07-28 12:35:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_teacher(add)', 'Add Teacher', 'New', 'PROC', 'teacher_add.php', 'N', 'ADD1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-19 22:05:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_teacher(del)', 'Delete Teacher', 'Delete', 'PROC', 'teacher_del.php', 'N', 'DEL1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-19 22:06:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_teacher(enq)', 'Emquire Teacher', 'Read', 'PROC', 'teacher_enq.php', 'N', 'ENQ1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-19 22:06:43', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_teacher(enq)', '2005-04-19 18:43:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_teacher(list)', 'List Teacher', 'Teachers', 'PROC', 'teacher_list.php', 'N', 'LIST1', 'CRSS', NULL, NULL, NULL, NULL, 'last_name', 'N', NULL, NULL, 'N', '2004-12-19 22:05:33', 'AJM', '2004-12-25 10:00:01', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_teacher(list)', 'crs_teacher(add)', '001', 'New', 'N', '2004-12-19 22:08:37', 'AJM', NULL, NULL),
('crs_teacher(list)', 'crs_teacher(enq)', '002', 'Read', 'Y', '2004-12-19 22:08:38', 'AJM', '2005-01-01 16:25:23', 'AJM'),
('crs_teacher(list)', 'crs_teacher(upd)', '003', 'Update', 'Y', '2004-12-19 22:08:49', 'AJM', '2005-01-01 16:25:23', 'AJM'),
('crs_teacher(list)', 'crs_teacher(del)', '004', 'Delete', 'Y', '2004-12-19 22:08:38', 'AJM', '2005-01-01 16:25:23', 'AJM'),
('crs_teacher(list)', 'crs_teacher(search)', '005', 'Search', 'N', '2004-12-19 22:08:49', 'AJM', '2005-01-01 16:25:23', 'AJM'),
('crs_teacher(list)', 'crs_lesson(list)c', '006', 'Lessons', 'Y', '2004-12-27 18:15:09', 'AJM', '2005-01-06 18:53:17', 'AJM'),
('crs_teacher(list)', 'crs_schedule(list)teacher', '007', 'Show Schedule', 'Y', '2005-02-24 21:28:02', 'AJM', '2005-02-26 11:03:28', 'AJM'),
('crs_teacher(list)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2004-12-25 11:10:14', 'AJM', '2005-02-24 21:28:17', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_teacher(list)', '2005-04-19 18:44:07', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_teacher(search)', 'Search Teacher', 'Search', 'PROC', 'teacher_search.php', 'N', 'SRCH', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-19 22:07:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'crs_teacher(search)', '2005-04-19 18:44:07', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crs_teacher(upd)', 'Update Teacher', 'Update', 'PROC', 'teacher_upd.php', 'N', 'UPD1', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-19 22:07:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crss', 'Classroom Scheduling System', 'CRS', 'MENU', 'menu.php', 'N', 'MENU', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-12-19 16:01:16', 'AJM', '2004-12-24 13:18:31', 'AJM'),
('crss2', 'Classroom Scheduling System (2)', 'Scheduling', 'MENU', 'menu.php', 'N', 'MENU', 'CRSS', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2005-01-01 17:39:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('crss', 'crs_room(list)', '001', 'Rooms', '2004-12-19 19:42:51', 'AJM', NULL, NULL),
('crss', 'crs_teacher(list)', '002', 'Teachers', '2004-12-19 22:07:58', 'AJM', NULL, NULL),
('crss', 'crs_subject(list)', '003', 'Subjects', '2005-07-28 12:42:32', 'AJM', '2005-07-28 12:42:54', 'AJM'),
('crss', 'crs_lesson(list)', '004', 'Lessons', '2004-12-21 18:32:13', 'AJM', '2005-07-28 12:42:54', 'AJM'),
('crss', 'crs_class(list)', '005', 'Classes', '2004-12-25 19:52:58', 'AJM', '2005-07-28 12:42:54', 'AJM'),
('crss', 'crs_student(list)', '006', 'Students', '2004-12-24 12:56:26', 'AJM', '2005-07-28 12:42:54', 'AJM'),
('crss', 'crss2', '007', 'Scheduling', '2005-01-01 17:40:04', 'AJM', '2005-07-28 12:42:54', 'AJM'),
('crss2', 'crs_confict(list)', '001', 'Conflicts', '2005-01-01 17:58:01', 'AJM', NULL, NULL),
('crss2', 'crs_schedule_hdr(list)', '002', 'Schedules', '2005-01-03 16:29:33', 'AJM', NULL, NULL);

REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('proto', 'crss', '003', 'Classroom', '2005-05-05 17:45:59', 'AJM', '2007-02-24 11:42:19', 'AJM');

-- finished
