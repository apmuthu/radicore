<?php
//*****************************************************************************
// This will allow a single occurrences of a database table to be updated.
// The identity of the selected occurrence is passed down from the previous screen.
//*****************************************************************************

$table_id = "wf_workitem";                  // table id
$screen   = 'workitem.detail.screen.inc';   // file identifying screen structure

require 'std.update1.inc';                  // activate page controller

?>
