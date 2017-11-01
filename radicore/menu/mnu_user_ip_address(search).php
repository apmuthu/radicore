<?php
//*****************************************************************************
// Show a blank detail screen for a database table and allow the user to enter
// selection criteria, which will be passed back to the previous screen.
//*****************************************************************************

$table_id = 'mnu_user_ip_address';                    // table id
$screen   = 'mnu_user_ip_address.detail.screen.inc';  // file identifying screen structure

$sql_search_table = null;			// name under which details will be saved

require 'std.search1.inc';          // activate page controller

?>
