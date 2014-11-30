-- USE `menu`;

UPDATE `mnu_task` SET `revised_date`='2012-06-23 18:43:11' ,`revised_user`='AJM' ,`task_desc`='List Relationship by Table (Senior to Junior)' WHERE task_id='dict_relationship(list2)a';

UPDATE `mnu_task` SET `revised_date`='2012-06-23 18:54:11' ,`revised_user`='AJM' ,`task_desc`='List Child Relationship by Table' WHERE task_id='dict_relationship(list2)a';

UPDATE `mnu_task` SET `revised_date`='2012-06-23 18:57:11' ,`revised_user`='AJM' ,`script_id`='relationship(list2)c.php' WHERE task_id='dict_relationship(list2)b';

UPDATE `help_text` SET `revised_date`='2012-06-23 18:58:24' ,`revised_user`='AJM' ,`task_id`='dict_relationship(list2)c' WHERE task_id='dict_relationship(list2)b';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 18:58:25' ,`revised_user`='AJM' ,`task_id_snr`='dict_relationship(list2)c' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='dict_relationship(search)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 18:58:25' ,`revised_user`='AJM' ,`task_id_snr`='dict_relationship(list2)c' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='dict_related_column(list2)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 18:58:25' ,`revised_user`='AJM' ,`task_id_snr`='dict_relationship(list2)c' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='dict_related_column(multi4)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 18:58:25' ,`revised_user`='AJM' ,`task_id_snr`='dict_relationship(list2)c' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='dict_relationship(del4)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 18:58:25' ,`revised_user`='AJM' ,`task_id_snr`='dict_relationship(list2)c' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 18:58:25' ,`revised_user`='AJM' ,`task_id_snr`='dict_relationship(list2)c' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='dict_relationship(output2)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 18:58:25' ,`revised_user`='AJM' ,`task_id_snr`='dict_relationship(list2)c' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='dict_relationship(output3)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 18:58:25' ,`revised_user`='AJM' ,`task_id_jnr`='dict_relationship(list2)c' WHERE task_id_snr='dict_database(list1)' AND task_id_jnr='dict_relationship(list2)b';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 18:58:25' ,`revised_user`='AJM' ,`task_id_jnr`='dict_relationship(list2)c' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_relationship(list2)b';

UPDATE `mnu_role_task` SET `revised_date`='2012-06-23 18:58:26' ,`revised_user`='AJM' ,`task_id`='dict_relationship(list2)c' WHERE role_id='DEMO' AND task_id='dict_relationship(list2)b';

UPDATE `mnu_task` SET `revised_date`='2012-06-23 18:58:27' ,`revised_user`='AJM' ,`task_id`='dict_relationship(list2)c' WHERE task_id='dict_relationship(list2)b';

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Relationships (Parent)' ,'2012-06-23 18:59:45' ,'AJM' ,'N' ,'N' ,'N' ,'LIST2' ,'relationship(list2)b.php' ,'DICT' ,'List Parent Relationship by Table' ,'dict_relationship(list2)b' ,'PROC' ,'N');

UPDATE `mnu_task` SET `button_text`='Relationships (Child)' ,`revised_date`='2012-06-23 19:00:05' ,`revised_user`='AJM' WHERE task_id='dict_relationship(list2)a';

UPDATE `mnu_nav_button` SET `button_text`='Child Relationships (Table)' ,`revised_date`='2012-06-23 19:05:52' ,`revised_user`='AJM' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_relationship(list2)a';

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Relationships (Parent)' ,'Y' ,'2012-06-23 19:06:13' ,'AJM' ,'015' ,'dict_relationship(list2)b' ,'dict_table(list2)');

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 19:06:57' ,`revised_user`='AJM' ,`sort_seq`='012' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 19:06:57' ,`revised_user`='AJM' ,`sort_seq`='013' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='audit_dtl(list)3exact';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 19:06:57' ,`revised_user`='AJM' ,`sort_seq`='014' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_relationship(list2)c';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 19:06:57' ,`revised_user`='AJM' ,`sort_seq`='015' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_table(output2)';

