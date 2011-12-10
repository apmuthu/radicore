--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.0
-- Dumped by pg_dump version 9.1.0
-- Started on 2011-09-15 17:17:59

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 12 (class 2615 OID 17613)
-- Name: workflow; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA workflow;


ALTER SCHEMA workflow OWNER TO postgres;

SET search_path = workflow, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 233 (class 1259 OID 18311)
-- Dependencies: 2257 2258 2259 2260 2261 12
-- Name: wf_arc; Type: TABLE; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE TABLE wf_arc (
    workflow_id smallint DEFAULT (0)::smallint NOT NULL,
    transition_id smallint DEFAULT (0)::smallint NOT NULL,
    place_id smallint DEFAULT (0)::smallint NOT NULL,
    direction character varying(3) NOT NULL,
    arc_type character varying(10) DEFAULT 'SEQ'::character varying,
    pre_condition text,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE workflow.wf_arc OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 18322)
-- Dependencies: 2262 2263 2264 2265 2266 12
-- Name: wf_case; Type: TABLE; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE TABLE wf_case (
    rdcaccount_id integer DEFAULT 1 NOT NULL,
    case_id integer DEFAULT 0 NOT NULL,
    workflow_id smallint DEFAULT (0)::smallint NOT NULL,
    context character varying(255),
    case_status character(2),
    start_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    end_date timestamp without time zone,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE workflow.wf_case OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 18330)
-- Dependencies: 2267 2268 2269 12
-- Name: wf_place; Type: TABLE; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE TABLE wf_place (
    workflow_id smallint DEFAULT (0)::smallint NOT NULL,
    place_id smallint DEFAULT (0)::smallint NOT NULL,
    place_type character(1),
    place_name character varying(80),
    place_desc text,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE workflow.wf_place OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 18339)
-- Dependencies: 2270 2271 2272 2273 2274 2275 12
-- Name: wf_token; Type: TABLE; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE TABLE wf_token (
    rdcaccount_id integer DEFAULT 1 NOT NULL,
    case_id integer DEFAULT 0 NOT NULL,
    token_id smallint DEFAULT (0)::smallint NOT NULL,
    workflow_id smallint DEFAULT (0)::smallint NOT NULL,
    place_id smallint DEFAULT (0)::smallint NOT NULL,
    context character varying(255),
    token_status character varying(4),
    enabled_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    cancelled_date timestamp without time zone,
    consumed_date timestamp without time zone
);


ALTER TABLE workflow.wf_token OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 18348)
-- Dependencies: 2276 2277 2278 2279 12
-- Name: wf_transition; Type: TABLE; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE TABLE wf_transition (
    workflow_id smallint DEFAULT (0)::smallint NOT NULL,
    transition_id smallint DEFAULT (0)::smallint NOT NULL,
    transition_name character varying(80) NOT NULL,
    transition_desc text,
    transition_trigger character varying(4) DEFAULT 'USER'::character varying NOT NULL,
    time_limit integer,
    task_id character varying(80) NOT NULL,
    role_id character varying(16),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE workflow.wf_transition OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 18358)
-- Dependencies: 2280 2281 12
-- Name: wf_workflow; Type: TABLE; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE TABLE wf_workflow (
    workflow_id smallint DEFAULT (0)::smallint NOT NULL,
    workflow_name character varying(80),
    workflow_desc text,
    start_task_id character varying(80),
    is_valid character(1),
    workflow_errors text,
    start_date date,
    end_date date,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE workflow.wf_workflow OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 18366)
-- Dependencies: 2282 2283 2284 2285 2286 12
-- Name: wf_workitem; Type: TABLE; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE TABLE wf_workitem (
    rdcaccount_id integer DEFAULT 1 NOT NULL,
    case_id integer DEFAULT 0 NOT NULL,
    workitem_id smallint DEFAULT (0)::smallint NOT NULL,
    workflow_id smallint DEFAULT (0)::smallint NOT NULL,
    transition_id smallint DEFAULT (0)::smallint NOT NULL,
    transition_trigger character varying(4),
    task_id character varying(80),
    context character varying(255),
    workitem_status character(2),
    enabled_date timestamp without time zone,
    cancelled_date timestamp without time zone,
    finished_date timestamp without time zone,
    deadline timestamp without time zone,
    role_id character varying(16),
    user_id character varying(16)
);


ALTER TABLE workflow.wf_workitem OWNER TO postgres;

--
-- TOC entry 2290 (class 2606 OID 18617)
-- Dependencies: 233 233 233 233 233
-- Name: wf_arc_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_arc
    ADD CONSTRAINT wf_arc_pkey PRIMARY KEY (workflow_id, transition_id, place_id, direction);


--
-- TOC entry 2294 (class 2606 OID 18619)
-- Dependencies: 234 234
-- Name: wf_case_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_case
    ADD CONSTRAINT wf_case_pkey PRIMARY KEY (case_id);


--
-- TOC entry 2296 (class 2606 OID 18621)
-- Dependencies: 235 235 235
-- Name: wf_place_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_place
    ADD CONSTRAINT wf_place_pkey PRIMARY KEY (workflow_id, place_id);


--
-- TOC entry 2300 (class 2606 OID 18623)
-- Dependencies: 236 236 236
-- Name: wf_token_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_token
    ADD CONSTRAINT wf_token_pkey PRIMARY KEY (case_id, token_id);


--
-- TOC entry 2302 (class 2606 OID 18625)
-- Dependencies: 237 237 237
-- Name: wf_transition_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_transition
    ADD CONSTRAINT wf_transition_pkey PRIMARY KEY (workflow_id, transition_id);


