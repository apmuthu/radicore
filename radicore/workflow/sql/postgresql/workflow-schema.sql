--
-- PostgreSQL database dump
--

-- Started on 2006-12-08 11:34:59

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 11 (class 2615 OID 17815)
-- Name: workflow; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA workflow;


ALTER SCHEMA workflow OWNER TO postgres;

SET search_path = workflow, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1467 (class 1259 OID 18364)
-- Dependencies: 1835 1836 1837 1838 1839 11
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
-- TOC entry 1468 (class 1259 OID 18373)
-- Dependencies: 1840 1841 1842 1843 11
-- Name: wf_case; Type: TABLE; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE TABLE wf_case (
    rdcaccount_id integer NOT NULL default 1,
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
-- TOC entry 1469 (class 1259 OID 18379)
-- Dependencies: 1844 1845 1846 11
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
-- TOC entry 1470 (class 1259 OID 18387)
-- Dependencies: 1847 1848 1849 1850 1851 11
-- Name: wf_token; Type: TABLE; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE TABLE wf_token (
    rdcaccount_id integer NOT NULL default 1,
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
-- TOC entry 1471 (class 1259 OID 18394)
-- Dependencies: 1852 1853 1854 1855 11
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
-- TOC entry 1472 (class 1259 OID 18403)
-- Dependencies: 1856 1857 11
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
-- TOC entry 1473 (class 1259 OID 18410)
-- Dependencies: 1858 1859 1860 1861 11
-- Name: wf_workitem; Type: TABLE; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE TABLE wf_workitem (
    rdcaccount_id integer NOT NULL default 1,
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
-- TOC entry 1865 (class 2606 OID 18621)
-- Dependencies: 1467 1467 1467 1467 1467
-- Name: wf_arc_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_arc
    ADD CONSTRAINT wf_arc_pkey PRIMARY KEY (workflow_id, transition_id, place_id, direction);


--
-- TOC entry 1868 (class 2606 OID 18623)
-- Dependencies: 1468 1468
-- Name: wf_case_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_case
    ADD CONSTRAINT wf_case_pkey PRIMARY KEY (case_id);


--
-- TOC entry 1870 (class 2606 OID 18625)
-- Dependencies: 1469 1469 1469
-- Name: wf_place_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_place
    ADD CONSTRAINT wf_place_pkey PRIMARY KEY (workflow_id, place_id);


--
-- TOC entry 1873 (class 2606 OID 18627)
-- Dependencies: 1470 1470 1470
-- Name: wf_token_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_token
    ADD CONSTRAINT wf_token_pkey PRIMARY KEY (case_id, token_id);


--
-- TOC entry 1875 (class 2606 OID 18629)
-- Dependencies: 1471 1471 1471
-- Name: wf_transition_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_transition
    ADD CONSTRAINT wf_transition_pkey PRIMARY KEY (workflow_id, transition_id);


--
-- TOC entry 1877 (class 2606 OID 18631)
-- Dependencies: 1472 1472
-- Name: wf_workflow_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_workflow
    ADD CONSTRAINT wf_workflow_pkey PRIMARY KEY (workflow_id);


--
-- TOC entry 1880 (class 2606 OID 18633)
-- Dependencies: 1473 1473 1473
-- Name: wf_workitem_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_workitem
    ADD CONSTRAINT wf_workitem_pkey PRIMARY KEY (case_id, workitem_id);


--
-- TOC entry 1862 (class 1259 OID 18664)
-- Dependencies: 1467 1467 1467
-- Name: wf_arc_index1; Type: INDEX; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE INDEX wf_arc_index1 ON wf_arc USING btree (workflow_id, place_id, direction);


--
-- TOC entry 1863 (class 1259 OID 18665)
-- Dependencies: 1467 1467 1467
-- Name: wf_arc_index2; Type: INDEX; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE INDEX wf_arc_index2 ON wf_arc USING btree (workflow_id, transition_id, direction);


--
-- TOC entry 1866 (class 1259 OID 18666)
-- Dependencies: 1468
-- Name: wf_case_index; Type: INDEX; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE INDEX wf_case_index1 ON wf_case USING btree (workflow_id);
CREATE INDEX wf_case_index2 ON wf_case USING btree (rdcaccount_id);


--
-- TOC entry 1871 (class 1259 OID 18667)
-- Dependencies: 1470 1470
-- Name: wf_token_index; Type: INDEX; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE INDEX wf_token_index1 ON wf_token USING btree (workflow_id, place_id);
CREATE INDEX wf_token_index2 ON wf_token USING btree (rdcaccount_id);


--
-- TOC entry 1878 (class 1259 OID 18668)
-- Dependencies: 1473 1473
-- Name: wf_workitem_index; Type: INDEX; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE INDEX wf_workitem_index1 ON wf_workitem USING btree (workflow_id, transition_id);
CREATE INDEX wf_workitem_index2 ON wf_workitem USING btree (rdcaccount_id);


--
-- TOC entry 1883 (class 0 OID 0)
-- Dependencies: 11
-- Name: workflow; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA workflow FROM PUBLIC;
REVOKE ALL ON SCHEMA workflow FROM postgres;
GRANT ALL ON SCHEMA workflow TO postgres;
GRANT USAGE ON SCHEMA workflow TO PUBLIC;


--
-- TOC entry 1884 (class 0 OID 0)
-- Dependencies: 1467
-- Name: wf_arc; Type: ACL; Schema: workflow; Owner: postgres
--

REVOKE ALL ON TABLE wf_arc FROM PUBLIC;
REVOKE ALL ON TABLE wf_arc FROM postgres;
GRANT ALL ON TABLE wf_arc TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE wf_arc TO PUBLIC;


--
-- TOC entry 1885 (class 0 OID 0)
-- Dependencies: 1468
-- Name: wf_case; Type: ACL; Schema: workflow; Owner: postgres
--

REVOKE ALL ON TABLE wf_case FROM PUBLIC;
REVOKE ALL ON TABLE wf_case FROM postgres;
GRANT ALL ON TABLE wf_case TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE wf_case TO PUBLIC;


--
-- TOC entry 1886 (class 0 OID 0)
-- Dependencies: 1469
-- Name: wf_place; Type: ACL; Schema: workflow; Owner: postgres
--

REVOKE ALL ON TABLE wf_place FROM PUBLIC;
REVOKE ALL ON TABLE wf_place FROM postgres;
GRANT ALL ON TABLE wf_place TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE wf_place TO PUBLIC;


--
-- TOC entry 1887 (class 0 OID 0)
-- Dependencies: 1470
-- Name: wf_token; Type: ACL; Schema: workflow; Owner: postgres
--

REVOKE ALL ON TABLE wf_token FROM PUBLIC;
REVOKE ALL ON TABLE wf_token FROM postgres;
GRANT ALL ON TABLE wf_token TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE wf_token TO PUBLIC;


--
-- TOC entry 1888 (class 0 OID 0)
-- Dependencies: 1471
-- Name: wf_transition; Type: ACL; Schema: workflow; Owner: postgres
--

REVOKE ALL ON TABLE wf_transition FROM PUBLIC;
REVOKE ALL ON TABLE wf_transition FROM postgres;
GRANT ALL ON TABLE wf_transition TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE wf_transition TO PUBLIC;


--
-- TOC entry 1889 (class 0 OID 0)
-- Dependencies: 1472
-- Name: wf_workflow; Type: ACL; Schema: workflow; Owner: postgres
--

REVOKE ALL ON TABLE wf_workflow FROM PUBLIC;
REVOKE ALL ON TABLE wf_workflow FROM postgres;
GRANT ALL ON TABLE wf_workflow TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE wf_workflow TO PUBLIC;


--
-- TOC entry 1890 (class 0 OID 0)
-- Dependencies: 1473
-- Name: wf_workitem; Type: ACL; Schema: workflow; Owner: postgres
--

REVOKE ALL ON TABLE wf_workitem FROM PUBLIC;
REVOKE ALL ON TABLE wf_workitem FROM postgres;
GRANT ALL ON TABLE wf_workitem TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE wf_workitem TO PUBLIC;


-- Completed on 2006-12-08 11:35:00

--
-- PostgreSQL database dump complete
--

