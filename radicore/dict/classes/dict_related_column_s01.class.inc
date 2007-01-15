<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'dict_related_column.class.inc';
class dict_related_column_s01 extends dict_related_column
{

    // ****************************************************************************
    // this subclass is used to import existing column names for a selected table
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
        $object =& singleton::getInstance('dict_table_key');
        $db_id  = $rowdata['database_id_snr'];
        $tbl_id = $rowdata['table_id_snr'];
        $key_id = 'PRIMARY';
        $col_id = $rowdata['column_id_snr'];
        $dbobject->sql_select = 'seq_in_index';
        $data = $object->getData_raw("database_id='$db_id' AND table_id='$tbl_id' AND key_name='$key_id' AND column_id='$col_id'");
        if (!empty($data)) {
        	$rowdata['seq_in_index'] = $data[0]['seq_in_index'];
        } // if

        return $rowdata;

    } // _cm_pre_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
