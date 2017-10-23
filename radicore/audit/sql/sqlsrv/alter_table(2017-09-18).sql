-- USE [audit];

ALTER TABLE php_session ALTER COLUMN session_id nvarchar(256) NOT NULL;
GO
