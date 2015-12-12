<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'survey_section.class.inc';
class survey_section_s01 extends survey_section
{
    // member variables

    // ****************************************************************************
    // This subtype is for moving rows UP in the section sequence
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
        $survey_id  = $rowdata[0]['survey_id'];
        $section_id = $rowdata[0]['section_id'];

        // tell previous screen to keep this row selected
        $this->instruction['select']['section_id'] = $section_id;

        $section_seq = (int)$rowdata[0]['section_seq'];
        if ($section_seq <= 1) {
            $this->errors[] = getLanguageText('e0022'); // "This section cannot be moved UP any further";
            return $fieldarray;
        } // if

        // update sequence number of current section
        $prev_seq = $section_seq-1;
        $rowdata[0]['section_seq'] = $prev_seq;

        // get id of previous row in current sequence
        $where = "survey_section.survey_id='$survey_id' and section_seq='$prev_seq'";
        $this->sql_select = 'section_id';
        $prev_row = $this->getData_raw($where);
        if ($this->numrows <> 1) {
            $this->errors[] = getLanguageText('e0016'); // "Could not locate previous record for updating";
            return $fieldarray;
        } // if

        // now update the row we have just swapped with
        $rowdata[1]['survey_id']   = $survey_id;
        $rowdata[1]['section_id']  = $prev_row[0]['section_id'];
        $rowdata[1]['section_seq'] = $section_seq;

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
