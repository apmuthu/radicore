<?php
//*****************************************************************************
// This will allow occurrences of a database table to be deleted.
// The identity of the selected occurrence(s) is passed from the previous screen.
//*****************************************************************************

//DebugBreak();
$table_id = 'crs_student';             	       // table id
$screen   = 'crs_student.detail.screen.inc';   // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = NULL;
$sql_from   = NULL;
$sql_where  = NULL;

// activate page controller
require 'std.delete1.inc';

?>
