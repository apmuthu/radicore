<?php
//*****************************************************************************
// Read an entry from the PARENT (outer) table (as selected in the previous screen),
// then read one or more entries from the CHILD (middle) table showing them one at a
// time, then read multiple entries from the GRANDCHILD (inner) table and allow the
// user to view/modify entries by activating other screens via navigation buttons.
//*****************************************************************************

//DebugBreak();
$outer_table  = '#outer_table#';                     // name of outer (parent) table
$middle_table = '#middle_table#';                    // name of middle (child) table
$inner_table  = '#inner_table#';                     // name of inner (grandchild) table
$screen       = '#inner_table#.list3.screen.inc';    // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = '';
$outer_sql_from   = '';
$outer_sql_where  = '';

$middle_sql_select  = '';
$middle_sql_from    = '';
$middle_sql_where   = '';
$middle_sql_orderby = '';

$inner_sql_select   = '';
$inner_sql_from     = '';
$inner_sql_where    = '';
$inner_sql_groupby  = '';
$inner_search_table = '';

require 'std.list3.inc';            // activate page controller

?>
