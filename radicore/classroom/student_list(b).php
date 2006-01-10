<?php
//*****************************************************************************
// List the contents of the STUDENT table for a particular value of CLASS_ID
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons. 
//*****************************************************************************

//DebugBreak();
$outer_table = 'crs_class';                      // name of outer table
$inner_table = 'crs_student';                    // name of inner table
$screen      = 'crs_student.list(b).screen.inc'; // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = '';
$outer_sql_from   = '';
$outer_sql_where  = NULL;

$inner_sql_select = 'student_id, first_name, last_name, initials';
$inner_sql_from   = '';
$inner_sql_where  = '';
$inner_search_table = 'crs_student';

// set default sort sequence
$inner_sql_orderby = 'crs_student.last_name';

// activate page controller
require 'std.list2.inc';

?>
