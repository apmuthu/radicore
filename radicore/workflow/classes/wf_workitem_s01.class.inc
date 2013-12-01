<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'wf_workitem.class.inc';
class wf_workitem_s01 extends wf_workitem
{
    // ****************************************************************************
    // this subtype is for use in: workitem.list(expired).php
    //                        and: workitem.upd(expired).php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if ($GLOBALS['mode'] == 'update') {
        	$this->fieldspec['context']['noedit'] = 'y';
        	$this->fieldspec['role_id']['noedit'] = 'y';
        	$this->fieldspec['user_id']['noedit'] = 'y';
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_post_getData ($rows, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        if ($GLOBALS['mode'] == 'update') {
            // "Press SUBMIT to fire this workitem"
        	$this->messages[] = getLanguageText('e0069');
        } // if

        return $rows;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        //$dbprefix = $this->dbprefix;

        // find out if tables in the 'menu' database need to be qualified
        $menuDB = $this->_qualify_dbname($this->dbname, 'menu');

        if ($GLOBALS['mode'] == 'list') {
        	$now = getTimeStamp();
            $where = "workitem_status='EN' AND deadline <= '$now'";
        } // if

        // only do this if sql_select is empty
        if (empty($this->sql_select)) {
            // include columns from foreign table
            $this->sql_select = 'user_id, role_id, wf_workitem.workflow_id, case_id, workitem_id, transition_id, wf_workitem.task_id, transition_trigger, workitem_status, enabled_date, cancelled_date, finished_date, deadline, context, workflow_name, task_desc';
            $this->sql_from   = 'wf_workitem '
                              . 'LEFT JOIN wf_workflow ON (wf_workflow.workflow_id=wf_workitem.workflow_id) '
                              . 'LEFT JOIN '.$menuDB.'mnu_task ON (mnu_task.task_id=wf_workitem.task_id) ';
                              //. 'LEFT JOIN "' .$dbprefix .'menu".mnu_task ON (mnu_task.task_id=wf_workitem.task_id) ';
        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_updateRecord ($rowdata)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        //$this->row_locks = 'SH';    // shared
        //$this->row_locks = 'EX';    // exclusive
        //$this->row_locks_supp = '?' // DBMS-specific

        $dbobject =& RDCsingleton::getInstance('workflow_engine');
        $result = $dbobject->fireTimedEvent($rowdata);
        if ($dbobject->errors) {
        	$this->errors = array_merge($this->errors, $dbobject->errors);
        } else {
            $rowdata = array();  // there is nothing to update
        } // if

        return $rowdata;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
