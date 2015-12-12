-- USE [menu];

CREATE TABLE mnu_saved_selection (
  selection_id int NOT NULL IDENTITY(1,1),
  selection_desc nvarchar(80) NOT NULL,
  user_id nvarchar(16) NOT NULL,
  task_id nvarchar(80) NOT NULL,
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (selection_id)
);

CREATE TABLE mnu_saved_selection_data (
  selection_id int NOT NULL,
  fieldname nvarchar(80) NOT NULL,
  fieldvalue nvarchar(80) DEFAULT NULL,
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (selection_id,fieldname)
);
