--
-- PostgreSQL database dump
--

-- Started on 2007-01-09 18:16:21

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
-- TOC entry 1475 (class 1259 OID 18418)
-- Dependencies: 12
-- Name: test_autoincrement; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE test_autoincrement (
    id integer NOT NULL,
    field1 character varying(40),
    field2 character varying(255),
    field3 bigint
);


ALTER TABLE xample.test_autoincrement OWNER TO postgres;

--
-- TOC entry 1474 (class 1259 OID 18416)
-- Dependencies: 1475 12
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
-- TOC entry 1905 (class 0 OID 0)
-- Dependencies: 1474
-- Name: test_autoincrement_id_seq; Type: SEQUENCE OWNED BY; Schema: xample; Owner: postgres
--

ALTER SEQUENCE test_autoincrement_id_seq OWNED BY test_autoincrement.id;


--
-- TOC entry 1476 (class 1259 OID 18421)
-- Dependencies: 1836 1837 1838 1839 12
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
-- TOC entry 1477 (class 1259 OID 18427)
-- Dependencies: 1840 1841 1842 1843 12
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
-- TOC entry 1478 (class 1259 OID 18433)
-- Dependencies: 1844 1845 1846 1847 12
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
-- TOC entry 1504 (class 1259 OID 18977)
-- Dependencies: 1871 1872 1873 1874 1875 1876 12
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
-- TOC entry 1479 (class 1259 OID 18450)
-- Dependencies: 1848 1849 1850 1851 1852 1853 1854 12
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
-- TOC entry 1480 (class 1259 OID 18459)
-- Dependencies: 1855 1856 1857 1858 1859 1860 12
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
-- TOC entry 1481 (class 1259 OID 18467)
-- Dependencies: 1861 1862 1863 1864 1865 1866 12
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
-- TOC entry 1482 (class 1259 OID 18475)
-- Dependencies: 1867 1868 1869 1870 12
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
-- TOC entry 1835 (class 2604 OID 18420)
-- Dependencies: 1474 1475 1475
-- Name: id; Type: DEFAULT; Schema: xample; Owner: postgres
--

ALTER TABLE test_autoincrement ALTER COLUMN id SET DEFAULT nextval('test_autoincrement_id_seq'::regclass);


--
-- TOC entry 1883 (class 2606 OID 18635)
-- Dependencies: 1477 1477 1477
-- Name: pers_opt_xref_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_pers_opt_xref
    ADD CONSTRAINT pers_opt_xref_pkey PRIMARY KEY (person_id, option_id);


--
-- TOC entry 1885 (class 2606 OID 18637)
-- Dependencies: 1478 1478
-- Name: pers_type_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_pers_type
    ADD CONSTRAINT pers_type_pkey PRIMARY KEY (pers_type_id);


--
-- TOC entry 1887 (class 2606 OID 18639)
-- Dependencies: 1479 1479 1479
-- Name: person_addr_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_person_addr
    ADD CONSTRAINT person_addr_pkey PRIMARY KEY (person_id, address_no);


--
-- TOC entry 1897 (class 2606 OID 18989)
-- Dependencies: 1504 1504
-- Name: person_nat_ins_no_key; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_person
    ADD CONSTRAINT person_nat_ins_no_key UNIQUE (nat_ins_no);


--
-- TOC entry 1899 (class 2606 OID 18991)
-- Dependencies: 1504 1504
-- Name: person_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_person
    ADD CONSTRAINT person_pkey PRIMARY KEY (person_id);


--
-- TOC entry 1878 (class 2606 OID 18645)
-- Dependencies: 1475 1475
-- Name: test_autoincrement_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY test_autoincrement
    ADD CONSTRAINT test_autoincrement_pkey PRIMARY KEY (id);


--
-- TOC entry 1889 (class 2606 OID 18647)
-- Dependencies: 1480 1480 1480
-- Name: tree_level_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_tree_level
    ADD CONSTRAINT tree_level_pkey PRIMARY KEY (tree_type_id, tree_level_id);


--
-- TOC entry 1893 (class 2606 OID 18649)
-- Dependencies: 1481 1481
-- Name: tree_node_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_tree_node
    ADD CONSTRAINT tree_node_pkey PRIMARY KEY (node_id);


--
-- TOC entry 1895 (class 2606 OID 18651)
-- Dependencies: 1482 1482
-- Name: tree_type_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_tree_type
    ADD CONSTRAINT tree_type_pkey PRIMARY KEY (tree_type_id);


--
-- TOC entry 1880 (class 2606 OID 18653)
-- Dependencies: 1476 1476
-- Name: x_option_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_option
    ADD CONSTRAINT x_option_pkey PRIMARY KEY (option_id);


