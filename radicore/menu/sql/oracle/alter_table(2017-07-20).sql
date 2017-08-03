ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
SET SCAN OFF;

-- ALTER SESSION SET CURRENT_SCHEMA = "MENU";

ALTER TABLE mnu_user_role ADD (sort_seq NUMBER (6,0) );
ALTER TABLE mnu_user_role ADD (start_date DATE DEFAULT '2000-01-01' NOT NULL );
ALTER TABLE mnu_user_role ADD (end_date DATE DEFAULT '9999-12-31' NULL );

UPDATE mnu_user_role SET sort_seq=1 WHERE is_primary='Y';
UPDATE mnu_user_role SET sort_seq=9 WHERE is_primary='N';
UPDATE mnu_user_role SET start_date=created_date;
UPDATE mnu_user_role SET end_date='9999-12-31';

ALTER TABLE mnu_user_role DROP COLUMN is_primary;
ALTER TABLE mnu_user_role MODIFY (sort_seq INT NOT NULL );

-- 2017-07-21
ALTER TABLE mnu_saved_selection_data ADD (sort_seq NUMBER (6,0) );
ALTER TABLE mnu_saved_selection_data ADD (output_name VARCHAR2(80) );

-- finish