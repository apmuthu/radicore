--
-- PostgreSQL database dump
--

-- Started on 2006-12-15 22:50:18

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 13 (class 2615 OID 18785)
-- Name: dict; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA dict;


ALTER SCHEMA dict OWNER TO postgres;

SET search_path = dict, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1483 (class 1259 OID 18786)
-- Dependencies: 1835 1836 1837 1838 1839 1840 1841 1842 1843 1844 1845 1846 1847 1848 1849 1850 1851 1852 1853 13
-- Name: dict_column; Type: TABLE; Schema: dict; Owner: postgres; Tablespace: 
--

CREATE TABLE dict_column (
    database_id character varying(64) DEFAULT ''::character varying NOT NULL,
    table_id character varying(64) DEFAULT ''::character varying NOT NULL,
    column_id character varying(64) DEFAULT ''::character varying NOT NULL,
    column_seq smallint DEFAULT (0)::smallint NOT NULL,
    column_desc character varying(255) DEFAULT ''::character varying NOT NULL,
    col_comment text,
    col_type character varying(20) DEFAULT ''::character varying NOT NULL,
    col_type_native character varying(32) DEFAULT ''::character varying NOT NULL,
    col_array_type character varying(20),
    col_values text,
    user_size bigint,
    col_maxsize bigint,
    col_null character(1) DEFAULT 'Y'::bpchar NOT NULL,
    is_required character(1) DEFAULT 'N'::bpchar NOT NULL,
    col_key character(3),
    col_default character varying(40),
    col_auto_increment character(1) DEFAULT 'N'::bpchar NOT NULL,
    col_unsigned character(1) DEFAULT 'N'::bpchar NOT NULL,
    col_zerofill_bwz character(3),
    col_precision smallint,
    col_scale smallint,
    col_minvalue double precision,
    col_maxvalue double precision,
    user_minvalue double precision,
    user_maxvalue double precision,
    noedit_nodisplay character(3),
    no_search character(3),
    no_audit character(3),
    upper_lowercase character varying(5),
    is_password character(1) DEFAULT 'N'::bpchar NOT NULL,
    auto_insert character(1) DEFAULT 'N'::bpchar NOT NULL,
    auto_update character(1) DEFAULT 'N'::bpchar NOT NULL,
    infinityisnull character(1) DEFAULT 'N'::bpchar NOT NULL,
    col_subtype character varying(10),
    image_width smallint,
    image_height smallint,
    is_boolean character(1) DEFAULT 'N'::bpchar NOT NULL,
    boolean_true character varying(4),
    boolean_false character varying(4),
    control character varying(10),
    optionlist character varying(64),
    checkbox_label character varying(64),
    task_id character varying(64),
    foreign_field character varying(64),
    align_hv character(1),
    align_lr character(1),
    multi_cols smallint,
    multi_rows smallint,
    custom_validation character varying(255),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE dict.dict_column OWNER TO postgres;

--
-- TOC entry 1484 (class 1259 OID 18810)
-- Dependencies: 1854 1855 1856 1857 1858 13
-- Name: dict_database; Type: TABLE; Schema: dict; Owner: postgres; Tablespace: 
--

CREATE TABLE dict_database (
    database_id character varying(64) DEFAULT ''::character varying NOT NULL,
    database_desc character varying(255) DEFAULT ''::character varying NOT NULL,
    db_comment text,
    subsys_id character varying(8) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE dict.dict_database OWNER TO postgres;

--
-- TOC entry 1485 (class 1259 OID 18820)
-- Dependencies: 1859 1860 1861 1862 1863 1864 1865 1866 1867 13
-- Name: dict_related_column; Type: TABLE; Schema: dict; Owner: postgres; Tablespace: 
--

CREATE TABLE dict_related_column (
    database_id_snr character varying(64) DEFAULT ''::character varying NOT NULL,
    table_id_snr character varying(64) DEFAULT ''::character varying NOT NULL,
    column_id_snr character varying(64) DEFAULT ''::character varying NOT NULL,
    database_id_jnr character varying(64) DEFAULT ''::character varying NOT NULL,
    table_id_jnr character varying(64) DEFAULT ''::character varying NOT NULL,
    seq_no smallint DEFAULT (0)::smallint NOT NULL,
    column_id_jnr character varying(64),
    seq_in_index smallint DEFAULT (0)::smallint NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE dict.dict_related_column OWNER TO postgres;

--
-- TOC entry 1486 (class 1259 OID 18831)
-- Dependencies: 1868 1869 1870 1871 1872 1873 1874 1875 13
-- Name: dict_relationship; Type: TABLE; Schema: dict; Owner: postgres; Tablespace: 
--

CREATE TABLE dict_relationship (
    database_id_snr character varying(64) DEFAULT ''::character varying NOT NULL,
    table_id_snr character varying(64) DEFAULT ''::character varying NOT NULL,
    database_id_jnr character varying(64) DEFAULT ''::character varying NOT NULL,
    table_id_jnr character varying(64) DEFAULT ''::character varying NOT NULL,
    seq_no smallint DEFAULT (0)::smallint NOT NULL,
    table_alias_snr character varying(64),
    table_alias_jnr character varying(64),
    relation_desc character varying(255),
    rel_comment text,
    rel_type character(3) DEFAULT ''::bpchar NOT NULL,
    orderby character varying(64),
    parent_field character varying(64),
    calc_field character varying(255),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE dict.dict_relationship OWNER TO postgres;

--
-- TOC entry 1487 (class 1259 OID 18844)
-- Dependencies: 1876 1877 1878 1879 1880 1881 13
-- Name: dict_table; Type: TABLE; Schema: dict; Owner: postgres; Tablespace: 
--

CREATE TABLE dict_table (
    database_id character varying(64) DEFAULT ''::character varying NOT NULL,
    table_id character varying(64) DEFAULT ''::character varying NOT NULL,
    table_desc character varying(255) DEFAULT ''::character varying NOT NULL,
    tbl_comment text,
    audit_logging character(1) DEFAULT 'Y'::bpchar NOT NULL,
    default_orderby character varying(64),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE dict.dict_table OWNER TO postgres;

--
-- TOC entry 1488 (class 1259 OID 18855)
-- Dependencies: 1882 1883 1884 1885 1886 1887 1888 1889 13
-- Name: dict_table_key; Type: TABLE; Schema: dict; Owner: postgres; Tablespace: 
--

CREATE TABLE dict_table_key (
    database_id character varying(64) DEFAULT ''::character varying NOT NULL,
    table_id character varying(64) DEFAULT ''::character varying NOT NULL,
    key_name character varying(64) DEFAULT ''::character varying NOT NULL,
    column_id character varying(64) DEFAULT ''::character varying NOT NULL,
    seq_in_index smallint DEFAULT (0)::smallint NOT NULL,
    is_unique character(1) DEFAULT 'N'::bpchar NOT NULL,
    column_seq smallint,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE dict.dict_table_key OWNER TO postgres;

--
-- TOC entry 1891 (class 2606 OID 18866)
-- Dependencies: 1483 1483 1483 1483
-- Name: dict_column_pkey; Type: CONSTRAINT; Schema: dict; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dict_column
    ADD CONSTRAINT dict_column_pkey PRIMARY KEY (database_id, table_id, column_id);


--
-- TOC entry 1893 (class 2606 OID 18868)
-- Dependencies: 1484 1484
-- Name: dict_database_pkey; Type: CONSTRAINT; Schema: dict; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dict_database
    ADD CONSTRAINT dict_database_pkey PRIMARY KEY (database_id);


--
-- TOC entry 1895 (class 2606 OID 18870)
-- Dependencies: 1485 1485 1485 1485 1485 1485 1485
-- Name: dict_related_column_pkey; Type: CONSTRAINT; Schema: dict; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dict_related_column
    ADD CONSTRAINT dict_related_column_pkey PRIMARY KEY (database_id_snr, table_id_snr, column_id_snr, database_id_jnr, table_id_jnr, seq_no);


--
-- TOC entry 1897 (class 2606 OID 18872)
-- Dependencies: 1486 1486 1486 1486 1486 1486
-- Name: dict_relationship_pkey; Type: CONSTRAINT; Schema: dict; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dict_relationship
    ADD CONSTRAINT dict_relationship_pkey PRIMARY KEY (database_id_snr, table_id_snr, database_id_jnr, table_id_jnr, seq_no);


--
-- TOC entry 1901 (class 2606 OID 18874)
-- Dependencies: 1488 1488 1488 1488 1488
-- Name: dict_table_key_pkey; Type: CONSTRAINT; Schema: dict; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dict_table_key
    ADD CONSTRAINT dict_table_key_pkey PRIMARY KEY (database_id, table_id, key_name, column_id);


--
-- TOC entry 1899 (class 2606 OID 18876)
-- Dependencies: 1487 1487 1487
-- Name: dict_table_pkey; Type: CONSTRAINT; Schema: dict; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dict_table
    ADD CONSTRAINT dict_table_pkey PRIMARY KEY (database_id, table_id);


--
-- TOC entry 1904 (class 0 OID 0)
-- Dependencies: 13
-- Name: dict; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA dict FROM PUBLIC;
REVOKE ALL ON SCHEMA dict FROM postgres;
GRANT ALL ON SCHEMA dict TO postgres;
GRANT USAGE ON SCHEMA dict TO PUBLIC;


--
-- TOC entry 1905 (class 0 OID 0)
-- Dependencies: 1483
-- Name: dict_column; Type: ACL; Schema: dict; Owner: postgres
--

REVOKE ALL ON TABLE dict_column FROM PUBLIC;
REVOKE ALL ON TABLE dict_column FROM postgres;
GRANT ALL ON TABLE dict_column TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE dict_column TO PUBLIC;


--
-- TOC entry 1906 (class 0 OID 0)
-- Dependencies: 1484
-- Name: dict_database; Type: ACL; Schema: dict; Owner: postgres
--

REVOKE ALL ON TABLE dict_database FROM PUBLIC;
REVOKE ALL ON TABLE dict_database FROM postgres;
GRANT ALL ON TABLE dict_database TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE dict_database TO PUBLIC;


--
-- TOC entry 1907 (class 0 OID 0)
-- Dependencies: 1485
-- Name: dict_related_column; Type: ACL; Schema: dict; Owner: postgres
--

REVOKE ALL ON TABLE dict_related_column FROM PUBLIC;
REVOKE ALL ON TABLE dict_related_column FROM postgres;
GRANT ALL ON TABLE dict_related_column TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE dict_related_column TO PUBLIC;


--
-- TOC entry 1908 (class 0 OID 0)
-- Dependencies: 1486
-- Name: dict_relationship; Type: ACL; Schema: dict; Owner: postgres
--

REVOKE ALL ON TABLE dict_relationship FROM PUBLIC;
REVOKE ALL ON TABLE dict_relationship FROM postgres;
GRANT ALL ON TABLE dict_relationship TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE dict_relationship TO PUBLIC;


--
-- TOC entry 1909 (class 0 OID 0)
-- Dependencies: 1487
-- Name: dict_table; Type: ACL; Schema: dict; Owner: postgres
--

REVOKE ALL ON TABLE dict_table FROM PUBLIC;
REVOKE ALL ON TABLE dict_table FROM postgres;
GRANT ALL ON TABLE dict_table TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE dict_table TO PUBLIC;


--
-- TOC entry 1910 (class 0 OID 0)
-- Dependencies: 1488
-- Name: dict_table_key; Type: ACL; Schema: dict; Owner: postgres
--

REVOKE ALL ON TABLE dict_table_key FROM PUBLIC;
REVOKE ALL ON TABLE dict_table_key FROM postgres;
GRANT ALL ON TABLE dict_table_key TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE dict_table_key TO PUBLIC;


-- Completed on 2006-12-15 22:50:19

--
-- PostgreSQL database dump complete
--

