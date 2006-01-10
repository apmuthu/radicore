<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'survey_answer_hdr.class.inc';
class survey_answer_hdr_s01 extends survey_answer_hdr
{
    // ****************************************************************************
    // This subtype is for updating IS_COMPLETE
    // ****************************************************************************

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        $fieldarray = parent::_cm_getExtraData ($where, $fieldarray);

        if (is_true($fieldarray['is_complete'])) {
            $this->messages[] = getLanguageText('e0011'); // "Press SUBMIT to mark as INCOMPLETE";
        } else {
            $this->messages[] = getLanguageText('e0012'); // "Press SUBMIT to mark as COMPLETE";
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {

        if (!is_true($rowdata[0]['is_complete'])) {
            // check that all answers have been given
            // 1st - build an array of answers
            require_once 'survey_answer_dtl.class.inc';
            $dbobject =& singleton::getInstance('survey_answer_dtl');
            $null = $dbobject->setScrollArray($where);

            $last = $dbobject->getNumRows(); // get count of entries

            // 2nd - check each answer to see if it exists in the database
            $next = 0;
            while ($next <= $last) {
                // obtain primary key for next item
                $next++;
            	$where = $dbobject->getScrollItem($next);
            	$count = $dbobject->getCount($where);
            	if ($count == 0) {
            	    // convert string into an associative array
            	    $wherearray = where2array($where);
            	    // "Section X Answer Y is missing - cannot change status to COMPLETE"
            		$this->errors[] = getLanguageText('e0029', $wherearray['section_id'], $wherearray['question_id']);
            		break;
            	} else {
            	    // find out if this answer requires a jump to another section
            	    $null = $dbobject->checkJumpTo($where);
            	} // if

            } // while
        } // if

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_updateRecord ($fieldarray)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        // toggle flag between TRUE and FALSE
        if (is_true($fieldarray['is_complete'])) {
            $fieldarray['is_complete'] = false;
        } else {
            $fieldarray['is_complete'] = true;
        } // if

        return $fieldarray;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
