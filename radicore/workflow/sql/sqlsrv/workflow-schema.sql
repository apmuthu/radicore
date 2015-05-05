CREATE DATABASE [workflow];
GO
ALTER DATABASE [workflow] SET COMPATIBILITY_LEVEL = 100;
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
 begin
 EXEC [workflow].[sys].[sp_fulltext_database] @action = 'enable'
 end;
GO
ALTER DATABASE [workflow] SET ANSI_NULL_DEFAULT OFF;
GO
ALTER DATABASE [workflow] SET ANSI_NULLS OFF;
GO
ALTER DATABASE [workflow] SET ANSI_PADDING OFF;
GO
ALTER DATABASE [workflow] SET ANSI_WARNINGS OFF;
GO
ALTER DATABASE [workflow] SET ARITHABORT OFF;
GO
ALTER DATABASE [workflow] SET AUTO_CLOSE ON;
GO
ALTER DATABASE [workflow] SET AUTO_CREATE_STATISTICS ON;
GO
ALTER DATABASE [workflow] SET AUTO_SHRINK OFF;
GO
ALTER DATABASE [workflow] SET AUTO_UPDATE_STATISTICS ON;
GO
ALTER DATABASE [workflow] SET CURSOR_CLOSE_ON_COMMIT OFF;
GO
ALTER DATABASE [workflow] SET CURSOR_DEFAULT GLOBAL;
GO
ALTER DATABASE [workflow] SET CONCAT_NULL_YIELDS_NULL OFF;
GO
ALTER DATABASE [workflow] SET NUMERIC_ROUNDABORT OFF;
GO
ALTER DATABASE [workflow] SET QUOTED_IDENTIFIER OFF;
GO
ALTER DATABASE [workflow] SET RECURSIVE_TRIGGERS OFF;
GO
ALTER DATABASE [workflow] SET DISABLE_BROKER;
GO
ALTER DATABASE [workflow] SET AUTO_UPDATE_STATISTICS_ASYNC OFF;
GO
ALTER DATABASE [workflow] SET DATE_CORRELATION_OPTIMIZATION OFF;
GO
ALTER DATABASE [workflow] SET TRUSTWORTHY OFF;
GO
ALTER DATABASE [workflow] SET ALLOW_SNAPSHOT_ISOLATION OFF;
GO
ALTER DATABASE [workflow] SET READ_COMMITTED_SNAPSHOT OFF;
GO
ALTER DATABASE [workflow] SET PARAMETERIZATION SIMPLE;
GO
ALTER DATABASE [workflow] SET READ_WRITE;
GO
ALTER DATABASE [workflow] SET RECOVERY SIMPLE;
GO
ALTER DATABASE [workflow] SET MULTI_USER;
GO
ALTER DATABASE [workflow] SET PAGE_VERIFY CHECKSUM;
GO
ALTER DATABASE [workflow] SET DB_CHAINING OFF;
GO
USE [workflow];
GO

-- --------------------------------------------------------

--
-- Table structure for table wf_arc
--

CREATE TABLE wf_arc (
  workflow_id smallint NOT NULL DEFAULT '0',
  transition_id smallint NOT NULL DEFAULT '0',
  place_id smallint NOT NULL DEFAULT '0',
  direction nvarchar(3) NOT NULL DEFAULT 'IN',
  arc_type nvarchar(10) NOT NULL DEFAULT 'SEQ',
  pre_condition nvarchar(MAX),
  created_date datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (workflow_id,transition_id,place_id,direction)
);
CREATE INDEX wf_arc_place_id ON wf_arc (workflow_id,place_id,direction);
CREATE INDEX wf_arc_transition_id ON wf_arc (workflow_id,transition_id,direction);
go

-- --------------------------------------------------------

--
-- Table structure for table wf_case
--

CREATE TABLE wf_case (
  rdcaccount_id int NOT NULL DEFAULT '1',
  case_id int NOT NULL DEFAULT '0',
  workflow_id smallint NOT NULL DEFAULT '0',
  convarchar(MAX) nvarchar(255) NOT NULL DEFAULT '',
  case_status nvarchar(2) NOT NULL DEFAULT 'OP',
  start_date datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  end_date datetime DEFAULT NULL,
  created_date datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (case_id)
);
CREATE INDEX wf_case_workflow_id ON wf_case (workflow_id);
CREATE INDEX wf_case_rdcaccount_id ON wf_case (rdcaccount_id);
go

