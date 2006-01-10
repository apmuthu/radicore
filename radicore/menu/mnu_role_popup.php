<?php
//*****************************************************************************
// List the contents of a database table and allow the user to choose one or
// more by pressing the CHOOSE button.
//*****************************************************************************

//DebugBreak();
$table_id = 'mnu_role';    	             // table name
$screen   = 'mnu_role.list.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = 'mnu_role.*, count(user_id) as count';
$sql_from   = 'mnu_role '.
              'LEFT JOIN mnu_user USING (role_id) ';
$sql_where  = NULL;
$sql_groupby = 'mnu_user.role_id';

// set default sort sequence
$sql_orderby = NULL;

require 'std.list1.popup.inc';          // activate page controller

?>
