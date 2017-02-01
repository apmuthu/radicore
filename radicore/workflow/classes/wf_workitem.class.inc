<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class wf_workitem extends Default_Table
{
    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbname      = 'workflow';
        $this->tablename   = 'wf_workitem';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if ($GLOBALS['mode'] == 'search') {
        	unset($this->fieldspec['workitem_status']['noedit']);
        	unset($this->fieldspec['transition_trigger']['noedit']);

        } elseif ($GLOBALS['mode'] == 'list') {
            unset($this->fieldspec['context']['control']);
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('workitem_status', $this->lookup_data)) {
            // get array for workitem_status and put into LOOKUP_DATA
            $array = $this->getValRep('workitem_status');
            $this->lookup_data['workitem_status'] = $array;
        } // if

        if (!array_key_exists('transition_trigger', $this->lookup_data)) {
            // get array for transition_trigger and put into LOOKUP_DATA
            $array = $this->getValRep('transition_trigger');
            $this->lookup_data['transition_trigger'] = $array;
        } // if

        if (!array_key_exists('role_id', $this->lookup_data)) {
            $dbobject =& RDCsingleton::getInstance('mnu_role');
            $role_array = $dbobject->getValRep('role_id');
            $this->lookup_data['role_id'] = $role_array;
        } // if

        if (!array_key_exists('user_id', $this->lookup_data)) {
            $dbobject =& RDCsingleton::getInstance('mnu_user');
            $role_array = $dbobject->getValRep('user_id');
            $this->lookup_data['user_id'] = $role_array;
        } // if

        if (!array_key_exists('workflow_id', $this->lookup_data)) {
            // get list of workflow names
            $dbobject =& RDCsingleton::getInstance('wf_workflow');
            $array = $dbobject->getValRep('workflow_id');
            $this->lookup_data['workflow_id'] = $array;
        } // if

        if (!empty($fieldarray['workflow_id'])) {
            $workflow_id = $fieldarray['workflow_id'];
            // get contents of foreign table TRANSITION and add as a LOOKUP list
            $dbobject =& RDCsingleton::getInstance('wf_transition');
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
    function _cm_getForeignData ($fieldarray, $rownum=null)
    // Retrieve data from foreign entities.
    {
        global $mode;
        if ($mode == 'search' and isset($fieldarray['case_id'])) {
            require_once 'classes/wf_case.class.inc';
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
    function _cm_getValRep ($item=null, $where=null, $orderby=null)
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
            require_once 'classes/wf_transition.class.inc';
            $dbtransition =& RDCsingleton::getInstance('wf_transition');
            $array = $dbtransition->getValRep($item);
            return $array;
        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // find out if tables in the 'menu' database need to be qualified
        $menuDB = findDBName('menu', $this->dbname);

        // only do this if sql_select is empty
        if (empty($this->sql_select)) {
            // include columns from foreign table
            $this->sql_select  = 'wf_workitem.rdcaccount_id, wf_workitem.user_id, wf_workitem.role_id, wf_workitem.workflow_id, wf_workitem.case_id, wf_workitem.workitem_id, wf_workitem.transition_id, wf_workitem.task_id, wf_workitem.transition_trigger, wf_workitem.workitem_status, wf_workitem.enabled_date, wf_workitem.cancelled_date, wf_workitem.finished_date, wf_workitem.deadline, wf_workitem.context';
            $this->sql_select .= ', wf_workflow.workflow_name, wf_case.case_status';
            $this->sql_select .= ", COALESCE(mnu_task_alt.task_desc, mnu_task.task_desc) AS task_desc";
            $this->sql_from    = 'wf_workitem '
                               . 'LEFT JOIN wf_workflow ON (wf_workflow.workflow_id=wf_workitem.workflow_id) '
                               . 'LEFT JOIN wf_case     ON (wf_case.case_id=wf_workitem.case_id) '
                               . "LEFT JOIN {$menuDB}mnu_task     ON (mnu_task.task_id    =wf_workitem.task_id) "
                               . "LEFT JOIN {$menuDB}mnu_task_alt ON (mnu_task_alt.task_id=wf_workitem.task_id AND mnu_task_alt.language_id='{$_SESSION['user_language']}')";
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
