CREATE USER "PRODUCT" IDENTIFIED BY "product";
GRANT CONNECT, RESOURCE TO "PRODUCT";
GRANT CREATE DATABASE LINK TO "PRODUCT";
GRANT CREATE MATERIALIZED VIEW TO "PRODUCT";
GRANT CREATE PROCEDURE TO "PRODUCT";
GRANT CREATE PUBLIC SYNONYM TO "PRODUCT";
GRANT CREATE ROLE TO "PRODUCT";
GRANT CREATE SEQUENCE TO "PRODUCT";
GRANT CREATE SYNONYM TO "PRODUCT";
GRANT CREATE TABLE TO "PRODUCT";
GRANT CREATE TRIGGER TO "PRODUCT";
GRANT CREATE TYPE TO "PRODUCT";
GRANT CREATE VIEW TO "PRODUCT";

ALTER SESSION SET CURRENT_SCHEMA = "PRODUCT";

-- 
-- Table structure for table container
-- 

CREATE TABLE container (
  facility_id number(5) NOT NULL,
  container_id number(5) NOT NULL,
  container_desc varchar2(40) NOT NULL,
  container_type_id number(5) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (facility_id,container_id)
);

REVOKE ALL ON container FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON container TO PUBLIC;

-- 
-- Table structure for table container_type
-- 

CREATE TABLE container_type (
  container_type_id number(5) NOT NULL,
  container_type_desc varchar2(40) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (container_type_id)
);
CREATE SEQUENCE container_type_seq;

REVOKE ALL ON container_type FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON container_type TO PUBLIC;
REVOKE ALL ON container_type_seq FROM PUBLIC;
GRANT SELECT,ALTER ON container_type_seq TO PUBLIC;

-- 
-- Table structure for table facility
-- 

CREATE TABLE facility (
  facility_id number(5) NOT NULL,
  facility_desc varchar2(255) NOT NULL,
  facility_type_id number(6) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (facility_id)
);
CREATE SEQUENCE facility_seq;

REVOKE ALL ON facility FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON facility TO PUBLIC;
REVOKE ALL ON facility_seq FROM PUBLIC;
GRANT SELECT,ALTER ON facility_seq TO PUBLIC;

-- 
-- Table structure for table facility_type
-- 

CREATE TABLE facility_type (
  facility_type_id number(6) NOT NULL,
  facility_type_desc varchar2(40) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (facility_type_id)
);
CREATE SEQUENCE facility_type_seq;

REVOKE ALL ON facility_type FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON facility_type TO PUBLIC;
REVOKE ALL ON facility_type_seq FROM PUBLIC;
GRANT SELECT,ALTER ON facility_type_seq TO PUBLIC;

-- 
-- Table structure for table good_identification
-- 

CREATE TABLE good_identification (
  product_id varchar2(16) NOT NULL,
  identity_type_id varchar2(6) NOT NULL,
  id_value varchar2(32) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (product_id,identity_type_id)
);
CREATE UNIQUE INDEX good_identification_idx1 ON good_identification (identity_type_id,id_value);

REVOKE ALL ON good_identification FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON good_identification TO PUBLIC;

-- 
-- Table structure for table good_identity_type
-- 

CREATE TABLE good_identity_type (
  identity_type_id varchar2(6) NOT NULL,
  identity_type_desc varchar2(255) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (identity_type_id)
);

REVOKE ALL ON good_identity_type FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON good_identity_type TO PUBLIC;

-- 
-- Table structure for table inventory_item
-- 

CREATE TABLE inventory_item (
  product_id varchar2(16) NOT NULL,
  inventory_item_id number(6) NOT NULL,
  inv_type char(1) NOT NULL,
  serial_no varchar2(40),
  qty_on_hand number(11),
  total_qty number(11),
  facility_id number(5) NOT NULL,
  container_id number(5) NOT NULL,
  lot_id number(10),
  inv_item_status_id number(5) default '1' NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (product_id,inventory_item_id)
);
CREATE UNIQUE INDEX inventory_item_idx1 ON inventory_item (product_id,serial_no);

