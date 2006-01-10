<?php
//*****************************************************************************
// This will allow occurrences of the INNER table to be displayed and modified.
// This version starts by showing the exiting entries, then allows the user
// to add, delete or modify entries.
// The identity of the OUTER table is passed down from the previous screen.
//*****************************************************************************

//DebugBreak();
$outer_table = 'product';				           // name of outer table
$inner_table = 'good_identification';              // name of inner table
$screen = 'good_identification.list.screen.inc';   // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = '';
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

$inner_sql_select = 'good_identification.*, identity_type_desc';
$inner_sql_from   = 'good_identification '.
                    'LEFT JOIN good_identity_type '.
                    'ON (good_identity_type.identity_type_id=good_identification.identity_type_id)';
$inner_sql_where  = '';

// set default sort sequence
$inner_sql_orderby = '';

// activate page controller
require 'std.list2.inc';

?>
