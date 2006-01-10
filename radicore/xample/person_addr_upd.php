<?php
//*****************************************************************************
// This will allow an occurrences of the PERSON_ADDR table to be updated.
// The identity of the selected occurrence is passed down from the previous screen.
//*****************************************************************************

//DebugBreak();
$table_id = "x_person_addr";                    // table id
$screen   = 'person_addr.detail.screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = '';
$sql_from   = '';
$sql_where  = '';

require 'std.update1.inc';                      // activate page controller

?>
