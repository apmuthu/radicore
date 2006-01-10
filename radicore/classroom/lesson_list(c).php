<?php
//*****************************************************************************
// List the contents of the LESSON table for a particular value of TEACHER_ID
// (as selected in the previous screen) and allow the user to view/modify
// the contents by activating other screens via navigation buttons. 
//*****************************************************************************

//DebugBreak();
$outer_table = 'crs_teacher';                   // name of outer table
$inner_table = 'crs_lesson';                    // name of inner table
$screen      = 'crs_lesson.list(c).screen.inc'; // file identifying screen structure

// identify extra parameters for a JOIN
$outer_sql_select = '';
$outer_sql_from   = '';
$outer_sql_where  = NULL;

$inner_sql_select = 'crs_lesson.lesson_id, crs_lesson.lesson_name, crs_lesson.year, '
//                 .'CASE count(crs_student_lesson.student_id) WHEN 0 THEN null ELSE count(crs_student_lesson.student_id) END AS student_count,'
                   .'CASE count(crs_class_lesson.class_id) WHEN 0 THEN null ELSE count(crs_class_lesson.class_id) END AS class_count';
$inner_sql_from   = 'crs_lesson '
//                 .'LEFT JOIN crs_student_lesson USING (lesson_id) '
                  .'LEFT JOIN crs_class_lesson USING (lesson_id)';
$inner_sql_where  = '';
$inner_sql_groupby = 'crs_lesson.lesson_id, crs_lesson.lesson_name, crs_lesson.year';
$inner_search_table = '';

// set default sort sequence
$inner_sql_orderby = '';

// activate page controller
require 'std.list2.inc';

?>
