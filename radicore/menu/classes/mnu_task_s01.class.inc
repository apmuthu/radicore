<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_task.class.inc';
class mnu_task_s01 extends mnu_task
{
    // ****************************************************************************
    // this class is for use by script: mnu_role_taskfield_multi(b).php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // (WHERE is supplied in two formats - string and array)
    // perform custom processing before database record(s) are retrieved.
    {
        //DebugBreak();
        // look for a particular substring in $this->sql_from
        $pos = strpos($this->sql_from, 'JOIN mnu_role_task');
        if ($pos !== false) {
            // remove old string
            $this->sql_from = substr($this->sql_from, 0, $pos-1);
        } // if

        // insert substring with current $role_id
        $role_id = $where_array['role_id'];

        // include only those tasks which can be accessed by this role
        $this->sql_from .= ' JOIN mnu_role_task '
                         . 'ON (mnu_role_task.task_id=mnu_task_field.task_id '
                         . "AND mnu_role_task.role_id='$role_id') ";

        // remove role_id from the $where clause (otherwise there will be trouble)
        $where = null;

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
