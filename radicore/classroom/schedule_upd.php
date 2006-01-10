<?php
//*****************************************************************************
// This will allow an occurrences of a database table to be updated.
// The identity of the selected occurrence is passed down from the previous screen.
//*****************************************************************************

//DebugBreak();
$table_id = 'crs_schedule';                     // table id
$screen   = 'crs_schedule.detail.screen.inc';   // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = NULL;
$sql_from   = NULL;
$sql_where  = NULL;

// activate page controller
require 'std.update1.inc';

?>
