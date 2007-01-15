<?php
//*****************************************************************************
// This will update one or more CHILD records in a PARENT-CHILD relationship.
// The identity of the PARENT (snr) is passed from the previous screen while
// the list of CHILD (jnr) entries is provided by a seperate popup screen.
// The updateSelection() method is used to perform the database update.
//*****************************************************************************

$table_id = '#tablename#';              // CHILD table name

$popup_task = '#popup_table#';  // name of popup
//$popup_repeat = TRUE;

require 'std.update2.inc';              // activate page controller

?>