UPDATE `mnu_nav_button` SET `button_text`='Parent Relationships (Table)' ,`revised_date`='2012-06-23 19:06:57' ,`revised_user`='AJM' ,`sort_seq`='011' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_relationship(list2)b';

UPDATE `mnu_task` SET `revised_date`='2012-06-23 19:57:29' ,`revised_user`='AJM' ,`script_id`='relationship(add2)a.php' ,`task_desc`='Add Child Relationship' WHERE task_id='dict_relationship(add2)';

UPDATE `help_text` SET `revised_date`='2012-06-23 19:57:49' ,`revised_user`='AJM' ,`task_id`='dict_relationship(add2)a' WHERE task_id='dict_relationship(add2)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 19:57:50' ,`revised_user`='AJM' ,`task_id_jnr`='dict_relationship(add2)a' WHERE task_id_snr='dict_relationship(list2)a' AND task_id_jnr='dict_relationship(add2)';

UPDATE `mnu_task` SET `revised_date`='2012-06-23 19:57:50' ,`revised_user`='AJM' ,`task_id`='dict_relationship(add2)a' WHERE task_id='dict_relationship(add2)';

UPDATE `mnu_task` SET `revised_date`='2012-06-23 20:01:42' ,`revised_user`='AJM' ,`script_id`='related_column(list2)a.php' ,`task_desc`='Enquire Child Relationship' WHERE task_id='dict_related_column(list2)';

UPDATE `help_text` SET `revised_date`='2012-06-23 20:02:00' ,`revised_user`='AJM' ,`task_id`='dict_related_column(list2)a' WHERE task_id='dict_related_column(list2)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 20:02:00' ,`revised_user`='AJM' ,`task_id_snr`='dict_related_column(list2)a' WHERE task_id_snr='dict_related_column(list2)' AND task_id_jnr='dict_related_column(multi4)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 20:02:00' ,`revised_user`='AJM' ,`task_id_jnr`='dict_related_column(list2)a' WHERE task_id_snr='dict_relationship(list1)' AND task_id_jnr='dict_related_column(list2)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 20:02:00' ,`revised_user`='AJM' ,`task_id_jnr`='dict_related_column(list2)a' WHERE task_id_snr='dict_relationship(list2)c' AND task_id_jnr='dict_related_column(list2)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 20:02:00' ,`revised_user`='AJM' ,`task_id_jnr`='dict_related_column(list2)a' WHERE task_id_snr='dict_relationship(list2)a' AND task_id_jnr='dict_related_column(list2)';

UPDATE `mnu_role_task` SET `revised_date`='2012-06-23 20:02:00' ,`revised_user`='AJM' ,`task_id`='dict_related_column(list2)a' WHERE role_id='DEMO' AND task_id='dict_related_column(list2)';

UPDATE `mnu_task` SET `revised_date`='2012-06-23 20:02:01' ,`revised_user`='AJM' ,`task_id`='dict_related_column(list2)a' WHERE task_id='dict_related_column(list2)';

UPDATE `mnu_task` SET `revised_date`='2012-06-23 20:04:33' ,`revised_user`='AJM' ,`script_id`='related_column(multi4)a.php' ,`task_desc`='Update Child Relationship' WHERE task_id='dict_related_column(multi4)';

UPDATE `help_text` SET `revised_date`='2012-06-23 20:04:48' ,`revised_user`='AJM' ,`task_id`='dict_related_column(multi4)a' WHERE task_id='dict_related_column(multi4)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 20:04:48' ,`revised_user`='AJM' ,`task_id_jnr`='dict_related_column(multi4)a' WHERE task_id_snr='dict_related_column(list2)a' AND task_id_jnr='dict_related_column(multi4)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 20:04:48' ,`revised_user`='AJM' ,`task_id_jnr`='dict_related_column(multi4)a' WHERE task_id_snr='dict_relationship(list1)' AND task_id_jnr='dict_related_column(multi4)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 20:04:48' ,`revised_user`='AJM' ,`task_id_jnr`='dict_related_column(multi4)a' WHERE task_id_snr='dict_relationship(list2)c' AND task_id_jnr='dict_related_column(multi4)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 20:04:48' ,`revised_user`='AJM' ,`task_id_jnr`='dict_related_column(multi4)a' WHERE task_id_snr='dict_relationship(list2)a' AND task_id_jnr='dict_related_column(multi4)';

