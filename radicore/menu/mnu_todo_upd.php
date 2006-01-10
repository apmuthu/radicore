<?php
//*****************************************************************************
// This will allow a single occurrences of a database table to be updated.
// The identity of the selected occurrence is passed down from the previous screen.
//*****************************************************************************

//DebugBreak();
$table_id = 'mnu_todo';                      // table id
$screen   = 'mnu_todo.detail.screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = NULL;
$sql_from   = NULL;
$sql_where  = NULL;

require 'std.update1.inc';          // activate page controller

?>
