<?php
//*****************************************************************************
// This will allow occurrences of a database table to be deleted.
// The identity of the selected occurrence(s) is passed from the previous screen.
//*****************************************************************************

$table_id = 'dict_relationship';             	    // table id
$screen   = 'dict_relationship.detail.screen.inc';  // file identifying screen structure

require 'std.delete1.inc';                          // activate page controller

?>