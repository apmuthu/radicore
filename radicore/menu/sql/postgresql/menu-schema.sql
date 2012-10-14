--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.4
-- Dumped by pg_dump version 9.1.4
-- Started on 2012-06-07 09:23:59

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 8 (class 2615 OID 17041)
-- Name: menu; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA menu;


ALTER SCHEMA menu OWNER TO postgres;

SET search_path = menu, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 172 (class 1259 OID 17042)
-- Dependencies: 2066 2067 2068 8
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
-- TOC entry 173 (class 1259 OID 17051)
-- Dependencies: 8
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
-- TOC entry 174 (class 1259 OID 17053)
-- Dependencies: 2069 2070 2071 8
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
-- TOC entry 175 (class 1259 OID 17059)
-- Dependencies: 2072 2073 2074 2075 8
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
-- TOC entry 176 (class 1259 OID 17066)
-- Dependencies: 2076 2077 2078 2079 2080 2081 2082 8
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
    revised_user character varying(16),
    breadcrumbs character varying(4000)
);


ALTER TABLE menu.mnu_favourite OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 17079)
-- Dependencies: 2083 2084 2085 2086 2087 2088 8
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
-- TOC entry 178 (class 1259 OID 17088)
-- Dependencies: 2089 2090 2091 2092 2093 2094 8
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
-- TOC entry 179 (class 1259 OID 17097)
-- Dependencies: 2095 2096 2097 2098 8
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
-- TOC entry 180 (class 1259 OID 17104)
-- Dependencies: 2099 2100 2101 2102 2103 8
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
-- TOC entry 181 (class 1259 OID 17112)
-- Dependencies: 2104 2105 2106 8
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
-- TOC entry 182 (class 1259 OID 17121)
-- Dependencies: 181 8
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
-- TOC entry 2227 (class 0 OID 0)
-- Dependencies: 182
-- Name: mnu_motd_motd_id_seq; Type: SEQUENCE OWNED BY; Schema: menu; Owner: postgres
--

ALTER SEQUENCE mnu_motd_motd_id_seq OWNED BY mnu_motd.motd_id;


--
-- TOC entry 183 (class 1259 OID 17123)
-- Dependencies: 2108 2109 2110 2111 2112 8
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
-- TOC entry 184 (class 1259 OID 17131)
-- Dependencies: 2113 2114 2115 2116 8
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
-- TOC entry 185 (class 1259 OID 17141)
-- Dependencies: 2117 2118 2119 2120 2121 2122 8
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
-- TOC entry 186 (class 1259 OID 17150)
-- Dependencies: 2123 2124 2125 2126 8
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
-- TOC entry 187 (class 1259 OID 17157)
-- Dependencies: 2127 2128 2129 2130 2131 8
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
-- TOC entry 188 (class 1259 OID 17165)
-- Dependencies: 2132 2133 2134 2135 8
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
-- TOC entry 189 (class 1259 OID 17175)
-- Dependencies: 2136 2137 2138 2139 8
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
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16),
    task_id_run_at_end character varying(80),
    task_id_run_at_cancel character varying(80)
);


ALTER TABLE menu.mnu_task OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 17185)
-- Dependencies: 2140 2141 2142 2143 8
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
-- TOC entry 191 (class 1259 OID 17192)
-- Dependencies: 2144 8
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
-- TOC entry 192 (class 1259 OID 17196)
-- Dependencies: 2145 2146 2147 2148 2149 2150 2151 8
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
-- TOC entry 193 (class 1259 OID 17209)
-- Dependencies: 2152 2153 2154 2155 2156 2157 2158 2159 2160 2161 8
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
-- TOC entry 194 (class 1259 OID 17225)
-- Dependencies: 2162 8
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
-- TOC entry 2107 (class 2604 OID 17229)
-- Dependencies: 182 181
-- Name: motd_id; Type: DEFAULT; Schema: menu; Owner: postgres
--

ALTER TABLE ONLY mnu_motd ALTER COLUMN motd_id SET DEFAULT nextval('mnu_motd_motd_id_seq'::regclass);


--
-- TOC entry 2164 (class 2606 OID 17231)
-- Dependencies: 172 172
-- Name: help_text_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY help_text
    ADD CONSTRAINT help_text_pkey PRIMARY KEY (task_id);


--
-- TOC entry 2166 (class 2606 OID 17233)
-- Dependencies: 174 174
-- Name: mnu_account_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_account
    ADD CONSTRAINT mnu_account_pkey PRIMARY KEY (rdcaccount_id);


--
-- TOC entry 2168 (class 2606 OID 17235)
-- Dependencies: 175 175 175
-- Name: mnu_control_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_control
    ADD CONSTRAINT mnu_control_pkey PRIMARY KEY (record_id, field_id);


