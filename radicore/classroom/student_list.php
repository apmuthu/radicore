<?php
// *****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
// *****************************************************************************

//DebugBreak();
$table_id = 'crs_student';                  // table name
$screen   = 'crs_student.list.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = 'crs_student.student_id, crs_student.first_name, crs_student.last_name, crs_student.initials, crs_student.year, crs_student.class_id, '
             .'CASE count(crs_student_lesson.lesson_id) WHEN 0 THEN null ELSE count(crs_student_lesson.lesson_id) END AS lesson_count';
$sql_from   = 'crs_student '
             .'LEFT JOIN crs_student_lesson ON (crs_student_lesson.student_id=crs_student.student_id) ';
$sql_where  = '';
$sql_groupby = 'crs_student.student_id, crs_student.first_name, crs_student.last_name, crs_student.initials, crs_student.year, crs_student.class_id';

// set default sort sequence
$sql_orderby = null;

// activate page controller
require 'std.list1.inc';

?>
