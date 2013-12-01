<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class survey_question extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function survey_question ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'survey';
        $this->tablename   = 'survey_question';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // survey_question

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if ($GLOBALS['mode'] == 'list'
        or basename($_SERVER['PHP_SELF']) == 'question_prompt_link.php'
        or basename($_SERVER['PHP_SELF']) == 'answer_option_multi.php') {
            // display as plain text, not a multi-line box
        	unset($this->fieldspec['question_text']['control']);
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('answer_type', $this->lookup_data)) {
            // get options for answer_type and insert in LOOKUP data
            $array = $this->getValRep('answer_type');
            $this->lookup_data['answer_type'] = $array;
        } // if

        if (!array_key_exists('risk_status_id', $this->lookup_data)) {
            // get contents of foreign table RISK_STATUS and add as a LOOKUP list
            $dbobject =& RDCsingleton::getInstance('risk_status');
            $data_array = $dbobject->getValRep('risk_status_id');
            $this->lookup_data['risk_status_id'] = $data_array;
            unset($dbobject);
        } // if

        global $mode;
        if ($mode != 'insert' and $mode != 'search') {
            // get contents of QUESTION_PROMPT and concatenate into a single string
            $dbobject =& RDCsingleton::getInstance('question_prompt');
            $dbobject->sql_select = "prompt_desc";
            $dbobject->sql_from   = "question_prompt "
                                  . "LEFT JOIN default_prompt ON (default_prompt.survey_id=question_prompt.survey_id AND default_prompt.prompt_id=question_prompt.prompt_id)";
            $where2 = filterWhere($where, $dbobject->getPkeynames(), $dbobject->getTableName());
            $data_array = $dbobject->getData($where2);
            unset($dbobject);
            $prompt_list = '';
            foreach ($data_array as $row => $data) {
                if (empty($prompt_list)) {
                    $prompt_list = $data['prompt_desc'];
                } else {
                    $prompt_list .= ', ' . $data['prompt_desc'];
                } // if
            } // foreach
            $fieldarray['prompt_list'] = $prompt_list;
        } // if

        if (isset($fieldarray['answer_type'])) {
            switch ($fieldarray['answer_type']) {
            	case 'M':
            		// get contents of ANSWER_OPTION and concatenate into a single string
                    $dbobject =& RDCsingleton::getInstance('answer_option');
                    $dbobject->sql_select = "answer_text";
                    $where2 = whereFilter($where, $dbobject->getPkeynames(), $dbobject->getTableName());
                    $data_array = $dbobject->getData($where2);
                    unset($dbobject);
                    $answer_list = '';
                    foreach ($data_array as $row => $data) {
                        if (empty($answer_list)) {
                            $answer_list = $data['answer_text'];
                        } else {
                            $answer_list .= ', ' . $data['answer_text'];
                        } // if
                    } // foreach
                    $fieldarray['answer_list'] = $answer_list;;
            		break;
            	case 'N':
            		// get contents of NUMBER_OPTION and concatenate into a single string
                    $dbobject =& RDCsingleton::getInstance('number_option');
                    $dbobject->sql_select = "min_value, max_value";
                    $where2 = whereFilter($where, $dbobject->getPkeynames(), $dbobject->getTableName());
                    $data_array = $dbobject->getData($where2);
                    unset($dbobject);
                    $answer_list = null;
                    if (isset($data_array[0]['min_value'])) {
                        $answer_list = "Minimum= {$data_array[0]['min_value']}";
                    } // if
                    if (isset($data_array[0]['max_value'])) {
                        if (strlen($answer_list) > 0) {
                            $answer_list .= ', ';
                        } // if
                        $answer_list .= "Maximum= {$data_array[0]['max_value']}";
                    } // if
                    $fieldarray['answer_list'] = $answer_list;;
            		break;
            	default:
            		;
            } // switch
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // set question_id to next available number
        if (!empty($fieldarray['survey_id']) AND !empty($fieldarray['section_id'])) {
            $where = "survey_id='{$fieldarray['survey_id']}' AND " . "section_id='{$fieldarray['section_id']}'";
            $query = "SELECT max(question_id) FROM $this->tablename WHERE $where";
            $count = $this->getCount($query);
            $fieldarray['question_id']  = $count + 1;
            $fieldarray['question_seq'] = $count + 1;
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item = '', $where)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'answer_type') {
//            $array['T'] = 'Text';
//            $array['M'] = 'Multiple Choice';
//            $array['N'] = 'Number';
            $array = getLanguageArray('answer_type');
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_post_deleteRecord ($fieldarray)
    // perform custom processing after database record is deleted.
    {
        // if there are any records with a sequence number greater than the one
        // which has just been deleted then they must be shuffled up in order
        // to absorb the now vacant number.
        $dboject =& RDCsingleton::getInstance('survey_question');
        $survey_id    = $fieldarray['survey_id'];
        $section_id   = $fieldarray['section_id'];
        $question_seq = $fieldarray['question_seq'];
        $where = "survey_id='$survey_id' AND section_id='$section_id' AND question_seq>$question_seq";
        $dboject->sql_orderby = 'question_seq';
        $rowdata = $dboject->getData_raw($where);

        foreach ($rowdata as $row => $data) {
            if ($data['question_seq'] <> $question_seq) {
                $data['question_seq'] = $question_seq;
                $data = $this->updateRecord($data);
            } // if
            $question_seq++;
        } // foreach

        return $fieldarray;

    } // _cm_post_deleteRecord

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        switch ($GLOBALS['task_id']) {
            case 'srv_answer_option(list)':
            case 'srv_answer_option(multi)':
                if ($rowdata[0]['answer_type'] != 'M') {
                    $this->errors[] = getLanguageText('e0013'); // 'Function invalid unless ANSWER TYPE = MULTIPLE CHOICE';
                } // if
                break;
            default:
                ;
        } // switch

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        $where = array2where($fieldarray, $this->getPkeyNames());

        switch ($fieldarray['answer_type']) {
            case 'M':
                $next['task_id'] = 'srv_answer_option(multi)';
                $next['where']   = $where;
                $next['action']  = 'OK';
                // this is processed by scriptnext() and scriptprevious()
                $_SESSION['script_sequence'][] = $next;
                break;
            case 'N':
                $next['task_id'] = 'srv_number_option(multi)';
                $next['where']   = $where;
                $next['action']  = 'OK';
                // this is processed by scriptnext() and scriptprevious()
                $_SESSION['script_sequence'][] = $next;
                break;
            default:
                ;
        } // switch

        $next['task_id'] = 'srv_question_prompt(link)';
        $next['where']   = $where;
        unset($next['action']);
        // this is processed by scriptnext() and scriptprevious()
        $_SESSION['script_sequence'][] = $next;

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database record is updated.
    {
        if ($fieldarray['answer_type'] <> $old_data['answer_type']) {
            // delete data associated with previous answer_type
            $where = array2where($fieldarray, $this->getPkeyNames());
            if ($old_data['answer_type'] == 'M') {
                require_once 'answer_option.class.inc';
                $dbobject =& RDCsingleton::getInstance('answer_option');
                $result = $dbobject->deleteMultiple($where);
                if ($result) {
                    $this->errors[] = $result;
                } // if
            } // if
            if ($old_data['answer_type'] == 'N') {
                require_once 'number_option.class.inc';
                $dbobject =& RDCsingleton::getInstance('number_option');
                $result = $dbobject->deleteRecord($fieldarray);
                $this->errors = $dbobject->getErrors();
            } // if
        } // if

        return $fieldarray;

    } // _cm_post_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
