ALTER SESSION SET CURRENT_SCHEMA = "MENU";

CREATE TABLE "MENU".mnu_time_limit_role (
	role_id VARCHAR2(16 BYTE), 
	seq_no NUMBER(6,0), 
	scheduled_start_time CHAR(8 BYTE) NOT NULL, 
	scheduled_end_time CHAR(8 BYTE) NOT NULL, 
	scheduled_monday CHAR(1 BYTE) DEFAULT 1,
	scheduled_tuesday CHAR(1 BYTE) DEFAULT 1,
	scheduled_wednesday CHAR(1 BYTE) DEFAULT 1,
	scheduled_thursday CHAR(1 BYTE) DEFAULT 1,
	scheduled_friday CHAR(1 BYTE) DEFAULT 1,
	scheduled_saturday CHAR(1 BYTE) DEFAULT 0,
	scheduled_sunday CHAR(1 BYTE) DEFAULT 0,
	created_date TIMESTAMP (6), 
	created_user VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	revised_date TIMESTAMP (6), 
	revised_user VARCHAR2(16 BYTE),
	PRIMARY KEY (role_id, seq_no)
) ;
REVOKE ALL ON mnu_time_limit_role FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_time_limit_role TO PUBLIC;

CREATE TABLE "MENU".mnu_time_limit_user (
	user_id VARCHAR2(16 BYTE), 
	seq_no NUMBER(6,0), 
	scheduled_start_time CHAR(8 BYTE) NOT NULL, 
	scheduled_end_time CHAR(8 BYTE) NOT NULL, 
	scheduled_monday CHAR(1 BYTE) DEFAULT 1,
	scheduled_tuesday CHAR(1 BYTE) DEFAULT 1,
	scheduled_wednesday CHAR(1 BYTE) DEFAULT 1,
	scheduled_thursday CHAR(1 BYTE) DEFAULT 1,
	scheduled_friday CHAR(1 BYTE) DEFAULT 1,
	scheduled_saturday CHAR(1 BYTE) DEFAULT 0,
	scheduled_sunday CHAR(1 BYTE) DEFAULT 0,
	created_date TIMESTAMP (6), 
	created_user VARCHAR2(16 BYTE) DEFAULT 'UNKNOWN', 
	revised_date TIMESTAMP (6), 
	revised_user VARCHAR2(16 BYTE),
	PRIMARY KEY (user_id, seq_no)
) ;
REVOKE ALL ON mnu_time_limit_user FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON mnu_time_limit_user TO PUBLIC;