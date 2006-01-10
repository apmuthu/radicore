<?php
//*****************************************************************************
// This will allow occurrences of the INNER table to be displayed and modified.
// This version allows starts by showing the exiting entries, then allows the
// user to add, delete or modify entries.
// The identity of the OUTER table is passed down from the previous screen.
//*****************************************************************************

//DebugBreak();
$outer_table = 'survey_type';                // name of outer table
$inner_table = 'survey_hdr';                 // name of inner table
$screen   = 'survey_hdr.list(a).screen.inc'; // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = NULL;
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

$inner_sql_select = '';
$inner_sql_from   = '';
$inner_sql_where  = NULL;
$inner_sql_groupby = '';

// set default sort sequence
$inner_sql_orderby = NULL;

// activate page controller
require 'std.list2.inc';

?>
