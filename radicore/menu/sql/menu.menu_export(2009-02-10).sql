USE `menu`;

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`settings` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Menu Controls' ,'2009-02-10 11:47:06' ,'AJM' ,'N' ,'N' ,'N' ,'UPD3' ,'mnu_control(upd3).php' ,'main_noedit=Y' ,'MENU' ,'Enquire Menu Controls' ,'mnu_control(upd3)noedit' ,'PROC' ,'N');

DELETE FROM `mnu_role_task` WHERE role_id='DEMO' AND task_id='mnu_control(upd3)';

REPLACE INTO `mnu_role_task` (`created_date` ,`created_user` ,`role_id` ,`task_id`) VALUES
('2009-02-10 11:47:42' ,'AJM' ,'DEMO' ,'mnu_control(upd3)noedit');

DELETE FROM `mnu_role_task` WHERE role_id='READONLY' AND task_id='mnu_control(upd3)';

REPLACE INTO `mnu_role_task` (`created_date` ,`created_user` ,`role_id` ,`task_id`) VALUES
('2009-02-10 12:18:19' ,'AJM' ,'READONLY' ,'mnu_control(upd3)noedit');
