-- USE `menu`;

UPDATE `mnu_task` SET `revised_date`='2013-10-26 16:51:47' ,`revised_user`='AJM' ,`script_id`='database(popup1).php' ,`task_desc`='Choose Dictionary Database' WHERE task_id ='dict_database(popup1)';

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Choose' ,'2013-10-26 16:52:32' ,'AJM' ,'N' ,'Y' ,'N' ,'POPUP1' ,'database(popup1).php' ,'DICT' ,'Choose Dictionary Database (Outer)' ,'dict_database(popup1)outer' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Choose' ,'2013-10-26 16:52:49' ,'AJM' ,'N' ,'Y' ,'N' ,'POPUP1' ,'database(popup1).php' ,'DICT' ,'Choose Dictionary Database (Middle)' ,'dict_database(popup1)middle' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Choose' ,'2013-10-26 16:53:10' ,'AJM' ,'N' ,'Y' ,'N' ,'POPUP1' ,'database(popup1).php' ,'DICT' ,'Choose Dictionary Database (Inner)' ,'dict_database(popup1)inner' ,'PROC' ,'N');

UPDATE `mnu_task` SET `revised_date`='2013-10-26 17:35:37' ,`revised_user`='AJM' ,`script_id`='database(popup1).php' WHERE task_id ='dict_database(popup1)';

UPDATE `mnu_task` SET `revised_date`='2013-10-26 17:38:35' ,`revised_user`='AJM' ,`script_id`='table(popup2).php' WHERE task_id ='dict_table(popup1)';

UPDATE `mnu_task` SET `revised_date`='2013-10-26 17:38:43' ,`revised_user`='AJM' ,`script_id`='table(popup2).php' WHERE task_id ='dict_table(popup1)jnr';

UPDATE `mnu_task` SET `revised_date`='2013-10-26 17:38:51' ,`revised_user`='AJM' ,`script_id`='table(popup2).php' WHERE task_id ='dict_table(popup1)snr';

UPDATE `help_text` SET `revised_date`='2013-10-26 17:39:17' ,`revised_user`='AJM' ,`task_id`='dict_table(popup2)' WHERE task_id='dict_table(popup1)';

UPDATE `mnu_role_task` SET `revised_date`='2013-10-26 17:39:17' ,`revised_user`='AJM' ,`task_id`='dict_table(popup2)' WHERE role_id='DEMO' AND task_id='dict_table(popup1)';

UPDATE `mnu_task` SET `revised_date`='2013-10-26 17:39:18' ,`revised_user`='AJM' ,`task_id`='dict_table(popup2)' WHERE task_id='dict_table(popup1)';

UPDATE `mnu_role_task` SET `revised_date`='2013-10-26 17:39:43' ,`revised_user`='AJM' ,`task_id`='dict_table(popup2)jnr' WHERE role_id='DEMO' AND task_id='dict_table(popup1)jnr';

UPDATE `mnu_task` SET `revised_date`='2013-10-26 17:39:44' ,`revised_user`='AJM' ,`task_id`='dict_table(popup2)jnr' WHERE task_id='dict_table(popup1)jnr';

UPDATE `help_text` SET `revised_date`='2013-10-26 17:40:03' ,`revised_user`='AJM' ,`task_id`='dict_table(popup2)snr' WHERE task_id='dict_table(popup1)snr';

UPDATE `mnu_role_task` SET `revised_date`='2013-10-26 17:40:04' ,`revised_user`='AJM' ,`task_id`='dict_table(popup2)snr' WHERE role_id='DEMO' AND task_id='dict_table(popup1)snr';

UPDATE `mnu_task` SET `revised_date`='2013-10-26 17:40:05' ,`revised_user`='AJM' ,`task_id`='dict_table(popup2)snr' WHERE task_id='dict_table(popup1)snr';

UPDATE `help_text` SET `help_text`='This will list records on the DICT_TABLE table and allow one or more to be selected. \n\nAfter selecting records please press the CHOOSE button. \n\nRefer to <a href=\"%root%/dict_table(popup2).html\">Choose Database Table</a> for full details.' ,`revised_date`='2013-10-26 18:29:42' ,`revised_user`='AJM' WHERE task_id ='dict_table(popup2)';

UPDATE `help_text` SET `help_text`='This will list records on the DICT_TABLE table and allow one or more to be selected. \n\nAfter selecting records please press the CHOOSE button. \n\nRefer to <a href=\"%root%/dict_table(popup2).html\">Choose Database Table</a> for full details.' ,`revised_date`='2013-10-26 18:29:56' ,`revised_user`='AJM' WHERE task_id ='dict_table(popup2)snr';
