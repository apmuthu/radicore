<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class crs_student extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function crs_student ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'crs_student';
        $this->dbname      = 'classroom';

        $this->fieldspec = $this->getFieldSpec_original();

    } // crs_student

    // ****************************************************************************
    function _cm_formatData ($fieldarray)
    // perform custom formatting before values are shown to the user.
    {
        if (!isset($fieldarray['student_name'])) {
            if (isset($fieldarray['first_name'])) {
                $fieldarray['student_name'] = $fieldarray['first_name']
                                        .' ' .$fieldarray['initials']
                                        .' ' .$fieldarray['last_name'];
            } // if
        } // if

        return $fieldarray;

    } // _cm_formatData

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        if (isset($fieldarray['year']) and isset($fieldarray['class_id'])) {
            $this->errors['year']     = getLanguageText('e0013'); // 'cannot set both YEAR and CLASS';
            $this->errors['class_id'] = getLanguageText('e0013'); // 'cannot set both YEAR and CLASS';
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('class_id', $this->lookup_data)) {
            // get contents of foreign table CLASS and add to lookup array
            $object =& singleton::getInstance('crs_class');
            $data   = $object->getValRep('class_id');
            $this->lookup_data['class_id'] = $data;
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // set survey_id to next available number
        $count = $this->getCount("SELECT max(student_id) FROM $this->tablename");
        $fieldarray['student_id'] = $count + 1;

        $this->fieldspec['student_id']['noedit'] = 'y';

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'student_id') {
            // get data from the database
            $this->sql_select     = 'student_id, last_name, first_name';
            $this->sql_orderby    = 'last_name';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData(null);

            // convert each row into 'id=desc' in the output array
            foreach ($data as $row => $rowdata) {
                $rowvalues = array_values($rowdata);
                $array[$rowvalues[0]] = "$rowvalues[1], $rowvalues[2]";
            } // foreach

            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        if (basename($_SERVER['PHP_SELF']) == 'student_popup.php') {
            $prev_script = getPreviousScript();
            if (basename($prev_script) == 'student_lesson_add(b).php') {
                // not allowed to choose students belonging to a class
                if (eregi('class_id IS NULL', $where)) {
                    // already there, so do nothing
                } else {
                    $where_array['class_id'] = 'IS NULL';
                    $where = array2where($where_array);
                } // if
            } // if
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        if (basename($_SERVER['PHP_SELF']) == 'lesson_list(a).php') {
            if (isset($rowdata[0]['class_id'])) {
                // 'Student is assigned to a class - cannot assign individual lessons'
                $this->errors[] = getLanguageText('e0014');
                $GLOBALS['nav_buttons_omit'][] = 'crs_student_lesson(add)a';
            } // if
        } // if

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_validateUpdate ($fieldarray, $originaldata)
    // perform custom validation before update.
    {
        if (empty($originaldata['class_id']) and !empty($fieldarray['class_id'])) {
            $count = $this->getCount("SELECT count(*) FROM crs_student_lesson WHERE student_id='{$fieldarray['student_id']}'");
            if ($count > 0) {
                // 'Cannot assign to a Class while individual lessons exist'
                $this->errors['class_id'] = getLanguageText('e0015');
            } // if
        } // if

        return $fieldarray;

    } // _cm_validateUpdate

// ****************************************************************************
} // end class
// ****************************************************************************

?>
