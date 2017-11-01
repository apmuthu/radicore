<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'dict_related_column.class.inc';
class dict_related_column_snr extends dict_related_column
{

    // ****************************************************************************
    // this subclass is used in: dict_related_column(multi4)b.php
    // ****************************************************************************

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        $this->fieldspec['parent_field'] = array('type' => 'string', 'nondb' => 'y');

        unset($this->fieldspec['column_id_jnr']['noedit']);
        $this->fieldspec['column_id_jnr']['control']    = 'dropdown';
        $this->fieldspec['column_id_jnr']['optionlist'] = 'column_id';

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_getPkeyNames ($pkey_array, $task_id, $pattern_id)
    // return the list of primary key fields in this table before the selection string
    // is constructed and passed to another form.
    // $pkey_array contains the current list of primary key fields.
    // $task_id identifies the task to which the primary key(s) will be passed.
    // $pattern_id identifies the task's pattern.
    {
        $pkey_array[] = 'parent_field';       // append to array
        //$pkey_array = array('whatever');  // replace array

        return $pkey_array;

    } // _cm_getPkeyNames

    // ****************************************************************************
    function _cm_pre_updateMultiple ($fieldarray)
    // perform custom processing before multiple database records are updated.
    {
        // change field to REQUIRED (NOT NULL)
        $this->fieldspec['column_id_jnr']['required'] = 'y';

        return $fieldarray;

    } // _cm_pre_updateMultiple

    // ****************************************************************************
    function _cm_pre_updateRecord ($rowdata)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        //$this->row_locks = 'SH';    // shared
        //$this->row_locks = 'EX';    // exclusive

        // verify that SEQ_IN_INDEX holds correct value
        $dbobject = RDCsingleton::getInstance('dict_table_key');
        $db_id  = $rowdata['database_id_snr'];
        $tbl_id = $rowdata['table_id_snr'];
        $key_id = 'PRIMARY';
        $col_id = $rowdata['column_id_snr'];
        $dbobject->sql_select = 'seq_in_index';
        $data = $dbobject->getData_raw("database_id='$db_id' AND table_id='$tbl_id' AND key_name='$key_id' AND column_id='$col_id'");
        if (!empty($data)) {
        	$rowdata['seq_in_index'] = $data[0]['seq_in_index'];
        } // if

        return $rowdata;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
