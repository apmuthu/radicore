-- file created on July 24, 2017, 6:31 pm
    
REPLACE INTO `mnu_subsystem` (`subsys_id`, `subsys_name`, `subsys_desc`, `subsys_dir`, `task_prefix`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU', 'Menu and Security system', NULL, 'menu', 'mnu_', '2003-01-01 12:00:00', 'AJM', '2006-04-22 09:39:02', 'AJM');

REPLACE INTO `mnu_language` (`language_id`, `language_name`, `input_date_format`, `output_date_format`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('de', 'German (Germany) [de]', 'dd MMM yyyy', 'dd MMM yyyy', '2017-05-18 10:14:25', 'AJM', NULL, NULL);
REPLACE INTO `mnu_language` (`language_id`, `language_name`, `input_date_format`, `output_date_format`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('en', 'English [en] **default**', 'dd MMM yyyy', 'dd MMM yyyy', '2008-01-09 15:19:37', 'AJM', '2014-04-20 13:19:24', 'AJM');
REPLACE INTO `mnu_language` (`language_id`, `language_name`, `input_date_format`, `output_date_format`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('en-us', 'English (United States) [en_US]', 'MMM dd yyyy', 'MMM dd yyyy', '2014-04-27 14:54:49', 'AJM', NULL, NULL);
REPLACE INTO `mnu_language` (`language_id`, `language_name`, `input_date_format`, `output_date_format`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('es', 'Spanish (Spain) [es]', 'dd/mm/yyyy', 'dd/mm/yyyy', '2014-07-04 09:07:16', 'AJM', NULL, NULL);
REPLACE INTO `mnu_language` (`language_id`, `language_name`, `input_date_format`, `output_date_format`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('fr', 'French (France) [fr]', 'dd MMM yyyy', 'dd MMM yyyy', '2017-05-18 10:13:50', 'AJM', NULL, NULL);

REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADD1', 'ADD1 - Insert a single record', 'This will allow the user to add a single record to a database table.

This will call the \'insertRecord\' method just once.', 'Y', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:38:46', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADD2', 'ADD2 - Insert a single record', 'This will add an occurrence to the MANY entity in a ONE-to-MANY relationship with the primary key of the ONE entity being passed down from the previous screen.

This will call the \'insertRecord\' method just once.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:38:59', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADD3', 'ADD3 - Insert multiple records without user dialog', 'This will add records to the database without any dialog with the user.

It will use the primary key supplied by the previous screen and one or more primary keys selected in a popup screen which will be called next.

This uses repeated calls to the \'insertRecord\' method.', 'N', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2017-05-20 18:55:47', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADD4', 'ADD4 - Insert one or more records without user dialog', 'This will allow one or more database records to be created without any dialog with the user.

Details of the parent table are passed down in $where.

This will use the \'insertMultiple\' method.', 'N', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-10 22:33:14', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADD5', 'ADD5 - Insert mutiple records', 'This will allow several database records to be created from a single input screen.

Details of the parent table are passed down in $where.

This will use the \'insertMultiple\' method.', 'Y', 'Y', 'N', '2008-03-28 19:00:53', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'BATCH - Background process', 'This process will be run in the background as it may require to run longer than the limit available for web pages. The output will be stored in the LOGS directory.', 'N', 'N', 'N', '2008-11-24 11:39:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEL1', 'DEL1 - Delete a single record', 'This will delete a single record from the database using the primary key passed down by the previous screen.

This will call the \'deleteRecord\' method.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:39:45', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEL2', 'DEL2 - Delete multiple records without user dialog', 'This will delete multiple records one at a time using the primary keys passed down from the previous screen.

This uses the \'deleteMultiple\' method.', 'N', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-10-01 16:56:16', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEL3', 'DEL3 - Delete multiple records without user dialog', 'This will call the \'deleteSelection\' method to delete/update a selection of records using the primary keys passed down from the previous screen.', 'N', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-09-08 11:58:29', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEL4', 'DEL4 - Delete parent and children', 'This will allow the user to delete a single record from the parent table, plus all related occurrences from the child table.

The primary key(s) for the occurrence(s) on the parent table is passed down by the previous screen.

This will call the \'deleteRecord\' method.', 'Y', 'Y', 'N', '2006-03-11 14:28:33', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ENQ1', 'ENQ1 - Enquire a single record', 'This will read a single record from the database using the primary key passed down by the previous screen and display it to the user.

If multiple rows are selected then scrolling options will be provided.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:56:48', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ERASE1', 'ERASE1 - Delete a record and all child records', 'This will delete a single record from the database using the primary key passed down by the previous screen. It will also delete *ALL* related occurrences on child tables.

This will call the \'eraseRecord\' method.', 'Y', 'Y', 'N', '2005-12-06 17:40:51', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FILEDOWNLOAD', 'FILEDOWNLOAD - File Download (local)', 'This will allow the user to download a file from the server to the client. The user selects an entity which contains the name of the file to be downloaded, then activates this transaction by pressing a navigation button.', 'N', 'Y', 'N', '2006-07-26 17:01:40', 'AJM', '2012-11-19 17:00:28', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FILEDOWNLOAD2', 'FILEDOWNLOAD2 - File Download (remote)', 'This will allow the user to download a file from a remote server (using FTP) to the client. The user selects an entity which contains the name of the file to be downloaded, then activates this transaction by pressing a navigation button.', 'N', 'Y', 'N', '2012-11-19 17:01:18', 'AJM', '2012-11-19 17:06:49', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FILEPICKER', 'FILEPICKER - File Picker (local)', 'This will allow the user to select the name of a file which exists in a local directory.', 'Y', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2012-11-19 10:14:22', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FILEPICKER2', 'FILEPICKER2 - File Picker (remote)', 'This will allow the user to select the name of a file which exists in a remote directory, which will be accessed using the FTP protocol.', 'Y', 'N', 'N', '2012-11-19 10:13:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FILEUPLOAD', 'FILEUPLOAD - File Upload', 'This will allow the user to upload a file from the client to the server. The file can be limited to a range of file types and a maximum size.', 'Y', 'N', 'N', '2005-12-18 14:50:32', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('LINK1', 'LINK1 - Update LINK table', 'This deals with a ONE-to-MANY-to-ONE relationship where MANY indicates a yes/no link between both of the ONE tables.

This allows multiple occurrences of MANY to be created, modified or deleted in a single screen.

This will call the \'updateLinkData\' method.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('LIST1', 'LIST1 - List multiple records', 'This will list all available rows from a database table one page at a time with (usually) 10 rows in each page.

Links at the bottom of the page will allow the user to jump to the first/last/previous/next page.

The selection may be refined by using the SEARCH button. This will bring up another screen into which selection criteria can be entered.', 'Y', 'N', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:57:00', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('LIST2', 'LIST2 - List multiple records in a 2-level hierarchy', 'This will list rows of MANY in a ONE-to-MANY relationship one page at a time with (usually) 10 rows in each page.

The primary key of ONE will be passed down from the previous screen.

Links at the bottom of the page will allow the user to jump to the first/last/previous/next page.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2013-10-26 16:37:44', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('LIST3', 'LIST3 - List multiple records in a 3-level hierarchy', 'This will list rows of MANY(1) and MANY(2) in a ONE-to-MANY(1)-to-MANY(2) relationship.

MANY(1)-to-MANY(2) is another ONE-to-MANY relationship

The primary key of ONE will be passed down from the previous screen.

This will then be passed to MANY(1) for processing.

The primary key of MANY(1) will then be passed to MANY(2) for processing.

Links at the bottom of the page will allow the user to jump to the first/last/previous/next page.', 'Y', 'Y', 'N', '2005-06-22 23:17:59', 'AJM', '2013-10-26 16:39:10', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU', 'MENU - Display menu options', 'This will display a list of options and allow the user to select one.', 'Y', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:57:21', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MULTI1', 'MULTI1 - Update/Insert/delete multiple records', 'This will take a selection of primary keys and allow individual databases rows to be inserted, updated or deleted.

The identity of the row(s) to be processed is passed down from the previous screen, and scrolling between rows is controlled by the setScrollArray() and getScrollItem() methods

This will deal with one row at a time and will call either the \'insertRecord\', \'updateRecord\' or \'deleteRecord\' methods as appropriate.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2005-06-24 23:20:22', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MULTI2', 'MULTI2 - Modify multiple records in a 2-level hierarchy', 'This will allow multiple MANY occurrences in a ONE-to-MANY relationship to be modified in a single operation. 

The primary key of ONE is passed down from the previous screen.

This will call the \'updateMultiple\' method.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2005-06-24 23:31:18', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MULTI3', 'MULTI3 - Modify multiple records in a 3-level hierarchy', 'This will allow updates to multiple occurrences of the CHILD table in a GRANDPARENT-PARENT-CHILD relationship n a single operation. 

The primary key of GRANDPARENT is passed down from the previous screen.

Occurrences of PARENT will start at the first available, with a scrolling area providing hyperlinks/buttons to step forwards or backwards through the available occurrences.

Occurrences of CHILD will start at the first available page, with a pagination area providing hyperlinks/buttons to step forwards or backwards through the available occurrences.

This will call the \'updateMultiple\' method for the CHILD entity.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2005-06-24 23:31:30', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MULTI4', 'MULTI4 - Update both in a ONE-to-MANY relationship', 'This will allow multiple MANY occurrences in a ONE-to-MANY relationship to be modified in a single operation. 

The primary key of ONE is passed down from the previous screen.

This will call the \'updateMultiple\' method.', 'Y', 'Y', 'N', '2005-06-24 23:25:47', 'AJM', '2006-10-07 19:01:30', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MULTI5', 'MULTI5 - Select/Modify multiple rows in a 2-level hierarchy', 'The top zone will act as a selection screen which will provide the selection criteria to populate the bottom zone with multiple occurrences.

The bottom zone is amendable by default, but can be made read-only.', 'Y', 'Y', 'N', '2013-06-10 13:54:36', 'AJM', '2013-10-26 15:35:24', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MULTI6', 'MULTI6 - Select/Modify multiple rows in a 3-level hierarchy', 'The top zone will act as a selection screen which will provide the selection criteria to populate the middle and inner zones with multiple occurrences.

The middle and inner zones are amendable by default, but can be made read-only.', 'Y', 'Y', 'N', '2013-10-17 13:39:29', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('OTHER', 'Other - Miscellaneous - Undefined', 'This is for anything whch does not fall into any recognisable category.', 'N', 'N', 'N', '2007-01-10 18:21:02', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('OUTPUT1', 'OUTPUT1 - Output records to a CSV file', 'This will extract all available rows from a database table and output them to a CSV file which will be downloaded to the client device.

It will use any search criteria that is passed down from the calling screen.', 'N', 'N', 'N', '2006-08-11 16:49:59', 'AJM', '2006-08-11 17:01:35', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('OUTPUT2', 'OUTPUT2 - Output records to a PDF file (List view)', 'This will extract all available rows from a database table and output them to a PDF file which will be downloaded to the client device.

It will use any search criteria that is passed down from the calling screen.

List view produces column headings on the top of the page, with each database record taking up one line across the page.', 'N', 'N', 'N', '2006-08-13 11:11:04', 'AJM', '2006-08-16 22:29:20', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('OUTPUT3', 'OUTPUT3 - Output records to a PDF file (Detail view)', 'This will extract all available rows from a database table and output them to a PDF file which will be downloaded to the client device.

It will use any search criteria that is passed down from the calling screen.

Detail view produces one page per database record, one line per field, with labels on the left and values on the right.', 'N', 'N', 'N', '2006-08-14 13:30:18', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('OUTPUT4', 'OUTPUT4 - Output selected fields to a CSV file', 'This will extract all available rows from a database table and output selected fields to a CSV file which will be downloaded to the client device.

The user is first shown a list of available fields and asked to select which ones should be included in the output.

It will use any search criteria that is passed down from the calling screen.', 'Y', 'N', 'N', '2008-06-15 11:49:56', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('OUTPUT5', 'OUTPUT5 - Output records to a PDF file (Address Labels)', 'This will extract all available rows from a database table and output them to a PDF file which will be downloaded to the client device.

It will use any search criteria that is passed down from the calling screen.

Label view constructs one label from each database record, then prints several labels across each line.', 'N', 'N', 'N', '2011-08-24 10:11:16', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('OUTPUT6', 'OUTPUT6 - Output records  from a Tree View to a CSV file', 'This will extract all available rows from a database table in Tree View and output them to a CSV file which will be downloaded to the client device.

It will use any search criteria that is passed down from the calling screen.', 'N', 'N', 'N', '2014-06-26 11:30:07', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('POPUP1', 'POPUP1 - Choose records (uses LIST1)', 'This shows the user a list of available rows from a database table and allows the user to choose one (or more) for processing in the previous screen.

This uses the LIST1 pattern.', 'Y', 'N', 'Y', '2006-10-06 13:07:29', 'AJM', '2006-10-06 13:12:02', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('POPUP2', 'POPUP2 - Choose records (uses LIST2)', 'This shows the user a list of available rows from a database table and allows the user to choose one (or more) for processing in the previous screen.

This uses the LIST2 pattern.', 'Y', 'N', 'Y', '2006-10-06 13:08:16', 'AJM', '2006-10-06 13:12:05', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('POPUP3', 'POPUP3 - Choose records (uses TREE1)', 'This shows the user a list of available rows from a database table and allows the user to choose one (or more) for processing in the previous screen.

This uses the TREE1 pattern.', 'Y', 'N', 'Y', '2006-10-06 13:10:16', 'AJM', '2006-10-06 13:12:08', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('POPUP4', 'POPUP4 - Choose records (uses TREE2)', 'This shows the user a list of available rows from a database table and allows the user to choose one (or more) for processing in the previous screen.

This uses the TREE2 pattern.', 'Y', 'N', 'Y', '2006-10-06 13:10:45', 'AJM', '2006-10-06 13:12:11', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SRCH', 'SRCH - Enter selection criteria', 'This will show a blank detail screen and allow the user to specify search criteria that will then be returned to the previous screen for action.', 'Y', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2005-11-27 17:05:50', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('TIMETABLE1', 'TIMETABLE1 - List timetable for a selected entity', 'This will list rows of TIMETABLE/SCHEDUILE table for a selected entity. It will show the schedule for every day in the week.

The primary key of selected entity will be passed down from the previous screen.

Links at the bottom of the page will allow the user to jump to the first/last/previous/next page.', 'Y', 'Y', 'N', '2006-07-10 21:35:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('TREE1', 'TREE1 - List Tree Structure (similar to LIST1)', 'This will list nodes in a tree structure and allow the user to expand and contract nodes individually.

This uses a stand-alone TREE_NODE table.

This uses the \'getNodeData\' method to retrieve the data for the selected nodes.', 'Y', 'Y', 'Y', '2003-01-01 12:00:00', 'AJM', '2014-06-26 11:28:07', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('TREE2', 'TREE2 - List Tree Structure (similar to LIST2)', 'This will list nodes in a tree structure and allow the user to expand and contract nodes individually.

This uses the TREE_TYPE, TREE_LEVEL and TREE_NODE database tables so that different levels can be defined for different tree types.

The TREE_TYPE to be displayed will be passed down by the previous screen.

This uses the \'getNodeData\' method to retrieve the data for the selected nodes.', 'Y', 'Y', 'Y', '2003-01-01 12:00:00', 'AJM', '2014-06-26 11:28:27', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('UPD1', 'UPD1 - Update a single record', 'This will allow a single database record (row) to be displayed and updated.

The primary key of the row is passed down from the previous screen. If multiple rows are selected then scrolling options will be provided.

This will call the \'updateRecord\' method.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:43:21', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('UPD2', 'UPD2 - Update multiple records', 'This will update multiple rows in the database.

The rows are identified using a combination of values supplied by the previous screen plus values selected in a popup screen which will be called next.

This will call the \'updateSelection\' method.', 'N', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2007-04-15 15:18:45', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('UPD3', 'UPD3 - Update Control record', 'This will update multiple rows in a \'control\' table in the database.

Each row contains a \'field_id\' and a \'field_value\' column, and they are treated as searate fields from a sigle row. This design allows \'fields\' (rows) to be added or deleted at will without having to alter the structure of the table.

This will call the \'updateSelection\' method.', 'Y', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-28 11:56:43', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('UPD4', 'UPD4 - Update one or more records without user dialog', 'This will allow one or more database rows to be updated without being displayed.

The identity of the row(s) to be updated is passed down from the previous screen.

This will call the \'updateMultiple\' method.', 'N', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-28 12:37:18', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_name`, `pattern_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('UPD5', 'UPD5 - Insert/Update one or more records without user dialog', 'This will allow one or more database rows to be inserted or updated without being displayed.

The identity of the row(s) to be processed is passed down from the previous screen so that they can be assembled.

This will call the \'insertOrUpdate\' method which will check if each record currently exists, then insert or update as appropriate.', 'N', 'Y', 'N', '2007-04-15 15:33:17', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role` (`role_id`, `role_name`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AUDIT', 'AUDIT', NULL, 'main_menu', 'N', 'N', 'N', '2014-04-19 12:21:39', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role` (`role_id`, `role_name`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'batch', NULL, 'main_menu', 'N', 'N', 'N', '2014-06-05 15:55:19', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role` (`role_id`, `role_name`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'Demonstration Class', NULL, 'main_menu', 'N', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2009-07-22 00:55:33', 'AJM');
REPLACE INTO `mnu_role` (`role_id`, `role_name`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DICT-RO', 'DICT read_only', NULL, 'main_menu', 'N', 'N', 'N', '2014-04-19 12:21:11', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role` (`role_id`, `role_name`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('GLOBAL', 'Global Access', NULL, 'main_menu', 'Y', 'N', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role` (`role_id`, `role_name`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'MENU read-only', NULL, 'main_menu', 'N', 'Y', 'N', '2014-04-19 06:21:53', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role` (`role_id`, `role_name`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'Prototype Aplplications', NULL, 'proto', 'N', 'N', 'N', '2016-10-06 13:46:36', 'AJM', '2016-10-06 13:47:53', 'AJM');
REPLACE INTO `mnu_role` (`role_id`, `role_name`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SURVEY', 'SURVEY Supervisor', NULL, 'main_menu', 'N', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2014-04-20 10:22:10', 'AJM');
REPLACE INTO `mnu_role` (`role_id`, `role_name`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'Ordinary everyday User', NULL, 'main_menu', 'N', 'N', 'N', '2006-09-05 13:31:49', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role` (`role_id`, `role_name`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW', 'WORKFLOW', NULL, 'workflow', 'N', 'N', 'N', '2014-04-19 12:22:14', 'AJM', '2014-04-20 12:54:42', 'AJM');
REPLACE INTO `mnu_role` (`role_id`, `role_name`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'WORKFLOW read-only', NULL, 'workflow', 'N', 'N', 'N', '2014-04-20 12:47:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role` (`role_id`, `role_name`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('XAMPLE', 'Prototype Aplplications', NULL, 'proto', 'N', 'N', 'N', '2016-10-06 13:46:36', 'AJM', '2016-10-06 13:47:53', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('applications', 'Applications', NULL, 'Transix', 'MENU', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2005-05-05 17:45:29', 'AJM', '2013-04-19 15:02:10', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'applications', '2015-12-12 20:16:11', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'applications', '2014-04-19 08:55:54', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('logon', 'Logon screen', NULL, 'Logon', 'PROC', 'logon.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'Y', NULL, NULL, NULL, 'Y', '2005-07-20 15:00:06', 'AJM', '2017-05-29 10:15:31', 'MGR');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'logon', '2015-12-12 20:16:26', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'logon', '2014-04-19 08:55:55', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SURVEY', 'logon', '2009-01-29 16:05:47', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('logon', 'Welcome to the RADICORE Menu & Security system.

You must enter a valid user id and password before you can continue any further.

The password field is case-sensitive, so watch out for the \'caps lock\' key.

Refer to <a href="%root%/mnu_logon.html">Logon screen</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-11 15:43:01', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('main_menu', 'Main index page', NULL, 'Menu1', 'MENU', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'main_menu', '2014-04-24 05:15:04', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'main_menu', '2014-04-19 09:02:03', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SURVEY', 'main_menu', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu', 'Home Page', NULL, 'Home', 'PROC', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-08-18 12:19:08', 'AJM', '2017-05-29 10:15:38', 'MGR');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu', 'audit_logon_errors(list)', '003', 'Logon Errors', 'N', '2006-03-08 14:52:45', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu', 'batch_log(filepicker)', '007', 'Log Files', 'N', '2008-11-21 12:09:53', 'AJM', '2010-07-22 14:37:04', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu', 'mnu_favourite(list2)', '010', 'List Favourites', 'Y', '2010-07-20 10:35:15', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu', 'mnu_motd(list1)', '008', 'MOTD', 'N', '2009-05-05 18:24:05', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu', 'mnu_session(upd3)', '004', 'Session Data', 'N', '2006-04-06 19:39:09', 'AJM', '2007-09-10 11:53:31', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu', 'mnu_todo(list2)', '001', 'ToDo', 'N', '2005-07-31 15:35:03', 'AJM', '2007-09-10 15:12:37', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu', 'mnu_user(upd1)a', '002', 'Change Password', 'N', '2006-02-23 10:51:20', 'AJM', '2007-09-10 15:35:45', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AUDIT', 'menu', '2014-04-19 12:21:40', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'menu', '2014-06-05 15:55:19', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('CRSS', 'menu', '2014-04-19 06:11:04', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'menu', '2014-04-20 11:39:06', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DICT-RO', 'menu', '2014-04-19 12:21:12', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FLUBIT_ADMIN', 'menu', '2012-08-29 13:10:08', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('GLOBAL', 'menu', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'menu', '2014-04-19 06:21:54', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PRODUCT', 'menu', '2014-04-19 06:12:27', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'menu', '2016-10-06 13:46:36', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SURVEY', 'menu', '2004-10-08 16:12:31', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'menu', '2014-04-20 12:47:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('XAMPLE', 'menu', '2014-04-19 06:18:46', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu', 'This is the first page the user sees after passing through the logon screen. It is also the page that is shown whenever the user selects an option from the menu bar instead of the navigation bar.

Refer to <a href="%root%/mnu_menu.html">Menu/Home Page</a> for full details.', '2005-07-02 18:09:35', 'AJM', '2013-06-11 15:43:22', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'Menu System', NULL, 'Menu System', 'MENU', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'menu01', '2015-12-12 20:16:11', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'menu01', '2014-04-19 09:02:03', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SURVEY', 'menu01', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(add1)', 'Add Hosting Account', NULL, 'New', 'PROC', 'mnu_account(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2007-09-13 11:30:42', 'AJM', '2017-05-26 16:45:39', 'MGR');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(add1)', 'This will allow a new record to be added to the ACCOUNT table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href="%root%/mnu_account(add1).html">Add Account</a> for full details.', '2008-01-04 10:27:45', 'AJM', '2013-06-11 15:40:40', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(del1)', 'Delete Hosting Account', NULL, 'Delete', 'PROC', 'mnu_account(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2007-09-13 11:30:42', 'AJM', '2017-05-26 16:45:55', 'MGR');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(del1)', 'This will display a record from the ACCOUNT table and allow it to be deleted.

Refer to <a href="%root%/mnu_account(del1).html">Delete Account</a> for full details.', '2008-01-04 10:32:08', 'AJM', '2013-06-11 15:41:00', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(enq1)', 'Enquire Hosting Account', NULL, 'Read', 'PROC', 'mnu_account(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2007-09-13 11:30:42', 'AJM', '2017-05-26 16:46:13', 'MGR');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_account(enq1)', '2015-12-12 20:16:11', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_account(enq1)', '2014-04-19 08:55:55', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(enq1)', 'This will display the contents of a record from the ACCOUNT table.

Refer to <a href="%root%/mnu_account(enq1).html">Enquire Account</a> for full details.', '2008-01-04 10:33:41', 'AJM', '2013-06-11 15:41:13', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(list1)', 'List Hosting Account', NULL, 'Hosting Account', 'PROC', 'mnu_account(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2007-09-13 11:30:42', 'AJM', '2009-11-20 16:15:41', 'AJM');

REPLACE INTO `mnu_task_alt` (`task_id`, `language_id`, `task_name`, `task_desc`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(list1)', 'de', '[de] List Hosting Account', NULL, '[de] Hosting Account', '2017-05-18 10:15:33', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_alt` (`task_id`, `language_id`, `task_name`, `task_desc`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(list1)', 'es', '[es] List Hosting Account', NULL, '[es] Hosting Account', '2017-05-18 10:11:59', 'AJM', '2017-05-18 10:12:28', 'AJM');
REPLACE INTO `mnu_task_alt` (`task_id`, `language_id`, `task_name`, `task_desc`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(list1)', 'fr', '[fr] List Hosting Account', NULL, '[fr] Hosting Account', '2017-05-18 10:15:54', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-09-13 11:30:43', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(list1)', 'mnu_account(add1)', '001', 'New', 'N', '2007-09-13 11:30:43', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(list1)', 'mnu_account(del1)', '004', 'Delete', 'Y', '2007-09-13 11:30:43', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(list1)', 'mnu_account(enq1)', '002', 'Read', 'Y', '2007-09-13 11:30:43', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(list1)', 'mnu_account(search)', '005', 'Search', 'N', '2007-09-13 11:30:43', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(list1)', 'mnu_account(upd1)', '003', 'Update', 'Y', '2007-09-13 11:30:43', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_account(list1)', '2015-12-12 20:16:11', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_account(list1)', '2014-04-19 08:55:56', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(list1)', 'This will list records on the ACCOUNT table.

Refer to <a href="%root%/mnu_account(list1).html">List Account</a> for full details.', '2008-01-04 10:50:02', 'AJM', '2013-06-11 15:41:22', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(search)', 'Search Hosting Account', NULL, 'Search', 'PROC', 'mnu_account(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2007-09-13 11:30:43', 'AJM', '2017-05-26 16:46:29', 'MGR');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_account(search)', '2015-12-12 20:16:11', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_account(search)', '2014-04-19 08:55:56', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(search)', 'This will allow search criteria to be entered for the ACCOUNT table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/mnu_account(search).html">Search Account</a> for full details.', '2008-01-04 10:35:17', 'AJM', '2013-06-11 15:41:31', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(upd1)', 'Update Hosting Account', NULL, 'Update', 'PROC', 'mnu_account(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2007-09-13 11:30:42', 'AJM', '2017-05-26 16:46:53', 'MGR');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(upd1)', 'This will display the contents of a record from the ACCOUNT table and allow it to be updated. 

Refer to <a href="%root%/mnu_account(upd1).html">Update Account</a> for full details.', '2008-01-04 10:36:51', 'AJM', '2013-06-11 15:41:40', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'Maintain Menu Controls', NULL, 'Menu Controls', 'PROC', 'mnu_control(upd3).php', 'N', 'UPD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-25 16:44:05', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'audit_ssn(batch)delete', '001', 'Delete Audit data', 'N', '2012-01-24 16:29:15', 'AJM', '2012-01-24 16:30:07', 'AJM');

REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'AUTHENTICATION', NULL, 'N', '2009-02-10 11:26:05', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'DEFAULT_LANGUAGE', NULL, 'N', '2006-04-10 09:36:18', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'LOGIN_TYPE', NULL, 'N', '2009-02-10 11:28:12', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PAGINATION_WIDTH', NULL, 'N', '2009-02-10 11:23:14', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_CHANGE', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_COUNT', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_DAYS', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_ENCRYPT', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_FORMAT_DIGITS', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_FORMAT_LOWER', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_FORMAT_MINLEN', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_FORMAT_UPPER', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_HIDDEN', NULL, 'N', '2006-07-18 18:27:46', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_RETRIES', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_WARNING', NULL, 'N', '2006-04-10 09:36:40', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'RADIUS_AUTHENTICATION', NULL, 'N', '2008-01-31 18:47:17', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SCROLLING_WIDTH', NULL, 'N', '2009-02-10 11:23:23', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_END', NULL, 'N', '2006-04-17 09:30:12', 'AJM', '2007-09-10 10:44:38', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_FRIDAY', NULL, 'N', '2006-04-17 09:30:58', 'AJM', '2007-09-10 10:44:38', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_MONDAY', NULL, 'N', '2006-04-17 09:30:27', 'AJM', '2007-09-10 10:44:38', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_SATURDAY', NULL, 'N', '2006-04-17 09:31:05', 'AJM', '2007-09-10 10:44:38', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_START', NULL, 'N', '2006-04-17 09:30:06', 'AJM', '2007-09-10 10:44:38', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_SUNDAY', NULL, 'N', '2006-04-17 09:31:11', 'AJM', '2007-09-10 10:44:38', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_THURSDAY', NULL, 'N', '2006-04-17 09:30:51', 'AJM', '2007-09-10 10:44:38', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_TUESDAY', NULL, 'N', '2006-04-17 09:30:35', 'AJM', '2007-09-10 10:44:38', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_WARNING', NULL, 'N', '2006-04-17 09:30:20', 'AJM', '2007-09-10 10:44:38', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `is_documentation_only`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_WEDNESDAY', NULL, 'N', '2006-04-17 09:30:44', 'AJM', '2007-09-10 10:44:38', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', '2014-04-20 12:57:53', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'AUTHENTICATION', 'NED', '2009-02-10 11:35:36', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'DEFAULT_LANGUAGE', 'NED', '2006-04-11 16:55:37', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'LOGIN_TYPE', 'NED', '2009-02-10 11:35:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'PAGINATION_WIDTH', 'NED', '2009-02-10 11:35:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'PSWD_CHANGE', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'PSWD_COUNT', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'PSWD_DAYS', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'PSWD_ENCRYPT', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'PSWD_FORMAT_DIGITS', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'PSWD_FORMAT_LOWER', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'PSWD_FORMAT_MINLEN', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'PSWD_FORMAT_UPPER', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'PSWD_HIDDEN', 'NED', '2009-02-10 11:35:51', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'PSWD_RETRIES', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'PSWD_WARNING', 'NED', '2006-04-11 16:46:48', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'RADIUS_AUTHENTICATION', 'NED', '2008-01-31 18:48:16', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'SCROLLING_WIDTH', 'NED', '2009-02-10 11:35:52', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'SHUTDOWN_END', 'NED', '2006-04-17 09:32:43', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'SHUTDOWN_FRIDAY', 'NED', '2006-04-17 09:32:43', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'SHUTDOWN_MONDAY', 'NED', '2006-04-17 09:32:43', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'SHUTDOWN_SATURDAY', 'NED', '2006-04-17 09:32:44', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'SHUTDOWN_START', 'NED', '2006-04-17 09:32:44', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'SHUTDOWN_SUNDAY', 'NED', '2006-04-17 09:32:44', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'SHUTDOWN_THURSDAY', 'NED', '2006-04-17 09:32:44', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'SHUTDOWN_TUESDAY', 'NED', '2006-04-17 09:32:44', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'SHUTDOWN_WARNING', 'NED', '2006-04-17 09:32:44', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)', 'SHUTDOWN_WEDNESDAY', 'NED', '2006-04-17 09:32:25', 'AJM', '2007-09-10 10:44:34', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'This will allow global settings on the MENU CONTROL table to be changed.

Refer to <a href="%root%/mnu_control(upd3).html">Update Menu Control data</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-11 15:43:51', 'AJM');

REPLACE INTO `help_text_alt` (`task_id`, `language_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'de', 'This is German help text.', '2017-05-18 15:53:39', 'AJM', NULL, NULL);
REPLACE INTO `help_text_alt` (`task_id`, `language_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'es', 'This is Spanish help text.', '2017-05-18 15:55:09', 'AJM', NULL, NULL);
REPLACE INTO `help_text_alt` (`task_id`, `language_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'fr', 'This is French help text.', '2017-05-18 15:55:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)noedit', 'Enquire Menu Controls', NULL, 'Menu Controls', 'PROC', 'mnu_control(upd3).php', 'N', 'UPD3', 'MENU', NULL, NULL, NULL, 'main_noedit=Y', NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2009-02-10 11:47:06', 'AJM', '2017-05-26 16:48:10', 'MGR');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_control(upd3)noedit', '2015-12-12 20:16:27', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_control(upd3)noedit', '2014-04-19 08:56:19', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)noedit', 'This will allow global settings on the MENU CONTROL table to be viewed.

Refer to <a href="%root%/mnu_control(upd3).html">Update Menu Control data</a> for full details.', '2009-05-21 10:59:13', 'AJM', '2013-06-11 15:45:16', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(add2)', 'Add Favourites', NULL, 'New', 'PROC', 'mnu_favourite(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2010-07-20 10:30:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(add2)', '2014-06-05 15:55:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_favourite(add2)', '2014-04-19 06:21:59', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_favourite(add2)', '2016-10-06 13:46:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_favourite(add2)', '2014-04-20 12:48:02', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(add2)', 'This will allow a new record to be added to the FAVOURITE table.

Refer to <a href="%root%/mnu_favourite(add2).html">Add Favourite</a> for full details.', '2013-06-11 15:50:37', 'AJM', '2013-06-11 15:52:48', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(add4)', 'Add Default Favourites', NULL, 'New', 'PROC', 'mnu_favourite(add4).php', 'N', 'ADD4', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2010-07-30 11:38:34', 'AJM', '2010-07-30 12:06:08', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(add4)', '2014-06-05 15:55:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_favourite(add4)', '2014-04-19 06:21:59', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_favourite(add4)', '2016-10-06 13:46:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_favourite(add4)', '2014-04-20 12:48:02', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(del1)', 'Delete Favourites', NULL, 'Delete', 'PROC', 'mnu_favourite(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2010-07-20 10:30:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(del1)', '2014-06-05 15:55:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_favourite(del1)', '2014-04-19 06:21:59', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_favourite(del1)', '2016-10-06 13:46:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_favourite(del1)', '2014-04-20 12:48:02', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(del1)', 'This will allow a record to be deleted from the FAVOURITE table.

Refer to <a href="%root%/mnu_favourite(del1).html">Delete Favourite</a> for full details.', '2013-06-11 15:54:02', 'AJM', '2013-06-11 15:55:33', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(enq1)', 'Enquire Favourites', NULL, 'Read', 'PROC', 'mnu_favourite(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2010-07-20 10:30:51', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(enq1)', '2014-06-05 15:55:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_favourite(enq1)', '2015-12-12 20:16:27', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_favourite(enq1)', '2014-04-19 06:22:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_favourite(enq1)', '2016-10-06 13:46:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_favourite(enq1)', '2014-04-20 12:48:03', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(enq1)', 'This will display the contents of a record from the FAVOURITE table.

Refer to <a href="%root%/mnu_favourite(enq1).html">Enquire Favourite</a> for full details.', '2013-06-11 15:48:41', 'AJM', '2013-06-11 15:55:58', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'List Favourites by User', NULL, 'List Favourites', 'PROC', 'mnu_favourite(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2010-07-20 10:30:47', 'AJM', '2010-07-20 10:35:05', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'audit_dtl(list)3', '009', 'Audit Trail', 'Y', '2010-07-20 10:31:00', 'AJM', '2010-07-20 15:55:21', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'mnu_favourite(add2)', '001', 'New', 'N', '2010-07-20 10:30:56', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'mnu_favourite(del1)', '004', 'Delete', 'Y', '2010-07-20 10:30:59', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'mnu_favourite(enq1)', '002', 'Read', 'Y', '2010-07-20 10:30:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'mnu_favourite(search)', '005', 'Search', 'N', '2010-07-20 10:31:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'mnu_favourite(upd1)', '003', 'Update', 'Y', '2010-07-20 10:30:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'mnu_favourite(upd4)movedown', '007', 'Move Down', 'Y', '2010-07-20 14:32:55', 'AJM', '2010-07-20 14:33:26', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'mnu_favourite(upd4)moveup', '006', 'Move Up', 'Y', '2010-07-20 14:32:56', 'AJM', '2010-07-20 14:33:26', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'mnu_favourite(upd4)reseq', '008', 'Resequence', 'N', '2010-07-20 15:55:09', 'AJM', '2017-07-20 15:46:11', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(list2)', '2014-06-05 15:55:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_favourite(list2)', '2014-04-19 06:22:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_favourite(list2)', '2016-10-06 13:46:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_favourite(list2)', '2014-04-20 12:48:03', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'This will list the contents of the FAVOURITE table for a selected USER.

Refer to <a href="%root%/mnu_favourite(list2).html">List Favourite by User</a> for full details.', '2013-06-11 15:57:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(search)', 'Search Favourites', NULL, 'Search', 'PROC', 'mnu_favourite(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2010-07-20 10:30:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(search)', '2014-06-05 15:55:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_favourite(search)', '2014-04-19 06:22:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_favourite(search)', '2016-10-06 13:46:38', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_favourite(search)', '2014-04-20 12:48:03', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(search)', 'This will allow search criteria to be entered before listing the contents of the FAVOURITE table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/mnu_favourite(search).html">Search Favourites</a> for full details.', '2013-06-11 15:59:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(upd1)', 'Update Favourites', NULL, 'Update', 'PROC', 'mnu_favourite(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2010-07-20 10:30:53', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(upd1)', '2014-06-05 15:55:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_favourite(upd1)', '2014-04-19 06:22:01', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_favourite(upd1)', '2016-10-06 13:46:38', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_favourite(upd1)', '2014-04-20 12:48:04', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(upd1)', 'This will allow a record on the FAVOURITE table to be updated.

Refer to <a href="%root%/mnu_favourite(upd1).html">Update Favourite</a> for full details.', '2013-06-11 16:02:02', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(upd4)movedown', 'Move Favourite Down', NULL, 'Move Down', 'PROC', 'mnu_favourite(upd4)movedown.php', 'N', 'UPD4', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2010-07-20 14:31:43', 'AJM', '2010-07-20 14:34:14', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(upd4)movedown', '2014-06-05 15:55:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_favourite(upd4)movedown', '2014-04-19 06:22:01', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_favourite(upd4)movedown', '2016-10-06 13:46:38', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_favourite(upd4)movedown', '2014-04-20 12:48:04', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(upd4)moveup', 'Move Favourite Up', NULL, 'Move Up', 'PROC', 'mnu_favourite(upd4)moveup.php', 'N', 'UPD4', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2010-07-20 14:20:30', 'AJM', '2010-07-20 14:34:34', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(upd4)moveup', '2014-06-05 15:55:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_favourite(upd4)moveup', '2014-04-19 06:22:02', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_favourite(upd4)moveup', '2016-10-06 13:46:38', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_favourite(upd4)moveup', '2014-04-20 12:48:04', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(upd4)reseq', 'Resequence Favourites', NULL, 'Resequence', 'PROC', 'mnu_favourite(upd4)reseq.php', 'N', 'UPD4', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2010-07-20 15:54:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(upd4)reseq', '2014-06-05 15:55:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_favourite(upd4)reseq', '2014-04-19 06:22:02', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_favourite(upd4)reseq', '2016-10-06 13:46:38', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_favourite(upd4)reseq', '2014-04-20 12:48:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(add2)', 'Add Help Text (Alternative Language)', NULL, 'New', 'PROC', 'help_text_alt(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2012-11-17 15:03:56', 'AJM', '2012-12-29 12:56:55', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(add2)', 'This will allow a new record to be added to the HELP_TEXT_ALT table.

Refer to <a href="%root%/mnu_help_text_alt(add2).html">Add Help Text (Alternative Language)</a> for full details.', '2013-06-11 16:14:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(del1)', 'Delete Help Text (Alternative Language)', NULL, 'Delete', 'PROC', 'help_text_alt(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2012-11-17 15:03:57', 'AJM', '2012-12-29 12:57:04', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(del1)', 'This will allow a record to be deleted from the HELP_TEXT_ALT table.

Refer to <a href="%root%/mnu_help_text_alt(del1).html">Delete Help Text (Alternative Language)</a> for full details.', '2013-06-11 16:15:52', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(enq1)', 'Enquire Help Text (Alternative Language)', NULL, 'Read', 'PROC', 'help_text_alt(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2012-11-17 15:03:56', 'AJM', '2012-12-29 12:57:14', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_help_text_alt(enq1)', '2015-12-12 20:16:46', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_help_text_alt(enq1)', '2014-04-19 08:56:20', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(enq1)', 'This will allow a record on the HELP_TEXT_ALT tableto be viewed

Refer to <a href="%root%/mnu_help_text_alt(enq1).html">Enquire Help Text (Alternative Language)</a> for full details.', '2013-06-11 16:28:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(list2)', 'Maintain Alternative Languages for HELP_TEXT', NULL, 'Alternative Languages', 'PROC', 'help_text_alt(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2012-11-17 15:03:56', 'AJM', '2012-11-17 15:10:44', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2012-11-17 15:03:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(list2)', 'mnu_help_text_alt(add2)', '001', 'New', 'N', '2012-11-17 15:03:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(list2)', 'mnu_help_text_alt(del1)', '004', 'Delete', 'Y', '2012-11-17 15:03:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(list2)', 'mnu_help_text_alt(enq1)', '002', 'Read', 'Y', '2012-11-17 15:03:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(list2)', 'mnu_help_text_alt(search)', '005', 'Search', 'N', '2012-11-17 15:03:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(list2)', 'mnu_help_text_alt(upd1)', '003', 'Update', 'Y', '2012-11-17 15:03:57', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_help_text_alt(list2)', '2015-12-12 20:16:47', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_help_text_alt(list2)', '2014-04-19 09:02:04', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(list2)', 'This will allow the contents of the HELP_TEXT_ALT table for a selected TASK to be viewed.

This table holds help text in alternative languages.

Refer to <a href="%root%/mnu_help_text_alt(list2).html">Maintain Alternative Languages for HELP_TEXT</a> for full details.', '2013-06-11 16:11:57', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(search)', 'Search Help Text (Alternative Language)', NULL, 'Search', 'PROC', 'help_text_alt(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2012-11-17 15:03:57', 'AJM', '2012-12-29 12:57:26', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_help_text_alt(search)', '2015-12-12 20:16:47', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_help_text_alt(search)', '2014-04-19 09:02:04', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(search)', 'This will allow search criteria to be entered before listing the contents of the HELP_TEXT_ALT table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/mnu_help_text_alt(search).html">Search Help Text (Alternative Language)</a> for full details.', '2013-06-11 16:30:31', 'AJM', '2013-06-11 16:54:52', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(upd1)', 'Update Help Text (Alternative Language)', NULL, 'Update', 'PROC', 'help_text_alt(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2012-11-17 15:03:56', 'AJM', '2012-12-29 12:57:36', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(upd1)', 'This will allow a record on the HELP_TEXT_ALT table to be updated.

Refer to <a href="%root%/mnu_help_text_alt(upd1).html">Update Help Text (Alternative Language)</a> for full details.', '2013-06-11 16:33:46', 'AJM', '2013-06-11 16:55:03', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text(multi1)', 'Maintain Help Text', NULL, 'Help Text', 'PROC', 'help_text(multi1).php', 'N', 'MULTI1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 10:47:22', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text(multi1)', 'mnu_help_text_alt(list2)', '001', 'Alternative Languages', 'Y', '2012-11-17 15:08:01', 'AJM', '2012-11-17 15:11:08', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text(multi1)', 'This will allow the contents of the HELP TEXT table to be maintained.

Refer to <a href="%root%/mnu_help_text(multi1).html">Maintain Help Text</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-11 16:05:19', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_role(multi3)a', 'Maintain Initial Value (Role) by Task', NULL, 'Initial Values', 'PROC', 'mnu_initial_value_role(multi3)a.php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2007-05-05 19:14:19', 'AJM', '2007-05-05 19:17:24', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_role(multi3)a', 'mnu_role(search)', '001', 'Search Role', 'N', '2007-05-05 19:17:50', 'AJM', '2008-02-07 14:46:56', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_role(multi3)a', 'This will allow the contents of the INITIAL_VALUE_ROLE table to be maintained by Role for a selected Task.

These values are used during the creation of new records.

Refer to <a href="%root%/mnu_initial_value_role(multi3)a.html">Maintain Initial Values (Role) by Task</a> for full details.', '2007-05-08 10:34:16', 'AJM', '2013-06-11 17:13:48', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_role(multi3)b', 'Maintain Initial Value by Role', NULL, 'Initial Values', 'PROC', 'mnu_initial_value_role(multi3)b.php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2007-05-05 22:41:13', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_role(multi3)b', 'mnu_task(search)', '001', 'Search Task', 'N', '2007-05-05 22:41:52', 'AJM', '2008-02-07 14:45:32', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_role(multi3)b', 'This will allow the contents of the INITIAL_VALUE_ROLE table to be maintained by Task for a selected Role.

These values are used during the creation of new records.

Refer to <a href="%root%/mnu_initial_value_role(multi3)b.html">Maintain Initial Values (Task) by Role</a> for full details.', '2007-05-08 10:34:37', 'AJM', '2013-06-11 17:09:12', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_user(multi3)a', 'Maintain Initial Value (User) by Task', NULL, 'Initial Values', 'PROC', 'mnu_initial_value_user(multi3)a.php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2007-05-27 10:43:36', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_user(multi3)a', 'mnu_user(search)', '001', 'Search User', 'N', '2008-02-07 14:47:21', 'AJM', '2008-02-07 14:47:30', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_user(multi3)a', 'This will allow the contents of the INITIAL_VALUE_USER table to be maintained by User for a selected Task.

These values are used during the creation of new records.

Refer to <a href="%root%/mnu_initial_value_user(multi3)a.html">Maintain Initial Values (Task) by User</a> for full details.', '2007-05-27 22:01:13', 'AJM', '2013-06-11 17:19:37', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_user(multi3)b', 'Maintain Initial Value by User', NULL, 'Initial Values', 'PROC', 'mnu_initial_value_user(multi3)b.php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2007-05-27 10:42:45', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_user(multi3)b', 'mnu_task(search)', '001', 'Search Task', 'N', '2008-02-07 14:43:08', 'AJM', '2008-02-07 14:43:17', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_user(multi3)b', 'This will allow the contents of the INITIAL_VALUE_USER table to be maintained by Task for a selected User.

These values are used during the creation of new records.

Refer to <a href="%root%/mnu_initial_value_user(multi3)b.html">Maintain Initial Values (Task) by User</a> for full details.', '2007-05-27 22:03:03', 'AJM', '2013-06-11 17:20:59', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(add1)', 'Add Supported Languages', NULL, 'New', 'PROC', 'mnu_language(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2008-01-03 11:34:32', 'AJM', '2017-05-24 16:19:50', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(add1)', 'This will allow a new record to be added to the LANGUAGE table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href="%root%/mnu_language(add1).html">Add Language</a> for full details.', '2008-01-04 10:31:04', 'AJM', '2013-06-11 17:22:57', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(del1)', 'Delete Supported Languages', NULL, 'Delete', 'PROC', 'mnu_language(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2008-01-03 11:34:34', 'AJM', '2017-05-24 16:19:59', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(del1)', 'This will display a record from the LANGUAGE table and allow it to be deleted.

Refer to <a href="%root%/mnu_language(del1).html">Delete Language</a> for full details.', '2008-01-04 10:32:38', 'AJM', '2013-06-11 17:22:59', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(enq1)', 'Enquire Supported Languages', NULL, 'Read', 'PROC', 'mnu_language(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2008-01-03 11:34:33', 'AJM', '2017-05-24 16:20:07', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_language(enq1)', '2015-12-12 20:17:04', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_language(enq1)', '2014-04-19 09:01:30', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(enq1)', 'This will display the contents of a record from the LANGUAGE table.

Refer to <a href="%root%/mnu_language(enq1).html">Enquire Language</a> for full details.', '2008-01-04 10:34:05', 'AJM', '2013-06-11 17:23:01', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(list1)', 'List Supported Languages', NULL, 'Supported Languages', 'PROC', 'mnu_language(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2008-01-03 11:34:31', 'AJM', '2013-06-19 12:47:59', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2008-01-03 11:34:36', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(list1)', 'mnu_language(add1)', '001', 'New', 'N', '2008-01-03 11:34:35', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(list1)', 'mnu_language(del1)', '004', 'Delete', 'Y', '2008-01-03 11:34:36', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(list1)', 'mnu_language(enq1)', '002', 'Read', 'Y', '2008-01-03 11:34:35', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(list1)', 'mnu_language(search)', '005', 'Search', 'N', '2008-01-03 11:34:36', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(list1)', 'mnu_language(upd1)', '003', 'Update', 'Y', '2008-01-03 11:34:35', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_language(list1)', '2015-12-12 20:17:04', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_language(list1)', '2014-04-19 09:01:31', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(list1)', 'This will list records on the LANGUAGE table.

Refer to <a href="%root%/mnu_language(list1).html">List Language</a> for full details.', '2008-01-04 10:28:39', 'AJM', '2013-06-11 17:23:03', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(search)', 'Search Supported Languages', NULL, 'Search', 'PROC', 'mnu_language(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2008-01-03 11:34:34', 'AJM', '2017-05-24 16:20:14', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_language(search)', '2015-12-12 20:17:05', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_language(search)', '2014-04-19 09:01:17', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(search)', 'This will allow search criteria to be entered for the LANGUAGE table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/mnu_language(search).html">Search Language</a> for full details.', '2008-01-04 10:35:40', 'AJM', '2013-06-11 17:23:07', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(upd1)', 'Update Supported Languages', NULL, 'Update', 'PROC', 'mnu_language(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2008-01-03 11:34:33', 'AJM', '2017-05-24 16:20:22', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(upd1)', 'This will display the contents of a record from the LANGUAGE table and allow it to be updated. 

Refer to <a href="%root%/mnu_language(upd1).html">Update Language</a> for full details.', '2008-01-04 10:37:13', 'AJM', '2013-06-11 17:23:09', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(add3)', 'Add Menu Items', NULL, 'Insert', 'PROC', 'mnu_menu(add3).php', 'N', 'ADD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:25:55', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(add3)a', 'Add Menu Items', NULL, 'Insert', 'PROC', 'mnu_menu(add3)a.php', 'N', 'ADD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2007-08-12 17:56:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(del2)', 'Delete Menu Items', NULL, 'Delete', 'PROC', 'mnu_menu(del2).php', 'N', 'DEL2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:26:52', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(link1)', 'Maintain Menu Items (2)', NULL, 'Menu Items(2)', 'PROC', 'mnu_menu(link1).php', 'N', 'LINK1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:28:00', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(link1)', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:28:00', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(link1)', 'This will display the contents of the MENU table for a selected task of type \'menu\'.

Refer to <a href="%root%/mnu_menu(link1).html">Maintain Menu Items (2)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:19:05', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)', 'List Menu Items', NULL, 'Menu Items(3)', 'PROC', 'mnu_menu(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:28:50', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2004-04-09 11:58:45', 'AJM', '2007-08-12 17:28:50', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)', 'mnu_menu(add3)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:28:50', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)', 'mnu_menu(del2)', '003', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:28:50', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)', 'mnu_menu(search)', '004', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:28:50', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)', 'mnu_menu(upd1)', '002', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:30:55', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_menu(list2)', '2015-12-12 20:17:12', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_menu(list2)', '2014-04-19 09:01:08', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)', 'This will list records on the MENU table for a selected Task of type \'menu\'.

Refer to <a href="%root%/mnu_menu(list2).html">List Menu Items</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:19:17', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)a', 'List Menu Parents', NULL, 'Menu (Parents)', 'PROC', 'mnu_menu(list2)a.php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2007-08-12 17:38:48', 'AJM', '2007-08-12 17:40:21', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)a', 'mnu_menu(add3)a', '001', 'New', 'N', '2007-08-12 17:56:49', 'AJM', '2007-08-12 17:57:08', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)a', 'mnu_menu(del2)', '002', 'Delete', 'Y', '2007-08-12 17:38:48', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)a', 'mnu_menu(search)', '003', 'Search', 'N', '2007-08-12 17:38:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_menu(list2)a', '2015-12-12 20:17:13', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_menu(list2)a', '2014-04-19 09:01:08', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)a', 'This will list parent records on the MENU table for a selected Task of type \'menu\'.

Refer to <a href="%root%/mnu_menu(list2)a.html">List Menu Parents</a> for full details.', '2007-08-12 22:04:22', 'AJM', '2013-06-12 12:19:24', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(multi2)', 'Maintain Menu Items (1)', NULL, 'Menu Items(1)', 'PROC', 'mnu_menu(multi2).php', 'N', 'MULTI2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:29:47', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(multi2)', 'mnu_menu(add3)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:29:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(multi2)', 'mnu_menu(del2)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:29:47', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(multi2)', 'This will display the contents of the MENU table for a selected task of type \'menu\', with the ability to modify data on existing records.. 

Refer to <a href="%root%/mnu_menu(multi2).html">Maintain Menu Items (1)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:26:01', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(search)', 'Search Menu Items', NULL, 'Search', 'PROC', 'mnu_menu(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:30:19', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_menu(search)', '2015-12-12 20:17:17', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_menu(search)', '2014-04-19 09:01:08', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(search)', 'This will allow search criteria to be entered for the MENU table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/mnu_menu(search).html">Search Menu Items</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:26:33', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(upd1)', 'Update Menu Item', NULL, 'Update', 'PROC', 'mnu_menu(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:30:56', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(upd1)', 'This will display the contents of a record from the MENU table and allow it to be updated. 

Refer to <a href="%root%/mnu_menu(upd1).html">Update Menu Item</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:27:23', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(add1)', 'Add Message of the Day', NULL, 'New', 'PROC', 'mnu_motd(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2009-05-05 11:36:55', 'AJM', '2017-05-26 16:51:35', 'MGR');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(add1)', 'This will allow a new record to be added to the MOTD (Message Of The Day) table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href="%root%/mnu_motd(add1).html">Add MOD</a> for full details.', '2009-05-14 10:27:54', 'AJM', '2013-06-12 12:34:17', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(del1)', 'Delete Message of the Day', NULL, 'Delete', 'PROC', 'mnu_motd(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2009-05-05 11:36:57', 'AJM', '2017-05-26 16:51:53', 'MGR');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(del1)', 'This will display a record from the MOTD (Message Of The Day) table and allow it to be deleted.

Refer to <a href="%root%/mnu_motd(del1).html">Delete MOTD</a> for full details.', '2009-05-14 10:28:30', 'AJM', '2013-06-12 12:34:20', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(enq1)', 'Enquire Message of the Day', NULL, 'Read', 'PROC', 'mnu_motd(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2009-05-05 11:36:56', 'AJM', '2017-05-26 16:52:10', 'MGR');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_motd(enq1)', '2014-04-19 09:00:54', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(enq1)', 'This will display the contents of a record from the MOTD (Message Of The Day) table.

Refer to <a href="%root%/mnu_motd(enq1).html">Enquire MOTD</a> for full details.', '2009-05-14 10:29:03', 'AJM', '2013-06-12 12:34:22', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'List Message of the Day', NULL, 'MOTD', 'PROC', 'mnu_motd(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, 'curr_or_hist=\'C\'', NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2009-05-05 11:36:55', 'AJM', '2013-06-19 12:47:13', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2009-05-05 11:36:59', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'date(current)', '007', 'Current', 'N', '2009-05-06 10:30:33', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'date(historic)', '008', 'Historic', 'N', '2009-05-06 10:30:34', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'mnu_motd(add1)', '001', 'New', 'N', '2009-05-05 11:36:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'mnu_motd(del1)', '004', 'Delete', 'Y', '2009-05-05 11:36:59', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'mnu_motd(enq1)', '002', 'Read', 'Y', '2009-05-05 11:36:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'mnu_motd(search)', '005', 'Search', 'N', '2009-05-05 11:36:59', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'mnu_motd(upd1)', '003', 'Update', 'Y', '2009-05-05 11:36:58', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_motd(list1)', '2014-04-19 09:00:54', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'This will list records on the MOTD (Message Of The Day) table.

Refer to <a href="%root%/mnu_motd(list1).html">List MOTD</a> for full details.', '2009-05-14 10:29:33', 'AJM', '2013-06-12 12:34:24', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(search)', 'Search Message of the Day', NULL, 'Search', 'PROC', 'mnu_motd(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2009-05-05 11:36:57', 'AJM', '2017-05-26 16:52:30', 'MGR');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_motd(search)', '2014-04-19 09:00:55', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(search)', 'This will allow search criteria to be entered for the MOTD (Message Of The Day) table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/mnu_motd(search).html">Search MOTD</a> for full details.', '2009-05-14 10:30:06', 'AJM', '2013-06-12 12:34:27', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(show)', 'Show Message of the Day', NULL, 'MOTD', 'PROC', 'mnu_motd(show).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2009-05-05 17:32:47', 'AJM', '2017-05-26 16:52:43', 'MGR');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_motd(show)', '2014-06-05 15:55:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_motd(show)', '2014-04-19 06:21:55', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_motd(show)', '2016-10-06 13:46:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_motd(show)', '2014-04-20 12:47:59', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(show)', 'This will show unexpired records from the MOTD (Message Of The Day) table, latest first.

Refer to <a href="%root%/mnu_motd(show).html">Show MOTD</a> for full details.', '2009-05-14 10:31:46', 'AJM', '2013-06-12 12:34:29', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(upd1)', 'Update Message of the Day', NULL, 'Update', 'PROC', 'mnu_motd(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2009-05-05 11:36:56', 'AJM', '2017-05-26 16:52:57', 'MGR');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(upd1)', 'This will display the contents of a record from the MOTD (Message Of The Day) table and allow it to be updated. 

Refer to <a href="%root%/mnu_motd(upd1).html">Update MOTD</a> for full details.', '2009-05-14 10:30:36', 'AJM', '2013-06-12 12:34:30', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(add3)', 'Add Navigation Button', NULL, 'Insert', 'PROC', 'mnu_nav_button(add3).php', 'N', 'ADD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:19:06', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(add3)a', 'Add Navigation Button', NULL, 'Insert', 'PROC', 'mnu_nav_button(add3)a.php', 'N', 'ADD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2007-08-12 13:42:22', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(del2)', 'Delete Navigation Button', NULL, 'Delete', 'PROC', 'mnu_nav_button(del2).php', 'N', 'DEL2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:19:56', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(link1)', 'Maintain Navigation Buttons (2)', NULL, 'Navigation Button (2)', 'PROC', 'mnu_nav_button(link1).php', 'N', 'LINK1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:20:37', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(link1)', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:16:40', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(link1)', 'This will display the contents of the NAVIGATION BUTTON table for a selected Task. Each of these will appear in the navigation bar area when the task is selected.

Refer to <a href="%root%/mnu_nav_button(link1).html">Maintain Navigation Buttons (2)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:35:48', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)', 'List Navigation Buttons', NULL, 'Navigation Buttons (3)', 'PROC', 'mnu_nav_button(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:22:09', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2004-04-09 11:58:57', 'AJM', '2007-08-12 11:16:12', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)', 'mnu_nav_button(add3)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:16:12', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)', 'mnu_nav_button(del2)', '003', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:16:12', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)', 'mnu_nav_button(search)', '004', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:16:12', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)', 'mnu_nav_button(upd1)', '002', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:18:58', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_nav_button(list2)', '2014-04-19 09:00:38', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)', 'This will list records on the NAVIGATION BUTTON table for a selected TASK.

Refer to <a href="%root%/mnu_nav_button(list2).html">List Navigation Buttons</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:35:50', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)a', 'List Navigation Button Parents', NULL, 'Navigation Button (Parents)', 'PROC', 'mnu_nav_button(list2)a.php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2007-08-12 11:25:09', 'AJM', '2007-08-12 14:22:28', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)a', 'mnu_nav_button(add3)a', '001', 'New', 'N', '2007-08-12 14:29:06', 'AJM', '2007-08-12 18:55:55', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)a', 'mnu_nav_button(del2)', '003', 'Delete', 'Y', '2007-08-12 14:28:49', 'AJM', '2009-08-07 14:11:13', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)a', 'mnu_nav_button(search)', '004', 'Search', 'N', '2007-08-12 14:28:24', 'AJM', '2009-08-07 14:11:13', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)a', 'mnu_nav_button(upd1)', '002', 'Update', 'Y', '2009-08-07 14:10:45', 'AJM', '2009-08-07 14:11:13', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_nav_button(list2)a', '2014-04-19 09:00:39', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)a', 'This will list parent records on the NAVIGATION BUTTON table for a selected TASK.

Refer to <a href="%root%/mnu_nav_button(list2)a.html">List Navigation Button Parents</a> for full details.', '2007-08-12 18:27:39', 'AJM', '2013-06-12 12:35:52', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(multi2)', 'Maintain Navigation Buttons (1)', NULL, 'Navigation Button (1)', 'PROC', 'mnu_nav_button(multi2).php', 'N', 'MULTI2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:22:57', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(multi2)', 'mnu_nav_button(add3)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:17:10', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(multi2)', 'mnu_nav_button(del2)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:17:10', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(multi2)', 'This will display the contents of the NAVIGATION BUTTON table for a selected task. 

Refer to <a href="%root%/mnu_nav_button(multi2).html">Maintain Navigation Buttons (1)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:35:53', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(search)', 'Search Navigation Button', NULL, 'Search', 'PROC', 'mnu_nav_button(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:23:47', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_nav_button(search)', '2014-04-19 09:00:39', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(search)', 'This will allow search criteria to be entered for the NAVIGATION BUTTON table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/mnu_nav_button(search).html">Search Navigation Button</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:35:55', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(upd1)', 'Update Navigation Button', NULL, 'Update', 'PROC', 'mnu_nav_button(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:24:14', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(upd1)', 'This will display the contents of a record from the NAVIGATION BUTTON table and allow it to be updated. 

Refer to <a href="%root%/mnu_nav_button(upd1).html">Update Navigation Button</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:35:56', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(add1)', 'Add Pattern', NULL, 'Insert', 'PROC', 'mnu_pattern(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-24 15:31:48', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(add1)', 'This will allow a new record to be added to the PATTERN table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href="%root%/mnu_pattern(add1).html">Add Pattern</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:38:42', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(del1)', 'Delete Pattern', NULL, 'Delete', 'PROC', 'mnu_pattern(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-21 15:34:36', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(del1)', 'This will display a record from the PATTERN table and allow it to be deleted.

Refer to <a href="%root%/mnu_pattern(del1).html">Delete Pattern</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:38:44', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(enq1)', 'Enquire Pattern', NULL, 'Enquire', 'PROC', 'mnu_pattern(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-21 15:34:44', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_pattern(enq1)', '2014-04-19 09:00:39', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(enq1)', 'This will display the contents of a record from the PATTERN table.

Refer to <a href="%root%/mnu_pattern(enq1).html">Enquire Pattern</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:38:46', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'List Pattern', NULL, 'List Pattern', 'PROC', 'mnu_pattern(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'Y', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-27 10:27:11', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2004-04-09 11:37:12', 'AJM', '2007-09-10 10:55:34', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'mnu_pattern(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:58:00', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'mnu_pattern(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:02:18', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'mnu_pattern(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:03:25', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'mnu_pattern(pdf)', '008', 'Output to PDF(L)', 'N', '2006-08-16 22:19:25', 'AJM', '2007-09-10 10:55:34', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'mnu_pattern(pdf)2', '009', 'Output to PDF(D)', 'N', '2006-08-16 19:13:53', 'AJM', '2007-09-10 10:55:34', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'mnu_pattern(search)', '006', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:55:34', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'mnu_pattern(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:05:58', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'mnu_task(list2)a', '005', 'List Task', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:46:07', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_pattern(list1)', '2014-04-19 09:00:40', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'pattern_id', '1', 'Pattern Id', '2016-05-18 16:50:22', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'pattern_name', '2', 'Pattern Name', '2016-05-18 16:50:33', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'This will list records on the PATTERN table.

Refer to <a href="%root%/mnu_pattern(list1).html">List Pattern</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:38:49', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(pdf)', 'Output to PDF - List view', NULL, 'Output to PDF(L)', 'PROC', 'mnu_pattern(pdf).php', 'N', 'OUTPUT2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2006-08-16 22:18:49', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_pattern(pdf)', '2014-04-19 08:59:58', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(pdf)2', 'Output to PDF - Detail view', NULL, 'Output to PDF(D)', 'PROC', 'mnu_pattern(pdf)2.php', 'N', 'OUTPUT3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2006-08-16 19:13:24', 'AJM', '2006-08-16 22:18:12', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_pattern(pdf)2', '2014-04-19 08:59:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(search)', 'Search Pattern', NULL, 'Search', 'PROC', 'mnu_pattern(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-24 15:32:23', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_pattern(search)', '2014-04-19 08:59:59', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(search)', 'This will allow search criteria to be entered for the PATTERN table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/mnu_pattern(search).html">Search Pattern</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:38:51', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(upd1)', 'Update Pattern', NULL, 'Update', 'PROC', 'mnu_pattern(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-21 15:34:12', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(upd1)', 'This will display the contents of a record from the PATTERN table and allow it to be updated. 

Refer to <a href="%root%/mnu_pattern(upd1).html">Update Pattern</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:38:53', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_task(link1)a', 'Link Role(s) to selected Task', NULL, 'Task Access', 'PROC', 'mnu_role_task(link1)a.php', 'N', 'LINK1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:12:14', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_task(link1)a', 'mnu_role(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:12:14', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_task(link1)a', 'This will display the contents of the ROLE TASK table for a selected task and allow updates to be made.

Refer to <a href="%root%/mnu_role_task(link1)a.html">Link Role(s) to selected task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:45:50', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_task(link1)b', 'Link Task(s) to selected Role', NULL, 'Task Access', 'PROC', 'mnu_role_task(link1)b.php', 'N', 'LINK1', 'MENU', NULL, NULL, NULL, NULL, 'task_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:20:38', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_task(link1)b', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:20:38', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_task(link1)b', 'This will display the contents of the ROLE TASK table for a selected role and allow updates to be made.

Refer to <a href="%root%/mnu_role_task(link1)b.html">Link Task(s) to selected Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:45:52', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_taskfield(multi3)a', 'Maintain Field Access via Task', NULL, 'Field Access', 'PROC', 'mnu_role_taskfield(multi3)a.php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, 'mnu_task_field.field_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:26:03', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_taskfield(multi3)a', 'mnu_role(search)', '001', 'Search Role', 'N', '2007-02-09 13:46:15', 'AJM', '2007-09-10 11:26:03', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_taskfield(multi3)a', 'This will show the contents of the ROLE TASK FIELD table for a selected Task and allow changes to be made.

Refer to <a href="%root%/mnu_role_taskfield(multi3)a.html">Maintain Field Access via Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:48:59', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_taskfield(multi3)b', 'Maintain Field Access via Role', NULL, 'Field Access', 'PROC', 'mnu_role_taskfield(multi3)b.php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, 'mnu_task_field.field_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:30:42', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_taskfield(multi3)b', 'mnu_task(search)', '001', 'Search Task', 'N', '2007-02-09 12:03:36', 'AJM', '2007-09-10 11:30:42', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_taskfield(multi3)b', 'This will show the contents of the ROLE TASK FIELD table for a selected Role and allow changes to be made.

Refer to <a href="%root%/mnu_role_taskfield(multi3)b.html">Maintain Field Access via Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:49:02', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(add1)', 'Add Role', NULL, 'Insert', 'PROC', 'mnu_role(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-24 15:44:30', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(add1)', 'This will allow a new record to be added to the ROLE table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href="%root%/mnu_role(add1).html">Add Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:51:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(del1)', 'Delete Role', NULL, 'Delete', 'PROC', 'mnu_role(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-24 15:44:36', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(del1)', 'This will display a record from the ROLE table and allow it to be deleted.

Refer to <a href="%root%/mnu_role(del1).html">Delete Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:56:15', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(enq1)', 'Enquire Role', NULL, 'Enquire', 'PROC', 'mnu_role(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-24 15:44:44', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_role(enq1)', '2014-04-19 08:59:19', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(enq1)', 'This will display the contents of a record from the ROLE table.

Refer to <a href="%root%/mnu_role(enq1).html">Enquire Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:56:17', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(list1)', 'List Role', NULL, 'List Role', 'PROC', 'mnu_role(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'Y', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-28 09:54:36', 'MGR');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(list1)', 'audit_dtl(list)3', '012', 'Audit Trail', 'Y', '2004-04-09 11:37:40', 'AJM', '2013-04-21 16:52:27', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(list1)', 'mnu_initial_value_role(multi3)b', '008', 'Initial Values', 'Y', '2007-05-05 22:42:40', 'AJM', '2007-09-10 11:41:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(list1)', 'mnu_role_task(link1)b', '006', 'Task Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(list1)', 'mnu_role_taskfield(multi3)b', '007', 'Field Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(list1)', 'mnu_role(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(list1)', 'mnu_role(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(list1)', 'mnu_role(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(list1)', 'mnu_role(pdf)', '010', 'Output to PDF(L)', 'N', '2006-08-17 16:25:30', 'AJM', '2013-04-21 16:52:28', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(list1)', 'mnu_role(search)', '009', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(list1)', 'mnu_role(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:50:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(list1)', 'mnu_time_limit_role(list2)', '011', 'Time Limits', 'Y', '2013-04-21 16:51:48', 'AJM', '2013-04-21 16:53:11', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(list1)', 'mnu_user(list2)', '005', 'List User', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:27:06', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_role(list1)', '2014-04-19 08:59:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(list1)', 'role_id', '1', 'Role Id', '2016-05-18 16:51:06', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(list1)', 'role_name', '2', 'Role Name', '2016-05-18 16:51:17', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(list1)', 'This will list records on the ROLE table.

Refer to <a href="%root%/mnu_role(list1).html">List Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:56:20', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(pdf)', 'Output to PDF - List view', NULL, 'Output to PDF(L)', 'PROC', 'mnu_role(pdf).php', 'N', 'OUTPUT2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2006-08-17 16:25:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_role(pdf)', '2014-04-19 08:59:20', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(popup1)', 'Choose Role', NULL, 'Choose', 'PROC', 'mnu_role(popup1).php', 'N', 'POPUP1', 'MENU', NULL, NULL, NULL, NULL, 'role_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-04-14 15:04:39', 'AJM', '2017-05-28 09:03:41', 'MGR');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_role(popup1)', '2014-04-19 08:59:20', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(popup1)', 'This will list records on the ROLE table and allow one or more to be selected.

After selecting records please press the CHOOSE button.

Refer to <a href="%root%/mnu_role(popup1).html">Choose Role</a> for full details.', '2004-08-26 14:08:25', 'AJM', '2013-06-12 12:56:27', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(search)', 'Search Role', NULL, 'Search', 'PROC', 'mnu_role(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-24 15:44:04', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_role(search)', '2014-04-19 08:59:20', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(search)', 'This will allow search criteria to be entered for the ROLE table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/mnu_role(search).html">Search Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:56:30', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(upd1)', 'Update Role', NULL, 'Update', 'PROC', 'mnu_role(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-24 15:44:11', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(upd1)', 'This will display the contents of a record from the ROLE table and allow it to be updated. 

Refer to <a href="%root%/mnu_role(upd1).html">Update Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:56:38', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_saved_selection(del1)', 'Delete Saved Selection', NULL, 'Delete', 'PROC', 'mnu_saved_selection(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2015-11-20 09:23:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_saved_selection(enq1)', 'Enquire Saved Selection', NULL, 'Read', 'PROC', 'mnu_saved_selection(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2015-11-20 09:23:27', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_saved_selection(list1)', 'List Saved Selection', NULL, 'Saved Selection', 'PROC', 'mnu_saved_selection(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2015-11-20 09:23:26', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_saved_selection(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2015-11-20 09:23:30', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_saved_selection(list1)', 'mnu_saved_selection(del1)', '004', 'Delete', 'Y', '2015-11-20 09:23:29', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_saved_selection(list1)', 'mnu_saved_selection(enq1)', '002', 'Read', 'Y', '2015-11-20 09:23:29', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_saved_selection(list1)', 'mnu_saved_selection(search)', '005', 'Search', 'N', '2015-11-20 09:23:29', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_saved_selection(list1)', 'mnu_saved_selection(upd1)', '003', 'Update', 'Y', '2015-11-20 09:23:29', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_saved_selection(list2)', 'List Saved Selection by User', NULL, 'Saved Selections', 'PROC', 'mnu_saved_selection(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, 'selection_id desc', 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2017-07-24 18:04:26', 'AJM', '2017-07-24 18:07:20', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_saved_selection(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2017-07-24 18:04:33', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_saved_selection(list2)', 'mnu_saved_selection(del1)', '004', 'Delete', 'Y', '2017-07-24 18:04:31', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_saved_selection(list2)', 'mnu_saved_selection(enq1)', '002', 'Read', 'Y', '2017-07-24 18:04:30', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_saved_selection(list2)', 'mnu_saved_selection(search)', '005', 'Search', 'N', '2017-07-24 18:04:32', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_saved_selection(list2)', 'mnu_saved_selection(upd1)', '003', 'Update', 'Y', '2017-07-24 18:04:31', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_saved_selection(search)', 'Search Saved Selection', NULL, 'Search', 'PROC', 'mnu_saved_selection(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2015-11-20 09:23:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_saved_selection(upd1)', 'Update Saved Selection', NULL, 'Update', 'PROC', 'mnu_saved_selection(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2015-11-20 09:23:27', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_session(upd3)', 'Update Session Data', NULL, 'Session Data', 'PROC', 'mnu_session(upd3).php', 'N', 'UPD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2006-04-06 19:37:49', 'AJM', '2007-09-10 11:53:31', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_session(upd3)', '2014-04-19 13:07:20', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_session(upd3)', 'This will allow certain settings which are being used within the current session to be changed.

Refer to <a href="%root%/mnu_session(upd3).html">Update Session data</a> for full details.', '2006-04-07 11:22:29', 'AJM', '2013-06-12 12:57:19', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(add1)', 'Add Subsystem', NULL, 'Insert', 'PROC', 'mnu_subsystem(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-24 15:42:15', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(add1)', 'This will allow a new record to be added to the SUBSYSTEM table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href="%root%/mnu_subsystem(add1).html">Add Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:59:26', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(del1)', 'Delete Subsystem', NULL, 'Delete', 'PROC', 'mnu_subsystem(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-24 15:42:41', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(del1)', 'This will display a record from the SUBSYSTEM table and allow it to be deleted.

Refer to <a href="%root%/mnu_subsystem(del1).html">Delete Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:59:31', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(enq1)', 'Enquire Subsystem', NULL, 'Enquire', 'PROC', 'mnu_subsystem(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-24 15:42:48', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_subsystem(enq1)', '2014-04-19 08:59:21', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(enq1)', 'This will display the contents of a record from the SUBSYSTEM table.

Refer to <a href="%root%/mnu_subsystem(enq1).html">Enquire Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:59:33', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(erase)', 'Erase Subsystem', NULL, 'Erase', 'PROC', 'mnu_subsystem(erase1).php', 'N', 'ERASE1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '300', NULL, NULL, 'N', '2005-12-06 17:42:11', 'AJM', '2014-03-07 09:31:46', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(erase)', 'This will allow all the records on all associated tables for the selected Subsystem to be erased.

To proceed with the erase press SUBMIT, otherwise press CANCEL.

Refer to <a href="%root%/mnu_subsystem(erase).html">Erase Subsystem</a> for full details.', '2013-06-12 13:02:28', 'AJM', '2013-06-12 13:04:08', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'List Subsystem', NULL, 'List Subsystem', 'PROC', 'mnu_subsystem(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'Y', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-28 09:33:04', 'MGR');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'audit_dtl(list)3', '012', 'Audit Trail', 'Y', '2004-04-09 11:37:58', 'AJM', '2007-09-10 14:01:48', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'dict_database(list2)', '008', 'Databases', 'Y', '2017-05-12 13:27:31', 'AJM', '2017-05-12 13:27:48', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'mnu_subsystem(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:01:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'mnu_subsystem(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:01:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'mnu_subsystem(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:01:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'mnu_subsystem(erase)', '009', 'Erase', 'Y', '2005-12-06 17:42:42', 'AJM', '2007-09-10 14:01:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'mnu_subsystem(pdf)', '010', 'Output to PDF(L)', 'N', '2006-08-17 10:59:24', 'AJM', '2007-09-10 14:01:48', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'mnu_subsystem(search)', '006', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:01:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'mnu_subsystem(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:05:25', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'mnu_subsystem(upd4)build', '011', 'Build Directory', 'Y', '2006-09-28 11:09:48', 'AJM', '2007-09-10 14:01:48', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'mnu_subsystem(upd4)export', '007', 'Export', 'Y', '2005-07-15 21:13:05', 'AJM', '2007-09-10 14:09:21', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'mnu_task(list2)b', '005', 'List Task', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:48:19', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_subsystem(list1)', '2014-04-19 08:59:03', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'subsys_id', '1', 'Subsys Id', '2016-05-18 16:40:07', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'subsys_dir', '3', 'Subsys Dir', '2016-05-18 16:40:31', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'subsys_name', '2', 'Subsystem Name', '2016-05-18 16:40:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'task_prefix', '4', 'Task Prefix', '2016-05-18 16:40:43', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'This will list records on the SUBSYSTEM table.

Refer to <a href="%root%/mnu_subsystem(list1).html">List Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:04:16', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(pdf)', 'Output to PDF - List view', NULL, 'Output to PDF(L)', 'PROC', 'mnu_subsystem(pdf).php', 'N', 'OUTPUT2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2006-08-17 10:58:50', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_subsystem(pdf)', '2014-04-19 08:59:03', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(search)', 'Search Subsystem', NULL, 'Search', 'PROC', 'mnu_subsystem(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-24 15:42:55', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_subsystem(search)', '2014-04-19 08:59:04', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(search)', 'This will allow search criteria to be entered for the SUBSYSTEM table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/mnu_subsystem(search).html">Search Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:04:19', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(upd1)', 'Update Subsystem', NULL, 'Update', 'PROC', 'mnu_subsystem(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-24 15:43:06', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(upd1)', 'This will display the contents of a record from the SUBSYSTEM table and allow it to be updated. 

Refer to <a href="%root%/mnu_subsystem(upd1).html">Update Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:04:22', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(upd4)build', 'Build Subsystem Directory', NULL, 'Build', 'PROC', 'mnu_subsystem(upd4)build.php', 'N', 'UPD4', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2006-09-28 11:02:20', 'AJM', '2007-09-10 12:02:43', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(upd4)export', 'Export Subsystem', NULL, 'Export', 'PROC', 'mnu_subsystem(upd4)export.php', 'N', 'UPD4', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '600', NULL, NULL, 'N', '2005-07-15 21:12:39', 'AJM', '2017-07-21 16:14:13', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(add2)', 'Add Task (Alternative Language)', NULL, 'New', 'PROC', 'mnu_task_alt(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2013-01-01 13:34:24', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(add2)', 'This will allow a new record to be added to the TASK_ALT table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href="%root%/mnu_task_alt(add2).html">Add Task (Alternative Language)</a> for full details.', '2013-06-12 13:09:41', 'AJM', '2013-06-12 13:11:00', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(del1)', 'Delete Task (Alternative Language)', NULL, 'Delete', 'PROC', 'mnu_task_alt(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2013-01-01 13:34:26', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(del1)', 'This will allow a record to be deleted from the TASK_ALT table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href="%root%/mnu_task_alt(del1).html">Delete Task (Alternative Language)</a> for full details.', '2013-06-12 13:14:44', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(enq1)', 'Enquire Task (Alternative Language)', NULL, 'Read', 'PROC', 'mnu_task_alt(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2013-01-01 13:34:25', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task_alt(enq1)', '2014-04-19 08:59:04', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(enq1)', 'This will display the contents record from the TASK_ALT table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href="%root%/mnu_task_alt(enq1).html">Enquire Task (Alternative Language)</a> for full details.', '2013-06-12 13:17:47', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(list2)', 'Maintain Alternative Languages for TASK', NULL, 'Alternative Languages', 'PROC', 'mnu_task_alt(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2013-01-01 13:34:23', 'AJM', '2013-01-01 13:43:09', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2013-01-01 13:34:29', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(list2)', 'mnu_task_alt(add2)', '001', 'New', 'N', '2013-01-01 13:34:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(list2)', 'mnu_task_alt(del1)', '004', 'Delete', 'Y', '2013-01-01 13:34:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(list2)', 'mnu_task_alt(enq1)', '002', 'Read', 'Y', '2013-01-01 13:34:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(list2)', 'mnu_task_alt(search)', '005', 'Search', 'N', '2013-01-01 13:34:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(list2)', 'mnu_task_alt(upd1)', '003', 'Update', 'Y', '2013-01-01 13:34:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task_alt(list2)', '2014-04-19 08:58:43', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(list2)', 'This will list records on the TASK_ALT table for a selected TASK.

Refer to <a href="%root%/mnu_task_alt(list2).html">Maintain Alternative Language for Task</a> for full details.', '2013-06-12 13:22:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(search)', 'Search Task (Alternative Language)', NULL, 'Search', 'PROC', 'mnu_task_alt(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2013-01-01 13:34:27', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task_alt(search)', '2014-04-19 08:58:43', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(search)', 'This will allow search criteria to be entered for the TASK_ALT table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/mnu_task_alt(search).html">Search Task (Alternative Language)</a> for full details.', '2013-06-12 13:23:54', 'AJM', '2013-06-12 13:25:05', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(upd1)', 'Update Task (Alternative Language)', NULL, 'Update', 'PROC', 'mnu_task_alt(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2013-01-01 13:34:26', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(upd1)', 'This will display the contents of a record from the TASK_ALT table and allow it to be updated. 

Refer to <a href="%root%/mnu_task_alt(upd1).html">Update Task (Alternative Language)</a> for full details.', '2013-06-12 13:26:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(add2)', 'Add Task Field', NULL, 'New', 'PROC', 'mnu_task_field(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:21:52', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(add2)', 'This will allow a record to be added to the TASK FIELD table for a selected TASK.

Refer to <a href="%root%/mnu_task_field(add2).html">Add Task Field</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:35:57', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(del1)', 'Delete Task Field', NULL, 'Delete', 'PROC', 'mnu_task_field(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:22:57', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(del1)', 'This will display a record from the TASK FIELD table and allow it to be deleted.

Refer to <a href="%root%/mnu_task_field(del1).html">Delete Task Field</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:37:10', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(enq1)', 'Enquire Task Field', NULL, 'Read', 'PROC', 'mnu_task_field(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2008-02-27 16:28:01', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task_field(enq1)', '2014-04-19 08:58:44', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(enq1)', 'This will display the contents of a record from the TASK FIELD table.

Refer to <a href="%root%/mnu_task_field(enq1).html">Enquire Task Field</a> for full details.', '2009-12-05 10:30:50', 'AJM', '2013-06-12 13:37:41', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(list2)', 'List Task Field', NULL, 'List Fields', 'PROC', 'mnu_task_field(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, 'field_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:19:30', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-09 11:59:27', 'AJM', '2008-02-27 16:32:26', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(list2)', 'mnu_task_field(add2)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:21:52', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(list2)', 'mnu_task_field(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2008-02-27 16:37:08', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(list2)', 'mnu_task_field(enq1)', '002', 'Read', 'Y', '2008-02-27 16:28:34', 'AJM', '2008-02-27 16:28:57', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(list2)', 'mnu_task_field(search)', '005', 'Search', 'N', '2008-02-27 16:32:16', 'AJM', '2008-02-27 16:32:27', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(list2)', 'mnu_task_field(upd1)', '003', 'Update', 'Y', '2008-02-27 16:15:46', 'AJM', '2008-02-27 16:37:08', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task_field(list2)', '2014-04-19 08:58:44', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(list2)', 'This will list records on the TASK FIELD table for a selected TASK.

Refer to <a href="%root%/mnu_task_field(list2).html">List Task Field</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:37:44', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(search)', 'Search Task Field', NULL, 'Search', 'PROC', 'mnu_task_field(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2008-02-27 16:31:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task_field(search)', '2014-04-19 08:58:45', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(search)', 'This will allow search criteria to be entered for the TASK FIELD table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/mnu_task_field(search).html">SearchTask Field</a> for full details.', '2009-12-05 10:32:23', 'AJM', '2013-06-12 13:37:46', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(upd1)', 'Update Task Field', NULL, 'Update', 'PROC', 'mnu_task_field(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2008-02-27 16:15:00', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(upd1)', 'This will display the contents of a record from the TASK FIELD table and allow it to be updated. 

Refer to <a href="%root%/mnu_task_field(upd1).html">Update Task Field</a> for full details.', '2009-12-05 10:34:05', 'AJM', '2013-06-12 13:37:48', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(add2)', 'Add Task IP Address', NULL, 'New', 'PROC', 'mnu_task_ip_address(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2009-11-15 18:07:26', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(add2)', 'This will allow a new record to be added to the TASK_IP_ADDRESS table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href="%root%/mnu_task_ip_address(add2).html">Add Task IP Address</a> for full details.', '2009-12-05 10:35:14', 'AJM', '2013-06-12 13:47:11', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(del1)', 'Delete Task IP Address', NULL, 'Delete', 'PROC', 'mnu_task_ip_address(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2009-11-15 18:07:28', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(del1)', 'This will display a record from the TASK_IP_ADDRESS table and allow it to be deleted.

Refer to <a href="%root%/mnu_task_ip_address(del1).html">Delete Task IP Address</a> for full details.', '2009-12-05 10:36:30', 'AJM', '2013-06-12 13:46:04', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(enq1)', 'Enquire Task IP Address', NULL, 'Read', 'PROC', 'mnu_task_ip_address(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2009-11-15 18:07:26', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task_ip_address(enq1)', '2014-04-19 08:58:20', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(enq1)', 'This will display the contents of a record from the TASK_IP_ADDRESS table.

Refer to <a href="%root%/mnu_task_ip_address(enq1).html">Enquire Task IP Address</a> for full details.', '2009-12-05 10:37:31', 'AJM', '2013-06-12 13:46:11', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(list2)', 'List IP Address by Task', NULL, 'Task IP Address', 'PROC', 'mnu_task_ip_address(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2009-11-15 18:07:25', 'AJM', '2009-11-15 18:10:22', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2009-11-15 18:07:32', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(list2)', 'mnu_task_ip_address(add2)', '001', 'New', 'N', '2009-11-15 18:07:30', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(list2)', 'mnu_task_ip_address(del1)', '004', 'Delete', 'Y', '2009-11-15 18:07:31', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(list2)', 'mnu_task_ip_address(enq1)', '002', 'Read', 'Y', '2009-11-15 18:07:31', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(list2)', 'mnu_task_ip_address(search)', '005', 'Search', 'N', '2009-11-15 18:07:32', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(list2)', 'mnu_task_ip_address(upd1)', '003', 'Update', 'Y', '2009-11-15 18:07:31', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task_ip_address(list2)', '2014-04-19 08:58:20', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(list2)', 'This will list records on the TASK_IP_ADDRESS table for a selected Task.

Refer to <a href="%root%/mnu_task_ip_address(list2).html">List IP Address by Task</a> for full details.', '2009-12-05 10:38:49', 'AJM', '2013-06-12 13:46:13', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(search)', 'Search Task IP Address', NULL, 'Search', 'PROC', 'mnu_task_ip_address(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2009-11-15 18:07:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task_ip_address(search)', '2014-04-19 08:58:21', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(search)', 'This will allow search criteria to be entered for the TASK_IP_ADDRESS table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/mnu_task_ip_address(search).html">Search Task IP Address</a> for full details.', '2009-12-05 10:39:57', 'AJM', '2013-06-12 13:46:15', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(upd1)', 'Update Task IP Address', NULL, 'Update', 'PROC', 'mnu_task_ip_address(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2009-11-15 18:07:27', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(upd1)', 'This will display the contents of a record from the TASK_IP_ADDRESS table and allow it to be updated. 

Refer to <a href="%root%/mnu_task_ip_address(upd1).html">Update Task IP Address</a> for full details.', '2009-12-05 10:41:00', 'AJM', '2013-06-12 13:46:18', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch_alt(add2)', 'Add Task QuickSearch (Alternative Language)', NULL, 'New', 'PROC', 'mnu_task_quicksearch_alt(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2016-05-19 09:11:57', 'AJM', '2016-05-19 09:21:06', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch_alt(del1)', 'Delete Task QuickSearch (Alternative Language)', NULL, 'Delete', 'PROC', 'mnu_task_quicksearch_alt(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2016-05-19 09:12:01', 'AJM', '2016-05-19 09:21:17', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch_alt(enq1)', 'Enquire Task QuickSearch (Alternative Language)', NULL, 'Read', 'PROC', 'mnu_task_quicksearch_alt(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2016-05-19 09:11:58', 'AJM', '2016-05-19 09:21:29', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch_alt(list2)', 'Maintain Alternative Languages for TASK_QUICKSEARCH', NULL, 'Alternative Languages', 'PROC', 'mnu_task_quicksearch_alt(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2016-05-19 09:11:56', 'AJM', '2016-05-19 09:20:09', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch_alt(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2016-05-19 09:12:06', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch_alt(list2)', 'mnu_task_quicksearch_alt(add2)', '001', 'New', 'N', '2016-05-19 09:12:03', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch_alt(list2)', 'mnu_task_quicksearch_alt(del1)', '004', 'Delete', 'Y', '2016-05-19 09:12:05', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch_alt(list2)', 'mnu_task_quicksearch_alt(enq1)', '002', 'Read', 'Y', '2016-05-19 09:12:04', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch_alt(list2)', 'mnu_task_quicksearch_alt(search)', '005', 'Search', 'N', '2016-05-19 09:12:05', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch_alt(list2)', 'mnu_task_quicksearch_alt(upd1)', '003', 'Update', 'Y', '2016-05-19 09:12:04', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch_alt(search)', 'Search Task QuickSearch (Alternative Language)', NULL, 'Search', 'PROC', 'mnu_task_quicksearch_alt(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2016-05-19 09:12:02', 'AJM', '2016-05-19 09:21:38', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch_alt(upd1)', 'Update Task QuickSearch (Alternative Language)', NULL, 'Update', 'PROC', 'mnu_task_quicksearch_alt(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2016-05-19 09:11:59', 'AJM', '2016-05-19 09:21:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch(add2)', 'Add QuickSearch option', NULL, 'New', 'PROC', 'mnu_task_quicksearch(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2016-05-18 15:24:40', 'AJM', '2016-05-18 15:30:39', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch(del1)', 'Delete QuickSearch option', NULL, 'Delete', 'PROC', 'mnu_task_quicksearch(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2016-05-18 15:24:43', 'AJM', '2016-05-18 15:30:54', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch(enq1)', 'Enquire QuickSearch option', NULL, 'Read', 'PROC', 'mnu_task_quicksearch(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2016-05-18 15:24:41', 'AJM', '2016-05-18 15:31:08', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch(list2)', 'List QuickSearch options for a Task', NULL, 'Quicksearch', 'PROC', 'mnu_task_quicksearch(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2016-05-18 15:24:39', 'AJM', '2016-05-19 09:17:02', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch(list2)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2016-05-18 15:24:47', 'AJM', '2016-05-19 09:13:54', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch(list2)', 'mnu_task_quicksearch_alt(list2)', '006', 'Alternative Languages', 'Y', '2016-05-19 09:13:42', 'AJM', '2016-05-19 09:16:03', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch(list2)', 'mnu_task_quicksearch(add2)', '001', 'New', 'N', '2016-05-18 15:24:44', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch(list2)', 'mnu_task_quicksearch(del1)', '004', 'Delete', 'Y', '2016-05-18 15:24:46', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch(list2)', 'mnu_task_quicksearch(enq1)', '002', 'Read', 'Y', '2016-05-18 15:24:45', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch(list2)', 'mnu_task_quicksearch(search)', '005', 'Search', 'N', '2016-05-18 15:24:46', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch(list2)', 'mnu_task_quicksearch(upd1)', '003', 'Update', 'Y', '2016-05-18 15:24:45', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch(search)', 'Search QuickSearch options', NULL, 'Search', 'PROC', 'mnu_task_quicksearch(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2016-05-18 15:24:43', 'AJM', '2016-05-19 09:17:10', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_quicksearch(upd1)', 'Update QuickSearch option', NULL, 'Update', 'PROC', 'mnu_task_quicksearch(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2016-05-18 15:24:42', 'AJM', '2016-05-19 09:17:18', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(add1)', 'Add Task', NULL, 'Insert', 'PROC', 'mnu_task(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:39:39', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(add1)', 'This will allow a new record to be added to the TASK table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href="%root%/mnu_task(add1).html">Add Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:50:09', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(del1)', 'Delete Task', NULL, 'Delete', 'PROC', 'mnu_task(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:42:08', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(del1)', 'This will display a record from the TASK table and allow it to be deleted.

Refer to <a href="%root%/mnu_task(del1).html">Delete Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:50:12', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(enq1)', 'Enquire Task', NULL, 'Enquire', 'PROC', 'mnu_task(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:43:14', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task(enq1)', '2014-04-19 08:58:21', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(enq1)', 'This will display the contents of a record from the TASK table.

Refer to <a href="%root%/mnu_task(enq1).html">Enquire Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:50:14', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'List Task (All)', NULL, 'Task (All)', 'PROC', 'mnu_task(list1).php', 'N', 'LIST1', 'MENU', 'mnu_task(search)', NULL, NULL, NULL, 'task_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:30:48', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'audit_dtl(list)3', '025', 'Audit Trail', 'Y', '2004-04-09 11:38:19', 'AJM', '2013-01-01 13:40:04', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_help_text(multi1)', '005', 'Help Text', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_initial_value_role(multi3)a', '017', 'Initial Values (Role)', 'Y', '2007-05-27 10:51:53', 'AJM', '2007-09-10 14:30:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_initial_value_user(multi3)a', '018', 'Initial Values (User)', 'Y', '2007-05-27 10:51:53', 'AJM', '2007-09-10 14:30:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_menu(link1)', '012', 'Menu Contents (2)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_menu(list2)', '013', 'Menu Contents (3)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_menu(list2)a', '014', 'Menu (Parents)', 'Y', '2007-08-13 10:17:03', 'AJM', '2007-09-10 14:30:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_menu(multi2)', '011', 'Menu Contents (1)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_nav_button(link1)', '008', 'Navigation Button(2)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_nav_button(list2)', '009', 'Navigation Button(3)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_nav_button(list2)a', '010', 'Navigation Button (Parents)', 'Y', '2007-08-13 10:16:50', 'AJM', '2007-09-10 14:30:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_nav_button(multi2)', '007', 'Navigation Button(1)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_role_task(link1)a', '006', 'Task Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_role_taskfield(multi3)a', '016', 'Field Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_task_alt(list2)', '024', 'Alternative Languages', 'Y', '2013-01-01 13:39:52', 'AJM', '2013-01-01 13:42:16', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_task_field(list2)', '015', 'List Fields', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_task(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:39:39', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_task(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:42:08', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_task(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:43:13', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_task(pdf)', '021', 'Output to PDF(L)', 'N', '2006-08-17 11:06:09', 'AJM', '2007-09-10 14:30:48', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_task(pdf)2', '022', 'Output to PDF(D)', 'N', '2006-08-17 11:33:44', 'AJM', '2007-09-10 14:30:48', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_task(pdf)3', '023', 'Nav Buttons (PDF)', 'N', '2006-08-27 21:58:48', 'AJM', '2007-09-10 14:30:48', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_task(rename)', '019', 'Rename', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_task(search)', '020', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'mnu_task(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:55:16', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task(list1)', '2014-04-19 08:58:22', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'task_id', '1', 'Task Id', '2016-05-18 16:52:16', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'task_name', '2', 'Task Name', '2016-05-18 16:52:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'pattern_id', '3', 'Pattern Id', '2016-05-18 16:52:38', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'This will list records on the TASK table regardless of their TASK-TYPE.

Refer to <a href="%root%/mnu_task(list1).html">List Task (All)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:50:16', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'List Task (Process)', NULL, 'Task (Proc)', 'PROC', 'mnu_task(list1).php', 'N', 'LIST1', 'MENU', 'mnu_task(search)', 'task_type=\'PROC\'', NULL, NULL, 'task_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:25', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'audit_dtl(list)3', '024', 'Audit Trail', 'Y', '2004-04-09 11:38:58', 'AJM', '2016-05-18 15:28:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_help_text(multi1)', '005', 'Help Text', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_initial_value_role(multi3)a', '014', 'Initial Values (Role)', 'Y', '2007-05-05 19:22:19', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_initial_value_user(multi3)a', '015', 'Initial Values (User)', 'Y', '2007-05-27 10:54:39', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_menu(list2)a', '011', 'Menu (Parents)', 'Y', '2007-08-12 18:08:29', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_nav_button(link1)', '008', 'Navigation Button(2)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_nav_button(list2)', '009', 'Navigation Button(3)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_nav_button(list2)a', '010', 'Navigation Button (Parents)', 'Y', '2007-08-12 11:29:07', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_nav_button(multi2)', '007', 'Navigation Button(1)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_role_task(link1)a', '006', 'Task Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_role_taskfield(multi3)a', '013', 'Field Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task_alt(list2)', '022', 'Alternative Languages', 'Y', '2013-01-01 13:40:26', 'AJM', '2013-01-01 13:42:28', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task_field(list2)', '012', 'List Fields', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task_ip_address(list2)', '021', 'Task IP Address', 'Y', '2009-11-15 18:12:45', 'AJM', '2009-11-15 18:12:56', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task_quicksearch(list2)', '023', 'Quicksearch', 'Y', '2016-05-18 15:27:55', 'AJM', '2016-05-18 15:28:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:39:39', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:42:08', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:43:13', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task(pdf)', '018', 'Output to PDF(L)', 'N', '2006-08-17 11:06:49', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task(pdf)2', '019', 'Output to PDF(D)', 'N', '2006-08-17 11:33:55', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task(pdf)3', '020', 'Nav Buttons (PDF)', 'N', '2006-08-27 21:59:03', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task(rename)', '016', 'Rename', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task(search)', '017', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:55:16', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task(list1)a', '2014-04-19 08:58:22', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'task_id', '1', 'Task Id', '2016-05-18 16:57:47', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'task_name', '2', 'Task Name', '2016-05-18 16:57:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'pattern_id', '3', 'Pattern Id', '2016-05-18 16:58:09', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'This will list records on the TASK table where type = \'TASK\'.

Refer to <a href="%root%/mnu_task(list1)a.html">List Task (Proc)</a> for full details.', '2004-08-26 12:07:32', 'AJM', '2013-06-12 12:42:49', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'List Task (Menu)', NULL, 'Task (Menu)', 'PROC', 'mnu_task(list1).php', 'N', 'LIST1', 'MENU', NULL, 'task_type=\'MENU\' and pattern_id=\'MENU\'', NULL, NULL, 'task_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'audit_dtl(list)3', '016', 'Audit Trail', 'Y', '2004-04-08 16:27:07', 'AJM', '2013-01-01 13:41:25', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'mnu_help_text(multi1)', '005', 'Help Text', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'mnu_menu(link1)', '008', 'Menu Items(2)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'mnu_menu(list2)', '009', 'Menu Items(3)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'mnu_menu(list2)a', '010', 'Menu (Parents)', 'Y', '2007-08-12 17:41:40', 'AJM', '2007-09-10 14:35:53', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'mnu_menu(multi2)', '007', 'Menu Items(1)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'mnu_role_task(link1)a', '006', 'Task Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'mnu_task_alt(list2)', '015', 'Alternative Languages', 'Y', '2013-01-01 13:40:53', 'AJM', '2013-01-01 13:42:40', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'mnu_task(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:39:39', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'mnu_task(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:42:08', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'mnu_task(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:43:13', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'mnu_task(pdf)', '013', 'Output to PDF(L)', 'N', '2006-08-17 11:07:01', 'AJM', '2013-01-01 13:41:25', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'mnu_task(pdf)2', '014', 'Output to PDF(D)', 'N', '2006-08-17 11:34:07', 'AJM', '2013-01-01 13:41:25', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'mnu_task(rename)', '011', 'Rename', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'mnu_task(search)', '012', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'mnu_task(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:55:16', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task(list1)b', '2014-04-19 08:57:58', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'task_id', '1', 'Task Id', '2016-05-18 16:57:47', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'task_name', '2', 'Task Name', '2016-05-18 16:57:57', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'This will list records on the TASK table where type = \'MENU\'.

Refer to <a href="%root%/mnu_task(list1)b.html">List Task (Menu)</a> for full details.', '2004-08-26 12:07:39', 'AJM', '2013-06-12 12:42:55', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)a', 'List Task by Pattern', NULL, 'List Task', 'PROC', 'mnu_task(list2)a.php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, 'task_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:46:07', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)a', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-09 11:59:11', 'AJM', '2016-05-18 15:32:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)a', 'mnu_help_text(multi1)', '003', 'Help Text', 'Y', '2004-08-26 11:58:54', 'AJM', '2007-09-10 14:46:07', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)a', 'mnu_task_quicksearch(list2)', '005', 'Quicksearch', 'Y', '2016-05-18 15:31:41', 'AJM', '2016-05-18 15:32:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)a', 'mnu_task(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:46:07', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)a', 'mnu_task(pdf)', '004', 'Output to PDF(L)', 'N', '2006-09-25 15:07:39', 'AJM', '2016-05-18 15:32:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)a', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:46:07', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task(list2)a', '2014-04-19 08:57:58', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)a', 'task_id', '1', 'Task Id', '2016-05-18 16:57:47', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)a', 'task_name', '2', 'Task Name', '2016-05-18 16:57:57', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)a', 'This will list records on the TASK table for a selected PATTERN.

Refer to <a href="%root%/mnu_task(list2)a.html">List Task by Pattern</a> for full details.', '2004-08-26 12:09:31', 'AJM', '2013-06-12 12:43:08', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)b', 'List Task by Subsystem', NULL, 'List Task', 'PROC', 'mnu_task(list2)b.php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, 'task_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:48:19', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)b', 'audit_dtl(list)3', '004', 'Audit Trail', 'Y', '2004-04-09 11:59:19', 'AJM', '2007-09-10 14:48:19', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)b', 'mnu_help_text(multi1)', '003', 'Help Text', 'Y', '2006-07-21 11:36:38', 'AJM', '2007-09-10 14:48:19', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)b', 'mnu_task(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:48:18', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)b', 'mnu_task(pdf)', '005', 'Output to PDF(L)', 'N', '2006-09-25 15:08:41', 'AJM', '2007-09-10 14:48:19', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)b', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:48:18', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task(list2)b', '2014-04-19 08:57:58', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)b', 'task_id', '1', 'Task Id', '2016-05-18 16:57:47', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)b', 'task_name', '2', 'Task Name', '2016-05-18 16:57:57', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)b', 'This will list records on the TASK table for a selected SUBSYSTEM.

Refer to <a href="%root%/mnu_task(list2)b.html">List Task by Subsystem</a> for full details.', '2004-08-26 12:09:43', 'AJM', '2013-06-12 12:43:14', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(pdf)', 'Output to PDF - List view', NULL, 'Output to PDF(L)', 'PROC', 'mnu_task(pdf).php', 'N', 'OUTPUT2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2006-08-17 11:05:50', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task(pdf)', '2014-04-19 08:57:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(pdf)2', 'Output to PDF - Detail view', NULL, 'Output to PDF(D)', 'PROC', 'mnu_task(pdf)2.php', 'N', 'OUTPUT3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2006-08-17 11:33:23', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task(pdf)2', '2014-04-19 08:57:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(pdf)3', 'Output to PDF - Navigation Buttons', NULL, 'Nav Buttons (PDF)', 'PROC', 'mnu_task(pdf)3.php', 'N', 'OUTPUT3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2006-08-27 21:57:58', 'AJM', '2006-08-27 22:00:30', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task(pdf)3', '2014-04-19 08:57:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)', 'Choose Task', NULL, 'Choose', 'PROC', 'mnu_task(popup1).php', 'N', 'POPUP1', 'MENU', NULL, NULL, NULL, 'select_one=FALSE', 'task_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-28 09:27:50', 'MGR');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:58:15', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task(popup1)', '2014-04-19 08:58:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)', 'task_id', '1', 'Task Id', '2016-05-18 16:57:47', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)', 'task_name', '2', 'Task Name', '2016-05-18 16:57:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)', 'pattern_id', '3', 'Pattern Id', '2016-05-18 16:58:09', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)', 'This will list records on the TASK table and allow one or more to be selected.

After selecting records please press the CHOOSE button.

Refer to <a href="%root%/mnu_task(popup1).html">Choose Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:50:48', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a', 'Choose Task (proc)', NULL, 'Choose', 'PROC', 'mnu_task(popup1).php', 'N', 'POPUP1', 'MENU', NULL, 'task_type=\'PROC\'', NULL, 'select_one=FALSE', 'task_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-08-12 15:43:07', 'AJM', '2017-05-28 09:28:03', 'MGR');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a', 'mnu_task(search)', '001', 'Search', 'N', '2004-08-26 12:00:46', 'AJM', '2007-09-10 14:59:10', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_task(popup1)a', '2014-06-05 15:55:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task(popup1)a', '2014-04-19 06:22:02', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_task(popup1)a', '2014-04-20 12:48:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a', 'task_id', '1', 'Task Id', '2016-05-18 16:57:47', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a', 'task_name', '2', 'Task Name', '2016-05-18 16:57:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a', 'pattern_id', '3', 'Pattern Id', '2016-05-18 16:58:09', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a', 'This will list records on the TASK table with type = PROC and allow one or more to be selected.

After selecting records please press the CHOOSE button.

Refer to <a href="%root%/mnu_task(popup1)a.html">Choose Task (Proc)</a> for full details.', '2004-08-26 14:09:00', 'AJM', '2013-06-12 14:11:33', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a1', 'Choose Task (proc)', NULL, 'Choose', 'PROC', 'mnu_task(popup1).php', 'N', 'POPUP1', 'MENU', NULL, 'task_type=\'PROC\'', NULL, 'select_one=FALSE', 'task_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2010-07-18 13:24:51', 'AJM', '2017-05-28 09:28:16', 'MGR');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a1', 'mnu_task(search)', '001', 'Search', 'N', '2010-07-18 15:47:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task(popup1)a1', '2014-04-19 08:58:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a1', 'task_id', '1', 'Task Id', '2016-05-18 16:57:47', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a1', 'task_name', '2', 'Task Name', '2016-05-18 16:57:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a1', 'pattern_id', '3', 'Pattern Id', '2016-05-18 16:58:09', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a1', '[copy: mnu_task(popup1)a]', '2013-06-12 13:56:46', 'AJM', '2013-06-12 14:12:04', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a2', 'Choose Task (proc)', NULL, 'Choose', 'PROC', 'mnu_task(popup1).php', 'N', 'POPUP1', 'MENU', NULL, 'task_type=\'PROC\'', NULL, 'select_one=FALSE', 'task_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2010-07-18 13:25:05', 'AJM', '2017-05-28 09:28:30', 'MGR');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a2', 'mnu_task(search)', '001', 'Search', 'N', '2010-07-18 15:47:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task(popup1)a2', '2014-04-19 08:58:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a2', 'task_id', '1', 'Task Id', '2016-05-18 16:57:47', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a2', 'task_name', '2', 'Task Name', '2016-05-18 16:57:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a2', 'pattern_id', '3', 'Pattern Id', '2016-05-18 16:58:09', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a2', '[copy: mnu_task(popup1)a]', '2013-06-12 13:57:56', 'AJM', '2013-06-12 14:12:09', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)b', 'Choose Task (menu)', NULL, 'Choose', 'PROC', 'mnu_task(popup1).php', 'N', 'POPUP1', 'MENU', NULL, 'task_type=\'MENU\'', NULL, 'select_one=TRUE', 'task_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2003-01-01 12:00:00', 'AJM', '2017-05-28 09:28:45', 'MGR');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)b', 'mnu_task(search)', '001', 'Search', 'N', '2007-10-13 13:33:24', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task(popup1)b', '2014-04-19 08:58:01', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)b', 'task_id', '1', 'Task Id', '2016-05-18 16:57:47', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)b', 'task_name', '2', 'Task Name', '2016-05-18 16:57:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)b', 'pattern_id', '3', 'Pattern Id', '2016-05-18 16:58:09', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)b', 'This will list records on the TASK table with type = MENUand allow one or more to be selected.

After selecting records please press the CHOOSE button.

Refer to <a href="%root%/mnu_task(popup1)b.html">Choose Task (Menu)</a> for full details.', '2004-08-26 14:09:10', 'AJM', '2013-06-12 14:12:36', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(rename)', 'Rename Task', NULL, 'Rename', 'PROC', 'mnu_task(upd2).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:02:13', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(rename)', 'This will allow a entry on the TASK table to be renamed. It will also rename any associated records on any related tables. 

Refer to <a href="%root%/mnu_task(rename).html">Rename Task</a> for full details.', '2004-08-26 12:25:54', 'AJM', '2013-06-12 13:58:48', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(search)', 'Search Task', NULL, 'Search', 'PROC', 'mnu_task(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:50:51', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_task(search)', '2014-06-05 15:55:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_task(search)', '2014-04-19 06:22:03', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_task(search)', '2014-04-20 12:48:05', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(search)', 'This will allow search criteria to be entered for the TASK table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/mnu_task(search).html">Search Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:08:08', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(upd1)', 'Update Task', NULL, 'Update', 'PROC', 'mnu_task(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:55:16', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(upd1)', 'This will display the contents of a record from the TASK table and allow it to be updated. 

Refer to <a href="%root%/mnu_task(upd1).html">Update Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:08:10', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(add2)', 'Add Time Limit for Role', NULL, 'New', 'PROC', 'mnu_time_limit_role(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2013-04-21 16:42:19', 'AJM', '2013-04-21 16:54:12', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(add2)', 'This will allow a record to be added to the TIME_LIMIT_ROLE table for a selected ROLE.

Refer to <a href="%root%/mnu_time_limit_role(add2).html">Add Time Limit for Role</a> for full details.', '2013-06-12 15:24:37', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(del1)', 'Delete Time Limit for Role', NULL, 'Delete', 'PROC', 'mnu_time_limit_role(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2013-04-21 16:42:21', 'AJM', '2013-04-21 16:54:27', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(del1)', 'This will display a record from the TIME_LIMIT_ROLE table and allow it to be deleted.

Refer to <a href="%root%/mnu_time_limit_role(del1).html">Delete Time Limit for Role</a> for full details.', '2013-06-12 15:27:03', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(enq1)', 'Enquire Time Limit for Role', NULL, 'Read', 'PROC', 'mnu_time_limit_role(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2013-04-21 16:42:20', 'AJM', '2013-04-21 16:54:41', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_time_limit_role(enq1)', '2014-04-19 08:57:38', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(enq1)', 'This will display a record from the TIME_LIMIT_ROLE table.

Refer to <a href="%root%/mnu_time_limit_role(enq1).html">Enquire Time Limit for Role</a> for full details.', '2013-06-12 15:27:49', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(list2)', 'List Time Limit for Role', NULL, 'Time Limits', 'PROC', 'mnu_time_limit_role(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2013-04-21 16:42:19', 'AJM', '2013-04-21 16:55:01', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2013-04-21 16:42:23', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(list2)', 'mnu_time_limit_role(add2)', '001', 'New', 'N', '2013-04-21 16:42:22', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(list2)', 'mnu_time_limit_role(del1)', '004', 'Delete', 'Y', '2013-04-21 16:42:22', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(list2)', 'mnu_time_limit_role(enq1)', '002', 'Read', 'Y', '2013-04-21 16:42:22', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(list2)', 'mnu_time_limit_role(search)', '005', 'Search', 'N', '2013-04-21 16:42:22', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(list2)', 'mnu_time_limit_role(upd1)', '003', 'Update', 'Y', '2013-04-21 16:42:22', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_time_limit_role(list2)', '2014-04-19 08:57:38', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(list2)', 'This will list records on the TIME_LIMIT_ROLE table for a selected ROLE.

Refer to <a href="%root%/mnu_time_limit_role(list2).html">List Time Limit for Role</a> for full details.', '2013-06-12 15:22:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(search)', 'Search Time Limit for Role', NULL, 'Search', 'PROC', 'mnu_time_limit_role(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2013-04-21 16:42:22', 'AJM', '2013-04-21 16:55:16', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_time_limit_role(search)', '2014-04-19 08:57:38', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(search)', 'This will allow search criteria to be entered for the TIME_LIMIT_ROLE table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/mnu_time_limit_role(search).html">Search Time Limit for Role</a> for full details.', '2013-06-12 15:29:29', 'AJM', '2013-06-12 15:29:50', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(upd1)', 'Update Time Limit for Role', NULL, 'Update', 'PROC', 'mnu_time_limit_role(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2013-04-21 16:42:21', 'AJM', '2013-04-21 16:55:32', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(upd1)', 'This will display a record from the TIME_LIMIT_ROLE table and allow it to be updated.

Refer to <a href="%root%/mnu_time_limit_role(upd1).html">Update Time Limit for Role</a> for full details.', '2013-06-12 15:30:24', 'AJM', '2013-06-12 15:31:14', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(add2)', 'Add Time Limit for User', NULL, 'New', 'PROC', 'mnu_time_limit_user(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2013-04-21 16:45:43', 'AJM', '2013-04-21 16:57:39', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(add2)', 'This will allow a record to be added to the TIME_LIMIT_USER table for a selected User.

Refer to <a href="%root%/mnu_time_limit_user(add2).html">Add Time Limit for User</a> for full details.', '2013-06-12 15:24:37', 'AJM', '2013-06-12 16:33:37', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(del1)', 'Delete Time Limit for User', NULL, 'Delete', 'PROC', 'mnu_time_limit_user(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2013-04-21 16:45:45', 'AJM', '2013-04-21 16:57:55', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(del1)', 'This will display a record from the TIME_LIMIT_USER table and allow it to be deleted.

Refer to <a href="%root%/mnu_time_limit_user(del1).html">Delete Time Limit for User</a> for full details.', '2013-06-12 15:27:03', 'AJM', '2013-06-12 16:33:48', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(enq1)', 'Enquire Time Limit for User', NULL, 'Read', 'PROC', 'mnu_time_limit_user(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2013-04-21 16:45:44', 'AJM', '2013-04-21 16:58:08', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_time_limit_user(enq1)', '2014-04-19 08:57:18', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(enq1)', 'This will display a record from the TIME_LIMIT_USER table.

Refer to <a href="%root%/mnu_time_limit_user(enq1).html">Enquire Time Limit for User</a> for full details.', '2013-06-12 15:27:49', 'AJM', '2013-06-12 16:33:57', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(list2)', 'List Time Limit for User', NULL, 'Time Limits', 'PROC', 'mnu_time_limit_user(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2013-04-21 16:45:43', 'AJM', '2013-04-21 16:58:47', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2013-04-21 16:45:46', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(list2)', 'mnu_time_limit_user(add2)', '001', 'New', 'N', '2013-04-21 16:45:46', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(list2)', 'mnu_time_limit_user(del1)', '004', 'Delete', 'Y', '2013-04-21 16:45:46', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(list2)', 'mnu_time_limit_user(enq1)', '002', 'Read', 'Y', '2013-04-21 16:45:46', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(list2)', 'mnu_time_limit_user(search)', '005', 'Search', 'N', '2013-04-21 16:45:46', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(list2)', 'mnu_time_limit_user(upd1)', '003', 'Update', 'Y', '2013-04-21 16:45:46', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_time_limit_user(list2)', '2014-04-19 08:57:18', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(list2)', 'This will list records on the TIME_LIMIT_USER table for a selected User.

Refer to <a href="%root%/mnu_time_limit_user(list2).html">List Time Limit for User</a> for full details.', '2013-06-12 15:22:34', 'AJM', '2013-06-12 16:34:06', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(search)', 'Search Time Limit for User', NULL, 'Search', 'PROC', 'mnu_time_limit_user(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2013-04-21 16:45:45', 'AJM', '2013-04-21 16:59:03', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_time_limit_user(search)', '2014-04-19 08:57:19', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(search)', 'This will allow search criteria to be entered for the TIME_LIMIT_USER table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/mnu_time_limit_user(search).html">Search Time Limit for User</a> for full details.', '2013-06-12 15:29:29', 'AJM', '2013-06-12 16:34:15', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(upd1)', 'Update Time Limit for User', NULL, 'Update', 'PROC', 'mnu_time_limit_user(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2013-04-21 16:45:44', 'AJM', '2013-04-21 16:59:19', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(upd1)', 'This will display a record from the TIME_LIMIT_USER table and allow it to be updated.

Refer to <a href="%root%/mnu_time_limit_user(upd1).html">Update Time Limit for User</a> for full details.', '2013-06-12 15:30:24', 'AJM', '2013-06-12 16:34:24', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(add1)', 'Add ToDo', NULL, 'New', 'PROC', 'mnu_todo(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2005-07-30 17:55:07', 'AJM', '2017-05-26 14:17:26', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_todo(add1)', '2014-06-05 15:55:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_todo(add1)', '2014-04-19 06:21:56', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_todo(add1)', '2016-10-06 13:46:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_todo(add1)', '2014-04-20 12:48:00', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(add1)', 'This will allow a new record to be added to the ToDo table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href="%root%/mnu_todo(add1).html">Add ToDo</a> for full details.', '2006-04-19 16:10:08', 'AJM', '2013-06-12 14:20:02', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(del1)', 'Delete ToDo', NULL, 'Delete', 'PROC', 'mnu_todo(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2005-07-30 17:55:33', 'AJM', '2017-05-26 14:17:34', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_todo(del1)', '2014-06-05 15:55:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_todo(del1)', '2014-04-19 06:21:56', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_todo(del1)', '2016-10-06 13:46:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_todo(del1)', '2014-04-20 12:48:00', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(del1)', 'This will display a record from the ToDo table and allow it to be deleted.

Refer to <a href="%root%/mnu_todo(del1).html">Delete ToDo</a> for full details.', '2006-04-19 16:10:55', 'AJM', '2013-06-12 14:20:04', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(enq1)', 'Enquire ToDo', NULL, 'Read', 'PROC', 'mnu_todo(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2005-07-30 17:56:00', 'AJM', '2017-05-26 14:17:40', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_todo(enq1)', '2014-06-05 15:55:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_todo(enq1)', '2014-04-19 06:21:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_todo(enq1)', '2016-10-06 13:46:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_todo(enq1)', '2014-04-20 12:48:00', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(enq1)', 'This will display the contents of a record from the ToDo table.

Refer to <a href="%root%/mnu_todo(enq1).html">Enquire ToDo</a> for full details.', '2006-04-19 16:12:45', 'AJM', '2013-06-12 14:20:06', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'List ToDo', NULL, 'ToDo', 'PROC', 'mnu_todo(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, 'is_complete=\'N\'', NULL, NULL, 'Y', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2005-07-30 17:54:29', 'AJM', '2007-09-10 15:11:15', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2005-07-30 19:32:15', 'AJM', '2010-07-24 11:09:39', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'mnu_todo(add1)', '001', 'New', 'N', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:11:15', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'mnu_todo(del1)', '005', 'Delete', 'Y', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:11:15', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'mnu_todo(enq1)', '003', 'Read', 'Y', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:11:15', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'mnu_todo(search)', '002', 'Search', 'N', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:11:15', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'mnu_todo(upd1)', '004', 'Update', 'Y', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:15:51', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_todo(list1)', '2014-04-19 08:57:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'user_id', '1', 'User Id', '2016-05-18 16:58:47', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'item_name', '2', 'Item Name', '2016-05-18 16:58:58', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'This will list records on the ToDo table.

Refer to <a href="%root%/mnu_todo(list1).html">List ToDo</a> for full details.', '2006-04-19 15:57:45', 'AJM', '2013-06-12 14:20:08', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list2)', 'List ToDo by User', NULL, 'ToDo', 'PROC', 'mnu_todo(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, 'is_complete=\'N\'', NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2005-07-30 19:17:53', 'AJM', '2007-09-10 15:12:37', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list2)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2005-07-30 19:32:02', 'AJM', '2010-07-24 11:10:52', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list2)', 'mnu_todo(add1)', '001', 'New', 'N', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:12:37', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list2)', 'mnu_todo(del1)', '005', 'Delete', 'Y', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:12:37', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list2)', 'mnu_todo(enq1)', '003', 'Read', 'Y', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:12:37', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list2)', 'mnu_todo(search)', '002', 'Search', 'N', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:12:37', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list2)', 'mnu_todo(upd1)', '004', 'Update', 'Y', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:15:51', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_todo(list2)', '2014-06-05 15:55:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_todo(list2)', '2014-04-19 06:21:56', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_todo(list2)', '2016-10-06 13:46:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_todo(list2)', '2014-04-20 12:47:59', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list2)', 'This will list records on the ToDo table for a particular USER.

Refer to <a href="%root%/mnu_todo(list)2.html">List ToDo for User</a> for full details.', '2006-04-19 16:07:56', 'AJM', '2013-06-12 14:20:10', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(search)', 'Search ToDo', NULL, 'Search', 'PROC', 'mnu_todo(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2005-07-30 17:56:31', 'AJM', '2017-05-26 14:17:46', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_todo(search)', '2014-06-05 15:55:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_todo(search)', '2014-04-19 06:21:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_todo(search)', '2016-10-06 13:46:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_todo(search)', '2014-04-20 12:48:00', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(search)', 'This will allow search criteria to be entered for the ToDo table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/mnu_todo(search).html">Search ToDo</a> for full details.', '2006-04-19 16:13:45', 'AJM', '2013-06-12 14:20:12', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(upd1)', 'Update ToDo', NULL, 'Update', 'PROC', 'mnu_todo(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2005-07-30 17:57:00', 'AJM', '2017-05-26 14:17:54', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_todo(upd1)', '2014-06-05 15:55:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_todo(upd1)', '2014-04-19 06:21:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_todo(upd1)', '2016-10-06 13:46:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_todo(upd1)', '2014-04-20 12:48:01', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(upd1)', 'This will display the contents of a record from the ToDo table and allow it to be updated. 

Refer to <a href="%root%/mnu_todo(upd1).html">Update ToDo</a> for full details.', '2006-04-19 16:14:40', 'AJM', '2013-06-12 14:20:14', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_alt(add2)', 'Add User (Alternative Language)', NULL, 'New', 'PROC', 'mnu_user_alt(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2014-04-23 18:14:31', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_alt(del1)', 'Delete User (Alternative Language)', NULL, 'Delete', 'PROC', 'mnu_user_alt(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2014-04-23 18:14:31', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_alt(enq1)', 'Enquire User (Alternative Language)', NULL, 'Read', 'PROC', 'mnu_user_alt(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2014-04-23 18:14:31', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_user_alt(enq1)', '2014-04-23 14:03:45', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_alt(list2)', 'Maintain Alternative Languages for USER', NULL, 'Alternative Languages', 'PROC', 'mnu_user_alt(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2014-04-23 18:14:31', 'AJM', '2014-04-23 18:16:42', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_alt(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2014-04-23 18:14:33', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_alt(list2)', 'mnu_user_alt(add2)', '001', 'New', 'N', '2014-04-23 18:14:32', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_alt(list2)', 'mnu_user_alt(del1)', '004', 'Delete', 'Y', '2014-04-23 18:14:32', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_alt(list2)', 'mnu_user_alt(enq1)', '002', 'Read', 'Y', '2014-04-23 18:14:32', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_alt(list2)', 'mnu_user_alt(search)', '005', 'Search', 'N', '2014-04-23 18:14:32', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_alt(list2)', 'mnu_user_alt(upd1)', '003', 'Update', 'Y', '2014-04-23 18:14:32', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_user_alt(list2)', '2014-04-23 14:03:46', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_alt(search)', 'Search User (Alternative Language)', NULL, 'Search', 'PROC', 'mnu_user_alt(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2014-04-23 18:14:32', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_user_alt(search)', '2014-04-23 14:03:46', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_alt(upd1)', 'Update User (Alternative Language)', NULL, 'Update', 'PROC', 'mnu_user_alt(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2014-04-23 18:14:31', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(add2)', 'Add User IP Address', NULL, 'New', 'PROC', 'mnu_user_ip_address(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2009-11-15 18:22:05', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(add2)', 'This will allow a new record to be added to the USER_IP_ADDRESS table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href="%root%/mnu_user_ip_address(add2).html">Add User IP Address</a> for full details.', '2009-12-05 10:46:48', 'AJM', '2013-06-12 14:22:52', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(del1)', 'Delete User IP Address', NULL, 'Delete', 'PROC', 'mnu_user_ip_address(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2009-11-15 18:22:07', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(del1)', 'This will display a record from the USER_IP_ADDRESS table and allow it to be deleted.

Refer to <a href="%root%/mnu_user_ip_address(del1).html">Delete User IP Address</a> for full details.', '2009-12-05 10:47:57', 'AJM', '2013-06-12 14:21:53', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(enq1)', 'Enquire User IP Address', NULL, 'Read', 'PROC', 'mnu_user_ip_address(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2009-11-15 18:22:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_user_ip_address(enq1)', '2014-04-19 08:57:20', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(enq1)', 'This will display the contents of a record from the USER_IP_ADDRESS table.

Refer to <a href="%root%/mnu_user_ip_address(enq1).html">Enquire User IP Address</a> for full details.', '2009-12-05 10:48:25', 'AJM', '2013-06-12 14:21:55', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(list2)', 'List IP Address by User', NULL, 'User IP Address', 'PROC', 'mnu_user_ip_address(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2009-11-15 18:22:04', 'AJM', '2009-11-15 18:23:33', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2009-11-15 18:22:13', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(list2)', 'mnu_user_ip_address(add2)', '001', 'New', 'N', '2009-11-15 18:22:10', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(list2)', 'mnu_user_ip_address(del1)', '004', 'Delete', 'Y', '2009-11-15 18:22:11', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(list2)', 'mnu_user_ip_address(enq1)', '002', 'Read', 'Y', '2009-11-15 18:22:10', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(list2)', 'mnu_user_ip_address(search)', '005', 'Search', 'N', '2009-11-15 18:22:12', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(list2)', 'mnu_user_ip_address(upd1)', '003', 'Update', 'Y', '2009-11-15 18:22:11', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_user_ip_address(list2)', '2014-04-19 08:57:20', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(list2)', 'This will list records on the USER_IP_ADDRESS table for a selected User.

Refer to <a href="%root%/mnu_user_ip_address(list2).html">List IP Address by User</a> for full details.', '2009-12-05 10:49:07', 'AJM', '2013-06-12 14:21:56', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(search)', 'Search User IP Address', NULL, 'Search', 'PROC', 'mnu_user_ip_address(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2009-11-15 18:22:09', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_user_ip_address(search)', '2014-04-19 08:57:20', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(search)', 'This will allow search criteria to be entered for the USER_IP_ADDRESS table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/mnu_user_ip_address(search).html">Search User IP Address</a> for full details.', '2009-12-05 10:49:42', 'AJM', '2013-06-12 14:21:58', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(upd1)', 'Update User IP Address', NULL, 'Update', 'PROC', 'mnu_user_ip_address(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2009-11-15 18:22:06', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(upd1)', 'This will display the contents of a record from the USER_IP_ADDRESS table and allow it to be updated. 

Refer to <a href="%root%/mnu_user_ip_address(upd1).html">Update User IP Address</a> for full details.', '2009-12-05 10:50:17', 'AJM', '2013-06-12 14:22:00', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(add2)', 'Add User Role', NULL, 'New', 'PROC', 'mnu_user_role(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2014-04-19 09:28:26', 'AJM', '2017-05-28 09:38:51', 'MGR');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(del1)', 'Delete User Role', NULL, 'Delete', 'PROC', 'mnu_user_role(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2014-04-19 09:28:27', 'AJM', '2017-05-28 09:39:05', 'MGR');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(enq1)', 'Enquire User Role', NULL, 'Read', 'PROC', 'mnu_user_role(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2014-04-19 09:28:26', 'AJM', '2017-05-28 09:39:21', 'MGR');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_user_role(enq1)', '2014-04-19 08:56:57', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(list2)', 'List User Role by User', NULL, 'User Roles', 'PROC', 'mnu_user_role(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, 'curr_or_hist=\'C\'', NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2014-04-19 09:28:26', 'AJM', '2017-07-20 14:38:09', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(list2)', 'audit_dtl(list)3', '012', 'Audit Trail', 'Y', '2014-04-19 09:28:29', 'AJM', '2017-07-20 15:05:33', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(list2)', 'date(current)', '006', 'Current', 'N', '2017-07-20 14:39:04', 'AJM', '2017-07-20 14:39:42', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(list2)', 'date(future)', '007', 'Future', 'N', '2017-07-20 14:39:04', 'AJM', '2017-07-20 14:39:42', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(list2)', 'date(historic)', '008', 'Historic', 'N', '2017-07-20 14:39:04', 'AJM', '2017-07-20 14:39:43', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(list2)', 'mnu_user_role(add2)', '001', 'New', 'N', '2014-04-19 09:28:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(list2)', 'mnu_user_role(del1)', '004', 'Delete', 'Y', '2014-04-19 09:28:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(list2)', 'mnu_user_role(enq1)', '002', 'Read', 'Y', '2014-04-19 09:28:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(list2)', 'mnu_user_role(search)', '005', 'Search', 'N', '2014-04-19 09:28:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(list2)', 'mnu_user_role(upd1)', '003', 'Update', 'Y', '2014-04-19 09:28:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(list2)', 'mnu_user_role(upd4)movedown', '010', 'Move Down', 'Y', '2017-07-20 15:05:08', 'AJM', '2017-07-20 15:05:33', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(list2)', 'mnu_user_role(upd4)moveup', '009', 'Move Up', 'Y', '2017-07-20 15:04:54', 'AJM', '2017-07-20 15:05:33', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(list2)', 'mnu_user_role(upd4)reseq', '011', 'Resequence', 'N', '2017-07-20 15:05:08', 'AJM', '2017-07-20 15:05:33', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_user_role(list2)', '2014-04-19 08:56:58', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(search)', 'Search User Role', NULL, 'Search', 'PROC', 'mnu_user_role(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2014-04-19 09:28:28', 'AJM', '2017-05-28 09:39:37', 'MGR');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_user_role(search)', '2014-04-19 08:56:58', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(upd1)', 'Update User Role', NULL, 'Update', 'PROC', 'mnu_user_role(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2014-04-19 09:28:26', 'AJM', '2017-05-28 09:39:54', 'MGR');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(upd4)movedown', 'Move Role Down', NULL, 'Move Down', 'PROC', 'mnu_user_role(upd4)movedown.php', 'N', 'UPD4', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2017-07-20 15:01:44', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(upd4)moveup', 'Move Role Up', NULL, 'Move Up', 'PROC', 'mnu_user_role(upd4)moveup.php', 'N', 'UPD4', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2017-07-20 15:02:40', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_role(upd4)reseq', 'Resequence User Roles', NULL, 'Resequence', 'PROC', 'mnu_user_role(upd4)reseq.php', 'N', 'UPD4', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2017-07-20 15:03:37', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(add1)', 'Add User', NULL, 'Insert', 'PROC', 'mnu_user(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-24 17:17:25', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(add1)', 'This will allow a new record to be added to the USER table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href="%root%/mnu_user(add1).html">Add User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:35:32', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(del1)', 'Delete User', NULL, 'Delete', 'PROC', 'mnu_user(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-24 17:17:31', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(del1)', 'This will display a record from the USER table and allow it to be deleted.

Refer to <a href="%root%/mnu_user(del1).html">Delete User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:35:35', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(enq1)', 'Enquire User', NULL, 'Enquire', 'PROC', 'mnu_user(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-24 17:17:38', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_user(enq1)', '2014-04-19 08:56:59', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(enq1)', 'This will display the contents of a record from the USER table.

Refer to <a href="%root%/mnu_user(enq1).html">Enquire User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:35:37', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'List User', NULL, 'List User', 'PROC', 'mnu_user(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, 'user_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-28 09:41:39', 'MGR');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'audit_dtl(list)3', '017', 'Audit Trail', 'Y', '2004-04-09 11:39:20', 'AJM', '2014-04-23 18:18:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_favourite(list2)', '014', 'Favourites', 'Y', '2010-07-20 10:56:02', 'AJM', '2014-04-19 10:47:33', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_initial_value_user(multi3)b', '009', 'Initial Values', 'Y', '2007-05-27 10:44:10', 'AJM', '2014-04-19 10:47:32', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_time_limit_user(list2)', '015', 'Time Limits', 'Y', '2013-04-21 17:00:46', 'AJM', '2014-04-19 10:47:34', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_todo(list2)', '008', 'ToDo', 'Y', '2005-07-30 19:18:31', 'AJM', '2014-04-19 10:47:32', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user_alt(list2)', '016', 'Alternative Languages', 'Y', '2014-04-23 18:18:02', 'AJM', '2014-04-23 18:18:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user_ip_address(list2)', '012', 'IP Address', 'Y', '2009-11-15 18:24:21', 'AJM', '2014-04-19 10:47:33', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user_role(list2)', '005', 'User Roles', 'Y', '2014-04-19 10:46:48', 'AJM', '2014-04-19 10:47:35', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user(pdf)', '011', 'Output to PDF(L)', 'N', '2006-08-17 19:01:45', 'AJM', '2014-04-19 10:47:33', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user(search)', '010', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2014-04-19 10:47:32', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:31:43', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user(upd1)a', '006', 'Change Password', 'Y', '2003-01-01 12:00:00', 'AJM', '2014-04-19 10:47:31', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user(upd1)b', '007', 'Reset Password', 'Y', '2003-01-01 12:00:00', 'AJM', '2014-04-19 10:47:31', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_user(list1)', '2014-04-19 08:56:37', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'user_id', '1', 'User Id', '2016-05-18 16:59:27', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_quicksearch` (`task_id`, `field_id`, `sort_seq`, `field_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'user_name', '2', 'User Name', '2016-05-18 16:59:38', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'This will list records on the USER table.

Refer to <a href="%root%/mnu_user(list1).html">List User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:35:38', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list2)', 'List User by Role', NULL, 'List User', 'PROC', 'mnu_user(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, 'user_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:27:06', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list2)', 'audit_dtl(list)3', '001', 'Audit Trail', 'Y', '2004-04-09 11:59:34', 'AJM', '2007-09-10 15:27:06', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list2)', 'mnu_initial_value_user(multi3)b', '002', 'Initial Values', 'Y', '2007-05-27 10:45:41', 'AJM', '2007-09-10 15:27:06', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_user(list2)', '2014-04-19 08:56:37', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list2)', 'This will list records on the USER table for a selected ROLE.

Refer to <a href="%root%/mnu_user(list2).html">List User by Role</a> for full details.', '2004-08-26 12:10:17', 'AJM', '2013-06-12 14:35:40', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(pdf)', 'Output to PDF - List view', NULL, 'Output to PDF(L)', 'PROC', 'mnu_user(pdf).php', 'N', 'OUTPUT2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2006-08-17 19:01:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_user(pdf)', '2014-04-19 08:56:38', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(popup1)', 'Choose User', NULL, 'Choose', 'PROC', 'mnu_user(popup1).php', 'N', 'POPUP1', 'MENU', NULL, NULL, NULL, NULL, 'user_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-28 09:28:58', 'MGR');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_user(popup1)', '2014-04-19 08:56:38', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(popup1)', 'This will list records on the USER table and allow one or more to be selected.

After selecting records please press the CHOOSE button to return to the previous screen.

Refer to <a href="%root%/mnu_user(popup1).html">Choose User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:35:42', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(search)', 'Search User', NULL, 'Search', 'PROC', 'mnu_user(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-24 17:17:00', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_user(search)', '2014-04-19 08:56:38', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(search)', 'This will allow search criteria to be entered for the USER table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href="%root%/mnu_user(search).html">Search User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:43:17', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(upd1)', 'Update User', NULL, 'Update', 'PROC', 'mnu_user(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-24 17:17:06', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(upd1)', 'This will display the contents of a record from the USER table and allow it to be updated. 

Refer to <a href="%root%/mnu_user(upd1).html">Update User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:43:20', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(upd1)a', 'Change User Password', NULL, 'Change Password', 'PROC', 'mnu_user(upd1)a.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'Y', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-28 09:42:25', 'MGR');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_user(upd1)a', '2014-06-05 15:55:19', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_user(upd1)a', '2016-10-06 13:46:36', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(upd1)a', 'This will allow a user\'s password to be changed.

Refer to <a href="%root%/mnu_user(upd1)a.html">Change User Password</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:44:12', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(upd1)b', 'Reset User Password', NULL, 'Reset Password', 'PROC', 'mnu_user(upd1)b.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'Y', NULL, NULL, NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2017-05-28 09:42:38', 'MGR');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_user(upd1)b', '2014-06-05 15:55:19', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_user(upd1)b', '2016-10-06 13:46:36', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(upd1)b', 'This will allow a user\'s password to be changed.

Refer to <a href="%root%/mnu_user(upd1)b.html">Reset User Password</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:44:34', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(upd1)c', 'Retrieve User Password', NULL, 'Retrieve Password', 'PROC', 'mnu_user(upd1)c.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'Y', '2006-04-23 11:39:09', 'AJM', '2017-05-28 09:42:51', 'MGR');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_user(upd1)c', '2014-06-05 15:55:19', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU-RO', 'mnu_user(upd1)c', '2014-04-19 06:21:55', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('PROTO', 'mnu_user(upd1)c', '2016-10-06 13:46:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('WORKFLOW-RO', 'mnu_user(upd1)c', '2014-04-20 12:47:59', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(upd1)c', 'Enter your e-mail address and your password will be sent to you.

Note: this will only work if your e-mail address is recorded on your user details.

Refer to <a href="%root%/mnu_user(pswd).html">Retrieve Password</a> for full details.', '2006-04-23 11:41:11', 'AJM', '2013-06-12 14:45:02', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('proto', 'Prototypes', NULL, 'PROTO', 'MENU', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2007-07-09 23:09:13', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'proto', '2014-04-20 12:55:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('applications', 'Applications', NULL, 'Transix', 'MENU', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2005-05-05 17:45:29', 'AJM', '2013-04-19 15:02:10', 'AJM');
REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('main_menu', 'Main index page', NULL, 'Menu1', 'MENU', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'Menu System', NULL, 'Menu System', 'MENU', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task` (`task_id`, `task_name`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('proto', 'Prototypes', NULL, 'PROTO', 'MENU', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, 'N', '2007-07-09 23:09:13', 'AJM', NULL, NULL);

REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('main_menu', 'menu01', '001', 'Menu System', '2004-09-08 18:07:24', 'AJM', '2004-09-08 18:07:33', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('main_menu', 'proto', '006', 'PROTO', '2007-07-09 23:10:08', 'AJM', NULL, NULL);
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_account(list1)', '010', 'Hosting Account', '2007-09-13 11:37:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_control(upd3)', '001', 'Menu Controls', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:32', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_language(list1)', '011', 'Languages', '2008-01-03 11:38:46', 'AJM', '2008-01-03 11:39:14', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_motd(list1)', '012', 'MOTD', '2009-05-05 11:40:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_pattern(list1)', '002', 'Pattern', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:55:34', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_role(list1)', '007', 'Role', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_saved_selection(list1)', '013', 'Saved Selection', '2015-11-20 09:25:59', 'AJM', NULL, NULL);
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_subsystem(list1)', '003', 'Subsystem', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:01:47', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_task(list1)', '004', 'Task (All)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_task(list1)a', '005', 'Task (Proc)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_task(list1)b', '006', 'Task (Menu)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:52', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_todo(list1)', '009', 'ToDo', '2005-07-30 17:59:41', 'AJM', '2007-09-10 15:11:15', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_user(list1)', '008', 'User', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM');

REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'AUDIT_DELETE', '3', '2012-08-07 07:48:21', 'AJM', NULL, NULL);
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'AUDIT_DELETE_PERIOD', 'YEAR', '2016-10-05 16:41:13', 'AJM', NULL, NULL);
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'AUTHENTICATION', 'INTERNAL', '2008-01-22 14:22:40', 'AJM', '2009-09-28 08:45:44', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'DEFAULT_LANGUAGE', 'en', '2005-07-05 17:20:23', 'AJM', '2005-07-14 17:02:12', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'FORCE_PSWD_CHG', 'Y', '2017-02-13 15:57:14', 'AJM', NULL, NULL);
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'LOGIN_TYPE', 'USER', '2008-10-05 14:53:39', 'AJM', '2017-05-18 09:36:50', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PAGINATION_WIDTH', '7', '2008-10-11 18:02:47', 'AJM', '2008-10-11 22:25:03', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_CHANGE', 'AR', '2003-01-01 12:00:00', 'AJM', '2017-05-09 14:50:13', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_COUNT', NULL, '2003-01-01 12:00:00', 'AJM', '2006-04-24 14:45:39', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_DAYS', NULL, '2003-01-01 12:00:00', 'AJM', '2017-05-09 14:50:14', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_ENCRYPT', 'Y', '2003-01-01 12:00:00', 'AJM', '2009-01-19 12:14:14', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_FORMAT_DIGITS', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_FORMAT_LOWER', NULL, '2003-01-01 12:00:00', 'AJM', '2007-05-17 19:07:00', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_FORMAT_MINLEN', '4', '2003-01-01 12:00:00', 'AJM', '2005-01-15 18:58:07', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_FORMAT_UPPER', NULL, '2003-01-01 12:00:00', 'AJM', '2007-08-20 22:56:55', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_HIDDEN', 'N', '2006-07-18 16:50:30', 'AJM', '2017-05-08 13:53:50', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_RETRIES', '3', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_WARNING', '5', '2006-03-08 22:31:52', 'AJM', '2006-04-24 14:45:39', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SCROLLING_WIDTH', '5', '2008-10-11 18:02:47', 'AJM', '2008-10-11 22:25:03', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_END', NULL, '2006-04-16 14:43:28', 'AJM', '2017-05-25 17:49:41', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_FRIDAY', NULL, '2006-04-16 14:59:25', 'AJM', '2017-05-25 17:49:41', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_MONDAY', NULL, '2006-04-16 14:59:24', 'AJM', '2017-05-25 17:49:41', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_SATURDAY', NULL, '2006-04-16 14:59:25', 'AJM', '2017-05-25 17:49:41', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_START', NULL, '2006-04-16 14:43:28', 'AJM', '2017-05-25 17:49:41', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_SUNDAY', NULL, '2006-04-16 14:59:25', 'AJM', '2017-05-25 17:49:42', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_THURSDAY', NULL, '2006-04-16 14:59:25', 'AJM', '2017-05-25 17:49:42', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_TUESDAY', NULL, '2006-04-16 14:59:24', 'AJM', '2017-05-25 17:49:42', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_WARNING', NULL, '2006-04-16 14:43:28', 'AJM', '2006-04-17 14:59:47', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_WEDNESDAY', NULL, '2006-04-16 14:59:24', 'AJM', '2017-05-25 17:49:42', 'AJM');

REPLACE INTO `mnu_account` (`rdcaccount_id`, `account_name`, `account_desc`, `rdcversion`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('1', 'Shared Account', NULL, '1', '2007-09-13 11:41:52', 'AJM', NULL, NULL);
REPLACE INTO `mnu_account` (`rdcaccount_id`, `account_name`, `account_desc`, `rdcversion`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('2', 'Another account', NULL, '1', '2016-07-01 17:48:01', 'AJM', NULL, NULL);

REPLACE INTO `mnu_motd` (`motd_id`, `motd_subject`, `motd_message`, `start_date`, `end_date`, `role_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('1', 'Welcome to the Demo system. This uses MySQL.', 'Welcome to the Demo system. This uses MySQL.', '2003-12-30', '9999-12-31', NULL, '2009-12-30 14:56:22', 'AJM', '2017-05-17 17:29:12', 'AJM');
REPLACE INTO `mnu_motd` (`motd_id`, `motd_subject`, `motd_message`, `start_date`, `end_date`, `role_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('2', 'News! Mafeking has been relieved!', 'On 17th may 1900 British forces commanded by Colonel B T Mahon of the army of Lord Roberts relieved the town of Mafeking after it had been besieged by the Boers for 217 days.', '2009-05-06', '9999-12-31', NULL, '2017-05-17 17:28:38', 'AJM', NULL, NULL);

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `rdcaccount_id`, `pswd_change_datetime`, `pswd_count`, `force_pswd_chg`, `in_use`, `is_disabled`, `logon_datetime`, `language_id`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'Tony Marston', 'N0GxJ{(,:aR9]lDE', NULL, '2017-05-10 17:58:10', '78', 'N', 'Y', 'N', '2017-07-24 17:31:56', 'en', '2003-01-01', '9999-12-31', '127.0.0.1', 'tony@marston-home.demon.co.uk', 'tony.marston', 'N', '98', 'Europe/London', 'Y', '2003-01-01 12:00:00', 'AJM', '2017-07-20 18:09:22', 'AJM');

REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'GLOBAL', '1', '2014-04-17', '9999-12-31', '2014-04-17 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_name`, `item_desc`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `object_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '1', 'Do something clever', NULL, '2014-04-20', '7', 'N', NULL, NULL, NULL, NULL, NULL, '2014-04-19 13:02:49', 'AJM', NULL, NULL);
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_name`, `item_desc`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `object_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '2', 'Do something', NULL, '2005-09-01', '7', 'Y', NULL, NULL, NULL, NULL, NULL, '2005-07-31 12:38:32', 'AJM', '2006-04-07 14:41:20', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_name`, `item_desc`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `object_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '3', 'Do something else', NULL, '2005-10-01', '7', 'Y', NULL, NULL, NULL, NULL, NULL, '2005-07-31 12:38:59', 'AJM', '2006-04-07 14:41:23', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_name`, `item_desc`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `object_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '4', 'Do something interesting', NULL, '2005-11-01', '7', 'Y', NULL, NULL, NULL, NULL, NULL, '2005-07-31 12:39:20', 'AJM', '2006-04-07 14:41:26', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_name`, `item_desc`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `object_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '5', 'Do something boring', NULL, '2005-12-01', '7', 'Y', NULL, NULL, NULL, NULL, NULL, '2005-07-31 12:39:34', 'AJM', '2006-04-07 14:41:30', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_name`, `item_desc`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `object_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '6', 'Make a new Year\'s Resolution', 'This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text.', '2006-01-01', '7', 'N', NULL, NULL, NULL, NULL, NULL, '2005-07-31 12:40:38', 'AJM', '2010-07-16 16:38:54', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_name`, `item_desc`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `object_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '7', 'Break a new Year\'s Resolution', NULL, '2006-02-01', '7', 'N', NULL, NULL, NULL, NULL, NULL, '2005-07-31 12:40:53', 'AJM', '2006-04-07 14:45:17', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_name`, `item_desc`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `object_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '8', 'Prepare for a long march', NULL, '2006-03-01', '7', 'N', NULL, NULL, NULL, NULL, NULL, '2005-07-31 12:41:09', 'AJM', '2005-07-31 17:41:16', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_name`, `item_desc`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `object_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '9', 'Take a rest after a long march', NULL, '2006-04-01', '7', 'N', NULL, NULL, NULL, NULL, NULL, '2005-07-31 12:41:21', 'AJM', '2005-07-31 17:41:32', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_name`, `item_desc`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `object_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '10', 'May the Fourth be with you', 'Celebrate "Star Wars" day by dressing up in a fancy costume, drinking lots of alcohol, and making a fool of yourself.', '2006-05-01', '7', 'N', NULL, NULL, NULL, NULL, NULL, '2005-07-31 12:41:35', 'AJM', '2017-05-17 14:08:06', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_name`, `item_desc`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `object_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '11', 'Watch out for June bugs', NULL, '2006-06-01', '7', 'Y', NULL, NULL, NULL, NULL, NULL, '2005-07-31 12:41:49', 'AJM', '2006-04-07 14:45:42', 'AJM');

REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_name`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '1', 'mnu_user(upd1)a', 'Change Password', '1', NULL, '2010-07-31 15:39:41', 'AJM', '2017-07-20 15:50:37', 'AJM');
REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_name`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '2', 'mnu_todo(list2)', 'To-Do', '2', NULL, '2010-07-31 15:39:41', 'AJM', '2017-07-20 15:50:44', 'AJM');
REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_name`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '3', 'mnu_motd(list1)', 'MOTD', '3', NULL, '2010-07-31 15:39:42', 'AJM', '2017-07-20 15:50:44', 'AJM');

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `rdcaccount_id`, `pswd_change_datetime`, `pswd_count`, `force_pswd_chg`, `in_use`, `is_disabled`, `logon_datetime`, `language_id`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'batch', 'K}_$nQDAm9U}2s$+', NULL, '2014-06-05 15:53:55', '2', 'N', 'N', 'N', '2014-06-05 15:56:08', NULL, '2014-06-05', '9999-12-31', '127.0.0.1', 'BATCH@null.null', NULL, 'N', NULL, 'Europe/London', 'N', '2014-06-05 15:53:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'BATCH', '1', '2014-06-05', '9999-12-31', '2014-06-05 15:55:46', 'AJM', NULL, NULL);

REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_name`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', '1', 'mnu_user(upd1)a', 'Change Password', '1', NULL, '2014-06-05 15:53:56', 'AJM', NULL, NULL);
REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_name`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', '2', 'mnu_todo(list2)', 'To-Do', '2', NULL, '2014-06-05 15:53:56', 'AJM', NULL, NULL);
REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_name`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', '3', 'mnu_motd(list1)', 'MOTD', '3', NULL, '2014-06-05 15:53:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `rdcaccount_id`, `pswd_change_datetime`, `pswd_count`, `force_pswd_chg`, `in_use`, `is_disabled`, `logon_datetime`, `language_id`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'Demo User', '~n:.^#l::y(@SGu!', NULL, '2009-07-22 00:49:59', '67', 'N', 'N', 'N', '2015-11-03 09:57:49', NULL, '2003-01-01', '9999-12-31', '127.0.0.1', 'DEMO@null.null', NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2015-11-03 09:58:14', 'DEMO');

REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'DEMO', '1', '2014-04-24', '9999-12-31', '2014-04-24 05:12:01', 'AJM', '2017-07-20 15:59:51', 'AJM');
REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'AUDIT', '2', '2014-04-19', '9999-12-31', '2014-04-19 12:24:18', 'AJM', '2017-07-20 15:59:56', 'AJM');
REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'MENU-RO', '3', '2014-04-19', '9999-12-31', '2014-04-19 08:51:13', 'AJM', '2017-07-20 16:00:01', 'AJM');
REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'DICT-RO', '4', '2014-04-19', '9999-12-31', '2014-04-19 12:24:30', 'AJM', '2017-07-20 16:00:06', 'AJM');
REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'WORKFLOW-RO', '5', '2014-04-20', '9999-12-31', '2014-04-20 12:50:47', 'AJM', '2017-07-20 16:00:06', 'AJM');

REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_name`, `item_desc`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `object_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', '1', 'Do something interesting', NULL, '2014-04-20', '7', 'N', NULL, NULL, NULL, NULL, NULL, '2014-04-19 12:32:07', 'DEMO', '2017-05-17 13:26:50', 'AJM');

REPLACE INTO `mnu_user_ip_address` (`user_id`, `ip_address`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', '::1', '2017-05-21 08:44:59', 'AJM', NULL, NULL);
REPLACE INTO `mnu_user_ip_address` (`user_id`, `ip_address`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', '127.0.0.1', '2017-05-21 08:44:44', 'AJM', NULL, NULL);
REPLACE INTO `mnu_user_ip_address` (`user_id`, `ip_address`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', '192.168.1.64', '2017-05-21 08:45:30', 'AJM', NULL, NULL);
REPLACE INTO `mnu_user_ip_address` (`user_id`, `ip_address`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', '192.168.1.65', '2017-05-21 08:45:43', 'AJM', NULL, NULL);

REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_name`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', '1', 'mnu_user(upd1)a', 'Change Password', '1', NULL, '2014-04-19 12:36:38', 'DEMO', NULL, NULL);
REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_name`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', '2', 'mnu_todo(list2)', 'To-Do', '2', NULL, '2014-04-19 12:36:38', 'DEMO', NULL, NULL);
REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_name`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', '3', 'mnu_motd(list1)', 'MOTD', '3', NULL, '2014-04-19 12:36:39', 'DEMO', NULL, NULL);

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `rdcaccount_id`, `pswd_change_datetime`, `pswd_count`, `force_pswd_chg`, `in_use`, `is_disabled`, `logon_datetime`, `language_id`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', 'Fred Bloggs', ';Rc_Gx(3~XPrAZCD', NULL, '2006-02-01 20:10:05', '10', 'N', 'N', 'N', '2006-03-08 22:12:49', NULL, '2003-01-01', '9999-12-31', '127.0.0.1', 'FB@null.null', NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2009-07-29 14:51:42', 'AJM');

REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', 'DEMO', '1', '2014-04-24', '9999-12-31', '2014-04-24 05:12:35', 'AJM', NULL, NULL);
REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', 'AUDIT', '9', '2014-04-20', '9999-12-31', '2014-04-20 11:53:24', 'AJM', NULL, NULL);
REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', 'DICT-RO', '9', '2014-04-20', '9999-12-31', '2014-04-20 11:53:44', 'AJM', NULL, NULL);
REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', 'MENU-RO', '9', '2014-04-20', '9999-12-31', '2014-04-20 11:53:09', 'AJM', '2014-04-24 05:12:35', 'AJM');
REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', 'WORKFLOW-RO', '9', '2014-04-20', '9999-12-31', '2014-04-20 12:51:57', 'AJM', NULL, NULL);

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `rdcaccount_id`, `pswd_change_datetime`, `pswd_count`, `force_pswd_chg`, `in_use`, `is_disabled`, `logon_datetime`, `language_id`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('JS', 'Joe Soap', ';,SA1Qo08{(lk.Y-', NULL, '2004-08-01 16:50:10', '0', 'N', 'N', 'N', NULL, NULL, '2003-01-01', '9999-12-31', NULL, 'JS@null.null', NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2005-11-02 18:05:54', 'AJM');

REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('JS', 'DEMO', '1', '2014-04-24', '9999-12-31', '2014-04-24 05:13:06', 'AJM', NULL, NULL);
REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('JS', 'AUDIT', '9', '2014-04-20', '9999-12-31', '2014-04-20 11:56:02', 'AJM', NULL, NULL);
REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('JS', 'DICT-RO', '9', '2014-04-20', '9999-12-31', '2014-04-20 11:55:48', 'AJM', NULL, NULL);
REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('JS', 'MENU-RO', '9', '2014-04-20', '9999-12-31', '2014-04-20 11:55:33', 'AJM', '2014-04-24 05:13:07', 'AJM');
REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('JS', 'WORKFLOW-RO', '9', '2014-04-20', '9999-12-31', '2014-04-20 12:52:49', 'AJM', NULL, NULL);

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `rdcaccount_id`, `pswd_change_datetime`, `pswd_count`, `force_pswd_chg`, `in_use`, `is_disabled`, `logon_datetime`, `language_id`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MANAGER', 'Manager', 'Y3YP&CWh;HW`+5N`', NULL, '2004-08-01 16:50:42', '0', 'N', 'N', 'N', NULL, NULL, '2003-01-01', '9999-12-31', NULL, 'MANAGER@null.null', NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2005-11-02 18:05:54', 'AJM');

REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MANAGER', 'GLOBAL', '1', '2014-04-17', '9999-12-31', '2014-04-17 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `rdcaccount_id`, `pswd_change_datetime`, `pswd_count`, `force_pswd_chg`, `in_use`, `is_disabled`, `logon_datetime`, `language_id`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MGR', 'MGR', 'Nz-3jN6+lK@Ii^DE', NULL, '2004-08-01 16:51:04', '18', 'N', 'Y', 'N', '2017-05-29 10:04:12', NULL, '2003-01-01', '9999-12-31', '127.0.0.1', 'MGR@null.null', NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2005-11-02 18:05:54', 'AJM');

REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MGR', 'GLOBAL', '1', '2014-04-17', '9999-12-31', '2014-04-17 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_name`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MGR', '1', 'mnu_user(upd1)a', 'Change Password', '1', NULL, '2010-07-31 15:39:41', 'AJM', NULL, NULL);
REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_name`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MGR', '2', 'mnu_todo(list2)', 'To-Do', '2', NULL, '2010-07-31 15:39:41', 'AJM', NULL, NULL);
REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_name`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MGR', '3', 'mnu_motd(list1)', 'MOTD', '3', NULL, '2010-07-31 15:39:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `rdcaccount_id`, `pswd_change_datetime`, `pswd_count`, `force_pswd_chg`, `in_use`, `is_disabled`, `logon_datetime`, `language_id`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SURVEY', 'SURVEY (supervisor)', '+wwjJMgFAuJ(1$qS', NULL, '2004-08-01 16:52:09', '0', 'N', 'N', 'N', '2003-10-09 19:24:40', NULL, '2003-01-01', '9999-12-31', NULL, 'SURVEY@null.null', NULL, 'N', NULL, NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2005-11-02 18:05:54', 'AJM');

REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SURVEY', 'SURVEY', '1', '2014-04-17', '9999-12-31', '2014-04-17 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `rdcaccount_id`, `pswd_change_datetime`, `pswd_count`, `force_pswd_chg`, `in_use`, `is_disabled`, `logon_datetime`, `language_id`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'user1', '$Y/R7/=t8_W98TI(', NULL, '2005-07-31 15:10:17', '1', 'N', 'N', 'N', '2005-07-31 15:10:52', NULL, '2005-07-31', '9999-12-31', NULL, 'USER1@null.null', NULL, 'N', NULL, NULL, 'N', '2005-07-31 15:10:17', 'AJM', '2005-11-02 18:05:54', 'AJM');

REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'USER', '1', '2014-04-20', '9999-12-31', '2014-04-20 10:56:58', 'AJM', '2014-04-20 10:57:23', 'AJM');

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `rdcaccount_id`, `pswd_change_datetime`, `pswd_count`, `force_pswd_chg`, `in_use`, `is_disabled`, `logon_datetime`, `language_id`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'user2', '$Y/R7uD,DS=6R,a?', NULL, '2005-07-31 15:10:32', '1', 'N', 'N', 'N', '2005-07-31 15:11:06', NULL, '2005-07-31', '9999-12-31', NULL, 'USER2@null.null', NULL, 'N', NULL, NULL, 'N', '2005-07-31 15:10:32', 'AJM', '2005-11-02 18:05:54', 'AJM');

REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'USER', '1', '2014-04-20', '9999-12-31', '2014-04-20 10:57:56', 'AJM', '2014-04-20 11:02:04', 'AJM');

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `rdcaccount_id`, `pswd_change_datetime`, `pswd_count`, `force_pswd_chg`, `in_use`, `is_disabled`, `logon_datetime`, `language_id`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'user3', '$Y/R75pZ~Uy#iyF=', NULL, '2005-07-31 15:10:45', '1', 'N', 'N', 'N', '2005-07-31 15:12:38', NULL, '2005-07-31', '9999-12-31', NULL, 'USER3@null.null', NULL, 'N', NULL, NULL, 'N', '2005-07-31 15:10:45', 'AJM', '2005-11-02 18:05:54', 'AJM');

REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'USER', '1', '2014-04-20', '9999-12-31', '2014-04-20 10:58:23', 'AJM', '2014-04-20 11:02:18', 'AJM');

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `rdcaccount_id`, `pswd_change_datetime`, `pswd_count`, `force_pswd_chg`, `in_use`, `is_disabled`, `logon_datetime`, `language_id`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('VPD', 'VPD', 'N`Uu$BBOW?;bBpk7', '2', '2007-09-13 17:53:24', '14', 'N', 'Y', 'N', '2007-09-18 11:46:49', NULL, '2007-09-13', '9999-12-31', '127.0.0.1', 'VPD@null.null', NULL, 'N', NULL, NULL, 'N', '2007-09-13 17:53:24', 'AJM', '2009-01-19 12:14:16', 'AJM');

REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('VPD', 'GLOBAL', '1', '2014-04-17', '9999-12-31', '2014-04-17 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `rdcaccount_id`, `pswd_change_datetime`, `pswd_count`, `force_pswd_chg`, `in_use`, `is_disabled`, `logon_datetime`, `language_id`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('VPD2', 'VPD2', 'v5qiJNNw6EpwgUxn', '2', '2009-07-11 10:30:36', '7', 'N', 'Y', 'N', '2009-08-17 14:44:35', NULL, '2009-07-10', '9999-12-31', '127.0.0.1', 'VPD2@null.null', NULL, 'N', NULL, NULL, 'N', '2009-07-10 13:35:19', 'AJM', '2009-07-11 10:30:36', 'AJM');

REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('VPD2', 'GLOBAL', '1', '2014-04-17', '9999-12-31', '2014-04-17 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `rdcaccount_id`, `pswd_change_datetime`, `pswd_count`, `force_pswd_chg`, `in_use`, `is_disabled`, `logon_datetime`, `language_id`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('VPD2A', 'VPD2a', '$nKyd39nT%mzlq=_', '2', '2009-07-14 10:43:11', '0', 'N', 'N', 'N', NULL, NULL, '2009-07-14', '9999-12-31', NULL, 'VPD2A@null.null', NULL, 'N', NULL, NULL, 'N', '2009-07-14 10:43:11', 'VPD2', NULL, NULL);

REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('VPD2A', 'DEMO', '1', '2014-04-17', '9999-12-31', '2014-04-17 00:00:00', 'VPD2', NULL, NULL);

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `rdcaccount_id`, `pswd_change_datetime`, `pswd_count`, `force_pswd_chg`, `in_use`, `is_disabled`, `logon_datetime`, `language_id`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `allow_responsive_gui`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('VPD3', 'VPD3', 'v5q$5MC3+7!21QvP', '3', '2009-07-14 10:41:32', '1', 'N', 'Y', 'N', '2009-08-17 13:29:56', NULL, '2009-07-14', '9999-12-31', '127.0.0.1', 'VPD3@null.null', NULL, 'N', NULL, NULL, 'N', '2009-07-14 10:41:32', 'AJM', '2009-07-14 10:41:50', 'AJM');

REPLACE INTO `mnu_user_role` (`user_id`, `role_id`, `sort_seq`, `start_date`, `end_date`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('VPD3', 'GLOBAL', '1', '2014-04-17', '9999-12-31', '2014-04-17 00:00:00', 'AJM', NULL, NULL);

-- finished
