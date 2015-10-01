-- ALTER SESSION SET CURRENT_SCHEMA = "MENU";

UPDATE mnu_language SET language_id=LOWER(language_id) WHERE language_id IS NOT NULL;

alter table "MENU"."MNU_USER" rename column "LANGUAGE_CODE" to "LANGUAGE_ID";
