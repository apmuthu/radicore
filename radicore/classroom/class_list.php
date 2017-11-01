<?php
// *****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
// *****************************************************************************

$table_id = 'crs_class';                  // table name
$screen   = 'crs_class.list.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = null;
$sql_from   = null;
$sql_where  = null;
$sql_groupby = null;

require 'std.list1.inc';                // activate page controller

?>
