CREATE DATABASE [audit];
GO
ALTER DATABASE [audit] SET COMPATIBILITY_LEVEL = 100;
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
 begin
 EXEC [audit].[sys].[sp_fulltext_database] @action = 'enable'
 end;
GO
ALTER DATABASE [audit] SET ANSI_NULL_DEFAULT OFF;
GO
ALTER DATABASE [audit] SET ANSI_NULLS OFF;
GO
ALTER DATABASE [audit] SET ANSI_PADDING OFF;
GO
ALTER DATABASE [audit] SET ANSI_WARNINGS OFF;
GO
ALTER DATABASE [audit] SET ARITHABORT OFF;
GO
ALTER DATABASE [audit] SET AUTO_CLOSE ON;
GO
ALTER DATABASE [audit] SET AUTO_CREATE_STATISTICS ON;
GO
ALTER DATABASE [audit] SET AUTO_SHRINK OFF;
GO
ALTER DATABASE [audit] SET AUTO_UPDATE_STATISTICS ON;
GO
ALTER DATABASE [audit] SET CURSOR_CLOSE_ON_COMMIT OFF;
GO
ALTER DATABASE [audit] SET CURSOR_DEFAULT GLOBAL;
GO
ALTER DATABASE [audit] SET CONCAT_NULL_YIELDS_NULL OFF;
GO
ALTER DATABASE [audit] SET NUMERIC_ROUNDABORT OFF;
GO
ALTER DATABASE [audit] SET QUOTED_IDENTIFIER OFF;
GO
ALTER DATABASE [audit] SET RECURSIVE_TRIGGERS OFF;
GO
ALTER DATABASE [audit] SET DISABLE_BROKER;
GO
ALTER DATABASE [audit] SET AUTO_UPDATE_STATISTICS_ASYNC OFF;
GO
ALTER DATABASE [audit] SET DATE_CORRELATION_OPTIMIZATION OFF;
GO
ALTER DATABASE [audit] SET TRUSTWORTHY OFF;
GO
ALTER DATABASE [audit] SET ALLOW_SNAPSHOT_ISOLATION OFF;
GO
ALTER DATABASE [audit] SET READ_COMMITTED_SNAPSHOT OFF;
GO
ALTER DATABASE [audit] SET PARAMETERIZATION SIMPLE;
GO
ALTER DATABASE [audit] SET READ_WRITE;
GO
ALTER DATABASE [audit] SET RECOVERY SIMPLE;
GO
ALTER DATABASE [audit] SET MULTI_USER;
GO
ALTER DATABASE [audit] SET PAGE_VERIFY CHECKSUM;
GO
ALTER DATABASE [audit] SET DB_CHAINING OFF;
GO
USE [audit];
GO

-- --------------------------------------------------------

--
-- Table structure for table audit_fld
--

CREATE TABLE audit_fld (
  session_id bigint NOT NULL DEFAULT '0',
  tran_seq_no smallint NOT NULL DEFAULT '0',
  table_seq_no smallint NOT NULL DEFAULT '0',
  field_id nvarchar(255) NOT NULL DEFAULT '',
  old_value ntext,
  new_value ntext,
  PRIMARY KEY (session_id,tran_seq_no,table_seq_no,field_id)
);
CREATE INDEX audit_fld_field_id ON audit_fld (field_id);
go
-- --------------------------------------------------------

--
-- Table structure for table audit_logon_errors
--

CREATE TABLE audit_logon_errors (
  id int NOT NULL IDENTITY(1,1),
  err_timestamp datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  ip_address nvarchar(40) NOT NULL DEFAULT '0.0.0.0',
  user_id nvarchar(16) DEFAULT NULL,
  user_password nvarchar(16) NOT NULL DEFAULT '',
  email_addr nvarchar(50) DEFAULT NULL,
  PRIMARY KEY (id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table audit_ssn
--

CREATE TABLE audit_ssn (
  session_id bigint NOT NULL IDENTITY(1,1),
  user_id nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  ssn_date date NOT NULL DEFAULT '2000-01-01',
  ssn_time time NOT NULL DEFAULT '00:00:00',
  PRIMARY KEY (session_id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table audit_tbl
--

CREATE TABLE audit_tbl (
  session_id bigint NOT NULL DEFAULT '0',
  tran_seq_no smallint NOT NULL DEFAULT '0',
  table_seq_no smallint NOT NULL DEFAULT '0',
  base_name nvarchar(64) NOT NULL DEFAULT '',
  table_name nvarchar(64) NOT NULL DEFAULT '',
  pkey nvarchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (session_id,tran_seq_no,table_seq_no)
);
CREATE INDEX audit_tbl_pkey ON audit_tbl (pkey);
go
-- --------------------------------------------------------

--
-- Table structure for table audit_trn
--

CREATE TABLE audit_trn (
  session_id bigint NOT NULL DEFAULT '0',
  tran_seq_no smallint NOT NULL DEFAULT '0',
  trn_date date NOT NULL DEFAULT '2000-01-01',
  trn_time time NOT NULL DEFAULT '00:00:00',
  task_id nvarchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (session_id,tran_seq_no)
);
go
-- --------------------------------------------------------

--
-- Table structure for table php_session
--

CREATE TABLE php_session (
  session_id nvarchar(32) NOT NULL DEFAULT '',
  user_id nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  date_created datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  last_updated datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  session_data ntext,
  PRIMARY KEY (session_id)
);
CREATE INDEX php_session_last_updated ON php_session (last_updated);
go
