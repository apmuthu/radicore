<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class wf_token extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'workflow';
        $this->tablename   = 'wf_token';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('token_status', $this->lookup_data)) {
            // get array for after_submit and put into LOOKUP_DATA
            $array = $this->getValRep('token_status');
            $this->lookup_data['token_status'] = $array;
        } // if

        if (!array_key_exists('workflow_id', $this->lookup_data)) {
            // get list of workflow names
            $dbobject =& RDCsingleton::getInstance('wf_workflow');
            $array = $dbobject->getValRep('workflow_id');
            $this->lookup_data['workflow_id'] = $array;
        } // if

        if (!empty($fieldarray['workflow_id'])) {
            $workflow_id = $fieldarray['workflow_id'];
            // get contents of foreign table PLACE and add as a LOOKUP list
            $dbobject =& RDCsingleton::getInstance('wf_place');
            $array = $dbobject->getValRep('place_id', "workflow_id='$workflow_id'");
            $this->lookup_data['place_id'] = $array;
            // set field control to dropdown
            $this->fieldspec['place_id']['control'] = 'dropdown';
        } else {
            unset($this->fieldspec['place_id']['control']);
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getForeignData ($fieldarray, $rownum=null)
    // Retrieve data from foreign entities.
    {
        global $mode;
        if ($mode == 'search' and isset($fieldarray['case_id'])) {
            $dbobject =& RDCsingleton::getInstance('wf_case');
            $dbobject->sql_select = 'workflow_id';
            $array = $dbobject->getData_raw("case_id='{$fieldarray['case_id']}'");
            if (!empty($array)) {
                $array = $array[0];
                $fieldarray = array_merge($fieldarray, $array);  // add to current data
            } // if
            // make this field 'read only'
            $this->fieldspec['workflow_id']['noedit'] = 'y';
        } // if

        return $fieldarray;

    } // _cm_getForeignData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        // set workflow_id to next available number
        $query = "SELECT max(token_id) FROM $this->tablename WHERE case_id='{$fieldarray['case_id']}'";
        $count = $this->getCount($query);
        $fieldarray['token_id'] = $count + 1;
        $this->retry_on_duplicate_key = 'token_id';

        // not allowed to set this field on INSERT
        $this->fieldspec['token_status']['nodisplay'] = 'y';

        $fieldarray['token_status'] = 'FREE';

        $fieldarray['enabled_date'] = getTimeStamp();

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item=null, $where=null, $orderby=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'token_status') {
//            $array['FREE'] = 'Free';
//            $array['LOCK'] = 'Locked';
//            $array['CONS'] = 'Consumed';
//            $array['CANC'] = 'Cancelled';
            $array = getLanguageArray('token_status');
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        if ($fieldarray['place_type'] == '9') {
            // this is the END place, so ....
            // mark this token as consumed
            $token_data['case_id']       = $fieldarray['case_id'];
            $token_data['rdcaccount_id'] = $fieldarray['rdcaccount_id'];
            $token_data['token_id']      = $fieldarray['token_id'];
            $token_data['token_status']  = 'CONS';
            $token_data['consumed_date'] = getTimeStamp();
            $token_data = $this->updateRecord($token_data);
            if ($this->errors) return $fieldarray;

            // mark any outstanding tokens as cancelled
            $where = "case_id='{$fieldarray['case_id']}' AND token_status IN ('FREE', 'LOCK')";
            $replace = "token_status='CANC'";
            $msg = $this->updateSelection($where, $replace);
            if ($this->errors) return $fieldarray;

            // mark any outstanding workitems as cancelled
            $dbworkitem =& RDCsingleton::getInstance('wf_workitem');
            $where = "case_id='{$fieldarray['case_id']}' AND workitem_status IN ('EN', 'IP')";
            $replace = "workitem_status='CA'";
            $msg = $dbworkitem->updateSelection($where, $replace);
            if ($dbworkitem->errors) {
                $this->errors = array_merge($this->errors, $dbworkitem->getErrors());
                return $fieldarray;
            } // if

            // mark this case as closed
            $dbcase =& RDCsingleton::getInstance('wf_case');
            $case_data['case_id']       = $fieldarray['case_id'];
            $case_data['rdcaccount_id'] = $fieldarray['rdcaccount_id'];
            $case_data['case_status']   = 'CL';
            $case_data['end_date']      = getTimeStamp();
            $case_data = $dbcase->updateRecord($case_data);
            if ($dbcase->errors) {
                $this->errors = array_merge($this->errors, $dbcase->getErrors());
                return $fieldarray;
            } // if
            return $fieldarray;
        } // if

        // this is not the end, so continue .....
        $workflow_id = $fieldarray['workflow_id'];
        $place_id = $fieldarray['place_id'];

        // find all transitions which are joined to this place via INWARD arcs
        $dbarc =& RDCsingleton::getInstance('wf_arc');
        $dbarc->sql_select = 'wf_arc.workflow_id, wf_arc.transition_id, place_id, direction, arc_type, task_id, role_id, transition_trigger, time_limit';
        $dbarc->sql_from = 'wf_arc '
                         . "LEFT JOIN wf_transition ON (wf_transition.workflow_id=wf_arc.workflow_id AND wf_transition.transition_id=wf_arc.transition_id) ";
        $where = "workflow_id='$workflow_id' AND place_id='$place_id' AND direction='IN'";
        $arc_data = $dbarc->getData($where);

        foreach ($arc_data as $arc_instance) {
            $arc_instance['case_id'] = $fieldarray['case_id'];
            $arc_instance['context'] = $fieldarray['context'];
            if (!empty($arc_instance['role_id'])) {
                // role_id has been specified, so unassign from user
                $arc_instance['user_id'] = null;
            } else {
                // assign to role_id and optionally a specific user_id
            	$arc_instance['role_id'] = $_SESSION['role_id'];
                if (isset($fieldarray['user_id'])) {
                    $arc_instance['user_id'] = $fieldarray['user_id'];
                } // if
            } // if
            $arc_instance = $dbarc->examineInwardArc($arc_instance);
            if ($dbarc->errors) {
                $this->errors = array_merge($this->errors, $dbarc->getErrors());
                return $fieldarray;
            } // if
        } // foreach

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array).
    // $parent_data may contain contents of current record in the parent object.
    {
        // only do this if sql_select is empty
        if (empty($this->sql_select)) {
            // include columns from foreign table
            $this->sql_select = 'wf_token.*, workflow_name, place_name';
            $this->sql_from   = 'wf_token '
                              . 'LEFT JOIN wf_workflow ON (wf_workflow.workflow_id=wf_token.workflow_id) '
                              . 'LEFT JOIN wf_place ON (wf_place.workflow_id=wf_token.workflow_id AND wf_place.place_id=wf_token.place_id)';
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
