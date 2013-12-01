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
  database_id nvarchar(64) NOT NULL DEFAULT '',
  table_id nvarchar(64) NOT NULL DEFAULT '',
  column_id nvarchar(64) NOT NULL DEFAULT '',
  column_seq smallint NOT NULL DEFAULT '0',
  column_desc nvarchar(255) NOT NULL DEFAULT '',
  col_comment ntext,
  col_type nvarchar(20) NOT NULL DEFAULT '',
  col_type_native nvarchar(32) NOT NULL DEFAULT '',
  col_array_type nvarchar(20) DEFAULT NULL,
  col_values ntext,
  user_size bigint DEFAULT NULL,
  col_maxsize bigint DEFAULT NULL,
  col_null char(1) NOT NULL DEFAULT 'Y',
  is_required char(1) NOT NULL DEFAULT 'N',
  col_key nvarchar(3) DEFAULT NULL,
  col_default nvarchar(40) DEFAULT NULL,
  col_auto_increment char(1) NOT NULL DEFAULT 'N',
  col_unsigned char(1) NOT NULL DEFAULT 'N',
  col_zerofill_bwz nvarchar(3) DEFAULT NULL,
  col_precision tinyint DEFAULT NULL,
  col_scale tinyint DEFAULT NULL,
  col_minvalue float DEFAULT NULL,
  col_maxvalue float DEFAULT NULL,
  user_minvalue float DEFAULT NULL,
  user_maxvalue float DEFAULT NULL,
  noedit_nodisplay nvarchar(3) DEFAULT NULL,
  no_search nvarchar(3) DEFAULT NULL,
  no_audit nvarchar(3) DEFAULT NULL,
  upper_lowercase nvarchar(5) DEFAULT NULL,
  is_password char(1) NOT NULL DEFAULT 'N',
  auto_insert char(1) NOT NULL DEFAULT 'N',
  auto_update char(1) NOT NULL DEFAULT 'N',
  infinityisnull char(1) NOT NULL DEFAULT 'N',
  col_subtype nvarchar(10) DEFAULT NULL,
  image_width smallint DEFAULT NULL,
  image_height smallint DEFAULT NULL,
  is_boolean char(1) NOT NULL DEFAULT 'N',
  boolean_true nvarchar(4) DEFAULT NULL,
  boolean_false nvarchar(4) DEFAULT NULL,
  control nvarchar(10) DEFAULT NULL,
  optionlist nvarchar(64) DEFAULT NULL,
  checkbox_label nvarchar(64) DEFAULT NULL,
  task_id nvarchar(80) DEFAULT NULL,
  foreign_field nvarchar(64) DEFAULT NULL,
  align_hv char(1) DEFAULT NULL,
  align_lr char(1) DEFAULT NULL,
  multi_cols tinyint DEFAULT NULL,
  multi_rows tinyint DEFAULT NULL,
  custom_validation nvarchar(255) DEFAULT NULL,
  created_date datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (database_id,table_id,column_id)
);
go

-- --------------------------------------------------------

--
-- Table structure for table dict_database
--

CREATE TABLE dict_database (
  database_id nvarchar(64) NOT NULL DEFAULT '',
  database_desc nvarchar(255) NOT NULL DEFAULT '',
  db_comment ntext,
  subsys_id nvarchar(16) NOT NULL DEFAULT '',
  created_date datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (database_id)
);
go

-- --------------------------------------------------------

--
-- Table structure for table dict_related_column
--

CREATE TABLE dict_related_column (
  database_id_snr nvarchar(64) NOT NULL DEFAULT '',
  table_id_snr nvarchar(64) NOT NULL DEFAULT '',
  column_id_snr nvarchar(64) NOT NULL DEFAULT '',
  database_id_jnr nvarchar(64) NOT NULL DEFAULT '',
  table_id_jnr nvarchar(64) NOT NULL DEFAULT '',
  seq_no tinyint NOT NULL DEFAULT '0',
  column_id_jnr nvarchar(64) DEFAULT NULL,
  seq_in_index tinyint NOT NULL DEFAULT '0',
  created_date datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (database_id_snr,table_id_snr,column_id_snr,database_id_jnr,table_id_jnr,seq_no)
);
go

-- --------------------------------------------------------

--
-- Table structure for table dict_relationship
--

CREATE TABLE dict_relationship (
  database_id_snr nvarchar(64) NOT NULL DEFAULT '',
  table_id_snr nvarchar(64) NOT NULL DEFAULT '',
  database_id_jnr nvarchar(64) NOT NULL DEFAULT '',
  table_id_jnr nvarchar(64) NOT NULL DEFAULT '',
  seq_no tinyint NOT NULL DEFAULT '0',
  table_alias_snr nvarchar(64) DEFAULT NULL,
  table_alias_jnr nvarchar(64) DEFAULT NULL,
  relation_desc nvarchar(255) DEFAULT NULL,
  rel_comment ntext,
  rel_type nvarchar(3) NOT NULL DEFAULT 'IGN',
  orderby nvarchar(64) DEFAULT NULL,
  parent_field nvarchar(64) DEFAULT NULL,
  calc_field nvarchar(255) DEFAULT NULL,
  key_name nvarchar(64) NOT NULL DEFAULT 'PRIMARY',
  created_date datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (database_id_snr,table_id_snr,database_id_jnr,table_id_jnr,seq_no)
);
go

-- --------------------------------------------------------

--
-- Table structure for table dict_table
--

CREATE TABLE dict_table (
  database_id nvarchar(64) NOT NULL DEFAULT '',
  table_id nvarchar(64) NOT NULL DEFAULT '',
  table_desc nvarchar(255) NOT NULL DEFAULT '',
  tbl_comment ntext,
  audit_logging char(1) NOT NULL DEFAULT 'Y',
  default_orderby nvarchar(64) DEFAULT NULL,
  alt_language_table nvarchar(64) DEFAULT NULL,
  alt_language_cols ntext,
  nameof_start_date nvarchar(40) DEFAULT NULL,
  nameof_end_date nvarchar(40) DEFAULT NULL,
  created_date datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (database_id,table_id)
);
go

-- --------------------------------------------------------

--
-- Table structure for table dict_table_key
--

CREATE TABLE dict_table_key (
  database_id nvarchar(64) NOT NULL DEFAULT '',
  table_id nvarchar(64) NOT NULL DEFAULT '',
  key_name nvarchar(64) NOT NULL DEFAULT '',
  column_id nvarchar(64) NOT NULL DEFAULT '',
  seq_in_index tinyint NOT NULL DEFAULT '0',
  is_unique char(1) NOT NULL DEFAULT 'N',
  column_seq tinyint DEFAULT NULL,
  created_date datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date datetime DEFAULT NULL,
  revised_user nvarchar(16) DEFAULT NULL,
  PRIMARY KEY (database_id,table_id,key_name,column_id)
);
go
