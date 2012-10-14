ALTER SESSION SET CURRENT_SCHEMA = "MENU";

CREATE INDEX  mnu_role_taskfield_idx1 ON  mnu_role_taskfield (task_id);

CREATE TABLE mnu_initial_value (
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
CREATE INDEX  mnu_initial_value_idx1 ON  mnu_initial_value (task_id);

REVOKE ALL ON mnu_initial_value FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_initial_value TO PUBLIC;
