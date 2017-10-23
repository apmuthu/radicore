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

CREATE PROCEDURE #Drop_Unique_keys (@TableName nvarchar(200))
AS
BEGIN
	DECLARE @ConstraintName nvarchar(200)
	WHILE 1=1
	BEGIN
	    SELECT TOP 1 @ConstraintName = Name FROM SYS.INDEXES
	    WHERE object_id = object_id(@TableName)
	      AND is_primary_key <> 1
              AND is_unique = 1
	    IF @@ROWCOUNT = 0 BREAK
	    EXEC('ALTER TABLE ['+ @TableName +'] DROP CONSTRAINT [' + @ConstraintName +']')
	END

END;
GO

USE [menu];

ALTER TABLE [dbo].[mnu_account] ALTER COLUMN account_name NVARCHAR(80) NOT NULL;
ALTER TABLE [dbo].[mnu_account] ADD account_desc nvarchar(max);
go

exec sp_rename 'mnu_favourite.task_desc', 'task_name', 'COLUMN';

ALTER TABLE [dbo].[mnu_nav_button] ALTER COLUMN button_text NVARCHAR(40) NOT NULL;
ALTER TABLE [dbo].[mnu_nav_button] ALTER COLUMN context_preselect CHAR(1) NOT NULL;
go

exec sp_rename 'mnu_pattern.pattern_desc', 'pattern_name', 'COLUMN';
exec sp_rename 'mnu_pattern.pattern_long_desc', 'pattern_desc', 'COLUMN';

exec sp_rename 'mnu_role.role_desc', 'role_name', 'COLUMN';
ALTER TABLE [dbo].[mnu_role] ALTER COLUMN role_name NVARCHAR(80) NOT NULL;
ALTER TABLE [dbo].[mnu_role] ADD role_desc nvarchar(max);
go

exec sp_rename 'mnu_saved_selection.selection_desc', 'selection_name', 'COLUMN';

exec sp_rename 'mnu_subsystem.subsys_desc', 'subsys_name', 'COLUMN';
ALTER TABLE [dbo].[mnu_subsystem] ALTER COLUMN subsys_name NVARCHAR(80) NOT NULL;
ALTER TABLE [dbo].[mnu_subsystem] ADD subsys_desc nvarchar(max);
go

UPDATE mnu_task SET is_disabled='N' WHERE is_disabled IS NULL;
UPDATE mnu_task SET keep_data='N' WHERE keep_data IS NULL;
UPDATE mnu_task SET log_sql_query='N' WHERE log_sql_query IS NULL;
UPDATE mnu_task SET use_https='N' WHERE use_https IS NULL;
go

exec sp_rename 'mnu_task.task_desc', 'task_name', 'COLUMN';
ALTER TABLE [dbo].[mnu_task] ADD task_desc nvarchar(max);


UPDATE mnu_task SET button_text=SUBSTRING(button_text,1,40);
UPDATE mnu_task SET button_text=task_id WHERE button_text IS NULL;
ALTER TABLE [dbo].[mnu_task] ALTER COLUMN button_text NVARCHAR(40) NOT NULL;
go

exec sp_rename 'mnu_task_alt.task_desc', 'task_name', 'COLUMN';
ALTER TABLE [dbo].[mnu_task_alt] ADD task_desc nvarchar(max);
ALTER TABLE [dbo].[mnu_task_alt] ALTER COLUMN button_text NVARCHAR(80) NOT NULL;
go

exec #Drop_Default_Constraint @TableName='mnu_task_quicksearch', @ColumnName='sort_seq';
ALTER TABLE [dbo].[mnu_task_quicksearch] ALTER COLUMN field_name NVARCHAR(80) NOT NULL;
ALTER TABLE [dbo].[mnu_task_quicksearch_alt] ALTER COLUMN field_name NVARCHAR(80) NOT NULL;
go

exec sp_rename 'mnu_todo.item_desc', 'item_name', 'COLUMN';
exec sp_rename 'mnu_todo.item_notes', 'item_desc', 'COLUMN';
go

ALTER TABLE [dbo].[mnu_user] ALTER COLUMN user_name NVARCHAR(40) NOT NULL;
go

