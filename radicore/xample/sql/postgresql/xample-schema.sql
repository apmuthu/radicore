--
-- PostgreSQL database dump
--

-- Started on 2008-01-12 15:11:02

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 12 (class 2615 OID 17816)
-- Name: xample; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA xample;


ALTER SCHEMA xample OWNER TO postgres;

SET search_path = xample, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1497 (class 1259 OID 18418)
-- Dependencies: 12
-- Name: test_autoincrement; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE test_autoincrement (
    id serial NOT NULL,
    field1 character varying(40),
    field2 character varying(255),
    field3 bigint
);


ALTER TABLE xample.test_autoincrement OWNER TO postgres;

--
-- TOC entry 1496 (class 1259 OID 18416)
-- Dependencies: 12 1497
-- Name: test_autoincrement_id_seq; Type: SEQUENCE; Schema: xample; Owner: postgres
--

CREATE SEQUENCE test_autoincrement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE xample.test_autoincrement_id_seq OWNER TO postgres;

--
-- TOC entry 1983 (class 0 OID 0)
-- Dependencies: 1496
-- Name: test_autoincrement_id_seq; Type: SEQUENCE OWNED BY; Schema: xample; Owner: postgres
--

ALTER SEQUENCE test_autoincrement_id_seq OWNED BY test_autoincrement.id;


