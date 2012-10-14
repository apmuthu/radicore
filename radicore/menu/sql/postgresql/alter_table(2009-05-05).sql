SET search_path TO "menu";

CREATE TABLE mnu_motd (
  motd_id serial NOT NULL,
  motd_subject character varying(80) NOT NULL,
  motd_message text NOT NULL,
  start_date date NOT NULL,
  end_date date DEFAULT '9999-12-31'::date,
  role_id character varying(16),
  created_date timestamp without time zone NOT NULL DEFAULT '2001-01-01 00:00:00'::timestamp without time zone,
  created_user character varying(16) NOT NULL DEFAULT 'UNKNOWN'::character varying,
  revised_date timestamp without time zone,
  revised_user character varying(16),
  CONSTRAINT motd_id PRIMARY KEY (motd_id)
);

ALTER TABLE menu.mnu_motd OWNER TO postgres;
