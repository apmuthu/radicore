-- USE `menu`;

REPLACE INTO `mnu_pattern` (`context_preselect` ,`created_date` ,`created_user` ,`keep_data` ,`pattern_desc` ,`pattern_id` ,`pattern_long_desc` ,`visible_screen`) VALUES
('Y' ,'2013-10-17 13:39:29' ,'AJM' ,'N' ,'MULTI6 - Select/Modify multiple rows in a 3-level hierarchy' ,'MULTI6' ,'The top zone will act as a selection screen which will provide the selection criteria to populate the middle and inner zones with multiple occurrences.\n\nThe middle and inner zones are amendable by default, but can be made read-only.' ,'Y');

UPDATE `mnu_pattern` SET `pattern_desc`='MULTI5 - Select/Modify multiple rows in a 2-level hierarchy' ,`revised_date`='2013-10-26 15:35:24' ,`revised_user`='AJM' WHERE pattern_id ='MULTI5';

UPDATE `mnu_pattern` SET `pattern_desc`='LIST2 - List multiple records in a 2-level hierarchy' ,`revised_date`='2013-10-26 16:37:44' ,`revised_user`='AJM' WHERE pattern_id ='LIST2';

UPDATE `mnu_pattern` SET `pattern_desc`='LIST3 - List multiple records in a 3-level hierarchy' ,`revised_date`='2013-10-26 16:39:10' ,`revised_user`='AJM' WHERE pattern_id ='LIST3';
