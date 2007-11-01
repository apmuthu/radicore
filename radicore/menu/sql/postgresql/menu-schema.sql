--
-- PostgreSQL database dump
--

-- Started on 2007-09-17 17:23:19

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 8 (class 2615 OID 17812)
-- Name: menu; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA menu;


ALTER SCHEMA menu OWNER TO postgres;

SET search_path = menu, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1439 (class 1259 OID 18027)
-- Dependencies: 1865 1866 1867 8
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
-- TOC entry 1534 (class 1259 OID 28914)
-- Dependencies: 1938 1939 8
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
-- TOC entry 1533 (class 1259 OID 28912)
-- Dependencies: 1534 8
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
-- TOC entry 1985 (class 0 OID 0)
-- Dependencies: 1533
-- Name: mnu_account_rdcaccount_id_seq; Type: SEQUENCE OWNED BY; Schema: menu; Owner: postgres
--

ALTER SEQUENCE mnu_account_rdcaccount_id_seq OWNED BY mnu_account.rdcaccount_id;


--
-- TOC entry 1440 (class 1259 OID 18035)
-- Dependencies: 1868 1869 1870 1871 8
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
-- TOC entry 1521 (class 1259 OID 28288)
-- Dependencies: 1927 1928 1929 1930 1931 8
-- Name: mnu_initial_value_role; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
--

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


ALTER TABLE menu.mnu_initial_value_role OWNER TO postgres;

--
-- TOC entry 1522 (class 1259 OID 28298)
-- Dependencies: 1932 1933 1934 1935 1936 8
-- Name: mnu_initial_value_user; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
--

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


ALTER TABLE menu.mnu_initial_value_user OWNER TO postgres;

--
-- TOC entry 1441 (class 1259 OID 18041)
-- Dependencies: 1872 1873 1874 1875 1876 8
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
-- TOC entry 1442 (class 1259 OID 18048)
-- Dependencies: 1877 1878 1879 1880 1881 8
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
-- TOC entry 1443 (class 1259 OID 18055)
-- Dependencies: 1882 1883 1884 1885 8
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
-- TOC entry 1444 (class 1259 OID 18064)
-- Dependencies: 1886 1887 1888 1889 8
-- Name: mnu_role; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE TABLE mnu_role (
    role_id character varying(16) DEFAULT ''::character varying NOT NULL,
    role_desc character varying(30) DEFAULT ''::character varying NOT NULL,
    start_task_id character varying(80),
    global_access character(1),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE menu.mnu_role OWNER TO postgres;

--
-- TOC entry 1445 (class 1259 OID 18070)
-- Dependencies: 1890 1891 1892 1893 8
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
-- TOC entry 1446 (class 1259 OID 18076)
-- Dependencies: 1894 1895 1896 1897 1898 8
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
-- TOC entry 1447 (class 1259 OID 18083)
-- Dependencies: 1899 1900 1901 1902 8
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
-- TOC entry 1448 (class 1259 OID 18092)
-- Dependencies: 1903 1904 1905 1906 8
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
    initial_passthru character varying(40),
    selection_fixed character varying(255),
    selection_temp character varying(255),
    settings character varying(40),
    order_by character varying(255),
    keep_data character(1),
    log_sql_query character(1),
    screen_refresh smallint,
    use_https character(1),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE menu.mnu_task OWNER TO postgres;

--
-- TOC entry 1449 (class 1259 OID 18101)
-- Dependencies: 1907 1908 1909 1910 8
-- Name: mnu_task_field; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE TABLE mnu_task_field (
    task_id character varying(80) DEFAULT ''::character varying NOT NULL,
    field_id character varying(40) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE menu.mnu_task_field OWNER TO postgres;

--
-- TOC entry 1450 (class 1259 OID 18107)
-- Dependencies: 1911 1912 1913 1914 1915 1916 1917 8
-- Name: mnu_todo; Type: TABLE; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE TABLE mnu_todo (
    user_id character varying(16) DEFAULT ''::character varying NOT NULL,
    seq_no smallint DEFAULT (0)::smallint NOT NULL,
    item_desc character varying(80) DEFAULT ''::character varying NOT NULL,
    item_notes text,
    due_date date DEFAULT '2000-01-01'::date NOT NULL,
    is_complete character(1) DEFAULT 'N'::bpchar NOT NULL,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16),
    visibility smallint NOT NULL,
    repeat_interval numeric(3,0),
    repeat_unit character(1),
    task_id character varying(80),
    task_context character varying(255)
);


ALTER TABLE menu.mnu_todo OWNER TO postgres;

--
-- TOC entry 1451 (class 1259 OID 18119)
-- Dependencies: 1918 1919 1920 1921 1922 1923 1924 1925 1926 8
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
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16),
    rdcaccount_id integer
);


