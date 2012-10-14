USE [audit];
GO

ALTER TABLE audit_logon_errors ALTER COLUMN ip_address nvarchar(40) NOT NULL;
GO
