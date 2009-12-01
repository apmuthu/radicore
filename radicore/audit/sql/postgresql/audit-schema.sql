--
-- PostgreSQL database dump
--

-- Started on 2009-09-29 14:29:27

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 6 (class 2615 OID 17809)
-- Name: audit; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA audit;

ALTER SCHEMA audit OWNER TO postgres;

SET search_path = audit, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1404 (class 1259 OID 17821)
-- Dependencies: 1835 1836 1837 1838 6
-- Name: audit_fld; Type: TABLE; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE TABLE audit_fld (
    session_id bigint DEFAULT (0)::bigint NOT NULL,
    tran_seq_no smallint DEFAULT (0)::smallint NOT NULL,
    table_seq_no smallint DEFAULT (0)::smallint NOT NULL,
    field_id character varying(255) DEFAULT ''::character varying NOT NULL,
    old_value text,
    new_value text
);


ALTER TABLE audit.audit_fld OWNER TO postgres;

--
-- TOC entry 1406 (class 1259 OID 17832)
-- Dependencies: 6
-- Name: audit_logon_errors; Type: TABLE; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE TABLE audit_logon_errors (
    id integer NOT NULL,
    err_timestamp timestamp without time zone NOT NULL,
    ip_address character varying(16) NOT NULL,
    user_id character varying(16) NULL,
    user_password character varying(16) NOT NULL,
    email_addr character varying(50)
);


ALTER TABLE audit.audit_logon_errors OWNER TO postgres;

--
-- TOC entry 1405 (class 1259 OID 17830)
-- Dependencies: 6 1406
-- Name: audit_logon_errors_id_seq; Type: SEQUENCE; Schema: audit; Owner: postgres
--

CREATE SEQUENCE audit_logon_errors_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE audit.audit_logon_errors_id_seq OWNER TO postgres;

--
-- TOC entry 1879 (class 0 OID 0)
-- Dependencies: 1405
-- Name: audit_logon_errors_id_seq; Type: SEQUENCE OWNED BY; Schema: audit; Owner: postgres
--

ALTER SEQUENCE audit_logon_errors_id_seq OWNED BY audit_logon_errors.id;


--
-- TOC entry 1408 (class 1259 OID 17837)
-- Dependencies: 1841 1842 1843 6
-- Name: audit_ssn; Type: TABLE; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE TABLE audit_ssn (
    session_id bigint NOT NULL,
    user_id character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    ssn_date date DEFAULT '2000-01-01'::date NOT NULL,
    ssn_time time without time zone DEFAULT '00:00:00'::time without time zone NOT NULL
);


ALTER TABLE audit.audit_ssn OWNER TO postgres;

--
-- TOC entry 1407 (class 1259 OID 17835)
-- Dependencies: 1408 6
-- Name: audit_ssn_session_id_seq; Type: SEQUENCE; Schema: audit; Owner: postgres
--

CREATE SEQUENCE audit_ssn_session_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE audit.audit_ssn_session_id_seq OWNER TO postgres;

--
-- TOC entry 1882 (class 0 OID 0)
-- Dependencies: 1407
-- Name: audit_ssn_session_id_seq; Type: SEQUENCE OWNED BY; Schema: audit; Owner: postgres
--

ALTER SEQUENCE audit_ssn_session_id_seq OWNED BY audit_ssn.session_id;


