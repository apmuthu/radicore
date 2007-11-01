
use `menu`;

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Generate SQL' ,'2007-06-23 13:39:36' ,'AJM' ,'N' ,'N' ,'N' ,'UPD4' ,'audit_tbl(upd4).php' ,'AUDIT' ,'Generate SQL' ,'audit_tbl(upd4)' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Generate SQL' ,'N' ,'2007-06-23 13:41:06' ,'AJM' ,'003' ,'audit_tbl(upd4)' ,'audit_dtl(list)2');

UPDATE `mnu_nav_button` SET `revised_date`='2007-06-23 13:41:47' ,`revised_user`='AJM' ,`sort_seq`='001' WHERE task_id_snr='audit_dtl(list)2' AND task_id_jnr='audit_fld(upd4)';
UPDATE `mnu_nav_button` SET `revised_date`='2007-06-23 13:41:47' ,`revised_user`='AJM' ,`sort_seq`='002' WHERE task_id_snr='audit_dtl(list)2' AND task_id_jnr='audit_dtl(del)';
UPDATE `mnu_nav_button` SET `revised_date`='2007-06-23 13:41:47' ,`revised_user`='AJM' ,`sort_seq`='003' WHERE task_id_snr='audit_dtl(list)2' AND task_id_jnr='audit_dtl(search)';
