CREATE USER "MENU" IDENTIFIED BY "menu";
GRANT CONNECT, RESOURCE TO "MENU";
GRANT CREATE DATABASE LINK TO "MENU";
GRANT CREATE MATERIALIZED VIEW TO "MENU";
GRANT CREATE PROCEDURE TO "MENU";
GRANT CREATE PUBLIC SYNONYM TO "MENU";
GRANT CREATE ROLE TO "MENU";
GRANT CREATE SEQUENCE TO "MENU";
GRANT CREATE SYNONYM TO "MENU";
GRANT CREATE TABLE TO "MENU";
GRANT CREATE TRIGGER TO "MENU";
GRANT CREATE TYPE TO "MENU";
GRANT CREATE VIEW TO "MENU";

ALTER SESSION SET CURRENT_SCHEMA = "MENU";

-- 
-- Table structure for table help_text
-- 

CREATE TABLE help_text (
  task_id varchar2(80) NOT NULL,
  help_text clob,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (task_id)
);

REVOKE ALL ON help_text FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON help_text TO PUBLIC;

--
-- Table structure for table mnu_account
--

CREATE TABLE mnu_account (
  rdcaccount_id number(10) NOT NULL,
  account_name varchar2(255) NOT NULL,
  rdcversion number(10) default 1 NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (rdcaccount_id)
);
CREATE SEQUENCE mnu_account_seq; 

REVOKE ALL ON mnu_account FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_account TO PUBLIC;
REVOKE ALL ON mnu_account_seq FROM PUBLIC; 
GRANT SELECT,ALTER ON mnu_account_seq TO PUBLIC; 

-- 
-- Table structure for table mnu_control
-- 

CREATE TABLE mnu_control (
  record_id varchar2(16) NOT NULL,
  field_id varchar2(32) NOT NULL,
  field_value varchar2(255),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (record_id,field_id)
);

REVOKE ALL ON mnu_control FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_control TO PUBLIC;

-- 
-- Table structure for table mnu_initial_value_role 
-- 

CREATE TABLE mnu_initial_value_role (
  role_id varchar2(16) NOT NULL,
  task_id varchar2(80) NOT NULL,
  field_id varchar2(40) NOT NULL,
  initial_value varchar2(255),
  is_noedit char(1) default 'N',
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (role_id,task_id,field_id)
);
CREATE INDEX  mnu_initial_value_role_idx1 ON  mnu_initial_value_role (task_id);

REVOKE ALL ON mnu_initial_value_role FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_initial_value_role TO PUBLIC;

-- 
-- Table structure for table mnu_initial_value_user 
-- 

CREATE TABLE mnu_initial_value_user (
  user_id varchar2(16) NOT NULL,
  task_id varchar2(80) NOT NULL,
  field_id varchar2(40) NOT NULL,
  initial_value varchar2(255),
  is_noedit char(1) default 'N',
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (user_id,task_id,field_id)
);
CREATE INDEX  mnu_initial_value_user_idx1 ON  mnu_initial_value_user (task_id);

REVOKE ALL ON mnu_initial_value_user FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_initial_value_user TO PUBLIC;

-- 
-- Table structure for table mnu_language
-- 

CREATE TABLE mnu_language (
  language_id varchar(5) default 'EN' NOT NULL,
  language_name varchar(40) default 'English' NOT NULL,
  created_date timestamp default '2000-01-01 00:00:00' NOT NULL,
  created_user varchar(16) default 'UNKNOWN',
  revised_date timestamp default NULL,
  revised_user varchar(16) default NULL,
  PRIMARY KEY  (language_id)
);

REVOKE ALL ON mnu_language FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_language TO PUBLIC;

-- 
-- Table structure for table mnu_menu
-- 

CREATE TABLE mnu_menu (
  menu_id varchar2(80) NOT NULL,
  task_id_jnr varchar2(80) NOT NULL,
  sort_seq number(3) default '000' NOT NULL,
  button_text varchar2(40),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (menu_id,task_id_jnr)
);

