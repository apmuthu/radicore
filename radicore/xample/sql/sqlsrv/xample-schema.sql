CREATE DATABASE [xample];
GO
ALTER DATABASE [xample] SET COMPATIBILITY_LEVEL = 100;
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
 begin
 EXEC [xample].[sys].[sp_fulltext_database] @action = 'enable'
 end;
GO
ALTER DATABASE [xample] SET ANSI_NULL_DEFAULT OFF;
GO
ALTER DATABASE [xample] SET ANSI_NULLS OFF;
GO
ALTER DATABASE [xample] SET ANSI_PADDING OFF;
GO
ALTER DATABASE [xample] SET ANSI_WARNINGS OFF;
GO
ALTER DATABASE [xample] SET ARITHABORT OFF;
GO
ALTER DATABASE [xample] SET AUTO_CLOSE ON;
GO
ALTER DATABASE [xample] SET AUTO_CREATE_STATISTICS ON;
GO
ALTER DATABASE [xample] SET AUTO_SHRINK OFF;
GO
ALTER DATABASE [xample] SET AUTO_UPDATE_STATISTICS ON;
GO
ALTER DATABASE [xample] SET CURSOR_CLOSE_ON_COMMIT OFF;
GO
ALTER DATABASE [xample] SET CURSOR_DEFAULT GLOBAL;
GO
ALTER DATABASE [xample] SET CONCAT_NULL_YIELDS_NULL OFF;
GO
ALTER DATABASE [xample] SET NUMERIC_ROUNDABORT OFF;
GO
ALTER DATABASE [xample] SET QUOTED_IDENTIFIER OFF;
GO
ALTER DATABASE [xample] SET RECURSIVE_TRIGGERS OFF;
GO
ALTER DATABASE [xample] SET DISABLE_BROKER;
GO
ALTER DATABASE [xample] SET AUTO_UPDATE_STATISTICS_ASYNC OFF;
GO
ALTER DATABASE [xample] SET DATE_CORRELATION_OPTIMIZATION OFF;
GO
ALTER DATABASE [xample] SET TRUSTWORTHY OFF;
GO
ALTER DATABASE [xample] SET ALLOW_SNAPSHOT_ISOLATION OFF;
GO
ALTER DATABASE [xample] SET READ_COMMITTED_SNAPSHOT OFF;
GO
ALTER DATABASE [xample] SET PARAMETERIZATION SIMPLE;
GO
ALTER DATABASE [xample] SET READ_WRITE;
GO
ALTER DATABASE [xample] SET RECOVERY SIMPLE;
GO
ALTER DATABASE [xample] SET MULTI_USER;
GO
ALTER DATABASE [xample] SET PAGE_VERIFY CHECKSUM;
GO
ALTER DATABASE [xample] SET DB_CHAINING OFF;
GO
USE [xample];
GO
--
-- Table structure for table x_option
--

CREATE TABLE x_option (
  option_id nvarchar(8) NOT NULL default '',
  option_desc nvarchar(40) NOT NULL default '',
  created_date datetime NOT NULL default '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL default 'UNKNOWN',
  revised_date datetime default NULL,
  revised_user nvarchar(16) default NULL,
  PRIMARY KEY  (option_id)
);
go

-- --------------------------------------------------------

--
-- Table structure for table x_option_alt
--

CREATE TABLE x_option_alt (
  option_id nvarchar(8) NOT NULL default '',
  language_id nvarchar(5) NOT NULL default '',
  option_desc nvarchar(40) NOT NULL default '',
  created_date datetime NOT NULL default '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL default 'UNKNOWN',
  revised_date datetime default NULL,
  revised_user nvarchar(16) default NULL,
  PRIMARY KEY  (option_id,language_id)
);
go

-- --------------------------------------------------------

--
-- Table structure for table x_person
--

CREATE TABLE x_person (
  person_id nvarchar(8) NOT NULL default '',
  pers_type_id nvarchar(6) NOT NULL default '',
  node_id smallint NOT NULL default '0',
  nat_ins_no nvarchar(10) NOT NULL default '',
  first_name nvarchar(20) NOT NULL default '',
  last_name nvarchar(30) NOT NULL default '',
  initials nvarchar(6) default NULL,
  star_sign nvarchar(3) NOT NULL default '',
  email_addr nvarchar(50) default NULL,
  value1 smallint default NULL,
  value2 decimal(10,2) default NULL,
  last_addr_no smallint default '0',
  start_date date NOT NULL default '2000-01-01',
  end_date date default '9999-12-31',
  picture nvarchar(40) default NULL,
--  favourite_food set('1','2','3','4','5','6','7','8','9','10') default NULL,
  fckeditor_test text,
  created_date datetime NOT NULL default '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL default 'UNKNOWN',
  revised_date datetime default NULL,
  revised_user nvarchar(16) default NULL,
  PRIMARY KEY  (person_id),
  UNIQUE (nat_ins_no)
);
CREATE INDEX x_person_pers_type_id ON x_person (pers_type_id);
go

-- --------------------------------------------------------

--
-- Table structure for table x_person_addr
--

CREATE TABLE x_person_addr (
  person_id nvarchar(8) NOT NULL default '',
  address_no smallint NOT NULL default '0',
  telephone_no nvarchar(20) default NULL,
  fax_no nvarchar(20) default NULL,
  addr_line_1 nvarchar(30) NOT NULL default '',
  addr_line_2 nvarchar(30) default NULL,
  addr_line_3 nvarchar(30) default NULL,
  town nvarchar(30) NOT NULL default '',
  county nvarchar(30) default NULL,
  postcode nvarchar(10) NOT NULL default '',
  start_date date NOT NULL default '2000-01-01',
  end_date date default '9999-12-31',
  created_date datetime NOT NULL default '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL default 'UNKNOWN',
  revised_date datetime default NULL,
  revised_user nvarchar(16) default NULL,
  PRIMARY KEY  (person_id,address_no)
);
go

