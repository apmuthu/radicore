USE `menu`;

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Update' ,'Y' ,'2009-08-07 14:10:45' ,'AJM' ,'004' ,'mnu_nav_button(upd1)' ,'mnu_nav_button(list2)a');

UPDATE `mnu_nav_button` SET `revised_date`='2009-08-07 14:11:13' ,`revised_user`='AJM' ,`sort_seq`='003' WHERE task_id_snr='mnu_nav_button(list2)a' AND task_id_jnr='mnu_nav_button(del2)';

UPDATE `mnu_nav_button` SET `revised_date`='2009-08-07 14:11:13' ,`revised_user`='AJM' ,`sort_seq`='004' WHERE task_id_snr='mnu_nav_button(list2)a' AND task_id_jnr='mnu_nav_button(search)';

UPDATE `mnu_nav_button` SET `revised_date`='2009-08-07 14:11:13' ,`revised_user`='AJM' ,`sort_seq`='002' WHERE task_id_snr='mnu_nav_button(list2)a' AND task_id_jnr='mnu_nav_button(upd1)';