REVOKE ALL ON mnu_menu FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_menu TO PUBLIC;

-- 
-- Table structure for table mnu_motd
-- 

CREATE TABLE MNU_MOTD
(
  MOTD_ID       NUMBER                          NOT NULL,
  MOTD_SUBJECT  CHAR(80 BYTE)                   NOT NULL,
  MOTD_MESSAGE  CLOB                            NOT NULL,
  START_DATE    DATE                            DEFAULT '2001-01-01'          NOT NULL,
  END_DATE      DATE                            DEFAULT '9999-12-31',
  role_id       varchar2(16 byte),
  CREATED_DATE  TIMESTAMP(6)                    DEFAULT '2001-01-01'          NOT NULL,
  CREATED_USER  VARCHAR2(16 BYTE)               DEFAULT 'UNKNOWN'             NOT NULL,
  REVISED_DATE  TIMESTAMP(6),
  REVISED_USER  VARCHAR2(16 BYTE)
);
CREATE SEQUENCE mnu_motd_seq; 

CREATE UNIQUE INDEX MNU_MOTD_PK ON MNU_MOTD (MOTD_ID);

REVOKE ALL ON mnu_motd FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_motd TO PUBLIC;
REVOKE ALL ON mnu_motd_seq FROM PUBLIC; 
GRANT SELECT,ALTER ON mnu_motd_seq TO PUBLIC; 

-- 
-- Table structure for table mnu_nav_button
-- 

CREATE TABLE mnu_nav_button (
  task_id_snr varchar2(80) NOT NULL,
  task_id_jnr varchar2(80) NOT NULL,
  sort_seq number(3) default '000' NOT NULL,
  button_text varchar2(40),
  context_preselect char(1),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (task_id_snr,task_id_jnr)
);

REVOKE ALL ON mnu_nav_button FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_nav_button TO PUBLIC;

-- 
-- Table structure for table mnu_pattern
-- 

CREATE TABLE mnu_pattern (
  pattern_id varchar2(16) NOT NULL,
  pattern_desc varchar2(60) NOT NULL,
  pattern_long_desc clob,
  visible_screen char(1),
  context_preselect char(1),
  keep_data char(1),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (pattern_id)
);

REVOKE ALL ON mnu_pattern FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_pattern TO PUBLIC;

-- 
-- Table structure for table mnu_role
-- 

CREATE TABLE mnu_role (
  role_id varchar2(16) NOT NULL,
  role_desc varchar2(30) NOT NULL,
  start_task_id varchar2(80),
  global_access char(1) default 'N',
  is_external_auth_off char(1) default 'N',
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (role_id)
);

REVOKE ALL ON mnu_role FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_role TO PUBLIC;

-- 
-- Table structure for table mnu_role_task
-- 

CREATE TABLE mnu_role_task (
  role_id varchar2(16) NOT NULL,
  task_id varchar2(80) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (role_id,task_id)
);

REVOKE ALL ON mnu_role_task FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_role_task TO PUBLIC;

-- 
-- Table structure for table mnu_role_taskfield
-- 

CREATE TABLE mnu_role_taskfield (
  role_id varchar2(16) NOT NULL,
  task_id varchar2(80) NOT NULL,
  field_id varchar2(40) NOT NULL,
  access_type varchar2(4),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (role_id,task_id,field_id)
);
CREATE INDEX  mnu_role_taskfield_idx1 ON  mnu_role_taskfield (task_id);

REVOKE ALL ON mnu_role_taskfield FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_role_taskfield TO PUBLIC;

-- 
-- Table structure for table mnu_subsystem
-- 

CREATE TABLE mnu_subsystem (
  subsys_id varchar2(16) NOT NULL,
  subsys_desc varchar2(255) NOT NULL,
  subsys_dir varchar2(255),
  task_prefix varchar2(8),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (subsys_id)
);

