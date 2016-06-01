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
-- TOC entry 9 (class 2615 OID 16422)
-- Name: menu; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA menu;


ALTER SCHEMA menu OWNER TO postgres;

SET search_path = menu, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 200 (class 1259 OID 16583)
-- Name: help_text; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE help_text (
    task_id character varying(80) DEFAULT ''::character varying NOT NULL,
    help_text text,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE help_text OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16592)
-- Name: help_text_alt; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE help_text_alt (
    task_id character varying(80) DEFAULT ''::character varying NOT NULL,
    language_id character varying(5) DEFAULT ''::character varying NOT NULL,
    help_text text,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE help_text_alt OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16602)
-- Name: mnu_account_rdcaccount_id_seq; Type: SEQUENCE; Schema: menu; Owner: postgres
--

CREATE SEQUENCE mnu_account_rdcaccount_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mnu_account_rdcaccount_id_seq OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16604)
-- Name: mnu_account; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_account (
    rdcaccount_id integer DEFAULT nextval('mnu_account_rdcaccount_id_seq'::regclass) NOT NULL,
    account_name character varying(255) NOT NULL,
    rdcversion integer DEFAULT 1 NOT NULL,
    created_date timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_account OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16610)
-- Name: mnu_control; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_control (
    record_id character varying(16) DEFAULT ''::character varying NOT NULL,
    field_id character varying(32) DEFAULT ''::character varying NOT NULL,
    field_value character varying(255),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_control OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16617)
-- Name: mnu_favourite; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_favourite (
    user_id character varying(16) DEFAULT ''::character varying NOT NULL,
    seq_no smallint DEFAULT (0)::smallint NOT NULL,
    task_id character varying(80) DEFAULT ''::character varying NOT NULL,
    task_desc character varying(80) DEFAULT ''::character varying NOT NULL,
    sort_seq smallint DEFAULT (0)::smallint NOT NULL,
    breadcrumbs character varying(4000),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_favourite OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16630)
-- Name: mnu_initial_value_role; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_initial_value_role (
    role_id character varying(16) DEFAULT ''::character varying NOT NULL,
    task_id character varying(80) DEFAULT ''::character varying NOT NULL,
    field_id character varying(40) DEFAULT ''::character varying NOT NULL,
    initial_value character varying(40),
    is_noedit character(1) DEFAULT 'N'::bpchar,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_initial_value_role OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16639)
-- Name: mnu_initial_value_user; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_initial_value_user (
    user_id character varying(16) DEFAULT ''::character varying NOT NULL,
    task_id character varying(80) DEFAULT ''::character varying NOT NULL,
    field_id character varying(40) DEFAULT ''::character varying NOT NULL,
    initial_value character varying(40),
    is_noedit character(1) DEFAULT 'N'::bpchar,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_initial_value_user OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16648)
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


ALTER TABLE mnu_language OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16655)
-- Name: mnu_menu; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_menu (
    menu_id character varying(80) DEFAULT ''::character varying NOT NULL,
    task_id_jnr character varying(80) DEFAULT ''::character varying NOT NULL,
    sort_seq smallint DEFAULT (0)::smallint NOT NULL,
    button_text character varying(40),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_menu OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16663)
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


ALTER TABLE mnu_motd OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16672)
-- Name: mnu_motd_motd_id_seq; Type: SEQUENCE; Schema: menu; Owner: postgres
--

CREATE SEQUENCE mnu_motd_motd_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mnu_motd_motd_id_seq OWNER TO postgres;

--
-- TOC entry 2645 (class 0 OID 0)
-- Dependencies: 211
-- Name: mnu_motd_motd_id_seq; Type: SEQUENCE OWNED BY; Schema: menu; Owner: postgres
--

ALTER SEQUENCE mnu_motd_motd_id_seq OWNED BY mnu_motd.motd_id;


