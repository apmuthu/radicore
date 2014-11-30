--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.5
-- Dumped by pg_dump version 9.2.5
-- Started on 2014-04-25 11:34:01

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 8 (class 2615 OID 16459)
-- Name: menu; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA menu;


ALTER SCHEMA menu OWNER TO postgres;

SET search_path = menu, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 186 (class 1259 OID 16647)
-- Name: help_text; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE TABLE help_text (
    task_id character varying(80) DEFAULT ''::character varying NOT NULL,
    help_text text,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE menu.help_text OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 33401)
-- Name: help_text_alt; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.help_text_alt OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 16656)
-- Name: mnu_account_rdcaccount_id_seq; Type: SEQUENCE; Schema: menu; Owner: postgres
--

CREATE SEQUENCE mnu_account_rdcaccount_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE menu.mnu_account_rdcaccount_id_seq OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 16658)
-- Name: mnu_account; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.mnu_account OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 16664)
-- Name: mnu_control; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.mnu_control OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 16671)
-- Name: mnu_favourite; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.mnu_favourite OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 16684)
-- Name: mnu_initial_value_role; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.mnu_initial_value_role OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 16693)
-- Name: mnu_initial_value_user; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.mnu_initial_value_user OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 16702)
-- Name: mnu_language; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.mnu_language OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 16709)
-- Name: mnu_menu; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.mnu_menu OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 16717)
-- Name: mnu_motd; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.mnu_motd OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 16726)
-- Name: mnu_motd_motd_id_seq; Type: SEQUENCE; Schema: menu; Owner: postgres
--

CREATE SEQUENCE mnu_motd_motd_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE menu.mnu_motd_motd_id_seq OWNER TO postgres;

--
-- TOC entry 2375 (class 0 OID 0)
-- Dependencies: 196
-- Name: mnu_motd_motd_id_seq; Type: SEQUENCE OWNED BY; Schema: menu; Owner: postgres
--

ALTER SEQUENCE mnu_motd_motd_id_seq OWNED BY mnu_motd.motd_id;


--
-- TOC entry 197 (class 1259 OID 16728)
-- Name: mnu_nav_button; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.mnu_nav_button OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16736)
-- Name: mnu_pattern; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.mnu_pattern OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16746)
-- Name: mnu_role; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.mnu_role OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16755)
-- Name: mnu_role_task; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE TABLE mnu_role_task (
    role_id character varying(16) DEFAULT ''::character varying NOT NULL,
    task_id character varying(80) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE menu.mnu_role_task OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16762)
-- Name: mnu_role_taskfield; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.mnu_role_taskfield OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16770)
-- Name: mnu_subsystem; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.mnu_subsystem OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16780)
-- Name: mnu_task; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.mnu_task OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 33431)
-- Name: mnu_task_alt; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.mnu_task_alt OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16790)
-- Name: mnu_task_field; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE TABLE mnu_task_field (
    task_id character varying(80) DEFAULT ''::character varying NOT NULL,
    field_id character varying(40) DEFAULT ''::character varying NOT NULL,
    field_desc character varying(255),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE menu.mnu_task_field OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16797)
-- Name: mnu_task_ip_address; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE TABLE mnu_task_ip_address (
    task_id character varying(80) NOT NULL,
    ip_address character varying(40) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE menu.mnu_task_ip_address OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 74465)
-- Name: mnu_time_limit_role; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.mnu_time_limit_role OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 74491)
-- Name: mnu_time_limit_user; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.mnu_time_limit_user OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16801)
-- Name: mnu_todo; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.mnu_todo OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16814)
-- Name: mnu_user; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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
    language_code character varying(6),
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


ALTER TABLE menu.mnu_user OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 74567)
-- Name: mnu_user_alt; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE TABLE mnu_user_alt (
    user_id character varying(16) DEFAULT ''::character varying NOT NULL,
    language_id character varying(5) DEFAULT ''::character varying NOT NULL,
    user_name character varying(30) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16) DEFAULT NULL::character varying
);


ALTER TABLE menu.mnu_user_alt OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16830)
-- Name: mnu_user_ip_address; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE TABLE mnu_user_ip_address (
    user_id character varying(16) NOT NULL,
    ip_address character varying(40) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE menu.mnu_user_ip_address OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 74578)
-- Name: mnu_user_role; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
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


