SET search_path TO "menu";

UPDATE mnu_control SET field_id='AUTHENTICATION' WHERE record_id='SYSTEM' AND field_id='RADIUS_AUTHENTICATION';
UPDATE mnu_control SET field_value='RADIUS' WHERE record_id='SYSTEM' AND field_id='AUTHENTICATION' AND field_value='Y';
UPDATE mnu_control SET field_value='INTERNAL' WHERE record_id='SYSTEM' AND field_id='AUTHENTICATION' AND field_value='N';

ALTER TABLE menu.mnu_role RENAME is_radius_auth_off  TO is_external_auth_off;
ALTER TABLE menu.mnu_user RENAME is_radius_auth_off  TO is_external_auth_off;
ALTER TABLE menu.mnu_user RENAME radius_id  TO external_id;
ALTER TABLE menu.mnu_user ALTER external_id TYPE character varying(255);

ALTER TABLE menu.mnu_task ADD COLUMN max_execution_time smallint;
