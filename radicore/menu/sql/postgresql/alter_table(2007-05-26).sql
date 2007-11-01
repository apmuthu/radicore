SET search_path = menu;

CREATE INDEX mnu_role_taskfield_index1 ON menu.mnu_role_taskfield USING btree (task_id);
ALTER TABLE menu.mnu_role_taskfield OWNER TO postgres;

CREATE TABLE mnu_initial_value_role (
    role_id character varying(16) DEFAULT ''::character varying NOT NULL,
    task_id character varying(80) DEFAULT ''::character varying NOT NULL,
    field_id character varying(40) DEFAULT ''::character varying NOT NULL,
    initial_value character varying(40),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_initial_value_role 
    ADD CONSTRAINT mnu_initial_value_role_pkey PRIMARY KEY (role_id, task_id, field_id);

CREATE INDEX mnu_initial_value_role_index1 ON menu.mnu_initial_value_role USING btree (task_id);

REVOKE ALL ON TABLE mnu_initial_value_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_initial_value_role FROM postgres;
GRANT ALL ON TABLE mnu_initial_value_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_initial_value_role TO PUBLIC;

CREATE TABLE mnu_initial_value_user (
    user_id character varying(16) DEFAULT ''::character varying NOT NULL,
    task_id character varying(80) DEFAULT ''::character varying NOT NULL,
    field_id character varying(40) DEFAULT ''::character varying NOT NULL,
    initial_value character varying(40),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_initial_value_user 
    ADD CONSTRAINT mnu_initial_value_user_pkey PRIMARY KEY (user_id, task_id, field_id);

CREATE INDEX mnu_initial_value_user_index1 ON menu.mnu_initial_value_user USING btree (task_id);

REVOKE ALL ON TABLE mnu_initial_value_user FROM PUBLIC;
REVOKE ALL ON TABLE mnu_initial_value_user FROM postgres;
GRANT ALL ON TABLE mnu_initial_value_user TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_initial_value_user TO PUBLIC;

ALTER TABLE mnu_todo ADD visibility DECIMAL(2,0) NULL;
UPDATE mnu_todo SET visibility=7;
ALTER TABLE mnu_todo ALTER visibility TYPE SMALLINT;
ALTER TABLE mnu_todo ALTER visibility SET NOT NULL;
ALTER TABLE mnu_todo ADD repeat_interval DECIMAL(3,0) NULL;
ALTER TABLE mnu_todo ADD repeat_unit CHAR(1) NULL;
ALTER TABLE mnu_todo ADD task_id VARCHAR(80) NULL;
ALTER TABLE mnu_todo ADD task_context VARCHAR(255) NULL;

