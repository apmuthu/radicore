-- SET search_path TO "menu";

CREATE TABLE mnu_saved_selection (
  selection_id serial NOT NULL,
  selection_desc varchar(80) NOT NULL,
  user_id varchar(16) NOT NULL,
  task_id varchar(80) NOT NULL,
  created_date timestamp without time zone NOT NULL,
  created_user character varying(16) NOT NULL DEFAULT 'UNKNOWN'::character varying,
  revised_date timestamp without time zone,
  revised_user character varying(16),
  PRIMARY KEY (selection_id)
);

CREATE SEQUENCE mnu_saved_selection_selection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

REVOKE ALL ON SEQUENCE mnu_saved_selection_selection_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE mnu_saved_selection_selection_id_seq FROM postgres;
GRANT ALL ON SEQUENCE mnu_saved_selection_selection_id_seq TO postgres;
GRANT ALL ON SEQUENCE mnu_saved_selection_selection_id_seq TO PUBLIC;

REVOKE ALL ON TABLE mnu_saved_selection FROM PUBLIC;
REVOKE ALL ON TABLE mnu_saved_selection FROM postgres;
GRANT ALL ON TABLE mnu_saved_selection TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_saved_selection TO PUBLIC;

CREATE TABLE mnu_saved_selection_data (
  selection_id integer NOT NULL,
  fieldname character varying(80) NOT NULL,
  fieldvalue character varying(80) DEFAULT NULL,
  created_date timestamp without time zone NOT NULL,
  created_user character varying(16) NOT NULL DEFAULT 'UNKNOWN'::character varying,
  revised_date timestamp without time zone,
  revised_user character varying(16),
  PRIMARY KEY (selection_id,fieldname)
);

REVOKE ALL ON TABLE mnu_saved_selection_data FROM PUBLIC;
REVOKE ALL ON TABLE mnu_saved_selection_data FROM postgres;
GRANT ALL ON TABLE mnu_saved_selection_data TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_saved_selection_data TO PUBLIC;
