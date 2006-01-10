<?php
// *****************************************************************************
// List the contents of a database table and allow the user to choose one
// (or more) for processing by te previous screen.
// *****************************************************************************

//DebugBreak();
$table_id = 'crs_lesson';                  // table name
$screen   = 'crs_lesson.list.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = '';
$sql_from   = '';
$sql_where  = '';
$sql_groupby = '';

// set default sort sequence
$sql_orderby = null;

// activate page controller
require 'std.list1.popup.inc';

?>
