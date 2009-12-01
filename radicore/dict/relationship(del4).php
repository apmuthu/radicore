<?php
//*****************************************************************************
// This will allow occurrences of the OUTER database table to be deleted, as well
// as all related occurrences on the INNER table.
// The identity of the selected OUTER occurrence(s) is passed from the previous screen.
//*****************************************************************************

$outer_table = 'dict_relationship';                 // name of outer table
$inner_table = 'dict_related_column';               // name of inner table
$screen   = 'dict_related_column.list2.screen.inc'; // file identifying screen structure

require 'std.delete4.inc';                          // activate page controller

?>
