-- USE `menu`;

ALTER TABLE `help_text` CHANGE COLUMN `help_text` `help_text` TEXT NOT NULL AFTER `task_id`;
ALTER TABLE `help_text_alt` CHANGE COLUMN `help_text` `help_text` TEXT NOT NULL AFTER `language_id`;

ALTER TABLE `mnu_account` ALTER `account_name` DROP DEFAULT;
ALTER TABLE `mnu_account` CHANGE COLUMN `account_name` `account_name` VARCHAR(80) NOT NULL AFTER `rdcaccount_id`;
ALTER TABLE `mnu_account` ADD COLUMN `account_desc` TEXT NULL DEFAULT NULL AFTER `account_name`;

ALTER TABLE `mnu_favourite` ALTER `task_id` DROP DEFAULT;
ALTER TABLE `mnu_favourite` CHANGE COLUMN `task_id` `task_id` VARCHAR(80) NOT NULL AFTER `seq_no`;
ALTER TABLE `mnu_favourite` CHANGE COLUMN `task_desc` `task_name` VARCHAR(80) NOT NULL AFTER `task_id`;
ALTER TABLE `mnu_favourite` ALTER `seq_no` DROP DEFAULT;
ALTER TABLE `mnu_favourite` CHANGE COLUMN `seq_no` `seq_no` SMALLINT(10) UNSIGNED NOT NULL AFTER `user_id`;
ALTER TABLE `mnu_favourite` ALTER `sort_seq` DROP DEFAULT;
ALTER TABLE `mnu_favourite` CHANGE COLUMN `sort_seq` `sort_seq` SMALLINT(10) UNSIGNED NOT NULL AFTER `task_name`;

ALTER TABLE `mnu_initial_value_role` CHANGE COLUMN `is_noedit` `is_noedit` CHAR(1) NOT NULL DEFAULT 'N' AFTER `initial_value`;

ALTER TABLE `mnu_initial_value_user` CHANGE COLUMN `is_noedit` `is_noedit` CHAR(1) NOT NULL DEFAULT 'N' AFTER `initial_value`;

ALTER TABLE `mnu_language` ALTER `language_name` DROP DEFAULT;
ALTER TABLE `mnu_language` CHANGE COLUMN `language_name` `language_name` VARCHAR(40) NOT NULL AFTER `language_id`;

ALTER TABLE `mnu_motd` ALTER `motd_subject` DROP DEFAULT;
ALTER TABLE `mnu_motd` CHANGE COLUMN `motd_subject` `motd_subject` VARCHAR(80) NOT NULL AFTER `motd_id`;

ALTER TABLE `mnu_pattern` CHANGE COLUMN `pattern_desc` `pattern_name` VARCHAR(80) NOT NULL AFTER `pattern_id`;
ALTER TABLE `mnu_pattern` CHANGE COLUMN `pattern_long_desc` `pattern_desc` TEXT NULL AFTER `pattern_name`;
ALTER TABLE `mnu_pattern` CHANGE COLUMN `visible_screen` `visible_screen` CHAR(1) NOT NULL DEFAULT 'N' AFTER `pattern_desc`;
ALTER TABLE `mnu_pattern` CHANGE COLUMN `context_preselect` `context_preselect` CHAR(1) NOT NULL DEFAULT 'N' AFTER `visible_screen`;
ALTER TABLE `mnu_pattern` CHANGE COLUMN `keep_data` `keep_data` CHAR(1) NOT NULL DEFAULT 'N' AFTER `context_preselect`;

UPDATE mnu_nav_button SET button_text=SUBSTRING(button_text,1,40);

ALTER TABLE `mnu_nav_button` ALTER `button_text` DROP DEFAULT;
ALTER TABLE `mnu_nav_button` CHANGE COLUMN `button_text` `button_text` VARCHAR(40) NOT NULL AFTER `sort_seq`;
ALTER TABLE `mnu_nav_button` CHANGE COLUMN `context_preselect` `context_preselect` CHAR(1) NOT NULL DEFAULT 'N' AFTER `button_text`;

ALTER TABLE `mnu_role` ALTER `role_desc` DROP DEFAULT;
ALTER TABLE `mnu_role` CHANGE COLUMN `role_desc` `role_name` VARCHAR(80) NOT NULL AFTER `role_id`;
ALTER TABLE `mnu_role` ADD COLUMN `role_desc` TEXT NULL DEFAULT NULL AFTER `role_name`;
ALTER TABLE `mnu_role` ALTER `start_task_id` DROP DEFAULT;
ALTER TABLE `mnu_role` CHANGE COLUMN `start_task_id` `start_task_id` VARCHAR(80) NOT NULL AFTER `role_desc`;
ALTER TABLE `mnu_role` CHANGE COLUMN `global_access` `global_access` CHAR(1) NOT NULL DEFAULT 'N' AFTER `start_task_id`;
ALTER TABLE `mnu_role` CHANGE COLUMN `is_external_auth_off` `is_external_auth_off` CHAR(1) NOT NULL DEFAULT 'N' AFTER `global_access`;

