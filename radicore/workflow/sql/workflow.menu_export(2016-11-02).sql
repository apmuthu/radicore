-- USE `gmx_menu`;

REPLACE INTO `mnu_task` (`button_text`, `created_date`, `created_user`, `is_disabled`, `keep_data`, `log_sql_query`, `pattern_id`, `script_id`, `settings`, `subsys_id`, `task_desc`, `task_id`, `task_type`, `use_https`) VALUES
('CANCEL' ,'2016-12-02 15:47:07' ,'AJM' ,'N' ,'N' ,'N' ,'UPD1' ,'case(upd1)status.php' ,'case_status=CA' ,'WORKFLOW' ,'Cancel Workflow Case' ,'wf_case(upd1)a' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text`, `created_date`, `created_user`, `is_disabled`, `keep_data`, `log_sql_query`, `pattern_id`, `script_id`, `settings`, `subsys_id`, `task_desc`, `task_id`, `task_type`, `use_https`) VALUES
('SUSPEND' ,'2016-12-02 15:48:03' ,'AJM' ,'N' ,'N' ,'N' ,'UPD1' ,'case(upd1)status.php' ,'case_status=SU' ,'WORKFLOW' ,'Suspend Workflow Case' ,'wf_case(upd1)b' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text`, `created_date`, `created_user`, `is_disabled`, `keep_data`, `log_sql_query`, `pattern_id`, `script_id`, `settings`, `subsys_id`, `task_desc`, `task_id`, `task_type`, `use_https`) VALUES
('REOPEN' ,'2016-12-02 15:48:46' ,'AJM' ,'N' ,'N' ,'N' ,'UPD1' ,'case(upd1)status.php' ,'case_status=OP' ,'WORKFLOW' ,'Reopen Workflow Case' ,'wf_case(upd1)c' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text`, `context_preselect`, `created_date`, `created_user`, `sort_seq`, `task_id_jnr`, `task_id_snr`) VALUES
('CANCEL' ,'Y' ,'2016-12-02 15:50:13' ,'AJM' ,'008' ,'wf_case(upd1)a' ,'wf_case(list)');

REPLACE INTO `mnu_nav_button` (`button_text`, `context_preselect`, `created_date`, `created_user`, `sort_seq`, `task_id_jnr`, `task_id_snr`) VALUES
('SUSPEND' ,'Y' ,'2016-12-02 15:50:14' ,'AJM' ,'009' ,'wf_case(upd1)b' ,'wf_case(list)');

REPLACE INTO `mnu_nav_button` (`button_text`, `context_preselect`, `created_date`, `created_user`, `sort_seq`, `task_id_jnr`, `task_id_snr`) VALUES
('REOPEN' ,'Y' ,'2016-12-02 15:50:15' ,'AJM' ,'010' ,'wf_case(upd1)c' ,'wf_case(list)');

UPDATE `mnu_nav_button` SET `revised_date`='2016-12-02 15:50:38', `revised_user`='AJM', `sort_seq`='010' WHERE task_id_snr='wf_case(list)' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `revised_date`='2016-12-02 15:50:38', `revised_user`='AJM', `sort_seq`='010' WHERE task_id_snr='wf_case(list)' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `revised_date`='2016-12-02 15:50:39', `revised_user`='AJM', `sort_seq`='007' WHERE task_id_snr='wf_case(list)' AND task_id_jnr='wf_case(upd1)a';

UPDATE `mnu_nav_button` SET `revised_date`='2016-12-02 15:50:39', `revised_user`='AJM', `sort_seq`='008' WHERE task_id_snr='wf_case(list)' AND task_id_jnr='wf_case(upd1)b';

UPDATE `mnu_nav_button` SET `revised_date`='2016-12-02 15:50:39', `revised_user`='AJM', `sort_seq`='009' WHERE task_id_snr='wf_case(list)' AND task_id_jnr='wf_case(upd1)c';

REPLACE INTO `mnu_nav_button` (`button_text`, `context_preselect`, `created_date`, `created_user`, `sort_seq`, `task_id_jnr`, `task_id_snr`) VALUES
('CANCEL' ,'Y' ,'2016-12-02 15:51:42' ,'AJM' ,'008' ,'wf_case(upd1)a' ,'wf_case(list)2');

REPLACE INTO `mnu_nav_button` (`button_text`, `context_preselect`, `created_date`, `created_user`, `sort_seq`, `task_id_jnr`, `task_id_snr`) VALUES
('SUSPEND' ,'Y' ,'2016-12-02 15:51:42' ,'AJM' ,'009' ,'wf_case(upd1)b' ,'wf_case(list)2');

REPLACE INTO `mnu_nav_button` (`button_text`, `context_preselect`, `created_date`, `created_user`, `sort_seq`, `task_id_jnr`, `task_id_snr`) VALUES
('REOPEN' ,'Y' ,'2016-12-02 15:51:43' ,'AJM' ,'010' ,'wf_case(upd1)c' ,'wf_case(list)2');

UPDATE `mnu_nav_button` SET `revised_date`='2016-12-02 15:52:03', `revised_user`='AJM', `sort_seq`='010' WHERE task_id_snr='wf_case(list)2' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `revised_date`='2016-12-02 15:52:04', `revised_user`='AJM', `sort_seq`='007' WHERE task_id_snr='wf_case(list)2' AND task_id_jnr='wf_case(upd1)a';

UPDATE `mnu_nav_button` SET `revised_date`='2016-12-02 15:52:04', `revised_user`='AJM', `sort_seq`='008' WHERE task_id_snr='wf_case(list)2' AND task_id_jnr='wf_case(upd1)b';

UPDATE `mnu_nav_button` SET `revised_date`='2016-12-02 15:52:04', `revised_user`='AJM', `sort_seq`='009' WHERE task_id_snr='wf_case(list)2' AND task_id_jnr='wf_case(upd1)c';
