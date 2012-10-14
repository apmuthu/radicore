SET search_path TO "menu";

ALTER TABLE menu.mnu_user ADD COLUMN party_id integer;

ALTER TABLE menu.mnu_task_field ADD COLUMN field_desc character varying(255);

