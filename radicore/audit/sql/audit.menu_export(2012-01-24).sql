USE `menu`;

REPLACE INTO mnu_task (button_text ,created_date ,created_user ,is_disabled ,keep_data ,log_sql_query ,pattern_id ,script_id ,subsys_id ,task_desc ,task_id ,task_type ,use_https) VALUES
('Delete' ,'2012-01-24 16:12:38' ,'AJM' ,'N' ,'N' ,'N' ,'BATCH' ,'audit_ssn(batch)delete.php' ,'AUDIT' ,'Delete Audit Session' ,'audit_ssn(batch)delete' ,'PROC' ,'N');

REPLACE INTO mnu_nav_button (button_text ,context_preselect ,created_date ,created_user ,sort_seq ,task_id_jnr ,task_id_snr) VALUES
('Delete Audit data' ,'N' ,'2012-01-24 16:29:15' ,'AJM' ,'001' ,'audit_ssn(batch)delete' ,'mnu_control(upd3)');

REPLACE INTO mnu_control (created_date ,created_user ,field_id ,field_value ,record_id) VALUES
('2012-01-25 09:29:14' ,'AJM' ,'AUDIT_DELETE' ,'99' ,'SYSTEM');
