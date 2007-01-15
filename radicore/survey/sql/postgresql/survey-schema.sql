--
-- PostgreSQL database dump
--

-- Started on 2006-12-08 11:35:58

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 10 (class 2615 OID 17814)
-- Name: survey; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA survey;


ALTER SCHEMA survey OWNER TO postgres;

SET search_path = survey, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1450 (class 1259 OID 18233)
-- Dependencies: 1835 1836 1837 1838 1839 1840 1841 1842 10
-- Name: answer_option; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE answer_option (
    survey_id smallint DEFAULT (0)::smallint NOT NULL,
    section_id smallint DEFAULT (0)::smallint NOT NULL,
    question_id smallint DEFAULT (0)::smallint NOT NULL,
    answer_id smallint DEFAULT (0)::smallint NOT NULL,
    answer_seq smallint DEFAULT (0)::smallint NOT NULL,
    answer_text character varying(255) DEFAULT '0'::character varying NOT NULL,
    jumpto_section_seq smallint,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.answer_option OWNER TO postgres;

--
-- TOC entry 1451 (class 1259 OID 18243)
-- Dependencies: 1843 1844 1845 1846 10
-- Name: asset_type; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE asset_type (
    asset_type_id smallint DEFAULT (0)::smallint NOT NULL,
    asset_type_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    image_fname character varying(255),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.asset_type OWNER TO postgres;

--
-- TOC entry 1452 (class 1259 OID 18249)
-- Dependencies: 1847 1848 1849 1850 1851 10
-- Name: default_prompt; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE default_prompt (
    survey_id smallint DEFAULT (0)::smallint NOT NULL,
    prompt_id smallint DEFAULT (0)::smallint NOT NULL,
    prompt_desc character varying(30) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.default_prompt OWNER TO postgres;

--
-- TOC entry 1453 (class 1259 OID 18256)
-- Dependencies: 1852 1853 1854 10
-- Name: location_address; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE location_address (
    node_id smallint DEFAULT (0)::smallint NOT NULL,
    address_line1 character varying(80),
    address_line2 character varying(80),
    town character varying(80),
    county character varying(80),
    postcode character varying(10),
    country character varying(80),
    telephone character varying(20),
    fax character varying(20),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.location_address OWNER TO postgres;

--
-- TOC entry 1454 (class 1259 OID 18261)
-- Dependencies: 1855 1856 1857 1858 10
-- Name: location_type; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE location_type (
    location_type_id smallint DEFAULT (0)::smallint NOT NULL,
    location_type_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    image_fname character varying(255),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.location_type OWNER TO postgres;

--
-- TOC entry 1455 (class 1259 OID 18267)
-- Dependencies: 1859 1860 1861 1862 1863 1864 1865 10
-- Name: number_option; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE number_option (
    survey_id smallint DEFAULT (0)::smallint NOT NULL,
    section_id smallint DEFAULT (0)::smallint NOT NULL,
    question_id smallint DEFAULT (0)::smallint NOT NULL,
    min_value integer DEFAULT 0 NOT NULL,
    max_value integer DEFAULT 0,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.number_option OWNER TO postgres;

--
-- TOC entry 1456 (class 1259 OID 18276)
-- Dependencies: 1866 1867 1868 1869 10
-- Name: org_type; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE org_type (
    org_type_id smallint DEFAULT (0)::smallint NOT NULL,
    org_type_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    image_fname character varying(255),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.org_type OWNER TO postgres;

--
-- TOC entry 1457 (class 1259 OID 18282)
-- Dependencies: 1870 1871 1872 1873 1874 1875 10
-- Name: question_prompt; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE question_prompt (
    survey_id smallint DEFAULT (0)::smallint NOT NULL,
    section_id smallint DEFAULT (0)::smallint NOT NULL,
    question_id smallint DEFAULT (0)::smallint NOT NULL,
    prompt_id smallint DEFAULT (0)::smallint NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.question_prompt OWNER TO postgres;

--
-- TOC entry 1458 (class 1259 OID 18290)
-- Dependencies: 1876 1877 1878 1879 10
-- Name: risk_status; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE risk_status (
    risk_status_id smallint DEFAULT (0)::smallint NOT NULL,
    risk_status_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.risk_status OWNER TO postgres;

--
-- TOC entry 1459 (class 1259 OID 18296)
-- Dependencies: 1880 1881 1882 1883 10
-- Name: risk_weighting; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE risk_weighting (
    weighting_id smallint DEFAULT (0)::smallint NOT NULL,
    weighting_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.risk_weighting OWNER TO postgres;

--
-- TOC entry 1460 (class 1259 OID 18302)
-- Dependencies: 1884 1885 1886 1887 1888 1889 1890 1891 10
-- Name: survey_answer_dtl; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE survey_answer_dtl (
    survey_answer_id integer DEFAULT 0 NOT NULL,
    survey_id smallint DEFAULT (0)::smallint NOT NULL,
    section_id smallint DEFAULT (0)::smallint NOT NULL,
    question_id smallint DEFAULT (0)::smallint NOT NULL,
    answer_text character varying(255) DEFAULT ''::character varying NOT NULL,
    weighting_id smallint,
    measure_adequate character(1) DEFAULT ''::bpchar NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.survey_answer_dtl OWNER TO postgres;

--
-- TOC entry 1461 (class 1259 OID 18312)
-- Dependencies: 1892 1893 1894 1895 1896 1897 10
-- Name: survey_answer_hdr; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE survey_answer_hdr (
    survey_answer_id integer DEFAULT 0 NOT NULL,
    user_id character varying(16),
    answer_date date DEFAULT '2000-01-01'::date NOT NULL,
    survey_id smallint DEFAULT (0)::smallint NOT NULL,
    node_id smallint DEFAULT (0)::smallint NOT NULL,
    is_complete character(1) DEFAULT 'N'::bpchar NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.survey_answer_hdr OWNER TO postgres;

--
-- TOC entry 1462 (class 1259 OID 18320)
-- Dependencies: 1898 1899 1900 1901 1902 1903 10
-- Name: survey_hdr; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE survey_hdr (
    survey_id smallint DEFAULT (0)::smallint NOT NULL,
    survey_name character varying(80) DEFAULT ''::character varying NOT NULL,
    survey_long_name character varying(255) DEFAULT ''::character varying NOT NULL,
    survey_type_id character varying(4) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.survey_hdr OWNER TO postgres;

--
-- TOC entry 1463 (class 1259 OID 18328)
-- Dependencies: 1904 1905 1906 1907 1908 1909 1910 1911 1912 10
-- Name: survey_question; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE survey_question (
    survey_id smallint DEFAULT (0)::smallint NOT NULL,
    section_id smallint DEFAULT (0)::smallint NOT NULL,
    question_id smallint DEFAULT (0)::smallint NOT NULL,
    question_seq smallint DEFAULT (0)::smallint NOT NULL,
    question_text character varying(255) DEFAULT ''::character varying NOT NULL,
    answer_type character(1) DEFAULT ''::bpchar NOT NULL,
    advice_text text,
    risk_status_id smallint DEFAULT (0)::smallint NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.survey_question OWNER TO postgres;

--
-- TOC entry 1464 (class 1259 OID 18342)
-- Dependencies: 1913 1914 1915 1916 1917 1918 10
-- Name: survey_section; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE survey_section (
    survey_id smallint DEFAULT (0)::smallint NOT NULL,
    section_id smallint DEFAULT (0)::smallint NOT NULL,
    section_seq smallint DEFAULT (0)::smallint NOT NULL,
    section_name character varying(80) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.survey_section OWNER TO postgres;

--
-- TOC entry 1465 (class 1259 OID 18350)
-- Dependencies: 1919 1920 1921 1922 10
-- Name: survey_type; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE survey_type (
    survey_type_id character varying(4) DEFAULT ''::character varying NOT NULL,
    survey_type_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.survey_type OWNER TO postgres;

--
-- TOC entry 1466 (class 1259 OID 18356)
-- Dependencies: 1923 1924 1925 1926 1927 1928 10
-- Name: tree_node; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE tree_node (
    node_id smallint DEFAULT (0)::smallint NOT NULL,
    node_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    node_type character(1) DEFAULT ''::bpchar NOT NULL,
    node_depth smallint DEFAULT (0)::smallint NOT NULL,
    node_id_snr smallint,
    org_type_id smallint,
    location_type_id smallint,
    asset_type_id smallint,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.tree_node OWNER TO postgres;

--
-- TOC entry 1930 (class 2606 OID 18587)
-- Dependencies: 1450 1450 1450 1450 1450
-- Name: answer_option_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY answer_option
    ADD CONSTRAINT answer_option_pkey PRIMARY KEY (survey_id, section_id, question_id, answer_id);


--
-- TOC entry 1932 (class 2606 OID 18589)
-- Dependencies: 1451 1451
-- Name: asset_type_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY asset_type
    ADD CONSTRAINT asset_type_pkey PRIMARY KEY (asset_type_id);


--
-- TOC entry 1934 (class 2606 OID 18591)
-- Dependencies: 1452 1452 1452
-- Name: default_prompt_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY default_prompt
    ADD CONSTRAINT default_prompt_pkey PRIMARY KEY (survey_id, prompt_id);


--
-- TOC entry 1936 (class 2606 OID 18593)
-- Dependencies: 1453 1453
-- Name: location_address_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY location_address
    ADD CONSTRAINT location_address_pkey PRIMARY KEY (node_id);


--
-- TOC entry 1938 (class 2606 OID 18595)
-- Dependencies: 1454 1454
-- Name: location_type_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY location_type
    ADD CONSTRAINT location_type_pkey PRIMARY KEY (location_type_id);


--
-- TOC entry 1940 (class 2606 OID 18597)
-- Dependencies: 1455 1455 1455 1455
-- Name: number_option_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY number_option
    ADD CONSTRAINT number_option_pkey PRIMARY KEY (survey_id, section_id, question_id);


--
-- TOC entry 1942 (class 2606 OID 18599)
-- Dependencies: 1456 1456
-- Name: org_type_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY org_type
    ADD CONSTRAINT org_type_pkey PRIMARY KEY (org_type_id);


--
-- TOC entry 1944 (class 2606 OID 18601)
-- Dependencies: 1457 1457 1457 1457 1457
-- Name: question_prompt_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY question_prompt
    ADD CONSTRAINT question_prompt_pkey PRIMARY KEY (survey_id, section_id, question_id, prompt_id);


--
-- TOC entry 1946 (class 2606 OID 18603)
-- Dependencies: 1458 1458
-- Name: risk_status_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY risk_status
    ADD CONSTRAINT risk_status_pkey PRIMARY KEY (risk_status_id);


--
-- TOC entry 1948 (class 2606 OID 18605)
-- Dependencies: 1459 1459
-- Name: risk_weighting_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY risk_weighting
    ADD CONSTRAINT risk_weighting_pkey PRIMARY KEY (weighting_id);


--
-- TOC entry 1950 (class 2606 OID 18607)
-- Dependencies: 1460 1460 1460 1460 1460
-- Name: survey_answer_dtl_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY survey_answer_dtl
    ADD CONSTRAINT survey_answer_dtl_pkey PRIMARY KEY (survey_answer_id, survey_id, section_id, question_id);


--
-- TOC entry 1952 (class 2606 OID 18609)
-- Dependencies: 1461 1461
-- Name: survey_answer_hdr_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY survey_answer_hdr
    ADD CONSTRAINT survey_answer_hdr_pkey PRIMARY KEY (survey_answer_id);


--
-- TOC entry 1954 (class 2606 OID 18611)
-- Dependencies: 1462 1462
-- Name: survey_hdr_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY survey_hdr
    ADD CONSTRAINT survey_hdr_pkey PRIMARY KEY (survey_id);


--
-- TOC entry 1956 (class 2606 OID 18613)
-- Dependencies: 1463 1463 1463 1463
-- Name: survey_question_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY survey_question
    ADD CONSTRAINT survey_question_pkey PRIMARY KEY (survey_id, section_id, question_id);


--
-- TOC entry 1958 (class 2606 OID 18615)
-- Dependencies: 1464 1464 1464
-- Name: survey_section_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY survey_section
    ADD CONSTRAINT survey_section_pkey PRIMARY KEY (survey_id, section_id);


--
-- TOC entry 1960 (class 2606 OID 18617)
-- Dependencies: 1465 1465
-- Name: survey_type_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY survey_type
    ADD CONSTRAINT survey_type_pkey PRIMARY KEY (survey_type_id);


--
-- TOC entry 1962 (class 2606 OID 18619)
-- Dependencies: 1466 1466
-- Name: tree_node_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tree_node
    ADD CONSTRAINT tree_node_pkey PRIMARY KEY (node_id);


--
-- TOC entry 1965 (class 0 OID 0)
-- Dependencies: 10
-- Name: survey; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA survey FROM PUBLIC;
REVOKE ALL ON SCHEMA survey FROM postgres;
GRANT ALL ON SCHEMA survey TO postgres;
GRANT USAGE ON SCHEMA survey TO PUBLIC;


--
-- TOC entry 1966 (class 0 OID 0)
-- Dependencies: 1450
-- Name: answer_option; Type: ACL; Schema: survey; Owner: postgres
--

REVOKE ALL ON TABLE answer_option FROM PUBLIC;
REVOKE ALL ON TABLE answer_option FROM postgres;
GRANT ALL ON TABLE answer_option TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE answer_option TO PUBLIC;


--
-- TOC entry 1967 (class 0 OID 0)
-- Dependencies: 1451
-- Name: asset_type; Type: ACL; Schema: survey; Owner: postgres
--

REVOKE ALL ON TABLE asset_type FROM PUBLIC;
REVOKE ALL ON TABLE asset_type FROM postgres;
GRANT ALL ON TABLE asset_type TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE asset_type TO PUBLIC;


--
-- TOC entry 1968 (class 0 OID 0)
-- Dependencies: 1452
-- Name: default_prompt; Type: ACL; Schema: survey; Owner: postgres
--

REVOKE ALL ON TABLE default_prompt FROM PUBLIC;
REVOKE ALL ON TABLE default_prompt FROM postgres;
GRANT ALL ON TABLE default_prompt TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE default_prompt TO PUBLIC;


--
-- TOC entry 1969 (class 0 OID 0)
-- Dependencies: 1453
-- Name: location_address; Type: ACL; Schema: survey; Owner: postgres
--

REVOKE ALL ON TABLE location_address FROM PUBLIC;
REVOKE ALL ON TABLE location_address FROM postgres;
GRANT ALL ON TABLE location_address TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE location_address TO PUBLIC;


--
-- TOC entry 1970 (class 0 OID 0)
-- Dependencies: 1454
-- Name: location_type; Type: ACL; Schema: survey; Owner: postgres
--

REVOKE ALL ON TABLE location_type FROM PUBLIC;
REVOKE ALL ON TABLE location_type FROM postgres;
GRANT ALL ON TABLE location_type TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE location_type TO PUBLIC;


--
-- TOC entry 1971 (class 0 OID 0)
-- Dependencies: 1455
-- Name: number_option; Type: ACL; Schema: survey; Owner: postgres
--

REVOKE ALL ON TABLE number_option FROM PUBLIC;
REVOKE ALL ON TABLE number_option FROM postgres;
GRANT ALL ON TABLE number_option TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE number_option TO PUBLIC;


--
-- TOC entry 1972 (class 0 OID 0)
-- Dependencies: 1456
-- Name: org_type; Type: ACL; Schema: survey; Owner: postgres
--

REVOKE ALL ON TABLE org_type FROM PUBLIC;
REVOKE ALL ON TABLE org_type FROM postgres;
GRANT ALL ON TABLE org_type TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE org_type TO PUBLIC;


--
-- TOC entry 1973 (class 0 OID 0)
-- Dependencies: 1457
-- Name: question_prompt; Type: ACL; Schema: survey; Owner: postgres
--

REVOKE ALL ON TABLE question_prompt FROM PUBLIC;
REVOKE ALL ON TABLE question_prompt FROM postgres;
GRANT ALL ON TABLE question_prompt TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE question_prompt TO PUBLIC;


--
-- TOC entry 1974 (class 0 OID 0)
-- Dependencies: 1458
-- Name: risk_status; Type: ACL; Schema: survey; Owner: postgres
--

REVOKE ALL ON TABLE risk_status FROM PUBLIC;
REVOKE ALL ON TABLE risk_status FROM postgres;
GRANT ALL ON TABLE risk_status TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE risk_status TO PUBLIC;


--
-- TOC entry 1975 (class 0 OID 0)
-- Dependencies: 1459
-- Name: risk_weighting; Type: ACL; Schema: survey; Owner: postgres
--

REVOKE ALL ON TABLE risk_weighting FROM PUBLIC;
REVOKE ALL ON TABLE risk_weighting FROM postgres;
GRANT ALL ON TABLE risk_weighting TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE risk_weighting TO PUBLIC;


--
-- TOC entry 1976 (class 0 OID 0)
-- Dependencies: 1460
-- Name: survey_answer_dtl; Type: ACL; Schema: survey; Owner: postgres
--

REVOKE ALL ON TABLE survey_answer_dtl FROM PUBLIC;
REVOKE ALL ON TABLE survey_answer_dtl FROM postgres;
GRANT ALL ON TABLE survey_answer_dtl TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE survey_answer_dtl TO PUBLIC;


--
-- TOC entry 1977 (class 0 OID 0)
-- Dependencies: 1461
-- Name: survey_answer_hdr; Type: ACL; Schema: survey; Owner: postgres
--

REVOKE ALL ON TABLE survey_answer_hdr FROM PUBLIC;
REVOKE ALL ON TABLE survey_answer_hdr FROM postgres;
GRANT ALL ON TABLE survey_answer_hdr TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE survey_answer_hdr TO PUBLIC;


--
-- TOC entry 1978 (class 0 OID 0)
-- Dependencies: 1462
-- Name: survey_hdr; Type: ACL; Schema: survey; Owner: postgres
--

REVOKE ALL ON TABLE survey_hdr FROM PUBLIC;
REVOKE ALL ON TABLE survey_hdr FROM postgres;
GRANT ALL ON TABLE survey_hdr TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE survey_hdr TO PUBLIC;


--
-- TOC entry 1979 (class 0 OID 0)
-- Dependencies: 1463
-- Name: survey_question; Type: ACL; Schema: survey; Owner: postgres
--

REVOKE ALL ON TABLE survey_question FROM PUBLIC;
REVOKE ALL ON TABLE survey_question FROM postgres;
GRANT ALL ON TABLE survey_question TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE survey_question TO PUBLIC;


--
-- TOC entry 1980 (class 0 OID 0)
-- Dependencies: 1464
-- Name: survey_section; Type: ACL; Schema: survey; Owner: postgres
--

REVOKE ALL ON TABLE survey_section FROM PUBLIC;
REVOKE ALL ON TABLE survey_section FROM postgres;
GRANT ALL ON TABLE survey_section TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE survey_section TO PUBLIC;


--
-- TOC entry 1981 (class 0 OID 0)
-- Dependencies: 1465
-- Name: survey_type; Type: ACL; Schema: survey; Owner: postgres
--

REVOKE ALL ON TABLE survey_type FROM PUBLIC;
REVOKE ALL ON TABLE survey_type FROM postgres;
GRANT ALL ON TABLE survey_type TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE survey_type TO PUBLIC;


--
-- TOC entry 1982 (class 0 OID 0)
-- Dependencies: 1466
-- Name: tree_node; Type: ACL; Schema: survey; Owner: postgres
--

REVOKE ALL ON TABLE tree_node FROM PUBLIC;
REVOKE ALL ON TABLE tree_node FROM postgres;
GRANT ALL ON TABLE tree_node TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE tree_node TO PUBLIC;


-- Completed on 2006-12-08 11:35:59

--
-- PostgreSQL database dump complete
--

