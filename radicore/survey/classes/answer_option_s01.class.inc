<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'answer_option.class.inc';
class answer_option_s01 extends answer_option
{
    // member variables
    var $done;          // flag to indicate that function has already been processed

    // ****************************************************************************
    // special subtype for use only by script 'answer_option_quick.php'.
    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        //DebugBreak();
        if ($this->done) {
            // this function has already been done, so use the function from
            // the parent class instead
            $fieldarray = parent::_cm_getInitialData($fieldarray);
            return $fieldarray;
        } else {
            $this->done = true;
        } // if

        if (!empty($fieldarray['survey_id'])
                AND !empty($fieldarray['section_id'])
                AND !empty($fieldarray['question_id'])) {
            $where = "survey_id='{$fieldarray['survey_id']}' AND " . "section_id='{$fieldarray['section_id']}' AND " . "question_id='{$fieldarray['question_id']}'";
        } // if

        if (empty($where)) {
            $this->errors[] = getLanguageText('sys0082'); // 'No parent has been selected yet.';
            return;
        } // if

        $count = $this->getCount($where);
        if ($count == 0) {
            // create entries for 'Yes' and 'No'
            $fieldarray['answer_text'] = getLanguageText('Yes'); // 'Yes';
            $rowdata[] = $fieldarray;
            $fieldarray['answer_text'] = getLanguageText('No'); // 'No';
            $rowdata[] = $fieldarray;
            // return $rowdata as output
            $fieldarray = $rowdata;
        } elseif ($count == 2) {
            // create 3rd entry for 'Not Applicable'
            $fieldarray['answer_text'] = getLanguageText('Not Applicable'); // 'Not Applicable';
            $rowdata[] = $fieldarray;
            // return $rowdata as output
            $fieldarray = $rowdata;
        } else {
            // not possible to add any more entries
            $this->errors[] = getLanguageText('e0004'); // "Cannot run this function if answers already exist";
        } // if

        return $fieldarray;

    } // _cm_getInitialData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
