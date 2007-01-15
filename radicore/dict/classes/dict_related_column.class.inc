<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class dict_related_column extends Default_Table
{
    // member variables

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function dict_related_column ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'dict_related_column';
        $this->dbname      = 'dict';

        $this->fieldspec = $this->getFieldSpec_original();

    } // dict_related_column

    // ****************************************************************************
    function _cm_getDatabaseLock ()
    // return array of database tables to be locked in current transaction.
    {
        $GLOBALS['lock_tables'] = FALSE;    // TRUE/FALSE
        $GLOBALS['lock_rows']   = FALSE;    // FALSE, SR (share), EX (exclusive)

        // the format of each $lock_array entry is one of the following:
        // $lock_array[] = 'tablename'         (within current database)
        // $lock_array[] = 'dbname.tablename'  (within another database)
        // $lock_array['READ'][] = '...'       (for a READ lock)
        switch ($GLOBALS['mode']){
            case 'insert':
                $lock_array[] = $this->tablename;
                $lock_array[] = 'dict_related_column';
                break;
            case 'update':
                $lock_array[] = $this->tablename;
                $lock_array[] = 'dict_related_column';
                break;
            case 'delete':
                $lock_array[] = $this->tablename;
                break;
            default:
                $lock_array = array();
        } // switch

        return $lock_array;

    } // _cm_getDatabaseLock

    // ****************************************************************************
    function _cm_getInitialDataMultiple ($fieldarray)
    // Perform custom processing prior to insertMultiple.
    // $fieldarray contains data from the initial $where clause.
    {
        $database_id = $fieldarray['database_id_snr'];
        $table_id    = $fieldarray['table_id_snr'];

        // obtain names of primary key columns from parent table
        require_once 'classes/dict_table_key.class.inc';
        $keyobj =& singleton::getInstance('dict_table_key');
        $where = "database_id='$database_id' AND table_id='$table_id' AND key_name='PRIMARY'";
        $keyobj->setOrderBy('seq_in_index');
        $inarray = $keyobj->getData($where);

        if (empty($inarray)) {
        	$outarray[] = $fieldarray;
        } else {
            foreach ($inarray as $row => $rowdata) {
                $outarray[$row] = $fieldarray;
            	$outarray[$row]['column_id_snr'] = $rowdata['column_id'];
                $outarray[$row]['seq_in_index']  = $rowdata['seq_in_index'];
            } // foreach
        } // if

        $fieldarray = $outarray;

        return $fieldarray;

    } // _cm_getInitialDataMultiple

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        //DebugBreak();
        if (!empty($rowdata)) {
            // get column names for junior (child) table
            require_once 'classes/dict_column.class.inc';
            $columnobj =& singleton::getInstance('dict_column');
            $where2 = "database_id='{$rowdata[0]['database_id_jnr']}'";
            $where2 .= " AND table_id='{$rowdata[0]['table_id_jnr']}'";
            $columnobj->setOrderBy('column_seq', 'asc');
            $data = $columnobj->getData($where2);
            // convert each row into 'id=id' in the output array
            $array[' '] = '';  // start with dummy entry
            foreach ($data as $row => $column) {
                $array[$column['column_id']] = $column['column_id'];
            } // foreach

            $this->lookup_data['column_id'] = $array;
        } // if

        return $rowdata;

    } // _cm_post_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
