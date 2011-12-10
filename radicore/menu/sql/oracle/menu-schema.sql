CREATE USER "MENU" IDENTIFIED BY "menu";
GRANT CONNECT, RESOURCE TO "MENU";
GRANT CREATE DATABASE LINK TO "MENU";
GRANT CREATE MATERIALIZED VIEW TO "MENU";
GRANT CREATE PROCEDURE TO "MENU";
GRANT CREATE PUBLIC SYNONYM TO "MENU";
GRANT CREATE ROLE TO "MENU";
GRANT CREATE SEQUENCE TO "MENU";
GRANT CREATE SYNONYM TO "MENU";
GRANT CREATE TABLE TO "MENU";
GRANT CREATE TRIGGER TO "MENU";
GRANT CREATE TYPE TO "MENU";
GRANT CREATE VIEW TO "MENU";

ALTER SESSION SET CURRENT_SCHEMA = "MENU";

--------------------------------------------------------
--  DDL for Sequence MNU_ACCOUNT_SEQ
--------------------------------------------------------

  CREATE SEQUENCE  "MNU_ACCOUNT_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

  GRANT ALTER ON "MNU_ACCOUNT_SEQ" TO PUBLIC;
  GRANT SELECT ON "MNU_ACCOUNT_SEQ" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Sequence MNU_MOTD_SEQ
--------------------------------------------------------

  CREATE SEQUENCE  "MNU_MOTD_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

  GRANT ALTER ON "MNU_MOTD_SEQ" TO PUBLIC;
  GRANT SELECT ON "MNU_MOTD_SEQ" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table HELP_TEXT
