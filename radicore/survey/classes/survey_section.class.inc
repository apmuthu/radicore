<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class survey_section extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function survey_section ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'survey';
        $this->tablename   = 'survey_section';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // survey_section

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // set section_id to next available number
        if (!empty($fieldarray['survey_id'])) {
            $where = "survey_id='{$fieldarray['survey_id']}'";
            $query = "SELECT max(section_id) FROM $this->tablename WHERE $where";
            $count = $this->getCount($query);
            $fieldarray['section_id'] = $count + 1;
            $fieldarray['section_seq'] = $count + 1;
        } // if

        $this->fieldspec['survey_id']['noedit']   = 'y';
        $this->fieldspec['section_id']['noedit']  = 'y';
        $this->fieldspec['section_seq']['noedit'] = 'y';

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_post_deleteRecord ($fieldarray)
    // perform custom processing after database record is deleted.
    {
        // if there are any records with a sequence number greater than the one
        // which has just been deleted then they must be shuffled up in order
        // to absorb the now vacant number.
        $survey_id   = $fieldarray['survey_id'];
        $section_seq = $fieldarray['section_seq'];
        $where       = "survey_id='$survey_id' and section_seq > $section_seq";
        $this->sql_orderby = 'section_seq';
        $rowdata = $this->getData_raw($where);
        if ($this->numrows == 0) {
            return $fieldarray;
        } // if

        foreach ($rowdata as $row => $data) {
            if ($data['section_seq'] <> $section_seq) {
                $data['section_seq'] = $section_seq;
                $data = $this->updateRecord($data);
            } // if
            $section_seq++;
        } // foreach

        return $fieldarray;

    } // _cm_post_deleteRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
