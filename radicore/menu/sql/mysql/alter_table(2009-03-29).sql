USE `menu`;

DELETE FROM mnu_initial_value_role WHERE field_id='EMAIL_FROM' AND task_id LIKE 'ord%';
DELETE FROM mnu_initial_value_user WHERE field_id='EMAIL_FROM' AND task_id LIKE 'ord%';
DELETE FROM mnu_task_field WHERE field_id='EMAIL_FROM' AND task_id LIKE 'ord%';
