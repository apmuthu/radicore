ALTER SESSION SET CURRENT_SCHEMA = "MENU";

ALTER TABLE menu.mnu_initial_value_role MODIFY(initial_value VARCHAR2(255));
ALTER TABLE menu.mnu_initial_value_user MODIFY(initial_value VARCHAR2(255));