--
-- TOC entry 1409 (class 1259 OID 17843)
-- Dependencies: 1844 1845 1846 1847 1848 1849 6
-- Name: audit_tbl; Type: TABLE; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE TABLE audit_tbl (
    session_id bigint DEFAULT (0)::bigint NOT NULL,
    tran_seq_no smallint DEFAULT (0)::smallint NOT NULL,
    table_seq_no smallint DEFAULT (0)::smallint NOT NULL,
    base_name character varying(64) DEFAULT ''::character varying NOT NULL,
    table_name character varying(64) DEFAULT ''::character varying NOT NULL,
    pkey character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE audit.audit_tbl OWNER TO postgres;

--
-- TOC entry 1410 (class 1259 OID 17851)
-- Dependencies: 1850 1851 1852 1853 1854 6
-- Name: audit_trn; Type: TABLE; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE TABLE audit_trn (
    session_id bigint DEFAULT (0)::bigint NOT NULL,
    tran_seq_no smallint DEFAULT (0)::smallint NOT NULL,
    trn_date date DEFAULT '2000-01-01'::date NOT NULL,
    trn_time time without time zone DEFAULT '00:00:00'::time without time zone NOT NULL,
    task_id character varying(80) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE audit.audit_trn OWNER TO postgres;

--
-- TOC entry 1411 (class 1259 OID 17858)
-- Dependencies: 1855 1856 1857 1858 6
-- Name: php_session; Type: TABLE; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE TABLE php_session (
    session_id character varying(32) DEFAULT ''::character varying NOT NULL,
    user_id character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    date_created timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    last_updated timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    session_data text
);


ALTER TABLE audit.php_session OWNER TO postgres;

--
-- TOC entry 1839 (class 2604 OID 17834)
-- Dependencies: 1405 1406 1406
-- Name: id; Type: DEFAULT; Schema: audit; Owner: postgres
--

ALTER TABLE audit_logon_errors ALTER COLUMN id SET DEFAULT nextval('audit_logon_errors_id_seq'::regclass);


--
-- TOC entry 1840 (class 2604 OID 17839)
-- Dependencies: 1407 1408 1408
-- Name: session_id; Type: DEFAULT; Schema: audit; Owner: postgres
--

ALTER TABLE audit_ssn ALTER COLUMN session_id SET DEFAULT nextval('audit_ssn_session_id_seq'::regclass);


--
-- TOC entry 1860 (class 2606 OID 18483)
-- Dependencies: 1404 1404 1404 1404 1404
-- Name: audit_fld_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY audit_fld
    ADD CONSTRAINT audit_fld_pkey PRIMARY KEY (session_id, tran_seq_no, table_seq_no, field_id);


--
-- TOC entry 1863 (class 2606 OID 18485)
-- Dependencies: 1406 1406
-- Name: audit_logon_errors_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY audit_logon_errors
    ADD CONSTRAINT audit_logon_errors_pkey PRIMARY KEY (id);


--
-- TOC entry 1865 (class 2606 OID 18487)
-- Dependencies: 1408 1408
-- Name: audit_ssn_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY audit_ssn
    ADD CONSTRAINT audit_ssn_pkey PRIMARY KEY (session_id);


--
-- TOC entry 1867 (class 2606 OID 18489)
-- Dependencies: 1409 1409 1409 1409
-- Name: audit_tbl_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY audit_tbl
    ADD CONSTRAINT audit_tbl_pkey PRIMARY KEY (session_id, tran_seq_no, table_seq_no);


--
-- TOC entry 1870 (class 2606 OID 18491)
-- Dependencies: 1410 1410 1410
-- Name: audit_trn_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY audit_trn
    ADD CONSTRAINT audit_trn_pkey PRIMARY KEY (session_id, tran_seq_no);


--
-- TOC entry 1873 (class 2606 OID 18493)
-- Dependencies: 1411 1411
-- Name: php_session_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY php_session
    ADD CONSTRAINT php_session_pkey PRIMARY KEY (session_id);


--
-- TOC entry 1861 (class 1259 OID 18654)
-- Dependencies: 1404
-- Name: field_id_index; Type: INDEX; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE INDEX field_id_index ON audit_fld USING btree (field_id);


--
-- TOC entry 1871 (class 1259 OID 18655)
-- Dependencies: 1411
-- Name: php_session_index; Type: INDEX; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE INDEX php_session_index ON php_session USING btree (last_updated);


--
-- TOC entry 1868 (class 1259 OID 18656)
-- Dependencies: 1409
-- Name: pkey_index; Type: INDEX; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE INDEX pkey_index ON audit_tbl USING btree (pkey);


--
-- TOC entry 1876 (class 0 OID 0)
-- Dependencies: 6
-- Name: audit; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA audit FROM PUBLIC;
REVOKE ALL ON SCHEMA audit FROM postgres;
GRANT ALL ON SCHEMA audit TO postgres;
GRANT USAGE ON SCHEMA audit TO PUBLIC;


--
-- TOC entry 1877 (class 0 OID 0)
-- Dependencies: 1404
-- Name: audit_fld; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON TABLE audit_fld FROM PUBLIC;
REVOKE ALL ON TABLE audit_fld FROM postgres;
GRANT ALL ON TABLE audit_fld TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE audit_fld TO PUBLIC;


--
-- TOC entry 1878 (class 0 OID 0)
-- Dependencies: 1406
-- Name: audit_logon_errors; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON TABLE audit_logon_errors FROM PUBLIC;
REVOKE ALL ON TABLE audit_logon_errors FROM postgres;
GRANT ALL ON TABLE audit_logon_errors TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE audit_logon_errors TO PUBLIC;


--
-- TOC entry 1880 (class 0 OID 0)
-- Dependencies: 1405
-- Name: audit_logon_errors_id_seq; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON SEQUENCE audit_logon_errors_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE audit_logon_errors_id_seq FROM postgres;
GRANT ALL ON SEQUENCE audit_logon_errors_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE audit_logon_errors_id_seq TO tony;
GRANT SELECT,UPDATE ON SEQUENCE audit_logon_errors_id_seq TO PUBLIC;


--
-- TOC entry 1881 (class 0 OID 0)
-- Dependencies: 1408
-- Name: audit_ssn; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON TABLE audit_ssn FROM PUBLIC;
REVOKE ALL ON TABLE audit_ssn FROM postgres;
GRANT ALL ON TABLE audit_ssn TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE audit_ssn TO PUBLIC;


--
-- TOC entry 1883 (class 0 OID 0)
-- Dependencies: 1407
-- Name: audit_ssn_session_id_seq; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON SEQUENCE audit_ssn_session_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE audit_ssn_session_id_seq FROM postgres;
GRANT ALL ON SEQUENCE audit_ssn_session_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE audit_ssn_session_id_seq TO tony;
GRANT SELECT,UPDATE ON SEQUENCE audit_ssn_session_id_seq TO PUBLIC;


--
-- TOC entry 1884 (class 0 OID 0)
-- Dependencies: 1409
-- Name: audit_tbl; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON TABLE audit_tbl FROM PUBLIC;
REVOKE ALL ON TABLE audit_tbl FROM postgres;
GRANT ALL ON TABLE audit_tbl TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE audit_tbl TO PUBLIC;


--
-- TOC entry 1885 (class 0 OID 0)
-- Dependencies: 1410
-- Name: audit_trn; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON TABLE audit_trn FROM PUBLIC;
REVOKE ALL ON TABLE audit_trn FROM postgres;
GRANT ALL ON TABLE audit_trn TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE audit_trn TO PUBLIC;


--
-- TOC entry 1886 (class 0 OID 0)
-- Dependencies: 1411
-- Name: php_session; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON TABLE php_session FROM PUBLIC;
REVOKE ALL ON TABLE php_session FROM postgres;
GRANT ALL ON TABLE php_session TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE php_session TO PUBLIC;


-- Completed on 2006-12-08 11:39:28

--
-- PostgreSQL database dump complete
--

