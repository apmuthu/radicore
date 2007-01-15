<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'crs_conflict.class.inc';
class crs_conflict_s01 extends crs_conflict
{
    // ****************************************************************************
    // this subclass is used to create entries for conflicting lessons.
    // ****************************************************************************
    function getLessonArray ($input)
    // extract lessons from input array and construct a second array which lists
    // all the lessons in pairs
    {
        // extract lesson_id's from input array
        $array1 = array();
        foreach ($input as $row) {
        	$array1[] = $row['lesson_id'];
        } // foreach

        // each lesson_id must be paired which each following lesson_id
        $array2 = array();
        $rownum = 0;
        // start at first entry
        for ($i1 = 0; $i1 < count($array1); $i1++) {
            $lesson_id1 = $array1[$i1];
            // start at following entry
        	for ($i2 = $i1+1; $i2 < count($array1); $i2++) {
        	    $lesson_id2 = $array1[$i2];
                $array2[$rownum]['lesson_id1'] = $lesson_id1;
                $array2[$rownum]['lesson_id2'] = $lesson_id2;
                $rownum++;
                // now reverse the entries
                $array2[$rownum]['lesson_id1'] = $lesson_id2;
                $array2[$rownum]['lesson_id2'] = $lesson_id1;
                $rownum++;
            } // for
        } // for

        return $array2;

    } // getLessonArray

    // ****************************************************************************
    function _cm_getInitialDataMultiple ($fieldarray)
    // Perform custom processing prior to insertMultiple.
    // $fieldarray contains data from the initial $where clause.
    {
        // delete existing records
        $result = $this->startTransaction();
        $count  = $this->_dml_deleteSelection('conflict_id IS NOT NULL');
        $errors = $this->commit();

        $rownum = 0;
        $fieldarray = array();

        //******************************************************************************
        // get list of teachers
        require_once 'classes/crs_teacher.class.inc';
        $teacherOBJ =& singleton::getInstance('crs_teacher');
        $teacher_data = $teacherOBJ->getData(null);

        // for each teacher get list of classes
        require_once 'classes/crs_lesson.class.inc';
        $lessonOBJ =& singleton::getInstance('crs_lesson');

        foreach ($teacher_data as $teacher) {
        	$teacher_id  = $teacher['teacher_id'];
            $lesson_data = $lessonOBJ->getData("teacher_id='$teacher_id'");
            if ($lessonOBJ->numrows > 1) {
                $lesson_array = $this->getLessonArray($lesson_data);
                foreach ($lesson_array as $pair) {
                    $rownum++;
                	$fieldarray[$rownum]['conflict_id']   = $rownum;
                    $fieldarray[$rownum]['conflict_type'] = 'T';
                    $fieldarray[$rownum]['teacher_id']    = $teacher_id;
                    $fieldarray[$rownum]['lesson_id1']    = $pair['lesson_id1'];
                    $fieldarray[$rownum]['lesson_id2']    = $pair['lesson_id2'];
                } // foreach
            } // if
        } // foreach

        unset($teacherOBJ);
        unset($lessonOBJ);

        // *****************************************************************************
        // get list of classes
        require_once 'classes/crs_class.class.inc';
        $classOBJ =& singleton::getInstance('crs_class');
        $class_data = $classOBJ->getData(null);

        // for each class get list of lessons
        require_once 'classes/crs_class_lesson.class.inc';
        $lessonOBJ =& singleton::getInstance('crs_class_lesson');

        foreach ($class_data as $class) {
        	$class_id  = $class['class_id'];
            $lesson_data = $lessonOBJ->getData("class_id='$class_id'");
            if ($lessonOBJ->numrows > 1) {
                $lesson_array = $this->getLessonArray($lesson_data);
                foreach ($lesson_array as $pair) {
                    $rownum++;
                	$fieldarray[$rownum]['conflict_id']   = $rownum;
                    $fieldarray[$rownum]['conflict_type'] = 'C';
                    $fieldarray[$rownum]['class_id']      = $class_id;
                    $fieldarray[$rownum]['lesson_id1']    = $pair['lesson_id1'];
                    $fieldarray[$rownum]['lesson_id2']    = $pair['lesson_id2'];
                } // foreach
            } // if
        } // foreach

        unset($classOBJ);
        unset($lessonOBJ);

        // *****************************************************************************
        // get list of students
        require_once 'classes/crs_student.class.inc';
        $studentOBJ =& singleton::getInstance('crs_student');
        $student_data = $studentOBJ->getData(null);

        // for each student get list of lessons
        require_once 'classes/crs_student_lesson.class.inc';
        $lessonOBJ =& singleton::getInstance('crs_student_lesson');

        foreach ($student_data as $student) {
        	$student_id  = $student['student_id'];
            $lesson_data = $lessonOBJ->getData("student_id='$student_id'");
            if ($lessonOBJ->numrows > 1) {
                $lesson_array = $this->getLessonArray($lesson_data);
                foreach ($lesson_array as $pair) {
                    $rownum++;
                	$fieldarray[$rownum]['conflict_id']   = $rownum;
                    $fieldarray[$rownum]['conflict_type'] = 'S';
                    $fieldarray[$rownum]['student_id']    = $student_id;
                    $fieldarray[$rownum]['lesson_id1']    = $pair['lesson_id1'];
                    $fieldarray[$rownum]['lesson_id2']    = $pair['lesson_id2'];
                } // foreach
            } // if
        } // foreach

        unset($classOBJ);
        unset($lessonOBJ);

        // *****************************************************************************

        return $fieldarray;

    } // _cm_getInitialDataMutiple

// ****************************************************************************
} // end class
// ****************************************************************************

?>
