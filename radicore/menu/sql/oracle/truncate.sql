ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
SET SCAN OFF;

ALTER SESSION SET CURRENT_SCHEMA = "MENU";

TRUNCATE TABLE help_text;
TRUNCATE TABLE mnu_account;
TRUNCATE TABLE mnu_control;
TRUNCATE TABLE mnu_favourite;
TRUNCATE TABLE mnu_initial_value_role;
TRUNCATE TABLE mnu_initial_value_user;
TRUNCATE TABLE mnu_language;
TRUNCATE TABLE mnu_menu;
TRUNCATE TABLE mnu_motd;
TRUNCATE TABLE mnu_nav_button;
TRUNCATE TABLE mnu_pattern;
TRUNCATE TABLE mnu_role;
TRUNCATE TABLE mnu_role_task;
TRUNCATE TABLE mnu_role_taskfield;
TRUNCATE TABLE mnu_subsystem;
TRUNCATE TABLE mnu_task;
TRUNCATE TABLE mnu_task_field;
TRUNCATE TABLE mnu_task_ip_address;
TRUNCATE TABLE mnu_todo;
TRUNCATE TABLE mnu_user_ip_address;
