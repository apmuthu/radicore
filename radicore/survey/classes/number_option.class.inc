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
            if ($fieldarray['max_value'] <= $fieldarray['min_value']) {
                // 'Maximum cannot be less than or equal to minimum'
                $this->errors['max_value'] = getLanguageText('e0008');
            } // if
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        $dbobject =& RDCsingleton::getInstance('survey_question');
    	$data  = $dbobject->getData_raw($where);

        if ($data[0]['answer_type'] != 'N') {
            // 'Function invalid unless ANSWER TYPE = NUMBER'
            $this->errors[] = getLanguageText('e0009');
        } // if

        // force the controller to move to the next record
        global $act_buttons;
        if (isset($act_buttons['submitstay'])) {
            // remove the 'Submit Say' button
        	unset($act_buttons['submitstay']);
        } elseif (isset($act_buttons['submitnext'])) {
            // leave the 'Submit Next' button
            unset($act_buttons['submit']);
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_insertRecord ($fieldarray)
    // perform custom processing before database record is inserted.
    {
        if (!isset($fieldarray['answer_type'])) {
        	$dbobject =& RDCsingleton::getInstance('survey_question');
        	$survey_id   = $fieldarray['survey_id'];
        	$section_id  = $fieldarray['section_id'];
        	$question_id = $fieldarray['question_id'];
        	$where = "survey_id='$survey_id' AND section_id='$section_id' AND question_id='$question_id'";
        	$data  = $dbobject->getData_raw($where);
        	$fieldarray['answer_type'] = $data[0]['answer_type'];
        } // if

        if ($fieldarray['answer_type'] != 'N') {
            // 'Function invalid unless ANSWER TYPE = NUMBER'
            $this->errors[] = getLanguageText('e0009');
        } // if

        return $fieldarray;

    } // _cm_pre_insertRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
