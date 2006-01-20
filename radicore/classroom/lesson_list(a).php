<?php
//*****************************************************************************
// List the contents of the LESSON table for a particular value of STUDENT_ID
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
//*****************************************************************************

//DebugBreak();
$outer_table = 'crs_student';                   // name of outer table
$inner_table = 'crs_student_lesson';            // name of inner table
$screen      = 'crs_lesson.list(a).screen.inc'; // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = 'student_id, first_name, initials, last_name, class_id, year';
$outer_sql_from   = '';
$outer_sql_where  = NULL;

$inner_sql_select = 'crs_student_lesson.lesson_id, crs_student_lesson.student_id, crs_lesson.lesson_name, crs_lesson.teacher_id';
$inner_sql_from   = 'crs_student_lesson '.
                    'LEFT JOIN crs_lesson ON (crs_lesson.lesson_id=crs_student_lesson.lesson_id)';
$inner_sql_where  = '';
$inner_search_table = 'crs_lesson';

// set default sort sequence
$inner_sql_orderby = 'crs_student_lesson.student_id';

// activate page controller
require 'std.list2.inc';

?>
