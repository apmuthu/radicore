USE [menu];
GO

ALTER TABLE mnu_language ADD input_date_format nvarchar(12) NULL;
ALTER TABLE mnu_language ADD output_date_format nvarchar(12) NULL;
GO

CREATE UNIQUE INDEX [user_id_task_id] ON [dbo].[mnu_favourite] ([user_id] ASC, [task_id] ASC);
GO

CREATE TABLE mnu_user_alt (
  user_id nvarchar(16), 
  language_id nvarchar(5),
  user_name nvarchar(30) NOT NULL,
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (user_id, language_id)
);
GO

CREATE TABLE mnu_user_role (
  user_id nvarchar(16), 
  role_id nvarchar(16),
  is_primary char(1) DEFAULT 'N', 
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (user_id, role_id)
);
GO

INSERT INTO mnu_user_role (user_id, role_id, is_primary, created_date, created_user)
                    SELECT user_id, role_id, 'Y', '2014-04-17', created_user FROM mnu_user;
GO

DROP INDEX [mnu_user_role_id] ON [dbo].[mnu_user];
ALTER TABLE mnu_user DROP COLUMN role_id;
GO
