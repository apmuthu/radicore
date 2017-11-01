<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class dict_table_key extends Default_Table
{
    // member variables
    var $delete_array = array();    // items to be deleted
    var $update_array = array();    // items to be updated

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function __construct ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->tablename   = 'dict_table_key';
        $this->dbname      = 'dict';

        $this->fieldspec = $this->getFieldSpec_original();

    } // __construct

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if ($GLOBALS['mode'] != 'search') {
			// do not replace database id with textual description
		    unset($this->fieldspec['database_id']['control']);
		} // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
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
                break;
            case 'update':
                $lock_array[] = $this->tablename;
                break;
            case 'delete':
                $lock_array[] = $this->tablename;
				$lock_array[] = 'dict_related_column';
                break;
            default:
                $lock_array = array();
        } // switch

        return $lock_array;

    } // _cm_getDatabaseLock

    // ****************************************************************************
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if (!array_key_exists('database_id', $this->lookup_data)) {
            // get contents of foreign table DATABASE and add as a LOOKUP list
            $dbobject = RDCsingleton::getInstance('dict_database');
            $array    = $dbobject->getValRep('database_id');
            $this->lookup_data['database_id'] = $array;
        } // if

        $pattern_id = getPatternId();

//        if (preg_match('/^(list1)$/i', $pattern_id)
//        OR (preg_match('/^(list2)$/i', $pattern_id) AND $this->zone == 'inner')) {
//        	if (!array_key_exists('quicksearch_field', $this->lookup_data)) {
//                // set list of field names for QuickSearch option
//                $array = array('database_id' => 'Database Id',
//                               'table_id' => 'Table Id',
//                               'key_name' => 'Key Name',
//                               'column_id' => 'Column Id');
//                $this->lookup_data['quicksearch_field'] = $array;
//            } // if
//        } // if

		return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getInitialDataMultiple ($fieldarray)
    // Perform custom processing prior to insertMultiple.
    // $fieldarray contains data from the initial $where clause.
    {
        // extract database and table names
        if (is_string(key($fieldarray))) {
            $dbname    =& $fieldarray['database_id'];
            $tablename =& $fieldarray['table_id'];
        } else {
            $dbname    =& $fieldarray[0]['database_id'];
            $tablename =& $fieldarray[0]['table_id'];
        } // if

        if (empty($dbname) OR empty($tablename)) {
            // 'Database and/or Table id is missing - please check selection'
            $this->errors[] = getLanguageText('e0019');
            return $fieldarray;
        } // if

        // get any existing dictionary data for this table
        $this->sql_orderby = 'key_name, seq_in_index';
        $old_data  = $this->getData("database_id='$dbname' AND table_id='$tablename'");

        // construct a smaller array of key and column names
        $old_data_cols = array();
        foreach ($old_data as $row => $rowdata) {
            if (preg_match('/^(primary)$/i', $rowdata['key_name'])) {
                $rowdata['key_name'] = strtoupper($rowdata['key_name']);
            } else {
                $rowdata['key_name'] = strtolower($rowdata['key_name']);
            } // if
            $old_data[$row] = $rowdata;
            $old_data_cols[$rowdata['key_name']][$rowdata['column_id']] = $row;
        } // foreach

        // obtain a list of current column definitions from the database engine
        $fieldarray = array();

        $db_data = $this->_ddl_showTableKeys($dbname, $tablename);

        // construct a smaller array of column names
        $db_data_cols = array();
        foreach ($db_data as $row => $rowdata) {
            if (preg_match('/^(primary)$/i', $rowdata['key_name'])) {
                $rowdata['key_name'] = strtoupper($rowdata['key_name']);
            } else {
                $rowdata['key_name'] = strtolower($rowdata['key_name']);
            } // if
            $db_data[$row] = $rowdata;
            $db_data_cols[$rowdata['key_name']][$rowdata['column_id']] = $row;
        } // foreach

        // construct array of static (common) data
        $static['database_id'] = $dbname;
        $static['table_id']    = $tablename;

        // compare contents of dictionary and the physical database
        $this->delete_array = array();
        $this->update_array = array();
        foreach ($old_data_cols as $key_name => $key_data) {
            //$key_name = strtolower($key_name);
        	foreach ($key_data as $columnid => $old_row) {
                if (array_key_exists($key_name, $db_data_cols)) {
                    if (array_key_exists($columnid, $db_data_cols[$key_name])) {
                        // entry to be updated
                        $db_row = $db_data_cols[$key_name][$columnid];
                        $update = array_merge($old_data[$old_row], $db_data[$db_row]);
                        $seq = $db_data_cols[$key_name][$columnid];
                        $update['column_seq']  = $seq;
                        // copy to member variable for processing in a subsequent method
                        $this->update_array[$old_row] = $update;
                        unset($db_data[$db_row]);
                        unset($db_data_cols[$key_name][$columnid]);
                    } else {
                        // entry to be deleted
                        $this->delete_array[$old_row] = $old_data[$old_row];
                        unset($old_data[$old_row]);
                    } // if
                } else {
                    // entry to be deleted
                    $this->delete_array[$old_row] = $old_data[$old_row];
                    unset($old_data[$old_row]);
                } // if
        	} // foreach
        } // foreach

        // anything left in $db_data array is to be inserted
        foreach ($db_data as $row => $columndata) {
        	// insert details of new key
            $seq = $row;
            $fieldarray[$seq]['column_seq']  = $seq;
            $fieldarray[$seq] = array_merge($fieldarray[$seq], $static, $columndata);
        } // foreach

        return $fieldarray;

    } // _cm_getInitialDataMultiple

    // ****************************************************************************
    function _cm_post_deleteRecord ($fieldarray)
    // perform custom processing after database record is deleted.
    {
        //DebugBreak();
        if ($fieldarray['key_name'] != 'PRIMARY') {
            return $fieldarray;
        } // if

        static $relobj;
        if (!is_object($relobj)) {
            //require_once 'classes/dict_related_column.class.inc';
            $relobj = RDCsingleton::getInstance('dict_related_column');
        } // if

        // if there are any relationships linked to this deleted column then they must also be deleted.
        $database_id = $fieldarray['database_id'];
        $table_id    = $fieldarray['table_id'];
        $column_id   = $fieldarray['column_id'];
        $array = $relobj->getData("database_id_snr='$database_id' AND table_id_snr='$table_id' AND column_id_snr='$column_id'");
        if (!empty($array)) {
            $array = $relobj->deleteMultiple($array);
            $errors = $relobj->getErrors();
            foreach ($errors as $row => $rowdata) {
                foreach ($rowdata as $field => $msg) {
                    $this->errors[] = 'Seq: ' .$row .', ' .$field .': ' .$msg;
                } // foreach
            } // foreach
            $this->messages = array_merge($this->messages, $relobj->getMessages());
        } // if

        return $fieldarray;

    } // _cm_post_deleteRecord

    // ****************************************************************************
    function _cm_post_insertMultiple ($fieldarray)
    // perform custom processing after multiple database records are inserted.
    {
        //DebugBreak();
        $errors = array();

        foreach ($this->errors as $row => $rowdata) {
            foreach ($rowdata as $field => $msg) {
                $errors[] = 'Seq: ' .$row .', ' .$field .': ' .$msg;
            } // foreach
        } // foreach

        // process any records marked for delete
        if (!empty($this->delete_array)) {
            $array = $this->deleteMultiple($this->delete_array);
            foreach ($this->errors as $row => $rowdata) {
                foreach ($rowdata as $field => $msg) {
                    $errors[] = 'Seq: ' .$row .', ' .$field .': ' .$msg;
                } // foreach
            } // foreach
        } // if

        // process any records marked for update
        if (!empty($this->update_array)) {
            $array = $this->updateMultiple($this->update_array);
            foreach ($this->errors as $row => $rowdata) {
                foreach ($rowdata as $field => $msg) {
                    if (is_array($msg)) {
                    	foreach ($msg as $field1 => $msg1) {
                    		$errors[] = 'Seq: ' .$row .', ' .$field1 .': ' .$msg1;
                    	} // foreach
                    } else {
                        $errors[] = 'Seq: ' .$row .', ' .$field .': ' .$msg;
                    } // if
                } // foreach
            } // foreach
        } // if

        $this->errors = $errors;

        return $fieldarray;

    } // _cm_post_insertMultiple

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        //DebugBreak();
        if ($fieldarray['key_name'] != 'PRIMARY') {
            return $fieldarray;
        } // if

        //require_once 'classes/dict_relationship.class.inc';
        $relobj = RDCsingleton::getInstance('dict_relationship');

        //require_once 'classes/dict_related_column.class.inc';
        $relcolobj = RDCsingleton::getInstance('dict_related_column');

        // if there are any relationships linked to this table then this new column must be added.
        $database_id = $fieldarray['database_id'];
        $table_id    = $fieldarray['table_id'];
        $column_id   = $fieldarray['column_id'];
        // lookup on DICT_RELATIONSHIP
        $array = $relobj->getData("database_id_snr='$database_id' AND table_id_snr='$table_id'");
        if (!empty($array)) {
            foreach ($array as $row => $data) {
                $insert_array[$row]['database_id_snr'] = $database_id;
                $insert_array[$row]['table_id_snr']    = $table_id;
                $insert_array[$row]['column_id_snr']   = $column_id;
                $insert_array[$row]['database_id_jnr'] = $data['database_id_jnr'];
                $insert_array[$row]['table_id_jnr']    = $data['table_id_jnr'];
                $insert_array[$row]['seq_no']          = $data['seq_no'];
            	$insert_array[$row]['seq_in_index']    = $fieldarray['seq_in_index'];
            } // foreach
            // add details to DICT_RELATED_COLUMN
            $insert_array = $relcolobj->insertMultiple($insert_array);
            $errors = $relcolobj->getErrors();
            foreach ($errors as $row => $rowdata) {
                foreach ($rowdata as $field => $msg) {
                    $this->errors[] = 'Seq: ' .$row .', ' .$field .': ' .$msg;
                } // foreach
            } // foreach
            $this->messages = array_merge($this->messages, $relobj->getMessages());
        } // if

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after a database record is updated.
    {
        //DebugBreak();
        if ($fieldarray['key_name'] != 'PRIMARY') {
            return $fieldarray;
        } // if

        //require_once 'classes/dict_related_column.class.inc';
        $relobj = RDCsingleton::getInstance('dict_related_column');

        // if there are any relationships linked to this updated column then they must also be updated.
        $database_id = $fieldarray['database_id'];
        $table_id    = $fieldarray['table_id'];
        $column_id   = $fieldarray['column_id'];
        $array = $relobj->getData("database_id_snr='$database_id' AND table_id_snr='$table_id' AND column_id_snr='$column_id'");
        if (!empty($array)) {
            foreach ($array as $row => $data) {
            	$array[$row]['seq_in_index'] = $fieldarray['seq_in_index'];
            } // foreach
            $array = $relobj->updateMultiple($array);
            $this->errors   = array_merge($this->errors, $relobj->getErrors());
            $this->messages = array_merge($this->messages, $relobj->getMessages());
        } // if

        return $fieldarray;

    } // _cm_post_updateRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
