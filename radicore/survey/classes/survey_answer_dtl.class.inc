<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class survey_answer_dtl extends Default_Table
{
    // additional member variables
    var $survey_answer_id;      // original primary key

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function survey_answer_dtl ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'survey';
        $this->tablename   = 'survey_answer_dtl';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // survey_answer_dtl

    // ****************************************************************************
    function checkJumpTo ($where, $fieldarray=array())
    // check if the amswer to the current question requires a jump to a question
    // in a different section.
    {
        if (empty($fieldarray)) {
        	// convert $where string into an associative array
            $wherearray = where2array($where);
            $survey_id   = $wherearray['survey_id'];
            $section_id  = $wherearray['section_id'];
            $question_id = $wherearray['question_id'];
        } else {
            $survey_id   = $fieldarray['survey_id'];
            $section_id  = $fieldarray['section_id'];
            $question_id = $fieldarray['question_id'];
        } // if

        $question_where = "survey_id='$survey_id' AND section_id='$section_id' AND question_id='$question_id'";

        if (empty($fieldarray['question_text']) and !empty($question_id)) {
            include_once 'survey_question.class.inc';
            $dbobject =& singleton::getInstance('survey_question');

            $dbobject->sql_select = 'question_text, question_seq, advice_text, answer_type';
            $data = $dbobject->getData($question_where);

            // use data from 1st row only
            $fieldarray = array_merge($fieldarray, $data[0]);

            unset($dbobject);
        } // if

        if ($fieldarray['answer_type'] == 'M') {
            if (!isset($fieldarray['answer_text'])) {
            	// get the current answer
            	$save_select = $this->sql_select;
                $this->sql_select = 'answer_text';
                $data = $this->getData($where);
                $this->sql_select = $save_select;
                if (!empty($data)) {
                	$fieldarray = array_merge($fieldarray, $data[0]);
                } // if
            } // if

            if (isset($fieldarray['answer_text'])) {
                // answer is multiple choice, so see if a JUMP TO has been set for the current answer
                require_once 'answer_option.class.inc';
                $dbobject =& singleton::getInstance('answer_option');

                $dbobject->sql_select = 'jumpto_section_seq';
                $answer_where = "survey_id='$survey_id' AND "
                              . "section_id='$section_id' AND "
                              . "question_id='$question_id' AND "
                              . "answer_id='{$fieldarray['answer_text']}'";
                $data = $dbobject->getData($answer_where);

                if (isset($data[0]['jumpto_section_seq'])) {
                    $jumpto_section_seq = $data[0]['jumpto_section_seq'];
                    $fieldarray['jumpto_text'] = "Jump to Section $jumpto_section_seq";
                    // now find the question number
                    // step forwards through scrollarray until the start of the desired section
                    for ($i = $this->scrollindex; $i < count($this->scrollarray); $i++) {
                        if ($this->scrollarray[$i]['section_seq'] == $jumpto_section_seq) {
                            break;
                        } // if
                    } // for
                    // add these details to the jump array
                    addJump($this->scrollindex, $i);
                } // if
                unset($dbobject);
            } // if
        } // if

        return $fieldarray;

    } // checkJumpTo

    // ****************************************************************************
    function _cm_getDatabaseLock ()
    // return array of database tables to be locked in current transaction.
    {
        $GLOBALS['lock_tables'] = FALSE;    // TRUE/FALSE
        $GLOBALS['lock_rows']   = FALSE;    // FALSE, SR (share), EX (exclusive)

        // the format of each $lock_array entry is one of the following:
        // $lock_array[] = 'tablename'         (within current database)
        // $lock_array[] = 'dbname.tablename'  (within another database)
        // $lock_array['READ'][] = '...'       (for a READ lock)
        switch ($GLOBALS['mode']){
            case 'insert':
                $lock_array[] = $this->tablename;
                $lock_array['READ'][] = 'answer_option';
                break;
            case 'update':
                $lock_array[] = $this->tablename;
                $lock_array['READ'][] = 'answer_option';
                break;
            case 'delete':
                $lock_array[] = $this->tablename;
                break;
            default:
                $lock_array = array();
        } // switch

        return $lock_array;

    } // _cm_getDatabaseLock

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        if (empty($fieldarray['survey_answer_id']) and !empty($fieldarray['survey_id'])) {
            // not supplied yet, so get it manually
            require_once 'survey_answer_hdr.class.inc';
            $dbobject =& singleton::getInstance('survey_answer_hdr');

            $dbobject->sql_select = 'survey_id, survey_answer_id, user_id, answer_date, node_id, is_complete';
            $data = $dbobject->getData("survey_answer_id='$this->survey_answer_id'");

            // get data from foreign tables
            $data = $dbobject->getExtradata($data);

            // merge with internal array
            $fieldarray = array_merge($fieldarray, $data[0]);

            unset($dbobject);

        } // if

        $survey_id   = $fieldarray['survey_id'];
        $section_id  = $fieldarray['section_id'];
        $question_id = $fieldarray['question_id'];

        $question_where = "survey_id='$survey_id' AND section_id='$section_id' AND question_id='$question_id'";

        $fieldarray = $this->checkJumpTo($where, $fieldarray);

        if ($fieldarray['answer_type'] == 'M') {
            // get contents of ANSWER_OPTION and add as a LOOKUP list
            require_once 'answer_option.class.inc';
            $dbobject =& singleton::getInstance('answer_option');

            $data_array = $dbobject->getValRep('answer_id', $question_where);
            $this->lookup_data['answer_id'] = $data_array;

            // answer is an entry from a dropdown list
            $this->fieldspec['answer_text']     = array('type' => 'string',
                                                        'size' => 12,
                                                        'required' => 'y',
                                                        'control' => 'dropdown',
                                                        'optionlist' => 'answer_id');

            unset($dbobject);

        } elseif ($fieldarray['answer_type'] == 'N') {
            // get contents of NUMBER_OPTION for possible min/max values
            require_once 'number_option.class.inc';
            $dbobject =& singleton::getInstance('number_option');

            $dbobject->sql_select = 'min_value,max_value';
            $data_array = $dbobject->getData($question_where);
            if (isset($data_array[0]['min_value'])) {
                $min_value = (int)$data_array[0]['min_value'];
            } // if

            if (isset($data_array[0]['max_value'])) {
                $max_value = (int)$data_array[0]['max_value'];
            } // if

            unset($dbobject);

            // answer is a number, not text, so shorten field
            $this->fieldspec['answer_text']     = array('type' => 'integer',
                                                        'unsigned' => 'y',
                                                        'size' => 12,
                                                        'required' => 'y');
            if (isset($min_value)) {
                $this->fieldspec['answer_text']['minvalue'] = $min_value;
            } // if

            if (isset($max_value)) {
                $this->fieldspec['answer_text']['maxvalue'] = $max_value;
            } // if

        } else {
            // answer is a multiline text field
            $this->fieldspec['answer_text']     = array('type' => 'string',
                                                        'control' => 'multiline',
                                                        'rows' => 5,
                                                        'cols' => 50,
                                                        'size' => 255,
                                                        'required' => 'y');
        } // if

        // get contents of foreign table RISK_WEIGHTING and add as a LOOKUP list
        require_once 'risk_weighting.class.inc';
        $dbobject =& singleton::getInstance('risk_weighting');
        $data_array = $dbobject->getValRep('weighting_id');
        $this->lookup_data['weighting_id'] = $data_array;
        unset($dbobject);

        // get contents of QUESTION_PROMPT and concatenate into a single list
        require_once 'question_prompt.class.inc';
        $dbobject =& singleton::getInstance('question_prompt');
        $dbobject->sql_select = "prompt_desc";
        $dbobject->sql_from   = "question_prompt "
                              . "LEFT JOIN default_prompt USING (survey_id,prompt_id)";
        $data_array = $dbobject->getData($question_where);
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

        if (is_true($fieldarray['is_complete'])) {
            $this->errors[] = getLanguageText('e0010'); // "Cannot update a survey which is marked as COMPLETE";
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // display autoinsert/autoupdate fields on this input screen
        foreach ($this->fieldspec as $field => $spec) {
        	if (array_key_exists('autoinsert', $spec) or array_key_exists('autoupdate', $spec)) {
        	    unset($this->fieldspec[$field]['nodisplay']);
        	} // if
        } // foreach

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        // processing is the same as for update mode
        $fieldarray = $this->_cm_post_updateRecord($fieldarray, $fieldarray);

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database record is updated.
    {
        //DebugBreak();
        if ($fieldarray['answer_type'] == 'M') {
            // this answer may have a 'jumpto' option, so ...
            // first we must clear any previous 'jumpto' for the current question
            clearJump($this->scrollindex);

            // now look for a new 'jumpto' option
            require_once 'answer_option.class.inc';
            $dbobject =& singleton::getInstance('answer_option');

            $dbobject->sql_select = 'jumpto_section_seq';
            $where = "survey_id='{$fieldarray['survey_id']}' AND "
                   . "section_id='{$fieldarray['section_id']}' AND "
                   . "question_id='{$fieldarray['question_id']}' AND "
                   . "answer_id='{$fieldarray['answer_text']}'";
            $data_array = $dbobject->getData($where);
            if (isset($data_array[0]['jumpto_section_seq'])) {
                $jumpto_section_seq = $data_array[0]['jumpto_section_seq'];
            } // if
            unset($dbobject);
        } // if

        if (isset($jumpto_section_seq)) {
            // step forwards through scrollarray until the start of the desired section
            for ($i = $this->scrollindex; $i < count($this->scrollarray); $i++) {
                if ($this->scrollarray[$i]['section_seq'] == $jumpto_section_seq) {
                    break;
                } // if
            } // for

            $jump_to = $i;
            // add these details to the jump array
            addJump($this->scrollindex, $jump_to);

        } else {
            // default is to jump to next queston
            $jump_to = $this->scrollindex + 1;
        } // if

        // set query string to jump to next answer, gthen restart curren script
        scriptRestart($this, "scrolling=$this->tablename&item=$jump_to");

        return $fieldarray;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_setScrollArray ($where, $wherearray)
    // construct an array of primary keys to scroll through
    {
        //DebugBreak();
        $array = array();

        $this->survey_answer_id = $wherearray['survey_answer_id'];
        $where = "survey_answer_id='$this->survey_answer_id'";

        $this->checkPrimaryKey = false;

        // 1 - read survey_answer_hdr to get survey_id
        require_once 'survey_answer_hdr.class.inc';
        $dbobject =& singleton::getInstance('survey_answer_hdr');

        $dbobject->sql_select = 'survey_id, user_id, is_complete';
        $hdrdata = $dbobject->getData($where);
        $errors = $dbobject->getErrors();
        unset($dbobject);
        if ($errors) {
            $this->errors = $errors;
            return;
        } // if

        if (is_true($hdrdata[0]['is_complete'])) {
            $this->errors[] = getLanguageText('e0010'); // "Cannot update a survey which is marked as COMPLETE";
            return;
        } // if

        // 2 - read all the sections for the selected survey_id
        $survey_id = $hdrdata[0]['survey_id'];
        require_once 'survey_section.class.inc';
        $dbobject =& singleton::getInstance('survey_section');

        $dbobject->sql_select = 'survey_id, section_seq, section_id';
        $dbobject->sql_orderby = 'section_seq';
        $sectionpkey = $dbobject->getPkeyNames();
        $sectiondata = $dbobject->getData("survey_id='$survey_id'");
        $errors = $dbobject->getErrors();
        unset($dbobject);
        if ($errors) {
            $this->errors = $errors;
            return;
        } // if

        // 3 - loop through all sections and read the questions
        require_once 'survey_question.class.inc';
        $dbobject =& singleton::getInstance('survey_question');

        $dbobject->sql_select = 'survey_id, section_id, question_id';
        $dbobject->sql_orderby = 'question_seq';

        foreach ($sectiondata as $sectionrow) {
            $where = array2where($sectionrow, $sectionpkey);
            $questiondata = $dbobject->getData($where);
            foreach ($questiondata as $questionrow) {
                // transfer other data into $questionrow
                $questionrow['survey_answer_id'] = $this->survey_answer_id;
                // 'section_seq' is required by the 'jumpto' function
                $questionrow['section_seq'] = $sectionrow['section_seq'];
                // append $questionrow to scrollarray
                $array[] = $questionrow;
            } // foreach
        } // foreach

        return $array;

    } // _cm_setScrollArray

// ****************************************************************************
} // end class
// ****************************************************************************

?>