ALTER TABLE `mnu_saved_selection` ALTER `selection_desc` DROP DEFAULT;
ALTER TABLE `mnu_saved_selection` CHANGE COLUMN `selection_desc` `selection_name` VARCHAR(80) NOT NULL AFTER `selection_id`;

ALTER TABLE `mnu_subsystem` ALTER `subsys_desc` DROP DEFAULT;
ALTER TABLE `mnu_subsystem` CHANGE COLUMN `subsys_desc` `subsys_name` VARCHAR(80) NOT NULL AFTER `subsys_id`;
ALTER TABLE `mnu_subsystem` ADD COLUMN `subsys_desc` TEXT NULL AFTER `subsys_name`;
ALTER TABLE `mnu_subsystem` ALTER `subsys_dir` DROP DEFAULT;
ALTER TABLE `mnu_subsystem` CHANGE COLUMN `subsys_dir` `subsys_dir` VARCHAR(255) NOT NULL AFTER `subsys_desc`;

UPDATE mnu_task SET is_disabled='N' WHERE is_disabled IS NULL;
UPDATE mnu_task SET keep_data='N' WHERE keep_data IS NULL;
UPDATE mnu_task SET log_sql_query='N' WHERE log_sql_query IS NULL;
UPDATE mnu_task SET use_https='N' WHERE use_https IS NULL;

UPDATE mnu_task SET button_text=SUBSTRING(button_text,1,40);
UPDATE mnu_task SET button_text='.' WHERE button_text IS NULL;

ALTER TABLE `mnu_task` ALTER `task_desc` DROP DEFAULT;
ALTER TABLE `mnu_task` CHANGE COLUMN `task_desc` `task_name` VARCHAR(80) NOT NULL AFTER `task_id`;
ALTER TABLE `mnu_task` ADD COLUMN `task_desc` TEXT NULL AFTER `task_name`;
ALTER TABLE `mnu_task` ALTER `button_text` DROP DEFAULT;
ALTER TABLE `mnu_task` CHANGE COLUMN `button_text` `button_text` VARCHAR(40) NOT NULL AFTER `task_desc`;
ALTER TABLE `mnu_task` CHANGE COLUMN `keep_data` `keep_data` CHAR(1) NOT NULL DEFAULT 'N' AFTER `order_by`;
ALTER TABLE `mnu_task` CHANGE COLUMN `is_disabled` `is_disabled` CHAR(1) NOT NULL DEFAULT 'N' AFTER `script_id`;
ALTER TABLE `mnu_task` CHANGE COLUMN `log_sql_query` `log_sql_query` CHAR(1) NOT NULL DEFAULT 'N' AFTER `keep_data`;
ALTER TABLE `mnu_task` CHANGE COLUMN `use_https` `use_https` CHAR(1) NOT NULL DEFAULT 'N' AFTER `screen_refresh`;

ALTER TABLE `mnu_task_alt` ALTER `task_desc` DROP DEFAULT;
ALTER TABLE `mnu_task_alt` CHANGE COLUMN `task_desc` `task_name` VARCHAR(80) NOT NULL AFTER `language_id`;
ALTER TABLE `mnu_task_alt` ADD COLUMN `task_desc` TEXT NULL AFTER `task_name`;
ALTER TABLE `mnu_task_alt` ALTER `button_text` DROP DEFAULT;

UPDATE mnu_task_alt SET button_text=task_name WHERE button_text IS NULL;
ALTER TABLE `mnu_task_alt` CHANGE COLUMN `button_text` `button_text` VARCHAR(40) NOT NULL AFTER `task_desc`;

ALTER TABLE `mnu_task_quicksearch` ALTER `sort_seq` DROP DEFAULT;
ALTER TABLE `mnu_task_quicksearch` CHANGE COLUMN `sort_seq` `sort_seq` SMALLINT(5) UNSIGNED NOT NULL AFTER `field_id`;
ALTER TABLE `mnu_task_quicksearch` ALTER `field_name` DROP DEFAULT;
ALTER TABLE `mnu_task_quicksearch` CHANGE COLUMN `field_name` `field_name` VARCHAR(80) NOT NULL AFTER `sort_seq`;

ALTER TABLE `mnu_task_quicksearch_alt` ALTER `field_name` DROP DEFAULT;
ALTER TABLE `mnu_task_quicksearch_alt` CHANGE COLUMN `field_name` `field_name` VARCHAR(80) NOT NULL AFTER `language_id`;

ALTER TABLE `mnu_time_limit_role` ALTER `seq_no` DROP DEFAULT;
ALTER TABLE `mnu_time_limit_role` CHANGE COLUMN `seq_no` `seq_no` SMALLINT(5) UNSIGNED NOT NULL AFTER `role_id`;

ALTER TABLE `mnu_time_limit_user` ALTER `seq_no` DROP DEFAULT;
ALTER TABLE `mnu_time_limit_user` CHANGE COLUMN `seq_no` `seq_no` SMALLINT(5) UNSIGNED NOT NULL AFTER `user_id`;

