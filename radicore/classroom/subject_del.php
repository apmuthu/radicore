<?php
//*****************************************************************************
// This will allow occurrences of a database table to be deleted.
// The identity of the selected occurrence(s) is passed from the previous screen.
//*****************************************************************************

//DebugBreak();
$table_id = 'crs_subject';             	        // table id
$screen   = 'crs_subject.detail.screen.inc';    // file identifying screen structure

require 'std.delete1.inc';          // activate page controller

?>
