SET search_path TO "menu";

CREATE TABLE mnu_favourite (
  user_id character varying(16) DEFAULT ''::character varying NOT NULL,
  seq_no smallint DEFAULT (0)::smallint NOT NULL,
  task_id character varying(80) DEFAULT ''::character varying NOT NULL,
  task_desc character varying(80) DEFAULT ''::character varying NOT NULL,
  sort_seq smallint DEFAULT (0)::smallint NOT NULL,
  created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
  created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
  revised_date timestamp without time zone,
  revised_user character varying(16)
);

ALTER TABLE ONLY mnu_favourite ADD CONSTRAINT mnu_favourite_pkey PRIMARY KEY (user_id,seq_no);

ALTER TABLE menu.mnu_favourite OWNER TO postgres;

GRANT ALL ON TABLE menu.mnu_favourite TO postgres;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE menu.mnu_favourite TO public;