ALTER TABLE menu.mnu_user_role OWNER TO postgres;

--
-- TOC entry 2094 (class 2604 OID 16899)
-- Name: motd_id; Type: DEFAULT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_motd ALTER COLUMN motd_id SET DEFAULT nextval('mnu_motd_motd_id_seq'::regclass);


--
-- TOC entry 2242 (class 2606 OID 33412)
-- Name: help_text_alt_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY help_text_alt
    ADD CONSTRAINT help_text_alt_pkey PRIMARY KEY (task_id, language_id);


--
-- TOC entry 2191 (class 2606 OID 16930)
-- Name: help_text_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY help_text
    ADD CONSTRAINT help_text_pkey PRIMARY KEY (task_id);


--
-- TOC entry 2193 (class 2606 OID 16932)
-- Name: mnu_account_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_account
    ADD CONSTRAINT mnu_account_pkey PRIMARY KEY (rdcaccount_id);


--
-- TOC entry 2195 (class 2606 OID 16934)
-- Name: mnu_control_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_control
    ADD CONSTRAINT mnu_control_pkey PRIMARY KEY (record_id, field_id);


--
-- TOC entry 2197 (class 2606 OID 16936)
-- Name: mnu_favourite_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_favourite
    ADD CONSTRAINT mnu_favourite_pkey PRIMARY KEY (user_id, seq_no);


--
-- TOC entry 2201 (class 2606 OID 16938)
-- Name: mnu_initial_value_role_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_initial_value_role
    ADD CONSTRAINT mnu_initial_value_role_pkey PRIMARY KEY (role_id, task_id, field_id);


--
-- TOC entry 2204 (class 2606 OID 16940)
-- Name: mnu_initial_value_user_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_initial_value_user
    ADD CONSTRAINT mnu_initial_value_user_pkey PRIMARY KEY (user_id, task_id, field_id);


--
-- TOC entry 2206 (class 2606 OID 16942)
-- Name: mnu_language_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_language
    ADD CONSTRAINT mnu_language_pkey PRIMARY KEY (language_id);


--
-- TOC entry 2208 (class 2606 OID 16944)
-- Name: mnu_menu_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_menu
    ADD CONSTRAINT mnu_menu_pkey PRIMARY KEY (menu_id, task_id_jnr);


--
-- TOC entry 2212 (class 2606 OID 16946)
-- Name: mnu_nav_button_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_nav_button
    ADD CONSTRAINT mnu_nav_button_pkey PRIMARY KEY (task_id_snr, task_id_jnr);


--
-- TOC entry 2214 (class 2606 OID 16948)
-- Name: mnu_pattern_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_pattern
    ADD CONSTRAINT mnu_pattern_pkey PRIMARY KEY (pattern_id);


--
-- TOC entry 2216 (class 2606 OID 16950)
-- Name: mnu_role_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_role
    ADD CONSTRAINT mnu_role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 2218 (class 2606 OID 16952)
-- Name: mnu_role_task_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_role_task
    ADD CONSTRAINT mnu_role_task_pkey PRIMARY KEY (role_id, task_id);


--
-- TOC entry 2221 (class 2606 OID 16954)
-- Name: mnu_role_taskfield_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_role_taskfield
    ADD CONSTRAINT mnu_role_taskfield_pkey PRIMARY KEY (role_id, task_id, field_id);


--
-- TOC entry 2223 (class 2606 OID 16956)
-- Name: mnu_subsystem_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_subsystem
    ADD CONSTRAINT mnu_subsystem_pkey PRIMARY KEY (subsys_id);


--
-- TOC entry 2244 (class 2606 OID 33441)
-- Name: mnu_task_alt_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_task_alt
    ADD CONSTRAINT mnu_task_alt_pkey PRIMARY KEY (task_id, language_id);


--
-- TOC entry 2229 (class 2606 OID 16958)
-- Name: mnu_task_field_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_task_field
    ADD CONSTRAINT mnu_task_field_pkey PRIMARY KEY (task_id, field_id);


--
-- TOC entry 2231 (class 2606 OID 16960)
-- Name: mnu_task_ip_address_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_task_ip_address
    ADD CONSTRAINT mnu_task_ip_address_pkey PRIMARY KEY (task_id, ip_address);


