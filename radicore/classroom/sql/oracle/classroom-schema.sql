CREATE USER "CLASSROOM" IDENTIFIED BY "classroom";
GRANT CONNECT, RESOURCE TO "CLASSROOM";
GRANT CREATE DATABASE LINK TO "CLASSROOM";
GRANT CREATE MATERIALIZED VIEW TO "CLASSROOM";
GRANT CREATE PROCEDURE TO "CLASSROOM";
GRANT CREATE PUBLIC SYNONYM TO "CLASSROOM";
GRANT CREATE ROLE TO "CLASSROOM";
GRANT CREATE SEQUENCE TO "CLASSROOM";
GRANT CREATE SYNONYM TO "CLASSROOM";
GRANT CREATE TABLE TO "CLASSROOM";
GRANT CREATE TRIGGER TO "CLASSROOM";
GRANT CREATE TYPE TO "CLASSROOM";
GRANT CREATE VIEW TO "CLASSROOM";

ALTER SESSION SET CURRENT_SCHEMA = "CLASSROOM";

-- 
-- Table structure for table crs_class
-- 

CREATE TABLE crs_class (
  class_id varchar2(8) NOT NULL,
  class_name varchar2(40) NOT NULL,
  year number(1),
  class_notes clob,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (class_id)
);

REVOKE ALL ON crs_class FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON crs_class TO PUBLIC;

-- 
-- Table structure for table crs_class_lesson
-- 

CREATE TABLE crs_class_lesson (
  class_id varchar2(8) NOT NULL,
  lesson_id number(5) NOT NULL,
  PRIMARY KEY  (class_id,lesson_id)
);

REVOKE ALL ON crs_class_lesson FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON crs_class_lesson TO PUBLIC;

-- 
-- Table structure for table crs_conflict
-- 

CREATE TABLE crs_conflict (
  conflict_id number(10) NOT NULL,
  conflict_type char(1) NOT NULL,
  teacher_id number(5),
  student_id number(5),
  class_id varchar2(8),
  lesson_id1 number(5) NOT NULL,
  lesson_id2 number(5) NOT NULL,
  PRIMARY KEY  (conflict_id)
);
CREATE INDEX crs_conflict_idx1 ON crs_conflict (lesson_id1);

REVOKE ALL ON crs_conflict FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON crs_conflict TO PUBLIC;

-- 
-- Table structure for table crs_lesson
-- 

CREATE TABLE crs_lesson (
  lesson_id number(5) NOT NULL,
  lesson_name varchar2(40),
  lesson_short_name varchar2(30),
  year number(1),
  teacher_id number(5),
  lesson_notes clob,
  subject_id varchar2(8) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (lesson_id)
);

REVOKE ALL ON crs_lesson FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON crs_lesson TO PUBLIC;

-- 
-- Table structure for table crs_room
-- 

CREATE TABLE crs_room (
  room_id varchar2(8) NOT NULL,
  room_desc varchar2(40) NOT NULL,
  room_capacity number(2) NOT NULL,
  room_notes clob,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (room_id)
);

REVOKE ALL ON crs_room FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON crs_room TO PUBLIC;

-- 
-- Table structure for table crs_schedule
-- 

CREATE TABLE crs_schedule (
  schedule_id number(5) NOT NULL,
  seq_no number(5) NOT NULL,
  room_id varchar2(8) NOT NULL,
  day_no number(1) NOT NULL,
  start_time char(8) NOT NULL,
  end_time char(8) NOT NULL,
  lesson_id number(5) NOT NULL,
  is_valid char(1) default 'N' NOT NULL,
  schedule_errors clob,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (schedule_id,seq_no)
);

REVOKE ALL ON crs_schedule FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON crs_schedule TO PUBLIC;

-- 
-- Table structure for table crs_schedule_hdr
-- 

CREATE TABLE crs_schedule_hdr (
  schedule_id number(5) NOT NULL,
  schedule_desc varchar2(40) NOT NULL,
  schedule_notes clob,
  is_active char(1) default 'N' NOT NULL,
  start_time char(8) NOT NULL,
  end_time char(8) NOT NULL,
  last_day_no number(1) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (schedule_id)
);

REVOKE ALL ON crs_schedule_hdr FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON crs_schedule_hdr TO PUBLIC;

-- 
-- Table structure for table crs_student
-- 

CREATE TABLE crs_student (
  student_id number(5) NOT NULL,
  first_name varchar2(40) NOT NULL,
  last_name varchar2(40) NOT NULL,
  initials varchar2(4),
  year number(1),
  class_id varchar2(8),
  student_notes clob,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (student_id)
);

REVOKE ALL ON crs_student FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON crs_student TO PUBLIC;

-- 
-- Table structure for table crs_student_lesson
-- 

CREATE TABLE crs_student_lesson (
  student_id number(5) NOT NULL,
  lesson_id number(5) NOT NULL,
  PRIMARY KEY  (student_id,lesson_id)
);

REVOKE ALL ON crs_student_lesson FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON crs_student_lesson TO PUBLIC;

-- 
-- Table structure for table crs_subject
-- 

CREATE TABLE crs_subject (
  subject_id varchar2(8) NOT NULL,
  subject_name varchar2(80) NOT NULL,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (subject_id)
);

REVOKE ALL ON crs_subject FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON crs_subject TO PUBLIC;

-- 
-- Table structure for table crs_teacher
-- 

CREATE TABLE crs_teacher (
  teacher_id number(5) NOT NULL,
  first_name varchar2(40) NOT NULL,
  last_name varchar2(40) NOT NULL,
  initials varchar2(4),
  title varchar2(4),
  teacher_notes clob,
  created_date timestamp NOT NULL,
  created_user varchar2(16) default 'UNKNOWN' NOT NULL,
  revised_date timestamp,
  revised_user varchar2(16),
  PRIMARY KEY  (teacher_id)
);

REVOKE ALL ON crs_teacher FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON crs_teacher TO PUBLIC;