--
-- TOC entry 1881 (class 1259 OID 18669)
-- Dependencies: 1477
-- Name: pers_opt_xref_index; Type: INDEX; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE INDEX pers_opt_xref_index ON x_pers_opt_xref USING btree (option_id);


--
-- TOC entry 1890 (class 1259 OID 18671)
-- Dependencies: 1481 1481
-- Name: tree_node_index1; Type: INDEX; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE INDEX tree_node_index1 ON x_tree_node USING btree (tree_type_id, tree_level_id);


--
-- TOC entry 1891 (class 1259 OID 18672)
-- Dependencies: 1481
-- Name: tree_node_index2; Type: INDEX; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE INDEX tree_node_index2 ON x_tree_node USING btree (node_id_snr);


--
-- TOC entry 1900 (class 1259 OID 19900)
-- Dependencies: 1504
-- Name: x_person_index1; Type: INDEX; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE INDEX x_person_index1 ON x_person USING btree (pers_type_id);


--
-- TOC entry 1903 (class 0 OID 0)
-- Dependencies: 12
-- Name: xample; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA xample FROM PUBLIC;
REVOKE ALL ON SCHEMA xample FROM postgres;
GRANT ALL ON SCHEMA xample TO postgres;
GRANT USAGE ON SCHEMA xample TO PUBLIC;


--
-- TOC entry 1904 (class 0 OID 0)
-- Dependencies: 1475
-- Name: test_autoincrement; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE test_autoincrement FROM PUBLIC;
REVOKE ALL ON TABLE test_autoincrement FROM postgres;
GRANT ALL ON TABLE test_autoincrement TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE test_autoincrement TO PUBLIC;


--
-- TOC entry 1906 (class 0 OID 0)
-- Dependencies: 1474
-- Name: test_autoincrement_id_seq; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON SEQUENCE test_autoincrement_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE test_autoincrement_id_seq FROM postgres;
GRANT ALL ON SEQUENCE test_autoincrement_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE test_autoincrement_id_seq TO PUBLIC;


--
-- TOC entry 1907 (class 0 OID 0)
-- Dependencies: 1476
-- Name: x_option; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_option FROM PUBLIC;
REVOKE ALL ON TABLE x_option FROM postgres;
GRANT ALL ON TABLE x_option TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_option TO PUBLIC;


--
-- TOC entry 1908 (class 0 OID 0)
-- Dependencies: 1477
-- Name: x_pers_opt_xref; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_pers_opt_xref FROM PUBLIC;
REVOKE ALL ON TABLE x_pers_opt_xref FROM postgres;
GRANT ALL ON TABLE x_pers_opt_xref TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_pers_opt_xref TO PUBLIC;


--
-- TOC entry 1909 (class 0 OID 0)
-- Dependencies: 1478
-- Name: x_pers_type; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_pers_type FROM PUBLIC;
REVOKE ALL ON TABLE x_pers_type FROM postgres;
GRANT ALL ON TABLE x_pers_type TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_pers_type TO PUBLIC;


--
-- TOC entry 1910 (class 0 OID 0)
-- Dependencies: 1504
-- Name: x_person; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_person FROM PUBLIC;
REVOKE ALL ON TABLE x_person FROM postgres;
GRANT ALL ON TABLE x_person TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_person TO PUBLIC;


--
-- TOC entry 1911 (class 0 OID 0)
-- Dependencies: 1479
-- Name: x_person_addr; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_person_addr FROM PUBLIC;
REVOKE ALL ON TABLE x_person_addr FROM postgres;
GRANT ALL ON TABLE x_person_addr TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_person_addr TO PUBLIC;


--
-- TOC entry 1912 (class 0 OID 0)
-- Dependencies: 1480
-- Name: x_tree_level; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_tree_level FROM PUBLIC;
REVOKE ALL ON TABLE x_tree_level FROM postgres;
GRANT ALL ON TABLE x_tree_level TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_tree_level TO PUBLIC;


--
-- TOC entry 1913 (class 0 OID 0)
-- Dependencies: 1481
-- Name: x_tree_node; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_tree_node FROM PUBLIC;
REVOKE ALL ON TABLE x_tree_node FROM postgres;
GRANT ALL ON TABLE x_tree_node TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_tree_node TO PUBLIC;


--
-- TOC entry 1914 (class 0 OID 0)
-- Dependencies: 1482
-- Name: x_tree_type; Type: ACL; Schema: xample; Owner: postgres
--

REVOKE ALL ON TABLE x_tree_type FROM PUBLIC;
REVOKE ALL ON TABLE x_tree_type FROM postgres;
GRANT ALL ON TABLE x_tree_type TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE x_tree_type TO PUBLIC;


-- Completed on 2007-01-09 18:16:23

--
-- PostgreSQL database dump complete
--

