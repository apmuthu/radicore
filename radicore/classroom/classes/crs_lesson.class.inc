<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class crs_lesson extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function crs_lesson ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'crs_lesson';
        $this->dbname      = 'classroom';

        $this->fieldspec = $this->getFieldSpec_original();

    } // crs_lesson

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('teacher_id', $this->lookup_data)) {
            // get contents of foreign table TEACHER and add to lookup array
            $object =& singleton::getInstance('crs_teacher');
            $data = $object->getValRep('teacher_id');
            $this->lookup_data['teacher_id'] = $data;
        } // if

        if (!array_key_exists('subject_id', $this->lookup_data)) {
            // get contents of foreign table SUBJECT and add to lookup array
            $object =& singleton::getInstance('crs_subject');
            $data = $object->getValRep('subject_id');
            $this->lookup_data['subject_id'] = $data;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // set survey_id to next available number
        $count = $this->getCount("SELECT max(lesson_id) FROM $this->tablename");
        $fieldarray['lesson_id'] = $count + 1;

        $this->fieldspec['lesson_id']['noedit'] = 'y';

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null)
    // get Value/Representation list as an associative array.
    {
        //DebugBreak();
        $array = array();

        if ($item == 'lesson_id') {
            // get data from the database
            $this->sql_select     = 'lesson_id, lesson_name';
            $this->sql_orderby    = 'lesson_name';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData(null);

            // convert each row into 'id=desc' in the output array
            foreach ($data as $row => $rowdata) {
                $rowvalues = array_values($rowdata);
                $array[$rowvalues[0]] = "$rowvalues[1]";
            } // foreach

            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        //DebugBreak();
        if (count($rowdata) == 0) {
            return $rowdata;
        } // if

        //require_once 'crs_class_lesson.class.inc';
        //$objectCL =& singleton::getInstance('crs_Class_Lesson');
        //$objectCL->sql_select  = 'crs_class_lesson.lesson_id, count(student_id) as count';
        //$objectCL->sql_from    = 'crs_class_lesson '
        //                        .'LEFT JOIN crs_student ON (crs_student.class_id=crs_class_lesson.class_id)';
        //$objectCL->sql_groupby = 'crs_class_lesson.lesson_id';

        require_once 'classes/crs_student_lesson.class.inc';
        $objectSL =& singleton::getInstance('crs_student_lesson');

        foreach ($rowdata as $rownum => $row) {
            if (isset($row['lesson_id'])) {
                $lesson_id  = $row['lesson_id'];
                //$data = $objectCL->getData("lesson_id='$lesson_id'");
                //if (isset($data[0]['count'])) {
                //    $count1 = $data[0]['count'];
                //} else {
                    $count1 = 0;
                //} // if

                $count2 = $objectSL->getCount("lesson_id='$lesson_id'");
                $count3 = $count1+$count2;
                if ($count3 == 0) $count3 = null;
                $rowdata[$rownum]['student_count'] = $count3;

                if (isset($row['teacher_id']) and !isset($row['teacher_name'])) {
                    $teacher_id = $row['teacher_id'];
                    if (isset($this->lookup_data['teacher_id'])) {
                        $rowdata[$rownum]['teacher_name'] = $this->lookup_data['teacher_id'][$teacher_id];
                    } else {
                        require_once 'classes/crs_teacher.class.inc';
                        $objectT =& singleton::getInstance('crs_teacher');
                        $data = $objectT->getData("teacher_id='$teacher_id'");
                        $rowdata[$rownum]['teacher_name'] = $data[0]['teacher_name'];
                    } // if
                } // if
            } // if
        } // foreach

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_insertRecord ($fieldarray)
    // perform custom processing before database record is inserted.
    {
        //DebugBreak();
        if (empty($fieldarray['lesson_short_name'])) {
            // extract everything up to the first comma or dash
            list($short_name) = split('[,-]', $fieldarray['lesson_name']);
            $fieldarray['lesson_short_name'] = $short_name;
        } // if

        return $fieldarray;

    } // _cm_pre_insertRecord

    // ****************************************************************************
    function _cm_pre_updateRecord ($fieldarray)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        //DebugBreak();
        if (empty($fieldarray['lesson_short_name'])) {
            // extract everything up to the first comma or dash
            list($short_name) = split('[,-]', $fieldarray['lesson_name']);
            $fieldarray['lesson_short_name'] = $short_name;
        } // if

        return $fieldarray;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