--
-- TOC entry 2170 (class 2606 OID 17237)
-- Dependencies: 176 176 176
-- Name: mnu_favourite_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_favourite
    ADD CONSTRAINT mnu_favourite_pkey PRIMARY KEY (user_id, seq_no);


--
-- TOC entry 2173 (class 2606 OID 17239)
-- Dependencies: 177 177 177 177
-- Name: mnu_initial_value_role_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_initial_value_role
    ADD CONSTRAINT mnu_initial_value_role_pkey PRIMARY KEY (role_id, task_id, field_id);


--
-- TOC entry 2176 (class 2606 OID 17241)
-- Dependencies: 178 178 178 178
-- Name: mnu_initial_value_user_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_initial_value_user
    ADD CONSTRAINT mnu_initial_value_user_pkey PRIMARY KEY (user_id, task_id, field_id);


--
-- TOC entry 2178 (class 2606 OID 17243)
-- Dependencies: 179 179
-- Name: mnu_language_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_language
    ADD CONSTRAINT mnu_language_pkey PRIMARY KEY (language_id);


--
-- TOC entry 2180 (class 2606 OID 17245)
-- Dependencies: 180 180 180
-- Name: mnu_menu_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_menu
    ADD CONSTRAINT mnu_menu_pkey PRIMARY KEY (menu_id, task_id_jnr);


--
-- TOC entry 2184 (class 2606 OID 17247)
-- Dependencies: 183 183 183
-- Name: mnu_nav_button_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_nav_button
    ADD CONSTRAINT mnu_nav_button_pkey PRIMARY KEY (task_id_snr, task_id_jnr);


--
-- TOC entry 2186 (class 2606 OID 17249)
-- Dependencies: 184 184
-- Name: mnu_pattern_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_pattern
    ADD CONSTRAINT mnu_pattern_pkey PRIMARY KEY (pattern_id);


--
-- TOC entry 2188 (class 2606 OID 17251)
-- Dependencies: 185 185
-- Name: mnu_role_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_role
    ADD CONSTRAINT mnu_role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 2190 (class 2606 OID 17253)
-- Dependencies: 186 186 186
-- Name: mnu_role_task_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_role_task
    ADD CONSTRAINT mnu_role_task_pkey PRIMARY KEY (role_id, task_id);


--
-- TOC entry 2193 (class 2606 OID 17255)
-- Dependencies: 187 187 187 187
-- Name: mnu_role_taskfield_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_role_taskfield
    ADD CONSTRAINT mnu_role_taskfield_pkey PRIMARY KEY (role_id, task_id, field_id);


--
-- TOC entry 2195 (class 2606 OID 17257)
-- Dependencies: 188 188
-- Name: mnu_subsystem_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_subsystem
    ADD CONSTRAINT mnu_subsystem_pkey PRIMARY KEY (subsys_id);


--
-- TOC entry 2201 (class 2606 OID 17259)
-- Dependencies: 190 190 190
-- Name: mnu_task_field_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_task_field
    ADD CONSTRAINT mnu_task_field_pkey PRIMARY KEY (task_id, field_id);


--
-- TOC entry 2203 (class 2606 OID 17261)
-- Dependencies: 191 191 191
-- Name: mnu_task_ip_address_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_task_ip_address
    ADD CONSTRAINT mnu_task_ip_address_pkey PRIMARY KEY (task_id, ip_address);


--
-- TOC entry 2199 (class 2606 OID 17263)
-- Dependencies: 189 189
-- Name: mnu_task_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_task
    ADD CONSTRAINT mnu_task_pkey PRIMARY KEY (task_id);


--
-- TOC entry 2205 (class 2606 OID 17265)
-- Dependencies: 192 192 192
-- Name: mnu_todo_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_todo
    ADD CONSTRAINT mnu_todo_pkey PRIMARY KEY (user_id, seq_no);


--
-- TOC entry 2207 (class 2606 OID 17267)
-- Dependencies: 193 193
-- Name: mnu_user_email_addr_key; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_user
    ADD CONSTRAINT mnu_user_email_addr_key UNIQUE (email_addr);


--
-- TOC entry 2213 (class 2606 OID 17269)
-- Dependencies: 194 194 194
-- Name: mnu_user_ip_address_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_user_ip_address
    ADD CONSTRAINT mnu_user_ip_address_pkey PRIMARY KEY (user_id, ip_address);


--
-- TOC entry 2211 (class 2606 OID 17271)
-- Dependencies: 193 193
-- Name: mnu_user_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_user
    ADD CONSTRAINT mnu_user_pkey PRIMARY KEY (user_id);


