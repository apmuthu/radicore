CREATE DATABASE [menu];
GO
ALTER DATABASE [menu] SET COMPATIBILITY_LEVEL = 100;
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
 begin
 EXEC [menu].[sys].[sp_fulltext_database] @action = 'enable'
 end;
GO
ALTER DATABASE [menu] SET ANSI_NULL_DEFAULT OFF;
GO
ALTER DATABASE [menu] SET ANSI_NULLS OFF;
GO
ALTER DATABASE [menu] SET ANSI_PADDING OFF;
GO
ALTER DATABASE [menu] SET ANSI_WARNINGS OFF;
GO
ALTER DATABASE [menu] SET ARITHABORT OFF;
GO
ALTER DATABASE [menu] SET AUTO_CLOSE ON;
GO
ALTER DATABASE [menu] SET AUTO_CREATE_STATISTICS ON;
GO
ALTER DATABASE [menu] SET AUTO_SHRINK OFF;
GO
ALTER DATABASE [menu] SET AUTO_UPDATE_STATISTICS ON;
GO
ALTER DATABASE [menu] SET CURSOR_CLOSE_ON_COMMIT OFF;
GO
ALTER DATABASE [menu] SET CURSOR_DEFAULT GLOBAL;
GO
ALTER DATABASE [menu] SET CONCAT_NULL_YIELDS_NULL OFF;
GO
ALTER DATABASE [menu] SET NUMERIC_ROUNDABORT OFF;
GO
ALTER DATABASE [menu] SET QUOTED_IDENTIFIER OFF;
GO
ALTER DATABASE [menu] SET RECURSIVE_TRIGGERS OFF;
GO
ALTER DATABASE [menu] SET DISABLE_BROKER;
GO
ALTER DATABASE [menu] SET AUTO_UPDATE_STATISTICS_ASYNC OFF;
GO
ALTER DATABASE [menu] SET DATE_CORRELATION_OPTIMIZATION OFF;
GO
ALTER DATABASE [menu] SET TRUSTWORTHY OFF;
GO
ALTER DATABASE [menu] SET ALLOW_SNAPSHOT_ISOLATION OFF;
GO
ALTER DATABASE [menu] SET READ_COMMITTED_SNAPSHOT OFF;
GO
ALTER DATABASE [menu] SET PARAMETERIZATION SIMPLE;
GO
ALTER DATABASE [menu] SET READ_WRITE;
GO
ALTER DATABASE [menu] SET RECOVERY SIMPLE;
GO
ALTER DATABASE [menu] SET MULTI_USER;
GO
ALTER DATABASE [menu] SET PAGE_VERIFY CHECKSUM;
GO
ALTER DATABASE [menu] SET DB_CHAINING OFF;
GO
USE [menu];
GO

--
-- Table structure for table help_text
--

