<?php
//*****************************************************************************
// This will allow occurrences of a CONTROL table to be created/updated.
// Although this table has a simple structure (record_id, field_id, field_value)
// what is shown on the screen is a customisable selection of field names and
// field values.
//*****************************************************************************

//DebugBreak();
$table_id = "mnu_control";                   // table id
$screen   = 'mnu_control.detail.screen.inc'; // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = '';
$sql_from   = '';
$sql_where  = '';

// activate page controller
require 'std.update3.inc';

?>
