<?php
//*****************************************************************************
// This will allow occurrences of a CONTROL table to be created/updated.
// Although this table has a simple structure (record_id, field_id, field_value)
// what is shown on the screen is a customisable selection of field names and
// field values.
//*****************************************************************************

//DebugBreak();
$table_id = "#tablename#";                   // table id
$screen   = '#tablename#.detail.screen.inc'; // file identifying screen structure

require 'std.update3.inc';          // activate page controller

?>
