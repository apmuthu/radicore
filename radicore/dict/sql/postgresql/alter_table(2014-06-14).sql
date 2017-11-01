SET search_path TO "dict";

ALTER TABLE dict.dict_column ALTER COLUMN col_default TYPE character varying(255);
