SET search_path TO "audit";

ALTER TABLE audit.audit_logon_errors ALTER COLUMN ip_address TYPE character varying(40);
