USE `menu`;

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Batch Log Files' ,'2008-11-21 11:42:41' ,'AJM' ,'N' ,'N' ,'N' ,'FILEDOWNLOAD' ,'batch_log_filedownload.php' ,'MENU' ,'Download Batch Log File' ,'batch_log(filedownload)' ,'PROC' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Batch Log Files' ,'2008-11-21 12:09:14' ,'AJM' ,'N' ,'N' ,'N' ,'FILEPICKER' ,'batch_log_filepicker.php' ,'MENU' ,'Show Batch Log File' ,'batch_log(filepicker)' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Batch Log Files' ,'N' ,'2008-11-21 12:09:53' ,'AJM' ,'007' ,'batch_log(filepicker)' ,'menu');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Search' ,'2008-11-22 16:19:22' ,'AJM' ,'N' ,'N' ,'N' ,'SRCH' ,'file(search).php' ,'MISC' ,'Search File Name' ,'file(search)' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Search' ,'N' ,'2008-11-22 16:20:27' ,'AJM' ,'001' ,'file(search)' ,'batch_log(filepicker)');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Search' ,'N' ,'2008-11-22 18:21:30' ,'AJM' ,'002' ,'file(search)' ,'x_person(filepicker)');

REPLACE INTO `mnu_pattern` (`context_preselect` ,`created_date` ,`created_user` ,`keep_data` ,`pattern_desc` ,`pattern_id` ,`pattern_long_desc` ,`visible_screen`) VALUES
('N' ,'2008-11-24 11:39:28' ,'AJM' ,'N' ,'BATCH - Background process' ,'BATCH' ,'This process will be run in the background as it may require to run longer than the limit available for web pages. The output will be stored in the LOGS directory.' ,'N');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Delete' ,'2008-11-24 16:33:57' ,'AJM' ,'N' ,'N' ,'N' ,'DEL2' ,'file(delete).php' ,'MISC' ,'Delete File Name' ,'file(delete)' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Delete' ,'Y' ,'2008-11-24 16:34:42' ,'AJM' ,'002' ,'file(delete)' ,'batch_log(filepicker)');

UPDATE `mnu_task` SET `revised_date`='2008-11-27 12:23:57' ,`revised_user`='AJM' ,`screen_refresh`='10' WHERE task_id='batch_log(filepicker)';

UPDATE `mnu_task` SET `revised_date`='2008-12-02 10:20:18' ,`revised_user`='AJM' ,`settings`='hyperlink_direct=Y' WHERE task_id='batch_log(filepicker)';

