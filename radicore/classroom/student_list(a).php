<?php
//*****************************************************************************
// List the contents of the STUDENT table for a particular value of LESSON_ID
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons. 
//*****************************************************************************

//DebugBreak();
$outer_table = 'crs_lesson_s01';                 // name of outer table
$inner_table = 'crs_student_lesson';             // name of inner table
$screen      = 'crs_student.list(a).screen.inc'; // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = '';
$outer_sql_from   = '';
$outer_sql_where  = NULL;

$inner_sql_select = 'crs_student_lesson.lesson_id, crs_student_lesson.student_id, crs_student.first_name, crs_student.last_name, crs_student.initials';
$inner_sql_from   = 'crs_student_lesson '.
                    'LEFT JOIN crs_student ON (crs_student.student_id=crs_student_lesson.student_id)';
$inner_sql_where  = '';
$inner_search_table = 'crs_student';

// set default sort sequence
$inner_sql_orderby = 'crs_student_lesson.lesson_id';

// activate page controller
require 'std.list2.inc';

?>
