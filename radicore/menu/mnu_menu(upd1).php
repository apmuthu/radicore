<?php
//*****************************************************************************
// This will allow an occurrences of a database table to be updated.
// The identity of the selected occurrence is passed down from the previous screen.
//*****************************************************************************

$table_id = "mnu_menu";                     // table id
$screen   = 'mnu_menu.detail.screen.inc';   // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = '';
$sql_from   = '';
$sql_where  = '';

require 'std.update1.inc';                  // activate page controller

?>
