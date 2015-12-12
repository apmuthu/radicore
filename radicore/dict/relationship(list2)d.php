<?php
//*****************************************************************************
// List the contents of the INNER table for a particular ID rom the OUTER table
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$outer_table = 'dict_database_jnr';                 // name of outer table
$inner_table = 'dict_relationship_snr';             // name of inner table
$screen   = 'dict_relationship.list2d.screen.inc';  // file identifying screen structure

require 'std.list2.inc';                            // activate page controller

?>
