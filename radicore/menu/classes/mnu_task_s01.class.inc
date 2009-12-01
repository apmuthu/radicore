<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2009 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_task.class.inc';
class mnu_task_s01 extends mnu_task
{
    // ****************************************************************************
    // this class is for use by script: mnu_role_taskfield_multi(b).php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // remove role_id from the $where clause (otherwise there will be trouble)
        if (isset($where_array['role_id'])) {
        	unset($where_array['role_id']);
            $where = array2where($where_array);
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
