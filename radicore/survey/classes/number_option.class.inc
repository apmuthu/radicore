<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class number_option extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function number_option ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'survey';
        $this->tablename   = 'number_option';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // number_option

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        if (isset($fieldarray['min_value']) AND isset($fieldarray['max_value'])) {
            // maximum must not be less than minimum
            if ($fieldarray['max_value'] < $fieldarray['min_value']) {
                $this->errors['max_value'] = getLanguageText('e0008'); // 'Maximum cannot be less than minimum';
            } // if
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {

        if ($fieldarray['answer_type'] != 'N') {
            $this->errors[] = getLanguageText('e0009'); // 'Function invalid unless ANSWER TYPE = NUMBER';
        } // if

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_insertRecord ($fieldarray)
    // perform custom processing before database record is inserted.
    {
        if ($fieldarray['answer_type'] != 'N') {
            $this->errors[] = getLanguageText('e0009'); // 'Function invalid unless ANSWER TYPE = NUMBER';
        } // if

        return $fieldarray;

    } // _cm_pre_insertRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
