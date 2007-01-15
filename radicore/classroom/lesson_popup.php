<?php
// *****************************************************************************
// List the contents of a database table and allow the user to choose one
// (or more) for processing by te previous screen.
// *****************************************************************************

//DebugBreak();
$table_id = 'crs_lesson';                  // table name
$screen   = 'crs_lesson.list.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = 'crs_lesson.lesson_id, crs_lesson.lesson_name, crs_lesson.year, crs_lesson.teacher_id, '
//             .'CASE count(crs_student_lesson.student_id) WHEN 0 THEN null ELSE count(crs_student_lesson.student_id) END AS student_count,'
             .'CASE count(crs_class_lesson.class_id) WHEN 0 THEN null ELSE count(crs_class_lesson.class_id) END AS class_count';
$sql_from   = 'crs_lesson '
//             .'LEFT JOIN crs_student_lesson ON (crs_student_lesson.lesson_id=crs_lesson.lesson_id) '
             .'LEFT JOIN crs_class_lesson ON (crs_class_lesson.lesson_id=crs_lesson.lesson_id)';
$sql_where  = '';
$sql_groupby = 'crs_lesson.lesson_id, crs_lesson.lesson_name, crs_lesson.year, crs_lesson.teacher_id';

// set default sort sequence
$sql_orderby = null;

// activate page controller
require 'std.list1.popup.inc';

?>
