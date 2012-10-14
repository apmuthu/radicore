ALTER SESSION SET CURRENT_SCHEMA = "MENU";

CREATE TABLE mnu_initial_value_role (
  role_id varchar2(16) NOT NULL,
  task_id varchar2(80) NOT NULL,
  field_id varchar2(40) NOT NULL,
  initial_value varchar2(40),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (role_id,task_id,field_id)
);
CREATE INDEX  mnu_initial_value_role_idx1 ON  mnu_initial_value_role (task_id);

REVOKE ALL ON mnu_initial_value_role FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_initial_value_role TO PUBLIC;

CREATE TABLE mnu_initial_value_user (
  user_id varchar2(16) NOT NULL,
  task_id varchar2(80) NOT NULL,
  field_id varchar2(40) NOT NULL,
  initial_value varchar2(40),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (user_id,task_id,field_id)
);
CREATE INDEX  mnu_initial_value_user_idx1 ON  mnu_initial_value_user (task_id);

REVOKE ALL ON mnu_initial_value_user FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_initial_value_user TO PUBLIC;

ALTER TABLE MNU_TODO ADD visibility NUMBER(3) NULL;
UPDATE MNU_TODO SET visibility=7;
ALTER TABLE MNU_TODO MODIFY visibility NOT NULL;
ALTER TABLE MNU_TODO ADD repeat_interval DECIMAL(3,0) NULL;
ALTER TABLE MNU_TODO ADD repeat_unit CHAR(1) NULL;
ALTER TABLE MNU_TODO ADD task_id VARCHAR(80) NULL;
ALTER TABLE MNU_TODO ADD task_context VARCHAR(255) NULL;
