<?php
//*****************************************************************************
// This will allow an occurrences of a database table to be deleted.
// The identity of the selected occurrence is passed down from the previous screen.
//*****************************************************************************

$table_id = "inventory_variance_reason";                    // table id
$screen   = 'inventory_variance_reason.detail.screen.inc';  // file identifying screen structure

require 'std.delete1.inc';                      // activate page controller

?>