ALTER TABLE `mnu_todo` ALTER `item_desc` DROP DEFAULT;
ALTER TABLE `mnu_todo`CHANGE COLUMN `item_desc` `item_name` VARCHAR(80) NOT NULL AFTER `seq_no`;
ALTER TABLE `mnu_todo` CHANGE COLUMN `item_notes` `item_desc` TEXT NULL AFTER `item_name`;
ALTER TABLE `mnu_todo` ALTER `seq_no` DROP DEFAULT;
ALTER TABLE `mnu_todo` CHANGE COLUMN `seq_no` `seq_no` SMALLINT(10) UNSIGNED NOT NULL AFTER `user_id`;
ALTER TABLE `mnu_todo` CHANGE COLUMN `is_complete` `is_complete` CHAR(1) NOT NULL DEFAULT 'N' AFTER `visibility`;

UPDATE mnu_user SET email_addr=CONCAT(user_id,'@null.null') WHERE email_addr IS NULL;

ALTER TABLE `mnu_user` ALTER `email_addr` DROP DEFAULT;
ALTER TABLE `mnu_user` CHANGE COLUMN `email_addr` `email_addr` VARCHAR(50) NOT NULL AFTER `ip_address`;
ALTER TABLE `mnu_user` ALTER `user_name` DROP DEFAULT;
ALTER TABLE `mnu_user` CHANGE COLUMN `user_name` `user_name` VARCHAR(40) NOT NULL AFTER `user_id`;

ALTER TABLE `mnu_user_alt` ALTER `user_id` DROP DEFAULT;
ALTER TABLE `mnu_user_alt` CHANGE COLUMN `user_id` `user_id` VARCHAR(16) NOT NULL FIRST;
ALTER TABLE `mnu_user_alt` ALTER `language_id` DROP DEFAULT;
ALTER TABLE `mnu_user_alt` CHANGE COLUMN `language_id` `language_id` VARCHAR(5) NOT NULL AFTER `user_id`;
ALTER TABLE `mnu_user_alt` ALTER `user_name` DROP DEFAULT;
ALTER TABLE `mnu_user_alt` CHANGE COLUMN `user_name` `user_name` VARCHAR(40) NOT NULL AFTER `language_id`;

ALTER TABLE `mnu_user_role` CHANGE COLUMN `is_primary` `is_primary` CHAR(1) NOT NULL DEFAULT 'N' AFTER `role_id`;

-- update database contents
UPDATE mnu_task_quicksearch SET field_id='database_name', field_name='Database Name' WHERE field_id='database_desc';
UPDATE mnu_task_quicksearch SET field_id='table_name', field_name='Table Name' WHERE field_id='table_desc';
UPDATE mnu_task_quicksearch SET field_id='pattern_name', field_name='Pattern Name' WHERE field_id='pattern_desc';
UPDATE mnu_task_quicksearch SET field_id='role_name', field_name='Role Name' WHERE field_id='role_desc';
UPDATE mnu_task_quicksearch SET field_id='subsys_name', field_name='Subsystem Name' WHERE field_id='subsys_desc';
UPDATE mnu_task_quicksearch SET field_id='task_name', field_name='Task Name' WHERE field_id='task_desc';
UPDATE mnu_task_quicksearch SET field_id='item_name', field_name='Item Name' WHERE field_id='item_desc';

-- combine separate DATE and TIME fields into a single DATETIME field
ALTER TABLE `mnu_user` ADD COLUMN `pswd_change_datetime` DATETIME NULL NULL AFTER `rdcaccount_id`;
UPDATE `mnu_user` SET `pswd_change_datetime`=TIMESTAMP(pswd_chg_date, pswd_chg_time) WHERE pswd_change_datetime IS NULL;
ALTER TABLE `mnu_user` DROP COLUMN `pswd_chg_date`;
ALTER TABLE `mnu_user` DROP COLUMN `pswd_chg_time`;

ALTER TABLE `mnu_user` ADD COLUMN `logon_datetime` DATETIME NULL NULL AFTER `is_disabled`;
UPDATE `mnu_user` SET `logon_datetime`=TIMESTAMP(logon_date, logon_time) WHERE logon_datetime IS NULL;
ALTER TABLE `mnu_user` DROP COLUMN `logon_date`;
ALTER TABLE `mnu_user` DROP COLUMN `logon_time`;

-- changes to allow output for responsive gui
ALTER TABLE `mnu_role` ADD COLUMN `allow_responsive_gui` CHAR(1) NOT NULL DEFAULT 'N' AFTER `is_external_auth_off`;
ALTER TABLE `mnu_task` ADD COLUMN `allow_responsive_gui` CHAR(1) NOT NULL DEFAULT 'N' AFTER `task_id_run_at_cancel`;
ALTER TABLE `mnu_user` ADD COLUMN `allow_responsive_gui` CHAR(1) NOT NULL DEFAULT 'N' AFTER `user_timezone`;

-- finish