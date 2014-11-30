SET search_path TO "menu";

ALTER TABLE menu.mnu_language
	ADD COLUMN input_date_format character varying(12),
	ADD COLUMN output_date_format character varying(12);

CREATE UNIQUE INDEX user_id_task_id ON menu.mnu_favourite (user_id ASC NULLS LAST, task_id ASC NULLS LAST);

CREATE TABLE IF NOT EXISTS mnu_user_alt (
  user_id character varying(16) NOT NULL DEFAULT '',
  language_id character varying(5) NOT NULL DEFAULT '',
  user_name character varying(30) NOT NULL DEFAULT '',
  created_date timestamp without time zone NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user character varying(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date timestamp without time zone DEFAULT NULL,
  revised_user character varying(16) DEFAULT NULL,
  PRIMARY KEY (user_id,language_id)
);

ALTER TABLE menu.mnu_user_alt OWNER TO postgres;
GRANT ALL ON TABLE menu.mnu_user_alt TO postgres;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE menu.mnu_user_alt TO public;

CREATE TABLE IF NOT EXISTS mnu_user_role (
  user_id character varying(16) NOT NULL DEFAULT '',
  role_id character varying(16) NOT NULL DEFAULT '',
  is_primary character(1) DEFAULT 'N',
  created_date timestamp without time zone NOT NULL DEFAULT '2000-01-01 00:00:00',
  created_user character varying(16) NOT NULL DEFAULT 'UNKNOWN',
  revised_date timestamp without time zone DEFAULT NULL,
  revised_user character varying(16) DEFAULT NULL,
  PRIMARY KEY (user_id,role_id)
);

ALTER TABLE menu.mnu_user_role OWNER TO postgres;
GRANT ALL ON TABLE menu.mnu_user_role TO postgres;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE menu.mnu_user_role TO public;

INSERT INTO mnu_user_role (user_id, role_id, is_primary, created_date, created_user)
                    SELECT user_id, role_id, 'Y', '2014-04-17', created_user FROM mnu_user;

ALTER TABLE mnu_user DROP COLUMN role_id;
