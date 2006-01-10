<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class crs_class extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function crs_class ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'crs_class';
        $this->dbname      = 'classroom';

        $this->fieldspec = $this->getFieldSpec_original();

    } // crs_class

    // ****************************************************************************
    function _cm_getValRep ($item = '', $where)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'class_id') {
            // get data from the database
            $this->sql_select     = 'class_id, class_name';
            $this->sql_orderby    = 'class_name';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData(null);

            $array[''] = ' ';   // start with blank entry

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
        if (basename($_SERVER['PHP_SELF']) == 'lesson_list(b).php') {
            if (isset($rowdata[0]['year']) and $rowdata[0]['year'] > 0) {
                // apply a retrieve profile to the popup form
                $GLOBALS['script_vars']['popup_where'] = "year={$rowdata[0]['year']}";
            } // if
        } // if

        if (count($rowdata) == 0) {
            return $rowdata;
        } // if

        require_once 'crs_student.class.inc';
        $objectS =& singleton::getInstance('crs_student');

        require_once 'crs_class_lesson.class.inc';
        $objectCL =& singleton::getInstance('crs_class_lesson');

        foreach ($rowdata as $rownum => $row) {
            if (isset($row['class_id'])) {
                $class_id = $row['class_id'];

                $count = $objectS->getCount("class_id='$class_id'");
                if ($count > 0) {
                    $rowdata[$rownum]['student_count'] = $count;
                } // if

                $count = $objectCL->getCount("class_id='$class_id'");
                if ($count > 0) {
                     $rowdata[$rownum]['lesson_count'] = $count;
                } // if
            } // if
        } // foreach

        return $rowdata;

    } // _cm_post_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
