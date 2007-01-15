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
  task_id varchar2(40) NOT NULL,
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
-- Table structure for table mnu_menu
-- 

CREATE TABLE mnu_menu (
  menu_id varchar2(40) NOT NULL,
  task_id_jnr varchar2(40) NOT NULL,
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
-- Table structure for table mnu_nav_button
-- 

CREATE TABLE mnu_nav_button (
  task_id_snr varchar2(40) NOT NULL,
  task_id_jnr varchar2(40) NOT NULL,
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
  start_task_id varchar2(40),
  global_access char(1),
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
  task_id varchar2(40) NOT NULL,
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
  task_id varchar2(40) NOT NULL,
  field_id varchar2(40) NOT NULL,
  access_type varchar2(4),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (role_id,task_id,field_id)
);

REVOKE ALL ON mnu_role_taskfield FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_role_taskfield TO PUBLIC;

-- 
-- Table structure for table mnu_subsystem
-- 

CREATE TABLE mnu_subsystem (
  subsys_id varchar2(8) NOT NULL,
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
  task_id varchar2(40) NOT NULL,
  task_desc varchar2(50) NOT NULL,
  button_text varchar2(40),
  task_type varchar2(4),
  script_id varchar2(40),
  is_disabled char(1),
  pattern_id varchar2(16),
  subsys_id varchar2(8),
  initial_passthru varchar2(40),
  selection_fixed varchar2(255),
  selection_temp varchar2(255),
  settings varchar2(40),
  order_by varchar2(255),
  keep_data char(1),
  log_sql_query char(1),
  screen_refresh number(5),
  use_https char(1),
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
  task_id varchar2(40) NOT NULL,
  field_id varchar2(40) NOT NULL,
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
  is_complete char(1) default 'N' NOT NULL,
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
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (user_id)
);
CREATE UNIQUE INDEX  mnu_user_idx1 ON  mnu_user (email_addr);
CREATE INDEX  mnu_user_idx2 ON  mnu_user (role_id);

REVOKE ALL ON mnu_user FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_user TO PUBLIC;