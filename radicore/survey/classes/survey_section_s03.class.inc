<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'survey_section.class.inc';
class survey_section_s03 extends survey_section
{
    // member variables
    var $section_seq;       // sequence number

    // ****************************************************************************
    // This subtype is for resequencing all the sections in a survey
    // ****************************************************************************

    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database record is updated.
    {
        $text = getLanguageText('e0024'); // 'Sections have been resequenced';
        if (!is_long(array_search($text, $this->messages))) {
            $this->messages[] = $text;
        } // if

        return $fieldarray;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        //DebugBreak();
        // remove everything but survey_id from $where
        $survey_id = $where_array['survey_id'];
        if (strlen($survey_id) == 0) {
            $this->errors[] = getLanguageText('e0020'); // "No value for SURVEY_ID has been supplied";
        } // if

        $where = "(survey_id='$survey_id')";

        $this->sql_orderby = 'section_seq';

        $this->section_seq = 1;     // sequence numbers start at 1

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_updateRecord ($fieldarray)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        //DebugBreak();
        // check if sequence no needs updating
        if ($fieldarray['section_seq'] <> $this->section_seq) {
            $fieldarray['section_seq'] = $this->section_seq;
        } // if

        // increment sequence number
        $this->section_seq++;

        return $fieldarray;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
