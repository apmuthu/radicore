-- SET search_path = 'audit';

ALTER TABLE php_session ALTER COLUMN session_id TYPE character varying (256);
