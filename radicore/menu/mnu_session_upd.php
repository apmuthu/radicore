<?php
//*****************************************************************************
// This will allow the user to change various settings in the current session.
//*****************************************************************************

$table_id = "mnu_session";                      // table id
$screen   = 'mnu_session.detail.screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = '';
$sql_from   = '';
$sql_where  = '';

require 'std.update3.inc';                      // activate page controller

?>
