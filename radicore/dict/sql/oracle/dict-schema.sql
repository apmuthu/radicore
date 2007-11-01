CREATE USER "DICT" IDENTIFIED BY "dict";
GRANT CONNECT, RESOURCE TO "DICT";
GRANT CREATE DATABASE LINK TO "DICT";
GRANT CREATE MATERIALIZED VIEW TO "DICT";
GRANT CREATE PROCEDURE TO "DICT";
GRANT CREATE PUBLIC SYNONYM TO "DICT";
GRANT CREATE ROLE TO "DICT";
GRANT CREATE SEQUENCE TO "DICT";
GRANT CREATE SYNONYM TO "DICT";
GRANT CREATE TABLE TO "DICT";
GRANT CREATE TRIGGER TO "DICT";
GRANT CREATE TYPE TO "DICT";
GRANT CREATE VIEW TO "DICT";

ALTER SESSION SET CURRENT_SCHEMA = "DICT";

-- 
-- Table structure for table dict_column
-- 

CREATE TABLE dict_column (
  database_id varchar2(64) NOT NULL,
  table_id varchar2(64) NOT NULL,
  column_id varchar2(64) NOT NULL,
  column_seq number(6) NOT NULL,
  column_desc varchar2(255) NOT NULL,
  col_comment clob,
  col_type varchar2(20) NOT NULL,
  col_type_native varchar2(32) NOT NULL,
  col_array_type varchar2(20),
  col_values clob,
  user_size number(20),
  col_maxsize number(20),
  col_null char(1) default 'Y' NOT NULL,
  is_required char(1) default 'N' NOT NULL,
  col_key char(3), 
  col_default varchar2(40),
  col_auto_increment char(1) default 'N' NOT NULL,
  col_unsigned char(1) default 'N' NOT NULL,
  col_zerofill_bwz varchar2(3),
  col_precision number(3),
  col_scale number(3),
  col_minvalue number,
  col_maxvalue number,
  user_minvalue number,
  user_maxvalue number,
  noedit_nodisplay char(3),
  no_search char(3),
  no_audit char(3),
  upper_lowercase varchar2(5),
  is_password char(1) default 'N' NOT NULL,
  auto_insert char(1) default 'N' NOT NULL,
  auto_update char(1) default 'N' NOT NULL,
  infinityisnull char(1) default 'N' NOT NULL,
  col_subtype varchar2(10),
  image_width number(6),
  image_height number(5),
  is_boolean char(1) default 'N' NOT NULL,
  boolean_true varchar2(4),
  boolean_false varchar2(4),
  control varchar2(10),
  optionlist varchar2(64),
  checkbox_label varchar2(64),
  task_id varchar2(80),
  foreign_field varchar2(64),
  align_hv char(1),
  align_lr char(1),
  multi_cols number(3),
  multi_rows number(3),
  custom_validation varchar2(255),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (database_id,table_id,column_id)
);

REVOKE ALL ON dict_column FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON dict_column TO PUBLIC;

-- 
-- Table structure for table dict_database
-- 

CREATE TABLE dict_database (
  database_id varchar2(64) NOT NULL,
  database_desc varchar2(255) NOT NULL,
  db_comment clob,
  subsys_id varchar2(16) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (database_id)
);

REVOKE ALL ON dict_database FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON dict_database TO PUBLIC;

-- 
-- Table structure for table dict_related_column
-- 

CREATE TABLE dict_related_column (
  database_id_snr varchar2(64) NOT NULL,
  table_id_snr varchar2(64) NOT NULL,
  column_id_snr varchar2(64) NOT NULL,
  database_id_jnr varchar2(64) NOT NULL,
  table_id_jnr varchar2(64) NOT NULL,
  seq_no number(3) NOT NULL,
  column_id_jnr varchar2(64),
  seq_in_index number(4) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (database_id_snr,table_id_snr,column_id_snr,database_id_jnr,table_id_jnr,seq_no)
);

REVOKE ALL ON dict_related_column FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON dict_related_column TO PUBLIC;

-- 
-- Table structure for table dict_relationship
-- 

CREATE TABLE dict_relationship (
  database_id_snr varchar2(64) NOT NULL,
  table_id_snr varchar2(64) NOT NULL,
  database_id_jnr varchar2(64) NOT NULL,
  table_id_jnr varchar2(64) NOT NULL,
  seq_no number(3) NOT NULL,
  table_alias_snr varchar2(64),
  table_alias_jnr varchar2(64),
  relation_desc varchar2(255),
  rel_comment clob,
  rel_type char(3) NOT NULL,
  orderby varchar2(64),
  parent_field varchar2(64),
  calc_field varchar2(255),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (database_id_snr,table_id_snr,database_id_jnr,table_id_jnr,seq_no)
);

REVOKE ALL ON dict_relationship FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON dict_relationship TO PUBLIC;

-- 
-- Table structure for table dict_table
-- 

CREATE TABLE dict_table (
  database_id varchar2(64) NOT NULL,
  table_id varchar2(64) NOT NULL,
  table_desc varchar2(255) NOT NULL,
  tbl_comment clob,
  audit_logging char(1) default 'Y' NOT NULL,
  default_orderby varchar2(64),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (database_id,table_id)
);

REVOKE ALL ON dict_table FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON dict_table TO PUBLIC;

-- 
-- Table structure for table dict_table_key
-- 

CREATE TABLE dict_table_key (
  database_id varchar2(64) NOT NULL,
  table_id varchar2(64) NOT NULL,
  key_name varchar2(64) NOT NULL,
  column_id varchar2(64) NOT NULL,
  seq_in_index number(3) NOT NULL,
  is_unique char(1) default 'N' NOT NULL,
  column_seq number(3),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (database_id,table_id,key_name,column_id)
);

REVOKE ALL ON dict_table_key FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON dict_table_key TO PUBLIC;
