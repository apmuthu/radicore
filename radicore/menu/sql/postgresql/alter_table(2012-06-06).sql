SET search_path TO "menu";

ALTER TABLE menu.mnu_user ALTER COLUMN ip_address TYPE character varying(40);
