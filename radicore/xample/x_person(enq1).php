<?php
//*****************************************************************************
// This will allow an occurrences of the PERSON table to be displayed in detail.
// The identity of the selected occurrence is passed down from the previous screen.
//*****************************************************************************

//DebugBreak();
$table_id = 'x_person';                     // table id
$screen   = 'person.detail.screen.inc';     // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = NULL;
$sql_from   = NULL;
$sql_where  = NULL;

require 'std.enquire1.inc';                 // activate page controller

?>