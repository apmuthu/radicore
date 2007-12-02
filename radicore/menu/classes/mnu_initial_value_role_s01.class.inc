<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_initial_value_role.class.inc';
class mnu_initial_value_role_s01 extends mnu_initial_value_role
{
    // ****************************************************************************
    // this subtype is for: mnu_initial_value_role(multi3)a
    //                 and: mnu_initial_value_role(multi3)b
    // ****************************************************************************

    // ****************************************************************************
    function _cm_getOrderBy ($orderby)
    // Adjust name of orderby item before it is used in an sql SELECT statement.
    {
        $orderby = str_replace('mnu_initial_value_role.field_id', 'mnu_task_field.field_id', $orderby);

        return $orderby;

    } // _cm_getOrderBy

    // ****************************************************************************
    function _cm_getOrderBy_Out ($orderby)
    // Adjust name of orderby item before it is added to XML output.
    {
        // customisable code goes here

        return $orderby;

    } // _cm_getOrderBy_Out

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        $this->sql_select = 'mnu_task_field.task_id, mnu_task_field.field_id, mnu_role.role_id, '
                           ."CASE WHEN mnu_initial_value_role.initial_value IS NULL THEN '' ELSE mnu_initial_value_role.initial_value END AS initial_value";
        $this->sql_from   = 'mnu_task_field '
                           .'CROSS JOIN mnu_role '
                           .'LEFT JOIN mnu_initial_value_role ON (mnu_initial_value_role.task_id=mnu_task_field.task_id AND mnu_initial_value_role.field_id=mnu_task_field.field_id AND mnu_initial_value_role.role_id=mnu_role.role_id)';

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
        if (empty($rowdata['initial_value'])) {
        	// this record is redundant, so remove it
            $where = array2where($rowdata, $this->getPkeyNames());

            $query = "SELECT count(*) FROM $this->tablename WHERE $where";
            $count = $this->getCount($query);

            if ($count > 0) {
                // record does currently exist, so delete it
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