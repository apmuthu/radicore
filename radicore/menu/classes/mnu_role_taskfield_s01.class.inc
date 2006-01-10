<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'mnu_role_taskfield.class.inc';
class mnu_role_taskfield_s01 extends mnu_role_taskfield
{

    // ****************************************************************************
    // this subtype is for: mnu_role_taskfield(multi)a
    //                 and: mnu_role_taskfield(multi)b
    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        // There may be zero or more records in $rowdata which now have
        // to be merged with the item list for the selected task.

        // First, get the contents of MNU_TASK_FIELD for this task_id
        require_once 'mnu_task_field.class.inc';
        $dbobject =& singleton::getInstance('mnu_task_field');
        $task_field_data = $dbobject->getData($where);
        if ($dbobject->errors) {
            $this->errors = $dbobject->errors;
            return FALSE;
        } // if

        //if ($dbobject->getNumrows() == 0) {
        //    $this->errors[] = 'There are no fields listed for this task';
        //} // if

        // convert the $where string into an associative array
        $where_array = where2array($where);

        if (!empty($rowdata)) {
            // examine each row retrieved from mnu_item_access ...
            foreach ($rowdata as $row) {
                // ... with each row retrieved from mnu_task_item
                foreach ($task_field_data as $field_row => $field_data) {
                    // if the field_id exists in $task_field_data then remove it
                    if ($row['field_id'] == $task_field_data[$field_row]['field_id']) {
                        unset($task_field_data[$field_row]);
                        break;
                    } // if
                } // foreach
            } // foreach
        } // if

        // what is left in $task_field_data does not exist in $rowdata,
        // so it must now be appended
        foreach ($task_field_data as $row) {
            $row['role_id']     = $where_array['role_id'];
            $row['access_type'] = 'FULL';   // set default value
            $rowdata[] = $row;
        } // foreach

        if (!empty($this->sql_orderby)) {
            $orderby = $this->sql_orderby;
            // check if this fieldname is qualified by tablename
            if ($substring = strrchr($orderby, '.')) {
                // now remove the tablename and put amended entry back into the array
                $orderby = ltrim($substring, '.');
            } // if
            // array now has to be sorted by column with this name
            foreach ($rowdata as $row) {
                // first, extract the column value to be sorted on
                $sortarray[] = $row[$orderby];
            } // foreach
            // now sort the rows by the value in the selected column
            if ($this->sql_orderby_seq == 'asc') {
                array_multisort($sortarray, SORT_ASC, $rowdata);
            } else {
                array_multisort($sortarray, SORT_DESC, $rowdata);
            } // if
        } // if

        // save the number of entries in the array
        $this->numrows  = count($rowdata);
        $this->pageno   = 1;
        $this->lastpage = 1;

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_pre_updateRecord ($fieldarray)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        // if record does not currently exist then insert it and
        // remove it from the update array

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
