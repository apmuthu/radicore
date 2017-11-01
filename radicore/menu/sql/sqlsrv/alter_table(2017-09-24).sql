-- use [menu];

ALTER TABLE help_text ALTER COLUMN help_text nvarchar(max) NULL;
GO

ALTER TABLE help_text_alt ALTER COLUMN help_text nvarchar(max) NULL;
GO

ALTER TABLE mnu_account ALTER COLUMN account_desc nvarchar(max) NULL;
GO

ALTER TABLE mnu_motd ALTER COLUMN motd_message nvarchar(max) NULL;
GO

ALTER TABLE mnu_pattern ALTER COLUMN pattern_desc nvarchar(max) NULL;
GO

ALTER TABLE mnu_role ALTER COLUMN role_desc nvarchar(max) NULL;
GO

ALTER TABLE mnu_subsystem ALTER COLUMN subsys_desc nvarchar(max) NULL;
GO

ALTER TABLE mnu_task ALTER COLUMN task_desc nvarchar(max) NULL;
GO

ALTER TABLE mnu_task_alt ALTER COLUMN task_desc nvarchar(max) NULL;
GO

ALTER TABLE mnu_todo ALTER COLUMN item_desc nvarchar(max) NULL;
GO