--
-- TOC entry 2304 (class 2606 OID 18627)
-- Dependencies: 238 238
-- Name: wf_workflow_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_workflow
    ADD CONSTRAINT wf_workflow_pkey PRIMARY KEY (workflow_id);


--
-- TOC entry 2308 (class 2606 OID 18629)
-- Dependencies: 239 239 239
-- Name: wf_workitem_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_workitem
    ADD CONSTRAINT wf_workitem_pkey PRIMARY KEY (case_id, workitem_id);


--
-- TOC entry 2287 (class 1259 OID 18671)
-- Dependencies: 233 233 233
-- Name: wf_arc_index1; Type: INDEX; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE INDEX wf_arc_index1 ON wf_arc USING btree (workflow_id, place_id, direction);


--
-- TOC entry 2288 (class 1259 OID 18672)
-- Dependencies: 233 233 233
-- Name: wf_arc_index2; Type: INDEX; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE INDEX wf_arc_index2 ON wf_arc USING btree (workflow_id, transition_id, direction);


--
-- TOC entry 2291 (class 1259 OID 18673)
-- Dependencies: 234
-- Name: wf_case_index1; Type: INDEX; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE INDEX wf_case_index1 ON wf_case USING btree (workflow_id);


--
-- TOC entry 2292 (class 1259 OID 18674)
-- Dependencies: 234
-- Name: wf_case_index2; Type: INDEX; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE INDEX wf_case_index2 ON wf_case USING btree (rdcaccount_id);


--
-- TOC entry 2297 (class 1259 OID 18675)
-- Dependencies: 236 236
-- Name: wf_token_index1; Type: INDEX; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE INDEX wf_token_index1 ON wf_token USING btree (workflow_id, place_id);


--
-- TOC entry 2298 (class 1259 OID 18676)
-- Dependencies: 236
-- Name: wf_token_index2; Type: INDEX; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE INDEX wf_token_index2 ON wf_token USING btree (rdcaccount_id);


--
-- TOC entry 2305 (class 1259 OID 18677)
-- Dependencies: 239 239
-- Name: wf_workitem_index1; Type: INDEX; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE INDEX wf_workitem_index1 ON wf_workitem USING btree (workflow_id, transition_id);


--
-- TOC entry 2306 (class 1259 OID 18678)
-- Dependencies: 239
-- Name: wf_workitem_index2; Type: INDEX; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE INDEX wf_workitem_index2 ON wf_workitem USING btree (rdcaccount_id);


--
-- TOC entry 2311 (class 0 OID 0)
-- Dependencies: 12
-- Name: workflow; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA workflow FROM PUBLIC;
REVOKE ALL ON SCHEMA workflow FROM postgres;
GRANT ALL ON SCHEMA workflow TO postgres;
GRANT USAGE ON SCHEMA workflow TO PUBLIC;


--
-- TOC entry 2312 (class 0 OID 0)
-- Dependencies: 233
-- Name: wf_arc; Type: ACL; Schema: workflow; Owner: postgres
--

REVOKE ALL ON TABLE wf_arc FROM PUBLIC;
REVOKE ALL ON TABLE wf_arc FROM postgres;
GRANT ALL ON TABLE wf_arc TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE wf_arc TO PUBLIC;


--
-- TOC entry 2313 (class 0 OID 0)
-- Dependencies: 234
-- Name: wf_case; Type: ACL; Schema: workflow; Owner: postgres
--

REVOKE ALL ON TABLE wf_case FROM PUBLIC;
REVOKE ALL ON TABLE wf_case FROM postgres;
GRANT ALL ON TABLE wf_case TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE wf_case TO PUBLIC;


--
-- TOC entry 2314 (class 0 OID 0)
-- Dependencies: 235
-- Name: wf_place; Type: ACL; Schema: workflow; Owner: postgres
--

REVOKE ALL ON TABLE wf_place FROM PUBLIC;
REVOKE ALL ON TABLE wf_place FROM postgres;
GRANT ALL ON TABLE wf_place TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE wf_place TO PUBLIC;


--
-- TOC entry 2315 (class 0 OID 0)
-- Dependencies: 236
-- Name: wf_token; Type: ACL; Schema: workflow; Owner: postgres
--

REVOKE ALL ON TABLE wf_token FROM PUBLIC;
REVOKE ALL ON TABLE wf_token FROM postgres;
GRANT ALL ON TABLE wf_token TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE wf_token TO PUBLIC;


--
-- TOC entry 2316 (class 0 OID 0)
-- Dependencies: 237
-- Name: wf_transition; Type: ACL; Schema: workflow; Owner: postgres
--

REVOKE ALL ON TABLE wf_transition FROM PUBLIC;
REVOKE ALL ON TABLE wf_transition FROM postgres;
GRANT ALL ON TABLE wf_transition TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE wf_transition TO PUBLIC;


--
-- TOC entry 2317 (class 0 OID 0)
-- Dependencies: 238
-- Name: wf_workflow; Type: ACL; Schema: workflow; Owner: postgres
--

REVOKE ALL ON TABLE wf_workflow FROM PUBLIC;
REVOKE ALL ON TABLE wf_workflow FROM postgres;
GRANT ALL ON TABLE wf_workflow TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE wf_workflow TO PUBLIC;


--
-- TOC entry 2318 (class 0 OID 0)
-- Dependencies: 239
-- Name: wf_workitem; Type: ACL; Schema: workflow; Owner: postgres
--

REVOKE ALL ON TABLE wf_workitem FROM PUBLIC;
REVOKE ALL ON TABLE wf_workitem FROM postgres;
GRANT ALL ON TABLE wf_workitem TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE wf_workitem TO PUBLIC;


-- Completed on 2011-09-15 17:18:01

--
-- PostgreSQL database dump complete
--

