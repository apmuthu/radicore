-- 
-- Database: "product"
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table "container"
-- 

CREATE TABLE "container" (
  "facility_id" smallint  NOT NULL default '0',
  "container_id" smallint NOT NULL default '0',
  "container_desc" varchar(40) NOT NULL default '',
  "container_type_id" smallint  NOT NULL default '0',
  "created_date" timestamp NOT NULL default '2001-01-01 00:00:00',
  "created_user" varchar(16) default NULL,
  "revised_date" timestamp default NULL,
  "revised_user" varchar(16) default NULL,
  PRIMARY KEY  ("facility_id","container_id")
);

-- --------------------------------------------------------

-- 
-- Table structure for table "container_type"
-- 

CREATE TABLE "container_type" (
  "container_type_id" serial  NOT NULL,
  "container_type_desc" varchar(40) NOT NULL default '',
  "created_date" timestamp NOT NULL default '2001-01-01 00:00:00',
  "created_user" varchar(16) default NULL,
  "revised_date" timestamp default NULL,
  "revised_user" varchar(16) default NULL,
  PRIMARY KEY  ("container_type_id")
) ;

-- --------------------------------------------------------

-- 
-- Table structure for table "facility"
-- 

CREATE TABLE "facility" (
  "facility_id" serial NOT NULL,
  "facility_desc" varchar(255) NOT NULL default '',
  "facility_type_id" smallint  NOT NULL default '0',
  "created_date" timestamp NOT NULL default '2001-01-01 00:00:00',
  "created_user" varchar(16) default NULL,
  "revised_date" timestamp default NULL,
  "revised_user" varchar(16) default NULL,
  PRIMARY KEY  ("facility_id")
) ;

-- --------------------------------------------------------

-- 
-- Table structure for table "facility_type"
-- 

CREATE TABLE "facility_type" (
  "facility_type_id" serial NOT NULL,
  "facility_type_desc" varchar(40) NOT NULL default '',
  "created_date" timestamp NOT NULL default '2001-01-01 00:00:00',
  "created_user" varchar(16) default NULL,
  "revised_date" timestamp default NULL,
  "revised_user" varchar(16) default NULL,
  PRIMARY KEY  ("facility_type_id")
) ;

-- 
-- Table structure for table "inventory_item"
-- 

CREATE TABLE "inventory_item" (
  "product_id" varchar(16) NOT NULL default '',
  "inventory_item_id" smallint NOT NULL default '0',
  "inv_type" char(1) NOT NULL default '',
  "serial_no" varchar(40) default NULL,
  "qty_on_hand" int default NULL,
  "total_qty" int default NULL,
  "facility_id" smallint  NOT NULL default '0',
  "container_id" smallint  NOT NULL default '0',
  "lot_id" int  default NULL,
  "inv_item_status_id" smallint NOT NULL default '1',
  "created_date" timestamp NOT NULL default '2001-01-01 00:00:00',
  "created_user" varchar(16) default NULL,
  "revised_date" timestamp default NULL,
  "revised_user" varchar(16) default NULL,
  PRIMARY KEY  ("product_id","inventory_item_id")
) ;

ALTER TABLE ONLY inventory_item
    ADD CONSTRAINT inventory_item_product_id_key UNIQUE (product_id, serial_no);

-- --------------------------------------------------------

-- 
-- Table structure for table "inventory_item_status"
-- 

CREATE TABLE "inventory_item_status" (
  "inv_item_status_id" serial NOT NULL,
  "inv_item_status_desc" varchar(40) NOT NULL default '',
  "created_date" timestamp NOT NULL default '2001-01-01 00:00:00',
  "created_user" varchar(16) default NULL,
  "revised_date" timestamp default NULL,
  "revised_user" varchar(16) default NULL,
  PRIMARY KEY  ("inv_item_status_id")
) ;

-- --------------------------------------------------------

-- 
-- Table structure for table "inventory_item_status_hist"
-- 

CREATE TABLE "inventory_item_status_hist" (
  "product_id" varchar(16) NOT NULL default '',
  "inventory_item_id" smallint  NOT NULL default '0',
  "seq_no" smallint NOT NULL default '0',
  "inv_item_status_id" smallint  NOT NULL default '0',
  "status_date" date NOT NULL default '2001-01-01',
  "created_date" timestamp NOT NULL default '2001-01-01 00:00:00',
  "created_user" varchar(16) default NULL,
  "revised_date" timestamp default NULL,
  "revised_user" varchar(16) default NULL,
  PRIMARY KEY  ("product_id","inventory_item_id","seq_no")
) ;

-- --------------------------------------------------------

-- 
-- Table structure for table "inventory_item_variance"
-- 

CREATE TABLE "inventory_item_variance" (
  "product_id" varchar(16) NOT NULL default '',
  "inventory_item_id" smallint  NOT NULL default '0',
  "seq_no" smallint  NOT NULL default '0',
  "inv_var_reason_id" smallint  NOT NULL default '0',
  "inventory_date" date NOT NULL default '2001-01-01',
  "variance_qty" int default NULL,
  "comment" text default NULL,
  "created_date" timestamp NOT NULL default '2001-01-01 00:00:00',
  "created_user" varchar(16) default NULL,
  "revised_date" timestamp default NULL,
  "revised_user" varchar(16) default NULL,
  PRIMARY KEY  ("product_id","inventory_item_id","seq_no")
) ;

-- --------------------------------------------------------

-- 
-- Table structure for table "inventory_variance_reason"
-- 

CREATE TABLE "inventory_variance_reason" (
  "inv_var_reason_id" serial NOT NULL,
  "inv_var_reason_desc" varchar(40) NOT NULL default '',
  "created_date" timestamp NOT NULL default '2001-01-01 00:00:00',
  "created_user" varchar(16) default NULL,
  "revised_date" timestamp default NULL,
  "revised_user" varchar(16) default NULL,
  PRIMARY KEY  ("inv_var_reason_id")
) ;

-- --------------------------------------------------------

-- 
-- Table structure for table "lot"
-- 

CREATE TABLE "lot" (
  "lot_id" int  NOT NULL default '0',
  "quantity" int NOT NULL default '0',
  "manuf_date" date NOT NULL default '2001-01-01',
  "expiry_date" date default NULL,
  "created_date" timestamp NOT NULL default '2001-01-01 00:00:00',
  "created_user" varchar(16) default NULL,
  "revised_date" timestamp default NULL,
  "revised_user" varchar(16) default NULL,
  PRIMARY KEY  ("lot_id")
) ;

