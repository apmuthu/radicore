--
-- PostgreSQL database dump
--

-- Started on 2006-01-01 12:21:09 GMT Standard Time

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 3 (class 2615 OID 16784)
-- Name: audit; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA audit;


ALTER SCHEMA audit OWNER TO postgres;

SET search_path = audit, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1380 (class 1259 OID 18835)
-- Dependencies: 1709 1710 1711 1712 3
-- Name: audit_fld; Type: TABLE; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE TABLE audit_fld (
    session_id bigint DEFAULT 0::bigint NOT NULL,
    tran_seq_no smallint DEFAULT 0::smallint NOT NULL,
    table_seq_no smallint DEFAULT 0::smallint NOT NULL,
    field_id character varying(255) DEFAULT ''::character varying NOT NULL,
    old_value text,
    new_value text
);


ALTER TABLE audit.audit_fld OWNER TO postgres;

--
-- TOC entry 1382 (class 1259 OID 18849)
-- Dependencies: 1714 1715 1716 3
-- Name: audit_ssn; Type: TABLE; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE TABLE audit_ssn (
    session_id bigserial NOT NULL,
    user_id character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    date date DEFAULT '2000-01-01'::date NOT NULL,
    "time" time without time zone DEFAULT '00:00:00'::time without time zone NOT NULL
);


ALTER TABLE audit.audit_ssn OWNER TO postgres;

--
-- TOC entry 1383 (class 1259 OID 18857)
-- Dependencies: 1717 1718 1719 1720 1721 1722 3
-- Name: audit_tbl; Type: TABLE; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE TABLE audit_tbl (
    session_id bigint DEFAULT 0::bigint NOT NULL,
    tran_seq_no smallint DEFAULT 0::smallint NOT NULL,
    table_seq_no smallint DEFAULT 0::smallint NOT NULL,
    base_name character varying(32) DEFAULT ''::character varying NOT NULL,
    table_name character varying(32) DEFAULT ''::character varying NOT NULL,
    pkey character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE audit.audit_tbl OWNER TO postgres;

--
-- TOC entry 1384 (class 1259 OID 18868)
-- Dependencies: 1723 1724 1725 1726 1727 3
-- Name: audit_trn; Type: TABLE; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE TABLE audit_trn (
    session_id bigint DEFAULT 0::bigint NOT NULL,
    tran_seq_no smallint DEFAULT 0::smallint NOT NULL,
    date date DEFAULT '2000-01-01'::date NOT NULL,
    "time" time without time zone DEFAULT '00:00:00'::time without time zone NOT NULL,
    task_id character varying(32) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE audit.audit_trn OWNER TO postgres;

--
-- TOC entry 1314 (class 1259 OID 16799)
-- Dependencies: 1706 1707 1708 3
-- Name: php_session; Type: TABLE; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE TABLE php_session (
    session_id character varying(32) DEFAULT ''::character varying NOT NULL,
    user_id character varying(16),
    date_created timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    last_updated timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    session_data text
);


ALTER TABLE audit.php_session OWNER TO postgres;

--
-- TOC entry 1732 (class 2606 OID 18845)
-- Dependencies: 1380 1380 1380 1380 1380
-- Name: audit_fld_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY audit_fld
    ADD CONSTRAINT audit_fld_pkey PRIMARY KEY (session_id, tran_seq_no, table_seq_no, field_id);


--
-- TOC entry 1735 (class 2606 OID 18856)
-- Dependencies: 1382 1382
-- Name: audit_ssn_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY audit_ssn
    ADD CONSTRAINT audit_ssn_pkey PRIMARY KEY (session_id);


--
-- TOC entry 1737 (class 2606 OID 18866)
-- Dependencies: 1383 1383 1383 1383
-- Name: audit_tbl_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY audit_tbl
    ADD CONSTRAINT audit_tbl_pkey PRIMARY KEY (session_id, tran_seq_no, table_seq_no);


--
-- TOC entry 1740 (class 2606 OID 18876)
-- Dependencies: 1384 1384 1384
-- Name: audit_trn_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY audit_trn
    ADD CONSTRAINT audit_trn_pkey PRIMARY KEY (session_id, tran_seq_no);


--
-- TOC entry 1730 (class 2606 OID 16812)
-- Dependencies: 1314 1314
-- Name: php_session_pkey; Type: CONSTRAINT; Schema: audit; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY php_session
    ADD CONSTRAINT php_session_pkey PRIMARY KEY (session_id);


--
-- TOC entry 1733 (class 1259 OID 18846)
-- Dependencies: 1380
-- Name: field_id_index; Type: INDEX; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE INDEX field_id_index ON audit_fld USING btree (field_id);


--
-- TOC entry 1728 (class 1259 OID 16814)
-- Dependencies: 1314
-- Name: php_session_index; Type: INDEX; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE INDEX php_session_index ON php_session USING btree (last_updated);


--
-- TOC entry 1738 (class 1259 OID 18867)
-- Dependencies: 1383
-- Name: pkey_index; Type: INDEX; Schema: audit; Owner: postgres; Tablespace: 
--

CREATE INDEX pkey_index ON audit_tbl USING btree (pkey);


-- Completed on 2006-01-01 12:21:11 GMT Standard Time

--
-- PostgreSQL database dump complete
--

