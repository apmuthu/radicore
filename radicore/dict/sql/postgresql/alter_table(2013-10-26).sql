SET search_path TO "dict";

ALTER TABLE dict.dict_relationship ADD COLUMN key_name character varying(64) NOT NULL DEFAULT 'PRIMARY';

ALTER TABLE dict.dict_relationship ALTER COLUMN rel_type SET DEFAULT 'IGN'::bpchar;