--
-- TOC entry 2182 (class 2606 OID 17273)
-- Dependencies: 181 181
-- Name: motd_id; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_motd
    ADD CONSTRAINT motd_id PRIMARY KEY (motd_id);


--
-- TOC entry 2171 (class 1259 OID 17274)
-- Dependencies: 177
-- Name: mnu_initial_value_role_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_initial_value_role_index1 ON mnu_initial_value_role USING btree (task_id);


--
-- TOC entry 2174 (class 1259 OID 17275)
-- Dependencies: 178
-- Name: mnu_initial_value_user_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_initial_value_user_index1 ON mnu_initial_value_user USING btree (task_id);


--
-- TOC entry 2191 (class 1259 OID 17276)
-- Dependencies: 187
-- Name: mnu_role_taskfield_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_role_taskfield_index1 ON mnu_role_taskfield USING btree (task_id);


--
-- TOC entry 2196 (class 1259 OID 17277)
-- Dependencies: 189
-- Name: mnu_task_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_task_index1 ON mnu_task USING btree (pattern_id);


--
-- TOC entry 2197 (class 1259 OID 17278)
-- Dependencies: 189
-- Name: mnu_task_index2; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_task_index2 ON mnu_task USING btree (subsys_id);


--
-- TOC entry 2208 (class 1259 OID 17279)
-- Dependencies: 193
-- Name: mnu_user_index; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_user_index ON mnu_user USING btree (role_id);


--
-- TOC entry 2209 (class 1259 OID 17280)
-- Dependencies: 193
-- Name: mnu_user_index2; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_user_index2 ON mnu_user USING btree (rdcaccount_id);


--
-- TOC entry 2216 (class 0 OID 0)
-- Dependencies: 8
-- Name: menu; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA menu FROM PUBLIC;
REVOKE ALL ON SCHEMA menu FROM postgres;
GRANT ALL ON SCHEMA menu TO postgres;
GRANT USAGE ON SCHEMA menu TO PUBLIC;


--
-- TOC entry 2217 (class 0 OID 0)
-- Dependencies: 172
-- Name: help_text; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE help_text FROM PUBLIC;
REVOKE ALL ON TABLE help_text FROM postgres;
GRANT ALL ON TABLE help_text TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE help_text TO PUBLIC;


--
-- TOC entry 2218 (class 0 OID 0)
-- Dependencies: 173
-- Name: mnu_account_rdcaccount_id_seq; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON SEQUENCE mnu_account_rdcaccount_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE mnu_account_rdcaccount_id_seq FROM postgres;
GRANT ALL ON SEQUENCE mnu_account_rdcaccount_id_seq TO postgres;
GRANT ALL ON SEQUENCE mnu_account_rdcaccount_id_seq TO PUBLIC;


--
-- TOC entry 2219 (class 0 OID 0)
-- Dependencies: 174
-- Name: mnu_account; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_account FROM PUBLIC;
REVOKE ALL ON TABLE mnu_account FROM postgres;
GRANT ALL ON TABLE mnu_account TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_account TO PUBLIC;


--
-- TOC entry 2220 (class 0 OID 0)
-- Dependencies: 175
-- Name: mnu_control; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_control FROM PUBLIC;
REVOKE ALL ON TABLE mnu_control FROM postgres;
GRANT ALL ON TABLE mnu_control TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_control TO PUBLIC;


--
-- TOC entry 2221 (class 0 OID 0)
-- Dependencies: 176
-- Name: mnu_favourite; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_favourite FROM PUBLIC;
REVOKE ALL ON TABLE mnu_favourite FROM postgres;
GRANT ALL ON TABLE mnu_favourite TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_favourite TO PUBLIC;


--
-- TOC entry 2222 (class 0 OID 0)
-- Dependencies: 177
-- Name: mnu_initial_value_role; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_initial_value_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_initial_value_role FROM postgres;
GRANT ALL ON TABLE mnu_initial_value_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_initial_value_role TO PUBLIC;


--
-- TOC entry 2223 (class 0 OID 0)
-- Dependencies: 178
-- Name: mnu_initial_value_user; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_initial_value_user FROM PUBLIC;
REVOKE ALL ON TABLE mnu_initial_value_user FROM postgres;
GRANT ALL ON TABLE mnu_initial_value_user TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_initial_value_user TO PUBLIC;


--
-- TOC entry 2224 (class 0 OID 0)
-- Dependencies: 179
-- Name: mnu_language; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_language FROM PUBLIC;
REVOKE ALL ON TABLE mnu_language FROM postgres;
GRANT ALL ON TABLE mnu_language TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_language TO PUBLIC;


