--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.0
-- Dumped by pg_dump version 9.1.0
-- Started on 2011-09-15 17:11:05

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 6 (class 2615 OID 17608)
-- Name: audit; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA audit;


ALTER SCHEMA audit OWNER TO postgres;

SET search_path = audit, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 168 (class 1259 OID 17746)
-- Dependencies: 2257 2258 2259 2260 6
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
-- TOC entry 169 (class 1259 OID 17756)
-- Dependencies: 6
-- Name: audit_logon_errors; Type: TABLE; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE TABLE audit_logon_errors (
    id integer NOT NULL,
    err_timestamp timestamp without time zone NOT NULL,
    ip_address character varying(40) NOT NULL,
    user_id character varying(16),
    user_password character varying(16) NOT NULL,
    email_addr character varying(50)
);


ALTER TABLE audit.audit_logon_errors OWNER TO postgres;

--
-- TOC entry 170 (class 1259 OID 17759)
-- Dependencies: 6 169
-- Name: audit_logon_errors_id_seq; Type: SEQUENCE; Schema: audit; Owner: postgres
--

CREATE SEQUENCE audit_logon_errors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE audit.audit_logon_errors_id_seq OWNER TO postgres;

--
-- TOC entry 2301 (class 0 OID 0)
-- Dependencies: 170
-- Name: audit_logon_errors_id_seq; Type: SEQUENCE OWNED BY; Schema: audit; Owner: postgres
--

ALTER SEQUENCE audit_logon_errors_id_seq OWNED BY audit_logon_errors.id;


--
-- TOC entry 171 (class 1259 OID 17761)
-- Dependencies: 2263 2264 2265 6
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
-- TOC entry 172 (class 1259 OID 17767)
-- Dependencies: 6 171
-- Name: audit_ssn_session_id_seq; Type: SEQUENCE; Schema: audit; Owner: postgres
--

CREATE SEQUENCE audit_ssn_session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE audit.audit_ssn_session_id_seq OWNER TO postgres;

--
-- TOC entry 2304 (class 0 OID 0)
-- Dependencies: 172
-- Name: audit_ssn_session_id_seq; Type: SEQUENCE OWNED BY; Schema: audit; Owner: postgres
--

ALTER SEQUENCE audit_ssn_session_id_seq OWNED BY audit_ssn.session_id;


--
-- TOC entry 173 (class 1259 OID 17769)
-- Dependencies: 2266 2267 2268 2269 2270 2271 6
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
-- TOC entry 174 (class 1259 OID 17778)
-- Dependencies: 2272 2273 2274 2275 2276 6
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
-- TOC entry 175 (class 1259 OID 17786)
-- Dependencies: 2277 2278 2279 2280 6
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
-- TOC entry 2261 (class 2604 OID 18488)
-- Dependencies: 170 169
-- Name: id; Type: DEFAULT; Schema: audit; Owner: postgres
--

ALTER TABLE audit_logon_errors ALTER COLUMN id SET DEFAULT nextval('audit_logon_errors_id_seq'::regclass);


--
-- TOC entry 2262 (class 2604 OID 18489)
-- Dependencies: 172 171
-- Name: session_id; Type: DEFAULT; Schema: audit; Owner: postgres
--

ALTER TABLE audit_ssn ALTER COLUMN session_id SET DEFAULT nextval('audit_ssn_session_id_seq'::regclass);


--
-- TOC entry 2282 (class 2606 OID 18493)
-- Dependencies: 168 168 168 168 168
-- Name: audit_fld_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY audit_fld
    ADD CONSTRAINT audit_fld_pkey PRIMARY KEY (session_id, tran_seq_no, table_seq_no, field_id);


--
-- TOC entry 2285 (class 2606 OID 18495)
-- Dependencies: 169 169
-- Name: audit_logon_errors_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY audit_logon_errors
    ADD CONSTRAINT audit_logon_errors_pkey PRIMARY KEY (id);


--
-- TOC entry 2287 (class 2606 OID 18497)
-- Dependencies: 171 171
-- Name: audit_ssn_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY audit_ssn
    ADD CONSTRAINT audit_ssn_pkey PRIMARY KEY (session_id);


--
-- TOC entry 2289 (class 2606 OID 18499)
-- Dependencies: 173 173 173 173
-- Name: audit_tbl_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY audit_tbl
    ADD CONSTRAINT audit_tbl_pkey PRIMARY KEY (session_id, tran_seq_no, table_seq_no);


