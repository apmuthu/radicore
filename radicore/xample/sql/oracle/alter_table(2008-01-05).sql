CREATE TABLE x_pers_type_alt (
  pers_type_id varchar2(6) NOT NULL,
  language_id varchar2(5) NOT NULL,
  pers_type_desc varchar2(40) NOT NULL,
  created_date timestamp default '2000-01-01' NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (pers_type_id, language_id)
);
REVOKE ALL ON x_pers_type_alt FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON x_pers_type_alt TO PUBLIC;

CREATE TABLE x_option_alt (
  option_id varchar2(8) NOT NULL,
  language_id varchar2(5) NOT NULL,
  option_desc varchar2(40) NOT NULL,
  created_date timestamp default '2000-01-01' NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (option_id, language_id)
);
REVOKE ALL ON x_option_alt FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON x_option_alt TO PUBLIC;

CREATE TABLE x_tree_type_alt (
  tree_type_id varchar2(8) NOT NULL,
  language_id varchar2(5) NOT NULL,
  tree_type_desc varchar2(40) NOT NULL,
  created_date timestamp default '2000-01-01' NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (tree_type_id, language_id)
);
REVOKE ALL ON x_tree_type_alt FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON x_tree_type_alt TO PUBLIC;

CREATE TABLE x_tree_level_alt (
  tree_type_id varchar2(8) NOT NULL,
  tree_level_id number(3) NOT NULL,
  language_id varchar2(5) NOT NULL,
  tree_level_desc varchar2(40) NOT NULL,
  created_date timestamp default '2000-01-01' NOT NULL,
  created_user varchar2(16) default 'UKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (tree_type_id,tree_level_id,language_id)
);
REVOKE ALL ON x_tree_level_alt FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON x_tree_level_alt TO PUBLIC;

CREATE TABLE x_tree_node_alt (
  node_id number(5) NOT NULL,
  language_id varchar2(5) NOT NULL,
  node_desc varchar2(40) NOT NULL,
  created_date timestamp default '2000-01-01' NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (node_id,language_id)
);
REVOKE ALL ON x_tree_node_alt FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON x_tree_node_alt TO PUBLIC;