ALTER TABLE menu.mnu_user OWNER TO postgres;

--
-- TOC entry 1937 (class 2604 OID 28916)
-- Dependencies: 1533 1534 1534
-- Name: rdcaccount_id; Type: DEFAULT; Schema: menu; Owner: postgres
--

ALTER TABLE mnu_account ALTER COLUMN rdcaccount_id SET DEFAULT nextval('mnu_account_rdcaccount_id_seq'::regclass);


--
-- TOC entry 1941 (class 2606 OID 28040)
-- Dependencies: 1439 1439
-- Name: help_text_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY help_text
    ADD CONSTRAINT help_text_pkey PRIMARY KEY (task_id);


--
-- TOC entry 1979 (class 2606 OID 28920)
-- Dependencies: 1534 1534
-- Name: mnu_account_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_account
    ADD CONSTRAINT mnu_account_pkey PRIMARY KEY (rdcaccount_id);


--
-- TOC entry 1943 (class 2606 OID 18531)
-- Dependencies: 1440 1440 1440
-- Name: mnu_control_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_control
    ADD CONSTRAINT mnu_control_pkey PRIMARY KEY (record_id, field_id);


--
-- TOC entry 1974 (class 2606 OID 28296)
-- Dependencies: 1521 1521 1521 1521
-- Name: mnu_initial_value_role_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_initial_value_role
    ADD CONSTRAINT mnu_initial_value_role_pkey PRIMARY KEY (role_id, task_id, field_id);


--
-- TOC entry 1977 (class 2606 OID 28306)
-- Dependencies: 1522 1522 1522 1522
-- Name: mnu_initial_value_user_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_initial_value_user
    ADD CONSTRAINT mnu_initial_value_user_pkey PRIMARY KEY (user_id, task_id, field_id);


--
-- TOC entry 1945 (class 2606 OID 28063)
-- Dependencies: 1441 1441 1441
-- Name: mnu_menu_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_menu
    ADD CONSTRAINT mnu_menu_pkey PRIMARY KEY (menu_id, task_id_jnr);


--
-- TOC entry 1947 (class 2606 OID 28085)
-- Dependencies: 1442 1442 1442
-- Name: mnu_nav_button_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_nav_button
    ADD CONSTRAINT mnu_nav_button_pkey PRIMARY KEY (task_id_snr, task_id_jnr);


--
-- TOC entry 1949 (class 2606 OID 18537)
-- Dependencies: 1443 1443
-- Name: mnu_pattern_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_pattern
    ADD CONSTRAINT mnu_pattern_pkey PRIMARY KEY (pattern_id);


--
-- TOC entry 1951 (class 2606 OID 18539)
-- Dependencies: 1444 1444
-- Name: mnu_role_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_role
    ADD CONSTRAINT mnu_role_pkey PRIMARY KEY (role_id);


--
-- TOC entry 1953 (class 2606 OID 28103)
-- Dependencies: 1445 1445 1445
-- Name: mnu_role_task_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_role_task
    ADD CONSTRAINT mnu_role_task_pkey PRIMARY KEY (role_id, task_id);


--
-- TOC entry 1956 (class 2606 OID 28113)
-- Dependencies: 1446 1446 1446 1446
-- Name: mnu_role_taskfield_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_role_taskfield
    ADD CONSTRAINT mnu_role_taskfield_pkey PRIMARY KEY (role_id, task_id, field_id);


--
-- TOC entry 1958 (class 2606 OID 28014)
-- Dependencies: 1447 1447
-- Name: mnu_subsystem_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_subsystem
    ADD CONSTRAINT mnu_subsystem_pkey PRIMARY KEY (subsys_id);


