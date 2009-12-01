SET search_path TO "audit";

ALTER TABLE audit.audit_logon_errors ALTER COLUMN user_id DROP NOT NULL;
ALTER TABLE audit.audit_logon_errors ADD COLUMN email_addr character varying(50);
