SET search_path TO "dict";

ALTER TABLE dict.dict_table ADD COLUMN nameof_start_date character varying(40);
ALTER TABLE dict.dict_table ADD COLUMN nameof_end_date character varying(40);