--
-- TOC entry 2227 (class 2606 OID 16962)
-- Name: mnu_task_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_task
    ADD CONSTRAINT mnu_task_pkey PRIMARY KEY (task_id);


--
-- TOC entry 2246 (class 2606 OID 74478)
-- Name: mnu_time_limit_role_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_time_limit_role
    ADD CONSTRAINT mnu_time_limit_role_pkey PRIMARY KEY (role_id, seq_no);


--
-- TOC entry 2248 (class 2606 OID 74504)
-- Name: mnu_time_limit_user_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_time_limit_user
    ADD CONSTRAINT mnu_time_limit_user_pkey PRIMARY KEY (user_id, seq_no);


--
-- TOC entry 2233 (class 2606 OID 16964)
-- Name: mnu_todo_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_todo
    ADD CONSTRAINT mnu_todo_pkey PRIMARY KEY (user_id, seq_no);


--
-- TOC entry 2250 (class 2606 OID 74577)
-- Name: mnu_user_alt_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_user_alt
    ADD CONSTRAINT mnu_user_alt_pkey PRIMARY KEY (user_id, language_id);


--
-- TOC entry 2235 (class 2606 OID 16966)
-- Name: mnu_user_email_addr_key; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_user
    ADD CONSTRAINT mnu_user_email_addr_key UNIQUE (email_addr);


--
-- TOC entry 2240 (class 2606 OID 16968)
-- Name: mnu_user_ip_address_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_user_ip_address
    ADD CONSTRAINT mnu_user_ip_address_pkey PRIMARY KEY (user_id, ip_address);


--
-- TOC entry 2238 (class 2606 OID 16970)
-- Name: mnu_user_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_user
    ADD CONSTRAINT mnu_user_pkey PRIMARY KEY (user_id);


--
-- TOC entry 2252 (class 2606 OID 74588)
-- Name: mnu_user_role_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_user_role
    ADD CONSTRAINT mnu_user_role_pkey PRIMARY KEY (user_id, role_id);


--
-- TOC entry 2210 (class 2606 OID 16972)
-- Name: motd_id; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_motd
    ADD CONSTRAINT motd_id PRIMARY KEY (motd_id);


--
-- TOC entry 2199 (class 1259 OID 16990)
-- Name: mnu_initial_value_role_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_initial_value_role_index1 ON mnu_initial_value_role USING btree (task_id);


--
-- TOC entry 2202 (class 1259 OID 16991)
-- Name: mnu_initial_value_user_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_initial_value_user_index1 ON mnu_initial_value_user USING btree (task_id);


--
-- TOC entry 2219 (class 1259 OID 16992)
-- Name: mnu_role_taskfield_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_role_taskfield_index1 ON mnu_role_taskfield USING btree (task_id);


--
-- TOC entry 2224 (class 1259 OID 16993)
-- Name: mnu_task_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_task_index1 ON mnu_task USING btree (pattern_id);


--
-- TOC entry 2225 (class 1259 OID 16994)
-- Name: mnu_task_index2; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_task_index2 ON mnu_task USING btree (subsys_id);


--
-- TOC entry 2236 (class 1259 OID 16996)
-- Name: mnu_user_index2; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_user_index2 ON mnu_user USING btree (rdcaccount_id);


--
-- TOC entry 2198 (class 1259 OID 74566)
-- Name: user_id_task_id; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX user_id_task_id ON mnu_favourite USING btree (user_id, task_id);


--
-- TOC entry 2363 (class 0 OID 0)
-- Dependencies: 8
-- Name: menu; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA menu FROM PUBLIC;
REVOKE ALL ON SCHEMA menu FROM postgres;
GRANT ALL ON SCHEMA menu TO postgres;
GRANT USAGE ON SCHEMA menu TO PUBLIC;


--
-- TOC entry 2364 (class 0 OID 0)
-- Dependencies: 186
-- Name: help_text; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE help_text FROM PUBLIC;
REVOKE ALL ON TABLE help_text FROM postgres;
GRANT ALL ON TABLE help_text TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE help_text TO PUBLIC;


--
-- TOC entry 2365 (class 0 OID 0)
-- Dependencies: 216
-- Name: help_text_alt; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE help_text_alt FROM PUBLIC;
REVOKE ALL ON TABLE help_text_alt FROM postgres;
GRANT ALL ON TABLE help_text_alt TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE help_text_alt TO PUBLIC;


