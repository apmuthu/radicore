<?php
//*****************************************************************************
// List the contents of a database table and allow the user to choose one or
// more occurrences. The identity of those selected will be returned to the
// previous screen.
//*****************************************************************************

$table_id = 'wf_place';                 // table name
$screen   = 'place.list.screen.inc';    // file identifying screen structure

require 'std.list1.popup.inc';          // activate page controller

?>
