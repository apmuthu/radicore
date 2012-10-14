
USE `menu`;

UPDATE `mnu_task` SET `button_text`='View Order (PDF)' ,`revised_date`='2012-09-27 20:02:12' ,`revised_user`='AJM' WHERE task_id='ord_order_header_p(output3)';

USE `menu`;

UPDATE `mnu_task` SET `button_text`='Email Order (PDF)' ,`revised_date`='2012-09-27 20:02:27' ,`revised_user`='AJM' WHERE task_id='ord_order_header_p(output3)a';

USE `menu`;

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('Email Order (PDF)' ,'N' ,'2012-09-27 20:03:08' ,'AJM' ,'018' ,'ord_order_header_p(output3)a' ,'ord_order_header_p(list1)');

USE `menu`;

UPDATE `mnu_nav_button` SET `revised_date`='2012-09-27 20:03:38' ,`revised_user`='AJM' ,`sort_seq`='014' WHERE task_id_snr='ord_order_header_p(list1)' AND task_id_jnr='ord_order_header_p(output3)b';

USE `menu`;

UPDATE `mnu_nav_button` SET `revised_date`='2012-09-27 20:03:38' ,`revised_user`='AJM' ,`sort_seq`='015' WHERE task_id_snr='ord_order_header_p(list1)' AND task_id_jnr='ord_order_header_p(upd1)awap';

USE `menu`;

UPDATE `mnu_nav_button` SET `revised_date`='2012-09-27 20:03:38' ,`revised_user`='AJM' ,`sort_seq`='016' WHERE task_id_snr='ord_order_header_p(list1)' AND task_id_jnr='ord_order_header_p(upd4)sup3';

USE `menu`;

UPDATE `mnu_nav_button` SET `revised_date`='2012-09-27 20:03:38' ,`revised_user`='AJM' ,`sort_seq`='017' WHERE task_id_snr='ord_order_header_p(list1)' AND task_id_jnr='ord_order_extra_values(list2)';

USE `menu`;

UPDATE `mnu_nav_button` SET `revised_date`='2012-09-27 20:03:39' ,`revised_user`='AJM' ,`sort_seq`='018' WHERE task_id_snr='ord_order_header_p(list1)' AND task_id_jnr='audit_dtl(list)3';

USE `menu`;

UPDATE `mnu_nav_button` SET `context_preselect`='Y' ,`revised_date`='2012-09-27 20:03:39' ,`revised_user`='AJM' ,`sort_seq`='013' WHERE task_id_snr='ord_order_header_p(list1)' AND task_id_jnr='ord_order_header_p(output3)a';