--
-- TOC entry 212 (class 1259 OID 16674)
-- Name: mnu_nav_button; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_nav_button (
    task_id_snr character varying(80) DEFAULT ''::character varying NOT NULL,
    task_id_jnr character varying(80) DEFAULT ''::character varying NOT NULL,
    sort_seq smallint DEFAULT (0)::smallint NOT NULL,
    button_text character varying(40),
    context_preselect character(1),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_nav_button OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16682)
-- Name: mnu_pattern; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_pattern (
    pattern_id character varying(16) DEFAULT ''::character varying NOT NULL,
    pattern_desc character varying(60) DEFAULT ''::character varying NOT NULL,
    pattern_long_desc text,
    visible_screen character(1),
    context_preselect character(1),
    keep_data character(1),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_pattern OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16692)
-- Name: mnu_role; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_role (
    role_id character varying(16) DEFAULT ''::character varying NOT NULL,
    role_desc character varying(30) DEFAULT ''::character varying NOT NULL,
    start_task_id character varying(80),
    global_access character(1) DEFAULT 'N'::bpchar,
    is_external_auth_off character(1) DEFAULT 'N'::bpchar,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_role OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16701)
-- Name: mnu_role_task; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_role_task (
    role_id character varying(16) DEFAULT ''::character varying NOT NULL,
    task_id character varying(80) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_role_task OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16708)
-- Name: mnu_role_taskfield; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_role_taskfield (
    role_id character varying(16) DEFAULT ''::character varying NOT NULL,
    task_id character varying(80) DEFAULT ''::character varying NOT NULL,
    field_id character varying(40) DEFAULT ''::character varying NOT NULL,
    access_type character varying(4),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_role_taskfield OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 17458)
-- Name: mnu_saved_selection; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_saved_selection (
    selection_id integer NOT NULL,
    selection_desc character varying(80) NOT NULL,
    user_id character varying(16) NOT NULL,
    task_id character varying(80) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_saved_selection OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 17465)
-- Name: mnu_saved_selection_data; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_saved_selection_data (
    selection_id integer NOT NULL,
    fieldname character varying(80) NOT NULL,
    fieldvalue character varying(80) DEFAULT NULL::character varying,
    created_date timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_saved_selection_data OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 17456)
-- Name: mnu_saved_selection_selection_id_seq; Type: SEQUENCE; Schema: menu; Owner: postgres
--

CREATE SEQUENCE mnu_saved_selection_selection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mnu_saved_selection_selection_id_seq OWNER TO postgres;

--
-- TOC entry 2654 (class 0 OID 0)
-- Dependencies: 251
-- Name: mnu_saved_selection_selection_id_seq; Type: SEQUENCE OWNED BY; Schema: menu; Owner: postgres
--

ALTER SEQUENCE mnu_saved_selection_selection_id_seq OWNED BY mnu_saved_selection.selection_id;


--
-- TOC entry 217 (class 1259 OID 16716)
-- Name: mnu_subsystem; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_subsystem (
    subsys_id character varying(16) DEFAULT ''::character varying NOT NULL,
    subsys_desc character varying(255) DEFAULT ''::character varying NOT NULL,
    subsys_dir character varying(255),
    task_prefix character varying(8),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_subsystem OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16726)
-- Name: mnu_task; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_task (
    task_id character varying(80) DEFAULT ''::character varying NOT NULL,
    task_desc character varying(80) DEFAULT ''::character varying NOT NULL,
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
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_task OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16736)
-- Name: mnu_task_alt; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_task_alt (
    task_id character varying(80) DEFAULT ''::character varying NOT NULL,
    language_id character varying(5) DEFAULT ''::character varying NOT NULL,
    task_desc character varying(80) DEFAULT ''::character varying NOT NULL,
    button_text character varying(80) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_task_alt OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16745)
-- Name: mnu_task_field; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_task_field (
    task_id character varying(80) DEFAULT ''::character varying NOT NULL,
    field_id character varying(40) DEFAULT ''::character varying NOT NULL,
    field_desc character varying(255),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16),
    is_documentation_only character(1) DEFAULT 'N'::bpchar NOT NULL
);


