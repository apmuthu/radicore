<?php
//*****************************************************************************
// List the contents of a database table and allow the user to choose one or
// more by pressing the CHOOSE button.
//*****************************************************************************

//DebugBreak();
$table_id = 'mnu_task';    	            // table name
$screen   = 'mnu_task.list.screen.inc'; // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = NULL;
$sql_from   = NULL;
$sql_where  = NULL;

// set default sort sequence
$sql_orderby = NULL;

require 'std.list1.popup.inc';          // activate page controller

?>
