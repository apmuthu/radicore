-- USE `menu`;

REPLACE INTO `mnu_pattern` (`context_preselect` ,`created_date` ,`created_user` ,`keep_data` ,`pattern_desc` ,`pattern_id` ,`pattern_long_desc` ,`visible_screen`) VALUES
('N' ,'2012-11-19 10:13:28' ,'AJM' ,'N' ,'FILEPICKER2 - File Picker (remote)' ,'FILEPICKER2' ,'This will allow the user to select the name of a file which exists in a remote directory, which will be accessed using the FTP protocol.' ,'Y');

UPDATE `mnu_pattern` SET `pattern_desc`='FILEPICKER - File Picker (local)' ,`pattern_long_desc`='This will allow the user to select the name of a file which exists in a local directory.' ,`revised_date`='2012-11-19 10:14:22' ,`revised_user`='AJM' WHERE pattern_id='FILEPICKER';

UPDATE `mnu_pattern` SET `pattern_desc`='FILEDOWNLOAD - File Download (local)' ,`revised_date`='2012-11-19 17:00:28' ,`revised_user`='AJM' WHERE pattern_id='FILEDOWNLOAD';

REPLACE INTO `mnu_pattern` (`context_preselect` ,`created_date` ,`created_user` ,`keep_data` ,`pattern_desc` ,`pattern_id` ,`pattern_long_desc` ,`visible_screen`) VALUES
('Y' ,'2012-11-19 17:01:18' ,'AJM' ,'N' ,'FILEDOWNLOAD2 - File Download (remote)' ,'FILEDOWNLOAD2' ,'This will allow the user to download a file from a remote server (using FTP) to the client. The user selects an entity which contains the name of the file to be downloaded, then activates this transaction by pressing a navigation button.' ,'N');
