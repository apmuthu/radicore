<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class wf_case extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function wf_case ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'workflow';
        $this->tablename   = 'wf_case';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // wf_case

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        // get array for after_submit and put into LOOKUP_DATA
        $array = $this->getValRep('case_status');
        $this->lookup_data['case_status'] = $array;

        // get list of workflow names
        require_once 'wf_workflow.class.inc';
        $dbobject =& singleton::getInstance('wf_workflow');
        $array = $dbobject->getValRep('workflow_id');
        $this->lookup_data['workflow_id'] = $array;

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        //DebugBreak();
        // set workflow_id to next available number
        $query = "SELECT max(case_id) FROM $this->tablename";
        $count = $this->getCount($query);
        $fieldarray['case_id'] = $count + 1;

        // not allowed to set this field on INSERT
        $this->fieldspec['case_status']['nodisplay'] = 'y';
        $fieldarray['case_status'] = 'OP';

        $fieldarray['start_date'] = getTimeStamp();

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item = '', $where)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'case_status') {
//            $array['OP'] = 'Open';
//            $array['CL'] = 'Closed';
//            $array['SU'] = 'Suspended';
//            $array['CA'] = 'Cancelled';
            $array= getLanguageArray('case_status');
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        //DebugBreak();
        $workflow_id = $fieldarray['workflow_id'];

        // a new workflow instance has started, so ....
        // find the place which is the start point
        require_once 'wf_place.class.inc' ;
        $dbplace =& singleton::getInstance('wf_place');

        $dbplace->sql_select = "workflow_id, place_id, place_type";
        $place_data = $dbplace->getData("workflow_id='$workflow_id' AND wf_place.place_type='1'");
        if ($dbplace->errors) {
            $this->errors = array_merge($this->errors, $dbplace->getErrors());
            return $fieldarray;
        } // if

        if ($dbplace->numrows = 0) {
            // "There is no START place fow workflow $workflow_id"
            $this->errors[] = getlanguageText('e0005', $workflow_id);
            return $fieldarray;
        } // if

        // create a token for the start point
        require_once 'wf_token.class.inc';
        $dbtoken =& singleton::getInstance('wf_token');
        $token_array['workflow_id'] = $fieldarray['workflow_id'];
        $token_array['place_id']    = $place_data[0]['place_id'];
        $token_array['place_type']  = $place_data[0]['place_type'];
        $token_array['case_id']     = $fieldarray['case_id'];
        $token_array['context']     = stripslashes($fieldarray['context']);
        $token_array = $dbtoken->insertRecord($token_array);
        if ($dbtoken->errors) {
            $this->errors = array_merge($this->errors, $dbtoken->getErrors());
            return $fieldarray;
        } // if

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    {
        // only do this if sql_select is empty
        if (empty($this->sql_select)) {
            // include columns from foreign table
            $this->sql_select = 'wf_case.*, workflow_name';
            $this->sql_from   = 'wf_case '
                               .'LEFT JOIN wf_workflow ON (wf_workflow.workflow_id=wf_case.workflow_id)';
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>