--------------------------------------------------------

  CREATE TABLE "HELP_TEXT" 
   (	"TASK_ID" VARCHAR2(80), 
	"HELP_TEXT" CLOB, 
	"CREATED_DATE" TIMESTAMP (6), 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "HELP_TEXT" TO PUBLIC;
 
  GRANT INSERT ON "HELP_TEXT" TO PUBLIC;
 
  GRANT SELECT ON "HELP_TEXT" TO PUBLIC;
 
  GRANT UPDATE ON "HELP_TEXT" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_ACCOUNT
--------------------------------------------------------

  CREATE TABLE "MNU_ACCOUNT" 
   (	"RDCACCOUNT_ID" NUMBER(10,0), 
	"ACCOUNT_NAME" VARCHAR2(255), 
	"RDCVERSION" NUMBER(10,0) DEFAULT 1, 
	"CREATED_DATE" TIMESTAMP (6), 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "MNU_ACCOUNT" TO PUBLIC;
 
  GRANT INSERT ON "MNU_ACCOUNT" TO PUBLIC;
 
  GRANT SELECT ON "MNU_ACCOUNT" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_ACCOUNT" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_CONTROL
--------------------------------------------------------

  CREATE TABLE "MNU_CONTROL" 
   (	"RECORD_ID" VARCHAR2(16), 
	"FIELD_ID" VARCHAR2(32), 
	"FIELD_VALUE" VARCHAR2(255), 
	"CREATED_DATE" TIMESTAMP (6), 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "MNU_CONTROL" TO PUBLIC;
 
  GRANT INSERT ON "MNU_CONTROL" TO PUBLIC;
 
  GRANT SELECT ON "MNU_CONTROL" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_CONTROL" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_FAVOURITE
--------------------------------------------------------

  CREATE TABLE "MNU_FAVOURITE" 
   (	"USER_ID" VARCHAR2(16), 
	"SEQ_NO" NUMBER(6,0), 
	"TASK_ID" VARCHAR2(80), 
	"TASK_DESC" VARCHAR2(80), 
	"SORT_SEQ" NUMBER(6,0), 
        "BREADCRUMBS" VARCHAR2(4000), 
	"CREATED_DATE" TIMESTAMP (6), 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "MNU_FAVOURITE" TO PUBLIC;
 
  GRANT INSERT ON "MNU_FAVOURITE" TO PUBLIC;
 
  GRANT SELECT ON "MNU_FAVOURITE" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_FAVOURITE" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_INITIAL_VALUE_ROLE
--------------------------------------------------------

  CREATE TABLE "MNU_INITIAL_VALUE_ROLE" 
   (	"ROLE_ID" VARCHAR2(16), 
	"TASK_ID" VARCHAR2(80), 
	"FIELD_ID" VARCHAR2(40), 
	"INITIAL_VALUE" VARCHAR2(255), 
	"IS_NOEDIT" CHAR(1) DEFAULT 'N', 
	"CREATED_DATE" TIMESTAMP (6), 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "MNU_INITIAL_VALUE_ROLE" TO PUBLIC;
 
  GRANT INSERT ON "MNU_INITIAL_VALUE_ROLE" TO PUBLIC;
 
  GRANT SELECT ON "MNU_INITIAL_VALUE_ROLE" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_INITIAL_VALUE_ROLE" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_INITIAL_VALUE_USER
--------------------------------------------------------

  CREATE TABLE "MNU_INITIAL_VALUE_USER" 
   (	"USER_ID" VARCHAR2(16), 
	"TASK_ID" VARCHAR2(80), 
	"FIELD_ID" VARCHAR2(40), 
	"INITIAL_VALUE" VARCHAR2(255), 
	"IS_NOEDIT" CHAR(1) DEFAULT 'N', 
	"CREATED_DATE" TIMESTAMP (6), 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "MNU_INITIAL_VALUE_USER" TO PUBLIC;
 
  GRANT INSERT ON "MNU_INITIAL_VALUE_USER" TO PUBLIC;
 
  GRANT SELECT ON "MNU_INITIAL_VALUE_USER" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_INITIAL_VALUE_USER" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_LANGUAGE
--------------------------------------------------------

  CREATE TABLE "MNU_LANGUAGE" 
   (	"LANGUAGE_ID" VARCHAR2(5) DEFAULT 'EN', 
	"LANGUAGE_NAME" VARCHAR2(40) DEFAULT 'English', 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2000-01-01 00:00:00', 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6) DEFAULT NULL, 
	"REVISED_USER" VARCHAR2(16) DEFAULT NULL
   ) ;
  GRANT DELETE ON "MNU_LANGUAGE" TO PUBLIC;
 
  GRANT INSERT ON "MNU_LANGUAGE" TO PUBLIC;
 
  GRANT SELECT ON "MNU_LANGUAGE" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_LANGUAGE" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_MENU
--------------------------------------------------------

  CREATE TABLE "MNU_MENU" 
   (	"MENU_ID" VARCHAR2(80), 
	"TASK_ID_JNR" VARCHAR2(80), 
	"SORT_SEQ" NUMBER(3,0) DEFAULT '000', 
	"BUTTON_TEXT" VARCHAR2(40), 
	"CREATED_DATE" TIMESTAMP (6), 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "MNU_MENU" TO PUBLIC;
 
  GRANT INSERT ON "MNU_MENU" TO PUBLIC;
 
  GRANT SELECT ON "MNU_MENU" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_MENU" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_MOTD
--------------------------------------------------------

  CREATE TABLE "MNU_MOTD" 
   (	"MOTD_ID" NUMBER, 
	"MOTD_SUBJECT" CHAR(80), 
	"MOTD_MESSAGE" CLOB, 
	"START_DATE" DATE DEFAULT '2001-01-01', 
	"END_DATE" DATE DEFAULT '9999-12-31', 
	"ROLE_ID" VARCHAR2(16), 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "MNU_MOTD" TO PUBLIC;
 
  GRANT INSERT ON "MNU_MOTD" TO PUBLIC;
 
  GRANT SELECT ON "MNU_MOTD" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_MOTD" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_NAV_BUTTON
--------------------------------------------------------

  CREATE TABLE "MNU_NAV_BUTTON" 
   (	"TASK_ID_SNR" VARCHAR2(80), 
	"TASK_ID_JNR" VARCHAR2(80), 
	"SORT_SEQ" NUMBER(3,0) DEFAULT '000', 
	"BUTTON_TEXT" VARCHAR2(40), 
	"CONTEXT_PRESELECT" CHAR(1), 
	"CREATED_DATE" TIMESTAMP (6), 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "MNU_NAV_BUTTON" TO PUBLIC;
 
  GRANT INSERT ON "MNU_NAV_BUTTON" TO PUBLIC;
 
  GRANT SELECT ON "MNU_NAV_BUTTON" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_NAV_BUTTON" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_PATTERN
--------------------------------------------------------

  CREATE TABLE "MNU_PATTERN" 
   (	"PATTERN_ID" VARCHAR2(16), 
	"PATTERN_DESC" VARCHAR2(60), 
	"PATTERN_LONG_DESC" CLOB, 
	"VISIBLE_SCREEN" CHAR(1), 
	"CONTEXT_PRESELECT" CHAR(1), 
	"KEEP_DATA" CHAR(1), 
	"CREATED_DATE" TIMESTAMP (6), 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "MNU_PATTERN" TO PUBLIC;
 
  GRANT INSERT ON "MNU_PATTERN" TO PUBLIC;
 
  GRANT SELECT ON "MNU_PATTERN" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_PATTERN" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_ROLE
--------------------------------------------------------

  CREATE TABLE "MNU_ROLE" 
   (	"ROLE_ID" VARCHAR2(16), 
	"ROLE_DESC" VARCHAR2(30), 
	"START_TASK_ID" VARCHAR2(80), 
	"GLOBAL_ACCESS" CHAR(1) DEFAULT 'N', 
	"IS_EXTERNAL_AUTH_OFF" CHAR(1) DEFAULT 'N', 
	"CREATED_DATE" TIMESTAMP (6), 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "MNU_ROLE" TO PUBLIC;
 
  GRANT INSERT ON "MNU_ROLE" TO PUBLIC;
 
  GRANT SELECT ON "MNU_ROLE" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_ROLE" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_ROLE_TASK
--------------------------------------------------------

  CREATE TABLE "MNU_ROLE_TASK" 
   (	"ROLE_ID" VARCHAR2(16), 
	"TASK_ID" VARCHAR2(80), 
	"CREATED_DATE" TIMESTAMP (6), 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "MNU_ROLE_TASK" TO PUBLIC;
 
  GRANT INSERT ON "MNU_ROLE_TASK" TO PUBLIC;
 
  GRANT SELECT ON "MNU_ROLE_TASK" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_ROLE_TASK" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_ROLE_TASKFIELD
--------------------------------------------------------

  CREATE TABLE "MNU_ROLE_TASKFIELD" 
   (	"ROLE_ID" VARCHAR2(16), 
	"TASK_ID" VARCHAR2(80), 
	"FIELD_ID" VARCHAR2(40), 
	"ACCESS_TYPE" VARCHAR2(4), 
	"CREATED_DATE" TIMESTAMP (6), 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "MNU_ROLE_TASKFIELD" TO PUBLIC;
 
  GRANT INSERT ON "MNU_ROLE_TASKFIELD" TO PUBLIC;
 
  GRANT SELECT ON "MNU_ROLE_TASKFIELD" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_ROLE_TASKFIELD" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_SUBSYSTEM
--------------------------------------------------------

  CREATE TABLE "MNU_SUBSYSTEM" 
   (	"SUBSYS_ID" VARCHAR2(16), 
	"SUBSYS_DESC" VARCHAR2(255), 
	"SUBSYS_DIR" VARCHAR2(255), 
	"TASK_PREFIX" VARCHAR2(8), 
	"CREATED_DATE" TIMESTAMP (6), 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "MNU_SUBSYSTEM" TO PUBLIC;
 
  GRANT INSERT ON "MNU_SUBSYSTEM" TO PUBLIC;
 
  GRANT SELECT ON "MNU_SUBSYSTEM" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_SUBSYSTEM" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_TASK
--------------------------------------------------------

  CREATE TABLE "MNU_TASK" 
   (	"TASK_ID" VARCHAR2(80), 
	"TASK_DESC" VARCHAR2(80), 
	"BUTTON_TEXT" VARCHAR2(80), 
	"TASK_TYPE" VARCHAR2(4), 
	"SCRIPT_ID" VARCHAR2(80), 
	"IS_DISABLED" CHAR(1), 
	"PATTERN_ID" VARCHAR2(16), 
	"SUBSYS_ID" VARCHAR2(16), 
	"INITIAL_PASSTHRU" VARCHAR2(80), 
	"SELECTION_FIXED" VARCHAR2(255), 
	"SELECTION_TEMP" VARCHAR2(255), 
	"SETTINGS" VARCHAR2(255), 
	"ORDER_BY" VARCHAR2(255), 
	"KEEP_DATA" CHAR(1), 
	"LOG_SQL_QUERY" CHAR(1), 
	"SCREEN_REFRESH" NUMBER(5,0), 
	"USE_HTTPS" CHAR(1), 
	"MAX_EXECUTION_TIME" NUMBER(5,0), 
        "TASK_ID_RUN_AT_END" VARCHAR2(80), 
	"TASK_ID_RUN_AT_CANCEL" VARCHAR2(80),
	"CREATED_DATE" TIMESTAMP (6), 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "MNU_TASK" TO PUBLIC;
 
  GRANT INSERT ON "MNU_TASK" TO PUBLIC;
 
  GRANT SELECT ON "MNU_TASK" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_TASK" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_TASK_FIELD
--------------------------------------------------------

  CREATE TABLE "MNU_TASK_FIELD" 
   (	"TASK_ID" VARCHAR2(80), 
	"FIELD_ID" VARCHAR2(40), 
	"FIELD_DESC" VARCHAR2(255), 
	"CREATED_DATE" TIMESTAMP (6), 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "MNU_TASK_FIELD" TO PUBLIC;
 
  GRANT INSERT ON "MNU_TASK_FIELD" TO PUBLIC;
 
  GRANT SELECT ON "MNU_TASK_FIELD" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_TASK_FIELD" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_TASK_IP_ADDRESS
--------------------------------------------------------

  CREATE TABLE "MNU_TASK_IP_ADDRESS" 
   (	"TASK_ID" VARCHAR2(80), 
	"IP_ADDRESS" VARCHAR2(40), 
	"CREATED_DATE" TIMESTAMP (6), 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "MNU_TASK_IP_ADDRESS" TO PUBLIC;
 
  GRANT INSERT ON "MNU_TASK_IP_ADDRESS" TO PUBLIC;
 
  GRANT SELECT ON "MNU_TASK_IP_ADDRESS" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_TASK_IP_ADDRESS" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_TODO
--------------------------------------------------------

  CREATE TABLE "MNU_TODO" 
   (	"USER_ID" VARCHAR2(16), 
	"SEQ_NO" NUMBER(6,0), 
	"ITEM_DESC" VARCHAR2(80), 
	"ITEM_NOTES" CLOB, 
	"DUE_DATE" DATE, 
	"VISIBILITY" NUMBER(3,0), 
	"IS_COMPLETE" CHAR(1) DEFAULT 'N', 
	"REPEAT_INTERVAL" NUMBER(3,0), 
	"REPEAT_UNIT" CHAR(1), 
	"TASK_ID" VARCHAR2(80), 
	"TASK_CONTEXT" VARCHAR2(255) DEFAULT NULL, 
	"CREATED_DATE" TIMESTAMP (6), 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "MNU_TODO" TO PUBLIC;
 
  GRANT INSERT ON "MNU_TODO" TO PUBLIC;
 
  GRANT SELECT ON "MNU_TODO" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_TODO" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_USER
--------------------------------------------------------

  CREATE TABLE "MNU_USER" 
   (	"USER_ID" VARCHAR2(16), 
	"USER_NAME" VARCHAR2(30), 
	"USER_PASSWORD" VARCHAR2(40), 
	"ROLE_ID" VARCHAR2(16), 
	"RDCACCOUNT_ID" NUMBER(10,0), 
	"PSWD_CHG_DATE" DATE, 
	"PSWD_CHG_TIME" CHAR(8), 
	"PSWD_COUNT" NUMBER(6,0), 
	"IN_USE" CHAR(1) DEFAULT 'N', 
	"IS_DISABLED" CHAR(1) DEFAULT 'N', 
	"LOGON_DATE" DATE, 
	"LOGON_TIME" CHAR(8), 
	"LANGUAGE_CODE" VARCHAR2(6), 
	"START_DATE" DATE, 
	"END_DATE" DATE, 
	"IP_ADDRESS" VARCHAR2(16), 
	"EMAIL_ADDR" VARCHAR2(50), 
	"EXTERNAL_ID" VARCHAR2(255), 
	"IS_EXTERNAL_AUTH_OFF" CHAR(1) DEFAULT 'N', 
	"PARTY_ID" NUMBER(10,0), 
	"USER_TIMEZONE" VARCHAR2(40), 
	"CREATED_DATE" TIMESTAMP (6), 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "MNU_USER" TO PUBLIC;
 
  GRANT INSERT ON "MNU_USER" TO PUBLIC;
 
  GRANT SELECT ON "MNU_USER" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_USER" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Table MNU_USER_IP_ADDRESS
--------------------------------------------------------

  CREATE TABLE "MNU_USER_IP_ADDRESS" 
   (	"USER_ID" VARCHAR2(16), 
	"IP_ADDRESS" VARCHAR2(40), 
	"CREATED_DATE" TIMESTAMP (6), 
	"CREATED_USER" VARCHAR2(16) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16)
   ) ;
  GRANT DELETE ON "MNU_USER_IP_ADDRESS" TO PUBLIC;
 
  GRANT INSERT ON "MNU_USER_IP_ADDRESS" TO PUBLIC;
 
  GRANT SELECT ON "MNU_USER_IP_ADDRESS" TO PUBLIC;
 
  GRANT UPDATE ON "MNU_USER_IP_ADDRESS" TO PUBLIC;
 

--------------------------------------------------------
--  DDL for Index MNU_FAVOURITE_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "MNU_FAVOURITE_PK" ON "MNU_FAVOURITE" ("USER_ID", "SEQ_NO") 
  ;
--------------------------------------------------------
--  DDL for Index MNU_INITIAL_VALUE_ROLE_IDX1
--------------------------------------------------------

  CREATE INDEX "MNU_INITIAL_VALUE_ROLE_IDX1" ON "MNU_INITIAL_VALUE_ROLE" ("TASK_ID") 
  ;
--------------------------------------------------------
--  DDL for Index MNU_INITIAL_VALUE_USER_IDX1
--------------------------------------------------------

  CREATE INDEX "MNU_INITIAL_VALUE_USER_IDX1" ON "MNU_INITIAL_VALUE_USER" ("TASK_ID") 
  ;
--------------------------------------------------------
--  DDL for Index MNU_MOTD_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "MNU_MOTD_PK" ON "MNU_MOTD" ("MOTD_ID") 
  ;
--------------------------------------------------------
--  DDL for Index MNU_ROLE_TASKFIELD_IDX1
--------------------------------------------------------

  CREATE INDEX "MNU_ROLE_TASKFIELD_IDX1" ON "MNU_ROLE_TASKFIELD" ("TASK_ID") 
  ;
--------------------------------------------------------
--  DDL for Index MNU_TASK_IDX1
--------------------------------------------------------

  CREATE INDEX "MNU_TASK_IDX1" ON "MNU_TASK" ("SUBSYS_ID") 
  ;
--------------------------------------------------------
--  DDL for Index MNU_TASK_IDX2
--------------------------------------------------------

  CREATE INDEX "MNU_TASK_IDX2" ON "MNU_TASK" ("PATTERN_ID") 
  ;
--------------------------------------------------------
--  DDL for Index MNU_USER_IDX1
--------------------------------------------------------

  CREATE UNIQUE INDEX "MNU_USER_IDX1" ON "MNU_USER" ("EMAIL_ADDR") 
  ;
--------------------------------------------------------
--  DDL for Index MNU_USER_IDX2
--------------------------------------------------------

  CREATE INDEX "MNU_USER_IDX2" ON "MNU_USER" ("ROLE_ID") 
  ;
--------------------------------------------------------
--  DDL for Index MNU_USER_IDX3
--------------------------------------------------------

  CREATE INDEX "MNU_USER_IDX3" ON "MNU_USER" ("RDCACCOUNT_ID") 
  ;
