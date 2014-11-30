--------------------------------------------------------
--  File created - Thursday-April-24-2014   
--------------------------------------------------------

CREATE USER "MENU" IDENTIFIED BY "MENU";
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

   CREATE SEQUENCE  "MENU"."MNU_ACCOUNT_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE
  GRANT ALTER, SELECT ON "MENU"."MNU_ACCOUNT_SEQ" TO PUBLIC
--------------------------------------------------------
--  DDL for Sequence MNU_MOTD_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "MENU"."MNU_MOTD_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE
  GRANT ALTER, SELECT ON "MENU"."MNU_MOTD_SEQ" TO PUBLIC
--------------------------------------------------------
--  DDL for Table HELP_TEXT
--------------------------------------------------------

  CREATE TABLE "MENU"."HELP_TEXT" 
   (	"TASK_ID" VARCHAR2(80 BYTE), 
	"HELP_TEXT" CLOB, 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."HELP_TEXT" TO PUBLIC
--------------------------------------------------------
--  DDL for Table HELP_TEXT_ALT
--------------------------------------------------------

  CREATE TABLE "MENU"."HELP_TEXT_ALT" 
   (	"TASK_ID" VARCHAR2(80 BYTE), 
	"LANGUAGE_ID" VARCHAR2(5 BYTE), 
	"HELP_TEXT" CLOB, 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."HELP_TEXT_ALT" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_ACCOUNT
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_ACCOUNT" 
   (	"RDCACCOUNT_ID" NUMBER(10,0), 
	"ACCOUNT_NAME" VARCHAR2(255 BYTE), 
	"RDCVERSION" NUMBER(10,0) DEFAULT 1, 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_ACCOUNT" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_CONTROL
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_CONTROL" 
   (	"RECORD_ID" VARCHAR2(16 BYTE), 
	"FIELD_ID" VARCHAR2(32 BYTE), 
	"FIELD_VALUE" VARCHAR2(255 BYTE), 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_CONTROL" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_FAVOURITE
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_FAVOURITE" 
   (	"USER_ID" VARCHAR2(16 BYTE), 
	"SEQ_NO" NUMBER(6,0), 
	"TASK_ID" VARCHAR2(80 BYTE), 
	"TASK_DESC" VARCHAR2(80 BYTE), 
	"SORT_SEQ" NUMBER(6,0), 
	"BREADCRUMBS" VARCHAR2(4000 BYTE), 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_FAVOURITE" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_INITIAL_VALUE_ROLE
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_INITIAL_VALUE_ROLE" 
   (	"ROLE_ID" VARCHAR2(16 BYTE), 
	"TASK_ID" VARCHAR2(80 BYTE), 
	"FIELD_ID" VARCHAR2(40 BYTE), 
	"INITIAL_VALUE" VARCHAR2(255 BYTE), 
	"IS_NOEDIT" CHAR(1 BYTE) DEFAULT 'N', 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_INITIAL_VALUE_ROLE" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_INITIAL_VALUE_USER
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_INITIAL_VALUE_USER" 
   (	"USER_ID" VARCHAR2(16 BYTE), 
	"TASK_ID" VARCHAR2(80 BYTE), 
	"FIELD_ID" VARCHAR2(40 BYTE), 
	"INITIAL_VALUE" VARCHAR2(255 BYTE), 
	"IS_NOEDIT" CHAR(1 BYTE) DEFAULT 'N', 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_INITIAL_VALUE_USER" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_LANGUAGE
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_LANGUAGE" 
   (	"LANGUAGE_ID" VARCHAR2(5 BYTE) DEFAULT 'EN', 
	"LANGUAGE_NAME" VARCHAR2(40 BYTE) DEFAULT 'English', 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2000-01-01 00:00:00', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6) DEFAULT NULL, 
	"REVISED_USER" VARCHAR2(16 BYTE) DEFAULT NULL, 
	"INPUT_DATE_FORMAT" VARCHAR2(12 BYTE), 
	"OUTPUT_DATE_FORMAT" VARCHAR2(12 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_LANGUAGE" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_MENU
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_MENU" 
   (	"MENU_ID" VARCHAR2(80 BYTE), 
	"TASK_ID_JNR" VARCHAR2(80 BYTE), 
	"SORT_SEQ" NUMBER(3,0) DEFAULT '000', 
	"BUTTON_TEXT" VARCHAR2(40 BYTE), 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_MENU" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_MOTD
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_MOTD" 
   (	"MOTD_ID" NUMBER, 
	"MOTD_SUBJECT" CHAR(80 BYTE), 
	"MOTD_MESSAGE" CLOB, 
	"START_DATE" DATE DEFAULT '2001-01-01', 
	"END_DATE" DATE DEFAULT '9999-12-31', 
	"ROLE_ID" VARCHAR2(16 BYTE), 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_MOTD" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_NAV_BUTTON
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_NAV_BUTTON" 
   (	"TASK_ID_SNR" VARCHAR2(80 BYTE), 
	"TASK_ID_JNR" VARCHAR2(80 BYTE), 
	"SORT_SEQ" NUMBER(3,0) DEFAULT '000', 
	"BUTTON_TEXT" VARCHAR2(40 BYTE), 
	"CONTEXT_PRESELECT" CHAR(1 BYTE), 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_NAV_BUTTON" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_PATTERN
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_PATTERN" 
   (	"PATTERN_ID" VARCHAR2(16 BYTE), 
	"PATTERN_DESC" VARCHAR2(60 BYTE), 
	"PATTERN_LONG_DESC" CLOB, 
	"VISIBLE_SCREEN" CHAR(1 BYTE), 
	"CONTEXT_PRESELECT" CHAR(1 BYTE), 
	"KEEP_DATA" CHAR(1 BYTE), 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_PATTERN" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_ROLE
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_ROLE" 
   (	"ROLE_ID" VARCHAR2(16 BYTE), 
	"ROLE_DESC" VARCHAR2(30 BYTE), 
	"START_TASK_ID" VARCHAR2(80 BYTE), 
	"GLOBAL_ACCESS" CHAR(1 BYTE) DEFAULT 'N', 
	"IS_EXTERNAL_AUTH_OFF" CHAR(1 BYTE) DEFAULT 'N', 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_ROLE" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_ROLE_TASK
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_ROLE_TASK" 
   (	"ROLE_ID" VARCHAR2(16 BYTE), 
	"TASK_ID" VARCHAR2(80 BYTE), 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_ROLE_TASK" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_ROLE_TASKFIELD
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_ROLE_TASKFIELD" 
   (	"ROLE_ID" VARCHAR2(16 BYTE), 
	"TASK_ID" VARCHAR2(80 BYTE), 
	"FIELD_ID" VARCHAR2(40 BYTE), 
	"ACCESS_TYPE" VARCHAR2(4 BYTE), 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_ROLE_TASKFIELD" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_SUBSYSTEM
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_SUBSYSTEM" 
   (	"SUBSYS_ID" VARCHAR2(16 BYTE), 
	"SUBSYS_DESC" VARCHAR2(255 BYTE), 
	"SUBSYS_DIR" VARCHAR2(255 BYTE), 
	"TASK_PREFIX" VARCHAR2(8 BYTE), 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_SUBSYSTEM" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_TASK
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_TASK" 
   (	"TASK_ID" VARCHAR2(80 BYTE), 
	"TASK_DESC" VARCHAR2(80 BYTE), 
	"BUTTON_TEXT" VARCHAR2(80 BYTE), 
	"TASK_TYPE" VARCHAR2(4 BYTE), 
	"SCRIPT_ID" VARCHAR2(80 BYTE), 
	"IS_DISABLED" CHAR(1 BYTE), 
	"PATTERN_ID" VARCHAR2(16 BYTE), 
	"SUBSYS_ID" VARCHAR2(16 BYTE), 
	"INITIAL_PASSTHRU" VARCHAR2(80 BYTE), 
	"SELECTION_FIXED" VARCHAR2(255 BYTE), 
	"SELECTION_TEMP" VARCHAR2(255 BYTE), 
	"SETTINGS" VARCHAR2(255 BYTE), 
	"ORDER_BY" VARCHAR2(255 BYTE), 
	"KEEP_DATA" CHAR(1 BYTE), 
	"LOG_SQL_QUERY" CHAR(1 BYTE), 
	"SCREEN_REFRESH" NUMBER(5,0), 
	"USE_HTTPS" CHAR(1 BYTE), 
	"MAX_EXECUTION_TIME" NUMBER(5,0), 
	"TASK_ID_RUN_AT_END" VARCHAR2(80 BYTE), 
	"TASK_ID_RUN_AT_CANCEL" VARCHAR2(80 BYTE), 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TASK" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_TASK_ALT
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_TASK_ALT" 
   (	"TASK_ID" VARCHAR2(80 BYTE), 
	"LANGUAGE_ID" VARCHAR2(5 BYTE), 
	"TASK_DESC" VARCHAR2(80 BYTE), 
	"BUTTON_TEXT" VARCHAR2(80 BYTE), 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TASK_ALT" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_TASK_FIELD
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_TASK_FIELD" 
   (	"TASK_ID" VARCHAR2(80 BYTE), 
	"FIELD_ID" VARCHAR2(40 BYTE), 
	"FIELD_DESC" VARCHAR2(255 BYTE), 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TASK_FIELD" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_TASK_IP_ADDRESS
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_TASK_IP_ADDRESS" 
   (	"TASK_ID" VARCHAR2(80 BYTE), 
	"IP_ADDRESS" VARCHAR2(40 BYTE), 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TASK_IP_ADDRESS" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_TIME_LIMIT_ROLE
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_TIME_LIMIT_ROLE" 
   (	"ROLE_ID" VARCHAR2(16 BYTE), 
	"SEQ_NO" NUMBER(6,0), 
	"SCHEDULED_START_TIME" CHAR(8 BYTE) DEFAULT '09:00:00', 
	"SCHEDULED_END_TIME" CHAR(8 BYTE) DEFAULT '17:30:00', 
	"SCHEDULED_MONDAY" CHAR(1 BYTE) DEFAULT 1, 
	"SCHEDULED_TUESDAY" CHAR(1 BYTE) DEFAULT 1, 
	"SCHEDULED_WEDNESDAY" CHAR(1 BYTE) DEFAULT 1, 
	"SCHEDULED_THURSDAY" CHAR(1 BYTE) DEFAULT 1, 
	"SCHEDULED_FRIDAY" CHAR(1 BYTE) DEFAULT 1, 
	"SCHEDULED_SATURDAY" CHAR(1 BYTE) DEFAULT 0, 
	"SCHEDULED_SUNDAY" CHAR(1 BYTE) DEFAULT 0, 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TIME_LIMIT_ROLE" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_TIME_LIMIT_USER
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_TIME_LIMIT_USER" 
   (	"USER_ID" VARCHAR2(16 BYTE), 
	"SEQ_NO" NUMBER(6,0), 
	"SCHEDULED_START_TIME" CHAR(8 BYTE), 
	"SCHEDULED_END_TIME" CHAR(8 BYTE), 
	"SCHEDULED_MONDAY" CHAR(1 BYTE) DEFAULT 1, 
	"SCHEDULED_TUESDAY" CHAR(1 BYTE) DEFAULT 1, 
	"SCHEDULED_WEDNESDAY" CHAR(1 BYTE) DEFAULT 1, 
	"SCHEDULED_THURSDAY" CHAR(1 BYTE) DEFAULT 1, 
	"SCHEDULED_FRIDAY" CHAR(1 BYTE) DEFAULT 1, 
	"SCHEDULED_SATURDAY" CHAR(1 BYTE) DEFAULT 0, 
	"SCHEDULED_SUNDAY" CHAR(1 BYTE) DEFAULT 0, 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TIME_LIMIT_USER" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_TODO
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_TODO" 
   (	"USER_ID" VARCHAR2(16 BYTE), 
	"SEQ_NO" NUMBER(6,0), 
	"ITEM_DESC" VARCHAR2(80 BYTE), 
	"ITEM_NOTES" CLOB, 
	"DUE_DATE" DATE, 
	"VISIBILITY" NUMBER(3,0), 
	"IS_COMPLETE" CHAR(1 BYTE) DEFAULT 'N', 
	"REPEAT_INTERVAL" NUMBER(3,0), 
	"REPEAT_UNIT" CHAR(1 BYTE), 
	"TASK_ID" VARCHAR2(80 BYTE), 
	"TASK_CONTEXT" VARCHAR2(255 BYTE) DEFAULT NULL, 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TODO" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_USER
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_USER" 
   (	"USER_ID" VARCHAR2(16 BYTE), 
	"USER_NAME" VARCHAR2(30 BYTE), 
	"USER_PASSWORD" VARCHAR2(40 BYTE), 
	"RDCACCOUNT_ID" NUMBER(10,0), 
	"PSWD_CHG_DATE" DATE, 
	"PSWD_CHG_TIME" CHAR(8 BYTE), 
	"PSWD_COUNT" NUMBER(6,0), 
	"IN_USE" CHAR(1 BYTE) DEFAULT 'N', 
	"IS_DISABLED" CHAR(1 BYTE) DEFAULT 'N', 
	"LOGON_DATE" DATE, 
	"LOGON_TIME" CHAR(8 BYTE), 
	"LANGUAGE_CODE" VARCHAR2(6 BYTE), 
	"START_DATE" DATE, 
	"END_DATE" DATE, 
	"IP_ADDRESS" VARCHAR2(40 BYTE), 
	"EMAIL_ADDR" VARCHAR2(50 BYTE), 
	"EXTERNAL_ID" VARCHAR2(255 BYTE), 
	"IS_EXTERNAL_AUTH_OFF" CHAR(1 BYTE) DEFAULT 'N', 
	"PARTY_ID" NUMBER(10,0), 
	"USER_TIMEZONE" VARCHAR2(40 BYTE), 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_USER" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_USER_ALT
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_USER_ALT" 
   (	"USER_ID" VARCHAR2(16 BYTE), 
	"LANGUAGE_ID" VARCHAR2(5 BYTE), 
	"USER_NAME" VARCHAR2(30 BYTE) NOT NULL, 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_USER_ALT" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_USER_IP_ADDRESS
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_USER_IP_ADDRESS" 
   (	"USER_ID" VARCHAR2(16 BYTE), 
	"IP_ADDRESS" VARCHAR2(40 BYTE), 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_USER_IP_ADDRESS" TO PUBLIC
--------------------------------------------------------
--  DDL for Table MNU_USER_ROLE
--------------------------------------------------------

  CREATE TABLE "MENU"."MNU_USER_ROLE" 
   (	"USER_ID" VARCHAR2(16 BYTE), 
	"ROLE_ID" VARCHAR2(16 BYTE), 
	"IS_PRIMARY" CHAR(1 BYTE) DEFAULT 'N', 
	"CREATED_DATE" TIMESTAMP (6) DEFAULT '2001-01-01', 
	"CREATED_USER" VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	"REVISED_DATE" TIMESTAMP (6), 
	"REVISED_USER" VARCHAR2(16 BYTE)
   )
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_USER_ROLE" TO PUBLIC
--------------------------------------------------------
--  DDL for Index INDEX1
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."INDEX1" ON "MENU"."MNU_FAVOURITE" ("USER_ID", "TASK_ID")
--------------------------------------------------------
--  DDL for Index MNU_INITIAL_VALUE_ROLE_IDX1
--------------------------------------------------------

  CREATE INDEX "MENU"."MNU_INITIAL_VALUE_ROLE_IDX1" ON "MENU"."MNU_INITIAL_VALUE_ROLE" ("TASK_ID")
--------------------------------------------------------
--  DDL for Index MNU_INITIAL_VALUE_USER_IDX1
--------------------------------------------------------

  CREATE INDEX "MENU"."MNU_INITIAL_VALUE_USER_IDX1" ON "MENU"."MNU_INITIAL_VALUE_USER" ("TASK_ID")
--------------------------------------------------------
--  DDL for Index MNU_ROLE_TASKFIELD_IDX1
--------------------------------------------------------

  CREATE INDEX "MENU"."MNU_ROLE_TASKFIELD_IDX1" ON "MENU"."MNU_ROLE_TASKFIELD" ("TASK_ID")
--------------------------------------------------------
--  DDL for Index MNU_TASK_IDX1
--------------------------------------------------------

  CREATE INDEX "MENU"."MNU_TASK_IDX1" ON "MENU"."MNU_TASK" ("SUBSYS_ID")
--------------------------------------------------------
--  DDL for Index MNU_TASK_IDX2
--------------------------------------------------------

  CREATE INDEX "MENU"."MNU_TASK_IDX2" ON "MENU"."MNU_TASK" ("PATTERN_ID")
--------------------------------------------------------
--  DDL for Index MNU_USER_IDX1
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."MNU_USER_IDX1" ON "MENU"."MNU_USER" ("EMAIL_ADDR")
--------------------------------------------------------
--  DDL for Index MNU_USER_IDX3
--------------------------------------------------------

  CREATE INDEX "MENU"."MNU_USER_IDX3" ON "MENU"."MNU_USER" ("RDCACCOUNT_ID")
--------------------------------------------------------
--  DDL for Index SYS_C007151
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007151" ON "MENU"."HELP_TEXT" ("TASK_ID")
--------------------------------------------------------
--  DDL for Index SYS_C007152
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007152" ON "MENU"."MNU_ACCOUNT" ("RDCACCOUNT_ID")
--------------------------------------------------------
--  DDL for Index SYS_C007153
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007153" ON "MENU"."MNU_CONTROL" ("RECORD_ID", "FIELD_ID")
--------------------------------------------------------
--  DDL for Index SYS_C007154
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007154" ON "MENU"."MNU_FAVOURITE" ("USER_ID", "SEQ_NO")
--------------------------------------------------------
--  DDL for Index SYS_C007155
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007155" ON "MENU"."MNU_INITIAL_VALUE_ROLE" ("ROLE_ID", "TASK_ID", "FIELD_ID")
--------------------------------------------------------
--  DDL for Index SYS_C007156
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007156" ON "MENU"."MNU_INITIAL_VALUE_USER" ("USER_ID", "TASK_ID", "FIELD_ID")
--------------------------------------------------------
--  DDL for Index SYS_C007157
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007157" ON "MENU"."MNU_LANGUAGE" ("LANGUAGE_ID")
--------------------------------------------------------
--  DDL for Index SYS_C007158
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007158" ON "MENU"."MNU_MENU" ("MENU_ID", "TASK_ID_JNR")
--------------------------------------------------------
--  DDL for Index SYS_C007159
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007159" ON "MENU"."MNU_MOTD" ("MOTD_ID")
--------------------------------------------------------
--  DDL for Index SYS_C007160
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007160" ON "MENU"."MNU_NAV_BUTTON" ("TASK_ID_SNR", "TASK_ID_JNR")
--------------------------------------------------------
--  DDL for Index SYS_C007161
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007161" ON "MENU"."MNU_PATTERN" ("PATTERN_ID")
--------------------------------------------------------
--  DDL for Index SYS_C007162
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007162" ON "MENU"."MNU_ROLE" ("ROLE_ID")
--------------------------------------------------------
--  DDL for Index SYS_C007163
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007163" ON "MENU"."MNU_ROLE_TASK" ("ROLE_ID", "TASK_ID")
--------------------------------------------------------
--  DDL for Index SYS_C007164
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007164" ON "MENU"."MNU_ROLE_TASKFIELD" ("ROLE_ID", "TASK_ID", "FIELD_ID")
--------------------------------------------------------
--  DDL for Index SYS_C007165
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007165" ON "MENU"."MNU_SUBSYSTEM" ("SUBSYS_ID")
--------------------------------------------------------
--  DDL for Index SYS_C007166
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007166" ON "MENU"."MNU_TASK" ("TASK_ID")
--------------------------------------------------------
--  DDL for Index SYS_C007167
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007167" ON "MENU"."MNU_TASK_FIELD" ("TASK_ID", "FIELD_ID")
--------------------------------------------------------
--  DDL for Index SYS_C007168
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007168" ON "MENU"."MNU_TASK_IP_ADDRESS" ("TASK_ID", "IP_ADDRESS")
--------------------------------------------------------
--  DDL for Index SYS_C007169
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007169" ON "MENU"."MNU_TODO" ("USER_ID", "SEQ_NO")
--------------------------------------------------------
--  DDL for Index SYS_C007171
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007171" ON "MENU"."MNU_USER" ("USER_ID")
--------------------------------------------------------
--  DDL for Index SYS_C007172
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007172" ON "MENU"."MNU_USER_IP_ADDRESS" ("USER_ID", "IP_ADDRESS")
--------------------------------------------------------
--  DDL for Index SYS_C007442
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007442" ON "MENU"."HELP_TEXT_ALT" ("TASK_ID", "LANGUAGE_ID")
--------------------------------------------------------
--  DDL for Index SYS_C007617
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C007617" ON "MENU"."MNU_TASK_ALT" ("TASK_ID", "LANGUAGE_ID")
--------------------------------------------------------
--  DDL for Index SYS_C008103
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C008103" ON "MENU"."MNU_TIME_LIMIT_ROLE" ("ROLE_ID", "SEQ_NO")
--------------------------------------------------------
--  DDL for Index SYS_C008104
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C008104" ON "MENU"."MNU_TIME_LIMIT_USER" ("USER_ID", "SEQ_NO")
--------------------------------------------------------
--  DDL for Index SYS_C009478
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C009478" ON "MENU"."MNU_USER_ALT" ("USER_ID", "LANGUAGE_ID")
--------------------------------------------------------
--  DDL for Index SYS_C009479
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENU"."SYS_C009479" ON "MENU"."MNU_USER_ROLE" ("USER_ID", "ROLE_ID")
--------------------------------------------------------
--  Constraints for Table HELP_TEXT
--------------------------------------------------------

  ALTER TABLE "MENU"."HELP_TEXT" ADD PRIMARY KEY ("TASK_ID") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."HELP_TEXT" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table HELP_TEXT_ALT
--------------------------------------------------------

  ALTER TABLE "MENU"."HELP_TEXT_ALT" ADD PRIMARY KEY ("TASK_ID", "LANGUAGE_ID") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."HELP_TEXT_ALT" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_ACCOUNT
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_ACCOUNT" ADD PRIMARY KEY ("RDCACCOUNT_ID") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_ACCOUNT" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_CONTROL
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_CONTROL" ADD PRIMARY KEY ("RECORD_ID", "FIELD_ID") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_CONTROL" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_FAVOURITE
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_FAVOURITE" ADD PRIMARY KEY ("USER_ID", "SEQ_NO") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_FAVOURITE" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_INITIAL_VALUE_ROLE
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_INITIAL_VALUE_ROLE" ADD PRIMARY KEY ("ROLE_ID", "TASK_ID", "FIELD_ID") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_INITIAL_VALUE_ROLE" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_INITIAL_VALUE_USER
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_INITIAL_VALUE_USER" ADD PRIMARY KEY ("USER_ID", "TASK_ID", "FIELD_ID") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_INITIAL_VALUE_USER" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_LANGUAGE
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_LANGUAGE" ADD PRIMARY KEY ("LANGUAGE_ID") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_LANGUAGE" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_MENU
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_MENU" ADD PRIMARY KEY ("MENU_ID", "TASK_ID_JNR") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_MENU" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_MOTD
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_MOTD" ADD PRIMARY KEY ("MOTD_ID") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_MOTD" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_NAV_BUTTON
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_NAV_BUTTON" ADD PRIMARY KEY ("TASK_ID_SNR", "TASK_ID_JNR") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_NAV_BUTTON" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_PATTERN
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_PATTERN" ADD PRIMARY KEY ("PATTERN_ID") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_PATTERN" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_ROLE
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_ROLE" ADD PRIMARY KEY ("ROLE_ID") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_ROLE" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_ROLE_TASK
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_ROLE_TASK" ADD PRIMARY KEY ("ROLE_ID", "TASK_ID") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_ROLE_TASK" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_ROLE_TASKFIELD
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_ROLE_TASKFIELD" ADD PRIMARY KEY ("ROLE_ID", "TASK_ID", "FIELD_ID") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_ROLE_TASKFIELD" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_SUBSYSTEM
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_SUBSYSTEM" ADD PRIMARY KEY ("SUBSYS_ID") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_SUBSYSTEM" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_TASK
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_TASK" ADD PRIMARY KEY ("TASK_ID") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TASK" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_TASK_ALT
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_TASK_ALT" ADD PRIMARY KEY ("TASK_ID", "LANGUAGE_ID") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TASK_ALT" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_TASK_FIELD
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_TASK_FIELD" ADD PRIMARY KEY ("TASK_ID", "FIELD_ID") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TASK_FIELD" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_TASK_IP_ADDRESS
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_TASK_IP_ADDRESS" ADD PRIMARY KEY ("TASK_ID", "IP_ADDRESS") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TASK_IP_ADDRESS" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_TIME_LIMIT_ROLE
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_TIME_LIMIT_ROLE" MODIFY ("SCHEDULED_END_TIME" NOT NULL ENABLE)
  ALTER TABLE "MENU"."MNU_TIME_LIMIT_ROLE" MODIFY ("SCHEDULED_START_TIME" NOT NULL ENABLE)
  ALTER TABLE "MENU"."MNU_TIME_LIMIT_ROLE" ADD PRIMARY KEY ("ROLE_ID", "SEQ_NO") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TIME_LIMIT_ROLE" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_TIME_LIMIT_USER
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_TIME_LIMIT_USER" ADD PRIMARY KEY ("USER_ID", "SEQ_NO") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TIME_LIMIT_USER" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_TODO
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_TODO" ADD PRIMARY KEY ("USER_ID", "SEQ_NO") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TODO" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_USER
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_USER" ADD PRIMARY KEY ("USER_ID") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_USER" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_USER_ALT
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_USER_ALT" ADD PRIMARY KEY ("USER_ID", "LANGUAGE_ID") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_USER_ALT" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_USER_IP_ADDRESS
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_USER_IP_ADDRESS" ADD PRIMARY KEY ("USER_ID", "IP_ADDRESS") ENABLE
  GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_USER_IP_ADDRESS" TO PUBLIC
--------------------------------------------------------
--  Constraints for Table MNU_USER_ROLE
--------------------------------------------------------

  ALTER TABLE "MENU"."MNU_USER_ROLE" ADD PRIMARY KEY ("USER_ID", "ROLE_ID") ENABLE

GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_USER_ROLE" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."HELP_TEXT" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."HELP_TEXT_ALT" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_ACCOUNT" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_CONTROL" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_FAVOURITE" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_INITIAL_VALUE_ROLE" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_INITIAL_VALUE_USER" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_LANGUAGE" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_MENU" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_MOTD" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_NAV_BUTTON" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_PATTERN" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_ROLE" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_ROLE_TASK" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_ROLE_TASKFIELD" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_SUBSYSTEM" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TASK" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TASK_ALT" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TASK_FIELD" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TASK_IP_ADDRESS" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TIME_LIMIT_ROLE" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TIME_LIMIT_USER" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_TODO" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_USER" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_USER_ALT" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_USER_IP_ADDRESS" TO PUBLIC;
GRANT DELETE, INSERT, SELECT, UPDATE ON "MENU"."MNU_USER_ROLE" TO PUBLIC;
