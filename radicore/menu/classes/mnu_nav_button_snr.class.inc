<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_nav_button.class.inc';
class mnu_nav_button_snr extends mnu_nav_button
{

    // ****************************************************************************
    // this subclass is used by: mnu_nav_button(list2).php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        if (empty($fieldarray['task_id_snr']) AND !empty($fieldarray['task_id'])) {
            $fieldarray['task_id_snr'] = $fieldarray['task_id'];
            unset($fieldarray['task_id']);
        } // if

        $fieldarray = parent::_cm_getInitialData($fieldarray);

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // look for entries where the specified task is JUNIOR
        $where = str_replace('task_id=', 'task_id_jnr=', $where);

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
