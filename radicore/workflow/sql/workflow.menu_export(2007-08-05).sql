
REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`order_by` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Expired Workitems' ,'2007-08-05 16:15:54' ,'AJM' ,'N' ,'Y' ,'N' ,'case_id,workitem_id' ,'LIST1' ,'workitem.list(expired).php' ,'WORKFLOW' ,'List Expired Workitems' ,'wf_workitem(list)expired' ,'PROC' ,'N');

REPLACE INTO `mnu_menu` (`button_text` ,`created_date` ,`created_user` ,`menu_id` ,`sort_seq` ,`task_id_jnr`) VALUES
('Expired Workitems' ,'2007-08-05 16:17:04' ,'AJM' ,'workflow' ,'005' ,'wf_workitem(list)expired');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Read' ,'Y' ,'2007-08-05 16:17:49' ,'AJM' ,'001' ,'wf_workitem(enq)' ,'wf_workitem(list)expired');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Search' ,'N' ,'2007-08-05 16:18:02' ,'AJM' ,'002' ,'wf_workitem(search)' ,'wf_workitem(list)expired');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Trigger' ,'2007-08-05 16:56:56' ,'AJM' ,'N' ,'N' ,'N' ,'UPD1' ,'workitem.upd(expired).php' ,'WORKFLOW' ,'Trigger Expired Workitem' ,'wf_workitem(upd)expired' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Trigger' ,'Y' ,'2007-08-05 16:57:18' ,'AJM' ,'003' ,'wf_workitem(upd)expired' ,'wf_workitem(list)expired');
