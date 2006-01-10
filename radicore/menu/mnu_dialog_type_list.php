<?php 
// *****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
// *****************************************************************************

//DebugBreak();
$table_id = 'mnu_dialog_type';                  // table name
$screen = 'mnu_dialog_type.list.screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = 'mnu_dialog_type.dialog_type_id, mnu_dialog_type.dialog_type_desc, count(task_id) as count';
$sql_from   = 'mnu_dialog_type ' . 'LEFT JOIN mnu_task USING (dialog_type_id) ';
$sql_where  = null;
$sql_groupby = 'mnu_dialog_type.dialog_type_id, mnu_dialog_type.dialog_type_desc';

// set default sort sequence
$sql_orderby = null;

// activate page controller
require 'std.list1.inc';

?>
