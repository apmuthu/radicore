-- SET search_path TO "menu";

ALTER TABLE mnu_user_role ADD COLUMN sort_seq int NULL;
ALTER TABLE mnu_user_role ADD COLUMN start_date date NOT NULL DEFAULT '2000-01-01';
ALTER TABLE mnu_user_role ADD COLUMN end_date date DEFAULT '9999-12-31';

UPDATE mnu_user_role SET sort_seq=1 WHERE is_primary='Y';
UPDATE mnu_user_role SET sort_seq=9 WHERE is_primary='N';
UPDATE mnu_user_role SET start_date=created_date;
UPDATE mnu_user_role SET end_date='9999-12-31';

-- exec #Drop_Default_Constraint @TableName='mnu_user_role', @ColumnName='is_primary';
ALTER TABLE mnu_user_role DROP COLUMN is_primary;

ALTER TABLE mnu_user_role ALTER COLUMN sort_seq SET NOT NULL;

-- 2017-07-21
ALTER TABLE mnu_saved_selection_data ADD COLUMN sort_seq SMALLINT NULL;
ALTER TABLE mnu_saved_selection_data ADD COLUMN output_name character varying(80) NULL;

-- finish