ALTER TABLE mnu_task_field OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16752)
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


ALTER TABLE mnu_task_ip_address OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 17581)
-- Name: mnu_task_quicksearch; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_task_quicksearch (
    task_id character varying(80) NOT NULL,
    field_id character varying(40) NOT NULL,
    sort_seq smallint DEFAULT (0)::smallint NOT NULL,
    field_name character varying(40) NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_task_quicksearch OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 17589)
-- Name: mnu_task_quicksearch_alt; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_task_quicksearch_alt (
    task_id character varying(80) NOT NULL,
    field_id character varying(40) NOT NULL,
    language_id character varying(5) DEFAULT ''::character varying NOT NULL,
    field_name character varying(40) NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_task_quicksearch_alt OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16756)
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


ALTER TABLE mnu_time_limit_role OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16768)
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


ALTER TABLE mnu_time_limit_user OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16780)
-- Name: mnu_todo; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_todo (
    user_id character varying(16) DEFAULT ''::character varying NOT NULL,
    seq_no smallint DEFAULT (0)::smallint NOT NULL,
    item_desc character varying(80) DEFAULT ''::character varying NOT NULL,
    item_notes text,
    due_date date DEFAULT '2000-01-01'::date NOT NULL,
    is_complete character(1) DEFAULT 'N'::bpchar NOT NULL,
    visibility smallint NOT NULL,
    repeat_interval numeric(3,0),
    repeat_unit character(1),
    task_id character varying(80),
    task_context character varying(255),
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_todo OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16793)
-- Name: mnu_user; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_user (
    user_id character varying(16) DEFAULT ''::character varying NOT NULL,
    user_name character varying(30) DEFAULT ''::character varying NOT NULL,
    user_password character varying(16) DEFAULT ''::character varying NOT NULL,
    pswd_chg_date date,
    pswd_chg_time time without time zone,
    pswd_count smallint,
    in_use character(1) DEFAULT 'N'::bpchar NOT NULL,
    is_disabled character(1) DEFAULT 'N'::bpchar NOT NULL,
    logon_date date,
    logon_time time without time zone,
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
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE mnu_user OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16809)
-- Name: mnu_user_alt; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_user_alt (
    user_id character varying(16) DEFAULT ''::character varying NOT NULL,
    language_id character varying(5) DEFAULT ''::character varying NOT NULL,
    user_name character varying(30) DEFAULT NULL::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE mnu_user_alt OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16818)
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


ALTER TABLE mnu_user_ip_address OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16822)
-- Name: mnu_user_role; Type: TABLE; Schema: menu; Owner: postgres
--

