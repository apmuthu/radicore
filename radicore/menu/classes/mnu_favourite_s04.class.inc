<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_favourite.class.inc';
class mnu_favourite_s04 extends mnu_favourite
{
    // ****************************************************************************
    // this subtype is used by the menu/home page
    // it will extract a user's favourites as buttons
    // ****************************************************************************

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        if (empty($this->sql_select)) {
            // change config
            $this->fieldspec['task_id']   = array('type' => 'string', 'size' => 80);
            $this->fieldspec['task_desc'] = array('type' => 'string', 'size' => 80);
            // task must not be disabled, and access must be allowed
            // (either global_access='Y' or a record exists on MNU_ROLE_TASK)
        	$this->sql_select = 'mnu_task.task_id, mnu_favourite.task_desc, mnu_task.is_disabled, mnu_role.global_access'
        	                 .", CASE WHEN is_disabled='Y' THEN 'N'"
        	                       ." WHEN global_access='Y' THEN 'Y'"
        	                       ." WHEN mnu_role_task.role_id IS NOT NULL THEN 'Y'"
        	                       ." ELSE 'N' END AS access_allowed";
        	$this->sql_from   = "mnu_favourite"
        	                  ." LEFT JOIN mnu_task ON (mnu_task.task_id=mnu_favourite.task_id)"
        	                  ." LEFT JOIN mnu_role ON (mnu_role.role_id='{$_SESSION['role_id']}')"
        	                  ." LEFT JOIN mnu_role_task ON (mnu_role_task.task_id=mnu_task.task_id AND mnu_role_task.role_id='{$_SESSION['role_id']}')";
        	$this->sql_having = "access_allowed='Y'";

        	$this->sql_select .= ', mnu_favourite.user_id, mnu_favourite.sort_seq';  // required by postgres
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
