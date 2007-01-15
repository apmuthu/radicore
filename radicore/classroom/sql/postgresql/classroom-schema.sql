--
-- PostgreSQL database dump
--

-- Started on 2006-12-08 11:38:52

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 7 (class 2615 OID 17810)
-- Name: classroom; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA classroom;


ALTER SCHEMA classroom OWNER TO postgres;

SET search_path = classroom, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1412 (class 1259 OID 17867)
-- Dependencies: 1835 1836 1837 7
-- Name: crs_class; Type: TABLE; Schema: classroom; Owner: postgres; Tablespace: 
--

CREATE TABLE crs_class (
    class_id character varying(8) DEFAULT ''::character varying NOT NULL,
    class_name character varying(40) DEFAULT ''::character varying NOT NULL,
    "year" numeric(1,0),
    class_notes text,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE classroom.crs_class OWNER TO postgres;

--
-- TOC entry 1413 (class 1259 OID 17875)
-- Dependencies: 1838 1839 7
-- Name: crs_class_lesson; Type: TABLE; Schema: classroom; Owner: postgres; Tablespace: 
--

CREATE TABLE crs_class_lesson (
    class_id character varying(8) DEFAULT ''::character varying NOT NULL,
    lesson_id smallint DEFAULT (0)::smallint NOT NULL
);


ALTER TABLE classroom.crs_class_lesson OWNER TO postgres;

--
-- TOC entry 1414 (class 1259 OID 17879)
-- Dependencies: 1840 1841 1842 1843 7
-- Name: crs_conflict; Type: TABLE; Schema: classroom; Owner: postgres; Tablespace: 
--

CREATE TABLE crs_conflict (
    conflict_id integer DEFAULT 0 NOT NULL,
    conflict_type character(1) DEFAULT ''::bpchar NOT NULL,
    teacher_id smallint,
    student_id smallint,
    class_id character varying(8),
    lesson_id1 smallint DEFAULT (0)::smallint NOT NULL,
    lesson_id2 smallint DEFAULT (0)::smallint NOT NULL
);


ALTER TABLE classroom.crs_conflict OWNER TO postgres;

--
-- TOC entry 1415 (class 1259 OID 17885)
-- Dependencies: 1844 1845 1846 7
-- Name: crs_lesson; Type: TABLE; Schema: classroom; Owner: postgres; Tablespace: 
--

CREATE TABLE crs_lesson (
    lesson_id smallint DEFAULT (0)::smallint NOT NULL,
    lesson_name character varying(40),
    lesson_short_name character varying(30),
    "year" numeric(1,0),
    teacher_id smallint,
    lesson_notes text,
    subject_id character varying(8) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE classroom.crs_lesson OWNER TO postgres;

--
-- TOC entry 1416 (class 1259 OID 17893)
-- Dependencies: 1847 1848 1849 1850 7
-- Name: crs_room; Type: TABLE; Schema: classroom; Owner: postgres; Tablespace: 
--

CREATE TABLE crs_room (
    room_id character varying(8) DEFAULT ''::character varying NOT NULL,
    room_desc character varying(40) DEFAULT ''::character varying NOT NULL,
    room_capacity numeric(2,0) DEFAULT (0)::numeric NOT NULL,
    room_notes text,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE classroom.crs_room OWNER TO postgres;

--
-- TOC entry 1417 (class 1259 OID 17902)
-- Dependencies: 1851 1852 1853 1854 1855 1856 1857 1858 1859 7
-- Name: crs_schedule; Type: TABLE; Schema: classroom; Owner: postgres; Tablespace: 
--

CREATE TABLE crs_schedule (
    schedule_id smallint DEFAULT (0)::smallint NOT NULL,
    seq_no smallint DEFAULT (0)::smallint NOT NULL,
    room_id character varying(8) DEFAULT ''::character varying NOT NULL,
    day_no numeric(1,0) DEFAULT (0)::numeric NOT NULL,
    start_time time without time zone DEFAULT '00:00:00'::time without time zone NOT NULL,
    end_time time without time zone DEFAULT '00:00:00'::time without time zone NOT NULL,
    lesson_id smallint DEFAULT (0)::smallint NOT NULL,
    is_valid character(1) DEFAULT 'N'::bpchar NOT NULL,
    schedule_errors text,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE classroom.crs_schedule OWNER TO postgres;

--
-- TOC entry 1418 (class 1259 OID 17916)
-- Dependencies: 1860 1861 1862 1863 1864 7
-- Name: crs_schedule_hdr; Type: TABLE; Schema: classroom; Owner: postgres; Tablespace: 
--

CREATE TABLE crs_schedule_hdr (
    schedule_id smallint DEFAULT (0)::smallint NOT NULL,
    schedule_desc character varying(40),
    schedule_notes text,
    is_active character(1),
    start_time time without time zone DEFAULT '00:00:00'::time without time zone NOT NULL,
    end_time time without time zone DEFAULT '00:00:00'::time without time zone NOT NULL,
    last_day_no numeric(1,0) DEFAULT (0)::numeric NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE classroom.crs_schedule_hdr OWNER TO postgres;

--
-- TOC entry 1419 (class 1259 OID 17926)
-- Dependencies: 1865 1866 1867 1868 7
-- Name: crs_student; Type: TABLE; Schema: classroom; Owner: postgres; Tablespace: 
--

CREATE TABLE crs_student (
    student_id smallint DEFAULT (0)::smallint NOT NULL,
    first_name character varying(40) DEFAULT ''::character varying NOT NULL,
    last_name character varying(40) DEFAULT ''::character varying NOT NULL,
    initials character varying(4),
    "year" numeric(1,0),
    class_id character varying(8),
    student_notes text,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE classroom.crs_student OWNER TO postgres;

--
-- TOC entry 1420 (class 1259 OID 17935)
-- Dependencies: 1869 1870 7
-- Name: crs_student_lesson; Type: TABLE; Schema: classroom; Owner: postgres; Tablespace: 
--

CREATE TABLE crs_student_lesson (
    student_id smallint DEFAULT (0)::smallint NOT NULL,
    lesson_id smallint DEFAULT (0)::smallint NOT NULL
);


ALTER TABLE classroom.crs_student_lesson OWNER TO postgres;

--
-- TOC entry 1421 (class 1259 OID 17939)
-- Dependencies: 1871 1872 1873 7
-- Name: crs_subject; Type: TABLE; Schema: classroom; Owner: postgres; Tablespace: 
--

CREATE TABLE crs_subject (
    subject_id character varying(8) DEFAULT ''::character varying NOT NULL,
    subject_name character varying(80) DEFAULT ''::character varying NOT NULL,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE classroom.crs_subject OWNER TO postgres;

--
-- TOC entry 1422 (class 1259 OID 17944)
-- Dependencies: 1874 1875 1876 1877 7
-- Name: crs_teacher; Type: TABLE; Schema: classroom; Owner: postgres; Tablespace: 
--

CREATE TABLE crs_teacher (
    teacher_id smallint DEFAULT (0)::smallint NOT NULL,
    first_name character varying(40) DEFAULT ''::character varying NOT NULL,
    last_name character varying(40) DEFAULT ''::character varying NOT NULL,
    initials character varying(4),
    title character varying(4),
    teacher_notes text,
    created_date timestamp without time zone DEFAULT '2000-01-01 00:00:00'::timestamp without time zone NOT NULL,
    created_user character varying(16),
    revised_date timestamp without time zone,
    revised_user character varying(16)
);


ALTER TABLE classroom.crs_teacher OWNER TO postgres;

--
-- TOC entry 1881 (class 2606 OID 18495)
-- Dependencies: 1413 1413 1413
-- Name: crs_class_lesson_pkey; Type: CONSTRAINT; Schema: classroom; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY crs_class_lesson
    ADD CONSTRAINT crs_class_lesson_pkey PRIMARY KEY (class_id, lesson_id);


--
-- TOC entry 1879 (class 2606 OID 18497)
-- Dependencies: 1412 1412
-- Name: crs_class_pkey; Type: CONSTRAINT; Schema: classroom; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY crs_class
    ADD CONSTRAINT crs_class_pkey PRIMARY KEY (class_id);


--
-- TOC entry 1884 (class 2606 OID 18499)
-- Dependencies: 1414 1414
-- Name: crs_conflict_pkey; Type: CONSTRAINT; Schema: classroom; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY crs_conflict
    ADD CONSTRAINT crs_conflict_pkey PRIMARY KEY (conflict_id);


--
-- TOC entry 1886 (class 2606 OID 18501)
-- Dependencies: 1415 1415
-- Name: crs_lesson_pkey; Type: CONSTRAINT; Schema: classroom; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY crs_lesson
    ADD CONSTRAINT crs_lesson_pkey PRIMARY KEY (lesson_id);


--
-- TOC entry 1888 (class 2606 OID 18503)
-- Dependencies: 1416 1416
-- Name: crs_room_pkey; Type: CONSTRAINT; Schema: classroom; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY crs_room
    ADD CONSTRAINT crs_room_pkey PRIMARY KEY (room_id);


--
-- TOC entry 1892 (class 2606 OID 18505)
-- Dependencies: 1418 1418
-- Name: crs_schedule_hdr_pkey; Type: CONSTRAINT; Schema: classroom; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY crs_schedule_hdr
    ADD CONSTRAINT crs_schedule_hdr_pkey PRIMARY KEY (schedule_id);


--
-- TOC entry 1890 (class 2606 OID 18507)
-- Dependencies: 1417 1417 1417
-- Name: crs_schedule_pkey; Type: CONSTRAINT; Schema: classroom; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY crs_schedule
    ADD CONSTRAINT crs_schedule_pkey PRIMARY KEY (schedule_id, seq_no);


--
-- TOC entry 1896 (class 2606 OID 18509)
-- Dependencies: 1420 1420 1420
-- Name: crs_student_lesson_pkey; Type: CONSTRAINT; Schema: classroom; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY crs_student_lesson
    ADD CONSTRAINT crs_student_lesson_pkey PRIMARY KEY (student_id, lesson_id);


--
-- TOC entry 1894 (class 2606 OID 18511)
-- Dependencies: 1419 1419
-- Name: crs_student_pkey; Type: CONSTRAINT; Schema: classroom; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY crs_student
    ADD CONSTRAINT crs_student_pkey PRIMARY KEY (student_id);


--
-- TOC entry 1898 (class 2606 OID 18513)
-- Dependencies: 1421 1421
-- Name: crs_subject_pkey; Type: CONSTRAINT; Schema: classroom; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY crs_subject
    ADD CONSTRAINT crs_subject_pkey PRIMARY KEY (subject_id);


--
-- TOC entry 1900 (class 2606 OID 18515)
-- Dependencies: 1422 1422
-- Name: crs_teacher_pkey; Type: CONSTRAINT; Schema: classroom; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY crs_teacher
    ADD CONSTRAINT crs_teacher_pkey PRIMARY KEY (teacher_id);


--
-- TOC entry 1882 (class 1259 OID 18657)
-- Dependencies: 1414
-- Name: crs_conflict_index; Type: INDEX; Schema: classroom; Owner: postgres; Tablespace: 
--

CREATE INDEX crs_conflict_index ON crs_conflict USING btree (lesson_id1);


--
-- TOC entry 1903 (class 0 OID 0)
-- Dependencies: 7
-- Name: classroom; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA classroom FROM PUBLIC;
REVOKE ALL ON SCHEMA classroom FROM postgres;
GRANT ALL ON SCHEMA classroom TO postgres;
GRANT USAGE ON SCHEMA classroom TO PUBLIC;


--
-- TOC entry 1904 (class 0 OID 0)
-- Dependencies: 1412
-- Name: crs_class; Type: ACL; Schema: classroom; Owner: postgres
--

REVOKE ALL ON TABLE crs_class FROM PUBLIC;
REVOKE ALL ON TABLE crs_class FROM postgres;
GRANT ALL ON TABLE crs_class TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE crs_class TO PUBLIC;


--
-- TOC entry 1905 (class 0 OID 0)
-- Dependencies: 1413
-- Name: crs_class_lesson; Type: ACL; Schema: classroom; Owner: postgres
--

REVOKE ALL ON TABLE crs_class_lesson FROM PUBLIC;
REVOKE ALL ON TABLE crs_class_lesson FROM postgres;
GRANT ALL ON TABLE crs_class_lesson TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE crs_class_lesson TO PUBLIC;


--
-- TOC entry 1906 (class 0 OID 0)
-- Dependencies: 1414
-- Name: crs_conflict; Type: ACL; Schema: classroom; Owner: postgres
--

REVOKE ALL ON TABLE crs_conflict FROM PUBLIC;
REVOKE ALL ON TABLE crs_conflict FROM postgres;
GRANT ALL ON TABLE crs_conflict TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE crs_conflict TO PUBLIC;


--
-- TOC entry 1907 (class 0 OID 0)
-- Dependencies: 1415
-- Name: crs_lesson; Type: ACL; Schema: classroom; Owner: postgres
--

REVOKE ALL ON TABLE crs_lesson FROM PUBLIC;
REVOKE ALL ON TABLE crs_lesson FROM postgres;
GRANT ALL ON TABLE crs_lesson TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE crs_lesson TO PUBLIC;


--
-- TOC entry 1908 (class 0 OID 0)
-- Dependencies: 1416
-- Name: crs_room; Type: ACL; Schema: classroom; Owner: postgres
--

REVOKE ALL ON TABLE crs_room FROM PUBLIC;
REVOKE ALL ON TABLE crs_room FROM postgres;
GRANT ALL ON TABLE crs_room TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE crs_room TO PUBLIC;


--
-- TOC entry 1909 (class 0 OID 0)
-- Dependencies: 1417
-- Name: crs_schedule; Type: ACL; Schema: classroom; Owner: postgres
--

REVOKE ALL ON TABLE crs_schedule FROM PUBLIC;
REVOKE ALL ON TABLE crs_schedule FROM postgres;
GRANT ALL ON TABLE crs_schedule TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE crs_schedule TO PUBLIC;


--
-- TOC entry 1910 (class 0 OID 0)
-- Dependencies: 1418
-- Name: crs_schedule_hdr; Type: ACL; Schema: classroom; Owner: postgres
--

REVOKE ALL ON TABLE crs_schedule_hdr FROM PUBLIC;
REVOKE ALL ON TABLE crs_schedule_hdr FROM postgres;
GRANT ALL ON TABLE crs_schedule_hdr TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE crs_schedule_hdr TO PUBLIC;


--
-- TOC entry 1911 (class 0 OID 0)
-- Dependencies: 1419
-- Name: crs_student; Type: ACL; Schema: classroom; Owner: postgres
--

REVOKE ALL ON TABLE crs_student FROM PUBLIC;
REVOKE ALL ON TABLE crs_student FROM postgres;
GRANT ALL ON TABLE crs_student TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE crs_student TO PUBLIC;


--
-- TOC entry 1912 (class 0 OID 0)
-- Dependencies: 1420
-- Name: crs_student_lesson; Type: ACL; Schema: classroom; Owner: postgres
--

REVOKE ALL ON TABLE crs_student_lesson FROM PUBLIC;
REVOKE ALL ON TABLE crs_student_lesson FROM postgres;
GRANT ALL ON TABLE crs_student_lesson TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE crs_student_lesson TO PUBLIC;


--
-- TOC entry 1913 (class 0 OID 0)
-- Dependencies: 1421
-- Name: crs_subject; Type: ACL; Schema: classroom; Owner: postgres
--

REVOKE ALL ON TABLE crs_subject FROM PUBLIC;
REVOKE ALL ON TABLE crs_subject FROM postgres;
GRANT ALL ON TABLE crs_subject TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE crs_subject TO PUBLIC;


--
-- TOC entry 1914 (class 0 OID 0)
-- Dependencies: 1422
-- Name: crs_teacher; Type: ACL; Schema: classroom; Owner: postgres
--

REVOKE ALL ON TABLE crs_teacher FROM PUBLIC;
REVOKE ALL ON TABLE crs_teacher FROM postgres;
GRANT ALL ON TABLE crs_teacher TO postgres;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE crs_teacher TO PUBLIC;


-- Completed on 2006-12-08 11:38:52

--
-- PostgreSQL database dump complete
--