UPDATE `mnu_task` SET `revised_date`='2012-06-23 20:04:49' ,`revised_user`='AJM' ,`task_id`='dict_related_column(multi4)a' WHERE task_id='dict_related_column(multi4)';

UPDATE `mnu_task` SET `revised_date`='2012-06-23 20:11:01' ,`revised_user`='AJM' ,`script_id`='relationship(output2)a.php' WHERE task_id='dict_relationship(output2)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 20:11:15' ,`revised_user`='AJM' ,`task_id_jnr`='dict_relationship(output2)a' WHERE task_id_snr='dict_relationship(list1)' AND task_id_jnr='dict_relationship(output2)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 20:11:16' ,`revised_user`='AJM' ,`task_id_jnr`='dict_relationship(output2)a' WHERE task_id_snr='dict_relationship(list2)c' AND task_id_jnr='dict_relationship(output2)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 20:11:16' ,`revised_user`='AJM' ,`task_id_jnr`='dict_relationship(output2)a' WHERE task_id_snr='dict_relationship(list2)a' AND task_id_jnr='dict_relationship(output2)';

UPDATE `mnu_role_task` SET `revised_date`='2012-06-23 20:11:16' ,`revised_user`='AJM' ,`task_id`='dict_relationship(output2)a' WHERE role_id='DEMO' AND task_id='dict_relationship(output2)';

UPDATE `mnu_task` SET `revised_date`='2012-06-23 20:11:16' ,`revised_user`='AJM' ,`task_id`='dict_relationship(output2)a' WHERE task_id='dict_relationship(output2)';

UPDATE `mnu_task` SET `revised_date`='2012-06-23 20:12:52' ,`revised_user`='AJM' ,`script_id`='relationship(output3)a.php' WHERE task_id='dict_relationship(output3)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 20:13:07' ,`revised_user`='AJM' ,`task_id_jnr`='dict_relationship(output3)a' WHERE task_id_snr='dict_relationship(list1)' AND task_id_jnr='dict_relationship(output3)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 20:13:07' ,`revised_user`='AJM' ,`task_id_jnr`='dict_relationship(output3)a' WHERE task_id_snr='dict_relationship(list2)c' AND task_id_jnr='dict_relationship(output3)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-23 20:13:07' ,`revised_user`='AJM' ,`task_id_jnr`='dict_relationship(output3)a' WHERE task_id_snr='dict_relationship(list2)a' AND task_id_jnr='dict_relationship(output3)';

UPDATE `mnu_role_task` SET `revised_date`='2012-06-23 20:13:07' ,`revised_user`='AJM' ,`task_id`='dict_relationship(output3)a' WHERE role_id='DEMO' AND task_id='dict_relationship(output3)';

