--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.0
-- Dumped by pg_dump version 9.1.0
-- Started on 2011-09-15 17:15:04

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 9 (class 2615 OID 17611)
-- Name: menu; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA menu;


ALTER SCHEMA menu OWNER TO postgres;

SET search_path = menu, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 193 (class 1259 OID 17976)
-- Dependencies: 2257 2258 2259 9
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
-- TOC entry 194 (class 1259 OID 17985)
-- Dependencies: 9
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
-- TOC entry 195 (class 1259 OID 17987)
-- Dependencies: 2260 2261 2262 9
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
-- TOC entry 196 (class 1259 OID 17993)
-- Dependencies: 2263 2264 2265 2266 9
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
-- TOC entry 197 (class 1259 OID 18000)
-- Dependencies: 2267 2268 2269 2270 2271 2272 2273 9
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
-- TOC entry 198 (class 1259 OID 18013)
-- Dependencies: 2274 2275 2276 2277 2278 2279 9
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
-- TOC entry 199 (class 1259 OID 18022)
-- Dependencies: 2280 2281 2282 2283 2284 2285 9
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
-- TOC entry 200 (class 1259 OID 18031)
-- Dependencies: 2286 2287 2288 2289 9
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
-- TOC entry 201 (class 1259 OID 18038)
-- Dependencies: 2290 2291 2292 2293 2294 9
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
-- TOC entry 202 (class 1259 OID 18046)
-- Dependencies: 2296 2297 2298 9
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
-- TOC entry 203 (class 1259 OID 18055)
-- Dependencies: 9 202
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
-- TOC entry 2418 (class 0 OID 0)
-- Dependencies: 203
-- Name: mnu_motd_motd_id_seq; Type: SEQUENCE OWNED BY; Schema: menu; Owner: postgres
--

ALTER SEQUENCE mnu_motd_motd_id_seq OWNED BY mnu_motd.motd_id;


--
-- TOC entry 204 (class 1259 OID 18057)
-- Dependencies: 2299 2300 2301 2302 2303 9
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
-- TOC entry 205 (class 1259 OID 18065)
-- Dependencies: 2304 2305 2306 2307 9
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
-- TOC entry 206 (class 1259 OID 18075)
-- Dependencies: 2308 2309 2310 2311 2312 2313 9
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
-- TOC entry 207 (class 1259 OID 18084)
-- Dependencies: 2314 2315 2316 2317 9
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
-- TOC entry 208 (class 1259 OID 18091)
-- Dependencies: 2318 2319 2320 2321 2322 9
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
-- TOC entry 209 (class 1259 OID 18099)
-- Dependencies: 2323 2324 2325 2326 9
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
-- TOC entry 210 (class 1259 OID 18109)
-- Dependencies: 2327 2328 2329 2330 9
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
-- TOC entry 211 (class 1259 OID 18119)
-- Dependencies: 2331 2332 2333 2334 9
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
-- TOC entry 212 (class 1259 OID 18126)
-- Dependencies: 2335 9
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
-- TOC entry 213 (class 1259 OID 18130)
-- Dependencies: 2336 2337 2338 2339 2340 2341 2342 9
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
-- TOC entry 214 (class 1259 OID 18143)
-- Dependencies: 2343 2344 2345 2346 2347 2348 2349 2350 2351 2352 9
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
-- TOC entry 215 (class 1259 OID 18159)
-- Dependencies: 2353 9
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
-- TOC entry 2295 (class 2604 OID 18490)
-- Dependencies: 203 202
-- Name: motd_id; Type: DEFAULT; Schema: menu; Owner: postgres
--

ALTER TABLE mnu_motd ALTER COLUMN motd_id SET DEFAULT nextval('mnu_motd_motd_id_seq'::regclass);


--
-- TOC entry 2355 (class 2606 OID 18539)
-- Dependencies: 193 193
-- Name: help_text_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY help_text
    ADD CONSTRAINT help_text_pkey PRIMARY KEY (task_id);


--
-- TOC entry 2357 (class 2606 OID 18541)
-- Dependencies: 195 195
-- Name: mnu_account_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_account
    ADD CONSTRAINT mnu_account_pkey PRIMARY KEY (rdcaccount_id);


--
-- TOC entry 2359 (class 2606 OID 18543)
-- Dependencies: 196 196 196
-- Name: mnu_control_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_control
    ADD CONSTRAINT mnu_control_pkey PRIMARY KEY (record_id, field_id);


--
-- TOC entry 2361 (class 2606 OID 18545)
-- Dependencies: 197 197 197
-- Name: mnu_favourite_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_favourite
    ADD CONSTRAINT mnu_favourite_pkey PRIMARY KEY (user_id, seq_no);


