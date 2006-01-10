<?php
//*****************************************************************************
// This will allow an occurrences of the OPTION table to be deleted.
// The identity of the selected occurrence is passed down from the previous screen.
//*****************************************************************************

//DebugBreak();
$table_id = "x_option";                     // table id
$screen   = 'option.detail.screen.inc';     // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = NULL;
$sql_from   = NULL;
$sql_where  = NULL;

require 'std.delete1.inc';                  // activate page controller

?>
