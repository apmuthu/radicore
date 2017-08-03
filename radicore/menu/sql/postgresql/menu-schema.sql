--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.3
-- Dumped by pg_dump version 9.5.3

-- Started on 2016-05-19 11:03:24

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: menu; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA menu;

ALTER SCHEMA menu OWNER TO postgres;

SET search_path = menu, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: help_text; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE help_text (
    task_id character varying(80) NOT NULL,
    help_text text,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY help_text ADD CONSTRAINT help_text_pkey PRIMARY KEY (task_id);

ALTER TABLE help_text OWNER TO postgres;

REVOKE ALL ON TABLE help_text FROM PUBLIC;
REVOKE ALL ON TABLE help_text FROM postgres;
GRANT ALL ON TABLE help_text TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE help_text TO PUBLIC;

--
-- Name: help_text_alt; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE help_text_alt (
    task_id character varying(80) NOT NULL,
    language_id character varying(5) NOT NULL,
    help_text text,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY help_text_alt ADD CONSTRAINT help_text_alt_pkey PRIMARY KEY (task_id, language_id);

ALTER TABLE help_text_alt OWNER TO postgres;

REVOKE ALL ON TABLE help_text_alt FROM PUBLIC;
REVOKE ALL ON TABLE help_text_alt FROM postgres;
GRANT ALL ON TABLE help_text_alt TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE help_text_alt TO PUBLIC;

--
-- Name: mnu_account; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_account (
    rdcaccount_id integer NOT NULL,
    account_name character varying(80) NOT NULL,
    account_desc text,
    rdcversion integer DEFAULT 1 NOT NULL,
    created_date timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_account ADD CONSTRAINT mnu_account_pkey PRIMARY KEY (rdcaccount_id);

ALTER TABLE mnu_account OWNER TO postgres;

REVOKE ALL ON TABLE mnu_account FROM PUBLIC;
REVOKE ALL ON TABLE mnu_account FROM postgres;
GRANT ALL ON TABLE mnu_account TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_account TO PUBLIC;

CREATE SEQUENCE mnu_account_rdcaccount_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE mnu_account_rdcaccount_id_seq OWNER TO postgres;
ALTER SEQUENCE mnu_account_rdcaccount_id_seq OWNED BY mnu_account.rdcaccount_id;
ALTER TABLE ONLY mnu_account ALTER COLUMN rdcaccount_id SET DEFAULT nextval('mnu_account_rdcaccount_id_seq'::regclass);

REVOKE ALL ON SEQUENCE mnu_account_rdcaccount_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE mnu_account_rdcaccount_id_seq FROM postgres;
GRANT ALL ON SEQUENCE mnu_account_rdcaccount_id_seq TO postgres;
GRANT ALL ON SEQUENCE mnu_account_rdcaccount_id_seq TO PUBLIC;

--
-- Name: mnu_control; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_control (
    record_id character varying(16) NOT NULL,
    field_id character varying(32) NOT NULL,
    field_value character varying(255),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_control ADD CONSTRAINT mnu_control_pkey PRIMARY KEY (record_id, field_id);

ALTER TABLE mnu_control OWNER TO postgres;

REVOKE ALL ON TABLE mnu_control FROM PUBLIC;
REVOKE ALL ON TABLE mnu_control FROM postgres;
GRANT ALL ON TABLE mnu_control TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_control TO PUBLIC;

--
-- Name: mnu_favourite; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_favourite (
    user_id character varying(16) NOT NULL,
    seq_no smallint DEFAULT (0)::smallint NOT NULL,
    task_id character varying(80) NOT NULL,
    task_name character varying(80) NOT NULL,
    sort_seq smallint DEFAULT (0)::smallint NOT NULL,
    breadcrumbs character varying(4000),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_favourite ADD CONSTRAINT mnu_favourite_pkey PRIMARY KEY (user_id, seq_no);
CREATE UNIQUE INDEX user_id_task_id ON mnu_favourite USING btree (user_id, task_id);

ALTER TABLE mnu_favourite OWNER TO postgres;

REVOKE ALL ON TABLE mnu_favourite FROM PUBLIC;
REVOKE ALL ON TABLE mnu_favourite FROM postgres;
GRANT ALL ON TABLE mnu_favourite TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_favourite TO PUBLIC;

--
-- Name: mnu_initial_value_role; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_initial_value_role (
    role_id character varying(16) NOT NULL,
    task_id character varying(80) NOT NULL,
    field_id character varying(40) NOT NULL,
    initial_value character varying(40),
    is_noedit character(1) DEFAULT 'N'::bpchar,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_initial_value_role ADD CONSTRAINT mnu_initial_value_role_pkey PRIMARY KEY (role_id, task_id, field_id);
CREATE INDEX mnu_initial_value_role_index1 ON mnu_initial_value_role USING btree (task_id);

ALTER TABLE mnu_initial_value_role OWNER TO postgres;

REVOKE ALL ON TABLE mnu_initial_value_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_initial_value_role FROM postgres;
GRANT ALL ON TABLE mnu_initial_value_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_initial_value_role TO PUBLIC;

--
-- Name: mnu_initial_value_user; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_initial_value_user (
    user_id character varying(16) NOT NULL,
    task_id character varying(80) NOT NULL,
    field_id character varying(40) NOT NULL,
    initial_value character varying(40),
    is_noedit character(1) DEFAULT 'N'::bpchar,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_initial_value_user ADD CONSTRAINT mnu_initial_value_user_pkey PRIMARY KEY (user_id, task_id, field_id);
CREATE INDEX mnu_initial_value_user_index1 ON mnu_initial_value_user USING btree (task_id);

ALTER TABLE mnu_initial_value_user OWNER TO postgres;

REVOKE ALL ON TABLE mnu_initial_value_user FROM PUBLIC;
REVOKE ALL ON TABLE mnu_initial_value_user FROM postgres;
GRANT ALL ON TABLE mnu_initial_value_user TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_initial_value_user TO PUBLIC;

--
-- Name: mnu_language; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_language (
    language_id character varying(5) DEFAULT 'EN'::character varying NOT NULL,
    language_name character varying(40) DEFAULT 'English'::character varying NOT NULL,
    input_date_format character varying(12),
    output_date_format character varying(12),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_language ADD CONSTRAINT mnu_language_pkey PRIMARY KEY (language_id);

ALTER TABLE mnu_language OWNER TO postgres;

REVOKE ALL ON TABLE mnu_language FROM PUBLIC;
REVOKE ALL ON TABLE mnu_language FROM postgres;
GRANT ALL ON TABLE mnu_language TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_language TO PUBLIC;

--
-- Name: mnu_menu; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_menu (
    menu_id character varying(80) NOT NULL,
    task_id_jnr character varying(80) NOT NULL,
    sort_seq smallint DEFAULT (0)::smallint NOT NULL,
    button_text character varying(40),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_menu ADD CONSTRAINT mnu_menu_pkey PRIMARY KEY (menu_id, task_id_jnr);

ALTER TABLE mnu_menu OWNER TO postgres;

REVOKE ALL ON TABLE mnu_menu FROM PUBLIC;
REVOKE ALL ON TABLE mnu_menu FROM postgres;
GRANT ALL ON TABLE mnu_menu TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_menu TO PUBLIC;

--
-- Name: mnu_motd; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_motd (
    motd_id integer NOT NULL,
    motd_subject character varying(80) NOT NULL,
    motd_message text NOT NULL,
    start_date date NOT NULL,
    end_date date DEFAULT '9999-12-31'::date,
    role_id character varying(16),
    created_date timestamp without time zone DEFAULT '2001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_motd ADD CONSTRAINT motd_id PRIMARY KEY (motd_id);

ALTER TABLE mnu_motd OWNER TO postgres;

REVOKE ALL ON TABLE mnu_motd FROM PUBLIC;
REVOKE ALL ON TABLE mnu_motd FROM postgres;
GRANT ALL ON TABLE mnu_motd TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_motd TO PUBLIC;

--
-- Name: mnu_motd_motd_id_seq; Type: SEQUENCE; Schema: menu; Owner: postgres
--

CREATE SEQUENCE mnu_motd_motd_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE mnu_motd_motd_id_seq OWNER TO postgres;
ALTER SEQUENCE mnu_motd_motd_id_seq OWNED BY mnu_motd.motd_id;
ALTER TABLE ONLY mnu_motd ALTER COLUMN motd_id SET DEFAULT nextval('mnu_motd_motd_id_seq'::regclass);

REVOKE ALL ON SEQUENCE mnu_motd_motd_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE mnu_motd_motd_id_seq FROM postgres;
GRANT ALL ON SEQUENCE mnu_motd_motd_id_seq TO postgres;
GRANT ALL ON SEQUENCE mnu_motd_motd_id_seq TO PUBLIC;

--
-- Name: mnu_nav_button; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_nav_button (
    task_id_snr character varying(80) NOT NULL,
    task_id_jnr character varying(80) NOT NULL,
    sort_seq smallint DEFAULT (0)::smallint NOT NULL,
    button_text character varying(40),
    context_preselect character(1),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_nav_button ADD CONSTRAINT mnu_nav_button_pkey PRIMARY KEY (task_id_snr, task_id_jnr);

ALTER TABLE mnu_nav_button OWNER TO postgres;

REVOKE ALL ON TABLE mnu_nav_button FROM PUBLIC;
REVOKE ALL ON TABLE mnu_nav_button FROM postgres;
GRANT ALL ON TABLE mnu_nav_button TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_nav_button TO PUBLIC;

--
-- Name: mnu_pattern; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_pattern (
    pattern_id character varying(16) NOT NULL,
    pattern_name character varying(80) NOT NULL,
    pattern_desc text,
    visible_screen character(1),
    context_preselect character(1),
    keep_data character(1),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_pattern ADD CONSTRAINT mnu_pattern_pkey PRIMARY KEY (pattern_id);

ALTER TABLE mnu_pattern OWNER TO postgres;

REVOKE ALL ON TABLE mnu_pattern FROM PUBLIC;
REVOKE ALL ON TABLE mnu_pattern FROM postgres;
GRANT ALL ON TABLE mnu_pattern TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_pattern TO PUBLIC;

--
-- Name: mnu_role; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_role (
    role_id character varying(16) NOT NULL,
    role_name character varying(80) NOT NULL,
    role_desc text,
    start_task_id character varying(80),
    global_access character(1) DEFAULT 'N'::bpchar,
    is_external_auth_off character(1) DEFAULT 'N'::bpchar NOT NULL,
    allow_responsive_gui character(1) DEFAULT 'N'::bpchar NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_role ADD CONSTRAINT mnu_role_pkey PRIMARY KEY (role_id);

ALTER TABLE mnu_role OWNER TO postgres;

REVOKE ALL ON TABLE mnu_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role FROM postgres;
GRANT ALL ON TABLE mnu_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role TO PUBLIC;

--
-- Name: mnu_role_task; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_role_task (
    role_id character varying(16) NOT NULL,
    task_id character varying(80) NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_role_task ADD CONSTRAINT mnu_role_task_pkey PRIMARY KEY (role_id, task_id);

ALTER TABLE mnu_role_task OWNER TO postgres;

REVOKE ALL ON TABLE mnu_role_task FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role_task FROM postgres;
GRANT ALL ON TABLE mnu_role_task TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role_task TO PUBLIC;

--
-- Name: mnu_role_taskfield; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_role_taskfield (
    role_id character varying(16) NOT NULL,
    task_id character varying(80) NOT NULL,
    field_id character varying(40) NOT NULL,
    access_type character varying(4),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_role_taskfield ADD CONSTRAINT mnu_role_taskfield_pkey PRIMARY KEY (role_id, task_id, field_id);
CREATE INDEX mnu_role_taskfield_index1 ON mnu_role_taskfield USING btree (task_id);

ALTER TABLE mnu_role_taskfield OWNER TO postgres;

REVOKE ALL ON TABLE mnu_role_taskfield FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role_taskfield FROM postgres;
GRANT ALL ON TABLE mnu_role_taskfield TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role_taskfield TO PUBLIC;

--
-- Name: mnu_saved_selection; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_saved_selection (
    selection_id integer NOT NULL,
    selection_name character varying(80) NOT NULL,
    user_id character varying(16) NOT NULL,
    task_id character varying(80) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_saved_selection ADD CONSTRAINT mnu_saved_selection_pkey PRIMARY KEY (selection_id);

ALTER TABLE mnu_saved_selection OWNER TO postgres;

REVOKE ALL ON TABLE mnu_saved_selection FROM PUBLIC;
REVOKE ALL ON TABLE mnu_saved_selection FROM postgres;
GRANT ALL ON TABLE mnu_saved_selection TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_saved_selection TO PUBLIC;

CREATE SEQUENCE mnu_saved_selection_selection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE mnu_saved_selection_selection_id_seq OWNER TO postgres;
ALTER SEQUENCE mnu_saved_selection_selection_id_seq OWNED BY mnu_saved_selection.selection_id;
ALTER TABLE ONLY mnu_saved_selection ALTER COLUMN selection_id SET DEFAULT nextval('mnu_saved_selection_selection_id_seq'::regclass);

REVOKE ALL ON SEQUENCE mnu_saved_selection_selection_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE mnu_saved_selection_selection_id_seq FROM postgres;
GRANT ALL ON SEQUENCE mnu_saved_selection_selection_id_seq TO postgres;
GRANT ALL ON SEQUENCE mnu_saved_selection_selection_id_seq TO PUBLIC;

--
-- Name: mnu_saved_selection_data; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_saved_selection_data (
    selection_id integer NOT NULL,
    fieldname character varying(80) NOT NULL,
    fieldvalue character varying(80),
    sort_seq smallint,
    output_name character varying(80),
    created_date timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_saved_selection_data ADD CONSTRAINT mnu_saved_selection_data_pkey PRIMARY KEY (selection_id, fieldname);

ALTER TABLE mnu_saved_selection_data OWNER TO postgres;

REVOKE ALL ON TABLE mnu_saved_selection_data FROM PUBLIC;
REVOKE ALL ON TABLE mnu_saved_selection_data FROM postgres;
GRANT ALL ON TABLE mnu_saved_selection_data TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_saved_selection_data TO PUBLIC;

--
-- Name: mnu_subsystem; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_subsystem (
    subsys_id character varying(16) NOT NULL,
    subsys_name character varying(80) NOT NULL,
    subsys_desc text,
    subsys_dir character varying(255) NOT NULL,
    task_prefix character varying(8),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_subsystem ADD CONSTRAINT mnu_subsystem_pkey PRIMARY KEY (subsys_id);

ALTER TABLE mnu_subsystem OWNER TO postgres;

REVOKE ALL ON TABLE mnu_subsystem FROM PUBLIC;
REVOKE ALL ON TABLE mnu_subsystem FROM postgres;
GRANT ALL ON TABLE mnu_subsystem TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_subsystem TO PUBLIC;

--
-- Name: mnu_task; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_task (
    task_id character varying(80) NOT NULL,
    task_name character varying(80) NOT NULL,
    task_desc text,
    button_text character varying(80),
    task_type character varying(4),
    script_id character varying(80),
    is_disabled character(1),
    pattern_id character varying(16),
    subsys_id character varying(16),
    initial_passthru character varying(80),
    selection_fixed character varying(255),
    selection_temp character varying(255),
    settings character varying(40),
    order_by character varying(255),
    keep_data character(1),
    log_sql_query character(1),
    screen_refresh smallint,
    use_https character(1),
    max_execution_time smallint,
    task_id_run_at_end character varying(80),
    task_id_run_at_cancel character varying(80),
    allow_responsive_gui character(1) DEFAULT 'N'::bpchar NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_task ADD CONSTRAINT mnu_task_pkey PRIMARY KEY (task_id);
CREATE INDEX mnu_task_index1 ON mnu_task USING btree (pattern_id);
CREATE INDEX mnu_task_index2 ON mnu_task USING btree (subsys_id);

ALTER TABLE mnu_task OWNER TO postgres;

REVOKE ALL ON TABLE mnu_task FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task FROM postgres;
GRANT ALL ON TABLE mnu_task TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task TO PUBLIC;

--
-- Name: mnu_task_alt; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_task_alt (
    task_id character varying(80) NOT NULL,
    language_id character varying(5) NOT NULL,
    task_name character varying(80) NOT NULL,
    task_desc text NOT NULL,
    button_text character varying(40) NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_task_alt ADD CONSTRAINT mnu_task_alt_pkey PRIMARY KEY (task_id, language_id);

ALTER TABLE mnu_task_alt OWNER TO postgres;

REVOKE ALL ON TABLE mnu_task_alt FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_alt FROM postgres;
GRANT ALL ON TABLE mnu_task_alt TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_alt TO PUBLIC;

--
-- Name: mnu_task_field; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_task_field (
    task_id character varying(80) NOT NULL,
    field_id character varying(40) NOT NULL,
    field_desc character varying(255),
    is_documentation_only character(1) DEFAULT 'N'::bpchar NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_task_field ADD CONSTRAINT mnu_task_field_pkey PRIMARY KEY (task_id, field_id);

ALTER TABLE mnu_task_field OWNER TO postgres;
REVOKE ALL ON TABLE mnu_task_field FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_field FROM postgres;
GRANT ALL ON TABLE mnu_task_field TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_field TO PUBLIC;

--
-- Name: mnu_task_ip_address; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_task_ip_address (
    task_id character varying(80) NOT NULL,
    ip_address character varying(40) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_task_ip_address ADD CONSTRAINT mnu_task_ip_address_pkey PRIMARY KEY (task_id, ip_address);

ALTER TABLE mnu_task_ip_address OWNER TO postgres;

REVOKE ALL ON TABLE mnu_task_ip_address FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_ip_address FROM postgres;
GRANT ALL ON TABLE mnu_task_ip_address TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_ip_address TO PUBLIC;

--
-- Name: mnu_task_quicksearch; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_task_quicksearch (
    task_id character varying(80) NOT NULL,
    field_id character varying(80) NOT NULL,
    sort_seq smallint DEFAULT (0)::smallint NOT NULL,
    field_name character varying(40) NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_task_quicksearch ADD CONSTRAINT mnu_task_quicksearch_pkey PRIMARY KEY (task_id, field_id);

ALTER TABLE mnu_task_quicksearch OWNER TO postgres;

REVOKE ALL ON TABLE mnu_task_quicksearch FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_quicksearch FROM postgres;
GRANT ALL ON TABLE mnu_task_quicksearch TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_quicksearch TO PUBLIC;

--
-- Name: mnu_task_quicksearch_alt; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_task_quicksearch_alt (
    task_id character varying(80) NOT NULL,
    field_id character varying(80) NOT NULL,
    language_id character varying(5) NOT NULL,
    field_name character varying(40) NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_task_quicksearch_alt ADD CONSTRAINT mnu_task_quicksearch_alt_pkey PRIMARY KEY (task_id, field_id, language_id);

ALTER TABLE mnu_task_quicksearch_alt OWNER TO postgres;

REVOKE ALL ON TABLE mnu_task_quicksearch_alt FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_quicksearch_alt FROM postgres;
GRANT ALL ON TABLE mnu_task_quicksearch_alt TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_quicksearch_alt TO PUBLIC;

--
-- Name: mnu_time_limit_role; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_time_limit_role (
    role_id character varying(16) NOT NULL,
    seq_no smallint NOT NULL,
    scheduled_start_time time without time zone,
    scheduled_end_time time without time zone,
    scheduled_monday boolean DEFAULT true NOT NULL,
    scheduled_tuesday boolean DEFAULT true NOT NULL,
    scheduled_wednesday boolean DEFAULT true NOT NULL,
    scheduled_thursday boolean DEFAULT true NOT NULL,
    scheduled_friday boolean DEFAULT true NOT NULL,
    scheduled_saturday boolean DEFAULT true NOT NULL,
    scheduled_sunday boolean DEFAULT true NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_time_limit_role ADD CONSTRAINT mnu_time_limit_role_pkey PRIMARY KEY (role_id, seq_no);

ALTER TABLE mnu_time_limit_role OWNER TO postgres;

REVOKE ALL ON TABLE mnu_time_limit_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_time_limit_role FROM postgres;
GRANT ALL ON TABLE mnu_time_limit_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_time_limit_role TO PUBLIC;

--
-- Name: mnu_time_limit_user; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_time_limit_user (
    user_id character varying(16) NOT NULL,
    seq_no smallint NOT NULL,
    scheduled_start_time time without time zone,
    scheduled_end_time time without time zone,
    scheduled_monday boolean DEFAULT true NOT NULL,
    scheduled_tuesday boolean DEFAULT true NOT NULL,
    scheduled_wednesday boolean DEFAULT true NOT NULL,
    scheduled_thursday boolean DEFAULT true NOT NULL,
    scheduled_friday boolean DEFAULT true NOT NULL,
    scheduled_saturday boolean DEFAULT true NOT NULL,
    scheduled_sunday boolean DEFAULT true NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_time_limit_user ADD CONSTRAINT mnu_time_limit_user_pkey PRIMARY KEY (user_id, seq_no);

ALTER TABLE mnu_time_limit_user OWNER TO postgres;

REVOKE ALL ON TABLE mnu_time_limit_user FROM PUBLIC;
REVOKE ALL ON TABLE mnu_time_limit_user FROM postgres;
GRANT ALL ON TABLE mnu_time_limit_user TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_time_limit_user TO PUBLIC;

--
-- Name: mnu_todo; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_todo (
    user_id character varying(16) NOT NULL,
    seq_no smallint DEFAULT (0)::smallint NOT NULL,
    item_name character varying(80) NOT NULL,
    item_desc text,
    due_date date DEFAULT '2000-01-01'::date NOT NULL,
    is_complete character(1) DEFAULT 'N'::bpchar NOT NULL,
    visibility smallint NOT NULL,
    repeat_interval numeric(3,0),
    repeat_unit character(1),
    task_id character varying(80),
    task_context character varying(255),
    object_id character varying(255),
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_todo ADD CONSTRAINT mnu_todo_pkey PRIMARY KEY (user_id, seq_no);

ALTER TABLE mnu_todo OWNER TO postgres;

REVOKE ALL ON TABLE mnu_todo FROM PUBLIC;
REVOKE ALL ON TABLE mnu_todo FROM postgres;
GRANT ALL ON TABLE mnu_todo TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_todo TO PUBLIC;

--
-- Name: mnu_user; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_user (
    user_id character varying(16) NOT NULL,
    user_name character varying(40) NOT NULL,
    user_password character varying(16) NOT NULL,
    pswd_change_datetime timestamp without time zone,
    pswd_count smallint,
    force_pswd_chg character(1) DEFAULT 'N'::bpchar NOT NULL,
    in_use character(1) DEFAULT 'N'::bpchar NOT NULL,
    is_disabled character(1) DEFAULT 'N'::bpchar NOT NULL,
    logon_datetime timestamp without time zone,
    language_id character varying(6),
    start_date date DEFAULT '2000-01-01'::date NOT NULL,
    end_date date DEFAULT '9999-12-31'::date,
    ip_address character varying(40),
    email_addr character varying(50),
    rdcaccount_id integer,
    external_id character varying(255),
    is_external_auth_off character(1) DEFAULT 'N'::bpchar,
    party_id integer,
    user_timezone character varying(40),
    allow_responsive_gui character(1) DEFAULT 'N'::bpchar NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_user ADD CONSTRAINT mnu_user_pkey PRIMARY KEY (user_id);
ALTER TABLE ONLY mnu_user ADD CONSTRAINT mnu_user_email_addr_key UNIQUE (email_addr);
CREATE INDEX mnu_user_index2 ON mnu_user USING btree (rdcaccount_id);
CREATE INDEX mnu_user_index3 ON mnu_user USING btree (party_id);

ALTER TABLE mnu_user OWNER TO postgres;

REVOKE ALL ON TABLE mnu_user FROM PUBLIC;
REVOKE ALL ON TABLE mnu_user FROM postgres;
GRANT ALL ON TABLE mnu_user TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_user TO PUBLIC;

--
-- Name: mnu_user_alt; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_user_alt (
    user_id character varying(16) NOT NULL,
    language_id character varying(5) NOT NULL,
    user_name character varying(40) NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_user_alt ADD CONSTRAINT mnu_user_alt_pkey PRIMARY KEY (user_id, language_id);

ALTER TABLE mnu_user_alt OWNER TO postgres;

REVOKE ALL ON TABLE mnu_user_alt FROM PUBLIC;
REVOKE ALL ON TABLE mnu_user_alt FROM postgres;
GRANT ALL ON TABLE mnu_user_alt TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_user_alt TO PUBLIC;

--
-- Name: mnu_user_ip_address; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_user_ip_address (
    user_id character varying(16) NOT NULL,
    ip_address character varying(40) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_user_ip_address ADD CONSTRAINT mnu_user_ip_address_pkey PRIMARY KEY (user_id, ip_address);

ALTER TABLE mnu_user_ip_address OWNER TO postgres;

REVOKE ALL ON TABLE mnu_user_ip_address FROM PUBLIC;
REVOKE ALL ON TABLE mnu_user_ip_address FROM postgres;
GRANT ALL ON TABLE mnu_user_ip_address TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_user_ip_address TO PUBLIC;

--
-- Name: mnu_user_role; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_user_role (
    user_id character varying(16) NOT NULL,
    role_id character varying(16) NOT NULL,
    sort_seq integer NOT NULL,
    start_date date NOT NULL DEFAULT '2000-01-01'::date,
    end_date date DEFAULT '9999-12-31'::date,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);
ALTER TABLE ONLY mnu_user_role ADD CONSTRAINT mnu_user_role_pkey PRIMARY KEY (user_id, role_id);

ALTER TABLE mnu_user_role OWNER TO postgres;

REVOKE ALL ON TABLE mnu_user_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_user_role FROM postgres;
GRANT ALL ON TABLE mnu_user_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_user_role TO PUBLIC;

--
-- Name: menu; Type: SCHEMA; Owner: postgres
-- 

REVOKE ALL ON SCHEMA menu FROM PUBLIC;
REVOKE ALL ON SCHEMA menu FROM postgres;
GRANT ALL ON SCHEMA menu TO postgres;
GRANT USAGE ON SCHEMA menu TO PUBLIC;

-- Completed on 2016-05-19 11:03:25

--
-- PostgreSQL database dump complete
--
