DELETE FROM
  mnu_subsystem
, mnu_task
, help_text
, mnu_favourite
, mnu_initial_value_role
, mnu_initial_value_user
, menu_snr
, menu_jnr
, nav_button_snr
, nav_button_jnr
, mnu_role
, mnu_role_task
, mnu_role_taskfield
, mnu_task_field
, mnu_task_ip_address
, mnu_todo
, mnu_control
USING mnu_subsystem
LEFT JOIN mnu_task ON (mnu_task.subsys_id=mnu_subsystem.subsys_id)
LEFT JOIN help_text ON (help_text.task_id=mnu_task.task_id)
LEFT JOIN mnu_favourite ON (mnu_favourite.task_id=mnu_task.task_id)
LEFT JOIN mnu_initial_value_role ON (mnu_initial_value_role.task_id=mnu_task.task_id)
LEFT JOIN mnu_initial_value_user ON (mnu_initial_value_user.task_id=mnu_task.task_id)
LEFT JOIN mnu_menu AS menu_snr ON (menu_snr.menu_id=mnu_task.task_id)
LEFT JOIN mnu_menu AS menu_jnr ON (menu_jnr.task_id_jnr=mnu_task.task_id)
LEFT JOIN mnu_nav_button AS nav_button_snr ON (nav_button_snr.task_id_snr=mnu_task.task_id)
LEFT JOIN mnu_nav_button AS nav_button_jnr ON (nav_button_jnr.task_id_jnr=mnu_task.task_id)
LEFT JOIN mnu_role ON (mnu_role.start_task_id=mnu_task.task_id)
LEFT JOIN mnu_role_task ON (mnu_role_task.task_id=mnu_task.task_id)
LEFT JOIN mnu_role_taskfield ON (mnu_role_taskfield.task_id=mnu_task.task_id)
LEFT JOIN mnu_task_field ON (mnu_task_field.task_id=mnu_task.task_id)
LEFT JOIN mnu_task_ip_address ON (mnu_task_ip_address.task_id=mnu_task.task_id)
LEFT JOIN mnu_todo ON (mnu_todo.task_id=mnu_task.task_id)
LEFT JOIN mnu_control ON (mnu_control.record_id=mnu_subsystem.subsys_id)

WHERE mnu_subsystem.subsys_id='CONTENT'