exec #Drop_Unique_keys @TableName='mnu_user';
UPDATE mnu_user SET email_addr=user_id + '@null.null' WHERE email_addr IS NULL;
ALTER TABLE [dbo].[mnu_user] ALTER COLUMN email_addr NVARCHAR(50) NOT NULL;
CREATE UNIQUE INDEX UQ1_mnu_user ON mnu_user(email_addr) WHERE email_addr IS NOT NULL;
go

ALTER TABLE [dbo].[mnu_user_alt] ALTER COLUMN user_name NVARCHAR(40) NOT NULL;
go

-- update database contents
UPDATE mnu_task_quicksearch SET field_id='database_name', field_name='Database Name' WHERE field_id='database_desc';
UPDATE mnu_task_quicksearch SET field_id='table_name', field_name='Table Name' WHERE field_id='table_desc';
UPDATE mnu_task_quicksearch SET field_id='pattern_name', field_name='Pattern Name' WHERE field_id='pattern_desc';
UPDATE mnu_task_quicksearch SET field_id='role_name', field_name='Role Name' WHERE field_id='role_desc';
UPDATE mnu_task_quicksearch SET field_id='subsys_name', field_name='Subsystem Name' WHERE field_id='subsys_desc';
UPDATE mnu_task_quicksearch SET field_id='task_name', field_name='Task Name' WHERE field_id='task_desc';
UPDATE mnu_task_quicksearch SET field_id='item_name', field_name='Item Name' WHERE field_id='item_desc';
go

-- change datetime2(7) to datetime2(0)

exec #Drop_Default_Constraint @TableName='help_text', @ColumnName='created_date';
ALTER TABLE [dbo].[help_text] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[help_text] ADD CONSTRAINT DF_help_text_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='help_text', @ColumnName='revised_date';
ALTER TABLE [dbo].[help_text] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='help_text_alt', @ColumnName='created_date';
ALTER TABLE [dbo].[help_text_alt] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[help_text_alt] ADD CONSTRAINT DF_help_text_alt_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='help_text_alt', @ColumnName='revised_date';
ALTER TABLE [dbo].[help_text_alt] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_account', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_account] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_account] ADD CONSTRAINT DF_mnu_account_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_account', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_account] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_control', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_control] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_control] ADD CONSTRAINT DF_mnu_control_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_control', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_control] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_favourite', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_favourite] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_favourite] ADD CONSTRAINT DF_mnu_favourite_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_favourite', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_favourite] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_initial_value_role', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_initial_value_role] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_initial_value_role] ADD CONSTRAINT DF_mnu_initial_value_role_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_initial_value_role', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_initial_value_role] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_initial_value_user', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_initial_value_user] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_initial_value_user] ADD CONSTRAINT DF_mnu_initial_value_user_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_initial_value_user', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_initial_value_user] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_language', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_language] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_language] ADD CONSTRAINT DF_mnu_language_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_language', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_language] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_menu', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_menu] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_menu] ADD CONSTRAINT DF_mnu_menu_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_menu', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_menu] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_motd', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_motd] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_motd] ADD CONSTRAINT DF_mnu_motd_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_motd', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_motd] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_nav_button', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_nav_button] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_nav_button] ADD CONSTRAINT DF_mnu_nav_button_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_nav_button', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_nav_button] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_pattern', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_pattern] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_pattern] ADD CONSTRAINT DF_mnu_pattern_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_pattern', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_pattern] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_role', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_role] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_role] ADD CONSTRAINT DF_mnu_role_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_role', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_role] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_role_task', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_role_task] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_role_task] ADD CONSTRAINT DF_mnu_role_task_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_role_task', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_role_task] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_role_taskfield', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_role_taskfield] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_role_taskfield] ADD CONSTRAINT DF_mnu_role_taskfield_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_role_taskfield', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_role_taskfield] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_saved_selection', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_saved_selection] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_saved_selection] ADD CONSTRAINT DF_mnu_saved_selection_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_saved_selection', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_saved_selection] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_saved_selection_data', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_saved_selection_data] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_saved_selection_data] ADD CONSTRAINT DF_mnu_saved_selection_data_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_saved_selection_data', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_saved_selection_data] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_subsystem', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_subsystem] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_subsystem] ADD CONSTRAINT DF_mnu_subsystem_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_subsystem', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_subsystem] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_task', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_task] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_task] ADD CONSTRAINT DF_mnu_task_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_task', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_task] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_task_alt', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_task_alt] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_task_alt] ADD CONSTRAINT DF_mnu_task_alt_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_task_alt', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_task_alt] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_task_field', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_task_field] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_task_field] ADD CONSTRAINT DF_mnu_task_field_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_task_field', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_task_field] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_task_ip_address', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_task_ip_address] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_task_ip_address] ADD CONSTRAINT DF_mnu_task_ip_address_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_task_ip_address', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_task_ip_address] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_task_quicksearch', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_task_quicksearch] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_task_quicksearch] ADD CONSTRAINT DF_mnu_task_quicksearch_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_task_quicksearch', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_task_quicksearch] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_task_quicksearch_alt', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_task_quicksearch_alt] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_task_quicksearch_alt] ADD CONSTRAINT DF_mnu_task_quicksearch_alt_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_task_quicksearch_alt', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_task_quicksearch_alt] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_time_limit_role', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_time_limit_role] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_time_limit_role] ADD CONSTRAINT DF_mnu_time_limit_role_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_time_limit_role', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_time_limit_role] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_time_limit_user', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_time_limit_user] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_time_limit_user] ADD CONSTRAINT DF_mnu_time_limit_user_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_time_limit_user', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_time_limit_user] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_todo', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_todo] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_todo] ADD CONSTRAINT DF_mnu_todo_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_todo', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_todo] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_user', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_user] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_user] ADD CONSTRAINT DF_mnu_user_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_user', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_user] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_user_alt', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_user_alt] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_user_alt] ADD CONSTRAINT DF_mnu_user_alt_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_user_alt', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_user_alt] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_user_ip_address', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_user_ip_address] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_user_ip_address] ADD CONSTRAINT DF_mnu_user_ip_address_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_user_ip_address', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_user_ip_address] ALTER COLUMN revised_date datetime2(0) NULL;