--
-- TOC entry 1498 (class 1259 OID 18421)
-- Dependencies: 1878 1879 1880 1881 12
-- Name: x_option; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_option (
    option_id character varying(8) DEFAULT ''::character varying NOT NULL,
    option_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_option OWNER TO postgres;

--
-- TOC entry 1543 (class 1259 OID 29209)
-- Dependencies: 1924 1925 1926 1927 1928 12
-- Name: x_option_alt; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_option_alt (
    option_id character varying(8) DEFAULT ''::character varying NOT NULL,
    language_id character varying(5) DEFAULT ''::character varying NOT NULL,
    option_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_option_alt OWNER TO postgres;

--
-- TOC entry 1499 (class 1259 OID 18427)
-- Dependencies: 1882 1883 1884 1885 12
-- Name: x_pers_opt_xref; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_pers_opt_xref (
    person_id character varying(8) DEFAULT ''::character varying NOT NULL,
    option_id character varying(8) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_pers_opt_xref OWNER TO postgres;

--
-- TOC entry 1500 (class 1259 OID 18433)
-- Dependencies: 1886 1887 1888 1889 12
-- Name: x_pers_type; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_pers_type (
    pers_type_id character varying(6) DEFAULT ''::character varying NOT NULL,
    pers_type_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_pers_type OWNER TO postgres;

--
-- TOC entry 1542 (class 1259 OID 29200)
-- Dependencies: 1919 1920 1921 1922 1923 12
-- Name: x_pers_type_alt; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_pers_type_alt (
    pers_type_id character varying(6) DEFAULT ''::character varying NOT NULL,
    language_id character varying(5) DEFAULT ''::character varying NOT NULL,
    pers_type_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_pers_type_alt OWNER TO postgres;

--
-- TOC entry 1526 (class 1259 OID 18977)
-- Dependencies: 1913 1914 1915 1916 1917 1918 12
-- Name: x_person; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_person (
    person_id character varying(8) DEFAULT ''::character varying NOT NULL,
    pers_type_id character varying(6) NOT NULL,
    node_id smallint NOT NULL,
    nat_ins_no character varying(10) NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(30) NOT NULL,
    initials character varying(6),
    star_sign character(3) NOT NULL,
    email_addr character varying(50),
    value1 smallint,
    value2 numeric(10,2),
    last_addr_no smallint DEFAULT (0)::smallint,
    start_date date DEFAULT '2000-01-01'::date NOT NULL,
    end_date date DEFAULT '9999-12-31'::date,
    picture character varying(40),
    favourite_food character varying(2)[],
    fckeditor_test text,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_person OWNER TO postgres;

--
-- TOC entry 1501 (class 1259 OID 18450)
-- Dependencies: 1890 1891 1892 1893 1894 1895 1896 12
-- Name: x_person_addr; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_person_addr (
    person_id character varying(8) DEFAULT ''::character varying NOT NULL,
    address_no smallint DEFAULT (0)::smallint NOT NULL,
    telephone_no character varying(20),
    fax_no character varying(20),
    addr_line_1 character varying(30) DEFAULT ''::character varying NOT NULL,
    addr_line_2 character varying(30),
    addr_line_3 character varying(30),
    town character varying(30),
    county character varying(30),
    postcode character varying(10),
    start_date date DEFAULT '2000-01-01'::date NOT NULL,
    end_date date DEFAULT '9999-12-31'::date,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_person_addr OWNER TO postgres;

--
-- TOC entry 1502 (class 1259 OID 18459)
-- Dependencies: 1897 1898 1899 1900 1901 1902 12
-- Name: x_tree_level; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_tree_level (
    tree_type_id character varying(8) DEFAULT ''::character varying NOT NULL,
    tree_level_id smallint DEFAULT (0)::smallint NOT NULL,
    tree_level_seq smallint DEFAULT (0)::smallint NOT NULL,
    tree_level_desc character varying(80) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_tree_level OWNER TO postgres;

--
-- TOC entry 1545 (class 1259 OID 29252)
-- Dependencies: 1934 1935 1936 1937 1938 1939 12
-- Name: x_tree_level_alt; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_tree_level_alt (
    tree_type_id character varying(8) DEFAULT ''::character varying NOT NULL,
    tree_level_id smallint DEFAULT (0)::smallint NOT NULL,
    language_id character varying(5) DEFAULT ''::character varying NOT NULL,
    tree_level_desc character varying(80) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_tree_level_alt OWNER TO postgres;

--
-- TOC entry 1503 (class 1259 OID 18467)
-- Dependencies: 1903 1904 1905 1906 1907 1908 12
-- Name: x_tree_node; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_tree_node (
    node_id smallint DEFAULT (0)::smallint NOT NULL,
    tree_type_id character varying(8) DEFAULT ''::character varying NOT NULL,
    tree_level_id smallint DEFAULT (0)::smallint NOT NULL,
    node_desc character varying(80) DEFAULT ''::character varying NOT NULL,
    node_id_snr smallint,
    external_code character varying(255),
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_tree_node OWNER TO postgres;

--
-- TOC entry 1546 (class 1259 OID 29262)
-- Dependencies: 1940 1941 1942 1943 1944 12
-- Name: x_tree_node_alt; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_tree_node_alt (
    node_id smallint DEFAULT (0)::smallint NOT NULL,
    language_id character varying(5) DEFAULT ''::character varying NOT NULL,
    node_desc character varying(80) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_tree_node_alt OWNER TO postgres;

--
-- TOC entry 1504 (class 1259 OID 18475)
-- Dependencies: 1909 1910 1911 1912 12
-- Name: x_tree_type; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_tree_type (
    tree_type_id character varying(8) DEFAULT ''::character varying NOT NULL,
    tree_type_desc character varying(80) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_tree_type OWNER TO postgres;

--
-- TOC entry 1544 (class 1259 OID 29243)
-- Dependencies: 1929 1930 1931 1932 1933 12
-- Name: x_tree_type_alt; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_tree_type_alt (
    tree_type_id character varying(8) DEFAULT ''::character varying NOT NULL,
    language_id character varying(5) DEFAULT ''::character varying NOT NULL,
    tree_type_desc character varying(80) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_tree_type_alt OWNER TO postgres;

--
-- TOC entry 1877 (class 2604 OID 18420)
-- Dependencies: 1497 1496 1497
-- Name: id; Type: DEFAULT; Schema: xample; Owner: postgres
--

ALTER TABLE test_autoincrement ALTER COLUMN id SET DEFAULT nextval('test_autoincrement_id_seq'::regclass);


--
-- TOC entry 1946 (class 2606 OID 18645)
-- Dependencies: 1497 1497
-- Name: test_autoincrement_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY test_autoincrement
    ADD CONSTRAINT test_autoincrement_pkey PRIMARY KEY (id);


--
-- TOC entry 1978 (class 2606 OID 29270)
-- Dependencies: 1546 1546 1546
-- Name: tree_node_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_tree_node_alt
    ADD CONSTRAINT tree_node_pkey PRIMARY KEY (node_id, language_id);


--
-- TOC entry 1972 (class 2606 OID 29217)
-- Dependencies: 1543 1543 1543
-- Name: x_option_alt_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_option_alt
    ADD CONSTRAINT x_option_alt_pkey PRIMARY KEY (option_id, language_id);


--
-- TOC entry 1948 (class 2606 OID 18653)
-- Dependencies: 1498 1498
-- Name: x_option_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_option
    ADD CONSTRAINT x_option_pkey PRIMARY KEY (option_id);


--
-- TOC entry 1951 (class 2606 OID 29221)
-- Dependencies: 1499 1499 1499
-- Name: x_pers_opt_xref_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_pers_opt_xref
    ADD CONSTRAINT x_pers_opt_xref_pkey PRIMARY KEY (person_id, option_id);


--
-- TOC entry 1970 (class 2606 OID 29219)
-- Dependencies: 1542 1542 1542
-- Name: x_pers_type_alt_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_pers_type_alt
    ADD CONSTRAINT x_pers_type_alt_pkey PRIMARY KEY (pers_type_id, language_id);


--
-- TOC entry 1953 (class 2606 OID 29223)
-- Dependencies: 1500 1500
-- Name: x_pers_type_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_pers_type
    ADD CONSTRAINT x_pers_type_pkey PRIMARY KEY (pers_type_id);


--
-- TOC entry 1955 (class 2606 OID 29229)
-- Dependencies: 1501 1501 1501
-- Name: x_person_addr_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_person_addr
    ADD CONSTRAINT x_person_addr_pkey PRIMARY KEY (person_id, address_no);


--
-- TOC entry 1966 (class 2606 OID 29227)
-- Dependencies: 1526 1526
-- Name: x_person_nat_ins_no_key; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_person
    ADD CONSTRAINT x_person_nat_ins_no_key UNIQUE (nat_ins_no);


--
-- TOC entry 1968 (class 2606 OID 29225)
-- Dependencies: 1526 1526
-- Name: x_person_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_person
    ADD CONSTRAINT x_person_pkey PRIMARY KEY (person_id);


--
-- TOC entry 1976 (class 2606 OID 29261)
-- Dependencies: 1545 1545 1545 1545
-- Name: x_tree_level_alt_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_tree_level_alt
    ADD CONSTRAINT x_tree_level_alt_pkey PRIMARY KEY (tree_type_id, tree_level_id, language_id);


--
-- TOC entry 1957 (class 2606 OID 29231)
-- Dependencies: 1502 1502 1502
-- Name: x_tree_level_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_tree_level
    ADD CONSTRAINT x_tree_level_pkey PRIMARY KEY (tree_type_id, tree_level_id);


--
-- TOC entry 1961 (class 2606 OID 29233)
-- Dependencies: 1503 1503
-- Name: x_tree_node_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_tree_node
    ADD CONSTRAINT x_tree_node_pkey PRIMARY KEY (node_id);


--
-- TOC entry 1974 (class 2606 OID 29251)
-- Dependencies: 1544 1544 1544
-- Name: x_tree_type_alt_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_tree_type_alt
    ADD CONSTRAINT x_tree_type_alt_pkey PRIMARY KEY (tree_type_id, language_id);


--
-- TOC entry 1963 (class 2606 OID 29235)
-- Dependencies: 1504 1504
-- Name: x_tree_type_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_tree_type
    ADD CONSTRAINT x_tree_type_pkey PRIMARY KEY (tree_type_id);


--
-- TOC entry 1949 (class 1259 OID 18669)
-- Dependencies: 1499
-- Name: pers_opt_xref_index; Type: INDEX; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE INDEX pers_opt_xref_index ON x_pers_opt_xref USING btree (option_id);


--
-- TOC entry 1958 (class 1259 OID 18671)
-- Dependencies: 1503 1503
-- Name: tree_node_index1; Type: INDEX; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE INDEX tree_node_index1 ON x_tree_node USING btree (tree_type_id, tree_level_id);


--
-- TOC entry 1959 (class 1259 OID 18672)
-- Dependencies: 1503
-- Name: tree_node_index2; Type: INDEX; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE INDEX tree_node_index2 ON x_tree_node USING btree (node_id_snr);


--
-- TOC entry 1964 (class 1259 OID 19900)
-- Dependencies: 1526
-- Name: x_person_idx1; Type: INDEX; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE INDEX x_person_idx1 ON x_person USING btree (pers_type_id);


--
-- TOC entry 1981 (class 0 OID 0)
-- Dependencies: 12
-- Name: xample; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA xample FROM PUBLIC;
REVOKE ALL ON SCHEMA xample FROM postgres;
GRANT ALL ON SCHEMA xample TO postgres;
GRANT USAGE ON SCHEMA xample TO PUBLIC;


--
-- TOC entry 1982 (class 0 OID 0)
-- Dependencies: 1497
-- Name: test_autoincrement; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE test_autoincrement FROM PUBLIC;
REVOKE ALL ON TABLE test_autoincrement FROM postgres;
GRANT ALL ON TABLE test_autoincrement TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE test_autoincrement TO PUBLIC;


--
-- TOC entry 1984 (class 0 OID 0)
-- Dependencies: 1496
-- Name: test_autoincrement_id_seq; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON SEQUENCE test_autoincrement_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE test_autoincrement_id_seq FROM postgres;
GRANT ALL ON SEQUENCE test_autoincrement_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE test_autoincrement_id_seq TO PUBLIC;


--
-- TOC entry 1985 (class 0 OID 0)
-- Dependencies: 1498
-- Name: x_option; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_option FROM PUBLIC;
REVOKE ALL ON TABLE x_option FROM postgres;
GRANT ALL ON TABLE x_option TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_option TO PUBLIC;


--
-- TOC entry 1986 (class 0 OID 0)
-- Dependencies: 1543
-- Name: x_option_alt; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_option_alt FROM PUBLIC;
REVOKE ALL ON TABLE x_option_alt FROM postgres;
GRANT ALL ON TABLE x_option_alt TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_option_alt TO PUBLIC;


--
-- TOC entry 1987 (class 0 OID 0)
-- Dependencies: 1499
-- Name: x_pers_opt_xref; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_pers_opt_xref FROM PUBLIC;
REVOKE ALL ON TABLE x_pers_opt_xref FROM postgres;
GRANT ALL ON TABLE x_pers_opt_xref TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_pers_opt_xref TO PUBLIC;


--
-- TOC entry 1988 (class 0 OID 0)
-- Dependencies: 1500
-- Name: x_pers_type; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_pers_type FROM PUBLIC;
REVOKE ALL ON TABLE x_pers_type FROM postgres;
GRANT ALL ON TABLE x_pers_type TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_pers_type TO PUBLIC;


--
-- TOC entry 1989 (class 0 OID 0)
-- Dependencies: 1542
-- Name: x_pers_type_alt; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_pers_type_alt FROM PUBLIC;
REVOKE ALL ON TABLE x_pers_type_alt FROM postgres;
GRANT ALL ON TABLE x_pers_type_alt TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_pers_type_alt TO PUBLIC;


--
-- TOC entry 1990 (class 0 OID 0)
-- Dependencies: 1526
-- Name: x_person; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_person FROM PUBLIC;
REVOKE ALL ON TABLE x_person FROM postgres;
GRANT ALL ON TABLE x_person TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_person TO PUBLIC;


--
-- TOC entry 1991 (class 0 OID 0)
-- Dependencies: 1501
-- Name: x_person_addr; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_person_addr FROM PUBLIC;
REVOKE ALL ON TABLE x_person_addr FROM postgres;
GRANT ALL ON TABLE x_person_addr TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_person_addr TO PUBLIC;


--
-- TOC entry 1992 (class 0 OID 0)
-- Dependencies: 1502
-- Name: x_tree_level; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_tree_level FROM PUBLIC;
REVOKE ALL ON TABLE x_tree_level FROM postgres;
GRANT ALL ON TABLE x_tree_level TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_tree_level TO PUBLIC;


--
-- TOC entry 1993 (class 0 OID 0)
-- Dependencies: 1545
-- Name: x_tree_level_alt; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_tree_level_alt FROM PUBLIC;
REVOKE ALL ON TABLE x_tree_level_alt FROM postgres;
GRANT ALL ON TABLE x_tree_level_alt TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_tree_level_alt TO PUBLIC;


--
-- TOC entry 1994 (class 0 OID 0)
-- Dependencies: 1503
-- Name: x_tree_node; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_tree_node FROM PUBLIC;
REVOKE ALL ON TABLE x_tree_node FROM postgres;
GRANT ALL ON TABLE x_tree_node TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_tree_node TO PUBLIC;


--
-- TOC entry 1995 (class 0 OID 0)
-- Dependencies: 1546
-- Name: x_tree_node_alt; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_tree_node_alt FROM PUBLIC;
REVOKE ALL ON TABLE x_tree_node_alt FROM postgres;
GRANT ALL ON TABLE x_tree_node_alt TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_tree_node_alt TO PUBLIC;


--
-- TOC entry 1996 (class 0 OID 0)
-- Dependencies: 1504
-- Name: x_tree_type; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_tree_type FROM PUBLIC;
REVOKE ALL ON TABLE x_tree_type FROM postgres;
GRANT ALL ON TABLE x_tree_type TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_tree_type TO PUBLIC;


--
-- TOC entry 1997 (class 0 OID 0)
-- Dependencies: 1544
-- Name: x_tree_type_alt; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_tree_type_alt FROM PUBLIC;
REVOKE ALL ON TABLE x_tree_type_alt FROM postgres;
GRANT ALL ON TABLE x_tree_type_alt TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_tree_type_alt TO PUBLIC;


-- Completed on 2008-01-12 15:11:03

--
-- PostgreSQL database dump complete
--

