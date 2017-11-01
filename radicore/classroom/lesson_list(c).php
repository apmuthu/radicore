<?php
//*****************************************************************************
// List the contents of the LESSON table for a particular value of TEACHER_ID
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$outer_table = 'crs_teacher';                   // name of outer table
$inner_table = 'crs_lesson';                    // name of inner table
$screen      = 'crs_lesson.list(c).screen.inc'; // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = '';
$outer_sql_from   = '';
$outer_sql_where  = NULL;

$inner_sql_select = null;
$inner_sql_from   = null;
$inner_sql_where  = null;
$inner_sql_groupby = null;
$inner_search_table = null;

// set default sort sequence
$inner_sql_orderby = '';

// activate page controller
require 'std.list2.inc';

?>
