-- SET search_path TO "menu";

UPDATE mnu_language SET language_id=LOWER(language_id);

ALTER TABLE menu.mnu_user RENAME language_code  TO language_id;
