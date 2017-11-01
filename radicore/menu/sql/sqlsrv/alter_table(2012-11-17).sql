USE [menu];
GO

CREATE TABLE help_text_alt (
  task_id nvarchar(80) NOT NULL,
  language_id nvarchar(5) NOT NULL,
  help_text ntext NOT NULL,
  created_date datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (task_id,language_id)
);
go

CREATE TABLE mnu_task_alt (
  task_id nvarchar(80) NOT NULL,
  language_id nvarchar(5) NOT NULL,
  task_desc nvarchar(80) NOT NULL,
  button_text nvarchar(80) NOT NULL,
  created_date datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (task_id,language_id)
);
go
