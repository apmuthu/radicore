ALTER SESSION SET CURRENT_SCHEMA = "MENU";

CREATE TABLE mnu_language (
  language_id varchar(5) default 'EN' NOT NULL,
  language_name varchar(40) default 'English' NOT NULL,
  created_date timestamp default '2000-01-01 00:00:00' NOT NULL,
  created_user varchar(16) default 'UNKNOWN',
  revised_date timestamp default NULL,
  revised_user varchar(16) default NULL,
  PRIMARY KEY  (language_id)
);
GRANT DELETE, INSERT, SELECT, UPDATE ON  mnu_language TO PUBLIC;

alter table MENU.MNU_USER ADD (radius_id VARCHAR2(40));
alter table MENU.MNU_USER ADD (is_radius_auth_off CHAR(1) DEFAULT 'N');

ALTER TABLE MENU.MNU_ROLE ADD (is_radius_auth_off CHAR(1) DEFAULT 'N');
ALTER TABLE MENU.MNU_ROLE MODIFY(GLOBAL_ACCESS  DEFAULT 'N');

ALTER TABLE MENU.MNU_INITIAL_VALUE_ROLE ADD (is_noedit CHAR(1) DEFAULT 'N');
ALTER TABLE MENU.MNU_INITIAL_VALUE_USER ADD (is_noedit CHAR(1) DEFAULT 'N');

ALTER TABLE MENU.MNU_TASK MODIFY(SETTINGS VARCHAR2(255));
