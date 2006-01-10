<?php
//*****************************************************************************
// This is for a PARENT-CHILD-GRANDCHILD relationship (ONE-to-MANY-to-MANY).
// An occurrence of the PARENT (outer) is selected using values passed down from the
// previous form. One or more associated occurrences are then read from the
// CHILD (middle), followed by multiple entries from the GRANDCHILD (inner).
// Entries from the GRANDCHILD may be inserted, amended or deleted.
// Only a single occurrence of the PARENT and CHILD will be shown at any one
// time, but scrolling areas will be shown if more occurrences are available.
//*****************************************************************************

//DebugBreak();
$outer_table  = '#outer_table#';				    // name of outer table
$middle_table = '#middle_table#';                   // name of table to be amended
$inner_table  = '#inner_table#';                    // name of inner table
$screen       = '#inner_table#.multi4.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = '';
$outer_sql_from   = '';
$outer_sql_where  = '';

$middle_sql_select = '';
$middle_sql_from   = '';
$middle_sql_where  = '';

$inner_sql_select = '';
$inner_sql_from   = '';
$inner_sql_where  = '';
$inner_sql_groupby = '';

require 'std.multi3.inc';                       // activate page controller

?>
