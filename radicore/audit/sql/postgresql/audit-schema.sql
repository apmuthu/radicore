--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.5
-- Dumped by pg_dump version 9.4.5
-- Started on 2015-10-15 17:11:52

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 6 (class 2615 OID 16397)
-- Name: audit; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA audit;


ALTER SCHEMA audit OWNER TO postgres;

SET search_path = audit, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 177 (class 1259 OID 16455)
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


ALTER TABLE audit_fld OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 16465)
-- Name: audit_logon_errors; Type: TABLE; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE TABLE audit_logon_errors (
    id integer NOT NULL,
    err_timestamp timestamp without time zone NOT NULL,
    ip_address character varying(16) NOT NULL,
    user_id character varying(16),
    user_password character varying(16) NOT NULL,
    email_addr character varying(50)
);


ALTER TABLE audit_logon_errors OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 16468)
-- Name: audit_logon_errors_id_seq; Type: SEQUENCE; Schema: audit; Owner: postgres
--

CREATE SEQUENCE audit_logon_errors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE audit_logon_errors_id_seq OWNER TO postgres;

--
-- TOC entry 2302 (class 0 OID 0)
-- Dependencies: 179
-- Name: audit_logon_errors_id_seq; Type: SEQUENCE OWNED BY; Schema: audit; Owner: postgres
--

ALTER SEQUENCE audit_logon_errors_id_seq OWNED BY audit_logon_errors.id;


--
-- TOC entry 180 (class 1259 OID 16470)
-- Name: audit_ssn; Type: TABLE; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE TABLE audit_ssn (
    session_id bigint NOT NULL,
    user_id character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    ssn_datetime timestamp without time zone NOT NULL
);


ALTER TABLE audit_ssn OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 16476)
-- Name: audit_ssn_session_id_seq; Type: SEQUENCE; Schema: audit; Owner: postgres
--

CREATE SEQUENCE audit_ssn_session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE audit_ssn_session_id_seq OWNER TO postgres;

--
-- TOC entry 2305 (class 0 OID 0)
-- Dependencies: 181
-- Name: audit_ssn_session_id_seq; Type: SEQUENCE OWNED BY; Schema: audit; Owner: postgres
--

ALTER SEQUENCE audit_ssn_session_id_seq OWNED BY audit_ssn.session_id;


--
-- TOC entry 182 (class 1259 OID 16478)
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


ALTER TABLE audit_tbl OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 16487)
-- Name: audit_trn; Type: TABLE; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE TABLE audit_trn (
    session_id bigint DEFAULT (0)::bigint NOT NULL,
    tran_seq_no smallint DEFAULT (0)::smallint NOT NULL,
    task_id character varying(80) DEFAULT ''::character varying NOT NULL,
    trn_datetime timestamp without time zone NOT NULL
);


ALTER TABLE audit_trn OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 16495)
-- Name: php_session; Type: TABLE; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE TABLE php_session (
    session_id character varying(32) DEFAULT ''::character varying NOT NULL,
    user_id character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    date_created timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    last_updated timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    session_data text
);


ALTER TABLE php_session OWNER TO postgres;

--
-- TOC entry 2153 (class 2604 OID 17008)
-- Name: id; Type: DEFAULT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY audit_logon_errors ALTER COLUMN id SET DEFAULT nextval('audit_logon_errors_id_seq'::regclass);


--
-- TOC entry 2154 (class 2604 OID 17009)
-- Name: session_id; Type: DEFAULT; Schema: audit; Owner: postgres
--

ALTER TABLE ONLY audit_ssn ALTER COLUMN session_id SET DEFAULT nextval('audit_ssn_session_id_seq'::regclass);


--
-- TOC entry 2170 (class 2606 OID 17014)
-- Name: audit_fld_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY audit_fld
    ADD CONSTRAINT audit_fld_pkey PRIMARY KEY (session_id, tran_seq_no, table_seq_no, field_id);


--
-- TOC entry 2173 (class 2606 OID 17016)
-- Name: audit_logon_errors_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY audit_logon_errors
    ADD CONSTRAINT audit_logon_errors_pkey PRIMARY KEY (id);


--
-- TOC entry 2176 (class 2606 OID 17018)
-- Name: audit_ssn_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY audit_ssn
    ADD CONSTRAINT audit_ssn_pkey PRIMARY KEY (session_id);


--
-- TOC entry 2178 (class 2606 OID 17020)
-- Name: audit_tbl_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY audit_tbl
    ADD CONSTRAINT audit_tbl_pkey PRIMARY KEY (session_id, tran_seq_no, table_seq_no);


