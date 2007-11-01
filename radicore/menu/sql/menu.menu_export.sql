-- file created on October 13, 2007, 3:30 pm
    
REPLACE INTO `mnu_pattern` (`pattern_id`, `pattern_desc`, `pattern_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('ADD1', 'ADD1 - Insert a single record', 'This will allow the user to add a single record to a database table.

This will call the \'insertRecord\' method just once.', 'Y', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:38:46', 'AJM'),
('ADD2', 'ADD2 - Insert a single record', 'This will add an occurrence to the MANY entity in a ONE-to-MANY relationship with the primary key of the ONE entity being passed down from the previous screen.

This will call the \'insertRecord\' method just once.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:38:59', 'AJM'),
('ADD3', 'ADD3 - Insert multiple records without user dialog', 'This will add records to the database without any dialog with the user.

It will use the primary key supplied by the previous screen and one or more primary keys selected in a popup screen which will be called next.

This uses repeated calls to the \'insertRecord\' method.', 'N', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:39:10', 'AJM'),
('ADD4', 'ADD4 - Insert one or more records without user dialog', 'This will allow one or more database records to be created without any dialog with the user.

Details of the parent table are passed down in $where.

This will use the \'insertMultiple\' method.', 'N', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-10 22:33:14', 'AJM'),
('DEL1', 'DEL1 - Delete a single record', 'This will delete a single record from the database using the primary key passed down by the previous screen.

This will call the \'deleteRecord\' method.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:39:45', 'AJM'),
('DEL2', 'DEL2 - Delete multiple records without user dialog', 'This will delete multiple records one at a time using the primary keys passed down from the previous screen.

This uses the \'deleteMultiple\' method.', 'N', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-10-01 16:56:16', 'AJM'),
('DEL3', 'DEL3 - Delete multiple records without user dialog', 'This will call the \'deleteSelection\' method to delete/update a selection of records using the primary keys passed down from the previous screen.', 'N', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-09-08 11:58:29', 'AJM'),
('DEL4', 'DEL4 - Delete parent and children', 'This will allow the user to delete a single record from the parent table, plus all related occurrences from the child table.

The primary key(s) for the occurrence(s) on the parent table is passed down by the previous screen.

This will call the \'deleteRecord\' method.', 'Y', 'Y', 'N', '2006-03-11 14:28:33', 'AJM', NULL, NULL),
('ENQ1', 'ENQ1 - Enquire a single record', 'This will read a single record from the database using the primary key passed down by the previous screen and display it to the user.

If multiple rows are selected then scrolling options will be provided.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:56:48', 'AJM'),
('ERASE1', 'ERASE1 - Delete a record and all child records', 'This will delete a single record from the database using the primary key passed down by the previous screen. It will also delete *ALL* related occurrences on child tables.

This will call the \'eraseRecord\' method.', 'Y', 'Y', 'N', '2005-12-06 17:40:51', 'AJM', NULL, NULL),
('FILEDOWNLOAD', 'FILEDOWNLOAD - File Download', 'This will allow the user to download a file from the server to the client. The user selects an entity which contains the name of the file to be downloaded, then activates this transaction by pressing a navigation button.', 'N', 'Y', 'N', '2006-07-26 17:01:40', 'AJM', NULL, NULL),
('FILEPICKER', 'FILEPICKER - File Picker', 'This will allow the user to select the name of a file.', 'Y', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:40:44', 'AJM'),
('FILEUPLOAD', 'FILEUPLOAD - File Upload', 'This will allow the user to upload a file from the client to the server. The file can be limited to a range of file types and a maximum size.', 'Y', 'N', 'N', '2005-12-18 14:50:32', 'AJM', NULL, NULL),
('LINK1', 'LINK1 - Update LINK table', 'This deals with a ONE-to-MANY-to-ONE relationship where MANY indicates a yes/no link between both of the ONE tables.

This allows multiple occurrences of MANY to be created, modified or deleted in a single screen.

This will call the \'updateLinkData\' method.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('LIST1', 'LIST1 - List multiple records', 'This will list all available rows from a database table one page at a time with (usually) 10 rows in each page.

Links at the bottom of the page will allow the user to jump to the first/last/previous/next page.

The selection may be refined by using the SEARCH button. This will bring up another screen into which selection criteria can be entered.', 'Y', 'N', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:57:00', 'AJM'),
('LIST2', 'LIST2 - List multiple children', 'This will list rows of MANY in a ONE-to-MANY relationship one page at a time with (usually) 10 rows in each page.

The primary key of ONE will be passed down from the previous screen.

Links at the bottom of the page will allow the user to jump to the first/last/previous/next page.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2007-03-20 18:00:48', 'AJM'),
('LIST3', 'LIST3 - List multiple children', 'This will list rows of MANY(1) and MANY(2) in a ONE-to-MANY(1)-to-MANY(2) relationship.

MANY(1)-to-MANY(2) is another ONE-to-MANY relationship

The primary key of ONE will be passed down from the previous screen.

This will then be passed to MANY(1) for processing.

The primary key of MANY(1) will then be passed to MANY(2) for processing.

Links at the bottom of the page will allow the user to jump to the first/last/previous/next page.', 'Y', 'Y', 'N', '2005-06-22 23:17:59', 'AJM', '2007-04-09 13:47:05', 'AJM'),
('MENU', 'MENU - Display menu options', 'This will display a list of options and allow the user to select one.', 'Y', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:57:21', 'AJM'),
('MULTI1', 'MULTI1 - Update/Insert/delete multiple records', 'This will take a selection of primary keys and allow individual databases rows to be inserted, updated or deleted.

The identity of the row(s) to be processed is passed down from the previous screen, and scrolling between rows is controlled by the setScrollArray() and getScrollItem() methods

This will deal with one row at a time and will call either the \'insertRecord\', \'updateRecord\' or \'deleteRecord\' methods as appropriate.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2005-06-24 23:20:22', 'AJM'),
('MULTI2', 'MULTI2 - Modify multiple records in a 2-level hierarchy', 'This will allow multiple MANY occurrences in a ONE-to-MANY relationship to be modified in a single operation. 

The primary key of ONE is passed down from the previous screen.

This will call the \'updateMultiple\' method.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2005-06-24 23:31:18', 'AJM'),
('MULTI3', 'MULTI3 - Modify multiple records in a 3-level hierarchy', 'This will allow updates to multiple occurrences of the CHILD table in a GRANDPARENT-PARENT-CHILD relationship n a single operation. 

The primary key of GRANDPARENT is passed down from the previous screen.

Occurrences of PARENT will start at the first available, with a scrolling area providing hyperlinks/buttons to step forwards or backwards through the available occurrences.

Occurrences of CHILD will start at the first available page, with a pagination area providing hyperlinks/buttons to step forwards or backwards through the available occurrences.

This will call the \'updateMultiple\' method for the CHILD entity.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2005-06-24 23:31:30', 'AJM'),
('MULTI4', 'MULTI4 - Update both in a ONE-to-MANY relationship', 'This will allow multiple MANY occurrences in a ONE-to-MANY relationship to be modified in a single operation. 

The primary key of ONE is passed down from the previous screen.

This will call the \'updateMultiple\' method.', 'Y', 'Y', 'N', '2005-06-24 23:25:47', 'AJM', '2006-10-07 19:01:30', 'AJM'),
('OTHER', 'Other - Miscellaneous - Undefined', 'This is for anything whch does not fall into any recognisable category.', 'N', 'N', 'N', '2007-01-10 18:21:02', 'AJM', NULL, NULL),
('OUTPUT1', 'OUTPUT1 - Output records to a CSV file', 'This will extract all available rows from a database table and output them to a CSV file which will be downloaded to the client device.

It will use any search criteria that is passed down from the calling screen.', 'N', 'N', 'N', '2006-08-11 16:49:59', 'AJM', '2006-08-11 17:01:35', 'AJM'),
('OUTPUT2', 'OUTPUT2 - Output records to a PDF file (List view)', 'This will extract all available rows from a database table and output them to a PDF file which will be downloaded to the client device.

It will use any search criteria that is passed down from the calling screen.

List view produces column headings on the top of the page, with each database record taking up one line across the page.', 'N', 'N', 'N', '2006-08-13 11:11:04', 'AJM', '2006-08-16 22:29:20', 'AJM'),
('OUTPUT3', 'OUTPUT3 - Output records to a PDF file (Detail view)', 'This will extract all available rows from a database table and output them to a PDF file which will be downloaded to the client device.

It will use any search criteria that is passed down from the calling screen.

Detail view produces one page per database record, one line per field, with labels on the left and values on the right.', 'N', 'N', 'N', '2006-08-14 13:30:18', 'AJM', NULL, NULL),
('POPUP1', 'POPUP1 - Choose records (uses LIST1)', 'This shows the user a list of available rows from a database table and allows the user to choose one (or more) for processing in the previous screen.

This uses the LIST1 pattern.', 'Y', 'N', 'Y', '2006-10-06 13:07:29', 'AJM', '2006-10-06 13:12:02', 'AJM'),
('POPUP2', 'POPUP2 - Choose records (uses LIST2)', 'This shows the user a list of available rows from a database table and allows the user to choose one (or more) for processing in the previous screen.

This uses the LIST2 pattern.', 'Y', 'N', 'Y', '2006-10-06 13:08:16', 'AJM', '2006-10-06 13:12:05', 'AJM'),
('POPUP3', 'POPUP3 - Choose records (uses TREE1)', 'This shows the user a list of available rows from a database table and allows the user to choose one (or more) for processing in the previous screen.

This uses the TREE1 pattern.', 'Y', 'N', 'Y', '2006-10-06 13:10:16', 'AJM', '2006-10-06 13:12:08', 'AJM'),
('POPUP4', 'POPUP4 - Choose records (uses TREE2)', 'This shows the user a list of available rows from a database table and allows the user to choose one (or more) for processing in the previous screen.

This uses the TREE2 pattern.', 'Y', 'N', 'Y', '2006-10-06 13:10:45', 'AJM', '2006-10-06 13:12:11', 'AJM'),
('SRCH', 'SRCH - Enter selection criteria', 'This will show a blank detail screen and allow the user to specify search criteria that will then be returned to the previous screen for action.', 'Y', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2005-11-27 17:05:50', 'AJM'),
('TIMETABLE1', 'TIMETABLE1 - List timetable for a selected entity', 'This will list rows of TIMETABLE/SCHEDUILE table for a selected entity. It will show the schedule for every day in the week.

The primary key of selected entity will be passed down from the previous screen.

Links at the bottom of the page will allow the user to jump to the first/last/previous/next page.', 'Y', 'Y', 'N', '2006-07-10 21:35:00', 'AJM', NULL, NULL),
('TREE1', 'TREE1 - List Tree Structure (fixed)', 'This will list nodes in a tree structure and allow the user to expand and contract nodes individually.

This uses a stand-alone TREE_NODE table.

This uses the \'getNodeData\' method to retrieve the data for the selected nodes.', 'Y', 'Y', 'Y', '2003-01-01 12:00:00', 'AJM', '2005-12-26 12:29:52', 'AJM'),
('TREE2', 'TREE2 - List Tree Structure (flexible)', 'This will list nodes in a tree structure and allow the user to expand and contract nodes individually.

This uses the TREE_TYPE, TREE_LEVEL and TREE_NODE database tables so that different levels can be defined for different tree types.

The TREE_TYPE to be displayed will be passed down by the previous screen.

This uses the \'getNodeData\' method to retrieve the data for the selected nodes.', 'Y', 'Y', 'Y', '2003-01-01 12:00:00', 'AJM', '2006-10-30 15:44:55', 'AJM'),
('UPD1', 'UPD1 - Update a single record', 'This will allow a single database record (row) to be displayed and updated.

The primary key of the row is passed down from the previous screen. If multiple rows are selected then scrolling options will be provided.

This will call the \'updateRecord\' method.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:43:21', 'AJM'),
('UPD2', 'UPD2 - Update multiple records', 'This will update multiple rows in the database.

The rows are identified using a combination of values supplied by the previous screen plus values selected in a popup screen which will be called next.

This will call the \'updateSelection\' method.', 'N', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2007-04-15 15:18:45', 'AJM'),
('UPD3', 'UPD3 - Update Control record', 'This will update multiple rows in a \'control\' table in the database.

Each row contains a \'field_id\' and a \'field_value\' column, and they are treated as searate fields from a sigle row. This design allows \'fields\' (rows) to be added or deleted at will without having to alter the structure of the table.

This will call the \'updateSelection\' method.', 'Y', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-28 11:56:43', 'AJM'),
('UPD4', 'UPD4 - Update one or more records without user dialog', 'This will allow one or more database rows to be updated without being displayed.

The identity of the row(s) to be updated is passed down from the previous screen.

This will call the \'updateMultiple\' method.', 'N', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-28 12:37:18', 'AJM'),
('UPD5', 'UPD5 - Insert/Update one or more records without user dialog', 'This will allow one or more database rows to be inserted or updated without being displayed.

The identity of the row(s) to be processed is passed down from the previous screen so that they can be assembled.

This will call the \'insertOrUpdate\' method which will check if each record currently exists, then insert or update as appropriate.', 'N', 'Y', 'N', '2007-04-15 15:33:17', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('ADMIN', 'Logistics Administrator', 'main_menu', 'N', '2005-11-18 11:17:09', 'RNP', NULL, NULL),
('DEMO', 'Demonstration Class', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('DEV', 'Development', 'main_menu', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('GLOBAL', 'Global Access', 'main_menu', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('LOGISTICS ADMIN', 'Logistics Administrator', 'main_menu', 'N', '2005-11-11 11:41:17', 'RNP', '2005-11-11 12:48:31', 'RNP'),
('READONLY', 'Read Only', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'SURVEY (supervisor)', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER', 'Ordinary everyday User', 'main_menu', 'N', '2006-09-05 13:31:49', 'AJM', NULL, NULL),
('USER1', 'User Class 1', 'proto', 'N', '2003-01-01 12:00:00', 'AJM', '2005-07-31 14:59:56', 'AJM'),
('USER2', 'User Class 2', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER3', 'User Class 3', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_subsystem` (`subsys_id`, `subsys_desc`, `subsys_dir`, `task_prefix`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('MENU', 'Menu and Security system', 'menu', 'mnu_', '2003-01-01 12:00:00', 'AJM', '2006-04-22 09:39:02', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('logon', 'Logon screen', 'Logon', 'PROC', 'logon.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'Y', '2005-07-20 15:00:06', 'AJM', '2006-03-12 12:11:11', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'logon', '2006-04-07 17:31:01', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('menu', 'Home Page', 'Home', 'PROC', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'Y', NULL, NULL, 'N', '2004-08-18 12:19:08', 'AJM', '2004-08-18 12:42:24', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('menu', 'mnu_todo(list2)', '001', 'ToDo', 'N', '2005-07-31 15:35:03', 'AJM', '2007-09-10 15:12:37', 'AJM'),
('menu', 'mnu_user(upd1)a', '002', 'Change Password', 'N', '2006-02-23 10:51:20', 'AJM', '2007-09-10 15:35:45', 'AJM'),
('menu', 'audit_logon_errors(list)', '003', 'Logon Errors', 'N', '2006-03-08 14:52:45', 'AJM', NULL, NULL),
('menu', 'mnu_session(upd3)', '004', 'Session Data', 'N', '2006-04-06 19:39:09', 'AJM', '2007-09-10 11:53:31', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'menu', '2004-10-08 16:07:50', 'AJM', NULL, NULL),
('READONLY', 'menu', '2004-10-08 16:12:31', 'AJM', NULL, NULL),
('SURVEY', 'menu', '2004-10-08 16:12:31', 'AJM', NULL, NULL),
('USER1', 'menu', '2004-10-08 16:12:31', 'AJM', NULL, NULL),
('USER2', 'menu', '2004-10-08 16:12:31', 'AJM', NULL, NULL),
('USER3', 'menu', '2004-10-08 16:12:31', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_account(add1)', 'Add Hosting Account', 'New', 'PROC', 'mnu_account(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2007-09-13 11:30:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_account(list1)', 'mnu_account(add1)', '001', 'New', 'N', '2007-09-13 11:30:43', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_account(del1)', 'Delete Hosting Account', 'Delete', 'PROC', 'mnu_account(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2007-09-13 11:30:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_account(list1)', 'mnu_account(del1)', '004', 'Delete', 'Y', '2007-09-13 11:30:43', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_account(enq1)', 'Enquire Hosting Account', 'Read', 'PROC', 'mnu_account(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2007-09-13 11:30:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_account(list1)', 'mnu_account(enq1)', '002', 'Read', 'Y', '2007-09-13 11:30:43', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_account(list1)', 'List Hosting Account', 'Hosting Account', 'PROC', 'mnu_account(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2007-09-13 11:30:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_account(list1)', 'mnu_account(add1)', '001', 'New', 'N', '2007-09-13 11:30:43', 'AJM', NULL, NULL),
('mnu_account(list1)', 'mnu_account(enq1)', '002', 'Read', 'Y', '2007-09-13 11:30:43', 'AJM', NULL, NULL),
('mnu_account(list1)', 'mnu_account(upd1)', '003', 'Update', 'Y', '2007-09-13 11:30:43', 'AJM', NULL, NULL),
('mnu_account(list1)', 'mnu_account(del1)', '004', 'Delete', 'Y', '2007-09-13 11:30:43', 'AJM', NULL, NULL),
('mnu_account(list1)', 'mnu_account(search)', '005', 'Search', 'N', '2007-09-13 11:30:43', 'AJM', NULL, NULL),
('mnu_account(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2007-09-13 11:30:43', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_account(search)', 'Search Hosting Account', 'Search', 'PROC', 'mnu_account(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2007-09-13 11:30:43', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_account(list1)', 'mnu_account(search)', '005', 'Search', 'N', '2007-09-13 11:30:43', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_account(upd1)', 'Update Hosting Account', 'Update', 'PROC', 'mnu_account(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2007-09-13 11:30:42', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_account(list1)', 'mnu_account(upd1)', '003', 'Update', 'Y', '2007-09-13 11:30:43', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_control(upd3)', 'Maintain Menu Controls', 'Menu Controls', 'PROC', 'mnu_control(upd3).php', 'N', 'UPD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 10:44:38', 'AJM');

REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_control(upd3)', 'DEFAULT_LANGUAGE', '2006-04-10 09:36:18', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('mnu_control(upd3)', 'PSWD_CHANGE', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('mnu_control(upd3)', 'PSWD_COUNT', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('mnu_control(upd3)', 'PSWD_DAYS', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('mnu_control(upd3)', 'PSWD_ENCRYPT', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('mnu_control(upd3)', 'PSWD_FORMAT_DIGITS', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('mnu_control(upd3)', 'PSWD_FORMAT_LOWER', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('mnu_control(upd3)', 'PSWD_FORMAT_MINLEN', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('mnu_control(upd3)', 'PSWD_FORMAT_UPPER', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('mnu_control(upd3)', 'PSWD_HIDDEN', '2006-07-18 18:27:46', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('mnu_control(upd3)', 'PSWD_RETRIES', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('mnu_control(upd3)', 'PSWD_WARNING', '2006-04-10 09:36:40', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('mnu_control(upd3)', 'SHUTDOWN_END', '2006-04-17 09:30:12', 'AJM', '2007-09-10 10:44:38', 'AJM'),
('mnu_control(upd3)', 'SHUTDOWN_FRIDAY', '2006-04-17 09:30:58', 'AJM', '2007-09-10 10:44:38', 'AJM'),
('mnu_control(upd3)', 'SHUTDOWN_MONDAY', '2006-04-17 09:30:27', 'AJM', '2007-09-10 10:44:38', 'AJM'),
('mnu_control(upd3)', 'SHUTDOWN_SATURDAY', '2006-04-17 09:31:05', 'AJM', '2007-09-10 10:44:38', 'AJM'),
('mnu_control(upd3)', 'SHUTDOWN_START', '2006-04-17 09:30:06', 'AJM', '2007-09-10 10:44:38', 'AJM'),
('mnu_control(upd3)', 'SHUTDOWN_SUNDAY', '2006-04-17 09:31:11', 'AJM', '2007-09-10 10:44:38', 'AJM'),
('mnu_control(upd3)', 'SHUTDOWN_THURSDAY', '2006-04-17 09:30:51', 'AJM', '2007-09-10 10:44:38', 'AJM'),
('mnu_control(upd3)', 'SHUTDOWN_TUESDAY', '2006-04-17 09:30:35', 'AJM', '2007-09-10 10:44:38', 'AJM'),
('mnu_control(upd3)', 'SHUTDOWN_WARNING', '2006-04-17 09:30:20', 'AJM', '2007-09-10 10:44:38', 'AJM'),
('mnu_control(upd3)', 'SHUTDOWN_WEDNESDAY', '2006-04-17 09:30:44', 'AJM', '2007-09-10 10:44:38', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_control(upd3)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:32', 'AJM'),
('READONLY', 'mnu_control(upd3)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:32', 'AJM');

REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_control(upd3)', 'DEFAULT_LANGUAGE', 'NED', '2006-04-11 16:56:03', 'AJM', '2007-09-10 10:44:32', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'DEFAULT_LANGUAGE', 'NED', '2006-04-11 16:55:37', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('USER1', 'mnu_control(upd3)', 'DEFAULT_LANGUAGE', 'NED', '2006-04-17 09:33:54', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER2', 'mnu_control(upd3)', 'DEFAULT_LANGUAGE', 'NED', '2006-04-17 09:34:29', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER3', 'mnu_control(upd3)', 'DEFAULT_LANGUAGE', 'NED', '2006-04-17 09:35:04', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'PSWD_CHANGE', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:32', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'PSWD_CHANGE', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('SURVEY', 'mnu_control(upd3)', 'PSWD_CHANGE', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER1', 'mnu_control(upd3)', 'PSWD_CHANGE', 'NED', '2006-04-17 09:33:54', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER2', 'mnu_control(upd3)', 'PSWD_CHANGE', 'NED', '2006-04-17 09:34:29', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER3', 'mnu_control(upd3)', 'PSWD_CHANGE', 'NED', '2006-04-17 09:35:04', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'PSWD_COUNT', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:32', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'PSWD_COUNT', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('SURVEY', 'mnu_control(upd3)', 'PSWD_COUNT', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER1', 'mnu_control(upd3)', 'PSWD_COUNT', 'NED', '2006-04-17 09:33:54', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER2', 'mnu_control(upd3)', 'PSWD_COUNT', 'NED', '2006-04-17 09:34:29', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER3', 'mnu_control(upd3)', 'PSWD_COUNT', 'NED', '2006-04-17 09:35:04', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'PSWD_DAYS', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:32', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'PSWD_DAYS', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('SURVEY', 'mnu_control(upd3)', 'PSWD_DAYS', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER1', 'mnu_control(upd3)', 'PSWD_DAYS', 'NED', '2006-04-17 09:33:54', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER2', 'mnu_control(upd3)', 'PSWD_DAYS', 'NED', '2006-04-17 09:34:30', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER3', 'mnu_control(upd3)', 'PSWD_DAYS', 'NED', '2006-04-17 09:35:04', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'PSWD_ENCRYPT', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:32', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'PSWD_ENCRYPT', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('SURVEY', 'mnu_control(upd3)', 'PSWD_ENCRYPT', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER1', 'mnu_control(upd3)', 'PSWD_ENCRYPT', 'NED', '2006-04-17 09:33:54', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER2', 'mnu_control(upd3)', 'PSWD_ENCRYPT', 'NED', '2006-04-17 09:34:30', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER3', 'mnu_control(upd3)', 'PSWD_ENCRYPT', 'NED', '2006-04-17 09:35:04', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'PSWD_FORMAT_DIGITS', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:32', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'PSWD_FORMAT_DIGITS', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('SURVEY', 'mnu_control(upd3)', 'PSWD_FORMAT_DIGITS', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER1', 'mnu_control(upd3)', 'PSWD_FORMAT_DIGITS', 'NED', '2006-04-17 09:33:54', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER2', 'mnu_control(upd3)', 'PSWD_FORMAT_DIGITS', 'NED', '2006-04-17 09:34:30', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER3', 'mnu_control(upd3)', 'PSWD_FORMAT_DIGITS', 'NED', '2006-04-17 09:35:04', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'PSWD_FORMAT_LOWER', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:32', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'PSWD_FORMAT_LOWER', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('SURVEY', 'mnu_control(upd3)', 'PSWD_FORMAT_LOWER', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER1', 'mnu_control(upd3)', 'PSWD_FORMAT_LOWER', 'NED', '2006-04-17 09:33:54', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER2', 'mnu_control(upd3)', 'PSWD_FORMAT_LOWER', 'NED', '2006-04-17 09:34:30', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER3', 'mnu_control(upd3)', 'PSWD_FORMAT_LOWER', 'NED', '2006-04-17 09:35:04', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'PSWD_FORMAT_MINLEN', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:32', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'PSWD_FORMAT_MINLEN', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('SURVEY', 'mnu_control(upd3)', 'PSWD_FORMAT_MINLEN', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER1', 'mnu_control(upd3)', 'PSWD_FORMAT_MINLEN', 'NED', '2006-04-17 09:33:54', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER2', 'mnu_control(upd3)', 'PSWD_FORMAT_MINLEN', 'NED', '2006-04-17 09:34:30', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER3', 'mnu_control(upd3)', 'PSWD_FORMAT_MINLEN', 'NED', '2006-04-17 09:35:04', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'PSWD_FORMAT_UPPER', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:32', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'PSWD_FORMAT_UPPER', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('SURVEY', 'mnu_control(upd3)', 'PSWD_FORMAT_UPPER', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER1', 'mnu_control(upd3)', 'PSWD_FORMAT_UPPER', 'NED', '2006-04-17 09:33:54', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER2', 'mnu_control(upd3)', 'PSWD_FORMAT_UPPER', 'NED', '2006-04-17 09:34:30', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER3', 'mnu_control(upd3)', 'PSWD_FORMAT_UPPER', 'NED', '2006-04-17 09:35:04', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'PSWD_HIDDEN', 'NED', '2006-07-18 18:28:05', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'PSWD_RETRIES', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'PSWD_RETRIES', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('SURVEY', 'mnu_control(upd3)', 'PSWD_RETRIES', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER1', 'mnu_control(upd3)', 'PSWD_RETRIES', 'NED', '2006-04-17 09:33:54', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER2', 'mnu_control(upd3)', 'PSWD_RETRIES', 'NED', '2006-04-17 09:34:30', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER3', 'mnu_control(upd3)', 'PSWD_RETRIES', 'NED', '2006-04-17 09:35:04', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'PSWD_WARNING', 'NED', '2006-04-11 16:38:33', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'PSWD_WARNING', 'NED', '2006-04-11 16:46:48', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('USER1', 'mnu_control(upd3)', 'PSWD_WARNING', 'NED', '2006-04-17 09:34:07', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER2', 'mnu_control(upd3)', 'PSWD_WARNING', 'NED', '2006-04-17 09:34:42', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER3', 'mnu_control(upd3)', 'PSWD_WARNING', 'NED', '2006-04-17 09:35:16', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'SHUTDOWN_END', 'NED', '2006-04-17 09:32:05', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_END', 'NED', '2006-04-17 09:32:43', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('USER1', 'mnu_control(upd3)', 'SHUTDOWN_END', 'NED', '2006-04-17 09:34:07', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER2', 'mnu_control(upd3)', 'SHUTDOWN_END', 'NED', '2006-04-17 09:34:43', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('USER3', 'mnu_control(upd3)', 'SHUTDOWN_END', 'NED', '2006-04-17 09:35:16', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'SHUTDOWN_FRIDAY', 'NED', '2006-04-17 09:32:05', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_FRIDAY', 'NED', '2006-04-17 09:32:43', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER1', 'mnu_control(upd3)', 'SHUTDOWN_FRIDAY', 'NED', '2006-04-17 09:34:07', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER2', 'mnu_control(upd3)', 'SHUTDOWN_FRIDAY', 'NED', '2006-04-17 09:34:43', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('USER3', 'mnu_control(upd3)', 'SHUTDOWN_FRIDAY', 'NED', '2006-04-17 09:35:16', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'SHUTDOWN_MONDAY', 'NED', '2006-04-17 09:32:05', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_MONDAY', 'NED', '2006-04-17 09:32:43', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER1', 'mnu_control(upd3)', 'SHUTDOWN_MONDAY', 'NED', '2006-04-17 09:34:07', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER2', 'mnu_control(upd3)', 'SHUTDOWN_MONDAY', 'NED', '2006-04-17 09:34:43', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('USER3', 'mnu_control(upd3)', 'SHUTDOWN_MONDAY', 'NED', '2006-04-17 09:35:16', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'SHUTDOWN_SATURDAY', 'NED', '2006-04-17 09:32:05', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_SATURDAY', 'NED', '2006-04-17 09:32:44', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER1', 'mnu_control(upd3)', 'SHUTDOWN_SATURDAY', 'NED', '2006-04-17 09:34:08', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER2', 'mnu_control(upd3)', 'SHUTDOWN_SATURDAY', 'NED', '2006-04-17 09:34:43', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('USER3', 'mnu_control(upd3)', 'SHUTDOWN_SATURDAY', 'NED', '2006-04-17 09:35:16', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'SHUTDOWN_START', 'NED', '2006-04-17 09:32:05', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_START', 'NED', '2006-04-17 09:32:44', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER1', 'mnu_control(upd3)', 'SHUTDOWN_START', 'NED', '2006-04-17 09:34:08', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER2', 'mnu_control(upd3)', 'SHUTDOWN_START', 'NED', '2006-04-17 09:34:43', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('USER3', 'mnu_control(upd3)', 'SHUTDOWN_START', 'NED', '2006-04-17 09:35:16', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'SHUTDOWN_SUNDAY', 'NED', '2006-04-17 09:32:05', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_SUNDAY', 'NED', '2006-04-17 09:32:44', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER1', 'mnu_control(upd3)', 'SHUTDOWN_SUNDAY', 'NED', '2006-04-17 09:34:08', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER2', 'mnu_control(upd3)', 'SHUTDOWN_SUNDAY', 'NED', '2006-04-17 09:34:43', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('USER3', 'mnu_control(upd3)', 'SHUTDOWN_SUNDAY', 'NED', '2006-04-17 09:35:16', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'SHUTDOWN_THURSDAY', 'NED', '2006-04-17 09:32:05', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_THURSDAY', 'NED', '2006-04-17 09:32:44', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER1', 'mnu_control(upd3)', 'SHUTDOWN_THURSDAY', 'NED', '2006-04-17 09:34:08', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER2', 'mnu_control(upd3)', 'SHUTDOWN_THURSDAY', 'NED', '2006-04-17 09:34:43', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('USER3', 'mnu_control(upd3)', 'SHUTDOWN_THURSDAY', 'NED', '2006-04-17 09:35:16', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'SHUTDOWN_TUESDAY', 'NED', '2006-04-17 09:32:05', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_TUESDAY', 'NED', '2006-04-17 09:32:44', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER1', 'mnu_control(upd3)', 'SHUTDOWN_TUESDAY', 'NED', '2006-04-17 09:34:08', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER2', 'mnu_control(upd3)', 'SHUTDOWN_TUESDAY', 'NED', '2006-04-17 09:34:43', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('USER3', 'mnu_control(upd3)', 'SHUTDOWN_TUESDAY', 'NED', '2006-04-17 09:35:16', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'SHUTDOWN_WARNING', 'NED', '2006-04-17 09:32:05', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_WARNING', 'NED', '2006-04-17 09:32:44', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER1', 'mnu_control(upd3)', 'SHUTDOWN_WARNING', 'NED', '2006-04-17 09:34:08', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER2', 'mnu_control(upd3)', 'SHUTDOWN_WARNING', 'NED', '2006-04-17 09:34:43', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('USER3', 'mnu_control(upd3)', 'SHUTDOWN_WARNING', 'NED', '2006-04-17 09:35:16', 'AJM', '2007-09-10 10:44:37', 'AJM'),
('DEMO', 'mnu_control(upd3)', 'SHUTDOWN_WEDNESDAY', 'NED', '2006-04-17 09:31:45', 'AJM', '2007-09-10 10:44:33', 'AJM'),
('READONLY', 'mnu_control(upd3)', 'SHUTDOWN_WEDNESDAY', 'NED', '2006-04-17 09:32:25', 'AJM', '2007-09-10 10:44:34', 'AJM'),
('USER1', 'mnu_control(upd3)', 'SHUTDOWN_WEDNESDAY', 'NED', '2006-04-17 09:33:37', 'AJM', '2007-09-10 10:44:35', 'AJM'),
('USER2', 'mnu_control(upd3)', 'SHUTDOWN_WEDNESDAY', 'NED', '2006-04-17 09:34:17', 'AJM', '2007-09-10 10:44:36', 'AJM'),
('USER3', 'mnu_control(upd3)', 'SHUTDOWN_WEDNESDAY', 'NED', '2006-04-17 09:34:52', 'AJM', '2007-09-10 10:44:37', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_help_text(multi1)', 'Maintain Help Text', 'Help Text', 'PROC', 'help_text(multi1).php', 'N', 'MULTI1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 10:47:22', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list2)a', 'mnu_help_text(multi1)', '003', 'Help Text', 'Y', '2004-08-26 11:58:54', 'AJM', '2007-09-10 14:46:07', 'AJM'),
('mnu_task(list2)b', 'mnu_help_text(multi1)', '003', 'Help Text', 'Y', '2006-07-21 11:36:38', 'AJM', '2007-09-10 14:48:19', 'AJM'),
('mnu_task(list1)', 'mnu_help_text(multi1)', '005', 'Help Text', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)a', 'mnu_help_text(multi1)', '005', 'Help Text', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)b', 'mnu_help_text(multi1)', '005', 'Help Text', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_initial_value_role(multi3)a', 'Maintain Initial Value (Role) by Task', 'Initial Values', 'PROC', 'mnu_initial_value_role(multi3)a.php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2007-05-05 19:14:19', 'AJM', '2007-05-05 19:17:24', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_initial_value_role(multi3)a', 'mnu_role(search)', '001', 'Search', 'N', '2007-05-05 19:17:50', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)a', 'mnu_initial_value_role(multi3)a', '014', 'Initial Values (Role)', 'Y', '2007-05-05 19:22:19', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)', 'mnu_initial_value_role(multi3)a', '017', 'Initial Values (Role)', 'Y', '2007-05-27 10:51:53', 'AJM', '2007-09-10 14:30:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_initial_value_role(multi3)b', 'Maintain Initial Value by Role', 'Initial Values', 'PROC', 'mnu_initial_value_role(multi3)b.php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2007-05-05 22:41:13', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_initial_value_role(multi3)b', 'mnu_task(search)', '001', 'Search', 'N', '2007-05-05 22:41:52', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(list1)', 'mnu_initial_value_role(multi3)b', '008', 'Initial Values', 'Y', '2007-05-05 22:42:40', 'AJM', '2007-09-10 11:41:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_initial_value_user(multi3)a', 'Maintain Initial Value (User) by Task', 'Initial Values', 'PROC', 'mnu_initial_value_user(multi3)a.php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2007-05-27 10:43:36', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)a', 'mnu_initial_value_user(multi3)a', '015', 'Initial Values (User)', 'Y', '2007-05-27 10:54:39', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)', 'mnu_initial_value_user(multi3)a', '018', 'Initial Values (User)', 'Y', '2007-05-27 10:51:53', 'AJM', '2007-09-10 14:30:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_initial_value_user(multi3)b', 'Maintain Initial Value by User', 'Initial Values', 'PROC', 'mnu_initial_value_user(multi3)b.php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2007-05-27 10:42:45', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(list2)', 'mnu_initial_value_user(multi3)b', '002', 'Initial Values', 'Y', '2007-05-27 10:45:41', 'AJM', '2007-09-10 15:27:06', 'AJM'),
('mnu_user(list1)', 'mnu_initial_value_user(multi3)b', '008', 'Initial Values', 'Y', '2007-05-27 10:44:10', 'AJM', '2007-09-10 15:25:13', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(add3)', 'Add Menu Items', 'Insert', 'PROC', 'mnu_menu(add3).php', 'N', 'ADD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:25:55', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(list2)', 'mnu_menu(add3)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:28:50', 'AJM'),
('mnu_menu(multi2)', 'mnu_menu(add3)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:29:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(add3)a', 'Add Menu Items', 'Insert', 'PROC', 'mnu_menu(add3)a.php', 'N', 'ADD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2007-08-12 17:56:28', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(list2)a', 'mnu_menu(add3)a', '001', 'New', 'N', '2007-08-12 17:56:49', 'AJM', '2007-08-12 17:57:08', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(del2)', 'Delete Menu Items', 'Delete', 'PROC', 'mnu_menu(del2).php', 'N', 'DEL2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:26:52', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(list2)a', 'mnu_menu(del2)', '002', 'Delete', 'Y', '2007-08-12 17:38:48', 'AJM', NULL, NULL),
('mnu_menu(list2)', 'mnu_menu(del2)', '003', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:28:50', 'AJM'),
('mnu_menu(multi2)', 'mnu_menu(del2)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:29:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(link1)', 'Maintain Menu Items (2)', 'Menu Items(2)', 'PROC', 'mnu_menu(link1).php', 'N', 'LINK1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:28:00', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(link1)', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:28:00', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)b', 'mnu_menu(link1)', '008', 'Menu Items(2)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM'),
('mnu_task(list1)', 'mnu_menu(link1)', '012', 'Menu Contents (2)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(list2)', 'List Menu Items', 'Menu Items(3)', 'PROC', 'mnu_menu(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:28:50', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(list2)', 'mnu_menu(add3)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:28:50', 'AJM'),
('mnu_menu(list2)', 'mnu_menu(upd1)', '002', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:30:55', 'AJM'),
('mnu_menu(list2)', 'mnu_menu(del2)', '003', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:28:50', 'AJM'),
('mnu_menu(list2)', 'mnu_menu(search)', '004', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:28:50', 'AJM'),
('mnu_menu(list2)', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2004-04-09 11:58:45', 'AJM', '2007-08-12 17:28:50', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)b', 'mnu_menu(list2)', '009', 'Menu Items(3)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM'),
('mnu_task(list1)', 'mnu_menu(list2)', '013', 'Menu Contents (3)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_menu(list2)', '2005-04-19 18:11:41', 'AJM', '2007-08-12 17:28:50', 'AJM'),
('READONLY', 'mnu_menu(list2)', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:28:50', 'AJM'),
('SURVEY', 'mnu_menu(list2)', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:28:50', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(list2)a', 'List Menu Parents', 'Menu (Parents)', 'PROC', 'mnu_menu(list2)a.php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2007-08-12 17:38:48', 'AJM', '2007-08-12 17:40:21', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(list2)a', 'mnu_menu(add3)a', '001', 'New', 'N', '2007-08-12 17:56:49', 'AJM', '2007-08-12 17:57:08', 'AJM'),
('mnu_menu(list2)a', 'mnu_menu(del2)', '002', 'Delete', 'Y', '2007-08-12 17:38:48', 'AJM', NULL, NULL),
('mnu_menu(list2)a', 'mnu_menu(search)', '003', 'Search', 'N', '2007-08-12 17:38:48', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)b', 'mnu_menu(list2)a', '010', 'Menu (Parents)', 'Y', '2007-08-12 17:41:40', 'AJM', '2007-09-10 14:35:53', 'AJM'),
('mnu_task(list1)a', 'mnu_menu(list2)a', '011', 'Menu (Parents)', 'Y', '2007-08-12 18:08:29', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)', 'mnu_menu(list2)a', '014', 'Menu (Parents)', 'Y', '2007-08-13 10:17:03', 'AJM', '2007-09-10 14:30:47', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_menu(list2)a', '2007-08-13 10:28:23', 'AJM', NULL, NULL),
('READONLY', 'mnu_menu(list2)a', '2007-08-13 10:30:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(multi2)', 'Maintain Menu Items (1)', 'Menu Items(1)', 'PROC', 'mnu_menu(multi2).php', 'N', 'MULTI2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:29:47', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(multi2)', 'mnu_menu(add3)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:29:47', 'AJM'),
('mnu_menu(multi2)', 'mnu_menu(del2)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:29:47', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)b', 'mnu_menu(multi2)', '007', 'Menu Items(1)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM'),
('mnu_task(list1)', 'mnu_menu(multi2)', '011', 'Menu Contents (1)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(search)', 'Search Menu Items', 'Search', 'PROC', 'mnu_menu(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:30:19', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(list2)a', 'mnu_menu(search)', '003', 'Search', 'N', '2007-08-12 17:38:48', 'AJM', NULL, NULL),
('mnu_menu(list2)', 'mnu_menu(search)', '004', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:28:50', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_menu(search)', '2005-04-19 18:11:41', 'AJM', NULL, NULL),
('READONLY', 'mnu_menu(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_menu(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(upd1)', 'Update Menu Item', 'Update', 'PROC', 'mnu_menu(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 17:30:56', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(list2)', 'mnu_menu(upd1)', '002', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:30:55', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(add3)', 'Add Navigation Button', 'Insert', 'PROC', 'mnu_nav_button(add3).php', 'N', 'ADD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:19:06', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(list2)', 'mnu_nav_button(add3)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:16:12', 'AJM'),
('mnu_nav_button(multi2)', 'mnu_nav_button(add3)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:17:10', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(add3)a', 'Add Navigation Button', 'Insert', 'PROC', 'mnu_nav_button(add3)a.php', 'N', 'ADD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2007-08-12 13:42:22', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(list2)a', 'mnu_nav_button(add3)a', '001', 'New', 'N', '2007-08-12 14:29:06', 'AJM', '2007-08-12 18:55:55', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(del2)', 'Delete Navigation Button', 'Delete', 'PROC', 'mnu_nav_button(del2).php', 'N', 'DEL2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:19:56', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(list2)a', 'mnu_nav_button(del2)', '002', 'Delete', 'Y', '2007-08-12 14:28:49', 'AJM', NULL, NULL),
('mnu_nav_button(list2)', 'mnu_nav_button(del2)', '003', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:16:12', 'AJM'),
('mnu_nav_button(multi2)', 'mnu_nav_button(del2)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:17:10', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(link1)', 'Maintain Navigation Buttons (2)', 'Navigation Button (2)', 'PROC', 'mnu_nav_button(link1).php', 'N', 'LINK1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:20:37', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(link1)', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:16:40', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)', 'mnu_nav_button(link1)', '008', 'Navigation Button(2)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)a', 'mnu_nav_button(link1)', '008', 'Navigation Button(2)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(list2)', 'List Navigation Buttons', 'Navigation Buttons (3)', 'PROC', 'mnu_nav_button(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:22:09', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(list2)', 'mnu_nav_button(add3)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:16:12', 'AJM'),
('mnu_nav_button(list2)', 'mnu_nav_button(upd1)', '002', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:18:58', 'AJM'),
('mnu_nav_button(list2)', 'mnu_nav_button(del2)', '003', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:16:12', 'AJM'),
('mnu_nav_button(list2)', 'mnu_nav_button(search)', '004', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:16:12', 'AJM'),
('mnu_nav_button(list2)', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2004-04-09 11:58:57', 'AJM', '2007-08-12 11:16:12', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)', 'mnu_nav_button(list2)', '009', 'Navigation Button(3)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)a', 'mnu_nav_button(list2)', '009', 'Navigation Button(3)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_nav_button(list2)', '2005-04-19 18:11:54', 'AJM', '2007-08-12 11:16:13', 'AJM'),
('READONLY', 'mnu_nav_button(list2)', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:16:13', 'AJM'),
('SURVEY', 'mnu_nav_button(list2)', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:16:13', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(list2)a', 'List Navigation Button Parents', 'Navigation Button (Parents)', 'PROC', 'mnu_nav_button(list2)a.php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2007-08-12 11:25:09', 'AJM', '2007-08-12 14:22:28', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(list2)a', 'mnu_nav_button(add3)a', '001', 'New', 'N', '2007-08-12 14:29:06', 'AJM', '2007-08-12 18:55:55', 'AJM'),
('mnu_nav_button(list2)a', 'mnu_nav_button(del2)', '002', 'Delete', 'Y', '2007-08-12 14:28:49', 'AJM', NULL, NULL),
('mnu_nav_button(list2)a', 'mnu_nav_button(search)', '003', 'Search', 'N', '2007-08-12 14:28:24', 'AJM', '2007-08-12 14:29:17', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)a', 'mnu_nav_button(list2)a', '010', 'Navigation Button (Parents)', 'Y', '2007-08-12 11:29:07', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)', 'mnu_nav_button(list2)a', '010', 'Navigation Button (Parents)', 'Y', '2007-08-13 10:16:50', 'AJM', '2007-09-10 14:30:47', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_nav_button(list2)a', '2007-08-13 10:28:35', 'AJM', NULL, NULL),
('READONLY', 'mnu_nav_button(list2)a', '2007-08-13 10:30:51', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(multi2)', 'Maintain Navigation Buttons (1)', 'Navigation Button (1)', 'PROC', 'mnu_nav_button(multi2).php', 'N', 'MULTI2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:22:57', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(multi2)', 'mnu_nav_button(add3)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:17:10', 'AJM'),
('mnu_nav_button(multi2)', 'mnu_nav_button(del2)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:17:10', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)', 'mnu_nav_button(multi2)', '007', 'Navigation Button(1)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)a', 'mnu_nav_button(multi2)', '007', 'Navigation Button(1)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(search)', 'Search Navigation Button', 'Search', 'PROC', 'mnu_nav_button(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:23:47', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(list2)a', 'mnu_nav_button(search)', '003', 'Search', 'N', '2007-08-12 14:28:24', 'AJM', '2007-08-12 14:29:17', 'AJM'),
('mnu_nav_button(list2)', 'mnu_nav_button(search)', '004', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:16:12', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_nav_button(search)', '2005-04-19 18:11:54', 'AJM', NULL, NULL),
('READONLY', 'mnu_nav_button(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_nav_button(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(upd1)', 'Update Navigation Button', 'Update', 'PROC', 'mnu_nav_button(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-08-12 14:24:14', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(list2)', 'mnu_nav_button(upd1)', '002', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:18:58', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_pattern(add1)', 'Add Pattern', 'Insert', 'PROC', 'mnu_pattern(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 10:58:00', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_pattern(list1)', 'mnu_pattern(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:58:00', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_pattern(del1)', 'Delete Pattern', 'Delete', 'PROC', 'mnu_pattern(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:02:18', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_pattern(list1)', 'mnu_pattern(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:02:18', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_pattern(enq1)', 'Enquire Pattern', 'Enquire', 'PROC', 'mnu_pattern_enq.php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:03:25', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_pattern(list1)', 'mnu_pattern(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:03:25', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_pattern(enq1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:03:25', 'AJM'),
('READONLY', 'mnu_pattern(enq1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:03:25', 'AJM'),
('SURVEY', 'mnu_pattern(enq1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:03:25', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_pattern(list1)', 'List Pattern', 'List Pattern', 'PROC', 'mnu_pattern(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'Y', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 10:55:35', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_pattern(list1)', 'mnu_pattern(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:58:00', 'AJM'),
('mnu_pattern(list1)', 'mnu_pattern(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:03:25', 'AJM'),
('mnu_pattern(list1)', 'mnu_pattern(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:05:58', 'AJM'),
('mnu_pattern(list1)', 'mnu_pattern(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:02:18', 'AJM'),
('mnu_pattern(list1)', 'mnu_task(list2)a', '005', 'List Task', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:46:07', 'AJM'),
('mnu_pattern(list1)', 'mnu_pattern(search)', '006', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:55:34', 'AJM'),
('mnu_pattern(list1)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2004-04-09 11:37:12', 'AJM', '2007-09-10 10:55:34', 'AJM'),
('mnu_pattern(list1)', 'mnu_pattern(pdf)', '008', 'Output to PDF(L)', 'N', '2006-08-16 22:19:25', 'AJM', '2007-09-10 10:55:34', 'AJM'),
('mnu_pattern(list1)', 'mnu_pattern(pdf)2', '009', 'Output to PDF(D)', 'N', '2006-08-16 19:13:53', 'AJM', '2007-09-10 10:55:34', 'AJM');

REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_pattern(list1)', 'DUMMY1', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:55:35', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_pattern(list1)', '2005-04-19 18:11:29', 'AJM', '2007-09-10 10:55:35', 'AJM'),
('READONLY', 'mnu_pattern(list1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:55:35', 'AJM'),
('SURVEY', 'mnu_pattern(list1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:55:35', 'AJM');

REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('USER1', 'mnu_pattern(list1)', 'DUMMY1', 'NDI', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:55:35', 'AJM'),
('USER3', 'mnu_pattern(list1)', 'DUMMY1', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:55:35', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_pattern(pdf)', 'Output to PDF - List view', 'Output to PDF(L)', 'PROC', 'mnu_pattern(pdf).php', 'N', 'OUTPUT2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-08-16 22:18:49', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_pattern(list1)', 'mnu_pattern(pdf)', '008', 'Output to PDF(L)', 'N', '2006-08-16 22:19:25', 'AJM', '2007-09-10 10:55:34', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_pattern(pdf)', '2006-08-18 13:24:37', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_pattern(pdf)2', 'Output to PDF - Detail view', 'Output to PDF(D)', 'PROC', 'mnu_pattern(pdf)2.php', 'N', 'OUTPUT3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-08-16 19:13:24', 'AJM', '2006-08-16 22:18:12', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_pattern(list1)', 'mnu_pattern(pdf)2', '009', 'Output to PDF(D)', 'N', '2006-08-16 19:13:53', 'AJM', '2007-09-10 10:55:34', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_pattern(pdf)2', '2006-08-18 13:24:52', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_pattern(search)', 'Search Pattern', 'Search', 'PROC', 'mnu_pattern(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:03:57', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_pattern(list1)', 'mnu_pattern(search)', '006', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:55:34', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_pattern(search)', '2003-01-01 12:00:00', 'AJM', '2006-03-27 23:37:36', 'AJM'),
('READONLY', 'mnu_pattern(search)', '2003-01-01 12:00:00', 'AJM', '2006-03-27 23:37:36', 'AJM'),
('SURVEY', 'mnu_pattern(search)', '2003-01-01 12:00:00', 'AJM', '2006-03-27 23:37:36', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_pattern(upd1)', 'Update Pattern', 'Update', 'PROC', 'mnu_pattern(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:05:59', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_pattern(list1)', 'mnu_pattern(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:05:58', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role_task(link1)a', 'Link Role(s) to selected Task', 'Task Access', 'PROC', 'mnu_role_task(link1)a.php', 'N', 'LINK1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:12:14', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role_task(link1)a', 'mnu_role(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:12:14', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)', 'mnu_role_task(link1)a', '006', 'Task Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)a', 'mnu_role_task(link1)a', '006', 'Task Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)b', 'mnu_role_task(link1)a', '006', 'Task Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role_task(link1)b', 'Link Task(s) to selected Role', 'Task Access', 'PROC', 'mnu_role_task(link1)b.php', 'N', 'LINK1', 'MENU', NULL, NULL, NULL, NULL, 'task_id', 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:20:38', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role_task(link1)b', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:20:38', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(list1)', 'mnu_role_task(link1)b', '006', 'Task Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role_taskfield(multi3)a', 'Maintain Field Access via Task', 'Field Access', 'PROC', 'mnu_role_taskfield(multi3)a.php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, 'mnu_task_field.field_id', 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:26:03', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role_taskfield(multi3)a', 'mnu_role(search)', '001', 'Search Role', 'N', '2007-02-09 13:46:15', 'AJM', '2007-09-10 11:26:03', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)a', 'mnu_role_taskfield(multi3)a', '013', 'Field Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)', 'mnu_role_taskfield(multi3)a', '016', 'Field Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role_taskfield(multi3)b', 'Maintain Field Access via Role', 'Field Access', 'PROC', 'mnu_role_taskfield(multi3)b.php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, 'mnu_task_field.field_id', 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:30:42', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role_taskfield(multi3)b', 'mnu_task(search)', '001', 'Search Task', 'N', '2007-02-09 12:03:36', 'AJM', '2007-09-10 11:30:42', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(list1)', 'mnu_role_taskfield(multi3)b', '007', 'Field Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(add1)', 'Add Role', 'Insert', 'PROC', 'mnu_role(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:34:18', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(list1)', 'mnu_role(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(del1)', 'Delete Role', 'Delete', 'PROC', 'mnu_role(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:36:00', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(list1)', 'mnu_role(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(enq1)', 'Enquire Role', 'Enquire', 'PROC', 'mnu_role(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:39:04', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(list1)', 'mnu_role(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_role(enq1)', '2005-04-19 18:11:54', 'AJM', '2007-09-10 11:39:04', 'AJM'),
('READONLY', 'mnu_role(enq1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:39:04', 'AJM'),
('SURVEY', 'mnu_role(enq1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:39:04', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(list1)', 'List Role', 'List Role', 'PROC', 'mnu_role(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'Y', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:41:48', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(list1)', 'mnu_role(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM'),
('mnu_role(list1)', 'mnu_role(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM'),
('mnu_role(list1)', 'mnu_role(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:50:24', 'AJM'),
('mnu_role(list1)', 'mnu_role(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM'),
('mnu_role(list1)', 'mnu_user(list2)', '005', 'List User', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:27:06', 'AJM'),
('mnu_role(list1)', 'mnu_role_task(link1)b', '006', 'Task Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM'),
('mnu_role(list1)', 'mnu_role_taskfield(multi3)b', '007', 'Field Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM'),
('mnu_role(list1)', 'mnu_initial_value_role(multi3)b', '008', 'Initial Values', 'Y', '2007-05-05 22:42:40', 'AJM', '2007-09-10 11:41:47', 'AJM'),
('mnu_role(list1)', 'mnu_role(search)', '009', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM'),
('mnu_role(list1)', 'audit_dtl(list)3', '010', 'Audit Trail', 'Y', '2004-04-09 11:37:40', 'AJM', '2007-09-10 11:41:47', 'AJM'),
('mnu_role(list1)', 'mnu_role(pdf)', '011', 'Output to PDF(L)', 'N', '2006-08-17 16:25:30', 'AJM', '2007-09-10 11:41:47', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_role(list1)', '2005-04-19 18:11:54', 'AJM', '2007-09-10 11:41:47', 'AJM'),
('READONLY', 'mnu_role(list1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM'),
('SURVEY', 'mnu_role(list1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(pdf)', 'Output to PDF - List view', 'Output to PDF(L)', 'PROC', 'mnu_role(pdf).php', 'N', 'OUTPUT2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-08-17 16:25:05', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(list1)', 'mnu_role(pdf)', '011', 'Output to PDF(L)', 'N', '2006-08-17 16:25:30', 'AJM', '2007-09-10 11:41:47', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_role(pdf)', '2006-08-18 13:24:37', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(popup1)', 'Choose Role', 'Choose', 'PROC', 'mnu_role(popup1).php', 'N', 'POPUP1', 'MENU', NULL, NULL, NULL, NULL, 'role_id', 'N', 'N', NULL, 'N', '2004-04-14 15:04:39', 'AJM', '2007-09-10 11:45:02', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_role(popup1)', '2005-04-19 18:11:54', 'AJM', '2007-09-10 11:45:02', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(search)', 'Search Role', 'Search', 'PROC', 'mnu_role_search.php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role_task(link1)a', 'mnu_role(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:12:14', 'AJM'),
('mnu_role_taskfield(multi3)a', 'mnu_role(search)', '001', 'Search Role', 'N', '2007-02-09 13:46:15', 'AJM', '2007-09-10 11:26:03', 'AJM'),
('mnu_initial_value_role(multi3)a', 'mnu_role(search)', '001', 'Search', 'N', '2007-05-05 19:17:50', 'AJM', NULL, NULL),
('mnu_role(list1)', 'mnu_role(search)', '009', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_role(search)', '2005-04-19 18:12:06', 'AJM', NULL, NULL),
('READONLY', 'mnu_role(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_role(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(upd1)', 'Update Role', 'Update', 'PROC', 'mnu_role(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:50:24', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(list1)', 'mnu_role(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:50:24', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_session(upd3)', 'Update Session Data', 'Session Data', 'PROC', 'mnu_session(upd3).php', 'N', 'UPD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-04-06 19:37:49', 'AJM', '2007-09-10 11:53:31', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('menu', 'mnu_session(upd3)', '004', 'Session Data', 'N', '2006-04-06 19:39:09', 'AJM', '2007-09-10 11:53:31', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_session(upd3)', '2006-04-10 11:03:18', 'AJM', '2007-09-10 11:53:31', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(add1)', 'Add Subsystem', 'Insert', 'PROC', 'mnu_subsystem(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:57:39', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(list1)', 'mnu_subsystem(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:01:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(del1)', 'Delete Subsystem', 'Delete', 'PROC', 'mnu_subsystem(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 11:58:59', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(list1)', 'mnu_subsystem(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:01:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(enq1)', 'Enquire Subsystem', 'Enquire', 'PROC', 'mnu_subsystem(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 12:03:57', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(list1)', 'mnu_subsystem(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:01:47', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_subsystem(enq1)', '2005-04-19 18:12:19', 'AJM', '2007-09-10 12:03:57', 'AJM'),
('READONLY', 'mnu_subsystem(enq1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 12:03:57', 'AJM'),
('SURVEY', 'mnu_subsystem(enq1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 12:03:57', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(erase)', 'Erase Subsystem', 'Erase', 'PROC', 'mnu_subsystem(erase1).php', 'N', 'ERASE1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2005-12-06 17:42:11', 'AJM', '2007-09-10 14:06:29', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(list1)', 'mnu_subsystem(erase)', '009', 'Erase', 'Y', '2005-12-06 17:42:42', 'AJM', '2007-09-10 14:01:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(list1)', 'List Subsystem', 'List Subsystem', 'PROC', 'mnu_subsystem(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'Y', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:01:48', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(list1)', 'mnu_subsystem(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:01:47', 'AJM'),
('mnu_subsystem(list1)', 'mnu_subsystem(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:01:47', 'AJM'),
('mnu_subsystem(list1)', 'mnu_subsystem(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:05:25', 'AJM'),
('mnu_subsystem(list1)', 'mnu_subsystem(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:01:47', 'AJM'),
('mnu_subsystem(list1)', 'mnu_task(list2)b', '005', 'List Task', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:48:19', 'AJM'),
('mnu_subsystem(list1)', 'mnu_subsystem(search)', '006', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:01:47', 'AJM'),
('mnu_subsystem(list1)', 'mnu_subsystem(upd4)export', '007', 'Export', 'Y', '2005-07-15 21:13:05', 'AJM', '2007-09-10 14:09:21', 'AJM'),
('mnu_subsystem(list1)', 'dict_database(list)2', '008', 'Databases', 'Y', '2005-03-12 18:56:34', 'AJM', '2007-09-10 14:01:47', 'AJM'),
('mnu_subsystem(list1)', 'mnu_subsystem(erase)', '009', 'Erase', 'Y', '2005-12-06 17:42:42', 'AJM', '2007-09-10 14:01:47', 'AJM'),
('mnu_subsystem(list1)', 'mnu_subsystem(pdf)', '010', 'Output to PDF(L)', 'N', '2006-08-17 10:59:24', 'AJM', '2007-09-10 14:01:48', 'AJM'),
('mnu_subsystem(list1)', 'mnu_subsystem(upd4)build', '011', 'Build Directory', 'Y', '2006-09-28 11:09:48', 'AJM', '2007-09-10 14:01:48', 'AJM'),
('mnu_subsystem(list1)', 'audit_dtl(list)3', '012', 'Audit Trail', 'Y', '2004-04-09 11:37:58', 'AJM', '2007-09-10 14:01:48', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_subsystem(list1)', '2005-04-19 18:12:19', 'AJM', '2007-09-10 14:01:48', 'AJM'),
('READONLY', 'mnu_subsystem(list1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:01:48', 'AJM'),
('SURVEY', 'mnu_subsystem(list1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:01:48', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(pdf)', 'Output to PDF - List view', 'Output to PDF(L)', 'PROC', 'mnu_subsystem(pdf).php', 'N', 'OUTPUT2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-08-17 10:58:50', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(list1)', 'mnu_subsystem(pdf)', '010', 'Output to PDF(L)', 'N', '2006-08-17 10:59:24', 'AJM', '2007-09-10 14:01:48', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_subsystem(pdf)', '2006-08-18 13:24:37', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(search)', 'Search Subsystem', 'Search', 'PROC', 'mnu_subsystem(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:04:15', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(list1)', 'mnu_subsystem(search)', '006', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:01:47', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_subsystem(search)', '2005-04-19 18:12:19', 'AJM', NULL, NULL),
('READONLY', 'mnu_subsystem(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_subsystem(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(upd1)', 'Update Subsystem', 'Update', 'PROC', 'mnu_subsystem(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:05:25', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(list1)', 'mnu_subsystem(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:05:25', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(upd4)build', 'Build Subsystem Directory', 'Build', 'PROC', 'mnu_subsystem(upd4)build.php', 'N', 'UPD4', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-09-28 11:02:20', 'AJM', '2007-09-10 12:02:43', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(list1)', 'mnu_subsystem(upd4)build', '011', 'Build Directory', 'Y', '2006-09-28 11:09:48', 'AJM', '2007-09-10 14:01:48', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(upd4)export', 'Export Subsystem', 'Export', 'PROC', 'mnu_subsystem(upd4)export.php', 'N', 'UPD4', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2005-07-15 21:12:39', 'AJM', '2007-09-10 14:09:21', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(list1)', 'mnu_subsystem(upd4)export', '007', 'Export', 'Y', '2005-07-15 21:13:05', 'AJM', '2007-09-10 14:09:21', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task_field(add2)', 'Add Task Field', 'New', 'PROC', 'mnu_task_field(add2).php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:21:52', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task_field(list2)', 'mnu_task_field(add2)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:21:52', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task_field(del1)', 'Delete Task Field', 'Delete', 'PROC', 'mnu_task_field(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:22:57', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task_field(list2)', 'mnu_task_field(del1)', '002', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:22:57', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task_field(list2)', 'List Task Field', 'List Fields', 'PROC', 'mnu_task_field(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, 'field_id', 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:19:30', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task_field(list2)', 'mnu_task_field(add2)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:21:52', 'AJM'),
('mnu_task_field(list2)', 'mnu_task_field(del1)', '002', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:22:57', 'AJM'),
('mnu_task_field(list2)', 'audit_dtl(list)3', '003', 'Audit Trail', 'Y', '2004-04-09 11:59:27', 'AJM', '2007-09-10 14:19:30', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)a', 'mnu_task_field(list2)', '012', 'List Fields', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)', 'mnu_task_field(list2)', '015', 'List Fields', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task_field(list2)', '2005-04-19 18:12:42', 'AJM', '2007-09-10 14:19:30', 'AJM'),
('SURVEY', 'mnu_task_field(list2)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:19:30', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(add1)', 'Add Task', 'Insert', 'PROC', 'mnu_task(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:39:39', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)', 'mnu_task(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:39:39', 'AJM'),
('mnu_task(list1)a', 'mnu_task(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:39:39', 'AJM'),
('mnu_task(list1)b', 'mnu_task(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:39:39', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(del1)', 'Delete Task', 'Delete', 'PROC', 'mnu_task(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:42:08', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)', 'mnu_task(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:42:08', 'AJM'),
('mnu_task(list1)a', 'mnu_task(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:42:08', 'AJM'),
('mnu_task(list1)b', 'mnu_task(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:42:08', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(enq1)', 'Enquire Task', 'Enquire', 'PROC', 'mnu_task(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:43:14', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)', 'mnu_task(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:43:13', 'AJM'),
('mnu_task(list2)a', 'mnu_task(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:46:07', 'AJM'),
('mnu_task(list2)b', 'mnu_task(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:48:18', 'AJM'),
('mnu_task(list1)a', 'mnu_task(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:43:13', 'AJM'),
('mnu_task(list1)b', 'mnu_task(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:43:13', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(enq1)', '2005-04-19 18:12:19', 'AJM', '2007-09-10 14:43:13', 'AJM'),
('READONLY', 'mnu_task(enq1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:43:13', 'AJM'),
('SURVEY', 'mnu_task(enq1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:43:13', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)', 'List Task (All)', 'Task (All)', 'PROC', 'mnu_task(list1).php', 'N', 'LIST1', 'MENU', 'mnu_task(search)', NULL, NULL, NULL, 'task_id', 'Y', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:30:48', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)', 'mnu_task(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:39:39', 'AJM'),
('mnu_task(list1)', 'mnu_task(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:43:13', 'AJM'),
('mnu_task(list1)', 'mnu_task(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:55:16', 'AJM'),
('mnu_task(list1)', 'mnu_task(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:42:08', 'AJM'),
('mnu_task(list1)', 'mnu_help_text(multi1)', '005', 'Help Text', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)', 'mnu_role_task(link1)a', '006', 'Task Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)', 'mnu_nav_button(multi2)', '007', 'Navigation Button(1)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)', 'mnu_nav_button(link1)', '008', 'Navigation Button(2)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)', 'mnu_nav_button(list2)', '009', 'Navigation Button(3)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)', 'mnu_nav_button(list2)a', '010', 'Navigation Button (Parents)', 'Y', '2007-08-13 10:16:50', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)', 'mnu_menu(multi2)', '011', 'Menu Contents (1)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)', 'mnu_menu(link1)', '012', 'Menu Contents (2)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)', 'mnu_menu(list2)', '013', 'Menu Contents (3)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)', 'mnu_menu(list2)a', '014', 'Menu (Parents)', 'Y', '2007-08-13 10:17:03', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)', 'mnu_task_field(list2)', '015', 'List Fields', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)', 'mnu_role_taskfield(multi3)a', '016', 'Field Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)', 'mnu_initial_value_role(multi3)a', '017', 'Initial Values (Role)', 'Y', '2007-05-27 10:51:53', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)', 'mnu_initial_value_user(multi3)a', '018', 'Initial Values (User)', 'Y', '2007-05-27 10:51:53', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)', 'mnu_task(rename)', '019', 'Rename', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)', 'mnu_task(search)', '020', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('mnu_task(list1)', 'mnu_task(pdf)', '021', 'Output to PDF(L)', 'N', '2006-08-17 11:06:09', 'AJM', '2007-09-10 14:30:48', 'AJM'),
('mnu_task(list1)', 'mnu_task(pdf)2', '022', 'Output to PDF(D)', 'N', '2006-08-17 11:33:44', 'AJM', '2007-09-10 14:30:48', 'AJM'),
('mnu_task(list1)', 'mnu_task(pdf)3', '023', 'Nav Buttons (PDF)', 'N', '2006-08-27 21:58:48', 'AJM', '2007-09-10 14:30:48', 'AJM'),
('mnu_task(list1)', 'audit_dtl(list)3', '024', 'Audit Trail', 'Y', '2004-04-09 11:38:19', 'AJM', '2007-09-10 14:30:48', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(list1)', '2005-04-19 18:12:19', 'AJM', '2007-09-10 14:30:48', 'AJM'),
('READONLY', 'mnu_task(list1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:48', 'AJM'),
('SURVEY', 'mnu_task(list1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:48', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)a', 'List Task (Process)', 'Task (Proc)', 'PROC', 'mnu_task(list1).php', 'N', 'LIST1', 'MENU', 'mnu_task(search)', 'task_type=\'PROC\'', NULL, NULL, 'task_id', 'Y', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:25', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)a', 'mnu_task(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:39:39', 'AJM'),
('mnu_task(list1)a', 'mnu_task(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:43:13', 'AJM'),
('mnu_task(list1)a', 'mnu_task(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:55:16', 'AJM'),
('mnu_task(list1)a', 'mnu_task(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:42:08', 'AJM'),
('mnu_task(list1)a', 'mnu_help_text(multi1)', '005', 'Help Text', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)a', 'mnu_role_task(link1)a', '006', 'Task Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)a', 'mnu_nav_button(multi2)', '007', 'Navigation Button(1)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)a', 'mnu_nav_button(link1)', '008', 'Navigation Button(2)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)a', 'mnu_nav_button(list2)', '009', 'Navigation Button(3)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)a', 'mnu_nav_button(list2)a', '010', 'Navigation Button (Parents)', 'Y', '2007-08-12 11:29:07', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)a', 'mnu_menu(list2)a', '011', 'Menu (Parents)', 'Y', '2007-08-12 18:08:29', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)a', 'mnu_task_field(list2)', '012', 'List Fields', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)a', 'mnu_role_taskfield(multi3)a', '013', 'Field Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)a', 'mnu_initial_value_role(multi3)a', '014', 'Initial Values (Role)', 'Y', '2007-05-05 19:22:19', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)a', 'mnu_initial_value_user(multi3)a', '015', 'Initial Values (User)', 'Y', '2007-05-27 10:54:39', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)a', 'mnu_task(rename)', '016', 'Rename', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)a', 'mnu_task(search)', '017', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)a', 'mnu_task(pdf)', '018', 'Output to PDF(L)', 'N', '2006-08-17 11:06:49', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)a', 'mnu_task(pdf)2', '019', 'Output to PDF(D)', 'N', '2006-08-17 11:33:55', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)a', 'mnu_task(pdf)3', '020', 'Nav Buttons (PDF)', 'N', '2006-08-27 21:59:03', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)a', 'audit_dtl(list)3', '021', 'Audit Trail', 'Y', '2004-04-09 11:38:58', 'AJM', '2007-09-10 14:35:24', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(list1)a', '2005-04-19 18:12:30', 'AJM', '2007-09-10 14:35:25', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)b', 'List Task (Menu)', 'Task (Menu)', 'PROC', 'mnu_task(list1).php', 'N', 'LIST1', 'MENU', NULL, 'task_type=\'MENU\' and pattern_id=\'MENU\'', NULL, NULL, 'task_id', 'Y', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)b', 'mnu_task(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:39:39', 'AJM'),
('mnu_task(list1)b', 'mnu_task(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:43:13', 'AJM'),
('mnu_task(list1)b', 'mnu_task(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:55:16', 'AJM'),
('mnu_task(list1)b', 'mnu_task(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:42:08', 'AJM'),
('mnu_task(list1)b', 'mnu_help_text(multi1)', '005', 'Help Text', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM'),
('mnu_task(list1)b', 'mnu_role_task(link1)a', '006', 'Task Access', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM'),
('mnu_task(list1)b', 'mnu_menu(multi2)', '007', 'Menu Items(1)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM'),
('mnu_task(list1)b', 'mnu_menu(link1)', '008', 'Menu Items(2)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM'),
('mnu_task(list1)b', 'mnu_menu(list2)', '009', 'Menu Items(3)', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM'),
('mnu_task(list1)b', 'mnu_menu(list2)a', '010', 'Menu (Parents)', 'Y', '2007-08-12 17:41:40', 'AJM', '2007-09-10 14:35:53', 'AJM'),
('mnu_task(list1)b', 'mnu_task(rename)', '011', 'Rename', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM'),
('mnu_task(list1)b', 'mnu_task(search)', '012', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM'),
('mnu_task(list1)b', 'audit_dtl(list)3', '013', 'Audit Trail', 'Y', '2004-04-08 16:27:07', 'AJM', '2007-09-10 14:35:53', 'AJM'),
('mnu_task(list1)b', 'mnu_task(pdf)', '014', 'Output to PDF(L)', 'N', '2006-08-17 11:07:01', 'AJM', '2007-09-10 14:35:53', 'AJM'),
('mnu_task(list1)b', 'mnu_task(pdf)2', '015', 'Output to PDF(D)', 'N', '2006-08-17 11:34:07', 'AJM', '2007-09-10 14:35:53', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(list1)b', '2005-04-19 18:12:30', 'AJM', '2007-09-10 14:35:53', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list2)a', 'List Task by Pattern', 'List Task', 'PROC', 'mnu_task(list2)a.php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, 'task_id', 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:46:07', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list2)a', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:46:07', 'AJM'),
('mnu_task(list2)a', 'mnu_task(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:46:07', 'AJM'),
('mnu_task(list2)a', 'mnu_help_text(multi1)', '003', 'Help Text', 'Y', '2004-08-26 11:58:54', 'AJM', '2007-09-10 14:46:07', 'AJM'),
('mnu_task(list2)a', 'audit_dtl(list)3', '004', 'Audit Trail', 'Y', '2004-04-09 11:59:11', 'AJM', '2007-09-10 14:46:07', 'AJM'),
('mnu_task(list2)a', 'mnu_task(pdf)', '005', 'Output to PDF(L)', 'N', '2006-09-25 15:07:39', 'AJM', '2007-09-10 14:46:07', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_pattern(list1)', 'mnu_task(list2)a', '005', 'List Task', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:46:07', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(list2)a', '2005-04-19 18:12:19', 'AJM', '2007-09-10 14:46:07', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list2)b', 'List Task by Subsystem', 'List Task', 'PROC', 'mnu_task(list2)b.php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, 'task_id', 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:48:19', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list2)b', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:48:18', 'AJM'),
('mnu_task(list2)b', 'mnu_task(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:48:18', 'AJM'),
('mnu_task(list2)b', 'mnu_help_text(multi1)', '003', 'Help Text', 'Y', '2006-07-21 11:36:38', 'AJM', '2007-09-10 14:48:19', 'AJM'),
('mnu_task(list2)b', 'audit_dtl(list)3', '004', 'Audit Trail', 'Y', '2004-04-09 11:59:19', 'AJM', '2007-09-10 14:48:19', 'AJM'),
('mnu_task(list2)b', 'mnu_task(pdf)', '005', 'Output to PDF(L)', 'N', '2006-09-25 15:08:41', 'AJM', '2007-09-10 14:48:19', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(list1)', 'mnu_task(list2)b', '005', 'List Task', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:48:19', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(list2)b', '2005-04-19 18:12:19', 'AJM', '2007-09-10 14:48:19', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(pdf)', 'Output to PDF - List view', 'Output to PDF(L)', 'PROC', 'mnu_task(pdf).php', 'N', 'OUTPUT2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-08-17 11:05:50', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list2)a', 'mnu_task(pdf)', '005', 'Output to PDF(L)', 'N', '2006-09-25 15:07:39', 'AJM', '2007-09-10 14:46:07', 'AJM'),
('mnu_task(list2)b', 'mnu_task(pdf)', '005', 'Output to PDF(L)', 'N', '2006-09-25 15:08:41', 'AJM', '2007-09-10 14:48:19', 'AJM'),
('mnu_task(list1)b', 'mnu_task(pdf)', '014', 'Output to PDF(L)', 'N', '2006-08-17 11:07:01', 'AJM', '2007-09-10 14:35:53', 'AJM'),
('mnu_task(list1)a', 'mnu_task(pdf)', '018', 'Output to PDF(L)', 'N', '2006-08-17 11:06:49', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)', 'mnu_task(pdf)', '021', 'Output to PDF(L)', 'N', '2006-08-17 11:06:09', 'AJM', '2007-09-10 14:30:48', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(pdf)', '2006-08-18 13:24:37', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(pdf)2', 'Output to PDF - Detail view', 'Output to PDF(D)', 'PROC', 'mnu_task(pdf)2.php', 'N', 'OUTPUT3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-08-17 11:33:23', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)b', 'mnu_task(pdf)2', '015', 'Output to PDF(D)', 'N', '2006-08-17 11:34:07', 'AJM', '2007-09-10 14:35:53', 'AJM'),
('mnu_task(list1)a', 'mnu_task(pdf)2', '019', 'Output to PDF(D)', 'N', '2006-08-17 11:33:55', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)', 'mnu_task(pdf)2', '022', 'Output to PDF(D)', 'N', '2006-08-17 11:33:44', 'AJM', '2007-09-10 14:30:48', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(pdf)2', '2006-08-18 13:24:52', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(pdf)3', 'Output to PDF - Navigation Buttons', 'Nav Buttons (PDF)', 'PROC', 'mnu_task(pdf)3.php', 'N', 'OUTPUT3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-08-27 21:57:58', 'AJM', '2006-08-27 22:00:30', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)a', 'mnu_task(pdf)3', '020', 'Nav Buttons (PDF)', 'N', '2006-08-27 21:59:03', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)', 'mnu_task(pdf)3', '023', 'Nav Buttons (PDF)', 'N', '2006-08-27 21:58:48', 'AJM', '2007-09-10 14:30:48', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(pdf)3', '2006-08-27 22:45:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(popup1)', 'Choose Task', 'Choose', 'PROC', 'mnu_task(popup1).php', 'N', 'POPUP1', 'MENU', NULL, NULL, NULL, 'select_one=FALSE', 'task_id', 'Y', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:58:15', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(popup1)', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:58:15', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(popup1)', '2005-04-19 18:12:30', 'AJM', '2007-09-10 14:58:15', 'AJM'),
('READONLY', 'mnu_task(popup1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:58:15', 'AJM'),
('SURVEY', 'mnu_task(popup1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:58:15', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(popup1)a', 'Choose Task (proc)', 'Choose', 'PROC', 'mnu_task(popup1).php', 'N', 'POPUP1', 'MENU', NULL, 'task_type=\'PROC\'', NULL, 'select_one=FALSE', 'task_id', 'Y', 'N', NULL, 'N', '2004-08-12 15:43:07', 'AJM', '2007-09-10 14:59:10', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(popup1)a', 'mnu_task(search)', '001', 'Search', 'N', '2004-08-26 12:00:46', 'AJM', '2007-09-10 14:59:10', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(popup1)a', '2005-04-19 18:12:30', 'AJM', '2007-09-10 14:59:10', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(popup1)b', 'Choose Task (menu)', 'Choose', 'PROC', 'mnu_task(popup1).php', 'N', 'POPUP1', 'MENU', NULL, 'task_type=\'MENU\'', NULL, 'select_one=TRUE', 'task_id', 'Y', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:59:46', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(popup1)b', 'mnu_task(search)', '001', 'Search', 'N', '2007-10-13 13:33:24', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(popup1)b', '2005-04-19 18:12:30', 'AJM', '2007-09-10 14:59:45', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(rename)', 'Rename Task', 'Rename', 'PROC', 'mnu_task(upd2).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:02:13', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)b', 'mnu_task(rename)', '011', 'Rename', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM'),
('mnu_task(list1)a', 'mnu_task(rename)', '016', 'Rename', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)', 'mnu_task(rename)', '019', 'Rename', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(search)', 'Search Task', 'Search', 'PROC', 'mnu_task(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:50:51', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(link1)', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 17:28:00', 'AJM'),
('mnu_initial_value_role(multi3)b', 'mnu_task(search)', '001', 'Search', 'N', '2007-05-05 22:41:52', 'AJM', NULL, NULL),
('mnu_role_taskfield(multi3)b', 'mnu_task(search)', '001', 'Search Task', 'N', '2007-02-09 12:03:36', 'AJM', '2007-09-10 11:30:42', 'AJM'),
('mnu_task(popup1)a', 'mnu_task(search)', '001', 'Search', 'N', '2004-08-26 12:00:46', 'AJM', '2007-09-10 14:59:10', 'AJM'),
('mnu_task(popup1)', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:58:15', 'AJM'),
('mnu_task(popup1)b', 'mnu_task(search)', '001', 'Search', 'N', '2007-10-13 13:33:24', 'AJM', NULL, NULL),
('mnu_task(list2)b', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:48:18', 'AJM'),
('mnu_task(list2)a', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:46:07', 'AJM'),
('mnu_role_task(link1)b', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:20:38', 'AJM'),
('mnu_nav_button(link1)', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-08-12 11:16:40', 'AJM'),
('mnu_task(list1)b', 'mnu_task(search)', '012', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:53', 'AJM'),
('mnu_task(list1)a', 'mnu_task(search)', '017', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('mnu_task(list1)', 'mnu_task(search)', '020', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(search)', '2005-04-19 18:12:30', 'AJM', NULL, NULL),
('READONLY', 'mnu_task(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_task(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(upd1)', 'Update Task', 'Update', 'PROC', 'mnu_task(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 14:55:16', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list1)', 'mnu_task(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:55:16', 'AJM'),
('mnu_task(list1)a', 'mnu_task(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:55:16', 'AJM'),
('mnu_task(list1)b', 'mnu_task(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:55:16', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(add1)', 'Add ToDo', 'New', 'PROC', 'mnu_todo(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2005-07-30 17:55:07', 'AJM', '2007-09-10 15:06:43', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(list1)', 'mnu_todo(add1)', '001', 'New', 'N', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:11:15', 'AJM'),
('mnu_todo(list2)', 'mnu_todo(add1)', '001', 'New', 'N', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:12:37', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_todo(add1)', '2005-07-31 16:30:15', 'AJM', '2007-09-10 15:06:42', 'AJM'),
('DEV', 'mnu_todo(add1)', '2005-07-31 16:30:31', 'AJM', '2007-09-10 15:06:42', 'AJM'),
('READONLY', 'mnu_todo(add1)', '2005-07-31 16:30:52', 'AJM', '2007-09-10 15:06:42', 'AJM'),
('SURVEY', 'mnu_todo(add1)', '2005-07-31 16:31:01', 'AJM', '2007-09-10 15:06:42', 'AJM'),
('USER1', 'mnu_todo(add1)', '2005-07-31 16:31:17', 'AJM', '2007-09-10 15:06:43', 'AJM'),
('USER2', 'mnu_todo(add1)', '2005-07-31 16:31:24', 'AJM', '2007-09-10 15:06:43', 'AJM'),
('USER3', 'mnu_todo(add1)', '2005-07-31 16:31:30', 'AJM', '2007-09-10 15:06:43', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(del1)', 'Delete ToDo', 'Delete', 'PROC', 'mnu_todo(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2005-07-30 17:55:33', 'AJM', '2007-09-10 15:08:08', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(list1)', 'mnu_todo(del1)', '005', 'Delete', 'Y', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:11:15', 'AJM'),
('mnu_todo(list2)', 'mnu_todo(del1)', '005', 'Delete', 'Y', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:12:37', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_todo(del1)', '2005-07-31 16:30:15', 'AJM', '2007-09-10 15:08:08', 'AJM'),
('DEV', 'mnu_todo(del1)', '2005-07-31 16:30:31', 'AJM', '2007-09-10 15:08:08', 'AJM'),
('READONLY', 'mnu_todo(del1)', '2005-07-31 16:30:53', 'AJM', '2007-09-10 15:08:08', 'AJM'),
('SURVEY', 'mnu_todo(del1)', '2005-07-31 16:31:01', 'AJM', '2007-09-10 15:08:08', 'AJM'),
('USER1', 'mnu_todo(del1)', '2005-07-31 16:31:17', 'AJM', '2007-09-10 15:08:08', 'AJM'),
('USER2', 'mnu_todo(del1)', '2005-07-31 16:31:24', 'AJM', '2007-09-10 15:08:08', 'AJM'),
('USER3', 'mnu_todo(del1)', '2005-07-31 16:31:30', 'AJM', '2007-09-10 15:08:08', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(enq1)', 'Enquire ToDo', 'Read', 'PROC', 'mnu_todo(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2005-07-30 17:56:00', 'AJM', '2007-09-10 15:09:07', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(list1)', 'mnu_todo(enq1)', '003', 'Read', 'Y', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:11:15', 'AJM'),
('mnu_todo(list2)', 'mnu_todo(enq1)', '003', 'Read', 'Y', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:12:37', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_todo(enq1)', '2005-07-31 16:30:15', 'AJM', '2007-09-10 15:09:06', 'AJM'),
('DEV', 'mnu_todo(enq1)', '2005-07-31 16:30:31', 'AJM', '2007-09-10 15:09:06', 'AJM'),
('READONLY', 'mnu_todo(enq1)', '2005-07-31 16:30:53', 'AJM', '2007-09-10 15:09:06', 'AJM'),
('SURVEY', 'mnu_todo(enq1)', '2005-07-31 16:31:01', 'AJM', '2007-09-10 15:09:06', 'AJM'),
('USER1', 'mnu_todo(enq1)', '2005-07-31 16:31:17', 'AJM', '2007-09-10 15:09:07', 'AJM'),
('USER2', 'mnu_todo(enq1)', '2005-07-31 16:31:24', 'AJM', '2007-09-10 15:09:07', 'AJM'),
('USER3', 'mnu_todo(enq1)', '2005-07-31 16:31:30', 'AJM', '2007-09-10 15:09:07', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(list1)', 'List ToDo', 'ToDo', 'PROC', 'mnu_todo(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, 'is_complete=\'N\'', NULL, NULL, 'Y', 'N', NULL, 'N', '2005-07-30 17:54:29', 'AJM', '2007-09-10 15:11:15', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(list1)', 'mnu_todo(add1)', '001', 'New', 'N', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:11:15', 'AJM'),
('mnu_todo(list1)', 'mnu_todo(search)', '002', 'Search', 'N', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:11:15', 'AJM'),
('mnu_todo(list1)', 'mnu_todo(enq1)', '003', 'Read', 'Y', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:11:15', 'AJM'),
('mnu_todo(list1)', 'mnu_todo(upd1)', '004', 'Update', 'Y', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:15:51', 'AJM'),
('mnu_todo(list1)', 'mnu_todo(del1)', '005', 'Delete', 'Y', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:11:15', 'AJM'),
('mnu_todo(list1)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2005-07-30 19:32:15', 'AJM', '2007-09-10 15:11:15', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_todo(list1)', '2006-04-07 17:31:01', 'AJM', '2007-09-10 15:11:15', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(list2)', 'List ToDo by User', 'ToDo', 'PROC', 'mnu_todo(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, 'is_complete=\'N\'', NULL, NULL, 'N', 'N', NULL, 'N', '2005-07-30 19:17:53', 'AJM', '2007-09-10 15:12:37', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(list2)', 'mnu_todo(add1)', '001', 'New', 'N', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:12:37', 'AJM'),
('mnu_todo(list2)', 'mnu_todo(search)', '002', 'Search', 'N', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:12:37', 'AJM'),
('mnu_todo(list2)', 'mnu_todo(enq1)', '003', 'Read', 'Y', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:12:37', 'AJM'),
('mnu_todo(list2)', 'mnu_todo(upd1)', '004', 'Update', 'Y', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:15:51', 'AJM'),
('mnu_todo(list2)', 'mnu_todo(del1)', '005', 'Delete', 'Y', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:12:37', 'AJM'),
('mnu_todo(list2)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2005-07-30 19:32:02', 'AJM', '2007-09-10 15:12:37', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('menu', 'mnu_todo(list2)', '001', 'ToDo', 'N', '2005-07-31 15:35:03', 'AJM', '2007-09-10 15:12:37', 'AJM'),
('mnu_user(list1)', 'mnu_todo(list2)', '007', 'ToDo', 'Y', '2005-07-30 19:18:31', 'AJM', '2007-09-10 15:25:13', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_todo(list2)', '2005-07-31 16:30:15', 'AJM', '2007-09-10 15:12:37', 'AJM'),
('DEV', 'mnu_todo(list2)', '2005-07-31 16:30:31', 'AJM', '2007-09-10 15:12:37', 'AJM'),
('READONLY', 'mnu_todo(list2)', '2005-07-31 16:30:53', 'AJM', '2007-09-10 15:12:37', 'AJM'),
('SURVEY', 'mnu_todo(list2)', '2005-07-31 16:31:01', 'AJM', '2007-09-10 15:12:37', 'AJM'),
('USER1', 'mnu_todo(list2)', '2005-07-31 16:31:17', 'AJM', '2007-09-10 15:12:37', 'AJM'),
('USER2', 'mnu_todo(list2)', '2005-07-31 16:31:24', 'AJM', '2007-09-10 15:12:37', 'AJM'),
('USER3', 'mnu_todo(list2)', '2005-07-31 16:31:30', 'AJM', '2007-09-10 15:12:37', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(search)', 'Search ToDo', 'Search', 'PROC', 'mnu_todo(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2005-07-30 17:56:31', 'AJM', '2007-09-10 15:12:59', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(list1)', 'mnu_todo(search)', '002', 'Search', 'N', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:11:15', 'AJM'),
('mnu_todo(list2)', 'mnu_todo(search)', '002', 'Search', 'N', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:12:37', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_todo(search)', '2005-07-31 16:30:15', 'AJM', NULL, NULL),
('DEV', 'mnu_todo(search)', '2005-07-31 16:30:31', 'AJM', NULL, NULL),
('READONLY', 'mnu_todo(search)', '2005-07-31 16:30:53', 'AJM', NULL, NULL),
('SURVEY', 'mnu_todo(search)', '2005-07-31 16:31:01', 'AJM', NULL, NULL),
('USER1', 'mnu_todo(search)', '2005-07-31 16:31:17', 'AJM', NULL, NULL),
('USER2', 'mnu_todo(search)', '2005-07-31 16:31:24', 'AJM', NULL, NULL),
('USER3', 'mnu_todo(search)', '2005-07-31 16:31:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(upd1)', 'Update ToDo', 'Update', 'PROC', 'mnu_todo(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2005-07-30 17:57:00', 'AJM', '2007-09-10 15:15:51', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(list1)', 'mnu_todo(upd1)', '004', 'Update', 'Y', '2005-07-30 17:57:41', 'AJM', '2007-09-10 15:15:51', 'AJM'),
('mnu_todo(list2)', 'mnu_todo(upd1)', '004', 'Update', 'Y', '2005-07-30 19:31:31', 'AJM', '2007-09-10 15:15:51', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_todo(upd1)', '2005-07-31 16:30:15', 'AJM', '2007-09-10 15:15:51', 'AJM'),
('DEV', 'mnu_todo(upd1)', '2005-07-31 16:30:31', 'AJM', '2007-09-10 15:15:51', 'AJM'),
('READONLY', 'mnu_todo(upd1)', '2005-07-31 16:30:53', 'AJM', '2007-09-10 15:15:51', 'AJM'),
('SURVEY', 'mnu_todo(upd1)', '2005-07-31 16:31:01', 'AJM', '2007-09-10 15:15:51', 'AJM'),
('USER1', 'mnu_todo(upd1)', '2005-07-31 16:31:17', 'AJM', '2007-09-10 15:15:51', 'AJM'),
('USER2', 'mnu_todo(upd1)', '2005-07-31 16:31:24', 'AJM', '2007-09-10 15:15:51', 'AJM'),
('USER3', 'mnu_todo(upd1)', '2005-07-31 16:31:30', 'AJM', '2007-09-10 15:15:51', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(add1)', 'Add User', 'Insert', 'PROC', 'mnu_user(add1).php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 15:18:35', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(list1)', 'mnu_user(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM');

REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(add1)', 'EMAIL_ADDR', '2007-05-27 16:50:38', 'AJM', '2007-09-10 15:18:35', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(del1)', 'Delete User', 'Delete', 'PROC', 'mnu_user(del1).php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 15:22:17', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(list1)', 'mnu_user(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM');

REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(del1)', 'USER_PASSWORD', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:22:17', 'AJM');

REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_user(del1)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:22:16', 'AJM'),
('READONLY', 'mnu_user(del1)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:22:17', 'AJM'),
('SURVEY', 'mnu_user(del1)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:22:17', 'AJM'),
('USER1', 'mnu_user(del1)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:22:17', 'AJM'),
('USER2', 'mnu_user(del1)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:22:17', 'AJM'),
('USER3', 'mnu_user(del1)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:22:17', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(enq1)', 'Enquire User', 'Enquire', 'PROC', 'mnu_user(enq1).php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 15:23:14', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(list1)', 'mnu_user(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM');

REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(enq1)', 'DUMMY1', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:23:14', 'AJM'),
('mnu_user(enq1)', 'USER_PASSWORD', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:23:14', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_user(enq1)', '2005-04-19 18:12:42', 'AJM', '2007-09-10 15:23:14', 'AJM'),
('READONLY', 'mnu_user(enq1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:23:14', 'AJM'),
('SURVEY', 'mnu_user(enq1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:23:14', 'AJM');

REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_user(enq1)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:23:14', 'AJM'),
('READONLY', 'mnu_user(enq1)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:23:14', 'AJM'),
('SURVEY', 'mnu_user(enq1)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:23:14', 'AJM'),
('USER1', 'mnu_user(enq1)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:23:14', 'AJM'),
('USER2', 'mnu_user(enq1)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:23:14', 'AJM'),
('USER3', 'mnu_user(enq1)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:23:14', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(list1)', 'List User', 'List User', 'PROC', 'mnu_user(list1).php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, 'user_id', 'Y', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 15:25:14', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(list1)', 'mnu_user(add1)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM'),
('mnu_user(list1)', 'mnu_user(enq1)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM'),
('mnu_user(list1)', 'mnu_user(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:31:43', 'AJM'),
('mnu_user(list1)', 'mnu_user(del1)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM'),
('mnu_user(list1)', 'mnu_user(upd1)a', '005', 'Change Password', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:35:45', 'AJM'),
('mnu_user(list1)', 'mnu_user(upd1)b', '006', 'Reset Password', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:37:19', 'AJM'),
('mnu_user(list1)', 'mnu_todo(list2)', '007', 'ToDo', 'Y', '2005-07-30 19:18:31', 'AJM', '2007-09-10 15:25:13', 'AJM'),
('mnu_user(list1)', 'mnu_initial_value_user(multi3)b', '008', 'Initial Values', 'Y', '2007-05-27 10:44:10', 'AJM', '2007-09-10 15:25:13', 'AJM'),
('mnu_user(list1)', 'mnu_user(search)', '009', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM'),
('mnu_user(list1)', 'mnu_user(pdf)', '010', 'Output to PDF(L)', 'N', '2006-08-17 19:01:45', 'AJM', '2007-09-10 15:25:13', 'AJM'),
('mnu_user(list1)', 'audit_dtl(list)3', '011', 'Audit Trail', 'Y', '2004-04-09 11:39:20', 'AJM', '2007-09-10 15:25:13', 'AJM');

REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(list1)', 'EMAIL_ADDR', '2007-05-27 18:00:16', 'AJM', '2007-09-10 15:25:14', 'AJM'),
('mnu_user(list1)', 'USER_PASSWORD', '2006-02-09 18:34:46', 'AJM', '2007-09-10 15:25:14', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_user(list1)', '2006-02-09 18:15:24', 'AJM', '2007-09-10 15:25:13', 'AJM'),
('READONLY', 'mnu_user(list1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM'),
('SURVEY', 'mnu_user(list1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM'),
('USER3', 'mnu_user(list1)', '2005-07-31 15:17:14', 'AJM', '2007-09-10 15:25:13', 'AJM');

REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_user(list1)', 'USER_PASSWORD', 'NDI', '2006-02-09 18:37:14', 'AJM', '2007-09-10 15:25:13', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(list2)', 'List User by Role', 'List User', 'PROC', 'mnu_user(list2).php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, 'user_id', 'N', 'N', NULL, 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:27:06', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(list2)', 'audit_dtl(list)3', '001', 'Audit Trail', 'Y', '2004-04-09 11:59:34', 'AJM', '2007-09-10 15:27:06', 'AJM'),
('mnu_user(list2)', 'mnu_initial_value_user(multi3)b', '002', 'Initial Values', 'Y', '2007-05-27 10:45:41', 'AJM', '2007-09-10 15:27:06', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(list1)', 'mnu_user(list2)', '005', 'List User', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:27:06', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_user(list2)', '2006-04-07 17:30:42', 'AJM', '2007-09-10 15:27:06', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(pdf)', 'Output to PDF - List view', 'Output to PDF(L)', 'PROC', 'mnu_user(pdf).php', 'N', 'OUTPUT2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-08-17 19:01:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(list1)', 'mnu_user(pdf)', '010', 'Output to PDF(L)', 'N', '2006-08-17 19:01:45', 'AJM', '2007-09-10 15:25:13', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_user(pdf)', '2006-08-18 13:24:37', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(popup1)', 'Choose User', 'Choose', 'PROC', 'mnu_user(popup1).php', 'N', 'POPUP1', 'MENU', NULL, NULL, NULL, NULL, 'user_id', 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 15:28:55', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_user(popup1)', '2005-04-19 18:12:42', 'AJM', '2007-09-10 15:28:55', 'AJM'),
('SURVEY', 'mnu_user(popup1)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:28:55', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(search)', 'Search User', 'Search', 'PROC', 'mnu_user(search).php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 15:30:18', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(list1)', 'mnu_user(search)', '009', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_user(search)', '2005-04-19 18:12:42', 'AJM', NULL, NULL),
('READONLY', 'mnu_user(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_user(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(upd1)', 'Update User', 'Update', 'PROC', 'mnu_user(upd1).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2004-01-01 00:00:00', 'AJM', '2007-09-10 15:31:44', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(list1)', 'mnu_user(upd1)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:31:43', 'AJM');

REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(upd1)', 'DUMMY1', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:31:43', 'AJM'),
('mnu_user(upd1)', 'DUMMY2', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:31:43', 'AJM'),
('mnu_user(upd1)', 'DUMMY3', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:31:44', 'AJM'),
('mnu_user(upd1)', 'DUMMY4', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:31:44', 'AJM'),
('mnu_user(upd1)', 'USER_PASSWORD', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:31:44', 'AJM');

REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('SURVEY', 'mnu_user(upd1)', 'DUMMY1', 'FULL', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:31:43', 'AJM'),
('SURVEY', 'mnu_user(upd1)', 'DUMMY2', 'NED', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:31:43', 'AJM'),
('GLOBAL', 'mnu_user(upd1)', 'USER_PASSWORD', 'FULL', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:31:43', 'AJM'),
('READONLY', 'mnu_user(upd1)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:31:43', 'AJM'),
('SURVEY', 'mnu_user(upd1)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:31:43', 'AJM'),
('USER1', 'mnu_user(upd1)', 'USER_PASSWORD', 'FULL', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:31:43', 'AJM'),
('USER2', 'mnu_user(upd1)', 'USER_PASSWORD', 'FULL', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:31:43', 'AJM'),
('USER3', 'mnu_user(upd1)', 'USER_PASSWORD', 'FULL', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:31:43', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(upd1)a', 'Change User Password', 'Change Password', 'PROC', 'mnu_user(upd1)a.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2007-09-10 15:35:45', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('menu', 'mnu_user(upd1)a', '002', 'Change Password', 'N', '2006-02-23 10:51:20', 'AJM', '2007-09-10 15:35:45', 'AJM'),
('mnu_user(list1)', 'mnu_user(upd1)a', '005', 'Change Password', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:35:45', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('USER3', 'mnu_user(upd1)a', '2005-07-31 15:17:36', 'AJM', '2007-09-10 15:35:45', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(upd1)b', 'Reset User Password', 'Reset Password', 'PROC', 'mnu_user(upd1)b.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'Y', '2004-01-01 00:00:00', 'AJM', '2007-09-10 15:37:20', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(list1)', 'mnu_user(upd1)b', '006', 'Reset Password', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:37:19', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('READONLY', 'mnu_user(upd1)b', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:37:19', 'AJM'),
('SURVEY', 'mnu_user(upd1)b', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:37:20', 'AJM'),
('USER1', 'mnu_user(upd1)b', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:37:20', 'AJM'),
('USER2', 'mnu_user(upd1)b', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:37:20', 'AJM'),
('USER3', 'mnu_user(upd1)b', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:37:20', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(upd1)c', 'Retrieve User Password', 'Retrieve Password', 'PROC', 'mnu_user(upd1)c.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, 'N', '2006-04-23 11:39:09', 'AJM', '2007-09-10 15:33:47', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `pattern_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `use_https`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('applications', 'Applications', 'APPL', 'MENU', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, NULL, '2005-05-05 17:45:29', 'AJM', '2007-07-06 14:47:09', 'AJM'),
('main_menu', 'Main index page', 'Menu1', 'MENU', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', NULL, NULL),
('menu01', 'Menu System', 'Menu System', 'MENU', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, 'N', '2004-01-01 00:00:00', 'AJM', NULL, NULL),
('proto', 'Prototypes', 'PROTO', 'MENU', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, NULL, '2007-07-09 23:09:13', 'AJM', NULL, NULL);

REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('main_menu', 'menu01', '001', 'Menu System', '2004-09-08 18:07:24', 'AJM', '2004-09-08 18:07:33', 'AJM'),
('main_menu', 'applications', '005', 'Applications', '2005-05-05 17:46:59', 'AJM', '2007-07-06 14:47:50', 'AJM'),
('main_menu', 'proto', '006', 'PROTO', '2007-07-09 23:10:08', 'AJM', NULL, NULL),
('menu01', 'mnu_control(upd3)', '001', 'Menu Controls', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:44:32', 'AJM'),
('menu01', 'mnu_pattern(list1)', '002', 'Pattern', '2003-01-01 12:00:00', 'AJM', '2007-09-10 10:55:34', 'AJM'),
('menu01', 'mnu_subsystem(list1)', '003', 'Subsystem', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:01:47', 'AJM'),
('menu01', 'mnu_task(list1)', '004', 'Task (All)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:30:47', 'AJM'),
('menu01', 'mnu_task(list1)a', '005', 'Task (Proc)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:24', 'AJM'),
('menu01', 'mnu_task(list1)b', '006', 'Task (Menu)', '2003-01-01 12:00:00', 'AJM', '2007-09-10 14:35:52', 'AJM'),
('menu01', 'mnu_role(list1)', '007', 'Role', '2003-01-01 12:00:00', 'AJM', '2007-09-10 11:41:47', 'AJM'),
('menu01', 'mnu_user(list1)', '008', 'User', '2003-01-01 12:00:00', 'AJM', '2007-09-10 15:25:13', 'AJM'),
('menu01', 'mnu_todo(list1)', '009', 'ToDo', '2005-07-30 17:59:41', 'AJM', '2007-09-10 15:11:15', 'AJM'),
('menu01', 'mnu_account(list1)', '010', 'Hosting Account', '2007-09-13 11:37:37', 'AJM', NULL, NULL);

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('logon', 'Welcome to the RADICORE Menu & Security system.

You must enter a valid user id and password before you can continue any further.

The password field is case-sensitive, so watch out for the \'caps lock\' key.

Refer to <a href=\"%root%/mnu_logon.html\">Logon screen</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-05-08 10:31:18', 'AJM'),
('menu', 'This is the first page the user sees after passing through the logon screen. It is also the page that is shown whenever the user selects an option from the menu bar instead of the navigation bar.

Refer to <a href=\"%root%/mnu_menu.html\">Menu/Home Page</a> for full details.', '2005-07-02 18:09:35', 'AJM', NULL, NULL),
('mnu_control(upd3)', 'This will allow global settings on the MENU CONTROL table to be changed.

Refer to <a href=\"%root%/mnu_control(upd3).html\">Update Menu Control data</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 18:27:24', 'AJM'),
('mnu_help_text(multi1)', 'This will allow the contents of the HELP TEXT table to be maintained.

Refer to <a href=\"%root%/mnu_help_text(multi1).html\">Maintain Help Text</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 18:36:51', 'AJM'),
('mnu_initial_value_role(multi3)a', 'This will allow the contents of the INITIAL_VALUE_ROLE table to be maintained for a particular task.

These values are used during the creation of new records.

Refer to <a href=\"%root%/mnu_initial_value_role(multi3)a.html\">Maintain Initial Values (Role) by Task</a> for full details.', '2007-05-08 10:34:16', 'AJM', '2007-05-27 22:01:24', 'AJM'),
('mnu_initial_value_role(multi3)b', 'This will allow the contents of the INITIAL_VALUE_ROLE table to be maintained for a particular task.

These values are used during the creation of new records.

Refer to <a href=\"%root%/mnu_initial_value_role(multi3)b.html\">Maintain Initial Values by Task</a> for full details.', '2007-05-08 10:34:37', 'AJM', '2007-05-27 22:02:19', 'AJM'),
('mnu_initial_value_user(multi3)a', 'This will allow the contents of the INITIAL_VALUE_USER table to be maintained for a particular task.

These values are used during the creation of new records.

Refer to <a href=\"%root%/mnu_initial_value_user(multi3)a.html\">Maintain Initial Values (User) by Task</a> for full details.', '2007-05-27 22:01:13', 'AJM', '2007-05-27 22:02:31', 'AJM'),
('mnu_initial_value_user(multi3)b', 'This will allow the contents of the INITIAL_VALUE_USER table to be maintained for a particular task.

These values are used during the creation of new records.

Refer to <a href=\"%root%/mnu_initial_value_user(multi3)b.html\">Maintain Initial Values by User</a> for full details.', '2007-05-27 22:03:03', 'AJM', '2007-09-10 19:09:23', 'AJM'),
('mnu_menu(link1)', 'This will display the contents of the MENU table for a selected task of type \'menu\'.

Refer to <a href=\"%root%/mnu_menu(link1).html\">Maintain Menu Items (2)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-08-12 22:03:34', 'AJM'),
('mnu_menu(list2)', 'This will list records on the MENU table for a selected Task of type \'menu\'.

Refer to <a href=\"%root%/mnu_menu(list2).html\">List Menu Items</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-08-12 22:03:47', 'AJM'),
('mnu_menu(list2)a', 'This will list parent records on the MENU table for a selected Task of type \'menu\'.

Refer to <a href=\"%root%/mnu_menu(list2)a.html\">List Menu Parents</a> for full details.', '2007-08-12 22:04:22', 'AJM', NULL, NULL),
('mnu_menu(multi2)', 'This will display the contents of the MENU table for a selected task of type \'menu\'. 

Refer to <a href=\"%root%/mnu_menu(multi2).html\">Maintain Menu Items (1)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-08-12 22:04:31', 'AJM'),
('mnu_menu(search)', 'This will allow search criteria to be entered for the MENU table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_menu(search).html\">Search Menu Items</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:25:28', 'AJM'),
('mnu_menu(upd1)', 'This will display the contents of a record from the MENU table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_menu(upd1).html\">Update Menu Item</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-08-12 22:04:46', 'AJM'),
('mnu_nav_button(link1)', 'This will display the contents of the NAVIGATION BUTTON table for a selected Task. Each of these will appear in the navigation bar area for the seected task.

Refer to <a href=\"%root%/mnu_nav_button(link1).html\">Maintain Navigation Buttons (2)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-08-12 18:24:09', 'AJM'),
('mnu_nav_button(list2)', 'This will list records on the NAVIGATION BUTTON table for a selected TASK.

Refer to <a href=\"%root%/mnu_nav_button(list2).html\">List Navigation Buttons</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-08-12 18:25:12', 'AJM'),
('mnu_nav_button(list2)a', 'This will list parent records on the NAVIGATION BUTTON table for a selected TASK.

Refer to <a href=\"%root%/mnu_nav_button(list2)a.html\">List Navigation Button Parents</a> for full details.', '2007-08-12 18:27:39', 'AJM', '2007-08-12 22:05:13', 'AJM'),
('mnu_nav_button(multi2)', 'This will display the contents of the NAVIGATION BUTTON table for a selected task. 

Refer to <a href=\"%root%/mnu_nav_button(multi2).html\">Maintain Navigation Buttons (1)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-08-12 18:25:59', 'AJM'),
('mnu_nav_button(search)', 'This will allow search criteria to be entered for the NAVIGATION BUTTON table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_nav_button(search).html\">Search Navigation Button</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:26:26', 'AJM'),
('mnu_nav_button(upd1)', 'This will display the contents of a record from the NAVIGATION BUTTON table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_nav_button(upd1).html\">Update Navigation Button</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-08-12 18:26:40', 'AJM'),
('mnu_pattern(add1)', 'This will allow a new record to be added to the PATTERN table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_pattern(add1).html\">Add Pattern</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 19:11:33', 'AJM'),
('mnu_pattern(del1)', 'This will display a record from the PATTERN table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_pattern(del1).html\">Delete Pattern</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 19:14:33', 'AJM'),
('mnu_pattern(enq1)', 'This will display the contents of a record from the PATTERN table.

Refer to <a href=\"%root%/mnu_pattern(enq1).html\">Enquire Pattern</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 19:18:32', 'AJM'),
('mnu_pattern(list1)', 'This will list records on the PATTERN table.

Refer to <a href=\"%root%/mnu_pattern(list1).html\">List Pattern</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 19:21:57', 'AJM'),
('mnu_pattern(search)', 'This will allow search criteria to be entered for the PATTERN table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_pattern(search).html\">Search Pattern</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2006-03-27 23:49:34', 'AJM'),
('mnu_pattern(upd1)', 'This will display the contents of a record from the PATTERN table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_pattern(upd1).html\">Update Pattern</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 19:36:56', 'AJM'),
('mnu_role_task(link1)a', 'This will display the contents of the ROLE TASK table for a selected task and allow updates to be made.

Refer to <a href=\"%root%/mnu_role_task(link1)a.html\">Link Role(s) to selected task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 19:41:50', 'AJM'),
('mnu_role_task(link1)b', 'This will display the contents of the ROLE TASK table for a selected role and allow updates to be made.

Refer to <a href=\"%root%/mnu_role_task(link1)b.html\">Link Task(s) to selected Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 19:46:57', 'AJM'),
('mnu_role_taskfield(multi3)a', 'This will show the contents of the ROLE TASK FIELD table for a selected Task and allow changes to be made.

Refer to <a href=\"%root%/mnu_role_taskfield(multi3)a.html\">Maintain Field Access via Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 19:50:38', 'AJM'),
('mnu_role_taskfield(multi3)b', 'This will show the contents of the ROLE TASK FIELD table for a selected Role and allow changes to be made.

Refer to <a href=\"%root%/mnu_role_taskfield(multi3)b.html\">Maintain Field Access via Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 19:58:37', 'AJM'),
('mnu_role(add1)', 'This will allow a new record to be added to the ROLE table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_role(add1).html\">Add Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 20:04:05', 'AJM'),
('mnu_role(del1)', 'This will display a record from the ROLE table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_role(del1).html\">Delete Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 20:07:17', 'AJM'),
('mnu_role(enq1)', 'This will display the contents of a record from the ROLE table.

Refer to <a href=\"%root%/mnu_role(enq1).html\">Enquire Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 20:11:42', 'AJM'),
('mnu_role(list1)', 'This will list records on the ROLE table.

Refer to <a href=\"%root%/mnu_role(list1).html\">List Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 20:15:54', 'AJM'),
('mnu_role(popup1)', 'This will list records on the ROLE table and allow one or more to be selected.

After selecting records please press the CHOOSE button.

Refer to <a href=\"%root%/mnu_role(popup1).html\">Choose Role</a> for full details.', '2004-08-26 14:08:25', 'AJM', '2007-09-10 20:23:41', 'AJM'),
('mnu_role(search)', 'This will allow search criteria to be entered for the ROLE table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_role(search).html\">Search Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:27:09', 'AJM'),
('mnu_role(upd1)', 'This will display the contents of a record from the ROLE table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_role(upd1).html\">Update Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 20:26:54', 'AJM'),
('mnu_session(upd3)', 'This will allow certain settings which are being used within the current session to be changed.

Refer to <a href=\"%root%/mnu_session(upd3).html\">Update Session data</a> for full details.', '2006-04-07 11:22:29', 'AJM', '2007-09-10 20:30:38', 'AJM'),
('mnu_subsystem(add1)', 'This will allow a new record to be added to the SUBSYSTEM table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_subsystem(add1).html\">Add Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 20:36:01', 'AJM'),
('mnu_subsystem(del1)', 'This will display a record from the SUBSYSTEM table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_subsystem(del1).html\">Delete Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 20:38:21', 'AJM'),
('mnu_subsystem(enq1)', 'This will display the contents of a record from the SUBSYSTEM table.

Refer to <a href=\"%root%/mnu_subsystem(enq1).html\">Enquire Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 20:41:03', 'AJM'),
('mnu_subsystem(list1)', 'This will list records on the SUBSYSTEM table.

Refer to <a href=\"%root%/mnu_subsystem(list1).html\">List Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 20:44:13', 'AJM'),
('mnu_subsystem(search)', 'This will allow search criteria to be entered for the SUBSYSTEM table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_subsystem(search).html\">Search Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:28:32', 'AJM'),
('mnu_subsystem(upd1)', 'This will display the contents of a record from the SUBSYSTEM table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_subsystem(upd1).html\">Update Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 20:49:36', 'AJM'),
('mnu_task_field(add2)', 'This will allow a record to be added to the TASK FIELD table for a selected TASK.

Refer to <a href=\"%root%/mnu_task_field(add2).html\">Add Task Field</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 21:04:25', 'AJM'),
('mnu_task_field(del1)', 'This will display a record from the TASK FIELD table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_task_field(del1).html\">Delete Task Field</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 21:09:48', 'AJM'),
('mnu_task_field(list2)', 'This will list records on the TASK FIELD table for a selected TASK.

Refer to <a href=\"%root%/mnu_task_field(list2).html\">List Task Field</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 21:14:06', 'AJM'),
('mnu_task(add1)', 'This will allow a new record to be added to the TASK table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_task(add1).html\">Add Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 21:19:53', 'AJM'),
('mnu_task(del1)', 'This will display a record from the TASK table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_task(del1).html\">Delete Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 21:23:13', 'AJM'),
('mnu_task(enq1)', 'This will display the contents of a record from the TASK table.

Refer to <a href=\"%root%/mnu_task(enq1).html\">Enquire Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 21:26:40', 'AJM'),
('mnu_task(list1)', 'This will list records on the TASK table regardless of their TASK-TYPE.

Refer to <a href=\"%root%/mnu_task(list1).html\">List Task (All)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 21:30:01', 'AJM'),
('mnu_task(list1)a', 'This will list records on the TASK table where type = \'TASK\'.

Refer to <a href=\"%root%/mnu_task(list1)a.html\">List Task (Proc)</a> for full details.', '2004-08-26 12:07:32', 'AJM', '2007-09-10 21:42:06', 'AJM'),
('mnu_task(list1)b', 'This will list records on the TASK table where type = \'MENU\'.

Refer to <a href=\"%root%/mnu_task(list1)b.html\">List Task (Menu)</a> for full details.', '2004-08-26 12:07:39', 'AJM', '2007-09-10 21:46:39', 'AJM'),
('mnu_task(list2)a', 'This will list records on the TASK table for a selected PATTERN.

Refer to <a href=\"%root%/mnu_task(list)2.html\">List Task by Pattern</a> for full details.', '2004-08-26 12:09:31', 'AJM', '2007-09-10 14:46:07', 'AJM'),
('mnu_task(list2)b', 'This will list records on the TASK table for a selected SUBSYSTEM.

Refer to <a href=\"%root%/mnu_task(list2)b.html\">List Task by Subsystem</a> for full details.', '2004-08-26 12:09:43', 'AJM', '2007-09-10 21:56:41', 'AJM'),
('mnu_task(popup1)', 'This will list records on the TASK table and allow one or more to be selected.

After selecting records please press the CHOOSE button.

Refer to <a href=\"%root%/mnu_task(popup1).html\">Choose Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 21:58:54', 'AJM'),
('mnu_task(popup1)a', 'This will list records on the TASK table and allow one or more to be selected.

After selecting records please press the CHOOSE button.

Refer to <a href=\"%root%/mnu_task(popup)a.html\">Choose Task (Proc)</a> for full details.', '2004-08-26 14:09:00', 'AJM', '2007-09-10 14:59:10', 'AJM'),
('mnu_task(popup1)b', 'This will list records on the TASK table and allow one or more to be selected.

After selecting records please press the CHOOSE button.

Refer to <a href=\"%root%/mnu_task(popup)b.html\">Choose Task (Menu)</a> for full details.', '2004-08-26 14:09:10', 'AJM', '2007-09-10 14:59:45', 'AJM'),
('mnu_task(rename)', 'This will allow a entry on the TASK table to be renamed. It will also rename any associated records on any related tables. 

Refer to <a href=\"%root%/mnu_task(rename).html\">Rename Task</a> for full details.', '2004-08-26 12:25:54', 'AJM', '2005-07-02 15:29:44', 'AJM'),
('mnu_task(search)', 'This will allow search criteria to be entered for the TASK table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_task(search).html\">Search Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:29:50', 'AJM'),
('mnu_task(upd1)', 'This will display the contents of a record from the TASK table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_task(upd1).html\">Update Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 22:10:53', 'AJM'),
('mnu_todo(add1)', 'This will allow a new record to be added to the ToDo table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_todo(add1).html\">Add ToDo</a> for full details.', '2006-04-19 16:10:08', 'AJM', '2007-09-10 22:16:19', 'AJM'),
('mnu_todo(del1)', 'This will display a record from the ToDo table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_todo(del1).html\">Delete ToDo</a> for full details.', '2006-04-19 16:10:55', 'AJM', '2007-09-10 22:19:14', 'AJM'),
('mnu_todo(enq1)', 'This will display the contents of a record from the ToDo table.

Refer to <a href=\"%root%/mnu_todo(enq1).html\">Enquire ToDo</a> for full details.', '2006-04-19 16:12:45', 'AJM', '2007-09-10 22:22:07', 'AJM'),
('mnu_todo(list1)', 'This will list records on the ToDo table.

Refer to <a href=\"%root%/mnu_todo(list1).html\">List ToDo</a> for full details.', '2006-04-19 15:57:45', 'AJM', '2007-09-10 22:25:02', 'AJM'),
('mnu_todo(list2)', 'This will list records on the ToDo table for a particular USER.

Refer to <a href=\"%root%/mnu_todo(list)2.html\">List ToDo for User</a> for full details.', '2006-04-19 16:07:56', 'AJM', '2007-09-10 15:12:36', 'AJM'),
('mnu_todo(search)', 'This will allow search criteria to be entered for the ToDo table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_todo(search).html\">Search ToDo</a> for full details.', '2006-04-19 16:13:45', 'AJM', NULL, NULL),
('mnu_todo(upd1)', 'This will display the contents of a record from the ToDo table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_todo(upd1).html\">Update ToDo</a> for full details.', '2006-04-19 16:14:40', 'AJM', '2007-09-10 22:33:06', 'AJM'),
('mnu_user(add1)', 'This will allow a new record to be added to the USER table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_user(add1).html\">Add User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 22:36:33', 'AJM'),
('mnu_user(del1)', 'This will display a record from the USER table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_user(del1).html\">Delete User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 22:38:47', 'AJM'),
('mnu_user(enq1)', 'This will display the contents of a record from the USER table.

Refer to <a href=\"%root%/mnu_user(enq1).html\">Enquire User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 22:41:10', 'AJM'),
('mnu_user(list1)', 'This will list records on the USER table.

Refer to <a href=\"%root%/mnu_user(list1).html\">List User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 22:43:26', 'AJM'),
('mnu_user(list2)', 'This will list records on the USER table for a selected ROLE.

Refer to <a href=\"%root%/mnu_user(list2).html\">List User by Role</a> for full details.', '2004-08-26 12:10:17', 'AJM', '2007-09-10 22:48:57', 'AJM'),
('mnu_user(popup1)', 'This will list records on the USER table and allow one or more to be selected.

After selecting records please press the CHOOSE button to return to the previous screen.

Refer to <a href=\"%root%/mnu_user(popup1).html\">Choose User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 22:52:08', 'AJM'),
('mnu_user(search)', 'This will allow search criteria to be entered for the USER table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_user(search).html\">Search User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:30:50', 'AJM'),
('mnu_user(upd1)', 'This will display the contents of a record from the USER table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_user(upd1).html\">Update User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 22:54:19', 'AJM'),
('mnu_user(upd1)a', 'This will allow a user\'s password to be changed.

Refer to <a href=\"%root%/mnu_user(upd1)a.html\">Change User Password</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 22:59:34', 'AJM'),
('mnu_user(upd1)b', 'This will allow a user\'s password to be changed.

Refer to <a href=\"%root%/mnu_user(upd1)b.html\">Reset User Password</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2007-09-10 23:02:58', 'AJM'),
('mnu_user(upd1)c', 'Enter your e-mail address and your password will be sent to you.

Note: this will only work if your e-mail address is recorded on your user details.

Refer to <a href=\"%root%/mnu_user(pswd).html\">Retrieve Password</a> for full details.', '2006-04-23 11:41:11', 'AJM', '2007-09-10 15:33:47', 'AJM');

REPLACE INTO `mnu_todo` (`user_id`, `seq_no`, `item_desc`, `item_notes`, `due_date`, `visibility`, `is_complete`, `repeat_interval`, `repeat_unit`, `task_id`, `task_context`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('AJM', '2', 'Do something', NULL, '2005-09-01', '7', 'Y', NULL, NULL, NULL, NULL, '2005-07-31 12:38:32', 'AJM', '2006-04-07 14:41:20', 'AJM'),
('AJM', '3', 'Do something else', NULL, '2005-10-01', '7', 'Y', NULL, NULL, NULL, NULL, '2005-07-31 12:38:59', 'AJM', '2006-04-07 14:41:23', 'AJM'),
('AJM', '4', 'Do something interesting', NULL, '2005-11-01', '7', 'Y', NULL, NULL, NULL, NULL, '2005-07-31 12:39:20', 'AJM', '2006-04-07 14:41:26', 'AJM'),
('AJM', '5', 'Do something boring', NULL, '2005-12-01', '7', 'Y', NULL, NULL, NULL, NULL, '2005-07-31 12:39:34', 'AJM', '2006-04-07 14:41:30', 'AJM'),
('AJM', '6', 'Make a new Year\'s Resolution', NULL, '2006-01-01', '7', 'N', NULL, NULL, NULL, NULL, '2005-07-31 12:40:38', 'AJM', '2007-06-20 11:26:11', 'AJM'),
('AJM', '7', 'Break a new Year\'s Resolution', NULL, '2006-02-01', '7', 'N', NULL, NULL, NULL, NULL, '2005-07-31 12:40:53', 'AJM', '2006-04-07 14:45:17', 'AJM'),
('AJM', '8', 'Prepare for a long march', NULL, '2006-03-01', '7', 'N', NULL, NULL, NULL, NULL, '2005-07-31 12:41:09', 'AJM', '2005-07-31 17:41:16', 'AJM'),
('AJM', '9', 'Take a rest after a long march', NULL, '2006-04-01', '7', 'N', NULL, NULL, NULL, NULL, '2005-07-31 12:41:21', 'AJM', '2005-07-31 17:41:32', 'AJM'),
('AJM', '10', 'May the Fourth be with you', NULL, '2006-05-01', '7', 'N', NULL, NULL, NULL, NULL, '2005-07-31 12:41:35', 'AJM', '2005-07-31 17:41:49', 'AJM'),
('AJM', '11', 'Watch out for June bugs', NULL, '2006-06-01', '7', 'Y', NULL, NULL, NULL, NULL, '2005-07-31 12:41:49', 'AJM', '2006-04-07 14:45:42', 'AJM'),
('AJM', '12', 'Test for 1st July 2006', NULL, '2006-07-01', '7', 'N', NULL, NULL, NULL, NULL, '2005-07-31 12:41:59', 'AJM', '2007-05-29 11:53:06', 'AJM'),
('AJM', '13', 'this is just a test', 'this is jst a test', '2006-09-30', '7', 'N', NULL, NULL, NULL, NULL, '2006-09-19 14:30:51', 'AJM', NULL, NULL),
('AJM', '14', 'Test for June 1st 2007', NULL, '2007-06-01', '7', 'Y', '1', 'M', NULL, NULL, '2007-05-28 11:41:01', 'AJM', '2007-05-29 11:55:11', 'AJM'),
('AJM', '15', 'Test for June 1st 2008', NULL, '2008-06-01', '7', 'N', NULL, NULL, NULL, NULL, '2007-05-28 11:41:23', 'AJM', NULL, NULL),
('AJM', '16', 'Test for June 1st 2007', NULL, '2007-07-01', '7', 'N', '1', 'M', NULL, NULL, '2007-05-29 11:55:24', 'AJM', NULL, NULL),
('AJM', '17', 'test', NULL, '2007-08-27', '7', 'N', NULL, NULL, NULL, NULL, '2007-08-26 00:05:03', 'AJM', NULL, NULL),
('DEMO', '1', 'Do something usefull', 'blah blah blah', '2006-04-30', '7', 'N', NULL, NULL, NULL, NULL, '2006-04-10 09:33:28', 'DEMO', NULL, NULL),
('FB', '1', 'stuff', NULL, '2005-09-01', '7', 'Y', NULL, NULL, NULL, NULL, '2005-07-30 18:44:46', 'AJM', '2005-07-30 20:20:16', 'AJM'),
('FB', '2', 'More Stuff', 'Just a test', '2005-08-15', '7', 'N', NULL, NULL, NULL, NULL, '2005-07-30 19:36:51', 'AJM', NULL, NULL),
('FB', '3', 'Yet More stuff', NULL, '2005-08-01', '7', 'N', NULL, NULL, NULL, NULL, '2005-07-30 20:20:09', 'AJM', NULL, NULL);

REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('SYSTEM', 'DEFAULT_LANGUAGE', 'en', '2005-07-05 17:20:23', 'AJM', '2005-07-14 17:02:12', 'AJM'),
('SYSTEM', 'PSWD_CHANGE', 'AR', '2003-01-01 12:00:00', 'AJM', '2006-04-24 14:45:39', 'AJM'),
('SYSTEM', 'PSWD_COUNT', NULL, '2003-01-01 12:00:00', 'AJM', '2006-04-24 14:45:39', 'AJM'),
('SYSTEM', 'PSWD_DAYS', NULL, '2003-01-01 12:00:00', 'AJM', '2006-04-24 12:56:11', 'AJM'),
('SYSTEM', 'PSWD_ENCRYPT', 'Y', '2003-01-01 12:00:00', 'AJM', '2007-08-21 14:00:21', 'AJM'),
('SYSTEM', 'PSWD_FORMAT_DIGITS', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SYSTEM', 'PSWD_FORMAT_LOWER', NULL, '2003-01-01 12:00:00', 'AJM', '2007-05-17 19:07:00', 'AJM'),
('SYSTEM', 'PSWD_FORMAT_MINLEN', '4', '2003-01-01 12:00:00', 'AJM', '2005-01-15 18:58:07', 'AJM'),
('SYSTEM', 'PSWD_FORMAT_UPPER', NULL, '2003-01-01 12:00:00', 'AJM', '2007-08-20 22:56:55', 'AJM'),
('SYSTEM', 'PSWD_HIDDEN', 'Y', '2006-07-18 16:50:30', 'AJM', '2007-08-21 14:01:13', 'AJM'),
('SYSTEM', 'PSWD_RETRIES', '3', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SYSTEM', 'PSWD_WARNING', '5', '2006-03-08 22:31:52', 'AJM', '2006-04-24 14:45:39', 'AJM'),
('SYSTEM', 'SHUTDOWN_END', NULL, '2006-04-16 14:43:28', 'AJM', '2006-04-26 09:50:23', 'AJM'),
('SYSTEM', 'SHUTDOWN_FRIDAY', NULL, '2006-04-16 14:59:25', 'AJM', '2006-04-26 09:50:23', 'AJM'),
('SYSTEM', 'SHUTDOWN_MONDAY', NULL, '2006-04-16 14:59:24', 'AJM', '2006-04-26 09:50:23', 'AJM'),
('SYSTEM', 'SHUTDOWN_SATURDAY', NULL, '2006-04-16 14:59:25', 'AJM', '2006-04-26 09:50:23', 'AJM'),
('SYSTEM', 'SHUTDOWN_START', NULL, '2006-04-16 14:43:28', 'AJM', '2006-04-26 09:50:23', 'AJM'),
('SYSTEM', 'SHUTDOWN_SUNDAY', NULL, '2006-04-16 14:59:25', 'AJM', '2006-04-26 09:50:23', 'AJM'),
('SYSTEM', 'SHUTDOWN_THURSDAY', NULL, '2006-04-16 14:59:25', 'AJM', '2006-04-26 09:50:24', 'AJM'),
('SYSTEM', 'SHUTDOWN_TUESDAY', NULL, '2006-04-16 14:59:24', 'AJM', '2006-04-26 09:50:24', 'AJM'),
('SYSTEM', 'SHUTDOWN_WARNING', NULL, '2006-04-16 14:43:28', 'AJM', '2006-04-17 14:59:47', 'AJM'),
('SYSTEM', 'SHUTDOWN_WEDNESDAY', NULL, '2006-04-16 14:59:24', 'AJM', '2006-04-26 09:50:24', 'AJM');

-- finished
