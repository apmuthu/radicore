--
-- PostgreSQL database dump
--

-- Started on 2005-10-08 12:17:42 GMT Standard Time

SET client_encoding = 'UNICODE';
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 13 (class 16672 OID 27332)
-- Name: workflow; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA workflow;


ALTER SCHEMA workflow OWNER TO postgres;

SET search_path = workflow, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1353 (class 1259 OID 27333)
-- Dependencies: 1674 1675 1676 1677 13
-- Name: wf_arc; Type: TABLE; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE TABLE wf_arc (
    workflow_id smallint DEFAULT (0)::smallint NOT NULL,
    transition_id smallint DEFAULT (0)::smallint NOT NULL,
    place_id smallint DEFAULT (0)::smallint NOT NULL,
    direction character varying(3) NOT NULL,
    arc_type character varying(10),
    pre_condition text,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE workflow.wf_arc OWNER TO postgres;

--
-- TOC entry 1354 (class 1259 OID 27342)
-- Dependencies: 1678 1679 1680 1681 13
-- Name: wf_case; Type: TABLE; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE TABLE wf_case (
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
-- TOC entry 1355 (class 1259 OID 27348)
-- Dependencies: 1682 1683 1684 13
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
-- TOC entry 1356 (class 1259 OID 27356)
-- Dependencies: 1685 1686 1687 1688 1689 13
-- Name: wf_token; Type: TABLE; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE TABLE wf_token (
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
-- TOC entry 1357 (class 1259 OID 27363)
-- Dependencies: 1690 1691 1692 13
-- Name: wf_transition; Type: TABLE; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE TABLE wf_transition (
    workflow_id smallint DEFAULT (0)::smallint NOT NULL,
    transition_id smallint DEFAULT (0)::smallint NOT NULL,
    transition_name character varying(80),
    transition_desc text,
    transition_trigger character varying(4),
    time_limit integer,
    task_id character varying(40),
    role_id character varying(16),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE workflow.wf_transition OWNER TO postgres;

--
-- TOC entry 1358 (class 1259 OID 27371)
-- Dependencies: 1693 1694 13
-- Name: wf_workflow; Type: TABLE; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE TABLE wf_workflow (
    workflow_id smallint DEFAULT (0)::smallint NOT NULL,
    workflow_name character varying(80),
    workflow_desc text,
    start_task_id character varying(40),
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
-- TOC entry 1359 (class 1259 OID 27378)
-- Dependencies: 1695 1696 1697 1698 13
-- Name: wf_workitem; Type: TABLE; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE TABLE wf_workitem (
    case_id integer DEFAULT 0 NOT NULL,
    workitem_id smallint DEFAULT (0)::smallint NOT NULL,
    workflow_id smallint DEFAULT (0)::smallint NOT NULL,
    transition_id smallint DEFAULT (0)::smallint NOT NULL,
    transition_trigger character varying(4),
    task_id character varying(40),
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
-- TOC entry 1718 (class 0 OID 27333)
-- Dependencies: 1353
-- Data for Name: wf_arc; Type: TABLE DATA; Schema: workflow; Owner: postgres
--

INSERT INTO wf_arc (workflow_id, transition_id, place_id, direction, arc_type, pre_condition, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 3, 'OUT', 'SEQ', NULL, '2004-12-11 18:46:20', 'AJM', NULL, NULL);
INSERT INTO wf_arc (workflow_id, transition_id, place_id, direction, arc_type, pre_condition, created_date, created_user, revised_date, revised_user) VALUES (1, 3, 2, 'OUT', 'SEQ', NULL, '2004-12-11 18:47:37', 'AJM', NULL, NULL);
INSERT INTO wf_arc (workflow_id, transition_id, place_id, direction, arc_type, pre_condition, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 1, 'IN', 'SEQ', NULL, '2004-12-11 18:45:47', 'AJM', NULL, NULL);
INSERT INTO wf_arc (workflow_id, transition_id, place_id, direction, arc_type, pre_condition, created_date, created_user, revised_date, revised_user) VALUES (1, 3, 3, 'IN', 'SEQ', NULL, '2004-12-11 18:47:17', 'AJM', NULL, NULL);
INSERT INTO wf_arc (workflow_id, transition_id, place_id, direction, arc_type, pre_condition, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 1, 'IN', 'AND-JOIN', NULL, '2004-04-25 20:56:17', 'AJM', NULL, NULL);
INSERT INTO wf_arc (workflow_id, transition_id, place_id, direction, arc_type, pre_condition, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 3, 'IN', 'OR-SPLIT-I', NULL, '2004-04-25 21:00:26', 'AJM', NULL, NULL);
INSERT INTO wf_arc (workflow_id, transition_id, place_id, direction, arc_type, pre_condition, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 3, 'IN', 'OR-SPLIT-I', NULL, '2004-04-25 21:28:25', 'AJM', NULL, NULL);


--
-- TOC entry 1719 (class 0 OID 27342)
-- Dependencies: 1354
-- Data for Name: wf_case; Type: TABLE DATA; Schema: workflow; Owner: postgres
--



--
-- TOC entry 1720 (class 0 OID 27348)
-- Dependencies: 1355
-- Data for Name: wf_place; Type: TABLE DATA; Schema: workflow; Owner: postgres
--

INSERT INTO wf_place (workflow_id, place_id, place_type, place_name, place_desc, created_date, created_user, revised_date, revised_user) VALUES (1, 3, '5', 'p1', NULL, '2004-04-12 19:06:04', 'AJM', '2004-04-13 17:11:47', 'AJM');
INSERT INTO wf_place (workflow_id, place_id, place_type, place_name, place_desc, created_date, created_user, revised_date, revised_user) VALUES (1, 1, '1', 'START', NULL, '2004-04-13 16:47:25', 'AJM', '2004-04-14 12:22:23', 'AJM');
INSERT INTO wf_place (workflow_id, place_id, place_type, place_name, place_desc, created_date, created_user, revised_date, revised_user) VALUES (1, 2, '9', 'END', NULL, '2004-04-13 16:47:38', 'AJM', '2004-04-14 12:22:40', 'AJM');
INSERT INTO wf_place (workflow_id, place_id, place_type, place_name, place_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 1, '1', 'START', NULL, '2004-04-20 16:23:28', 'AJM', NULL, NULL);
INSERT INTO wf_place (workflow_id, place_id, place_type, place_name, place_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 2, '9', 'END', NULL, '2004-04-20 16:23:33', 'AJM', NULL, NULL);
INSERT INTO wf_place (workflow_id, place_id, place_type, place_name, place_desc, created_date, created_user, revised_date, revised_user) VALUES (3, 1, '1', 'START', NULL, '2004-04-23 16:28:42', 'AJM', NULL, NULL);
INSERT INTO wf_place (workflow_id, place_id, place_type, place_name, place_desc, created_date, created_user, revised_date, revised_user) VALUES (3, 2, '9', 'END', NULL, '2004-04-23 16:28:42', 'AJM', NULL, NULL);
INSERT INTO wf_place (workflow_id, place_id, place_type, place_name, place_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 3, '5', 'p1', NULL, '2004-04-25 16:14:28', 'AJM', NULL, NULL);
INSERT INTO wf_place (workflow_id, place_id, place_type, place_name, place_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 4, '5', 'p2', NULL, '2004-04-25 21:01:37', 'AJM', NULL, NULL);
INSERT INTO wf_place (workflow_id, place_id, place_type, place_name, place_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 5, '5', 'p3', NULL, '2004-04-25 21:47:46', 'AJM', NULL, NULL);


--
-- TOC entry 1721 (class 0 OID 27356)
-- Dependencies: 1356
-- Data for Name: wf_token; Type: TABLE DATA; Schema: workflow; Owner: postgres
--



--
-- TOC entry 1722 (class 0 OID 27363)
-- Dependencies: 1357
-- Data for Name: wf_transition; Type: TABLE DATA; Schema: workflow; Owner: postgres
--

INSERT INTO wf_transition (workflow_id, transition_id, transition_name, transition_desc, transition_trigger, time_limit, task_id, role_id, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 'Add Person Address', NULL, 'USER', NULL, 'x_person_addr(add)', 'USER1', '2004-04-20 16:25:12', 'AJM', NULL, NULL);
INSERT INTO wf_transition (workflow_id, transition_id, transition_name, transition_desc, transition_trigger, time_limit, task_id, role_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 'Add Person Address', NULL, 'USER', NULL, 'x_person_addr(add)', 'GLOBAL', '2004-04-13 17:51:02', 'AJM', '2004-04-22 14:27:22', 'AJM');
INSERT INTO wf_transition (workflow_id, transition_id, transition_name, transition_desc, transition_trigger, time_limit, task_id, role_id, created_date, created_user, revised_date, revised_user) VALUES (1, 3, 'Update Person Address', NULL, 'USER', NULL, 'x_person_addr(upd)', 'GLOBAL', '2004-04-13 17:51:31', 'AJM', '2004-04-22 14:27:30', 'AJM');
INSERT INTO wf_transition (workflow_id, transition_id, transition_name, transition_desc, transition_trigger, time_limit, task_id, role_id, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 'Add Option', NULL, 'USER', NULL, 'x_option(add)', 'USER1', '2004-04-25 21:02:58', 'AJM', '2005-07-21 14:13:31', 'AJM');


--
-- TOC entry 1723 (class 0 OID 27371)
-- Dependencies: 1358
-- Data for Name: wf_workflow; Type: TABLE DATA; Schema: workflow; Owner: postgres
--

INSERT INTO wf_workflow (workflow_id, workflow_name, workflow_desc, start_task_id, is_valid, workflow_errors, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES (1, 'This is just a test', 'This is a long description. There is currently the only workable workflow.', 'x_person(add)', 'Y', NULL, '2004-04-10', '9999-12-31', '2004-04-04 00:10:10', 'AJM', '2005-04-24 18:10:33', 'AJM');
INSERT INTO wf_workflow (workflow_id, workflow_name, workflow_desc, start_task_id, is_valid, workflow_errors, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES (2, 'This is another test', 'Just a test. It has lots of errors.', 'x_person(add)', 'N', 'There are no ARCS going into the END place.
There are no OUTWARD ARCS for place ''p1''
There are no INWARD ARCS for place ''p2''
There are no OUTWARD ARCS for place ''p2''
There are no INWARD ARCS for place ''p3''
There are no OUTWARD ARCS for place ''p3''
Not enough arcs of type ''AND-join'' at transition ''Add Person Address''
There is more than 1 type of INWARD ARC for transition ''Add Person Address''
There are no OUTWARD ARCS for transition ''Add Person Address''
There are no OUTWARD ARCS for transition ''Add Option''
', '2004-01-01', '2004-01-31', '2004-04-20 16:23:27', 'AJM', '2005-07-21 14:14:08', 'AJM');
INSERT INTO wf_workflow (workflow_id, workflow_name, workflow_desc, start_task_id, is_valid, workflow_errors, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES (3, 'Yet another test', 'This is another test with errors.', 'x_option(add)', 'N', 'There are no intermediate places.
There are no TRANSITIONS.
There are no ARCS.
There are no ARCS coming out of the START place.
There are no ARCS going into the END place.
', '2004-04-01', '9999-12-31', '2004-04-23 16:28:42', 'AJM', '2005-07-21 12:51:44', 'AJM');


--
-- TOC entry 1724 (class 0 OID 27378)
-- Dependencies: 1359
-- Data for Name: wf_workitem; Type: TABLE DATA; Schema: workflow; Owner: postgres
--



--
-- TOC entry 1702 (class 16386 OID 27385)
-- Dependencies: 1353 1353 1353 1353 1353
-- Name: wf_arc_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_arc
    ADD CONSTRAINT wf_arc_pkey PRIMARY KEY (workflow_id, transition_id, place_id, direction);


ALTER INDEX workflow.wf_arc_pkey OWNER TO postgres;

--
-- TOC entry 1705 (class 16386 OID 27387)
-- Dependencies: 1354 1354
-- Name: wf_case_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_case
    ADD CONSTRAINT wf_case_pkey PRIMARY KEY (case_id);


ALTER INDEX workflow.wf_case_pkey OWNER TO postgres;

--
-- TOC entry 1707 (class 16386 OID 27389)
-- Dependencies: 1355 1355 1355
-- Name: wf_place_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_place
    ADD CONSTRAINT wf_place_pkey PRIMARY KEY (workflow_id, place_id);


ALTER INDEX workflow.wf_place_pkey OWNER TO postgres;

--
-- TOC entry 1710 (class 16386 OID 27391)
-- Dependencies: 1356 1356 1356
-- Name: wf_token_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_token
    ADD CONSTRAINT wf_token_pkey PRIMARY KEY (case_id, token_id);


ALTER INDEX workflow.wf_token_pkey OWNER TO postgres;

--
-- TOC entry 1712 (class 16386 OID 27393)
-- Dependencies: 1357 1357 1357
-- Name: wf_transition_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_transition
    ADD CONSTRAINT wf_transition_pkey PRIMARY KEY (workflow_id, transition_id);


ALTER INDEX workflow.wf_transition_pkey OWNER TO postgres;

--
-- TOC entry 1714 (class 16386 OID 27395)
-- Dependencies: 1358 1358
-- Name: wf_workflow_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_workflow
    ADD CONSTRAINT wf_workflow_pkey PRIMARY KEY (workflow_id);


ALTER INDEX workflow.wf_workflow_pkey OWNER TO postgres;

--
-- TOC entry 1717 (class 16386 OID 27397)
-- Dependencies: 1359 1359 1359
-- Name: wf_workitem_pkey; Type: CONSTRAINT; Schema: workflow; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wf_workitem
    ADD CONSTRAINT wf_workitem_pkey PRIMARY KEY (case_id, workitem_id);


ALTER INDEX workflow.wf_workitem_pkey OWNER TO postgres;

--
-- TOC entry 1699 (class 1259 OID 27398)
-- Dependencies: 1353 1353 1353
-- Name: wf_arc_index1; Type: INDEX; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE INDEX wf_arc_index1 ON wf_arc USING btree (workflow_id, place_id, direction);


ALTER INDEX workflow.wf_arc_index1 OWNER TO postgres;

--
-- TOC entry 1700 (class 1259 OID 27399)
-- Dependencies: 1353 1353 1353
-- Name: wf_arc_index2; Type: INDEX; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE INDEX wf_arc_index2 ON wf_arc USING btree (workflow_id, transition_id, direction);


ALTER INDEX workflow.wf_arc_index2 OWNER TO postgres;

--
-- TOC entry 1703 (class 1259 OID 27400)
-- Dependencies: 1354
-- Name: wf_case_index; Type: INDEX; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE INDEX wf_case_index ON wf_case USING btree (workflow_id);


ALTER INDEX workflow.wf_case_index OWNER TO postgres;

--
-- TOC entry 1708 (class 1259 OID 27401)
-- Dependencies: 1356 1356
-- Name: wf_token_index; Type: INDEX; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE INDEX wf_token_index ON wf_token USING btree (workflow_id, place_id);


ALTER INDEX workflow.wf_token_index OWNER TO postgres;

--
-- TOC entry 1715 (class 1259 OID 27402)
-- Dependencies: 1359 1359
-- Name: wf_workitem_index; Type: INDEX; Schema: workflow; Owner: postgres; Tablespace: 
--

CREATE INDEX wf_workitem_index ON wf_workitem USING btree (workflow_id, transition_id);


ALTER INDEX workflow.wf_workitem_index OWNER TO postgres;

-- Completed on 2005-10-08 12:17:43 GMT Standard Time

--
-- PostgreSQL database dump complete
--

