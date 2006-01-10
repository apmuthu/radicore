<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_role.class.inc';
class mnu_role_s01 extends mnu_role
{
    // ****************************************************************************
    // this class is for use by script: mnu_role_taskitem_multi(a).php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        //DebugBreak();
        // look for a particular substring in $this->sql_from
        $pos = strpos($this->sql_from, 'LEFT JOIN mnu_role_task');
        if ($pos !== false) {
            // remove old string
            $this->sql_from = substr($this->sql_from, 0, $pos-1);
        } // if

        // insert substring with current task_id
        $task_id = $where_array['task_id'];

        // include only those roles which are authorised to access this task
        $this->sql_from .= ' LEFT JOIN mnu_role_task '
                         . 'ON (mnu_role_task.role_id=mnu_role.role_id '
                         . "AND mnu_role_task.task_id='$task_id') ";

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
