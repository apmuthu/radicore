CREATE PROCEDURE #Drop_Default_Constraint (@TableName nvarchar(200), @ColumnName nvarchar(200))
AS
BEGIN
	DECLARE @ConstraintName nvarchar(200)
	SELECT @ConstraintName = Name FROM SYS.DEFAULT_CONSTRAINTS
	WHERE PARENT_OBJECT_ID = OBJECT_ID(@TableName)
	AND PARENT_COLUMN_ID = (SELECT column_id FROM sys.columns
							WHERE NAME = @ColumnName
							AND object_id = OBJECT_ID(@TableName))
	
	IF @ConstraintName IS NOT NULL
	EXEC('ALTER TABLE '+ @TableName +' DROP CONSTRAINT ' + @ConstraintName)

END;
go

-- USE [sta_audit];

ALTER TABLE dbo.audit_ssn ADD ssn_datetime datetime2 NULL;
go
UPDATE dbo.audit_ssn SET ssn_datetime=CAST(ssn_date AS datetime)+CAST(ssn_time AS datetime) WHERE ssn_datetime IS NULL;
go

exec #Drop_Default_Constraint @TableName='audit_ssn', @ColumnName='ssn_date';
exec #Drop_Default_Constraint @TableName='audit_ssn', @ColumnName='ssn_time';
ALTER TABLE dbo.audit_ssn DROP COLUMN ssn_date, ssn_time;
go

UPDATE audit_ssn SET ssn_datetime='2000-01-01 00:00:00' WHERE ssn_datetime IS NULL;

ALTER TABLE "dbo"."audit_ssn" ALTER COLUMN  "ssn_datetime" datetime2 NOT NULL;
go
CREATE INDEX audit_ssn_datetime ON audit_ssn (ssn_datetime);
go



ALTER TABLE dbo.audit_trn ADD trn_datetime datetime2 NULL;
go
UPDATE dbo.audit_trn SET trn_datetime=CAST(trn_date AS datetime)+CAST(trn_time AS datetime) WHERE trn_datetime IS NULL;
go

exec #Drop_Default_Constraint @TableName='audit_trn', @ColumnName='trn_date';
exec #Drop_Default_Constraint @TableName='audit_trn', @ColumnName='trn_time';
ALTER TABLE dbo.audit_trn DROP COLUMN trn_date, trn_time;
go

UPDATE audit_trn SET trn_datetime='2000-01-01 00:00:00' WHERE trn_datetime IS NULL;

ALTER TABLE "dbo"."audit_trn" ALTER COLUMN  "trn_datetime" datetime2 NOT NULL;
go
CREATE INDEX audit_trn_datetime ON audit_trn (trn_datetime);
go