ALTER TABLE `help_text` CHANGE `task_id` `task_id` VARCHAR( 80 ) NOT NULL;
ALTER TABLE `mnu_menu` CHANGE `menu_id` `menu_id` VARCHAR( 80 ) NOT NULL;
ALTER TABLE `mnu_menu` CHANGE `task_id_jnr` `task_id_jnr` VARCHAR( 80 ) NOT NULL;
ALTER TABLE `mnu_nav_button` CHANGE `task_id_snr` `task_id_snr` VARCHAR( 80 ) NOT NULL;
ALTER TABLE `mnu_nav_button` CHANGE `task_id_jnr` `task_id_jnr` VARCHAR( 80 ) NOT NULL;
ALTER TABLE `mnu_role` CHANGE `start_task_id` `start_task_id` VARCHAR( 80 ) NOT NULL;
ALTER TABLE `mnu_role_task` CHANGE `task_id` `task_id` VARCHAR( 80 ) NOT NULL;
ALTER TABLE `mnu_role_taskfield` CHANGE `task_id` `task_id` VARCHAR( 80 ) NOT NULL;
ALTER TABLE `mnu_task` CHANGE `task_id` `task_id` VARCHAR( 80 ) NOT NULL;
ALTER TABLE `mnu_task_field` CHANGE `task_id` `task_id` VARCHAR( 80 ) NOT NULL;

ALTER TABLE `mnu_subsystem` CHANGE `subsys_id` `subsys_id` VARCHAR( 16 ) NOT NULL;
ALTER TABLE `mnu_task` CHANGE `subsys_id` `subsys_id` VARCHAR( 16 );
