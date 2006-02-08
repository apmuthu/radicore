<?php
//*****************************************************************************
// Allow occurrences of the MANY table in a ONE(a)-to-MANY-to-ONE(b)
// relationship to be created.
// The primary key for ONE(a) is passed from the previous screen while one or
// more primary keys from ONE(b) are selected in a separate popup screen.
//*****************************************************************************

$table_id = '#tablename#';      // table name

// this screen is used to select occurrences from ONE(b)
$popup_screen = '#tablename#(popup)';

require 'std.add3.inc';     // activate page controller

?>

