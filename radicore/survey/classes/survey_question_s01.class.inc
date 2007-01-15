<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'survey_question.class.inc';
class survey_question_s01 extends survey_question
{
    // ****************************************************************************
    // This subtype is for moving rows UP in the question sequence
    // ****************************************************************************

    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        // can only process a single row
        if (count($rowdata) > 1) {
            // 'Multiple rows selected - only the 1st accepted'
            $this->messages[] = getLanguageText('e0014');
            $array[0] = $rowdata[0];
            $rowdata  = $array;
        } // if

        // check that this record can be moved UP in the sequence
        $survey_id   = $rowdata[0]['survey_id'];
        $section_id  = $rowdata[0]['section_id'];
        $question_id = $rowdata[0]['question_id'];

        // tell previous screen to keep this row selected
        $this->instruction['select']['question_id'] = $question_id;

        $question_seq = (int)$rowdata[0]['question_seq'];
        if ($question_seq <= 1) {
            $this->errors[] = getLanguageText('e0015'); // "This question cannot be moved UP any further";
            return $fieldarray;
        } // if

        // update sequence number of current section
        $prev_seq = $question_seq-1;
        $rowdata[0]['question_seq'] = $prev_seq;

        // get id of previous row in current sequence
        $where = "survey_id='$survey_id' AND section_id='$section_id' AND question_seq='$prev_seq'";
        $this->sql_select = 'question_id';
        $prev_row = $this->getData_raw($where);
        if ($this->numrows <> 1) {
            $this->errors[] = getLanguageText('e0016'); // "Could not locate previous record for updating";
            return $fieldarray;
        } // if

        // now update the row we have just swapped with
        $rowdata[1]['survey_id']    = $survey_id;
        $rowdata[1]['section_id']   = $section_id;
        $rowdata[1]['question_id']  = $prev_row[0]['question_id'];
        $rowdata[1]['question_seq'] = $question_seq;

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // check that full primary key has been passed down from parent form
        $this->checkPrimaryKey = true;

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
