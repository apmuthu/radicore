<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_initial_value_user.class.inc';
class mnu_initial_value_user_s01 extends mnu_initial_value_user
{
    // ****************************************************************************
    // this subtype is for: mnu_initial_value_user(multi3)a
    //                 and: mnu_initial_value_user(multi3)b
    // ****************************************************************************

    // ****************************************************************************
    function _cm_getOrderBy ($orderby)
    // Adjust name of orderby item before it is used in an sql SELECT statement.
    {
        $orderby = str_replace('mnu_initial_value_user.field_id', 'mnu_task_field.field_id', $orderby);

        return $orderby;

    } // _cm_getOrderBy

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        $this->sql_select = 'mnu_task_field.task_id, mnu_task_field.field_id, mnu_user.user_id, mnu_initial_value_user.is_noedit '
                           .", CASE WHEN mnu_initial_value_user.initial_value IS NULL THEN '' ELSE mnu_initial_value_user.initial_value END AS initial_value";
        $this->sql_from   = 'mnu_task_field '
                           .'CROSS JOIN mnu_user '
                           .'LEFT JOIN mnu_initial_value_user ON (mnu_initial_value_user.task_id=mnu_task_field.task_id AND mnu_initial_value_user.field_id=mnu_task_field.field_id AND mnu_initial_value_user.user_id=mnu_user.user_id)';

        if (!empty($where_array['task_id'])) {
            $where_array['mnu_task_field.task_id'] = $where_array['task_id'];
            unset($where_array['task_id']);
        } // if
        if (!empty($where_array['task_id'])) {
            $where_array['mnu_user.user_id']       = $where_array['user_id'];
            unset($where_array['user_id']);
        } // if
        $where = array2where($where_array);

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_post_updateRecord ($rowdata, $old_data)
    // perform custom processing after database record is updated.
    {
        if (empty($rowdata['initial_value'])) {
        	// this record is redundant, so remove it
            $where = array2where($rowdata, $this->getPkeyNames());

            if (!empty($where)) {
                $query = "SELECT count(*) FROM $this->tablename WHERE $where";
                $count = $this->getCount($query);

                if ($count > 0) {
                    // record does currently exist, so delete it
                    $rowdata = $this->deleteRecord($rowdata);
                    if (!empty($this->errors)) return $rowdata;
                } // if
            } // if
        } // if

        return $rowdata;

    } // _cm_post_updateRecord

// ****************************************************************************
    function _cm_pre_updateRecord ($fieldarray)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        $where = array2where($fieldarray, $this->getPkeyNames());

        $query = "SELECT count(*) FROM $this->tablename WHERE $where";
        $count = $this->getCount($query);

        if ($count == 0) {
            if (empty($fieldarray['initial_value'])) {
                // no need to insert an empty record
            	$fieldarray = array();
            } else {
                // record does not currently exist, so insert it otherwise the update will fail
                $fieldarray = $this->insertRecord($fieldarray);
                if (!empty($this->errors)) return $fieldarray;
            } // if
        } // if

        return $fieldarray;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