-- --------------------------------------------------------

--
-- Table structure for table wf_place
--

CREATE TABLE wf_place (
  workflow_id smallint NOT NULL DEFAULT '0',
  place_id smallint NOT NULL DEFAULT '0',
  place_type char(1) NOT NULL DEFAULT '5',
  place_name nvarchar(80) NOT NULL DEFAULT '',
  place_desc nvarchar(MAX),
  created_date datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (workflow_id,place_id)
);
go

-- --------------------------------------------------------

--
-- Table structure for table wf_token
--

CREATE TABLE wf_token (
  rdcaccount_id int NOT NULL DEFAULT '1',
  case_id int NOT NULL DEFAULT '0',
  token_id smallint NOT NULL DEFAULT '0',
  workflow_id smallint NOT NULL DEFAULT '0',
  place_id smallint NOT NULL DEFAULT '0',
  convarchar(MAX) nvarchar(255) NOT NULL DEFAULT '',
  token_status nvarchar(4) NOT NULL DEFAULT 'FREE',
  enabled_date datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  cancelled_date datetime DEFAULT NULL,
  consumed_date datetime DEFAULT NULL,
  PRIMARY KEY (case_id,token_id)
);
CREATE INDEX wf_token_place_id ON wf_token (workflow_id,place_id);
CREATE INDEX wf_token_rdcaccount_id ON wf_token (rdcaccount_id);
go

-- --------------------------------------------------------

--
-- Table structure for table wf_transition
--

CREATE TABLE wf_transition (
  workflow_id smallint NOT NULL DEFAULT '0',
  transition_id smallint NOT NULL DEFAULT '0',
  transition_name nvarchar(80) NOT NULL DEFAULT '',
  transition_desc nvarchar(MAX),
  transition_trigger nvarchar(4) NOT NULL DEFAULT 'USER',
  time_limit int DEFAULT NULL,
  task_id nvarchar(80) NOT NULL DEFAULT '',
  role_id nvarchar(16) DEFAULT NULL,
  created_date datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (workflow_id,transition_id)
);
go

-- --------------------------------------------------------

--
-- Table structure for table wf_workflow
--

CREATE TABLE wf_workflow (
  workflow_id smallint NOT NULL DEFAULT '0',
  workflow_name nvarchar(80) NOT NULL DEFAULT '',
  workflow_desc nvarchar(MAX),
  start_task_id nvarchar(80) NOT NULL DEFAULT '',
  is_valid char(1) NOT NULL DEFAULT 'N',
  workflow_errors nvarchar(MAX),
  start_date date DEFAULT NULL,
  end_date date DEFAULT NULL,
  created_date datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (workflow_id)
);
go

-- --------------------------------------------------------

--
-- Table structure for table wf_workitem
--

CREATE TABLE wf_workitem (
  rdcaccount_id int NOT NULL DEFAULT '1',
  case_id int NOT NULL DEFAULT '0',
  workitem_id smallint NOT NULL DEFAULT '0',
  workflow_id smallint NOT NULL DEFAULT '0',
  transition_id smallint NOT NULL DEFAULT '0',
  transition_trigger nvarchar(4) NOT NULL DEFAULT 'USER',
  task_id nvarchar(80) NOT NULL DEFAULT '',
  convarchar(MAX) nvarchar(255) NOT NULL DEFAULT '',
  workitem_status nvarchar(2) NOT NULL DEFAULT 'EN',
  enabled_date datetime DEFAULT NULL,
  cancelled_date datetime DEFAULT NULL,
  finished_date datetime DEFAULT NULL,
  deadline datetime DEFAULT NULL,
  role_id nvarchar(16) DEFAULT NULL,
  user_id nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (case_id,workitem_id)
);
CREATE INDEX wf_workitem_transition_id ON wf_workitem (workflow_id,transition_id);
CREATE INDEX wf_workitem_rdcaccount_id ON wf_workitem (rdcaccount_id);
go
