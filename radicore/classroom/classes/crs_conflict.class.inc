<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class crs_conflict extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function crs_conflict ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'crs_conflict';
        $this->dbname      = 'classroom';

        $this->fieldspec = $this->getFieldSpec_original();

    } // crs_conflict

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('conflict_type', $this->lookup_data)) {
            // get array for task_type and put into LOOKUP_DATA
            $array = $this->getValRep('conflict_type');
            $this->lookup_data['conflict_type'] = $array;
        } // if

        if (!array_key_exists('teacher_id', $this->lookup_data)) {
            // get contents of foreign table TEACHER and add to lookup array
            $object =& RDCsingleton::getInstance('crs_teacher');
            $data = $object->getValRep('teacher_id');
            $this->lookup_data['teacher_id'] = $data;
        } // if

        if (!array_key_exists('class_id', $this->lookup_data)) {
            // get contents of foreign table CLASS and add to lookup array
            $object =& RDCsingleton::getInstance('crs_class');
            $data = $object->getValRep('class_id');
            $this->lookup_data['class_id'] = $data;
        } // if

        if (!array_key_exists('lesson_id', $this->lookup_data)) {
            // get contents of foreign table LESSON and add to lookup array
            $object =& RDCsingleton::getInstance('crs_lesson');
            $data = $object->getValRep('lesson_id');
            $this->lookup_data['lesson_id'] = $data;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null)
    // get Value/Representation list as an associative array.
    {
        // provide values for dropdown list

        if ($item == 'conflict_type') {
//            $array['C'] = 'Class';
//            $array['S'] = 'Student';
//            $array['T'] = 'Teacher';
            $array = getLanguageArray('conflict_type');
            return $array;
        } // if

        return array();

    } // _cm_getValRep

// ****************************************************************************
} // end class
// ****************************************************************************

?>