UPDATE `mnu_task` SET `revised_date`='2012-06-23 20:13:08' ,`revised_user`='AJM' ,`task_id`='dict_relationship(output3)a' WHERE task_id='dict_relationship(output3)';

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Search' ,'N' ,'2012-06-23 20:19:02' ,'AJM' ,'001' ,'dict_relationship(search)' ,'dict_relationship(list2)b');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Delete' ,'Y' ,'2012-06-23 20:19:52' ,'AJM' ,'002' ,'dict_relationship(del4)' ,'dict_relationship(list2)b');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Audit Trail' ,'Y' ,'2012-06-23 20:20:52' ,'AJM' ,'003' ,'audit_dtl(list)3' ,'dict_relationship(list2)b');

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`order_by` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Update' ,'2012-06-24 19:11:12' ,'AJM' ,'N' ,'N' ,'N' ,'seq_in_index' ,'MULTI4' ,'related_column(multi4)b.php' ,'DICT' ,'Update Parent Relationship' ,'dict_related_column(multi4)b' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Update' ,'Y' ,'2012-06-24 19:13:15' ,'AJM' ,'004' ,'dict_related_column(multi4)b' ,'dict_relationship(list2)b');

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-24 19:13:43' ,`revised_user`='AJM' ,`sort_seq`='004' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-24 19:13:43' ,`revised_user`='AJM' ,`sort_seq`='003' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='dict_related_column(multi4)b';

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Related Columns' ,'2012-06-24 19:46:48' ,'AJM' ,'N' ,'N' ,'N' ,'LIST2' ,'related_column(list2)b.php' ,'DICT' ,'Enquire Parent Relationship' ,'dict_related_column(list2)b' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Related Columns' ,'Y' ,'2012-06-24 19:47:25' ,'AJM' ,'005' ,'dict_related_column(list2)b' ,'dict_relationship(list2)b');

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-24 19:47:53' ,`revised_user`='AJM' ,`sort_seq`='004' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='dict_relationship(search)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-24 19:47:54' ,`revised_user`='AJM' ,`sort_seq`='003' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='dict_relationship(del4)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-24 19:47:54' ,`revised_user`='AJM' ,`sort_seq`='002' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='dict_related_column(multi4)b';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-24 19:47:54' ,`revised_user`='AJM' ,`sort_seq`='005' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `button_text`='Read' ,`revised_date`='2012-06-24 19:47:54' ,`revised_user`='AJM' ,`sort_seq`='001' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='dict_related_column(list2)b';

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Update' ,'Y' ,'2012-06-24 19:49:46' ,'AJM' ,'001' ,'dict_related_column(multi4)b' ,'dict_related_column(list2)b');

UPDATE `mnu_nav_button` SET `context_preselect`='N' ,`revised_date`='2012-06-24 19:50:02' ,`revised_user`='AJM' WHERE task_id_snr='dict_related_column(list2)b' AND task_id_jnr='dict_related_column(multi4)b';

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('New' ,'2012-06-24 19:51:46' ,'AJM' ,'N' ,'N' ,'N' ,'ADD2' ,'relationship(add2)b.php' ,'DICT' ,'Add Parent Relationship' ,'dict_relationship(add2)b' ,'PROC' ,'N');

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('New' ,'Y' ,'2012-06-24 19:52:22' ,'AJM' ,'006' ,'dict_relationship(add2)b' ,'dict_relationship(list2)b');

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-24 19:52:55' ,`revised_user`='AJM' ,`sort_seq`='002' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='dict_related_column(list2)b';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-24 19:52:56' ,`revised_user`='AJM' ,`sort_seq`='003' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='dict_related_column(multi4)b';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-24 19:52:56' ,`revised_user`='AJM' ,`sort_seq`='004' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='dict_relationship(del4)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-24 19:52:56' ,`revised_user`='AJM' ,`sort_seq`='005' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='dict_relationship(search)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-06-24 19:52:56' ,`revised_user`='AJM' ,`sort_seq`='006' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `context_preselect`='N' ,`revised_date`='2012-06-24 19:52:56' ,`revised_user`='AJM' ,`sort_seq`='001' WHERE task_id_snr='dict_relationship(list2)b' AND task_id_jnr='dict_relationship(add2)b';

UPDATE `mnu_nav_button` SET `button_text`='Child Relationships' ,`revised_date`='2012-07-14 11:47:26' ,`revised_user`='AJM' WHERE task_id_snr='dict_table(list1)' AND task_id_jnr='dict_relationship(list2)a';

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Relationships (Parent)' ,'Y' ,'2012-07-14 11:48:05' ,'AJM' ,'011' ,'dict_relationship(list2)b' ,'dict_table(list1)');

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 11:48:39' ,`revised_user`='AJM' ,`sort_seq`='010' WHERE task_id_snr='dict_table(list1)' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 11:48:39' ,`revised_user`='AJM' ,`sort_seq`='011' WHERE task_id_snr='dict_table(list1)' AND task_id_jnr='dict_table(output2)';