--
-- TOC entry 1964 (class 2606 OID 28139)
-- Dependencies: 1449 1449 1449
-- Name: mnu_task_field_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_task_field
    ADD CONSTRAINT mnu_task_field_pkey PRIMARY KEY (task_id, field_id);


--
-- TOC entry 1962 (class 2606 OID 28124)
-- Dependencies: 1448 1448
-- Name: mnu_task_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_task
    ADD CONSTRAINT mnu_task_pkey PRIMARY KEY (task_id);


--
-- TOC entry 1966 (class 2606 OID 18551)
-- Dependencies: 1450 1450 1450
-- Name: mnu_todo_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_todo
    ADD CONSTRAINT mnu_todo_pkey PRIMARY KEY (user_id, seq_no);


--
-- TOC entry 1968 (class 2606 OID 18553)
-- Dependencies: 1451 1451
-- Name: mnu_user_email_addr_key; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_user
    ADD CONSTRAINT mnu_user_email_addr_key UNIQUE (email_addr);


--
-- TOC entry 1971 (class 2606 OID 18555)
-- Dependencies: 1451 1451
-- Name: mnu_user_pkey; Type: CONSTRAINT; Schema: menu; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY mnu_user
    ADD CONSTRAINT mnu_user_pkey PRIMARY KEY (user_id);


--
-- TOC entry 1972 (class 1259 OID 28297)
-- Dependencies: 1521
-- Name: mnu_initial_value_role_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_initial_value_role_index1 ON mnu_initial_value_role USING btree (task_id);


--
-- TOC entry 1975 (class 1259 OID 28307)
-- Dependencies: 1522
-- Name: mnu_initial_value_user_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_initial_value_user_index1 ON mnu_initial_value_user USING btree (task_id);


--
-- TOC entry 1954 (class 1259 OID 28277)
-- Dependencies: 1446
-- Name: mnu_role_taskfield_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_role_taskfield_index1 ON mnu_role_taskfield USING btree (task_id);


--
-- TOC entry 1959 (class 1259 OID 18658)
-- Dependencies: 1448
-- Name: mnu_task_index1; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_task_index1 ON mnu_task USING btree (pattern_id);


--
-- TOC entry 1960 (class 1259 OID 28025)
-- Dependencies: 1448
-- Name: mnu_task_index2; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_task_index2 ON mnu_task USING btree (subsys_id);


--
-- TOC entry 1969 (class 1259 OID 18660)
-- Dependencies: 1451
-- Name: mnu_user_index; Type: INDEX; Schema: menu; Owner: postgres; Tablespace: 
--

CREATE INDEX mnu_user_index ON mnu_user USING btree (role_id);

CREATE INDEX mnu_user_index2 ON mnu_user USING btree (rdcaccount_id);

--
-- TOC entry 1982 (class 0 OID 0)
-- Dependencies: 8
-- Name: menu; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA menu FROM PUBLIC;
REVOKE ALL ON SCHEMA menu FROM postgres;
GRANT ALL ON SCHEMA menu TO postgres;
GRANT USAGE ON SCHEMA menu TO PUBLIC;


--
-- TOC entry 1983 (class 0 OID 0)
-- Dependencies: 1439
-- Name: help_text; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE help_text FROM PUBLIC;
REVOKE ALL ON TABLE help_text FROM postgres;
GRANT ALL ON TABLE help_text TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE help_text TO PUBLIC;


--
-- TOC entry 1984 (class 0 OID 0)
-- Dependencies: 1534
-- Name: mnu_account; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_account FROM PUBLIC;
REVOKE ALL ON TABLE mnu_account FROM postgres;
GRANT ALL ON TABLE mnu_account TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_account TO PUBLIC;


--
-- TOC entry 1986 (class 0 OID 0)
-- Dependencies: 1440
-- Name: mnu_control; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_control FROM PUBLIC;
REVOKE ALL ON TABLE mnu_control FROM postgres;
GRANT ALL ON TABLE mnu_control TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_control TO PUBLIC;


