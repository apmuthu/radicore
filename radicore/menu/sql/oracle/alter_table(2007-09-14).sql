ALTER SESSION SET CURRENT_SCHEMA = "MENU";

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

ALTER TABLE MENU.MNU_USER ADD (rdcaccount_id  NUMBER(10));
CREATE INDEX  mnu_user_idx3 ON  mnu_user (rdcaccount_id);

INSERT INTO `mnu_account` (`rdcaccount_id`, `account_name`, `rdcversion`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES
(1, 'Shared Account', 1, '2007-09-13 11:41:52', 'AJM', NULL, NULL);
