-- USE `menu`;

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('List Answers' ,'Y' ,'2015-12-01 15:45:46' ,'AJM' ,'010' ,'srv_answer_option(list)' ,'srv_survey_question(list)');

UPDATE `mnu_nav_button` SET `revised_date`='2015-12-01 15:46:10' ,`revised_user`='AJM' ,`sort_seq`='010' WHERE task_id_snr='srv_survey_question(list)' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `button_text`='List Answer Options' ,`revised_date`='2015-12-01 15:46:10' ,`revised_user`='AJM' ,`sort_seq`='009' WHERE task_id_snr='srv_survey_question(list)' AND task_id_jnr='srv_answer_option(list)';

UPDATE `mnu_nav_button` SET `button_text`='Answer Options' ,`revised_date`='2015-12-01 15:46:45' ,`revised_user`='AJM' WHERE task_id_snr='srv_survey_question(list)' AND task_id_jnr='srv_answer_option(list)';

REPLACE INTO `mnu_nav_button` (`button_text` ,`context_preselect` ,`created_date` ,`created_user` ,`sort_seq` ,`task_id_jnr` ,`task_id_snr`) VALUES
('List Prompts' ,'Y' ,'2015-12-01 15:47:37' ,'AJM' ,'011' ,'srv_question_prompt(list)' ,'srv_survey_question(list)');

UPDATE `mnu_nav_button` SET `revised_date`='2015-12-01 15:48:02' ,`revised_user`='AJM' ,`sort_seq`='011' WHERE task_id_snr='srv_survey_question(list)' AND task_id_jnr='audit_dtl(list)3';

UPDATE `mnu_nav_button` SET `button_text`='Question Prompts' ,`revised_date`='2015-12-01 15:48:02' ,`revised_user`='AJM' ,`sort_seq`='010' WHERE task_id_snr='srv_survey_question(list)' AND task_id_jnr='srv_question_prompt(list)';
