ALTER SESSION SET CURRENT_SCHEMA = "MENU";

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
