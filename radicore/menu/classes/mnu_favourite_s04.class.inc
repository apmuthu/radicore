<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_favourite.class.inc';
class mnu_favourite_s04 extends mnu_favourite
{
    // ****************************************************************************
    // this subtype is used by the menu/home page
    // it will extract a user's favourites as buttons
    // ****************************************************************************

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        if (empty($this->sql_select)) {
            // first we must obtain the user's current security setting
            $dbrole =& RDCsingleton::getInstance('mnu_role');
            $dbrole_data = $dbrole->getRole();
            if ($dbrole->errors) {
                $this->errors = $dbrole->errors;
                return FALSE;
            } // if

            $role_id       = $dbrole_data['role_id'];
            $role_list     = $dbrole_data['role_list'];
            $global_access = $dbrole_data['global_access'];

            // change config
            $this->fieldspec['task_id']   = array('type' => 'string', 'size' => 80);
            $this->fieldspec['task_desc'] = array('type' => 'string', 'size' => 80);

            if (is_True($global_access)) {
                // global_access is ON so all buttons can be accessed without restriction
                // (unless a task has been disabled)
                $this->sql_select = 'mnu_task.task_id, mnu_favourite.task_desc, mnu_task.is_disabled, mnu_task.task_desc AS tooltip';
                $this->sql_from   = "mnu_favourite"
                                  ." LEFT JOIN mnu_task ON (mnu_task.task_id=mnu_favourite.task_id)";
                $where_array['mnu_task.is_disabled'] = 'N';
            } else {
                // global_access is OFF so task must have an entry on MNU_ROLE_TASK
                // (unless a task has been disabled)
                $this->sql_select = 'mnu_task.task_id, mnu_favourite.task_desc, mnu_task.is_disabled'
                                  .", CASE WHEN EXISTS(SELECT 1 FROM mnu_role_task WHERE task_id=mnu_favourite.task_id AND role_id IN($role_list) ) THEN 'Y' ELSE 'N' END AS access_allowed";
                $this->sql_from   = "mnu_favourite"
                                  ." LEFT JOIN mnu_task ON (mnu_task.task_id=mnu_favourite.task_id)";
                $where_array['mnu_task.is_disabled'] = 'N';
                $this->sql_having = "access_allowed='Y'";
            } // if

            $where = array2where($where_array);

            $this->sql_select .= ', mnu_favourite.user_id, mnu_favourite.sort_seq';  // required by postgres

        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
