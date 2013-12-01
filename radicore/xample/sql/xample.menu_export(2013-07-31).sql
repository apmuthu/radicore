-- USE `menu`;

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Select/Display Person' ,'2013-07-31 14:34:06' ,'AJM' ,'N' ,'N' ,'N' ,'MULTI5' ,'x_person(multi5).php' ,'XAMPLE' ,'Select/Display Person' ,'x_person(multi5)' ,'PROC' ,'N');

REPLACE INTO `mnu_menu` (`button_text` ,`created_date` ,`created_user` ,`menu_id` ,`sort_seq` ,`task_id_jnr`) VALUES
('Select/Display Person' ,'2013-07-31 14:39:12' ,'AJM' ,'xample' ,'006' ,'x_person(multi5)');

UPDATE `mnu_menu` SET `revised_date`='2013-07-31 14:39:59' ,`revised_user`='AJM' ,`sort_seq`='003' WHERE menu_id='xample' AND task_id_jnr='x_option(list)';

UPDATE `mnu_menu` SET `revised_date`='2013-07-31 14:40:00' ,`revised_user`='AJM' ,`sort_seq`='004' WHERE menu_id='xample' AND task_id_jnr='x_pers_type(list)';

UPDATE `mnu_menu` SET `revised_date`='2013-07-31 14:40:00' ,`revised_user`='AJM' ,`sort_seq`='005' WHERE menu_id='xample' AND task_id_jnr='x_tree_type(list)';

UPDATE `mnu_menu` SET `revised_date`='2013-07-31 14:40:00' ,`revised_user`='AJM' ,`sort_seq`='006' WHERE menu_id='xample' AND task_id_jnr='test_autoinsert(add)';

UPDATE `mnu_menu` SET `button_text`='Person (Multi5)' ,`revised_date`='2013-07-31 14:40:01' ,`revised_user`='AJM' ,`sort_seq`='002' WHERE menu_id='xample' AND task_id_jnr='x_person(multi5)';