--
-- TOC entry 2364 (class 2606 OID 18547)
-- Dependencies: 198 198 198 198
-- Name: mnu_initial_value_role_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_initial_value_role
    ADD CONSTRAINT mnu_initial_value_role_pkey PRIMARY KEY (role_id, task_id, field_id);


--
-- TOC entry 2367 (class 2606 OID 18549)
-- Dependencies: 199 199 199 199
-- Name: mnu_initial_value_user_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_initial_value_user
    ADD CONSTRAINT mnu_initial_value_user_pkey PRIMARY KEY (user_id, task_id, field_id);


--
-- TOC entry 2369 (class 2606 OID 18551)
-- Dependencies: 200 200
-- Name: mnu_language_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_language
    ADD CONSTRAINT mnu_language_pkey PRIMARY KEY (language_id);


--
-- TOC entry 2371 (class 2606 OID 18553)
-- Dependencies: 201 201 201
-- Name: mnu_menu_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_menu
    ADD CONSTRAINT mnu_menu_pkey PRIMARY KEY (menu_id, task_id_jnr);


--
-- TOC entry 2375 (class 2606 OID 18555)
-- Dependencies: 204 204 204
-- Name: mnu_nav_button_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_nav_button
    ADD CONSTRAINT mnu_nav_button_pkey PRIMARY KEY (task_id_snr, task_id_jnr);


--
-- TOC entry 2377 (class 2606 OID 18557)
-- Dependencies: 205 205
-- Name: mnu_pattern_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_pattern
    ADD CONSTRAINT mnu_pattern_pkey PRIMARY KEY (pattern_id);


--
-- TOC entry 2379 (class 2606 OID 18559)
-- Dependencies: 206 206
-- Name: mnu_role_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_role
    ADD CONSTRAINT mnu_role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 2381 (class 2606 OID 18561)
-- Dependencies: 207 207 207
-- Name: mnu_role_task_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_role_task
    ADD CONSTRAINT mnu_role_task_pkey PRIMARY KEY (role_id, task_id);


--
-- TOC entry 2384 (class 2606 OID 18563)
-- Dependencies: 208 208 208 208
-- Name: mnu_role_taskfield_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_role_taskfield
    ADD CONSTRAINT mnu_role_taskfield_pkey PRIMARY KEY (role_id, task_id, field_id);


--
-- TOC entry 2386 (class 2606 OID 18565)
-- Dependencies: 209 209
-- Name: mnu_subsystem_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_subsystem
    ADD CONSTRAINT mnu_subsystem_pkey PRIMARY KEY (subsys_id);


--
-- TOC entry 2392 (class 2606 OID 18567)
-- Dependencies: 211 211 211
-- Name: mnu_task_field_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_task_field
    ADD CONSTRAINT mnu_task_field_pkey PRIMARY KEY (task_id, field_id);


--
-- TOC entry 2394 (class 2606 OID 18569)
-- Dependencies: 212 212 212
-- Name: mnu_task_ip_address_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_task_ip_address
    ADD CONSTRAINT mnu_task_ip_address_pkey PRIMARY KEY (task_id, ip_address);


--
-- TOC entry 2390 (class 2606 OID 18571)
-- Dependencies: 210 210
-- Name: mnu_task_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_task
    ADD CONSTRAINT mnu_task_pkey PRIMARY KEY (task_id);


--
-- TOC entry 2396 (class 2606 OID 18573)
-- Dependencies: 213 213 213
-- Name: mnu_todo_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_todo
    ADD CONSTRAINT mnu_todo_pkey PRIMARY KEY (user_id, seq_no);


--
-- TOC entry 2398 (class 2606 OID 18575)
-- Dependencies: 214 214
-- Name: mnu_user_email_addr_key; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_user
    ADD CONSTRAINT mnu_user_email_addr_key UNIQUE (email_addr);


--
-- TOC entry 2404 (class 2606 OID 18577)
-- Dependencies: 215 215 215
-- Name: mnu_user_ip_address_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_user_ip_address
    ADD CONSTRAINT mnu_user_ip_address_pkey PRIMARY KEY (user_id, ip_address);


--
-- TOC entry 2402 (class 2606 OID 18579)
-- Dependencies: 214 214
-- Name: mnu_user_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_user
    ADD CONSTRAINT mnu_user_pkey PRIMARY KEY (user_id);


--
-- TOC entry 2373 (class 2606 OID 18581)
-- Dependencies: 202 202
-- Name: motd_id; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_motd
    ADD CONSTRAINT motd_id PRIMARY KEY (motd_id);


