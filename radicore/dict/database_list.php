<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$table_id = 'dict_database';    	            // table name
$screen   = 'dict_database.list.screen.inc';    // file identifying screen structure

require_once 'config.inc';

$sql_select = 'dict_database.database_id, database_desc, subsys_desc, count(dict_table.database_id) as table_count';
$sql_from   = 'dict_database '
             .'LEFT JOIN dict_table ON (dict_table.database_id=dict_database.database_id) '
             .'LEFT JOIN ' .$GLOBALS['dbprefix'] .'menu.mnu_subsystem ON (mnu_subsystem.subsys_id=dict_database.subsys_id)';
$sql_groupby = 'dict_database.database_id, database_desc, subsys_desc';

require 'std.list1.inc';                        // activate page controller

?>
