CREATE USER "XAMPLE" IDENTIFIED BY "xample";
GRANT CONNECT, RESOURCE TO "XAMPLE";
GRANT CREATE DATABASE LINK TO "XAMPLE";
GRANT CREATE MATERIALIZED VIEW TO "XAMPLE";
GRANT CREATE PROCEDURE TO "XAMPLE";
GRANT CREATE PUBLIC SYNONYM TO "XAMPLE";
GRANT CREATE ROLE TO "XAMPLE";
GRANT CREATE SEQUENCE TO "XAMPLE";
GRANT CREATE SYNONYM TO "XAMPLE";
GRANT CREATE TABLE TO "XAMPLE";
GRANT CREATE TRIGGER TO "XAMPLE";
GRANT CREATE TYPE TO "XAMPLE";
GRANT CREATE VIEW TO "XAMPLE";

ALTER SESSION SET CURRENT_SCHEMA = "XAMPLE";

-- 
-- Table structure for table x_option
-- 

CREATE TABLE x_option (
  option_id varchar2(8) NOT NULL,
  option_desc varchar2(40) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (option_id)
);

REVOKE ALL ON x_option FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON x_option TO PUBLIC;

-- 
-- Table structure for table x_pers_opt_xref
-- 

CREATE TABLE x_pers_opt_xref (
  person_id varchar2(8) NOT NULL,
  option_id varchar2(8) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (person_id,option_id)
);
CREATE INDEX  x_pers_opt_xref_idx1 ON  x_pers_opt_xref (option_id);

REVOKE ALL ON x_pers_opt_xref FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON x_pers_opt_xref TO PUBLIC;

-- 
-- Table structure for table x_pers_type
-- 

CREATE TABLE x_pers_type (
  pers_type_id varchar2(6) NOT NULL,
  pers_type_desc varchar2(40) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (pers_type_id)
);

REVOKE ALL ON x_pers_type FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON x_pers_type TO PUBLIC;

-- 
-- Table structure for table x_person
-- 

CREATE OR REPLACE TYPE t_fvrt_food IS VARRAY(10) OF NUMBER(2);

CREATE TABLE x_person (
  person_id varchar2(8) NOT NULL,
  pers_type_id varchar2(6) NOT NULL,
  node_id number(4) NOT NULL,
  nat_ins_no varchar2(10) NOT NULL,
  first_name varchar2(20) NOT NULL,
  last_name varchar2(30) NOT NULL,
  initials varchar2(6),
  star_sign char(3) NOT NULL,
  email_addr varchar2(50),
  value1 number(5),
  value2 number(10,2),
  last_addr_no number(4),
  start_date date default '2000-01-01' NOT NULL,
  end_date date default '9999-12-31',
  picture varchar2(40),
  favourite_food t_fvrt_food,
  fckeditor_test clob,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (person_id)
);
CREATE UNIQUE INDEX X_PERSON_IDX1 ON x_person (nat_ins_no);
CREATE INDEX  x_person_idx2 ON  x_person (pers_type_id);

REVOKE ALL ON x_person FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON x_person TO PUBLIC;

-- 
-- Table structure for table x_person_addr
-- 

CREATE TABLE x_person_addr (
  person_id varchar2(8) NOT NULL,
  address_no number(4) NOT NULL,
  telephone_no varchar2(20),
  fax_no varchar2(20),
  addr_line_1 varchar2(30) NOT NULL,
  addr_line_2 varchar2(30),
  addr_line_3 varchar2(30),
  town varchar2(30) NOT NULL,
  county varchar2(30),
  postcode varchar2(10) NOT NULL,
  start_date date default '2000-01-01' NOT NULL,
  end_date date default '9999-12-31',
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (person_id,address_no)
);

REVOKE ALL ON x_person_addr FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON x_person_addr TO PUBLIC;

-- 
-- Table structure for table x_tree_level
-- 

CREATE TABLE x_tree_level (
  tree_type_id varchar2(8) NOT NULL,
  tree_level_id number(3) NOT NULL,
  tree_level_seq number(3) NOT NULL,
  tree_level_desc varchar2(40) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (tree_type_id,tree_level_id)
);

REVOKE ALL ON x_tree_level FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON x_tree_level TO PUBLIC;

-- 
-- Table structure for table x_tree_node
-- 

CREATE TABLE x_tree_node (
  node_id number(5) NOT NULL,
  tree_type_id varchar2(8) NOT NULL,
  tree_level_id number(3) NOT NULL,
  node_desc varchar2(40) NOT NULL,
  node_id_snr number(5),
  external_code varchar2(255),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (node_id)
);
CREATE INDEX  x_tree_node_idx1 ON  x_tree_node (tree_type_id, tree_level_id);
CREATE INDEX  x_tree_node_idx2 ON  x_tree_node (node_id_snr);

REVOKE ALL ON x_tree_node FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON x_tree_node TO PUBLIC;

-- 
-- Table structure for table x_tree_type
-- 

CREATE TABLE x_tree_type (
  tree_type_id varchar2(8) NOT NULL,
  tree_type_desc varchar2(40) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (tree_type_id)
);

REVOKE ALL ON x_tree_type FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON x_tree_type TO PUBLIC;