--
-- TOC entry 2362 (class 1259 OID 18664)
-- Dependencies: 198
-- Name: mnu_initial_value_role_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_initial_value_role_index1 ON mnu_initial_value_role USING btree (task_id);


--
-- TOC entry 2365 (class 1259 OID 18665)
-- Dependencies: 199
-- Name: mnu_initial_value_user_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_initial_value_user_index1 ON mnu_initial_value_user USING btree (task_id);


--
-- TOC entry 2382 (class 1259 OID 18666)
-- Dependencies: 208
-- Name: mnu_role_taskfield_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_role_taskfield_index1 ON mnu_role_taskfield USING btree (task_id);


--
-- TOC entry 2387 (class 1259 OID 18667)
-- Dependencies: 210
-- Name: mnu_task_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_task_index1 ON mnu_task USING btree (pattern_id);


--
-- TOC entry 2388 (class 1259 OID 18668)
-- Dependencies: 210
-- Name: mnu_task_index2; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_task_index2 ON mnu_task USING btree (subsys_id);


--
-- TOC entry 2399 (class 1259 OID 18669)
-- Dependencies: 214
-- Name: mnu_user_index; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_user_index ON mnu_user USING btree (role_id);


--
-- TOC entry 2400 (class 1259 OID 18670)
-- Dependencies: 214
-- Name: mnu_user_index2; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_user_index2 ON mnu_user USING btree (rdcaccount_id);


--
-- TOC entry 2407 (class 0 OID 0)
-- Dependencies: 9
-- Name: menu; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA menu FROM PUBLIC;
REVOKE ALL ON SCHEMA menu FROM postgres;
GRANT ALL ON SCHEMA menu TO postgres;
GRANT USAGE ON SCHEMA menu TO PUBLIC;


--
-- TOC entry 2408 (class 0 OID 0)
-- Dependencies: 193
-- Name: help_text; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE help_text FROM PUBLIC;
REVOKE ALL ON TABLE help_text FROM postgres;
GRANT ALL ON TABLE help_text TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE help_text TO PUBLIC;


--
-- TOC entry 2409 (class 0 OID 0)
-- Dependencies: 194
-- Name: mnu_account_rdcaccount_id_seq; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON SEQUENCE mnu_account_rdcaccount_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE mnu_account_rdcaccount_id_seq FROM postgres;
GRANT ALL ON SEQUENCE mnu_account_rdcaccount_id_seq TO postgres;
GRANT ALL ON SEQUENCE mnu_account_rdcaccount_id_seq TO PUBLIC;


--
-- TOC entry 2410 (class 0 OID 0)
-- Dependencies: 195
-- Name: mnu_account; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_account FROM PUBLIC;
REVOKE ALL ON TABLE mnu_account FROM postgres;
GRANT ALL ON TABLE mnu_account TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_account TO PUBLIC;


--
-- TOC entry 2411 (class 0 OID 0)
-- Dependencies: 196
-- Name: mnu_control; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_control FROM PUBLIC;
REVOKE ALL ON TABLE mnu_control FROM postgres;
GRANT ALL ON TABLE mnu_control TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_control TO PUBLIC;


--
-- TOC entry 2412 (class 0 OID 0)
-- Dependencies: 197
-- Name: mnu_favourite; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_favourite FROM PUBLIC;
REVOKE ALL ON TABLE mnu_favourite FROM postgres;
GRANT ALL ON TABLE mnu_favourite TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_favourite TO PUBLIC;


--
-- TOC entry 2413 (class 0 OID 0)
-- Dependencies: 198
-- Name: mnu_initial_value_role; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_initial_value_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_initial_value_role FROM postgres;
GRANT ALL ON TABLE mnu_initial_value_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_initial_value_role TO PUBLIC;


--
-- TOC entry 2414 (class 0 OID 0)
-- Dependencies: 199
-- Name: mnu_initial_value_user; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_initial_value_user FROM PUBLIC;
REVOKE ALL ON TABLE mnu_initial_value_user FROM postgres;
GRANT ALL ON TABLE mnu_initial_value_user TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_initial_value_user TO PUBLIC;


--
-- TOC entry 2415 (class 0 OID 0)
-- Dependencies: 200
-- Name: mnu_language; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_language FROM PUBLIC;
REVOKE ALL ON TABLE mnu_language FROM postgres;
GRANT ALL ON TABLE mnu_language TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_language TO PUBLIC;