CREATE TABLE help_text (
  task_id nvarchar(80) NOT NULL,
  help_text ntext NOT NULL,
  created_date datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (task_id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_account
--

CREATE TABLE mnu_account (
  rdcaccount_id int NOT NULL IDENTITY(1,1),
  account_name nvarchar(255) NOT NULL,
  rdcversion int NOT NULL DEFAULT '1',
  created_date datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) DEFAULT 'UNKNOWN',
  revised_date datetime DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (rdcaccount_id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_control
--

CREATE TABLE mnu_control (
  record_id nvarchar(16) NOT NULL,
  field_id nvarchar(32) NOT NULL,
  field_value nvarchar(255) DEFAULT NULL,
  created_date datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (record_id,field_id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_favourite
--

CREATE TABLE mnu_favourite (
  user_id nvarchar(16) NOT NULL,
  seq_no smallint NOT NULL DEFAULT '0',
  task_id nvarchar(80) NOT NULL,
  task_desc nvarchar(80) NOT NULL,
  sort_seq smallint NOT NULL DEFAULT '0',
  breadcrumbs nvarchar(4000) DEFAULT NULL,
  created_date datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (user_id,seq_no)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_initial_value_role
--

CREATE TABLE mnu_initial_value_role (
  role_id nvarchar(16) NOT NULL,
  task_id nvarchar(80) NOT NULL,
  field_id nvarchar(40) NOT NULL,
  initial_value nvarchar(255) DEFAULT NULL,
  is_noedit char(1) DEFAULT 'N',
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (role_id,task_id,field_id)
);
CREATE INDEX mnu_initial_value_role_task_id ON mnu_initial_value_role (task_id);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_initial_value_user
--

CREATE TABLE mnu_initial_value_user (
  user_id nvarchar(16) NOT NULL,
  task_id nvarchar(80) NOT NULL,
  field_id nvarchar(40) NOT NULL,
  initial_value nvarchar(255) DEFAULT NULL,
  is_noedit char(1) DEFAULT 'N',
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (user_id,task_id,field_id)
);
CREATE INDEX mnu_initial_value_user_task_id ON mnu_initial_value_user (task_id);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_language
--

CREATE TABLE mnu_language (
  language_id nvarchar(5) NOT NULL DEFAULT 'EN',
  language_name nvarchar(40) NOT NULL DEFAULT 'English',
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (language_id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_menu
--

CREATE TABLE mnu_menu (
  menu_id nvarchar(80) NOT NULL,
  task_id_jnr nvarchar(80) NOT NULL,
  sort_seq tinyint NOT NULL DEFAULT '000',
  button_text nvarchar(40) DEFAULT NULL,
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (menu_id,task_id_jnr)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_motd
--

CREATE TABLE mnu_motd (
  motd_id int NOT NULL IDENTITY(1,1),
  motd_subject nvarchar(80) NOT NULL,
  motd_message ntext NOT NULL,
  start_date date NOT NULL DEFAULT '2000-01-01',
  end_date date DEFAULT '9999-12-31',
  role_id nvarchar(16) DEFAULT NULL,
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (motd_id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_nav_button
--

CREATE TABLE mnu_nav_button (
  task_id_snr nvarchar(80) NOT NULL,
  task_id_jnr nvarchar(80) NOT NULL,
  sort_seq tinyint NOT NULL DEFAULT '000',
  button_text nvarchar(40) DEFAULT NULL,
  context_preselect char(1) DEFAULT 'N',
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (task_id_snr,task_id_jnr)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_pattern
--

CREATE TABLE mnu_pattern (
  pattern_id nvarchar(16) NOT NULL,
  pattern_desc nvarchar(60) NOT NULL,
  pattern_long_desc ntext,
  visible_screen char(1) DEFAULT 'N',
  context_preselect char(1) DEFAULT 'N',
  keep_data char(1) DEFAULT 'N',
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (pattern_id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_role
--

CREATE TABLE mnu_role (
  role_id nvarchar(16) NOT NULL,
  role_desc nvarchar(30) NOT NULL,
  start_task_id nvarchar(80) NOT NULL,
  global_access char(1) DEFAULT 'N',
  is_external_auth_off char(1) DEFAULT 'N',
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (role_id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_role_task
--

CREATE TABLE mnu_role_task (
  role_id nvarchar(16) NOT NULL,
  task_id nvarchar(80) NOT NULL,
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (role_id,task_id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_role_taskfield
--

CREATE TABLE mnu_role_taskfield (
  role_id nvarchar(16) NOT NULL,
  task_id nvarchar(80) NOT NULL,
  field_id nvarchar(40) NOT NULL,
  access_type nvarchar(4) DEFAULT NULL,
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (role_id,task_id,field_id)
);
CREATE INDEX mnu_role_taskfield_task_id ON mnu_role_taskfield (task_id);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_subsystem
--

CREATE TABLE mnu_subsystem (
  subsys_id nvarchar(16) NOT NULL,
  subsys_desc nvarchar(255) NOT NULL,
  subsys_dir nvarchar(255) DEFAULT NULL,
  task_prefix nvarchar(8) DEFAULT NULL,
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (subsys_id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_task
--

CREATE TABLE mnu_task (
  task_id nvarchar(80) NOT NULL,
  task_desc nvarchar(80) NOT NULL,
  button_text nvarchar(80) DEFAULT NULL,
  task_type nvarchar(4) DEFAULT NULL,
  script_id nvarchar(80) DEFAULT NULL,
  is_disabled char(1) DEFAULT 'N',
  pattern_id nvarchar(16) DEFAULT NULL,
  subsys_id nvarchar(16) DEFAULT NULL,
  initial_passthru nvarchar(80) DEFAULT NULL,
  selection_fixed nvarchar(255) DEFAULT NULL,
  selection_temp nvarchar(255) DEFAULT NULL,
  settings nvarchar(255) DEFAULT NULL,
  order_by nvarchar(255) DEFAULT NULL,
  keep_data char(1) DEFAULT 'N',
  log_sql_query char(1) DEFAULT 'N',
  screen_refresh smallint DEFAULT NULL,
  use_https char(1) DEFAULT 'N',
  max_execution_time smallint DEFAULT NULL,
  task_id_run_at_end nvarchar(80) DEFAULT NULL,
  task_id_run_at_cancel nvarchar(80) DEFAULT NULL,
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (task_id)
);
CREATE INDEX mnu_task_subsys_id ON mnu_task (subsys_id);
CREATE INDEX mnu_task_pattern_id ON mnu_task (pattern_id);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_task_field
--

CREATE TABLE mnu_task_field (
  task_id nvarchar(80) NOT NULL,
  field_id nvarchar(40) NOT NULL,
  field_desc nvarchar(255) DEFAULT NULL,
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (task_id,field_id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_task_ip_address
--

CREATE TABLE mnu_task_ip_address (
  task_id nvarchar(80) NOT NULL,
  ip_address nvarchar(40) NOT NULL,
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (task_id,ip_address)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_todo
--

CREATE TABLE mnu_todo (
  user_id nvarchar(16) NOT NULL,
  seq_no smallint NOT NULL DEFAULT '0',
  item_desc nvarchar(80) NOT NULL,
  item_notes ntext,
  due_date date NOT NULL DEFAULT '0000-00-00',
  visibility tinyint NOT NULL DEFAULT '0',
  is_complete char(1) NOT NULL DEFAULT 'N',
  repeat_interval decimal(3,0) DEFAULT NULL,
  repeat_unit char(1) DEFAULT NULL,
  task_id nvarchar(80) DEFAULT NULL,
  task_context nvarchar(255) DEFAULT NULL,
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (user_id,seq_no)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_user
--

CREATE TABLE mnu_user (
  user_id nvarchar(16) NOT NULL,
  user_name nvarchar(30) NOT NULL,
  user_password nvarchar(40) NOT NULL,
  role_id nvarchar(16) NOT NULL,
  rdcaccount_id int DEFAULT NULL,
  pswd_chg_date date DEFAULT NULL,
  pswd_chg_time time DEFAULT NULL,
  pswd_count smallint DEFAULT NULL,
  in_use char(1) NOT NULL DEFAULT 'N',
  is_disabled char(1) NOT NULL DEFAULT 'N',
  logon_date date DEFAULT NULL,
  logon_time time DEFAULT NULL,
  language_code nvarchar(6) DEFAULT NULL,
  start_date date NOT NULL DEFAULT '2000-01-01',
  end_date date DEFAULT '9999-12-31',
  ip_address nvarchar(40) DEFAULT NULL,
  email_addr nvarchar(50) DEFAULT NULL,
  external_id nvarchar(255) DEFAULT NULL,
  is_external_auth_off char(1) DEFAULT 'N',
  party_id int DEFAULT NULL,
  user_timezone nvarchar(40) DEFAULT NULL,
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (user_id),
  UNIQUE (email_addr)
);
CREATE INDEX mnu_user_role_id ON mnu_user (role_id);
CREATE INDEX mnu_user_rdcaccount_id ON mnu_user (rdcaccount_id);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_user_ip_address
--

CREATE TABLE mnu_user_ip_address (
  user_id nvarchar(16) NOT NULL,
  ip_address nvarchar(40) NOT NULL,
  created_date datetime2 NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2 DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (user_id,ip_address)
);
go
