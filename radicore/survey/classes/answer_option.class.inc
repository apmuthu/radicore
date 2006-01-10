<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class answer_option extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function answer_option ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'survey';
        $this->tablename   = 'answer_option';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // answer_option

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        //DebugBreak();
        if (strlen($fieldarray['jumpto_section_seq']) > 0) {
            // get sequence number of curren section
            require_once 'survey_section.class.inc';
            $dbobject =& singleton::getInstance('survey_section');

            $dbobject->sql_select = 'section_seq';
            $section_data = $dbobject->getData("survey_id='{$fieldarray['survey_id']}' AND section_id='{$fieldarray['section_id']}'");
            $section_seq  = $section_data[0]['section_seq'];

            if ($fieldarray['jumpto_section_seq'] <= $section_seq) {
                $this->errors['jumpto_section_seq'] = getLanguageText('e0001'); // 'Can only jump to a later section.';
            } // if

            $count = $dbobject->getCount("survey_id='{$fieldarray['survey_id']}'");
            if ($fieldarray['jumpto_section_seq'] > $count) {
                $this->errors['jumpto_section_seq'] = getLanguageText('e0002'); // 'Cannot jump to section which does not exist.';
            } // if

            unset($dbobject);
        } // if

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_deleteMultiple($where)
    // delete/update multiple records using the criteria in $where.
    {
        // $where must identify a particular question
        $fieldarray = where2array($where);
        if (!array_key_exists('survey_id', $fieldarray)
        or  !array_key_exists('section_id', $fieldarray)
        or  !array_key_exists('question_id', $fieldarray)) {
            return getLanguageText('e0003'); // 'Cannot delete from answer_option - selection incomplete';
        } // if

        // delete all selected records.
        $this->_dml_deleteRecord($fieldarray);

        return;

    } // _cm_deleteMultiple

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        //DebugBreak();
        // set answer_id to next available number
        if (!empty($fieldarray['survey_id'])
                AND !empty($fieldarray['section_id'])
                AND !empty($fieldarray['question_id'])) {
            $where = "survey_id='{$fieldarray['survey_id']}' AND " . "section_id='{$fieldarray['section_id']}' AND " . "question_id='{$fieldarray['question_id']}'";
        } // if

        if (empty($where)) {
            $this->errors[] = getLanguageText('sys0082'); // 'No parent has been selected yet.';
            return;
        } // if

        $query = "SELECT max(answer_id) FROM $this->tablename WHERE $where";
        $count = $this->getCount($query);
        $fieldarray['answer_id'] = $count + 1;
        $fieldarray['answer_seq'] = $count + 1;

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item = '', $where)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'answer_id') {
            // get data from the database
            $this->sql_select     = 'answer_id, answer_text';
            $this->sql_orderby    = 'answer_seq';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData($where);

            $array[''] = ' ';   // start with blank entry

            // convert each row into 'id=desc' in the output array
            foreach ($data as $row => $rowdata) {
                $rowvalues = array_values($rowdata);
                $array[$rowvalues[0]] = $rowvalues[1];
            } // foreach

            return $array;

        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        //DebugBreak();
        switch ($GLOBALS['task_id']) {
            case 'srv_answer_option(multi)':
                // remove any tablenames in front of column names
                $where = unqualifyWhere($where);
                break;
            default:
                ;
        } // switch

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
