-- file created on October 26, 2013, 4:15 pm
    
REPLACE INTO `mnu_subsystem` (`subsys_id`, `subsys_desc`, `subsys_dir`, `task_prefix`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU', 'Menu and Security system', 'menu', 'mnu_', '2003-01-01 12:00:00', 'AJM', '2006-04-22 09:39:02', 'AJM');

REPLACE INTO `mnu_language` (`language_id`, `language_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DE', 'German (Germany) [de]', '2008-03-06 12:02:19', 'AJM', NULL, NULL);
REPLACE INTO `mnu_language` (`language_id`, `language_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('EN', 'English [en] **default**', '2008-01-09 15:19:37', 'AJM', '2008-01-09 15:27:10', 'AJM');
REPLACE INTO `mnu_language` (`language_id`, `language_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('EN-US', 'English (United States) [en_US]', '2008-09-11 17:58:18', 'AJM', '2008-09-11 17:59:03', 'AJM');
REPLACE INTO `mnu_language` (`language_id`, `language_name`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SV', 'Swedish (Sweden) [sv]', '2009-07-28 15:12:23', 'AJM', '2009-08-13 11:17:50', 'AJM');

REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADD1', 'ADD1 - Insert a single record', 'This will allow the user to add a single record to a database table.

This will call the \'insertRecord\' method just once.', 'Y', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:38:46', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADD2', 'ADD2 - Insert a single record', 'This will add an occurrence to the MANY entity in a ONE-to-MANY relationship with the primary key of the ONE entity being passed down from the previous screen.

This will call the \'insertRecord\' method just once.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:38:59', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADD3', 'ADD3 - Insert multiple records without user dialog', 'This will add records to the database without any dialog with the user.

It will use the primary key supplied by the previous screen and one or more primary keys selected in a popup screen which will be called next.

This uses repeated calls to the \'insertRecord\' method.', 'N', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:39:10', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADD4', 'ADD4 - Insert one or more records without user dialog', 'This will allow one or more database records to be created without any dialog with the user.

Details of the parent table are passed down in $where.

This will use the \'insertMultiple\' method.', 'N', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-10 22:33:14', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADD5', 'ADD5 - Insert mutiple records', 'This will allow several database records to be created from a single input screen.

Details of the parent table are passed down in $where.

This will use the \'insertMultiple\' method.', 'Y', 'Y', 'N', '2008-03-28 19:00:53', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'BATCH - Background process', 'This process will be run in the background as it may require to run longer than the limit available for web pages. The output will be stored in the LOGS directory.', 'N', 'N', 'N', '2008-11-24 11:39:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEL1', 'DEL1 - Delete a single record', 'This will delete a single record from the database using the primary key passed down by the previous screen.

This will call the \'deleteRecord\' method.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:39:45', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEL2', 'DEL2 - Delete multiple records without user dialog', 'This will delete multiple records one at a time using the primary keys passed down from the previous screen.

This uses the \'deleteMultiple\' method.', 'N', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-10-01 16:56:16', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEL3', 'DEL3 - Delete multiple records without user dialog', 'This will call the \'deleteSelection\' method to delete/update a selection of records using the primary keys passed down from the previous screen.', 'N', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-09-08 11:58:29', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEL4', 'DEL4 - Delete parent and children', 'This will allow the user to delete a single record from the parent table, plus all related occurrences from the child table.

The primary key(s) for the occurrence(s) on the parent table is passed down by the previous screen.

This will call the \'deleteRecord\' method.', 'Y', 'Y', 'N', '2006-03-11 14:28:33', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ENQ1', 'ENQ1 - Enquire a single record', 'This will read a single record from the database using the primary key passed down by the previous screen and display it to the user.

If multiple rows are selected then scrolling options will be provided.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:56:48', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ERASE1', 'ERASE1 - Delete a record and all child records', 'This will delete a single record from the database using the primary key passed down by the previous screen. It will also delete *ALL* related occurrences on child tables.

This will call the \'eraseRecord\' method.', 'Y', 'Y', 'N', '2005-12-06 17:40:51', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FILEDOWNLOAD', 'FILEDOWNLOAD - File Download', 'This will allow the user to download a file from the server to the client. The user selects an entity which contains the name of the file to be downloaded, then activates this transaction by pressing a navigation button.', 'N', 'Y', 'N', '2006-07-26 17:01:40', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FILEPICKER', 'FILEPICKER - File Picker', 'This will allow the user to select the name of a file.', 'Y', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:40:44', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FILEUPLOAD', 'FILEUPLOAD - File Upload', 'This will allow the user to upload a file from the client to the server. The file can be limited to a range of file types and a maximum size.', 'Y', 'N', 'N', '2005-12-18 14:50:32', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('LINK1', 'LINK1 - Update LINK table', 'This deals with a ONE-to-MANY-to-ONE relationship where MANY indicates a yes/no link between both of the ONE tables.

This allows multiple occurrences of MANY to be created, modified or deleted in a single screen.

This will call the \'updateLinkData\' method.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('LIST1', 'LIST1 - List multiple records', 'This will list all available rows from a database table one page at a time with (usually) 10 rows in each page.

Links at the bottom of the page will allow the user to jump to the first/last/previous/next page.

The selection may be refined by using the SEARCH button. This will bring up another screen into which selection criteria can be entered.', 'Y', 'N', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:57:00', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('LIST2', 'LIST2 - List multiple children', 'This will list rows of MANY in a ONE-to-MANY relationship one page at a time with (usually) 10 rows in each page.

The primary key of ONE will be passed down from the previous screen.

Links at the bottom of the page will allow the user to jump to the first/last/previous/next page.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2007-03-20 18:00:48', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('LIST3', 'LIST3 - List multiple children', 'This will list rows of MANY(1) and MANY(2) in a ONE-to-MANY(1)-to-MANY(2) relationship.

MANY(1)-to-MANY(2) is another ONE-to-MANY relationship

The primary key of ONE will be passed down from the previous screen.

This will then be passed to MANY(1) for processing.

The primary key of MANY(1) will then be passed to MANY(2) for processing.

Links at the bottom of the page will allow the user to jump to the first/last/previous/next page.', 'Y', 'Y', 'N', '2005-06-22 23:17:59', 'AJM', '2007-04-09 13:47:05', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MENU', 'MENU - Display menu options', 'This will display a list of options and allow the user to select one.', 'Y', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:57:21', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MULTI1', 'MULTI1 - Update/Insert/delete multiple records', 'This will take a selection of primary keys and allow individual databases rows to be inserted, updated or deleted.

The identity of the row(s) to be processed is passed down from the previous screen, and scrolling between rows is controlled by the setScrollArray() and getScrollItem() methods

This will deal with one row at a time and will call either the \'insertRecord\', \'updateRecord\' or \'deleteRecord\' methods as appropriate.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2005-06-24 23:20:22', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MULTI2', 'MULTI2 - Modify multiple records in a 2-level hierarchy', 'This will allow multiple MANY occurrences in a ONE-to-MANY relationship to be modified in a single operation. 

The primary key of ONE is passed down from the previous screen.

This will call the \'updateMultiple\' method.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2005-06-24 23:31:18', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MULTI3', 'MULTI3 - Modify multiple records in a 3-level hierarchy', 'This will allow updates to multiple occurrences of the CHILD table in a GRANDPARENT-PARENT-CHILD relationship n a single operation. 

The primary key of GRANDPARENT is passed down from the previous screen.

Occurrences of PARENT will start at the first available, with a scrolling area providing hyperlinks/buttons to step forwards or backwards through the available occurrences.

Occurrences of CHILD will start at the first available page, with a pagination area providing hyperlinks/buttons to step forwards or backwards through the available occurrences.

This will call the \'updateMultiple\' method for the CHILD entity.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2005-06-24 23:31:30', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MULTI4', 'MULTI4 - Update both in a ONE-to-MANY relationship', 'This will allow multiple MANY occurrences in a ONE-to-MANY relationship to be modified in a single operation. 

The primary key of ONE is passed down from the previous screen.

This will call the \'updateMultiple\' method.', 'Y', 'Y', 'N', '2005-06-24 23:25:47', 'AJM', '2006-10-07 19:01:30', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MULTI5', 'MULTI5 - Select/Modify multiple rows in a 2-level hierarchy', 'The top zone will act as a selection screen which will provide the selection criteria to populate the bottom zone with multiple occurrences.

The bottom zone is amendable by default, but can be made read-only.', 'Y', 'Y', 'N', '2013-06-10 13:54:36', 'AJM', '2013-10-26 15:35:24', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MULTI6', 'MULTI6 - Select/Modify multiple rows in a 3-level hierarchy', 'The top zone will act as a selection screen which will provide the selection criteria to populate the middle and inner zones with multiple occurrences.

The middle and inner zones are amendable by default, but can be made read-only.', 'Y', 'Y', 'N', '2013-10-17 13:39:29', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('OTHER', 'Other - Miscellaneous - Undefined', 'This is for anything whch does not fall into any recognisable category.', 'N', 'N', 'N', '2007-01-10 18:21:02', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('OUTPUT1', 'OUTPUT1 - Output records to a CSV file', 'This will extract all available rows from a database table and output them to a CSV file which will be downloaded to the client device.

It will use any search criteria that is passed down from the calling screen.', 'N', 'N', 'N', '2006-08-11 16:49:59', 'AJM', '2006-08-11 17:01:35', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('OUTPUT2', 'OUTPUT2 - Output records to a PDF file (List view)', 'This will extract all available rows from a database table and output them to a PDF file which will be downloaded to the client device.

It will use any search criteria that is passed down from the calling screen.

List view produces column headings on the top of the page, with each database record taking up one line across the page.', 'N', 'N', 'N', '2006-08-13 11:11:04', 'AJM', '2006-08-16 22:29:20', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('OUTPUT3', 'OUTPUT3 - Output records to a PDF file (Detail view)', 'This will extract all available rows from a database table and output them to a PDF file which will be downloaded to the client device.

It will use any search criteria that is passed down from the calling screen.

Detail view produces one page per database record, one line per field, with labels on the left and values on the right.', 'N', 'N', 'N', '2006-08-14 13:30:18', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('OUTPUT4', 'OUTPUT4 - Output selected fields to a CSV file', 'This will extract all available rows from a database table and output selected fields to a CSV file which will be downloaded to the client device.

The user is first shown a list of available fields and asked to select which ones should be included in the output.

It will use any search criteria that is passed down from the calling screen.', 'Y', 'N', 'N', '2008-06-15 11:49:56', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('OUTPUT5', 'OUTPUT5 - Output records to a PDF file (Address Labels)', 'This will extract all available rows from a database table and output them to a PDF file which will be downloaded to the client device.

It will use any search criteria that is passed down from the calling screen.

Label view constructs one label from each database record, then prints several labels across each line.', 'N', 'N', 'N', '2011-08-24 10:11:16', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('POPUP1', 'POPUP1 - Choose records (uses LIST1)', 'This shows the user a list of available rows from a database table and allows the user to choose one (or more) for processing in the previous screen.

This uses the LIST1 pattern.', 'Y', 'N', 'Y', '2006-10-06 13:07:29', 'AJM', '2006-10-06 13:12:02', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('POPUP2', 'POPUP2 - Choose records (uses LIST2)', 'This shows the user a list of available rows from a database table and allows the user to choose one (or more) for processing in the previous screen.

This uses the LIST2 pattern.', 'Y', 'N', 'Y', '2006-10-06 13:08:16', 'AJM', '2006-10-06 13:12:05', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('POPUP3', 'POPUP3 - Choose records (uses TREE1)', 'This shows the user a list of available rows from a database table and allows the user to choose one (or more) for processing in the previous screen.

This uses the TREE1 pattern.', 'Y', 'N', 'Y', '2006-10-06 13:10:16', 'AJM', '2006-10-06 13:12:08', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('POPUP4', 'POPUP4 - Choose records (uses TREE2)', 'This shows the user a list of available rows from a database table and allows the user to choose one (or more) for processing in the previous screen.

This uses the TREE2 pattern.', 'Y', 'N', 'Y', '2006-10-06 13:10:45', 'AJM', '2006-10-06 13:12:11', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SRCH', 'SRCH - Enter selection criteria', 'This will show a blank detail screen and allow the user to specify search criteria that will then be returned to the previous screen for action.', 'Y', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2005-11-27 17:05:50', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('TIMETABLE1', 'TIMETABLE1 - List timetable for a selected entity', 'This will list rows of TIMETABLE/SCHEDUILE table for a selected entity. It will show the schedule for every day in the week.

The primary key of selected entity will be passed down from the previous screen.

Links at the bottom of the page will allow the user to jump to the first/last/previous/next page.', 'Y', 'Y', 'N', '2006-07-10 21:35:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('TREE1', 'TREE1 - List Tree Structure (fixed)', 'This will list nodes in a tree structure and allow the user to expand and contract nodes individually.

This uses a stand-alone TREE_NODE table.

This uses the \'getNodeData\' method to retrieve the data for the selected nodes.', 'Y', 'Y', 'Y', '2003-01-01 12:00:00', 'AJM', '2005-12-26 12:29:52', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('TREE2', 'TREE2 - List Tree Structure (flexible)', 'This will list nodes in a tree structure and allow the user to expand and contract nodes individually.

This uses the TREE_TYPE, TREE_LEVEL and TREE_NODE database tables so that different levels can be defined for different tree types.

The TREE_TYPE to be displayed will be passed down by the previous screen.

This uses the \'getNodeData\' method to retrieve the data for the selected nodes.', 'Y', 'Y', 'Y', '2003-01-01 12:00:00', 'AJM', '2006-10-30 15:44:55', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('UPD1', 'UPD1 - Update a single record', 'This will allow a single database record (row) to be displayed and updated.

The primary key of the row is passed down from the previous screen. If multiple rows are selected then scrolling options will be provided.

This will call the \'updateRecord\' method.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:43:21', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('UPD2', 'UPD2 - Update multiple records', 'This will update multiple rows in the database.

The rows are identified using a combination of values supplied by the previous screen plus values selected in a popup screen which will be called next.

This will call the \'updateSelection\' method.', 'N', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2007-04-15 15:18:45', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('UPD3', 'UPD3 - Update Control record', 'This will update multiple rows in a \'control\' table in the database.

Each row contains a \'field_id\' and a \'field_value\' column, and they are treated as searate fields from a sigle row. This design allows \'fields\' (rows) to be added or deleted at will without having to alter the structure of the table.

This will call the \'updateSelection\' method.', 'Y', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-28 11:56:43', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('UPD4', 'UPD4 - Update one or more records without user dialog', 'This will allow one or more database rows to be updated without being displayed.

The identity of the row(s) to be updated is passed down from the previous screen.

This will call the \'updateMultiple\' method.', 'N', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-28 12:37:18', 'AJM');
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('UPD5', 'UPD5 - Insert/Update one or more records without user dialog', 'This will allow one or more database rows to be inserted or updated without being displayed.

The identity of the row(s) to be processed is passed down from the previous screen so that they can be assembled.

This will call the \'insertOrUpdate\' method which will check if each record currently exists, then insert or update as appropriate.', 'N', 'Y', 'N', '2007-04-15 15:33:17', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'Logistics Administrator', 'main_menu', 'N', 'N', '2005-11-18 11:17:09', 'RNP', NULL, NULL);
REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'Batch (background) Processing', 'main_menu', 'N', 'N', '2010-04-13 11:55:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'Demonstration Class', 'main_menu', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2009-07-22 00:55:33', 'AJM');
REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEV', 'Development', 'main_menu', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('GLOBAL', 'Global Access', 'main_menu', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'Read Only', 'main_menu', 'N', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'Sales Desk', 'applications', 'N', 'N', '2012-05-26 15:29:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'Supplier Portal', 'order_supplier', 'N', 'Y', '2008-10-10 11:55:56', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SURVEY', 'SURVEY (supervisor)', 'main_menu', 'N', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'Ordinary everyday User', 'main_menu', 'Y', 'N', '2006-09-05 13:31:49', 'AJM', '2010-10-07 15:48:23', 'AJM');
REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'User Class 1', 'proto', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2010-10-07 15:47:57', 'AJM');
REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'User Class 2', 'main_menu', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2010-10-07 15:48:02', 'AJM');
REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `is_external_auth_off`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'User Class 3', 'main_menu', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2010-10-07 15:48:06', 'AJM');

REPLACE INTO `mnu_time_limit_role` (`role_id`, `seq_no`, `scheduled_start_time`, `scheduled_end_time`, `scheduled_monday`, `scheduled_tuesday`, `scheduled_wednesday`, `scheduled_thursday`, `scheduled_friday`, `scheduled_saturday`, `scheduled_sunday`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', '1', '09:00:00', '18:00:00', '1', '1', '1', '1', '1', '0', '0', '2013-08-19 15:25:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('logon', 'Logon screen', 'Logon', 'PROC', 'logon.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'Y', NULL, NULL, NULL, '2005-07-20 15:00:06', 'AJM', '2006-03-12 12:11:11', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'logon', '2012-02-29 21:54:57', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('logon', 'Welcome to the RADICORE Menu & Security system.

You must enter a valid user id and password before you can continue any further.

The password field is case-sensitive, so watch out for the \'caps lock\' key.

Refer to <a href=\"%root%/mnu_logon.html\">Logon screen</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-05-08 10:31:18', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu', 'Home Page', 'Home', 'PROC', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'Y', NULL, NULL, 'N', NULL, NULL, NULL, '2004-08-18 12:19:08', 'AJM', '2004-08-18 12:42:24', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu', 'audit_logon_errors(list)', '003', 'Logon Errors', 'N', '2006-03-08 14:52:45', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu', 'batch_log(filepicker)', '008', 'Batch Log Files', 'N', '2008-11-21 12:09:53', 'AJM', '2010-04-29 16:57:19', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu', 'mnu_favourite(list2)', '010', 'List Favourites', 'Y', '2010-07-20 10:35:15', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu', 'mnu_session(upd3)', '004', 'Session Data', 'N', '2006-04-06 19:39:09', 'AJM', '2007-09-10 11:53:31', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu', 'py_email_signature(multi1)', '007', 'Email Signature', 'Y', '2010-04-29 16:56:50', 'AJM', '2010-04-29 16:57:20', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'menu', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'menu', '2010-04-13 11:55:01', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'menu', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'menu', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'menu', '2012-05-26 15:29:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'menu', '2009-01-19 12:03:02', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'menu', '2012-02-29 21:54:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'menu', '2011-07-22 14:07:41', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'menu', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'menu', '2011-07-22 15:02:08', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu', 'This is the first page the user sees after passing through the logon screen. It is also the page that is shown whenever the user selects an option from the menu bar instead of the navigation bar.

Refer to <a href=\"%root%/mnu_menu.html\">Menu/Home Page</a> for full details.', '2005-07-02 18:09:35', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(add1)', 'Add Hosting Account', 'New', 'PROC', 'mnu_account(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2007-09-13 11:30:42', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(add1)', 'This will allow a new record to be added to the ACCOUNT table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_account(add1).html\">Add Account</a> for full details.', '2008-01-04 10:27:45', 'AJM', '2013-06-11 15:40:40', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(del1)', 'Delete Hosting Account', 'Delete', 'PROC', 'mnu_account(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2007-09-13 11:30:42', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(del1)', 'This will display a record from the ACCOUNT table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_account(del1).html\">Delete Account</a> for full details.', '2008-01-04 10:32:08', 'AJM', '2013-06-11 15:41:00', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(enq1)', 'Enquire Hosting Account', 'Read', 'PROC', 'mnu_account(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2007-09-13 11:30:42', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(enq1)', 'This will display the contents of a record from the ACCOUNT table.

Refer to <a href=\"%root%/mnu_account(enq1).html\">Enquire Account</a> for full details.', '2008-01-04 10:33:41', 'AJM', '2013-06-11 15:41:13', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(list1)', 'List Hosting Account', 'Hosting Account', 'PROC', 'mnu_account(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2007-09-13 11:30:42', 'AJM', '2011-07-22 15:40:17', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-09-13 11:30:43', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(list1)', 'mnu_account(add1)', '001', 'New', 'N', '2007-09-13 11:30:43', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(list1)', 'mnu_account(del1)', '004', 'Delete', 'Y', '2007-09-13 11:30:43', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(list1)', 'mnu_account(enq1)', '002', 'Read', 'Y', '2007-09-13 11:30:43', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(list1)', 'mnu_account(search)', '005', 'Search', 'N', '2007-09-13 11:30:43', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(list1)', 'mnu_account(upd1)', '003', 'Update', 'Y', '2007-09-13 11:30:43', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(list1)', 'This will list records on the ACCOUNT table.

Refer to <a href=\"%root%/mnu_account(list1).html\">List Account</a> for full details.', '2008-01-04 10:50:02', 'AJM', '2013-06-11 15:41:22', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(search)', 'Search Hosting Account', 'Search', 'PROC', 'mnu_account(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2007-09-13 11:30:43', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_account(search)', '2009-02-10 11:10:50', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(search)', 'This will allow search criteria to be entered for the ACCOUNT table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_account(search).html\">Search Account</a> for full details.', '2008-01-04 10:35:17', 'AJM', '2013-06-11 15:41:31', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(upd1)', 'Update Hosting Account', 'Update', 'PROC', 'mnu_account(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2007-09-13 11:30:42', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_account(upd1)', 'This will display the contents of a record from the ACCOUNT table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_account(upd1).html\">Update Account</a> for full details.', '2008-01-04 10:36:51', 'AJM', '2013-06-11 15:41:40', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'Maintain Menu Controls', 'Menu Controls', 'PROC', 'mnu_control(upd3).php', 'N', 'UPD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 10:44:38', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'audit_ssn(batch)delete', '001', 'Delete Audit data', 'N', '2012-01-24 16:29:15', 'AJM', '2012-01-24 16:30:07', 'AJM');

REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'AUTHENTICATION', NULL, '2009-02-10 11:26:05', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'DEFAULT_LANGUAGE', NULL, '2006-04-10 09:36:18', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'LOGIN_TYPE', NULL, '2009-02-10 11:28:12', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PAGINATION_WIDTH', NULL, '2009-02-10 11:23:14', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_CHANGE', NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_COUNT', NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_DAYS', NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_ENCRYPT', NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_FORMAT_DIGITS', NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_FORMAT_LOWER', NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_FORMAT_MINLEN', NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_FORMAT_UPPER', NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_HIDDEN', NULL, '2006-07-18 18:27:46', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_RETRIES', NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'PSWD_WARNING', NULL, '2006-04-10 09:36:40', 'AJM', '2007-09-10 10:44:37', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SCROLLING_WIDTH', NULL, '2009-02-10 11:23:23', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_END', NULL, '2006-04-17 09:30:12', 'AJM', '2007-09-10 10:44:38', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_FRIDAY', NULL, '2006-04-17 09:30:58', 'AJM', '2007-09-10 10:44:38', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_MONDAY', NULL, '2006-04-17 09:30:27', 'AJM', '2007-09-10 10:44:38', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_SATURDAY', NULL, '2006-04-17 09:31:05', 'AJM', '2007-09-10 10:44:38', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_START', NULL, '2006-04-17 09:30:06', 'AJM', '2007-09-10 10:44:38', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_SUNDAY', NULL, '2006-04-17 09:31:11', 'AJM', '2007-09-10 10:44:38', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_THURSDAY', NULL, '2006-04-17 09:30:51', 'AJM', '2007-09-10 10:44:38', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_TUESDAY', NULL, '2006-04-17 09:30:35', 'AJM', '2007-09-10 10:44:38', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_WARNING', NULL, '2006-04-17 09:30:20', 'AJM', '2007-09-10 10:44:38', 'AJM');
REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `field_desc`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'SHUTDOWN_WEDNESDAY', NULL, '2006-04-17 09:30:44', 'AJM', '2007-09-10 10:44:38', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', '2009-02-10 13:36:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'AUTHENTICATION', 'NED', '2009-02-10 11:35:36', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'DEFAULT_LANGUAGE', 'NED', '2006-04-11 16:55:37', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'LOGIN_TYPE', 'NED', '2009-02-10 11:35:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'PAGINATION_WIDTH', 'NED', '2009-02-10 11:35:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'PSWD_CHANGE', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'PSWD_COUNT', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'PSWD_DAYS', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'PSWD_ENCRYPT', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'PSWD_FORMAT_DIGITS', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'PSWD_FORMAT_LOWER', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'PSWD_FORMAT_MINLEN', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'PSWD_FORMAT_UPPER', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'PSWD_HIDDEN', 'NED', '2009-02-10 11:35:51', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'PSWD_RETRIES', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'PSWD_WARNING', 'NED', '2006-04-11 16:46:48', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'SCROLLING_WIDTH', 'NED', '2009-02-10 11:35:52', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_END', 'NED', '2006-04-17 09:32:43', 'AJM', '2007-09-10 10:44:33', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_FRIDAY', 'NED', '2006-04-17 09:32:43', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_MONDAY', 'NED', '2006-04-17 09:32:43', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_SATURDAY', 'NED', '2006-04-17 09:32:44', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_START', 'NED', '2006-04-17 09:32:44', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_SUNDAY', 'NED', '2006-04-17 09:32:44', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_THURSDAY', 'NED', '2006-04-17 09:32:44', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_TUESDAY', 'NED', '2006-04-17 09:32:44', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_WARNING', 'NED', '2006-04-17 09:32:44', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_WEDNESDAY', 'NED', '2006-04-17 09:32:25', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SURVEY', 'mnu_control(upd3)', 'PSWD_CHANGE', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SURVEY', 'mnu_control(upd3)', 'PSWD_COUNT', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SURVEY', 'mnu_control(upd3)', 'PSWD_DAYS', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SURVEY', 'mnu_control(upd3)', 'PSWD_ENCRYPT', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SURVEY', 'mnu_control(upd3)', 'PSWD_FORMAT_DIGITS', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SURVEY', 'mnu_control(upd3)', 'PSWD_FORMAT_LOWER', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SURVEY', 'mnu_control(upd3)', 'PSWD_FORMAT_MINLEN', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SURVEY', 'mnu_control(upd3)', 'PSWD_FORMAT_UPPER', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:34', 'AJM');
REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SURVEY', 'mnu_control(upd3)', 'PSWD_RETRIES', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:34', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)', 'This will allow global settings on the MENU CONTROL table to be changed.

Refer to <a href=\"%root%/mnu_control(upd3).html\">Update Menu Control data</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-11 15:43:51', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)noedit', 'Enquire Menu Controls', 'Menu Controls', 'PROC', 'mnu_control(upd3).php', 'N', 'UPD3', 'MENU', NULL, NULL, NULL, 'main_noedit=Y', NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-02-10 11:47:06', 'AJM', '2009-02-10 12:03:38', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_control(upd3)noedit', '2009-02-10 11:47:42', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_control(upd3)noedit', '2009-02-10 12:18:19', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_control(upd3)noedit', 'This will allow global settings on the MENU CONTROL table to be viewed.

Refer to <a href=\"%root%/mnu_control(upd3).html\">Update Menu Control data</a> for full details.', '2009-05-21 10:59:13', 'AJM', '2013-06-11 15:45:16', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(add2)', 'Add Favourites', 'New', 'PROC', 'mnu_favourite(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2010-07-20 10:30:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_favourite(add2)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(add2)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_favourite(add2)', '2010-07-24 11:54:51', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_favourite(add2)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_favourite(add2)', '2012-05-26 15:29:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_favourite(add2)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_favourite(add2)', '2012-02-29 21:56:32', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_favourite(add2)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_favourite(add2)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_favourite(add2)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(add2)', 'This will allow a new record to be added to the FAVOURITE table.

Refer to <a href=\"%root%/mnu_favourite(add2).html\">Add Favourite</a> for full details.', '2013-06-11 15:50:37', 'AJM', '2013-06-11 15:52:48', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(add4)', 'Add Default Favourites', 'New', 'PROC', 'mnu_favourite(add4).php', 'N', 'ADD4', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2010-07-30 11:38:34', 'AJM', '2010-07-30 12:06:08', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_favourite(add4)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(add4)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_favourite(add4)', '2010-08-27 14:35:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_favourite(add4)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_favourite(add4)', '2012-05-26 15:29:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_favourite(add4)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_favourite(add4)', '2012-02-29 21:56:32', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_favourite(add4)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_favourite(add4)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_favourite(add4)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(del1)', 'Delete Favourites', 'Delete', 'PROC', 'mnu_favourite(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2010-07-20 10:30:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_favourite(del1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(del1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_favourite(del1)', '2010-07-24 11:54:51', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_favourite(del1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_favourite(del1)', '2012-05-26 15:29:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_favourite(del1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_favourite(del1)', '2012-02-29 21:56:32', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_favourite(del1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_favourite(del1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_favourite(del1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(del1)', 'This will allow a record to be deleted from the FAVOURITE table.

Refer to <a href=\"%root%/mnu_favourite(del1).html\">Delete Favourite</a> for full details.', '2013-06-11 15:54:02', 'AJM', '2013-06-11 15:55:33', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(enq1)', 'Enquire Favourites', 'Read', 'PROC', 'mnu_favourite(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2010-07-20 10:30:51', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_favourite(enq1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(enq1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_favourite(enq1)', '2010-07-24 11:54:52', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_favourite(enq1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_favourite(enq1)', '2012-05-26 15:29:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_favourite(enq1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_favourite(enq1)', '2012-02-29 21:56:32', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_favourite(enq1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_favourite(enq1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_favourite(enq1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(enq1)', 'This will display the contents of a record from the FAVOURITE table.

Refer to <a href=\"%root%/mnu_favourite(enq1).html\">Enquire Favourite</a> for full details.', '2013-06-11 15:48:41', 'AJM', '2013-06-11 15:55:58', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'List Favourites by User', 'List Favourites', 'PROC', 'mnu_favourite(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2010-07-20 10:30:47', 'AJM', '2010-07-20 10:35:05', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'audit_dtl(list)3', '009', 'Audit Trail', 'Y', '2010-07-20 10:31:00', 'AJM', '2010-07-20 15:55:21', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'mnu_favourite(add2)', '001', 'New', 'N', '2010-07-20 10:30:56', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'mnu_favourite(del1)', '004', 'Delete', 'Y', '2010-07-20 10:30:59', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'mnu_favourite(enq1)', '002', 'Read', 'Y', '2010-07-20 10:30:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'mnu_favourite(search)', '005', 'Search', 'N', '2010-07-20 10:31:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'mnu_favourite(upd1)', '003', 'Update', 'Y', '2010-07-20 10:30:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'mnu_favourite(upd4)movedown', '007', 'Move Down', 'Y', '2010-07-20 14:32:55', 'AJM', '2010-07-20 14:33:26', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'mnu_favourite(upd4)moveup', '006', 'Move Up', 'Y', '2010-07-20 14:32:56', 'AJM', '2010-07-20 14:33:26', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'mnu_favourite(upd4)reseq', '008', 'Resequence', 'Y', '2010-07-20 15:55:09', 'AJM', '2010-07-20 15:55:22', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_favourite(list2)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(list2)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_favourite(list2)', '2010-07-24 11:54:52', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_favourite(list2)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_favourite(list2)', '2012-05-26 15:29:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_favourite(list2)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_favourite(list2)', '2012-02-29 21:56:32', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_favourite(list2)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_favourite(list2)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_favourite(list2)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(list2)', 'This will list the contents of the FAVOURITE table for a selected USER.

Refer to <a href=\"%root%/mnu_favourite(list2).html\">List Favourite by User</a> for full details.', '2013-06-11 15:57:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(search)', 'Search Favourites', 'Search', 'PROC', 'mnu_favourite(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2010-07-20 10:30:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_favourite(search)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(search)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_favourite(search)', '2010-07-24 11:54:53', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_favourite(search)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_favourite(search)', '2012-05-26 15:29:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_favourite(search)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_favourite(search)', '2012-02-29 21:56:32', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_favourite(search)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_favourite(search)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_favourite(search)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(search)', 'This will allow search criteria to be entered before listing the contents of the FAVOURITE table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_favourite(search).html\">Search Favourites</a> for full details.', '2013-06-11 15:59:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(upd1)', 'Update Favourites', 'Update', 'PROC', 'mnu_favourite(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2010-07-20 10:30:53', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_favourite(upd1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(upd1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_favourite(upd1)', '2010-07-24 11:54:53', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_favourite(upd1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_favourite(upd1)', '2012-05-26 15:29:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_favourite(upd1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_favourite(upd1)', '2012-02-29 21:56:32', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_favourite(upd1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_favourite(upd1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_favourite(upd1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(upd1)', 'This will allow a record on the FAVOURITE table to be updated.

Refer to <a href=\"%root%/mnu_favourite(upd1).html\">Update Favourite</a> for full details.', '2013-06-11 16:02:02', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(upd4)movedown', 'Move Favourite Down', 'Move Down', 'PROC', 'mnu_favourite(upd4)movedown.php', 'N', 'UPD4', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2010-07-20 14:31:43', 'AJM', '2010-07-20 14:34:14', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_favourite(upd4)movedown', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(upd4)movedown', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_favourite(upd4)movedown', '2010-07-24 11:54:22', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_favourite(upd4)movedown', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_favourite(upd4)movedown', '2012-05-26 15:29:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_favourite(upd4)movedown', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_favourite(upd4)movedown', '2012-02-29 21:57:19', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_favourite(upd4)movedown', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_favourite(upd4)movedown', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_favourite(upd4)movedown', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(upd4)moveup', 'Move Favourite Up', 'Move Up', 'PROC', 'mnu_favourite(upd4)moveup.php', 'N', 'UPD4', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2010-07-20 14:20:30', 'AJM', '2010-07-20 14:34:34', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_favourite(upd4)moveup', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(upd4)moveup', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_favourite(upd4)moveup', '2010-07-24 11:54:22', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_favourite(upd4)moveup', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_favourite(upd4)moveup', '2012-05-26 15:29:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_favourite(upd4)moveup', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_favourite(upd4)moveup', '2012-02-29 21:57:19', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_favourite(upd4)moveup', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_favourite(upd4)moveup', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_favourite(upd4)moveup', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_favourite(upd4)reseq', 'Resequence Favourites', 'Resequence', 'PROC', 'mnu_favourite(upd4)reseq.php', 'N', 'UPD4', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2010-07-20 15:54:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_favourite(upd4)reseq', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_favourite(upd4)reseq', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_favourite(upd4)reseq', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_favourite(upd4)reseq', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_favourite(upd4)reseq', '2012-05-26 15:29:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_favourite(upd4)reseq', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_favourite(upd4)reseq', '2012-02-29 21:57:19', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_favourite(upd4)reseq', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_favourite(upd4)reseq', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_favourite(upd4)reseq', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(add2)', 'Add Help Text (Alternative Language)', 'New', 'PROC', 'help_text_alt(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2012-11-17 15:03:56', 'AJM', '2012-12-29 12:56:55', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(add2)', 'This will allow a new record to be added to the HELP_TEXT_ALT table.

Refer to <a href=\"%root%/mnu_help_text_alt(add2).html\">Add Help Text (Alternative Language)</a> for full details.', '2013-06-11 16:14:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(del1)', 'Delete Help Text (Alternative Language)', 'Delete', 'PROC', 'help_text_alt(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2012-11-17 15:03:57', 'AJM', '2012-12-29 12:57:04', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(del1)', 'This will allow a record to be deleted from the HELP_TEXT_ALT table.

Refer to <a href=\"%root%/mnu_help_text_alt(del1).html\">Delete Help Text (Alternative Language)</a> for full details.', '2013-06-11 16:15:52', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(enq1)', 'Enquire Help Text (Alternative Language)', 'Read', 'PROC', 'help_text_alt(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2012-11-17 15:03:56', 'AJM', '2012-12-29 12:57:14', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(enq1)', 'This will allow a record on the HELP_TEXT_ALT tableto be viewed

Refer to <a href=\"%root%/mnu_help_text_alt(enq1).html\">Enquire Help Text (Alternative Language)</a> for full details.', '2013-06-11 16:28:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(list2)', 'Maintain Alternative Languages for HELP_TEXT', 'Alternative Languages', 'PROC', 'help_text_alt(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2012-11-17 15:03:56', 'AJM', '2012-11-17 15:10:44', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2012-11-17 15:03:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(list2)', 'mnu_help_text_alt(add2)', '001', 'New', 'N', '2012-11-17 15:03:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(list2)', 'mnu_help_text_alt(del1)', '004', 'Delete', 'Y', '2012-11-17 15:03:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(list2)', 'mnu_help_text_alt(enq1)', '002', 'Read', 'Y', '2012-11-17 15:03:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(list2)', 'mnu_help_text_alt(search)', '005', 'Search', 'N', '2012-11-17 15:03:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(list2)', 'mnu_help_text_alt(upd1)', '003', 'Update', 'Y', '2012-11-17 15:03:57', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(list2)', 'This will allow the contents of the HELP_TEXT_ALT table for a selected TASK to be viewed.

This table holds help text in alternative languages.

Refer to <a href=\"%root%/mnu_help_text_alt(list2).html\">Maintain Alternative Languages for HELP_TEXT</a> for full details.', '2013-06-11 16:11:57', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(search)', 'Search Help Text (Alternative Language)', 'Search', 'PROC', 'help_text_alt(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2012-11-17 15:03:57', 'AJM', '2012-12-29 12:57:26', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(search)', 'This will allow search criteria to be entered before listing the contents of the HELP_TEXT_ALT table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_help_text_alt(search).html\">Search Help Text (Alternative Language)</a> for full details.', '2013-06-11 16:30:31', 'AJM', '2013-06-11 16:54:52', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(upd1)', 'Update Help Text (Alternative Language)', 'Update', 'PROC', 'help_text_alt(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2012-11-17 15:03:56', 'AJM', '2012-12-29 12:57:36', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text_alt(upd1)', 'This will allow a record on the HELP_TEXT_ALT table to be updated.

Refer to <a href=\"%root%/mnu_help_text_alt(upd1).html\">Update Help Text (Alternative Language)</a> for full details.', '2013-06-11 16:33:46', 'AJM', '2013-06-11 16:55:03', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text(multi1)', 'Maintain Help Text', 'Help Text', 'PROC', 'help_text(multi1).php', 'N', 'MULTI1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 10:47:22', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text(multi1)', 'mnu_help_text_alt(list2)', '001', 'Alternative Languages', 'Y', '2012-11-17 15:08:01', 'AJM', '2012-11-17 15:11:08', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_help_text(multi1)', 'This will allow the contents of the HELP TEXT table to be maintained.

Refer to <a href=\"%root%/mnu_help_text(multi1).html\">Maintain Help Text</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-11 16:05:19', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_role(multi3)a', 'Maintain Initial Value (Role) by Task', 'Initial Values', 'PROC', 'mnu_initial_value_role(multi3)a.php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2007-05-05 19:14:19', 'AJM', '2007-05-05 19:17:24', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_role(multi3)a', 'mnu_role(search)', '001', 'Search Role', 'N', '2007-05-05 19:17:50', 'AJM', '2008-02-07 14:46:56', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_role(multi3)a', 'This will allow the contents of the INITIAL_VALUE_ROLE table to be maintained by Role for a selected Task.

These values are used during the creation of new records.

Refer to <a href=\"%root%/mnu_initial_value_role(multi3)a.html\">Maintain Initial Values (Role) by Task</a> for full details.', '2007-05-08 10:34:16', 'AJM', '2013-06-11 17:13:48', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_role(multi3)b', 'Maintain Initial Value by Role', 'Initial Values', 'PROC', 'mnu_initial_value_role(multi3)b.php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2007-05-05 22:41:13', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_role(multi3)b', 'mnu_task(search)', '001', 'Search Task', 'N', '2007-05-05 22:41:52', 'AJM', '2008-02-07 14:45:32', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_role(multi3)b', 'This will allow the contents of the INITIAL_VALUE_ROLE table to be maintained by Task for a selected Role.

These values are used during the creation of new records.

Refer to <a href=\"%root%/mnu_initial_value_role(multi3)b.html\">Maintain Initial Values (Task) by Role</a> for full details.', '2007-05-08 10:34:37', 'AJM', '2013-06-11 17:09:12', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_user(multi3)a', 'Maintain Initial Value (User) by Task', 'Initial Values', 'PROC', 'mnu_initial_value_user(multi3)a.php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2007-05-27 10:43:36', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_user(multi3)a', 'mnu_user(search)', '001', 'Search User', 'N', '2008-02-07 14:47:21', 'AJM', '2008-02-07 14:47:30', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_user(multi3)a', 'This will allow the contents of the INITIAL_VALUE_USER table to be maintained by User for a selected Task.

These values are used during the creation of new records.

Refer to <a href=\"%root%/mnu_initial_value_user(multi3)a.html\">Maintain Initial Values (Task) by User</a> for full details.', '2007-05-27 22:01:13', 'AJM', '2013-06-11 17:19:37', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_user(multi3)b', 'Maintain Initial Value by User', 'Initial Values', 'PROC', 'mnu_initial_value_user(multi3)b.php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2007-05-27 10:42:45', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_user(multi3)b', 'mnu_task(search)', '001', 'Search Task', 'N', '2008-02-07 14:43:08', 'AJM', '2008-02-07 14:43:17', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_initial_value_user(multi3)b', 'This will allow the contents of the INITIAL_VALUE_USER table to be maintained by Task for a selected User.

These values are used during the creation of new records.

Refer to <a href=\"%root%/mnu_initial_value_user(multi3)b.html\">Maintain Initial Values (Task) by User</a> for full details.', '2007-05-27 22:03:03', 'AJM', '2013-06-11 17:20:59', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(add1)', 'Add Supported Languages', 'New', 'PROC', 'mnu_language(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2008-01-03 11:34:32', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(add1)', 'This will allow a new record to be added to the LANGUAGE table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_language(add1).html\">Add Language</a> for full details.', '2008-01-04 10:31:04', 'AJM', '2013-06-11 17:22:57', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(del1)', 'Delete Supported Languages', 'Delete', 'PROC', 'mnu_language(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2008-01-03 11:34:34', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(del1)', 'This will display a record from the LANGUAGE table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_language(del1).html\">Delete Language</a> for full details.', '2008-01-04 10:32:38', 'AJM', '2013-06-11 17:22:59', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(enq1)', 'Enquire Supported Languages', 'Read', 'PROC', 'mnu_language(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2008-01-03 11:34:33', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_language(enq1)', '2009-02-10 11:11:04', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_language(enq1)', '2009-02-10 11:36:49', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(enq1)', 'This will display the contents of a record from the LANGUAGE table.

Refer to <a href=\"%root%/mnu_language(enq1).html\">Enquire Language</a> for full details.', '2008-01-04 10:34:05', 'AJM', '2013-06-11 17:23:01', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(list1)', 'List Supported Languages', 'Supported Languages', 'PROC', 'mnu_language(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2008-01-03 11:34:31', 'AJM', '2011-07-22 15:40:25', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2008-01-03 11:34:36', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(list1)', 'mnu_language(add1)', '001', 'New', 'N', '2008-01-03 11:34:35', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(list1)', 'mnu_language(del1)', '004', 'Delete', 'Y', '2008-01-03 11:34:36', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(list1)', 'mnu_language(enq1)', '002', 'Read', 'Y', '2008-01-03 11:34:35', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(list1)', 'mnu_language(search)', '005', 'Search', 'N', '2008-01-03 11:34:36', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(list1)', 'mnu_language(upd1)', '003', 'Update', 'Y', '2008-01-03 11:34:35', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_language(list1)', '2009-02-10 11:11:05', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_language(list1)', '2009-02-10 11:36:49', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(list1)', 'This will list records on the LANGUAGE table.

Refer to <a href=\"%root%/mnu_language(list1).html\">List Language</a> for full details.', '2008-01-04 10:28:39', 'AJM', '2013-06-11 17:23:03', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(search)', 'Search Supported Languages', 'Search', 'PROC', 'mnu_language(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2008-01-03 11:34:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_language(search)', '2009-07-22 00:51:33', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_language(search)', '2009-02-10 11:36:50', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(search)', 'This will allow search criteria to be entered for the LANGUAGE table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_language(search).html\">Search Language</a> for full details.', '2008-01-04 10:35:40', 'AJM', '2013-06-11 17:23:07', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(upd1)', 'Update Supported Languages', 'Update', 'PROC', 'mnu_language(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2008-01-03 11:34:33', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_language(upd1)', 'This will display the contents of a record from the LANGUAGE table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_language(upd1).html\">Update Language</a> for full details.', '2008-01-04 10:37:13', 'AJM', '2013-06-11 17:23:09', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(add3)', 'Add Menu Items', 'Insert', 'PROC', 'mnu_menu(add3).php', 'N', 'ADD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:25:55', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(add3)a', 'Add Menu Items', 'Insert', 'PROC', 'mnu_menu(add3)a.php', 'N', 'ADD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2007-08-12 17:56:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(del2)', 'Delete Menu Items', 'Delete', 'PROC', 'mnu_menu(del2).php', 'N', 'DEL2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:26:52', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(link1)', 'Maintain Menu Items (2)', 'Menu Items(2)', 'PROC', 'mnu_menu(link1).php', 'N', 'LINK1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:28:00', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(link1)', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:28:00', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(link1)', 'This will display the contents of the MENU table for a selected task of type \'menu\'.

Refer to <a href=\"%root%/mnu_menu(link1).html\">Maintain Menu Items (2)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:19:05', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)', 'List Menu Items', 'Menu Items(3)', 'PROC', 'mnu_menu(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:28:50', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2004-04-09 11:58:45', 'AJM', '2007-08-12 17:28:50', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)', 'mnu_menu(add3)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:28:50', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)', 'mnu_menu(del2)', '003', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:28:50', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)', 'mnu_menu(search)', '004', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:28:50', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)', 'mnu_menu(upd1)', '002', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:30:55', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_menu(list2)', '2009-02-10 11:11:05', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_menu(list2)', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:28:50', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)', 'This will list records on the MENU table for a selected Task of type \'menu\'.

Refer to <a href=\"%root%/mnu_menu(list2).html\">List Menu Items</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:19:17', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)a', 'List Menu Parents', 'Menu (Parents)', 'PROC', 'mnu_menu(list2)a.php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2007-08-12 17:38:48', 'AJM', '2007-08-12 17:40:21', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)a', 'mnu_menu(add3)a', '001', 'New', 'N', '2007-08-12 17:56:49', 'AJM', '2007-08-12 17:57:08', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)a', 'mnu_menu(del2)', '002', 'Delete', 'Y', '2007-08-12 17:38:48', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)a', 'mnu_menu(search)', '003', 'Search', 'N', '2007-08-12 17:38:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_menu(list2)a', '2009-02-10 11:11:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_menu(list2)a', '2007-08-13 10:30:00', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(list2)a', 'This will list parent records on the MENU table for a selected Task of type \'menu\'.

Refer to <a href=\"%root%/mnu_menu(list2)a.html\">List Menu Parents</a> for full details.', '2007-08-12 22:04:22', 'AJM', '2013-06-12 12:19:24', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(multi2)', 'Maintain Menu Items (1)', 'Menu Items(1)', 'PROC', 'mnu_menu(multi2).php', 'N', 'MULTI2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:29:47', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(multi2)', 'mnu_menu(add3)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:29:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(multi2)', 'mnu_menu(del2)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:29:47', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(multi2)', 'This will display the contents of the MENU table for a selected task of type \'menu\', with the ability to modify data on existing records.. 

Refer to <a href=\"%root%/mnu_menu(multi2).html\">Maintain Menu Items (1)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:26:01', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(search)', 'Search Menu Items', 'Search', 'PROC', 'mnu_menu(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:30:19', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_menu(search)', '2009-02-10 11:11:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_menu(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(search)', 'This will allow search criteria to be entered for the MENU table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_menu(search).html\">Search Menu Items</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:26:33', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(upd1)', 'Update Menu Item', 'Update', 'PROC', 'mnu_menu(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:30:56', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_menu(upd1)', 'This will display the contents of a record from the MENU table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_menu(upd1).html\">Update Menu Item</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:27:23', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(add1)', 'Add Message of the Day', 'New', 'PROC', 'mnu_motd(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-05-05 11:36:55', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_motd(add1)', '2012-02-29 21:57:47', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(add1)', 'This will allow a new record to be added to the MOTD (Message Of The Day) table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_motd(add1).html\">Add MOD</a> for full details.', '2009-05-14 10:27:54', 'AJM', '2013-06-12 12:34:17', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(del1)', 'Delete Message of the Day', 'Delete', 'PROC', 'mnu_motd(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-05-05 11:36:57', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_motd(del1)', '2012-02-29 21:57:47', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(del1)', 'This will display a record from the MOTD (Message Of The Day) table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_motd(del1).html\">Delete MOTD</a> for full details.', '2009-05-14 10:28:30', 'AJM', '2013-06-12 12:34:20', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(enq1)', 'Enquire Message of the Day', 'Read', 'PROC', 'mnu_motd(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-05-05 11:36:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_motd(enq1)', '2009-05-07 14:50:01', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(enq1)', 'This will display the contents of a record from the MOTD (Message Of The Day) table.

Refer to <a href=\"%root%/mnu_motd(enq1).html\">Enquire MOTD</a> for full details.', '2009-05-14 10:29:03', 'AJM', '2013-06-12 12:34:22', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'List Message of the Day', 'MOTD', 'PROC', 'mnu_motd(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, 'curr_or_hist=\'C\'', NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-05-05 11:36:55', 'AJM', '2009-11-20 16:16:00', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2009-05-05 11:36:59', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'date(current)', '007', 'Current', 'N', '2009-05-06 10:30:33', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'date(historic)', '008', 'Historic', 'N', '2009-05-06 10:30:34', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'mnu_motd(add1)', '001', 'New', 'N', '2009-05-05 11:36:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'mnu_motd(del1)', '004', 'Delete', 'Y', '2009-05-05 11:36:59', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'mnu_motd(enq1)', '002', 'Read', 'Y', '2009-05-05 11:36:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'mnu_motd(search)', '005', 'Search', 'N', '2009-05-05 11:36:59', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'mnu_motd(upd1)', '003', 'Update', 'Y', '2009-05-05 11:36:58', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_motd(list1)', '2009-05-07 14:50:01', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_motd(list1)', '2012-02-29 21:57:47', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(list1)', 'This will list records on the MOTD (Message Of The Day) table.

Refer to <a href=\"%root%/mnu_motd(list1).html\">List MOTD</a> for full details.', '2009-05-14 10:29:33', 'AJM', '2013-06-12 12:34:24', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(search)', 'Search Message of the Day', 'Search', 'PROC', 'mnu_motd(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-05-05 11:36:57', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_motd(search)', '2009-05-07 14:50:02', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_motd(search)', '2012-02-29 21:57:47', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(search)', 'This will allow search criteria to be entered for the MOTD (Message Of The Day) table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_motd(search).html\">Search MOTD</a> for full details.', '2009-05-14 10:30:06', 'AJM', '2013-06-12 12:34:27', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(show)', 'Show Message of the Day', 'MOTD', 'PROC', 'mnu_motd(show).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-05-05 17:32:47', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_motd(show)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_motd(show)', '2010-04-13 11:55:03', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_motd(show)', '2009-05-07 14:49:49', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_motd(show)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_motd(show)', '2012-05-26 15:29:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_motd(show)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_motd(show)', '2012-02-29 21:57:47', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_motd(show)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_motd(show)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_motd(show)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(show)', 'This will show unexpired records from the MOTD (Message Of The Day) table, latest first.

Refer to <a href=\"%root%/mnu_motd(show).html\">Show MOTD</a> for full details.', '2009-05-14 10:31:46', 'AJM', '2013-06-12 12:34:29', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(upd1)', 'Update Message of the Day', 'Update', 'PROC', 'mnu_motd(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-05-05 11:36:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_motd(upd1)', '2012-02-29 21:57:47', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_motd(upd1)', 'This will display the contents of a record from the MOTD (Message Of The Day) table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_motd(upd1).html\">Update MOTD</a> for full details.', '2009-05-14 10:30:36', 'AJM', '2013-06-12 12:34:30', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(add3)', 'Add Navigation Button', 'Insert', 'PROC', 'mnu_nav_button(add3).php', 'N', 'ADD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:19:06', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(add3)a', 'Add Navigation Button', 'Insert', 'PROC', 'mnu_nav_button(add3)a.php', 'N', 'ADD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2007-08-12 13:42:22', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(del2)', 'Delete Navigation Button', 'Delete', 'PROC', 'mnu_nav_button(del2).php', 'N', 'DEL2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:19:56', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(link1)', 'Maintain Navigation Buttons (2)', 'Navigation Button (2)', 'PROC', 'mnu_nav_button(link1).php', 'N', 'LINK1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:20:37', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(link1)', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:16:40', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(link1)', 'This will display the contents of the NAVIGATION BUTTON table for a selected Task. Each of these will appear in the navigation bar area when the task is selected.

Refer to <a href=\"%root%/mnu_nav_button(link1).html\">Maintain Navigation Buttons (2)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:35:48', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)', 'List Navigation Buttons', 'Navigation Buttons (3)', 'PROC', 'mnu_nav_button(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:22:09', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2004-04-09 11:58:57', 'AJM', '2007-08-12 11:16:12', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)', 'mnu_nav_button(add3)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:16:12', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)', 'mnu_nav_button(del2)', '003', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:16:12', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)', 'mnu_nav_button(search)', '004', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:16:12', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)', 'mnu_nav_button(upd1)', '002', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:18:58', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_nav_button(list2)', '2009-02-10 11:11:20', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_nav_button(list2)', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:16:13', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)', 'This will list records on the NAVIGATION BUTTON table for a selected TASK.

Refer to <a href=\"%root%/mnu_nav_button(list2).html\">List Navigation Buttons</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:35:50', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)a', 'List Navigation Button Parents', 'Navigation Button (Parents)', 'PROC', 'mnu_nav_button(list2)a.php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2007-08-12 11:25:09', 'AJM', '2007-08-12 14:22:28', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)a', 'mnu_nav_button(add3)a', '001', 'New', 'N', '2007-08-12 14:29:06', 'AJM', '2007-08-12 18:55:55', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)a', 'mnu_nav_button(del2)', '003', 'Delete', 'Y', '2007-08-12 14:28:49', 'AJM', '2009-08-07 14:11:13', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)a', 'mnu_nav_button(search)', '004', 'Search', 'N', '2007-08-12 14:28:24', 'AJM', '2009-08-07 14:11:13', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)a', 'mnu_nav_button(upd1)', '002', 'Update', 'Y', '2009-08-07 14:10:45', 'AJM', '2009-08-07 14:11:13', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_nav_button(list2)a', '2009-02-10 11:11:21', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_nav_button(list2)a', '2007-08-13 10:30:51', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(list2)a', 'This will list parent records on the NAVIGATION BUTTON table for a selected TASK.

Refer to <a href=\"%root%/mnu_nav_button(list2)a.html\">List Navigation Button Parents</a> for full details.', '2007-08-12 18:27:39', 'AJM', '2013-06-12 12:35:52', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(multi2)', 'Maintain Navigation Buttons (1)', 'Navigation Button (1)', 'PROC', 'mnu_nav_button(multi2).php', 'N', 'MULTI2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:22:57', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(multi2)', 'mnu_nav_button(add3)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:17:10', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(multi2)', 'mnu_nav_button(del2)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:17:10', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(multi2)', 'This will display the contents of the NAVIGATION BUTTON table for a selected task. 

Refer to <a href=\"%root%/mnu_nav_button(multi2).html\">Maintain Navigation Buttons (1)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:35:53', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(search)', 'Search Navigation Button', 'Search', 'PROC', 'mnu_nav_button(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:23:47', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_nav_button(search)', '2009-02-10 11:11:36', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_nav_button(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(search)', 'This will allow search criteria to be entered for the NAVIGATION BUTTON table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_nav_button(search).html\">Search Navigation Button</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:35:55', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(upd1)', 'Update Navigation Button', 'Update', 'PROC', 'mnu_nav_button(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:24:14', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_nav_button(upd1)', 'This will display the contents of a record from the NAVIGATION BUTTON table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_nav_button(upd1).html\">Update Navigation Button</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:35:56', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(add1)', 'Add Pattern', 'Insert', 'PROC', 'mnu_pattern(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 10:58:00', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(add1)', 'This will allow a new record to be added to the PATTERN table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_pattern(add1).html\">Add Pattern</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:38:42', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(del1)', 'Delete Pattern', 'Delete', 'PROC', 'mnu_pattern(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:02:18', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(del1)', 'This will display a record from the PATTERN table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_pattern(del1).html\">Delete Pattern</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:38:44', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(enq1)', 'Enquire Pattern', 'Enquire', 'PROC', 'mnu_pattern(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2009-05-14 10:03:42', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_pattern(enq1)', '2009-02-10 11:11:36', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_pattern(enq1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:03:25', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(enq1)', 'This will display the contents of a record from the PATTERN table.

Refer to <a href=\"%root%/mnu_pattern(enq1).html\">Enquire Pattern</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:38:46', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'List Pattern', 'List Pattern', 'PROC', 'mnu_pattern(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 10:55:35', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2004-04-09 11:37:12', 'AJM', '2007-09-10 10:55:34', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'mnu_pattern(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:58:00', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'mnu_pattern(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:02:18', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'mnu_pattern(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:03:25', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'mnu_pattern(pdf)', '008', 'Output to PDF(L)', 'N', '2006-08-16 22:19:25', 'AJM', '2007-09-10 10:55:34', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'mnu_pattern(pdf)2', '009', 'Output to PDF(D)', 'N', '2006-08-16 19:13:53', 'AJM', '2007-09-10 10:55:34', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'mnu_pattern(search)', '006', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:55:34', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'mnu_pattern(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:05:58', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'mnu_task(list2)a', '005', 'List Task', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:46:07', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_pattern(list1)', '2009-02-10 11:11:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_pattern(list1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:55:35', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(list1)', 'This will list records on the PATTERN table.

Refer to <a href=\"%root%/mnu_pattern(list1).html\">List Pattern</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:38:49', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(pdf)', 'Output to PDF - List view', 'Output to PDF(L)', 'PROC', 'mnu_pattern(pdf).php', 'N', 'OUTPUT2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-08-16 22:18:49', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_pattern(pdf)', '2009-02-10 11:11:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_pattern(pdf)', '2009-02-10 11:37:09', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(pdf)2', 'Output to PDF - Detail view', 'Output to PDF(D)', 'PROC', 'mnu_pattern(pdf)2.php', 'N', 'OUTPUT3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-08-16 19:13:24', 'AJM', '2006-08-16 22:18:12', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_pattern(pdf)2', '2009-02-10 11:11:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_pattern(pdf)2', '2009-02-10 11:37:09', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(search)', 'Search Pattern', 'Search', 'PROC', 'mnu_pattern(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:03:57', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_pattern(search)', '2009-02-10 11:11:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_pattern(search)', '2003-01-01 12:00:00', 'AJM', '2006-03-27 23:37:36', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(search)', 'This will allow search criteria to be entered for the PATTERN table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_pattern(search).html\">Search Pattern</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:38:51', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(upd1)', 'Update Pattern', 'Update', 'PROC', 'mnu_pattern(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:05:59', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_pattern(upd1)', 'This will display the contents of a record from the PATTERN table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_pattern(upd1).html\">Update Pattern</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:38:53', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_task(link1)a', 'Link Role(s) to selected Task', 'Task Access', 'PROC', 'mnu_role_task(link1)a.php', 'N', 'LINK1', 'MENU', NULL, NULL, NULL, NULL, 'role_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2011-07-13 11:35:00', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_task(link1)a', 'mnu_role(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:12:14', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_task(link1)a', 'This will display the contents of the ROLE TASK table for a selected task and allow updates to be made.

Refer to <a href=\"%root%/mnu_role_task(link1)a.html\">Link Role(s) to selected task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:45:50', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_task(link1)b', 'Link Task(s) to selected Role', 'Task Access', 'PROC', 'mnu_role_task(link1)b.php', 'N', 'LINK1', 'MENU', NULL, NULL, NULL, NULL, 'task_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:20:38', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_task(link1)b', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:20:38', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_task(link1)b', 'This will display the contents of the ROLE TASK table for a selected role and allow updates to be made.

Refer to <a href=\"%root%/mnu_role_task(link1)b.html\">Link Task(s) to selected Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:45:52', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_taskfield(multi3)a', 'Maintain Field Access via Task', 'Field Access', 'PROC', 'mnu_role_taskfield(multi3)a.php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, 'mnu_task_field.field_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:26:03', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_taskfield(multi3)a', 'mnu_role(search)', '001', 'Search Role', 'N', '2007-02-09 13:46:15', 'AJM', '2007-09-10 11:26:03', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_taskfield(multi3)a', 'This will show the contents of the ROLE TASK FIELD table for a selected Task and allow changes to be made.

Refer to <a href=\"%root%/mnu_role_taskfield(multi3)a.html\">Maintain Field Access via Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:48:59', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_taskfield(multi3)b', 'Maintain Field Access via Role', 'Field Access', 'PROC', 'mnu_role_taskfield(multi3)b.php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, 'mnu_task_field.field_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:30:42', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_taskfield(multi3)b', 'mnu_task(search)', '001', 'Search Task', 'N', '2007-02-09 12:03:36', 'AJM', '2007-09-10 11:30:42', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role_taskfield(multi3)b', 'This will show the contents of the ROLE TASK FIELD table for a selected Role and allow changes to be made.

Refer to <a href=\"%root%/mnu_role_taskfield(multi3)b.html\">Maintain Field Access via Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:49:02', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(add1)', 'Add Role', 'Insert', 'PROC', 'mnu_role(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:34:18', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(add1)', 'This will allow a new record to be added to the ROLE table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_role(add1).html\">Add Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:51:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(del1)', 'Delete Role', 'Delete', 'PROC', 'mnu_role(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:36:00', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(del1)', 'This will display a record from the ROLE table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_role(del1).html\">Delete Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:56:15', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(enq1)', 'Enquire Role', 'Enquire', 'PROC', 'mnu_role(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:39:04', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_role(enq1)', '2009-02-10 11:11:49', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_role(enq1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:39:04', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(enq1)', 'This will display the contents of a record from the ROLE table.

Refer to <a href=\"%root%/mnu_role(enq1).html\">Enquire Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:56:17', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(list1)', 'List Role', 'List Role', 'PROC', 'mnu_role(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:41:48', 'AJM');

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

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_role(list1)', '2009-02-10 11:11:50', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_role(list1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(list1)', 'This will list records on the ROLE table.

Refer to <a href=\"%root%/mnu_role(list1).html\">List Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:56:20', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(pdf)', 'Output to PDF - List view', 'Output to PDF(L)', 'PROC', 'mnu_role(pdf).php', 'N', 'OUTPUT2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-08-17 16:25:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_role(pdf)', '2009-02-10 11:11:50', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_role(pdf)', '2009-02-10 11:37:18', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(popup1)', 'Choose Role', 'Choose', 'PROC', 'mnu_role(popup1).php', 'N', 'POPUP1', 'MENU', NULL, NULL, NULL, NULL, 'role_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-04-14 15:04:39', 'AJM', '2007-09-10 11:45:02', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_role(popup1)', '2009-07-22 00:52:04', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(popup1)', 'This will list records on the ROLE table and allow one or more to be selected.

After selecting records please press the CHOOSE button.

Refer to <a href=\"%root%/mnu_role(popup1).html\">Choose Role</a> for full details.', '2004-08-26 14:08:25', 'AJM', '2013-06-12 12:56:27', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(search)', 'Search Role', 'Search', 'PROC', 'mnu_role(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2009-05-14 10:05:57', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_role(search)', '2009-02-10 11:12:11', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_role(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(search)', 'This will allow search criteria to be entered for the ROLE table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_role(search).html\">Search Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:56:30', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(upd1)', 'Update Role', 'Update', 'PROC', 'mnu_role(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:50:24', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_role(upd1)', 'This will display the contents of a record from the ROLE table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_role(upd1).html\">Update Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:56:38', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_session(upd3)', 'Update Session Data', 'Session Data', 'PROC', 'mnu_session(upd3).php', 'N', 'UPD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-04-06 19:37:49', 'AJM', '2007-09-10 11:53:31', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_session(upd3)', 'This will allow certain settings which are being used within the current session to be changed.

Refer to <a href=\"%root%/mnu_session(upd3).html\">Update Session data</a> for full details.', '2006-04-07 11:22:29', 'AJM', '2013-06-12 12:57:19', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(add1)', 'Add Subsystem', 'Insert', 'PROC', 'mnu_subsystem(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:57:39', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(add1)', 'This will allow a new record to be added to the SUBSYSTEM table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_subsystem(add1).html\">Add Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:59:26', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(del1)', 'Delete Subsystem', 'Delete', 'PROC', 'mnu_subsystem(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:58:59', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(del1)', 'This will display a record from the SUBSYSTEM table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_subsystem(del1).html\">Delete Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:59:31', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(enq1)', 'Enquire Subsystem', 'Enquire', 'PROC', 'mnu_subsystem(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 12:03:57', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_subsystem(enq1)', '2009-02-10 11:12:11', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_subsystem(enq1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 12:03:57', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(enq1)', 'This will display the contents of a record from the SUBSYSTEM table.

Refer to <a href=\"%root%/mnu_subsystem(enq1).html\">Enquire Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 12:59:33', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(erase)', 'Erase Subsystem', 'Erase', 'PROC', 'mnu_subsystem(erase1).php', 'N', 'ERASE1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '120', NULL, NULL, '2005-12-06 17:42:11', 'AJM', '2012-07-15 14:20:19', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(erase)', 'This will allow all the records on all associated tables for the selected Subsystem to be erased.

To proceed with the erase press SUBMIT, otherwise press CANCEL.

Refer to <a href=\"%root%/mnu_subsystem(erase).html\">Erase Subsystem</a> for full details.', '2013-06-12 13:02:28', 'AJM', '2013-06-12 13:04:08', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'List Subsystem', 'List Subsystem', 'PROC', 'mnu_subsystem(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:01:48', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'audit_dtl(list)3', '012', 'Audit Trail', 'Y', '2004-04-09 11:37:58', 'AJM', '2007-09-10 14:01:48', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'dict_database(list)2', '008', 'Databases', 'Y', '2005-03-12 18:56:34', 'AJM', '2007-09-10 14:01:47', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'dict_database(list2)', '008', 'Databases', 'Y', '2005-03-12 18:56:34', 'AJM', '2009-06-26 16:13:26', 'AJM');
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

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_subsystem(list1)', '2009-02-10 11:12:11', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_subsystem(list1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:01:48', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(list1)', 'This will list records on the SUBSYSTEM table.

Refer to <a href=\"%root%/mnu_subsystem(list1).html\">List Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:04:16', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(pdf)', 'Output to PDF - List view', 'Output to PDF(L)', 'PROC', 'mnu_subsystem(pdf).php', 'N', 'OUTPUT2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-08-17 10:58:50', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_subsystem(pdf)', '2009-02-10 11:12:12', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_subsystem(pdf)', '2009-02-10 11:37:29', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(search)', 'Search Subsystem', 'Search', 'PROC', 'mnu_subsystem(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:04:15', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_subsystem(search)', '2009-02-10 11:12:27', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_subsystem(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(search)', 'This will allow search criteria to be entered for the SUBSYSTEM table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_subsystem(search).html\">Search Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:04:19', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(upd1)', 'Update Subsystem', 'Update', 'PROC', 'mnu_subsystem(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:05:25', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(upd1)', 'This will display the contents of a record from the SUBSYSTEM table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_subsystem(upd1).html\">Update Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:04:22', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(upd4)build', 'Build Subsystem Directory', 'Build', 'PROC', 'mnu_subsystem(upd4)build.php', 'N', 'UPD4', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-09-28 11:02:20', 'AJM', '2007-09-10 12:02:43', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_subsystem(upd4)export', 'Export Subsystem', 'Export', 'PROC', 'mnu_subsystem(upd4)export.php', 'N', 'UPD4', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '360', NULL, NULL, '2005-07-15 21:12:39', 'AJM', '2012-02-05 11:28:12', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(add2)', 'Add Task (Alternative Language)', 'New', 'PROC', 'mnu_task_alt(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2013-01-01 13:34:24', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(add2)', 'This will allow a new record to be added to the TASK_ALT table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_task_alt(add2).html\">Add Task (Alternative Language)</a> for full details.', '2013-06-12 13:09:41', 'AJM', '2013-06-12 13:11:00', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(del1)', 'Delete Task (Alternative Language)', 'Delete', 'PROC', 'mnu_task_alt(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2013-01-01 13:34:26', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(del1)', 'This will allow a record to be deleted from the TASK_ALT table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_task_alt(del1).html\">Delete Task (Alternative Language)</a> for full details.', '2013-06-12 13:14:44', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(enq1)', 'Enquire Task (Alternative Language)', 'Read', 'PROC', 'mnu_task_alt(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2013-01-01 13:34:25', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(enq1)', 'This will display the contents record from the TASK_ALT table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_task_alt(enq1).html\">Enquire Task (Alternative Language)</a> for full details.', '2013-06-12 13:17:47', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(list2)', 'Maintain Alternative Languages for TASK', 'Alternative Languages', 'PROC', 'mnu_task_alt(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2013-01-01 13:34:23', 'AJM', '2013-01-01 13:43:09', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2013-01-01 13:34:29', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(list2)', 'mnu_task_alt(add2)', '001', 'New', 'N', '2013-01-01 13:34:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(list2)', 'mnu_task_alt(del1)', '004', 'Delete', 'Y', '2013-01-01 13:34:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(list2)', 'mnu_task_alt(enq1)', '002', 'Read', 'Y', '2013-01-01 13:34:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(list2)', 'mnu_task_alt(search)', '005', 'Search', 'N', '2013-01-01 13:34:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(list2)', 'mnu_task_alt(upd1)', '003', 'Update', 'Y', '2013-01-01 13:34:28', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(list2)', 'This will list records on the TASK_ALT table for a selected TASK.

Refer to <a href=\"%root%/mnu_task_alt(list2).html\">Maintain Alternative Language for Task</a> for full details.', '2013-06-12 13:22:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(search)', 'Search Task (Alternative Language)', 'Search', 'PROC', 'mnu_task_alt(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2013-01-01 13:34:27', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(search)', 'This will allow search criteria to be entered for the TASK_ALT table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_task_alt(search).html\">Search Task (Alternative Language)</a> for full details.', '2013-06-12 13:23:54', 'AJM', '2013-06-12 13:25:05', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(upd1)', 'Update Task (Alternative Language)', 'Update', 'PROC', 'mnu_task_alt(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2013-01-01 13:34:26', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_alt(upd1)', 'This will display the contents of a record from the TASK_ALT table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_task_alt(upd1).html\">Update Task (Alternative Language)</a> for full details.', '2013-06-12 13:26:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(add2)', 'Add Task Field', 'New', 'PROC', 'mnu_task_field(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:21:52', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(add2)', 'This will allow a record to be added to the TASK FIELD table for a selected TASK.

Refer to <a href=\"%root%/mnu_task_field(add2).html\">Add Task Field</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:35:57', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(del1)', 'Delete Task Field', 'Delete', 'PROC', 'mnu_task_field(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:22:57', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(del1)', 'This will display a record from the TASK FIELD table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_task_field(del1).html\">Delete Task Field</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:37:10', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(enq1)', 'Enquire Task Field', 'Read', 'PROC', 'mnu_task_field(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2008-02-27 16:28:01', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task_field(enq1)', '2009-02-10 11:12:27', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_task_field(enq1)', '2009-02-10 11:37:44', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(enq1)', 'This will display the contents of a record from the TASK FIELD table.

Refer to <a href=\"%root%/mnu_task_field(enq1).html\">Enquire Task Field</a> for full details.', '2009-12-05 10:30:50', 'AJM', '2013-06-12 13:37:41', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(list2)', 'List Task Field', 'List Fields', 'PROC', 'mnu_task_field(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, 'field_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:19:30', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2004-04-09 11:59:27', 'AJM', '2008-02-27 16:32:26', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(list2)', 'mnu_task_field(add2)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:21:52', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(list2)', 'mnu_task_field(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2008-02-27 16:37:08', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(list2)', 'mnu_task_field(enq1)', '002', 'Read', 'Y', '2008-02-27 16:28:34', 'AJM', '2008-02-27 16:28:57', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(list2)', 'mnu_task_field(search)', '005', 'Search', 'N', '2008-02-27 16:32:16', 'AJM', '2008-02-27 16:32:27', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(list2)', 'mnu_task_field(upd1)', '003', 'Update', 'Y', '2008-02-27 16:15:46', 'AJM', '2008-02-27 16:37:08', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task_field(list2)', '2009-02-10 11:12:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_task_field(list2)', '2009-02-10 11:37:44', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(list2)', 'This will list records on the TASK FIELD table for a selected TASK.

Refer to <a href=\"%root%/mnu_task_field(list2).html\">List Task Field</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:37:44', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(search)', 'Search Task Field', 'Search', 'PROC', 'mnu_task_field(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2008-02-27 16:31:56', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task_field(search)', '2009-02-10 11:12:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_task_field(search)', '2009-02-10 11:37:44', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(search)', 'This will allow search criteria to be entered for the TASK FIELD table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_task_field(search).html\">SearchTask Field</a> for full details.', '2009-12-05 10:32:23', 'AJM', '2013-06-12 13:37:46', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(upd1)', 'Update Task Field', 'Update', 'PROC', 'mnu_task_field(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2008-02-27 16:15:00', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_field(upd1)', 'This will display the contents of a record from the TASK FIELD table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_task_field(upd1).html\">Update Task Field</a> for full details.', '2009-12-05 10:34:05', 'AJM', '2013-06-12 13:37:48', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(add2)', 'Add Task IP Address', 'New', 'PROC', 'mnu_task_ip_address(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-11-15 18:07:26', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(add2)', 'This will allow a new record to be added to the TASK_IP_ADDRESS table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_task_ip_address(add2).html\">Add Task IP Address</a> for full details.', '2009-12-05 10:35:14', 'AJM', '2013-06-12 13:47:11', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(del1)', 'Delete Task IP Address', 'Delete', 'PROC', 'mnu_task_ip_address(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-11-15 18:07:28', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(del1)', 'This will display a record from the TASK_IP_ADDRESS table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_task_ip_address(del1).html\">Delete Task IP Address</a> for full details.', '2009-12-05 10:36:30', 'AJM', '2013-06-12 13:46:04', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(enq1)', 'Enquire Task IP Address', 'Read', 'PROC', 'mnu_task_ip_address(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-11-15 18:07:26', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task_ip_address(enq1)', '2010-07-24 11:52:41', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(enq1)', 'This will display the contents of a record from the TASK_IP_ADDRESS table.

Refer to <a href=\"%root%/mnu_task_ip_address(enq1).html\">Enquire Task IP Address</a> for full details.', '2009-12-05 10:37:31', 'AJM', '2013-06-12 13:46:11', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(list2)', 'List IP Address by Task', 'Task IP Address', 'PROC', 'mnu_task_ip_address(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-11-15 18:07:25', 'AJM', '2009-11-15 18:10:22', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2009-11-15 18:07:32', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(list2)', 'mnu_task_ip_address(add2)', '001', 'New', 'N', '2009-11-15 18:07:30', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(list2)', 'mnu_task_ip_address(del1)', '004', 'Delete', 'Y', '2009-11-15 18:07:31', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(list2)', 'mnu_task_ip_address(enq1)', '002', 'Read', 'Y', '2009-11-15 18:07:31', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(list2)', 'mnu_task_ip_address(search)', '005', 'Search', 'N', '2009-11-15 18:07:32', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(list2)', 'mnu_task_ip_address(upd1)', '003', 'Update', 'Y', '2009-11-15 18:07:31', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task_ip_address(list2)', '2010-07-24 11:52:41', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(list2)', 'This will list records on the TASK_IP_ADDRESS table for a selected Task.

Refer to <a href=\"%root%/mnu_task_ip_address(list2).html\">List IP Address by Task</a> for full details.', '2009-12-05 10:38:49', 'AJM', '2013-06-12 13:46:13', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(search)', 'Search Task IP Address', 'Search', 'PROC', 'mnu_task_ip_address(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-11-15 18:07:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task_ip_address(search)', '2010-07-24 11:52:27', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(search)', 'This will allow search criteria to be entered for the TASK_IP_ADDRESS table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_task_ip_address(search).html\">Search Task IP Address</a> for full details.', '2009-12-05 10:39:57', 'AJM', '2013-06-12 13:46:15', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(upd1)', 'Update Task IP Address', 'Update', 'PROC', 'mnu_task_ip_address(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-11-15 18:07:27', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task_ip_address(upd1)', 'This will display the contents of a record from the TASK_IP_ADDRESS table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_task_ip_address(upd1).html\">Update Task IP Address</a> for full details.', '2009-12-05 10:41:00', 'AJM', '2013-06-12 13:46:18', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(add1)', 'Add Task', 'Insert', 'PROC', 'mnu_task(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:39:39', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(add1)', 'This will allow a new record to be added to the TASK table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_task(add1).html\">Add Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:50:09', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(del1)', 'Delete Task', 'Delete', 'PROC', 'mnu_task(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:42:08', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(del1)', 'This will display a record from the TASK table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_task(del1).html\">Delete Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:50:12', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(enq1)', 'Enquire Task', 'Enquire', 'PROC', 'mnu_task(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:43:14', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task(enq1)', '2009-02-10 11:12:43', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_task(enq1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:43:13', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(enq1)', 'This will display the contents of a record from the TASK table.

Refer to <a href=\"%root%/mnu_task(enq1).html\">Enquire Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:50:14', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'List Task (All)', 'Task (All)', 'PROC', 'mnu_task(list1).php', 'N', 'LIST1', 'MENU', 'mnu_task(search)', NULL, NULL, NULL, 'task_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:30:48', 'AJM');

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

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task(list1)', '2009-02-10 11:12:43', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_task(list1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:48', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)', 'This will list records on the TASK table regardless of their TASK-TYPE.

Refer to <a href=\"%root%/mnu_task(list1).html\">List Task (All)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:50:16', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'List Task (Process)', 'Task (Proc)', 'PROC', 'mnu_task(list1).php', 'N', 'LIST1', 'MENU', 'mnu_task(search)', 'task_type=\'PROC\'', NULL, NULL, 'task_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:25', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'audit_dtl(list)3', '023', 'Audit Trail', 'Y', '2004-04-09 11:38:58', 'AJM', '2013-01-01 13:40:38', 'AJM');
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
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:39:39', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:42:08', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:43:13', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task(pdf)', '018', 'Output to PDF(L)', 'N', '2006-08-17 11:06:49', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task(pdf)2', '019', 'Output to PDF(D)', 'N', '2006-08-17 11:33:55', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task(pdf)3', '020', 'Nav Buttons (PDF)', 'N', '2006-08-27 21:59:03', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task(rename)', '016', 'Rename', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task(search)', '017', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'mnu_task(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:55:16', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task(list1)a', '2009-02-10 11:12:43', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_task(list1)a', '2009-02-10 11:37:58', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)a', 'This will list records on the TASK table where type = \'TASK\'.

Refer to <a href=\"%root%/mnu_task(list1)a.html\">List Task (Proc)</a> for full details.', '2004-08-26 12:07:32', 'AJM', '2013-06-12 12:42:49', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'List Task (Menu)', 'Task (Menu)', 'PROC', 'mnu_task(list1).php', 'N', 'LIST1', 'MENU', NULL, 'task_type=\'MENU\' and pattern_id=\'MENU\'', NULL, NULL, 'task_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM');

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

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task(list1)b', '2009-02-10 11:12:43', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_task(list1)b', '2009-02-10 11:37:58', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list1)b', 'This will list records on the TASK table where type = \'MENU\'.

Refer to <a href=\"%root%/mnu_task(list1)b.html\">List Task (Menu)</a> for full details.', '2004-08-26 12:07:39', 'AJM', '2013-06-12 12:42:55', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)a', 'List Task by Pattern', 'List Task', 'PROC', 'mnu_task(list2)a.php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, 'task_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:46:07', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)a', 'audit_dtl(list)3', '004', 'Audit Trail', 'Y', '2004-04-09 11:59:11', 'AJM', '2007-09-10 14:46:07', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)a', 'mnu_help_text(multi1)', '003', 'Help Text', 'Y', '2004-08-26 11:58:54', 'AJM', '2007-09-10 14:46:07', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)a', 'mnu_task(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:46:07', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)a', 'mnu_task(pdf)', '005', 'Output to PDF(L)', 'N', '2006-09-25 15:07:39', 'AJM', '2007-09-10 14:46:07', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)a', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:46:07', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task(list2)a', '2009-02-10 11:12:43', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_task(list2)a', '2009-02-10 11:37:58', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)a', 'This will list records on the TASK table for a selected PATTERN.

Refer to <a href=\"%root%/mnu_task(list2)a.html\">List Task by Pattern</a> for full details.', '2004-08-26 12:09:31', 'AJM', '2013-06-12 12:43:08', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)b', 'List Task by Subsystem', 'List Task', 'PROC', 'mnu_task(list2)b.php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, 'task_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:48:19', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)b', 'audit_dtl(list)3', '004', 'Audit Trail', 'Y', '2004-04-09 11:59:19', 'AJM', '2007-09-10 14:48:19', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)b', 'mnu_help_text(multi1)', '003', 'Help Text', 'Y', '2006-07-21 11:36:38', 'AJM', '2007-09-10 14:48:19', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)b', 'mnu_task(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:48:18', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)b', 'mnu_task(pdf)', '005', 'Output to PDF(L)', 'N', '2006-09-25 15:08:41', 'AJM', '2007-09-10 14:48:19', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)b', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:48:18', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task(list2)b', '2009-02-10 11:12:44', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_task(list2)b', '2009-02-10 11:37:59', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(list2)b', 'This will list records on the TASK table for a selected SUBSYSTEM.

Refer to <a href=\"%root%/mnu_task(list2)b.html\">List Task by Subsystem</a> for full details.', '2004-08-26 12:09:43', 'AJM', '2013-06-12 12:43:14', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(pdf)', 'Output to PDF - List view', 'Output to PDF(L)', 'PROC', 'mnu_task(pdf).php', 'N', 'OUTPUT2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-08-17 11:05:50', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task(pdf)', '2009-02-10 11:12:44', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_task(pdf)', '2009-02-10 11:37:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(pdf)2', 'Output to PDF - Detail view', 'Output to PDF(D)', 'PROC', 'mnu_task(pdf)2.php', 'N', 'OUTPUT3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-08-17 11:33:23', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task(pdf)2', '2009-02-10 11:12:44', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_task(pdf)2', '2009-02-10 11:37:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(pdf)3', 'Output to PDF - Navigation Buttons', 'Nav Buttons (PDF)', 'PROC', 'mnu_task(pdf)3.php', 'N', 'OUTPUT3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-08-27 21:57:58', 'AJM', '2006-08-27 22:00:30', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task(pdf)3', '2009-02-10 11:12:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_task(pdf)3', '2009-02-10 11:38:11', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)', 'Choose Task', 'Choose', 'PROC', 'mnu_task(popup1).php', 'N', 'POPUP1', 'MENU', NULL, NULL, NULL, 'select_one=FALSE', 'task_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:58:15', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:58:15', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task(popup1)', '2009-07-22 00:52:29', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_task(popup1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:58:15', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)', 'This will list records on the TASK table and allow one or more to be selected.

After selecting records please press the CHOOSE button.

Refer to <a href=\"%root%/mnu_task(popup1).html\">Choose Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 13:50:48', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a', 'Choose Task (proc)', 'Choose', 'PROC', 'mnu_task(popup1).php', 'N', 'POPUP1', 'MENU', NULL, 'task_type=\'PROC\'', NULL, 'select_one=FALSE', 'task_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2004-08-12 15:43:07', 'AJM', '2007-09-10 14:59:10', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a', 'mnu_task(search)', '001', 'Search', 'N', '2004-08-26 12:00:46', 'AJM', '2007-09-10 14:59:10', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task(popup1)a', '2009-07-22 00:52:41', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a', 'This will list records on the TASK table with type = PROC and allow one or more to be selected.

After selecting records please press the CHOOSE button.

Refer to <a href=\"%root%/mnu_task(popup1)a.html\">Choose Task (Proc)</a> for full details.', '2004-08-26 14:09:00', 'AJM', '2013-06-12 14:11:33', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a1', 'Choose Task (proc)', 'Choose', 'PROC', 'mnu_task(popup1).php', 'N', 'POPUP1', 'MENU', NULL, 'task_type=\'PROC\'', NULL, 'select_one=FALSE', 'task_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2010-07-18 13:24:51', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a1', 'mnu_task(search)', '001', 'Search', 'N', '2010-07-18 15:47:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task(popup1)a1', '2010-07-24 11:52:14', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a1', '[copy: mnu_task(popup1)a]', '2013-06-12 13:56:46', 'AJM', '2013-06-12 14:12:04', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a2', 'Choose Task (proc)', 'Choose', 'PROC', 'mnu_task(popup1).php', 'N', 'POPUP1', 'MENU', NULL, 'task_type=\'PROC\'', NULL, 'select_one=FALSE', 'task_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2010-07-18 13:25:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a2', 'mnu_task(search)', '001', 'Search', 'N', '2010-07-18 15:47:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task(popup1)a2', '2010-07-24 11:52:15', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)a2', '[copy: mnu_task(popup1)a]', '2013-06-12 13:57:56', 'AJM', '2013-06-12 14:12:09', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)b', 'Choose Task (menu)', 'Choose', 'PROC', 'mnu_task(popup1).php', 'N', 'POPUP1', 'MENU', NULL, 'task_type=\'MENU\'', NULL, 'select_one=TRUE', 'task_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:59:46', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)b', 'mnu_task(search)', '001', 'Search', 'N', '2007-10-13 13:33:24', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task(popup1)b', '2009-07-22 00:52:41', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(popup1)b', 'This will list records on the TASK table with type = MENUand allow one or more to be selected.

After selecting records please press the CHOOSE button.

Refer to <a href=\"%root%/mnu_task(popup1)b.html\">Choose Task (Menu)</a> for full details.', '2004-08-26 14:09:10', 'AJM', '2013-06-12 14:12:36', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(rename)', 'Rename Task', 'Rename', 'PROC', 'mnu_task(upd2).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:02:13', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(rename)', 'This will allow a entry on the TASK table to be renamed. It will also rename any associated records on any related tables. 

Refer to <a href=\"%root%/mnu_task(rename).html\">Rename Task</a> for full details.', '2004-08-26 12:25:54', 'AJM', '2013-06-12 13:58:48', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(search)', 'Search Task', 'Search', 'PROC', 'mnu_task(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:50:51', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_task(search)', '2009-02-10 11:12:59', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_task(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(search)', 'This will allow search criteria to be entered for the TASK table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_task(search).html\">Search Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:08:08', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(upd1)', 'Update Task', 'Update', 'PROC', 'mnu_task(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:55:16', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_task(upd1)', 'This will display the contents of a record from the TASK table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_task(upd1).html\">Update Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:08:10', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(add2)', 'Add Time Limit for Role', 'New', 'PROC', 'mnu_time_limit_role(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2013-04-21 16:42:19', 'AJM', '2013-04-21 16:54:12', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(add2)', 'This will allow a record to be added to the TIME_LIMIT_ROLE table for a selected ROLE.

Refer to <a href=\"%root%/mnu_time_limit_role(add2).html\">Add Time Limit for Role</a> for full details.', '2013-06-12 15:24:37', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(del1)', 'Delete Time Limit for Role', 'Delete', 'PROC', 'mnu_time_limit_role(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2013-04-21 16:42:21', 'AJM', '2013-04-21 16:54:27', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(del1)', 'This will display a record from the TIME_LIMIT_ROLE table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_time_limit_role(del1).html\">Delete Time Limit for Role</a> for full details.', '2013-06-12 15:27:03', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(enq1)', 'Enquire Time Limit for Role', 'Read', 'PROC', 'mnu_time_limit_role(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2013-04-21 16:42:20', 'AJM', '2013-04-21 16:54:41', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(enq1)', 'This will display a record from the TIME_LIMIT_ROLE table.

Refer to <a href=\"%root%/mnu_time_limit_role(enq1).html\">Enquire Time Limit for Role</a> for full details.', '2013-06-12 15:27:49', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(list2)', 'List Time Limit for Role', 'Time Limits', 'PROC', 'mnu_time_limit_role(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2013-04-21 16:42:19', 'AJM', '2013-04-21 16:55:01', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2013-04-21 16:42:23', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(list2)', 'mnu_time_limit_role(add2)', '001', 'New', 'N', '2013-04-21 16:42:22', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(list2)', 'mnu_time_limit_role(del1)', '004', 'Delete', 'Y', '2013-04-21 16:42:22', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(list2)', 'mnu_time_limit_role(enq1)', '002', 'Read', 'Y', '2013-04-21 16:42:22', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(list2)', 'mnu_time_limit_role(search)', '005', 'Search', 'N', '2013-04-21 16:42:22', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(list2)', 'mnu_time_limit_role(upd1)', '003', 'Update', 'Y', '2013-04-21 16:42:22', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(list2)', 'This will list records on the TIME_LIMIT_ROLE table for a selected ROLE.

Refer to <a href=\"%root%/mnu_time_limit_role(list2).html\">List Time Limit for Role</a> for full details.', '2013-06-12 15:22:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(search)', 'Search Time Limit for Role', 'Search', 'PROC', 'mnu_time_limit_role(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2013-04-21 16:42:22', 'AJM', '2013-04-21 16:55:16', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(search)', 'This will allow search criteria to be entered for the TIME_LIMIT_ROLE table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_time_limit_role(search).html\">Search Time Limit for Role</a> for full details.', '2013-06-12 15:29:29', 'AJM', '2013-06-12 15:29:50', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(upd1)', 'Update Time Limit for Role', 'Update', 'PROC', 'mnu_time_limit_role(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2013-04-21 16:42:21', 'AJM', '2013-04-21 16:55:32', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_role(upd1)', 'This will display a record from the TIME_LIMIT_ROLE table and allow it to be updated.

Refer to <a href=\"%root%/mnu_time_limit_role(upd1).html\">Update Time Limit for Role</a> for full details.', '2013-06-12 15:30:24', 'AJM', '2013-06-12 15:31:14', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(add2)', 'Add Time Limit for User', 'New', 'PROC', 'mnu_time_limit_user(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2013-04-21 16:45:43', 'AJM', '2013-04-21 16:57:39', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(add2)', 'This will allow a record to be added to the TIME_LIMIT_USER table for a selected User.

Refer to <a href=\"%root%/mnu_time_limit_user(add2).html\">Add Time Limit for User</a> for full details.', '2013-06-12 15:24:37', 'AJM', '2013-06-12 16:33:37', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(del1)', 'Delete Time Limit for User', 'Delete', 'PROC', 'mnu_time_limit_user(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2013-04-21 16:45:45', 'AJM', '2013-04-21 16:57:55', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(del1)', 'This will display a record from the TIME_LIMIT_USER table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_time_limit_user(del1).html\">Delete Time Limit for User</a> for full details.', '2013-06-12 15:27:03', 'AJM', '2013-06-12 16:33:48', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(enq1)', 'Enquire Time Limit for User', 'Read', 'PROC', 'mnu_time_limit_user(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2013-04-21 16:45:44', 'AJM', '2013-04-21 16:58:08', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(enq1)', 'This will display a record from the TIME_LIMIT_USER table.

Refer to <a href=\"%root%/mnu_time_limit_user(enq1).html\">Enquire Time Limit for User</a> for full details.', '2013-06-12 15:27:49', 'AJM', '2013-06-12 16:33:57', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(list2)', 'List Time Limit for User', 'Time Limits', 'PROC', 'mnu_time_limit_user(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2013-04-21 16:45:43', 'AJM', '2013-04-21 16:58:47', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2013-04-21 16:45:46', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(list2)', 'mnu_time_limit_user(add2)', '001', 'New', 'N', '2013-04-21 16:45:46', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(list2)', 'mnu_time_limit_user(del1)', '004', 'Delete', 'Y', '2013-04-21 16:45:46', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(list2)', 'mnu_time_limit_user(enq1)', '002', 'Read', 'Y', '2013-04-21 16:45:46', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(list2)', 'mnu_time_limit_user(search)', '005', 'Search', 'N', '2013-04-21 16:45:46', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(list2)', 'mnu_time_limit_user(upd1)', '003', 'Update', 'Y', '2013-04-21 16:45:46', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(list2)', 'This will list records on the TIME_LIMIT_USER table for a selected User.

Refer to <a href=\"%root%/mnu_time_limit_user(list2).html\">List Time Limit for User</a> for full details.', '2013-06-12 15:22:34', 'AJM', '2013-06-12 16:34:06', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(search)', 'Search Time Limit for User', 'Search', 'PROC', 'mnu_time_limit_user(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2013-04-21 16:45:45', 'AJM', '2013-04-21 16:59:03', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(search)', 'This will allow search criteria to be entered for the TIME_LIMIT_USER table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_time_limit_user(search).html\">Search Time Limit for User</a> for full details.', '2013-06-12 15:29:29', 'AJM', '2013-06-12 16:34:15', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(upd1)', 'Update Time Limit for User', 'Update', 'PROC', 'mnu_time_limit_user(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2013-04-21 16:45:44', 'AJM', '2013-04-21 16:59:19', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_time_limit_user(upd1)', 'This will display a record from the TIME_LIMIT_USER table and allow it to be updated.

Refer to <a href=\"%root%/mnu_time_limit_user(upd1).html\">Update Time Limit for User</a> for full details.', '2013-06-12 15:30:24', 'AJM', '2013-06-12 16:34:24', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(add1)', 'Add ToDo', 'New', 'PROC', 'mnu_todo(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-07-30 17:55:07', 'AJM', '2007-09-10 15:06:43', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_todo(add1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_todo(add1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_todo(add1)', '2009-02-10 11:13:05', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEV', 'mnu_todo(add1)', '2005-07-31 16:30:31', 'AJM', '2007-09-10 15:06:42', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_todo(add1)', '2005-07-31 16:30:52', 'AJM', '2007-09-10 15:06:42', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_todo(add1)', '2012-05-26 15:29:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_todo(add1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_todo(add1)', '2012-02-29 21:58:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_todo(add1)', '2005-07-31 16:31:17', 'AJM', '2007-09-10 15:06:43', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_todo(add1)', '2005-07-31 16:31:24', 'AJM', '2007-09-10 15:06:43', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_todo(add1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(add1)', 'This will allow a new record to be added to the ToDo table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_todo(add1).html\">Add ToDo</a> for full details.', '2006-04-19 16:10:08', 'AJM', '2013-06-12 14:20:02', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(complete)', 'Set selection criteria to COMPLETE', 'COMPLETE', 'PROC', 'mnu_todo(complete).php', 'N', 'OTHER', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2010-07-24 11:07:35', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_todo(complete)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_todo(complete)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_todo(complete)', '2010-07-24 11:52:03', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_todo(complete)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_todo(complete)', '2012-05-26 15:29:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_todo(complete)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_todo(complete)', '2012-02-29 21:58:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_todo(complete)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_todo(complete)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_todo(complete)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(del1)', 'Delete ToDo', 'Delete', 'PROC', 'mnu_todo(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-07-30 17:55:33', 'AJM', '2007-09-10 15:08:08', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_todo(del1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_todo(del1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_todo(del1)', '2009-02-10 11:13:05', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEV', 'mnu_todo(del1)', '2005-07-31 16:30:31', 'AJM', '2007-09-10 15:08:08', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_todo(del1)', '2005-07-31 16:30:53', 'AJM', '2007-09-10 15:08:08', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_todo(del1)', '2012-05-26 15:29:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_todo(del1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_todo(del1)', '2012-02-29 21:58:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_todo(del1)', '2005-07-31 16:31:17', 'AJM', '2007-09-10 15:08:08', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_todo(del1)', '2005-07-31 16:31:24', 'AJM', '2007-09-10 15:08:08', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_todo(del1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(del1)', 'This will display a record from the ToDo table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_todo(del1).html\">Delete ToDo</a> for full details.', '2006-04-19 16:10:55', 'AJM', '2013-06-12 14:20:04', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(enq1)', 'Enquire ToDo', 'Read', 'PROC', 'mnu_todo(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-07-30 17:56:00', 'AJM', '2007-09-10 15:09:07', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_todo(enq1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_todo(enq1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_todo(enq1)', '2009-02-10 11:12:59', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEV', 'mnu_todo(enq1)', '2005-07-31 16:30:31', 'AJM', '2007-09-10 15:09:06', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_todo(enq1)', '2005-07-31 16:30:53', 'AJM', '2007-09-10 15:09:06', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_todo(enq1)', '2012-05-26 15:29:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_todo(enq1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_todo(enq1)', '2012-02-29 21:58:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_todo(enq1)', '2005-07-31 16:31:17', 'AJM', '2007-09-10 15:09:07', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_todo(enq1)', '2005-07-31 16:31:24', 'AJM', '2007-09-10 15:09:07', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_todo(enq1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(enq1)', 'This will display the contents of a record from the ToDo table.

Refer to <a href=\"%root%/mnu_todo(enq1).html\">Enquire ToDo</a> for full details.', '2006-04-19 16:12:45', 'AJM', '2013-06-12 14:20:06', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(incomplete)', 'Set selection criteria to INCOMPLETE', 'INCOMPLETE', 'PROC', 'mnu_todo(incomplete).php', 'N', 'OTHER', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2010-07-24 11:07:59', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_todo(incomplete)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_todo(incomplete)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_todo(incomplete)', '2010-07-24 11:52:03', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_todo(incomplete)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_todo(incomplete)', '2012-05-26 15:29:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_todo(incomplete)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_todo(incomplete)', '2012-02-29 21:58:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_todo(incomplete)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_todo(incomplete)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_todo(incomplete)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'List ToDo', 'ToDo', 'PROC', 'mnu_todo(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, 'is_complete=\'N\'', NULL, NULL, 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2005-07-30 17:54:29', 'AJM', '2007-09-10 15:11:15', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2005-07-30 19:32:15', 'AJM', '2010-07-24 11:09:39', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'mnu_todo(add1)', '001', 'New', 'N', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:11:15', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'mnu_todo(complete)', '006', 'COMPLETE', 'N', '2010-07-24 11:08:59', 'AJM', '2010-07-24 11:09:39', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'mnu_todo(del1)', '005', 'Delete', 'Y', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:11:15', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'mnu_todo(enq1)', '003', 'Read', 'Y', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:11:15', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'mnu_todo(incomplete)', '007', 'INCOMPLETE', 'N', '2010-07-24 11:09:20', 'AJM', '2010-07-24 11:09:39', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'mnu_todo(search)', '002', 'Search', 'N', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:11:15', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'mnu_todo(upd1)', '004', 'Update', 'Y', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:15:51', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_todo(list1)', '2009-02-10 11:13:27', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_todo(list1)', '2009-02-10 11:38:26', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_todo(list1)', '2012-02-29 21:58:57', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list1)', 'This will list records on the ToDo table.

Refer to <a href=\"%root%/mnu_todo(list1).html\">List ToDo</a> for full details.', '2006-04-19 15:57:45', 'AJM', '2013-06-12 14:20:08', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list2)', 'List ToDo by User', 'ToDo', 'PROC', 'mnu_todo(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, 'is_complete=\'N\'', NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-07-30 19:17:53', 'AJM', '2007-09-10 15:12:37', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list2)', 'audit_dtl(list)3', '008', 'Audit Trail', 'Y', '2005-07-30 19:32:02', 'AJM', '2010-07-24 11:10:52', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list2)', 'mnu_todo(add1)', '001', 'New', 'N', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:12:37', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list2)', 'mnu_todo(complete)', '006', 'COMPLETE', 'N', '2010-07-24 11:10:09', 'AJM', '2010-07-24 11:10:53', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list2)', 'mnu_todo(del1)', '005', 'Delete', 'Y', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:12:37', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list2)', 'mnu_todo(enq1)', '003', 'Read', 'Y', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:12:37', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list2)', 'mnu_todo(incomplete)', '007', 'INCOMPLETE', 'N', '2010-07-24 11:10:25', 'AJM', '2010-07-24 11:10:53', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list2)', 'mnu_todo(search)', '002', 'Search', 'N', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:12:37', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list2)', 'mnu_todo(upd1)', '004', 'Update', 'Y', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:15:51', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_todo(list2)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_todo(list2)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_todo(list2)', '2009-02-10 11:13:27', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEV', 'mnu_todo(list2)', '2005-07-31 16:30:31', 'AJM', '2007-09-10 15:12:37', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_todo(list2)', '2005-07-31 16:30:53', 'AJM', '2007-09-10 15:12:37', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_todo(list2)', '2012-05-26 15:29:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_todo(list2)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_todo(list2)', '2012-02-29 21:58:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_todo(list2)', '2005-07-31 16:31:17', 'AJM', '2007-09-10 15:12:37', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_todo(list2)', '2005-07-31 16:31:24', 'AJM', '2007-09-10 15:12:37', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_todo(list2)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(list2)', 'This will list records on the ToDo table for a particular USER.

Refer to <a href=\"%root%/mnu_todo(list)2.html\">List ToDo for User</a> for full details.', '2006-04-19 16:07:56', 'AJM', '2013-06-12 14:20:10', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(search)', 'Search ToDo', 'Search', 'PROC', 'mnu_todo(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-07-30 17:56:31', 'AJM', '2007-09-10 15:12:59', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_todo(search)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_todo(search)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_todo(search)', '2009-02-10 11:13:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEV', 'mnu_todo(search)', '2005-07-31 16:30:31', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_todo(search)', '2005-07-31 16:30:53', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_todo(search)', '2012-05-26 15:29:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_todo(search)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_todo(search)', '2012-02-29 21:58:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_todo(search)', '2005-07-31 16:31:17', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_todo(search)', '2005-07-31 16:31:24', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_todo(search)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(search)', 'This will allow search criteria to be entered for the ToDo table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_todo(search).html\">Search ToDo</a> for full details.', '2006-04-19 16:13:45', 'AJM', '2013-06-12 14:20:12', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(upd1)', 'Update ToDo', 'Update', 'PROC', 'mnu_todo(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2005-07-30 17:57:00', 'AJM', '2007-09-10 15:15:51', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_todo(upd1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_todo(upd1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_todo(upd1)', '2009-02-10 11:13:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEV', 'mnu_todo(upd1)', '2005-07-31 16:30:31', 'AJM', '2007-09-10 15:15:51', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_todo(upd1)', '2005-07-31 16:30:53', 'AJM', '2007-09-10 15:15:51', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_todo(upd1)', '2012-05-26 15:29:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_todo(upd1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_todo(upd1)', '2012-02-29 21:59:15', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_todo(upd1)', '2005-07-31 16:31:17', 'AJM', '2007-09-10 15:15:51', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_todo(upd1)', '2005-07-31 16:31:24', 'AJM', '2007-09-10 15:15:51', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_todo(upd1)', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_todo(upd1)', 'This will display the contents of a record from the ToDo table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_todo(upd1).html\">Update ToDo</a> for full details.', '2006-04-19 16:14:40', 'AJM', '2013-06-12 14:20:14', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(add2)', 'Add User IP Address', 'New', 'PROC', 'mnu_user_ip_address(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-11-15 18:22:05', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(add2)', 'This will allow a new record to be added to the USER_IP_ADDRESS table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_user_ip_address(add2).html\">Add User IP Address</a> for full details.', '2009-12-05 10:46:48', 'AJM', '2013-06-12 14:22:52', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(del1)', 'Delete User IP Address', 'Delete', 'PROC', 'mnu_user_ip_address(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-11-15 18:22:07', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(del1)', 'This will display a record from the USER_IP_ADDRESS table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_user_ip_address(del1).html\">Delete User IP Address</a> for full details.', '2009-12-05 10:47:57', 'AJM', '2013-06-12 14:21:53', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(enq1)', 'Enquire User IP Address', 'Read', 'PROC', 'mnu_user_ip_address(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-11-15 18:22:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_user_ip_address(enq1)', '2010-07-24 11:51:26', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(enq1)', 'This will display the contents of a record from the USER_IP_ADDRESS table.

Refer to <a href=\"%root%/mnu_user_ip_address(enq1).html\">Enquire User IP Address</a> for full details.', '2009-12-05 10:48:25', 'AJM', '2013-06-12 14:21:55', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(list2)', 'List IP Address by User', 'User IP Address', 'PROC', 'mnu_user_ip_address(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-11-15 18:22:04', 'AJM', '2009-11-15 18:23:33', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2009-11-15 18:22:13', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(list2)', 'mnu_user_ip_address(add2)', '001', 'New', 'N', '2009-11-15 18:22:10', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(list2)', 'mnu_user_ip_address(del1)', '004', 'Delete', 'Y', '2009-11-15 18:22:11', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(list2)', 'mnu_user_ip_address(enq1)', '002', 'Read', 'Y', '2009-11-15 18:22:10', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(list2)', 'mnu_user_ip_address(search)', '005', 'Search', 'N', '2009-11-15 18:22:12', 'AJM', NULL, NULL);
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(list2)', 'mnu_user_ip_address(upd1)', '003', 'Update', 'Y', '2009-11-15 18:22:11', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_user_ip_address(list2)', '2010-07-24 11:51:27', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(list2)', 'This will list records on the USER_IP_ADDRESS table for a selected User.

Refer to <a href=\"%root%/mnu_user_ip_address(list2).html\">List IP Address by User</a> for full details.', '2009-12-05 10:49:07', 'AJM', '2013-06-12 14:21:56', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(search)', 'Search User IP Address', 'Search', 'PROC', 'mnu_user_ip_address(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-11-15 18:22:09', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_user_ip_address(search)', '2010-07-24 11:51:47', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(search)', 'This will allow search criteria to be entered for the USER_IP_ADDRESS table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_user_ip_address(search).html\">Search User IP Address</a> for full details.', '2009-12-05 10:49:42', 'AJM', '2013-06-12 14:21:58', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(upd1)', 'Update User IP Address', 'Update', 'PROC', 'mnu_user_ip_address(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2009-11-15 18:22:06', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user_ip_address(upd1)', 'This will display the contents of a record from the USER_IP_ADDRESS table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_user_ip_address(upd1).html\">Update User IP Address</a> for full details.', '2009-12-05 10:50:17', 'AJM', '2013-06-12 14:22:00', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(add1)', 'Add User', 'Insert', 'PROC', 'mnu_user(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 15:18:35', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(add1)', 'This will allow a new record to be added to the USER table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_user(add1).html\">Add User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:35:32', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(del1)', 'Delete User', 'Delete', 'PROC', 'mnu_user(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 15:22:17', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(del1)', 'This will display a record from the USER table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_user(del1).html\">Delete User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:35:35', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(enq1)', 'Enquire User', 'Enquire', 'PROC', 'mnu_user(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 15:23:14', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_user(enq1)', '2009-02-10 11:13:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_user(enq1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:23:14', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(enq1)', 'This will display the contents of a record from the USER table.

Refer to <a href=\"%root%/mnu_user(enq1).html\">Enquire User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:35:37', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'List User', 'List User', 'PROC', 'mnu_user(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, 'user_id', 'Y', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 15:25:14', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'audit_dtl(list)3', '015', 'Audit Trail', 'Y', '2004-04-09 11:39:20', 'AJM', '2013-04-21 17:01:27', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_favourite(list2)', '013', 'Favourites', 'Y', '2010-07-20 10:56:02', 'AJM', '2010-07-20 10:56:19', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_initial_value_user(multi3)b', '008', 'Initial Values', 'Y', '2007-05-27 10:44:10', 'AJM', '2007-09-10 15:25:13', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_time_limit_user(list2)', '014', 'Time Limits', 'Y', '2013-04-21 17:00:46', 'AJM', '2013-04-21 17:01:28', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_todo(list2)', '007', 'ToDo', 'Y', '2005-07-30 19:18:31', 'AJM', '2007-09-10 15:25:13', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user_ip_address(list2)', '011', 'IP Address', 'Y', '2009-11-15 18:24:21', 'AJM', '2010-07-20 10:55:48', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user(pdf)', '010', 'Output to PDF(L)', 'N', '2006-08-17 19:01:45', 'AJM', '2007-09-10 15:25:13', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user(search)', '009', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:31:43', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user(upd1)a', '005', 'Change Password', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:35:45', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'mnu_user(upd1)b', '006', 'Reset Password', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:37:19', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'py_email_signature(multi1)', '012', 'Email Signature', 'Y', '2010-04-29 16:51:24', 'AJM', '2013-04-21 17:03:04', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_user(list1)', '2009-02-10 11:13:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_user(list1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list1)', 'This will list records on the USER table.

Refer to <a href=\"%root%/mnu_user(list1).html\">List User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:35:38', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list2)', 'List User by Role', 'List User', 'PROC', 'mnu_user(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, 'user_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:27:06', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list2)', 'audit_dtl(list)3', '001', 'Audit Trail', 'Y', '2004-04-09 11:59:34', 'AJM', '2007-09-10 15:27:06', 'AJM');
REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list2)', 'mnu_initial_value_user(multi3)b', '002', 'Initial Values', 'Y', '2007-05-27 10:45:41', 'AJM', '2007-09-10 15:27:06', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_user(list2)', '2009-02-10 11:13:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_user(list2)', '2009-02-10 11:38:26', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(list2)', 'This will list records on the USER table for a selected ROLE.

Refer to <a href=\"%root%/mnu_user(list2).html\">List User by Role</a> for full details.', '2004-08-26 12:10:17', 'AJM', '2013-06-12 14:35:40', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(pdf)', 'Output to PDF - List view', 'Output to PDF(L)', 'PROC', 'mnu_user(pdf).php', 'N', 'OUTPUT2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-08-17 19:01:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_user(pdf)', '2009-02-10 11:13:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_user(pdf)', '2009-02-10 11:38:26', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(popup1)', 'Choose User', 'Choose', 'PROC', 'mnu_user(popup1).php', 'N', 'POPUP1', 'MENU', NULL, NULL, NULL, NULL, 'user_id', 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 15:28:55', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_user(popup1)', '2009-07-22 00:52:51', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(popup1)', 'This will list records on the USER table and allow one or more to be selected.

After selecting records please press the CHOOSE button to return to the previous screen.

Refer to <a href=\"%root%/mnu_user(popup1).html\">Choose User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:35:42', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(search)', 'Search User', 'Search', 'PROC', 'mnu_user(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 15:30:18', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_user(search)', '2009-02-10 11:13:39', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_user(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(search)', 'This will allow search criteria to be entered for the USER table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_user(search).html\">Search User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:43:17', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(upd1)', 'Update User', 'Update', 'PROC', 'mnu_user(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 15:31:44', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(upd1)', 'This will display the contents of a record from the USER table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_user(upd1).html\">Update User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:43:20', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(upd1)a', 'Change User Password', 'Change Password', 'PROC', 'mnu_user(upd1)a.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'Y', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 15:35:45', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_user(upd1)a', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_user(upd1)a', '2010-04-13 11:55:01', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_user(upd1)a', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_user(upd1)a', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_user(upd1)a', '2012-05-26 15:29:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_user(upd1)a', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_user(upd1)a', '2012-02-29 21:59:38', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_user(upd1)a', '2011-07-22 14:08:24', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_user(upd1)a', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_user(upd1)a', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(upd1)a', 'This will allow a user\'s password to be changed.

Refer to <a href=\"%root%/mnu_user(upd1)a.html\">Change User Password</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:44:12', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(upd1)b', 'Reset User Password', 'Reset Password', 'PROC', 'mnu_user(upd1)b.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'Y', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2007-09-10 15:37:20', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_user(upd1)b', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_user(upd1)b', '2010-04-13 11:55:02', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_user(upd1)b', '2009-02-10 11:39:11', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_user(upd1)b', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:37:19', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_user(upd1)b', '2012-05-26 15:29:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_user(upd1)b', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_user(upd1)b', '2012-02-29 21:59:38', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_user(upd1)b', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:37:20', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_user(upd1)b', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:37:20', 'AJM');
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_user(upd1)b', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(upd1)b', 'This will allow a user\'s password to be changed.

Refer to <a href=\"%root%/mnu_user(upd1)b.html\">Reset User Password</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2013-06-12 14:44:34', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(upd1)c', 'Retrieve User Password', 'Retrieve Password', 'PROC', 'mnu_user(upd1)c.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, '2006-04-23 11:39:09', 'AJM', '2007-09-10 15:33:47', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('ADMIN', 'mnu_user(upd1)c', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'mnu_user(upd1)c', '2010-04-13 11:55:02', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'mnu_user(upd1)c', '2009-02-10 11:39:11', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'mnu_user(upd1)c', '2009-02-10 11:38:48', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SALES', 'mnu_user(upd1)c', '2012-05-26 15:29:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SUPPLIER', 'mnu_user(upd1)c', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER', 'mnu_user(upd1)c', '2012-02-29 21:59:38', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'mnu_user(upd1)c', '2011-07-22 14:08:25', 'AJM', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'mnu_user(upd1)c', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);
REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'mnu_user(upd1)c', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('mnu_user(upd1)c', 'Enter your e-mail address and your password will be sent to you.

Note: this will only work if your e-mail address is recorded on your user details.

Refer to <a href=\"%root%/mnu_user(pswd).html\">Retrieve Password</a> for full details.', '2006-04-23 11:41:11', 'AJM', '2013-06-12 14:45:02', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('applications', 'Applications', 'Transix', 'MENU', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, NULL, NULL, NULL, NULL, '2005-05-05 17:45:29', 'AJM', '2008-02-26 11:53:32', 'AJM');
REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('main_menu', 'Main index page', 'Menu1', 'MENU', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'Menu System', 'Menu System', 'MENU', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `max_execution_time`, `task_id_run_at_end`, `task_id_run_at_cancel`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('proto', 'Prototypes', 'PROTO', 'MENU', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, NULL, NULL, NULL, NULL, '2007-07-09 23:09:13', 'AJM', NULL, NULL);

REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('main_menu', 'applications', '005', 'Transix', '2005-05-05 17:46:59', 'AJM', '2008-02-26 11:54:29', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('main_menu', 'menu01', '001', 'Menu System', '2004-09-08 18:07:24', 'AJM', '2004-09-08 18:07:33', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_account(list1)', '010', 'Hosting Account', '2007-09-13 11:37:37', 'AJM', NULL, NULL);
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_control(upd3)', '001', 'Menu Controls', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:32', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_language(list1)', '011', 'Languages', '2008-01-03 11:38:46', 'AJM', '2008-01-03 11:39:14', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_motd(list1)', '012', 'MOTD', '2009-05-05 11:40:28', 'AJM', NULL, NULL);
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_pattern(list1)', '002', 'Pattern', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:55:34', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_role(list1)', '007', 'Role', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_subsystem(list1)', '003', 'Subsystem', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:01:47', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_task(list1)', '004', 'Task (All)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_task(list1)a', '005', 'Task (Proc)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_task(list1)b', '006', 'Task (Menu)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:52', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_todo(list1)', '009', 'ToDo', '2005-07-30 17:59:41', 'AJM', '2007-09-10 15:11:15', 'AJM');
REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('menu01', 'mnu_user(list1)', '008', 'User', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM');

REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'AUDIT_DELETE', '2', '2012-01-25 09:29:14', 'AJM', '2012-01-29 11:39:11', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'AUTHENTICATION', 'INTERNAL', '2008-01-22 14:22:40', 'AJM', '2009-09-28 08:45:44', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'DEFAULT_LANGUAGE', 'en', '2005-07-05 17:20:23', 'AJM', '2005-07-14 17:02:12', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'LOGIN_TYPE', 'USER', '2008-10-05 14:53:39', 'AJM', '2009-09-30 14:13:24', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PAGINATION_WIDTH', '7', '2008-10-11 18:02:47', 'AJM', '2008-10-11 22:25:03', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_CHANGE', 'AR', '2003-01-01 12:00:00', 'AJM', '2010-04-03 23:58:59', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_COUNT', NULL, '2003-01-01 12:00:00', 'AJM', '2010-04-03 23:59:00', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_DAYS', NULL, '2003-01-01 12:00:00', 'AJM', '2008-07-21 11:35:43', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_ENCRYPT', 'Y', '2003-01-01 12:00:00', 'AJM', '2009-01-19 12:14:14', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_FORMAT_DIGITS', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_FORMAT_LOWER', NULL, '2003-01-01 12:00:00', 'AJM', '2007-05-17 19:07:00', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_FORMAT_MINLEN', '4', '2003-01-01 12:00:00', 'AJM', '2005-01-15 18:58:07', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_FORMAT_UPPER', NULL, '2003-01-01 12:00:00', 'AJM', '2007-08-20 22:56:55', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_HIDDEN', 'N', '2006-07-18 16:50:30', 'AJM', '2008-10-10 11:53:25', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_RETRIES', '3', '2003-01-01 12:00:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'PSWD_WARNING', '5', '2006-03-08 22:31:52', 'AJM', '2006-04-24 14:45:39', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SCROLLING_WIDTH', '5', '2008-10-11 18:02:47', 'AJM', '2008-10-11 22:25:03', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_END', NULL, '2006-04-16 14:43:28', 'AJM', '2013-01-12 16:52:19', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_FRIDAY', NULL, '2006-04-16 14:59:25', 'AJM', '2013-01-12 16:52:19', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_MONDAY', NULL, '2006-04-16 14:59:24', 'AJM', '2013-01-12 16:52:19', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_SATURDAY', NULL, '2006-04-16 14:59:25', 'AJM', '2013-01-12 16:52:19', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_START', NULL, '2006-04-16 14:43:28', 'AJM', '2013-01-12 16:52:19', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_SUNDAY', NULL, '2006-04-16 14:59:25', 'AJM', '2013-01-12 16:52:19', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_THURSDAY', NULL, '2006-04-16 14:59:25', 'AJM', '2013-01-12 16:52:20', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_TUESDAY', NULL, '2006-04-16 14:59:24', 'AJM', '2013-01-12 16:52:20', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_WARNING', NULL, '2006-04-16 14:43:28', 'AJM', '2006-04-17 14:59:47', 'AJM');
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SYSTEM', 'SHUTDOWN_WEDNESDAY', NULL, '2006-04-16 14:59:24', 'AJM', '2013-01-12 16:52:20', 'AJM');

REPLACE INTO `mnu_account` (`rdcaccount_id`, `account_name`, `rdcversion`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('1', 'Shared Account', '1', '2007-09-13 11:41:52', 'AJM', NULL, NULL);
REPLACE INTO `mnu_account` (`rdcaccount_id`, `account_name`, `rdcversion`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('2', 'Account #2', '1', '2009-07-10 13:33:53', 'AJM', NULL, NULL);
REPLACE INTO `mnu_account` (`rdcaccount_id`, `account_name`, `rdcversion`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('3', 'Account #3', '1', '2000-01-01 00:00:00', 'UNKNOWN', NULL, NULL);

REPLACE INTO `mnu_motd` (`motd_id`, `motd_subject`, `motd_message`, `start_date`, `end_date`, `role_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('1', 'Welcome to Wedding Rings Direct', 'Welcome to Wedding Rings Direct', '2009-12-30', '9999-12-31', NULL, '2009-12-30 14:56:22', 'AJM', '2011-02-17 18:55:03', 'AJM');

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `role_id`, `rdcaccount_id`, `pswd_chg_date`, `pswd_chg_time`, `pswd_count`, `in_use`, `is_disabled`, `logon_date`, `logon_time`, `language_code`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'Tony Marston', 'N0GxJ{(,:aR9]lDE', 'GLOBAL', NULL, '2013-09-12', '11:04:03', '85', 'Y', 'N', '2013-10-26', '15:05:45', NULL, '2003-01-01', '9999-12-31', '127.0.0.1', 'tony@marston-home.demon.co.uk', 'tony.marston', 'N', '98', NULL, '2003-01-01 12:00:00', 'AJM', '2013-10-18 17:58:09', 'AJM');

REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'req_request(add1)', 'PARTY_ID_QA', '69', 'N', '2008-02-26 14:04:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'req_request(add1)', 'PARTY_ID_MGR', '69', 'N', '2008-02-26 14:04:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'req_request(add1)', 'PARTY_ID_PREP', '69', 'N', '2008-02-26 14:04:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'shp_shipment(add2)', 'PARTY_ID_SENDER', '63', 'N', '2007-06-21 15:31:34', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'acc_credit_note(add1)', 'COMPANY_ID', '63', 'N', '2008-09-27 17:05:56', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'acc_credit_note(add4)', 'COMPANY_ID', '63', 'N', '2008-10-10 17:10:01', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_item_p(add4)', 'COMPANY_ID', '63', 'N', '2007-12-06 15:16:42', 'AJM', '2008-06-02 17:51:56', 'AJM');
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_item_p(upd4)', 'SUBJECT', 'moonstar_print_job', 'N', '2008-05-30 17:13:55', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_item_p(upd4)', '_FORMAT', 'format', 'N', '2008-06-27 18:51:23', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_item_p(upd4)', '_JOBNAME', 'ord_order_item_p(upd4)', 'N', '2008-06-27 18:51:24', 'AJM', '2011-08-06 14:20:27', 'AJM');
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_item_p(upd4)', '_QUANTITY', '1', 'N', '2008-06-27 18:51:24', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_item_p(upd4)', '_PRINTERNAME', 'printername', 'N', '2008-06-27 18:51:24', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_item_p(upd4)', 'PRINTER_ADDRESS', 'moonstar@weddingringsdirect.com', 'N', '2008-04-09 14:49:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'acc_invoice_header(add1)', 'COMPANY_ID', '63', 'N', '2008-07-18 17:02:02', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'acc_invoice_header(add4)', 'COMPANY_ID', '63', 'N', '2008-07-18 16:51:12', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_p(add1)', 'COMPANY_ID', '63', 'N', '2007-06-26 16:17:09', 'AJM', '2007-12-06 15:10:15', 'AJM');
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_t(add1)', 'COMPANY_ID', '63', 'N', '2007-06-24 17:14:43', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_item_s(multi2)', 'SUBJECT', 'moonstar_print_job', 'N', '2008-09-18 11:04:05', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_item_s(multi2)', '_FORMAT', 'slimbrand.lbl', 'N', '2008-09-18 11:01:30', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_item_s(multi2)', 'PARTY_ID', '50', 'N', '2007-12-09 16:22:22', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_item_s(multi2)', '_JOBNAME', 'SampleJob002', 'N', '2008-09-18 11:01:49', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_item_s(multi2)', '_QUANTITY', '1', 'N', '2008-09-18 11:02:55', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_item_s(multi2)', '_PRINTERNAME', 'moonstar', 'N', '2008-09-18 11:02:10', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_item_s(multi2)', 'PRINTER_ADDRESS', 'moonstar@weddingringsdirect.com', 'N', '2008-09-18 11:02:55', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'shp_dispatch_event(add1)', 'FACILITY_ID_ORIGIN', '1', 'N', '2007-06-21 10:27:45', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'shp_dispatch_event(add2)', 'FACILITY_ID_ORIGIN', '1', 'N', '2007-06-21 10:27:51', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'acc_credit_note(output3)b', 'SUBJECT', 'print this', 'N', '2008-09-29 16:07:18', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'acc_credit_note(output3)b', 'PRINTER_ADDRESS', 'printer@tonymarston.net', 'N', '2008-09-29 16:07:18', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'acc_invoice_header(add1)so', 'COMPANY_ID', '63', 'N', '2008-08-06 18:40:26', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'shp_fedex_shipment(multi1)', 'DROPOFF_TYPE', 'REGULAR_PICKUP', 'N', '2010-01-18 15:04:41', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'shp_fedex_shipment(multi1)', 'PAYMENT_TYPE', 'SENDER', 'N', '2010-01-18 15:04:42', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'shp_fedex_shipment(multi1)', 'WEIGHT_UNITS', 'KG', 'N', '2010-01-18 15:04:42', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'shp_fedex_shipment(multi1)', 'DOCUMENT_CONTENT', 'NON_DOCUMENTS', 'N', '2010-01-18 15:04:41', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(output3)', 'COMPANY_ID', '63', 'N', '2007-06-13 13:47:19', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_item_p(upd4)image', 'SUBJECT', 'moonstar_print_job', 'N', '2008-06-24 16:32:19', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_item_p(upd4)image', 'FILE_PATH', '..\\..\\www.weddingrings-direct.com\\images\\product_images\\large', 'N', '2008-06-24 17:23:05', 'AJM', '2008-06-24 17:40:21', 'AJM');
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_item_p(upd4)image', 'PRINTER_ADDRESS', 'moonstar@weddingringsdirect.com', 'N', '2008-06-24 16:32:19', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'py_party_relationship(add1)', 'REL_STATUS_ID', 'ACT', 'N', '2007-06-22 14:24:46', 'AJM', '2007-06-22 14:25:48', 'AJM');
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'py_party_relationship(add1)', 'REL_PRIORITY_ID', 'LOW', 'N', '2007-06-22 14:25:26', 'AJM', '2007-06-22 14:25:48', 'AJM');
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'py_party_relationship(add2)', 'REL_STATUS_ID', 'ACT', 'N', '2007-06-22 14:24:55', 'AJM', '2007-06-22 14:25:59', 'AJM');
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'py_party_relationship(add2)', 'REL_PRIORITY_ID', 'LOW', 'N', '2007-06-22 14:25:15', 'AJM', '2007-06-22 14:25:59', 'AJM');
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'acc_invoice_header(output3)b', 'SUBJECT', 'print this', 'N', '2008-06-14 14:39:31', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'acc_invoice_header(output3)b', 'PRINTER_ADDRESS', 'printer@tonymarston.net', 'N', '2008-06-14 14:39:30', 'AJM', '2008-09-29 15:54:29', 'AJM');
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_p(output3)b', 'SUBJECT', 'print this', 'N', '2008-06-11 15:53:01', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_p(output3)b', 'PRINTER_ADDRESS', 'printer@nowhere.foo', 'N', '2008-06-11 15:53:00', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(output3)a', 'COMPANY_ID', '63', 'N', '2007-06-13 13:47:25', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(output3)b', 'SUBJECT', 'print this', 'N', '2008-06-11 18:17:17', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(output3)b', 'COMPANY_ID', '63', 'N', '2008-06-11 18:17:16', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(output3)b', 'PRINTER_ADDRESS', 'printer@foo.bar', 'N', '2008-06-11 18:17:16', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_t(output3)b', 'SUBJECT', 'print this', 'N', '2008-06-11 18:36:43', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_t(output3)b', 'PRINTER_ADDRESS', 'printer@nowhere.foo', 'N', '2008-06-11 18:36:43', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_item_p(batch)build', 'COMPANY_ID', '63', 'N', '2009-08-04 17:46:26', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'shp_fedex_package(upd4)image', 'SUBJECT', 'moonstar_print_job', 'N', '2010-01-21 15:13:41', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'shp_fedex_package(upd4)image', 'PRINTER_ADDRESS', 'moonstar@weddingringsdirect.com', 'N', '2010-01-21 15:13:40', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(upd4)label', 'SUBJECT', 'moonstar_print_job', 'N', '2008-06-12 10:57:34', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(upd4)label', '_FORMAT', 'slimbrand.lbl', 'N', '2008-06-12 10:56:29', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(upd4)label', '_JOBNAME', 'ord_order_header_s(upd4)label', 'N', '2008-06-12 10:56:45', 'AJM', '2011-08-06 14:19:23', 'AJM');
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(upd4)label', '_QUANTITY', '1', 'N', '2008-06-12 10:57:06', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(upd4)label', '_PRINTERNAME', 'moonstar', 'N', '2008-06-12 10:57:06', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(upd4)label', 'PRINTER_ADDRESS', 'moonstar@weddingringsdirect.com', 'N', '2008-06-12 10:57:33', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_purchase_order_build(add4)', 'PARTY_ID', '50', 'N', '2008-06-02 10:26:14', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'shp_package_out_content(add4)out1', 'PARTY_ID_SENDER', '63', 'N', '2010-01-31 10:12:12', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'shp_return_matl_auth_hdr(output3)b', 'SUBJECT', 'print this', 'N', '2010-04-08 10:43:41', 'AJM', '2010-04-09 16:23:45', 'AJM');
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'shp_return_matl_auth_hdr(output3)b', 'PRINTER_ADDRESS', 'printer@tonymarston.net', 'N', '2010-04-08 10:43:40', 'AJM', '2010-04-09 16:23:44', 'AJM');
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(upd4)samplelabel', 'SUBJECT', 'foobar_print_job', 'N', '2011-07-04 11:23:45', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(upd4)samplelabel', '_FORMAT', 'foobar.lbl', 'N', '2011-07-04 11:23:42', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(upd4)samplelabel', '_JOBNAME', 'ord_order_header_s(upd4)samplelabel', 'N', '2011-07-04 11:23:43', 'AJM', '2011-08-06 14:20:08', 'AJM');
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(upd4)samplelabel', '_QUANTITY', '1', 'N', '2011-07-04 11:23:44', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(upd4)samplelabel', '_PRINTERNAME', 'foobar', 'N', '2011-07-04 11:23:43', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(upd4)samplelabel', 'PRINTER_ADDRESS', 'foobar@weddingringsdirect.com', 'N', '2011-07-04 11:23:44', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(upd4)label_status', 'SUBJECT', 'moonstar_print_job', 'N', '2011-07-09 12:15:49', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(upd4)label_status', '_FORMAT', 'slimbrand.lbl', 'N', '2011-07-09 12:15:49', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(upd4)label_status', '_JOBNAME', 'ord_order_header_s(upd4)label_status', 'N', '2011-07-09 12:15:49', 'AJM', '2011-08-06 14:19:46', 'AJM');
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(upd4)label_status', '_QUANTITY', '1', 'N', '2011-07-09 12:15:49', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(upd4)label_status', '_PRINTERNAME', 'moonstar', 'N', '2011-07-09 12:15:49', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'ord_order_header_s(upd4)label_status', 'PRINTER_ADDRESS', 'moonstar@weddingringsdirect.com', 'N', '2011-07-09 12:15:49', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'shp_fedex_package_out_content(multi4)', 'WEIGHT', '0.4', 'N', '2010-03-30 16:24:23', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'shp_fedex_package_out_content(multi4)', 'PACKAGING_TYPE', 'FEDEX_ENVELOPE', 'N', '2010-03-30 16:24:22', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', 'shp_fedex_package_out_content(multi4)', 'CUSTOMER_REF_TYPE0', 'CUSTOMER_REFERENCE', 'N', '2010-03-30 16:24:21', 'AJM', NULL, NULL);

REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '2', 'Do something', NULL, '2005-09-01', '7', 'Y', NULL, NULL, NULL, NULL, '2005-07-31 12:38:32', 'AJM', '2006-04-07 14:41:20', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '3', 'Do something else', NULL, '2005-10-01', '7', 'Y', NULL, NULL, NULL, NULL, '2005-07-31 12:38:59', 'AJM', '2006-04-07 14:41:23', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '4', 'Do something interesting', NULL, '2005-11-01', '7', 'Y', NULL, NULL, NULL, NULL, '2005-07-31 12:39:20', 'AJM', '2006-04-07 14:41:26', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '5', 'Do something boring', NULL, '2005-12-01', '7', 'Y', NULL, NULL, NULL, NULL, '2005-07-31 12:39:34', 'AJM', '2006-04-07 14:41:30', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '6', 'Make a new Year\'s Resolution', 'This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text. This is a note with lots of text.', '2006-01-01', '7', 'N', NULL, NULL, NULL, NULL, '2005-07-31 12:40:38', 'AJM', '2010-07-16 16:38:54', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '7', 'Break a new Year\'s Resolution', NULL, '2006-02-01', '7', 'N', NULL, NULL, NULL, NULL, '2005-07-31 12:40:53', 'AJM', '2006-04-07 14:45:17', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '8', 'Prepare for a long march', NULL, '2006-03-01', '7', 'N', NULL, NULL, NULL, NULL, '2005-07-31 12:41:09', 'AJM', '2005-07-31 17:41:16', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '9', 'Take a rest after a long march', NULL, '2006-04-01', '7', 'N', NULL, NULL, NULL, NULL, '2005-07-31 12:41:21', 'AJM', '2005-07-31 17:41:32', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '10', 'May the Fourth be with you', NULL, '2006-05-01', '7', 'N', NULL, NULL, NULL, NULL, '2005-07-31 12:41:35', 'AJM', '2005-07-31 17:41:49', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '11', 'Watch out for June bugs', NULL, '2006-06-01', '7', 'Y', NULL, NULL, NULL, NULL, '2005-07-31 12:41:49', 'AJM', '2006-04-07 14:45:42', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '12', 'Test for 1st July 2006', NULL, '2006-07-01', '7', 'N', NULL, NULL, NULL, NULL, '2005-07-31 12:41:59', 'AJM', '2007-05-29 11:53:06', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '13', 'this is just a test', 'this is jst a test', '2006-09-30', '7', 'N', NULL, NULL, NULL, NULL, '2006-09-19 14:30:51', 'AJM', NULL, NULL);
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '14', 'Test for June 1st 2007', NULL, '2007-06-01', '7', 'Y', '1', 'M', NULL, NULL, '2007-05-28 11:41:01', 'AJM', '2007-05-29 11:55:11', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '15', 'Test for June 1st 2008', NULL, '2008-06-01', '7', 'N', NULL, NULL, NULL, NULL, '2007-05-28 11:41:23', 'AJM', NULL, NULL);
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '16', 'Test for June 1st 2007', NULL, '2007-07-01', '7', 'N', '1', 'M', NULL, NULL, '2007-05-29 11:55:24', 'AJM', NULL, NULL);
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '17', 'test', NULL, '2007-08-27', '7', 'Y', NULL, NULL, NULL, NULL, '2007-08-26 00:05:03', 'AJM', '2010-07-17 14:14:58', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '18', 'Do something completely spontaneous.', NULL, '2010-07-30', '7', 'N', NULL, NULL, NULL, NULL, '2010-07-16 17:40:51', 'AJM', NULL, NULL);
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '19', 'Reassigned by: AJM', 'Please deal with this because I am too lazy.', '2010-07-19', '7', 'Y', NULL, NULL, 'py_email_msg(enq1)', 'email_id=\'24\'', '2010-07-18 09:00:19', 'AJM', '2010-10-14 14:25:59', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '20', 'Reassigned by: AJM', NULL, '2010-10-19', '7', 'Y', NULL, NULL, 'py_email_msg(enq1)', 'email_id=\'23\'', '2010-10-18 20:54:36', 'AJM', '2010-11-13 08:19:05', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '21', 'Reassigned by: AJM', NULL, '2010-11-14', '7', 'Y', NULL, NULL, 'py_email_msg(enq1)', 'email_id=\'148\'', '2010-11-13 08:18:38', 'AJM', '2010-11-13 08:19:32', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '22', 'Reassigned by JS', NULL, '2010-11-15', '7', 'Y', NULL, NULL, 'py_email_msg(enq1)', 'email_id=\'28\'', '2000-01-01 00:00:00', 'UNKNOWN', '2010-11-14 17:55:26', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '23', 'test february 2013', 'test february 2013', '2013-02-14', '7', 'N', NULL, NULL, NULL, NULL, '2013-02-09 10:29:06', 'AJM', NULL, NULL);

REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_desc`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '1', 'mnu_user(upd1)a', 'Change Password', '1', NULL, '2010-07-31 14:51:16', 'AJM', NULL, NULL);
REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_desc`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '2', 'mnu_todo(list2)', 'To-Do', '2', NULL, '2010-07-31 14:51:17', 'AJM', NULL, NULL);
REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_desc`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '3', 'mnu_motd(list1)', 'MOTD', '3', NULL, '2010-07-31 14:51:17', 'AJM', NULL, NULL);
REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_desc`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '4', 'py_email_signature(list1)', 'List Email Signature', '4', NULL, '2010-10-01 15:50:53', 'AJM', NULL, NULL);
REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_desc`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('AJM', '5', 'py_person(list1)', 'List Person', '5', 'current_menu=party&main_menu[button_text]=Home&main_menu[script_id]=/menu/menu.php&applications[button_text]=Transix&applications[script_id]=/menu/menu.php&party[button_text]=PARTY&party[script_id]=/menu/menu.php&py_person(list1)[button_text]=Person&py_person(list1)[script_id]=/party/person(list1).php', '2010-12-29 14:42:39', 'AJM', NULL, NULL);

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `role_id`, `rdcaccount_id`, `pswd_chg_date`, `pswd_chg_time`, `pswd_count`, `in_use`, `is_disabled`, `logon_date`, `logon_time`, `language_code`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'Batch (background) processing', 'K}_$nQDAm9U}2s$+', 'BATCH', NULL, '2010-04-13', '11:53:52', '0', 'N', 'N', NULL, NULL, NULL, '2010-04-13', '9999-12-31', NULL, NULL, NULL, 'N', NULL, 'Europe/London', '2010-04-13 11:53:52', 'AJM', '2010-04-13 11:55:29', 'AJM');

REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'py_scan_email_inbox(batch)', 'MAILBOX', '{pop3.demon.co.uk:110/pop3}INBOX', 'N', '2010-04-13 12:02:25', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'py_scan_email_inbox(batch)', 'PASSWORD', 'yr332058b', 'N', '2010-04-13 12:02:26', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('BATCH', 'py_scan_email_inbox(batch)', 'USERNAME', 'customer.service+marston-home', 'N', '2010-04-13 12:02:27', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('batch', 'ord_order_item_s(upd4)ring-gauge', 'SUBJECT', 'moonstar_print_job', 'N', '2008-05-30 17:14:14', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('batch', 'ord_order_item_s(upd4)ring-gauge', '_FORMAT', 'slimbrand.lbl', 'N', '2008-05-30 14:38:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('batch', 'ord_order_item_s(upd4)ring-gauge', '_JOBNAME', 'ord_order_item_s(upd4)ring-gauge', 'N', '2008-05-30 14:38:57', 'AJM', '2011-08-06 14:21:00', 'AJM');
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('batch', 'ord_order_item_s(upd4)ring-gauge', '_QUANTITY', '1', 'N', '2008-05-30 14:38:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('batch', 'ord_order_item_s(upd4)ring-gauge', 'SALE_TYPE_ID', '*', 'N', '2009-08-06 17:29:34', 'AJM', '2009-08-11 11:41:28', 'AJM');
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('batch', 'ord_order_item_s(upd4)ring-gauge', '_PRINTERNAME', 'moonstar', 'N', '2008-05-30 14:38:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('batch', 'ord_order_item_s(upd4)ring-gauge', 'PRINTER_ADDRESS', 'moonstar@weddingringsdirect.com', 'N', '2008-05-30 14:38:58', 'AJM', NULL, NULL);
REPLACE INTO `mnu_initial_value_user` (`user_id`, `task_id`, `field_id`, `initial_value`, `is_noedit`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('batch', 'ord_order_item_s(upd4)ring-gauge', 'VALID_COUNTRIES', '1,116,212,328,210,2,335', 'N', '2009-08-06 17:48:10', 'AJM', '2011-10-12 16:06:23', 'AJM');

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `role_id`, `rdcaccount_id`, `pswd_chg_date`, `pswd_chg_time`, `pswd_count`, `in_use`, `is_disabled`, `logon_date`, `logon_time`, `language_code`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', 'Demo User', '~n:.^#l::y(@SGu!', 'DEMO', NULL, '2009-07-22', '00:49:59', '15', 'N', 'N', '2010-08-27', '14:35:17', NULL, '2003-01-01', '9999-12-31', '127.0.0.1', NULL, NULL, 'N', NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2010-08-27 14:34:13', 'DEMO');

REPLACE INTO `mnu_user_ip_address` (`user_id`, `ip_address`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', '127.0.0.1', '2009-11-16 16:16:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_user_ip_address` (`user_id`, `ip_address`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', '192.168.1.64', '2009-11-16 15:34:49', 'AJM', NULL, NULL);
REPLACE INTO `mnu_user_ip_address` (`user_id`, `ip_address`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', '192.168.1.65', '2009-11-16 15:34:57', 'AJM', NULL, NULL);

REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_desc`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', '1', 'mnu_user(upd1)a', 'Change Password', '1', NULL, '2010-08-27 14:35:24', 'DEMO', NULL, NULL);
REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_desc`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', '2', 'mnu_todo(list2)', 'To-Do', '2', NULL, '2010-08-27 14:35:25', 'DEMO', NULL, NULL);
REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_desc`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('DEMO', '3', 'mnu_motd(list1)', 'MOTD', '3', NULL, '2010-08-27 14:35:25', 'DEMO', NULL, NULL);

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `role_id`, `rdcaccount_id`, `pswd_chg_date`, `pswd_chg_time`, `pswd_count`, `in_use`, `is_disabled`, `logon_date`, `logon_time`, `language_code`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', 'Fred Bloggs', ';Rc_Gx(3~XPrAZCD', 'USER', NULL, '2006-02-01', '20:10:05', '14', 'Y', 'N', '2010-10-07', '15:49:08', NULL, '2003-01-01', '9999-12-31', '127.0.0.1', NULL, NULL, 'N', NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2010-10-07 15:48:45', 'AJM');

REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', '1', 'stuff', NULL, '2005-09-01', '7', 'Y', NULL, NULL, NULL, NULL, '2005-07-30 18:44:46', 'AJM', '2005-07-30 20:20:16', 'AJM');
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', '2', 'More Stuff', 'Just a test', '2005-08-15', '7', 'N', NULL, NULL, NULL, NULL, '2005-07-30 19:36:51', 'AJM', NULL, NULL);
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('FB', '3', 'Yet More stuff', NULL, '2005-08-01', '7', 'N', NULL, NULL, NULL, NULL, '2005-07-30 20:20:09', 'AJM', NULL, NULL);

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `role_id`, `rdcaccount_id`, `pswd_chg_date`, `pswd_chg_time`, `pswd_count`, `in_use`, `is_disabled`, `logon_date`, `logon_time`, `language_code`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('JS', 'Joe Soap', ';,SA1Qo08{(lk.Y-', 'USER', NULL, '2004-08-01', '16:50:10', '0', 'N', 'N', NULL, NULL, NULL, '2003-01-01', '9999-12-31', NULL, NULL, NULL, 'N', NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2010-10-07 15:48:55', 'AJM');

REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('JS', '1', 'Reassigned by: AJM', NULL, '2010-10-19', '7', 'N', NULL, NULL, 'py_email_msg(enq1)', 'email_id=\'23\'', '2010-10-18 20:46:44', 'AJM', NULL, NULL);
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('JS', '2', 'Reassigned by: AJM', NULL, '2010-10-19', '7', 'N', NULL, NULL, 'py_email_msg(enq1)', 'email_id=\'23\'', '2010-10-18 20:54:57', 'AJM', NULL, NULL);
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('JS', '3', 'Reassigned by: AJM', NULL, '2010-11-06', '7', 'N', NULL, NULL, 'py_email_msg(enq1)', 'email_id=\'147\'', '2010-11-05 09:55:06', 'AJM', NULL, NULL);
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('JS', '4', 'Reassigned by: AJM', NULL, '2010-11-06', '7', 'N', NULL, NULL, 'py_email_msg(enq1)', 'email_id=\'147\'', '2010-11-05 10:54:11', 'AJM', NULL, NULL);
REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('JS', '5', 'Reassigned by: AJM', 'note', '2010-11-14', '7', 'N', NULL, NULL, 'py_email_msg(enq1)', 'email_id=\'148\'', '2010-11-13 08:06:20', 'AJM', NULL, NULL);

REPLACE INTO `mnu_time_limit_user` (`user_id`, `seq_no`, `scheduled_start_time`, `scheduled_end_time`, `scheduled_monday`, `scheduled_tuesday`, `scheduled_wednesday`, `scheduled_thursday`, `scheduled_friday`, `scheduled_saturday`, `scheduled_sunday`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('JS', '1', '09:00:00', '18:00:00', '1', '1', '1', '1', '1', '0', '0', '2013-08-19 15:25:49', 'AJM', NULL, NULL);

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `role_id`, `rdcaccount_id`, `pswd_chg_date`, `pswd_chg_time`, `pswd_count`, `in_use`, `is_disabled`, `logon_date`, `logon_time`, `language_code`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MANAGER', 'Manager', 'Y3YP&CWh;HW`+5N`', 'GLOBAL', NULL, '2004-08-01', '16:50:42', '0', 'N', 'N', NULL, NULL, NULL, '2003-01-01', '9999-12-31', NULL, NULL, NULL, 'N', NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2005-11-02 18:05:54', 'AJM');

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `role_id`, `rdcaccount_id`, `pswd_chg_date`, `pswd_chg_time`, `pswd_count`, `in_use`, `is_disabled`, `logon_date`, `logon_time`, `language_code`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('MGR', 'MGR', 'Nz-3jN6+lK@Ii^DE', 'GLOBAL', NULL, '2004-08-01', '16:51:04', '11', 'Y', 'N', '2011-06-11', '10:32:15', NULL, '2003-01-01', '9999-12-31', '127.0.0.1', NULL, NULL, 'N', NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2005-11-02 18:05:54', 'AJM');

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `role_id`, `rdcaccount_id`, `pswd_chg_date`, `pswd_chg_time`, `pswd_count`, `in_use`, `is_disabled`, `logon_date`, `logon_time`, `language_code`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('READONLY', 'Read Only', 'QRDpjDD7=%1(X?zx', 'READONLY', NULL, '2004-08-01', '16:51:51', '0', 'N', 'N', '2003-09-23', '14:11:52', NULL, '2003-01-01', '9999-12-31', NULL, NULL, NULL, 'N', NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2005-11-02 18:05:54', 'AJM');

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `role_id`, `rdcaccount_id`, `pswd_chg_date`, `pswd_chg_time`, `pswd_count`, `in_use`, `is_disabled`, `logon_date`, `logon_time`, `language_code`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SLIMBRAND', 'Slimbrand', 'b@9XSrH/E<fMpIiY', 'SUPPLIER', NULL, '2011-02-08', '17:46:08', '5', 'Y', 'N', '2013-01-19', '17:51:25', NULL, '2011-02-08', '9999-12-31', '127.0.0.1', NULL, NULL, 'Y', '64', 'Europe/London', '2011-02-08 17:46:08', 'AJM', NULL, NULL);

REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_desc`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SLIMBRAND', '1', 'mnu_user(upd1)a', 'Change Password', '1', NULL, '2011-02-08 17:46:10', 'AJM', NULL, NULL);
REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_desc`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SLIMBRAND', '2', 'mnu_todo(list2)', 'To-Do', '2', NULL, '2011-02-08 17:46:11', 'AJM', NULL, NULL);
REPLACE INTO `mnu_favourite` (`user_id`, `seq_no`, `task_id`, `task_desc`, `sort_seq`, `breadcrumbs`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SLIMBRAND', '3', 'mnu_motd(list1)', 'MOTD', '3', NULL, '2011-02-08 17:46:11', 'AJM', NULL, NULL);

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `role_id`, `rdcaccount_id`, `pswd_chg_date`, `pswd_chg_time`, `pswd_count`, `in_use`, `is_disabled`, `logon_date`, `logon_time`, `language_code`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('SURVEY', 'SURVEY (supervisor)', '+wwjJMgFAuJ(1$qS', 'SURVEY', NULL, '2004-08-01', '16:52:09', '0', 'N', 'N', '2003-10-09', '19:24:40', NULL, '2003-01-01', '9999-12-31', NULL, NULL, NULL, 'N', NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2005-11-02 18:05:54', 'AJM');

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `role_id`, `rdcaccount_id`, `pswd_chg_date`, `pswd_chg_time`, `pswd_count`, `in_use`, `is_disabled`, `logon_date`, `logon_time`, `language_code`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('TEST', 'test', 'vknmgJDBm cA*ZcF', 'GLOBAL', NULL, '2010-06-30', '11:51:56', '0', 'Y', 'N', '2010-06-30', '11:51:12', NULL, '2010-06-30', '9999-12-31', '127.0.0.1', NULL, NULL, 'N', NULL, 'US/Central', '2010-06-30 11:50:43', 'AJM', '2010-06-30 11:51:56', 'TEST');

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `role_id`, `rdcaccount_id`, `pswd_chg_date`, `pswd_chg_time`, `pswd_count`, `in_use`, `is_disabled`, `logon_date`, `logon_time`, `language_code`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER1', 'user1', '$Y/R7/=t8_W98TI(', 'USER1', NULL, '2005-07-31', '15:10:17', '3', 'N', 'N', '2011-07-22', '14:10:24', NULL, '2005-07-31', '9999-12-31', '127.0.0.1', NULL, NULL, 'N', NULL, NULL, '2005-07-31 15:10:17', 'AJM', '2005-11-02 18:05:54', 'AJM');

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `role_id`, `rdcaccount_id`, `pswd_chg_date`, `pswd_chg_time`, `pswd_count`, `in_use`, `is_disabled`, `logon_date`, `logon_time`, `language_code`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER2', 'user2', '$Y/R7uD,DS=6R,a?', 'USER2', NULL, '2005-07-31', '15:10:32', '1', 'N', 'N', '2005-07-31', '15:11:06', NULL, '2005-07-31', '9999-12-31', NULL, NULL, NULL, 'N', NULL, NULL, '2005-07-31 15:10:32', 'AJM', '2005-11-02 18:05:54', 'AJM');

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `role_id`, `rdcaccount_id`, `pswd_chg_date`, `pswd_chg_time`, `pswd_count`, `in_use`, `is_disabled`, `logon_date`, `logon_time`, `language_code`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('USER3', 'user3', '$Y/R75pZ~Uy#iyF=', 'USER3', NULL, '2005-07-31', '15:10:45', '1', 'N', 'N', '2005-07-31', '15:12:38', NULL, '2005-07-31', '9999-12-31', NULL, NULL, NULL, 'N', NULL, NULL, '2005-07-31 15:10:45', 'AJM', '2005-11-02 18:05:54', 'AJM');

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `role_id`, `rdcaccount_id`, `pswd_chg_date`, `pswd_chg_time`, `pswd_count`, `in_use`, `is_disabled`, `logon_date`, `logon_time`, `language_code`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('VPD1', 'VPD1', 'v5qi.M-z]%RE08Ut', 'GLOBAL', '1', '2009-07-11', '09:54:33', '0', 'Y', 'N', NULL, NULL, NULL, '2009-07-10', '9999-12-31', NULL, NULL, NULL, 'N', NULL, 'Europe/London', '2009-07-10 13:34:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `role_id`, `rdcaccount_id`, `pswd_chg_date`, `pswd_chg_time`, `pswd_count`, `in_use`, `is_disabled`, `logon_date`, `logon_time`, `language_code`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('VPD2', 'VPD2', 'v5qiJNNw6EpwgUxn', 'GLOBAL', '2', '2009-07-11', '10:30:36', '10', 'Y', 'N', '2012-07-12', '21:12:41', NULL, '2009-07-10', '9999-12-31', '127.0.0.1', NULL, NULL, 'N', NULL, 'Europe/London', '2009-07-10 13:35:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `role_id`, `rdcaccount_id`, `pswd_chg_date`, `pswd_chg_time`, `pswd_count`, `in_use`, `is_disabled`, `logon_date`, `logon_time`, `language_code`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('VPD2A', 'VPD2a', '$nKyd39nT%mzlq=_', 'DEMO', '2', '2009-07-14', '10:43:11', '0', 'N', 'N', NULL, NULL, NULL, '2009-07-14', '9999-12-31', NULL, NULL, NULL, 'N', NULL, 'Europe/London', '2009-07-14 10:43:11', 'VPD2', '2012-07-12 21:13:18', 'VPD2');

REPLACE INTO `mnu_user` (`user_id`, `user_name`, `user_password`, `role_id`, `rdcaccount_id`, `pswd_chg_date`, `pswd_chg_time`, `pswd_count`, `in_use`, `is_disabled`, `logon_date`, `logon_time`, `language_code`, `start_date`, `end_date`, `ip_address`, `email_addr`, `external_id`, `is_external_auth_off`, `party_id`, `user_timezone`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES ('VPD3', 'VPD3', 'v5q$5MC3+7!21QvP', 'GLOBAL', '3', '2009-07-14', '10:41:32', '1', 'Y', 'N', '2009-08-17', '13:29:56', NULL, '2009-07-14', '9999-12-31', '127.0.0.1', NULL, NULL, 'N', NULL, 'Europe/London', '2009-07-14 10:41:32', 'AJM', NULL, NULL);

-- finished