REVOKE ALL ON mnu_subsystem FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_subsystem TO PUBLIC;

-- 
-- Table structure for table mnu_task
-- 

CREATE TABLE mnu_task (
  task_id varchar2(80) NOT NULL,
  task_desc varchar2(80) NOT NULL,
  button_text varchar2(80),
  task_type varchar2(4),
  script_id varchar2(80),
  is_disabled char(1),
  pattern_id varchar2(16),
  subsys_id varchar2(16),
  initial_passthru varchar2(40),
  selection_fixed varchar2(255),
  selection_temp varchar2(255),
  settings varchar2(255),
  order_by varchar2(255),
  keep_data char(1),
  log_sql_query char(1),
  screen_refresh number(5),
  use_https char(1),
  max_execution_time number(5),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (task_id)
);
CREATE INDEX  mnu_task_idx1 ON  mnu_task (subsys_id);
CREATE INDEX  mnu_task_idx2 ON  mnu_task (pattern_id);

REVOKE ALL ON mnu_task FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_task TO PUBLIC;

-- 
-- Table structure for table mnu_task_field
-- 

CREATE TABLE mnu_task_field (
  task_id varchar2(80) NOT NULL,
  field_id varchar2(40) NOT NULL,
  field_desc varchar2(255),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (task_id,field_id)
);

REVOKE ALL ON mnu_task_field FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_task_field TO PUBLIC;

-- 
-- Table structure for table mnu_todo
-- 

CREATE TABLE mnu_todo (
  user_id varchar2(16) NOT NULL,
  seq_no number(6) NOT NULL,
  item_desc varchar2(80) NOT NULL,
  item_notes clob,
  due_date date NOT NULL,
  visibility number(3) NOT NULL,
  is_complete char(1) default 'N' NOT NULL,
  repeat_interval decimal(3,0),
  repeat_unit char(1),
  task_id varchar2(80),
  task_context varchar2(255) default NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (user_id,seq_no)
);

REVOKE ALL ON mnu_todo FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_todo TO PUBLIC;

-- 
-- Table structure for table mnu_user
-- 

CREATE TABLE mnu_user (
  user_id varchar2(16) NOT NULL,
  user_name varchar2(30) NOT NULL,
  user_password varchar2(40) NOT NULL,
  role_id varchar2(16) NOT NULL,
  rdcaccount_id number(10),
  pswd_chg_date date,
  pswd_chg_time char(8),
  pswd_count number(6),
  in_use char(1) default 'N' NOT NULL,
  is_disabled char(1) default 'N' NOT NULL,
  logon_date date,
  logon_time char(8),
  language_code varchar2(6),
  start_date date NOT NULL,
  end_date date,
  ip_address varchar2(16),
  email_addr varchar2(50),
  external_id varchar2(255),
  is_external_auth_off char(1) default 'N',
  party_id number(10),
  user_timezone varchar2(40),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (user_id)
);
CREATE UNIQUE INDEX  mnu_user_idx1 ON  mnu_user (email_addr);
CREATE INDEX  mnu_user_idx2 ON  mnu_user (role_id);
CREATE INDEX  mnu_user_idx3 ON  mnu_user (rdcaccount_id);

REVOKE ALL ON mnu_user FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_user TO PUBLIC;

CREATE TABLE mnu_user_ip_address (
  user_id varchar2(16) NOT NULL,
  ip_address varchar2(40) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (user_id, ip_address)
);

REVOKE ALL ON mnu_user_ip_address FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_user_ip_address TO PUBLIC;

CREATE TABLE mnu_task_ip_address (
  task_id varchar2(80) NOT NULL,
  ip_address varchar2(40) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (task_id, ip_address)
);

REVOKE ALL ON mnu_task_ip_address FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_task_ip_address TO PUBLIC;

