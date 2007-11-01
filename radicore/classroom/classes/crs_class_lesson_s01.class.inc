<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'crs_class_lesson.class.inc';
class crs_class_lesson_s01 extends crs_class_lesson
{
    // ****************************************************************************
    // this version is for lesson_list(b).php (includes a list of teachers)
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

        // ensure field is populated from the dropdown list
        $this->fieldspec['teacher_id'] = array('type' => 'integer',
                                               'control' => 'dropdown',
                                               'optionlist' => 'teacher_id');

        return $fieldarray;

    } // _cm_getExtraData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
