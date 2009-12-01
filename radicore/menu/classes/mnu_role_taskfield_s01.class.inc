<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2009 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_role_taskfield.class.inc';
class mnu_role_taskfield_s01 extends mnu_role_taskfield
{

    // ****************************************************************************
    // this subtype is for: mnu_role_taskfield(multi)a
    //                 and: mnu_role_taskfield(multi)b
    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        $this->sql_select = 'mnu_task_field.task_id, mnu_task_field.field_id, mnu_role.role_id, mnu_task_field.field_desc'
                           .", CASE WHEN mnu_role_taskfield.access_type IS NULL THEN 'FULL' ELSE mnu_role_taskfield.access_type END AS access_type";
        $this->sql_from   = 'mnu_task_field '
                           .'CROSS JOIN mnu_role '
                           .'LEFT JOIN mnu_role_taskfield ON (mnu_role_taskfield.task_id=mnu_task_field.task_id AND mnu_role_taskfield.field_id=mnu_task_field.field_id AND mnu_role_taskfield.role_id=mnu_role.role_id)';

        $where_array['mnu_task_field.task_id'] = $where_array['task_id'];
        unset($where_array['task_id']);
        $where_array['mnu_role.role_id']       = $where_array['role_id'];
        unset($where_array['role_id']);
        $where = array2where($where_array);

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_post_updateRecord ($rowdata, $old_data)
    // perform custom processing after database record is updated.
    {
        if ($rowdata['access_type'] == 'FULL') {
        	// this record is redundant, so remove it
            $where = array2where($rowdata, $this->getPkeyNames());

            $query = "SELECT count(*) FROM $this->tablename WHERE $where";
            $count = $this->getCount($query);

            if ($count > 0) {
                // record does not currently exist, so insert it
                $rowdata = $this->deleteRecord($rowdata);
                if (!empty($this->errors)) return $rowdata;
            } // if
        } // if

        return $rowdata;

    } // _cm_post_updateRecord

// ****************************************************************************
    function _cm_pre_updateRecord ($fieldarray)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        // if record does not currently exist then insert it otherwise the update will fail

        $where = array2where($fieldarray, $this->getPkeyNames());

        $query = "SELECT count(*) FROM $this->tablename WHERE $where";
        $count = $this->getCount($query);

        if ($count == 0) {
            // record does not currently exist, so insert it
            $fieldarray = $this->insertRecord($fieldarray);
            if (!empty($this->errors)) return $fieldarray;
        } // if

        return $fieldarray;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
