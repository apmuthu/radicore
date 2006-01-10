<?php
//*****************************************************************************
// List the contents of the LESSON table for a particular value of CLASS_ID
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons. 
//*****************************************************************************

//DebugBreak();
$outer_table = 'crs_class';                     // name of outer table
$inner_table = 'crs_class_lesson_s01';          // name of inner table
$screen      = 'crs_lesson.list(b).screen.inc'; // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = 'class_id, class_name, year';
$outer_sql_from   = '';
$outer_sql_where  = NULL;

$inner_sql_select = 'crs_class_lesson.lesson_id, crs_class_lesson.class_id, crs_lesson.lesson_name, crs_lesson.teacher_id';
$inner_sql_from   = 'crs_class_lesson '.
                    'LEFT JOIN crs_lesson ON (crs_lesson.lesson_id=crs_class_lesson.lesson_id)';
$inner_sql_where  = '';
$inner_search_table = 'crs_lesson';

// set default sort sequence
$inner_sql_orderby = 'crs_class_lesson.class_id';

// activate page controller
require 'std.list2.inc';

?>
