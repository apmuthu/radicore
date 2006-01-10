<?php
//*****************************************************************************
// This will allow a database record table to be updated, or inserted if it does
// not currently exist.
// The identity of the selected record is passed down in $where.
//*****************************************************************************

//DebugBreak();
$table_id = '#tablename#';                     // table id
$screen   = '#tablename#.detail.screen.inc';   // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = '';
$sql_from   = '';
$sql_where  = '';

// define action buttons
$act_buttons['clear'] = 'CLEAR';

require 'std.multi1.inc';           // activate page controller

?>
