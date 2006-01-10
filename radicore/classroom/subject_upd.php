<?php
//*****************************************************************************
// This will allow a single occurrences of a database table to be updated.
// The identity of the selected occurrence is passed down from the previous screen.
//*****************************************************************************

//DebugBreak();
$table_id = 'crs_subject';                      // table id
$screen   = 'crs_subject.detail.screen.inc';    // file identifying screen structure

require 'std.update1.inc';          // activate page controller

?>
