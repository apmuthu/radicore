<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class crs_lesson extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->tablename   = 'crs_lesson';
        $this->dbname      = 'classroom';

        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('student_count', $this->fieldspec)) {
        	$this->fieldspec['student_count']  = array('type' => 'numeric', 'blank_when_zero' => 'y', 'nondb' => 'y');
        } // if

        if (!array_key_exists('class_count', $this->fieldspec)) {
        	$this->fieldspec['class_count']  = array('type' => 'numeric', 'blank_when_zero' => 'y', 'nondb' => 'y');
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('teacher_id', $this->lookup_data)) {
            // get contents of foreign table TEACHER and add to lookup array
            $object =& RDCsingleton::getInstance('crs_teacher');
            $data = $object->getValRep('teacher_id');
            $this->lookup_data['teacher_id'] = $data;
        } // if

        if (!array_key_exists('subject_id', $this->lookup_data)) {
            // get contents of foreign table SUBJECT and add to lookup array
            $object =& RDCsingleton::getInstance('crs_subject');
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
        // set id to next available number
        $count = $this->getCount("SELECT max(lesson_id) FROM $this->tablename");
        $fieldarray['lesson_id'] = $count + 1;

        $this->fieldspec['lesson_id']['noedit'] = 'y';

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null, $orderby=null)
    // get Value/Representation list as an associative array.
    {
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
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        if (empty($this->sql_select)) {
            // construct default SELECT and FROM clauses using parent relations
            $this->sql_select  = null;
            $this->sql_from    = null;
            $this->sql_groupby = null;
            $this->sql_having  = null;
            $this->sql_from    = $this->_sqlForeignJoin($this->sql_select, $this->sql_from, $this->parent_relations);
            // get count of students in this class
            $this->sql_select .= ", (SELECT COUNT(student_id) FROM crs_student_lesson WHERE crs_student_lesson.lesson_id=crs_lesson.lesson_id ) AS student_count";
            // get count of classes for this lesson
            $this->sql_select .= ", (SELECT COUNT(class_id) FROM crs_class_lesson WHERE crs_class_lesson.lesson_id=crs_lesson.lesson_id ) AS class_count";
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_insertRecord ($fieldarray)
    // perform custom processing before database record is inserted.
    {
        if (empty($fieldarray['lesson_short_name'])) {
            // extract everything up to the first comma or dash
            list($short_name) = preg_split('/[,-]/', $fieldarray['lesson_name']);
            $fieldarray['lesson_short_name'] = $short_name;
        } // if

        return $fieldarray;

    } // _cm_pre_insertRecord

    // ****************************************************************************
    function _cm_pre_updateRecord ($fieldarray)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        if (empty($fieldarray['lesson_short_name'])) {
            // extract everything up to the first comma or dash
            list($short_name) = preg_split('/[,-]/', $fieldarray['lesson_name']);
            $fieldarray['lesson_short_name'] = $short_name;
        } // if

        return $fieldarray;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
