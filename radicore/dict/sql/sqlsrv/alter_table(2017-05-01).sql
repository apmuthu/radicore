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
	EXEC('ALTER TABLE ['+ @TableName +'] DROP CONSTRAINT ' + @ConstraintName + ']')

END;
GO

-- USE [dict];

exec sp_rename 'dict_column.column_desc', 'column_name', 'COLUMN';
ALTER TABLE [dbo].[dict_column] ALTER COLUMN column_name NVARCHAR(80) NOT NULL;

exec sp_rename 'dict_column.col_comment', 'column_desc', 'COLUMN';

exec sp_rename 'dict_database.database_desc', 'database_name', 'COLUMN';
ALTER TABLE [dbo].[dict_database] ALTER COLUMN database_name NVARCHAR(80) NOT NULL;

exec sp_rename 'dict_database.db_comment', 'database_desc', 'COLUMN';

exec sp_rename 'dict_relationship.relation_desc', 'relation_name', 'COLUMN';
ALTER TABLE [dbo].[dict_relationship] ALTER COLUMN relation_name NVARCHAR(80) NOT NULL;

exec sp_rename 'dict_relationship.rel_comment', 'relation_desc', 'COLUMN';

exec sp_rename 'dict_relationship.rel_type', 'relation_type', 'COLUMN';

UPDATE dict_table SET tbl_comment=table_desc WHERE tbl_comment IS NULL;
UPDATE dict_table SET table_desc=substring(table_desc,1,80);

exec sp_rename 'dict_table.table_desc', 'table_name', 'COLUMN';
ALTER TABLE [dbo].[dict_table] ALTER COLUMN table_name NVARCHAR(80) NOT NULL;
exec sp_rename 'dict_table.tbl_comment', 'table_desc', 'COLUMN';

-- change ntext to nvarchar(max)
ALTER TABLE dict_column ALTER COLUMN column_desc nvarchar(max) NULL;
ALTER TABLE dict_database ALTER COLUMN database_desc nvarchar(max) NULL;
ALTER TABLE dict_relationship ALTER COLUMN relation_desc nvarchar(max) NULL;
ALTER TABLE dict_table ALTER COLUMN table_desc nvarchar(max) NULL;

-- change datetime2(7) to datetime2(0)

exec #Drop_Default_Constraint @TableName='dict_column', @ColumnName='created_date';
ALTER TABLE [dbo].[dict_column] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[dict_column] ADD DEFAULT '2000-01-01 00:00:00' for [created_date];
exec #Drop_Default_Constraint @TableName='dict_column', @ColumnName='revised_date';
ALTER TABLE [dbo].[dict_column] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='dict_database', @ColumnName='created_date';
ALTER TABLE [dbo].[dict_database] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[dict_database] ADD DEFAULT '2000-01-01 00:00:00' for [created_date];
exec #Drop_Default_Constraint @TableName='dict_database', @ColumnName='revised_date';
ALTER TABLE [dbo].[dict_database] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='dict_related_column', @ColumnName='created_date';
ALTER TABLE [dbo].[dict_related_column] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[dict_related_column] ADD DEFAULT '2000-01-01 00:00:00' for [created_date];
exec #Drop_Default_Constraint @TableName='dict_related_column', @ColumnName='revised_date';
ALTER TABLE [dbo].[dict_related_column] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='dict_relationship', @ColumnName='created_date';
ALTER TABLE [dbo].[dict_relationship] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[dict_relationship] ADD DEFAULT '2000-01-01 00:00:00' for [created_date];
exec #Drop_Default_Constraint @TableName='dict_relationship', @ColumnName='revised_date';
ALTER TABLE [dbo].[dict_relationship] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='dict_table', @ColumnName='created_date';
ALTER TABLE [dbo].[dict_table] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[dict_table] ADD DEFAULT '2000-01-01 00:00:00' for [created_date];
exec #Drop_Default_Constraint @TableName='dict_table', @ColumnName='revised_date';
ALTER TABLE [dbo].[dict_table] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='dict_table_key', @ColumnName='created_date';
ALTER TABLE [dbo].[dict_table_key] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[dict_table_key] ADD DEFAULT '2000-01-01 00:00:00' for [created_date];
exec #Drop_Default_Constraint @TableName='dict_table_key', @ColumnName='revised_date';
ALTER TABLE [dbo].[dict_table_key] ALTER COLUMN revised_date datetime2(0) NULL;

-- finish