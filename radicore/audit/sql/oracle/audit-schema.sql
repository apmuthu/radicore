CREATE USER "AUDIT" IDENTIFIED BY "audit";
GRANT CONNECT, RESOURCE TO "AUDIT";
GRANT CREATE DATABASE LINK TO "AUDIT";
GRANT CREATE MATERIALIZED VIEW TO "AUDIT";
GRANT CREATE PROCEDURE TO "AUDIT";
GRANT CREATE PUBLIC SYNONYM TO "AUDIT";
GRANT CREATE ROLE TO "AUDIT";
GRANT CREATE SEQUENCE TO "AUDIT";
GRANT CREATE SYNONYM TO "AUDIT";
GRANT CREATE TABLE TO "AUDIT";
GRANT CREATE TRIGGER TO "AUDIT";
GRANT CREATE TYPE TO "AUDIT";
GRANT CREATE VIEW TO "AUDIT";

ALTER SESSION SET CURRENT_SCHEMA = "AUDIT";

-- 
-- Table structure for table `audit_fld`
-- 

CREATE TABLE audit_fld (
  session_id number(20) NOT NULL,
  tran_seq_no number(6) NOT NULL,
  table_seq_no number(6) NOT NULL,
  field_id varchar2(255) NOT NULL,
  old_value clob,
  new_value clob,
  PRIMARY KEY  (session_id,tran_seq_no,table_seq_no,field_id)
);
CREATE INDEX  audit_fld_idx1 ON  audit_fld (field_id);

REVOKE ALL ON audit_fld FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON audit_fld TO PUBLIC;

-- 
-- Table structure for table `audit_logon_errors`
-- 

CREATE TABLE audit_logon_errors (
  id number(10) NOT NULL,
  err_timestamp timestamp NOT NULL,
  ip_address varchar(16) NOT NULL,
  user_id varchar2(16) NOT NULL,
  user_password varchar2(16) NOT NULL,
  PRIMARY KEY  (id)
);
CREATE SEQUENCE audit_logon_errors_seq;

REVOKE ALL ON audit_logon_errors FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON audit_logon_errors TO PUBLIC;
REVOKE ALL ON audit_logon_errors_seq FROM PUBLIC;
GRANT SELECT,ALTER ON audit_logon_errors_seq TO PUBLIC;

-- 
-- Table structure for table `audit_ssn`
-- 

CREATE TABLE audit_ssn (
  session_id number(20) NOT NULL,
  user_id varchar2(16) NOT NULL,
  ssn_date date NOT NULL,
  ssn_time char(8) NOT NULL,
  PRIMARY KEY  (session_id)
);
CREATE SEQUENCE audit_ssn_seq;

REVOKE ALL ON audit_ssn FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON audit_ssn TO PUBLIC;
REVOKE ALL ON audit_ssn_seq FROM PUBLIC;
GRANT SELECT,ALTER ON audit_ssn_seq TO PUBLIC;

-- 
-- Table structure for table `audit_tbl`
-- 

CREATE TABLE audit_tbl (
  session_id number(20) NOT NULL,
  tran_seq_no number(6) NOT NULL,
  table_seq_no number(6) NOT NULL,
  base_name varchar2(64) NOT NULL,
  table_name varchar2(64) NOT NULL,
  pkey varchar2(255) NOT NULL,
  PRIMARY KEY  (session_id,tran_seq_no,table_seq_no)
);
CREATE INDEX audit_tbl_idx1 ON audit_tbl (pkey);

REVOKE ALL ON audit_tbl FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON audit_tbl TO PUBLIC;

-- 
-- Table structure for table `audit_trn`
-- 

CREATE TABLE audit_trn (
  session_id number(20) NOT NULL,
  tran_seq_no number(6) NOT NULL,
  trn_date date NOT NULL,
  trn_time char(8) NOT NULL,
  task_id varchar2(40) NOT NULL,
  PRIMARY KEY  (session_id,tran_seq_no)
);

REVOKE ALL ON audit_trn FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON audit_trn TO PUBLIC;

-- 
-- Table structure for table `php_session`
-- 

CREATE TABLE php_session (
  session_id varchar2(32) NOT NULL,
  user_id varchar2(16),
  date_created timestamp NOT NULL,
  last_updated timestamp NOT NULL,
  session_data clob,
  PRIMARY KEY  (session_id)
);
CREATE INDEX php_session_idx1 ON php_session (last_updated);

REVOKE ALL ON php_session FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON php_session TO PUBLIC;
