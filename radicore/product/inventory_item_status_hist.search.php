<?php
//*****************************************************************************
// Show a blank detail screen for a database table and allow the user to enter
// selection criteria, which will be passed back to the previous screen.
//*****************************************************************************

$table_id = "inventory_item_status_hist";                    // table id
$screen   = 'inventory_item_status_hist.detail.screen.inc';  // file identifying screen structure

require 'std.search1.inc';                      // activate page controller

?>