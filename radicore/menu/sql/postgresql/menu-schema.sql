--
-- PostgreSQL database dump
--

-- Started on 2010-07-21 08:52:02

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 9 (class 2615 OID 16635)
-- Name: menu; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA menu;


ALTER SCHEMA menu OWNER TO postgres;

SET search_path = menu, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1643 (class 1259 OID 16636)
-- Dependencies: 1965 1966 1967 9
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
-- TOC entry 1644 (class 1259 OID 16645)
-- Dependencies: 1969 1970 9
-- Name: mnu_account; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE TABLE mnu_account (
    rdcaccount_id integer NOT NULL,
    account_name character varying(255) NOT NULL,
    rdcversion integer DEFAULT 1 NOT NULL,
    created_date timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE menu.mnu_account OWNER TO postgres;

--
-- TOC entry 1645 (class 1259 OID 16650)
-- Dependencies: 9 1644
-- Name: mnu_account_rdcaccount_id_seq; Type: SEQUENCE; Schema: menu; Owner: postgres
--

CREATE SEQUENCE mnu_account_rdcaccount_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE menu.mnu_account_rdcaccount_id_seq OWNER TO postgres;

--
-- TOC entry 2118 (class 0 OID 0)
-- Dependencies: 1645
-- Name: mnu_account_rdcaccount_id_seq; Type: SEQUENCE OWNED BY; Schema: menu; Owner: postgres
--

ALTER SEQUENCE mnu_account_rdcaccount_id_seq OWNED BY mnu_account.rdcaccount_id;


--
-- TOC entry 1646 (class 1259 OID 16652)
-- Dependencies: 1971 1972 1973 1974 9
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
-- TOC entry 1687 (class 1259 OID 17180)
-- Dependencies: 2055 2056 2057 2058 2059 2060 2061 9
-- Name: mnu_favourite; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE TABLE mnu_favourite (
    user_id character varying(16) DEFAULT ''::character varying NOT NULL,
    seq_no smallint DEFAULT (0)::smallint NOT NULL,
    task_id character varying(80) DEFAULT ''::character varying NOT NULL,
    task_desc character varying(80) DEFAULT ''::character varying NOT NULL,
    sort_seq smallint DEFAULT (0)::smallint NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE menu.mnu_favourite OWNER TO postgres;

--
-- TOC entry 1647 (class 1259 OID 16659)
-- Dependencies: 1975 1976 1977 1978 1979 1980 9
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
-- TOC entry 1648 (class 1259 OID 16668)
-- Dependencies: 1981 1982 1983 1984 1985 1986 9
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
-- TOC entry 1649 (class 1259 OID 16677)
-- Dependencies: 1987 1988 1989 1990 9
-- Name: mnu_language; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE TABLE mnu_language (
    language_id character varying(5) DEFAULT 'EN'::character varying NOT NULL,
    language_name character varying(40) DEFAULT 'English'::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE menu.mnu_language OWNER TO postgres;

--
-- TOC entry 1650 (class 1259 OID 16684)
-- Dependencies: 1991 1992 1993 1994 1995 9
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
-- TOC entry 1651 (class 1259 OID 16692)
-- Dependencies: 1997 1998 1999 9
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
-- TOC entry 1652 (class 1259 OID 16701)
-- Dependencies: 1651 9
-- Name: mnu_motd_motd_id_seq; Type: SEQUENCE; Schema: menu; Owner: postgres
--

CREATE SEQUENCE mnu_motd_motd_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE menu.mnu_motd_motd_id_seq OWNER TO postgres;

--
-- TOC entry 2125 (class 0 OID 0)
-- Dependencies: 1652
-- Name: mnu_motd_motd_id_seq; Type: SEQUENCE OWNED BY; Schema: menu; Owner: postgres
--

ALTER SEQUENCE mnu_motd_motd_id_seq OWNED BY mnu_motd.motd_id;


--
-- TOC entry 1653 (class 1259 OID 16703)
-- Dependencies: 2000 2001 2002 2003 2004 9
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
-- TOC entry 1654 (class 1259 OID 16711)
-- Dependencies: 2005 2006 2007 2008 9
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
-- TOC entry 1655 (class 1259 OID 16721)
-- Dependencies: 2009 2010 2011 2012 2013 2014 9
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
-- TOC entry 1656 (class 1259 OID 16730)
-- Dependencies: 2015 2016 2017 2018 9
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
-- TOC entry 1657 (class 1259 OID 16737)
-- Dependencies: 2019 2020 2021 2022 2023 9
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
-- TOC entry 1658 (class 1259 OID 16745)
-- Dependencies: 2024 2025 2026 2027 9
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
-- TOC entry 1659 (class 1259 OID 16755)
-- Dependencies: 2028 2029 2030 2031 9
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
-- TOC entry 1660 (class 1259 OID 16765)
-- Dependencies: 2032 2033 2034 2035 9
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
-- TOC entry 1686 (class 1259 OID 17165)
-- Dependencies: 2054 9
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
-- TOC entry 1661 (class 1259 OID 16772)
-- Dependencies: 2036 2037 2038 2039 2040 2041 2042 9
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
-- TOC entry 1662 (class 1259 OID 16785)
-- Dependencies: 2043 2044 2045 2046 2047 2048 2049 2050 2051 2052 9
-- Name: mnu_user; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE TABLE mnu_user (
    user_id character varying(16) DEFAULT ''::character varying NOT NULL,
    user_name character varying(30) DEFAULT ''::character varying NOT NULL,
    user_password character varying(16) DEFAULT ''::character varying NOT NULL,
    role_id character varying(16) NOT NULL,
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
    ip_address character varying(16),
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
-- TOC entry 1685 (class 1259 OID 17159)
-- Dependencies: 2053 9
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
-- TOC entry 1968 (class 2604 OID 16801)
-- Dependencies: 1645 1644
-- Name: rdcaccount_id; Type: DEFAULT; Schema: menu; Owner: postgres
--

ALTER TABLE mnu_account ALTER COLUMN rdcaccount_id SET DEFAULT nextval('mnu_account_rdcaccount_id_seq'::regclass);


--
-- TOC entry 1996 (class 2604 OID 16802)
-- Dependencies: 1652 1651
-- Name: motd_id; Type: DEFAULT; Schema: menu; Owner: postgres
--

ALTER TABLE mnu_motd ALTER COLUMN motd_id SET DEFAULT nextval('mnu_motd_motd_id_seq'::regclass);


--
-- TOC entry 2063 (class 2606 OID 16804)
-- Dependencies: 1643 1643
-- Name: help_text_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY help_text
    ADD CONSTRAINT help_text_pkey PRIMARY KEY (task_id);


--
-- TOC entry 2065 (class 2606 OID 16806)
-- Dependencies: 1644 1644
-- Name: mnu_account_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_account
    ADD CONSTRAINT mnu_account_pkey PRIMARY KEY (rdcaccount_id);


--
-- TOC entry 2067 (class 2606 OID 16808)
-- Dependencies: 1646 1646 1646
-- Name: mnu_control_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_control
    ADD CONSTRAINT mnu_control_pkey PRIMARY KEY (record_id, field_id);


--
-- TOC entry 2112 (class 2606 OID 17191)
-- Dependencies: 1687 1687 1687
-- Name: mnu_favourite_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_favourite
    ADD CONSTRAINT mnu_favourite_pkey PRIMARY KEY (user_id, seq_no);


--
-- TOC entry 2070 (class 2606 OID 16810)
-- Dependencies: 1647 1647 1647 1647
-- Name: mnu_initial_value_role_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_initial_value_role
    ADD CONSTRAINT mnu_initial_value_role_pkey PRIMARY KEY (role_id, task_id, field_id);


--
-- TOC entry 2073 (class 2606 OID 16812)
-- Dependencies: 1648 1648 1648 1648
-- Name: mnu_initial_value_user_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_initial_value_user
    ADD CONSTRAINT mnu_initial_value_user_pkey PRIMARY KEY (user_id, task_id, field_id);


--
-- TOC entry 2075 (class 2606 OID 16814)
-- Dependencies: 1649 1649
-- Name: mnu_language_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_language
    ADD CONSTRAINT mnu_language_pkey PRIMARY KEY (language_id);


--
-- TOC entry 2077 (class 2606 OID 16816)
-- Dependencies: 1650 1650 1650
-- Name: mnu_menu_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_menu
    ADD CONSTRAINT mnu_menu_pkey PRIMARY KEY (menu_id, task_id_jnr);


--
-- TOC entry 2081 (class 2606 OID 16818)
-- Dependencies: 1653 1653 1653
-- Name: mnu_nav_button_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_nav_button
    ADD CONSTRAINT mnu_nav_button_pkey PRIMARY KEY (task_id_snr, task_id_jnr);


--
-- TOC entry 2083 (class 2606 OID 16820)
-- Dependencies: 1654 1654
-- Name: mnu_pattern_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_pattern
    ADD CONSTRAINT mnu_pattern_pkey PRIMARY KEY (pattern_id);


--
-- TOC entry 2085 (class 2606 OID 16822)
-- Dependencies: 1655 1655
-- Name: mnu_role_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_role
    ADD CONSTRAINT mnu_role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 2087 (class 2606 OID 16824)
-- Dependencies: 1656 1656 1656
-- Name: mnu_role_task_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_role_task
    ADD CONSTRAINT mnu_role_task_pkey PRIMARY KEY (role_id, task_id);


--
-- TOC entry 2090 (class 2606 OID 16826)
-- Dependencies: 1657 1657 1657 1657
-- Name: mnu_role_taskfield_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_role_taskfield
    ADD CONSTRAINT mnu_role_taskfield_pkey PRIMARY KEY (role_id, task_id, field_id);


--
-- TOC entry 2092 (class 2606 OID 16828)
-- Dependencies: 1658 1658
-- Name: mnu_subsystem_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_subsystem
    ADD CONSTRAINT mnu_subsystem_pkey PRIMARY KEY (subsys_id);


--
-- TOC entry 2098 (class 2606 OID 16830)
-- Dependencies: 1660 1660 1660
-- Name: mnu_task_field_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_task_field
    ADD CONSTRAINT mnu_task_field_pkey PRIMARY KEY (task_id, field_id);


--
-- TOC entry 2110 (class 2606 OID 17170)
-- Dependencies: 1686 1686 1686
-- Name: mnu_task_ip_address_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_task_ip_address
    ADD CONSTRAINT mnu_task_ip_address_pkey PRIMARY KEY (task_id, ip_address);


--
-- TOC entry 2096 (class 2606 OID 16832)
-- Dependencies: 1659 1659
-- Name: mnu_task_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_task
    ADD CONSTRAINT mnu_task_pkey PRIMARY KEY (task_id);


--
-- TOC entry 2100 (class 2606 OID 16834)
-- Dependencies: 1661 1661 1661
-- Name: mnu_todo_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_todo
    ADD CONSTRAINT mnu_todo_pkey PRIMARY KEY (user_id, seq_no);


--
-- TOC entry 2102 (class 2606 OID 16836)
-- Dependencies: 1662 1662
-- Name: mnu_user_email_addr_key; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_user
    ADD CONSTRAINT mnu_user_email_addr_key UNIQUE (email_addr);


--
-- TOC entry 2108 (class 2606 OID 17164)
-- Dependencies: 1685 1685 1685
-- Name: mnu_user_ip_address_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_user_ip_address
    ADD CONSTRAINT mnu_user_ip_address_pkey PRIMARY KEY (user_id, ip_address);


--
-- TOC entry 2106 (class 2606 OID 16838)
-- Dependencies: 1662 1662
-- Name: mnu_user_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_user
    ADD CONSTRAINT mnu_user_pkey PRIMARY KEY (user_id);


--
-- TOC entry 2079 (class 2606 OID 16840)
-- Dependencies: 1651 1651
-- Name: motd_id; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_motd
    ADD CONSTRAINT motd_id PRIMARY KEY (motd_id);


--
-- TOC entry 2068 (class 1259 OID 16841)
-- Dependencies: 1647
-- Name: mnu_initial_value_role_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_initial_value_role_index1 ON mnu_initial_value_role USING btree (task_id);


--
-- TOC entry 2071 (class 1259 OID 16842)
-- Dependencies: 1648
-- Name: mnu_initial_value_user_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_initial_value_user_index1 ON mnu_initial_value_user USING btree (task_id);


--
-- TOC entry 2088 (class 1259 OID 16843)
-- Dependencies: 1657
-- Name: mnu_role_taskfield_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_role_taskfield_index1 ON mnu_role_taskfield USING btree (task_id);


--
-- TOC entry 2093 (class 1259 OID 16844)
-- Dependencies: 1659
-- Name: mnu_task_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_task_index1 ON mnu_task USING btree (pattern_id);


--
-- TOC entry 2094 (class 1259 OID 16845)
-- Dependencies: 1659
-- Name: mnu_task_index2; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_task_index2 ON mnu_task USING btree (subsys_id);


--
-- TOC entry 2103 (class 1259 OID 16846)
-- Dependencies: 1662
-- Name: mnu_user_index; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_user_index ON mnu_user USING btree (role_id);


--
-- TOC entry 2104 (class 1259 OID 16847)
-- Dependencies: 1662
-- Name: mnu_user_index2; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_user_index2 ON mnu_user USING btree (rdcaccount_id);


--
-- TOC entry 2115 (class 0 OID 0)
-- Dependencies: 9
-- Name: menu; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA menu FROM PUBLIC;
REVOKE ALL ON SCHEMA menu FROM postgres;
GRANT ALL ON SCHEMA menu TO postgres;
GRANT USAGE ON SCHEMA menu TO PUBLIC;


--
-- TOC entry 2116 (class 0 OID 0)
-- Dependencies: 1643
-- Name: help_text; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE help_text FROM PUBLIC;
REVOKE ALL ON TABLE help_text FROM postgres;
GRANT ALL ON TABLE help_text TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE help_text TO PUBLIC;


--
-- TOC entry 2117 (class 0 OID 0)
-- Dependencies: 1644
-- Name: mnu_account; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_account FROM PUBLIC;
REVOKE ALL ON TABLE mnu_account FROM postgres;
GRANT ALL ON TABLE mnu_account TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_account TO PUBLIC;


--
-- TOC entry 2119 (class 0 OID 0)
-- Dependencies: 1646
-- Name: mnu_control; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_control FROM PUBLIC;
REVOKE ALL ON TABLE mnu_control FROM postgres;
GRANT ALL ON TABLE mnu_control TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_control TO PUBLIC;


--
-- TOC entry 2120 (class 0 OID 0)
-- Dependencies: 1647
-- Name: mnu_initial_value_role; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_initial_value_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_initial_value_role FROM postgres;
GRANT ALL ON TABLE mnu_initial_value_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_initial_value_role TO PUBLIC;


--
-- TOC entry 2121 (class 0 OID 0)
-- Dependencies: 1648
-- Name: mnu_initial_value_user; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_initial_value_user FROM PUBLIC;
REVOKE ALL ON TABLE mnu_initial_value_user FROM postgres;
GRANT ALL ON TABLE mnu_initial_value_user TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_initial_value_user TO PUBLIC;


--
-- TOC entry 2122 (class 0 OID 0)
-- Dependencies: 1649
-- Name: mnu_language; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_language FROM PUBLIC;
REVOKE ALL ON TABLE mnu_language FROM postgres;
GRANT ALL ON TABLE mnu_language TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_language TO PUBLIC;


--
-- TOC entry 2123 (class 0 OID 0)
-- Dependencies: 1650
-- Name: mnu_menu; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_menu FROM PUBLIC;
REVOKE ALL ON TABLE mnu_menu FROM postgres;
GRANT ALL ON TABLE mnu_menu TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_menu TO PUBLIC;


--
-- TOC entry 2124 (class 0 OID 0)
-- Dependencies: 1651
-- Name: mnu_motd; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_motd FROM PUBLIC;
REVOKE ALL ON TABLE mnu_motd FROM postgres;
GRANT ALL ON TABLE mnu_motd TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_motd TO PUBLIC;


--
-- TOC entry 2126 (class 0 OID 0)
-- Dependencies: 1653
-- Name: mnu_nav_button; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_nav_button FROM PUBLIC;
REVOKE ALL ON TABLE mnu_nav_button FROM postgres;
GRANT ALL ON TABLE mnu_nav_button TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_nav_button TO PUBLIC;


--
-- TOC entry 2127 (class 0 OID 0)
-- Dependencies: 1654
-- Name: mnu_pattern; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_pattern FROM PUBLIC;
REVOKE ALL ON TABLE mnu_pattern FROM postgres;
GRANT ALL ON TABLE mnu_pattern TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_pattern TO PUBLIC;


--
-- TOC entry 2128 (class 0 OID 0)
-- Dependencies: 1655
-- Name: mnu_role; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role FROM postgres;
GRANT ALL ON TABLE mnu_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role TO PUBLIC;


--
-- TOC entry 2129 (class 0 OID 0)
-- Dependencies: 1656
-- Name: mnu_role_task; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_role_task FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role_task FROM postgres;
GRANT ALL ON TABLE mnu_role_task TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role_task TO PUBLIC;


--
-- TOC entry 2130 (class 0 OID 0)
-- Dependencies: 1657
-- Name: mnu_role_taskfield; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_role_taskfield FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role_taskfield FROM postgres;
GRANT ALL ON TABLE mnu_role_taskfield TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role_taskfield TO PUBLIC;


--
-- TOC entry 2131 (class 0 OID 0)
-- Dependencies: 1658
-- Name: mnu_subsystem; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_subsystem FROM PUBLIC;
REVOKE ALL ON TABLE mnu_subsystem FROM postgres;
GRANT ALL ON TABLE mnu_subsystem TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_subsystem TO PUBLIC;


--
-- TOC entry 2132 (class 0 OID 0)
-- Dependencies: 1659
-- Name: mnu_task; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task FROM postgres;
GRANT ALL ON TABLE mnu_task TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task TO PUBLIC;


--
-- TOC entry 2133 (class 0 OID 0)
-- Dependencies: 1660
-- Name: mnu_task_field; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task_field FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_field FROM postgres;
GRANT ALL ON TABLE mnu_task_field TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_field TO PUBLIC;


--
-- TOC entry 2134 (class 0 OID 0)
-- Dependencies: 1686
-- Name: mnu_task_ip_address; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task_ip_address FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_ip_address FROM postgres;
GRANT ALL ON TABLE mnu_task_ip_address TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_ip_address TO PUBLIC;


--
-- TOC entry 2135 (class 0 OID 0)
-- Dependencies: 1661
-- Name: mnu_todo; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_todo FROM PUBLIC;
REVOKE ALL ON TABLE mnu_todo FROM postgres;
GRANT ALL ON TABLE mnu_todo TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_todo TO PUBLIC;


--
-- TOC entry 2136 (class 0 OID 0)
-- Dependencies: 1662
-- Name: mnu_user; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_user FROM PUBLIC;
REVOKE ALL ON TABLE mnu_user FROM postgres;
GRANT ALL ON TABLE mnu_user TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_user TO PUBLIC;


--
-- TOC entry 2137 (class 0 OID 0)
-- Dependencies: 1685
-- Name: mnu_user_ip_address; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_user_ip_address FROM PUBLIC;
REVOKE ALL ON TABLE mnu_user_ip_address FROM postgres;
GRANT ALL ON TABLE mnu_user_ip_address TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_user_ip_address TO PUBLIC;


-- Completed on 2010-07-21 08:52:03

--
-- PostgreSQL database dump complete
--

