<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'survey_question.class.inc';
class survey_question_s03 extends survey_question
{
    // member variables
    var $question_seq;      // sequence number

    // ****************************************************************************
    // This subtype is for resequencing all the questions in a survey section
    // ****************************************************************************

    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database record is updated.
    {
        $text = getLanguageText('e0019'); // 'Questions have been resequenced';
        if (!is_long(array_search($text, $this->messages))) {
            $this->messages[] = $text;
        } // if

        return $fieldarray;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // remove everything from $where except survey_id and section_id
        $survey_id  = $where_array['survey_id'];
        $section_id = $where_array['section_id'];
        if (strlen($survey_id) == 0) {
            $this->errors[] = getLanguageText('e0020'); // "No value for SURVEY_ID has been supplied";
        } // if

        if (strlen($section_id) == 0) {
            $this->errors[] = getLanguageText('e0021'); // "No value for SECTION_ID has been supplied";
        } // if

        $where = "(survey_id='$survey_id' and section_id='$section_id')";

        $this->sql_orderby = 'question_seq';

        $this->question_seq = 1;    // sequence numbers start at 1

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_updateRecord ($fieldarray)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        // check if sequence nnumber needs updating
        if ($fieldarray['question_seq'] <> $this->question_seq) {
            $fieldarray['question_seq'] = $this->question_seq;
        } // if

        // increment sequence number
        $this->question_seq++;

        return $fieldarray;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
