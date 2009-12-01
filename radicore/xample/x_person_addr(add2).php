<?php
//*****************************************************************************
// Allow a new occurrence to be added to a database table as a child record
// to an existing parent. The primary key of the parent is selected in the
// previous screen.
//*****************************************************************************

$table_id = 'x_person_addr';                      // table name
$screen   = 'x_person_addr.detail.screen.inc';    // file identifying screen structure

require 'std.add2.inc';     // activate page controller

?>
