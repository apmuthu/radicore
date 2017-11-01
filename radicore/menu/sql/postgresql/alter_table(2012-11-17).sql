SET search_path = menu;

CREATE TABLE menu.help_text_alt
(
  task_id character varying(80) NOT NULL DEFAULT ''::character varying,
  language_id character varying(5) NOT NULL DEFAULT ''::character varying,
  help_text text,
  created_date timestamp without time zone NOT NULL DEFAULT '2000-01-01 00:00:00'::timestamp without time zone,
  created_user character varying(16) NOT NULL DEFAULT 'UNKNOWN'::character varying,
  revised_date timestamp without time zone,
  revised_user character varying(16),
  CONSTRAINT help_text_alt_pkey PRIMARY KEY (task_id,language_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE menu.help_text_alt OWNER TO postgres;
GRANT ALL ON TABLE menu.help_text_alt TO postgres;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE menu.help_text_alt TO public;

CREATE TABLE menu.mnu_task_alt
(
  task_id character varying(80) NOT NULL DEFAULT ''::character varying,
  language_id character varying(5) NOT NULL DEFAULT ''::character varying,
  task_desc character varying(80) NOT NULL DEFAULT ''::character varying,
  button_text character varying(80) NOT NULL DEFAULT ''::character varying,
  created_date timestamp without time zone NOT NULL DEFAULT '2000-01-01 00:00:00'::timestamp without time zone,
  created_user character varying(16) NOT NULL DEFAULT 'UNKNOWN'::character varying,
  revised_date timestamp without time zone,
  revised_user character varying(16),
  CONSTRAINT mnu_task_alt_pkey PRIMARY KEY (task_id,language_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE menu.mnu_task_alt OWNER TO postgres;
GRANT ALL ON TABLE menu.mnu_task_alt TO postgres;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE menu.mnu_task_alt TO public;
