-- file created on February 3, 2006, 2:57 pm
    
REPLACE INTO `mnu_control` (`record_id`, `field_id`, `field_value`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('SYSTEM', 'DEFAULT_LANGUAGE', 'en', '2005-07-05 17:20:23', 'AJM', '2005-07-14 17:02:12', 'AJM'),
('SYSTEM', 'PSWD_CHANGE', 'AR', '2003-01-01 12:00:00', 'AJM', '2005-07-29 12:08:00', 'AJM'),
('SYSTEM', 'PSWD_COUNT', NULL, '2003-01-01 12:00:00', 'AJM', '2004-04-10 18:13:59', 'AJM'),
('SYSTEM', 'PSWD_DAYS', NULL, '2003-01-01 12:00:00', 'AJM', '2005-07-29 12:08:00', 'AJM'),
('SYSTEM', 'PSWD_ENCRYPT', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-09-22 19:20:11', 'AJM'),
('SYSTEM', 'PSWD_FORMAT_DIGITS', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SYSTEM', 'PSWD_FORMAT_LOWER', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SYSTEM', 'PSWD_FORMAT_MINLEN', '4', '2003-01-01 12:00:00', 'AJM', '2005-01-15 18:58:07', 'AJM'),
('SYSTEM', 'PSWD_FORMAT_UPPER', NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SYSTEM', 'PSWD_RETRIES', '3', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_dialog_type` (`dialog_type_id`, `dialog_type_desc`, `dialog_type_long_desc`, `visible_screen`, `context_preselect`, `keep_data`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
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
('ENQ1', 'ENQ1 - Enquire a single record', 'This will read a single record from the database using the primary key passed down by the previous screen and display it to the user.

If multiple rows are selected then scrolling options will be provided.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:56:48', 'AJM'),
('ERASE1', 'ERASE1 - Delete a record and all child records', 'This will delete a single record from the database using the primary key passed down by the previous screen. It will also delete *ALL* related occurrences on child tables.

This will call the \'eraseRecord\' method.', 'Y', 'Y', 'N', '2005-12-06 17:40:51', 'AJM', NULL, NULL),
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

Links at the bottom of the page will allow the user to jump to the first/last/previous/next page.', 'Y', 'Y', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:57:06', 'AJM'),
('LIST3', 'LIST3 - List multiple children', 'This will list rows of MANY(1) and MANY(2) in a ONE-to-MANY(1)-to-MANY(2) relationship.

MANY(1)-to-MANY(2) is another ONE-to-MANY relationship

The primary key of ONE will be passed down from the previous screen.

This will then be passed to MANY(1) for processing.

The primary key of MANY(1) will then be passed to MANY(2) for processing.

Links at the bottom of the page will allow the user to jump to the first/last/previous/next page.', 'Y', 'Y', 'Y', '2005-06-22 23:17:59', 'AJM', NULL, NULL),
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

This will call the \'updateMultiple\' method.', 'N', 'N', 'N', '2005-06-24 23:25:47', 'AJM', '2005-06-25 16:50:12', 'AJM'),
('POPUP', 'POPUP - Choose records', 'This shows the user a list of available rows from a database table and allows the user to choose one (or more) for processing in the previous screen.', 'Y', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:57:37', 'AJM'),
('SRCH', 'SRCH - Enter selection criteria', 'This will show a blank detail screen and allow the user to specify search criteria that will then be returned to the previous screen for action.', 'Y', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2005-11-27 17:05:50', 'AJM'),
('TREE1', 'TREE1 - List Tree Structure (fixed)', 'This will list nodes in a tree structure and allow the user to expand and contract nodes individually.

This uses a stand-alone TREE_NODE table.

This uses the \'getNodeData\' method to retrieve the data for the selected nodes.', 'Y', 'Y', 'Y', '2003-01-01 12:00:00', 'AJM', '2005-12-26 12:29:52', 'AJM'),
('TREE1POPUP', 'TREE1POPUP - Choose from a Tree Structure (fixed)', 'This will list nodes in a tree structure and allow the user to choose one for processing in the previous screen.

This uses a stand-alone TREE_NODE table.

This uses the \'getNodeData\' method to retrieve the data for the selected nodes.', 'Y', 'Y', 'Y', '2005-12-26 12:29:37', 'AJM', NULL, NULL),
('TREE2', 'TREE2 - List Tree Structure (flexible)', 'This will list nodes in a tree structure and allow the user to expand and contract nodes individually.

This uses the TREE_TYPE, TREE_LEVEL and TREE_NODE database tables so that different levels can be defined for different tree types.

The TREE_TYPE to be displayed will be passed down by the previous screen.

This uses the \'getNodeData\' method to retrieve the data for the selected nodes.', 'Y', 'N', 'Y', '2003-01-01 12:00:00', 'AJM', '2005-12-26 12:30:51', 'AJM'),
('TREE2POPUP', 'TREE2POPUP - Choose from a Tree Structure (flexible)', 'This will list nodes in a tree structure and allow the user to choose one for processing in the previous screen.

This uses the TREE_TYPE, TREE_LEVEL and TREE_NODE database tables so that different levels can be defined for different tree types.

The TREE_TYPE to be displayed will be passed down by the previous screen.

This uses the \'getNodeData\' method to retrieve the data for the selected nodes.', 'Y', 'N', 'Y', '2005-12-26 12:30:37', 'AJM', NULL, NULL),
('UPD1', 'UPD1 - Update a single record', 'This will allow a single database record (row) to be displayed and updated.

The primary key of the row is passed down from the previous screen. If multiple rows are selected then scrolling options will be provided.

This will call the \'updateRecord\' method.', 'Y', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-04-11 16:43:21', 'AJM'),
('UPD2', 'UPD2 - Update multiple records', 'This will update multiple rows in the database.

The rows are identified using a combination of values supplied by the previous screen plus values selected in a popup screen which will called next.

This will call the \'updateSelection\' method.', 'N', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-28 11:56:26', 'AJM'),
('UPD3', 'UPD3 - Update Control record', 'This will update multiple rows in a \'control\' table in the database.

Each row contains a \'field_id\' and a \'field_value\' column, and they are treated as searate fields from a sigle row. This design allows \'fields\' (rows) to be added or deleted at will without having to alter the structure of the table.

This will call the \'updateSelection\' method.', 'Y', 'N', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-28 11:56:43', 'AJM'),
('UPD4', 'UPD4 - Update one or more records without user dialog', 'This will allow one or more database rows to be updated without being displayed.

The identity of the row(s) to be updated is passed down from the previous screen.

This will call the \'updateMultiple\' method.', 'N', 'Y', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-28 12:37:18', 'AJM');

REPLACE INTO `mnu_role` (`role_id`, `role_desc`, `start_task_id`, `global_access`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('ADMIN', 'Logistics Administrator', 'main_menu', 'N', '2005-11-18 11:17:09', 'RNP', NULL, NULL),
('DEMO', 'Demonstration Class', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('DEV', 'Development', 'main_menu', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('GLOBAL', 'Global Access', 'main_menu', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('LOGISTICS ADMIN', 'Logistics Administrator', 'main_menu', 'N', '2005-11-11 11:41:17', 'RNP', '2005-11-11 12:48:31', 'RNP'),
('READONLY', 'Read Only', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'SURVEY (supervisor)', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY1', 'SURVEY (user)', 'survey', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER1', 'User Class 1', 'proto', 'N', '2003-01-01 12:00:00', 'AJM', '2005-07-31 14:59:56', 'AJM'),
('USER2', 'User Class 2', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER3', 'User Class 3', 'main_menu', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_subsystem` (`subsys_id`, `subsys_desc`, `subsys_dir`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('MENU', 'Menu and Security system', 'menu', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('logon', 'Logon screen', 'Logon', 'PROC', 'logon.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2005-07-20 15:00:06', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('menu', 'Home Page', 'Home', 'PROC', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'Y', NULL, NULL, '2004-08-18 12:19:08', 'AJM', '2004-08-18 12:42:24', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('menu', 'mnu_todo(list)2', '001', 'ToDo', 'N', '2005-07-31 15:35:03', 'AJM', '2005-07-31 15:35:11', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'menu', '2004-10-08 16:07:50', 'AJM', NULL, NULL),
('READONLY', 'menu', '2004-10-08 16:12:31', 'AJM', NULL, NULL),
('SURVEY', 'menu', '2004-10-08 16:12:31', 'AJM', NULL, NULL),
('SURVEY1', 'menu', '2004-10-08 16:12:31', 'AJM', NULL, NULL),
('USER1', 'menu', '2004-10-08 16:12:31', 'AJM', NULL, NULL),
('USER2', 'menu', '2004-10-08 16:12:31', 'AJM', NULL, NULL),
('USER3', 'menu', '2004-10-08 16:12:31', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_control(upd)', 'Maintain Menu Controls', 'Menu Controls', 'PROC', 'mnu_control_upd.php', 'N', 'UPD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_control(upd)', 'PSWD_CHANGE', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_control(upd)', 'PSWD_COUNT', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_control(upd)', 'PSWD_DAYS', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_control(upd)', 'PSWD_ENCRYPT', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_control(upd)', 'PSWD_FORMAT_DIGITS', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_control(upd)', 'PSWD_FORMAT_LOWER', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_control(upd)', 'PSWD_FORMAT_MINLEN', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_control(upd)', 'PSWD_FORMAT_UPPER', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_control(upd)', 'PSWD_RETRIES', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_control(upd)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('READONLY', 'mnu_control(upd)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_control(upd)', 'PSWD_CHANGE', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('READONLY', 'mnu_control(upd)', 'PSWD_CHANGE', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_control(upd)', 'PSWD_CHANGE', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('DEMO', 'mnu_control(upd)', 'PSWD_COUNT', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('READONLY', 'mnu_control(upd)', 'PSWD_COUNT', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_control(upd)', 'PSWD_COUNT', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('DEMO', 'mnu_control(upd)', 'PSWD_DAYS', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('READONLY', 'mnu_control(upd)', 'PSWD_DAYS', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_control(upd)', 'PSWD_DAYS', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('DEMO', 'mnu_control(upd)', 'PSWD_ENCRYPT', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('READONLY', 'mnu_control(upd)', 'PSWD_ENCRYPT', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_control(upd)', 'PSWD_ENCRYPT', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('DEMO', 'mnu_control(upd)', 'PSWD_FORMAT_DIGITS', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('READONLY', 'mnu_control(upd)', 'PSWD_FORMAT_DIGITS', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_control(upd)', 'PSWD_FORMAT_DIGITS', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('DEMO', 'mnu_control(upd)', 'PSWD_FORMAT_LOWER', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('READONLY', 'mnu_control(upd)', 'PSWD_FORMAT_LOWER', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_control(upd)', 'PSWD_FORMAT_LOWER', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('DEMO', 'mnu_control(upd)', 'PSWD_FORMAT_MINLEN', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('READONLY', 'mnu_control(upd)', 'PSWD_FORMAT_MINLEN', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_control(upd)', 'PSWD_FORMAT_MINLEN', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('DEMO', 'mnu_control(upd)', 'PSWD_FORMAT_UPPER', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('READONLY', 'mnu_control(upd)', 'PSWD_FORMAT_UPPER', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_control(upd)', 'PSWD_FORMAT_UPPER', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('DEMO', 'mnu_control(upd)', 'PSWD_RETRIES', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('READONLY', 'mnu_control(upd)', 'PSWD_RETRIES', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_control(upd)', 'PSWD_RETRIES', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_dialog_type(add)', 'Add Dialog Type', 'Insert', 'PROC', 'mnu_dialog_type_add.php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_dialog_type(del)', 'Delete Dialog Type', 'Delete', 'PROC', 'mnu_dialog_type_del.php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_dialog_type(enq)', 'Enquire Dialog Type', 'Enquire', 'PROC', 'mnu_dialog_type_enq.php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_dialog_type(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('READONLY', 'mnu_dialog_type(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_dialog_type(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_dialog_type(list)', 'List Dialog Type', 'List Dialog Type', 'PROC', 'mnu_dialog_type_list.php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'Y', NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2004-08-18 12:09:58', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_dialog_type(list)', 'mnu_dialog_type(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_dialog_type(list)', 'mnu_dialog_type(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_dialog_type(list)', 'mnu_dialog_type(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_dialog_type(list)', 'mnu_dialog_type(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_dialog_type(list)', 'mnu_task(list)2', '005', 'List Task', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_dialog_type(list)', 'mnu_dialog_type(search)', '006', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_dialog_type(list)', 'audit_dtl(list)3', '007', 'Audit Trail', 'Y', '2004-04-09 11:37:12', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_dialog_type(list)', 'DUMMY1', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_dialog_type(list)', '2005-04-19 18:11:29', 'AJM', NULL, NULL),
('READONLY', 'mnu_dialog_type(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_dialog_type(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('USER1', 'mnu_dialog_type(list)', 'DUMMY1', 'NDI', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER3', 'mnu_dialog_type(list)', 'DUMMY1', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_dialog_type(search)', 'Search Dialog Type', 'Search', 'PROC', 'mnu_dialog_type_search.php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_dialog_type(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('READONLY', 'mnu_dialog_type(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_dialog_type(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_dialog_type(upd)', 'Update Dialog Type', 'Update', 'PROC', 'mnu_dialog_type_upd.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_help_text(multi)', 'Maintain Help Text', 'Help Text', 'PROC', 'help_text_multi.php', 'N', 'MULTI1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2005-06-24 17:31:37', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(add)', 'Add Menu Items', 'Insert', 'PROC', 'mnu_menu_add.php', 'N', 'ADD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(del)', 'Delete Menu Items', 'Delete', 'PROC', 'mnu_menu_del.php', 'N', 'DEL2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(link)', 'Maintain Menu Items (2)', 'Menu Items(2)', 'PROC', 'mnu_menu_link.php', 'N', 'LINK1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2004-09-09 10:31:31', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(link)', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(list)', 'List Menu Items', 'Menu Items(3)', 'PROC', 'mnu_menu_list.php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2004-09-09 10:39:22', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(list)', 'mnu_menu(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_menu(list)', 'mnu_menu(upd)', '002', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_menu(list)', 'mnu_menu(del)', '003', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_menu(list)', 'mnu_menu(search)', '004', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_menu(list)', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2004-04-09 11:58:45', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_menu(list)', '2005-04-19 18:11:41', 'AJM', NULL, NULL),
('READONLY', 'mnu_menu(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_menu(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(multi)', 'Maintain Menu Items (1)', 'Menu Items(1)', 'PROC', 'mnu_menu_multi.php', 'N', 'MULTI2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2005-06-24 17:30:19', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(multi)', 'mnu_menu(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_menu(multi)', 'mnu_menu(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(search)', 'Search Menu Items', 'Search', 'PROC', 'mnu_menu_search.php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_menu(search)', '2005-04-19 18:11:41', 'AJM', NULL, NULL),
('READONLY', 'mnu_menu(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_menu(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_menu(upd)', 'Update Menu Item', 'Update', 'PROC', 'mnu_menu_upd.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(add)', 'Add Navigation Button', 'Insert', 'PROC', 'mnu_nav_button_add.php', 'N', 'ADD3', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(del)', 'Delete Navigation Button', 'Delete', 'PROC', 'mnu_nav_button_del.php', 'N', 'DEL2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(link)', 'Maintain Navigation Buttons (2)', 'Navigation Button (2)', 'PROC', 'mnu_nav_button_link.php', 'N', 'LINK1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2004-08-14 18:43:51', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(link)', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(list)', 'List Navigation Buttons', 'Navigation Buttons (3)', 'PROC', 'mnu_nav_button_list.php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2004-08-14 18:38:49', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(list)', 'mnu_nav_button(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_nav_button(list)', 'mnu_nav_button(upd)', '002', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_nav_button(list)', 'mnu_nav_button(del)', '003', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_nav_button(list)', 'mnu_nav_button(search)', '004', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_nav_button(list)', 'audit_dtl(list)3', '005', 'Audit Trail', 'Y', '2004-04-09 11:58:57', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_nav_button(list)', '2005-04-19 18:11:54', 'AJM', NULL, NULL),
('READONLY', 'mnu_nav_button(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_nav_button(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(multi)', 'Maintain Navigation Buttons (1)', 'Navigation Button (1)', 'PROC', 'mnu_nav_button_multi.php', 'N', 'MULTI2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2005-06-24 17:30:28', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(multi)', 'mnu_nav_button(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_nav_button(multi)', 'mnu_nav_button(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(search)', 'Search Navigation Button', 'Search', 'PROC', 'mnu_nav_button_search.php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_nav_button(search)', '2005-04-19 18:11:54', 'AJM', NULL, NULL),
('READONLY', 'mnu_nav_button(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_nav_button(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_nav_button(upd)', 'Update Navigation Button', 'Update', 'PROC', 'mnu_nav_button_upd.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(add)', 'Add Role', 'Insert', 'PROC', 'mnu_role_add.php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(del)', 'Delete Role', 'Delete', 'PROC', 'mnu_role_del.php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(enq)', 'Enquire Role', 'Enquire', 'PROC', 'mnu_role_enq.php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_role(enq)', '2005-04-19 18:11:54', 'AJM', NULL, NULL),
('READONLY', 'mnu_role(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_role(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(list)', 'List Role', 'List Role', 'PROC', 'mnu_role_list.php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'Y', NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2004-08-18 12:10:03', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(list)', 'mnu_role(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_role(list)', 'mnu_role(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_role(list)', 'mnu_role(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_role(list)', 'mnu_role(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_role(list)', 'mnu_user(list)2', '005', 'List User', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_role(list)', 'mnu_role_task(link)b', '006', 'Task Access', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_role(list)', 'mnu_role_taskfield(multi)b', '007', 'Field Access', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_role(list)', 'mnu_role(search)', '008', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_role(list)', 'audit_dtl(list)3', '009', 'Audit Trail', 'Y', '2004-04-09 11:37:40', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_role(list)', '2005-04-19 18:11:54', 'AJM', NULL, NULL),
('READONLY', 'mnu_role(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_role(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(popup)', 'Choose Role', 'Choose', 'PROC', 'mnu_role_popup.php', 'N', 'POPUP', 'MENU', NULL, NULL, NULL, NULL, 'role_id', 'N', NULL, NULL, '2004-04-14 15:04:39', 'AJM', '2004-12-25 11:36:22', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_role(popup)', '2005-04-19 18:11:54', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(search)', 'Search Role', 'Search', 'PROC', 'mnu_role_search.php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_role(search)', '2005-04-19 18:12:06', 'AJM', NULL, NULL),
('READONLY', 'mnu_role(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_role(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role(upd)', 'Update Role', 'Update', 'PROC', 'mnu_role_upd.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role_task(link)a', 'Link Role(s) to selected Task', 'Task Access', 'PROC', 'mnu_role_task_link(a).php', 'N', 'LINK1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role_task(link)a', 'mnu_role(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role_task(link)b', 'Link Task(s) to selected Role', 'Task Access', 'PROC', 'mnu_role_task_link(b).php', 'N', 'LINK1', 'MENU', NULL, NULL, NULL, NULL, 'task_id', 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2005-04-24 12:48:17', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role_task(link)b', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role_taskfield(multi)a', 'Maintain Field Access via Task', 'Field Access', 'PROC', 'mnu_role_taskfield_multi(a).php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, 'task_id,field_id', 'N', NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2005-06-24 17:32:42', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_role_taskfield(multi)b', 'Maintain Field Access via Role', 'Field Access', 'PROC', 'mnu_role_taskfield_multi(b).php', 'N', 'MULTI3', 'MENU', NULL, NULL, NULL, NULL, 'task_id,field_id', 'N', NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2005-06-24 17:32:55', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(add)', 'Add Subsystem', 'Insert', 'PROC', 'mnu_subsystem_add.php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(del)', 'Delete Subsystem', 'Delete', 'PROC', 'mnu_subsystem_del.php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(enq)', 'Enquire Subsystem', 'Enquire', 'PROC', 'mnu_subsystem_enq.php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_subsystem(enq)', '2005-04-19 18:12:19', 'AJM', NULL, NULL),
('READONLY', 'mnu_subsystem(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_subsystem(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(erase)', 'Erase Subsystem', 'Erase', 'PROC', 'mnu_subsystem_erase.php', 'N', 'ERASE1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2005-12-06 17:42:11', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(export)', 'Export Subsystem', 'Export', 'PROC', 'mnu_subsystem_export.php', 'N', 'UPD4', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2005-07-15 21:12:39', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(list)', 'List Subsystem', 'List Subsystem', 'PROC', 'mnu_subsystem_list.php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'Y', NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2004-08-18 12:10:08', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(list)', 'mnu_subsystem(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_subsystem(list)', 'mnu_subsystem(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_subsystem(list)', 'mnu_subsystem(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_subsystem(list)', 'mnu_subsystem(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_subsystem(list)', 'mnu_task(list)3', '005', 'List Task', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_subsystem(list)', 'mnu_subsystem(search)', '006', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_subsystem(list)', 'mnu_subsystem(export)', '007', 'Export', 'Y', '2005-07-15 21:13:05', 'AJM', '2005-07-15 21:14:32', 'AJM'),
('mnu_subsystem(list)', 'dict_database(list)2', '008', 'Databases', 'Y', '2005-03-12 18:56:34', 'AJM', '2005-07-15 21:14:32', 'AJM'),
('mnu_subsystem(list)', 'mnu_subsystem(erase)', '009', 'Erase', 'Y', '2005-12-06 17:42:42', 'AJM', '2005-12-06 17:46:12', 'AJM'),
('mnu_subsystem(list)', 'audit_dtl(list)3', '010', 'Audit Trail', 'Y', '2004-04-09 11:37:58', 'AJM', '2005-12-06 17:46:12', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_subsystem(list)', '2005-04-19 18:12:19', 'AJM', NULL, NULL),
('READONLY', 'mnu_subsystem(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_subsystem(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(search)', 'Search Subsystem', 'Search', 'PROC', 'mnu_subsystem_search.php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_subsystem(search)', '2005-04-19 18:12:19', 'AJM', NULL, NULL),
('READONLY', 'mnu_subsystem(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_subsystem(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_subsystem(upd)', 'Update Subsystem', 'Update', 'PROC', 'mnu_subsystem_upd.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(add)', 'Add Task', 'Insert', 'PROC', 'mnu_task_add.php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2006-01-17 18:32:44', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(del)', 'Delete Task', 'Delete', 'PROC', 'mnu_task_del.php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2006-01-17 18:32:54', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(enq)', 'Enquire Task', 'Enquire', 'PROC', 'mnu_task_enq.php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2006-01-17 18:33:02', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(enq)', '2005-04-19 18:12:19', 'AJM', NULL, NULL),
('READONLY', 'mnu_task(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_task(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list)', 'List Task (All)', 'Task (All)', 'PROC', 'mnu_task_list.php', 'N', 'LIST1', 'MENU', 'mnu_task(search)', NULL, NULL, NULL, 'task_id', 'Y', 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2006-01-17 18:33:10', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list)', 'mnu_task(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)', 'mnu_task(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)', 'mnu_task(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)', 'mnu_task(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)', 'mnu_help_text(multi)', '005', 'Help Text', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)', 'mnu_role_task(link)a', '006', 'Task Access', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)', 'mnu_nav_button(multi)', '007', 'Navigation Button(1)', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-08-14 18:42:28', 'AJM'),
('mnu_task(list)', 'mnu_nav_button(link)', '008', 'Navigation Button(2)', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-08-14 18:42:28', 'AJM'),
('mnu_task(list)', 'mnu_nav_button(list)', '009', 'Navigation Button(3)', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-08-14 18:42:28', 'AJM'),
('mnu_task(list)', 'mnu_menu(multi)', '010', 'Menu Contents (1)', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-08-14 18:57:43', 'AJM'),
('mnu_task(list)', 'mnu_menu(link)', '011', 'Menu Contents (2)', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)', 'mnu_menu(list)', '012', 'Menu Contents (3)', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-08-14 18:57:43', 'AJM'),
('mnu_task(list)', 'mnu_task_field(list)', '013', 'List Fields', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)', 'mnu_role_taskfield(multi)a', '014', 'Field Access', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)', 'mnu_task(rename)', '015', 'Rename', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)', 'mnu_task(search)', '016', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)', 'audit_dtl(list)3', '017', 'Audit Trail', 'Y', '2004-04-09 11:38:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(list)', '2005-04-19 18:12:19', 'AJM', NULL, NULL),
('READONLY', 'mnu_task(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_task(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list)2', 'List Task by Dialog Type', 'List Task', 'PROC', 'mnu_task_list2.php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, 'task_id', 'N', 'N', NULL, '2003-01-01 12:00:00', 'AJM', '2006-01-17 18:33:16', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list)2', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)2', 'mnu_task(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)2', 'audit_dtl(list)3', '003', 'Audit Trail', 'Y', '2004-04-09 11:59:11', 'AJM', NULL, NULL),
('mnu_task(list)2', 'mnu_help_text(multi)', '004', 'Help Text', 'Y', '2004-08-26 11:58:54', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(list)2', '2005-04-19 18:12:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list)3', 'List Task by Subsystem', 'List Task', 'PROC', 'mnu_task_list3.php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, 'task_id', 'N', 'N', NULL, '2003-01-01 12:00:00', 'AJM', '2006-01-17 18:33:23', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list)3', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)3', 'mnu_task(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)3', 'audit_dtl(list)3', '003', 'Audit Trail', 'Y', '2004-04-09 11:59:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(list)3', '2005-04-19 18:12:19', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list)a', 'List Task (Process)', 'Task (Proc)', 'PROC', 'mnu_task_list.php', 'N', 'LIST1', 'MENU', 'mnu_task(search)', 'task_type=\'PROC\'', NULL, NULL, 'task_id', 'Y', 'N', NULL, '2003-01-01 12:00:00', 'AJM', '2006-01-17 18:33:29', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list)a', 'mnu_task(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)a', 'mnu_task(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)a', 'mnu_task(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)a', 'mnu_task(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)a', 'mnu_help_text(multi)', '005', 'Help Text', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)a', 'mnu_role_task(link)a', '006', 'Task Access', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)a', 'mnu_nav_button(multi)', '007', 'Navigation Button(1)', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-08-14 18:47:16', 'AJM'),
('mnu_task(list)a', 'mnu_nav_button(link)', '008', 'Navigation Button(2)', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)a', 'mnu_nav_button(list)', '009', 'Navigation Button(3)', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-08-14 18:47:16', 'AJM'),
('mnu_task(list)a', 'mnu_task_field(list)', '010', 'List Fields', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)a', 'mnu_role_taskfield(multi)a', '011', 'Field Access', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)a', 'mnu_task(rename)', '012', 'Rename', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)a', 'mnu_task(search)', '013', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)a', 'audit_dtl(list)3', '014', 'Audit Trail', 'Y', '2004-04-09 11:38:58', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(list)a', '2005-04-19 18:12:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list)b', 'List Task (Menu)', 'Task (Menu)', 'PROC', 'mnu_task_list.php', 'N', 'LIST1', 'MENU', NULL, 'task_type=\'MENU\'', NULL, NULL, 'task_id', 'Y', 'N', NULL, '2003-01-01 12:00:00', 'AJM', '2006-01-17 18:33:36', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(list)b', 'mnu_task(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)b', 'mnu_task(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)b', 'mnu_task(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)b', 'mnu_task(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)b', 'mnu_help_text(multi)', '005', 'Help Text', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)b', 'mnu_role_task(link)a', '006', 'Task Access', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)b', 'mnu_menu(multi)', '007', 'Menu Items(1)', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-09-09 10:36:48', 'AJM'),
('mnu_task(list)b', 'mnu_menu(link)', '008', 'Menu Items(2)', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-09-09 10:36:48', 'AJM'),
('mnu_task(list)b', 'mnu_menu(list)', '009', 'Menu Items(3)', 'Y', '2003-01-01 12:00:00', 'AJM', '2004-09-09 10:36:48', 'AJM'),
('mnu_task(list)b', 'mnu_task(rename)', '010', 'Rename', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)b', 'mnu_task(search)', '011', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task(list)b', 'audit_dtl(list)3', '012', 'Audit Trail', 'Y', '2004-04-08 16:27:07', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(list)b', '2005-04-19 18:12:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(popup)', 'Choose Task', 'Choose', 'PROC', 'mnu_task_popup.php', 'N', 'POPUP', 'MENU', NULL, NULL, NULL, NULL, 'task_id', 'N', 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2006-01-17 18:33:43', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(popup)', 'mnu_task(search)', '001', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(popup)', '2005-04-19 18:12:30', 'AJM', NULL, NULL),
('READONLY', 'mnu_task(popup)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_task(popup)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(popup)a', 'Choose Task (proc)', 'Choose', 'PROC', 'mnu_task_popup.php', 'N', 'POPUP', 'MENU', NULL, 'task_type=\'PROC\'', NULL, NULL, 'task_id', 'N', 'N', NULL, '2004-08-12 15:43:07', 'AJM', '2006-01-17 18:33:48', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(popup)a', 'mnu_task(search)', '001', 'Search', 'N', '2004-08-26 12:00:46', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(popup)a', '2005-04-19 18:12:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(popup)b', 'Choose Task (menu)', 'Choose', 'PROC', 'mnu_task_popup.php', 'N', 'POPUP', 'MENU', NULL, 'task_type=\'MENU\'', NULL, 'select_one=TRUE', 'task_id', 'N', 'N', NULL, '2003-01-01 12:00:00', 'AJM', '2006-01-17 18:34:30', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(popup)b', '2005-04-19 18:12:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(rename)', 'Rename Task', 'Rename', 'PROC', 'mnu_task_upd2.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, '2003-01-01 12:00:00', 'AJM', '2006-01-17 18:34:36', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(search)', 'Search Task', 'Search', 'PROC', 'mnu_task_search.php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2006-01-17 18:34:15', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task(search)', '2005-04-19 18:12:30', 'AJM', NULL, NULL),
('READONLY', 'mnu_task(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_task(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task(upd)', 'Update Task', 'Update', 'PROC', 'mnu_task_upd.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', 'N', NULL, '2004-01-01 00:00:00', 'AJM', '2006-01-17 18:34:02', 'AJM');

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task_field(add)', 'Add Task Field', 'New', 'PROC', 'mnu_task_field_add.php', 'N', 'ADD2', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task_field(del)', 'Delete Task Field', 'Delete', 'PROC', 'mnu_task_field_del.php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task_field(list)', 'List Task Field', 'List Fields', 'PROC', 'mnu_task_field_list.php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, 'field_id', 'N', NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2004-05-18 12:28:06', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_task_field(list)', 'mnu_task_field(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', '2004-05-18 14:23:08', 'AJM'),
('mnu_task_field(list)', 'mnu_task_field(del)', '002', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_task_field(list)', 'audit_dtl(list)3', '003', 'Audit Trail', 'Y', '2004-04-09 11:59:27', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_task_field(list)', '2005-04-19 18:12:42', 'AJM', NULL, NULL),
('SURVEY', 'mnu_task_field(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(add)', 'Add ToDo', 'New', 'PROC', 'mnu_todo_add.php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2005-07-30 17:55:07', 'AJM', '2005-07-30 18:12:13', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_todo(add)', '2005-07-31 16:30:15', 'AJM', NULL, NULL),
('DEV', 'mnu_todo(add)', '2005-07-31 16:30:31', 'AJM', NULL, NULL),
('READONLY', 'mnu_todo(add)', '2005-07-31 16:30:52', 'AJM', NULL, NULL),
('SURVEY', 'mnu_todo(add)', '2005-07-31 16:31:01', 'AJM', NULL, NULL),
('SURVEY1', 'mnu_todo(add)', '2005-07-31 16:31:09', 'AJM', NULL, NULL),
('USER1', 'mnu_todo(add)', '2005-07-31 16:31:17', 'AJM', NULL, NULL),
('USER2', 'mnu_todo(add)', '2005-07-31 16:31:24', 'AJM', NULL, NULL),
('USER3', 'mnu_todo(add)', '2005-07-31 16:31:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(del)', 'Delete ToDo', 'Delete', 'PROC', 'mnu_todo_del.php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2005-07-30 17:55:33', 'AJM', '2005-07-30 18:12:17', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_todo(del)', '2005-07-31 16:30:15', 'AJM', NULL, NULL),
('DEV', 'mnu_todo(del)', '2005-07-31 16:30:31', 'AJM', NULL, NULL),
('READONLY', 'mnu_todo(del)', '2005-07-31 16:30:53', 'AJM', NULL, NULL),
('SURVEY', 'mnu_todo(del)', '2005-07-31 16:31:01', 'AJM', NULL, NULL),
('SURVEY1', 'mnu_todo(del)', '2005-07-31 16:31:09', 'AJM', NULL, NULL),
('USER1', 'mnu_todo(del)', '2005-07-31 16:31:17', 'AJM', NULL, NULL),
('USER2', 'mnu_todo(del)', '2005-07-31 16:31:24', 'AJM', NULL, NULL),
('USER3', 'mnu_todo(del)', '2005-07-31 16:31:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(enq)', 'Enquire ToDo', 'Read', 'PROC', 'mnu_todo_enq.php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2005-07-30 17:56:00', 'AJM', '2005-07-30 18:12:21', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_todo(enq)', '2005-07-31 16:30:15', 'AJM', NULL, NULL),
('DEV', 'mnu_todo(enq)', '2005-07-31 16:30:31', 'AJM', NULL, NULL),
('READONLY', 'mnu_todo(enq)', '2005-07-31 16:30:53', 'AJM', NULL, NULL),
('SURVEY', 'mnu_todo(enq)', '2005-07-31 16:31:01', 'AJM', NULL, NULL),
('SURVEY1', 'mnu_todo(enq)', '2005-07-31 16:31:09', 'AJM', NULL, NULL),
('USER1', 'mnu_todo(enq)', '2005-07-31 16:31:17', 'AJM', NULL, NULL),
('USER2', 'mnu_todo(enq)', '2005-07-31 16:31:24', 'AJM', NULL, NULL),
('USER3', 'mnu_todo(enq)', '2005-07-31 16:31:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(list)', 'List ToDo', 'ToDo', 'PROC', 'mnu_todo_list.php', 'N', 'LIST1', 'MENU', NULL, NULL, 'is_complete=\'N\'', NULL, NULL, 'Y', NULL, NULL, '2005-07-30 17:54:29', 'AJM', '2005-07-30 20:27:26', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(list)', 'mnu_todo(add)', '001', 'New', 'N', '2005-07-30 17:57:41', 'AJM', NULL, NULL),
('mnu_todo(list)', 'mnu_todo(search)', '002', 'Search', 'N', '2005-07-30 17:57:41', 'AJM', '2005-07-30 17:58:03', 'AJM'),
('mnu_todo(list)', 'mnu_todo(enq)', '003', 'Read', 'Y', '2005-07-30 17:57:41', 'AJM', NULL, NULL),
('mnu_todo(list)', 'mnu_todo(upd)', '004', 'Update', 'Y', '2005-07-30 17:57:41', 'AJM', '2005-07-30 17:58:03', 'AJM'),
('mnu_todo(list)', 'mnu_todo(del)', '005', 'Delete', 'Y', '2005-07-30 17:57:41', 'AJM', '2005-07-30 17:58:03', 'AJM'),
('mnu_todo(list)', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2005-07-30 19:32:15', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(list)2', 'List ToDo by User', 'ToDo', 'PROC', 'mnu_todo_list2.php', 'N', 'LIST2', 'MENU', NULL, NULL, 'is_complete=\'N\'', NULL, NULL, 'Y', NULL, NULL, '2005-07-30 19:17:53', 'AJM', '2005-07-30 20:26:03', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(list)2', 'mnu_todo(add)', '001', 'New', 'N', '2005-07-30 19:31:31', 'AJM', NULL, NULL),
('mnu_todo(list)2', 'mnu_todo(search)', '002', 'Search', 'N', '2005-07-30 19:31:31', 'AJM', '2005-07-30 19:31:49', 'AJM'),
('mnu_todo(list)2', 'mnu_todo(enq)', '003', 'Read', 'Y', '2005-07-30 19:31:31', 'AJM', NULL, NULL),
('mnu_todo(list)2', 'mnu_todo(upd)', '004', 'Update', 'Y', '2005-07-30 19:31:31', 'AJM', '2005-07-30 19:31:49', 'AJM'),
('mnu_todo(list)2', 'mnu_todo(del)', '005', 'Delete', 'Y', '2005-07-30 19:31:31', 'AJM', '2005-07-30 19:31:49', 'AJM'),
('mnu_todo(list)2', 'audit_dtl(list)3', '006', 'Audit Trail', 'Y', '2005-07-30 19:32:02', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_todo(list)2', '2005-07-31 16:30:15', 'AJM', NULL, NULL),
('DEV', 'mnu_todo(list)2', '2005-07-31 16:30:31', 'AJM', NULL, NULL),
('READONLY', 'mnu_todo(list)2', '2005-07-31 16:30:53', 'AJM', NULL, NULL),
('SURVEY', 'mnu_todo(list)2', '2005-07-31 16:31:01', 'AJM', NULL, NULL),
('SURVEY1', 'mnu_todo(list)2', '2005-07-31 16:31:09', 'AJM', NULL, NULL),
('USER1', 'mnu_todo(list)2', '2005-07-31 16:31:17', 'AJM', NULL, NULL),
('USER2', 'mnu_todo(list)2', '2005-07-31 16:31:24', 'AJM', NULL, NULL),
('USER3', 'mnu_todo(list)2', '2005-07-31 16:31:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(search)', 'Search ToDo', 'Search', 'PROC', 'mnu_todo_search.php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2005-07-30 17:56:31', 'AJM', '2005-07-30 18:12:31', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_todo(search)', '2005-07-31 16:30:15', 'AJM', NULL, NULL),
('DEV', 'mnu_todo(search)', '2005-07-31 16:30:31', 'AJM', NULL, NULL),
('READONLY', 'mnu_todo(search)', '2005-07-31 16:30:53', 'AJM', NULL, NULL),
('SURVEY', 'mnu_todo(search)', '2005-07-31 16:31:01', 'AJM', NULL, NULL),
('SURVEY1', 'mnu_todo(search)', '2005-07-31 16:31:09', 'AJM', NULL, NULL),
('USER1', 'mnu_todo(search)', '2005-07-31 16:31:17', 'AJM', NULL, NULL),
('USER2', 'mnu_todo(search)', '2005-07-31 16:31:24', 'AJM', NULL, NULL),
('USER3', 'mnu_todo(search)', '2005-07-31 16:31:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_todo(upd)', 'Update ToDo', 'Update', 'PROC', 'mnu_todo_upd.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2005-07-30 17:57:00', 'AJM', '2005-07-30 18:12:35', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_todo(upd)', '2005-07-31 16:30:15', 'AJM', NULL, NULL),
('DEV', 'mnu_todo(upd)', '2005-07-31 16:30:31', 'AJM', NULL, NULL),
('READONLY', 'mnu_todo(upd)', '2005-07-31 16:30:53', 'AJM', NULL, NULL),
('SURVEY', 'mnu_todo(upd)', '2005-07-31 16:31:01', 'AJM', NULL, NULL),
('SURVEY1', 'mnu_todo(upd)', '2005-07-31 16:31:09', 'AJM', NULL, NULL),
('USER1', 'mnu_todo(upd)', '2005-07-31 16:31:17', 'AJM', NULL, NULL),
('USER2', 'mnu_todo(upd)', '2005-07-31 16:31:24', 'AJM', NULL, NULL),
('USER3', 'mnu_todo(upd)', '2005-07-31 16:31:30', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(add)', 'Add User', 'Insert', 'PROC', 'mnu_user_add.php', 'N', 'ADD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(del)', 'Delete User', 'Delete', 'PROC', 'mnu_user_del.php', 'N', 'DEL1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(del)', 'USER_PASSWORD', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_user(del)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('READONLY', 'mnu_user(del)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_user(del)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER1', 'mnu_user(del)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER2', 'mnu_user(del)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER3', 'mnu_user(del)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(enq)', 'Enquire User', 'Enquire', 'PROC', 'mnu_user_enq.php', 'N', 'ENQ1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(enq)', 'DUMMY1', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_user(enq)', 'USER_PASSWORD', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_user(enq)', '2005-04-19 18:12:42', 'AJM', NULL, NULL),
('READONLY', 'mnu_user(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_user(enq)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_user(enq)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('READONLY', 'mnu_user(enq)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_user(enq)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER1', 'mnu_user(enq)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER2', 'mnu_user(enq)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER3', 'mnu_user(enq)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(list)', 'List User', 'List User', 'PROC', 'mnu_user_list.php', 'N', 'LIST1', 'MENU', NULL, NULL, NULL, NULL, 'user_id', 'Y', NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2005-02-17 17:52:55', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(list)', 'mnu_user(add)', '001', 'New', 'N', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_user(list)', 'mnu_user(enq)', '002', 'Read', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_user(list)', 'mnu_user(upd)', '003', 'Update', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_user(list)', 'mnu_user(del)', '004', 'Delete', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_user(list)', 'mnu_user(upd)a', '005', 'Change Password', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_user(list)', 'mnu_user(upd)b', '006', 'Reset Password', 'Y', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_user(list)', 'mnu_todo(list)2', '007', 'ToDo', 'Y', '2005-07-30 19:18:31', 'AJM', '2005-07-30 19:18:47', 'AJM'),
('mnu_user(list)', 'mnu_user(search)', '008', 'Search', 'N', '2003-01-01 12:00:00', 'AJM', '2005-07-30 19:18:47', 'AJM'),
('mnu_user(list)', 'audit_dtl(list)3', '009', 'Audit Trail', 'Y', '2004-04-09 11:39:20', 'AJM', '2005-07-30 19:18:47', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('READONLY', 'mnu_user(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_user(list)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER3', 'mnu_user(list)', '2005-07-31 15:17:14', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(list)2', 'List User by Role', 'List User', 'PROC', 'mnu_user_list2.php', 'N', 'LIST2', 'MENU', NULL, NULL, NULL, NULL, 'user_id', 'N', NULL, NULL, '2003-01-01 12:00:00', 'AJM', '2004-05-18 14:15:22', 'AJM');

REPLACE INTO `mnu_nav_button` (`task_id_snr`, `task_id_jnr`, `sort_seq`, `button_text`, `context_preselect`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(list)2', 'audit_dtl(list)3', '001', 'Audit Trail', 'Y', '2004-04-09 11:59:34', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(popup)', 'Choose User', 'Choose', 'PROC', 'mnu_user_popup.php', 'N', 'POPUP', 'MENU', NULL, NULL, NULL, NULL, 'user_id', 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', '2004-12-25 11:37:13', 'AJM');

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_user(popup)', '2005-04-19 18:12:42', 'AJM', NULL, NULL),
('SURVEY', 'mnu_user(popup)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(search)', 'Search User', 'Search', 'PROC', 'mnu_user_search.php', 'N', 'SRCH', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_user(search)', '2005-04-19 18:12:42', 'AJM', NULL, NULL),
('READONLY', 'mnu_user(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_user(search)', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(upd)', 'Update User', 'Update', 'PROC', 'mnu_user_upd.php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task_field` (`task_id`, `field_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(upd)', 'DUMMY1', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_user(upd)', 'DUMMY2', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_user(upd)', 'DUMMY3', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_user(upd)', 'DUMMY4', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('mnu_user(upd)', 'USER_PASSWORD', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_taskfield` (`role_id`, `task_id`, `field_id`, `access_type`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('SURVEY', 'mnu_user(upd)', 'DUMMY1', 'FULL', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_user(upd)', 'DUMMY2', 'NED', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('GLOBAL', 'mnu_user(upd)', 'USER_PASSWORD', 'FULL', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('READONLY', 'mnu_user(upd)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_user(upd)', 'USER_PASSWORD', 'NDI', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER1', 'mnu_user(upd)', 'USER_PASSWORD', 'FULL', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER2', 'mnu_user(upd)', 'USER_PASSWORD', 'FULL', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER3', 'mnu_user(upd)', 'USER_PASSWORD', 'FULL', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(upd)a', 'Change User Password', 'Change Password', 'PROC', 'mnu_user_upd(a).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('DEMO', 'mnu_user(upd)a', '2005-04-19 18:12:45', 'AJM', NULL, NULL),
('USER3', 'mnu_user(upd)a', '2005-07-31 15:17:36', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('mnu_user(upd)b', 'Reset User Password', 'Reset Password', 'PROC', 'mnu_user_upd(b).php', 'N', 'UPD1', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_role_task` (`role_id`, `task_id`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('READONLY', 'mnu_user(upd)b', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY', 'mnu_user(upd)b', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('SURVEY1', 'mnu_user(upd)b', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER1', 'mnu_user(upd)b', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER2', 'mnu_user(upd)b', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('USER3', 'mnu_user(upd)b', '2003-01-01 12:00:00', 'AJM', NULL, NULL);

REPLACE INTO `mnu_task` (`task_id`, `task_desc`, `button_text`, `task_type`, `script_id`, `is_disabled`, `dialog_type_id`, `subsys_id`, `initial_passthru`, `selection_fixed`, `selection_temp`, `settings`, `order_by`, `keep_data`, `log_sql_query`, `screen_refresh`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('main_menu', 'Main index page', 'Menu1', 'MENU', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL),
('menu01', 'Menu System', 'Menu System', 'MENU', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2004-01-01 00:00:00', 'AJM', NULL, NULL),
('proto', 'Prototype Applications', 'PROTO', 'MENU', 'menu.php', 'N', 'MENU', 'MENU', NULL, NULL, NULL, NULL, NULL, 'N', NULL, NULL, '2005-05-05 17:45:29', 'AJM', NULL, NULL);

REPLACE INTO `mnu_menu` (`menu_id`, `task_id_jnr`, `sort_seq`, `button_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('main_menu', 'menu01', '001', 'Menu System', '2004-09-08 18:07:24', 'AJM', '2004-09-08 18:07:33', 'AJM'),
('main_menu', 'proto', '005', 'Prototypes', '2005-05-05 17:46:59', 'AJM', '2005-06-12 12:17:52', 'AJM'),
('menu01', 'mnu_control(upd)', '001', 'Menu Controls', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('menu01', 'mnu_dialog_type(list)', '002', 'Dialog Type', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('menu01', 'mnu_subsystem(list)', '003', 'Subsystem', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('menu01', 'mnu_task(list)', '004', 'Task (All)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('menu01', 'mnu_task(list)a', '005', 'Task (Proc)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('menu01', 'mnu_task(list)b', '006', 'Task (Menu)', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('menu01', 'mnu_role(list)', '007', 'Role', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('menu01', 'mnu_user(list)', '008', 'User', '2003-01-01 12:00:00', 'AJM', NULL, NULL),
('menu01', 'mnu_todo(list)', '009', 'ToDo', '2005-07-30 17:59:41', 'AJM', '2005-07-30 18:00:05', 'AJM');

REPLACE INTO `help_text` (`task_id`, `help_text`, `created_date`, `created_user`, `revised_date`, `revised_user`) VALUES 
('logon', 'Welcome to Tony Marston\'s amazing Menu & Security system.

You must enter a valid user id and password before you can continue any further.

The password field is case-sensitive, so watch out for the \'caps lock\' key.

Refer to <a href=\"%root%/mnu_logon.html\">Logon screen</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 17:43:05', 'AJM'),
('menu', 'This is the first page the user sees after passing through the logon screen. It is also the page that is shown whenever the user selects an option from the menu bar instead of the navigation bar.

Refer to <a href=\"%root%/mnu_menu.html\">Menu/Home Page</a> for full details.', '2005-07-02 18:09:35', 'AJM', NULL, NULL),
('mnu_control(upd)', 'This will allow global settings on the MENU CONTROL table to be changed.

Refer to <a href=\"%root%/mnu_control(upd).html\">Update Menu Control data</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:23:40', 'AJM'),
('mnu_dialog_type(add)', 'This will allow a new record to be added to the DIALOG TYPE table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_dialog_type(add).html\">Add Dialog Type</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:23:48', 'AJM'),
('mnu_dialog_type(del)', 'This will display a record from the DIALOG TYPE table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_dialog_type(del).html\">Delete Dialog Type</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:23:55', 'AJM'),
('mnu_dialog_type(enq)', 'This will display the contents of a record from the DIALOG TYPE table.

Refer to <a href=\"%root%/mnu_dialog_type(enq).html\">Enquire Dialog Type</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:24:00', 'AJM'),
('mnu_dialog_type(list)', 'This will list records on the DIALOG TYPE table.

Refer to <a href=\"%root%/mnu_dialog_type(list).html\">List Dialog Type</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:24:06', 'AJM'),
('mnu_dialog_type(search)', 'This will allow search criteria to be entered for the DIALOG TYPE table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_dialog_type(search).html\">Search Dialog Type</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:24:12', 'AJM'),
('mnu_dialog_type(upd)', 'This will display the contents of a record from the DIALOG TYPE table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_dialog_type(upd).html\">Update Dialog Type</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:24:18', 'AJM'),
('mnu_help_text(multi)', 'This will allow the contents of the HELP TEXT table to be maintained.

Refer to <a href=\"%root%/mnu_help_text(multi).html\">Maintain Help Text</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:24:24', 'AJM'),
('mnu_menu(link)', 'This will display the contents of the MENU table for a selected task of type \'menu\'.

Refer to <a href=\"%root%/mnu_menu(link).html\">Maintain Menu Items (2)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:24:30', 'AJM'),
('mnu_menu(list)', 'This will list records on the MENU table for a selected Task of type \'menu\'.

Refer to <a href=\"%root%/mnu_menu(list).html\">List Menu Items</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:24:35', 'AJM'),
('mnu_menu(multi)', 'This will display the contents of the MENU table for a selected task of type \'menu\'. 

Refer to <a href=\"%root%/mnu_menu(multi).html\">Maintain Menu Items (1)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:24:41', 'AJM'),
('mnu_menu(search)', 'This will allow search criteria to be entered for the MENU table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_menu(search).html\">Search Menu Items</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:25:28', 'AJM'),
('mnu_menu(upd)', 'This will display the contents of a record from the MENU table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_menu(upd).html\">Update Menu Item</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:25:56', 'AJM'),
('mnu_nav_button(link)', 'This will display the contents of the NAVIGATION BUTTON table for a selected Task. Each of these will appear in the navigation bar area for the seected task.

Refer to <a href=\"%root%/mnu_nav_button(link).html\">Maintain Navigation Buttons (2)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:26:07', 'AJM'),
('mnu_nav_button(list)', 'This will list records on the NAVIGATION BUTTON table for a selected TASK.

Refer to <a href=\"%root%/mnu_nav_button(list).html\">List Navigation Buttons</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:26:16', 'AJM'),
('mnu_nav_button(multi)', 'This will display the contents of the NAVIGATION BUTTON table for a selected task. 

Refer to <a href=\"%root%/mnu_nav_button(multi).html\">Maintain Navigation Buttons (1)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:26:20', 'AJM'),
('mnu_nav_button(search)', 'This will allow search criteria to be entered for the NAVIGATION BUTTON table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_nav_button(search).html\">Search Navigation Button</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:26:26', 'AJM'),
('mnu_nav_button(upd)', 'This will display the contents of a record from the NAVIGATION BUTTON table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_nav_button(upd).html\">Update Navigation Button</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:26:32', 'AJM'),
('mnu_role(add)', 'This will allow a new record to be added to the ROLE table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_role(add).html\">Add Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:26:37', 'AJM'),
('mnu_role(del)', 'This will display a record from the ROLE table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_role(del).html\">Delete Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:26:42', 'AJM'),
('mnu_role(enq)', 'This will display the contents of a record from the ROLE table.

Refer to <a href=\"%root%/mnu_role(enq).html\">Enquire Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:26:48', 'AJM'),
('mnu_role(list)', 'This will list records on the ROLE table.

Refer to <a href=\"%root%/mnu_role(list).html\">List Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:26:57', 'AJM'),
('mnu_role(popup)', 'This will list records on the ROLE table and allow one or more to be selected.

After selecting records please press the CHOOSE button.

Refer to <a href=\"%root%/mnu_role(popup).html\">Choose Role</a> for full details.', '2004-08-26 14:08:25', 'AJM', '2005-07-02 15:27:03', 'AJM'),
('mnu_role(search)', 'This will allow search criteria to be entered for the ROLE table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_role(search).html\">Search Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:27:09', 'AJM'),
('mnu_role(upd)', 'This will display the contents of a record from the ROLE table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_role(upd).html\">Update Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:27:14', 'AJM'),
('mnu_role_task(link)a', 'This will display the contents of the ROLE TASK table for a selected task and allow updates to be made.

Refer to <a href=\"%root%/mnu_role_task(link)a.html\">Link Role(s) to selected task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:27:20', 'AJM'),
('mnu_role_task(link)b', 'This will display the contents of the ROLE TASK table for a selected role and allow updates to be made.

Refer to <a href=\"%root%/mnu_role_task(link)b.html\">Link Task(s) to selected Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:27:27', 'AJM'),
('mnu_role_taskfield(multi)a', 'This will show the contents of the ROLE TASK FIELD table for a selected Task and allow changes to be made.

Refer to <a href=\"%root%/mnu_role_taskfield(multi)a.html\">Maintain Field Access via Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:27:32', 'AJM'),
('mnu_role_taskfield(multi)b', 'This will show the contents of the ROLE TASK FIELD table for a selected Role and allow changes to be made.

Refer to <a href=\"%root%/mnu_role_taskfield(multi)b.html\">Maintain Field Access via Role</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:27:37', 'AJM'),
('mnu_subsystem(add)', 'This will allow a new record to be added to the SUBSYSTEM table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_subsystem(add).html\">Add Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:27:45', 'AJM'),
('mnu_subsystem(del)', 'This will display a record from the SUBSYSTEM table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_subsystem(del).html\">Delete Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:27:51', 'AJM'),
('mnu_subsystem(enq)', 'This will display the contents of a record from the SUBSYSTEM table.

Refer to <a href=\"%root%/mnu_subsystem(enq).html\">Enquire Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:27:56', 'AJM'),
('mnu_subsystem(list)', 'This will list records on the SUBSYSTEM table.

Refer to <a href=\"%root%/mnu_subsystem(list).html\">List Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:28:26', 'AJM'),
('mnu_subsystem(search)', 'This will allow search criteria to be entered for the SUBSYSTEM table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_subsystem(search).html\">Search Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:28:32', 'AJM'),
('mnu_subsystem(upd)', 'This will display the contents of a record from the SUBSYSTEM table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_subsystem(upd).html\">Update Subsystem</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:28:38', 'AJM'),
('mnu_task(add)', 'This will allow a new record to be added to the TASK table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_task(add).html\">Add Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:28:43', 'AJM'),
('mnu_task(del)', 'This will display a record from the TASK table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_task(del).html\">Delete Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:28:48', 'AJM'),
('mnu_task(enq)', 'This will display the contents of a record from the TASK table.

Refer to <a href=\"%root%/mnu_task(enq).html\">Enquire Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:28:55', 'AJM'),
('mnu_task(list)', 'This will list records on the TASK table regardless of their TASK-TYPE.

Refer to <a href=\"%root%/mnu_task(list).html\">List Task (All)</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:29:00', 'AJM'),
('mnu_task(list)2', 'This will list records on the TASK table for a selected DIALOG TYPE.

Refer to <a href=\"%root%/mnu_task(list)2.html\">List Task by Dialog Type</a> for full details.', '2004-08-26 12:09:31', 'AJM', '2005-07-02 15:29:05', 'AJM'),
('mnu_task(list)3', 'This will list records on the TASK table for a selected SUBSYSTEM.

Refer to <a href=\"%root%/mnu_task(list)3.html\">List Task by Subsystem</a> for full details.', '2004-08-26 12:09:43', 'AJM', '2005-07-02 15:29:11', 'AJM'),
('mnu_task(list)a', 'This will list records on the TASK table where type = \'TASK\'.

Refer to <a href=\"%root%/mnu_task(list)a.html\">List Task (Proc)</a> for full details.', '2004-08-26 12:07:32', 'AJM', '2005-07-02 15:29:16', 'AJM'),
('mnu_task(list)b', 'This will list records on the TASK table where type = \'MENU\'.

Refer to <a href=\"%root%/mnu_task(list)b.html\">List Task (Menu)</a> for full details.', '2004-08-26 12:07:39', 'AJM', '2005-07-02 15:29:22', 'AJM'),
('mnu_task(popup)', 'This will list records on the TASK table and allow one or more to be selected.

After selecting records please press the CHOOSE button.

Refer to <a href=\"%root%/mnu_task(popup).html\">Choose Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:29:29', 'AJM'),
('mnu_task(popup)a', 'This will list records on the TASK table and allow one or more to be selected.

After selecting records please press the CHOOSE button.

Refer to <a href=\"%root%/mnu_task(popup)a.html\">Choose Task (Proc)</a> for full details.', '2004-08-26 14:09:00', 'AJM', '2005-07-02 15:29:33', 'AJM'),
('mnu_task(popup)b', 'This will list records on the TASK table and allow one or more to be selected.

After selecting records please press the CHOOSE button.

Refer to <a href=\"%root%/mnu_task(popup)b.html\">Choose Task (Menu)</a> for full details.', '2004-08-26 14:09:10', 'AJM', '2005-07-02 15:29:38', 'AJM'),
('mnu_task(rename)', 'This will allow a entry on the TASK table to be renamed. It will also rename any associated records on any related tables. 

Refer to <a href=\"%root%/mnu_task(rename).html\">Rename Task</a> for full details.', '2004-08-26 12:25:54', 'AJM', '2005-07-02 15:29:44', 'AJM'),
('mnu_task(search)', 'This will allow search criteria to be entered for the TASK table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_task(search).html\">Search Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:29:50', 'AJM'),
('mnu_task(upd)', 'This will display the contents of a record from the TASK table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_task(upd).html\">Update Task</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:29:55', 'AJM'),
('mnu_task_field(add)', 'This will allow a record to be added to the TASK FIELD table for a selected TASK.

Refer to <a href=\"%root%/mnu_task_field(add).html\">Add Task Field</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:30:01', 'AJM'),
('mnu_task_field(del)', 'This will display a record from the TASK FIELD table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_task_field(del).html\">Delete Task Field</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:30:06', 'AJM'),
('mnu_task_field(list)', 'This will list records on the TASK FIELD table for a selected TASK.

Refer to <a href=\"%root%/mnu_task_field(list).html\">List Task Field</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:30:11', 'AJM'),
('mnu_user(add)', 'This will allow a new record to be added to the USER table.

Enter your data then press the SUBMIT button to add it to the database.

Refer to <a href=\"%root%/mnu_user(add).html\">Add User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:30:17', 'AJM'),
('mnu_user(del)', 'This will display a record from the USER table and allow it to be deleted.

Refer to <a href=\"%root%/mnu_user(del).html\">Delete User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:30:22', 'AJM'),
('mnu_user(enq)', 'This will display the contents of a record from the USER table.

Refer to <a href=\"%root%/mnu_user(enq).html\">Enquire User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:30:27', 'AJM'),
('mnu_user(list)', 'This will list records on the USER table.

Refer to <a href=\"%root%/mnu_user(list).html\">List User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:30:33', 'AJM'),
('mnu_user(list)2', 'This will list records on the USER table for a selected ROLE.

Refer to <a href=\"%root%/mnu_user(list)2.html\">List User by Role</a> for full details.', '2004-08-26 12:10:17', 'AJM', '2005-07-02 15:30:39', 'AJM'),
('mnu_user(popup)', 'This will list records on the USER table and allow one or more to be selected.

After selecting records please press the CHOOSE button to return to the previous screen.

Refer to <a href=\"%root%/mnu_user(popup).html\">Choose User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:30:45', 'AJM'),
('mnu_user(search)', 'This will allow search criteria to be entered for the USER table.

Enter selection criteria then press the SUBMIT button to pass it back to the previous task for processing.

Refer to <a href=\"%root%/mnu_user(search).html\">Search User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:30:50', 'AJM'),
('mnu_user(upd)', 'This will display the contents of a record from the USER table and allow it to be updated. 

Refer to <a href=\"%root%/mnu_user(upd).html\">Update User</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:30:56', 'AJM'),
('mnu_user(upd)a', 'This will allow a user\'s password to be changed.

Refer to <a href=\"%root%/mnu_user(upd)a.html\">Change User Password</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:31:01', 'AJM'),
('mnu_user(upd)b', 'This will allow a user\'s password to be changed.

Refer to <a href=\"%root%/mnu_user(upd)b.html\">Reset User Password</a> for full details.', '2003-01-01 12:00:00', 'AJM', '2005-07-02 15:31:07', 'AJM');

-- finished