ALTER SESSION SET CURRENT_SCHEMA = "AUDIT";

ALTER TABLE audit_ssn ADD (ssn_datetime TIMESTAMP);

UPDATE audit_ssn SET ssn_datetime=to_timestamp(ssn_date || ssn_time) WHERE ssn_datetime IS NULL;

ALTER TABLE AUDIT_SSN MODIFY (SSN_DATETIME NOT NULL);

CREATE INDEX AUDIT_SSN_DATETIME ON AUDIT_SSN (SSN_DATETIME ASC);

ALTER TABLE AUDIT_SSN DROP COLUMN SSN_DATE;
ALTER TABLE AUDIT_SSN DROP COLUMN SSN_TIME;


ALTER TABLE audit_trn ADD (trn_datetime TIMESTAMP);

UPDATE audit_trn SET trn_datetime=to_timestamp(trn_date || trn_time) WHERE trn_datetime IS NULL;

ALTER TABLE audit_trn MODIFY (TRN_DATETIME NOT NULL);

CREATE INDEX AUDIT_TRN_DATETIME ON AUDIT_TRN (TRN_DATETIME ASC);

ALTER TABLE audit_trn DROP COLUMN TRN_DATE;
ALTER TABLE audit_trn DROP COLUMN TRN_TIME;


------------



--

ALTER TABLE audit_trn ADD COLUMN trn_datetime DATETIME NULL AFTER trn_time;

UPDATE audit_trn SET trn_datetime=TIMESTAMP(trn_date, trn_time) WHERE trn_datetime IS NULL;

ALTER TABLE audit_trn ALTER trn_datetime DROP DEFAULT;
ALTER TABLE audit_trn CHANGE COLUMN trn_datetime trn_datetime DATETIME NOT NULL AFTER tran_seq_no;

ALTER TABLE audit_trn ADD INDEX trn_datetime (trn_datetime);

ALTER TABLE audit_trn DROP COLUMN trn_date;
ALTER TABLE audit_trn	DROP COLUMN trn_time;
