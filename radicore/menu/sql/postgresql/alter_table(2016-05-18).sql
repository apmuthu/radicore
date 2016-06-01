-- SET search_path TO "menu";

ALTER TABLE menu.mnu_task_field ADD COLUMN is_documentation_only character(1) DEFAULT 'N' NOT NULL;

CREATE TABLE mnu_task_quicksearch (
  task_id character varying(80) NOT NULL,
  field_id character varying(40) NOT NULL,
  sort_seq smallint DEFAULT (0)::smallint NOT NULL,
  field_name character varying(40) NOT NULL,
  created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
  created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
  revised_date timestamp without time zone,
  revised_user character varying(16),
  PRIMARY KEY (task_id,field_id)
);

ALTER TABLE mnu_task_quicksearch OWNER TO postgres;
REVOKE ALL ON TABLE mnu_task_quicksearch FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_quicksearch FROM postgres;
GRANT ALL ON TABLE mnu_task_quicksearch TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_quicksearch TO PUBLIC;

CREATE TABLE mnu_task_quicksearch_alt (
  task_id character varying(80) NOT NULL,
  field_id character varying(40) NOT NULL,
  language_id character varying(5) DEFAULT ''::character varying NOT NULL,
  field_name character varying(40) NOT NULL,
  created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
  created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
  revised_date timestamp without time zone,
  revised_user character varying(16),
  PRIMARY KEY (task_id,field_id,language_id)
);

ALTER TABLE mnu_task_quicksearch_alt OWNER TO postgres;
REVOKE ALL ON TABLE mnu_task_quicksearch_alt FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_quicksearch_alt FROM postgres;
GRANT ALL ON TABLE mnu_task_quicksearch_alt TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_quicksearch TO PUBLIC;
