--
-- PostgreSQL database dump
--

-- Started on 2006-01-07 18:23:56 GMT Standard Time

SET client_encoding = 'UTF8';
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 13 (class 2615 OID 17385)
-- Name: xample; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA xample;


ALTER SCHEMA xample OWNER TO postgres;

SET search_path = xample, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = true;

--
-- TOC entry 1371 (class 1259 OID 17388)
-- Dependencies: 13
-- Name: test_autoincrement; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE test_autoincrement (
    id serial NOT NULL,
    field1 character varying(40),
    field2 character varying(255),
    field3 bigint
);


ALTER TABLE xample.test_autoincrement OWNER TO postgres;

--
-- TOC entry 1783 (class 0 OID 0)
-- Dependencies: 1370
-- Name: test_autoincrement_id_seq; Type: SEQUENCE SET; Schema: xample; Owner: postgres
--

SELECT pg_catalog.setval(pg_catalog.pg_get_serial_sequence('test_autoincrement', 'id'), 1, false);


SET default_with_oids = false;

--
-- TOC entry 1372 (class 1259 OID 17391)
-- Dependencies: 1707 1708 1709 1710 13
-- Name: x_option; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_option (
    option_id character varying(8) DEFAULT ''::character varying NOT NULL,
    option_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_option OWNER TO postgres;

--
-- TOC entry 1373 (class 1259 OID 17397)
-- Dependencies: 1711 1712 1713 1714 13
-- Name: x_pers_opt_xref; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_pers_opt_xref (
    person_id character varying(8) DEFAULT ''::character varying NOT NULL,
    option_id character varying(8) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_pers_opt_xref OWNER TO postgres;

--
-- TOC entry 1374 (class 1259 OID 17403)
-- Dependencies: 1715 1716 1717 1718 13
-- Name: x_pers_type; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_pers_type (
    pers_type_id character varying(6) DEFAULT ''::character varying NOT NULL,
    pers_type_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_pers_type OWNER TO postgres;

--
-- TOC entry 1375 (class 1259 OID 17409)
-- Dependencies: 1719 1720 1721 1722 1723 1724 13
-- Name: x_person; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_person (
    person_id character varying(8) DEFAULT ''::character varying NOT NULL,
    pers_type_id character varying(6),
    node_id smallint,
    nat_ins_no character varying(10) NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(30) NOT NULL,
    initials character varying(6),
    star_sign character(3) NOT NULL,
    email_addr character varying(50),
    value1 smallint,
    value2 numeric(10,2),
    last_addr_no smallint DEFAULT (0)::smallint,
    start_date date DEFAULT '2000-01-01'::date NOT NULL,
    end_date date DEFAULT '9999-12-31'::date,
    picture character varying(40),
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_person OWNER TO postgres;

--
-- TOC entry 1376 (class 1259 OID 17417)
-- Dependencies: 1725 1726 1727 1728 1729 1730 1731 13
-- Name: x_person_addr; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_person_addr (
    person_id character varying(8) DEFAULT ''::character varying NOT NULL,
    address_no smallint DEFAULT (0)::smallint NOT NULL,
    telephone_no character varying(20),
    fax_no character varying(20),
    addr_line_1 character varying(30) DEFAULT ''::character varying NOT NULL,
    addr_line_2 character varying(30),
    addr_line_3 character varying(30),
    town character varying(30),
    county character varying(30),
    postcode character varying(10),
    start_date date DEFAULT '2000-01-01'::date NOT NULL,
    end_date date DEFAULT '9999-12-31'::date,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_person_addr OWNER TO postgres;

--
-- TOC entry 1377 (class 1259 OID 17426)
-- Dependencies: 1732 1733 1734 1735 1736 1737 13
-- Name: x_tree_level; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_tree_level (
    tree_type_id character varying(8) DEFAULT ''::character varying NOT NULL,
    tree_level_id smallint DEFAULT (0)::smallint NOT NULL,
    tree_level_seq smallint DEFAULT (0)::smallint NOT NULL,
    tree_level_desc character varying(80) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_tree_level OWNER TO postgres;

--
-- TOC entry 1378 (class 1259 OID 17434)
-- Dependencies: 1738 1739 1740 1741 1742 1743 13
-- Name: x_tree_node; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_tree_node (
    node_id smallint DEFAULT (0)::smallint NOT NULL,
    tree_type_id character varying(8) DEFAULT ''::character varying NOT NULL,
    tree_level_id smallint DEFAULT (0)::smallint NOT NULL,
    node_desc character varying(80) DEFAULT ''::character varying NOT NULL,
    node_id_snr smallint,
    external_code character varying(255),
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_tree_node OWNER TO postgres;

--
-- TOC entry 1379 (class 1259 OID 17442)
-- Dependencies: 1744 1745 1746 1747 13
-- Name: x_tree_type; Type: TABLE; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE TABLE x_tree_type (
    tree_type_id character varying(8) DEFAULT ''::character varying NOT NULL,
    tree_type_desc character varying(80) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2003-01-01 12:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT 'UNKNOWN'::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE xample.x_tree_type OWNER TO postgres;

--
-- TOC entry 1772 (class 0 OID 17388)
-- Dependencies: 1371
-- Data for Name: test_autoincrement; Type: TABLE DATA; Schema: xample; Owner: postgres
--



--
-- TOC entry 1773 (class 0 OID 17391)
-- Dependencies: 1372
-- Data for Name: x_option; Type: TABLE DATA; Schema: xample; Owner: postgres
--

INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('ALBATROS', 'Albatross', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('ANACONDA', 'Anaconda', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('BARACUDA', 'Baracuda', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('BUMBLE', 'Bumble Bee', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('CHINCHIL', 'Chinchilla', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('CROCODIL', 'Crocodile', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('DINOSAUR', 'Dinosaur', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('DUCKBILL', 'Duck-Billed Platypus', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('EMU', 'Emu', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('FERRET', 'Ferret', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('FOX', 'Fox', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('GERBIL', 'Gerbil', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('GORILLA', 'Gorilla', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('HADDOCK', 'Haddock', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('HAMSTER', 'Hamster', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('IBEX', 'Ibex', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('IBIS', 'Ibis', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('JABBER', 'Jabberwocky', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('JACKAL', 'Jackal', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('KANGEROO', 'Kangeroo', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('KESTREL', 'Kestrel', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('LEMMING', 'Lemming', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('LION', 'Lion', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('MACAW', 'Macaw', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('MOUSE', 'Mouse', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('NASTURTI', 'Nasturtium', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('NATTERJA', 'Natterjack', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('OAK', 'Oak', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('OCELOT', 'Ocelot', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('PARROT', 'Parrot', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('PARSLEY', 'Parsley', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('QUAIL', 'Quail', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('QUINCE', 'Quince', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('RABBIT', 'Rabbit', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('RACOON', 'Racoon', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('SALAMAND', 'Salamander', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('SHEEP', 'Sheep', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('TARANTUL', 'Tarantula', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('TURKEY', 'Turkey', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('UKELELE', 'Ukelele', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('URCHIN', 'Urchin', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('VIXEN', 'Vixen', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('VOLE', 'Vole', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('WATERBUF', 'Waterbuffalo', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('WILDEBEE', 'Wildebeest', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('XENOPHIL', 'Xenophile', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('XENOPHOB', 'Xenophobe', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('YAK', 'Yak', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('YETI', 'Yeti', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('ZEBRA', 'Zebra', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('ZOMBIE', 'Zombie', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('CôTE', 'Côte d''Ivoire', '2005-02-03 18:40:45', 'AJM', NULL, NULL);
INSERT INTO x_option (option_id, option_desc, created_date, created_user, revised_date, revised_user) VALUES ('ELEPHANT', 'Eléphânt', '2000-01-01 00:00:00', 'AJM', '2005-06-27 12:39:06', 'AJM');


--
-- TOC entry 1774 (class 0 OID 17397)
-- Dependencies: 1373
-- Data for Name: x_pers_opt_xref; Type: TABLE DATA; Schema: xample; Owner: postgres
--

INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'BARACUDA', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'CHINCHIL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'DINOSAUR', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'FERRET', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'GERBIL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'HADDOCK', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'IBEX', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'JABBER', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'KANGEROO', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'LEMMING', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'MACAW', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'NASTURTI', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'OAK', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'PARROT', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'QUAIL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'RABBIT', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'SALAMAND', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'TARANTUL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'UKELELE', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'VIXEN', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'WATERBUF', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'XENOPHIL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'YAK', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'ZEBRA', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('BB', 'ANACONDA', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('BB', 'BUMBLE', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('BB', 'CROCODIL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('BB', 'DUCKBILL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('BB', 'EMU', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('BG', 'ANACONDA', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('BG', 'BUMBLE', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('BG', 'CROCODIL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('BG', 'DUCKBILL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('BG', 'EMU', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('CC', 'ALBATROS', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('CC', 'BARACUDA', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('CC', 'CHINCHIL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('CC', 'DINOSAUR', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('CJ', 'ALBATROS', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('DD', 'ALBATROS', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('DD', 'BARACUDA', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('DD', 'CHINCHIL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('DD', 'DINOSAUR', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('EE', 'ANACONDA', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('EE', 'BUMBLE', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('EE', 'CROCODIL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('EE', 'DUCKBILL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('EE', 'EMU', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('FB', 'ALBATROS', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('FB', 'BARACUDA', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('FB', 'CHINCHIL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('FB', 'DINOSAUR', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('FB', 'ZOMBIE', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'ANACONDA', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'BUMBLE', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'CROCODIL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'DUCKBILL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'EMU', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'FOX', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'GORILLA', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'HAMSTER', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'IBIS', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'JACKAL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'KESTREL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'LION', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'MOUSE', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'NATTERJA', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'OCELOT', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'PARSLEY', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'RACOON', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'TURKEY', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'URCHIN', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'VOLE', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'WILDEBEE', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'XENOPHOB', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'YETI', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'ZOMBIE', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('LH', 'ALBATROS', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('LH', 'ZOMBIE', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('LL', 'ALBATROS', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PV', 'ALBATROS', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('MM', 'ALBATROS', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'ALBATROS', '2005-04-06 19:17:20', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'BARACUDA', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'CHINCHIL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'DINOSAUR', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'FERRET', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'GERBIL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'HADDOCK', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'IBEX', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'JABBER', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'KANGEROO', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'LEMMING', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'MACAW', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'NASTURTI', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'OAK', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'PARROT', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'QUAIL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'RABBIT', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'SALAMAND', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'TARANTUL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'UKELELE', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'VIXEN', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'WATERBUF', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'XENOPHIL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'YAK', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('Z', 'ALBATROS', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PQ', 'ALBATROS', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('RO', 'ALBATROS', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('RR', 'ALBATROS', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('RR', 'ZOMBIE', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('WW', 'ALBATROS', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('SF', 'ALBATROS', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('SF', 'BARACUDA', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('SF', 'CHINCHIL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('SF', 'DINOSAUR', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('SF', 'ZOMBIE', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('SS', 'ZOMBIE', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('WC', 'ANACONDA', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('WC', 'BUMBLE', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('WC', 'CROCODIL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('WC', 'DUCKBILL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('WC', 'EMU', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('TT', 'ALBATROS', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'ZEBRA', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('YY', 'ALBATROS', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('CJ', 'ANACONDA', '2004-08-16 14:56:55', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'ANACONDA', '2004-08-16 14:59:47', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('BG', 'ALBATROS', '2005-01-12 21:52:36', 'AJM', NULL, NULL);
INSERT INTO x_pers_opt_xref (person_id, option_id, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'ALBATROS', '2005-04-07 11:12:13', 'AJM', NULL, NULL);


--
-- TOC entry 1775 (class 0 OID 17403)
-- Dependencies: 1374
-- Data for Name: x_pers_type; Type: TABLE DATA; Schema: xample; Owner: postgres
--

INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('ACTOR', 'Actor/Artiste', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('BORING', 'Boring Person', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('CARTOO', 'Cartoon Character', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('DOLLY', 'Dolly Bird', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('EXEC', 'Executive', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('FUNNY', 'Funny Person/Comedian', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('GENFAC', 'General Factotum', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('IGTWIT', 'Ignorant Twit', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('JAMMY', 'Jammy Beggar', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('KLEPTO', 'Kleptomaniac', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('LAZY', 'Lazy Bones', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('MAD', 'Mad as a Hatter', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('NINNY', 'Nincompoop', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('ONE', 'One Sandwich Short of a Picnic', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('LAME', 'Lame Brain', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('HISTOR', 'Historical Figure', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('QP', 'Of Questionable Parentage', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('ANON', 'Anne Oni Mouse', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('FILM', 'Film Star', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('LAYABO', 'Layabout', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('MOANER', 'Moaning Minnie', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('PP', 'Party Pooper', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('FAMOUS', 'Famous Person', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_pers_type (pers_type_id, pers_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('OBNOXI', 'Obnoxious Oik', '2003-01-01 12:00:00', 'AJM', NULL, NULL);


--
-- TOC entry 1776 (class 0 OID 17409)
-- Dependencies: 1375
-- Data for Name: x_person; Type: TABLE DATA; Schema: xample; Owner: postgres
--

INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 'GENFAC', 10, 'XX123456Y', 'Tony', 'Marston', '', 'CAP', 'tony@marston-home.demon.co.uk', 34, 12.34, 3, '1951-01-02', '2005-01-02', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('BB', 'CARTOO', 8, 'BB', 'Billy', 'Bunter', NULL, 'CAN', 'bb@fatman.com', NULL, NULL, 1, '2002-12-01', '9999-12-31', 'pictures/clown.jpg', '2003-01-01 12:00:00', 'AJM', '2005-04-06 18:33:44', 'AJM');
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('BG', 'EXEC', 21, 'BG', 'Bill', 'Gates', 'wg', 'CAN', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('CC', 'CARTOO', 9, 'CC', 'Charlie', 'Chan', NULL, 'CAN', NULL, NULL, NULL, 0, '1953-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('CJ', 'FUNNY', 7, 'CJ', 'Casper', 'Jarret', 'cj', 'GEM', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('DD', 'CARTOO', 16, 'DD', 'Donald', 'Duck', NULL, 'SAG', NULL, NULL, NULL, 0, '1998-02-02', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('EE', 'FUNNY', 17, 'EE', 'Edna', 'Everage', 'ee', 'ARI', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('FB', 'ANON', 7, 'FB', 'Fred', 'Bloggs', NULL, 'VIR', 'fred.bloggs@nowhere.com', NULL, NULL, 3, '2002-01-01', '9999-12-31', 'pictures/clown.jpg', '2003-01-01 12:00:00', 'AJM', '2005-04-06 17:57:53', 'AJM');
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('JI', 'FILM', 6, 'JI', 'Jeremy', 'Irons', 'ji', 'SAG', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('KB', 'DOLLY', 6, 'KB', 'Kim', 'Basinger', 'KB', 'SAG', 'kim.bassinger@hollywood.net', NULL, NULL, 1, '1990-01-01', '9999-12-31', 'pictures/female2.jpg', '2003-01-01 12:00:00', 'AJM', '2005-04-06 17:57:36', 'AJM');
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('KK', 'FILM', 8, 'KK', 'Kevin', 'Kline', 'kk', 'LEO', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('LH', 'DOLLY', 5, 'LH', 'Liz', 'Hurley', 'lh', 'VIR', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', 'pictures/female2.jpg', '2003-01-01 12:00:00', 'AJM', '2005-03-10 21:56:30', 'AJM');
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('LL', 'FAMOUS', 9, 'LL', 'Lord', 'Lucan', 'll', 'GEM', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('LU', 'ACTOR', 10, 'LU', 'Liv', 'Ullman', 'lu', 'ARI', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('MM', 'CARTOO', 16, 'MM', 'Mickey', 'Mouse', NULL, 'LEO', NULL, NULL, NULL, 0, '2001-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('MP', 'DOLLY', 21, 'MP', 'Michelle', 'Pfeiffer', 'mp', 'CAP', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', 'pictures/female2.jpg', '2003-01-01 12:00:00', 'AJM', '2005-03-10 21:56:37', 'AJM');
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('MR', 'FILM', 6, 'MR', 'Mickey', 'Rooney', NULL, 'SCO', NULL, NULL, NULL, 1, '1940-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('NN', 'FILM', 17, 'NN', 'Nick', 'Nolte', 'nn', 'TAU', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('PA', 'DOLLY', 5, 'PA', 'Pamela', 'Anderson', 'PA', 'VIR', 'pam@hollywood.com', NULL, NULL, 2, '1980-07-01', '9999-12-31', 'pictures/female2.jpg', '2003-01-01 12:00:00', 'AJM', '2005-04-06 17:57:31', 'AJM');
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('PQ', 'ACTOR', 5, 'PQ', 'Pauline', 'Quirke', 'pq', 'ARI', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('PV', 'HISTOR', 16, 'PV', 'Pancho', 'Villa', 'pv', 'LIB', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('RO', 'FAMOUS', 18, 'RO', 'Roy', 'Orbison', 'ro', 'SAG', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('RR', 'CARTOO', 7, 'RR', 'Road', 'Runner', NULL, 'VIR', 'roadrunner@cartoonland.com', NULL, NULL, 0, '1950-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('RW', 'DOLLY', 17, 'RW', 'Raquel', 'Welch', 'rw', 'VIR', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', 'pictures/female2.jpg', '2003-01-01 12:00:00', 'AJM', '2005-03-10 21:56:50', 'AJM');
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('SF', 'DOLLY', 18, 'SF', 'Sam', 'Fox', 'sf', 'VIR', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', 'pictures/female2.jpg', '2003-01-01 12:00:00', 'AJM', '2005-03-10 21:56:23', 'AJM');
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('SS', 'DOLLY', 8, 'SS', 'Sharon', 'Stone', 'ss', 'VIR', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', 'pictures/female2.jpg', '2003-01-01 12:00:00', 'AJM', '2005-03-10 21:56:44', 'AJM');
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('TT', 'FUNNY', 9, 'TT', 'Terry', 'Thomas', 'tt', 'AQU', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('WC', 'CARTOO', 10, 'WC', 'Wiley', 'Coyote', NULL, 'SAG', 'wileycoyote@cartoonland.com', NULL, NULL, 1, '1950-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('WW', 'BORING', 18, 'WW', 'Willy', 'Wonka', '', 'GEM', 'willy@chocolatefactory.com', NULL, NULL, 1, '1999-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('XX', 'ANON', 21, 'XX', 'Xavier', 'Xtra', 'xx', 'LIB', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('YY', 'HISTOR', 5, 'YY', 'Yin', 'Yang', 'yy', 'SCO', NULL, NULL, NULL, 0, '1990-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('Z', 'CARTOO', 6, 'Z', 'Mr', 'Zebedee', 'z', 'CAN', NULL, NULL, NULL, 1, '1990-01-01', '9999-12-31', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person (person_id, pers_type_id, node_id, nat_ins_no, first_name, last_name, initials, star_sign, email_addr, value1, value2, last_addr_no, start_date, end_date, picture, created_date, created_user, revised_date, revised_user) VALUES ('TEST', 'ACTOR', 25, 'TEST', 'test', 'test', NULL, 'TAU', NULL, NULL, NULL, 1, '2005-11-01', '9999-12-31', NULL, '2005-10-12 17:44:29', 'AJM', '2005-10-12 17:45:05', 'AJM');


--
-- TOC entry 1777 (class 0 OID 17417)
-- Dependencies: 1376
-- Data for Name: x_person_addr; Type: TABLE DATA; Schema: xample; Owner: postgres
--

INSERT INTO x_person_addr (person_id, address_no, telephone_no, fax_no, addr_line_1, addr_line_2, addr_line_3, town, county, postcode, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 1, '020 8642 3524', NULL, '32 Strathearn Road', NULL, NULL, 'SUTTON', 'Surrey', 'SM1 2RS', '1951-01-02', '1978-06-30', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person_addr (person_id, address_no, telephone_no, fax_no, addr_line_1, addr_line_2, addr_line_3, town, county, postcode, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 2, NULL, NULL, 'new 1', 'new 2', NULL, 'NEWTOWN', 'newshire', 'NN1 1NN', '1978-07-01', '2003-12-31', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person_addr (person_id, address_no, telephone_no, fax_no, addr_line_1, addr_line_2, addr_line_3, town, county, postcode, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('AJM', 3, NULL, NULL, 'new3', NULL, NULL, 'NEW3', NULL, 'NN3 3NN', '2004-01-01', '2005-01-02', '2004-08-29 20:16:39', 'AJM', NULL, NULL);
INSERT INTO x_person_addr (person_id, address_no, telephone_no, fax_no, addr_line_1, addr_line_2, addr_line_3, town, county, postcode, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('BB', 1, NULL, NULL, 'Fat Lane', NULL, NULL, 'FATTYVILLE', NULL, 'BB1 1BB', '2002-12-01', '9999-12-31', '2005-04-06 18:33:44', 'AJM', NULL, NULL);
INSERT INTO x_person_addr (person_id, address_no, telephone_no, fax_no, addr_line_1, addr_line_2, addr_line_3, town, county, postcode, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('FB', 1, NULL, NULL, 'Battersea Dogs Home', NULL, NULL, 'BATTERSEA', 'London', 'SW9 9AZ', '2002-01-01', '2003-05-31', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person_addr (person_id, address_no, telephone_no, fax_no, addr_line_1, addr_line_2, addr_line_3, town, county, postcode, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('FB', 2, NULL, NULL, 'Chelsea Pensioners', NULL, NULL, 'CHELSEA', 'London', 'SW5 5AZ', '2003-06-01', '2003-08-31', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person_addr (person_id, address_no, telephone_no, fax_no, addr_line_1, addr_line_2, addr_line_3, town, county, postcode, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('FB', 3, NULL, NULL, 'Cell 27', 'Wormwood Scrubs', NULL, 'WANDSWORTH', 'London', 'NE1 1NE', '2003-09-01', '9999-12-31', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person_addr (person_id, address_no, telephone_no, fax_no, addr_line_1, addr_line_2, addr_line_3, town, county, postcode, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('KB', 1, NULL, NULL, 'kb1', NULL, NULL, 'KNIGHTSBRIDGE', NULL, 'KB1 1KB', '1990-01-01', '9999-12-31', '2005-03-28 15:27:05', 'AJM', NULL, NULL);
INSERT INTO x_person_addr (person_id, address_no, telephone_no, fax_no, addr_line_1, addr_line_2, addr_line_3, town, county, postcode, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('MR', 1, NULL, NULL, 'mr1', NULL, NULL, 'MR1', 'mr1', 'MR1 1MR', '1940-01-01', '9999-12-31', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person_addr (person_id, address_no, telephone_no, fax_no, addr_line_1, addr_line_2, addr_line_3, town, county, postcode, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PA', 1, NULL, NULL, '2 Titty Terrace', NULL, NULL, 'JUGSVILLE', NULL, 'TT1 1TT', '1980-07-01', '1989-12-31', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person_addr (person_id, address_no, telephone_no, fax_no, addr_line_1, addr_line_2, addr_line_3, town, county, postcode, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PA', 2, NULL, NULL, 'pa2', 'pa2', 'pa2', 'PA2', 'pa2 again', 'PA2 2PA', '1990-01-01', '9999-12-31', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person_addr (person_id, address_no, telephone_no, fax_no, addr_line_1, addr_line_2, addr_line_3, town, county, postcode, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('WC', 1, NULL, NULL, 'test', 'test', NULL, 'TEST', NULL, 'SM1 2RS', '1999-09-09', '9999-12-31', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person_addr (person_id, address_no, telephone_no, fax_no, addr_line_1, addr_line_2, addr_line_3, town, county, postcode, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('WW', 1, NULL, NULL, 'line 1', 'line 2', 'line 3', 'TOWN', 'county', 'WW1 1WW', '1999-01-01', '9999-12-31', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person_addr (person_id, address_no, telephone_no, fax_no, addr_line_1, addr_line_2, addr_line_3, town, county, postcode, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('Z', 1, NULL, NULL, '26 Alphabet Street', NULL, NULL, 'ALPHABETVILLE', 'Dictionaryshire', 'AB1 1XY', '1990-01-01', '9999-12-31', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_person_addr (person_id, address_no, telephone_no, fax_no, addr_line_1, addr_line_2, addr_line_3, town, county, postcode, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('TEST', 1, NULL, NULL, 't1', NULL, NULL, 'T1', NULL, 'TT1 1TT', '2005-11-01', '9999-12-31', '2005-10-12 17:45:04', 'AJM', NULL, NULL);


--
-- TOC entry 1778 (class 0 OID 17426)
-- Dependencies: 1377
-- Data for Name: x_tree_level; Type: TABLE DATA; Schema: xample; Owner: postgres
--

INSERT INTO x_tree_level (tree_type_id, tree_level_id, tree_level_seq, tree_level_desc, created_date, created_user, revised_date, revised_user) VALUES ('TEST', 1, 1, 'Test level 1', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_level (tree_type_id, tree_level_id, tree_level_seq, tree_level_desc, created_date, created_user, revised_date, revised_user) VALUES ('TEST', 2, 2, 'Test level 2', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_level (tree_type_id, tree_level_id, tree_level_seq, tree_level_desc, created_date, created_user, revised_date, revised_user) VALUES ('ORG', 1, 2, 'Company', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_level (tree_type_id, tree_level_id, tree_level_seq, tree_level_desc, created_date, created_user, revised_date, revised_user) VALUES ('ORG', 2, 3, 'Department', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_level (tree_type_id, tree_level_id, tree_level_seq, tree_level_desc, created_date, created_user, revised_date, revised_user) VALUES ('ORG', 3, 4, 'Section', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_level (tree_type_id, tree_level_id, tree_level_seq, tree_level_desc, created_date, created_user, revised_date, revised_user) VALUES ('PROJ', 1, 1, 'Project ID', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_level (tree_type_id, tree_level_id, tree_level_seq, tree_level_desc, created_date, created_user, revised_date, revised_user) VALUES ('PROJ', 2, 2, 'Project Phase', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_level (tree_type_id, tree_level_id, tree_level_seq, tree_level_desc, created_date, created_user, revised_date, revised_user) VALUES ('PROJ', 3, 3, 'Project Component', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_level (tree_type_id, tree_level_id, tree_level_seq, tree_level_desc, created_date, created_user, revised_date, revised_user) VALUES ('ORG', 4, 1, 'Group', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_level (tree_type_id, tree_level_id, tree_level_seq, tree_level_desc, created_date, created_user, revised_date, revised_user) VALUES ('TEST', 3, 3, 'Test level 3', '2003-01-01 12:00:00', 'AJM', NULL, NULL);


--
-- TOC entry 1779 (class 0 OID 17434)
-- Dependencies: 1378
-- Data for Name: x_tree_node; Type: TABLE DATA; Schema: xample; Owner: postgres
--

INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (1, 'ORG', 1, 'AJM Systems Limited', 25, '-01', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (2, 'ORG', 2, 'Department of Problems', 1, '-001', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (3, 'ORG', 2, 'Department of Solutions', 1, '-002', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (4, 'ORG', 2, 'Department of Excuses', 1, '-003', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (6, 'ORG', 3, 'Section 2 (node 6)', 4, '-0002', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (5, 'ORG', 3, 'Section 1 (node 5)', 4, '-0001', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (7, 'ORG', 3, 'Section 3 (node 7)', 4, '-0003', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (8, 'ORG', 3, 'Section 4 (node 8)', 2, '-0004', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (9, 'ORG', 3, 'Section 5 (node 9)', 2, '-0005', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (10, 'ORG', 3, 'Section 6 (node 10)', 2, '-0006', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (11, 'TEST', 2, 'Node 11, test level 2', 12, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (12, 'TEST', 1, 'Node 12, test level 1', NULL, '12-1', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (13, 'TEST', 2, 'Node 13, test level 2', 12, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (14, 'TEST', 2, 'Node 14, test level 2', 12, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (15, 'ORG', 2, 'Department of Silly Noises', 26, '-004', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (16, 'ORG', 3, 'Section 7 (node 16)', 3, '-0007', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (17, 'ORG', 3, 'Section 8 (node 17)', 3, '-0008', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (18, 'ORG', 3, 'Section 9 (node 18)', 3, '-0009', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (19, 'ORG', 2, 'Department of Silly Walks', 26, '-005', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (20, 'ORG', 2, 'Department of Failures', 26, '-006', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (21, 'ORG', 3, 'Section 10 (node 21)', 3, '-0010', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (22, 'ORG', 3, 'Section 11 (node 22)', 15, '-0011', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (23, 'ORG', 3, 'Section 12 (node 23)', 44, '-0012', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (24, 'ORG', 3, 'Section 13 (node 24)', 20, '-0013', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (25, 'ORG', 4, 'The AJM Group', NULL, 'A', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (26, 'ORG', 1, 'AJM Products Limited', 25, '-02', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (27, 'ORG', 3, 'Section 14 (node 27)', 19, '-0014', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (28, 'ORG', 3, 'Section 15 (node 28)', NULL, '-0015', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (29, 'PROJ', 1, 'Project A', NULL, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (30, 'PROJ', 1, 'Project B', NULL, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (31, 'PROJ', 1, 'Project C', NULL, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (32, 'PROJ', 2, 'Phase 1', 29, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (33, 'PROJ', 2, 'Phase 2', 29, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (34, 'PROJ', 2, 'Phase 3', 29, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (35, 'PROJ', 2, 'Phase 1', 30, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (36, 'PROJ', 2, 'Phase 2', 30, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (37, 'PROJ', 2, 'Phase 3', 30, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (38, 'PROJ', 2, 'Phase 1', 31, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (39, 'PROJ', 2, 'Phase 2', 31, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (40, 'PROJ', 2, 'Phase 3', 31, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (41, 'PROJ', 3, 'Component 41', 32, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (42, 'PROJ', 3, 'Component 42', 32, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (43, 'PROJ', 3, 'Component 43', 32, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (44, 'ORG', 2, 'Department 44', 1, '-044', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (45, 'ORG', 3, 'Section 16 (node 45)', NULL, '-0016', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (46, 'TEST', 2, 'Node 46 level 2', NULL, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (47, 'ORG', 1, 'AJM Enterprises Ltd', 25, '47', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (48, 'ORG', 3, 'node 48', NULL, '-0048', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (49, 'ORG', 3, 'node 49', NULL, '-0049', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (50, 'TEST', 3, 'node 50', 11, '', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (51, 'TEST', 3, 'node 51', 11, '-51', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (52, 'ORG', 2, 'yet another node', 47, 'N/A', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (53, 'ORG', 1, 'AJM Business Solutions (BS) Ltd', 25, 'BS', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (54, 'ORG', 2, 'node 54', 53, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (55, 'TEST', 2, 'node 55', NULL, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (56, 'ORG', 3, 'node 56', 20, '-0056', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (57, 'TEST', 3, 'Node 57', 11, '57', '2004-07-23 17:54:20', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (58, 'ORG', 3, 'Node 58', NULL, NULL, '2004-08-16 15:41:34', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (60, 'TEST', 2, 'Node 60', NULL, '-60', '2005-01-16 18:51:32', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (59, 'ORG', 2, 'Node 59', NULL, '-59', '2004-08-26 14:06:02', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (61, 'TEST', 3, 'Node 61', NULL, '-61', '2005-01-16 18:52:15', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (62, 'TEST', 3, 'Node 62', NULL, '-62', '2005-01-16 20:34:59', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (63, 'TEST', 3, 'Node 63', NULL, '-63', '2005-01-20 21:50:02', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (64, 'TEST', 3, 'Node 64', NULL, '-64', '2005-01-20 21:55:30', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (65, 'TEST', 3, 'Node 65', NULL, '-65', '2005-01-21 06:26:12', 'AJM', NULL, NULL);
INSERT INTO x_tree_node (node_id, tree_type_id, tree_level_id, node_desc, node_id_snr, external_code, created_date, created_user, revised_date, revised_user) VALUES (66, 'TEST', 3, 'Node 66', NULL, '-66', '2005-01-21 06:27:51', 'AJM', NULL, NULL);


--
-- TOC entry 1780 (class 0 OID 17442)
-- Dependencies: 1379
-- Data for Name: x_tree_type; Type: TABLE DATA; Schema: xample; Owner: postgres
--

INSERT INTO x_tree_type (tree_type_id, tree_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('ORG', 'Organisation', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_type (tree_type_id, tree_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('PROJ', 'Project', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO x_tree_type (tree_type_id, tree_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('TEST', 'Test', '2003-01-01 12:00:00', 'AJM', NULL, NULL);


--
-- TOC entry 1754 (class 2606 OID 17449)
-- Dependencies: 1373 1373 1373
-- Name: pers_opt_xref_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_pers_opt_xref
    ADD CONSTRAINT pers_opt_xref_pkey PRIMARY KEY (person_id, option_id);


--
-- TOC entry 1756 (class 2606 OID 17451)
-- Dependencies: 1374 1374
-- Name: pers_type_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_pers_type
    ADD CONSTRAINT pers_type_pkey PRIMARY KEY (pers_type_id);


--
-- TOC entry 1763 (class 2606 OID 17453)
-- Dependencies: 1376 1376 1376
-- Name: person_addr_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_person_addr
    ADD CONSTRAINT person_addr_pkey PRIMARY KEY (person_id, address_no);


--
-- TOC entry 1759 (class 2606 OID 17455)
-- Dependencies: 1375 1375
-- Name: person_nat_ins_no_key; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_person
    ADD CONSTRAINT person_nat_ins_no_key UNIQUE (nat_ins_no);


--
-- TOC entry 1761 (class 2606 OID 17457)
-- Dependencies: 1375 1375
-- Name: person_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_person
    ADD CONSTRAINT person_pkey PRIMARY KEY (person_id);


--
-- TOC entry 1749 (class 2606 OID 17459)
-- Dependencies: 1371 1371
-- Name: test_autoincrement_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY test_autoincrement
    ADD CONSTRAINT test_autoincrement_pkey PRIMARY KEY (id);


--
-- TOC entry 1765 (class 2606 OID 17461)
-- Dependencies: 1377 1377 1377
-- Name: tree_level_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_tree_level
    ADD CONSTRAINT tree_level_pkey PRIMARY KEY (tree_type_id, tree_level_id);


--
-- TOC entry 1769 (class 2606 OID 17463)
-- Dependencies: 1378 1378
-- Name: tree_node_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_tree_node
    ADD CONSTRAINT tree_node_pkey PRIMARY KEY (node_id);


--
-- TOC entry 1771 (class 2606 OID 17465)
-- Dependencies: 1379 1379
-- Name: tree_type_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_tree_type
    ADD CONSTRAINT tree_type_pkey PRIMARY KEY (tree_type_id);


--
-- TOC entry 1751 (class 2606 OID 17467)
-- Dependencies: 1372 1372
-- Name: x_option_pkey; Type: CONSTRAINT; Schema: xample; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY x_option
    ADD CONSTRAINT x_option_pkey PRIMARY KEY (option_id);


--
-- TOC entry 1752 (class 1259 OID 17468)
-- Dependencies: 1373
-- Name: pers_opt_xref_index; Type: INDEX; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE INDEX pers_opt_xref_index ON x_pers_opt_xref USING btree (option_id);


--
-- TOC entry 1757 (class 1259 OID 17469)
-- Dependencies: 1375
-- Name: person_index; Type: INDEX; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE INDEX person_index ON x_person USING btree (pers_type_id);


--
-- TOC entry 1766 (class 1259 OID 17470)
-- Dependencies: 1378 1378
-- Name: tree_node_index1; Type: INDEX; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE INDEX tree_node_index1 ON x_tree_node USING btree (tree_type_id, tree_level_id);


--
-- TOC entry 1767 (class 1259 OID 17471)
-- Dependencies: 1378
-- Name: tree_node_index2; Type: INDEX; Schema: xample; Owner: postgres; Tablespace: 
--

CREATE INDEX tree_node_index2 ON x_tree_node USING btree (node_id_snr);


--
-- TOC entry 1782 (class 0 OID 0)
-- Dependencies: 13
-- Name: xample; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA xample FROM PUBLIC;
REVOKE ALL ON SCHEMA xample FROM postgres;
GRANT ALL ON SCHEMA xample TO postgres;


-- Completed on 2006-01-07 18:23:59 GMT Standard Time

--
-- PostgreSQL database dump complete
--

