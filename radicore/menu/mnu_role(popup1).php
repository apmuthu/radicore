<?php
//*****************************************************************************
// List the contents of a database table and allow the user to choose one or
// more by pressing the CHOOSE button.
//*****************************************************************************

$table_id = 'mnu_role';    	              // table name
$screen   = 'mnu_role.list1.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = 'mnu_role.*, count(user_id) as count';
$sql_from   = 'mnu_role LEFT JOIN mnu_user_role ON (mnu_user_role.role_id=mnu_role.role_id) ';
$sql_where  = NULL;
$sql_groupby = 'mnu_role.role_id';

// set default sort sequence
$sql_orderby = NULL;

require 'std.list1.popup.inc';          // activate page controller

?>
