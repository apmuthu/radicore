<?php
// Display help text for the specified task.

$table_id = 'help_text';

if ($_SERVER['SERVER_NAME'] == 'localhost') {
   // this is for my PC, not for my web host
   $root = "e:/www.ajm.net/www";
} // if

require 'std.help.inc';

?>
