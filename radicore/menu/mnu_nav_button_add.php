<?php
//*****************************************************************************
// Allow occurrences of the MANY table in a ONE(a)-to-MANY-to-ONE(b) relationship
// to be created.
// The primary key for ONE(a) is passed from the previous screen while one or
// more primary keys from ONE(b) are selected in a separate popup screen.
//*****************************************************************************

$table_id = 'mnu_nav_button';   // table name

// this screen is used to select occurrences of ONE(b)
$popup_screen = 'mnu_task(popup)a';

require 'std.add3.inc';         // activate page controller

?>

