<?php
//*****************************************************************************
// This will allow an occurrences of the PERS_TYPE table to be updated.
// The identity of the selected occurrence is passed down from the previous screen.
//*****************************************************************************

//DebugBreak();
$table_id = "x_pers_type";                   // table id
$screen   = 'pers_type.detail.screen.inc';   // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = NULL;
$sql_from   = NULL;
$sql_where  = NULL;

require 'std.update1.inc';                  // activate page controller

?>
