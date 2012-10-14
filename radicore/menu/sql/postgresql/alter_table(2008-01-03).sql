SET search_path TO "menu";

CREATE TABLE menu.mnu_language (
    language_id character varying(5) DEFAULT 'EN'::character varying NOT NULL,
    language_name character varying(40) DEFAULT 'English'::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16),
    CONSTRAINT mnu_language_pkey PRIMARY KEY (language_id)
);
ALTER TABLE menu.mnu_language OWNER TO postgres;
GRANT ALL ON TABLE menu.mnu_language TO postgres;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE menu.mnu_language TO public;

ALTER TABLE menu.mnu_user ADD COLUMN radius_id character varying(40);
ALTER TABLE menu.mnu_user ADD COLUMN is_radius_auth_off character(1);
ALTER TABLE menu.mnu_user ALTER COLUMN is_radius_auth_off SET DEFAULT 'N';

ALTER TABLE menu.mnu_role ADD COLUMN is_radius_auth_off character(1);
ALTER TABLE menu.mnu_role ALTER COLUMN is_radius_auth_off SET DEFAULT 'N';
ALTER TABLE menu.mnu_role ALTER COLUMN global_access SET DEFAULT 'N';

ALTER TABLE menu.mnu_initial_value_role ADD COLUMN is_noedit character(1);
ALTER TABLE menu.mnu_initial_value_role ALTER COLUMN is_noedit SET DEFAULT 'N';
ALTER TABLE menu.mnu_initial_value_user ADD COLUMN is_noedit character(1);
ALTER TABLE menu.mnu_initial_value_user ALTER COLUMN is_noedit SET DEFAULT 'N';

ALTER TABLE menu.mnu_task ALTER settings TYPE character varying(255);


