<?php
//*****************************************************************************
// List the contents of the CLASS table for a particular value of LESSON_ID
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

$outer_table = 'crs_lesson_s01';                // name of outer table
$inner_table = 'crs_class_lesson';              // name of inner table
$screen      = 'crs_class.list(a).screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = 'lesson_id, lesson_name';
$outer_sql_from   = NULL;
$outer_sql_where  = NULL;

$inner_sql_select = null;
$inner_sql_from   = null;
$inner_sql_where  = null;
$inner_sql_groupby  = null;
$inner_search_table = 'crs_class';

// set default sort sequence
$inner_sql_orderby = 'crs_class.class_name';

require 'std.list2.inc';                // activate page controller

?>
