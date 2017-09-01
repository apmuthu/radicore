CREATE DATABASE [dict];
GO
ALTER DATABASE [dict] SET COMPATIBILITY_LEVEL = 100;
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
 begin
 EXEC [dict].[sys].[sp_fulltext_database] @action = 'enable'
 end;
GO
ALTER DATABASE [dict] SET ANSI_NULL_DEFAULT OFF;
GO
ALTER DATABASE [dict] SET ANSI_NULLS OFF;
GO
ALTER DATABASE [dict] SET ANSI_PADDING OFF;
GO
ALTER DATABASE [dict] SET ANSI_WARNINGS OFF;
GO
ALTER DATABASE [dict] SET ARITHABORT OFF;
GO
ALTER DATABASE [dict] SET AUTO_CLOSE ON;
GO
ALTER DATABASE [dict] SET AUTO_CREATE_STATISTICS ON;
GO
ALTER DATABASE [dict] SET AUTO_SHRINK OFF;
GO
ALTER DATABASE [dict] SET AUTO_UPDATE_STATISTICS ON;
GO
ALTER DATABASE [dict] SET CURSOR_CLOSE_ON_COMMIT OFF;
GO
ALTER DATABASE [dict] SET CURSOR_DEFAULT GLOBAL;
GO
ALTER DATABASE [dict] SET CONCAT_NULL_YIELDS_NULL OFF;
GO
ALTER DATABASE [dict] SET NUMERIC_ROUNDABORT OFF;
GO
ALTER DATABASE [dict] SET QUOTED_IDENTIFIER OFF;
GO
ALTER DATABASE [dict] SET RECURSIVE_TRIGGERS OFF;
GO
ALTER DATABASE [dict] SET DISABLE_BROKER;
GO
ALTER DATABASE [dict] SET AUTO_UPDATE_STATISTICS_ASYNC OFF;
GO
ALTER DATABASE [dict] SET DATE_CORRELATION_OPTIMIZATION OFF;
GO
ALTER DATABASE [dict] SET TRUSTWORTHY OFF;
GO
ALTER DATABASE [dict] SET ALLOW_SNAPSHOT_ISOLATION OFF;
GO
ALTER DATABASE [dict] SET READ_COMMITTED_SNAPSHOT OFF;
GO
ALTER DATABASE [dict] SET PARAMETERIZATION SIMPLE;
GO
ALTER DATABASE [dict] SET READ_WRITE;
GO
ALTER DATABASE [dict] SET RECOVERY SIMPLE;
GO
ALTER DATABASE [dict] SET MULTI_USER;
GO
ALTER DATABASE [dict] SET PAGE_VERIFY CHECKSUM;
GO
ALTER DATABASE [dict] SET DB_CHAINING OFF;
GO
USE [dict];
GO

--
-- Table structure for table dict_column
--

CREATE TABLE dict_column (
  database_id nvarchar(64) NOT NULL,
  table_id nvarchar(64) NOT NULL,
  column_id nvarchar(64) NOT NULL,
  column_seq smallint NOT NULL,
  column_name nvarchar(80) NOT NULL,
  column_desc ntext,
  col_type nvarchar(20) NOT NULL,
  col_type_native nvarchar(32) NOT NULL,
  col_array_type nvarchar(20) NULL,
  col_values ntext,
  user_size bigint NULL,
  col_maxsize bigint NULL,
  col_null char(1) NOT NULL DEFAULT 'Y',
  is_required char(1) NOT NULL DEFAULT 'N',
  col_key nvarchar(3) NULL,
  col_default nvarchar(255) NULL,
  col_auto_increment char(1) NOT NULL DEFAULT 'N',
  col_unsigned char(1) NOT NULL DEFAULT 'N',
  col_zerofill_bwz nvarchar(3) NULL,
  col_precision tinyint NULL,
  col_scale tinyint NULL,
  col_minvalue float NULL,
  col_maxvalue float NULL,
  user_minvalue float NULL,
  user_maxvalue float NULL,
  noedit_nodisplay nvarchar(3) NULL,
  no_search nvarchar(3) NULL,
  no_audit nvarchar(3) NULL,
  upper_lowercase nvarchar(5) NULL,
  is_password char(1) NOT NULL DEFAULT 'N',
  auto_insert char(1) NOT NULL DEFAULT 'N',
  auto_update char(1) NOT NULL DEFAULT 'N',
  infinityisnull char(1) NOT NULL DEFAULT 'N',
  col_subtype nvarchar(10) NULL,
  image_width smallint NULL,
  image_height smallint NULL,
  is_boolean char(1) NOT NULL DEFAULT 'N',
  boolean_true nvarchar(4) NULL,
  boolean_false nvarchar(4) NULL,
  control nvarchar(10) NULL,
  optionlist nvarchar(64) NULL,
  checkbox_label nvarchar(64) NULL,
  task_id nvarchar(80) NULL,
  foreign_field nvarchar(64) NULL,
  align_hv char(1) NULL,
  align_lr char(1) NULL,
  multi_cols tinyint NULL,
  multi_rows tinyint NULL,
  custom_validation nvarchar(255) NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (database_id,table_id,column_id)
);
go