REVOKE ALL ON inventory_item FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON inventory_item TO PUBLIC;

-- 
-- Table structure for table inventory_item_status
-- 

CREATE TABLE inventory_item_status (
  inv_item_status_id number(5) NOT NULL,
  inv_item_status_desc varchar2(40) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (inv_item_status_id)
);
CREATE SEQUENCE inventory_item_status_seq;

REVOKE ALL ON inventory_item_status FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON inventory_item_status TO PUBLIC;
REVOKE ALL ON inventory_item_status_seq FROM PUBLIC;
GRANT SELECT,ALTER ON inventory_item_status_seq TO PUBLIC;

-- 
-- Table structure for table inventory_item_status_hist
-- 

CREATE TABLE inventory_item_status_hist (
  product_id varchar2(16) NOT NULL,
  inventory_item_id number(5) NOT NULL,
  seq_no number(5) NOT NULL,
  inv_item_status_id number(5) NOT NULL,
  status_date date NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (product_id,inventory_item_id,seq_no)
);

REVOKE ALL ON inventory_item_status_hist FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON inventory_item_status_hist TO PUBLIC;

-- 
-- Table structure for table inventory_item_variance
-- 

CREATE TABLE inventory_item_variance (
  product_id varchar2(16) NOT NULL,
  inventory_item_id number(5) NOT NULL,
  seq_no number(5) NOT NULL,
  inv_var_reason_id number(5) NOT NULL,
  inventory_date date NOT NULL,
  variance_qty number(11),
  var_comment clob,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (product_id,inventory_item_id,seq_no)
);

REVOKE ALL ON inventory_item_variance FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON inventory_item_variance TO PUBLIC;

-- 
-- Table structure for table inventory_variance_reason
-- 

CREATE TABLE inventory_variance_reason (
  inv_var_reason_id number(5) NOT NULL,
  inv_var_reason_desc varchar2(40) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (inv_var_reason_id)
);
CREATE SEQUENCE inventory_variance_reason_seq;

REVOKE ALL ON inventory_variance_reason FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON inventory_variance_reason TO PUBLIC;
REVOKE ALL ON inventory_variance_reason_seq FROM PUBLIC;
GRANT SELECT,ALTER ON inventory_variance_reason_seq TO PUBLIC;

-- 
-- Table structure for table lot
-- 

CREATE TABLE lot (
  lot_id number(10) NOT NULL,
  quantity number(10) NOT NULL,
  manuf_date date NOT NULL,
  expiry_date date,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (lot_id)
);

REVOKE ALL ON lot FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON lot TO PUBLIC;

-- 
-- Table structure for table price_component
-- 

CREATE TABLE price_component (
  price_component_id number(10) NOT NULL,
  start_date date NOT NULL,
  end_date date,
  price number(11,2),
  percent number(6,3),
  price_type char(1) NOT NULL,
  price_frequency char(1) NOT NULL,
  uom_id varchar2(16),
  quantity number(6),
  product_id varchar2(16),
  prod_feature_id number(8),
  prod_cat_id varchar2(16),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (price_component_id)
);
CREATE INDEX price_component_idx1 ON price_component (product_id);
CREATE INDEX price_component_idx2 ON price_component (prod_feature_id);
CREATE INDEX price_component_idx3 ON price_component (prod_cat_id);

REVOKE ALL ON price_component FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON price_component TO PUBLIC;

-- 
-- Table structure for table prod_cat_class
-- 

CREATE TABLE prod_cat_class (
  product_id varchar2(16) NOT NULL,
  prod_cat_id varchar2(16) NOT NULL,
  seq_no number(5) NOT NULL,
  primary_flag char(1) NOT NULL,
  pcc_comment varchar2(255),
  start_date date NOT NULL,
  end_date date,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (product_id,prod_cat_id,seq_no)
);

REVOKE ALL ON prod_cat_class FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON prod_cat_class TO PUBLIC;

-- 
-- Table structure for table prod_cat_rollup
-- 