UPDATE `mnu_nav_button` SET `button_text`='Parent Relationships' ,`revised_date`='2012-07-14 11:48:40' ,`revised_user`='AJM' ,`sort_seq`='009' WHERE task_id_snr='dict_table(list1)' AND task_id_jnr='dict_relationship(list2)b';

UPDATE `mnu_task` SET `revised_date`='2012-07-14 11:58:34' ,`revised_user`='AJM' ,`task_desc`='List Child Relationship by Database' WHERE task_id='dict_relationship(list2)c';

REPLACE INTO `mnu_task` (`button_text` ,`created_date` ,`created_user` ,`is_disabled` ,`keep_data` ,`log_sql_query` ,`pattern_id` ,`script_id` ,`subsys_id` ,`task_desc` ,`task_id` ,`task_type` ,`use_https`) VALUES
('Parent Relationships' ,'2012-07-14 11:59:29' ,'AJM' ,'N' ,'N' ,'N' ,'LIST2' ,'relationship(list2)d.php' ,'DICT' ,'List Parent Relationship by Database' ,'dict_relationship(list2)d' ,'PROC' ,'N');

UPDATE `mnu_task` SET `button_text`='Child Relationships' ,`revised_date`='2012-07-14 11:59:53' ,`revised_user`='AJM' ,`task_desc`='List Child Relationships by Database' WHERE task_id='dict_relationship(list2)c';

UPDATE `mnu_task` SET `revised_date`='2012-07-14 12:00:00' ,`revised_user`='AJM' ,`task_desc`='List Parent Relationships by Database' WHERE task_id='dict_relationship(list2)d';

UPDATE `mnu_task` SET `revised_date`='2012-07-14 12:12:17' ,`revised_user`='AJM' ,`script_id`='relationship(list2)b.php' WHERE task_id='dict_relationship(list2)b';

UPDATE `mnu_nav_button` SET `button_text`='Child Relationships' ,`revised_date`='2012-07-14 12:54:23' ,`revised_user`='AJM' WHERE task_id_snr='dict_database(list1)' AND task_id_jnr='dict_relationship(list2)c';

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Parent Relationships' ,'Y' ,'2012-07-14 12:54:59' ,'AJM' ,'013' ,'dict_relationship(list2)d' ,'dict_database(list1)');

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 12:56:42' ,`revised_user`='AJM' ,`sort_seq`='007' WHERE task_id_snr='dict_database(list1)' AND task_id_jnr='dict_table(list2)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 12:56:42' ,`revised_user`='AJM' ,`sort_seq`='008' WHERE task_id_snr='dict_database(list1)' AND task_id_jnr='dict_relationship(list2)c';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 12:56:42' ,`revised_user`='AJM' ,`sort_seq`='010' WHERE task_id_snr='dict_database(list1)' AND task_id_jnr='dict_database(upd4)export';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 12:56:42' ,`revised_user`='AJM' ,`sort_seq`='011' WHERE task_id_snr='dict_database(list1)' AND task_id_jnr='dict_database(erase1)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 12:56:42' ,`revised_user`='AJM' ,`sort_seq`='012' WHERE task_id_snr='dict_database(list1)' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 12:56:42' ,`revised_user`='AJM' ,`sort_seq`='013' WHERE task_id_snr='dict_database(list1)' AND task_id_jnr='audit_dtl(list)3exact';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 12:56:43' ,`revised_user`='AJM' ,`sort_seq`='006' WHERE task_id_snr='dict_database(list1)' AND task_id_jnr='dict_database(output2)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 12:56:43' ,`revised_user`='AJM' ,`sort_seq`='009' WHERE task_id_snr='dict_database(list1)' AND task_id_jnr='dict_relationship(list2)d';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 13:10:31' ,`revised_user`='AJM' ,`sort_seq`='009' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_table(upd4)export';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 13:10:31' ,`revised_user`='AJM' ,`sort_seq`='010' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_column(list2)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 13:10:32' ,`revised_user`='AJM' ,`sort_seq`='011' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_table_key(list2)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 13:10:32' ,`revised_user`='AJM' ,`sort_seq`='012' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_relationship(list2)a';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 13:10:32' ,`revised_user`='AJM' ,`sort_seq`='013' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_relationship(list2)b';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 13:10:32' ,`revised_user`='AJM' ,`sort_seq`='014' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 13:10:32' ,`revised_user`='AJM' ,`sort_seq`='015' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='audit_dtl(list)3exact';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 13:10:32' ,`revised_user`='AJM' ,`sort_seq`='007' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_relationship(list2)c';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 13:10:32' ,`revised_user`='AJM' ,`sort_seq`='008' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_table(output2)';