--
-- TOC entry 2366 (class 0 OID 0)
-- Dependencies: 187
-- Name: mnu_account_rdcaccount_id_seq; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON SEQUENCE mnu_account_rdcaccount_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE mnu_account_rdcaccount_id_seq FROM postgres;
GRANT ALL ON SEQUENCE mnu_account_rdcaccount_id_seq TO postgres;
GRANT ALL ON SEQUENCE mnu_account_rdcaccount_id_seq TO PUBLIC;


--
-- TOC entry 2367 (class 0 OID 0)
-- Dependencies: 188
-- Name: mnu_account; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_account FROM PUBLIC;
REVOKE ALL ON TABLE mnu_account FROM postgres;
GRANT ALL ON TABLE mnu_account TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_account TO PUBLIC;


--
-- TOC entry 2368 (class 0 OID 0)
-- Dependencies: 189
-- Name: mnu_control; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_control FROM PUBLIC;
REVOKE ALL ON TABLE mnu_control FROM postgres;
GRANT ALL ON TABLE mnu_control TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_control TO PUBLIC;


--
-- TOC entry 2369 (class 0 OID 0)
-- Dependencies: 190
-- Name: mnu_favourite; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_favourite FROM PUBLIC;
REVOKE ALL ON TABLE mnu_favourite FROM postgres;
GRANT ALL ON TABLE mnu_favourite TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_favourite TO PUBLIC;


--
-- TOC entry 2370 (class 0 OID 0)
-- Dependencies: 191
-- Name: mnu_initial_value_role; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_initial_value_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_initial_value_role FROM postgres;
GRANT ALL ON TABLE mnu_initial_value_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_initial_value_role TO PUBLIC;


--
-- TOC entry 2371 (class 0 OID 0)
-- Dependencies: 192
-- Name: mnu_initial_value_user; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_initial_value_user FROM PUBLIC;
REVOKE ALL ON TABLE mnu_initial_value_user FROM postgres;
GRANT ALL ON TABLE mnu_initial_value_user TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_initial_value_user TO PUBLIC;


--
-- TOC entry 2372 (class 0 OID 0)
-- Dependencies: 193
-- Name: mnu_language; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_language FROM PUBLIC;
REVOKE ALL ON TABLE mnu_language FROM postgres;
GRANT ALL ON TABLE mnu_language TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_language TO PUBLIC;


--
-- TOC entry 2373 (class 0 OID 0)
-- Dependencies: 194
-- Name: mnu_menu; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_menu FROM PUBLIC;
REVOKE ALL ON TABLE mnu_menu FROM postgres;
GRANT ALL ON TABLE mnu_menu TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_menu TO PUBLIC;


--
-- TOC entry 2374 (class 0 OID 0)
-- Dependencies: 195
-- Name: mnu_motd; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_motd FROM PUBLIC;
REVOKE ALL ON TABLE mnu_motd FROM postgres;
GRANT ALL ON TABLE mnu_motd TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_motd TO PUBLIC;


--
-- TOC entry 2376 (class 0 OID 0)
-- Dependencies: 196
-- Name: mnu_motd_motd_id_seq; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON SEQUENCE mnu_motd_motd_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE mnu_motd_motd_id_seq FROM postgres;
GRANT ALL ON SEQUENCE mnu_motd_motd_id_seq TO postgres;
GRANT ALL ON SEQUENCE mnu_motd_motd_id_seq TO PUBLIC;


--
-- TOC entry 2377 (class 0 OID 0)
-- Dependencies: 197
-- Name: mnu_nav_button; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_nav_button FROM PUBLIC;
REVOKE ALL ON TABLE mnu_nav_button FROM postgres;
GRANT ALL ON TABLE mnu_nav_button TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_nav_button TO PUBLIC;


--
-- TOC entry 2378 (class 0 OID 0)
-- Dependencies: 198
-- Name: mnu_pattern; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_pattern FROM PUBLIC;
REVOKE ALL ON TABLE mnu_pattern FROM postgres;
GRANT ALL ON TABLE mnu_pattern TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_pattern TO PUBLIC;


--
-- TOC entry 2379 (class 0 OID 0)
-- Dependencies: 199
-- Name: mnu_role; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role FROM postgres;
GRANT ALL ON TABLE mnu_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role TO PUBLIC;


