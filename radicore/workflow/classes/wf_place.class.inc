<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class wf_place extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'workflow';
        $this->tablename   = 'wf_place';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

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
    function _cm_getValRep ($item=null, $where=null, $orderby=null)
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
    function _cm_post_deleteRecord ($fieldarray)
    // perform custom processing after database record has been deleted.
    {
        $result = $this->_updateWorkflow($fieldarray['workflow_id']);

        return $fieldarray;

    } // _cm_post_deleteRecord

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record has been inserted.
    {
        $result = $this->_updateWorkflow($fieldarray['workflow_id']);

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database record is updated.
    {
        $result = $this->_updateWorkflow($fieldarray['workflow_id']);

        return $fieldarray;

    } // _cm_post_updateRecord

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

    // ***************************************************************************
    function _updateWorkflow ($workflow_id)
    // set IS_VALID to FALSE to force workflow to be revalidated.
    {
        $dbobject = RDCsingleton::getInstance('wf_workflow');
        $update['workflow_id'] = $workflow_id;
        $update['is_valid']    = FALSE;
        $update = $dbobject->updateRecord($update);
        if ($dbobject->errors) {
            $this->errors[$dbobject->getClassName()] = $dbobject->errors;
            return false;
        } // if

        return true;

    } // _updateWorkflow

// ****************************************************************************
} // end class
// ****************************************************************************

?>
