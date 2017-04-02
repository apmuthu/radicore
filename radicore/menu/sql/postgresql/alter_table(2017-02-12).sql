-- SET search_path TO "menu";

ALTER TABLE mnu_user ADD COLUMN force_pswd_chg CHARACTER(1) DEFAULT 'N' NOT NULL;
