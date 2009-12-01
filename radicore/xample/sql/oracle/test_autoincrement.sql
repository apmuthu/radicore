CREATE TABLE test_autoincrement (
  id number(10) NOT NULL,
  field1 varchar2(40) default NULL,
  field2 varchar2(255) default NULL,
  PRIMARY KEY  (id)
);
CREATE SEQUENCE test_autoincrement_seq;

REVOKE ALL ON test_autoincrement FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON test_autoincrement TO PUBLIC;
REVOKE ALL ON test_autoincrement_seq FROM PUBLIC;
GRANT SELECT,ALTER ON test_autoincrement_seq TO PUBLIC;

