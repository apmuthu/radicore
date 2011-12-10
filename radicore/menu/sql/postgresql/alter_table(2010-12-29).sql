SET search_path TO "menu";

ALTER TABLE menu.mnu_favourite ADD COLUMN breadcrumbs character varying(4000);
