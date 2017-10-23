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
  help_text nvarchar(max) NOT NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (task_id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table help_text_alt
--

CREATE TABLE help_text_alt (
  task_id nvarchar(80) NOT NULL,
  language_id nvarchar(5) NOT NULL,
  help_text nvarchar(max) NOT NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (task_id,language_id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_account
--

CREATE TABLE mnu_account (
  rdcaccount_id int NOT NULL IDENTITY(1,1),
  account_name nvarchar(80) NOT NULL,
  account_desc nvarchar(max),
  rdcversion int NOT NULL DEFAULT '1',
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
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
  field_value nvarchar(255) NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
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
  task_name nvarchar(80) NOT NULL,
  sort_seq smallint NOT NULL DEFAULT '0',
  breadcrumbs nvarchar(4000) NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
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
  initial_value nvarchar(255) NULL,
  is_noedit char(1) DEFAULT 'N',
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
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
  initial_value nvarchar(255) NULL,
  is_noedit char(1) DEFAULT 'N',
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
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
  input_date_format nvarchar(12) NULL,
  output_date_format nvarchar(12) NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
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
  button_text nvarchar(40) NOT NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
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
  motd_message nvarchar(max) NOT NULL,
  start_date date NOT NULL DEFAULT '2000-01-01',
  end_date date DEFAULT '9999-12-31',
  role_id nvarchar(16) NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
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
  button_text nvarchar(40) NOT NULL,
  context_preselect char(1) DEFAULT 'N',
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (task_id_snr,task_id_jnr)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_pattern
--

CREATE TABLE mnu_pattern (
  pattern_id nvarchar(16) NOT NULL,
  pattern_name nvarchar(60) NOT NULL,
  pattern_desc nvarchar(max),
  visible_screen char(1) DEFAULT 'N',
  context_preselect char(1) DEFAULT 'N',
  keep_data char(1) DEFAULT 'N',
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (pattern_id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_role
--

CREATE TABLE mnu_role (
  role_id nvarchar(16) NOT NULL,
  role_name nvarchar(80) NOT NULL,
  role_desc nvarchar(max),
  start_task_id nvarchar(80) NOT NULL,
  global_access char(1) DEFAULT 'N',
  is_external_auth_off char(1) NOT NULL DEFAULT 'N',
  allow_responsive_gui char(1) NOT NULL DEFAULT 'N',
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
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
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
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
  access_type nvarchar(4) NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (role_id,task_id,field_id)
);
CREATE INDEX mnu_role_taskfield_task_id ON mnu_role_taskfield (task_id);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_saved_selection
--

CREATE TABLE mnu_saved_selection (
  selection_id int NOT NULL IDENTITY(1,1),
  selection_name nvarchar(80) NOT NULL,
  user_id nvarchar(16) NOT NULL,
  task_id nvarchar(80) NOT NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (selection_id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_saved_selection_data
--

-- --------------------------------------------------------

CREATE TABLE mnu_saved_selection_data (
  selection_id int NOT NULL,
  fieldname nvarchar(80) NOT NULL,
  fieldvalue nvarchar(80) NULL,
  sort_seq smallint NULL,
  output_name nvarchar(80) NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (selection_id,fieldname)
);
go
--
-- Table structure for table mnu_subsystem
--

CREATE TABLE mnu_subsystem (
  subsys_id nvarchar(16) NOT NULL,
  subsys_name nvarchar(80) NOT NULL,
  subsys_desc nvarchar(max),
  subsys_dir nvarchar(255) NOT NULL,
  task_prefix nvarchar(8) NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (subsys_id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_task
--

CREATE TABLE mnu_task (
  task_id nvarchar(80) NOT NULL,
  task_name nvarchar(80) NOT NULL,
  task_desc nvarchar(max),
  button_text nvarchar(40) NULL,
  task_type nvarchar(4) NULL,
  script_id nvarchar(80) NULL,
  is_disabled char(1) DEFAULT 'N',
  pattern_id nvarchar(16) NULL,
  subsys_id nvarchar(16) NULL,
  initial_passthru nvarchar(80) NULL,
  selection_fixed nvarchar(255) NULL,
  selection_temp nvarchar(255) NULL,
  settings nvarchar(255) NULL,
  order_by nvarchar(255) NULL,
  keep_data char(1) DEFAULT 'N',
  log_sql_query char(1) DEFAULT 'N',
  screen_refresh smallint NULL,
  use_https char(1) DEFAULT 'N',
  max_execution_time smallint NULL,
  task_id_run_at_end nvarchar(80) NULL,
  task_id_run_at_cancel nvarchar(80) NULL,
  allow_responsive_gui char(1) NOT NULL DEFAULT 'N',
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (task_id)
);
CREATE INDEX mnu_task_subsys_id ON mnu_task (subsys_id);
CREATE INDEX mnu_task_pattern_id ON mnu_task (pattern_id);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_task_alt
--

CREATE TABLE mnu_task_alt (
  task_id nvarchar(80) NOT NULL,
  language_id nvarchar(5) NOT NULL,
  task_name nvarchar(80) NOT NULL,
  task_desc nvarchar(max),
  button_text nvarchar(40) NOT NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (task_id,language_id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_task_field
--

CREATE TABLE mnu_task_field (
  task_id nvarchar(80) NOT NULL,
  field_id nvarchar(40) NOT NULL,
  field_desc nvarchar(255) NULL,
  is_documentation_only CHAR(1) NOT NULL DEFAULT 'N',
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
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
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (task_id,ip_address)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_task_quicksearch
--

CREATE TABLE mnu_task_quicksearch (
  task_id nvarchar(80) NOT NULL,
  field_id nvarchar(40) NOT NULL,
  sort_seq smallint NOT NULL,
  field_name nvarchar(40) NOT NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (task_id,field_id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_task_quicksearch_alt
--

CREATE TABLE mnu_task_quicksearch_alt (
  task_id nvarchar(80) NOT NULL,
  field_id nvarchar(40) NOT NULL,
  language_id nvarchar(5) NOT NULL,
  field_name nvarchar(40) NOT NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (task_id,field_id,language_id)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_time_limit_role
--

CREATE TABLE mnu_time_limit_role (
	role_id nvarchar(16), 
	seq_no smallint NOT NULL DEFAULT '0',
	scheduled_start_time time(0) NULL,
	scheduled_end_time time(0) NULL,
	scheduled_monday char(1) NOT NULL DEFAULT 'Y',
	scheduled_tuesday char(1) NOT NULL DEFAULT 'Y',
	scheduled_wednesday char(1) NOT NULL DEFAULT 'Y',
	scheduled_thursday char(1) NOT NULL DEFAULT 'Y',
	scheduled_friday char(1) NOT NULL DEFAULT 'Y',
	scheduled_saturday char(1) NOT NULL DEFAULT 'N',
	scheduled_sunday char(1) NOT NULL DEFAULT 'N',
	created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  	created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  	revised_date datetime2(0) NULL,
  	revised_user nvarchar(16) NULL,
	PRIMARY KEY (role_id, seq_no)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_time_limit_user
--

CREATE TABLE mnu_time_limit_user (
	user_id nvarchar(16), 
	seq_no smallint NOT NULL DEFAULT '0',
	scheduled_start_time time(0) NULL,
	scheduled_end_time time(0) NULL,
	scheduled_monday char(1) NOT NULL DEFAULT 'Y',
	scheduled_tuesday char(1) NOT NULL DEFAULT 'Y',
	scheduled_wednesday char(1) NOT NULL DEFAULT 'Y',
	scheduled_thursday char(1) NOT NULL DEFAULT 'Y',
	scheduled_friday char(1) NOT NULL DEFAULT 'Y',
	scheduled_saturday char(1) NOT NULL DEFAULT 'N',
	scheduled_sunday char(1) NOT NULL DEFAULT 'N',
	created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  	created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  	revised_date datetime2(0) NULL,
  	revised_user nvarchar(16) NULL,
	PRIMARY KEY (user_id, seq_no)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_todo
--

CREATE TABLE mnu_todo (
  user_id nvarchar(16) NOT NULL,
  seq_no smallint NOT NULL DEFAULT '0',
  item_name nvarchar(80) NOT NULL,
  item_desc nvarchar(max),
  due_date date NOT NULL DEFAULT '0000-00-00',
  visibility tinyint NOT NULL DEFAULT '0',
  is_complete char(1) NOT NULL DEFAULT 'N',
  repeat_interval decimal(3,0) NULL,
  repeat_unit char(1) NULL,
  task_id nvarchar(80) NULL,
  task_context nvarchar(255) NULL,
  object_id nvarchar(255) NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (user_id,seq_no)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_user
--

CREATE TABLE mnu_user (
  user_id nvarchar(16) NOT NULL,
  user_name nvarchar(40) NOT NULL,
  user_password nvarchar(40) NOT NULL,
  rdcaccount_id int NULL,
  pswd_change_datetime datetime2(0) NULL,
  pswd_count smallint NULL,
  force_pswd_chg char(1) DEFAULT 'N',
  in_use char(1) NOT NULL DEFAULT 'N',
  is_disabled char(1) NOT NULL DEFAULT 'N',
  logon_datetime datetime2(0) NULL,
  language_id nvarchar(6) NULL,
  start_date date NOT NULL DEFAULT '2000-01-01',
  end_date date DEFAULT '9999-12-31',
  ip_address nvarchar(40) NULL,
  email_addr nvarchar(50) NOT NULL,
  external_id nvarchar(255) NULL,
  is_external_auth_off char(1) DEFAULT 'N',
  party_id int NULL,
  user_timezone nvarchar(40) NULL,
  allow_responsive_gui char(1) NOT NULL DEFAULT 'N',
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (user_id)
);
CREATE INDEX mnu_user_rdcaccount_id ON mnu_user (rdcaccount_id);
CREATE INDEX mnu_user_party_id ON mnu_user (party_id);
CREATE UNIQUE INDEX UQ1_mnu_user ON mnu_user (email_addr) WHERE email_addr IS NOT NULL;
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_user_alt
--
CREATE TABLE mnu_user_alt (
  user_id nvarchar(16), 
  language_id nvarchar(5),
  user_name nvarchar(40) NOT NULL,  
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (user_id, language_id)
);
GO
-- --------------------------------------------------------

--
-- Table structure for table mnu_user_ip_address
--

CREATE TABLE mnu_user_ip_address (
  user_id nvarchar(16) NOT NULL,
  ip_address nvarchar(40) NOT NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (user_id,ip_address)
);
go
-- --------------------------------------------------------

--
-- Table structure for table mnu_user_role
--

CREATE TABLE mnu_user_role (
  user_id nvarchar(16) NOT NULL, 
  role_id nvarchar(16) NOT NULL,
  sort_seq int NOT NULL,
  start_date date NOT NULL DEFAULT ('2000-01-01'),
  end_date date NULL DEFAULT ('9999-12-31'),
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (user_id, role_id)
);
go

-- finished