<?php
//*****************************************************************************
// This will allow an occurrences of a database table to be updated.
// The identity of the selected occurrence is passed down from the previous screen.
// This version allows the user to change his/her password
//*****************************************************************************

$table_id = 'mnu_user_s02';                     // table id
$screen   = 'mnu_user.detail(pswd).screen.inc'; // file identifying screen structure

require 'std.update1.inc';                      // activate page controller

?>
