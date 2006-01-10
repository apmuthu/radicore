--
-- PostgreSQL database dump
--

-- Started on 2005-09-14 18:29:15 GMT Standard Time

SET client_encoding = 'UNICODE';
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 12 (class 16672 OID 23436)
-- Name: product; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA product;


ALTER SCHEMA product OWNER TO postgres;

SET search_path = product, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1314 (class 1259 OID 23437)
-- Dependencies: 1642 1643 1644 1645 1646 12
-- Name: good_identification; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE good_identification (
    product_id character varying(16) DEFAULT ''::character varying NOT NULL,
    identity_type_id character varying(6) DEFAULT ''::character varying NOT NULL,
    id_value character varying(32) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.good_identification OWNER TO postgres;

--
-- TOC entry 1315 (class 1259 OID 23448)
-- Dependencies: 1647 1648 1649 1650 12
-- Name: good_identity_type; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE good_identity_type (
    identity_type_id character varying(6) DEFAULT ''::character varying NOT NULL,
    identity_type_desc character varying(255) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.good_identity_type OWNER TO postgres;

--
-- TOC entry 1316 (class 1259 OID 23466)
-- Dependencies: 1651 1652 1653 1654 1655 1656 12
-- Name: price_component; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE price_component (
    price_component_id integer DEFAULT 0 NOT NULL,
    start_date date DEFAULT '2000-01-01'::date NOT NULL,
    end_date date,
    price numeric(11,2),
    percent numeric(6,3),
    price_type character(1) DEFAULT ''::bpchar NOT NULL,
    price_frequency character(1) DEFAULT ''::bpchar NOT NULL,
    uom_id character varying(16),
    quantity smallint,
    product_id character varying(16),
    prod_feature_id bigint,
    prod_cat_id character varying(16),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.price_component OWNER TO postgres;

--
-- TOC entry 1317 (class 1259 OID 23479)
-- Dependencies: 1657 1658 1659 1660 1661 1662 1663 12
-- Name: prod_cat_class; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE prod_cat_class (
    product_id character varying(16) DEFAULT ''::character varying NOT NULL,
    prod_cat_id character varying(16) DEFAULT ''::character varying NOT NULL,
    seq_no smallint DEFAULT 0::smallint NOT NULL,
    primary_flag character(1) DEFAULT ''::bpchar NOT NULL,
    "comment" character varying(255),
    start_date date DEFAULT '2000-01-01'::date NOT NULL,
    end_date date,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.prod_cat_class OWNER TO postgres;

--
-- TOC entry 1318 (class 1259 OID 23490)
-- Dependencies: 1664 1665 1666 1667 12
-- Name: prod_cat_rollup; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE prod_cat_rollup (
    prod_cat_id_snr character varying(16) DEFAULT ''::character varying NOT NULL,
    prod_cat_id_jnr character varying(16) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.prod_cat_rollup OWNER TO postgres;

--
-- TOC entry 1319 (class 1259 OID 23498)
-- Dependencies: 1668 1669 1670 1671 1672 1673 1674 12
-- Name: prod_feature_applicability; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE prod_feature_applicability (
    product_id character varying(16) DEFAULT ''::character varying NOT NULL,
    prod_feature_id bigint DEFAULT 0::bigint NOT NULL,
    seq_no smallint DEFAULT 1::smallint NOT NULL,
    feature_type character(1) DEFAULT 'O'::bpchar NOT NULL,
    start_date date DEFAULT '2000-01-01'::date NOT NULL,
    end_date date,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.prod_feature_applicability OWNER TO postgres;

--
-- TOC entry 1320 (class 1259 OID 23509)
-- Dependencies: 1675 1676 1677 1678 1679 1680 12
-- Name: prod_feature_interaction; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE prod_feature_interaction (
    product_id character varying(16) DEFAULT ''::character varying NOT NULL,
    prod_feature_id_snr bigint DEFAULT 0::bigint NOT NULL,
    prod_feature_id_jnr bigint DEFAULT 0::bigint NOT NULL,
    feature_interaction character(1) DEFAULT ''::bpchar NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.prod_feature_interaction OWNER TO postgres;

--
-- TOC entry 1321 (class 1259 OID 23519)
-- Dependencies: 1681 1682 1683 1684 1685 12
-- Name: product; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE product (
    product_id character varying(16) DEFAULT ''::character varying NOT NULL,
    product_name character varying(255) DEFAULT ''::character varying NOT NULL,
    date_intro date,
    end_date_sales date,
    end_date_support date,
    "comment" character varying(255),
    product_subtype character(1) DEFAULT 'G'::bpchar NOT NULL,
    uom_id character varying(16),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.product OWNER TO postgres;

--
-- TOC entry 1322 (class 1259 OID 23528)
-- Dependencies: 1686 1687 1688 1689 12
-- Name: product_category; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE product_category (
    prod_cat_id character varying(16) DEFAULT ''::character varying NOT NULL,
    prod_cat_desc character varying(255) DEFAULT ''::character varying NOT NULL,
    product_usage character varying(16),
    product_industry character varying(16),
    product_materials character varying(16),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.product_category OWNER TO postgres;

--
-- TOC entry 1323 (class 1259 OID 23536)
-- Dependencies: 1690 1691 1692 1693 12
-- Name: product_feature; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE product_feature (
    prod_feature_id bigint DEFAULT 0::bigint NOT NULL,
    prod_feature_desc character varying(255) DEFAULT ''::character varying NOT NULL,
    prod_feature_cat_id character varying(16),
    uom_id character varying(16),
    measurement double precision,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.product_feature OWNER TO postgres;

--
-- TOC entry 1324 (class 1259 OID 23544)
-- Dependencies: 1694 1695 1696 1697 1698 12
-- Name: product_feature_category; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE product_feature_category (
    prod_feature_cat_id character varying(16) DEFAULT ''::character varying NOT NULL,
    prod_feature_cat_desc character varying(255) DEFAULT ''::character varying NOT NULL,
    measurement_reqd character(1) DEFAULT 'N'::bpchar NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.product_feature_category OWNER TO postgres;

--
-- TOC entry 1325 (class 1259 OID 23553)
-- Dependencies: 1699 1700 1701 1702 1703 1704 12
-- Name: unit_of_measure; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE unit_of_measure (
    uom_id character varying(16) DEFAULT ''::character varying NOT NULL,
    uom_cat_id character varying(4) DEFAULT ''::character varying NOT NULL,
    uom_abbrev character varying(8) DEFAULT ''::character varying NOT NULL,
    uom_desc character varying(255) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.unit_of_measure OWNER TO postgres;

--
-- TOC entry 1326 (class 1259 OID 23563)
-- Dependencies: 1705 1706 1707 1708 12
-- Name: uom_category; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE uom_category (
    uom_cat_id character varying(4) DEFAULT ''::character varying NOT NULL,
    uom_cat_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.uom_category OWNER TO postgres;

--
-- TOC entry 1327 (class 1259 OID 23571)
-- Dependencies: 1709 1710 1711 1712 1713 12
-- Name: uom_conversion; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE uom_conversion (
    uom_id_from character varying(16) DEFAULT ''::character varying NOT NULL,
    uom_id_to character varying(16) DEFAULT ''::character varying NOT NULL,
    conversion_factor double precision DEFAULT 0::double precision NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.uom_conversion OWNER TO postgres;

--
-- TOC entry 1747 (class 0 OID 23437)
-- Dependencies: 1314
-- Data for Name: good_identification; Type: TABLE DATA; Schema: product; Owner: postgres
--

INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 'MANUF', 'MAN001', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 'SKU', 'SKU001', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('PEN202', 'MANUF', 'MAN002', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('PEN202', 'SKU', 'SKU002', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('DSK401', 'MANUF', 'MAN003', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('DSK401', 'SKU', 'SKU003', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('FRMCHFA1500', 'MANUF', 'MAN004', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('FRMCHFA1500', 'SKU', 'SKU004', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('PC101', 'MANUF', 'MAN005', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('PC101', 'SKU', 'SKU005', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('PC100', 'MANUF', 'MAN006', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identification (product_id, identity_type_id, id_value, created_date, created_user, revised_date, revised_user) VALUES ('PC100', 'SKU', 'SKU006', '2004-03-01 12:00:00', 'AJM', NULL, NULL);


--
-- TOC entry 1748 (class 0 OID 23448)
-- Dependencies: 1315
-- Data for Name: good_identity_type; Type: TABLE DATA; Schema: product; Owner: postgres
--

INSERT INTO good_identity_type (identity_type_id, identity_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('MANUF', 'Manufacturer''s ID number', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identity_type (identity_type_id, identity_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('UPCA', 'Universal Product Code - America', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identity_type (identity_type_id, identity_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('UPCE', 'Universal Product Code - Europe', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identity_type (identity_type_id, identity_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('SKU', 'Stock Keeping Unit', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO good_identity_type (identity_type_id, identity_type_desc, created_date, created_user, revised_date, revised_user) VALUES ('ISBN', 'International Standard Book Number', '2004-03-01 12:00:00', 'AJM', NULL, NULL);


--
-- TOC entry 1749 (class 0 OID 23466)
-- Dependencies: 1316
-- Data for Name: price_component; Type: TABLE DATA; Schema: product; Owner: postgres
--

INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (1, '2000-01-01', '2000-12-31', 2.00, NULL, 'B', '1', NULL, NULL, 'PAP192', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (2, '2001-01-01', '2001-12-31', 2.50, NULL, 'B', '1', NULL, NULL, 'PAP192', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (3, '2002-01-01', '2002-12-31', 2.99, NULL, 'B', '1', NULL, NULL, 'PAP192', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (4, '2003-01-01', '2003-12-31', 3.50, NULL, 'B', '1', NULL, NULL, 'PAP192', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (5, '2004-01-01', '9999-12-31', 3.99, NULL, 'B', '1', NULL, NULL, 'PAP192', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (6, '2000-01-01', '2000-12-31', 50.00, NULL, 'S', '1', NULL, NULL, NULL, 20, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (7, '2001-01-01', '2001-12-31', 45.00, NULL, 'S', '1', NULL, NULL, NULL, 20, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (8, '2002-01-01', '9999-12-31', 40.00, NULL, 'S', '1', NULL, NULL, NULL, 20, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (9, '2000-01-01', '2000-12-31', 150.00, NULL, 'S', '1', NULL, NULL, NULL, 21, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (10, '2001-01-01', '2001-12-31', 140.00, NULL, 'S', '1', NULL, NULL, NULL, 21, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (11, '2002-01-01', '9999-12-31', 130.00, NULL, 'S', '1', NULL, NULL, NULL, 21, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (12, '2002-01-01', '2003-12-31', 5.99, NULL, 'B', '1', NULL, NULL, 'PEN202', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (13, '2004-01-01', '9999-12-31', 6.99, NULL, 'B', '1', NULL, NULL, 'PEN202', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (14, '2002-01-01', '9999-12-31', 0.50, NULL, 'S', '1', NULL, NULL, 'PAP192', 7, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (15, '2002-01-01', '2002-12-31', 1000.00, NULL, 'B', '1', NULL, NULL, 'PC101', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (16, '2003-01-01', '9999-12-31', 1100.00, NULL, 'B', '1', NULL, NULL, 'PC101', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (17, '2002-01-01', '9999-12-31', 500.00, NULL, 'B', 'R', 'DAY', NULL, NULL, NULL, 'CONSULT', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (18, '2004-01-01', '9999-12-31', 400.00, NULL, 'D', 'R', 'DAY', NULL, NULL, 19, 'CONSULT', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (19, '2000-01-01', '2000-12-31', 90.00, NULL, 'B', '1', NULL, NULL, NULL, NULL, 'PC1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (20, '2001-01-01', '2001-12-31', 91.00, NULL, 'B', '1', NULL, NULL, NULL, NULL, 'PC1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (21, '2002-01-01', '2002-12-31', 92.00, NULL, 'B', '1', NULL, NULL, NULL, NULL, 'PC1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (22, '2003-01-01', '2003-12-31', 94.00, NULL, 'B', '1', NULL, NULL, NULL, NULL, 'PC1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO price_component (price_component_id, start_date, end_date, price, percent, price_type, price_frequency, uom_id, quantity, product_id, prod_feature_id, prod_cat_id, created_date, created_user, revised_date, revised_user) VALUES (23, '2004-01-01', '9999-12-31', 95.00, NULL, 'B', '1', NULL, NULL, NULL, NULL, 'PC1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);


--
-- TOC entry 1750 (class 0 OID 23479)
-- Dependencies: 1317
-- Data for Name: prod_cat_class; Type: TABLE DATA; Schema: product; Owner: postgres
--

INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, "comment", start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 'PAPER', 1, 'N', NULL, '2004-02-21', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, "comment", start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PC100', 'PC1', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, "comment", start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PEN202', 'PEN', 1, 'N', NULL, '2004-02-21', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, "comment", start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('STUFF', 'STUFF', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, "comment", start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('DSK401', 'COMPUTER', 1, 'Y', NULL, '2004-02-21', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, "comment", start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('CNS109', 'CONSULT', 1, 'Y', NULL, '2004-02-21', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, "comment", start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('FRMCHFA1500', 'OFFICE', 1, 'Y', NULL, '2004-02-21', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, "comment", start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1', 'STUFF1', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, "comment", start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PC101', 'PC1', 1, 'Y', NULL, '2004-03-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, "comment", start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2', 'STUFF2', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, "comment", start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1A', 'STUFF1A', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, "comment", start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1B', 'STUFF1B', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, "comment", start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2A', 'STUFF2A', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_class (product_id, prod_cat_id, seq_no, primary_flag, "comment", start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2B', 'STUFF2B', 1, 'N', NULL, '2000-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);


--
-- TOC entry 1751 (class 0 OID 23490)
-- Dependencies: 1318
-- Data for Name: prod_cat_rollup; Type: TABLE DATA; Schema: product; Owner: postgres
--

INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('OFFICE', 'PEN', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('OFFICE', 'PAPER', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('COMPUTER', 'PC1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('COMPUTER', 'PC2', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('STUFF', 'STUFF1', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('STUFF', 'STUFF2', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1', 'STUFF1A', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1', 'STUFF1B', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2', 'STUFF2A', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_cat_rollup (prod_cat_id_snr, prod_cat_id_jnr, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2', 'STUFF2B', '2004-03-01 12:00:00', 'AJM', NULL, NULL);


--
-- TOC entry 1752 (class 0 OID 23498)
-- Dependencies: 1319
-- Data for Name: prod_feature_applicability; Type: TABLE DATA; Schema: product; Owner: postgres
--

INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PC101', 20, 1, 'S', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PC101', 21, 1, 'O', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PC100', 20, 1, 'S', '2000-01-01', '2001-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PC100', 21, 1, 'S', '2002-01-01', '2003-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PC100', 22, 1, 'S', '2004-01-01', '2004-03-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PC100', 22, 2, 'S', '2004-04-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 5, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 4, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 14, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 6, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 7, 1, 'O', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 2, 1, 'X', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 10, 1, 'X', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 11, 1, 'X', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 12, 1, 'X', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PEN202', 8, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PEN202', 13, 1, 'S', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PEN202', 2, 1, 'O', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('PEN202', 15, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('DSK401', 1, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('DSK401', 18, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('DSK401', 16, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('CNS109', 9, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO prod_feature_applicability (product_id, prod_feature_id, seq_no, feature_type, start_date, end_date, created_date, created_user, revised_date, revised_user) VALUES ('CNS109', 17, 1, 'R', '2004-01-01', '9999-12-31', '2004-03-01 12:00:00', 'AJM', NULL, NULL);


--
-- TOC entry 1753 (class 0 OID 23509)
-- Dependencies: 1320
-- Data for Name: prod_feature_interaction; Type: TABLE DATA; Schema: product; Owner: postgres
--

INSERT INTO prod_feature_interaction (product_id, prod_feature_id_snr, prod_feature_id_jnr, feature_interaction, created_date, created_user, revised_date, revised_user) VALUES ('PC101', 20, 21, 'I', '2004-03-01 12:00:00', 'AJM', NULL, NULL);


--
-- TOC entry 1754 (class 0 OID 23519)
-- Dependencies: 1321
-- Data for Name: product; Type: TABLE DATA; Schema: product; Owner: postgres
--

INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, "comment", product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('PAP192', 'Johnson fine grade 8.5 by 11 inch bond paper', NULL, NULL, NULL, NULL, 'G', 'REAM', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, "comment", product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('PEN202', 'Goldstein Elite pen', NULL, NULL, NULL, NULL, 'G', 'EACH', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, "comment", product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('DSK401', 'Jerry''s box of 3.5-inch diskettes', NULL, NULL, NULL, NULL, 'G', 'BOX', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, "comment", product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('FRMCHFA1500', 'Preprinted forms for insurance claims', NULL, NULL, NULL, NULL, 'G', 'EACH', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, "comment", product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('CNS109', 'Office supply inventory management consulting service', NULL, NULL, NULL, NULL, 'S', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, "comment", product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('PC101', 'Laptop Computer', NULL, NULL, NULL, NULL, 'G', 'EACH', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, "comment", product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('PC100', 'Desktop Computer', '2004-03-01', NULL, NULL, NULL, 'G', 'EACH', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, "comment", product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('STUFF', 'Stuff', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, "comment", product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1', 'Stuff 1', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, "comment", product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2', 'Stuff 2', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, "comment", product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1A', 'Stuff 1a', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, "comment", product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1B', 'Stuff 1b', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, "comment", product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2A', 'Stuff 2a', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product (product_id, product_name, date_intro, end_date_sales, end_date_support, "comment", product_subtype, uom_id, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2B', 'Stuff 2b', NULL, NULL, NULL, NULL, 'G', NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);


--
-- TOC entry 1755 (class 0 OID 23528)
-- Dependencies: 1322
-- Data for Name: product_category; Type: TABLE DATA; Schema: product; Owner: postgres
--

INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('OFFICE', 'Office Supplies', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('PEN', 'Pens', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('PAPER', 'Paper', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('COMPUTER', 'Computer Supplies', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('CONSULT', 'Consultancy Services', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('FORMS', 'Forms', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('INS', 'Insurance', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('PC1', 'Computer Hardware', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('PC2', 'Computer Software', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('STUFF', 'Stuff', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1', 'Stuff 1', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2', 'Stuff 2', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1A', 'Stuff 1a', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('STUFF1B', 'Stuff 1b', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2A', 'Stuff 2a', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_category (prod_cat_id, prod_cat_desc, product_usage, product_industry, product_materials, created_date, created_user, revised_date, revised_user) VALUES ('STUFF2B', 'Stuff 2b', NULL, NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);


--
-- TOC entry 1756 (class 0 OID 23536)
-- Dependencies: 1323
-- Data for Name: product_feature; Type: TABLE DATA; Schema: product; Owner: postgres
--

INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (1, 'Red', 'COLOUR', NULL, 1.23458, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (2, 'Blue', 'COLOUR', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (3, 'Green', 'COLOUR', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (4, '8.5in Wide', 'DIM', 'INCH', 8.5, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (5, '11in Long', 'DIM', 'INCH', 11, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (6, 'Fine Grade', 'QUAL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (7, 'Extra Glossy Finish', 'QUAL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (8, 'Fine Point', 'QUAL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (9, 'Expert', 'QUAL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (10, 'Grey', 'COLOUR', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (11, 'Cream', 'COLOUR', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (12, 'White', 'COLOUR', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (13, 'Black', 'COLOUR', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (14, 'Johnson', 'BRAND', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (15, 'Goldstein', 'BRAND', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (16, 'Jerry''s', 'BRAND', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (17, 'ABC Corporation', 'BRAND', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (18, '3.5in Diameter', 'DIM', 'INCH', 3.5, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (19, 'Junior', 'QUAL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (20, 'CD-ROM drive', 'HARD', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (21, 'DVD-ROM drive', 'HARD', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (22, 'DVD-RW drive', 'HARD', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (23, 'Small', 'SIZE', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (24, 'Medium', 'SIZE', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (25, 'Large', 'SIZE', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (26, 'Extra Large', 'SIZE', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (27, 'Post & Package', 'BILL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (28, 'Delivery - Standard', 'BILL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature (prod_feature_id, prod_feature_desc, prod_feature_cat_id, uom_id, measurement, created_date, created_user, revised_date, revised_user) VALUES (29, 'Delivery - Express', 'BILL', NULL, NULL, '2004-03-01 12:00:00', 'AJM', NULL, NULL);


--
-- TOC entry 1757 (class 0 OID 23544)
-- Dependencies: 1324
-- Data for Name: product_feature_category; Type: TABLE DATA; Schema: product; Owner: postgres
--

INSERT INTO product_feature_category (prod_feature_cat_id, prod_feature_cat_desc, measurement_reqd, created_date, created_user, revised_date, revised_user) VALUES ('BILL', 'Billing Feature', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature_category (prod_feature_cat_id, prod_feature_cat_desc, measurement_reqd, created_date, created_user, revised_date, revised_user) VALUES ('BRAND', 'Brand', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature_category (prod_feature_cat_id, prod_feature_cat_desc, measurement_reqd, created_date, created_user, revised_date, revised_user) VALUES ('COLOUR', 'Colour', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature_category (prod_feature_cat_id, prod_feature_cat_desc, measurement_reqd, created_date, created_user, revised_date, revised_user) VALUES ('DIM', 'Dimension', 'Y', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature_category (prod_feature_cat_id, prod_feature_cat_desc, measurement_reqd, created_date, created_user, revised_date, revised_user) VALUES ('HARD', 'Hardware Feature', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature_category (prod_feature_cat_id, prod_feature_cat_desc, measurement_reqd, created_date, created_user, revised_date, revised_user) VALUES ('QUAL', 'Quality', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature_category (prod_feature_cat_id, prod_feature_cat_desc, measurement_reqd, created_date, created_user, revised_date, revised_user) VALUES ('SIZE', 'Size', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature_category (prod_feature_cat_id, prod_feature_cat_desc, measurement_reqd, created_date, created_user, revised_date, revised_user) VALUES ('SOFT', 'Software Feature', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO product_feature_category (prod_feature_cat_id, prod_feature_cat_desc, measurement_reqd, created_date, created_user, revised_date, revised_user) VALUES ('STYLE', 'Style', 'N', '2004-03-01 12:00:00', 'AJM', NULL, NULL);


--
-- TOC entry 1758 (class 0 OID 23553)
-- Dependencies: 1325
-- Data for Name: unit_of_measure; Type: TABLE DATA; Schema: product; Owner: postgres
--

INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('AMP', 'ELEC', 'amp', 'Ampere', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('BOX', 'VOL', 'BOX', 'Box', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('CENTILITRE', 'VOL', 'cl', 'Centilitre', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('CENTIMETER', 'LEN', 'cm', 'Centimeter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('CU_CC', 'VOL', 'cc', 'Cubic Centimeter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('CU_FT', 'VOL', 'Cu. Ft.', 'Cubic Foot', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('CU_INCH', 'VOL', 'Cu. In.', 'Cubic Inch', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('CU_M', 'VOL', 'Cu. M', 'Cubic Meter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('CU_YD', 'VOL', 'Cu. Yd.', 'Cubic Yard', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('DAY', 'TIME', 'day', 'per Day', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('DECIMETER', 'LEN', 'dm', 'Decimeter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('EACH', 'MISC', 'EA', 'Each', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('FLUIDOUNCE', 'VOL', 'Floz', 'Fluid Ounce', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('FOOT', 'LEN', 'Ft', 'Foot', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('GALLON', 'VOL', 'Gal', 'Gallon (Imperial)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('GALLON(US)', 'VOL', 'Gal', 'Gallon (US)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('GRAM', 'WEIG', 'gm', 'Gram', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('HOUR', 'TIME', 'Hour', 'per Hour', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('HUNDREDWEIGHT', 'WEIG', 'cwt', 'Hundredweight', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('HUNDREDWT(US)', 'WEIG', 'cwt', 'Hundredweight (US)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('INCH', 'LEN', 'in', 'Inch', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('KILOGRAM', 'WEIG', 'kg', 'Kilogram', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('KILOWATT', 'ELEC', 'Kw', 'Kilowatt', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('LITRE', 'VOL', 'lt', 'Litre', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('METER', 'LEN', 'm', 'Meter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('MILLIGRAM', 'WEIG', 'mg', 'Milligram', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('MILLIMETER', 'LEN', 'mm', 'Millimeter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('MONTH', 'TIME', 'month', 'per Month', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('OHM', 'ELEC', 'ohm', 'Ohm', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('OUNCE', 'WEIG', 'oz', 'Ounce Avoirdupois', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('PINT', 'VOL', 'pt', 'Pint (Imperial)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('PINT(US)', 'VOL', 'pt', 'Pint (US)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('POUND', 'WEIG', 'lb', 'Pound Avoirdupois', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('QUART', 'VOL', 'Qt', 'Quart (Imperial)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('QUART(US)', 'VOL', 'Qt', 'Quart (US)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('REAM', 'VOL', 'Ream', 'Ream', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('SHEET', 'VOL', 'Sheet', 'Sheet', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('SQ_CM', 'AREA', 'Sq. Cm.', 'Square Centimeter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('SQ_FOOT', 'AREA', 'Sq. Ft.', 'Square Foot', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('SQ_INCH', 'AREA', 'Sq. In.', 'Square Inch', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('SQ_M', 'AREA', 'Sq. M.', 'Square Meter', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('SQ_YARD', 'AREA', 'Sq. Yd.', 'Square Yard', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('STONE', 'WEIG', 'st', 'Stone', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('TON', 'WEIG', 'ton', 'Short Ton (UK)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('TON(L)', 'WEIG', 'ton', 'Long Ton (US)', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('TONNE', 'WEIG', 'tonne', 'Metric Tonne', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('VOLT', 'ELEC', 'V', 'Volt', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('WATT', 'ELEC', 'watt', 'Watt', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO unit_of_measure (uom_id, uom_cat_id, uom_abbrev, uom_desc, created_date, created_user, revised_date, revised_user) VALUES ('YARD', 'LEN', 'yd', 'Yard', '2004-03-01 12:00:00', 'AJM', NULL, NULL);


--
-- TOC entry 1759 (class 0 OID 23563)
-- Dependencies: 1326
-- Data for Name: uom_category; Type: TABLE DATA; Schema: product; Owner: postgres
--

INSERT INTO uom_category (uom_cat_id, uom_cat_desc, created_date, created_user, revised_date, revised_user) VALUES ('VOL', 'Volume/Capacity', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_category (uom_cat_id, uom_cat_desc, created_date, created_user, revised_date, revised_user) VALUES ('WEIG', 'Weight', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_category (uom_cat_id, uom_cat_desc, created_date, created_user, revised_date, revised_user) VALUES ('LEN', 'Length', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_category (uom_cat_id, uom_cat_desc, created_date, created_user, revised_date, revised_user) VALUES ('AREA', 'Area', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_category (uom_cat_id, uom_cat_desc, created_date, created_user, revised_date, revised_user) VALUES ('TIME', 'Time', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_category (uom_cat_id, uom_cat_desc, created_date, created_user, revised_date, revised_user) VALUES ('ELEC', 'Electrical', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_category (uom_cat_id, uom_cat_desc, created_date, created_user, revised_date, revised_user) VALUES ('MISC', 'Miscellaneous', '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_category (uom_cat_id, uom_cat_desc, created_date, created_user, revised_date, revised_user) VALUES ('SPEE', 'Speed', '2004-03-01 12:00:00', 'AJM', NULL, NULL);


--
-- TOC entry 1760 (class 0 OID 23571)
-- Dependencies: 1327
-- Data for Name: uom_conversion; Type: TABLE DATA; Schema: product; Owner: postgres
--

INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('CENTIMETER', 'METER', 100, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('MILLIMETER', 'CENTIMETER', 10, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('MILLIMETER', 'METER', 1000, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('MILLIMETER', 'DECIMETER', 100, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('CENTIMETER', 'DECIMETER', 10, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('DECIMETER', 'METER', 10, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('DECIMETER', 'CENTIMETER', 0.10000000149011599, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('DECIMETER', 'MILLIMETER', 0.0099999997764825804, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('METER', 'DECIMETER', 0.10000000149011599, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('METER', 'CENTIMETER', 0.0099999997764825804, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('METER', 'MILLIMETER', 0.00100000004749745, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('CENTIMETER', 'MILLIMETER', 0.10000000149011599, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('FOOT', 'INCH', 12, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('YARD', 'FOOT', 3, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('YARD', 'INCH', 36, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('FOOT', 'YARD', 0.33333333333332998, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('INCH', 'FOOT', 0.083333333333332996, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('INCH', 'YARD', 0.027777777777776999, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('PINT', 'FLUIDOUNCE', 20, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('PINT(US)', 'FLUIDOUNCE', 16, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('GALLON', 'QUART', 4, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('GALLON', 'PINT', 8, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('GALLON', 'FLUIDOUNCE', 160, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('GALLON(US)', 'QUART(US)', 4, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('GALLON(US)', 'PINT(US)', 8, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('GALLON(US)', 'FLUIDOUNCE', 128, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('KILOGRAM', 'GRAM', 1000, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('GRAM', 'MILLIGRAM', 1000, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('TONNE', 'KILOGRAM', 1000, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('TONNE', 'MILLIGRAM', 1000000, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('TON', 'HUNDREDWEIGHT', 20, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('TON', 'POUND', 2240, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('POUND', 'OUNCE', 16, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('STONE', 'POUND', 14, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('TON(L)', 'POUND', 2000, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('HUNDREDWEIGHT', 'STONE', 8, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('HUNDREDWEIGHT', 'POUND', 112, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('HUNDREDWT(US)', 'POUND', 100, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('HUNDREDWT(US)', 'STONE', 7.1428571428570997, '2004-03-01 12:00:00', 'AJM', NULL, NULL);
INSERT INTO uom_conversion (uom_id_from, uom_id_to, conversion_factor, created_date, created_user, revised_date, revised_user) VALUES ('REAM', 'SHEET', 500, '2004-03-01 12:00:00', 'AJM', NULL, NULL);


--
-- TOC entry 1715 (class 16386 OID 23447)
-- Dependencies: 1314 1314 1314
-- Name: good_identification_identity_type_id_key; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY good_identification
    ADD CONSTRAINT good_identification_identity_type_id_key UNIQUE (identity_type_id, id_value);


ALTER INDEX product.good_identification_identity_type_id_key OWNER TO postgres;

--
-- TOC entry 1717 (class 16386 OID 23445)
-- Dependencies: 1314 1314 1314
-- Name: good_identification_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY good_identification
    ADD CONSTRAINT good_identification_pkey PRIMARY KEY (product_id, identity_type_id);


ALTER INDEX product.good_identification_pkey OWNER TO postgres;

--
-- TOC entry 1719 (class 16386 OID 23455)
-- Dependencies: 1315 1315
-- Name: good_identity_type_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY good_identity_type
    ADD CONSTRAINT good_identity_type_pkey PRIMARY KEY (identity_type_id);


ALTER INDEX product.good_identity_type_pkey OWNER TO postgres;

--
-- TOC entry 1724 (class 16386 OID 23475)
-- Dependencies: 1316 1316
-- Name: price_component_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY price_component
    ADD CONSTRAINT price_component_pkey PRIMARY KEY (price_component_id);


ALTER INDEX product.price_component_pkey OWNER TO postgres;

--
-- TOC entry 1726 (class 16386 OID 23489)
-- Dependencies: 1317 1317 1317 1317
-- Name: prod_cat_class_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY prod_cat_class
    ADD CONSTRAINT prod_cat_class_pkey PRIMARY KEY (product_id, prod_cat_id, seq_no);


ALTER INDEX product.prod_cat_class_pkey OWNER TO postgres;

--
-- TOC entry 1728 (class 16386 OID 23497)
-- Dependencies: 1318 1318 1318
-- Name: prod_cat_rollup_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY prod_cat_rollup
    ADD CONSTRAINT prod_cat_rollup_pkey PRIMARY KEY (prod_cat_id_snr, prod_cat_id_jnr);


ALTER INDEX product.prod_cat_rollup_pkey OWNER TO postgres;

--
-- TOC entry 1730 (class 16386 OID 23508)
-- Dependencies: 1319 1319 1319 1319
-- Name: prod_feature_applicability_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY prod_feature_applicability
    ADD CONSTRAINT prod_feature_applicability_pkey PRIMARY KEY (product_id, prod_feature_id, seq_no);


ALTER INDEX product.prod_feature_applicability_pkey OWNER TO postgres;

--
-- TOC entry 1732 (class 16386 OID 23518)
-- Dependencies: 1320 1320 1320 1320
-- Name: prod_feature_interaction_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY prod_feature_interaction
    ADD CONSTRAINT prod_feature_interaction_pkey PRIMARY KEY (product_id, prod_feature_id_snr, prod_feature_id_jnr);


ALTER INDEX product.prod_feature_interaction_pkey OWNER TO postgres;

--
-- TOC entry 1736 (class 16386 OID 23535)
-- Dependencies: 1322 1322
-- Name: product_category_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (prod_cat_id);


ALTER INDEX product.product_category_pkey OWNER TO postgres;

--
-- TOC entry 1740 (class 16386 OID 23552)
-- Dependencies: 1324 1324
-- Name: product_feature_category_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_feature_category
    ADD CONSTRAINT product_feature_category_pkey PRIMARY KEY (prod_feature_cat_id);


ALTER INDEX product.product_feature_category_pkey OWNER TO postgres;

--
-- TOC entry 1738 (class 16386 OID 23543)
-- Dependencies: 1323 1323
-- Name: product_feature_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_feature
    ADD CONSTRAINT product_feature_pkey PRIMARY KEY (prod_feature_id);


ALTER INDEX product.product_feature_pkey OWNER TO postgres;

--
-- TOC entry 1734 (class 16386 OID 23527)
-- Dependencies: 1321 1321
-- Name: product_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);


ALTER INDEX product.product_pkey OWNER TO postgres;

--
-- TOC entry 1742 (class 16386 OID 23562)
-- Dependencies: 1325 1325
-- Name: unit_of_measure_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY unit_of_measure
    ADD CONSTRAINT unit_of_measure_pkey PRIMARY KEY (uom_id);


ALTER INDEX product.unit_of_measure_pkey OWNER TO postgres;

--
-- TOC entry 1744 (class 16386 OID 23570)
-- Dependencies: 1326 1326
-- Name: uom_category_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY uom_category
    ADD CONSTRAINT uom_category_pkey PRIMARY KEY (uom_cat_id);


ALTER INDEX product.uom_category_pkey OWNER TO postgres;

--
-- TOC entry 1746 (class 16386 OID 23579)
-- Dependencies: 1327 1327 1327
-- Name: uom_conversion_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY uom_conversion
    ADD CONSTRAINT uom_conversion_pkey PRIMARY KEY (uom_id_from, uom_id_to);


ALTER INDEX product.uom_conversion_pkey OWNER TO postgres;

--
-- TOC entry 1720 (class 1259 OID 23476)
-- Dependencies: 1316
-- Name: price_component_index1; Type: INDEX; Schema: product; Owner: postgres; Tablespace: 
--

CREATE INDEX price_component_index1 ON price_component USING btree (product_id);


ALTER INDEX product.price_component_index1 OWNER TO postgres;

--
-- TOC entry 1721 (class 1259 OID 23477)
-- Dependencies: 1316
-- Name: price_component_index2; Type: INDEX; Schema: product; Owner: postgres; Tablespace: 
--

CREATE INDEX price_component_index2 ON price_component USING btree (prod_feature_id);


ALTER INDEX product.price_component_index2 OWNER TO postgres;

--
-- TOC entry 1722 (class 1259 OID 23478)
-- Dependencies: 1316
-- Name: price_component_index3; Type: INDEX; Schema: product; Owner: postgres; Tablespace: 
--

CREATE INDEX price_component_index3 ON price_component USING btree (prod_cat_id);


ALTER INDEX product.price_component_index3 OWNER TO postgres;

-- Completed on 2005-09-14 18:29:16 GMT Standard Time

--
-- PostgreSQL database dump complete
--