--
-- TOC entry 1987 (class 0 OID 0)
-- Dependencies: 1521
-- Name: mnu_initial_value_role; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_initial_value_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_initial_value_role FROM postgres;
GRANT ALL ON TABLE mnu_initial_value_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_initial_value_role TO PUBLIC;


--
-- TOC entry 1988 (class 0 OID 0)
-- Dependencies: 1522
-- Name: mnu_initial_value_user; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_initial_value_user FROM PUBLIC;
REVOKE ALL ON TABLE mnu_initial_value_user FROM postgres;
GRANT ALL ON TABLE mnu_initial_value_user TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_initial_value_user TO PUBLIC;


--
-- TOC entry 1989 (class 0 OID 0)
-- Dependencies: 1441
-- Name: mnu_menu; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_menu FROM PUBLIC;
REVOKE ALL ON TABLE mnu_menu FROM postgres;
GRANT ALL ON TABLE mnu_menu TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_menu TO PUBLIC;


--
-- TOC entry 1990 (class 0 OID 0)
-- Dependencies: 1442
-- Name: mnu_nav_button; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_nav_button FROM PUBLIC;
REVOKE ALL ON TABLE mnu_nav_button FROM postgres;
GRANT ALL ON TABLE mnu_nav_button TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_nav_button TO PUBLIC;


--
-- TOC entry 1991 (class 0 OID 0)
-- Dependencies: 1443
-- Name: mnu_pattern; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_pattern FROM PUBLIC;
REVOKE ALL ON TABLE mnu_pattern FROM postgres;
GRANT ALL ON TABLE mnu_pattern TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_pattern TO PUBLIC;


--
-- TOC entry 1992 (class 0 OID 0)
-- Dependencies: 1444
-- Name: mnu_role; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_role FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role FROM postgres;
GRANT ALL ON TABLE mnu_role TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role TO PUBLIC;


--
-- TOC entry 1993 (class 0 OID 0)
-- Dependencies: 1445
-- Name: mnu_role_task; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_role_task FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role_task FROM postgres;
GRANT ALL ON TABLE mnu_role_task TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role_task TO PUBLIC;


--
-- TOC entry 1994 (class 0 OID 0)
-- Dependencies: 1446
-- Name: mnu_role_taskfield; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_role_taskfield FROM PUBLIC;
REVOKE ALL ON TABLE mnu_role_taskfield FROM postgres;
GRANT ALL ON TABLE mnu_role_taskfield TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_role_taskfield TO PUBLIC;


--
-- TOC entry 1995 (class 0 OID 0)
-- Dependencies: 1447
-- Name: mnu_subsystem; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_subsystem FROM PUBLIC;
REVOKE ALL ON TABLE mnu_subsystem FROM postgres;
GRANT ALL ON TABLE mnu_subsystem TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_subsystem TO PUBLIC;


--
-- TOC entry 1996 (class 0 OID 0)
-- Dependencies: 1448
-- Name: mnu_task; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task FROM postgres;
GRANT ALL ON TABLE mnu_task TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task TO PUBLIC;


--
-- TOC entry 1997 (class 0 OID 0)
-- Dependencies: 1449
-- Name: mnu_task_field; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_task_field FROM PUBLIC;
REVOKE ALL ON TABLE mnu_task_field FROM postgres;
GRANT ALL ON TABLE mnu_task_field TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_task_field TO PUBLIC;


--
-- TOC entry 1998 (class 0 OID 0)
-- Dependencies: 1450
-- Name: mnu_todo; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_todo FROM PUBLIC;
REVOKE ALL ON TABLE mnu_todo FROM postgres;
GRANT ALL ON TABLE mnu_todo TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_todo TO PUBLIC;


--
-- TOC entry 1999 (class 0 OID 0)
-- Dependencies: 1451
-- Name: mnu_user; Type: ACL; Schema: menu; Owner: postgres
--

REVOKE ALL ON TABLE mnu_user FROM PUBLIC;
REVOKE ALL ON TABLE mnu_user FROM postgres;
GRANT ALL ON TABLE mnu_user TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE mnu_user TO PUBLIC;


-- Completed on 2007-09-17 17:23:19

--
-- PostgreSQL database dump complete
--

