<?php
//*****************************************************************************
// This will allow an occurrences of a database table to be deleted.
// The identity of the selected occurrence is passed down from the previous screen.
//*****************************************************************************

//DebugBreak();
$table_id = "prod_cat_class";                    // table id
$screen   = 'prod_cat_class.detail.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = NULL;
$sql_from   = NULL;
$sql_where  = NULL;

// activate page controller
require 'std.delete1.inc';

?>
