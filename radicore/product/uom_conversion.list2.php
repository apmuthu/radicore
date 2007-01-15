<?php
//*****************************************************************************
// This will allow occurrences of the INNER table to be displayed and modified.
// This version starts by showing the exiting entries, then allows the user
// to add, delete or modify entries.
// The identity of the OUTER table is passed down from the previous screen.
//*****************************************************************************

$outer_table = 'unit_of_measure';            // name of outer table
$inner_table = 'uom_conversion';             // name of inner table
$screen = 'uom_conversion.list2.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = '';
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

$inner_sql_select = '';
$inner_sql_from   = NULL;
$inner_sql_where  = NULL;

require 'std.list2.inc';            // activate page controller

?>
