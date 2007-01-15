<?php
//*****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$table_id = 'mnu_user';                     // table name
$screen   = 'mnu_user.list.screen.inc';     // file identifying screen structure

$sql_select  = 'user_id, user_name, role_id';

require 'std.list1.inc';                    // activate page controller

?>