-- --------------------------------------------------------

--
-- Table structure for table dict_database
--

CREATE TABLE dict_database (
  database_id nvarchar(64) NOT NULL,
  database_name nvarchar(80) NOT NULL,
  database_desc ntext,
  subsys_id nvarchar(16) NOT NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (database_id)
);
go

-- --------------------------------------------------------

--
-- Table structure for table dict_related_column
--

CREATE TABLE dict_related_column (
  database_id_snr nvarchar(64) NOT NULL,
  table_id_snr nvarchar(64) NOT NULL,
  column_id_snr nvarchar(64) NOT NULL,
  database_id_jnr nvarchar(64) NOT NULL,
  table_id_jnr nvarchar(64) NOT NULL,
  seq_no tinyint NOT NULL DEFAULT '0',
  column_id_jnr nvarchar(64) NULL,
  seq_in_index tinyint NOT NULL DEFAULT '0',
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (database_id_snr,table_id_snr,column_id_snr,database_id_jnr,table_id_jnr,seq_no)
);
go

-- --------------------------------------------------------

--
-- Table structure for table dict_relationship
--

CREATE TABLE dict_relationship (
  database_id_snr nvarchar(64) NOT NULL,
  table_id_snr nvarchar(64) NOT NULL,
  database_id_jnr nvarchar(64) NOT NULL,
  table_id_jnr nvarchar(64) NOT NULL,
  seq_no tinyint NOT NULL DEFAULT '0',
  table_alias_snr nvarchar(64) NULL,
  table_alias_jnr nvarchar(64) NULL,
  relation_name nvarchar(80) NULL,
  relation_desc ntext,
  relation_type nvarchar(3) NOT NULL DEFAULT 'RES',
  orderby nvarchar(64) NULL,
  parent_field nvarchar(64) NULL,
  calc_field nvarchar(255) NULL,
  key_name NVARCHAR(64) NOT NULL DEFAULT 'PRIMARY',
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (database_id_snr,table_id_snr,database_id_jnr,table_id_jnr,seq_no)
);
go

-- --------------------------------------------------------

--
-- Table structure for table dict_table
--

CREATE TABLE dict_table (
  database_id nvarchar(64) NOT NULL,
  table_id nvarchar(64) NOT NULL,
  table_name nvarchar(80) NOT NULL,
  table_desc ntext,
  audit_logging char(1) NOT NULL DEFAULT 'Y',
  default_orderby nvarchar(64) NULL,
  alt_language_table nvarchar(64) NULL,
  alt_language_cols ntext,
  nameof_start_date nvarchar(40) NULL,
  nameof_end_date nvarchar(40) NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (database_id,table_id)
);
go

-- --------------------------------------------------------

--
-- Table structure for table dict_table_key
--

CREATE TABLE dict_table_key (
  database_id nvarchar(64) NOT NULL,
  table_id nvarchar(64) NOT NULL,
  key_name nvarchar(64) NOT NULL,
  column_id nvarchar(64) NOT NULL,
  seq_in_index tinyint NOT NULL DEFAULT '0',
  is_unique char(1) NOT NULL DEFAULT 'N',
  column_seq tinyint NULL,
  created_date datetime2(0) NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime2(0) NULL,
  revised_user nvarchar(16) NULL,
  PRIMARY KEY (database_id,table_id,key_name,column_id)
);
go
