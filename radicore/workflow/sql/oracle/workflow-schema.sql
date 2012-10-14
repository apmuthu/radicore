CREATE USER "WORKFLOW" IDENTIFIED BY "WORKFLOW";
GRANT CONNECT, RESOURCE TO "WORKFLOW";
GRANT CREATE DATABASE LINK TO "WORKFLOW";
GRANT CREATE MATERIALIZED VIEW TO "WORKFLOW";
GRANT CREATE PROCEDURE TO "WORKFLOW";
GRANT CREATE PUBLIC SYNONYM TO "WORKFLOW";
GRANT CREATE ROLE TO "WORKFLOW";
GRANT CREATE SEQUENCE TO "WORKFLOW";
GRANT CREATE SYNONYM TO "WORKFLOW";
GRANT CREATE TABLE TO "WORKFLOW";
GRANT CREATE TRIGGER TO "WORKFLOW";
GRANT CREATE TYPE TO "WORKFLOW";
GRANT CREATE VIEW TO "WORKFLOW";

ALTER SESSION SET CURRENT_SCHEMA = "WORKFLOW";

-- 
-- Table structure for table wf_arc
-- 

CREATE TABLE wf_arc (
  workflow_id number(5) NOT NULL,
  transition_id number(5) NOT NULL,
  place_id number(5) NOT NULL,
  direction char(3) default 'IN' NOT NULL,
  arc_type varchar2(10) default 'SEQ' NOT NULL,
  pre_condition clob,
  created_date timestamp NOT NULL,
  created_user varchar2(16) NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (workflow_id,transition_id,place_id,direction)
);
CREATE INDEX  wf_arc_idx1 ON  wf_arc (workflow_id,place_id,direction);
CREATE INDEX  wf_arc_idx2 ON  wf_arc (workflow_id,transition_id,direction);

REVOKE ALL ON wf_arc FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON wf_arc TO PUBLIC;

-- 
-- Table structure for table wf_case
-- 

CREATE TABLE wf_case (
  rdcaccount_id number(10) default 1 NOT NULL,
  case_id number(10) NOT NULL,
  workflow_id number(5) NOT NULL,
  context varchar2(255) NOT NULL,
  case_status char(2) default 'OP' NOT NULL,
  start_date date NOT NULL,
  end_date date,
  created_date timestamp,
  created_user varchar2(16),
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (case_id)
);
CREATE INDEX  wf_case_idx1 ON  wf_case (workflow_id);
CREATE INDEX  wf_case_idx2 ON  wf_case (rdcaccount_id);

REVOKE ALL ON wf_case FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON wf_case TO PUBLIC;

-- 
-- Table structure for table wf_place
-- 

CREATE TABLE wf_place (
  workflow_id number(5) NOT NULL,
  place_id number(5) NOT NULL,
  place_type char(1) default '5' NOT NULL,
  place_name varchar2(80) NOT NULL,
  place_desc clob,
  created_date timestamp NOT NULL,
  created_user varchar2(16),
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (workflow_id,place_id)
);

REVOKE ALL ON wf_place FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON wf_place TO PUBLIC;

-- 
-- Table structure for table wf_token
-- 

CREATE TABLE wf_token (
  rdcaccount_id number(10) default 1 NOT NULL,
  case_id number(10) NOT NULL,
  token_id number(5) NOT NULL,
  workflow_id number(6) NOT NULL,
  place_id number(5) NOT NULL,
  context varchar2(255) NOT NULL,
  token_status varchar2(4) default 'FREE' NOT NULL,
  enabled_date date NOT NULL,
  cancelled_date date,
  consumed_date date,
  PRIMARY KEY  (case_id,token_id)
);
CREATE INDEX  wf_token_idx1 ON  wf_token (workflow_id,place_id);
CREATE INDEX  wf_token_idx2 ON  wf_token (rdcaccount_id);

REVOKE ALL ON wf_token FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON wf_token TO PUBLIC;

-- 
-- Table structure for table wf_transition
-- 

CREATE TABLE wf_transition (
  workflow_id number(5) NOT NULL,
  transition_id number(5) NOT NULL,
  transition_name varchar2(80) NOT NULL,
  transition_desc clob,
  transition_trigger varchar2(4) default 'USER' NOT NULL,
  time_limit number(5),
  task_id varchar2(80) NOT NULL,
  role_id varchar2(16),
  created_date timestamp NOT NULL,
  created_user varchar2(16) NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (workflow_id,transition_id)
);

REVOKE ALL ON wf_transition FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON wf_transition TO PUBLIC;

-- 
-- Table structure for table wf_workflow
-- 

CREATE TABLE wf_workflow (
  workflow_id number(5) NOT NULL,
  workflow_name varchar2(80) NOT NULL,
  workflow_desc clob,
  start_task_id varchar2(80) NOT NULL,
  is_valid char(1) default 'N' NOT NULL,
  workflow_errors clob,
  start_date date,
  end_date date,
  created_date timestamp NOT NULL,
  created_user varchar2(16) NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (workflow_id)
);

REVOKE ALL ON wf_workflow FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON wf_workflow TO PUBLIC;

-- 
-- Table structure for table wf_workitem
-- 

CREATE TABLE wf_workitem (
  rdcaccount_id number(10) default 1 NOT NULL,
  case_id number(10) NOT NULL,
  workitem_id number(5) NOT NULL,
  workflow_id number(6) NOT NULL,
  transition_id number(5) NOT NULL,
  transition_trigger varchar2(4) default 'USER' NOT NULL,
  task_id varchar2(80) NOT NULL,
  context varchar2(255) NOT NULL,
  workitem_status char(2) default 'EN' NOT NULL,
  enabled_date date,
  cancelled_date date,
  finished_date date,
  deadline date,
  role_id varchar2(16),
  user_id varchar2(16),
  PRIMARY KEY  (case_id,workitem_id)
);
CREATE INDEX  wf_workitem_idx1 ON  wf_workitem (workflow_id,transition_id);
CREATE INDEX  wf_workitem_idx2 ON  wf_workitem (rdcaccount_id);

REVOKE ALL ON wf_workitem FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON wf_workitem TO PUBLIC;