CREATE TABLE mnu_user_role (
    user_id character varying(16) DEFAULT ''::character varying NOT NULL,
    role_id character varying(16) DEFAULT ''::character varying NOT NULL,
    is_primary character(1) DEFAULT 'N'::bpchar,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE mnu_user_role OWNER TO postgres;

--
-- TOC entry 2338 (class 2604 OID 16790)
-- Name: motd_id; Type: DEFAULT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_motd ALTER COLUMN motd_id SET DEFAULT nextval('mnu_motd_motd_id_seq'::regclass);


--
-- TOC entry 2434 (class 2604 OID 16791)
-- Name: selection_id; Type: DEFAULT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_saved_selection ALTER COLUMN selection_id SET DEFAULT nextval('mnu_saved_selection_selection_id_seq'::regclass);


--
-- TOC entry 2447 (class 2606 OID 16805)
-- Name: help_text_alt_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY help_text_alt
    ADD CONSTRAINT help_text_alt_pkey PRIMARY KEY (task_id, language_id);


--
-- TOC entry 2445 (class 2606 OID 16806)
-- Name: help_text_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY help_text
    ADD CONSTRAINT help_text_pkey PRIMARY KEY (task_id);


--
-- TOC entry 2449 (class 2606 OID 16807)
-- Name: mnu_account_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_account
    ADD CONSTRAINT mnu_account_pkey PRIMARY KEY (rdcaccount_id);


--
-- TOC entry 2451 (class 2606 OID 16808)
-- Name: mnu_control_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_control
    ADD CONSTRAINT mnu_control_pkey PRIMARY KEY (record_id, field_id);


--
-- TOC entry 2453 (class 2606 OID 16809)
-- Name: mnu_favourite_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_favourite
    ADD CONSTRAINT mnu_favourite_pkey PRIMARY KEY (user_id, seq_no);


--
-- TOC entry 2457 (class 2606 OID 16810)
-- Name: mnu_initial_value_role_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_initial_value_role
    ADD CONSTRAINT mnu_initial_value_role_pkey PRIMARY KEY (role_id, task_id, field_id);


--
-- TOC entry 2460 (class 2606 OID 16811)
-- Name: mnu_initial_value_user_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_initial_value_user
    ADD CONSTRAINT mnu_initial_value_user_pkey PRIMARY KEY (user_id, task_id, field_id);


--
-- TOC entry 2462 (class 2606 OID 16812)
-- Name: mnu_language_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_language
    ADD CONSTRAINT mnu_language_pkey PRIMARY KEY (language_id);


--
-- TOC entry 2464 (class 2606 OID 16813)
-- Name: mnu_menu_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_menu
    ADD CONSTRAINT mnu_menu_pkey PRIMARY KEY (menu_id, task_id_jnr);


--
-- TOC entry 2468 (class 2606 OID 16814)
-- Name: mnu_nav_button_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_nav_button
    ADD CONSTRAINT mnu_nav_button_pkey PRIMARY KEY (task_id_snr, task_id_jnr);


--
-- TOC entry 2470 (class 2606 OID 16815)
-- Name: mnu_pattern_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_pattern
    ADD CONSTRAINT mnu_pattern_pkey PRIMARY KEY (pattern_id);


--
-- TOC entry 2472 (class 2606 OID 16816)
-- Name: mnu_role_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_role
    ADD CONSTRAINT mnu_role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 2474 (class 2606 OID 16817)
-- Name: mnu_role_task_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_role_task
    ADD CONSTRAINT mnu_role_task_pkey PRIMARY KEY (role_id, task_id);


--
-- TOC entry 2477 (class 2606 OID 16818)
-- Name: mnu_role_taskfield_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_role_taskfield
    ADD CONSTRAINT mnu_role_taskfield_pkey PRIMARY KEY (role_id, task_id, field_id);


--
-- TOC entry 2510 (class 2606 OID 16819)
-- Name: mnu_saved_selection_data_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_saved_selection_data
    ADD CONSTRAINT mnu_saved_selection_data_pkey PRIMARY KEY (selection_id, fieldname);


--
-- TOC entry 2508 (class 2606 OID 16820)
-- Name: mnu_saved_selection_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_saved_selection
    ADD CONSTRAINT mnu_saved_selection_pkey PRIMARY KEY (selection_id);


--
-- TOC entry 2479 (class 2606 OID 16821)
-- Name: mnu_subsystem_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_subsystem
    ADD CONSTRAINT mnu_subsystem_pkey PRIMARY KEY (subsys_id);


--
-- TOC entry 2485 (class 2606 OID 16822)
-- Name: mnu_task_alt_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_task_alt
    ADD CONSTRAINT mnu_task_alt_pkey PRIMARY KEY (task_id, language_id);


--
-- TOC entry 2487 (class 2606 OID 16823)
-- Name: mnu_task_field_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_task_field
    ADD CONSTRAINT mnu_task_field_pkey PRIMARY KEY (task_id, field_id);


--
-- TOC entry 2489 (class 2606 OID 16824)
-- Name: mnu_task_ip_address_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_task_ip_address
    ADD CONSTRAINT mnu_task_ip_address_pkey PRIMARY KEY (task_id, ip_address);


--
-- TOC entry 2483 (class 2606 OID 16825)
-- Name: mnu_task_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_task
    ADD CONSTRAINT mnu_task_pkey PRIMARY KEY (task_id);


--
-- TOC entry 2514 (class 2606 OID 17596)
-- Name: mnu_task_quicksearch_alt_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_task_quicksearch_alt
    ADD CONSTRAINT mnu_task_quicksearch_alt_pkey PRIMARY KEY (task_id, field_id, language_id);


--
-- TOC entry 2512 (class 2606 OID 17588)
-- Name: mnu_task_quicksearch_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_task_quicksearch
    ADD CONSTRAINT mnu_task_quicksearch_pkey PRIMARY KEY (task_id, field_id);


--
-- TOC entry 2491 (class 2606 OID 16826)
-- Name: mnu_time_limit_role_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_time_limit_role
    ADD CONSTRAINT mnu_time_limit_role_pkey PRIMARY KEY (role_id, seq_no);


--
-- TOC entry 2493 (class 2606 OID 16827)
-- Name: mnu_time_limit_user_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_time_limit_user
    ADD CONSTRAINT mnu_time_limit_user_pkey PRIMARY KEY (user_id, seq_no);


--
-- TOC entry 2495 (class 2606 OID 16828)
-- Name: mnu_todo_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_todo
    ADD CONSTRAINT mnu_todo_pkey PRIMARY KEY (user_id, seq_no);


--
-- TOC entry 2502 (class 2606 OID 16829)
-- Name: mnu_user_alt_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_user_alt
    ADD CONSTRAINT mnu_user_alt_pkey PRIMARY KEY (user_id, language_id);


--
-- TOC entry 2497 (class 2606 OID 16830)
-- Name: mnu_user_email_addr_key; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_user
    ADD CONSTRAINT mnu_user_email_addr_key UNIQUE (email_addr);


--
-- TOC entry 2504 (class 2606 OID 16831)
-- Name: mnu_user_ip_address_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_user_ip_address
    ADD CONSTRAINT mnu_user_ip_address_pkey PRIMARY KEY (user_id, ip_address);


--
-- TOC entry 2500 (class 2606 OID 16832)
-- Name: mnu_user_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_user
    ADD CONSTRAINT mnu_user_pkey PRIMARY KEY (user_id);


--
-- TOC entry 2506 (class 2606 OID 16833)
-- Name: mnu_user_role_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_user_role
    ADD CONSTRAINT mnu_user_role_pkey PRIMARY KEY (user_id, role_id);


--
-- TOC entry 2466 (class 2606 OID 16834)
-- Name: motd_id; Type: CONSTRAINT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_motd
    ADD CONSTRAINT motd_id PRIMARY KEY (motd_id);


--
-- TOC entry 2455 (class 1259 OID 17140)
-- Name: mnu_initial_value_role_index1; Type: INDEX; Schema: menu; Owner: postgres
--

CREATE INDEX mnu_initial_value_role_index1 ON mnu_initial_value_role USING btree (task_id);


--
-- TOC entry 2458 (class 1259 OID 17141)
-- Name: mnu_initial_value_user_index1; Type: INDEX; Schema: menu; Owner: postgres
--

CREATE INDEX mnu_initial_value_user_index1 ON mnu_initial_value_user USING btree (task_id);


--
-- TOC entry 2475 (class 1259 OID 17142)
-- Name: mnu_role_taskfield_index1; Type: INDEX; Schema: menu; Owner: postgres
--

CREATE INDEX mnu_role_taskfield_index1 ON mnu_role_taskfield USING btree (task_id);


--
-- TOC entry 2480 (class 1259 OID 17143)
-- Name: mnu_task_index1; Type: INDEX; Schema: menu; Owner: postgres
--

CREATE INDEX mnu_task_index1 ON mnu_task USING btree (pattern_id);


--
-- TOC entry 2481 (class 1259 OID 17144)
-- Name: mnu_task_index2; Type: INDEX; Schema: menu; Owner: postgres
--

CREATE INDEX mnu_task_index2 ON mnu_task USING btree (subsys_id);


--
-- TOC entry 2498 (class 1259 OID 17145)
-- Name: mnu_user_index2; Type: INDEX; Schema: menu; Owner: postgres
--

CREATE INDEX mnu_user_index2 ON mnu_user USING btree (rdcaccount_id);


--
-- TOC entry 2454 (class 1259 OID 17146)
-- Name: user_id_task_id; Type: INDEX; Schema: menu; Owner: postgres
--

CREATE UNIQUE INDEX user_id_task_id ON mnu_favourite USING btree (user_id, task_id);


--
-- TOC entry 2633 (class 0 OID 0)
-- Dependencies: 9
-- Name: menu; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA menu FROM PUBLIC;
REVOKE ALL ON SCHEMA menu FROM postgres;
GRANT ALL ON SCHEMA menu TO postgres;
GRANT USAGE ON SCHEMA menu TO PUBLIC;


--
-- TOC entry 2634 (class 0 OID 0)
-- Dependencies: 200
-- Name: help_text; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE help_text FROM PUBLIC;
REVOKE ALL ON TABLE help_text FROM postgres;
GRANT ALL ON TABLE help_text TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE help_text TO PUBLIC;


--
-- TOC entry 2635 (class 0 OID 0)
-- Dependencies: 201
-- Name: help_text_alt; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE help_text_alt FROM PUBLIC;
REVOKE ALL ON TABLE help_text_alt FROM postgres;
GRANT ALL ON TABLE help_text_alt TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE help_text_alt TO PUBLIC;


--
-- TOC entry 2636 (class 0 OID 0)
-- Dependencies: 202
-- Name: mnu_account_rdcaccount_id_seq; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON SEQUENCE mnu_account_rdcaccount_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE mnu_account_rdcaccount_id_seq FROM postgres;
GRANT ALL ON SEQUENCE mnu_account_rdcaccount_id_seq TO postgres;
GRANT ALL ON SEQUENCE mnu_account_rdcaccount_id_seq TO PUBLIC;


--
-- TOC entry 2637 (class 0 OID 0)
-- Dependencies: 203
-- Name: mnu_account; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_account FROM PUBLIC;
REVOKE ALL ON TABLE mnu_account FROM postgres;
GRANT ALL ON TABLE mnu_account TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_account TO PUBLIC;


--
-- TOC entry 2638 (class 0 OID 0)
-- Dependencies: 204
-- Name: mnu_control; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_control FROM PUBLIC;
REVOKE ALL ON TABLE mnu_control FROM postgres;
GRANT ALL ON TABLE mnu_control TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_control TO PUBLIC;


--
-- TOC entry 2639 (class 0 OID 0)
-- Dependencies: 205
-- Name: mnu_favourite; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_favourite FROM PUBLIC;
REVOKE ALL ON TABLE mnu_favourite FROM postgres;
GRANT ALL ON TABLE mnu_favourite TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_favourite TO PUBLIC;


--
-- TOC entry 2640 (class 0 OID 0)
-- Dependencies: 206
-- Name: mnu_initial_value_role; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_initial_value_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_initial_value_role FROM postgres;
GRANT ALL ON TABLE mnu_initial_value_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_initial_value_role TO PUBLIC;


--
-- TOC entry 2641 (class 0 OID 0)
-- Dependencies: 207
-- Name: mnu_initial_value_user; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_initial_value_user FROM PUBLIC;
REVOKE ALL ON TABLE mnu_initial_value_user FROM postgres;
GRANT ALL ON TABLE mnu_initial_value_user TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_initial_value_user TO PUBLIC;


--
-- TOC entry 2642 (class 0 OID 0)
-- Dependencies: 208
-- Name: mnu_language; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_language FROM PUBLIC;
REVOKE ALL ON TABLE mnu_language FROM postgres;
GRANT ALL ON TABLE mnu_language TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_language TO PUBLIC;


--
-- TOC entry 2643 (class 0 OID 0)
-- Dependencies: 209
-- Name: mnu_menu; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_menu FROM PUBLIC;
REVOKE ALL ON TABLE mnu_menu FROM postgres;
GRANT ALL ON TABLE mnu_menu TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_menu TO PUBLIC;


--
-- TOC entry 2644 (class 0 OID 0)
-- Dependencies: 210
-- Name: mnu_motd; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_motd FROM PUBLIC;
REVOKE ALL ON TABLE mnu_motd FROM postgres;
GRANT ALL ON TABLE mnu_motd TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_motd TO PUBLIC;


--
-- TOC entry 2646 (class 0 OID 0)
-- Dependencies: 211
-- Name: mnu_motd_motd_id_seq; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON SEQUENCE mnu_motd_motd_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE mnu_motd_motd_id_seq FROM postgres;
GRANT ALL ON SEQUENCE mnu_motd_motd_id_seq TO postgres;
GRANT ALL ON SEQUENCE mnu_motd_motd_id_seq TO PUBLIC;


--
-- TOC entry 2647 (class 0 OID 0)
-- Dependencies: 212
-- Name: mnu_nav_button; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_nav_button FROM PUBLIC;
REVOKE ALL ON TABLE mnu_nav_button FROM postgres;
GRANT ALL ON TABLE mnu_nav_button TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_nav_button TO PUBLIC;


--
-- TOC entry 2648 (class 0 OID 0)
-- Dependencies: 213
-- Name: mnu_pattern; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_pattern FROM PUBLIC;
REVOKE ALL ON TABLE mnu_pattern FROM postgres;
GRANT ALL ON TABLE mnu_pattern TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_pattern TO PUBLIC;


--
-- TOC entry 2649 (class 0 OID 0)
-- Dependencies: 214
-- Name: mnu_role; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role FROM postgres;
GRANT ALL ON TABLE mnu_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role TO PUBLIC;


--
-- TOC entry 2650 (class 0 OID 0)
-- Dependencies: 215
-- Name: mnu_role_task; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_role_task FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role_task FROM postgres;
GRANT ALL ON TABLE mnu_role_task TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role_task TO PUBLIC;


--
-- TOC entry 2651 (class 0 OID 0)
-- Dependencies: 216
-- Name: mnu_role_taskfield; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_role_taskfield FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role_taskfield FROM postgres;
GRANT ALL ON TABLE mnu_role_taskfield TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role_taskfield TO PUBLIC;


--
-- TOC entry 2652 (class 0 OID 0)
-- Dependencies: 252
-- Name: mnu_saved_selection; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_saved_selection FROM PUBLIC;
REVOKE ALL ON TABLE mnu_saved_selection FROM postgres;
GRANT ALL ON TABLE mnu_saved_selection TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_saved_selection TO PUBLIC;


--
-- TOC entry 2653 (class 0 OID 0)
-- Dependencies: 253
-- Name: mnu_saved_selection_data; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_saved_selection_data FROM PUBLIC;
REVOKE ALL ON TABLE mnu_saved_selection_data FROM postgres;
GRANT ALL ON TABLE mnu_saved_selection_data TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_saved_selection_data TO PUBLIC;


--
-- TOC entry 2655 (class 0 OID 0)
-- Dependencies: 251
-- Name: mnu_saved_selection_selection_id_seq; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON SEQUENCE mnu_saved_selection_selection_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE mnu_saved_selection_selection_id_seq FROM postgres;
GRANT ALL ON SEQUENCE mnu_saved_selection_selection_id_seq TO postgres;
GRANT ALL ON SEQUENCE mnu_saved_selection_selection_id_seq TO PUBLIC;


--
-- TOC entry 2656 (class 0 OID 0)
-- Dependencies: 217
-- Name: mnu_subsystem; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_subsystem FROM PUBLIC;
REVOKE ALL ON TABLE mnu_subsystem FROM postgres;
GRANT ALL ON TABLE mnu_subsystem TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_subsystem TO PUBLIC;


--
-- TOC entry 2657 (class 0 OID 0)
-- Dependencies: 218
-- Name: mnu_task; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task FROM postgres;
GRANT ALL ON TABLE mnu_task TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task TO PUBLIC;


--
-- TOC entry 2658 (class 0 OID 0)
-- Dependencies: 219
-- Name: mnu_task_alt; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task_alt FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_alt FROM postgres;
GRANT ALL ON TABLE mnu_task_alt TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_alt TO PUBLIC;


--
-- TOC entry 2659 (class 0 OID 0)
-- Dependencies: 220
-- Name: mnu_task_field; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task_field FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_field FROM postgres;
GRANT ALL ON TABLE mnu_task_field TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_field TO PUBLIC;


--
-- TOC entry 2660 (class 0 OID 0)
-- Dependencies: 221
-- Name: mnu_task_ip_address; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task_ip_address FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_ip_address FROM postgres;
GRANT ALL ON TABLE mnu_task_ip_address TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_ip_address TO PUBLIC;


--
-- TOC entry 2661 (class 0 OID 0)
-- Dependencies: 254
-- Name: mnu_task_quicksearch; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task_quicksearch FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_quicksearch FROM postgres;
GRANT ALL ON TABLE mnu_task_quicksearch TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_quicksearch TO PUBLIC;


--
-- TOC entry 2662 (class 0 OID 0)
-- Dependencies: 255
-- Name: mnu_task_quicksearch_alt; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task_quicksearch_alt FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_quicksearch_alt FROM postgres;
GRANT ALL ON TABLE mnu_task_quicksearch_alt TO postgres;


--
-- TOC entry 2663 (class 0 OID 0)
-- Dependencies: 222
-- Name: mnu_time_limit_role; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_time_limit_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_time_limit_role FROM postgres;
GRANT ALL ON TABLE mnu_time_limit_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_time_limit_role TO PUBLIC;


--
-- TOC entry 2664 (class 0 OID 0)
-- Dependencies: 223
-- Name: mnu_time_limit_user; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_time_limit_user FROM PUBLIC;
REVOKE ALL ON TABLE mnu_time_limit_user FROM postgres;
GRANT ALL ON TABLE mnu_time_limit_user TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_time_limit_user TO PUBLIC;


--
-- TOC entry 2665 (class 0 OID 0)
-- Dependencies: 224
-- Name: mnu_todo; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_todo FROM PUBLIC;
REVOKE ALL ON TABLE mnu_todo FROM postgres;
GRANT ALL ON TABLE mnu_todo TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_todo TO PUBLIC;


--
-- TOC entry 2666 (class 0 OID 0)
-- Dependencies: 225
-- Name: mnu_user; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_user FROM PUBLIC;
REVOKE ALL ON TABLE mnu_user FROM postgres;
GRANT ALL ON TABLE mnu_user TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_user TO PUBLIC;


--
-- TOC entry 2667 (class 0 OID 0)
-- Dependencies: 226
-- Name: mnu_user_alt; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_user_alt FROM PUBLIC;
REVOKE ALL ON TABLE mnu_user_alt FROM postgres;
GRANT ALL ON TABLE mnu_user_alt TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_user_alt TO PUBLIC;


--
-- TOC entry 2668 (class 0 OID 0)
-- Dependencies: 227
-- Name: mnu_user_ip_address; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_user_ip_address FROM PUBLIC;
REVOKE ALL ON TABLE mnu_user_ip_address FROM postgres;
GRANT ALL ON TABLE mnu_user_ip_address TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_user_ip_address TO PUBLIC;


--
-- TOC entry 2669 (class 0 OID 0)
-- Dependencies: 228
-- Name: mnu_user_role; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_user_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_user_role FROM postgres;
GRANT ALL ON TABLE mnu_user_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_user_role TO PUBLIC;


-- Completed on 2016-05-19 11:03:25

--
-- PostgreSQL database dump complete
--

