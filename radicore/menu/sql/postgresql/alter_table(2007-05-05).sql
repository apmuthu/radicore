SET search_path = menu;

CREATE INDEX mnu_role_taskfield_index1 ON menu.mnu_role_taskfield USING btree (task_id);

CREATE TABLE mnu_initial_value (
    role_id character varying(16) DEFAULT ''::character varying NOT NULL,
    task_id character varying(80) DEFAULT ''::character varying NOT NULL,
    field_id character varying(40) DEFAULT ''::character varying NOT NULL,
    initial_value character varying(40),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_initial_value 
    ADD CONSTRAINT mnu_initial_value_pkey PRIMARY KEY (role_id, task_id, field_id);

ALTER TABLE menu.mnu_role_taskfield OWNER TO postgres;

CREATE INDEX mnu_initial_value_index1 ON menu.mnu_initial_value USING btree (task_id);

REVOKE ALL ON TABLE mnu_initial_value FROM PUBLIC;
REVOKE ALL ON TABLE mnu_initial_value FROM postgres;
GRANT ALL ON TABLE mnu_initial_value TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_initial_value TO PUBLIC;
