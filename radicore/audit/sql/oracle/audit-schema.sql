CREATE USER "AUDIT" IDENTIFIED BY "AUDIT";
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
  ip_address varchar2(40) NOT NULL,
  user_id varchar2(16),
  user_password varchar2(16) NOT NULL,
  email_addr varchar2(50),
  PRIMARY KEY  (id)
);
REVOKE ALL ON audit_logon_errors FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON audit_logon_errors TO PUBLIC;

CREATE SEQUENCE audit_logon_errors_seq;
REVOKE ALL ON audit_logon_errors_seq FROM PUBLIC;
GRANT SELECT,ALTER ON audit_logon_errors_seq TO PUBLIC;

-- 
-- Table structure for table `audit_ssn`
-- 

CREATE TABLE audit_ssn (
  session_id number(20) NOT NULL,
  user_id varchar2(16) NOT NULL DEFAULT 'UNKNOWN',
  ssn_datetime timestamp NOT NULL,
  PRIMARY KEY  (session_id)
);
CREATE INDEX "AUDIT_SSN_DATETIME" ON "AUDIT_SSN" ("SSN_DATETIME");

REVOKE ALL ON audit_ssn FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON audit_ssn TO PUBLIC;

CREATE SEQUENCE audit_ssn_seq;
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
  trn_datetime timestamp NOT NULL,
  task_id varchar2(80) NOT NULL,
  PRIMARY KEY  (session_id,tran_seq_no)
);
CREATE INDEX "AUDIT_TRN_DATETIME" ON "AUDIT_TRN" ("TRN_DATETIME");

REVOKE ALL ON audit_trn FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON audit_trn TO PUBLIC;

-- 
-- Table structure for table `php_session`
-- 

CREATE TABLE php_session (
  session_id varchar2(256) NOT NULL,
  user_id varchar2(16),
  date_created timestamp NOT NULL,
  last_updated timestamp NOT NULL,
  session_data clob,
  PRIMARY KEY  (session_id)
);
CREATE INDEX php_session_idx1 ON php_session (last_updated);

REVOKE ALL ON php_session FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON php_session TO PUBLIC;
