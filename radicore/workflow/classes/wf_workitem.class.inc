<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class wf_workitem extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function wf_workitem ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'workflow';
        $this->tablename   = 'wf_workitem';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // wf_workitem

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        // get array for workitem_status and put into LOOKUP_DATA
        $array = $this->getValRep('workitem_status');
        $this->lookup_data['workitem_status'] = $array;

        // get array for transition_trigger and put into LOOKUP_DATA
        $array = $this->getValRep('transition_trigger');
        $this->lookup_data['transition_trigger'] = $array;

        require_once 'classes/mnu_role.class.inc';
        $dbobject =& singleton::getInstance('mnu_role');
        $role_array = $dbobject->getValRep('role_id');
        $this->lookup_data['role_id'] = $role_array;

        require_once 'classes/mnu_user.class.inc';
        $dbobject =& singleton::getInstance('mnu_user');
        $role_array = $dbobject->getValRep('user_id');
        $this->lookup_data['user_id'] = $role_array;

        // get list of workflow names
        if (!class_exists('wf_workflow', false)) {
        	require_once 'wf_workflow.class.inc';
        } // if
        $dbobject =& singleton::getInstance('wf_workflow');
        $array = $dbobject->getValRep('workflow_id');
        $this->lookup_data['workflow_id'] = $array;

        if (!empty($fieldarray['workflow_id'])) {
            $workflow_id = $fieldarray['workflow_id'];
            // get contents of foreign table TRANSITION and add as a LOOKUP list
            require_once 'wf_transition.class.inc';
            $dbobject =& singleton::getInstance('wf_transition');
            $array = $dbobject->getValRep('transition_id', "workflow_id='$workflow_id'");
            $this->lookup_data['transition_id'] = $array;
            // set field control to dropdown
            $this->fieldspec['transition_id']['control'] = 'dropdown';
        } else {
            unset($this->fieldspec['transition_id']['control']);
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getForeignData ($fieldarray)
    // Retrieve data from foreign entities.
    {
        //DebugBreak();
        global $mode;
        if ($mode == 'search' and isset($fieldarray['case_id'])) {
            require_once 'wf_case.class.inc';
            $dbobject =& singleton::getInstance('wf_case');
            $dbobject->sql_select = 'workflow_id';
            $array = $dbobject->getData("case_id='{$fieldarray['case_id']}'");
            // add to current data
            $fieldarray = array_merge($fieldarray, $array[0]);
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
        //DebugBreak();
        // set workflow_id to next available number
        $query = "SELECT max(workitem_id) FROM $this->tablename WHERE case_id='{$fieldarray['case_id']}'";
        $count = $this->getCount($query);
        $fieldarray['workitem_id'] = $count + 1;

        // not allowed to set this field on INSERT
        $this->fieldspec['workitem_status']['nodisplay'] = 'y';
        $fieldarray['workitem_status'] = 'EN';

        if (empty($fieldarray['enabled_date'])) {
            $fieldarray['enabled_date'] = getTimeStamp();
        } // if

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getValRep ($item = '', $where)
    // get Value/Representation list as an associative array.
    {
        $array = array();

        if ($item == 'workitem_status') {
//            $array['EN'] = 'Enabled';
//            $array['IP'] = 'In Progress';
//            $array['CA'] = 'Cancelled';
//            $array['FI'] = 'Finished';
            $array = getLanguageArray('workitem_status');
            return $array;
        } // if

        if ($item == 'transition_trigger') {
            require_once 'wf_transition.class.inc';
            $dbtransition =& singleton::getInstance('wf_transition');
            $array = $dbtransition->getValRep($item);
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        //DebugBreak();
        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    {
        //DebugBreak();
        global $dbprefix;

        // only do this if sql_select is empty
        if (empty($this->sql_select)) {
            // include columns from foreign table
            $this->sql_select = 'user_id, role_id, wf_workitem.workflow_id, case_id, workitem_id, wf_workitem.task_id, transition_trigger, workitem_status, enabled_date, deadline, context, workflow_name, task_desc';
            $this->sql_from   = 'wf_workitem '
                              . 'LEFT JOIN wf_workflow ON (wf_workflow.workflow_id=wf_workitem.workflow_id) '
                              . 'LEFT JOIN ' . $dbprefix . 'menu.mnu_task ON (mnu_task.task_id=wf_workitem.task_id) ';
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
