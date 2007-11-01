
use `menu`;

UPDATE `mnu_menu` SET `menu_id`='applications' ,`revised_date`='2007-07-06 14:46:30' ,`revised_user`='AJM' WHERE menu_id='proto' AND task_id_jnr='product';

UPDATE `mnu_menu` SET `menu_id`='applications' ,`revised_date`='2007-07-06 14:46:30' ,`revised_user`='AJM' WHERE menu_id='proto' AND task_id_jnr='party';

UPDATE `mnu_menu` SET `menu_id`='applications' ,`revised_date`='2007-07-06 14:46:30' ,`revised_user`='AJM' WHERE menu_id='proto' AND task_id_jnr='order';

UPDATE `mnu_menu` SET `menu_id`='applications' ,`revised_date`='2007-07-06 14:46:30' ,`revised_user`='AJM' WHERE menu_id='proto' AND task_id_jnr='request';

UPDATE `mnu_menu` SET `menu_id`='applications' ,`revised_date`='2007-07-06 14:46:30' ,`revised_user`='AJM' WHERE menu_id='proto' AND task_id_jnr='shipment';

UPDATE `mnu_menu` SET `menu_id`='applications' ,`revised_date`='2007-07-06 14:46:31' ,`revised_user`='AJM' WHERE menu_id='proto' AND task_id_jnr='inventory';

UPDATE `mnu_menu` SET `menu_id`='applications' ,`revised_date`='2007-07-06 14:46:31' ,`revised_user`='AJM' WHERE menu_id='proto' AND task_id_jnr='invoicing';

UPDATE `mnu_menu` SET `revised_date`='2007-07-06 14:46:31' ,`revised_user`='AJM' ,`task_id_jnr`='applications' WHERE menu_id='main_menu' AND task_id_jnr='proto';

UPDATE `mnu_role` SET `revised_date`='2007-07-06 14:46:31' ,`revised_user`='AJM' ,`start_task_id`='applications' WHERE role_id='USER1';

UPDATE `mnu_role_task` SET `revised_date`='2007-07-06 14:46:31' ,`revised_user`='AJM' ,`task_id`='applications' WHERE role_id='USER1' AND task_id='proto';

UPDATE `mnu_role_task` SET `revised_date`='2007-07-06 14:46:31' ,`revised_user`='AJM' ,`task_id`='applications' WHERE role_id='USER2' AND task_id='proto';

UPDATE `mnu_role_task` SET `revised_date`='2007-07-06 14:46:31' ,`revised_user`='AJM' ,`task_id`='applications' WHERE role_id='USER3' AND task_id='proto';

UPDATE `mnu_task` SET `revised_date`='2007-07-06 14:46:32' ,`revised_user`='AJM' ,`task_id`='applications' WHERE task_id='proto';

UPDATE `mnu_task` SET `button_text`='APPL' ,`revised_date`='2007-07-06 14:47:09' ,`revised_user`='AJM' ,`task_desc`='Applications' WHERE task_id='applications';

UPDATE `mnu_menu` SET `button_text`='Applications' ,`revised_date`='2007-07-06 14:47:50' ,`revised_user`='AJM' WHERE menu_id='main_menu' AND task_id_jnr='applications';