--
-- TOC entry 2416 (class 0 OID 0)
-- Dependencies: 201
-- Name: mnu_menu; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_menu FROM PUBLIC;
REVOKE ALL ON TABLE mnu_menu FROM postgres;
GRANT ALL ON TABLE mnu_menu TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_menu TO PUBLIC;


--
-- TOC entry 2417 (class 0 OID 0)
-- Dependencies: 202
-- Name: mnu_motd; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_motd FROM PUBLIC;
REVOKE ALL ON TABLE mnu_motd FROM postgres;
GRANT ALL ON TABLE mnu_motd TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_motd TO PUBLIC;


--
-- TOC entry 2419 (class 0 OID 0)
-- Dependencies: 203
-- Name: mnu_motd_motd_id_seq; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON SEQUENCE mnu_motd_motd_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE mnu_motd_motd_id_seq FROM postgres;
GRANT ALL ON SEQUENCE mnu_motd_motd_id_seq TO postgres;
GRANT ALL ON SEQUENCE mnu_motd_motd_id_seq TO PUBLIC;


--
-- TOC entry 2420 (class 0 OID 0)
-- Dependencies: 204
-- Name: mnu_nav_button; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_nav_button FROM PUBLIC;
REVOKE ALL ON TABLE mnu_nav_button FROM postgres;
GRANT ALL ON TABLE mnu_nav_button TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_nav_button TO PUBLIC;


--
-- TOC entry 2421 (class 0 OID 0)
-- Dependencies: 205
-- Name: mnu_pattern; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_pattern FROM PUBLIC;
REVOKE ALL ON TABLE mnu_pattern FROM postgres;
GRANT ALL ON TABLE mnu_pattern TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_pattern TO PUBLIC;


--
-- TOC entry 2422 (class 0 OID 0)
-- Dependencies: 206
-- Name: mnu_role; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role FROM postgres;
GRANT ALL ON TABLE mnu_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role TO PUBLIC;


--
-- TOC entry 2423 (class 0 OID 0)
-- Dependencies: 207
-- Name: mnu_role_task; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_role_task FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role_task FROM postgres;
GRANT ALL ON TABLE mnu_role_task TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role_task TO PUBLIC;


--
-- TOC entry 2424 (class 0 OID 0)
-- Dependencies: 208
-- Name: mnu_role_taskfield; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_role_taskfield FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role_taskfield FROM postgres;
GRANT ALL ON TABLE mnu_role_taskfield TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role_taskfield TO PUBLIC;


--
-- TOC entry 2425 (class 0 OID 0)
-- Dependencies: 209
-- Name: mnu_subsystem; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_subsystem FROM PUBLIC;
REVOKE ALL ON TABLE mnu_subsystem FROM postgres;
GRANT ALL ON TABLE mnu_subsystem TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_subsystem TO PUBLIC;


--
-- TOC entry 2426 (class 0 OID 0)
-- Dependencies: 210
-- Name: mnu_task; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task FROM postgres;
GRANT ALL ON TABLE mnu_task TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task TO PUBLIC;


--
-- TOC entry 2427 (class 0 OID 0)
-- Dependencies: 211
-- Name: mnu_task_field; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task_field FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_field FROM postgres;
GRANT ALL ON TABLE mnu_task_field TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_field TO PUBLIC;


--
-- TOC entry 2428 (class 0 OID 0)
-- Dependencies: 212
-- Name: mnu_task_ip_address; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task_ip_address FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_ip_address FROM postgres;
GRANT ALL ON TABLE mnu_task_ip_address TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_ip_address TO PUBLIC;


--
-- TOC entry 2429 (class 0 OID 0)
-- Dependencies: 213
-- Name: mnu_todo; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_todo FROM PUBLIC;
REVOKE ALL ON TABLE mnu_todo FROM postgres;
GRANT ALL ON TABLE mnu_todo TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_todo TO PUBLIC;


--
-- TOC entry 2430 (class 0 OID 0)
-- Dependencies: 214
-- Name: mnu_user; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_user FROM PUBLIC;
REVOKE ALL ON TABLE mnu_user FROM postgres;
GRANT ALL ON TABLE mnu_user TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_user TO PUBLIC;


--
-- TOC entry 2431 (class 0 OID 0)
-- Dependencies: 215
-- Name: mnu_user_ip_address; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_user_ip_address FROM PUBLIC;
REVOKE ALL ON TABLE mnu_user_ip_address FROM postgres;
GRANT ALL ON TABLE mnu_user_ip_address TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_user_ip_address TO PUBLIC;


-- Completed on 2011-09-15 17:15:06

--
-- PostgreSQL database dump complete
--

