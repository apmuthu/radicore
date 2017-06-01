--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.0
-- Dumped by pg_dump version 9.1.0
-- Started on 2011-09-15 17:14:04

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 8 (class 2615 OID 17610)
-- Name: dict; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA dict;


ALTER SCHEMA dict OWNER TO postgres;

SET search_path = dict, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 187 (class 1259 OID 17893)
-- Dependencies: 2257 2258 2259 2260 2261 2262 2263 2264 2265 2266 2267 2268 2269 2270 2271 2272 2273 8
-- Name: dict_column; Type: TABLE; Schema: dict; Owner: postgres; Tablespace: 
--

CREATE TABLE dict.dict_column (
  database_id character varying(64) NOT NULL,
  table_id character varying(64) NOT NULL,
  column_id character varying(64) NOT NULL,
  column_seq smallint NOT NULL,
  column_name character varying(80) NOT NULL,
  column_desc text,
  col_type character varying(20),
  col_type_native character varying(32),
  col_array_type character varying(20),
  col_values text,
  user_size bigint,
  col_maxsize bigint,
  col_null character(1) DEFAULT 'Y'::bpchar,
  is_required character(1) DEFAULT 'N'::bpchar,
  col_key character(3),
  col_default character varying(255),
  col_auto_increment character(1) DEFAULT 'N'::bpchar,
  col_unsigned character(1) DEFAULT 'N'::bpchar,
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
  is_password character(1) DEFAULT 'N'::bpchar,
  auto_insert character(1) DEFAULT 'N'::bpchar,
  auto_update character(1) DEFAULT 'N'::bpchar,
  infinityisnull character(1) DEFAULT 'N'::bpchar,
  col_subtype character varying(10),
  image_width smallint,
  image_height smallint,
  is_boolean character(1) DEFAULT 'N'::bpchar,
  boolean_true character varying(4),
  boolean_false character varying(4),
  control character varying(10),
  optionlist character varying(64),
  checkbox_label character varying(64),
  task_id character varying(80),
  foreign_field character varying(64),
  align_hv character(1),
  align_lr character(1),
  multi_cols smallint,
  multi_rows smallint,
  custom_validation character varying(255),
  created_date timestamp without time zone NOT NULL DEFAULT '2000-01-01 00:00:00'::timestamp without time zone,
  created_user character varying(16) NOT NULL DEFAULT 'UNKNOWN'::character varying,
  revised_date timestamp without time zone,
  revised_user character varying(16)
);

ALTER TABLE dict.dict_column OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 17916)
-- Dependencies: 2274 2275 2276 2277 2278 8
-- Name: dict_database; Type: TABLE; Schema: dict; Owner: postgres; Tablespace: 
--

CREATE TABLE dict_database (
    database_id character varying(64) NOT NULL,
    database_name character varying(80) NOT NULL,
    database_desc text,
    subsys_id character varying(16) NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE dict.dict_database OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 17927)
-- Dependencies: 2279 2280 2281 2282 2283 2284 2285 2286 2287 8
-- Name: dict_related_column; Type: TABLE; Schema: dict; Owner: postgres; Tablespace: 
--

