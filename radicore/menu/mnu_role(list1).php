<?php
// *****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
// *****************************************************************************

$table_id = 'mnu_role';                 // table name
$screen = 'mnu_role.list1.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = 'mnu_role.role_id, start_task_id, global_access, role_name, count(mnu_user_role.user_id) as count';
$sql_from   = 'mnu_role LEFT JOIN mnu_user_role ON (mnu_user_role.role_id=mnu_role.role_id) ';
$sql_where  = '';
$sql_groupby = 'mnu_role.role_id';

// set default sort sequence
$sql_orderby = null;

require 'std.list1.inc';                // activate page controller

?>
