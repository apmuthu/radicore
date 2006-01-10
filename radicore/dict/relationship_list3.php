<?php
//*****************************************************************************
// List the contents of the INNER table for a particular ID rom the OUTER table
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons. 
//*****************************************************************************

//DebugBreak();
$outer_table = 'dict_database';                     // name of outer table
$inner_table = 'dict_relationship';                 // name of inner table
$screen   = 'dict_relationship.list3.screen.inc';   // file identifying screen structure

// activate page controller
require 'std.list2.inc';

?>
