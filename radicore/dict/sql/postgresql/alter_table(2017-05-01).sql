SET search_path TO "dict";

ALTER TABLE dict_column RENAME column_desc TO column_name;
ALTER TABLE dict_column ALTER COLUMN column_name TYPE character varying (80);
ALTER TABLE dict_column RENAME col_comment TO column_desc;

ALTER TABLE dict_database RENAME database_desc TO database_name;
ALTER TABLE dict_database ALTER COLUMN database_name TYPE character varying (80);
ALTER TABLE dict_database RENAME db_comment TO database_desc;

ALTER TABLE dict_relationship RENAME relation_desc TO relation_name;
ALTER TABLE dict_relationship ALTER COLUMN relation_name TYPE character varying (80);
ALTER TABLE dict_relationship RENAME rel_comment TO relation_desc;
ALTER TABLE dict_relationship RENAME rel_type TO relation_type;

ALTER TABLE dict_table RENAME table_desc TO table_name;
ALTER TABLE dict_table ALTER COLUMN table_name TYPE character varying (80);
ALTER TABLE dict_table RENAME tbl_comment TO table_desc;

-- finish