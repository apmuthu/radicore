SET search_path TO "menu";

CREATE TABLE menu.mnu_time_limit_role
(
  role_id character varying(16),
  seq_no smallint,
  scheduled_start_time time without time zone,
  scheduled_end_time time without time zone,
  scheduled_monday boolean NOT NULL DEFAULT true,
  scheduled_tuesday boolean NOT NULL DEFAULT true,
  scheduled_wednesday boolean NOT NULL DEFAULT true,
  scheduled_thursday boolean NOT NULL DEFAULT true,
  scheduled_friday boolean NOT NULL DEFAULT true,
  scheduled_saturday boolean NOT NULL DEFAULT true,
  scheduled_sunday boolean NOT NULL DEFAULT true,
  created_date timestamp without time zone NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user character varying(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date timestamp without time zone,
  revised_user character varying(16),
  CONSTRAINT mnu_time_limit_role_pkey PRIMARY KEY (role_id,seq_no)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE menu.mnu_time_limit_role OWNER TO postgres;
GRANT ALL ON TABLE menu.mnu_time_limit_role TO postgres;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE menu.mnu_time_limit_role TO public;

CREATE TABLE menu.mnu_time_limit_user
(
  user_id character varying(16),
  seq_no smallint,
  scheduled_start_time time without time zone,
  scheduled_end_time time without time zone,
  scheduled_monday boolean NOT NULL DEFAULT true,
  scheduled_tuesday boolean NOT NULL DEFAULT true,
  scheduled_wednesday boolean NOT NULL DEFAULT true,
  scheduled_thursday boolean NOT NULL DEFAULT true,
  scheduled_friday boolean NOT NULL DEFAULT true,
  scheduled_saturday boolean NOT NULL DEFAULT true,
  scheduled_sunday boolean NOT NULL DEFAULT true,
  created_date timestamp without time zone NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user character varying(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date timestamp without time zone,
  revised_user character varying(16),
  CONSTRAINT mnu_time_limit_user_pkey PRIMARY KEY (user_id,seq_no)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE menu.mnu_time_limit_user OWNER TO postgres;
GRANT ALL ON TABLE menu.mnu_time_limit_user TO postgres;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE menu.mnu_time_limit_user TO public;