exec #Drop_Default_Constraint @TableName='mnu_user_role', @ColumnName='created_date';
ALTER TABLE [dbo].[mnu_user_role] ALTER COLUMN created_date datetime2(0) NOT NULL;
ALTER TABLE [dbo].[mnu_user_role] ADD CONSTRAINT DF_mnu_user_role_created_date default '2000-01-01 00:00:00' for created_date;
exec #Drop_Default_Constraint @TableName='mnu_user_role', @ColumnName='revised_date';
ALTER TABLE [dbo].[mnu_user_role] ALTER COLUMN revised_date datetime2(0) NULL;
go

-- combine separate DATE and TIME fields into a single DATETIME field
ALTER TABLE [dbo].[mnu_user] ADD pswd_change_datetime datetime2(0) NULL;
go
UPDATE [dbo].[mnu_user] SET pswd_change_datetime=CAST(pswd_chg_date AS datetime)+CAST(pswd_chg_time AS datetime) WHERE pswd_change_datetime IS NULL;
go
exec #Drop_Default_Constraint @TableName='mnu_user', @ColumnName='pswd_chg_date';
exec #Drop_Default_Constraint @TableName='mnu_user', @ColumnName='pswd_chg_time';
ALTER TABLE [dbo].[mnu_user] DROP COLUMN pswd_chg_date, pswd_chg_time;
go

ALTER TABLE [dbo].[mnu_user] ADD logon_datetime datetime2(0) NULL;
go
UPDATE [dbo].[mnu_user] SET logon_datetime=CAST(logon_date AS datetime)+CAST(logon_time AS datetime) WHERE logon_datetime IS NULL;
go
exec #Drop_Default_Constraint @TableName='mnu_user', @ColumnName='logon_date';
exec #Drop_Default_Constraint @TableName='mnu_user', @ColumnName='logon_time';
ALTER TABLE [dbo].[mnu_user] DROP COLUMN logon_date, logon_time;
go

-- changes to allow output for responsive gui
ALTER TABLE [dbo].[mnu_role] ADD [allow_responsive_gui] char(1) DEFAULT 'N' NOT NULL;
ALTER TABLE [dbo].[mnu_task] ADD [allow_responsive_gui] char(1) DEFAULT 'N' NOT NULL;
ALTER TABLE [dbo].[mnu_user] ADD [allow_responsive_gui] char(1) DEFAULT 'N' NOT NULL;
go

-- finish