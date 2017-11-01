-- USE `menu`;

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Output to CSV' ,'2014-06-26 11:52:04' ,'AJM' ,'N' ,'N' ,'N' ,'OUTPUT6' ,'x_tree_node(output6).php' ,'XAMPLE' ,'Output Tree Node to CSV' ,'x_tree_node(output6)' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Output to CSV' ,'N' ,'2014-06-26 11:54:44' ,'AJM' ,'003' ,'x_tree_node(output6)' ,'x_tree_structure(list)');
