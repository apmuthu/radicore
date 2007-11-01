<?php
//*****************************************************************************
// This will allow a database record table to be updated, or inserted if it does
// not currently exist.
// The identity of the selected record is passed down in $where.
//*****************************************************************************

$table_id = 'help_text';                    // table id
$screen   = 'help_text.detail.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = NULL;
$sql_from   = NULL;
$sql_where  = NULL;

// add CLEAR to action buttons (this will also enable DELETE)
$act_buttons['clear'] = 'CLEAR';

require 'std.multi1.inc';                   // activate page controller

?>