CREATE TABLE dict_related_column (
    database_id_snr character varying(64) NOT NULL,
    table_id_snr character varying(64) NOT NULL,
    column_id_snr character varying(64) NOT NULL,
    database_id_jnr character varying(64) NOT NULL,
    table_id_jnr character varying(64) NOT NULL,
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
-- TOC entry 190 (class 1259 OID 17939)
-- Dependencies: 2288 2289 2290 2291 2292 2293 2294 2295 8
-- Name: dict_relationship; Type: TABLE; Schema: dict; Owner: postgres; Tablespace: 
--

CREATE TABLE dict_relationship (
    database_id_snr character varying(64) NOT NULL,
    table_id_snr character varying(64) NOT NULL,
    database_id_jnr character varying(64) NOT NULL,
    table_id_jnr character varying(64) NOT NULL,
    seq_no smallint DEFAULT (0)::smallint NOT NULL,
    table_alias_snr character varying(64),
    table_alias_jnr character varying(64),
    relation_name character varying(80),
    relation_desc text,
    relation_type character(3) DEFAULT 'RES'::bpchar NOT NULL,
    orderby character varying(64),
    parent_field character varying(64),
    calc_field character varying(255),
    key_name character varying(64) NOT NULL DEFAULT 'PRIMARY',
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE dict.dict_relationship OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 17953)
-- Dependencies: 2296 2297 2298 2299 2300 2301 8
-- Name: dict_table; Type: TABLE; Schema: dict; Owner: postgres; Tablespace: 
--

CREATE TABLE dict_table (
    database_id character varying(64) NOT NULL,
    table_id character varying(64) NOT NULL,
    table_name character varying(80) NOT NULL,
    table_desc text,
    audit_logging character(1) DEFAULT 'Y'::bpchar NOT NULL,
    default_orderby character varying(64),
    alt_language_table character varying(64),
    alt_language_cols character varying(4000),
    nameof_start_date character varying(40),
    nameof_end_date character varying(40),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE dict.dict_table OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 17965)
-- Dependencies: 2302 2303 2304 2305 2306 2307 2308 2309 8
-- Name: dict_table_key; Type: TABLE; Schema: dict; Owner: postgres; Tablespace: 
--

CREATE TABLE dict_table_key (
    database_id character varying(64) NOT NULL,
    table_id character varying(64) NOT NULL,
    key_name character varying(64) NOT NULL,
    column_id character varying(64) NOT NULL,
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
-- TOC entry 2311 (class 2606 OID 18527)
-- Dependencies: 187 187 187 187
-- Name: dict_column_pkey; Type: CONSTRAINT; Schema: dict; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dict_column
    ADD CONSTRAINT dict_column_pkey PRIMARY KEY (database_id, table_id, column_id);


--
-- TOC entry 2313 (class 2606 OID 18529)
-- Dependencies: 188 188
-- Name: dict_database_pkey; Type: CONSTRAINT; Schema: dict; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dict_database
    ADD CONSTRAINT dict_database_pkey PRIMARY KEY (database_id);


--
-- TOC entry 2315 (class 2606 OID 18531)
-- Dependencies: 189 189 189 189 189 189 189
-- Name: dict_related_column_pkey; Type: CONSTRAINT; Schema: dict; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dict_related_column
    ADD CONSTRAINT dict_related_column_pkey PRIMARY KEY (database_id_snr, table_id_snr, column_id_snr, database_id_jnr, table_id_jnr, seq_no);


--
-- TOC entry 2317 (class 2606 OID 18533)
-- Dependencies: 190 190 190 190 190 190
-- Name: dict_relationship_pkey; Type: CONSTRAINT; Schema: dict; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dict_relationship
    ADD CONSTRAINT dict_relationship_pkey PRIMARY KEY (database_id_snr, table_id_snr, database_id_jnr, table_id_jnr, seq_no);


--
-- TOC entry 2321 (class 2606 OID 18535)
-- Dependencies: 192 192 192 192 192
-- Name: dict_table_key_pkey; Type: CONSTRAINT; Schema: dict; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dict_table_key
    ADD CONSTRAINT dict_table_key_pkey PRIMARY KEY (database_id, table_id, key_name, column_id);


--
-- TOC entry 2319 (class 2606 OID 18537)
-- Dependencies: 191 191 191
-- Name: dict_table_pkey; Type: CONSTRAINT; Schema: dict; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dict_table
    ADD CONSTRAINT dict_table_pkey PRIMARY KEY (database_id, table_id);


--
-- TOC entry 2324 (class 0 OID 0)
-- Dependencies: 8
-- Name: dict; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA dict FROM PUBLIC;
REVOKE ALL ON SCHEMA dict FROM postgres;
GRANT ALL ON SCHEMA dict TO postgres;
GRANT USAGE ON SCHEMA dict TO PUBLIC;


--
-- TOC entry 2325 (class 0 OID 0)
-- Dependencies: 187
-- Name: dict_column; Type: ACL; Schema: dict; Owner: postgres
--

REVOKE ALL ON TABLE dict_column FROM PUBLIC;
REVOKE ALL ON TABLE dict_column FROM postgres;
GRANT ALL ON TABLE dict_column TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE dict_column TO PUBLIC;


--
-- TOC entry 2326 (class 0 OID 0)
-- Dependencies: 188
-- Name: dict_database; Type: ACL; Schema: dict; Owner: postgres
--

REVOKE ALL ON TABLE dict_database FROM PUBLIC;
REVOKE ALL ON TABLE dict_database FROM postgres;
GRANT ALL ON TABLE dict_database TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE dict_database TO PUBLIC;


--
-- TOC entry 2327 (class 0 OID 0)
-- Dependencies: 189
-- Name: dict_related_column; Type: ACL; Schema: dict; Owner: postgres
--

REVOKE ALL ON TABLE dict_related_column FROM PUBLIC;
REVOKE ALL ON TABLE dict_related_column FROM postgres;
GRANT ALL ON TABLE dict_related_column TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE dict_related_column TO PUBLIC;


--
-- TOC entry 2328 (class 0 OID 0)
-- Dependencies: 190
-- Name: dict_relationship; Type: ACL; Schema: dict; Owner: postgres
--

REVOKE ALL ON TABLE dict_relationship FROM PUBLIC;
REVOKE ALL ON TABLE dict_relationship FROM postgres;
GRANT ALL ON TABLE dict_relationship TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE dict_relationship TO PUBLIC;


--
-- TOC entry 2329 (class 0 OID 0)
-- Dependencies: 191
-- Name: dict_table; Type: ACL; Schema: dict; Owner: postgres
--

REVOKE ALL ON TABLE dict_table FROM PUBLIC;
REVOKE ALL ON TABLE dict_table FROM postgres;
GRANT ALL ON TABLE dict_table TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE dict_table TO PUBLIC;


--
-- TOC entry 2330 (class 0 OID 0)
-- Dependencies: 192
-- Name: dict_table_key; Type: ACL; Schema: dict; Owner: postgres
--

REVOKE ALL ON TABLE dict_table_key FROM PUBLIC;
REVOKE ALL ON TABLE dict_table_key FROM postgres;
GRANT ALL ON TABLE dict_table_key TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE dict_table_key TO PUBLIC;


-- Completed on 2011-09-15 17:14:05

--
-- PostgreSQL database dump complete
--

