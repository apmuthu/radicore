ALTER SESSION SET CURRENT_SCHEMA = "AUDIT";

ALTER TABLE AUDIT_LOGON_ERRORS MODIFY (IP_ADDRESS VARCHAR2(40 BYTE) );
