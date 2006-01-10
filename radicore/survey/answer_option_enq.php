<?php
//*****************************************************************************
// This will allow an occurrences of a database table to be displayed in detail.
// The identity of the selected occurrence is passed down from the previous screen.
//*****************************************************************************

//DebugBreak();

$table_id = 'answer_option';                    // table id
$screen   = 'answer_option.detail.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = NULL;
$sql_from   = NULL;
$sql_where  = NULL;

// activate page controller
require 'std.enquire1.inc';

?>
