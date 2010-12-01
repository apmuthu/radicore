<?php
//*****************************************************************************
// Display help text for the specified task.
//*****************************************************************************

//$table_id = 'help_text';    // table id

if ($_SERVER['SERVER_NAME'] == 'localhost') {
   // this is for my PC, not for my web host
   $root = "e:/www.tonymarston.net/lypha";
} // if

require 'std.help.inc';     // activate page controller

?>
