ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
SET SCAN OFF;

ALTER SESSION SET CURRENT_SCHEMA = "MENU";

ALTER TABLE MENU.MNU_TODO ADD (object_id  VARCHAR2(255 BYTE));
