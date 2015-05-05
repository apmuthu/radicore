<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_task.class.inc';
class mnu_task_s04 extends mnu_task
{
    // ****************************************************************************
    // this class is for use by script: mnu_task(popup1).php
    // ****************************************************************************

    var $global_access = false;     // TRUE = can access all tasks in the database
    var $role_list;                 // list of user roles

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    // NOTE: $selection is passed by reference as it may be amended.
    // NOTE: $search    is only available for OUTPUT tasks.
    {
        $pattern_id = getPatternId();

        if (preg_match('/^popup/i', $pattern_id)) {
            // obtain the user's current security setting
            $dbrole =& RDCsingleton::getInstance('mnu_role');
            $dbrole_data = $dbrole->getRole();
            if ($dbrole->errors) {
                $this->errors = $dbrole->errors;
                return FALSE;
            } // if

            $this->global_access = $dbrole_data['global_access'];
            $this->role_list     = $dbrole_data['role_list'];
        } // if

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        $pattern_id = getPatternId();

        $where_array = where2array($where, null, false);  // do not lose '!=' operator

        if (preg_match('/^popup/i', $pattern_id)) {
            if ($this->global_access) {
                // if global_access is ON then all tasks can be accessed without restriction
                // (unless a task has been disabled)
                $this->sql_select = 'mnu_task.*';
                $this->sql_from   = 'mnu_task';
                $where_array[]    = "mnu_task.is_disabled='N'";
            } else {
                // if global_access is OFF then a task is not accessible unless it has an
                // entry on MNU_ROLE_TASK for the current role
                // (or if it has been disabled)
                $role_list = $this->role_list;
                $this->sql_select = 'mnu_task.*';
                $this->sql_from   = 'mnu_task'
                                  .' LEFT JOIN mnu_role_task ON (mnu_role_task.task_id=mnu_task.task_id)';
                $where_array[] = "mnu_task.is_disabled='N'";
                $where_arrau[] = "mnu_role_task.role_id IN($role_list)";
            } // if
            $where = array2where($where_array);
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
