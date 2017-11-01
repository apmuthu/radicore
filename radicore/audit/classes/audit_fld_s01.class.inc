<?php
// *****************************************************************************
// Copyright 1999-2016 by Geoprise Technologies Licensing, All Rights Reserved.
// *****************************************************************************
require_once 'audit_fld.class.inc';
class audit_fld_s01 extends audit_fld
{

    // ****************************************************************************
    // this class is for use by various custom scripts
    // ****************************************************************************

    // *****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // custom code goes here

        return $fieldarray;

    } // _cm_changeConfig

    //*********************************************************************
    function _cm_getForeignData ($rowdata, $rownum=null)
    {
        // custom code goes here

        return $rowdata;

    } // _cm_getForeignData

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $parent_data=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $parent_data may contain contents of current record in the parent object.
    {
        if (empty($this->sql_from)) {
            $this->sql_select  = "fld.session_id, fld.tran_seq_no, fld.table_seq_no, CAST(fld.new_value AS integer) AS viewnumber, ssn.user_id";
            $this->sql_select .= ", (SELECT new_value FROM audit_fld AS x WHERE x.session_id = fld.session_id AND x.tran_seq_no = fld.tran_seq_no AND x.table_seq_no = fld.table_seq_no AND x.field_id='revised_date') AS timestamp";
            $this->sql_from    = "audit_fld AS fld"
                               ." LEFT JOIN audit_tbl AS tbl ON (tbl.session_id = fld.session_id AND tbl.tran_seq_no = fld.tran_seq_no AND tbl.table_seq_no = fld.table_seq_no) "
                               ." LEFT JOIN audit_ssn AS ssn ON (ssn.session_id = fld.session_id) ";
        } // if

        // obtain details from parent object
        $parentOBJ  =& $this->parent_object;
        $base_name  = $parentOBJ->dbname_server;
        $table_name = $parentOBJ->tablename;

        $where = "base_name='$base_name' AND table_name='$table_name' AND field_id='viewcount'"
               . " AND pkey='"
               . str_replace("'", "\'", $where)
               . "'";

        // do not bother with primary key check
        $this->checkPrimaryKey = FALSE;

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
