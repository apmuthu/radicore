<?php 
// *****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
// *****************************************************************************

//DebugBreak();
$table_id = 'crs_class';                  // table name
$screen   = 'crs_class.list.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = 'crs_class.class_id, crs_class.class_name, crs_class.year, '
//             .'CASE count(crs_class_lesson.lesson_id) WHEN 0 THEN null ELSE count(crs_class_lesson.lesson_id) END AS lesson_count'
             .'CASE count(crs_student.student_id) WHEN 0 THEN null ELSE count(crs_student.student_id) END AS student_count';
$sql_from   = 'crs_class ' 
//             .'LEFT JOIN crs_class_lesson USING (lesson_id) '
             .'LEFT JOIN crs_student ON (crs_student.class_id=crs_class.class_id) ';
$sql_where  = '';
$sql_groupby = 'crs_class.class_id, crs_class.class_name, crs_class.year';

// activate page controller
require 'std.list1.inc';

?>
