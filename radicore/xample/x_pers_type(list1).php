<?php
//*****************************************************************************
// List the contents of the PERS_TYPE table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$table_id = 'x_pers_type';                  // table name
$screen   = 'pers_type.list.screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = NULL;
$sql_from   = NULL;
$sql_where  = NULL;

// set default sort sequence
$sql_orderby = '';

require 'std.list1.inc';                    // activate page controller

?>