UPDATE `mnu_nav_button` SET `button_text`='Child Relationships (DB)' ,`revised_date`='2012-07-14 13:10:50' ,`revised_user`='AJM' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_relationship(list2)c';

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Parent Relationships' ,'Y' ,'2012-07-14 13:11:11' ,'AJM' ,'016' ,'dict_relationship(list2)d' ,'dict_table(list2)');

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 13:11:55' ,`revised_user`='AJM' ,`sort_seq`='009' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_table(output2)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 13:11:55' ,`revised_user`='AJM' ,`sort_seq`='010' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_table(upd4)export';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 13:11:55' ,`revised_user`='AJM' ,`sort_seq`='011' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_column(list2)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 13:11:55' ,`revised_user`='AJM' ,`sort_seq`='012' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_table_key(list2)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 13:11:55' ,`revised_user`='AJM' ,`sort_seq`='013' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_relationship(list2)a';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 13:11:55' ,`revised_user`='AJM' ,`sort_seq`='014' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_relationship(list2)b';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 13:11:55' ,`revised_user`='AJM' ,`sort_seq`='015' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 13:11:56' ,`revised_user`='AJM' ,`sort_seq`='016' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='audit_dtl(list)3exact';

UPDATE `mnu_nav_button` SET `button_text`='Parent Relationships(DB)' ,`revised_date`='2012-07-14 13:11:56' ,`revised_user`='AJM' ,`sort_seq`='008' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_relationship(list2)d';

UPDATE `mnu_nav_button` SET `context_preselect`='N' ,`revised_date`='2012-07-14 13:12:17' ,`revised_user`='AJM' WHERE task_id_snr='dict_table(list2)' AND task_id_jnr='dict_relationship(list2)d';

UPDATE `mnu_nav_button` SET `button_text`='Child Relationships' ,`revised_date`='2012-07-14 18:08:24' ,`revised_user`='AJM' WHERE task_id_snr='dict_column(list2)' AND task_id_jnr='dict_relationship(list2)a';

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Relationships (Parent)' ,'Y' ,'2012-07-14 18:08:45' ,'AJM' ,'013' ,'dict_relationship(list2)b' ,'dict_column(list2)');

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 18:09:21' ,`revised_user`='AJM' ,`sort_seq`='011' WHERE task_id_snr='dict_column(list2)' AND task_id_jnr='dict_table(upd4)export';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 18:09:21' ,`revised_user`='AJM' ,`sort_seq`='012' WHERE task_id_snr='dict_column(list2)' AND task_id_jnr='dict_column(output2)';

UPDATE `mnu_nav_button` SET `revised_date`='2012-07-14 18:09:21' ,`revised_user`='AJM' ,`sort_seq`='013' WHERE task_id_snr='dict_column(list2)' AND task_id_jnr='dict_column(output3)';

UPDATE `mnu_nav_button` SET `button_text`='Parent Relationships' ,`context_preselect`='N' ,`revised_date`='2012-07-14 18:09:22' ,`revised_user`='AJM' ,`sort_seq`='010' WHERE task_id_snr='dict_column(list2)' AND task_id_jnr='dict_relationship(list2)b';
