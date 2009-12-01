SET search_path TO "menu";

ALTER TABLE menu.mnu_user ADD COLUMN user_timezone character varying(40);
