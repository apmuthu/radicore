<?php
// *****************************************************************************
// List the contents of a database table and allow the user to view/modify
// the contents by activating other screens via navigation buttons.
// *****************************************************************************

//DebugBreak();
$table_id = 'crs_conflict';                  // table name
$screen   = 'crs_conflict.list.screen.inc';  // file identifying screen structure

// identify extra parameters for a JOIN
$sql_select = 'crs_conflict.*, L1.lesson_name AS lesson_name1, L2.lesson_name AS lesson_name2, '
             ."CONCAT(T.title, ' ', T.first_name, ' ', T.last_name) AS teacher_name, "
             ."CONCAT(S.last_name, ' ', S.first_name) AS student_name ";
$sql_from   = 'crs_conflict '
             .'LEFT JOIN crs_lesson AS L1 ON (L1.lesson_id=crs_conflict.lesson_id1) '
             .'LEFT JOIN crs_lesson AS L2 ON (L2.lesson_id=crs_conflict.lesson_id2) '
             .'LEFT JOIN crs_teacher AS T ON (T.teacher_id=crs_conflict.teacher_id) '
             .'LEFT JOIN crs_student AS S ON (S.student_id=crs_conflict.student_id) ';
$sql_where  = '';
$sql_groupby = '';

// set default sort sequence
$sql_orderby = null;

// activate page controller
require 'std.list1.inc';

?>
