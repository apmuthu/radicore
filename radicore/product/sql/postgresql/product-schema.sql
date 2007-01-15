--
-- PostgreSQL database dump
--

-- Started on 2006-12-16 19:46:53

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 9 (class 2615 OID 17813)
-- Name: product; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA product;


ALTER SCHEMA product OWNER TO postgres;

SET search_path = product, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1489 (class 1259 OID 18877)
-- Dependencies: 1907 1908 1909 1910 1911 9
-- Name: container; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE container (
    facility_id smallint DEFAULT 0::smallint NOT NULL,
    container_id smallint DEFAULT 0::smallint NOT NULL,
    container_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    container_type_id smallint DEFAULT 0::smallint NOT NULL,
    created_date timestamp without time zone DEFAULT '2001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.container OWNER TO postgres;

--
-- TOC entry 1491 (class 1259 OID 18888)
-- Dependencies: 1913 1914 9
-- Name: container_type; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE container_type (
    container_type_id integer NOT NULL,
    container_type_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.container_type OWNER TO postgres;

--
-- TOC entry 1490 (class 1259 OID 18886)
-- Dependencies: 1491 9
-- Name: container_type_container_type_id_seq; Type: SEQUENCE; Schema: product; Owner: postgres
--

CREATE SEQUENCE container_type_container_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE product.container_type_container_type_id_seq OWNER TO postgres;

--
-- TOC entry 2011 (class 0 OID 0)
-- Dependencies: 1490
-- Name: container_type_container_type_id_seq; Type: SEQUENCE OWNED BY; Schema: product; Owner: postgres
--

ALTER SEQUENCE container_type_container_type_id_seq OWNED BY container_type.container_type_id;


--
-- TOC entry 1493 (class 1259 OID 18897)
-- Dependencies: 1916 1917 1918 9
-- Name: facility; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE facility (
    facility_id integer NOT NULL,
    facility_desc character varying(255) DEFAULT ''::character varying NOT NULL,
    facility_type_id smallint DEFAULT 0::smallint NOT NULL,
    created_date timestamp without time zone DEFAULT '2001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.facility OWNER TO postgres;

--
-- TOC entry 1492 (class 1259 OID 18895)
-- Dependencies: 9 1493
-- Name: facility_facility_id_seq; Type: SEQUENCE; Schema: product; Owner: postgres
--

CREATE SEQUENCE facility_facility_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE product.facility_facility_id_seq OWNER TO postgres;

--
-- TOC entry 2013 (class 0 OID 0)
-- Dependencies: 1492
-- Name: facility_facility_id_seq; Type: SEQUENCE OWNED BY; Schema: product; Owner: postgres
--

ALTER SEQUENCE facility_facility_id_seq OWNED BY facility.facility_id;


--
-- TOC entry 1495 (class 1259 OID 18907)
-- Dependencies: 1920 1921 9
-- Name: facility_type; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE facility_type (
    facility_type_id integer NOT NULL,
    facility_type_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.facility_type OWNER TO postgres;

--
-- TOC entry 1494 (class 1259 OID 18905)
-- Dependencies: 9 1495
-- Name: facility_type_facility_type_id_seq; Type: SEQUENCE; Schema: product; Owner: postgres
--

CREATE SEQUENCE facility_type_facility_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE product.facility_type_facility_type_id_seq OWNER TO postgres;

--
-- TOC entry 2015 (class 0 OID 0)
-- Dependencies: 1494
-- Name: facility_type_facility_type_id_seq; Type: SEQUENCE OWNED BY; Schema: product; Owner: postgres
--

ALTER SEQUENCE facility_type_facility_type_id_seq OWNED BY facility_type.facility_type_id;


--
-- TOC entry 1436 (class 1259 OID 18130)
-- Dependencies: 1835 1836 1837 1838 1839 9
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
-- TOC entry 1437 (class 1259 OID 18137)
-- Dependencies: 1840 1841 1842 1843 9
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
-- TOC entry 1496 (class 1259 OID 18914)
-- Dependencies: 1922 1923 1924 1925 1926 1927 1928 9
-- Name: inventory_item; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE inventory_item (
    product_id character varying(16) DEFAULT ''::character varying NOT NULL,
    inventory_item_id smallint DEFAULT 0::smallint NOT NULL,
    inv_type character(1) DEFAULT ''::bpchar NOT NULL,
    serial_no character varying(40),
    qty_on_hand integer,
    total_qty integer,
    facility_id smallint DEFAULT 0::smallint NOT NULL,
    container_id smallint DEFAULT 0::smallint NOT NULL,
    lot_id integer,
    inv_item_status_id smallint DEFAULT 1::smallint NOT NULL,
    created_date timestamp without time zone DEFAULT '2001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.inventory_item OWNER TO postgres;

--
-- TOC entry 1498 (class 1259 OID 18929)
-- Dependencies: 1930 1931 9
-- Name: inventory_item_status; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE inventory_item_status (
    inv_item_status_id integer NOT NULL,
    inv_item_status_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.inventory_item_status OWNER TO postgres;

--
-- TOC entry 1499 (class 1259 OID 18936)
-- Dependencies: 1932 1933 1934 1935 1936 1937 9
-- Name: inventory_item_status_hist; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE inventory_item_status_hist (
    product_id character varying(16) DEFAULT ''::character varying NOT NULL,
    inventory_item_id smallint DEFAULT 0::smallint NOT NULL,
    seq_no smallint DEFAULT 0::smallint NOT NULL,
    inv_item_status_id smallint DEFAULT 0::smallint NOT NULL,
    status_date date DEFAULT '2001-01-01'::date NOT NULL,
    created_date timestamp without time zone DEFAULT '2001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.inventory_item_status_hist OWNER TO postgres;

--
-- TOC entry 1497 (class 1259 OID 18927)
-- Dependencies: 9 1498
-- Name: inventory_item_status_inv_item_status_id_seq; Type: SEQUENCE; Schema: product; Owner: postgres
--

CREATE SEQUENCE inventory_item_status_inv_item_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE product.inventory_item_status_inv_item_status_id_seq OWNER TO postgres;

--
-- TOC entry 2021 (class 0 OID 0)
-- Dependencies: 1497
-- Name: inventory_item_status_inv_item_status_id_seq; Type: SEQUENCE OWNED BY; Schema: product; Owner: postgres
--

ALTER SEQUENCE inventory_item_status_inv_item_status_id_seq OWNED BY inventory_item_status.inv_item_status_id;


--
-- TOC entry 1500 (class 1259 OID 18946)
-- Dependencies: 1938 1939 1940 1941 1942 1943 9
-- Name: inventory_item_variance; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE inventory_item_variance (
    product_id character varying(16) DEFAULT ''::character varying NOT NULL,
    inventory_item_id smallint DEFAULT 0::smallint NOT NULL,
    seq_no smallint DEFAULT 0::smallint NOT NULL,
    inv_var_reason_id smallint DEFAULT 0::smallint NOT NULL,
    inventory_date date DEFAULT '2001-01-01'::date NOT NULL,
    variance_qty integer,
    var_comment text,
    created_date timestamp without time zone DEFAULT '2001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.inventory_item_variance OWNER TO postgres;

--
-- TOC entry 1502 (class 1259 OID 18961)
-- Dependencies: 1945 1946 9
-- Name: inventory_variance_reason; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE inventory_variance_reason (
    inv_var_reason_id integer NOT NULL,
    inv_var_reason_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.inventory_variance_reason OWNER TO postgres;

--
-- TOC entry 1501 (class 1259 OID 18959)
-- Dependencies: 1502 9
-- Name: inventory_variance_reason_inv_var_reason_id_seq; Type: SEQUENCE; Schema: product; Owner: postgres
--

CREATE SEQUENCE inventory_variance_reason_inv_var_reason_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE product.inventory_variance_reason_inv_var_reason_id_seq OWNER TO postgres;

--
-- TOC entry 2024 (class 0 OID 0)
-- Dependencies: 1501
-- Name: inventory_variance_reason_inv_var_reason_id_seq; Type: SEQUENCE OWNED BY; Schema: product; Owner: postgres
--

ALTER SEQUENCE inventory_variance_reason_inv_var_reason_id_seq OWNED BY inventory_variance_reason.inv_var_reason_id;


--
-- TOC entry 1503 (class 1259 OID 18968)
-- Dependencies: 1947 1948 1949 1950 9
-- Name: lot; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE lot (
    lot_id integer DEFAULT 0 NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    manuf_date date DEFAULT '2001-01-01'::date NOT NULL,
    expiry_date date,
    created_date timestamp without time zone DEFAULT '2001-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.lot OWNER TO postgres;

--
-- TOC entry 1438 (class 1259 OID 18143)
-- Dependencies: 1844 1845 1846 1847 1848 1849 9
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
-- TOC entry 1439 (class 1259 OID 18151)
-- Dependencies: 1850 1851 1852 1853 1854 1855 1856 9
-- Name: prod_cat_class; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE prod_cat_class (
    product_id character varying(16) DEFAULT ''::character varying NOT NULL,
    prod_cat_id character varying(16) DEFAULT ''::character varying NOT NULL,
    seq_no smallint DEFAULT (0)::smallint NOT NULL,
    primary_flag character(1) DEFAULT ''::bpchar NOT NULL,
    pcc_comment character varying(255),
    start_date date DEFAULT '2000-01-01'::date NOT NULL,
    end_date date,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.prod_cat_class OWNER TO postgres;

--
-- TOC entry 1440 (class 1259 OID 18160)
-- Dependencies: 1857 1858 1859 1860 9
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
-- TOC entry 1441 (class 1259 OID 18166)
-- Dependencies: 1861 1862 1863 1864 1865 1866 1867 9
-- Name: prod_feature_applicability; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE prod_feature_applicability (
    product_id character varying(16) DEFAULT ''::character varying NOT NULL,
    prod_feature_id bigint DEFAULT (0)::bigint NOT NULL,
    seq_no smallint DEFAULT (1)::smallint NOT NULL,
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
-- TOC entry 1442 (class 1259 OID 18175)
-- Dependencies: 1868 1869 1870 1871 1872 1873 9
-- Name: prod_feature_interaction; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE prod_feature_interaction (
    product_id character varying(16) DEFAULT ''::character varying NOT NULL,
    prod_feature_id_snr bigint DEFAULT (0)::bigint NOT NULL,
    prod_feature_id_jnr bigint DEFAULT (0)::bigint NOT NULL,
    feature_interaction character(1) DEFAULT ''::bpchar NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.prod_feature_interaction OWNER TO postgres;

--
-- TOC entry 1443 (class 1259 OID 18183)
-- Dependencies: 1874 1875 1876 1877 1878 9
-- Name: product; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE product (
    product_id character varying(16) DEFAULT ''::character varying NOT NULL,
    product_name character varying(255) DEFAULT ''::character varying NOT NULL,
    date_intro date,
    end_date_sales date,
    end_date_support date,
    prod_comment character varying(255),
    product_subtype character(1) DEFAULT 'G'::bpchar NOT NULL,
    uom_id character varying(16),
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.product OWNER TO postgres;

--
-- TOC entry 1444 (class 1259 OID 18193)
-- Dependencies: 1879 1880 1881 1882 9
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
-- TOC entry 1445 (class 1259 OID 18199)
-- Dependencies: 1883 1884 1885 1886 9
-- Name: product_feature; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE product_feature (
    prod_feature_id bigint DEFAULT (0)::bigint NOT NULL,
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
-- TOC entry 1446 (class 1259 OID 18205)
-- Dependencies: 1887 1888 1889 1890 1891 9
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
-- TOC entry 1447 (class 1259 OID 18212)
-- Dependencies: 1892 1893 1894 1895 1896 1897 9
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
-- TOC entry 1448 (class 1259 OID 18220)
-- Dependencies: 1898 1899 1900 1901 9
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
-- TOC entry 1449 (class 1259 OID 18226)
-- Dependencies: 1902 1903 1904 1905 1906 9
-- Name: uom_conversion; Type: TABLE; Schema: product; Owner: postgres; Tablespace: 
--

CREATE TABLE uom_conversion (
    uom_id_from character varying(16) DEFAULT ''::character varying NOT NULL,
    uom_id_to character varying(16) DEFAULT ''::character varying NOT NULL,
    conversion_factor double precision DEFAULT (0)::double precision NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16) DEFAULT ''::character varying NOT NULL,
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE product.uom_conversion OWNER TO postgres;

--
-- TOC entry 1912 (class 2604 OID 18890)
-- Dependencies: 1490 1491 1491
-- Name: container_type_id; Type: DEFAULT; Schema: product; Owner: postgres
--

ALTER TABLE container_type ALTER COLUMN container_type_id SET DEFAULT nextval('container_type_container_type_id_seq'::regclass);


--
-- TOC entry 1915 (class 2604 OID 18899)
-- Dependencies: 1492 1493 1493
-- Name: facility_id; Type: DEFAULT; Schema: product; Owner: postgres
--

ALTER TABLE facility ALTER COLUMN facility_id SET DEFAULT nextval('facility_facility_id_seq'::regclass);


--
-- TOC entry 1919 (class 2604 OID 18909)
-- Dependencies: 1495 1494 1495
-- Name: facility_type_id; Type: DEFAULT; Schema: product; Owner: postgres
--

ALTER TABLE facility_type ALTER COLUMN facility_type_id SET DEFAULT nextval('facility_type_facility_type_id_seq'::regclass);


--
-- TOC entry 1929 (class 2604 OID 18931)
-- Dependencies: 1498 1497 1498
-- Name: inv_item_status_id; Type: DEFAULT; Schema: product; Owner: postgres
--

ALTER TABLE inventory_item_status ALTER COLUMN inv_item_status_id SET DEFAULT nextval('inventory_item_status_inv_item_status_id_seq'::regclass);


--
-- TOC entry 1944 (class 2604 OID 18963)
-- Dependencies: 1502 1501 1502
-- Name: inv_var_reason_id; Type: DEFAULT; Schema: product; Owner: postgres
--

ALTER TABLE inventory_variance_reason ALTER COLUMN inv_var_reason_id SET DEFAULT nextval('inventory_variance_reason_inv_var_reason_id_seq'::regclass);


--
-- TOC entry 1985 (class 2606 OID 18885)
-- Dependencies: 1489 1489 1489
-- Name: container_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY container
    ADD CONSTRAINT container_pkey PRIMARY KEY (facility_id, container_id);


--
-- TOC entry 1987 (class 2606 OID 18894)
-- Dependencies: 1491 1491
-- Name: container_type_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY container_type
    ADD CONSTRAINT container_type_pkey PRIMARY KEY (container_type_id);


--
-- TOC entry 1989 (class 2606 OID 18904)
-- Dependencies: 1493 1493
-- Name: facility_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY facility
    ADD CONSTRAINT facility_pkey PRIMARY KEY (facility_id);


--
-- TOC entry 1991 (class 2606 OID 18913)
-- Dependencies: 1495 1495
-- Name: facility_type_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY facility_type
    ADD CONSTRAINT facility_type_pkey PRIMARY KEY (facility_type_id);


--
-- TOC entry 1952 (class 2606 OID 18557)
-- Dependencies: 1436 1436 1436
-- Name: good_identification_identity_type_id_key; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY good_identification
    ADD CONSTRAINT good_identification_identity_type_id_key UNIQUE (identity_type_id, id_value);


--
-- TOC entry 1954 (class 2606 OID 18559)
-- Dependencies: 1436 1436 1436
-- Name: good_identification_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY good_identification
    ADD CONSTRAINT good_identification_pkey PRIMARY KEY (product_id, identity_type_id);


--
-- TOC entry 1956 (class 2606 OID 18561)
-- Dependencies: 1437 1437
-- Name: good_identity_type_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY good_identity_type
    ADD CONSTRAINT good_identity_type_pkey PRIMARY KEY (identity_type_id);


--
-- TOC entry 1993 (class 2606 OID 18924)
-- Dependencies: 1496 1496 1496
-- Name: inventory_item_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY inventory_item
    ADD CONSTRAINT inventory_item_pkey PRIMARY KEY (product_id, inventory_item_id);


--
-- TOC entry 1995 (class 2606 OID 18926)
-- Dependencies: 1496 1496 1496
-- Name: inventory_item_product_id_key; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY inventory_item
    ADD CONSTRAINT inventory_item_product_id_key UNIQUE (product_id, serial_no);


--
-- TOC entry 1999 (class 2606 OID 18945)
-- Dependencies: 1499 1499 1499 1499
-- Name: inventory_item_status_hist_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY inventory_item_status_hist
    ADD CONSTRAINT inventory_item_status_hist_pkey PRIMARY KEY (product_id, inventory_item_id, seq_no);


--
-- TOC entry 1997 (class 2606 OID 18935)
-- Dependencies: 1498 1498
-- Name: inventory_item_status_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY inventory_item_status
    ADD CONSTRAINT inventory_item_status_pkey PRIMARY KEY (inv_item_status_id);


--
-- TOC entry 2001 (class 2606 OID 18958)
-- Dependencies: 1500 1500 1500 1500
-- Name: inventory_item_variance_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY inventory_item_variance
    ADD CONSTRAINT inventory_item_variance_pkey PRIMARY KEY (product_id, inventory_item_id, seq_no);


--
-- TOC entry 2003 (class 2606 OID 18967)
-- Dependencies: 1502 1502
-- Name: inventory_variance_reason_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY inventory_variance_reason
    ADD CONSTRAINT inventory_variance_reason_pkey PRIMARY KEY (inv_var_reason_id);


--
-- TOC entry 2005 (class 2606 OID 18975)
-- Dependencies: 1503 1503
-- Name: lot_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY lot
    ADD CONSTRAINT lot_pkey PRIMARY KEY (lot_id);


--
-- TOC entry 1961 (class 2606 OID 18563)
-- Dependencies: 1438 1438
-- Name: price_component_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY price_component
    ADD CONSTRAINT price_component_pkey PRIMARY KEY (price_component_id);


--
-- TOC entry 1963 (class 2606 OID 18565)
-- Dependencies: 1439 1439 1439 1439
-- Name: prod_cat_class_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY prod_cat_class
    ADD CONSTRAINT prod_cat_class_pkey PRIMARY KEY (product_id, prod_cat_id, seq_no);


--
-- TOC entry 1965 (class 2606 OID 18567)
-- Dependencies: 1440 1440 1440
-- Name: prod_cat_rollup_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY prod_cat_rollup
    ADD CONSTRAINT prod_cat_rollup_pkey PRIMARY KEY (prod_cat_id_snr, prod_cat_id_jnr);


--
-- TOC entry 1967 (class 2606 OID 18569)
-- Dependencies: 1441 1441 1441 1441
-- Name: prod_feature_applicability_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY prod_feature_applicability
    ADD CONSTRAINT prod_feature_applicability_pkey PRIMARY KEY (product_id, prod_feature_id, seq_no);


--
-- TOC entry 1969 (class 2606 OID 18571)
-- Dependencies: 1442 1442 1442 1442
-- Name: prod_feature_interaction_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY prod_feature_interaction
    ADD CONSTRAINT prod_feature_interaction_pkey PRIMARY KEY (product_id, prod_feature_id_snr, prod_feature_id_jnr);


--
-- TOC entry 1973 (class 2606 OID 18573)
-- Dependencies: 1444 1444
-- Name: product_category_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (prod_cat_id);


--
-- TOC entry 1977 (class 2606 OID 18575)
-- Dependencies: 1446 1446
-- Name: product_feature_category_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_feature_category
    ADD CONSTRAINT product_feature_category_pkey PRIMARY KEY (prod_feature_cat_id);


--
-- TOC entry 1975 (class 2606 OID 18577)
-- Dependencies: 1445 1445
-- Name: product_feature_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product_feature
    ADD CONSTRAINT product_feature_pkey PRIMARY KEY (prod_feature_id);


--
-- TOC entry 1971 (class 2606 OID 18579)
-- Dependencies: 1443 1443
-- Name: product_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);


--
-- TOC entry 1979 (class 2606 OID 18581)
-- Dependencies: 1447 1447
-- Name: unit_of_measure_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY unit_of_measure
    ADD CONSTRAINT unit_of_measure_pkey PRIMARY KEY (uom_id);


--
-- TOC entry 1981 (class 2606 OID 18583)
-- Dependencies: 1448 1448
-- Name: uom_category_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY uom_category
    ADD CONSTRAINT uom_category_pkey PRIMARY KEY (uom_cat_id);


--
-- TOC entry 1983 (class 2606 OID 18585)
-- Dependencies: 1449 1449 1449
-- Name: uom_conversion_pkey; Type: CONSTRAINT; Schema: product; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY uom_conversion
    ADD CONSTRAINT uom_conversion_pkey PRIMARY KEY (uom_id_from, uom_id_to);


--
-- TOC entry 1957 (class 1259 OID 18661)
-- Dependencies: 1438
-- Name: price_component_index1; Type: INDEX; Schema: product; Owner: postgres; Tablespace: 
--

CREATE INDEX price_component_index1 ON price_component USING btree (product_id);


--
-- TOC entry 1958 (class 1259 OID 18662)
-- Dependencies: 1438
-- Name: price_component_index2; Type: INDEX; Schema: product; Owner: postgres; Tablespace: 
--

CREATE INDEX price_component_index2 ON price_component USING btree (prod_feature_id);


--
-- TOC entry 1959 (class 1259 OID 18663)
-- Dependencies: 1438
-- Name: price_component_index3; Type: INDEX; Schema: product; Owner: postgres; Tablespace: 
--

CREATE INDEX price_component_index3 ON price_component USING btree (prod_cat_id);


--
-- TOC entry 2008 (class 0 OID 0)
-- Dependencies: 9
-- Name: product; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA product FROM PUBLIC;
REVOKE ALL ON SCHEMA product FROM postgres;
GRANT ALL ON SCHEMA product TO postgres;
GRANT USAGE ON SCHEMA product TO PUBLIC;


--
-- TOC entry 2009 (class 0 OID 0)
-- Dependencies: 1489
-- Name: container; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE container FROM PUBLIC;
REVOKE ALL ON TABLE container FROM postgres;
GRANT ALL ON TABLE container TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE container TO PUBLIC;


--
-- TOC entry 2010 (class 0 OID 0)
-- Dependencies: 1491
-- Name: container_type; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE container_type FROM PUBLIC;
REVOKE ALL ON TABLE container_type FROM postgres;
GRANT ALL ON TABLE container_type TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE container_type TO PUBLIC;


--
-- TOC entry 2012 (class 0 OID 0)
-- Dependencies: 1493
-- Name: facility; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE facility FROM PUBLIC;
REVOKE ALL ON TABLE facility FROM postgres;
GRANT ALL ON TABLE facility TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE facility TO PUBLIC;


--
-- TOC entry 2014 (class 0 OID 0)
-- Dependencies: 1495
-- Name: facility_type; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE facility_type FROM PUBLIC;
REVOKE ALL ON TABLE facility_type FROM postgres;
GRANT ALL ON TABLE facility_type TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE facility_type TO PUBLIC;


--
-- TOC entry 2016 (class 0 OID 0)
-- Dependencies: 1436
-- Name: good_identification; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE good_identification FROM PUBLIC;
REVOKE ALL ON TABLE good_identification FROM postgres;
GRANT ALL ON TABLE good_identification TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE good_identification TO PUBLIC;


--
-- TOC entry 2017 (class 0 OID 0)
-- Dependencies: 1437
-- Name: good_identity_type; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE good_identity_type FROM PUBLIC;
REVOKE ALL ON TABLE good_identity_type FROM postgres;
GRANT ALL ON TABLE good_identity_type TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE good_identity_type TO PUBLIC;


--
-- TOC entry 2018 (class 0 OID 0)
-- Dependencies: 1496
-- Name: inventory_item; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE inventory_item FROM PUBLIC;
REVOKE ALL ON TABLE inventory_item FROM postgres;
GRANT ALL ON TABLE inventory_item TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE inventory_item TO PUBLIC;


--
-- TOC entry 2019 (class 0 OID 0)
-- Dependencies: 1498
-- Name: inventory_item_status; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE inventory_item_status FROM PUBLIC;
REVOKE ALL ON TABLE inventory_item_status FROM postgres;
GRANT ALL ON TABLE inventory_item_status TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE inventory_item_status TO PUBLIC;


--
-- TOC entry 2020 (class 0 OID 0)
-- Dependencies: 1499
-- Name: inventory_item_status_hist; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE inventory_item_status_hist FROM PUBLIC;
REVOKE ALL ON TABLE inventory_item_status_hist FROM postgres;
GRANT ALL ON TABLE inventory_item_status_hist TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE inventory_item_status_hist TO PUBLIC;


--
-- TOC entry 2022 (class 0 OID 0)
-- Dependencies: 1500
-- Name: inventory_item_variance; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE inventory_item_variance FROM PUBLIC;
REVOKE ALL ON TABLE inventory_item_variance FROM postgres;
GRANT ALL ON TABLE inventory_item_variance TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE inventory_item_variance TO PUBLIC;


--
-- TOC entry 2023 (class 0 OID 0)
-- Dependencies: 1502
-- Name: inventory_variance_reason; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE inventory_variance_reason FROM PUBLIC;
REVOKE ALL ON TABLE inventory_variance_reason FROM postgres;
GRANT ALL ON TABLE inventory_variance_reason TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE inventory_variance_reason TO PUBLIC;


--
-- TOC entry 2025 (class 0 OID 0)
-- Dependencies: 1503
-- Name: lot; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE lot FROM PUBLIC;
REVOKE ALL ON TABLE lot FROM postgres;
GRANT ALL ON TABLE lot TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE lot TO PUBLIC;


--
-- TOC entry 2026 (class 0 OID 0)
-- Dependencies: 1438
-- Name: price_component; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE price_component FROM PUBLIC;
REVOKE ALL ON TABLE price_component FROM postgres;
GRANT ALL ON TABLE price_component TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE price_component TO PUBLIC;


--
-- TOC entry 2027 (class 0 OID 0)
-- Dependencies: 1439
-- Name: prod_cat_class; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE prod_cat_class FROM PUBLIC;
REVOKE ALL ON TABLE prod_cat_class FROM postgres;
GRANT ALL ON TABLE prod_cat_class TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE prod_cat_class TO PUBLIC;


--
-- TOC entry 2028 (class 0 OID 0)
-- Dependencies: 1440
-- Name: prod_cat_rollup; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE prod_cat_rollup FROM PUBLIC;
REVOKE ALL ON TABLE prod_cat_rollup FROM postgres;
GRANT ALL ON TABLE prod_cat_rollup TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE prod_cat_rollup TO PUBLIC;


--
-- TOC entry 2029 (class 0 OID 0)
-- Dependencies: 1441
-- Name: prod_feature_applicability; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE prod_feature_applicability FROM PUBLIC;
REVOKE ALL ON TABLE prod_feature_applicability FROM postgres;
GRANT ALL ON TABLE prod_feature_applicability TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE prod_feature_applicability TO PUBLIC;


--
-- TOC entry 2030 (class 0 OID 0)
-- Dependencies: 1442
-- Name: prod_feature_interaction; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE prod_feature_interaction FROM PUBLIC;
REVOKE ALL ON TABLE prod_feature_interaction FROM postgres;
GRANT ALL ON TABLE prod_feature_interaction TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE prod_feature_interaction TO PUBLIC;


--
-- TOC entry 2031 (class 0 OID 0)
-- Dependencies: 1443
-- Name: product; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE product FROM PUBLIC;
REVOKE ALL ON TABLE product FROM postgres;
GRANT ALL ON TABLE product TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE product TO PUBLIC;


--
-- TOC entry 2032 (class 0 OID 0)
-- Dependencies: 1444
-- Name: product_category; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE product_category FROM PUBLIC;
REVOKE ALL ON TABLE product_category FROM postgres;
GRANT ALL ON TABLE product_category TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE product_category TO PUBLIC;


--
-- TOC entry 2033 (class 0 OID 0)
-- Dependencies: 1445
-- Name: product_feature; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE product_feature FROM PUBLIC;
REVOKE ALL ON TABLE product_feature FROM postgres;
GRANT ALL ON TABLE product_feature TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE product_feature TO PUBLIC;


--
-- TOC entry 2034 (class 0 OID 0)
-- Dependencies: 1446
-- Name: product_feature_category; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE product_feature_category FROM PUBLIC;
REVOKE ALL ON TABLE product_feature_category FROM postgres;
GRANT ALL ON TABLE product_feature_category TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE product_feature_category TO PUBLIC;


--
-- TOC entry 2035 (class 0 OID 0)
-- Dependencies: 1447
-- Name: unit_of_measure; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE unit_of_measure FROM PUBLIC;
REVOKE ALL ON TABLE unit_of_measure FROM postgres;
GRANT ALL ON TABLE unit_of_measure TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE unit_of_measure TO PUBLIC;


--
-- TOC entry 2036 (class 0 OID 0)
-- Dependencies: 1448
-- Name: uom_category; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE uom_category FROM PUBLIC;
REVOKE ALL ON TABLE uom_category FROM postgres;
GRANT ALL ON TABLE uom_category TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE uom_category TO PUBLIC;


--
-- TOC entry 2037 (class 0 OID 0)
-- Dependencies: 1449
-- Name: uom_conversion; Type: ACL; Schema: product; Owner: postgres
--

REVOKE ALL ON TABLE uom_conversion FROM PUBLIC;
REVOKE ALL ON TABLE uom_conversion FROM postgres;
GRANT ALL ON TABLE uom_conversion TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE uom_conversion TO PUBLIC;


-- Completed on 2006-12-16 19:46:54

--
-- PostgreSQL database dump complete
--

