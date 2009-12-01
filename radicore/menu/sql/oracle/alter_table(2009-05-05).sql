ALTER SESSION SET CURRENT_SCHEMA = "MENU";

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

CREATE UNIQUE INDEX MNU_MOTD_PK ON MNU_MOTD (MOTD_ID);

CREATE SEQUENCE mnu_motd_seq; 

GRANT DELETE, INSERT, SELECT, UPDATE ON  MNU_USER TO PUBLIC;

