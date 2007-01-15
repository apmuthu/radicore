<?php
// *****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
// *****************************************************************************

//DebugBreak();
$table_id = 'crs_teacher';                  // table name
$screen   = 'crs_teacher.list.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = 'crs_teacher.*';
$sql_from   = '';
$sql_where  = '';
$sql_groupby = '';

// set default sort sequence
$sql_orderby = null;

// activate page controller
require 'std.list1.inc';

?>