--
-- TOC entry 2182 (class 2606 OID 17022)
-- Name: audit_trn_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY audit_trn
    ADD CONSTRAINT audit_trn_pkey PRIMARY KEY (session_id, tran_seq_no);


--
-- TOC entry 2185 (class 2606 OID 17024)
-- Name: php_session_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY php_session
    ADD CONSTRAINT php_session_pkey PRIMARY KEY (session_id);


--
-- TOC entry 2174 (class 1259 OID 17430)
-- Name: audit_ssn_datetime; Type: INDEX; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE INDEX audit_ssn_datetime ON audit_ssn USING btree (ssn_datetime);


--
-- TOC entry 2180 (class 1259 OID 17431)
-- Name: audit_trn_datetime; Type: INDEX; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE INDEX audit_trn_datetime ON audit_trn USING btree (trn_datetime);


--
-- TOC entry 2171 (class 1259 OID 17137)
-- Name: field_id_index; Type: INDEX; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE INDEX field_id_index ON audit_fld USING btree (field_id);


--
-- TOC entry 2183 (class 1259 OID 17138)
-- Name: php_session_index; Type: INDEX; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE INDEX php_session_index ON php_session USING btree (last_updated);


--
-- TOC entry 2179 (class 1259 OID 17139)
-- Name: pkey_index; Type: INDEX; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE INDEX pkey_index ON audit_tbl USING btree (pkey);


--
-- TOC entry 2299 (class 0 OID 0)
-- Dependencies: 6
-- Name: audit; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA audit FROM PUBLIC;
REVOKE ALL ON SCHEMA audit FROM postgres;
GRANT ALL ON SCHEMA audit TO postgres;
GRANT USAGE ON SCHEMA audit TO PUBLIC;


--
-- TOC entry 2300 (class 0 OID 0)
-- Dependencies: 177
-- Name: audit_fld; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON TABLE audit_fld FROM PUBLIC;
REVOKE ALL ON TABLE audit_fld FROM postgres;
GRANT ALL ON TABLE audit_fld TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE audit_fld TO PUBLIC;


--
-- TOC entry 2301 (class 0 OID 0)
-- Dependencies: 178
-- Name: audit_logon_errors; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON TABLE audit_logon_errors FROM PUBLIC;
REVOKE ALL ON TABLE audit_logon_errors FROM postgres;
GRANT ALL ON TABLE audit_logon_errors TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE audit_logon_errors TO PUBLIC;


--
-- TOC entry 2303 (class 0 OID 0)
-- Dependencies: 179
-- Name: audit_logon_errors_id_seq; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON SEQUENCE audit_logon_errors_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE audit_logon_errors_id_seq FROM postgres;
GRANT ALL ON SEQUENCE audit_logon_errors_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE audit_logon_errors_id_seq TO PUBLIC;


--
-- TOC entry 2304 (class 0 OID 0)
-- Dependencies: 180
-- Name: audit_ssn; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON TABLE audit_ssn FROM PUBLIC;
REVOKE ALL ON TABLE audit_ssn FROM postgres;
GRANT ALL ON TABLE audit_ssn TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE audit_ssn TO PUBLIC;


--
-- TOC entry 2306 (class 0 OID 0)
-- Dependencies: 181
-- Name: audit_ssn_session_id_seq; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON SEQUENCE audit_ssn_session_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE audit_ssn_session_id_seq FROM postgres;
GRANT ALL ON SEQUENCE audit_ssn_session_id_seq TO postgres;
GRANT SELECT,UPDATE ON SEQUENCE audit_ssn_session_id_seq TO PUBLIC;


--
-- TOC entry 2307 (class 0 OID 0)
-- Dependencies: 182
-- Name: audit_tbl; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON TABLE audit_tbl FROM PUBLIC;
REVOKE ALL ON TABLE audit_tbl FROM postgres;
GRANT ALL ON TABLE audit_tbl TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE audit_tbl TO PUBLIC;


--
-- TOC entry 2308 (class 0 OID 0)
-- Dependencies: 183
-- Name: audit_trn; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON TABLE audit_trn FROM PUBLIC;
REVOKE ALL ON TABLE audit_trn FROM postgres;
GRANT ALL ON TABLE audit_trn TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE audit_trn TO PUBLIC;


--
-- TOC entry 2309 (class 0 OID 0)
-- Dependencies: 184
-- Name: php_session; Type: ACL; Schema: audit; Owner: postgres
--

REVOKE ALL ON TABLE php_session FROM PUBLIC;
REVOKE ALL ON TABLE php_session FROM postgres;
GRANT ALL ON TABLE php_session TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE php_session TO PUBLIC;


-- Completed on 2015-10-15 17:11:53

--
-- PostgreSQL database dump complete
--

