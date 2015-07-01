<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class crs_student_lesson extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function crs_student_lesson ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'crs_student_lesson';
        $this->dbname      = 'classroom';

        $this->fieldspec = $this->getFieldSpec_original();

    } // crs_student_lesson

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (basename($_SERVER['PHP_SELF']) == 'lesson_list(a).php') {
            if (!array_key_exists('teacher_id', $this->lookup_data)) {
                // get contents of foreign table TEACHER and add to lookup array
                $object =& RDCsingleton::getInstance('crs_teacher');
                $data = $object->getValRep('teacher_id');
                $this->lookup_data['teacher_id'] = $data;
            } // if
            // ensure field is populated from the dropdown list
            $this->fieldspec['teacher_id'] = array('type' => 'integer',
                                                   'control' => 'dropdown',
                                                   'optionlist' => 'teacher_id');
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_popupCall ($popupname, $where, $fieldarray, &$settings)
    // if a popup button has been pressed the contents of $where may need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered as well.
    {
        if (!empty($fieldarray['student_id'])) {
            // convert 'student=X' into 'year=Y'
            $object =& RDCsingleton::getInstance('crs_student');
            $object->sql_select = 'year';
            $data = $object->getData_raw($where);
            if (isset($data[0]['year']) and $data[0]['year'] > 0) {
                $where = "year=" .$data[0]['year'];
            } else {
                $where = '';
            } // if
        } // if

        $settings['select_one'] = false;

        return $where;

    } // _cm_popupCall

// ****************************************************************************
} // end class
// ****************************************************************************

?>
