<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class wf_place extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function wf_place ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'workflow';
        $this->tablename   = 'wf_place';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // wf_place

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        //DebugBreak();
        if (isset($fieldarray['workflow_id'])) {
            // set transition_id to next available number for this workflow_id
            $workflow_id = $fieldarray['workflow_id'];
            $query = "SELECT max(place_id) FROM $this->tablename WHERE workflow_id='$workflow_id'";
            $count = $this->getCount($query);
            $fieldarray['place_id'] = $count + 1;
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'place_id') {
            // get data from the database
            $this->sql_select     = 'place_id, place_name';
            $this->sql_orderby    = 'place_type';
            $this->sql_ordery_seq = 'asc';
            $data = $this->getData_raw($where);

            // convert each row into 'id=desc' in the output array
            foreach ($data as $row => $rowdata) {
                $rowvalues = array_values($rowdata);
                $array[$rowvalues[0]] = $rowvalues[1];
            } // foreach
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_pre_insertRecord ($fieldarray)
    // perform custom processing before database record is inserted.
    {
        //DebugBreak();
        if (empty($fieldarray['place_type'])) {
            // set default value
            $fieldarray['place_type'] = '5';
        } // if

        return $fieldarray;

    } // _cm_pre_insertRecord

    // ****************************************************************************
    function _cm_validateDelete ($fieldarray, $parent_table)
    // verify that the selected record can be deleted.
    // $parent_table is not empty during a cascade delete.
    // (put any errors in $this->errors)
    {
        switch ($fieldarray['place_type']) {
            case '1':
                $this->errors[] = getLanguageText('e0006'); // 'Cannot delete START place';
                return;
                break;
            case '9':
                $this->errors[] = getLanguageText('e0007'); // 'Cannot delete END place';
                return;
                break;
            default:
                ;
        } // switch

        return;

    } // _cm_validateDelete

// ****************************************************************************
} // end class
// ****************************************************************************

?>
