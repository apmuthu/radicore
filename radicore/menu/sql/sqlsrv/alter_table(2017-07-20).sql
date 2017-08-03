CREATE PROCEDURE #Drop_Default_Constraint (@TableName nvarchar(200), @ColumnName nvarchar(200))
AS
BEGIN
	DECLARE @ConstraintName nvarchar(200)
	SELECT @ConstraintName = Name FROM SYS.DEFAULT_CONSTRAINTS
	WHERE PARENT_OBJECT_ID = OBJECT_ID(@TableName)
	  AND OBJECT_ID = (SELECT default_object_id FROM SYS.COLUMNS
						   WHERE name = @ColumnName
						     AND object_id = PARENT_OBJECT_ID)
	IF @ConstraintName IS NOT NULL
	EXEC('ALTER TABLE ['+ @TableName +'] DROP CONSTRAINT [' + @ConstraintName + ']')

END;
GO

-- USE [menu];

ALTER TABLE [dbo].[mnu_user_role] ADD sort_seq int NULL;
ALTER TABLE [dbo].[mnu_user_role] ADD start_date date NOT NULL DEFAULT '2000-01-01';
ALTER TABLE [dbo].[mnu_user_role] ADD end_date date DEFAULT '9999-12-31';
GO

UPDATE mnu_user_role SET sort_seq=1 WHERE is_primary='Y';
UPDATE mnu_user_role SET sort_seq=9 WHERE is_primary='N';
UPDATE mnu_user_role SET start_date=CAST(created_date AS DATE);
UPDATE mnu_user_role SET end_date='9999-12-31';
GO

exec #Drop_Default_Constraint @TableName='mnu_user_role', @ColumnName='is_primary';
ALTER TABLE [dbo].[mnu_user_role] DROP COLUMN is_primary;
ALTER TABLE [dbo].[mnu_user_role] ALTER COLUMN sort_seq int NOT NULL;

-- 2017-07-21
ALTER TABLE [dbo].[mnu_saved_selection_data] ADD sort_seq SMALLINT NULL;
ALTER TABLE [dbo].[mnu_saved_selection_data] ADD output_name NVARCHAR(80) NULL;

-- finish