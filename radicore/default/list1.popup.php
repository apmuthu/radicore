<?php
// *****************************************************************************
// List the contents of a database table and allow the user to select one or
// more entries by means of a CHOOSE button.
// *****************************************************************************

//DebugBreak();
$table_id = '#tablename#';                      // table name
$screen   = '#tablename#.list1.screen.inc';     // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select  = '';
$sql_from    = '';
$sql_where   = '';
$sql_groupby = '';

require 'std.list1.popup.inc';                  // activate page controller

?>
