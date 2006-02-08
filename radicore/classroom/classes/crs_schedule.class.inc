<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class crs_schedule extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function crs_schedule ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'crs_schedule';
        $this->dbname      = 'classroom';

        $this->fieldspec = $this->getFieldSpec_original();

    } // crs_schedule

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        global $mode;
        if ($mode == 'search') {
            $this->fieldspec['schedule_errors']['nodisplay'] = 'y';
            unset($this->fieldspec['is_valid']['noedit']);
        } // if

        if (basename($_SERVER['PHP_SELF']) == 'schedule_multi.php') {
            // make this field display-only in this screen
            $this->fieldspec['lesson_id']['noedit'] = 'y';
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_commonValidation ($fieldarray, $orignaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        //DebugBreak();
        if (is_True($this->via_updateMultiple)) {
            return $fieldarray; // skip this function till later
        } // if

        $fieldarray['schedule_errors'] = '';

        $start_time = $fieldarray['start_time'];
        $end_time   = $fieldarray['end_time'];

        if ($start_time > $end_time) {
            $this->errors['start_time'] = getLanguageText('e0001'); // 'Start Time cannot be later than End Time';
            $this->errors['end_time']   = getLanguageText('e0002'); // 'End Time cannot be earlier than Start Time';
        } else {
            $pattern = '/(00|15|30|45)/';
            $start_minutes = substr($start_time, 3, 2);
            if (!preg_match($pattern, $start_minutes)) {
                $this->errors['start_time'] = getLanguageText('e0003'); // 'Start Time must be 00,15,30 or 45 minutes';
            } // if
            $end_minutes = substr($end_time, 3, 2);
            if (!preg_match($pattern, $end_minutes)) {
                $this->errors['end_time'] = getLanguageText('e0004'); // 'End Time must be 00,15,30 or 45 minutes';
            } // if
        } // if

        if ($this->errors) {
            return $fieldarray;
        } // if

        $errors = array();

        // ****************************************************************************
        // look for conflicting schedules with the same room
        $schedule_id = $fieldarray['schedule_id'];
        $seq_no      = $fieldarray['seq_no'];
        $room_id     = $fieldarray['room_id'];
        $lesson_id   = $fieldarray['lesson_id'];
        $day_no      = $fieldarray['day_no'];
        $start_time  = adjustTime($start_time, '+1 second');
        $end_time    = adjustTime($end_time, '-1 second');

        $this->sql_select = 'crs_schedule.*, lesson_name ';
        $this->sql_from   = 'crs_schedule '
                           .'LEFT JOIN crs_lesson ON (crs_lesson.lesson_id=crs_schedule.lesson_id) ';
        $where = "schedule_id='$schedule_id' AND room_id='$room_id' AND day_no='$day_no' AND seq_no<>'$seq_no' "
               . "AND start_time <= '$end_time' AND end_time >= '$start_time'";
        $data = $this->getData($where);
        if (count($data) > 0) {
            foreach ($data as $row) {
                // "Room conflict: Lesson '{$row['lesson_name']}' between {$row['start_time']} and {$row['end_time']}"
            	$errors[] = getLanguageText('e0005', $row['lesson_name'], $row['start_time'], $row['end_time']);
            } // foreach
        } // if

        // ****************************************************************************
        // check student numbers against room capacity
        require_once 'crs_room.class.inc';
        $roomOBJ =& singleton::getInstance('crs_room');
        $roomOBJ->sql_select = 'room_capacity';
        $data = $roomOBJ->getData("room_id='$room_id'");
        $room_capacity = $data[0]['room_capacity'];

        require_once 'crs_class_lesson.class.inc';
        $class_lessonOBJ =& singleton::getInstance('crs_class_lesson');
        $class_lessonOBJ->sql_select  = 'crs_class_lesson.lesson_id, count(student_id) as count';
        $class_lessonOBJ->sql_from    = 'crs_class_lesson '
                                      . 'LEFT JOIN crs_student ON (crs_student.class_id=crs_class_lesson.class_id)';
        $class_lessonOBJ->sql_groupby = 'crs_class_lesson.lesson_id';
        $data = $class_lessonOBJ->getData("lesson_id='$lesson_id'");
        if (count($data) > 0) {
            $count1 = $data[0]['count'];
        } else {
            $count1 = 0;
        } // if

        require_once 'crs_student_lesson.class.inc';
        $student_lessonOBJ =& singleton::getInstance('crs_student_lesson');
        $count2 = $student_lessonOBJ->getCount("lesson_id='$lesson_id'");

        $count3 = $count1+$count2;
        if ($count3 > $room_capacity) {
            // "Size conflict: Student count ($count3) exceeds room capacity ($room_capacity)"
            $errors[] = getLanguageText('e0006', $count3, $room_capacity);
        } // if

        // ****************************************************************************

        // check if other scheduled lessons conflict with this one
        require_once 'crs_conflict.class.inc';
        $conflictOBJ =& singleton::getInstance('crs_conflict');
        $conflictOBJ->setRowsPerPage(0); // turn off pagination
        $conflictOBJ->sql_orderby = 'lesson_id2';
        $conflictOBJ->sql_groupby = 'lesson_id2';
        $conflictDATA = $conflictOBJ->getData("lesson_id1='$lesson_id'");

        // construct WHERE using lesson_id2 from each entry
        $where = '';
        foreach ($conflictDATA as $row) {
        	if (empty($where)) {
        	    $where  = "lesson_id='{$row['lesson_id2']}' ";
            } else {
                $where .= "OR lesson_id='{$row['lesson_id2']}' ";
        	} // if
        } // foreach

        if (!empty($where)) {
            $this->sql_select = 'crs_schedule.*, crs_lesson.lesson_name';
            $this->sql_from   = 'crs_schedule '
                              . 'LEFT JOIN crs_lesson USING (lesson_id)';
            $where = "schedule_id='$schedule_id' AND day_no='$day_no' AND start_time <= '$end_time' AND end_time >= '$start_time' AND ($where)";
            $data = $this->getData($where);
            if (count($data) > 0) {
                foreach ($data as $row) {
                    // "Lesson conflict: Lesson '{$row['lesson_name']}' between {$row['start_time']} and {$row['end_time']}"
                	$errors[] = getLanguageText('e0007', $row['lesson_name'], $row['start_time'], $row['end_time']);
                    // include details of each possible conflict
                    $where2   = "lesson_id1='$lesson_id' AND lesson_id2='{$row['lesson_id']}'";
                    $conflictOBJ->sql_orderby = null;
                    $conflictOBJ->sql_groupby = null;
                    $conflictOBJ->sql_select  = 'crs_conflict.*, class_name, '
                                               .'CONCAT_WS(", ", crs_student.last_name, crs_student.first_name, crs_student.initials) AS student_name, '
                                               .'CONCAT_WS(", ", crs_teacher.last_name, crs_teacher.first_name, crs_teacher.initials) AS teacher_name ';
                    $conflictOBJ->sql_from    = 'crs_conflict '
                                               .'LEFT JOIN crs_class USING (class_id) '
                                               .'LEFT JOIN crs_student ON (crs_student.student_id=crs_conflict.student_id) '
                                               .'LEFT JOIN crs_teacher ON (crs_teacher.teacher_id=crs_conflict.teacher_id) ';
                    $conflictDATA = $conflictOBJ->getData($where2);
                    foreach ($conflictDATA as $conflict) {
                        switch ($conflict['conflict_type']) {
                            case 'C':
                                // '- class: ' .$conflict['class_name']
                                $errors[] = getLanguageText('e0008', $conflict['class_name']);
                                break;
                        	case 'S':
                        	    // '- student: ' .$conflict['student_name']
                        		$errors[] = getLanguageText('e0009', $conflict['student_name']);
                        		break;
                        	case 'T':
                        	    // '- teacher: ' .$conflict['teacher_name']
                        		$errors[] = getLanguageText('e0010', $conflict['teacher_name']);
                        		break;
                        	default:
                        	    // 'unknown conflict type (' .$conflict['conflict_type'] .')'
                        		$errors[] = getLanguageText('e0011', $conflict['conflict_type']);
                        } // switch
                    } // foreach
                } // foreach
            } // if
        } // if

        // ****************************************************************************
        if (!empty($errors)) {
            // transfer error messages into database field
            $fieldarray['is_valid'] = 'N';
            foreach ($errors as $error) {
                $fieldarray['schedule_errors'] .= "$error\n";
            } // foreach
            $fieldarray['schedule_errors'] = addslashes($fieldarray['schedule_errors']);
            $this->messages[] = getLanguageText('e0012', $seq_no); // "Event $seq_no contains errors.";
        } else {
            $fieldarray['is_valid'] = 'Y';
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        // get array for day_no and put into LOOKUP_DATA
        $array = $this->getValRep('day_no');
        $this->lookup_data['day_no'] = $array;

        // get contents of foreign table LESSON and add to lookup array
        require_once 'crs_lesson.class.inc';
        $object =& singleton::getInstance('crs_lesson');
        $data = $object->getValRep('lesson_id');
        $this->lookup_data['lesson_id'] = $data;

        // get contents of foreign table ROOM and add to lookup array
        require_once 'crs_room.class.inc';
        $object =& singleton::getInstance('crs_room');
        $data = $object->getValRep('room_id');
        $this->lookup_data['room_id'] = $data;

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        //DebugBreak();
        // set seq_no to next available number
        $where = "schedule_id='{$fieldarray['schedule_id']}'";
        $count = $this->getCount("SELECT max(seq_no) FROM $this->tablename WHERE $where");
        $fieldarray['seq_no'] = $count + 1;

        // not allowed to set this field on INSERT
        $this->fieldspec['is_valid']['nodisplay'] = 'y';
        $fieldarray['is_valid'] = 'N';

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item = '', $where)
    // get Value/Representation list as an associative array.
    {
        //DebugBreak();
        // provide values for dropdown list


        if ($item == 'day_no') {
//            $array[''] = ' ';   // start with blank entry
//            $array[1] = 'Monday';
//            $array[2] = 'Tuesday';
//            $array[3] = 'Wednesday';
//            $array[4] = 'Thursday';
//            $array[5] = 'Friday';
//            $array[6] = 'Saturday';
//            $array[7] = 'Sunday';
            $array = getLanguageArray('day_no');
            return $array;
        } // if

        return array();

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        //DebugBreak();
        if (count($rowdata) != 1) {
            return $rowdata;
        } // if

        if (isset($rowdata[0]['room_id'])) {
            require_once 'crs_room.class.inc';
            $object =& singleton::getInstance('crs_room');
            $data = $object->getData("room_id='{$rowdata[0]['room_id']}'");
            $rowdata[0]['room_capacity'] = $data[0]['room_capacity'];
        } // if

        if (isset($rowdata[0]['lesson_id'])) {
            require_once 'crs_lesson.class.inc';
            $object =& singleton::getInstance('crs_lesson');
            $data = $object->getData("lesson_id='{$rowdata[0]['lesson_id']}'");
            $rowdata[0]['teacher_name'] = $data[0]['teacher_name'];
            $student_count1             = $data[0]['student_count'];
        } // if

        require_once 'crs_class_lesson.class.inc';
        $object =& singleton::getInstance('crs_class_lesson');
        $object->sql_select  = 'crs_class_lesson.lesson_id, count(student_id) as count';
        $object->sql_from    = 'crs_class_lesson '
                             . 'LEFT JOIN crs_student ON (crs_student.class_id=crs_class_lesson.class_id)';
        $object->sql_groupby = 'crs_class_lesson.lesson_id';
        $data = $object->getData("lesson_id='{$rowdata[0]['lesson_id']}'");
        if (isset($data[0]['count'])) {
            $student_count2 = $data[0]['count'];
        } else {
            $student_count2 = 0;
        } // if

        $student_count = $student_count1 + $student_count2;
        $rowdata[0]['student_count'] = $student_count;

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_post_updateMultiple ($fieldarray)
    // perform custom processing after multiple database records have been updated.
    {
        //DebugBreak();
        $errors = array();

        // now validate each row in the database
        foreach ($fieldarray as $row => $data) {
            $originaldata = $fieldarray[$row];
            $fieldarray[$row] = $this->_cm_commonValidation($fieldarray[$row], $originaldata);
            if (!empty($this->errors)) {
                // keep $errors separate for each row
                $errors[$row] = $this->errors;
            } else {
                if ($fieldarray[$row] != $originaldata) {
                    // update this record to record any conflicts
                    $this->_dml_updateRecord($fieldarray[$row], $originaldata);
                } // if
            } // if
        } // foreach

        // overwrite proper array
        $this->errors = $errors;

        return $fieldarray;

    } // _cm_post_updateMultiple

// ****************************************************************************
} // end class
// ****************************************************************************

?>