-- --------------------------------------------------------

--
-- Table structure for table x_pers_opt_xref
--

CREATE TABLE x_pers_opt_xref (
  person_id nvarchar(8) NOT NULL default '',
  option_id nvarchar(8) NOT NULL default '',
  created_date datetime NOT NULL default '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL default 'UNKNOWN',
  revised_date datetime default NULL,
  revised_user nvarchar(16) default NULL,
  PRIMARY KEY  (person_id,option_id)
);
CREATE INDEX x_pers_opt_xref_option_id ON x_pers_opt_xref (option_id);
go

-- --------------------------------------------------------

--
-- Table structure for table x_pers_type
--

CREATE TABLE x_pers_type (
  pers_type_id nvarchar(6) NOT NULL default '',
  pers_type_desc nvarchar(40) NOT NULL default '',
  created_date datetime NOT NULL default '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL default 'UNKNOWN',
  revised_date datetime default NULL,
  revised_user nvarchar(16) default NULL,
  PRIMARY KEY  (pers_type_id)
);
go

-- --------------------------------------------------------

--
-- Table structure for table x_pers_type_alt
--

CREATE TABLE x_pers_type_alt (
  pers_type_id nvarchar(6) NOT NULL default '',
  language_id nvarchar(5) NOT NULL default '',
  pers_type_desc nvarchar(40) NOT NULL default '',
  created_date datetime NOT NULL default '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL default 'UNKNOWN',
  revised_date datetime default NULL,
  revised_user nvarchar(16) default NULL,
  PRIMARY KEY  (pers_type_id,language_id)
);
go

-- --------------------------------------------------------

--
-- Table structure for table x_tree_level
--

CREATE TABLE x_tree_level (
  tree_type_id nvarchar(8) NOT NULL default '',
  tree_level_id tinyint NOT NULL default '0',
  tree_level_seq tinyint NOT NULL default '0',
  tree_level_desc nvarchar(40) NOT NULL default '',
  created_date datetime NOT NULL default '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL default 'UKNOWN',
  revised_date datetime default NULL,
  revised_user nvarchar(16) default NULL,
  PRIMARY KEY  (tree_type_id,tree_level_id)
);
go

-- --------------------------------------------------------

--
-- Table structure for table x_tree_level_alt
--

CREATE TABLE x_tree_level_alt (
  tree_type_id nvarchar(8) NOT NULL default '',
  tree_level_id tinyint NOT NULL default '0',
  language_id nvarchar(5) NOT NULL default '',
  tree_level_desc nvarchar(40) NOT NULL default '',
  created_date datetime NOT NULL default '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL default 'UKNOWN',
  revised_date datetime default NULL,
  revised_user nvarchar(16) default NULL,
  PRIMARY KEY  (tree_type_id,tree_level_id,language_id)
);

-- --------------------------------------------------------

--
-- Table structure for table x_tree_node
--

CREATE TABLE x_tree_node (
  node_id smallint NOT NULL default '0',
  tree_type_id nvarchar(8) NOT NULL default '',
  tree_level_id tinyint NOT NULL default '0',
  node_desc nvarchar(40) NOT NULL default '',
  node_id_snr smallint default NULL,
  external_code nvarchar(255) default NULL,
  created_date datetime NOT NULL default '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL default 'UNKNOWN',
  revised_date datetime default NULL,
  revised_user nvarchar(16) default NULL,
  PRIMARY KEY  (node_id)
);
CREATE INDEX x_tree_node_tree_type_id ON x_tree_node (tree_type_id,tree_level_id);
CREATE INDEX x_tree_node_node_id_snr ON x_tree_node (node_id_snr);
go

-- --------------------------------------------------------

--
-- Table structure for table x_tree_node_alt
--

CREATE TABLE x_tree_node_alt (
  node_id smallint NOT NULL default '0',
  language_id nvarchar(5) NOT NULL default '',
  node_desc nvarchar(40) NOT NULL default '',
  created_date datetime NOT NULL default '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL default 'UNKNOWN',
  revised_date datetime default NULL,
  revised_user nvarchar(16) default NULL,
  PRIMARY KEY  (node_id,language_id)
);
go

-- --------------------------------------------------------

--
-- Table structure for table x_tree_type
--

CREATE TABLE x_tree_type (
  tree_type_id nvarchar(8) NOT NULL default '',
  tree_type_desc nvarchar(40) NOT NULL default '',
  created_date datetime NOT NULL default '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL default 'UNKNOWN',
  revised_date datetime default NULL,
  revised_user nvarchar(16) default NULL,
  PRIMARY KEY  (tree_type_id)
);
go

-- --------------------------------------------------------

--
-- Table structure for table x_tree_type_alt
--
go

CREATE TABLE x_tree_type_alt (
  tree_type_id nvarchar(8) NOT NULL default '',
  language_id nvarchar(5) NOT NULL default '',
  tree_type_desc nvarchar(40) NOT NULL default '',
  created_date datetime NOT NULL default '2000-01-01 00:00:00',
  created_user nvarchar(16) NOT NULL default 'UNKNOWN',
  revised_date datetime default NULL,
  revised_user nvarchar(16) default NULL,
  PRIMARY KEY  (tree_type_id,language_id)
);
go