--
-- TOC entry 2380 (class 0 OID 0)
-- Dependencies: 200
-- Name: mnu_role_task; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_role_task FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role_task FROM postgres;
GRANT ALL ON TABLE mnu_role_task TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role_task TO PUBLIC;


--
-- TOC entry 2381 (class 0 OID 0)
-- Dependencies: 201
-- Name: mnu_role_taskfield; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_role_taskfield FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role_taskfield FROM postgres;
GRANT ALL ON TABLE mnu_role_taskfield TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role_taskfield TO PUBLIC;


--
-- TOC entry 2382 (class 0 OID 0)
-- Dependencies: 202
-- Name: mnu_subsystem; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_subsystem FROM PUBLIC;
REVOKE ALL ON TABLE mnu_subsystem FROM postgres;
GRANT ALL ON TABLE mnu_subsystem TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_subsystem TO PUBLIC;


--
-- TOC entry 2383 (class 0 OID 0)
-- Dependencies: 203
-- Name: mnu_task; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task FROM postgres;
GRANT ALL ON TABLE mnu_task TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task TO PUBLIC;


--
-- TOC entry 2384 (class 0 OID 0)
-- Dependencies: 217
-- Name: mnu_task_alt; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task_alt FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_alt FROM postgres;
GRANT ALL ON TABLE mnu_task_alt TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_alt TO PUBLIC;


--
-- TOC entry 2385 (class 0 OID 0)
-- Dependencies: 204
-- Name: mnu_task_field; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task_field FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_field FROM postgres;
GRANT ALL ON TABLE mnu_task_field TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_field TO PUBLIC;


--
-- TOC entry 2386 (class 0 OID 0)
-- Dependencies: 205
-- Name: mnu_task_ip_address; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task_ip_address FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_ip_address FROM postgres;
GRANT ALL ON TABLE mnu_task_ip_address TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_ip_address TO PUBLIC;


--
-- TOC entry 2387 (class 0 OID 0)
-- Dependencies: 218
-- Name: mnu_time_limit_role; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_time_limit_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_time_limit_role FROM postgres;
GRANT ALL ON TABLE mnu_time_limit_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_time_limit_role TO PUBLIC;


--
-- TOC entry 2388 (class 0 OID 0)
-- Dependencies: 219
-- Name: mnu_time_limit_user; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_time_limit_user FROM PUBLIC;
REVOKE ALL ON TABLE mnu_time_limit_user FROM postgres;
GRANT ALL ON TABLE mnu_time_limit_user TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_time_limit_user TO PUBLIC;


--
-- TOC entry 2389 (class 0 OID 0)
-- Dependencies: 206
-- Name: mnu_todo; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_todo FROM PUBLIC;
REVOKE ALL ON TABLE mnu_todo FROM postgres;
GRANT ALL ON TABLE mnu_todo TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_todo TO PUBLIC;


--
-- TOC entry 2390 (class 0 OID 0)
-- Dependencies: 207
-- Name: mnu_user; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_user FROM PUBLIC;
REVOKE ALL ON TABLE mnu_user FROM postgres;
GRANT ALL ON TABLE mnu_user TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_user TO PUBLIC;


--
-- TOC entry 2391 (class 0 OID 0)
-- Dependencies: 220
-- Name: mnu_user_alt; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_user_alt FROM PUBLIC;
REVOKE ALL ON TABLE mnu_user_alt FROM postgres;
GRANT ALL ON TABLE mnu_user_alt TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_user_alt TO PUBLIC;


--
-- TOC entry 2392 (class 0 OID 0)
-- Dependencies: 208
-- Name: mnu_user_ip_address; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_user_ip_address FROM PUBLIC;
REVOKE ALL ON TABLE mnu_user_ip_address FROM postgres;
GRANT ALL ON TABLE mnu_user_ip_address TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_user_ip_address TO PUBLIC;


--
-- TOC entry 2393 (class 0 OID 0)
-- Dependencies: 221
-- Name: mnu_user_role; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_user_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_user_role FROM postgres;
GRANT ALL ON TABLE mnu_user_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_user_role TO PUBLIC;


-- Completed on 2014-04-25 11:34:01

--
-- PostgreSQL database dump complete
--