--
-- TOC entry 2292 (class 2606 OID 18501)
-- Dependencies: 174 174 174
-- Name: audit_trn_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY audit_trn
    ADD CONSTRAINT audit_trn_pkey PRIMARY KEY (session_id, tran_seq_no);


--
-- TOC entry 2295 (class 2606 OID 18503)
-- Dependencies: 175 175
-- Name: php_session_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY php_session
    ADD CONSTRAINT php_session_pkey PRIMARY KEY (session_id);


--
-- TOC entry 2283 (class 1259 OID 18660)
-- Dependencies: 168
-- Name: field_id_index; Type: INDEX; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE INDEX field_id_index ON audit_fld USING btree (field_id);


--
-- TOC entry 2293 (class 1259 OID 18661)
-- Dependencies: 175
-- Name: php_session_index; Type: INDEX; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE INDEX php_session_index ON php_session USING btree (last_updated);


--
-- TOC entry 2290 (class 1259 OID 18662)
-- Dependencies: 173
-- Name: pkey_index; Type: INDEX; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE INDEX pkey_index ON audit_tbl USING btree (pkey);


--
-- TOC entry 2298 (class 0 OID 0)
-- Dependencies: 6
-- Name: audit; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA audit FROM PUBLIC;
REVOKE ALL ON SCHEMA audit FROM postgres;
GRANT ALL ON SCHEMA audit TO postgres;
GRANT USAGE ON SCHEMA audit TO PUBLIC;


--
-- TOC entry 2299 (class 0 OID 0)
-- Dependencies: 168
-- Name: audit_fld; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON TABLE audit_fld FROM PUBLIC;
REVOKE ALL ON TABLE audit_fld FROM postgres;
GRANT ALL ON TABLE audit_fld TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE audit_fld TO PUBLIC;


--
-- TOC entry 2300 (class 0 OID 0)
-- Dependencies: 169
-- Name: audit_logon_errors; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON TABLE audit_logon_errors FROM PUBLIC;
REVOKE ALL ON TABLE audit_logon_errors FROM postgres;
GRANT ALL ON TABLE audit_logon_errors TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE audit_logon_errors TO PUBLIC;


--
-- TOC entry 2302 (class 0 OID 0)
-- Dependencies: 170
-- Name: audit_logon_errors_id_seq; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON SEQUENCE audit_logon_errors_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE audit_logon_errors_id_seq FROM postgres;
GRANT ALL ON SEQUENCE audit_logon_errors_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE audit_logon_errors_id_seq TO tony;
GRANT SELECT,UPDATE ON SEQUENCE audit_logon_errors_id_seq TO PUBLIC;


--
-- TOC entry 2303 (class 0 OID 0)
-- Dependencies: 171
-- Name: audit_ssn; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON TABLE audit_ssn FROM PUBLIC;
REVOKE ALL ON TABLE audit_ssn FROM postgres;
GRANT ALL ON TABLE audit_ssn TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE audit_ssn TO PUBLIC;


--
-- TOC entry 2305 (class 0 OID 0)
-- Dependencies: 172
-- Name: audit_ssn_session_id_seq; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON SEQUENCE audit_ssn_session_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE audit_ssn_session_id_seq FROM postgres;
GRANT ALL ON SEQUENCE audit_ssn_session_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE audit_ssn_session_id_seq TO tony;
GRANT SELECT,UPDATE ON SEQUENCE audit_ssn_session_id_seq TO PUBLIC;


--
-- TOC entry 2306 (class 0 OID 0)
-- Dependencies: 173
-- Name: audit_tbl; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON TABLE audit_tbl FROM PUBLIC;
REVOKE ALL ON TABLE audit_tbl FROM postgres;
GRANT ALL ON TABLE audit_tbl TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE audit_tbl TO PUBLIC;


--
-- TOC entry 2307 (class 0 OID 0)
-- Dependencies: 174
-- Name: audit_trn; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON TABLE audit_trn FROM PUBLIC;
REVOKE ALL ON TABLE audit_trn FROM postgres;
GRANT ALL ON TABLE audit_trn TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE audit_trn TO PUBLIC;


--
-- TOC entry 2308 (class 0 OID 0)
-- Dependencies: 175
-- Name: php_session; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON TABLE php_session FROM PUBLIC;
REVOKE ALL ON TABLE php_session FROM postgres;
GRANT ALL ON TABLE php_session TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE php_session TO PUBLIC;


-- Completed on 2011-09-15 17:11:07

--
-- PostgreSQL database dump complete
--

