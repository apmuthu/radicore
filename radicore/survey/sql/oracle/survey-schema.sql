CREATE USER "SURVEY" IDENTIFIED BY "survey";
GRANT CONNECT, RESOURCE TO "SURVEY";
GRANT CREATE DATABASE LINK TO "SURVEY";
GRANT CREATE MATERIALIZED VIEW TO "SURVEY";
GRANT CREATE PROCEDURE TO "SURVEY";
GRANT CREATE PUBLIC SYNONYM TO "SURVEY";
GRANT CREATE ROLE TO "SURVEY";
GRANT CREATE SEQUENCE TO "SURVEY";
GRANT CREATE SYNONYM TO "SURVEY";
GRANT CREATE TABLE TO "SURVEY";
GRANT CREATE TRIGGER TO "SURVEY";
GRANT CREATE TYPE TO "SURVEY";
GRANT CREATE VIEW TO "SURVEY";

ALTER SESSION SET CURRENT_SCHEMA = "SURVEY";

-- 
-- Table structure for table answer_option
-- 

CREATE TABLE answer_option (
  survey_id number(5) NOT NULL,
  section_id number(5) NOT NULL,
  question_id number(5) NOT NULL,
  answer_id number(2) NOT NULL,
  answer_seq number(2) NOT NULL,
  answer_text varchar2(255) NOT NULL,
  jumpto_section_seq number(5),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN',
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (survey_id,section_id,question_id,answer_id)
);

REVOKE ALL ON answer_option FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON answer_option TO PUBLIC;

-- 
-- Table structure for table asset_type
-- 

CREATE TABLE asset_type (
  asset_type_id number(3) NOT NULL,
  asset_type_desc varchar2(40) NOT NULL,
  image_fname varchar2(255),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (asset_type_id)
);

REVOKE ALL ON asset_type FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON asset_type TO PUBLIC;

-- 
-- Table structure for table default_prompt
-- 

CREATE TABLE default_prompt (
  survey_id number(5) NOT NULL,
  prompt_id number(2) NOT NULL,
  prompt_desc varchar2(30) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (survey_id,prompt_id)
);

REVOKE ALL ON default_prompt FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON default_prompt TO PUBLIC;

-- 
-- Table structure for table location_address
-- 

CREATE TABLE location_address (
  node_id number(5) NOT NULL,
  address_line1 varchar2(80),
  address_line2 varchar2(80),
  town varchar2(80),
  county varchar2(80),
  postcode varchar2(10),
  country varchar2(80),
  telephone varchar2(20),
  fax varchar2(20),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (node_id)
);

REVOKE ALL ON location_address FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON location_address TO PUBLIC;

-- 
-- Table structure for table location_type
-- 

CREATE TABLE location_type (
  location_type_id number(3) NOT NULL,
  location_type_desc varchar2(40) NOT NULL,
  image_fname varchar2(255),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (location_type_id)
);

REVOKE ALL ON location_type FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON location_type TO PUBLIC;

-- 
-- Table structure for table number_option
-- 

CREATE TABLE number_option (
  survey_id number(5) NOT NULL,
  section_id number(5) NOT NULL,
  question_id number(5) NOT NULL,
  min_value number(10) NOT NULL,
  max_value number(10),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (survey_id,section_id,question_id)
);

REVOKE ALL ON number_option FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON number_option TO PUBLIC;

-- 
-- Table structure for table org_type
-- 

CREATE TABLE org_type (
  org_type_id number(3) NOT NULL,
  org_type_desc varchar2(40) NOT NULL,
  image_fname varchar2(255),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (org_type_id)
);

REVOKE ALL ON org_type FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON org_type TO PUBLIC;

-- 
-- Table structure for table question_prompt
-- 

CREATE TABLE question_prompt (
  survey_id number(5) NOT NULL,
  section_id number(5) NOT NULL,
  question_id number(5) NOT NULL,
  prompt_id number(2) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (survey_id,section_id,question_id,prompt_id)
);

REVOKE ALL ON question_prompt FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON question_prompt TO PUBLIC;

-- 
-- Table structure for table risk_status
-- 

CREATE TABLE risk_status (
  risk_status_id number(3) NOT NULL,
  risk_status_desc varchar2(40) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (risk_status_id)
);

REVOKE ALL ON risk_status FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON risk_status TO PUBLIC;

-- 
-- Table structure for table risk_weighting
-- 

CREATE TABLE risk_weighting (
  weighting_id number(3) NOT NULL,
  weighting_desc varchar2(40) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (weighting_id)
);

REVOKE ALL ON risk_weighting FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON risk_weighting TO PUBLIC;

-- 
-- Table structure for table survey_answer_dtl
-- 

CREATE TABLE survey_answer_dtl (
  survey_answer_id number(10) NOT NULL,
  survey_id number(5) NOT NULL,
  section_id number(5) NOT NULL,
  question_id number(5) NOT NULL,
  answer_text varchar2(255) NOT NULL,
  weighting_id number(3),
  measure_adequate char(1) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (survey_answer_id,survey_id,section_id,question_id)
);

REVOKE ALL ON survey_answer_dtl FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON survey_answer_dtl TO PUBLIC;

-- 
-- Table structure for table survey_answer_hdr
-- 

CREATE TABLE survey_answer_hdr (
  survey_answer_id number(10) NOT NULL,
  user_id varchar2(16),
  answer_date date NOT NULL,
  survey_id number(5) NOT NULL,
  node_id number(5) NOT NULL,
  is_complete char(1) default 'N' NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (survey_answer_id)
);

REVOKE ALL ON survey_answer_hdr FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON survey_answer_hdr TO PUBLIC;

-- 
-- Table structure for table survey_hdr
-- 

CREATE TABLE survey_hdr (
  survey_id number(5) NOT NULL,
  survey_name varchar2(80) NOT NULL,
  survey_long_name varchar2(255) NOT NULL,
  survey_type_id varchar2(4) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (survey_id)
);

REVOKE ALL ON survey_hdr FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON survey_hdr TO PUBLIC;

-- 
-- Table structure for table survey_question
-- 

CREATE TABLE survey_question (
  survey_id number(5) NOT NULL,
  section_id number(5) NOT NULL,
  question_id number(5) NOT NULL,
  question_seq number(5) NOT NULL,
  question_text varchar2(255) NOT NULL,
  answer_type char(1) NOT NULL,
  advice_text clob,
  risk_status_id number(2) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (survey_id,section_id,question_id)
);

REVOKE ALL ON survey_question FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON survey_question TO PUBLIC;

-- 
-- Table structure for table survey_section
-- 

CREATE TABLE survey_section (
  survey_id number(5) NOT NULL,
  section_id number(5) NOT NULL,
  section_seq number(5) NOT NULL,
  section_name varchar2(80) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (survey_id,section_id)
);

REVOKE ALL ON survey_section FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON survey_section TO PUBLIC;

-- 
-- Table structure for table survey_type
-- 

CREATE TABLE survey_type (
  survey_type_id varchar2(4) NOT NULL,
  survey_type_desc varchar2(40) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (survey_type_id)
);

REVOKE ALL ON survey_type FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON survey_type TO PUBLIC;

-- 
-- Table structure for table tree_node
-- 

CREATE TABLE tree_node (
  node_id number(5) NOT NULL,
  node_desc varchar2(40) NOT NULL,
  node_type char(1) NOT NULL,
  node_depth number(3) NOT NULL,
  node_id_snr number(5),
  org_type_id number(3),
  location_type_id number(3),
  asset_type_id number(3),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (node_id)
);

REVOKE ALL ON tree_node FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON tree_node TO PUBLIC;