CREATE TABLE prod_cat_rollup (
  prod_cat_id_snr varchar2(16) NOT NULL,
  prod_cat_id_jnr varchar2(16) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (prod_cat_id_snr,prod_cat_id_jnr)
);

REVOKE ALL ON prod_cat_rollup FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON prod_cat_rollup TO PUBLIC;

-- 
-- Table structure for table prod_feature_applicability
-- 

CREATE TABLE prod_feature_applicability (
  product_id varchar2(16) NOT NULL,
  prod_feature_id number(9) NOT NULL,
  seq_no number(6) default '1' NOT NULL,
  feature_type char(1) default 'O' NOT NULL,
  start_date date NOT NULL,
  end_date date,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (product_id,prod_feature_id,seq_no)
);

REVOKE ALL ON prod_feature_applicability FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON prod_feature_applicability TO PUBLIC;

-- 
-- Table structure for table prod_feature_interaction
-- 

CREATE TABLE prod_feature_interaction (
  product_id varchar2(16) NOT NULL,
  prod_feature_id_snr number(9) NOT NULL,
  prod_feature_id_jnr number(9) NOT NULL,
  feature_interaction char(1) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (product_id,prod_feature_id_snr,prod_feature_id_jnr)
);

REVOKE ALL ON prod_feature_interaction FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON prod_feature_interaction TO PUBLIC;

-- 
-- Table structure for table product
-- 

CREATE TABLE product (
  product_id varchar2(16) NOT NULL,
  product_name varchar2(255) NOT NULL,
  date_intro date,
  end_date_sales date,
  end_date_support date,
  prod_comment varchar2(255),
  product_subtype char(1) default 'G' NOT NULL,
  uom_id varchar2(16),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (product_id)
);

REVOKE ALL ON product FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON product TO PUBLIC;

-- 
-- Table structure for table product_category
-- 

CREATE TABLE product_category (
  prod_cat_id varchar2(16) NOT NULL,
  prod_cat_desc varchar2(255) NOT NULL,
  product_usage varchar2(16),
  product_industry varchar2(16),
  product_materials varchar2(16),
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (prod_cat_id)
);

REVOKE ALL ON product_category FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON product_category TO PUBLIC;

-- 
-- Table structure for table product_feature
-- 

CREATE TABLE product_feature (
  prod_feature_id number(9) NOT NULL,
  prod_feature_desc varchar2(255) NOT NULL,
  prod_feature_cat_id varchar2(16),
  uom_id varchar2(16),
  measurement number,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (prod_feature_id)
);

REVOKE ALL ON product_feature FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON product_feature TO PUBLIC;

-- 
-- Table structure for table product_feature_category
-- 

CREATE TABLE product_feature_category (
  prod_feature_cat_id varchar2(16) NOT NULL,
  prod_feature_cat_desc varchar2(255) NOT NULL,
  measurement_reqd char(1) default 'N' NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (prod_feature_cat_id)
);

REVOKE ALL ON product_feature_category FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON product_feature_category TO PUBLIC;

-- 
-- Table structure for table unit_of_measure
-- 

CREATE TABLE unit_of_measure (
  uom_id varchar2(16) NOT NULL,
  uom_cat_id varchar2(4) NOT NULL,
  uom_abbrev varchar2(8) NOT NULL,
  uom_desc varchar2(255) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (uom_id)
);

REVOKE ALL ON unit_of_measure FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON unit_of_measure TO PUBLIC;

-- 
-- Table structure for table uom_category
-- 

CREATE TABLE uom_category (
  uom_cat_id varchar2(4) NOT NULL,
  uom_cat_desc varchar2(40) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (uom_cat_id)
);

REVOKE ALL ON uom_category FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON uom_category TO PUBLIC;

-- 
-- Table structure for table uom_conversion
-- 

CREATE TABLE uom_conversion (
  uom_id_from varchar2(16) NOT NULL,
  uom_id_to varchar2(16) NOT NULL,
  conversion_factor number NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (uom_id_from,uom_id_to)
);

REVOKE ALL ON uom_conversion FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON uom_conversion TO PUBLIC;

