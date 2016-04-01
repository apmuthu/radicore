<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'audit_ssn.class.inc';
class audit_ssn_s01 extends audit_ssn
{
    // ****************************************************************************
    // this class is for use by script: audit_ssn(batch)delete.php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_deleteSelection ($selection)
    // delete/update a selection of records in a single operation.
    {
        // remove this line after your customisation
        //trigger_error(getLanguageText('sys0035', get_class($this)), E_USER_ERROR); // "DELETESELECTION method has not been defined in class"

        global $stdout, $stdouth;

        // read each record so that its child relations can also be deleted
        $resource = $this->getData_serial($selection);

        $count = 0;
        while ($row = $this->fetchRow($resource)){
            if (!empty($stdout)) {
                $result = fwrite($stdouth, "<p>Deleting records for session_id '{$row['session_id']}', date/time: '{$row['ssn_datetime']}");
            } // if
            $from = 'ssn, trn, tbl, fld';
            $using = 'audit_ssn AS ssn'
                   .' LEFT JOIN audit_trn AS trn ON (trn.session_id=ssn.session_id)'
                   .' LEFT JOIN audit_tbl AS tbl ON (tbl.session_id=trn.session_id'
                                              .' AND tbl.tran_seq_no=trn.tran_seq_no)'
                   .' LEFT JOIN audit_fld AS fld ON (fld.session_id=tbl.session_id'
                                              .' AND fld.tran_seq_no=tbl.tran_seq_no'
                                              .' AND fld.table_seq_no=tbl.table_seq_no)';
            $selection = "ssn.session_id={$row['session_id']}";
            $child_count = $this->_dml_deleteSelection($selection, $from, $using);
            if (!empty($stdout)) {
                $result = fwrite($stdouth, ", child records deleted = $child_count</p>\n");
            } // if
            $count++;
        } // while

        // $count rows were deleted
        return $this->getLanguageText('sys0004', $count, strtoupper($this->tablename));

    } // _cm_deleteSelection

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search=null)
    // perform any initialisation for the current task.
    // NOTE: $selection is passed by reference as it may be amended.
    // NOTE: $search    is only available for OUTPUT tasks.
    {
        // this is the batch delete, so set selection criteria
        $dbobject =& RDCsingleton::getInstance('mnu_control');
        $data = $dbobject->getControlData('audit_delete');
        $number =& $data['audit_delete'];
        if ($number < 1) $number = 99;
        $period =& $data['audit_delete_period'];
        if (empty($period)) $period = 'YEAR';

        $today = getTimeStamp('date');
        //$selection = "DATE_ADD(DATE(ssn_datetime), INTERVAL $years YEAR) < '$today'";
        $selection = "ssn_datetime < DATE_SUB('$today', INTERVAL $number $period)";
        $count = $this->getCount($selection);
        // add a message to the output file
        global $stdout, $stdouth;
        if (!empty($stdout)) {
            $result = fwrite($stdouth, "<p>Deleting records greater than $years years old, count=$count</p>\n");
        } // if

        return $where;

    } // _cm_initialise

// ****************************************************************************
} // end class
// ****************************************************************************

?>
