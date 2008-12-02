USE `menu`;

REPLACE INTO `mnu_pattern` (`context_preselect` ,`created_date` ,`created_user` ,`keep_data` ,`pattern_desc` ,`pattern_id` ,`pattern_long_desc` ,`visible_screen`) VALUES
('N' ,'2008-06-15 11:49:56' ,'AJM' ,'N' ,'OUTPUT4 - Output selected fields to a CSV file' ,'OUTPUT4' ,'This will extract all available rows from a database table and output selected fields to a CSV file which will be downloaded to the client device.

The user is first shown a list of available fields and asked to select which ones should be included in the output.

It will use any search criteria that is passed down from the calling screen.' ,'Y');
