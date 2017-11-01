-- SET search_path TO "menu";

ALTER TABLE mnu_account ALTER COLUMN account_name TYPE character varying (80);
ALTER TABLE mnu_account ADD COLUMN account_desc text;

ALTER TABLE mnu_favourite RENAME task_desc TO task_name;
ALTER TABLE mnu_favourite ALTER COLUMN task_name TYPE character varying (80);

ALTER TABLE mnu_pattern RENAME pattern_desc TO pattern_name;
ALTER TABLE mnu_pattern ALTER COLUMN pattern_name TYPE character varying (80);

ALTER TABLE mnu_pattern RENAME pattern_long_desc TO pattern_desc;
ALTER TABLE mnu_pattern ALTER COLUMN pattern_desc TYPE text;

ALTER TABLE mnu_role RENAME role_desc TO role_name;
ALTER TABLE mnu_role ALTER COLUMN role_name TYPE character varying (80);

ALTER TABLE mnu_role ADD COLUMN role_desc text;

ALTER TABLE mnu_saved_selection RENAME selection_desc TO selection_name;
ALTER TABLE mnu_saved_selection ALTER COLUMN selection_name TYPE character varying (80);

ALTER TABLE mnu_subsystem RENAME subsys_desc TO subsys_name;
ALTER TABLE mnu_subsystem ALTER COLUMN subsys_name TYPE character varying (80);
ALTER TABLE mnu_subsystem ADD COLUMN subsys_desc text;

UPDATE mnu_task SET is_disabled='N' WHERE is_disabled IS NULL;
UPDATE mnu_task SET keep_data='N' WHERE keep_data IS NULL;
UPDATE mnu_task SET log_sql_query='N' WHERE log_sql_query IS NULL;
UPDATE mnu_task SET use_https='N' WHERE use_https IS NULL;

ALTER TABLE mnu_task RENAME task_desc TO task_name;
ALTER TABLE mnu_task ALTER COLUMN task_name TYPE character varying (80);
ALTER TABLE mnu_task ADD COLUMN task_desc text;
ALTER TABLE mnu_task ALTER COLUMN button_text TYPE character varying (40);

ALTER TABLE mnu_task_alt RENAME task_desc TO task_name;
ALTER TABLE mnu_task_alt ALTER COLUMN task_name TYPE character varying (80);
ALTER TABLE mnu_task_alt ALTER COLUMN task_name SET NOT NULL;
ALTER TABLE mnu_task_alt ADD COLUMN task_desc text;
ALTER TABLE mnu_task_alt ALTER COLUMN task_desc SET NOT NULL;
ALTER TABLE mnu_task_alt ALTER COLUMN button_text TYPE character varying (40);
ALTER TABLE mnu_task_alt ALTER COLUMN button_text SET NOT NULL;

ALTER TABLE mnu_task_quicksearch ALTER COLUMN field_name TYPE character varying (80);

ALTER TABLE mnu_task_quicksearch_alt ALTER COLUMN field_name TYPE character varying (80);

ALTER TABLE mnu_todo RENAME item_desc TO item_name;
ALTER TABLE mnu_todo ALTER COLUMN item_name TYPE character varying (80);
ALTER TABLE mnu_todo RENAME item_notes TO item_desc;
ALTER TABLE mnu_todo ALTER COLUMN item_desc TYPE text ;

ALTER TABLE mnu_user ALTER COLUMN user_name TYPE character varying (40);

ALTER TABLE mnu_user_alt ALTER COLUMN user_name TYPE character varying (40);

UPDATE mnu_user SET email_addr=user_id || '@null.null' WHERE email_addr IS NULL OR email_addr='';

-- update database contents
UPDATE mnu_task_quicksearch SET field_id='database_name', field_name='Database Name' WHERE field_id='database_desc';
UPDATE mnu_task_quicksearch SET field_id='table_name', field_name='Table Name' WHERE field_id='table_desc';
UPDATE mnu_task_quicksearch SET field_id='pattern_name', field_name='Pattern Name' WHERE field_id='pattern_desc';
UPDATE mnu_task_quicksearch SET field_id='role_name', field_name='Role Name' WHERE field_id='role_desc';
UPDATE mnu_task_quicksearch SET field_id='subsys_name', field_name='Subsystem Name' WHERE field_id='subsys_desc';
UPDATE mnu_task_quicksearch SET field_id='task_name', field_name='Task Name' WHERE field_id='task_desc';
UPDATE mnu_task_quicksearch SET field_id='item_name', field_name='Item Name' WHERE field_id='item_desc';

-- combine separate DATE and TIME fields into a single DATETIME field
ALTER TABLE mnu_user ADD COLUMN pswd_change_datetime timestamp without time zone;
UPDATE mnu_user SET pswd_change_datetime=(pswd_chg_date + pswd_chg_time) WHERE pswd_change_datetime IS NULL;
ALTER TABLE mnu_user DROP COLUMN pswd_chg_date;
ALTER TABLE mnu_user DROP COLUMN pswd_chg_time;

ALTER TABLE mnu_user ADD COLUMN logon_datetime timestamp without time zone;
UPDATE mnu_user SET logon_datetime=(logon_date + logon_time) WHERE logon_datetime IS NULL;
ALTER TABLE mnu_user DROP COLUMN logon_date;
ALTER TABLE mnu_user DROP COLUMN logon_time;

-- changes to allow output for responsive gui
ALTER TABLE mnu_role ADD COLUMN allow_responsive_gui character(1) DEFAULT 'N' NOT NULL;
ALTER TABLE mnu_task ADD COLUMN allow_responsive_gui character(1) DEFAULT 'N' NOT NULL;
ALTER TABLE mnu_user ADD COLUMN allow_responsive_gui character(1) DEFAULT 'N' NOT NULL;

-- finish