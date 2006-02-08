<?php
// *****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
// *****************************************************************************

$table_id = 'mnu_role';                 // table name
$screen = 'mnu_role.list.screen.inc';   // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = 'mnu_role.role_id, mnu_role.start_task_id, mnu_role.global_access, mnu_role.role_desc, count(user_id) as count';
$sql_from   = 'mnu_role LEFT JOIN mnu_user USING (role_id) ';
$sql_where  = null;
$sql_groupby = 'mnu_role.role_id, mnu_role.start_task_id, mnu_role.global_access, mnu_role.role_desc';

// set default sort sequence
$sql_orderby = null;

require 'std.list1.inc';                // activate page controller

?>
