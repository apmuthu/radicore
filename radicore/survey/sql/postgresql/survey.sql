--
-- PostgreSQL database dump
--

-- Started on 2005-09-14 18:51:43 GMT Standard Time

SET client_encoding = 'UNICODE';
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 13 (class 16672 OID 23714)
-- Name: survey; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA survey;


ALTER SCHEMA survey OWNER TO postgres;

SET search_path = survey, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1347 (class 1259 OID 23715)
-- Dependencies: 1678 1679 1680 1681 1682 1683 1684 1685 13
-- Name: answer_option; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE answer_option (
    survey_id smallint DEFAULT 0::smallint NOT NULL,
    section_id smallint DEFAULT 0::smallint NOT NULL,
    question_id smallint DEFAULT 0::smallint NOT NULL,
    answer_id smallint DEFAULT 0::smallint NOT NULL,
    answer_seq smallint DEFAULT 0::smallint NOT NULL,
    answer_text character varying(255) DEFAULT '0'::character varying NOT NULL,
    jumpto_section_seq smallint,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.answer_option OWNER TO postgres;

--
-- TOC entry 1348 (class 1259 OID 23727)
-- Dependencies: 1686 1687 1688 1689 13
-- Name: asset_type; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE asset_type (
    asset_type_id smallint DEFAULT 0::smallint NOT NULL,
    asset_type_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    image_fname character varying(255),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.asset_type OWNER TO postgres;

--
-- TOC entry 1349 (class 1259 OID 23735)
-- Dependencies: 1690 1691 1692 1693 1694 13
-- Name: default_prompt; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE default_prompt (
    survey_id smallint DEFAULT 0::smallint NOT NULL,
    prompt_id smallint DEFAULT 0::smallint NOT NULL,
    prompt_desc character varying(30) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.default_prompt OWNER TO postgres;

--
-- TOC entry 1350 (class 1259 OID 23744)
-- Dependencies: 1695 1696 1697 13
-- Name: location_address; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE location_address (
    node_id smallint DEFAULT 0::smallint NOT NULL,
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
-- TOC entry 1351 (class 1259 OID 23751)
-- Dependencies: 1698 1699 1700 1701 13
-- Name: location_type; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE location_type (
    location_type_id smallint DEFAULT 0::smallint NOT NULL,
    location_type_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    image_fname character varying(255),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.location_type OWNER TO postgres;

--
-- TOC entry 1352 (class 1259 OID 23759)
-- Dependencies: 1702 1703 1704 1705 1706 1707 1708 13
-- Name: number_option; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE number_option (
    survey_id smallint DEFAULT 0::smallint NOT NULL,
    section_id smallint DEFAULT 0::smallint NOT NULL,
    question_id smallint DEFAULT 0::smallint NOT NULL,
    min_value integer DEFAULT 0,
    max_value integer DEFAULT 0,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.number_option OWNER TO postgres;

--
-- TOC entry 1353 (class 1259 OID 23770)
-- Dependencies: 1709 1710 1711 1712 13
-- Name: org_type; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE org_type (
    org_type_id smallint DEFAULT 0::smallint NOT NULL,
    org_type_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    image_fname character varying(255),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.org_type OWNER TO postgres;

--
-- TOC entry 1354 (class 1259 OID 23778)
-- Dependencies: 1713 1714 1715 1716 1717 1718 13
-- Name: question_prompt; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE question_prompt (
    survey_id smallint DEFAULT 0::smallint NOT NULL,
    section_id smallint DEFAULT 0::smallint NOT NULL,
    question_id smallint DEFAULT 0::smallint NOT NULL,
    prompt_id smallint DEFAULT 0::smallint NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.question_prompt OWNER TO postgres;

--
-- TOC entry 1355 (class 1259 OID 23788)
-- Dependencies: 1719 1720 1721 1722 13
-- Name: risk_status; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE risk_status (
    risk_status_id smallint DEFAULT 0::smallint NOT NULL,
    risk_status_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.risk_status OWNER TO postgres;

--
-- TOC entry 1356 (class 1259 OID 23796)
-- Dependencies: 1723 1724 1725 1726 13
-- Name: risk_weighting; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE risk_weighting (
    weighting_id smallint DEFAULT 0::smallint NOT NULL,
    weighting_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.risk_weighting OWNER TO postgres;

--
-- TOC entry 1357 (class 1259 OID 23804)
-- Dependencies: 1727 1728 1729 1730 1731 1732 1733 1734 13
-- Name: survey_answer_dtl; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE survey_answer_dtl (
    survey_answer_id integer DEFAULT 0 NOT NULL,
    survey_id smallint DEFAULT 0::smallint NOT NULL,
    section_id smallint DEFAULT 0::smallint NOT NULL,
    question_id smallint DEFAULT 0::smallint NOT NULL,
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
-- TOC entry 1358 (class 1259 OID 23816)
-- Dependencies: 1735 1736 1737 1738 1739 1740 13
-- Name: survey_answer_hdr; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE survey_answer_hdr (
    survey_answer_id integer DEFAULT 0 NOT NULL,
    user_id character varying(16),
    answer_date date DEFAULT '2000-01-01'::date NOT NULL,
    survey_id smallint DEFAULT 0::smallint NOT NULL,
    node_id smallint DEFAULT 0::smallint NOT NULL,
    is_complete character(1) DEFAULT 'N'::bpchar NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.survey_answer_hdr OWNER TO postgres;

--
-- TOC entry 1359 (class 1259 OID 23826)
-- Dependencies: 1741 1742 1743 1744 1745 1746 13
-- Name: survey_hdr; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE survey_hdr (
    survey_id smallint DEFAULT 0::smallint NOT NULL,
    survey_name character varying(80) DEFAULT ''::character varying NOT NULL,
    survey_desc character varying(255) DEFAULT ''::character varying NOT NULL,
    survey_type_id character varying(4) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.survey_hdr OWNER TO postgres;

--
-- TOC entry 1360 (class 1259 OID 23836)
-- Dependencies: 1747 1748 1749 1750 1751 1752 1753 1754 1755 13
-- Name: survey_question; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE survey_question (
    survey_id smallint DEFAULT 0::smallint NOT NULL,
    section_id smallint DEFAULT 0::smallint NOT NULL,
    question_id smallint DEFAULT 0::smallint NOT NULL,
    question_seq smallint DEFAULT 0::smallint NOT NULL,
    question_text character varying(255) DEFAULT ''::character varying NOT NULL,
    answer_type character(1) DEFAULT ''::bpchar NOT NULL,
    advice_text text,
    risk_status_id smallint DEFAULT 0::smallint NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.survey_question OWNER TO postgres;

--
-- TOC entry 1361 (class 1259 OID 23852)
-- Dependencies: 1756 1757 1758 1759 1760 1761 13
-- Name: survey_section; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE survey_section (
    survey_id smallint DEFAULT 0::smallint NOT NULL,
    section_id smallint DEFAULT 0::smallint NOT NULL,
    section_seq smallint DEFAULT 0::smallint NOT NULL,
    section_name character varying(80) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE survey.survey_section OWNER TO postgres;

--
-- TOC entry 1362 (class 1259 OID 23862)
-- Dependencies: 1762 1763 1764 1765 13
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
-- TOC entry 1363 (class 1259 OID 23870)
-- Dependencies: 1766 1767 1768 1769 1770 1771 13
-- Name: tree_node; Type: TABLE; Schema: survey; Owner: postgres; Tablespace: 
--

CREATE TABLE tree_node (
    node_id smallint DEFAULT 0::smallint NOT NULL,
    node_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    node_type character(1) DEFAULT ''::bpchar NOT NULL,
    node_depth smallint DEFAULT 0::smallint NOT NULL,
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
-- TOC entry 1806 (class 0 OID 23715)
-- Dependencies: 1347
-- Data for Name: answer_option; Type: TABLE DATA; Schema: survey; Owner: postgres
--

INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 2, 1, 1, 'Yes', NULL, '2003-10-18 21:17:25', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 1, 1, 1, 'Yes', NULL, '2003-09-25 19:04:04', 'AJM', '2003-10-19 17:55:18', 'AJM');
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 1, 2, 2, 'No', NULL, '2003-09-25 19:04:04', 'AJM', '2003-10-19 17:55:23', 'AJM');
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 1, 2, 2, 'No', NULL, '2003-10-29 19:08:37', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 1, 1, 1, 'Yes', NULL, '2003-10-29 19:08:37', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 2, 2, 2, 'No', NULL, '2003-10-28 21:59:08', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 3, 1, 1, 'Yes', NULL, '2003-10-05 10:00:38', 'AJM', '2003-10-28 23:30:47', 'AJM');
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 3, 2, 2, 'No', NULL, '2003-10-05 10:00:48', 'AJM', '2003-10-28 23:30:47', 'AJM');
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 4, 1, 1, 'Yes', NULL, '2003-10-05 10:01:21', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 4, 2, 2, 'No', NULL, '2003-10-05 10:01:33', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 5, 1, 1, 'Yes', NULL, '2003-10-05 10:02:05', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 5, 2, 2, 'No', NULL, '2003-10-05 10:02:15', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 5, 3, 3, 'Not Applicable', NULL, '2003-10-05 10:02:29', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 6, 1, 1, 'Yes', NULL, '2003-10-05 10:03:07', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 6, 2, 2, 'No', NULL, '2003-10-05 10:03:17', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 6, 3, 3, 'Not Applicable', NULL, '2003-10-05 10:03:31', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 7, 1, 1, 'Yes', NULL, '2003-10-05 10:04:21', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 7, 2, 2, 'No', NULL, '2003-10-05 10:04:31', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 8, 1, 1, 'Yes', NULL, '2003-10-05 10:05:28', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 8, 2, 2, 'No', NULL, '2003-10-05 10:05:38', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 9, 1, 1, 'Yes', NULL, '2003-10-05 10:06:14', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 9, 2, 2, 'No', NULL, '2003-10-05 10:06:24', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 10, 1, 1, 'Yes', NULL, '2003-10-05 10:07:07', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 10, 2, 2, 'No', NULL, '2003-10-05 10:07:18', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 3, 1, 1, 1, 'Yes', NULL, '2003-10-05 16:54:31', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 3, 1, 2, 2, 'No', NULL, '2003-10-05 16:54:42', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 3, 2, 1, 1, 'Yes', NULL, '2003-10-05 16:55:22', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 3, 2, 2, 2, 'No', NULL, '2003-10-05 16:55:33', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 4, 1, 1, 1, 'Yes', NULL, '2003-10-05 16:57:27', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 4, 1, 2, 2, 'No', NULL, '2003-10-05 16:57:37', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 4, 2, 1, 1, 'Yes', NULL, '2003-10-05 16:58:11', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 4, 2, 2, 2, 'No', NULL, '2003-10-05 16:58:21', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 4, 3, 1, 1, 'Yes', NULL, '2003-10-05 16:59:09', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 4, 3, 2, 2, 'No', NULL, '2003-10-05 16:59:19', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 4, 4, 1, 1, 'Yes', NULL, '2003-10-05 16:59:56', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 4, 4, 2, 2, 'No', NULL, '2003-10-05 17:00:13', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 1, 1, 1, 'Yes', NULL, '2003-10-05 17:01:12', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 1, 2, 2, 'No', NULL, '2003-10-05 17:01:23', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 2, 1, 1, 'Yes', NULL, '2003-10-05 17:01:56', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 2, 2, 2, 'No', NULL, '2003-10-05 17:02:07', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 3, 1, 1, 'Yes', NULL, '2003-10-05 17:02:40', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 3, 2, 2, 'No', NULL, '2003-10-05 17:02:51', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 1, 1, 1, 'Yes', NULL, '2003-10-05 17:03:48', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 1, 2, 2, 'No', NULL, '2003-10-05 17:03:59', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 1, 3, 3, 'Not Applicable', NULL, '2003-10-05 17:04:13', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 2, 1, 1, 'Yes', NULL, '2003-10-05 17:04:47', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 2, 2, 2, 'No', NULL, '2003-10-05 17:04:57', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 2, 3, 3, 'Not Applicable', NULL, '2003-10-05 17:05:10', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 7, 1, 1, 1, 'Yes', NULL, '2003-10-05 17:08:33', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 7, 1, 2, 2, 'No', NULL, '2003-10-05 17:08:43', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 7, 2, 1, 1, 'Yes', NULL, '2003-10-05 17:09:39', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 7, 2, 2, 2, 'No', NULL, '2003-10-05 17:09:50', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 1, 1, 1, 'Yes', NULL, '2003-10-05 17:10:39', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 1, 2, 2, 'No', NULL, '2003-10-05 17:10:50', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 2, 1, 1, 'Yes', NULL, '2003-10-05 17:11:40', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 2, 2, 2, 'No', NULL, '2003-10-05 17:11:51', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 3, 1, 1, 'Yes', NULL, '2003-10-05 17:12:48', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 3, 2, 2, 'No', NULL, '2003-10-05 17:12:59', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 4, 1, 1, 'Yes', NULL, '2003-10-05 17:13:57', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 4, 2, 2, 'No', NULL, '2003-10-05 17:14:07', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 1, 1, 1, 'Yes', NULL, '2003-10-05 17:15:07', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 1, 2, 2, 'No', NULL, '2003-10-05 17:15:17', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 2, 1, 1, 'Yes', NULL, '2003-10-05 17:15:48', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 2, 2, 2, 'No', NULL, '2003-10-05 17:15:57', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 3, 1, 1, 'Yes', NULL, '2003-10-05 17:16:30', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 3, 2, 2, 'No', NULL, '2003-10-05 17:16:39', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 4, 1, 1, 'Yes', NULL, '2003-10-05 17:17:18', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 4, 2, 2, 'No', NULL, '2003-10-05 17:17:29', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 5, 1, 1, 'Yes', NULL, '2003-10-05 17:18:06', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 5, 2, 2, 'No', NULL, '2003-10-05 17:18:54', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 6, 1, 1, 'Yes', NULL, '2003-10-05 17:20:26', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 6, 2, 2, 'No', NULL, '2003-10-05 17:20:36', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 7, 1, 1, 'Yes', NULL, '2003-10-05 17:22:43', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 7, 2, 2, 'No', NULL, '2003-10-05 17:22:52', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 8, 1, 1, 'Yes', NULL, '2003-10-05 17:23:51', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 8, 2, 2, 'No', NULL, '2003-10-05 17:24:01', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 8, 3, 3, 'Not Applicable', NULL, '2003-10-05 17:24:12', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 9, 1, 1, 'Yes', NULL, '2003-10-05 17:25:24', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 9, 2, 2, 'No', NULL, '2003-10-05 17:25:34', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 10, 1, 1, 'Yes', NULL, '2003-10-05 17:26:16', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 10, 2, 2, 'No', NULL, '2003-10-05 17:26:26', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 11, 1, 1, 'Yes', NULL, '2003-10-05 17:26:58', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 11, 2, 2, 'No', NULL, '2003-10-05 17:27:08', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 1, 1, 1, 'Yes', NULL, '2003-10-05 17:28:01', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 1, 2, 2, 'No', NULL, '2003-10-05 17:28:11', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 2, 1, 1, 'Yes', NULL, '2003-10-05 17:28:41', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 2, 2, 2, 'No', NULL, '2003-10-05 17:28:51', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 3, 1, 1, 'Yes', NULL, '2003-10-05 17:29:26', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 3, 2, 2, 'No', NULL, '2003-10-05 17:29:37', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 4, 1, 1, 'Yes', NULL, '2003-10-05 17:30:46', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 4, 2, 2, 'No', NULL, '2003-10-05 17:30:56', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 5, 1, 1, 'Yes', NULL, '2003-10-05 17:31:49', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 5, 2, 2, 'No', NULL, '2003-10-05 17:31:58', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 6, 1, 1, 'Yes', NULL, '2003-10-05 17:32:50', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 6, 2, 2, 'No', NULL, '2003-10-05 17:32:59', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 7, 1, 1, 'Yes', NULL, '2003-10-05 17:33:28', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 7, 2, 2, 'No', NULL, '2003-10-05 17:33:37', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 7, 3, 3, 'Not Applicable', NULL, '2003-10-05 17:33:48', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 8, 1, 1, 'Yes', NULL, '2003-10-05 17:34:18', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 8, 2, 2, 'No', NULL, '2003-10-05 17:34:27', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 1, 1, 1, 'Yes', NULL, '2003-10-05 17:36:10', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 1, 2, 2, 'No', NULL, '2003-10-05 17:36:20', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 2, 1, 1, 'Yes', NULL, '2003-10-05 17:37:55', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 2, 2, 2, 'No', NULL, '2003-10-05 17:38:06', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 3, 1, 1, 'Yes', NULL, '2003-10-05 17:39:09', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 3, 2, 2, 'No', NULL, '2003-10-05 17:39:19', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 4, 1, 1, 'Yes', NULL, '2003-10-05 17:39:51', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 4, 2, 2, 'No', NULL, '2003-10-05 17:40:00', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 5, 1, 1, 'Yes', NULL, '2003-10-05 17:40:58', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 5, 2, 2, 'No', NULL, '2003-10-05 17:41:07', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 5, 3, 3, 'Not Applicable', NULL, '2003-10-05 17:41:19', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 6, 1, 1, 'Yes', NULL, '2003-10-05 17:41:52', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 6, 2, 2, 'No', NULL, '2003-10-05 17:42:01', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 6, 3, 3, 'Not Applicable', NULL, '2003-10-05 17:42:24', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 7, 1, 1, 'Yes', NULL, '2003-10-05 17:42:58', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 7, 2, 2, 'No', NULL, '2003-10-05 17:43:08', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 7, 3, 3, 'Not Applicable', NULL, '2003-10-05 17:43:24', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 8, 1, 1, 'Yes', NULL, '2003-10-05 17:43:51', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 8, 2, 2, 'No', NULL, '2003-10-05 17:44:00', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 9, 1, 1, 'Yes', NULL, '2003-10-05 17:44:25', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 9, 2, 2, 'No', NULL, '2003-10-05 17:44:36', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 10, 1, 1, 'Yes', NULL, '2003-10-05 17:45:05', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 10, 2, 2, 'No', NULL, '2003-10-05 17:45:15', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 11, 1, 1, 'Yes', NULL, '2003-10-05 17:45:51', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 11, 2, 2, 'No', NULL, '2003-10-05 17:46:00', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 1, 1, 1, 'Yes', NULL, '2003-10-05 17:47:30', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 1, 2, 2, 'No', NULL, '2003-10-05 17:47:41', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 2, 1, 1, 'Yes', NULL, '2003-10-05 17:48:20', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 2, 2, 2, 'No', NULL, '2003-10-05 17:48:29', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 2, 3, 3, 'Not Applicable', NULL, '2003-10-05 17:48:39', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 3, 1, 1, 'Yes', NULL, '2003-10-05 17:49:14', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 3, 2, 2, 'No', NULL, '2003-10-05 17:50:33', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 4, 1, 1, 'Yes', NULL, '2003-10-05 17:51:04', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 4, 2, 2, 'No', NULL, '2003-10-05 17:51:13', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 5, 1, 1, 'Yes', NULL, '2003-10-05 17:51:44', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 5, 2, 2, 'No', NULL, '2003-10-05 17:51:53', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 1, 1, 1, 'Yes', NULL, '2003-10-05 17:52:42', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 1, 2, 2, 'No', NULL, '2003-10-05 17:52:51', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 2, 1, 1, 'Yes', NULL, '2003-10-05 17:53:20', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 2, 2, 2, 'No', NULL, '2003-10-05 17:53:31', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 3, 1, 1, 'Yes', NULL, '2003-10-05 17:54:00', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 3, 2, 2, 'No', NULL, '2003-10-05 17:54:10', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 4, 1, 1, 'Yes', NULL, '2003-10-05 17:54:44', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 4, 2, 2, 'No', NULL, '2003-10-05 17:54:54', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 1, 1, 1, 'Yes', NULL, '2003-10-05 17:55:44', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 1, 2, 2, 'No', NULL, '2003-10-05 17:55:54', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 2, 1, 1, 'Yes', NULL, '2003-10-05 17:56:19', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 2, 2, 2, 'No', NULL, '2003-10-05 17:56:28', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 2, 3, 3, 'Not Applicable', NULL, '2003-10-05 17:56:39', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 3, 1, 1, 'Yes', NULL, '2003-10-05 17:57:06', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 3, 2, 2, 'No', NULL, '2003-10-05 17:57:15', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 4, 1, 1, 'Yes', NULL, '2003-10-05 17:57:39', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 4, 2, 2, 'No', NULL, '2003-10-05 17:57:49', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 5, 1, 1, 'Yes', NULL, '2003-10-05 17:59:18', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 5, 2, 2, 'No', NULL, '2003-10-05 17:59:30', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 1, 1, 1, 'Yes', NULL, '2003-10-05 18:00:28', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 1, 2, 2, 'No', NULL, '2003-10-05 18:00:37', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 2, 1, 1, 'Yes', NULL, '2003-10-05 18:01:02', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 2, 2, 2, 'No', NULL, '2003-10-05 18:01:11', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 2, 3, 3, 'Not Applicable', NULL, '2003-10-05 18:01:22', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 3, 1, 1, 'Yes', NULL, '2003-10-05 18:01:53', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 3, 2, 2, 'No', NULL, '2003-10-05 18:02:02', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 3, 3, 3, 'Not Applicable', NULL, '2003-10-05 18:02:14', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 4, 1, 1, 'Yes', NULL, '2003-10-05 18:02:40', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 4, 2, 2, 'No', NULL, '2003-10-05 18:02:50', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 4, 3, 3, 'Not Applicable', NULL, '2003-10-05 18:03:04', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 1, 1, 1, 'Yes', NULL, '2003-10-05 18:04:13', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 1, 2, 2, 'No', NULL, '2003-10-05 18:04:22', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 2, 1, 1, 'Yes', NULL, '2003-10-05 18:04:53', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 2, 2, 2, 'No', NULL, '2003-10-05 18:05:02', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 3, 1, 1, 'Yes', NULL, '2003-10-05 18:06:26', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 3, 2, 2, 'No', NULL, '2003-10-05 18:06:35', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 4, 1, 1, 'Yes', NULL, '2003-10-05 18:07:04', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 4, 2, 2, 'No', NULL, '2003-10-05 18:07:14', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 1, 1, 1, 'Yes', NULL, '2003-10-05 18:08:01', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 1, 2, 2, 'No', NULL, '2003-10-05 18:08:11', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 2, 1, 1, 'Yes', NULL, '2003-10-05 18:08:40', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 2, 2, 2, 'No', NULL, '2003-10-05 18:08:49', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 3, 1, 1, 'Yes', NULL, '2003-10-05 18:10:32', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 3, 2, 2, 'No', NULL, '2003-10-05 18:10:44', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 18, 1, 1, 1, 'Yes', NULL, '2003-10-05 18:11:31', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 18, 1, 2, 2, 'No', NULL, '2003-10-05 18:11:40', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 18, 2, 1, 1, 'Yes', NULL, '2003-10-05 18:12:09', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 18, 2, 2, 2, 'No', NULL, '2003-10-05 18:12:20', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 19, 1, 1, 1, 'Yes', NULL, '2003-10-05 18:13:03', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 19, 1, 2, 2, 'No', NULL, '2003-10-05 18:13:12', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 20, 1, 1, 1, 'Yes', NULL, '2003-10-05 18:14:00', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 20, 1, 2, 2, 'No', NULL, '2003-10-05 18:14:11', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 20, 2, 1, 1, 'Yes', NULL, '2003-10-05 18:14:34', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 20, 2, 2, 2, 'No', NULL, '2003-10-05 18:14:43', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 20, 3, 1, 1, 'Yes', NULL, '2003-10-05 18:15:34', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 20, 3, 2, 2, 'No', NULL, '2003-10-05 18:18:25', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 1, 1, 1, 'Yes', NULL, '2003-10-05 18:19:25', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 1, 2, 2, 'No', NULL, '2003-10-05 18:19:36', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 2, 1, 1, 'Yes', NULL, '2003-10-05 18:20:08', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 2, 2, 2, 'No', NULL, '2003-10-05 18:20:17', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 3, 1, 1, 'Yes', NULL, '2003-10-05 18:20:55', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 3, 2, 2, 'No', NULL, '2003-10-05 18:21:05', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 4, 1, 1, 'Yes', NULL, '2003-10-05 18:21:34', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 4, 2, 2, 'No', NULL, '2003-10-05 18:21:43', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 22, 1, 1, 1, 'Yes', NULL, '2003-10-05 18:22:35', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 22, 1, 2, 2, 'No', NULL, '2003-10-05 18:22:44', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 22, 2, 1, 1, 'Yes', NULL, '2003-10-05 18:23:16', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 22, 2, 2, 2, 'No', NULL, '2003-10-05 18:23:25', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 2, 2, 2, 'No', NULL, '2003-10-18 21:17:25', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 2, 3, 3, 'Not Applicable', NULL, '2003-10-18 21:17:42', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 3, 1, 1, 'Yes', NULL, '2003-10-18 21:19:05', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 3, 2, 2, 'No', NULL, '2003-10-18 21:19:05', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 4, 1, 1, 'Yes', NULL, '2003-10-18 21:20:16', 'AJM', '2003-10-18 21:20:32', 'AJM');
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 4, 2, 2, 'No', NULL, '2003-10-18 21:20:16', 'AJM', '2003-10-18 21:20:32', 'AJM');
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 1, 1, 1, 'Yes', NULL, '2003-10-18 21:26:12', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 1, 2, 2, 'No', NULL, '2003-10-18 21:26:13', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 2, 1, 1, 'Yes', NULL, '2003-10-18 21:27:20', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 2, 2, 2, 'No', NULL, '2003-10-18 21:27:20', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 3, 1, 1, 'Yes', NULL, '2003-10-18 21:28:17', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 3, 2, 2, 'No', NULL, '2003-10-18 21:28:17', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 4, 1, 1, 'Yes', NULL, '2003-10-18 21:29:47', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 4, 2, 2, 'No', NULL, '2003-10-18 21:29:47', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 3, 1, 1, 1, 'Yes', NULL, '2003-10-18 21:30:54', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 3, 1, 2, 2, 'No', NULL, '2003-10-18 21:30:54', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 3, 2, 1, 1, 'Yes', NULL, '2003-10-18 21:31:47', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 3, 2, 2, 2, 'No', NULL, '2003-10-18 21:31:47', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 3, 2, 3, 3, 'Not Applicable', NULL, '2003-10-18 21:31:59', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 3, 3, 1, 1, 'Yes', NULL, '2003-10-18 21:32:51', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 3, 3, 2, 2, 'No', NULL, '2003-10-18 21:32:51', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 4, 1, 1, 1, 'Yes', NULL, '2003-10-18 21:34:13', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 4, 1, 2, 2, 'No', NULL, '2003-10-18 21:34:13', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 4, 2, 1, 1, 'Yes', NULL, '2003-10-18 21:35:32', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 4, 2, 2, 2, 'No', NULL, '2003-10-18 21:35:32', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 4, 3, 1, 1, 'Yes', NULL, '2003-10-18 21:36:18', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 4, 3, 2, 2, 'No', NULL, '2003-10-18 21:36:18', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 5, 1, 1, 1, 'Yes', NULL, '2003-10-18 21:37:08', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 5, 1, 2, 2, 'No', NULL, '2003-10-18 21:37:08', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 1, 1, 1, 'Yes', NULL, '2003-10-18 21:38:05', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 1, 2, 2, 'No', NULL, '2003-10-18 21:38:05', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 2, 1, 1, 'Yes', NULL, '2003-10-18 21:40:01', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 2, 2, 2, 'No', NULL, '2003-10-18 21:40:01', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 3, 1, 1, 'Yes', NULL, '2003-10-18 21:40:51', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 3, 2, 2, 'No', NULL, '2003-10-18 21:40:51', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 4, 1, 1, 'Yes', NULL, '2003-10-18 21:41:36', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 4, 2, 2, 'No', NULL, '2003-10-18 21:41:36', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 5, 1, 1, 'Yes', NULL, '2003-10-18 21:42:21', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 5, 2, 2, 'No', NULL, '2003-10-18 21:42:21', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 6, 1, 1, 'Yes', NULL, '2003-10-18 21:43:23', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 6, 2, 2, 'No', NULL, '2003-10-18 21:43:23', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 7, 1, 1, 'Yes', NULL, '2003-10-18 21:44:29', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 7, 2, 2, 'No', NULL, '2003-10-18 21:44:29', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 8, 1, 1, 'Yes', NULL, '2003-10-18 21:45:14', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 8, 2, 2, 'No', NULL, '2003-10-18 21:45:14', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 9, 1, 1, 'Yes', NULL, '2003-10-18 21:46:05', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 9, 2, 2, 'No', NULL, '2003-10-18 21:46:05', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 9, 3, 3, 'Not Applicable', NULL, '2003-10-18 21:46:16', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 1, 1, 1, 'Yes', NULL, '2003-10-18 21:47:09', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 1, 2, 2, 'No', NULL, '2003-10-18 21:47:10', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 1, 3, 3, 'Not Applicable', NULL, '2003-10-18 21:47:21', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 2, 1, 1, 'Yes', NULL, '2003-10-18 21:48:13', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 2, 2, 2, 'No', NULL, '2003-10-18 21:48:13', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 2, 3, 3, 'Not Applicable', NULL, '2003-10-18 21:48:26', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 3, 1, 1, 'Yes', NULL, '2003-10-18 21:49:16', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 3, 2, 2, 'No', NULL, '2003-10-18 21:49:16', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 3, 3, 3, 'Not Applicable', NULL, '2003-10-18 21:49:34', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 4, 1, 1, 'Yes', NULL, '2003-10-18 21:50:28', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 4, 2, 2, 'No', NULL, '2003-10-18 21:50:28', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 4, 3, 3, 'Not Applcable', NULL, '2003-10-18 21:50:41', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 1, 1, 1, 'Yes', NULL, '2003-10-18 21:51:33', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 1, 2, 2, 'No', NULL, '2003-10-18 21:51:33', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 1, 3, 3, 'Not Applicable', NULL, '2003-10-18 21:51:44', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 2, 1, 1, 'Yes', NULL, '2003-10-18 21:52:31', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 2, 2, 2, 'No', NULL, '2003-10-18 21:52:31', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 3, 1, 1, 'Yes', NULL, '2003-10-18 21:53:17', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 3, 2, 2, 'No', NULL, '2003-10-18 21:53:17', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 3, 3, 3, 'Not Applicable', NULL, '2003-10-18 21:53:29', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 4, 1, 1, 'Yes', NULL, '2003-10-18 21:54:34', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 4, 2, 2, 'No', NULL, '2003-10-18 21:54:34', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 4, 3, 3, 'Not Applicable', NULL, '2003-10-18 21:54:53', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 5, 1, 1, 'Yes', NULL, '2003-10-18 21:55:47', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 5, 2, 2, 'No', NULL, '2003-10-18 21:55:47', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 5, 3, 3, 'Not Applicable', NULL, '2003-10-18 21:55:59', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 9, 1, 1, 1, 'Yes', NULL, '2003-10-18 21:56:49', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 9, 1, 2, 2, 'No', NULL, '2003-10-18 21:56:49', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 9, 2, 1, 1, 'Yes', NULL, '2003-10-18 21:57:41', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 9, 2, 2, 2, 'No', NULL, '2003-10-18 21:57:41', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 10, 1, 1, 1, 'Yes', NULL, '2003-10-18 21:58:43', 'AJM', '2003-10-19 19:22:27', 'AJM');
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 10, 1, 2, 2, 'No', NULL, '2003-10-18 21:58:43', 'AJM', '2003-10-19 19:22:33', 'AJM');
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 10, 2, 1, 1, 'Yes', NULL, '2003-10-18 22:00:21', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 10, 2, 2, 2, 'No', NULL, '2003-10-18 22:00:21', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 10, 2, 3, 3, 'Not Applicable', NULL, '2003-10-18 22:00:32', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 10, 3, 1, 1, 'Yes', NULL, '2003-10-18 22:01:17', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 10, 3, 2, 2, 'No', NULL, '2003-10-18 22:01:17', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 1, 1, 1, 'Yes', NULL, '2003-10-18 22:02:10', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 1, 2, 2, 'No', NULL, '2003-10-18 22:02:10', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 2, 1, 1, 'Yes', NULL, '2003-10-18 22:02:55', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 2, 2, 2, 'No', NULL, '2003-10-18 22:02:55', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 2, 3, 3, 'Not Applicable', NULL, '2003-10-18 22:03:06', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 3, 1, 1, 'Yes', NULL, '2003-10-18 22:03:50', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 3, 2, 2, 'No', NULL, '2003-10-18 22:03:50', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 3, 3, 3, 'Not Applicable', NULL, '2003-10-18 22:04:02', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 4, 1, 1, 'Yes', NULL, '2003-10-18 22:04:48', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 4, 2, 2, 'No', NULL, '2003-10-18 22:04:48', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 4, 3, 3, 'Not Applicable', NULL, '2003-10-18 22:05:00', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 12, 1, 1, 1, 'Yes', NULL, '2003-10-18 22:05:53', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 12, 1, 2, 2, 'No', NULL, '2003-10-18 22:05:53', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 12, 1, 3, 3, 'Not Applicable', NULL, '2003-10-18 22:06:04', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 1, 1, 1, 'Yes', NULL, '2003-10-18 22:07:08', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 1, 2, 2, 'No', NULL, '2003-10-18 22:07:08', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 2, 1, 1, 'Yes', NULL, '2003-10-18 22:39:33', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 2, 2, 2, 'No', NULL, '2003-10-18 22:39:33', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 3, 1, 1, 'Yes', NULL, '2003-10-18 22:40:24', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 3, 2, 2, 'No', NULL, '2003-10-18 22:40:24', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 4, 1, 1, 'Yes', NULL, '2003-10-18 22:41:11', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 4, 2, 2, 'No', NULL, '2003-10-18 22:41:11', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 5, 1, 1, 'Yes', NULL, '2003-10-18 22:43:34', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 5, 2, 2, 'No', NULL, '2003-10-18 22:43:34', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 6, 1, 1, 'Yes', NULL, '2003-10-18 22:44:44', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 6, 2, 2, 'No', NULL, '2003-10-18 22:44:44', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 7, 1, 1, 'Yes', NULL, '2003-10-18 22:45:31', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 7, 2, 2, 'No', NULL, '2003-10-18 22:45:31', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 1, 1, 1, 'Yes', NULL, '2003-10-19 19:39:54', 'AJM', '2003-10-19 19:45:49', 'AJM');
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 1, 2, 2, 'No', 2, '2003-10-19 19:39:54', 'AJM', '2003-10-19 19:45:49', 'AJM');
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 8, 1, 1, 'Yes', NULL, '2003-10-19 19:51:35', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 8, 2, 2, 'No', NULL, '2003-10-19 19:51:35', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 3, 1, 1, 'Yes', NULL, '2003-10-19 20:00:56', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 3, 2, 2, 'No', NULL, '2003-10-19 20:00:56', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 4, 1, 1, 'Yes', NULL, '2003-10-19 20:01:51', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 4, 2, 2, 'No', NULL, '2003-10-19 20:01:51', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 4, 1, 1, 1, 'British standard', NULL, '2003-10-19 20:10:10', 'AJM', '2003-10-19 20:13:46', 'AJM');
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 4, 1, 2, 2, 'Contractual benchmarks', NULL, '2003-10-19 20:10:54', 'AJM', '2003-10-19 20:13:46', 'AJM');
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 4, 1, 3, 3, 'Suppliers own standards', NULL, '2003-10-19 20:11:16', 'AJM', '2003-10-19 20:13:46', 'AJM');
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 4, 1, 4, 4, 'Other standard', NULL, '2003-10-19 20:11:34', 'AJM', '2003-10-19 20:13:46', 'AJM');
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 4, 2, 1, 1, 'Yes', NULL, '2003-10-19 20:14:34', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 4, 2, 2, 2, 'No', NULL, '2003-10-19 20:14:34', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 5, 3, 1, 1, 'Daily', NULL, '2003-10-19 20:59:04', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 5, 3, 2, 2, 'Weekly', NULL, '2003-10-19 20:59:13', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 5, 3, 3, 3, 'Monthly', NULL, '2003-10-19 20:59:22', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 5, 3, 4, 4, 'Annually', NULL, '2003-10-19 20:59:37', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 5, 3, 5, 5, 'Never', NULL, '2003-10-19 20:59:48', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 2, 1, 1, 'Yes', NULL, '2003-10-28 21:59:08', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 6, 5, 1, 1, 'Yes', NULL, '2004-07-23 15:32:08', 'AJM', NULL, NULL);
INSERT INTO answer_option (survey_id, section_id, question_id, answer_id, answer_seq, answer_text, jumpto_section_seq, created_date, created_user, revised_date, revised_user) VALUES (3, 6, 5, 2, 2, 'No', NULL, '2004-07-23 15:32:08', 'AJM', NULL, NULL);


--
-- TOC entry 1807 (class 0 OID 23727)
-- Dependencies: 1348
-- Data for Name: asset_type; Type: TABLE DATA; Schema: survey; Owner: postgres
--

INSERT INTO asset_type (asset_type_id, asset_type_desc, image_fname, created_date, created_user, revised_date, revised_user) VALUES (1, 'Computer', 'icons/computer.gif', '2003-10-22 23:38:30', 'AJM', '2003-12-07 11:43:25', 'AJM');
INSERT INTO asset_type (asset_type_id, asset_type_desc, image_fname, created_date, created_user, revised_date, revised_user) VALUES (2, 'Safe', 'icons/safe.gif', '2003-10-22 23:38:38', 'AJM', '2003-12-07 11:43:34', 'AJM');
INSERT INTO asset_type (asset_type_id, asset_type_desc, image_fname, created_date, created_user, revised_date, revised_user) VALUES (3, 'Vehicle (car)', 'icons/car.gif', '2003-10-22 23:38:47', 'AJM', '2003-12-07 11:43:43', 'AJM');
INSERT INTO asset_type (asset_type_id, asset_type_desc, image_fname, created_date, created_user, revised_date, revised_user) VALUES (4, 'Vehicle (van)', 'icons/van.gif', '2003-12-06 11:54:16', 'AJM', '2003-12-07 11:43:56', 'AJM');


--
-- TOC entry 1808 (class 0 OID 23735)
-- Dependencies: 1349
-- Data for Name: default_prompt; Type: TABLE DATA; Schema: survey; Owner: postgres
--

INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (1, 1, 'Arson', '2003-10-06 16:41:40', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 'Assault', '2003-10-06 16:41:51', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (1, 3, 'Criminal Damage', '2003-10-06 16:42:11', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (1, 4, 'Public Safety', '2003-10-06 16:42:30', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 'Terrorism', '2003-10-06 16:42:47', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 'Theft', '2003-10-06 16:43:01', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (1, 7, 'Unlawful Entry', '2003-10-06 16:43:25', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 'Vandalism', '2003-10-06 16:43:40', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 'Workforce Safety', '2003-10-06 16:44:02', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 'Regulation Compliance', '2003-10-06 16:44:17', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 'Not Applicable', '2003-10-06 18:07:15', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 'Regulation Compliance', '2003-10-06 18:10:56', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 'Not Applicable', '2003-10-06 18:11:14', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 'Regulation Compliance', '2003-10-06 18:11:36', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (3, 2, 'Not Applicable', '2003-10-06 18:11:49', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 3, 'Arson', '2003-10-18 21:08:43', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 4, 'Assault', '2003-10-18 21:09:02', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 5, 'Criminal Damage', '2003-10-18 21:09:14', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 'Terrorism', '2003-10-18 21:09:29', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 'Theft', '2003-10-18 21:09:37', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 'Unlawful Entry', '2003-10-18 21:10:56', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 9, 'Vandalism', '2003-10-18 21:11:14', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 10, 'Workforce Safety', '2003-10-18 21:11:26', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 'Arson', '2003-10-18 21:11:59', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (3, 4, 'Assault', '2003-10-18 21:12:07', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (3, 5, 'Criminal Damage', '2003-10-18 21:12:19', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (3, 6, 'Public Safety', '2003-10-18 21:12:38', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (3, 7, 'Terrorism', '2003-10-18 21:12:51', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 'Public Safety', '2003-10-18 21:13:38', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (3, 8, 'Theft', '2003-10-18 21:14:07', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (3, 9, 'Unlawful Entry', '2003-10-18 21:14:26', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (3, 10, 'Vandalism', '2003-10-18 21:14:36', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (3, 11, 'Workforce Safety', '2003-10-18 21:14:54', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (2, 12, 'Welfare', '2003-10-18 22:37:31', 'AJM', NULL, NULL);
INSERT INTO default_prompt (survey_id, prompt_id, prompt_desc, created_date, created_user, revised_date, revised_user) VALUES (4, 1, 'test', '2003-10-21 22:08:08', 'AJM', NULL, NULL);


--
-- TOC entry 1809 (class 0 OID 23744)
-- Dependencies: 1350
-- Data for Name: location_address; Type: TABLE DATA; Schema: survey; Owner: postgres
--

INSERT INTO location_address (node_id, address_line1, address_line2, town, county, postcode, country, telephone, fax, created_date, created_user, revised_date, revised_user) VALUES (10, 'aa', 'aa', 'AA', 'aa', 'AA1 1AA', 'aa', NULL, NULL, '2004-12-12 21:40:59', 'AJM', '2005-07-23 16:09:10', 'AJM');


--
-- TOC entry 1810 (class 0 OID 23751)
-- Dependencies: 1351
-- Data for Name: location_type; Type: TABLE DATA; Schema: survey; Owner: postgres
--

INSERT INTO location_type (location_type_id, location_type_desc, image_fname, created_date, created_user, revised_date, revised_user) VALUES (1, 'Office', 'icons/office.gif', '2003-10-21 23:00:15', 'AJM', '2003-12-07 11:42:46', 'AJM');
INSERT INTO location_type (location_type_id, location_type_desc, image_fname, created_date, created_user, revised_date, revised_user) VALUES (2, 'Warehouse', 'icons/factory.gif', '2003-10-21 23:00:51', 'AJM', '2003-12-07 11:43:05', 'AJM');
INSERT INTO location_type (location_type_id, location_type_desc, image_fname, created_date, created_user, revised_date, revised_user) VALUES (3, 'Outhouse', 'icons/wc.gif', '2003-10-25 19:43:21', 'AJM', '2003-12-07 11:42:55', 'AJM');
INSERT INTO location_type (location_type_id, location_type_desc, image_fname, created_date, created_user, revised_date, revised_user) VALUES (4, 'Drinking Hole', 'icons/drink.gif', '2003-10-25 19:43:31', 'AJM', '2003-12-07 11:42:26', 'AJM');
INSERT INTO location_type (location_type_id, location_type_desc, image_fname, created_date, created_user, revised_date, revised_user) VALUES (5, 'Eating House', 'icons/burger.gif', '2003-12-06 12:07:42', 'AJM', '2003-12-07 11:42:36', 'AJM');


--
-- TOC entry 1811 (class 0 OID 23759)
-- Dependencies: 1352
-- Data for Name: number_option; Type: TABLE DATA; Schema: survey; Owner: postgres
--

INSERT INTO number_option (survey_id, section_id, question_id, min_value, max_value, created_date, created_user, revised_date, revised_user) VALUES (3, 4, 3, 0, NULL, '2003-10-19 20:15:25', 'AJM', '2003-10-27 21:07:33', 'AJM');


--
-- TOC entry 1812 (class 0 OID 23770)
-- Dependencies: 1353
-- Data for Name: org_type; Type: TABLE DATA; Schema: survey; Owner: postgres
--

INSERT INTO org_type (org_type_id, org_type_desc, image_fname, created_date, created_user, revised_date, revised_user) VALUES (1, 'International', 'icons/globe.gif', '2003-10-21 20:46:56', 'AJM', '2003-12-07 11:41:32', 'AJM');
INSERT INTO org_type (org_type_id, org_type_desc, image_fname, created_date, created_user, revised_date, revised_user) VALUES (2, 'National', 'icons/ukflag.gif', '2003-10-21 20:49:09', 'AJM', '2003-12-07 11:41:40', 'AJM');
INSERT INTO org_type (org_type_id, org_type_desc, image_fname, created_date, created_user, revised_date, revised_user) VALUES (3, 'Regional', 'icons/organisation.gif', '2003-10-21 20:49:19', 'AJM', '2003-12-07 11:41:57', 'AJM');


--
-- TOC entry 1813 (class 0 OID 23778)
-- Dependencies: 1354
-- Data for Name: question_prompt; Type: TABLE DATA; Schema: survey; Owner: postgres
--

INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 3, 3, '2003-10-01 16:29:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 3, 1, '2003-10-01 16:29:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 2, 4, '2003-10-01 16:09:19', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 2, 9, '2003-10-01 16:28:39', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 1, 2, 11, '2003-10-01 16:25:44', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 3, 4, '2003-10-01 16:29:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 1, 4, '2003-10-01 16:27:42', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 1, 9, '2003-10-01 16:27:42', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 3, 8, '2003-10-01 16:29:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 3, 9, '2003-10-01 16:29:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 4, 1, '2003-10-01 16:32:57', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 4, 3, '2003-10-01 16:32:57', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 4, 4, '2003-10-01 16:32:57', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 4, 8, '2003-10-01 16:32:57', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 4, 9, '2003-10-01 16:32:57', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 5, 1, '2003-10-01 16:33:44', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 5, 3, '2003-10-01 16:33:44', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 5, 4, '2003-10-01 16:33:44', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 5, 5, '2003-10-01 16:33:44', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 6, 1, '2003-10-01 16:39:10', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 5, 9, '2003-10-01 16:33:44', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 4, 5, '2003-10-01 16:34:56', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 6, 3, '2003-10-01 16:39:10', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 6, 4, '2003-10-01 16:39:10', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 6, 5, '2003-10-01 16:39:32', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 6, 9, '2003-10-01 16:39:10', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 6, 8, '2003-10-01 16:41:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 7, 1, '2003-10-01 16:42:17', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 7, 3, '2003-10-01 16:42:18', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 7, 4, '2003-10-01 16:42:18', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 7, 5, '2003-10-01 16:42:18', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 7, 9, '2003-10-01 16:42:18', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 10, 4, '2003-10-01 16:45:12', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 9, 9, '2003-10-01 16:44:37', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 8, 4, '2003-10-01 16:43:11', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 9, 4, '2003-10-01 16:44:37', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 8, 9, '2003-10-01 16:43:11', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 10, 9, '2003-10-01 16:45:12', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 3, 1, 10, '2003-10-01 16:47:13', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 3, 2, 10, '2003-10-01 16:47:45', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 3, 3, 10, '2003-10-01 16:48:16', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 3, 4, 10, '2003-10-01 16:49:00', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 4, 1, 10, '2003-10-01 16:49:49', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 4, 2, 10, '2003-10-01 16:50:39', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 4, 3, 10, '2003-10-01 16:51:08', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 4, 4, 10, '2003-10-01 16:51:54', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 1, 4, '2003-10-01 16:53:01', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 1, 5, '2003-10-01 16:53:01', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 1, 9, '2003-10-01 16:53:01', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 1, 10, '2003-10-01 16:53:01', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 2, 4, '2003-10-01 16:53:35', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 2, 9, '2003-10-01 16:53:35', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 2, 10, '2003-10-01 16:53:35', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 3, 4, '2003-10-01 16:54:16', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 3, 5, '2003-10-01 16:54:16', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 3, 9, '2003-10-01 16:54:16', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 3, 10, '2003-10-01 16:54:16', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 1, 4, '2003-10-01 16:55:14', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 1, 9, '2003-10-01 16:55:14', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 1, 10, '2003-10-01 16:55:14', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 2, 4, '2003-10-01 16:55:54', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 2, 9, '2003-10-01 16:55:54', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 2, 10, '2003-10-01 16:55:54', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 3, 4, '2003-10-01 16:56:24', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 3, 9, '2003-10-01 16:56:24', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 3, 10, '2003-10-01 16:56:24', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 7, 1, 4, '2003-10-01 16:57:43', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 7, 1, 9, '2003-10-01 16:57:43', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 7, 2, 4, '2003-10-01 16:59:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 7, 2, 8, '2003-10-01 16:59:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 7, 2, 9, '2003-10-01 16:59:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 1, 4, '2003-10-01 17:00:12', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 1, 9, '2003-10-01 17:00:12', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 2, 4, '2003-10-01 17:00:43', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 2, 9, '2003-10-01 17:00:43', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 3, 4, '2003-10-01 17:01:13', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 3, 5, '2003-10-01 17:01:13', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 3, 9, '2003-10-01 17:01:13', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 4, 4, '2003-10-01 17:01:46', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 4, 9, '2003-10-01 17:01:46', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 4, 10, '2003-10-01 17:01:46', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 1, 4, '2003-10-01 17:02:37', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 1, 9, '2003-10-01 17:02:37', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 1, 5, '2003-10-01 17:03:44', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 2, 4, '2003-10-01 17:04:17', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 2, 5, '2003-10-01 17:04:17', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 2, 9, '2003-10-01 17:04:17', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 3, 4, '2003-10-01 17:04:49', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 3, 5, '2003-10-01 17:04:49', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 3, 9, '2003-10-01 17:04:49', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 4, 4, '2003-10-01 17:05:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 4, 5, '2003-10-01 17:05:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 4, 9, '2003-10-01 17:05:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 5, 4, '2003-10-01 17:05:57', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 5, 9, '2003-10-01 17:05:57', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 6, 4, '2003-10-01 17:06:54', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 6, 9, '2003-10-01 17:06:54', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 7, 4, '2003-10-01 17:07:32', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 7, 9, '2003-10-01 17:07:32', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 8, 4, '2003-10-01 17:08:06', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 8, 5, '2003-10-01 17:08:06', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 8, 9, '2003-10-01 17:08:06', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 9, 4, '2003-10-01 17:08:41', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 9, 9, '2003-10-01 17:08:41', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 10, 4, '2003-10-01 17:09:14', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 10, 5, '2003-10-01 17:09:14', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 10, 9, '2003-10-01 17:09:14', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 11, 4, '2003-10-01 17:09:48', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 11, 5, '2003-10-01 17:09:49', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 11, 9, '2003-10-01 17:09:49', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 1, 9, '2003-10-01 19:06:27', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 2, 4, '2003-10-01 19:06:57', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 2, 5, '2003-10-01 19:06:58', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 2, 9, '2003-10-01 19:06:58', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 3, 4, '2003-10-01 19:07:28', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 3, 5, '2003-10-01 19:07:28', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 3, 9, '2003-10-01 19:07:28', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 4, 4, '2003-10-01 19:07:58', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 4, 5, '2003-10-01 19:07:58', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 4, 9, '2003-10-01 19:07:58', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 5, 4, '2003-10-01 19:08:29', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 5, 9, '2003-10-01 19:08:29', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 6, 4, '2003-10-01 19:08:58', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 6, 9, '2003-10-01 19:08:58', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 7, 4, '2003-10-01 19:09:25', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 7, 9, '2003-10-01 19:09:25', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 8, 4, '2003-10-01 19:09:54', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 8, 9, '2003-10-01 19:09:55', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 1, 1, '2003-10-01 19:10:50', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 1, 4, '2003-10-01 19:10:50', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 1, 5, '2003-10-01 19:10:50', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 1, 8, '2003-10-01 19:10:50', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 1, 9, '2003-10-01 19:10:50', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 2, 4, '2003-10-01 19:11:34', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 2, 9, '2003-10-01 19:11:34', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 3, 1, '2003-10-01 19:12:18', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 3, 4, '2003-10-01 19:12:18', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 3, 9, '2003-10-01 19:12:18', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 4, 1, '2003-10-01 19:12:50', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 4, 4, '2003-10-01 19:12:50', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 4, 9, '2003-10-01 19:12:50', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 5, 1, '2003-10-01 19:13:20', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 5, 4, '2003-10-01 19:13:20', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 5, 9, '2003-10-01 19:13:20', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 6, 4, '2003-10-01 19:13:54', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 6, 9, '2003-10-01 19:13:54', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 7, 1, '2003-10-01 19:14:22', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 7, 4, '2003-10-01 19:14:22', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 7, 9, '2003-10-01 19:14:22', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 8, 4, '2003-10-01 19:14:51', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 8, 9, '2003-10-01 19:14:51', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 9, 4, '2003-10-01 19:15:27', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 9, 9, '2003-10-01 19:15:27', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 10, 4, '2003-10-01 19:15:59', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 10, 9, '2003-10-01 19:15:59', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 11, 1, '2003-10-01 19:16:37', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 11, 3, '2003-10-01 19:16:37', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 11, 4, '2003-10-01 19:16:37', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 11, 5, '2003-10-01 19:16:37', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 11, 8, '2003-10-01 19:16:37', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 11, 9, '2003-10-01 19:16:37', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 1, 1, '2003-10-01 19:17:41', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 1, 4, '2003-10-01 19:17:42', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 1, 9, '2003-10-01 19:17:42', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 1, 11, '2003-10-01 19:19:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 2, 1, '2003-10-01 19:21:12', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 2, 4, '2003-10-01 19:21:12', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 2, 9, '2003-10-01 19:21:12', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 2, 11, '2003-10-01 19:21:12', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 3, 1, '2003-10-01 19:21:57', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 3, 4, '2003-10-01 19:21:57', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 3, 9, '2003-10-01 19:21:57', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 3, 11, '2003-10-01 19:21:57', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 4, 1, '2003-10-01 19:24:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 4, 4, '2003-10-01 19:24:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 4, 9, '2003-10-01 19:24:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 4, 11, '2003-10-01 19:24:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 5, 1, '2003-10-01 19:25:55', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 5, 11, '2003-10-01 19:25:55', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 5, 4, '2003-10-01 19:25:55', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 5, 9, '2003-10-01 19:25:55', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 1, 4, '2003-10-01 19:27:06', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 1, 5, '2003-10-01 19:27:06', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 1, 9, '2003-10-01 19:27:06', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 2, 4, '2003-10-01 19:27:40', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 2, 5, '2003-10-01 19:27:40', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 2, 9, '2003-10-01 19:27:40', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 3, 4, '2003-10-01 19:28:16', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 3, 5, '2003-10-01 19:28:16', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 3, 9, '2003-10-01 19:28:17', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 4, 4, '2003-10-01 19:28:56', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 4, 5, '2003-10-01 19:28:56', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 4, 9, '2003-10-01 19:28:56', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 1, 1, '2003-10-01 19:29:50', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 1, 3, '2003-10-01 19:29:50', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 1, 4, '2003-10-01 19:29:50', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 1, 5, '2003-10-01 19:29:50', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 1, 9, '2003-10-01 19:29:50', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 2, 1, '2003-10-01 19:30:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 2, 3, '2003-10-01 19:30:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 2, 4, '2003-10-01 19:30:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 2, 5, '2003-10-01 19:30:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 2, 9, '2003-10-01 19:30:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 3, 1, '2003-10-01 19:31:45', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 3, 3, '2003-10-01 19:31:45', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 3, 4, '2003-10-01 19:31:46', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 3, 5, '2003-10-01 19:31:46', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 3, 9, '2003-10-01 19:31:46', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 4, 1, '2003-10-01 19:32:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 4, 3, '2003-10-01 19:32:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 4, 4, '2003-10-01 19:32:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 4, 5, '2003-10-01 19:32:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 4, 9, '2003-10-01 19:32:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 5, 1, '2003-10-01 19:33:08', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 5, 3, '2003-10-01 19:33:08', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 5, 4, '2003-10-01 19:33:08', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 5, 5, '2003-10-01 19:33:09', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 5, 9, '2003-10-01 19:33:09', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 1, 4, '2003-10-01 19:33:53', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 1, 9, '2003-10-01 19:33:53', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 2, 4, '2003-10-01 19:34:22', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 2, 9, '2003-10-01 19:34:23', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 3, 4, '2003-10-01 19:34:54', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 3, 9, '2003-10-01 19:34:54', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 4, 4, '2003-10-01 19:35:22', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 4, 9, '2003-10-01 19:35:22', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 1, 1, '2003-10-01 19:36:23', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 1, 3, '2003-10-01 19:36:23', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 1, 4, '2003-10-01 19:36:24', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 1, 5, '2003-10-01 19:36:24', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 1, 9, '2003-10-01 19:36:24', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 2, 1, '2003-10-01 19:37:02', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 2, 3, '2003-10-01 19:37:02', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 2, 4, '2003-10-01 19:37:02', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 2, 5, '2003-10-01 19:37:02', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 2, 9, '2003-10-01 19:37:02', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 3, 1, '2003-10-01 19:37:36', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 3, 3, '2003-10-01 19:37:36', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 3, 4, '2003-10-01 19:37:37', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 3, 5, '2003-10-01 19:37:37', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 3, 9, '2003-10-01 19:37:37', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 4, 1, '2003-10-01 19:38:19', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 4, 3, '2003-10-01 19:38:19', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 4, 4, '2003-10-01 19:38:19', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 4, 5, '2003-10-01 19:38:19', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 4, 9, '2003-10-01 19:38:19', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 1, 1, '2003-10-01 19:39:12', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 1, 3, '2003-10-01 19:39:13', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 1, 4, '2003-10-01 19:39:13', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 1, 5, '2003-10-01 19:39:13', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 1, 8, '2003-10-01 19:39:13', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 1, 9, '2003-10-01 19:39:13', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 2, 1, '2003-10-01 19:39:50', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 2, 3, '2003-10-01 19:39:50', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 2, 4, '2003-10-01 19:39:51', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 2, 5, '2003-10-01 19:39:51', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 2, 8, '2003-10-01 19:39:51', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 2, 9, '2003-10-01 19:39:51', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 3, 1, '2003-10-01 19:40:35', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 3, 3, '2003-10-01 19:40:35', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 3, 4, '2003-10-01 19:40:35', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 3, 5, '2003-10-01 19:40:35', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 3, 8, '2003-10-01 19:40:35', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 3, 9, '2003-10-01 19:40:35', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 18, 1, 1, '2003-10-01 19:41:27', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 18, 1, 3, '2003-10-01 19:41:28', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 18, 1, 4, '2003-10-01 19:41:28', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 18, 1, 5, '2003-10-01 19:41:28', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 18, 1, 9, '2003-10-01 19:41:28', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 18, 2, 1, '2003-10-01 19:42:13', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 18, 2, 3, '2003-10-01 19:42:13', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 18, 2, 4, '2003-10-01 19:42:13', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 18, 2, 5, '2003-10-01 19:42:13', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 18, 2, 9, '2003-10-01 19:42:13', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 19, 1, 1, '2003-10-01 19:42:57', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 19, 1, 4, '2003-10-01 19:42:57', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 19, 1, 8, '2003-10-01 19:42:57', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 19, 1, 9, '2003-10-01 19:42:57', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 20, 1, 4, '2003-10-01 19:43:43', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 20, 1, 9, '2003-10-01 19:43:43', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 20, 2, 4, '2003-10-01 19:44:22', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 20, 2, 9, '2003-10-01 19:44:23', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 20, 3, 4, '2003-10-01 19:44:52', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 20, 3, 9, '2003-10-01 19:44:53', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 1, 1, '2003-10-01 19:45:40', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 1, 3, '2003-10-01 19:45:40', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 1, 4, '2003-10-01 19:45:40', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 1, 5, '2003-10-01 19:45:40', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 1, 8, '2003-10-01 19:45:40', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 1, 9, '2003-10-01 19:45:40', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 2, 1, '2003-10-01 19:46:19', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 2, 3, '2003-10-01 19:46:19', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 2, 4, '2003-10-01 19:46:19', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 2, 5, '2003-10-01 19:46:20', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 2, 8, '2003-10-01 19:46:20', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 2, 9, '2003-10-01 19:46:20', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 3, 1, '2003-10-01 19:47:03', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 3, 3, '2003-10-01 19:47:03', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 3, 4, '2003-10-01 19:47:03', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 3, 5, '2003-10-01 19:47:03', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 3, 8, '2003-10-01 19:47:03', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 3, 9, '2003-10-01 19:47:03', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 4, 1, '2003-10-01 19:47:46', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 4, 3, '2003-10-01 19:47:46', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 4, 4, '2003-10-01 19:47:46', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 4, 5, '2003-10-01 19:47:46', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 4, 8, '2003-10-01 19:47:46', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 4, 9, '2003-10-01 19:47:46', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 22, 1, 1, '2003-10-01 19:48:31', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 22, 1, 3, '2003-10-01 19:48:31', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 22, 1, 4, '2003-10-01 19:48:31', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 22, 1, 5, '2003-10-01 19:48:31', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 22, 1, 8, '2003-10-01 19:48:31', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 22, 1, 9, '2003-10-01 19:48:31', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 22, 2, 4, '2003-10-01 19:49:18', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 22, 2, 9, '2003-10-01 19:49:18', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 1, 1, 11, '2003-10-01 19:51:14', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (1, 22, 3, 11, '2003-10-14 22:36:46', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 3, 11, '2003-10-18 21:19:23', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 2, 10, '2003-10-18 21:18:09', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 2, 11, '2003-10-18 21:18:09', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 1, 10, '2003-10-18 21:15:36', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 1, 11, '2003-10-18 21:15:36', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 3, 10, '2003-10-18 21:19:23', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 4, 11, '2003-10-18 21:25:10', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 4, 10, '2003-10-18 21:25:10', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 1, 11, '2003-10-18 21:26:31', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 1, 10, '2003-10-18 21:26:31', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 2, 11, '2003-10-18 21:27:30', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 2, 10, '2003-10-18 21:27:30', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 3, 11, '2003-10-18 21:28:25', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 3, 10, '2003-10-18 21:28:25', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 4, 11, '2003-10-18 21:30:00', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 4, 10, '2003-10-18 21:30:00', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 3, 1, 11, '2003-10-18 21:31:00', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 3, 1, 10, '2003-10-18 21:31:00', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 3, 2, 11, '2003-10-18 21:32:12', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 3, 2, 10, '2003-10-18 21:32:12', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 3, 3, 11, '2003-10-18 21:32:58', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 3, 3, 10, '2003-10-18 21:32:58', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 4, 1, 11, '2003-10-18 21:34:21', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 4, 1, 10, '2003-10-18 21:34:21', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 4, 2, 11, '2003-10-18 21:35:38', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 4, 2, 10, '2003-10-18 21:35:38', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 4, 3, 11, '2003-10-18 21:36:25', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 4, 3, 10, '2003-10-18 21:36:25', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 5, 1, 11, '2003-10-18 21:37:15', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 5, 1, 10, '2003-10-18 21:37:15', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 1, 11, '2003-10-18 21:38:13', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 1, 10, '2003-10-18 21:38:13', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 2, 11, '2003-10-18 21:40:07', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 2, 10, '2003-10-18 21:40:07', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 3, 11, '2003-10-18 21:40:58', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 3, 10, '2003-10-18 21:40:58', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 4, 11, '2003-10-18 21:41:43', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 4, 10, '2003-10-18 21:41:43', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 5, 11, '2003-10-18 21:42:27', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 5, 10, '2003-10-18 21:42:27', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 6, 11, '2003-10-18 21:43:31', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 6, 10, '2003-10-18 21:43:31', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 7, 11, '2003-10-18 21:44:35', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 7, 10, '2003-10-18 21:44:35', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 8, 11, '2003-10-18 21:45:23', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 8, 10, '2003-10-18 21:45:23', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 9, 11, '2003-10-18 21:46:24', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 9, 10, '2003-10-18 21:46:24', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 1, 11, '2003-10-18 21:47:28', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 1, 10, '2003-10-18 21:47:28', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 2, 11, '2003-10-18 21:48:34', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 2, 10, '2003-10-18 21:48:34', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 3, 11, '2003-10-18 21:49:49', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 3, 10, '2003-10-18 21:49:49', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 4, 11, '2003-10-18 21:50:48', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 4, 10, '2003-10-18 21:50:48', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 1, 11, '2003-10-18 21:51:51', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 1, 10, '2003-10-18 21:51:51', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 2, 11, '2003-10-18 21:52:38', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 2, 10, '2003-10-18 21:52:38', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 3, 11, '2003-10-18 21:53:46', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 3, 10, '2003-10-18 21:53:46', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 4, 11, '2003-10-18 21:55:00', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 4, 10, '2003-10-18 21:55:00', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 5, 11, '2003-10-18 21:56:05', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 5, 10, '2003-10-18 21:56:05', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 9, 1, 11, '2003-10-18 21:56:56', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 9, 1, 10, '2003-10-18 21:56:56', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 9, 2, 11, '2003-10-18 21:57:52', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 9, 2, 10, '2003-10-18 21:57:52', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 10, 1, 11, '2003-10-18 21:58:50', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 10, 1, 10, '2003-10-18 21:58:50', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 10, 2, 11, '2003-10-18 22:00:40', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 10, 2, 10, '2003-10-18 22:00:40', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 10, 3, 11, '2003-10-18 22:01:24', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 10, 3, 10, '2003-10-18 22:01:24', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 1, 11, '2003-10-18 22:02:17', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 1, 10, '2003-10-18 22:02:17', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 2, 11, '2003-10-18 22:03:12', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 2, 10, '2003-10-18 22:03:12', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 3, 11, '2003-10-18 22:04:09', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 3, 10, '2003-10-18 22:04:09', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 4, 11, '2003-10-18 22:05:08', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 4, 10, '2003-10-18 22:05:08', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 12, 1, 11, '2003-10-18 22:06:10', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 12, 1, 10, '2003-10-18 22:06:10', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 1, 11, '2003-10-18 22:07:16', 'AJM', '2003-10-18 22:38:35', 'AJM');
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 1, 10, '2003-10-18 22:07:16', 'AJM', '2003-10-18 22:38:35', 'AJM');
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 1, 12, '2003-10-18 22:38:35', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 2, 11, '2003-10-18 22:39:43', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 2, 12, '2003-10-18 22:39:43', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 2, 10, '2003-10-18 22:39:43', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 3, 11, '2003-10-18 22:40:31', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 3, 12, '2003-10-18 22:40:31', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 3, 10, '2003-10-18 22:40:31', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 4, 11, '2003-10-18 22:41:20', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 4, 12, '2003-10-18 22:41:20', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 4, 10, '2003-10-18 22:41:20', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 5, 11, '2003-10-18 22:43:42', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 5, 12, '2003-10-18 22:43:42', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 5, 10, '2003-10-18 22:43:42', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 6, 11, '2003-10-18 22:44:51', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 6, 12, '2003-10-18 22:44:51', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 6, 10, '2003-10-18 22:44:51', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 7, 11, '2003-10-18 22:45:39', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 7, 12, '2003-10-18 22:45:39', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 7, 10, '2003-10-18 22:45:39', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 1, 4, '2003-10-19 19:40:30', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 1, 3, '2003-10-19 19:40:30', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 1, 5, '2003-10-19 19:40:30', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 1, 6, '2003-10-19 19:40:30', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 1, 7, '2003-10-19 19:40:30', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 1, 8, '2003-10-19 19:40:30', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 1, 9, '2003-10-19 19:40:30', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 1, 11, '2003-10-19 19:40:30', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 2, 5, '2003-10-19 19:42:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 2, 6, '2003-10-19 19:42:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 2, 7, '2003-10-19 19:42:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 2, 9, '2003-10-19 19:42:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 2, 11, '2003-10-19 19:42:26', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 3, 6, '2003-10-19 19:43:15', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 3, 9, '2003-10-19 19:43:15', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 3, 11, '2003-10-19 19:43:15', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 4, 5, '2003-10-19 19:44:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 4, 8, '2003-10-19 19:44:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 4, 9, '2003-10-19 19:44:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 4, 11, '2003-10-19 19:44:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 5, 3, '2003-10-19 19:46:49', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 5, 9, '2003-10-19 19:46:49', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 5, 10, '2003-10-19 19:46:49', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 5, 11, '2003-10-19 19:46:49', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 6, 3, '2003-10-19 19:49:23', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 6, 5, '2003-10-19 19:49:23', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 6, 6, '2003-10-19 19:49:23', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 6, 7, '2003-10-19 19:49:23', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 6, 9, '2003-10-19 19:49:23', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 6, 10, '2003-10-19 19:49:23', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 6, 11, '2003-10-19 19:49:23', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 7, 6, '2003-10-19 19:50:17', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 7, 9, '2003-10-19 19:50:17', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 7, 10, '2003-10-19 19:50:17', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 7, 11, '2003-10-19 19:50:17', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 8, 9, '2003-10-19 19:51:49', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 8, 11, '2003-10-19 19:51:49', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 9, 9, '2003-10-19 19:53:14', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 9, 10, '2003-10-19 19:53:14', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 9, 11, '2003-10-19 19:53:14', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 10, 5, '2003-10-19 19:54:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 10, 6, '2003-10-19 19:54:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 10, 8, '2003-10-19 19:54:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 10, 9, '2003-10-19 19:54:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 10, 10, '2003-10-19 19:54:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 10, 11, '2003-10-19 19:54:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 2, 2, 3, '2003-10-19 19:56:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 2, 2, 5, '2003-10-19 19:56:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 2, 2, 7, '2003-10-19 19:56:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 2, 2, 8, '2003-10-19 19:56:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 2, 2, 9, '2003-10-19 19:56:33', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 2, 4, 4, '2003-10-19 19:57:48', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 2, 4, 5, '2003-10-19 19:57:48', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 2, 4, 6, '2003-10-19 19:57:48', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 2, 4, 8, '2003-10-19 19:57:48', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 2, 4, 9, '2003-10-19 19:57:48', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 2, 4, 11, '2003-10-19 19:57:48', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 6, 3, '2003-10-19 20:03:12', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 6, 5, '2003-10-19 20:03:12', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 6, 6, '2003-10-19 20:03:12', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 6, 8, '2003-10-19 20:03:12', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 6, 9, '2003-10-19 20:03:12', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 6, 11, '2003-10-19 20:03:12', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 4, 2, 9, '2003-10-19 20:14:39', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 6, 1, 3, '2003-10-19 21:04:17', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 6, 1, 5, '2003-10-19 21:04:17', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 6, 1, 8, '2003-10-19 21:04:17', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 6, 1, 9, '2003-10-19 21:04:17', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 6, 1, 11, '2003-10-19 21:04:17', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 6, 5, 4, '2004-07-23 15:32:35', 'AJM', NULL, NULL);
INSERT INTO question_prompt (survey_id, section_id, question_id, prompt_id, created_date, created_user, revised_date, revised_user) VALUES (3, 6, 5, 3, '2004-07-23 15:32:35', 'AJM', NULL, NULL);


--
-- TOC entry 1814 (class 0 OID 23788)
-- Dependencies: 1355
-- Data for Name: risk_status; Type: TABLE DATA; Schema: survey; Owner: postgres
--

INSERT INTO risk_status (risk_status_id, risk_status_desc, created_date, created_user, revised_date, revised_user) VALUES (0, '00 - Not Applicable', '2003-09-30 16:26:39', 'AJM', '2003-10-02 11:47:58', 'AJM');
INSERT INTO risk_status (risk_status_id, risk_status_desc, created_date, created_user, revised_date, revised_user) VALUES (1, '01 - Discretionary', '2003-09-30 16:27:00', 'AJM', '2003-10-02 11:48:14', 'AJM');
INSERT INTO risk_status (risk_status_id, risk_status_desc, created_date, created_user, revised_date, revised_user) VALUES (5, '05 - Statutory', '2003-09-30 16:27:18', 'AJM', '2003-10-02 11:48:29', 'AJM');
INSERT INTO risk_status (risk_status_id, risk_status_desc, created_date, created_user, revised_date, revised_user) VALUES (10, '10 - Essential', '2003-09-30 16:28:16', 'AJM', '2003-10-02 11:48:44', 'AJM');


--
-- TOC entry 1815 (class 0 OID 23796)
-- Dependencies: 1356
-- Data for Name: risk_weighting; Type: TABLE DATA; Schema: survey; Owner: postgres
--

INSERT INTO risk_weighting (weighting_id, weighting_desc, created_date, created_user, revised_date, revised_user) VALUES (0, '00 - Not Applicable', '2003-09-30 15:57:16', 'AJM', '2003-10-06 19:02:04', 'AJM');
INSERT INTO risk_weighting (weighting_id, weighting_desc, created_date, created_user, revised_date, revised_user) VALUES (1, '01 - Low', '2003-09-30 15:58:02', 'AJM', '2003-10-06 19:02:17', 'AJM');
INSERT INTO risk_weighting (weighting_id, weighting_desc, created_date, created_user, revised_date, revised_user) VALUES (5, '05 - Medium', '2003-09-30 15:58:14', 'AJM', '2003-10-06 19:02:29', 'AJM');
INSERT INTO risk_weighting (weighting_id, weighting_desc, created_date, created_user, revised_date, revised_user) VALUES (10, '10 - High', '2003-09-30 15:59:41', 'AJM', '2003-10-06 19:02:42', 'AJM');


--
-- TOC entry 1816 (class 0 OID 23804)
-- Dependencies: 1357
-- Data for Name: survey_answer_dtl; Type: TABLE DATA; Schema: survey; Owner: postgres
--

INSERT INTO survey_answer_dtl (survey_answer_id, survey_id, section_id, question_id, answer_text, weighting_id, measure_adequate, created_date, created_user, revised_date, revised_user) VALUES (1, 1, 1, 1, '1 High Street
New Malden
Surrey', 0, 'N', '2003-10-27 21:15:30', 'AJM', '2003-10-28 23:31:09', 'AJM');
INSERT INTO survey_answer_dtl (survey_answer_id, survey_id, section_id, question_id, answer_text, weighting_id, measure_adequate, created_date, created_user, revised_date, revised_user) VALUES (1, 1, 1, 2, 'Department X', 0, 'N', '2003-10-28 19:29:41', 'AJM', '2003-10-28 23:31:12', 'AJM');
INSERT INTO survey_answer_dtl (survey_answer_id, survey_id, section_id, question_id, answer_text, weighting_id, measure_adequate, created_date, created_user, revised_date, revised_user) VALUES (1, 1, 2, 1, '1', 0, 'N', '2003-10-28 19:34:39', 'AJM', '2003-10-28 23:31:14', 'AJM');
INSERT INTO survey_answer_dtl (survey_answer_id, survey_id, section_id, question_id, answer_text, weighting_id, measure_adequate, created_date, created_user, revised_date, revised_user) VALUES (1, 1, 2, 2, '1', 0, 'N', '2003-10-28 19:47:49', 'AJM', '2003-10-28 23:31:16', 'AJM');
INSERT INTO survey_answer_dtl (survey_answer_id, survey_id, section_id, question_id, answer_text, weighting_id, measure_adequate, created_date, created_user, revised_date, revised_user) VALUES (1, 1, 2, 3, '2', 0, 'N', '2003-10-28 22:16:49', 'AJM', '2003-10-28 23:31:21', 'AJM');
INSERT INTO survey_answer_dtl (survey_answer_id, survey_id, section_id, question_id, answer_text, weighting_id, measure_adequate, created_date, created_user, revised_date, revised_user) VALUES (1, 1, 2, 4, '1', 0, 'N', '2003-10-28 22:23:40', 'AJM', '2003-10-28 23:31:30', 'AJM');
INSERT INTO survey_answer_dtl (survey_answer_id, survey_id, section_id, question_id, answer_text, weighting_id, measure_adequate, created_date, created_user, revised_date, revised_user) VALUES (1, 1, 15, 4, '1', 0, 'N', '2003-10-28 23:32:12', 'AJM', '2003-10-28 23:32:23', 'AJM');
INSERT INTO survey_answer_dtl (survey_answer_id, survey_id, section_id, question_id, answer_text, weighting_id, measure_adequate, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 1, 1, '2', 0, 'N', '2003-10-29 18:39:32', 'AJM', '2003-10-29 22:50:22', 'AJM');
INSERT INTO survey_answer_dtl (survey_answer_id, survey_id, section_id, question_id, answer_text, weighting_id, measure_adequate, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 2, 2, 'Dry rot, woodworm', 0, 'N', '2005-02-21 18:00:57', 'AJM', NULL, NULL);
INSERT INTO survey_answer_dtl (survey_answer_id, survey_id, section_id, question_id, answer_text, weighting_id, measure_adequate, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 2, 1, 'wattle and daub', 0, 'N', '2005-02-21 17:59:26', 'AJM', NULL, NULL);
INSERT INTO survey_answer_dtl (survey_answer_id, survey_id, section_id, question_id, answer_text, weighting_id, measure_adequate, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 2, 3, 'Guard dog.', 0, 'N', '2004-04-17 14:59:16', 'AJM', NULL, NULL);


--
-- TOC entry 1817 (class 0 OID 23816)
-- Dependencies: 1358
-- Data for Name: survey_answer_hdr; Type: TABLE DATA; Schema: survey; Owner: postgres
--

INSERT INTO survey_answer_hdr (survey_answer_id, user_id, answer_date, survey_id, node_id, is_complete, created_date, created_user, revised_date, revised_user) VALUES (1, 'AJM', '2003-10-26', 1, 3, 'N', '2003-10-26 18:50:44', 'AJM', '2005-07-29 12:35:49', 'AJM');
INSERT INTO survey_answer_hdr (survey_answer_id, user_id, answer_date, survey_id, node_id, is_complete, created_date, created_user, revised_date, revised_user) VALUES (2, 'AJM', '2003-10-29', 2, 3, 'N', '2003-10-29 18:07:22', 'AJM', '2005-07-29 12:36:17', 'AJM');
INSERT INTO survey_answer_hdr (survey_answer_id, user_id, answer_date, survey_id, node_id, is_complete, created_date, created_user, revised_date, revised_user) VALUES (3, 'AJM', '2003-10-29', 3, 4, 'N', '2003-10-29 18:19:17', 'AJM', NULL, NULL);


--
-- TOC entry 1818 (class 0 OID 23826)
-- Dependencies: 1359
-- Data for Name: survey_hdr; Type: TABLE DATA; Schema: survey; Owner: postgres
--

INSERT INTO survey_hdr (survey_id, survey_name, survey_desc, survey_type_id, created_date, created_user, revised_date, revised_user) VALUES (1, 'FIRE SAFETY', 'Fire and risk assessment survey of a building', 'FIRE', '2003-09-24 22:43:00', 'AJM', '2003-10-15 21:54:12', 'AJM');
INSERT INTO survey_hdr (survey_id, survey_name, survey_desc, survey_type_id, created_date, created_user, revised_date, revised_user) VALUES (2, 'HEALTH, SAFETY & WELFARE', 'HEALTH, SAFETY & WELFARE', 'SAFE', '2003-09-24 22:48:02', 'AJM', NULL, NULL);
INSERT INTO survey_hdr (survey_id, survey_name, survey_desc, survey_type_id, created_date, created_user, revised_date, revised_user) VALUES (3, 'SITE SECURITY', 'Generic template survey for a typical office or commercial site with a fenced or walled perimeter.', 'SEC', '2003-09-24 22:53:40', 'AJM', NULL, NULL);


--
-- TOC entry 1819 (class 0 OID 23836)
-- Dependencies: 1360
-- Data for Name: survey_question; Type: TABLE DATA; Schema: survey; Owner: postgres
--

INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 1, 1, 1, 'What is the full postal address of the premises?', 'T', 'Full postal address of the premises should be entered together with directions for difficult to find locations.', 10, '2003-09-29 17:56:56', 'AJM', '2003-10-19 16:28:49', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 1, 2, 2, 'What is the name of the department being surveyed?', 'T', 'The title of the department concerned must be clearly stated in addition to the physical area occupied by it on the site concerned.', 0, '2003-09-29 18:00:02', 'AJM', '2003-10-19 16:28:49', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 1, 1, 'Do assessments comply with Fire Precautions (Workplace) Regulations 1997?', 'M', 'The effect of the regulations is that, not only does the employer need to make suitable arrangements for fire precautions in the workplace, they should also undertake a risk assessment of the workplace with particular regard to fire safety.', 5, '2003-09-29 18:01:02', 'AJM', '2003-10-29 19:08:31', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 2, 2, 'Do assessments comply with Fire Precautions (Places of Work) (as amended) 1999?', 'M', 'Assessments should also comply with the requirements of The Management of Health and Safety at Work Regulations 1999.', 5, '2003-09-29 18:01:29', 'AJM', '2003-10-28 21:59:02', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 3, 3, 'Have all electrical systems and equipment been tested and certified by a competent electrical engineer?', 'M', 'Electrical systems should be regularly checked to avoid defective equipment causing fires.  Such checks may also reduce inefficient operation of equipment and waste.', 10, '2003-09-29 18:17:49', 'AJM', '2003-10-02 11:30:18', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 4, 4, 'Has a competent person tested the electrical mains installations during the last 5 years?', 'M', 'Electrical installations deteriorate with time and fall behind the thinking in safety standards and design.  The demand on circuits may vary from one time to another by the increase or movement in electrical equipment being used.', 10, '2003-09-29 18:22:41', 'AJM', '2003-10-02 11:31:08', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 5, 5, 'Have all portable appliances been tested by a competent person during the last 5 years?', 'M', 'The use of portable equipment presents an additional problem regarding its positioning.  Such equipment may be connected to circuits already near their maximum loading or be postioned in such a manner as to cause danger from combustible materials.', 0, '2003-09-29 18:23:51', 'AJM', '2003-10-02 11:32:37', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 6, 6, 'Are records kept regarding the regular testing of installations, equipment and portable appliances?', 'M', 'In addition to a centally held register of checks and inspections carried out, it makes things far easier to manage if installations, appliances and equipment are fitted with a sticker or label showing when the last check was carried out.', 10, '2003-09-29 18:25:41', 'AJM', '2003-10-02 11:34:00', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 7, 7, 'Is a Permit to Work system operating and in regular use with contracted staff?', 'M', 'Health & Safety requirements demand some level of control over works carried out in order to manage the level of risk to the workforce and the public.', 10, '2003-09-29 18:27:45', 'AJM', '2003-10-02 11:44:15', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 8, 8, 'Do assessments comply with the Gas Safety (Installations and use) Regulations 1994?', 'M', 'The requirements of this legislation are very specific covering life threatening issues such as the risk of explosion and ventilation requirements.', 10, '2003-09-29 18:28:12', 'AJM', '2003-10-02 11:45:09', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 9, 9, 'Are all gas installations serviced by Corgi registered contractors?', 'M', 'Registration is in respect of individuals and not just organisations.  The recording of an individuals corgi number would not be inappropriate and would confirm that reasonable steps had been taken to confirm the safety of work to be carried out.', 10, '2003-09-29 18:28:35', 'AJM', '2005-01-15 23:56:45', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 10, 10, 'Are full records kept of gas installation servicing and assessments?', 'M', 'These records, whilst rarely asked for, would be invaluable for fire certification or to be followed up on subsequent to any problem that may occur.', 1, '2003-09-29 18:29:00', 'AJM', '2005-01-15 23:56:45', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 3, 1, 1, 'Is the Fire Certificate kept on the premises in a safe place ready for inspection by the Fire Service?', 'M', 'Documents may be easily misplaced.  Proper managment of administration in respect of certification can complete the picture of an organisation that is serious about safety.', 5, '2003-09-29 18:29:47', 'AJM', '2003-10-02 11:59:01', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 3, 2, 2, 'Is a copy of the Fire Certificate stored off site for insurance use after any fire?', 'M', 'For insurance and other uses, it should not be relied upon to get copies of documentation from third parties subsequent of any problem or disaster.', 10, '2003-09-29 18:30:14', 'AJM', '2003-10-02 12:00:08', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 3, 3, 3, 'What is the Fire Certificate number?', 'T', 'Ease of reference use only.', 1, '2003-09-29 18:30:35', 'AJM', '2003-10-02 12:00:48', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 3, 4, 4, 'On what date was the Fire Certificate issued?', 'T', 'The certificates are usually issued for a set period and should be within date.', 5, '2003-09-29 18:30:56', 'AJM', '2003-10-02 12:01:24', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 4, 1, 1, 'Are records up to date in respect of fire alarm weekly tests, three monthly services, faults and remedial action?', 'M', 'Such records may be inspected during fire certification or for health & safety purposes.', 10, '2003-09-29 18:31:47', 'AJM', '2003-10-03 15:46:09', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 4, 2, 2, 'Are records up to date in respect of emergency lighting monthly tests, three monthly service, faults and remedial action?', 'M', 'Such records may be inspected during fire certification or health & safety checks.', 0, '2003-09-29 18:32:08', 'AJM', '2003-10-03 15:46:50', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 4, 3, 3, 'Are records up to date in respect of hose reels and portable fire fighting equipment (extinguishers etc.) annual service, quarterly checks, faults and remedial action?', 'M', 'Such records should be properly managed for inspection during fire certification or health & safety checks.', 10, '2003-09-29 18:32:33', 'AJM', '2003-10-03 15:47:26', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 4, 4, 4, 'Are fire training records up to date?', 'M', 'Such records should be properly managed for inspection during fire certification or health & safety checks.', 10, '2003-09-29 18:32:53', 'AJM', '2003-10-03 15:48:08', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 1, 1, 'Are staff trained annually and issued with fire procedures in writing?', 'M', 'The employer should provide his/her employees with information regarding the risks identified and the measures taken to ensure their safety.  It is good practice to record all training given.', 5, '2003-09-29 18:33:35', 'AJM', '2003-10-03 15:41:50', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 2, 2, 'Have names of all trained staff, full and part time, shift and day workers etc., been entered into the fire safety record book?', 'M', 'Employers must appoint competent person(s) to assist them to comply with their obligations.  (A competent employee should be used in preference to a non-employee)', 5, '2003-09-29 18:33:59', 'AJM', '2003-10-03 15:43:26', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 3, 3, 'Have six monthly fire evacuation practices been carried out?', 'M', '1.  Regular training is necessary to keep evacuation plans effective.
2.  If occupants can leave the premises easily, then escape will be possible before exit routes become affected by fire.', 10, '2003-09-29 18:34:20', 'AJM', '2003-10-03 15:44:02', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 1, 1, 'Is regular testing and maintenance carried out?', 'M', 'Once systems are in place, ensure they will work when needed by following a well thought out maintenance and testing regime.', 5, '2003-09-29 18:34:56', 'AJM', '2003-10-03 15:50:57', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 2, 2, 'Are accurate records kept about tests?', 'M', 'Proof of regular testing will improve confidence in the systems and prevent neglect.', 10, '2003-09-29 18:35:17', 'AJM', '2003-10-03 15:51:35', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 3, 3, 'What is the name, address and telehone number of the maintenance engineers?', 'T', 'It is vital that information in respect of maintenance engineers is kept up to date.  Unless a constant relationship exists with the engineers concerned it may be a good idea to contact them after every fire practice to ensure that they can still provide the required services.', 10, '2003-09-29 18:35:42', 'AJM', '2003-10-03 16:14:44', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 7, 1, 1, 'Are records for testing, maintenance and repair of fixed installations, eg. central heating boilers, water systems, lifts, hoists and escalators up to date?', 'M', 'In addition to wear and tear on appliances the build ups that occur on certain equipment reduces their efficiency and can cause the emission of toxic fumes.  In a work environment it is also not uncommon for damage to occur to equipment that should not be allowed to go unrepaired.', 5, '2003-09-29 18:36:31', 'AJM', '2003-10-03 16:16:02', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 7, 2, 2, 'Are all vents and service ducts, etc. suitably protected where appropriate, to prevent the spread of fire, heat and smoke?', 'M', '1.  Slowing the effects of a fire relies on breaking a building down into compartments with fire doors and other such barriers.  It is necessary to take full care of ducts and other possible channels for heat and smoke to complete the compartmentalisation exercise.
2.  Vents and ducts can become blocked by birds and rodent activity or could simply be blocked by badly placed stores or goods being placed against them.', 5, '2003-09-29 18:37:00', 'AJM', '2003-10-03 16:16:46', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 1, 1, 'Is a good level of liaison maintained with the local Fire Service?', 'M', 'Efforts in this area make the Fire Service more knowledgeable about the site and therefore more effective when dealing with a fire on it.  Informal contact creates a less authoritarian approach when certification and other issues are being addressed.', 10, '2003-09-29 18:37:37', 'AJM', '2003-10-03 16:18:05', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 2, 2, 'Is there adequate access for fire appliances?', 'M', 'Inviting the Fire Service to inspect access arrangements is a very good icebreaker and ensures that problem areas such as parked cars can be dealt with well in advance of an emergency situation.', 10, '2003-09-29 18:37:58', 'AJM', '2003-10-03 16:18:37', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 3, 3, 'Has the Fire Service approved the location of the evacuation assembly area?', 'M', 'The Fire Service have their own specific views on this subject and they should be asked them in advance.  It is difficult enough checking an assembled mass of people to ensure that everyone is out of a building without the Fire Service asking you to move them somewhere else.', 10, '2003-09-29 18:38:19', 'AJM', '2003-10-03 16:19:16', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 4, 4, 'Are fire hydrants clearly indicated and accessible?', 'M', 'Fire hydrants should be clearly marked both on the ground and at eye level with a clear sign indicating their whereabouts.  Precautions and signs should also be in place to ensure they do not become blocked by parked vehicles or stacks of goods.', 5, '2003-09-29 18:38:41', 'AJM', '2003-10-03 16:20:03', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 1, 1, 'Are there clearly defined fire evacuation procedures?', 'M', 'Should a fire occur, the time available for escape is the time between the alarm being raised and the point  where conditions will no longer allow people to escape safely.', 5, '2003-09-29 18:39:22', 'AJM', '2003-10-03 16:33:49', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 2, 2, 'Do you have sufficient trained emergency marshalls to take control in an emergency situation?', 'M', 'Organisations must appoint competent person(s) to assist them to comply with their obligations where necessary.', 10, '2003-09-29 18:39:42', 'AJM', '2003-10-03 16:35:12', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 3, 3, 'Have all staff been briefed on how to activate the fire alarm system and to call the Fire Service for all fires, no matter how small?', 'M', '1.  Written information about the action to be taken in the event of a fire shall be made readily available to all employees.
2.  An initial period of at least half an hour of instruction should be given to all employees once every 6 months that should include calling the fire service and raising the alarm.  This should include learning the location of alarm call points.', 5, '2003-09-29 18:40:03', 'AJM', '2003-10-03 16:35:47', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 4, 4, 'Do the night shift workers benefit from an equal standard of fire training to day workers?', 'M', 'The training given to night shift workers should be equal to that given to day shift workers and include any specific issues that effect the night shift only such as coping with darkness issues etc.', 5, '2003-09-29 18:40:23', 'AJM', '2003-10-03 16:36:25', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 5, 5, 'Are all employees aware of what they must do in the event of a fire?', 'M', 'An initial period of instruction given every 6 months should include:
a. The action to be taken upon discovering a fire
b. The action to be taken on hearing a fire alarm', 5, '2003-09-29 18:40:48', 'AJM', '2003-10-03 16:37:12', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 6, 6, 'Are all employees aware that their first duty in the event of a fire is to raise the alarm?', 'M', 'This should be emphasised during 6 monthly instruction sessions.', 5, '2003-09-29 18:41:48', 'AJM', '2003-10-03 16:39:41', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 7, 7, 'Are all employees aware of what the fire alarm sounds like and that their main responsibility when the alarm is activated is to evacuate the building?', 'M', 'The sound should become known during weekly tests.', 5, '2003-09-29 18:42:17', 'AJM', '2003-10-03 16:40:17', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 8, 8, 'Are all employees trained/briefed on how to operate any break-glass alarm points?', 'M', 'This should form part of the 6 monthly instruction sessions.', 5, '2003-09-29 18:42:38', 'AJM', '2003-10-03 16:41:38', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 9, 9, 'Do all visitors receive information on the action to be taken in the event of a fire?', 'M', 'This can easily be included on the rear of any visitors pass issued and be pointed out as something that should be read by the visitor when the card is issued.', 5, '2003-09-29 18:43:03', 'AJM', '2003-10-03 16:42:09', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 10, 10, 'Will the visitors register be readily available in the event of a fire to ensure the safe evacuation of all visitors?', 'M', 'Either a carbon copy of visitors passes as part of a register or a print out from an electronic visitors register are the most straight forward way of achieving this.', 5, '2003-09-29 18:43:26', 'AJM', '2003-10-03 16:42:38', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 11, 11, 'Are a spare set of master keys available in a secure location to be handed to the Fire Service should they need them in the event of a fire?', 'M', 'These keys should logically form part of an emergency ''crash box'' kit that can be picked up and taken to the emergency control point in the event of any such emergency.', 10, '2003-09-29 18:43:50', 'AJM', '2003-10-03 16:55:21', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 1, 1, 'Are staff trained to use the nearest available fire exit?', 'M', 'By planning ahead and ensuring that everyone knows what to do in the case of fire the time to respond to an outbreak of fire will be reduced.', 10, '2003-09-29 18:44:51', 'AJM', '2003-10-26 09:58:21', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 2, 2, 'Do all exits lead to places of safety?', 'M', 'Ultimate safety is outside the building; Protected routes within the building will hold back the fire and extend the possible escape time.', 5, '2003-09-29 18:45:14', 'AJM', '2003-10-26 09:58:22', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 3, 3, 'Are all corridors and stairways free from obstruction and not used for storage?', 'M', 'Keep the corridors tidy, free from obstruction and remove rubbish regularly.', 5, '2003-09-29 18:45:36', 'AJM', '2003-10-26 09:58:24', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 4, 4, 'If the premises have external fire escapes, are these maintained in a safe condition and certified?', 'M', 'Structural checks and certification may be necessary for external fire escapes.  Older escapes may be constructed from materials subject to rust etc.', 5, '2003-09-29 18:46:33', 'AJM', '2003-10-26 09:58:26', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 5, 5, 'Are all floor and stairway surfaces in good condition, free from tripping and slipping hazards?', 'M', '1.  Corridors and doorways should be wide enough such that all persons needing to use them can escape to a place of safety in 2/3 minutes.  (In most cases it should be assumed that the largest exit route is not available because of the fire)
2.  Tripping and slipping hazards present a major health & safety problem that may be multiplied when moving in dense smoke or in poor lighting.', 5, '2003-09-29 18:46:53', 'AJM', '2003-10-26 09:58:27', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 6, 6, 'Is the normal electrical lighting functioning properly with no missing bulbs or badly lit areas?', 'M', 'It is often the case that normal lighting is able to operate throughout the evacuation of a building.  For the most helpful effect in an environment that may be made more difficult by smoke, normal lighting should be working efficiently.', 5, '2003-09-29 18:47:12', 'AJM', '2003-10-26 09:58:29', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 7, 7, 'Is any emergency lighting tested and working?', 'M', NULL, 5, '2003-09-29 18:47:59', 'AJM', '2003-10-26 09:58:31', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 8, 8, 'Are all fire exit doors frequently checked for serviceability and easily openable from the inside without the use of a key?', 'M', 'It may be possible to regularly check fire doors from the outside but occasionally they should be opened from the inside to ensure that their mechanisms are working.  This is particularly the case with doors fitted with glass bolts or alarms that are only used for real emergencies.', 5, '2003-09-29 18:48:24', 'AJM', '2003-10-26 09:58:31', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 1, 1, 'Are all staff given documented fire prevention instruction and advised how to report potential fire hazards?', 'M', 'This type of documented confirmation of training may be issued as a handout at the end of 6 monthly instruction sessions or be part of a workers handbook.', 10, '2003-09-29 18:50:56', 'AJM', '2003-10-03 17:07:59', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 2, 2, 'Do staff understand the importance of closing fire resisting doors to reduce the spread of fire or smoke?', 'M', 'Individuals should be instructed about the need to close all fire doors when an alarm is raised to break the building down into compartments slowing the spread of smoke and flames.', 10, '2003-09-29 18:51:14', 'AJM', '2003-10-03 17:08:50', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 3, 3, 'Is waste and rubbish collected regularly and place in safe receptacles, preferably outside the premises?', 'M', 'Keep the workplace tidy, remove rubbish regularly, keep equipment clean to maintain efficiency.', 10, '2003-09-29 18:51:36', 'AJM', '2003-10-03 17:09:32', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 4, 4, 'Are no smoking rules rigorously enforced?', 'M', 'Where smoking is allowed in designated areas, every effort should be made to encourage smokers to use them willingly.  The squalid nature of many facilities designed to attract smokers is off putting and unecessary.', 10, '2003-09-29 18:51:56', 'AJM', '2003-10-03 17:10:15', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 5, 5, 'Are there suitable facilities for the disposal of smoking materials if smoking rooms are provided?', 'M', 'Overfull, smoking, dirty boxes adorn the outside walls of many office blocks.  Such facilities should be emptied at reasonable intervals and should not be allowed to become a problem instead of being part of a cure.', 10, '2003-09-29 18:52:15', 'AJM', '2003-10-03 17:10:46', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 6, 6, 'Are any catering staff instructed in relevent areas of fire risk?', 'M', 'The kitchen environment presents specific fire risks that should be minimised by proper training and equipment.  In particular the use of fire blankets to deal with deep fat fryer fires should be covered.', 5, '2003-09-29 18:52:36', 'AJM', '2003-10-03 17:11:23', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 7, 7, 'Are any maintenance workshops kept clean and tidy?', 'M', 'Workshops are a traditional source of problems as a result of electrical tools and other equipment.  Paint and cleaning materials may also be a source of fire if not properly stored in the right containers.', 10, '2003-09-29 18:52:56', 'AJM', '2003-10-03 17:11:54', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 8, 8, 'Are cable runs to electrical equipment kept to a minimum and made as safe as possible?', 'M', 'Exposed cable may become damaged whilst concealed cable may be at risk of being trapped or crushed.  The insulation on cable carrying higher current may overheat if enclosed.', 10, '2003-09-29 18:53:16', 'AJM', '2003-10-03 17:12:29', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 9, 9, 'Are checks conducted to ensure that cables to equipment are not run where they may suffer from damage?', 'M', 'Running cables under floor coverings, through doorways and under cabinets or equipment should be avoided.', 5, '2003-09-29 18:53:32', 'AJM', '2003-10-03 17:14:33', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 10, 10, 'Is the upholstery covering on soft furnishings in good condition?', 'M', 'The foam in most soft furnishings gives off lethal gas when burning.  The fabric covering the foam is usually fire resistant and can slow the danger of toxic gases in the event of a fire.', 10, '2003-09-29 18:53:51', 'AJM', '2003-10-03 17:15:03', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 11, 11, 'Have measures been taken to reduce the risk of arson?', 'M', 'Good housekeeping and proper controls over combustible materials go a long way to reducing the opportunities for potential arsonists.  Controlling access to refuse collection and other areas where fires may be started is another good step to take.', 5, '2003-09-29 18:54:11', 'AJM', '2003-10-03 17:16:03', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 1, 1, 'Are all fire resisting doors in good condition, ie. closing fully on rebates and not wedged open?', 'M', 'Fire resisting doors are categorised in terms of the time they are designed to resist the effects of fire.  A fire resisting door that is damaged or not fitted properly will not achieve the resistance level required.', 5, '2003-09-29 18:54:46', 'AJM', '2003-10-03 17:17:27', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 2, 2, 'Where they are fitted, are self closing devices on fire resisting doors effective?', 'M', 'Self closing devices should be strong enough to completely close the door to which they are fitted and resist wind or drafts that may try and blow them ajar.', 5, '2003-09-29 18:55:03', 'AJM', '2003-10-03 17:18:00', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 3, 3, 'Are signs fixed on the following fire resisting doors at eye level on both sides of the door?  (Fire doors to stairways and those provided in corridors, or to rooms of high risk, eg. kitchen, boiler rooms)', 'M', 'Signs should be white lettering on a blue background that should read - ''FIRE DOOR - KEEP CLOSED''', 5, '2003-09-29 18:55:23', 'AJM', '2003-10-03 17:18:36', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 4, 4, 'Are signs fixed on fire resisting doors at eye level on both sides on fire doors to cupboards and stores, escape cooridors or stairways?', 'M', 'Signs should be white letters on a blue background and read - FIRE DOOR - KEEP LOCKED AND CLOSED.', 5, '2003-09-29 18:55:41', 'AJM', '2003-10-03 17:19:57', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 5, 5, 'Are signs fixed on fire resisting doors at eye level on both sides on automatic fire doors fitted with magnetic or other type of release mechanism?', 'M', 'Signs should be white lettering on a blue background and read - AUTOMATIC FIRE DOOR - KEEP CLEAR', 5, '2003-09-29 18:56:03', 'AJM', '2003-10-03 17:21:21', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 1, 1, 'Are notices provided at fire exit doors and corridors?', 'M', 'Signs should be pictograms showing a running man with a directional arrow.  NB; ''Exit'' and ''Fire Exit'' signs are not mandatory, but are considered to be supplementary to picotgrams.', 5, '2003-09-29 18:56:35', 'AJM', '2003-10-03 17:22:21', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 2, 2, 'Are notices provided over panic bars on fire exit doors?', 'M', 'Signs should be white lettering on a green background and read - PUSH BAR TO OPEN.', 5, '2003-09-29 18:56:50', 'AJM', '2003-10-03 17:22:53', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 3, 3, 'Are fire evacuation procedure notices displayed adjacent to all fire alarm break-glass call points?', 'M', 'Such notices should give the brief details necessary to convey on fire drills and fire evacuation at the very least.', 5, '2003-09-29 18:57:07', 'AJM', '2003-10-03 17:23:27', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 4, 4, 'Are fire evacuation procedure notices displayed on Health & Safety notice boards?', 'M', 'These notices should precis the basic details regarding fire prevention and evacuation.', 5, '2003-09-29 18:57:30', 'AJM', '2003-10-03 17:23:56', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 1, 1, 'Has the level of fire fighting equipment (extinguishers, fire blankets, etc.) been the subject of a professional and documented survey?', 'M', 'Employers must carry out risk assessments to identify risks to employees at work and others in connection with the undertaking.  The level of fire fighting equipment should directly relate to the perceived risk.', 10, '2003-09-29 18:58:19', 'AJM', '2003-10-03 17:24:52', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 2, 2, 'Is the level of equipment available in line with the recommendations of such a survey?', 'M', 'To establish a proper level of fire fighting equipment issue it may be necessary to seek expert advice.', 10, '2003-09-29 18:58:36', 'AJM', '2003-10-03 17:25:31', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 3, 3, 'Is the presence of equipment at approved ''fire points'' the subject of a weekly check?', 'M', 'Routine checks by appropriate individuals such as security or caretaking staff should record such checks.', 10, '2003-09-29 18:58:55', 'AJM', '2003-10-03 17:26:06', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 4, 4, 'Is the serviceability of equipment the subject of a 6 monthly certified inspection?', 'M', 'Testing regime should be in accordance with BS 5306 or equivalent.', 5, '2003-09-29 18:59:11', 'AJM', '2003-10-03 17:27:03', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 5, 5, 'Are all staff trained in the use of all types of available fire fighting equipment?', 'M', 'This is best done on the day of the visit by whoever it is that maintains fire fighting equipment.  Any equipment scheduled to be refilled or regassed can then be used for training purposes.', 10, '2003-09-29 18:59:28', 'AJM', '2003-10-03 17:27:33', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 1, 1, 'Are the premises fitted with emergency lighting?', 'M', 'This section will be automatically skipped if the answer is no to this question.', 10, '2003-09-29 19:00:04', 'AJM', '2003-10-03 17:28:28', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 2, 2, 'Is the emergency lighting system in good working order?', 'M', 'Testing regime should be in accordance with BS 5266 or equivalent.', 10, '2003-09-29 19:00:30', 'AJM', '2003-10-03 17:28:58', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 3, 3, 'Are emergency lighting units visually tested?', 'M', '''Maintained'' units will have sign illumination and the red LED lit.  ''Non-maintained'' units will not be lit but the red LED will be lit.  The red LED indicates power feeding the unit.', 10, '2003-09-29 19:00:45', 'AJM', '2003-10-03 17:29:26', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 4, 4, 'Are monthly checks undertaken involving the switching off of power and ensuring that all emergency lights are lit?', 'M', 'This type of test should only be undertaken by authorised and trained individuals to prevent damage to equipment or loss of data from computer systems.', 10, '2003-09-29 19:01:00', 'AJM', '2003-10-03 17:29:55', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 1, 1, 'Is the fire alarm system in good working order?', 'M', 'The testing regime should be in accordance with BS 5839 or equivalent.', 5, '2003-09-29 19:01:37', 'AJM', '2003-10-03 17:30:47', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 2, 2, 'Can the alarm be raised without anyone being placed at risk from fire?', 'M', NULL, 5, '2003-09-29 19:01:54', 'AJM', '2003-10-03 17:31:11', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 3, 3, 'Are the break-glass call points unobstructed, clearly visible and suitably indicated?', 'M', NULL, 10, '2003-09-29 19:02:14', 'AJM', '2003-10-03 17:31:34', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 4, 4, 'Is the fire alarm system subject to an annual inspection and certified as serviceable?', 'M', NULL, 5, '2003-09-29 19:02:34', 'AJM', '2003-10-03 17:31:57', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 1, 1, 'Are suitable controls exercised over fire prevention issues in relation to alterations, repairs, decoration and any other works?', 'M', 'Property owners should advise any contractors'' employers of any fire risks and the measures to be taken to comply with Fire Precaution Regulations.', 5, '2003-09-29 19:03:09', 'AJM', '2003-10-03 17:33:37', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 2, 2, 'Are suitable checks carried out to ensure that means of escape remain unobstructed during alterations, repairs, decoration and other works?', 'M', 'The employer should advise any contractors'' employers or ''in house'' workers undertaking modification or maintenance work of any requirements to sustain compliance with Fire Precaution Regulations.  Reasonable checks should be conducted to ensure that work is carried out in line with these conditions.', 5, '2003-09-29 19:03:25', 'AJM', '2003-10-03 17:34:21', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 3, 3, 'Are plans for alterations subject to professional approval to ensure no reduction in fire safety will result from the completion of the proposed work?', 'M', 'In addition to the view of a competent structural professional it may be adviseable to seek the advice of the fire service officer responsible for certification of the building.', 10, '2003-09-29 19:04:08', 'AJM', '2003-10-03 17:34:50', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 18, 1, 1, 'Is a permit to work system used for all external contractors?', 'M', 'Employers should advise any contractors'' employers of any fire risks and the measures taken to comply with Fire Precaution Regulations.', 10, '2003-09-29 19:04:40', 'AJM', '2003-10-03 17:35:35', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 18, 2, 2, 'Are duplicates of Work Permits kept on file for reference and inspection by the Enforcing Authorities?', 'M', 'Duplicates are useful both from a management perspective and as a tool for use in any investigation subsequent to an incident involving fire.', 10, '2003-09-29 19:05:00', 'AJM', '2003-10-03 17:36:04', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 19, 1, 1, 'Are heating appliances in a fixed position at a safe distance from any combustible materials, and suitably guarded?', 'M', 'Free standing heating appliances should be avoided wherever possible and all heaters should be fitted with appropriate guards to prevent them coming into contact with combustible materials.', 10, '2003-09-29 19:05:29', 'AJM', '2003-10-03 17:37:43', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 20, 1, 1, 'Are private electrical appliances allowed to be used in the premises?', 'M', 'The use of private electrical appliances in premises should be discouraged if possible.', 1, '2003-09-29 19:06:06', 'AJM', '2003-10-03 17:39:00', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 20, 2, 2, 'Are all electrical appliances routinely checked for serviceability and to ensure that fuses are fitted of the correct ampage for the appliance?', 'M', 'This should be carried out by a certified electical operative.', 10, '2003-09-29 19:06:28', 'AJM', '2003-10-03 17:39:29', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 20, 3, 3, 'Are records kept of appliance checks and are all appliances in used fitted with a sticker to prove such checks have been carried out?', 'M', 'Off the shelf packs of self adhesive stickers can be purchased from many stationery suppliers.', 10, '2003-09-29 19:06:47', 'AJM', '2003-10-03 17:39:58', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 1, 1, 'Are all flammable substances and materials stored safely?', 'M', 'Store flammables in a suitable container, ideally away from any main building, in stores with appropriate ventilation.', 5, '2003-09-29 19:07:16', 'AJM', '2003-10-03 17:40:43', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 2, 2, 'Is any system in place for controlling the amounts of flammable and combustible materials that are on the premises and is the system effective?', 'M', 'If the item which is presenting the hazard cannot be removed entirely then steps should be taken to ensure that quantities are kept to a minimum.  If it is practicable to remove the item between usage then this step should also be taken.', 10, '2003-09-29 19:07:31', 'AJM', '2003-10-03 17:41:15', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 3, 3, 'If liquified petroleum gas (lpg) is used, (eg. fork lift or vehicle fuel etc.) is the product stored outside in a secure safety cage?', 'M', 'Amounts of lpg being stored should be kept to an absolute minimum and storage should only be done in a properly ventilated facility.  The ideal facility is a secure external cage well away from the building and any vehicles on the site.', 10, '2003-09-29 19:07:48', 'AJM', '2003-10-03 17:41:41', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 4, 4, 'Have the various COSHH recommendations been followed in respect of any flammable or combustible materials on the premises?', 'M', 'Advice on particular materials and substances should be supplied by the manufacturer or supplier.  In the absence of such advice the materials concerned should be treated with caution and steps should be taken to seek the advice needed.', 5, '2003-09-29 19:08:05', 'AJM', '2003-10-03 17:42:15', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 22, 1, 1, 'Are records kept and available on any threat to fire safety on the site?', 'M', 'Proper records should be maintained in respect of incidents so that better informed preventive action may be taken.  Certain incidents are legally notifiable to the Health & Safety Executive.', 10, '2003-09-29 19:08:37', 'AJM', '2003-10-03 17:44:31', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 22, 2, 2, 'Are records maintained of any remedial activity prompted as a result of any fire risk report?', 'M', 'Full records should be maintained to ensure continued vigilence in respect of measures put in place.', 10, '2003-09-29 19:08:55', 'AJM', '2003-10-03 17:44:59', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (1, 22, 3, 3, 'What is the name of the individual in full charge of fire safety on the site?', 'T', NULL, 10, '2003-09-29 19:09:44', 'AJM', '2003-10-03 17:47:58', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 1, 1, 'Are all areas of the workplace adequately ventilated?', 'M', 'Clean air should be drawn into the workplace that is uncontaminated by discharges from vents, chimneys or other outlets to be circulated throughout workrooms.', 5, '2003-10-18 21:07:45', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 2, 2, 'Is any excess humidity, vapour, dust or warmth diluted by ventilation systems without creating draughts?', 'M', 'Where air is contaminated by excess heat, dust, vapour or humidity the amount of fresh air needed to provide ventilation that is adequate increases.

Open windows may need to be replaced or subsidised by mechanical means of ventilation to achieve the required level of air exchange.', 5, '2003-10-18 21:17:21', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 3, 3, 'Is a satisfactory temperature maintained in the workplace?', 'M', 'For mainly sedantry workplaces the temperature should normally be maintained at over 16C.

For physical work environments the temperature should normally be maintained at over 13C unless other regulation requires temparatures to be lower.', 5, '2003-10-18 21:19:02', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 4, 4, 'Does the working environment involve exposure to excesses of heat or cold such as those found in cold stores or foundries?', 'M', 'Specialist regulation, equipment and working conditions may apply to such workplaces for which advice should be obtained from expert sources.', 5, '2003-10-18 21:20:13', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 1, 1, 'Are lighting levels sufficient to enable people to work and move around safely?', 'M', 'This question applies to the general area of the workplace and not to specific workstations.', 5, '2003-10-18 21:26:09', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 2, 2, 'This question applies to the general area of the workplace and not to specific workstations.', 'M', 'Care should be taken with local lighting to avoid glare or the addition of danger from the use of unsuitable or inappropriately installed fittings.', 0, '2003-10-18 21:27:18', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 3, 3, 'Is local lighting provided at individual workstations?', 'M', 'Lights or their method of installation should not create additional hazards in themselves.', 0, '2003-10-18 21:28:15', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 4, 4, 'Is automatic emergency lighting provided where sudden loss of light would create a risk?', 'M', 'Emergency lighting should be powered by an independent source.', 5, '2003-10-18 21:29:45', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 3, 1, 1, 'Are workplace floors, walls and ceilings kept clean?', 'M', 'Cleaning should be carried out as necessary by an effective method.', 5, '2003-10-18 21:30:51', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 3, 2, 2, 'Are surfaces, furnishings and fittings kept clean?', 'M', 'Cleaning should be carried out as necessary by an effective method.', 5, '2003-10-18 21:31:44', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 3, 3, 3, 'Are waste items removed as necessary and stored in suitable receptacles?', 'M', 'Where possible, waste materials and refuse should be stored in suitable receptacles away from the workplace.', 5, '2003-10-18 21:32:49', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 4, 1, 1, 'Does the workplace have enough space to allow people move about with ease?', 'M', 'Every person has a minimum personal entitlement of 11 cubic metres.  The layout of certain workplaces or the nature of the work undertaken may cause 11 cubic metres to be insufficient in practical terms.', 5, '2003-10-18 21:34:10', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 4, 2, 2, 'Are workstations suitable for the physical attributes of the people using them?', 'M', 'Irrespective of size, individuals must be able to work comfortably and leave workstations quickly in the event of an emergency.', 5, '2003-10-18 21:35:29', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 4, 3, 3, 'Is any seating provided suitable for the people and the type of work carried out?', 'M', 'Seating should give adequate support for the lower back with footrests provided where workers cannot place their feet flat on the floor.', 5, '2003-10-18 21:36:16', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 5, 1, 1, 'Are equipment, devices and systems maintained in efficient working order for health safety and welfare?', 'M', 'Any ventilation system, equipment or device which would cause a risk to health, safety or welfare if a fault occurred should be subject to a managed regime of maintenance.', 5, '2003-10-18 21:37:05', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 1, 1, 'Are there sufficient traffic routes, of sufficient width and headroom to allow people and vehicles to circulate safely with ease?', 'M', '''Traffic route'' means a route for pedestrian traffic, vehicles, or both, and includes any stairs, fixed ladder, doorway, gateway, loading bay or ramp.', 5, '2003-10-18 21:38:02', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 2, 2, 'Are floors and traffic routes sound and strong enough for the loads placed on them and traffic expected to use them?', 'M', 'The surfaces should not have holes, be uneven, have unsuitable gradients, or be slippery.  All routes should be kept free of obstructions.', 5, '2003-10-18 21:39:59', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 3, 3, 'Are all restrictions clearly indicated?', 'M', 'Hazards on all routes should be minimised with the use of signs, mirrors, speed limits and one way circuits where required.', 5, '2003-10-18 21:40:49', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 4, 4, 'Are screens or other measures taken to protect people from the effects of exhaust fumes or materials that may fall from vehicles?', 'M', 'Items such as added ventilation or protective cages and barriers should be considered to protect workers in the vicinity of a vehicle route.', 5, '2003-10-18 21:41:33', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 5, 5, 'Are additional measures in place where pedestrians have to cross or share a route with vehicles?', 'M', 'Such measures may include speed limits, barriers, signage, road markings, pedestrian crossings or bridges.', 5, '2003-10-18 21:42:18', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 6, 6, 'Are open sides to staircases fenced with an upper rail of at least 900mm and a lower rail?', 'M', 'The upper rail on open staircases should be 900mm or higher with other rails or barriers fitted at intervals that are suitable.', 5, '2003-10-18 21:43:21', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 7, 7, 'Are handrails fitted on at least one side of every staircase and on both sides if there is a particular risk?', 'M', 'Additional handrails may be required down the centre of wide staircases.  Access between floors should not be by ladders or steep stairs.', 5, '2003-10-18 21:44:26', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 8, 8, 'Are barriers or portable wheel stops provided to stop vehicle falls where loads are to be tipped into pits or similar places?', 'M', 'Barriers and wheel stops should have sufficient substance to be effective.', 5, '2003-10-18 21:45:11', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 9, 9, 'Are loading bays provided with at least one exit or refuge to avoid people being struck or crushed by vehicles?', 'M', 'Measures should be implemented to reduce the direct mix between moving vehicles and pedestrians.  Steps should always be taken to improve the visibility for drivers and provide early warning of the presence of vehicles to pedestrians by warning buzzers or other means.', 5, '2003-10-18 21:46:02', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 1, 1, 'Is adequate fencing provided where a person may fall two metres or more, or where they may fall less than two metres and risk serious injury?', 'M', 'Fencing should be securely fixed, at least 1100mm high, and have two guard-rails.', 5, '2003-10-18 21:47:07', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 2, 2, 'Are all pits, tanks or other structures where a fall might occur securely fenced or covered?', 'M', 'Covers must be firmly fixed and capable of bearing the weight of a person or vehicle as required with any fencing necessary to a height of at least 1100mm.', 5, '2003-10-18 21:48:11', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 3, 3, 'Are fixed ladders of sound construction, properly maintained and securely fixed?', 'M', 'Rungs should be horizontal and give adequate foothold and the stiles should extend at least 1100mm above any landing.  Fixed ladders over 2.5m long at a pitch of more than 75 degrees should be fitted with safety hoops or permanently fixed fall-arrest systems.  Fixed ladders should only be used if it is not practical to install a staircase.', 5, '2003-10-18 21:49:14', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 4, 4, 'Are measures in place to enhance the safety of workers having to work on roofs or other high places such as the tops of vehicles or loads?', 'M', 'Measures may include fall-arrest systems or crawling boards.  Fragile roofs should be clearly indicated by appropriate signage.  Where possible people should avoid climbing on top of vehicles or their loads.', 5, '2003-10-18 21:50:25', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 1, 1, 'Are storage racking and shelving of adequate strength and stability for the loads placed on them?', 'M', 'Damaged racking or shelving may be substantially weaker than it is supposed to be and collapse under less weight than its normal or recommended workload.  The training and skill of transport operators is vital to prevent and minimise damage.', 5, '2003-10-18 21:51:30', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 2, 2, 'Are checks regularly undertaken to identify and report damaged shelving or racking?', 'M', 'Visual checks should be supported by physical checks that include any fixings or bolts.', 5, '2003-10-18 21:52:29', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 3, 3, 'Are procedures in place to ensure that employees are aware of the need to report any type of damage to racking, shelving or lifting equipment to ensure that the effects on safety may be quickly assessed?', 'M', 'In order to create an audit trail to ensure that reports do not slip through the net it is adviseable to operate a journal in which all reports are recorded along with any remedial action.', 5, '2003-10-18 21:53:14', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 4, 4, 'Are maximum load notices fitted and legible on racking and shelving?', 'M', 'Proper knowledge of the weight of goods being racked or shelved is essential for these notices to have any effect.', 5, '2003-10-18 21:54:31', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 5, 5, 'Are appropriate precautions applied to activity involved in stacking and storing goods?', 'M', 'Precautions should include:
1.  safe stacking on sound pallets
2.  banding or wrapping to prevent individual articles falling
3.  setting limits for the height of stacks to maintain stability
4.  regular inspection of stacks to detect and remedy any unsafe stacks
5.  instruction and training of employees in stacking
6.  special arrangements for goods that may be difficult to store', 5, '2003-10-18 21:55:44', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 9, 1, 1, 'Are windows, transparent or translucent surfaces in walls, partitions, doors and gates made of safety material or protected against breakage?', 'M', 'If there is a danger of people coming into contact with these they should be marked or incorporate features to make them apparent.', 0, '2003-10-18 21:56:47', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 9, 2, 2, 'Is there a foreseeable risk of people coming into contact with glazing and being hurt?', 'M', 'If this is the case, the glazing will ned to meet the requirements of the Regulations.', 0, '2003-10-18 21:57:38', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 10, 1, 1, 'Are openable windows, skylights and ventilators able to be opened, closed or adjusted safely?', 'M', 'It should not be necessary to climb on desks, chairs or other things to open windows or lean out of windows to close or adjust them.', 0, '2003-10-18 21:58:41', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 10, 2, 2, 'When windows are open do they present any danger either inside or outside the building?', 'M', 'In addition to any risk of people or objects falling out consideration should be given to the possibility of people banging their heads or coming into contact with the open window in other ways that might cause injury.', 0, '2003-10-18 22:00:19', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 10, 3, 3, 'Are windows and skylights designed so that they can be cleaned safely?', 'M', 'Account should be taken of any equipment used in conjunction with the window or skylight or of devices fitted to the building.', 0, '2003-10-18 22:01:15', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 1, 1, 'Are doors and gates suitably constructed and fitted with any necessary safety devices?', 'M', 'The construction of doors must be appropriate to their use.  Fire and smoke resistance should be considered in addition to the safety and ease of those using them.  Heavy closing mechanisms or inappropriate glass may be examples of dangers to be dealt with.', 0, '2003-10-18 22:02:07', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 2, 2, 'Do doors and gates that swing both ways have transparent viewing panels?', 'M', 'The potential dangers involve such things as injuries caused by the door swinging unexpectedly into people or items being carried such as hot food being knocked over people.', 0, '2003-10-18 22:02:52', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 3, 3, 'Do any power-operated doors or gates have safety features to prevent people being stuck or trapped?', 'M', 'Where necessary such doors or gates should be fitted with readily identifiable and accessible controls or devices so that they can be stopped quickly in an emergency.', 0, '2003-10-18 22:03:48', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 4, 4, 'Are any upward-opening doors or gates fitted with effective devices to prevent them falling back?', 'M', 'Provided that they are properly maintained, counterbalance springs and similar counterbalance or ratchet devices to hold them in the open position are acceptable.', 0, '2003-10-18 22:04:45', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 12, 1, 1, 'Do any escalators or moving walkways function safely and are they fitted with necessary safety devices?', 'M', 'Emergency stop controls should be easily identifiable and readily accessible.', 5, '2003-10-18 22:05:50', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 1, 1, 'Are suitable and sufficient sanitary conveniences and washing facilities provided at readily accessible places?', 'M', 'Facilities should be kept clean, adequately ventilated and lit.  Washing facilities should have running hot and cold or warm water, soap and clean twels or other means of hand drying.  If required by the type of work, showers should also be provided.  Men and women should have separate facilities unless each facility is in a separate room with a lockable door and is for use by only one person at a time.', 5, '2003-10-18 22:07:04', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 2, 2, 'Is an adequate supply of wholesome drinking water provided?', 'M', 'The supply should be from a fountain with an upward drinking jet of suitable cups should be provided.  Where it cannot be provided from mains supply the water should be supplied from refillable enclosed containers.  The containers should be refilled at least daily (unless they are chilled water dispensers that are returned to the supplier for refilling).  Bottled dispensing systems may still be provided as a secondary source of drinking water.', 5, '2003-10-18 22:39:31', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 3, 3, 'Are adequate, suitable and secure facilities available to store workers'' own clothing and special clothing?', 'M', 'As far as reasonably practicable the facilities should allow for drying clothing.  Changing facilities should also be provided for workers who change into special work clothing.  The facilities should be readily accessible from workrooms and washing and eating facilities and should ensure the privacy of the user.', 5, '2003-10-18 22:40:21', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 4, 4, 'Are suitable and sufficient, readily accessible, rest facilities available?', 'M', 'Rest areas or rooms should be large enough, and have sufficient seats with backrests and tables, for the number of workers likely to use them at any time.  They should includ suitable facilities to eat meals where meals are regularly eaten in the workplace and the food would otherwise be likely to become contaminated.', 5, '2003-10-18 22:41:09', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 5, 5, 'Are seats provided for workers to use during breaks?', 'M', 'These should be in a place where personal protective equipment need not be worn.  Work areas can be counted as rest areas and as eating facilities, provided they are adequately clean and there is a suitable surface on which to place food.  Where provided, eating facilities should include a facility for preparing or obtaining a hot drink.  Where hot food cannot be obtained in, or reasonably near to the workplace, workers may need to be provided with a means for heating their own food.  Canteens or restaurants may be used as rest facilities so long as their is no obligation to purchase food.', 5, '2003-10-18 22:43:29', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 6, 6, 'Are suitable rest facilities available for pregnant women and nursing mothers?', 'M', 'Such facilities should be close to sanitary facilities and, where necessary, include the facility to lie down.', 5, '2003-10-18 22:44:42', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 7, 7, 'Do rest facilities away from the workstation include arrangements to protect non-smokers from discomfort caused by tobacco smoke?', 'M', 'The link between passive smoke inhalation and disease is such that is often less complicated to offer a separate facility away from normal rest areas to smokers.  Suitable effective air extraction facilities may offer a workable alternative where separate facilities cannot be created.', 5, '2003-10-18 22:45:28', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 1, 1, 'Do you have a defined perimeter over and above the footprint of the building?', 'M', 'The response should include comment on any defined land over which the organisation has responsibility.', 10, '2003-10-19 19:39:37', 'AJM', '2003-10-27 13:45:24', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 2, 2, 'Type of perimeter fence or wall?', 'T', 'Strongly built, and difficult to scale fences should be erected where appropriate if planning restrictions allow.', 10, '2003-10-19 19:42:03', 'AJM', '2003-10-27 13:45:24', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 3, 3, 'Height of perimeter fence or wall?', 'T', 'Where planning restrictions allow, fences or walls of at least 2 metres should be constructed sympethetically surrounding all properties of the Company.', 1, '2003-10-19 19:43:04', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 4, 4, 'Environmental features around perimeter?  (Trees, shrubs, buildings etc.)', 'T', 'Trees and shrubs should be planted in a way that does not create cover for trespassers to hide in or behind.  Where appropriate they are to be of a thorned variety to enhance security.  Care is to be taken not to let planting compromise fence or wall lines by overhanging the structure.', 10, '2003-10-19 19:44:11', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 5, 5, 'What perimeter systems are installed?  (CCTV, Alarms, Movement Detectors etc.)', 'T', 'Simply list the equipment that is installed in addition to any efforts or facility to integrate systems.', 10, '2003-10-19 19:46:34', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 6, 6, 'What perimeter access controls are in place?  (Manned entry points, turnstiles, pass controlled gates etc.)', 'T', 'Access control may be achieved by a variety of means either using equipment or manpower.  State the number and type of controls in place eg. manned check point, automatic card reading turnstile etc.', 10, '2003-10-19 19:49:01', 'AJM', '2003-10-27 13:33:14', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 7, 7, 'How are perimeter systems integrated and monitored?', 'T', 'Systems may be integrated by technology or monitored in one place and integrated by a human interface.  Describe the situation on the site.', 1, '2003-10-19 19:50:01', 'AJM', '2003-10-27 13:33:16', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 8, 8, 'Is the perimeter covered by its own security lodge?', 'M', 'It is not essential that the perimeter has its own gate lodge but the function is so important as to justify a devoted resource if this is practicable.', 1, '2003-10-19 19:51:32', 'AJM', '2003-10-27 13:33:18', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 9, 9, 'Does the perimeter have any weak areas?', 'T', 'The weak areas of a perimeter may be caused by damage to fences or walls or a structural problem such as adjoining property that cannot be fully resolved.  Whatever the issue look at the property from the outside with a view to gaining access and note then strengthen any weakness by practical means where possible.', 10, '2003-10-19 19:53:04', 'AJM', '2003-10-27 13:33:20', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 10, 10, 'Is the lighting on the perimeter adequate?', 'T', 'Cover of darkness is a great confidence booster to unwelcome visitors.  Monitoring is impossible without the use of image enhancement in the dark.  The comfort of people is usually increased by a light and welcoming atmosphere.  Reasonable lighting is normally of great value for a wide variety of positive reasons.', 1, '2003-10-19 19:53:52', 'AJM', '2003-10-27 13:33:20', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 2, 1, 1, 'Type of construction & physical shell?', 'T', NULL, 0, '2003-10-19 19:55:47', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 2, 2, 2, 'Any environmental features effecting structural integrity?', 'T', NULL, 0, '2003-10-19 19:56:19', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 2, 3, 3, 'What security systems are used to monitor the building? (CCTV, Alarms etc.)', 'T', NULL, 0, '2003-10-19 19:57:02', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 2, 4, 4, 'What access control systems are used in the Building?  (Digital locks, swipe systems, manned entrances etc)', 'T', NULL, 0, '2003-10-19 19:57:33', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 2, 5, 5, 'Does the building have any vulnerable areas?', 'T', NULL, 0, '2003-10-19 19:58:53', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 2, 6, 6, 'Is equipment or other property recorded when removed from the building?', 'T', NULL, 0, '2003-10-19 19:59:21', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 1, 1, 'Are security systems on a maintenance contract?', 'T', NULL, 0, '2003-10-19 19:59:56', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 2, 2, 'Are the fire detection systems and equipment on maintenance contracts?', 'T', NULL, 0, '2003-10-19 20:00:22', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 3, 3, 'Does the site have CCTV coverage?', 'M', NULL, 0, '2003-10-19 20:00:53', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 4, 4, 'Is the CCTV system recorded?', 'M', NULL, 0, '2003-10-19 20:01:48', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 5, 5, 'Type of intruder alarms used?', 'T', NULL, 0, '2003-10-19 20:02:29', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 6, 6, 'How are intruder alarms and systems monitored?', 'T', NULL, 0, '2003-10-19 20:02:57', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 7, 7, 'How is the response to an alarm activation co-ordinated?', 'T', NULL, 0, '2003-10-19 20:03:37', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 8, 8, 'Type of fire alarms used?', 'T', NULL, 0, '2003-10-19 20:04:03', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 9, 9, 'How are fire alarms monitored?', 'T', NULL, 0, '2003-10-19 20:04:27', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 10, 10, 'How is the response to a fire alarm activation co-ordinated?', 'T', NULL, 0, '2003-10-19 20:04:54', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 11, 11, 'Does the site have either portable or fixed panic alarms for personnel?', 'T', NULL, 0, '2003-10-19 20:05:23', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 12, 12, 'How are panic alarms monitored?', 'T', NULL, 0, '2003-10-19 20:06:08', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 13, 13, 'How is the response to panic alarm activations co-ordinated?', 'T', NULL, 0, '2003-10-19 20:06:33', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 14, 14, 'Is patrol activity monitored on the site?', 'T', NULL, 0, '2003-10-19 20:07:01', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 15, 15, 'Are radios or pagers used on the site?', 'T', NULL, 0, '2003-10-19 20:07:35', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 16, 16, 'What formal training is carried out in respect of sysems and equipment?', 'T', NULL, 0, '2003-10-19 20:08:05', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 17, 17, 'What arrangements exist to cover equipment down time?', 'T', NULL, 0, '2003-10-19 20:08:32', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 4, 1, 1, 'What performance monitoring criteria do security staff work to?', 'M', NULL, 0, '2003-10-19 20:09:57', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 4, 2, 2, 'Are dedicated security staff employed?', 'M', NULL, 0, '2003-10-19 20:14:31', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 4, 3, 3, 'How many security staff are employed?', 'N', NULL, 0, '2003-10-19 20:15:19', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 4, 4, 4, 'What selection and vetting procedures are applied to security employees?', 'T', NULL, 0, '2003-10-19 20:16:14', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 4, 5, 5, 'What training standards are required to be achieved by security staff?', 'T', NULL, 0, '2003-10-19 20:33:07', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 4, 6, 6, 'Are formal review meetings on performance regularly held?', 'T', NULL, 0, '2003-10-19 20:33:41', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 4, 7, 7, 'What procedures are in place to deal with any guard offending or poor discipline?', 'T', NULL, 0, '2003-10-19 20:35:26', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 4, 8, 8, 'Are employees contractually obliged to co-operate with security staff?', 'T', NULL, 0, '2003-10-19 20:57:02', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 5, 1, 1, 'Does the site have documented evacuation procedures?', 'T', NULL, 0, '2003-10-19 20:57:37', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 5, 2, 2, 'Are evacuations regularly practiced?', 'T', NULL, 0, '2003-10-19 20:58:10', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 5, 3, 3, 'Are alarms regularly tested?', 'M', NULL, 0, '2003-10-19 20:58:54', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 5, 4, 4, 'Are procedures in place in respect of suspect packages or bomb warnings?', 'T', NULL, 0, '2003-10-19 21:00:30', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 5, 5, 5, 'Are evacuation assembly points clearly indicated?', 'T', NULL, 0, '2003-10-19 21:00:56', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 5, 6, 6, 'Are there any particularly hazardous areas or substances on the site?', 'T', NULL, 0, '2003-10-19 21:01:31', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 5, 7, 7, 'Are clear instructions given to prevent the use of any lifts in the event of an evacuation?', 'T', NULL, 0, '2003-10-19 21:01:57', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 5, 8, 8, 'Are evacuation marshalls appointed and trained?', 'T', NULL, 0, '2003-10-19 21:03:06', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 5, 9, 9, 'Are local emergency services familiar with the site and facilities?', 'T', NULL, 0, '2003-10-19 21:03:26', 'AJM', NULL, NULL);
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 6, 1, 1, 'Is the issue of keys controlled through a written procedure?', 'T', NULL, 0, '2003-10-19 21:04:03', 'AJM', '2003-10-25 20:53:28', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 6, 2, 2, 'Are keys and passes suited or zoned?', 'T', NULL, 0, '2003-10-19 21:04:43', 'AJM', '2003-10-25 20:53:29', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 6, 3, 3, 'Are procedures in place to deal with any compromise of keys, passes or access codes?', 'T', NULL, 0, '2003-10-19 21:05:11', 'AJM', '2003-10-25 20:53:31', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 6, 4, 4, 'Are duplicates to keys and passes retained for use in an emergency?', 'T', NULL, 0, '2003-10-19 21:05:38', 'AJM', '2003-10-25 20:53:31', 'AJM');
INSERT INTO survey_question (survey_id, section_id, question_id, question_seq, question_text, answer_type, advice_text, risk_status_id, created_date, created_user, revised_date, revised_user) VALUES (3, 6, 5, 5, 'test', 'M', 'test', 0, '2004-07-23 15:31:37', 'AJM', NULL, NULL);


--
-- TOC entry 1820 (class 0 OID 23852)
-- Dependencies: 1361
-- Data for Name: survey_section; Type: TABLE DATA; Schema: survey; Owner: postgres
--

INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (3, 1, 1, 'PERIMITER SECURITY', '2003-09-25 18:55:49', 'AJM', '2003-10-25 19:32:29', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (3, 2, 2, 'BUILDING SECURITY', '2003-09-25 18:56:07', 'AJM', '2003-10-25 19:32:31', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (3, 3, 3, 'SYSTEMS & EQUIPMENT', '2003-09-25 18:56:40', 'AJM', '2003-10-25 19:32:32', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (3, 4, 4, 'GUARDING SERVICES', '2003-09-25 18:57:02', 'AJM', '2003-10-25 20:53:13', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (3, 5, 5, 'EMERGENCY PROCEDURES', '2003-09-25 18:57:23', 'AJM', '2005-01-15 23:55:31', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (3, 6, 6, 'KEY & PASS CONTROL', '2003-09-25 18:57:50', 'AJM', '2005-01-15 23:55:31', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (2, 1, 1, 'HEAT & VENTILATION', '2003-09-25 19:04:04', 'AJM', NULL, NULL);
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (2, 2, 2, 'LIGHTING', '2003-09-25 19:04:32', 'AJM', NULL, NULL);
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (2, 3, 3, 'CLEANLINESS & WASTE MATERIALS', '2003-09-25 19:04:58', 'AJM', NULL, NULL);
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (2, 4, 4, 'ROOM DIMENSIONS, SPACE & WORKSTATIONS', '2003-09-25 19:05:26', 'AJM', NULL, NULL);
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (2, 5, 5, 'MAINTENANCE', '2003-09-25 19:05:45', 'AJM', NULL, NULL);
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (2, 6, 6, 'FLOORS & TRAFFIC ROUTES', '2003-09-25 19:06:08', 'AJM', NULL, NULL);
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (2, 7, 7, 'FALLS', '2003-09-25 19:06:26', 'AJM', NULL, NULL);
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (2, 8, 8, 'FALLING OBJECTS', '2003-09-25 19:06:44', 'AJM', NULL, NULL);
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (2, 9, 9, 'TRANSPARENT/TRANSLUCENT DOORS, GATES OR WALLS & WINDOWS', '2003-09-25 19:07:47', 'AJM', NULL, NULL);
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (2, 10, 10, 'OPENABLE WINDOWS & THEIR SAFE CLEANING', '2003-09-25 19:09:33', 'AJM', NULL, NULL);
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (2, 11, 11, 'DOORS AND GATES', '2003-09-25 19:09:55', 'AJM', NULL, NULL);
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (2, 12, 12, 'ESCALATORS AND MOVING WALKWAYS', '2003-09-25 19:11:55', 'AJM', NULL, NULL);
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (2, 13, 13, 'WELFARE', '2003-09-25 19:12:15', 'AJM', NULL, NULL);
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 1, 1, 'SITE DETAILS', '2003-09-25 19:13:35', 'AJM', '2003-10-17 20:46:26', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 2, 2, 'RISK ASSESSMENTS - LEGISLATIVE COMPLIANCE', '2003-09-25 19:14:14', 'AJM', '2003-10-17 20:46:26', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 3, 3, 'FIRE CERTIFICATE (Fire Precautions Act 1971)', '2003-09-25 19:14:46', 'AJM', '2003-09-27 19:10:03', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 4, 4, 'FIRE SAFETY RECORD BOOK', '2003-09-25 19:15:09', 'AJM', '2003-09-27 19:10:04', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 5, 5, 'STAFF TRAINING', '2003-09-25 19:15:33', 'AJM', '2003-09-27 19:10:05', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 6, 6, 'SPRINKLER INSTALLATION', '2003-09-25 19:15:57', 'AJM', '2003-09-27 19:10:05', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 7, 7, 'PLANT & MACHINERY', '2003-09-25 19:16:47', 'AJM', '2003-09-27 19:10:06', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 8, 8, 'LIAISON WITH THE FIRE SERVICE', '2003-09-25 19:17:12', 'AJM', '2003-09-27 19:10:07', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 9, 9, 'FIRE EVACUATION', '2003-09-25 19:18:18', 'AJM', '2003-10-05 11:50:58', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 10, 10, 'ESCAPE ROUTES', '2003-09-25 19:18:39', 'AJM', '2003-10-05 11:50:58', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 11, 11, 'FIRE PREVENTION', '2003-09-25 19:19:01', 'AJM', '2003-09-27 19:10:09', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 12, 12, 'FIRE RESISTING DOORS', '2003-09-25 19:19:29', 'AJM', '2003-09-27 19:10:09', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 13, 13, 'FIRE NOTICES', '2003-09-25 19:20:25', 'AJM', '2003-09-27 19:10:10', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 14, 14, 'FIRE FIGHTING EQUIPMENT', '2003-09-25 19:20:46', 'AJM', '2005-01-15 23:50:26', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 15, 15, 'EMERGENCY LIGHTING', '2003-09-25 19:21:11', 'AJM', '2005-01-15 23:50:26', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 16, 16, 'FIRE ALARM SYSTEM', '2003-09-25 19:21:57', 'AJM', '2003-10-26 09:47:35', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 17, 17, 'BUILDING WORKS', '2003-09-25 19:22:18', 'AJM', '2003-10-26 09:47:37', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 18, 18, 'PERMITS TO WORK', '2003-09-25 19:22:37', 'AJM', '2003-10-26 09:47:39', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 19, 19, 'HEATING APPLIANCES', '2003-09-25 19:23:05', 'AJM', '2003-10-26 09:47:40', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 20, 20, 'ELECTRICAL APPLIANCES', '2003-09-25 19:23:26', 'AJM', '2003-10-26 09:47:42', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 21, 21, 'FLAMMABLE SUBSTANCES & MATERIALS', '2003-09-25 19:23:56', 'AJM', '2003-10-26 09:47:43', 'AJM');
INSERT INTO survey_section (survey_id, section_id, section_seq, section_name, created_date, created_user, revised_date, revised_user) VALUES (1, 22, 22, 'GENERAL INFORMATION', '2003-09-25 19:24:11', 'AJM', '2003-10-26 09:47:43', 'AJM');


--
-- TOC entry 1821 (class 0 OID 23862)
-- Dependencies: 1362
-- Data for Name: survey_type; Type: TABLE DATA; Schema: survey; Owner: postgres
--

INSERT INTO survey_type (survey_type_id, survey_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('EMER', 'Emergency & Disaster', '2003-09-24 17:00:54', 'AJM', NULL, NULL);
INSERT INTO survey_type (survey_type_id, survey_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('IT', 'Information Technology', '2003-09-24 17:00:54', 'AJM', NULL, NULL);
INSERT INTO survey_type (survey_type_id, survey_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('ENV', 'Environment', '2003-09-24 17:00:54', 'AJM', NULL, NULL);
INSERT INTO survey_type (survey_type_id, survey_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('SEC', 'Security', '2003-09-24 17:00:54', 'AJM', NULL, NULL);
INSERT INTO survey_type (survey_type_id, survey_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('SAFE', 'Health & Safety', '2003-09-24 17:00:54', 'AJM', NULL, NULL);
INSERT INTO survey_type (survey_type_id, survey_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('MAIN', 'Maintenance', '2003-09-24 17:00:54', 'AJM', NULL, NULL);
INSERT INTO survey_type (survey_type_id, survey_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('FIRE', 'Fire', '2003-09-24 17:00:54', 'AJM', NULL, NULL);
INSERT INTO survey_type (survey_type_id, survey_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('CARP', 'Parking', '2003-09-24 17:00:54', 'AJM', NULL, NULL);
INSERT INTO survey_type (survey_type_id, survey_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('STAF', 'Staff', '2003-09-24 17:00:54', 'AJM', NULL, NULL);
INSERT INTO survey_type (survey_type_id, survey_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('BUIL', 'Building', '2003-09-24 17:00:54', 'AJM', NULL, NULL);


--
-- TOC entry 1822 (class 0 OID 23870)
-- Dependencies: 1363
-- Data for Name: tree_node; Type: TABLE DATA; Schema: survey; Owner: postgres
--

INSERT INTO tree_node (node_id, node_desc, node_type, node_depth, node_id_snr, org_type_id, location_type_id, asset_type_id, created_date, created_user, revised_date, revised_user) VALUES (1, 'Organisation #1', 'O', 1, NULL, 1, NULL, NULL, '2003-10-25 13:46:13', 'AJM', NULL, NULL);
INSERT INTO tree_node (node_id, node_desc, node_type, node_depth, node_id_snr, org_type_id, location_type_id, asset_type_id, created_date, created_user, revised_date, revised_user) VALUES (2, 'Organisation #2', 'O', 1, NULL, 2, NULL, NULL, '2003-10-25 13:53:27', 'AJM', NULL, NULL);
INSERT INTO tree_node (node_id, node_desc, node_type, node_depth, node_id_snr, org_type_id, location_type_id, asset_type_id, created_date, created_user, revised_date, revised_user) VALUES (3, 'Location #3', 'L', 2, 1, NULL, 1, NULL, '2003-10-25 14:49:34', 'AJM', '2003-10-27 14:47:59', 'AJM');
INSERT INTO tree_node (node_id, node_desc, node_type, node_depth, node_id_snr, org_type_id, location_type_id, asset_type_id, created_date, created_user, revised_date, revised_user) VALUES (7, 'asset # 7 (car)', 'A', 2, 1, NULL, NULL, 3, '2003-12-05 20:25:34', 'AJM', NULL, NULL);
INSERT INTO tree_node (node_id, node_desc, node_type, node_depth, node_id_snr, org_type_id, location_type_id, asset_type_id, created_date, created_user, revised_date, revised_user) VALUES (8, 'Asset #8 (van)', 'A', 2, 1, NULL, NULL, 4, '2003-12-06 19:27:21', 'AJM', NULL, NULL);
INSERT INTO tree_node (node_id, node_desc, node_type, node_depth, node_id_snr, org_type_id, location_type_id, asset_type_id, created_date, created_user, revised_date, revised_user) VALUES (9, 'Location #4 (warehouse)', 'L', 3, 4, NULL, 2, NULL, '2003-12-07 11:45:26', 'AJM', NULL, NULL);
INSERT INTO tree_node (node_id, node_desc, node_type, node_depth, node_id_snr, org_type_id, location_type_id, asset_type_id, created_date, created_user, revised_date, revised_user) VALUES (4, 'Location #4', 'L', 2, 2, NULL, 4, NULL, '2003-10-27 14:49:11', 'AJM', NULL, NULL);
INSERT INTO tree_node (node_id, node_desc, node_type, node_depth, node_id_snr, org_type_id, location_type_id, asset_type_id, created_date, created_user, revised_date, revised_user) VALUES (5, 'Asset #5 (computer)', 'A', 3, 3, NULL, NULL, 1, '2003-10-27 14:49:33', 'AJM', '2003-12-05 20:24:37', 'AJM');
INSERT INTO tree_node (node_id, node_desc, node_type, node_depth, node_id_snr, org_type_id, location_type_id, asset_type_id, created_date, created_user, revised_date, revised_user) VALUES (6, 'Asset #6 (safe)', 'A', 3, 4, NULL, NULL, 2, '2003-10-27 14:49:51', 'AJM', '2003-12-05 20:24:54', 'AJM');
INSERT INTO tree_node (node_id, node_desc, node_type, node_depth, node_id_snr, org_type_id, location_type_id, asset_type_id, created_date, created_user, revised_date, revised_user) VALUES (10, 'test location2', 'L', 2, 2, NULL, 4, NULL, '2004-12-12 21:40:59', 'AJM', '2005-07-23 16:08:33', 'AJM');


--
-- TOC entry 1773 (class 16386 OID 23726)
-- Dependencies: 1347 1347 1347 1347 1347
-- Name: answer_option_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY answer_option
    ADD CONSTRAINT answer_option_pkey PRIMARY KEY (survey_id, section_id, question_id, answer_id);


ALTER INDEX survey.answer_option_pkey OWNER TO postgres;

--
-- TOC entry 1775 (class 16386 OID 23734)
-- Dependencies: 1348 1348
-- Name: asset_type_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY asset_type
    ADD CONSTRAINT asset_type_pkey PRIMARY KEY (asset_type_id);


ALTER INDEX survey.asset_type_pkey OWNER TO postgres;

--
-- TOC entry 1777 (class 16386 OID 23743)
-- Dependencies: 1349 1349 1349
-- Name: default_prompt_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY default_prompt
    ADD CONSTRAINT default_prompt_pkey PRIMARY KEY (survey_id, prompt_id);


ALTER INDEX survey.default_prompt_pkey OWNER TO postgres;

--
-- TOC entry 1779 (class 16386 OID 23750)
-- Dependencies: 1350 1350
-- Name: location_address_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY location_address
    ADD CONSTRAINT location_address_pkey PRIMARY KEY (node_id);


ALTER INDEX survey.location_address_pkey OWNER TO postgres;

--
-- TOC entry 1781 (class 16386 OID 23758)
-- Dependencies: 1351 1351
-- Name: location_type_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY location_type
    ADD CONSTRAINT location_type_pkey PRIMARY KEY (location_type_id);


ALTER INDEX survey.location_type_pkey OWNER TO postgres;

--
-- TOC entry 1783 (class 16386 OID 23769)
-- Dependencies: 1352 1352 1352 1352
-- Name: number_option_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY number_option
    ADD CONSTRAINT number_option_pkey PRIMARY KEY (survey_id, section_id, question_id);


ALTER INDEX survey.number_option_pkey OWNER TO postgres;

--
-- TOC entry 1785 (class 16386 OID 23777)
-- Dependencies: 1353 1353
-- Name: org_type_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY org_type
    ADD CONSTRAINT org_type_pkey PRIMARY KEY (org_type_id);


ALTER INDEX survey.org_type_pkey OWNER TO postgres;

--
-- TOC entry 1787 (class 16386 OID 23787)
-- Dependencies: 1354 1354 1354 1354 1354
-- Name: question_prompt_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY question_prompt
    ADD CONSTRAINT question_prompt_pkey PRIMARY KEY (survey_id, section_id, question_id, prompt_id);


ALTER INDEX survey.question_prompt_pkey OWNER TO postgres;

--
-- TOC entry 1789 (class 16386 OID 23795)
-- Dependencies: 1355 1355
-- Name: risk_status_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY risk_status
    ADD CONSTRAINT risk_status_pkey PRIMARY KEY (risk_status_id);


ALTER INDEX survey.risk_status_pkey OWNER TO postgres;

--
-- TOC entry 1791 (class 16386 OID 23803)
-- Dependencies: 1356 1356
-- Name: risk_weighting_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY risk_weighting
    ADD CONSTRAINT risk_weighting_pkey PRIMARY KEY (weighting_id);


ALTER INDEX survey.risk_weighting_pkey OWNER TO postgres;

--
-- TOC entry 1793 (class 16386 OID 23815)
-- Dependencies: 1357 1357 1357 1357 1357
-- Name: survey_answer_dtl_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY survey_answer_dtl
    ADD CONSTRAINT survey_answer_dtl_pkey PRIMARY KEY (survey_answer_id, survey_id, section_id, question_id);


ALTER INDEX survey.survey_answer_dtl_pkey OWNER TO postgres;

--
-- TOC entry 1795 (class 16386 OID 23825)
-- Dependencies: 1358 1358
-- Name: survey_answer_hdr_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY survey_answer_hdr
    ADD CONSTRAINT survey_answer_hdr_pkey PRIMARY KEY (survey_answer_id);


ALTER INDEX survey.survey_answer_hdr_pkey OWNER TO postgres;

--
-- TOC entry 1797 (class 16386 OID 23835)
-- Dependencies: 1359 1359
-- Name: survey_hdr_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY survey_hdr
    ADD CONSTRAINT survey_hdr_pkey PRIMARY KEY (survey_id);


ALTER INDEX survey.survey_hdr_pkey OWNER TO postgres;

--
-- TOC entry 1799 (class 16386 OID 23851)
-- Dependencies: 1360 1360 1360 1360
-- Name: survey_question_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY survey_question
    ADD CONSTRAINT survey_question_pkey PRIMARY KEY (survey_id, section_id, question_id);


ALTER INDEX survey.survey_question_pkey OWNER TO postgres;

--
-- TOC entry 1801 (class 16386 OID 23861)
-- Dependencies: 1361 1361 1361
-- Name: survey_section_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY survey_section
    ADD CONSTRAINT survey_section_pkey PRIMARY KEY (survey_id, section_id);


ALTER INDEX survey.survey_section_pkey OWNER TO postgres;

--
-- TOC entry 1803 (class 16386 OID 23869)
-- Dependencies: 1362 1362
-- Name: survey_type_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY survey_type
    ADD CONSTRAINT survey_type_pkey PRIMARY KEY (survey_type_id);


ALTER INDEX survey.survey_type_pkey OWNER TO postgres;

--
-- TOC entry 1805 (class 16386 OID 23879)
-- Dependencies: 1363 1363
-- Name: tree_node_pkey; Type: CONSTRAINT; Schema: survey; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tree_node
    ADD CONSTRAINT tree_node_pkey PRIMARY KEY (node_id);


ALTER INDEX survey.tree_node_pkey OWNER TO postgres;

-- Completed on 2005-09-14 18:51:43 GMT Standard Time

--
-- PostgreSQL database dump complete
--