--
-- TOC entry 2225 (class 0 OID 0)
-- Dependencies: 180
-- Name: mnu_menu; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_menu FROM PUBLIC;
REVOKE ALL ON TABLE mnu_menu FROM postgres;
GRANT ALL ON TABLE mnu_menu TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_menu TO PUBLIC;


--
-- TOC entry 2226 (class 0 OID 0)
-- Dependencies: 181
-- Name: mnu_motd; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_motd FROM PUBLIC;
REVOKE ALL ON TABLE mnu_motd FROM postgres;
GRANT ALL ON TABLE mnu_motd TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_motd TO PUBLIC;


--
-- TOC entry 2228 (class 0 OID 0)
-- Dependencies: 182
-- Name: mnu_motd_motd_id_seq; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON SEQUENCE mnu_motd_motd_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE mnu_motd_motd_id_seq FROM postgres;
GRANT ALL ON SEQUENCE mnu_motd_motd_id_seq TO postgres;
GRANT ALL ON SEQUENCE mnu_motd_motd_id_seq TO PUBLIC;


--
-- TOC entry 2229 (class 0 OID 0)
-- Dependencies: 183
-- Name: mnu_nav_button; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_nav_button FROM PUBLIC;
REVOKE ALL ON TABLE mnu_nav_button FROM postgres;
GRANT ALL ON TABLE mnu_nav_button TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_nav_button TO PUBLIC;


--
-- TOC entry 2230 (class 0 OID 0)
-- Dependencies: 184
-- Name: mnu_pattern; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_pattern FROM PUBLIC;
REVOKE ALL ON TABLE mnu_pattern FROM postgres;
GRANT ALL ON TABLE mnu_pattern TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_pattern TO PUBLIC;


--
-- TOC entry 2231 (class 0 OID 0)
-- Dependencies: 185
-- Name: mnu_role; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role FROM postgres;
GRANT ALL ON TABLE mnu_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role TO PUBLIC;


--
-- TOC entry 2232 (class 0 OID 0)
-- Dependencies: 186
-- Name: mnu_role_task; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_role_task FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role_task FROM postgres;
GRANT ALL ON TABLE mnu_role_task TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role_task TO PUBLIC;


--
-- TOC entry 2233 (class 0 OID 0)
-- Dependencies: 187
-- Name: mnu_role_taskfield; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_role_taskfield FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role_taskfield FROM postgres;
GRANT ALL ON TABLE mnu_role_taskfield TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role_taskfield TO PUBLIC;


--
-- TOC entry 2234 (class 0 OID 0)
-- Dependencies: 188
-- Name: mnu_subsystem; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_subsystem FROM PUBLIC;
REVOKE ALL ON TABLE mnu_subsystem FROM postgres;
GRANT ALL ON TABLE mnu_subsystem TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_subsystem TO PUBLIC;


--
-- TOC entry 2235 (class 0 OID 0)
-- Dependencies: 189
-- Name: mnu_task; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task FROM postgres;
GRANT ALL ON TABLE mnu_task TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task TO PUBLIC;


--
-- TOC entry 2236 (class 0 OID 0)
-- Dependencies: 190
-- Name: mnu_task_field; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task_field FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_field FROM postgres;
GRANT ALL ON TABLE mnu_task_field TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_field TO PUBLIC;


--
-- TOC entry 2237 (class 0 OID 0)
-- Dependencies: 191
-- Name: mnu_task_ip_address; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task_ip_address FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_ip_address FROM postgres;
GRANT ALL ON TABLE mnu_task_ip_address TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_ip_address TO PUBLIC;


--
-- TOC entry 2238 (class 0 OID 0)
-- Dependencies: 192
-- Name: mnu_todo; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_todo FROM PUBLIC;
REVOKE ALL ON TABLE mnu_todo FROM postgres;
GRANT ALL ON TABLE mnu_todo TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_todo TO PUBLIC;


--
-- TOC entry 2239 (class 0 OID 0)
-- Dependencies: 193
-- Name: mnu_user; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_user FROM PUBLIC;
REVOKE ALL ON TABLE mnu_user FROM postgres;
GRANT ALL ON TABLE mnu_user TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_user TO PUBLIC;


--
-- TOC entry 2240 (class 0 OID 0)
-- Dependencies: 194
-- Name: mnu_user_ip_address; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_user_ip_address FROM PUBLIC;
REVOKE ALL ON TABLE mnu_user_ip_address FROM postgres;
GRANT ALL ON TABLE mnu_user_ip_address TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_user_ip_address TO PUBLIC;


-- Completed on 2012-06-07 09:24:00

--
-- PostgreSQL database dump complete
--

