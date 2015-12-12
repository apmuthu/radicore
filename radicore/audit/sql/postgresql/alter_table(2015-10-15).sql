-- SET search_path TO "audit";

ALTER TABLE audit.audit_ssn ADD COLUMN ssn_datetime timestamp without time zone;

UPDATE audit_ssn SET ssn_datetime=(ssn_date + ssn_time) WHERE ssn_datetime IS NULL;

ALTER TABLE audit.audit_ssn ALTER COLUMN ssn_datetime SET NOT NULL;

CREATE INDEX audit_ssn_datetime ON audit.audit_ssn (ssn_datetime ASC NULLS LAST);

ALTER TABLE audit_ssn DROP COLUMN ssn_date;
ALTER TABLE audit_ssn DROP COLUMN ssn_time;

ALTER TABLE audit.audit_trn ADD COLUMN trn_datetime timestamp without time zone;

UPDATE audit_trn SET trn_datetime=(trn_date + trn_time) WHERE trn_datetime IS NULL;

ALTER TABLE audit.audit_trn ALTER COLUMN trn_datetime SET NOT NULL;

CREATE INDEX audit_trn_datetime ON audit.audit_trn (trn_datetime ASC NULLS LAST);

ALTER TABLE audit_trn DROP COLUMN trn_date;
ALTER TABLE audit_trn DROP COLUMN trn_time;
