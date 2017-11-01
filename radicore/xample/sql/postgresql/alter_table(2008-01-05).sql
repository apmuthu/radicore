SET search_path TO "xample";

CREATE TABLE x_pers_type_alt (
    pers_type_id character varying(6) DEFAULT ''::character varying NOT NULL,
    language_id character varying(5)DEFAULT ''::character varying NOT NULL,
    pers_type_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16),
    CONSTRAINT x_pers_type_alt_pkey PRIMARY KEY (pers_type_id,language_id)
);
ALTER TABLE xample.x_pers_type_alt OWNER TO postgres;
GRANT ALL ON TABLE xample.x_pers_type_alt TO postgres;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE xample.x_pers_type_alt TO public;

CREATE TABLE x_option_alt (
    option_id character varying(8) DEFAULT ''::character varying NOT NULL,
    language_id character varying(5)DEFAULT ''::character varying NOT NULL,
    option_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16),
    CONSTRAINT x_option_alt_pkey PRIMARY KEY (option_id,language_id)
);
ALTER TABLE xample.x_option_alt OWNER TO postgres;
GRANT ALL ON TABLE xample.x_option_alt TO postgres;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE xample.x_option_alt TO public;

CREATE TABLE x_tree_type_alt (
    tree_type_id character varying(8) DEFAULT ''::character varying NOT NULL,
    language_id character varying(5)DEFAULT ''::character varying NOT NULL,
    tree_type_desc character varying(80) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16),
    CONSTRAINT x_tree_type_alt_pkey PRIMARY KEY (tree_type_id,language_id)
);
ALTER TABLE xample.x_tree_type_alt OWNER TO postgres;
GRANT ALL ON TABLE xample.x_tree_type_alt TO postgres;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE xample.x_tree_type_alt TO public;

CREATE TABLE x_tree_level_alt (
    tree_type_id character varying(8) DEFAULT ''::character varying NOT NULL,
    tree_level_id smallint DEFAULT (0)::smallint NOT NULL,
    language_id character varying(5)DEFAULT ''::character varying NOT NULL,
    tree_level_desc character varying(80) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16),
    CONSTRAINT x_tree_level_alt_pkey PRIMARY KEY (tree_type_id, tree_level_id, language_id)
);
ALTER TABLE xample.x_tree_level_alt OWNER TO postgres;
GRANT ALL ON TABLE xample.x_tree_level_alt TO postgres;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE xample.x_tree_level_alt TO public;

CREATE TABLE x_tree_node_alt (
    node_id smallint DEFAULT (0)::smallint NOT NULL,
    language_id character varying(5)DEFAULT ''::character varying NOT NULL,
    node_desc character varying(80) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16),
    CONSTRAINT tree_node_pkey_alt PRIMARY KEY (node_id, language_id)
);
ALTER TABLE xample.x_tree_node_alt OWNER TO postgres;
GRANT ALL ON TABLE xample.x_tree_node_alt TO postgres;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE xample.x_tree_node_alt TO public;
