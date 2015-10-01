-- USE `menu`;

UPDATE mnu_language SET language_id=LOWER(language_id);

BEGIN TRANSACTION
GO
EXECUTE sp_rename N'dbo.mnu_user.language_code', N'Tmp_language_id', 'COLUMN';
GO
EXECUTE sp_rename N'dbo.mnu_user.Tmp_language_id', N'language_id', 'COLUMN';
GO
ALTER TABLE dbo.mnu_user SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
