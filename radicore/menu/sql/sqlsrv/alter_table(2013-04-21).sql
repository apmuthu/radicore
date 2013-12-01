USE [menu];
GO

ALTER TABLE mnu_user ALTER COLUMN pswd_chg_time time(0) DEFAULT NULL;
GO
ALTER TABLE mnu_user ALTER COLUMN logon_time time(0) DEFAULT NULL,
GO

CREATE TABLE mnu_time_limit_role (
	role_id nvarchar(16), 
	seq_no smallint NOT NULL DEFAULT '0',
	scheduled_start_time(0) time DEFAULT NULL,
	scheduled_end_time(0) time DEFAULT NULL,
	scheduled_monday char(1) NOT NULL DEFAULT 'Y',
	scheduled_tuesday char(1) NOT NULL DEFAULT 'Y',
	scheduled_wednesday char(1) NOT NULL DEFAULT 'Y',
	scheduled_thursday char(1) NOT NULL DEFAULT 'Y',
	scheduled_friday char(1) NOT NULL DEFAULT 'Y',
	scheduled_saturday char(1) NOT NULL DEFAULT 'N',
	scheduled_sunday char(1) NOT NULL DEFAULT 'N',
	created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  	created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  	revised_date datetime2(0) DEFAULT NULL,
  	revised_user nvarchar(16) DEFAULT NULL,
	PRIMARY KEY (role_id, seq_no)
);
go

CREATE TABLE mnu_time_limit_user (
	user_id nvarchar(16), 
	seq_no smallint NOT NULL DEFAULT '0',
	scheduled_start_time time(0) DEFAULT NULL,
	scheduled_end_time time(0) DEFAULT NULL,
	scheduled_monday char(1) NOT NULL DEFAULT 'Y',
	scheduled_tuesday char(1) NOT NULL DEFAULT 'Y',
	scheduled_wednesday char(1) NOT NULL DEFAULT 'Y',
	scheduled_thursday char(1) NOT NULL DEFAULT 'Y',
	scheduled_friday char(1) NOT NULL DEFAULT 'Y',
	scheduled_saturday char(1) NOT NULL DEFAULT 'N',
	scheduled_sunday char(1) NOT NULL DEFAULT 'N',
	created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  	created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  	revised_date datetime2(0) DEFAULT NULL,
  	revised_user nvarchar(16) DEFAULT NULL,
	PRIMARY KEY (user_id, seq_no)
);
go
